Return-Path: <linux-wireless+bounces-4661-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39AF987A1FC
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Mar 2024 04:51:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAFD71F237DD
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Mar 2024 03:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B37101DE;
	Wed, 13 Mar 2024 03:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H2ljax6q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F342C13D
	for <linux-wireless@vger.kernel.org>; Wed, 13 Mar 2024 03:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710301896; cv=none; b=hQIET1ibsotMVt+vXI4fhlY2XN32EDdxZR+Ja0+LupijNNa1ej/IXW/G2oHEyDlx4nHOv5DCIhAvADeDOy+r5I7Ls7aaXY7jfPZtW0vVbs87/B2eE3IaOsEW8iiabzy8hwpcdSdO90xPbseSSw1n1KV/0xbAE1tvACufOnbLTQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710301896; c=relaxed/simple;
	bh=VRn5QcWYK1xMQei7lA9hS8DGSuGHrKg/GS5e5vmrI2s=;
	h=Date:From:To:Cc:Subject:Message-ID; b=aBopgY88/yPXdP/fOfRASzTXsmeqwlpykjAKNlJF0Y1zDl5a8rTUr0HCmH2VINCfkQvhYdwVhV3TIxuUUyj+W6tCUy9grBCm9OqNFG4Ain0EDpYYway6PPWIXoe6qbJJGPt/+DL8N9KDKqRiOUeazypMzJoz4PtQ/QbkmGRioVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H2ljax6q; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710301894; x=1741837894;
  h=date:from:to:cc:subject:message-id;
  bh=VRn5QcWYK1xMQei7lA9hS8DGSuGHrKg/GS5e5vmrI2s=;
  b=H2ljax6qEN0MliAp6Sg8UO1/Ou7T25m/w9aMNT8hIIUL3YJdh+oeg4+U
   V1XIGZeIus7Q2ni7eXLFui/As8ZRIYR+OCdc/Pxs1038kAq3xWFTwCu4q
   QcSSN+HvEVYZ58WhrNaHMWBPF7LEU1M/OIVR1NVg2qHgyBk/52CEnEM80
   s9YjDkr9otKbO2p+gEBDlIbKmzeH42gYG8KgJxlo1CPz5FtjcYmZhMgg0
   Kq9wmwWFtRovI89hWJJFld40/WwPublCPhi9FqO2HGQVCnBiVNBx4PQQR
   m+MQvp7m66NKvtnnPpvkTTBJKbuDxdggCGFklP/83yQr7A2cBdgD2kHhs
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="8858892"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="8858892"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 20:51:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="42768045"
Received: from lkp-server01.sh.intel.com (HELO b21307750695) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 12 Mar 2024 20:51:32 -0700
Received: from kbuild by b21307750695 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rkFeM-000ByL-0v;
	Wed, 13 Mar 2024 03:51:30 +0000
Date: Wed, 13 Mar 2024 11:50:58 +0800
From: kernel test robot <lkp@intel.com>
To: Kalle Valo <kvalo@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>,
 linux-wireless@vger.kernel.org
Subject: [wireless-next:main] BUILD REGRESSION
 e27b02e23a701e5761f1d6028643e1203a1c56de
Message-ID: <202403131152.cibo50S0-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: e27b02e23a701e5761f1d6028643e1203a1c56de  ssb: drop use of non-existing CONFIG_SSB_DEBUG symbol

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202403130633.muvbu9ev-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202403130705.xI2y4Nym-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202403130717.TWm17FiD-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202403130813.Dz0M53DR-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

drivers/ssb/main.c:1148:10: error: label at end of compound statement: expected statement
drivers/ssb/main.c:1148:2: error: label at end of compound statement
drivers/ssb/main.c:1149:2: warning: label at end of compound statement is a C23 extension [-Wc23-extensions]
drivers/ssb/main.c:1149:2: warning: label at end of compound statement is a C2x extension [-Wc2x-extensions]

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
`-- i386-buildonly-randconfig-006-20240313
    `-- drivers-ssb-main.c:error:label-at-end-of-compound-statement
