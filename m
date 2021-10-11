Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32ECD4296F1
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Oct 2021 20:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233456AbhJKScq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 11 Oct 2021 14:32:46 -0400
Received: from mga11.intel.com ([192.55.52.93]:4420 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231497AbhJKScn (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 11 Oct 2021 14:32:43 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10134"; a="224354135"
X-IronPort-AV: E=Sophos;i="5.85,365,1624345200"; 
   d="scan'208";a="224354135"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2021 11:30:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,365,1624345200"; 
   d="scan'208";a="658762102"
Received: from lkp-server02.sh.intel.com (HELO 08b2c502c3de) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 11 Oct 2021 11:30:41 -0700
Received: from kbuild by 08b2c502c3de with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1ma04P-0002b5-0i; Mon, 11 Oct 2021 18:30:41 +0000
Date:   Tue, 12 Oct 2021 02:29:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
Subject: [kvalo-wireless-drivers-next:master] BUILD SUCCESS
 9b793db5fca44d01f72d3564a168171acf7c4076
Message-ID: <6164829c.KEF4dP+uCiUZd5/7%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next.git master
branch HEAD: 9b793db5fca44d01f72d3564a168171acf7c4076  b43: fix a lower bounds test

elapsed time: 720m

configs tested: 151
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                              allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
i386                 randconfig-c001-20211011
sh                           se7206_defconfig
powerpc                      pcm030_defconfig
sh                        edosk7760_defconfig
arc                      axs103_smp_defconfig
mips                          rm200_defconfig
arm                       cns3420vb_defconfig
arm                         orion5x_defconfig
sh                               alldefconfig
nios2                         10m50_defconfig
arm                        realview_defconfig
arm                        multi_v5_defconfig
riscv                               defconfig
sh                     magicpanelr2_defconfig
powerpc                     tqm8541_defconfig
mips                     cu1830-neo_defconfig
arm                            lart_defconfig
riscv                            alldefconfig
powerpc                     tqm8555_defconfig
powerpc                       eiger_defconfig
arm                         at91_dt_defconfig
arm                             mxs_defconfig
mips                    maltaup_xpa_defconfig
mips                        maltaup_defconfig
parisc                generic-32bit_defconfig
microblaze                          defconfig
sh                        sh7785lcr_defconfig
mips                           ip22_defconfig
arm                          ep93xx_defconfig
riscv             nommu_k210_sdcard_defconfig
xtensa                    xip_kc705_defconfig
powerpc                 linkstation_defconfig
arc                         haps_hs_defconfig
m68k                       m5249evb_defconfig
mips                        vocore2_defconfig
mips                         tb0287_defconfig
mips                        workpad_defconfig
arc                     haps_hs_smp_defconfig
powerpc                     asp8347_defconfig
arm                        mini2440_defconfig
h8300                            alldefconfig
arm                         cm_x300_defconfig
sh                           se7751_defconfig
arm                         vf610m4_defconfig
m68k                        m5272c3_defconfig
mips                          ath79_defconfig
powerpc                    sam440ep_defconfig
m68k                         apollo_defconfig
mips                           xway_defconfig
sh                     sh7710voipgw_defconfig
openrisc                 simple_smp_defconfig
arm                     davinci_all_defconfig
sh                          sdk7780_defconfig
powerpc                   microwatt_defconfig
powerpc                     mpc512x_defconfig
sh                        sh7757lcr_defconfig
powerpc                 mpc8315_rdb_defconfig
nios2                               defconfig
nds32                            alldefconfig
sh                      rts7751r2d1_defconfig
ia64                        generic_defconfig
xtensa                    smp_lx200_defconfig
arm                          moxart_defconfig
m68k                        m5307c3_defconfig
arm                         lubbock_defconfig
mips                            gpr_defconfig
arm                  randconfig-c002-20211011
x86_64               randconfig-c001-20211011
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allmodconfig
m68k                             allyesconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
nios2                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                             allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
x86_64               randconfig-a015-20211011
x86_64               randconfig-a012-20211011
x86_64               randconfig-a016-20211011
x86_64               randconfig-a014-20211011
x86_64               randconfig-a013-20211011
x86_64               randconfig-a011-20211011
i386                 randconfig-a016-20211011
i386                 randconfig-a014-20211011
i386                 randconfig-a011-20211011
i386                 randconfig-a015-20211011
i386                 randconfig-a012-20211011
i386                 randconfig-a013-20211011
arc                  randconfig-r043-20211011
s390                 randconfig-r044-20211011
riscv                randconfig-r042-20211011
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                          rv32_defconfig
riscv                            allyesconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec
x86_64                           allyesconfig

clang tested configs:
arm                  randconfig-c002-20211011
mips                 randconfig-c004-20211011
i386                 randconfig-c001-20211011
s390                 randconfig-c005-20211011
x86_64               randconfig-c007-20211011
powerpc              randconfig-c003-20211011
riscv                randconfig-c006-20211011
x86_64               randconfig-a004-20211011
x86_64               randconfig-a006-20211011
x86_64               randconfig-a001-20211011
x86_64               randconfig-a005-20211011
x86_64               randconfig-a002-20211011
x86_64               randconfig-a003-20211011
i386                 randconfig-a001-20211011
i386                 randconfig-a003-20211011
i386                 randconfig-a004-20211011
i386                 randconfig-a005-20211011
i386                 randconfig-a002-20211011
i386                 randconfig-a006-20211011
hexagon              randconfig-r041-20211011
hexagon              randconfig-r045-20211011

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
