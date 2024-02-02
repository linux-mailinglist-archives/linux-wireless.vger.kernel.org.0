Return-Path: <linux-wireless+bounces-3005-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E751846E1D
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Feb 2024 11:39:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA1C62937DB
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Feb 2024 10:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF718004D;
	Fri,  2 Feb 2024 10:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R7AjJl8D"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B0012B159
	for <linux-wireless@vger.kernel.org>; Fri,  2 Feb 2024 10:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706870383; cv=none; b=d5LqeP3h74FXdmqlGAapLbNZBOXlXr038B3IguzBd+JDTGaLVMrL+KJy/zBsSDxfNS6kyNkko0TEiAJqJ/zRk4Z/rQ9crr+zkdiJwnzKmmhaXsX4pIz8KIbI8uiqW3t2fW5To7zkOKlecrXeCkNmnv6Zf+413lk/PClm3XWIJSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706870383; c=relaxed/simple;
	bh=f/4ZuLNSirsVJUkbn5tEs68kTQN8gR7XGgEJEOAShYc=;
	h=Date:From:To:Cc:Subject:Message-ID; b=ofJjutOAhlk9xYrEmVyzR6JircE7JCDOl85V/Cix1SFJ8kuW/geyJ7A38kEn8RHVQYzYObtyWu6iSeLbcUQL6CkfLedgR9g1M7H2WrqhbHkkpZMdGya9T7vyLyWGyfjYSLy8nwc0ROcrsv7/TcVW5Ws6Y7jJ3Pn+fZeUe8uSyeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R7AjJl8D; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706870381; x=1738406381;
  h=date:from:to:cc:subject:message-id;
  bh=f/4ZuLNSirsVJUkbn5tEs68kTQN8gR7XGgEJEOAShYc=;
  b=R7AjJl8D+oGMw6nN+bDdUhbJRxWJsA40W79annG6gNoR/NP/Ky1G1rNJ
   JJTUgeeMruPlGuqqx0l3bhftH18CSPHpioeim+FORZ8ttV3bMRNY3b4M3
   yesZZu+fPf1g5AbCqFxuWzI7SkOeLUU5gDVbB+TwEVY8u+WUZGdADQ4Tf
   O9wJ6I+4i7hJgxw9nX8nMnptBL+zHZwaGoXnYe8+9N+YIwqxQRjIJ4saS
   vQBLZXlUxlIHaGyoOWZg5oUCx1GR0drqa2PdXy4BJmriO2OfLcXZZ90RR
   jfeGA4G0VyxShsw298eEOzWs+4ZqiwtVdGI8op0MpU82236XqOsnJaEoe
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="3973853"
X-IronPort-AV: E=Sophos;i="6.05,237,1701158400"; 
   d="scan'208";a="3973853"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 02:39:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,237,1701158400"; 
   d="scan'208";a="30856943"
Received: from lkp-server02.sh.intel.com (HELO 59f4f4cd5935) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 02 Feb 2024 02:39:40 -0800
Received: from kbuild by 59f4f4cd5935 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rVqxM-0003mv-2c;
	Fri, 02 Feb 2024 10:39:36 +0000
Date: Fri, 02 Feb 2024 18:39:25 +0800
From: kernel test robot <lkp@intel.com>
To: Kalle Valo <kvalo@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>,
 linux-wireless@vger.kernel.org
Subject: [wireless:for-next] BUILD SUCCESS
 aa125f229076a8230a171d519dbdb2a862145d33
Message-ID: <202402021822.jxiv9mkj-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git for-next
branch HEAD: aa125f229076a8230a171d519dbdb2a862145d33  wifi: iwlwifi: remove extra kernel-doc

elapsed time: 1446m

