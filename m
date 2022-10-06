Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98FA95F6E6E
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Oct 2022 21:51:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232110AbiJFTvq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 6 Oct 2022 15:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232101AbiJFTvp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 6 Oct 2022 15:51:45 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBC02125027
        for <linux-wireless@vger.kernel.org>; Thu,  6 Oct 2022 12:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665085903; x=1696621903;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=slHQxGeAabBkCLBZE+mRhL8TmKtsmDksbO76urjRpns=;
  b=OE136R7ebhYQuFS26bnzF4IPtphotwYw9NoP6pXPVJbebWy4o8aYZ3oL
   hslAE2pJ9Gswmk3bX1FuTlIto6nyECnY7VL3C1Z3Xo1Z7rBPcy/GuvKhI
   LmexfPNi02uORNTT/oJIT9+JOJ5FviijkY6xWtY67pknvu4F75VwdwNEC
   RE2Vf3qiZ1Pevn7+pT9zfkrPj3ZjX0AT89AsCa46qECxmWRYcSzwTqhz3
   pJZWJm5rfRMfF1OzgnvcW4Jcn8AE5y3jIp42817VSWkgaBlEpVLJuc8j3
   l78qZ1by95/mlsbkkXQMhP4PG7jNcE1L9eGJYIlu7Y/Lg2ZLrRr25ajOW
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10492"; a="389845648"
X-IronPort-AV: E=Sophos;i="5.95,164,1661842800"; 
   d="scan'208";a="389845648"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2022 12:51:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10492"; a="767284875"
X-IronPort-AV: E=Sophos;i="5.95,164,1661842800"; 
   d="scan'208";a="767284875"
Received: from lkp-server01.sh.intel.com (HELO 3c15167049b7) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 06 Oct 2022 12:51:42 -0700
Received: from kbuild by 3c15167049b7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ogWuD-0000Pb-20;
        Thu, 06 Oct 2022 19:51:41 +0000
Date:   Fri, 07 Oct 2022 03:51:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johannes Berg <johannes.berg@intel.com>
Cc:     linux-wireless@vger.kernel.org, Kalle Valo <kvalo@kernel.org>
Subject: [wireless-next:mld] BUILD SUCCESS
 c028c32152a5b8841d5451748b98f98c3a04b269
Message-ID: <633f31b8.09HEr38Kall2m33D%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git mld
branch HEAD: c028c32152a5b8841d5451748b98f98c3a04b269  wifi: mac80211: fix ifdef symbol name

elapsed time: 722m

configs tested: 146
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                              defconfig
arc                                 defconfig
alpha                               defconfig
s390                                defconfig
i386                                defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
arm                                 defconfig
x86_64                    rhel-8.3-kselftests
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
um                             i386_defconfig
x86_64                           allyesconfig
um                           x86_64_defconfig
x86_64                           rhel-8.3-kvm
x86_64               randconfig-a011-20221003
powerpc                          allmodconfig
x86_64               randconfig-a012-20221003
mips                             allyesconfig
x86_64               randconfig-a013-20221003
i386                 randconfig-a011-20221003
sh                               allmodconfig
arm                              allyesconfig
i386                 randconfig-a012-20221003
powerpc                           allnoconfig
arm64                            allyesconfig
i386                 randconfig-a013-20221003
i386                             allyesconfig
m68k                             allyesconfig
i386                 randconfig-a015-20221003
x86_64               randconfig-a015-20221003
i386                 randconfig-a016-20221003
i386                 randconfig-a014-20221003
x86_64               randconfig-a014-20221003
s390                             allmodconfig
x86_64               randconfig-a016-20221003
riscv                randconfig-r042-20221003
arc                  randconfig-r043-20221003
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
ia64                             allmodconfig
arc                  randconfig-r043-20221002
s390                 randconfig-r044-20221003
s390                             allyesconfig
alpha                            allyesconfig
mips                        bcm47xx_defconfig
arm                          simpad_defconfig
m68k                             allmodconfig
arc                              allyesconfig
arc                        nsim_700_defconfig
sh                          r7780mp_defconfig
xtensa                              defconfig
sh                        dreamcast_defconfig
m68k                       m5475evb_defconfig
mips                    maltaup_xpa_defconfig
i386                          randconfig-c001
powerpc                      pcm030_defconfig
arm                      jornada720_defconfig
arm                     eseries_pxa_defconfig
mips                         cobalt_defconfig
openrisc                            defconfig
nios2                            alldefconfig
powerpc                      cm5200_defconfig
arm                           viper_defconfig
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
arc                           tb10x_defconfig
um                               alldefconfig
mips                         bigsur_defconfig
m68k                            q40_defconfig
mips                  decstation_64_defconfig
powerpc                     tqm8548_defconfig
mips                      loongson3_defconfig
xtensa                  nommu_kc705_defconfig
m68k                            mac_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                 randconfig-c004-20221002
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
powerpc                     taishan_defconfig
powerpc                       eiger_defconfig
loongarch                        alldefconfig
powerpc                 mpc85xx_cds_defconfig
parisc                generic-64bit_defconfig
arm                  randconfig-c002-20221002
x86_64                        randconfig-c001
sh                            migor_defconfig
powerpc                      tqm8xx_defconfig
powerpc                     tqm8555_defconfig
powerpc                         wii_defconfig
powerpc                        warp_defconfig
powerpc                      makalu_defconfig
csky                             alldefconfig
arc                      axs103_smp_defconfig
mips                            gpr_defconfig
arm                        clps711x_defconfig
arm                      integrator_defconfig
powerpc                     sequoia_defconfig
powerpc                  storcenter_defconfig
powerpc                     mpc83xx_defconfig
mips                  maltasmvp_eva_defconfig

clang tested configs:
x86_64               randconfig-a002-20221003
x86_64               randconfig-a001-20221003
hexagon              randconfig-r041-20221003
x86_64               randconfig-a004-20221003
riscv                randconfig-r042-20221002
hexagon              randconfig-r041-20221002
x86_64               randconfig-a006-20221003
i386                 randconfig-a004-20221003
i386                 randconfig-a005-20221003
i386                 randconfig-a003-20221003
x86_64               randconfig-a003-20221003
s390                 randconfig-r044-20221002
x86_64               randconfig-a005-20221003
i386                 randconfig-a002-20221003
i386                 randconfig-a001-20221003
i386                 randconfig-a006-20221003
powerpc                    mvme5100_defconfig
powerpc                     ppa8548_defconfig
hexagon              randconfig-r045-20221002
hexagon              randconfig-r045-20221003
riscv                randconfig-r042-20221006
hexagon              randconfig-r041-20221006
s390                 randconfig-r044-20221006
hexagon              randconfig-r045-20221006
x86_64                        randconfig-k001
arm                          sp7021_defconfig
arm                        magician_defconfig
powerpc                     powernv_defconfig
arm                           spitz_defconfig
i386                             allyesconfig
powerpc                   bluestone_defconfig
powerpc                          g5_defconfig
powerpc                      pmac32_defconfig
arm                                 defconfig
powerpc                      ppc44x_defconfig
powerpc                   microwatt_defconfig
mips                malta_qemu_32r6_defconfig
powerpc                      obs600_defconfig
arm                       cns3420vb_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
