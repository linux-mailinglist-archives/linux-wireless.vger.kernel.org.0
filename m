Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C7905AC247
	for <lists+linux-wireless@lfdr.de>; Sun,  4 Sep 2022 06:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232199AbiIDERi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 4 Sep 2022 00:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbiIDERe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 4 Sep 2022 00:17:34 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 461AF4B4B1
        for <linux-wireless@vger.kernel.org>; Sat,  3 Sep 2022 21:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662265053; x=1693801053;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=RSWivm1ACjkXyyZzKOsg4ebnb4bHCOFdmVU8vvTUB0s=;
  b=e+pmRMNkpny0Qhe7gAfCuPcWT0b69DL88RjUUTAUOWgg2QVfB1L7zqVL
   7EC2dnUvZE0usZo+e8WoiZHoeXgYIh9D5WuoaQUTBar1adt043w8Sxpsx
   h3a9NLcLhVb5zCIIjDorC/a+q2AkNT+O+nlCP4+FB36cTrt6OoMzhe3W5
   aJ614oaEdv0ubpNLD+LUtXDzC7s/h9+RMjHmG2oHTCdWEBiFToGgHdLYf
   WgqNI6n+yo5qH9udiJN2s53EkJkVE4Z7cw+VOk2U58rtM23OniZ7tYCr4
   q6ewxt/VRukBzh/DyN5bDuOMIQf2PIinOxSxOxbtz01REqul0m9ArwXtD
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10459"; a="322373817"
X-IronPort-AV: E=Sophos;i="5.93,288,1654585200"; 
   d="scan'208";a="322373817"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2022 21:17:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,288,1654585200"; 
   d="scan'208";a="643402963"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 03 Sep 2022 21:17:31 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oUh4c-0002Y9-23;
        Sun, 04 Sep 2022 04:17:30 +0000
Date:   Sun, 04 Sep 2022 12:16:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johannes Berg <johannes.berg@intel.com>
Cc:     linux-wireless@vger.kernel.org, Kalle Valo <kvalo@kernel.org>
Subject: [wireless-next:main] BUILD SUCCESS
 c087f9fcd0fb53422a9a6c865dbf7dc89b6aecdb
Message-ID: <631426a7.tthGXa1ciwJUZqdB%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: c087f9fcd0fb53422a9a6c865dbf7dc89b6aecdb  wifi: mac80211_hwsim: fix multi-channel handling in netlink RX

elapsed time: 721m

configs tested: 99
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                           x86_64_defconfig
um                             i386_defconfig
i386                                defconfig
x86_64                        randconfig-a015
x86_64                              defconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a013
x86_64                        randconfig-a011
arc                  randconfig-r043-20220904
i386                          randconfig-a001
csky                              allnoconfig
arc                               allnoconfig
i386                          randconfig-a003
x86_64                        randconfig-a002
x86_64                               rhel-8.3
m68k                             allmodconfig
sh                               allmodconfig
i386                          randconfig-a005
x86_64                           rhel-8.3-syz
x86_64                           allyesconfig
sh                           se7619_defconfig
arc                              allyesconfig
alpha                             allnoconfig
x86_64                        randconfig-a004
riscv                             allnoconfig
alpha                            allyesconfig
arm                                 defconfig
riscv                randconfig-r042-20220904
s390                 randconfig-r044-20220904
i386                          randconfig-a014
m68k                             allyesconfig
i386                          randconfig-a016
i386                             allyesconfig
microblaze                      mmu_defconfig
arm                     eseries_pxa_defconfig
sh                        edosk7705_defconfig
arc                  randconfig-r043-20220901
i386                          randconfig-a012
x86_64                          rhel-8.3-func
arm                              allyesconfig
x86_64                         rhel-8.3-kunit
mips                       bmips_be_defconfig
arm                         assabet_defconfig
x86_64                           rhel-8.3-kvm
x86_64                    rhel-8.3-kselftests
sh                          sdk7780_defconfig
ia64                             allmodconfig
arc                  randconfig-r043-20220903
arm64                            allyesconfig
m68k                             alldefconfig
mips                      fuloong2e_defconfig
mips                  decstation_64_defconfig
arm                        keystone_defconfig
arm                      integrator_defconfig
parisc64                         alldefconfig
sh                            shmin_defconfig
ia64                      gensparse_defconfig
arm                          gemini_defconfig
i386                          randconfig-c001
powerpc                           allnoconfig
mips                             allyesconfig
powerpc                          allmodconfig
powerpc              randconfig-c003-20220904
arc                         haps_hs_defconfig
mips                        bcm47xx_defconfig
s390                       zfcpdump_defconfig

clang tested configs:
x86_64                        randconfig-a014
x86_64                        randconfig-a005
x86_64                        randconfig-a012
hexagon              randconfig-r045-20220904
riscv                randconfig-r042-20220901
i386                          randconfig-a002
hexagon              randconfig-r045-20220903
i386                          randconfig-a004
x86_64                        randconfig-a001
i386                          randconfig-a006
hexagon              randconfig-r041-20220904
x86_64                        randconfig-a003
x86_64                        randconfig-a016
i386                          randconfig-a013
s390                 randconfig-r044-20220901
s390                 randconfig-r044-20220903
i386                          randconfig-a011
powerpc                     ppa8548_defconfig
hexagon              randconfig-r041-20220901
riscv                randconfig-r042-20220903
hexagon              randconfig-r041-20220903
i386                          randconfig-a015
arm                         orion5x_defconfig
powerpc                          g5_defconfig
arm                           sama7_defconfig
hexagon              randconfig-r045-20220901
powerpc                      ppc64e_defconfig
riscv                          rv32_defconfig
arm                          moxart_defconfig
powerpc                 mpc8315_rdb_defconfig
mips                          rm200_defconfig
x86_64                        randconfig-k001
mips                      malta_kvm_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
