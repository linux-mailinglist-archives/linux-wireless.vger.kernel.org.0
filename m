Return-Path: <linux-wireless+bounces-12479-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B0A596BC5A
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Sep 2024 14:31:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98C9C1F219F9
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Sep 2024 12:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46C541D9335;
	Wed,  4 Sep 2024 12:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HovdViwI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377941E864
	for <linux-wireless@vger.kernel.org>; Wed,  4 Sep 2024 12:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725453019; cv=none; b=suGRCYOmN9wSkw9VDgl8HTmNiWk4jPqMcioM4ttjlT7O1r0mBQYIGfZ8lUUA/IOjcaQmXh1KdM2utOemf3byHDMmLzIqesFivv2TPXxc68cZYVlVGoIOoaTpFjS3z470N+HrkFr94EsEs07w6fJDIGy75/Q48b08djYBf2jrcY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725453019; c=relaxed/simple;
	bh=O2cRHFCOMX26Cb2V/uemiolEY91MDFQU1xKvh8D+ao8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=FE6sQSuJdBg1z5SYyeDaqzVpa/kcmRIJvC9Mwo2hEYg/xaohxA0ps5hIT8OpDIk7T+8hMfjPdKEb6CbQ3wQ9sEKvX+liL1Aupp1Vxmwxg2ngziy0fjcYwZmc58hxsbqy8K3c0a47L9SlbVXhn+ruSQ7XromZW2a3Fg+e/lGFDxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HovdViwI; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725453017; x=1756989017;
  h=date:from:to:cc:subject:message-id;
  bh=O2cRHFCOMX26Cb2V/uemiolEY91MDFQU1xKvh8D+ao8=;
  b=HovdViwIyo6gosSHsNdHFI3RiZtQBgUjv13QMTfta6Z+mTcaOGnsJqef
   e8CI9HMBxY25EDn2rWVuAxpsxrD/YSL75+ErpHwde4Asi2fq/rhqzadYM
   LseTSabT8GT/nsSKCdrJEZiJ66QSwkRaD4y+e3ig5D3WdyKI0tWrnz5Iv
   MZ5ii1tbPKGYFlTgLgRfwCSBSeMxMXBWTm2dnVgxAq5Lq+WyH+4kXkVVI
   E9vXolNEOZXO9tp6QGIssh8/YmypNRz0794lRnM1aE9eiHV5Z4Oz50kPK
   2j0WGdtFiM5UDDCG6XOk1bzPNkF7YaVXHF08n8UAEUcsyafM987jhjGC1
   w==;
X-CSE-ConnectionGUID: wr8soe16TI6kBKL9+5wJQA==
X-CSE-MsgGUID: kINuIU/cQ5K2RZH/4kGtbA==
X-IronPort-AV: E=McAfee;i="6700,10204,11184"; a="24272039"
X-IronPort-AV: E=Sophos;i="6.10,201,1719903600"; 
   d="scan'208";a="24272039"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2024 05:30:16 -0700
X-CSE-ConnectionGUID: YspiVLUAQ8SMfOGabEmFQg==
X-CSE-MsgGUID: zOdKiPNPSI6oEPjoal4zKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,201,1719903600"; 
   d="scan'208";a="65299658"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 04 Sep 2024 05:30:15 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1slp9J-00082p-0q;
	Wed, 04 Sep 2024 12:30:13 +0000
Date: Wed, 04 Sep 2024 20:29:45 +0800
From: kernel test robot <lkp@intel.com>
To: Kalle Valo <kvalo@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>,
 linux-wireless@vger.kernel.org
Subject: [wireless-next:main] BUILD SUCCESS
 97b766f989bcd06e5a7651b1080001d7327012f5
Message-ID: <202409042042.nAKywTYT-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: 97b766f989bcd06e5a7651b1080001d7327012f5  wifi: mwifiex: Convert to use jiffies macro

elapsed time: 1032m

configs tested: 93
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-14.1.0
alpha                            allyesconfig   clang-20
alpha                               defconfig   gcc-14.1.0
arc                              allmodconfig   clang-20
arc                               allnoconfig   gcc-14.1.0
arc                              allyesconfig   clang-20
arc                                 defconfig   gcc-14.1.0
arm                              allmodconfig   clang-20
arm                               allnoconfig   gcc-14.1.0
arm                              allyesconfig   clang-20
arm                                 defconfig   gcc-14.1.0
arm                        neponset_defconfig   gcc-14.1.0
arm                         socfpga_defconfig   gcc-14.1.0
arm64                            allmodconfig   clang-20
arm64                             allnoconfig   gcc-14.1.0
arm64                               defconfig   gcc-14.1.0
csky                             alldefconfig   gcc-14.1.0
csky                              allnoconfig   gcc-14.1.0
csky                                defconfig   gcc-14.1.0
hexagon                          allmodconfig   clang-20
hexagon                           allnoconfig   gcc-14.1.0
hexagon                          allyesconfig   clang-20
hexagon                             defconfig   gcc-14.1.0
i386                             allmodconfig   clang-18
i386                              allnoconfig   clang-18
i386                             allyesconfig   clang-18
i386                                defconfig   clang-18
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch                           defconfig   gcc-14.1.0
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
m68k                                defconfig   gcc-14.1.0
m68k                          multi_defconfig   gcc-14.1.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
microblaze                          defconfig   gcc-14.1.0
mips                              allnoconfig   gcc-14.1.0
mips                           gcw0_defconfig   gcc-14.1.0
mips                           ip28_defconfig   gcc-14.1.0
mips                           jazz_defconfig   gcc-14.1.0
nios2                             allnoconfig   gcc-14.1.0
nios2                               defconfig   gcc-14.1.0
openrisc                          allnoconfig   clang-20
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-12
openrisc                 simple_smp_defconfig   gcc-14.1.0
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   clang-20
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-12
parisc64                            defconfig   gcc-14.1.0
powerpc                     akebono_defconfig   gcc-14.1.0
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   clang-20
powerpc                          allyesconfig   gcc-14.1.0
powerpc                      ep88xc_defconfig   gcc-14.1.0
powerpc                          g5_defconfig   gcc-14.1.0
powerpc                    ge_imp3a_defconfig   gcc-14.1.0
powerpc                 xes_mpc85xx_defconfig   gcc-14.1.0
riscv                            allmodconfig   gcc-14.1.0
riscv                             allnoconfig   clang-20
riscv                            allyesconfig   gcc-14.1.0
riscv                               defconfig   gcc-12
s390                             allmodconfig   gcc-14.1.0
s390                              allnoconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   gcc-12
s390                                defconfig   gcc-14.1.0
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-12
sh                          sdk7786_defconfig   gcc-14.1.0
sh                           se7724_defconfig   gcc-14.1.0
sparc                            allmodconfig   gcc-14.1.0
sparc                       sparc32_defconfig   gcc-14.1.0
sparc64                             defconfig   gcc-12
um                               allmodconfig   clang-20
um                                allnoconfig   clang-20
um                               allyesconfig   clang-20
um                                  defconfig   gcc-12
um                             i386_defconfig   gcc-12
um                           x86_64_defconfig   gcc-12
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64                              defconfig   clang-18
x86_64                                  kexec   gcc-12
x86_64                          rhel-8.3-rust   clang-18
x86_64                               rhel-8.3   gcc-12
xtensa                            allnoconfig   gcc-14.1.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

