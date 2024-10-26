Return-Path: <linux-wireless+bounces-14574-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A4AB9B17DB
	for <lists+linux-wireless@lfdr.de>; Sat, 26 Oct 2024 14:15:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B105B21618
	for <lists+linux-wireless@lfdr.de>; Sat, 26 Oct 2024 12:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF5121D5154;
	Sat, 26 Oct 2024 12:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kpy9qumU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500DC1D5175
	for <linux-wireless@vger.kernel.org>; Sat, 26 Oct 2024 12:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729944905; cv=none; b=Aopr1Cn4ZIUChrN089OukLq9aNr+NTrFdkElpiD4P80XFeiweUsWaX2y/P+fe9EZpagViDK1ytw7HS+lmuovibFucPApSsNSkE1satLnu0ssAX+nY9PbNE8Q8jSaLUtWbibW+wgQe4pYqVBBryAbzGBdgfZNIHRgmz9M9cTmK5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729944905; c=relaxed/simple;
	bh=CTiU0+/Ii2y4iELcgAPW6cecA3pJYwd3ZJdw9ak7EK4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=bX13Z1W05IHdtbvy0NMMZFQU7N6ONQfHxnWSg5cRLsJo30t0SV7CbYwGFpQ8nNqbihgnai/nCyNXj0fMpzbVs/0X7ocLz2K7S6U3Ma+raSOEHUdiu6QO9tZtngQ+tzh+UVfiPDRsrLpzqb6rg7Y9RopAStDiuvoic9pTiyc9uUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kpy9qumU; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729944904; x=1761480904;
  h=date:from:to:cc:subject:message-id;
  bh=CTiU0+/Ii2y4iELcgAPW6cecA3pJYwd3ZJdw9ak7EK4=;
  b=kpy9qumUBd+KAPOL5cY2Jwql5S6DiYmUD22L2+NNd6Af7qecO7j3g3Bo
   Tiu0+MmXust4KCnL+ca1s00UuQQPF7bzZZUzi2R17fZi94xOFAzaHd9lJ
   uRjJaHc/AwbRGdsUvGcjMwvt8LRqv/JwJIIur0HmytSC8+S3ldes0SmAe
   qybc9GHyW1P874EIGPtrsI22g5bL7iUT7/FMXfl6bgsIJQzOyU3XPKiha
   xHMRvjNAgsJ1AD5YV0on2Qz89+liQ2HuxV4/MVGU312vPC4ab2wbEzQJA
   MpdagQsPUhnyc5k1d+YYQEQvlE9BDuvFOdzEDafpNe0z8CiycOrpVifK9
   g==;
X-CSE-ConnectionGUID: pYwlZxIORgqtjjWPN+lhVw==
X-CSE-MsgGUID: kvKU3Rg/RcWrWyy4T6iBpg==
X-IronPort-AV: E=McAfee;i="6700,10204,11237"; a="29819665"
X-IronPort-AV: E=Sophos;i="6.11,235,1725346800"; 
   d="scan'208";a="29819665"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2024 05:15:03 -0700
X-CSE-ConnectionGUID: EVsUINUgSxykR29ojSm9tQ==
X-CSE-MsgGUID: JXKKao5vSaKLSQDnqlvn0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,235,1725346800"; 
   d="scan'208";a="81206446"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 26 Oct 2024 05:15:00 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t4fh4-000Zca-28;
	Sat, 26 Oct 2024 12:14:58 +0000
Date: Sat, 26 Oct 2024 20:14:22 +0800
From: kernel test robot <lkp@intel.com>
To: Johannes Berg <johannes.berg@intel.com>
Cc: Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org
Subject: [wireless:for-next] BUILD SUCCESS
 cf44e745048df2c935cb37de16e0ca476003a3b1
Message-ID: <202410262014.xPj5gZbn-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git for-next
branch HEAD: cf44e745048df2c935cb37de16e0ca476003a3b1  wifi: mac80211: ieee80211_i: Fix memory corruption bug in struct ieee80211_chanctx

