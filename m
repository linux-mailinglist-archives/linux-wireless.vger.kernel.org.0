Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 213017BC9E3
	for <lists+linux-wireless@lfdr.de>; Sat,  7 Oct 2023 23:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344169AbjJGVBf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 7 Oct 2023 17:01:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344165AbjJGVBe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 7 Oct 2023 17:01:34 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3792D95
        for <linux-wireless@vger.kernel.org>; Sat,  7 Oct 2023 14:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696712492; x=1728248492;
  h=date:from:to:cc:subject:message-id;
  bh=Fxcsn1O4roedS6tMhnsXj+h4yas9K1Ei6Op3/YhPOoI=;
  b=ZOdE/FquNAbpgpBOqWgi0M2nNY9xzCYfyqtgV4Ef8oCrj30Gz/MDw+S2
   E+bi8+g/lUX6K0WVhtNBsdyQdOPjLtvFe/ii714NdmixCBaP9RvO4HXHr
   OdAemnmbleYvSQq7zXKmnJGTtx1Yr6tYH8B6GGdW9SQgQ6hdgDIW/noTC
   zgYCZ/MJ2a9gH8tIwxmd4xGfQDkZX492dByQP4Z0fUrepMxlSE0e3vV2Q
   HrGilLqBufGVKwL4elnDYXM6S4SiXG4X4851rgIiGvxYdeD9TmPOcYTlh
   IbGJEDr3ckSrSMY2Y9uPQWvzY7P9q/uPMUYSWuRqYC2B0rS9kIlHEZzRs
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10856"; a="450456995"
X-IronPort-AV: E=Sophos;i="6.03,206,1694761200"; 
   d="scan'208";a="450456995"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2023 14:01:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10856"; a="729236416"
X-IronPort-AV: E=Sophos;i="6.03,206,1694761200"; 
   d="scan'208";a="729236416"
Received: from lkp-server01.sh.intel.com (HELO 8a3a91ad4240) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 07 Oct 2023 14:01:30 -0700
Received: from kbuild by 8a3a91ad4240 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qpEQS-0004mD-04;
        Sat, 07 Oct 2023 21:01:28 +0000
Date:   Sun, 08 Oct 2023 05:00:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org
Subject: [wireless-next:main] BUILD SUCCESS
 48533eca606efcf63ef4080ded5618e0b17ee3d7
Message-ID: <202310080530.QlaArLPh-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: 48533eca606efcf63ef4080ded5618e0b17ee3d7  net: sock_dequeue_err_skb() optimization

elapsed time: 1217m

configs tested: 156
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
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                          collie_defconfig   clang
arm                                 defconfig   gcc  
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
i386         buildonly-randconfig-002-20231007   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20231007   gcc  
i386                  randconfig-002-20231007   gcc  
i386                  randconfig-003-20231007   gcc  
i386                  randconfig-004-20231007   gcc  
i386                  randconfig-005-20231007   gcc  
i386                  randconfig-011-20231007   gcc  
i386                  randconfig-011-20231008   gcc  
i386                  randconfig-012-20231007   gcc  
i386                  randconfig-012-20231008   gcc  
i386                  randconfig-013-20231007   gcc  
i386                  randconfig-014-20231007   gcc  
i386                  randconfig-015-20231007   gcc  
i386                  randconfig-016-20231007   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20231007   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                            mac_defconfig   gcc  
m68k                          sun3x_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                  decstation_64_defconfig   gcc  
mips                  maltasmvp_eva_defconfig   gcc  
mips                        maltaup_defconfig   clang
mips                         rt305x_defconfig   gcc  
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
powerpc                      katmai_defconfig   clang
powerpc                   lite5200b_defconfig   clang
powerpc                      mgcoge_defconfig   gcc  
powerpc                      ppc64e_defconfig   clang
powerpc                      ppc6xx_defconfig   gcc  
powerpc                      walnut_defconfig   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20231007   gcc  
riscv                 randconfig-001-20231008   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20231007   gcc  
s390                  randconfig-001-20231008   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                        edosk7705_defconfig   gcc  
sh                           se7705_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                 randconfig-001-20231007   gcc  
sparc                 randconfig-001-20231008   gcc  
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
x86_64       buildonly-randconfig-001-20231007   gcc  
x86_64       buildonly-randconfig-002-20231007   gcc  
x86_64       buildonly-randconfig-003-20231007   gcc  
x86_64       buildonly-randconfig-004-20231007   gcc  
x86_64       buildonly-randconfig-005-20231007   gcc  
x86_64       buildonly-randconfig-006-20231007   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20231007   gcc  
x86_64                randconfig-002-20231007   gcc  
x86_64                randconfig-003-20231007   gcc  
x86_64                randconfig-004-20231007   gcc  
x86_64                randconfig-011-20231007   gcc  
x86_64                randconfig-011-20231008   gcc  
x86_64                randconfig-012-20231007   gcc  
x86_64                randconfig-012-20231008   gcc  
x86_64                randconfig-013-20231007   gcc  
x86_64                randconfig-013-20231008   gcc  
x86_64                randconfig-014-20231007   gcc  
x86_64                randconfig-014-20231008   gcc  
x86_64                randconfig-015-20231007   gcc  
x86_64                randconfig-015-20231008   gcc  
x86_64                randconfig-016-20231007   gcc  
x86_64                randconfig-016-20231008   gcc  
x86_64                randconfig-071-20231007   gcc  
x86_64                randconfig-071-20231008   gcc  
x86_64                randconfig-072-20231007   gcc  
x86_64                randconfig-072-20231008   gcc  
x86_64                randconfig-073-20231007   gcc  
x86_64                randconfig-073-20231008   gcc  
x86_64                randconfig-074-20231007   gcc  
x86_64                randconfig-074-20231008   gcc  
x86_64                randconfig-075-20231007   gcc  
x86_64                randconfig-075-20231008   gcc  
x86_64                randconfig-076-20231007   gcc  
x86_64                randconfig-076-20231008   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
