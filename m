Return-Path: <linux-wireless+bounces-11582-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CBB3955769
	for <lists+linux-wireless@lfdr.de>; Sat, 17 Aug 2024 13:29:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44676282394
	for <lists+linux-wireless@lfdr.de>; Sat, 17 Aug 2024 11:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 625B3146019;
	Sat, 17 Aug 2024 11:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UIFw7frP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E980148855
	for <linux-wireless@vger.kernel.org>; Sat, 17 Aug 2024 11:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723894179; cv=none; b=JJitd5JpV74iaX4T6J77BRd5AiASxzmm0H8dv2Yw0JM1DcTZs7xdGd4t0PEk8cnJ7bZ3TekQA+IH+xOWbD9JX2qXlaYSJubvqda6AEvs8ric9tPEf9jEX905MIy0Cw/fcdYvxB+EF1VOZcZWFrLymMDhVfsIsElo6imZ7IB3zYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723894179; c=relaxed/simple;
	bh=u010KjlnQYLezDAMBhDpm+eDuKXcqhs7+k4mWLMGN2U=;
	h=Date:From:To:Cc:Subject:Message-ID; b=os34XyRAoCEHQpb+0XOQm0SnHfq5B9qso4mMejQVogsdz2QIWAnXYs8snfYA66pdIBCQWoHI4SpAvmXqrXrHxS9qwK8lPmkT5De62RS8x9ac+FARMrp4q/Y+9FdvgunAyNFUHYUW4aiT/s+fforZgPo61BpUM/AJaSvZ0jU7lQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UIFw7frP; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723894176; x=1755430176;
  h=date:from:to:cc:subject:message-id;
  bh=u010KjlnQYLezDAMBhDpm+eDuKXcqhs7+k4mWLMGN2U=;
  b=UIFw7frPWdULf4B9mVEi3nFF14pW7WL+i4YKUsmPYushXAPanYcYK7Eo
   2HoA3d10feyZCHnSVeEpHvT++mbHN30goZ2TP8OzKXHgJZ/rj+pAZrzto
   cPtQwhsdaEWrN9MJXPI1q/uHdh1aP/1KbU68V9WAV/mPEWFdk3x92QZTN
   GwAymeJQCFMP9cc6qeXSBMHV+rmCib3bpEuAeo/zw0TNL9xXFHIDuOkZN
   b6ybtCnJVW6addN7MvtpZP0qSAO/Ke8a8obvONWfiWzkRQzYoNROFQz7Y
   QiuOZVY00VkVdREjU0VT85Ql8yykctvaEFMVYJ9JzAPUKAvLxFEeZE8yn
   A==;
X-CSE-ConnectionGUID: 7Ok1gqlDTue3N+zTT0musQ==
X-CSE-MsgGUID: ogI0t78gRCK/eUYLRNSHTw==
X-IronPort-AV: E=McAfee;i="6700,10204,11166"; a="33328883"
X-IronPort-AV: E=Sophos;i="6.10,154,1719903600"; 
   d="scan'208";a="33328883"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2024 04:29:36 -0700
X-CSE-ConnectionGUID: IzlQ/NpLROmN3MiVpQIakA==
X-CSE-MsgGUID: QEWjgv/lRByHGORoR1JZEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,154,1719903600"; 
   d="scan'208";a="59763155"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 17 Aug 2024 04:29:34 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sfHch-0007Oc-39;
	Sat, 17 Aug 2024 11:29:31 +0000
Date: Sat, 17 Aug 2024 19:28:55 +0800
From: kernel test robot <lkp@intel.com>
To: Kalle Valo <kvalo@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>,
 linux-wireless@vger.kernel.org
Subject: [wireless-next:main] BUILD SUCCESS
 daaf0dd0398d5e93b7304f35184ca182ed583681
Message-ID: <202408171952.w1ERyq4U-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: daaf0dd0398d5e93b7304f35184ca182ed583681  wifi: mwifiex: keep mwifiex_cfg80211_ops constant

elapsed time: 1447m

