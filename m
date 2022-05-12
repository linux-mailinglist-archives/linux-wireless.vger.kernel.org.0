Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ECCF524BC8
	for <lists+linux-wireless@lfdr.de>; Thu, 12 May 2022 13:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350773AbiELLgk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 May 2022 07:36:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353319AbiELLgi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 12 May 2022 07:36:38 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FF671EAE6
        for <linux-wireless@vger.kernel.org>; Thu, 12 May 2022 04:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652355397; x=1683891397;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=F+/rw3HpE+xA8HoOYqCTHF4jtUnntOuKnArXf1Qq6GA=;
  b=UJbCKy2HJc+vL2SepOC4LqWRHZRN1smN4ViJwCbcYnwbiLH7RMKoBCQV
   n0GlhxMEms/AaoRKQZMKALu/xaGQiL0fmlQBOxPwPiNuOa5gfSFvq4yOn
   nVZVXDF41n3bWo7HWAbo3y/V2myaj3MB3NFJjUs1XmNlv/+GCT+E0hrHy
   I+e4MlK7PW9L9riGLRCP0cNiYYcK4aOM86Rtijo0hnU95TU3ozT+Gikwm
   5OzN4l9reR1O1CyVBLpjR9w2+8L0hgC/7vrQyt4n4ScXS+49l9u7jTUo6
   0DZU031NO9TMqHKCWuwLqyyr08bJEMq6UBgynnZAZaq9/mZOf9VmsrrJ8
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10344"; a="267558532"
X-IronPort-AV: E=Sophos;i="5.91,219,1647327600"; 
   d="scan'208";a="267558532"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 04:36:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,219,1647327600"; 
   d="scan'208";a="594627142"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 12 May 2022 04:36:16 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1np77A-000KMW-0a;
        Thu, 12 May 2022 11:36:16 +0000
Date:   Thu, 12 May 2022 19:35:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johannes Berg <johannes.berg@intel.com>
Cc:     linux-wireless@vger.kernel.org, Kalle Valo <kvalo@kernel.org>
Subject: [wireless:main] BUILD SUCCESS
 a36e07dfe6ee71e209383ea9288cd8d1617e14f9
Message-ID: <627cf105.ruybdM7CroKisIJ5%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git main
branch HEAD: a36e07dfe6ee71e209383ea9288cd8d1617e14f9  rfkill: uapi: fix RFKILL_IOCTL_MAX_SIZE ioctl request definition

elapsed time: 4145m

