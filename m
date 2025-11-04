Return-Path: <linux-wireless+bounces-28533-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 00073C30D3C
	for <lists+linux-wireless@lfdr.de>; Tue, 04 Nov 2025 12:52:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 759914E1C75
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Nov 2025 11:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE37E2D6E6E;
	Tue,  4 Nov 2025 11:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TI9yUYqM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D1E2BDC09
	for <linux-wireless@vger.kernel.org>; Tue,  4 Nov 2025 11:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762257081; cv=none; b=mSY805m1NawiTHIl6JJ5ZhivWdwOtzlFH3AwJJwnRBDWSXth8V6SJI85QuLjIqRo9xI6UkbxTAhM80yoLwo5q2v4p1zqKC7Ti+lxQi20kCW2bFEcQxTANva7uhwp6tdTZ9u+vkOygH2KX9Ttpl33zvzgJIWo/5hJnfv/bw+wk7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762257081; c=relaxed/simple;
	bh=Y/7S8wh+nOIxUBgiwh5HXJsP39WYnu7j1WPO2GL4P2g=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Z4z8B0ALS5m9fjx08V82ArQxh2TgMXXJkZgiLHK5/cRizSi2WA1mGA9ybCc5kIJtTv8xqD88Bp/Rxa3BeISiAmmrRp6O+AY4SLvOfarF635fZWTMx6iE+isy8ITx0bOV0Ii2gwb7I4jjVwtXyFHxA6nJx9GxvZvi19GGNwsBexY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TI9yUYqM; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762257080; x=1793793080;
  h=date:from:to:cc:subject:message-id;
  bh=Y/7S8wh+nOIxUBgiwh5HXJsP39WYnu7j1WPO2GL4P2g=;
  b=TI9yUYqM8v0+PTVsFvofGRkyOGfep39mjFTcx8/C/TFZoyHSGPKupZrB
   bFvZ5FWae0LLxF9PTeeqz+VhiQ/EwLPocfl8LOYAuglqzRaOn92P3hD2O
   H3BL7J5XMYLpqoo417JQaiLQPwkv4PtGQxxTfXUcWToAqAeDzpVO/gwhu
   dx90PlCxAz1X5R0XARaOD5ARJG25OgOzw0S9r1rOMj4bzRz8ObbaMZRus
   Nz7NqtE3eh/is9s+5bwgeJ09aCcI6l5HavvVthHiH4k9FiR/lRUiVoqpq
   AYTqhJ0wM3XSjBl1sqZYef52XYx1lvfJe8WqgJwUtIAxJbCcf81KNyqHb
   g==;
X-CSE-ConnectionGUID: NYqVg5SZQaCCGlb0AcBr9g==
X-CSE-MsgGUID: EtAAKUPSRBurMTj7SfU6vQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11602"; a="51920149"
X-IronPort-AV: E=Sophos;i="6.19,279,1754982000"; 
   d="scan'208";a="51920149"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 03:51:19 -0800
X-CSE-ConnectionGUID: NKEb9dPyT9WCdb5ryC5H0Q==
X-CSE-MsgGUID: y1USp64eRxmvDlkF/sxTUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,279,1754982000"; 
   d="scan'208";a="192305877"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa005.jf.intel.com with ESMTP; 04 Nov 2025 03:51:18 -0800
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vGFZD-000RMK-20;
	Tue, 04 Nov 2025 11:51:15 +0000
Date: Tue, 04 Nov 2025 19:51:09 +0800
From: kernel test robot <lkp@intel.com>
To: Johannes Berg <johannes.berg@intel.com>
Cc: linux-wireless@vger.kernel.org
Subject: [wireless-next:main] BUILD SUCCESS
 dcbc94c1f044235f90f3272baa3bf4ffb6dc3cbd
Message-ID: <202511041903.GyYmqbEw-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: dcbc94c1f044235f90f3272baa3bf4ffb6dc3cbd  Merge tag 'iwlwifi-next-2025-10-28' of https://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next

elapsed time: 1466m

