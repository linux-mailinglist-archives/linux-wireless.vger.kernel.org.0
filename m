Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70D754DBEA7
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Mar 2022 06:47:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbiCQFs1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Mar 2022 01:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiCQFs0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Mar 2022 01:48:26 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A93B4265E92
        for <linux-wireless@vger.kernel.org>; Wed, 16 Mar 2022 22:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647494318; x=1679030318;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=v1KTNNbRslWYFq/D/UOArzs5E5HTOmMjPNugkDvbu9o=;
  b=Y7Qe5gM2GGNy6mI1rGcfeVzBpXapwoGldJf4FVq8lC+dBcibOAX1sTWd
   v4vYM3BZipc1aY8On7v/ouNZEUXjxEvrqtIoMFVXt/k5wr4Z3jD6ZnMxq
   DKZx9GmZrMrWD09si1k4sMiQIIkkrhk2ERakvpQxSZ2/Gu8uAyt5oR8LW
   wLGz0oWscGOCazD10c+ij9RAEwJfZKu6ZxTFgF0ueUvs5aLbYsTPodBMn
   1kf5S6mb0IYbZdMVT3ks9im7SL4xa5TsZd26LEvaeSXncAiDXVnSw0r8s
   IiTDzVDOD2cIPGfw9BkM/f5Y6sGrnPtRTm0zNWAAupbayQc7uI16oFZWK
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10288"; a="281572697"
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="281572697"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 22:18:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="516626137"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 16 Mar 2022 22:18:36 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nUiWx-000DJQ-MY; Thu, 17 Mar 2022 05:18:35 +0000
Date:   Thu, 17 Mar 2022 13:18:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <quic_kvalo@quicinc.com>
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>
Subject: [wireless:main] BUILD SUCCESS
 45b4eb7ee6aa1a55a50831b328aa5f46ac3a7187
Message-ID: <6232c494.aRU6aiBTnAsq3jwL%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git main
branch HEAD: 45b4eb7ee6aa1a55a50831b328aa5f46ac3a7187  Revert "ath10k: drop beacon and probe response which leak from other channel"

elapsed time: 725m

configs tested: 191
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
i386                          randconfig-c001
i386                 randconfig-c001-20220314
powerpc                      tqm8xx_defconfig
m68k                         apollo_defconfig
sh                        edosk7760_defconfig
mips                       bmips_be_defconfig
sh                         ecovec24_defconfig
arm                        oxnas_v6_defconfig
mips                           ci20_defconfig
sh                           sh2007_defconfig
powerpc                  storcenter_defconfig
alpha                            alldefconfig
ia64                            zx1_defconfig
arc                     nsimosci_hs_defconfig
h8300                       h8s-sim_defconfig
sh                               alldefconfig
powerpc                      arches_defconfig
sh                           se7343_defconfig
powerpc                     stx_gp3_defconfig
sh                         ap325rxa_defconfig
arm                           h3600_defconfig
arm                            lart_defconfig
powerpc                         wii_defconfig
h8300                            alldefconfig
arm                         nhk8815_defconfig
powerpc                     pq2fads_defconfig
sh                          rsk7264_defconfig
sh                             sh03_defconfig
powerpc                       eiger_defconfig
ia64                         bigsur_defconfig
h8300                            allyesconfig
um                           x86_64_defconfig
powerpc                     rainier_defconfig
powerpc                     ep8248e_defconfig
parisc                generic-64bit_defconfig
xtensa                           alldefconfig
sh                              ul2_defconfig
arm                           sama5_defconfig
m68k                          atari_defconfig
powerpc                     tqm8548_defconfig
xtensa                    xip_kc705_defconfig
sh                ecovec24-romimage_defconfig
sh                          sdk7786_defconfig
arc                    vdk_hs38_smp_defconfig
xtensa                          iss_defconfig
arc                      axs103_smp_defconfig
m68k                       bvme6000_defconfig
arm                           sunxi_defconfig
arm                        trizeps4_defconfig
arm                        multi_v7_defconfig
parisc64                            defconfig
mips                           jazz_defconfig
arc                              alldefconfig
sh                          urquell_defconfig
sh                          sdk7780_defconfig
powerpc                      ppc40x_defconfig
sh                   secureedge5410_defconfig
arm                         lubbock_defconfig
sh                             shx3_defconfig
arm                            xcep_defconfig
mips                           ip32_defconfig
sh                        edosk7705_defconfig
arm                           stm32_defconfig
arm                        cerfcube_defconfig
sh                        dreamcast_defconfig
arm                      jornada720_defconfig
powerpc                    adder875_defconfig
m68k                       m5208evb_defconfig
sh                         apsh4a3a_defconfig
arm                           tegra_defconfig
mips                         cobalt_defconfig
arm                  randconfig-c002-20220317
arm                  randconfig-c002-20220313
arm                  randconfig-c002-20220314
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                 randconfig-a003-20220314
i386                 randconfig-a004-20220314
i386                 randconfig-a001-20220314
i386                 randconfig-a006-20220314
i386                 randconfig-a002-20220314
i386                 randconfig-a005-20220314
x86_64               randconfig-a004-20220314
x86_64               randconfig-a005-20220314
x86_64               randconfig-a003-20220314
x86_64               randconfig-a002-20220314
x86_64               randconfig-a006-20220314
x86_64               randconfig-a001-20220314
arc                  randconfig-r043-20220313
arc                  randconfig-r043-20220314
riscv                randconfig-r042-20220313
s390                 randconfig-r044-20220313
arc                  randconfig-r043-20220317
riscv                randconfig-r042-20220317
s390                 randconfig-r044-20220317
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                                  kexec

clang tested configs:
arm                  randconfig-c002-20220313
x86_64                        randconfig-c007
powerpc              randconfig-c003-20220313
riscv                randconfig-c006-20220313
mips                 randconfig-c004-20220313
i386                          randconfig-c001
mips                       rbtx49xx_defconfig
arm                       mainstone_defconfig
mips                            e55_defconfig
arm                          ep93xx_defconfig
powerpc                      pmac32_defconfig
powerpc                     kilauea_defconfig
mips                           mtx1_defconfig
mips                        maltaup_defconfig
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64               randconfig-a014-20220314
x86_64               randconfig-a015-20220314
x86_64               randconfig-a016-20220314
x86_64               randconfig-a012-20220314
x86_64               randconfig-a013-20220314
x86_64               randconfig-a011-20220314
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                 randconfig-a013-20220314
i386                 randconfig-a015-20220314
i386                 randconfig-a014-20220314
i386                 randconfig-a011-20220314
i386                 randconfig-a016-20220314
i386                 randconfig-a012-20220314
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r045-20220313
hexagon              randconfig-r041-20220313
hexagon              randconfig-r041-20220314
riscv                randconfig-r042-20220314
hexagon              randconfig-r045-20220314
s390                 randconfig-r044-20220314

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
