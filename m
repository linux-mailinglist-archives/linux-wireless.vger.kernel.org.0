Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70F2E2D23B1
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Dec 2020 07:37:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725777AbgLHGgo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Dec 2020 01:36:44 -0500
Received: from mga05.intel.com ([192.55.52.43]:39428 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725208AbgLHGgo (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Dec 2020 01:36:44 -0500
IronPort-SDR: fsd0rbkNb6B286Vzh2aryWlpNXhrBR2s1wVmZmXe/5FVzdrCRa3OhD8r8S+mfUjsfT2WzfVayt
 JJdC3v4PsZTQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9828"; a="258548154"
X-IronPort-AV: E=Sophos;i="5.78,401,1599548400"; 
   d="scan'208";a="258548154"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2020 22:36:03 -0800
IronPort-SDR: SVLacc2xkbQLkfrRxOSXgTVdbiBmXoyltg3cwYv01NGq8aaDOMMwW+jl5GJUaAMNns3KXgnLBj
 mzbxXPiJ3WdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,401,1599548400"; 
   d="scan'208";a="370254716"
Received: from lkp-server01.sh.intel.com (HELO c88bd47c8831) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 07 Dec 2020 22:36:02 -0800
Received: from kbuild by c88bd47c8831 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kmWbR-00002C-J6; Tue, 08 Dec 2020 06:36:01 +0000
Date:   Tue, 08 Dec 2020 14:35:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
Subject: [wireless-drivers-next:master] BUILD REGRESSION
 871a825c3902247d7fcc06e81eb993194d3bf424
Message-ID: <5fcf1ec9.uZFQK280c8TViyrM%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next.git  master
branch HEAD: 871a825c3902247d7fcc06e81eb993194d3bf424  brcmfmac: remove redundant assignment to pointer 'entry'

Error/Warning reports:

https://lore.kernel.org/linux-wireless/202012080726.z6M9DkUt-lkp@intel.com

Error/Warning in current branch:

mips-linux-ld: drivers/net/wireless/realtek/rtw88/rtw8822ce.o:(.rodata.rtw_pm_ops+0x0): multiple definition of `rtw_pm_ops'; drivers/net/wireless/realtek/rtw88/rtw8822be.o:(.rodata.rtw_pm_ops+0x0): first defined here

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
`-- mips-allyesconfig
    `-- multiple-definition-of-rtw_pm_ops-drivers-net-wireless-realtek-rtw88-rtw8822be.o:(.rodata.rtw_pm_ops):first-defined-here

elapsed time: 725m

configs tested: 127
configs skipped: 2

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                      walnut_defconfig
arm                         palmz72_defconfig
arm                          simpad_defconfig
powerpc                     tqm8555_defconfig
arc                          axs103_defconfig
nds32                               defconfig
powerpc                  mpc885_ads_defconfig
mips                           ip28_defconfig
powerpc                     pq2fads_defconfig
powerpc                 mpc832x_rdb_defconfig
c6x                         dsk6455_defconfig
m68k                        m5272c3_defconfig
m68k                          hp300_defconfig
s390                          debug_defconfig
arm                             ezx_defconfig
mips                            gpr_defconfig
microblaze                          defconfig
microblaze                    nommu_defconfig
powerpc                   motionpro_defconfig
arm                       imx_v4_v5_defconfig
powerpc                 mpc834x_itx_defconfig
powerpc                         wii_defconfig
mips                         cobalt_defconfig
m68k                        stmark2_defconfig
arm                     eseries_pxa_defconfig
arm                          pcm027_defconfig
powerpc                      makalu_defconfig
sh                          rsk7201_defconfig
mips                         rt305x_defconfig
powerpc                   lite5200b_defconfig
arm                         mv78xx0_defconfig
powerpc                   currituck_defconfig
sparc                       sparc32_defconfig
sh                   rts7751r2dplus_defconfig
arm                       omap2plus_defconfig
arm                         lpc18xx_defconfig
sh                          sdk7780_defconfig
m68k                       m5275evb_defconfig
mips                         tb0287_defconfig
m68k                             alldefconfig
arm                           omap1_defconfig
um                            kunit_defconfig
xtensa                    xip_kc705_defconfig
m68k                       m5475evb_defconfig
mips                malta_qemu_32r6_defconfig
m68k                       m5249evb_defconfig
powerpc                     kilauea_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a004-20201208
i386                 randconfig-a005-20201208
i386                 randconfig-a001-20201208
i386                 randconfig-a002-20201208
i386                 randconfig-a006-20201208
i386                 randconfig-a003-20201208
i386                 randconfig-a005-20201207
i386                 randconfig-a004-20201207
i386                 randconfig-a001-20201207
i386                 randconfig-a002-20201207
i386                 randconfig-a006-20201207
i386                 randconfig-a003-20201207
x86_64               randconfig-a016-20201207
x86_64               randconfig-a012-20201207
x86_64               randconfig-a014-20201207
x86_64               randconfig-a013-20201207
x86_64               randconfig-a015-20201207
x86_64               randconfig-a011-20201207
i386                 randconfig-a014-20201207
i386                 randconfig-a013-20201207
i386                 randconfig-a011-20201207
i386                 randconfig-a015-20201207
i386                 randconfig-a012-20201207
i386                 randconfig-a016-20201207
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a004-20201207
x86_64               randconfig-a006-20201207
x86_64               randconfig-a002-20201207
x86_64               randconfig-a001-20201207
x86_64               randconfig-a005-20201207
x86_64               randconfig-a003-20201207

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
