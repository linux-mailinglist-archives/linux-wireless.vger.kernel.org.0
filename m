Return-Path: <linux-wireless+bounces-11267-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E92E894DF6A
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Aug 2024 03:11:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0277F1C20A3C
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Aug 2024 01:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 755B22F5B;
	Sun, 11 Aug 2024 01:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MU9Jc3SA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17CA1370
	for <linux-wireless@vger.kernel.org>; Sun, 11 Aug 2024 01:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723338678; cv=none; b=TtEa9v1Mf6YOID4BPfICanCCPgPua2tWDI51M933sSQLpLLVim3/ocBm0WN50Get6dvAxURhe39iLpBt/1udZaM65KdkdkFWf12YOY400gT17/CIc3HAEdMRKjNve0ShgyCkFm/GRHycF32IFP3uQXDS+0EX2HWLVE/aeYLqotU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723338678; c=relaxed/simple;
	bh=F4W5k77z6xRK+cyCYI4GkUSniYYVEoqwA0ytHlKcbFE=;
	h=Date:From:To:Cc:Subject:Message-ID; b=WajUuxMsB85eXAB0tLb/tSZKady+9iVBlGTBJUIdwm7y3HnI4ghEdErQwl+nYDN+Fw3qhXc8pmBPXrvdiP5vk5VEoaIVr/oooOR0TJ7dWPL3BXeGzl2tkDA5kCxGuolRxUD2tTXsI7XRnk4VbB0F1SjQ4b4WXQKeNFhhAucHkf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MU9Jc3SA; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723338676; x=1754874676;
  h=date:from:to:cc:subject:message-id;
  bh=F4W5k77z6xRK+cyCYI4GkUSniYYVEoqwA0ytHlKcbFE=;
  b=MU9Jc3SAgubbhCCcoT2YwpWHtaW3gNI/paOxtWYAHPyxye7xB+98kq1W
   0YC08YSnrIuFH894yZq2egjRFDsjGo5WQkqcUZk78wSqF0EHkRx6xNZB5
   06tBLtXAvfXB24aVUeykMP7Gek/BYS+EqQvp6Z4umglk85OVsWvclo8hn
   v538iuVZSBMF2ReyQtLoXud2WaET1QJxVeUX9iEWUcuftkjqv6hMJWAos
   9ScZodTxj86GcdSKNGIhCNEkhNMS3LFHSBRfolX2cLbtcWIFW26VPgs4O
   F7cudIJMngI7b0qgHa0qS+bLXMJeaT6pwARou1q9pikngl/F0QVybLw1s
   Q==;
X-CSE-ConnectionGUID: o2oVq3BvTpGx0z+JxeNIfg==
X-CSE-MsgGUID: WCzfFc+uSJqPKKma9jeDKw==
X-IronPort-AV: E=McAfee;i="6700,10204,11160"; a="32627064"
X-IronPort-AV: E=Sophos;i="6.09,280,1716274800"; 
   d="scan'208";a="32627064"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2024 18:11:15 -0700
X-CSE-ConnectionGUID: CbDzFiHuRSq79+LmcJdnTQ==
X-CSE-MsgGUID: t7OayBDvSqawxc01vBxlZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,280,1716274800"; 
   d="scan'208";a="57810298"
Received: from unknown (HELO b6bf6c95bbab) ([10.239.97.151])
  by orviesa010.jf.intel.com with ESMTP; 10 Aug 2024 18:11:14 -0700
Received: from kbuild by b6bf6c95bbab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1scx71-000ASB-29;
	Sun, 11 Aug 2024 01:11:11 +0000
Date: Sun, 11 Aug 2024 09:10:40 +0800
From: kernel test robot <lkp@intel.com>
To: Kalle Valo <kvalo@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>,
 linux-wireless@vger.kernel.org
Subject: [wireless-next:main] BUILD SUCCESS
 cc32e9fb380d8afdbf3486d7063d5520bfb0f071
Message-ID: <202408110937.8DEKLbD5-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: cc32e9fb380d8afdbf3486d7063d5520bfb0f071  Merge tag 'rtw-next-2024-08-09' of https://github.com/pkshih/rtw

elapsed time: 991m

