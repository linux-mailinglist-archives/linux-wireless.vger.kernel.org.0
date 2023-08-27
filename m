Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5716F78A07A
	for <lists+linux-wireless@lfdr.de>; Sun, 27 Aug 2023 19:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbjH0RXU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 27 Aug 2023 13:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjH0RXD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 27 Aug 2023 13:23:03 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED4C2B2
        for <linux-wireless@vger.kernel.org>; Sun, 27 Aug 2023 10:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693156980; x=1724692980;
  h=date:from:to:cc:subject:message-id;
  bh=1LGRfp7H4FJtZOzY7sAaKB72mrnIwUlzqzIe7yYR0Ho=;
  b=a5w6oIJBsU1fj3iQFYvCPgjsGQr9nBGcgaXE3NMPjd0L7W5/4E+1zm5U
   jg8VyYbnT9aGk3P953Uzcg9+e4p2h3s/CvML2tzybBxx/TY5LRhh9cPks
   QzSKhx6fjyibFWlV8la9rdGcs27pBk3mGVcxWrJ0dNIZet9wm2jDV9AAD
   DnYq51UyY5FkfgS18hSyy4DgOAZotCLzbe5b+ralJhX1o6+X8v1uljcVZ
   5ZB46HBNM8CmsaYVGTTttjd3pHPfPzucEWfp+NmV4SWOXCOoOnBgqnsa8
   WWLTkXuT79c7ei2dEOmnhqkJxCeUEntK5TacDQExjpdCfsBM+aBHE3IQ8
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10815"; a="374932987"
X-IronPort-AV: E=Sophos;i="6.02,205,1688454000"; 
   d="scan'208";a="374932987"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2023 10:23:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10815"; a="911795278"
X-IronPort-AV: E=Sophos;i="6.02,205,1688454000"; 
   d="scan'208";a="911795278"
Received: from lkp-server02.sh.intel.com (HELO daf8bb0a381d) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 27 Aug 2023 10:22:58 -0700
Received: from kbuild by daf8bb0a381d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qaJTV-00062F-2q;
        Sun, 27 Aug 2023 17:22:57 +0000
Date:   Mon, 28 Aug 2023 01:22:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org
Subject: [wireless-next:main] BUILD SUCCESS
 b32add2d20ea6e62f30a3c0a7c2fb306ec5ceb3d
Message-ID: <202308280130.5J31iLF1-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: b32add2d20ea6e62f30a3c0a7c2fb306ec5ceb3d  Merge branch '1GbE' of git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue

elapsed time: 2309m

