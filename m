Return-Path: <linux-wireless+bounces-18146-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34D59A21D34
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Jan 2025 13:39:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 561F63A64D2
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Jan 2025 12:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C354372;
	Wed, 29 Jan 2025 12:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L11Q5YZH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82206184
	for <linux-wireless@vger.kernel.org>; Wed, 29 Jan 2025 12:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738154350; cv=none; b=Vzbnp9UnXKH++DIhOgei/tNVjBaTQw5ACG3l1/oNE/Ct0ep+qoT3H0XJJnxWTB+EWnCvNXFXsqHgU2AftN1AqnSiH5huGzUboFGMaXxmCp+QBDJrCyjJKgG8Plx+fjZOYFp+8ue11GBeJxYb/0/pS/bRKjRuP3M2+4Gd4dO44Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738154350; c=relaxed/simple;
	bh=vJWVTXm93TmEvhMMt5leccWh1RH7Vk4xrJFHq6fVe44=;
	h=Date:From:To:Cc:Subject:Message-ID; b=FsDMRuqfi5oklV2PecChSYjAnEgBZCul2xj3bzQ3OMprCRWAvoITFEbgyhMewB1meVn1pin3iJP90wqRha3KLhTMH/YmZ18dBEREoAglm5FHoaEmQhNDzeublz2dw0BRNWJNzMyM/kq5Vf5wJOGfkadQkMYbr8ipQE5iViBHwzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L11Q5YZH; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738154349; x=1769690349;
  h=date:from:to:cc:subject:message-id;
  bh=vJWVTXm93TmEvhMMt5leccWh1RH7Vk4xrJFHq6fVe44=;
  b=L11Q5YZHwDVMKpGlAWPRbT+xXhfoVifd/qVTE219It6HFOM41xLGeqyk
   OOGgjWEpWG3Qda/almdk4fflCzae2Iq1O/czo/Gxj+x9hADx0XYpR46Yn
   tf+bW+aKK0xfqqjVhLawQPyWoiwfOljuVp6dldDl1iMUYfAKwuGnxcdjB
   NUxhLUnROadwDZTwR91KNIplJh6ZIV0fm+jTl79cU0XhRCnQGfZwfy9lM
   VxuClb7E87N2SIffrZo16hRN9TbKcoE44wC1CmykxH03Yl6yrWjKtKixS
   Ag8DvJWloHDs3z2lho86YFxp8jvXr1/VjxEiimaGbZqbpJDfiK8KYNDgJ
   g==;
X-CSE-ConnectionGUID: GEblxMfTRR++uJ1/mqsegg==
X-CSE-MsgGUID: 36oVHVHuQ1eJk5Ma12OdIA==
X-IronPort-AV: E=McAfee;i="6700,10204,11329"; a="42415469"
X-IronPort-AV: E=Sophos;i="6.13,243,1732608000"; 
   d="scan'208";a="42415469"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2025 04:38:57 -0800
X-CSE-ConnectionGUID: At1VvQYDS/Crmt9JAgr4/w==
X-CSE-MsgGUID: +k81I81RThSQw4QDaxZAWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,243,1732608000"; 
   d="scan'208";a="108995899"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 29 Jan 2025 04:38:55 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1td7LI-000iwf-39;
	Wed, 29 Jan 2025 12:38:52 +0000
Date: Wed, 29 Jan 2025 20:37:55 +0800
From: kernel test robot <lkp@intel.com>
To: Kalle Valo <kvalo@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>,
 linux-wireless@vger.kernel.org
Subject: [wireless:for-next] BUILD SUCCESS
 3319569bf9d8b4d8c5aaf0d410b620210c4bb317
Message-ID: <202501292041.MQRPzCSd-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git for-next
branch HEAD: 3319569bf9d8b4d8c5aaf0d410b620210c4bb317  Merge tag 'ath-current-20250124' of git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath

elapsed time: 1090m

