Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23D6D2B51ED
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Nov 2020 21:06:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731551AbgKPUFS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 16 Nov 2020 15:05:18 -0500
Received: from mga05.intel.com ([192.55.52.43]:10486 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726487AbgKPUFS (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 16 Nov 2020 15:05:18 -0500
IronPort-SDR: O+xtlkP+SFbrRrP+XWdEU+j6PZVpJHSQZZpKOwmZy2+0DsKrLQj5Sv140XQw4MbN7KSKn5/J/G
 4PwLCPQgL3Uw==
X-IronPort-AV: E=McAfee;i="6000,8403,9807"; a="255520224"
X-IronPort-AV: E=Sophos;i="5.77,483,1596524400"; 
   d="scan'208";a="255520224"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2020 12:05:05 -0800
IronPort-SDR: yetXj1gGnaBP5rXSGUGV0igwqE0UNL05j1V/xlVtGsdYYLMMQxVjuP8delcAqiJ5X7ht0OHLMX
 i8dfqmzfuJbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,483,1596524400"; 
   d="scan'208";a="358595216"
Received: from lkp-server01.sh.intel.com (HELO fb398427a497) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 16 Nov 2020 12:05:03 -0800
Received: from kbuild by fb398427a497 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kekkJ-0000C7-2Y; Mon, 16 Nov 2020 20:05:03 +0000
Date:   Tue, 17 Nov 2020 04:04:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     linux-wireless@vger.kernel.org
Subject: [mac80211:master] BUILD SUCCESS
 849920c703392957f94023f77ec89ca6cf119d43
Message-ID: <5fb2db49.gj2bi/BVdnFpY0GU%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211.git  master
branch HEAD: 849920c703392957f94023f77ec89ca6cf119d43  devlink: Add missing genlmsg_cancel() in devlink_nl_sb_port_pool_fill()

elapsed time: 2550m

configs tested: 265
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
powerpc                    amigaone_defconfig
powerpc                 xes_mpc85xx_defconfig
powerpc                      mgcoge_defconfig
arc                        nsim_700_defconfig
arm                           omap1_defconfig
c6x                        evmc6474_defconfig
sh                   sh7770_generic_defconfig
powerpc                       eiger_defconfig
powerpc                     tqm8548_defconfig
sh                        sh7757lcr_defconfig
s390                                defconfig
arm                       omap2plus_defconfig
sh                           se7722_defconfig
mips                             allyesconfig
m68k                       m5249evb_defconfig
m68k                         amcore_defconfig
powerpc                     tqm8560_defconfig
arm                         lpc32xx_defconfig
mips                            e55_defconfig
openrisc                 simple_smp_defconfig
sh                          rsk7203_defconfig
arm                       netwinder_defconfig
arm                     am200epdkit_defconfig
mips                           gcw0_defconfig
powerpc                 mpc834x_itx_defconfig
powerpc                     mpc512x_defconfig
sh                        sh7785lcr_defconfig
arm                        oxnas_v6_defconfig
sh                          r7785rp_defconfig
powerpc                         wii_defconfig
arm                           h5000_defconfig
mips                      loongson3_defconfig
mips                           ip27_defconfig
sh                          r7780mp_defconfig
s390                             alldefconfig
powerpc                      pmac32_defconfig
arc                        nsimosci_defconfig
mips                            ar7_defconfig
arc                            hsdk_defconfig
sh                        apsh4ad0a_defconfig
powerpc                     ksi8560_defconfig
powerpc                  mpc866_ads_defconfig
arm                       mainstone_defconfig
um                           x86_64_defconfig
arm                        magician_defconfig
m68k                        m5272c3_defconfig
arm                        spear3xx_defconfig
arm                         shannon_defconfig
sh                 kfr2r09-romimage_defconfig
arm                          iop32x_defconfig
sh                           sh2007_defconfig
mips                     loongson1b_defconfig
mips                      pic32mzda_defconfig
mips                    maltaup_xpa_defconfig
m68k                        stmark2_defconfig
powerpc                 mpc836x_mds_defconfig
sh                         ap325rxa_defconfig
sh                         apsh4a3a_defconfig
arc                                 defconfig
sh                      rts7751r2d1_defconfig
riscv                    nommu_k210_defconfig
arm                     eseries_pxa_defconfig
mips                      malta_kvm_defconfig
arm                           viper_defconfig
sh                          sdk7780_defconfig
arc                 nsimosci_hs_smp_defconfig
sh                          sdk7786_defconfig
ia64                        generic_defconfig
ia64                          tiger_defconfig
mips                       capcella_defconfig
mips                        nlm_xlr_defconfig
sh                        dreamcast_defconfig
arm                        shmobile_defconfig
openrisc                            defconfig
sh                         microdev_defconfig
sh                             espt_defconfig
powerpc                     tqm8555_defconfig
powerpc                     ep8248e_defconfig
sparc64                          alldefconfig
powerpc                 mpc837x_mds_defconfig
s390                          debug_defconfig
powerpc                    ge_imp3a_defconfig
powerpc                  storcenter_defconfig
powerpc                 mpc837x_rdb_defconfig
arm                    vt8500_v6_v7_defconfig
mips                     cu1830-neo_defconfig
ia64                                defconfig
sh                        edosk7760_defconfig
mips                         tb0226_defconfig
arc                          axs101_defconfig
m68k                             allmodconfig
powerpc                     sbc8548_defconfig
powerpc                 mpc8540_ads_defconfig
mips                         db1xxx_defconfig
mips                        jmr3927_defconfig
mips                        bcm47xx_defconfig
arm                         orion5x_defconfig
openrisc                         alldefconfig
powerpc                      cm5200_defconfig
mips                          malta_defconfig
powerpc                      ppc40x_defconfig
microblaze                          defconfig
arm                          prima2_defconfig
arm                        mvebu_v5_defconfig
powerpc                      acadia_defconfig
mips                       bmips_be_defconfig
sh                            migor_defconfig
openrisc                    or1ksim_defconfig
nds32                            alldefconfig
arm                          badge4_defconfig
um                            kunit_defconfig
powerpc                    sam440ep_defconfig
mips                         tb0287_defconfig
arc                    vdk_hs38_smp_defconfig
arm                          pxa168_defconfig
mips                  cavium_octeon_defconfig
mips                           ip28_defconfig
x86_64                           alldefconfig
sh                           se7721_defconfig
sparc                       sparc64_defconfig
mips                       rbtx49xx_defconfig
powerpc               mpc834x_itxgp_defconfig
mips                           xway_defconfig
alpha                               defconfig
riscv                             allnoconfig
m68k                          hp300_defconfig
arm                          gemini_defconfig
arm                      tct_hammer_defconfig
arm                       aspeed_g4_defconfig
arc                         haps_hs_defconfig
arm                         vf610m4_defconfig
arm                       versatile_defconfig
sh                           se7619_defconfig
powerpc                      walnut_defconfig
alpha                            allyesconfig
h8300                               defconfig
arm                         s3c6400_defconfig
arm                            lart_defconfig
mips                          ath25_defconfig
microblaze                      mmu_defconfig
arm                            zeus_defconfig
sh                               alldefconfig
arm                           h3600_defconfig
arm                        neponset_defconfig
xtensa                  nommu_kc705_defconfig
mips                malta_kvm_guest_defconfig
mips                         bigsur_defconfig
m68k                       m5275evb_defconfig
sh                           se7343_defconfig
arm                        mvebu_v7_defconfig
ia64                            zx1_defconfig
i386                             allyesconfig
powerpc                     pq2fads_defconfig
xtensa                  audio_kc705_defconfig
arm                        vexpress_defconfig
arm                         axm55xx_defconfig
sh                          landisk_defconfig
m68k                         apollo_defconfig
sh                           se7712_defconfig
sh                          kfr2r09_defconfig
arm                       multi_v4t_defconfig
arm                          ixp4xx_defconfig
sh                          polaris_defconfig
mips                          rm200_defconfig
arm                       spear13xx_defconfig
powerpc                      chrp32_defconfig
arm                          moxart_defconfig
powerpc                      arches_defconfig
sh                          lboxre2_defconfig
sh                           se7724_defconfig
mips                        bcm63xx_defconfig
mips                  decstation_64_defconfig
xtensa                              defconfig
powerpc                 mpc8272_ads_defconfig
m68k                          sun3x_defconfig
arm                          collie_defconfig
ia64                         bigsur_defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
xtensa                           allyesconfig
h8300                            allyesconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
parisc                           allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a003-20201116
x86_64               randconfig-a005-20201116
x86_64               randconfig-a004-20201116
x86_64               randconfig-a002-20201116
x86_64               randconfig-a001-20201116
x86_64               randconfig-a006-20201116
i386                 randconfig-a006-20201115
i386                 randconfig-a005-20201115
i386                 randconfig-a001-20201115
i386                 randconfig-a002-20201115
i386                 randconfig-a004-20201115
i386                 randconfig-a003-20201115
i386                 randconfig-a006-20201116
i386                 randconfig-a005-20201116
i386                 randconfig-a001-20201116
i386                 randconfig-a002-20201116
i386                 randconfig-a004-20201116
i386                 randconfig-a003-20201116
x86_64               randconfig-a015-20201115
x86_64               randconfig-a011-20201115
x86_64               randconfig-a014-20201115
x86_64               randconfig-a013-20201115
x86_64               randconfig-a016-20201115
x86_64               randconfig-a012-20201115
i386                 randconfig-a012-20201115
i386                 randconfig-a014-20201115
i386                 randconfig-a016-20201115
i386                 randconfig-a011-20201115
i386                 randconfig-a015-20201115
i386                 randconfig-a013-20201115
i386                 randconfig-a012-20201116
i386                 randconfig-a014-20201116
i386                 randconfig-a016-20201116
i386                 randconfig-a011-20201116
i386                 randconfig-a015-20201116
i386                 randconfig-a013-20201116
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
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
x86_64               randconfig-a003-20201115
x86_64               randconfig-a005-20201115
x86_64               randconfig-a004-20201115
x86_64               randconfig-a002-20201115
x86_64               randconfig-a001-20201115
x86_64               randconfig-a006-20201115
x86_64               randconfig-a015-20201116
x86_64               randconfig-a011-20201116
x86_64               randconfig-a014-20201116
x86_64               randconfig-a013-20201116
x86_64               randconfig-a016-20201116
x86_64               randconfig-a012-20201116

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
