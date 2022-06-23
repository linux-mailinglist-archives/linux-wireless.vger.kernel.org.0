Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21684557622
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Jun 2022 10:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbiFWI7e (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Jun 2022 04:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbiFWI7a (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Jun 2022 04:59:30 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BCB1140CD
        for <linux-wireless@vger.kernel.org>; Thu, 23 Jun 2022 01:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655974769; x=1687510769;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=xQHVOBUw4Zad+UiT5UVz2CKIM5rBv7HhATojKPUSb1E=;
  b=HYFTLauVMS8FfDhrD1KCNhgTrX6gFql+76RtlwxzZTaDnjgi2AYf/zVe
   vCr5SHSLYYChkccTH61xC0gWUn1GhEkWhO+bu5etu6q9vBfsL2sAcyZvI
   0iokd71qbA7WgH/h/kEe9GnmzQCN2gkt8PDaytmwg6wAUVjXlz/dK0xSk
   Q1C26OgGBcvNbdrFYaBX/lqNFbUC+zzcwRQ4a46WvV3mPl1wV3UsUbuMu
   5kUM0V45FQBKoD7sbCPOwbnxm5We9sEg5kTUdYc1H+mqlkdvD/4dgcxP9
   w1YgOePye0Sj0tPNyud2KIIxczDzLkvFMRMYr5SbxgNm18s4Nd7YVyWlL
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10386"; a="281395921"
X-IronPort-AV: E=Sophos;i="5.92,215,1650956400"; 
   d="scan'208";a="281395921"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 01:59:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,215,1650956400"; 
   d="scan'208";a="592612290"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 23 Jun 2022 01:59:27 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o4IgQ-0000zV-MN;
        Thu, 23 Jun 2022 08:59:26 +0000
Date:   Thu, 23 Jun 2022 16:58:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>
Subject: [wireless-next:main] BUILD SUCCESS
 683a4647a7a3044868cfdc14c117525091b9fa0c
Message-ID: <62b42b47.300GmIXlZZoAmgrn%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: 683a4647a7a3044868cfdc14c117525091b9fa0c  wifi: rtw89: 8852a: rfk: fix div 0 exception

elapsed time: 2975m

configs tested: 195
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
arm64                               defconfig
arm                              allmodconfig
mips                 randconfig-c004-20220619
i386                          randconfig-c001
mips                 randconfig-c004-20220622
sh                           se7780_defconfig
powerpc                 mpc8540_ads_defconfig
powerpc                     mpc83xx_defconfig
sh                          urquell_defconfig
sparc                       sparc64_defconfig
m68k                          multi_defconfig
alpha                            alldefconfig
mips                       bmips_be_defconfig
arc                              alldefconfig
mips                         rt305x_defconfig
csky                             alldefconfig
mips                          rb532_defconfig
arc                      axs103_smp_defconfig
m68k                       m5249evb_defconfig
ia64                         bigsur_defconfig
openrisc                 simple_smp_defconfig
powerpc                      mgcoge_defconfig
arm                        shmobile_defconfig
arc                          axs103_defconfig
m68k                          hp300_defconfig
arc                        vdk_hs38_defconfig
sh                          landisk_defconfig
m68k                          sun3x_defconfig
xtensa                       common_defconfig
arm                       imx_v6_v7_defconfig
um                                  defconfig
sh                               j2_defconfig
powerpc                       ppc64_defconfig
xtensa                  audio_kc705_defconfig
arm                        multi_v7_defconfig
sh                           se7705_defconfig
arm                           stm32_defconfig
arm64                            alldefconfig
ia64                             alldefconfig
sh                                  defconfig
ia64                      gensparse_defconfig
mips                           ci20_defconfig
xtensa                  nommu_kc705_defconfig
m68k                             allyesconfig
sh                           se7724_defconfig
arm                        realview_defconfig
powerpc                     redwood_defconfig
powerpc                 mpc837x_rdb_defconfig
sh                         apsh4a3a_defconfig
arm                           h3600_defconfig
powerpc                 mpc837x_mds_defconfig
arm                         cm_x300_defconfig
m68k                           virt_defconfig
powerpc                         wii_defconfig
sh                          sdk7786_defconfig
arm                         axm55xx_defconfig
arc                 nsimosci_hs_smp_defconfig
sh                   sh7770_generic_defconfig
xtensa                    smp_lx200_defconfig
powerpc                       maple_defconfig
sh                         microdev_defconfig
sh                        sh7785lcr_defconfig
powerpc                      ppc6xx_defconfig
mips                            ar7_defconfig
riscv                               defconfig
arm                      integrator_defconfig
um                             i386_defconfig
arm                         vf610m4_defconfig
powerpc                      pasemi_defconfig
nios2                         10m50_defconfig
parisc                generic-32bit_defconfig
powerpc                   currituck_defconfig
m68k                            q40_defconfig
sh                          kfr2r09_defconfig
powerpc                 linkstation_defconfig
mips                            gpr_defconfig
xtensa                         virt_defconfig
um                               alldefconfig
openrisc                            defconfig
arm                         lubbock_defconfig
m68k                        mvme147_defconfig
sh                          rsk7201_defconfig
arm                     eseries_pxa_defconfig
powerpc                     tqm8541_defconfig
arm                             rpc_defconfig
sparc                               defconfig
xtensa                           allyesconfig
csky                                defconfig
sparc                            allyesconfig
x86_64                                  kexec
s390                                defconfig
s390                             allmodconfig
arc                                 defconfig
alpha                               defconfig
s390                             allyesconfig
nios2                            allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220622
riscv                             allnoconfig
m68k                             allmodconfig
m68k                                defconfig
arc                              allyesconfig
alpha                            allyesconfig
sh                               allmodconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
i386                             allyesconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allmodconfig
powerpc                          allyesconfig
x86_64               randconfig-a004-20220620
x86_64               randconfig-a006-20220620
x86_64               randconfig-a001-20220620
x86_64               randconfig-a005-20220620
x86_64               randconfig-a002-20220620
x86_64               randconfig-a003-20220620
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                 randconfig-a005-20220620
i386                 randconfig-a001-20220620
i386                 randconfig-a006-20220620
i386                 randconfig-a004-20220620
i386                 randconfig-a003-20220620
i386                 randconfig-a002-20220620
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
riscv                randconfig-r042-20220619
arc                  randconfig-r043-20220620
arc                  randconfig-r043-20220619
s390                 randconfig-r044-20220619
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                            allmodconfig
riscv                            allyesconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit

clang tested configs:
arm                         orion5x_defconfig
mips                        maltaup_defconfig
s390                             alldefconfig
mips                        qi_lb60_defconfig
arm64                            allyesconfig
powerpc                       ebony_defconfig
arm                       aspeed_g4_defconfig
powerpc                 mpc8313_rdb_defconfig
mips                      malta_kvm_defconfig
mips                      maltaaprp_defconfig
x86_64                        randconfig-k001
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64               randconfig-a013-20220620
x86_64               randconfig-a012-20220620
x86_64               randconfig-a016-20220620
x86_64               randconfig-a015-20220620
x86_64               randconfig-a011-20220620
x86_64               randconfig-a014-20220620
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
i386                 randconfig-a014-20220620
i386                 randconfig-a011-20220620
i386                 randconfig-a012-20220620
i386                 randconfig-a015-20220620
i386                 randconfig-a016-20220620
i386                 randconfig-a013-20220620
hexagon              randconfig-r041-20220622
s390                 randconfig-r044-20220622
hexagon              randconfig-r045-20220622
riscv                randconfig-r042-20220622
hexagon              randconfig-r041-20220621
hexagon              randconfig-r045-20220621

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
