const std = @import("std");

pub fn printGithubId(title: []const u8, w: anytype) !void {
    const allowed_chars = "abcdefghijklmnopqrstuvwxyz0123456789- ";
    // since we need to strip leading and trailing hyphens, we cannot do it
    // on-the-fly
    var buffer: [256]u8 = undefined;
    const lower = std.ascii.lowerString(&buffer, title);
    for (lower, 0..) |c, i| {
        if (std.mem.indexOfScalar(u8, allowed_chars, c)) |_| {
            if (c == ' ') {
                buffer[i] = '-';
            } else {
                buffer[i] = c;
            }
        } else {
            buffer[i] = '-';
        }
    }
    const github_id = std.mem.trim(u8, lower, "-");
    try w.print("{s}", .{github_id});
}
