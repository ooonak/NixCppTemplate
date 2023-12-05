#pragma once

#include <string>

#include "spdlog/spdlog.h"

namespace CppTempl
{

class CppTemplImpl
{
 public:
  explicit CppTemplImpl(const std::shared_ptr<spdlog::logger> &logger);

  ~CppTemplImpl();

  std::string echo(std::string msg) const;

 private:
  std::shared_ptr<spdlog::logger> logger_;
};

}  // namespace CppTempl
