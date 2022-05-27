Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE3E536788
	for <lists+linux-wireless@lfdr.de>; Fri, 27 May 2022 21:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354424AbiE0TgR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 27 May 2022 15:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238483AbiE0TgQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 27 May 2022 15:36:16 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70FB32BC0
        for <linux-wireless@vger.kernel.org>; Fri, 27 May 2022 12:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653680175; x=1685216175;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=RRbCU7XlDIvNKXn8paf7kG2lWS5BkpaZJQWQejDT9OY=;
  b=Eq9IX9lau9awSr48enYr9zhqzKhXhCf9WGnyr2AU/89tjL/O5+sv5Vuc
   oETqiXjXqOQ/ehsj40Syk1oIb6K6oMINm8JjtJQTJiDmDppxIYsP1CWcn
   cD+bnWuvpdwvPcKZ0W8TVCbgPZEfClf1h7zOCFXcUkWAx1bcfZClt6rQ5
   XyFTUNSPWPF/XJfgr43g+0jQ2SkFOtiEvmJ51caPrcBhJyt0lzxUWrkM6
   gBhG2qJ4rHgEh1t2ai6D2t9iAv3wRNnFi53WCMnv5zPPVdyiXs4h1XCbZ
   M6yrBjR21Zq5OTanNx6INFRdztfoHVo6kE4eAiK098UKBHcVdE6eHK5g3
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10360"; a="274662276"
X-IronPort-AV: E=Sophos;i="5.91,256,1647327600"; 
   d="scan'208";a="274662276"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2022 12:36:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,256,1647327600"; 
   d="scan'208";a="705268071"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 27 May 2022 12:36:12 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nufkq-00054d-7d;
        Fri, 27 May 2022 19:36:12 +0000
Date:   Sat, 28 May 2022 03:35:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     linux-wireless@vger.kernel.org, Kalle Valo <kvalo@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>
Subject: [wireless:for-next] BUILD SUCCESS
 a54ce3703613e41fe1d98060b62ec09a3984dc28
Message-ID: <6291281d.CdpF+7gDPxB8H8Fd%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git for-next
branch HEAD: a54ce3703613e41fe1d98060b62ec09a3984dc28  net: sched: fixed barrier to prevent skbuff sticking in qdisc backlog

elapsed time: 908m

configs tested: 184
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
powerpc                      pcm030_defconfig
mips                         db1xxx_defconfig
sh                          polaris_defconfig
arm                         assabet_defconfig
arm                            mps2_defconfig
m68k                          sun3x_defconfig
powerpc                      ppc6xx_defconfig
arm                       multi_v4t_defconfig
sparc64                             defconfig
arc                         haps_hs_defconfig
openrisc                         alldefconfig
powerpc64                           defconfig
um                                  defconfig
sh                               alldefconfig
arm                           sama5_defconfig
arm                           imxrt_defconfig
parisc                           alldefconfig
parisc64                            defconfig
arm                         vf610m4_defconfig
sh                             sh03_defconfig
xtensa                           alldefconfig
arc                     haps_hs_smp_defconfig
powerpc                 mpc8540_ads_defconfig
sh                            hp6xx_defconfig
mips                 decstation_r4k_defconfig
sh                            titan_defconfig
sh                           sh2007_defconfig
sh                           se7712_defconfig
arm                          pxa3xx_defconfig
sh                ecovec24-romimage_defconfig
mips                         bigsur_defconfig
xtensa                    xip_kc705_defconfig
powerpc                     tqm8555_defconfig
microblaze                      mmu_defconfig
arc                        nsimosci_defconfig
sh                             espt_defconfig
sh                            shmin_defconfig
arm                           u8500_defconfig
um                               alldefconfig
sh                           se7619_defconfig
powerpc                     ep8248e_defconfig
sh                          sdk7786_defconfig
xtensa                  cadence_csp_defconfig
sh                          kfr2r09_defconfig
sparc                       sparc32_defconfig
arm                            pleb_defconfig
powerpc                     asp8347_defconfig
arm                     eseries_pxa_defconfig
sparc                       sparc64_defconfig
sh                        apsh4ad0a_defconfig
sh                           se7343_defconfig
microblaze                          defconfig
m68k                          multi_defconfig
arm                          pxa910_defconfig
arc                      axs103_smp_defconfig
sh                           se7780_defconfig
sh                   sh7724_generic_defconfig
arm                      footbridge_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                         microdev_defconfig
s390                       zfcpdump_defconfig
arm                        trizeps4_defconfig
riscv                    nommu_k210_defconfig
m68k                        m5407c3_defconfig
arc                            hsdk_defconfig
arm                        shmobile_defconfig
nios2                         10m50_defconfig
arm                          lpd270_defconfig
arm                  randconfig-c002-20220526
arm                  randconfig-c002-20220524
x86_64                        randconfig-c001
ia64                                defconfig
ia64                             allmodconfig
ia64                             allyesconfig
riscv                             allnoconfig
m68k                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
nios2                               defconfig
arc                              allyesconfig
csky                                defconfig
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
h8300                            allyesconfig
xtensa                           allyesconfig
arc                                 defconfig
sh                               allmodconfig
s390                                defconfig
s390                             allmodconfig
parisc                              defconfig
parisc                           allyesconfig
s390                             allyesconfig
sparc                               defconfig
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
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arc                  randconfig-r043-20220526
arc                  randconfig-r043-20220524
s390                 randconfig-r044-20220526
s390                 randconfig-r044-20220524
riscv                randconfig-r042-20220526
riscv                randconfig-r042-20220524
arc                  randconfig-r043-20220527
arc                  randconfig-r043-20220525
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
riscv                            allyesconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                                  kexec
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit

clang tested configs:
arm                  randconfig-c002-20220524
x86_64                        randconfig-c007
s390                 randconfig-c005-20220524
i386                          randconfig-c001
powerpc              randconfig-c003-20220524
riscv                randconfig-c006-20220524
mips                 randconfig-c004-20220524
powerpc                  mpc885_ads_defconfig
mips                      pic32mzda_defconfig
powerpc                       ebony_defconfig
mips                           ip28_defconfig
mips                         tb0287_defconfig
powerpc                      obs600_defconfig
arm                        mvebu_v5_defconfig
mips                  cavium_octeon_defconfig
mips                           ip22_defconfig
arm                     am200epdkit_defconfig
powerpc                          allyesconfig
powerpc                    mvme5100_defconfig
arm                      pxa255-idp_defconfig
arm                       aspeed_g4_defconfig
mips                     cu1830-neo_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r045-20220527
hexagon              randconfig-r041-20220527
s390                 randconfig-r044-20220527
riscv                randconfig-r042-20220527
hexagon              randconfig-r045-20220524
hexagon              randconfig-r045-20220526
hexagon              randconfig-r041-20220526
hexagon              randconfig-r041-20220524

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
