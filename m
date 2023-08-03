Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E13F276DD11
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Aug 2023 03:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232289AbjHCBSm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Aug 2023 21:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbjHCBSk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Aug 2023 21:18:40 -0400
Received: from mgamail.intel.com (unknown [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 885101BF
        for <linux-wireless@vger.kernel.org>; Wed,  2 Aug 2023 18:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691025519; x=1722561519;
  h=date:from:to:cc:subject:message-id;
  bh=TkKWFPbv9ErsE8bCi3z3ukU4ItksmbgHbrkFdtSmgHI=;
  b=FCqiS7adBeCKAW/CjZrA6RpPu0KO9x5uFno19K+d9HRNnIszKhy7/8HL
   6Tl+8FjFCWRxrZTf+BEI2M3jWtDENwVkZpPfOazPKX2NAJx+QzUKA4V2b
   Zk+eaJ2JLtFj8/fyi4xPjzfOtYcCVvYLYUMAGmsgdA/rcbBescp89+y/L
   vtbwgbWo6JeQylMbvYZvO4FckElZrlvsQdGL8s5uu8WVQ2wyLRe4SX4i7
   ZaEEDvF5IAKw0Y0U6JXU7p/9Pw7q9XjZFhD40Bjt1wvEaNUAKdqemS0Th
   VlH6kTUho+A2ITzLcpYfCsbEyg3Xqf+wAxcVnWA0zHPZttk+3HICgfTY9
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="372475617"
X-IronPort-AV: E=Sophos;i="6.01,250,1684825200"; 
   d="scan'208";a="372475617"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 18:18:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="819426954"
X-IronPort-AV: E=Sophos;i="6.01,250,1684825200"; 
   d="scan'208";a="819426954"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 02 Aug 2023 18:18:35 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qRMz4-0001dT-2F;
        Thu, 03 Aug 2023 01:18:34 +0000
Date:   Thu, 03 Aug 2023 09:17:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
Subject: [wireless-next:main] BUILD SUCCESS
 288c63d5cb4667a51a04668b3e2bb0ea499bc5f4
Message-ID: <202308030935.xO2yxbec-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: 288c63d5cb4667a51a04668b3e2bb0ea499bc5f4  wifi: mwifiex: fix error recovery in PCIE buffer descriptor management

elapsed time: 876m

configs tested: 167
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r023-20230731   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                            hsdk_defconfig   gcc  
arc                  randconfig-r004-20230801   gcc  
arc                  randconfig-r025-20230731   gcc  
arc                  randconfig-r026-20230731   gcc  
arc                  randconfig-r031-20230731   gcc  
arc                  randconfig-r033-20230731   gcc  
arc                  randconfig-r043-20230731   gcc  
arc                  randconfig-r043-20230802   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                         assabet_defconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r005-20230801   clang
arm                  randconfig-r024-20230731   gcc  
arm                  randconfig-r032-20230731   clang
arm                  randconfig-r046-20230731   gcc  
arm                        realview_defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                randconfig-r014-20230731   clang
arm64                randconfig-r036-20230731   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r006-20230801   gcc  
hexagon              randconfig-r022-20230731   clang
hexagon              randconfig-r041-20230731   clang
hexagon              randconfig-r045-20230731   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230731   gcc  
i386         buildonly-randconfig-r004-20230801   gcc  
i386         buildonly-randconfig-r005-20230731   gcc  
i386         buildonly-randconfig-r005-20230801   gcc  
i386         buildonly-randconfig-r006-20230731   gcc  
i386         buildonly-randconfig-r006-20230801   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230731   gcc  
i386                 randconfig-i001-20230801   gcc  
i386                 randconfig-i002-20230731   gcc  
i386                 randconfig-i002-20230801   gcc  
i386                 randconfig-i003-20230731   gcc  
i386                 randconfig-i003-20230801   gcc  
i386                 randconfig-i004-20230731   gcc  
i386                 randconfig-i004-20230801   gcc  
i386                 randconfig-i005-20230731   gcc  
i386                 randconfig-i005-20230801   gcc  
i386                 randconfig-i006-20230731   gcc  
i386                 randconfig-i006-20230801   gcc  
i386                 randconfig-i011-20230731   clang
i386                 randconfig-i011-20230802   gcc  
i386                 randconfig-i012-20230731   clang
i386                 randconfig-i012-20230802   gcc  
i386                 randconfig-i013-20230731   clang
i386                 randconfig-i013-20230802   gcc  
i386                 randconfig-i014-20230731   clang
i386                 randconfig-i014-20230802   gcc  
i386                 randconfig-i015-20230731   clang
i386                 randconfig-i015-20230802   gcc  
i386                 randconfig-i016-20230731   clang
i386                 randconfig-i016-20230802   gcc  
i386                 randconfig-r014-20230731   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r012-20230801   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                        m5272c3_defconfig   gcc  
m68k                 randconfig-r002-20230801   gcc  
m68k                 randconfig-r006-20230801   gcc  
m68k                 randconfig-r024-20230731   gcc  
microblaze           randconfig-r001-20230801   gcc  
microblaze           randconfig-r003-20230801   gcc  
microblaze           randconfig-r005-20230801   gcc  
microblaze           randconfig-r013-20230731   gcc  
microblaze           randconfig-r023-20230731   gcc  
microblaze           randconfig-r025-20230731   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                         bigsur_defconfig   gcc  
mips                      maltaaprp_defconfig   clang
mips                 randconfig-r001-20230801   clang
mips                 randconfig-r002-20230801   clang
mips                 randconfig-r016-20230801   gcc  
mips                 randconfig-r022-20230731   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r005-20230801   gcc  
nios2                randconfig-r015-20230731   gcc  
openrisc             randconfig-r003-20230801   gcc  
openrisc             randconfig-r012-20230731   gcc  
openrisc             randconfig-r036-20230731   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r006-20230801   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                     asp8347_defconfig   gcc  
powerpc                     mpc5200_defconfig   clang
powerpc                 mpc832x_rdb_defconfig   clang
powerpc              randconfig-r003-20230801   gcc  
powerpc              randconfig-r015-20230801   clang
riscv                            alldefconfig   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r021-20230731   clang
riscv                randconfig-r034-20230731   gcc  
riscv                randconfig-r042-20230731   clang
riscv                randconfig-r042-20230802   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r004-20230801   gcc  
s390                 randconfig-r011-20230731   clang
s390                 randconfig-r011-20230801   clang
s390                 randconfig-r044-20230731   clang
s390                 randconfig-r044-20230802   gcc  
sh                               allmodconfig   gcc  
sh                        apsh4ad0a_defconfig   gcc  
sh                   randconfig-r011-20230731   gcc  
sh                   randconfig-r014-20230801   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64              randconfig-r002-20230801   gcc  
sparc64              randconfig-r035-20230731   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                   randconfig-r013-20230801   gcc  
um                   randconfig-r032-20230731   clang
um                   randconfig-r034-20230731   clang
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230731   gcc  
x86_64       buildonly-randconfig-r001-20230801   gcc  
x86_64       buildonly-randconfig-r002-20230731   gcc  
x86_64       buildonly-randconfig-r002-20230801   gcc  
x86_64       buildonly-randconfig-r003-20230731   gcc  
x86_64       buildonly-randconfig-r003-20230801   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-r012-20230731   clang
x86_64               randconfig-x001-20230731   clang
x86_64               randconfig-x002-20230731   clang
x86_64               randconfig-x003-20230731   clang
x86_64               randconfig-x004-20230731   clang
x86_64               randconfig-x005-20230731   clang
x86_64               randconfig-x006-20230731   clang
x86_64               randconfig-x011-20230731   gcc  
x86_64               randconfig-x012-20230731   gcc  
x86_64               randconfig-x013-20230731   gcc  
x86_64               randconfig-x014-20230731   gcc  
x86_64               randconfig-x015-20230731   gcc  
x86_64               randconfig-x016-20230731   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa               randconfig-r033-20230731   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
