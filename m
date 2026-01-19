Return-Path: <linux-wireless+bounces-30980-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D365D3BAD4
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Jan 2026 23:23:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7000C3001CA4
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Jan 2026 22:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D80232FC871;
	Mon, 19 Jan 2026 22:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TxXTqhvB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877CB2F4A05
	for <linux-wireless@vger.kernel.org>; Mon, 19 Jan 2026 22:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768861403; cv=none; b=EHuQkL4ejv0OXn1J2msz4aBGPzlfC4BbFdylB50G5kHPLNTM/bgc+IXzeRh/O5uyuDs1A2lKXWu9rGZskJHfmBAYtU/qE/7ORPQXaKWsMGi2gIKELAA6N48I5x4Y9HaqMCBf2+6W/9bARzm7hWgR3Ss4j1K67m3Cpq1IsJDr0iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768861403; c=relaxed/simple;
	bh=3rhwdQbZYA0fQMENDbqqP5XUo/Qr2BNuEyFYEVccpjU=;
	h=Date:From:To:Cc:Subject:Message-ID; b=azjQdrhLWU6Ya59/8re5aMNLtJgJeP3ecCnN8Puivu/b3qOtX67GMsnnVMyCiS610Y6YGfZZdqDkgZsGv1u4HOkNpWwfZbUWjE6oAbZj3lx5JZEudLHBzX9Q22resAUyxYC/9p1xkp78hRYWKtEOqVYSMB2ayMGmokr5nPighlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TxXTqhvB; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768861402; x=1800397402;
  h=date:from:to:cc:subject:message-id;
  bh=3rhwdQbZYA0fQMENDbqqP5XUo/Qr2BNuEyFYEVccpjU=;
  b=TxXTqhvBlqQYm4uQRY6cGG6K7xtNIpb+ZYlIh3napnImPmoowO2TtBsh
   gN4zGzgiiBtFy1bnFyJGQ3i+tsmltd5Vk8bggNcVA/Fph/gSopn9jIq7M
   STnws6U3nXZSq7g3Ys/Uh3hlPlmQSS4Y6JQeQ+Pl83+prNKIbJz9xwhjC
   7btZjUMIFrrmx+X1/eRowW17Ho5n/a6YWxvCGl8Zj/0tup/peRUJznA4U
   HkG3EcpOdIe688cfiBqpVeECT6ZRWpx+qY7lrRmNm6N5Y5NCQ0hm1Fsjr
   lw0RQnbchF7Y5n6B46A6Q1oddwm99oNdin5L3rDCAs3Zcoo2yiVwqz81m
   w==;
X-CSE-ConnectionGUID: Gv/ZrMYaRQiLtgeRVc+fnQ==
X-CSE-MsgGUID: 86JY0QP4TTSYaKFUABslyg==
X-IronPort-AV: E=McAfee;i="6800,10657,11676"; a="80703352"
X-IronPort-AV: E=Sophos;i="6.21,239,1763452800"; 
   d="scan'208";a="80703352"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2026 14:23:21 -0800
X-CSE-ConnectionGUID: yMfXP3tzSCetRZPbxEsyPw==
X-CSE-MsgGUID: IHeNzd5ZRiCgRN38MRq8ww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,239,1763452800"; 
   d="scan'208";a="228891102"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 19 Jan 2026 14:23:20 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vhxeX-00000000OLn-2Psh;
	Mon, 19 Jan 2026 22:23:17 +0000
Date: Tue, 20 Jan 2026 06:22:44 +0800
From: kernel test robot <lkp@intel.com>
To: Johannes Berg <johannes.berg@intel.com>
Cc: linux-wireless@vger.kernel.org
Subject: [wireless-next:main] BUILD SUCCESS
 1e1dd9eeaab3908746d1dce5db6b0c29e0d28d6d
Message-ID: <202601200638.Trqaqtn7-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: 1e1dd9eeaab3908746d1dce5db6b0c29e0d28d6d  wifi: mac80211: mark iface work SKBs as consumed

