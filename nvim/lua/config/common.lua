
-- Get the base directory of a given path
function BaseDir(path)
    return path:match("(.*[/\\])")
end

-- Receive a table and an element and return `true` if the element is inside the table
function Contains (tab, element)
  for _, value in ipairs(tab) do
    if value == element then
      return true
    end
  end

  return false
end

-- Remove elements from an array. The `fnKeep` should return true to keep the value, or false to discard it.
function ArrayRemove(t, fnKeep)
    local j, n = 1, #t;

    for i=1,n do
        if (fnKeep(t, i, j)) then
            -- Move i's kept value to j's position, if it's not already there.
            if (i ~= j) then
                t[j] = t[i];
                t[i] = nil;
            end
            j = j + 1; -- Increment position of where we'll place the next kept value.
        else
            t[i] = nil;
        end
    end

    return t;
end

