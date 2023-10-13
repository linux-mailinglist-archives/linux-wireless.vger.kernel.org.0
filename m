Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D13727C7B18
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Oct 2023 03:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbjJMBNd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 Oct 2023 21:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjJMBNc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 12 Oct 2023 21:13:32 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C32F2C9
        for <linux-wireless@vger.kernel.org>; Thu, 12 Oct 2023 18:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697159610; x=1728695610;
  h=date:from:to:cc:subject:message-id;
  bh=oJx9Wkzu0jnHcm73Vm/BWEZ75vXNTTnsoEmUNwsYzKg=;
  b=Gq1LAbsXEVq4f9YzZGzACse+pxKk9kwC3cBRe/TCBI4V+VSTt3LTco9A
   V9tDtf7R2NDfVzR6HQQ7f2Gsg9nNvs+ab3v/xobRCtdfsRxVjdW4Poyj0
   69TcpH/hxI9V4YArOJDJD6DIpl1vP64hW0ipBO5qS7Bb+cVyznUEbm2RT
   uLnopotBe5u1jyhsLVJQAS8Gy/0xm7WeB8TZ09vQiubbsaqXsERpCGJKT
   NzSCLSjTj3rj/O9an1DGhWpPXwTmiNWY4hWx3aiHaw/OuvGsq0/kV2JrV
   RFZaZWGNjuWIKDchU1xjW/+iriauens7NGAcPzi5hyz7h9DOagvb39FW1
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="471312859"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="471312859"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 18:13:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="758285416"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="758285416"
Received: from lkp-server02.sh.intel.com (HELO f64821696465) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 12 Oct 2023 18:13:29 -0700
Received: from kbuild by f64821696465 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qr6k3-0004AX-0H;
        Fri, 13 Oct 2023 01:13:27 +0000
Date:   Fri, 13 Oct 2023 09:12:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johannes Berg <johannes.berg@intel.com>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org
Subject: [wireless:for-next] BUILD SUCCESS
 f2ac54ebf85615a6d78f5eb213a8bbeeb17ebe5d
Message-ID: <202310130955.Lm5JmQwl-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git for-next
branch HEAD: f2ac54ebf85615a6d78f5eb213a8bbeeb17ebe5d  net: rfkill: reduce data->mtx scope in rfkill_fop_open

elapsed time: 1977m

configs tested: 127
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
arc                   randconfig-001-20231012   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                   randconfig-001-20231012   gcc  
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
i386         buildonly-randconfig-001-20231012   gcc  
i386         buildonly-randconfig-002-20231012   gcc  
i386         buildonly-randconfig-003-20231012   gcc  
i386         buildonly-randconfig-004-20231012   gcc  
i386         buildonly-randconfig-005-20231012   gcc  
i386         buildonly-randconfig-006-20231012   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20231012   gcc  
i386                  randconfig-002-20231012   gcc  
i386                  randconfig-003-20231012   gcc  
i386                  randconfig-004-20231012   gcc  
i386                  randconfig-005-20231012   gcc  
i386                  randconfig-006-20231012   gcc  
i386                  randconfig-011-20231012   gcc  
i386                  randconfig-012-20231012   gcc  
i386                  randconfig-013-20231012   gcc  
i386                  randconfig-014-20231012   gcc  
i386                  randconfig-015-20231012   gcc  
i386                  randconfig-016-20231012   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
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
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20231012   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20231012   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
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
x86_64       buildonly-randconfig-001-20231012   gcc  
x86_64       buildonly-randconfig-002-20231012   gcc  
x86_64       buildonly-randconfig-003-20231012   gcc  
x86_64       buildonly-randconfig-004-20231012   gcc  
x86_64       buildonly-randconfig-005-20231012   gcc  
x86_64       buildonly-randconfig-006-20231012   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20231012   gcc  
x86_64                randconfig-002-20231012   gcc  
x86_64                randconfig-003-20231012   gcc  
x86_64                randconfig-004-20231012   gcc  
x86_64                randconfig-005-20231012   gcc  
x86_64                randconfig-006-20231012   gcc  
x86_64                randconfig-011-20231012   gcc  
x86_64                randconfig-012-20231012   gcc  
x86_64                randconfig-013-20231012   gcc  
x86_64                randconfig-014-20231012   gcc  
x86_64                randconfig-015-20231012   gcc  
x86_64                randconfig-016-20231012   gcc  
x86_64                randconfig-071-20231012   gcc  
x86_64                randconfig-072-20231012   gcc  
x86_64                randconfig-073-20231012   gcc  
x86_64                randconfig-074-20231012   gcc  
x86_64                randconfig-075-20231012   gcc  
x86_64                randconfig-076-20231012   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
