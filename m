Return-Path: <linux-wireless+bounces-8303-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8EBC8D4654
	for <lists+linux-wireless@lfdr.de>; Thu, 30 May 2024 09:46:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C5771F21DCE
	for <lists+linux-wireless@lfdr.de>; Thu, 30 May 2024 07:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B5AFC12C;
	Thu, 30 May 2024 07:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cooyeQhH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D7EC2E9
	for <linux-wireless@vger.kernel.org>; Thu, 30 May 2024 07:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717055160; cv=none; b=rHzZB2x5v6QJU1YbW7YhvplsaYwgeMyT4Z3loqYN60XCZ33PLf/1jl8wubewtWRk5/OcRZlNWnYLJ96uDy1fEWJdx5SM/F8wIaMfQgjbcex0cz0KoaeHGERvZlUccbAtbK29f+cVfpHMtyzEpTotwuTQ2IdF9/CRxwUp3gN2vAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717055160; c=relaxed/simple;
	bh=yyH930KymM7MfBpugdhjLH6IjP6OXgynacvp2wQKxm4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=uHbnll+r6P1EuFt6cnzkurtLLjVgw4bm3+q/5pA40ClvPY3Y3v4vGhUn7dHP+zssYePTscpI/AjWTvxLiTPJqPQGpqnN2W2HzIjsO+pa8E2k9z0J5hNEppabc7KQz2D21SuLY8+Hz/ah5T/MQkhbQbWjqNxJbs4OioJcYx3+cEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cooyeQhH; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717055159; x=1748591159;
  h=date:from:to:cc:subject:message-id;
  bh=yyH930KymM7MfBpugdhjLH6IjP6OXgynacvp2wQKxm4=;
  b=cooyeQhHCdnliA+UWLT2FK4qOPwxNGgt+JZaC4wf9zX4RjQle2Y9hQTw
   WjwR0w7B2Uy3ZR8+27igWMhwsMzpYyO7mkjvosVfuApXg84FrnRSCk2MB
   izFWYnwF/z8wGtulftNxy+Ekh0yNgdKKeXxJh86CpSjR85/WKB8Tolvub
   uJTVcu/CZvMYWZ09y5j/HyZVwN/0uQQ1mVKiGSIEQ3Fq5F7vA3CWOrC4N
   3cRV4DDzemvzHFTVDMKKNpZzKZmw9tsTicIUATytZUGXSAu1uJGgnjlg6
   s5IuoqFEk3YjqQIfINCPhMU08gtme8CdwQ8kKabHmcRsrx6GLOBHKy0e2
   A==;
X-CSE-ConnectionGUID: ECndYdECSpeV9IoCUQWe1w==
X-CSE-MsgGUID: +nj4/FEWQCu0aGWEQCeMdg==
X-IronPort-AV: E=McAfee;i="6600,9927,11087"; a="24073230"
X-IronPort-AV: E=Sophos;i="6.08,199,1712646000"; 
   d="scan'208";a="24073230"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 00:45:58 -0700
X-CSE-ConnectionGUID: 0xHjIGckQbeLwcBSDRVpQg==
X-CSE-MsgGUID: F6PNf9d2SM+lt1o9pF3tpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,199,1712646000"; 
   d="scan'208";a="35705923"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 30 May 2024 00:45:56 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sCaTx-000Ey7-2Y;
	Thu, 30 May 2024 07:45:53 +0000
Date: Thu, 30 May 2024 15:45:01 +0800
From: kernel test robot <lkp@intel.com>
To: Johannes Berg <johannes.berg@intel.com>
Cc: Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org
Subject: [wireless-next:main] BUILD SUCCESS
 8526f8c877baf3f9e678b31fd7d1066b776775cc
Message-ID: <202405301559.1BVnFZ8b-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: 8526f8c877baf3f9e678b31fd7d1066b776775cc  wifi: nl80211: clean up coalescing rule handling

elapsed time: 1311m

