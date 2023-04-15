Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 123B86E2E14
	for <lists+linux-wireless@lfdr.de>; Sat, 15 Apr 2023 03:01:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbjDOBBJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Apr 2023 21:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjDOBBI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Apr 2023 21:01:08 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9908F35AC
        for <linux-wireless@vger.kernel.org>; Fri, 14 Apr 2023 18:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681520464; x=1713056464;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=koaOR+EWRiFiATSqjpyInNNpg77bvP0WAvwy4341WXw=;
  b=Dw8pQHV8hRPYNIRKJTFOttKkJtnVOd1ldDGGUcci1W4qsOxg/9LizHqK
   Jh1vW4M628JTeu6MF4pEI7qCiDyYYipUje2cKyO9z9bgInkLs6JkNWyVm
   aSDa6+S82pFpzenkyr4CNt8KbY/GcXxSc46nMqmw5NpUNFriMc3LGxe03
   P9fUdasa/I/YOVa7U4OxJet+WTeqbMjqdILafQE+Nw3ohUNTIVXja/Gt4
   8nRh7Jort4p20BG51wsaVYFVS1S8lyMyRObv51/UIrFZ7M3kZMgjKL6ws
   t6h+Xd7G1wTbvzTswG/TDSflok+6oYPzpW+8ycjCIYBNoqFLy6Txu6yZW
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10680"; a="372472087"
X-IronPort-AV: E=Sophos;i="5.99,198,1677571200"; 
   d="scan'208";a="372472087"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2023 18:01:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10680"; a="722644409"
X-IronPort-AV: E=Sophos;i="5.99,198,1677571200"; 
   d="scan'208";a="722644409"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 14 Apr 2023 18:01:01 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pnUHk-000aCX-2h;
        Sat, 15 Apr 2023 01:01:00 +0000
Date:   Sat, 15 Apr 2023 09:00:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>
Subject: [wireless-next:main] BUILD SUCCESS
 666f4ab26c2c7c5e1aa963dc5d8623df1b015d06
Message-ID: <6439f73c.+np5iD2FybNBT0Nm%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: 666f4ab26c2c7c5e1aa963dc5d8623df1b015d06  bcma: Add explicit of_device.h include

elapsed time: 730m

