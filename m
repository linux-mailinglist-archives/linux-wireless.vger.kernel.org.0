Return-Path: <linux-wireless+bounces-30835-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FB0AD219F6
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jan 2026 23:39:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DD24D304269B
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jan 2026 22:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1131A3B530A;
	Wed, 14 Jan 2026 22:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PLhlBxz+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79D13AEF42
	for <linux-wireless@vger.kernel.org>; Wed, 14 Jan 2026 22:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768430198; cv=none; b=gCqs0WtRreBuLju+LOeVqn8lknHTnb9GDkinsJaGoXJcX46ZhOrrhOLz1Rh9vYt2vPSpNiUr2T/8JM5Zvq0OYmPqogKQjtgf8zCwablDfLbJtTiifgDO0+yKSMtHvL6bEI7Rz5sfJg+IuCpP+pT8YH9O4aHZe9ZIPDsrYroZFwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768430198; c=relaxed/simple;
	bh=RjbaTkKTcj2XJIM5ntbTTFrM1n4DbL9G1EHma2R3nWA=;
	h=Date:From:To:Cc:Subject:Message-ID; b=TQiPeuxxQpMLYQfJtKQoP05W0GcB5ZiKnB43h1CH/4BZXNxet2MfTR4wGDk+LyurIuX2TsozpJx4gBbD9cQ3t/lagGU/wF6USuk0c1pVUNdqnRYLZQt76p4CTvb1DBuO27Vezz2rtN5SwhhdD/DrYfXEkAtPG8/9/TE6KyVzogA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PLhlBxz+; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768430192; x=1799966192;
  h=date:from:to:cc:subject:message-id;
  bh=RjbaTkKTcj2XJIM5ntbTTFrM1n4DbL9G1EHma2R3nWA=;
  b=PLhlBxz+kPixmqItaG8u/IyvpnKTJRn2GiIgq5o3ScmN2lcECwKaS11y
   iA4azt2iFdClAaRTdMNLkRSQuUOBY3FNP6ZmEVQO38AjSNzTNmpieKFGO
   SfxhodkA69MDdYha+Z69+g6H6ZqTMJabYgyeXt6j3p9KL6utWj1UPDsRu
   R4hfa921bCjjirTPe53DQoBB497QdFoUDVVHdvcdBue/1qyTgGHW+ygFX
   19yUG1LwzscTpyuJaWSiLrCaD7TizuMGy6xBChJ0Kn6BCEENeHf9LXbIl
   /DhH2UHq59mRDSVYBSvJnJ36cnkT8SVWvNzLkJC5MO/ptZbVPHqYShBf7
   A==;
X-CSE-ConnectionGUID: Y854lZhPSkGucwLJDdk8RA==
X-CSE-MsgGUID: sHFvY0FPQNOFuvA1i+f0sg==
X-IronPort-AV: E=McAfee;i="6800,10657,11671"; a="87317608"
X-IronPort-AV: E=Sophos;i="6.21,226,1763452800"; 
   d="scan'208";a="87317608"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 14:36:28 -0800
X-CSE-ConnectionGUID: bdrSwIhMRxCUmIuxrEm2vQ==
X-CSE-MsgGUID: ATVOseSMS26eVZ0mqASnMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,226,1763452800"; 
   d="scan'208";a="209651379"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 14 Jan 2026 14:36:27 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vg9TU-00000000H8h-3Pqn;
	Wed, 14 Jan 2026 22:36:24 +0000
Date: Thu, 15 Jan 2026 06:35:58 +0800
From: kernel test robot <lkp@intel.com>
To: Johannes Berg <johannes.berg@intel.com>
Cc: linux-wireless@vger.kernel.org
Subject: [wireless:for-next] BUILD SUCCESS
 e7df8567878f9cbb9059287161e80f7c7da9b15c
Message-ID: <202601150652.7NSDQmdp-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git for-next
branch HEAD: e7df8567878f9cbb9059287161e80f7c7da9b15c  Merge tag 'ath-current-20260113' of git://git.kernel.org/pub/scm/linux/kernel/git/ath/ath into wireless

elapsed time: 751m

