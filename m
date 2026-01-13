Return-Path: <linux-wireless+bounces-30790-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4954ED1BA55
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jan 2026 00:02:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 780803027E3B
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jan 2026 23:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E2182DA755;
	Tue, 13 Jan 2026 23:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a7wefSpQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24EB1D432D
	for <linux-wireless@vger.kernel.org>; Tue, 13 Jan 2026 23:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768345374; cv=none; b=gxu+2qT6NGo8BG0E4Llr7iCL9MrRX4Tp7OfD/9npeqdSGyO0k0AYRajdqqqBAgOTYlGNJ/87gPTiiRY+LbO71od6kgn0lKEztZpxBhb9PQf4exywOCAfqldjqJRyMFi2lbfliUXYzPi4ml3iav96D7CO5guyOR5nJo8QafErDsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768345374; c=relaxed/simple;
	bh=ZstixME5KMrYxNoCMqH4VMXWM8a2HPc/dVZJXKZb9zo=;
	h=Date:From:To:Cc:Subject:Message-ID; b=WEympHd3sE73qjnGQxXkeZp26fReHToGdhgCMrytBmxNQWYEyyQNXVELbdGeQhHmBjs9DpA7QzROPN76stSxnNNlyRJKBe4cupuAfWLupGskcEQcr7eTBn4aAIyOxfupiQLsoPyL7zsyjolR6Saxkx/aK0eDomKMgUu1K8mEYWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a7wefSpQ; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768345372; x=1799881372;
  h=date:from:to:cc:subject:message-id;
  bh=ZstixME5KMrYxNoCMqH4VMXWM8a2HPc/dVZJXKZb9zo=;
  b=a7wefSpQXBmoNQBYTUVIoD0P6HaupuLMFB5tbg+KoUWuGz7JkqYv5OY4
   m3ZkxBPPu/Vj7qUJgt+Kw3YRTOhT3jZdsV8mivdMOxXtjehD5EVRySIg6
   ynvvfew8U4PB1RHuiz6ATNVaLfNZHxOH0rkLYK470bwKYwzAobCn8m5fR
   Fuajt4zb+Rc+OgPX3dPgnTp5zLSob4UnqKXmzk3D71wvQsa1rdb/A80cP
   xrjYeGKL7bTzO+ltw+4YbfIWim64uobnZnLHUonOoCN7qNDwX+YUpw6dP
   K5APK3GFbtDGkCAbKX4BVHNEiv5NXrgR5hmL6D+hzBxo1sTVkvjWeGhyP
   w==;
X-CSE-ConnectionGUID: Hi+khDdXQZWrX707FHxyNg==
X-CSE-MsgGUID: OUCMVQk3Roy7Jarks52D2g==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="73277292"
X-IronPort-AV: E=Sophos;i="6.21,224,1763452800"; 
   d="scan'208";a="73277292"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 15:02:52 -0800
X-CSE-ConnectionGUID: Dts0dPTSQUeU8hkVHYXuNw==
X-CSE-MsgGUID: tzexqUWzQ9y79VsQcbBixQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,224,1763452800"; 
   d="scan'208";a="208674013"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 13 Jan 2026 15:02:51 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vfnPU-00000000FTG-2eP7;
	Tue, 13 Jan 2026 23:02:48 +0000
Date: Wed, 14 Jan 2026 07:02:31 +0800
From: kernel test robot <lkp@intel.com>
To: Johannes Berg <johannes.berg@intel.com>
Cc: linux-wireless@vger.kernel.org
Subject: [wireless-next:main] BUILD SUCCESS
 24a57985670e9dac5547e5b7731bf8e7b03d5be8
Message-ID: <202601140723.4EGDaRas-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: 24a57985670e9dac5547e5b7731bf8e7b03d5be8  wifi: cfg80211: don't apply HT flags to S1G channels

elapsed time: 754m

