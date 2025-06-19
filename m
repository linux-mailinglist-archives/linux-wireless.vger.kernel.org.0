Return-Path: <linux-wireless+bounces-24264-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 961D8ADFE69
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Jun 2025 09:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FF7E18958A4
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Jun 2025 07:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D789E246794;
	Thu, 19 Jun 2025 07:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BZCq0d+T"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08B4242D9F
	for <linux-wireless@vger.kernel.org>; Thu, 19 Jun 2025 07:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750317028; cv=none; b=Xa/CPqt32y5D1qgu1bND0RQ0OLc6KPebZfXYne8annz3oCI8r1HfirdqtjrdlDaGtISUkgTMlkOskEVZMYvld4F9xDx4GbcSnrBsqZ44waO5+6lrn7Mno47qIgGMnNGrM3CS6f/Ot7G81C0Vc2wEOfEJtOi+BbYMZart04wX9GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750317028; c=relaxed/simple;
	bh=0uerSldYab5YoQNyCNCBEKU9RPNcm9BPwlTnJQamTLE=;
	h=Date:From:To:Cc:Subject:Message-ID; b=n8S9K6vJBmktUNSVBuWtzQpTz3Wh6RZViZ462232IzuNUFebIe4IlUn2hxg1N5JYDtl46LF6RX7XdIPnQpAXhCI7HahCHoBdhklrn/kkmfnaxNQXYxg0B9DQiQWkHBP6GP37ZL8ojhEkxmNQBW1hApi3hq03NBi8GjXRZgwCEoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BZCq0d+T; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750317027; x=1781853027;
  h=date:from:to:cc:subject:message-id;
  bh=0uerSldYab5YoQNyCNCBEKU9RPNcm9BPwlTnJQamTLE=;
  b=BZCq0d+TSTCJqRNX7vKFbbPNjLQSMkQYVJB4VFRwF3UZKCxeIjTLi57D
   Y0jrFoRs6LJPyFGlePi8Z3SGo/JXYEqcZVHr6+wjW5pVyqUDIPNKZOwhS
   dnMcF+/DPa0QMMIS8XVXwwV1ZGKcx2KyH9IVdShngX1bnqMfmM1bPTU/K
   8M63ovMw/xSevgjhIZkxyIJyDHrRMBQ9xDIwjZ6X6WRCYhUdGTUPXyoki
   k8EpEQe8E220ZkuFA1aHeYGCHyTLXXQSBtYqSn0nu8htj3mogTzqHoIsE
   x3LbZazzZqmfYTD9EsGBveoW7sbeS4Fc0AW7P75QCejxjxrO7W4ZEAvyL
   A==;
X-CSE-ConnectionGUID: LWI69N/XRLOL0A6vvbuG0A==
X-CSE-MsgGUID: trH1fg0bSjy09pEvDiqT5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11468"; a="55193054"
X-IronPort-AV: E=Sophos;i="6.16,247,1744095600"; 
   d="scan'208";a="55193054"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2025 00:10:26 -0700
X-CSE-ConnectionGUID: YCCLKttuQ0mN+RaoWDnj4A==
X-CSE-MsgGUID: 6Li77Ik2RuudCtVydg2rkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,247,1744095600"; 
   d="scan'208";a="154936401"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 19 Jun 2025 00:10:24 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uS9Pi-000KUb-2E;
	Thu, 19 Jun 2025 07:10:22 +0000
Date: Thu, 19 Jun 2025 15:09:34 +0800
From: kernel test robot <lkp@intel.com>
To: Johannes Berg <johannes.berg@intel.com>
Cc: Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org
Subject: [wireless:for-next] BUILD SUCCESS
 68dd8eeb7208f16a0592da3896dd59379d95d553
Message-ID: <202506191523.8GEn2QGJ-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git for-next
branch HEAD: 68dd8eeb7208f16a0592da3896dd59379d95d553  Merge tag 'iwlwifi-fixes-2025-06-18' of https://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next

elapsed time: 1219m

