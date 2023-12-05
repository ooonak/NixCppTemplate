#include "CppTempl/CppTempl.hpp"

#include "CppTemplImpl.hpp"

CppTempl::CppTempl::CppTempl(const std::shared_ptr<spdlog::logger> &logger)
    : impl_{std::make_unique<CppTemplImpl>(logger)}
{
}

CppTempl::CppTempl::~CppTempl() = default;

std::string CppTempl::CppTempl::echo(std::string msg) const { return impl_->echo(msg); }
