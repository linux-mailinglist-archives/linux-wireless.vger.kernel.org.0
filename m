Return-Path: <linux-wireless+bounces-23053-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 778F4AB957B
	for <lists+linux-wireless@lfdr.de>; Fri, 16 May 2025 07:27:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1547E7B242B
	for <lists+linux-wireless@lfdr.de>; Fri, 16 May 2025 05:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D80042165F3;
	Fri, 16 May 2025 05:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JUJYkYcC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D0F481C4
	for <linux-wireless@vger.kernel.org>; Fri, 16 May 2025 05:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747373227; cv=none; b=pBar3jkSXE1wnSFPhofJMS+s6kbN72UqtI4ddYqBzSNkvhqF4X+1A5NAz+NrP8PW4RkxdMWgqOvYKHpbDBkOllY03+hrnt45u+MGbjGByWizF6BRW3TYK0uzWK/Fnj26X15BLiQoUg3tp8kADcyoJRbZu5sYvianbG1cmdIebbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747373227; c=relaxed/simple;
	bh=LlWmQjHEjz1LzJKJijzE4BD4rvzXLmcM3wbkFVTIVS4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=mYIU5sqtt5P9J/L4DuwEf52/3LJNaFGcJUykF4hF+buW4JDrqG0snWZfqThbjRKyzmiVyV2GWXpU4XEE4Yq+oqV5yv41yHIV1Pt6evSU5Kd5XBycL7RpRu5cRC29GqI7BM8kOC7klTwTxuXxdcvwR8cUDVqFvqdlao+POpLu8H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JUJYkYcC; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747373226; x=1778909226;
  h=date:from:to:cc:subject:message-id;
  bh=LlWmQjHEjz1LzJKJijzE4BD4rvzXLmcM3wbkFVTIVS4=;
  b=JUJYkYcChAYc+k7XmWbUGi53lhZirKCeHgfKygLb4zx5ELp8Y+BRFzvs
   gnOyK8n6h9QFDsfefbx38g6uOB+M7JIsGyaKI3x6h5UqKB4hwBbdPoRMs
   wPEitjMgikygLEgkGkhxwFpw3fVtAyPE/BobbKCVFw6nWFf0GwUpzExLK
   6/68N6Yl+YgDIyYyc0Xo71kalE0cIFrQbN8uhy9/8BeZVG5EsAuicmHD5
   aH0qsCZeNxdioWpejv8hvREt3Mvgm78cnMUx1yyF6lynUrriWXY0X/oLS
   tQW0MP0RLcd+0zZjLt4JzsB5eMslTaexVV7H5fz6h141Vpwf+OFeqpWg+
   A==;
X-CSE-ConnectionGUID: Vq6ex+V7SmWx7LEfEs1DPw==
X-CSE-MsgGUID: tKxZcfbtSTOJR6/cy2DTww==
X-IronPort-AV: E=McAfee;i="6700,10204,11434"; a="49028920"
X-IronPort-AV: E=Sophos;i="6.15,293,1739865600"; 
   d="scan'208";a="49028920"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 22:27:06 -0700
X-CSE-ConnectionGUID: p9sNC06FQtSYMfd87bZf7A==
X-CSE-MsgGUID: k2QuSGpcQeGLXyTnTImJEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,293,1739865600"; 
   d="scan'208";a="139592971"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 15 May 2025 22:27:04 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uFnb3-000J17-2E;
	Fri, 16 May 2025 05:27:01 +0000
Date: Fri, 16 May 2025 13:26:03 +0800
From: kernel test robot <lkp@intel.com>
To: Johannes Berg <johannes.berg@intel.com>
Cc: Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org
Subject: [wireless:for-next] BUILD SUCCESS
 943aeda0d75a24038723414dff6f63e337821197
Message-ID: <202505161353.K1Kwbtxp-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git for-next
branch HEAD: 943aeda0d75a24038723414dff6f63e337821197  Merge tag 'mt76-fixes-2025-05-15' of https://github.com/nbd168/wireless

elapsed time: 1004m