configs tested: 358
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm                              allyesconfig
i386                 randconfig-c001-20220509
i386                          randconfig-c001
arm                           h5000_defconfig
m68k                          hp300_defconfig
alpha                            alldefconfig
arm                         nhk8815_defconfig
sh                               j2_defconfig
sh                         ap325rxa_defconfig
sh                      rts7751r2d1_defconfig
sh                              ul2_defconfig
mips                           ci20_defconfig
sparc                       sparc64_defconfig
nios2                         3c120_defconfig
sh                           se7619_defconfig
h8300                    h8300h-sim_defconfig
powerpc                      makalu_defconfig
arm                         axm55xx_defconfig
powerpc                 linkstation_defconfig
mips                       capcella_defconfig
sh                          rsk7269_defconfig
xtensa                         virt_defconfig
um                                  defconfig
m68k                       m5249evb_defconfig
sh                          urquell_defconfig
arm                       omap2plus_defconfig
csky                                defconfig
xtensa                  cadence_csp_defconfig
ia64                        generic_defconfig
arm                            qcom_defconfig
arc                     nsimosci_hs_defconfig
powerpc                        warp_defconfig
sh                           se7721_defconfig
arm                           corgi_defconfig
mips                 decstation_r4k_defconfig
powerpc                       eiger_defconfig
mips                           xway_defconfig
powerpc                      pasemi_defconfig
arm                        mini2440_defconfig
arm                        multi_v7_defconfig
m68k                        m5272c3_defconfig
sh                          rsk7201_defconfig
arm                         at91_dt_defconfig
arm                         lubbock_defconfig
parisc                           alldefconfig
ia64                             alldefconfig
sh                          rsk7203_defconfig
arm                        spear6xx_defconfig
arm                          iop32x_defconfig
arm                         cm_x300_defconfig
arm                           h3600_defconfig
arm                             rpc_defconfig
mips                         cobalt_defconfig
riscv                            allyesconfig
parisc64                         alldefconfig
m68k                            mac_defconfig
powerpc                     taishan_defconfig
sh                          r7785rp_defconfig
sh                                  defconfig
powerpc                  storcenter_defconfig
arm                       aspeed_g5_defconfig
xtensa                  nommu_kc705_defconfig
arm                           stm32_defconfig
powerpc                    sam440ep_defconfig
arm                        clps711x_defconfig
arc                              alldefconfig
sh                          landisk_defconfig
powerpc                           allnoconfig
sparc64                             defconfig
arm                            zeus_defconfig
nios2                            alldefconfig
sh                           sh2007_defconfig
i386                                defconfig
m68k                             allmodconfig
powerpc                     sequoia_defconfig
sh                          polaris_defconfig
sh                            hp6xx_defconfig
sparc                            alldefconfig
arc                         haps_hs_defconfig
mips                    maltaup_xpa_defconfig
powerpc64                           defconfig
arc                        vdk_hs38_defconfig
powerpc                mpc7448_hpc2_defconfig
arm                       imx_v6_v7_defconfig
powerpc                     tqm8548_defconfig
powerpc                       holly_defconfig
mips                        vocore2_defconfig
arm                        keystone_defconfig
riscv             nommu_k210_sdcard_defconfig
openrisc                            defconfig
arm                          pxa910_defconfig
h8300                               defconfig
arc                      axs103_smp_defconfig
sh                        edosk7705_defconfig
sh                        sh7763rdp_defconfig
sh                   sh7724_generic_defconfig
nios2                            allyesconfig
m68k                          multi_defconfig
sh                          sdk7780_defconfig
s390                             allyesconfig
arm                        realview_defconfig
arc                          axs103_defconfig
powerpc                    klondike_defconfig
arm                         lpc18xx_defconfig
powerpc                 mpc8540_ads_defconfig
nios2                         10m50_defconfig
sh                             sh03_defconfig
arc                                 defconfig
mips                             allyesconfig
s390                                defconfig
openrisc                 simple_smp_defconfig
s390                       zfcpdump_defconfig
arm                      footbridge_defconfig
arc                 nsimosci_hs_smp_defconfig
sh                           se7343_defconfig
sh                          kfr2r09_defconfig
arm                             ezx_defconfig
sh                           se7751_defconfig
m68k                       m5208evb_defconfig
powerpc                      pcm030_defconfig
arm                           sunxi_defconfig
sh                         apsh4a3a_defconfig
xtensa                    xip_kc705_defconfig
mips                         tb0226_defconfig
powerpc                 canyonlands_defconfig
mips                            ar7_defconfig
xtensa                    smp_lx200_defconfig
sh                         microdev_defconfig
arm                      integrator_defconfig
arm                          badge4_defconfig
nios2                               defconfig
powerpc                      tqm8xx_defconfig
mips                           gcw0_defconfig
arm                          simpad_defconfig
ia64                         bigsur_defconfig
xtensa                       common_defconfig
arm                            xcep_defconfig
sh                           se7724_defconfig
arm                        cerfcube_defconfig
sh                            migor_defconfig
powerpc                     tqm8555_defconfig
h8300                            allyesconfig
arm                      jornada720_defconfig
powerpc                      cm5200_defconfig
arm                            mps2_defconfig
parisc                generic-32bit_defconfig
alpha                            allyesconfig
arm                          pxa3xx_defconfig
powerpc                     rainier_defconfig
m68k                        mvme147_defconfig
powerpc                        cell_defconfig
ia64                                defconfig
powerpc                     stx_gp3_defconfig
powerpc                      ppc6xx_defconfig
m68k                          amiga_defconfig
sh                         ecovec24_defconfig
m68k                             alldefconfig
sh                          lboxre2_defconfig
mips                        bcm47xx_defconfig
arm                           tegra_defconfig
sh                        sh7757lcr_defconfig
sh                           se7722_defconfig
arm                          exynos_defconfig
openrisc                  or1klitex_defconfig
m68k                        m5407c3_defconfig
riscv                               defconfig
xtensa                           alldefconfig
powerpc                   currituck_defconfig
sh                     sh7710voipgw_defconfig
sh                          r7780mp_defconfig
m68k                        stmark2_defconfig
m68k                       bvme6000_defconfig
sh                           se7206_defconfig
sh                           se7780_defconfig
sh                            shmin_defconfig
ia64                          tiger_defconfig
sh                        apsh4ad0a_defconfig
powerpc                      ppc40x_defconfig
arm                         assabet_defconfig
mips                            gpr_defconfig
microblaze                          defconfig
powerpc                      ep88xc_defconfig
powerpc                    adder875_defconfig
powerpc                       ppc64_defconfig
powerpc                         ps3_defconfig
ia64                      gensparse_defconfig
arm                          lpd270_defconfig
arc                           tb10x_defconfig
arc                            hsdk_defconfig
powerpc                  iss476-smp_defconfig
powerpc                 mpc834x_itx_defconfig
arm                         vf610m4_defconfig
mips                         mpc30x_defconfig
um                               alldefconfig
arc                    vdk_hs38_smp_defconfig
arm                            hisi_defconfig
sh                             espt_defconfig
riscv                    nommu_k210_defconfig
openrisc                         alldefconfig
arc                        nsim_700_defconfig
powerpc                     tqm8541_defconfig
powerpc                       maple_defconfig
sh                           se7712_defconfig
x86_64               randconfig-c001-20220509
arm                  randconfig-c002-20220509
x86_64                        randconfig-c001
arm                  randconfig-c002-20220512
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allyesconfig
m68k                                defconfig
arc                              allyesconfig
alpha                               defconfig
xtensa                           allyesconfig
sh                               allmodconfig
s390                             allmodconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
sparc                               defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
x86_64               randconfig-a015-20220509
x86_64               randconfig-a012-20220509
x86_64               randconfig-a016-20220509
x86_64               randconfig-a014-20220509
x86_64               randconfig-a013-20220509
x86_64               randconfig-a011-20220509
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
i386                 randconfig-a011-20220509
i386                 randconfig-a013-20220509
i386                 randconfig-a016-20220509
i386                 randconfig-a015-20220509
i386                 randconfig-a014-20220509
i386                 randconfig-a012-20220509
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
arc                  randconfig-r043-20220509
s390                 randconfig-r044-20220509
riscv                randconfig-r042-20220509
s390                 randconfig-r044-20220510
riscv                randconfig-r042-20220510
arc                  randconfig-r043-20220510
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                             allnoconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                                  kexec
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                         rhel-8.3-kunit
x86_64                               rhel-8.3

