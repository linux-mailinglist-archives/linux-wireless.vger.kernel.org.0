Return-Path: <linux-wireless+bounces-13835-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C674998051
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Oct 2024 10:42:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E961E1F255D4
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Oct 2024 08:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B9EB192B78;
	Thu, 10 Oct 2024 08:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VmIpyRh0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18C918C00E
	for <linux-wireless@vger.kernel.org>; Thu, 10 Oct 2024 08:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728548579; cv=none; b=HiHdKsR04ghGyxfvFPwxfhYHAem2oP5HB0c/dy6AX7TRcMrlIBsV58/MFhMRz4oWJ1eT3zd0c68WszB9ziqtdLrNI+oOAKYUzAVFVOZg76hEvHoPoLxLt2gJyDXN+7jo5Si+shLhAIh0ejvkoZT9x72N5iVicfbS5lUt32V7La4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728548579; c=relaxed/simple;
	bh=wDJzNtNFeQrSuhYwk/8WjRKoXz0sM6loGmpmmIDx/Oo=;
	h=Date:From:To:Cc:Subject:Message-ID; b=k5t5uRIf0Ky5XpbUH1nuiGBBsrU037ZuruqonyB/6Zkw3Xbg+6Tm+K00uE1Rzpr/mKix/AEz+/P2mWcWG6cEk0dNIswmDDC1A4Spx9V4cvG9LIoCrZ5TRwRiFpPtGGPXPviwi8UlY1Kzx8RILJa2x4RV3X1wBWdnT0WWxRfRo5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VmIpyRh0; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728548578; x=1760084578;
  h=date:from:to:cc:subject:message-id;
  bh=wDJzNtNFeQrSuhYwk/8WjRKoXz0sM6loGmpmmIDx/Oo=;
  b=VmIpyRh09JiBwi6jOup3qx7EbIBsggv0tJi9daCqSEwc47UpjXMvadQC
   qZH/UKFLdMzT9KEooAbgLqMBPXqC9ZO8bz9hEDqp3if3tWWI7Bm2sOB2Z
   ydt25cCs34RePuEdHQ+ggrrh+z1KHsVFH1lnsFWvEA6CTgBu8eJP7+SzI
   KPx4EkfJkGMqpW1a2tbihdLe5/w1FNzFKTWRGoYrktAPSQ0Y9TDD3Fekb
   POFiQCy3T9T/dceg0ISTTrGWfbNppsThSV3OiwB1WiHSWFsbt3Vdg3Iuj
   6N8LcoIVvl73wXVSb7iUx+pRr7KFrqM+pxalALr2JWmRVmj7N0JSZIvhc
   w==;
X-CSE-ConnectionGUID: P9qBBneyStGxXFDaPHrsdw==
X-CSE-MsgGUID: qZCZi39vQJiUHlc+aYJ/IA==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="27702138"
X-IronPort-AV: E=Sophos;i="6.11,192,1725346800"; 
   d="scan'208";a="27702138"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2024 01:22:58 -0700
X-CSE-ConnectionGUID: mmLQMv11QGiE4lUBrqtsAQ==
X-CSE-MsgGUID: vjmHJ2h8SIyisveXfFsOqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,192,1725346800"; 
   d="scan'208";a="76180308"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 10 Oct 2024 01:22:56 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1syoRh-000AO5-36;
	Thu, 10 Oct 2024 08:22:53 +0000
Date: Thu, 10 Oct 2024 16:22:37 +0800
From: kernel test robot <lkp@intel.com>
To: Johannes Berg <johannes.berg@intel.com>
Cc: Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org
Subject: [wireless-next:main] BUILD SUCCESS
 a0efa2f362a69e47b9d8b48f770ef3a0249a7911
Message-ID: <202410101630.FRncHZGF-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: a0efa2f362a69e47b9d8b48f770ef3a0249a7911  Merge net-next/main to resolve conflicts

elapsed time: 1382m

