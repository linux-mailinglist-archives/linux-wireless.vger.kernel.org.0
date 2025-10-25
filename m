Return-Path: <linux-wireless+bounces-28240-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6966BC0875E
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Oct 2025 02:47:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 242F43B0466
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Oct 2025 00:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A1E71E3787;
	Sat, 25 Oct 2025 00:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S5juU/b3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9D81C8629
	for <linux-wireless@vger.kernel.org>; Sat, 25 Oct 2025 00:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761353272; cv=none; b=FPhbEvTVbv5uCMxgK1svyX81sj2d8BmFGOttSYGXrAJVG5FY/qIshSEv0KEdpMw6BbaYJI/pk/XALXc+HfXjB/0ctO19i4zNbYcphNzeCIYJrnfIjvOCEgopUk+aaWGInByY/3lMnBTaTzfpSOGQ1stXgU5TWGFt5AAusyinXhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761353272; c=relaxed/simple;
	bh=WrNUqJejlhfSV5i+0sDibSaFND794o3H8xV+JRXu2AA=;
	h=Date:From:To:Cc:Subject:Message-ID; b=bJNSojXOlkhD93AjpyBllJwq/JpruWybazqzR46aw3UVbF8UGTOa62tQ506qEViFHOM2kaPyMVY6NRcCMm8mCnZBcNCDF6mr89EFEs4lr4Cd8FdC1gP6F90Z11PsZDxJ1M3Iew4GQes0tzHN4tDFIdIjlJQzGA2M8V5E9aLEeG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S5juU/b3; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761353270; x=1792889270;
  h=date:from:to:cc:subject:message-id;
  bh=WrNUqJejlhfSV5i+0sDibSaFND794o3H8xV+JRXu2AA=;
  b=S5juU/b335GgGemVzlj4lwSF2hAb9K1DGY30jEr+HbihqlpnyXHRywY6
   OH4MPTkIPCTBE2GS3Po7aecTa5QEe62VtAOyarSMlZK9fouwhIf5TmFTW
   xTLjG7shMWRoKOCfofZMw0EPgrtE57VTg1ig4i4TQXrO42qv1vMufTj3b
   lC84kBuDZsXaT3ytvTcKMIgCL5zLM8Ul40c/N1GHgqBaBu1Y7j2OQtia0
   XD8bveOVVJeUkFoMV8sOLKCqdG4Xymkw7jCmq7POamJ4YzWPDbQxVr/QK
   O9XTYVdDAVLmjzbB7g02r5CXQ1TS4Y3l+4DtANM5WPpe1dU49XpYhdY49
   Q==;
X-CSE-ConnectionGUID: 0O7JsLIWQQelnwBS+gGG0Q==
X-CSE-MsgGUID: PJ4qC8zVTvOEvLKi34GGAw==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="81160649"
X-IronPort-AV: E=Sophos;i="6.19,253,1754982000"; 
   d="scan'208";a="81160649"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2025 17:47:50 -0700
X-CSE-ConnectionGUID: 5hLtVWsaSluM0lQUACmeIA==
X-CSE-MsgGUID: bdul9xppS+C1Sp+fltsqzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,253,1754982000"; 
   d="scan'208";a="221760037"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 24 Oct 2025 17:47:48 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vCSRY-000F0t-0C;
	Sat, 25 Oct 2025 00:47:42 +0000
Date: Sat, 25 Oct 2025 08:46:48 +0800
From: kernel test robot <lkp@intel.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>,
 linux-wireless@vger.kernel.org
Subject: [wireless:for-next] BUILD SUCCESS
 a83155cc4ec5dd8c99edb541dc12d3bd8e97eae9
Message-ID: <202510250841.idNxdFlA-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git for-next
branch HEAD: a83155cc4ec5dd8c99edb541dc12d3bd8e97eae9  Merge tag 'wireless-2025-10-23' of https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless

elapsed time: 1447m

