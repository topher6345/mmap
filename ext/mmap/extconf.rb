#!/usr/bin/env ruby
# frozen_string_literal: true

ARGV.collect! { |x| x.sub(/^--with-mmap-prefix=/, '--with-mmap-dir=') }

require 'mkmf'

dir_config('mmap')

%w[lstrip match insert casecmp].each do |func|
  $CFLAGS += " -DHAVE_RB_STR_#{func.upcase}" if ''.respond_to?(func)
end

have_func 'rb_fstring_new'

warn "\tIPC will not be available" if enable_config('ipc') && !(have_func('semctl') && have_func('shmctl'))

create_makefile 'mmap'
