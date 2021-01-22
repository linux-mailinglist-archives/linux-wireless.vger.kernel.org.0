Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED5C2FFBEA
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Jan 2021 05:45:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbhAVEpL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 Jan 2021 23:45:11 -0500
Received: from mga04.intel.com ([192.55.52.120]:53185 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725854AbhAVEpG (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 Jan 2021 23:45:06 -0500
IronPort-SDR: 1pYxxORjvd9dSNqMacArmXhmif369qyXZZUgdzwxEPyIq9YytfXcH9ws1X+nTD5LtlUcST05vZ
 P3/xmw8KwpBw==
X-IronPort-AV: E=McAfee;i="6000,8403,9871"; a="176816135"
X-IronPort-AV: E=Sophos;i="5.79,365,1602572400"; 
   d="scan'208";a="176816135"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2021 20:44:24 -0800
IronPort-SDR: M9ywtPms6TDqX0a3fMNEYzvHityQeGnYxgY+arN/U3/DW/phKVO12jsfh9o89aQ001a8ict0n/
 TbJtMRj20lzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,365,1602572400"; 
   d="scan'208";a="427653102"
Received: from lkp-server01.sh.intel.com (HELO 260eafd5ecd0) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 21 Jan 2021 20:44:22 -0800
Received: from kbuild by 260eafd5ecd0 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1l2oJ4-0006yw-6N; Fri, 22 Jan 2021 04:44:22 +0000
Date:   Fri, 22 Jan 2021 12:43:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johannes Berg <johannes.berg@intel.com>
Cc:     linux-wireless@vger.kernel.org
Subject: [mac80211-next:master] BUILD SUCCESS WITH WARNING
 791daf8fc49a16aef77d881f664a648642b75b45
Message-ID: <600a5802.4NXIiMTWoZYBp4lh%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211-next.git master
branch HEAD: 791daf8fc49a16aef77d881f664a648642b75b45  cfg80211: avoid holding the RTNL when calling the driver

Warning reports:

https://lore.kernel.org/linux-wireless/202101220739.mkyobq8P-lkp@intel.com

Warning in current branch:

net/mac80211/he.c:60:25: sparse:    left side has type unsigned short
net/mac80211/he.c:60:25: sparse:    right side has type restricted __le16
net/mac80211/he.c:96:29: sparse:    right side has type fouled restricted __le16

Warning ids grouped by kconfigs:

gcc_recent_errors
`-- i386-randconfig-s002-20210122
    |-- net-mac80211-he.c:sparse:left-side-has-type-unsigned-short
    |-- net-mac80211-he.c:sparse:right-side-has-type-fouled-restricted-__le16
    |-- net-mac80211-he.c:sparse:right-side-has-type-restricted-__le16
    |-- net-mac80211-he.c:sparse:sparse:cast-to-restricted-__le16
    |-- net-mac80211-he.c:sparse:sparse:incorrect-type-in-argument-(different-base-types)-expected-unsigned-short-usertype-he_mcs-got-restricted-__le16
    |-- net-mac80211-he.c:sparse:sparse:incorrect-type-in-argument-(different-base-types)-expected-unsigned-short-usertype-he_own_rx-got-restricted-__le16
    |-- net-mac80211-he.c:sparse:sparse:incorrect-type-in-argument-(different-base-types)-expected-unsigned-short-usertype-he_own_tx-got-restricted-__le16
    |-- net-mac80211-he.c:sparse:sparse:incorrect-type-in-argument-(different-base-types)-expected-unsigned-short-usertype-he_peer_rx-got-restricted-__le16
    |-- net-mac80211-he.c:sparse:sparse:incorrect-type-in-argument-(different-base-types)-expected-unsigned-short-usertype-he_peer_tx-got-restricted-__le16
    `-- net-mac80211-he.c:sparse:sparse:invalid-assignment:

elapsed time: 720m

configs tested: 83
configs skipped: 2

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
h8300                       h8s-sim_defconfig
arm                     davinci_all_defconfig
arc                        nsim_700_defconfig
powerpc                       holly_defconfig
powerpc                 mpc85xx_cds_defconfig
m68k                       m5249evb_defconfig
arm                      pxa255-idp_defconfig
xtensa                  audio_kc705_defconfig
arm                          simpad_defconfig
powerpc                 xes_mpc85xx_defconfig
sh                          kfr2r09_defconfig
mips                      pic32mzda_defconfig
mips                      loongson3_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
c6x                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                               tinyconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a002-20210121
x86_64               randconfig-a003-20210121
x86_64               randconfig-a001-20210121
x86_64               randconfig-a005-20210121
x86_64               randconfig-a006-20210121
x86_64               randconfig-a004-20210121
i386                 randconfig-a001-20210121
i386                 randconfig-a002-20210121
i386                 randconfig-a004-20210121
i386                 randconfig-a006-20210121
i386                 randconfig-a005-20210121
i386                 randconfig-a003-20210121
i386                 randconfig-a013-20210121
i386                 randconfig-a011-20210121
i386                 randconfig-a012-20210121
i386                 randconfig-a014-20210121
i386                 randconfig-a015-20210121
i386                 randconfig-a016-20210121
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                      rhel-8.3-kbuiltin
x86_64                                  kexec

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
