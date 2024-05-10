Return-Path: <linux-wireless+bounces-7415-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 690D78C1CDD
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2024 05:15:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDAE81F21C6B
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2024 03:15:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCAFB5490E;
	Fri, 10 May 2024 03:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nLTmhuFv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D665433CD1
	for <linux-wireless@vger.kernel.org>; Fri, 10 May 2024 03:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715310946; cv=none; b=ZAIJn/pPxNqMjr253/RwSGrMXcHU/PEyjwaO2XYt3GkNokVPhyRRBjPJSfPFo+nAcuypaeK8hx3wPuaWbxRB8qNGdxN4OQyHqwK5FVyCbtnTRdgusjDQX8v/jvVxf7PyZsCtDx2+TcSVmP1IxhsReo0qTGbl6Zueoxq6h5lYk6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715310946; c=relaxed/simple;
	bh=6V1O3HtzRRHp/dNXW42Dgb7DA3CheRd1wO4QqtAjoIY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=pvizhxAmEeYTzp7rQbBwZSG9ulpG+PC6lBPS0svllmZZFd+LdwKq+Cyui0QV1V5JqQ2jjfiY4DRmWflwdqoqVUBm8s3GsiOQgX5B9sRE+I5VjQvcXflo7C6D0IS4KKTjnR2Teze9/2IE+QfSJgKf7UH/mfU94eXR48hJwuorwPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nLTmhuFv; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715310945; x=1746846945;
  h=date:from:to:cc:subject:message-id;
  bh=6V1O3HtzRRHp/dNXW42Dgb7DA3CheRd1wO4QqtAjoIY=;
  b=nLTmhuFv6HXQOjp7lfTLbzBW8moHxjHyVnf1cIIbo9V17rlmpxrqmGiM
   toD/2Xj6VWumhMHfVgJ1BVvHIXUfjLIv7bqrMksfOgtzYL+/pjCIz6aRP
   8FQpYgCrRH689UDGM4i9eLDOFvE3USSVUGpBySTDjsFh3bwk8hY7GeGyl
   U/Yz04nqwZGm+oDlNqu7wjz/xFvTMLby2aAUS56VxCTNUjJ1rMRo/MDN1
   w0SheQPq7vjz4BKmqc5BViUZnhgoDaJ/QlIyQRiN2OOFuj/xG9o7VanwT
   Hzc1oUrjFEvi7YIhq8leG+y/LTq2RCL1MlgYAuEUEqHUuu9+W6JthaycD
   w==;
X-CSE-ConnectionGUID: vekr3QAMQjSvTcphrzfZCQ==
X-CSE-MsgGUID: OpvPiOh4S7eMYEwSV89QZg==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="15070890"
X-IronPort-AV: E=Sophos;i="6.08,149,1712646000"; 
   d="scan'208";a="15070890"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2024 20:15:44 -0700
X-CSE-ConnectionGUID: cQ+7imqTT6uUcNGzDg+x0w==
X-CSE-MsgGUID: BUIxSf/qTH2lCWUpP4Z4kQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,149,1712646000"; 
   d="scan'208";a="29330667"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 09 May 2024 20:15:42 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s5GjU-0005fD-1X;
	Fri, 10 May 2024 03:15:40 +0000
Date: Fri, 10 May 2024 11:15:29 +0800
From: kernel test robot <lkp@intel.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>,
 Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org
Subject: [wireless-next:main] BUILD SUCCESS
 83127ecada257e27f4740dbca9644dd0e838bc36
Message-ID: <202405101127.xZYV2CaX-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: 83127ecada257e27f4740dbca9644dd0e838bc36  Merge tag 'wireless-next-2024-05-08' of git://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next

elapsed time: 1447m

