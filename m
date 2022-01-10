Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DDD648A225
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Jan 2022 22:48:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345060AbiAJVsP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 10 Jan 2022 16:48:15 -0500
Received: from mga17.intel.com ([192.55.52.151]:60615 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345050AbiAJVsP (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 10 Jan 2022 16:48:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641851295; x=1673387295;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=i4fnz1dnrL/P4chx0iwVAgPTFqYaCdWs1yvPiUjCFz0=;
  b=A5F6y07tHeBWA6vslTtZjCJfe8JUwBHCNmzti3Sh/cUndXoW7WYOXUOW
   TGV8JwZCAAyaOqOqkOoZRp0dSBPbjotiHVI0+1JZUwqGNbmfeouQzHFq/
   je2CJQABf3hJjZ5ow+COXqI0U7kDlRR6ToTUec7i40TbzQgh4iouEDeT0
   GK+BZGHQ4tn4fvjmgw28JCUeJ9rbAL5MsLk744K0M+pLQ4VYUeMPrcWY+
   /6ZVN3nlJq4igbVFzJJ4gyPzOoq8Lo98kl8Eq9HLnP0YVXmp2MKITq1/x
   T0h8NGlZvaVxRQPJC6QUik0GgrjDRVfILuB0BSJ7auIwkCxJVAlxavZjP
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10223"; a="224028437"
X-IronPort-AV: E=Sophos;i="5.88,278,1635231600"; 
   d="scan'208";a="224028437"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2022 13:48:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,278,1635231600"; 
   d="scan'208";a="622817202"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 10 Jan 2022 13:48:13 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n72WS-0003zO-ND; Mon, 10 Jan 2022 21:48:12 +0000
Date:   Tue, 11 Jan 2022 05:47:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     linux-wireless@vger.kernel.org
Subject: [jberg-mac80211:master] BUILD SUCCESS
 dd3ca4c5184ea98e40acb8eb293d85b88ea04ee2
Message-ID: <61dca98e.N892zETRua4l0AFb%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211.git master
branch HEAD: dd3ca4c5184ea98e40acb8eb293d85b88ea04ee2  amt: fix wrong return type of amt_send_membership_update()

elapsed time: 1235m

configs tested: 54
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
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
s390                             allmodconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                               defconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
sparc                            allyesconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
riscv                    nommu_k210_defconfig
riscv                            allyesconfig
riscv                    nommu_virt_defconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
um                           x86_64_defconfig
um                             i386_defconfig
x86_64                           allyesconfig
x86_64                    rhel-8.3-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                          rhel-8.3-func
x86_64                                  kexec

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
