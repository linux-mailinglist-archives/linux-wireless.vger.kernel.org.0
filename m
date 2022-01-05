Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7D56484F3D
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Jan 2022 09:23:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238457AbiAEIXo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 5 Jan 2022 03:23:44 -0500
Received: from mga04.intel.com ([192.55.52.120]:63486 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238433AbiAEIXn (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 5 Jan 2022 03:23:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641371023; x=1672907023;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=ebW2D09TkO3dLnyeFAJaj4Q0sPPo84A/UN55zLtr3kM=;
  b=c8GlmTIJDYhQjLlcDTVpEuK6pTPS/xOnxkOwo9ojfwzhCbQGHD9Giw+h
   /LviDEkPsY0w+aRfDarj+xu/BPksIW7DRpv2zpj8Aw0rDaJ+LTMbrQGXm
   GxrT5CgZI+pH2F2ufAk9r5TzHq8LmfE365c9+ELI6Lz1SpHCfuEGfxuNr
   klN8Cf4xJGA+kdL6JErMcRsFpbxKU8oQak3Y+XgbuDakqA9bVBDHsFpZo
   /jUicutFabxTPCi2wzUOTx6FZcuEf2VAvyaXMlQ1MlXyfqLMukRLDdSPU
   OUv/YUYvPPLGZJixuj1naEzxTMlgem2n8QgNcvhfZ/2Bc92C5Hxm5+xa8
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="241215886"
X-IronPort-AV: E=Sophos;i="5.88,262,1635231600"; 
   d="scan'208";a="241215886"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2022 00:23:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,262,1635231600"; 
   d="scan'208";a="526423546"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 05 Jan 2022 00:23:30 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n51Zx-000GPW-Hd; Wed, 05 Jan 2022 08:23:29 +0000
Date:   Wed, 05 Jan 2022 16:22:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     linux-wireless@vger.kernel.org
Subject: [jberg-mac80211-next:master] BUILD SUCCESS
 18343b80691560f41c3339119a2e9314d4672c77
Message-ID: <61d55547.v0Gvv7UiWSOFz5c+%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211-next.git master
branch HEAD: 18343b80691560f41c3339119a2e9314d4672c77  Merge tag 'mac80211-next-for-net-next-2022-01-04' of git://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211-next

elapsed time: 908m

configs tested: 54
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

gcc tested configs:
arm                                 defconfig
arm                              allmodconfig
arm                              allyesconfig
arm64                            allyesconfig
arm64                               defconfig
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
sparc                               defconfig
sparc                            allyesconfig
i386                             allyesconfig
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
riscv                             allnoconfig
riscv                               defconfig
riscv                          rv32_defconfig
riscv                            allmodconfig
riscv                    nommu_virt_defconfig
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
