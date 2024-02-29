Return-Path: <linux-wireless+bounces-4267-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69EBE86D5B8
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Feb 2024 22:09:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDA601F222AB
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Feb 2024 21:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 131F0150980;
	Thu, 29 Feb 2024 20:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PA5DvljV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE7D154BE3
	for <linux-wireless@vger.kernel.org>; Thu, 29 Feb 2024 20:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709240196; cv=none; b=XlkWHx2IPC9aTBPfojimmvkwbLGr+Py+8x3yVVyELB/o2vWVMRykQqG/O5/osBIL5NYuw81xZyHBHwSLVnFG6x2Tu7aK83J3qn+fwhEUO/DidDf/qs4vQNCbK8c+cC4ZOTT+2bkfx3ApuBZcdbGPLbudWJDO65ldZMEmN4QAyhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709240196; c=relaxed/simple;
	bh=I0qn1cVQ05fuufH059eDZOab2HWYV112hJBdFp58BHI=;
	h=Date:From:To:Cc:Subject:Message-ID; b=K9KArTl693fMxjKubKe7MD71/fjDh/A2VImAsfpluK8HSzdTRvFVsIULNGkoUVDjv0ifkElV8cwATaWLdB3h78dL7CtiAv7pswunaYXF5krEWRMnuyaX+uLlGzDrslvlJO/sKvo/VRS9WZRcf52G/7yyL2TCdgDBcljRMSGmXq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PA5DvljV; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709240194; x=1740776194;
  h=date:from:to:cc:subject:message-id;
  bh=I0qn1cVQ05fuufH059eDZOab2HWYV112hJBdFp58BHI=;
  b=PA5DvljVENHwcrACXy61jqQ7SzsQrOt+bBTI7b00Rt4VFXu/zfzSNY+h
   X+oHB2TwlbpVinbfa18Hu+cCk/39g2Xd6xfOnp2qxPcxgcC1lb2z6WVHM
   m/YhRQwTKEArlssOBcabjhovkoH5TNbOgP9ozQL0iRVoW/UyjYQxgqDjy
   +Yo7uNYFUOBguw/aEzdot2qO4XyRToGjlLsj6gb9apy7H20cbpt6UuLWQ
   GTTFWRRhLaBldbenDG4gMJZbfxOI6/fuMN5keAocB4+9L/yOFWn5J+319
   aJzbaOkE9olt5U/Y/gY2SLe18ZpOw0x64rzfxzSPmlGkl7xFjpwxb7bf2
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="14897146"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="14897146"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 12:56:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="12641223"
Received: from lkp-server02.sh.intel.com (HELO 3c78fa4d504c) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 29 Feb 2024 12:56:32 -0800
Received: from kbuild by 3c78fa4d504c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rfnS9-000DHf-2R;
	Thu, 29 Feb 2024 20:56:29 +0000
Date: Fri, 01 Mar 2024 04:55:57 +0800
From: kernel test robot <lkp@intel.com>
To: Johannes Berg <johannes.berg@intel.com>
Cc: Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org
Subject: [wireless-next:crosslink-csa] BUILD SUCCESS
 68254f26db2c9d6aad3ed9561306a42ac5cd12bd
Message-ID: <202403010453.DB5cxkUr-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git crosslink-csa
branch HEAD: 68254f26db2c9d6aad3ed9561306a42ac5cd12bd  wifi: mac80211: mlme: handle cross-link CSA

elapsed time: 727m

configs tested: 156
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
arc                   randconfig-001-20240229   gcc  
arc                   randconfig-002-20240229   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                                 defconfig   clang
arm                   randconfig-001-20240229   gcc  
arm                   randconfig-002-20240229   gcc  
arm                   randconfig-003-20240229   clang
arm                   randconfig-004-20240229   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240229   clang
arm64                 randconfig-002-20240229   gcc  
arm64                 randconfig-003-20240229   clang
arm64                 randconfig-004-20240229   clang
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240229   gcc  
csky                  randconfig-002-20240229   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
hexagon               randconfig-001-20240229   clang
hexagon               randconfig-002-20240229   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240229   clang
i386         buildonly-randconfig-002-20240229   gcc  
i386         buildonly-randconfig-003-20240229   gcc  
i386         buildonly-randconfig-004-20240229   clang
i386         buildonly-randconfig-005-20240229   gcc  
i386         buildonly-randconfig-006-20240229   gcc  
i386                                defconfig   clang
i386                  randconfig-001-20240229   clang
i386                  randconfig-002-20240229   gcc  
i386                  randconfig-003-20240229   clang
i386                  randconfig-004-20240229   gcc  
i386                  randconfig-005-20240229   gcc  
i386                  randconfig-006-20240229   gcc  
i386                  randconfig-011-20240229   gcc  
i386                  randconfig-012-20240229   gcc  
i386                  randconfig-013-20240229   clang
i386                  randconfig-014-20240229   clang
i386                  randconfig-015-20240229   clang
i386                  randconfig-016-20240229   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240229   gcc  
loongarch             randconfig-002-20240229   gcc  
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
nios2                 randconfig-001-20240229   gcc  
nios2                 randconfig-002-20240229   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240229   gcc  
parisc                randconfig-002-20240229   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc               randconfig-001-20240229   clang
powerpc               randconfig-002-20240229   gcc  
powerpc               randconfig-003-20240229   clang
powerpc64             randconfig-001-20240229   gcc  
powerpc64             randconfig-002-20240229   clang
powerpc64             randconfig-003-20240229   clang
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240229   clang
riscv                 randconfig-002-20240229   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240229   clang
s390                  randconfig-002-20240229   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                    randconfig-001-20240229   gcc  
sh                    randconfig-002-20240229   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240229   gcc  
sparc64               randconfig-002-20240229   gcc  
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                             i386_defconfig   gcc  
um                    randconfig-001-20240229   gcc  
um                    randconfig-002-20240229   gcc  
um                           x86_64_defconfig   clang
x86_64                            allnoconfig   clang
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240229   gcc  
x86_64       buildonly-randconfig-002-20240229   clang
x86_64       buildonly-randconfig-003-20240229   gcc  
x86_64       buildonly-randconfig-004-20240229   gcc  
x86_64       buildonly-randconfig-005-20240229   gcc  
x86_64       buildonly-randconfig-006-20240229   gcc  
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240229   clang
x86_64                randconfig-002-20240229   clang
x86_64                randconfig-003-20240229   clang
x86_64                randconfig-004-20240229   clang
x86_64                randconfig-005-20240229   clang
x86_64                randconfig-006-20240229   clang
x86_64                randconfig-011-20240229   gcc  
x86_64                randconfig-012-20240229   gcc  
x86_64                randconfig-013-20240229   gcc  
x86_64                randconfig-014-20240229   gcc  
x86_64                randconfig-015-20240229   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  
xtensa                randconfig-001-20240229   gcc  
xtensa                randconfig-002-20240229   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

