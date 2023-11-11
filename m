Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC297E8C00
	for <lists+linux-wireless@lfdr.de>; Sat, 11 Nov 2023 19:05:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229437AbjKKSFY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 11 Nov 2023 13:05:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjKKSFX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 11 Nov 2023 13:05:23 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBA0AD54
        for <linux-wireless@vger.kernel.org>; Sat, 11 Nov 2023 10:05:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699725920; x=1731261920;
  h=date:from:to:cc:subject:message-id;
  bh=5+XriFsV2g7xvGSea+bWaGrkLT2nFo4RL6CAUlyXYec=;
  b=W8ThljQAP9keqMhfyRB8VkgkTmZXX6ykFX9085WbFRqWiSbF9v5GA6YP
   jwDaXsnxsB5LDfSVcUZvyN0ORDfkqJFTZmitd5ahhuSwLo60TkFca8W6p
   hOE/1psekdkwU2c2MkKWi4gqQhi9RmpF/hXYds8gBact0gm3Sq10tLf8P
   462pDlZtfosEO8SvUNlvn19+3Mtpt5zPPhXYav4iEDSxWAADVajUEQzeB
   2ZIY/bQzBLbEfxOuswgqwB1cjxwRIgOgnf/TtQG5GNj04ibUpQLX/SBb0
   Q05m7zGpXIKx90e/OweG/LMdF+9Q4Qs1dCezqKuDr1buTh/InL7UJxSfQ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10891"; a="394194137"
X-IronPort-AV: E=Sophos;i="6.03,295,1694761200"; 
   d="scan'208";a="394194137"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2023 10:05:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10891"; a="834373220"
X-IronPort-AV: E=Sophos;i="6.03,295,1694761200"; 
   d="scan'208";a="834373220"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 11 Nov 2023 10:05:18 -0800
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1r1sM8-000AfA-2l;
        Sat, 11 Nov 2023 18:05:16 +0000
Date:   Sun, 12 Nov 2023 02:04:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johannes Berg <johannes.berg@intel.com>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org
Subject: [wireless:debugfs-locking-fixes] BUILD SUCCESS
 3a6de55dae6e476afb92a19a7fccc39a01fb7c67
Message-ID: <202311120249.1LDWEzBW-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git debugfs-locking-fixes
branch HEAD: 3a6de55dae6e476afb92a19a7fccc39a01fb7c67  wifi: mac80211: use wiphy locked debugfs for sdata/link

elapsed time: 1453m

configs tested: 175
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20231111   gcc  
arc                   randconfig-002-20231111   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                   randconfig-001-20231111   gcc  
arm                   randconfig-002-20231111   gcc  
arm                   randconfig-003-20231111   gcc  
arm                   randconfig-004-20231111   gcc  
arm64                            allmodconfig   gcc  
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20231111   gcc  
arm64                 randconfig-002-20231111   gcc  
arm64                 randconfig-003-20231111   gcc  
arm64                 randconfig-004-20231111   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20231111   gcc  
csky                  randconfig-002-20231111   gcc  
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20231111   gcc  
i386         buildonly-randconfig-002-20231111   gcc  
i386         buildonly-randconfig-003-20231111   gcc  
i386         buildonly-randconfig-004-20231111   gcc  
i386         buildonly-randconfig-005-20231111   gcc  
i386         buildonly-randconfig-006-20231111   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20231111   gcc  
i386                  randconfig-002-20231111   gcc  
i386                  randconfig-003-20231111   gcc  
i386                  randconfig-004-20231111   gcc  
i386                  randconfig-005-20231111   gcc  
i386                  randconfig-006-20231111   gcc  
i386                  randconfig-011-20231111   gcc  
i386                  randconfig-012-20231111   gcc  
i386                  randconfig-013-20231111   gcc  
i386                  randconfig-014-20231111   gcc  
i386                  randconfig-015-20231111   gcc  
i386                  randconfig-016-20231111   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20231111   gcc  
loongarch             randconfig-002-20231111   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20231111   gcc  
nios2                 randconfig-002-20231111   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20231111   gcc  
parisc                randconfig-002-20231111   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   gcc  
powerpc               randconfig-001-20231111   gcc  
powerpc               randconfig-002-20231111   gcc  
powerpc               randconfig-003-20231111   gcc  
powerpc64             randconfig-001-20231111   gcc  
powerpc64             randconfig-002-20231111   gcc  
powerpc64             randconfig-003-20231111   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20231111   gcc  
riscv                 randconfig-002-20231111   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20231111   gcc  
s390                  randconfig-002-20231111   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20231111   gcc  
sh                    randconfig-001-20231112   gcc  
sh                    randconfig-002-20231111   gcc  
sh                    randconfig-002-20231112   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                 randconfig-001-20231111   gcc  
sparc                 randconfig-001-20231112   gcc  
sparc                 randconfig-002-20231111   gcc  
sparc                 randconfig-002-20231112   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20231111   gcc  
sparc64               randconfig-001-20231112   gcc  
sparc64               randconfig-002-20231111   gcc  
sparc64               randconfig-002-20231112   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                    randconfig-001-20231111   gcc  
um                    randconfig-001-20231112   gcc  
um                    randconfig-002-20231111   gcc  
um                    randconfig-002-20231112   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-001-20231111   gcc  
x86_64       buildonly-randconfig-002-20231111   gcc  
x86_64       buildonly-randconfig-003-20231111   gcc  
x86_64       buildonly-randconfig-004-20231111   gcc  
x86_64       buildonly-randconfig-005-20231111   gcc  
x86_64       buildonly-randconfig-006-20231111   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20231111   gcc  
x86_64                randconfig-002-20231111   gcc  
x86_64                randconfig-003-20231111   gcc  
x86_64                randconfig-004-20231111   gcc  
x86_64                randconfig-005-20231111   gcc  
x86_64                randconfig-006-20231111   gcc  
x86_64                randconfig-011-20231111   gcc  
x86_64                randconfig-012-20231111   gcc  
x86_64                randconfig-013-20231111   gcc  
x86_64                randconfig-014-20231111   gcc  
x86_64                randconfig-015-20231111   gcc  
x86_64                randconfig-016-20231111   gcc  
x86_64                randconfig-071-20231111   gcc  
x86_64                randconfig-072-20231111   gcc  
x86_64                randconfig-073-20231111   gcc  
x86_64                randconfig-074-20231111   gcc  
x86_64                randconfig-075-20231111   gcc  
x86_64                randconfig-076-20231111   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                randconfig-001-20231111   gcc  
xtensa                randconfig-001-20231112   gcc  
xtensa                randconfig-002-20231111   gcc  
xtensa                randconfig-002-20231112   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
