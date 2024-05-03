Return-Path: <linux-wireless+bounces-7151-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 263E98BB07B
	for <lists+linux-wireless@lfdr.de>; Fri,  3 May 2024 18:00:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD9482814D3
	for <lists+linux-wireless@lfdr.de>; Fri,  3 May 2024 16:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1C9726AF5;
	Fri,  3 May 2024 16:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Uc6l00+7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F9A26296
	for <linux-wireless@vger.kernel.org>; Fri,  3 May 2024 16:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714752048; cv=none; b=axYVMl6BJYnU6Ub4csXcxDo1678xUWp3mjNDfhygzfaOrF/NJhl9vnLrNuRw5bZgMcJkHB95K0S/itTiohgAJPne17zRFBe3x+UXn9KwO7PPT+UyVU4KMXIAMvOFmAS6ng/+jE3sQKjc22daP70iys7oIxj8A8UeiDGZJvxwCgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714752048; c=relaxed/simple;
	bh=0TSq29/OXnRAz2jfbFt7eT/c5fcF8PDoFrMBiz1oRCs=;
	h=Date:From:To:Cc:Subject:Message-ID; b=qaJLh2drCs/OUenAPMI3FmWZ4axG1+AuyuPKWWFqHYqCCjULCJ/Xy+cq50Y6A0Bi6414gd4L+YLDTgcrF7x/hSi3yswGDdCCqk2ERflFM8sJPNuYH/a7g7qqXK8ALdpipf5MieclNBfFn0+I7ld0CMTHR0l/ARcwvUaCGm89zoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Uc6l00+7; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714752047; x=1746288047;
  h=date:from:to:cc:subject:message-id;
  bh=0TSq29/OXnRAz2jfbFt7eT/c5fcF8PDoFrMBiz1oRCs=;
  b=Uc6l00+7kptJKsIuUmm3FyCFrGGymOoPnWwLcpqPYqXkQD/6rQ5rBMjE
   DP4QLpoRpkRGWBuQZAwBxyU7IGBY60/51xG+PTAV8iM173We0O+nd+C01
   KE6gyzBvip9Zep3oMRVE7Mgs3jpmWioq/T5h/hyd7Ud/S/s4YklPr2mFJ
   EUp6CdNFgz5ZjLv71/7BGL4rFN37nvPLAEVfvpYWHJMUebocmggd9flzw
   1yoTwP+gw0qfRrUps0rjCLNAsNEmaKl42HGYMCIVWuPd9c/7HvTeSpQt2
   WO3eUZAVlgbUduzJXJhD4CDSvF2lyuUWU3LICdskGFDGaJJjJRm59hKXX
   g==;
X-CSE-ConnectionGUID: m09XfGLfQYKEa1b7iYLRtw==
X-CSE-MsgGUID: u+sOSicoSPikjcrsUnJO9g==
X-IronPort-AV: E=McAfee;i="6600,9927,11063"; a="10725657"
X-IronPort-AV: E=Sophos;i="6.07,251,1708416000"; 
   d="scan'208";a="10725657"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2024 09:00:40 -0700
X-CSE-ConnectionGUID: Zcmaap0zQTCZx3TeY2GDtg==
X-CSE-MsgGUID: cCcCyRakSQS92HO1lsv6Mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,251,1708416000"; 
   d="scan'208";a="27997969"
Received: from lkp-server01.sh.intel.com (HELO e434dd42e5a1) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 03 May 2024 09:00:39 -0700
Received: from kbuild by e434dd42e5a1 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s2vKu-000Bpk-15;
	Fri, 03 May 2024 16:00:36 +0000
Date: Sat, 04 May 2024 00:00:02 +0800
From: kernel test robot <lkp@intel.com>
To: Kalle Valo <kvalo@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>,
 linux-wireless@vger.kernel.org
Subject: [wireless-next:pending] BUILD SUCCESS
 24849d329eef223f70b4d6296fb01de8f2564e68
Message-ID: <202405040000.BrBNP7Uu-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git pending
branch HEAD: 24849d329eef223f70b4d6296fb01de8f2564e68  Merge tag 'mt76-for-kvalo-2024-05-02' of https://github.com/nbd168/wireless into pending

elapsed time: 1454m

configs tested: 127
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
arc                   randconfig-001-20240503   gcc  
arc                   randconfig-002-20240503   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                   randconfig-001-20240503   clang
arm                   randconfig-002-20240503   clang
arm                   randconfig-003-20240503   clang
arm                   randconfig-004-20240503   gcc  
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240503   clang
arm64                 randconfig-002-20240503   gcc  
arm64                 randconfig-003-20240503   clang
arm64                 randconfig-004-20240503   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240503   gcc  
csky                  randconfig-002-20240503   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240503   clang
hexagon               randconfig-002-20240503   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240503   clang
i386         buildonly-randconfig-002-20240503   clang
i386         buildonly-randconfig-003-20240503   gcc  
i386         buildonly-randconfig-004-20240503   gcc  
i386         buildonly-randconfig-005-20240503   gcc  
i386         buildonly-randconfig-006-20240503   clang
i386                                defconfig   clang
i386                  randconfig-001-20240503   gcc  
i386                  randconfig-002-20240503   clang
i386                  randconfig-003-20240503   clang
i386                  randconfig-004-20240503   gcc  
i386                  randconfig-005-20240503   clang
i386                  randconfig-006-20240503   clang
i386                  randconfig-011-20240503   clang
i386                  randconfig-012-20240503   gcc  
i386                  randconfig-013-20240503   gcc  
i386                  randconfig-014-20240503   gcc  
i386                  randconfig-015-20240503   gcc  
i386                  randconfig-016-20240503   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240503   gcc  
loongarch             randconfig-002-20240503   gcc  
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
nios2                 randconfig-001-20240503   gcc  
nios2                 randconfig-002-20240503   gcc  
openrisc                          allnoconfig   gcc  
openrisc                            defconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240503   gcc  
parisc                randconfig-002-20240503   gcc  
parisc64                            defconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc               randconfig-001-20240503   clang
powerpc               randconfig-002-20240503   clang
powerpc               randconfig-003-20240503   gcc  
powerpc64             randconfig-001-20240503   clang
powerpc64             randconfig-002-20240503   clang
powerpc64             randconfig-003-20240503   clang
riscv                             allnoconfig   gcc  
riscv                               defconfig   clang
riscv                 randconfig-001-20240503   gcc  
riscv                 randconfig-002-20240503   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240503   gcc  
s390                  randconfig-002-20240503   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240503   gcc  
sh                    randconfig-002-20240503   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240503   gcc  
sparc64               randconfig-002-20240503   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240503   clang
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64                              defconfig   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

