Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 360C54C9B73
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Mar 2022 03:50:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235652AbiCBCv3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Mar 2022 21:51:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239167AbiCBCv0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Mar 2022 21:51:26 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48B65AB473
        for <linux-wireless@vger.kernel.org>; Tue,  1 Mar 2022 18:50:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646189444; x=1677725444;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=KQka5WhCgDBhIHey/B8wermvm1DG8eXv9jTxfWg2z7I=;
  b=c+ZcwEwOf+NWQ2LyDHq11tu8V66b//44MKs1DtSr2XdA92n6a/f7d4M3
   Z9uSD+hljiCYqxtPTESQeYLpybEvoTtPAnAX8Ksno/h+U0zjXJceq1xfB
   JSDvYGZfVtVm96Fhxb+0CqGMsiryF1iXJpvq7lq5ZQZe0mmXb6l5okuBC
   iOi1woW2zSpWWQjdu8OWB5ZXqnFM5V4xpyf5+eFQsE5xJ8/kKBXndbW7B
   Nql1gR4VzMaesl8ER0LF43F59bk1GKFBO7kIFyNst+MjadSe4lFOpaY5b
   XsKDmw0GKnpXm8+bmmCZUmeP62/Jty2TyqMHsc2Oz/Mkw9aM7ddeiHXrp
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10273"; a="339725585"
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="339725585"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2022 18:50:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="709335767"
Received: from lkp-server02.sh.intel.com (HELO e9605edfa585) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 01 Mar 2022 18:50:31 -0800
Received: from kbuild by e9605edfa585 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nPF4Q-0000g8-Fg; Wed, 02 Mar 2022 02:50:30 +0000
Date:   Wed, 02 Mar 2022 09:56:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johannes Berg <johannes.berg@intel.com>
Cc:     linux-wireless@vger.kernel.org, Kalle Valo <kvalo@kernel.org>
Subject: [wireless:main] BUILD SUCCESS
 a12f76345e026f1b300a0d17c56f020b6949b093
Message-ID: <621ecedb.QiEksGxQ4/69YNxI%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git main
branch HEAD: a12f76345e026f1b300a0d17c56f020b6949b093  cfg80211: fix CONFIG_CFG80211_EXTRA_REGDB_KEYDIR typo

elapsed time: 725m

configs tested: 145
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                          randconfig-c001
sh                          kfr2r09_defconfig
mips                     loongson1b_defconfig
powerpc                 mpc837x_mds_defconfig
sh                     magicpanelr2_defconfig
h8300                       h8s-sim_defconfig
nios2                         10m50_defconfig
mips                           jazz_defconfig
openrisc                  or1klitex_defconfig
csky                             alldefconfig
arm                        mvebu_v7_defconfig
sh                             shx3_defconfig
powerpc                         ps3_defconfig
arm                       multi_v4t_defconfig
arc                                 defconfig
ia64                            zx1_defconfig
arm                          iop32x_defconfig
arm                     eseries_pxa_defconfig
powerpc                      mgcoge_defconfig
arc                    vdk_hs38_smp_defconfig
mips                        vocore2_defconfig
powerpc                      tqm8xx_defconfig
arm                         nhk8815_defconfig
sh                           se7722_defconfig
sh                               alldefconfig
powerpc                     ep8248e_defconfig
powerpc                mpc7448_hpc2_defconfig
xtensa                              defconfig
arm                        oxnas_v6_defconfig
arc                           tb10x_defconfig
arm                           h5000_defconfig
xtensa                       common_defconfig
mips                         db1xxx_defconfig
xtensa                  audio_kc705_defconfig
powerpc                        cell_defconfig
arm                        trizeps4_defconfig
sh                          polaris_defconfig
sh                          urquell_defconfig
arm                          gemini_defconfig
sh                        sh7757lcr_defconfig
mips                            ar7_defconfig
powerpc                      arches_defconfig
powerpc                        warp_defconfig
mips                           ip32_defconfig
sh                            hp6xx_defconfig
arm                            zeus_defconfig
arm                         assabet_defconfig
sh                           se7343_defconfig
mips                  decstation_64_defconfig
sh                            migor_defconfig
m68k                        stmark2_defconfig
arm                       imx_v6_v7_defconfig
microblaze                          defconfig
m68k                          multi_defconfig
riscv                    nommu_k210_defconfig
ia64                        generic_defconfig
sh                          lboxre2_defconfig
arm                         axm55xx_defconfig
sh                         ecovec24_defconfig
sh                           se7780_defconfig
arm                  randconfig-c002-20220301
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
arc                  randconfig-r043-20220301
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                                  kexec

clang tested configs:
x86_64                        randconfig-c007
powerpc              randconfig-c003-20220301
riscv                randconfig-c006-20220301
i386                          randconfig-c001
arm                  randconfig-c002-20220301
mips                 randconfig-c004-20220301
powerpc                     mpc5200_defconfig
arm                                 defconfig
powerpc                  mpc866_ads_defconfig
arm                          imote2_defconfig
powerpc                      walnut_defconfig
riscv                    nommu_virt_defconfig
arm                         bcm2835_defconfig
arm                         palmz72_defconfig
arm                         orion5x_defconfig
powerpc                        fsp2_defconfig
arm                        spear3xx_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r045-20220301
hexagon              randconfig-r041-20220301
riscv                randconfig-r042-20220301
s390                 randconfig-r044-20220301

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
