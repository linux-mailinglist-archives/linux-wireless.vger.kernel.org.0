Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E25CD52BD49
	for <lists+linux-wireless@lfdr.de>; Wed, 18 May 2022 16:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237571AbiERNQr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 May 2022 09:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237790AbiERNQj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 May 2022 09:16:39 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 867A636B4E
        for <linux-wireless@vger.kernel.org>; Wed, 18 May 2022 06:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652879796; x=1684415796;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=8/et9LFlBnPs+da0XTx2yDN1fTjUCBqo+lmRhldDKaM=;
  b=jrN+haSv/I0Ogd9yel+FT7Owly/cZTP5zRAc7dNjSrRh6uiddibDqpKO
   J37pYX+6qgDTIn9QgUa1NqCCVDA1UVwCfSljQt1FHZ7o03DTDhAYs3Ie1
   bWNk7QORLeeyp/7F5JELNcjysl/RFCyC8Njauc7dJmlLJ3e0fQp27+Wnk
   Eh4lcGRNv2I3Q8+mgMHHH/SRM0ibvc+lJTtY3oqq768wREv8PZwJIhjTJ
   S7wp/d8ALPs7Z+29fcaDNM5X3i1xtRdU3Sxxs9mSDbxrjmuvdNNuAowBP
   te9pSYaTj9RX53ZNntH8MzvBQz6H2BFQODLLSw0oIDdldJ2kIKox73HIx
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10350"; a="271795893"
X-IronPort-AV: E=Sophos;i="5.91,234,1647327600"; 
   d="scan'208";a="271795893"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 06:16:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,234,1647327600"; 
   d="scan'208";a="556318760"
Received: from lkp-server02.sh.intel.com (HELO 242b25809ac7) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 18 May 2022 06:16:34 -0700
Received: from kbuild by 242b25809ac7 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nrJXV-0002D0-US;
        Wed, 18 May 2022 13:16:33 +0000
Date:   Wed, 18 May 2022 21:15:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johannes Berg <johannes.berg@intel.com>
Cc:     linux-wireless@vger.kernel.org, Kalle Valo <kvalo@kernel.org>
Subject: [wireless-next:mld] BUILD SUCCESS WITH WARNING
 e926d3f8da675484f102647e9cd8f3664ef56e13
Message-ID: <6284f18f.agCJkzIzmmpOn6Gw%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git mld
branch HEAD: e926d3f8da675484f102647e9cd8f3664ef56e13  mac80211: reorg some iface data structs for MLD

Warning reports:

https://lore.kernel.org/linux-wireless/202205170246.inGN6Zt9-lkp@intel.com

Warning: (recently discovered and may have been fixed)