configs tested: 168
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    gcc-15.1.0
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    gcc-15.1.0
arc                                 defconfig    gcc-15.1.0
arc                        nsimosci_defconfig    gcc-15.1.0
arc                   randconfig-001-20251103    gcc-9.5.0
arc                   randconfig-002-20251103    gcc-15.1.0
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    gcc-15.1.0
arm                                 defconfig    clang-22
arm                           imxrt_defconfig    clang-22
arm                         mv78xx0_defconfig    clang-19
arm                   randconfig-001-20251103    clang-22
arm                   randconfig-002-20251103    clang-16
arm                   randconfig-003-20251103    gcc-14.3.0
arm                   randconfig-004-20251103    clang-22
arm                         s3c6400_defconfig    gcc-15.1.0
arm                         s5pv210_defconfig    gcc-15.1.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                            allyesconfig    clang-22
arm64                               defconfig    gcc-15.1.0
arm64                 randconfig-001-20251104    gcc-13.4.0
arm64                 randconfig-002-20251104    clang-22
arm64                 randconfig-003-20251104    gcc-13.4.0
arm64                 randconfig-004-20251104    clang-22
csky                             allmodconfig    gcc-15.1.0
csky                              allnoconfig    gcc-15.1.0
csky                             allyesconfig    gcc-15.1.0
csky                                defconfig    gcc-15.1.0
csky                  randconfig-001-20251104    gcc-10.5.0
csky                  randconfig-002-20251104    gcc-15.1.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon                             defconfig    clang-22
hexagon               randconfig-001-20251103    clang-22
hexagon               randconfig-002-20251103    clang-22
i386                              allnoconfig    gcc-14
i386        buildonly-randconfig-001-20251104    gcc-14
i386        buildonly-randconfig-002-20251104    clang-20
i386        buildonly-randconfig-003-20251104    gcc-12
i386        buildonly-randconfig-004-20251104    gcc-14
i386        buildonly-randconfig-005-20251104    gcc-12
i386        buildonly-randconfig-006-20251104    gcc-14
i386                                defconfig    clang-20
i386                  randconfig-001-20251104    gcc-12
i386                  randconfig-002-20251104    gcc-14
i386                  randconfig-003-20251104    clang-20
i386                  randconfig-004-20251104    gcc-14
i386                  randconfig-005-20251104    gcc-14
i386                  randconfig-006-20251104    gcc-14
i386                  randconfig-007-20251104    gcc-14
i386                  randconfig-011-20251104    gcc-13
i386                  randconfig-012-20251104    clang-20
i386                  randconfig-013-20251104    gcc-14
i386                  randconfig-014-20251104    clang-20
i386                  randconfig-015-20251104    gcc-14
i386                  randconfig-016-20251104    clang-20
i386                  randconfig-017-20251104    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                        allyesconfig    clang-22
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251103    gcc-12.5.0
loongarch             randconfig-002-20251103    gcc-14.3.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                                defconfig    gcc-15.1.0
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
microblaze                          defconfig    gcc-15.1.0
mips                             allmodconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                             allyesconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20251103    gcc-11.5.0
nios2                 randconfig-002-20251103    gcc-11.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-15.1.0
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                randconfig-001-20251103    gcc-14.3.0
parisc                randconfig-002-20251103    gcc-15.1.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-22
powerpc                 mpc836x_rdk_defconfig    clang-22
powerpc               randconfig-001-20251103    gcc-8.5.0
powerpc               randconfig-002-20251103    clang-20
powerpc64             randconfig-001-20251103    clang-22
powerpc64             randconfig-002-20251103    gcc-8.5.0
riscv                             allnoconfig    gcc-15.1.0
riscv                 randconfig-001-20251104    gcc-8.5.0
riscv                 randconfig-002-20251104    gcc-8.5.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                          debug_defconfig    gcc-15.1.0
s390                  randconfig-001-20251104    clang-22
s390                  randconfig-002-20251104    clang-22
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-15.1.0
sh                    randconfig-001-20251104    gcc-13.4.0
sh                    randconfig-002-20251104    gcc-11.5.0
sh                          rsk7203_defconfig    gcc-15.1.0
sh                           se7722_defconfig    gcc-15.1.0
sh                   secureedge5410_defconfig    gcc-15.1.0
sh                        sh7785lcr_defconfig    gcc-15.1.0
sh                             shx3_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                 randconfig-001-20251104    gcc-13.4.0
sparc                 randconfig-002-20251104    gcc-12.5.0
sparc64                             defconfig    clang-20
sparc64               randconfig-001-20251104    gcc-8.5.0
sparc64               randconfig-002-20251104    clang-22
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                                  defconfig    clang-22
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251104    clang-22
um                    randconfig-002-20251104    clang-22
um                           x86_64_defconfig    clang-22
x86_64                            allnoconfig    clang-20
x86_64      buildonly-randconfig-001-20251104    clang-20
x86_64      buildonly-randconfig-002-20251104    gcc-12
x86_64      buildonly-randconfig-003-20251104    gcc-14
x86_64      buildonly-randconfig-004-20251104    gcc-14
x86_64      buildonly-randconfig-005-20251104    gcc-12
x86_64      buildonly-randconfig-006-20251104    clang-20
x86_64                              defconfig    gcc-14
x86_64                randconfig-001-20251104    gcc-14
x86_64                randconfig-002-20251104    clang-20
x86_64                randconfig-003-20251104    gcc-13
x86_64                randconfig-004-20251104    clang-20
x86_64                randconfig-005-20251104    clang-20
x86_64                randconfig-006-20251104    gcc-14
x86_64                randconfig-011-20251104    gcc-14
x86_64                randconfig-012-20251104    gcc-14
x86_64                randconfig-013-20251104    clang-20
x86_64                randconfig-014-20251104    clang-20
x86_64                randconfig-015-20251104    gcc-14
x86_64                randconfig-016-20251104    clang-20
x86_64                randconfig-071-20251104    clang-20
x86_64                randconfig-072-20251104    clang-20
x86_64                randconfig-073-20251104    clang-20
x86_64                randconfig-074-20251104    gcc-14
x86_64                randconfig-075-20251104    clang-20
x86_64                randconfig-076-20251104    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                  nommu_kc705_defconfig    gcc-15.1.0
xtensa                randconfig-001-20251104    gcc-13.4.0
xtensa                randconfig-002-20251104    gcc-11.5.0
xtensa                    smp_lx200_defconfig    gcc-15.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

