function class(className,super)
    local cls = {}
    local superType = type(super)
    cls.__index = cls
    cls.__name = className
    
    if superType == "table" then
        setmetatable(cls,{__index=super})
    elseif  superType=="function" then
        cls.__create = super
    end
    
    function cls.new(...)
        local instance
        if cls.__create then
            instance = cls.__create(...)
        else
            instance = {}
        end
        setmetatable(instance, cls)
        if cls.ctor then
            instance:ctor(...)
        end
        return instance
    end
    
    return cls
end

local son = class("son")

son.c =2;
local instance = son.new()
instance.c =6;
print(son.c)
print(instance.c)