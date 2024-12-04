Return-Path: <linux-wireless+bounces-15883-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B3AE9E38A6
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Dec 2024 12:21:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7DA1B33D06
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Dec 2024 11:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 081DE1B4F3A;
	Wed,  4 Dec 2024 11:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ibDfoOvI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788D71B4137
	for <linux-wireless@vger.kernel.org>; Wed,  4 Dec 2024 11:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733310450; cv=none; b=rInnI179i28CMhv387Y+t2ZGzNzwAbUNqwJiMGqbwzGWBuYT3PpX50oiNRIi2HDuxCqOwMlUaQy3Awj5kRs1zR0knKhl+DPjHOuimQbAjCkgjCo05EU3TqZu6En4Yx+1M5fhNT+oS8+lvviN1kNXgwUniqeZM+g6JPOkn+nXS/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733310450; c=relaxed/simple;
	bh=qPBN4+HJsxZ9mhvNdea+KgsesEPqtcXRLsUNE7QVxvk=;
	h=Date:From:To:Cc:Subject:Message-ID; b=AVI6L1zcNw0BLMJuhKFJwZWvYKGMEzGwQAdpiTE9lPuRPTxhgjCEaPgKeWumEYmLMaAch47CJOBVvkLgiDe2iv2sUACxJ2BENB6aPhYUUSAovgac3HBqPKunBO/MpbkwmLsvG9Exjcn6LAh2xM9unWgW6JsK8flcX1jgjCJsRl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ibDfoOvI; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733310448; x=1764846448;
  h=date:from:to:cc:subject:message-id;
  bh=qPBN4+HJsxZ9mhvNdea+KgsesEPqtcXRLsUNE7QVxvk=;
  b=ibDfoOvIFYpx8Ay3uwVjZFd9C4PDcDqROU5aYTDoLDhhICs+bxje1TGZ
   dbbKd0sDpWozwoyt7C62SZveE4A0OQeKXcHY0ecBG0gU+3Auuf2kCGBBe
   EClU+LdE4HNPmQdufeycLrTaG8VUYSBX1jGnYwFbxPECpoyM1c5aPh1Fp
   l8PwNkHF3ZNXylbGuHIbh9SuCrf2PiKZ0Nv9zWHWRb6txq9A2yb3KXnHi
   UEXYh/1WAHyQWjUDLsl7DS2h4Rp/4ilWY6MCjkS5T1X1u9YKh1SZn1dMY
   jQ8FU0jfcmnAfS8TFY/B+SGfiTXBnT6gTm1TObUW3Z3fFw5SPhUBtXoFl
   Q==;
X-CSE-ConnectionGUID: G3FnygwoTxS/VYEXLqa9eQ==
X-CSE-MsgGUID: KCRHf8IDTp+Q/y+JBtD/ZA==
X-IronPort-AV: E=McAfee;i="6700,10204,11275"; a="44596451"
X-IronPort-AV: E=Sophos;i="6.12,207,1728975600"; 
   d="scan'208";a="44596451"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2024 03:07:28 -0800
X-CSE-ConnectionGUID: 6SGTTe7sSXuqmSEFYLqYnw==
X-CSE-MsgGUID: sSQx+AFUQRufVSuP7indAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,207,1728975600"; 
   d="scan'208";a="124663761"
Received: from lkp-server02.sh.intel.com (HELO 1f5a171d57e2) ([10.239.97.151])
  by fmviesa001.fm.intel.com with ESMTP; 04 Dec 2024 03:07:25 -0800
Received: from kbuild by 1f5a171d57e2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tInDg-0002ul-0w;
	Wed, 04 Dec 2024 11:07:05 +0000
Date: Wed, 04 Dec 2024 19:03:15 +0800
From: kernel test robot <lkp@intel.com>
To: Johannes Berg <johannes.berg@intel.com>
Cc: Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org
Subject: [wireless:for-next] BUILD SUCCESS
 819e0f1e58e0ba3800cd9eb96b2a39e44e49df97
Message-ID: <202412041904.0L0NHzxi-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git for-next
branch HEAD: 819e0f1e58e0ba3800cd9eb96b2a39e44e49df97  wifi: mac80211: fix station NSS capability initialization order

elapsed time: 1446m

