Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2D2C514AB9
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Apr 2022 15:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346991AbiD2NmE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 29 Apr 2022 09:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376281AbiD2Nlm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 29 Apr 2022 09:41:42 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60406CD302
        for <linux-wireless@vger.kernel.org>; Fri, 29 Apr 2022 06:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651239494; x=1682775494;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=jxD4E2gJjVdOefgGsSrOlhE0CfMvfrWFHKjauTf5H4Q=;
  b=MC85fBP5GXZad/J3TNaTalkVB8FiBtOmTP0kwYJjG8yjCHdSHmusJ9uY
   ow5v951/DJjqudLgeNGNkty6Z8rlAG72PjCIsD3x0LAgbW7QNJNCLyNH6
   QX5WaP2BlkrufvYSzmdMpEoQyORHFjVmQjeZY6G64hT1LG1ONIR+XF8Fg
   Nu8AD8mtDMPonyH5FrEdbhc44YyDIy/S7OhVV8/72cZOpHFI/4kvq/gzs
   4pnNir5t/ArZ/H1E1RB2pzA7WTVaolOdUFovS1oFRWlzTHiEV/zH403ZP
   rQlSuHctqyLPzSbEEXPos2auf/t+3WbudDdMBGsqboviJtlIxP2FSwpy7
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10331"; a="353075472"
X-IronPort-AV: E=Sophos;i="5.91,185,1647327600"; 
   d="scan'208";a="353075472"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2022 06:38:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,185,1647327600"; 
   d="scan'208";a="732070321"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 29 Apr 2022 06:38:11 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nkQp1-0006Lz-2U;
        Fri, 29 Apr 2022 13:38:11 +0000
Date:   Fri, 29 Apr 2022 21:37:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>
Subject: [wireless-next:pending] BUILD SUCCESS
 68d57a07bfe5bb29b80cd8b8fa24c9d1ea104124
Message-ID: <626bea0b.mh9h0Ne2mNvRvlyx%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,TRACKER_ID autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git pending
branch HEAD: 68d57a07bfe5bb29b80cd8b8fa24c9d1ea104124  wireless: add plfxlc driver for pureLiFi X, XL, XC devices

elapsed time: 5757m

configs tested: 263
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm                              allyesconfig
mips                 randconfig-c004-20220425
i386                 randconfig-c001-20220425
i386                          randconfig-c001
ia64                          tiger_defconfig
sh                            shmin_defconfig
mips                           ip32_defconfig
nios2                               defconfig
mips                     decstation_defconfig
m68k                            q40_defconfig
arm                           corgi_defconfig
sh                           se7724_defconfig
parisc                generic-32bit_defconfig
powerpc                       ppc64_defconfig
sh                  sh7785lcr_32bit_defconfig
powerpc                    sam440ep_defconfig
sh                           se7619_defconfig
powerpc                      pasemi_defconfig
sh                        sh7785lcr_defconfig
powerpc                    amigaone_defconfig
um                               alldefconfig
powerpc                      makalu_defconfig
sh                               j2_defconfig
arm                        cerfcube_defconfig
sh                           se7751_defconfig
arm                         assabet_defconfig
mips                  decstation_64_defconfig
arm                            zeus_defconfig
arm                      integrator_defconfig
arc                              alldefconfig
arm                           sunxi_defconfig
s390                             allmodconfig
sh                          rsk7264_defconfig
mips                  maltasmvp_eva_defconfig
mips                      maltasmvp_defconfig
sh                        sh7763rdp_defconfig
openrisc                  or1klitex_defconfig
mips                       bmips_be_defconfig
powerpc                     ep8248e_defconfig
s390                                defconfig
mips                         tb0226_defconfig
sh                        edosk7760_defconfig
powerpc                 mpc834x_mds_defconfig
powerpc                     taishan_defconfig
sparc                       sparc64_defconfig
powerpc                        cell_defconfig
parisc                generic-64bit_defconfig
arm                         cm_x300_defconfig
sparc                               defconfig
arm                            hisi_defconfig
alpha                            alldefconfig
i386                             alldefconfig
arm                        clps711x_defconfig
arm                             pxa_defconfig
arm                        keystone_defconfig
arm                         vf610m4_defconfig
sh                              ul2_defconfig
sh                          sdk7786_defconfig
arm                           viper_defconfig
m68k                       m5249evb_defconfig
arm                          iop32x_defconfig
xtensa                              defconfig
arm                        mini2440_defconfig
sh                ecovec24-romimage_defconfig
arm                      jornada720_defconfig
m68k                        m5272c3_defconfig
sh                             shx3_defconfig
sh                           se7780_defconfig
arc                     nsimosci_hs_defconfig
xtensa                           alldefconfig
arm                          gemini_defconfig
sh                          kfr2r09_defconfig
m68k                       bvme6000_defconfig
sh                          landisk_defconfig
arm                         lpc18xx_defconfig
arc                         haps_hs_defconfig
mips                      loongson3_defconfig
parisc64                            defconfig
arm                          simpad_defconfig
sh                           se7206_defconfig
m68k                          sun3x_defconfig
nios2                            allyesconfig
m68k                                defconfig
sh                        edosk7705_defconfig
arm                        multi_v7_defconfig
microblaze                          defconfig
powerpc                      ppc6xx_defconfig
powerpc                     pq2fads_defconfig
arc                 nsimosci_hs_smp_defconfig
arm                            pleb_defconfig
h8300                       h8s-sim_defconfig
m68k                        mvme147_defconfig
xtensa                          iss_defconfig
sh                           se7750_defconfig
sparc64                             defconfig
powerpc                  storcenter_defconfig
arc                      axs103_smp_defconfig
sh                          r7780mp_defconfig
m68k                             alldefconfig
arm                           h3600_defconfig
xtensa                  cadence_csp_defconfig
m68k                        mvme16x_defconfig
h8300                            alldefconfig
arm                        mvebu_v7_defconfig
sh                          sdk7780_defconfig
arm                      footbridge_defconfig
ia64                             alldefconfig
mips                       capcella_defconfig
powerpc                 mpc85xx_cds_defconfig
sh                         ap325rxa_defconfig
arm                         lubbock_defconfig
arc                     haps_hs_smp_defconfig
xtensa                  nommu_kc705_defconfig
arc                                 defconfig
powerpc                      arches_defconfig
mips                          rb532_defconfig
powerpc                      mgcoge_defconfig
x86_64                           alldefconfig
x86_64               randconfig-c001-20220425
arm                  randconfig-c002-20220425
x86_64                        randconfig-c001
arm                  randconfig-c002-20220428
arm                  randconfig-c002-20220427
arm                  randconfig-c002-20220426
ia64                                defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
h8300                            allyesconfig
xtensa                           allyesconfig
sh                               allmodconfig
parisc                              defconfig
parisc                           allyesconfig
s390                             allyesconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64               randconfig-a015-20220425
x86_64               randconfig-a014-20220425
x86_64               randconfig-a011-20220425
x86_64               randconfig-a013-20220425
x86_64               randconfig-a012-20220425
x86_64               randconfig-a016-20220425
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
i386                 randconfig-a014-20220425
i386                 randconfig-a012-20220425
i386                 randconfig-a011-20220425
i386                 randconfig-a015-20220425
i386                 randconfig-a013-20220425
i386                 randconfig-a016-20220425
i386                          randconfig-a012
i386                          randconfig-a016
i386                          randconfig-a014
arc                  randconfig-r043-20220425
s390                 randconfig-r044-20220425
riscv                randconfig-r042-20220425
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
riscv                            allmodconfig
riscv                            allyesconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                          rhel-8.3-func
x86_64                                  kexec
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                         rhel-8.3-kunit
x86_64                               rhel-8.3
x86_64                           rhel-8.3-syz

