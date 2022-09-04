Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0250B5AC21F
	for <lists+linux-wireless@lfdr.de>; Sun,  4 Sep 2022 05:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbiIDDBb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 3 Sep 2022 23:01:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbiIDDB2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 3 Sep 2022 23:01:28 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8CC54BA59
        for <linux-wireless@vger.kernel.org>; Sat,  3 Sep 2022 20:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662260487; x=1693796487;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=mukoPoxiOvKRM474oDwIKqV6hAAT5Pq5JGuuA9i1jmE=;
  b=KIjNBCQc/19woeKfHbafF/RxYcU+3M+64E1N1NgUb/8afBuoO/ffrqZ8
   iW50zzLgFiBjIjjona617S5TLgsYCacPMUritjkXxHWwMz8FQGMv4bpF8
   WlJIHookL245ujkI/SuFksvx7spSt3ccOBJe+KxFp2a2q6UblypIxpiSf
   vZFF3ry6gLw8xnyo8vwxrS9nK05QzGsFmR7Rqx4DfP3kCkYciDY60yQZT
   fqujRgC8M98Jv+MVcQtbyc6LKZY+aRj/pGQQlVmnsfi3nV4rMedO3oRhQ
   Nzw27IhRbtQzSGWGf7a3BcV9wKZf6TDXzVn5xG4AK1TPLYuwvXBJBWURm
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10459"; a="297503919"
X-IronPort-AV: E=Sophos;i="5.93,288,1654585200"; 
   d="scan'208";a="297503919"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2022 20:01:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,288,1654585200"; 
   d="scan'208";a="643390240"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 03 Sep 2022 20:01:25 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oUfsz-0002Tz-0N;
        Sun, 04 Sep 2022 03:01:25 +0000
Date:   Sun, 04 Sep 2022 11:00:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johannes Berg <johannes.berg@intel.com>
Cc:     linux-wireless@vger.kernel.org, Kalle Valo <kvalo@kernel.org>
Subject: [wireless:for-next] BUILD SUCCESS
 2aec909912da55a6e469fd6ee8412080a5433ed2
Message-ID: <631414d5.h9cVq8Ys3J4sWMDA%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git for-next
branch HEAD: 2aec909912da55a6e469fd6ee8412080a5433ed2  wifi: use struct_group to copy addresses

elapsed time: 722m

configs tested: 113
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                        randconfig-a015
i386                          randconfig-a005
i386                                defconfig
arm                                 defconfig
csky                              allnoconfig
i386                          randconfig-a001
arc                               allnoconfig
x86_64                              defconfig
i386                          randconfig-a016
x86_64                        randconfig-a006
x86_64                          rhel-8.3-func
x86_64                        randconfig-a004
x86_64                        randconfig-a002
alpha                             allnoconfig
riscv                             allnoconfig
arc                  randconfig-r043-20220901
m68k                             allyesconfig
x86_64                    rhel-8.3-kselftests
i386                          randconfig-a003
i386                          randconfig-a014
i386                          randconfig-a012
arc                  randconfig-r043-20220903
x86_64                           rhel-8.3-kvm
arm                      integrator_defconfig
powerpc                          allmodconfig
sh                           se7722_defconfig
arm                           u8500_defconfig
arm                              allyesconfig
sh                               allmodconfig
x86_64                        randconfig-a013
m68k                             allmodconfig
parisc64                         alldefconfig
mips                             allyesconfig
powerpc                           allnoconfig
arm64                            allyesconfig
xtensa                  nommu_kc705_defconfig
x86_64                               rhel-8.3
x86_64                        randconfig-a011
x86_64                         rhel-8.3-kunit
arc                              allyesconfig
sh                            shmin_defconfig
ia64                             allmodconfig
parisc64                            defconfig
i386                             allyesconfig
ia64                      gensparse_defconfig
m68k                       m5475evb_defconfig
arm                             rpc_defconfig
mips                      fuloong2e_defconfig
x86_64                           allyesconfig
sparc64                          alldefconfig
arc                         haps_hs_defconfig
x86_64                           rhel-8.3-syz
arc                        nsimosci_defconfig
arm                         assabet_defconfig
sh                        dreamcast_defconfig
sh                           se7206_defconfig
mips                        bcm47xx_defconfig
m68k                          atari_defconfig
arm                          gemini_defconfig
mips                         bigsur_defconfig
sh                           se7780_defconfig
s390                       zfcpdump_defconfig
arm                           tegra_defconfig
mips                  decstation_64_defconfig
i386                          randconfig-c001
alpha                            allyesconfig
arm                         vf610m4_defconfig
loongarch                 loongson3_defconfig
powerpc                         wii_defconfig
microblaze                          defconfig
sh                          r7785rp_defconfig
arc                      axs103_smp_defconfig
loongarch                           defconfig
loongarch                         allnoconfig
mips                       bmips_be_defconfig
sh                           se7619_defconfig
sh                        edosk7705_defconfig

clang tested configs:
riscv                randconfig-r042-20220903
s390                 randconfig-r044-20220903
hexagon              randconfig-r045-20220903
i386                          randconfig-a004
x86_64                        randconfig-a016
hexagon              randconfig-r041-20220903
arm                         mv78xx0_defconfig
hexagon              randconfig-r041-20220901
x86_64                        randconfig-a001
i386                          randconfig-a011
i386                          randconfig-a002
hexagon              randconfig-r045-20220901
x86_64                        randconfig-a005
i386                          randconfig-a013
riscv                randconfig-r042-20220901
x86_64                        randconfig-a003
s390                 randconfig-r044-20220901
i386                          randconfig-a006
powerpc                   microwatt_defconfig
i386                          randconfig-a015
x86_64                        randconfig-a012
mips                          rm200_defconfig
x86_64                        randconfig-a014
arm                   milbeaut_m10v_defconfig
riscv                          rv32_defconfig
arm                           sama7_defconfig
arm                          moxart_defconfig
powerpc                 mpc8315_rdb_defconfig
mips                      malta_kvm_defconfig
mips                      bmips_stb_defconfig
mips                     loongson2k_defconfig
powerpc                 mpc836x_rdk_defconfig
x86_64                        randconfig-k001
arm                         s3c2410_defconfig

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
