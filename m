Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97FD64FB149
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Apr 2022 03:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239106AbiDKBRv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 10 Apr 2022 21:17:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234340AbiDKBRt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 10 Apr 2022 21:17:49 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CB4C28E
        for <linux-wireless@vger.kernel.org>; Sun, 10 Apr 2022 18:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649639737; x=1681175737;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=M2xbCo88OJmbP01kH0splXe0Lgk0FIWfL1GZXFRGoPs=;
  b=S47nUhi8U+Y47NenmyUb8NHH/NXqjnvPeg0DiH2YPDwFHAlu4TpOdzMo
   BzNdgXXeLXaQBCkomCM2tIcW/KPsbDUq2dSD5O1RI+oPKnq75LUlzj6JP
   MPxJsS8/mIWug7we+3KeD0FIqG07SWHdoz/33oMNXlXW5NewwF3KjcvfR
   Nat+wKOuVAh6OxV8wu90iLP9dWAMW8h0XBmqaPyXndxxbE6kio6Tu1HgE
   LCEQaQ706Fa58HGDHD/J1Tfw4pIkD0gKGHJU9bEpMXWsDsszMqzdewG9i
   EZwOlWFB/evIIQgc7W8X16XrIE8WfkRXh4tLZgEjPO7YpfrqnpUi8yyHJ
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10313"; a="241944580"
X-IronPort-AV: E=Sophos;i="5.90,250,1643702400"; 
   d="scan'208";a="241944580"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2022 18:15:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,250,1643702400"; 
   d="scan'208";a="723758265"
Received: from lkp-server02.sh.intel.com (HELO d3fc50ef50de) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 10 Apr 2022 18:15:35 -0700
Received: from kbuild by d3fc50ef50de with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ndieU-0001Dr-Hu;
        Mon, 11 Apr 2022 01:15:34 +0000
Date:   Mon, 11 Apr 2022 09:14:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>
Subject: [wireless:main] BUILD SUCCESS
 5a6b06f5927c940fa44026695779c30b7536474c
Message-ID: <625380f7.ju3k/Tpmgd0w8cSY%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git main
branch HEAD: 5a6b06f5927c940fa44026695779c30b7536474c  ath9k: Fix usage of driver-private space in tx_info

elapsed time: 720m

configs tested: 174
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm                              allyesconfig
powerpc              randconfig-c003-20220410
i386                          randconfig-c001
m68k                             allyesconfig
sh                          landisk_defconfig
sh                         ap325rxa_defconfig
parisc                generic-32bit_defconfig
powerpc                 canyonlands_defconfig
arc                        nsimosci_defconfig
arm                        realview_defconfig
m68k                       bvme6000_defconfig
sh                        edosk7705_defconfig
xtensa                         virt_defconfig
powerpc                     taishan_defconfig
powerpc                 mpc8540_ads_defconfig
powerpc                   currituck_defconfig
nios2                            alldefconfig
powerpc                 mpc834x_mds_defconfig
arc                     nsimosci_hs_defconfig
sh                          r7780mp_defconfig
sh                            migor_defconfig
powerpc                      ppc40x_defconfig
powerpc                 mpc85xx_cds_defconfig
arm                            zeus_defconfig
x86_64                              defconfig
sparc                               defconfig
xtensa                  audio_kc705_defconfig
powerpc                           allnoconfig
powerpc                      tqm8xx_defconfig
mips                             allmodconfig
m68k                         apollo_defconfig
sparc                       sparc64_defconfig
arm                        oxnas_v6_defconfig
sh                   sh7724_generic_defconfig
arm                           h3600_defconfig
arm                       multi_v4t_defconfig
arm                          pxa910_defconfig
mips                            gpr_defconfig
sh                          sdk7786_defconfig
arm                            xcep_defconfig
openrisc                         alldefconfig
m68k                        m5307c3_defconfig
powerpc                     tqm8541_defconfig
mips                       capcella_defconfig
nios2                               defconfig
m68k                        mvme16x_defconfig
xtensa                          iss_defconfig
mips                  maltasmvp_eva_defconfig
m68k                       m5249evb_defconfig
xtensa                              defconfig
sh                         ecovec24_defconfig
h8300                            allyesconfig
m68k                       m5275evb_defconfig
powerpc                mpc7448_hpc2_defconfig
mips                             allyesconfig
sh                            hp6xx_defconfig
arm                  randconfig-c002-20220411
arm                  randconfig-c002-20220410
i386                 randconfig-c001-20220411
x86_64               randconfig-c001-20220411
x86_64                        randconfig-c001
ia64                             allmodconfig
ia64                             allyesconfig
ia64                                defconfig
m68k                             allmodconfig
m68k                                defconfig
csky                                defconfig
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
xtensa                           allyesconfig
s390                                defconfig
s390                             allmodconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                             allyesconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
i386                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
arc                              allyesconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
i386                          randconfig-a001
i386                          randconfig-a003
i386                          randconfig-a005
i386                          randconfig-a012
i386                          randconfig-a016
i386                          randconfig-a014
i386                 randconfig-a015-20220411
i386                 randconfig-a011-20220411
i386                 randconfig-a016-20220411
i386                 randconfig-a012-20220411
i386                 randconfig-a013-20220411
i386                 randconfig-a014-20220411
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
arc                  randconfig-r043-20220410
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
riscv                    nommu_k210_defconfig
riscv                             allnoconfig
riscv                            allmodconfig
riscv                            allyesconfig
x86_64                    rhel-8.3-kselftests
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                          rhel-8.3-func
x86_64                                  kexec
x86_64                           allyesconfig
x86_64                         rhel-8.3-kunit
x86_64                               rhel-8.3

clang tested configs:
x86_64                        randconfig-c007
powerpc              randconfig-c003-20220410
arm                  randconfig-c002-20220410
i386                          randconfig-c001
riscv                randconfig-c006-20220410
mips                 randconfig-c004-20220410
powerpc                 mpc8313_rdb_defconfig
powerpc                     kmeter1_defconfig
powerpc                      acadia_defconfig
arm                             mxs_defconfig
mips                        qi_lb60_defconfig
arm                          imote2_defconfig
s390                             alldefconfig
arm                       netwinder_defconfig
arm                      pxa255-idp_defconfig
mips                         tb0219_defconfig
mips                      bmips_stb_defconfig
mips                         tb0287_defconfig
mips                           ip22_defconfig
mips                          rm200_defconfig
arm                       imx_v4_v5_defconfig
arm                          moxart_defconfig
mips                   sb1250_swarm_defconfig
mips                          malta_defconfig
powerpc                 mpc8272_ads_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                 randconfig-a004-20220411
i386                 randconfig-a001-20220411
i386                 randconfig-a003-20220411
i386                 randconfig-a005-20220411
i386                 randconfig-a006-20220411
i386                 randconfig-a002-20220411
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64               randconfig-a003-20220411
x86_64               randconfig-a004-20220411
x86_64               randconfig-a006-20220411
x86_64               randconfig-a001-20220411
x86_64               randconfig-a002-20220411
x86_64               randconfig-a005-20220411
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
riscv                randconfig-r042-20220410
hexagon              randconfig-r041-20220410
hexagon              randconfig-r045-20220410
hexagon              randconfig-r041-20220411
hexagon              randconfig-r045-20220411
s390                 randconfig-r044-20220410

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