clang tested configs:
riscv                randconfig-c006-20220425
mips                 randconfig-c004-20220425
x86_64               randconfig-c007-20220425
arm                  randconfig-c002-20220425
i386                 randconfig-c001-20220425
powerpc              randconfig-c003-20220425
riscv                randconfig-c006-20220427
mips                 randconfig-c004-20220427
x86_64                        randconfig-c007
i386                          randconfig-c001
arm                  randconfig-c002-20220427
powerpc              randconfig-c003-20220427
riscv                randconfig-c006-20220428
mips                 randconfig-c004-20220428
arm                  randconfig-c002-20220428
powerpc              randconfig-c003-20220428
mips                          ath79_defconfig
mips                     loongson2k_defconfig
arm                          pxa168_defconfig
powerpc                    socrates_defconfig
arm                            dove_defconfig
arm                       aspeed_g4_defconfig
arm                          moxart_defconfig
mips                           mtx1_defconfig
arm                       cns3420vb_defconfig
arm                     davinci_all_defconfig
mips                          rm200_defconfig
powerpc                     tqm5200_defconfig
mips                           ip22_defconfig
powerpc                  mpc885_ads_defconfig
mips                malta_qemu_32r6_defconfig
powerpc                       ebony_defconfig
arm                       imx_v4_v5_defconfig
powerpc                          allyesconfig
powerpc                      katmai_defconfig
powerpc                     pseries_defconfig
powerpc                        fsp2_defconfig
arm                      pxa255-idp_defconfig
mips                      malta_kvm_defconfig
mips                           ip27_defconfig
arm                        vexpress_defconfig
mips                       rbtx49xx_defconfig
powerpc                          allmodconfig
powerpc                 mpc8560_ads_defconfig
arm                       mainstone_defconfig
powerpc                     skiroot_defconfig
mips                     loongson1c_defconfig
mips                         tb0287_defconfig
mips                        workpad_defconfig
mips                      bmips_stb_defconfig
arm                       versatile_defconfig
x86_64               randconfig-a002-20220425
x86_64               randconfig-a004-20220425
x86_64               randconfig-a003-20220425
x86_64               randconfig-a001-20220425
x86_64               randconfig-a005-20220425
x86_64               randconfig-a006-20220425
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
i386                 randconfig-a003-20220425
i386                 randconfig-a002-20220425
i386                 randconfig-a001-20220425
i386                 randconfig-a004-20220425
i386                 randconfig-a005-20220425
i386                 randconfig-a006-20220425
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
hexagon              randconfig-r041-20220428
riscv                randconfig-r042-20220428
hexagon              randconfig-r045-20220428
hexagon              randconfig-r041-20220425
hexagon              randconfig-r045-20220425

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
