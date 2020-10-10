Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97D8F289E0C
	for <lists+linux-wireless@lfdr.de>; Sat, 10 Oct 2020 05:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730976AbgJJDnw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 9 Oct 2020 23:43:52 -0400
Received: from mga04.intel.com ([192.55.52.120]:12846 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730875AbgJJDfv (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 9 Oct 2020 23:35:51 -0400
IronPort-SDR: Idxbr8/hyljFlZfWybcZPX6j/M0MlGugVyYScp1+YsWUWwKqKYwXL3Chrx8hA47KeG+CgPXV16
 m5b8TlrbaKeA==
X-IronPort-AV: E=McAfee;i="6000,8403,9769"; a="162921178"
X-IronPort-AV: E=Sophos;i="5.77,357,1596524400"; 
   d="scan'208";a="162921178"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2020 20:16:39 -0700
IronPort-SDR: 08z4WpE8vFYtY4baOYHITPBRsIlLxyh+iB9vn9p/bNoU87c8X7g7Zf7ZLabERElmi5eb6rrguN
 REzwx4oPnlZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,357,1596524400"; 
   d="scan'208";a="389327529"
Received: from lkp-server02.sh.intel.com (HELO 3341fc3e273e) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 09 Oct 2020 20:16:38 -0700
Received: from kbuild by 3341fc3e273e with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kR5N7-000018-Qc; Sat, 10 Oct 2020 03:16:37 +0000
Date:   Sat, 10 Oct 2020 11:15:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org
Subject: [wireless-drivers-next:master] BUILD SUCCESS
 b7d96bca1f004b5f26ee51ea9c9749a28dac8316
Message-ID: <5f81275e.Rqk+LgTH7kFrCzfA%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-next.git  master
branch HEAD: b7d96bca1f004b5f26ee51ea9c9749a28dac8316  Revert "iwlwifi: remove wide_cmd_header field"

elapsed time: 722m

configs tested: 98
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
c6x                                 defconfig
sparc64                          alldefconfig
arm                          iop32x_defconfig
arm                          gemini_defconfig
sparc                       sparc64_defconfig
powerpc                        warp_defconfig
mips                       lemote2f_defconfig
powerpc                     ppa8548_defconfig
m68k                        m5307c3_defconfig
arm                             rpc_defconfig
mips                       bmips_be_defconfig
h8300                            alldefconfig
mips                      maltasmvp_defconfig
mips                           ip22_defconfig
sh                           se7705_defconfig
arm                     davinci_all_defconfig
powerpc                      bamboo_defconfig
m68k                         amcore_defconfig
arm                             ezx_defconfig
powerpc                     mpc5200_defconfig
mips                     cu1830-neo_defconfig
arm                           corgi_defconfig
openrisc                         alldefconfig
mips                         db1xxx_defconfig
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
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
i386                 randconfig-a006-20201009
i386                 randconfig-a005-20201009
i386                 randconfig-a001-20201009
i386                 randconfig-a004-20201009
i386                 randconfig-a002-20201009
i386                 randconfig-a003-20201009
x86_64               randconfig-a012-20201009
x86_64               randconfig-a015-20201009
x86_64               randconfig-a013-20201009
x86_64               randconfig-a014-20201009
x86_64               randconfig-a011-20201009
x86_64               randconfig-a016-20201009
i386                 randconfig-a015-20201009
i386                 randconfig-a013-20201009
i386                 randconfig-a014-20201009
i386                 randconfig-a016-20201009
i386                 randconfig-a011-20201009
i386                 randconfig-a012-20201009
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
x86_64                                  kexec

clang tested configs:
x86_64               randconfig-a004-20201009
x86_64               randconfig-a003-20201009
x86_64               randconfig-a005-20201009
x86_64               randconfig-a001-20201009
x86_64               randconfig-a002-20201009
x86_64               randconfig-a006-20201009

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
