Return-Path: <linux-wireless+bounces-25677-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D82CB0B06C
	for <lists+linux-wireless@lfdr.de>; Sat, 19 Jul 2025 16:25:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A59E7A7057
	for <lists+linux-wireless@lfdr.de>; Sat, 19 Jul 2025 14:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B43A0287255;
	Sat, 19 Jul 2025 14:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZmKjzPFO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5EB41DC9A3
	for <linux-wireless@vger.kernel.org>; Sat, 19 Jul 2025 14:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752935128; cv=none; b=KIZs3WsmDmdvzFFb+aXsuQ6QM/fQIWAuFW9+7gsWEGsKDIiCqEheedeeRFS/Fizt7hpXpJwTsLEkssxFwgDeWOWGJRADAt1SaBDtODKUi9p9C/1KUOPRy0vsYE9tDMZAVVGwo7PXIyiFX9BARVF5amHYGOf+knvrd3ejmxIrCXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752935128; c=relaxed/simple;
	bh=miSkwoiKtRWuKtgjQ5NaomF1TTgsfRDS61rSLm4KtnE=;
	h=Date:From:To:Cc:Subject:Message-ID; b=JvSqtl7mjWu1apc16i0Iz6o0RbBP/yf+kBzPmLZgesrMtFBiygfSAZ96DgseV3SS6FTqtFiPWpwmJN3fwnv2SSMGCfAB4ktX4BHSfoi067MQpBkumYJHJOqVIUUzmQ/t3tmO2AmwGrAZImFNxrO/chmM2AHd/6EcJFtX+H8q6Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZmKjzPFO; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752935127; x=1784471127;
  h=date:from:to:cc:subject:message-id;
  bh=miSkwoiKtRWuKtgjQ5NaomF1TTgsfRDS61rSLm4KtnE=;
  b=ZmKjzPFOqCpsXznlK4NjpkVb2kINQhmeSRXyeS/zO5oLs4ul1mbG4f73
   7RpwAeEAt5hi7uVJl/h0VzmSc+iHujv2cr2TafuDpwwl6nXfLMs18IkgX
   DVSvQLd1VXI2WVMRfsPbaP3OopL5QR71h1XsFG7q9nlessCaNy9NgYhJ7
   h7GqjR1VkLUoz9Eu6lwnSfIxISSAr4pJBO9jgMng0f87bd6Je2YQ301ab
   QKt1F359peYujGr8OOWfSSBXESbl4H0s+wE5qxzuggDA3l6fQuL1Dl9gZ
   frhoRBS6NG/MZpuror8mOaErK+STYh/JZ24BhW01Nt9hziL23F1gx+7tj
   Q==;
X-CSE-ConnectionGUID: 8BrezlS0TCS554XjMTzRAQ==
X-CSE-MsgGUID: pJyVhdqpSt+DcE2SPv69BQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11497"; a="72665954"
X-IronPort-AV: E=Sophos;i="6.16,324,1744095600"; 
   d="scan'208";a="72665954"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2025 07:25:26 -0700
X-CSE-ConnectionGUID: TSRUvdfyQymbPV9E+O16LQ==
X-CSE-MsgGUID: 4W4ff89pSn2oSKZ+fpDBFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,324,1744095600"; 
   d="scan'208";a="158773971"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 19 Jul 2025 07:25:25 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ud8V9-000FXv-0p;
	Sat, 19 Jul 2025 14:25:23 +0000
Date: Sat, 19 Jul 2025 22:25:13 +0800
From: kernel test robot <lkp@intel.com>
To: Johannes Berg <johannes.berg@intel.com>
Cc: Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org
Subject: [wireless-next:main] BUILD SUCCESS
 754fe848b3b297fc85ec24cd959bad22b6df8cb8
Message-ID: <202507192201.wq4DQcfP-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: 754fe848b3b297fc85ec24cd959bad22b6df8cb8  Reapply "wifi: mac80211: Update skb's control block key in ieee80211_tx_dequeue()"

elapsed time: 1443m

