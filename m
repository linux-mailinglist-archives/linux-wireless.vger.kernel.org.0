Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AEFA7B98B5
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Oct 2023 01:32:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231684AbjJDXce (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Oct 2023 19:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbjJDXcd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Oct 2023 19:32:33 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF464C0
        for <linux-wireless@vger.kernel.org>; Wed,  4 Oct 2023 16:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696462350; x=1727998350;
  h=date:from:to:cc:subject:message-id;
  bh=DIYwT/GHCl6hAWhfvXT8QwhVrI5zeja12aqfVu8/69A=;
  b=IzpluOk0MbSxRsiyvoxVK/ogBeDIGd8hBgDyoN8H/NwXyJ+9x/4fab21
   XbEioO4HGFLVkbi7B3fNmyBga3F8IhbHgMyzdxJrAShlZGXPvAjo65XvW
   YI7/5Edzbg1ImMczrz3h31/+3obRXemIrVA20P+iVCkEzHghpbeVX1ZNW
   rpDzGclaZcOjDhz+uiz0a6bEW/9jkaka3i9IH2+souLTyeUziLtQmItBC
   /ahkGmT5h3wAtYsbsTeO1Km3ufOtJvBM+iOnJDeBE9yKdRiaHZpx3SPM1
   ZhkbQsEO4YhxzL8VmKmxViMGL07YCV+rz12RJ7UzB250jLanCqBj+KCEH
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="363616654"
X-IronPort-AV: E=Sophos;i="6.03,201,1694761200"; 
   d="scan'208";a="363616654"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 16:32:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="786720093"
X-IronPort-AV: E=Sophos;i="6.03,201,1694761200"; 
   d="scan'208";a="786720093"
Received: from lkp-server02.sh.intel.com (HELO c3b01524d57c) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 04 Oct 2023 16:32:22 -0700
Received: from kbuild by c3b01524d57c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qoBLn-000KkK-2F;
        Wed, 04 Oct 2023 23:32:19 +0000
Date:   Thu, 05 Oct 2023 07:32:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
Subject: [wireless-next:pending] BUILD SUCCESS
 6e41ffa1dea50785b6ec9c9cc83363e2d18a00df
Message-ID: <202310050705.PQBlf2Z9-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git pending
branch HEAD: 6e41ffa1dea50785b6ec9c9cc83363e2d18a00df  Merge tag 'mt76-for-kvalo-2023-09-30' of https://github.com/nbd168/wireless into pending

elapsed time: 734m

configs tested: 128
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
arc                   randconfig-001-20231004   gcc  
arc                   randconfig-001-20231005   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                            dove_defconfig   clang
arm                       multi_v4t_defconfig   gcc  
arm                   randconfig-001-20231004   gcc  
arm                   randconfig-001-20231005   gcc  
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
i386         buildonly-randconfig-001-20231004   gcc  
i386         buildonly-randconfig-002-20231004   gcc  
i386         buildonly-randconfig-003-20231004   gcc  
i386         buildonly-randconfig-004-20231004   gcc  
i386         buildonly-randconfig-005-20231004   gcc  
i386         buildonly-randconfig-006-20231004   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20231004   gcc  
i386                  randconfig-001-20231005   gcc  
i386                  randconfig-002-20231004   gcc  
i386                  randconfig-002-20231005   gcc  
i386                  randconfig-003-20231004   gcc  
i386                  randconfig-003-20231005   gcc  
i386                  randconfig-004-20231004   gcc  
i386                  randconfig-004-20231005   gcc  
i386                  randconfig-005-20231004   gcc  
i386                  randconfig-005-20231005   gcc  
i386                  randconfig-006-20231004   gcc  
i386                  randconfig-006-20231005   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20231004   gcc  
loongarch             randconfig-001-20231005   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                            mac_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                  decstation_64_defconfig   gcc  
mips                           ip28_defconfig   clang
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
openrisc                         alldefconfig   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   gcc  
powerpc                     mpc512x_defconfig   clang
powerpc                       ppc64_defconfig   gcc  
powerpc                         wii_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                     magicpanelr2_defconfig   gcc  
sh                             sh03_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                       sparc32_defconfig   gcc  
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
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20231004   gcc  
x86_64                randconfig-002-20231004   gcc  
x86_64                randconfig-003-20231004   gcc  
x86_64                randconfig-004-20231004   gcc  
x86_64                randconfig-005-20231004   gcc  
x86_64                randconfig-006-20231004   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
