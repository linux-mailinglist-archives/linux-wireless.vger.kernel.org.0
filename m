Return-Path: <linux-wireless+bounces-3818-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B1BE85C2D3
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Feb 2024 18:38:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36A241C21D7A
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Feb 2024 17:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24FD477F0A;
	Tue, 20 Feb 2024 17:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jE3TvetQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72F577653
	for <linux-wireless@vger.kernel.org>; Tue, 20 Feb 2024 17:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708450711; cv=none; b=G2l9TDX16oZtsp/TAOOsxl4FbvzL9VwUi7OJMR1w2SNYaamBBgUECeQYNDWjUtAixY4qjK4OJs9M0GctZxpxuGcxsE0hYLp866bjJLOT+10pa5LJgLJsY5hJt+AoVrAhostP13mBOV0BWskvfEbpjLdJmQtu02R1jaiW5+zqgpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708450711; c=relaxed/simple;
	bh=wygr7bhiBI8wW7jJkCuMoI1IVra1T42txVSGeyI6wag=;
	h=Date:From:To:Cc:Subject:Message-ID; b=ONX3YcXsTt4kFzG7/JHef6c2i594+9YZuQ2zPW6K7fcBCr0HHydEzBn7TlsZU7bo459wB0orEGD9Hc3cYGUGYOtXzEpUv1nJ+Bf0k2CreVBKzrErTRwmIOcWoctoS5PxAtLLfAb2gn5goji4XdYWc5jkOZukh8cR0yQdVDvH0Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jE3TvetQ; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708450709; x=1739986709;
  h=date:from:to:cc:subject:message-id;
  bh=wygr7bhiBI8wW7jJkCuMoI1IVra1T42txVSGeyI6wag=;
  b=jE3TvetQ5KHOca8VEm/diJ1i1QgOds6uWMprKP8r1+LBDUqcM+pEcLgC
   4kCrDa9rBGQTnxHDohg/77/kt71n89TjMhLqE2ojPrD1bu4ZSQ89inQpd
   XBLa99GfTHOKug3whGQTIHiDsH1QqeOahCg4fAGVa/LfWRNfEte70Xel5
   uUSFpAW9fbeKcmpsM+a0nXa8Kq7ys3NAm6RgSlpKztuX+2RT7o33BKTN7
   FVRULddbNiHT5ki3GUJC2hks0YSsN3jPJ9T6U77I88LNjRwD25S+ciShf
   55YMn++KocvtUuDDtCBLZpCV+tswoLY9OYy2cqCHFobipJZjSR0S7jZGc
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="13687876"
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="13687876"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 09:38:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="4826972"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by fmviesa010.fm.intel.com with ESMTP; 20 Feb 2024 09:38:03 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rcU49-0004j9-05;
	Tue, 20 Feb 2024 17:38:01 +0000
Date: Wed, 21 Feb 2024 01:37:44 +0800
From: kernel test robot <lkp@intel.com>
To: Kalle Valo <kvalo@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>,
 linux-wireless@vger.kernel.org
Subject: [wireless-next:main] BUILD SUCCESS
 dd66185c23f71af36397bebfc99ede608dca07b6
Message-ID: <202402210141.FIEFrXsi-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: dd66185c23f71af36397bebfc99ede608dca07b6  wifi: wilc1000: add missing read critical sections around vif list traversal

elapsed time: 1450m

configs tested: 163
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                        nsim_700_defconfig   gcc  
arc                   randconfig-001-20240220   gcc  
arc                   randconfig-002-20240220   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                        multi_v7_defconfig   gcc  
arm                       omap2plus_defconfig   gcc  
arm                   randconfig-002-20240220   gcc  
arm                   randconfig-003-20240220   gcc  
arm                   randconfig-004-20240220   gcc  
arm                         wpcm450_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240220   gcc  
csky                  randconfig-002-20240220   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-003-20240220   clang
i386         buildonly-randconfig-004-20240220   clang
i386                                defconfig   clang
i386                  randconfig-003-20240220   clang
i386                  randconfig-004-20240220   clang
i386                  randconfig-006-20240220   clang
i386                  randconfig-011-20240220   clang
i386                  randconfig-014-20240220   clang
i386                  randconfig-015-20240220   clang
i386                  randconfig-016-20240220   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch                 loongson3_defconfig   gcc  
loongarch             randconfig-001-20240220   gcc  
loongarch             randconfig-002-20240220   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                            mac_defconfig   gcc  
m68k                          multi_defconfig   gcc  
m68k                           sun3_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                     decstation_defconfig   gcc  
mips                           ip27_defconfig   gcc  
mips                     loongson1c_defconfig   gcc  
mips                      maltasmvp_defconfig   gcc  
mips                           rs90_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240220   gcc  
nios2                 randconfig-002-20240220   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240220   gcc  
parisc                randconfig-002-20240220   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                      arches_defconfig   gcc  
powerpc                    ge_imp3a_defconfig   gcc  
powerpc                 mpc8313_rdb_defconfig   gcc  
powerpc                         ps3_defconfig   gcc  
powerpc               randconfig-001-20240220   gcc  
powerpc64             randconfig-001-20240220   gcc  
powerpc64             randconfig-002-20240220   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                          debug_defconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240220   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                        dreamcast_defconfig   gcc  
sh                             espt_defconfig   gcc  
sh                          r7785rp_defconfig   gcc  
sh                    randconfig-001-20240220   gcc  
sh                    randconfig-002-20240220   gcc  
sh                          rsk7264_defconfig   gcc  
sh                           se7343_defconfig   gcc  
sh                           sh2007_defconfig   gcc  
sh                     sh7710voipgw_defconfig   gcc  
sh                             shx3_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240220   gcc  
sparc64               randconfig-002-20240220   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                    randconfig-001-20240220   gcc  
um                    randconfig-002-20240220   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240220   clang
x86_64       buildonly-randconfig-002-20240220   clang
x86_64       buildonly-randconfig-004-20240220   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-004-20240220   clang
x86_64                randconfig-005-20240220   clang
x86_64                randconfig-012-20240220   clang
x86_64                randconfig-013-20240220   clang
x86_64                randconfig-015-20240220   clang
x86_64                randconfig-071-20240220   clang
x86_64                randconfig-072-20240220   clang
x86_64                randconfig-073-20240220   clang
x86_64                randconfig-074-20240220   clang
x86_64                randconfig-075-20240220   clang
x86_64                randconfig-076-20240220   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                  cadence_csp_defconfig   gcc  
xtensa                randconfig-001-20240220   gcc  
xtensa                randconfig-002-20240220   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