configs tested: 298
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-22
arc                          axs101_defconfig    gcc-15.2.0
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260113    clang-22
arc                   randconfig-001-20260114    gcc-10.5.0
arc                   randconfig-002-20260113    clang-22
arc                   randconfig-002-20260114    gcc-10.5.0
arc                           tb10x_defconfig    gcc-15.2.0
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                        clps711x_defconfig    gcc-15.2.0
arm                                 defconfig    gcc-15.2.0
arm                            hisi_defconfig    gcc-15.2.0
arm                       imx_v6_v7_defconfig    gcc-15.2.0
arm                          pxa168_defconfig    gcc-15.2.0
arm                   randconfig-001-20260113    clang-22
arm                   randconfig-001-20260114    gcc-10.5.0
arm                   randconfig-002-20260113    clang-22
arm                   randconfig-002-20260114    gcc-10.5.0
arm                   randconfig-003-20260113    clang-22
arm                   randconfig-003-20260114    gcc-10.5.0
arm                   randconfig-004-20260113    clang-22
arm                   randconfig-004-20260114    gcc-10.5.0
arm                        spear3xx_defconfig    gcc-15.2.0
arm                           spitz_defconfig    gcc-15.2.0
arm                           stm32_defconfig    clang-22
arm                         wpcm450_defconfig    gcc-15.2.0
arm64                            allmodconfig    clang-22
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260113    clang-22
arm64                 randconfig-001-20260114    clang-22
arm64                 randconfig-002-20260113    clang-22
arm64                 randconfig-002-20260114    clang-22
arm64                 randconfig-003-20260113    clang-22
arm64                 randconfig-003-20260114    clang-22
arm64                 randconfig-003-20260114    gcc-10.5.0
arm64                 randconfig-004-20260113    clang-22
arm64                 randconfig-004-20260114    clang-18
arm64                 randconfig-004-20260114    clang-22
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260113    clang-22
csky                  randconfig-001-20260114    clang-22
csky                  randconfig-001-20260114    gcc-15.2.0
csky                  randconfig-002-20260113    clang-22
csky                  randconfig-002-20260114    clang-22
csky                  randconfig-002-20260114    gcc-10.5.0
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260113    clang-22
hexagon               randconfig-001-20260114    clang-22
hexagon               randconfig-002-20260113    clang-22
hexagon               randconfig-002-20260114    clang-22
i386                             allmodconfig    clang-20
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20260113    clang-20
i386        buildonly-randconfig-001-20260114    gcc-14
i386        buildonly-randconfig-002-20260113    clang-20
i386        buildonly-randconfig-002-20260114    gcc-14
i386        buildonly-randconfig-003-20260113    clang-20
i386        buildonly-randconfig-003-20260114    gcc-14
i386        buildonly-randconfig-004-20260113    clang-20
i386        buildonly-randconfig-004-20260114    gcc-14
i386        buildonly-randconfig-005-20260113    clang-20
i386        buildonly-randconfig-005-20260114    gcc-14
i386        buildonly-randconfig-006-20260113    clang-20
i386        buildonly-randconfig-006-20260114    gcc-14
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260113    clang-20
i386                  randconfig-001-20260114    gcc-14
i386                  randconfig-002-20260113    clang-20
i386                  randconfig-002-20260114    gcc-14
i386                  randconfig-003-20260113    clang-20
i386                  randconfig-003-20260114    gcc-14
i386                  randconfig-004-20260113    clang-20
i386                  randconfig-004-20260114    gcc-14
i386                  randconfig-005-20260113    clang-20
i386                  randconfig-005-20260114    gcc-14
i386                  randconfig-006-20260113    clang-20
i386                  randconfig-006-20260114    gcc-14
i386                  randconfig-007-20260113    clang-20
i386                  randconfig-007-20260114    gcc-14
i386                  randconfig-011-20260113    gcc-14
i386                  randconfig-011-20260114    gcc-14
i386                  randconfig-012-20260113    gcc-14
i386                  randconfig-012-20260114    gcc-14
i386                  randconfig-013-20260113    gcc-14
i386                  randconfig-013-20260114    gcc-14
i386                  randconfig-014-20260113    gcc-14
i386                  randconfig-014-20260114    gcc-14
i386                  randconfig-015-20260113    gcc-14
i386                  randconfig-015-20260114    gcc-14
i386                  randconfig-016-20260113    gcc-14
i386                  randconfig-016-20260114    gcc-14
i386                  randconfig-017-20260113    gcc-14
i386                  randconfig-017-20260114    gcc-14
loongarch                        allmodconfig    clang-22
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260113    clang-22
loongarch             randconfig-001-20260114    clang-22
loongarch             randconfig-002-20260113    clang-22
loongarch             randconfig-002-20260114    clang-22
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                                defconfig    clang-19
m68k                          multi_defconfig    gcc-15.2.0
m68k                        mvme147_defconfig    gcc-15.2.0
m68k                           sun3_defconfig    gcc-15.2.0
microblaze                       alldefconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                         bigsur_defconfig    gcc-15.2.0
mips                       bmips_be_defconfig    gcc-15.2.0
mips                  cavium_octeon_defconfig    gcc-15.2.0
mips                          eyeq6_defconfig    gcc-15.2.0
mips                           gcw0_defconfig    gcc-15.2.0
mips                           ip30_defconfig    gcc-15.2.0
mips                    maltaup_xpa_defconfig    gcc-15.2.0
mips                           rs90_defconfig    gcc-15.2.0
nios2                         10m50_defconfig    gcc-15.2.0
nios2                         3c120_defconfig    gcc-15.2.0
nios2                            allmodconfig    clang-22
nios2                             allnoconfig    clang-22
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260113    clang-22
nios2                 randconfig-001-20260114    clang-22
nios2                 randconfig-002-20260113    clang-22
nios2                 randconfig-002-20260114    clang-22
openrisc                         allmodconfig    clang-22
openrisc                          allnoconfig    clang-22
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-22
parisc                           allyesconfig    clang-19
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260113    clang-19
parisc                randconfig-001-20260114    gcc-14.3.0
parisc                randconfig-002-20260113    clang-19
parisc                randconfig-002-20260114    gcc-14.3.0
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-22
powerpc                      chrp32_defconfig    gcc-15.2.0
powerpc                   motionpro_defconfig    gcc-15.2.0
powerpc                  mpc866_ads_defconfig    clang-22
powerpc                  mpc885_ads_defconfig    gcc-15.2.0
powerpc                     powernv_defconfig    clang-22
powerpc               randconfig-001-20260113    clang-19
powerpc               randconfig-001-20260114    gcc-14.3.0
powerpc               randconfig-002-20260113    clang-19
powerpc               randconfig-002-20260114    gcc-14.3.0
powerpc                    sam440ep_defconfig    clang-22
powerpc                     tqm8555_defconfig    gcc-15.2.0
powerpc64             randconfig-001-20260113    clang-19
powerpc64             randconfig-001-20260114    gcc-14.3.0
powerpc64             randconfig-002-20260113    clang-19
powerpc64             randconfig-002-20260114    gcc-14.3.0
riscv                            alldefconfig    clang-22
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    clang-22
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv             nommu_k210_sdcard_defconfig    clang-22
riscv                    nommu_virt_defconfig    gcc-15.2.0
riscv                 randconfig-001-20260113    gcc-15.2.0
riscv                 randconfig-001-20260114    gcc-15.2.0
riscv                 randconfig-002-20260113    gcc-15.2.0
riscv                 randconfig-002-20260114    gcc-15.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.2.0
s390                          debug_defconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260113    gcc-15.2.0
s390                  randconfig-001-20260114    gcc-15.2.0
s390                  randconfig-002-20260113    gcc-15.2.0
s390                  randconfig-002-20260114    gcc-15.2.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-22
sh                               allyesconfig    clang-19
sh                                  defconfig    gcc-14
sh                          kfr2r09_defconfig    gcc-15.2.0
sh                          landisk_defconfig    gcc-15.2.0
sh                    randconfig-001-20260113    gcc-15.2.0
sh                    randconfig-001-20260114    gcc-15.2.0
sh                    randconfig-002-20260113    gcc-15.2.0
sh                    randconfig-002-20260114    gcc-15.2.0
sh                      rts7751r2d1_defconfig    gcc-15.2.0
sh                           se7619_defconfig    clang-22
sh                     sh7710voipgw_defconfig    gcc-15.2.0
sparc                            alldefconfig    gcc-15.2.0
sparc                             allnoconfig    clang-22
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260113    gcc-14.3.0
sparc                 randconfig-001-20260114    clang-20
sparc                 randconfig-002-20260113    gcc-14.3.0
sparc                 randconfig-002-20260114    clang-20
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260113    gcc-14.3.0
sparc64               randconfig-001-20260114    clang-20
sparc64               randconfig-002-20260113    gcc-14.3.0
sparc64               randconfig-002-20260114    clang-20
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260113    gcc-14.3.0
um                    randconfig-001-20260114    clang-20
um                    randconfig-002-20260113    gcc-14.3.0
um                    randconfig-002-20260114    clang-20
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-22
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260113    clang-20
x86_64      buildonly-randconfig-001-20260114    clang-20
x86_64      buildonly-randconfig-002-20260113    clang-20
x86_64      buildonly-randconfig-002-20260114    clang-20
x86_64      buildonly-randconfig-003-20260113    clang-20
x86_64      buildonly-randconfig-003-20260114    clang-20
x86_64      buildonly-randconfig-004-20260113    clang-20
x86_64      buildonly-randconfig-004-20260114    clang-20
x86_64      buildonly-randconfig-005-20260113    clang-20
x86_64      buildonly-randconfig-005-20260114    clang-20
x86_64      buildonly-randconfig-006-20260113    clang-20
x86_64      buildonly-randconfig-006-20260114    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260113    gcc-14
x86_64                randconfig-001-20260114    gcc-14
x86_64                randconfig-002-20260113    gcc-14
x86_64                randconfig-002-20260114    gcc-14
x86_64                randconfig-003-20260113    gcc-14
x86_64                randconfig-003-20260114    gcc-14
x86_64                randconfig-004-20260113    gcc-14
x86_64                randconfig-004-20260114    gcc-14
x86_64                randconfig-005-20260113    gcc-14
x86_64                randconfig-005-20260114    gcc-14
x86_64                randconfig-006-20260113    gcc-14
x86_64                randconfig-006-20260114    gcc-14
x86_64                randconfig-011-20260113    clang-20
x86_64                randconfig-011-20260114    gcc-14
x86_64                randconfig-012-20260113    clang-20
x86_64                randconfig-012-20260114    gcc-14
x86_64                randconfig-013-20260113    clang-20
x86_64                randconfig-013-20260114    gcc-14
x86_64                randconfig-014-20260113    clang-20
x86_64                randconfig-014-20260114    gcc-14
x86_64                randconfig-015-20260113    clang-20
x86_64                randconfig-015-20260114    gcc-14
x86_64                randconfig-016-20260113    clang-20
x86_64                randconfig-016-20260114    gcc-14
x86_64                randconfig-071-20260113    clang-20
x86_64                randconfig-071-20260114    clang-20
x86_64                randconfig-072-20260113    clang-20
x86_64                randconfig-072-20260114    clang-20
x86_64                randconfig-073-20260113    clang-20
x86_64                randconfig-073-20260114    clang-20
x86_64                randconfig-074-20260113    clang-20
x86_64                randconfig-074-20260114    clang-20
x86_64                randconfig-075-20260113    clang-20
x86_64                randconfig-075-20260114    clang-20
x86_64                randconfig-076-20260113    clang-20
x86_64                randconfig-076-20260114    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-22
xtensa                           allyesconfig    clang-22
xtensa                  audio_kc705_defconfig    clang-22
xtensa                  audio_kc705_defconfig    gcc-15.2.0
xtensa                  nommu_kc705_defconfig    gcc-15.2.0
xtensa                randconfig-001-20260113    gcc-14.3.0
xtensa                randconfig-001-20260114    clang-20
xtensa                randconfig-002-20260113    gcc-14.3.0
xtensa                randconfig-002-20260114    clang-20
xtensa                    smp_lx200_defconfig    gcc-15.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

