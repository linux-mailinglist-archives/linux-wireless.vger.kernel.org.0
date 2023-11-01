Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5297DE389
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Nov 2023 16:37:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344282AbjKAOgW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Nov 2023 10:36:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233968AbjKAOgU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Nov 2023 10:36:20 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE39910C
        for <linux-wireless@vger.kernel.org>; Wed,  1 Nov 2023 07:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698849374; x=1730385374;
  h=date:from:to:cc:subject:message-id;
  bh=1GjPP02dVsye5SmfZJBpoxPj0CaGCICt1/1eKxOgjJI=;
  b=XRz7pw9weTKUNDzCcIiOClDxHXVtIRyrutCHJbdFzeu1tE4Frm/rPIrf
   gd6+9dEcgUtW0dNHh+rfd3Sv3rjm9aPSVjhgG+8lQ5nTS4tIdTccS94Ua
   slZiRScbFWqMwg8vGQrNT41ntLRzJhTgqWsRsdXUB0xluMu259bvpE5CS
   bLDhOqDeCsBOn9EMijG1GviSWyIK8mZduUHA1UwP+rvOsNW1Xu1ZtHuav
   5FSIng9Bj6tvw9a9w9Z/rDjuUlRLm5PAeGG3+9kcswzdI3C+yUlZNOJKS
   2WQdzH08ga21i1iyE5rDdkvuM/Dv4Bkv1VQvG6OaxNNlC2fMabTTPb/aQ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="452793625"
X-IronPort-AV: E=Sophos;i="6.03,268,1694761200"; 
   d="scan'208";a="452793625"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2023 07:36:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="831367143"
X-IronPort-AV: E=Sophos;i="6.03,268,1694761200"; 
   d="scan'208";a="831367143"
Received: from lkp-server01.sh.intel.com (HELO 17d9e85e5079) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 01 Nov 2023 07:36:06 -0700
Received: from kbuild by 17d9e85e5079 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qyCKC-0000qM-17;
        Wed, 01 Nov 2023 14:36:04 +0000
Date:   Wed, 01 Nov 2023 22:35:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
Subject: [wireless-next:main] BUILD SUCCESS
 bec95598b24a42adba294994ab7a5d8db417cca5
Message-ID: <202311012226.5tVA6wIa-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: bec95598b24a42adba294994ab7a5d8db417cca5  wifi: remove orphaned rndis_wlan driver

elapsed time: 2634m

