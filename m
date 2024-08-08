Return-Path: <linux-wireless+bounces-11117-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA8DA94B94D
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Aug 2024 10:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8357E282983
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Aug 2024 08:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE1B925634;
	Thu,  8 Aug 2024 08:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IdYP6GTe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21120189B98
	for <linux-wireless@vger.kernel.org>; Thu,  8 Aug 2024 08:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723107094; cv=none; b=SdjLNsD2A2IZhBGcEizxFqqBH5THixSke+7l+kq/6x6wRuk8XnGvI5SeOD1ZNFrj2XevMIveSkE3vCllS2GG9YfcUdq92l14/h24VIneOEIBecJbS/4JfBG4upCiTwkPgXudiOKynAXyr3WmA5J3vQGEGsnvhQSSTNSn+sKfQ18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723107094; c=relaxed/simple;
	bh=BBsjjCzk1tU3Nwk+uZFREnSC9OUSoAe8yptS0avOuDc=;
	h=Date:From:To:Cc:Subject:Message-ID; b=cgfxQib6BMa820AM55aiOmZgfQQg+GMIsVgTUTM4FKVjsKwolshi3lAcLedQ1RCWSBuYPRe9Rmc4f56SyOf4XZZq4hFAH2rGbIUhwBae5yT7jcM0oJsFj8u/fmtKus5zH30FbYS9mflvL3VxgKJ/8efyqtJkuDC5cm8OVdICNZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IdYP6GTe; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723107093; x=1754643093;
  h=date:from:to:cc:subject:message-id;
  bh=BBsjjCzk1tU3Nwk+uZFREnSC9OUSoAe8yptS0avOuDc=;
  b=IdYP6GTedvf7ZG5ErzBEVWdQWMErvOV7YlU0Dv8zJc9/HDu0emcI5qyZ
   27gR6c04RxP/wjcoPoCAY++c7pdi4XnQK/KhtwK+GSPRJ6BT9LFkht1ev
   I8xhbhl+4VBwVia66EzZkNoddI2tJbSY2Hv+bhYIo/pajTqeXncY01drY
   oeZneMLMp7N5t+SF0l+P4OB8gGDs+6yoyDoJa8gtcgqJp40+zQvEvBm9Q
   3NXk3Zm3ONzEJH8/zosiT6t/m45vG6D/wry3hRf7eKczAvHqc8vxmLLIC
   aWDi4/jpCawyh/WNvO0khi+jW7REiSXHDBKKbtcCq9zHT2HhnDUBRNbTq
   g==;
X-CSE-ConnectionGUID: 5uFfdf8vQAmcNrsv4hslTQ==
X-CSE-MsgGUID: hYwc08NtRMaZRc5VgKOglw==
X-IronPort-AV: E=McAfee;i="6700,10204,11157"; a="21190766"
X-IronPort-AV: E=Sophos;i="6.09,272,1716274800"; 
   d="scan'208";a="21190766"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 01:51:33 -0700
X-CSE-ConnectionGUID: uNkr4iM5TyWSfCRoejjW+g==
X-CSE-MsgGUID: R34rDW/1SIKqzWkBzdZfcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,272,1716274800"; 
   d="scan'208";a="57071308"
Received: from unknown (HELO b6bf6c95bbab) ([10.239.97.151])
  by orviesa009.jf.intel.com with ESMTP; 08 Aug 2024 01:51:31 -0700
Received: from kbuild by b6bf6c95bbab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sbyrp-00063s-0V;
	Thu, 08 Aug 2024 08:51:29 +0000
Date: Thu, 08 Aug 2024 16:51:00 +0800
From: kernel test robot <lkp@intel.com>
To: Kalle Valo <kvalo@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>,
 linux-wireless@vger.kernel.org
Subject: [wireless-next:main] BUILD SUCCESS
 4ab9f870a6335af27507d1f3bfb29635d956af48
Message-ID: <202408081655.YrYlzWCx-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: 4ab9f870a6335af27507d1f3bfb29635d956af48  wifi: b43: Constify struct lpphy_tx_gain_table_entry

elapsed time: 930m