configs tested: 211
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r023-20230826   gcc  
alpha                randconfig-r032-20230826   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20230826   gcc  
arc                  randconfig-r001-20230826   gcc  
arc                  randconfig-r012-20230826   gcc  
arc                  randconfig-r015-20230826   gcc  
arc                  randconfig-r016-20230826   gcc  
arc                  randconfig-r022-20230826   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                   randconfig-001-20230826   gcc  
arm                  randconfig-r015-20230826   gcc  
arm                  randconfig-r016-20230826   gcc  
arm                  randconfig-r021-20230826   gcc  
arm                  randconfig-r023-20230826   gcc  
arm                  randconfig-r034-20230826   clang
arm64                            allmodconfig   gcc  
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r004-20230826   gcc  
arm64                randconfig-r011-20230826   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r001-20230826   gcc  
csky                 randconfig-r012-20230826   gcc  
csky                 randconfig-r031-20230826   gcc  
hexagon               randconfig-001-20230826   clang
hexagon               randconfig-002-20230826   clang
hexagon              randconfig-r006-20230826   clang
i386                              allnoconfig   gcc  
i386         buildonly-randconfig-001-20230826   gcc  
i386         buildonly-randconfig-002-20230826   gcc  
i386         buildonly-randconfig-003-20230826   gcc  
i386         buildonly-randconfig-004-20230826   gcc  
i386         buildonly-randconfig-005-20230826   gcc  
i386         buildonly-randconfig-006-20230826   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20230826   gcc  
i386                  randconfig-002-20230826   gcc  
i386                  randconfig-003-20230826   gcc  
i386                  randconfig-004-20230826   gcc  
i386                  randconfig-005-20230826   gcc  
i386                  randconfig-006-20230826   gcc  
i386                  randconfig-011-20230826   clang
i386                  randconfig-012-20230826   clang
i386                  randconfig-013-20230826   clang
i386                  randconfig-014-20230826   clang
i386                  randconfig-015-20230826   clang
i386                  randconfig-016-20230826   clang
i386                 randconfig-r002-20230826   gcc  
i386                 randconfig-r013-20230826   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20230826   gcc  
loongarch            randconfig-r005-20230826   gcc  
loongarch            randconfig-r015-20230826   gcc  
loongarch            randconfig-r033-20230826   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r004-20230826   gcc  
m68k                 randconfig-r014-20230826   gcc  
m68k                 randconfig-r021-20230826   gcc  
m68k                 randconfig-r025-20230826   gcc  
m68k                 randconfig-r031-20230826   gcc  
m68k                 randconfig-r035-20230826   gcc  
m68k                 randconfig-r036-20230826   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
microblaze           randconfig-r001-20230826   gcc  
microblaze           randconfig-r005-20230826   gcc  
microblaze           randconfig-r012-20230826   gcc  
microblaze           randconfig-r014-20230826   gcc  
microblaze           randconfig-r024-20230826   gcc  
microblaze           randconfig-r035-20230826   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r014-20230826   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r005-20230826   gcc  
nios2                randconfig-r013-20230826   gcc  
nios2                randconfig-r025-20230826   gcc  
nios2                randconfig-r032-20230826   gcc  
nios2                randconfig-r036-20230826   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc             randconfig-r011-20230826   gcc  
openrisc             randconfig-r016-20230826   gcc  
openrisc             randconfig-r023-20230826   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r003-20230826   gcc  
parisc               randconfig-r022-20230826   gcc  
parisc               randconfig-r033-20230826   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   gcc  
powerpc              randconfig-r006-20230826   gcc  
powerpc              randconfig-r013-20230826   clang
powerpc64            randconfig-r002-20230826   gcc  
powerpc64            randconfig-r003-20230826   gcc  
powerpc64            randconfig-r006-20230826   gcc  
powerpc64            randconfig-r011-20230826   clang
powerpc64            randconfig-r022-20230826   clang
powerpc64            randconfig-r025-20230826   clang
powerpc64            randconfig-r026-20230826   clang
powerpc64            randconfig-r034-20230826   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20230826   gcc  
riscv                randconfig-r021-20230826   clang
riscv                randconfig-r024-20230826   clang
riscv                randconfig-r034-20230826   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20230826   clang
s390                 randconfig-r003-20230826   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                   randconfig-r006-20230826   gcc  
sh                   randconfig-r021-20230826   gcc  
sh                   randconfig-r023-20230826   gcc  
sh                   randconfig-r025-20230826   gcc  
sh                   randconfig-r026-20230826   gcc  
sh                   randconfig-r036-20230826   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r024-20230826   gcc  
sparc                randconfig-r032-20230826   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64              randconfig-r005-20230826   gcc  
sparc64              randconfig-r024-20230826   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r002-20230826   clang
um                   randconfig-r004-20230826   clang
um                   randconfig-r026-20230826   gcc  
um                   randconfig-r031-20230826   clang
um                           x86_64_defconfig   gcc  
x86_64       buildonly-randconfig-001-20230826   gcc  
x86_64       buildonly-randconfig-002-20230826   gcc  
x86_64       buildonly-randconfig-003-20230826   gcc  
x86_64       buildonly-randconfig-004-20230826   gcc  
x86_64       buildonly-randconfig-005-20230826   gcc  
x86_64       buildonly-randconfig-006-20230826   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20230826   clang
x86_64                randconfig-002-20230826   clang
x86_64                randconfig-003-20230826   clang
x86_64                randconfig-004-20230826   clang
x86_64                randconfig-005-20230826   clang
x86_64                randconfig-006-20230826   clang
x86_64                randconfig-011-20230826   gcc  
x86_64                randconfig-012-20230826   gcc  
x86_64                randconfig-013-20230826   gcc  
x86_64                randconfig-014-20230826   gcc  
x86_64                randconfig-015-20230826   gcc  
x86_64                randconfig-016-20230826   gcc  
x86_64                randconfig-071-20230826   gcc  
x86_64                randconfig-072-20230826   gcc  
x86_64                randconfig-073-20230826   gcc  
x86_64                randconfig-074-20230826   gcc  
x86_64                randconfig-075-20230826   gcc  
x86_64                randconfig-076-20230826   gcc  
x86_64               randconfig-r004-20230826   gcc  
x86_64               randconfig-r022-20230826   clang
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa               randconfig-r002-20230826   gcc  
xtensa               randconfig-r033-20230826   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
