Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EFF86B0473
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Mar 2023 11:33:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbjCHKdo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Mar 2023 05:33:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbjCHKdR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Mar 2023 05:33:17 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 905878483B
        for <linux-wireless@vger.kernel.org>; Wed,  8 Mar 2023 02:32:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678271567; x=1709807567;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=vDsedwkTFb+d1toZTXx0ngXG9Khc7OAa2B7VES58D70=;
  b=eqcR32IS98WWCfjaNyw2bgeWrO4Ac9hZo0CuewCE8YggZJTPWqOfAV8+
   QOV7ykFjDXqUO674M2jW5EXM/gcmV6OKVyARvLIO1uFLR2CbU0h95me/j
   LDXyy5CUwaRw+kRhAlATcAlfy2TCIXMycF3LiV/SaSOwENc7SU1toU0yK
   eoCbDKBHNu8f2gRgI+LqYnekMzrOI5vW/D/IC6gfSdimJnQQPWCcXUCbW
   UFI7VNrXhwVSFEmZtmlqtk/zb7LJCdoD4yeoCGqgfS6FWCT8bF4Tqpmr9
   tml4dNta5yonZXS4If5yYbPLyJ2yjhutitBbVC2PPlmrPHohhsQEFpT/F
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="324432650"
X-IronPort-AV: E=Sophos;i="5.98,243,1673942400"; 
   d="scan'208";a="324432650"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2023 02:32:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10642"; a="709382209"
X-IronPort-AV: E=Sophos;i="5.98,243,1673942400"; 
   d="scan'208";a="709382209"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 08 Mar 2023 02:32:43 -0800
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pZr6A-00023V-1I;
        Wed, 08 Mar 2023 10:32:42 +0000
Date:   Wed, 08 Mar 2023 18:32:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johannes Berg <johannes.berg@intel.com>
Cc:     linux-wireless@vger.kernel.org, Kalle Valo <kvalo@kernel.org>
Subject: [wireless-next:main] BUILD SUCCESS
 da1185449c669076276027c600666286124eef9f
Message-ID: <64086423.aFVXk5P0AQv4su2R%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: da1185449c669076276027c600666286124eef9f  wifi: iwlwifi: mvm: fix EOF bit reporting

elapsed time: 722m

