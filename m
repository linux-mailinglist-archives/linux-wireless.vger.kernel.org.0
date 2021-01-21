Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E5AD2FE67C
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Jan 2021 10:38:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728896AbhAUJhs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 Jan 2021 04:37:48 -0500
Received: from mga12.intel.com ([192.55.52.136]:43469 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728870AbhAUJhm (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 Jan 2021 04:37:42 -0500
IronPort-SDR: 5vdUmemXR8vDZvVuQPrdy4KWegt1+6A6ByWlLGUOZhlM6TzMG90EAeLdhWX6oB7FLVqR/crkW5
 MBiosztjUsZQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9870"; a="158422662"
X-IronPort-AV: E=Sophos;i="5.79,363,1602572400"; 
   d="scan'208";a="158422662"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2021 01:36:59 -0800
IronPort-SDR: c6lWl/hU8ih+nvzTeftlS/ozKG9sgD/py5UeBBrG9nu8XXzY94w0D5n9oHlJgG4Q6u4Mc7kPO7
 YAeYbI6HkmoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,363,1602572400"; 
   d="scan'208";a="467402145"
Received: from lkp-server01.sh.intel.com (HELO 260eafd5ecd0) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 21 Jan 2021 01:36:58 -0800
Received: from kbuild by 260eafd5ecd0 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1l2WOf-0006QO-Iz; Thu, 21 Jan 2021 09:36:57 +0000
Date:   Thu, 21 Jan 2021 17:36:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     linux-wireless@vger.kernel.org
Subject: [mac80211-next:master] BUILD SUCCESS
 0fe2f273ab892bbba3f8d85e3f237bc0802e5709
Message-ID: <60094b15.CNNp4Hy9gQ0Ie3hN%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211-next.git master
branch HEAD: 0fe2f273ab892bbba3f8d85e3f237bc0802e5709  Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net

elapsed time: 727m

configs tested: 199
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
alpha                            alldefconfig
arm                           stm32_defconfig
sparc64                             defconfig
arm                   milbeaut_m10v_defconfig
powerpc                     kilauea_defconfig
sh                     magicpanelr2_defconfig
arc                          axs101_defconfig
sh                   sh7770_generic_defconfig
c6x                              alldefconfig
arm                             pxa_defconfig
mips                        maltaup_defconfig
powerpc                  storcenter_defconfig
powerpc                 mpc836x_mds_defconfig
arm                              alldefconfig
arm                     davinci_all_defconfig
mips                        omega2p_defconfig
sh                        dreamcast_defconfig
powerpc                     ppa8548_defconfig
sh                           se7780_defconfig
mips                        workpad_defconfig
sh                                  defconfig
arm                          gemini_defconfig
mips                           jazz_defconfig
arm                           spitz_defconfig
sh                            titan_defconfig
arm                        mini2440_defconfig
mips                        nlm_xlr_defconfig
powerpc                 mpc834x_mds_defconfig
xtensa                  cadence_csp_defconfig
sh                 kfr2r09-romimage_defconfig
mips                    maltaup_xpa_defconfig
arc                           tb10x_defconfig
powerpc                         wii_defconfig
mips                        vocore2_defconfig
arm                          moxart_defconfig
powerpc                      acadia_defconfig
powerpc                       eiger_defconfig
arm                          pxa910_defconfig
m68k                        stmark2_defconfig
arm                        multi_v7_defconfig
arm                    vt8500_v6_v7_defconfig
arm                         cm_x300_defconfig
powerpc                    amigaone_defconfig
openrisc                            defconfig
powerpc                 mpc832x_mds_defconfig
arm                       imx_v4_v5_defconfig
mips                malta_qemu_32r6_defconfig
mips                            e55_defconfig
arm                          pcm027_defconfig
arc                        nsim_700_defconfig
m68k                           sun3_defconfig
sh                  sh7785lcr_32bit_defconfig
mips                       lemote2f_defconfig
mips                   sb1250_swarm_defconfig
sh                           se7724_defconfig
mips                     decstation_defconfig
mips                         bigsur_defconfig
xtensa                              defconfig
sparc                               defconfig
h8300                    h8300h-sim_defconfig
arm                         nhk8815_defconfig
mips                           ip27_defconfig
arm                       spear13xx_defconfig
m68k                          multi_defconfig
xtensa                  nommu_kc705_defconfig
powerpc                 mpc834x_itx_defconfig
mips                            ar7_defconfig
ia64                        generic_defconfig
mips                        jmr3927_defconfig
c6x                         dsk6455_defconfig
powerpc                     pseries_defconfig
mips                           rs90_defconfig
mips                       bmips_be_defconfig
sh                        edosk7705_defconfig
xtensa                         virt_defconfig
i386                             alldefconfig
arm                           sunxi_defconfig
arc                     haps_hs_smp_defconfig
sh                        edosk7760_defconfig
sparc64                          alldefconfig
arm                             ezx_defconfig
powerpc                      arches_defconfig
powerpc                       ppc64_defconfig
mips                      pistachio_defconfig
powerpc                 mpc837x_mds_defconfig
arm                        oxnas_v6_defconfig
sh                      rts7751r2d1_defconfig
h8300                     edosk2674_defconfig
h8300                            alldefconfig
powerpc                        icon_defconfig
powerpc                      ppc44x_defconfig
sh                           se7721_defconfig
sparc                            alldefconfig
ia64                          tiger_defconfig
mips                          malta_defconfig
powerpc                        cell_defconfig
mips                        nlm_xlp_defconfig
csky                             alldefconfig
arm                         mv78xx0_defconfig
mips                           ip32_defconfig
mips                      maltasmvp_defconfig
mips                           gcw0_defconfig
xtensa                generic_kc705_defconfig
sh                        sh7763rdp_defconfig
powerpc                      ppc6xx_defconfig
mips                           ip22_defconfig
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
nds32                               defconfig
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
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a002-20210121
x86_64               randconfig-a003-20210121
x86_64               randconfig-a001-20210121
x86_64               randconfig-a005-20210121
x86_64               randconfig-a006-20210121
x86_64               randconfig-a004-20210121
i386                 randconfig-a001-20210121
i386                 randconfig-a002-20210121
i386                 randconfig-a004-20210121
i386                 randconfig-a006-20210121
i386                 randconfig-a005-20210121
i386                 randconfig-a003-20210121
i386                 randconfig-a001-20210120
i386                 randconfig-a002-20210120
i386                 randconfig-a004-20210120
i386                 randconfig-a006-20210120
i386                 randconfig-a005-20210120
i386                 randconfig-a003-20210120
x86_64               randconfig-a012-20210120
x86_64               randconfig-a015-20210120
x86_64               randconfig-a016-20210120
x86_64               randconfig-a011-20210120
x86_64               randconfig-a013-20210120
x86_64               randconfig-a014-20210120
i386                 randconfig-a013-20210120
i386                 randconfig-a011-20210120
i386                 randconfig-a012-20210120
i386                 randconfig-a014-20210120
i386                 randconfig-a015-20210120
i386                 randconfig-a016-20210120
i386                 randconfig-a013-20210121
i386                 randconfig-a011-20210121
i386                 randconfig-a012-20210121
i386                 randconfig-a014-20210121
i386                 randconfig-a015-20210121
i386                 randconfig-a016-20210121
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
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a002-20210120
x86_64               randconfig-a003-20210120
x86_64               randconfig-a001-20210120
x86_64               randconfig-a005-20210120
x86_64               randconfig-a006-20210120
x86_64               randconfig-a004-20210120

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
