Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3417170117C
	for <lists+linux-wireless@lfdr.de>; Fri, 12 May 2023 23:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235912AbjELVpC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 12 May 2023 17:45:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234887AbjELVpA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 12 May 2023 17:45:00 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75A895B93
        for <linux-wireless@vger.kernel.org>; Fri, 12 May 2023 14:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683927899; x=1715463899;
  h=date:from:to:cc:subject:message-id;
  bh=cN/T+MvWuZzUMSwih+zx1uml0kDf4D9GG6fsc3AP2Cs=;
  b=CtIv5bg5YV+vcTczgBvPMwNve42pTUm5UEvbX62GEaqQOW81FIPmB82O
   pe7labn0pYit5wIuFU96tF2xTTSxlvQp+aoU2zzSmvi2ceACVyldAU56c
   e0ICHS6CM1IiIKm46gYRZbSInJ1qbwZWYb0OPhgQpIg7yGtpk6GmBme9S
   90ZN+N63GjdGEskeU80ks+H58uO0YhKDdgHx9XReqsy+wRcgf0QSawUt8
   7wO5epON219p5GtNAjus1/u8XO8l2sXg7DJu1IPlGXwTjoOhjDJuMaDxG
   2hK3+Y1d0/YMFcHnuCPh52Q7D2IFNl7qsnZv0ieckaojN8EXbiLdeAHo0
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="335415084"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="335415084"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2023 14:44:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10708"; a="730962176"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200"; 
   d="scan'208";a="730962176"
Received: from lkp-server01.sh.intel.com (HELO dea6d5a4f140) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 12 May 2023 14:44:57 -0700
Received: from kbuild by dea6d5a4f140 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pxaZM-00057w-2j;
        Fri, 12 May 2023 21:44:56 +0000
Date:   Sat, 13 May 2023 05:44:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
Subject: [wireless:for-next] BUILD SUCCESS
 bcafcb959a57a6890e900199690c5fc47da1a304
Message-ID: <20230512214424.F3qXg%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git for-next
branch HEAD: bcafcb959a57a6890e900199690c5fc47da1a304  wifi: rtw88: use work to update rate to avoid RCU warning

elapsed time: 724m

