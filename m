Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF85C7B7722
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Oct 2023 06:30:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232507AbjJDEaF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Oct 2023 00:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbjJDEaE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Oct 2023 00:30:04 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B19490
        for <linux-wireless@vger.kernel.org>; Tue,  3 Oct 2023 21:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696393800; x=1727929800;
  h=date:from:to:cc:subject:message-id;
  bh=xlIRUR+3aFNki9P7SlD0y0FCl3wjSURZVVu28HtiY/o=;
  b=VctkCkYbpMbVX0Hq8qYD5TbdQ2NDGKzudkkqkH9RpMKqHtmv75B3CiOM
   Gs6TnvEWvajSp4eJtkXiXMRt6mqzv74gwafMn5qzv2UbKOeD6PVkBKsLA
   anch7i6OY8ahwmPe4Gecg6druyU3uGhhZdD8uhU7JrlZ75aQS+FGmyErv
   2KUsl8qrKDoKO2DjfubPwRYrk+gNEBhWxNAhMoY6S+D4KQqRKezNKWwOI
   XN0jxZWedbhlpDrlASo0RA0ozcqXErVu9Zn4/L2VNWTj0owRMtEW4oZ+A
   dHhOjiXdkT037H1UFPIlv54j3Aa+Hrq2qnzES79hpmOzL3PrO3Blf7T0E
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="382955388"
X-IronPort-AV: E=Sophos;i="6.03,199,1694761200"; 
   d="scan'208";a="382955388"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 21:29:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="894770960"
X-IronPort-AV: E=Sophos;i="6.03,199,1694761200"; 
   d="scan'208";a="894770960"
Received: from lkp-server02.sh.intel.com (HELO c3b01524d57c) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 03 Oct 2023 21:28:33 -0700
Received: from kbuild by c3b01524d57c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qntWG-000BPt-23;
        Wed, 04 Oct 2023 04:29:56 +0000
Date:   Wed, 04 Oct 2023 12:29:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
Subject: [wireless-next:main] BUILD SUCCESS
 f0fb62e090bdf38eb3c7e127f21858708b55b71b
Message-ID: <202310041218.1CTX39G3-lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: f0fb62e090bdf38eb3c7e127f21858708b55b71b  wifi: rtlwifi: use unsigned long for rtl_bssid_entry timestamp

elapsed time: 954m

configs tested: 102
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
arc                   randconfig-001-20231003   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                   randconfig-001-20231003   gcc  
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
i386         buildonly-randconfig-001-20231003   gcc  
i386         buildonly-randconfig-002-20231003   gcc  
i386         buildonly-randconfig-003-20231003   gcc  
i386         buildonly-randconfig-004-20231003   gcc  
i386         buildonly-randconfig-005-20231003   gcc  
i386         buildonly-randconfig-006-20231003   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20231003   gcc  
i386                  randconfig-002-20231003   gcc  
i386                  randconfig-003-20231003   gcc  
i386                  randconfig-004-20231003   gcc  
i386                  randconfig-005-20231003   gcc  
i386                  randconfig-006-20231003   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20231003   gcc  
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
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
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
x86_64                randconfig-006-20231003   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
