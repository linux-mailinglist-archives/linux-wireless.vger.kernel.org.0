Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6524557732A
	for <lists+linux-wireless@lfdr.de>; Sun, 17 Jul 2022 04:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbiGQCYI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 16 Jul 2022 22:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiGQCYI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 16 Jul 2022 22:24:08 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6442CB7E0
        for <linux-wireless@vger.kernel.org>; Sat, 16 Jul 2022 19:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658024647; x=1689560647;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=b2+S2zQ+26k/6yjEQWZUrhmrvJuHDpjLn1cc4L2VP64=;
  b=IOG+UwyS44QIDUkdna8bzau3OuOPl32oNilXTIM9jZga++82ebzNwm7B
   fRvWKxIODvNibsN24YDEMQPiPaqNtO4GX1x4dE6EadDAq6p8lxts1ayRT
   lWPD+DVomF9/Oie5ViX6Bqntb3uewr22nL7YKaa9z4DEyi2n132WCBQJt
   i/gHq5fs09QMjO1qBb/K+vfP61y28c7eOGQqTzktA32ZelbDexnmnPYBG
   OLhLdZCBvItHqwSVXrsz3A5JLf/OgPWP3NkOemTycFoISqOEnRxKw7noP
   6UjdAWcg90RJ7VLhE3npYXX6OLJ1pInbiALiVLnq7nEmiygroHO7IRKDO
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10410"; a="284777293"
X-IronPort-AV: E=Sophos;i="5.92,278,1650956400"; 
   d="scan'208";a="284777293"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2022 19:24:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,278,1650956400"; 
   d="scan'208";a="842917582"
Received: from lkp-server02.sh.intel.com (HELO ff137eb26ff1) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 16 Jul 2022 19:24:05 -0700
Received: from kbuild by ff137eb26ff1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oCtwz-0002X8-A5;
        Sun, 17 Jul 2022 02:24:05 +0000
Date:   Sun, 17 Jul 2022 10:23:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johannes Berg <johannes.berg@intel.com>
Cc:     linux-wireless@vger.kernel.org, Kalle Valo <kvalo@kernel.org>
Subject: [wireless-next:mld] BUILD SUCCESS
 a260edccf66f340a5fa9ff2ac740579097b3a206
Message-ID: <62d372b2.mMr8zYOuS5DH3mP3%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git mld
branch HEAD: a260edccf66f340a5fa9ff2ac740579097b3a206  wifi: mac80211: tx: use AP address in some places for MLO

elapsed time: 724m

configs tested: 130
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
powerpc              randconfig-c003-20220717
arm                     eseries_pxa_defconfig
mips                      loongson3_defconfig
x86_64                           alldefconfig
powerpc                 mpc837x_rdb_defconfig
powerpc                       holly_defconfig
arm                        multi_v7_defconfig
csky                              allnoconfig
sh                         ecovec24_defconfig
sh                         ap325rxa_defconfig
arm                          gemini_defconfig
arm                           sama5_defconfig
mips                           jazz_defconfig
arm                          simpad_defconfig
arm                       multi_v4t_defconfig
arm                      integrator_defconfig
openrisc                            defconfig
mips                        vocore2_defconfig
csky                                defconfig
loongarch                           defconfig
sh                               alldefconfig
powerpc                    sam440ep_defconfig
powerpc                     rainier_defconfig
arm                       omap2plus_defconfig
arm                           u8500_defconfig
loongarch                 loongson3_defconfig
alpha                               defconfig
sh                           se7750_defconfig
arm                        spear6xx_defconfig
powerpc                     tqm8548_defconfig
arm                         lpc18xx_defconfig
sh                          urquell_defconfig
mips                       bmips_be_defconfig
ia64                             alldefconfig
openrisc                 simple_smp_defconfig
powerpc                     tqm8555_defconfig
arm                        clps711x_defconfig
arm                           stm32_defconfig
arm                           h3600_defconfig
arm                          pxa910_defconfig
xtensa                         virt_defconfig
ia64                                defconfig
powerpc                      cm5200_defconfig
m68k                       m5208evb_defconfig
ia64                         bigsur_defconfig
xtensa                    smp_lx200_defconfig
powerpc                     asp8347_defconfig
nios2                            allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
alpha                             allnoconfig
arc                               allnoconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
i386                             allyesconfig
i386                                defconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
x86_64                    rhel-8.3-kselftests
x86_64                           allyesconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit

clang tested configs:
powerpc                     tqm5200_defconfig
mips                        qi_lb60_defconfig
powerpc                     kilauea_defconfig
powerpc                  mpc885_ads_defconfig
powerpc                    mvme5100_defconfig
arm                       aspeed_g4_defconfig
arm                          moxart_defconfig
powerpc                     ppa8548_defconfig
mips                      maltaaprp_defconfig
arm                        multi_v5_defconfig
arm                       imx_v4_v5_defconfig
riscv                          rv32_defconfig
powerpc                    socrates_defconfig
powerpc               mpc834x_itxgp_defconfig
mips                      malta_kvm_defconfig
mips                           ip28_defconfig
x86_64                        randconfig-k001
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
hexagon              randconfig-r045-20220716
hexagon              randconfig-r045-20220715
s390                 randconfig-r044-20220715
hexagon              randconfig-r041-20220716
hexagon              randconfig-r041-20220715
riscv                randconfig-r042-20220715
hexagon              randconfig-r045-20220717
s390                 randconfig-r044-20220717
hexagon              randconfig-r041-20220717
riscv                randconfig-r042-20220717

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
