Return-Path: <linux-wireless+bounces-29839-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B680FCC83DA
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Dec 2025 15:39:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CC85230A7A34
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Dec 2025 14:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AE323A5C06;
	Wed, 17 Dec 2025 14:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HsiQ8BxC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E89C3A4EBC
	for <linux-wireless@vger.kernel.org>; Wed, 17 Dec 2025 14:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765982093; cv=none; b=aJP+TGmqhQKhmzhyXf8MHSuGwn8NvcR2oehstmkZouLLD329xIoH00nj8BNA4Yy/0/WAvn1oSCs+/XL3MmmgpnU50xD3RMsEgGsth6Gkr8w/915pb2hGH0x2A3tBFIaAo8JyXCPAQR9XywWieFO4xtCLTj5cgdyNnVrivNVrqAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765982093; c=relaxed/simple;
	bh=Cr42S638IeXuwWHZet8RdHr8uyLHf0AG0m69kAgSfhE=;
	h=Date:From:To:Cc:Subject:Message-ID; b=I2nVHfU8kv+hw6kvGdNrM9YRE7UlgTNFADeDmQj144yX+iKHXQ6U8mBiW8qultJGLOwOkROQ40wXIpkMgCn+Da5J/oqzW/VhRU8FLT1J004qMWRMZ5V/HdvDFyexV1GjpCNZT1XiLlrygnSNRKBhJBIwLR46jH6T1AEqEGkpykk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=fail smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HsiQ8BxC; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765982089; x=1797518089;
  h=date:from:to:cc:subject:message-id;
  bh=Cr42S638IeXuwWHZet8RdHr8uyLHf0AG0m69kAgSfhE=;
  b=HsiQ8BxCprxvFPer/JkDXP9FtBPIK6q85cDlO4Yg7Hss8bdL3rUHuOMF
   g+wu5kFqVbqN1FuedzijgdD5G/+7SI9sHAG5xV27cggI9Vt3Hf/6hTjYP
   GuDayeKurfmWR/jwtEOwdb0fcP0KqO2oQ2kEcX+IheVHuyZ7mt30WtIC/
   Nq2iVd5uEgKVwMWZH9x8SOlcH7DflEiWMGjPcStCRV0w8OFkrtwGKSzUH
   /VrIPuaqg8RERFTNIBon1wM59Tegg2avPhrhoGzNaOcLMzrVTlkIgYL4D
   ptqPfnP9opVbSW3hkY9Jnsp5ayGxQQlW50JZovTOGvM63UBB6z3TXW4Ua
   w==;
X-CSE-ConnectionGUID: q3tKMbAPTOC++gkqAUvIIg==
X-CSE-MsgGUID: xpmi9rhXSFSV4Cqr3kQdPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11645"; a="70496127"
X-IronPort-AV: E=Sophos;i="6.21,156,1763452800"; 
   d="scan'208";a="70496127"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2025 06:34:46 -0800
X-CSE-ConnectionGUID: abxOJx58RYapIQQee90Tdg==
X-CSE-MsgGUID: G3kxUgdLRyKZ0JKw/Qx2rw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,156,1763452800"; 
   d="scan'208";a="202690527"
Received: from lkp-server01.sh.intel.com (HELO 0d09efa1b85f) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 17 Dec 2025 06:34:45 -0800
Received: from kbuild by 0d09efa1b85f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vVsbz-000000000ir-1xB9;
	Wed, 17 Dec 2025 14:34:43 +0000
Date: Wed, 17 Dec 2025 22:34:29 +0800
From: kernel test robot <lkp@intel.com>
To: Johannes Berg <johannes.berg@intel.com>
Cc: linux-wireless@vger.kernel.org
Subject: [wireless:for-next] BUILD SUCCESS
 81d90d93d22ca4f61833cba921dce9a0bd82218f
Message-ID: <202512172223.QViTkuC8-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git for-next
branch HEAD: 81d90d93d22ca4f61833cba921dce9a0bd82218f  wifi: iwlwifi: Implement settime64 as stub for MVM/MLD PTP

