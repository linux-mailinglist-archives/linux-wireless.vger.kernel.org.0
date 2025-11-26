Return-Path: <linux-wireless+bounces-29359-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DF4EC89305
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Nov 2025 11:08:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1BF174EBD38
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Nov 2025 10:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C3D2D7DC5;
	Wed, 26 Nov 2025 10:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CDcDB5eV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3761096F
	for <linux-wireless@vger.kernel.org>; Wed, 26 Nov 2025 10:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764151665; cv=none; b=jLQG7udeh6NNAN+PpEYKcdK33fgTiFE9LbAOyN3QW2DPDdcdtCh8R8MWW/e2q4HPZEMj2PeCPvecyVXdSX8wU17pON74ga2TEksXX6U+ukw9dMJi4Vcg8WruMl3oR0ohp+X2oz08jHOOQcSPxqCetaSv7FuXrlhSnIXSDalolyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764151665; c=relaxed/simple;
	bh=aKCH6MyHxrVY03wjQjZE3aQlEgeplrwL9jEgdOAnsXY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=HAiinnPtkoHzQXp8ehd0nT5z1BFtkW2QKiKEpfK+N/EbeLM9EnngUd5IxJ7a1NpeR0ehWrurs92nvARUCgdLnKAZIcd4FEC9MH9t77KX6bCAmkL0SKSfRlcUdiVkZxu9hOHS+PYL997eitf98g6QhkJZCBCeN1Li2hsNOd5o7cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CDcDB5eV; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764151663; x=1795687663;
  h=date:from:to:cc:subject:message-id;
  bh=aKCH6MyHxrVY03wjQjZE3aQlEgeplrwL9jEgdOAnsXY=;
  b=CDcDB5eVg9ZaDrqjzA1BCxK/1FnWenMnCHn0+Dxp8ipsfQW4Lk51hg9q
   hbTHDn63xYeCr1G3Hov+5DIHa1KY91aYUdUrc/GZC2tHHqoeN33FNfDMr
   DEP05rE3t5zhlUsLBTmbDXiwtc/akr02OfS2BLbxIkIrgEfSCJZyxcEQK
   oUQ72jJLRyKNRlORepf7Ugj+T2kFtapKQ5hI4mCBGqlW4rPrt/vW39Iao
   BqwJl15W1k/HDxqi/RCirBfI45KonIzRq/faN+UtqkzwmcAOD2JqYKVRT
   dkgZwJyVgo4CbMKZq02bskanbujCg6Cza4Ngu/UJVuJ9ZvAAo+PEVx/C+
   A==;
X-CSE-ConnectionGUID: kfM9f4AjSieTADQMgjeL8Q==
X-CSE-MsgGUID: KBUBFNUdRdOR3d/VqFLpdA==
X-IronPort-AV: E=McAfee;i="6800,10657,11624"; a="76806940"
X-IronPort-AV: E=Sophos;i="6.20,228,1758610800"; 
   d="scan'208";a="76806940"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2025 02:07:43 -0800
X-CSE-ConnectionGUID: GQwmHq8ZRsO0itsVnW6dZw==
X-CSE-MsgGUID: my5j+390QHGGt/oT2mL9XQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,228,1758610800"; 
   d="scan'208";a="192917882"
Received: from lkp-server01.sh.intel.com (HELO 4664bbef4914) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 26 Nov 2025 02:07:42 -0800
Received: from kbuild by 4664bbef4914 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vOCR1-000000002hx-1c3e;
	Wed, 26 Nov 2025 10:07:39 +0000
Date: Wed, 26 Nov 2025 18:06:44 +0800
From: kernel test robot <lkp@intel.com>
To: Johannes Berg <johannes.berg@intel.com>
Cc: linux-wireless@vger.kernel.org
Subject: [wireless-next:main] BUILD SUCCESS
 1c6a92a5a5de7ebf94526dee7068926e6d5b1b01
Message-ID: <202511261838.YqL8QslO-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: 1c6a92a5a5de7ebf94526dee7068926e6d5b1b01  wifi: nl80211: vendor-cmd: intel: fix a blank kernel-doc line warning

elapsed time: 1458m

