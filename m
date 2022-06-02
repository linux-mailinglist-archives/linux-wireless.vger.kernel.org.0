Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5049453C12C
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jun 2022 00:59:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239869AbiFBW5D (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 2 Jun 2022 18:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239850AbiFBW46 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 2 Jun 2022 18:56:58 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E70FAE69
        for <linux-wireless@vger.kernel.org>; Thu,  2 Jun 2022 15:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654210617; x=1685746617;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=PPLv9QhoW0T3g2nwPVWQnyfi5p+duLgG+vDbvU9uCyM=;
  b=EBjBJDKhHPgz+gP8wQCqZS/E/30Mkw5xgI1u12Azmfdg/rMNgHJurKnH
   wY/3R56faIw7PUEBeCzIICbheaR3Si1nISsXn9M0lYDXr7+KJLgVhcAsI
   jBgyauZzVYXO+4Rq3WHMqlCC5kH94BjVTBwSQ8i6tuDm2tVD4s/lh8oeS
   Hw4jJ8u2fjJAovUom4cCl/MGKTodwtw0uXZlfv1OQQeMstXf57qu5Z6Gp
   5qT27r+HA6lKUT1diKGnDw0yfshrf/eE4ZB/mdQK0mN6OctF7xWwALDT3
   VJwtRt0q+oj9p2sj0Ca+DeQlGM2XLWtOb8dXERTWhRvNi9RLm2Gpj7zXV
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10366"; a="276119336"
X-IronPort-AV: E=Sophos;i="5.91,272,1647327600"; 
   d="scan'208";a="276119336"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2022 15:56:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,272,1647327600"; 
   d="scan'208";a="634271933"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 02 Jun 2022 15:56:53 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nwtkL-0005VN-45;
        Thu, 02 Jun 2022 22:56:53 +0000
Date:   Fri, 03 Jun 2022 06:56:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Paolo Abeni <pabeni@redhat.com>
Cc:     linux-wireless@vger.kernel.org, Kalle Valo <kvalo@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>
Subject: [wireless:for-next] BUILD SUCCESS
 c6fbbf1eae8f35e10966826960e154c9596c86dc
Message-ID: <62994004.O+SYgzyk6PPQqhnh%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git for-next
branch HEAD: c6fbbf1eae8f35e10966826960e154c9596c86dc  nfp: remove padding in nfp_nfdk_tx_desc

elapsed time: 808m

configs tested: 144
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm64                               defconfig
arm64                            allyesconfig
arm                              allmodconfig
arm                                 defconfig
arm                              allyesconfig
arm                       imx_v6_v7_defconfig
arc                          axs101_defconfig
arm                          gemini_defconfig
arm                         vf610m4_defconfig
arm                           viper_defconfig
nios2                               defconfig
s390                       zfcpdump_defconfig
sh                          r7785rp_defconfig
sh                          rsk7201_defconfig
sh                   secureedge5410_defconfig
arm64                            alldefconfig
sh                         microdev_defconfig
xtensa                generic_kc705_defconfig
powerpc                      cm5200_defconfig
arm                       omap2plus_defconfig
arm                      footbridge_defconfig
ia64                        generic_defconfig
mips                          rb532_defconfig
m68k                         apollo_defconfig
powerpc                     ep8248e_defconfig
sh                           se7780_defconfig
sh                          kfr2r09_defconfig
powerpc                    amigaone_defconfig
m68k                         amcore_defconfig
ia64                             alldefconfig
arm                         lpc18xx_defconfig
arc                 nsimosci_hs_smp_defconfig
arm                             rpc_defconfig
mips                         mpc30x_defconfig
openrisc                 simple_smp_defconfig
arm                        mini2440_defconfig
sh                           se7343_defconfig
arm                           sunxi_defconfig
arm                        spear6xx_defconfig
arm                          pxa910_defconfig
sh                            shmin_defconfig
mips                           ip32_defconfig
powerpc                 mpc834x_itx_defconfig
sh                        edosk7705_defconfig
sh                     magicpanelr2_defconfig
ia64                                defconfig
x86_64                        randconfig-c001
i386                          randconfig-c001
arm                  randconfig-c002-20220531
riscv                             allnoconfig
m68k                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
arc                              allyesconfig
csky                                defconfig
nios2                            allyesconfig
alpha                               defconfig
alpha                            allyesconfig
h8300                            allyesconfig
xtensa                           allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
parisc64                            defconfig
parisc                           allyesconfig
s390                                defconfig
s390                             allmodconfig
s390                             allyesconfig
i386                              debian-10.3
i386                             allyesconfig
i386                   debian-10.3-kselftests
sparc                               defconfig
i386                                defconfig
sparc                            allyesconfig
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
arc                  randconfig-r043-20220601
riscv                            allyesconfig
riscv                            allmodconfig
riscv                    nommu_k210_defconfig
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
x86_64                    rhel-8.3-kselftests
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                          rhel-8.3-func
x86_64                           rhel-8.3-syz
x86_64                         rhel-8.3-kunit
x86_64                                  kexec
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                               rhel-8.3

clang tested configs:
mips                 randconfig-c004-20220531
x86_64                        randconfig-c007
i386                          randconfig-c001
s390                 randconfig-c005-20220531
arm                  randconfig-c002-20220531
powerpc              randconfig-c003-20220531
riscv                randconfig-c006-20220531
powerpc                     tqm5200_defconfig
riscv                    nommu_virt_defconfig
powerpc                      acadia_defconfig
arm                           omap1_defconfig
arm                        magician_defconfig
arm                         hackkit_defconfig
powerpc                   lite5200b_defconfig
mips                      malta_kvm_defconfig
hexagon                             defconfig
arm                       netwinder_defconfig
arm                         lpc32xx_defconfig
x86_64                        randconfig-a005
x86_64                        randconfig-a003
x86_64                        randconfig-a001
i386                          randconfig-a002
i386                          randconfig-a006
i386                          randconfig-a004
x86_64                        randconfig-a012
x86_64                        randconfig-a014
x86_64                        randconfig-a016
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
hexagon              randconfig-r041-20220531
hexagon              randconfig-r045-20220531
hexagon              randconfig-r041-20220601
hexagon              randconfig-r045-20220601
riscv                randconfig-r042-20220601
s390                 randconfig-r044-20220601

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