elapsed time: 1223m

configs tested: 209
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                              allmodconfig    clang-16
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-22
arc                          axs101_defconfig    gcc-15.1.0
arc                                 defconfig    gcc-15.1.0
arc                   randconfig-001-20251217    clang-22
arc                   randconfig-001-20251217    gcc-8.5.0
arc                   randconfig-002-20251217    clang-22
arc                   randconfig-002-20251217    gcc-10.5.0
arm                               allnoconfig    gcc-15.1.0
arm                              allyesconfig    clang-16
arm                                 defconfig    gcc-15.1.0
arm                   randconfig-001-20251217    clang-18
arm                   randconfig-001-20251217    clang-22
arm                   randconfig-002-20251217    clang-22
arm                   randconfig-003-20251217    clang-22
arm                   randconfig-004-20251217    clang-22
arm                           sama5_defconfig    gcc-15.1.0
arm64                            allmodconfig    clang-22
arm64                             allnoconfig    gcc-15.1.0
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20251217    clang-22
arm64                 randconfig-002-20251217    clang-22
arm64                 randconfig-003-20251217    clang-22
arm64                 randconfig-004-20251217    clang-22
csky                             allmodconfig    gcc-15.1.0
csky                              allnoconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20251217    clang-22
csky                  randconfig-002-20251217    clang-22
hexagon                          allmodconfig    gcc-15.1.0
hexagon                           allnoconfig    gcc-15.1.0
hexagon                             defconfig    gcc-15.1.0
hexagon               randconfig-001-20251217    clang-22
hexagon               randconfig-001-20251217    gcc-11.5.0
hexagon               randconfig-002-20251217    clang-22
hexagon               randconfig-002-20251217    gcc-11.5.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-15.1.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20251217    clang-20
i386        buildonly-randconfig-002-20251217    clang-20
i386        buildonly-randconfig-003-20251217    clang-20
i386        buildonly-randconfig-004-20251217    clang-20
i386        buildonly-randconfig-005-20251217    clang-20
i386        buildonly-randconfig-006-20251217    clang-20
i386                                defconfig    gcc-15.1.0
i386                  randconfig-001-20251217    gcc-14
i386                  randconfig-002-20251217    gcc-14
i386                  randconfig-003-20251217    gcc-14
i386                  randconfig-004-20251217    gcc-14
i386                  randconfig-005-20251217    gcc-14
i386                  randconfig-006-20251217    gcc-14
i386                  randconfig-007-20251217    gcc-14
i386                  randconfig-011-20251217    clang-20
i386                  randconfig-011-20251217    gcc-14
i386                  randconfig-012-20251217    clang-20
i386                  randconfig-013-20251217    clang-20
i386                  randconfig-014-20251217    clang-20
i386                  randconfig-015-20251217    clang-20
i386                  randconfig-015-20251217    gcc-14
i386                  randconfig-016-20251217    clang-20
i386                  randconfig-016-20251217    gcc-14
i386                  randconfig-017-20251217    clang-20
loongarch                        allmodconfig    clang-22
loongarch                         allnoconfig    gcc-15.1.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251217    clang-22
loongarch             randconfig-001-20251217    gcc-11.5.0
loongarch             randconfig-002-20251217    clang-22
loongarch             randconfig-002-20251217    gcc-11.5.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-16
m68k                                defconfig    clang-19
m68k                                defconfig    gcc-15.1.0
m68k                           virt_defconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    clang-19
microblaze                          defconfig    gcc-15.1.0
mips                             allmodconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                             allyesconfig    gcc-15.1.0
nios2                         3c120_defconfig    gcc-15.1.0
nios2                            allmodconfig    clang-22
nios2                             allnoconfig    clang-22
nios2                               defconfig    clang-19
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20251217    gcc-11.5.0
nios2                 randconfig-002-20251217    gcc-11.5.0
nios2                 randconfig-002-20251217    gcc-8.5.0
openrisc                         allmodconfig    clang-22
openrisc                          allnoconfig    clang-22
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                           allyesconfig    clang-19
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251217    gcc-8.5.0
parisc                randconfig-002-20251217    gcc-8.5.0
parisc64                            defconfig    clang-19
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                      chrp32_defconfig    gcc-15.1.0
powerpc                       ebony_defconfig    gcc-15.1.0
powerpc               randconfig-001-20251217    gcc-8.5.0
powerpc               randconfig-002-20251217    gcc-8.5.0
powerpc64             randconfig-001-20251217    gcc-8.5.0
powerpc64             randconfig-002-20251217    gcc-8.5.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    clang-22
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                               defconfig    gcc-15.1.0
riscv                    nommu_k210_defconfig    gcc-15.1.0
riscv                 randconfig-001-20251217    clang-18
riscv                 randconfig-002-20251217    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    clang-22
s390                                defconfig    gcc-15.1.0
s390                  randconfig-001-20251217    clang-18
s390                  randconfig-002-20251217    clang-18
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    clang-22
sh                               allyesconfig    clang-19
sh                                  defconfig    gcc-14
sh                                  defconfig    gcc-15.1.0
sh                        edosk7760_defconfig    gcc-15.1.0
sh                    randconfig-001-20251217    clang-18
sh                    randconfig-002-20251217    clang-18
sh                           se7619_defconfig    gcc-15.1.0
sh                   secureedge5410_defconfig    gcc-15.1.0
sparc                             allnoconfig    clang-22
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251217    gcc-15.1.0
sparc                 randconfig-002-20251217    gcc-15.1.0
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    clang-20
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20251217    clang-20
sparc64               randconfig-001-20251217    gcc-15.1.0
sparc64               randconfig-002-20251217    gcc-12.5.0
sparc64               randconfig-002-20251217    gcc-15.1.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-15.1.0
um                                  defconfig    clang-22
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251217    clang-22
um                    randconfig-001-20251217    gcc-15.1.0
um                    randconfig-002-20251217    clang-22
um                    randconfig-002-20251217    gcc-15.1.0
um                           x86_64_defconfig    clang-22
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-22
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251217    clang-20
x86_64      buildonly-randconfig-001-20251217    gcc-14
x86_64      buildonly-randconfig-002-20251217    clang-20
x86_64      buildonly-randconfig-002-20251217    gcc-14
x86_64      buildonly-randconfig-003-20251217    gcc-13
x86_64      buildonly-randconfig-003-20251217    gcc-14
x86_64      buildonly-randconfig-004-20251217    gcc-14
x86_64      buildonly-randconfig-005-20251217    gcc-14
x86_64      buildonly-randconfig-006-20251217    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20251217    clang-20
x86_64                randconfig-002-20251217    clang-20
x86_64                randconfig-003-20251217    clang-20
x86_64                randconfig-004-20251217    clang-20
x86_64                randconfig-005-20251217    clang-20
x86_64                randconfig-006-20251217    clang-20
x86_64                randconfig-011-20251217    gcc-14
x86_64                randconfig-012-20251217    gcc-14
x86_64                randconfig-013-20251217    gcc-14
x86_64                randconfig-014-20251217    gcc-14
x86_64                randconfig-015-20251217    gcc-14
x86_64                randconfig-016-20251217    gcc-14
x86_64                randconfig-071-20251217    gcc-14
x86_64                randconfig-072-20251217    gcc-14
x86_64                randconfig-073-20251217    gcc-14
x86_64                randconfig-074-20251217    gcc-14
x86_64                randconfig-075-20251217    gcc-14
x86_64                randconfig-076-20251217    gcc-14
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-22
xtensa                           allyesconfig    clang-22
xtensa                randconfig-001-20251217    gcc-15.1.0
xtensa                randconfig-001-20251217    gcc-8.5.0
xtensa                randconfig-002-20251217    gcc-15.1.0
xtensa                    smp_lx200_defconfig    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

