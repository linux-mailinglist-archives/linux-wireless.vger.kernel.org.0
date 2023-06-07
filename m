Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6D9672517B
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Jun 2023 03:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234932AbjFGBXy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Jun 2023 21:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbjFGBXr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Jun 2023 21:23:47 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B733172E
        for <linux-wireless@vger.kernel.org>; Tue,  6 Jun 2023 18:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686101026; x=1717637026;
  h=date:from:to:cc:subject:message-id;
  bh=qIl26vMxC+C6CUQaWZPVmU0Vtewu5oUFGNMXrSl8e0E=;
  b=NFIMVwYXKDaWVbQkjT3xSXDeI9om06b+JEpgs8k1kjGOs+XRyv7P6rAc
   YQI+tEfhrNztej3wNhYLEVNy1g3o14NWprctnxqdL8+0kCVrPKzvJRvl0
   txPgKfBWgtvqxxFcd1NJTOQV2sCPpY4cxIFT8UDOXS8SxcIzVjx8gcQUE
   QCcyP4985xHOz0MJIL3KKf8wfJ5BYxg4MLYycW2f/lqLYrEbvgVYq5nXU
   FyoKZeU5XfS8EMb+zfnMb1EhUcVZV8Z0+WWTmRO7XWc7fN28MRnSE7j4S
   lOysgoLquXk44VxPy1pZIxE4T1GDMA48V3CdZkkVxMXbSxaWxB1fmYu8R
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="359312187"
X-IronPort-AV: E=Sophos;i="6.00,222,1681196400"; 
   d="scan'208";a="359312187"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 18:23:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="774325929"
X-IronPort-AV: E=Sophos;i="6.00,222,1681196400"; 
   d="scan'208";a="774325929"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 06 Jun 2023 18:23:27 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q6htW-0005yF-37;
        Wed, 07 Jun 2023 01:23:26 +0000
Date:   Wed, 07 Jun 2023 09:22:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johannes Berg <johannes.berg@intel.com>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org
Subject: [wireless:for-next] BUILD SUCCESS
 f7e60032c6618dfd643c7210d5cba2789e2de2e2
Message-ID: <20230607012243.Yx11_%lkp@intel.com>
User-Agent: s-nail v14.9.24
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git for-next
branch HEAD: f7e60032c6618dfd643c7210d5cba2789e2de2e2  wifi: cfg80211: fix locking in regulatory disconnect

elapsed time: 722m

