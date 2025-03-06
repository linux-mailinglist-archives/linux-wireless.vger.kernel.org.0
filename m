Return-Path: <linux-wireless+bounces-19849-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE928A544F5
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 09:33:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02C7A188D2DE
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 08:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 740C12063F1;
	Thu,  6 Mar 2025 08:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cwhu7+ip"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF71207DE9
	for <linux-wireless@vger.kernel.org>; Thu,  6 Mar 2025 08:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741249995; cv=none; b=XiGYi6F1u91rn7AIV51Vgla+cXD74ZEBpGRuWdzqEAndaAJ3a/FNKWbYX28eubbbsSPMkT+1vlrrUEE9F78CZkDQvWQBh8k4JT+CeleIcFThs3QdFGzGSM2TPN+ZEvWQoyXQiBwje555jonXT7OET3g1maPhxe4fnMu4NSaZOgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741249995; c=relaxed/simple;
	bh=8Hph1cAETDIztLbbudDQneEEL0jKPmwgBKXmWGVbxoM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=RX/ylLQxn6xeJFDsAeEI6vwB32yD/0FW/q12tgYSUPrXOZ2taM02tHakPsathA5bMYYmkUpb+CrlWyOY1hsjY1NMmKsiOUU8Fbo5ToKYtK7qITyv056CHn3MN92NFeyTm6m2In7oJ1xweqfJbS0u/Jssag9u4jnh/Gt3kIk8I8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cwhu7+ip; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741249992; x=1772785992;
  h=date:from:to:cc:subject:message-id;
  bh=8Hph1cAETDIztLbbudDQneEEL0jKPmwgBKXmWGVbxoM=;
  b=cwhu7+ipy7TDAsxPJkSevTlPDP2gGSTXa4f+NfSawG5dFrNhDA/pUrDv
   I3IHnaWE8EYjOgMg0VneL/vkn2fGFHcLk4QBk84LJJU85ebxKuHE7NRck
   0b30pT32SBmdqkPxCM/SUerIgfVKNqI7/vTqLmW6ufm/pOiUK/fgvLSfq
   f5DfuwPpYlpJZRjQ83tuIr80l2d2W/q5lrvNwBtmUZK8n8LddP6vV/vnC
   2lz7lOl2j3oQ/NjiNOSLDCIM7XHW/wSGqtl8muh/Q+MOp81vxsm+5xptf
   PziOmy6pnQoHiWIrmwJidDOifHpQenYF5NKrXwPHAHT8yhZTgB2+glV2u
   g==;
X-CSE-ConnectionGUID: jF1hmtx0Q9iQyWeGBm2UBQ==
X-CSE-MsgGUID: FlOJqUZaSteKyn31ab7pBw==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="52892420"
X-IronPort-AV: E=Sophos;i="6.14,225,1736841600"; 
   d="scan'208";a="52892420"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 00:33:12 -0800
X-CSE-ConnectionGUID: 0WJzHyOjRf6t9JTvjy7Vig==
X-CSE-MsgGUID: xGaa+7I2QEGB+ju6MEeEhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="149894356"
Received: from lkp-server02.sh.intel.com (HELO 76cde6cc1f07) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 06 Mar 2025 00:33:10 -0800
Received: from kbuild by 76cde6cc1f07 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tq6fE-000Mlu-0q;
	Thu, 06 Mar 2025 08:33:08 +0000
Date: Thu, 06 Mar 2025 16:32:38 +0800
From: kernel test robot <lkp@intel.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>,
 Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org
Subject: [wireless:for-next] BUILD SUCCESS
 3c6a041b317a9bb0c707343c0b99d2a29d523390
Message-ID: <202503061629.q2ngmXDM-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git for-next
branch HEAD: 3c6a041b317a9bb0c707343c0b99d2a29d523390  Merge tag 'wireless-2025-03-04' of https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless

elapsed time: 2332m