configs tested: 174
configs skipped: 10

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r004-20230305   gcc  
alpha                randconfig-r005-20230306   gcc  
alpha                randconfig-r016-20230305   gcc  
alpha                randconfig-r035-20230306   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r002-20230306   gcc  
arc                  randconfig-r015-20230306   gcc  
arc                  randconfig-r021-20230305   gcc  
arc                  randconfig-r031-20230305   gcc  
arc                  randconfig-r035-20230306   gcc  
arc                  randconfig-r043-20230305   gcc  
arc                  randconfig-r043-20230306   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm          buildonly-randconfig-r004-20230306   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r021-20230306   gcc  
arm                  randconfig-r025-20230305   clang
arm                  randconfig-r031-20230306   clang
arm                  randconfig-r033-20230306   clang
arm                  randconfig-r034-20230306   clang
arm                  randconfig-r046-20230305   clang
arm                  randconfig-r046-20230306   gcc  
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r005-20230306   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r013-20230305   gcc  
arm64                randconfig-r016-20230306   clang
arm64                randconfig-r024-20230305   gcc  
csky         buildonly-randconfig-r006-20230305   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r011-20230305   gcc  
csky                 randconfig-r026-20230305   gcc  
csky                 randconfig-r033-20230305   gcc  
hexagon      buildonly-randconfig-r001-20230306   clang
hexagon              randconfig-r011-20230306   clang
hexagon              randconfig-r012-20230306   clang
hexagon              randconfig-r022-20230306   clang
hexagon              randconfig-r023-20230306   clang
hexagon              randconfig-r033-20230306   clang
hexagon              randconfig-r041-20230305   clang
hexagon              randconfig-r041-20230306   clang
hexagon              randconfig-r045-20230305   clang
hexagon              randconfig-r045-20230306   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r003-20230306   gcc  
i386         buildonly-randconfig-r006-20230306   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-a001-20230306   gcc  
i386                 randconfig-a002-20230306   gcc  
i386                 randconfig-a003-20230306   gcc  
i386                 randconfig-a004-20230306   gcc  
i386                 randconfig-a005-20230306   gcc  
i386                 randconfig-a006-20230306   gcc  
i386                 randconfig-a011-20230306   clang
i386                 randconfig-a012-20230306   clang
i386                 randconfig-a013-20230306   clang
i386                 randconfig-a014-20230306   clang
i386                 randconfig-a015-20230306   clang
i386                 randconfig-a016-20230306   clang
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
ia64                 randconfig-r006-20230305   gcc  
ia64                 randconfig-r011-20230306   gcc  
ia64                 randconfig-r012-20230305   gcc  
ia64                 randconfig-r022-20230305   gcc  
ia64                 randconfig-r023-20230305   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r011-20230305   gcc  
loongarch            randconfig-r021-20230305   gcc  
loongarch            randconfig-r036-20230305   gcc  
m68k                             allmodconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r021-20230306   gcc  
m68k                 randconfig-r022-20230306   gcc  
m68k                 randconfig-r024-20230305   gcc  
m68k                 randconfig-r035-20230305   gcc  
microblaze   buildonly-randconfig-r005-20230305   gcc  
microblaze           randconfig-r013-20230305   gcc  
microblaze           randconfig-r013-20230306   gcc  
microblaze           randconfig-r014-20230306   gcc  
microblaze           randconfig-r015-20230305   gcc  
microblaze           randconfig-r016-20230305   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips         buildonly-randconfig-r001-20230306   clang
mips                 randconfig-r015-20230305   clang
nios2        buildonly-randconfig-r006-20230306   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r006-20230306   gcc  
nios2                randconfig-r024-20230306   gcc  
nios2                randconfig-r036-20230306   gcc  
openrisc     buildonly-randconfig-r001-20230305   gcc  
openrisc     buildonly-randconfig-r002-20230306   gcc  
openrisc             randconfig-r001-20230305   gcc  
openrisc             randconfig-r005-20230305   gcc  
openrisc             randconfig-r013-20230306   gcc  
openrisc             randconfig-r014-20230306   gcc  
openrisc             randconfig-r031-20230306   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r003-20230306   gcc  
parisc               randconfig-r014-20230305   gcc  
parisc               randconfig-r032-20230306   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc      buildonly-randconfig-r006-20230305   gcc  
powerpc              randconfig-r023-20230305   gcc  
powerpc              randconfig-r032-20230306   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv        buildonly-randconfig-r004-20230306   clang
riscv                               defconfig   gcc  
riscv                randconfig-r014-20230305   gcc  
riscv                randconfig-r024-20230306   clang
riscv                randconfig-r025-20230306   clang
riscv                randconfig-r032-20230305   clang
riscv                randconfig-r042-20230305   gcc  
riscv                randconfig-r042-20230306   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390         buildonly-randconfig-r003-20230306   clang
s390                                defconfig   gcc  
s390                 randconfig-r002-20230305   clang
s390                 randconfig-r004-20230306   gcc  
s390                 randconfig-r016-20230306   clang
s390                 randconfig-r044-20230305   gcc  
s390                 randconfig-r044-20230306   clang
sh                               allmodconfig   gcc  
sh           buildonly-randconfig-r005-20230306   gcc  
sh                   randconfig-r012-20230306   gcc  
sh                   randconfig-r015-20230306   gcc  
sh                   randconfig-r026-20230305   gcc  
sh                   randconfig-r034-20230306   gcc  
sparc        buildonly-randconfig-r001-20230305   gcc  
sparc        buildonly-randconfig-r002-20230305   gcc  
sparc        buildonly-randconfig-r003-20230305   gcc  
sparc        buildonly-randconfig-r004-20230305   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r001-20230306   gcc  
sparc64              randconfig-r012-20230305   gcc  
sparc64              randconfig-r022-20230305   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230306   gcc  
x86_64               randconfig-a002-20230306   gcc  
x86_64               randconfig-a003-20230306   gcc  
x86_64               randconfig-a004-20230306   gcc  
x86_64               randconfig-a005-20230306   gcc  
x86_64               randconfig-a006-20230306   gcc  
x86_64               randconfig-a011-20230306   clang
x86_64               randconfig-a012-20230306   clang
x86_64               randconfig-a013-20230306   clang
x86_64               randconfig-a014-20230306   clang
x86_64               randconfig-a015-20230306   clang
x86_64               randconfig-a016-20230306   clang
x86_64               randconfig-r023-20230306   clang
x86_64                               rhel-8.3   gcc  
xtensa       buildonly-randconfig-r005-20230305   gcc  
xtensa               randconfig-r003-20230305   gcc  
xtensa               randconfig-r026-20230306   gcc  
xtensa               randconfig-r034-20230305   gcc  
xtensa               randconfig-r036-20230306   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
