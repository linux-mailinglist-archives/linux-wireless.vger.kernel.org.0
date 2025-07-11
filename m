Return-Path: <linux-wireless+bounces-25239-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B30B0105D
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Jul 2025 02:49:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 543555A5866
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Jul 2025 00:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDC2B539A;
	Fri, 11 Jul 2025 00:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TsOdnlN5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25B32907
	for <linux-wireless@vger.kernel.org>; Fri, 11 Jul 2025 00:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752194961; cv=none; b=gkmvC/w9sh8unnSOCrCKyTmIpyP5CyNCaATLeeTvt8K/6v/UsqxS9tlciS0yy/8K+cPNCilHwsE8ndtQQRXHDKosJs6ImUYZbgXXxOwGEMjCUes8sjvNRELyKoExoPgB7E810Na7zQRgfo8WJpMqwrFrDMbq5loX+fUDZA5YY24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752194961; c=relaxed/simple;
	bh=ck8BZ3deoTnpaMLiZ9XPqYYSCzk25rBfrI/74+svisg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=RBE10EdPBoKsjol8KCw8xb52GxNW93vOcvt/NcjbLXqVVWfr92l2NzH5DprUUkULN/74WkebMQtFh+tcgBody5K5X9TUL3wzRIHy7SkQZzQOi8604SM79iD6KRxIjHFXCJ+yoH01a4640Xcg2tEcE84Bg0caP0ywyCsrY2GqQJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TsOdnlN5; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752194960; x=1783730960;
  h=date:from:to:cc:subject:message-id;
  bh=ck8BZ3deoTnpaMLiZ9XPqYYSCzk25rBfrI/74+svisg=;
  b=TsOdnlN586+zgxRMcS5jL2881ED1p0icMjdFtJzdBdICIYBzkynqsEOv
   kSfr3k56h1jDwhQCplh0sD4tvqwZfCjW0Mat6uTn1c/yYx1k8Pa311Xws
   hiip5pGAOkbqEf9xdO/CYB4NT9j2c2EJ93v+/MfmNVAaJDVACiVOI3oah
   lqIKjzYEbtGLZnGqDjPTeuebe5994a8+9FjOl1Mo5U9HjH7VKQAIDDz9Q
   uJuoPZCRzJXK8l6Asb+FV71SZS2KrEjezykwGGDLCnAhRw5/fAY9bvtIi
   fBVjHwQz+M4X/zLHznq4KX7XSLO32M09d8jEdaLRp8xTpKEKxSQMJwJa9
   A==;
X-CSE-ConnectionGUID: koRb1PxDRPKsROFldhfJXg==
X-CSE-MsgGUID: sO+FPzICQZ6X6+iYu/rcqg==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="54621079"
X-IronPort-AV: E=Sophos;i="6.16,302,1744095600"; 
   d="scan'208";a="54621079"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 17:49:19 -0700
X-CSE-ConnectionGUID: n1EsuP37Q5u1x4goY11Ukw==
X-CSE-MsgGUID: SgMH8MijQea+oO0HBlze/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,302,1744095600"; 
   d="scan'208";a="156581010"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 10 Jul 2025 17:49:18 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ua1wx-0005f1-1n;
	Fri, 11 Jul 2025 00:49:15 +0000
Date: Fri, 11 Jul 2025 08:48:52 +0800
From: kernel test robot <lkp@intel.com>
To: Johannes Berg <johannes.berg@intel.com>
Cc: Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org
Subject: [wireless:for-next] BUILD SUCCESS
 c07981af55d3ba3ec3be880cfe4a0cc10f1f7138
Message-ID: <202507110840.GUF2wRuA-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git for-next
branch HEAD: c07981af55d3ba3ec3be880cfe4a0cc10f1f7138  wifi: mac80211: add the virtual monitor after reconfig complete

elapsed time: 755m

