Return-Path: <linux-wireless+bounces-8379-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D0048D733E
	for <lists+linux-wireless@lfdr.de>; Sun,  2 Jun 2024 05:34:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F27AA1F21673
	for <lists+linux-wireless@lfdr.de>; Sun,  2 Jun 2024 03:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D72AE53AC;
	Sun,  2 Jun 2024 03:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TSRS1vhW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A4580B
	for <linux-wireless@vger.kernel.org>; Sun,  2 Jun 2024 03:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717299278; cv=none; b=HwUCmworOErkjogYyMu26zM9RAAs0Nz4bO3Uacsyc8ynurE7C623lLEaREzUB+Z10jSZKvExC7pswjpGRoMPr4u7TnCXh1U4izYoyqRqQoxOtH+rfz6jSwK5q0pVQ4mueDy+vzWvVVzMUqt6/UHLSEbO59EC/r8rx51BlaXeq7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717299278; c=relaxed/simple;
	bh=XW83aSXhnBPqEw5G38Jgp9+F3VHaeudVEwRCEg/UGgI=;
	h=Date:From:To:Cc:Subject:Message-ID; b=te/lqodX4ipdbAhP6aHGWHN2m/N17h6eisksgFN+eAa+gQ25WaLaHSaCFK52Hg/+zlnn/HYHZJSKWobS1ApbaVTZVKHf/4rDnZDVg0Zj9jvfCUPOzDAnwGVVVK0Ei5k2Z1kBORr/KwDn8WYgys7El7CHd1eH/D6M5mStbqHxzxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TSRS1vhW; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717299276; x=1748835276;
  h=date:from:to:cc:subject:message-id;
  bh=XW83aSXhnBPqEw5G38Jgp9+F3VHaeudVEwRCEg/UGgI=;
  b=TSRS1vhWvRHhD7jsrAExgPDxnot2DIszfdzaC1KqPI2b9tOo8o63MxLz
   Hun5yfdAsl3g2Tek7xp9Q2GzV5Fup+kqqGVVbBHe1xgOdf5s8/uLV0r0N
   9jf29ULLU2Z5OzNzmiUo+Jra5zzPe/bbd2Razy+LXHM6iCLJJMwYAXKUp
   5I/jUdmxPzyk6ksZWJEbAR1vVtOvcrh9D+ukK/MlalZToANi19/HKlTwC
   +RxfwUg78XB2uPL+/tkNWqqDVnHWC3bf+ualubaU+QPkex95EcRmGwdKT
   bnM+sr++B3DjjBjoiezA8YMIeotU/XZed7cKMpxLAIKq3/SUF/6RRimO/
   A==;
X-CSE-ConnectionGUID: 7BVkdrRtQgS36/KdmRKIgQ==
X-CSE-MsgGUID: bwBOw0bwTT2+/mlwDTi/2g==
X-IronPort-AV: E=McAfee;i="6600,9927,11090"; a="13759871"
X-IronPort-AV: E=Sophos;i="6.08,208,1712646000"; 
   d="scan'208";a="13759871"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2024 20:34:36 -0700
X-CSE-ConnectionGUID: oFf+bqOVRdelN9PGg0IVDg==
X-CSE-MsgGUID: HQh6hYhaSjSYaCZ2+L+cTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,208,1712646000"; 
   d="scan'208";a="67723640"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 01 Jun 2024 20:34:34 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sDbzM-000Jdj-0h;
	Sun, 02 Jun 2024 03:34:32 +0000
Date: Sun, 02 Jun 2024 11:33:49 +0800
From: kernel test robot <lkp@intel.com>
To: Kalle Valo <kvalo@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>,
 linux-wireless@vger.kernel.org
Subject: [wireless-next:main] BUILD SUCCESS
 5bcd9a0a59953b5ff55ac226f903397319bf7f40
Message-ID: <202406021146.XzX2SeRt-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: 5bcd9a0a59953b5ff55ac226f903397319bf7f40  wifi: brcm80211: remove unused structs

elapsed time: 1033m

