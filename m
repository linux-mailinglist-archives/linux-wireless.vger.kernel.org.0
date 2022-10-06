Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE5065F6D9A
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Oct 2022 20:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbiJFSkp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 6 Oct 2022 14:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbiJFSkm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 6 Oct 2022 14:40:42 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C597558CC
        for <linux-wireless@vger.kernel.org>; Thu,  6 Oct 2022 11:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665081641; x=1696617641;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=Pl25bLdTm1jWp6VTiRz3B0ReF899/o+FkOoQsD0B+Gk=;
  b=SSZkT75quziBXMRW3f4K9O+flWq45NylZw5+WoPFZ0/el88u6OK55V3c
   evFADnAguADeRsSd+VmnpKeJqhdEwqgbdY+0AeksVumdP8b7Jzpo2g6JA
   MxY9VO6my429peA4ml9qR433BpxaMX3gK3TgnAAk3n/n+5j0afiZ/bOzN
   7LimlGDxP/yJmJJ7nQ6nMRWIQLwVjMnwXzCrTz/7LLGf255ZYtz7h6aXO
   nzEUgNWDP93YfEZSbSIlK63Osrz1ZMMAsMbH6aoYLYOR24RCC5u1/wo4o
   qSCTwEcBnKXWNrVhe9aoewmuFYwtVS4hN8YG+V6W2HcF/htwBl7D42tvJ
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10492"; a="304533020"
X-IronPort-AV: E=Sophos;i="5.95,164,1661842800"; 
   d="scan'208";a="304533020"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2022 11:40:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10492"; a="953736222"
X-IronPort-AV: E=Sophos;i="5.95,164,1661842800"; 
   d="scan'208";a="953736222"
Received: from lkp-server01.sh.intel.com (HELO 3c15167049b7) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 06 Oct 2022 11:40:39 -0700
Received: from kbuild by 3c15167049b7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1ogVnS-0000NL-1w;
        Thu, 06 Oct 2022 18:40:38 +0000
Date:   Fri, 07 Oct 2022 02:40:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>
Subject: [wireless:for-next] BUILD SUCCESS
 6b430f72b2bc14fd0ac922dda92eaa51c82e15a4
Message-ID: <633f2109.2Lfs8Ufri4N/OYsr%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git for-next
branch HEAD: 6b430f72b2bc14fd0ac922dda92eaa51c82e15a4  wifi: mt76: fix rate reporting / throughput regression on mt7915 and newer

elapsed time: 723m

configs tested: 124
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                                 defconfig
s390                             allmodconfig
i386                 randconfig-a016-20221003
i386                 randconfig-a014-20221003
alpha                               defconfig
i386                 randconfig-a011-20221003
arc                  randconfig-r043-20221006
x86_64                              defconfig
i386                 randconfig-a012-20221003
x86_64                          rhel-8.3-func
x86_64               randconfig-a011-20221003
x86_64                    rhel-8.3-kselftests
i386                 randconfig-a013-20221003
x86_64               randconfig-a012-20221003
powerpc                           allnoconfig
i386                 randconfig-a015-20221003
i386                                defconfig
arm                                 defconfig
s390                                defconfig
x86_64                           rhel-8.3-syz
x86_64               randconfig-a015-20221003
x86_64                         rhel-8.3-kunit
m68k                             allmodconfig
arc                  randconfig-r043-20221003
x86_64                           rhel-8.3-kvm
s390                             allyesconfig
x86_64               randconfig-a013-20221003
arc                              allyesconfig
x86_64               randconfig-a016-20221003
s390                 randconfig-r044-20221003
x86_64               randconfig-a014-20221003
riscv                randconfig-r042-20221003
x86_64                               rhel-8.3
alpha                            allyesconfig
x86_64                           allyesconfig
ia64                             allmodconfig
m68k                             allyesconfig
arm64                            allyesconfig
arm                              allyesconfig
i386                             allyesconfig
sh                               allmodconfig
mips                             allyesconfig
powerpc                          allmodconfig
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
mips                        bcm47xx_defconfig
arm                          simpad_defconfig
arc                        nsim_700_defconfig
sh                          r7780mp_defconfig
xtensa                              defconfig
arc                  randconfig-r043-20221002
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
powerpc                     taishan_defconfig
powerpc                       eiger_defconfig
loongarch                        alldefconfig
powerpc                 mpc85xx_cds_defconfig
parisc                generic-64bit_defconfig
arm                  randconfig-c002-20221002
x86_64                        randconfig-c001
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
sh                            migor_defconfig
powerpc                      tqm8xx_defconfig
powerpc                     tqm8555_defconfig
powerpc                        warp_defconfig
powerpc                      makalu_defconfig
csky                             alldefconfig
arc                      axs103_smp_defconfig
mips                            gpr_defconfig
arm                        clps711x_defconfig
arm                      integrator_defconfig
powerpc                     sequoia_defconfig

clang tested configs:
hexagon              randconfig-r041-20221006
x86_64               randconfig-a003-20221003
i386                 randconfig-a005-20221003
hexagon              randconfig-r045-20221006
x86_64               randconfig-a002-20221003
hexagon              randconfig-r045-20221003
i386                 randconfig-a006-20221003
s390                 randconfig-r044-20221006
x86_64               randconfig-a001-20221003
hexagon              randconfig-r041-20221003
x86_64               randconfig-a004-20221003
riscv                randconfig-r042-20221006
x86_64               randconfig-a006-20221003
x86_64               randconfig-a005-20221003
i386                 randconfig-a003-20221003
i386                 randconfig-a001-20221003
i386                 randconfig-a002-20221003
i386                 randconfig-a004-20221003
powerpc                    mvme5100_defconfig
powerpc                     ppa8548_defconfig
x86_64                        randconfig-k001
powerpc                     powernv_defconfig
arm                           spitz_defconfig
i386                             allyesconfig
powerpc                   bluestone_defconfig
powerpc                          g5_defconfig
powerpc                      pmac32_defconfig
arm                                 defconfig
powerpc                      ppc44x_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