configs tested: 252
configs skipped: 8

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-21
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              allmodconfig    clang-18
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-18
arc                              allyesconfig    gcc-13.2.0
arc                      axs103_smp_defconfig    clang-21
arc                                 defconfig    gcc-14.2.0
arc                         haps_hs_defconfig    gcc-13.2.0
arc                   randconfig-001-20250305    gcc-13.2.0
arc                   randconfig-001-20250305    gcc-14.2.0
arc                   randconfig-002-20250305    gcc-13.2.0
arc                   randconfig-002-20250305    gcc-14.2.0
arm                              allmodconfig    clang-18
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-18
arm                              allyesconfig    gcc-14.2.0
arm                         bcm2835_defconfig    clang-17
arm                                 defconfig    gcc-14.2.0
arm                      footbridge_defconfig    gcc-13.2.0
arm                          ixp4xx_defconfig    clang-21
arm                        mvebu_v7_defconfig    clang-17
arm                       omap2plus_defconfig    gcc-14.2.0
arm                   randconfig-001-20250305    gcc-14.2.0
arm                   randconfig-002-20250305    clang-19
arm                   randconfig-002-20250305    gcc-14.2.0
arm                   randconfig-003-20250305    gcc-14.2.0
arm                   randconfig-004-20250305    gcc-14.2.0
arm                        spear3xx_defconfig    gcc-13.2.0
arm64                            alldefconfig    clang-21
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20250305    clang-15
arm64                 randconfig-001-20250305    gcc-14.2.0
arm64                 randconfig-002-20250305    gcc-14.2.0
arm64                 randconfig-003-20250305    clang-21
arm64                 randconfig-003-20250305    gcc-14.2.0
arm64                 randconfig-004-20250305    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20250305    gcc-14.2.0
csky                  randconfig-002-20250305    gcc-14.2.0
hexagon                          allmodconfig    clang-21
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-18
hexagon                          allyesconfig    clang-21
hexagon                             defconfig    gcc-14.2.0
hexagon               randconfig-001-20250305    clang-21
hexagon               randconfig-001-20250305    gcc-14.2.0
hexagon               randconfig-002-20250305    clang-18
hexagon               randconfig-002-20250305    gcc-14.2.0
i386                             allmodconfig    clang-19
i386                              allnoconfig    clang-19
i386                             allyesconfig    clang-19
i386        buildonly-randconfig-001-20250305    clang-19
i386        buildonly-randconfig-002-20250305    clang-19
i386        buildonly-randconfig-003-20250305    clang-19
i386        buildonly-randconfig-004-20250305    clang-19
i386        buildonly-randconfig-005-20250305    clang-19
i386        buildonly-randconfig-006-20250305    clang-19
i386        buildonly-randconfig-006-20250305    gcc-12
i386                                defconfig    clang-19
i386                  randconfig-001-20250305    clang-19
i386                  randconfig-001-20250306    clang-19
i386                  randconfig-002-20250305    clang-19
i386                  randconfig-002-20250306    clang-19
i386                  randconfig-003-20250305    clang-19
i386                  randconfig-003-20250306    clang-19
i386                  randconfig-004-20250305    clang-19
i386                  randconfig-004-20250306    clang-19
i386                  randconfig-005-20250305    clang-19
i386                  randconfig-005-20250306    clang-19
i386                  randconfig-006-20250305    clang-19
i386                  randconfig-006-20250306    clang-19
i386                  randconfig-007-20250305    clang-19
i386                  randconfig-007-20250306    clang-19
i386                  randconfig-011-20250305    gcc-11
i386                  randconfig-011-20250306    gcc-12
i386                  randconfig-012-20250305    gcc-11
i386                  randconfig-012-20250306    gcc-12
i386                  randconfig-013-20250305    gcc-11
i386                  randconfig-013-20250306    gcc-12
i386                  randconfig-014-20250305    gcc-11
i386                  randconfig-014-20250306    gcc-12
i386                  randconfig-015-20250305    gcc-11
i386                  randconfig-015-20250306    gcc-12
i386                  randconfig-016-20250305    gcc-11
i386                  randconfig-016-20250306    gcc-12
i386                  randconfig-017-20250305    gcc-11
i386                  randconfig-017-20250306    gcc-12
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20250305    gcc-14.2.0
loongarch             randconfig-002-20250305    gcc-14.2.0
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                       bmips_be_defconfig    gcc-14.2.0
mips                      maltaaprp_defconfig    clang-21
mips                          rb532_defconfig    clang-17
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20250305    gcc-14.2.0
nios2                 randconfig-002-20250305    gcc-14.2.0
openrisc                          allnoconfig    clang-15
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-12
parisc                           alldefconfig    gcc-13.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-15
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-12
parisc                generic-64bit_defconfig    clang-21
parisc                randconfig-001-20250305    gcc-14.2.0
parisc                randconfig-002-20250305    gcc-14.2.0
parisc64                            defconfig    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-15
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    gcc-14.2.0
powerpc                    ge_imp3a_defconfig    clang-17
powerpc                    ge_imp3a_defconfig    clang-21
powerpc                 mpc834x_itx_defconfig    gcc-14.2.0
powerpc                  mpc866_ads_defconfig    gcc-14.2.0
powerpc                     powernv_defconfig    gcc-14.2.0
powerpc               randconfig-001-20250305    clang-17
powerpc               randconfig-001-20250305    gcc-14.2.0
powerpc               randconfig-002-20250305    gcc-14.2.0
powerpc               randconfig-003-20250305    gcc-14.2.0
powerpc                     tqm8540_defconfig    gcc-13.2.0
powerpc                     tqm8555_defconfig    clang-21
powerpc                 xes_mpc85xx_defconfig    gcc-13.2.0
powerpc64             randconfig-001-20250305    clang-19
powerpc64             randconfig-001-20250305    gcc-14.2.0
powerpc64             randconfig-002-20250305    clang-17
powerpc64             randconfig-002-20250305    gcc-14.2.0
powerpc64             randconfig-003-20250305    clang-19
powerpc64             randconfig-003-20250305    gcc-14.2.0
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    clang-15
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    gcc-14.2.0
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20250305    clang-19
riscv                 randconfig-001-20250305    gcc-14.2.0
riscv                 randconfig-002-20250305    gcc-14.2.0
s390                             allmodconfig    clang-19
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-15
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20250305    gcc-14.2.0
s390                  randconfig-002-20250305    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                             espt_defconfig    clang-17
sh                          polaris_defconfig    gcc-14.2.0
sh                          r7780mp_defconfig    clang-17
sh                    randconfig-001-20250305    gcc-14.2.0
sh                    randconfig-002-20250305    gcc-14.2.0
sh                          rsk7264_defconfig    clang-17
sh                   sh7724_generic_defconfig    gcc-13.2.0
sh                             shx3_defconfig    gcc-14.2.0
sh                          urquell_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20250305    gcc-14.2.0
sparc                 randconfig-002-20250305    gcc-14.2.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20250305    gcc-14.2.0
sparc64               randconfig-002-20250305    gcc-14.2.0
um                               allmodconfig    clang-21
um                                allnoconfig    clang-15
um                                allnoconfig    clang-18
um                               allyesconfig    clang-21
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20250305    clang-19
um                    randconfig-001-20250305    gcc-14.2.0
um                    randconfig-002-20250305    gcc-12
um                    randconfig-002-20250305    gcc-14.2.0
um                           x86_64_defconfig    clang-17
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20250305    clang-19
x86_64      buildonly-randconfig-002-20250305    clang-19
x86_64      buildonly-randconfig-002-20250305    gcc-12
x86_64      buildonly-randconfig-003-20250305    clang-19
x86_64      buildonly-randconfig-004-20250305    clang-19
x86_64      buildonly-randconfig-004-20250305    gcc-12
x86_64      buildonly-randconfig-005-20250305    clang-19
x86_64      buildonly-randconfig-006-20250305    clang-19
x86_64                              defconfig    clang-19
x86_64                                  kexec    clang-19
x86_64                randconfig-001-20250305    gcc-12
x86_64                randconfig-001-20250306    clang-19
x86_64                randconfig-002-20250305    gcc-12
x86_64                randconfig-002-20250306    clang-19
x86_64                randconfig-003-20250305    gcc-12
x86_64                randconfig-003-20250306    clang-19
x86_64                randconfig-004-20250305    gcc-12
x86_64                randconfig-004-20250306    clang-19
x86_64                randconfig-005-20250305    gcc-12
x86_64                randconfig-005-20250306    clang-19
x86_64                randconfig-006-20250305    gcc-12
x86_64                randconfig-006-20250306    clang-19
x86_64                randconfig-007-20250305    gcc-12
x86_64                randconfig-007-20250306    clang-19
x86_64                randconfig-008-20250305    gcc-12
x86_64                randconfig-008-20250306    clang-19
x86_64                randconfig-071-20250305    clang-19
x86_64                randconfig-071-20250306    clang-19
x86_64                randconfig-072-20250305    clang-19
x86_64                randconfig-072-20250306    clang-19
x86_64                randconfig-073-20250305    clang-19
x86_64                randconfig-073-20250306    clang-19
x86_64                randconfig-074-20250305    clang-19
x86_64                randconfig-074-20250306    clang-19
x86_64                randconfig-075-20250305    clang-19
x86_64                randconfig-075-20250306    clang-19
x86_64                randconfig-076-20250305    clang-19
x86_64                randconfig-076-20250306    clang-19
x86_64                randconfig-077-20250305    clang-19
x86_64                randconfig-077-20250306    clang-19
x86_64                randconfig-078-20250305    clang-19
x86_64                randconfig-078-20250306    clang-19
x86_64                               rhel-9.4    clang-19
x86_64                           rhel-9.4-bpf    clang-18
x86_64                         rhel-9.4-kunit    clang-18
x86_64                           rhel-9.4-ltp    clang-18
x86_64                          rhel-9.4-rust    clang-18
xtensa                            allnoconfig    gcc-14.2.0
xtensa                randconfig-001-20250305    gcc-14.2.0
xtensa                randconfig-002-20250305    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