configs tested: 266
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.1.0
alpha                            allyesconfig    gcc-15.1.0
arc                              allmodconfig    clang-19
arc                              allmodconfig    gcc-15.1.0
arc                               allnoconfig    gcc-15.1.0
arc                              allyesconfig    clang-19
arc                              allyesconfig    gcc-15.1.0
arc                   randconfig-001-20250618    gcc-11.5.0
arc                   randconfig-001-20250619    gcc-15.1.0
arc                   randconfig-002-20250618    gcc-15.1.0
arc                   randconfig-002-20250619    gcc-15.1.0
arm                              allmodconfig    clang-19
arm                              allmodconfig    gcc-15.1.0
arm                               allnoconfig    clang-21
arm                               allnoconfig    gcc-15.1.0
arm                              allyesconfig    clang-19
arm                              allyesconfig    gcc-15.1.0
arm                         bcm2835_defconfig    gcc-15.1.0
arm                      jornada720_defconfig    clang-21
arm                        multi_v7_defconfig    gcc-15.1.0
arm                   randconfig-001-20250618    gcc-15.1.0
arm                   randconfig-001-20250619    clang-21
arm                   randconfig-001-20250619    gcc-15.1.0
arm                   randconfig-002-20250618    gcc-10.5.0
arm                   randconfig-002-20250619    gcc-15.1.0
arm                   randconfig-002-20250619    gcc-8.5.0
arm                   randconfig-003-20250618    clang-21
arm                   randconfig-003-20250619    gcc-15.1.0
arm                   randconfig-003-20250619    gcc-8.5.0
arm                   randconfig-004-20250618    gcc-11.5.0
arm                   randconfig-004-20250619    gcc-10.5.0
arm                   randconfig-004-20250619    gcc-15.1.0
arm                           stm32_defconfig    gcc-15.1.0
arm64                            allmodconfig    clang-19
arm64                             allnoconfig    gcc-15.1.0
arm64                 randconfig-001-20250618    clang-21
arm64                 randconfig-001-20250619    gcc-15.1.0
arm64                 randconfig-001-20250619    gcc-8.5.0
arm64                 randconfig-002-20250618    clang-21
arm64                 randconfig-002-20250619    gcc-15.1.0
arm64                 randconfig-002-20250619    gcc-9.5.0
arm64                 randconfig-003-20250618    gcc-14.3.0
arm64                 randconfig-003-20250619    gcc-10.5.0
arm64                 randconfig-003-20250619    gcc-15.1.0
arm64                 randconfig-004-20250618    clang-16
arm64                 randconfig-004-20250619    gcc-10.5.0
arm64                 randconfig-004-20250619    gcc-15.1.0
csky                              allnoconfig    gcc-15.1.0
csky                  randconfig-001-20250618    gcc-13.3.0
csky                  randconfig-001-20250619    gcc-11.5.0
csky                  randconfig-001-20250619    gcc-8.5.0
csky                  randconfig-002-20250618    gcc-15.1.0
csky                  randconfig-002-20250619    gcc-8.5.0
csky                  randconfig-002-20250619    gcc-9.3.0
hexagon                          allmodconfig    clang-17
hexagon                           allnoconfig    clang-21
hexagon                           allnoconfig    gcc-15.1.0
hexagon                          allyesconfig    clang-21
hexagon               randconfig-001-20250618    clang-19
hexagon               randconfig-001-20250619    clang-21
hexagon               randconfig-001-20250619    gcc-8.5.0
hexagon               randconfig-002-20250618    clang-16
hexagon               randconfig-002-20250619    clang-21
hexagon               randconfig-002-20250619    gcc-8.5.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-20
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20250618    clang-20
i386        buildonly-randconfig-001-20250619    clang-20
i386        buildonly-randconfig-001-20250619    gcc-12
i386        buildonly-randconfig-002-20250618    gcc-12
i386        buildonly-randconfig-002-20250619    clang-20
i386        buildonly-randconfig-002-20250619    gcc-12
i386        buildonly-randconfig-003-20250618    clang-20
i386        buildonly-randconfig-003-20250619    clang-20
i386        buildonly-randconfig-004-20250618    clang-20
i386        buildonly-randconfig-004-20250619    clang-20
i386        buildonly-randconfig-005-20250618    clang-20
i386        buildonly-randconfig-005-20250619    clang-20
i386        buildonly-randconfig-006-20250618    clang-20
i386        buildonly-randconfig-006-20250619    clang-20
i386                                defconfig    clang-20
i386                  randconfig-001-20250619    gcc-12
i386                  randconfig-002-20250619    gcc-12
i386                  randconfig-003-20250619    gcc-12
i386                  randconfig-004-20250619    gcc-12
i386                  randconfig-005-20250619    gcc-12
i386                  randconfig-006-20250619    gcc-12
i386                  randconfig-007-20250619    gcc-12
i386                  randconfig-011-20250619    clang-20
i386                  randconfig-012-20250619    clang-20
i386                  randconfig-013-20250619    clang-20
i386                  randconfig-014-20250619    clang-20
i386                  randconfig-015-20250619    clang-20
i386                  randconfig-016-20250619    clang-20
i386                  randconfig-017-20250619    clang-20
loongarch                        allmodconfig    gcc-15.1.0
loongarch                         allnoconfig    gcc-15.1.0
loongarch             randconfig-001-20250618    gcc-15.1.0
loongarch             randconfig-001-20250619    gcc-15.1.0
loongarch             randconfig-001-20250619    gcc-8.5.0
loongarch             randconfig-002-20250618    gcc-15.1.0
loongarch             randconfig-002-20250619    gcc-15.1.0
loongarch             randconfig-002-20250619    gcc-8.5.0
m68k                             allmodconfig    gcc-15.1.0
m68k                              allnoconfig    gcc-15.1.0
m68k                             allyesconfig    gcc-15.1.0
m68k                         apollo_defconfig    clang-21
m68k                            mac_defconfig    clang-21
microblaze                       allmodconfig    gcc-15.1.0
microblaze                        allnoconfig    gcc-15.1.0
microblaze                       allyesconfig    gcc-15.1.0
mips                              allnoconfig    gcc-15.1.0
mips                           ip30_defconfig    clang-21
mips                           ip32_defconfig    gcc-15.1.0
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20250618    gcc-11.5.0
nios2                 randconfig-001-20250619    gcc-8.5.0
nios2                 randconfig-002-20250618    gcc-8.5.0
nios2                 randconfig-002-20250619    gcc-8.5.0
openrisc                          allnoconfig    gcc-15.1.0
openrisc                         allyesconfig    gcc-15.1.0
openrisc                            defconfig    gcc-12
parisc                           allmodconfig    gcc-15.1.0
parisc                            allnoconfig    gcc-15.1.0
parisc                           allyesconfig    gcc-15.1.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20250618    gcc-10.5.0
parisc                randconfig-001-20250619    gcc-11.5.0
parisc                randconfig-001-20250619    gcc-8.5.0
parisc                randconfig-002-20250618    gcc-8.5.0
parisc                randconfig-002-20250619    gcc-8.5.0
powerpc                          allmodconfig    gcc-15.1.0
powerpc                           allnoconfig    gcc-15.1.0
powerpc                          allyesconfig    clang-21
powerpc                          allyesconfig    gcc-15.1.0
powerpc                   currituck_defconfig    clang-21
powerpc               randconfig-001-20250618    gcc-8.5.0
powerpc               randconfig-001-20250619    gcc-8.5.0
powerpc               randconfig-001-20250619    gcc-9.3.0
powerpc               randconfig-002-20250618    clang-19
powerpc               randconfig-002-20250619    clang-21
powerpc               randconfig-002-20250619    gcc-8.5.0
powerpc               randconfig-003-20250618    clang-21
powerpc               randconfig-003-20250619    gcc-10.5.0
powerpc               randconfig-003-20250619    gcc-8.5.0
powerpc                     tqm8540_defconfig    gcc-15.1.0
powerpc64             randconfig-001-20250618    gcc-8.5.0
powerpc64             randconfig-001-20250619    gcc-11.5.0
powerpc64             randconfig-001-20250619    gcc-8.5.0
powerpc64             randconfig-002-20250618    clang-21
powerpc64             randconfig-002-20250619    clang-21
powerpc64             randconfig-002-20250619    gcc-8.5.0
powerpc64             randconfig-003-20250618    gcc-15.1.0
powerpc64             randconfig-003-20250619    gcc-10.5.0
powerpc64             randconfig-003-20250619    gcc-8.5.0
riscv                            allmodconfig    clang-21
riscv                            allmodconfig    gcc-15.1.0
riscv                             allnoconfig    gcc-15.1.0
riscv                            allyesconfig    clang-16
riscv                            allyesconfig    gcc-15.1.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250618    clang-20
riscv                 randconfig-001-20250619    gcc-11.5.0
riscv                 randconfig-001-20250619    gcc-9.3.0
riscv                 randconfig-002-20250618    clang-21
riscv                 randconfig-002-20250619    clang-16
riscv                 randconfig-002-20250619    gcc-9.3.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    gcc-15.1.0
s390                              allnoconfig    clang-21
s390                             allyesconfig    gcc-15.1.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250618    gcc-8.5.0
s390                  randconfig-001-20250619    clang-19
s390                  randconfig-001-20250619    gcc-9.3.0
s390                  randconfig-002-20250618    gcc-15.1.0
s390                  randconfig-002-20250619    gcc-13.2.0
s390                  randconfig-002-20250619    gcc-9.3.0
sh                               allmodconfig    gcc-15.1.0
sh                                allnoconfig    gcc-15.1.0
sh                               allyesconfig    gcc-15.1.0
sh                         apsh4a3a_defconfig    clang-21
sh                                  defconfig    gcc-12
sh                    randconfig-001-20250618    gcc-15.1.0
sh                    randconfig-001-20250619    gcc-9.3.0
sh                    randconfig-002-20250618    gcc-15.1.0
sh                    randconfig-002-20250619    gcc-9.3.0
sh                           se7705_defconfig    clang-21
sh                            titan_defconfig    gcc-15.1.0
sparc                            allmodconfig    gcc-15.1.0
sparc                             allnoconfig    gcc-15.1.0
sparc                 randconfig-001-20250618    gcc-8.5.0
sparc                 randconfig-001-20250619    gcc-14.3.0
sparc                 randconfig-001-20250619    gcc-9.3.0
sparc                 randconfig-002-20250618    gcc-13.3.0
sparc                 randconfig-002-20250619    gcc-10.3.0
sparc                 randconfig-002-20250619    gcc-9.3.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250618    gcc-13.3.0
sparc64               randconfig-001-20250619    gcc-13.3.0
sparc64               randconfig-001-20250619    gcc-9.3.0
sparc64               randconfig-002-20250618    gcc-8.5.0
sparc64               randconfig-002-20250619    gcc-8.5.0
sparc64               randconfig-002-20250619    gcc-9.3.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-21
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250618    clang-21
um                    randconfig-001-20250619    clang-19
um                    randconfig-001-20250619    gcc-9.3.0
um                    randconfig-002-20250618    clang-21
um                    randconfig-002-20250619    clang-21
um                    randconfig-002-20250619    gcc-9.3.0
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-20
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20250618    clang-20
x86_64      buildonly-randconfig-001-20250619    clang-20
x86_64      buildonly-randconfig-001-20250619    gcc-12
x86_64      buildonly-randconfig-002-20250618    clang-20
x86_64      buildonly-randconfig-002-20250619    gcc-12
x86_64      buildonly-randconfig-003-20250618    gcc-12
x86_64      buildonly-randconfig-003-20250619    clang-20
x86_64      buildonly-randconfig-003-20250619    gcc-12
x86_64      buildonly-randconfig-004-20250618    clang-20
x86_64      buildonly-randconfig-004-20250619    gcc-12
x86_64      buildonly-randconfig-005-20250618    clang-20
x86_64      buildonly-randconfig-005-20250619    clang-20
x86_64      buildonly-randconfig-005-20250619    gcc-12
x86_64      buildonly-randconfig-006-20250618    gcc-12
x86_64      buildonly-randconfig-006-20250619    gcc-12
x86_64                              defconfig    clang-20
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20250619    gcc-11
x86_64                randconfig-002-20250619    gcc-11
x86_64                randconfig-003-20250619    gcc-11
x86_64                randconfig-004-20250619    gcc-11
x86_64                randconfig-005-20250619    gcc-11
x86_64                randconfig-006-20250619    gcc-11
x86_64                randconfig-007-20250619    gcc-11
x86_64                randconfig-008-20250619    gcc-11
x86_64                randconfig-071-20250619    clang-20
x86_64                randconfig-072-20250619    clang-20
x86_64                randconfig-073-20250619    clang-20
x86_64                randconfig-074-20250619    clang-20
x86_64                randconfig-075-20250619    clang-20
x86_64                randconfig-076-20250619    clang-20
x86_64                randconfig-077-20250619    clang-20
x86_64                randconfig-078-20250619    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                          rhel-9.4-rust    clang-18
x86_64                          rhel-9.4-rust    clang-20
xtensa                           alldefconfig    gcc-15.1.0
xtensa                            allnoconfig    gcc-15.1.0
xtensa                randconfig-001-20250618    gcc-13.3.0
xtensa                randconfig-001-20250619    gcc-9.3.0
xtensa                randconfig-002-20250618    gcc-11.5.0
xtensa                randconfig-002-20250619    gcc-8.5.0
xtensa                randconfig-002-20250619    gcc-9.3.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

