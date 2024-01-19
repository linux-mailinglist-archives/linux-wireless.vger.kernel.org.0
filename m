Return-Path: <linux-wireless+bounces-2259-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B988A832CFA
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jan 2024 17:15:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B7B0B24F09
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jan 2024 16:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7412052F61;
	Fri, 19 Jan 2024 16:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MYUt5I/h"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD4654BE3
	for <linux-wireless@vger.kernel.org>; Fri, 19 Jan 2024 16:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705680911; cv=none; b=sqatY30DKJUl29VkzKZqzUNBQa8XN3+0ZVsWaHTwTXa/pWSuJklKxU0/AnXBC/dctq3F2fjDKGojl3oRDwkYY0lJgXfFm+bz5qTuqp+kmgto1kX+vveixx/XrzzJBmSGlzK+KXne2ZWP9Nlnc7OxAJul+yJb+rcXnAL7h6Yzjc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705680911; c=relaxed/simple;
	bh=RXQ0eqBJC6OOBAX0NRjuaxzJxYPEoA1ZHldZrSaB4KU=;
	h=Date:From:To:Cc:Subject:Message-ID; b=G45ZHA5HZqElAngQxe6mHw9jaAOmOk2ISLC6yAp0OFMwxiGBr8YkefRjQdYmo9dqml6BWtd+gSTXFBMiLrVOz5SLsPgP+X/3q3swUSNsTpGYsyftFZqbFUm8JfrhhDag7QZsBD3BVMktzLxHlBCV8FP0mnsXoFYm0A9QH837/XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MYUt5I/h; arc=none smtp.client-ip=192.55.52.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705680909; x=1737216909;
  h=date:from:to:cc:subject:message-id;
  bh=RXQ0eqBJC6OOBAX0NRjuaxzJxYPEoA1ZHldZrSaB4KU=;
  b=MYUt5I/hH7/kkHBLsPNJufj7omYd7I045kMu0TK2S+PxvCkZPlGzz5kM
   Qj532R6KkXOhiX4mOX5FzlrjErpquOgBTwbmyYYSDDysWdVHHj/icpT2A
   PgqROnY0xbEzp2guh1GAeCOPQz021wN2Kr81X5zGLuNQgMM3mBink4i7T
   zLU6e6dSCz6e3YXuQpNOwhN6Pfyv9vqwpboNbToi2ehz0V5sw73uj2ElO
   OhWLUJyY20FMJy+iZxz2gWzUCiUw+PM1oNMKLgRYAK5W5zXApKpDxBFuJ
   9wEbjeE3AeG+se0FvSfqNB0/CjqxU9vwAuZYIup59e2kPS0c55O2WXGGF
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10957"; a="400435848"
X-IronPort-AV: E=Sophos;i="6.05,204,1701158400"; 
   d="scan'208";a="400435848"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2024 08:15:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10957"; a="788386342"
X-IronPort-AV: E=Sophos;i="6.05,204,1701158400"; 
   d="scan'208";a="788386342"
Received: from lkp-server01.sh.intel.com (HELO 961aaaa5b03c) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 19 Jan 2024 08:15:06 -0800
Received: from kbuild by 961aaaa5b03c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rQrWK-0004EG-2h;
	Fri, 19 Jan 2024 16:15:04 +0000
Date: Sat, 20 Jan 2024 00:14:14 +0800
From: kernel test robot <lkp@intel.com>
To: Kalle Valo <kvalo@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>,
 linux-wireless@vger.kernel.org
Subject: [wireless-next:main] BUILD SUCCESS
 0f7352557a35ab7888bc7831411ec8a3cbe20d78
Message-ID: <202401200011.HQJhH0Gl-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: 0f7352557a35ab7888bc7831411ec8a3cbe20d78  wifi: brcmfmac: Fix use-after-free bug in brcmf_cfg80211_detach

elapsed time: 1581m

configs tested: 111
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                               defconfig   gcc  
arc                               allnoconfig   gcc  
arc                          axs101_defconfig   gcc  
arc                                 defconfig   gcc  
arm                               allnoconfig   gcc  
arm                         at91_dt_defconfig   gcc  
arm                          gemini_defconfig   gcc  
arm                         lpc18xx_defconfig   gcc  
arm                           u8500_defconfig   gcc  
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
csky                              allnoconfig   gcc  
csky                                defconfig   gcc  
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386         buildonly-randconfig-001-20240119   gcc  
i386         buildonly-randconfig-002-20240119   gcc  
i386         buildonly-randconfig-003-20240119   gcc  
i386         buildonly-randconfig-004-20240119   gcc  
i386         buildonly-randconfig-005-20240119   gcc  
i386         buildonly-randconfig-006-20240119   gcc  
i386                  randconfig-001-20240119   gcc  
i386                  randconfig-002-20240119   gcc  
i386                  randconfig-003-20240119   gcc  
i386                  randconfig-004-20240119   gcc  
i386                  randconfig-005-20240119   gcc  
i386                  randconfig-006-20240119   gcc  
i386                  randconfig-011-20240119   clang
i386                  randconfig-012-20240119   clang
i386                  randconfig-013-20240119   clang
i386                  randconfig-014-20240119   clang
i386                  randconfig-015-20240119   clang
i386                  randconfig-016-20240119   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                          amiga_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                          hp300_defconfig   gcc  
m68k                            mac_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                        bcm47xx_defconfig   gcc  
mips                         bigsur_defconfig   gcc  
mips                         cobalt_defconfig   gcc  
mips                 decstation_r4k_defconfig   gcc  
mips                           ip28_defconfig   gcc  
mips                      loongson3_defconfig   gcc  
mips                           xway_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                   motionpro_defconfig   gcc  
powerpc                 mpc834x_itx_defconfig   gcc  
powerpc                     mpc83xx_defconfig   gcc  
powerpc                      ppc6xx_defconfig   gcc  
powerpc                     rainier_defconfig   gcc  
powerpc64                        alldefconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                    nommu_k210_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                        edosk7760_defconfig   gcc  
sh                            hp6xx_defconfig   gcc  
sh                          rsk7269_defconfig   gcc  
sh                           se7780_defconfig   gcc  
sh                  sh7785lcr_32bit_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                            allyesconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   clang
x86_64                                  kexec   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                  nommu_kc705_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

