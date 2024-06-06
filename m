Return-Path: <linux-wireless+bounces-8642-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E67D38FF556
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Jun 2024 21:36:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EEC81F270C5
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Jun 2024 19:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3791240BF2;
	Thu,  6 Jun 2024 19:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FpGPzFzq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723E54087C
	for <linux-wireless@vger.kernel.org>; Thu,  6 Jun 2024 19:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717702567; cv=none; b=JLenEUL6J/OmoFEAn19AbLyn0P4HYZrghB7vPTWEb8YuX/RREA1Jp+vrtrxwRrwtw9vAjq69A7LPZLOHV6mWzU/KhdmAENvOYZTlBvDoasF2J57B2ABtsNPh7NX1YXZl5LtNC/9myLFu7qovN6WsaRjTrbw3qmHc43leC480dBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717702567; c=relaxed/simple;
	bh=waI3UWtzD9Vn/CITDmwA0+b+Ulo2nw2EEK3W/cR8+I0=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Ze6+yA3M1K91U3ngM1BshKgS8Kw5U+0grjQfZHEg3FBsIbeTgxRlG+x9JV/BELkpU0HWRIS9BczTZ7Ir8AeDUrSh3VfXnFmzXJXO2XQVjNPE5pPVYNAGUiGBOcxO6ySDZD62Kak5XfkqbeG0IToryXhrxGA0zTa8+KPvfPK+xLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FpGPzFzq; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717702566; x=1749238566;
  h=date:from:to:cc:subject:message-id;
  bh=waI3UWtzD9Vn/CITDmwA0+b+Ulo2nw2EEK3W/cR8+I0=;
  b=FpGPzFzqJWJoILt0Zr397CnwjcgaOOzcdd8k2HmNYCFVO2+L+2r5pjPZ
   TEb8qFiqKWztN+DdajChzWQnlG5T0g26dMESrs77qc5EU5v1kf1RECu+1
   IxixARmA3uNhTo2DXt7uuNVyZig8CXIYqtP3K6pF870RRcFj48ISAaN33
   Q2reAdWGFFwvGkZjLbJ19iQO3mTWL10KMk4Jr9duYhfSXEOG4FCZeQ3Hg
   PXf42w5omtGKWemLXES+RDVy0sv6ORJWJRyOlP2nVvAmPq8Kz/h4ykZqb
   mm2XL8i4wi6R9Cs0el1c+X++i71qOr06rZrmo7dc6o4/V098zmzHJ4/QH
   Q==;
X-CSE-ConnectionGUID: no2W/bBGRAaiOxZhX2/SdQ==
X-CSE-MsgGUID: cMZFyhXDTrS3deqPE7K7Qg==
X-IronPort-AV: E=McAfee;i="6600,9927,11095"; a="17329579"
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="17329579"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2024 12:36:05 -0700
X-CSE-ConnectionGUID: jeZ5xdbEQpOi0pxx9gp4TQ==
X-CSE-MsgGUID: PeRNFT+pR2yiznACJ98vGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,219,1712646000"; 
   d="scan'208";a="75549982"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 06 Jun 2024 12:36:03 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sFIu0-0003cu-1S;
	Thu, 06 Jun 2024 19:36:00 +0000
Date: Fri, 07 Jun 2024 03:35:00 +0800
From: kernel test robot <lkp@intel.com>
To: Kalle Valo <kvalo@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>,
 linux-wireless@vger.kernel.org
Subject: [wireless-next:main] BUILD SUCCESS
 a46300b1b09ba260c2c2b00f06f6e34482a8ec01
Message-ID: <202406070357.qUhaLV0p-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: a46300b1b09ba260c2c2b00f06f6e34482a8ec01  Merge tag 'ath-next-20240605' of git://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath

elapsed time: 1472m

configs tested: 86
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
arc                   randconfig-001-20240607   gcc  
arc                   randconfig-002-20240607   gcc  
arm                               allnoconfig   clang
arm                                 defconfig   clang
arm                   randconfig-001-20240607   gcc  
arm                   randconfig-002-20240607   clang
arm                   randconfig-003-20240607   clang
arm                   randconfig-004-20240607   gcc  
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240607   gcc  
arm64                 randconfig-002-20240607   clang
csky                              allnoconfig   gcc  
csky                                defconfig   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-004-20240606   gcc  
i386         buildonly-randconfig-006-20240606   gcc  
i386                                defconfig   clang
i386                  randconfig-012-20240606   gcc  
i386                  randconfig-013-20240606   gcc  
i386                  randconfig-014-20240606   gcc  
i386                  randconfig-015-20240606   gcc  
i386                  randconfig-016-20240606   gcc  
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
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                            defconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                           allnoconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                               defconfig   clang
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
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
x86_64                              defconfig   gcc  
x86_64                          rhel-8.3-rust   clang
xtensa                            allnoconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

