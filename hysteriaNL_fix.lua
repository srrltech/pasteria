local build_level = "hysteria";
VERSION = "4.2a";
PROJECT_NAME = build_level;
IS_DEBUG_MODE = not _IS_MARKET;
build_level = 1;
local username = common.get_username();
local timestamps = {
    common.get_timestamp()
};
local launch_options = {
    OFFLINE = string.find(_NAME, "%-w") ~= nil,
    NOFONTS = string.find(_NAME, "%-f") ~= nil
};
local print = print;
local require = require;
local print_raw = print_raw;
local print_error = print_error;
local Color = color;
local next = next;
local Vector = vector;
local type = type;
local ipairs = ipairs;
local setmetatable = setmetatable;
local rawget = rawget;
local rawset = rawset;
local unpack = unpack;
local tonumber = tonumber;
local tostring = tostring;
local error = error;
local pcall = pcall;
local print_dev = print_dev;
local function copy_table(src_table)
    -- upvalues: next (ref)
    local dest_table = {};
    for k, v in next, src_table do
        dest_table[k] = v;
    end;
    return dest_table;
end;
local table_utils = copy_table(table);
local math_utils = copy_table(math);
local string_utils = copy_table(string);
table_utils.new = require("table.new");
table_utils.clear = require("table.clear");
table_utils.has = function (t, val)
    for i = 1, #t do
        if t[i] == val then
            return true;
        end;
    end;
    return false;
end;
table_utils.find = function (t, val)
    for i = 1, #t do
        if t[i] == val then
            return i;
        end;
    end;
end;
table_utils.copy = function (t)
    -- upvalues: type (ref), next (ref), table_utils (ref)
    if type(t) ~= "table" then
        return t;
    else
        local result = {};
        for k, v in next, t do
            result[table_utils.copy(k)] = table_utils.copy(v);
        end;
        return result;
    end;
end;
table_utils.slide = function (t, val, max_size)
    -- upvalues: table_utils (ref)
    if #t == max_size then
        table_utils.remove(t, 1);
    end;
    t[#t + 1] = val;
end;
table_utils.place = function (t, path, val)
    -- upvalues: ipairs (ref), type (ref)
    local l_v49_0 = t;
    for i, k in ipairs(path) do
        if type(l_v49_0[k]) == "table" then
            l_v49_0 = l_v49_0[k];
        else
            l_v49_0[k] = i < #path and {} or val;
            l_v49_0 = l_v49_0[k];
        end;
    end;
    return t;
end;
table_utils.random = function (t)
    -- upvalues: math_utils (ref)
    local idx = math_utils.random(1, #t);
    return t[idx], idx;
end;
table_utils.filter = function (t)
    -- upvalues: table_utils (ref)
    local result = {};
    local i = 1;
    for k = 1, table_utils.maxn(t) do
        if t[k] ~= nil then
            local l_v59_0 = i;
            local v = t[k];
            i = i + 1;
            result[l_v59_0] = v;
        end;
    end;
    return result;
end;
table_utils.distribute = function (t, key, val_key)
    -- upvalues: ipairs (ref)
    local result = {};
    for k, v in ipairs(t) do
        result[val_key and v[val_key] or k] = key == nil and k or v[key];
    end;
    return result;
end;
local chars_from_bytes_or_rad_to_deg = 180 / math_utils.pi;
math_utils.deginrad = math_utils.pi / 180;
math_utils.radindeg = chars_from_bytes_or_rad_to_deg;
math_utils.sq3 = function (x, y, z)
    return x * x + y * y + (z and z * z or 0);
end;
math_utils.map = function (val, min1, max1, min2, max2, clamp)
    -- upvalues: math_utils (ref)
    if clamp then
        local clamped = math_utils.clamp(val, min1, max1);
        if clamped then
            val = clamped;
        end;
    end;
    return min2 + (val - min1) * (max2 - min2) / (max1 - min1);
end;
math_utils.lerp = function (a, b, t)
    return a + (b - a) * t;
end;
math_utils.dist = function (v1, v2, is_2d)
    -- upvalues: math_utils (ref)
    local dx = v2 and v2.x - v1.x or v1.x;
    local dy = v2 and v2.y - v1.y or v1.y;
    local dz = not is_2d and (v2 and v2.z - v1.z or v1.z) or nil;
    return math_utils.sqrt(dx * dx + dy * dy + (dz and dz * dz or 0));
end;
math_utils.distb = function (v1, v2, is_2d)
    -- upvalues: math_utils (ref)
    local dx = v2 and v2[1] - v1[1] or v1[1];
    local dy = v2 and v2[2] - v1[2] or v1[2];
    local dz = not is_2d and (v2 and v2[3] - v1[3] or v1[3]) or nil;
    return math_utils.sqrt(dx * dx + dy * dy + (dz and dz * dz or 0));
end;
math_utils.sqrt3 = function (x, y, z)
    -- upvalues: math_utils (ref)
    return math_utils.sqrt(x * x + y * y + (z and z * z or 0));
end;
math_utils.clamp = function (val, min_val, max_val)
    return val < min_val and min_val or max_val < val and max_val or val;
end;
math_utils.cycle = function (val, max_val)
    local rem = val % max_val;
    return rem == 0 and max_val or rem;
end;
math_utils.round = function (val)
    -- upvalues: math_utils (ref)
    return math_utils.floor(val + 0.5);
end;
math_utils.roundb = function (val, decimals)
    -- upvalues: math_utils (ref)
    local mult = 10 ^ (decimals or 0);
    return math_utils.floor(val * mult + 0.5) / mult;
end;
math_utils.medium = function (...)
    -- upvalues: ipairs (ref)
    local sum = 0;
    local count = 0;
    for k, v in ipairs({
        ...
    }) do
        local l_v110_0 = k;
        sum = sum + v;
        count = l_v110_0;
    end;
    return sum / count;
end;
math_utils.average = function (t)
    local sum = 0;
    local count = 0;
    for i = 1, #t do
        local l_v116_0 = i;
        sum = sum + t[i];
        count = l_v116_0;
    end;
    return sum / count;
end;
math_utils.tolerate = function (val, tolerance)
    if val < tolerance then
        return 0;
    elseif 1 - tolerance < val then
        return 1;
    else
        return val;
    end;
end;
math_utils.angle_to = function (src, dst)
    -- upvalues: Vector (ref), math_utils (ref)
    local dx = dst.x - src.x;
    local dy = dst.y - src.y;
    local dz = dst.z - src.z;
    return Vector(math_utils.atan2(-dz, math_utils.sqrt(dx * dx + dy * dy)) * math_utils.radindeg, math_utils.atan2(dy, dx) * math_utils.radindeg, 0);
end;
math_utils.angle_vec = function (pitch, yaw, roll)
    -- upvalues: math_utils (ref), Vector (ref)
    local cp = pitch * math_utils.deginrad;
    local sp = yaw * math_utils.deginrad;
    roll = roll * math_utils.deginrad;
    yaw = sp;
    pitch = cp;
    cp = math_utils.cos(pitch);
    sp = math_utils.sin(pitch);
    local cy = math_utils.cos(yaw);
    local sy = math_utils.sin(yaw);
    local cr = math_utils.cos(roll);
    local sr = math_utils.sin(roll);
    return Vector(cp * cy, cp * sy, -sp), Vector(-1 * sr * sp * cy + -1 * cr * -sy, -1 * sr * sp * sy + -1 * cr * cy, -1 * sr * cp);
end;
math_utils.extend_vec = function (dist, yaw, x, y, z)
    -- upvalues: math_utils (ref)
    local yaw_rad = yaw * math_utils.deginrad;
    return x + math_utils.cos(yaw_rad) * dist, y + math_utils.sin(yaw_rad) * dist, z;
end;
math_utils.angle_diff = function (a, b)
    return (a - b + 180) % 360 - 180;
end;
math_utils.extrapolate = function (pos, vel, ticks)
    return pos + vel * globals.tickinterval * ticks;
end;
math_utils.relative_yaw = function (a, b)
    -- upvalues: math_utils (ref)
    return math_utils.atan2(a.y - b.y, a.x - b.x) * math_utils.radindeg;
end;
math_utils.relative_pitch = function (a, b)
    -- upvalues: math_utils (ref)
    return math_utils.atan2(-(b.z - a.z), math_utils.sqrt((b.x - a.x) * (b.x - a.x) + (b.y - a.y) * (b.y - a.y))) * math_utils.radindeg;
end;
math_utils.normalize_yaw = function (yaw)
    return (yaw + 180) % -360 + 180;
end;
math_utils.normalize_pitch = function (pitch)
    return pitch < -89 and -89 or pitch > 89 and 89 or pitch;
end;
string_utils.clean = function (s)
    -- upvalues: string_utils (ref)
    return string_utils.gsub(string_utils.gsub(s, "^%s+", ""), "%s+$", "");
end;
string_utils.limit = function (s, limit, suffix)
    -- upvalues: string_utils (ref), table_utils (ref)
    local res = {};
    local count = 1;
    for c in string_utils.gmatch(s, ".[\128-\191]*") do
        local next_count = count + 1;
        res[count] = c;
        count = next_count;
        if limit < count then
            if suffix then
                res[count] = suffix == true and "..." or suffix;
                break;
            else
                break;
            end;
        end;
    end;
    return table_utils.concat(res);
end;
string_utils.insert = function (s, insert_str, pos)
    -- upvalues: string_utils (ref)
    return string_utils.sub(s, 1, pos) .. insert_str .. string_utils.sub(s, pos + 1);
end;
chars_from_bytes_or_rad_to_deg = function (...)
    -- upvalues: table_utils (ref), string_utils (ref)
    return table_utils.concat({
        string_utils.char(...)
    });
end;
local function _(s)
    -- upvalues: table_utils (ref), string_utils (ref)
    return table_utils.concat({
        string_utils.byte(s, 1, #s)
    }, ",");
end;
local function are_not_equal(a, b)
    return a ~= b;
end;
local pui = require(username == "enQ" and "pui" or "neverlose/pui");
local sec_base64 = require("neverlose/sec-base64");
local debug_log = IS_DEBUG_MODE and function (...)
    -- upvalues: print_raw (ref), print_dev (ref)
    print_raw(PROJECT_NAME, " \226\128\148 ", ...);
    print_dev(...);
end or function ()

end;
if not IS_DEBUG_MODE or not require("inspect") then
    local function _(...)
        return ...;
    end;
end;
local function iif(cond, a, b)
    if cond then
        return a;
    else
        return b;
    end;
end;
local function _(func, ...)
    -- upvalues: pcall (ref), unpack (ref)
    local res = {
        pcall(func, ...)
    };
    if res[1] then
        return unpack(res, 2);
    else
        return nil;
    end;
end;
if IS_DEBUG_MODE then
    setmetatable(_G, {
        __index = function (_, k)
            -- upvalues: debug_log (ref)
            debug_log("_G READ: ", k);
            return nil;
        end,
        __newindex = function (t, k, v)
            -- upvalues: debug_log (ref), rawset (ref)
            debug_log("_G SET: ", k);
            rawset(t, k, v);
        end
    });
end;
local menu_items = nil;
local colors = nil;
local events = nil;
local global_events_table = _G.events;
local events_any_proxy = global_events_table.any;
local db_manager = {
    set = events_any_proxy.set,
    unset = events_any_proxy.unset,
    call = events_any_proxy.call
};
local db_key = nil;
do
    local l_l_events_0_0, l_v188_0, l_v189_0 = global_events_table, db_manager, db_key;
    l_v189_0 = {
        set = function (self, cb)
            -- upvalues: type (ref)
            if type(cb) == "function" and self.proxy[cb] == nil then
                local idx = #self.callbacks + 1;
                local l_callbacks_0 = self.callbacks;
                local l_proxy_0 = self.proxy;
                local l_v194_0 = cb;
                l_proxy_0[cb] = idx;
                l_callbacks_0[idx] = l_v194_0;
            end;
        end,
        unset = function (self, cb)
            -- upvalues: table_utils (ref), next (ref)
            local idx = self.proxy[cb];
            if idx == nil then
                return;
            else
                table_utils.remove(self.callbacks, idx);
                self.proxy[cb] = nil;
                for k, v in next, self.proxy do
                    if idx < v then
                        self.proxy[k] = v - 1;
                    end;
                end;
                return;
            end;
        end,
        __call = function (self, cb, add)
            -- upvalues: l_v189_0 (ref)
            if add ~= false then
                l_v189_0.set(self, cb);
            else
                l_v189_0.unset(self, cb);
            end;
        end,
        call = function (self, ...)
            -- upvalues: l_v188_0 (ref)
            if self.name == "voice_message" then
                return l_v188_0.call(self[0], ...);
            else
                return self.mainfn(...);
            end;
        end,
        gcall = function (self, ...)
            -- upvalues: l_v188_0 (ref)
            l_v188_0.call(self[0], ...);
        end,
        unhook = function (self)
            -- upvalues: l_v188_0 (ref)
            l_v188_0.unset(self[0], self.mainfn);
        end
    };
    l_v189_0.__index = l_v189_0;
    events = setmetatable({}, {
        __index = function (self, name)
            -- upvalues: setmetatable (ref), l_l_events_0_0 (ref), l_v189_0 (ref), l_v188_0 (ref), rawset (ref)
            local event = setmetatable({
                [0] = l_l_events_0_0[name],
                name = name,
                proxy = {},
                callbacks = {}
            }, l_v189_0);
            event.mainfn = function (...)
                -- upvalues: event (ref)
                local res = nil;
                for i = 1, #event.callbacks do
                    if event.callbacks[i] then
                        local cb_res = event.callbacks[i](...);
                        if cb_res ~= nil then
                            res = cb_res;
                        end;
                    end;
                end;
                return res;
            end;
            l_v188_0.set(event[0], event.mainfn);
            rawset(self, name, event);
            return event;
        end
    });
end;
events_any_proxy = nil;
global_events_table = print;
db_manager = 0;
db_key = nil;
do
    local l_v188_1, l_v189_1 = db_manager, db_key;
    events.accent_settings_change:set(function (event_data)
        -- upvalues: l_v189_1 (ref)
        l_v189_1 = event_data.value[1];
    end);
    events_any_proxy = function (...)
        -- upvalues: colors (ref), l_v189_1 (ref), Color (ref), l_v188_1 (ref), type (ref), string_utils (ref), tostring (ref), print_raw (ref), unpack (ref)
        local l_hex_0 = colors.hex;
        local l_hex2_0 = colors.hex2;
        if l_v189_1 == "Rainbow" then
            local _, s, v = colors.accent:to_hsv();
            l_hex_0 = "\a" .. Color():as_hsv(l_v188_1 * 15 % 360 / 360, s, v, 1):to_hex();
            l_hex2_0 = l_hex_0;
        end;
        local replacements = {
            ["\r"] = "\aDEFAULT",
            ["\v"] = l_hex_0,
            ["\f"] = l_hex2_0
        };
        local args = {
            ...
        };
        for i = 1, #args do
            if type(args[i]) == "string" then
                args[i] = string_utils.gsub(args[i], "[\v\r\f]", replacements);
            else
                args[i] = tostring(args[i]);
            end;
        end;
        print_raw(unpack(args));
        l_v188_1 = l_v188_1 == 23 and 0 or l_v188_1 + 1;
    end;
    print = function (...)
        -- upvalues: events_any_proxy (ref)
        events_any_proxy("\vhysteria\r ", ...);
    end;
end;
db_key = PROJECT_NAME .. "::db";
local screen_size = 2;
db_manager = {
    key = db_key,
    version = screen_size
};
local screen_center = db[db_key];
if not screen_center then
    db[db_key] = {
        version = db_manager.version,
        configs = {},
        stats = {}
    };
    screen_center = db[db_key];
end;
if screen_center.version ~= screen_size then
    screen_center.version = screen_size;
end;
screen_center.stats.loaded = (screen_center.stats.loaded or 0) + 1;
do
    local l_v189_2, l_v228_0 = db_key, screen_center;
    do
        local function save_db()
            -- upvalues: events (ref), l_v189_2 (ref), l_v228_0 (ref), save_db (ref)
            events.database_pre_save:call();
            db[l_v189_2] = l_v228_0;
            utils.execute_after(300, save_db);
        end;
        utils.execute_after(300, save_db);
    end;
    events.shutdown:set(function ()
        -- upvalues: l_v189_2 (ref), l_v228_0 (ref)
        db[l_v189_2] = l_v228_0;
    end);
    db_manager.stats = setmetatable({}, {
        __index = function (_, k)
            -- upvalues: l_v228_0 (ref)
            local val = l_v228_0.stats[k];
            if val then
                return val;
            else
                l_v228_0.stats[k] = 0;
                return 0;
            end;
        end,
        __newindex = function (_, k, v)
            -- upvalues: l_v228_0 (ref), events (ref)
            l_v228_0.stats[k] = v;
            events.stats_update:call();
        end
    });
    db_manager.__direct = l_v228_0;
    setmetatable(db_manager, {
        __index = l_v228_0,
        __call = function (_)
            -- upvalues: l_v189_2 (ref), l_v228_0 (ref)
            db[l_v189_2] = l_v228_0;
        end
    });
end;
db_key = nil;
screen_size = ffi.typeof("char[?]");
screen_center = utils.get_vfunc("vgui2.dll", "VGUI_System010", 7, "int(__thiscall*)(void*)");
local native_screen_size = utils.get_vfunc("vgui2.dll", "VGUI_System010", 9, "void(__thiscall*)(void*, const char*, int)");
local native_screen_center = utils.get_vfunc("vgui2.dll", "VGUI_System010", 11, "int(__thiscall*)(void*, int, const char*, int)");
do
    local l_v227_0, l_v228_1, l_v239_0, l_v240_0 = screen_size, screen_center, native_screen_size, native_screen_center;
    db_key = {
        get = function ()
            -- upvalues: l_v228_1 (ref), l_v227_0 (ref), l_v240_0 (ref)
            local size = l_v228_1();
            if size == 0 then
                return;
            else
                local buf = l_v227_0(size);
                l_v240_0(0, buf, size);
                return ffi.string(buf, size - 1);
            end;
        end,
        set = function (val)
            -- upvalues: tostring (ref), l_v239_0 (ref)
            val = tostring(val);
            l_v239_0(val, #val);
        end
    };
end;
local current_font_set = 1;
local render_proxy = render.screen_size();
native_screen_size = render_proxy;
screen_size = render_proxy / current_font_set;
local anim_manager = render_proxy * 0.5;
screen_center = screen_size * 0.5;
native_screen_center = anim_manager;
current_font_set = nil;
colors = {};
render_proxy = function (font_name, size, flags, fallback)
    -- upvalues: launch_options (ref), pcall (ref), debug_log (ref)
    if launch_options.NOFONTS then
        return fallback or 1;
    else
        local success, res = pcall(render.load_font, font_name, size, flags);
        if not success then
            debug_log(font_name, " font has not been loaded, contact developers if the problem persists.");
            return fallback or 1;
        else
            return res;
        end;
    end;
end;
anim_manager = {
    big = render_proxy("Segoe UI Bold", Vector(16, 16), "a"),
    bold = render_proxy("Segoe UI Bold", Vector(14, 12), "a"),
    bold_d = render_proxy("Segoe UI Bold", Vector(14, 12), "ad"),
    regular = render_proxy("Segoe UI Semibold", Vector(14, 12), "a"),
    regular_d = render_proxy("Segoe UI Semibold", Vector(14, 12), "ad"),
    small = render_proxy("Segoe UI Semibold", Vector(12, 11), "a", 1),
    small_d = render_proxy("Segoe UI Semibold", Vector(12, 11), "ad", 1)
};
local drag_handler = {
    regular = 1,
    small = 2,
    bold_d = 4,
    bold = 4,
    small_d = 2,
    big = 4,
    regular_d = 1
};
current_font_set = anim_manager;
do
    local l_v250_0, l_v257_0 = anim_manager, drag_handler;
    events.style_changed:set(function (style)
        -- upvalues: current_font_set (ref), l_v250_0 (ref), l_v257_0 (ref)
        current_font_set = style == 1 and l_v250_0 or l_v257_0;
    end);
    colors = {
        hexs = "\a74A6A9",
        hex = "\a74A6A9FF",
        accent = Color("74A6A9"),
        back = Color(23, 26, 28),
        dark = Color(5, 6, 8),
        white = Color(255),
        black = Color(0),
        null = Color(0, 0, 0, 0),
        text = Color(240),
        themes = {
            dark = {
                text = Color(240),
                l1 = Color(5, 6, 8, 96),
                g1 = Color(5, 6, 8, 140),
                l2 = Color(23, 26, 28, 96),
                g2 = Color(23, 26, 28, 140)
            },
            light = {
                text = Color(24),
                l1 = Color(236, 239, 242),
                g1 = Color(236, 239, 242),
                l2 = Color(236, 239, 242),
                g2 = Color(236, 239, 242)
            }
        },
        simple = {
            g1 = Color(0, 0, 0, 80)
        }
    };
    colors.panel = colors.themes.dark;
end;
render_proxy = nil;
anim_manager = _G.render;
drag_handler = math_utils.floor;
local widget_factory = 1;
local image_assets = "s";
do
    local l_v250_1, l_v261_0, l_v262_0 = anim_manager, widget_factory, image_assets;
    local function scale(val)
        -- upvalues: l_v261_0 (ref)
        if l_v261_0 == 1 then
            return val;
        else
            return val * l_v261_0;
        end;
    end;
    local alpha = 1;
    local alpha_stack = {};
    local l_alpha_modulate_0 = Color().alpha_modulate;
    local function apply_alpha(col, override_alpha)
        -- upvalues: alpha (ref), colors (ref), l_alpha_modulate_0 (ref)
        if alpha == 1 then
            return col;
        elseif not override_alpha and alpha == 0 then
            return colors.null;
        else
            return l_alpha_modulate_0(col, alpha, true);
        end;
    end;
    local dpi_t = {};
    local is_scaled = l_v250_1.get_scale(2) ~= 1;
    do
        local l_v276_0 = is_scaled;
        dpi_t = {
            callback = function (new_dpi)
                -- upvalues: l_v261_0 (ref), l_v250_1 (ref), l_v262_0 (ref), render_proxy (ref), events (ref), l_v276_0 (ref)
                l_v261_0 = new_dpi and l_v250_1.get_scale(2) or 1;
                l_v262_0 = l_v261_0 ~= 1 and "s" or "";
                if render_proxy.dpi ~= l_v261_0 then
                    events.render_dpi:call(l_v261_0, render_proxy.dpi, l_v276_0);
                    local l_v249_0 = render_proxy;
                    local l_l_v261_0_0 = l_v261_0;
                    l_v276_0 = false;
                    l_v249_0.dpi = l_l_v261_0_0;
                end;
            end
        };
    end;
    events.render_dpi:set(function (dpi, _)
        -- upvalues: screen_size (ref), native_screen_size (ref), screen_center (ref)
        screen_size = native_screen_size / dpi;
        screen_center = screen_size * 0.5;
    end);
    is_scaled = pui.alpha > 0;
    do
        local l_v276_1 = is_scaled;
        events.render:set(function ()
            -- upvalues: events (ref), l_v276_1 (ref), pui (ref)
            events.pre_render_native:call();
            if l_v276_1 then
                events.render_ui:call();
            end;
            events.pre_hud_render:call();
            l_v276_1 = pui.alpha > 0;
        end);
    end;
    render_proxy = setmetatable({
        style = 1,
        dpi = 1,
        cheap = false,
        dpi_t = dpi_t,
        push_alpha = function (alpha)
            -- upvalues: alpha_stack (ref), error (ref), alpha (ref)
            local top = #alpha_stack;
            if top > 255 then
                error("alpha stack exceeded 255 objects, report to developers");
            end;
            alpha_stack[top + 1] = alpha;
            alpha = alpha * alpha_stack[top + 1] * (alpha_stack[top] or 1);
        end,
        pop_alpha = function ()
            -- upvalues: alpha_stack (ref), alpha (ref)
            local top = #alpha_stack;
            local l_v269_0 = alpha_stack;
            local l_v286_0 = top;
            local nil_val = nil;
            top = top - 1;
            l_v269_0[l_v286_0] = nil_val;
            alpha = top == 0 and 1 or alpha_stack[top] * (alpha_stack[top - 1] or 1);
        end,
        get_alpha = function (idx)
            -- upvalues: alpha_stack (ref), alpha (ref)
            if idx then
                return alpha_stack[idx];
            else
                return alpha, #alpha_stack;
            end;
        end,
        screen_size = function (unscaled)
            -- upvalues: l_v250_1 (ref), l_v261_0 (ref)
            return l_v250_1.screen_size() / (unscaled and 1 or l_v261_0);
        end,
        measure_text = function (font, ...)
            -- upvalues: l_v250_1 (ref), l_v262_0 (ref), l_v261_0 (ref)
            return l_v250_1.measure_text(font, l_v262_0, ...) / l_v261_0;
        end,
        load_font = function (name, size, flags)
            -- upvalues: l_v250_1 (ref)
            return l_v250_1.load_font(name, size, flags or "");
        end,
        text = function (font, pos, col, flags, text, measure)
            -- upvalues: l_v250_1 (ref), scale (ref), apply_alpha (ref), l_v262_0 (ref), render_proxy (ref)
            l_v250_1.text(font, scale(pos), apply_alpha(col), flags and flags .. l_v262_0 or l_v262_0, text);
            if measure == true then
                return render_proxy.measure_text(font, text);
            else
                return;
            end;
        end,
        blur = function (pos_a, pos_b, mult, radius, rounding)
            -- upvalues: render_proxy (ref), type (ref), scale (ref), alpha (ref), l_v250_1 (ref)
            if render_proxy.cheap then
                return;
            else
                if type(rounding) == "table" then
                    for i = 1, 4 do
                        rounding[i] = scale(rounding[i] or 0);
                    end;
                else
                    rounding = scale(rounding or 0);
                end;
                local radius = (radius or 1) * alpha;
                mult = scale(mult or 2);
                radius = radius;
                if radius > 0 and mult > 0 then
                    l_v250_1.blur(scale(pos_a), scale(pos_b), mult, radius, rounding);
                end;
                return;
            end;
        end,
        shadow = function (pos_a, pos_b, col, radius, offset_x, offset_y)
            -- upvalues: render_proxy (ref), l_v250_1 (ref), scale (ref), apply_alpha (ref)
            if render_proxy.cheap then
                return;
            else
                l_v250_1.shadow(scale(pos_a), scale(pos_b), apply_alpha(col), scale(radius or 16), scale(offset_x or 0), scale(offset_y or 0));
                return;
            end;
        end,
        poly = function (col, ...)
            -- upvalues: scale (ref), l_v250_1 (ref), apply_alpha (ref), unpack (ref)
            local points = {
                ...
            };
            for i = 1, #points do
                points[i] = scale(points[i]);
            end;
            l_v250_1.poly(apply_alpha(col), unpack(points));
        end,
        line = function (pos_a, pos_b, col)
            -- upvalues: l_v250_1 (ref), scale (ref), apply_alpha (ref)
            l_v250_1.line(scale(pos_a), scale(pos_b), apply_alpha(col));
        end,
        rect = function (pos_a, pos_b, col, rounding, filled)
            -- upvalues: type (ref), scale (ref), l_v250_1 (ref), apply_alpha (ref)
            if type(rounding) == "table" then
                for i = 1, 4 do
                    rounding[i] = scale(rounding[i] or 0);
                end;
            else
                rounding = scale(rounding or 0);
            end;
            l_v250_1.rect(scale(pos_a), scale(pos_b), apply_alpha(col), rounding, filled or false);
        end,
        rect_outline = function (pos_a, pos_b, col, thickness, rounding, filled)
            -- upvalues: type (ref), scale (ref), l_v250_1 (ref), apply_alpha (ref)
            if type(rounding) == "table" then
                for i = 1, 4 do
                    rounding[i] = scale(rounding[i] or 0);
                end;
            else
                rounding = scale(rounding or 0);
            end;
            l_v250_1.rect_outline(scale(pos_a), scale(pos_b), apply_alpha(col), scale(thickness or 0), rounding, filled or false);
        end,
        gradient = function (pos_a, pos_b, col_tl, col_tr, col_bl, col_br, type)
            -- upvalues: l_v250_1 (ref), scale (ref), apply_alpha (ref)
            local col_bl_real = col_bl or col_tl;
            if not col_br then
                col_br = col_tr;
            end;
            l_v250_1.gradient(scale(pos_a), scale(pos_b), apply_alpha(col_tl, true), apply_alpha(col_tr, true), apply_alpha(col_bl_real, true), apply_alpha(col_br, true), type or 0);
        end,
        circle = function (pos, col, radius, start_angle, end_angle)
            -- upvalues: l_v250_1 (ref), scale (ref), apply_alpha (ref)
            l_v250_1.circle(scale(pos), apply_alpha(col), scale(radius), start_angle or 0, end_angle or 1);
        end,
        circle_outline = function (pos, col, radius, start_angle, end_angle, thickness)
            -- upvalues: l_v250_1 (ref), scale (ref), apply_alpha (ref)
            l_v250_1.circle_outline(scale(pos), apply_alpha(col), scale(radius), start_angle or 0, end_angle or 1, scale(thickness or 1));
        end,
        circle_3d = function (pos, col, radius, start_angle, end_angle)
            -- upvalues: l_v250_1 (ref), apply_alpha (ref)
            l_v250_1.circle_3d(pos, apply_alpha(col), radius, start_angle or 0, end_angle or 1, false);
        end,
        circle_3d_outline = function (pos, col, radius, start_angle, end_angle, thickness)
            -- upvalues: l_v250_1 (ref), apply_alpha (ref), scale (ref)
            l_v250_1.circle_3d_outline(pos, apply_alpha(col), radius, start_angle or 0, end_angle or 1, scale(thickness or 1));
        end,
        circle_3d_gradient = function (pos, col_in, col_out, radius, start_angle, end_angle, thickness)
            -- upvalues: l_v250_1 (ref), apply_alpha (ref), scale (ref)
            l_v250_1.circle_3d_gradient(pos, apply_alpha(col_in), apply_alpha(col_out), radius, start_angle or 0, end_angle or 1, scale(thickness or 1));
        end,
        texture = function (tex, pos, size, col, mode, rounding)
            -- upvalues: Color (ref), l_v250_1 (ref), scale (ref), Vector (ref), apply_alpha (ref)
            if not tex then
                return;
            else
                if not col then
                    col = Color();
                end;
                l_v250_1.texture(tex, scale(pos), scale(size or Vector(tex.width, tex.height)), apply_alpha(col), mode or "", rounding or 0);
                return;
            end;
        end,
        push_clip_rect = function (pos_a, pos_b, intersect)
            -- upvalues: l_v250_1 (ref), scale (ref)
            l_v250_1.push_clip_rect(scale(pos_a), scale(pos_b), intersect or false);
        end
    }, {
        __index = l_v250_1
    });
end;
anim_manager = nil;
drag_handler = setmetatable({}, {
    __mode = "k"
});
widget_factory = 0;
image_assets = 1;
local aa_states = {
    pow = {
        [1] = function (v380, v381)
            return 1 - (1 - v380) ^ (v381 or 3);
        end,
        [2] = function (v382, v383)
            return v382 ^ (v383 or 3);
        end,
        [3] = function (v384, v385)
            -- upvalues: math_utils (ref)
            return v384 < 0.5 and 4 * math_utils.pow(v384, v385 or 3) or 1 - math_utils.pow(-2 * v384 + 2, v385 or 3) * 0.5;
        end
    }
};
do
    local l_v257_1, l_v261_1, l_v262_1, l_v386_0 = drag_handler, widget_factory, image_assets, aa_states;
    anim_manager = {
        pulse = 0,
        easings = l_v386_0,
        lerp = function (v391, v392, v393, v394)
            -- upvalues: l_v261_1 (ref), l_v262_1 (ref), math_utils (ref)
            local v395 = v391 + (v392 - v391) * l_v261_1 * (v393 or 8) * l_v262_1;
            return math_utils.abs(v392 - v395) < (v394 or 0.002) and v392 or v395;
        end,
        condition = function (v396, v397, v398, v399)
            -- upvalues: l_v257_1 (ref), type (ref), math_utils (ref), l_v261_1 (ref), l_v262_1 (ref), l_v386_0 (ref)
            local v400 = v396[1] and v396 or l_v257_1[v396];
            if not v400 then
                l_v257_1[v396] = {
                    [1] = v397 and 1 or 0,
                    [2] = v397
                };
                v400 = l_v257_1[v396];
            end;
            if not v398 then
                v398 = 4;
            end;
            local l_v398_0 = v398;
            if type(v398) == "table" then
                l_v398_0 = v397 and v398[1] or v398[2];
            end;
            v400[1] = math_utils.clamp(v400[1] + l_v261_1 * math_utils.abs(l_v398_0) * l_v262_1 * (v397 and 1 or -1), 0, 1);
            return (not (v400[1] % 1 ~= 0) or l_v398_0 < 0) and v400[1] or l_v386_0.pow[v399 and (v397 and v399[1][1] or v399[2][1]) or v397 and 1 or 3](v400[1], v399 and (v397 and v399[1][2] or v399[2][2]) or 3);
        end
    };
    events.post_render:set(function ()
        -- upvalues: anim_manager (ref), math_utils (ref), l_v261_1 (ref)
        anim_manager.pulse = math_utils.abs(globals.realtime * 1 % 2 - 1);
        l_v261_1 = globals.frametime;
    end);
end;
drag_handler = nil;
widget_factory = nil;
image_assets = {};
aa_states = function (v402, v403, v404)
    return v402.x >= v403.x and v402.x <= v404.x and v402.y >= v403.y and v402.y <= v404.y;
end;
local game_data = pui.create("drag data");
game_data:visibility(false);
do
    local l_v261_2, l_v262_2, l_v386_1, l_v405_0 = widget_factory, image_assets, aa_states, game_data;
    drag_handler = {
        data = l_v262_2,
        in_bounds = l_v386_1,
        ui_group = l_v405_0,
        new = function (v410, v411)
            -- upvalues: l_v262_2 (ref), l_v405_0 (ref), screen_size (ref), math_utils (ref), Vector (ref), native_screen_size (ref), events (ref), pui (ref)
            if not v411 then
                v411 = {};
            end;
            l_v262_2[v410.id] = {
                x = l_v405_0:slider(v410.id .. "::x", 0, 10000, v410.pos.x / screen_size.x * 10000),
                y = l_v405_0:slider(v410.id .. "::y", 0, 10000, v410.pos.y / screen_size.y * 10000)
            };
            l_v262_2[v410.id].x:set_callback(function (v412)
                -- upvalues: v410 (ref), math_utils (ref), screen_size (ref)
                v410.pos.x = math_utils.round(v412.value * 1.0E-4 * screen_size.x);
            end, true);
            l_v262_2[v410.id].y:set_callback(function (v413)
                -- upvalues: v410 (ref), math_utils (ref), screen_size (ref)
                v410.pos.y = math_utils.round(v413.value * 1.0E-4 * screen_size.y);
            end, true);
            v410.__drag = {
                active = false,
                locked = false,
                point = Vector(),
                progress = {
                    [1] = {
                        [1] = 0
                    },
                    [2] = {
                        [1] = 0
                    },
                    [3] = {
                        [1] = 0
                    }
                },
                border = v411.border or {
                    [1] = Vector(),
                    [2] = native_screen_size
                },
                rulers = v411.rulers or {},
                on_release = v411.on_release,
                on_held = v411.on_held,
                on_active = v411.on_active,
                config = l_v262_2[v410.id]
            };
            events.mouse_input:set(function ()
                -- upvalues: pui (ref), v410 (ref)
                if pui.alpha > 0 and (v410.__drag.hovered or v410.__drag.active) then
                    return false;
                else
                    return;
                end;
            end);
            events.render_dpi:set(function (_, _, _)
                -- upvalues: l_v262_2 (ref), v410 (ref)
                l_v262_2[v410.id].x:set(l_v262_2[v410.id].x.value);
                l_v262_2[v410.id].y:set(l_v262_2[v410.id].y.value);
            end);
        end,
        think = function (v417)
            -- upvalues: pui (ref), render_proxy (ref), l_v386_1 (ref), l_v261_2 (ref), anim_manager (ref), colors (ref), ipairs (ref), math_utils (ref), Vector (ref), screen_size (ref), Color (ref)
            local l___drag_0 = v417.__drag;
            if l___drag_0.locked or pui.alpha == 0 then
                return;
            else
                local v419 = ui.get_mouse_position() / render_proxy.dpi;
                local l_menu_position_0 = pui.menu_position;
                local l_menu_size_0 = pui.menu_size;
                local v422 = pui.alpha > 0 and common.is_button_down(1);
                local v423 = l_v386_1(v419, v417.pos, v417.pos + v417.size) and not l_v386_1(v419, l_menu_position_0 / render_proxy.dpi, (l_menu_position_0 + l_menu_size_0) / render_proxy.dpi);
                if v422 and l___drag_0.ready == nil then
                    local l_v423_0 = v423;
                    local v425 = v417.pos - v419;
                    l___drag_0.init = v417.pos:clone();
                    l___drag_0.point = v425;
                    l___drag_0.ready = l_v423_0;
                end;
                if v422 and l___drag_0.ready then
                    if l_v261_2 == nil and l___drag_0.on_held then
                        l___drag_0.on_held(v417, l___drag_0);
                    end;
                    l_v261_2 = l___drag_0.ready and l_v261_2 == nil and v417.id or l_v261_2;
                    l___drag_0.active = l_v261_2 == v417.id;
                elseif not v422 then
                    if l___drag_0.active and l___drag_0.on_release then
                        l___drag_0.on_release(v417, l___drag_0);
                    end;
                    l___drag_0.active = false;
                    local v426 = nil;
                    local v427 = nil;
                    local v428 = nil;
                    local v429 = nil;
                    l_v261_2 = nil;
                    l___drag_0.aligning = v429;
                    l___drag_0.init = v428;
                    l___drag_0.point = v427;
                    l___drag_0.ready = v426;
                end;
                local v430 = v417.pos * render_proxy.dpi;
                local v431 = v417.size * render_proxy.dpi;
                l___drag_0.hovered = v423 or l___drag_0.active;
                local v432 = {};
                local v433 = v430 + v431 * 0.5;
                local v434 = l___drag_0.point and (l___drag_0.point + v419) * render_proxy.dpi or v430;
                local v435 = anim_manager.condition(l___drag_0.progress[1], l___drag_0.active, 4);
                local v436 = anim_manager.condition(l___drag_0.progress[2], l___drag_0.active or l___drag_0.hovered, -12);
                render_proxy.push_alpha(pui.alpha);
                render_proxy.rect(v417.pos - 4, v417.pos + v417.size + 4, colors.white:alpha_modulate(0.1 * (v436 * 0.65 + 0.35), true), 6);
                render_proxy.rect_outline(v417.pos - 5, v417.pos + v417.size + 5, colors.white:alpha_modulate(0.3 * v435, true), 1, 7);
                render_proxy.push_alpha(v435);
                if v435 > 0 and not common.is_button_down(162) then
                    local v437 = (v434 + v431 * 0.5) / render_proxy.dpi;
                    for _, v439 in ipairs(l___drag_0.rulers) do
                        v439[4] = v439[4] or {
                            [1] = 0
                        };
                        local v440 = v439[2] / render_proxy.dpi;
                        local v441 = math_utils.abs(v439[1] and v437.x - v440.x or v437.y - v440.y) < 10 * render_proxy.dpi;
                        local l_v440_0 = v440;
                        local v443 = v439[1] and Vector(v440.x + 1, v439[3] / render_proxy.dpi) or Vector(v439[3] / render_proxy.dpi, v440.y + 1);
                        local v444 = v439[1] and 1 or 2;
                        if not v432[v444] then
                            v432[v444] = v441 and (v439[1] and v440.x - v417.size.x * 0.5 or v440.y - v417.size.y * 0.5) or nil;
                        end;
                        local v445 = math_utils.abs(v439[1] and v433.x - v440.x or v433.y - v440.y);
                        local v446 = anim_manager.condition(v439[4], v441 or v445 < 10 * render_proxy.dpi, -8) * 0.35 + 0.1;
                        render_proxy.rect(l_v440_0, v443, colors.white:alpha_modulate(v446, true));
                    end;
                    if l___drag_0.border[3] then
                        local v447 = l_v386_1(v417.pos, l___drag_0.border[1], l___drag_0.border[2] - v417.size * 0.5 - 1);
                        local v448 = anim_manager.condition(l___drag_0.progress[3], not v447);
                        render_proxy.rect_outline(l___drag_0.border[1] / render_proxy.dpi, l___drag_0.border[2] / render_proxy.dpi, colors.white:alpha_modulate(v448 * 0.75 + 0.25, true), 1, 4);
                    end;
                end;
                render_proxy.pop_alpha();
                render_proxy.pop_alpha();
                if l___drag_0.active then
                    local v449 = v434 / render_proxy.dpi;
                    if common.is_button_down(160) then
                        local v450 = l___drag_0.init:to(v449);
                        local v451 = math_utils.abs(v450.y);
                        local v452 = math_utils.abs(v450.x);
                        if l___drag_0.aligning == nil then
                            if v451 > 0.9 then
                                l___drag_0.aligning = 0;
                            elseif v452 > 0.9 then
                                l___drag_0.aligning = 1;
                            end;
                        end;
                        if l___drag_0.aligning == 0 then
                            v449.x = l___drag_0.init.x;
                            render_proxy.rect(Vector(v449.x + v417.size.x * 0.5, 0), Vector(v449.x + v417.size.x * 0.5 + 1, screen_size.y), Color(255, 64));
                        elseif l___drag_0.aligning == 1 then
                            v449.y = l___drag_0.init.y;
                            render_proxy.rect(Vector(0, v449.y + v417.size.y * 0.5), Vector(screen_size.x, v449.y + v417.size.y * 0.5 + 1), Color(255, 64));
                        end;
                    end;
                    local v453 = v432[1] or v449.x;
                    v449.y = v432[2] or v449.y;
                    v449.x = v453;
                    v453 = (l___drag_0.border[1] - v431 * 0.5) / render_proxy.dpi;
                    local v454 = (l___drag_0.border[2] - v431 * 0.5) / render_proxy.dpi;
                    v417:set_position(math_utils.clamp(v449.x, v453.x, math_utils.min(v454.x, screen_size.x - v417.size.x)), (math_utils.clamp(v449.y, v453.y, math_utils.min(v454.y, screen_size.y - v417.size.y))));
                    if l___drag_0.on_active then
                        l___drag_0.on_active(v417, l___drag_0, v449);
                    end;
                end;
                return;
            end;
        end
    };
end;
widget_factory = nil;
image_assets = nil;
do
    local l_v262_3 = image_assets;
    l_v262_3 = {
        update = function (_)
            return 1;
        end,
        paint = function (_, _, _)

        end,
        set_position = function (v460, v461, v462)
            -- upvalues: type (ref), screen_size (ref)
            local v463 = nil;
            local v464 = nil;
            if type(v461) == "userdata" then
                local l_x_0 = v461.x;
                v464 = v461.y;
                v463 = l_x_0;
            else
                local l_v461_0 = v461;
                v464 = v462;
                v463 = l_v461_0;
            end;
            if v460.__drag then
                if v463 then
                    v460.__drag.config.x:set(v463 / screen_size.x * 10000);
                end;
                if v464 then
                    v460.__drag.config.y:set(v464 / screen_size.y * 10000);
                end;
            else
                local l_pos_0 = v460.pos;
                local l_pos_1 = v460.pos;
                local v469;
                if not v463 then
                    v469 = v460.pos.x;
                else
                    v469 = v463;
                end;
                local v470;
                if not v464 then
                    v470 = v460.pos.y;
                else
                    v470 = v464;
                end;
                l_pos_1.y = v470;
                l_pos_0.x = v469;
            end;
        end,
        get_drag_position = function (v471)
            -- upvalues: Vector (ref), screen_size (ref)
            local v472 = v471.__drag and v471.__drag.config;
            if not v472 then
                return v471.pos;
            else
                local l_value_0 = v472.x.value;
                local l_value_1 = v472.y.value;
                return Vector(l_value_0 * 1.0E-4 * screen_size.x, l_value_1 * 1.0E-4 * screen_size.y);
            end;
        end,
        __call = function (v475)
            -- upvalues: render_proxy (ref), drag_handler (ref), l_v262_3 (ref)
            local l___list_0 = v475.__list;
            local l___drag_1 = v475.__drag;
            if l___list_0 then
                local v478 = l___list_0.collect();
                l___list_0.active = 0;
                l___list_0.items = v478;
                for v479 = 1, #l___list_0.items do
                    if l___list_0.items[v479].active then
                        l___list_0.active = l___list_0.active + 1;
                    end;
                end;
            end;
            v475.alpha = v475:update();
            render_proxy.push_alpha(v475.alpha);
            if v475.alpha > 0 then
                if l___drag_1 then
                    drag_handler.think(v475);
                end;
                if l___list_0 then
                    l_v262_3.traverse(v475);
                end;
                v475:paint(v475.pos, v475.pos + v475.size);
            end;
            render_proxy.pop_alpha();
        end,
        enlist = function (v480, v481, v482, v483)
            -- upvalues: setmetatable (ref)
            v480.__list = {
                active = 0,
                longest = 0,
                items = {},
                progress = setmetatable({}, {
                    __mode = "k"
                }),
                minwidth = v480.size.x,
                collect = v481,
                paint = v482,
                rev = v483
            };
        end,
        traverse = function (v484)
            -- upvalues: Vector (ref), anim_manager (ref), render_proxy (ref), math_utils (ref)
            local l___list_1 = v484.__list;
            local v486 = 0;
            local v487 = Vector();
            local v488 = 0;
            l___list_1.longest = 0;
            l___list_1.active = v488;
            for v489 = 1, #l___list_1.items do
                local v490 = l___list_1.items[v489];
                local v491 = v490.name or v489;
                l___list_1.progress[v491] = l___list_1.progress[v491] or {
                    [1] = 0
                };
                local v492 = anim_manager.condition(l___list_1.progress[v491], v490.active, 6, {
                    [1] = {
                        [1] = 1,
                        [2] = 3
                    },
                    [2] = {
                        [1] = 2,
                        [2] = 3
                    }
                });
                if v492 > 0 then
                    render_proxy.push_alpha(v492);
                    v487 = l___list_1.paint(v484, v490, v486, v492);
                    render_proxy.pop_alpha();
                    local v493 = l___list_1.active + 1;
                    v486 = v486 + v487.y * v492;
                    l___list_1.active = v493;
                    l___list_1.longest = math_utils.max(l___list_1.longest, v487.x);
                end;
            end;
            v484.size.x = anim_manager.lerp(v484.size.x, math_utils.max(l___list_1.longest, l___list_1.minwidth), 10, 0.5);
        end,
        lock = function (v494, v495)
            if not v494.__drag then
                return;
            else
                v494.__drag.locked = v495 and true or false;
                return;
            end;
        end
    };
    l_v262_3.__index = l_v262_3;
    widget_factory = {
        new = function (v496, v497, v498, v499)
            -- upvalues: drag_handler (ref), type (ref), setmetatable (ref), l_v262_3 (ref)
            local v500 = {
                alpha = 0,
                id = v496,
                pos = v497,
                size = v498,
                progress = {
                    [1] = 0
                }
            };
            if v499 then
                drag_handler.new(v500, type(v499) == "table" and v499 or nil);
            end;
            return setmetatable(v500, l_v262_3);
        end
    };
end;
image_assets = {};
aa_states = {
    butterfly = {
        link = "https://cdn.hysteria.one/main/butterfly.png",
        type = "png",
        size = Vector(540, 540)
    },
    avatar = {
        type = "png",
        temp = true,
        size = Vector(64, 64),
        link = string_utils.format("https://neverlose.cc/static/avatars/%s.png", username)
    },
    logo_l = {
        bin = true,
        type = "png",
        link = "https://cdn.hysteria.one/logo/logo_l.png",
        size = Vector(26, 15)
    },
    logo_r = {
        bin = true,
        type = "png",
        link = "https://cdn.hysteria.one/logo/logo_r.png",
        size = Vector(24, 15)
    },
    logo_l2x = {
        bin = true,
        type = "png",
        link = "https://cdn.hysteria.one/logo/logo_l2x.png",
        size = Vector(52, 30)
    },
    logo_r2x = {
        bin = true,
        type = "png",
        link = "https://cdn.hysteria.one/logo/logo_r2x.png",
        size = Vector(48, 30)
    },
    logo_lo2x = {
        bin = true,
        type = "png",
        link = "https://cdn.hysteria.one/logo/logo_lo2x.png",
        size = Vector(52, 30)
    },
    logo_ro2x = {
        bin = true,
        type = "png",
        link = "https://cdn.hysteria.one/logo/logo_ro2x.png",
        size = Vector(48, 30)
    }
};
image_assets.corner_h1 = render_proxy.load_image("<svg width=\"4\" height=\"5.87\" viewBox=\"0 0 4 6\"><path fill=\"#fff\" d=\"M0 6V4c0-2 2-4 4-4v2C2 2 0 4 0 6Z\"/></svg>", Vector(8, 12));
image_assets.corner_h2 = render_proxy.load_image("<svg width=\"4\" height=\"5.87\" viewBox=\"0 0 4 6\"><path fill=\"#fff\" d=\"M4 6c0-2-2-4-4-4V0c2 0 4 2 4 4v2Z\"/></svg>", Vector(8, 12));
image_assets.corner_v1 = render_proxy.load_image("<svg width=\"5.87\" height=\"4\" viewBox=\"0 0 6 4\"><path fill=\"#fff\" d=\"M2 4H0c0-2 2-4 4-4h2C4 0 2 2 2 4Z\"/></svg>", Vector(12, 8));
image_assets.corner_v2 = render_proxy.load_image("<svg width=\"5.87\" height=\"4\" viewBox=\"0 0 6 4\"><path fill=\"#fff\" d=\"M2 0H0c0 2 2 4 4 4h2C4 4 2 2 2 0Z\"/></svg>", Vector(12, 12));
image_assets.warning = render_proxy.load_image("<svg width=\"16\" height=\"16\" viewBox=\"0 0 16 16\"><path fill=\"#fff\" d=\"m13.259 13h-10.518c-0.35787 0.0023-0.68906-0.1889-0.866-0.5-0.18093-0.3088-0.18093-0.6912 0-1l5.259-9.015c0.1769-0.31014 0.50696-0.50115 0.864-0.5 0.3568-0.00121 0.68659 0.18986 0.863 0.5l5.26 9.015c0.1809 0.3088 0.1809 0.6912 0 1-0.1764 0.3097-0.5056 0.5006-0.862 0.5zm-6.259-3v2h2v-2zm0-5v4h2v-4z\"/></svg>", Vector(32, 32));
image_assets.manual = render_proxy.load_image("<svg width=\"8\" height=\"10\" viewBox=\"0 0 8 10\"><path fill=\"#fff\" d=\"m0.384 5.802c-0.24286-0.19453-0.3842-0.48884-0.3842-0.8s0.14134-0.60547 0.3842-0.8l6.08-4c0.29513-0.22371 0.69277-0.25727 1.0212-0.086202 0.32846 0.17107 0.52889 0.51613 0.51477 0.8862l-1.92 3.96 1.92 4.04c0.01412 0.37007-0.18631 0.71513-0.51477 0.8862-0.32846 0.1711-0.7261 0.1375-1.0212-0.0862z\"/></svg>", Vector(20, 20));
image_assets.logo_lo = render_proxy.load_image("\137PNG\r\n\026\n\000\000\000\rIHDR\000\000\000\026\000\000\000\015\b\006\000\000\000\250Q\223\230\000\000\000\004sBIT\b\b\b\b|\bd\136\000\000\002iIDAT8O\189T=\136\146q\024\255\191W\004\199\t\186X\225\226;5\229\023XN\r\1614T\208 \t\"M:\152\163\195\169\22494\b\026wC!.\n\146%t tX\139\248\210\226\144`)Nw:\164\131\017\182\168\220q\155\246{^\255\127\187$2\226\184\a\030|\190\222\223\239\249x_%vA\"]\016\015S\137F\163\209{\189^\255\128\236z\189~t\a\002\243\199y6AD[~\191\255\216\235\2452\167\211\201\002\129\000\203\231\243\2311\169o<\030\191n6\155\204\229r\153\b\208\001\253\212\239\247\153\209hd\146$\237\195\127F\131\174L\165\135\127\021z\002\237\175L{\019\254\156\199)/\015\135\195#\131\193p%\157N\179H$\"\017\017\001\236\206\231\243'\131\193\128\233t:\166\213jU\028\248J\185\\>\r\135\195\015\0050\026a\173V\139Y\173V\022\143\199\191D\163Q\139F\163\185$\242\157N\231\155\217l6\156m\164\221n/n\148\205f\191\a\131\193kdS\a\221n\151\229r9\186\215i\161P\216\1648\249\138\162\208\026Z\211\233\2122\155\2056j\181\218\137\219\237\222*\149J\204\231\243-\177q\n\181\158\bl6\155\026'\"\025\015|\165\251p\160e\199\232\254\016\249\014\242\030q?\187\221NM]\023\181\184\195r\003\147\201\1326\210F\189\149\234\249\218\182\019\137\132\155\136\156\184O\141\223\135%\147I%\022\13999\208+\228\203\000; @Y\150\153\000n4\026\204\225p01\r\192\213\151)\149JU\209\200=\154\130\206\208\235\245\166\197b\241P\202d2\251\161P\2321\031\243%\242\155\184W@\236agg\231\179\199\227\177\152L\166\203\020\163\174\233\134\152\246\024\rj\168A!\188\1852H\221DJB\184\213jU]\221[\168\135\023?\194\239-h\\<\140{\204*\149\202\006\221@\236\158\003~D\205\221%\203/\227)\204\236J\252\r\017\1898\019\220\131M\031j\020J\173\0260\221\1625.\2266poCo@\233\243\016r\000C\2251\241v4\224\171D\127\147\015H\222\255C\1936b\207\215<\251[z\029\017MC\128\139w\148\177\022t\023\250\014J\031\230?\203:\"\001$s\224\255\254\255\251\t\028\251\005y1\018\227l\000\000\000\000IEND\174B`\130", Vector(26, 15));
image_assets.logo_ro = render_proxy.load_image("\137PNG\r\n\026\n\000\000\000\rIHDR\000\000\000\024\000\000\000\015\b\006\000\000\000\254\164\015\219\000\000\000\004sBIT\b\b\b\b|\bd\136\000\000\002\bIDAT8O\213S=hZQ\020>\207`\151$(\017\135\184\248\b\181`\146\022%\133\186\137?%c\161\163\198\128\232P\002]2\232T4\163B;\180\014\025\212M\tAh\147\169P\149b\a\201 \021\146A\156t\144R\132`\v\165Xh_\191ss\031<)\164 d\200\133\143s\238y\231\156\239\187\031<\133n\248(7\188\159\230!X\156N\167c\147\201\244\199l6/\253O\224<\004\1755M{>\028\014IU\213' 8\189\142\196H\176\136F\021\248\001\f\fC\155\2005y\231\250'\192+\239;\136\021\153\219\017y\135qVX\244\180\221n\031\248|>^$N\173V\235\004\002\129{6\155m\217\168n<\030\255\182\219\237\v\\\147/\b#\253:\026\141:\014\135\227\014\215\187\221.y<\030\170V\171\020\141F\021\165\223\239\127w\185\\\203\249|\158\144S\177X\020M^\175\151&\147\tY,\022R\148\171\135&\018\t\n\006\131\020\137D\136\251\211\233\244\022z:\220\147L&\169T*\209`0 \171\213\202x\203\226\021\248\169?_,\209\151\2432&\147J>K[\190`\225*\247aA\171R\169\216@\182\209h4(\028\014\031\151\203\229\135\241x|M\222\133}\130@_j\176\227U\189^\223\015\133B\186\178\251\248v\209l6\223\195\186\237V\171\245\203\239\247\031\229r\185\221T*\165\139x\006\242C\195\139}\1529S\160B\227'\027O\161P\184\140\197b+R\2339\226\003\2063\153L;\155\205\242\1608l\029[\226t:\197\157\149\179(>\189^\239\167\219\237^gsg,\146\179\031\016\031\003\223\1287\192\vY\127\137\184o\016\211A\1905\163n\246\178\195\004\143\128\168\172\243\194\143\192]`C\214NX\156\204U\196\004`\001\206\128w\192\030\192\022\014Y8\176\rL\00017\207\143v\141\224\127?\221~\130\191).\187\139\030\210\019\211\000\000\000\000IEND\174B`\130", Vector(24, 15));
image_assets.bfly = render_proxy.load_image("\137PNG\r\n\026\n\000\000\000\rIHDR\000\000\000\t\000\000\000\t\b\006\000\000\000\224\145\006\016\000\000\000\004sBIT\b\b\b\b|\bd\136\000\000\000\253IDAT\024Wc\228\231\231\239\248\248\241c9\031\031\223\174O\159>\165300<\000b\005..\174\229\223\190}\179\000\202w2\002\005\254\191\127\255\158a\193\130\005\f\229\229\229\223\127\253\250\149\197\198\1986\181\179\179\147+!!\129APP\144\001\172\b\b\128\020\003Xabb\"\195\252\249\243\025@\n@\128\145\145\145\129\145\151\151\247\205\161C\135\132\r\f\f\224\na\n\014\0288\192\016\026\026z\145\017\228&II\201\188\246\246v\206\128\128\000\176B\016\216\176a\003CVV\214\143\231\207\159g\130\172sPSS\219r\243\230Mn\144\228\131\a\015\024\020\020\020\192\nUTT>\221\189{\215\031\164H\000\232\184\a\251\246\237\227\aI\248\250\250\254\217\188y3\v\136mnn\014\242\b\023H\017\b$\176\179\179O\a1~\254\252\185\018\200\014\a\249\006\168\192\n(t\001\166\b\238\022l\f\000$\223ai]i\219y\000\000\000\000IEND\174B`\130", Vector(9, 9));
game_data = utils.get_vfunc("steamclient.dll", "SteamClient017", 2, "int(__thiscall*)(void*, int)");
local config_builder = utils.get_vfunc("steamclient.dll", "SteamClient017", 8, "int*(__thiscall*)(void*, int, int, const char*)");
local local_player = utils.get_vfunc("steamclient.dll", "SteamClient017", 9, "int*(__thiscall*)(void*, int, const char*)");
local players = utils.get_vfunc(35, "int(__thiscall*)(void*, uint64_t)");
local keybinds = utils.get_vfunc(5, "bool(__thiscall*)(void*, int, uint32_t*, uint32_t*)");
local active_binds = utils.get_vfunc(6, "bool(__thiscall*)(void*, int, unsigned char*, int)");
local build_info = nil;
local ui_helpers = nil;
local ui_groups = nil;
local ui_elements = nil;
if build_info == nil then
    build_info = 1;
    ui_elements = config_builder(game_data(build_info), build_info, "SteamFriends015");
    ui_groups = local_player(build_info, "SteamUtils009");
end;
local ui_tabs = ffi.typeof("char[?]");
local ui_settings = ffi.typeof("unsigned int[?]");
local function ui_groups_settings()
    -- upvalues: tonumber (ref), string_utils (ref)
    local v512 = panorama.GameStateAPI.GetLocalPlayerXuid();
    if not v512 then
        return;
    else
        local v513 = tonumber(string_utils.sub(v512, 4, -1));
        if not v513 then
            return;
        else
            return 76500000000000000ULL + v513;
        end;
    end;
end;
do
    local l_v503_0, l_v504_0, l_v505_0, l_v508_0, l_v509_0, l_v510_0, l_v511_0, l_v514_0 = players, keybinds, active_binds, ui_groups, ui_elements, ui_tabs, ui_settings, ui_groups_settings;
    local function v529(v523)
        -- upvalues: l_v503_0 (ref), l_v509_0 (ref), l_v511_0 (ref), l_v504_0 (ref), l_v508_0 (ref), l_v510_0 (ref), l_v505_0 (ref), render_proxy (ref), Vector (ref)
        if not v523 then
            return;
        else
            local v524 = l_v503_0(l_v509_0, v523);
            if v524 > 0 then
                local v525 = l_v511_0(1);
                local v526 = l_v511_0(1);
                if l_v504_0(l_v508_0, v524, v525, v526) and v525[0] > 0 and v526[0] > 0 then
                    local v527 = v525[0] * v526[0] * 4;
                    local v528 = l_v510_0(v527);
                    if l_v505_0(l_v508_0, v524, v528, v527) then
                        return render_proxy.load_image_rgba(ffi.string(v528, v527), Vector(v525[0], v526[0]));
                    end;
                end;
            end;
            return;
        end;
    end;
    local function v530()
        -- upvalues: l_v514_0 (ref), v529 (ref), image_assets (ref), events (ref), v530 (ref)
        local v531 = l_v514_0();
        local v532 = v529(v531);
        if v532 then
            image_assets.steampfp = v532;
            events.render:unset(v530);
        end;
    end;
    events.render:set(v530);
end;
game_data = {
    safely = function (v533, v534, v535)
        -- upvalues: pcall (ref), render_proxy (ref), print_error (ref)
        local v536, v537 = pcall(render_proxy.load_image, v533, v534);
        if not v536 then
            print_error("Couldn't load ", v535 or "an image", ". Reason: ", v537);
        end;
        return v536 and v537 or nil;
    end
};
do
    local l_v405_1 = game_data;
    events.file_loaded:set(function (v539, _, v541)
        -- upvalues: image_assets (ref), l_v405_1 (ref), Vector (ref)
        if v539 == "butterfly" then
            image_assets.butterfly_s = l_v405_1.safely(v541, Vector(64, 64), v539);
        end;
    end);
    files.create_folder(PROJECT_NAME);
    players = nil;
    keybinds = {};
    local_player = PROJECT_NAME .. "/resources.bin";
    config_builder = keybinds;
    keybinds = files.read(local_player, true);
    if keybinds then
        for v542, v543 in next, msgpack.unpack(keybinds) do
            config_builder[v542] = v543;
        end;
        players = true;
    else
        for v544, _ in next, aa_states do
            config_builder[v544] = false;
        end;
        players = false;
    end;
    keybinds = 0;
    do
        local l_v501_0, l_v502_0, l_v504_1 = config_builder, local_player, keybinds;
        for v549, v550 in next, aa_states do
            ui_tabs = nil;
            ui_settings = nil;
            if v550.bin then
                ui_settings = l_v501_0[v549];
            elseif v550.temp then
                ui_settings = nil;
            else
                ui_tabs = string_utils.format("%s/%s.%s", PROJECT_NAME, v549, v550.type);
                ui_settings = files.read(ui_tabs, true);
            end;
            do
                local l_v549_0, l_v550_0 = v549, v550;
                do
                    local l_v510_1 = ui_tabs;
                    if ui_settings and #ui_settings > 16 then
                        image_assets[l_v549_0] = l_v405_1.safely(ui_settings, l_v550_0.size, l_v549_0);
                        events.file_loaded:call(l_v549_0, image_assets[l_v549_0], ui_settings);
                    elseif not launch_options.OFFLINE then
                        l_v504_1 = l_v504_1 + 1;
                        network.get(l_v550_0.link, nil, function (v554)
                            -- upvalues: l_v504_1 (ref), string_utils (ref), image_assets (ref), l_v549_0 (ref), l_v405_1 (ref), l_v550_0 (ref), events (ref), l_v501_0 (ref), l_v510_1 (ref)
                            l_v504_1 = l_v504_1 - 1;
                            if not v554 or string_utils.sub(v554, 2, 4) ~= "PNG" then
                                return;
                            else
                                image_assets[l_v549_0] = l_v405_1.safely(v554, l_v550_0.size, l_v549_0);
                                if image_assets[l_v549_0] then
                                    events.file_loaded:call(l_v549_0, image_assets[l_v549_0], v554);
                                    if l_v550_0.bin then
                                        l_v501_0[l_v549_0] = v554;
                                    elseif l_v510_1 then
                                        files.write(l_v510_1, v554, true);
                                    end;
                                end;
                                return;
                            end;
                        end);
                    end;
                end;
            end;
        end;
        if not players and not launch_options.OFFLINE then
            do
                local l_v505_1 = active_binds;
                l_v505_1 = function ()
                    -- upvalues: l_v504_1 (ref), events (ref), l_v505_1 (ref)
                    if l_v504_1 == 0 then
                        events.render:unset(l_v505_1);
                        events.binary_downloaded:call();
                    end;
                end;
                events.render:set(l_v505_1);
                events.binary_downloaded:set(function ()
                    -- upvalues: l_v501_0 (ref), l_v502_0 (ref)
                    local v556 = msgpack.pack(l_v501_0);
                    files.write(l_v502_0, v556, true);
                end);
            end;
        end;
    end;
end;
aa_states = {
    states = {
        [1] = {
            [1] = "default",
            [2] = "Default",
            [3] = "D"
        },
        [2] = {
            [1] = "stand",
            [2] = "Standing",
            [3] = "S"
        },
        [3] = {
            [1] = "run",
            [2] = "Running",
            [3] = "R"
        },
        [4] = {
            [1] = "walk",
            [2] = "Walking",
            [3] = "W"
        },
        [5] = {
            [1] = "air",
            [2] = "Air",
            [3] = "A"
        },
        [6] = {
            [1] = "airc",
            [2] = "Air & crouch",
            [3] = "AC"
        },
        [7] = {
            [1] = "crouch",
            [2] = "Crouching",
            [3] = "C"
        },
        [8] = {
            [1] = "sneak",
            [2] = "Sneaking",
            [3] = "3"
        },
        [9] = {
            [1] = "fakelag",
            [2] = "Fakelag",
            [3] = "FL"
        }
    },
    snaps = {
        [1] = {
            [1] = "default",
            [2] = "Default",
            [3] = "D"
        },
        [2] = {
            [1] = "air",
            [2] = "Air",
            [3] = "A"
        },
        [3] = {
            [1] = "airc",
            [2] = "Air & crouch",
            [3] = "AC"
        },
        [4] = {
            [1] = "crouch",
            [2] = "Crouching",
            [3] = "C"
        },
        [5] = {
            [1] = "sneak",
            [2] = "Sneaking",
            [3] = "S"
        },
        [6] = {
            [1] = "walk",
            [2] = "Walking",
            [3] = "W"
        },
        [7] = {
            [1] = "edge",
            [2] = "Edge bait",
            [3] = "EB"
        }
    }
};
game_data = {
    hitgroups = {
        [0] = "generic",
        [1] = "head",
        [2] = "chest",
        [3] = "stomach",
        [4] = "left arm",
        [5] = "right arm",
        [6] = "left leg",
        [7] = "right leg",
        [8] = "neck",
        [9] = "generic",
        [10] = "gear"
    },
    states = table_utils.distribute(aa_states.states, nil, 1),
    kstates = table_utils.distribute(aa_states.states, 1),
    snaps = table_utils.distribute(aa_states.snaps, nil, 1),
    build = {
        [1] = {
            [1] = "",
            [2] = ""
        },
        [2] = {
            [1] = "S",
            [2] = ""
        },
        [3] = {
            [1] = "\206\178",
            [2] = ""
        },
        [4] = {
            [1] = "\226\153\170",
            [2] = ""
        }
    },
    aipeek = {
        COOLDOWN = 2,
        MOVING = 1,
        STANDBY = 0,
        MOVE_BACK = 3
    },
    exploit = {
        DT = 1,
        HS = 2,
        OS = 2
    }
};
config_builder = {
    builder = {
        custom = {}
    },
    snap = {
        custom = {}
    }
};
local_player = nil;
players = nil;
keybinds = nil;
active_binds = nil;
build_info = {
    valid = false,
    userid = 0,
    side = 0,
    exploit = {
        lc_left = 0
    }
};
players = {};
local_player = build_info;
build_info = nil;
ui_helpers = 0;
do
    local l_v507_0 = ui_helpers;
    build_info = function ()
        -- upvalues: menu_items (ref), local_player (ref), game_data (ref), math_utils (ref), l_v507_0 (ref)
        local l_dt_0 = menu_items.rage.main.dt;
        local l_hs_0 = menu_items.rage.main.hs;
        local l_fd_0 = menu_items.antiaim.misc.fd;
        local v561 = l_dt_0:get_override();
        local v562 = l_hs_0:get_override();
        local v563 = l_fd_0:get_override();
        local l_value_2 = l_dt_0.value;
        local l_value_3 = l_hs_0.value;
        local l_value_4 = l_fd_0.value;
        if v561 ~= nil then
            l_value_2 = v561;
        end;
        if v562 ~= nil then
            l_value_3 = v562;
        end;
        if v563 ~= nil then
            l_value_4 = v563;
        end;
        local_player.exploit.charge = rage.exploit:get();
        local_player.exploit.fd = l_value_4;
        if l_value_4 then
            local_player.exploit.active = game_data.exploit.OFF;
        else
            local_player.exploit.active = l_value_2 and game_data.exploit.DT or l_value_3 and game_data.exploit.HS or game_data.exploit.OFF;
        end;
        local v567 = local_player.self.m_nTickBase or 0;
        if math_utils.abs(v567 - l_v507_0) > 64 then
            l_v507_0 = 0;
        end;
        if l_v507_0 < v567 then
            l_v507_0 = v567;
        elseif v567 < l_v507_0 then

        end;
        local_player.exploit.lc_left = math_utils.min(14, math_utils.max(0, l_v507_0 - v567 - 1));
        local_player.exploit.defensive = local_player.exploit.lc_left > 0;
    end;
end;
do
    local l_v506_0, l_v508_1 = build_info, ui_groups;
    ui_helpers = function (v570)
        -- upvalues: local_player (ref), players (ref), math_utils (ref), l_v506_0 (ref), events (ref)
        local_player.self = entity.get_local_player();
        local_player.valid = local_player.self ~= nil and local_player.self:is_alive();
        players = entity.get_players(false, false);
        local_player.in_game = true;
        if local_player.self then
            local_player.userid = local_player.self:get_player_info().userid;
            local l_v502_1 = local_player;
            local l_v502_2 = local_player;
            local v573 = entity.get_threat();
            l_v502_2.menace = entity.get_threat(true);
            l_v502_1.threat = v573;
            if local_player.valid then
                local_player.flags = local_player.self.m_fFlags;
                local_player.on_ground = bit.band(local_player.flags, bit.lshift(1, 0)) == 1;
                local_player.duck_amount = local_player.self.m_flDuckAmount;
                local_player.crouching = local_player.duck_amount > 0.5;
                local_player.side = v570.in_moveright and -1 or v570.in_moveleft and 1 or 0;
                local_player.velocity = math_utils.sqrt3(local_player.self.m_vecVelocity:unpack());
                l_v502_1 = local_player;
                l_v502_2 = local_player;
                v573 = local_player.self:get_origin();
                l_v502_2.eyes = local_player.self:get_eye_position();
                l_v502_1.origin = v573;
                l_v502_1 = local_player;
                l_v502_2 = local_player;
                v573 = local_player.self:get_anim_state();
                l_v502_2.animlayers = local_player.self:get_anim_overlay();
                l_v502_1.animstate = v573;
                l_v506_0();
                if v570 then
                    l_v502_1 = local_player.self:get_player_weapon();
                    if l_v502_1 ~= local_player.weapon then
                        l_v502_2 = local_player;
                        v573 = local_player;
                        local l_v502_3 = local_player;
                        local l_l_v502_1_0 = l_v502_1;
                        local v576 = l_v502_1 and l_v502_1:get_weapon_info();
                        l_v502_3.weapon_i = l_v502_1 and l_v502_1:get_weapon_index();
                        v573.weapon_t = v576;
                        l_v502_2.weapon = l_l_v502_1_0;
                        events.local_weapon_change:call(l_v502_1);
                    end;
                    local_player.using = v570.in_use;
                    local_player.walking = local_player.velocity > 5 and v570.in_speed;
                    local_player.jumping = v570.in_jump or not local_player.on_ground;
                    local_player.in_score = v570.in_score;
                    l_v502_2 = local_player;
                    v573 = local_player;
                    local l_in_attack_0 = v570.in_attack;
                    v573.in_attack2 = v570.in_attack2;
                    l_v502_2.in_attack = l_in_attack_0;
                end;
            end;
        end;
    end;
    events.createmove:set(ui_helpers);
    events.net_update_end:set(function ()
        -- upvalues: local_player (ref)
        local_player.self = entity.get_local_player();
        local_player.valid = local_player.self ~= nil and local_player.self:is_alive();
        local_player.gamerules = entity.get_game_rules();
    end);
    events.player_death:set(function (v578)
        -- upvalues: local_player (ref), events (ref)
        if v578.userid == local_player.userid then
            events.local_death:call(v578);
        elseif v578.userid ~= local_player.userid and v578.attacker == local_player.userid then
            events.local_frag:call(v578);
        end;
    end);
    events.player_spawn:set(function (v579)
        -- upvalues: local_player (ref), events (ref)
        if v579.userid ~= local_player.userid then
            return;
        else
            events.local_spawn:call(v579);
            return;
        end;
    end);
    events.player_connect_full:set(function (v580)
        -- upvalues: local_player (ref), events (ref)
        if v580.userid ~= local_player.userid then
            return;
        else
            events.local_connect_full:call(v580);
            return;
        end;
    end);
    l_v508_1 = nil;
    ui_elements = {};
    active_binds = {};
    keybinds = ui_elements;
    events.pre_render_native:set(function ()
        -- upvalues: local_player (ref), players (ref), l_v508_1 (ref), events (ref)
        local_player.self = entity.get_local_player();
        local_player.valid = local_player.self ~= nil and local_player.self:is_alive();
        if local_player.valid then
            local l_v502_4 = local_player;
            local l_v502_5 = local_player;
            local v583 = local_player.self:get_origin();
            l_v502_5.eyes = local_player.self:get_eye_position();
            l_v502_4.origin = v583;
        end;
        players = entity.get_players(false, false);
        local l_is_in_game_0 = globals.is_in_game;
        if l_v508_1 and not l_is_in_game_0 then
            local l_v502_6 = local_player;
            local l_v502_7 = local_player;
            local v587 = nil;
            l_v502_7.valid = false;
            l_v502_6.self = v587;
            local_player.in_game = false;
            events.local_disconnect:call();
            l_v508_1 = false;
        end;
        l_v508_1 = l_is_in_game_0;
    end);
end;
build_info = nil;
ui_settings = nil;
ui_groups_settings = string_utils.find(_NAME, "\239\146\146");
ui_elements = chars_from_bytes_or_rad_to_deg(69, 86, 69, 78, 84, 33, 104, 89, 115, 84, 101, 82, 105, 65, 36, 66, 76, 73, 83, 83);
ui_tabs = chars_from_bytes_or_rad_to_deg(66, 76, 73, 83, 83, 45, 75, 69, 89, 58, 58, 37, 115, 58, 58, 37, 48, 50, 88);
ui_groups = chars_from_bytes_or_rad_to_deg(71, 85, 72, 90, 65, 79, 75, 88, 67, 80, 76, 78, 81, 68, 86, 82, 83, 84, 89, 87, 74, 66, 73, 69, 70, 77, 105, 102, 103, 115, 110, 122, 108, 114, 117, 112, 98, 97, 118, 109, 119, 101, 111, 113, 106, 107, 99, 116, 104, 120, 100, 121, 48, 49, 57, 51, 53, 50, 54, 52, 55, 56, 43, 47, 61);
ui_helpers = chars_from_bytes_or_rad_to_deg(104, 121, 115, 116, 101, 114, 105, 97, 58, 58, 75, 69, 89, 83, 58, 58, 48, 120, 48, 50);
local update_stats_ui = ui_groups;
ui_groups = ui_helpers;
ui_helpers = update_stats_ui;
update_stats_ui = ui_elements;
ui_elements = ui_tabs;
ui_tabs = update_stats_ui;
update_stats_ui = db[ui_groups];
if update_stats_ui then
    ui_settings = sec_base64.encode(string_utils.format(ui_elements, username, 255 - #username), ui_helpers) == update_stats_ui;
else
    ui_settings = false;
end;
do
    local l_v511_1 = ui_settings;
    events[ui_tabs]:set(function (v590, v591)
        -- upvalues: l_v511_1 (ref), events (ref)
        if v590 ~= l_v511_1 and v591 then
            events.render_ui:set(function ()
                common.reload_script();
            end);
        end;
    end);
    if _TEST_BUILD then
        update_stats_ui = false;
        ui_groups_settings = false;
        IS_DEBUG_MODE = update_stats_ui;
    end;
    if IS_DEBUG_MODE and (username == "enQ" or username == "maj0r") then
        build_level = 4;
    elseif IS_DEBUG_MODE or ui_groups_settings then
        build_level = 3;
    elseif l_v511_1 then
        build_level = 2;
    end;
end;
ui_helpers = {
    [1] = "live",
    [2] = "bliss",
    [3] = "beta",
    [4] = "debug"
};
build_info = {
    title = "hysteria",
    user = username,
    script = PROJECT_NAME,
    build = ui_helpers[build_level] or "live",
    version = VERSION,
    level = build_level
};
menu_items = {
    rage = {
        main = {
            enable = pui.find("Aimbot", "Ragebot", "Main", "Enabled", {
                dormant = "Dormant Aimbot"
            }),
            peek = pui.find("Aimbot", "Ragebot", "Main", "Peek Assist", {
                retreat = "Retreat Mode"
            }),
            dt = pui.find("Aimbot", "Ragebot", "Main", "Double Tap", {
                fl = "Fake Lag Limit",
                lag = "Lag Options"
            }),
            hs = pui.find("Aimbot", "Ragebot", "Main", "Hide shots", {
                options = "Options"
            })
        },
        selection = {
            hitboxes = pui.find("Aimbot", "Ragebot", "Selection", "Hitboxes"),
            multipoint = pui.find("Aimbot", "Ragebot", "Selection", "Multipoint", {
                head = "Head Scale",
                body = "Body Scale"
            }),
            hitchance = pui.find("Aimbot", "Ragebot", "Selection", "Hit Chance"),
            damage = pui.find("Aimbot", "Ragebot", "Selection", "Min. Damage", {
                delay = "Delay Shot"
            })
        },
        safety = {
            body_aim = pui.find("Aimbot", "Ragebot", "Safety", "Body Aim")
        },
        accuracy = {
            autostop = pui.find("Aimbot", "Ragebot", "Accuracy", "Auto Stop", {
                options = "Options"
            }),
            autostop_ssg = pui.find("Aimbot", "Ragebot", "Accuracy", "Auto Stop", {
                options = "Options"
            })
        }
    },
    antiaim = {
        __groups = {
            angles = pui.find("Aimbot", "Anti Aim", "Angles")
        },
        fl = {
            enable = pui.find("Aimbot", "Anti Aim", "Fake Lag", "Enabled"),
            limit = pui.find("Aimbot", "Anti Aim", "Fake Lag", "Limit")
        },
        misc = {
            fd = pui.find("Aimbot", "Anti Aim", "Misc", "Fake Duck"),
            sw = pui.find("Aimbot", "Anti Aim", "Misc", "Slow Walk"),
            leg = pui.find("Aimbot", "Anti Aim", "Misc", "Leg Movement")
        },
        angles = {
            enabled = pui.find("Aimbot", "Anti Aim", "Angles", "Enabled"),
            pitch = pui.find("Aimbot", "Anti Aim", "Angles", "Pitch"),
            yaw = pui.find("Aimbot", "Anti Aim", "Angles", "Yaw", {
                hidden = "Hidden",
                offset = "Offset",
                avoid_bs = "Avoid Backstab",
                base = "Base"
            }),
            modifier = pui.find("Aimbot", "Anti Aim", "Angles", "Yaw Modifier", {
                offset = "Offset"
            }),
            body = pui.find("Aimbot", "Anti Aim", "Angles", "Body Yaw", {
                invert = "Inverter",
                freestand = "Freestanding",
                right = "Right Limit",
                options = "Options",
                left = "Left Limit"
            }),
            freestand = pui.find("Aimbot", "Anti Aim", "Angles", "Freestanding", {
                body = "Body Freestanding",
                disable_yaw = "Disable Yaw Modifiers"
            }),
            extended = pui.find("Aimbot", "Anti Aim", "Angles", "Extended Angles")
        }
    },
    world = {
        main = {
            fov = pui.find("Visuals", "World", "Main", "Field of View"),
            zoom = pui.find("Visuals", "World", "Main", "Override Zoom", {
                scope = "Scope Overlay"
            })
        },
        other = {
            hitmarker = pui.find("Visuals", "World", "Other", "Hit Marker")
        }
    },
    misc = {
        movement = {
            airstrafe = pui.find("Miscellaneous", "Main", "Movement", "Air Strafe", {
                smooth = "Smoothing"
            }),
            aircrouch = pui.find("Miscellaneous", "Main", "Movement", "Air Duck", {
                mode = "Mode"
            })
        },
        other = {
            weaponacts = pui.find("Miscellaneous", "Main", "Other", "Weapon Actions"),
            eventlog = pui.find("Miscellaneous", "Main", "Other", "Log Events"),
            windows = pui.find("Miscellaneous", "Main", "Other", "Windows"),
            fakeping = pui.find("Miscellaneous", "Main", "Other", "Fake Latency")
        },
        ingame = {
            clantag = pui.find("Miscellaneous", "Main", "In-Game", "Clan Tag")
        }
    },
    global = {
        language = pui.find("Settings", "Language"),
        animspeed = pui.find("Settings", "Animation Speed"),
        menu_scale = pui.find("Settings", "Menu Scale")
    }
};
events.pre_render_native:set(function ()
    -- upvalues: keybinds (ref), table_utils (ref), active_binds (ref), string_utils (ref)
    local v592 = ui.get_binds();
    keybinds = v592;
    table_utils.clear(active_binds);
    for v593 = 1, #v592 do
        local v594 = v592[v593];
        if v594.active then
            active_binds[string_utils.lower(v594.name)] = v594;
        end;
    end;
end);
ui_helpers = nil;
ui_groups = nil;
ui_elements = nil;
ui_tabs = {};
ui_settings = {};
do
    local l_v509_1 = ui_elements;
    do
        local l_v510_2, l_v511_2, l_v514_1, l_l_v508_2_0 = ui_tabs, ui_settings, ui_groups_settings, update_stats_ui;
        l_v509_1 = {
            send = function (v600, v601)
                -- upvalues: l_v511_2 (ref), l_v510_2 (ref)
                l_v511_2[v600] = l_v511_2[v600] or {
                    [1] = 0,
                    [2] = nil,
                    [3] = false
                };
                if not l_v511_2[v600][3] then
                    l_v510_2[#l_v510_2 + 1] = v600;
                end;
                local v602 = l_v511_2[v600];
                local v603 = l_v511_2[v600];
                local l_v601_0 = v601;
                v603[3] = true;
                v602[2] = l_v601_0;
            end,
            setup = function (v605, v606)
                -- upvalues: string_utils (ref), l_v509_1 (ref)
                local v607 = v605:name();
                if string_utils.find(v607, "\001") then
                    if v606 ~= nil then
                        v605:set_callback(function (v608)
                            -- upvalues: v606 (ref), l_v509_1 (ref), v607 (ref)
                            local v609, v610 = v606(v608);
                            if not v610 then
                                v609 = v609 and 1 or 0;
                            end;
                            l_v509_1.send(v607, v609);
                        end, true);
                    else
                        v605:set_callback(function (v611)
                            -- upvalues: l_v509_1 (ref), v607 (ref)
                            l_v509_1.send(v607, v611.value and 1 or 0);
                        end, true);
                    end;
                    return v605;
                else
                    return;
                end;
            end
        };
        l_v514_1 = ui.get_style("Small Text");
        l_l_v508_2_0 = pui.accent;
        events.render_ui:set(function ()
            -- upvalues: pui (ref), l_v514_1 (ref), l_l_v508_2_0 (ref), l_v510_2 (ref), next (ref), l_v511_2 (ref), anim_manager (ref), string_utils (ref), table_utils (ref)
            local v612 = ui.get_style("Small Text");
            local l_accent_0 = pui.accent;
            if l_v514_1 ~= v612 or l_l_v508_2_0 ~= l_accent_0 then
                local v614 = {};
                local l_v612_0 = v612;
                l_l_v508_2_0 = l_accent_0;
                l_v514_1 = l_v612_0;
                l_v510_2 = v614;
                for v616, v617 in next, l_v511_2 do
                    local l_l_v510_2_0 = l_v510_2;
                    local v619 = #l_v510_2 + 1;
                    local l_v616_0 = v616;
                    v617[3] = true;
                    l_l_v510_2_0[v619] = l_v616_0;
                end;
            end;
            for v621 = #l_v510_2, 1, -1 do
                local v622 = l_v510_2[v621];
                local v623 = l_v511_2[l_v510_2[v621]];
                if v623[3] then
                    local v624 = anim_manager.condition(v623, v623[2] == 1, 4, {
                        [1] = {
                            [1] = 1,
                            [2] = 2
                        },
                        [2] = {
                            [1] = 2,
                            [2] = 2
                        }
                    });
                    local v625 = l_v514_1:lerp(l_l_v508_2_0, v624):to_hex();
                    local v626 = string_utils.gsub(v622, "\001", "\a" .. v625);
                    ui.localize("en", v622, pui.string(v626));
                    if v624 == v623[2] then
                        v623[3] = false;
                    end;
                end;
                if not v623[3] then
                    table_utils.remove(l_v510_2, v621);
                end;
            end;
        end);
    end;
    pui.macros.s = "\a{Small Text}";
    pui.macros.a = "\a{Active Text}";
    pui.macros.t = "\a{Text}";
    pui.macros.p = " \a{Small Text}\f<angle-right>\aDEFAULT\t";
    ui_groups = {};
    ui_helpers = {
        anim = l_v509_1.setup,
        selector = function (v627, v628)
            -- upvalues: ipairs (ref), tostring (ref), next (ref), events (ref), l_v509_1 (ref), menu_items (ref)
            local v629 = {};
            local v630 = {};
            local v631 = #v628;
            for v632, v633 in ipairs(v628) do
                local v634 = v633[1];
                v630[v632] = tostring(v632);
                v629[v632] = v634;
            end;
            v630[#v630 + 1] = "R";
            local v635 = v627:list("\next", v629, nil, false);
            local v636 = v627:list("\nint", v630, nil, false);
            v636:visibility(false);
            for v637, v638 in ipairs(v628) do
                local l_l_next_0_0 = next;
                local v640 = v638[2] or {};
                for _, v642 in l_l_next_0_0, v640 do
                    v642:depend({
                        [1] = v636,
                        [2] = v637
                    });
                end;
            end;
            local v643 = 0;
            local v644 = false;
            local function v645()
                -- upvalues: v643 (ref), v644 (ref), v636 (ref), v635 (ref), events (ref), v645 (ref)
                if v643 < globals.realtime or v644 == false then
                    v636:set(v635.value);
                    events.render_ui:unset(v645);
                    local v646 = 0;
                    v644 = false;
                    v643 = v646;
                end;
            end;
            for v647, v648 in ipairs(v629) do
                l_v509_1.send(v648, v635.value == v647 and 1 or 0);
            end;
            v635:set_callback(function ()
                -- upvalues: ipairs (ref), v629 (ref), l_v509_1 (ref), v635 (ref), v644 (ref), v636 (ref), v631 (ref), v643 (ref), menu_items (ref), events (ref), v645 (ref)
                for v649, v650 in ipairs(v629) do
                    l_v509_1.send(v650, v635.value == v649 and 1 or 0);
                end;
                if v644 then
                    v636:set(v635.value);
                    v644 = false;
                elseif v636.value ~= v635.value then
                    v636:set(v631 + 1);
                    local v651 = globals.realtime + 0.25 * (1 / menu_items.global.animspeed.value);
                    v644 = true;
                    v643 = v651;
                    events.render_ui:set(v645);
                end;
            end);
            if not IS_DEBUG_MODE then
                utils.execute_after(0, function ()
                    -- upvalues: v635 (ref), v636 (ref)
                    v635:set(1);
                    v636:set(1);
                end);
            end;
            return v635, v636;
        end,
        selectorb = function (v652, v653, v654)
            -- upvalues: ipairs (ref), next (ref), l_v509_1 (ref)
            local v655 = {};
            local _ = #v653;
            for v657, v658 in ipairs(v653) do
                v655[v657] = v658[1];
            end;
            local v659 = v652:list("\next", v655, nil, v654 == true);
            for v660, v661 in ipairs(v653) do
                local l_l_next_0_1 = next;
                local v663 = v661[2] or {};
                for _, v665 in l_l_next_0_1, v663 do
                    v665:depend({
                        [1] = v659,
                        [2] = v660
                    });
                end;
            end;
            v659:set_callback(function ()
                -- upvalues: ipairs (ref), v655 (ref), l_v509_1 (ref), v659 (ref)
                for v666, v667 in ipairs(v655) do
                    l_v509_1.send(v667, v659.value == v666 and 1 or 0);
                end;
            end, true);
            if not IS_DEBUG_MODE and v654 ~= true then
                utils.execute_after(0, function ()
                    -- upvalues: v659 (ref)
                    v659:set(1);
                end);
            end;
            return v659;
        end,
        animlist = function (v668)
            -- upvalues: l_v509_1 (ref)
            local v669 = v668:list();
            v668:set_callback(function ()
                -- upvalues: v669 (ref), l_v509_1 (ref), v668 (ref)
                for v670 = 1, #v669 do
                    l_v509_1.send(v669[v670], v668.value == v670 and 1 or 0);
                end;
            end, true);
            return v668;
        end,
        lock = function (v671, v672, v673, _)
            if not v673 then
                v673 = function (v675)
                    -- upvalues: v672 (ref)
                    v675:set(v672 or false);
                end;
            end;
            local function v676()
                -- upvalues: v673 (ref), v671 (ref)
                utils.execute_after(0.01, v673, v671);
            end;
            utils.execute_after(0.5, v673, v671);
            v671:set_callback(v676, true);
            v671:disabled(true);
        end,
        tabs = {
            home = pui.string("\f<house-blank>"),
            vars = pui.string("\f<bars>"),
            antiaim = pui.string("\f<shield>")
        }
    };
end;
ui_elements = {};
ui_tabs = ui_helpers.tabs.home;
ui_settings = {
    info = pui.create(ui_tabs, "\ninfo", 1),
    logo = pui.create(ui_tabs, "\nlogo", 1),
    selector = pui.create(ui_tabs, "\nselector", 1),
    stats = pui.create(ui_tabs, "Statistics", 2),
    links = pui.create(ui_tabs, "Links", 2),
    configsnew = pui.create(ui_tabs, "\nconfigsnew", 2),
    configs = pui.create(ui_tabs, "\nconfigs", 2),
    discord = pui.create(ui_tabs, "\nDiscord", 2)
};
ui_groups.home = ui_settings;
ui_elements.selectors = ui_helpers.selector(ui_settings.selector, {
    [1] = {
        [1] = "\001\f<bars-staggered>\r\tDashboard",
        [2] = {
            [1] = ui_settings.stats,
            [2] = ui_settings.links,
            [3] = ui_settings.discord
        }
    },
    [2] = {
        [1] = "\001\f<folder>\r\tConfigs",
        [2] = {
            [1] = ui_settings.configs,
            [2] = ui_settings.configsnew
        }
    }
});
ui_groups_settings = ({
    [1] = nil,
    [2] = "\v\f<bolt>  Bliss",
    [3] = "\v\f<flask>  Beta",
    [4] = "\v\f<brackets-curly>"
})[build_level];
ui_elements.info = {
    [1] = ui_settings.info:label(" \a{Small Text}\f<user>\r \tUser"),
    [2] = ui_settings.info:button(string_utils.format(" %s \nuser", username), nil, true),
    [3] = ui_settings.info:label("\a{Small Text}\f<code-commit>\r\tVersion"),
    [4] = ui_settings.info:button(string_utils.format(" %s \nver", VERSION), nil, true),
    [5] = ui_groups_settings and ui_settings.info:button(string_utils.format(" %s \nbuild", ui_groups_settings), nil, true) or nil
};
ui_elements.stats = {
    [1] = ui_settings.stats:label("\a{Small Text}\f<skull>\r\tFrags"),
    [2] = ui_settings.stats:button("stats-killed", nil, true),
    [3] = ui_settings.stats:label("\a{Small Text}\f<shield>\r\tEvaded"),
    [4] = ui_settings.stats:button("stats-evaded", nil, true),
    [5] = ui_settings.stats:label("\a{Small Text}\f<clock>\r\tPlaytime"),
    [6] = ui_settings.stats:button("stats-playtime", nil, true),
    other = ui_settings.stats:label("\a{Small Text}\f<ellipsis>\r\226\128\138\tOther", function (v677)
        local v678 = {
            [1] = v677:label("\a{Small Text}\f<crown>\r\tGod LC"),
            [2] = v677:button("stats-godlc", nil, true),
            [3] = v677:label("\a{Small Text}\f<burst>\r\226\128\138\tWorld threat LC"),
            [4] = v677:button("stats-wtlc", nil, true),
            [5] = v677:label("\a{Small Text}\f<bullseye>\r\226\128\138\tHeadshots"),
            [6] = v677:button("stats-headshots", nil, true),
            [7] = v677:label("\a{Small Text}\f<skull>\r\226\128\138\tDeaths"),
            [8] = v677:button("stats-deaths", nil, true),
            [9] = v677:label("\226\128\138\a{Small Text}\f<plus-minus>\r \tK/D"),
            kd = v677:button("stats-kd", nil, true),
            troll = v677:switch("Show risky actions"),
            res = v677:button("  \aff5c5cff\f<arrow-rotate-left>\r  Reset  ", nil, true)
        };
        v678.troll:depend({
            [1] = nil,
            [2] = false,
            [1] = v678.troll
        });
        v678.res:depend({
            [1] = nil,
            [2] = true,
            [1] = v678.troll
        });
        return v678;
    end)
};
update_stats_ui = function ()
    -- upvalues: db_manager (ref), string_utils (ref), math_utils (ref), tostring (ref)
    local l_stats_0 = db_manager.stats;
    local v680 = string_utils.format("%d h", math_utils.floor(l_stats_0.playtime), math_utils.floor(l_stats_0.playtime % 1 * 100));
    local v681 = string_utils.format("%.2f", l_stats_0.killed / (l_stats_0.deaths == 0 and 1 or l_stats_0.deaths));
    ui.localize("en", "stats-killed", tostring(l_stats_0.killed));
    ui.localize("en", "stats-evaded", tostring(l_stats_0.evaded));
    ui.localize("en", "stats-playtime", v680);
    ui.localize("en", "stats-godlc", tostring(l_stats_0.god_lc));
    ui.localize("en", "stats-wtlc", tostring(l_stats_0.wt_lc));
    ui.localize("en", "stats-deaths", tostring(l_stats_0.deaths));
    ui.localize("en", "stats-headshots", tostring(l_stats_0.headshots));
    ui.localize("en", "stats-kd", v681);
end;
update_stats_ui();
events.stats_update:set(update_stats_ui);
do
    local l_l_v508_2_1 = update_stats_ui;
    ui_elements.stats.other.res:set_callback(function ()
        -- upvalues: db_manager (ref), l_l_v508_2_1 (ref)
        db_manager.__direct.stats = {};
        db_manager();
        l_l_v508_2_1();
    end);
end;
ui_elements.links = {
    ui_settings.links:label("\a{Small Text}Themes"),
    ui_settings.links:button(" \f<moon>  Dark ", function ()
        panorama.SteamOverlayAPI.OpenExternalBrowserURL("https://neverlose.cc/getitem?c=aZ0b4pLW4XUWThrd-6eUXQ59n-A");
    end, true),
    ui_settings.links:button(" \f<sun-bright>  Light ", function ()
        panorama.SteamOverlayAPI.OpenExternalBrowserURL("https://neverlose.cc/getitem?c=sWbZtdxgjqlx6bDm-S2s_FBrZIb");
    end, true),
    ui_settings.links:label("\a{Small Text}Scripts"),
    ui_settings.links:button(" \f<bolt>  Bliss ", function ()
        panorama.SteamOverlayAPI.OpenExternalBrowserURL("https://market.neverlose.cc/7kCCQB");
    end, true),
    ui_settings.links:button(" \f<shield>  ? ", function ()

    end, true):disabled(true),
    ui_settings.links:button(" \f<tennis-ball>  GH ", function ()
        panorama.SteamOverlayAPI.OpenExternalBrowserURL("https://market.neverlose.cc/X6Qa7d");
    end, true),
    ui_settings.links:label("\a{Small Text}Other"),
    ui_settings.links:button(" \f<memo>  Config ", function ()
        panorama.SteamOverlayAPI.OpenExternalBrowserURL("https://en.neverlose.cc/market/item?id=vSZYDo");
    end, true)
};
do
    local l_v511_3 = ui_settings;
    ui_elements.discord = {
        [1] = l_v511_3.discord:label("\a{Small Text}\f<discord>"),
        join = l_v511_3.discord:button("  \f<link>  Join  ", function ()
            panorama.SteamOverlayAPI.OpenExternalBrowserURL("https://discord.gg/eC82SmcF9E");
        end, true),
        verify = l_v511_3.discord:button("  \f<key>  Get code  ", function (v684)
            -- upvalues: string_utils (ref), ipairs (ref), table_utils (ref), username (ref), pcall (ref), l_v511_3 (ref), db_key (ref)
            v684:disabled(true);
            local function v691(v685)
                -- upvalues: string_utils (ref), ipairs (ref), table_utils (ref)
                local v686 = {};
                local v687 = {
                    string_utils.byte(v685, 1, #v685)
                };
                for v688, v689 in ipairs(v687) do
                    v686[v688] = string_utils.format("%x", v689);
                end;
                local v690 = string_utils.gsub(table_utils.concat(v686), "[64]", {
                    ["6"] = "a7",
                    ["4"] = "9r"
                });
                while #v690 < 16 do
                    v690 = v690 .. v690;
                end;
                return string_utils.sub(v690, 1, 16);
            end;
            local v692 = _BLISS and "neverlose-bliss" or "neverlose";
            local v693 = v691(username .. v692);
            network.get("https://backend.hysteria.one/keygen", {
                ["hst-uname"] = username,
                ["hst-cheat"] = v692,
                UserAgent = "ltcp_debug" .. ".." .. "|" .. ".." .. v693
            }, function (v694)
                -- upvalues: pcall (ref), l_v511_3 (ref), db_key (ref)
                if not v694 then
                    return;
                else
                    local v695, v696 = pcall(json.parse, v694);
                    if not v695 then
                        l_v511_3.discord:label("\aFF4040FF\f<key>\r  Something went wrong. Try again later");
                        return;
                    else
                        if v696.is_connected == "yes" then
                            l_v511_3.discord:label("\aFF4040FF\f<key>\r  You have already linked your discord.");
                        else
                            db_key.set(v696.status);
                            l_v511_3.discord:label("\aB6DE47FF\f<key>\r\tCopied successfully. Use #verify channel to get a role");
                        end;
                        return;
                    end;
                end;
            end);
        end, true)
    };
    if image_assets.butterfly then
        ui_elements.butterfly = l_v511_3.logo:texture(image_assets.butterfly, Vector(270));
    else
        do
            local l_l_v508_2_2 = update_stats_ui;
            l_l_v508_2_2 = function (v698)
                -- upvalues: ui_elements (ref), l_v511_3 (ref), image_assets (ref), Vector (ref), events (ref), l_l_v508_2_2 (ref)
                if v698 == "butterfly" then
                    ui_elements.butterfly = l_v511_3.logo:texture(image_assets.butterfly, Vector(270));
                    events.file_loaded:unset(l_l_v508_2_2);
                end;
            end;
            events.file_loaded:set(l_l_v508_2_2);
        end;
    end;
end;
ui_tabs = nil;
ui_settings = ui_helpers.tabs.vars;
ui_groups_settings = {
    selector = pui.create(ui_settings, "\nselector", 1),
    rage = pui.create(ui_settings, "Rage", 1),
    misc = pui.create(ui_settings, "Misc", 2),
    move = pui.create(ui_settings, "Movement", 2),
    style = pui.create(ui_settings, "\nstyle", 1),
    visuals = pui.create(ui_settings, "Misc\nvisuals", 1),
    indicators = pui.create(ui_settings, "Indicators", 2),
    widgets = pui.create(ui_settings, "Widgets", 2)
};
ui_groups.settings = ui_groups_settings;
ui_elements.ftabs = ui_helpers.selector(ui_groups_settings.selector, {
    [1] = {
        [1] = "\001\f<wand-magic-sparkles>\r\tFeatures",
        [2] = {
            [1] = ui_groups_settings.misc,
            [2] = ui_groups_settings.move,
            [3] = ui_groups_settings.rage
        }
    },
    [2] = {
        [1] = "\001\f<glasses-round>\r\tVisuals",
        [2] = {
            [1] = ui_groups_settings.visuals,
            [2] = ui_groups_settings.style,
            [3] = ui_groups_settings.widgets,
            [4] = ui_groups_settings.indicators
        }
    }
});
ui_tabs = {
    settings = {
        teleport = ui_groups_settings.rage:switch("\001\f<person-from-portal>\r\tAuto teleport", false, function (v699, _)
            local v701 = {
                mode = v699:combo("Teleport style", {
                    [1] = "Offensive",
                    [2] = "Defensive"
                }),
                land = v699:switch("Ensure landing", true, "Ensure the moment of the landing and the shot."),
                wpns = v699:selectable("Allowed weapons", {
                    [1] = "Automatics",
                    [2] = "Pistols",
                    [3] = "Heavy pistols",
                    [4] = "Melee"
                }, "Non-automatic weapons are allowed by default.")
            };
            v701.land:depend({
                [1] = nil,
                [2] = "Offensive",
                [1] = v701.mode
            });
            v701.wpns:depend({
                [1] = nil,
                [2] = "Defensive",
                [1] = v701.mode
            });
            return v701, true;
        end),
        airstop = ui_groups_settings.rage:switch("\001\f<wind>\r\tAirstop", false, function (v702)
            return {
                duck = v702:switch("Allow aircrouch"),
                conds = v702:listable("Stop conditions", {
                    [1] = "Close to enemy",
                    [2] = "Pressing shift"
                })
            }, true;
        end),
        exswitch = ui_groups_settings.rage:switch("\001\f<shuffle>\r\tAuto hide shots", false, function (v703)
            return {
                p = v703:switch("Allow rifles and pistols", true),
                hp = v703:switch("Allow Desert Eagle", true)
            }, true;
        end, "Will automatically enable hide shots with double tap."),
        aipeek = ui_groups_settings.rage:switch("\001\238\130\160\r\tAI peek", false, function (v704)
            return {
                perf = v704:slider("Perfomance impact", 30, 100, 50),
                ticks = v704:slider("Safety ticks", 1, 32, 8)
            }, true;
        end),
        dormant = ui_groups_settings.rage:switch("\001\f<crosshairs-simple>\r\tDormant aimbot", false, function (v705)
            return {
                acc = v705:slider("Min. accuracy", 25, 90, 65, 1, "%")
            }, true;
        end),
        ping = ui_groups_settings.rage:switch("\001\f<satellite-dish>\r\tUnlock fake ping", false, function (v706)
            return {
                ovr = v706:slider("\nping", 0, 200, 200, 1, "ms")
            }, true;
        end),
        cross = ui_groups_settings.rage:hotkey("\b<s>\f<burst>\r   \226\128\138\226\128\138Ideal cross LC"),
        clantag = ui_groups_settings.misc:switch("\001\f<tags>\r\226\128\138\tClantag"),
        shared = ui_groups_settings.misc:switch("\001\f<signal-stream>\r\tShared icon"),
        logs = ui_groups_settings.misc:switch("\001\f<comment>\r\226\128\138\tLogger", false, function (v707)
            -- upvalues: ui_helpers (ref)
            local v708 = ui_helpers.selectorb(v707, {
                [1] = {
                    [1] = "\001\f<explosion>\r \226\128\138\226\128\138 Events\nl",
                    [2] = {}
                },
                [2] = {
                    [1] = "\001\f<pen>\r\tStyle\nl",
                    [2] = {}
                }
            });
            local v709 = {
                h = v707:switch("\001\f<check>\r\226\128\138\tDamage dealt\nl", true):depend({
                    [1] = nil,
                    [2] = 1,
                    [1] = v708
                }),
                m = v707:switch("\001\f<xmark-large>\r\226\128\138\tShots missed\nl", true):depend({
                    [1] = nil,
                    [2] = 1,
                    [1] = v708
                }),
                t = v707:switch("\001\f<skull>\r\tDamage taken", false):depend({
                    [1] = nil,
                    [2] = 1,
                    [1] = v708
                }),
                aa = v707:switch("\001\f<shield>\r\tDamage evaded", true):depend({
                    [1] = nil,
                    [2] = 1,
                    [1] = v708
                }),
                ab = v707:switch("\001\f<shield-keyhole>\r\tAnti-bruteforce", false):depend({
                    [1] = nil,
                    [2] = 1,
                    [1] = v708
                }),
                sc = v707:switch("\001\f<display>\r  \226\128\138\226\128\138 Screen", true):depend({
                    [1] = nil,
                    [2] = 2,
                    [1] = v708
                }),
                con = v707:switch("\001\f<terminal>\r\tConsole", true):depend({
                    [1] = nil,
                    [2] = 2,
                    [1] = v708
                }),
                hys = v707:switch("\b<p>  Show \194\171hysteria\194\187", true):depend({
                    [1] = nil,
                    [2] = 2,
                    [1] = v708
                })
            };
            v709.hys:depend({
                [1] = nil,
                [2] = true,
                [1] = v709.con
            });
            return v709, true;
        end),
        avoidc = ui_groups_settings.move:switch("\001\f<arrow-up-from-arc>\r   \226\128\138\226\128\138Avoid collisions"),
        fdspeed = ui_groups_settings.move:switch("\001\f<lock-open>\r   \226\128\138Unlock FD speed"),
        ladder = ui_groups_settings.move:switch("\001\f<arrow-up-wide-short>\r   \226\128\138Fast ladder"),
        nofall = ui_groups_settings.move:switch("\001\f<person-falling>\r\t No fall damage", false, "Keep in mind it won't work in 100% of cases."),
        release = ui_groups_settings.move:switch("\001\f<bomb>\r\tGrenade release", false, function (v710)
            return {
                dmg = v710:slider("Minimum damage", 1, 100, 50, 1, "HP"),
                burn = v710:switch("Allow molotovs", true)
            }, true;
        end),
        accent = ui_groups_settings.style:color_picker("\f<fill>\r\tColor", {
            Solid = {
                [1] = colors.accent
            },
            Rainbow = {
                colors.accent:alpha_modulate(96)
            },
            Gradient = {
                [1] = colors.accent,
                [2] = colors.white
            }
        }),
        style = ui_groups_settings.style:label("\f<pen-swirl>\r\tStyle", function (v711)
            -- upvalues: ui_helpers (ref)
            local v712 = {
                dpi = v711:switch("\001\238\130\160\r\tDPI scaling", false),
                mode = ui_helpers.animlist(v711:list("\v\f<pen>\r\tStyle", {
                    [1] = "\001\f<sparkles>\r\tClassic",
                    [2] = "\001\f<circle>\r\tSimple"
                })),
                blur = v711:switch("\001\226\128\138\f<droplet>\r\226\128\138\tBlur and glow", false, "Use if you have a really good GPU."),
                bga = v711:slider("\001\f<send-backward>\r\tAlpha", 0, 100, 7, 1, "%")
            };
            v712.bga:depend({
                [1] = nil,
                [2] = 2,
                [1] = v712.mode
            });
            return v712;
        end),
        crosshair = ui_groups_settings.indicators:switch("\226\128\138\001\f<rectangle-history>\r\226\128\138\tCrosshair indicators", false, function (v713)
            -- upvalues: ui_helpers (ref)
            return {
                style = ui_helpers.animlist(v713:list("\nstyle", {
                    [1] = "\001\f<sparkles>\r\tClassic\nch",
                    [2] = "\001\f<magnifying-glass>\r\tMini"
                })),
                bfly = v713:switch("\001\f<heart>\r\tButterfly", true)
            }, true;
        end),
        damage = ui_groups_settings.indicators:switch("\226\128\138\001\f<hundred-points>\r\226\128\138\tDamage indicator", false, function (v714)
            return {
                anim = v714:switch("\001\f<wave-sine>\r\tAnimated"),
                sw = v714:switch("\226\128\138\001\f<circle-dashed>\r\226\128\138\tShow state", false, "Will make text darker if damage not overridden."),
                font = v714:list(" \001\f<font>\r \tFont", {
                    [1] = "Pixel",
                    [2] = "Mini",
                    [3] = "Segoe UI",
                    [4] = "Tahoma"
                })
            }, true;
        end),
        arrows = ui_groups_settings.indicators:switch("\226\128\138\001\f<location-arrow>\r\226\128\138\226\128\138\tAnti-aim arrows"),
        marker = ui_groups_settings.indicators:switch("\226\128\138\001\f<bullseye-arrow>\r\226\128\138\tShot markers", false, function (v715)
            return {
                dur = v715:slider("\b<s>\f<timer>\r\tDuration", 10, 50, 20, 0.1, "s"),
                hit = v715:switch("\226\128\138\001\f<check>\r\tHit marker", true),
                miss = v715:switch("\226\128\138\001\f<xmark-large>\r\tMiss marker", false)
            }, true;
        end),
        watermark = ui_groups_settings.widgets:switch(" \001\f<bookmark>\r \tWatermark", true, function (v716)
            -- upvalues: ui_helpers (ref), build_level (ref), string_utils (ref), pui (ref), ui_tabs (ref), ui_groups (ref), ui_elements (ref), table_utils (ref), pcall (ref)
            local v717 = ui_helpers.selectorb(v716, {
                [1] = {
                    [1] = "\001\f<pen>\r\tStyle",
                    [2] = {}
                },
                [2] = {
                    [1] = "\001\f<lock>\r\226\128\138\tPrivacy",
                    [2] = {}
                }
            });
            local v718 = {
                hide = v716:switch("\001\f<eye-slash>\r\tHide logo"):depend({
                    [1] = nil,
                    [2] = 1,
                    [1] = v717
                }),
                time = v716:combo("\226\128\138\001\f<clock>\r\226\128\138\tTime", {
                    [1] = "24-hour",
                    [2] = "12-hour",
                    [3] = "Off"
                }):depend({
                    [1] = nil,
                    [2] = 1,
                    [1] = v717
                }),
                sb = build_level > 1 and v716:switch(" \001\f<code-branch>\r \tShow build", true):depend({
                    [1] = nil,
                    [2] = 2,
                    [1] = v717
                }) or nil,
                pfp = v716:combo(" \001\f<user>\r \tAvatar", {
                    [1] = "Steam",
                    [2] = "Neverlose",
                    [3] = "Hidden"
                }):depend({
                    [1] = nil,
                    [2] = 2,
                    [1] = v717
                }),
                namet = v716:combo("\001\f<signature>\r\tName", {
                    [1] = "Steam",
                    [2] = "Neverlose",
                    [3] = "Custom"
                }):depend({
                    [1] = nil,
                    [2] = 2,
                    [1] = v717
                }),
                name = v716:input("\nname", "Name", "Supports icons: \\f<icon-name>"):depend({
                    [1] = nil,
                    [2] = 2,
                    [1] = v717
                })
            };
            v718.name:depend({
                [1] = nil,
                [2] = "Custom",
                [1] = v718.namet
            });
            v718.name:set_callback(function (v719)
                -- upvalues: string_utils (ref), build_level (ref), pui (ref), ui_tabs (ref), ui_groups (ref), ui_elements (ref), table_utils (ref), pcall (ref)
                v719.value = string_utils.gsub(v719.value, "^%s+", "");
                v719.value = string_utils.gsub(v719.value, "%s+$", "");
                v719.value = string_utils.gsub(v719.value, "\\f<(.-)>", ui.get_icon);
                v719.value = string_utils.gsub(v719.value, "\\v", "\a{Link Active}");
                v719.value = string_utils.gsub(v719.value, "\\r", "\aDEFAULT");
                v719.value = string_utils.limit(v719.value, 24, true);
                v719:set(v719.value);
                if build_level < 4 and (v719.value == "enQ" or v719.value == "maj0r") then
                    v719:set("");
                    v719.value = "";
                    pui.traverse({
                        [1] = ui_tabs,
                        [2] = ui_groups,
                        [3] = ui_elements
                    }, function (v720, v721)
                        -- upvalues: string_utils (ref), table_utils (ref), pcall (ref)
                        local v722 = v720:name();
                        if not string_utils.find(v722, "^\n") then
                            v720:name("\a00000000" .. table_utils.concat(v721));
                        end;
                        pcall(function ()
                            -- upvalues: v720 (ref)
                            local v723 = v720:list();
                            if v723 then
                                local v724 = {};
                                for v725 = 1, #v723 do
                                    v724[v725] = "\n" .. v725;
                                end;
                                v720:update(v724);
                            end;
                        end);
                    end);
                    ui_groups.home.selector:parent():name("\nhome");
                    ui_groups.settings.selector:parent():name("\nfe");
                    ui_groups.antiaim.tabs:parent():name("\naa");
                    utils.execute_after(0.15, common.unload_script);
                end;
            end, true);
            return v718, true;
        end),
        keylist = ui_groups_settings.widgets:switch("\001\f<keyboard-brightness>\r   \226\128\138Keybinds"),
        speclist = ui_groups_settings.widgets:switch("\001\f<camera-cctv>\r\tSpectators"),
        slowdown = ui_groups_settings.widgets:switch("\001\f<snowflake>\r\t\226\128\138Slowdown warning"),
        lchelper = ui_groups_settings.widgets:switch("\001\f<arrow-up-left-from-circle>\r\t\226\128\138LC indicator", false, function (v726)
            return {
                bar = v726:switch("\001\f<bars-progress>\r\tProgress bar", false)
            }, true;
        end),
        process = ui_groups_settings.widgets:switch("\001\f<table-rows>\r\t\226\128\138The process", false, function (v727)
            return {
                graph = v727:switch("State graph", false, "\affa238ff\f<triangle-exclamation>\r  Very FPS consuming")
            }, true;
        end),
        aspect = ui_groups_settings.visuals:switch("\001\f<display>\r\tAspect ratio", false, function (v728)
            -- upvalues: table_utils (ref), tostring (ref), ipairs (ref)
            local v729 = {
                [1] = {
                    [1] = 125,
                    [2] = "5:4",
                    [3] = "5:4"
                },
                [2] = {
                    [1] = 133,
                    [2] = "4:3",
                    [3] = "4:3"
                },
                [3] = {
                    [1] = 150,
                    [2] = "3:2",
                    [3] = "3:2"
                },
                [4] = {
                    [1] = 160,
                    [2] = "16:10",
                    [3] = "16:10"
                },
                [5] = {
                    [1] = 178,
                    [2] = "16:9",
                    [3] = "16:9"
                }
            };
            local v730 = {};
            local v731 = table_utils.distribute(v729, 2, 1);
            v730.ratio = v728:slider("\nratio", 80, 240, 150, 0.01, function (v732)
                -- upvalues: v731 (ref), tostring (ref)
                return v731[v732] or tostring(v732 * 0.01);
            end);
            v728:label("\a{Small Text}\f<expand-wide>");
            for _, v734 in ipairs(v729) do
                do
                    local l_v734_0 = v734;
                    v730[l_v734_0[2]] = v728:button(l_v734_0[3], function ()
                        -- upvalues: v730 (ref), l_v734_0 (ref)
                        v730.ratio:set(l_v734_0[1]);
                    end, true);
                end;
            end;
            return v730, true;
        end),
        viewmodel = ui_groups_settings.visuals:switch("\001\f<hand>\r\226\128\138\tViewmodel", false, function (v736)
            return {
                [1] = v736:label(" "),
                res = v736:button("  \v\f<arrow-rotate-left>  \rReset  ", false, true),
                fov = v736:slider("\nfov", 40, 120, 68, 1, function (v737)
                    return "FOV: " .. v737;
                end),
                x = v736:slider("\nx", -100, 100, 0, 0.1, function (v738)
                    return "x: " .. v738 * 0.1;
                end),
                y = v736:slider("\ny", -100, 100, 0, 0.1, function (v739)
                    return "y: " .. v739 * 0.1;
                end),
                z = v736:slider("\nz", -100, 100, 0, 0.1, function (v740)
                    return "z: " .. v740 * 0.1;
                end)
            }, true;
        end),
        vgui = ui_groups_settings.visuals:switch("\001\f<rectangle-terminal>\r\226\128\138\tVGUI color", false, {
            [1] = nil,
            [2] = true,
            [1] = Color()
        }),
        scope = ui_groups_settings.visuals:switch("\001\f<crosshairs-simple>\r\t\226\128\138Sniper scope", false, function (v741)
            -- upvalues: colors (ref), Color (ref)
            local v742 = {
                clr = v741:combo("\f<fill>\tColor", {
                    [1] = "Custom",
                    [2] = "Accent",
                    [3] = "Accent inverted"
                }, {
                    Fade = {
                        [1] = colors.white
                    },
                    Gradient = {
                        colors.white,
                        Color(255, 0)
                    }
                }),
                size = v741:slider("\238\130\160\tSize", 20, 400, 40, 1, "px"),
                gap = v741:slider("\239\141\131\226\128\138\tGap", 0, 60, 10, 1, "px"),
                t = v741:switch("\001\f<text>\r\226\128\138\tT-scope")
            };
            v742.clr.color:depend({
                [1] = nil,
                [2] = "Custom",
                [1] = v742.clr
            });
            return v742, true;
        end),
        nadius = ui_groups_settings.visuals:switch("\001\f<circle-nodes>\r\226\128\138\tNade radius", false, function (v743)
            -- upvalues: Color (ref)
            return {
                fire = v743:switch("\001\f<fire-smoke>\r\tMolotov", true, {
                    [1] = nil,
                    [2] = true,
                    [1] = Color(240, 120, 100)
                }),
                smoke = v743:switch("\001\f<smoke>\r\tSmoke", false, {
                    [1] = nil,
                    [2] = true,
                    [1] = Color(128)
                })
            }, true;
        end),
        breaker = ui_groups_settings.visuals:switch("\001\f<fan>\r\226\128\138\tAnimation Breaker", false, function (v744)
            return {
                legs = v744:combo("Legs on ground", {
                    [1] = "Disabled",
                    [2] = "Static",
                    [3] = "Moonwalk"
                }),
                air = v744:combo("Legs in air", {
                    [1] = "Disabled",
                    [2] = "Static",
                    [3] = "Moonwalk"
                }),
                pitch = v744:switch("Pitch 0 on land")
            }, true;
        end)
    },
    drag = drag_handler.data
};
ui_settings = ui_helpers.tabs.antiaim;
ui_groups_settings = {
    tabs = pui.create(ui_settings, "\ntabs", 1),
    master = pui.create(ui_settings, "\nmaster", 2),
    buttons = pui.create(ui_settings, "Buttons", 1),
    settings = pui.create(ui_settings, "Settings", 2),
    ab = pui.create(ui_settings, "Variability", 2),
    builder = pui.create(ui_settings, "\nbuilder", 1),
    states = table_utils.new(#aa_states.states, 0),
    def = pui.create(ui_settings, "\ndef", 1),
    snap = pui.create(ui_settings, "\nsnap", 1)
};
ui_groups.antiaim = ui_groups_settings;
update_stats_ui = {
    ui_helpers.selector(ui_groups_settings.tabs, {
        [1] = {
            [1] = "\001\f<gear>\r\tSettings",
            [2] = {
                [1] = ui_groups_settings.master,
                [2] = ui_groups_settings.settings,
                [3] = ui_groups_settings.buttons,
                [4] = ui_groups_settings.ab
            }
        },
        [2] = {
            [1] = "\001\f<sliders-simple>\r\tBuilder",
            [2] = {
                [1] = ui_groups_settings.builder
            }
        },
        [3] = {
            [1] = "\001\f<object-subtract>\r\tDefensive",
            [2] = {
                [1] = ui_groups_settings.def,
                [2] = ui_groups_settings.snap
            }
        }
    })
};
local aa_ui_elements_or_aa_runtime_state = {
    enable = ui_groups_settings.master:switch("\226\128\138\001\f<star-christmas>\r\226\128\138\tAnti-aim"),
    buttons = {
        invert = ui_groups_settings.buttons:switch("Inverter"),
        fs = ui_groups_settings.buttons:switch("Freestanding", false, function (v745)
            return {
                s = v745:switch("\001\f<arrow-up>\r\tStatic", true)
            };
        end),
        edge = ui_groups_settings.buttons:switch("Edge yaw", false, function (v746)
            return {
                s = v746:switch("\001\f<arrow-up>\r\tStatic", true)
            };
        end),
        manual = ui_groups_settings.buttons:combo("Manual yaw", {
            [1] = "Off",
            [2] = "Left",
            [3] = "Right",
            [4] = "Forward"
        }, function (v747)
            return {
                s = v747:switch("\001\f<arrow-up>\r\tStatic", true)
            };
        end),
        roll = ui_groups_settings.buttons:slider("Roll", -50, 50, 0, 1, "\194\176")
    },
    general = {
        head = ui_groups_settings.settings:switch("\001\f<face-head-bandage>\r\226\128\138\tSafe head", false, function (v748)
            return {
                smart = v748:switch("\001\f<brain>\r\tSmart mode")
            }, true;
        end),
        use = ui_groups_settings.settings:switch("\226\128\138\001\f<hand>\r\226\128\138\tLegit AA"),
        nature = ui_groups_settings.settings:switch("\001\f<wave-sine>\r\tNaturality", false, "Smooth states.")
    },
    ab = {
        on = ui_groups_settings.ab:switch("\001\f<spa>\r\tAnti-bruteforce", false, function (v749)
            -- upvalues: next (ref)
            local v751 = {
                events = v749:selectable("\001\f<forward>\r\tTriggers", {
                    [1] = "Enemy shot",
                    [2] = "Local shot"
                }),
                mode = v749:combo("\v\f<gear>\r\tMode", {
                    [1] = "Adjust",
                    [2] = "Preset rack"
                }, "\vAdjust\r:  make fine adjustments to your current settings to refresh them.\n\n\vPreset rack\r:  load a new preset from your configs list to drastically change your settings."),
                power = v749:slider("\b<p> \f<arrows-left-right>\tPower", 1, 100, 25, 1, "%"),
                timer = v749:slider("\b<p> \f<timer>\tTimer", 0, 100, 30, 0.1, function (v750)
                    return v750 == 0 and "Off" or v750 * 0.1 .. "s";
                end),
                order = v749:combo("\b<p> \f<send-backward>\tOrder", {
                    [1] = "Random",
                    [2] = "Sequence"
                }),
                sel = v749:selectable("\b<p> \f<filter-list>\tSelected", {}, "If not selected, all configs will be used."),
                _lpt = v749:label("\a74c0fcff\f<circle-info>   TIP:\r   All your presets should be good enough."),
                _lpw = v749:label("\affd43bff\f<triangle-exclamation>   WARNING:\r   Your original settings may be lost after saving the preset.")
            };
            for v752, v753 in next, v751 do
                if v752 ~= "events" then
                    v753:depend(v751.events);
                end;
            end;
            v751.power:depend({
                [1] = nil,
                [2] = "Adjust",
                [1] = v751.mode
            });
            v751.timer:depend({
                [1] = nil,
                [2] = "Adjust",
                [1] = v751.mode
            });
            v751.order:depend({
                [1] = nil,
                [2] = "Preset rack",
                [1] = v751.mode
            });
            v751.sel:depend({
                [1] = nil,
                [2] = "Preset rack",
                [1] = v751.mode
            });
            v751._lpt:depend({
                [1] = nil,
                [2] = "Preset rack",
                [1] = v751.mode
            });
            v751._lpw:depend({
                [1] = nil,
                [2] = "Preset rack",
                [1] = v751.mode
            });
            return v751, true;
        end)
    },
    state = {
        selector = ui_groups_settings.builder:combo("\f<location-pin>\tState\nbuild", table_utils.distribute(aa_states.states, 2), function (v754)
            return {
                copy = v754:button("\t\f<arrow-up-from-bracket>   Copy\t", nil, true),
                paste = v754:button("\t\f<arrow-down-to-bracket>   Paste\t", nil, true),
                clear = v754:button("\t\f<arrow-rotate-left>  \226\128\138Reset\t", nil, true)
            };
        end, false)
    },
    builder = table_utils.new(0, #aa_states.states),
    def = {
        triggers = ui_groups_settings.def:switch("\001\f<arrow-up-left-from-circle>\r\tLC triggers", false, function (v755)
            return {
                states = v755:selectable("On state...", {
                    [1] = "Air",
                    [2] = "Air-crouch",
                    [3] = "Crouching",
                    [4] = "Sneaking",
                    [5] = "Walking",
                    [6] = "Running",
                    [7] = "Standing"
                })
            }, true;
        end),
        snap = ui_groups_settings.snap:switch("\001\f<object-subtract>\r\tDefensive AA", false, function (v756)
            return {
                os = v756:switch("\001\f<check>\r\tAllow with hide shots", true)
            }, true;
        end),
        selector = ui_groups_settings.snap:combo(" \f<location-pin>\tState\ndef", table_utils.distribute(aa_states.snaps, 2), nil, false)
    },
    snaps = {}
};
ui_tabs.antiaim = aa_ui_elements_or_aa_runtime_state;
local function link_aa_builder_to_config_or_features_module_or_aa_runtime_context(v758, v759)
    -- upvalues: table_utils (ref), config_builder (ref)
    v759:set_callback(function (v760)
        -- upvalues: table_utils (ref), config_builder (ref), v758 (ref)
        table_utils.place(config_builder.builder.custom, v758, v760.value);
    end, true);
    return v759;
end;
local aa_features = {
    random = function (v762)
        return v762 == 0 and "Off" or v762 .. "%";
    end
};
do
    local l_v761_0 = link_aa_builder_to_config_or_features_module_or_aa_runtime_context;
    for state_index = 1, #aa_states.states do
        local state_data = aa_states.states[state_index];
        local state_id = state_data[1];
        local state_name = state_data[2];
        local _ = state_data[3];
        local is_default_state = state_data[1] == "default";
        pui.macros.z = "\n" .. state_id;
        local state_ui_groups = {
            main = pui.create(ui_settings, "\nm" .. state_name, 1),
            off = pui.create(ui_settings, "\no" .. state_id, 2),
            yaw = pui.create(ui_settings, "\ny" .. state_id, 2),
            des = pui.create(ui_settings, "\nd" .. state_id, 2),
            misc = pui.create(ui_settings, "\na" .. state_id, 2)
        };
        local state_ui_elements = {};
        do
            local l_v767_0, l_v772_0 = state_id, state_ui_elements;
            local function create_aa_builder_options(parent_group, options_table)
                -- upvalues: l_v772_0 (ref), l_v761_0 (ref), l_v767_0 (ref)
                l_v772_0.o = {
                    lr = l_v761_0({
                        [1] = nil,
                        [2] = "add",
                        [3] = "on",
                        [1] = l_v767_0
                    }, parent_group:switch("\001\f<arrow-right-arrow-left>\r\tAdd yaw\b<z>")),
                    mid = l_v761_0({
                        [1] = nil,
                        [2] = "mod",
                        [3] = "mid",
                        [1] = l_v767_0
                    }, parent_group:switch("\001\f<arrows-rotate>\r\tModifier ignore delay\b<z>"))
                };
                return l_v772_0.o, options_table[0].type ~= "label" or nil;
            end;
            local default_state_label = nil;
            if not is_default_state then
                l_v772_0.on = l_v761_0({
                    [1] = nil,
                    [2] = "override",
                    [1] = l_v767_0
                }, state_ui_groups.main:switch(string_utils.format("\001\f<check>\r\t%s\b<z>", state_name), false, create_aa_builder_options));
            else
                default_state_label = state_ui_groups.main:label("\v\f<check>\r\tDefault", create_aa_builder_options);
            end;
            l_v772_0.off = l_v761_0({
                [1] = nil,
                [2] = "off",
                [1] = l_v767_0
            }, state_ui_groups.off:slider("\001\f<arrow-right-arrow-left>\r\tOffset\b<z>", -60, 60, 0, 1, "\194\176"));
            l_v772_0.al = l_v761_0({
                [1] = nil,
                [2] = "add",
                [3] = "l",
                [1] = l_v767_0
            }, state_ui_groups.off:slider("\b<p> \f<arrow-left>\r\tAdd left\b<z>", -60, 60, 0, 1, "\194\176")):depend(l_v772_0.o.lr);
            l_v772_0.ar = l_v761_0({
                [1] = nil,
                [2] = "add",
                [3] = "r",
                [1] = l_v767_0
            }, state_ui_groups.off:slider("\b<p> \f<arrow-right>\r\tAdd right\b<z>", -60, 60, 0, 1, "\194\176")):depend(l_v772_0.o.lr);
            l_v772_0.m = l_v761_0({
                [1] = nil,
                [2] = "mod",
                [3] = "type",
                [1] = l_v767_0
            }, state_ui_groups.yaw:combo("\001\f<arrows-rotate>\r\tModifier\b<z>", {
                [1] = "Off",
                [2] = "Jitter",
                [3] = "Ways",
                [4] = "Random",
                [5] = "Rotate",
                [6] = "Skitter"
            }));
            l_v772_0.mw = l_v761_0({
                [1] = nil,
                [2] = "mod",
                [3] = "ways",
                [1] = l_v767_0
            }, state_ui_groups.yaw:slider("\b<p> \f<shuffle>\tWays\b<z>", 3, 8)):depend({
                [1] = nil,
                [2] = "Ways",
                [1] = l_v772_0.m
            });
            l_v772_0.md = l_v761_0({
                [1] = nil,
                [2] = "mod",
                [3] = "deg",
                [1] = l_v767_0
            }, state_ui_groups.yaw:slider("\b<p> \f<arrows-left-right>\tDegree\b<z>", -90, 90, 0, 1, "\194\176")):depend({
                [1] = nil,
                [2] = "Off",
                [3] = true,
                [1] = l_v772_0.m
            });
            l_v772_0.d = l_v761_0({
                [1] = nil,
                [2] = "des",
                [3] = "mode",
                [1] = l_v767_0
            }, state_ui_groups.des:combo("\001\f<angle>\r\226\128\138\tDesync\b<z>", {
                [1] = "Off",
                [2] = "Static",
                [3] = "Jitter",
                [4] = "Random"
            }, function (v779, v780)
                -- upvalues: l_v761_0 (ref), l_v767_0 (ref)
                return {
                    i = l_v761_0({
                        [1] = nil,
                        [2] = "des",
                        [3] = "inv",
                        [1] = l_v767_0
                    }, v779:switch("\001\f<right-left>\r\tInverter\b<z>d")):depend({
                        [1] = nil,
                        [2] = "Static",
                        [1] = v780
                    })
                }, function (v781)
                    return v781.value ~= "Off";
                end;
            end));
            l_v772_0.dl = l_v761_0({
                [1] = nil,
                [2] = "des",
                [3] = "l",
                [1] = l_v767_0
            }, state_ui_groups.des:slider("\b<p> \f<arrow-left>\tLeft\b<z>", 0, 60, 60, 1, "\194\176")):depend({
                [1] = nil,
                [2] = "Off",
                [3] = true,
                [1] = l_v772_0.d
            });
            l_v772_0.dr = l_v761_0({
                [1] = nil,
                [2] = "des",
                [3] = "r",
                [1] = l_v767_0
            }, state_ui_groups.des:slider("\b<p> \f<arrow-right>\tRight\b<z>", 0, 60, 60, 1, "\194\176")):depend({
                [1] = nil,
                [2] = "Off",
                [3] = true,
                [1] = l_v772_0.d
            });
            l_v772_0.sm = l_v761_0({
                [1] = nil,
                [2] = "switch",
                [3] = "mode",
                [1] = l_v767_0
            }, state_ui_groups.misc:combo("\001\f<timer>\r\tDelay\b<z>", {
                [1] = "None",
                [2] = "Static",
                [3] = "Fluctuate",
                [4] = "Random"
            }));
            l_v772_0.st = l_v761_0({
                [1] = nil,
                [2] = "switch",
                [3] = "time",
                [1] = l_v767_0
            }, state_ui_groups.misc:slider("\b<p> \f<arrow-right-to-arc>\tAmount\b<z>", 1, 16, 0, 1, "t")):depend({
                [1] = nil,
                [2] = "None",
                [3] = true,
                [1] = l_v772_0.sm
            });
            l_v772_0.r = l_v761_0({
                [1] = nil,
                [2] = "random",
                [1] = l_v767_0
            }, state_ui_groups.misc:slider("\001\f<chart-scatter>\r\tRandomize\b<z>", 0, 100, 0, 1, aa_features.random));
            aa_ui_elements_or_aa_runtime_state.builder[l_v767_0] = l_v772_0;
            for v782, v783 in next, state_ui_groups do
                v783:depend(aa_ui_elements_or_aa_runtime_state.enable, {
                    [1] = nil,
                    [2] = 2,
                    [1] = update_stats_ui[2]
                }, {
                    [1] = aa_ui_elements_or_aa_runtime_state.state.selector,
                    [2] = state_name
                }, v782 ~= "main" and l_v772_0.on or nil);
            end;
        end;
    end;
    pui.macros.z = nil;
end;
link_aa_builder_to_config_or_features_module_or_aa_runtime_context = function (snap_config_path, snap_ui_element)
    -- upvalues: table_utils (ref), config_builder (ref)
    snap_ui_element:set_callback(function (snap_element_callback)
        -- upvalues: table_utils (ref), config_builder (ref), snap_config_path (ref)
        table_utils.place(config_builder.snap.custom, snap_config_path, snap_element_callback.value);
    end, true);
    return snap_ui_element;
end;
aa_features = {
    delay = function (delay_formatter)
        return delay_formatter == 0 and "Off" or delay_formatter .. "t";
    end,
    time = function (time_formatter)
        return time_formatter == 13 and "Max" or time_formatter .. "t";
    end,
    pitch = function (pitch_formatter)
        if pitch_formatter == -89 then
            return "Up";
        elseif pitch_formatter == 89 then
            return "Down";
        elseif pitch_formatter == 0 then
            return "Zero";
        else
            return pitch_formatter .. "\194\176";
        end;
    end
};
for snap_index = 1, #aa_states.snaps do
    local snap_data = aa_states.snaps[snap_index];
    local snap_id = snap_data[1];
    local snap_name = snap_data[2];
    local _ = snap_data[3];
    local is_default_snap = snap_data[1] == "default";
    pui.macros.z = "\n" .. snap_id;
    local snap_ui_groups = {
        main = pui.create(ui_settings, "\nsm" .. snap_id, 2),
        pitch = pui.create(ui_settings, "\nsx" .. snap_id, 2),
        yaw = pui.create(ui_settings, "\nsy" .. snap_id, 2),
        misc = pui.create(ui_settings, "\nsa" .. snap_id, 2)
    };
    local snap_ui_elements = {
        on = link_aa_builder_to_config_or_features_module_or_aa_runtime_context({
            [1] = nil,
            [2] = "on",
            [1] = snap_id
        }, snap_ui_groups.main:combo(string_utils.format("\001\f<check>\r\t%s\b<z>", snap_name), is_default_snap and {
            [1] = "Off",
            [2] = "Custom"
        } or {
            [1] = "Default",
            [2] = "Off",
            [3] = "Custom"
        })),
        x = link_aa_builder_to_config_or_features_module_or_aa_runtime_context({
            [1] = nil,
            [2] = "x",
            [3] = "type",
            [1] = snap_id
        }, snap_ui_groups.pitch:combo("\001 \f<arrows-up-down>\r \tPitch\b<z>", {
            [1] = "Off",
            [2] = "Static",
            [3] = "Jitter",
            [4] = "Random",
            [5] = "Random Static",
            [6] = "Spin",
            [7] = "Spin Full",
            [8] = "Camera",
            [9] = "At target"
        }))
    };
    snap_ui_elements.xa = link_aa_builder_to_config_or_features_module_or_aa_runtime_context({
        [1] = nil,
        [2] = "x",
        [3] = "ang",
        [1] = snap_id
    }, snap_ui_groups.pitch:slider("\b<p> \226\128\138\f<angle-90>\tAngle\b<z>x", -89, 89, -89, 1, aa_features.pitch)):depend({
        [1] = nil,
        [2] = "Static",
        [3] = "Jitter",
        [4] = "Random",
        [5] = "Random Static",
        [6] = "Spin",
        [7] = "Spin Full",
        [1] = snap_ui_elements.x
    });
    snap_ui_elements.xb = link_aa_builder_to_config_or_features_module_or_aa_runtime_context({
        [1] = nil,
        [2] = "x",
        [3] = "ang2",
        [1] = snap_id
    }, snap_ui_groups.pitch:slider("\b<p> \226\128\138\f<angle-90>\tAngle 2\b<z>x", -89, 89, -89, 1, aa_features.pitch)):depend({
        [1] = nil,
        [2] = "Jitter",
        [3] = "Random",
        [4] = "Random Static",
        [5] = "Spin",
        [6] = "Spin Full",
        [1] = snap_ui_elements.x
    });
    snap_ui_elements.xs = link_aa_builder_to_config_or_features_module_or_aa_runtime_context({
        [1] = nil,
        [2] = "x",
        [3] = "speed",
        [1] = snap_id
    }, snap_ui_groups.pitch:slider("\b<p> \f<gauge-simple-high>\tSpeed\b<z>x", -50, 50, 20, 0.1, "")):depend({
        [1] = nil,
        [2] = "Spin",
        [1] = snap_ui_elements.x
    });
    snap_ui_elements.y = link_aa_builder_to_config_or_features_module_or_aa_runtime_context({
        [1] = nil,
        [2] = "y",
        [3] = "type",
        [1] = snap_id
    }, snap_ui_groups.yaw:combo("\001\f<arrows-left-right>\r\tYaw\b<z>", {
        [1] = "Off",
        [2] = "Static",
        [3] = "Jitter",
        [4] = "Random",
        [5] = "Random Jitter",
        [6] = "Random Static",
        [7] = "Spin",
        [8] = "Spin Full",
        [9] = "Spin Jitter",
        [10] = "90w",
        [11] = "180v",
        [12] = snap_id == "edge" and "Opposite" or nil
    }));
    snap_ui_elements.ya = link_aa_builder_to_config_or_features_module_or_aa_runtime_context({
        [1] = nil,
        [2] = "y",
        [3] = "ang",
        [1] = snap_id
    }, snap_ui_groups.yaw:slider("\b<p> \226\128\138\f<angle-90>\tAngle\b<z>y", 0, 360, 180, 1, "\194\176")):depend({
        [1] = nil,
        [2] = "Off",
        [3] = true,
        [1] = snap_ui_elements.y
    }, {
        [1] = nil,
        [2] = "Opposite",
        [3] = true,
        [1] = snap_ui_elements.y
    });
    snap_ui_elements.yd = link_aa_builder_to_config_or_features_module_or_aa_runtime_context({
        [1] = nil,
        [2] = "y",
        [3] = "delay",
        [1] = snap_id
    }, snap_ui_groups.yaw:slider("\b<p> \f<timer>\tDelay\b<z>y", 0, 14, 0, 1, aa_features.delay)):depend({
        [1] = nil,
        [2] = "Jitter",
        [3] = "Spin Jitter",
        [1] = snap_ui_elements.y
    });
    snap_ui_elements.ys = link_aa_builder_to_config_or_features_module_or_aa_runtime_context({
        [1] = nil,
        [2] = "y",
        [3] = "speed",
        [1] = snap_id
    }, snap_ui_groups.yaw:slider("\b<p> \f<gauge-simple-high>\tSpeed\b<z>y", -50, 50, 20, 0.1, "")):depend({
        [1] = nil,
        [2] = "Spin",
        [3] = "Spin Jitter",
        [4] = "90w",
        [5] = "180v",
        [1] = snap_ui_elements.y
    });
    snap_ui_elements.f = link_aa_builder_to_config_or_features_module_or_aa_runtime_context({
        [1] = nil,
        [2] = "lc",
        [1] = snap_id
    }, snap_ui_groups.misc:switch("\001\f<arrow-up-left-from-circle>\r\tForce LC"));
    snap_ui_elements.t = link_aa_builder_to_config_or_features_module_or_aa_runtime_context({
        [1] = nil,
        [2] = "time",
        [1] = snap_id
    }, snap_ui_groups.misc:slider("\f<timer>\tDuration\b<z>", 1, 13, 13, 1, aa_features.time));
    aa_ui_elements_or_aa_runtime_state.snaps[snap_id] = snap_ui_elements;
    for ui_group_key, ui_group_obj in next, snap_ui_groups do
        ui_group_obj:depend(aa_ui_elements_or_aa_runtime_state.enable, aa_ui_elements_or_aa_runtime_state.def.snap, {
            [1] = nil,
            [2] = 3,
            [1] = update_stats_ui[2]
        }, {
            [1] = aa_ui_elements_or_aa_runtime_state.def.selector,
            [2] = snap_name
        }, ui_group_key ~= "main" and {
            [1] = nil,
            [2] = "Custom",
            [1] = snap_ui_elements.on
        } or nil);
    end;
end;
aa_ui_elements_or_aa_runtime_state.def.selector:depend(aa_ui_elements_or_aa_runtime_state.def.snap);
pui.macros.z = nil;
do
    local l_l_v508_2_3, l_v757_0 = update_stats_ui, aa_ui_elements_or_aa_runtime_state;
    l_v757_0.enable:set_callback(function (enable_switch_element)
        -- upvalues: l_l_v508_2_3 (ref)
        if not enable_switch_element.value then
            l_l_v508_2_3[1]:set(1);
        end;
    end, true);
    l_v757_0.def.triggers:depend({
        [1] = nil,
        [2] = false,
        [1] = l_v757_0.def.snap
    });
    pui.traverse(ui_groups_settings, function (traversed_element, element_path)
        -- upvalues: l_v757_0 (ref)
        if element_path[1] ~= "master" then
            traversed_element:depend({
                [1] = nil,
                [2] = true,
                [1] = l_v757_0.enable
            });
        end;
    end);
end;
ui_settings = {
    selected = 0,
    default = "hysteria::NL::YCFbZybtZT6FVVrNhCFdHTeYh3obeTmhs5GMaVlEM3Txes8OyYb5HVFbsi1xsirNaVlEDhSxesweaTWMzJEft5jnt5jrpzK2wFDAaVuENtz113ZntC7us2YxeL8Ae9K6wF8uzCmlgCXfsCXdpzK2wFDAaVuEN8SiZCKoHTjbpzK2wFSjaVuEW93iHVDdt5jwpzK2wFDzaVuEW3Sas5UbH3mhs5GMaVlECOzxes8OyYblsi7ws3xxgVYMaVlEWvrxes8PfYjvsi7lZVEwpzK2wFQiaVuEUz143ZTas3X8jCbrZ5IeBNShcimlgCXfsCXdpgEyHVRMhGh3Z5XhzGECFnZCFnZCFzbz113ZjCXfZVUksuGNhC1kZCThO3ZiZT6wgVZbhJjvtuSFaV9ntCKrZLSuciFxtTKuZHSnHT6htsYnZi7rjBCys5cMh3obeTmhs5OMh56xgVUbZTrMhJUbsiHdhVFhH3owMYxwsCXltCbwjLYas3mkj3Fkj30Mh3KhsuE8t5NNzCmlgCXfsCXdvzblsi7ws3xxgVRNh3EfHT68HTcMzCX2s5jhjCEavzjvsi7lZVEwvzxz113ZsiXfZTKwZHYnHuXdtfSlZC1uLzZxsuDkj5INh56xs5UbH5GUhVDxjCbkwDgitTKdg3Xdv9Zxs5UbH5OMhJUhticMhiKlH3XrjDSbP37fgTGhQws8AOZUSPZCaV9uci1xsiobsaSlZJXdKYEagVONhC1hs5IMhJZujTuMzu65HVFbsi1xsirCauEyv9FrHT1bhW6xtTTnjCboZgsdEM1at5Xda5UisYXOjCXxtgXrHT1bjYXOjCXxtgFagTFbvzhz113Zjibbj31kZCXfxYK2BYK6BYK9BYEit5ZWhuEaHVDbZLSaciFksi1xtuGUa3KlH8CntC7us4SaciKhsuE8t5MMhTEktiFwnpYxczFnjTEqvzXz113ZtC7us2eys3INa3EktfSxgLSlgJbwv9K8vzKov9DxHsYhjibbj31kZCXfvzZxgVUbZTkMhVE8eTmbp9EnsCuMhCDfjVRMhC1kZCPUh3DdZTKqZVRMzVjxjCXdtTKdg4SbcuUhtieUa373sfwQzJ6ysiXxg3Xdp9FfZTjwzWFhs3KytCXnhVUhjCEavzExgVYaFCbwHTDfZTGuci6xZCb1s2Gbs31kg3VMhyhwtT7qZgnlSNB2LNpvFngnZibdZsSbYiZhsiThQ8HvEwp3EWZChi6xZCb1s4YuZC7dtTKrjLYicuElt5UbxgEuHVBYa3EfszZNjVE8t33ns3b9ZGynYiEfshGaF5DxZCbbtuGhQ8ZCFnZCFnZCzGECFnZCFnHvLYKz113ZaVOMhiK3t3bnH4Sbs3EksCVMhimxZCFbsfSajCXfZVUksuOMhi6kZiKftLYiZCKoHTjbvzhz113ZH5Dks5EaHTbdpzFyZim6v9XwjJbfZACusiXfZTKwZsYhciX2s5jhjCEapzKvv9DasLSacuUdt3Ebs5SUhTjdHVUavzjxtuFhHTboxzjyjTbfZCXdygF5HTmq5pBAaiFfIYDktfSlt3ZiUzEz113Zt39Ma31hZLYytJRMai1nDgDwjBgyHTvBai15B9Dz113ZZQCxgsYxZYZYgVF8ZVYxsxyxt2YltTbnvzDfsfYys33iP5FxjCblaiFdIYKohnhhjJFbszDxspMlHTbd5pBAaiFfIYDktfSlt3ZiBYEz113Zt39Ma31hZLYytJRMai1nJYDwjBCyHTvBai15B9Dz113ZZQCxgsYxZYZYgVF8ZVYxspCxt2YltTbnvzDfsfYys33iP5FxjCblaiFdIYKohnhhjJFbszDxspMnHTbdH72BWYDntNdyt30Na37iZxrlci7rpzEogTOMaimdvzDoZUz113Zys5AUaiKfBYDojvSyciGUaTuMaTGiGib8jCXdaVQKaTz113ZMa31hZLYytJRMauEohbE8HVFhH9DnsldxtgZYgVF8ZVYyHVQBh3FbZiK1tJGSaiFfIYEkZiHBai1nBYDwjBCyHTvBai15B9Dz113ZZQCxgsYxZYEIZigxspMxt2YltTbnvzDfsfYys33nOi7rZgDnsldxtgjOg3b8jCXdaiKdBYZlsi71H3leBUMyZCv4ai7rv9EkZiHJa56ktaYltTbnvzDfsfYytTAfauE8BzDxtBMytVsNau6npgKhvzKnhnhhjJFbszKdBYKkpzEogTOMaimdvzDwtgFSt36baiFdIYKohnhhjJFbszDxspMbs5FxtiOeBUMyZCv4ai7rv9EkZiHBa56ktaYltTbnvzDfsfYytTAjauE8BgDxtBMytVsNau6npgKhvzKnhnhhjJFbszKdBgKkpzEogTOMaimdvzDwtgFSt36baiFdIYKohnhhjJFbszDxspMbs36bHTkeBUMyZCv4ai7rv9EkZiHEa56ktaYltTbnvzDfsfYytTAjauE8BgDxtBMytVsNau6npgKhvzKnhnhhjJFbszKdBgKkpzEogTOMaimdvzDwtgFSt36baiFdIYKohnhhjJFbszDxspMlsuXr5pBAaiFfIYDktfSlt3ZiBYEz113Zt39Ma31hZLYytJRMai1nQYDwjBCyHTvBai15B9Dz113ZZQCxgsYxZYZYgVF8ZVYxspCxt2YltTbnvzDfsfYys33nOi7rZgDnsldxtgZYgVF8ZVYyHVQBh3Zxg3XfHTceBUMyZCv4ai7rvzEkZiHBa56ktaYltTbnvzDfsfYytTABauE8BgDxtBMytVsNau6npgKhvzKna87iZzKdBYKkpzEogTOMaimdvzDwtgFSt36baiFdIYKoa87iZzDxspMlZCXixYFwtiKvv9Xz113Zs36xsQCyt5INzV68sibuZ3Xds2Cis5FxjCXwbgEUgVYzATbdRTEdt5XlgYbNsi71H3xhtieaP36bHTohtiexczx8sibuZ3Xds4SuZ3XrZVDxtQGngCXxZLYbcixbHTGUhVEoHVD8vzE1s3VNhi6xjJXdZsYiZT6xHimbv9XwtiKvs2guZCXiHVXfjQrxZfYyt39lO3ZiaVylO3ZiaVilO3ZiaVAEaubxwRGyeCJAh9D6ZBMyeCRAh9D6smGyeJLPhiEdt5XlgQrxZfSyt39iA5XwjC7oaVyiP5FxjCblaViiGib8jCXdaVAEaubxZYD2HjNOaubnBYD2HoMuaubwKYD2smGnZTFuZHrxZfSyt39iA5XwjC7oaVyiP5FxjCblaViaO5Uvt5EhjCTxjB3yeTJLoYD2HAMyeTABauxy8YeyeVLPauxwKYExgVYRaTtNai7rhnE1s5FktgK2hbE8HVFhH9K6zXEvgT2pFuXftYK8NgD6Hs8UgYD2HjNOaubnBYD2HbiyeVLPauxwKYXwtiXxg2rxZfYyt39uFCXiHVXfjYK2a87iZzK6a87iZzK8NgD6Hsd8auxx8YeyeTABauxy8YeyeVLPauxwKYFxgVDly9KivzDktzjWZTZxjTm8aVylO3ZiaVilO3ZiaVAEaubxwRGyeCJAh9D6ZBMyeCRAh9D6smGyeJLPh3D1jJFktuSQhibrjiXdjLYnsi7ftBMyZuIMhCXnZ3VMhi1xtuXxtYEIZigbciXnZ3TUaVINh56oHT61HTdUaVINa56is2Cxs4E7",
    badge = "\a{Link Active}\226\128\162\aDEFAULT  ",
    name = "",
    list = {},
    rlist = {}
};
ui_groups_settings = nil;
update_stats_ui = {
    list = ui_groups.home.configs:list("\nconfigs", {
        [1] = "Default",
        [2] = "1",
        [3] = "2",
        [4] = "3",
        [5] = "4",
        [6] = "5",
        [7] = "6",
        [8] = "7",
        [9] = "8",
        [10] = "9",
        [11] = "10",
        [12] = "11"
    }),
    load = ui_groups.home.configs:button("\t\t\f<arrow-down>\t\t", nil, false, "Load"),
    loadaa = ui_groups.home.configs:button("  \f<shield>  ", nil, false, "Load AA settings"),
    save = ui_groups.home.configs:button("   \f<floppy-disk>   ", nil, true, "Save"),
    export = ui_groups.home.configs:button("   \f<arrow-up-from-bracket>   ", nil, true, "Export"),
    delete = ui_groups.home.configs:button(" \f<trash> ", nil, true, "Delete"),
    report = ui_groups.home.configs:label("Config information"),
    new = ui_groups.home.configsnew:button("\t\t\t\t\f<plus-large>  New\t\t\t\t", nil, true),
    import = ui_groups.home.configsnew:button("   \f<arrow-down-to-bracket>  Import\t", nil, true),
    create = ui_groups.home.configsnew:button("\t\t\t\t\f<plus-large>  New\t\t\t\t", nil, false),
    cancel = ui_groups.home.configsnew:button("\t\f<xmark>  Cancel\t", nil, true),
    name = ui_groups.home.configsnew:input("\nname")
};
ui_elements.configs = update_stats_ui;
aa_ui_elements_or_aa_runtime_state = "BUMNWKCJQDYRLESIAFGOPXTVHZgtsjecpxylnbiuahzqforkvmdw8135269047+/=";
do
    local config_actions, l_l_v508_2_4, config_encoding_charset, show_config_notification, update_config_list_ui = ui_groups_settings, update_stats_ui, aa_ui_elements_or_aa_runtime_state, link_aa_builder_to_config_or_features_module_or_aa_runtime_context, aa_features;
    config_actions = {
        make = function (v810, v811, v812)
            -- upvalues: string_utils (ref), username (ref), sec_base64 (ref), config_encoding_charset (ref)
            local v813 = msgpack.pack(v812 or {});
            local v814 = string_utils.format("(%s)[%s]{%s}", v810 or "unnamed", v811 or username, v813);
            local v815 = string_utils.gsub(sec_base64.encode(v814, config_encoding_charset), "[%+%/%=]", {
                ["="] = "_",
                ["+"] = "z113Z",
                ["/"] = "z143Z"
            });
            return string_utils.format("%s::NL::%s", PROJECT_NAME, v815);
        end,
        eval = function (v816, v817)
            -- upvalues: string_utils (ref), sec_base64 (ref), config_encoding_charset (ref)
            if not v816 then
                return "\fPreset not found";
            else
                local v818, v819, v820, v821 = string_utils.match(v816, "^(%a+)::(%a+)::([%w%+%/]+)(_*)");
                if v818 ~= PROJECT_NAME then
                    return "\fInvalid config";
                elseif v819 ~= "NL" then
                    return "\fNot for neverlose";
                elseif not v820 then
                    return "\fCorrupted preset";
                else
                    v821 = v821 and string_utils.rep("=", #v821) or "";
                    v820 = string_utils.gsub(v820, "z%d%d%dZ", {
                        z113Z = "+",
                        z143Z = "/"
                    });
                    v820 = sec_base64.decode(v820 .. v821, config_encoding_charset);
                    local v822, v823, v824 = string_utils.match(v820, "^%((.*)%)%[(.*)%]%{(.+)%}");
                    return v822, v823, v817 ~= true and v824 ~= nil and msgpack.unpack(v824) or {};
                end;
            end;
        end,
        create = function (v825)
            -- upvalues: db_manager (ref), config_actions (ref), username (ref)
            if v825 == "" then
                local v826 = common.get_date("%B %e, %H:%M");
                if v826 then
                    v825 = v826;
                end;
            end;
            if v825 == "" then
                return "\fEmpty name";
            elseif v825 == "Default" then
                return "\fCan't overwrite default config";
            elseif #v825 > 24 then
                return "\fThe name is too long";
            elseif db_manager.configs[v825] then
                return "\f" .. v825 .. " is already in the list";
            else
                db_manager.configs[v825] = config_actions.make(v825, username);
                return "\a" .. v825 .. " has been created";
            end;
        end,
        save = function (v827, ...)
            -- upvalues: tostring (ref), config_actions (ref), db_manager (ref), ui_settings (ref)
            if v827 == "Default" then
                return "\fCan't overwrite default config";
            else
                v827 = tostring(v827);
                local v828, v829 = config_actions.eval(db_manager.configs[v827], true);
                db_manager.configs[v827] = config_actions.make(v828, v829, ui_settings.system:save(...));
                return "\a" .. v827 .. " has been saved";
            end;
        end,
        delete = function (v830)
            -- upvalues: db_manager (ref)
            if v830 == "Default" then
                return "\fCan't delete default config";
            else
                db_manager.configs[v830] = nil;
                return;
            end;
        end,
        export = function (v831)
            -- upvalues: db_key (ref), db_manager (ref)
            if not v831 or v831 == "" then
                return "\fNot selected";
            else
                db_key.set(db_manager.configs[v831]);
                return "\aCopied to clipboard.";
            end;
        end,
        import = function ()
            -- upvalues: db_key (ref), config_actions (ref), db_manager (ref), string_utils (ref)
            local v832 = db_key.get();
            if not v832 then
                return "\fEmpty clipboard";
            else
                local v833, v834 = config_actions.eval(v832, true);
                if not v834 then
                    return v833;
                else
                    local v835 = v832:match("^hysteria::%a+::[%w%+%/]+_*");
                    if v833 == "Default" then
                        return "\fCan't import default config";
                    else
                        db_manager.configs[v833] = v835;
                        return string_utils.format("\aAdded %s by %s", v833, v834);
                    end;
                end;
            end;
        end,
        load = function (v836, ...)
            -- upvalues: ui_settings (ref), db_manager (ref), config_actions (ref)
            if not v836 or v836 == "" then
                return "\fNot selected";
            else
                local v837 = v836 == "Default" and ui_settings.default or db_manager.configs[v836];
                local v838, v839, v840 = config_actions.eval(v837);
                if not v839 then
                    return v838;
                else
                    ui_settings.system:load(v840, ...);
                    if ... then
                        return;
                    else
                        ui_settings.loaded = v836;
                        return;
                    end;
                end;
            end;
        end
    };
    ui_settings.actions = config_actions;
    show_config_notification = nil;
    l_l_v508_2_4.report:visibility(false);
    update_config_list_ui = 0;
    local execute_config_action = false;
    do
        local l_l_v763_0_0, l_v841_0 = update_config_list_ui, execute_config_action;
        local function v844()
            -- upvalues: l_l_v763_0_0 (ref), l_l_v508_2_4 (ref), events (ref), v844 (ref), l_v841_0 (ref)
            if l_l_v763_0_0 < globals.realtime then
                l_l_v508_2_4.report:visibility(false);
                events.render:unset(v844);
                l_v841_0 = false;
            end;
        end;
        show_config_notification = function (v845)
            -- upvalues: type (ref), l_l_v763_0_0 (ref), string_utils (ref), l_l_v508_2_4 (ref), l_v841_0 (ref), events (ref), v844 (ref)
            if type(v845) ~= "string" then
                return;
            else
                l_l_v763_0_0 = globals.realtime + 2;
                local v846 = string_utils.gsub(v845, "^[\f\a]", {
                    ["\a"] = "\aB6DE47FF\f<check>   Done!\r\n",
                    ["\f"] = "\aFF4040FF\f<xmark>   Error\r\n"
                });
                l_l_v508_2_4.report:name(v846);
                if not l_v841_0 then
                    l_l_v508_2_4.report:visibility(true);
                    events.render:set(v844);
                    l_v841_0 = true;
                end;
                return;
            end;
        end;
    end;
    update_config_list_ui = function (v847)
        -- upvalues: ui_settings (ref), next (ref), db_manager (ref), table_utils (ref), l_l_v508_2_4 (ref), ui_tabs (ref), string_utils (ref)
        if v847 ~= true then
            ui_settings.list = {};
            for v848 in next, db_manager.configs do
                ui_settings.list[#ui_settings.list + 1] = v848;
            end;
            table_utils.sort(ui_settings.list);
            table_utils.insert(ui_settings.list, 1, "Default");
            ui_settings.rlist = table_utils.copy(ui_settings.list);
            local v849 = table_utils.find(ui_settings.list, ui_settings.loaded);
            ui_settings.loadedidx = v849;
            if v849 then
                ui_settings.list[v849] = ui_settings.badge .. ui_settings.list[v849];
            else
                ui_settings.loaded = 0;
            end;
            l_l_v508_2_4.list:update(ui_settings.list);
            ui_tabs.antiaim.ab.on.sel:update(ui_settings.rlist);
        end;
        ui_settings.selected = l_l_v508_2_4.list.value;
        ui_settings.name = string_utils.gsub(ui_settings.list[ui_settings.selected] or "Default", "^" .. ui_settings.badge, "");
        l_l_v508_2_4.list:set(ui_settings.selected);
    end;
    execute_config_action = function (v850, ...)
        -- upvalues: pcall (ref), config_actions (ref), show_config_notification (ref), update_config_list_ui (ref), db_manager (ref)
        local v851, v852, v853, _ = pcall(config_actions[v850], ...);
        if v851 then
            show_config_notification(v853 or v852);
        elseif v852 then
            show_config_notification("\f" .. v852);
        end;
        update_config_list_ui();
        db_manager();
    end;
    update_config_list_ui();
    l_l_v508_2_4.list:set_callback(function ()
        -- upvalues: update_config_list_ui (ref)
        update_config_list_ui(true);
    end);
    l_l_v508_2_4.load:set_callback(function ()
        -- upvalues: execute_config_action (ref), ui_settings (ref)
        execute_config_action("load", ui_settings.name);
    end);
    l_l_v508_2_4.loadaa:set_callback(function ()
        -- upvalues: execute_config_action (ref), ui_settings (ref)
        execute_config_action("load", ui_settings.name, "antiaim");
    end);
    l_l_v508_2_4.save:set_callback(function ()
        -- upvalues: execute_config_action (ref), ui_settings (ref)
        execute_config_action("save", ui_settings.name);
    end);
    l_l_v508_2_4.export:set_callback(function ()
        -- upvalues: execute_config_action (ref), ui_settings (ref)
        execute_config_action("export", ui_settings.name);
    end);
    l_l_v508_2_4.save:depend(true, {
        [1] = nil,
        [2] = 1,
        [3] = true,
        [1] = l_l_v508_2_4.list
    });
    l_l_v508_2_4.export:depend(true, {
        [1] = nil,
        [2] = 1,
        [3] = true,
        [1] = l_l_v508_2_4.list
    });
    l_l_v508_2_4.delete:depend(true, {
        [1] = nil,
        [2] = 1,
        [3] = true,
        [1] = l_l_v508_2_4.list
    });
    local v855 = 0;
    local v856 = false;
    do
        local l_v855_0, l_v856_0 = v855, v856;
        local function v859()
            -- upvalues: l_v855_0 (ref), l_v856_0 (ref), l_l_v508_2_4 (ref), events (ref), v859 (ref)
            if l_v855_0 < globals.realtime or l_v856_0 == false then
                l_l_v508_2_4.delete:name(" \f<trash>\r ");
                events.render_ui:unset(v859);
                l_v856_0 = false;
            end;
        end;
        l_l_v508_2_4.delete:set_callback(function ()
            -- upvalues: l_v856_0 (ref), execute_config_action (ref), ui_settings (ref), l_l_v508_2_4 (ref), l_v855_0 (ref), events (ref), v859 (ref)
            if l_v856_0 then
                execute_config_action("delete", ui_settings.name);
                l_v856_0 = false;
            else
                l_l_v508_2_4.delete:name(" \ad25151ff\f<trash>\r ");
                local v860 = globals.realtime + 1;
                l_v856_0 = true;
                l_v855_0 = v860;
                events.render_ui:set(v859);
            end;
        end);
    end;
    v855 = ui_groups.home.configsnew:switch("\nconfignewstate");
    v855:visibility(false);
    do
        local l_v855_1 = v855;
        utils.execute_after(0.2, function ()
            -- upvalues: l_v855_1 (ref)
            l_v855_1:set(false);
        end);
        l_l_v508_2_4.import:set_callback(function ()
            -- upvalues: execute_config_action (ref)
            execute_config_action("import");
        end);
        l_l_v508_2_4.create:set_callback(function ()
            -- upvalues: execute_config_action (ref), l_l_v508_2_4 (ref), l_v855_1 (ref)
            execute_config_action("create", l_l_v508_2_4.name:get());
            l_l_v508_2_4.name:set("");
            l_v855_1:set(false);
        end);
        l_l_v508_2_4.new:set_callback(function ()
            -- upvalues: l_v855_1 (ref)
            l_v855_1:set(true);
        end);
        ui_elements.selectors:set_callback(function (v862)
            -- upvalues: l_v855_1 (ref)
            if v862.value ~= 2 then
                l_v855_1:set(false);
            end;
        end);
        l_l_v508_2_4.cancel:set_callback(function ()
            -- upvalues: l_v855_1 (ref), l_l_v508_2_4 (ref)
            l_v855_1:set(false);
            l_l_v508_2_4.name:set("");
        end);
        l_l_v508_2_4.new:depend({
            [1] = nil,
            [2] = false,
            [1] = l_v855_1
        });
        l_l_v508_2_4.import:depend({
            [1] = nil,
            [2] = false,
            [1] = l_v855_1
        });
        l_l_v508_2_4.load:depend({
            [1] = nil,
            [2] = false,
            [1] = l_v855_1
        });
        l_l_v508_2_4.loadaa:depend({
            [1] = nil,
            [2] = false,
            [1] = l_v855_1
        });
        l_l_v508_2_4.save:depend({
            [1] = nil,
            [2] = false,
            [1] = l_v855_1
        });
        l_l_v508_2_4.export:depend({
            [1] = nil,
            [2] = false,
            [1] = l_v855_1
        });
        l_l_v508_2_4.delete:depend({
            [1] = nil,
            [2] = false,
            [1] = l_v855_1
        });
        l_l_v508_2_4.name:depend(l_v855_1);
        l_l_v508_2_4.create:depend(l_v855_1);
        l_l_v508_2_4.cancel:depend(l_v855_1);
    end;
end;
ui_groups_settings = "BUMNWKCJQDYRLESIAFGOPXTVHZgtsjecpxylnbiuahzqforkvmdw8135269047+/=";
do
    local l_v514_3, l_l_v508_2_5, l_v757_2 = ui_groups_settings, update_stats_ui, aa_ui_elements_or_aa_runtime_state;
    l_l_v508_2_5 = {
        export = function (v866)
            -- upvalues: ui_settings (ref), string_utils (ref), sec_base64 (ref), l_v514_3 (ref)
            local v867 = ui_settings.system:save("antiaim", "builder", v866);
            local v868 = string_utils.gsub(sec_base64.encode(msgpack.pack(v867), l_v514_3), "[%+%/%=]", {
                ["="] = "_",
                ["+"] = "z113Z",
                ["/"] = "z143Z"
            });
            return (string_utils.format("hysteria::NL:builder:%s::%s", string_utils.upper(v866), v868));
        end,
        import = function (v869, v870)
            -- upvalues: type (ref), db_key (ref), string_utils (ref), sec_base64 (ref), l_v514_3 (ref), ui_settings (ref)
            if type(v870) ~= "string" or not v870 then
                v870 = db_key.get();
            end;
            if not v870 then
                return;
            else
                local v871, v872, v873, v874 = string_utils.match(v870, "hysteria::(%a+):builder:(%a+)::([%w%+%/]+)(_*)");
                if v871 ~= "NL" or not v872 or not v873 then
                    return;
                else
                    v872 = string_utils.lower(v872);
                    v874 = v874 and string_utils.rep("=", #v874) or "";
                    v873 = string_utils.gsub(v873, "z%d%d%dZ", {
                        z113Z = "+",
                        z143Z = "/"
                    });
                    v873 = sec_base64.decode(v873 .. v874, l_v514_3);
                    local v875 = {
                        antiaim = {
                            builder = {
                                [v869] = msgpack.unpack(v873).antiaim.builder[v872]
                            }
                        }
                    };
                    if v875.antiaim.builder[v869].on == nil then
                        v875.antiaim.builder[v869].on = true;
                    end;
                    ui_settings.system:load(v875, "antiaim", "builder", v869);
                    return;
                end;
            end;
        end
    };
    l_v757_2 = table_utils.distribute(aa_states.states, 1, 2);
    ui_tabs.antiaim.state.selector.copy:set_callback(function ()
        -- upvalues: l_v757_2 (ref), ui_tabs (ref), db_key (ref), l_l_v508_2_5 (ref)
        local v876 = l_v757_2[ui_tabs.antiaim.state.selector.value];
        db_key.set(l_l_v508_2_5.export(v876));
    end);
    ui_tabs.antiaim.state.selector.paste:set_callback(function ()
        -- upvalues: l_v757_2 (ref), ui_tabs (ref), l_l_v508_2_5 (ref)
        local v877 = l_v757_2[ui_tabs.antiaim.state.selector.value];
        l_l_v508_2_5.import(v877);
    end);
    ui_tabs.antiaim.state.selector.clear:set_callback(function ()
        -- upvalues: l_v757_2 (ref), ui_tabs (ref), ui_settings (ref)
        local v878 = l_v757_2[ui_tabs.antiaim.state.selector.value];
        ui_settings.system:load({
            antiaim = {
                builder = {
                    [v878] = {
                        on = v878 ~= "default" and ui_tabs.antiaim.builder[v878].on.value or nil
                    }
                }
            }
        }, "antiaim", "builder", v878);
    end);
end;
ui_groups_settings = 1;
update_stats_ui = {
    [2] = pui.get_icon("bolt"),
    [3] = pui.get_icon("vial"),
    [4] = pui.get_icon("brackets-curly")
};
aa_ui_elements_or_aa_runtime_state = {};
for v879 in string_utils.gmatch("hysteria", ".[\128-\191]*") do
    aa_ui_elements_or_aa_runtime_state[#aa_ui_elements_or_aa_runtime_state + 1] = {
        d = false,
        w = v879,
        p = {
            [1] = 0
        }
    };
end;
link_aa_builder_to_config_or_features_module_or_aa_runtime_context = table_utils.new(#aa_ui_elements_or_aa_runtime_state, 0);
aa_features = nil;
for v880 = 1, #aa_ui_elements_or_aa_runtime_state do
    local v881 = aa_ui_elements_or_aa_runtime_state[v880];
    link_aa_builder_to_config_or_features_module_or_aa_runtime_context[#link_aa_builder_to_config_or_features_module_or_aa_runtime_context + 1] = string_utils.format("\a%02x%02x%02x%02x%s", 0, 0, 0, 0, v881.w);
end;
link_aa_builder_to_config_or_features_module_or_aa_runtime_context[#link_aa_builder_to_config_or_features_module_or_aa_runtime_context + 1] = string_utils.format("\a%02x%02x%02x%02x  \226\128\162  \a%02x%02x%02x%02x%s", 0, 0, 0, 0, 0, 0, 0, 0, update_stats_ui[build_level]);
aa_features = table_utils.concat(link_aa_builder_to_config_or_features_module_or_aa_runtime_context);
pui.sidebar(aa_features, "\nempty");
do
    local l_v514_4, l_l_v508_2_6, l_v757_3, l_v761_2, l_v763_1 = ui_groups_settings, update_stats_ui, aa_ui_elements_or_aa_runtime_state, link_aa_builder_to_config_or_features_module_or_aa_runtime_context, aa_features;
    local v923 = {
        [1] = {
            p = {
                [1] = 0
            },
            work = function (v887)
                -- upvalues: anim_manager (ref), string_utils (ref), pui (ref), l_v763_1 (ref), l_v514_4 (ref)
                local v888, v889, v890, v891 = ui.get_style("Sidebar Text"):unpack();
                local v892 = anim_manager.condition(v887.p, true, 4);
                local v893 = string_utils.format("\a%02x%02x%02x%02x\f<star-christmas>", v888, v889, v890, v891 * v892);
                pui.sidebar(l_v763_1, v893);
                if v892 == 1 then
                    l_v514_4 = 2;
                end;
            end
        },
        [2] = {
            work = function (_)
                -- upvalues: l_v757_3 (ref), anim_manager (ref), l_v761_2 (ref), string_utils (ref), l_v763_1 (ref), table_utils (ref), pui (ref), l_v514_4 (ref)
                local v895 = ui.get_style("Sidebar Text");
                local v896, v897, v898, v899 = v895:unpack();
                for v900 = 1, #l_v757_3 do
                    local v901 = l_v757_3[v900];
                    v901.n = v901.n or globals.realtime + (v900 - 1) * 0.1;
                    v901.d = v901.d or globals.realtime >= v901.n;
                    local v902 = anim_manager.condition(v901.p, v901.d, 2);
                    l_v761_2[v900] = string_utils.format("\a%02x%02x%02x%02x%s", v896, v897, v898, v899 * v902, v901.w);
                end;
                l_v763_1 = table_utils.concat(l_v761_2);
                pui.sidebar(l_v763_1, string_utils.format("\a%s\f<star-christmas>", v895:to_hex()));
                if l_v757_3[#l_v757_3].p[1] == 1 then
                    l_v514_4 = 3;
                end;
            end
        },
        [3] = {
            p = {
                [1] = 0
            },
            work = function (v903)
                -- upvalues: anim_manager (ref), string_utils (ref), pui (ref), l_v763_1 (ref), l_v514_4 (ref)
                local v904 = anim_manager.condition(v903.p, true, 3);
                local v905, v906, v907, v908 = ui.get_style("Sidebar Text"):lerp(ui.get_style("Link Active"), v904):unpack();
                local v909 = string_utils.format("\a%02x%02x%02x%02x\f<star-christmas>", v905, v906, v907, v908);
                pui.sidebar(l_v763_1, v909);
                if v904 == 1 then
                    l_v514_4 = 4;
                end;
            end
        },
        [4] = {
            p = {
                [1] = 0
            },
            work = function (v910)
                -- upvalues: build_level (ref), anim_manager (ref), l_v761_2 (ref), string_utils (ref), pui (ref), l_l_v508_2_6 (ref), l_v763_1 (ref), table_utils (ref), l_v514_4 (ref)
                if build_level > 1 then
                    local v911 = anim_manager.condition(v910.p, true, 3);
                    local v912, v913, v914, v915 = ui.get_style("Link Active"):unpack();
                    local v916, v917, v918 = ui.get_style("Sidebar Text"):unpack();
                    l_v761_2[#l_v761_2] = string_utils.format("\a%02x%02x%02x%02x  \226\128\162  \a%02x%02x%02x%02x%s", v916, v917, v918, v911 * 32 * pui.alpha, v912, v913, v914, v915 * v911, l_l_v508_2_6[build_level]);
                    l_v763_1 = table_utils.concat(l_v761_2);
                    pui.sidebar(l_v763_1, "star-christmas");
                    if v911 == 1 then
                        l_v514_4 = 5;
                    end;
                else
                    l_v514_4 = 5;
                end;
            end
        },
        [5] = {
            work = function (_)
                -- upvalues: l_v763_1 (ref), build_level (ref), string_utils (ref), pui (ref), l_l_v508_2_6 (ref)
                l_v763_1 = "hysteria";
                if build_level > 1 then
                    local v920, v921, v922 = ui.get_style("Sidebar Text"):unpack();
                    l_v763_1 = string_utils.format("hysteria\a%02x%02x%02x%02x  \226\128\162  \v%s", v920, v921, v922, 32 * pui.alpha, l_l_v508_2_6[build_level]);
                end;
                pui.sidebar(l_v763_1, "\f<star-christmas>");
            end
        }
    };
    local function v924()
        -- upvalues: l_v514_4 (ref), v923 (ref), events (ref), v924 (ref)
        if l_v514_4 then
            v923[l_v514_4]:work();
        else
            events.render_ui:unset(v924);
        end;
    end;
    utils.execute_after(0.25, function ()
        -- upvalues: events (ref), v924 (ref)
        events.render_ui:set(v924);
    end);
end;
ui_groups_settings = ui_tabs.settings.accent;
update_stats_ui = ui_groups_settings:get("Rainbow")[1];
local crosshair_widget;
aa_ui_elements_or_aa_runtime_state, link_aa_builder_to_config_or_features_module_or_aa_runtime_context, aa_features, crosshair_widget = update_stats_ui:to_hsv();
do
    local l_v514_5, l_l_v508_2_7, l_v757_4, l_v761_3, l_v763_2, l_v925_0 = ui_groups_settings, update_stats_ui, aa_ui_elements_or_aa_runtime_state, link_aa_builder_to_config_or_features_module_or_aa_runtime_context, aa_features, crosshair_widget;
    events.pre_hud_render:set(function ()
        -- upvalues: l_v514_5 (ref), l_l_v508_2_7 (ref), Color (ref), l_v925_0 (ref), l_v761_3 (ref), l_v763_2 (ref)
        if l_v514_5.value[1] == "Rainbow" then
            l_l_v508_2_7 = Color():as_hsv(globals.realtime * l_v925_0 % 1, l_v761_3, l_v763_2, l_v925_0);
            l_v514_5:set("Rainbow", {
                [1] = l_l_v508_2_7
            });
        end;
    end);
    l_v514_5:set_callback(function (v932)
        -- upvalues: events (ref), l_v514_5 (ref), colors (ref), l_l_v508_2_7 (ref), l_v757_4 (ref), l_v761_3 (ref), l_v763_2 (ref), l_v925_0 (ref), string_utils (ref), ui_elements (ref), pui (ref)
        local v933 = v932.value[1];
        events.accent_settings_change:call(v932);
        if v933 == "Solid" then
            l_v514_5:set("Solid", {
                v932.value[2]:alpha_modulate(255)
            });
            local l_v184_0 = colors;
            local l_v184_1 = colors;
            local v936 = v932.value[2];
            l_v184_1.secondary = v932.value[2];
            l_v184_0.accent = v936;
        elseif v933 == "Gradient" then
            local l_v184_2 = colors;
            local l_v184_3 = colors;
            local v939 = v932.value[2][1];
            l_v184_3.secondary = v932.value[2][2];
            l_v184_2.accent = v939;
        elseif v933 == "Rainbow" then
            if l_v514_5.value[2] ~= l_l_v508_2_7 then
                local v940, v941, v942, v943 = l_v514_5.value[2]:to_hsv();
                l_v925_0 = v943;
                l_v763_2 = v942;
                l_v761_3 = v941;
                l_v757_4 = v940;
            end;
            local l_v184_4 = colors;
            local l_v184_5 = colors;
            local v946 = v932.value[2];
            l_v184_5.secondary = v932.value[2];
            l_v184_4.accent = v946;
        end;
        local l_accent_1 = colors.accent;
        local l_secondary_0 = colors.secondary;
        local v949 = 255;
        l_secondary_0.a = 255;
        l_accent_1.a = v949;
        l_accent_1 = colors;
        l_secondary_0 = colors;
        v949 = "\a" .. colors.accent:to_hex();
        l_secondary_0.hex2 = "\a" .. colors.secondary:to_hex();
        l_accent_1.hex = v949;
        l_accent_1 = colors;
        l_secondary_0 = colors;
        v949 = string_utils.sub(colors.hex, 0, -3);
        l_secondary_0.hex2s = string_utils.sub(colors.hex2, 0, -3);
        l_accent_1.hexs = v949;
        if ui_elements.butterfly and pui.alpha > 0 then
            ui_elements.butterfly:set(nil, colors.accent);
        end;
    end, true);
    if ui_elements.butterfly then
        ui_elements.butterfly:set(nil, colors.accent);
    end;
end;
ui_tabs.settings.style.blur:set_callback(function (v950)
    -- upvalues: render_proxy (ref)
    render_proxy.cheap = not v950.value;
end, true);
ui_tabs.settings.style.mode:set_callback(function (v951)
    -- upvalues: render_proxy (ref), events (ref)
    render_proxy.style = v951.value;
    events.style_changed:call(v951.value);
end, true);
events.pre_render_native:set(function ()
    -- upvalues: render_proxy (ref), ui_tabs (ref)
    render_proxy.dpi_t.callback(ui_tabs.settings.style.dpi.value);
end);
menu_items.global.menu_scale:set_callback(function ()
    -- upvalues: ui_elements (ref), Vector (ref), render_proxy (ref)
    utils.execute_after(0.5, function ()
        -- upvalues: ui_elements (ref), Vector (ref), render_proxy (ref)
        if ui_elements.butterfly then
            ui_elements.butterfly:set(Vector(270, 270) * render_proxy.get_scale(1));
        end;
    end);
end, true);
if build_level < 2 then
    ui_helpers.lock(ui_tabs.settings.aipeek);
    ui_helpers.lock(ui_tabs.settings.dormant);
    ui_helpers.lock(ui_tabs.settings.cross, 0);
    ui_helpers.lock(ui_tabs.antiaim.general.head.smart);
    ui_helpers.lock(ui_tabs.antiaim.general.nature);
    ui_helpers.lock(ui_tabs.antiaim.snaps.edge.on, "Off");
end;
ui_groups_settings = nil;
update_stats_ui = nil;
aa_ui_elements_or_aa_runtime_state = {
    statew = 0,
    stateb = 1,
    switch = false,
    state = 1,
    send_packet = false,
    counter = 0,
    sent = 0,
    states_record = {}
};
link_aa_builder_to_config_or_features_module_or_aa_runtime_context = {
    mod = 0,
    des = 0,
    yaw = 0,
    pitch = 89
};
aa_features = {};
crosshair_widget = nil;
local widgets_manager = {
    pitch = menu_items.antiaim.angles.pitch,
    yaw_type = menu_items.antiaim.angles.yaw,
    yaw_base = menu_items.antiaim.angles.yaw.base,
    yaw = menu_items.antiaim.angles.yaw.offset,
    avoid_bs = menu_items.antiaim.angles.yaw.avoid_bs,
    hidden = menu_items.antiaim.angles.yaw.hidden,
    modifier = menu_items.antiaim.angles.modifier,
    mod_deg = menu_items.antiaim.angles.modifier.offset,
    body_yaw = menu_items.antiaim.angles.body,
    inverter = menu_items.antiaim.angles.body.invert,
    left = menu_items.antiaim.angles.body.left,
    right = menu_items.antiaim.angles.body.right,
    options = menu_items.antiaim.angles.body.options,
    desync_fs = menu_items.antiaim.angles.body.freestand,
    freestand = menu_items.antiaim.angles.freestand,
    extended = menu_items.antiaim.angles.extended,
    fl_enable = menu_items.antiaim.fl.enable,
    fl_limit = menu_items.antiaim.fl.limit,
    fl_var = menu_items.antiaim.fl.var
};
local widget_instance = {};
for cvar_key, cvar_ref in next, widgets_manager do
    widget_instance[#widget_instance + 1] = {
        [1] = cvar_key,
        [2] = cvar_ref
    };
end;
crosshair_widget = setmetatable({
    list = widgets_manager,
    keys = widget_instance,
    n = #widget_instance
}, {
    __index = widgets_manager
});
widgets_manager = nil;
widget_instance = 0;
do
    local l_l_v508_2_8, l_v757_5, l_v761_4, l_v763_3, l_v925_1, l_v953_0 = update_stats_ui, aa_ui_elements_or_aa_runtime_state, link_aa_builder_to_config_or_features_module_or_aa_runtime_context, aa_features, crosshair_widget, widget_instance;
    do
        local l_l_v953_0_0 = l_v953_0;
        widgets_manager = {
            force_lc = function (ticks_to_wait)
                -- upvalues: math_utils (ref), l_l_v953_0_0 (ref), l_l_v508_2_8 (ref)
                if math_utils.abs(l_l_v953_0_0 - globals.tickcount) >= (ticks_to_wait or 12) then
                    local l_l_l_v508_2_8_0 = l_l_v508_2_8;
                    local v965 = true;
                    l_l_v953_0_0 = globals.tickcount;
                    l_l_l_v508_2_8_0.force_defensive = v965;
                end;
            end
        };
    end;
    l_v953_0 = {};
    l_v953_0.override = function (state_id_to_override, force_override)
        -- upvalues: l_v953_0 (ref), l_v757_5 (ref), game_data (ref)
        local state_config = l_v953_0[0][state_id_to_override];
        if state_config and (force_override or state_config.override) then
            local l_l_v953_0_1 = l_v953_0;
            local l_l_v757_5_0 = l_v757_5;
            local l_v968_0 = state_config;
            l_l_v757_5_0.stateb = game_data.states[state_id_to_override];
            l_l_v953_0_1.cur = l_v968_0;
            return true;
        else
            return false;
        end;
    end;
    local update_aa_state_and_conditions = nil;
    local get_current_aa_state_func = {
        [false] = function ()
            -- upvalues: local_player (ref), game_data (ref)
            if not local_player.jumping then
                if local_player.duck_amount > 0 then
                    return local_player.velocity > 5 and game_data.states.sneak or game_data.states.crouch;
                elseif local_player.velocity > 5 then
                    return local_player.walking and game_data.states.walk or game_data.states.run;
                else
                    return game_data.states.stand;
                end;
            else
                return local_player.duck_amount > 0 and game_data.states.airc or game_data.states.air;
            end;
        end,
        [true] = function ()
            -- upvalues: local_player (ref), game_data (ref), math_utils (ref)
            local l_landing_0 = local_player.animstate.landing;
            local l_anim_duck_amount_0 = local_player.animstate.anim_duck_amount;
            local v975 = 1 - local_player.animstate.in_air_smooth_value;
            local l_move_weight_0 = local_player.animstate.move_weight;
            local l_walk_run_transition_0 = local_player.animstate.walk_run_transition;
            local l_walk_to_run_transition_state_0 = local_player.animstate.walk_to_run_transition_state;
            local l_speed_as_portion_of_walk_top_speed_0 = local_player.animstate.speed_as_portion_of_walk_top_speed;
            local l_stand_0 = game_data.states.stand;
            local l_crouch_0 = game_data.states.crouch;
            local l_l_anim_duck_amount_0_0 = l_anim_duck_amount_0;
            if l_move_weight_0 > 0.01 then
                l_l_anim_duck_amount_0_0 = l_move_weight_0;
                l_crouch_0 = local_player.walking and game_data.states.walk or game_data.states.run;
                if (l_walk_run_transition_0 > 0 or l_move_weight_0 < l_speed_as_portion_of_walk_top_speed_0) and local_player.walking then
                    local v983 = (l_move_weight_0 - 0.621) * 2.635;
                    local l_run_0 = game_data.states.run;
                    l_l_anim_duck_amount_0_0 = 1 - v983;
                    l_stand_0 = l_run_0;
                elseif local_player.walking and not l_walk_to_run_transition_state_0 then
                    l_stand_0 = game_data.states.walk;
                end;
                if l_anim_duck_amount_0 > 0 then
                    local l_sneak_0 = game_data.states.sneak;
                    l_l_anim_duck_amount_0_0 = (1 - l_anim_duck_amount_0) * l_move_weight_0;
                    l_stand_0 = l_sneak_0;
                end;
            end;
            if v975 > 0 then
                if v975 < 1 then
                    local v986 = l_anim_duck_amount_0 > 0 and game_data.states.airc or game_data.states.air;
                    l_l_anim_duck_amount_0_0 = v975;
                    l_crouch_0 = v986;
                else
                    local l_air_0 = game_data.states.air;
                    local l_airc_0 = game_data.states.airc;
                    l_l_anim_duck_amount_0_0 = l_anim_duck_amount_0;
                    l_crouch_0 = l_airc_0;
                    l_stand_0 = l_air_0;
                end;
            end;
            if l_landing_0 then
                l_l_anim_duck_amount_0_0 = l_l_anim_duck_amount_0_0 * (1 - l_anim_duck_amount_0);
            end;
            return l_stand_0, l_crouch_0, (math_utils.tolerate(math_utils.clamp(l_l_anim_duck_amount_0_0, 0, 1), 0.05));
        end
    };
    local aa_state_processor = {
        select = function (all_state_configs, current_state_id)
            -- upvalues: local_player (ref), game_data (ref), aa_states (ref)
            if all_state_configs.fakelag.override and local_player.exploit.active == game_data.exploit.OFF then
                current_state_id = game_data.states.fakelag;
            elseif not all_state_configs.airc.override and current_state_id == game_data.states.airc then
                current_state_id = game_data.states.air;
            elseif not all_state_configs.sneak.override and current_state_id == game_data.states.sneak then
                current_state_id = game_data.states.crouch;
            end;
            if not all_state_configs[aa_states.states[current_state_id][1]].override or not current_state_id then
                current_state_id = game_data.states.default;
            end;
            return all_state_configs[aa_states.states[current_state_id][1]];
        end,
        work = function (builder_processor)
            -- upvalues: config_builder (ref), l_v953_0 (ref), l_v757_5 (ref)
            local l_custom_0 = config_builder.builder.custom;
            l_v953_0 = {
                [0] = l_custom_0,
                cur = builder_processor.select(l_custom_0, l_v757_5.state),
                next = l_v757_5.stateb and builder_processor.select(l_custom_0, l_v757_5.stateb)
            };
        end
    };
    local function process_defensive_snap()
        -- upvalues: l_v953_0 (ref), ui_tabs (ref), local_player (ref), game_data (ref), config_builder (ref), l_v757_5 (ref), aa_states (ref)
        l_v953_0.snap = nil;
        if not ui_tabs.antiaim.def.snap.value then
            return;
        elseif local_player.exploit.active == game_data.exploit.OS and not ui_tabs.antiaim.def.snap.os.value then
            return;
        else
            local snap_config_set = nil;
            local config_index = 0;
            local l_default_0 = game_data.snaps.default;
            if config_index == 0 then
                snap_config_set = config_builder.snap.custom;
            else
                snap_config_set = config_builder.snap[config_index];
            end;
            if snap_config_set.airc.on ~= "Default" and local_player.jumping and local_player.crouching then
                l_default_0 = game_data.snaps.airc;
            elseif snap_config_set.air.on ~= "Default" and local_player.jumping then
                l_default_0 = game_data.snaps.air;
            elseif snap_config_set.edge.on ~= "Default" and l_v757_5.freestand_raw and not local_player.jumping then
                l_default_0 = game_data.snaps.edge;
            elseif snap_config_set.sneak.on ~= "Default" and local_player.on_ground and local_player.crouching and local_player.velocity > 5 then
                l_default_0 = game_data.snaps.sneak;
            elseif snap_config_set.crouch.on ~= "Default" and local_player.on_ground and local_player.crouching then
                l_default_0 = game_data.snaps.crouch;
            elseif snap_config_set.walk.on ~= "Default" and local_player.on_ground and local_player.walking then
                l_default_0 = game_data.snaps.walk;
            end;
            local active_snap_config = snap_config_set[aa_states.snaps[l_default_0][1]];
            if active_snap_config.on == "Off" then
                return;
            else
                if active_snap_config.on ~= "Custom" or not l_default_0 then
                    l_default_0 = game_data.snaps.default;
                end;
                active_snap_config = snap_config_set[aa_states.snaps[l_default_0][1]];
                if active_snap_config and active_snap_config.on ~= "Off" then
                    l_v953_0.snap = active_snap_config;
                end;
                return;
            end;
        end;
    end;
    local function update_aa_angles_and_targets()
        -- upvalues: l_v757_5 (ref), render_proxy (ref), local_player (ref), math_utils (ref)
        l_v757_5.camera_ang = render_proxy.camera_angles();
        local threat_origin = local_player.threat and local_player.threat:get_origin();
        l_v757_5.threat_ang = threat_origin and math_utils.angle_to(local_player.origin, threat_origin) or nil;
        l_v757_5.threat_ang_raw = rage.antiaim:get_target();
        l_v757_5.freestand_raw = rage.antiaim:get_target(true);
        l_v757_5.threat_dist = threat_origin and math_utils.dist(local_player.origin, threat_origin);
    end;
    local log_aa_state_graph = nil;
    local aa_state_to_graph_value_map = {
        [game_data.states.crouch] = 0,
        [game_data.states.sneak] = 1,
        [game_data.states.stand] = 2,
        [game_data.states.walk] = 3,
        [game_data.states.run] = 4,
        [game_data.states.airc] = 5,
        [game_data.states.air] = 6
    };
    do
        local l_v1003_0 = aa_state_to_graph_value_map;
        log_aa_state_graph = function (base_state, target_state, interpolation_factor)
            -- upvalues: ui_tabs (ref), l_v1003_0 (ref), math_utils (ref), table_utils (ref), ui_groups_settings (ref)
            if not ui_tabs.settings.process.graph.value then
                return;
            else
                local v1008 = target_state or base_state;
                if not interpolation_factor then
                    interpolation_factor = 0;
                end;
                target_state = v1008;
                v1008 = l_v1003_0;
                local v1009 = v1008[base_state] or base_state;
                local v1010 = v1008[target_state];
                if v1010 then
                    target_state = v1010;
                end;
                v1009 = math_utils.clamp(math_utils.lerp(v1009, target_state, interpolation_factor) / 7, 0, 1);
                if v1009 then
                    table_utils.slide(ui_groups_settings.data.states_record, v1009, 10);
                end;
                return;
            end;
        end;
    end;
    do
        local l_v989_0, l_v994_0, l_v999_0, l_v1001_0, l_v1002_0 = get_current_aa_state_func, aa_state_processor, process_defensive_snap, update_aa_angles_and_targets, log_aa_state_graph;
        update_aa_state_and_conditions = function ()
            -- upvalues: l_v757_5 (ref), l_l_v508_2_8 (ref), l_v989_0 (ref), ui_tabs (ref), l_v1001_0 (ref), l_v994_0 (ref), l_v999_0 (ref), l_v1002_0 (ref)
            l_v757_5.send_packet = l_l_v508_2_8.choked_commands == 0;
            local l_l_v757_5_1 = l_v757_5;
            local l_l_v757_5_2 = l_v757_5;
            local l_l_v757_5_3 = l_v757_5;
            local v1019, v1020, v1021 = l_v989_0[ui_tabs.antiaim.general.nature.value]();
            l_l_v757_5_3.statew = v1021;
            l_l_v757_5_2.stateb = v1020;
            l_l_v757_5_1.state = v1019;
            l_v757_5.inverted = ui_tabs.antiaim.buttons.invert.value;
            l_v1001_0();
            l_v994_0:work();
            l_v999_0();
            l_v1002_0(l_v757_5.state, l_v757_5.stateb, l_v757_5.statew);
        end;
        aa_state_to_graph_value_map = 0;
        local v1022 = 0;
        do
            local l_v1003_1, l_v1022_0 = aa_state_to_graph_value_map, v1022;
            events.player_hurt:set(function (v1025)
                -- upvalues: local_player (ref), l_v1022_0 (ref)
                if v1025.userid == local_player.userid then
                    l_v1022_0 = globals.tickcount;
                end;
            end);
            events.bullet_impact:set(function (v1026)
                -- upvalues: local_player (ref), l_v1003_1 (ref), Vector (ref), math_utils (ref), unpack (ref), l_v757_5 (ref), events (ref), l_v1022_0 (ref)
                if not local_player.valid or l_v1003_1 == globals.tickcount then
                    return;
                else
                    local v1027 = entity.get(v1026.userid, true);
                    if not v1027 or not v1027:is_enemy() or v1027:is_dormant() then
                        return;
                    else
                        local v1028 = Vector(v1026.x, v1026.y, v1026.z);
                        local v1029 = v1027:get_eye_position();
                        local v1030 = {};
                        local v1031 = entity.get_players(false, false);
                        for v1032 = 1, #v1031 do
                            local v1033 = v1031[v1032];
                            if not v1033:is_enemy() then
                                local v1034 = v1033:get_origin() + Vector(0, 0, 36);
                                local v1035 = v1034:closest_ray_point(v1029, v1028);
                                v1030[v1033 == local_player.self and 0 or #v1030 + 1] = v1034:dist(v1035);
                            end;
                        end;
                        if v1030[0] and (#v1030 == 0 or v1030[0] < math_utils.min(unpack(v1030))) and v1030[0] < 80 then
                            local v1036 = l_v757_5.statew and l_v757_5.statew > 0.5 and l_v757_5.stateb or l_v757_5.state;
                            do
                                local l_v1036_0 = v1036;
                                utils.execute_after(to_time(1), function ()
                                    -- upvalues: events (ref), l_v1003_1 (ref), l_v1022_0 (ref), v1030 (ref), v1027 (ref), v1026 (ref), l_v1036_0 (ref)
                                    events.enemy_shot:call({
                                        damaged = l_v1003_1 == l_v1022_0,
                                        dist = v1030[0],
                                        attacker = v1027,
                                        userid = v1026.userid,
                                        last_state = l_v1036_0
                                    });
                                end);
                                l_v1003_1 = globals.tickcount;
                            end;
                        end;
                        return;
                    end;
                end;
            end);
        end;
    end;
    get_current_aa_state_func = nil;
    aa_state_processor = {
        buttons = {
            manual = {
                Forward = 180,
                Right = 90,
                Left = -90
            },
            edge = function ()
                -- upvalues: local_player (ref), Vector (ref), l_v757_5 (ref), math_utils (ref)
                local v1038 = 1;
                local v1039 = nil;
                local v1040 = {};
                for v1041 = -180, 179, 45 do
                    local v1042 = local_player.eyes + Vector():angles(Vector(0, v1041, 0)) * 24;
                    local v1043 = utils.trace_line(local_player.eyes, v1042, local_player.self);
                    if v1043.fraction < v1038 and (v1043.entity == nil or not v1043.entity:is_player()) then
                        local l_fraction_0 = v1043.fraction;
                        v1039 = v1041;
                        v1038 = l_fraction_0;
                    end;
                end;
                if v1039 == nil then
                    return;
                else
                    for v1045 = v1039 - 30, v1039 + 30, 10 do
                        local v1046 = local_player.eyes + Vector():angles(Vector(0, v1045, 0)) * 24;
                        local v1047 = utils.trace_line(local_player.eyes, v1046, local_player.self);
                        if v1047.fraction < 1 then
                            v1040[#v1040 + 1] = v1045;
                            if v1047.fraction < v1038 then
                                local l_fraction_1 = v1047.fraction;
                                v1039 = v1045;
                                v1038 = l_fraction_1;
                            end;
                        end;
                    end;
                    local v1049 = v1039 * 2 - l_v757_5.camera_ang.y;
                    return math_utils.normalize_yaw(v1049);
                end;
            end
        },
        work = function (button_logic_handler)
            -- upvalues: l_v761_4 (ref), l_v757_5 (ref), ui_tabs (ref), local_player (ref), l_v763_3 (ref)
            l_v761_4.yaw = 0;
            local l_l_v757_5_4 = l_v757_5;
            local l_l_v757_5_5 = l_v757_5;
            local l_l_v757_5_6 = l_v757_5;
            local v1054 = nil;
            local v1055 = nil;
            l_l_v757_5_6.edge = nil;
            l_l_v757_5_5.freestand = v1055;
            l_l_v757_5_4.manual_yaw = v1054;
            l_l_v757_5_4 = ui_tabs.antiaim.buttons;
            l_l_v757_5_5 = button_logic_handler.buttons.manual[l_l_v757_5_4.manual.value];
            l_l_v757_5_6 = l_l_v757_5_4.fs.value and not local_player.jumping;
            v1054 = l_l_v757_5_4.edge.value;
            l_v761_4.fs = false;
            l_v763_3.selected_yaw = l_v757_5.threat_ang_raw or l_v757_5.camera_ang.y;
            if l_l_v757_5_5 then
                v1055 = l_v761_4;
                local l_l_v757_5_7 = l_v757_5;
                local l_l_l_v757_5_5_0 = l_l_v757_5_5;
                l_l_v757_5_7.manual_yaw = l_l_v757_5_5;
                v1055.yaw = l_l_l_v757_5_5_0;
                l_v763_3.force_camera = true;
                if l_l_v757_5_4.manual.s.value then
                    v1055 = l_v763_3;
                    l_l_v757_5_7 = l_v763_3;
                    l_l_l_v757_5_5_0 = l_v763_3;
                    local v1058 = true;
                    local v1059 = true;
                    l_l_l_v757_5_5_0.force_desync = l_v757_5.inverted and 60 or -60;
                    l_l_v757_5_7.no_offset = v1059;
                    v1055.no_modifier = v1058;
                end;
                l_v763_3.selected_yaw = l_v761_4.yaw + l_v757_5.camera_ang.y;
            elseif l_l_v757_5_6 then
                v1055 = l_v761_4;
                local l_l_v757_5_8 = l_v757_5;
                local v1061 = true;
                l_l_v757_5_8.freestand = l_v757_5.freestand_raw;
                v1055.fs = v1061;
                if l_v757_5.freestand then
                    if l_l_v757_5_4.fs.s.value then
                        v1055 = l_v763_3;
                        l_l_v757_5_8 = l_v763_3;
                        v1061 = l_v763_3;
                        local v1062 = true;
                        local v1063 = true;
                        v1061.force_desync = l_v757_5.inverted and 60 or -60;
                        l_l_v757_5_8.no_offset = v1063;
                        v1055.no_modifier = v1062;
                    end;
                    l_v763_3.selected_yaw = l_v757_5.freestand;
                end;
            elseif v1054 then
                v1055 = button_logic_handler.buttons.edge();
                if v1055 then
                    l_v763_3.force_static = true;
                    local l_l_v761_4_0 = l_v761_4;
                    local l_l_v757_5_9 = l_v757_5;
                    local l_v1055_0 = v1055;
                    l_l_v757_5_9.edge = v1055;
                    l_l_v761_4_0.yaw = l_v1055_0;
                    l_v763_3.selected_yaw = v1055;
                    if l_l_v757_5_4.edge.s.value then
                        l_l_v761_4_0 = l_v763_3;
                        l_l_v757_5_9 = l_v763_3;
                        l_v1055_0 = l_v763_3;
                        local v1067 = true;
                        local v1068 = true;
                        l_v1055_0.force_desync = l_v757_5.inverted and 60 or -60;
                        l_l_v757_5_9.no_offset = v1068;
                        l_l_v761_4_0.no_modifier = v1067;
                    end;
                end;
            end;
        end
    };
    process_defensive_snap = {
        gsequence = {
            [1] = -1,
            [2] = 1,
            [3] = 0,
            [4] = -1,
            [5] = 1,
            [6] = 0,
            [7] = -1,
            [8] = 0,
            [9] = 1,
            [10] = -1,
            [11] = 0,
            [12] = 1
        },
        type = {
            Jitter = function (modifier_config)
                -- upvalues: l_v757_5 (ref)
                return ((modifier_config.mid and l_v757_5.sent or l_v757_5.counter) % 2 == 0 and modifier_config.deg or -modifier_config.deg) + l_v757_5.abweight * 10;
            end,
            Ways = function (modifier_config_ways)
                -- upvalues: l_v757_5 (ref), math_utils (ref)
                local v1071 = (modifier_config_ways.mid and l_v757_5.sent or l_v757_5.counter) % modifier_config_ways.ways / (modifier_config_ways.ways - 1);
                return math_utils.lerp(-modifier_config_ways.deg, modifier_config_ways.deg, v1071);
            end,
            ["Shuffle ways"] = function (modifier_config_shuffle)
                -- upvalues: math_utils (ref)
                local v1073 = math_utils.random(0, modifier_config_shuffle.ways) / modifier_config_shuffle.ways;
                return math_utils.lerp(-modifier_config_shuffle.deg, modifier_config_shuffle.deg, v1073);
            end,
            Skitter = function (modifier_config_skitter, modifier_handler_table)
                -- upvalues: math_utils (ref), l_v757_5 (ref), l_v953_0 (ref), l_v763_3 (ref)
                local l_gsequence_0 = modifier_handler_table.gsequence;
                local v1077 = l_gsequence_0[math_utils.cycle(modifier_config_skitter.mid and l_v757_5.sent or l_v757_5.counter, #l_gsequence_0)];
                local v1078 = v1077 * modifier_config_skitter.deg * 2;
                local l_des_0 = l_v953_0.cur.des;
                if l_des_0.mode == "Jitter" and l_v763_3.force_desync == nil then
                    l_v763_3.force_desync = v1077 > 0 and l_des_0.l or v1077 < 0 and -l_des_0.r or v1077 == 0 and 0;
                end;
                return v1078;
            end,
            Rotate = function (modifier_config_rotate)
                -- upvalues: math_utils (ref)
                return math_utils.lerp(-modifier_config_rotate.deg, modifier_config_rotate.deg, globals.curtime * 4 % 1);
            end,
            Random = function (modifier_config_random)
                return utils.random_int(-modifier_config_random.deg, modifier_config_random.deg);
            end
        },
        work = function (modifier_processor)
            -- upvalues: l_v761_4 (ref), l_v953_0 (ref), l_v757_5 (ref)
            l_v761_4.mod = 0;
            local l_mod_0 = l_v953_0.cur.mod;
            if l_mod_0 then
                local v1084 = modifier_processor.type[l_mod_0.type];
                l_v761_4.mod = l_v761_4.mod + (v1084 and v1084(l_mod_0, modifier_processor) or 0);
                local v1085 = l_v953_0.cur.random * 0.5;
                l_v761_4.mod = l_v761_4.mod + (v1085 > 0 and utils.random_int(-v1085, v1085) or 0);
                l_v761_4.mod = l_v761_4.mod + l_v757_5.abweight * -10;
            end;
        end
    };
    update_aa_angles_and_targets = {
        type = {
            Static = function (desync_config_static)
                -- upvalues: are_not_equal (ref), l_v757_5 (ref), l_v953_0 (ref)
                return are_not_equal(l_v757_5.inverted, l_v953_0.cur.des.inv) and desync_config_static.r or -desync_config_static.l;
            end,
            Jitter = function (desync_config_jitter)
                -- upvalues: l_v757_5 (ref)
                return l_v757_5.switch and desync_config_jitter.r or -desync_config_jitter.l;
            end,
            Random = function (desync_config_random)
                -- upvalues: math_utils (ref)
                return math_utils.random() > 0.5 and desync_config_random.r or -desync_config_random.l;
            end
        },
        work = function (desync_processor)
            -- upvalues: l_v761_4 (ref), l_v953_0 (ref)
            local l_l_v761_4_1 = l_v761_4;
            local l_l_v761_4_2 = l_v761_4;
            local l_l_v761_4_3 = l_v761_4;
            local v1093 = nil;
            local v1094 = "Off";
            l_l_v761_4_3.deso = {};
            l_l_v761_4_2.desfs = v1094;
            l_l_v761_4_1.des = v1093;
            l_l_v761_4_1 = l_v953_0.cur.des;
            if desync_processor.type[l_l_v761_4_1.mode] then
                l_v761_4.des = desync_processor.type[l_l_v761_4_1.mode](l_l_v761_4_1);
                l_v761_4.desfs = l_l_v761_4_1.fs;
                l_v761_4.deso = l_l_v761_4_1.ao and {
                    [1] = "Avoid Overlap"
                } or l_v761_4.deso;
            end;
        end
    };
    log_aa_state_graph = {
        data = {
            counter = 0,
            ticks = 0,
            once = {}
        },
        pitch = {
            Static = function (_, snap_pitch_config_static)
                return snap_pitch_config_static.ang;
            end,
            Jitter = function (_, snap_pitch_config_jitter)
                -- upvalues: l_v757_5 (ref)
                return l_v757_5.switch and snap_pitch_config_jitter.ang or snap_pitch_config_jitter.ang2;
            end,
            Random = function (_, snap_pitch_config_random)
                return utils.random_int(snap_pitch_config_random.ang, snap_pitch_config_random.ang2);
            end,
            ["Random Static"] = function (snap_data_storage, snap_pitch_config_random_static)
                if not snap_data_storage.once.srx then
                    snap_data_storage.once.srx = utils.random_int(snap_pitch_config_random_static.ang, snap_pitch_config_random_static.ang2);
                end;
                return snap_data_storage.once.srx;
            end,
            Spin = function (_, snap_pitch_config_spin)
                -- upvalues: math_utils (ref)
                return math_utils.lerp(snap_pitch_config_spin.ang, snap_pitch_config_spin.ang2, globals.curtime * snap_pitch_config_spin.speed * 0.1 % 1);
            end,
            ["Spin Full"] = function (snap_data_storage_spin_full, snap_pitch_config_spin_full)
                -- upvalues: math_utils (ref), l_v953_0 (ref), local_player (ref)
                local v1107 = math_utils.min(snap_data_storage_spin_full.once.apex, l_v953_0.snap.time);
                local v1108 = snap_data_storage_spin_full.once.apex - (v1107 - 1);
                local v1109 = (local_player.exploit.lc_left - v1108) / (v1107 - 1);
                return math_utils.lerp(snap_pitch_config_spin_full.ang, snap_pitch_config_spin_full.ang2, v1109);
            end,
            Camera = function (_, _)
                -- upvalues: l_v757_5 (ref)
                return l_v757_5.camera_ang and l_v757_5.camera_ang.x or 0;
            end,
            ["At target"] = function (_, _)
                -- upvalues: l_v757_5 (ref)
                return l_v757_5.threat_ang and l_v757_5.threat_ang.x or l_v757_5.camera_ang.x;
            end
        },
        yaw = {
            Static = function (_, snap_yaw_config_static)
                return 360 - snap_yaw_config_static.ang;
            end,
            Jitter = function (snap_data_storage_jitter, snap_yaw_config_jitter)
                return 180 + snap_yaw_config_jitter.ang * (snap_data_storage_jitter.once.switch and 0.5 or -0.5);
            end,
            Random = function (_, snap_yaw_config_random)
                return 180 + utils.random_int(snap_yaw_config_random.ang * -0.5, snap_yaw_config_random.ang * 0.5);
            end,
            ["Random Jitter"] = function (_, snap_yaw_config_random_jitter)
                -- upvalues: math_utils (ref)
                local v1122 = math_utils.random(0, 1) == 0 and 1 or -1;
                local v1123 = math_utils.random(snap_yaw_config_random_jitter.ang * -0.25, snap_yaw_config_random_jitter.ang * 0.25);
                return v1122 * 90 + v1123;
            end,
            ["Random Static"] = function (snap_data_storage_random_static, snap_yaw_config_random_static)
                -- upvalues: math_utils (ref)
                if not snap_data_storage_random_static.once.sry then
                    snap_data_storage_random_static.once.sry = math_utils.random(snap_yaw_config_random_static.ang * -0.5, snap_yaw_config_random_static.ang * 0.5);
                end;
                return 180 + snap_data_storage_random_static.once.sry;
            end,
            Spin = function (_, snap_yaw_config_spin)
                -- upvalues: math_utils (ref)
                return 180 + math_utils.lerp(snap_yaw_config_spin.ang * -0.5, snap_yaw_config_spin.ang * 0.5, globals.curtime * (snap_yaw_config_spin.speed * 0.1) % 1), true;
            end,
            ["Spin Full"] = function (snap_data_storage_spin_full, snap_yaw_config_spin_full)
                -- upvalues: math_utils (ref), l_v953_0 (ref), local_player (ref)
                local v1130 = math_utils.min(snap_data_storage_spin_full.once.apex, l_v953_0.snap.time);
                local v1131 = snap_data_storage_spin_full.once.apex - (v1130 - 1);
                local v1132 = (local_player.exploit.lc_left - v1131) / (v1130 - 1);
                return 180 + math_utils.lerp(snap_yaw_config_spin_full.ang * -0.5, snap_yaw_config_spin_full.ang * 0.5, v1132);
            end,
            ["Spin Jitter"] = function (snap_data_storage_spin_jitter, snap_yaw_config_spin_jitter)
                -- upvalues: math_utils (ref)
                local v1135 = snap_data_storage_spin_jitter.once.switch and 1 or -1;
                local v1136 = math_utils.lerp(snap_yaw_config_spin_jitter.ang * -0.5, snap_yaw_config_spin_jitter.ang * 0.5, globals.curtime * (snap_yaw_config_spin_jitter.speed * 0.1) % 1);
                return v1135 * 90 + v1136;
            end,
            ["90w"] = function (snap_data_storage_90w, snap_yaw_config_90w)
                -- upvalues: math_utils (ref), local_player (ref), l_v953_0 (ref)
                local v1139 = snap_data_storage_90w.counter % 2 == 0 and 1 or -1;
                local v1140 = math_utils.lerp(snap_yaw_config_90w.ang * -0.5, snap_yaw_config_90w.ang * 0.5, local_player.exploit.lc_left / l_v953_0.snap.time * snap_yaw_config_90w.speed * 0.05 % 1);
                return v1139 * 90 + v1140 - 90, true;
            end,
            ["180v"] = function (_, snap_yaw_config_180v)
                -- upvalues: math_utils (ref)
                local v1143 = math_utils.sin(globals.curtime * (snap_yaw_config_180v.speed * 0.2)) * 0.5 + 0.5;
                return 180 + math_utils.lerp(snap_yaw_config_180v.ang * -0.5, snap_yaw_config_180v.ang * 0.5, v1143), true;
            end,
            Camera = function (_, snap_yaw_config_camera)
                -- upvalues: l_v757_5 (ref)
                return (l_v757_5.camera_ang and l_v757_5.camera_ang.y or 0) - snap_yaw_config_camera.ang + 180;
            end,
            ["At target"] = function (_, snap_yaw_config_at_target)
                -- upvalues: l_v757_5 (ref), l_v761_4 (ref)
                local v1148 = l_v757_5.threat_ang or l_v757_5.camera_ang;
                return (v1148 and v1148.y or 0) - l_v761_4.yaw - snap_yaw_config_at_target.ang + 180;
            end,
            Opposite = function (_, _)
                -- upvalues: l_v757_5 (ref), l_v763_3 (ref)
                if not l_v757_5.freestand_raw then
                    return;
                else
                    local l_selected_yaw_0 = l_v763_3.selected_yaw;
                    if l_v757_5.freestand then
                        return 180;
                    else
                        if l_v757_5.edge then
                            l_selected_yaw_0 = l_v757_5.camera_ang.y;
                        end;
                        return l_v757_5.freestand_raw - l_selected_yaw_0;
                    end;
                end;
            end
        },
        snap = function (snap_logic_handler)
            -- upvalues: l_v761_4 (ref), l_v953_0 (ref), l_v757_5 (ref), local_player (ref), l_v763_3 (ref), table_utils (ref)
            l_v761_4.snap = nil;
            local l_snap_0 = l_v953_0.snap;
            local l_data_0 = snap_logic_handler.data;
            local v1155 = l_snap_0 and l_snap_0.on ~= "Off" and not l_v757_5.use_aa and local_player.exploit.active and local_player.exploit.lc_left > 0;
            if v1155 then
                l_data_0.ticks = l_data_0.ticks + 1;
                v1155 = l_snap_0.time >= l_data_0.ticks;
            else
                l_data_0.ticks = 0;
            end;
            if v1155 then
                local l_l_v757_5_10 = l_v757_5;
                local l_l_v761_4_4 = l_v761_4;
                local v1158 = true;
                l_l_v761_4_4.snap = {};
                l_l_v757_5_10.snapping = v1158;
                l_data_0.once.apex = l_data_0.once.apex or local_player.exploit.lc_left;
                l_data_0.once.delayed = l_data_0.once.delayed or 0;
                if l_data_0.once.delayed >= l_snap_0.y.delay + 1 then
                    l_data_0.once.switch = not l_data_0.once.switch;
                    l_data_0.once.delayed = 0;
                elseif l_v757_5.send_packet then
                    l_data_0.once.delayed = l_data_0.once.delayed + 1;
                end;
                if l_snap_0.x.type ~= "Off" then
                    l_l_v757_5_10 = snap_logic_handler.pitch[l_snap_0.x.type](l_data_0, l_snap_0.x);
                    if l_l_v757_5_10 then
                        l_v761_4.snap[1] = l_l_v757_5_10;
                    end;
                end;
                if l_snap_0.y.type ~= "Off" then
                    l_l_v757_5_10 = snap_logic_handler.yaw[l_snap_0.y.type](l_data_0, l_snap_0.y);
                    if l_l_v757_5_10 then
                        l_v761_4.snap[2] = l_l_v757_5_10;
                    end;
                end;
                if l_v761_4.snap[2] and local_player.exploit.defensive then
                    l_l_v757_5_10 = l_v763_3;
                    l_l_v761_4_4 = l_v763_3;
                    v1158 = true;
                    l_l_v761_4_4.no_offset = true;
                    l_l_v757_5_10.no_modifier = v1158;
                end;
            elseif l_v757_5.snapping then
                l_v757_5.snapping = false;
                l_data_0.counter = l_data_0.counter >= 65535 and 0 or l_data_0.counter + 1;
                table_utils.clear(l_data_0.once);
            end;
        end,
        lc_check = function ()
            -- upvalues: local_player (ref), ui_tabs (ref), l_v953_0 (ref), l_v757_5 (ref), game_data (ref)
            local v1159 = false;
            if not local_player.exploit.active then
                return false;
            else
                if ui_tabs.antiaim.def.snap.value then
                    local l_snap_1 = l_v953_0.snap;
                    if l_snap_1 and l_snap_1.on ~= "Off" then
                        v1159 = l_snap_1.lc;
                    end;
                elseif ui_tabs.antiaim.def.triggers.value then
                    local v1161 = ui_tabs.antiaim.def.triggers[1];
                    local v1162 = l_v757_5.statew and l_v757_5.statew > 0.5 and l_v757_5.stateb or l_v757_5.state;
                    if #v1161.states.value > 0 and not v1159 then
                        v1159 = v1162 == game_data.states.airc and v1161.states:get("Air-crouch") or v1162 == game_data.states.air and v1161.states:get("Air") or v1162 == game_data.states.sneak and v1161.states:get("Sneaking") or v1162 == game_data.states.crouch and v1161.states:get("Crouching") or v1162 == game_data.states.walk and v1161.states:get("Walking") or v1162 == game_data.states.run and v1161.states:get("Running") or v1162 == game_data.states.stand and v1161.states:get("Standing");
                    end;
                end;
                return v1159;
            end;
        end,
        lc = function (lc_handler)
            -- upvalues: ui_tabs (ref), menu_items (ref)
            local l_data_1 = lc_handler.data;
            if lc_handler.lc_check() then
                menu_items.rage.main.dt.lag:override("Always On");
                menu_items.rage.main.hs.options:override("Break LC");
                l_data_1.forced_lc = true;
            elseif l_data_1.forced_lc then
                menu_items.rage.main.dt.lag:override();
                menu_items.rage.main.hs.options:override();
                l_data_1.forced_lc = false;
            end;
        end,
        work = function (lc_processor)
            lc_processor:lc();
            lc_processor:snap();
        end
    };
    aa_state_to_graph_value_map = {
        movement_fix = function ()
            -- upvalues: l_l_v508_2_8 (ref), math_utils (ref)
            local l_forwardmove_0 = l_l_v508_2_8.forwardmove;
            local l_sidemove_0 = l_l_v508_2_8.sidemove;
            local v1169, v1170 = math_utils.angle_vec(0, l_l_v508_2_8.view_angles.y, 0);
            local v1171, v1172 = math_utils.angle_vec(l_l_v508_2_8.view_angles.x, l_l_v508_2_8.view_angles.y, l_l_v508_2_8.view_angles.z);
            local v1173 = 0;
            local v1174 = 0;
            local v1175 = 0;
            v1172.z = 0;
            v1171.z = v1175;
            v1170.z = v1174;
            v1169.z = v1173;
            v1173 = v1169 / math_utils.sqrt3(v1169:unpack());
            v1174 = v1170 / math_utils.sqrt3(v1170:unpack());
            v1175 = v1171 / math_utils.sqrt3(v1171:unpack());
            v1172 = v1172 / math_utils.sqrt3(v1172:unpack());
            v1171 = v1175;
            v1173 = v1173 * l_forwardmove_0 + v1174 * l_sidemove_0;
            l_l_v508_2_8.sidemove = (v1171.x * v1173.y - v1171.y * v1173.x) / (v1172.y * v1171.x - v1172.x * v1171.y);
            l_l_v508_2_8.forwardmove = (v1172.y * v1173.x - v1172.x * v1173.y) / (v1172.y * v1171.x - v1172.x * v1171.y);
        end,
        work = function (roll_handler)
            -- upvalues: l_v757_5 (ref), ui_tabs (ref), local_player (ref), math_utils (ref), l_l_v508_2_8 (ref), l_v763_3 (ref)
            l_v757_5.roll_mode = nil;
            if ui_tabs.antiaim.buttons.roll.value == 0 then
                return;
            else
                local v1177 = ui_tabs.antiaim.buttons.roll.value * (l_v757_5.inverted and -1 or 1);
                if local_player.velocity > 5 or not local_player.on_ground then
                    v1177 = math_utils.clamp(v1177, -40, 40);
                end;
                l_l_v508_2_8.view_angles.z = v1177;
                l_v757_5.roll_mode = l_l_v508_2_8.view_angles.z;
                if local_player.on_ground then
                    roll_handler.movement_fix();
                end;
                local l_l_v763_3_0 = l_v763_3;
                local l_l_v763_3_1 = l_v763_3;
                local l_l_v763_3_2 = l_v763_3;
                local v1181 = true;
                local v1182 = true;
                l_l_v763_3_2.no_snap = true;
                l_l_v763_3_1.no_offset = v1182;
                l_l_v763_3_0.no_modifier = v1181;
                l_v763_3.force_desync = l_l_v508_2_8.view_angles.z > 0 and 60 or -60;
                return;
            end;
        end
    };
    local special_modes_handler = {
        use = {
            wait = false,
            check = function ()
                -- upvalues: local_player (ref), l_l_v508_2_8 (ref)
                local l_m_iTeamNum_0 = local_player.self.m_iTeamNum;
                local l_m_bIsDefusing_0 = local_player.self.m_bIsDefusing;
                local l_m_bIsGrabbingHostage_0 = local_player.self.m_bIsGrabbingHostage;
                if l_m_bIsDefusing_0 or l_m_bIsGrabbingHostage_0 then
                    return false;
                else
                    if l_m_iTeamNum_0 == 3 and l_l_v508_2_8.view_angles.x > 15 then
                        local v1186 = entity.get_entities(129);
                        for v1187 = 1, #v1186 do
                            local v1188 = v1186[v1187]:get_origin();
                            if v1188 and local_player.origin and local_player.origin:dist(v1188) < 61 then
                                return false;
                            end;
                        end;
                    end;
                    return true;
                end;
            end,
            work = function (v1189)
                -- upvalues: l_v757_5 (ref), ui_tabs (ref), local_player (ref), l_v763_3 (ref), l_l_v508_2_8 (ref), l_v761_4 (ref)
                l_v757_5.use_aa = false;
                if not ui_tabs.antiaim.general.use.value then
                    return;
                else
                    if local_player.using then
                        l_v757_5.use_aa = true;
                        l_v763_3.force_camera = true;
                        if v1189.wait == false then
                            l_v763_3.force_send = true;
                            l_v763_3.no_antiaim = true;
                            v1189.wait = true;
                        elseif v1189.wait == true then
                            if v1189.check() then
                                l_l_v508_2_8.in_use = false;
                                local l_l_v761_4_5 = l_v761_4;
                                local l_l_v761_4_6 = l_v761_4;
                                local l_l_v761_4_7 = l_v761_4;
                                local v1193 = "Disabled";
                                local v1194 = 180;
                                l_l_v761_4_7.desfs = "Peek real";
                                l_l_v761_4_6.yaw = v1194;
                                l_l_v761_4_5.pitch = v1193;
                                l_v763_3.no_snap = true;
                            else
                                l_v763_3.no_antiaim = true;
                            end;
                        end;
                    elseif v1189.wait then
                        l_v763_3.force_send = true;
                        local l_l_v763_3_3 = l_v763_3;
                        local l_l_v763_3_4 = l_v763_3;
                        local v1197 = true;
                        l_l_v763_3_4.no_modifier = true;
                        l_l_v763_3_3.no_offset = v1197;
                        v1189.wait = false;
                    end;
                    return;
                end;
            end
        },
        safe = {
            smart = function ()
                -- upvalues: local_player (ref), l_v757_5 (ref), game_data (ref), l_v763_3 (ref)
                local v1198 = local_player.threat:get_eye_position();
                local v1199 = local_player.self:get_hitbox_position(1);
                if not v1198 or not v1199 then
                    return;
                else
                    local v1200 = (v1199.z - v1198.z) / l_v757_5.threat_dist;
                    local v1201 = 0;
                    local v1202 = 0.75;
                    if local_player.on_ground and not local_player.crouching then
                        local v1203 = 0.25;
                        v1202 = 0.5;
                        v1201 = v1203;
                    elseif local_player.on_ground and local_player.crouching then
                        local v1204 = -0.05;
                        v1202 = 0.3;
                        v1201 = v1204;
                    elseif l_v757_5.state == game_data.states.air then
                        local v1205 = 0.15;
                        v1202 = 0.75;
                        v1201 = v1205;
                    elseif l_v757_5.state == game_data.states.airc then
                        if (local_player.weapon_t and local_player.weapon_t.weapon_name) == "weapon_knife" then
                            local v1206 = -0.05;
                            v1202 = 0.55;
                            v1201 = v1206;
                        else
                            local v1207 = 0.1;
                            v1202 = 0.75;
                            v1201 = v1207;
                        end;
                    end;
                    if v1200 < v1201 or v1202 < v1200 then
                        return;
                    else
                        l_v757_5.safe_head = true;
                        local l_l_v763_3_5 = l_v763_3;
                        local l_l_v763_3_6 = l_v763_3;
                        local l_l_v763_3_7 = l_v763_3;
                        local v1211 = true;
                        local v1212 = true;
                        l_l_v763_3_7.force_desync = 0;
                        l_l_v763_3_6.no_offset = v1212;
                        l_l_v763_3_5.no_modifier = v1211;
                        return;
                    end;
                end;
            end,
            basic = function ()
                -- upvalues: local_player (ref), l_v757_5 (ref), l_v763_3 (ref)
                local v1213 = local_player.threat:get_origin();
                if not v1213 then
                    return;
                else
                    local v1214 = local_player.origin.z - v1213.z;
                    local v1215 = local_player.weapon_t and local_player.weapon_t.weapon_type == 0;
                    if local_player.jumping and v1215 and v1214 > -32 then
                        l_v757_5.safe_head = true;
                        local l_l_v763_3_8 = l_v763_3;
                        local l_l_v763_3_9 = l_v763_3;
                        local l_l_v763_3_10 = l_v763_3;
                        local v1219 = true;
                        local v1220 = true;
                        l_l_v763_3_10.force_desync = 0;
                        l_l_v763_3_9.no_offset = v1220;
                        l_l_v763_3_8.no_modifier = v1219;
                    end;
                    return;
                end;
            end,
            work = function (v1221)
                -- upvalues: l_v757_5 (ref), ui_tabs (ref), local_player (ref)
                l_v757_5.safe_head = false;
                if not ui_tabs.antiaim.general.head.value or not local_player.threat or l_v757_5.manual_yaw or l_v757_5.use_aa then
                    return;
                else
                    if ui_tabs.antiaim.general.head.smart.value then
                        v1221.smart();
                    else
                        v1221.basic();
                    end;
                    return;
                end;
            end
        },
        flick = {
            step = 0,
            work = function (v1222)
                -- upvalues: l_v757_5 (ref), ui_tabs (ref), local_player (ref), are_not_equal (ref), l_v953_0 (ref), l_v763_3 (ref), l_l_v508_2_8 (ref), l_v761_4 (ref)
                l_v757_5.lcflick = false;
                if not ui_tabs.antiaim.buttons.flick.value or local_player.exploit.charge < 1 then
                    return;
                else
                    local v1223 = l_v757_5.sent % 4 >= 2;
                    local _ = are_not_equal(v1223, l_v953_0.cur.des.inv) and -1 or 1;
                    local v1225 = are_not_equal(l_v757_5.inverted, l_v953_0.cur.des.inv) and -1 or 1;
                    l_v763_3.no_offset = true;
                    l_l_v508_2_8.force_defensive = true;
                    l_v761_4.des = -60 * v1225;
                    l_v761_4.mod = (not local_player.exploit.defensive and ({
                        [1] = 40,
                        [2] = 45,
                        [3] = 45,
                        [4] = 40
                    })[v1222.step % 4 + 1] or 0) * v1225;
                    if not local_player.exploit.defensive and l_v757_5.send_packet then
                        v1222.step = v1222.step >= 255 and 0 or v1222.step + 1;
                    end;
                    return;
                end;
            end
        },
        work = function (special_modes_processor)
            special_modes_processor.use:work();
            special_modes_processor.safe:work();
        end
    };
    local function interpolate_aa_settings(base_value_table, target_value_table, lerp_factor)
        -- upvalues: l_v757_5 (ref), next (ref), type (ref), math_utils (ref)
        if not lerp_factor then
            lerp_factor = l_v757_5.statew;
        end;
        if lerp_factor == 0 or not target_value_table then
            return base_value_table;
        elseif lerp_factor == 1 then
            return target_value_table;
        else
            local v1231 = base_value_table or {};
            if not target_value_table then
                target_value_table = {};
            end;
            base_value_table = v1231;
            v1231 = {};
            for v1232 in next, base_value_table do
                local v1233 = base_value_table[v1232];
                local v1234 = target_value_table[v1232];
                if type(v1233) == "number" and type(v1234) == "number" then
                    v1231[v1232] = math_utils.lerp(v1233, v1234, lerp_factor);
                elseif lerp_factor < 0.5 then
                    v1231[v1232] = v1233;
                else
                    v1231[v1232] = v1234;
                end;
            end;
            return v1231;
        end;
    end;
    do
        local l_v994_1, l_v999_1, l_v1001_1, l_v1002_1, l_v1003_2, l_v1227_0, l_v1235_0 = aa_state_processor, process_defensive_snap, update_aa_angles_and_targets, log_aa_state_graph, aa_state_to_graph_value_map, special_modes_handler, interpolate_aa_settings;
        local aa_work_dispatcher = {
            [true] = function ()
                -- upvalues: l_v994_1 (ref), l_v757_5 (ref), l_v999_1 (ref), l_v1001_1 (ref), l_v953_0 (ref), table_utils (ref), l_v761_4 (ref), l_v1235_0 (ref), l_v1003_2 (ref), l_v1002_1 (ref), l_v1227_0 (ref), l_v763_3 (ref), math_utils (ref)
                l_v994_1:work();
                if l_v757_5.statew == 0 then
                    l_v999_1:work();
                    l_v1001_1:work();
                elseif l_v757_5.statew == 1 then
                    local l_l_v953_0_2 = l_v953_0;
                    local l_l_v953_0_3 = l_v953_0;
                    local l_next_1 = l_v953_0.next;
                    l_l_v953_0_3.next = l_v953_0.cur;
                    l_l_v953_0_2.cur = l_next_1;
                    l_v999_1:work();
                    l_v1001_1:work();
                    l_l_v953_0_2 = l_v953_0;
                    l_l_v953_0_3 = l_v953_0;
                    l_next_1 = l_v953_0.next;
                    l_l_v953_0_3.next = l_v953_0.cur;
                    l_l_v953_0_2.cur = l_next_1;
                else
                    l_v999_1:work();
                    l_v1001_1:work();
                    local v1246 = table_utils.copy(l_v761_4);
                    local l_l_v953_0_4 = l_v953_0;
                    local l_l_v953_0_5 = l_v953_0;
                    local l_next_2 = l_v953_0.next;
                    l_l_v953_0_5.next = l_v953_0.cur;
                    l_l_v953_0_4.cur = l_next_2;
                    l_v999_1:work();
                    l_v1001_1:work();
                    l_l_v953_0_4 = table_utils.copy(l_v761_4);
                    l_l_v953_0_5 = l_v953_0;
                    l_next_2 = l_v953_0;
                    local l_next_3 = l_v953_0.next;
                    l_next_2.next = l_v953_0.cur;
                    l_l_v953_0_5.cur = l_next_3;
                    l_v761_4 = l_v1235_0(v1246, l_l_v953_0_4);
                end;
                l_v1003_2:work();
                l_v1002_1:work();
                l_v1227_0:work();
                if l_v763_3.no_snap then
                    l_v761_4.snap = nil;
                end;
                if l_v763_3.no_modifier then
                    l_v761_4.mod = 0;
                end;
                if l_v763_3.force_desync ~= nil then
                    l_v761_4.des = l_v763_3.force_desync or nil;
                end;
                if not l_v763_3.no_offset then
                    local v1251 = l_v953_0.cur.off + (l_v953_0.cur.add.on and l_v761_4.des and l_v761_4.des ~= 0 and (l_v761_4.des > 0 and l_v953_0.cur.add.r or l_v953_0.cur.add.l) or 0);
                    local v1252 = l_v953_0.next.off + (l_v953_0.next.add.on and l_v761_4.des and l_v761_4.des ~= 0 and (l_v761_4.des > 0 and l_v953_0.next.add.r or l_v953_0.next.add.l) or 0);
                    l_v761_4.mod = l_v761_4.mod + math_utils.lerp(v1251, v1252, l_v757_5.statew);
                end;
            end,
            [false] = function ()
                -- upvalues: l_v994_1 (ref), l_v999_1 (ref), l_v1001_1 (ref), l_v1003_2 (ref), l_v1002_1 (ref), l_v1227_0 (ref), l_v763_3 (ref), l_v761_4 (ref), l_v953_0 (ref)
                l_v994_1:work();
                l_v999_1:work();
                l_v1001_1:work();
                l_v1003_2:work();
                l_v1002_1:work();
                l_v1227_0:work();
                if l_v763_3.no_snap then
                    l_v761_4.snap = nil;
                end;
                if l_v763_3.no_modifier then
                    l_v761_4.mod = 0;
                end;
                if l_v763_3.force_desync ~= nil then
                    l_v761_4.des = l_v763_3.force_desync or nil;
                end;
                if not l_v763_3.no_offset then
                    l_v761_4.mod = l_v761_4.mod + l_v953_0.cur.off;
                    if l_v953_0.cur.add.on and l_v761_4.des and l_v761_4.des ~= 0 then
                        l_v761_4.mod = l_v761_4.mod + (l_v761_4.des > 0 and l_v953_0.cur.add.r or l_v953_0.cur.add.l);
                    end;
                end;
            end
        };
        get_current_aa_state_func = function ()
            -- upvalues: aa_work_dispatcher (ref), ui_tabs (ref)
            aa_work_dispatcher[ui_tabs.antiaim.general.nature.value]();
        end;
        local l_on_0 = ui_tabs.antiaim.ab.on;
        l_v757_5.abweight = 0;
        l_v757_5.abcfgidx = 1;
        l_v757_5.abcfgname = "Default";
        local l_rlist_0 = ui_settings.rlist;
        local v1256 = nil;
        do
            local l_l_on_0_0, l_l_rlist_0_0, l_v1256_0 = l_on_0, l_rlist_0, v1256;
            local function trigger_anti_bruteforce()
                -- upvalues: l_l_on_0_0 (ref), l_v757_5 (ref), l_v1256_0 (ref), table_utils (ref), l_l_rlist_0_0 (ref), ui_settings (ref), math_utils (ref)
                if l_l_on_0_0.mode.value == "Adjust" then
                    local v1260 = l_l_on_0_0.power.value * 0.01;
                    l_v757_5.abweight = utils.random_float(-v1260, v1260);
                    if l_l_on_0_0.timer.value > 0 then
                        l_v1256_0 = globals.curtime;
                    end;
                elseif l_l_on_0_0.mode.value == "Preset rack" then
                    if l_l_on_0_0.order.value == "Random" then
                        local l_l_v757_5_11 = l_v757_5;
                        local l_l_v757_5_12 = l_v757_5;
                        local v1263, v1264 = table_utils.random(l_l_rlist_0_0);
                        l_l_v757_5_12.abcfgidx = v1264;
                        l_l_v757_5_11.abcfgname = v1263;
                        ui_settings.actions.load(l_v757_5.abcfgname, {
                            [1] = "antiaim",
                            [2] = "builder"
                        }, {
                            [1] = "antiaim",
                            [2] = "snaps"
                        });
                    elseif l_l_on_0_0.order.value == "Sequence" then
                        l_v757_5.abcfgidx = math_utils.cycle(l_v757_5.abcfgidx + 1, #l_l_rlist_0_0);
                        l_v757_5.abcfgname = l_l_rlist_0_0[l_v757_5.abcfgidx];
                        ui_settings.actions.load(l_v757_5.abcfgname, {
                            [1] = "antiaim",
                            [2] = "builder"
                        }, {
                            [1] = "antiaim",
                            [2] = "snaps"
                        });
                    end;
                end;
            end;
            local function reset_anti_bruteforce()
                -- upvalues: l_v757_5 (ref), ui_settings (ref)
                l_v757_5.abweight = 0;
                l_v757_5.abcfgidx = ui_settings.loadedidx or 0;
                l_v757_5.abcfgname = ui_settings.loaded or "Default";
            end;
            local function on_enemy_shot(shot_event_data)
                -- upvalues: l_l_on_0_0 (ref), trigger_anti_bruteforce (ref), events (ref), l_v757_5 (ref)
                if not l_l_on_0_0.events:get("Enemy shot") then
                    return;
                else
                    trigger_anti_bruteforce();
                    events.ab_set:call({
                        trigger = "enemy_shot",
                        set = true,
                        enemy = shot_event_data.attacker,
                        weight = l_v757_5.abweight,
                        config = l_v757_5.abcfgname,
                        mode = l_l_on_0_0.mode.value
                    });
                    return;
                end;
            end;
            local function on_local_shot(fire_event_data)
                -- upvalues: l_l_on_0_0 (ref), local_player (ref), trigger_anti_bruteforce (ref), events (ref), l_v757_5 (ref)
                if not l_l_on_0_0.events:get("Local shot") or fire_event_data.userid ~= local_player.userid then
                    return;
                else
                    trigger_anti_bruteforce();
                    events.ab_set:call({
                        trigger = "local_shot",
                        set = true,
                        enemy = fire_event_data.attacker,
                        weight = l_v757_5.abweight,
                        config = l_v757_5.abcfgname,
                        mode = l_l_on_0_0.mode.value
                    });
                    return;
                end;
            end;
            local function on_round_event_for_ab()
                -- upvalues: reset_anti_bruteforce (ref), events (ref), l_v757_5 (ref), l_l_on_0_0 (ref)
                reset_anti_bruteforce();
                events.ab_set:call({
                    set = false,
                    weight = l_v757_5.abweight,
                    config = l_v757_5.abcfgname,
                    mode = l_l_on_0_0.mode.value
                });
            end;
            local function check_ab_timer()
                -- upvalues: l_l_on_0_0 (ref), l_v1256_0 (ref), math_utils (ref), reset_anti_bruteforce (ref), events (ref), l_v757_5 (ref)
                local v1272 = l_l_on_0_0.timer.value * 0.1;
                if l_v1256_0 and v1272 < math_utils.abs(globals.curtime - l_v1256_0) then
                    reset_anti_bruteforce();
                    events.ab_set:call({
                        trigger = "timer",
                        set = false,
                        weight = l_v757_5.abweight,
                        config = l_v757_5.abcfgname,
                        mode = l_l_on_0_0.mode.value
                    });
                    l_v1256_0 = nil;
                end;
            end;
            l_l_on_0_0.sel:set_callback(function (v1274)
                -- upvalues: l_l_on_0_0 (ref), l_l_rlist_0_0 (ref), ui_settings (ref)
                v1274.value = l_l_on_0_0.sel:get();
                l_l_rlist_0_0 = #v1274.value > 0 and v1274.value or ui_settings.rlist;
            end, true);
            l_l_on_0_0:set_callback(function (v1275)
                -- upvalues: events (ref), on_enemy_shot (ref), on_local_shot (ref), on_round_event_for_ab (ref), check_ab_timer (ref), reset_anti_bruteforce (ref)
                events.enemy_shot(on_enemy_shot, v1275.value);
                events.weapon_fire(on_local_shot, v1275.value);
                events.local_spawn(on_round_event_for_ab, v1275.value);
                events.local_disconnect(on_round_event_for_ab, v1275.value);
                events.createmove(check_ab_timer, v1275.value);
                if not v1275.value then
                    reset_anti_bruteforce();
                end;
            end, true);
        end;
    end;
    ui_groups_settings = {
        data = l_v757_5,
        ctx = l_v761_4
    };
    aa_state_processor = function (_)
        -- upvalues: math_utils (ref), l_v763_3 (ref), l_v761_4 (ref), l_v925_1 (ref), l_v757_5 (ref)
        local final_yaw_offset = math_utils.normalize_yaw(l_v763_3.force_yaw or l_v761_4.yaw + l_v761_4.mod);
        l_v925_1.freestand:override(l_v761_4.fs);
        l_v925_1.hidden:override(l_v761_4.snap ~= nil);
        if l_v761_4.snap then
            rage.antiaim:override_hidden_pitch(l_v761_4.snap[1] and math_utils.normalize_pitch(l_v761_4.snap[1]) or 89);
            rage.antiaim:override_hidden_yaw_offset(l_v761_4.snap[2] and math_utils.normalize_yaw(l_v761_4.snap[2]) or 0);
        end;
        if l_v757_5.send_packet or l_v763_3.force_send then
            l_v925_1.pitch:set(l_v757_5.use_aa and "Disabled" or "Down");
            l_v925_1.yaw:override(final_yaw_offset);
            l_v925_1.yaw_type:override((not not l_v763_3.force_yaw or l_v763_3.force_static) and "Static" or "Backward");
            l_v925_1.yaw_base:override(l_v763_3.force_camera and "Local View" or "At Target");
            l_v925_1.modifier:override("Disabled");
            l_v925_1.extended:override(false);
            l_v925_1.body_yaw:override(l_v761_4.des ~= nil);
            if l_v761_4.des then
                l_v925_1.inverter:override(l_v761_4.des > 0);
                l_v925_1.left:override(-l_v761_4.des);
                l_v925_1.right:override(l_v761_4.des);
                l_v925_1.options:override(l_v761_4.deso);
                l_v925_1.desync_fs:override(l_v761_4.desfs);
            end;
        end;
    end;
    process_defensive_snap = nil;
    update_aa_angles_and_targets = nil;
    log_aa_state_graph = 0;
    aa_state_to_graph_value_map = 0;
    do
        local l_v1002_2, l_v1003_3, l_v1227_1 = log_aa_state_graph, aa_state_to_graph_value_map, special_modes_handler;
        l_v1227_1 = {
            Static = function (delay_config_static)
                return delay_config_static.time;
            end,
            Fluctuate = function (delay_config_fluctuate)
                -- upvalues: l_v1003_3 (ref)
                return l_v1003_3 >= delay_config_fluctuate.time and 0 or l_v1003_3 + 1;
            end,
            Switch = function (delay_config_switch)
                -- upvalues: l_v1003_3 (ref)
                return l_v1003_3 == delay_config_switch.time and 0 or delay_config_switch.time;
            end,
            Random = function (delay_config_random)
                return utils.random_int(0, delay_config_random.time);
            end
        };
        update_aa_angles_and_targets = function ()
            -- upvalues: l_v757_5 (ref), l_v953_0 (ref), l_v1227_1 (ref), l_v1002_2 (ref), local_player (ref), game_data (ref), l_v1003_3 (ref)
            local active_delay_config = l_v757_5.statew and l_v757_5.statew > 0.5 and l_v953_0.next.switch or l_v953_0.cur.switch;
            local next_choke_limit = l_v1227_1[active_delay_config.mode] and l_v1227_1[active_delay_config.mode](active_delay_config) + 1 or 0;
            if next_choke_limit <= l_v1002_2 or local_player.exploit.active == game_data.exploit.OFF then
                if l_v757_5.send_packet then
                    l_v757_5.counter = l_v757_5.counter >= 65535 and 0 or l_v757_5.counter + 1;
                    l_v757_5.switch = l_v757_5.counter % 2 == 0;
                    l_v1002_2 = 0;
                    l_v1003_3 = next_choke_limit - 1;
                end;
            else
                l_v1002_2 = l_v1002_2 + 1;
            end;
        end;
    end;
    do
        local l_v1001_2 = update_aa_angles_and_targets;
        process_defensive_snap = function ()
            -- upvalues: l_v757_5 (ref), l_v1001_2 (ref), table_utils (ref), l_v763_3 (ref)
            if l_v757_5.send_packet then
                l_v757_5.sent = l_v757_5.sent >= 65535 and 0 or l_v757_5.sent + 1;
            end;
            l_v1001_2();
            table_utils.clear(l_v763_3);
        end;
    end;
    do
        local l_v994_2, l_v999_2, l_v1001_3 = aa_state_processor, process_defensive_snap, update_aa_angles_and_targets;
        l_v1001_3 = {
            work = function (user_cmd)
                -- upvalues: l_l_v508_2_8 (ref), update_aa_state_and_conditions (ref), get_current_aa_state_func (ref), l_v994_2 (ref), l_v999_2 (ref)
                l_l_v508_2_8 = user_cmd;
                update_aa_state_and_conditions();
                get_current_aa_state_func();
                l_v994_2();
                l_v999_2();
            end,
            revert = function ()
                -- upvalues: next (ref), l_v925_1 (ref)
                for _, cvar_reference in next, l_v925_1.list do
                    cvar_reference:override();
                end;
            end
        };
        ui_tabs.antiaim.enable:set_callback(function (aa_enable_switch)
            -- upvalues: menu_items (ref), events (ref), l_v1001_3 (ref)
            menu_items.antiaim.angles.enabled:override(aa_enable_switch.value or nil);
            menu_items.antiaim.angles.yaw.avoid_bs:override(aa_enable_switch.value or nil);
            events.createmove(l_v1001_3.work, aa_enable_switch.value);
            if not aa_enable_switch.value then
                l_v1001_3.revert();
            end;
        end, true);
        menu_items.antiaim.angles.freestand:set_callback(function (freestand_switch)
            -- upvalues: ui_tabs (ref)
            ui_tabs.antiaim.buttons.fs:set(freestand_switch.value);
        end, true);
        events.shutdown:set(l_v1001_3.revert);
    end;
end;
update_stats_ui = {};
update_stats_ui.shared = {
    code_mul = 143,
    latest_rollcall = 0,
    users = {},
    icons = {
        [1] = "https://cdn.hysteria.one/main/user.png",
        [2] = "https://cdn.hysteria.one/main/bliss.png",
        [3] = "https://cdn.hysteria.one/main/beta.png",
        [4] = "https://cdn.hysteria.one/main/dev.png"
    },
    listen = function (v1296)
        -- upvalues: update_stats_ui (ref), debug_log (ref), string_utils (ref)
        local v1297 = v1296.buffer:read_bits(4);
        local v1298 = v1296.buffer:read_bits(8);
        local v1299 = v1296.buffer:read_bits(4);
        local v1300 = v1296.buffer:read_bits(20);
        local v1301 = v1296.buffer:read_bits(12);
        if v1296.entity and v1296.xuid == 0 then
            local v1302 = #v1296.entity:get_name();
            local v1303 = update_stats_ui.shared.code_mul - v1302 - 1;
            if v1297 == 0 and v1298 == v1302 and v1299 > 0 and v1299 < 5 and v1300 % v1303 == 0 and v1300 % v1301 == 0 then
                debug_log(string_utils.format("%s is a %s user", v1296.entity:get_name(), v1299));
                update_stats_ui.shared.set(v1296.entity, v1299);
            end;
        end;
        update_stats_ui.shared.rollcall();
    end,
    say = function ()
        -- upvalues: events (ref), build_level (ref), update_stats_ui (ref)
        if not globals.is_in_game then
            return;
        else
            local v1304 = #cvar.name:string();
            local v1305 = utils.random_int(256, 4095);
            events.voice_message:call(function (v1306)
                -- upvalues: v1304 (ref), build_level (ref), v1305 (ref), update_stats_ui (ref)
                v1306:write_bits(0, 4);
                v1306:write_bits(v1304, 8);
                v1306:write_bits(build_level, 4);
                v1306:write_bits(v1305 * (update_stats_ui.shared.code_mul - v1304 - 1), 20);
                v1306:write_bits(v1305, 12);
            end);
            return;
        end;
    end,
    rollcall = function (v1307)
        -- upvalues: math_utils (ref), update_stats_ui (ref), local_player (ref), build_level (ref)
        if v1307 == true or math_utils.abs(globals.tickcount - update_stats_ui.shared.latest_rollcall) > 256 then
            update_stats_ui.shared.say();
            update_stats_ui.shared.set(local_player.self, build_level);
            update_stats_ui.shared.latest_rollcall = globals.tickcount;
        end;
    end,
    set = function (v1308, v1309, v1310)
        -- upvalues: update_stats_ui (ref), ui_tabs (ref), local_player (ref)
        if not v1308 or v1308:is_bot() then
            return;
        else
            local l_shared_0 = update_stats_ui.shared;
            local v1312 = l_shared_0.icons[v1309];
            local l_steamid_0 = v1308:get_player_info().steamid;
            if ui_tabs.settings.shared.value and v1309 and v1312 then
                if not l_shared_0.users[l_steamid_0] then
                    v1308:set_icon(v1312);
                    l_shared_0.active = true;
                    l_shared_0.users[l_steamid_0] = true;
                end;
            elseif l_shared_0.users[l_steamid_0] and (not v1310 or v1308 ~= local_player.self) then
                v1308:set_icon();
                l_shared_0.users[l_steamid_0] = nil;
            end;
            return;
        end;
    end,
    clear = function ()
        -- upvalues: update_stats_ui (ref)
        entity.get_players(false, true, update_stats_ui.shared.set);
        update_stats_ui.shared.users = {};
    end,
    run = function (shared_icon_module)
        -- upvalues: ui_tabs (ref), events (ref), update_stats_ui (ref), local_player (ref), build_level (ref)
        shared_icon_module.say();
        ui_tabs.settings.shared:set_callback(function (v1315)
            -- upvalues: events (ref), shared_icon_module (ref), update_stats_ui (ref), local_player (ref), build_level (ref)
            events.voice_message(shared_icon_module.listen, v1315.value);
            if v1315.value then
                shared_icon_module.rollcall();
                update_stats_ui.shared.set(local_player.self, build_level, true);
            else
                shared_icon_module.clear();
            end;
        end, true);
        events.player_spawn:set(shared_icon_module.rollcall);
        events.player_death:set(shared_icon_module.rollcall);
        events.round_start:set(shared_icon_module.rollcall);
        events.round_prestart:set(shared_icon_module.clear);
        events.shutdown:set(shared_icon_module.clear);
    end
};
update_stats_ui.clantag = {
    last = 0,
    list = {
        [1] = "h \226\160\128 \226\160\128\226\160\128\226\160\128",
        [2] = "hy \226\160\128 \226\160\128 \226\160\128",
        [3] = "hys \226\160\128\226\160\128\226\160\128",
        [4] = "hyst  \226\160\128\226\160\128 ",
        [5] = "hyste\226\160\128\226\160\128",
        [6] = "hyster \226\160\128",
        [7] = "hysteri\226\160\128",
        [8] = "hysteria",
        [9] = "hysteria",
        [10] = "hysteria",
        [11] = "hysteria",
        [12] = "hysteria",
        [13] = "hysteria",
        [14] = "hysteria",
        [15] = "hysteria",
        [16] = "hysteria",
        [17] = "hysteria",
        [18] = "\226\160\128ysteria",
        [19] = "\226\160\128 steria",
        [20] = "\226\160\128\226\160\128 teria",
        [21] = "\226\160\128\226\160\128\226\160\128eria",
        [22] = "\226\160\128\226\160\128 \226\160\128 ria",
        [23] = "\226\160\128 \226\160\128 \226\160\128 ia",
        [24] = "\226\160\128 \226\160\128\226\160\128\226\160\128 a"
    },
    work = function ()
        -- upvalues: math_utils (ref), update_stats_ui (ref)
        if not globals.is_in_game then
            return;
        else
            local v1316 = math_utils.floor(globals.curtime * 4 + 0.5) % #update_stats_ui.clantag.list + 1;
            if v1316 == update_stats_ui.clantag.last then
                return;
            else
                update_stats_ui.clantag.last = v1316;
                common.set_clan_tag(update_stats_ui.clantag.list[v1316] or "");
                return;
            end;
        end;
    end,
    reset = function ()
        common.set_clan_tag("");
    end,
    run = function (clantag_module)
        -- upvalues: ui_tabs (ref), events (ref), menu_items (ref)
        ui_tabs.settings.clantag:set_callback(function (v1318)
            -- upvalues: events (ref), clantag_module (ref), ui_tabs (ref), menu_items (ref)
            events.net_update_end(clantag_module.work, v1318.value);
            if ui_tabs.settings.clantag.value then
                menu_items.misc.ingame.clantag:override(false);
            else
                clantag_module.reset();
                menu_items.misc.ingame.clantag:override();
            end;
        end, true);
        events.shutdown:set(clantag_module.reset);
        menu_items.misc.ingame.clantag:depend(true, {
            [1] = nil,
            [2] = false,
            [1] = ui_tabs.settings.clantag
        });
    end
};
update_stats_ui.ladder = {
    work = function (v1319)
        -- upvalues: local_player (ref), render_proxy (ref), math_utils (ref)
        if local_player.self.m_MoveType ~= 9 or v1319.forwardmove == 0 then
            return;
        else
            local v1320 = render_proxy.camera_angles();
            local v1321 = v1319.forwardmove < 0 or v1320.x > 45;
            local l_v1321_0 = v1321;
            v1319.in_moveright = not v1321;
            v1319.in_moveleft = l_v1321_0;
            l_v1321_0 = v1321;
            v1319.in_back = not v1321;
            v1319.in_forward = l_v1321_0;
            l_v1321_0 = v1319.view_angles;
            local l_view_angles_0 = v1319.view_angles;
            local v1324 = 89;
            l_view_angles_0.y = math_utils.normalize_yaw(v1319.move_yaw + 90);
            l_v1321_0.x = v1324;
            return;
        end;
    end,
    run = function (ladder_strafe_module)
        -- upvalues: ui_tabs (ref), events (ref)
        ui_tabs.settings.ladder:set_callback(function (v1326)
            -- upvalues: events (ref), ladder_strafe_module (ref)
            events.createmove(ladder_strafe_module.work, v1326.value);
        end, true);
    end
};
update_stats_ui.avoidc = {
    work = function (v1327)
        -- upvalues: local_player (ref), Vector (ref), players (ref), math_utils (ref)
        if not v1327.in_jump or v1327.in_moveright or v1327.in_moveleft or not not v1327.in_back then
            return;
        else
            local l_origin_0 = local_player.origin;
            if not l_origin_0 then
                return;
            else
                l_origin_0.z = l_origin_0.z + 16;
                local v1329 = l_origin_0 + Vector():angles(Vector(0, v1327.move_yaw, 0)) * 128;
                local v1330 = utils.trace_line(l_origin_0, v1329, players, 33636363);
                if bit.band(v1330.contents, 536870912) ~= 0 or v1330.entity and v1330.entity:get_classname() == "CDynamicProp" then
                    return;
                else
                    local l_huge_0 = math_utils.huge;
                    local l_huge_1 = math_utils.huge;
                    for v1333 = -80, 80, 10 do
                        local v1334 = l_origin_0 + Vector():angles(Vector(0, v1327.move_yaw + v1333)) * 64;
                        local v1335 = utils.trace_line(l_origin_0, v1334, players, 33636363);
                        local v1336 = l_origin_0:dist(v1335.end_pos);
                        if v1336 < l_huge_1 and (not v1335.entity or not v1335.entity:is_player()) then
                            local l_v1333_0 = v1333;
                            l_huge_1 = v1336;
                            l_huge_0 = l_v1333_0;
                        end;
                    end;
                    local v1338 = 35;
                    if l_huge_1 < v1338 then
                        local v1339 = math_utils.rad(l_huge_0 + 90);
                        local v1340 = math_utils.abs(l_huge_0) < v1338 and (v1338 - l_huge_1) / 15 or 1;
                        local v1341 = math_utils.abs(local_player.velocity * math_utils.cos(v1339));
                        local v1342 = local_player.velocity * math_utils.sin(v1339) * v1340;
                        v1327.forwardmove = v1341;
                        v1327.sidemove = v1342 * (l_huge_0 >= 0 and 1 or -1);
                    end;
                    return;
                end;
            end;
        end;
    end,
    run = function (collision_avoid_module)
        -- upvalues: ui_tabs (ref), events (ref)
        ui_tabs.settings.avoidc:set_callback(function (v1344)
            -- upvalues: events (ref), collision_avoid_module (ref)
            events.createmove(collision_avoid_module.work, v1344.value);
        end, true);
    end
};
update_stats_ui.release = {
    held = 0,
    predict = function (v1345)
        -- upvalues: local_player (ref), ui_tabs (ref), update_stats_ui (ref)
        if local_player.in_attack and (v1345.type == "Frag" or v1345.type == "Molly" and ui_tabs.settings.release.burn.value) then
            local l_release_0 = update_stats_ui.release;
            if v1345.fatal or v1345.damage >= ui_tabs.settings.release.dmg.value then
                if l_release_0.held < 8 then
                    l_release_0.held = l_release_0.held + 1;
                else
                    cvar["-attack"]:call();
                    if local_player.in_attack then
                        l_release_0.held = 0;
                    end;
                end;
            elseif l_release_0.held ~= 0 then
                cvar["-attack"]:call();
                l_release_0.held = 0;
            end;
        end;
    end,
    run = function (grenade_release_module)
        -- upvalues: ui_tabs (ref), events (ref)
        ui_tabs.settings.release:set_callback(function (v1348)
            -- upvalues: events (ref), grenade_release_module (ref)
            events.grenade_prediction(grenade_release_module.predict, v1348.value);
        end, true);
    end
};
update_stats_ui.nofall = {
    work = function (v1349)
        -- upvalues: local_player (ref), Vector (ref)
        local l_m_vecVelocity_0 = local_player.self.m_vecVelocity;
        if l_m_vecVelocity_0.z < -10 and local_player.origin then
            local l_origin_1 = local_player.origin;
            local v1352 = utils.trace_line(l_origin_1, l_origin_1 + Vector(0, 0, -512), nil, nil, 1);
            if l_origin_1.z - v1352.end_pos.z <= 70 and l_origin_1.z - v1352.end_pos.z >= 12 and l_m_vecVelocity_0.z < -450 then
                v1349.in_duck = true;
            end;
        end;
    end,
    run = function (no_fall_damage_module)
        -- upvalues: ui_tabs (ref), events (ref)
        ui_tabs.settings.nofall:set_callback(function (v1354)
            -- upvalues: events (ref), no_fall_damage_module (ref)
            events.createmove(no_fall_damage_module.work, v1354.value);
        end, true);
    end
};
update_stats_ui.fdspeed = {
    work = function (v1355)
        -- upvalues: local_player (ref)
        if local_player.on_ground and local_player.exploit.fd then
            v1355.forwardmove = v1355.forwardmove * 2;
            v1355.sidemove = v1355.sidemove * 2;
        end;
    end,
    run = function (fake_duck_speed_module)
        -- upvalues: ui_tabs (ref), events (ref)
        ui_tabs.settings.fdspeed:set_callback(function (v1357)
            -- upvalues: events (ref), fake_duck_speed_module (ref)
            events.createmove_run(fake_duck_speed_module.work, v1357.value);
        end, true);
    end
};
for _, feature_module in next, update_stats_ui do
    if feature_module then
        feature_module:run();
    end;
end;
aa_ui_elements_or_aa_runtime_state = nil;
link_aa_builder_to_config_or_features_module_or_aa_runtime_context = table_utils.new(50, 0);
aa_features = {
    [1] = "knife",
    [2] = "c4",
    [3] = "decoy",
    [4] = "flashbang",
    [5] = "hegrenade",
    [6] = "incgrenade",
    [7] = "molotov",
    [8] = "inferno",
    [9] = "smokegrenade"
};
aa_ui_elements_or_aa_runtime_state = {
    list = link_aa_builder_to_config_or_features_module_or_aa_runtime_context
};
crosshair_widget = ui_tabs.settings.logs;
widgets_manager = {};
widget_instance = nil;
do
    local l_v761_5, l_v763_4, l_v925_2, l_v952_0, l_v953_1 = link_aa_builder_to_config_or_features_module_or_aa_runtime_context, aa_features, crosshair_widget, widgets_manager, widget_instance;
    local function log_event(v1365, v1366, v1367)
        -- upvalues: l_v925_2 (ref), print (ref), events_any_proxy (ref), l_v952_0 (ref), print_raw (ref), l_v761_5 (ref), string_utils (ref), unpack (ref), table_utils (ref)
        if v1366 and l_v925_2.con.value then
            local v1368 = l_v925_2.hys.value and print or events_any_proxy;
            if l_v952_0.round then
                print_raw("");
                v1368("round ", "\v" .. l_v952_0.round);
                l_v952_0.round = nil;
            end;
            v1368(v1366);
        end;
        if v1367 and l_v925_2.sc.value then
            if (v1365.event == "burnt" or v1365.event == "fire") and l_v761_5[1] and l_v761_5[1].event == v1365.event then
                l_v761_5[1].time = globals.realtime;
                l_v761_5[1].data[1] = l_v761_5[1].data[1] + v1365.data[1];
                l_v761_5[1].text = string_utils.format(v1367, l_v761_5[1].data[1]);
            else
                local v1369 = v1365.data and string_utils.format(v1367, unpack(v1365.data)) or v1367;
                table_utils.insert(l_v761_5, 1, {
                    text = v1369,
                    props = v1365,
                    event = v1365 and v1365.event,
                    data = v1365 and v1365.data,
                    time = globals.realtime,
                    progress = {
                        [1] = 0
                    }
                });
            end;
        end;
    end;
    local function format_and_log_event(v1371, v1372, v1373)
        -- upvalues: render_proxy (ref), table_utils (ref), type (ref), ipairs (ref), tostring (ref), log_event (ref)
        local v1374 = {};
        local v1375 = {};
        if v1371 then
            local v1376 = v1371.color and "\a" .. v1371.color:to_hex() or "";
            v1374[2] = "\194\183\aDEFAULT ";
            v1374[1] = v1376;
            v1376 = v1371.color and "\a" .. v1371.color:to_hex() or "";
            local v1377;
            if v1371.color then
                v1377 = render_proxy.style == 1 and "\226\128\162\aDEFAULT " or "~\aDEFAULT ";
            else
                v1377 = "";
            end;
            v1375[2] = v1377;
            v1375[1] = v1376;
        end;
        for v1378 = 1, table_utils.maxn(v1372) do
            local v1379 = v1372[v1378];
            if v1379 then
                if type(v1379) == "table" then
                    local v1380 = v1372[v1378][1] == true and 1 or v1372[v1378][1] == false and 2 or 0;
                    for v1381, v1382 in ipairs(v1379) do
                        local v1383 = type(v1382);
                        if v1383 ~= "boolean" or v1381 ~= 1 then
                            if v1380 ~= 2 then
                                if v1383 == "table" then
                                    table_utils.move(v1382, 1, #v1382, #v1374 + 1, v1374);
                                else
                                    local v1384 = #v1374;
                                    local v1385 = v1384 + 1;
                                    local v1386 = v1384 + 2;
                                    local v1387 = v1384 + 3;
                                    local v1388 = "\r";
                                    local v1389 = tostring(v1382);
                                    v1374[v1387] = "\f";
                                    v1374[v1386] = v1389;
                                    v1374[v1385] = v1388;
                                end;
                            end;
                            if v1380 ~= 1 then
                                if v1383 == "table" then
                                    for v1390 = 1, #v1382 do
                                        local v1391 = #v1375;
                                        local v1392 = v1391 + 1;
                                        local v1393 = v1391 + 2;
                                        local v1394 = v1382[v1390];
                                        v1375[v1393] = "\aDEFAULT";
                                        v1375[v1392] = v1394;
                                    end;
                                else
                                    local v1395 = #v1375;
                                    local v1396 = v1395 + 1;
                                    local v1397 = v1395 + 2;
                                    local v1398 = v1395 + 3;
                                    local v1399 = "\aE6E6E660";
                                    local v1400 = tostring(v1382);
                                    v1375[v1398] = "\aDEFAULT";
                                    v1375[v1397] = v1400;
                                    v1375[v1396] = v1399;
                                end;
                            end;
                        end;
                    end;
                else
                    local v1401 = #v1374;
                    local v1402 = #v1375;
                    local v1403 = v1401 + 1;
                    local v1404 = v1401 + 2;
                    local v1405 = v1401 + 3;
                    local v1406 = "\a808080";
                    local v1407 = tostring(v1379);
                    v1374[v1405] = "\aDEFAULT";
                    v1374[v1404] = v1407;
                    v1374[v1403] = v1406;
                    v1403 = v1402 + 1;
                    v1404 = v1402 + 2;
                    v1405 = "\aE6E6E660";
                    v1375[v1404] = tostring(v1379);
                    v1375[v1403] = v1405;
                end;
            end;
        end;
        if v1373 and table_utils.maxn(v1373) > 0 then
            v1374[#v1374 + 1] = "  \f~\aDEFAULT  ";
            for v1408 = 1, table_utils.maxn(v1373) do
                local v1409 = v1373[v1408];
                if v1409 then
                    if type(v1409) == "table" then
                        for _, v1411 in ipairs(v1409) do
                            local v1412 = type(v1411);
                            if v1412 == "table" then
                                v1374[#v1374 + 1] = "\aAAAAAAFF";
                                table_utils.move(v1411, 1, #v1411, #v1374 + 1, v1374);
                            else
                                local v1413 = #v1374;
                                local v1414 = v1413 + 1;
                                local v1415 = v1413 + 2;
                                local v1416 = "\a707070FF";
                                v1374[v1415] = v1412 == "string" and v1411 or tostring(v1411);
                                v1374[v1414] = v1416;
                            end;
                            v1374[#v1374 + 1] = "\aDEFAULT";
                        end;
                    else
                        local v1417 = #v1374;
                        local v1418 = v1417 + 1;
                        local v1419 = v1417 + 2;
                        local v1420 = v1417 + 3;
                        local v1421 = "\a707070FF";
                        local v1422 = tostring(v1409);
                        v1374[v1420] = "\aDEFAULT";
                        v1374[v1419] = v1422;
                        v1374[v1418] = v1421;
                    end;
                    if v1408 < #v1373 then
                        v1374[#v1374 + 1] = "\a707070FF, \aDEFAULT";
                    end;
                end;
            end;
        end;
        log_event(v1371, table_utils.concat(v1374), table_utils.concat(v1375));
    end;
    l_v953_1 = {
        enemy_shot = {
            call = function (v1424)
                -- upvalues: l_v925_2 (ref), format_and_log_event (ref), Color (ref), string_utils (ref), aa_states (ref)
                if not l_v925_2.aa.value or v1424.damaged then
                    return;
                else
                    format_and_log_event({
                        event = "evaded",
                        color = Color("b0e2ff")
                    }, {
                        [1] = {
                            [1] = true,
                            [2] = "evaded ",
                            [3] = {
                                v1424.attacker:get_name()
                            }
                        },
                        [2] = {
                            [1] = false,
                            [2] = "Evaded ",
                            [3] = {
                                string_utils.limit(v1424.attacker:get_name(), 20, true)
                            }
                        },
                        [3] = {
                            [1] = "'s shot"
                        }
                    }, {
                        [1] = {
                            [1] = "state: ",
                            [2] = {
                                [1] = aa_states.states[v1424.last_state][1]
                            }
                        }
                    });
                    return;
                end;
            end
        },
        player_hurt = {
            given = function (v1425, v1426, _)
                -- upvalues: l_v925_2 (ref), table_utils (ref), l_v763_4 (ref), string_utils (ref), format_and_log_event (ref), Color (ref)
                if not l_v925_2.h.value then
                    return;
                elseif not table_utils.find(l_v763_4, v1425.weapon) and v1425.weapon ~= "knife" then
                    return;
                else
                    local v1428 = v1425.health == 0;
                    local v1429 = "a " .. v1425.weapon;
                    if v1425.weapon == "hegrenade" then
                        v1429 = "an HE grenade";
                    end;
                    local v1430 = string_utils.gsub(v1426:get_name(), "\n", "");
                    local v1431 = v1425.weapon == "inferno";
                    local v1432 = v1428 and "Killed" or "Hurt";
                    if v1428 and v1425.weapon == "hegrenade" then
                        v1432 = "Exploded";
                    elseif v1428 and v1425.weapon == "knife" then
                        v1432 = "Stabbed";
                    elseif v1431 then
                        v1432 = "Burnt";
                    end;
                    format_and_log_event({
                        event = v1431 and "fire" or "hit",
                        color = Color("A3D350"),
                        data = v1431 and {
                            [1] = v1425.dmg_health
                        } or nil
                    }, {
                        [1] = {
                            [1] = true,
                            [2] = nil,
                            [3] = " ",
                            [2] = string_utils.lower(v1432),
                            [4] = {
                                [1] = v1430
                            }
                        },
                        [2] = {
                            [1] = false,
                            [2] = nil,
                            [3] = " ",
                            [2] = v1432,
                            [4] = {
                                string_utils.limit(v1430, 20, true)
                            }
                        },
                        [3] = not v1428 and {
                            [1] = true,
                            [2] = " for ",
                            [3] = {
                                [1] = nil,
                                [2] = " hp",
                                [1] = v1425.dmg_health
                            }
                        } or nil,
                        [4] = not v1428 and {
                            [1] = false,
                            [2] = " for ",
                            [3] = {
                                [1] = v1431 and "%s" or v1425.dmg_health
                            }
                        } or nil,
                        [5] = v1428 and v1432 == "Burnt" and {
                            [1] = " to ",
                            [2] = {
                                [1] = "death"
                            }
                        } or nil,
                        [6] = (not (v1432 ~= "Killed") or v1432 == "Hurt") and {
                            [1] = true,
                            [2] = " with ",
                            [3] = {
                                [1] = v1429
                            }
                        } or nil
                    });
                    return;
                end;
            end,
            taken = function (v1433, v1434, v1435)
                -- upvalues: l_v925_2 (ref), game_data (ref), string_utils (ref), format_and_log_event (ref), Color (ref)
                if not l_v925_2.t.value then
                    return;
                else
                    local v1436 = v1434 == v1435 or v1435 == 0;
                    local v1437 = v1433.health == 0;
                    local l_weapon_0 = v1433.weapon;
                    local l_dmg_health_0 = v1433.dmg_health;
                    local v1440 = game_data.hitgroups[v1433.hitgroup] or "generic";
                    local v1441 = l_weapon_0 == "inferno";
                    local v1442 = v1437 and "Killed by" or "Hurt by";
                    local v1443 = v1437 and "killed" or "hurt";
                    if v1437 and l_weapon_0 == "hegrenade" then
                        local v1444 = "Exploded by";
                        v1443 = "exploded";
                        v1442 = v1444;
                    elseif v1437 and l_weapon_0 == "knife" then
                        local v1445 = "Stabbed by";
                        v1443 = "stabbed";
                        v1442 = v1445;
                    elseif v1441 then
                        local v1446 = "Burnt by";
                        v1443 = "burnt";
                        v1442 = v1446;
                    end;
                    v1435 = v1435 ~= 0 and string_utils.gsub(v1435:get_name(), "\n", "") or "world";
                    format_and_log_event({
                        event = v1441 and "burnt" or "hurt",
                        color = Color("ff7070"),
                        data = v1441 and {
                            [1] = v1433.dmg_health
                        } or nil
                    }, {
                        [1] = v1436 and {
                            [1] = true,
                            [2] = nil,
                            [3] = " ",
                            [4] = nil,
                            [5] = " ",
                            [2] = {
                                [1] = "you"
                            },
                            [4] = v1443
                        } or {
                            [1] = true,
                            [2] = nil,
                            [3] = " ",
                            [2] = string_utils.lower(v1442)
                        },
                        [2] = v1436 and {
                            [1] = false,
                            [2] = nil,
                            [3] = " ",
                            [4] = nil,
                            [5] = " ",
                            [2] = {
                                [1] = "You"
                            },
                            [4] = v1443
                        } or {
                            [1] = false,
                            [2] = nil,
                            [3] = " ",
                            [2] = v1442
                        },
                        [3] = {
                            [1] = true,
                            [2] = v1436 and {
                                [1] = "yourself"
                            } or {
                                [1] = v1435
                            }
                        },
                        [4] = {
                            [1] = false,
                            [2] = v1436 and {
                                [1] = "yourself"
                            } or {
                                string_utils.limit(v1435, 20, true)
                            }
                        },
                        [5] = not v1436 and v1440 ~= "generic" and {
                            [1] = " in ",
                            [2] = {
                                [1] = v1440
                            }
                        } or nil,
                        [6] = not v1437 and {
                            [1] = true,
                            [2] = " for ",
                            [3] = {
                                [1] = nil,
                                [2] = " hp",
                                [1] = l_dmg_health_0
                            }
                        } or nil,
                        [7] = not v1437 and {
                            [1] = false,
                            [2] = " for ",
                            [3] = {
                                [1] = v1441 and "%s" or l_dmg_health_0
                            }
                        } or nil
                    });
                    return;
                end;
            end,
            call = function (v1447)
                -- upvalues: l_v953_1 (ref), local_player (ref)
                local l_player_hurt_0 = l_v953_1.player_hurt;
                local v1449 = entity.get(v1447.userid, true);
                local v1450 = v1447.attacker ~= 0 and entity.get(v1447.attacker, true) or 0;
                if v1450 == local_player.self and v1449 ~= local_player.self then
                    l_player_hurt_0.given(v1447, v1449, v1450);
                elseif v1449 == local_player.self then
                    l_player_hurt_0.taken(v1447, v1449, v1450);
                end;
            end
        },
        aim_ack = {
            hit = function (v1451)
                -- upvalues: l_v925_2 (ref), local_player (ref), string_utils (ref), game_data (ref), format_and_log_event (ref), Color (ref), menu_items (ref), math_utils (ref)
                if not l_v925_2.h.value then
                    return;
                else
                    local v1452 = not v1451.target:is_alive();
                    local v1453 = "Hit";
                    if not v1451.target:is_alive() then
                        v1453 = local_player.weapon and local_player.weapon.m_iItemDefinitionIndex == 31 and "Tased" or "Killed";
                    end;
                    local v1454 = string_utils.gsub(v1451.target:get_name(), "\n", "");
                    local v1455 = game_data.hitgroups[v1451.hitgroup];
                    local v1456 = game_data.hitgroups[v1451.wanted_hitgroup];
                    local v1457 = not v1452 and v1451.hitgroup ~= v1451.wanted_hitgroup;
                    local v1458 = not v1452 and v1451.wanted_damage - v1451.damage > 10;
                    local v1459 = nil;
                    if v1458 and v1457 and v1456 then
                        v1459 = {
                            [1] = nil,
                            [2] = "-",
                            [1] = v1456,
                            [3] = v1451.wanted_damage
                        };
                    elseif v1458 then
                        v1459 = {
                            [1] = nil,
                            [2] = " hp",
                            [1] = v1451.wanted_damage
                        };
                    end;
                    local l_v1423_0 = format_and_log_event;
                    local v1461 = {
                        event = "hit",
                        color = Color("cded74")
                    };
                    local v1462 = {
                        [1] = {
                            [1] = true,
                            [2] = nil,
                            [3] = " ",
                            [2] = string_utils.lower(v1453),
                            [4] = {
                                [1] = v1454
                            }
                        },
                        [2] = {
                            [1] = false,
                            [2] = nil,
                            [3] = " ",
                            [2] = v1453,
                            [4] = {
                                string_utils.limit(v1454, 20, true)
                            }
                        },
                        [3] = v1455 and v1455 ~= "generic" and {
                            [1] = v1453 == "Hit" and "'s " or " in ",
                            [2] = {
                                [1] = v1455
                            }
                        } or nil,
                        [4] = v1457 and {
                            [1] = "\aD59A4DFF!\r"
                        } or nil,
                        [5] = not v1452 and {
                            [1] = true,
                            [2] = " for ",
                            [3] = {
                                [1] = nil,
                                [2] = " hp",
                                [1] = v1451.damage
                            }
                        } or nil,
                        [6] = not v1452 and {
                            [1] = false,
                            [2] = " for ",
                            [3] = {
                                [1] = v1451.damage
                            }
                        } or nil,
                        [7] = v1458 and {
                            [1] = "\aD59A4DFF!\r"
                        } or nil
                    };
                    local v1463 = {};
                    local v1464;
                    if v1459 then
                        v1464 = {
                            [1] = "exp: ",
                            [2] = v1459
                        };
                    else
                        v1464 = v1459;
                    end;
                    v1463[1] = v1464;
                    v1463[2] = v1451.backtrack ~= 0 and {
                        [1] = "bt: ",
                        [2] = {
                            [1] = nil,
                            [2] = "t",
                            [1] = v1451.backtrack
                        }
                    } or nil;
                    v1463[3] = menu_items.rage.selection.hitchance:get() - v1451.hitchance > 5 and {
                        [1] = "hc: ",
                        [2] = nil,
                        [3] = "\226\174\159",
                        [2] = {
                            [1] = nil,
                            [2] = "%",
                            [1] = math_utils.floor(v1451.hitchance)
                        }
                    } or nil;
                    l_v1423_0(v1461, v1462, v1463);
                    return;
                end;
            end,
            miss = function (v1465)
                -- upvalues: l_v925_2 (ref), string_utils (ref), game_data (ref), format_and_log_event (ref), Color (ref), menu_items (ref)
                if not l_v925_2.m.value then
                    return;
                else
                    local v1466 = "Missed";
                    local v1467 = string_utils.gsub(v1465.target:get_name(), "\n", "");
                    local v1468 = game_data.hitgroups[v1465.wanted_hitgroup];
                    local l_state_0 = v1465.state;
                    if l_state_0 == "prediction error" and v1465.backtrack > 2 then
                        l_state_0 = "unpredicted occasion";
                    elseif l_state_0 == "spread" and v1465.spread < 0.1 then
                        l_state_0 = "occlusion";
                    elseif l_state_0 == "correction" then
                        l_state_0 = "resolver";
                    end;
                    format_and_log_event({
                        event = "miss",
                        color = Color("d9b0ff")
                    }, {
                        [1] = {
                            [1] = true,
                            [2] = nil,
                            [3] = " ",
                            [2] = string_utils.lower(v1466),
                            [4] = {
                                [1] = v1467
                            }
                        },
                        [2] = {
                            [1] = false,
                            [2] = nil,
                            [3] = " ",
                            [2] = v1466,
                            [4] = {
                                string_utils.limit(v1467, 20, true)
                            }
                        },
                        [3] = v1468 and {
                            [1] = "'s ",
                            [2] = {
                                [1] = v1468
                            }
                        },
                        [4] = {
                            [1] = " due to ",
                            [2] = {
                                [1] = l_state_0
                            }
                        }
                    }, {
                        [1] = v1465.backtrack ~= 0 and {
                            [1] = "\206\148: ",
                            [2] = {
                                [1] = nil,
                                [2] = "t",
                                [1] = v1465.backtrack
                            }
                        } or nil,
                        [2] = v1465.spread and {
                            [1] = "\226\136\160: ",
                            [2] = {
                                ("%.2f\194\186"):format(v1465.spread)
                            }
                        } or nil,
                        [3] = menu_items.rage.selection.hitchance:get() - v1465.hitchance > 5 and {
                            [1] = "hc: ",
                            [2] = {
                                [1] = nil,
                                [2] = "%",
                                [1] = v1465.hitchance
                            }
                        } or nil
                    });
                    return;
                end;
            end,
            call = function (v1470)
                -- upvalues: l_v953_1 (ref)
                local l_aim_ack_0 = l_v953_1.aim_ack;
                if v1470.state then
                    l_aim_ack_0.miss(v1470);
                else
                    l_aim_ack_0.hit(v1470);
                end;
            end
        },
        round_start = {
            call = function (_)
                -- upvalues: l_v952_0 (ref)
                l_v952_0.round = entity.get_game_rules().m_totalRoundsPlayed;
            end
        },
        ab_set = {
            call = function (v1473)
                -- upvalues: l_v925_2 (ref), format_and_log_event (ref), Color (ref), string_utils (ref)
                if not l_v925_2.ab.value then
                    return;
                else
                    if v1473.set then
                        format_and_log_event({
                            event = "ab",
                            color = Color("b0bdff")
                        }, {
                            [1] = {
                                [1] = true,
                                [2] = {
                                    [1] = "anti-brute "
                                }
                            },
                            [2] = {
                                [1] = false,
                                [2] = "Anti-brute "
                            },
                            [3] = v1473.mode == "Adjust" and {
                                [1] = "weight: ",
                                [2] = {
                                    string_utils.format("%.2f", v1473.weight)
                                }
                            } or {
                                [1] = "config: ",
                                [2] = {
                                    string_utils.limit(v1473.config, 16, true)
                                }
                            }
                        }, {
                            [1] = v1473.trigger and {
                                [1] = "reason: ",
                                [2] = {
                                    [1] = v1473.trigger
                                }
                            } or nil
                        });
                    else
                        format_and_log_event({
                            event = "ab",
                            color = Color("b0bdff")
                        }, {
                            [1] = {
                                [1] = true,
                                [2] = {
                                    [1] = "anti-brute "
                                }
                            },
                            [2] = {
                                [1] = false,
                                [2] = "Anti-brute "
                            },
                            [3] = {
                                [1] = {
                                    [1] = "reset"
                                }
                            }
                        }, {
                            [1] = v1473.trigger and {
                                [1] = "reason: ",
                                [2] = {
                                    [1] = v1473.trigger
                                }
                            } or nil
                        });
                    end;
                    return;
                end;
            end
        }
    };
    l_v925_2:set_callback(function (v1474)
        -- upvalues: next (ref), l_v953_1 (ref), events (ref), menu_items (ref)
        for v1475, v1476 in next, l_v953_1 do
            events[v1475](v1476.call, v1474.value);
        end;
        menu_items.misc.other.eventlog:override(v1474.value and {} or nil);
    end, true);
    menu_items.misc.other.eventlog:depend(true, {
        [1] = nil,
        [2] = false,
        [1] = l_v925_2
    });
end;
link_aa_builder_to_config_or_features_module_or_aa_runtime_context = {};
link_aa_builder_to_config_or_features_module_or_aa_runtime_context.aspect = {
    active = false,
    value = screen_size.x / screen_size.y,
    init = screen_size.x / screen_size.y,
    work = function ()
        -- upvalues: link_aa_builder_to_config_or_features_module_or_aa_runtime_context (ref), ui_tabs (ref), anim_manager (ref), events (ref)
        local l_aspect_0 = link_aa_builder_to_config_or_features_module_or_aa_runtime_context.aspect;
        local l_aspect_1 = ui_tabs.settings.aspect;
        if l_aspect_1.value then
            local v1479 = l_aspect_1.ratio.value * 0.01;
            l_aspect_0.value = anim_manager.lerp(l_aspect_0.value, v1479, 8, 0.001);
            l_aspect_0.active = v1479 ~= l_aspect_0.value;
            cvar.r_aspectratio:float(l_aspect_0.value);
            if v1479 == l_aspect_0.value then
                events.render:unset(l_aspect_0.work);
            end;
        else
            l_aspect_0.value = anim_manager.lerp(l_aspect_0.value, l_aspect_0.init);
            cvar.r_aspectratio:float(l_aspect_0.value);
            if l_aspect_0.value == l_aspect_0.init then
                events.render:unset(l_aspect_0.work);
                cvar.r_aspectratio:float(0);
                l_aspect_0.active = false;
            end;
        end;
    end,
    activate = function ()
        -- upvalues: link_aa_builder_to_config_or_features_module_or_aa_runtime_context (ref), ui_tabs (ref), events (ref)
        local l_aspect_2 = link_aa_builder_to_config_or_features_module_or_aa_runtime_context.aspect;
        local l_aspect_3 = ui_tabs.settings.aspect;
        if not l_aspect_2.active and not l_aspect_3.value and l_aspect_2.value == l_aspect_2.init then
            return;
        else
            if not l_aspect_2.active then
                events.render:set(l_aspect_2.work);
                l_aspect_2.active = true;
            end;
            return;
        end;
    end,
    run = function ()
        -- upvalues: link_aa_builder_to_config_or_features_module_or_aa_runtime_context (ref), ui_tabs (ref), events (ref)
        local l_aspect_4 = link_aa_builder_to_config_or_features_module_or_aa_runtime_context.aspect;
        local l_aspect_5 = ui_tabs.settings.aspect;
        l_aspect_5:set_callback(l_aspect_4.activate, true);
        l_aspect_5.ratio:set_callback(l_aspect_4.activate);
        events.shutdown:set(function ()
            cvar.r_aspectratio:float(0);
        end);
    end
};
link_aa_builder_to_config_or_features_module_or_aa_runtime_context.viewmodel = {
    active = false,
    was_active = false,
    value = {},
    init = {},
    e_names = {
        [1] = "fov",
        [2] = "x",
        [3] = "y",
        [4] = "z"
    },
    e_cvars = {
        [1] = "fov",
        [2] = "offset_x",
        [3] = "offset_y",
        [4] = "offset_z"
    },
    restore = function ()
        -- upvalues: link_aa_builder_to_config_or_features_module_or_aa_runtime_context (ref)
        local l_viewmodel_0 = link_aa_builder_to_config_or_features_module_or_aa_runtime_context.viewmodel;
        cvar.viewmodel_fov:float(l_viewmodel_0.init.fov, true);
        cvar.viewmodel_offset_x:float(l_viewmodel_0.init.x, true);
        cvar.viewmodel_offset_y:float(l_viewmodel_0.init.y, true);
        cvar.viewmodel_offset_z:float(l_viewmodel_0.init.z, true);
        l_viewmodel_0.was_active = false;
    end,
    update = function ()
        -- upvalues: link_aa_builder_to_config_or_features_module_or_aa_runtime_context (ref), ipairs (ref)
        local l_viewmodel_1 = link_aa_builder_to_config_or_features_module_or_aa_runtime_context.viewmodel;
        for v1486, v1487 in ipairs(l_viewmodel_1.e_names) do
            if not l_viewmodel_1.active then
                l_viewmodel_1.init[v1487] = cvar["viewmodel_" .. l_viewmodel_1.e_cvars[v1486]]:float();
            end;
            l_viewmodel_1.value[v1487] = l_viewmodel_1.init[v1487];
        end;
    end,
    work = function ()
        -- upvalues: link_aa_builder_to_config_or_features_module_or_aa_runtime_context (ref), ui_tabs (ref), anim_manager (ref), events (ref)
        local l_viewmodel_2 = link_aa_builder_to_config_or_features_module_or_aa_runtime_context.viewmodel;
        local l_viewmodel_3 = ui_tabs.settings.viewmodel;
        if not l_viewmodel_2.active then
            return;
        else
            if l_viewmodel_3.value then
                l_viewmodel_2.was_active = true;
                local v1490 = {};
                local v1491 = true;
                for v1492 = 1, #l_viewmodel_2.e_names do
                    local v1493 = l_viewmodel_2.e_names[v1492];
                    v1490[v1493] = l_viewmodel_3[v1493].value * (v1493 == "fov" and 1 or 0.1);
                    l_viewmodel_2.value[v1493] = anim_manager.lerp(l_viewmodel_2.value[v1493], v1490[v1493]);
                    if l_viewmodel_2.value[v1493] ~= v1490[v1493] then
                        v1491 = false;
                    end;
                    cvar["viewmodel_" .. l_viewmodel_2.e_cvars[v1492]]:float(l_viewmodel_2.value[v1493], true);
                end;
                l_viewmodel_2.active = not v1491;
                if v1491 then
                    events.render:unset(l_viewmodel_2.work);
                end;
            else
                local v1494 = true;
                for v1495 = 1, #l_viewmodel_2.e_names do
                    local v1496 = l_viewmodel_2.e_names[v1495];
                    l_viewmodel_2.value[v1496] = anim_manager.lerp(l_viewmodel_2.value[v1496], l_viewmodel_2.init[v1496]);
                    if l_viewmodel_2.value[v1496] ~= l_viewmodel_2.init[v1496] then
                        v1494 = false;
                    end;
                    cvar["viewmodel_" .. l_viewmodel_2.e_cvars[v1495]]:float(l_viewmodel_2.value[v1496], true);
                end;
                if v1494 then
                    events.render:unset(l_viewmodel_2.work);
                    l_viewmodel_2.restore();
                    l_viewmodel_2.active = false;
                end;
            end;
            return;
        end;
    end,
    activate = function ()
        -- upvalues: link_aa_builder_to_config_or_features_module_or_aa_runtime_context (ref), ui_tabs (ref), events (ref)
        local l_viewmodel_4 = link_aa_builder_to_config_or_features_module_or_aa_runtime_context.viewmodel;
        if not ui_tabs.settings.viewmodel.value and not l_viewmodel_4.was_active then
            return;
        else
            if not l_viewmodel_4.active then
                events.render:set(l_viewmodel_4.work);
                l_viewmodel_4.active = true;
            end;
            return;
        end;
    end,
    run = function (viewmodel_module)
        -- upvalues: ui_tabs (ref), next (ref), events (ref)
        local l_viewmodel_5 = ui_tabs.settings.viewmodel;
        viewmodel_module.update();
        l_viewmodel_5:set_callback(viewmodel_module.activate, true);
        l_viewmodel_5.res:set_callback(function ()
            -- upvalues: l_viewmodel_5 (ref), viewmodel_module (ref)
            l_viewmodel_5.fov:set(viewmodel_module.init.fov);
            l_viewmodel_5.x:set(viewmodel_module.init.x * 10);
            l_viewmodel_5.y:set(viewmodel_module.init.y * 10);
            l_viewmodel_5.z:set(viewmodel_module.init.z * 10);
        end);
        for _, v1501 in next, l_viewmodel_5[1] do
            v1501:set_callback(viewmodel_module.activate);
        end;
        events.shutdown:set(viewmodel_module.restore);
    end
};
link_aa_builder_to_config_or_features_module_or_aa_runtime_context.marker = {
    list = {},
    duration = ui_tabs.settings.marker.dur.value * 0.1,
    marker = function (v1502, v1503, v1504)
        -- upvalues: render_proxy (ref), math_utils (ref), link_aa_builder_to_config_or_features_module_or_aa_runtime_context (ref), colors (ref), Vector (ref), image_assets (ref)
        local v1505 = v1502.pos and v1502.pos:to_screen();
        if v1505 then
            v1505 = v1505 / render_proxy.dpi;
            local v1506 = v1502.state == nil;
            local v1507 = 1 - math_utils.max((v1502.time - globals.realtime) / link_aa_builder_to_config_or_features_module_or_aa_runtime_context.marker.duration, 0);
            if v1504 then
                local v1508 = (v1506 and 32 or 16) * v1503;
                render_proxy.circle(v1505, (v1506 and colors.accent or colors.black):alpha_modulate(1 - v1503, true), v1508);
            end;
            if v1506 then
                render_proxy.shadow(v1505 - Vector(1, 1), v1505 - Vector(1, 1), colors.accent, 40);
                render_proxy.texture(image_assets.bfly, v1505 - Vector(5, 5), Vector(9, 9), colors.accent);
            else
                render_proxy.circle(v1505, colors.white:alpha_modulate(128), 2);
                render_proxy.circle_outline(v1505, colors.white:alpha_modulate(0.5 - v1507, true), 24 * v1507, 0, 1, 1);
            end;
        end;
    end,
    work = function ()
        -- upvalues: link_aa_builder_to_config_or_features_module_or_aa_runtime_context (ref), ipairs (ref), anim_manager (ref), render_proxy (ref), table_utils (ref)
        local l_marker_0 = link_aa_builder_to_config_or_features_module_or_aa_runtime_context.marker;
        for v1510, v1511 in ipairs(l_marker_0.list) do
            local v1512 = v1511.time > globals.realtime;
            local v1513 = anim_manager.condition(v1511.progress, v1512, {
                [1] = 3,
                [2] = -4
            }, {
                [1] = {
                    [1] = 1,
                    [2] = 4
                },
                [2] = {
                    [1] = 3,
                    [2] = 4
                }
            });
            render_proxy.push_alpha(v1513);
            l_marker_0.marker(v1511, v1513, v1512);
            render_proxy.pop_alpha();
            if not v1512 and v1513 == 0 then
                table_utils.remove(l_marker_0.list, v1510);
            end;
        end;
    end,
    append = function (v1514)
        -- upvalues: link_aa_builder_to_config_or_features_module_or_aa_runtime_context (ref), ui_tabs (ref), table_utils (ref)
        local l_marker_1 = link_aa_builder_to_config_or_features_module_or_aa_runtime_context.marker;
        local l_marker_2 = ui_tabs.settings.marker;
        if not v1514.state and not l_marker_2.hit.value or v1514.state and not l_marker_2.miss.value then
            return;
        else
            table_utils.insert(l_marker_1.list, 1, {
                state = v1514.state,
                pos = v1514.aim,
                damage = v1514.damage,
                time = globals.realtime + l_marker_1.duration,
                progress = {
                    [1] = 0
                }
            });
            return;
        end;
    end,
    run = function (shot_marker_module)
        -- upvalues: ui_tabs (ref), events (ref), menu_items (ref), iif (ref), table_utils (ref)
        local l_marker_3 = ui_tabs.settings.marker;
        l_marker_3:set_callback(function (v1519)
            -- upvalues: events (ref), shot_marker_module (ref), menu_items (ref), iif (ref), table_utils (ref)
            events.aim_ack(shot_marker_module.append, v1519.value);
            events.render(shot_marker_module.work, v1519.value);
            menu_items.world.other.hitmarker:override(iif(v1519.value, false, nil));
            if not v1519.value then
                table_utils.clear(shot_marker_module.list);
            end;
        end, true);
        l_marker_3.dur:set_callback(function (v1520)
            -- upvalues: shot_marker_module (ref)
            shot_marker_module.duration = v1520.value * 0.1;
        end);
        menu_items.world.other.hitmarker:depend(true, {
            [1] = nil,
            [2] = false,
            [1] = l_marker_3
        });
    end
};
link_aa_builder_to_config_or_features_module_or_aa_runtime_context.console = {
    alpha = 0,
    overridden = false,
    names = {
        [1] = "vgui_white",
        [2] = "vgui/hud/800corner1",
        [3] = "vgui/hud/800corner2",
        [4] = "vgui/hud/800corner3",
        [5] = "vgui/hud/800corner4"
    },
    cached = {},
    progress = {
        [1] = 0
    },
    in_console = utils.get_vfunc("client.dll", "GameConsole004", 5, "bool(__thiscall*)(void*)"),
    is_cursor_locked = utils.get_vfunc("vguimatsurface.dll", "VGUI_Surface031", 58, "bool(__thiscall*)(void*)"),
    work = function ()
        -- upvalues: link_aa_builder_to_config_or_features_module_or_aa_runtime_context (ref), ui_tabs (ref), ipairs (ref)
        local l_console_0 = link_aa_builder_to_config_or_features_module_or_aa_runtime_context.console;
        local l_vgui_0 = ui_tabs.settings.vgui;
        if l_vgui_0.value and (l_console_0.is_cursor_locked() or l_console_0.in_console()) then
            for _, v1524 in ipairs(l_console_0.cached) do
                v1524:color_modulate(l_vgui_0.color.value);
                v1524:alpha_modulate(l_console_0.alpha * (l_vgui_0.color.value.a / 255));
            end;
            l_console_0.overridden = true;
        elseif l_console_0.overridden then
            l_console_0.restore();
            local v1525 = false;
            l_console_0.progress = {
                [1] = 0
            };
            l_console_0.overridden = v1525;
        end;
    end,
    alphen = function ()
        -- upvalues: link_aa_builder_to_config_or_features_module_or_aa_runtime_context (ref), anim_manager (ref)
        local l_console_1 = link_aa_builder_to_config_or_features_module_or_aa_runtime_context.console;
        l_console_1.alpha = anim_manager.condition(l_console_1.progress, l_console_1.is_cursor_locked() or l_console_1.in_console(), 3);
    end,
    restore = function ()
        -- upvalues: ipairs (ref), link_aa_builder_to_config_or_features_module_or_aa_runtime_context (ref), Color (ref)
        for _, v1528 in ipairs(link_aa_builder_to_config_or_features_module_or_aa_runtime_context.console.cached) do
            v1528:color_modulate(Color());
            v1528:alpha_modulate(1);
        end;
    end,
    run = function (vgui_color_module)
        -- upvalues: ui_tabs (ref), ipairs (ref), events (ref)
        local l_vgui_1 = ui_tabs.settings.vgui;
        for _, v1532 in ipairs(vgui_color_module.names) do
            materials.get_materials(v1532, false, function (v1533)
                -- upvalues: vgui_color_module (ref)
                vgui_color_module.cached[#vgui_color_module.cached + 1] = v1533;
            end);
        end;
        l_vgui_1:set_callback(function (v1534)
            -- upvalues: events (ref), vgui_color_module (ref)
            events.pre_render(vgui_color_module.alphen, v1534.value);
            events.pre_render(vgui_color_module.work, v1534.value);
            if v1534.value then
                vgui_color_module.overridden = false;
            else
                vgui_color_module.restore();
            end;
        end, true);
        l_vgui_1.color:set_callback(function (_)
            -- upvalues: vgui_color_module (ref), l_vgui_1 (ref)
            vgui_color_module.overridden = not l_vgui_1.value;
        end);
        events.shutdown:set(vgui_color_module.restore);
    end
};
link_aa_builder_to_config_or_features_module_or_aa_runtime_context.nadius = {
    inferno = {
        list = {},
        gather = function (v1536)
            -- upvalues: local_player (ref), Vector (ref), next (ref)
            entity.get_entities("CInferno", nil, function (v1537)
                -- upvalues: local_player (ref), v1536 (ref), Vector (ref)
                local l_m_vecOrigin_0 = v1537.m_vecOrigin;
                local v1539 = v1537:get_index();
                if cvar.mp_friendlyfire:int() == 0 and local_player.valid then
                    local v1540 = v1537 and v1537.m_hOwnerEntity;
                    if v1540 and local_player.self ~= v1540 and local_player.self.m_iTeamNum == v1540.m_iTeamNum then
                        return;
                    end;
                end;
                v1536.list[v1539] = v1536.list[v1539] or {
                    [0] = {
                        [1] = 0,
                        [2] = true,
                        [3] = v1537.m_nFireEffectTickBegin
                    },
                    [1] = {
                        [1] = l_m_vecOrigin_0,
                        [2] = {
                            [1] = 0,
                            [2] = true
                        }
                    }
                };
                local v1541 = v1536.list[v1539];
                for v1542 = 0, v1537.m_fireCount - 1 do
                    local v1543 = v1542 + 1;
                    v1541[v1543] = v1541[v1543] or {
                        [1] = l_m_vecOrigin_0 + Vector(v1537.m_fireXDelta[v1542], v1537.m_fireYDelta[v1542], v1537.m_fireZDelta[v1542]),
                        [2] = {
                            [1] = 0,
                            [2] = false
                        }
                    };
                    v1541[v1543][2][2] = v1537.m_bFireIsBurning[v1542];
                end;
            end);
            for v1544, v1545 in next, v1536.list do
                local v1546 = entity.get(v1544);
                if not v1546 or v1546:get_classname() ~= "CInferno" then
                    v1545[0][2] = false;
                end;
            end;
        end,
        draw = function (v1547)
            -- upvalues: ui_tabs (ref), next (ref), anim_manager (ref), local_player (ref), render_proxy (ref)
            local l_value_5 = ui_tabs.settings.nadius.fire.color.value;
            for v1549, v1550 in next, v1547.list do
                local v1551 = anim_manager.condition(v1550[0], v1550[0][2], 3);
                local v1552 = 1 - (globals.tickcount - v1550[0][3]) / to_ticks(7);
                for v1553 = 1, #v1550 do
                    local v1554 = v1550[v1553];
                    local v1555 = anim_manager.condition(v1554[2], v1554[2][2] and local_player.origin:dist(v1554[1]) < 576, 3);
                    if v1555 > 0 then
                        if v1553 == 1 then
                            render_proxy.circle_3d_gradient(v1554[1], l_value_5:alpha_modulate(v1551 * v1555 * 0.6, true), l_value_5:alpha_modulate(0), 70 * v1555, 0, 1);
                            render_proxy.circle_3d_outline(v1554[1], l_value_5:alpha_modulate(v1551 * v1555, true), 70 * v1555, 0, v1552, 4);
                        else
                            render_proxy.circle_3d(v1554[1], l_value_5:alpha_modulate(v1551 * v1555 * 0.5, true), 70 * v1555, 0, 1);
                        end;
                    end;
                end;
                if v1551 == 0 and not v1550[0][2] then
                    v1547.list[v1549] = nil;
                end;
            end;
        end
    },
    smoke = {
        list = {},
        gather = function (v1556)
            -- upvalues: next (ref)
            entity.get_entities("CSmokeGrenadeProjectile", nil, function (v1557)
                -- upvalues: v1556 (ref)
                if not v1557.m_bDidSmokeEffect then
                    return;
                else
                    local v1558 = v1557:get_index();
                    v1556.list[v1558] = v1556.list[v1558] or {
                        [1] = v1557.m_vecOrigin,
                        [2] = {
                            [1] = 0,
                            [2] = true
                        },
                        [3] = v1557.m_nSmokeEffectTickBegin
                    };
                    return;
                end;
            end);
            for v1559, v1560 in next, v1556.list do
                local v1561 = entity.get(v1559);
                if not v1561 or v1561:get_classname() ~= "CSmokeGrenadeProjectile" then
                    v1560[2][2] = false;
                end;
            end;
        end,
        draw = function (v1562)
            -- upvalues: ui_tabs (ref), next (ref), anim_manager (ref), local_player (ref), render_proxy (ref)
            local l_value_6 = ui_tabs.settings.nadius.smoke.color.value;
            for v1564, v1565 in next, v1562.list do
                local v1566 = 1 - (globals.tickcount - v1565[3]) / to_ticks(18);
                local v1567 = anim_manager.condition(v1565[2], v1565[2][2] and local_player.origin:dist(v1565[1]) < 576, 3);
                render_proxy.circle_3d(v1565[1], l_value_6:alpha_modulate(v1567, true), 150 * v1567, 0, 1);
                render_proxy.circle_3d_outline(v1565[1], l_value_6:alpha_modulate(v1567 * 255), 150 * v1567, 0, v1566, 3);
                if v1567 == 0 and not v1565[2][2] then
                    v1562.list[v1564] = nil;
                end;
            end;
        end
    },
    gather = function ()
        -- upvalues: link_aa_builder_to_config_or_features_module_or_aa_runtime_context (ref)
        local l_nadius_0 = link_aa_builder_to_config_or_features_module_or_aa_runtime_context.nadius;
        l_nadius_0.inferno:gather();
        l_nadius_0.smoke:gather();
    end,
    draw = function ()
        -- upvalues: link_aa_builder_to_config_or_features_module_or_aa_runtime_context (ref), ui_tabs (ref), local_player (ref)
        local l_nadius_1 = link_aa_builder_to_config_or_features_module_or_aa_runtime_context.nadius;
        local l_nadius_2 = ui_tabs.settings.nadius;
        if not local_player.origin then
            return;
        elseif not globals.is_in_game then
            return l_nadius_1.clear();
        else
            if l_nadius_2.fire.value then
                l_nadius_1.inferno:draw();
            end;
            if l_nadius_2.smoke.value then
                l_nadius_1.smoke:draw();
            end;
            return;
        end;
    end,
    clear = function ()
        -- upvalues: link_aa_builder_to_config_or_features_module_or_aa_runtime_context (ref)
        local l_inferno_0 = link_aa_builder_to_config_or_features_module_or_aa_runtime_context.nadius.inferno;
        local l_smoke_0 = link_aa_builder_to_config_or_features_module_or_aa_runtime_context.nadius.smoke;
        local v1573 = {};
        l_smoke_0.list = {};
        l_inferno_0.list = v1573;
    end,
    run = function (nade_radius_module)
        -- upvalues: ui_tabs (ref), events (ref)
        ui_tabs.settings.nadius:set_callback(function (v1575)
            -- upvalues: events (ref), nade_radius_module (ref)
            events.net_update_end(nade_radius_module.gather, v1575.value);
            events.pre_hud_render(nade_radius_module.draw, v1575.value);
            events.round_poststart(nade_radius_module.clear, v1575.value);
            if not v1575.value then
                local l_inferno_1 = nade_radius_module.inferno;
                local l_smoke_1 = nade_radius_module.smoke;
                local v1578 = {};
                l_smoke_1.list = {};
                l_inferno_1.list = v1578;
            end;
        end, true);
    end
};
link_aa_builder_to_config_or_features_module_or_aa_runtime_context.scope = {
    progress = {
        [1] = 0
    },
    work = function ()
        -- upvalues: local_player (ref), anim_manager (ref), link_aa_builder_to_config_or_features_module_or_aa_runtime_context (ref), ui_tabs (ref), colors (ref), render_proxy (ref), Vector (ref), screen_center (ref)
        if not local_player.self or not local_player.valid or not globals.is_in_game then
            return;
        else
            local v1579 = anim_manager.condition(link_aa_builder_to_config_or_features_module_or_aa_runtime_context.scope.progress, local_player.self.m_bIsScoped and not local_player.in_score, {
                [1] = 2.5,
                [2] = 6
            }, {
                [1] = {
                    [1] = 1,
                    [2] = 4
                },
                [2] = {
                    [1] = 2,
                    [2] = 2
                }
            });
            if v1579 == 0 then
                return;
            else
                local l_scope_0 = ui_tabs.settings.scope;
                local l_value_7 = l_scope_0.gap.value;
                local v1582 = (l_scope_0.gap.value + l_scope_0.size.value) * v1579;
                local v1583 = nil;
                if l_scope_0.clr.value == "Custom" then
                    local v1584 = l_scope_0.clr.color.value[1];
                    local v1585 = l_scope_0.clr.color.value[2];
                    if v1584 == "Fade" then
                        v1583 = {
                            v1585,
                            v1585:alpha_modulate(0)
                        };
                    else
                        v1583 = {
                            [1] = v1585[1],
                            [2] = v1585[2]
                        };
                    end;
                elseif l_scope_0.clr.value == "Accent" then
                    v1583 = {
                        colors.accent,
                        colors.secondary:alpha_modulate(0)
                    };
                elseif l_scope_0.clr.value == "Accent inverted" then
                    v1583 = {
                        [1] = colors.accent:alpha_modulate(0),
                        [2] = colors.secondary
                    };
                end;
                render_proxy.push_alpha(v1579);
                render_proxy.gradient(Vector(screen_center.x + l_value_7, screen_center.y), Vector(screen_center.x + v1582 + 1, screen_center.y + 1), v1583[1], v1583[2], v1583[1], v1583[2]);
                render_proxy.gradient(Vector(screen_center.x - l_value_7 + 1, screen_center.y), Vector(screen_center.x - v1582, screen_center.y + 1), v1583[1], v1583[2], v1583[1], v1583[2]);
                render_proxy.gradient(Vector(screen_center.x, screen_center.y + l_value_7), Vector(screen_center.x + 1, screen_center.y + v1582 + 1), v1583[1], v1583[1], v1583[2], v1583[2]);
                if not l_scope_0.t.value then
                    render_proxy.gradient(Vector(screen_center.x, screen_center.y - l_value_7 + 1), Vector(screen_center.x + 1, screen_center.y - v1582), v1583[1], v1583[1], v1583[2], v1583[2]);
                end;
                render_proxy.pop_alpha();
                return;
            end;
        end;
    end,
    run = function (scope_module)
        -- upvalues: ui_tabs (ref), events (ref), menu_items (ref)
        local l_scope_1 = ui_tabs.settings.scope;
        l_scope_1:set_callback(function (v1588)
            -- upvalues: events (ref), scope_module (ref), menu_items (ref)
            events.render(scope_module.work, v1588.value);
            menu_items.world.main.zoom.scope:override(v1588.value and "Remove All" or nil);
        end, true);
        menu_items.world.main.zoom.scope:depend(true, {
            [1] = nil,
            [2] = false,
            [1] = l_scope_1
        });
    end
};
link_aa_builder_to_config_or_features_module_or_aa_runtime_context.breaker = {
    animlayer_t = ffi.typeof("struct { char pad_0x0000[0x18]; uint32_t sequence; float prev_cycle; float weight; float weight_delta_rate; float playback_rate; float cycle;void *entity;char pad_0x0038[0x4]; } **"),
    work = function (v1589)
        -- upvalues: link_aa_builder_to_config_or_features_module_or_aa_runtime_context (ref), local_player (ref), ui_tabs (ref), menu_items (ref)
        local l_breaker_0 = link_aa_builder_to_config_or_features_module_or_aa_runtime_context.breaker;
        local l_self_0 = local_player.self;
        if not local_player.valid or not l_self_0 then
            return;
        elseif v1589 ~= local_player.self then
            return;
        else
            local v1592 = local_player.self[0];
            local l_jumping_0 = local_player.jumping;
            local v1594 = ui_tabs.settings.breaker[1];
            if l_jumping_0 then
                if v1594.air.value == "Static" then
                    l_self_0.m_flPoseParameter[6] = 1;
                elseif v1594.air.value == "Moonwalk" then
                    ffi.cast(l_breaker_0.animlayer_t, ffi.cast("uintptr_t", v1592) + 10640)[0][6].weight = 1;
                end;
            elseif v1594.legs.value == "Static" then
                menu_items.antiaim.misc.leg:override("Sliding");
                l_self_0.m_flPoseParameter[0] = 1;
            elseif v1594.legs.value == "Moonwalk" then
                menu_items.antiaim.misc.leg:override("Walking");
                l_self_0.m_flPoseParameter[7] = 0;
            end;
            if v1594.pitch.value then
                local v1595 = local_player.self:get_anim_state();
                if not l_jumping_0 and v1595 and v1595.landing then
                    l_self_0.m_flPoseParameter[12] = 0.5;
                end;
            end;
            return;
        end;
    end,
    run = function (anim_breaker_module)
        -- upvalues: ui_tabs (ref), events (ref), menu_items (ref)
        ui_tabs.settings.breaker:set_callback(function (v1597)
            -- upvalues: events (ref), anim_breaker_module (ref), menu_items (ref)
            events.post_update_clientside_animation(anim_breaker_module.work, v1597.value);
            if not v1597.value then
                menu_items.antiaim.misc.leg:override();
            end;
        end, true);
    end
};
for _, v1599 in next, link_aa_builder_to_config_or_features_module_or_aa_runtime_context do
    if v1599 then
        v1599:run();
    end;
end;
aa_features = {};
aa_features.teleport = {
    landing = function (v1600)
        -- upvalues: local_player (ref)
        local l_m_vecVelocity_1 = local_player.self.m_vecVelocity;
        if l_m_vecVelocity_1.z >= 0 then
            return;
        else
            local v1602 = local_player.self:get_origin();
            local v1603 = local_player.extrapolate(v1602, l_m_vecVelocity_1, v1600);
            local v1604 = utils.trace_line(v1602, v1603, nil, nil, 0);
            return v1604 and v1604.fraction < 1;
        end;
    end,
    defense = {
        check_weapon = function (v1605, v1606)
            -- upvalues: ui_tabs (ref)
            if not v1606 then
                v1606 = v1605 and v1605:get_weapon_info();
            end;
            if not v1606 then
                return false;
            else
                local l_wpns_0 = ui_tabs.settings.teleport[1].wpns;
                local v1608 = v1605:get_weapon_index();
                local v1609 = v1608 == 1 or v1608 == 64;
                local l_weapon_type_0 = v1606.weapon_type;
                local l_full_auto_0 = v1606.full_auto;
                if l_weapon_type_0 == 9 or l_weapon_type_0 == 0 and not l_wpns_0:get("Melee") or v1609 and not l_wpns_0:get("Heavy pistols") or l_weapon_type_0 == 1 and not v1609 and not l_wpns_0:get("Pistols") then
                    return false;
                elseif l_full_auto_0 and l_weapon_type_0 ~= 1 and not l_wpns_0:get("Automatics") then
                    return false;
                else
                    return true;
                end;
            end;
        end,
        select_matter = function (v1612, v1613)
            -- upvalues: math_utils (ref)
            local v1614 = math_utils.clamp(v1612.m_iHealth, 0, 100);
            local v1615 = v1613:get_player_weapon();
            local v1616 = v1615 and v1615:get_weapon_info();
            if not v1616 then
                return 1, v1614 * 0.15;
            elseif v1616.damage < v1614 then
                return 1, v1614 * 0.15;
            else
                return 5, v1614 * 0.35;
            end;
        end,
        work = function (v1617, v1618, _)
            -- upvalues: local_player (ref), ui_tabs (ref)
            if not local_player.valid or not local_player.jumping or local_player.exploit.active ~= 1 or local_player.exploit.charge < 0.5 then
                return;
            else
                if not v1617.check_weapon(local_player.weapon, local_player.weapon_t) then
                    return;
                else
                    local v1622 = false;
                    if local_player.menace ~= nil then
                        rage.exploit:force_teleport();
                    end;
                    if v1622 and local_player.exploit.charge == 1 then
                        v1618.force_defensive = true;
                    end;
                    return;
                end;
            end;
        end
    },
    attack = {
        work = function (_, _, v1626)
            -- upvalues: local_player (ref), game_data (ref), ui_tabs (ref), menu_items (ref), Vector (ref), players (ref), math_utils (ref)
            if not local_player.jumping or local_player.exploit.active ~= game_data.exploit.DT then
                return;
            else
                local v1627 = false;
                local l_teleport_1 = ui_tabs.settings.teleport;
                if not local_player.weapon then
                    return;
                else
                    local l_weapon_t_0 = local_player.weapon_t;
                    local l_weapon_type_1 = l_weapon_t_0.weapon_type;
                    if l_weapon_t_0.full_auto or l_weapon_type_1 == 9 or l_weapon_type_1 == 0 or l_weapon_type_1 == 1 then
                        return;
                    else
                        local v1631 = rage.exploit:get();
                        local v1632 = v1631 * (16 - menu_items.rage.main.dt.fl.value - l_weapon_t_0.time_to_idle);
                        local v1633 = local_player.self:get_simulation_time();
                        local v1634 = local_player.weapon.m_flNextPrimaryAttack - v1633.current < 1;
                        if v1631 < 0.5 and not v1634 then
                            return;
                        else
                            local l_m_vecVelocity_3 = local_player.self.m_vecVelocity;
                            local l_origin_2 = local_player.origin;
                            local v1637 = local_player.self:simulate_movement();
                            if not v1637 then
                                return;
                            else
                                v1637:think(v1632);
                                local v1638 = local_player.self:get_eye_position();
                                local v1639 = v1637.origin + Vector(0, 0, v1637.view_offset);
                                local l_damage_0 = v1626.damage;
                                local v1641 = utils.trace_line(v1638, v1639);
                                if v1641 then
                                    local l_end_pos_0 = v1641.end_pos;
                                    if l_end_pos_0 then
                                        v1641 = l_end_pos_0;
                                        goto label0 --[[  true, true  ]];
                                    end;
                                end;
                                v1641 = v1639;
                                ::label0::;
                                for v1643 = 1, #players do
                                    local v1644 = players[v1643];
                                    if v1644 and v1644:is_enemy() and v1644:is_alive() and not v1644:is_dormant() then
                                        local v1645 = v1644:get_origin();
                                        if (l_origin_2:dist(v1645) < 400 or v1644 == local_player.threat) and v1645:to_screen() then
                                            local v1646 = v1644:get_hitbox_position(0);
                                            local v1647, v1648 = utils.trace_bullet(local_player.self, v1641, v1646);
                                            local v1649 = math_utils.min(l_damage_0, v1644.m_iHealth);
                                            if v1648 and v1648.entity == v1644 and v1648 and v1649 < v1647 or v1648.hitgroup == 1 then
                                                v1627 = true;
                                                break;
                                            end;
                                        end;
                                    end;
                                end;
                                if v1627 then
                                    if l_teleport_1.land.value then
                                        if local_player.self.m_vecVelocity.z >= 0 then
                                            return;
                                        else
                                            local v1650 = local_player.crouching and l_weapon_t_0.recovery_time_crouch or l_weapon_t_0.recovery_time_stand;
                                            local v1651 = math_utils.extrapolate(l_origin_2, l_m_vecVelocity_3, v1632);
                                            v1651.z = v1651.z - v1650;
                                            local v1652 = utils.trace_line(l_origin_2, v1651, nil, nil, 0);
                                            if not (v1652 and v1652.fraction < 1) then
                                                return;
                                            end;
                                        end;
                                    end;
                                    rage.exploit:force_teleport();
                                end;
                                return;
                            end;
                        end;
                    end;
                end;
            end;
        end
    },
    work = function (v1653, v1654)
        -- upvalues: ui_tabs (ref), aa_features (ref)
        local l_value_8 = ui_tabs.settings.teleport[1].mode.value;
        local l_teleport_2 = aa_features.teleport;
        if l_value_8 == "Offensive" then
            l_teleport_2.attack:work(v1653, v1654);
        else
            l_teleport_2.defense:work(v1653, v1654);
        end;
    end,
    run = function (teleport_module)
        -- upvalues: ui_tabs (ref), events (ref)
        ui_tabs.settings.teleport:set_callback(function (v1658)
            -- upvalues: events (ref), teleport_module (ref)
            events.ragebot_features(teleport_module.work, v1658.value);
        end, true);
    end
};
aa_features.dormant = {
    set_requirements = function (v1659, _, _)
        local _ = v1659:get_origin();
    end,
    is_accurate_enough = function (_, _)
        -- upvalues: local_player (ref)
        return local_player.weapon:get_spread() + local_player.weapon:get_inaccuracy() < 0.0095;
    end,
    work = function (v1665)
        -- upvalues: local_player (ref), aa_features (ref), menu_items (ref), math_utils (ref), players (ref), ui_tabs (ref), Vector (ref), events (ref)
        local l_weapon_t_1 = local_player.weapon_t;
        if not l_weapon_t_1 then
            return;
        else
            local l_dormant_0 = aa_features.dormant;
            local l_weapon_type_2 = l_weapon_t_1.weapon_type;
            if l_weapon_type_2 == 0 or l_weapon_type_2 == 9 then
                return;
            else
                local v1669 = local_player.self:get_simulation_time();
                local v1670 = local_player.self:get_eye_position();
                local v1671 = menu_items.rage.selection.damage.ref:get();
                local v1672 = false;
                if v1671 > 100 then
                    local v1673 = v1671 - 100;
                    v1672 = true;
                    v1671 = v1673;
                end;
                local v1674 = false;
                if l_weapon_t_1.is_revolver then
                    v1674 = v1669.current > local_player.weapon.m_flNextPrimaryAttack;
                else
                    v1674 = v1669.current > math_utils.max(local_player.self.m_flNextAttack, local_player.weapon.m_flNextPrimaryAttack, local_player.weapon.m_flNextSecondaryAttack);
                end;
                if not v1674 then
                    return;
                else
                    local v1675 = nil;
                    for v1676 = 1, #players do
                        local v1677 = players[v1676];
                        if v1677 and v1677:is_enemy() and v1677:is_alive() and v1677:is_dormant() then
                            local v1678 = v1677:get_origin();
                            local v1679 = v1677:get_network_state();
                            local v1680 = v1677:get_bbox();
                            if v1679 ~= 0 and v1679 < 4 and v1680.alpha < 0.8 and v1680.alpha > ui_tabs.settings.dormant.acc.value * 0.01 then
                                local v1681 = v1672 and v1671 + v1677.m_iHealth or math_utils.min(v1671, v1677.m_iHealth);
                                local v1682 = v1679 == 1 or v1680.alpha >= 0.75;
                                local v1683 = v1682 and v1681 > 80;
                                local v1684 = v1682 and v1677:get_hitbox_position(v1683 and 1 or 4) or v1678 + Vector(0, 0, 40);
                                local v1685, v1686 = utils.trace_bullet(local_player.self, v1670, v1684);
                                if v1683 then
                                    local v1687 = v1685 * l_weapon_t_1.headshot_multiplier;
                                    if v1687 then
                                        v1685 = v1687;
                                    end;
                                end;
                                if v1686 and v1681 < v1685 and v1686.entity and v1686.entity:get_name() == "CWorld" and (not v1675 or v1685 >= v1675.dmg or not v1675) then
                                    v1675 = {
                                        ent = v1677,
                                        pos = v1684,
                                        dmg = v1685,
                                        net = v1679,
                                        alpha = v1680.alpha
                                    };
                                end;
                            end;
                        end;
                    end;
                    if v1675 then
                        local v1688 = v1670:to(v1675.pos):angles();
                        v1665.block_movement = 1;
                        v1665.view_angles = v1688;
                        if not local_player.self.m_bIsScoped and l_weapon_type_2 == 5 and not local_player.jumping and local_player.on_ground then
                            v1665.in_attack2 = true;
                        end;
                        if l_dormant_0.is_accurate_enough(v1675.pos, v1670) then
                            v1665.in_attack = true;
                            aa_features.dormant.latest_target = v1675;
                            events.daim_shot:call({
                                target = v1675.ent,
                                wanted_dmg = v1675.dmg,
                                pos = v1675.pos,
                                memory = v1675.alpha
                            });
                        end;
                    end;
                    return;
                end;
            end;
        end;
    end,
    await = function (v1689)
        -- upvalues: aa_features (ref), local_player (ref), events (ref)
        local v1690 = entity.get(v1689.userid, true);
        local v1691 = entity.get(v1689.attacker, true);
        local l_latest_target_0 = aa_features.dormant.latest_target;
        if v1691 == local_player.self and l_latest_target_0 and v1690 == l_latest_target_0.ent then
            events.daim_ack:call({
                hit = true,
                fatal = v1689.health == 0,
                target = v1690,
                dmg = v1689.dmg_health,
                wanted_dmg = l_latest_target_0.dmg,
                hitgroup = v1689.hitgroup,
                memory = l_latest_target_0.alpha
            });
            aa_features.dormant.latest_target = nil;
        end;
    end,
    fetch = function (v1693)
        -- upvalues: aa_features (ref), events (ref)
        utils.execute_after(1, function ()
            -- upvalues: aa_features (ref), events (ref), v1693 (ref)
            if aa_features.dormant.latest_target then
                events.daim_ack:call({
                    hit = false,
                    target = v1693.target,
                    wanted_dmg = v1693.dmg,
                    memory = v1693.memory
                });
                aa_features.dormant.latest_target = nil;
            end;
        end);
    end,
    run = function (dormant_aim_module)
        -- upvalues: events (ref), ui_tabs (ref), menu_items (ref), iif (ref)
        events.daim_shot:set(dormant_aim_module.fetch);
        ui_tabs.settings.dormant:set_callback(function (v1695)
            -- upvalues: events (ref), dormant_aim_module (ref), menu_items (ref), iif (ref)
            events.createmove(dormant_aim_module.work, v1695.value);
            events.player_hurt(dormant_aim_module.await, v1695.value);
            menu_items.rage.main.enable.dormant:override(iif(v1695.value, false, nil));
        end, true);
    end
};
aa_features.peek = {
    timestamp = 0,
    able = false,
    state = game_data.aipeek.STANDBY,
    ensure_safety = {},
    hitbox_list = {
        Head = {
            [1] = 1,
            [2] = {
                [1] = 0
            }
        },
        Chest = {
            [1] = 2,
            [2] = {
                [1] = 4,
                [2] = 5,
                [3] = 6
            }
        },
        Stomach = {
            [1] = 3,
            [2] = {
                [1] = 2,
                [2] = 3
            }
        },
        Arms = {
            [1] = 4,
            [2] = {
                [1] = 13,
                [2] = 14,
                [3] = 16,
                [4] = 18
            }
        },
        Legs = {
            [1] = 6,
            [2] = {
                [1] = 7,
                [2] = 8,
                [3] = 9,
                [4] = 10
            }
        }
    },
    can_shoot = function ()
        -- upvalues: local_player (ref)
        if not local_player.valid or not local_player.weapon then
            return;
        else
            local v1696 = local_player.self.m_nTickBase * globals.tickinterval;
            local l_m_flNextAttack_0 = local_player.self.m_flNextAttack;
            local l_m_flNextPrimaryAttack_0 = local_player.weapon.m_flNextPrimaryAttack;
            return l_m_flNextAttack_0 <= v1696 and l_m_flNextPrimaryAttack_0 <= v1696;
        end;
    end,
    check = function (v1699)
        -- upvalues: menu_items (ref), local_player (ref), aa_features (ref), game_data (ref)
        if not menu_items.rage.main.peek.value then
            return;
        elseif v1699.in_forward or v1699.in_back or v1699.in_moveleft or v1699.in_moveright or v1699.in_duck or local_player.jumping then
            return;
        elseif not local_player.weapon_t or local_player.weapon_t.weapon_type == 0 or local_player.weapon_t.weapon_type == 9 then
            return;
        elseif not aa_features.peek.can_shoot() or local_player.exploit.active ~= game_data.exploit.DT then
            return;
        else
            return true;
        end;
    end,
    min_damage = function (v1700)
        -- upvalues: menu_items (ref), math_utils (ref)
        local v1701 = menu_items.rage.selection.damage:get();
        local l_m_iHealth_0 = v1700.m_iHealth;
        if v1701 > 100 then
            return l_m_iHealth_0 + (v1701 - 100);
        else
            return math_utils.min(l_m_iHealth_0, math_utils.max(1, v1701));
        end;
    end,
    peekable_distance = function ()
        -- upvalues: local_player (ref)
        if not local_player.weapon then
            return 0, 0;
        else
            return local_player.weapon:get_max_speed(), 0.25;
        end;
    end,
    find_peekable = function (v1703)
        -- upvalues: render_proxy (ref), local_player (ref), aa_features (ref), math_utils (ref), ui_tabs (ref), Vector (ref), table_utils (ref)
        local v1704 = {};
        local v1705 = render_proxy.camera_angles();
        local v1706 = v1703:get_origin();
        local v1707 = local_player.origin:to(v1706);
        local v1708, v1709 = aa_features.peek.peekable_distance();
        if not v1708 then
            return v1704;
        else
            for v1710 = 0, 360, 360 / math_utils.floor(ui_tabs.settings.aipeek.perf.value * 0.16) do
                local v1711 = Vector():angles(0, v1705.y + v1710):scaled(v1708);
                local v1712 = local_player.self:simulate_movement(nil, v1711 - local_player.self.m_vecVelocity);
                v1712:think(to_ticks(v1709));
                if v1712.origin then
                    if bit.band(v1712.flags, bit.lshift(1, 0)) ~= 0 then
                        local v1713 = local_player.origin:to(v1712.origin);
                        local v1714 = math_utils.deg(math_utils.acos(v1707:dot(v1713)));
                        local v1715 = v1712.origin + Vector(0, 0, v1712.view_offset);
                        table_utils.insert(v1704, {
                            [1] = v1715,
                            [2] = v1705.y + v1710,
                            [3] = v1712.origin:dist(local_player.origin),
                            [4] = v1714
                        });
                    else
                        break;
                    end;
                end;
            end;
            table_utils.sort(v1704, function (v1716, v1717)
                -- upvalues: math_utils (ref)
                return math_utils.abs(90 - v1716[4]) < math_utils.abs(90 - v1717[4]);
            end);
            return v1704;
        end;
    end,
    select = function ()
        -- upvalues: local_player (ref), Vector (ref), render_proxy (ref), math_utils (ref), players (ref)
        local l_eyes_0 = local_player.eyes;
        local v1719 = Vector():angles(render_proxy.camera_angles());
        local l_huge_2 = math_utils.huge;
        local v1721 = nil;
        for v1722 = 1, #players do
            local v1723 = players[v1722];
            if v1723:is_enemy() and not v1723.m_bGunGameImmunity then
                local v1724 = v1723:get_hitbox_position(2);
                if v1724.x ~= 0 or v1724.y ~= 0 or v1724.z ~= 0 then
                    local v1725 = v1724:dist_to_ray(l_eyes_0, v1719);
                    if v1725 < l_huge_2 then
                        local l_v1725_0 = v1725;
                        v1721 = v1723;
                        l_huge_2 = l_v1725_0;
                    end;
                end;
            end;
        end;
        return v1721;
    end,
    scale_damage = function (v1727, v1728)
        -- upvalues: local_player (ref)
        if not local_player.valid or not local_player.weapon_t then
            return;
        else
            local l_weapon_t_2 = local_player.weapon_t;
            local v1730 = ({
                [1] = 4,
                [2] = 1.25,
                [3] = nil,
                [4] = nil,
                [5] = nil,
                [6] = 0.75
            })[v1728] or 1;
            local v1731 = ({
                [1] = nil,
                [2] = true,
                [3] = true,
                [4] = true,
                [1] = v1727.m_bHasHelmet
            })[v1728];
            local v1732 = l_weapon_t_2.damage * v1730;
            if v1731 then
                local v1733 = l_weapon_t_2.armor_ratio / 2;
                local l_m_ArmorValue_0 = v1727.m_ArmorValue;
                local v1735 = nil;
                if l_m_ArmorValue_0 < v1732 * v1733 / 2 then
                    v1735 = l_m_ArmorValue_0 * 4;
                else
                    v1735 = v1732;
                end;
                v1732 = v1732 - v1735 * (1 - v1733);
            end;
            return v1732;
        end;
    end,
    aim = function (v1736, v1737)
        -- upvalues: aa_features (ref), menu_items (ref), unpack (ref)
        local l_hitbox_list_0 = aa_features.peek.hitbox_list;
        local v1739 = {
            [1] = "Stomach",
            [2] = "Arms",
            [3] = "Legs",
            [4] = "Head",
            [5] = "Chest"
        };
        local v1740 = {};
        for v1741 = 1, #v1739 do
            local v1742 = v1739[v1741];
            if menu_items.rage.selection.hitboxes:get(v1742) then
                local v1743, v1744 = unpack(l_hitbox_list_0[v1742]);
                if aa_features.peek.scale_damage(v1736, v1743) >= v1737 then
                    for v1745 = 1, #v1744 do
                        v1740[#v1740 + 1] = v1744[v1745];
                    end;
                end;
            end;
        end;
        return v1740;
    end,
    work = function (v1746)
        -- upvalues: aa_features (ref), game_data (ref), menu_items (ref), local_player (ref), ui_tabs (ref), unpack (ref)
        local l_peek_0 = aa_features.peek;
        local l_aipeek_0 = game_data.aipeek;
        if not l_peek_0.check(v1746) then
            local v1749 = false;
            l_peek_0.state = l_aipeek_0.STANDBY;
            l_peek_0.able = v1749;
            return;
        else
            menu_items.rage.main.peek.retreat:override({
                [1] = "On Shot"
            });
            local v1750 = common.get_timestamp();
            if l_peek_0.state == l_aipeek_0.COOLDOWN then
                if v1750 < l_peek_0.timestamp then
                    l_peek_0.able = false;
                    return;
                else
                    l_peek_0.state = l_aipeek_0.STANDBY;
                end;
            end;
            if l_peek_0.state == l_aipeek_0.MOVING or l_peek_0.state == l_aipeek_0.MOVE_BACK then
                if not l_peek_0.direction or not l_peek_0.distance then
                    return;
                elseif l_peek_0.state == l_aipeek_0.MOVING and (not l_peek_0.target or not l_peek_0.target:is_alive()) then
                    l_peek_0.state = l_aipeek_0.STANDBY;
                    return;
                else
                    local v1751 = local_player.origin:dist(l_peek_0.original_position);
                    if l_peek_0.distance * 1.1 < v1751 then
                        v1746.discharge_pending = true;
                        l_peek_0.state = l_aipeek_0.MOVE_BACK;
                    elseif l_peek_0.state == l_aipeek_0.MOVE_BACK and v1751 < 5 then
                        l_peek_0.state = l_aipeek_0.COOLDOWN;
                        l_peek_0.timestamp = v1750 + ui_tabs.settings.aipeek.perf.value * 100 / 2;
                    end;
                    v1746.move_yaw = l_peek_0.direction;
                    local v1752 = 450;
                    local v1753 = true;
                    local v1754 = false;
                    if l_peek_0.state == l_aipeek_0.MOVE_BACK then
                        local v1755 = 0;
                        local v1756 = false;
                        v1754 = false;
                        v1753 = v1756;
                        v1752 = v1755;
                    end;
                    if l_peek_0.state == l_aipeek_0.MOVE_BACK then
                        menu_items.rage.main.peek.retreat:override({
                            [1] = "On Shot",
                            [2] = "On Key Release"
                        });
                    end;
                    local l_v1752_0 = v1752;
                    local l_v1753_0 = v1753;
                    v1746.in_back = v1754;
                    v1746.in_forward = l_v1753_0;
                    v1746.forwardmove = l_v1752_0;
                    l_v1752_0 = 0;
                    l_v1753_0 = false;
                    local v1759 = false;
                    local v1760 = false;
                    local v1761 = false;
                    v1746.in_jump = false;
                    v1746.in_moveright = v1761;
                    v1746.in_moveleft = v1760;
                    v1746.in_right = v1759;
                    v1746.in_left = l_v1753_0;
                    v1746.sidemove = l_v1752_0;
                    return;
                end;
            else
                local v1762 = l_peek_0.select();
                if not v1762 then
                    l_peek_0.able = false;
                    return;
                else
                    l_peek_0.able = true;
                    local v1763 = l_peek_0.min_damage(v1762);
                    local v1764 = l_peek_0.aim(v1762, v1763);
                    local v1765 = l_peek_0.find_peekable(v1762);
                    local v1766 = nil;
                    local v1767 = nil;
                    local v1768 = nil;
                    local v1769 = false;
                    for v1770 = 1, #v1765 do
                        local v1771, v1772, v1773 = unpack(v1765[v1770]);
                        for v1774 = 1, #v1764 do
                            local v1775 = v1762:get_hitbox_position(v1764[v1774]);
                            if v1775:length() > 0 then
                                local v1776, v1777 = utils.trace_bullet(local_player.self, v1771, v1775);
                                local l_entity_0 = v1777.entity;
                                if (not l_entity_0 or l_entity_0:is_enemy()) and v1763 <= v1776 then
                                    local l_v1776_0 = v1776;
                                    local l_v1772_0 = v1772;
                                    v1768 = v1773;
                                    v1767 = l_v1772_0;
                                    v1766 = l_v1776_0;
                                    v1769 = true;
                                end;
                            end;
                            if v1769 then
                                break;
                            end;
                        end;
                        if v1769 then
                            break;
                        end;
                    end;
                    local v1781 = v1762:get_index();
                    if not v1767 or not v1768 or not v1766 then
                        l_peek_0.ensure_safety[v1781] = 0;
                    end;
                    l_peek_0.ensure_safety[v1781] = (l_peek_0.ensure_safety[v1781] or -1) + 1;
                    if l_peek_0.ensure_safety[v1781] < ui_tabs.settings.aipeek.ticks.value then
                        return;
                    else
                        l_peek_0.state = l_aipeek_0.MOVING;
                        l_peek_0.direction = v1767;
                        l_peek_0.original_position = local_player.origin;
                        l_peek_0.target = v1762;
                        l_peek_0.distance = v1768;
                        return;
                    end;
                end;
            end;
        end;
    end,
    run = function (ai_peek_module)
        -- upvalues: ui_tabs (ref), events (ref), menu_items (ref)
        ui_tabs.settings.aipeek:set_callback(function (v1783)
            -- upvalues: events (ref), ai_peek_module (ref), menu_items (ref)
            events.createmove(ai_peek_module.work, v1783.value);
            if not v1783.value then
                menu_items.rage.main.peek.retreat:override();
            end;
        end, true);
    end
};
aa_features.airstop = {
    reloaded = false,
    overridden = false,
    work = function (v1784, v1785)
        -- upvalues: local_player (ref), aa_features (ref), ui_tabs (ref), menu_items (ref), iif (ref)
        if not local_player.weapon then
            return;
        else
            local l_airstop_0 = aa_features.airstop;
            local l_airstop_1 = ui_tabs.settings.airstop;
            local l_weapon_i_0 = local_player.weapon_i;
            if l_weapon_i_0 == 40 or l_weapon_i_0 == 64 then
                local l_autostoptions_0 = v1785.autostoptions;
                l_autostoptions_0[#l_autostoptions_0 + 1] = "In Air";
                local v1790 = 500;
                if local_player.threat then
                    local v1791 = local_player.threat:get_origin();
                    if v1791 then
                        local v1792 = local_player.origin:dist(v1791);
                        if v1792 then
                            v1790 = v1792;
                        end;
                    end;
                end;
                local v1793 = l_airstop_1.conds:get(1);
                local v1794 = l_airstop_1.conds:get(2);
                local v1795 = local_player.velocity < 20;
                local v1796 = local_player.jumping and (v1793 and (not (local_player.velocity >= 120) or not (v1790 >= 150)) or v1794 and v1784.in_speed);
                local v1797 = local_player.jumping and l_airstop_1.duck.value and (not (local_player.velocity >= 70) or v1790 < 300) and local_player.self.m_MoveType ~= 9;
                v1785.autostoptions = v1796 and l_autostoptions_0 or nil;
                menu_items.misc.movement.airstrafe:override(iif(v1795, false, nil));
                if v1797 then
                    v1784.in_duck = true;
                end;
                l_airstop_0.overridden = true;
            elseif l_airstop_0.overridden then
                menu_items.misc.movement.airstrafe:override();
                l_airstop_0.overridden = false;
            end;
            if not l_airstop_0.reload and ui_tabs.settings.airstop.value and #common.get_active_scripts() > 1 then
                ui_tabs.settings.airstop:set(false);
                utils.execute_after(0.5, function ()
                    -- upvalues: ui_tabs (ref)
                    ui_tabs.settings.airstop:set(true);
                end);
                l_airstop_0.reload = true;
            end;
            return;
        end;
    end,
    run = function (airstop_module)
        -- upvalues: ui_tabs (ref), events (ref), menu_items (ref)
        ui_tabs.settings.airstop:set_callback(function (v1799)
            -- upvalues: events (ref), airstop_module (ref), menu_items (ref)
            events.ragebot_features(airstop_module.work, v1799.value);
            if not v1799.value then
                menu_items.misc.movement.airstrafe:override();
            end;
        end);
    end
};
aa_features.exswitch = {
    ovr = false,
    work = function (_)
        -- upvalues: aa_features (ref), ui_tabs (ref), local_player (ref), menu_items (ref)
        local l_exswitch_0 = aa_features.exswitch;
        local l_exswitch_1 = ui_tabs.settings.exswitch;
        local v1803;
        if (local_player.walking or local_player.velocity < 2) and not menu_items.rage.main.peek.value or local_player.self.m_flDuckAmount > 0.5 then
            v1803 = false;
        else
            v1803 = true;
        end;
        local v1804 = false;
        local v1805 = false;
        if local_player.weapon then
            local l_weapon_t_3 = local_player.weapon_t;
            local l_weapon_i_1 = local_player.weapon_i;
            local l_full_auto_1 = l_weapon_t_3.full_auto;
            local l_weapon_type_3 = l_weapon_t_3.weapon_type;
            v1804 = l_full_auto_1 or l_weapon_type_3 == 1 or l_weapon_i_1 == 1;
            if l_exswitch_1.p.value and l_weapon_i_1 ~= 1 and (l_weapon_type_3 == 1 or l_weapon_type_3 == 2 or l_weapon_type_3 == 3) or l_weapon_i_1 == 1 and l_exswitch_1.hp.value then
                v1804 = false;
            end;
            if l_weapon_t_3.is_revolver or l_weapon_type_3 == 9 or l_weapon_type_3 == 0 then
                v1805 = true;
            end;
        end;
        if not v1805 and not local_player.jumping and menu_items.rage.main.dt.value and local_player.exploit.charge == 1 and not v1804 and not v1803 then
            menu_items.rage.main.dt:override(false);
            menu_items.rage.main.hs:override(true);
            l_exswitch_0.ovr = true;
        elseif l_exswitch_0.ovr then
            menu_items.rage.main.dt:override();
            menu_items.rage.main.hs:override();
            l_exswitch_0.ovr = false;
        end;
    end,
    run = function (exploit_switcher_module)
        -- upvalues: ui_tabs (ref), events (ref), menu_items (ref)
        ui_tabs.settings.exswitch:set_callback(function (v1811)
            -- upvalues: events (ref), exploit_switcher_module (ref), menu_items (ref)
            events.createmove(exploit_switcher_module.work, v1811.value);
            if not v1811.value then
                menu_items.rage.main.dt:override();
                menu_items.rage.main.hs:override();
            end;
        end);
    end
};
aa_features.cross = {
    state = false,
    active = false,
    work = function (v1812)
        -- upvalues: aa_features (ref), ui_tabs (ref), menu_items (ref), local_player (ref)
        local l_cross_0 = aa_features.cross;
        local v1814 = ui_tabs.settings.cross:get();
        l_cross_0.active = v1814;
        if v1814 and not menu_items.rage.main.dt.value and local_player.exploit.charge == 0 and l_cross_0.state == 0 then
            menu_items.rage.main.dt:set(true);
            return;
        else
            local l_lc_left_0 = local_player.exploit.lc_left;
            if v1814 then
                if local_player.exploit.charge == 1 then
                    rage.exploit:allow_defensive(false);
                    l_cross_0.state = 1;
                end;
            elseif l_cross_0.state == 1 then
                v1812.force_defensive = true;
                l_cross_0.state = 2;
            elseif l_cross_0.state == 2 and l_lc_left_0 > 1 then
                menu_items.rage.main.dt:set(false);
                rage.exploit:force_teleport();
                rage.exploit:allow_defensive(true);
                l_cross_0.state = 0;
            end;
            return;
        end;
    end,
    run = function (cross_lc_module)
        -- upvalues: build_level (ref), events (ref)
        if build_level > 1 then
            events.createmove:set(cross_lc_module.work);
        end;
    end
};
aa_features.hsfix = {
    state = 0,
    callback = function ()
        -- upvalues: menu_items (ref), aa_features (ref)
        if menu_items.rage.main.hs.value then
            menu_items.rage.main.hs.options:override("Break LC");
            aa_features.hsfix.state = 1;
        end;
    end,
    work = function ()
        -- upvalues: aa_features (ref), menu_items (ref)
        if aa_features.hsfix.state == 1 then
            aa_features.hsfix.state = 2;
        elseif aa_features.hsfix.state == 2 then
            menu_items.rage.main.hs.options:override();
            aa_features.hsfix.state = 0;
        end;
    end,
    run = function (hs_fix_module)
        -- upvalues: events (ref), menu_items (ref)
        events.createmove:set(hs_fix_module.work);
        events.local_spawn:set(hs_fix_module.callback);
        menu_items.rage.main.hs:set_callback(hs_fix_module.callback);
    end
};
aa_features.nadefix = {
    ovr = false,
    work = function ()
        -- upvalues: aa_features (ref), local_player (ref)
        local l_nadefix_0 = aa_features.nadefix;
        if local_player.weapon and local_player.weapon_t.weapon_type == 9 and (local_player.weapon.m_bPinPulled or local_player.weapon.m_fThrowTime ~= 0) then
            l_nadefix_0.timer = globals.tickcount + 16;
        elseif l_nadefix_0.timer and globals.tickcount > l_nadefix_0.timer then
            l_nadefix_0.timer = nil;
        end;
    end,
    run = function (nade_fix_module)
        -- upvalues: events (ref)
        events.createmove(nade_fix_module.work);
    end
};
aa_features.ping = {
    work = function (_)
        -- upvalues: menu_items (ref), ui_tabs (ref)
        menu_items.misc.other.fakeping:override(ui_tabs.settings.ping.ovr.value);
    end,
    run = function (ping_module)
        -- upvalues: ui_tabs (ref), events (ref), menu_items (ref)
        ui_tabs.settings.ping:set_callback(function (v1822)
            -- upvalues: events (ref), ping_module (ref), menu_items (ref)
            events.createmove(ping_module.work, v1822.value);
            if not v1822.value then
                menu_items.misc.other.fakeping:override();
            end;
        end, true);
    end
};
crosshair_widget = {
    head_scale = menu_items.rage.selection.multipoint.head.ref,
    body_scale = menu_items.rage.selection.multipoint.body.ref,
    hitchance = menu_items.rage.selection.hitchance.ref,
    damage = menu_items.rage.selection.damage.ref,
    autostoptions = menu_items.rage.accuracy.autostop_ssg.options.ref
};
widgets_manager = {};
do
    local l_v925_3, l_v952_1, l_v953_2 = crosshair_widget, widgets_manager, widget_instance;
    l_v953_2 = setmetatable({}, {
        __index = function (_, v1827)
            -- upvalues: rawget (ref), l_v952_1 (ref), l_v925_3 (ref)
            local v1828 = rawget(l_v952_1, v1827);
            if v1828 ~= nil then
                return v1828;
            else
                return l_v925_3[v1827]:get();
            end;
        end,
        __newindex = function (_, v1830, v1831)
            -- upvalues: rawset (ref), l_v952_1 (ref)
            rawset(l_v952_1, v1830, v1831);
        end
    });
    events.createmove:set(function (v1832)
        -- upvalues: table_utils (ref), l_v952_1 (ref), events (ref), l_v953_2 (ref), next (ref), l_v925_3 (ref)
        table_utils.clear(l_v952_1);
        events.ragebot_features:call(v1832, l_v953_2);
        for v1833, v1834 in next, l_v925_3 do
            v1834:override(l_v952_1[v1833]);
        end;
    end);
end;
for _, feature_module_instance in next, aa_features do
    if feature_module_instance then
        feature_module_instance:run();
    end;
end;
events.enemy_shot:set(function (v1837)
    -- upvalues: db_manager (ref)
    local v1838 = v1837.attacker and v1837.attacker:get_resource();
    if not v1838 or v1838.m_iPing == 0 then
        return;
    else
        if not v1837.damaged then
            db_manager.stats.evaded = db_manager.stats.evaded + 1;
        end;
        return;
    end;
end);
events.local_frag:set(function (v1839)
    -- upvalues: db_manager (ref)
    db_manager.stats.killed = db_manager.stats.killed + 1;
    db_manager.stats.headshots = db_manager.stats.headshots + (v1839.headshot and 1 or 0);
end);
events.local_death:set(function (v1840)
    -- upvalues: db_manager (ref)
    db_manager.stats.deaths = db_manager.stats.deaths + 1;
    db_manager.stats.hsed = db_manager.stats.hsed + (v1840.headshot and 1 or 0);
end);
events.database_pre_save:set(function ()
    -- upvalues: db_manager (ref)
    db_manager.stats.playtime = db_manager.stats.playtime + 0.08;
end);
render_proxy.logo = function (v1841, v1842)
    -- upvalues: image_assets (ref), render_proxy (ref), Vector (ref), colors (ref)
    local l_logo_l_0 = image_assets.logo_l;
    local l_logo_r_0 = image_assets.logo_r;
    local l_logo_lo_0 = image_assets.logo_lo;
    local l_logo_ro_0 = image_assets.logo_ro;
    local l_logo_l2x_0 = image_assets.logo_l2x;
    local l_logo_r2x_0 = image_assets.logo_r2x;
    local l_logo_lo2x_0 = image_assets.logo_lo2x;
    local l_logo_ro2x_0 = image_assets.logo_ro2x;
    if render_proxy.dpi > 1 and l_logo_lo2x_0 and l_logo_ro2x_0 then
        local l_l_logo_l2x_0_0 = l_logo_l2x_0;
        local l_l_logo_r2x_0_0 = l_logo_r2x_0;
        local l_l_logo_lo2x_0_0 = l_logo_lo2x_0;
        l_logo_ro_0 = l_logo_ro2x_0;
        l_logo_lo_0 = l_l_logo_lo2x_0_0;
        l_logo_r_0 = l_l_logo_r2x_0_0;
        l_logo_l_0 = l_l_logo_l2x_0_0;
    end;
    if v1842 and l_logo_l_0 and l_logo_r_0 then
        render_proxy.texture(l_logo_l_0, v1841, Vector(26, 15), colors.accent);
        render_proxy.texture(l_logo_r_0, Vector(v1841.x + 26, v1841.y), Vector(24, 15), colors.text);
    else
        render_proxy.texture(l_logo_lo_0, v1841, Vector(26, 15), colors.accent);
        render_proxy.texture(l_logo_ro_0, Vector(v1841.x + 26, v1841.y), Vector(24, 15), colors.text);
    end;
end;
render_proxy.edge_h = function (v1854, v1855, v1856, v1857)
    -- upvalues: colors (ref), render_proxy (ref), Vector (ref), image_assets (ref)
    local v1858 = v1856 or colors.accent;
    if not v1857 then
        v1857 = colors.secondary;
    end;
    v1856 = v1858;
    if v1856 == v1857 then
        render_proxy.rect(Vector(v1854.x + 4, v1854.y), v1854 + Vector(v1855 - 4, 2), v1856);
    else
        render_proxy.gradient(Vector(v1854.x + 4, v1854.y), v1854 + Vector(v1855 - 4, 2), v1856, v1857, v1856, v1857);
    end;
    render_proxy.texture(image_assets.corner_h1, Vector(v1854.x, v1854.y), Vector(4, 6), v1856, "f");
    v1858 = render_proxy.texture;
    local l_corner_h2_0 = image_assets.corner_h2;
    local v1860 = Vector(v1854.x + v1855 - 4, v1854.y);
    local v1861 = Vector(4, 6);
    local v1862;
    if not v1857 then
        v1862 = v1856;
    else
        v1862 = v1857;
    end;
    v1858(l_corner_h2_0, v1860, v1861, v1862, "f");
end;
render_proxy.edge_v = function (v1863, v1864, v1865, v1866)
    -- upvalues: colors (ref), render_proxy (ref), Vector (ref), image_assets (ref)
    local v1867 = v1865 or colors.accent;
    if not v1866 then
        v1866 = colors.secondary;
    end;
    v1865 = v1867;
    if v1865 == v1866 then
        render_proxy.rect(Vector(v1863.x, v1863.y + 4), v1863 + Vector(2, v1864 - 4), v1865);
    else
        render_proxy.gradient(Vector(v1863.x, v1863.y + 4), v1863 + Vector(2, v1864 - 4), v1865, v1865, v1866, v1866);
    end;
    render_proxy.texture(image_assets.corner_v1, Vector(v1863.x, v1863.y), Vector(6, 4), v1865, "f");
    v1867 = render_proxy.texture;
    local l_corner_v2_0 = image_assets.corner_v2;
    local v1869 = Vector(v1863.x, v1863.y + v1864 - 4);
    local v1870 = Vector(6, 4);
    local v1871;
    if not v1866 then
        v1871 = v1865;
    else
        v1871 = v1866;
    end;
    v1867(l_corner_v2_0, v1869, v1870, v1871, "f");
end;
render_proxy.side_h = function (v1872, v1873)
    -- upvalues: render_proxy (ref), colors (ref), Vector (ref), Color (ref), ui_tabs (ref)
    if render_proxy.style == 1 then
        render_proxy.blur(v1872, v1873, 1, 1, {
            [1] = 4,
            [2] = 4,
            [3] = 0,
            [4] = 0
        });
        render_proxy.rect(v1872, v1873, colors.panel.g1, {
            [1] = 4,
            [2] = 4,
            [3] = 0,
            [4] = 0
        });
        render_proxy.rect(Vector(v1872.x, v1873.y), Vector(v1873.x, v1873.y + 2), colors.panel.g1);
        render_proxy.edge_h(Vector(v1872.x, v1873.y), v1873.x - v1872.x);
    else
        render_proxy.blur(v1872, v1873, 1, 1, 4);
        render_proxy.rect(v1872, v1873, Color(0, 0, 0, ui_tabs.settings.style[1].bga.value * 2.55), 4);
        render_proxy.edge_h(Vector(v1872.x, v1872.y - 1), v1873.x - v1872.x);
    end;
end;
render_proxy.side_v = function (v1874, v1875)
    -- upvalues: render_proxy (ref), colors (ref), Vector (ref)
    render_proxy.blur(v1874, v1875, 1, 1, {
        [1] = 4,
        [2] = 0,
        [3] = 0,
        [4] = 4
    });
    render_proxy.rect(v1874, v1875, colors.panel.g1, {
        [1] = 4,
        [2] = 0,
        [3] = 0,
        [4] = 4
    });
    render_proxy.rect(Vector(v1875.x, v1874.y), Vector(v1875.x + 2, v1875.y), colors.panel.g1);
    render_proxy.edge_v(Vector(v1875.x, v1874.y), v1875.y - v1874.y);
end;
crosshair_widget = widget_factory.new("crosshair", Vector(screen_center.x - 24, screen_center.y + 32), Vector(48, 16), {
    border = {
        Vector(native_screen_center.x, native_screen_center.y - 100),
        Vector(native_screen_center.x, native_screen_center.y + 100)
    },
    rulers = {
        [1] = {
            [1] = true,
            [2] = Vector(native_screen_center.x, native_screen_center.y - 100),
            [3] = native_screen_center.y + 100
        }
    }
});
widgets_manager = {
    scope = {
        target = 0,
        reserved = false,
        side = 0
    },
    progress = {
        y = {
            [1] = 0
        },
        nade = {
            [1] = 0
        }
    }
};
crosshair_widget.items = {
    [1] = {
        [1] = 0,
        x = 0,
        [2] = function (v1876, v1877)
            -- upvalues: anim_manager (ref), ui_tabs (ref), colors (ref), render_proxy (ref), Vector (ref), math_utils (ref), image_assets (ref)
            if v1876[1] > 0 then
                local v1878 = anim_manager.condition(v1876.bfly, ui_tabs.settings.crosshair.bfly.value, -8);
                if v1878 > 0 then
                    local v1879 = colors.accent:alpha_modulate(v1878, true);
                    render_proxy.shadow(Vector(v1877.x + 4, v1877.y), Vector(v1877.x + 16, v1877.y + 12), v1879, math_utils.lerp(25, 50, anim_manager.pulse));
                    render_proxy.texture(image_assets.butterfly_s, Vector(v1877.x - 3, v1877.y - 10), Vector(32, 32), v1879);
                end;
                render_proxy.logo(v1877);
            end;
            return ui_tabs.settings.crosshair.style.value == 1, Vector(50, 15);
        end,
        bfly = {
            [1] = 0
        }
    },
    [2] = {
        [1] = 0,
        x = 0,
        [2] = function (v1880, v1881)
            -- upvalues: render_proxy (ref), ui_tabs (ref), image_assets (ref), Vector (ref), colors (ref), build_level (ref), string_utils (ref), build_info (ref)
            local v1882 = "HYSTERIA";
            local v1883, v1884 = render_proxy.measure_text(2, v1882):unpack();
            if v1880[1] > 0 then
                if ui_tabs.settings.crosshair.bfly.value then
                    render_proxy.texture(image_assets.bfly, Vector(v1881.x + v1883 - 2, v1881.y + 2), Vector(9, 9), colors.accent);
                    v1883 = v1883 + 5;
                elseif build_level > 1 then
                    v1882 = string_utils.format("HYSTERIA %s%s", colors.hex, string_utils.upper(build_info.build));
                    v1883 = render_proxy.measure_text(2, v1882):unpack();
                end;
                render_proxy.text(2, v1881, colors.text, nil, v1882);
            end;
            return ui_tabs.settings.crosshair.style.value == 2, Vector(v1883, v1884 + 2);
        end
    },
    [3] = {
        [1] = 0,
        x = 0,
        [2] = function (v1885, v1886)
            -- upvalues: menu_items (ref), anim_manager (ref), colors (ref), string_utils (ref), render_proxy (ref)
            local l_value_9 = menu_items.rage.main.dt.value;
            local v1888 = menu_items.rage.main.dt.ref:get_override();
            if v1885[1] > 0 then
                local v1889 = rage.exploit:get();
                local v1890 = anim_manager.condition(v1885.ovr_p, v1888 ~= false, -8);
                local v1891 = "DT " .. colors.hex2 .. string_utils.insert("IIIIII", "\aFFFFFF60", v1889 * 6);
                render_proxy.text(2, v1886, colors.text:alpha_modulate(0.5 + v1890 * 0.5, true), nil, v1891);
            end;
            return l_value_9 or v1888, render_proxy.measure_text(2, "DT IIIIII");
        end,
        ovr_p = {
            [1] = 0
        }
    },
    [4] = {
        [1] = 0,
        x = 0,
        [2] = function (v1892, v1893)
            -- upvalues: aa_features (ref), colors (ref), local_player (ref), render_proxy (ref)
            local l_active_0 = aa_features.cross.active;
            local v1895 = "CLC";
            if v1892[1] > 0 then
                local v1896 = colors.text:alpha_modulate(96);
                if local_player.exploit.charge == 1 then
                    v1896 = colors.accent;
                end;
                render_proxy.text(2, v1893, v1896, nil, v1895);
            end;
            return l_active_0, render_proxy.measure_text(2, v1895);
        end
    },
    [5] = {
        [1] = 0,
        x = 0,
        [2] = function (v1897, v1898)
            -- upvalues: menu_items (ref), anim_manager (ref), render_proxy (ref), colors (ref)
            local v1899 = menu_items.rage.main.hs.value or menu_items.rage.main.hs.ref:get_override();
            local v1900 = "OS";
            if v1897[1] > 0 then
                local v1901 = menu_items.rage.main.dt.value or menu_items.rage.main.dt.ref:get_override();
                local v1902 = anim_manager.condition(v1897.a1, not v1901, -8);
                render_proxy.text(2, v1898, colors.text:lerp(colors.secondary, v1902 * rage.exploit:get()), nil, v1900);
            end;
            return v1899, render_proxy.measure_text(2, v1900);
        end,
        a1 = {
            [1] = 0
        }
    },
    [6] = {
        [1] = 0,
        x = 0,
        [2] = function (v1903, v1904)
            -- upvalues: menu_items (ref), local_player (ref), anim_manager (ref), render_proxy (ref), colors (ref)
            local l_value_10 = menu_items.rage.main.peek.value;
            local v1906 = local_player.exploit.active == 1 and rage.exploit:get() > 0.5;
            local v1907 = v1906 and "QP" or "AP";
            if v1903[1] > 0 then
                local v1908 = anim_manager.condition(v1903.ideal, v1906, -8);
                render_proxy.text(2, v1904, colors.text:lerp(colors.secondary, v1908), nil, v1907);
            end;
            return l_value_10, render_proxy.measure_text(2, v1907);
        end,
        ideal = {
            [1] = 0
        }
    },
    [7] = {
        [1] = 0,
        x = 0,
        [2] = function (v1909, v1910)
            -- upvalues: ui_groups_settings (ref), render_proxy (ref), colors (ref)
            local v1911 = ui_groups_settings.data.roll_mode ~= nil;
            local v1912 = "RO";
            if v1909[1] > 0 then
                render_proxy.text(2, v1910, colors.text, nil, v1912);
            end;
            return v1911, render_proxy.measure_text(2, v1912);
        end
    },
    [8] = {
        [1] = 0,
        x = 0,
        [2] = function (v1913, v1914)
            -- upvalues: ui_tabs (ref), anim_manager (ref), ui_groups_settings (ref), render_proxy (ref), colors (ref)
            local l_value_11 = ui_tabs.antiaim.buttons.fs.value;
            local v1916 = "FS";
            if v1913[1] > 0 then
                local v1917 = anim_manager.condition(v1913.a1, ui_groups_settings.data.freestand ~= nil, -8);
                render_proxy.text(2, v1914, colors.text:alpha_modulate(96):lerp(colors.secondary, v1917), nil, v1916);
            end;
            return l_value_11, render_proxy.measure_text(2, v1916);
        end,
        a1 = {
            [1] = 0
        }
    },
    [9] = {
        [1] = 0,
        x = 0,
        [2] = function (v1918, v1919)
            -- upvalues: ui_tabs (ref), anim_manager (ref), ui_groups_settings (ref), render_proxy (ref), colors (ref)
            local l_value_12 = ui_tabs.antiaim.buttons.edge.value;
            local v1921 = "EY";
            if v1918[1] > 0 then
                local v1922 = anim_manager.condition(v1918.a1, ui_groups_settings.data.edge, -8);
                render_proxy.text(2, v1919, colors.text:alpha_modulate(96):lerp(colors.secondary, v1922), nil, v1921);
            end;
            return l_value_12, render_proxy.measure_text(2, v1921);
        end,
        a1 = {
            [1] = 0
        }
    },
    [10] = {
        [1] = 0,
        x = 0,
        [2] = function (v1923, v1924)
            -- upvalues: menu_items (ref), render_proxy (ref), colors (ref)
            local v1925 = menu_items.rage.safety.body_aim.ref:get() == "Force";
            local v1926 = "BA";
            if v1923[1] > 0 then
                render_proxy.text(2, v1924, colors.text, nil, v1926);
            end;
            return v1925, render_proxy.measure_text(2, v1926);
        end
    }
};
do
    local l_v952_2 = widgets_manager;
    crosshair_widget.enumerate = function (v1928)
        -- upvalues: Vector (ref), anim_manager (ref), l_v952_2 (ref), screen_center (ref), render_proxy (ref), math_utils (ref)
        local v1929 = Vector(v1928.pos.x + v1928.size.x * 0.5, v1928.pos.y);
        local v1930 = anim_manager.condition(l_v952_2.progress.y, v1928.pos.y > screen_center.y, 3) * 2 - 1;
        local l_side_0 = l_v952_2.scope.side;
        local v1932 = l_side_0 * 0.5 + 0.5;
        for v1933 = 1, #v1928.items do
            local v1934 = v1928.items[v1933];
            v1934[0] = v1934[0] or {
                [1] = 0
            };
            render_proxy.push_alpha(v1934[1]);
            local v1935, v1936 = v1934[2](v1934, Vector(v1929.x + v1934.x, v1929.y));
            render_proxy.pop_alpha();
            v1934[1] = anim_manager.condition(v1934[0], v1935, 6);
            v1934.x = v1936.x * -v1932 - l_side_0 * 16;
            v1929.y = v1929.y + (v1936.y - 2) * v1934[1] * v1930;
        end;
        return math_utils.abs(v1929.y - v1928.pos.y);
    end;
    crosshair_widget.update = function (v1937)
        -- upvalues: local_player (ref), ui_tabs (ref), anim_manager (ref), l_v952_2 (ref)
        if local_player.in_score then
            v1937.progress[1] = 0;
            return 0;
        elseif not ui_tabs.settings.crosshair.value then
            return anim_manager.condition(v1937.progress, false, -12);
        else
            local v1938 = local_player.weapon and local_player.weapon_t;
            local v1939 = (v1938 and v1938.weapon_type) == 9;
            local v1940 = anim_manager.condition(l_v952_2.progress.nade, not v1939, -12) * 0.5 + 0.5;
            return anim_manager.condition(v1937.progress, local_player.valid, -12) * v1940;
        end;
    end;
    crosshair_widget.paint = function (v1941)
        -- upvalues: local_player (ref), l_v952_2 (ref), anim_manager (ref)
        if local_player.valid and local_player.self.m_bIsScoped then
            if not l_v952_2.scope.reserved and local_player.side ~= 0 then
                local l_scope_2 = l_v952_2.scope;
                local l_scope_3 = l_v952_2.scope;
                local v1944 = -local_player.side;
                l_scope_3.reserved = true;
                l_scope_2.target = v1944;
            end;
        else
            local l_scope_4 = l_v952_2.scope;
            local l_scope_5 = l_v952_2.scope;
            local v1947 = 0;
            l_scope_5.reserved = false;
            l_scope_4.target = v1947;
        end;
        l_v952_2.scope.side = anim_manager.lerp(l_v952_2.scope.side, l_v952_2.scope.target, 12, 0.01);
        v1941:enumerate();
    end;
    events.render_dpi:set(function ()
        -- upvalues: crosshair_widget (ref), screen_size (ref), ui_tabs (ref)
        local v1948 = crosshair_widget.size.x / screen_size.x * 5000;
        ui_tabs.drag[crosshair_widget.id].x:set(5000 - v1948);
    end);
end;
widgets_manager = {
    watermark = widget_factory.new("watermark", Vector(screen_size.x - 24, 24), Vector(320, 22), {
        rulers = {
            [1] = {
                [1] = true,
                [2] = Vector(native_screen_center.x, 0),
                [3] = native_screen_size.y
            },
            [2] = {
                [1] = false,
                [2] = Vector(0, native_screen_size.y - 24),
                [3] = native_screen_size.x
            },
            [3] = {
                [1] = false,
                [2] = Vector(0, 24),
                [3] = native_screen_size.x
            }
        },
        on_release = function (v1949, v1950)
            -- upvalues: screen_size (ref), math_utils (ref)
            local v1951 = screen_size.x / 3;
            local v1952 = v1949.pos.x + v1949.size.x * 0.5;
            local v1953 = math_utils.floor(v1952 / v1951);
            if v1953 == v1949.align then
                return;
            else
                v1949.align = v1953;
                if v1949.align == 1 then
                    v1949:set_position(v1952);
                elseif v1949.align == 2 then
                    v1949:set_position(v1949.pos.x + v1949.size.x);
                end;
                v1950.config.a:set(v1953);
                return;
            end;
        end,
        on_held = function (v1954, v1955)
            v1955.config.a:set(0);
            v1954.align = 0;
        end
    })
};
widgets_manager.watermark.active_items = 0;
widget_instance = widgets_manager.watermark;
local v1956 = "align";
local l_watermark_0 = widgets_manager.watermark;
local v1958 = "logop";
local l_watermark_1 = widgets_manager.watermark;
local v1960 = "logo";
local v1961 = 2;
local v1962 = {
    [1] = 0
};
l_watermark_1[v1960] = 0;
l_watermark_0[v1958] = v1962;
widget_instance[v1956] = v1961;
widgets_manager.watermark.__drag.config.a = drag_handler.ui_group:slider("watermark:align", 0, 2, widgets_manager.watermark.align);
widgets_manager.watermark.__drag.config.a:set_callback(function (v1963)
    -- upvalues: widgets_manager (ref)
    widgets_manager.watermark.align = v1963.value;
end, true);
widgets_manager.watermark.get_name = function ()
    -- upvalues: ui_tabs (ref), build_info (ref)
    local v1964 = ui_tabs.settings.watermark[1];
    if v1964.namet.value == "Steam" then
        return cvar.name:string();
    elseif v1964.namet.value == "Neverlose" then
        return build_info.user;
    elseif v1964.namet.value == "Custom" then
        return v1964.name.value;
    else
        return;
    end;
end;
widgets_manager.watermark.get_pfp = function ()
    -- upvalues: ui_tabs (ref), image_assets (ref)
    local v1965 = ui_tabs.settings.watermark[1];
    if v1965.pfp.value == "Steam" then
        return image_assets.steampfp;
    elseif v1965.pfp.value == "Neverlose" then
        return image_assets.avatar;
    else
        return;
    end;
end;
widgets_manager.watermark.draw_item_back = function (v1966, v1967)
    -- upvalues: render_proxy (ref), Vector (ref), colors (ref)
    if render_proxy.style == 1 then
        render_proxy.blur(v1967, Vector(v1967.x + v1966.w, v1967.y + 22), 1, 1, 4);
        render_proxy.rect(v1967, Vector(v1967.x + v1966.w, v1967.y + 22), colors.panel.l2, 4);
    end;
end;
widgets_manager.watermark.builds = {
    nil,
    pui.string("bliss \f<bolt>"),
    pui.string("beta \f<flask>"),
    pui.string("debug \f<brackets-curly>")
};
widgets_manager.watermark.items = {
    [1] = {
        [1] = 0,
        w = 96,
        [2] = function (v1968, v1969)
            -- upvalues: ui_tabs (ref), widgets_manager (ref), build_level (ref), colors (ref), render_proxy (ref), current_font_set (ref), Vector (ref)
            local v1970 = ui_tabs.settings.watermark[1];
            local v1971 = widgets_manager.watermark.get_name();
            local v1972 = v1970.sb and v1970.sb.value and widgets_manager.watermark.builds[build_level] or nil;
            local v1973 = v1971 .. (v1972 and (#v1971 > 0 and " \aFFFFFF40\226\128\148 " or "") .. colors.hex2 .. v1972 or "");
            local v1974 = widgets_manager.watermark.get_pfp();
            local v1975 = render_proxy.measure_text(current_font_set.regular, v1973).x + (v1974 and 16 or 0);
            if v1968[1] > 0 then
                widgets_manager.watermark.draw_item_back(v1968, v1969);
                render_proxy.text(current_font_set.regular, Vector(v1969.x + (v1974 and 24 or 8), v1969.y + 4), colors.text, nil, v1973);
                if v1974 then
                    render_proxy.texture(v1974, Vector(v1969.x + 4, v1969.y + 3), Vector(16, 16), colors.white, nil, 4);
                end;
            end;
            return v1974 or #v1971 > 0 or v1972, v1975 + 16;
        end,
        [3] = {}
    },
    [2] = {
        [1] = 0,
        w = 96,
        [2] = function (v1976, v1977)
            -- upvalues: ui_tabs (ref), render_proxy (ref), current_font_set (ref), widgets_manager (ref), Vector (ref), colors (ref)
            local v1978 = common.get_date(ui_tabs.settings.watermark.time.value == "12-hour" and "%I:%M %p \aFFFFFF50%A" or "%H:%M \aFFFFFF50%A");
            local l_x_1 = render_proxy.measure_text(current_font_set.regular, v1978).x;
            if v1976[1] > 0 then
                widgets_manager.watermark.draw_item_back(v1976, v1977);
                render_proxy.text(current_font_set.regular, Vector(v1977.x + 8, v1977.y + 4), colors.text, nil, v1978);
            end;
            return ui_tabs.settings.watermark.time.value ~= "Off", l_x_1 + 16;
        end,
        [3] = {}
    },
    [3] = {
        [1] = 0,
        w = 96,
        [2] = function (v1980, v1981)
            -- upvalues: string_utils (ref), render_proxy (ref), current_font_set (ref), widgets_manager (ref), Vector (ref), colors (ref)
            local v1982 = utils.net_channel();
            local v1983 = v1982 and v1982.latency[1] * 1000 or 0;
            local v1984 = string_utils.format("%d \aFFFFFF60ms", v1983);
            local l_x_2 = render_proxy.measure_text(current_font_set.regular, v1984).x;
            if v1980[1] > 0 then
                widgets_manager.watermark.draw_item_back(v1980, v1981);
                render_proxy.text(current_font_set.regular, Vector(v1981.x + 8, v1981.y + 4), colors.text, nil, v1984);
            end;
            return v1983 > 5 and widgets_manager.watermark.active_items > 0, l_x_2 + 16;
        end,
        [3] = {}
    }
};
widgets_manager.watermark.enumerate = function (v1986)
    -- upvalues: render_proxy (ref), ipairs (ref), Vector (ref), anim_manager (ref)
    local v1987 = v1986.logo * (render_proxy.style == 1 and 68 or 54);
    v1986.active_items = 0;
    for _, v1989 in ipairs(v1986.items) do
        local v1990 = Vector(v1986.pos.x + v1987, v1986.pos.y + (render_proxy.style == 1 and 1 or 0));
        render_proxy.push_alpha(v1989[1]);
        local v1991, v1992 = v1989[2](v1989, v1990);
        render_proxy.pop_alpha();
        v1989[1] = anim_manager.condition(v1989[3], v1991);
        v1989.w = anim_manager.lerp(v1989.w, v1992, 16, 0.5);
        v1987 = v1987 + (v1989.w + (render_proxy.style == 1 and 2 or -4)) * v1989[1];
        v1986.active_items = v1986.active_items + (v1989[1] > 0 and 1 or 0);
    end;
    v1986.size.x = v1987 + (render_proxy.style == 1 and -2 or 6);
    if v1986.active_items == 0 then
        v1986.size.x = 66;
    end;
end;
widgets_manager.watermark.update = function (v1993)
    -- upvalues: anim_manager (ref), ui_tabs (ref)
    local v1994 = v1993:get_drag_position();
    if v1993.align == 2 then
        v1993.pos.x = v1994.x - v1993.size.x * v1993.alpha;
    elseif v1993.align == 1 then
        v1993.pos.x = v1994.x - v1993.size.x * 0.5;
    end;
    return anim_manager.condition(v1993.progress, ui_tabs.settings.watermark.value, 3, {
        [1] = {
            [1] = 1,
            [2] = 4
        },
        [2] = {
            [1] = 3,
            [2] = 4
        }
    });
end;
widgets_manager.watermark.paint = function (v1995, v1996, _)
    -- upvalues: anim_manager (ref), ui_tabs (ref), render_proxy (ref), Vector (ref), current_font_set (ref), colors (ref)
    v1995.logo = anim_manager.condition(v1995.logop, not ui_tabs.settings.watermark[1].hide.value);
    if v1995.logo > 0 then
        render_proxy.push_alpha(v1995.logo);
        if v1995.active_items > 0 then
            if render_proxy.style == 1 then
                render_proxy.side_v(v1996:clone(), Vector(v1996.x + 64, v1996.y + 24));
                render_proxy.logo(Vector(v1996.x + 7, v1996.y + 5), true);
            else
                local v1998 = Vector(v1996.x, v1996.y - 2);
                render_proxy.side_h(v1998, Vector(v1996.x + v1995.size.x, v1996.y + v1995.size.y));
                render_proxy.text(current_font_set.bold_d, Vector(v1996.x + 8, v1996.y + 4), colors.text, nil, "hysteria");
            end;
        else
            render_proxy.logo(Vector(v1996.x + 8, v1996.y + 5), false);
        end;
        render_proxy.pop_alpha();
    end;
    v1995:enumerate();
end;
widgets_manager.slowdown = widget_factory.new("slowdown", Vector(screen_center.x - 60, screen_center.y - 160), Vector(120, 32), {
    rulers = {
        [1] = {
            [1] = true,
            [2] = Vector(native_screen_center.x, 0),
            [3] = native_screen_size.y
        }
    }
});
widgets_manager.slowdown.speed = 0.5;
widgets_manager.slowdown.update = function (v1999)
    -- upvalues: ui_tabs (ref), local_player (ref), pui (ref), anim_manager (ref)
    if not ui_tabs.settings.slowdown.value or not local_player.valid and pui.alpha <= 0 then
        return anim_manager.condition(v1999.progress, false, -8);
    else
        v1999.speed = local_player.valid and local_player.self.m_flVelocityModifier or 1;
        return anim_manager.condition(v1999.progress, pui.alpha > 0 or local_player.valid and v1999.speed < 1, -8);
    end;
end;
widgets_manager.slowdown.style = {
    [1] = function (v2000, v2001, v2002)
        -- upvalues: Color (ref), colors (ref), render_proxy (ref), Vector (ref), image_assets (ref), current_font_set (ref), string_utils (ref), math_utils (ref)
        local v2003 = Color(240, 60, 60):lerp(colors.text, v2000.speed);
        render_proxy.blur(Vector(v2001.x + 36, v2001.y + 1), Vector(v2002.x, v2002.y - 1), 1, 1, 4);
        render_proxy.rect(Vector(v2001.x + 36, v2001.y + 1), Vector(v2002.x, v2002.y - 1), colors.panel.l2, 4);
        render_proxy.side_v(v2001, v2001 + 32);
        render_proxy.texture(image_assets.warning, v2001 + 8, Vector(16, 16), v2003);
        render_proxy.text(current_font_set.regular, Vector(v2001.x + 44, v2001.y + 6), colors.text:alpha_modulate((1 - v2000.speed) * 196 + 64), nil, "slowed");
        render_proxy.text(current_font_set.regular, Vector(v2002.x - 8, v2001.y + 6), v2003, "r", string_utils.format("%d%%", v2000.speed * 100));
        render_proxy.rect(Vector(v2001.x + 44, v2001.y + 21), Vector(v2002.x - 8, v2001.y + 23), colors.white:alpha_modulate(32), 2);
        render_proxy.rect(Vector(v2001.x + 44, v2001.y + 21), Vector(math_utils.lerp(v2001.x + 44, v2002.x - 8, v2000.speed), v2001.y + 23), colors.secondary:alpha_modulate(v2000.speed * 196 + 58), 2);
    end,
    [2] = function (v2004, v2005, v2006)
        -- upvalues: Color (ref), colors (ref), render_proxy (ref), image_assets (ref), Vector (ref), current_font_set (ref), string_utils (ref)
        local v2007 = Color(240, 60, 60):lerp(colors.text, v2004.speed);
        local v2008 = (v2005.x + v2006.x) * 0.5;
        render_proxy.texture(image_assets.warning, Vector(v2008 - 8, v2005.y - 2), Vector(16, 16), v2007);
        render_proxy.text(current_font_set.regular, Vector(v2008, v2005.y + 20), colors.text, "c", "slowed down");
        render_proxy.text(current_font_set.regular, Vector(v2008, v2005.y + 32), v2007:alpha_modulate((1 - v2004.speed) * 196 + 64), "c", string_utils.format("%d%%", v2004.speed * 100));
    end
};
widgets_manager.slowdown.paint = function (v2009, v2010, v2011)
    -- upvalues: render_proxy (ref)
    v2009.style[render_proxy.style](v2009, v2010, v2011);
end;
widgets_manager.lchelper = widget_factory.new("lchelper", Vector(screen_center.x - 60, screen_center.y - 118), Vector(120, 32), {
    rulers = {
        [1] = {
            [1] = true,
            [2] = Vector(native_screen_center.x, 0),
            [3] = native_screen_size.y
        }
    }
});
widget_instance = widgets_manager.lchelper;
v1956 = "last_charge";
l_watermark_0 = widgets_manager.lchelper;
v1958 = "last_discharge_lc";
l_watermark_1 = widgets_manager.lchelper;
v1960 = "last_lc";
v1961 = 0;
v1962 = 0;
l_watermark_1[v1960] = 0;
l_watermark_0[v1958] = v1962;
widget_instance[v1956] = v1961;
widgets_manager.lchelper.timer = nil;
widgets_manager.lchelper.breaking = false;
widgets_manager.lchelper.discharging = false;
widgets_manager.lchelper.praise = {
    [0] = {
        "failed",
        Color("FF4040")
    },
    [1] = {
        "bad",
        Color("FFAF68")
    },
    [2] = {
        "bad",
        Color("FFAF68")
    },
    [3] = {
        "bad",
        Color("FFAF68")
    },
    [4] = {
        [1] = "ok",
        [2] = colors.text
    },
    [5] = {
        [1] = "ok",
        [2] = colors.text
    },
    [6] = {
        [1] = "ok",
        [2] = colors.text
    },
    [7] = {
        "good",
        Color("CDEC8E")
    },
    [8] = {
        "good",
        Color("CDEC8E")
    },
    [9] = {
        "good",
        Color("CDEC8E")
    },
    [10] = {
        "nice",
        Color("7AF1B6")
    },
    [11] = {
        "nice",
        Color("7AF1B6")
    },
    [12] = {
        "ideal lc",
        Color("65D5FF")
    },
    [13] = {
        "lc god",
        Color("CF91FF")
    },
    [14] = {
        "the world threat",
        Color("FF0000")
    }
};
widgets_manager.lchelper.update = function (v2012)
    -- upvalues: ui_tabs (ref), local_player (ref), pui (ref), anim_manager (ref), menu_items (ref)
    if not ui_tabs.settings.lchelper.value or not local_player.valid and pui.alpha <= 0 then
        return anim_manager.condition(v2012.progress, false, -8);
    else
        local v2013 = (menu_items.rage.main.dt.lag:get_override() or menu_items.rage.main.dt.lag.value) == "Always On";
        local v2014 = (menu_items.rage.main.hs.options:get_override() or menu_items.rage.main.hs.options.value) == "Break LC";
        v2012.breaking = v2013 or v2014 or v2012.timer or local_player.exploit.lc_left > 0;
        if ui_tabs.settings.lchelper.bar.value then
            if v2012.breaking and local_player.jumping then
                v2012.progress[1] = 1;
            end;
            v2012.size.y = v2012.timer and 34 or 21;
            return anim_manager.condition(v2012.progress, pui.alpha > 0 or local_player.valid and v2012.breaking and (local_player.jumping or v2012.timer), -8);
        else
            if v2012.timer and local_player.jumping then
                v2012.progress[1] = 1;
            end;
            v2012.size.y = 21;
            return anim_manager.condition(v2012.progress, pui.alpha > 0 or local_player.valid and v2012.breaking and v2012.timer, -8);
        end;
    end;
end;
widgets_manager.lchelper.check = function (_)
    -- upvalues: widgets_manager (ref), ui_tabs (ref), local_player (ref), db_manager (ref)
    local l_lchelper_0 = widgets_manager.lchelper;
    if not ui_tabs.settings.lchelper.value then
        return;
    else
        local l_charge_0 = local_player.exploit.charge;
        if l_charge_0 < l_lchelper_0.last_charge and local_player.jumping and not l_lchelper_0.discharging then
            l_lchelper_0.discharging = true;
            l_lchelper_0.timer = globals.realtime + (l_lchelper_0.last_lc == 14 and 2 or 0.66);
            l_lchelper_0.last_discharge_lc = l_lchelper_0.last_lc;
            if l_lchelper_0.last_discharge_lc >= 13 then
                db_manager.stats.god_lc = db_manager.stats.god_lc + 1;
            end;
            if l_lchelper_0.last_discharge_lc == 14 then
                db_manager.stats.wt_lc = db_manager.stats.wt_lc + 1;
            end;
        end;
        if l_lchelper_0.discharging and l_charge_0 == 0 then
            l_lchelper_0.discharging = false;
        end;
        if l_lchelper_0.timer and globals.realtime > l_lchelper_0.timer then
            l_lchelper_0.timer = nil;
        end;
        l_lchelper_0.last_charge = local_player.exploit.charge;
        l_lchelper_0.last_lc = local_player.exploit.lc_left;
        return;
    end;
end;
widgets_manager.lchelper.paint = function (v2018, v2019, v2020)
    -- upvalues: ui_tabs (ref), render_proxy (ref), colors (ref), math_utils (ref), local_player (ref), Vector (ref), pui (ref), string_utils (ref), current_font_set (ref)
    local l_value_13 = ui_tabs.settings.lchelper.bar.value;
    if l_value_13 then
        render_proxy.blur(v2019, v2020, 1, 1, 4);
        render_proxy.rect(v2019, v2020, colors.panel.l2, 4);
    end;
    if l_value_13 then
        local v2022 = math_utils.clamp((v2018.timer and v2018.last_discharge_lc or local_player.exploit.lc_left) / 12, 0, 1);
        local v2023 = Vector(math_utils.lerp(v2020.x - 12, v2019.x + 4, v2022), v2020.y - 4);
        local v2024 = v2018.timer and v2018.last_discharge_lc or v2018.breaking and local_player.exploit.lc_left or -1;
        render_proxy.rect(Vector(v2019.x + 8, v2020.y - 12), Vector(v2019.x + 8 + 6, v2020.y - 8), v2018.praise[12][2]:alpha_modulate(v2024 == 12 and 1 or 0.33, true));
        render_proxy.rect(Vector(v2019.x + 8 + 7, v2020.y - 12), Vector(v2019.x + 8 + 24, v2020.y - 8), v2018.praise[11][2]:alpha_modulate(v2024 <= 11 and v2024 > 9 and 1 or 0.33, true));
        render_proxy.rect(Vector(v2019.x + 8 + 25, v2020.y - 12), Vector(v2019.x + 8 + 50, v2020.y - 8), v2018.praise[9][2]:alpha_modulate(v2024 <= 9 and v2024 > 6 and 1 or 0.33, true));
        render_proxy.rect(Vector(v2019.x + 8 + 51, v2020.y - 12), Vector(v2019.x + 8 + 76, v2020.y - 8), v2018.praise[6][2]:alpha_modulate(v2024 <= 6 and v2024 > 3 and 1 or 0.33, true));
        render_proxy.rect(Vector(v2019.x + 8 + 77, v2020.y - 12), Vector(v2019.x + 8 + 96, v2020.y - 8), v2018.praise[3][2]:alpha_modulate(v2024 <= 3 and v2024 > 0 and 1 or 0.33, true));
        render_proxy.rect(Vector(v2019.x + 8 + 97, v2020.y - 12), Vector(v2019.x + 8 + 104, v2020.y - 8), v2018.praise[0][2]:alpha_modulate(v2024 == 0 and 1 or 0.3, true));
        if v2018.breaking then
            render_proxy.poly(colors.white, v2023 + Vector(0, 4), v2023 + Vector(4, 0), v2023 + Vector(8, 4));
        end;
    end;
    local l_timer_0 = v2018.timer;
    if not l_value_13 then
        l_timer_0 = v2018.alpha > 0 or pui.alpha > 0;
    end;
    if l_timer_0 then
        local v2026 = v2018.praise[v2018.last_discharge_lc];
        local l_last_discharge_lc_0 = v2018.last_discharge_lc;
        if l_value_13 then
            local v2028 = string_utils.format("\a%s%s", v2026[2]:to_hex(), v2026[1]);
            render_proxy.text(l_last_discharge_lc_0 == 14 and current_font_set.bold or current_font_set.regular, Vector((v2019.x + v2020.x) * 0.5, v2019.y + 10), colors.text, "c", v2028);
            render_proxy.text(current_font_set.regular, Vector(v2020.x - 8, v2019.y + 5), colors.text:alpha_modulate(0.33, true), "r", l_last_discharge_lc_0);
        else
            local v2029;
            if pui.alpha > 0 and not v2018.timer then
                v2029 = "lc status";
            else
                v2029 = string_utils.format("\a%s%s", v2026[2]:to_hex(), v2026[1], l_last_discharge_lc_0);
            end;
            local v2030 = l_last_discharge_lc_0 == 14 and math_utils.random(-1, 1) or 0;
            render_proxy.text(l_last_discharge_lc_0 == 14 and current_font_set.bold_d or current_font_set.regular_d, Vector((v2019.x + v2020.x) * 0.5 + v2030, v2019.y + 4), colors.text, "c", v2029);
            render_proxy.text(current_font_set.regular_d, Vector((v2019.x + v2020.x) * 0.5, v2019.y + 17), colors.text:alpha_modulate(0.5, true), "c", l_last_discharge_lc_0 .. "t");
        end;
    end;
end;
ui_tabs.settings.lchelper:set_callback(function (v2031)
    -- upvalues: events (ref), widgets_manager (ref)
    events.createmove(widgets_manager.lchelper.check, v2031.value);
end, true);
widgets_manager.keylist = widget_factory.new("keylist", Vector(screen_center.x - 400, screen_center.y), Vector(120, 22), true);
widgets_manager.keylist.format = {
    knames = setmetatable({}, {
        mode = "kv"
    }),
    name = function (v2032, v2033)
        -- upvalues: string_utils (ref), colors (ref)
        if not v2032.knames[v2033] then
            local l_v2033_0 = v2033;
            local v2035 = 0;
            local v2036 = 0;
            local v2037 = 0;
            local v2038, v2039 = string_utils.gsub(l_v2033_0, "\a{Link Active}", "\f");
            v2035 = v2039;
            v2038, v2039 = string_utils.gsub(v2038, "[\t\226\128\138]", {
                ["\t"] = "  ",
                ["\226\128\138"] = ""
            });
            v2036 = v2039;
            l_v2033_0 = v2038;
            if v2036 == 0 then
                v2038, v2039 = string_utils.gsub(l_v2033_0, " %a", string_utils.lower);
                v2037 = v2039;
                l_v2033_0 = v2038;
            end;
            v2032.knames[v2033] = l_v2033_0;
        end;
        return string_utils.gsub(v2032.knames[v2033], "\f", colors.hex, 1), nil;
    end,
    state = function (_, v2041)
        -- upvalues: type (ref), string_utils (ref), table_utils (ref)
        local v2042 = type(v2041);
        if v2042 == "boolean" then
            return v2041 and "on" or "off";
        elseif v2042 == "table" then
            local v2043 = {};
            for v2044 = 1, #v2041 do
                v2043[v2044] = string_utils.sub(v2041[v2044], 1, 1);
            end;
            return table_utils.concat(v2043, ", ");
        else
            return v2041;
        end;
    end,
    state2 = function (_, v2046, v2047)
        -- upvalues: type (ref), string_utils (ref), table_utils (ref)
        local v2048 = type(v2046);
        if v2048 == "boolean" then
            if v2047 == 1 then
                return v2046 and "holding" or "holding";
            else
                return v2046 and "toggled" or "disabled";
            end;
        elseif v2048 == "table" then
            local v2049 = {};
            for v2050 = 1, #v2046 do
                v2049[v2050] = string_utils.sub(v2046[v2050], 1, 1);
            end;
            return table_utils.concat(v2049, ", ");
        else
            return v2046;
        end;
    end
};
widgets_manager.keylist.draw_item = {
    [1] = function (v2051, v2052, v2053, v2054)
        -- upvalues: Vector (ref), render_proxy (ref), colors (ref), current_font_set (ref)
        local v2055;
        local v2056;
        v2055 = Vector(v2051.pos.x + 4, v2051.pos.y + v2053 + 28 * (v2052.active and v2054 or 1));
        v2056 = Vector(v2051.size.x - 8, 20);
        render_proxy.blur(v2055, v2055 + v2056, 1, 1, 4);
        render_proxy.rect(v2055, v2055 + v2056, colors.panel.l2, 4);
        local v2057 = v2051.format:name(v2052.name);
        local v2058 = v2051.format:state(v2052.value);
        render_proxy.text(current_font_set.regular, Vector(v2055.x + 6, v2055.y + 3), colors.text, nil, v2057);
        render_proxy.text(current_font_set.regular, Vector(v2055.x + v2056.x - 6, v2055.y + 3), colors.secondary, "r", v2058);
        local l_x_3 = render_proxy.measure_text(current_font_set.regular, v2057).x;
        local l_x_4 = render_proxy.measure_text(current_font_set.regular, v2058).x;
        return Vector(l_x_3 + l_x_4 + 32, v2056.y + 2);
    end,
    [2] = function (v2061, v2062, v2063, v2064)
        -- upvalues: Vector (ref), string_utils (ref), render_proxy (ref), current_font_set (ref), colors (ref)
        local v2065;
        local v2066;
        v2065 = Vector(v2061.pos.x + 4, v2061.pos.y + v2063 + 21 * (v2062.active and v2064 or 1));
        v2066 = Vector(v2061.size.x - 8, 14);
        local v2067 = string_utils.lower(v2061.format:name(v2062.name));
        local v2068 = v2061.format:state2(v2062.value, v2062.state);
        render_proxy.text(current_font_set.regular, Vector(v2065.x, v2065.y + 3), colors.text, nil, v2067);
        render_proxy.text(current_font_set.regular, Vector(v2065.x + v2066.x, v2065.y + 3), colors.text:alpha_modulate(0.5, true), "r", v2068);
        local l_x_5 = render_proxy.measure_text(current_font_set.regular, v2067).x;
        local l_x_6 = render_proxy.measure_text(current_font_set.regular, v2068).x;
        return Vector(l_x_5 + l_x_6 + 32, v2066.y + 2);
    end
};
widgets_manager.keylist:enlist(function ()
    -- upvalues: keybinds (ref)
    return keybinds;
end, function (v2071, v2072, v2073, v2074)
    -- upvalues: widgets_manager (ref), render_proxy (ref)
    return widgets_manager.keylist.draw_item[render_proxy.style](v2071, v2072, v2073, v2074);
end);
widgets_manager.keylist.update = function (v2075)
    -- upvalues: anim_manager (ref), ui_tabs (ref), pui (ref)
    return anim_manager.condition(v2075.progress, ui_tabs.settings.keylist.value and (pui.alpha > 0 or v2075.__list.active > 0));
end;
widgets_manager.keylist.paint = function (v2076, v2077, v2078)
    -- upvalues: render_proxy (ref), string_utils (ref), colors (ref), pui (ref), current_font_set (ref), Vector (ref)
    render_proxy.side_h(v2077, v2078);
    if render_proxy.style == 1 then
        local v2079 = string_utils.format("%s%s\aDEFAULT %s", colors.hex, pui.get_icon("link-simple"), "Hotkeys");
        render_proxy.text(current_font_set.regular, Vector(v2077.x + v2076.size.x * 0.5, v2077.y + 11), colors.text, "c", v2079);
    else
        render_proxy.text(current_font_set.regular, Vector(v2077.x + v2076.size.x * 0.5, v2077.y + 11), colors.text, "c", "keybinds");
    end;
end;
widgets_manager.speclist = widget_factory.new("speclist", Vector(screen_center.x + 280, screen_center.y), Vector(120, 22), true);
widgets_manager.speclist.draw_item = {
    [1] = function (v2080, v2081, v2082, v2083)
        -- upvalues: Vector (ref), render_proxy (ref), colors (ref), current_font_set (ref)
        local v2084 = Vector(v2080.pos.x + 4, v2080.pos.y + v2082 + 28 * (v2081.active and v2083 or 1));
        local v2085 = Vector(v2080.size.x - 8, 20);
        local v2086 = v2084 + v2085;
        render_proxy.blur(v2084, v2084 + v2085, 1, 1, 4);
        render_proxy.rect(v2084, v2084 + v2085, colors.panel.l2, 4);
        local l_nick_0 = v2081.nick;
        local v2088 = v2081.ent:get_steam_avatar();
        render_proxy.texture(v2088, Vector(v2086.x - 20, v2084.y + 2), Vector(16, 16), nil, nil, 8);
        render_proxy.text(current_font_set.regular, Vector(v2084.x + 6, v2084.y + 3), colors.text, nil, l_nick_0);
        local l_x_7 = render_proxy.measure_text(current_font_set.regular, l_nick_0).x;
        return Vector(l_x_7 + 40, 22);
    end,
    [2] = function (v2090, v2091, v2092, v2093)
        -- upvalues: Vector (ref), render_proxy (ref), current_font_set (ref), colors (ref)
        local v2094 = Vector(v2090.pos.x + 4, v2090.pos.y + v2092 + 21 * (v2091.active and v2093 or 1));
        local v2095 = Vector(v2090.size.x - 8, 14);
        local v2096 = v2094 + v2095;
        local l_nick_1 = v2091.nick;
        local v2098 = v2091.ent:get_steam_avatar();
        render_proxy.texture(v2098, Vector(v2096.x - 14, v2094.y + 2), Vector(14, 14), nil, nil, 8);
        render_proxy.text(current_font_set.regular, Vector(v2094.x, v2094.y + 3), colors.text, nil, l_nick_1);
        local l_x_8 = render_proxy.measure_text(current_font_set.regular, l_nick_1).x;
        return Vector(l_x_8 + 40, v2095.y + 2);
    end
};
widgets_manager.speclist:enlist(function ()
    -- upvalues: local_player (ref), players (ref), string_utils (ref)
    local v2100 = {};
    if local_player.valid then
        local v2101 = nil;
        if local_player.self.m_hObserverTarget and (local_player.self.m_iObserverMode == 4 or local_player.self.m_iObserverMode == 5) then
            v2101 = local_player.self.m_hObserverTarget;
        else
            v2101 = local_player.self;
        end;
        for v2102 = 1, #players do
            local v2103 = players[v2102];
            if v2103 and not v2103:is_dormant() then
                local l_m_hObserverTarget_0 = v2103.m_hObserverTarget;
                local l_m_iObserverMode_0 = v2103.m_iObserverMode;
                v2100[#v2100 + 1] = {
                    name = v2103:get_xuid(),
                    ent = v2103,
                    nick = string_utils.limit(v2103:get_name(), 20, "\aFFFFFF80..."),
                    active = l_m_hObserverTarget_0 and l_m_hObserverTarget_0 == v2101 and v2103 ~= local_player.self and (not (l_m_iObserverMode_0 ~= 4) or l_m_iObserverMode_0 == 5)
                };
            end;
        end;
    end;
    return v2100;
end, function (v2106, v2107, v2108, v2109)
    -- upvalues: widgets_manager (ref), render_proxy (ref)
    return widgets_manager.speclist.draw_item[render_proxy.style](v2106, v2107, v2108, v2109);
end);
events.round_start:set(function ()
    -- upvalues: widgets_manager (ref)
    local l___list_2 = widgets_manager.speclist.__list;
    local l___list_3 = widgets_manager.speclist.__list;
    local v2112 = {};
    l___list_3.progress = {};
    l___list_2.items = v2112;
end);
widgets_manager.speclist.update = function (v2113)
    -- upvalues: anim_manager (ref), ui_tabs (ref), pui (ref)
    return anim_manager.condition(v2113.progress, ui_tabs.settings.speclist.value and (pui.alpha > 0 or v2113.__list.active > 0));
end;
widgets_manager.speclist.paint = function (v2114, v2115, v2116)
    -- upvalues: render_proxy (ref), string_utils (ref), colors (ref), pui (ref), current_font_set (ref), Vector (ref)
    render_proxy.side_h(v2115, v2116);
    if render_proxy.style == 1 then
        local v2117 = string_utils.format("%s%s\aDEFAULT  %s \aFFFFFF60(%d)", colors.hex, pui.get_icon("glasses-round"), "Spectators", v2114.__list.active);
        render_proxy.text(current_font_set.regular, Vector(v2115.x + v2114.size.x * 0.5, v2115.y + 11), colors.text, "c", v2117);
    else
        render_proxy.text(current_font_set.regular, Vector(v2115.x + v2114.size.x * 0.5, v2115.y + 11), colors.text, "c", "spectators");
    end;
end;
widgets_manager.arrows = widget_factory.new("arrows", Vector(native_screen_center.x - 40, native_screen_center.y - 4), Vector(10, 10), {
    border = {
        Vector(native_screen_center.x - 120, native_screen_center.y + 1),
        Vector(native_screen_center.x - 10, native_screen_center.y + 1)
    },
    rulers = {
        [1] = {
            [1] = false,
            [2] = Vector(native_screen_center.x - 120, native_screen_center.y),
            [3] = native_screen_center.x - 10
        }
    }
});
widgets_manager.arrows.sides = {
    l = {
        [1] = 0
    },
    r = {
        [1] = 0
    }
};
widgets_manager.arrows.update = function (v2118)
    -- upvalues: local_player (ref), ui_tabs (ref), anim_manager (ref), pui (ref)
    if local_player.in_score then
        v2118.progress[1] = 0;
        return 0;
    elseif not ui_tabs.settings.arrows.value then
        return anim_manager.condition(v2118.progress, false, -8);
    else
        return anim_manager.condition(v2118.progress, local_player.valid or pui.alpha > 0, -8);
    end;
end;
widgets_manager.arrows.paint = function (v2119, v2120, _)
    -- upvalues: colors (ref), math_utils (ref), ui_groups_settings (ref), render_proxy (ref), anim_manager (ref), pui (ref), image_assets (ref), Vector (ref), screen_size (ref)
    local v2122 = colors.white:alpha_modulate(128);
    local v2123 = math_utils.normalize_yaw(ui_groups_settings.data.freestand and ui_groups_settings.data.freestand - render_proxy.camera_angles().y or 0);
    local v2124 = anim_manager.condition(v2119.sides.l, ui_groups_settings.data.manual_yaw == -90 or v2123 > 70 and v2123 < 110, -12);
    render_proxy.push_alpha((not (pui.alpha ~= 0) or v2124 > 0) and v2124 or pui.alpha);
    render_proxy.texture(image_assets.manual, v2120, Vector(11, 10), v2122:lerp(colors.secondary, v2124));
    render_proxy.pop_alpha();
    local v2125 = anim_manager.condition(v2119.sides.r, ui_groups_settings.data.manual_yaw == 90 or v2123 < -70 and v2123 > -110, -12);
    render_proxy.push_alpha((not (pui.alpha ~= 0) or v2125 > 0) and v2125 or pui.alpha);
    render_proxy.push_rotation(270);
    render_proxy.texture(image_assets.manual, Vector(screen_size.x - v2120.x - 9, v2120.y), Vector(11, 10), v2122:lerp(colors.secondary, v2125));
    render_proxy.pop_alpha();
    render_proxy.pop_rotation();
end;
widgets_manager.damage = widget_factory.new("damage", Vector(screen_center.x + 4, screen_center.y + 4), Vector(6, 4), {
    border = {
        [1] = nil,
        [2] = nil,
        [3] = true,
        [1] = native_screen_center - 40,
        [2] = native_screen_center + 40
    }
});
widgets_manager.damage.dmg = menu_items.rage.selection.damage.value;
widget_instance = widgets_manager.damage;
v1956 = "ovr_progress";
l_watermark_0 = widgets_manager.damage;
v1958 = "ovr_alpha";
l_watermark_1 = {
    [1] = 0
};
l_watermark_0[v1958] = 0;
widget_instance[v1956] = l_watermark_1;
widgets_manager.damage.fonts = {
    [1] = 2,
    [2] = nil,
    [3] = nil,
    [4] = 1,
    [2] = current_font_set.small_d,
    [3] = current_font_set.regular_d
};
widgets_manager.damage.update = function (v2126)
    -- upvalues: local_player (ref), ui_tabs (ref), anim_manager (ref), active_binds (ref), menu_items (ref), pui (ref)
    if local_player.in_score then
        v2126.progress[1] = 0;
        return 0;
    elseif not ui_tabs.settings.damage.value then
        return anim_manager.condition(v2126.progress, false, -8);
    else
        local v2127 = true;
        if ui_tabs.settings.damage.sw.value then
            v2127 = active_binds["min. damage"] ~= nil;
        end;
        local v2128 = menu_items.rage.selection.damage:get();
        v2126.dmg = ui_tabs.settings.damage.anim.value and anim_manager.lerp(v2126.dmg, v2128, 16) or v2128;
        v2126.ovr_alpha = anim_manager.condition(v2126.ovr_progress, v2127, -8);
        local v2129 = local_player.weapon and local_player.weapon_t;
        local v2130 = v2129 and v2129.weapon_type ~= 9 and v2129.weapon_type ~= 0;
        return anim_manager.condition(v2126.progress, local_player.valid and (v2130 or pui.alpha > 0) and globals.is_in_game, -8);
    end;
end;
widgets_manager.damage.paint = function (v2131, v2132, _)
    -- upvalues: math_utils (ref), tostring (ref), render_proxy (ref), ui_tabs (ref), colors (ref)
    local v2134 = math_utils.round(v2131.dmg);
    v2134 = v2134 == 0 and "A" or v2134 > 100 and "+" .. v2134 - 100 or tostring(v2134);
    v2131.size = render_proxy.measure_text(2, v2134);
    render_proxy.text(v2131.fonts[ui_tabs.settings.damage.font.value], v2132, colors.text:alpha_modulate(v2131.ovr_alpha * 0.5 + 0.5, true), nil, v2134);
end;
widgets_manager.logs = widget_factory.new("logs", Vector(screen_center.x - 150, screen_center.y + 160), Vector(300, 24), {
    rulers = {
        [1] = {
            [1] = true,
            [2] = Vector(native_screen_center.x, 0),
            [3] = native_screen_size.y
        }
    }
});
widgets_manager.logs.data = {
    p1 = {
        [1] = 0
    },
    p2 = {
        [1] = 0
    }
};
widget_instance = widgets_manager.logs;
v1956 = "preview";
l_watermark_0 = widgets_manager.logs;
v1958 = "dummy";
l_watermark_1 = 0;
l_watermark_0[v1958] = {
    [1] = {
        text = "\ab6ff57FF\226\128\162\aE6E6E660 Killed \aE6E6E6FFmaj0r\aE6E6E660 in \aE6E6E6FFhead",
        event = "hit",
        time = math_utils.huge,
        progress = {
            [1] = 0
        }
    },
    [2] = {
        text = "\ab8a6ffFF\226\128\162\aE6E6E660 Missed \aE6E6E6FFenQ\aE6E6E660's\aE6E6E6FF head\aE6E6E660 due to \aE6E6E6FFunpredicted occasion",
        event = "miss",
        time = math_utils.huge,
        progress = {
            [1] = 0
        }
    },
    [3] = {
        text = "\aff5c5cFF\226\128\162\aE6E6E660 Harmed by \aE6E6E6FFenQ\aE6E6E660 in \aE6E6E6FFhead\aE6E6E660 for \aE6E6E6FF72",
        event = "harm",
        time = math_utils.huge,
        progress = {
            [1] = 0
        }
    }
};
widget_instance[v1956] = l_watermark_1;
widgets_manager.logs.update = function (v2135)
    -- upvalues: anim_manager (ref), ui_tabs (ref)
    return anim_manager.condition(v2135.progress, ui_tabs.settings.logs.value and globals.is_in_game and ui_tabs.settings.logs.sc.value);
end;
widgets_manager.logs.part = {
    [1] = function (v2136, v2137, v2138, v2139, v2140, v2141)
        -- upvalues: render_proxy (ref), current_font_set (ref), Vector (ref), math_utils (ref), colors (ref), image_assets (ref)
        local v2142 = render_proxy.measure_text(current_font_set.regular, v2137.text).x + 32;
        local v2143 = Vector(math_utils.lerp(v2136.pos.x + v2136.size.x * 0.5 - v2142 * 0.5 - 4, v2136.pos.x, v2136.align), v2136.pos.y + v2138);
        if not v2140 then
            v2143.x = v2143.x + (1 - v2139) * (v2142 * 0.5) * (v2136.align == 0 and v2141 % 2 == 0 and 1 or -1);
        end;
        render_proxy.blur(Vector(v2143.x + 27, v2143.y + 1), Vector(v2143.x + v2142 + 8, v2143.y + 23), 1, 1, 4);
        render_proxy.rect(Vector(v2143.x + 27, v2143.y + 1), Vector(v2143.x + v2142 + 8, v2143.y + 23), colors.panel.l2, 4);
        render_proxy.text(current_font_set.regular, Vector(v2143.x + 33, v2143.y + 5), colors.text, nil, v2137.text);
        render_proxy.side_v(v2143, v2143 + 24);
        render_proxy.texture(image_assets.bfly, v2143 + 8, Vector(9, 9), colors.accent);
    end,
    [2] = function (v2144, v2145, v2146, v2147, v2148, v2149)
        -- upvalues: render_proxy (ref), current_font_set (ref), Vector (ref), math_utils (ref), colors (ref)
        local l_x_9 = render_proxy.measure_text(current_font_set.regular, v2145.text).x;
        local v2151 = Vector(math_utils.lerp(v2144.pos.x + v2144.size.x * 0.5 - l_x_9 * 0.5 - 4, v2144.pos.x, v2144.align), v2144.pos.y + v2146);
        if not v2148 then
            v2151.x = v2151.x + (1 - v2147) * (l_x_9 * 0.5) * (v2144.align == 0 and v2149 % 2 == 0 and 1 or -1);
        end;
        render_proxy.text(current_font_set.regular, Vector(v2151.x, v2151.y + 5), colors.text, nil, v2145.text);
    end
};
widgets_manager.logs.paint = function (v2152, _, _)
    -- upvalues: anim_manager (ref), pui (ref), aa_ui_elements_or_aa_runtime_state (ref), ui_tabs (ref), screen_size (ref), iif (ref), render_proxy (ref), table_utils (ref)
    v2152.preview = anim_manager.condition(v2152.data.p1, pui.alpha > 0 and #aa_ui_elements_or_aa_runtime_state.list == 0 and ui_tabs.settings.logs.sc.value);
    v2152.align = anim_manager.condition(v2152.data.p2, v2152.pos.x < screen_size.x / 3);
    local v2155 = 0;
    local v2156 = nil;
    local v2157 = v2152.preview > 0 and v2152.dummy or aa_ui_elements_or_aa_runtime_state.list;
    for v2158 = 1, #v2157 do
        local v2159 = v2157[v2158];
        local v2160 = globals.realtime - v2159.time < 4 and v2158 < 8;
        local v2161 = anim_manager.condition(v2159.progress, iif(v2152.preview > 0, v2152.preview == 1, v2160));
        if v2161 == 0 then
            v2156 = v2158;
        end;
        render_proxy.push_alpha(v2161);
        v2152.part[render_proxy.style](v2152, v2159, v2155, v2161, v2160, v2158);
        render_proxy.pop_alpha();
        v2155 = v2155 + (render_proxy.style == 1 and 28 or 20) * (v2160 and v2161 or 1);
    end;
    if v2156 then
        table_utils.remove(aa_ui_elements_or_aa_runtime_state.list, v2156);
    end;
end;
widgets_manager.process = widget_factory.new("process", Vector(screen_center.x - 68, screen_center.y - 320), Vector(136, 22), true);
widgets_manager.process.draw_graph = function (v2162, v2163, v2164, v2165, v2166)
    -- upvalues: Vector (ref), render_proxy (ref)
    local v2167 = #v2164;
    for v2168 = 1, v2167 - 1 do
        local v2169 = v2168 + 1;
        local v2170 = v2163.z * v2168;
        local v2171 = v2163.z * v2169;
        local v2172 = 1 - v2164[v2168];
        local v2173 = 1 - v2164[v2169];
        local v2174 = Vector(v2162.x + v2170, v2162.y + v2163.y * v2172);
        local v2175 = Vector(v2162.x + v2171, v2162.y + v2163.y * v2173);
        local v2176 = v2166 and v2165:lerp(v2166, v2168 / v2167) or v2165;
        render_proxy.line(v2174, v2175, v2176);
    end;
end;
widgets_manager.process.factors = {
    ex = {
        work = function (_, v2178, _, _)
            -- upvalues: Vector (ref), widgets_manager (ref), render_proxy (ref), colors (ref), local_player (ref), current_font_set (ref), string_utils (ref), Color (ref)
            local v2181 = 40;
            local v2182 = Vector(v2178.x + widgets_manager.process.size.x - 8, v2178.y + v2181);
            render_proxy.blur(v2178, v2182, 1, 1, 4);
            render_proxy.rect(v2178, v2182, colors.panel.l2, 4);
            local v2183 = local_player.exploit.active == 0 and "~" or local_player.exploit.active == 1 and "DOUBLE TAP" or "HIDE SHOTS";
            render_proxy.text(current_font_set.small, Vector(v2178.x + 8, v2178.y + 5), colors.text:alpha_modulate(0.25, true), nil, "EXPLOIT");
            render_proxy.text(current_font_set.small, Vector(v2182.x - 8, v2178.y + 5), colors.text, "r", v2183);
            local v2184 = rage.exploit:get();
            local v2185 = string_utils.format("%dt", v2184 * 14);
            local v2186 = colors.text:lerp(colors.secondary, v2184);
            render_proxy.text(current_font_set.regular, Vector(v2178.x + 8, v2178.y + 20), colors.text, nil, "Shifted");
            render_proxy.circle_outline(Vector(v2182.x - 12, v2178.y + 27), Color(255, 40), 5, 0, 1, 1.5);
            render_proxy.circle_outline(Vector(v2182.x - 12, v2178.y + 27), v2186, 5, 0, v2184, 1.5);
            render_proxy.text(current_font_set.regular, Vector(v2182.x - 20, v2178.y + 20), v2186, "r", v2185);
            return v2181;
        end
    },
    aa = {
        naturality = 0,
        h = 46,
        work = function (v2187, v2188, _)
            -- upvalues: ui_tabs (ref), widgets_manager (ref), Vector (ref), render_proxy (ref), colors (ref), current_font_set (ref), anim_manager (ref), ui_groups_settings (ref), Color (ref), aa_states (ref), math_utils (ref)
            local l_value_14 = ui_tabs.antiaim.general.nature.value;
            local l_value_15 = ui_tabs.settings.process.graph.value;
            local v2192 = l_value_15 and 64 or l_value_14 and 46 or 40;
            local v2193 = widgets_manager.process.size.x - 8;
            local v2194 = Vector(v2188.x + v2193, v2188.y + v2192);
            render_proxy.blur(v2188, v2194, 1, 1, 4);
            render_proxy.rect(v2188, v2194, colors.panel.l2, 4);
            render_proxy.text(current_font_set.small, Vector(v2188.x + 8, v2188.y + 5), colors.text:alpha_modulate(0.25, true), nil, "ANTI-AIM");
            render_proxy.text(current_font_set.small, Vector(v2194.x - 8, v2188.y + 5), colors.text, "r", l_value_14 and "NATURAL" or "REGULAR");
            local v2195 = 0;
            if not l_value_15 then
                if l_value_14 then
                    v2187.naturality = anim_manager.lerp(v2187.naturality, ui_groups_settings.data.statew or 0, 24);
                    local l_naturality_0 = v2187.naturality;
                    local l_state_1 = ui_groups_settings.data.state;
                    local v2198 = ui_groups_settings.data.stateb or ui_groups_settings.data.state;
                    render_proxy.text(current_font_set.regular, Vector(v2188.x + 8, v2188.y + 20 + v2195), Color(240, 80):lerp(colors.accent, 1 - l_naturality_0), nil, aa_states.states[l_state_1][2]);
                    render_proxy.text(current_font_set.regular, Vector(v2194.x - 8, v2188.y + 20 + v2195), Color(240, 80):lerp(colors.secondary, l_naturality_0), "r", aa_states.states[v2198][2]);
                    local v2199 = math_utils.max(2, (v2193 - 16) * l_naturality_0);
                    local v2200 = colors.accent:lerp(colors.secondary, l_naturality_0);
                    render_proxy.rect(Vector(v2188.x + 8, v2188.y + 36 + v2195), Vector(v2194.x - 8, v2188.y + 38 + v2195), Color(255, 16), 2);
                    render_proxy.gradient(Vector(v2188.x + 8, v2188.y + 36 + v2195), Vector(v2188.x + 8 + v2199, v2188.y + 38 + v2195), colors.accent, v2200, colors.accent, v2200, 2);
                    v2195 = v2195 + 24;
                else
                    local l_state_2 = ui_groups_settings.data.state;
                    render_proxy.text(current_font_set.regular, Vector(v2188.x + 8, v2188.y + 20 + v2195), colors.text, nil, "State");
                    render_proxy.text(current_font_set.regular, Vector(v2194.x - 8, v2188.y + 20 + v2195), colors.secondary, "r", aa_states.states[l_state_2][2]);
                    v2195 = v2195 + 16;
                end;
            else
                local v2202 = not ui_tabs.settings.style.blur.value;
                render_proxy.line(Vector(v2188.x + 8, v2188.y + 22), Vector(v2194.x - 8, v2188.y + 22), Color(255, 16));
                render_proxy.line(Vector(v2188.x + 8, v2188.y + 54), Vector(v2194.x - 8, v2188.y + 54), Color(255, 16));
                widgets_manager.process.draw_graph(Vector(v2188.x - 3, v2188.y + 17), Vector(120, 37, 12), ui_groups_settings.data.states_record, v2202 and colors.secondary or colors.accent:alpha_modulate(80), not v2202 and colors.secondary or nil);
            end;
            return v2192;
        end
    },
    ven = {
        progress = {
            [1] = {
                [1] = 0
            },
            [2] = {
                [1] = 0
            },
            [3] = {
                [1] = 0
            }
        },
        work = function (_, v2204, _)
            -- upvalues: Vector (ref), widgets_manager (ref), ui_groups_settings (ref), render_proxy (ref), colors (ref), current_font_set (ref), string_utils (ref)
            local v2206 = 40;
            local v2207 = Vector(v2204.x + widgets_manager.process.size.x - 8, v2204.y + v2206);
            local l_values_0 = ui_groups_settings.venture.values;
            if not ui_groups_settings.scenery.theatre.venture then
                local _ = {
                    long = {
                        gaslight = false
                    },
                    short = {
                        diversity = 0,
                        evasion = false,
                        tension = 0
                    }
                };
            end;
            render_proxy.blur(v2204, v2207, 1, 1, 4);
            render_proxy.rect(v2204, v2207, colors.panel.l2, 4);
            render_proxy.text(current_font_set.small, Vector(v2204.x + 8, v2204.y + 5), colors.text:alpha_modulate(0.25, true), nil, "VENTURE");
            render_proxy.text(current_font_set.regular, Vector(v2204.x + 8, v2204.y + 20), colors.text, nil, string_utils.format("G %s%.1f\aFFFFFF40 | \aDEFAULTE %s%.1f\aFFFFFF40 | \aDEFAULTT %s%d%%", colors.hex2, l_values_0.gaslight, colors.hex2, l_values_0.evasion * 10, colors.hex2, l_values_0.tension * 100));
            return v2206;
        end
    }
};
widgets_manager.process:enlist(function ()
    -- upvalues: menu_items (ref), ui_tabs (ref)
    return {
        [1] = {
            name = "ex",
            active = menu_items.rage.main.dt.value or menu_items.rage.main.hs.value
        },
        [2] = {
            name = "aa",
            active = ui_tabs.antiaim.enable.value
        }
    };
end, function (v2210, v2211, v2212, v2213)
    -- upvalues: Vector (ref)
    local v2214 = Vector(v2210.pos.x + 4, v2210.pos.y + v2212 + 28 * (v2211.active and v2213 or 1));
    local v2215 = Vector(v2210.size.x - 8, 56);
    if v2210.factors[v2211.name] then
        local v2216 = v2210.factors[v2211.name]:work(v2214, v2213);
        return Vector(120, (v2216 or v2215.y) + 2);
    else
        return Vector(120, 0);
    end;
end);
widgets_manager.process.update = function (v2217)
    -- upvalues: render_proxy (ref), anim_manager (ref), ui_tabs (ref), pui (ref), local_player (ref)
    if render_proxy.style == 1 then
        return anim_manager.condition(v2217.progress, ui_tabs.settings.process.value and (pui.alpha > 0 or local_player.valid and v2217.__list.active > 0));
    else
        return anim_manager.condition(v2217.progress, ui_tabs.settings.process.value and (pui.alpha > 0 or local_player.valid));
    end;
end;
widgets_manager.process.paint = function (_, v2219, v2220)
    -- upvalues: render_proxy (ref), string_utils (ref), colors (ref), pui (ref), current_font_set (ref), Vector (ref)
    local v2221 = entity.get_threat();
    render_proxy.side_h(v2219, v2220);
    local v2222 = string_utils.format("%s%s\aDEFAULT  Process", colors.hex, pui.get_icon("shield"));
    render_proxy.text(current_font_set.regular, Vector(v2219.x + 8, v2219.y + 5), colors.text, nil, v2222);
    render_proxy.text(current_font_set.regular, Vector(v2220.x - 8, v2219.y + 5), colors.text:alpha_modulate(0.5, true), "r", v2221 and string_utils.limit(v2221:get_name(), 7, true) or "~");
end;
widgets_manager.process.alt = function (v2223)
    -- upvalues: render_proxy (ref), current_font_set (ref), Vector (ref), screen_center (ref), colors (ref), build_info (ref), ui_groups_settings (ref), aa_states (ref), ui_tabs (ref), string_utils (ref), local_player (ref), menu_items (ref)
    v2223.alpha = v2223:update();
    render_proxy.push_alpha(v2223.alpha);
    local v2224 = 0;
    render_proxy.text(current_font_set.bold_d, Vector(32, screen_center.y + v2224), colors.text, nil, colors.hex .. "hysteria\aDEFAULT \226\128\148 anti-aim panel");
    v2224 = v2224 + 14;
    render_proxy.text(current_font_set.regular_d, Vector(32, screen_center.y + v2224), colors.text:alpha_modulate(0.33, true), nil, build_info.build);
    v2224 = v2224 + 20;
    render_proxy.text(current_font_set.regular_d, Vector(32, screen_center.y + v2224), colors.text, nil, "aa");
    local v2225 = ui_groups_settings.data.state and aa_states.states[ui_groups_settings.data.state][1] or "unk";
    v2224 = v2224 + 14;
    render_proxy.text(current_font_set.regular_d, Vector(32, screen_center.y + v2224), colors.text, nil, "- current state: " .. v2225);
    if ui_tabs.antiaim.general.nature.value then
        local v2226 = ui_groups_settings.data.stateb and aa_states.states[ui_groups_settings.data.stateb][1] or "unk";
        v2224 = v2224 + 14;
        render_proxy.text(current_font_set.regular_d, Vector(32, screen_center.y + v2224), colors.text, nil, "- next state: " .. v2226);
        v2224 = v2224 + 14;
        render_proxy.text(current_font_set.regular_d, Vector(32, screen_center.y + v2224), colors.text, nil, string_utils.format("- naturality bias: %.2f", ui_groups_settings.data.statew or 0));
    end;
    if local_player.exploit.active then
        v2224 = v2224 + 20;
        render_proxy.text(current_font_set.regular_d, Vector(32, screen_center.y + v2224), colors.text, nil, "exp");
        v2224 = v2224 + 14;
        render_proxy.text(current_font_set.regular_d, Vector(32, screen_center.y + v2224), colors.text, nil, "- type: " .. (local_player.exploit.active == 1 and "dt" or "osaa"));
        v2224 = v2224 + 14;
        render_proxy.text(current_font_set.regular_d, Vector(32, screen_center.y + v2224), colors.text, nil, string_utils.format("- charge: %d%%", rage.exploit:get() * 100));
    end;
    local v2227 = (menu_items.rage.main.dt.lag:get_override() or menu_items.rage.main.dt.lag.value) == "Always On";
    local v2228 = (menu_items.rage.main.hs.options:get_override() or menu_items.rage.main.hs.options.value) == "Break LC";
    if v2227 or v2228 or v2223.timer or local_player.exploit.lc_left > 0 then
        v2224 = v2224 + 20;
        render_proxy.text(current_font_set.regular_d, Vector(32, screen_center.y + v2224), colors.text, nil, "lc");
        v2224 = v2224 + 14;
        render_proxy.text(current_font_set.regular_d, Vector(32, screen_center.y + v2224), colors.text, nil, "- active: " .. (local_player.exploit.defensive and "+" or "-"));
        v2224 = v2224 + 14;
        render_proxy.text(current_font_set.regular_d, Vector(32, screen_center.y + v2224), colors.text, nil, "- ticks left: " .. local_player.exploit.lc_left);
    end;
    render_proxy.pop_alpha();
end;
widgets_manager.process.nwater = function ()
    -- upvalues: render_proxy (ref), image_assets (ref), Vector (ref), screen_center (ref), screen_size (ref), colors (ref)
    render_proxy.texture(image_assets.bfly, Vector(screen_center.x - 3, screen_size.y - 16), Vector(9, 9), colors.accent);
end;
events.render:set(function ()
    -- upvalues: widgets_manager (ref), ui_tabs (ref), crosshair_widget (ref), render_proxy (ref)
    if widgets_manager.arrows.alpha > 0 or ui_tabs.settings.arrows.value then
        widgets_manager.arrows();
    end;
    if widgets_manager.damage.alpha > 0 or ui_tabs.settings.damage.value then
        widgets_manager.damage();
    end;
    if crosshair_widget.alpha > 0 or ui_tabs.settings.crosshair.value then
        crosshair_widget();
    end;
    if widgets_manager.logs.alpha > 0 or ui_tabs.settings.logs.value and ui_tabs.settings.logs.sc.value then
        widgets_manager.logs();
    end;
    if widgets_manager.speclist.alpha > 0 or ui_tabs.settings.speclist.value then
        widgets_manager.speclist();
    end;
    if widgets_manager.keylist.alpha > 0 or ui_tabs.settings.keylist.value then
        widgets_manager.keylist();
    end;
    if widgets_manager.process.alpha > 0 or ui_tabs.settings.process.value then
        if render_proxy.style == 1 then
            widgets_manager.process();
        else
            widgets_manager.process:alt();
        end;
    end;
    if widgets_manager.slowdown.alpha > 0 or ui_tabs.settings.slowdown.value then
        widgets_manager.slowdown();
    end;
    if widgets_manager.lchelper.alpha > 0 or ui_tabs.settings.lchelper.value then
        widgets_manager.lchelper();
    end;
    if widgets_manager.watermark.alpha > 0 or ui_tabs.settings.watermark.value then
        widgets_manager.watermark();
    end;
    if widgets_manager.watermark.alpha == 0 and crosshair_widget.alpha == 0 then
        widgets_manager.process.nwater();
    end;
end);
widget_instance = {
    combo = function (v2229)
        return v2229.value ~= "Off" and v2229.value ~= "Disabled" and v2229.value ~= "None";
    end,
    selectable = function (v2230)
        return #v2230.value > 0;
    end,
    slider = function (v2231)
        return v2231.value ~= 0;
    end
};
do
    local l_v953_3, l_v1956_0 = widget_instance, v1956;
    l_v1956_0 = function (v2234)
        -- upvalues: type (ref), ui_helpers (ref), l_v953_3 (ref), next (ref), l_v1956_0 (ref)
        if type(v2234) ~= "table" or v2234.__name ~= "pui::element" then
            return;
        else
            local v2235 = v2234:type();
            if v2234:type() == "color_picker" or v2234:type() == "label" and v2234[0].gear == nil then
                return;
            else
                ui_helpers.anim(v2234, l_v953_3[v2235]);
                if v2234[0].gear then
                    for _, v2237 in next, v2234[1] do
                        l_v1956_0(v2237);
                    end;
                end;
                return;
            end;
        end;
    end;
    pui.traverse(ui_tabs, l_v1956_0);
    ui_settings.system = pui.setup(ui_tabs, true);
end;
timestamps[#timestamps + 1] = common.get_timestamp();
debug_log("load time: ", timestamps[#timestamps] - timestamps[1]);