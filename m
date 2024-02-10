Return-Path: <linux-wireless+bounces-3412-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C35785034A
	for <lists+linux-wireless@lfdr.de>; Sat, 10 Feb 2024 08:34:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BACBB1C21025
	for <lists+linux-wireless@lfdr.de>; Sat, 10 Feb 2024 07:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 542EA1A27A;
	Sat, 10 Feb 2024 07:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fPJhib1E"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E1E7472
	for <linux-wireless@vger.kernel.org>; Sat, 10 Feb 2024 07:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707550452; cv=none; b=dLqDi6NWm9Z8WN37MaSyS+paSIGJnwq741+Lb7PQihT42zz3MOh2L9/P4HjgJQnRYHNpHGZZ2FXZy0B63tuQFUBpD3xGSm6vjaDRP6ZXOGLzgdLh17hpP9SeLjAME84kebxlHPryqAMslYNCDT/lg0sOJbLsOVX787P0O84VaL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707550452; c=relaxed/simple;
	bh=T7bF0uEGIh9M5hnIJxrEMwvsXC+JnVZzSBR+rdOcONw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=tBkaBiyV/iWX6GDiUHqUOYeEoVlYlVIOycrJYknWwkMtc2Zxq5Jh+FWihBZAZnnWkgNuyGb/7vWdI7j/cB7fwdUHk/bMe8Jm7eGn5FQKU/3C/w6lOq05NRT+AGU8Nd/ZR0c5nZOyqxqAQKvMphW2oS1uyeLZTxs2+rbhMsJFhao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fPJhib1E; arc=none smtp.client-ip=192.55.52.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707550450; x=1739086450;
  h=date:from:to:cc:subject:message-id;
  bh=T7bF0uEGIh9M5hnIJxrEMwvsXC+JnVZzSBR+rdOcONw=;
  b=fPJhib1EWrxC/JSIvo/Jkn74uOpsrrZzVKHqkxbEVNZWrIZ199m/Gp+B
   EvqLNh6MRLt+yminQP8aVedpI3npOQ91anIQvwaeUSj7HrEbe1FljMd06
   SEqpV8LVzuxPVNabMuvV+CVLJvifBC51FXWbyBFx2P9WoXY0MsmeYpHFH
   gkbVp6cCHJdyI2CjkKaLldiDuljuFCHmaY9s3nStotgpfbMHRodO+38Y6
   SdJlT7qZ+TBZBTFINus/22bCxTO7+UFOyIqTz3Y4KkjlEXue1Xvc8VvmJ
   eH1kTidg3hTUk+jv4U5jYrDgnOFjAVgPN7onHoE/dK4IJ3UYLfkY9gVhl
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10979"; a="436686940"
X-IronPort-AV: E=Sophos;i="6.05,259,1701158400"; 
   d="scan'208";a="436686940"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 23:34:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,259,1701158400"; 
   d="scan'208";a="6775799"
Received: from lkp-server01.sh.intel.com (HELO 01f0647817ea) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 09 Feb 2024 23:34:07 -0800
Received: from kbuild by 01f0647817ea with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rYhsD-0005Ri-0v;
	Sat, 10 Feb 2024 07:34:05 +0000
Date: Sat, 10 Feb 2024 15:33:46 +0800
From: kernel test robot <lkp@intel.com>
To: Johannes Berg <johannes.berg@intel.com>
Cc: Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org
Subject: [wireless-next:main] BUILD REGRESSION
 d4655db0a1e11eeacc55c44c81121c83b087982e
Message-ID: <202402101543.wVHFO31O-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: d4655db0a1e11eeacc55c44c81121c83b087982e  wifi: cfg80211: fix kernel-doc for cfg80211_chandef_primary

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202402091914.TvQ2OSQY-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

