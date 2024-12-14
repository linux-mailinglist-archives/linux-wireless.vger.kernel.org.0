Return-Path: <linux-wireless+bounces-16394-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B4289F1F2F
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Dec 2024 15:07:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5E1D1889B00
	for <lists+linux-wireless@lfdr.de>; Sat, 14 Dec 2024 14:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5236D1E517;
	Sat, 14 Dec 2024 14:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QS2/bYkF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF28D53C
	for <linux-wireless@vger.kernel.org>; Sat, 14 Dec 2024 14:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734185233; cv=none; b=OgwArwJ/Y7B9HnTReg6UrdVc/56YbazCNmuc4wOKeLe2c6FwRKjSiTPIZxNdJfCa235IB++D766AF6Vv1ZbIYMZhKcQPYiA5DzhlH3VYiHqyL0XIuXAsMp76jQbyJOYv/NPL8GvxG28XDxy/q7eIT0530YW+IRlWlWcdyMSsdA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734185233; c=relaxed/simple;
	bh=dcBk6Yi8o8lgZ5OjofQ/vMWRswDUF/KTXaR6od9BJSc=;
	h=Date:From:To:Cc:Subject:Message-ID; b=AS934hBSsgLl4HXqgq+3skDY0Pg7QImJJ9iUW2E1ziiXJwiM9d+rUm4bBpFsqOuDW0Du74FUAh5599g7ztzrzP+bRwyJYkNQiTzA9LZ/8iONsXByRK1K/Eo0FOHg/sHqe1jk7YVN0wb4GLyyQ2G6xofZDlcKUb/YQePf77hP10A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QS2/bYkF; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734185232; x=1765721232;
  h=date:from:to:cc:subject:message-id;
  bh=dcBk6Yi8o8lgZ5OjofQ/vMWRswDUF/KTXaR6od9BJSc=;
  b=QS2/bYkFSv+VgcM6s+PUTgKvO4yu9CgmHN0u+6FrRu4fNzk9g4i0ycpG
   P7cnJu0xMC6+HHmplFY7nlyXDr6RDGtQ3kUQVvgSKtNBq/U1GyNiIfyF5
   TUrgirh7rRSu3MOkb16bX1IWeNk/MHuRcy6WCWsDICZFwxHFi6YGC5ZY5
   I0jeCO9NaYNx/hY4k/5mksIm9McPu1XrgBNOAxzYpNiMvB0PqrJYThegT
   onnKt0DbvbUcraBllYV+cF0YByxYJ/LWaFR/64597MIBRgMYeRQ49AJRv
   xMr3PNkN0DUdaCohokNl8CMyxtWOouU+sQv7Uq7I7Nx2f9Z0nMxD6CcuW
   A==;
X-CSE-ConnectionGUID: coRkMzYARXi30r4AJlj/bw==
X-CSE-MsgGUID: mQ07jD8LRCGUWFBNe5VgIQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11286"; a="34859969"
X-IronPort-AV: E=Sophos;i="6.12,234,1728975600"; 
   d="scan'208";a="34859969"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2024 06:07:10 -0800
X-CSE-ConnectionGUID: ro/JITTITH2rGzeqgGP5+g==
X-CSE-MsgGUID: wvTR7ey5SeuFmlRlncpG+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="127789384"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 14 Dec 2024 06:07:10 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tMSnT-000Cy7-0F;
	Sat, 14 Dec 2024 14:07:07 +0000
Date: Sat, 14 Dec 2024 22:06:49 +0800
From: kernel test robot <lkp@intel.com>
To: Kalle Valo <kvalo@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>,
 linux-wireless@vger.kernel.org
Subject: [wireless:for-next] BUILD SUCCESS
 b83accfec0811421df065f820e73ca8df7f6439a
Message-ID: <202412142243.aZugFVFW-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git for-next
branch HEAD: b83accfec0811421df065f820e73ca8df7f6439a  MAINTAINERS: wifi: ath: add Jeff Johnson as maintainer

elapsed time: 1456m