configs tested: 163
configs skipped: 8

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
alpha                             allnoconfig   gcc-13.3.0
alpha                            allyesconfig   gcc-13.3.0
alpha                               defconfig   gcc-13.2.0
arc                              allmodconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                              allyesconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                         haps_hs_defconfig   gcc-13.2.0
arc                           tb10x_defconfig   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                              allmodconfig   gcc-14.1.0
arm                               allnoconfig   clang-20
arm                               allnoconfig   gcc-13.2.0
arm                              allyesconfig   gcc-13.2.0
arm                              allyesconfig   gcc-14.1.0
arm                         axm55xx_defconfig   gcc-13.2.0
arm                                 defconfig   gcc-13.2.0
arm                            hisi_defconfig   gcc-13.2.0
arm                      integrator_defconfig   gcc-13.2.0
arm                        mvebu_v7_defconfig   gcc-13.2.0
arm                       omap2plus_defconfig   gcc-13.2.0
arm                        shmobile_defconfig   gcc-13.2.0
arm64                            allmodconfig   clang-20
arm64                            allmodconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-14.1.0
arm64                               defconfig   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
csky                              allnoconfig   gcc-14.1.0
csky                                defconfig   gcc-13.2.0
hexagon                          allmodconfig   clang-20
hexagon                           allnoconfig   clang-20
hexagon                          allyesconfig   clang-20
i386                             allmodconfig   clang-18
i386                             allmodconfig   gcc-12
i386                              allnoconfig   clang-18
i386                              allnoconfig   gcc-12
i386                             allyesconfig   clang-18
i386                             allyesconfig   gcc-12
i386         buildonly-randconfig-001-20240810   clang-18
i386         buildonly-randconfig-001-20240811   gcc-12
i386         buildonly-randconfig-002-20240810   clang-18
i386         buildonly-randconfig-002-20240811   gcc-12
i386         buildonly-randconfig-003-20240810   clang-18
i386         buildonly-randconfig-003-20240811   gcc-12
i386         buildonly-randconfig-004-20240810   clang-18
i386         buildonly-randconfig-004-20240811   gcc-12
i386         buildonly-randconfig-005-20240810   gcc-12
i386         buildonly-randconfig-005-20240811   gcc-12
i386         buildonly-randconfig-006-20240810   gcc-12
i386         buildonly-randconfig-006-20240811   gcc-12
i386                                defconfig   clang-18
i386                  randconfig-001-20240810   clang-18
i386                  randconfig-001-20240811   gcc-12
i386                  randconfig-002-20240810   gcc-12
i386                  randconfig-002-20240811   gcc-12
i386                  randconfig-003-20240810   clang-18
i386                  randconfig-003-20240811   gcc-12
i386                  randconfig-004-20240810   gcc-12
i386                  randconfig-004-20240811   gcc-12
i386                  randconfig-005-20240810   gcc-12
i386                  randconfig-005-20240811   gcc-12
i386                  randconfig-006-20240810   clang-18
i386                  randconfig-006-20240811   gcc-12
i386                  randconfig-011-20240810   gcc-12
i386                  randconfig-011-20240811   gcc-12
i386                  randconfig-012-20240810   gcc-12
i386                  randconfig-012-20240811   gcc-12
i386                  randconfig-013-20240810   clang-18
i386                  randconfig-013-20240811   gcc-12
i386                  randconfig-014-20240810   gcc-12
i386                  randconfig-014-20240811   gcc-12
i386                  randconfig-015-20240810   gcc-12
i386                  randconfig-015-20240811   gcc-12
i386                  randconfig-016-20240810   gcc-12
i386                  randconfig-016-20240811   gcc-12
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch                           defconfig   gcc-13.2.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-13.2.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
m68k                                defconfig   gcc-13.2.0
m68k                        mvme147_defconfig   gcc-13.2.0
m68k                           sun3_defconfig   gcc-13.2.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
mips                              allnoconfig   gcc-14.1.0
mips                         bigsur_defconfig   gcc-13.2.0
mips                      bmips_stb_defconfig   gcc-13.2.0
mips                          eyeq6_defconfig   gcc-13.2.0
mips                           ip28_defconfig   gcc-13.2.0
mips                        vocore2_defconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-14.1.0
nios2                               defconfig   gcc-13.2.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc64                            defconfig   gcc-13.2.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   clang-20
powerpc                          allyesconfig   gcc-14.1.0
powerpc                   bluestone_defconfig   gcc-13.2.0
powerpc                     ep8248e_defconfig   gcc-13.2.0
powerpc                 mpc834x_itx_defconfig   gcc-13.2.0
powerpc                      pmac32_defconfig   gcc-13.2.0
powerpc                     rainier_defconfig   gcc-13.2.0
powerpc                     redwood_defconfig   gcc-13.2.0
powerpc                     tqm8541_defconfig   gcc-13.2.0
powerpc64                        alldefconfig   gcc-13.2.0
riscv                            allmodconfig   clang-20
riscv                            allmodconfig   gcc-14.1.0
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   clang-20
riscv                            allyesconfig   gcc-14.1.0
riscv                               defconfig   gcc-14.1.0
s390                             allmodconfig   clang-20
s390                              allnoconfig   clang-20
s390                              allnoconfig   gcc-14.1.0
s390                             allyesconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   gcc-14.1.0
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-13.2.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-14.1.0
sh                          kfr2r09_defconfig   gcc-13.2.0
sh                          rsk7269_defconfig   gcc-13.2.0
sh                             shx3_defconfig   gcc-13.2.0
sparc                            allmodconfig   gcc-14.1.0
sparc                       sparc32_defconfig   gcc-13.2.0
sparc64                          alldefconfig   gcc-13.2.0
sparc64                             defconfig   gcc-14.1.0
um                               allmodconfig   clang-20
um                               allmodconfig   gcc-13.3.0
um                                allnoconfig   clang-17
um                                allnoconfig   gcc-14.1.0
um                               allyesconfig   gcc-12
um                               allyesconfig   gcc-13.3.0
um                                  defconfig   gcc-14.1.0
um                             i386_defconfig   gcc-14.1.0
um                           x86_64_defconfig   gcc-14.1.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64                              defconfig   clang-18
x86_64                              defconfig   gcc-11
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                            allnoconfig   gcc-14.1.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

