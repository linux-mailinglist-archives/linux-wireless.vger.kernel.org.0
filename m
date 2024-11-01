Return-Path: <linux-wireless+bounces-14816-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D19169B93CD
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Nov 2024 15:55:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1215DB20EF6
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Nov 2024 14:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66DC11A7AF7;
	Fri,  1 Nov 2024 14:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T5Danryk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66AD1A2C06
	for <linux-wireless@vger.kernel.org>; Fri,  1 Nov 2024 14:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730472947; cv=none; b=Q81mgekAH7xq1ymzAKFGRRCbTfI12NF02B9+NwYqrfpqif6f3TNVJReuAGT9OYoFO1hnp+GmmQnnyExxCuKaVvEKFB0nL/VDYY2zLPydIGI9FgiHY6CdF4TGX2GS8q7+H3pXUcBM57GYjY7rBJh0C2pZCIk5Kt7bxpXMww+A0Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730472947; c=relaxed/simple;
	bh=8HCUWuqjSBQzIwI+1yfTrndk3qyG705v4k6C/V0LW78=;
	h=Date:From:To:Cc:Subject:Message-ID; b=hIxz3/3mfZ3d3kJGcXr6mTlgjKREWIVvNeAcwK3AuPeZe7qyWtdgPD1UrDQcbNmd1LN5hho0l+EXsoJmRhpPQuKcN3IEWJxzsCvmgs985mlgPFZluySQPo+lJwzL+kpirDITjpfRMSBQV9wZSlxb7HAslTSqcrDpl/nCB2StSjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T5Danryk; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730472945; x=1762008945;
  h=date:from:to:cc:subject:message-id;
  bh=8HCUWuqjSBQzIwI+1yfTrndk3qyG705v4k6C/V0LW78=;
  b=T5Danryk+U567h63h45ZVRzhadBEVdTBPut97j6beVrn14pXm3/+5xHA
   zpi5v3pzDyJ+Fyw6FKkNrOWOUnP13Q63P5gRUlLrP56E4kWKXQLlNGAYe
   rE1TSnePKXeGMGFqecdOXQu7Xp3s8pRz1+Nk5iG5F22hix9h1yH8a9ga7
   a3z+8yLVpNFt0ZRFrIF3yDPw70pzQvRlhKr7dIwtrc0ZRqvnFJvTexYPZ
   xrsn5ubpweVZEzSN0dIjtIpEoC0xiBqW5XyNdQwRc1yr3fShmnR1tQEcP
   pjxyOSF6ffy4g4u8KNbNOG0GWq9wHrNHggaHKqKFT+kFdzxKrHXmSEx9v
   g==;
X-CSE-ConnectionGUID: EbOZdu47S8eRPmr1ru2jbw==
X-CSE-MsgGUID: PkGCxAcjQKW7C4Uig3StGQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11243"; a="55638204"
X-IronPort-AV: E=Sophos;i="6.11,250,1725346800"; 
   d="scan'208";a="55638204"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2024 07:55:44 -0700
X-CSE-ConnectionGUID: 03n7uvM1SLOUbdYhXrgRxg==
X-CSE-MsgGUID: 8ef4uEHkQ8WaDZAGeODTUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,250,1725346800"; 
   d="scan'208";a="83320080"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 01 Nov 2024 07:55:43 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t6t3s-000het-2t;
	Fri, 01 Nov 2024 14:55:40 +0000
Date: Fri, 01 Nov 2024 22:54:55 +0800
From: kernel test robot <lkp@intel.com>
To: Kalle Valo <kvalo@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>,
 linux-wireless@vger.kernel.org
Subject: [wireless-next:main] BUILD SUCCESS
 2b94751626a6d49bbe42a19cc1503bd391016bd5
Message-ID: <202411012242.v4SBrbG7-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: 2b94751626a6d49bbe42a19cc1503bd391016bd5  wifi: cw1200: Fix potential NULL dereference

elapsed time: 1209m