configs tested: 237
configs skipped: 7

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                      axs103_smp_defconfig   gcc  
arc                                 defconfig   gcc  
arc                   randconfig-001-20240509   gcc  
arc                   randconfig-001-20240510   gcc  
arc                   randconfig-002-20240509   gcc  
arc                   randconfig-002-20240510   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                     am200epdkit_defconfig   gcc  
arm                                 defconfig   clang
arm                          moxart_defconfig   gcc  
arm                   randconfig-001-20240509   gcc  
arm                   randconfig-001-20240510   gcc  
arm                   randconfig-002-20240510   clang
arm                   randconfig-003-20240510   gcc  
arm                   randconfig-004-20240510   gcc  
arm                         s3c6400_defconfig   gcc  
arm                       spear13xx_defconfig   gcc  
arm                         vf610m4_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240510   clang
arm64                 randconfig-002-20240510   gcc  
arm64                 randconfig-003-20240509   gcc  
arm64                 randconfig-003-20240510   clang
arm64                 randconfig-004-20240510   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240509   gcc  
csky                  randconfig-001-20240510   gcc  
csky                  randconfig-002-20240509   gcc  
csky                  randconfig-002-20240510   gcc  
hexagon                           allnoconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240510   clang
hexagon               randconfig-002-20240510   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240509   gcc  
i386         buildonly-randconfig-001-20240510   clang
i386         buildonly-randconfig-002-20240509   gcc  
i386         buildonly-randconfig-002-20240510   gcc  
i386         buildonly-randconfig-003-20240510   clang
i386         buildonly-randconfig-004-20240510   clang
i386         buildonly-randconfig-005-20240509   gcc  
i386         buildonly-randconfig-005-20240510   clang
i386         buildonly-randconfig-006-20240509   gcc  
i386         buildonly-randconfig-006-20240510   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240510   clang
i386                  randconfig-002-20240510   clang
i386                  randconfig-003-20240510   gcc  
i386                  randconfig-004-20240509   gcc  
i386                  randconfig-004-20240510   gcc  
i386                  randconfig-005-20240510   clang
i386                  randconfig-006-20240509   gcc  
i386                  randconfig-006-20240510   clang
i386                  randconfig-011-20240510   clang
i386                  randconfig-012-20240509   gcc  
i386                  randconfig-012-20240510   clang
i386                  randconfig-013-20240510   gcc  
i386                  randconfig-014-20240509   gcc  
i386                  randconfig-014-20240510   clang
i386                  randconfig-015-20240509   gcc  
i386                  randconfig-015-20240510   gcc  
i386                  randconfig-016-20240509   gcc  
i386                  randconfig-016-20240510   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240509   gcc  
loongarch             randconfig-001-20240510   gcc  
loongarch             randconfig-002-20240509   gcc  
loongarch             randconfig-002-20240510   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                       m5208evb_defconfig   gcc  
m68k                          multi_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
microblaze                      mmu_defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                  decstation_64_defconfig   gcc  
mips                 decstation_r4k_defconfig   gcc  
mips                           ip27_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240509   gcc  
nios2                 randconfig-001-20240510   gcc  
nios2                 randconfig-002-20240509   gcc  
nios2                 randconfig-002-20240510   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240509   gcc  
parisc                randconfig-001-20240510   gcc  
parisc                randconfig-002-20240509   gcc  
parisc                randconfig-002-20240510   gcc  
parisc64                         alldefconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                     ep8248e_defconfig   gcc  
powerpc               randconfig-001-20240510   gcc  
powerpc               randconfig-002-20240510   gcc  
powerpc               randconfig-003-20240510   clang
powerpc                  storcenter_defconfig   gcc  
powerpc                         wii_defconfig   gcc  
powerpc64             randconfig-001-20240510   clang
powerpc64             randconfig-002-20240509   gcc  
powerpc64             randconfig-002-20240510   clang
powerpc64             randconfig-003-20240510   clang
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240509   gcc  
riscv                 randconfig-001-20240510   clang
riscv                 randconfig-002-20240509   gcc  
riscv                 randconfig-002-20240510   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240509   gcc  
s390                  randconfig-001-20240510   gcc  
s390                  randconfig-002-20240509   gcc  
s390                  randconfig-002-20240510   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                        apsh4ad0a_defconfig   gcc  
sh                                  defconfig   gcc  
sh                        edosk7705_defconfig   gcc  
sh                     magicpanelr2_defconfig   gcc  
sh                    randconfig-001-20240509   gcc  
sh                    randconfig-001-20240510   gcc  
sh                    randconfig-002-20240509   gcc  
sh                    randconfig-002-20240510   gcc  
sh                          urquell_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc                       sparc32_defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240509   gcc  
sparc64               randconfig-001-20240510   gcc  
sparc64               randconfig-002-20240509   gcc  
sparc64               randconfig-002-20240510   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240510   gcc  
um                    randconfig-002-20240509   gcc  
um                    randconfig-002-20240510   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240509   clang
x86_64       buildonly-randconfig-001-20240510   gcc  
x86_64       buildonly-randconfig-002-20240509   clang
x86_64       buildonly-randconfig-002-20240510   clang
x86_64       buildonly-randconfig-003-20240510   gcc  
x86_64       buildonly-randconfig-004-20240510   clang
x86_64       buildonly-randconfig-005-20240510   gcc  
x86_64       buildonly-randconfig-006-20240510   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240510   gcc  
x86_64                randconfig-002-20240509   clang
x86_64                randconfig-002-20240510   clang
x86_64                randconfig-003-20240510   clang
x86_64                randconfig-004-20240510   gcc  
x86_64                randconfig-005-20240509   clang
x86_64                randconfig-005-20240510   gcc  
x86_64                randconfig-006-20240509   clang
x86_64                randconfig-006-20240510   gcc  
x86_64                randconfig-011-20240509   clang
x86_64                randconfig-011-20240510   clang
x86_64                randconfig-012-20240509   clang
x86_64                randconfig-012-20240510   clang
x86_64                randconfig-013-20240510   clang
x86_64                randconfig-014-20240509   clang
x86_64                randconfig-014-20240510   clang
x86_64                randconfig-015-20240509   clang
x86_64                randconfig-015-20240510   clang
x86_64                randconfig-016-20240510   gcc  
x86_64                randconfig-071-20240509   clang
x86_64                randconfig-071-20240510   clang
x86_64                randconfig-072-20240509   clang
x86_64                randconfig-072-20240510   clang
x86_64                randconfig-073-20240509   clang
x86_64                randconfig-073-20240510   clang
x86_64                randconfig-074-20240509   clang
x86_64                randconfig-074-20240510   gcc  
x86_64                randconfig-075-20240509   clang
x86_64                randconfig-075-20240510   clang
x86_64                randconfig-076-20240510   clang
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                       common_defconfig   gcc  
xtensa                randconfig-001-20240509   gcc  
xtensa                randconfig-001-20240510   gcc  
xtensa                randconfig-002-20240509   gcc  
xtensa                randconfig-002-20240510   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

