Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 963D17C6ACA
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Oct 2023 12:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347132AbjJLKRp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 Oct 2023 06:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347124AbjJLKRo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 12 Oct 2023 06:17:44 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B71BECA
        for <linux-wireless@vger.kernel.org>; Thu, 12 Oct 2023 03:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697105862; x=1728641862;
  h=date:from:to:cc:subject:message-id;
  bh=YZrAZTGRin7SlnKJkdY24uoyhisnuqzJv2dRNjPuoNk=;
  b=a+0sJ3cf9WYqhzHS6VwJRtJU1giEf80PJcmifH+L49jbbMt5BRPIQrHw
   qDOcpy5NharJAmKnqI0JuOO9y+2CZhYRVjgnqQB/r3nOTHd8Qr04GeKaX
   FFshMHiGeZtkH0h+DsCaGD431a2H7iSGbZv+u1iWepEutSN4FKK+FaZCD
   a/gvh591bRlkPAa5Dn9YfUVxteqkaOy2ZIFC/hJviWgavBe33Eyl3Q3JP
   zk2h4UTYBG7cEes0twBXAotB3dtcC2xJJIEvWGNWcrDKfLeLNESoLmEFJ
   kK5cjZVJ0cXXYVGgjxXXDrOtNGOeQxUbpWelhQY6qTf+h6LhQH2ULamdE
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="364252422"
X-IronPort-AV: E=Sophos;i="6.03,218,1694761200"; 
   d="scan'208";a="364252422"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 03:17:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="820082595"
X-IronPort-AV: E=Sophos;i="6.03,218,1694761200"; 
   d="scan'208";a="820082595"
Received: from lkp-server02.sh.intel.com (HELO f64821696465) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 12 Oct 2023 03:17:41 -0700
Received: from kbuild by f64821696465 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qqsl9-0003Mr-0H;
        Thu, 12 Oct 2023 10:17:39 +0000
Date:   Thu, 12 Oct 2023 18:17:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
Subject: [wireless-next:main] BUILD SUCCESS
 62d19b35808816dc2bdf5031e5401230f6a915ba
Message-ID: <202310121803.54t6Apla-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: 62d19b35808816dc2bdf5031e5401230f6a915ba  wifi: brcmfmac: fweh: Add __counted_by for struct brcmf_fweh_queue_item and use struct_size()

elapsed time: 1459m

configs tested: 161
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
arc                      axs103_smp_defconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20231011   gcc  
arc                   randconfig-001-20231012   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                         orion5x_defconfig   clang
arm                   randconfig-001-20231011   gcc  
arm                   randconfig-001-20231012   gcc  
arm                         wpcm450_defconfig   gcc  
arm64                            allmodconfig   gcc  
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20231011   gcc  
i386         buildonly-randconfig-002-20231011   gcc  
i386         buildonly-randconfig-003-20231011   gcc  
i386         buildonly-randconfig-004-20231011   gcc  
i386         buildonly-randconfig-005-20231011   gcc  
i386         buildonly-randconfig-006-20231011   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20231011   gcc  
i386                  randconfig-001-20231012   gcc  
i386                  randconfig-002-20231011   gcc  
i386                  randconfig-002-20231012   gcc  
i386                  randconfig-003-20231011   gcc  
i386                  randconfig-003-20231012   gcc  
i386                  randconfig-004-20231011   gcc  
i386                  randconfig-004-20231012   gcc  
i386                  randconfig-005-20231011   gcc  
i386                  randconfig-005-20231012   gcc  
i386                  randconfig-006-20231011   gcc  
i386                  randconfig-006-20231012   gcc  
i386                  randconfig-011-20231011   gcc  
i386                  randconfig-012-20231011   gcc  
i386                  randconfig-013-20231011   gcc  
i386                  randconfig-014-20231011   gcc  
i386                  randconfig-015-20231011   gcc  
i386                  randconfig-016-20231011   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20231011   gcc  
loongarch             randconfig-001-20231012   gcc  
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
mips                      loongson3_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc64                         alldefconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   gcc  
powerpc                      pcm030_defconfig   gcc  
powerpc                     tqm8560_defconfig   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20231011   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20231011   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                         apsh4a3a_defconfig   gcc  
sh                                  defconfig   gcc  
sh                ecovec24-romimage_defconfig   gcc  
sh                        edosk7705_defconfig   gcc  
sh                           se7750_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                 randconfig-001-20231012   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-001-20231011   gcc  
x86_64       buildonly-randconfig-001-20231012   gcc  
x86_64       buildonly-randconfig-002-20231011   gcc  
x86_64       buildonly-randconfig-002-20231012   gcc  
x86_64       buildonly-randconfig-003-20231011   gcc  
x86_64       buildonly-randconfig-003-20231012   gcc  
x86_64       buildonly-randconfig-004-20231011   gcc  
x86_64       buildonly-randconfig-004-20231012   gcc  
x86_64       buildonly-randconfig-005-20231011   gcc  
x86_64       buildonly-randconfig-005-20231012   gcc  
x86_64       buildonly-randconfig-006-20231011   gcc  
x86_64       buildonly-randconfig-006-20231012   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20231011   gcc  
x86_64                randconfig-002-20231011   gcc  
x86_64                randconfig-003-20231011   gcc  
x86_64                randconfig-004-20231011   gcc  
x86_64                randconfig-005-20231011   gcc  
x86_64                randconfig-006-20231011   gcc  
x86_64                randconfig-011-20231011   gcc  
x86_64                randconfig-012-20231011   gcc  
x86_64                randconfig-013-20231011   gcc  
x86_64                randconfig-014-20231011   gcc  
x86_64                randconfig-015-20231011   gcc  
x86_64                randconfig-016-20231011   gcc  
x86_64                randconfig-071-20231011   gcc  
x86_64                randconfig-072-20231011   gcc  
x86_64                randconfig-073-20231011   gcc  
x86_64                randconfig-074-20231011   gcc  
x86_64                randconfig-075-20231011   gcc  
x86_64                randconfig-076-20231011   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                  cadence_csp_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
