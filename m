Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D20B70710B
	for <lists+linux-wireless@lfdr.de>; Wed, 17 May 2023 20:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbjEQSqf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 17 May 2023 14:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjEQSqe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 17 May 2023 14:46:34 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF0B81BC
        for <linux-wireless@vger.kernel.org>; Wed, 17 May 2023 11:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684349193; x=1715885193;
  h=date:from:to:cc:subject:message-id;
  bh=eIdVA+ITgsROhXDHdOrrL5mrCHvEzzZuzooxlybejJw=;
  b=SlSmcTZnJeFMvFna4jXlKWXUjj/QJPS7S/iCNx7tWj0SCGyKcbubOn7P
   EmVJAdXAvaTbWR7pJdkW4vt21itLjXMNy4Hsn7MMcdMcCSETeBuVNISFt
   zeLfF7xBsisIHd3P0lP8GF1//csON5U0FMXyAwq0i7V38REKm+0xh+ujl
   XYoVcdvHsew4U98AfRuSZdJTiuVR1BJA3ZU9P1rdsrSdveSamzrvAGlZ7
   k2ToabbHkaVGfG6e6WOWoU/B/XWcvilGU/z9POnZpJvbWd9QwzOgy/Uad
   2hzHPsy06xAatHwbhL9vj8SyTzbyJ4OJN/5y20cCZbw/XHfO8G3qbdbde
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="415263344"
X-IronPort-AV: E=Sophos;i="5.99,283,1677571200"; 
   d="scan'208";a="415263344"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2023 11:46:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="652340164"
X-IronPort-AV: E=Sophos;i="5.99,283,1677571200"; 
   d="scan'208";a="652340164"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 17 May 2023 11:46:31 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pzMAQ-00098u-1G;
        Wed, 17 May 2023 18:46:30 +0000
Date:   Thu, 18 May 2023 02:45:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
Subject: [wireless:for-next] BUILD SUCCESS
 212457ccbd60dba34f965e4ffbe62f0e4f970538
