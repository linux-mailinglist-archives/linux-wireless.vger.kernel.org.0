Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCF8C5F5B14
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Oct 2022 22:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbiJEUhg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 5 Oct 2022 16:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230508AbiJEUhf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 5 Oct 2022 16:37:35 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8420948CA3
        for <linux-wireless@vger.kernel.org>; Wed,  5 Oct 2022 13:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665002254; x=1696538254;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=1SmTtXJby4IzJP1o3XW6AzPCBqvJgrXVPyYEeAO4xV0=;
  b=hWgCmSTC6dymmr7AamKOcDDUch+NtOnbBDAtWL/5+ufQG8M8Fqv2oiV3
   qQPmLQWGOsR1l2k1sWoU544hYKKTzSkRfHnJewu+pyOmov/NFIMbz6QKb
   +DgKU7LeR9+UFR48jyxrq1uUbmYOzLZavceHGA+hWhxDL/FmRMonkUxjn
   75134+bD0y5CDmbClBF1LKwehVA7CO6Hp4rL0ao4KMAyeXb6dDrAN8UHR
   Tur0WMK6eKx8sNBqaZgx574HzI7yCFjIVAjiJ/LNh+oVY34eRNAzqYN1/
   j4C2/7JWvqbSVWnMVQmNHFCHaI6GAT1zLgtAoC1+VNMbLinCXNLjrBBr4
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10491"; a="290523476"
X-IronPort-AV: E=Sophos;i="5.95,161,1661842800"; 
   d="scan'208";a="290523476"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2022 13:37:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10491"; a="766879663"
X-IronPort-AV: E=Sophos;i="5.95,161,1661842800"; 
   d="scan'208";a="766879663"
Received: from lkp-server01.sh.intel.com (HELO d4f44333118a) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 05 Oct 2022 13:37:31 -0700
Received: from kbuild by d4f44333118a with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ogB91-0001bv-11;
        Wed, 05 Oct 2022 20:37:31 +0000
Date:   Thu, 06 Oct 2022 04:36:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>
Subject: [wireless-next:main] BUILD SUCCESS
 8af9d4068e86dd5c3221ee495ec09537c7fb458b
Message-ID: <633deae8.L4zgaHj+dvnXABx3%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: 8af9d4068e86dd5c3221ee495ec09537c7fb458b  wifi: atmel: Avoid clashing function prototypes

elapsed time: 720m

configs tested: 111
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
powerpc                          allmodconfig
mips                             allyesconfig
powerpc                           allnoconfig
i386                                defconfig
um                           x86_64_defconfig
um                             i386_defconfig
arm                                 defconfig
i386                 randconfig-a016-20221003
x86_64               randconfig-a015-20221003
x86_64               randconfig-a016-20221003
arm64                            allyesconfig
arm                              allyesconfig
ia64                             allmodconfig
i386                             allyesconfig
riscv                randconfig-r042-20221003
arc                  randconfig-r043-20221003
arc                  randconfig-r043-20221002
s390                 randconfig-r044-20221003
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
sparc                               defconfig
arc                        nsim_700_defconfig
sh                            titan_defconfig
powerpc                 mpc834x_itx_defconfig
s390                                defconfig
s390                             allmodconfig
alpha                               defconfig
s390                             allyesconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
x86_64               randconfig-a011-20221003
x86_64               randconfig-a014-20221003
x86_64               randconfig-a013-20221003
x86_64               randconfig-a012-20221003
i386                 randconfig-a011-20221003
i386                 randconfig-a012-20221003
i386                 randconfig-a014-20221003
i386                 randconfig-a015-20221003
i386                 randconfig-a013-20221003
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
sh                          landisk_defconfig
mips                      fuloong2e_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
riscv                               defconfig
arc                                 defconfig
riscv                            allmodconfig
arm                      jornada720_defconfig
sh                               allmodconfig
m68k                        m5407c3_defconfig
sh                  sh7785lcr_32bit_defconfig
xtensa                    xip_kc705_defconfig
i386                          randconfig-c001
mips                 randconfig-c004-20221002
m68k                            q40_defconfig
mips                  decstation_64_defconfig
powerpc                     tqm8548_defconfig
powerpc                     taishan_defconfig
powerpc                       eiger_defconfig
loongarch                        alldefconfig
powerpc                 mpc85xx_cds_defconfig
parisc                generic-64bit_defconfig
powerpc                         wii_defconfig
m68k                          atari_defconfig
sh                      rts7751r2d1_defconfig
mips                           xway_defconfig
powerpc                    klondike_defconfig
x86_64                        randconfig-c001
arm                       omap2plus_defconfig
arc                           tb10x_defconfig

clang tested configs:
x86_64               randconfig-a006-20221003
x86_64               randconfig-a005-20221003
x86_64               randconfig-a004-20221003
i386                 randconfig-a005-20221003
hexagon              randconfig-r041-20221003
riscv                randconfig-r042-20221002
i386                 randconfig-a006-20221003
hexagon              randconfig-r041-20221002
s390                 randconfig-r044-20221002
hexagon              randconfig-r045-20221002
hexagon              randconfig-r045-20221003
x86_64                        randconfig-k001
x86_64               randconfig-a003-20221003
x86_64               randconfig-a001-20221003
x86_64               randconfig-a002-20221003
i386                 randconfig-a001-20221003
i386                 randconfig-a002-20221003
i386                 randconfig-a003-20221003
i386                 randconfig-a004-20221003
hexagon              randconfig-r041-20221005
hexagon              randconfig-r045-20221005
mips                malta_qemu_32r6_defconfig
powerpc                 mpc836x_mds_defconfig
arm                            mmp2_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
