Return-Path: <linux-wireless+bounces-1886-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 400E682D09A
	for <lists+linux-wireless@lfdr.de>; Sun, 14 Jan 2024 13:43:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB75528202B
	for <lists+linux-wireless@lfdr.de>; Sun, 14 Jan 2024 12:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF6D023B9;
	Sun, 14 Jan 2024 12:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H3rgaUDv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2AA23A6
	for <linux-wireless@vger.kernel.org>; Sun, 14 Jan 2024 12:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705236201; x=1736772201;
  h=date:from:to:cc:subject:message-id;
  bh=bKmSKiRXXFMRp56SGDlwEQWFHStxxpeegbk+LTEJV3c=;
  b=H3rgaUDvpbuybFmW009KFJBEu/bG7ynKCuDfrmGHGUc+7By0DMVNggxy
   n6UHgd9Sn8QX3ed3kWaAEvmJ6s2xIOA0Wxj1o4w0ZSG0N4ybV2cQTjb5B
   CewatJJzN4x5ScZp//vpEZgj/WIq92VF5PkkCEzzyXawmcqPI7Lc+PCCx
   An1PtqojHFq9huZOtIyK4r+Jz0fOXlj04iqzvVPh3woHKjh46PtplUeP1
   jLEyx+Pdz+YIFLnksQ2145XcxzLwYzJpOjSY9gcTmIXMp79jiSc2ZbQso
   iKObbcZjYhcQVx6b42ElTiKE+cr+/VirbEXLjzPZuHxkYhSPyxxFZO0mh
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10952"; a="20934493"
X-IronPort-AV: E=Sophos;i="6.04,194,1695711600"; 
   d="scan'208";a="20934493"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2024 04:43:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10952"; a="817559268"
X-IronPort-AV: E=Sophos;i="6.04,194,1695711600"; 
   d="scan'208";a="817559268"
Received: from lkp-server02.sh.intel.com (HELO b07ab15da5fe) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 14 Jan 2024 04:43:18 -0800
Received: from kbuild by b07ab15da5fe with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rOzpc-000BVW-0u;
	Sun, 14 Jan 2024 12:43:16 +0000
Date: Sun, 14 Jan 2024 20:43:03 +0800
From: kernel test robot <lkp@intel.com>
To: Kalle Valo <kvalo@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>,
 linux-wireless@vger.kernel.org
Subject: [wireless-next:main] BUILD SUCCESS
 178cc55d5129556e290cc05e152138037930419f
Message-ID: <202401142001.mn9TyDoU-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: 178cc55d5129556e290cc05e152138037930419f  wifi: rtlwifi: rtl_usb: Use sync register writes

elapsed time: 2575m

configs tested: 108
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240114   gcc  
arc                   randconfig-002-20240114   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                         bcm2835_defconfig   clang
arm                                 defconfig   clang
arm                           imxrt_defconfig   gcc  
arm                      integrator_defconfig   gcc  
arm                         lpc18xx_defconfig   gcc  
arm                   randconfig-001-20240114   clang
arm                   randconfig-002-20240114   clang
arm                   randconfig-003-20240114   clang
arm                   randconfig-004-20240114   clang
arm                        spear6xx_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240114   clang
arm64                 randconfig-002-20240114   clang
arm64                 randconfig-003-20240114   clang
arm64                 randconfig-004-20240114   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240114   gcc  
csky                  randconfig-002-20240114   gcc  
hexagon                           allnoconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240114   clang
hexagon               randconfig-002-20240114   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386                                defconfig   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240114   gcc  
loongarch             randconfig-002-20240114   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                        mvme147_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   clang
mips                             allyesconfig   gcc  
mips                           ip22_defconfig   gcc  
mips                malta_qemu_32r6_defconfig   clang
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240114   gcc  
nios2                 randconfig-002-20240114   gcc  
openrisc                         allyesconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                randconfig-001-20240114   gcc  
parisc                randconfig-002-20240114   gcc  
powerpc                          allmodconfig   clang
powerpc                          allyesconfig   clang
powerpc                    gamecube_defconfig   clang
powerpc                      ppc6xx_defconfig   gcc  
powerpc               randconfig-001-20240114   clang
powerpc               randconfig-002-20240114   clang
powerpc               randconfig-003-20240114   clang
powerpc                  storcenter_defconfig   gcc  
powerpc                     stx_gp3_defconfig   gcc  
powerpc64             randconfig-001-20240114   clang
powerpc64             randconfig-002-20240114   clang
powerpc64             randconfig-003-20240114   clang
riscv                            allmodconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                 randconfig-001-20240114   clang
riscv                 randconfig-002-20240114   clang
riscv                          rv32_defconfig   clang
s390                  randconfig-001-20240114   gcc  
s390                  randconfig-002-20240114   gcc  
sh                               alldefconfig   gcc  
sh                               allmodconfig   gcc  
sh                               j2_defconfig   gcc  
sh                    randconfig-001-20240114   gcc  
sh                    randconfig-002-20240114   gcc  
sh                           se7343_defconfig   gcc  
sh                           se7721_defconfig   gcc  
sparc64               randconfig-001-20240114   gcc  
sparc64               randconfig-002-20240114   gcc  
um                    randconfig-001-20240114   clang
um                    randconfig-002-20240114   clang
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64                              defconfig   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                randconfig-001-20240114   gcc  
xtensa                randconfig-002-20240114   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

