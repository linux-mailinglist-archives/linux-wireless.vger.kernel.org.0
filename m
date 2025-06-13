Return-Path: <linux-wireless+bounces-24094-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43541AD95B0
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Jun 2025 21:39:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A56603A78CC
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Jun 2025 19:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53AFE3FE7;
	Fri, 13 Jun 2025 19:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QjK72P0l"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A1F22B59D
	for <linux-wireless@vger.kernel.org>; Fri, 13 Jun 2025 19:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749843555; cv=none; b=Bod78aEQQbco44CEIaHPztwBhco9llXots77rgbV/DaF/ZIurWKKg4ExrxZiSAI5+oh9yAXsxB0xQqPleTxSn7eDQRQhcDnADaESDUlCW2vwqLXirnyQ7Hb3wry91mlPKQzeQc8tfKDOgIILZRsaKDbo9fRcysa6HrVTjb2Q5gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749843555; c=relaxed/simple;
	bh=sV36VXgpQduBxQrExKYMk+yr7X1DxQaa20/pSg5avgk=;
	h=Date:From:To:Cc:Subject:Message-ID; b=OIOzImQ+UD27d4VwTuV6m6vUfANI2ShmA5HhIZmcqiVZ3rJ7e5cyqW0F4K7xAE4ueWeVSWdH24XygKSIDQy6m8Xg4xK02LcvsaUz4u0j4v6dfViJEet7ZDa40XmA6RiOtO/ouFat/TwacJshMmHxAvUKJnVCaxyrl2FCYErO29g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QjK72P0l; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749843554; x=1781379554;
  h=date:from:to:cc:subject:message-id;
  bh=sV36VXgpQduBxQrExKYMk+yr7X1DxQaa20/pSg5avgk=;
  b=QjK72P0lNtIMRG4P86v8ipuNayxYAGXOS/qpQAMJgmfmXl3N2wOCTAcc
   jjQzUZAcYxKwHqhnd46E1Daph8vUi+CuvLgvi1yoGCgEh/veIKwY87u0K
   ssd2Y+2P9lNiy94Yrjf6OjVMF2zRK1fA8g8q6EFrYQrzByWZQagg1Se5v
   HpvuTQpJomDsVTu7wSdpJ2Z2aFu73nORqyFRMIaV5KMz8yywCyZMR0zO+
   bMkmUbdaaExDVPLW0+ibd8TrEM4iVOYQbQBbMHfsUqpnGgj2YvLWTRIa1
   k0ApvH7a9BXtpoBcCZPuqwqjmAJ9Zdy84RESuBqkmGcEdE+ounBpONAfI
   g==;
X-CSE-ConnectionGUID: NKKWCN/XQL67MUdDc8/Vog==
X-CSE-MsgGUID: D0eWz2YeTnu5V5hfg42Lfg==
X-IronPort-AV: E=McAfee;i="6800,10657,11463"; a="52053093"
X-IronPort-AV: E=Sophos;i="6.16,234,1744095600"; 
   d="scan'208";a="52053093"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2025 12:39:13 -0700
X-CSE-ConnectionGUID: 7tO9pmyRSS6WJ/RZu4T1wg==
X-CSE-MsgGUID: ruqWlcmSQayhTkbiXZg8Rg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,234,1744095600"; 
   d="scan'208";a="152871920"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 13 Jun 2025 12:39:11 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uQAF2-000Cwy-0P;
	Fri, 13 Jun 2025 19:39:08 +0000
Date: Sat, 14 Jun 2025 03:38:30 +0800
From: kernel test robot <lkp@intel.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>,
 Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org
Subject: [wireless-next:main] BUILD SUCCESS
 535de528015b56e34a40a8e1eb1629fadf809a84
Message-ID: <202506140320.0ERV9ZDm-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: 535de528015b56e34a40a8e1eb1629fadf809a84  Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net

elapsed time: 1445m