configs tested: 180
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.1.0
alpha                            allyesconfig    clang-20
alpha                               defconfig    gcc-14.1.0
arc                              allmodconfig    clang-20
arc                               allnoconfig    gcc-14.1.0
arc                              allyesconfig    clang-20
arc                          axs101_defconfig    gcc-14.1.0
arc                                 defconfig    gcc-14.1.0
arc                   randconfig-001-20241010    clang-20
arc                   randconfig-002-20241010    clang-20
arc                           tb10x_defconfig    gcc-14.1.0
arc                        vdk_hs38_defconfig    gcc-14.1.0
arm                              allmodconfig    clang-20
arm                               allnoconfig    gcc-14.1.0
arm                              allyesconfig    clang-20
arm                                 defconfig    gcc-14.1.0
arm                   randconfig-001-20241010    clang-20
arm                   randconfig-002-20241010    clang-20
arm                   randconfig-003-20241010    clang-20
arm                   randconfig-004-20241010    clang-20
arm                         wpcm450_defconfig    gcc-14.1.0
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.1.0
arm64                               defconfig    gcc-14.1.0
arm64                 randconfig-001-20241010    clang-20
arm64                 randconfig-002-20241010    clang-20
arm64                 randconfig-003-20241010    clang-20
arm64                 randconfig-004-20241010    clang-20
csky                              allnoconfig    gcc-14.1.0
csky                                defconfig    gcc-14.1.0
csky                  randconfig-001-20241010    clang-20
csky                  randconfig-002-20241010    clang-20
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.1.0
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    gcc-14.1.0
hexagon               randconfig-001-20241010    clang-20
hexagon               randconfig-002-20241010    clang-20
i386                             allmodconfig    clang-18
i386                              allnoconfig    clang-18
i386                             allyesconfig    clang-18
i386        buildonly-randconfig-001-20241010    clang-18
i386        buildonly-randconfig-002-20241010    clang-18
i386        buildonly-randconfig-003-20241010    clang-18
i386        buildonly-randconfig-004-20241010    clang-18
i386        buildonly-randconfig-005-20241010    clang-18
i386        buildonly-randconfig-006-20241010    clang-18
i386                                defconfig    clang-18
i386                  randconfig-001-20241010    clang-18
i386                  randconfig-002-20241010    clang-18
i386                  randconfig-003-20241010    clang-18
i386                  randconfig-004-20241010    clang-18
i386                  randconfig-005-20241010    clang-18
i386                  randconfig-006-20241010    clang-18
i386                  randconfig-011-20241010    clang-18
i386                  randconfig-012-20241010    clang-18
i386                  randconfig-013-20241010    clang-18
i386                  randconfig-014-20241010    clang-18
i386                  randconfig-015-20241010    clang-18
i386                  randconfig-016-20241010    clang-18
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
loongarch                           defconfig    gcc-14.1.0
loongarch             randconfig-001-20241010    clang-20
loongarch             randconfig-002-20241010    clang-20
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
m68k                                defconfig    gcc-14.1.0
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
microblaze                          defconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
mips                           ci20_defconfig    gcc-14.1.0
mips                     cu1830-neo_defconfig    gcc-14.1.0
mips                          malta_defconfig    gcc-14.1.0
nios2                             allnoconfig    gcc-14.1.0
nios2                               defconfig    gcc-14.1.0
nios2                 randconfig-001-20241010    clang-20
nios2                 randconfig-002-20241010    clang-20
openrisc                          allnoconfig    clang-20
openrisc                          allnoconfig    gcc-14.1.0
openrisc                         allyesconfig    gcc-14.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.1.0
parisc                            allnoconfig    clang-20
parisc                            allnoconfig    gcc-14.1.0
parisc                           allyesconfig    gcc-14.1.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20241010    clang-20
parisc                randconfig-002-20241010    clang-20
parisc64                            defconfig    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.1.0
powerpc                           allnoconfig    clang-20
powerpc                           allnoconfig    gcc-14.1.0
powerpc                          allyesconfig    gcc-14.1.0
powerpc                        fsp2_defconfig    gcc-14.1.0
powerpc                     mpc83xx_defconfig    gcc-14.1.0
powerpc                      ppc6xx_defconfig    gcc-14.1.0
powerpc               randconfig-001-20241010    clang-20
powerpc               randconfig-002-20241010    clang-20
powerpc               randconfig-003-20241010    clang-20
powerpc                     tqm8541_defconfig    gcc-14.1.0
powerpc64             randconfig-001-20241010    clang-20
powerpc64             randconfig-002-20241010    clang-20
powerpc64             randconfig-003-20241010    clang-20
riscv                            allmodconfig    gcc-14.1.0
riscv                             allnoconfig    clang-20
riscv                             allnoconfig    gcc-14.1.0
riscv                            allyesconfig    gcc-14.1.0
riscv                               defconfig    gcc-12
riscv                    nommu_k210_defconfig    gcc-14.1.0
riscv                 randconfig-001-20241010    clang-20
riscv                 randconfig-002-20241010    clang-20
s390                             allmodconfig    gcc-14.1.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20241010    clang-20
s390                  randconfig-002-20241010    clang-20
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                                  defconfig    gcc-12
sh                        edosk7705_defconfig    gcc-14.1.0
sh                            hp6xx_defconfig    gcc-14.1.0
sh                    randconfig-001-20241010    clang-20
sh                    randconfig-002-20241010    clang-20
sh                   sh7770_generic_defconfig    gcc-14.1.0
sh                        sh7785lcr_defconfig    gcc-14.1.0
sparc                            allmodconfig    gcc-14.1.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20241010    clang-20
sparc64               randconfig-002-20241010    clang-20
um                               allmodconfig    clang-20
um                                allnoconfig    clang-17
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20241010    clang-20
um                    randconfig-002-20241010    clang-20
um                           x86_64_defconfig    gcc-12
x86_64                           alldefconfig    gcc-14.1.0
x86_64                            allnoconfig    clang-18
x86_64                           allyesconfig    clang-18
x86_64      buildonly-randconfig-001-20241010    gcc-12
x86_64      buildonly-randconfig-002-20241010    gcc-12
x86_64      buildonly-randconfig-003-20241010    gcc-12
x86_64      buildonly-randconfig-004-20241010    gcc-12
x86_64      buildonly-randconfig-005-20241010    gcc-12
x86_64      buildonly-randconfig-006-20241010    gcc-12
x86_64                              defconfig    clang-18
x86_64                                  kexec    clang-18
x86_64                                  kexec    gcc-12
x86_64                randconfig-001-20241010    gcc-12
x86_64                randconfig-002-20241010    gcc-12
x86_64                randconfig-003-20241010    gcc-12
x86_64                randconfig-004-20241010    gcc-12
x86_64                randconfig-005-20241010    gcc-12
x86_64                randconfig-006-20241010    gcc-12
x86_64                randconfig-011-20241010    gcc-12
x86_64                randconfig-012-20241010    gcc-12
x86_64                randconfig-013-20241010    gcc-12
x86_64                randconfig-014-20241010    gcc-12
x86_64                randconfig-015-20241010    gcc-12
x86_64                randconfig-016-20241010    gcc-12
x86_64                randconfig-071-20241010    gcc-12
x86_64                randconfig-072-20241010    gcc-12
x86_64                randconfig-073-20241010    gcc-12
x86_64                randconfig-074-20241010    gcc-12
x86_64                randconfig-075-20241010    gcc-12
x86_64                randconfig-076-20241010    gcc-12
x86_64                               rhel-8.3    gcc-12
x86_64                    rhel-8.3-kselftests    gcc-12
x86_64                          rhel-8.3-rust    clang-18
xtensa                            allnoconfig    gcc-14.1.0
xtensa                randconfig-001-20241010    clang-20
xtensa                randconfig-002-20241010    clang-20

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

