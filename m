Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 897776FFEF4
	for <lists+linux-wireless@lfdr.de>; Fri, 12 May 2023 04:25:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233931AbjELCZi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 11 May 2023 22:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231446AbjELCZh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 11 May 2023 22:25:37 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14E254C26
        for <linux-wireless@vger.kernel.org>; Thu, 11 May 2023 19:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683858336; x=1715394336;
  h=date:from:to:cc:subject:message-id;
  bh=yls+V/HylUR4/YODfqv2siw/dcBtoK4zirtWp4hNgR0=;
  b=d4ynfd4xEsrOYT2eP4Q1PXcW3WxZ6nRE49Z8thZPNdqVGA3xnAZPvbnv
   CT/aa6K9zUKO0+jdHPEdVJTVsQ7uAQ9yvzyZ9R7PvAPA27OLjjr2mGs3t
   5toFzgclZwrmEBiOfsAJki9Oa2sYdQgc9hAlaM7MbUN2sl+hPwTEk3bUC
   ksTAng9F9oIcLScZHkAU405P+520mFu4dxrxXgSQFfKYo9IPNt64qpTZQ
   NCqm4zwmAIhNYPRCPbNQEz+ePBIYaFvc9k5L63gULby362tMitj1lUeAM
   HJ8Gc308ocIBq/59m0ZZiPcJ3fNeSotfaeMf9fIumzVepn/1D8NAe5UBy
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="335199397"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="335199397"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2023 19:25:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="1029877095"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="1029877095"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 11 May 2023 19:25:34 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pxITN-0004Qn-1y;
        Fri, 12 May 2023 02:25:33 +0000
Date:   Fri, 12 May 2023 10:25:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
Subject: [wireless-next:main] BUILD SUCCESS
 8130e94e888bf90e495f88d1a1e63c43e1cfbc18
Message-ID: <20230512022518.G2MZ5%lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: 8130e94e888bf90e495f88d1a1e63c43e1cfbc18  wifi: rtw89: suppress the log for specific SER called CMDPSR_FRZTO

elapsed time: 731m