configs tested: 283
configs skipped: 9

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
alpha                             allnoconfig   gcc-13.3.0
alpha                            allyesconfig   gcc-13.3.0
alpha                               defconfig   gcc-13.2.0
alpha                               defconfig   gcc-13.3.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                          axs103_defconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                            hsdk_defconfig   gcc-13.2.0
arc                   randconfig-001-20240817   gcc-13.2.0
arc                   randconfig-002-20240817   gcc-13.2.0
arc                        vdk_hs38_defconfig   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                              allmodconfig   gcc-14.1.0
arm                               allnoconfig   clang-20
arm                               allnoconfig   gcc-13.2.0
arm                              allyesconfig   gcc-13.2.0
arm                              allyesconfig   gcc-14.1.0
arm                        clps711x_defconfig   gcc-13.2.0
arm                                 defconfig   clang-14
arm                          ep93xx_defconfig   clang-14
arm                         lpc32xx_defconfig   gcc-13.2.0
arm                        multi_v5_defconfig   gcc-13.2.0
arm                        multi_v5_defconfig   gcc-14.1.0
arm                       omap2plus_defconfig   gcc-14.1.0
arm                          pxa3xx_defconfig   clang-20
arm                   randconfig-001-20240817   gcc-13.2.0
arm                   randconfig-001-20240817   gcc-14.1.0
arm                   randconfig-002-20240817   clang-20
arm                   randconfig-002-20240817   gcc-13.2.0
arm                   randconfig-003-20240817   clang-20
arm                   randconfig-003-20240817   gcc-13.2.0
arm                   randconfig-004-20240817   gcc-13.2.0
arm                   randconfig-004-20240817   gcc-14.1.0
arm                         s3c6400_defconfig   gcc-13.2.0
arm                       spear13xx_defconfig   gcc-13.2.0
arm                           spitz_defconfig   gcc-14.1.0
arm64                            allmodconfig   clang-20
arm64                            allmodconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-14.1.0
arm64                               defconfig   gcc-13.2.0
arm64                               defconfig   gcc-14.1.0
arm64                 randconfig-001-20240817   clang-20
arm64                 randconfig-001-20240817   gcc-13.2.0
arm64                 randconfig-002-20240817   gcc-13.2.0
arm64                 randconfig-002-20240817   gcc-14.1.0
arm64                 randconfig-003-20240817   gcc-13.2.0
arm64                 randconfig-003-20240817   gcc-14.1.0
arm64                 randconfig-004-20240817   gcc-13.2.0
arm64                 randconfig-004-20240817   gcc-14.1.0
csky                              allnoconfig   gcc-13.2.0
csky                              allnoconfig   gcc-14.1.0
csky                                defconfig   gcc-13.2.0
csky                                defconfig   gcc-14.1.0
csky                  randconfig-001-20240817   gcc-13.2.0
csky                  randconfig-001-20240817   gcc-14.1.0
csky                  randconfig-002-20240817   gcc-13.2.0
csky                  randconfig-002-20240817   gcc-14.1.0
hexagon                          allmodconfig   clang-20
hexagon                           allnoconfig   clang-20
hexagon                          allyesconfig   clang-20
hexagon                             defconfig   clang-20
hexagon               randconfig-001-20240817   clang-20
hexagon               randconfig-002-20240817   clang-20
i386                             allmodconfig   clang-18
i386                             allmodconfig   gcc-12
i386                              allnoconfig   clang-18
i386                              allnoconfig   gcc-12
i386                             allyesconfig   clang-18
i386                             allyesconfig   gcc-12
i386         buildonly-randconfig-001-20240816   gcc-12
i386         buildonly-randconfig-001-20240817   gcc-12
i386         buildonly-randconfig-002-20240816   clang-18
i386         buildonly-randconfig-002-20240817   gcc-12
i386         buildonly-randconfig-003-20240816   clang-18
i386         buildonly-randconfig-003-20240817   gcc-12
i386         buildonly-randconfig-004-20240816   clang-18
i386         buildonly-randconfig-004-20240817   gcc-12
i386         buildonly-randconfig-005-20240816   gcc-11
i386         buildonly-randconfig-005-20240817   gcc-12
i386         buildonly-randconfig-006-20240816   gcc-12
i386         buildonly-randconfig-006-20240817   gcc-12
i386                                defconfig   clang-18
i386                  randconfig-001-20240816   clang-18
i386                  randconfig-001-20240817   gcc-12
i386                  randconfig-002-20240816   gcc-12
i386                  randconfig-002-20240817   gcc-12
i386                  randconfig-003-20240816   gcc-11
i386                  randconfig-003-20240817   gcc-12
i386                  randconfig-004-20240816   gcc-12
i386                  randconfig-004-20240817   gcc-12
i386                  randconfig-005-20240816   clang-18
i386                  randconfig-005-20240817   gcc-12
i386                  randconfig-006-20240816   gcc-11
i386                  randconfig-006-20240817   gcc-12
i386                  randconfig-011-20240816   gcc-12
i386                  randconfig-011-20240817   gcc-12
i386                  randconfig-012-20240816   clang-18
i386                  randconfig-012-20240817   gcc-12
i386                  randconfig-013-20240816   clang-18
i386                  randconfig-013-20240817   gcc-12
i386                  randconfig-014-20240816   gcc-12
i386                  randconfig-014-20240817   gcc-12
i386                  randconfig-015-20240816   gcc-12
i386                  randconfig-015-20240817   gcc-12
i386                  randconfig-016-20240816   gcc-12
i386                  randconfig-016-20240817   gcc-12
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch                           defconfig   gcc-13.2.0
loongarch                           defconfig   gcc-14.1.0
loongarch             randconfig-001-20240817   gcc-13.2.0
loongarch             randconfig-001-20240817   gcc-14.1.0
loongarch             randconfig-002-20240817   gcc-13.2.0
loongarch             randconfig-002-20240817   gcc-14.1.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-13.2.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
m68k                          amiga_defconfig   gcc-14.1.0
m68k                                defconfig   gcc-13.2.0
m68k                                defconfig   gcc-14.1.0
m68k                        mvme147_defconfig   gcc-13.2.0
m68k                           sun3_defconfig   gcc-14.1.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-13.2.0
microblaze                          defconfig   gcc-14.1.0
mips                              allnoconfig   gcc-13.2.0
mips                              allnoconfig   gcc-14.1.0
mips                  cavium_octeon_defconfig   gcc-13.2.0
mips                          eyeq5_defconfig   gcc-13.2.0
mips                           ip28_defconfig   gcc-13.2.0
mips                           jazz_defconfig   gcc-13.2.0
mips                           rs90_defconfig   gcc-13.2.0
mips                   sb1250_swarm_defconfig   gcc-14.1.0
nios2                             allnoconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-14.1.0
nios2                               defconfig   gcc-13.2.0
nios2                               defconfig   gcc-14.1.0
nios2                 randconfig-001-20240817   gcc-13.2.0
nios2                 randconfig-001-20240817   gcc-14.1.0
nios2                 randconfig-002-20240817   gcc-13.2.0
nios2                 randconfig-002-20240817   gcc-14.1.0
openrisc                         alldefconfig   gcc-14.1.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc                randconfig-001-20240817   gcc-13.2.0
parisc                randconfig-001-20240817   gcc-14.1.0
parisc                randconfig-002-20240817   gcc-13.2.0
parisc                randconfig-002-20240817   gcc-14.1.0
parisc64                            defconfig   gcc-13.2.0
parisc64                            defconfig   gcc-14.1.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   clang-20
powerpc                          allyesconfig   gcc-14.1.0
powerpc                       maple_defconfig   clang-20
powerpc                     mpc512x_defconfig   gcc-13.2.0
powerpc               randconfig-001-20240817   clang-14
powerpc               randconfig-001-20240817   gcc-13.2.0
powerpc               randconfig-002-20240817   gcc-13.2.0
powerpc               randconfig-002-20240817   gcc-14.1.0
powerpc                     skiroot_defconfig   gcc-13.2.0
powerpc64             randconfig-001-20240817   gcc-13.2.0
powerpc64             randconfig-001-20240817   gcc-14.1.0
powerpc64             randconfig-002-20240817   clang-16
powerpc64             randconfig-002-20240817   gcc-13.2.0
powerpc64             randconfig-003-20240817   clang-20
powerpc64             randconfig-003-20240817   gcc-13.2.0
riscv                            allmodconfig   clang-20
riscv                            allmodconfig   gcc-14.1.0
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   clang-20
riscv                            allyesconfig   gcc-14.1.0
riscv                               defconfig   clang-20
riscv                               defconfig   gcc-14.1.0
riscv                 randconfig-001-20240817   gcc-13.2.0
riscv                 randconfig-001-20240817   gcc-14.1.0
riscv                 randconfig-002-20240817   clang-17
riscv                 randconfig-002-20240817   gcc-13.2.0
s390                             allmodconfig   clang-20
s390                              allnoconfig   clang-20
s390                             allyesconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   clang-20
s390                                defconfig   gcc-14.1.0
s390                  randconfig-001-20240817   gcc-13.2.0
s390                  randconfig-001-20240817   gcc-14.1.0
s390                  randconfig-002-20240817   clang-20
s390                  randconfig-002-20240817   gcc-13.2.0
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-13.2.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                         ap325rxa_defconfig   gcc-14.1.0
sh                                  defconfig   gcc-14.1.0
sh                    randconfig-001-20240817   gcc-13.2.0
sh                    randconfig-001-20240817   gcc-14.1.0
sh                    randconfig-002-20240817   gcc-13.2.0
sh                    randconfig-002-20240817   gcc-14.1.0
sh                           se7343_defconfig   gcc-14.1.0
sh                           se7751_defconfig   gcc-14.1.0
sh                             sh03_defconfig   gcc-13.2.0
sh                           sh2007_defconfig   gcc-13.2.0
sh                     sh7710voipgw_defconfig   gcc-14.1.0
sh                  sh7785lcr_32bit_defconfig   gcc-14.1.0
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-14.1.0
sparc64               randconfig-001-20240817   gcc-13.2.0
sparc64               randconfig-001-20240817   gcc-14.1.0
sparc64               randconfig-002-20240817   gcc-13.2.0
sparc64               randconfig-002-20240817   gcc-14.1.0
um                               allmodconfig   clang-20
um                               allmodconfig   gcc-13.3.0
um                                allnoconfig   clang-17
um                               allyesconfig   gcc-12
um                               allyesconfig   gcc-13.3.0
um                                  defconfig   clang-20
um                                  defconfig   gcc-14.1.0
um                             i386_defconfig   gcc-12
um                             i386_defconfig   gcc-14.1.0
um                    randconfig-001-20240817   gcc-12
um                    randconfig-001-20240817   gcc-13.2.0
um                    randconfig-002-20240817   gcc-12
um                    randconfig-002-20240817   gcc-13.2.0
um                           x86_64_defconfig   clang-15
um                           x86_64_defconfig   gcc-14.1.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240817   gcc-12
x86_64       buildonly-randconfig-002-20240817   gcc-12
x86_64       buildonly-randconfig-003-20240817   gcc-11
x86_64       buildonly-randconfig-003-20240817   gcc-12
x86_64       buildonly-randconfig-004-20240817   gcc-12
x86_64       buildonly-randconfig-005-20240817   gcc-12
x86_64       buildonly-randconfig-006-20240817   clang-18
x86_64                              defconfig   clang-18
x86_64                              defconfig   gcc-11
x86_64                randconfig-001-20240817   clang-18
x86_64                randconfig-001-20240817   gcc-12
x86_64                randconfig-002-20240817   clang-18
x86_64                randconfig-002-20240817   gcc-12
x86_64                randconfig-003-20240817   gcc-12
x86_64                randconfig-004-20240817   gcc-12
x86_64                randconfig-005-20240817   clang-18
x86_64                randconfig-005-20240817   gcc-12
x86_64                randconfig-006-20240817   clang-18
x86_64                randconfig-006-20240817   gcc-12
x86_64                randconfig-011-20240817   clang-18
x86_64                randconfig-011-20240817   gcc-12
x86_64                randconfig-012-20240817   clang-18
x86_64                randconfig-012-20240817   gcc-12
x86_64                randconfig-013-20240817   gcc-12
x86_64                randconfig-014-20240817   gcc-12
x86_64                randconfig-015-20240817   gcc-12
x86_64                randconfig-016-20240817   gcc-12
x86_64                randconfig-071-20240817   gcc-12
x86_64                randconfig-072-20240817   gcc-12
x86_64                randconfig-073-20240817   clang-18
x86_64                randconfig-073-20240817   gcc-12
x86_64                randconfig-074-20240817   gcc-12
x86_64                randconfig-075-20240817   gcc-12
x86_64                randconfig-076-20240817   gcc-12
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                            allnoconfig   gcc-14.1.0
xtensa                       common_defconfig   gcc-14.1.0
xtensa                randconfig-001-20240817   gcc-13.2.0
xtensa                randconfig-001-20240817   gcc-14.1.0
xtensa                randconfig-002-20240817   gcc-13.2.0
xtensa                randconfig-002-20240817   gcc-14.1.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

