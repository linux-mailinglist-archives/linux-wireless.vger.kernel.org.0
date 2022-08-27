Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5A8B5A32F6
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Aug 2022 02:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238383AbiH0AK3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 26 Aug 2022 20:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231769AbiH0AK2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 26 Aug 2022 20:10:28 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1298ABD0B4
        for <linux-wireless@vger.kernel.org>; Fri, 26 Aug 2022 17:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661559028; x=1693095028;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=KJRmRt8odvgV3fqVmbFIKqWeSjW5zNy129b+KpWeSNQ=;
  b=Yw/6h4ypUKWxlRXOG4UFg5gJuI/6vlFuBZMHqYxlvwl35/bbwQ4tkRc5
   f7l846SRF1R6eyRhOsSZWL9i57v7ZpEbroYzZyVh8VaFV87uUeFCIltjD
   HxgPY1Q3ertGWtCDDjE+214koyhocmYzakjjtC+jbfIlW/+I0SjGxXqS/
   oM4TMQx7qpE3ypp20UQLBqnWISNy6qIVRSuBlBoFBD1E/rYareGWsAdKV
   z4xU/7/7QUZwr2eUNyHBwKS8cjcy8WYtNrNQVWrWeH0zB5IkzJ2CumDnd
   q2/g4HDycSnKSP98UQdOt05Rx5EduhB9VuLJSvct5L++zpCNFHVt9Uh75
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10451"; a="281586338"
X-IronPort-AV: E=Sophos;i="5.93,266,1654585200"; 
   d="scan'208";a="281586338"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2022 17:10:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,266,1654585200"; 
   d="scan'208";a="938930899"
Received: from lkp-server01.sh.intel.com (HELO 71b0d3b5b1bc) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 26 Aug 2022 17:10:26 -0700
Received: from kbuild by 71b0d3b5b1bc with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oRjP7-0000hX-1Y;
        Sat, 27 Aug 2022 00:10:25 +0000
Date:   Sat, 27 Aug 2022 08:09:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johannes Berg <johannes.berg@intel.com>
Cc:     linux-wireless@vger.kernel.org, Kalle Valo <kvalo@kernel.org>
Subject: [wireless:for-next] BUILD SUCCESS
 fa3fbe64037839f448dc569212bafc5a495d8219
Message-ID: <630960c2.OyZeZO7+Z9n0ctXh%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
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
branch HEAD: fa3fbe64037839f448dc569212bafc5a495d8219  wifi: mt76: mt7921e: fix crash in chip reset fail

elapsed time: 722m

configs tested: 129
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
alpha                               defconfig
i386                                defconfig
loongarch                         allnoconfig
um                             i386_defconfig
i386                          randconfig-a016
arc                                 defconfig
x86_64                        randconfig-a006
um                           x86_64_defconfig
loongarch                           defconfig
x86_64                              defconfig
alpha                            allyesconfig
x86_64                               rhel-8.3
arc                              allyesconfig
sh                               allmodconfig
i386                          randconfig-a014
x86_64                        randconfig-a011
x86_64                        randconfig-a002
i386                          randconfig-a005
x86_64                        randconfig-a015
x86_64                           allyesconfig
m68k                             allyesconfig
arm                                 defconfig
i386                          randconfig-a012
m68k                             allmodconfig
s390                             allmodconfig
mips                             allyesconfig
i386                          randconfig-a003
x86_64                        randconfig-a013
powerpc                           allnoconfig
s390                                defconfig
i386                          randconfig-a001
i386                             allyesconfig
x86_64                        randconfig-a004
x86_64                          rhel-8.3-func
arc                  randconfig-r043-20220824
powerpc                          allmodconfig
arc                  randconfig-r043-20220823
x86_64                         rhel-8.3-kunit
x86_64                           rhel-8.3-kvm
x86_64                    rhel-8.3-kselftests
riscv                randconfig-r042-20220824
x86_64                           rhel-8.3-syz
s390                 randconfig-r044-20220826
arc                  randconfig-r043-20220825
arm                              allyesconfig
arm64                            allyesconfig
s390                 randconfig-r044-20220824
s390                             allyesconfig
riscv                randconfig-r042-20220826
ia64                             allmodconfig
arc                  randconfig-r043-20220826
powerpc                          allyesconfig
riscv                               defconfig
riscv                            allmodconfig
riscv                            allyesconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
nios2                            allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
sparc                               defconfig
xtensa                           allyesconfig
csky                                defconfig
sparc                            allyesconfig
x86_64                                  kexec
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
s390                       zfcpdump_defconfig
sh                ecovec24-romimage_defconfig
powerpc                 mpc8540_ads_defconfig
arm                           sama5_defconfig
sh                        apsh4ad0a_defconfig
openrisc                    or1ksim_defconfig
i386                          randconfig-c001
sh                          landisk_defconfig
arm64                               defconfig
arm                              allmodconfig
m68k                                defconfig
ia64                                defconfig
mips                             allmodconfig
sh                          rsk7203_defconfig
parisc                generic-32bit_defconfig
arm                            xcep_defconfig
openrisc                  or1klitex_defconfig
ia64                            zx1_defconfig
sh                           se7343_defconfig
m68k                          multi_defconfig
sh                           se7780_defconfig

clang tested configs:
x86_64                        randconfig-a005
x86_64                        randconfig-a012
i386                          randconfig-a011
i386                          randconfig-a006
i386                          randconfig-a013
x86_64                        randconfig-a014
x86_64                        randconfig-a001
x86_64                        randconfig-a016
i386                          randconfig-a015
x86_64                        randconfig-a003
hexagon              randconfig-r041-20220823
i386                          randconfig-a002
hexagon              randconfig-r045-20220825
hexagon              randconfig-r045-20220823
hexagon              randconfig-r041-20220824
i386                          randconfig-a004
hexagon              randconfig-r041-20220825
hexagon              randconfig-r045-20220824
s390                 randconfig-r044-20220823
hexagon              randconfig-r045-20220826
riscv                randconfig-r042-20220823
hexagon              randconfig-r041-20220826
riscv                randconfig-r042-20220825
s390                 randconfig-r044-20220825
hexagon              randconfig-r045-20220827
riscv                randconfig-r042-20220827
hexagon              randconfig-r041-20220827
s390                 randconfig-r044-20220827
x86_64                        randconfig-k001
arm                                 defconfig
arm                         bcm2835_defconfig
powerpc                  mpc885_ads_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