configs tested: 252
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            alldefconfig    clang-22
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-22
arc                                 defconfig    gcc-15.2.0
arc                 nsimosci_hs_smp_defconfig    gcc-15.2.0
arc                   randconfig-001-20260114    gcc-10.5.0
arc                   randconfig-001-20260115    clang-22
arc                   randconfig-002-20260114    gcc-10.5.0
arc                   randconfig-002-20260115    clang-22
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                         at91_dt_defconfig    clang-22
arm                                 defconfig    gcc-15.2.0
arm                          ep93xx_defconfig    gcc-15.2.0
arm                          ixp4xx_defconfig    clang-22
arm                          moxart_defconfig    clang-22
arm                   randconfig-001-20260114    gcc-10.5.0
arm                   randconfig-001-20260115    clang-22
arm                   randconfig-002-20260114    gcc-10.5.0
arm                   randconfig-002-20260115    clang-22
arm                   randconfig-003-20260114    gcc-10.5.0
arm                   randconfig-003-20260115    clang-22
arm                   randconfig-004-20260114    gcc-10.5.0
arm                   randconfig-004-20260115    clang-22
arm                           sama7_defconfig    clang-22
arm64                            allmodconfig    clang-22
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260114    clang-22
arm64                 randconfig-001-20260115    clang-22
arm64                 randconfig-002-20260114    clang-22
arm64                 randconfig-002-20260115    clang-22
arm64                 randconfig-003-20260114    clang-22
arm64                 randconfig-003-20260115    clang-22
arm64                 randconfig-004-20260114    clang-22
arm64                 randconfig-004-20260115    clang-22
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260114    clang-22
csky                  randconfig-001-20260115    clang-22
csky                  randconfig-002-20260114    clang-22
csky                  randconfig-002-20260115    clang-22
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260114    clang-22
hexagon               randconfig-002-20260114    clang-22
i386                             allmodconfig    clang-20
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20260114    gcc-14
i386        buildonly-randconfig-002-20260114    gcc-14
i386        buildonly-randconfig-003-20260114    gcc-14
i386        buildonly-randconfig-004-20260114    gcc-14
i386        buildonly-randconfig-005-20260114    gcc-14
i386        buildonly-randconfig-006-20260114    gcc-14
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260114    gcc-14
i386                  randconfig-001-20260115    clang-20
i386                  randconfig-002-20260114    gcc-14
i386                  randconfig-002-20260115    clang-20
i386                  randconfig-003-20260114    gcc-14
i386                  randconfig-003-20260115    clang-20
i386                  randconfig-004-20260114    gcc-14
i386                  randconfig-004-20260115    clang-20
i386                  randconfig-005-20260114    gcc-14
i386                  randconfig-005-20260115    clang-20
i386                  randconfig-006-20260114    gcc-14
i386                  randconfig-006-20260115    clang-20
i386                  randconfig-007-20260114    gcc-14
i386                  randconfig-007-20260115    clang-20
i386                  randconfig-011-20260114    gcc-14
i386                  randconfig-011-20260115    gcc-14
i386                  randconfig-012-20260114    gcc-14
i386                  randconfig-012-20260115    gcc-14
i386                  randconfig-013-20260114    gcc-14
i386                  randconfig-013-20260115    gcc-14
i386                  randconfig-014-20260114    gcc-14
i386                  randconfig-014-20260115    gcc-14
i386                  randconfig-015-20260114    gcc-14
i386                  randconfig-015-20260115    gcc-14
i386                  randconfig-016-20260114    gcc-14
i386                  randconfig-016-20260115    gcc-14
i386                  randconfig-017-20260114    gcc-14
i386                  randconfig-017-20260115    gcc-14
loongarch                        allmodconfig    clang-22
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260114    clang-22
loongarch             randconfig-002-20260114    clang-22
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                                defconfig    clang-19
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                           ip28_defconfig    gcc-15.2.0
mips                           mtx1_defconfig    gcc-15.2.0
mips                      pic32mzda_defconfig    clang-22
mips                          rb532_defconfig    clang-22
nios2                            allmodconfig    clang-22
nios2                             allnoconfig    clang-22
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260114    clang-22
nios2                 randconfig-002-20260114    clang-22
openrisc                         alldefconfig    gcc-15.2.0
openrisc                         allmodconfig    clang-22
openrisc                          allnoconfig    clang-22
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-22
parisc                           allyesconfig    clang-19
parisc                              defconfig    gcc-15.2.0
parisc                generic-64bit_defconfig    clang-22
parisc                randconfig-001-20260114    gcc-14.3.0
parisc                randconfig-001-20260115    clang-22
parisc                randconfig-002-20260114    gcc-14.3.0
parisc                randconfig-002-20260115    clang-22
parisc64                            defconfig    clang-19
powerpc                    adder875_defconfig    clang-22
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-22
powerpc                    gamecube_defconfig    clang-22
powerpc                 linkstation_defconfig    clang-22
powerpc                   lite5200b_defconfig    gcc-15.2.0
powerpc               randconfig-001-20260114    gcc-14.3.0
powerpc               randconfig-001-20260115    clang-22
powerpc               randconfig-002-20260114    gcc-14.3.0
powerpc               randconfig-002-20260115    clang-22
powerpc                     tqm8555_defconfig    gcc-15.2.0
powerpc                      tqm8xx_defconfig    clang-22
powerpc64             randconfig-001-20260114    gcc-14.3.0
powerpc64             randconfig-001-20260115    clang-22
powerpc64             randconfig-002-20260114    gcc-14.3.0
powerpc64             randconfig-002-20260115    clang-22
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    clang-22
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260114    gcc-14.3.0
riscv                 randconfig-001-20260114    gcc-15.2.0
riscv                 randconfig-001-20260115    gcc-10.5.0
riscv                 randconfig-002-20260114    gcc-15.2.0
riscv                 randconfig-002-20260114    gcc-9.5.0
riscv                 randconfig-002-20260115    gcc-10.5.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260114    gcc-15.2.0
s390                  randconfig-001-20260115    gcc-10.5.0
s390                  randconfig-002-20260114    gcc-15.2.0
s390                  randconfig-002-20260114    gcc-8.5.0
s390                  randconfig-002-20260115    gcc-10.5.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-22
sh                               allyesconfig    clang-19
sh                                  defconfig    gcc-14
sh                          kfr2r09_defconfig    gcc-15.2.0
sh                          r7785rp_defconfig    clang-22
sh                    randconfig-001-20260114    gcc-15.2.0
sh                    randconfig-001-20260115    gcc-10.5.0
sh                    randconfig-002-20260114    gcc-12.5.0
sh                    randconfig-002-20260114    gcc-15.2.0
sh                    randconfig-002-20260115    gcc-10.5.0
sparc                             allnoconfig    clang-22
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260114    clang-20
sparc                 randconfig-001-20260115    clang-22
sparc                 randconfig-002-20260114    clang-20
sparc                 randconfig-002-20260115    clang-22
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260114    clang-20
sparc64               randconfig-001-20260115    clang-22
sparc64               randconfig-002-20260114    clang-20
sparc64               randconfig-002-20260115    clang-22
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    clang-22
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260114    clang-20
um                    randconfig-001-20260115    clang-22
um                    randconfig-002-20260114    clang-20
um                    randconfig-002-20260115    clang-22
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-22
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260114    clang-20
x86_64      buildonly-randconfig-002-20260114    clang-20
x86_64      buildonly-randconfig-003-20260114    clang-20
x86_64      buildonly-randconfig-004-20260114    clang-20
x86_64      buildonly-randconfig-005-20260114    clang-20
x86_64      buildonly-randconfig-006-20260114    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260114    gcc-14
x86_64                randconfig-001-20260115    clang-20
x86_64                randconfig-002-20260114    gcc-14
x86_64                randconfig-002-20260115    clang-20
x86_64                randconfig-003-20260114    gcc-14
x86_64                randconfig-003-20260115    clang-20
x86_64                randconfig-004-20260114    gcc-14
x86_64                randconfig-004-20260115    clang-20
x86_64                randconfig-005-20260114    gcc-14
x86_64                randconfig-005-20260115    clang-20
x86_64                randconfig-006-20260114    gcc-14
x86_64                randconfig-006-20260115    clang-20
x86_64                randconfig-011-20260114    gcc-14
x86_64                randconfig-012-20260114    gcc-14
x86_64                randconfig-013-20260114    gcc-14
x86_64                randconfig-014-20260114    gcc-14
x86_64                randconfig-015-20260114    gcc-14
x86_64                randconfig-016-20260114    gcc-14
x86_64                randconfig-071-20260114    clang-20
x86_64                randconfig-071-20260115    gcc-14
x86_64                randconfig-072-20260114    clang-20
x86_64                randconfig-072-20260115    gcc-14
x86_64                randconfig-073-20260114    clang-20
x86_64                randconfig-073-20260115    gcc-14
x86_64                randconfig-074-20260114    clang-20
x86_64                randconfig-074-20260115    gcc-14
x86_64                randconfig-075-20260114    clang-20
x86_64                randconfig-075-20260115    gcc-14
x86_64                randconfig-076-20260114    clang-20
x86_64                randconfig-076-20260115    gcc-14
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-22
xtensa                           allyesconfig    clang-22
xtensa                randconfig-001-20260114    clang-20
xtensa                randconfig-001-20260115    clang-22
xtensa                randconfig-002-20260114    clang-20
xtensa                randconfig-002-20260115    clang-22

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

