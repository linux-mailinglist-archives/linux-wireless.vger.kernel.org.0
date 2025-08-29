Return-Path: <linux-wireless+bounces-26867-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 649DDB3BC87
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Aug 2025 15:31:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BCA9188B4E4
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Aug 2025 13:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 947B3218ADD;
	Fri, 29 Aug 2025 13:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R+EcPNGg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B634A1DB122
	for <linux-wireless@vger.kernel.org>; Fri, 29 Aug 2025 13:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756474257; cv=none; b=o5TsJw21I8+N56/8qn3i7p4ibvkTIUljQ/39itrp4s8bf7E/dF/qhWM7O8P4q8WrpIbBPNkYa/BQreuZdhzAGVgAosAzKjRCb0avRTGIGJRKMHNLbhspmzEToJi7uLyLK/9UDGo2kT3WaKXoIj3FHJbrIvIX6KyjMVXTg4kYdU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756474257; c=relaxed/simple;
	bh=OKKkAN+XqL2jDgCW6DJVEMaCXlGXgzbE6gzPAr2kq3g=;
	h=Date:From:To:Cc:Subject:Message-ID; b=C9/nULemWz8kjzSM2mXAvGoaije2YjfZTdob52a+AW81afC/AXGi3u/KH9tWKtXPHFrYkaHcBfLDsxrr1vJbyBeSzrbZ71c1Y92sf/+bXjYmvK9g5ojVpEcWzvrLwmLYeZ3+s2yn9wVQWCe7BNxNvlvpOkDh2Hbpv/8k3OayyvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R+EcPNGg; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756474256; x=1788010256;
  h=date:from:to:cc:subject:message-id;
  bh=OKKkAN+XqL2jDgCW6DJVEMaCXlGXgzbE6gzPAr2kq3g=;
  b=R+EcPNGgk2IbP0+/ItRYYPDXOj5gfuC64vylX2tWWL8ZgKrptprAPhv9
   lz2Pj80a9cdBlDjGHxIF/UqKr3KTr9Tma4nvWOFiPCCSa6WxMbayX9iwH
   fKzflTzMJG4mO0Dh4kXYQPmhhcjFPu7jZ0ZOoq+2L46PrS8ZnYJ9LUY5a
   orQ7amIbiQkz8TdMEMPFR2gLI6Makkt6kJWJ3/lkoXiIrr40aqjju0oRD
   sAWS4vjdeWc8HjxMvyV56BRbkJgKPhvEAnilPddQ4KUIMu5T+eh3WbxI9
   FNlqBU5FS2eMgwHceswIdDOA1iaoIkxOgo6ZxMxpGKak10ALcMHze/bJM
   Q==;
X-CSE-ConnectionGUID: 9Lm3QPDrQzCuGdSy9nQN7Q==
X-CSE-MsgGUID: 0qTfkZoyQyWYMpRXspBjfQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11537"; a="46327561"
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="46327561"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 06:30:55 -0700
X-CSE-ConnectionGUID: iNH0BP96QvywkW5ffF56+Q==
X-CSE-MsgGUID: BghM2EuvQrWYGkYCieWGJg==
X-ExtLoop1: 1
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by fmviesa003.fm.intel.com with ESMTP; 29 Aug 2025 06:30:54 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1urzBh-000Ug1-11;
	Fri, 29 Aug 2025 13:30:43 +0000
Date: Fri, 29 Aug 2025 21:29:06 +0800
From: kernel test robot <lkp@intel.com>
To: Johannes Berg <johannes.berg@intel.com>
Cc: Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org
Subject: [wireless:for-next] BUILD SUCCESS
 2c72c8d356db40178be558bbbd43a1d0b5bd0c27
Message-ID: <202508292156.f3Bip1qg-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git for-next
branch HEAD: 2c72c8d356db40178be558bbbd43a1d0b5bd0c27  Merge tag 'iwlwifi-fixes-2025-08-28' of https://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next

elapsed time: 1451m

