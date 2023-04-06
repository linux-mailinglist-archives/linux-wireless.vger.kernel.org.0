Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C87A6D9E34
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Apr 2023 19:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbjDFRKI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 6 Apr 2023 13:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239605AbjDFRKF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 6 Apr 2023 13:10:05 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8CAE9017
        for <linux-wireless@vger.kernel.org>; Thu,  6 Apr 2023 10:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680801004; x=1712337004;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=V31+mBDKL4LYUs1NuCrFx6z15DLVcDX/QxFprer5qG8=;
  b=L2qEGLxF+CFN8nfpthO+TJ9l1ixaQEZiko2ACAhFpcQ62a6NCAqU6deC
   9buEMIYGeGZBh2xCr89+uK1meVMLj0n5+tlyj3BLqAa2krWNE3O5CGejp
   MM2uC+kRtkWF7u+lwTrBV0AaQwy7/HQssSDK/3SmoRnfuB9U/2hYZfcIE
   7XdG7V11I+PMGvRHQ1mFo58FcuCa9HSBeNPt76gzlTxbLmkNjoE6jy8bs
   UrB7Lot0RjNFzF5WVyB1McyufKN+Ya4n0UY7yD4YUezMAUQKQEtL9N/mD
   0BwYm2qIzBEfeVkiNrWu4++WQWIqoSios5XetkFQigy/KWrq836htEA82
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10672"; a="341528627"
X-IronPort-AV: E=Sophos;i="5.98,323,1673942400"; 
   d="scan'208";a="341528627"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2023 10:10:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10672"; a="719777600"
X-IronPort-AV: E=Sophos;i="5.98,323,1673942400"; 
   d="scan'208";a="719777600"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 06 Apr 2023 10:10:01 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pkT7Y-000RY5-13;
        Thu, 06 Apr 2023 17:10:00 +0000
Date:   Fri, 07 Apr 2023 01:09:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     linux-wireless@vger.kernel.org, Kalle Valo <kvalo@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>
Subject: [wireless-next:for-next] BUILD SUCCESS
 b536f32b5b034f592df0f0ba129ad59fa0f3e532
Message-ID: <642efcbe.OHH6N9EEdDwMY3ah%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git for-next
branch HEAD: b536f32b5b034f592df0f0ba129ad59fa0f3e532  net: stmmac: dwmac-imx: use platform specific reset for imx93 SoCs

elapsed time: 870m

