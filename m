Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3A224EC409
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Mar 2022 14:30:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345471AbiC3Mah (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 30 Mar 2022 08:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345371AbiC3M1f (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 30 Mar 2022 08:27:35 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 206C13C729
        for <linux-wireless@vger.kernel.org>; Wed, 30 Mar 2022 05:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648642494; x=1680178494;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=+y9M8bG4NDLJq8RTlHY11EA46+9TKHYh+UqspdjXuXI=;
  b=hM7rw1IllzlrjFBKe5ukkpmt5lATyAPUuEwEsTDJ+vrT+puEw/wFuvvD
   N9476H6BWwi4jzirjarXRQt6JMVaB+Lb4w0t7ZmuAl+WnCwCOLe4rgHJA
   wNAIaJ9s5y+7Et+FEB7exS0nDxC7cTV1wkBl2r++c7HNX3Qmx4BfCf8YR
   eEMtj3uKAGZbZiQrugz/WGIveJd5ithR1wpBIMDdbUqFVwNJP7FOGgrKd
   I6J9oTu8qTkUG3XWFfPnRmrF0YIP4KbhNOltulERzftmcSnXLjJLH1tkU
   OP7yKbskVfJUFQ8GM1ZyFj6xF/u+YIWEDEHMLGmiir37hbM/6W8Dm/7l+
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10301"; a="247026349"
X-IronPort-AV: E=Sophos;i="5.90,222,1643702400"; 
   d="scan'208";a="247026349"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 05:14:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,222,1643702400"; 
   d="scan'208";a="585978562"
Received: from lkp-server02.sh.intel.com (HELO 50c1cd9a0434) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 30 Mar 2022 05:14:51 -0700
Received: from kbuild by 50c1cd9a0434 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nZXDu-00007r-36; Wed, 30 Mar 2022 12:14:50 +0000
Date:   Wed, 30 Mar 2022 20:13:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>
Subject: [wireless:main] BUILD SUCCESS
 24b488061b97a6c6ff82c433e6843eaf54f41f3c
Message-ID: <62444981.Rvse4vVAR0439G7e%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git main
branch HEAD: 24b488061b97a6c6ff82c433e6843eaf54f41f3c  MAINTAINERS: update Lorenzo's email address

elapsed time: 7275m

configs tested: 356
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                          randconfig-c001
i386                 randconfig-c001-20220328
powerpc64                           defconfig
m68k                            mac_defconfig
h8300                    h8300h-sim_defconfig
sh                           se7619_defconfig
sh                          urquell_defconfig
powerpc                     pq2fads_defconfig
ia64                          tiger_defconfig
mips                       capcella_defconfig
powerpc                       ppc64_defconfig
sh                   sh7724_generic_defconfig
powerpc                     redwood_defconfig
mips                     decstation_defconfig
powerpc                           allnoconfig
m68k                            q40_defconfig
sh                          r7780mp_defconfig
arm                           h3600_defconfig
ia64                            zx1_defconfig
sh                             espt_defconfig
powerpc                     tqm8548_defconfig
sh                     magicpanelr2_defconfig
sh                                  defconfig
sh                 kfr2r09-romimage_defconfig
m68k                       m5275evb_defconfig
arm                         assabet_defconfig
i386                                defconfig
powerpc                      tqm8xx_defconfig
sh                           se7722_defconfig
powerpc                     asp8347_defconfig
sh                             shx3_defconfig
alpha                            alldefconfig
powerpc                      bamboo_defconfig
mips                         mpc30x_defconfig
sh                           sh2007_defconfig
nios2                         3c120_defconfig
sh                          rsk7269_defconfig
arc                        nsim_700_defconfig
arm                      footbridge_defconfig
arm                       multi_v4t_defconfig
m68k                        mvme147_defconfig
arm                            zeus_defconfig
csky                                defconfig
arm                           sama5_defconfig
m68k                       bvme6000_defconfig
xtensa                              defconfig
sh                          polaris_defconfig
powerpc                  storcenter_defconfig
powerpc                     taishan_defconfig
xtensa                  audio_kc705_defconfig
powerpc                    amigaone_defconfig
arm                            hisi_defconfig
powerpc                    klondike_defconfig
m68k                          atari_defconfig
ia64                        generic_defconfig
m68k                                defconfig
sh                               allmodconfig
powerpc                       maple_defconfig
arm                          badge4_defconfig
ia64                      gensparse_defconfig
sh                         ap325rxa_defconfig
arc                                 defconfig
arm                           imxrt_defconfig
powerpc                      ppc6xx_defconfig
powerpc                   motionpro_defconfig
arc                      axs103_smp_defconfig
arm                      integrator_defconfig
s390                          debug_defconfig
arm                          pxa3xx_defconfig
powerpc                 mpc8540_ads_defconfig
sh                            shmin_defconfig
sh                         apsh4a3a_defconfig
arm                          exynos_defconfig
arm                          simpad_defconfig
parisc                           alldefconfig
arm                            pleb_defconfig
sparc                       sparc64_defconfig
powerpc                     stx_gp3_defconfig
powerpc                  iss476-smp_defconfig
sh                           se7724_defconfig
m68k                       m5208evb_defconfig
powerpc                       holly_defconfig
arc                         haps_hs_defconfig
mips                            ar7_defconfig
mips                           ci20_defconfig
openrisc                            defconfig
mips                  decstation_64_defconfig
sh                      rts7751r2d1_defconfig
m68k                         apollo_defconfig
ia64                                defconfig
parisc64                            defconfig
arm                        mvebu_v7_defconfig
powerpc64                        alldefconfig
arm                         at91_dt_defconfig
arm                        mini2440_defconfig
x86_64                              defconfig
arc                          axs101_defconfig
arc                            hsdk_defconfig
nios2                         10m50_defconfig
sparc                            alldefconfig
arm                           sunxi_defconfig
openrisc                  or1klitex_defconfig
csky                             alldefconfig
nios2                               defconfig
arm64                            alldefconfig
powerpc                         wii_defconfig
mips                           gcw0_defconfig
nios2                            allyesconfig
arm                          lpd270_defconfig
i386                             alldefconfig
arc                     haps_hs_smp_defconfig
sparc64                             defconfig
arm                             pxa_defconfig
powerpc                     ep8248e_defconfig
xtensa                       common_defconfig
sh                   secureedge5410_defconfig
sparc64                          alldefconfig
mips                        bcm47xx_defconfig
arm                           tegra_defconfig
m68k                       m5475evb_defconfig
m68k                       m5249evb_defconfig
powerpc                      ep88xc_defconfig
mips                  maltasmvp_eva_defconfig
openrisc                    or1ksim_defconfig
arm                        multi_v7_defconfig
sh                          kfr2r09_defconfig
mips                             allyesconfig
parisc                generic-64bit_defconfig
mips                          rb532_defconfig
powerpc                      mgcoge_defconfig
h8300                               defconfig
sh                         microdev_defconfig
arm                           u8500_defconfig
xtensa                           allyesconfig
arm                     eseries_pxa_defconfig
m68k                        m5272c3_defconfig
powerpc                      makalu_defconfig
arc                        nsimosci_defconfig
mips                     loongson1b_defconfig
sh                          r7785rp_defconfig
arc                    vdk_hs38_smp_defconfig
sh                           se7206_defconfig
sh                          sdk7780_defconfig
m68k                         amcore_defconfig
um                               alldefconfig
m68k                          multi_defconfig
powerpc                      chrp32_defconfig
m68k                        mvme16x_defconfig
arm                           h5000_defconfig
xtensa                  nommu_kc705_defconfig
powerpc                      pasemi_defconfig
arm                             rpc_defconfig
microblaze                      mmu_defconfig
sparc                               defconfig
powerpc                      arches_defconfig
arm                            qcom_defconfig
arm                         s3c6400_defconfig
sh                           se7343_defconfig
h8300                            alldefconfig
m68k                             alldefconfig
sh                               j2_defconfig
riscv             nommu_k210_sdcard_defconfig
sh                           se7750_defconfig
arm                        realview_defconfig
arm                         lpc18xx_defconfig
arm                           stm32_defconfig
um                                  defconfig
x86_64                           alldefconfig
arm                           viper_defconfig
sh                   sh7770_generic_defconfig
s390                                defconfig
sh                            hp6xx_defconfig
arm                        cerfcube_defconfig
mips                 decstation_r4k_defconfig
xtensa                    xip_kc705_defconfig
arm                       aspeed_g5_defconfig
s390                       zfcpdump_defconfig
powerpc                 mpc837x_mds_defconfig
sh                         ecovec24_defconfig
arm                            lart_defconfig
sh                        apsh4ad0a_defconfig
h8300                       h8s-sim_defconfig
arc                              allyesconfig
arm                        trizeps4_defconfig
powerpc                 mpc837x_rdb_defconfig
arm                         vf610m4_defconfig
mips                      maltasmvp_defconfig
arc                     nsimosci_hs_defconfig
mips                       bmips_be_defconfig
riscv                    nommu_k210_defconfig
sh                             sh03_defconfig
parisc64                         alldefconfig
arm                          pxa910_defconfig
sh                          landisk_defconfig
sh                          rsk7264_defconfig
openrisc                 simple_smp_defconfig
arm                         axm55xx_defconfig
powerpc                 mpc834x_itx_defconfig
m68k                        m5307c3_defconfig
powerpc                   currituck_defconfig
arm                        clps711x_defconfig
riscv                            allyesconfig
parisc                              defconfig
powerpc                     tqm8541_defconfig
arm                          gemini_defconfig
s390                             allyesconfig
mips                         rt305x_defconfig
m68k                             allyesconfig
xtensa                           alldefconfig
arm                  randconfig-c002-20220325
arm                  randconfig-c002-20220324
arm                  randconfig-c002-20220327
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allmodconfig
alpha                               defconfig
alpha                            allyesconfig
h8300                            allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64               randconfig-a001-20220328
x86_64               randconfig-a003-20220328
x86_64               randconfig-a004-20220328
x86_64               randconfig-a002-20220328
x86_64               randconfig-a005-20220328
x86_64               randconfig-a006-20220328
i386                 randconfig-a001-20220328
i386                 randconfig-a003-20220328
i386                 randconfig-a006-20220328
i386                 randconfig-a005-20220328
i386                 randconfig-a004-20220328
i386                 randconfig-a002-20220328
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
riscv                randconfig-r042-20220325
s390                 randconfig-r044-20220325
arc                  randconfig-r043-20220325
arc                  randconfig-r043-20220324
riscv                randconfig-r042-20220327
s390                 randconfig-r044-20220327
arc                  randconfig-r043-20220327
arc                  randconfig-r043-20220328
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                                  kexec

clang tested configs:
x86_64                        randconfig-c007
mips                 randconfig-c004-20220324
arm                  randconfig-c002-20220324
riscv                randconfig-c006-20220324
powerpc              randconfig-c003-20220324
i386                          randconfig-c001
mips                 randconfig-c004-20220327
arm                  randconfig-c002-20220327
riscv                randconfig-c006-20220327
powerpc              randconfig-c003-20220327
s390                 randconfig-c005-20220327
mips                 randconfig-c004-20220328
arm                  randconfig-c002-20220328
x86_64               randconfig-c007-20220328
powerpc              randconfig-c003-20220328
riscv                randconfig-c006-20220328
i386                 randconfig-c001-20220328
s390                 randconfig-c005-20220328
powerpc                 mpc832x_rdb_defconfig
powerpc                       ebony_defconfig
arm                         s3c2410_defconfig
arm                  colibri_pxa300_defconfig
powerpc                      acadia_defconfig
x86_64                           allyesconfig
powerpc                     tqm8540_defconfig
arm                        neponset_defconfig
mips                           ip22_defconfig
arm                       aspeed_g4_defconfig
powerpc                 mpc8315_rdb_defconfig
powerpc                     ppa8548_defconfig
arm                          imote2_defconfig
arm                  colibri_pxa270_defconfig
mips                  cavium_octeon_defconfig
arm                         mv78xx0_defconfig
powerpc                 mpc832x_mds_defconfig
powerpc                      katmai_defconfig
mips                           ip27_defconfig
powerpc                      walnut_defconfig
arm                          moxart_defconfig
powerpc                          g5_defconfig
powerpc                    ge_imp3a_defconfig
arm                             mxs_defconfig
mips                malta_qemu_32r6_defconfig
arm                        magician_defconfig
powerpc                   microwatt_defconfig
arm                          ixp4xx_defconfig
powerpc                      ppc64e_defconfig
hexagon                             defconfig
mips                        bcm63xx_defconfig
powerpc                 xes_mpc85xx_defconfig
arm                        multi_v5_defconfig
powerpc                          allmodconfig
powerpc                      pmac32_defconfig
arm                         socfpga_defconfig
arm                        spear3xx_defconfig
arm                       imx_v4_v5_defconfig
arm                           omap1_defconfig
arm                       spear13xx_defconfig
mips                       rbtx49xx_defconfig
powerpc                     ksi8560_defconfig
powerpc                        icon_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64               randconfig-a016-20220328
x86_64               randconfig-a012-20220328
x86_64               randconfig-a011-20220328
x86_64               randconfig-a014-20220328
x86_64               randconfig-a013-20220328
x86_64               randconfig-a015-20220328
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
i386                 randconfig-a015-20220328
i386                 randconfig-a016-20220328
i386                 randconfig-a011-20220328
i386                 randconfig-a012-20220328
i386                 randconfig-a014-20220328
i386                 randconfig-a013-20220328
riscv                randconfig-r042-20220328
hexagon              randconfig-r045-20220328
hexagon              randconfig-r041-20220328
riscv                randconfig-r042-20220326
hexagon              randconfig-r045-20220326
hexagon              randconfig-r041-20220326

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
