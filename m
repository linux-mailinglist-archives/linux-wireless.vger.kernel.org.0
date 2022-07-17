Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC33257732C
	for <lists+linux-wireless@lfdr.de>; Sun, 17 Jul 2022 04:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbiGQCZJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 16 Jul 2022 22:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiGQCZI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 16 Jul 2022 22:25:08 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A0871706C
        for <linux-wireless@vger.kernel.org>; Sat, 16 Jul 2022 19:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658024708; x=1689560708;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=DPHUUZhx7p6eBRxQVgRFdbkFRu+rxzLvbj6VKP5v4zw=;
  b=iBHhFggBRJ22jk8Eb1zFY9oNR4AAwACVUiEPyb9y24i7Op6iV1QS9RvZ
   Mz/xeMWG7BBifryIj36DN8Fbi76BpJZb8RuIHKS/I27Zj/o68iN9jb3jt
   vsbEEMXzXMu2n6TfrA6VbI9sRNIVrHTiZBzrMXG4maoto9/fcO1GSdLYM
   M9NmfPEuYzGckq2rv3T08Zr/jH11Fu6LZLIpIlSqHcRdsqIinLN6xzcxr
   SO9xnCUqr/7Uk5quMWSFC6gGHPiv+3B6GQQVGlCq0iJx0+xalUd+tONEW
   8osfSZFOSPKd7ouedHZVFmFa2wzdizaxcid/FHHvW9nzfbpU2mdWfwhfo
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10410"; a="283586056"
X-IronPort-AV: E=Sophos;i="5.92,278,1650956400"; 
   d="scan'208";a="283586056"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2022 19:25:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,278,1650956400"; 
   d="scan'208";a="594114597"
Received: from lkp-server02.sh.intel.com (HELO ff137eb26ff1) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 16 Jul 2022 19:25:05 -0700
Received: from kbuild by ff137eb26ff1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oCtxx-0002XC-Aa;
        Sun, 17 Jul 2022 02:25:05 +0000
Date:   Sun, 17 Jul 2022 10:24:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     linux-wireless@vger.kernel.org, Kalle Valo <kvalo@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>
Subject: [wireless:for-next] BUILD SUCCESS
 11052589cf5c0bab3b4884d423d5f60c38fcf25d
Message-ID: <62d372db.dN/SN1KTzqcYcu28%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git for-next
branch HEAD: 11052589cf5c0bab3b4884d423d5f60c38fcf25d  tcp/udp: Make early_demux back namespacified.

elapsed time: 1394m

configs tested: 182
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
powerpc              randconfig-c003-20220717
arm                      footbridge_defconfig
xtensa                              defconfig
openrisc                    or1ksim_defconfig
arm                     eseries_pxa_defconfig
mips                      loongson3_defconfig
x86_64                           alldefconfig
powerpc                 mpc837x_rdb_defconfig
powerpc                       holly_defconfig
arm                        multi_v7_defconfig
csky                              allnoconfig
sh                         ecovec24_defconfig
arm                        mvebu_v7_defconfig
powerpc                 mpc85xx_cds_defconfig
parisc                generic-32bit_defconfig
arm                            lart_defconfig
sh                         ap325rxa_defconfig
arm                          gemini_defconfig
arm                           sama5_defconfig
xtensa                generic_kc705_defconfig
xtensa                  nommu_kc705_defconfig
arm                            mps2_defconfig
mips                           jazz_defconfig
arm                          simpad_defconfig
arm                       multi_v4t_defconfig
arm                      integrator_defconfig
openrisc                            defconfig
mips                        vocore2_defconfig
powerpc                     ep8248e_defconfig
sh                        sh7763rdp_defconfig
mips                    maltaup_xpa_defconfig
arm                        keystone_defconfig
powerpc                      tqm8xx_defconfig
csky                                defconfig
loongarch                           defconfig
sh                               alldefconfig
powerpc                    sam440ep_defconfig
powerpc                     rainier_defconfig
xtensa                    xip_kc705_defconfig
powerpc                     tqm8555_defconfig
sh                        sh7785lcr_defconfig
mips                             allyesconfig
arm                       omap2plus_defconfig
arm                           u8500_defconfig
loongarch                 loongson3_defconfig
alpha                               defconfig
sh                           se7750_defconfig
arm                        spear6xx_defconfig
powerpc                     tqm8548_defconfig
arm                         lpc18xx_defconfig
sh                          urquell_defconfig
mips                       bmips_be_defconfig
ia64                             alldefconfig
openrisc                 simple_smp_defconfig
arm                        clps711x_defconfig
arm                           stm32_defconfig
arm                           h3600_defconfig
arm                          pxa910_defconfig
sh                           se7721_defconfig
m68k                        mvme147_defconfig
sh                          polaris_defconfig
powerpc                  storcenter_defconfig
arc                            hsdk_defconfig
i386                                defconfig
xtensa                         virt_defconfig
ia64                                defconfig
powerpc                      cm5200_defconfig
m68k                       m5208evb_defconfig
ia64                         bigsur_defconfig
xtensa                    smp_lx200_defconfig
powerpc                     asp8347_defconfig
sh                   secureedge5410_defconfig
mips                         tb0226_defconfig
s390                                defconfig
s390                             allmodconfig
arc                                 defconfig
s390                             allyesconfig
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
alpha                             allnoconfig
arc                               allnoconfig
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
sh                               allmodconfig
i386                             allyesconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
arc                  randconfig-r043-20220717
arc                  randconfig-r043-20220716
arc                  randconfig-r043-20220715
s390                 randconfig-r044-20220716
riscv                randconfig-r042-20220716
x86_64                    rhel-8.3-kselftests
x86_64                           allyesconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit

clang tested configs:
powerpc                     tqm5200_defconfig
mips                        qi_lb60_defconfig
powerpc                     kilauea_defconfig
mips                      pic32mzda_defconfig
mips                           mtx1_defconfig
powerpc                      ppc64e_defconfig
powerpc                  mpc885_ads_defconfig
powerpc                    mvme5100_defconfig
arm                       aspeed_g4_defconfig
arm                          moxart_defconfig
powerpc                     ppa8548_defconfig
mips                      maltaaprp_defconfig
arm                        multi_v5_defconfig
arm                       imx_v4_v5_defconfig
riscv                          rv32_defconfig
mips                        workpad_defconfig
arm                        mvebu_v5_defconfig
arm                         bcm2835_defconfig
powerpc                    socrates_defconfig
powerpc               mpc834x_itxgp_defconfig
mips                      malta_kvm_defconfig
mips                           ip28_defconfig
mips                  cavium_octeon_defconfig
arm                       netwinder_defconfig
mips                       lemote2f_defconfig
arm                   milbeaut_m10v_defconfig
powerpc                    ge_imp3a_defconfig
mips                     loongson1c_defconfig
arm                         orion5x_defconfig
mips                     cu1830-neo_defconfig
powerpc                      obs600_defconfig
arm                            dove_defconfig
x86_64                        randconfig-k001
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
riscv                randconfig-r042-20220715
hexagon              randconfig-r045-20220715
s390                 randconfig-r044-20220715
hexagon              randconfig-r041-20220716
hexagon              randconfig-r045-20220716
hexagon              randconfig-r041-20220715
hexagon              randconfig-r045-20220717
s390                 randconfig-r044-20220717
hexagon              randconfig-r041-20220717
riscv                randconfig-r042-20220717

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
