Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB4854D42B1
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Mar 2022 09:37:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236970AbiCJIhr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Mar 2022 03:37:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235496AbiCJIhq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Mar 2022 03:37:46 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 552F9136ECC
        for <linux-wireless@vger.kernel.org>; Thu, 10 Mar 2022 00:36:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646901406; x=1678437406;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=bJbrYKDgAObOAeAsaBDVuySAOoD7K5WsIVDXlK2+v+0=;
  b=U4FZl4iMYUGn/2RkUfM1NaOqgEsYEXwF5YMZ+m0Sy102m6L/cRALGBhN
   bwwTu3VeKOUhxKII6q5yBf6DINDiDfvSb0fIQ8STjTErGzw+6rkFAsW01
   EG/ioV/5kEt/eWzoNRXw0d8Ed65V2EVUwN2bY1kQsqbP5HLxeUb57YbQ5
   dXmaVDKuON1TEo89uq4WJbFnbZLNUEQKdVFugc6QFxZXUT9pugS4agzNy
   ttjsCQf4P1mWhb9CPpHQnHVFn8wedsDs1crH7eTnErS2L2DQX3GbW4LfW
   w7UEGRFAWSDRX5hp9UihMcU6mB9n2/xd1V0CbIq5bXjO97FOfh+m2S2E/
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10281"; a="235144731"
X-IronPort-AV: E=Sophos;i="5.90,169,1643702400"; 
   d="scan'208";a="235144731"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 00:36:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,169,1643702400"; 
   d="scan'208";a="644360855"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 10 Mar 2022 00:36:44 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nSEHr-0004ek-Nb; Thu, 10 Mar 2022 08:36:43 +0000
Date:   Thu, 10 Mar 2022 16:35:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>
Subject: [wireless-next:main] BUILD SUCCESS
 12b604d4ba693a3aa254cf7f9d0b4835770e9e97
Message-ID: <6229b861.Xo4qcgiwSLjmopDp%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: 12b604d4ba693a3aa254cf7f9d0b4835770e9e97  rtw89: declare HE capabilities in 6G band

elapsed time: 1202m

configs tested: 106
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm                                 defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                              allyesconfig
i386                          randconfig-c001
powerpc                      tqm8xx_defconfig
powerpc                         wii_defconfig
powerpc                  iss476-smp_defconfig
h8300                     edosk2674_defconfig
arm                           corgi_defconfig
arm                        spear6xx_defconfig
sh                           se7206_defconfig
h8300                       h8s-sim_defconfig
mips                 decstation_r4k_defconfig
mips                            gpr_defconfig
sh                          urquell_defconfig
arm                  randconfig-c002-20220309
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
nds32                             allnoconfig
nios2                               defconfig
arc                              allyesconfig
csky                                defconfig
alpha                               defconfig
nds32                               defconfig
alpha                            allyesconfig
nios2                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
h8300                            allyesconfig
xtensa                           allyesconfig
parisc                              defconfig
parisc64                            defconfig
s390                             allmodconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
i386                              debian-10.3
i386                                defconfig
sparc                               defconfig
i386                   debian-10.3-kselftests
sparc                            allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
i386                          randconfig-a001
i386                          randconfig-a005
i386                          randconfig-a003
x86_64                        randconfig-a013
x86_64                        randconfig-a011
x86_64                        randconfig-a015
x86_64                        randconfig-a002
x86_64                        randconfig-a004
x86_64                        randconfig-a006
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
arc                  randconfig-r043-20220309
riscv                    nommu_k210_defconfig
riscv                    nommu_virt_defconfig
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                         rhel-8.3-kunit
x86_64                              defconfig
x86_64                          rhel-8.3-func
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                                  kexec

clang tested configs:
powerpc                          allyesconfig
mips                      malta_kvm_defconfig
mips                   sb1250_swarm_defconfig
powerpc                     tqm5200_defconfig
mips                     loongson2k_defconfig
powerpc                     akebono_defconfig
arm                       mainstone_defconfig
arm                      pxa255-idp_defconfig
powerpc                 mpc8315_rdb_defconfig
powerpc                     kilauea_defconfig
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
x86_64                        randconfig-a001
x86_64                        randconfig-a003
x86_64                        randconfig-a005
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r041-20220309
hexagon              randconfig-r045-20220309
s390                 randconfig-r044-20220309
riscv                randconfig-r042-20220309

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
