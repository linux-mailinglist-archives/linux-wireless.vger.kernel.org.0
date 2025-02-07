Return-Path: <linux-wireless+bounces-18649-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB1B3A2D02D
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Feb 2025 22:56:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBCA316AC25
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Feb 2025 21:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BF821B3953;
	Fri,  7 Feb 2025 21:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dcjDqgnR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149381B4235
	for <linux-wireless@vger.kernel.org>; Fri,  7 Feb 2025 21:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738965380; cv=none; b=s82db8Bw1VNzHDrmVapf7396F+AKwNaoxhH0BI8rybzux1Alx/1D2KtKo1GlNzXPqOZBA5AOWW86exMO1FJwuf0w2rtHtGgFqd46xVyNhSUvW6oLJ6mN3pN0UOZiE/Z7ND4af7NLdHyXr6cr8nwQ98bqPF7x3O3osjlEAs2o1PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738965380; c=relaxed/simple;
	bh=MdFWXHrM9A+3XbRJYKmI55YIcqgvRZMR/KQyXZje0lc=;
	h=Date:From:To:Cc:Subject:Message-ID; b=icbiOLoF5542H/JMqjEnbygRvxJRMNun92KYa+VUn2hvbObxIE9Vy3nRE6p9GSKkkCtGxkE0t0r531p3Wibjwd4Ci14Xzqe+ugrch5A92abueTlPWm1dq8y3lUaPG7jYPOPAiQW0h1wncy0GiqX5nKFVqsh2rjRNynY7ZA4rpII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dcjDqgnR; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738965378; x=1770501378;
  h=date:from:to:cc:subject:message-id;
  bh=MdFWXHrM9A+3XbRJYKmI55YIcqgvRZMR/KQyXZje0lc=;
  b=dcjDqgnRQa4MoLLvQrQFUEUtYA8sI2/ndupQaAGQLEiHDmMOEk75SSmd
   JK/6Y4XwUzyjxMZid/1mi4L4q0GlMBjhNlUINKuSEitfKLExuJXJUxpxQ
   k87Q5MatW6lugMf148O43lbiMG+08T/ecnuBKiPfyXR+c2Q4Gn24PO+/y
   ELprW/fHLn4HI9+CpNLT6kyiU4EciCWhXjpywAKxHfYHcOS2vQKvYb2ZU
   qJp+nWul9TMX9td0zg75k19IWteS+15i9RHAjqBFEqyK/B7BgsPCsECwH
   dz661tsPE3gkR6nhQljmVVBFnwze0mbm4PUySZgbgfzBGqfykZL93z6+G
   w==;
X-CSE-ConnectionGUID: L2Gi3Pt+Qa+GlHHPAsxNFQ==
X-CSE-MsgGUID: Z/KsOsedRHu7gAaZluvvKg==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="39733947"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="39733947"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 13:56:16 -0800
X-CSE-ConnectionGUID: wewZ0A8nTICqNdRmWDG8XA==
X-CSE-MsgGUID: N8tQUMu6QB+S+btyFNPNqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="112529189"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 07 Feb 2025 13:56:14 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tgWKZ-000z63-1g;
	Fri, 07 Feb 2025 21:56:11 +0000
Date: Sat, 08 Feb 2025 05:55:16 +0800
From: kernel test robot <lkp@intel.com>
To: Kalle Valo <kvalo@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>,
 linux-wireless@vger.kernel.org
Subject: [wireless:for-next] BUILD SUCCESS
 b76adb9758f8eaaf22b824d0bcdd694551ce0557
Message-ID: <202502080506.UgNWhTN6-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git for-next
branch HEAD: b76adb9758f8eaaf22b824d0bcdd694551ce0557  MAINTAINERS: wifi: remove Kalle

elapsed time: 1450m

