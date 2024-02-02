Return-Path: <linux-wireless+bounces-3008-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEB99846E78
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Feb 2024 11:59:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66B9C296664
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Feb 2024 10:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF80813D4EA;
	Fri,  2 Feb 2024 10:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jjuEqin5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A20168B7
	for <linux-wireless@vger.kernel.org>; Fri,  2 Feb 2024 10:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706871463; cv=none; b=Y7mPHHURHjB1lDcktvwwHexM0HTWkv4Qw9ixKVqDGPav/V9vpsTDd5tfxfwHTpNHjexy/c4ILo2cCl3ElCrriBev4uca6vfl+XgfWOYtATotCeTSWJkRUt1m2Puzw7HR+7UW21rd9PNuAHHm+W2Cv85dqhLER1Whqjg0GxP4Y/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706871463; c=relaxed/simple;
	bh=1szRTCgSErZoa3CPd2TaAOVEkDXJ/yed+UeRgdTMBpM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=F77ZnuuZBQpqGflOfQmCFHEVflo8ta0E14Vcu40tlUhmq13oGlH3+edyiJlDzLDDrUYxTGOv6fffOM94Ws5wsTimwkyQ2M5hsCX4WlGGtCTZtYQGfJnvRCbNzv69LKHXOLd84R3o3tX10C+ig8tdgPb5cP/q/RuWZfopwFb1QIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=fail smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jjuEqin5; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706871462; x=1738407462;
  h=date:from:to:cc:subject:message-id;
  bh=1szRTCgSErZoa3CPd2TaAOVEkDXJ/yed+UeRgdTMBpM=;
  b=jjuEqin5mwbuYKCVpw6/ya74Go+/IcCtO7CsCpnN2z/pWl2xCT8+ZxoX
   MV7vpMauny1ylngUyqfElav175DGn+8EYhi99MaCUXljb+7IEqQ7Tolwe
   C4DtuM63PBlHuq+3cVs8NaM6dFITcWIVJfvMDqt+lkjffepeZVZAR+l5X
   ZZDpff4rPp6XpESN0HlF8vIusvs9CzRs7hS6is4qa1SYvMwnAqkMoF2m/
   OoIj7v3KpEFJpKVTFDOzc1mDLfgP9SCVXNyM/JqX5DGCPLsWzNAKU5bLS
   YIKwiVLaTdj1PDE1sZ0Kgdlh8Kz8CWbgoNPB53CAEf/4fpWAoGN8XHe7Z
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="11503865"
X-IronPort-AV: E=Sophos;i="6.05,237,1701158400"; 
   d="scan'208";a="11503865"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 02:57:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,237,1701158400"; 
   d="scan'208";a="4802658"
Received: from lkp-server02.sh.intel.com (HELO 59f4f4cd5935) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 02 Feb 2024 02:57:40 -0800
Received: from kbuild by 59f4f4cd5935 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rVrEn-0003nO-0T;
	Fri, 02 Feb 2024 10:57:37 +0000
Date: Fri, 02 Feb 2024 18:57:22 +0800
From: kernel test robot <lkp@intel.com>
To: Kalle Valo <kvalo@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>,
 linux-wireless@vger.kernel.org
Subject: [wireless-next:main] BUILD SUCCESS
 17903a283593c1dbf9da041f836004163ca30f7b
Message-ID: <202402021819.ydmLsEQB-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: 17903a283593c1dbf9da041f836004163ca30f7b  wifi: rtl8xxxu: fix error messages

elapsed time: 1464m

configs tested: 181
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
arc                   randconfig-001-20240202   gcc  
arc                   randconfig-002-20240202   gcc  
arc                    vdk_hs38_smp_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                        keystone_defconfig   gcc  
arm                   randconfig-001-20240202   gcc  
arm                   randconfig-002-20240202   gcc  
arm                   randconfig-003-20240202   gcc  
arm                   randconfig-004-20240202   clang
arm                           sama5_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240202   gcc  
arm64                 randconfig-002-20240202   clang
arm64                 randconfig-003-20240202   gcc  
arm64                 randconfig-004-20240202   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240202   gcc  
csky                  randconfig-002-20240202   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240202   clang
hexagon               randconfig-002-20240202   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240202   gcc  
i386         buildonly-randconfig-002-20240202   clang
i386         buildonly-randconfig-003-20240202   gcc  
i386         buildonly-randconfig-004-20240202   clang
i386         buildonly-randconfig-005-20240202   clang
i386         buildonly-randconfig-006-20240202   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240202   gcc  
i386                  randconfig-002-20240202   gcc  
i386                  randconfig-003-20240202   clang
i386                  randconfig-004-20240202   gcc  
i386                  randconfig-005-20240202   gcc  
i386                  randconfig-006-20240202   gcc  
i386                  randconfig-011-20240202   gcc  
i386                  randconfig-012-20240202   gcc  
i386                  randconfig-013-20240202   gcc  
i386                  randconfig-014-20240202   clang
i386                  randconfig-015-20240202   gcc  
i386                  randconfig-016-20240202   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240202   gcc  
loongarch             randconfig-002-20240202   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                           ip27_defconfig   gcc  
mips                      malta_kvm_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240202   gcc  
nios2                 randconfig-002-20240202   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240202   gcc  
parisc                randconfig-002-20240202   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc               randconfig-001-20240202   clang
powerpc               randconfig-002-20240202   clang
powerpc               randconfig-003-20240202   clang
powerpc                     tqm5200_defconfig   gcc  
powerpc64             randconfig-001-20240202   clang
powerpc64             randconfig-002-20240202   gcc  
powerpc64             randconfig-003-20240202   clang
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240202   gcc  
riscv                 randconfig-002-20240202   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240202   clang
s390                  randconfig-002-20240202   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                        edosk7705_defconfig   gcc  
sh                            hp6xx_defconfig   gcc  
sh                    randconfig-001-20240202   gcc  
sh                    randconfig-002-20240202   gcc  
sh                     sh7710voipgw_defconfig   gcc  
sh                   sh7724_generic_defconfig   gcc  
sh                  sh7785lcr_32bit_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240202   gcc  
sparc64               randconfig-002-20240202   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                    randconfig-001-20240202   clang
um                    randconfig-002-20240202   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240202   clang
x86_64       buildonly-randconfig-002-20240202   clang
x86_64       buildonly-randconfig-003-20240202   clang
x86_64       buildonly-randconfig-004-20240202   clang
x86_64       buildonly-randconfig-005-20240202   gcc  
x86_64       buildonly-randconfig-006-20240202   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240202   clang
x86_64                randconfig-002-20240202   clang
x86_64                randconfig-003-20240202   gcc  
x86_64                randconfig-004-20240202   gcc  
x86_64                randconfig-005-20240202   gcc  
x86_64                randconfig-006-20240202   gcc  
x86_64                randconfig-011-20240202   clang
x86_64                randconfig-012-20240202   clang
x86_64                randconfig-013-20240202   gcc  
x86_64                randconfig-014-20240202   clang
x86_64                randconfig-015-20240202   clang
x86_64                randconfig-016-20240202   clang
x86_64                randconfig-071-20240202   gcc  
x86_64                randconfig-072-20240202   clang
x86_64                randconfig-073-20240202   gcc  
x86_64                randconfig-074-20240202   clang
x86_64                randconfig-075-20240202   gcc  
x86_64                randconfig-076-20240202   clang
x86_64                          rhel-8.3-func   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                randconfig-001-20240202   gcc  
xtensa                randconfig-002-20240202   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

