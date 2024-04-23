Return-Path: <linux-wireless+bounces-6703-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 971D98ADCC2
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Apr 2024 06:19:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5CD31C21A96
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Apr 2024 04:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 603CC1946B;
	Tue, 23 Apr 2024 04:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i5Jiurio"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6D318AED
	for <linux-wireless@vger.kernel.org>; Tue, 23 Apr 2024 04:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713845944; cv=none; b=ZqXcaZSGoi3N80PxrUCWv1g5IaS1HpbcY0SV5/pPlbvFzxYT5CvxDk78kspH0T2MhL6biHZ6H0+dkEgXDaYX3G+GirwC+ai9jwsf3+oj0fMHhTjUGCEA7ByVsQXAgIUbIRnrnji5RmPfa0rWTo4C8/FvvOLsTllgvDnjJ/EOjtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713845944; c=relaxed/simple;
	bh=BHLCfTcjgzZ/EqnIj7CvXMCALDbad+EKKCgIonXGfAY=;
	h=Date:From:To:Cc:Subject:Message-ID; b=jvNdrRE2l8xNKaWmzqQYvtaKqpwc7IrLGE2A/A9M2nQiXAOTsdpie0ZY5sYSAsmGJOXyUU7hTBjIC08N+JtmrZ+Kfa8iHVRe0cODf4ufVd5M7a2MsTBM1Mj9uuJatMjxJi8UJZK4lTsydaum0vEN6QW3hNhn0292FI3c04xYOqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i5Jiurio; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713845943; x=1745381943;
  h=date:from:to:cc:subject:message-id;
  bh=BHLCfTcjgzZ/EqnIj7CvXMCALDbad+EKKCgIonXGfAY=;
  b=i5JiurioitAFUpvtnZxoiaZ8IKqls5DKd7xu/8bKKrbZSGL+zblKYWBj
   75fIO9e9+SoF5u0X22bAwtyhZdSF5W80uj06hdPDw4a4Nb7OwHzsUZKvo
   ePBIJqihWEHstm31RINGAxvZzBDyQ/FX7jIcM/mbxNtQqPu0FBMUc8GV5
   z+t+197LOHcP4J0QVWKYqvhekTfpUjUlYoNxouuU5IMdBos4E3GCW6KVk
   xJb9BI0Sci/BIrgdG2/g3/Xvk9TSR6eskMGmlPAUplran3mWzDr1pWggb
   GpmrGQRGk3UNVCL7dddtCdGq/QDq6bg2Qrh7nPF6Ro1Gvi/jvlqFLR2PO
   w==;
X-CSE-ConnectionGUID: Ged0cfJ2SS6B+BN03r8UzQ==
X-CSE-MsgGUID: DT7wvgGZQ+icHPmq4YjSAg==
X-IronPort-AV: E=McAfee;i="6600,9927,11052"; a="9287426"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="9287426"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 21:19:03 -0700
X-CSE-ConnectionGUID: CEIhc8qZQO2Vmx1JtAVH8Q==
X-CSE-MsgGUID: Y6ga8YuoQbuH/ycBaW57pQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="28748982"
Received: from lkp-server01.sh.intel.com (HELO 01437695816f) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 22 Apr 2024 21:19:00 -0700
Received: from kbuild by 01437695816f with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rz7cQ-0000TE-1E;
	Tue, 23 Apr 2024 04:18:58 +0000
Date: Tue, 23 Apr 2024 12:18:42 +0800
From: kernel test robot <lkp@intel.com>
To: Johannes Berg <johannes.berg@intel.com>
Cc: Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org
Subject: [wireless:for-next] BUILD SUCCESS
 91112fc6212a9be6f3be636d885df9c17395e1a4
Message-ID: <202404231239.8OLILkAi-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git for-next
branch HEAD: 91112fc6212a9be6f3be636d885df9c17395e1a4  wifi: iwlwifi: mvm: fix link ID management

elapsed time: 1223m

