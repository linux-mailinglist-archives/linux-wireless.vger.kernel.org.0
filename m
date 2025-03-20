Return-Path: <linux-wireless+bounces-20619-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4917DA6AEFE
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Mar 2025 21:11:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACD59461234
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Mar 2025 20:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E16AC227E98;
	Thu, 20 Mar 2025 20:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bc3RCTEH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C0521CA00
	for <linux-wireless@vger.kernel.org>; Thu, 20 Mar 2025 20:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742501481; cv=none; b=uj7ybjQyk6fKD99bV80SnvKIGxyBHVUp9ZNW8Jwa//6b1akDixZV+JPBr2uSNPVCK1Zxz3k9yxoW3ATsGHkU/zLGKmCclR6TwNcT34r6h8yOTaQROHlzA35TPVmhkhquZEVDAYjfUuTK9an+XvsBSPyW5grcZPRnpImpFvXYAhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742501481; c=relaxed/simple;
	bh=YpmJz6tBFHE2m6skZKMQjQOQkR8wo0jcZjlI++BMaq8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=pCP93ESLipsDnD/ZT4686XM2SVsK0AQdyk2cVBKrJ9sKKmHnvW9IwZXcp0r+F3Ui3qBztpVADWm50ZRR26pgq+VjvBNcsYd8da85O6dpJnddQEnQBVL9uOgBqwvcGSUtrO3m1yotNVgJjoKb10NKkjgF14ksBQd7v4jUKWNGWOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bc3RCTEH; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742501480; x=1774037480;
  h=date:from:to:cc:subject:message-id;
  bh=YpmJz6tBFHE2m6skZKMQjQOQkR8wo0jcZjlI++BMaq8=;
  b=Bc3RCTEH++vj70BOLMyT8sj1lb5JltKB67H9uk+967FCP0lEjTXlrTge
   tXEJeTud2Pg/GeK5zy3dpfcLSbWiv6cRacMQsNTGCOUSUOPLy8pIeGyVl
   y+pLr2HqgSaiBFUHDA4+719Rt7JuaxvzciS0zkJJw0ZACHc1+NugNPaHq
   4VknTcyUZlrRU3DiRHk21VJW+fHWYAeSh6WGQTl/XDoNsRFOMpROiF3nh
   6vfv0sWFoMfyodVflvTMDG9Er/4V6hMeMyEMOKJMSK05fDEBmvfzZa3l1
   5Oq8VuJ7tFBh5I4aeAWcOdsErxwqieWunbPowAMKIA1p5hJgEkQTJFGSt
   g==;
X-CSE-ConnectionGUID: 3ga46WgbSHmX6WQsgbpIlA==
X-CSE-MsgGUID: MGKEzI2ORw+/PzmrU8JdVA==
X-IronPort-AV: E=McAfee;i="6700,10204,11379"; a="43005322"
X-IronPort-AV: E=Sophos;i="6.14,262,1736841600"; 
   d="scan'208";a="43005322"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 13:11:19 -0700
X-CSE-ConnectionGUID: sDE3CYyCT6+1neon5qgRZA==
X-CSE-MsgGUID: ZdAS0eAtTsS4dS3MTbfhXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,262,1736841600"; 
   d="scan'208";a="128422824"
Received: from lkp-server02.sh.intel.com (HELO e98e3655d6d2) ([10.239.97.151])
  by orviesa005.jf.intel.com with ESMTP; 20 Mar 2025 13:11:17 -0700
Received: from kbuild by e98e3655d6d2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tvMEV-0000jh-1S;
	Thu, 20 Mar 2025 20:11:15 +0000
Date: Fri, 21 Mar 2025 04:10:11 +0800
From: kernel test robot <lkp@intel.com>
To: Johannes Berg <johannes.berg@intel.com>
Cc: Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org
Subject: [wireless-next:main] BUILD SUCCESS
 1794d7ab34d2221ac7eb921b171e75b856e10561
Message-ID: <202503210405.GbPYmCC7-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: 1794d7ab34d2221ac7eb921b171e75b856e10561  wifi: mt76: mt7996: fix locking in mt7996_mac_sta_rc_work()