configs tested: 188
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    clang-22
alpha                            allyesconfig    gcc-15.1.0
alpha                               defconfig    clang-19
arc                              allmodconfig    clang-19
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    clang-22
arc                              allyesconfig    clang-19
arc                              allyesconfig    gcc-15.1.0
arc                                 defconfig    clang-19
arc                   randconfig-001-20251024    gcc-8.5.0
arc                   randconfig-002-20251024    gcc-14.3.0
arm                              allmodconfig    clang-19
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-22
arm                              allyesconfig    clang-19
arm                              allyesconfig    gcc-15.1.0
arm                        clps711x_defconfig    gcc-15.1.0
arm                                 defconfig    clang-19
arm                          pxa168_defconfig    gcc-15.1.0
arm                   randconfig-001-20251024    clang-20
arm                   randconfig-002-20251024    gcc-15.1.0
arm                   randconfig-003-20251024    clang-22
arm                   randconfig-004-20251024    clang-22
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    clang-22
arm64                            allyesconfig    gcc-15.1.0
arm64                               defconfig    clang-19
arm64                 randconfig-001-20251024    gcc-8.5.0
arm64                 randconfig-002-20251024    clang-16
arm64                 randconfig-003-20251024    gcc-13.4.0
arm64                 randconfig-004-20251024    clang-17
csky                             allmodconfig    gcc-15.1.0
csky                              allnoconfig    clang-22
csky                             allyesconfig    gcc-15.1.0
csky                                defconfig    clang-19
csky                  randconfig-001-20251024    gcc-14.3.0
csky                  randconfig-002-20251024    gcc-11.5.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-22
hexagon                          allyesconfig    clang-22
hexagon                             defconfig    clang-19
hexagon               randconfig-001-20251024    clang-22
hexagon               randconfig-002-20251024    clang-22
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-14
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20251024    clang-20
i386        buildonly-randconfig-002-20251024    gcc-14
i386        buildonly-randconfig-003-20251024    clang-20
i386        buildonly-randconfig-004-20251024    gcc-14
i386        buildonly-randconfig-005-20251024    gcc-14
i386        buildonly-randconfig-006-20251024    gcc-14
i386                                defconfig    clang-20
i386                  randconfig-001-20251024    clang-20
i386                  randconfig-002-20251024    clang-20
i386                  randconfig-003-20251024    clang-20
i386                  randconfig-004-20251024    clang-20
i386                  randconfig-005-20251024    clang-20
i386                  randconfig-006-20251024    clang-20
i386                  randconfig-007-20251024    clang-20
i386                  randconfig-011-20251024    clang-20
i386                  randconfig-012-20251024    clang-20
i386                  randconfig-013-20251024    clang-20
i386                  randconfig-014-20251024    clang-20
i386                  randconfig-015-20251024    clang-20
i386                  randconfig-016-20251024    clang-20
i386                  randconfig-017-20251024    clang-20
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-22
loongarch                        allyesconfig    gcc-15.1.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20251024    gcc-15.1.0
loongarch             randconfig-002-20251024    gcc-15.1.0
m68k                             allmodconfig    clang-19
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    clang-19
m68k                                defconfig    clang-19
m68k                       m5208evb_defconfig    gcc-15.1.0
m68k                            mac_defconfig    gcc-15.1.0
microblaze                       allmodconfig    clang-19
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    clang-19
microblaze                          defconfig    gcc-15.1.0
mips                             allmodconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                             allyesconfig    gcc-15.1.0
mips                          rb532_defconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-15.1.0
nios2                               defconfig    gcc-15.1.0
nios2                 randconfig-001-20251024    gcc-11.5.0
nios2                 randconfig-002-20251024    gcc-11.5.0
openrisc                          allnoconfig    clang-22
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-14
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    clang-22
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-15.1.0
parisc                randconfig-001-20251024    gcc-9.5.0
parisc                randconfig-002-20251024    gcc-13.4.0
parisc64                            defconfig    gcc-15.1.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    clang-22
powerpc                          allyesconfig    gcc-15.1.0
powerpc                   bluestone_defconfig    gcc-15.1.0
powerpc               mpc834x_itxgp_defconfig    gcc-15.1.0
powerpc               randconfig-001-20251024    gcc-8.5.0
powerpc               randconfig-002-20251024    clang-17
powerpc               randconfig-003-20251024    clang-16
powerpc64             randconfig-001-20251024    gcc-12.5.0
powerpc64             randconfig-002-20251024    gcc-14.3.0
powerpc64             randconfig-003-20251024    gcc-8.5.0
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    clang-22
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-14
riscv                 randconfig-001-20251024    clang-22
riscv                 randconfig-002-20251024    clang-22
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-14
s390                  randconfig-001-20251024    gcc-13.4.0
s390                  randconfig-002-20251024    clang-22
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                                  defconfig    gcc-14
sh                          r7785rp_defconfig    gcc-15.1.0
sh                    randconfig-001-20251024    gcc-12.5.0
sh                    randconfig-002-20251024    gcc-14.3.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                               defconfig    gcc-15.1.0
sparc                 randconfig-001-20251024    gcc-12.5.0
sparc                 randconfig-002-20251024    gcc-8.5.0
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20251024    clang-20
sparc64               randconfig-002-20251024    clang-22
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20251024    gcc-14
um                    randconfig-002-20251024    clang-22
um                           x86_64_defconfig    gcc-14
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20251024    clang-20
x86_64      buildonly-randconfig-002-20251024    clang-20
x86_64      buildonly-randconfig-003-20251024    clang-20
x86_64      buildonly-randconfig-004-20251024    gcc-14
x86_64      buildonly-randconfig-005-20251024    gcc-14
x86_64      buildonly-randconfig-006-20251024    clang-20
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20251024    gcc-14
x86_64                randconfig-002-20251024    gcc-14
x86_64                randconfig-003-20251024    gcc-14
x86_64                randconfig-004-20251024    gcc-14
x86_64                randconfig-005-20251024    gcc-14
x86_64                randconfig-006-20251024    gcc-14
x86_64                randconfig-007-20251024    gcc-14
x86_64                randconfig-008-20251024    gcc-14
x86_64                randconfig-071-20251024    clang-20
x86_64                randconfig-072-20251024    clang-20
x86_64                randconfig-073-20251024    clang-20
x86_64                randconfig-074-20251024    clang-20
x86_64                randconfig-075-20251024    clang-20
x86_64                randconfig-076-20251024    clang-20
x86_64                randconfig-077-20251024    clang-20
x86_64                randconfig-078-20251024    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20251024    gcc-11.5.0
xtensa                randconfig-002-20251024    gcc-13.4.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

