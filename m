Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDAE170738F
	for <lists+linux-wireless@lfdr.de>; Wed, 17 May 2023 23:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbjEQVKo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 17 May 2023 17:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjEQVKn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 17 May 2023 17:10:43 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22BE055AE
        for <linux-wireless@vger.kernel.org>; Wed, 17 May 2023 14:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684357842; x=1715893842;
  h=date:from:to:cc:subject:message-id;
  bh=4hUV/bJNMRGgcjrC3yN+7lmx4eQupqq828oLBc7OuOM=;
  b=fNmyuSeDT/a5T1w+bK0jLl5H2hFxluQC0XnyThVtxaJTQScSNSDKq61k
   fCbgu0NesCqjJ2/Ewgig4tDBX88aCwuHdylnOCc4kacMfK8AGayqCpRxu
   G08b2Ukg+20TKVINKcyAeBw5xbC6eOVNi43XH9xK5dtUwqFXdwuBqzGbe
   S/yPmyXIML9mi3PR7wRGmJbffT4Ze0Qx7LO3AYtL295Lydiv1HWykLKP5
   9xOjAKu9ryzDqDi6APmpTLsMEcHlAvYidVdHKQzRpR1xt97PlW7Jywcln
   /ghv6oHtGubE5L4fEG4flPKqRnsA70g5zICecC9gGVpE9nRtCLkqsGf8n
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="331492212"
X-IronPort-AV: E=Sophos;i="5.99,283,1677571200"; 
   d="scan'208";a="331492212"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2023 14:10:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10713"; a="791655603"
X-IronPort-AV: E=Sophos;i="5.99,283,1677571200"; 
   d="scan'208";a="791655603"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 17 May 2023 14:10:39 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pzOPv-0009ET-03;
        Wed, 17 May 2023 21:10:39 +0000
Date:   Thu, 18 May 2023 05:10:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
Subject: [wireless-next:main] BUILD SUCCESS
 3f2da9fc17f66af17a1349d4d32f6a6ba245b94d
