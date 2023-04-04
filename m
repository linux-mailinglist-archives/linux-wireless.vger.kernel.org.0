Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B357D6D56E9
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Apr 2023 04:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232833AbjDDCyA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 3 Apr 2023 22:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjDDCx7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 3 Apr 2023 22:53:59 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DC0D19BF
        for <linux-wireless@vger.kernel.org>; Mon,  3 Apr 2023 19:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680576838; x=1712112838;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=y17nbAT0Mbwwe+1RP9vrLI2xf7Ag1OExitGufnLGH/E=;
  b=mznNw2BiaH1XmmUL8j0uazeHaTah0BA38oy3eCu4GcK9nZ/eMXjxR2ab
   XOoyG7kA+3B5N2VRamO6cU/hseBIhbBHWMqv9y9VBH5wf0HeVD8niULCy
   3ES1iuMdwwcmwV72de2IYwzVvFofhzxclmue5hqN2ShodnQggpItrrAOb
   JM30IXoDXwDR0nVOlqfQMLWwhw5jQU5SIyyAU2dzCmhPUG4UVsnrYZj3J
   JiYphXXQOP5G9zl5+NKw5UHUwPs9z5EDqEvYNLByrWn9scRir2GW+B6Gq
   WNPX+Jcev8fCFFEjaBX54dky/m3J/GlbMUDU2v3lB9Son4cMm2Bci6VDJ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="340806652"
X-IronPort-AV: E=Sophos;i="5.98,316,1673942400"; 
   d="scan'208";a="340806652"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2023 19:53:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="718770233"
X-IronPort-AV: E=Sophos;i="5.98,316,1673942400"; 
   d="scan'208";a="718770233"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 03 Apr 2023 19:53:56 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1pjWnz-000P4q-1U;
        Tue, 04 Apr 2023 02:53:55 +0000
Date:   Tue, 04 Apr 2023 10:52:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>
Subject: [wireless:for-next] BUILD SUCCESS
 e6db67fa871dee37d22701daba806bfcd4d9df49
Message-ID: <642b9106.+2cHY1c2DXl6uN4l%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git for-next
branch HEAD: e6db67fa871dee37d22701daba806bfcd4d9df49  wifi: mt76: ignore key disable commands

elapsed time: 728m

configs tested: 158
configs skipped: 14

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r005-20230403   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r002-20230403   gcc  
alpha                randconfig-r005-20230403   gcc  
alpha                randconfig-r023-20230403   gcc  
alpha                randconfig-r036-20230403   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r004-20230403   gcc  
arc                  randconfig-r006-20230403   gcc  
arc                  randconfig-r011-20230403   gcc  
arc                  randconfig-r016-20230403   gcc  
arc                  randconfig-r021-20230403   gcc  
arc                  randconfig-r033-20230403   gcc  
arc                  randconfig-r034-20230403   gcc  
arc                  randconfig-r043-20230403   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm          buildonly-randconfig-r001-20230403   clang
arm                                 defconfig   gcc  
arm                          exynos_defconfig   gcc  
arm                  randconfig-r034-20230403   gcc  
arm                  randconfig-r046-20230403   clang
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r006-20230403   clang
arm64                               defconfig   gcc  
arm64                randconfig-r004-20230403   clang
arm64                randconfig-r015-20230403   gcc  
arm64                randconfig-r022-20230403   gcc  
arm64                randconfig-r026-20230403   gcc  
arm64                randconfig-r032-20230403   clang
csky                                defconfig   gcc  
csky                 randconfig-r011-20230403   gcc  
csky                 randconfig-r013-20230403   gcc  
csky                 randconfig-r035-20230403   gcc  
hexagon              randconfig-r001-20230403   clang
hexagon              randconfig-r005-20230403   clang
hexagon              randconfig-r006-20230403   clang
hexagon              randconfig-r041-20230403   clang
hexagon              randconfig-r045-20230403   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r002-20230403   clang
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
ia64                             allmodconfig   gcc  
ia64                                defconfig   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r031-20230403   gcc  
m68k                             allmodconfig   gcc  
m68k         buildonly-randconfig-r002-20230403   gcc  
m68k         buildonly-randconfig-r006-20230403   gcc  
m68k                                defconfig   gcc  
m68k                       m5249evb_defconfig   gcc  
m68k                 randconfig-r014-20230403   gcc  
m68k                 randconfig-r023-20230403   gcc  
microblaze   buildonly-randconfig-r005-20230403   gcc  
microblaze           randconfig-r031-20230403   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips         buildonly-randconfig-r001-20230403   gcc  
mips                     loongson2k_defconfig   clang
mips                 randconfig-r004-20230403   gcc  
mips                 randconfig-r011-20230403   clang
mips                 randconfig-r014-20230403   clang
mips                 randconfig-r021-20230403   clang
mips                 randconfig-r024-20230403   clang
nios2        buildonly-randconfig-r004-20230403   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r002-20230403   gcc  
nios2                randconfig-r014-20230403   gcc  
nios2                randconfig-r022-20230403   gcc  
nios2                randconfig-r024-20230403   gcc  
openrisc             randconfig-r012-20230403   gcc  
openrisc             randconfig-r034-20230403   gcc  
parisc       buildonly-randconfig-r003-20230403   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r003-20230403   gcc  
parisc               randconfig-r013-20230403   gcc  
parisc               randconfig-r035-20230403   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc              randconfig-r005-20230403   clang
powerpc              randconfig-r006-20230403   clang
powerpc              randconfig-r013-20230403   gcc  
powerpc              randconfig-r015-20230403   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv        buildonly-randconfig-r002-20230403   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r006-20230403   clang
riscv                randconfig-r012-20230403   gcc  
riscv                randconfig-r013-20230403   gcc  
riscv                randconfig-r016-20230403   gcc  
riscv                randconfig-r042-20230403   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390         buildonly-randconfig-r005-20230403   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r002-20230403   clang
s390                 randconfig-r035-20230403   clang
s390                 randconfig-r044-20230403   gcc  
sh                               allmodconfig   gcc  
sh                          landisk_defconfig   gcc  
sh                   randconfig-r001-20230403   gcc  
sh                   randconfig-r003-20230403   gcc  
sh                   randconfig-r015-20230403   gcc  
sh                          urquell_defconfig   gcc  
sparc        buildonly-randconfig-r003-20230403   gcc  
sparc        buildonly-randconfig-r004-20230403   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r014-20230403   gcc  
sparc                randconfig-r032-20230403   gcc  
sparc64      buildonly-randconfig-r006-20230403   gcc  
sparc64                             defconfig   gcc  
sparc64              randconfig-r004-20230403   gcc  
sparc64              randconfig-r005-20230403   gcc  
sparc64              randconfig-r024-20230403   gcc  
sparc64              randconfig-r026-20230403   gcc  
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
x86_64               randconfig-a013-20230403   gcc  
x86_64               randconfig-a014-20230403   gcc  
x86_64               randconfig-a015-20230403   gcc  
x86_64               randconfig-a016-20230403   gcc  
x86_64               randconfig-r026-20230403   gcc  
x86_64                               rhel-8.3   gcc  
xtensa       buildonly-randconfig-r003-20230403   gcc  
xtensa               randconfig-r021-20230403   gcc  
xtensa                         virt_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests
