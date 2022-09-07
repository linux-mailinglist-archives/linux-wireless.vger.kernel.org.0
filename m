Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8F585AF955
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Sep 2022 03:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbiIGBIZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Sep 2022 21:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbiIGBH6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Sep 2022 21:07:58 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A27758A7C0
        for <linux-wireless@vger.kernel.org>; Tue,  6 Sep 2022 18:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662512877; x=1694048877;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=TBncTFhvGCt7zfdqEwLqnWjclWIOf0JHJuiypoEKdJo=;
  b=ea0iw+pk0XG990Nnp7pmtuibuwk7nF+TdR4dHnuViQF+1iPLOWMQ0z5X
   hTtti8jtmSxzyik2OKtwbBq5icFJBz1OmYAD2XqTmMA69rccQXQeNjcPx
   hRIsalzoWXXxh3TAwL/bHzXboCKn1Ss/SxZfqUfzVCA3z04o3dwTs15n0
   ZZE4gHhPlLX7+I27djNYvjZsAoWOcOahdxiyH1L24GmV+9kyTUeIbyIuR
   BLT3DheeH2YLlVuswyBJOI/tLDA7Enld8XFeINZNber4vXzaPynxPI0Zn
   zXZphoyJBa24k88fXBvCAUHQbshVs4uzscQ8/xYQcV9Gk6V2r/V/hIHA7
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="277143318"
X-IronPort-AV: E=Sophos;i="5.93,295,1654585200"; 
   d="scan'208";a="277143318"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 18:07:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,295,1654585200"; 
   d="scan'208";a="942685529"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 06 Sep 2022 18:07:55 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oVjXn-0005tb-1H;
        Wed, 07 Sep 2022 01:07:55 +0000
Date:   Wed, 07 Sep 2022 09:07:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johannes Berg <johannes.berg@intel.com>
Cc:     linux-wireless@vger.kernel.org, Kalle Valo <kvalo@kernel.org>
Subject: [wireless-next:main] BUILD SUCCESS
 b008f4a195af92052f69a10869a06e9c403efe63
Message-ID: <6317eebc.W18549MxNUZdQJIG%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: b008f4a195af92052f69a10869a06e9c403efe63  wifi: rsi: fix kernel-doc warning

elapsed time: 936m

configs tested: 165
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                              defconfig
x86_64                               rhel-8.3
i386                             allyesconfig
i386                                defconfig
x86_64                           allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
arc                  randconfig-r043-20220906
m68k                             allyesconfig
riscv                randconfig-r042-20220906
s390                 randconfig-r044-20220906
i386                          randconfig-a014
i386                          randconfig-a012
i386                          randconfig-a016
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
x86_64                           rhel-8.3-kvm
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                    rhel-8.3-kselftests
x86_64                         rhel-8.3-kunit
arm                          pxa3xx_defconfig
microblaze                      mmu_defconfig
sh                          r7785rp_defconfig
sh                     sh7710voipgw_defconfig
openrisc                         alldefconfig
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
arc                        nsim_700_defconfig
powerpc                        warp_defconfig
arm                      footbridge_defconfig
mips                     loongson1b_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
sh                           se7780_defconfig
mips                           xway_defconfig
powerpc                       holly_defconfig
loongarch                           defconfig
loongarch                         allnoconfig
i386                          randconfig-c001
sh                          polaris_defconfig
sh                   sh7770_generic_defconfig
ia64                                defconfig
powerpc                    klondike_defconfig
ia64                            zx1_defconfig
mips                     decstation_defconfig
powerpc                      ppc40x_defconfig
mips                           ci20_defconfig
arm                              allmodconfig
sh                               j2_defconfig
arm                       aspeed_g5_defconfig
m68k                          multi_defconfig
powerpc                         wii_defconfig
arm                            lart_defconfig
powerpc                 mpc85xx_cds_defconfig
sparc64                             defconfig
parisc                generic-32bit_defconfig
arc                         haps_hs_defconfig
arm                           tegra_defconfig
arm                          gemini_defconfig
sh                         ecovec24_defconfig
xtensa                generic_kc705_defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
sh                          r7780mp_defconfig
sparc                       sparc64_defconfig
parisc64                            defconfig
powerpc                 canyonlands_defconfig
arm                           viper_defconfig
powerpc                    adder875_defconfig
sh                        dreamcast_defconfig
sh                          lboxre2_defconfig
powerpc                      bamboo_defconfig
powerpc                      makalu_defconfig
csky                             alldefconfig
m68k                                defconfig
powerpc                     pq2fads_defconfig
xtensa                          iss_defconfig
powerpc                    amigaone_defconfig
arm                        cerfcube_defconfig
sparc                            allyesconfig
sh                           se7705_defconfig
nios2                            allyesconfig
nios2                               defconfig
parisc                              defconfig
parisc                           allyesconfig
sh                           se7750_defconfig
sparc64                          alldefconfig
arm                             ezx_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220906
arm                          iop32x_defconfig
mips                           ip32_defconfig
nios2                         10m50_defconfig
arc                          axs103_defconfig
sparc                               defconfig
xtensa                           allyesconfig
csky                                defconfig
x86_64                                  kexec
powerpc                mpc7448_hpc2_defconfig
alpha                               defconfig
arm                           sama5_defconfig
powerpc                     tqm8548_defconfig
sh                            titan_defconfig
ia64                          tiger_defconfig
sh                         ap325rxa_defconfig
m68k                        mvme16x_defconfig
powerpc                 mpc837x_mds_defconfig
sh                          rsk7264_defconfig
sh                 kfr2r09-romimage_defconfig
ia64                             allmodconfig

clang tested configs:
hexagon              randconfig-r041-20220906
hexagon              randconfig-r045-20220906
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
powerpc                      ppc64e_defconfig
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
powerpc                    mvme5100_defconfig
arm                             mxs_defconfig
powerpc                 mpc8313_rdb_defconfig
arm                            mmp2_defconfig
arm                      pxa255-idp_defconfig
i386                             allyesconfig
mips                           ip27_defconfig
powerpc                      acadia_defconfig
powerpc                     pseries_defconfig
arm                        neponset_defconfig
powerpc                     kilauea_defconfig
powerpc                     akebono_defconfig
powerpc                   lite5200b_defconfig
powerpc                     tqm5200_defconfig
powerpc                     mpc512x_defconfig
arm                           spitz_defconfig
arm                       spear13xx_defconfig
mips                      malta_kvm_defconfig
arm                    vt8500_v6_v7_defconfig
arm                     davinci_all_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