configs tested: 204
configs skipped: 15

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r001-20230405   gcc  
alpha        buildonly-randconfig-r004-20230405   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r002-20230403   gcc  
alpha                randconfig-r005-20230403   gcc  
alpha                randconfig-r021-20230403   gcc  
alpha                randconfig-r033-20230406   gcc  
alpha                randconfig-r036-20230403   gcc  
alpha                randconfig-r036-20230404   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r001-20230405   gcc  
arc                  randconfig-r002-20230403   gcc  
arc                  randconfig-r004-20230403   gcc  
arc                  randconfig-r016-20230403   gcc  
arc                  randconfig-r021-20230403   gcc  
arc                  randconfig-r025-20230403   gcc  
arc                  randconfig-r033-20230403   gcc  
arc                  randconfig-r034-20230403   gcc  
arc                  randconfig-r043-20230403   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                        clps711x_defconfig   gcc  
arm                                 defconfig   gcc  
arm                           imxrt_defconfig   gcc  
arm                             pxa_defconfig   gcc  
arm                  randconfig-r005-20230405   gcc  
arm                  randconfig-r025-20230405   clang
arm                  randconfig-r034-20230403   gcc  
arm                  randconfig-r046-20230403   clang
arm                           sama5_defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r003-20230403   clang
arm64                               defconfig   gcc  
arm64                randconfig-r004-20230403   clang
arm64                randconfig-r012-20230403   gcc  
arm64                randconfig-r015-20230403   gcc  
arm64                randconfig-r021-20230405   gcc  
arm64                randconfig-r035-20230403   clang
csky         buildonly-randconfig-r001-20230403   gcc  
csky         buildonly-randconfig-r002-20230403   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r033-20230403   gcc  
hexagon      buildonly-randconfig-r001-20230403   clang
hexagon      buildonly-randconfig-r004-20230403   clang
hexagon      buildonly-randconfig-r006-20230404   clang
hexagon              randconfig-r006-20230403   clang
hexagon              randconfig-r012-20230403   clang
hexagon              randconfig-r024-20230403   clang
hexagon              randconfig-r024-20230405   clang
hexagon              randconfig-r035-20230403   clang
hexagon              randconfig-r041-20230403   clang
hexagon              randconfig-r045-20230403   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a001-20230403   clang
i386                 randconfig-a002-20230403   clang
i386                 randconfig-a003-20230403   clang
i386                 randconfig-a004-20230403   clang
i386                 randconfig-a005-20230403   clang
i386                 randconfig-a006-20230403   clang
i386                 randconfig-a011-20230403   gcc  
i386                 randconfig-a012-20230403   gcc  
i386                 randconfig-a013-20230403   gcc  
i386                 randconfig-a014-20230403   gcc  
i386                 randconfig-a015-20230403   gcc  
i386                 randconfig-a016-20230403   gcc  
i386                 randconfig-r022-20230403   gcc  
i386                 randconfig-r036-20230403   clang
ia64                             allmodconfig   gcc  
ia64         buildonly-randconfig-r006-20230403   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r002-20230403   gcc  
ia64                 randconfig-r024-20230403   gcc  
ia64                 randconfig-r026-20230403   gcc  
ia64                 randconfig-r026-20230405   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r006-20230403   gcc  
loongarch            randconfig-r013-20230403   gcc  
loongarch            randconfig-r022-20230403   gcc  
loongarch            randconfig-r026-20230403   gcc  
loongarch            randconfig-r032-20230406   gcc  
loongarch            randconfig-r034-20230406   gcc  
m68k                             allmodconfig   gcc  
m68k         buildonly-randconfig-r005-20230403   gcc  
m68k                                defconfig   gcc  
m68k                        m5407c3_defconfig   gcc  
m68k                 randconfig-r001-20230403   gcc  
m68k                 randconfig-r012-20230403   gcc  
m68k                 randconfig-r025-20230405   gcc  
m68k                 randconfig-r034-20230404   gcc  
m68k                 randconfig-r036-20230406   gcc  
microblaze   buildonly-randconfig-r006-20230403   gcc  
microblaze           randconfig-r005-20230403   gcc  
microblaze           randconfig-r023-20230403   gcc  
microblaze           randconfig-r023-20230405   gcc  
microblaze           randconfig-r024-20230403   gcc  
microblaze           randconfig-r031-20230403   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                      maltasmvp_defconfig   gcc  
mips                 randconfig-r002-20230405   gcc  
mips                 randconfig-r014-20230403   clang
mips                 randconfig-r022-20230405   clang
nios2                               defconfig   gcc  
nios2                randconfig-r014-20230403   gcc  
nios2                randconfig-r033-20230404   gcc  
openrisc     buildonly-randconfig-r001-20230403   gcc  
openrisc                            defconfig   gcc  
openrisc             randconfig-r011-20230403   gcc  
openrisc             randconfig-r025-20230403   gcc  
openrisc                 simple_smp_defconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r003-20230403   gcc  
parisc               randconfig-r003-20230405   gcc  
parisc               randconfig-r011-20230403   gcc  
parisc               randconfig-r022-20230405   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc      buildonly-randconfig-r003-20230404   clang
powerpc      buildonly-randconfig-r004-20230403   gcc  
powerpc      buildonly-randconfig-r005-20230403   gcc  
powerpc                      chrp32_defconfig   gcc  
powerpc                   currituck_defconfig   gcc  
powerpc                       eiger_defconfig   gcc  
powerpc                      pasemi_defconfig   gcc  
powerpc                         ps3_defconfig   gcc  
powerpc              randconfig-r005-20230403   clang
powerpc              randconfig-r012-20230403   gcc  
powerpc              randconfig-r013-20230403   gcc  
powerpc              randconfig-r014-20230403   gcc  
powerpc              randconfig-r036-20230403   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r021-20230403   gcc  
riscv                randconfig-r024-20230405   gcc  
riscv                randconfig-r031-20230406   gcc  
riscv                randconfig-r042-20230403   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390         buildonly-randconfig-r006-20230405   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r031-20230404   gcc  
s390                 randconfig-r044-20230403   gcc  
sh                               allmodconfig   gcc  
sh           buildonly-randconfig-r003-20230403   gcc  
sh                          polaris_defconfig   gcc  
sh                   randconfig-r001-20230403   gcc  
sh                   randconfig-r003-20230403   gcc  
sh                   randconfig-r013-20230403   gcc  
sh                   randconfig-r031-20230403   gcc  
sh                          rsk7264_defconfig   gcc  
sh                   sh7724_generic_defconfig   gcc  
sh                   sh7770_generic_defconfig   gcc  
sparc                            alldefconfig   gcc  
sparc        buildonly-randconfig-r001-20230403   gcc  
sparc        buildonly-randconfig-r002-20230403   gcc  
sparc        buildonly-randconfig-r004-20230403   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r001-20230403   gcc  
sparc                randconfig-r015-20230403   gcc  
sparc                randconfig-r016-20230403   gcc  
sparc                randconfig-r032-20230403   gcc  
sparc64      buildonly-randconfig-r006-20230403   gcc  
sparc64                             defconfig   gcc  
sparc64              randconfig-r014-20230403   gcc  
sparc64              randconfig-r022-20230403   gcc  
sparc64              randconfig-r035-20230406   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230403   clang
x86_64               randconfig-a002-20230403   clang
x86_64               randconfig-a003-20230403   clang
x86_64               randconfig-a004-20230403   clang
x86_64               randconfig-a005-20230403   clang
x86_64               randconfig-a006-20230403   clang
x86_64               randconfig-a011-20230403   gcc  
x86_64               randconfig-a012-20230403   gcc  
x86_64                        randconfig-a012   clang
x86_64               randconfig-a013-20230403   gcc  
x86_64               randconfig-a014-20230403   gcc  
x86_64                        randconfig-a014   clang
x86_64               randconfig-a015-20230403   gcc  
x86_64               randconfig-a016-20230403   gcc  
x86_64                        randconfig-a016   clang
x86_64               randconfig-k001-20230403   gcc  
x86_64               randconfig-r026-20230403   gcc  
x86_64               randconfig-r032-20230403   clang
x86_64                               rhel-8.3   gcc  
xtensa       buildonly-randconfig-r005-20230403   gcc  
xtensa               randconfig-r001-20230403   gcc  
xtensa               randconfig-r016-20230403   gcc  
xtensa               randconfig-r035-20230404   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