configs tested: 229
configs skipped: 16

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r011-20230509   gcc  
alpha                randconfig-r036-20230510   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r003-20230510   gcc  
arc          buildonly-randconfig-r003-20230511   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r001-20230509   gcc  
arc                  randconfig-r006-20230509   gcc  
arc                  randconfig-r011-20230511   gcc  
arc                  randconfig-r033-20230511   gcc  
arc                  randconfig-r036-20230512   gcc  
arc                  randconfig-r043-20230509   gcc  
arc                  randconfig-r043-20230511   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                          pxa168_defconfig   clang
arm                            qcom_defconfig   gcc  
arm                  randconfig-r005-20230509   clang
arm                  randconfig-r006-20230511   gcc  
arm                  randconfig-r016-20230509   gcc  
arm                  randconfig-r046-20230509   gcc  
arm                  randconfig-r046-20230511   clang
arm                         wpcm450_defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r005-20230511   clang
arm64                               defconfig   gcc  
arm64                randconfig-r003-20230509   gcc  
arm64                randconfig-r005-20230511   clang
arm64                randconfig-r011-20230509   clang
arm64                randconfig-r012-20230511   gcc  
arm64                randconfig-r026-20230509   clang
csky         buildonly-randconfig-r002-20230511   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r004-20230511   gcc  
csky                 randconfig-r025-20230509   gcc  
csky                 randconfig-r035-20230511   gcc  
hexagon              randconfig-r002-20230509   clang
hexagon              randconfig-r004-20230509   clang
hexagon              randconfig-r015-20230511   clang
hexagon              randconfig-r021-20230511   clang
hexagon              randconfig-r023-20230509   clang
hexagon              randconfig-r024-20230509   clang
hexagon              randconfig-r024-20230511   clang
hexagon              randconfig-r031-20230509   clang
hexagon              randconfig-r032-20230511   clang
hexagon              randconfig-r034-20230509   clang
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
ia64                 randconfig-r013-20230509   gcc  
ia64                 randconfig-r013-20230511   gcc  
ia64                 randconfig-r023-20230509   gcc  
ia64                 randconfig-r025-20230509   gcc  
ia64                 randconfig-r026-20230509   gcc  
ia64                 randconfig-r036-20230511   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch    buildonly-randconfig-r005-20230511   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r001-20230511   gcc  
loongarch            randconfig-r003-20230509   gcc  
loongarch            randconfig-r006-20230511   gcc  
loongarch            randconfig-r024-20230511   gcc  
m68k                             allmodconfig   gcc  
m68k                          atari_defconfig   gcc  
m68k         buildonly-randconfig-r003-20230511   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r002-20230511   gcc  
m68k                 randconfig-r005-20230509   gcc  
m68k                 randconfig-r006-20230509   gcc  
m68k                 randconfig-r012-20230509   gcc  
m68k                 randconfig-r016-20230511   gcc  
m68k                 randconfig-r031-20230512   gcc  
m68k                 randconfig-r033-20230509   gcc  
m68k                 randconfig-r036-20230511   gcc  
microblaze   buildonly-randconfig-r001-20230511   gcc  
microblaze           randconfig-r001-20230509   gcc  
microblaze           randconfig-r002-20230509   gcc  
microblaze           randconfig-r003-20230509   gcc  
microblaze           randconfig-r013-20230509   gcc  
microblaze           randconfig-r021-20230509   gcc  
microblaze           randconfig-r022-20230509   gcc  
microblaze           randconfig-r031-20230510   gcc  
microblaze           randconfig-r033-20230511   gcc  
microblaze           randconfig-r034-20230511   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r003-20230511   gcc  
mips                 randconfig-r011-20230511   clang
mips                 randconfig-r015-20230509   gcc  
mips                 randconfig-r022-20230511   clang
mips                 randconfig-r024-20230509   gcc  
mips                 randconfig-r024-20230511   clang
mips                 randconfig-r025-20230511   clang
nios2                               defconfig   gcc  
nios2                randconfig-r002-20230511   gcc  
nios2                randconfig-r006-20230509   gcc  
nios2                randconfig-r025-20230511   gcc  
nios2                randconfig-r032-20230510   gcc  
nios2                randconfig-r033-20230512   gcc  
openrisc     buildonly-randconfig-r001-20230511   gcc  
openrisc             randconfig-r004-20230509   gcc  
openrisc             randconfig-r011-20230511   gcc  
openrisc             randconfig-r022-20230509   gcc  
openrisc             randconfig-r022-20230511   gcc  
openrisc             randconfig-r025-20230511   gcc  
openrisc             randconfig-r035-20230509   gcc  
parisc       buildonly-randconfig-r001-20230510   gcc  
parisc       buildonly-randconfig-r005-20230510   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r012-20230511   gcc  
parisc               randconfig-r015-20230509   gcc  
parisc               randconfig-r024-20230509   gcc  
parisc               randconfig-r032-20230511   gcc  
parisc               randconfig-r035-20230510   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc      buildonly-randconfig-r002-20230510   clang
powerpc               mpc834x_itxgp_defconfig   clang
powerpc                     mpc83xx_defconfig   gcc  
powerpc                      pcm030_defconfig   gcc  
powerpc                         ps3_defconfig   gcc  
powerpc              randconfig-r001-20230509   gcc  
powerpc              randconfig-r003-20230511   clang
powerpc              randconfig-r016-20230511   gcc  
powerpc              randconfig-r023-20230511   gcc  
powerpc              randconfig-r026-20230511   gcc  
powerpc              randconfig-r036-20230509   gcc  
powerpc                    sam440ep_defconfig   gcc  
powerpc                     tqm5200_defconfig   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv        buildonly-randconfig-r004-20230511   gcc  
riscv        buildonly-randconfig-r006-20230511   gcc  
riscv                               defconfig   gcc  
riscv             nommu_k210_sdcard_defconfig   gcc  
riscv                randconfig-r021-20230509   clang
riscv                randconfig-r023-20230511   gcc  
riscv                randconfig-r032-20230509   gcc  
riscv                randconfig-r036-20230511   clang
riscv                randconfig-r042-20230509   clang
riscv                randconfig-r042-20230511   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r002-20230509   gcc  
s390                 randconfig-r003-20230511   clang
s390                 randconfig-r013-20230509   clang
s390                 randconfig-r021-20230509   clang
s390                 randconfig-r026-20230511   gcc  
s390                 randconfig-r031-20230511   clang
s390                 randconfig-r033-20230510   gcc  
s390                 randconfig-r044-20230509   clang
s390                 randconfig-r044-20230511   gcc  
sh                               allmodconfig   gcc  
sh                          kfr2r09_defconfig   gcc  
sh                   randconfig-r001-20230511   gcc  
sh                   randconfig-r006-20230511   gcc  
sh                   randconfig-r014-20230509   gcc  
sh                          rsk7264_defconfig   gcc  
sh                           se7722_defconfig   gcc  
sparc        buildonly-randconfig-r002-20230511   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r005-20230511   gcc  
sparc                randconfig-r012-20230509   gcc  
sparc                randconfig-r014-20230511   gcc  
sparc                randconfig-r021-20230511   gcc  
sparc                randconfig-r022-20230509   gcc  
sparc                randconfig-r035-20230512   gcc  
sparc                       sparc64_defconfig   gcc  
sparc64              randconfig-r004-20230511   gcc  
sparc64              randconfig-r014-20230511   gcc  
sparc64              randconfig-r016-20230509   gcc  
sparc64              randconfig-r022-20230511   gcc  
sparc64              randconfig-r024-20230511   gcc  
sparc64              randconfig-r032-20230511   gcc  
sparc64              randconfig-r032-20230512   gcc  
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
x86_64                           rhel-8.3-bpf   gcc  
x86_64                         rhel-8.3-kunit   gcc  
x86_64                           rhel-8.3-kvm   gcc  
x86_64                           rhel-8.3-syz   gcc  
x86_64                               rhel-8.3   gcc  
xtensa       buildonly-randconfig-r006-20230510   gcc  
xtensa               randconfig-r001-20230511   gcc  
xtensa               randconfig-r015-20230511   gcc  
xtensa               randconfig-r024-20230509   gcc  
xtensa               randconfig-r031-20230511   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
