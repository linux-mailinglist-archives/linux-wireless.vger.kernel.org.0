Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DBFA7D260E
	for <lists+linux-wireless@lfdr.de>; Sun, 22 Oct 2023 23:08:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232851AbjJVVIP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 22 Oct 2023 17:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232855AbjJVVIO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 22 Oct 2023 17:08:14 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67CE1F7
        for <linux-wireless@vger.kernel.org>; Sun, 22 Oct 2023 14:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698008892; x=1729544892;
  h=date:from:to:cc:subject:message-id;
  bh=ZhZWRcpDjIa2f4L052R+TujPtnnYt8ia7vQYYPNyq7Q=;
  b=hej1+5gSxMKxr0WfFgwET525eIXcM4ljL0FJAYAxlmnCxm+3xCbrj9sy
   E03Rdahb8Bq+TH81ntRacNEKBnICz3FPkMK/FgRvipYEntbNSfrivBzz8
   7wi4zMedfB+jdRtbLPVYnywMMqCBZj/ZFWcjL8fJVsujFCWBNsMNRDVeI
   r2e6XCOo4Xi+aJ9TKao39yKbxnobf37a3zg0fcZnpWm7G/54kRr4HPmgu
   o4C0iB9UGWI4obD2DhCDScLvS/Uv+bYUK2TcldN/1Gu/ft+gJhkUfju/w
   aMIPM4qTrUpq5fOSZTLlrRl93AGEgczurq6qe4Z5EovQn9/9F/kt7FjdZ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10871"; a="386551150"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="386551150"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2023 14:08:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10871"; a="707733905"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="707733905"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 22 Oct 2023 14:08:10 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qufg7-0006GS-2h;
        Sun, 22 Oct 2023 21:08:07 +0000
Date:   Mon, 23 Oct 2023 05:07:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
Subject: [wireless-next:main] BUILD SUCCESS
 05ac1a198a63ad66bf5ae8b7321407c102d40ef3
Message-ID: <202310230521.AAaFgnpG-lkp@intel.com>
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
branch HEAD: 05ac1a198a63ad66bf5ae8b7321407c102d40ef3  wifi: wilc1000: use vmm_table as array in wilc struct

elapsed time: 5106m

configs tested: 134
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
arc                   randconfig-001-20231020   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                   randconfig-001-20231021   gcc  
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
i386         buildonly-randconfig-001-20231021   gcc  
i386         buildonly-randconfig-002-20231021   gcc  
i386         buildonly-randconfig-003-20231021   gcc  
i386         buildonly-randconfig-004-20231021   gcc  
i386         buildonly-randconfig-005-20231021   gcc  
i386         buildonly-randconfig-006-20231021   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20231021   gcc  
i386                  randconfig-002-20231021   gcc  
i386                  randconfig-003-20231021   gcc  
i386                  randconfig-004-20231021   gcc  
i386                  randconfig-005-20231021   gcc  
i386                  randconfig-006-20231021   gcc  
i386                  randconfig-011-20231020   gcc  
i386                  randconfig-012-20231020   gcc  
i386                  randconfig-013-20231020   gcc  
i386                  randconfig-014-20231020   gcc  
i386                  randconfig-015-20231020   gcc  
i386                  randconfig-016-20231020   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20231020   gcc  
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
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20231020   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20231020   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                 randconfig-001-20231020   gcc  
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
x86_64       buildonly-randconfig-001-20231020   gcc  
x86_64       buildonly-randconfig-002-20231020   gcc  
x86_64       buildonly-randconfig-003-20231020   gcc  
x86_64       buildonly-randconfig-004-20231020   gcc  
x86_64       buildonly-randconfig-005-20231020   gcc  
x86_64       buildonly-randconfig-006-20231020   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20231020   gcc  
x86_64                randconfig-002-20231020   gcc  
x86_64                randconfig-003-20231020   gcc  
x86_64                randconfig-004-20231020   gcc  
x86_64                randconfig-005-20231020   gcc  
x86_64                randconfig-006-20231020   gcc  
x86_64                randconfig-011-20231021   gcc  
x86_64                randconfig-012-20231021   gcc  
x86_64                randconfig-013-20231021   gcc  
x86_64                randconfig-014-20231021   gcc  
x86_64                randconfig-015-20231021   gcc  
x86_64                randconfig-016-20231021   gcc  
x86_64                randconfig-071-20231021   gcc  
x86_64                randconfig-072-20231021   gcc  
x86_64                randconfig-073-20231021   gcc  
x86_64                randconfig-074-20231021   gcc  
x86_64                randconfig-075-20231021   gcc  
x86_64                randconfig-076-20231021   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
