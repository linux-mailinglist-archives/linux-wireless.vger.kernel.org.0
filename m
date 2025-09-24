Return-Path: <linux-wireless+bounces-27626-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA5FB97FE5
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Sep 2025 03:21:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2621D4E05A4
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Sep 2025 01:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D450A6F305;
	Wed, 24 Sep 2025 01:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fZ80Y1EQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16CCE8C11
	for <linux-wireless@vger.kernel.org>; Wed, 24 Sep 2025 01:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758676869; cv=none; b=qdgZG8Bnj5Ju8EXJlRHdo9hCeJuaFqHcM4bYiMGtcJE0JkQh97w1gN/rcQaj+mwF25IKN8oJ6PO6l+cHAM1345ReSj7ZQX6Vd+vxODBPJiDYhx//MRbLci/BjR/0nqmzkgaepJ3sbcQYSe8AhT+sZpoy9aqferktmkk979DmgJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758676869; c=relaxed/simple;
	bh=wIQigrZF5EReTl8/xHW+W4iRS6qZ71UNvJVptfG2214=;
	h=Date:From:To:Cc:Subject:Message-ID; b=pUwPjwSL017abS7cl1ds8rHzCSmIHrpeK/KAg4YvpR/CzFRbt8ZhNx3teU1Gc2rv7hdVevx7cGkPNpkeBmYPv0Oso9lVSn8Iu1dWclybE09xpWEt6Ed6RTsZJSY9Is/Gnu7sr1Sv6k9m5gX4RZI8VyXqGbwR6YAvxHfywrA7AVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fZ80Y1EQ; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758676868; x=1790212868;
  h=date:from:to:cc:subject:message-id;
  bh=wIQigrZF5EReTl8/xHW+W4iRS6qZ71UNvJVptfG2214=;
  b=fZ80Y1EQXcuZty45flNfX+Eu1CUUe8rJtV8ncb6U+ZWorp18hKxzqP3p
   Oy93vvfIWPI0Xy/c+qXGqo7u+gGi6nk2IvI/uu/tr4zA+JSwGgalKW3tw
   MNfqRXnDYBtDFIXnFPPo/+kXKder3YzovGo2aOyy8m/XeYr1z4+XPkB2o
   JpxbzaKCQmpyE4gYVdUhyGfwu+eDFrngxIVKt2JDlPUXi+M7DJ6rrZouG
   IzGUUUQVaI/e30R1h5fuKC6F6W2i7nomnhOYKvkA4tIDhmlf+HS+E9MET
   8TUxB8K571Ek9HJLnkFNj3vn3dxrQ0hIObYiJr8v7qAwZqgj08enV5vxY
   w==;
X-CSE-ConnectionGUID: 14Lrr3mHTsuXXtfMg4TgTg==
X-CSE-MsgGUID: WdWM/eStT42RvRsU3XoP6A==
X-IronPort-AV: E=McAfee;i="6800,10657,11561"; a="60856366"
X-IronPort-AV: E=Sophos;i="6.18,289,1751266800"; 
   d="scan'208";a="60856366"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2025 18:21:07 -0700
X-CSE-ConnectionGUID: iZMhbbYZRaKZg7g0AEbSZw==
X-CSE-MsgGUID: SQgaesR+QBekY8IjN5JVUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,289,1751266800"; 
   d="scan'208";a="207842532"
Received: from lkp-server02.sh.intel.com (HELO 84c55410ccf6) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 23 Sep 2025 18:21:06 -0700
Received: from kbuild by 84c55410ccf6 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1v1EBs-0003hH-0n;
	Wed, 24 Sep 2025 01:21:04 +0000
Date: Wed, 24 Sep 2025 09:20:42 +0800
From: kernel test robot <lkp@intel.com>
To: Johannes Berg <johannes.berg@intel.com>
Cc: Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org
Subject: [wireless-next:main] BUILD SUCCESS
 1e06a137513dff9835e57f76cff177cb1e2e5475
