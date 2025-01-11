Return-Path: <linux-wireless+bounces-17353-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A74B8A0A3F6
	for <lists+linux-wireless@lfdr.de>; Sat, 11 Jan 2025 14:39:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60EF1188AAAD
	for <lists+linux-wireless@lfdr.de>; Sat, 11 Jan 2025 13:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F500199234;
	Sat, 11 Jan 2025 13:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BoKCrvr7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627CB1A8F97
	for <linux-wireless@vger.kernel.org>; Sat, 11 Jan 2025 13:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736602755; cv=none; b=hD/cjftXoC47rGiTmG+xQZ5u/lC+WP84r+DT36ddr/YUjzlVD0cFPPc5K2JvktvaNOQTSxkZhyCzlmp3bS7ySB1TINga9Io1XuZyIOwJXx5ZuGCj1EGpEeVIzItT+ejbY7RsK3w4HkzQ9DdLN8YMcKBqgGbzx6TfP2Lo2gpThGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736602755; c=relaxed/simple;
	bh=XEdFVZGNOzKT7fpCKnSIaB74g+jK2g66DMXPai7Sf98=;
	h=Date:From:To:Cc:Subject:Message-ID; b=G9Wzn9LbXaq1ZLgG1ISpEs6h7nEx1AbGBfbtmKfSy+5BwkzL5ZFcY++8qhY8SQpSyfjVC4KcVgm1dqqtnn6nou1q10NXWzixHv7ZG7LKOAI0GV+s7k+ONfXCEsWGlfz8qemqduhUIr9PgCfz8Qb8vo4HpU77z60g0AxpPJatVlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BoKCrvr7; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736602754; x=1768138754;
  h=date:from:to:cc:subject:message-id;
  bh=XEdFVZGNOzKT7fpCKnSIaB74g+jK2g66DMXPai7Sf98=;
  b=BoKCrvr7mTuyG4ZWMzHkYDshCCrewnDwmgEVcnn+VZ1NPFSQK95LYNcY
   8TDtGn330ylRAVSMdMWxlcSPRxf9saAmnNG0Y7lJeOK7riqF3LiQ98kY5
   T5t5OHMhUcfdNnTSPJS/04mdB6uRHTrBnyT4dkFsdccW5sTyzZXzBt7Gb
   LcHKfq+QZsIT23md/Eqvwj4y6nM2SNz7Dmv5f0JcdibcN7GJxIpDUJaYd
   +BsfVN+yDNNrKT9RyQUKOeO/k3HkVqejkDIShvmYamVQrOmo1/ThQ0zMi
   4RaOW1dKYk5aNNxjpoEUYwJcQvmdQqCXAx5jMX4wegQ3YsUVlvrJWvR6j
   w==;
X-CSE-ConnectionGUID: fark56OmRM6PT2bW7vqb8g==
X-CSE-MsgGUID: mqfKX/GvRHavpF+K4UxtTA==
X-IronPort-AV: E=McAfee;i="6700,10204,11312"; a="47379506"
X-IronPort-AV: E=Sophos;i="6.12,307,1728975600"; 
   d="scan'208";a="47379506"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2025 05:39:12 -0800
X-CSE-ConnectionGUID: muSstjB4RSO2qjR2RLw2TQ==
X-CSE-MsgGUID: 5yXGE0X5QyW+qDRliMVQKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,307,1728975600"; 
   d="scan'208";a="103932180"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 11 Jan 2025 05:39:10 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tWbhj-000KhR-2U;
	Sat, 11 Jan 2025 13:39:07 +0000
Date: Sat, 11 Jan 2025 21:38:34 +0800
From: kernel test robot <lkp@intel.com>
To: Kalle Valo <kvalo@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>,
 linux-wireless@vger.kernel.org
Subject: [wireless-next:main] BUILD SUCCESS
 8221712a174ad83e36489c414c26619010f4e348
Message-ID: <202501112125.xAX4NzLC-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: 8221712a174ad83e36489c414c26619010f4e348  wifi: brcmfmac: Add missing Return: to function documentation

elapsed time: 1445m

