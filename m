Return-Path: <linux-wireless+bounces-19838-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31C96A54232
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 06:34:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BAF3168A3B
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 05:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E18D19CCEC;
	Thu,  6 Mar 2025 05:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OR/Li6Yz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C9C8172A
	for <linux-wireless@vger.kernel.org>; Thu,  6 Mar 2025 05:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741239280; cv=none; b=T+7nK6l1NdWQxT/Y4K8M6w/zF3JN89knCqz2fnliMmfAj4u0VcLeMvrsy60PoxgjcgYuOXwDBMffDYLQDj3CF4gdFIjtIE645R9DP8qHxTHjL7HQnb8jSeCz1gUnX6Tm++vDWip7NIjfRjDb6iatd3TBsGS/c13KGgO9q2FWzYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741239280; c=relaxed/simple;
	bh=aPL0zgI/iNO/pzgWN9FyzHq4d4X4Nflec72+CQs4bmo=;
	h=Date:From:To:Cc:Subject:Message-ID; b=W6KH02iCaRKXuU4sDUAjwh1GF8UVIEpXg3n41fxomuRIy2hOnwZgoW9HJbrJvOdHmNRmYidNQmxjvcDundrmUBonhnJDCiGEGhllLN1MtyhGx/PeExkcHDtdGcthmRngByN4gULAYRVozZxiYC5EmAE+Mc1giPYyN1oezvNAtnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OR/Li6Yz; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741239278; x=1772775278;
  h=date:from:to:cc:subject:message-id;
  bh=aPL0zgI/iNO/pzgWN9FyzHq4d4X4Nflec72+CQs4bmo=;
  b=OR/Li6YzdSn7BBqkPOtoFGwyD9XOifqVWZML/iCAtHDX2W3KOK4NyLe7
   Xw29JUlsT/4RxUoy6lGSlk6aB/CRVnDj9D8FR4loz4mSGWK4gu1i0gXTc
   znvb0Ud5HB/9r6C8l2mhnDe1sWD3fYqWfpTi40FevUn/Z50xCQ5+3z/2M
   MQAA6g4wVj5JKXC8TPS/HtKKGh0t6Zwora1rZxrC9KZ25CosVBU+jc29F
   BRCUf+pLHvn1XstY+Tc/qLtkGDMQSjGqNFyy27PJ1czZyfHEUA+kbsRLj
   czCQvZvjGGpjI/vZURne0wdiWnwVFCuiRO2IOCoZWECFLqfRkNsKzIZT1
   Q==;
X-CSE-ConnectionGUID: fFtP0SdvSHiSJH8tto9tsA==
X-CSE-MsgGUID: u6oIA4yKRTK4ISmykRtLcA==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="42367295"
X-IronPort-AV: E=Sophos;i="6.14,225,1736841600"; 
   d="scan'208";a="42367295"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 21:34:38 -0800
X-CSE-ConnectionGUID: 1fug4ZeJRMSYpEapFIy0Ug==
X-CSE-MsgGUID: srb+uEPSQ22DZoTq+3PL4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,225,1736841600"; 
   d="scan'208";a="118917830"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 05 Mar 2025 21:34:36 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tq3sQ-000MaQ-0R;
	Thu, 06 Mar 2025 05:34:34 +0000
Date: Thu, 06 Mar 2025 13:34:26 +0800
From: kernel test robot <lkp@intel.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>,
 Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org
Subject: [wireless-next:main] BUILD SUCCESS
 71f8992e34a9f358a53da6bfcd8b00226df177a2
Message-ID: <202503061320.37Wv13sX-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: 71f8992e34a9f358a53da6bfcd8b00226df177a2  Merge tag 'wireless-next-2025-03-04-v2' of https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next

elapsed time: 2155m