Message-ID: <202509240931.H96cpGV4-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: 1e06a137513dff9835e57f76cff177cb1e2e5475  wifi: libertas: WQ_PERCPU added to alloc_workqueue users

elapsed time: 1011m

configs tested: 136
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                          axs103_defconfig    gcc-15.1.0
arc                   randconfig-001-20250923    gcc-12.5.0
arc                   randconfig-002-20250923    gcc-12.5.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                            mmp2_defconfig    gcc-15.1.0
arm                            mps2_defconfig    clang-22
arm                         orion5x_defconfig    clang-22
arm                          pxa3xx_defconfig    clang-22
arm                   randconfig-001-20250923    gcc-12.5.0
arm                   randconfig-002-20250923    clang-17
arm                   randconfig-003-20250923    gcc-8.5.0
arm                   randconfig-004-20250923    clang-22
arm                             rpc_defconfig    clang-18
arm                           stm32_defconfig    gcc-15.1.0
arm                       versatile_defconfig    gcc-15.1.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250923    gcc-8.5.0
arm64                 randconfig-002-20250923    clang-18
arm64                 randconfig-003-20250923    gcc-8.5.0
arm64                 randconfig-004-20250923    gcc-11.5.0
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250923    gcc-9.5.0
csky                  randconfig-002-20250923    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20250923    clang-22
hexagon               randconfig-002-20250923    clang-22
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20250923    gcc-14
i386        buildonly-randconfig-002-20250923    clang-20
i386        buildonly-randconfig-003-20250923    clang-20
i386        buildonly-randconfig-004-20250923    gcc-14
i386        buildonly-randconfig-005-20250923    clang-20
i386        buildonly-randconfig-006-20250923    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20250923    gcc-15.1.0
loongarch             randconfig-002-20250923    gcc-15.1.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                          multi_defconfig    gcc-15.1.0
m68k                        mvme147_defconfig    gcc-15.1.0
microblaze                       alldefconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                  cavium_octeon_defconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20250923    gcc-11.5.0
nios2                 randconfig-002-20250923    gcc-11.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250923    gcc-15.1.0
parisc                randconfig-002-20250923    gcc-9.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc                     kmeter1_defconfig    gcc-15.1.0
powerpc               randconfig-001-20250923    gcc-8.5.0
powerpc               randconfig-002-20250923    clang-16
powerpc               randconfig-003-20250923    gcc-12.5.0
powerpc                      tqm8xx_defconfig    clang-19
powerpc64             randconfig-001-20250923    gcc-10.5.0
powerpc64             randconfig-002-20250923    clang-22
powerpc64             randconfig-003-20250923    gcc-8.5.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                 randconfig-001-20250923    gcc-12.5.0
riscv                 randconfig-002-20250923    clang-22
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-22
s390                  randconfig-001-20250923    gcc-8.5.0
s390                  randconfig-002-20250923    clang-22
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                          r7785rp_defconfig    gcc-15.1.0
sh                    randconfig-001-20250923    gcc-15.1.0
sh                    randconfig-002-20250923    gcc-10.5.0
sh                           se7705_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250923    gcc-8.5.0
sparc                 randconfig-002-20250923    gcc-12.5.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20250923    clang-22
sparc64               randconfig-002-20250923    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                    randconfig-001-20250923    clang-22
um                    randconfig-002-20250923    clang-22
um                           x86_64_defconfig    clang-22
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250923    gcc-14
x86_64      buildonly-randconfig-002-20250923    gcc-14
x86_64      buildonly-randconfig-003-20250923    gcc-14
x86_64      buildonly-randconfig-004-20250923    clang-20
x86_64      buildonly-randconfig-005-20250923    clang-20
x86_64      buildonly-randconfig-006-20250923    clang-20
x86_64                              defconfig    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250923    gcc-8.5.0
xtensa                randconfig-002-20250923    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

