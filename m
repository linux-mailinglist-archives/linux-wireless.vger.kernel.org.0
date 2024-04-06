Return-Path: <linux-wireless+bounces-5934-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5ABF89A8BB
	for <lists+linux-wireless@lfdr.de>; Sat,  6 Apr 2024 05:53:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBA0D1C20BDE
	for <lists+linux-wireless@lfdr.de>; Sat,  6 Apr 2024 03:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B07217758;
	Sat,  6 Apr 2024 03:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RP80zMdb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165854C9F
	for <linux-wireless@vger.kernel.org>; Sat,  6 Apr 2024 03:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712375601; cv=none; b=CCbao3qdDI4GFkvgnaAdYSeSnyk5PV26T/gG8eg2uyCpT94+08uAqjjdjcdIiotFbgI7Ao8zMtEkx10zALIf9ChkRdZahys71HFZ93IpGCnRynmReYqOoV6t+soaNyWxZ/jOO3SEo95+swTkckK6ZhQj3CQSE7NVubONMuCgB90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712375601; c=relaxed/simple;
	bh=pxhbHklcmyaZbnz4cwuMFoLCkROEoqt0RN2jrOjzIsE=;
	h=Date:From:To:Cc:Subject:Message-ID; b=i9rZMdIflIDcXWO21G27yIH2EOHfLbeUZIMjV38YyGtWlX1TWj6hlVMVtA0QJguCmVFEY/YPiYvdY22xjWbr4EwDHNkF8Du0sotjHo1D14fWc5yBcRqpR+cwj1BUs/9eLwZiI8Uk7jkdOVd5GIhQOzAR4U+HYE15KiX2jZZ9lQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RP80zMdb; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712375599; x=1743911599;
  h=date:from:to:cc:subject:message-id;
  bh=pxhbHklcmyaZbnz4cwuMFoLCkROEoqt0RN2jrOjzIsE=;
  b=RP80zMdb2vvJJTnaVJJMpq0gGHuZ+ynh6+nqFDScR1u9BPl8LwOheb/Y
   7BIg2TuNGl2214kMmkyQg5Lu9F+8opoq0MzTobewTKc6DnjPv7kZqFwHf
   2hdkxK8JZQQNMeyXqEaK2PRTXAubKDeEkcsy+kvE4sgN6AnfY5Sb7g4HJ
   kOLTDCR3j+A1fs/SsFYIZ/M7ILGdS2BPTwyY1/+IOLqaAMn5p2NWGo53/
   C/EnVRDTo8hl7YhqRRUcXwKE+MnjP6xIFt5BEJ+sC8urQhOchcZibQLUE
   wv+PAPSfueqacE343+tgCd+qvlHvc4bKlXYQ7uUbole87skuU+KR2y9uM
   g==;
X-CSE-ConnectionGUID: iLIY2qdjRzu4wY3Rg60yfQ==
X-CSE-MsgGUID: 3zitWXNVSxiLFsFWjlMtjA==
X-IronPort-AV: E=McAfee;i="6600,9927,11035"; a="7575706"
X-IronPort-AV: E=Sophos;i="6.07,182,1708416000"; 
   d="scan'208";a="7575706"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 20:53:19 -0700
X-CSE-ConnectionGUID: JmTZFjdITViig8uptrKY9g==
X-CSE-MsgGUID: gcffAoqaTA+zRq03B3dJIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,182,1708416000"; 
   d="scan'208";a="19266505"
Received: from lkp-server01.sh.intel.com (HELO e61807b1d151) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 05 Apr 2024 20:53:17 -0700
Received: from kbuild by e61807b1d151 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rsx7C-000348-2Q;
	Sat, 06 Apr 2024 03:53:14 +0000
Date: Sat, 06 Apr 2024 11:52:42 +0800
From: kernel test robot <lkp@intel.com>
To: Kalle Valo <kvalo@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>,
 linux-wireless@vger.kernel.org
Subject: [wireless-next:main] BUILD SUCCESS
 132c2a1cf76d161d3772826cad3cf321b8c878ce
Message-ID: <202404061140.7P0ZjyAI-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: 132c2a1cf76d161d3772826cad3cf321b8c878ce  Merge tag 'rtw-next-2024-04-04' of https://github.com/pkshih/rtw

elapsed time: 1090m

configs tested: 133
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
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                        multi_v5_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                            allyesconfig   clang
arm64                               defconfig   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240405   gcc  
i386         buildonly-randconfig-001-20240406   clang
i386         buildonly-randconfig-002-20240405   gcc  
i386         buildonly-randconfig-002-20240406   clang
i386         buildonly-randconfig-003-20240405   clang
i386         buildonly-randconfig-004-20240405   gcc  
i386         buildonly-randconfig-004-20240406   clang
i386         buildonly-randconfig-005-20240405   clang
i386         buildonly-randconfig-006-20240405   clang
i386         buildonly-randconfig-006-20240406   clang
i386                                defconfig   clang
i386                  randconfig-001-20240405   clang
i386                  randconfig-001-20240406   clang
i386                  randconfig-002-20240405   gcc  
i386                  randconfig-003-20240405   clang
i386                  randconfig-003-20240406   clang
i386                  randconfig-004-20240405   clang
i386                  randconfig-004-20240406   clang
i386                  randconfig-005-20240405   clang
i386                  randconfig-005-20240406   clang
i386                  randconfig-006-20240405   gcc  
i386                  randconfig-011-20240405   clang
i386                  randconfig-011-20240406   clang
i386                  randconfig-012-20240405   gcc  
i386                  randconfig-012-20240406   clang
i386                  randconfig-013-20240405   gcc  
i386                  randconfig-013-20240406   clang
i386                  randconfig-014-20240405   gcc  
i386                  randconfig-015-20240405   gcc  
i386                  randconfig-015-20240406   clang
i386                  randconfig-016-20240405   clang
i386                  randconfig-016-20240406   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
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
mips                           ip27_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                    adder875_defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                               j2_defconfig   gcc  
sh                      rts7751r2d1_defconfig   gcc  
sh                           se7343_defconfig   gcc  
sh                             sh03_defconfig   gcc  
sh                            titan_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-002-20240406   gcc  
x86_64       buildonly-randconfig-004-20240406   gcc  
x86_64       buildonly-randconfig-005-20240406   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240406   gcc  
x86_64                randconfig-003-20240406   gcc  
x86_64                randconfig-011-20240406   gcc  
x86_64                randconfig-014-20240406   gcc  
x86_64                randconfig-015-20240406   gcc  
x86_64                randconfig-076-20240406   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

