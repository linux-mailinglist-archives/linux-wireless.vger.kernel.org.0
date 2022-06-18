Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3472A550514
	for <lists+linux-wireless@lfdr.de>; Sat, 18 Jun 2022 15:24:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232991AbiFRNYW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 18 Jun 2022 09:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbiFRNYU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 18 Jun 2022 09:24:20 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52A0C140EB
        for <linux-wireless@vger.kernel.org>; Sat, 18 Jun 2022 06:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655558659; x=1687094659;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=QRcmzrl0xbtW9syDDihDfx60f4sMTmHqIXxikZsrqB8=;
  b=hmo0liTMAwV6H1JxAxQG+VKg3FGgkYRgZ3I0s/4BLsyE/Qkpk29T2qva
   GO04I/huysMtJRIvJg24GvJ/fJQ1hqsOYEApe2525LoB/vaEjaSgUlPau
   P0uEhWe0R2P6fJq99rQVN7+6cBd2boOqWWwKAt2L+nwPnyse7yBG5G423
   aYzMz7IpbGtmL15UBetQnlHAWvCWQiqdWs5ZbUyrl63huk/kUnzLvwDX9
   oyP9XeROqc/CImBodS/T7rAWntMb7JhA9oqnSSAHqZFS6pdBGZ5GPjCdu
   Pu2FYrp4Lt7Sg0lpR3F5dJ5PxygehKLzBToFp6Vgj13w0w07m60fCMz9C
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="278428490"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="278428490"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2022 06:24:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="642412437"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 18 Jun 2022 06:24:17 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o2YQz-000QKp-8S;
        Sat, 18 Jun 2022 13:24:17 +0000
Date:   Sat, 18 Jun 2022 21:23:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johannes Berg <johannes.berg@intel.com>
Cc:     linux-wireless@vger.kernel.org, Kalle Valo <kvalo@kernel.org>
Subject: [wireless-next:mld] BUILD SUCCESS
 666397bf2946bddf197060c50a2b88a7e8dd7865
Message-ID: <62add1e2.zmryWIp0P+f6f9/7%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git mld
branch HEAD: 666397bf2946bddf197060c50a2b88a7e8dd7865  wifi: mac80211_hwsim: print the link id

elapsed time: 1502m

configs tested: 156
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm                              allyesconfig
i386                          randconfig-c001
s390                       zfcpdump_defconfig
sh                           se7751_defconfig
sh                            migor_defconfig
mips                            gpr_defconfig
powerpc                    adder875_defconfig
sh                           se7724_defconfig
powerpc                         ps3_defconfig
sh                          r7780mp_defconfig
sh                           sh2007_defconfig
sh                   rts7751r2dplus_defconfig
m68k                       m5475evb_defconfig
powerpc                     tqm8548_defconfig
mips                             allyesconfig
powerpc                 mpc8540_ads_defconfig
arm                        spear6xx_defconfig
m68k                          amiga_defconfig
arm                         at91_dt_defconfig
arc                           tb10x_defconfig
arm                        cerfcube_defconfig
powerpc                        cell_defconfig
sh                          sdk7780_defconfig
mips                    maltaup_xpa_defconfig
sh                            titan_defconfig
mips                           ip32_defconfig
xtensa                              defconfig
um                             i386_defconfig
xtensa                         virt_defconfig
powerpc                     pq2fads_defconfig
m68k                            mac_defconfig
mips                           xway_defconfig
m68k                        mvme147_defconfig
powerpc                       maple_defconfig
arc                        vdk_hs38_defconfig
powerpc                      ep88xc_defconfig
parisc64                         alldefconfig
powerpc                      ppc40x_defconfig
sh                            hp6xx_defconfig
xtensa                  nommu_kc705_defconfig
mips                             allmodconfig
xtensa                  audio_kc705_defconfig
arm                            zeus_defconfig
arc                    vdk_hs38_smp_defconfig
sparc64                          alldefconfig
powerpc                       holly_defconfig
powerpc                     tqm8541_defconfig
m68k                          multi_defconfig
m68k                       m5249evb_defconfig
sparc64                             defconfig
ia64                         bigsur_defconfig
arm                       aspeed_g5_defconfig
powerpc                     rainier_defconfig
m68k                          hp300_defconfig
sh                          landisk_defconfig
sh                        edosk7760_defconfig
m68k                         amcore_defconfig
mips                      maltasmvp_defconfig
arc                        nsimosci_defconfig
sh                             shx3_defconfig
csky                             alldefconfig
mips                         tb0226_defconfig
m68k                       m5208evb_defconfig
sh                   sh7724_generic_defconfig
sh                              ul2_defconfig
arm                        realview_defconfig
riscv             nommu_k210_sdcard_defconfig
x86_64                        randconfig-c001
arm                  randconfig-c002-20220617
ia64                                defconfig
riscv                             allnoconfig
m68k                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
nios2                               defconfig
arc                              allyesconfig
csky                                defconfig
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
arc                                 defconfig
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
powerpc                          allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
x86_64                        randconfig-a006
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a011
x86_64                        randconfig-a013
x86_64                        randconfig-a015
i386                          randconfig-a012
i386                          randconfig-a014
i386                          randconfig-a016
riscv                randconfig-r042-20220617
arc                  randconfig-r043-20220617
s390                 randconfig-r044-20220617
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                            allmodconfig
riscv                            allyesconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
x86_64                                  kexec
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit

clang tested configs:
arm                           sama7_defconfig
mips                      malta_kvm_defconfig
arm                       spear13xx_defconfig
arm                      pxa255-idp_defconfig
riscv                             allnoconfig
arm                          collie_defconfig
powerpc                       ebony_defconfig
arm                             mxs_defconfig
arm                         s3c2410_defconfig
arm                            mmp2_defconfig
powerpc                     mpc512x_defconfig
mips                      bmips_stb_defconfig
powerpc                 mpc8313_rdb_defconfig
powerpc                          allmodconfig
powerpc                        icon_defconfig
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
hexagon              randconfig-r045-20220617

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
