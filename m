Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D06DA7D8CAE
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Oct 2023 03:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbjJ0BE6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Oct 2023 21:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjJ0BE5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Oct 2023 21:04:57 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 960871B6
        for <linux-wireless@vger.kernel.org>; Thu, 26 Oct 2023 18:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698368694; x=1729904694;
  h=date:from:to:cc:subject:message-id;
  bh=dSxFQ+8irXQNqUyePURMH57CKwyK8Rnx6+O4xHLpGb4=;
  b=MTNkkHZ3s8ustAngqKCO/tjvwX5sL0UwSsk38dY4N3E1LTuCdJbmp3m4
   iptY7V9rY6NmMNOnqyLbssaODnpmfwziIzxAF1ffBcB37/o3UuHH31Ss9
   f++xEEvi8F1fL5FtXSuqtMG63uOMVltmULCi2+5aYuKwbklFjjIxSoeqm
   FAzTSEdjCHEa/hyIdjqkm/0eMj6ckUkl8HjLCtn/pmzMixrKrp+5Y7iSq
   Lb3kZIbv8O9xi99GDf/FycgBmDfuscnwq3MplWAcNAaZm+p/viKwDHXZX
   +e/1On1wLSDhMYADgBjX74Ayrm+ytmKJlqyqwvUjio+00/4LDuo/kpZIb
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="390542972"
X-IronPort-AV: E=Sophos;i="6.03,255,1694761200"; 
   d="scan'208";a="390542972"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 18:04:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="903115594"
X-IronPort-AV: E=Sophos;i="6.03,255,1694761200"; 
   d="scan'208";a="903115594"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 26 Oct 2023 18:02:25 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qwBHO-000AHl-1j;
        Fri, 27 Oct 2023 01:04:50 +0000
Date:   Fri, 27 Oct 2023 09:04:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
Subject: [wireless-next:pending] BUILD SUCCESS
 81ba6b51c3a640b277274701407bbf557f12edac
Message-ID: <202310270922.rm7Y1Mgp-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git pending
branch HEAD: 81ba6b51c3a640b277274701407bbf557f12edac  wifi: remove ipw2100/ipw2200 drivers

elapsed time: 4953m

configs tested: 133
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
arc                   randconfig-001-20231024   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                   randconfig-001-20231025   gcc  
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
i386         buildonly-randconfig-001-20231024   gcc  
i386         buildonly-randconfig-002-20231024   gcc  
i386         buildonly-randconfig-003-20231024   gcc  
i386         buildonly-randconfig-004-20231024   gcc  
i386         buildonly-randconfig-005-20231024   gcc  
i386         buildonly-randconfig-006-20231024   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20231024   gcc  
i386                  randconfig-002-20231024   gcc  
i386                  randconfig-003-20231024   gcc  
i386                  randconfig-004-20231024   gcc  
i386                  randconfig-005-20231024   gcc  
i386                  randconfig-006-20231024   gcc  
i386                  randconfig-011-20231024   gcc  
i386                  randconfig-012-20231024   gcc  
i386                  randconfig-013-20231024   gcc  
i386                  randconfig-014-20231024   gcc  
i386                  randconfig-015-20231024   gcc  
i386                  randconfig-016-20231024   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20231024   gcc  
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
riscv                 randconfig-001-20231024   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20231024   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                 randconfig-001-20231024   gcc  
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
x86_64       buildonly-randconfig-001-20231024   gcc  
x86_64       buildonly-randconfig-002-20231024   gcc  
x86_64       buildonly-randconfig-003-20231024   gcc  
x86_64       buildonly-randconfig-004-20231024   gcc  
x86_64       buildonly-randconfig-005-20231024   gcc  
x86_64       buildonly-randconfig-006-20231024   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20231024   gcc  
x86_64                randconfig-002-20231024   gcc  
x86_64                randconfig-003-20231024   gcc  
x86_64                randconfig-004-20231024   gcc  
x86_64                randconfig-005-20231024   gcc  
x86_64                randconfig-006-20231024   gcc  
x86_64                randconfig-011-20231025   gcc  
x86_64                randconfig-012-20231025   gcc  
x86_64                randconfig-013-20231025   gcc  
x86_64                randconfig-014-20231025   gcc  
x86_64                randconfig-015-20231025   gcc  
x86_64                randconfig-016-20231025   gcc  
x86_64                randconfig-071-20231025   gcc  
x86_64                randconfig-072-20231025   gcc  
x86_64                randconfig-073-20231025   gcc  
x86_64                randconfig-074-20231025   gcc  
x86_64                randconfig-075-20231025   gcc  
x86_64                randconfig-076-20231025   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