configs tested: 219
configs skipped: 8

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-20
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    gcc-13.2.0
arc                   randconfig-001-20250110    gcc-13.2.0
arc                   randconfig-001-20250111    clang-18
arc                   randconfig-002-20250110    gcc-13.2.0
arc                   randconfig-002-20250111    clang-18
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    gcc-14.2.0
arm                            hisi_defconfig    gcc-14.2.0
arm                         lpc18xx_defconfig    clang-20
arm                   milbeaut_m10v_defconfig    clang-20
arm                   randconfig-001-20250110    clang-20
arm                   randconfig-001-20250111    clang-18
arm                   randconfig-002-20250110    gcc-14.2.0
arm                   randconfig-002-20250111    clang-18
arm                   randconfig-003-20250110    clang-19
arm                   randconfig-003-20250111    clang-18
arm                   randconfig-004-20250110    gcc-14.2.0
arm                   randconfig-004-20250111    clang-18
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250110    gcc-14.2.0
arm64                 randconfig-001-20250111    clang-18
arm64                 randconfig-002-20250110    gcc-14.2.0
arm64                 randconfig-002-20250111    clang-18
arm64                 randconfig-003-20250110    clang-17
arm64                 randconfig-003-20250111    clang-18
arm64                 randconfig-004-20250110    gcc-14.2.0
arm64                 randconfig-004-20250111    clang-18
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250111    gcc-14.2.0
csky                  randconfig-002-20250111    gcc-14.2.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-18
hexagon                          allyesconfig    clang-20
hexagon               randconfig-001-20250111    clang-20
hexagon               randconfig-001-20250111    gcc-14.2.0
hexagon               randconfig-002-20250111    clang-15
hexagon               randconfig-002-20250111    gcc-14.2.0
i386                             allmodconfig    clang-19
i386                              allnoconfig    clang-19
i386                             allyesconfig    clang-19
i386        buildonly-randconfig-001-20250110    clang-19
i386        buildonly-randconfig-001-20250111    gcc-11
i386        buildonly-randconfig-002-20250110    clang-19
i386        buildonly-randconfig-002-20250111    gcc-11
i386        buildonly-randconfig-003-20250110    clang-19
i386        buildonly-randconfig-003-20250111    gcc-11
i386        buildonly-randconfig-004-20250110    gcc-12
i386        buildonly-randconfig-004-20250111    gcc-11
i386        buildonly-randconfig-005-20250110    gcc-12
i386        buildonly-randconfig-005-20250111    gcc-11
i386        buildonly-randconfig-006-20250110    clang-19
i386        buildonly-randconfig-006-20250111    gcc-11
i386                                defconfig    clang-19
i386                  randconfig-001-20250111    clang-19
i386                  randconfig-002-20250111    clang-19
i386                  randconfig-003-20250111    clang-19
i386                  randconfig-004-20250111    clang-19
i386                  randconfig-005-20250111    clang-19
i386                  randconfig-006-20250111    clang-19
i386                  randconfig-007-20250111    clang-19
i386                  randconfig-011-20250111    clang-19
i386                  randconfig-012-20250111    clang-19
i386                  randconfig-013-20250111    clang-19
i386                  randconfig-014-20250111    clang-19
i386                  randconfig-015-20250111    clang-19
i386                  randconfig-016-20250111    clang-19
i386                  randconfig-017-20250111    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250111    gcc-14.2.0
loongarch             randconfig-002-20250111    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                          multi_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                           ci20_defconfig    gcc-14.2.0
mips                            gpr_defconfig    clang-20
nios2                         3c120_defconfig    clang-20
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250111    gcc-14.2.0
nios2                 randconfig-002-20250111    gcc-14.2.0
openrisc                         alldefconfig    gcc-14.2.0
openrisc                          allnoconfig    clang-20
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-20
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20250111    gcc-14.2.0
parisc                randconfig-002-20250111    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-20
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-16
powerpc                          allyesconfig    gcc-14.2.0
powerpc                     asp8347_defconfig    gcc-14.2.0
powerpc                     mpc512x_defconfig    clang-20
powerpc               randconfig-001-20250111    gcc-14.2.0
powerpc               randconfig-002-20250111    gcc-14.2.0
powerpc               randconfig-003-20250111    gcc-14.2.0
powerpc64             randconfig-001-20250111    gcc-14.2.0
powerpc64             randconfig-002-20250111    gcc-14.2.0
powerpc64             randconfig-003-20250111    gcc-14.2.0
riscv                            allmodconfig    clang-20
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    clang-20
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-20
riscv                            allyesconfig    gcc-14.2.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250110    clang-17
riscv                 randconfig-001-20250111    clang-18
riscv                 randconfig-001-20250111    gcc-14.2.0
riscv                 randconfig-002-20250110    clang-20
riscv                 randconfig-002-20250111    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250110    gcc-14.2.0
s390                  randconfig-001-20250111    clang-20
s390                  randconfig-001-20250111    gcc-14.2.0
s390                  randconfig-002-20250110    gcc-14.2.0
s390                  randconfig-002-20250111    clang-19
s390                  randconfig-002-20250111    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                     magicpanelr2_defconfig    gcc-14.2.0
sh                    randconfig-001-20250110    gcc-14.2.0
sh                    randconfig-001-20250111    gcc-14.2.0
sh                    randconfig-002-20250110    gcc-14.2.0
sh                    randconfig-002-20250111    gcc-14.2.0
sh                          rsk7203_defconfig    clang-20
sh                           sh2007_defconfig    clang-20
sh                              ul2_defconfig    clang-20
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250110    gcc-14.2.0
sparc                 randconfig-001-20250111    gcc-14.2.0
sparc                 randconfig-002-20250110    gcc-14.2.0
sparc                 randconfig-002-20250111    gcc-14.2.0
sparc                       sparc32_defconfig    gcc-14.2.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250110    gcc-14.2.0
sparc64               randconfig-001-20250111    gcc-14.2.0
sparc64               randconfig-002-20250110    gcc-14.2.0
sparc64               randconfig-002-20250111    gcc-14.2.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-18
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250110    clang-20
um                    randconfig-001-20250111    clang-18
um                    randconfig-001-20250111    gcc-14.2.0
um                    randconfig-002-20250110    gcc-12
um                    randconfig-002-20250111    clang-20
um                    randconfig-002-20250111    gcc-14.2.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250111    clang-19
x86_64      buildonly-randconfig-002-20250111    clang-19
x86_64      buildonly-randconfig-002-20250111    gcc-12
x86_64      buildonly-randconfig-003-20250111    clang-19
x86_64      buildonly-randconfig-003-20250111    gcc-12
x86_64      buildonly-randconfig-004-20250111    clang-19
x86_64      buildonly-randconfig-005-20250111    clang-19
x86_64      buildonly-randconfig-005-20250111    gcc-12
x86_64      buildonly-randconfig-006-20250111    clang-19
x86_64      buildonly-randconfig-006-20250111    gcc-12
x86_64                              defconfig    clang-19
x86_64                                  kexec    clang-19
x86_64                randconfig-001-20250111    clang-19
x86_64                randconfig-002-20250111    clang-19
x86_64                randconfig-003-20250111    clang-19
x86_64                randconfig-004-20250111    clang-19
x86_64                randconfig-005-20250111    clang-19
x86_64                randconfig-006-20250111    clang-19
x86_64                randconfig-007-20250111    clang-19
x86_64                randconfig-008-20250111    clang-19
x86_64                randconfig-071-20250111    gcc-12
x86_64                randconfig-072-20250111    gcc-12
x86_64                randconfig-073-20250111    gcc-12
x86_64                randconfig-074-20250111    gcc-12
x86_64                randconfig-075-20250111    gcc-12
x86_64                randconfig-076-20250111    gcc-12
x86_64                randconfig-077-20250111    gcc-12
x86_64                randconfig-078-20250111    gcc-12
x86_64                               rhel-9.4    clang-19
x86_64                           rhel-9.4-bpf    clang-19
x86_64                         rhel-9.4-kunit    clang-19
x86_64                           rhel-9.4-ltp    clang-19
x86_64                          rhel-9.4-rust    clang-19
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250110    gcc-14.2.0
xtensa                randconfig-001-20250111    gcc-14.2.0
xtensa                randconfig-002-20250110    gcc-14.2.0
xtensa                randconfig-002-20250111    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