configs tested: 132
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                   randconfig-001-20250129    gcc-13.2.0
arc                   randconfig-002-20250129    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-17
arm                              allyesconfig    gcc-14.2.0
arm                   milbeaut_m10v_defconfig    clang-20
arm                       omap2plus_defconfig    gcc-14.2.0
arm                          pxa910_defconfig    gcc-14.2.0
arm                   randconfig-001-20250129    gcc-14.2.0
arm                   randconfig-002-20250129    clang-20
arm                   randconfig-003-20250129    gcc-14.2.0
arm                   randconfig-004-20250129    gcc-14.2.0
arm                           sama7_defconfig    clang-16
arm                        spear3xx_defconfig    clang-16
arm                        vexpress_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250129    gcc-14.2.0
arm64                 randconfig-002-20250129    gcc-14.2.0
arm64                 randconfig-003-20250129    gcc-14.2.0
arm64                 randconfig-004-20250129    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250129    gcc-14.2.0
csky                  randconfig-002-20250129    gcc-14.2.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    clang-20
hexagon                          allyesconfig    clang-18
hexagon               randconfig-001-20250129    clang-19
hexagon               randconfig-002-20250129    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250129    clang-19
i386        buildonly-randconfig-002-20250129    gcc-12
i386        buildonly-randconfig-003-20250129    clang-19
i386        buildonly-randconfig-004-20250129    clang-19
i386        buildonly-randconfig-005-20250129    clang-19
i386        buildonly-randconfig-006-20250129    gcc-12
i386                                defconfig    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250129    gcc-14.2.0
loongarch             randconfig-002-20250129    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                          atari_defconfig    gcc-14.2.0
m68k                          hp300_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                        bcm47xx_defconfig    clang-20
mips                      bmips_stb_defconfig    clang-18
mips                      maltaaprp_defconfig    clang-20
mips                          rb532_defconfig    clang-17
nios2                 randconfig-001-20250129    gcc-14.2.0
nios2                 randconfig-002-20250129    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-14.2.0
openrisc                  or1klitex_defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-14.2.0
parisc                randconfig-001-20250129    gcc-14.2.0
parisc                randconfig-002-20250129    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-16
powerpc                      arches_defconfig    gcc-14.2.0
powerpc                     ep8248e_defconfig    gcc-14.2.0
powerpc                      pmac32_defconfig    clang-20
powerpc               randconfig-001-20250129    clang-20
powerpc               randconfig-002-20250129    clang-20
powerpc               randconfig-003-20250129    gcc-14.2.0
powerpc                     sequoia_defconfig    clang-17
powerpc                     tqm8541_defconfig    clang-15
powerpc                      tqm8xx_defconfig    clang-20
powerpc64             randconfig-001-20250129    clang-16
powerpc64             randconfig-002-20250129    clang-18
powerpc64             randconfig-003-20250129    clang-20
riscv                            allmodconfig    clang-20
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-20
riscv                               defconfig    clang-19
riscv                    nommu_k210_defconfig    clang-15
riscv                 randconfig-001-20250129    gcc-14.2.0
riscv                 randconfig-002-20250129    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    clang-15
s390                  randconfig-001-20250129    clang-20
s390                  randconfig-002-20250129    clang-17
sh                               allmodconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-14.2.0
sh                          kfr2r09_defconfig    gcc-14.2.0
sh                          r7785rp_defconfig    gcc-14.2.0
sh                    randconfig-001-20250129    gcc-14.2.0
sh                    randconfig-002-20250129    gcc-14.2.0
sh                          rsk7201_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                 randconfig-001-20250129    gcc-14.2.0
sparc                 randconfig-002-20250129    gcc-14.2.0
sparc64                             defconfig    gcc-14.2.0
sparc64               randconfig-001-20250129    gcc-14.2.0
sparc64               randconfig-002-20250129    gcc-14.2.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-18
um                               allyesconfig    gcc-12
um                                  defconfig    clang-20
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250129    gcc-12
um                    randconfig-002-20250129    gcc-12
um                           x86_64_defconfig    clang-15
x86_64                           alldefconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250129    clang-19
x86_64      buildonly-randconfig-002-20250129    gcc-12
x86_64      buildonly-randconfig-003-20250129    gcc-12
x86_64      buildonly-randconfig-004-20250129    gcc-12
x86_64      buildonly-randconfig-005-20250129    gcc-12
x86_64      buildonly-randconfig-006-20250129    clang-19
x86_64                              defconfig    gcc-11
xtensa                randconfig-001-20250129    gcc-14.2.0
xtensa                randconfig-002-20250129    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