clang tested configs:
x86_64               randconfig-c007-20220509
i386                 randconfig-c001-20220509
powerpc              randconfig-c003-20220509
riscv                randconfig-c006-20220509
mips                 randconfig-c004-20220509
arm                  randconfig-c002-20220509
s390                 randconfig-c005-20220509
powerpc              randconfig-c003-20220510
x86_64                        randconfig-c007
riscv                randconfig-c006-20220510
mips                 randconfig-c004-20220510
i386                          randconfig-c001
arm                  randconfig-c002-20220510
s390                 randconfig-c005-20220512
powerpc              randconfig-c003-20220512
riscv                randconfig-c006-20220512
mips                 randconfig-c004-20220512
arm                  randconfig-c002-20220512
mips                        bcm63xx_defconfig
arm                           omap1_defconfig
mips                     cu1830-neo_defconfig
powerpc                      acadia_defconfig
powerpc                    mvme5100_defconfig
arm                                 defconfig
powerpc                     tqm5200_defconfig
powerpc                     kmeter1_defconfig
arm                        spear3xx_defconfig
arm                       imx_v4_v5_defconfig
powerpc                     ppa8548_defconfig
powerpc                 mpc836x_mds_defconfig
mips                          malta_defconfig
powerpc                      katmai_defconfig
powerpc                     tqm8540_defconfig
mips                          ath79_defconfig
arm                         socfpga_defconfig
powerpc                      ppc64e_defconfig
mips                        workpad_defconfig
arm                          pcm027_defconfig
powerpc                     akebono_defconfig
powerpc                     powernv_defconfig
powerpc                          allmodconfig
mips                       rbtx49xx_defconfig
mips                        maltaup_defconfig
mips                      maltaaprp_defconfig
arm                      pxa255-idp_defconfig
hexagon                             defconfig
mips                        omega2p_defconfig
arm                         bcm2835_defconfig
arm                       netwinder_defconfig
powerpc                          g5_defconfig
powerpc                   bluestone_defconfig
powerpc                     tqm8560_defconfig
powerpc                      walnut_defconfig
arm                     am200epdkit_defconfig
mips                            e55_defconfig
powerpc                 xes_mpc85xx_defconfig
arm                       aspeed_g4_defconfig
arm                       versatile_defconfig
arm                         s3c2410_defconfig
powerpc                     skiroot_defconfig
arm                          ixp4xx_defconfig
mips                      pic32mzda_defconfig
arm                  colibri_pxa300_defconfig
arm                          collie_defconfig
arm                        vexpress_defconfig
mips                     loongson1c_defconfig
arm                         shannon_defconfig
powerpc                 mpc836x_rdk_defconfig
arm                          pxa168_defconfig
x86_64               randconfig-a006-20220509
x86_64               randconfig-a002-20220509
x86_64               randconfig-a001-20220509
x86_64               randconfig-a004-20220509
x86_64               randconfig-a005-20220509
x86_64               randconfig-a003-20220509
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                 randconfig-a004-20220509
i386                 randconfig-a006-20220509
i386                 randconfig-a002-20220509
i386                 randconfig-a003-20220509
i386                 randconfig-a001-20220509
i386                 randconfig-a005-20220509
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
hexagon              randconfig-r045-20220509
hexagon              randconfig-r041-20220509

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