drivers/net/wireless/intel/iwlwifi/fw/uefi.c:359:6: error: redefinition of 'iwl_uefi_get_sgom_table'
drivers/net/wireless/intel/iwlwifi/fw/uefi.c:392:5: error: redefinition of 'iwl_uefi_get_uats_table'

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- arm-allmodconfig
|   |-- drivers-net-wireless-intel-iwlwifi-fw-uefi.c:error:redefinition-of-iwl_uefi_get_sgom_table
|   `-- drivers-net-wireless-intel-iwlwifi-fw-uefi.c:error:redefinition-of-iwl_uefi_get_uats_table
`-- arm-allyesconfig
    |-- drivers-net-wireless-intel-iwlwifi-fw-uefi.c:error:redefinition-of-iwl_uefi_get_sgom_table
    `-- drivers-net-wireless-intel-iwlwifi-fw-uefi.c:error:redefinition-of-iwl_uefi_get_uats_table

elapsed time: 1450m

configs tested: 166
configs skipped: 3

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                         haps_hs_defconfig   gcc  
arc                   randconfig-001-20240209   gcc  
arc                   randconfig-002-20240209   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                        mvebu_v5_defconfig   gcc  
arm                   randconfig-002-20240209   gcc  
arm                   randconfig-003-20240209   gcc  
arm                   randconfig-004-20240209   gcc  
arm                       spear13xx_defconfig   gcc  
arm                        vexpress_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240209   gcc  
csky                  randconfig-002-20240209   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240209   clang
i386         buildonly-randconfig-002-20240209   clang
i386         buildonly-randconfig-003-20240209   gcc  
i386         buildonly-randconfig-004-20240209   clang
i386         buildonly-randconfig-005-20240209   clang
i386         buildonly-randconfig-006-20240209   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240209   clang
i386                  randconfig-002-20240209   gcc  
i386                  randconfig-003-20240209   clang
i386                  randconfig-004-20240209   clang
i386                  randconfig-005-20240209   clang
i386                  randconfig-006-20240209   gcc  
i386                  randconfig-011-20240209   gcc  
i386                  randconfig-012-20240209   gcc  
i386                  randconfig-013-20240209   clang
i386                  randconfig-014-20240209   gcc  
i386                  randconfig-015-20240209   gcc  
i386                  randconfig-016-20240209   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240209   gcc  
loongarch             randconfig-002-20240209   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                       m5475evb_defconfig   gcc  
m68k                        stmark2_defconfig   gcc  
m68k                          sun3x_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
nios2                         3c120_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240209   gcc  
nios2                 randconfig-002-20240209   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240209   gcc  
parisc                randconfig-002-20240209   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                        fsp2_defconfig   gcc  
powerpc               randconfig-003-20240209   gcc  
riscv                            alldefconfig   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240209   gcc  
s390                  randconfig-002-20240209   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                          kfr2r09_defconfig   gcc  
sh                    randconfig-001-20240209   gcc  
sh                    randconfig-002-20240209   gcc  
sh                          rsk7201_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240209   gcc  
sparc64               randconfig-002-20240209   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                    randconfig-001-20240209   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240209   gcc  
x86_64       buildonly-randconfig-002-20240209   gcc  
x86_64       buildonly-randconfig-003-20240209   clang
x86_64       buildonly-randconfig-004-20240209   gcc  
x86_64       buildonly-randconfig-005-20240209   clang
x86_64       buildonly-randconfig-006-20240209   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240209   clang
x86_64                randconfig-002-20240209   gcc  
x86_64                randconfig-003-20240209   gcc  
x86_64                randconfig-004-20240209   clang
x86_64                randconfig-005-20240209   gcc  
x86_64                randconfig-006-20240209   gcc  
x86_64                randconfig-011-20240209   clang
x86_64                randconfig-012-20240209   clang
x86_64                randconfig-013-20240209   gcc  
x86_64                randconfig-014-20240209   clang
x86_64                randconfig-015-20240209   gcc  
x86_64                randconfig-016-20240209   clang
x86_64                randconfig-071-20240209   gcc  
x86_64                randconfig-072-20240209   clang
x86_64                randconfig-073-20240209   clang
x86_64                randconfig-074-20240209   gcc  
x86_64                randconfig-075-20240209   gcc  
x86_64                randconfig-076-20240209   clang
x86_64                           rhel-8.3-bpf   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                randconfig-001-20240209   gcc  
xtensa                randconfig-002-20240209   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

