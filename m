Return-Path: <linux-wireless+bounces-27480-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12CAAB845F3
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Sep 2025 13:35:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5AC74A3225
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Sep 2025 11:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26573280CE0;
	Thu, 18 Sep 2025 11:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q0i4xGDN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03BABBA42
	for <linux-wireless@vger.kernel.org>; Thu, 18 Sep 2025 11:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758195299; cv=none; b=VYHM+VR7+zpAspwqHbVAJ+eynuEhfYR9UQrGDRN/Ft4QHeIe44G6yr1jQPg7b45d8zEClYRNcxm1xnUBm0s+wuKRy4BudDPxWfSCTmzbFjWXVYtYXXictDr97vEF7Gzx4+xxd8fZcQAcwAOduQYEEENEX2arK7Z6ucYHATZSBx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758195299; c=relaxed/simple;
	bh=xn6Ocgv47DHAI0eXLj5cqG/ZXnaXa3AzffKDgTwsRL8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=GQDBQ5Dvb9jOHiwSfmL3gQMRyym0qqUOLwSgYdsa3wNkAVmwNVA/q4NmCV4rzLqYpz5jMjw6TageyOaQ/t5MwSBj9kXtsPTVMr+tboHiAffkOm5rGX2a9bMM/uj+5KIqn0npgTiT4Qdwi5etq221oUfO1HEAXgvUOx6jbkB/YiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q0i4xGDN; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758195297; x=1789731297;
  h=date:from:to:cc:subject:message-id;
  bh=xn6Ocgv47DHAI0eXLj5cqG/ZXnaXa3AzffKDgTwsRL8=;
  b=Q0i4xGDNRiXkf7aY8uzs2wN+L1Sc1ADQz4++n2JoIwajXg94N91XKifn
   8IFTpaI1+il4wuTT1jRvb3zgbAo/7M5C68dLoymE4e8ch0oFAT6ZtiNPL
   pN9owNBOvXL/NRiwXPGJcs39SqtI9utko4u/l+G+IAUT0vFfyDZYW+tzn
   fm3s5tYztzJ86No1iFTaxkFO8+JATKFsYvXQNyTtaJKl5kBAqcQenv5Cl
   SBMuvVSE4ejhcFZHzELZYH3HOH2Y8tXDrWWpeZ9c72r1/sUns8c93D40h
   KFW8hcqEwRSKkoHi2K6Gt+zhXIcjDZAro18NXic/NxiAkUdNgwZoo4H2q
   A==;
X-CSE-ConnectionGUID: 18in+Q6HS7qPuzowTPR6gQ==
X-CSE-MsgGUID: l5RKejV0QCewaDEHDFNPFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="64324481"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="64324481"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2025 04:34:57 -0700
X-CSE-ConnectionGUID: tf4MKTELRgiJq6wiD1LRFQ==
X-CSE-MsgGUID: peQJPpO7SqiRT44Tw0Vu2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,274,1751266800"; 
   d="scan'208";a="180632699"
Received: from lkp-server01.sh.intel.com (HELO 84a20bd60769) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 18 Sep 2025 04:34:55 -0700
Received: from kbuild by 84a20bd60769 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uzCua-0003CJ-1N;
	Thu, 18 Sep 2025 11:34:52 +0000
Date: Thu, 18 Sep 2025 19:34:03 +0800
From: kernel test robot <lkp@intel.com>
To: Johannes Berg <johannes.berg@intel.com>
Cc: Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org
Subject: [wireless:for-next] BUILD SUCCESS
 b6f56a44e4c1014b08859dcf04ed246500e310e5
Message-ID: <202509181957.PIAlkFAp-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git for-next
branch HEAD: b6f56a44e4c1014b08859dcf04ed246500e310e5  net: rfkill: gpio: Fix crash due to dereferencering uninitialized pointer

elapsed time: 1466m

