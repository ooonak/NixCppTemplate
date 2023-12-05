#include "CppTempl/CppTempl.hpp"
#include "gtest/gtest.h"
#include "spdlog/sinks/stdout_color_sinks.h"
#include "spdlog/spdlog.h"

TEST(CppTempl, echo)
{
  auto console = spdlog::stdout_color_mt("console");
  CppTempl::CppTempl templ(console);
  EXPECT_EQ(templ.echo("test"), "test");
}
