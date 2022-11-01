Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD3F661561E
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Nov 2022 00:29:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbiKAX3e (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Nov 2022 19:29:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbiKAX3c (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Nov 2022 19:29:32 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBEDC13E28
        for <linux-wireless@vger.kernel.org>; Tue,  1 Nov 2022 16:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667345371; x=1698881371;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=BVj9irDuP5eCk/K5xKl4QwQyfr7km7ILYCuVCFJ+k0Q=;
  b=JiBlrIJsZUbeviDqkEewFlkthxarmK9iIEdzmwfLdkjUP5BGB/45+gow
   qHQaBM/hENEjb8fyE+PetI55eONTieYllr/7+Q6tTosTajjUDkLaZE5Wi
   0xRy6oYBajiW06DIMP0lhbmRZSnb3ndaoHltC2HejtPMlA7MHYaY3qmzr
   pehaCJUmrqs588AZ+UUfiqFGdObPs6CKZP9ATkVrGbYo/xP9fw5s+1oBd
   frSbJGzDHGis/saws5fub82cS+YzUsaPkUQdiFHHEv3y9iMVSAeScHv+s
   0hZjNWLpWgjOczf7eFO0T3tEMx596u8V6cqjJipsH1v3jEJP6xf83dvLs
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="310368863"
X-IronPort-AV: E=Sophos;i="5.95,232,1661842800"; 
   d="scan'208";a="310368863"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2022 16:29:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="759343022"
X-IronPort-AV: E=Sophos;i="5.95,232,1661842800"; 
   d="scan'208";a="759343022"
Received: from lkp-server02.sh.intel.com (HELO b6d29c1a0365) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 01 Nov 2022 16:29:30 -0700
Received: from kbuild by b6d29c1a0365 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oq0hF-000EAK-1D;
        Tue, 01 Nov 2022 23:29:29 +0000
Date:   Wed, 02 Nov 2022 07:29:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>
Subject: [wireless:for-next] BUILD SUCCESS
 6788ba8aed4e28e90f72d68a9d794e34eac17295
Message-ID: <6361abc7.1gD5ME7XSVQ1F1P0%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git for-next
branch HEAD: 6788ba8aed4e28e90f72d68a9d794e34eac17295  wifi: brcmfmac: Fix potential buffer overflow in brcmf_fweh_event_worker()

elapsed time: 721m

configs tested: 148
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
arc                                 defconfig
s390                             allmodconfig
alpha                               defconfig
x86_64                          rhel-8.3-func
x86_64                    rhel-8.3-kselftests
s390                                defconfig
s390                             allyesconfig
arm64                            allyesconfig
arm                                 defconfig
arm                              allyesconfig
ia64                             allmodconfig
x86_64               randconfig-k001-20221031
i386                             allyesconfig
i386                                defconfig
mips                           jazz_defconfig
arm                           tegra_defconfig
mips                 decstation_r4k_defconfig
arm                          lpd270_defconfig
x86_64               randconfig-a016-20221031
x86_64               randconfig-a011-20221031
x86_64               randconfig-a013-20221031
x86_64               randconfig-a012-20221031
x86_64               randconfig-a014-20221031
x86_64               randconfig-a015-20221031
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
sh                               allmodconfig
sparc                             allnoconfig
xtensa                    smp_lx200_defconfig
arm                          gemini_defconfig
sh                 kfr2r09-romimage_defconfig
xtensa                       common_defconfig
i386                 randconfig-a016-20221031
i386                 randconfig-a012-20221031
i386                 randconfig-a015-20221031
i386                 randconfig-a013-20221031
i386                 randconfig-a014-20221031
i386                 randconfig-a011-20221031
sh                          rsk7203_defconfig
m68k                       bvme6000_defconfig
arm                           viper_defconfig
arm                        mini2440_defconfig
powerpc                      mgcoge_defconfig
powerpc                 mpc834x_itx_defconfig
mips                       bmips_be_defconfig
arm                         lubbock_defconfig
powerpc                      chrp32_defconfig
m68k                                defconfig
arm                            mps2_defconfig
i386                 randconfig-c001-20221031
mips                 randconfig-c004-20221031
sh                              ul2_defconfig
powerpc                 mpc8540_ads_defconfig
openrisc                       virt_defconfig
powerpc                 canyonlands_defconfig
i386                          randconfig-c001
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
loongarch                           defconfig
loongarch                         allnoconfig
loongarch                        allmodconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
arm64                            alldefconfig
powerpc                 linkstation_defconfig
m68k                        stmark2_defconfig
arm                      footbridge_defconfig
powerpc                     taishan_defconfig
sh                  sh7785lcr_32bit_defconfig
alpha                             allnoconfig
um                                  defconfig
arm                         s3c6400_defconfig
m68k                       m5249evb_defconfig
arm                            qcom_defconfig
s390                 randconfig-r044-20221031
riscv                randconfig-r042-20221031
arc                  randconfig-r043-20221031
powerpc                      arches_defconfig
powerpc                    klondike_defconfig
openrisc                            defconfig
mips                    maltaup_xpa_defconfig
arc                      axs103_smp_defconfig
arm                       omap2plus_defconfig
arm                          iop32x_defconfig
riscv                    nommu_k210_defconfig
sh                        sh7757lcr_defconfig
openrisc                    or1ksim_defconfig
powerpc                     stx_gp3_defconfig
ia64                        generic_defconfig
sh                      rts7751r2d1_defconfig
arm                             ezx_defconfig
arm                           sama5_defconfig
ia64                            zx1_defconfig
nios2                            allyesconfig
nios2                               defconfig
parisc64                            defconfig
parisc                           allyesconfig
mips                         db1xxx_defconfig
mips                            ar7_defconfig
sh                     sh7710voipgw_defconfig
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func

clang tested configs:
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
riscv                randconfig-r042-20221101
hexagon              randconfig-r041-20221101
hexagon              randconfig-r045-20221101
s390                 randconfig-r044-20221101
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64               randconfig-a005-20221031
x86_64               randconfig-a006-20221031
x86_64               randconfig-a004-20221031
x86_64               randconfig-a001-20221031
x86_64               randconfig-a003-20221031
x86_64               randconfig-a002-20221031
powerpc                   bluestone_defconfig
arm                        magician_defconfig
arm                        vexpress_defconfig
powerpc                       ebony_defconfig
powerpc                      obs600_defconfig
mips                        qi_lb60_defconfig
arm                      pxa255-idp_defconfig
mips                      bmips_stb_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