configs tested: 214
configs skipped: 10

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha        buildonly-randconfig-r001-20230606   gcc  
alpha        buildonly-randconfig-r004-20230606   gcc  
alpha        buildonly-randconfig-r006-20230606   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r001-20230606   gcc  
alpha                randconfig-r016-20230606   gcc  
alpha                randconfig-r032-20230606   gcc  
arc                              allyesconfig   gcc  
arc                          axs101_defconfig   gcc  
arc          buildonly-randconfig-r002-20230606   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r001-20230606   gcc  
arc                  randconfig-r002-20230606   gcc  
arc                  randconfig-r012-20230606   gcc  
arc                  randconfig-r016-20230606   gcc  
arc                  randconfig-r043-20230606   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm          buildonly-randconfig-r004-20230606   gcc  
arm                                 defconfig   gcc  
arm                          gemini_defconfig   gcc  
arm                           imxrt_defconfig   gcc  
arm                  randconfig-r004-20230606   clang
arm                  randconfig-r014-20230606   gcc  
arm                  randconfig-r022-20230606   gcc  
arm                  randconfig-r046-20230606   gcc  
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r005-20230606   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r005-20230606   gcc  
arm64                randconfig-r021-20230606   clang
arm64                randconfig-r025-20230606   clang
csky         buildonly-randconfig-r006-20230606   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r004-20230606   gcc  
csky                 randconfig-r006-20230606   gcc  
csky                 randconfig-r022-20230606   gcc  
csky                 randconfig-r035-20230606   gcc  
hexagon              randconfig-r002-20230606   clang
hexagon              randconfig-r022-20230606   clang
hexagon              randconfig-r041-20230606   clang
hexagon              randconfig-r045-20230606   clang
i386                             allyesconfig   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230606   gcc  
i386                 randconfig-i002-20230606   gcc  
i386                 randconfig-i003-20230606   gcc  
i386                 randconfig-i004-20230606   gcc  
i386                 randconfig-i005-20230606   gcc  
i386                 randconfig-i006-20230606   gcc  
i386                 randconfig-i011-20230606   clang
i386                 randconfig-i012-20230606   clang
i386                 randconfig-i013-20230606   clang
i386                 randconfig-i014-20230606   clang
i386                 randconfig-i015-20230606   clang
i386                 randconfig-i016-20230606   clang
i386                 randconfig-i051-20230606   gcc  
i386                 randconfig-i052-20230606   gcc  
i386                 randconfig-i053-20230606   gcc  
i386                 randconfig-i054-20230606   gcc  
i386                 randconfig-i055-20230606   gcc  
i386                 randconfig-i056-20230606   gcc  
i386                 randconfig-i061-20230606   gcc  
i386                 randconfig-i062-20230606   gcc  
i386                 randconfig-i063-20230606   gcc  
i386                 randconfig-i064-20230606   gcc  
i386                 randconfig-i065-20230606   gcc  
i386                 randconfig-i066-20230606   gcc  
i386                 randconfig-r003-20230606   gcc  
i386                 randconfig-r006-20230606   gcc  
i386                 randconfig-r024-20230606   clang
i386                 randconfig-r034-20230606   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch    buildonly-randconfig-r003-20230606   gcc  
loongarch    buildonly-randconfig-r006-20230606   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r003-20230606   gcc  
loongarch            randconfig-r011-20230606   gcc  
loongarch            randconfig-r013-20230606   gcc  
loongarch            randconfig-r026-20230606   gcc  
loongarch            randconfig-r031-20230606   gcc  
loongarch            randconfig-r032-20230606   gcc  
loongarch            randconfig-r033-20230606   gcc  
loongarch            randconfig-r034-20230606   gcc  
m68k                             alldefconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                         amcore_defconfig   gcc  
m68k                                defconfig   gcc  
m68k                        m5307c3_defconfig   gcc  
m68k                 randconfig-r012-20230606   gcc  
m68k                 randconfig-r016-20230606   gcc  
m68k                 randconfig-r022-20230606   gcc  
m68k                 randconfig-r025-20230606   gcc  
m68k                 randconfig-r033-20230606   gcc  
microblaze   buildonly-randconfig-r002-20230606   gcc  
microblaze   buildonly-randconfig-r004-20230606   gcc  
microblaze           randconfig-r001-20230606   gcc  
microblaze           randconfig-r011-20230606   gcc  
microblaze           randconfig-r012-20230606   gcc  
microblaze           randconfig-r014-20230606   gcc  
microblaze           randconfig-r015-20230606   gcc  
microblaze           randconfig-r024-20230606   gcc  
microblaze           randconfig-r032-20230606   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips         buildonly-randconfig-r002-20230606   clang
mips                       lemote2f_defconfig   clang
mips                 randconfig-r015-20230606   gcc  
mips                 randconfig-r021-20230606   gcc  
mips                 randconfig-r031-20230606   clang
mips                 randconfig-r036-20230606   clang
nios2        buildonly-randconfig-r004-20230606   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r005-20230606   gcc  
nios2                randconfig-r014-20230606   gcc  
openrisc     buildonly-randconfig-r003-20230606   gcc  
openrisc             randconfig-r003-20230606   gcc  
openrisc             randconfig-r012-20230606   gcc  
openrisc             randconfig-r021-20230606   gcc  
openrisc             randconfig-r024-20230606   gcc  
openrisc             randconfig-r026-20230606   gcc  
openrisc             randconfig-r031-20230606   gcc  
openrisc             randconfig-r035-20230606   gcc  
parisc       buildonly-randconfig-r001-20230606   gcc  
parisc       buildonly-randconfig-r005-20230606   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r034-20230606   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc      buildonly-randconfig-r001-20230606   clang
powerpc                       holly_defconfig   gcc  
powerpc                 mpc8313_rdb_defconfig   clang
powerpc                      ppc40x_defconfig   gcc  
powerpc              randconfig-r012-20230606   clang
powerpc              randconfig-r021-20230606   clang
powerpc              randconfig-r026-20230606   clang
powerpc              randconfig-r032-20230606   gcc  
powerpc              randconfig-r033-20230606   gcc  
powerpc              randconfig-r035-20230606   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv        buildonly-randconfig-r003-20230606   clang
riscv                               defconfig   gcc  
riscv                randconfig-r004-20230606   gcc  
riscv                randconfig-r025-20230606   clang
riscv                randconfig-r036-20230606   gcc  
riscv                randconfig-r042-20230606   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390         buildonly-randconfig-r002-20230606   clang
s390                                defconfig   gcc  
s390                 randconfig-r006-20230606   gcc  
s390                 randconfig-r044-20230606   clang
sh                               allmodconfig   gcc  
sh                        edosk7705_defconfig   gcc  
sh                   randconfig-r006-20230606   gcc  
sh                   randconfig-r013-20230606   gcc  
sh                   randconfig-r035-20230606   gcc  
sh                           sh2007_defconfig   gcc  
sparc        buildonly-randconfig-r003-20230606   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r011-20230606   gcc  
sparc                randconfig-r023-20230606   gcc  
sparc                randconfig-r024-20230606   gcc  
sparc                randconfig-r036-20230606   gcc  
sparc64              randconfig-r004-20230606   gcc  
sparc64              randconfig-r031-20230606   gcc  
sparc64              randconfig-r033-20230606   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r005-20230606   gcc  
x86_64       buildonly-randconfig-r006-20230606   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230606   gcc  
x86_64               randconfig-a002-20230606   gcc  
x86_64               randconfig-a003-20230606   gcc  
x86_64               randconfig-a004-20230606   gcc  
x86_64               randconfig-a005-20230606   gcc  
x86_64               randconfig-a006-20230606   gcc  
x86_64               randconfig-a011-20230606   clang
x86_64               randconfig-a012-20230606   clang
x86_64               randconfig-a013-20230606   clang
x86_64               randconfig-a014-20230606   clang
x86_64               randconfig-a015-20230606   clang
x86_64               randconfig-a016-20230606   clang
x86_64               randconfig-r005-20230606   gcc  
x86_64               randconfig-r015-20230606   clang
x86_64               randconfig-r021-20230606   clang
x86_64               randconfig-r023-20230606   clang
x86_64               randconfig-r034-20230606   gcc  
x86_64               randconfig-x051-20230606   clang
x86_64               randconfig-x052-20230606   clang
x86_64               randconfig-x053-20230606   clang
x86_64               randconfig-x054-20230606   clang
x86_64               randconfig-x055-20230606   clang
x86_64               randconfig-x056-20230606   clang
x86_64               randconfig-x061-20230606   clang
x86_64               randconfig-x062-20230606   clang
x86_64               randconfig-x063-20230606   clang
x86_64               randconfig-x064-20230606   clang
x86_64               randconfig-x065-20230606   clang
x86_64               randconfig-x066-20230606   clang
x86_64                               rhel-8.3   gcc  
xtensa                  audio_kc705_defconfig   gcc  
xtensa       buildonly-randconfig-r005-20230606   gcc  
xtensa               randconfig-r002-20230606   gcc  
xtensa               randconfig-r013-20230606   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
