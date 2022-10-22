Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D53E16082FE
	for <lists+linux-wireless@lfdr.de>; Sat, 22 Oct 2022 02:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbiJVAx1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 21 Oct 2022 20:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiJVAx0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 21 Oct 2022 20:53:26 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79A582ACBD3
        for <linux-wireless@vger.kernel.org>; Fri, 21 Oct 2022 17:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666400005; x=1697936005;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=imCjon54ZP4y3sIZJgRBB1ufmQHKk2E2GSW2MLqrrZU=;
  b=Lyu49K2JzNC6jnR21RjEXd1YvkDTNtFbk0Xf4TNwEw+MqmSpJ1lzoWCp
   7f3vjc02nbMbvJp9ItRErO1OV0A7fHaV4cMU9uAqFgj+pYjfvEbth5ZGg
   28IqxId36tuqQ1efdJXVsRglUyoHlntkG1F4qCi4Iup6Gig+ArXNgX1ji
   ANRIhpBq1QUT3OQEZ++gkcUa0s3fXHfUL/EDhzUGRgzGBQeaNxltuoEmM
   iPoS/P7dJd0nYauTnzbhJigBfb36myYkVmwiz477jbNd15CFSvSC+jl5k
   zNjB0CEw1HU8JNq/SO2Z7R+X9RwqCvYM9PtgOz443d3zY+gUwoJWzqMhR
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="308823011"
X-IronPort-AV: E=Sophos;i="5.95,203,1661842800"; 
   d="scan'208";a="308823011"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2022 17:53:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10507"; a="630695963"
X-IronPort-AV: E=Sophos;i="5.95,203,1661842800"; 
   d="scan'208";a="630695963"
Received: from lkp-server02.sh.intel.com (HELO b6d29c1a0365) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 21 Oct 2022 17:53:23 -0700
Received: from kbuild by b6d29c1a0365 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1om2lO-00037L-38;
        Sat, 22 Oct 2022 00:53:22 +0000
Date:   Sat, 22 Oct 2022 08:53:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johannes Berg <johannes.berg@intel.com>
Cc:     linux-wireless@vger.kernel.org, Kalle Valo <kvalo@kernel.org>
Subject: [wireless:for-next] BUILD SUCCESS
 69188df5f6e4cecc6b76b958979ba363cd5240e8
Message-ID: <63533efc.mz4UQzhRZr1i9ZY5%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git for-next
branch HEAD: 69188df5f6e4cecc6b76b958979ba363cd5240e8  wifi: mac80211_hwsim: fix debugfs attribute ps with rc table support

elapsed time: 726m

configs tested: 135
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                           x86_64_defconfig
um                             i386_defconfig
arc                                 defconfig
alpha                               defconfig
s390                             allmodconfig
x86_64                          rhel-8.3-func
s390                                defconfig
x86_64                    rhel-8.3-kselftests
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                              defconfig
s390                             allyesconfig
arc                  randconfig-r043-20221019
x86_64                               rhel-8.3
arc                  randconfig-r043-20221020
x86_64                           allyesconfig
s390                 randconfig-r044-20221020
powerpc                           allnoconfig
x86_64                           rhel-8.3-kvm
powerpc                          allmodconfig
m68k                             allmodconfig
riscv                randconfig-r042-20221020
i386                             allyesconfig
i386                                defconfig
arc                              allyesconfig
x86_64                        randconfig-a015
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
sh                               allmodconfig
mips                             allyesconfig
alpha                            allyesconfig
m68k                             allyesconfig
arm                        oxnas_v6_defconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
openrisc                         alldefconfig
powerpc                       holly_defconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arm                        multi_v7_defconfig
sh                           se7721_defconfig
powerpc                         ps3_defconfig
m68k                           virt_defconfig
i386                          randconfig-c001
sparc                       sparc32_defconfig
sh                          sdk7786_defconfig
parisc                           alldefconfig
mips                      fuloong2e_defconfig
arc                           tb10x_defconfig
sh                            titan_defconfig
powerpc                     pq2fads_defconfig
arm                         nhk8815_defconfig
arm                       omap2plus_defconfig
arm                        clps711x_defconfig
powerpc                 linkstation_defconfig
arc                            hsdk_defconfig
openrisc                 simple_smp_defconfig
ia64                          tiger_defconfig
arm                        mvebu_v7_defconfig
mips                    maltaup_xpa_defconfig
arc                              alldefconfig
m68k                          atari_defconfig
powerpc                     tqm8548_defconfig
arm                          lpd270_defconfig
arc                  randconfig-r043-20221018
s390                 randconfig-r044-20221018
riscv                randconfig-r042-20221018
arm                          exynos_defconfig
alpha                             allnoconfig
arc                               allnoconfig
arm                           u8500_defconfig
csky                                defconfig
parisc                generic-64bit_defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
sh                           se7722_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20221019
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
loongarch                           defconfig
loongarch                         allnoconfig
loongarch                        allmodconfig
arc                  randconfig-r043-20221022
s390                 randconfig-r044-20221022
riscv                randconfig-r042-20221022

clang tested configs:
x86_64                        randconfig-a012
hexagon              randconfig-r041-20221020
hexagon              randconfig-r045-20221020
hexagon              randconfig-r045-20221019
hexagon              randconfig-r041-20221019
s390                 randconfig-r044-20221019
riscv                randconfig-r042-20221019
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
powerpc                    gamecube_defconfig
hexagon              randconfig-r045-20221018
hexagon              randconfig-r041-20221018
i386                 randconfig-a013-20221017
i386                 randconfig-a015-20221017
i386                 randconfig-a016-20221017
i386                 randconfig-a011-20221017
i386                 randconfig-a014-20221017
i386                 randconfig-a012-20221017
x86_64                        randconfig-k001
arm                        magician_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
arm                      pxa255-idp_defconfig
mips                          ath79_defconfig
powerpc                      acadia_defconfig
arm                             mxs_defconfig
arm                       netwinder_defconfig
mips                        maltaup_defconfig
powerpc                 mpc8560_ads_defconfig
arm                        vexpress_defconfig
mips                       rbtx49xx_defconfig
arm                           spitz_defconfig
powerpc                   microwatt_defconfig
arm                         orion5x_defconfig
powerpc                      obs600_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
