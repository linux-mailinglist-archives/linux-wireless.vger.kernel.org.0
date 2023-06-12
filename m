Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7354872D062
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Jun 2023 22:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234549AbjFLUXJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 12 Jun 2023 16:23:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234168AbjFLUXI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 12 Jun 2023 16:23:08 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6306018E
        for <linux-wireless@vger.kernel.org>; Mon, 12 Jun 2023 13:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686601387; x=1718137387;
  h=date:from:to:cc:subject:message-id;
  bh=ZVuH5bFmDd+IhkR4tP2b/U4kmxoQxh5QKKk7bclqY90=;
  b=J0bcGucXDN+N9wLU5ASaOnK45uVIv5mtOX7I+fJDWWZqntU1nfy5a+s/
   NGInCHEBdSwTCBpTqIyW7BHLtXCC0rvAjvl2/S51SgaehHLcDxOL1tCNj
   MwqmnS6SQ8D+fF0yiYZqNg4XepukYyJmVYyjeuXdXnvBmwpEU4LLPZgyM
   B6koneMld7WIZkWO5fhzWbQkx3S2othWcu/lPBctSWd9SVxAqCG7NiERW
   ky53NPmmgZtJz/sILBBXdAgrmlBAMFkwk5FiyT8DzuLLznxddIIoVd+Re
   EdQhh1g8GqRaSwRTMPhgOJRn/PjZv6nIsUYr3I5uKZezkDbTr5feOsCK3
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="386543482"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="386543482"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 13:23:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="714524520"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="714524520"
Received: from lkp-server01.sh.intel.com (HELO 211f47bdb1cb) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 12 Jun 2023 13:23:06 -0700
Received: from kbuild by 211f47bdb1cb with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q8o49-0000fa-0x;
        Mon, 12 Jun 2023 20:23:05 +0000
Date:   Tue, 13 Jun 2023 04:22:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johannes Berg <johannes.berg@intel.com>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org
Subject: [wireless:for-next] BUILD SUCCESS
 d094482c9974a543851a18a1c587a7d132a81659
Message-ID: <202306130409.EOsAHtYR-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git for-next
branch HEAD: d094482c9974a543851a18a1c587a7d132a81659  wifi: mac80211: fragment per STA profile correctly

elapsed time: 722m

configs tested: 127
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r002-20230612   gcc  
alpha                randconfig-r025-20230612   gcc  
arc                              allyesconfig   gcc  
arc          buildonly-randconfig-r004-20230612   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r014-20230612   gcc  
arc                  randconfig-r043-20230612   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                  randconfig-r003-20230612   gcc  
arm                  randconfig-r024-20230612   clang
arm                  randconfig-r026-20230612   clang
arm                  randconfig-r036-20230612   gcc  
arm                  randconfig-r046-20230612   clang
arm64                            allyesconfig   gcc  
arm64        buildonly-randconfig-r001-20230612   clang
arm64                               defconfig   gcc  
arm64                randconfig-r004-20230612   clang
csky         buildonly-randconfig-r003-20230612   gcc  
csky                                defconfig   gcc  
csky                 randconfig-r002-20230612   gcc  
csky                 randconfig-r011-20230612   gcc  
csky                 randconfig-r016-20230612   gcc  
csky                 randconfig-r031-20230612   gcc  
hexagon      buildonly-randconfig-r006-20230612   clang
hexagon              randconfig-r003-20230612   clang
hexagon              randconfig-r014-20230612   clang
hexagon              randconfig-r041-20230612   clang
hexagon              randconfig-r045-20230612   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r006-20230612   clang
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230612   clang
i386                 randconfig-i002-20230612   clang
i386                 randconfig-i003-20230612   clang
i386                 randconfig-i004-20230612   clang
i386                 randconfig-i005-20230612   clang
i386                 randconfig-i006-20230612   clang
i386                 randconfig-i011-20230612   gcc  
i386                 randconfig-i012-20230612   gcc  
i386                 randconfig-i013-20230612   gcc  
i386                 randconfig-i014-20230612   gcc  
i386                 randconfig-i015-20230612   gcc  
i386                 randconfig-i016-20230612   gcc  
i386                 randconfig-r016-20230612   gcc  
i386                 randconfig-r021-20230612   gcc  
i386                 randconfig-r035-20230612   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r001-20230612   gcc  
loongarch            randconfig-r013-20230612   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r033-20230612   gcc  
m68k                 randconfig-r035-20230612   gcc  
m68k                 randconfig-r036-20230612   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips         buildonly-randconfig-r002-20230612   gcc  
mips                 randconfig-r001-20230612   gcc  
mips                 randconfig-r024-20230612   clang
mips                 randconfig-r031-20230612   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r004-20230612   gcc  
openrisc     buildonly-randconfig-r003-20230612   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc              randconfig-r032-20230612   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                randconfig-r012-20230612   gcc  
riscv                randconfig-r034-20230612   clang
riscv                randconfig-r042-20230612   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r015-20230612   gcc  
s390                 randconfig-r021-20230612   gcc  
s390                 randconfig-r025-20230612   gcc  
s390                 randconfig-r044-20230612   gcc  
sh                               allmodconfig   gcc  
sh           buildonly-randconfig-r001-20230612   gcc  
sh                   randconfig-r012-20230612   gcc  
sh                   randconfig-r015-20230612   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r022-20230612   gcc  
sparc                randconfig-r023-20230612   gcc  
sparc                randconfig-r033-20230612   gcc  
sparc64              randconfig-r006-20230612   gcc  
sparc64              randconfig-r013-20230612   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   clang
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r002-20230612   clang
x86_64       buildonly-randconfig-r005-20230612   clang
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230612   clang
x86_64               randconfig-a002-20230612   clang
x86_64               randconfig-a003-20230612   clang
x86_64               randconfig-a004-20230612   clang
x86_64               randconfig-a005-20230612   clang
x86_64               randconfig-a006-20230612   clang
x86_64               randconfig-a011-20230612   gcc  
x86_64               randconfig-a012-20230612   gcc  
x86_64               randconfig-a013-20230612   gcc  
x86_64               randconfig-a014-20230612   gcc  
x86_64               randconfig-a015-20230612   gcc  
x86_64               randconfig-a016-20230612   gcc  
x86_64               randconfig-r026-20230612   gcc  
x86_64               randconfig-r034-20230612   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa       buildonly-randconfig-r005-20230612   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