configs tested: 213
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    clang-22
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    clang-19
arc                              allmodconfig    clang-19
arc                               allnoconfig    clang-22
arc                              allyesconfig    clang-19
arc                                 defconfig    clang-19
arc                         haps_hs_defconfig    gcc-15.1.0
arc                   randconfig-001-20250829    gcc-12.5.0
arc                   randconfig-001-20250829    gcc-8.5.0
arc                   randconfig-002-20250829    gcc-10.5.0
arc                   randconfig-002-20250829    gcc-12.5.0
arm                              allmodconfig    clang-19
arm                               allnoconfig    clang-22
arm                              allyesconfig    clang-19
arm                                 defconfig    clang-19
arm                          exynos_defconfig    gcc-15.1.0
arm                          ixp4xx_defconfig    gcc-15.1.0
arm                         lpc18xx_defconfig    gcc-15.1.0
arm                   randconfig-001-20250829    gcc-10.5.0
arm                   randconfig-001-20250829    gcc-12.5.0
arm                   randconfig-002-20250829    clang-22
arm                   randconfig-002-20250829    gcc-12.5.0
arm                   randconfig-003-20250829    clang-22
arm                   randconfig-003-20250829    gcc-12.5.0
arm                   randconfig-004-20250829    clang-22
arm                   randconfig-004-20250829    gcc-12.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    clang-22
arm64                               defconfig    clang-19
arm64                 randconfig-001-20250829    clang-22
arm64                 randconfig-001-20250829    gcc-12.5.0
arm64                 randconfig-002-20250829    gcc-12.5.0
arm64                 randconfig-003-20250829    clang-22
arm64                 randconfig-003-20250829    gcc-12.5.0
arm64                 randconfig-004-20250829    gcc-12.5.0
arm64                 randconfig-004-20250829    gcc-9.5.0
csky                              allnoconfig    clang-22
csky                                defconfig    clang-19
csky                  randconfig-001-20250829    clang-22
csky                  randconfig-001-20250829    gcc-9.5.0
csky                  randconfig-002-20250829    clang-22
csky                  randconfig-002-20250829    gcc-10.5.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-22
hexagon                             defconfig    clang-19
hexagon               randconfig-001-20250829    clang-22
hexagon               randconfig-002-20250829    clang-22
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250829    clang-20
i386        buildonly-randconfig-001-20250829    gcc-12
i386        buildonly-randconfig-002-20250829    clang-20
i386        buildonly-randconfig-003-20250829    clang-20
i386        buildonly-randconfig-004-20250829    clang-20
i386        buildonly-randconfig-005-20250829    clang-20
i386        buildonly-randconfig-005-20250829    gcc-12
i386        buildonly-randconfig-006-20250829    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20250829    clang-20
i386                  randconfig-002-20250829    clang-20
i386                  randconfig-003-20250829    clang-20
i386                  randconfig-004-20250829    clang-20
i386                  randconfig-005-20250829    clang-20
i386                  randconfig-006-20250829    clang-20
i386                  randconfig-007-20250829    clang-20
i386                  randconfig-011-20250829    clang-20
i386                  randconfig-012-20250829    clang-20
i386                  randconfig-013-20250829    clang-20
i386                  randconfig-014-20250829    clang-20
i386                  randconfig-015-20250829    clang-20
i386                  randconfig-016-20250829    clang-20
i386                  randconfig-017-20250829    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20250829    clang-22
loongarch             randconfig-002-20250829    clang-22
m68k                             allmodconfig    clang-19
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
m68k                             allyesconfig    gcc-15.1.0
m68k                       bvme6000_defconfig    gcc-15.1.0
m68k                                defconfig    clang-19
microblaze                       allmodconfig    clang-19
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    clang-19
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20250829    clang-22
nios2                 randconfig-001-20250829    gcc-11.5.0
nios2                 randconfig-002-20250829    clang-22
nios2                 randconfig-002-20250829    gcc-11.5.0
openrisc                          allnoconfig    clang-22
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250829    clang-22
parisc                randconfig-001-20250829    gcc-14.3.0
parisc                randconfig-002-20250829    clang-22
parisc                randconfig-002-20250829    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                          allyesconfig    clang-22
powerpc                          allyesconfig    gcc-15.1.0
powerpc                     asp8347_defconfig    gcc-15.1.0
powerpc                        fsp2_defconfig    gcc-15.1.0
powerpc               randconfig-001-20250829    clang-22
powerpc               randconfig-001-20250829    gcc-13.4.0
powerpc               randconfig-002-20250829    clang-22
powerpc               randconfig-003-20250829    clang-22
powerpc               randconfig-003-20250829    gcc-12.5.0
powerpc64             randconfig-001-20250829    clang-22
powerpc64             randconfig-002-20250829    clang-22
powerpc64             randconfig-003-20250829    clang-22
powerpc64             randconfig-003-20250829    gcc-8.5.0
riscv                            allmodconfig    clang-22
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    clang-22
riscv                            allyesconfig    clang-16
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250829    clang-22
riscv                 randconfig-002-20250829    gcc-9.5.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250829    gcc-11.5.0
s390                  randconfig-002-20250829    gcc-8.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-12
sh                 kfr2r09-romimage_defconfig    gcc-15.1.0
sh                    randconfig-001-20250829    gcc-10.5.0
sh                    randconfig-002-20250829    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250829    gcc-15.1.0
sparc                 randconfig-002-20250829    gcc-15.1.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250829    clang-20
sparc64               randconfig-002-20250829    clang-22
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250829    clang-22
um                    randconfig-002-20250829    gcc-12
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250829    clang-20
x86_64      buildonly-randconfig-001-20250829    gcc-11
x86_64      buildonly-randconfig-002-20250829    clang-20
x86_64      buildonly-randconfig-002-20250829    gcc-11
x86_64      buildonly-randconfig-003-20250829    clang-20
x86_64      buildonly-randconfig-003-20250829    gcc-12
x86_64      buildonly-randconfig-004-20250829    clang-20
x86_64      buildonly-randconfig-005-20250829    clang-20
x86_64      buildonly-randconfig-006-20250829    clang-20
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250829    gcc-12
x86_64                randconfig-002-20250829    gcc-12
x86_64                randconfig-003-20250829    gcc-12
x86_64                randconfig-004-20250829    gcc-12
x86_64                randconfig-005-20250829    gcc-12
x86_64                randconfig-006-20250829    gcc-12
x86_64                randconfig-007-20250829    gcc-12
x86_64                randconfig-008-20250829    gcc-12
x86_64                randconfig-071-20250829    clang-20
x86_64                randconfig-072-20250829    clang-20
x86_64                randconfig-073-20250829    clang-20
x86_64                randconfig-074-20250829    clang-20
x86_64                randconfig-075-20250829    clang-20
x86_64                randconfig-076-20250829    clang-20
x86_64                randconfig-077-20250829    clang-20
x86_64                randconfig-078-20250829    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-12
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-12
x86_64                           rhel-9.4-ltp    gcc-12
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250829    gcc-11.5.0
xtensa                randconfig-002-20250829    gcc-11.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

