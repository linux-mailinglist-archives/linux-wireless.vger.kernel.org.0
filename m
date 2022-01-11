Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5313448A432
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jan 2022 01:12:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345646AbiAKAMT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 10 Jan 2022 19:12:19 -0500
Received: from mga04.intel.com ([192.55.52.120]:45956 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242685AbiAKAMT (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 10 Jan 2022 19:12:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641859938; x=1673395938;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=CFrKTB8iJ1yGiYv9nzIhZA4jVIBY+43iQAu31TuSbAI=;
  b=Z586gMq6tiUVefdH1M96XFsjg37qWEAMgaGNB76FBKtuxz3tylzCQRZv
   ytc7XKIPU7LfLBCYvUzTxBF4K1ht+LKLkxPpU7FF3nBNvdYY2SjwBGRh9
   8O6CjBdj9TjjvCA//B0w2lOnCbrGPy3uSglmd5HrbMtgO6SWj5T7ZDuUX
   rCfnYVMWd3RtS612e8iYwFO8nJ6E3TMyFjCRhVcHmqs5jTC2iYV+aKrrJ
   xXmjVsM0L1F9PaYsBhV729m+hXiRtdM4U+1cSMeCC5fUqsAmYGpIA72KU
   V+73LR/MUNhNsG7M47xiw4je0LDWkUp9PU8aLS/aJUX/7rYnyIM6AdHb1
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10223"; a="242179039"
X-IronPort-AV: E=Sophos;i="5.88,278,1635231600"; 
   d="scan'208";a="242179039"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2022 16:12:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,278,1635231600"; 
   d="scan'208";a="622865822"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 10 Jan 2022 16:12:16 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n74lr-00046H-NR; Tue, 11 Jan 2022 00:12:15 +0000
Date:   Tue, 11 Jan 2022 08:11:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     linux-wireless@vger.kernel.org
Subject: [jberg-mac80211-next:master] BUILD SUCCESS
 8aaaf2f3af2ae212428f4db1af34214225f5cec3
Message-ID: <61dccb4f.FebonzjRij3TW31i%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211-next.git master
branch HEAD: 8aaaf2f3af2ae212428f4db1af34214225f5cec3  Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net

elapsed time: 1133m

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
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
i386                   debian-10.3-kselftests
i386                              debian-10.3
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