net/mac80211/tx.c:5404:38: warning: variable 'ifmgd' set but not used [-Wunused-but-set-variable]

Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-allyesconfig
|   `-- net-mac80211-tx.c:warning:variable-ifmgd-set-but-not-used
|-- arc-allyesconfig
|   `-- net-mac80211-tx.c:warning:variable-ifmgd-set-but-not-used
|-- arm-allmodconfig
|   `-- net-mac80211-tx.c:warning:variable-ifmgd-set-but-not-used
|-- arm-allyesconfig
|   `-- net-mac80211-tx.c:warning:variable-ifmgd-set-but-not-used
|-- arm-defconfig
|   `-- net-mac80211-tx.c:warning:variable-ifmgd-set-but-not-used
|-- arm-imx_v6_v7_defconfig
|   `-- net-mac80211-tx.c:warning:variable-ifmgd-set-but-not-used
|-- arm64-allyesconfig
|   `-- net-mac80211-tx.c:warning:variable-ifmgd-set-but-not-used
|-- arm64-defconfig
|   `-- net-mac80211-tx.c:warning:variable-ifmgd-set-but-not-used
|-- h8300-allyesconfig
|   `-- net-mac80211-tx.c:warning:variable-ifmgd-set-but-not-used
|-- i386-allyesconfig
|   `-- net-mac80211-tx.c:warning:variable-ifmgd-set-but-not-used
|-- i386-defconfig
|   `-- net-mac80211-tx.c:warning:variable-ifmgd-set-but-not-used
|-- ia64-allmodconfig
|   `-- net-mac80211-tx.c:warning:variable-ifmgd-set-but-not-used
|-- ia64-allyesconfig
|   `-- net-mac80211-tx.c:warning:variable-ifmgd-set-but-not-used
|-- m68k-allmodconfig
|   `-- net-mac80211-tx.c:warning:variable-ifmgd-set-but-not-used
|-- m68k-allyesconfig
|   `-- net-mac80211-tx.c:warning:variable-ifmgd-set-but-not-used
|-- mips-allmodconfig
|   `-- net-mac80211-tx.c:warning:variable-ifmgd-set-but-not-used
|-- mips-allyesconfig
|   `-- net-mac80211-tx.c:warning:variable-ifmgd-set-but-not-used
|-- mips-gcw0_defconfig
|   `-- net-mac80211-tx.c:warning:variable-ifmgd-set-but-not-used
|-- nios2-allyesconfig
|   `-- net-mac80211-tx.c:warning:variable-ifmgd-set-but-not-used
|-- nios2-randconfig-r035-20220516
|   `-- net-mac80211-tx.c:warning:variable-ifmgd-set-but-not-used
|-- openrisc-randconfig-r034-20220516
|   `-- net-mac80211-tx.c:warning:variable-ifmgd-set-but-not-used
|-- openrisc-randconfig-r036-20220516
|   `-- net-mac80211-tx.c:warning:variable-ifmgd-set-but-not-used
|-- parisc-allyesconfig
|   `-- net-mac80211-tx.c:warning:variable-ifmgd-set-but-not-used
|-- powerpc-allmodconfig
|   `-- net-mac80211-tx.c:warning:variable-ifmgd-set-but-not-used
|-- powerpc-allyesconfig
|   `-- net-mac80211-tx.c:warning:variable-ifmgd-set-but-not-used
|-- riscv-allmodconfig
|   `-- net-mac80211-tx.c:warning:variable-ifmgd-set-but-not-used
|-- riscv-allyesconfig
|   `-- net-mac80211-tx.c:warning:variable-ifmgd-set-but-not-used
|-- riscv-randconfig-r042-20220516
|   `-- net-mac80211-tx.c:warning:variable-ifmgd-set-but-not-used
|-- sh-allmodconfig
|   `-- net-mac80211-tx.c:warning:variable-ifmgd-set-but-not-used
|-- sparc-allyesconfig
|   `-- net-mac80211-tx.c:warning:variable-ifmgd-set-but-not-used
|-- x86_64-allyesconfig
|   `-- net-mac80211-tx.c:warning:variable-ifmgd-set-but-not-used
|-- x86_64-defconfig
|   `-- net-mac80211-tx.c:warning:variable-ifmgd-set-but-not-used
|-- x86_64-kexec
|   `-- net-mac80211-tx.c:warning:variable-ifmgd-set-but-not-used
|-- x86_64-randconfig-a015-20220516
|   `-- net-mac80211-tx.c:warning:variable-ifmgd-set-but-not-used
|-- x86_64-rhel-8.3
|   `-- net-mac80211-tx.c:warning:variable-ifmgd-set-but-not-used
|-- x86_64-rhel-8.3-func
|   `-- net-mac80211-tx.c:warning:variable-ifmgd-set-but-not-used
|-- x86_64-rhel-8.3-kselftests
|   `-- net-mac80211-tx.c:warning:variable-ifmgd-set-but-not-used
|-- x86_64-rhel-8.3-kunit
|   `-- net-mac80211-tx.c:warning:variable-ifmgd-set-but-not-used
|-- x86_64-rhel-8.3-syz
|   `-- net-mac80211-tx.c:warning:variable-ifmgd-set-but-not-used
`-- xtensa-allyesconfig
    `-- net-mac80211-tx.c:warning:variable-ifmgd-set-but-not-used

elapsed time: 1526m

configs tested: 98
configs skipped: 3

gcc tested configs:
arm                              allmodconfig
arm                              allyesconfig
arm64                            allyesconfig
arm                                 defconfig
arm64                               defconfig
i386                 randconfig-c001-20220516
arm                         lpc18xx_defconfig
arc                     nsimosci_hs_defconfig
arm                       imx_v6_v7_defconfig
sh                     magicpanelr2_defconfig
arc                          axs103_defconfig
um                               alldefconfig
arm                           stm32_defconfig
mips                           gcw0_defconfig
mips                           ip32_defconfig
m68k                          sun3x_defconfig
ia64                                defconfig
ia64                             allmodconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allyesconfig
m68k                             allmodconfig
alpha                               defconfig
csky                                defconfig
nios2                            allyesconfig
alpha                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
h8300                            allyesconfig
xtensa                           allyesconfig
parisc                              defconfig
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
s390                             allyesconfig
parisc64                            defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
i386                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
nios2                               defconfig
arc                              allyesconfig
mips                             allmodconfig
mips                             allyesconfig
powerpc                           allnoconfig
powerpc                          allmodconfig
powerpc                          allyesconfig
x86_64               randconfig-a012-20220516
x86_64               randconfig-a011-20220516
x86_64               randconfig-a013-20220516
x86_64               randconfig-a014-20220516
x86_64               randconfig-a016-20220516
x86_64               randconfig-a015-20220516
i386                 randconfig-a014-20220516
i386                 randconfig-a011-20220516
i386                 randconfig-a013-20220516
i386                 randconfig-a015-20220516
i386                 randconfig-a012-20220516
i386                 randconfig-a016-20220516
x86_64                        randconfig-a004
x86_64                        randconfig-a002
x86_64                        randconfig-a006
arc                  randconfig-r043-20220516
s390                 randconfig-r044-20220516
riscv                randconfig-r042-20220516
riscv                             allnoconfig
riscv                            allyesconfig
riscv                            allmodconfig
riscv                    nommu_k210_defconfig
riscv                          rv32_defconfig
riscv                    nommu_virt_defconfig
riscv                               defconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                              defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                                  kexec
x86_64                           rhel-8.3-syz
x86_64                          rhel-8.3-func
x86_64                               rhel-8.3
x86_64                         rhel-8.3-kunit

clang tested configs:
mips                            e55_defconfig
powerpc                        icon_defconfig
arm64                            allyesconfig
mips                         tb0287_defconfig
i386                 randconfig-a003-20220516
i386                 randconfig-a001-20220516
i386                 randconfig-a002-20220516
i386                 randconfig-a004-20220516
i386                 randconfig-a006-20220516
i386                 randconfig-a005-20220516
x86_64                        randconfig-a005
x86_64                        randconfig-a001
x86_64                        randconfig-a003
hexagon              randconfig-r045-20220516
hexagon              randconfig-r041-20220516

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
