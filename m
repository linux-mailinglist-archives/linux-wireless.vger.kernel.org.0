Return-Path: <linux-wireless+bounces-17715-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD6C7A16384
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Jan 2025 19:24:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FBD5188108B
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Jan 2025 18:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8D9C1DF727;
	Sun, 19 Jan 2025 18:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NYkgutIy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F421836D
	for <linux-wireless@vger.kernel.org>; Sun, 19 Jan 2025 18:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737311095; cv=none; b=D1hv8OzW8NAwUBVv0oi/cOw2SnJ5QPA0if0ouqPzsK7VUrVEIJTovyVq/g4HdPzOxWbeIotb17/6MdHHwKl+MQlWPy8NV2Pnljtthikp3u1l4qFKlkjNxzv+JXMIrmFLKR0xveKD9aS8hrB9jYflcG9A7YP0Nt3kfPl8Gz9/fH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737311095; c=relaxed/simple;
	bh=AP0187SvQTi6GCguWFonh9RUONNKeMCDSaqu36QU4JA=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Q1aeuPFEnKMZubfEOth2uVTu5EVNpVFs+wuoe07b6ETP6/5s3b4jkazt8VP48OoqGHRJpTgHpFbQvbiwH8tp/TBwFoKgIzDvf2D52C0IiIILqJRWIoJbK1+pCI/H8QYwOlst6rjwq+gSQoii564ttpl90AogKTueI0SHlbNSW4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NYkgutIy; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737311094; x=1768847094;
  h=date:from:to:cc:subject:message-id;
  bh=AP0187SvQTi6GCguWFonh9RUONNKeMCDSaqu36QU4JA=;
  b=NYkgutIyNEyAeV8B4VOxfi06mpvCZpupcJlwE1vTK3GbsOeM4Tc5CwwU
   bDhhqop3OSsg+YrsF1QeieJoZ1zdC+EJNUK4EyrFRImNlTglXGhIhZ6TW
   GzJpWVdah/FCmXUloMMxHhjrakApCeFskIXB3MEHyKLxlpaD3UgRE/gEw
   rB4E1PQTaFJMuZ+XNHa80XM4jbUoVZFdvZOerK2fXbUIDoW1p8sDJuwnx
   tol2t0xBshXtl25RkwjjaS5d+V/L4SCfKs6+4Dp8lbwDLfyDVm35FmBKs
   lfULLC3FnxG5r6ru/EZN2anqwBpgWTEdl0AUJaCHlOtueqt9ql3Jyu2S+
   Q==;
X-CSE-ConnectionGUID: ZziwZXWCT4uMNAOATR9nMQ==
X-CSE-MsgGUID: wVhWR4QCSNiCCL1Lh7aqWQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11320"; a="36952443"
X-IronPort-AV: E=Sophos;i="6.13,218,1732608000"; 
   d="scan'208";a="36952443"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2025 10:24:53 -0800
X-CSE-ConnectionGUID: yAx2Xjq6TB6lcjO/FFeD5Q==
X-CSE-MsgGUID: TtNnP0jRRESmMqsFwSJJDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,218,1732608000"; 
   d="scan'208";a="106123869"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 19 Jan 2025 10:24:52 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tZZyb-000VhX-2j;
	Sun, 19 Jan 2025 18:24:49 +0000
Date: Mon, 20 Jan 2025 02:23:55 +0800
From: kernel test robot <lkp@intel.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>,
 Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org
Subject: [wireless-next:main] BUILD SUCCESS
 59372af69d4d71e6487614f1b35712cf241eadb4
Message-ID: <202501200249.8WOWVr6m-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: 59372af69d4d71e6487614f1b35712cf241eadb4  Merge tag 'batadv-next-pullrequest-20250117' of git://git.open-mesh.org/linux-merge

elapsed time: 973m