configs tested: 77
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                           allyesconfig    gcc-14.2.0
arc                             allmodconfig    gcc-13.2.0
arc                             allyesconfig    gcc-13.2.0
arc                  randconfig-001-20241214    gcc-13.2.0
arc                  randconfig-002-20241214    gcc-13.2.0
arm                             allmodconfig    gcc-14.2.0
arm                             allyesconfig    gcc-14.2.0
arm                  randconfig-001-20241214    gcc-14.2.0
arm                  randconfig-002-20241214    clang-15
arm                  randconfig-003-20241214    gcc-14.2.0
arm                  randconfig-004-20241214    gcc-14.2.0
arm64                           allmodconfig    clang-18
arm64                randconfig-001-20241214    clang-15
arm64                randconfig-002-20241214    clang-20
arm64                randconfig-003-20241214    clang-15
arm64                randconfig-004-20241214    gcc-14.2.0
csky                 randconfig-001-20241214    gcc-14.2.0
csky                 randconfig-002-20241214    gcc-14.2.0
hexagon                         allmodconfig    clang-20
hexagon                         allyesconfig    clang-18
hexagon              randconfig-001-20241214    clang-20
hexagon              randconfig-002-20241214    clang-14
i386       buildonly-randconfig-001-20241213    clang-19
i386       buildonly-randconfig-002-20241213    gcc-12
i386       buildonly-randconfig-003-20241213    gcc-12
i386       buildonly-randconfig-004-20241213    clang-19
i386       buildonly-randconfig-005-20241213    gcc-12
i386       buildonly-randconfig-006-20241213    gcc-12
loongarch            randconfig-001-20241214    gcc-14.2.0
loongarch            randconfig-002-20241214    gcc-14.2.0
nios2                randconfig-001-20241214    gcc-14.2.0
nios2                randconfig-002-20241214    gcc-14.2.0
openrisc                         allnoconfig    gcc-14.2.0
openrisc                        allyesconfig    gcc-14.2.0
parisc                          allmodconfig    gcc-14.2.0
parisc                           allnoconfig    gcc-14.2.0
parisc                          allyesconfig    gcc-14.2.0
parisc               randconfig-001-20241214    gcc-14.2.0
parisc               randconfig-002-20241214    gcc-14.2.0
powerpc                         allmodconfig    gcc-14.2.0
powerpc                          allnoconfig    gcc-14.2.0
powerpc                         allyesconfig    clang-16
powerpc              randconfig-001-20241214    clang-20
powerpc              randconfig-002-20241214    clang-15
powerpc              randconfig-003-20241214    clang-20
powerpc64            randconfig-001-20241214    gcc-14.2.0
powerpc64            randconfig-002-20241214    gcc-14.2.0
powerpc64            randconfig-003-20241214    clang-20
riscv                            allnoconfig    gcc-14.2.0
riscv                randconfig-001-20241213    gcc-14.2.0
riscv                randconfig-002-20241213    gcc-14.2.0
s390                            allmodconfig    clang-19
s390                             allnoconfig    clang-20
s390                            allyesconfig    gcc-14.2.0
s390                 randconfig-001-20241213    gcc-14.2.0
s390                 randconfig-002-20241213    clang-19
sh                              allmodconfig    gcc-14.2.0
sh                              allyesconfig    gcc-14.2.0
sh                   randconfig-001-20241213    gcc-14.2.0
sh                   randconfig-002-20241213    gcc-14.2.0
sparc                           allmodconfig    gcc-14.2.0
sparc                randconfig-001-20241213    gcc-14.2.0
sparc                randconfig-002-20241213    gcc-14.2.0
sparc64              randconfig-001-20241213    gcc-14.2.0
sparc64              randconfig-002-20241213    gcc-14.2.0
um                              allmodconfig    clang-20
um                               allnoconfig    clang-18
um                   randconfig-001-20241213    gcc-12
um                   randconfig-002-20241213    clang-16
x86_64     buildonly-randconfig-001-20241214    gcc-11
x86_64     buildonly-randconfig-002-20241214    clang-19
x86_64     buildonly-randconfig-003-20241214    gcc-12
x86_64     buildonly-randconfig-004-20241214    gcc-12
x86_64     buildonly-randconfig-005-20241214    gcc-12
x86_64     buildonly-randconfig-006-20241214    clang-19
xtensa               randconfig-001-20241213    gcc-14.2.0
xtensa               randconfig-002-20241213    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

