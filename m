Return-Path: <linux-wireless+bounces-8037-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C21508CE0CC
	for <lists+linux-wireless@lfdr.de>; Fri, 24 May 2024 07:55:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78AC6282D0D
	for <lists+linux-wireless@lfdr.de>; Fri, 24 May 2024 05:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 734F71272D6;
	Fri, 24 May 2024 05:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CA2rWSwF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA35079C2
	for <linux-wireless@vger.kernel.org>; Fri, 24 May 2024 05:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716530133; cv=none; b=qIXDV4nXafrOMtjd07gR5lbi2o18Ei952ubn8j7mujhENzoBTtX/ZldRwOQ4P6hPdNxE9eeTAeRx8BBv6GLdX3RwkhnGMwWCBX1GAorQbaxsFfZvDyuLGPnReTYKkzC08A7BJcnLUWVXA6VqJ8Yt5s/jxb0RMDVTxquWaf4beM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716530133; c=relaxed/simple;
	bh=8nWnJWTvB2o5JB6q+txG/NesKzngV/zQM87uHBnTyQI=;
	h=Date:From:To:Cc:Subject:Message-ID; b=I67i/fKhNcfFRHip+q5Q5/Z3kmrcWZ1KreglROtBtaD4MBCIO6Tv7XBzHouRyBDGYa3znRQrR7EScKiWZr1oGw84E08s64ruHabX5m9wbIpNJ3pfhw5WGqUAypTxwRZ3LjRWgcFakwWLNNKHjytpiUDUxcG6hua3r6vT41wTD8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CA2rWSwF; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716530132; x=1748066132;
  h=date:from:to:cc:subject:message-id;
  bh=8nWnJWTvB2o5JB6q+txG/NesKzngV/zQM87uHBnTyQI=;
  b=CA2rWSwFIy0p6xYpah+/xIbtIeNgLbqVM53pOVUKL42KnJwau1inUYto
   nsyTJlLog0QZ38Bw5n+tof+ACzyAXeIfApn8mLq9QoLnSPvgH+NIh9Kr9
   EF3dTbl9ffrTNOCCIBZl/0D5ukUs8kAKWMFR9HRfppoJ5EpEvFVklyN/S
   ciRdUhIjFRX8V3HR1NVaQXaYeGuRtyO6bByiafQ0hhJeQckJWGJOenD/d
   GtNJtqn6YTj1Dhw/nxOMzFOvPi7j6pUrd8dq/er1HYsZWwggbberdv5JX
   vOJI3qRnImksuJOfXwuDmWlEmuu2CQk4f+yQaohh5/3wRpitPQUY+dA41
   A==;
X-CSE-ConnectionGUID: JCbRC9x+Q1iLAIKpnszr8w==
X-CSE-MsgGUID: 3Dron/HCRYSaavC2bEBQMA==
X-IronPort-AV: E=McAfee;i="6600,9927,11081"; a="13071782"
X-IronPort-AV: E=Sophos;i="6.08,184,1712646000"; 
   d="scan'208";a="13071782"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2024 22:55:31 -0700
X-CSE-ConnectionGUID: evSRg16sRGyzP/FZXMNBrw==
X-CSE-MsgGUID: uAB3Jxx1SfaDvVhUhkr5eQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,184,1712646000"; 
   d="scan'208";a="38899222"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 23 May 2024 22:55:30 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sANtn-0003wD-2H;
	Fri, 24 May 2024 05:55:27 +0000
Date: Fri, 24 May 2024 13:54:28 +0800
From: kernel test robot <lkp@intel.com>
To: Johannes Berg <johannes.berg@intel.com>
Cc: Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org
Subject: [wireless-next:main] BUILD REGRESSION
 a92fd2d9327ba877f29753eec15b93072ac300b0
Message-ID: <202405241325.m4aBVktQ-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: a92fd2d9327ba877f29753eec15b93072ac300b0  wifi: mac80211: send DelBA with correct BSSID

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202405240755.nD7VAvLn-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

drivers/net/wireless/intel/iwlwifi/dvm/eeprom.o: warning: objtool: unexpected relocation symbol type in .rela.discard.reachable
drivers/net/wireless/intel/iwlwifi/iwl-nvm-utils.o: warning: objtool: unexpected relocation symbol type in .rela.discard.reachable

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
`-- loongarch-defconfig
    |-- drivers-net-wireless-intel-iwlwifi-dvm-eeprom.o:warning:objtool:unexpected-relocation-symbol-type-in-.rela.discard.reachable
    `-- drivers-net-wireless-intel-iwlwifi-iwl-nvm-utils.o:warning:objtool:unexpected-relocation-symbol-type-in-.rela.discard.reachable

elapsed time: 1193m

configs tested: 123
configs skipped: 3

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240524   gcc  
arc                   randconfig-002-20240524   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                   randconfig-001-20240524   clang
arm                   randconfig-002-20240524   gcc  
arm                   randconfig-003-20240524   gcc  
arm                   randconfig-004-20240524   clang
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240524   clang
arm64                 randconfig-002-20240524   clang
arm64                 randconfig-003-20240524   gcc  
arm64                 randconfig-004-20240524   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240524   gcc  
csky                  randconfig-002-20240524   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240524   clang
hexagon               randconfig-002-20240524   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240523   clang
i386         buildonly-randconfig-002-20240523   gcc  
i386         buildonly-randconfig-003-20240523   clang
i386         buildonly-randconfig-004-20240523   clang
i386         buildonly-randconfig-005-20240523   clang
i386         buildonly-randconfig-006-20240523   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240523   gcc  
i386                  randconfig-002-20240523   clang
i386                  randconfig-003-20240523   clang
i386                  randconfig-004-20240523   clang
i386                  randconfig-005-20240523   gcc  
i386                  randconfig-006-20240523   clang
i386                  randconfig-011-20240523   gcc  
i386                  randconfig-012-20240523   clang
i386                  randconfig-013-20240523   clang
i386                  randconfig-014-20240523   gcc  
i386                  randconfig-015-20240523   gcc  
i386                  randconfig-016-20240523   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240524   gcc  
loongarch             randconfig-002-20240524   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240524   gcc  
nios2                 randconfig-002-20240524   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240524   gcc  
parisc                randconfig-002-20240524   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc               randconfig-001-20240524   gcc  
powerpc               randconfig-002-20240524   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64                              defconfig   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

