Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E50E37ACE29
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Sep 2023 04:34:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231560AbjIYCeb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 24 Sep 2023 22:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjIYCea (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 24 Sep 2023 22:34:30 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CC29D3
        for <linux-wireless@vger.kernel.org>; Sun, 24 Sep 2023 19:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695609264; x=1727145264;
  h=date:from:to:cc:subject:message-id;
  bh=syrWkusV+NZagWSj8OeRTe9WgpTOZM9uAn6iEe4Kz2s=;
  b=g1cEsiqpEc4+4jIOE0MmximR2wjAV0c5CBIrQj5AtFuS0hubyaNarIzr
   nUy4g9gCP70KDVnIzsH5oQB5708zfeTmXkMJW4XsmBU4wPG+MlzvdBbFJ
   pzrKlEUhIfgHW4pxudLEt3moFn/TSE7fZZ3x2UN/G6CdW0NhF+lOKc4jS
   LlkxxvlDxOjD2+FBst04t1YmcxqEQ90Cz4+u6bs+FlX7sS2aF2jZh210h
   7eyzN1qPKht46BI3x5qbJO4btgu7slNtEy5vFkIDHtbtjI3UB6hMUNCWq
   zCudZ81Ov6AkzALpcAmwGl6NIVt2dSzI2jdUBCUPIa5pjygyNusPaAyXu
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="361405349"
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; 
   d="scan'208";a="361405349"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2023 19:34:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="871899289"
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; 
   d="scan'208";a="871899289"
Received: from lkp-server02.sh.intel.com (HELO 32c80313467c) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 24 Sep 2023 19:34:19 -0700
Received: from kbuild by 32c80313467c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qkbQQ-0000sx-03;
        Mon, 25 Sep 2023 02:34:18 +0000
Date:   Mon, 25 Sep 2023 10:33:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
Subject: [wireless:for-next] BUILD SUCCESS
 684e45e120b82deccaf8b85633905304a3bbf56d
Message-ID: <202309251017.xdAYKjWQ-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git for-next
branch HEAD: 684e45e120b82deccaf8b85633905304a3bbf56d  wifi: mt76: mt76x02: fix MT76x0 external LNA gain handling

elapsed time: 4020m

configs tested: 283
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
arc                     nsimosci_hs_defconfig   gcc  
arc                   randconfig-001-20230922   gcc  
arc                   randconfig-001-20230923   gcc  
arc                        vdk_hs38_defconfig   gcc  
arc                    vdk_hs38_smp_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                       aspeed_g4_defconfig   clang
arm                                 defconfig   gcc  
arm                        keystone_defconfig   gcc  
arm                          pxa910_defconfig   gcc  
arm                   randconfig-001-20230922   gcc  
arm                   randconfig-001-20230923   gcc  
arm                   randconfig-001-20230924   gcc  
arm                   randconfig-001-20230925   gcc  
arm                         s3c6400_defconfig   gcc  
arm                           u8500_defconfig   gcc  
arm                         vf610m4_defconfig   gcc  
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
i386         buildonly-randconfig-001-20230922   gcc  
i386         buildonly-randconfig-001-20230923   gcc  
i386         buildonly-randconfig-001-20230924   gcc  
i386         buildonly-randconfig-002-20230922   gcc  
i386         buildonly-randconfig-002-20230923   gcc  
i386         buildonly-randconfig-002-20230924   gcc  
i386         buildonly-randconfig-003-20230922   gcc  
i386         buildonly-randconfig-003-20230923   gcc  
i386         buildonly-randconfig-003-20230924   gcc  
i386         buildonly-randconfig-004-20230922   gcc  
i386         buildonly-randconfig-004-20230924   gcc  
i386         buildonly-randconfig-005-20230922   gcc  
i386         buildonly-randconfig-005-20230923   gcc  
i386         buildonly-randconfig-005-20230924   gcc  
i386         buildonly-randconfig-006-20230922   gcc  
i386         buildonly-randconfig-006-20230924   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20230922   gcc  
i386                  randconfig-001-20230923   gcc  
i386                  randconfig-001-20230924   gcc  
i386                  randconfig-001-20230925   gcc  
i386                  randconfig-002-20230922   gcc  
i386                  randconfig-002-20230924   gcc  
i386                  randconfig-002-20230925   gcc  
i386                  randconfig-003-20230922   gcc  
i386                  randconfig-003-20230924   gcc  
i386                  randconfig-003-20230925   gcc  
i386                  randconfig-004-20230922   gcc  
i386                  randconfig-004-20230924   gcc  
i386                  randconfig-004-20230925   gcc  
i386                  randconfig-005-20230922   gcc  
i386                  randconfig-005-20230923   gcc  
i386                  randconfig-005-20230924   gcc  
i386                  randconfig-005-20230925   gcc  
i386                  randconfig-006-20230922   gcc  
i386                  randconfig-006-20230923   gcc  
i386                  randconfig-006-20230924   gcc  
i386                  randconfig-006-20230925   gcc  
i386                  randconfig-011-20230922   gcc  
i386                  randconfig-011-20230923   gcc  
i386                  randconfig-011-20230924   gcc  
i386                  randconfig-011-20230925   gcc  
i386                  randconfig-012-20230922   gcc  
i386                  randconfig-012-20230924   gcc  
i386                  randconfig-012-20230925   gcc  
i386                  randconfig-013-20230922   gcc  
i386                  randconfig-013-20230924   gcc  
i386                  randconfig-013-20230925   gcc  
i386                  randconfig-014-20230922   gcc  
i386                  randconfig-014-20230923   gcc  
i386                  randconfig-014-20230924   gcc  
i386                  randconfig-014-20230925   gcc  
i386                  randconfig-015-20230922   gcc  
i386                  randconfig-015-20230923   gcc  
i386                  randconfig-015-20230924   gcc  
i386                  randconfig-015-20230925   gcc  
i386                  randconfig-016-20230922   gcc  
i386                  randconfig-016-20230923   gcc  
i386                  randconfig-016-20230924   gcc  
i386                  randconfig-016-20230925   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20230922   gcc  
loongarch             randconfig-001-20230923   gcc  
loongarch             randconfig-001-20230924   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                        stmark2_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                       bmips_be_defconfig   gcc  
mips                           ip32_defconfig   gcc  
mips                          rb532_defconfig   gcc  
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
powerpc                          allmodconfig   clang
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   gcc  
powerpc                  iss476-smp_defconfig   gcc  
powerpc                       maple_defconfig   gcc  
powerpc                     mpc83xx_defconfig   gcc  
powerpc                      pmac32_defconfig   clang
powerpc                     stx_gp3_defconfig   gcc  
powerpc                     tqm8548_defconfig   gcc  
powerpc                         wii_defconfig   gcc  
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                    nommu_k210_defconfig   gcc  
riscv             nommu_k210_sdcard_defconfig   gcc  
riscv                 randconfig-001-20230922   gcc  
riscv                 randconfig-001-20230924   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20230922   gcc  
s390                  randconfig-001-20230923   gcc  
s390                  randconfig-001-20230924   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                         apsh4a3a_defconfig   gcc  
sh                                  defconfig   gcc  
sh                          rsk7201_defconfig   gcc  
sh                      rts7751r2d1_defconfig   gcc  
sh                           se7206_defconfig   gcc  
sh                        sh7757lcr_defconfig   gcc  
sh                  sh7785lcr_32bit_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                 randconfig-001-20230922   gcc  
sparc                 randconfig-001-20230923   gcc  
sparc                 randconfig-001-20230924   gcc  
sparc                 randconfig-001-20230925   gcc  
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
x86_64       buildonly-randconfig-001-20230922   gcc  
x86_64       buildonly-randconfig-001-20230923   gcc  
x86_64       buildonly-randconfig-001-20230924   gcc  
x86_64       buildonly-randconfig-001-20230925   gcc  
x86_64       buildonly-randconfig-002-20230922   gcc  
x86_64       buildonly-randconfig-002-20230924   gcc  
x86_64       buildonly-randconfig-002-20230925   gcc  
x86_64       buildonly-randconfig-003-20230922   gcc  
x86_64       buildonly-randconfig-003-20230923   gcc  
x86_64       buildonly-randconfig-003-20230924   gcc  
x86_64       buildonly-randconfig-003-20230925   gcc  
x86_64       buildonly-randconfig-004-20230922   gcc  
x86_64       buildonly-randconfig-004-20230924   gcc  
x86_64       buildonly-randconfig-004-20230925   gcc  
x86_64       buildonly-randconfig-005-20230922   gcc  
x86_64       buildonly-randconfig-005-20230923   gcc  
x86_64       buildonly-randconfig-005-20230924   gcc  
x86_64       buildonly-randconfig-005-20230925   gcc  
x86_64       buildonly-randconfig-006-20230922   gcc  
x86_64       buildonly-randconfig-006-20230923   gcc  
x86_64       buildonly-randconfig-006-20230924   gcc  
x86_64       buildonly-randconfig-006-20230925   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                randconfig-001-20230922   gcc  
x86_64                randconfig-001-20230924   gcc  
x86_64                randconfig-001-20230925   gcc  
x86_64                randconfig-002-20230922   gcc  
x86_64                randconfig-002-20230924   gcc  
x86_64                randconfig-002-20230925   gcc  
x86_64                randconfig-003-20230922   gcc  
x86_64                randconfig-003-20230924   gcc  
x86_64                randconfig-003-20230925   gcc  
x86_64                randconfig-004-20230922   gcc  
x86_64                randconfig-004-20230924   gcc  
x86_64                randconfig-004-20230925   gcc  
x86_64                randconfig-005-20230922   gcc  
x86_64                randconfig-005-20230924   gcc  
x86_64                randconfig-005-20230925   gcc  
x86_64                randconfig-006-20230922   gcc  
x86_64                randconfig-006-20230924   gcc  
x86_64                randconfig-006-20230925   gcc  
x86_64                randconfig-011-20230923   gcc  
x86_64                randconfig-011-20230924   gcc  
x86_64                randconfig-011-20230925   gcc  
x86_64                randconfig-012-20230923   gcc  
x86_64                randconfig-012-20230924   gcc  
x86_64                randconfig-012-20230925   gcc  
x86_64                randconfig-013-20230923   gcc  
x86_64                randconfig-013-20230924   gcc  
x86_64                randconfig-013-20230925   gcc  
x86_64                randconfig-014-20230923   gcc  
x86_64                randconfig-014-20230924   gcc  
x86_64                randconfig-014-20230925   gcc  
x86_64                randconfig-015-20230923   gcc  
x86_64                randconfig-015-20230924   gcc  
x86_64                randconfig-015-20230925   gcc  
x86_64                randconfig-016-20230923   gcc  
x86_64                randconfig-016-20230924   gcc  
x86_64                randconfig-016-20230925   gcc  
x86_64                randconfig-071-20230922   gcc  
x86_64                randconfig-071-20230923   gcc  
x86_64                randconfig-071-20230924   gcc  
x86_64                randconfig-071-20230925   gcc  
x86_64                randconfig-072-20230922   gcc  
x86_64                randconfig-072-20230923   gcc  
x86_64                randconfig-072-20230924   gcc  
x86_64                randconfig-072-20230925   gcc  
x86_64                randconfig-073-20230922   gcc  
x86_64                randconfig-073-20230923   gcc  
x86_64                randconfig-073-20230924   gcc  
x86_64                randconfig-073-20230925   gcc  
x86_64                randconfig-074-20230922   gcc  
x86_64                randconfig-074-20230923   gcc  
x86_64                randconfig-074-20230924   gcc  
x86_64                randconfig-074-20230925   gcc  
x86_64                randconfig-075-20230922   gcc  
x86_64                randconfig-075-20230923   gcc  
x86_64                randconfig-075-20230924   gcc  
x86_64                randconfig-075-20230925   gcc  
x86_64                randconfig-076-20230922   gcc  
x86_64                randconfig-076-20230923   gcc  
x86_64                randconfig-076-20230924   gcc  
x86_64                randconfig-076-20230925   gcc  
x86_64                           rhel-8.3-bpf   gcc  
x86_64                          rhel-8.3-func   gcc  
x86_64                    rhel-8.3-kselftests   gcc  
x86_64                         rhel-8.3-kunit   gcc  
x86_64                           rhel-8.3-ltp   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                  nommu_kc705_defconfig   gcc  
xtensa                    smp_lx200_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