elapsed time: 749m

configs tested: 172
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.1.0
alpha                            allyesconfig    clang-20
alpha                               defconfig    gcc-14.1.0
arc                              allmodconfig    clang-20
arc                               allnoconfig    gcc-14.1.0
arc                              allyesconfig    clang-20
arc                          axs103_defconfig    gcc-14.1.0
arc                                 defconfig    gcc-14.1.0
arc                   randconfig-001-20241026    gcc-14.1.0
arc                   randconfig-002-20241026    gcc-14.1.0
arm                              allmodconfig    clang-20
arm                               allnoconfig    gcc-14.1.0
arm                              allyesconfig    clang-20
arm                                 defconfig    gcc-14.1.0
arm                        multi_v5_defconfig    gcc-14.1.0
arm                        neponset_defconfig    gcc-14.1.0
arm                   randconfig-001-20241026    gcc-14.1.0
arm                   randconfig-002-20241026    gcc-14.1.0
arm                   randconfig-003-20241026    gcc-14.1.0
arm                   randconfig-004-20241026    gcc-14.1.0
arm                          sp7021_defconfig    gcc-14.1.0
arm                       versatile_defconfig    gcc-14.1.0
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.1.0
arm64                               defconfig    gcc-14.1.0
arm64                 randconfig-001-20241026    gcc-14.1.0
arm64                 randconfig-002-20241026    gcc-14.1.0
arm64                 randconfig-003-20241026    gcc-14.1.0
arm64                 randconfig-004-20241026    gcc-14.1.0
csky                              allnoconfig    gcc-14.1.0
csky                                defconfig    gcc-14.1.0
csky                  randconfig-001-20241026    gcc-14.1.0
csky                  randconfig-002-20241026    gcc-14.1.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.1.0
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    gcc-14.1.0
hexagon               randconfig-001-20241026    gcc-14.1.0
hexagon               randconfig-002-20241026    gcc-14.1.0
i386                             allmodconfig    clang-19
i386                              allnoconfig    clang-19
i386                             allyesconfig    clang-19
i386        buildonly-randconfig-001-20241026    gcc-12
i386        buildonly-randconfig-002-20241026    gcc-12
i386        buildonly-randconfig-003-20241026    gcc-12
i386        buildonly-randconfig-004-20241026    gcc-12
i386        buildonly-randconfig-005-20241026    gcc-12
i386        buildonly-randconfig-006-20241026    gcc-12
i386                                defconfig    clang-19
i386                  randconfig-001-20241026    gcc-12
i386                  randconfig-002-20241026    gcc-12
i386                  randconfig-003-20241026    gcc-12
i386                  randconfig-004-20241026    gcc-12
i386                  randconfig-005-20241026    gcc-12
i386                  randconfig-006-20241026    gcc-12
i386                  randconfig-011-20241026    gcc-12
i386                  randconfig-012-20241026    gcc-12
i386                  randconfig-013-20241026    gcc-12
i386                  randconfig-014-20241026    gcc-12
i386                  randconfig-015-20241026    gcc-12
i386                  randconfig-016-20241026    gcc-12
loongarch                        allmodconfig    gcc-14.1.0
loongarch                         allnoconfig    gcc-14.1.0
loongarch                           defconfig    gcc-14.1.0
loongarch             randconfig-001-20241026    gcc-14.1.0
loongarch             randconfig-002-20241026    gcc-14.1.0
m68k                             allmodconfig    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
m68k                             allyesconfig    gcc-14.1.0
m68k                         amcore_defconfig    gcc-14.1.0
m68k                                defconfig    gcc-14.1.0
m68k                           sun3_defconfig    gcc-14.1.0
microblaze                       allmodconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
microblaze                       allyesconfig    gcc-14.1.0
microblaze                          defconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
mips                          rb532_defconfig    gcc-14.1.0
nios2                             allnoconfig    gcc-14.1.0
nios2                               defconfig    gcc-14.1.0
nios2                 randconfig-001-20241026    gcc-14.1.0
nios2                 randconfig-002-20241026    gcc-14.1.0
openrisc                          allnoconfig    clang-20
openrisc                         allyesconfig    gcc-14.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.1.0
parisc                            allnoconfig    clang-20
parisc                           allyesconfig    gcc-14.1.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20241026    gcc-14.1.0
parisc                randconfig-002-20241026    gcc-14.1.0
parisc64                            defconfig    gcc-14.1.0
powerpc                     akebono_defconfig    gcc-14.1.0
powerpc                          allmodconfig    gcc-14.1.0
powerpc                           allnoconfig    clang-20
powerpc                          allyesconfig    gcc-14.1.0
powerpc                   bluestone_defconfig    gcc-14.1.0
powerpc                 canyonlands_defconfig    gcc-14.1.0
powerpc                     kmeter1_defconfig    gcc-14.1.0
powerpc               randconfig-001-20241026    gcc-14.1.0
powerpc               randconfig-002-20241026    gcc-14.1.0
powerpc               randconfig-003-20241026    gcc-14.1.0
powerpc64             randconfig-001-20241026    gcc-14.1.0
powerpc64             randconfig-002-20241026    gcc-14.1.0
powerpc64             randconfig-003-20241026    gcc-14.1.0
riscv                            allmodconfig    gcc-14.1.0
riscv                             allnoconfig    clang-20
riscv                            allyesconfig    gcc-14.1.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20241026    gcc-14.1.0
riscv                 randconfig-002-20241026    gcc-14.1.0
s390                             allmodconfig    gcc-14.1.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20241026    gcc-14.1.0
s390                  randconfig-002-20241026    gcc-14.1.0
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                                  defconfig    gcc-12
sh                        edosk7705_defconfig    gcc-14.1.0
sh                    randconfig-001-20241026    gcc-14.1.0
sh                    randconfig-002-20241026    gcc-14.1.0
sh                           se7619_defconfig    gcc-14.1.0
sh                        sh7757lcr_defconfig    gcc-14.1.0
sparc                            allmodconfig    gcc-14.1.0
sparc                       sparc64_defconfig    gcc-14.1.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20241026    gcc-14.1.0
sparc64               randconfig-002-20241026    gcc-14.1.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20241026    gcc-14.1.0
um                    randconfig-002-20241026    gcc-14.1.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20241026    clang-19
x86_64      buildonly-randconfig-002-20241026    clang-19
x86_64      buildonly-randconfig-003-20241026    clang-19
x86_64      buildonly-randconfig-004-20241026    clang-19
x86_64      buildonly-randconfig-005-20241026    clang-19
x86_64      buildonly-randconfig-006-20241026    clang-19
x86_64                              defconfig    clang-19
x86_64                                  kexec    clang-19
x86_64                                  kexec    gcc-12
x86_64                randconfig-001-20241026    clang-19
x86_64                randconfig-002-20241026    clang-19
x86_64                randconfig-003-20241026    clang-19
x86_64                randconfig-004-20241026    clang-19
x86_64                randconfig-005-20241026    clang-19
x86_64                randconfig-006-20241026    clang-19
x86_64                randconfig-011-20241026    clang-19
x86_64                randconfig-012-20241026    clang-19
x86_64                randconfig-013-20241026    clang-19
x86_64                randconfig-014-20241026    clang-19
x86_64                randconfig-015-20241026    clang-19
x86_64                randconfig-016-20241026    clang-19
x86_64                randconfig-071-20241026    clang-19
x86_64                randconfig-072-20241026    clang-19
x86_64                randconfig-073-20241026    clang-19
x86_64                randconfig-074-20241026    clang-19
x86_64                randconfig-075-20241026    clang-19
x86_64                randconfig-076-20241026    clang-19
x86_64                               rhel-8.3    gcc-12
xtensa                            allnoconfig    gcc-14.1.0
xtensa                randconfig-001-20241026    gcc-14.1.0
xtensa                randconfig-002-20241026    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