configs tested: 205
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                          axs101_defconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240530   gcc  
arc                   randconfig-002-20240530   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                         bcm2835_defconfig   clang
arm                                 defconfig   clang
arm                            hisi_defconfig   gcc  
arm                          moxart_defconfig   gcc  
arm                       netwinder_defconfig   gcc  
arm                   randconfig-001-20240530   clang
arm                   randconfig-002-20240530   gcc  
arm                   randconfig-003-20240530   clang
arm                   randconfig-004-20240530   gcc  
arm                       spear13xx_defconfig   gcc  
arm                    vt8500_v6_v7_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240530   clang
arm64                 randconfig-002-20240530   gcc  
arm64                 randconfig-003-20240530   gcc  
arm64                 randconfig-004-20240530   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240530   gcc  
csky                  randconfig-002-20240530   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240530   clang
hexagon               randconfig-002-20240530   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240529   clang
i386         buildonly-randconfig-002-20240529   gcc  
i386         buildonly-randconfig-003-20240529   gcc  
i386         buildonly-randconfig-003-20240530   clang
i386         buildonly-randconfig-004-20240529   clang
i386         buildonly-randconfig-004-20240530   clang
i386         buildonly-randconfig-005-20240529   gcc  
i386         buildonly-randconfig-005-20240530   clang
i386         buildonly-randconfig-006-20240529   clang
i386         buildonly-randconfig-006-20240530   clang
i386                                defconfig   clang
i386                  randconfig-001-20240529   clang
i386                  randconfig-002-20240529   gcc  
i386                  randconfig-002-20240530   clang
i386                  randconfig-003-20240529   gcc  
i386                  randconfig-004-20240529   gcc  
i386                  randconfig-004-20240530   clang
i386                  randconfig-005-20240529   clang
i386                  randconfig-006-20240529   clang
i386                  randconfig-011-20240529   clang
i386                  randconfig-011-20240530   clang
i386                  randconfig-012-20240529   clang
i386                  randconfig-013-20240529   clang
i386                  randconfig-013-20240530   clang
i386                  randconfig-014-20240529   gcc  
i386                  randconfig-014-20240530   clang
i386                  randconfig-015-20240529   clang
i386                  randconfig-016-20240529   gcc  
i386                  randconfig-016-20240530   clang
loongarch                        alldefconfig   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240530   gcc  
loongarch             randconfig-002-20240530   gcc  
m68k                             alldefconfig   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                            mac_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                        bcm47xx_defconfig   clang
mips                  decstation_64_defconfig   gcc  
mips                      fuloong2e_defconfig   gcc  
mips                   sb1250_swarm_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240530   gcc  
nios2                 randconfig-002-20240530   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc                    or1ksim_defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240530   gcc  
parisc                randconfig-002-20240530   gcc  
parisc64                            defconfig   gcc  
powerpc                    adder875_defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc               randconfig-001-20240530   gcc  
powerpc               randconfig-002-20240530   clang
powerpc               randconfig-003-20240530   gcc  
powerpc                         wii_defconfig   gcc  
powerpc64             randconfig-001-20240530   gcc  
powerpc64             randconfig-002-20240530   clang
powerpc64             randconfig-003-20240530   clang
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240530   clang
riscv                 randconfig-002-20240530   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240530   clang
s390                  randconfig-002-20240530   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                         ecovec24_defconfig   gcc  
sh                    randconfig-001-20240530   gcc  
sh                    randconfig-002-20240530   gcc  
sh                          rsk7269_defconfig   gcc  
sh                           se7712_defconfig   gcc  
sh                           se7750_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240530   gcc  
sparc64               randconfig-002-20240530   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240530   gcc  
um                    randconfig-002-20240530   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240530   clang
x86_64       buildonly-randconfig-002-20240530   clang
x86_64       buildonly-randconfig-003-20240530   gcc  
x86_64       buildonly-randconfig-004-20240530   gcc  
x86_64       buildonly-randconfig-005-20240530   clang
x86_64       buildonly-randconfig-006-20240530   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240530   clang
x86_64                randconfig-002-20240530   clang
x86_64                randconfig-003-20240530   clang
x86_64                randconfig-004-20240530   clang
x86_64                randconfig-005-20240530   clang
x86_64                randconfig-006-20240530   clang
x86_64                randconfig-011-20240530   clang
x86_64                randconfig-012-20240530   gcc  
x86_64                randconfig-013-20240530   gcc  
x86_64                randconfig-014-20240530   gcc  
x86_64                randconfig-015-20240530   clang
x86_64                randconfig-016-20240530   gcc  
x86_64                randconfig-071-20240530   clang
x86_64                randconfig-072-20240530   clang
x86_64                randconfig-073-20240530   clang
x86_64                randconfig-074-20240530   clang
x86_64                randconfig-075-20240530   gcc  
x86_64                randconfig-076-20240530   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                  cadence_csp_defconfig   gcc  
xtensa                       common_defconfig   gcc  
xtensa                  nommu_kc705_defconfig   gcc  
xtensa                randconfig-001-20240530   gcc  
xtensa                randconfig-002-20240530   gcc  
xtensa                    smp_lx200_defconfig   gcc  
xtensa                         virt_defconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