configs tested: 176
configs skipped: 22

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r003-20230511   gcc  
alpha        buildonly-randconfig-r005-20230509   gcc  
alpha        buildonly-randconfig-r006-20230511   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r015-20230509   gcc  
alpha                randconfig-r034-20230509   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r006-20230511   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r005-20230509   gcc  
arc                  randconfig-r011-20230509   gcc  
arc                  randconfig-r016-20230511   gcc  
arc                  randconfig-r023-20230509   gcc  
arc                  randconfig-r025-20230509   gcc  
arc                  randconfig-r031-20230509   gcc  
arc                  randconfig-r043-20230509   gcc  
arc                  randconfig-r043-20230511   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm          buildonly-randconfig-r002-20230511   clang
arm                                 defconfig   gcc  
arm                  randconfig-r002-20230511   gcc  
arm                  randconfig-r024-20230509   gcc  
arm                  randconfig-r033-20230509   clang
arm                  randconfig-r046-20230509   gcc  
arm                  randconfig-r046-20230511   clang
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r002-20230511   clang
arm64                               defconfig   gcc  
arm64                randconfig-r014-20230511   gcc  
arm64                randconfig-r032-20230511   clang
arm64                randconfig-r035-20230511   clang
arm64                randconfig-r036-20230509   gcc  
csky         buildonly-randconfig-r003-20230509   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r001-20230509   gcc  
csky                 randconfig-r002-20230509   gcc  
csky                 randconfig-r011-20230509   gcc  
csky                 randconfig-r022-20230511   gcc  
csky                 randconfig-r032-20230509   gcc  
hexagon              randconfig-r026-20230511   clang
hexagon              randconfig-r041-20230509   clang
hexagon              randconfig-r041-20230511   clang
hexagon              randconfig-r045-20230509   clang
hexagon              randconfig-r045-20230511   clang
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
ia64                                defconfig   gcc  
ia64                 randconfig-r026-20230509   gcc  
ia64                 randconfig-r031-20230511   gcc  
ia64                 randconfig-r035-20230509   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r006-20230509   gcc  
loongarch            randconfig-r021-20230509   gcc  
loongarch            randconfig-r021-20230511   gcc  
loongarch            randconfig-r035-20230509   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r006-20230511   gcc  
m68k                 randconfig-r014-20230509   gcc  
microblaze   buildonly-randconfig-r002-20230509   gcc  
microblaze   buildonly-randconfig-r004-20230509   gcc  
microblaze   buildonly-randconfig-r004-20230511   gcc  
microblaze   buildonly-randconfig-r005-20230511   gcc  
microblaze           randconfig-r004-20230509   gcc  
microblaze           randconfig-r005-20230509   gcc  
microblaze           randconfig-r012-20230511   gcc  
microblaze           randconfig-r036-20230509   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips         buildonly-randconfig-r004-20230511   gcc  
mips                 randconfig-r001-20230511   gcc  
mips                 randconfig-r011-20230511   clang
mips                 randconfig-r016-20230509   gcc  
mips                 randconfig-r022-20230509   gcc  
mips                 randconfig-r023-20230511   clang
mips                 randconfig-r036-20230511   gcc  
nios2        buildonly-randconfig-r001-20230511   gcc  
nios2        buildonly-randconfig-r006-20230509   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r005-20230511   gcc  
nios2                randconfig-r012-20230509   gcc  
nios2                randconfig-r016-20230511   gcc  
nios2                randconfig-r024-20230511   gcc  
nios2                randconfig-r026-20230509   gcc  
nios2                randconfig-r034-20230511   gcc  
openrisc             randconfig-r002-20230511   gcc  
openrisc             randconfig-r004-20230511   gcc  
openrisc             randconfig-r031-20230511   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r001-20230509   gcc  
parisc               randconfig-r003-20230509   gcc  
parisc               randconfig-r003-20230511   gcc  
parisc               randconfig-r013-20230511   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc      buildonly-randconfig-r004-20230509   clang
powerpc              randconfig-r004-20230509   gcc  
powerpc              randconfig-r015-20230511   gcc  
powerpc              randconfig-r024-20230509   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv        buildonly-randconfig-r005-20230511   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r022-20230509   clang
riscv                randconfig-r025-20230511   gcc  
riscv                randconfig-r034-20230511   clang
riscv                randconfig-r042-20230509   clang
riscv                randconfig-r042-20230511   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390         buildonly-randconfig-r001-20230511   gcc  
s390         buildonly-randconfig-r002-20230509   clang
s390                                defconfig   gcc  
s390                 randconfig-r002-20230509   gcc  
s390                 randconfig-r003-20230511   clang
s390                 randconfig-r013-20230509   clang
s390                 randconfig-r014-20230511   gcc  
s390                 randconfig-r021-20230511   gcc  
s390                 randconfig-r023-20230509   clang
s390                 randconfig-r031-20230509   gcc  
s390                 randconfig-r033-20230511   clang
s390                 randconfig-r034-20230509   gcc  
s390                 randconfig-r044-20230509   clang
s390                 randconfig-r044-20230511   gcc  
sh                               allmodconfig   gcc  
sh                   randconfig-r015-20230511   gcc  
sparc        buildonly-randconfig-r003-20230511   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r003-20230509   gcc  
sparc                randconfig-r005-20230511   gcc  
sparc                randconfig-r006-20230511   gcc  
sparc64              randconfig-r006-20230509   gcc  
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
x86_64                               rhel-8.3   gcc  
xtensa       buildonly-randconfig-r001-20230509   gcc  
xtensa       buildonly-randconfig-r005-20230509   gcc  
xtensa               randconfig-r001-20230511   gcc  
xtensa               randconfig-r022-20230511   gcc  
xtensa               randconfig-r035-20230511   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