configs tested: 123
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                         haps_hs_defconfig    gcc-15.1.0
arc                   randconfig-001-20251125    gcc-9.5.0
arc                   randconfig-002-20251125    gcc-8.5.0
arm                               allnoconfig    clang-22
arm                        keystone_defconfig    gcc-15.1.0
arm                         mv78xx0_defconfig    clang-19
arm                   randconfig-001-20251125    clang-22
arm                   randconfig-002-20251125    gcc-10.5.0
arm                   randconfig-003-20251125    gcc-10.5.0
arm                   randconfig-004-20251125    gcc-8.5.0
arm                        shmobile_defconfig    gcc-15.1.0
arm                       spear13xx_defconfig    gcc-15.1.0
arm                         wpcm450_defconfig    gcc-15.1.0
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20251126    gcc-8.5.0
arm64                 randconfig-002-20251126    clang-19
arm64                 randconfig-003-20251126    clang-22
arm64                 randconfig-004-20251126    clang-22
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20251126    gcc-11.5.0
csky                  randconfig-002-20251126    gcc-15.1.0
hexagon                           allnoconfig    clang-22
hexagon               randconfig-001-20251125    clang-19
hexagon               randconfig-002-20251125    clang-22
i386                              allnoconfig    gcc-14
i386        buildonly-randconfig-001-20251126    clang-20
i386        buildonly-randconfig-002-20251126    gcc-14
i386        buildonly-randconfig-003-20251126    clang-20
i386        buildonly-randconfig-004-20251126    clang-20
i386        buildonly-randconfig-005-20251126    clang-20
i386        buildonly-randconfig-006-20251126    gcc-14
i386                  randconfig-001-20251126    clang-20
i386                  randconfig-002-20251126    clang-20
i386                  randconfig-003-20251126    gcc-14
i386                  randconfig-004-20251126    clang-20
i386                  randconfig-005-20251126    gcc-14
i386                  randconfig-006-20251126    gcc-14
i386                  randconfig-007-20251126    clang-20
loongarch                         allnoconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251125    gcc-15.1.0
loongarch             randconfig-002-20251125    gcc-12.5.0
m68k                             alldefconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                      maltaaprp_defconfig    clang-22
mips                        vocore2_defconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20251125    gcc-8.5.0
nios2                 randconfig-002-20251125    gcc-11.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251125    gcc-13.4.0
parisc                randconfig-002-20251125    gcc-10.5.0
parisc64                            defconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                      ep88xc_defconfig    gcc-15.1.0
powerpc                     ksi8560_defconfig    gcc-15.1.0
powerpc                     mpc512x_defconfig    clang-22
powerpc                  mpc866_ads_defconfig    clang-22
powerpc                    mvme5100_defconfig    gcc-15.1.0
powerpc                      pcm030_defconfig    clang-22
powerpc               randconfig-001-20251125    clang-19
powerpc               randconfig-002-20251125    gcc-8.5.0
powerpc64             randconfig-001-20251125    clang-16
powerpc64             randconfig-002-20251125    gcc-15.1.0
riscv                             allnoconfig    gcc-15.1.0
riscv                               defconfig    clang-22
riscv                 randconfig-001-20251126    gcc-10.5.0
riscv                 randconfig-002-20251126    clang-22
s390                              allnoconfig    clang-22
s390                                defconfig    clang-22
s390                  randconfig-001-20251126    gcc-8.5.0
s390                  randconfig-002-20251126    gcc-8.5.0
sh                                allnoconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20251126    gcc-14.3.0
sh                    randconfig-002-20251126    gcc-11.5.0
sh                        sh7757lcr_defconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251126    gcc-8.5.0
sparc                 randconfig-002-20251126    gcc-14.3.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20251126    gcc-8.5.0
sparc64               randconfig-002-20251126    clang-22
um                                allnoconfig    clang-22
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251126    clang-19
um                    randconfig-002-20251126    clang-22
um                           x86_64_defconfig    clang-22
x86_64                            allnoconfig    clang-20
x86_64      buildonly-randconfig-001-20251126    clang-20
x86_64      buildonly-randconfig-002-20251126    gcc-14
x86_64      buildonly-randconfig-003-20251126    clang-20
x86_64      buildonly-randconfig-004-20251126    clang-20
x86_64      buildonly-randconfig-005-20251126    gcc-14
x86_64      buildonly-randconfig-006-20251126    clang-20
x86_64                              defconfig    gcc-14
x86_64                randconfig-011-20251126    clang-20
x86_64                randconfig-012-20251126    clang-20
x86_64                randconfig-013-20251126    gcc-14
x86_64                randconfig-014-20251126    clang-20
x86_64                randconfig-015-20251126    clang-20
x86_64                randconfig-016-20251126    clang-20
x86_64                randconfig-071-20251126    clang-20
x86_64                randconfig-072-20251126    gcc-14
x86_64                randconfig-073-20251126    clang-20
x86_64                randconfig-074-20251126    gcc-14
x86_64                randconfig-075-20251126    clang-20
x86_64                randconfig-076-20251126    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20251126    gcc-14.3.0
xtensa                randconfig-002-20251126    gcc-10.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