configs tested: 221
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc  
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
arc                              allmodconfig   gcc  
arc                               allnoconfig   gcc  
arc                              allyesconfig   gcc  
arc                          axs101_defconfig   gcc  
arc                                 defconfig   gcc  
arc                        nsim_700_defconfig   gcc  
arc                        nsimosci_defconfig   gcc  
arc                   randconfig-001-20240201   gcc  
arc                   randconfig-001-20240202   gcc  
arc                   randconfig-002-20240201   gcc  
arc                   randconfig-002-20240202   gcc  
arc                    vdk_hs38_smp_defconfig   gcc  
arm                              allmodconfig   gcc  
arm                               allnoconfig   clang
arm                              allyesconfig   gcc  
arm                         assabet_defconfig   clang
arm                                 defconfig   clang
arm                      footbridge_defconfig   clang
arm                        keystone_defconfig   gcc  
arm                        multi_v7_defconfig   gcc  
arm                       netwinder_defconfig   gcc  
arm                           omap1_defconfig   gcc  
arm                       omap2plus_defconfig   gcc  
arm                          pxa168_defconfig   clang
arm                   randconfig-001-20240201   gcc  
arm                   randconfig-001-20240202   gcc  
arm                   randconfig-002-20240202   gcc  
arm                   randconfig-003-20240201   gcc  
arm                   randconfig-003-20240202   gcc  
arm                           sama5_defconfig   gcc  
arm                        shmobile_defconfig   gcc  
arm64                            allmodconfig   clang
arm64                             allnoconfig   gcc  
arm64                               defconfig   gcc  
arm64                 randconfig-001-20240201   gcc  
arm64                 randconfig-001-20240202   gcc  
arm64                 randconfig-003-20240201   gcc  
arm64                 randconfig-003-20240202   gcc  
arm64                 randconfig-004-20240201   gcc  
arm64                 randconfig-004-20240202   gcc  
csky                             allmodconfig   gcc  
csky                              allnoconfig   gcc  
csky                             allyesconfig   gcc  
csky                                defconfig   gcc  
csky                  randconfig-001-20240201   gcc  
csky                  randconfig-001-20240202   gcc  
csky                  randconfig-002-20240201   gcc  
csky                  randconfig-002-20240202   gcc  
hexagon                          allmodconfig   clang
hexagon                           allnoconfig   clang
hexagon                          allyesconfig   clang
hexagon                             defconfig   clang
i386                             alldefconfig   gcc  
i386                             allmodconfig   gcc  
i386                              allnoconfig   gcc  
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-001-20240201   gcc  
i386         buildonly-randconfig-002-20240201   gcc  
i386         buildonly-randconfig-002-20240202   clang
i386         buildonly-randconfig-004-20240202   clang
i386         buildonly-randconfig-005-20240202   clang
i386         buildonly-randconfig-006-20240201   gcc  
i386                                defconfig   clang
i386                  randconfig-003-20240202   clang
i386                  randconfig-005-20240201   gcc  
i386                  randconfig-012-20240201   gcc  
i386                  randconfig-013-20240201   gcc  
i386                  randconfig-014-20240201   gcc  
i386                  randconfig-014-20240202   clang
i386                  randconfig-015-20240201   gcc  
i386                  randconfig-016-20240201   gcc  
i386                  randconfig-016-20240202   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch                        allyesconfig   gcc  
loongarch                           defconfig   gcc  
loongarch             randconfig-001-20240201   gcc  
loongarch             randconfig-001-20240202   gcc  
loongarch             randconfig-002-20240201   gcc  
loongarch             randconfig-002-20240202   gcc  
m68k                             allmodconfig   gcc  
m68k                              allnoconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                          atari_defconfig   gcc  
m68k                                defconfig   gcc  
microblaze                       allmodconfig   gcc  
microblaze                        allnoconfig   gcc  
microblaze                       allyesconfig   gcc  
microblaze                          defconfig   gcc  
mips                             allmodconfig   gcc  
mips                              allnoconfig   gcc  
mips                             allyesconfig   gcc  
mips                     cu1830-neo_defconfig   gcc  
mips                     decstation_defconfig   gcc  
mips                           ip27_defconfig   gcc  
mips                      malta_kvm_defconfig   gcc  
mips                malta_qemu_32r6_defconfig   gcc  
nios2                            allmodconfig   gcc  
nios2                             allnoconfig   gcc  
nios2                            allyesconfig   gcc  
nios2                               defconfig   gcc  
nios2                 randconfig-001-20240201   gcc  
nios2                 randconfig-001-20240202   gcc  
nios2                 randconfig-002-20240201   gcc  
nios2                 randconfig-002-20240202   gcc  
openrisc                         allmodconfig   gcc  
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc                randconfig-001-20240201   gcc  
parisc                randconfig-001-20240202   gcc  
parisc                randconfig-002-20240201   gcc  
parisc                randconfig-002-20240202   gcc  
parisc64                            defconfig   gcc  
powerpc                     akebono_defconfig   clang
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                          allyesconfig   clang
powerpc                       ebony_defconfig   clang
powerpc                     powernv_defconfig   gcc  
powerpc               randconfig-003-20240201   gcc  
powerpc                     tqm5200_defconfig   gcc  
powerpc                      walnut_defconfig   gcc  
powerpc64             randconfig-002-20240202   gcc  
powerpc64             randconfig-003-20240201   gcc  
riscv                            allmodconfig   clang
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   clang
riscv                               defconfig   clang
riscv                 randconfig-001-20240201   gcc  
riscv                 randconfig-001-20240202   gcc  
riscv                 randconfig-002-20240202   gcc  
s390                             allmodconfig   clang
s390                              allnoconfig   clang
s390                             allyesconfig   gcc  
s390                                defconfig   clang
s390                  randconfig-001-20240201   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sh                ecovec24-romimage_defconfig   gcc  
sh                        edosk7705_defconfig   gcc  
sh                        edosk7760_defconfig   gcc  
sh                            hp6xx_defconfig   gcc  
sh                     magicpanelr2_defconfig   gcc  
sh                    randconfig-001-20240201   gcc  
sh                    randconfig-001-20240202   gcc  
sh                    randconfig-002-20240201   gcc  
sh                    randconfig-002-20240202   gcc  
sh                          rsk7269_defconfig   gcc  
sh                      rts7751r2d1_defconfig   gcc  
sh                     sh7710voipgw_defconfig   gcc  
sh                   sh7724_generic_defconfig   gcc  
sh                  sh7785lcr_32bit_defconfig   gcc  
sh                             shx3_defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                            allyesconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
sparc64               randconfig-001-20240201   gcc  
sparc64               randconfig-001-20240202   gcc  
sparc64               randconfig-002-20240201   gcc  
sparc64               randconfig-002-20240202   gcc  
um                               alldefconfig   clang
um                               allmodconfig   clang
um                                allnoconfig   clang
um                               allyesconfig   gcc  
um                                  defconfig   clang
um                    randconfig-001-20240201   gcc  
um                    randconfig-002-20240201   gcc  
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
x86_64                           rhel-8.3-bpf   gcc  
x86_64                          rhel-8.3-func   gcc  
x86_64                          rhel-8.3-rust   clang
x86_64                               rhel-8.3   gcc  
xtensa                            allnoconfig   gcc  
xtensa                           allyesconfig   gcc  
xtensa                          iss_defconfig   gcc  
xtensa                randconfig-001-20240201   gcc  
xtensa                randconfig-001-20240202   gcc  
xtensa                randconfig-002-20240201   gcc  
xtensa                randconfig-002-20240202   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

