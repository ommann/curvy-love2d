local M = {}

--Keys and Values have to be strictly increasing/decreasing
--Requires same number of Keys and Values
M.Functable = function(keys, values)
  if #keys ~= #values then error("tables have different lengths", 3) end

  local output = {}

  output.keys = keys
  output.values = values

  output.execute = M._execute

  setmetatable(output, {__call = M._execute})

  return output
end

--Keys and Values have to be strictly increasing/decreasing
--Requires same number of Keys and Values
M.Curve = function(keys, values)
  local output = {}

  local ks, vs = {}, {}

  for i,v in ipairs(keys) do
    ks[i] = v
  end

  for i,v in ipairs(values) do
    vs[i] = v
  end

  output._normal = M.Functable(ks, vs)
  output._inverse = M.Functable(vs, ks)

  output.move = M._move

  setmetatable(output, {__call = M._move})

  return output
end

M._move = function(self, state, change)
  return self._normal:execute(self._inverse:execute(state) + change)
end

M._execute = function(self, key)
  local last = #self.keys

  if self.keys[1] < self.keys[2] then
    if key <= self.keys[1] then return self.values[1] end
    if key >= self.keys[last] then return self.values[last] end
  end

  if self.keys[1] > self.keys[2] then
    if key >= self.keys[1] then return self.values[1] end
    if key <= self.keys[last] then return self.values[last] end
  end

  for i = 1,last-1 do
    if key >= self.keys[i] and key <= self.keys[i+1]
    or key <= self.keys[i] and key >= self.keys[i+1] then
      return M._lerp( self.values[i], self.values[i+1], math.abs(key - self.keys[i]) / math.abs(self.keys[i+1] - self.keys[i]) )
    end
  end
end

M._lerp = function(a, b, amount)
  return (1 - amount) * a + amount * b
end

local call = function(self, keys, values) return M.Curve(keys, values) end
setmetatable(M, {__call = call})

return M
