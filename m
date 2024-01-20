Return-Path: <linux-wireless+bounces-2292-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0737C833699
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Jan 2024 22:56:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24C621C21343
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Jan 2024 21:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 201D012E47;
	Sat, 20 Jan 2024 21:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q5peSgoX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6188C8BEC
	for <linux-wireless@vger.kernel.org>; Sat, 20 Jan 2024 21:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705787760; cv=none; b=rpPByQugqn07ns127PEg8gYi/1TzQ7lhEHI/eoLDSuu7bdHepKdp6p3kIhZrTOqHRe8RPaoKCfpiNVeTV4O7KWi5cMZDWhETzPGSV4gM6jJpel+IzPz+dlR1QUVrNR8Nnf+TekNquVAZl4spbXI3yLRgCLjBBllJZkiVseUFtGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705787760; c=relaxed/simple;
	bh=4KScG/TakkBel+hlR0GOYAQz7/mNfnvm+4Ua82FY2Rw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=HAOgbEyz0sR44FKPN5sSigUDLurHmJuenCa6jBVZ026ojRdAC4JhSrywHo/oHHDfG4jS/VCoQCQXlthKHgbKbendUmvGrCS7OOs9e/ZEi194PpiYrKKot83WqyZlyTcHWCuIDxYRoqslbshGu8POtNnBpNeAGlpIWVVqZMObYAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q5peSgoX; arc=none smtp.client-ip=134.134.136.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705787757; x=1737323757;
  h=date:from:to:cc:subject:message-id;
  bh=4KScG/TakkBel+hlR0GOYAQz7/mNfnvm+4Ua82FY2Rw=;
  b=Q5peSgoXiuw5ZNPK1U/CEal8YFEhde3TK0cUNOMe1yPK8uzzvnfdnzPz
   EkolOA7JcjU8rMGrFCLVD8RY/URs3oXM+ZKRHOnLyZeafi2oW9Hz7golS
   IUNR3X1KlqcVoMvWWB3YZYIGbVwaRqBU86HTT02wm5cWf6wPQrJLaKIiW
   eUwhQdqB2LBdG65QJmfsuwDbGnRYIJEVm1YHCZJpneZWD/WgOrzWfXWsX
   xSVujlw0U0FCXhtO1CRNqTBtSzGuLRf+WEZg3LHzFgc/nj04Yoqreicfg
   cDfIR1WMz0iW4yE7fGT9/m5DLojculukHr/thWWBeBS9O919jJDm1tPQN
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10959"; a="467353796"
X-IronPort-AV: E=Sophos;i="6.05,208,1701158400"; 
   d="scan'208";a="467353796"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2024 13:55:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10959"; a="761406371"
X-IronPort-AV: E=Sophos;i="6.05,208,1701158400"; 
   d="scan'208";a="761406371"
Received: from lkp-server01.sh.intel.com (HELO 961aaaa5b03c) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 20 Jan 2024 13:55:55 -0800
Received: from kbuild by 961aaaa5b03c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rRJJh-0005TO-04;
	Sat, 20 Jan 2024 21:55:53 +0000
Date: Sun, 21 Jan 2024 05:54:57 +0800
From: kernel test robot <lkp@intel.com>
To: Kalle Valo <kvalo@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>,
 linux-wireless@vger.kernel.org
Subject: [wireless-next:main] BUILD SUCCESS
 b06439c6687443e6b99dbcf746042067ff0e9ba9
Message-ID: <202401210555.LBRf6Fxw-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: b06439c6687443e6b99dbcf746042067ff0e9ba9  wifi: rtlwifi: Speed up firmware loading for USB

elapsed time: 1678m