configs tested: 136
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                         haps_hs_defconfig    gcc-13.2.0
arc                   randconfig-001-20250119    gcc-13.2.0
arc                   randconfig-002-20250119    gcc-13.2.0
arc                        vdk_hs38_defconfig    gcc-13.2.0
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-17
arm                              allyesconfig    gcc-14.2.0
arm                       aspeed_g4_defconfig    clang-20
arm                         assabet_defconfig    clang-20
arm                           h3600_defconfig    gcc-14.2.0
arm                         mv78xx0_defconfig    clang-20
arm                          pxa910_defconfig    gcc-14.2.0
arm                   randconfig-001-20250119    gcc-14.2.0
arm                   randconfig-002-20250119    clang-20
arm                   randconfig-003-20250119    clang-16
arm                   randconfig-004-20250119    gcc-14.2.0
arm                       spear13xx_defconfig    gcc-14.2.0
arm                           spitz_defconfig    gcc-14.2.0
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20250119    clang-20
arm64                 randconfig-002-20250119    clang-20
arm64                 randconfig-003-20250119    gcc-14.2.0
arm64                 randconfig-004-20250119    clang-20
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20250119    gcc-14.2.0
csky                  randconfig-002-20250119    gcc-14.2.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    clang-20
hexagon                          allyesconfig    clang-18
hexagon               randconfig-001-20250119    clang-20
hexagon               randconfig-002-20250119    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250119    clang-19
i386        buildonly-randconfig-002-20250119    gcc-12
i386        buildonly-randconfig-003-20250119    gcc-12
i386        buildonly-randconfig-004-20250119    gcc-12
i386        buildonly-randconfig-005-20250119    clang-19
i386        buildonly-randconfig-006-20250119    gcc-12
i386                                defconfig    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20250119    gcc-14.2.0
loongarch             randconfig-002-20250119    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                          ath25_defconfig    clang-16
mips                         bigsur_defconfig    gcc-14.2.0
mips                           ip22_defconfig    gcc-14.2.0
mips                           ip30_defconfig    gcc-14.2.0
nios2                         10m50_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250119    gcc-14.2.0
nios2                 randconfig-002-20250119    gcc-14.2.0
openrisc                         alldefconfig    gcc-14.2.0
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                 simple_smp_defconfig    gcc-14.2.0
openrisc                       virt_defconfig    gcc-14.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                generic-32bit_defconfig    gcc-14.2.0
parisc                randconfig-001-20250119    gcc-14.2.0
parisc                randconfig-002-20250119    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-16
powerpc                      chrp32_defconfig    clang-20
powerpc                      pasemi_defconfig    clang-20
powerpc               randconfig-001-20250119    clang-20
powerpc               randconfig-002-20250119    clang-20
powerpc               randconfig-003-20250119    clang-16
powerpc64                        alldefconfig    clang-20
powerpc64             randconfig-001-20250119    clang-18
powerpc64             randconfig-002-20250119    clang-16
powerpc64             randconfig-003-20250119    gcc-14.2.0
riscv                            allmodconfig    clang-20
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-20
riscv                 randconfig-001-20250119    gcc-14.2.0
riscv                 randconfig-002-20250119    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                  randconfig-001-20250119    clang-20
s390                  randconfig-002-20250119    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                         ap325rxa_defconfig    gcc-14.2.0
sh                         apsh4a3a_defconfig    gcc-14.2.0
sh                          kfr2r09_defconfig    gcc-14.2.0
sh                    randconfig-001-20250119    gcc-14.2.0
sh                    randconfig-002-20250119    gcc-14.2.0
sh                          rsk7269_defconfig    gcc-14.2.0
sh                   sh7770_generic_defconfig    gcc-14.2.0
sh                            shmin_defconfig    gcc-14.2.0
sparc                            alldefconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250119    gcc-14.2.0
sparc                 randconfig-002-20250119    gcc-14.2.0
sparc64               randconfig-001-20250119    gcc-14.2.0
sparc64               randconfig-002-20250119    gcc-14.2.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-18
um                               allyesconfig    gcc-12
um                    randconfig-001-20250119    clang-18
um                    randconfig-002-20250119    clang-16
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250119    clang-19
x86_64      buildonly-randconfig-002-20250119    gcc-12
x86_64      buildonly-randconfig-003-20250119    gcc-12
x86_64      buildonly-randconfig-004-20250119    clang-19
x86_64      buildonly-randconfig-005-20250119    gcc-12
x86_64      buildonly-randconfig-006-20250119    gcc-12
x86_64                              defconfig    gcc-11
xtensa                            allnoconfig    gcc-14.2.0
xtensa                  cadence_csp_defconfig    gcc-14.2.0
xtensa                randconfig-001-20250119    gcc-14.2.0
xtensa                randconfig-002-20250119    gcc-14.2.0
xtensa                    smp_lx200_defconfig    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

