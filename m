Return-Path: <linux-wireless+bounces-28118-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D76FDBF477D
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Oct 2025 05:14:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BBD218C546D
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Oct 2025 03:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 609871F63D9;
	Tue, 21 Oct 2025 03:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LxVnhAZP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01EF178F4A
	for <linux-wireless@vger.kernel.org>; Tue, 21 Oct 2025 03:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761016450; cv=none; b=mqwhYIRTkqjHWfU2mFH3xLNjGH8IVTdNosnH6mK1EZYMXRh9GjIkGF22HRhPRbtC19XZJKAtgAfRDbrEDVZAENcxUPHcO0C+YDFgyxUyGK5Y8e7dDVONn15EjmcdVqm+kG3gsZSt1b8HNNvlrDloLuVWOA3xHUAefz1tUPuywGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761016450; c=relaxed/simple;
	bh=RbqXrLn4pPEcxOdJIr466uNGDzuefLZ01YAXnK4AHnE=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Z5pv+3Jng1kMZ/l8MWbfbI7la9RP0CxonkTiWrZLfgE0ThWVyTz4Uya+8HFQKCmbfnUjkRZKrjafDFcK+LMDx2sgYow3Rgt7j+RAzPOabCjiU9WmeXgRUXYg7bZmurBnTphYZ96ACBVI7gCaV1g4wnoY38TzjY8zHBa/bvKYeTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LxVnhAZP; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761016448; x=1792552448;
  h=date:from:to:cc:subject:message-id;
  bh=RbqXrLn4pPEcxOdJIr466uNGDzuefLZ01YAXnK4AHnE=;
  b=LxVnhAZP0/ONpIY6ZTEtsnSScK59lJzPGtlZ6lH+jayAzkLhjFgj2mFl
   qpGVjo5DQvMveeg5D3r0MqimEsbIDIpa8f9NhbY7ss3g992kIKy06QY42
   7p9QcQZA9vwuP5un7sQTUI8DS3Pdhj2x68I+fx6k4YBOQ4CB8rXlxjwGc
   +f5Qc0cthGUM5rYJAU7D7oaC4GhOPLZqrRSgkR7SBvr1UK3ZqCDuAEMUC
   QDKg04rXAyGrfYcRA3zI7sttRlkup3G5SZqEgSz8a6lcKhIwvzhr8dsL3
   +Kp36TUx/2k1mhz8ypd3N7d53aiexwiPelsRTr3JTM9LS8hRl4uZVmKV7
   A==;
X-CSE-ConnectionGUID: DHWx5z0TRPK3OY0638tHkQ==
X-CSE-MsgGUID: b9MqbucgR+Woj/Fm5rOMsg==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="74482549"
X-IronPort-AV: E=Sophos;i="6.19,243,1754982000"; 
   d="scan'208";a="74482549"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2025 20:14:07 -0700
X-CSE-ConnectionGUID: ZjVaYpfdQrykQyJUDoEgBg==
X-CSE-MsgGUID: ah/XIRcwT66sMPYHHWcbvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,243,1754982000"; 
   d="scan'208";a="187750798"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 20 Oct 2025 20:14:06 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vB2p1-000APx-12;
	Tue, 21 Oct 2025 03:14:03 +0000
Date: Tue, 21 Oct 2025 11:13:36 +0800
From: kernel test robot <lkp@intel.com>
To: Johannes Berg <johannes.berg@intel.com>
Cc: linux-wireless@vger.kernel.org
Subject: [wireless:for-next] BUILD SUCCESS
 69e4b75a5b90ef74300c283c0aafe8d41daf13a8
Message-ID: <202510211129.JeDfRG6x-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git for-next
branch HEAD: 69e4b75a5b90ef74300c283c0aafe8d41daf13a8  Merge tag 'iwlwifi-fixes-2025-10-19' of https://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next

elapsed time: 756m

