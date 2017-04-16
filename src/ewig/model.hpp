//
// ewig - an immutable text editor
// Copyright (C) 2017 Juan Pedro Bolivar Puente
//
// This file is part of ewig.
//
// ewig is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// ewig is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with ewig.  If not, see <http://www.gnu.org/licenses/>.
//

#pragma once

#include <immer/box.hpp>
#include <immer/flex_vector.hpp>
#include <immer/vector.hpp>

#include <ctime>

namespace ewig {

using line = immer::flex_vector<wchar_t>;
using text = immer::flex_vector<line>;

using index = int;

struct coord
{
    index row;
    index col;
};

struct region
{
    text  content;
    coord first;
    coord last;
};

using string_t = immer::box<std::string>;

struct file_buffer
{
    text content;
    coord cursor;
    coord scroll;
    string_t file_name;
    bool dirty;
};

struct message
{
    std::time_t time_stamp;
    string_t content;
};

struct app_state
{
    file_buffer buffer;
    immer::vector<file_buffer> history;
    immer::vector<region> clipboard;
    immer::vector<message> messages;
};

constexpr auto tab_width = 8;

file_buffer load_file(const char* file_name);

app_state put_message(app_state state, string_t str);

coord actual_cursor(file_buffer buf);
coord actual_display_cursor(const file_buffer& buf);

file_buffer page_up(file_buffer buf, coord size);
file_buffer page_down(file_buffer buf, coord size);

file_buffer move_line_start(file_buffer buf);
file_buffer move_line_end(file_buffer buf);

file_buffer move_cursor_up(file_buffer buf);
file_buffer move_cursor_down(file_buffer buf);
file_buffer move_cursor_left(file_buffer buf);
file_buffer move_cursor_right(file_buffer buf);

file_buffer scroll_to_cursor(file_buffer buf, coord wsize);

file_buffer delete_char(file_buffer buf);
file_buffer delete_char_right(file_buffer buf);
file_buffer delete_rest(file_buffer buf);

file_buffer insert_new_line(file_buffer buf);
file_buffer insert_char(file_buffer buf, wchar_t value);

} // namespace ewig