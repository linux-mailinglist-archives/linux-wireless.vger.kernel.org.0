Return-Path: <linux-wireless+bounces-25535-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5996AB0738C
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Jul 2025 12:35:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85DEB1898D6A
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Jul 2025 10:35:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0144D23FC42;
	Wed, 16 Jul 2025 10:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XRi7B8uI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3886A233722
	for <linux-wireless@vger.kernel.org>; Wed, 16 Jul 2025 10:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752662107; cv=none; b=BQ6+K8J3rPk6190zNizTHlZQNkeh5nQEWQwMM1RjOZstsDcMZdM30IJaslx4/UpWcaiEfVsS73WkcYZU6i5sIAREL/Yv8HZo0o322AhuI2NpoPDq6P3pThQqcT+5bEY1EjJ5LFKu5DUtAa+L9P987b+N9g4zbRHVsbe136dOo3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752662107; c=relaxed/simple;
	bh=hXbldTlIWJ0SKoog0wsrGdtcCcawq9qCLIwjMQFvyfg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=K4s65f3rOESpZejGvCOa4N4EBLd0NN3Bpf+VwUIwPx/YLRghyAuNEvNzQqqCFaPIidf+GSMbzZHcj7E2NTltt/vks7rHPwy608DqjR8NS8LFxvb9DwTbfvIUvnIQ/Q/p15udDqvfrKStS0AzYw0w3r9HBdZwbw+y100zW2B1gfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XRi7B8uI; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752662107; x=1784198107;
  h=date:from:to:cc:subject:message-id;
  bh=hXbldTlIWJ0SKoog0wsrGdtcCcawq9qCLIwjMQFvyfg=;
  b=XRi7B8uIes/dAkjDfGMu7ANabo18w+tADiyuWoYntrP8jEymNfhCGv4z
   5p2hwSq/WgH+MdF/IZr5qyVmOg70l6alrrJWxAFGVMoiYmcjXPqVuxlIr
   53vBkQMOZHVWkD9STz3VUELXrwHrSd6ZljdJcAs7epwjAHfl7vT+BDJIw
   5pQw2wbQnBhty989RKrAWUXqrb2DI3COjb+fWth09IE7O2z+82lFKNsG+
   AnusjXEP9ufSAqWX9t0fq1FI1f162FcJrUxJGm9FfS65b8LogxTY6dzEH
   FLGIqQTfIOdoaYitowo3J1uPwnQbyxFwHbXOduFsqoHKNLDw3T98ilFvN
   Q==;
X-CSE-ConnectionGUID: 0DIyyG//Q1mtMjBbUZoiEA==
X-CSE-MsgGUID: kSVQ/vJ2TAGMGcTrHDHuNA==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="54757161"
X-IronPort-AV: E=Sophos;i="6.16,315,1744095600"; 
   d="scan'208";a="54757161"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2025 03:35:06 -0700
X-CSE-ConnectionGUID: 64AFVO1VQ1iMHlRHbqNiIA==
X-CSE-MsgGUID: +sO9F1TWSOSU5CdlGiuaCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,315,1744095600"; 
   d="scan'208";a="157958494"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 16 Jul 2025 03:35:04 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ubzTZ-000CF5-1b;
	Wed, 16 Jul 2025 10:35:01 +0000
Date: Wed, 16 Jul 2025 18:34:46 +0800
From: kernel test robot <lkp@intel.com>
To: Johannes Berg <johannes.berg@intel.com>
Cc: Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org
Subject: [wireless:for-next] BUILD SUCCESS
 bbc19fef578970158847a41d9b6b6b218034b8c2
Message-ID: <202507161833.w4YmA5Ku-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git for-next
branch HEAD: bbc19fef578970158847a41d9b6b6b218034b8c2  Merge tag 'iwlwifi-fixes-2025-07-15' of https://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next

elapsed time: 1328m