configs tested: 337
configs skipped: 40

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r002-20230413   gcc  
alpha        buildonly-randconfig-r005-20230409   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r002-20230409   gcc  
alpha                randconfig-r011-20230413   gcc  
alpha                randconfig-r013-20230409   gcc  
alpha                randconfig-r013-20230413   gcc  
alpha                randconfig-r021-20230414   gcc  
alpha                randconfig-r023-20230413   gcc  
alpha                randconfig-r034-20230409   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r001-20230409   gcc  
arc          buildonly-randconfig-r002-20230410   gcc  
arc          buildonly-randconfig-r003-20230409   gcc  
arc          buildonly-randconfig-r005-20230410   gcc  
arc          buildonly-randconfig-r006-20230412   gcc  
arc          buildonly-randconfig-r006-20230413   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r002-20230414   gcc  
arc                  randconfig-r005-20230412   gcc  
arc                  randconfig-r011-20230410   gcc  
arc                  randconfig-r013-20230410   gcc  
arc                  randconfig-r016-20230410   gcc  
arc                  randconfig-r025-20230414   gcc  
arc                  randconfig-r026-20230413   gcc  
arc                  randconfig-r032-20230413   gcc  
arc                  randconfig-r033-20230410   gcc  
arc                  randconfig-r043-20230409   gcc  
arc                  randconfig-r043-20230410   gcc  
arc                  randconfig-r043-20230413   gcc  
arc                  randconfig-r043-20230414   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r012-20230413   gcc  
arm                  randconfig-r014-20230409   clang
arm                  randconfig-r021-20230413   gcc  
arm                  randconfig-r023-20230414   clang
arm                  randconfig-r033-20230410   gcc  
arm                  randconfig-r046-20230409   clang
arm                  randconfig-r046-20230410   clang
arm                  randconfig-r046-20230413   gcc  
arm                  randconfig-r046-20230414   clang
arm                         socfpga_defconfig   clang
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r006-20230413   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r001-20230410   clang
arm64                randconfig-r002-20230410   clang
arm64                randconfig-r004-20230414   clang
arm64                randconfig-r013-20230409   gcc  
arm64                randconfig-r014-20230410   gcc  
arm64                randconfig-r021-20230414   gcc  
arm64                randconfig-r022-20230409   gcc  
arm64                randconfig-r032-20230410   clang
arm64                randconfig-r035-20230413   gcc  
arm64                randconfig-r036-20230413   gcc  
csky         buildonly-randconfig-r006-20230410   gcc  
csky         buildonly-randconfig-r006-20230413   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r024-20230409   gcc  
csky                 randconfig-r026-20230413   gcc  
hexagon      buildonly-randconfig-r003-20230414   clang
hexagon      buildonly-randconfig-r005-20230413   clang
hexagon      buildonly-randconfig-r006-20230414   clang
hexagon              randconfig-r002-20230414   clang
hexagon              randconfig-r005-20230410   clang
hexagon              randconfig-r015-20230409   clang
hexagon              randconfig-r015-20230413   clang
hexagon              randconfig-r024-20230414   clang
hexagon              randconfig-r025-20230410   clang
hexagon              randconfig-r031-20230409   clang
hexagon              randconfig-r041-20230409   clang
hexagon              randconfig-r041-20230410   clang
hexagon              randconfig-r041-20230413   clang
hexagon              randconfig-r041-20230414   clang
hexagon              randconfig-r045-20230409   clang
hexagon              randconfig-r045-20230410   clang
hexagon              randconfig-r045-20230413   clang
hexagon              randconfig-r045-20230414   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230410   clang
i386         buildonly-randconfig-r006-20230410   clang
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a001-20230410   clang
i386                 randconfig-a002-20230410   clang
i386                 randconfig-a003-20230410   clang
i386                 randconfig-a004-20230410   clang
i386                 randconfig-a005-20230410   clang
i386                 randconfig-a006-20230410   clang
i386                 randconfig-a011-20230410   gcc  
i386                 randconfig-a012-20230410   gcc  
i386                 randconfig-a013-20230410   gcc  
i386                 randconfig-a014-20230410   gcc  
i386                 randconfig-a015-20230410   gcc  
i386                 randconfig-a016-20230410   gcc  
i386                 randconfig-r026-20230410   gcc  
ia64                             allmodconfig   gcc  
ia64         buildonly-randconfig-r001-20230410   gcc  
ia64         buildonly-randconfig-r002-20230409   gcc  
ia64         buildonly-randconfig-r003-20230410   gcc  
ia64         buildonly-randconfig-r005-20230409   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r002-20230410   gcc  
ia64                 randconfig-r005-20230414   gcc  
ia64                 randconfig-r012-20230414   gcc  
ia64                 randconfig-r013-20230409   gcc  
ia64                 randconfig-r015-20230410   gcc  
ia64                 randconfig-r022-20230414   gcc  
ia64                 randconfig-r024-20230410   gcc  
ia64                 randconfig-r024-20230414   gcc  
ia64                 randconfig-r025-20230409   gcc  
ia64                 randconfig-r025-20230413   gcc  
ia64                 randconfig-r026-20230414   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch    buildonly-randconfig-r006-20230409   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r002-20230413   gcc  
loongarch            randconfig-r014-20230413   gcc  
loongarch            randconfig-r016-20230410   gcc  
loongarch            randconfig-r021-20230410   gcc  
loongarch            randconfig-r023-20230409   gcc  
loongarch            randconfig-r024-20230410   gcc  
loongarch            randconfig-r025-20230409   gcc  
loongarch            randconfig-r033-20230409   gcc  
m68k                             allmodconfig   gcc  
m68k         buildonly-randconfig-r001-20230413   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r001-20230412   gcc  
m68k                 randconfig-r004-20230412   gcc  
m68k                 randconfig-r011-20230412   gcc  
m68k                 randconfig-r011-20230415   gcc  
m68k                 randconfig-r012-20230409   gcc  
m68k                 randconfig-r013-20230412   gcc  
m68k                 randconfig-r015-20230410   gcc  
m68k                 randconfig-r015-20230413   gcc  
m68k                 randconfig-r016-20230409   gcc  
microblaze   buildonly-randconfig-r004-20230410   gcc  
microblaze   buildonly-randconfig-r005-20230413   gcc  
microblaze           randconfig-r002-20230412   gcc  
microblaze           randconfig-r005-20230413   gcc  
microblaze           randconfig-r005-20230414   gcc  
microblaze           randconfig-r016-20230413   gcc  
microblaze           randconfig-r025-20230413   gcc  
microblaze           randconfig-r026-20230414   gcc  
microblaze           randconfig-r032-20230410   gcc  
microblaze           randconfig-r033-20230413   gcc  
microblaze           randconfig-r035-20230409   gcc  
microblaze           randconfig-r036-20230410   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips         buildonly-randconfig-r001-20230409   gcc  
mips         buildonly-randconfig-r003-20230410   gcc  
mips         buildonly-randconfig-r006-20230409   gcc  
mips                 randconfig-r012-20230410   clang
mips                 randconfig-r014-20230413   gcc  
mips                 randconfig-r016-20230414   clang
mips                 randconfig-r024-20230413   gcc  
mips                 randconfig-r031-20230410   gcc  
mips                 randconfig-r032-20230409   gcc  
mips                 randconfig-r034-20230409   gcc  
nios2        buildonly-randconfig-r001-20230410   gcc  
nios2        buildonly-randconfig-r004-20230410   gcc  
nios2        buildonly-randconfig-r004-20230413   gcc  
nios2        buildonly-randconfig-r005-20230410   gcc  
nios2        buildonly-randconfig-r005-20230412   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r004-20230413   gcc  
nios2                randconfig-r011-20230409   gcc  
nios2                randconfig-r014-20230410   gcc  
nios2                randconfig-r016-20230409   gcc  
nios2                randconfig-r021-20230409   gcc  
nios2                randconfig-r022-20230413   gcc  
openrisc     buildonly-randconfig-r002-20230413   gcc  
openrisc                  or1klitex_defconfig   gcc  
openrisc             randconfig-r004-20230414   gcc  
openrisc             randconfig-r012-20230410   gcc  
openrisc             randconfig-r015-20230415   gcc  
openrisc             randconfig-r016-20230413   gcc  
openrisc             randconfig-r022-20230413   gcc  
openrisc             randconfig-r023-20230413   gcc  
openrisc             randconfig-r024-20230409   gcc  
parisc       buildonly-randconfig-r001-20230409   gcc  
parisc       buildonly-randconfig-r003-20230409   gcc  
parisc       buildonly-randconfig-r003-20230410   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r003-20230412   gcc  
parisc               randconfig-r006-20230412   gcc  
parisc               randconfig-r011-20230409   gcc  
parisc               randconfig-r011-20230410   gcc  
parisc               randconfig-r011-20230413   gcc  
parisc               randconfig-r012-20230409   gcc  
parisc               randconfig-r016-20230412   gcc  
parisc               randconfig-r022-20230409   gcc  
parisc               randconfig-r023-20230409   gcc  
parisc               randconfig-r023-20230414   gcc  
parisc               randconfig-r025-20230410   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc      buildonly-randconfig-r004-20230409   gcc  
powerpc                   microwatt_defconfig   clang
powerpc                     mpc83xx_defconfig   gcc  
powerpc                 mpc8540_ads_defconfig   gcc  
powerpc              randconfig-r002-20230414   clang
powerpc              randconfig-r003-20230410   clang
powerpc              randconfig-r006-20230409   clang
powerpc              randconfig-r013-20230414   gcc  
powerpc              randconfig-r014-20230412   gcc  
powerpc              randconfig-r015-20230410   gcc  
powerpc              randconfig-r015-20230414   gcc  
powerpc              randconfig-r022-20230409   gcc  
powerpc              randconfig-r022-20230410   gcc  
powerpc              randconfig-r034-20230413   gcc  
powerpc              randconfig-r035-20230409   clang
powerpc              randconfig-r035-20230410   clang
powerpc                     stx_gp3_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv        buildonly-randconfig-r001-20230413   clang
riscv        buildonly-randconfig-r002-20230410   gcc  
riscv        buildonly-randconfig-r004-20230412   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r001-20230409   clang
riscv                randconfig-r001-20230414   clang
riscv                randconfig-r003-20230410   clang
riscv                randconfig-r004-20230409   clang
riscv                randconfig-r014-20230410   gcc  
riscv                randconfig-r026-20230409   gcc  
riscv                randconfig-r026-20230410   gcc  
riscv                randconfig-r036-20230409   clang
riscv                randconfig-r042-20230409   gcc  
riscv                randconfig-r042-20230410   gcc  
riscv                randconfig-r042-20230413   clang
riscv                randconfig-r042-20230414   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390         buildonly-randconfig-r002-20230410   gcc  
s390         buildonly-randconfig-r003-20230412   gcc  
s390         buildonly-randconfig-r003-20230413   clang
s390         buildonly-randconfig-r005-20230409   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r001-20230409   clang
s390                 randconfig-r003-20230414   clang
s390                 randconfig-r004-20230410   clang
s390                 randconfig-r004-20230414   clang
s390                 randconfig-r014-20230414   gcc  
s390                 randconfig-r021-20230409   gcc  
s390                 randconfig-r023-20230409   gcc  
s390                 randconfig-r044-20230409   gcc  
s390                 randconfig-r044-20230410   gcc  
s390                 randconfig-r044-20230413   clang
s390                 randconfig-r044-20230414   gcc  
sh                               allmodconfig   gcc  
sh                     magicpanelr2_defconfig   gcc  
sh                   randconfig-r001-20230413   gcc  
sh                   randconfig-r003-20230414   gcc  
sh                   randconfig-r004-20230410   gcc  
sh                   randconfig-r006-20230413   gcc  
sh                   randconfig-r006-20230414   gcc  
sh                   randconfig-r012-20230412   gcc  
sh                   randconfig-r012-20230415   gcc  
sh                   randconfig-r013-20230410   gcc  
sh                   randconfig-r014-20230409   gcc  
sh                   randconfig-r015-20230409   gcc  
sh                   randconfig-r023-20230410   gcc  
sh                   randconfig-r026-20230409   gcc  
sh                   sh7724_generic_defconfig   gcc  
sh                  sh7785lcr_32bit_defconfig   gcc  
sparc                             allnoconfig   gcc  
sparc        buildonly-randconfig-r003-20230413   gcc  
sparc        buildonly-randconfig-r005-20230413   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r011-20230410   gcc  
sparc                randconfig-r015-20230412   gcc  
sparc                randconfig-r021-20230410   gcc  
sparc                randconfig-r032-20230409   gcc  
sparc                randconfig-r033-20230409   gcc  
sparc                       sparc64_defconfig   gcc  
sparc64                          alldefconfig   gcc  
sparc64      buildonly-randconfig-r003-20230409   gcc  
sparc64      buildonly-randconfig-r004-20230413   gcc  
sparc64      buildonly-randconfig-r006-20230409   gcc  
sparc64              randconfig-r006-20230414   gcc  
sparc64              randconfig-r013-20230413   gcc  
sparc64              randconfig-r013-20230415   gcc  
sparc64              randconfig-r014-20230413   gcc  
sparc64              randconfig-r016-20230410   gcc  
sparc64              randconfig-r016-20230415   gcc  
sparc64              randconfig-r021-20230409   gcc  
sparc64              randconfig-r024-20230413   gcc  
sparc64              randconfig-r025-20230414   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230410   clang
x86_64                        randconfig-a001   clang
x86_64               randconfig-a002-20230410   clang
x86_64               randconfig-a003-20230410   clang
x86_64                        randconfig-a003   clang
x86_64               randconfig-a004-20230410   clang
x86_64               randconfig-a005-20230410   clang
x86_64                        randconfig-a005   clang
x86_64               randconfig-a006-20230410   clang
x86_64               randconfig-a011-20230410   gcc  
x86_64               randconfig-a012-20230410   gcc  
x86_64               randconfig-a013-20230410   gcc  
x86_64               randconfig-a014-20230410   gcc  
x86_64               randconfig-a015-20230410   gcc  
x86_64               randconfig-a016-20230410   gcc  
x86_64                        randconfig-k001   clang
x86_64               randconfig-r006-20230410   clang
x86_64               randconfig-r024-20230410   gcc  
x86_64               randconfig-r025-20230410   gcc  
x86_64                               rhel-8.3   gcc  
xtensa       buildonly-randconfig-r001-20230414   gcc  
xtensa       buildonly-randconfig-r002-20230409   gcc  
xtensa       buildonly-randconfig-r004-20230409   gcc  
xtensa       buildonly-randconfig-r004-20230414   gcc  
xtensa               randconfig-r005-20230409   gcc  
xtensa               randconfig-r013-20230410   gcc  
xtensa               randconfig-r014-20230409   gcc  
xtensa               randconfig-r014-20230410   gcc  
xtensa               randconfig-r015-20230409   gcc  
xtensa               randconfig-r015-20230410   gcc  
xtensa               randconfig-r016-20230409   gcc  
xtensa               randconfig-r021-20230410   gcc  
xtensa               randconfig-r034-20230410   gcc  
xtensa               randconfig-r036-20230410   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