configs tested: 231
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    clang-19
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-19
arc                   randconfig-001-20250515    gcc-12.4.0
arc                   randconfig-001-20250516    gcc-13.3.0
arc                   randconfig-001-20250516    gcc-9.5.0
arc                   randconfig-002-20250515    gcc-14.2.0
arc                   randconfig-002-20250516    gcc-13.3.0
arc                   randconfig-002-20250516    gcc-9.5.0
arm                              allmodconfig    clang-19
arm                               allnoconfig    clang-21
arm                              allyesconfig    clang-19
arm                          gemini_defconfig    clang-21
arm                            mps2_defconfig    clang-21
arm                   randconfig-001-20250515    clang-21
arm                   randconfig-001-20250516    gcc-7.5.0
arm                   randconfig-001-20250516    gcc-9.5.0
arm                   randconfig-002-20250515    gcc-8.5.0
arm                   randconfig-002-20250516    clang-21
arm                   randconfig-002-20250516    gcc-9.5.0
arm                   randconfig-003-20250515    gcc-8.5.0
arm                   randconfig-003-20250516    clang-21
arm                   randconfig-003-20250516    gcc-9.5.0
arm                   randconfig-004-20250515    clang-21
arm                   randconfig-004-20250516    clang-21
arm                   randconfig-004-20250516    gcc-9.5.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250515    clang-21
arm64                 randconfig-001-20250516    gcc-9.5.0
arm64                 randconfig-002-20250515    clang-21
arm64                 randconfig-002-20250516    gcc-9.5.0
arm64                 randconfig-003-20250515    clang-20
arm64                 randconfig-003-20250516    gcc-5.5.0
arm64                 randconfig-003-20250516    gcc-9.5.0
arm64                 randconfig-004-20250515    gcc-6.5.0
arm64                 randconfig-004-20250516    gcc-9.5.0
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250515    gcc-14.2.0
csky                  randconfig-001-20250516    clang-21
csky                  randconfig-002-20250515    gcc-14.2.0
csky                  randconfig-002-20250516    clang-21
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250515    clang-16
hexagon               randconfig-001-20250516    clang-21
hexagon               randconfig-002-20250515    clang-21
hexagon               randconfig-002-20250516    clang-21
i386                             alldefconfig    clang-21
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250515    gcc-11
i386        buildonly-randconfig-001-20250516    clang-20
i386        buildonly-randconfig-002-20250515    gcc-12
i386        buildonly-randconfig-002-20250516    clang-20
i386        buildonly-randconfig-003-20250515    clang-20
i386        buildonly-randconfig-003-20250516    clang-20
i386        buildonly-randconfig-004-20250515    clang-20
i386        buildonly-randconfig-004-20250516    clang-20
i386        buildonly-randconfig-005-20250515    gcc-12
i386        buildonly-randconfig-005-20250516    clang-20
i386        buildonly-randconfig-006-20250515    gcc-11
i386        buildonly-randconfig-006-20250516    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20250516    gcc-12
i386                  randconfig-002-20250516    gcc-12
i386                  randconfig-003-20250516    gcc-12
i386                  randconfig-004-20250516    gcc-12
i386                  randconfig-005-20250516    gcc-12
i386                  randconfig-006-20250516    gcc-12
i386                  randconfig-007-20250516    gcc-12
i386                  randconfig-011-20250516    gcc-12
i386                  randconfig-012-20250516    gcc-12
i386                  randconfig-013-20250516    gcc-12
i386                  randconfig-014-20250516    gcc-12
i386                  randconfig-015-20250516    gcc-12
i386                  randconfig-016-20250516    gcc-12
i386                  randconfig-017-20250516    gcc-12
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250515    gcc-12.4.0
loongarch             randconfig-001-20250516    clang-21
loongarch             randconfig-002-20250515    gcc-14.2.0
loongarch             randconfig-002-20250516    clang-21
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                          hp300_defconfig    clang-21
m68k                          sun3x_defconfig    clang-21
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                          ath79_defconfig    clang-21
mips                          eyeq6_defconfig    clang-21
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250515    gcc-12.4.0
nios2                 randconfig-001-20250516    clang-21
nios2                 randconfig-002-20250515    gcc-6.5.0
nios2                 randconfig-002-20250516    clang-21
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20250515    gcc-13.3.0
parisc                randconfig-001-20250516    clang-21
parisc                randconfig-002-20250515    gcc-13.3.0
parisc                randconfig-002-20250516    clang-21
powerpc                    adder875_defconfig    clang-21
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    gcc-14.2.0
powerpc                      bamboo_defconfig    clang-21
powerpc                     mpc83xx_defconfig    clang-21
powerpc                      pasemi_defconfig    clang-21
powerpc               randconfig-001-20250515    gcc-8.5.0
powerpc               randconfig-001-20250516    clang-21
powerpc               randconfig-002-20250515    gcc-6.5.0
powerpc               randconfig-002-20250516    clang-21
powerpc               randconfig-003-20250515    clang-21
powerpc               randconfig-003-20250516    clang-21
powerpc                     sequoia_defconfig    clang-21
powerpc                     skiroot_defconfig    clang-21
powerpc64             randconfig-001-20250515    clang-21
powerpc64             randconfig-001-20250516    clang-21
powerpc64             randconfig-002-20250515    gcc-8.5.0
powerpc64             randconfig-002-20250516    clang-21
powerpc64             randconfig-003-20250515    clang-21
powerpc64             randconfig-003-20250516    clang-21
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    gcc-14.2.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250515    gcc-8.5.0
riscv                 randconfig-001-20250516    gcc-7.5.0
riscv                 randconfig-002-20250515    gcc-14.2.0
riscv                 randconfig-002-20250516    gcc-7.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250515    clang-21
s390                  randconfig-001-20250516    gcc-7.5.0
s390                  randconfig-002-20250515    gcc-9.3.0
s390                  randconfig-002-20250516    gcc-7.5.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                    randconfig-001-20250515    gcc-14.2.0
sh                    randconfig-001-20250516    gcc-7.5.0
sh                    randconfig-002-20250515    gcc-10.5.0
sh                    randconfig-002-20250516    gcc-7.5.0
sh                            shmin_defconfig    clang-21
sh                              ul2_defconfig    clang-21
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250515    gcc-6.5.0
sparc                 randconfig-001-20250516    gcc-7.5.0
sparc                 randconfig-002-20250515    gcc-10.3.0
sparc                 randconfig-002-20250516    gcc-7.5.0
sparc                       sparc64_defconfig    clang-21
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250515    gcc-9.3.0
sparc64               randconfig-001-20250516    gcc-7.5.0
sparc64               randconfig-002-20250515    gcc-9.3.0
sparc64               randconfig-002-20250516    gcc-7.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250515    gcc-12
um                    randconfig-001-20250516    gcc-7.5.0
um                    randconfig-002-20250515    clang-21
um                    randconfig-002-20250516    gcc-7.5.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250515    clang-20
x86_64      buildonly-randconfig-001-20250516    gcc-12
x86_64      buildonly-randconfig-002-20250515    clang-20
x86_64      buildonly-randconfig-002-20250516    gcc-12
x86_64      buildonly-randconfig-003-20250515    clang-20
x86_64      buildonly-randconfig-003-20250516    gcc-12
x86_64      buildonly-randconfig-004-20250515    clang-20
x86_64      buildonly-randconfig-004-20250516    gcc-12
x86_64      buildonly-randconfig-005-20250515    clang-20
x86_64      buildonly-randconfig-005-20250516    gcc-12
x86_64      buildonly-randconfig-006-20250515    gcc-12
x86_64      buildonly-randconfig-006-20250516    gcc-12
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250516    gcc-12
x86_64                randconfig-002-20250516    gcc-12
x86_64                randconfig-003-20250516    gcc-12
x86_64                randconfig-004-20250516    gcc-12
x86_64                randconfig-005-20250516    gcc-12
x86_64                randconfig-006-20250516    gcc-12
x86_64                randconfig-007-20250516    gcc-12
x86_64                randconfig-008-20250516    gcc-12
x86_64                randconfig-071-20250516    clang-20
x86_64                randconfig-072-20250516    clang-20
x86_64                randconfig-073-20250516    clang-20
x86_64                randconfig-074-20250516    clang-20
x86_64                randconfig-075-20250516    clang-20
x86_64                randconfig-076-20250516    clang-20
x86_64                randconfig-077-20250516    clang-20
x86_64                randconfig-078-20250516    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-12
x86_64                         rhel-9.4-kunit    gcc-12
x86_64                           rhel-9.4-ltp    gcc-12
x86_64                          rhel-9.4-rust    clang-18
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250515    gcc-14.2.0
xtensa                randconfig-001-20250516    gcc-7.5.0
xtensa                randconfig-002-20250515    gcc-13.3.0
xtensa                randconfig-002-20250516    gcc-7.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