configs tested: 130
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.1.0
alpha                            allyesconfig    clang-20
alpha                               defconfig    gcc-14.1.0
arc                              allmodconfig    clang-20
arc                               allnoconfig    gcc-14.1.0
arc                              allyesconfig    clang-20
arc                                 defconfig    gcc-14.1.0
arc                    vdk_hs38_smp_defconfig    gcc-14.1.0
arm                              allmodconfig    clang-20
arm                               allnoconfig    gcc-14.1.0
arm                              allyesconfig    clang-20
arm                         assabet_defconfig    clang-20
arm                                 defconfig    gcc-14.1.0
arm                          ep93xx_defconfig    clang-20
arm                          exynos_defconfig    clang-20
arm                            hisi_defconfig    clang-20
arm                        keystone_defconfig    clang-20
arm                           omap1_defconfig    gcc-14.1.0
arm                         s5pv210_defconfig    clang-20
arm                        vexpress_defconfig    clang-20
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.1.0
arm64                               defconfig    gcc-14.1.0
csky                              allnoconfig    gcc-14.1.0
csky                                defconfig    gcc-14.1.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.1.0
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    gcc-14.1.0
i386                             allmodconfig    clang-19
i386                              allnoconfig    clang-19
i386                             allyesconfig    clang-19
i386        buildonly-randconfig-001-20241101    gcc-12
i386        buildonly-randconfig-002-20241101    gcc-12
i386        buildonly-randconfig-003-20241101    gcc-12
i386        buildonly-randconfig-004-20241101    gcc-12
i386        buildonly-randconfig-005-20241101    gcc-12
i386        buildonly-randconfig-006-20241101    gcc-12
i386                                defconfig    clang-19
i386                  randconfig-001-20241101    gcc-12
i386                  randconfig-002-20241101    gcc-12
i386                  randconfig-003-20241101    gcc-12
i386                  randconfig-004-20241101    gcc-12
i386                  randconfig-005-20241101    gcc-12
i386                  randconfig-006-20241101    gcc-12
i386                  randconfig-011-20241101    gcc-12
i386                  randconfig-012-20241101    gcc-12
i386                  randconfig-013-20241101    gcc-12
i386                  randconfig-014-20241101    gcc-12
i386                  randconfig-015-20241101    gcc-12
i386                  randconfig-016-20241101    gcc-12
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
loongarch                           defconfig    gcc-14.1.0
loongarch                 loongson3_defconfig    clang-20
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
m68k                                defconfig    gcc-14.1.0
m68k                           sun3_defconfig    gcc-14.1.0
m68k                           virt_defconfig    clang-20
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
microblaze                          defconfig    gcc-14.1.0
microblaze                      mmu_defconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
mips                           ci20_defconfig    gcc-14.1.0
nios2                             allnoconfig    gcc-14.1.0
nios2                               defconfig    gcc-14.1.0
openrisc                          allnoconfig    clang-20
openrisc                         allyesconfig    gcc-14.1.0
openrisc                            defconfig    gcc-12
openrisc                    or1ksim_defconfig    gcc-14.1.0
openrisc                 simple_smp_defconfig    gcc-14.1.0
parisc                           allmodconfig    gcc-14.1.0
parisc                            allnoconfig    clang-20
parisc                           allyesconfig    gcc-14.1.0
parisc                              defconfig    gcc-12
parisc64                            defconfig    gcc-14.1.0
powerpc                    adder875_defconfig    clang-20
powerpc                          allmodconfig    gcc-14.1.0
powerpc                           allnoconfig    clang-20
powerpc                          allyesconfig    gcc-14.1.0
powerpc                      cm5200_defconfig    clang-20
powerpc               mpc834x_itxgp_defconfig    clang-20
powerpc                 mpc836x_rdk_defconfig    clang-20
powerpc                      ppc44x_defconfig    gcc-14.1.0
powerpc                     sequoia_defconfig    clang-20
powerpc                         wii_defconfig    gcc-14.1.0
riscv                            allmodconfig    gcc-14.1.0
riscv                             allnoconfig    clang-20
riscv                            allyesconfig    gcc-14.1.0
riscv                               defconfig    gcc-12
riscv             nommu_k210_sdcard_defconfig    gcc-14.1.0
s390                             allmodconfig    gcc-14.1.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                                defconfig    gcc-12
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                        apsh4ad0a_defconfig    gcc-14.1.0
sh                                  defconfig    gcc-12
sh                            migor_defconfig    clang-20
sh                           se7206_defconfig    clang-20
sh                           se7343_defconfig    clang-20
sh                            titan_defconfig    gcc-14.1.0
sparc                            allmodconfig    gcc-14.1.0
sparc                       sparc64_defconfig    gcc-14.1.0
sparc64                             defconfig    gcc-12
um                               allmodconfig    clang-20
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                           x86_64_defconfig    gcc-12
x86_64                           alldefconfig    gcc-14.1.0
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64                              defconfig    clang-19
x86_64                                  kexec    clang-19
x86_64                                  kexec    gcc-12
x86_64                               rhel-8.3    gcc-12
x86_64                           rhel-8.3-bpf    clang-19
x86_64                         rhel-8.3-kunit    clang-19
x86_64                           rhel-8.3-ltp    clang-19
x86_64                          rhel-8.3-rust    clang-19
xtensa                            allnoconfig    gcc-14.1.0
xtensa                         virt_defconfig    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

