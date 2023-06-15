Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99ABB73214A
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Jun 2023 23:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236658AbjFOVFL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 15 Jun 2023 17:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232464AbjFOVEy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 15 Jun 2023 17:04:54 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93E6D10EC
        for <linux-wireless@vger.kernel.org>; Thu, 15 Jun 2023 14:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686863092; x=1718399092;
  h=date:from:to:cc:subject:message-id;
  bh=cCB4JSnyefxixZxyhHZEgSmFMALqB93qU6Wg71s43J8=;
  b=czrzY4ljiOyIAS4P7Il8pykiS1UqnaIPNbqES9PpdviQTQEIsTFC0C5t
   rnvEiE9tAHaU9Ef6bhCQlDVG7AMR7EwpvCAVYfxldB0M5C38ZU52+KThh
   hdVyb0HGZBd6o5lDyYFzvprX1n+IJ6MLa3iPAIxlEJdF4kRrwkV/Y2Jow
   UUYg239d5y8hH9hy7fR3AFTaZQB6l2Ms17TfbGvJFe+zg065gajvNBUFs
   MmMH88lhrujERmTmfOTCWeZZ8OkDl13LcIMHhFJUQUqd8S5TdyPA7mEmJ
   LJw2dmPPYloohc2qfsb7PrpuQeEjKZ9hAcEl6BDa1VCxRoi90mdJI5SB7
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="339381316"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="339381316"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 14:04:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="689947433"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="689947433"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 15 Jun 2023 14:04:50 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q9u9B-0000Nh-2O;
        Thu, 15 Jun 2023 21:04:49 +0000
Date:   Fri, 16 Jun 2023 05:04:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
Subject: [wireless-next:main] BUILD SUCCESS
 5bc9a34ce87bee0ca53b86ff1a5ca340a62c2117
Message-ID: <202306160512.IdgoesgE-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: 5bc9a34ce87bee0ca53b86ff1a5ca340a62c2117  wifi: rtw89: fix spelling typo of IQK debug messages

elapsed time: 726m

configs tested: 151
configs skipped: 12

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r025-20230614   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                         haps_hs_defconfig   gcc  
arc                  randconfig-r034-20230615   gcc  
arc                  randconfig-r043-20230615   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                         assabet_defconfig   gcc  
arm          buildonly-randconfig-r001-20230614   clang
arm                                 defconfig   gcc  
arm                           h3600_defconfig   gcc  
arm                  randconfig-r021-20230615   gcc  
arm                  randconfig-r023-20230614   clang
arm                  randconfig-r046-20230615   gcc  
arm                        realview_defconfig   gcc  
arm                           tegra_defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r002-20230615   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r004-20230615   gcc  
csky                 randconfig-r026-20230614   gcc  
hexagon      buildonly-randconfig-r002-20230615   clang
hexagon              randconfig-r003-20230615   clang
hexagon              randconfig-r024-20230615   clang
hexagon              randconfig-r035-20230615   clang
hexagon              randconfig-r041-20230615   clang
hexagon              randconfig-r045-20230615   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r005-20230614   clang
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230614   clang
i386                 randconfig-i001-20230615   gcc  
i386                 randconfig-i002-20230614   clang
i386                 randconfig-i002-20230615   gcc  
i386                 randconfig-i003-20230614   clang
i386                 randconfig-i003-20230615   gcc  
i386                 randconfig-i004-20230614   clang
i386                 randconfig-i004-20230615   gcc  
i386                 randconfig-i005-20230614   clang
i386                 randconfig-i005-20230615   gcc  
i386                 randconfig-i006-20230614   clang
i386                 randconfig-i006-20230615   gcc  
i386                 randconfig-i011-20230615   clang
i386                 randconfig-i012-20230615   clang
i386                 randconfig-i013-20230615   clang
i386                 randconfig-i014-20230615   clang
i386                 randconfig-i015-20230615   clang
i386                 randconfig-i016-20230615   clang
i386                 randconfig-r015-20230615   clang
i386                 randconfig-r032-20230615   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r011-20230615   gcc  
loongarch            randconfig-r013-20230615   gcc  
loongarch            randconfig-r016-20230615   gcc  
loongarch            randconfig-r022-20230615   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r012-20230615   gcc  
m68k                 randconfig-r016-20230615   gcc  
microblaze   buildonly-randconfig-r005-20230615   gcc  
microblaze           randconfig-r001-20230615   gcc  
microblaze           randconfig-r021-20230614   gcc  
microblaze           randconfig-r033-20230615   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                 randconfig-r006-20230615   clang
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r003-20230615   gcc  
nios2                randconfig-r014-20230615   gcc  
nios2                randconfig-r031-20230615   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r011-20230615   gcc  
parisc               randconfig-r023-20230615   gcc  
parisc               randconfig-r036-20230615   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                        cell_defconfig   gcc  
powerpc              randconfig-r014-20230615   clang
powerpc              randconfig-r034-20230615   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv        buildonly-randconfig-r001-20230615   clang
riscv        buildonly-randconfig-r003-20230614   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r035-20230615   gcc  
riscv                randconfig-r042-20230615   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390         buildonly-randconfig-r002-20230614   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r015-20230615   clang
s390                 randconfig-r026-20230615   clang
s390                 randconfig-r044-20230615   clang
sh                               allmodconfig   gcc  
sh                   randconfig-r025-20230615   gcc  
sh                   rts7751r2dplus_defconfig   gcc  
sh                          sdk7786_defconfig   gcc  
sparc                            allyesconfig   gcc  
sparc        buildonly-randconfig-r003-20230615   gcc  
sparc        buildonly-randconfig-r004-20230615   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r005-20230615   gcc  
sparc64              randconfig-r012-20230615   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   clang
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230614   clang
x86_64               randconfig-a001-20230615   gcc  
x86_64               randconfig-a002-20230614   clang
x86_64               randconfig-a002-20230615   gcc  
x86_64               randconfig-a003-20230614   clang
x86_64               randconfig-a003-20230615   gcc  
x86_64               randconfig-a004-20230614   clang
x86_64               randconfig-a004-20230615   gcc  
x86_64               randconfig-a005-20230614   clang
x86_64               randconfig-a005-20230615   gcc  
x86_64               randconfig-a006-20230614   clang
x86_64               randconfig-a006-20230615   gcc  
x86_64               randconfig-a011-20230614   gcc  
x86_64               randconfig-a011-20230615   clang
x86_64               randconfig-a012-20230614   gcc  
x86_64               randconfig-a012-20230615   clang
x86_64               randconfig-a013-20230614   gcc  
x86_64               randconfig-a013-20230615   clang
x86_64               randconfig-a014-20230614   gcc  
x86_64               randconfig-a014-20230615   clang
x86_64               randconfig-a015-20230614   gcc  
x86_64               randconfig-a015-20230615   clang
x86_64               randconfig-a016-20230614   gcc  
x86_64               randconfig-a016-20230615   clang
x86_64               randconfig-r022-20230614   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa       buildonly-randconfig-r006-20230614   gcc  
xtensa               randconfig-r002-20230615   gcc  
xtensa               randconfig-r032-20230615   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