configs tested: 200
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
arc                   randconfig-001-20231031   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                         lpc18xx_defconfig   gcc  
arm                        multi_v7_defconfig   gcc  
arm                   randconfig-001-20231031   gcc  
arm                   randconfig-001-20231101   gcc  
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
i386         buildonly-randconfig-001-20231031   gcc  
i386         buildonly-randconfig-001-20231101   gcc  
i386         buildonly-randconfig-002-20231031   gcc  
i386         buildonly-randconfig-002-20231101   gcc  
i386         buildonly-randconfig-003-20231031   gcc  
i386         buildonly-randconfig-003-20231101   gcc  
i386         buildonly-randconfig-004-20231031   gcc  
i386         buildonly-randconfig-004-20231101   gcc  
i386         buildonly-randconfig-005-20231031   gcc  
i386         buildonly-randconfig-005-20231101   gcc  
i386         buildonly-randconfig-006-20231031   gcc  
i386         buildonly-randconfig-006-20231101   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20231031   gcc  
i386                  randconfig-001-20231101   gcc  
i386                  randconfig-002-20231031   gcc  
i386                  randconfig-002-20231101   gcc  
i386                  randconfig-003-20231031   gcc  
i386                  randconfig-003-20231101   gcc  
i386                  randconfig-004-20231031   gcc  
i386                  randconfig-004-20231101   gcc  
i386                  randconfig-005-20231031   gcc  
i386                  randconfig-005-20231101   gcc  
i386                  randconfig-006-20231031   gcc  
i386                  randconfig-006-20231101   gcc  
i386                  randconfig-011-20231031   gcc  
i386                  randconfig-011-20231101   gcc  
i386                  randconfig-012-20231031   gcc  
i386                  randconfig-012-20231101   gcc  
i386                  randconfig-013-20231031   gcc  
i386                  randconfig-013-20231101   gcc  
i386                  randconfig-014-20231031   gcc  
i386                  randconfig-014-20231101   gcc  
i386                  randconfig-015-20231031   gcc  
i386                  randconfig-015-20231101   gcc  
i386                  randconfig-016-20231031   gcc  
i386                  randconfig-016-20231101   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20231031   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                       m5249evb_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                         cobalt_defconfig   gcc  
mips                         db1xxx_defconfig   gcc  
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
powerpc                    klondike_defconfig   gcc  
powerpc                   lite5200b_defconfig   clang
powerpc               mpc834x_itxgp_defconfig   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20231031   gcc  
riscv                 randconfig-001-20231101   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20231031   gcc  
s390                  randconfig-001-20231101   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                          polaris_defconfig   gcc  
sh                   secureedge5410_defconfig   gcc  
sh                             sh03_defconfig   gcc  
sh                           sh2007_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                 randconfig-001-20231101   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           alldefconfig   gcc  
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-001-20231031   gcc  
x86_64       buildonly-randconfig-001-20231101   gcc  
x86_64       buildonly-randconfig-002-20231031   gcc  
x86_64       buildonly-randconfig-002-20231101   gcc  
x86_64       buildonly-randconfig-003-20231031   gcc  
x86_64       buildonly-randconfig-003-20231101   gcc  
x86_64       buildonly-randconfig-004-20231031   gcc  
x86_64       buildonly-randconfig-004-20231101   gcc  
x86_64       buildonly-randconfig-005-20231031   gcc  
x86_64       buildonly-randconfig-005-20231101   gcc  
x86_64       buildonly-randconfig-006-20231031   gcc  
x86_64       buildonly-randconfig-006-20231101   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                randconfig-001-20231031   gcc  
x86_64                randconfig-001-20231101   gcc  
x86_64                randconfig-002-20231031   gcc  
x86_64                randconfig-002-20231101   gcc  
x86_64                randconfig-003-20231031   gcc  
x86_64                randconfig-003-20231101   gcc  
x86_64                randconfig-004-20231031   gcc  
x86_64                randconfig-004-20231101   gcc  
x86_64                randconfig-005-20231031   gcc  
x86_64                randconfig-005-20231101   gcc  
x86_64                randconfig-006-20231031   gcc  
x86_64                randconfig-006-20231101   gcc  
x86_64                randconfig-011-20231031   gcc  
x86_64                randconfig-011-20231101   gcc  
x86_64                randconfig-012-20231031   gcc  
x86_64                randconfig-012-20231101   gcc  
x86_64                randconfig-013-20231031   gcc  
x86_64                randconfig-013-20231101   gcc  
x86_64                randconfig-014-20231031   gcc  
x86_64                randconfig-014-20231101   gcc  
x86_64                randconfig-015-20231031   gcc  
x86_64                randconfig-015-20231101   gcc  
x86_64                randconfig-016-20231031   gcc  
x86_64                randconfig-016-20231101   gcc  
x86_64                randconfig-071-20231031   gcc  
x86_64                randconfig-071-20231101   gcc  
x86_64                randconfig-072-20231031   gcc  
x86_64                randconfig-072-20231101   gcc  
x86_64                randconfig-073-20231031   gcc  
x86_64                randconfig-073-20231101   gcc  
x86_64                randconfig-074-20231031   gcc  
x86_64                randconfig-074-20231101   gcc  
x86_64                randconfig-075-20231031   gcc  
x86_64                randconfig-075-20231101   gcc  
x86_64                randconfig-076-20231031   gcc  
x86_64                randconfig-076-20231101   gcc  
x86_64                           rhel-8.3-bpf   gcc  
x86_64                          rhel-8.3-func   gcc  
x86_64                    rhel-8.3-kselftests   gcc  
x86_64                         rhel-8.3-kunit   gcc  
x86_64                           rhel-8.3-ltp   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