configs tested: 232
configs skipped: 6

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-20
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    clang-20
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    clang-20
arc                              allyesconfig    gcc-13.2.0
arc                      axs103_smp_defconfig    gcc-14.2.0
arc                     haps_hs_smp_defconfig    gcc-14.2.0
arc                        nsimosci_defconfig    gcc-13.2.0
arc                 nsimosci_hs_smp_defconfig    clang-20
arc                            randconfig-001    clang-20
arc                   randconfig-001-20241203    gcc-13.2.0
arc                            randconfig-002    clang-20
arc                   randconfig-002-20241203    gcc-13.2.0
arc                    vdk_hs38_smp_defconfig    gcc-14.2.0
arm                              allmodconfig    clang-20
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-20
arm                              allyesconfig    clang-20
arm                              allyesconfig    gcc-14.2.0
arm                       aspeed_g4_defconfig    clang-20
arm                       aspeed_g5_defconfig    gcc-14.2.0
arm                         assabet_defconfig    clang-20
arm                         at91_dt_defconfig    clang-20
arm                     davinci_all_defconfig    clang-20
arm                     davinci_all_defconfig    gcc-14.2.0
arm                           h3600_defconfig    clang-20
arm                       imx_v6_v7_defconfig    clang-20
arm                          ixp4xx_defconfig    gcc-14.2.0
arm                        keystone_defconfig    gcc-14.2.0
arm                         lpc18xx_defconfig    clang-20
arm                        mvebu_v5_defconfig    gcc-14.2.0
arm                          pxa3xx_defconfig    gcc-14.2.0
arm                          pxa910_defconfig    clang-20
arm                             pxa_defconfig    gcc-14.2.0
arm                            qcom_defconfig    clang-20
arm                            randconfig-001    clang-20
arm                   randconfig-001-20241203    clang-20
arm                            randconfig-002    clang-20
arm                   randconfig-002-20241203    gcc-14.2.0
arm                            randconfig-003    clang-20
arm                   randconfig-003-20241203    clang-20
arm                            randconfig-004    clang-20
arm                   randconfig-004-20241203    clang-20
arm                             rpc_defconfig    gcc-14.2.0
arm                        shmobile_defconfig    clang-18
arm                        shmobile_defconfig    gcc-14.2.0
arm                         socfpga_defconfig    gcc-14.2.0
arm                          sp7021_defconfig    clang-20
arm                        spear3xx_defconfig    clang-16
arm                        spear3xx_defconfig    clang-20
arm                           spitz_defconfig    gcc-14.2.0
arm                           stm32_defconfig    clang-20
arm                         wpcm450_defconfig    clang-20
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                          randconfig-001    clang-20
arm64                 randconfig-001-20241203    gcc-14.2.0
arm64                          randconfig-002    clang-20
arm64                 randconfig-002-20241203    gcc-14.2.0
arm64                          randconfig-003    clang-20
arm64                 randconfig-003-20241203    gcc-14.2.0
arm64                          randconfig-004    clang-20
arm64                 randconfig-004-20241203    clang-20
csky                             alldefconfig    clang-20
csky                             alldefconfig    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    clang-20
hexagon                          allyesconfig    clang-20
i386                 buildonly-randconfig-001    gcc-12
i386        buildonly-randconfig-001-20241203    gcc-12
i386                 buildonly-randconfig-002    gcc-12
i386        buildonly-randconfig-002-20241203    gcc-12
i386                 buildonly-randconfig-003    gcc-12
i386        buildonly-randconfig-003-20241203    clang-19
i386                 buildonly-randconfig-004    gcc-12
i386        buildonly-randconfig-004-20241203    clang-19
i386                 buildonly-randconfig-005    gcc-12
i386        buildonly-randconfig-005-20241203    clang-19
i386                 buildonly-randconfig-006    gcc-12
i386        buildonly-randconfig-006-20241203    gcc-12
loongarch                         allnoconfig    gcc-14.2.0
loongarch                 loongson3_defconfig    clang-18
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                         amcore_defconfig    gcc-14.2.0
m68k                          atari_defconfig    clang-18
m68k                          atari_defconfig    gcc-14.2.0
m68k                       bvme6000_defconfig    gcc-14.2.0
m68k                        m5272c3_defconfig    gcc-14.2.0
m68k                       m5275evb_defconfig    gcc-14.2.0
m68k                        m5407c3_defconfig    gcc-14.2.0
m68k                        mvme16x_defconfig    gcc-14.2.0
m68k                            q40_defconfig    gcc-14.2.0
m68k                        stmark2_defconfig    gcc-14.2.0
m68k                          sun3x_defconfig    gcc-14.2.0
microblaze                       alldefconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                      mmu_defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                          ath25_defconfig    clang-20
mips                          ath79_defconfig    gcc-14.2.0
mips                      bmips_stb_defconfig    clang-18
mips                      bmips_stb_defconfig    clang-20
mips                           ci20_defconfig    clang-18
mips                         db1xxx_defconfig    clang-20
mips                          eyeq6_defconfig    clang-20
mips                           ip22_defconfig    gcc-14.2.0
mips                           ip32_defconfig    gcc-14.2.0
mips                           jazz_defconfig    clang-20
mips                          rb532_defconfig    clang-18
mips                         rt305x_defconfig    clang-20
mips                   sb1250_swarm_defconfig    gcc-14.2.0
mips                           xway_defconfig    clang-20
nios2                         10m50_defconfig    gcc-14.2.0
nios2                         3c120_defconfig    gcc-14.2.0
nios2                            alldefconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
openrisc                         alldefconfig    gcc-14.2.0
openrisc                          allnoconfig    clang-20
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                       virt_defconfig    clang-20
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-20
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                generic-32bit_defconfig    gcc-14.2.0
powerpc                    adder875_defconfig    gcc-14.2.0
powerpc                     akebono_defconfig    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-20
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-20
powerpc                          allyesconfig    gcc-14.2.0
powerpc                   bluestone_defconfig    clang-20
powerpc                        cell_defconfig    gcc-14.2.0
powerpc                      cm5200_defconfig    clang-20
powerpc                       ebony_defconfig    clang-18
powerpc                    ge_imp3a_defconfig    gcc-14.2.0
powerpc                  iss476-smp_defconfig    clang-20
powerpc                  iss476-smp_defconfig    gcc-14.2.0
powerpc                 linkstation_defconfig    clang-20
powerpc                 linkstation_defconfig    gcc-14.2.0
powerpc                   motionpro_defconfig    clang-18
powerpc                 mpc8313_rdb_defconfig    clang-20
powerpc                  mpc866_ads_defconfig    clang-20
powerpc                    mvme5100_defconfig    gcc-14.2.0
powerpc                      pmac32_defconfig    clang-20
powerpc                      pmac32_defconfig    gcc-14.2.0
powerpc                     ppa8548_defconfig    clang-20
powerpc                     ppa8548_defconfig    gcc-14.2.0
powerpc                      ppc64e_defconfig    gcc-14.2.0
powerpc                     rainier_defconfig    gcc-14.2.0
powerpc                  storcenter_defconfig    gcc-14.2.0
powerpc                     stx_gp3_defconfig    clang-20
powerpc                     tqm5200_defconfig    gcc-14.2.0
powerpc                     tqm8540_defconfig    gcc-14.2.0
powerpc                      tqm8xx_defconfig    clang-20
powerpc                         wii_defconfig    gcc-14.2.0
riscv                            allmodconfig    clang-20
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    clang-20
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-20
riscv                            allyesconfig    gcc-14.2.0
riscv                               defconfig    clang-20
riscv                    nommu_k210_defconfig    clang-20
riscv                    nommu_k210_defconfig    gcc-14.2.0
s390                             allmodconfig    clang-20
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                        apsh4ad0a_defconfig    gcc-14.2.0
sh                        dreamcast_defconfig    gcc-14.2.0
sh                ecovec24-romimage_defconfig    clang-20
sh                ecovec24-romimage_defconfig    gcc-14.2.0
sh                            hp6xx_defconfig    gcc-14.2.0
sh                          landisk_defconfig    clang-20
sh                          landisk_defconfig    gcc-14.2.0
sh                   rts7751r2dplus_defconfig    clang-20
sh                   rts7751r2dplus_defconfig    gcc-14.2.0
sh                          sdk7780_defconfig    gcc-14.2.0
sh                          sdk7786_defconfig    clang-20
sh                           se7343_defconfig    clang-20
sh                           se7619_defconfig    clang-20
sh                           se7712_defconfig    gcc-14.2.0
sh                           se7722_defconfig    gcc-14.2.0
sh                           se7750_defconfig    gcc-14.2.0
sh                           se7751_defconfig    clang-20
sh                           se7780_defconfig    gcc-14.2.0
sh                   secureedge5410_defconfig    clang-20
sh                   secureedge5410_defconfig    gcc-14.2.0
sh                             sh03_defconfig    clang-20
sh                            shmin_defconfig    clang-20
sh                            shmin_defconfig    gcc-14.2.0
sh                            titan_defconfig    clang-20
sh                              ul2_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                       sparc32_defconfig    gcc-14.2.0
um                               alldefconfig    gcc-14.2.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-17
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                               allyesconfig    gcc-12
um                             i386_defconfig    gcc-14.2.0
x86_64                           alldefconfig    gcc-12
x86_64      buildonly-randconfig-001-20241203    clang-19
x86_64      buildonly-randconfig-001-20241204    clang-19
x86_64      buildonly-randconfig-002-20241203    clang-19
x86_64      buildonly-randconfig-002-20241204    clang-19
x86_64      buildonly-randconfig-003-20241203    clang-19
x86_64      buildonly-randconfig-003-20241204    clang-19
x86_64      buildonly-randconfig-004-20241203    gcc-11
x86_64      buildonly-randconfig-004-20241204    clang-19
x86_64      buildonly-randconfig-005-20241203    gcc-12
x86_64      buildonly-randconfig-005-20241204    clang-19
x86_64      buildonly-randconfig-006-20241203    clang-19
x86_64      buildonly-randconfig-006-20241204    clang-19
xtensa                            allnoconfig    gcc-14.2.0
xtensa                  nommu_kc705_defconfig    clang-20
xtensa                  nommu_kc705_defconfig    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