configs tested: 263
configs skipped: 8

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    clang-19
arc                              allmodconfig    clang-19
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-19
arc                              allyesconfig    gcc-15.1.0
arc                          axs103_defconfig    clang-21
arc                      axs103_smp_defconfig    clang-21
arc                                 defconfig    clang-19
arc                   randconfig-001-20250715    gcc-8.5.0
arc                   randconfig-001-20250716    clang-21
arc                   randconfig-001-20250716    gcc-13.4.0
arc                   randconfig-002-20250715    gcc-11.5.0
arc                   randconfig-002-20250716    clang-21
arc                   randconfig-002-20250716    gcc-8.5.0
arm                              allmodconfig    clang-19
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    clang-19
arm                              allyesconfig    gcc-15.1.0
arm                                 defconfig    clang-19
arm                   randconfig-001-20250715    clang-21
arm                   randconfig-001-20250716    clang-20
arm                   randconfig-001-20250716    clang-21
arm                   randconfig-002-20250715    gcc-10.5.0
arm                   randconfig-002-20250716    clang-21
arm                   randconfig-002-20250716    gcc-12.4.0
arm                   randconfig-003-20250715    clang-21
arm                   randconfig-003-20250716    clang-21
arm                   randconfig-003-20250716    gcc-8.5.0
arm                   randconfig-004-20250715    gcc-12.4.0
arm                   randconfig-004-20250716    clang-21
arm                   randconfig-004-20250716    gcc-8.5.0
arm                         s3c6400_defconfig    clang-21
arm64                            alldefconfig    clang-21
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    clang-19
arm64                 randconfig-001-20250715    clang-16
arm64                 randconfig-001-20250716    clang-21
arm64                 randconfig-001-20250716    gcc-9.5.0
arm64                 randconfig-002-20250715    gcc-12.3.0
arm64                 randconfig-002-20250716    clang-21
arm64                 randconfig-002-20250716    gcc-8.5.0
arm64                 randconfig-003-20250715    gcc-8.5.0
arm64                 randconfig-003-20250716    clang-21
arm64                 randconfig-003-20250716    gcc-8.5.0
arm64                 randconfig-004-20250715    clang-21
arm64                 randconfig-004-20250716    clang-21
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    clang-19
csky                  randconfig-001-20250715    gcc-9.3.0
csky                  randconfig-001-20250716    gcc-14.3.0
csky                  randconfig-001-20250716    gcc-15.1.0
csky                  randconfig-002-20250715    gcc-12.4.0
csky                  randconfig-002-20250716    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    clang-19
hexagon               randconfig-001-20250715    clang-18
hexagon               randconfig-001-20250716    clang-21
hexagon               randconfig-001-20250716    gcc-15.1.0
hexagon               randconfig-002-20250715    clang-21
hexagon               randconfig-002-20250716    clang-21
hexagon               randconfig-002-20250716    gcc-15.1.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250715    gcc-12
i386        buildonly-randconfig-001-20250716    gcc-12
i386        buildonly-randconfig-002-20250715    gcc-12
i386        buildonly-randconfig-002-20250716    clang-20
i386        buildonly-randconfig-002-20250716    gcc-12
i386        buildonly-randconfig-003-20250715    gcc-12
i386        buildonly-randconfig-003-20250716    gcc-12
i386        buildonly-randconfig-004-20250715    clang-20
i386        buildonly-randconfig-004-20250716    gcc-11
i386        buildonly-randconfig-004-20250716    gcc-12
i386        buildonly-randconfig-005-20250715    clang-20
i386        buildonly-randconfig-005-20250716    gcc-12
i386        buildonly-randconfig-006-20250715    clang-20
i386        buildonly-randconfig-006-20250716    clang-20
i386        buildonly-randconfig-006-20250716    gcc-12
i386                                defconfig    clang-20
i386                  randconfig-001-20250716    clang-20
i386                  randconfig-002-20250716    clang-20
i386                  randconfig-003-20250716    clang-20
i386                  randconfig-004-20250716    clang-20
i386                  randconfig-005-20250716    clang-20
i386                  randconfig-006-20250716    clang-20
i386                  randconfig-007-20250716    clang-20
i386                  randconfig-011-20250716    gcc-12
i386                  randconfig-012-20250716    gcc-12
i386                  randconfig-013-20250716    gcc-12
i386                  randconfig-014-20250716    gcc-12
i386                  randconfig-015-20250716    gcc-12
i386                  randconfig-016-20250716    gcc-12
i386                  randconfig-017-20250716    gcc-12
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-21
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20250715    clang-21
loongarch             randconfig-001-20250716    clang-18
loongarch             randconfig-001-20250716    gcc-15.1.0
loongarch             randconfig-002-20250715    gcc-15.1.0
loongarch             randconfig-002-20250716    clang-21
loongarch             randconfig-002-20250716    gcc-15.1.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    clang-19
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-14.2.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20250715    gcc-11.5.0
nios2                 randconfig-001-20250716    gcc-14.2.0
nios2                 randconfig-001-20250716    gcc-15.1.0
nios2                 randconfig-002-20250715    gcc-8.5.0
nios2                 randconfig-002-20250716    gcc-11.5.0
nios2                 randconfig-002-20250716    gcc-15.1.0
openrisc                          allnoconfig    clang-21
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-21
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250715    gcc-10.5.0
parisc                randconfig-001-20250716    gcc-15.1.0
parisc                randconfig-001-20250716    gcc-8.5.0
parisc                randconfig-002-20250715    gcc-9.3.0
parisc                randconfig-002-20250716    gcc-15.1.0
parisc                randconfig-002-20250716    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-21
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-21
powerpc                      cm5200_defconfig    clang-21
powerpc               randconfig-001-20250715    clang-21
powerpc               randconfig-001-20250716    gcc-15.1.0
powerpc               randconfig-001-20250716    gcc-8.5.0
powerpc               randconfig-002-20250715    clang-21
powerpc               randconfig-002-20250716    clang-21
powerpc               randconfig-002-20250716    gcc-15.1.0
powerpc               randconfig-003-20250715    gcc-8.5.0
powerpc               randconfig-003-20250716    gcc-14.3.0
powerpc               randconfig-003-20250716    gcc-15.1.0
powerpc64             randconfig-001-20250715    clang-21
powerpc64             randconfig-001-20250716    gcc-10.5.0
powerpc64             randconfig-001-20250716    gcc-15.1.0
powerpc64             randconfig-002-20250715    gcc-8.5.0
powerpc64             randconfig-003-20250715    clang-17
powerpc64             randconfig-003-20250716    gcc-13.4.0
powerpc64             randconfig-003-20250716    gcc-15.1.0
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    clang-21
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250716    gcc-8.5.0
riscv                 randconfig-001-20250716    gcc-9.3.0
riscv                 randconfig-002-20250716    gcc-11.5.0
riscv                 randconfig-002-20250716    gcc-9.3.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250716    gcc-11.5.0
s390                  randconfig-001-20250716    gcc-9.3.0
s390                  randconfig-002-20250716    gcc-11.5.0
s390                  randconfig-002-20250716    gcc-9.3.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-12
sh                          kfr2r09_defconfig    clang-21
sh                    randconfig-001-20250716    gcc-15.1.0
sh                    randconfig-001-20250716    gcc-9.3.0
sh                    randconfig-002-20250716    gcc-14.3.0
sh                    randconfig-002-20250716    gcc-9.3.0
sh                  sh7785lcr_32bit_defconfig    clang-21
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250716    gcc-8.5.0
sparc                 randconfig-001-20250716    gcc-9.3.0
sparc                 randconfig-002-20250716    gcc-14.3.0
sparc                 randconfig-002-20250716    gcc-9.3.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250716    clang-20
sparc64               randconfig-001-20250716    gcc-9.3.0
sparc64               randconfig-002-20250716    clang-21
sparc64               randconfig-002-20250716    gcc-9.3.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250716    gcc-11
um                    randconfig-001-20250716    gcc-9.3.0
um                    randconfig-002-20250716    gcc-12
um                    randconfig-002-20250716    gcc-9.3.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250715    clang-20
x86_64      buildonly-randconfig-001-20250716    clang-20
x86_64      buildonly-randconfig-001-20250716    gcc-12
x86_64      buildonly-randconfig-002-20250715    gcc-12
x86_64      buildonly-randconfig-002-20250716    clang-20
x86_64      buildonly-randconfig-003-20250715    gcc-12
x86_64      buildonly-randconfig-003-20250716    clang-20
x86_64      buildonly-randconfig-004-20250715    gcc-11
x86_64      buildonly-randconfig-004-20250716    clang-20
x86_64      buildonly-randconfig-005-20250715    gcc-12
x86_64      buildonly-randconfig-005-20250716    clang-20
x86_64      buildonly-randconfig-006-20250715    gcc-12
x86_64      buildonly-randconfig-006-20250716    clang-20
x86_64      buildonly-randconfig-006-20250716    gcc-12
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250716    clang-20
x86_64                randconfig-002-20250716    clang-20
x86_64                randconfig-003-20250716    clang-20
x86_64                randconfig-004-20250716    clang-20
x86_64                randconfig-005-20250716    clang-20
x86_64                randconfig-006-20250716    clang-20
x86_64                randconfig-007-20250716    clang-20
x86_64                randconfig-008-20250716    clang-20
x86_64                randconfig-071-20250716    gcc-12
x86_64                randconfig-072-20250716    gcc-12
x86_64                randconfig-073-20250716    gcc-12
x86_64                randconfig-074-20250716    gcc-12
x86_64                randconfig-075-20250716    gcc-12
x86_64                randconfig-076-20250716    gcc-12
x86_64                randconfig-077-20250716    gcc-12
x86_64                randconfig-078-20250716    gcc-12
x86_64                               rhel-9.4    clang-20
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250716    gcc-9.3.0
xtensa                randconfig-002-20250716    gcc-13.4.0
xtensa                randconfig-002-20250716    gcc-9.3.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