configs tested: 255
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-21
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    clang-18
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-18
arc                              allyesconfig    gcc-13.2.0
arc                      axs103_smp_defconfig    clang-21
arc                                 defconfig    gcc-14.2.0
arc                         haps_hs_defconfig    gcc-13.2.0
arc                   randconfig-001-20250305    gcc-13.2.0
arc                   randconfig-001-20250305    gcc-14.2.0
arc                   randconfig-002-20250305    gcc-13.2.0
arc                   randconfig-002-20250305    gcc-14.2.0
arm                              allmodconfig    clang-18
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-18
arm                              allyesconfig    gcc-14.2.0
arm                         bcm2835_defconfig    clang-17
arm                                 defconfig    gcc-14.2.0
arm                      footbridge_defconfig    gcc-13.2.0
arm                          ixp4xx_defconfig    clang-21
arm                        mvebu_v7_defconfig    clang-17
arm                       omap2plus_defconfig    gcc-14.2.0
arm                   randconfig-001-20250305    gcc-14.2.0
arm                   randconfig-002-20250305    clang-19
arm                   randconfig-002-20250305    gcc-14.2.0
arm                   randconfig-003-20250305    gcc-14.2.0
arm                   randconfig-004-20250305    gcc-14.2.0
arm                        spear3xx_defconfig    gcc-13.2.0
arm64                            alldefconfig    clang-21
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20250305    clang-15
arm64                 randconfig-001-20250305    gcc-14.2.0
arm64                 randconfig-002-20250305    gcc-14.2.0
arm64                 randconfig-003-20250305    clang-21
arm64                 randconfig-003-20250305    gcc-14.2.0
arm64                 randconfig-004-20250305    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20250305    gcc-14.2.0
csky                  randconfig-002-20250305    gcc-14.2.0
hexagon                          allmodconfig    clang-21
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-18
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    gcc-14.2.0
hexagon               randconfig-001-20250305    clang-21
hexagon               randconfig-001-20250305    gcc-14.2.0
hexagon               randconfig-002-20250305    clang-18
hexagon               randconfig-002-20250305    gcc-14.2.0
i386                             allmodconfig    clang-19
i386                              allnoconfig    clang-19
i386                             allyesconfig    clang-19
i386        buildonly-randconfig-001-20250305    clang-19
i386        buildonly-randconfig-002-20250305    clang-19
i386        buildonly-randconfig-003-20250305    clang-19
i386        buildonly-randconfig-004-20250305    clang-19
i386        buildonly-randconfig-005-20250305    clang-19
i386        buildonly-randconfig-006-20250305    clang-19
i386        buildonly-randconfig-006-20250305    gcc-12
i386                                defconfig    clang-19
i386                  randconfig-001-20250305    clang-19
i386                  randconfig-001-20250306    clang-19
i386                  randconfig-002-20250305    clang-19
i386                  randconfig-002-20250306    clang-19
i386                  randconfig-003-20250305    clang-19
i386                  randconfig-003-20250306    clang-19
i386                  randconfig-004-20250305    clang-19
i386                  randconfig-004-20250306    clang-19
i386                  randconfig-005-20250305    clang-19
i386                  randconfig-005-20250306    clang-19
i386                  randconfig-006-20250305    clang-19
i386                  randconfig-006-20250306    clang-19
i386                  randconfig-007-20250305    clang-19
i386                  randconfig-007-20250306    clang-19
i386                  randconfig-011-20250305    gcc-11
i386                  randconfig-011-20250306    gcc-12
i386                  randconfig-012-20250305    gcc-11
i386                  randconfig-012-20250306    gcc-12
i386                  randconfig-013-20250305    gcc-11
i386                  randconfig-013-20250306    gcc-12
i386                  randconfig-014-20250305    gcc-11
i386                  randconfig-014-20250306    gcc-12
i386                  randconfig-015-20250305    gcc-11
i386                  randconfig-015-20250306    gcc-12
i386                  randconfig-016-20250305    gcc-11
i386                  randconfig-016-20250306    gcc-12
i386                  randconfig-017-20250305    gcc-11
i386                  randconfig-017-20250306    gcc-12
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20250305    gcc-14.2.0
loongarch             randconfig-002-20250305    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                       bmips_be_defconfig    gcc-14.2.0
mips                      maltaaprp_defconfig    clang-21
mips                          rb532_defconfig    clang-17
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250305    gcc-14.2.0
nios2                 randconfig-002-20250305    gcc-14.2.0
openrisc                          allnoconfig    clang-15
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-12
parisc                           alldefconfig    gcc-13.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-15
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-12
parisc                generic-64bit_defconfig    clang-21
parisc                randconfig-001-20250305    gcc-14.2.0
parisc                randconfig-002-20250305    gcc-14.2.0
parisc64                            defconfig    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-15
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-16
powerpc                          allyesconfig    gcc-14.2.0
powerpc                    ge_imp3a_defconfig    clang-17
powerpc                    ge_imp3a_defconfig    clang-21
powerpc                 mpc834x_itx_defconfig    gcc-14.2.0
powerpc                  mpc866_ads_defconfig    gcc-14.2.0
powerpc                     powernv_defconfig    gcc-14.2.0
powerpc               randconfig-001-20250305    clang-17
powerpc               randconfig-001-20250305    gcc-14.2.0
powerpc               randconfig-002-20250305    gcc-14.2.0
powerpc               randconfig-003-20250305    gcc-14.2.0
powerpc                     tqm8540_defconfig    gcc-13.2.0
powerpc                     tqm8555_defconfig    clang-21
powerpc                 xes_mpc85xx_defconfig    gcc-13.2.0
powerpc64             randconfig-001-20250305    clang-19
powerpc64             randconfig-001-20250305    gcc-14.2.0
powerpc64             randconfig-002-20250305    clang-17
powerpc64             randconfig-002-20250305    gcc-14.2.0
powerpc64             randconfig-003-20250305    clang-19
powerpc64             randconfig-003-20250305    gcc-14.2.0
riscv                            allmodconfig    clang-21
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    clang-15
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-21
riscv                            allyesconfig    gcc-14.2.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250305    clang-19
riscv                 randconfig-001-20250305    gcc-14.2.0
riscv                 randconfig-002-20250305    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-15
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250305    gcc-14.2.0
s390                  randconfig-002-20250305    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                             espt_defconfig    clang-17
sh                          polaris_defconfig    gcc-14.2.0
sh                          r7780mp_defconfig    clang-17
sh                    randconfig-001-20250305    gcc-14.2.0
sh                    randconfig-002-20250305    gcc-14.2.0
sh                          rsk7264_defconfig    clang-17
sh                   sh7724_generic_defconfig    gcc-13.2.0
sh                             shx3_defconfig    gcc-14.2.0
sh                          urquell_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250305    gcc-14.2.0
sparc                 randconfig-002-20250305    gcc-14.2.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250305    gcc-14.2.0
sparc64               randconfig-002-20250305    gcc-14.2.0
um                               allmodconfig    clang-21
um                                allnoconfig    clang-15
um                                allnoconfig    clang-18
um                               allyesconfig    clang-21
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250305    clang-19
um                    randconfig-001-20250305    gcc-14.2.0
um                    randconfig-002-20250305    gcc-12
um                    randconfig-002-20250305    gcc-14.2.0
um                           x86_64_defconfig    clang-17
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250305    clang-19
x86_64      buildonly-randconfig-002-20250305    clang-19
x86_64      buildonly-randconfig-002-20250305    gcc-12
x86_64      buildonly-randconfig-003-20250305    clang-19
x86_64      buildonly-randconfig-004-20250305    clang-19
x86_64      buildonly-randconfig-004-20250305    gcc-12
x86_64      buildonly-randconfig-005-20250305    clang-19
x86_64      buildonly-randconfig-006-20250305    clang-19
x86_64                              defconfig    clang-19
x86_64                                  kexec    clang-19
x86_64                randconfig-001-20250305    gcc-12
x86_64                randconfig-001-20250306    clang-19
x86_64                randconfig-002-20250305    gcc-12
x86_64                randconfig-002-20250306    clang-19
x86_64                randconfig-003-20250305    gcc-12
x86_64                randconfig-003-20250306    clang-19
x86_64                randconfig-004-20250305    gcc-12
x86_64                randconfig-004-20250306    clang-19
x86_64                randconfig-005-20250305    gcc-12
x86_64                randconfig-005-20250306    clang-19
x86_64                randconfig-006-20250305    gcc-12
x86_64                randconfig-006-20250306    clang-19
x86_64                randconfig-007-20250305    gcc-12
x86_64                randconfig-007-20250306    clang-19
x86_64                randconfig-008-20250305    gcc-12
x86_64                randconfig-008-20250306    clang-19
x86_64                randconfig-071-20250305    clang-19
x86_64                randconfig-071-20250306    clang-19
x86_64                randconfig-072-20250305    clang-19
x86_64                randconfig-072-20250306    clang-19
x86_64                randconfig-073-20250305    clang-19
x86_64                randconfig-073-20250306    clang-19
x86_64                randconfig-074-20250305    clang-19
x86_64                randconfig-074-20250306    clang-19
x86_64                randconfig-075-20250305    clang-19
x86_64                randconfig-075-20250306    clang-19
x86_64                randconfig-076-20250305    clang-19
x86_64                randconfig-076-20250306    clang-19
x86_64                randconfig-077-20250305    clang-19
x86_64                randconfig-077-20250306    clang-19
x86_64                randconfig-078-20250305    clang-19
x86_64                randconfig-078-20250306    clang-19
x86_64                               rhel-9.4    clang-19
x86_64                           rhel-9.4-bpf    clang-18
x86_64                         rhel-9.4-kunit    clang-18
x86_64                           rhel-9.4-ltp    clang-18
x86_64                          rhel-9.4-rust    clang-18
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250305    gcc-14.2.0
xtensa                randconfig-002-20250305    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