elapsed time: 1451m

configs tested: 203
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-9.3.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    clang-19
arc                              allmodconfig    gcc-14.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-19
arc                              allyesconfig    gcc-14.2.0
arc                                 defconfig    gcc-14.2.0
arc                         haps_hs_defconfig    gcc-14.2.0
arc                        nsimosci_defconfig    gcc-14.2.0
arc                   randconfig-001-20250320    gcc-10.5.0
arc                   randconfig-001-20250321    clang-21
arc                   randconfig-002-20250320    gcc-8.5.0
arc                   randconfig-002-20250321    clang-21
arm                              allmodconfig    clang-19
arm                              allmodconfig    gcc-14.2.0
arm                              allmodconfig    gcc-8.5.0
arm                               allnoconfig    clang-21
arm                              allyesconfig    clang-19
arm                              allyesconfig    gcc-6.5.0
arm                         assabet_defconfig    gcc-14.2.0
arm                                 defconfig    gcc-14.2.0
arm                            dove_defconfig    gcc-14.2.0
arm                   randconfig-001-20250320    clang-20
arm                   randconfig-001-20250321    clang-21
arm                   randconfig-002-20250320    clang-16
arm                   randconfig-002-20250321    clang-21
arm                   randconfig-003-20250320    gcc-8.5.0
arm                   randconfig-003-20250321    clang-21
arm                   randconfig-004-20250320    gcc-6.5.0
arm                   randconfig-004-20250321    clang-21
arm                           sama7_defconfig    gcc-14.2.0
arm                           stm32_defconfig    gcc-14.2.0
arm                       versatile_defconfig    gcc-14.2.0
arm                         wpcm450_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20250320    clang-21
arm64                 randconfig-001-20250321    clang-21
arm64                 randconfig-002-20250320    clang-21
arm64                 randconfig-002-20250321    clang-21
arm64                 randconfig-003-20250320    clang-19
arm64                 randconfig-003-20250321    clang-21
arm64                 randconfig-004-20250320    gcc-8.5.0
arm64                 randconfig-004-20250321    clang-21
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20250320    gcc-10.5.0
csky                  randconfig-001-20250321    gcc-7.5.0
csky                  randconfig-002-20250320    gcc-14.2.0
csky                  randconfig-002-20250321    gcc-7.5.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    gcc-14.2.0
hexagon               randconfig-001-20250320    clang-18
hexagon               randconfig-001-20250321    gcc-7.5.0
hexagon               randconfig-002-20250320    clang-21
hexagon               randconfig-002-20250321    gcc-7.5.0
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250320    gcc-12
i386        buildonly-randconfig-002-20250320    clang-20
i386        buildonly-randconfig-003-20250320    clang-20
i386        buildonly-randconfig-004-20250320    clang-20
i386        buildonly-randconfig-005-20250320    gcc-12
i386        buildonly-randconfig-006-20250320    clang-20
i386                                defconfig    clang-20
loongarch                        allmodconfig    gcc-12.4.0
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20250320    gcc-14.2.0
loongarch             randconfig-001-20250321    gcc-7.5.0
loongarch             randconfig-002-20250320    gcc-12.4.0
loongarch             randconfig-002-20250321    gcc-7.5.0
m68k                             allmodconfig    gcc-14.2.0
m68k                             allmodconfig    gcc-8.5.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-6.5.0
m68k                                defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-9.3.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-9.3.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                   sb1250_swarm_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250320    gcc-6.5.0
nios2                 randconfig-001-20250321    gcc-7.5.0
nios2                 randconfig-002-20250320    gcc-12.4.0
nios2                 randconfig-002-20250321    gcc-7.5.0
openrisc                          allnoconfig    clang-15
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-12
openrisc                  or1klitex_defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-10.5.0
parisc                            allnoconfig    clang-15
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20250320    gcc-13.3.0
parisc                randconfig-001-20250321    gcc-7.5.0
parisc                randconfig-002-20250320    gcc-11.5.0
parisc                randconfig-002-20250321    gcc-7.5.0
parisc64                            defconfig    gcc-14.2.0
powerpc                          allmodconfig    gcc-5.5.0
powerpc                           allnoconfig    clang-15
powerpc                          allyesconfig    clang-21
powerpc                     mpc83xx_defconfig    gcc-14.2.0
powerpc               randconfig-001-20250320    gcc-6.5.0
powerpc               randconfig-001-20250321    gcc-7.5.0
powerpc               randconfig-002-20250320    clang-21
powerpc               randconfig-002-20250321    gcc-7.5.0
powerpc               randconfig-003-20250320    clang-21
powerpc               randconfig-003-20250321    gcc-7.5.0
powerpc                     tqm5200_defconfig    gcc-14.2.0
powerpc                     tqm8541_defconfig    gcc-14.2.0
powerpc64             randconfig-001-20250320    clang-21
powerpc64             randconfig-001-20250321    gcc-7.5.0
powerpc64             randconfig-002-20250320    gcc-8.5.0
powerpc64             randconfig-002-20250321    gcc-7.5.0
powerpc64             randconfig-003-20250320    clang-21
powerpc64             randconfig-003-20250321    gcc-7.5.0
riscv                            allmodconfig    clang-21
riscv                             allnoconfig    clang-15
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250320    clang-21
riscv                 randconfig-001-20250321    gcc-6.5.0
riscv                 randconfig-002-20250320    gcc-8.5.0
riscv                 randconfig-002-20250321    gcc-6.5.0
s390                             alldefconfig    gcc-14.2.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-15
s390                             allyesconfig    gcc-14.2.0
s390                             allyesconfig    gcc-8.5.0
s390                          debug_defconfig    gcc-14.2.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250320    gcc-5.5.0
s390                  randconfig-001-20250321    gcc-6.5.0
s390                  randconfig-002-20250320    gcc-7.5.0
s390                  randconfig-002-20250321    gcc-6.5.0
sh                               allmodconfig    gcc-14.2.0
sh                               allmodconfig    gcc-9.3.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                               allyesconfig    gcc-7.5.0
sh                                  defconfig    gcc-12
sh                    randconfig-001-20250320    gcc-14.2.0
sh                    randconfig-001-20250321    gcc-6.5.0
sh                    randconfig-002-20250320    gcc-10.5.0
sh                    randconfig-002-20250321    gcc-6.5.0
sparc                            allmodconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-6.5.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250320    gcc-7.5.0
sparc                 randconfig-001-20250321    gcc-6.5.0
sparc                 randconfig-002-20250320    gcc-7.5.0
sparc                 randconfig-002-20250321    gcc-6.5.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250320    gcc-5.5.0
sparc64               randconfig-001-20250321    gcc-6.5.0
sparc64               randconfig-002-20250320    gcc-13.3.0
sparc64               randconfig-002-20250321    gcc-6.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-15
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250320    gcc-12
um                    randconfig-001-20250321    gcc-6.5.0
um                    randconfig-002-20250320    clang-16
um                    randconfig-002-20250321    gcc-6.5.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250320    clang-20
x86_64      buildonly-randconfig-001-20250321    clang-20
x86_64      buildonly-randconfig-002-20250320    gcc-12
x86_64      buildonly-randconfig-002-20250321    clang-20
x86_64      buildonly-randconfig-003-20250320    clang-20
x86_64      buildonly-randconfig-003-20250321    clang-20
x86_64      buildonly-randconfig-004-20250320    clang-20
x86_64      buildonly-randconfig-004-20250321    clang-20
x86_64      buildonly-randconfig-005-20250320    clang-20
x86_64      buildonly-randconfig-005-20250321    clang-20
x86_64      buildonly-randconfig-006-20250320    gcc-12
x86_64      buildonly-randconfig-006-20250321    clang-20
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                  audio_kc705_defconfig    gcc-14.2.0
xtensa                randconfig-001-20250320    gcc-9.3.0
xtensa                randconfig-001-20250321    gcc-6.5.0
xtensa                randconfig-002-20250320    gcc-11.5.0
xtensa                randconfig-002-20250321    gcc-6.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

