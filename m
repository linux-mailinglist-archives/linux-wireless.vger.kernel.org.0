Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCC1F5397FC
	for <lists+linux-wireless@lfdr.de>; Tue, 31 May 2022 22:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347754AbiEaUda (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 31 May 2022 16:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347751AbiEaUd2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 31 May 2022 16:33:28 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0BDF8DDD2
        for <linux-wireless@vger.kernel.org>; Tue, 31 May 2022 13:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654029207; x=1685565207;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=oLhRWt5/RvAT0daoMeS58JDv3UZIbA8x2lPxu/uVsTE=;
  b=DDjTw86ejeRogR4BbwwflrDRKWQLvwm3uIpd0l6jyWpy8chQfjzzsGic
   KGr7b318rpp8NjLDy9iCKHnRj3E1NVVQAsasan6D9v/XOjGiDK+2p5qwL
   3vk548p5b6MNIO++398g794fl+H+3oONgvW+EqfljS3NR/YZRamQHt+sj
   sxXepyKPn6qvlDjbUO+E/bPzXN6PiVRp67x4UphvV3X6inhFNG5KLrHSt
   7DhjjKmkiyJSAL5NiLOYw5FMiSP5N8cEZ30TplHSWdn0cTf157HtuQwOF
   +bXl15iLwMu2Bbnxfw3o4vit4EW+Q2Gk6Fb87fYmmJrNcnib+7Bs9SDPQ
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10364"; a="263012325"
X-IronPort-AV: E=Sophos;i="5.91,266,1647327600"; 
   d="scan'208";a="263012325"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2022 13:33:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,266,1647327600"; 
   d="scan'208";a="904139528"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 31 May 2022 13:33:25 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nw8YO-000333-Jk;
        Tue, 31 May 2022 20:33:24 +0000
Date:   Wed, 01 Jun 2022 04:33:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johannes Berg <johannes.berg@intel.com>
Cc:     linux-wireless@vger.kernel.org, Kalle Valo <kvalo@kernel.org>
Subject: [wireless-next:mld] BUILD SUCCESS
 252b352055a7d66f2c83d7abfe999d34c2dfb1f6
Message-ID: <62967b8a.uOH0Cncr50NnvvRh%lkp@intel.com>
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

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git mld
branch HEAD: 252b352055a7d66f2c83d7abfe999d34c2dfb1f6  mac80211: correct link config data in tracing

elapsed time: 728m

configs tested: 144
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
sh                  sh7785lcr_32bit_defconfig
arm64                            alldefconfig
sh                   sh7770_generic_defconfig
sh                          lboxre2_defconfig
sh                        sh7763rdp_defconfig
powerpc                      pcm030_defconfig
xtensa                  cadence_csp_defconfig
m68k                             allmodconfig
arm                        realview_defconfig
arm                        mvebu_v7_defconfig
arm                        spear6xx_defconfig
powerpc                     pq2fads_defconfig
openrisc                 simple_smp_defconfig
powerpc                     tqm8555_defconfig
sh                     magicpanelr2_defconfig
m68k                       bvme6000_defconfig
arm                          badge4_defconfig
arc                                 defconfig
xtensa                  nommu_kc705_defconfig
arm                            zeus_defconfig
alpha                            alldefconfig
sparc                       sparc32_defconfig
parisc64                         alldefconfig
arc                           tb10x_defconfig
sh                          sdk7786_defconfig
powerpc                     stx_gp3_defconfig
powerpc                      mgcoge_defconfig
parisc                           alldefconfig
h8300                               defconfig
ia64                         bigsur_defconfig
sh                        dreamcast_defconfig
parisc                generic-64bit_defconfig
arm                        clps711x_defconfig
h8300                            alldefconfig
powerpc                 mpc8540_ads_defconfig
mips                       bmips_be_defconfig
h8300                            allyesconfig
sh                          r7780mp_defconfig
microblaze                          defconfig
sh                          rsk7269_defconfig
powerpc                 linkstation_defconfig
ia64                                defconfig
ia64                             allmodconfig
ia64                             allyesconfig
riscv                             allnoconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
csky                                defconfig
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
sh                               allmodconfig
s390                                defconfig
s390                             allmodconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                             allyesconfig
sparc                               defconfig
i386                             allyesconfig
sparc                            allyesconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
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
arc                  randconfig-r043-20220531
s390                 randconfig-r044-20220531
riscv                randconfig-r042-20220531
riscv                            allyesconfig
riscv                            allmodconfig
riscv                    nommu_k210_defconfig
riscv                          rv32_defconfig
riscv                    nommu_virt_defconfig
riscv                               defconfig
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                                  kexec
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit

clang tested configs:
mips                 randconfig-c004-20220531
x86_64                        randconfig-c007
i386                          randconfig-c001
s390                 randconfig-c005-20220531
arm                  randconfig-c002-20220531
powerpc              randconfig-c003-20220531
riscv                randconfig-c006-20220531
arm                            mmp2_defconfig
mips                       rbtx49xx_defconfig
powerpc                     mpc512x_defconfig
arm                             mxs_defconfig
mips                      maltaaprp_defconfig
powerpc                     tqm5200_defconfig
powerpc                     akebono_defconfig
powerpc                   lite5200b_defconfig
arm                   milbeaut_m10v_defconfig
arm                           sama7_defconfig
arm                         shannon_defconfig
mips                malta_qemu_32r6_defconfig
powerpc                     skiroot_defconfig
powerpc                    ge_imp3a_defconfig
mips                         tb0287_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a004
i386                          randconfig-a006
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a011
i386                          randconfig-a013
i386                          randconfig-a015
hexagon              randconfig-r041-20220531
hexagon              randconfig-r045-20220531

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