clang_recent_errors
|-- arm-randconfig-004-20240313
|   `-- drivers-ssb-main.c:error:label-at-end-of-compound-statement:expected-statement
|-- arm64-allmodconfig
|   `-- drivers-ssb-main.c:warning:label-at-end-of-compound-statement-is-a-C23-extension-Wc23-extensions
|-- hexagon-allyesconfig
|   `-- drivers-ssb-main.c:warning:label-at-end-of-compound-statement-is-a-C23-extension-Wc23-extensions
`-- i386-buildonly-randconfig-004-20240313
    `-- drivers-ssb-main.c:warning:label-at-end-of-compound-statement-is-a-C2x-extension-Wc2x-extensions

elapsed time: 726m

configs tested: 154
configs skipped: 3

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240313   gcc  
arc                   randconfig-002-20240313   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                     am200epdkit_defconfig   gcc  
arm                        clps711x_defconfig   clang
arm                     davinci_all_defconfig   clang
arm                                 defconfig   clang
arm                          pxa910_defconfig   gcc  
arm                   randconfig-001-20240313   gcc  
arm                   randconfig-002-20240313   clang
arm                   randconfig-003-20240313   gcc  
arm                   randconfig-004-20240313   clang
arm                           stm32_defconfig   gcc  
arm                       versatile_defconfig   gcc  
arm                         wpcm450_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240313   clang
arm64                 randconfig-002-20240313   clang
arm64                 randconfig-003-20240313   clang
arm64                 randconfig-004-20240313   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240313   gcc  
csky                  randconfig-002-20240313   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240313   clang
hexagon               randconfig-002-20240313   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240313   gcc  
i386         buildonly-randconfig-002-20240313   gcc  
i386         buildonly-randconfig-003-20240313   clang
i386         buildonly-randconfig-004-20240313   clang
i386         buildonly-randconfig-005-20240313   clang
i386         buildonly-randconfig-006-20240313   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240313   clang
i386                  randconfig-002-20240313   clang
i386                  randconfig-003-20240313   clang
i386                  randconfig-004-20240313   gcc  
i386                  randconfig-005-20240313   gcc  
i386                  randconfig-006-20240313   clang
i386                  randconfig-011-20240313   gcc  
i386                  randconfig-012-20240313   clang
i386                  randconfig-013-20240313   gcc  
i386                  randconfig-014-20240313   gcc  
i386                  randconfig-015-20240313   clang
i386                  randconfig-016-20240313   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240313   gcc  
loongarch             randconfig-002-20240313   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                         amcore_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                       m5475evb_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                     cu1830-neo_defconfig   gcc  
mips                      maltaaprp_defconfig   clang
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240313   gcc  
nios2                 randconfig-002-20240313   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240313   gcc  
parisc                randconfig-002-20240313   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                 mpc832x_rdb_defconfig   gcc  
powerpc               mpc834x_itxgp_defconfig   clang
powerpc               randconfig-001-20240313   gcc  
powerpc               randconfig-002-20240313   gcc  
powerpc               randconfig-003-20240313   clang
powerpc64             randconfig-001-20240313   clang
powerpc64             randconfig-002-20240313   gcc  
powerpc64             randconfig-003-20240313   clang
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240313   clang
riscv                 randconfig-002-20240313   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240313   gcc  
s390                  randconfig-002-20240313   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                     magicpanelr2_defconfig   gcc  
sh                    randconfig-001-20240313   gcc  
sh                    randconfig-002-20240313   gcc  
sh                            titan_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240313   gcc  
sparc64               randconfig-002-20240313   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240313   gcc  
um                    randconfig-002-20240313   clang
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64                              defconfig   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                          iss_defconfig   gcc  
xtensa                randconfig-001-20240313   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