configs tested: 138
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                   randconfig-001-20250718    gcc-10.5.0
arc                   randconfig-001-20250719    gcc-14.3.0
arc                   randconfig-002-20250718    gcc-8.5.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    gcc-15.1.0
arm                            hisi_defconfig    gcc-15.1.0
arm                       omap2plus_defconfig    gcc-15.1.0
arm                   randconfig-001-20250718    gcc-8.5.0
arm                   randconfig-001-20250719    gcc-14.3.0
arm                   randconfig-002-20250718    gcc-8.5.0
arm                   randconfig-003-20250718    gcc-8.5.0
arm                   randconfig-004-20250718    gcc-10.5.0
arm                         socfpga_defconfig    gcc-15.1.0
arm                        spear6xx_defconfig    clang-21
arm                       versatile_defconfig    gcc-15.1.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250718    gcc-13.4.0
arm64                 randconfig-002-20250718    gcc-8.5.0
arm64                 randconfig-003-20250718    clang-21
arm64                 randconfig-004-20250718    gcc-8.5.0
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250718    gcc-15.1.0
csky                  randconfig-001-20250719    gcc-15.1.0
csky                  randconfig-002-20250718    gcc-15.1.0
csky                  randconfig-002-20250719    gcc-11.5.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250718    clang-21
hexagon               randconfig-001-20250719    clang-21
hexagon               randconfig-002-20250718    clang-21
hexagon               randconfig-002-20250719    clang-21
i386        buildonly-randconfig-001-20250718    gcc-12
i386        buildonly-randconfig-002-20250718    clang-20
i386        buildonly-randconfig-003-20250718    gcc-12
i386        buildonly-randconfig-004-20250718    gcc-11
i386        buildonly-randconfig-005-20250718    gcc-12
i386        buildonly-randconfig-006-20250718    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-21
loongarch             randconfig-001-20250718    gcc-15.1.0
loongarch             randconfig-001-20250719    clang-18
loongarch             randconfig-002-20250718    gcc-15.1.0
loongarch             randconfig-002-20250719    gcc-15.1.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                       bmips_be_defconfig    gcc-15.1.0
mips                           ip32_defconfig    clang-21
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20250718    gcc-8.5.0
nios2                 randconfig-001-20250719    gcc-11.5.0
nios2                 randconfig-002-20250718    gcc-11.5.0
nios2                 randconfig-002-20250719    gcc-8.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                 simple_smp_defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250718    gcc-14.3.0
parisc                randconfig-001-20250719    gcc-8.5.0
parisc                randconfig-002-20250718    gcc-13.4.0
parisc                randconfig-002-20250719    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-21
powerpc                      pcm030_defconfig    clang-21
powerpc                     rainier_defconfig    gcc-15.1.0
powerpc               randconfig-001-20250718    gcc-9.5.0
powerpc               randconfig-001-20250719    clang-19
powerpc               randconfig-002-20250718    gcc-11.5.0
powerpc               randconfig-002-20250719    gcc-10.5.0
powerpc               randconfig-003-20250718    clang-17
powerpc               randconfig-003-20250719    gcc-12.5.0
powerpc                        warp_defconfig    gcc-15.1.0
powerpc64             randconfig-001-20250718    clang-18
powerpc64             randconfig-001-20250719    gcc-8.5.0
powerpc64             randconfig-002-20250718    clang-21
powerpc64             randconfig-002-20250719    clang-21
powerpc64             randconfig-003-20250719    gcc-10.5.0
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                 randconfig-001-20250719    clang-21
riscv                 randconfig-002-20250719    clang-21
s390                             alldefconfig    gcc-15.1.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-15.1.0
s390                  randconfig-001-20250719    gcc-9.5.0
s390                  randconfig-002-20250719    gcc-9.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                        edosk7705_defconfig    gcc-15.1.0
sh                             espt_defconfig    gcc-15.1.0
sh                    randconfig-001-20250719    gcc-13.4.0
sh                    randconfig-002-20250719    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250719    gcc-15.1.0
sparc                 randconfig-002-20250719    gcc-15.1.0
sparc64               randconfig-001-20250719    gcc-9.5.0
sparc64               randconfig-002-20250719    gcc-9.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                    randconfig-001-20250719    clang-16
um                    randconfig-002-20250719    clang-21
x86_64                           alldefconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64      buildonly-randconfig-001-20250718    clang-20
x86_64      buildonly-randconfig-002-20250718    gcc-12
x86_64      buildonly-randconfig-003-20250718    gcc-12
x86_64      buildonly-randconfig-004-20250718    clang-20
x86_64      buildonly-randconfig-005-20250718    clang-20
x86_64      buildonly-randconfig-006-20250718    clang-20
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250719    gcc-14.3.0
xtensa                randconfig-002-20250719    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