configs tested: 108
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                               defconfig   gcc  
arc                     haps_hs_smp_defconfig   gcc  
arc                   randconfig-001-20240120   gcc  
arc                   randconfig-002-20240120   gcc  
arm                         lpc32xx_defconfig   clang
arm                   randconfig-001-20240120   clang
arm                   randconfig-002-20240120   clang
arm                   randconfig-003-20240120   clang
arm                   randconfig-004-20240120   clang
arm64                 randconfig-001-20240120   clang
arm64                 randconfig-002-20240120   clang
arm64                 randconfig-003-20240120   clang
arm64                 randconfig-004-20240120   clang
csky                  randconfig-001-20240120   gcc  
csky                  randconfig-002-20240120   gcc  
hexagon               randconfig-001-20240120   clang
hexagon               randconfig-002-20240120   clang
i386                             allmodconfig   clang
i386                              allnoconfig   clang
i386                             allyesconfig   clang
i386         buildonly-randconfig-001-20240120   clang
i386         buildonly-randconfig-002-20240120   clang
i386         buildonly-randconfig-003-20240120   clang
i386         buildonly-randconfig-004-20240120   clang
i386         buildonly-randconfig-005-20240120   clang
i386         buildonly-randconfig-006-20240120   clang
i386                                defconfig   gcc  
i386                  randconfig-001-20240120   clang
i386                  randconfig-002-20240120   clang
i386                  randconfig-003-20240120   clang
i386                  randconfig-004-20240120   clang
i386                  randconfig-005-20240120   clang
i386                  randconfig-006-20240120   clang
i386                  randconfig-011-20240120   gcc  
i386                  randconfig-012-20240120   gcc  
i386                  randconfig-013-20240120   gcc  
i386                  randconfig-014-20240120   gcc  
i386                  randconfig-015-20240120   gcc  
i386                  randconfig-016-20240120   gcc  
loongarch                        allmodconfig   gcc  
loongarch             randconfig-001-20240120   gcc  
loongarch             randconfig-002-20240120   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                        mvme147_defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                       allyesconfig   gcc  
mips                             allyesconfig   gcc  
mips                       bmips_be_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                 randconfig-001-20240120   gcc  
nios2                 randconfig-002-20240120   gcc  
parisc                randconfig-001-20240120   gcc  
parisc                randconfig-002-20240120   gcc  
powerpc               randconfig-001-20240120   clang
powerpc               randconfig-002-20240120   clang
powerpc               randconfig-003-20240120   clang
powerpc64             randconfig-001-20240120   clang
powerpc64             randconfig-002-20240120   clang
powerpc64             randconfig-003-20240120   clang
riscv                 randconfig-001-20240120   clang
riscv                 randconfig-002-20240120   clang
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                  randconfig-001-20240120   gcc  
s390                  randconfig-002-20240120   gcc  
sh                               allmodconfig   gcc  
sh                               allyesconfig   gcc  
sh                    randconfig-001-20240120   gcc  
sh                    randconfig-002-20240120   gcc  
sparc                            allmodconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64               randconfig-001-20240120   gcc  
sparc64               randconfig-002-20240120   gcc  
um                               allmodconfig   clang
um                    randconfig-001-20240120   clang
um                    randconfig-002-20240120   clang
x86_64                            allnoconfig   gcc  
x86_64                           allyesconfig   clang
x86_64       buildonly-randconfig-001-20240120   clang
x86_64       buildonly-randconfig-002-20240120   clang
x86_64       buildonly-randconfig-003-20240120   clang
x86_64       buildonly-randconfig-004-20240120   clang
x86_64       buildonly-randconfig-005-20240120   clang
x86_64       buildonly-randconfig-006-20240120   clang
x86_64                              defconfig   gcc  
x86_64                randconfig-001-20240120   gcc  
x86_64                randconfig-002-20240120   gcc  
x86_64                randconfig-003-20240120   gcc  
x86_64                randconfig-004-20240120   gcc  
x86_64                randconfig-005-20240120   gcc  
x86_64                randconfig-006-20240120   gcc  
x86_64                randconfig-011-20240120   clang
x86_64                randconfig-012-20240120   clang
x86_64                randconfig-013-20240120   clang
x86_64                randconfig-014-20240120   clang
x86_64                randconfig-015-20240120   clang
x86_64                randconfig-016-20240120   clang
x86_64                randconfig-071-20240120   clang
x86_64                randconfig-072-20240120   clang
x86_64                randconfig-073-20240120   clang
x86_64                randconfig-074-20240120   clang
x86_64                randconfig-075-20240120   clang
x86_64                randconfig-076-20240120   clang
x86_64                          rhel-8.3-rust   clang
xtensa                randconfig-001-20240120   gcc  
xtensa                randconfig-002-20240120   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