configs tested: 229
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    clang-21
alpha                            allyesconfig    clang-19
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    clang-19
arc                              allmodconfig    clang-19
arc                               allnoconfig    clang-21
arc                              allyesconfig    clang-19
arc                                 defconfig    clang-19
arc                   randconfig-001-20250710    gcc-15.1.0
arc                   randconfig-001-20250711    clang-21
arc                   randconfig-002-20250710    gcc-12.4.0
arc                   randconfig-002-20250711    clang-21
arm                              allmodconfig    clang-19
arm                               allnoconfig    clang-21
arm                              allyesconfig    clang-19
arm                                 defconfig    clang-19
arm                   randconfig-001-20250710    gcc-8.5.0
arm                   randconfig-001-20250711    clang-21
arm                   randconfig-002-20250710    clang-21
arm                   randconfig-002-20250711    clang-21
arm                   randconfig-003-20250710    clang-21
arm                   randconfig-003-20250711    clang-21
arm                   randconfig-004-20250710    gcc-8.5.0
arm                   randconfig-004-20250711    clang-21
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    clang-21
arm64                               defconfig    clang-19
arm64                 randconfig-001-20250710    clang-21
arm64                 randconfig-001-20250711    clang-21
arm64                 randconfig-002-20250710    clang-21
arm64                 randconfig-002-20250711    clang-21
arm64                 randconfig-003-20250710    gcc-8.5.0
arm64                 randconfig-003-20250711    clang-21
arm64                 randconfig-004-20250710    clang-21
arm64                 randconfig-004-20250711    clang-21
csky                              allnoconfig    clang-21
csky                                defconfig    clang-19
csky                  randconfig-001-20250710    gcc-15.1.0
csky                  randconfig-001-20250711    gcc-15.1.0
csky                  randconfig-002-20250710    gcc-15.1.0
csky                  randconfig-002-20250711    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    clang-19
hexagon               randconfig-001-20250710    clang-21
hexagon               randconfig-001-20250711    gcc-15.1.0
hexagon               randconfig-002-20250710    clang-21
hexagon               randconfig-002-20250711    gcc-15.1.0
i386                             allmodconfig    clang-20
i386                              allnoconfig    clang-20
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20250710    gcc-12
i386        buildonly-randconfig-001-20250711    gcc-11
i386        buildonly-randconfig-002-20250710    gcc-12
i386        buildonly-randconfig-002-20250711    gcc-11
i386        buildonly-randconfig-003-20250710    clang-20
i386        buildonly-randconfig-003-20250711    gcc-11
i386        buildonly-randconfig-004-20250710    gcc-11
i386        buildonly-randconfig-004-20250711    gcc-11
i386        buildonly-randconfig-005-20250710    clang-20
i386        buildonly-randconfig-005-20250711    gcc-11
i386        buildonly-randconfig-006-20250710    clang-20
i386        buildonly-randconfig-006-20250711    gcc-11
i386                                defconfig    clang-20
i386                  randconfig-001-20250711    gcc-12
i386                  randconfig-002-20250711    gcc-12
i386                  randconfig-003-20250711    gcc-12
i386                  randconfig-004-20250711    gcc-12
i386                  randconfig-005-20250711    gcc-12
i386                  randconfig-006-20250711    gcc-12
i386                  randconfig-007-20250711    gcc-12
i386                  randconfig-011-20250711    gcc-12
i386                  randconfig-012-20250711    gcc-12
i386                  randconfig-013-20250711    gcc-12
i386                  randconfig-014-20250711    gcc-12
i386                  randconfig-015-20250711    gcc-12
i386                  randconfig-016-20250711    gcc-12
i386                  randconfig-017-20250711    gcc-12
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-21
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20250710    gcc-14.3.0
loongarch             randconfig-001-20250711    gcc-15.1.0
loongarch             randconfig-002-20250710    gcc-15.1.0
loongarch             randconfig-002-20250711    gcc-15.1.0
m68k                             allmodconfig    clang-19
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    clang-19
microblaze                       allmodconfig    clang-19
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    clang-19
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20250710    gcc-9.3.0
nios2                 randconfig-001-20250711    gcc-15.1.0
nios2                 randconfig-002-20250710    gcc-12.4.0
nios2                 randconfig-002-20250711    gcc-15.1.0
openrisc                          allnoconfig    clang-21
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-21
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250710    gcc-8.5.0
parisc                randconfig-001-20250711    gcc-15.1.0
parisc                randconfig-002-20250710    gcc-8.5.0
parisc                randconfig-002-20250711    gcc-15.1.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-21
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    gcc-15.1.0
powerpc               randconfig-001-20250710    gcc-12.4.0
powerpc               randconfig-001-20250711    gcc-15.1.0
powerpc               randconfig-002-20250710    gcc-9.3.0
powerpc               randconfig-002-20250711    gcc-15.1.0
powerpc               randconfig-003-20250710    gcc-8.5.0
powerpc               randconfig-003-20250711    gcc-15.1.0
powerpc64             randconfig-001-20250710    gcc-11.5.0
powerpc64             randconfig-001-20250711    gcc-15.1.0
powerpc64             randconfig-002-20250710    clang-17
powerpc64             randconfig-002-20250711    gcc-15.1.0
powerpc64             randconfig-003-20250710    gcc-14.3.0
powerpc64             randconfig-003-20250711    gcc-15.1.0
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    clang-21
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250710    gcc-15.1.0
riscv                 randconfig-001-20250711    gcc-9.3.0
riscv                 randconfig-002-20250710    gcc-10.5.0
riscv                 randconfig-002-20250711    gcc-9.3.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250710    gcc-14.3.0
s390                  randconfig-001-20250711    gcc-9.3.0
s390                  randconfig-002-20250710    clang-17
s390                  randconfig-002-20250711    gcc-9.3.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-12
sh                    randconfig-001-20250710    gcc-15.1.0
sh                    randconfig-001-20250711    gcc-9.3.0
sh                    randconfig-002-20250710    gcc-13.4.0
sh                    randconfig-002-20250711    gcc-9.3.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250710    gcc-13.4.0
sparc                 randconfig-001-20250711    gcc-9.3.0
sparc                 randconfig-002-20250710    gcc-14.3.0
sparc                 randconfig-002-20250711    gcc-9.3.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250710    gcc-8.5.0
sparc64               randconfig-001-20250711    gcc-9.3.0
sparc64               randconfig-002-20250710    gcc-15.1.0
sparc64               randconfig-002-20250711    gcc-9.3.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250710    gcc-11
um                    randconfig-001-20250711    gcc-9.3.0
um                    randconfig-002-20250710    clang-16
um                    randconfig-002-20250711    gcc-9.3.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250710    gcc-12
x86_64      buildonly-randconfig-001-20250711    clang-20
x86_64      buildonly-randconfig-002-20250710    gcc-12
x86_64      buildonly-randconfig-002-20250711    clang-20
x86_64      buildonly-randconfig-003-20250710    gcc-12
x86_64      buildonly-randconfig-003-20250711    clang-20
x86_64      buildonly-randconfig-004-20250710    clang-20
x86_64      buildonly-randconfig-004-20250711    clang-20
x86_64      buildonly-randconfig-005-20250710    clang-20
x86_64      buildonly-randconfig-005-20250711    clang-20
x86_64      buildonly-randconfig-006-20250710    clang-20
x86_64      buildonly-randconfig-006-20250711    clang-20
x86_64                              defconfig    clang-20
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250711    clang-20
x86_64                randconfig-002-20250711    clang-20
x86_64                randconfig-003-20250711    clang-20
x86_64                randconfig-004-20250711    clang-20
x86_64                randconfig-005-20250711    clang-20
x86_64                randconfig-006-20250711    clang-20
x86_64                randconfig-007-20250711    clang-20
x86_64                randconfig-008-20250711    clang-20
x86_64                randconfig-071-20250711    clang-20
x86_64                randconfig-072-20250711    clang-20
x86_64                randconfig-073-20250711    clang-20
x86_64                randconfig-074-20250711    clang-20
x86_64                randconfig-075-20250711    clang-20
x86_64                randconfig-076-20250711    clang-20
x86_64                randconfig-077-20250711    clang-20
x86_64                randconfig-078-20250711    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-12
x86_64                         rhel-9.4-kunit    gcc-12
x86_64                           rhel-9.4-ltp    gcc-12
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250710    gcc-12.4.0
xtensa                randconfig-001-20250711    gcc-9.3.0
xtensa                randconfig-002-20250710    gcc-14.3.0
xtensa                randconfig-002-20250711    gcc-9.3.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