configs tested: 250
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    clang-22
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    clang-22
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                   randconfig-001-20251020    gcc-14.3.0
arc                   randconfig-001-20251021    clang-22
arc                   randconfig-001-20251021    gcc-8.5.0
arc                   randconfig-002-20251020    gcc-8.5.0
arc                   randconfig-002-20251021    clang-22
arc                   randconfig-002-20251021    gcc-9.5.0
arc                        vdk_hs38_defconfig    gcc-15.1.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                           imxrt_defconfig    gcc-15.1.0
arm                   randconfig-001-20251020    gcc-14.3.0
arm                   randconfig-001-20251021    clang-22
arm                   randconfig-002-20251020    clang-22
arm                   randconfig-002-20251021    clang-22
arm                   randconfig-003-20251020    clang-22
arm                   randconfig-003-20251021    clang-22
arm                   randconfig-004-20251020    clang-22
arm                   randconfig-004-20251021    clang-22
arm                           u8500_defconfig    gcc-15.1.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    clang-22
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20251020    clang-22
arm64                 randconfig-001-20251021    clang-22
arm64                 randconfig-001-20251021    gcc-15.1.0
arm64                 randconfig-002-20251020    gcc-12.5.0
arm64                 randconfig-002-20251021    clang-22
arm64                 randconfig-003-20251020    gcc-8.5.0
arm64                 randconfig-003-20251021    clang-22
arm64                 randconfig-003-20251021    gcc-12.5.0
arm64                 randconfig-004-20251020    gcc-10.5.0
arm64                 randconfig-004-20251021    clang-18
arm64                 randconfig-004-20251021    clang-22
csky                              allnoconfig    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20251020    gcc-15.1.0
csky                  randconfig-001-20251021    gcc-15.1.0
csky                  randconfig-001-20251021    gcc-8.5.0
csky                  randconfig-002-20251020    gcc-15.1.0
csky                  randconfig-002-20251021    gcc-11.5.0
csky                  randconfig-002-20251021    gcc-8.5.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon               randconfig-001-20251020    clang-22
hexagon               randconfig-001-20251021    clang-22
hexagon               randconfig-001-20251021    gcc-8.5.0
hexagon               randconfig-002-20251020    clang-22
hexagon               randconfig-002-20251021    clang-17
hexagon               randconfig-002-20251021    gcc-8.5.0
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20251020    gcc-14
i386        buildonly-randconfig-001-20251021    clang-20
i386        buildonly-randconfig-002-20251020    clang-20
i386        buildonly-randconfig-002-20251021    clang-20
i386        buildonly-randconfig-003-20251020    gcc-14
i386        buildonly-randconfig-003-20251021    clang-20
i386        buildonly-randconfig-004-20251020    gcc-14
i386        buildonly-randconfig-004-20251021    gcc-14
i386        buildonly-randconfig-005-20251020    clang-20
i386        buildonly-randconfig-005-20251021    gcc-14
i386        buildonly-randconfig-006-20251020    clang-20
i386        buildonly-randconfig-006-20251021    clang-20
i386                                defconfig    clang-20
i386                  randconfig-011-20251021    clang-20
i386                  randconfig-012-20251021    clang-20
i386                  randconfig-013-20251021    clang-20
i386                  randconfig-014-20251021    clang-20
i386                  randconfig-015-20251021    clang-20
i386                  randconfig-016-20251021    clang-20
i386                  randconfig-017-20251021    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch             randconfig-001-20251020    gcc-15.1.0
loongarch             randconfig-001-20251021    clang-22
loongarch             randconfig-001-20251021    gcc-8.5.0
loongarch             randconfig-002-20251020    gcc-15.1.0
loongarch             randconfig-002-20251021    clang-22
loongarch             randconfig-002-20251021    gcc-8.5.0
m68k                             allmodconfig    clang-19
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
m68k                             allyesconfig    gcc-15.1.0
microblaze                       allmodconfig    clang-19
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    clang-19
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                        bcm63xx_defconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20251020    gcc-10.5.0
nios2                 randconfig-001-20251021    gcc-10.5.0
nios2                 randconfig-001-20251021    gcc-8.5.0
nios2                 randconfig-002-20251020    gcc-8.5.0
nios2                 randconfig-002-20251021    gcc-8.5.0
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-14
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251020    gcc-13.4.0
parisc                randconfig-001-20251021    gcc-8.5.0
parisc                randconfig-002-20251020    gcc-10.5.0
parisc                randconfig-002-20251021    gcc-15.1.0
parisc                randconfig-002-20251021    gcc-8.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc                        cell_defconfig    gcc-15.1.0
powerpc               randconfig-001-20251020    clang-22
powerpc               randconfig-001-20251021    clang-22
powerpc               randconfig-001-20251021    gcc-8.5.0
powerpc               randconfig-002-20251020    gcc-8.5.0
powerpc               randconfig-002-20251021    clang-19
powerpc               randconfig-002-20251021    gcc-8.5.0
powerpc               randconfig-003-20251020    clang-22
powerpc               randconfig-003-20251021    clang-22
powerpc               randconfig-003-20251021    gcc-8.5.0
powerpc64             randconfig-001-20251020    clang-19
powerpc64             randconfig-001-20251021    clang-22
powerpc64             randconfig-001-20251021    gcc-8.5.0
powerpc64             randconfig-002-20251020    gcc-11.5.0
powerpc64             randconfig-002-20251021    gcc-12.5.0
powerpc64             randconfig-002-20251021    gcc-8.5.0
powerpc64             randconfig-003-20251020    gcc-8.5.0
powerpc64             randconfig-003-20251021    gcc-8.5.0
riscv                            alldefconfig    gcc-15.1.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-14
riscv                 randconfig-001-20251020    gcc-13.4.0
riscv                 randconfig-001-20251021    gcc-8.5.0
riscv                 randconfig-002-20251020    clang-22
riscv                 randconfig-002-20251021    clang-22
riscv                 randconfig-002-20251021    gcc-8.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                          debug_defconfig    gcc-15.1.0
s390                                defconfig    gcc-14
s390                  randconfig-001-20251020    gcc-11.5.0
s390                  randconfig-001-20251021    clang-22
s390                  randconfig-001-20251021    gcc-8.5.0
s390                  randconfig-002-20251020    clang-22
s390                  randconfig-002-20251021    gcc-11.5.0
s390                  randconfig-002-20251021    gcc-8.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-14
sh                    randconfig-001-20251020    gcc-15.1.0
sh                    randconfig-001-20251021    gcc-8.5.0
sh                    randconfig-001-20251021    gcc-9.5.0
sh                    randconfig-002-20251020    gcc-15.1.0
sh                    randconfig-002-20251021    gcc-10.5.0
sh                    randconfig-002-20251021    gcc-8.5.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251020    gcc-8.5.0
sparc                 randconfig-001-20251021    gcc-8.5.0
sparc                 randconfig-002-20251020    gcc-8.5.0
sparc                 randconfig-002-20251021    gcc-14.3.0
sparc                 randconfig-002-20251021    gcc-8.5.0
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20251020    gcc-10.5.0
sparc64               randconfig-001-20251021    gcc-8.5.0
sparc64               randconfig-002-20251020    clang-22
sparc64               randconfig-002-20251021    gcc-10.5.0
sparc64               randconfig-002-20251021    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251020    clang-22
um                    randconfig-001-20251021    gcc-14
um                    randconfig-001-20251021    gcc-8.5.0
um                    randconfig-002-20251020    clang-22
um                    randconfig-002-20251021    gcc-14
um                    randconfig-002-20251021    gcc-8.5.0
um                           x86_64_defconfig    gcc-14
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251020    gcc-14
x86_64      buildonly-randconfig-001-20251021    clang-20
x86_64      buildonly-randconfig-001-20251021    gcc-13
x86_64      buildonly-randconfig-002-20251020    clang-20
x86_64      buildonly-randconfig-002-20251021    clang-20
x86_64      buildonly-randconfig-003-20251020    gcc-14
x86_64      buildonly-randconfig-003-20251021    clang-20
x86_64      buildonly-randconfig-004-20251020    gcc-14
x86_64      buildonly-randconfig-004-20251021    clang-20
x86_64      buildonly-randconfig-005-20251020    gcc-14
x86_64      buildonly-randconfig-005-20251021    clang-20
x86_64      buildonly-randconfig-005-20251021    gcc-14
x86_64      buildonly-randconfig-006-20251020    gcc-14
x86_64      buildonly-randconfig-006-20251021    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20251021    gcc-14
x86_64                randconfig-002-20251021    gcc-14
x86_64                randconfig-003-20251021    gcc-14
x86_64                randconfig-004-20251021    gcc-14
x86_64                randconfig-005-20251021    gcc-14
x86_64                randconfig-006-20251021    gcc-14
x86_64                randconfig-007-20251021    gcc-14
x86_64                randconfig-008-20251021    gcc-14
x86_64                randconfig-071-20251021    gcc-14
x86_64                randconfig-072-20251021    gcc-14
x86_64                randconfig-073-20251021    gcc-14
x86_64                randconfig-074-20251021    gcc-14
x86_64                randconfig-075-20251021    gcc-14
x86_64                randconfig-076-20251021    gcc-14
x86_64                randconfig-077-20251021    gcc-14
x86_64                randconfig-078-20251021    gcc-14
x86_64                               rhel-9.4    clang-20
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                generic_kc705_defconfig    gcc-15.1.0
xtensa                randconfig-001-20251020    gcc-8.5.0
xtensa                randconfig-001-20251021    gcc-8.5.0
xtensa                randconfig-002-20251020    gcc-8.5.0
xtensa                randconfig-002-20251021    gcc-13.4.0
xtensa                randconfig-002-20251021    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

