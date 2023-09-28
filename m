Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE9A17B1A9B
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Sep 2023 13:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232068AbjI1LTw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 Sep 2023 07:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232053AbjI1LTO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 Sep 2023 07:19:14 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20A2F3A84
        for <linux-wireless@vger.kernel.org>; Thu, 28 Sep 2023 04:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695899162; x=1727435162;
  h=date:from:to:cc:subject:message-id;
  bh=z2vmj7NGP51lkyqPDLjBImCw5PdTLiZQwPooshbyxBI=;
  b=afHgItBbtqHRUrwZc7OjYmmSX7JCQwu9l1CbDuXQS7s7/N6obABGQIt4
   qCBRQCG5SkoKyvB5GhE9WHtGizczXKnsxCnaOUxkGzaRpL1OmaF+7UqgV
   EvEInvzmH/2pRVFJjOsdNYlCwM1XOg2CvMaMK0tEszPvCJjFSd/d2Jd8B
   VStUDrr9kGxuRFtJF39I1371szYyz6sdNgERv0uZ1KcQgh+epf7DMIS+k
   826agPCt5Y9xNx4Ph+FXVGsOql1QeMuiqjcjhCkG2H9K2Spgf1aJpfyZm
   YToMrtsXNiMlSUYFl7w3xinnYf3ddnvxrIgj0DqMz8SC+e5vCRtAPdKds
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="361405227"
X-IronPort-AV: E=Sophos;i="6.03,183,1694761200"; 
   d="scan'208";a="361405227"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 04:05:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10846"; a="1080533561"
X-IronPort-AV: E=Sophos;i="6.03,183,1694761200"; 
   d="scan'208";a="1080533561"
Received: from lkp-server02.sh.intel.com (HELO c3b01524d57c) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 28 Sep 2023 04:05:58 -0700
Received: from kbuild by c3b01524d57c with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qloqB-0001Nn-2z;
        Thu, 28 Sep 2023 11:05:55 +0000
Date:   Thu, 28 Sep 2023 19:05:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johannes Berg <johannes.berg@intel.com>
Cc:     Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org
Subject: [wireless:for-next] BUILD SUCCESS
 22061bfc57fe08c77141dc876b4af75603c4d61d
Message-ID: <202309281903.Gc2mvpfK-lkp@intel.com>
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
branch HEAD: 22061bfc57fe08c77141dc876b4af75603c4d61d  wifi: iwlwifi: mvm: Fix incorrect usage of scan API

elapsed time: 1452m

configs tested: 173
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
arc                   randconfig-001-20230928   gcc  
arc                    vdk_hs38_smp_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   gcc  
arm                              allyesconfig   gcc  
arm                                 defconfig   gcc  
arm                       imx_v6_v7_defconfig   gcc  
arm                         lpc32xx_defconfig   clang
arm                        neponset_defconfig   clang
arm                   randconfig-001-20230928   gcc  
arm                        shmobile_defconfig   gcc  
arm                        spear3xx_defconfig   clang
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
i386         buildonly-randconfig-001-20230928   gcc  
i386         buildonly-randconfig-002-20230928   gcc  
i386         buildonly-randconfig-003-20230928   gcc  
i386         buildonly-randconfig-004-20230928   gcc  
i386         buildonly-randconfig-005-20230928   gcc  
i386         buildonly-randconfig-006-20230928   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                  randconfig-001-20230927   gcc  
i386                  randconfig-001-20230928   gcc  
i386                  randconfig-002-20230927   gcc  
i386                  randconfig-002-20230928   gcc  
i386                  randconfig-003-20230927   gcc  
i386                  randconfig-003-20230928   gcc  
i386                  randconfig-004-20230927   gcc  
i386                  randconfig-004-20230928   gcc  
i386                  randconfig-005-20230927   gcc  
i386                  randconfig-005-20230928   gcc  
i386                  randconfig-006-20230927   gcc  
i386                  randconfig-006-20230928   gcc  
i386                  randconfig-011-20230927   gcc  
i386                  randconfig-011-20230928   gcc  
i386                  randconfig-012-20230927   gcc  
i386                  randconfig-012-20230928   gcc  
i386                  randconfig-013-20230927   gcc  
i386                  randconfig-013-20230928   gcc  
i386                  randconfig-014-20230927   gcc  
i386                  randconfig-014-20230928   gcc  
i386                  randconfig-015-20230927   gcc  
i386                  randconfig-015-20230928   gcc  
i386                  randconfig-016-20230927   gcc  
i386                  randconfig-016-20230928   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20230927   gcc  
loongarch             randconfig-001-20230928   gcc  
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
mips                           ip28_defconfig   clang
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
powerpc                      ppc64e_defconfig   clang
powerpc                    sam440ep_defconfig   gcc  
powerpc                    socrates_defconfig   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv                               defconfig   gcc  
riscv                 randconfig-001-20230927   gcc  
riscv                 randconfig-001-20230928   gcc  
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                                defconfig   gcc  
s390                  randconfig-001-20230927   gcc  
s390                  randconfig-001-20230928   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                 randconfig-001-20230927   gcc  
sparc                 randconfig-001-20230928   gcc  
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
x86_64       buildonly-randconfig-001-20230927   gcc  
x86_64       buildonly-randconfig-001-20230928   gcc  
x86_64       buildonly-randconfig-002-20230927   gcc  
x86_64       buildonly-randconfig-002-20230928   gcc  
x86_64       buildonly-randconfig-003-20230927   gcc  
x86_64       buildonly-randconfig-003-20230928   gcc  
x86_64       buildonly-randconfig-004-20230927   gcc  
x86_64       buildonly-randconfig-004-20230928   gcc  
x86_64       buildonly-randconfig-005-20230927   gcc  
x86_64       buildonly-randconfig-005-20230928   gcc  
x86_64       buildonly-randconfig-006-20230927   gcc  
x86_64       buildonly-randconfig-006-20230928   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64                randconfig-001-20230928   gcc  
x86_64                randconfig-002-20230928   gcc  
x86_64                randconfig-003-20230928   gcc  
x86_64                randconfig-004-20230928   gcc  
x86_64                randconfig-005-20230928   gcc  
x86_64                randconfig-006-20230928   gcc  
x86_64                randconfig-011-20230928   gcc  
x86_64                randconfig-012-20230928   gcc  
x86_64                randconfig-013-20230928   gcc  
x86_64                randconfig-014-20230928   gcc  
x86_64                randconfig-015-20230928   gcc  
x86_64                randconfig-016-20230928   gcc  
x86_64                randconfig-071-20230928   gcc  
x86_64                randconfig-072-20230928   gcc  
x86_64                randconfig-073-20230928   gcc  
x86_64                randconfig-074-20230928   gcc  
x86_64                randconfig-075-20230928   gcc  
x86_64                randconfig-076-20230928   gcc  
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