configs tested: 200
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
arc                   randconfig-001-20240601   gcc  
arc                   randconfig-001-20240602   gcc  
arc                   randconfig-002-20240601   gcc  
arc                   randconfig-002-20240602   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                   randconfig-001-20240601   clang
arm                   randconfig-002-20240601   clang
arm                   randconfig-003-20240601   gcc  
arm                   randconfig-003-20240602   gcc  
arm                   randconfig-004-20240601   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240601   gcc  
arm64                 randconfig-002-20240601   clang
arm64                 randconfig-002-20240602   gcc  
arm64                 randconfig-003-20240601   clang
arm64                 randconfig-004-20240601   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240601   gcc  
csky                  randconfig-001-20240602   gcc  
csky                  randconfig-002-20240601   gcc  
csky                  randconfig-002-20240602   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240601   clang
hexagon               randconfig-002-20240601   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240601   clang
i386         buildonly-randconfig-002-20240601   gcc  
i386         buildonly-randconfig-003-20240601   gcc  
i386         buildonly-randconfig-004-20240601   gcc  
i386         buildonly-randconfig-005-20240601   gcc  
i386         buildonly-randconfig-006-20240601   clang
i386                                defconfig   clang
i386                  randconfig-001-20240601   clang
i386                  randconfig-002-20240601   gcc  
i386                  randconfig-003-20240601   clang
i386                  randconfig-004-20240601   gcc  
i386                  randconfig-005-20240601   clang
i386                  randconfig-006-20240601   gcc  
i386                  randconfig-011-20240601   gcc  
i386                  randconfig-012-20240601   gcc  
i386                  randconfig-013-20240601   gcc  
i386                  randconfig-014-20240601   gcc  
i386                  randconfig-015-20240601   clang
i386                  randconfig-016-20240601   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240601   gcc  
loongarch             randconfig-001-20240602   gcc  
loongarch             randconfig-002-20240601   gcc  
loongarch             randconfig-002-20240602   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240601   gcc  
nios2                 randconfig-001-20240602   gcc  
nios2                 randconfig-002-20240601   gcc  
nios2                 randconfig-002-20240602   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240601   gcc  
parisc                randconfig-001-20240602   gcc  
parisc                randconfig-002-20240601   gcc  
parisc                randconfig-002-20240602   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc               randconfig-001-20240601   gcc  
powerpc               randconfig-002-20240601   gcc  
powerpc               randconfig-002-20240602   gcc  
powerpc               randconfig-003-20240601   gcc  
powerpc64             randconfig-001-20240601   clang
powerpc64             randconfig-002-20240601   clang
powerpc64             randconfig-002-20240602   gcc  
powerpc64             randconfig-003-20240601   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240601   clang
riscv                 randconfig-002-20240601   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240601   gcc  
s390                  randconfig-001-20240602   gcc  
s390                  randconfig-002-20240601   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240601   gcc  
sh                    randconfig-001-20240602   gcc  
sh                    randconfig-002-20240601   gcc  
sh                    randconfig-002-20240602   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240601   gcc  
sparc64               randconfig-001-20240602   gcc  
sparc64               randconfig-002-20240601   gcc  
sparc64               randconfig-002-20240602   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240601   gcc  
um                    randconfig-001-20240602   gcc  
um                    randconfig-002-20240601   clang
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240601   clang
x86_64       buildonly-randconfig-002-20240601   clang
x86_64       buildonly-randconfig-002-20240602   clang
x86_64       buildonly-randconfig-003-20240601   gcc  
x86_64       buildonly-randconfig-003-20240602   clang
x86_64       buildonly-randconfig-004-20240601   gcc  
x86_64       buildonly-randconfig-005-20240601   clang
x86_64       buildonly-randconfig-005-20240602   clang
x86_64       buildonly-randconfig-006-20240601   gcc  
x86_64       buildonly-randconfig-006-20240602   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240601   gcc  
x86_64                randconfig-002-20240601   clang
x86_64                randconfig-002-20240602   clang
x86_64                randconfig-003-20240601   clang
x86_64                randconfig-003-20240602   clang
x86_64                randconfig-004-20240601   clang
x86_64                randconfig-005-20240601   gcc  
x86_64                randconfig-005-20240602   clang
x86_64                randconfig-006-20240601   clang
x86_64                randconfig-006-20240602   clang
x86_64                randconfig-011-20240601   clang
x86_64                randconfig-012-20240601   clang
x86_64                randconfig-012-20240602   clang
x86_64                randconfig-013-20240601   clang
x86_64                randconfig-013-20240602   clang
x86_64                randconfig-014-20240601   gcc  
x86_64                randconfig-015-20240601   gcc  
x86_64                randconfig-015-20240602   clang
x86_64                randconfig-016-20240601   gcc  
x86_64                randconfig-071-20240601   clang
x86_64                randconfig-072-20240601   gcc  
x86_64                randconfig-072-20240602   clang
x86_64                randconfig-073-20240601   clang
x86_64                randconfig-074-20240601   gcc  
x86_64                randconfig-074-20240602   clang
x86_64                randconfig-075-20240601   clang
x86_64                randconfig-075-20240602   clang
x86_64                randconfig-076-20240601   gcc  
x86_64                randconfig-076-20240602   clang
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240601   gcc  
xtensa                randconfig-001-20240602   gcc  
xtensa                randconfig-002-20240601   gcc  
xtensa                randconfig-002-20240602   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