elapsed time: 725m

configs tested: 297
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-22
arc                                 defconfig    gcc-15.2.0
arc                 nsimosci_hs_smp_defconfig    gcc-15.2.0
arc                   randconfig-001-20260119    gcc-14.3.0
arc                   randconfig-001-20260120    clang-22
arc                   randconfig-002-20260119    gcc-14.3.0
arc                   randconfig-002-20260120    clang-22
arm                               allnoconfig    clang-22
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.2.0
arm                       aspeed_g5_defconfig    gcc-15.2.0
arm                         bcm2835_defconfig    clang-16
arm                         bcm2835_defconfig    gcc-15.2.0
arm                        clps711x_defconfig    gcc-15.2.0
arm                                 defconfig    gcc-15.2.0
arm                          gemini_defconfig    gcc-15.2.0
arm                          ixp4xx_defconfig    gcc-15.2.0
arm                       multi_v4t_defconfig    clang-22
arm                   randconfig-001-20260119    gcc-14.3.0
arm                   randconfig-001-20260120    clang-22
arm                   randconfig-002-20260119    gcc-14.3.0
arm                   randconfig-002-20260120    clang-22
arm                   randconfig-003-20260119    gcc-14.3.0
arm                   randconfig-003-20260120    clang-22
arm                   randconfig-004-20260119    gcc-14.3.0
arm                   randconfig-004-20260120    clang-22
arm                           sama5_defconfig    gcc-15.2.0
arm                          sp7021_defconfig    clang-16
arm                        spear3xx_defconfig    gcc-15.2.0
arm                           tegra_defconfig    gcc-15.2.0
arm64                            allmodconfig    clang-22
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260119    clang-19
arm64                 randconfig-001-20260120    gcc-15.2.0
arm64                 randconfig-002-20260119    clang-19
arm64                 randconfig-002-20260120    gcc-15.2.0
arm64                 randconfig-003-20260119    clang-19
arm64                 randconfig-003-20260120    gcc-15.2.0
arm64                 randconfig-004-20260119    clang-19
arm64                 randconfig-004-20260120    gcc-15.2.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260119    clang-19
csky                  randconfig-001-20260120    gcc-15.2.0
csky                  randconfig-002-20260119    clang-19
csky                  randconfig-002-20260120    gcc-15.2.0
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-22
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260119    clang-18
hexagon               randconfig-001-20260120    gcc-12.5.0
hexagon               randconfig-002-20260119    clang-18
hexagon               randconfig-002-20260120    gcc-12.5.0
i386                             allmodconfig    clang-20
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386        buildonly-randconfig-001-20260119    clang-20
i386        buildonly-randconfig-001-20260120    gcc-14
i386        buildonly-randconfig-002-20260119    clang-20
i386        buildonly-randconfig-002-20260120    gcc-14
i386        buildonly-randconfig-003-20260119    clang-20
i386        buildonly-randconfig-003-20260120    gcc-14
i386        buildonly-randconfig-004-20260119    clang-20
i386        buildonly-randconfig-004-20260120    gcc-14
i386        buildonly-randconfig-005-20260119    clang-20
i386        buildonly-randconfig-005-20260120    gcc-14
i386        buildonly-randconfig-006-20260119    clang-20
i386        buildonly-randconfig-006-20260120    gcc-14
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260119    gcc-13
i386                  randconfig-001-20260120    clang-20
i386                  randconfig-002-20260119    gcc-13
i386                  randconfig-002-20260120    clang-20
i386                  randconfig-003-20260119    gcc-13
i386                  randconfig-003-20260120    clang-20
i386                  randconfig-004-20260119    gcc-13
i386                  randconfig-004-20260120    clang-20
i386                  randconfig-005-20260119    gcc-13
i386                  randconfig-005-20260120    clang-20
i386                  randconfig-006-20260119    gcc-13
i386                  randconfig-006-20260120    clang-20
i386                  randconfig-007-20260119    gcc-13
i386                  randconfig-007-20260120    clang-20
i386                  randconfig-011-20260119    gcc-14
i386                  randconfig-011-20260120    clang-20
i386                  randconfig-012-20260119    gcc-14
i386                  randconfig-012-20260120    clang-20
i386                  randconfig-013-20260119    gcc-14
i386                  randconfig-013-20260120    clang-20
i386                  randconfig-014-20260119    gcc-14
i386                  randconfig-014-20260120    clang-20
i386                  randconfig-015-20260119    gcc-14
i386                  randconfig-015-20260120    clang-20
i386                  randconfig-016-20260119    gcc-14
i386                  randconfig-016-20260120    clang-20
i386                  randconfig-017-20260119    gcc-14
i386                  randconfig-017-20260120    clang-20
loongarch                        allmodconfig    clang-22
loongarch                         allnoconfig    clang-22
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch                loongson64_defconfig    clang-16
loongarch             randconfig-001-20260119    clang-18
loongarch             randconfig-001-20260120    gcc-12.5.0
loongarch             randconfig-002-20260119    clang-18
loongarch             randconfig-002-20260120    gcc-12.5.0
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                             allyesconfig    gcc-15.2.0
m68k                         amcore_defconfig    gcc-15.2.0
m68k                                defconfig    clang-19
m68k                        mvme16x_defconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                     cu1830-neo_defconfig    gcc-15.2.0
mips                           ip22_defconfig    clang-16
mips                       lemote2f_defconfig    clang-16
mips                  maltasmvp_eva_defconfig    gcc-15.2.0
mips                    maltaup_xpa_defconfig    gcc-15.2.0
mips                           xway_defconfig    gcc-15.2.0
nios2                            allmodconfig    clang-22
nios2                             allnoconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260119    clang-18
nios2                 randconfig-001-20260120    gcc-12.5.0
nios2                 randconfig-002-20260119    clang-18
nios2                 randconfig-002-20260120    gcc-12.5.0
openrisc                         allmodconfig    clang-22
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    clang-19
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260119    clang-22
parisc                randconfig-001-20260120    gcc-8.5.0
parisc                randconfig-002-20260119    clang-22
parisc                randconfig-002-20260120    gcc-8.5.0
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.2.0
powerpc                    amigaone_defconfig    clang-22
powerpc                     asp8347_defconfig    clang-22
powerpc                   currituck_defconfig    gcc-15.2.0
powerpc                       eiger_defconfig    clang-16
powerpc                      ep88xc_defconfig    gcc-15.2.0
powerpc                    gamecube_defconfig    gcc-15.2.0
powerpc                   motionpro_defconfig    clang-22
powerpc                 mpc834x_itx_defconfig    clang-16
powerpc                  mpc885_ads_defconfig    gcc-15.2.0
powerpc               randconfig-001-20260119    clang-22
powerpc               randconfig-001-20260120    gcc-8.5.0
powerpc               randconfig-002-20260119    clang-22
powerpc               randconfig-002-20260120    gcc-8.5.0
powerpc                  storcenter_defconfig    clang-16
powerpc                     tqm5200_defconfig    clang-22
powerpc64             randconfig-001-20260119    clang-22
powerpc64             randconfig-001-20260120    gcc-8.5.0
powerpc64             randconfig-002-20260119    clang-22
powerpc64             randconfig-002-20260120    gcc-8.5.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                    nommu_virt_defconfig    clang-22
riscv                 randconfig-001-20260119    gcc-15.2.0
riscv                 randconfig-001-20260120    gcc-13.4.0
riscv                 randconfig-002-20260119    gcc-15.2.0
riscv                 randconfig-002-20260120    gcc-13.4.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260119    gcc-15.2.0
s390                  randconfig-001-20260120    gcc-13.4.0
s390                  randconfig-002-20260119    gcc-15.2.0
s390                  randconfig-002-20260120    gcc-13.4.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-22
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                                  defconfig    gcc-14
sh                            migor_defconfig    gcc-15.2.0
sh                    randconfig-001-20260119    gcc-15.2.0
sh                    randconfig-001-20260120    gcc-13.4.0
sh                    randconfig-002-20260119    gcc-15.2.0
sh                    randconfig-002-20260120    gcc-13.4.0
sh                           se7712_defconfig    gcc-15.2.0
sh                           se7722_defconfig    gcc-15.2.0
sh                     sh7710voipgw_defconfig    gcc-15.2.0
sparc                             allnoconfig    clang-22
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260119    gcc-14.3.0
sparc                 randconfig-001-20260120    gcc-8.5.0
sparc                 randconfig-002-20260119    gcc-14.3.0
sparc                 randconfig-002-20260120    gcc-8.5.0
sparc64                          alldefconfig    clang-22
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260119    gcc-14.3.0
sparc64               randconfig-001-20260120    gcc-8.5.0
sparc64               randconfig-002-20260119    gcc-14.3.0
sparc64               randconfig-002-20260120    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260119    gcc-14.3.0
um                    randconfig-001-20260120    gcc-8.5.0
um                    randconfig-002-20260119    gcc-14.3.0
um                    randconfig-002-20260120    gcc-8.5.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-22
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260119    gcc-14
x86_64      buildonly-randconfig-002-20260119    gcc-14
x86_64      buildonly-randconfig-003-20260119    gcc-14
x86_64      buildonly-randconfig-004-20260119    gcc-14
x86_64      buildonly-randconfig-005-20260119    gcc-14
x86_64      buildonly-randconfig-006-20260119    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260119    gcc-14
x86_64                randconfig-001-20260120    gcc-14
x86_64                randconfig-002-20260119    gcc-14
x86_64                randconfig-002-20260120    gcc-14
x86_64                randconfig-003-20260119    gcc-14
x86_64                randconfig-003-20260120    gcc-14
x86_64                randconfig-004-20260119    gcc-14
x86_64                randconfig-004-20260120    gcc-14
x86_64                randconfig-005-20260119    gcc-14
x86_64                randconfig-005-20260120    gcc-14
x86_64                randconfig-006-20260119    gcc-14
x86_64                randconfig-006-20260120    gcc-14
x86_64                randconfig-011-20260119    clang-20
x86_64                randconfig-011-20260120    gcc-14
x86_64                randconfig-012-20260119    clang-20
x86_64                randconfig-012-20260120    gcc-14
x86_64                randconfig-013-20260119    clang-20
x86_64                randconfig-013-20260120    gcc-14
x86_64                randconfig-014-20260119    clang-20
x86_64                randconfig-014-20260120    gcc-14
x86_64                randconfig-015-20260119    clang-20
x86_64                randconfig-015-20260120    gcc-14
x86_64                randconfig-016-20260119    clang-20
x86_64                randconfig-016-20260120    gcc-14
x86_64                randconfig-071-20260119    clang-20
x86_64                randconfig-071-20260120    gcc-14
x86_64                randconfig-072-20260119    clang-20
x86_64                randconfig-072-20260120    gcc-14
x86_64                randconfig-073-20260119    clang-20
x86_64                randconfig-073-20260120    gcc-14
x86_64                randconfig-074-20260119    clang-20
x86_64                randconfig-074-20260120    gcc-14
x86_64                randconfig-075-20260119    clang-20
x86_64                randconfig-075-20260120    gcc-14
x86_64                randconfig-076-20260119    clang-20
x86_64                randconfig-076-20260120    gcc-14
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-22
xtensa                            allnoconfig    gcc-15.2.0
xtensa                           allyesconfig    clang-22
xtensa                randconfig-001-20260119    gcc-14.3.0
xtensa                randconfig-001-20260120    gcc-8.5.0
xtensa                randconfig-002-20260119    gcc-14.3.0
xtensa                randconfig-002-20260120    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