configs tested: 194
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                        nsimosci_defconfig   gcc  
arc                   randconfig-001-20240422   gcc  
arc                   randconfig-002-20240422   gcc  
arm                              alldefconfig   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                       aspeed_g5_defconfig   gcc  
arm                                 defconfig   clang
arm                          ixp4xx_defconfig   gcc  
arm                        mvebu_v5_defconfig   gcc  
arm                          pxa910_defconfig   gcc  
arm                   randconfig-001-20240422   gcc  
arm                   randconfig-002-20240422   gcc  
arm                   randconfig-004-20240422   gcc  
arm                           sunxi_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   clang
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240422   gcc  
arm64                 randconfig-003-20240422   gcc  
arm64                 randconfig-004-20240422   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240422   gcc  
csky                  randconfig-002-20240422   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240422   clang
i386         buildonly-randconfig-002-20240422   gcc  
i386         buildonly-randconfig-003-20240422   clang
i386         buildonly-randconfig-003-20240423   gcc  
i386         buildonly-randconfig-004-20240422   gcc  
i386         buildonly-randconfig-005-20240422   gcc  
i386         buildonly-randconfig-006-20240422   clang
i386         buildonly-randconfig-006-20240423   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240422   clang
i386                  randconfig-001-20240423   gcc  
i386                  randconfig-002-20240422   clang
i386                  randconfig-002-20240423   gcc  
i386                  randconfig-003-20240422   gcc  
i386                  randconfig-004-20240422   clang
i386                  randconfig-004-20240423   gcc  
i386                  randconfig-005-20240422   gcc  
i386                  randconfig-006-20240422   gcc  
i386                  randconfig-011-20240422   clang
i386                  randconfig-011-20240423   gcc  
i386                  randconfig-012-20240422   clang
i386                  randconfig-013-20240422   clang
i386                  randconfig-014-20240422   clang
i386                  randconfig-014-20240423   gcc  
i386                  randconfig-015-20240422   clang
i386                  randconfig-015-20240423   gcc  
i386                  randconfig-016-20240422   gcc  
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240422   gcc  
loongarch             randconfig-002-20240422   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
m68k                          multi_defconfig   gcc  
m68k                        mvme147_defconfig   gcc  
m68k                          sun3x_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                           ip28_defconfig   gcc  
mips                          malta_defconfig   gcc  
mips                      pic32mzda_defconfig   gcc  
mips                       rbtx49xx_defconfig   gcc  
nios2                            alldefconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240422   gcc  
nios2                 randconfig-002-20240422   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
openrisc                 simple_smp_defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                generic-64bit_defconfig   gcc  
parisc                randconfig-001-20240422   gcc  
parisc                randconfig-002-20240422   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                  iss476-smp_defconfig   gcc  
powerpc                         ps3_defconfig   gcc  
powerpc64             randconfig-001-20240422   gcc  
powerpc64             randconfig-002-20240422   gcc  
powerpc64             randconfig-003-20240422   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-002-20240422   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                ecovec24-romimage_defconfig   gcc  
sh                    randconfig-001-20240422   gcc  
sh                    randconfig-002-20240422   gcc  
sh                          rsk7201_defconfig   gcc  
sh                          rsk7264_defconfig   gcc  
sh                           se7780_defconfig   gcc  
sh                  sh7785lcr_32bit_defconfig   gcc  
sh                             shx3_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240422   gcc  
sparc64               randconfig-002-20240422   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240422   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240422   clang
x86_64       buildonly-randconfig-002-20240422   gcc  
x86_64       buildonly-randconfig-003-20240422   gcc  
x86_64       buildonly-randconfig-004-20240422   clang
x86_64       buildonly-randconfig-005-20240422   gcc  
x86_64       buildonly-randconfig-006-20240422   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240422   clang
x86_64                randconfig-002-20240422   gcc  
x86_64                randconfig-003-20240422   clang
x86_64                randconfig-004-20240422   gcc  
x86_64                randconfig-005-20240422   gcc  
x86_64                randconfig-006-20240422   clang
x86_64                randconfig-011-20240422   gcc  
x86_64                randconfig-012-20240422   clang
x86_64                randconfig-013-20240422   gcc  
x86_64                randconfig-014-20240422   clang
x86_64                randconfig-015-20240422   gcc  
x86_64                randconfig-016-20240422   gcc  
x86_64                randconfig-071-20240422   clang
x86_64                randconfig-072-20240422   gcc  
x86_64                randconfig-073-20240422   gcc  
x86_64                randconfig-074-20240422   gcc  
x86_64                randconfig-075-20240422   gcc  
x86_64                randconfig-076-20240422   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                       common_defconfig   gcc  
xtensa                  nommu_kc705_defconfig   gcc  
xtensa                randconfig-001-20240422   gcc  
xtensa                randconfig-002-20240422   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