Message-ID: <20230517211005.0PrMb%lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: INFO setup_repo_specs: /db/releases/20230517200055/lkp-src/repo/*/wireless-next
https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: 3f2da9fc17f66af17a1349d4d32f6a6ba245b94d  wifi: rtw89: 8851b: rfk: add TSSI

elapsed time: 725m

configs tested: 245
configs skipped: 15

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r001-20230517   gcc  
alpha        buildonly-randconfig-r002-20230517   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r013-20230517   gcc  
alpha                randconfig-r015-20230517   gcc  
alpha                randconfig-r024-20230517   gcc  
alpha                randconfig-r034-20230517   gcc  
alpha                randconfig-r035-20230517   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r005-20230517   gcc  
arc          buildonly-randconfig-r006-20230517   gcc  
arc                                 defconfig   gcc  
arc                        nsimosci_defconfig   gcc  
arc                  randconfig-r001-20230517   gcc  
arc                  randconfig-r022-20230517   gcc  
arc                  randconfig-r025-20230517   gcc  
arc                  randconfig-r043-20230517   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                      jornada720_defconfig   gcc  
arm                        keystone_defconfig   gcc  
arm                        mvebu_v7_defconfig   gcc  
arm                  randconfig-r001-20230517   gcc  
arm                  randconfig-r006-20230517   gcc  
arm                  randconfig-r031-20230517   gcc  
arm                  randconfig-r034-20230517   gcc  
arm                  randconfig-r035-20230517   gcc  
arm                  randconfig-r036-20230517   gcc  
arm                  randconfig-r046-20230517   clang
arm                           u8500_defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r011-20230517   gcc  
arm64                randconfig-r014-20230517   gcc  
arm64                randconfig-r023-20230517   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r006-20230517   gcc  
csky                 randconfig-r024-20230517   gcc  
csky                 randconfig-r025-20230517   gcc  
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
ia64         buildonly-randconfig-r003-20230517   gcc  
ia64                                defconfig   gcc  
ia64                      gensparse_defconfig   gcc  
ia64                 randconfig-r005-20230517   gcc  
ia64                 randconfig-r012-20230517   gcc  
ia64                 randconfig-r013-20230517   gcc  
ia64                 randconfig-r014-20230517   gcc  
ia64                 randconfig-r023-20230517   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch    buildonly-randconfig-r002-20230517   gcc  
loongarch    buildonly-randconfig-r005-20230517   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r002-20230517   gcc  
loongarch            randconfig-r003-20230517   gcc  
loongarch            randconfig-r004-20230517   gcc  
loongarch            randconfig-r011-20230517   gcc  
loongarch            randconfig-r032-20230517   gcc  
loongarch            randconfig-r033-20230517   gcc  
loongarch            randconfig-r035-20230517   gcc  
m68k                             alldefconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                        mvme16x_defconfig   gcc  
m68k                 randconfig-r005-20230517   gcc  
m68k                 randconfig-r015-20230517   gcc  
m68k                 randconfig-r023-20230517   gcc  
microblaze   buildonly-randconfig-r003-20230517   gcc  
microblaze   buildonly-randconfig-r005-20230517   gcc  
microblaze           randconfig-r006-20230517   gcc  
microblaze           randconfig-r021-20230517   gcc  
microblaze           randconfig-r025-20230517   gcc  
microblaze           randconfig-r031-20230517   gcc  
microblaze           randconfig-r033-20230517   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                        maltaup_defconfig   clang
mips                 randconfig-r002-20230517   gcc  
mips                 randconfig-r003-20230517   gcc  
mips                 randconfig-r006-20230517   gcc  
mips                 randconfig-r015-20230517   clang
mips                 randconfig-r016-20230517   clang
mips                 randconfig-r023-20230517   clang
mips                 randconfig-r032-20230517   gcc  
nios2                         10m50_defconfig   gcc  
nios2        buildonly-randconfig-r002-20230517   gcc  
nios2        buildonly-randconfig-r006-20230517   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r003-20230517   gcc  
nios2                randconfig-r004-20230517   gcc  
nios2                randconfig-r011-20230517   gcc  
nios2                randconfig-r023-20230517   gcc  
nios2                randconfig-r025-20230517   gcc  
nios2                randconfig-r032-20230517   gcc  
openrisc     buildonly-randconfig-r004-20230517   gcc  
openrisc             randconfig-r001-20230517   gcc  
openrisc             randconfig-r002-20230517   gcc  
openrisc             randconfig-r003-20230517   gcc  
openrisc             randconfig-r004-20230517   gcc  
openrisc             randconfig-r013-20230517   gcc  
openrisc             randconfig-r031-20230517   gcc  
openrisc             randconfig-r035-20230517   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r002-20230517   gcc  
parisc               randconfig-r016-20230517   gcc  
parisc               randconfig-r026-20230517   gcc  
parisc               randconfig-r032-20230517   gcc  
parisc               randconfig-r033-20230517   gcc  
parisc64                            defconfig   gcc  
powerpc                    adder875_defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc      buildonly-randconfig-r004-20230517   gcc  
powerpc                        fsp2_defconfig   clang
powerpc                       maple_defconfig   gcc  
powerpc                 mpc837x_rdb_defconfig   gcc  
powerpc              randconfig-r012-20230517   gcc  
powerpc              randconfig-r014-20230517   gcc  
powerpc                     tqm5200_defconfig   clang
powerpc                      walnut_defconfig   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv        buildonly-randconfig-r001-20230517   gcc  
riscv        buildonly-randconfig-r003-20230517   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r011-20230517   gcc  
riscv                randconfig-r014-20230517   gcc  
riscv                randconfig-r015-20230517   gcc  
riscv                randconfig-r024-20230517   gcc  
riscv                randconfig-r026-20230517   gcc  
riscv                randconfig-r032-20230517   clang
riscv                randconfig-r042-20230517   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390         buildonly-randconfig-r004-20230517   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r003-20230517   clang
s390                 randconfig-r004-20230517   clang
s390                 randconfig-r005-20230517   clang
s390                 randconfig-r016-20230517   gcc  
s390                 randconfig-r021-20230517   gcc  
s390                 randconfig-r022-20230517   gcc  
s390                 randconfig-r031-20230517   clang
s390                 randconfig-r032-20230517   clang
s390                 randconfig-r044-20230517   gcc  
sh                               allmodconfig   gcc  
sh           buildonly-randconfig-r004-20230517   gcc  
sh           buildonly-randconfig-r005-20230517   gcc  
sh           buildonly-randconfig-r006-20230517   gcc  
sh                          polaris_defconfig   gcc  
sh                   randconfig-r001-20230517   gcc  
sh                   randconfig-r005-20230517   gcc  
sh                   randconfig-r013-20230517   gcc  
sh                   randconfig-r021-20230517   gcc  
sh                   randconfig-r022-20230517   gcc  
sh                   randconfig-r024-20230517   gcc  
sh                   randconfig-r025-20230517   gcc  
sh                   randconfig-r036-20230517   gcc  
sh                          rsk7269_defconfig   gcc  
sh                           se7619_defconfig   gcc  
sh                           se7721_defconfig   gcc  
sh                           se7722_defconfig   gcc  
sh                           se7780_defconfig   gcc  
sh                   secureedge5410_defconfig   gcc  
sh                        sh7785lcr_defconfig   gcc  
sh                             shx3_defconfig   gcc  
sh                              ul2_defconfig   gcc  
sh                          urquell_defconfig   gcc  
sparc        buildonly-randconfig-r002-20230517   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r001-20230517   gcc  
sparc                randconfig-r003-20230517   gcc  
sparc                randconfig-r021-20230517   gcc  
sparc                randconfig-r022-20230517   gcc  
sparc                randconfig-r024-20230517   gcc  
sparc                randconfig-r036-20230517   gcc  
sparc                       sparc64_defconfig   gcc  
sparc64      buildonly-randconfig-r001-20230517   gcc  
sparc64      buildonly-randconfig-r005-20230517   gcc  
sparc64              randconfig-r005-20230517   gcc  
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
xtensa               randconfig-r004-20230517   gcc  
xtensa               randconfig-r026-20230517   gcc  
xtensa               randconfig-r031-20230517   gcc  
xtensa               randconfig-r032-20230517   gcc  
xtensa                    xip_kc705_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