configs tested: 231
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            alldefconfig    clang-21
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                              allmodconfig    clang-19
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-19
arc                                 defconfig    gcc-15.1.0
arc                   randconfig-001-20250613    gcc-12.4.0
arc                   randconfig-002-20250613    gcc-12.4.0
arm                              allmodconfig    clang-19
arm                               allnoconfig    gcc-15.1.0
arm                              allyesconfig    clang-19
arm                                 defconfig    gcc-15.1.0
arm                            mps2_defconfig    clang-21
arm                   randconfig-001-20250613    clang-21
arm                   randconfig-002-20250613    clang-20
arm                   randconfig-003-20250613    gcc-8.5.0
arm                   randconfig-004-20250613    clang-21
arm                           sunxi_defconfig    clang-21
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20250613    gcc-15.1.0
arm64                 randconfig-002-20250613    clang-21
arm64                 randconfig-003-20250613    clang-21
arm64                 randconfig-004-20250613    gcc-15.1.0
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20250613    gcc-13.3.0
csky                  randconfig-001-20250613    gcc-15.1.0
csky                  randconfig-002-20250613    gcc-13.3.0
csky                  randconfig-002-20250613    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    gcc-15.1.0
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    gcc-15.1.0
hexagon               randconfig-001-20250613    clang-21
hexagon               randconfig-001-20250613    gcc-13.3.0
hexagon               randconfig-002-20250613    clang-21
hexagon               randconfig-002-20250613    gcc-13.3.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250613    gcc-12
i386        buildonly-randconfig-001-20250614    clang-20
i386        buildonly-randconfig-002-20250613    gcc-11
i386        buildonly-randconfig-002-20250613    gcc-12
i386        buildonly-randconfig-002-20250614    clang-20
i386        buildonly-randconfig-003-20250613    gcc-12
i386        buildonly-randconfig-003-20250614    clang-20
i386        buildonly-randconfig-004-20250613    clang-20
i386        buildonly-randconfig-004-20250613    gcc-12
i386        buildonly-randconfig-004-20250614    clang-20
i386        buildonly-randconfig-005-20250613    clang-20
i386        buildonly-randconfig-005-20250613    gcc-12
i386        buildonly-randconfig-005-20250614    clang-20
i386        buildonly-randconfig-006-20250613    gcc-12
i386        buildonly-randconfig-006-20250614    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20250613    clang-20
i386                  randconfig-001-20250614    clang-20
i386                  randconfig-002-20250613    clang-20
i386                  randconfig-002-20250614    clang-20
i386                  randconfig-003-20250613    clang-20
i386                  randconfig-003-20250614    clang-20
i386                  randconfig-004-20250613    clang-20
i386                  randconfig-004-20250614    clang-20
i386                  randconfig-005-20250613    clang-20
i386                  randconfig-005-20250614    clang-20
i386                  randconfig-006-20250613    clang-20
i386                  randconfig-006-20250614    clang-20
i386                  randconfig-007-20250613    clang-20
i386                  randconfig-007-20250614    clang-20
i386                  randconfig-011-20250613    clang-20
i386                  randconfig-012-20250613    clang-20
i386                  randconfig-013-20250613    clang-20
i386                  randconfig-014-20250613    clang-20
i386                  randconfig-015-20250613    clang-20
i386                  randconfig-016-20250613    clang-20
i386                  randconfig-017-20250613    clang-20
loongarch                        allmodconfig    gcc-15.1.0
loongarch                         allnoconfig    gcc-15.1.0
loongarch                           defconfig    gcc-15.1.0
loongarch             randconfig-001-20250613    gcc-13.3.0
loongarch             randconfig-001-20250613    gcc-15.1.0
loongarch             randconfig-002-20250613    gcc-13.3.0
loongarch             randconfig-002-20250613    gcc-15.1.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
m68k                          multi_defconfig    gcc-15.1.0
m68k                          sun3x_defconfig    clang-21
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                        maltaup_defconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20250613    gcc-11.5.0
nios2                 randconfig-001-20250613    gcc-13.3.0
nios2                 randconfig-002-20250613    gcc-11.5.0
nios2                 randconfig-002-20250613    gcc-13.3.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-12
openrisc                       virt_defconfig    clang-21
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20250613    gcc-13.3.0
parisc                randconfig-001-20250613    gcc-8.5.0
parisc                randconfig-002-20250613    gcc-13.3.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-21
powerpc                          allyesconfig    gcc-15.1.0
powerpc                      arches_defconfig    gcc-15.1.0
powerpc                        cell_defconfig    clang-21
powerpc                      chrp32_defconfig    gcc-15.1.0
powerpc                      pasemi_defconfig    gcc-15.1.0
powerpc               randconfig-001-20250613    clang-21
powerpc               randconfig-001-20250613    gcc-13.3.0
powerpc               randconfig-002-20250613    gcc-13.3.0
powerpc               randconfig-002-20250613    gcc-8.5.0
powerpc               randconfig-003-20250613    gcc-13.3.0
powerpc               randconfig-003-20250613    gcc-9.3.0
powerpc64             randconfig-001-20250613    gcc-13.3.0
powerpc64             randconfig-001-20250613    gcc-8.5.0
powerpc64             randconfig-002-20250613    gcc-13.3.0
powerpc64             randconfig-002-20250613    gcc-8.5.0
powerpc64             randconfig-003-20250613    gcc-10.5.0
powerpc64             randconfig-003-20250613    gcc-13.3.0
riscv                            allmodconfig    clang-21
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250613    gcc-15.1.0
riscv                 randconfig-001-20250613    gcc-8.5.0
riscv                 randconfig-002-20250613    clang-21
riscv                 randconfig-002-20250613    gcc-15.1.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250613    clang-21
s390                  randconfig-001-20250613    gcc-15.1.0
s390                  randconfig-002-20250613    clang-21
s390                  randconfig-002-20250613    gcc-15.1.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-12
sh                        edosk7705_defconfig    gcc-15.1.0
sh                             espt_defconfig    clang-21
sh                    randconfig-001-20250613    gcc-15.1.0
sh                    randconfig-002-20250613    gcc-15.1.0
sh                          sdk7780_defconfig    clang-21
sh                          sdk7780_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                 randconfig-001-20250613    gcc-10.3.0
sparc                 randconfig-001-20250613    gcc-15.1.0
sparc                 randconfig-002-20250613    gcc-13.3.0
sparc                 randconfig-002-20250613    gcc-15.1.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250613    gcc-15.1.0
sparc64               randconfig-002-20250613    gcc-15.1.0
sparc64               randconfig-002-20250613    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250613    gcc-12
um                    randconfig-001-20250613    gcc-15.1.0
um                    randconfig-002-20250613    gcc-12
um                    randconfig-002-20250613    gcc-15.1.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250613    clang-20
x86_64      buildonly-randconfig-001-20250613    gcc-12
x86_64      buildonly-randconfig-002-20250613    gcc-12
x86_64      buildonly-randconfig-003-20250613    gcc-12
x86_64      buildonly-randconfig-004-20250613    gcc-12
x86_64      buildonly-randconfig-005-20250613    clang-20
x86_64      buildonly-randconfig-005-20250613    gcc-12
x86_64      buildonly-randconfig-006-20250613    gcc-12
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250613    gcc-12
x86_64                randconfig-002-20250613    gcc-12
x86_64                randconfig-003-20250613    gcc-12
x86_64                randconfig-004-20250613    gcc-12
x86_64                randconfig-005-20250613    gcc-12
x86_64                randconfig-006-20250613    gcc-12
x86_64                randconfig-007-20250613    gcc-12
x86_64                randconfig-008-20250613    gcc-12
x86_64                randconfig-071-20250613    gcc-12
x86_64                randconfig-072-20250613    gcc-12
x86_64                randconfig-073-20250613    gcc-12
x86_64                randconfig-074-20250613    gcc-12
x86_64                randconfig-075-20250613    gcc-12
x86_64                randconfig-076-20250613    gcc-12
x86_64                randconfig-077-20250613    gcc-12
x86_64                randconfig-078-20250613    gcc-12
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-12
x86_64                         rhel-9.4-kunit    gcc-12
x86_64                           rhel-9.4-ltp    gcc-12
x86_64                          rhel-9.4-rust    clang-18
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250613    gcc-15.1.0
xtensa                randconfig-001-20250613    gcc-8.5.0
xtensa                randconfig-002-20250613    gcc-15.1.0
xtensa                    smp_lx200_defconfig    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