configs tested: 242
configs skipped: 5

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
arc                          axs101_defconfig    clang-22
arc                                 defconfig    clang-19
arc                   randconfig-001-20250917    gcc-8.5.0
arc                   randconfig-001-20250918    clang-22
arc                   randconfig-002-20250917    gcc-15.1.0
arc                   randconfig-002-20250918    clang-22
arm                              allmodconfig    clang-19
arm                               allnoconfig    clang-22
arm                              allyesconfig    clang-19
arm                                 defconfig    clang-19
arm                   milbeaut_m10v_defconfig    clang-22
arm                       netwinder_defconfig    clang-22
arm                   randconfig-001-20250917    clang-22
arm                   randconfig-001-20250918    clang-22
arm                   randconfig-002-20250917    gcc-12.5.0
arm                   randconfig-002-20250918    clang-22
arm                   randconfig-003-20250917    gcc-10.5.0
arm                   randconfig-003-20250918    clang-22
arm                   randconfig-004-20250917    clang-22
arm                   randconfig-004-20250918    clang-22
arm                         s5pv210_defconfig    clang-22
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    clang-22
arm64                               defconfig    clang-19
arm64                 randconfig-001-20250917    clang-22
arm64                 randconfig-001-20250918    clang-22
arm64                 randconfig-002-20250917    clang-19
arm64                 randconfig-002-20250918    clang-22
arm64                 randconfig-003-20250917    gcc-10.5.0
arm64                 randconfig-003-20250918    clang-22
arm64                 randconfig-004-20250917    clang-22
arm64                 randconfig-004-20250918    clang-22
csky                              allnoconfig    clang-22
csky                                defconfig    clang-19
csky                  randconfig-001-20250917    gcc-12.5.0
csky                  randconfig-001-20250918    clang-22
csky                  randconfig-002-20250917    gcc-9.5.0
csky                  randconfig-002-20250918    clang-22
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    clang-19
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-19
hexagon                          allyesconfig    clang-22
hexagon                             defconfig    clang-19
hexagon               randconfig-001-20250917    clang-22
hexagon               randconfig-001-20250918    clang-22
hexagon               randconfig-002-20250917    clang-22
hexagon               randconfig-002-20250918    clang-22
i386                             allmodconfig    clang-20
i386                              allnoconfig    clang-20
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20250917    gcc-14
i386        buildonly-randconfig-001-20250918    gcc-14
i386        buildonly-randconfig-002-20250917    clang-20
i386        buildonly-randconfig-002-20250918    gcc-14
i386        buildonly-randconfig-003-20250917    gcc-14
i386        buildonly-randconfig-003-20250918    gcc-14
i386        buildonly-randconfig-004-20250917    gcc-14
i386        buildonly-randconfig-004-20250918    gcc-14
i386        buildonly-randconfig-005-20250917    gcc-14
i386        buildonly-randconfig-005-20250918    gcc-14
i386        buildonly-randconfig-006-20250917    clang-20
i386        buildonly-randconfig-006-20250918    gcc-14
i386                                defconfig    clang-20
i386                  randconfig-001-20250918    gcc-14
i386                  randconfig-002-20250918    gcc-14
i386                  randconfig-003-20250918    gcc-14
i386                  randconfig-004-20250918    gcc-14
i386                  randconfig-005-20250918    gcc-14
i386                  randconfig-006-20250918    gcc-14
i386                  randconfig-007-20250918    gcc-14
i386                  randconfig-011-20250918    gcc-14
i386                  randconfig-012-20250918    gcc-14
i386                  randconfig-013-20250918    gcc-14
i386                  randconfig-014-20250918    gcc-14
i386                  randconfig-015-20250918    gcc-14
i386                  randconfig-016-20250918    gcc-14
i386                  randconfig-017-20250918    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20250917    gcc-15.1.0
loongarch             randconfig-001-20250918    clang-22
loongarch             randconfig-002-20250917    gcc-15.1.0
loongarch             randconfig-002-20250918    clang-22
m68k                             allmodconfig    clang-19
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
m68k                             allyesconfig    gcc-15.1.0
m68k                         amcore_defconfig    clang-22
m68k                                defconfig    clang-19
microblaze                       allmodconfig    clang-19
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    clang-19
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                        maltaup_defconfig    clang-22
mips                           mtx1_defconfig    clang-22
mips                         rt305x_defconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20250917    gcc-11.5.0
nios2                 randconfig-001-20250918    clang-22
nios2                 randconfig-002-20250917    gcc-8.5.0
nios2                 randconfig-002-20250918    clang-22
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-14
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20250917    gcc-14.3.0
parisc                randconfig-001-20250918    clang-22
parisc                randconfig-002-20250917    gcc-14.3.0
parisc                randconfig-002-20250918    clang-22
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc                          allyesconfig    gcc-15.1.0
powerpc               randconfig-001-20250917    clang-18
powerpc               randconfig-001-20250918    clang-22
powerpc               randconfig-002-20250917    clang-22
powerpc               randconfig-002-20250918    clang-22
powerpc               randconfig-003-20250917    gcc-9.5.0
powerpc               randconfig-003-20250918    clang-22
powerpc64             randconfig-001-20250917    clang-19
powerpc64             randconfig-001-20250918    clang-22
powerpc64             randconfig-002-20250917    gcc-8.5.0
powerpc64             randconfig-002-20250918    clang-22
powerpc64             randconfig-003-20250917    gcc-10.5.0
powerpc64             randconfig-003-20250918    clang-22
riscv                            allmodconfig    clang-22
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-14
riscv                 randconfig-001-20250917    gcc-14.3.0
riscv                 randconfig-001-20250918    gcc-10.5.0
riscv                 randconfig-002-20250917    clang-22
riscv                 randconfig-002-20250918    gcc-10.5.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-14
s390                  randconfig-001-20250917    clang-22
s390                  randconfig-001-20250918    gcc-10.5.0
s390                  randconfig-002-20250917    gcc-8.5.0
s390                  randconfig-002-20250918    gcc-10.5.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-14
sh                    randconfig-001-20250917    gcc-14.3.0
sh                    randconfig-001-20250918    gcc-10.5.0
sh                    randconfig-002-20250917    gcc-15.1.0
sh                    randconfig-002-20250918    gcc-10.5.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20250917    gcc-8.5.0
sparc                 randconfig-001-20250918    gcc-10.5.0
sparc                 randconfig-002-20250917    gcc-14.3.0
sparc                 randconfig-002-20250918    gcc-10.5.0
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20250917    gcc-11.5.0
sparc64               randconfig-001-20250918    gcc-10.5.0
sparc64               randconfig-002-20250917    gcc-8.5.0
sparc64               randconfig-002-20250918    gcc-10.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    clang-19
um                               allyesconfig    gcc-14
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20250917    gcc-14
um                    randconfig-001-20250918    gcc-10.5.0
um                    randconfig-002-20250917    gcc-14
um                    randconfig-002-20250918    gcc-10.5.0
um                           x86_64_defconfig    gcc-14
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250917    gcc-14
x86_64      buildonly-randconfig-001-20250918    clang-20
x86_64      buildonly-randconfig-002-20250917    clang-20
x86_64      buildonly-randconfig-002-20250918    clang-20
x86_64      buildonly-randconfig-003-20250917    clang-20
x86_64      buildonly-randconfig-003-20250918    clang-20
x86_64      buildonly-randconfig-004-20250917    clang-20
x86_64      buildonly-randconfig-004-20250918    clang-20
x86_64      buildonly-randconfig-005-20250917    clang-20
x86_64      buildonly-randconfig-005-20250918    clang-20
x86_64      buildonly-randconfig-006-20250917    gcc-12
x86_64      buildonly-randconfig-006-20250918    clang-20
x86_64                              defconfig    clang-20
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250918    gcc-12
x86_64                randconfig-002-20250918    gcc-12
x86_64                randconfig-003-20250918    gcc-12
x86_64                randconfig-004-20250918    gcc-12
x86_64                randconfig-005-20250918    gcc-12
x86_64                randconfig-006-20250918    gcc-12
x86_64                randconfig-007-20250918    gcc-12
x86_64                randconfig-008-20250918    gcc-12
x86_64                randconfig-071-20250918    clang-20
x86_64                randconfig-072-20250918    clang-20
x86_64                randconfig-073-20250918    clang-20
x86_64                randconfig-074-20250918    clang-20
x86_64                randconfig-075-20250918    clang-20
x86_64                randconfig-076-20250918    clang-20
x86_64                randconfig-077-20250918    clang-20
x86_64                randconfig-078-20250918    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250917    gcc-8.5.0
xtensa                randconfig-001-20250918    gcc-10.5.0
xtensa                randconfig-002-20250917    gcc-11.5.0
xtensa                randconfig-002-20250918    gcc-10.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

