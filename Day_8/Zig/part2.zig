const std = @import("std");
const fs = std.fs;
const print = std.debug.print;

pub fn main() !void {
    var file = try fs.cwd().openFile("../input", .{});
    defer file.close();
    var buffer: [1024]u8 = undefined;
    var file_reader = file.reader(&buffer);
    const reader = &file_reader.interface;
    var str_len_sum: usize = 0;
    var str_len_extra_sum: usize = 0;
    while (reader.takeDelimiterExclusive('\n')) |line| {
        str_len_sum += line.len;
        var extra = line.len + 4;
        var i: usize = 1;
        var minus_sum: usize = 0;
        while (i < line.len) {
            const ch = line[i];
            const minus: usize = if (ch == '\\') blk: {
                const next = line[i + 1];
                if (next == 'x') {
                    i += 4;
                    extra += 1;
                    break :blk 3;
                } else {
                    i += 2;
                    extra += 2;
                    break :blk 1;
                } 
            } else blk: {
                i += 1;
                break :blk 0;
            }; 
            minus_sum += minus;
        }
        str_len_extra_sum += extra;
    } else |_| {}
    print("{d}", .{str_len_extra_sum - str_len_sum});
}


