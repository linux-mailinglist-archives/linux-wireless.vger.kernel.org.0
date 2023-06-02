Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 279CE71FA2E
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Jun 2023 08:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233894AbjFBGhV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 2 Jun 2023 02:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233869AbjFBGhT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 2 Jun 2023 02:37:19 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8509F18D
        for <linux-wireless@vger.kernel.org>; Thu,  1 Jun 2023 23:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685687837; x=1717223837;
  h=date:from:to:cc:subject:message-id;
  bh=qrJpaKsg2Om7vo9JXRumqTudqW6M3OzAcc7f5TbqnP8=;
  b=Z7TtocbiECxzb4LNvgPWU9FPG5UlxBSK9JhPnbXi6echa20M56Hjk49Z
   kJqdZ9n9gtGgIZcbzlJF3Zz7jK4Ih4+U/8i0zgF7NRS14JLT6P3bSh31B
   1avWiN1inVNvZiNSeMZqrmDOR5ds0dvxs63dlUNKqY58kCDn2+tTqGhpL
   mwZt3JQsIyicXXr3Dc+sZ5ZNXxtV3tYkG1f2xJq8BZ4ZVOK74+0L/Yn/G
   76vwnkAI52It+AXhfqegTMDKnVc/Hq9hnXHw0YsMvGiImSAvlhZhrnTA4
   KROVqNi2CgM6BUhYrCJPQtQZ/azhbjd0vDqqKFmnT8D4INNuggv5mulkC
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="442165384"
X-IronPort-AV: E=Sophos;i="6.00,212,1681196400"; 
   d="scan'208";a="442165384"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 23:37:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="685179692"
X-IronPort-AV: E=Sophos;i="6.00,212,1681196400"; 
   d="scan'208";a="685179692"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 01 Jun 2023 23:37:15 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q4yPS-0000At-2o;
        Fri, 02 Jun 2023 06:37:14 +0000
Date:   Fri, 02 Jun 2023 14:36:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
Subject: [wireless-next:main] BUILD SUCCESS
 8012ec4a0e64b60d4d782950296e6fb217c6758f
Message-ID: <20230602063644.cIsqE%lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: 8012ec4a0e64b60d4d782950296e6fb217c6758f  wifi: brcmutil: use helper function pktq_empty() instead of open code

elapsed time: 721m

configs tested: 142
configs skipped: 12

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r001-20230531   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r001-20230531   gcc  
alpha                randconfig-r002-20230531   gcc  
alpha                randconfig-r015-20230601   gcc  
alpha                randconfig-r025-20230531   gcc  
arc                              allyesconfig   gcc  
arc                          axs103_defconfig   gcc  
arc          buildonly-randconfig-r005-20230531   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r006-20230602   gcc  
arc                  randconfig-r022-20230531   gcc  
arc                  randconfig-r043-20230531   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                       aspeed_g4_defconfig   clang
arm                                 defconfig   gcc  
arm                        neponset_defconfig   clang
arm                  randconfig-r005-20230531   clang
arm                  randconfig-r014-20230601   clang
arm                  randconfig-r026-20230531   gcc  
arm                  randconfig-r046-20230531   gcc  
arm                         s5pv210_defconfig   clang
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r016-20230601   gcc  
arm64                randconfig-r024-20230531   clang
arm64                randconfig-r025-20230531   clang
arm64                randconfig-r026-20230531   clang
arm64                randconfig-r036-20230602   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r035-20230602   gcc  
hexagon              randconfig-r003-20230602   clang
hexagon              randconfig-r041-20230531   clang
hexagon              randconfig-r045-20230531   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230531   gcc  
i386                 randconfig-i002-20230531   gcc  
i386                 randconfig-i003-20230531   gcc  
i386                 randconfig-i004-20230531   gcc  
i386                 randconfig-i005-20230531   gcc  
i386                 randconfig-i006-20230531   gcc  
i386                 randconfig-i051-20230531   gcc  
i386                 randconfig-i051-20230602   gcc  
i386                 randconfig-i052-20230531   gcc  
i386                 randconfig-i052-20230602   gcc  
i386                 randconfig-i053-20230531   gcc  
i386                 randconfig-i053-20230602   gcc  
i386                 randconfig-i054-20230531   gcc  
i386                 randconfig-i054-20230602   gcc  
i386                 randconfig-i055-20230531   gcc  
i386                 randconfig-i055-20230602   gcc  
i386                 randconfig-i056-20230531   gcc  
i386                 randconfig-i056-20230602   gcc  
i386                 randconfig-i061-20230531   gcc  
i386                 randconfig-i062-20230531   gcc  
i386                 randconfig-i063-20230531   gcc  
i386                 randconfig-i064-20230531   gcc  
i386                 randconfig-i065-20230531   gcc  
i386                 randconfig-i066-20230531   gcc  
i386                 randconfig-r004-20230602   gcc  
ia64                            zx1_defconfig   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r012-20230601   gcc  
m68k                             allmodconfig   gcc  
m68k                         apollo_defconfig   gcc  
m68k         buildonly-randconfig-r004-20230531   gcc  
m68k         buildonly-randconfig-r006-20230531   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r016-20230601   gcc  
m68k                 randconfig-r021-20230531   gcc  
microblaze           randconfig-r024-20230531   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                           ip28_defconfig   clang
mips                 randconfig-r022-20230531   gcc  
nios2        buildonly-randconfig-r002-20230531   gcc  
nios2        buildonly-randconfig-r004-20230531   gcc  
nios2        buildonly-randconfig-r006-20230531   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r002-20230602   gcc  
nios2                randconfig-r012-20230601   gcc  
openrisc     buildonly-randconfig-r003-20230531   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r003-20230531   gcc  
parisc               randconfig-r023-20230531   gcc  
parisc               randconfig-r032-20230531   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                      chrp32_defconfig   gcc  
powerpc                     mpc83xx_defconfig   gcc  
powerpc                      pmac32_defconfig   clang
powerpc                     skiroot_defconfig   clang
powerpc                     tqm5200_defconfig   clang
powerpc                     tqm8560_defconfig   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv        buildonly-randconfig-r002-20230531   clang
riscv                               defconfig   gcc  
riscv                randconfig-r031-20230531   gcc  
riscv                randconfig-r034-20230602   gcc  
riscv                randconfig-r042-20230531   clang
riscv                          rv32_defconfig   gcc  
s390                             alldefconfig   clang
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r004-20230531   gcc  
s390                 randconfig-r011-20230601   gcc  
s390                 randconfig-r033-20230531   gcc  
s390                 randconfig-r044-20230531   clang
sh                               allmodconfig   gcc  
sh                   randconfig-r015-20230601   gcc  
sh                   randconfig-r034-20230531   gcc  
sh                   randconfig-r035-20230531   gcc  
sh                          sdk7780_defconfig   gcc  
sparc        buildonly-randconfig-r003-20230531   gcc  
sparc                               defconfig   gcc  
sparc64              randconfig-r001-20230602   gcc  
sparc64              randconfig-r005-20230602   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230531   gcc  
x86_64               randconfig-a002-20230531   gcc  
x86_64               randconfig-a003-20230531   gcc  
x86_64               randconfig-a004-20230531   gcc  
x86_64               randconfig-a005-20230531   gcc  
x86_64               randconfig-a006-20230531   gcc  
x86_64               randconfig-r006-20230531   gcc  
x86_64                               rhel-8.3   gcc  
xtensa       buildonly-randconfig-r005-20230531   gcc  
xtensa                  cadence_csp_defconfig   gcc  
xtensa               randconfig-r033-20230602   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