configs tested: 198
configs skipped: 9

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
arc                          axs101_defconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arc                   randconfig-001-20240808   gcc-13.2.0
arc                   randconfig-002-20240808   gcc-13.2.0
arm                              allmodconfig   gcc-13.2.0
arm                              allmodconfig   gcc-14.1.0
arm                               allnoconfig   clang-20
arm                               allnoconfig   gcc-13.2.0
arm                              allyesconfig   gcc-13.2.0
arm                              allyesconfig   gcc-14.1.0
arm                                 defconfig   gcc-13.2.0
arm                        neponset_defconfig   gcc-13.2.0
arm                   randconfig-001-20240808   gcc-14.1.0
arm                   randconfig-002-20240808   gcc-14.1.0
arm                   randconfig-003-20240808   clang-17
arm                   randconfig-004-20240808   gcc-14.1.0
arm                             rpc_defconfig   gcc-13.2.0
arm                         s3c6400_defconfig   gcc-13.2.0
arm                           stm32_defconfig   gcc-13.2.0
arm64                            allmodconfig   clang-20
arm64                            allmodconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-13.2.0
arm64                             allnoconfig   gcc-14.1.0
arm64                               defconfig   gcc-13.2.0
arm64                 randconfig-001-20240808   clang-20
arm64                 randconfig-002-20240808   gcc-14.1.0
arm64                 randconfig-003-20240808   gcc-14.1.0
arm64                 randconfig-004-20240808   clang-14
csky                              allnoconfig   gcc-13.2.0
csky                              allnoconfig   gcc-14.1.0
csky                                defconfig   gcc-13.2.0
csky                  randconfig-001-20240808   gcc-14.1.0
csky                  randconfig-002-20240808   gcc-14.1.0
hexagon                          allmodconfig   clang-20
hexagon                           allnoconfig   clang-20
hexagon                          allyesconfig   clang-20
hexagon               randconfig-001-20240808   clang-20
hexagon               randconfig-002-20240808   clang-17
i386                             allmodconfig   clang-18
i386                             allmodconfig   gcc-12
i386                              allnoconfig   clang-18
i386                              allnoconfig   gcc-12
i386                             allyesconfig   clang-18
i386                             allyesconfig   gcc-12
i386         buildonly-randconfig-001-20240808   clang-18
i386         buildonly-randconfig-002-20240808   clang-18
i386         buildonly-randconfig-002-20240808   gcc-12
i386         buildonly-randconfig-003-20240808   clang-18
i386         buildonly-randconfig-004-20240808   clang-18
i386         buildonly-randconfig-005-20240808   clang-18
i386         buildonly-randconfig-006-20240808   clang-18
i386         buildonly-randconfig-006-20240808   gcc-12
i386                                defconfig   clang-18
i386                  randconfig-001-20240808   clang-18
i386                  randconfig-001-20240808   gcc-12
i386                  randconfig-002-20240808   clang-18
i386                  randconfig-002-20240808   gcc-12
i386                  randconfig-003-20240808   clang-18
i386                  randconfig-004-20240808   clang-18
i386                  randconfig-004-20240808   gcc-12
i386                  randconfig-005-20240808   clang-18
i386                  randconfig-005-20240808   gcc-12
i386                  randconfig-006-20240808   clang-18
i386                  randconfig-006-20240808   gcc-12
i386                  randconfig-011-20240808   clang-18
i386                  randconfig-012-20240808   clang-18
i386                  randconfig-012-20240808   gcc-11
i386                  randconfig-013-20240808   clang-18
i386                  randconfig-014-20240808   clang-18
i386                  randconfig-014-20240808   gcc-11
i386                  randconfig-015-20240808   clang-18
i386                  randconfig-015-20240808   gcc-12
i386                  randconfig-016-20240808   clang-18
i386                  randconfig-016-20240808   gcc-12
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-13.2.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch                           defconfig   gcc-13.2.0
loongarch             randconfig-001-20240808   gcc-14.1.0
loongarch             randconfig-002-20240808   gcc-14.1.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-13.2.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
m68k                                defconfig   gcc-13.2.0
m68k                       m5475evb_defconfig   gcc-13.2.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
mips                              allnoconfig   gcc-14.1.0
mips                        bcm47xx_defconfig   gcc-13.2.0
mips                   sb1250_swarm_defconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-14.1.0
nios2                               defconfig   gcc-13.2.0
nios2                 randconfig-001-20240808   gcc-14.1.0
nios2                 randconfig-002-20240808   gcc-14.1.0
openrisc                          allnoconfig   gcc-14.1.0
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   gcc-14.1.0
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-14.1.0
parisc                generic-32bit_defconfig   gcc-13.2.0
parisc                randconfig-001-20240808   gcc-14.1.0
parisc                randconfig-002-20240808   gcc-14.1.0
parisc64                            defconfig   gcc-13.2.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   gcc-14.1.0
powerpc                          allyesconfig   clang-20
powerpc                          allyesconfig   gcc-14.1.0
powerpc               randconfig-001-20240808   clang-20
powerpc               randconfig-002-20240808   clang-17
powerpc                     skiroot_defconfig   gcc-13.2.0
powerpc64             randconfig-001-20240808   clang-16
powerpc64             randconfig-002-20240808   clang-20
riscv                            allmodconfig   clang-20
riscv                            allmodconfig   gcc-14.1.0
riscv                             allnoconfig   gcc-14.1.0
riscv                            allyesconfig   clang-20
riscv                            allyesconfig   gcc-14.1.0
riscv                               defconfig   gcc-14.1.0
riscv                 randconfig-001-20240808   gcc-14.1.0
riscv                 randconfig-002-20240808   gcc-14.1.0
s390                             allmodconfig   clang-20
s390                              allnoconfig   clang-20
s390                              allnoconfig   gcc-14.1.0
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   gcc-14.1.0
s390                  randconfig-001-20240808   gcc-14.1.0
s390                  randconfig-002-20240808   gcc-14.1.0
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-13.2.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-14.1.0
sh                    randconfig-001-20240808   gcc-14.1.0
sh                    randconfig-002-20240808   gcc-14.1.0
sh                           se7721_defconfig   gcc-13.2.0
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-14.1.0
sparc64               randconfig-001-20240808   gcc-14.1.0
sparc64               randconfig-002-20240808   gcc-14.1.0
um                               allmodconfig   clang-20
um                               allmodconfig   gcc-13.3.0
um                                allnoconfig   clang-17
um                                allnoconfig   gcc-14.1.0
um                               allyesconfig   gcc-12
um                               allyesconfig   gcc-13.3.0
um                                  defconfig   gcc-14.1.0
um                             i386_defconfig   gcc-14.1.0
um                    randconfig-001-20240808   gcc-12
um                    randconfig-002-20240808   gcc-12
um                           x86_64_defconfig   gcc-14.1.0
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240808   gcc-12
x86_64       buildonly-randconfig-002-20240808   gcc-12
x86_64       buildonly-randconfig-003-20240808   gcc-12
x86_64       buildonly-randconfig-004-20240808   gcc-12
x86_64       buildonly-randconfig-005-20240808   gcc-12
x86_64       buildonly-randconfig-006-20240808   gcc-12
x86_64                              defconfig   clang-18
x86_64                              defconfig   gcc-11
x86_64                randconfig-001-20240808   gcc-12
x86_64                randconfig-002-20240808   gcc-12
x86_64                randconfig-003-20240808   gcc-12
x86_64                randconfig-004-20240808   gcc-12
x86_64                randconfig-005-20240808   gcc-12
x86_64                randconfig-006-20240808   gcc-12
x86_64                randconfig-011-20240808   gcc-12
x86_64                randconfig-012-20240808   gcc-12
x86_64                randconfig-013-20240808   gcc-12
x86_64                randconfig-014-20240808   gcc-12
x86_64                randconfig-015-20240808   gcc-12
x86_64                randconfig-016-20240808   gcc-12
x86_64                randconfig-071-20240808   gcc-12
x86_64                randconfig-072-20240808   gcc-12
x86_64                randconfig-073-20240808   gcc-12
x86_64                randconfig-074-20240808   gcc-12
x86_64                randconfig-075-20240808   gcc-12
x86_64                randconfig-076-20240808   gcc-12
x86_64                          rhel-8.3-rust   clang-18
xtensa                            allnoconfig   gcc-13.2.0
xtensa                            allnoconfig   gcc-14.1.0
xtensa                randconfig-001-20240808   gcc-14.1.0
xtensa                randconfig-002-20240808   gcc-14.1.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