configs tested: 256
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-21
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    clang-19
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    clang-18
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-18
arc                                 defconfig    gcc-14.2.0
arc                     haps_hs_smp_defconfig    clang-19
arc                   randconfig-001-20250207    gcc-13.2.0
arc                   randconfig-001-20250208    gcc-13.2.0
arc                   randconfig-002-20250207    gcc-13.2.0
arc                   randconfig-002-20250208    gcc-13.2.0
arm                              allmodconfig    clang-18
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-18
arm                         at91_dt_defconfig    clang-21
arm                                 defconfig    gcc-14.2.0
arm                         lpc32xx_defconfig    clang-21
arm                         lpc32xx_defconfig    gcc-14.2.0
arm                          pxa910_defconfig    gcc-14.2.0
arm                   randconfig-001-20250207    gcc-13.2.0
arm                   randconfig-001-20250207    gcc-14.2.0
arm                   randconfig-001-20250208    gcc-13.2.0
arm                   randconfig-002-20250207    gcc-13.2.0
arm                   randconfig-002-20250207    gcc-14.2.0
arm                   randconfig-002-20250208    gcc-13.2.0
arm                   randconfig-003-20250207    gcc-13.2.0
arm                   randconfig-003-20250207    gcc-14.2.0
arm                   randconfig-003-20250208    gcc-13.2.0
arm                   randconfig-004-20250207    clang-21
arm                   randconfig-004-20250207    gcc-13.2.0
arm                   randconfig-004-20250208    gcc-13.2.0
arm                         s3c6400_defconfig    clang-19
arm                         wpcm450_defconfig    clang-19
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20250207    gcc-13.2.0
arm64                 randconfig-001-20250207    gcc-14.2.0
arm64                 randconfig-001-20250208    gcc-13.2.0
arm64                 randconfig-002-20250207    gcc-13.2.0
arm64                 randconfig-002-20250207    gcc-14.2.0
arm64                 randconfig-002-20250208    gcc-13.2.0
arm64                 randconfig-003-20250207    clang-16
arm64                 randconfig-003-20250207    gcc-13.2.0
arm64                 randconfig-003-20250208    gcc-13.2.0
arm64                 randconfig-004-20250207    clang-21
arm64                 randconfig-004-20250207    gcc-13.2.0
arm64                 randconfig-004-20250208    gcc-13.2.0
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    clang-21
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20250207    gcc-14.2.0
csky                  randconfig-002-20250207    gcc-14.2.0
hexagon                          alldefconfig    clang-21
hexagon                          allmodconfig    clang-21
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-18
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    gcc-14.2.0
hexagon               randconfig-001-20250207    clang-21
hexagon               randconfig-001-20250207    gcc-14.2.0
hexagon               randconfig-002-20250207    clang-17
hexagon               randconfig-002-20250207    gcc-14.2.0
i386                             allmodconfig    clang-19
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-19
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-19
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250207    gcc-12
i386        buildonly-randconfig-001-20250208    gcc-11
i386        buildonly-randconfig-002-20250207    gcc-12
i386        buildonly-randconfig-002-20250208    gcc-11
i386        buildonly-randconfig-003-20250207    gcc-12
i386        buildonly-randconfig-003-20250208    gcc-11
i386        buildonly-randconfig-004-20250207    gcc-12
i386        buildonly-randconfig-004-20250208    gcc-11
i386        buildonly-randconfig-005-20250207    clang-19
i386        buildonly-randconfig-005-20250207    gcc-12
i386        buildonly-randconfig-005-20250208    gcc-11
i386        buildonly-randconfig-006-20250207    clang-19
i386        buildonly-randconfig-006-20250207    gcc-12
i386        buildonly-randconfig-006-20250208    gcc-11
i386                                defconfig    clang-19
i386                  randconfig-001-20250207    gcc-12
i386                  randconfig-002-20250207    gcc-12
i386                  randconfig-003-20250207    gcc-12
i386                  randconfig-004-20250207    gcc-12
i386                  randconfig-005-20250207    gcc-12
i386                  randconfig-006-20250207    gcc-12
i386                  randconfig-007-20250207    gcc-12
i386                  randconfig-011-20250207    gcc-12
i386                  randconfig-011-20250208    gcc-12
i386                  randconfig-012-20250207    gcc-12
i386                  randconfig-012-20250208    gcc-12
i386                  randconfig-013-20250207    gcc-12
i386                  randconfig-013-20250208    gcc-12
i386                  randconfig-014-20250207    gcc-12
i386                  randconfig-014-20250208    gcc-12
i386                  randconfig-015-20250207    gcc-12
i386                  randconfig-015-20250208    gcc-12
i386                  randconfig-016-20250207    gcc-12
i386                  randconfig-016-20250208    gcc-12
i386                  randconfig-017-20250207    gcc-12
i386                  randconfig-017-20250208    gcc-12
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20250207    gcc-14.2.0
loongarch             randconfig-002-20250207    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                           gcw0_defconfig    clang-19
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250207    gcc-14.2.0
nios2                 randconfig-002-20250207    gcc-14.2.0
openrisc                          allnoconfig    clang-21
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-21
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20250207    gcc-14.2.0
parisc                randconfig-002-20250207    gcc-14.2.0
parisc64                            defconfig    gcc-14.2.0
powerpc                     akebono_defconfig    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-21
powerpc                          allyesconfig    gcc-14.2.0
powerpc                 canyonlands_defconfig    clang-19
powerpc                          g5_defconfig    gcc-14.2.0
powerpc                     mpc83xx_defconfig    clang-21
powerpc                      ppc44x_defconfig    gcc-14.2.0
powerpc               randconfig-001-20250207    clang-21
powerpc               randconfig-001-20250207    gcc-14.2.0
powerpc               randconfig-002-20250207    clang-21
powerpc               randconfig-002-20250207    gcc-14.2.0
powerpc               randconfig-003-20250207    gcc-14.2.0
powerpc                     tqm5200_defconfig    clang-19
powerpc                     tqm8540_defconfig    gcc-14.2.0
powerpc64             randconfig-001-20250207    gcc-14.2.0
powerpc64             randconfig-002-20250207    clang-21
powerpc64             randconfig-002-20250207    gcc-14.2.0
powerpc64             randconfig-003-20250207    gcc-14.2.0
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    clang-21
riscv                            allyesconfig    gcc-14.2.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250207    gcc-14.2.0
riscv                 randconfig-002-20250207    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-14.2.0
s390                          debug_defconfig    gcc-14.2.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250207    gcc-14.2.0
s390                  randconfig-002-20250207    clang-21
s390                  randconfig-002-20250207    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                        edosk7760_defconfig    clang-21
sh                    randconfig-001-20250207    gcc-14.2.0
sh                    randconfig-002-20250207    gcc-14.2.0
sh                   sh7770_generic_defconfig    clang-21
sh                              ul2_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250207    gcc-14.2.0
sparc                 randconfig-002-20250207    gcc-14.2.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250207    gcc-14.2.0
sparc64               randconfig-002-20250207    gcc-14.2.0
um                               allmodconfig    clang-21
um                                allnoconfig    clang-21
um                               allyesconfig    clang-21
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250207    clang-21
um                    randconfig-001-20250207    gcc-14.2.0
um                    randconfig-002-20250207    gcc-12
um                    randconfig-002-20250207    gcc-14.2.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250207    gcc-12
x86_64      buildonly-randconfig-001-20250208    clang-19
x86_64      buildonly-randconfig-002-20250207    clang-19
x86_64      buildonly-randconfig-002-20250208    clang-19
x86_64      buildonly-randconfig-003-20250207    clang-19
x86_64      buildonly-randconfig-003-20250208    clang-19
x86_64      buildonly-randconfig-004-20250207    clang-19
x86_64      buildonly-randconfig-004-20250208    clang-19
x86_64      buildonly-randconfig-005-20250207    clang-19
x86_64      buildonly-randconfig-005-20250208    clang-19
x86_64      buildonly-randconfig-006-20250207    clang-19
x86_64      buildonly-randconfig-006-20250208    clang-19
x86_64                              defconfig    clang-19
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-19
x86_64                randconfig-001-20250207    clang-19
x86_64                randconfig-001-20250208    clang-19
x86_64                randconfig-002-20250207    clang-19
x86_64                randconfig-002-20250208    clang-19
x86_64                randconfig-003-20250207    clang-19
x86_64                randconfig-003-20250208    clang-19
x86_64                randconfig-004-20250207    clang-19
x86_64                randconfig-004-20250208    clang-19
x86_64                randconfig-005-20250207    clang-19
x86_64                randconfig-005-20250208    clang-19
x86_64                randconfig-006-20250207    clang-19
x86_64                randconfig-006-20250208    clang-19
x86_64                randconfig-007-20250207    clang-19
x86_64                randconfig-007-20250208    clang-19
x86_64                randconfig-008-20250207    clang-19
x86_64                randconfig-008-20250208    clang-19
x86_64                randconfig-071-20250207    gcc-12
x86_64                randconfig-071-20250208    gcc-12
x86_64                randconfig-072-20250207    gcc-12
x86_64                randconfig-072-20250208    gcc-12
x86_64                randconfig-073-20250207    gcc-12
x86_64                randconfig-073-20250208    gcc-12
x86_64                randconfig-074-20250207    gcc-12
x86_64                randconfig-074-20250208    gcc-12
x86_64                randconfig-075-20250207    gcc-12
x86_64                randconfig-075-20250208    gcc-12
x86_64                randconfig-076-20250207    gcc-12
x86_64                randconfig-076-20250208    gcc-12
x86_64                randconfig-077-20250207    gcc-12
x86_64                randconfig-077-20250208    gcc-12
x86_64                randconfig-078-20250207    gcc-12
x86_64                randconfig-078-20250208    gcc-12
x86_64                               rhel-9.4    clang-19
x86_64                           rhel-9.4-bpf    clang-19
x86_64                         rhel-9.4-kunit    clang-19
x86_64                           rhel-9.4-ltp    clang-19
x86_64                          rhel-9.4-rust    clang-19
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250207    gcc-14.2.0
xtensa                randconfig-002-20250207    gcc-14.2.0
xtensa                         virt_defconfig    clang-19
xtensa                    xip_kc705_defconfig    clang-21

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

