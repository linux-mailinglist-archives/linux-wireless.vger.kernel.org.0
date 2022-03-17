Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B5974DCF44
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Mar 2022 21:24:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbiCQUZ2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 17 Mar 2022 16:25:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiCQUZZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 17 Mar 2022 16:25:25 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8354D147AC9
        for <linux-wireless@vger.kernel.org>; Thu, 17 Mar 2022 13:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647548648; x=1679084648;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=dR3YQEf3oZAGXscdmuvzHxOJ4DHaIY9z5svPhz+nrqs=;
  b=bR0L+RYszRStrMZRYyUcG6dME5xD8Hb5IFGooabrdn+SJGyp0OzllPcC
   XRnYob90ZBKRb935QjnO1BK9duUjzX4y3yi+oBq5uKr3TLOq5aDy3HaV5
   bQuk+lMCvZSlNb92Pg0aGr7X117DUrdBGrVt0OBdrModaxdU8CfpW/eLJ
   X1Gwj0awJSGs4kNIpWu7cfquyiMoGl2HLPvfJ/nfoea6FQ824bKVhyYhc
   Gns4BQY5Ma2/7Mw37zVjWiyVW0wHKDCb4rnv0d6Zh0i258eHCXGdBxtRm
   912NEo7HGJ6ZtSlxm0usNUC94JI/M01vFtJS1wVpC2UJCWvHHTXrSCkwE
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="343410518"
X-IronPort-AV: E=Sophos;i="5.90,190,1643702400"; 
   d="scan'208";a="343410518"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 13:24:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,190,1643702400"; 
   d="scan'208";a="541527291"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 17 Mar 2022 13:24:06 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nUwfF-000E1T-Sy; Thu, 17 Mar 2022 20:24:05 +0000
Date:   Fri, 18 Mar 2022 04:23:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>
Subject: [wireless-next:pending] BUILD SUCCESS
 d3f47e73e8d5cbb89e81a84200e5ff8369e66752
Message-ID: <623398bf.8LlBrTbrXjFJwB2p%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git pending
branch HEAD: d3f47e73e8d5cbb89e81a84200e5ff8369e66752  iwlwifi: mei: fix building iwlmei

elapsed time: 733m

configs tested: 119
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                               defconfig
arm                              allmodconfig
arm                              allyesconfig
arm64                            allyesconfig
arm                             pxa_defconfig
sh                   rts7751r2dplus_defconfig
nios2                         10m50_defconfig
sh                               alldefconfig
powerpc                     tqm8548_defconfig
xtensa                              defconfig
mips                  decstation_64_defconfig
mips                      loongson3_defconfig
mips                      maltasmvp_defconfig
powerpc                     tqm8541_defconfig
powerpc                     tqm8555_defconfig
h8300                    h8300h-sim_defconfig
m68k                          amiga_defconfig
mips                     decstation_defconfig
arc                      axs103_smp_defconfig
arm                       aspeed_g5_defconfig
parisc64                         alldefconfig
arm                      jornada720_defconfig
alpha                            alldefconfig
sh                        dreamcast_defconfig
arm                        cerfcube_defconfig
arm                           stm32_defconfig
sh                          sdk7780_defconfig
arm                         vf610m4_defconfig
arm                         at91_dt_defconfig
arm                            qcom_defconfig
mips                         cobalt_defconfig
arm                  randconfig-c002-20220317
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
alpha                               defconfig
nds32                               defconfig
alpha                            allyesconfig
nios2                            allyesconfig
csky                                defconfig
arc                                 defconfig
sh                               allmodconfig
h8300                            allyesconfig
xtensa                           allyesconfig
s390                                defconfig
parisc                              defconfig
parisc64                            defconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                             allyesconfig
sparc                               defconfig
i386                             allyesconfig
i386                              debian-10.3
i386                   debian-10.3-kselftests
i386                                defconfig
sparc                            allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                          randconfig-a003
i386                          randconfig-a001
i386                          randconfig-a005
x86_64                        randconfig-a015
x86_64                        randconfig-a013
x86_64                        randconfig-a011
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
x86_64                        randconfig-a002
x86_64                        randconfig-a004
x86_64                        randconfig-a006
arc                  randconfig-r043-20220317
s390                 randconfig-r044-20220317
riscv                randconfig-r042-20220317
riscv                            allmodconfig
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                                  kexec
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                         rhel-8.3-kunit
x86_64                    rhel-8.3-kselftests

clang tested configs:
arm                    vt8500_v6_v7_defconfig
mips                        qi_lb60_defconfig
powerpc                 mpc832x_rdb_defconfig
arm                           spitz_defconfig
powerpc                       ebony_defconfig
arm                           sama7_defconfig
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
x86_64                        randconfig-a001
x86_64                        randconfig-a005
x86_64                        randconfig-a003
hexagon              randconfig-r041-20220317
hexagon              randconfig-r045-20220317

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
