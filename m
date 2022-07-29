Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E825584946
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Jul 2022 03:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233387AbiG2BNG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 Jul 2022 21:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiG2BNF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 Jul 2022 21:13:05 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B37FC48C9A
        for <linux-wireless@vger.kernel.org>; Thu, 28 Jul 2022 18:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659057184; x=1690593184;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=q9eN3XW4375ROb2R2uUA4R2OlD6uIBt67vwZBKgXDHk=;
  b=I9bAebtZqNaHvIVyqwPFqOcJvlT3cIGaxZoySphw4RXPdEFIVJuyIfXF
   2vvRNGe77QqPM/KJDBJrgVDcumiHYl6cul8NZJTMCmGq/EoUWP1uzQ7Ov
   PX8G0J9qgRf1cPYvHbc8ch5yAGb35aAt/xAYrZk3xbTrKII+40RpjPn5j
   VwTiNcwc1w1jaBIqsOr4cPnCVY/wNrTVMXJkQcXhLlFmfCI7Q8+j1VG1b
   3JiGz3R9ugDExP2/N54H4uMLRGyGk5YI176bAMaUKOzmSo4SErt3bi8w5
   w9lB9tSJZ1vfyxR73U5SPFyqOPol8FoBbaWvStgpULdhZ8vzO9ntfVFZ8
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10422"; a="288676348"
X-IronPort-AV: E=Sophos;i="5.93,199,1654585200"; 
   d="scan'208";a="288676348"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2022 18:13:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,199,1654585200"; 
   d="scan'208";a="551559149"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 28 Jul 2022 18:13:02 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oHEYo-000ApR-0X;
        Fri, 29 Jul 2022 01:13:02 +0000
Date:   Fri, 29 Jul 2022 09:12:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>
Subject: [wireless-next:main] BUILD SUCCESS
 cb774bd35318c1b4cb61f6f2caac85537d07fbde
Message-ID: <62e33415.8c+JlJ49IPE/iADo%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: cb774bd35318c1b4cb61f6f2caac85537d07fbde  wifi: brcmfmac: prevent double-free on hardware-reset

elapsed time: 885m

configs tested: 99
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
x86_64                        randconfig-a015
x86_64                        randconfig-a013
x86_64                        randconfig-a011
um                             i386_defconfig
um                           x86_64_defconfig
arc                  randconfig-r043-20220728
riscv                randconfig-r042-20220728
powerpc                          allmodconfig
i386                          randconfig-a001
mips                             allyesconfig
s390                 randconfig-r044-20220728
powerpc                           allnoconfig
i386                                defconfig
i386                          randconfig-a003
i386                          randconfig-a005
i386                          randconfig-a014
x86_64                           rhel-8.3-syz
arm                                 defconfig
x86_64                        randconfig-a002
i386                          randconfig-a016
arm                              allyesconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
arm64                            allyesconfig
i386                          randconfig-a012
ia64                             allmodconfig
sh                               allmodconfig
i386                             allyesconfig
x86_64                         rhel-8.3-kunit
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-kvm
x86_64                    rhel-8.3-kselftests
csky                              allnoconfig
alpha                             allnoconfig
arc                               allnoconfig
riscv                             allnoconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
m68k                             allyesconfig
m68k                             allmodconfig
arc                              allyesconfig
alpha                            allyesconfig
s390                       zfcpdump_defconfig
openrisc                         alldefconfig
i386                          randconfig-c001
ia64                        generic_defconfig
sh                           se7343_defconfig
arm                            mps2_defconfig
openrisc                    or1ksim_defconfig
xtensa                  cadence_csp_defconfig
mips                           ip32_defconfig
arc                            hsdk_defconfig
sh                 kfr2r09-romimage_defconfig
sh                     sh7710voipgw_defconfig
loongarch                           defconfig
loongarch                         allnoconfig
m68k                        m5407c3_defconfig
powerpc                     taishan_defconfig
sh                         ap325rxa_defconfig
powerpc                      tqm8xx_defconfig
arm                          lpd270_defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
i386                          debian-10.3-kvm
i386                        debian-10.3-kunit
i386                         debian-10.3-func
mips                 randconfig-c004-20220728
powerpc              randconfig-c003-20220728
nios2                               defconfig
m68k                            mac_defconfig

clang tested configs:
x86_64                        randconfig-a014
x86_64                        randconfig-a012
x86_64                        randconfig-a016
hexagon              randconfig-r045-20220728
hexagon              randconfig-r041-20220728
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a001
i386                          randconfig-a015
x86_64                        randconfig-a003
x86_64                        randconfig-a005
i386                          randconfig-a013
i386                          randconfig-a011
powerpc                 mpc836x_mds_defconfig
riscv                             allnoconfig
x86_64                        randconfig-k001
powerpc                     tqm5200_defconfig
powerpc                        fsp2_defconfig
powerpc                      katmai_defconfig
powerpc                   microwatt_defconfig
powerpc                      ppc64e_defconfig
mips                          rm200_defconfig
arm                  colibri_pxa270_defconfig
arm                      pxa255-idp_defconfig
powerpc                  mpc885_ads_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