Message-ID: <20230517184542.kMIal%lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: INFO setup_repo_specs: /db/releases/20230517200055/lkp-src/repo/*/wireless
https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git for-next
branch HEAD: 212457ccbd60dba34f965e4ffbe62f0e4f970538  wifi: b43: fix incorrect __packed annotation

elapsed time: 729m

configs tested: 278
configs skipped: 21

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r001-20230517   gcc  
alpha        buildonly-randconfig-r005-20230517   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r003-20230517   gcc  
alpha                randconfig-r014-20230517   gcc  
alpha                randconfig-r022-20230517   gcc  
alpha                randconfig-r024-20230517   gcc  
alpha                randconfig-r033-20230517   gcc  
alpha                randconfig-r034-20230517   gcc  
alpha                randconfig-r036-20230517   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r005-20230517   gcc  
arc          buildonly-randconfig-r006-20230517   gcc  
arc                                 defconfig   gcc  
arc                        nsim_700_defconfig   gcc  
arc                        nsimosci_defconfig   gcc  
arc                  randconfig-r001-20230517   gcc  
arc                  randconfig-r004-20230517   gcc  
arc                  randconfig-r022-20230517   gcc  
arc                  randconfig-r023-20230517   gcc  
arc                  randconfig-r031-20230517   gcc  
arc                  randconfig-r043-20230517   gcc  
arc                    vdk_hs38_smp_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm          buildonly-randconfig-r001-20230517   clang
arm                        clps711x_defconfig   gcc  
arm                          collie_defconfig   clang
arm                                 defconfig   gcc  
arm                          exynos_defconfig   gcc  
arm                           h3600_defconfig   gcc  
arm                            hisi_defconfig   gcc  
arm                      jornada720_defconfig   gcc  
arm                            mmp2_defconfig   clang
arm                        mvebu_v7_defconfig   gcc  
arm                  randconfig-r025-20230517   clang
arm                  randconfig-r031-20230517   gcc  
arm                  randconfig-r034-20230517   gcc  
arm                  randconfig-r035-20230517   gcc  
arm                  randconfig-r036-20230517   gcc  
arm                  randconfig-r046-20230517   clang
arm                        shmobile_defconfig   gcc  
arm                       versatile_defconfig   clang
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r003-20230517   clang
arm64                               defconfig   gcc  
arm64                randconfig-r006-20230517   clang
arm64                randconfig-r014-20230517   gcc  
arm64                randconfig-r015-20230517   gcc  
arm64                randconfig-r023-20230517   gcc  
arm64                randconfig-r024-20230517   gcc  
csky         buildonly-randconfig-r004-20230517   gcc  
csky         buildonly-randconfig-r005-20230517   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r004-20230517   gcc  
csky                 randconfig-r006-20230517   gcc  
csky                 randconfig-r021-20230517   gcc  
csky                 randconfig-r024-20230517   gcc  
csky                 randconfig-r025-20230517   gcc  
hexagon      buildonly-randconfig-r004-20230517   clang
hexagon              randconfig-r012-20230517   clang
hexagon              randconfig-r016-20230517   clang
hexagon              randconfig-r035-20230517   clang
hexagon              randconfig-r041-20230517   clang
hexagon              randconfig-r045-20230517   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                          randconfig-a001   gcc  
i386                          randconfig-a002   clang
i386                          randconfig-a003   gcc  
i386                          randconfig-a004   clang
i386                          randconfig-a005   gcc  
i386                          randconfig-a006   clang
i386                          randconfig-a011   clang
i386                          randconfig-a012   gcc  
i386                          randconfig-a013   clang
i386                          randconfig-a014   gcc  
i386                          randconfig-a015   clang
i386                          randconfig-a016   gcc  
ia64                             allmodconfig   gcc  
ia64         buildonly-randconfig-r002-20230517   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r005-20230517   gcc  
ia64                 randconfig-r013-20230517   gcc  
ia64                 randconfig-r022-20230517   gcc  
ia64                 randconfig-r023-20230517   gcc  
ia64                 randconfig-r035-20230517   gcc  
ia64                 randconfig-r036-20230517   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch    buildonly-randconfig-r002-20230517   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r001-20230517   gcc  
loongarch            randconfig-r003-20230517   gcc  
loongarch            randconfig-r004-20230517   gcc  
loongarch            randconfig-r011-20230517   gcc  
loongarch            randconfig-r022-20230517   gcc  
loongarch            randconfig-r023-20230517   gcc  
loongarch            randconfig-r033-20230517   gcc  
loongarch            randconfig-r034-20230517   gcc  
loongarch            randconfig-r035-20230517   gcc  
m68k                             allmodconfig   gcc  
m68k                         amcore_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                        mvme16x_defconfig   gcc  
m68k                 randconfig-r014-20230517   gcc  
m68k                 randconfig-r015-20230517   gcc  
m68k                 randconfig-r023-20230517   gcc  
m68k                 randconfig-r034-20230517   gcc  
m68k                 randconfig-r036-20230517   gcc  
microblaze   buildonly-randconfig-r002-20230517   gcc  
microblaze   buildonly-randconfig-r003-20230517   gcc  
microblaze           randconfig-r003-20230517   gcc  
microblaze           randconfig-r006-20230517   gcc  
microblaze           randconfig-r012-20230517   gcc  
microblaze           randconfig-r021-20230517   gcc  
microblaze           randconfig-r025-20230517   gcc  
microblaze           randconfig-r031-20230517   gcc  
microblaze           randconfig-r033-20230517   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                           ci20_defconfig   gcc  
mips                           ip22_defconfig   clang
mips                           ip27_defconfig   clang
mips                     loongson1c_defconfig   clang
mips                      maltasmvp_defconfig   gcc  
mips                 randconfig-r006-20230517   gcc  
mips                 randconfig-r032-20230517   gcc  
mips                 randconfig-r034-20230517   gcc  
mips                        vocore2_defconfig   gcc  
mips                           xway_defconfig   gcc  
nios2                         10m50_defconfig   gcc  
nios2                            allyesconfig   gcc  
nios2        buildonly-randconfig-r006-20230517   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r003-20230517   gcc  
nios2                randconfig-r004-20230517   gcc  
nios2                randconfig-r013-20230517   gcc  
nios2                randconfig-r023-20230517   gcc  
nios2                randconfig-r025-20230517   gcc  
openrisc     buildonly-randconfig-r002-20230517   gcc  
openrisc             randconfig-r002-20230517   gcc  
openrisc             randconfig-r011-20230517   gcc  
openrisc             randconfig-r012-20230517   gcc  
openrisc             randconfig-r013-20230517   gcc  
openrisc             randconfig-r035-20230517   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r002-20230517   gcc  
parisc               randconfig-r011-20230517   gcc  
parisc               randconfig-r016-20230517   gcc  
parisc               randconfig-r024-20230517   gcc  
parisc               randconfig-r026-20230517   gcc  
parisc               randconfig-r032-20230517   gcc  
parisc64                            defconfig   gcc  
powerpc                    adder875_defconfig   gcc  
powerpc                          allmodconfig   clang
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc      buildonly-randconfig-r004-20230517   gcc  
powerpc                 linkstation_defconfig   gcc  
powerpc                       maple_defconfig   gcc  
powerpc                 mpc837x_rdb_defconfig   gcc  
powerpc                  mpc866_ads_defconfig   clang
powerpc              randconfig-r011-20230517   gcc  
powerpc              randconfig-r016-20230517   gcc  
powerpc                    socrates_defconfig   clang
powerpc                  storcenter_defconfig   gcc  
powerpc                     tqm5200_defconfig   clang
powerpc                        warp_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv        buildonly-randconfig-r001-20230517   gcc  
riscv        buildonly-randconfig-r003-20230517   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r001-20230517   clang
riscv                randconfig-r002-20230517   clang
riscv                randconfig-r005-20230517   clang
riscv                randconfig-r014-20230517   gcc  
riscv                randconfig-r024-20230517   gcc  
riscv                randconfig-r026-20230517   gcc  
riscv                randconfig-r032-20230517   clang
riscv                randconfig-r042-20230517   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390         buildonly-randconfig-r001-20230517   gcc  
s390         buildonly-randconfig-r006-20230517   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r003-20230517   clang
s390                 randconfig-r004-20230517   clang
s390                 randconfig-r005-20230517   clang
s390                 randconfig-r021-20230517   gcc  
s390                 randconfig-r022-20230517   gcc  
s390                 randconfig-r026-20230517   gcc  
s390                 randconfig-r031-20230517   clang
s390                 randconfig-r044-20230517   gcc  
sh                               alldefconfig   gcc  
sh                               allmodconfig   gcc  
sh           buildonly-randconfig-r003-20230517   gcc  
sh           buildonly-randconfig-r004-20230517   gcc  
sh           buildonly-randconfig-r005-20230517   gcc  
sh                          polaris_defconfig   gcc  
sh                   randconfig-r002-20230517   gcc  
sh                   randconfig-r005-20230517   gcc  
sh                   randconfig-r015-20230517   gcc  
sh                   randconfig-r021-20230517   gcc  
sh                   randconfig-r022-20230517   gcc  
sh                   randconfig-r024-20230517   gcc  
sh                   randconfig-r025-20230517   gcc  
sh                   randconfig-r036-20230517   gcc  
sh                          rsk7269_defconfig   gcc  
sh                           se7721_defconfig   gcc  
sh                           se7751_defconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r001-20230517   gcc  
sparc                randconfig-r003-20230517   gcc  
sparc                randconfig-r016-20230517   gcc  
sparc                randconfig-r021-20230517   gcc  
sparc                randconfig-r022-20230517   gcc  
sparc                randconfig-r023-20230517   gcc  
sparc                randconfig-r024-20230517   gcc  
sparc                randconfig-r032-20230517   gcc  
sparc                randconfig-r033-20230517   gcc  
sparc                       sparc64_defconfig   gcc  
sparc64      buildonly-randconfig-r004-20230517   gcc  
sparc64      buildonly-randconfig-r005-20230517   gcc  
sparc64              randconfig-r005-20230517   gcc  
sparc64              randconfig-r012-20230517   gcc  
sparc64              randconfig-r016-20230517   gcc  
sparc64              randconfig-r026-20230517   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                        randconfig-a001   clang
x86_64                        randconfig-a002   gcc  
x86_64                        randconfig-a003   clang
x86_64                        randconfig-a004   gcc  
x86_64                        randconfig-a005   clang
x86_64                        randconfig-a006   gcc  
x86_64                        randconfig-a011   gcc  
x86_64                        randconfig-a012   clang
x86_64                        randconfig-a013   gcc  
x86_64                        randconfig-a014   clang
x86_64                        randconfig-a015   gcc  
x86_64                        randconfig-a016   clang
x86_64                        randconfig-k001   clang
x86_64                        randconfig-x051   gcc  
x86_64                        randconfig-x052   clang
x86_64                        randconfig-x053   gcc  
x86_64                        randconfig-x054   clang
x86_64                        randconfig-x055   gcc  
x86_64                        randconfig-x056   clang
x86_64                        randconfig-x061   gcc  
x86_64                        randconfig-x062   clang
x86_64                        randconfig-x063   gcc  
x86_64                        randconfig-x064   clang
x86_64                        randconfig-x065   gcc  
x86_64                        randconfig-x066   clang
x86_64                          rhel-8.3-func   gcc  
x86_64                    rhel-8.3-kselftests   gcc  
x86_64                           rhel-8.3-ltp   gcc  
x86_64                               rhel-8.3   gcc  
xtensa                           alldefconfig   gcc  
xtensa       buildonly-randconfig-r001-20230517   gcc  
xtensa       buildonly-randconfig-r003-20230517   gcc  
xtensa       buildonly-randconfig-r004-20230517   gcc  
xtensa                  nommu_kc705_defconfig   gcc  
xtensa               randconfig-r004-20230517   gcc  
xtensa               randconfig-r006-20230517   gcc  
xtensa               randconfig-r012-20230517   gcc  
xtensa               randconfig-r025-20230517   gcc  
xtensa               randconfig-r032-20230517   gcc  
xtensa                    smp_lx200_defconfig   gcc  
xtensa                    xip_kc705_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
