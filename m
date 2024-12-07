Return-Path: <linux-wireless+bounces-15995-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB87B9E7F08
	for <lists+linux-wireless@lfdr.de>; Sat,  7 Dec 2024 09:34:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64B591881CFC
	for <lists+linux-wireless@lfdr.de>; Sat,  7 Dec 2024 08:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7683118638;
	Sat,  7 Dec 2024 08:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CaABwMmI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2DD055896
	for <linux-wireless@vger.kernel.org>; Sat,  7 Dec 2024 08:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733560458; cv=none; b=P0I0u6ijEMBQpPQb6YivUWVg4w/QlI6rTcEyyrJnoVTETRIf66abdJHhzxAHNA/1X4CwaMnjaC0HbBybYGATU4fUUHc+qFIh64oJrkjMPys/6lJ3Q5puAEblGNH9bciP96ImwMMtd/G84LaUfjp9djy7vCIGKoSo1wsqWYa0fJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733560458; c=relaxed/simple;
	bh=Cp3VSIOrFDlzj0yhxlnTs+dXshQGll4ikJVk6P1BeWs=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Y/kqy+buPCVAqejWuGKFmXenT7gPbhNyIvfa5GYCv/7eDqFOcD/VMAfJ/O3CwDhQhezicdRk5/uPNyca1dDw6OKtIlc9B3NZu+7xKVuRUVJbWxNNaVBIRbhb9TaNuGAVu3uXvwBaYAzFCTjPsPLecz87OLzQM9NRGbbp0kcnbqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CaABwMmI; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733560455; x=1765096455;
  h=date:from:to:cc:subject:message-id;
  bh=Cp3VSIOrFDlzj0yhxlnTs+dXshQGll4ikJVk6P1BeWs=;
  b=CaABwMmIf6sYd/DnMt3tEfahk150FP5jWvBk04nFjdPrgFEo1FFP93VQ
   vWNNDBrc8o4tfzTgaGGKaM/nA29Cx5CHZa7Y5jDN5hNGaTlDP2KHmikKB
   PkketOqm4cFs7g2TiMMHD/GChVoR88LG7CY2wRIlYNkGB3400Hnd/vchl
   ZwO9HoWr+GdQf15mHSI9f0zAz3V7NEzIjIZbvVDpCBHoelIiWUjcgBKn/
   FvaXqZttuc1xroUeXge/lQ1bTCn97J9NN0Vs1qiF1RWNhMu7spkxEKu9D
   F1uoH8SVvZZTGi+cG1Lwx5F9W3IgYVM2yfOzec9GPaVLIv/95TNvnHX/P
   w==;
X-CSE-ConnectionGUID: YjiQAXC0QDqhqNAbj/i/yg==
X-CSE-MsgGUID: N9Pu7xlUQ4K4b6OT4el1kg==
X-IronPort-AV: E=McAfee;i="6700,10204,11278"; a="37849354"
X-IronPort-AV: E=Sophos;i="6.12,215,1728975600"; 
   d="scan'208";a="37849354"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2024 00:34:15 -0800
X-CSE-ConnectionGUID: TJNm6rf5RkKwJpIJQWRP9w==
X-CSE-MsgGUID: WJDjzTTIRMOTchH4sbJpMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,215,1728975600"; 
   d="scan'208";a="117867686"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 07 Dec 2024 00:34:13 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tJqGR-0002Zt-25;
	Sat, 07 Dec 2024 08:34:11 +0000
Date: Sat, 07 Dec 2024 16:30:20 +0800
From: kernel test robot <lkp@intel.com>
To: Johannes Berg <johannes.berg@intel.com>
Cc: Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org
Subject: [wireless:for-next] BUILD SUCCESS
 f1d3334d604cc32db63f6e2b3283011e02294e54
Message-ID: <202412071610.dEomiOXQ-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git for-next
branch HEAD: f1d3334d604cc32db63f6e2b3283011e02294e54  wifi: cfg80211: sme: init n_channels before channels[] access

elapsed time: 1360m

configs tested: 362
configs skipped: 20

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            alldefconfig    clang-15
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    clang-20
alpha                            allyesconfig    gcc-14.2.0
alpha                               defconfig    gcc-14.2.0
arc                              alldefconfig    clang-20
arc                              allmodconfig    clang-18
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-18
arc                              allyesconfig    gcc-13.2.0
arc                                 defconfig    gcc-14.2.0
arc                         haps_hs_defconfig    gcc-13.2.0
arc                            hsdk_defconfig    gcc-14.2.0
arc                     nsimosci_hs_defconfig    gcc-13.2.0
arc                   randconfig-001-20241206    gcc-13.2.0
arc                   randconfig-001-20241206    gcc-14.2.0
arc                   randconfig-001-20241207    clang-19
arc                   randconfig-002-20241206    gcc-13.2.0
arc                   randconfig-002-20241206    gcc-14.2.0
arc                   randconfig-002-20241207    clang-19
arc                        vdk_hs38_defconfig    clang-20
arm                              allmodconfig    clang-18
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    clang-20
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-18
arm                              allyesconfig    gcc-14.2.0
arm                       aspeed_g5_defconfig    gcc-14.2.0
arm                         axm55xx_defconfig    clang-20
arm                          collie_defconfig    gcc-14.2.0
arm                     davinci_all_defconfig    clang-20
arm                                 defconfig    gcc-14.2.0
arm                            dove_defconfig    gcc-14.2.0
arm                          gemini_defconfig    clang-15
arm                          gemini_defconfig    clang-20
arm                            hisi_defconfig    gcc-14.2.0
arm                           imxrt_defconfig    gcc-13.2.0
arm                         lpc18xx_defconfig    gcc-14.2.0
arm                            mmp2_defconfig    gcc-14.2.0
arm                            mps2_defconfig    clang-15
arm                            mps2_defconfig    clang-20
arm                        multi_v5_defconfig    clang-20
arm                        multi_v5_defconfig    gcc-14.2.0
arm                       netwinder_defconfig    gcc-14.2.0
arm                           omap1_defconfig    clang-20
arm                           omap1_defconfig    gcc-14.2.0
arm                         orion5x_defconfig    clang-20
arm                          pxa168_defconfig    clang-20
arm                   randconfig-001-20241206    gcc-14.2.0
arm                   randconfig-001-20241207    clang-19
arm                   randconfig-002-20241206    gcc-14.2.0
arm                   randconfig-002-20241207    clang-19
arm                   randconfig-003-20241206    gcc-14.2.0
arm                   randconfig-003-20241207    clang-19
arm                   randconfig-004-20241206    clang-20
arm                   randconfig-004-20241206    gcc-14.2.0
arm                   randconfig-004-20241207    clang-19
arm                        realview_defconfig    clang-20
arm                             rpc_defconfig    gcc-14.2.0
arm                           sama7_defconfig    clang-20
arm                        shmobile_defconfig    gcc-14.2.0
arm                           stm32_defconfig    gcc-14.2.0
arm                           u8500_defconfig    gcc-13.2.0
arm                         vf610m4_defconfig    clang-17
arm64                            alldefconfig    clang-20
arm64                            allmodconfig    clang-18
arm64                             allnoconfig    gcc-14.2.0
arm64                               defconfig    gcc-14.2.0
arm64                 randconfig-001-20241206    clang-14
arm64                 randconfig-001-20241206    gcc-14.2.0
arm64                 randconfig-001-20241207    clang-19
arm64                 randconfig-002-20241206    gcc-14.2.0
arm64                 randconfig-002-20241207    clang-19
arm64                 randconfig-003-20241206    clang-20
arm64                 randconfig-003-20241206    gcc-14.2.0
arm64                 randconfig-003-20241207    clang-19
arm64                 randconfig-004-20241206    clang-20
arm64                 randconfig-004-20241206    gcc-14.2.0
arm64                 randconfig-004-20241207    clang-19
csky                              allnoconfig    gcc-14.2.0
csky                                defconfig    gcc-14.2.0
csky                  randconfig-001-20241206    gcc-14.2.0
csky                  randconfig-001-20241207    clang-19
csky                  randconfig-002-20241206    gcc-14.2.0
csky                  randconfig-002-20241207    clang-19
hexagon                          alldefconfig    clang-20
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    clang-20
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-20
hexagon                             defconfig    gcc-14.2.0
hexagon               randconfig-001-20241206    gcc-14.2.0
hexagon               randconfig-001-20241207    clang-19
hexagon               randconfig-002-20241206    gcc-14.2.0
hexagon               randconfig-002-20241207    clang-19
i386                             allmodconfig    clang-19
i386                              allnoconfig    clang-19
i386                             allyesconfig    clang-19
i386                 buildonly-randconfig-001    gcc-12
i386        buildonly-randconfig-001-20241206    clang-19
i386        buildonly-randconfig-001-20241207    clang-19
i386                 buildonly-randconfig-002    gcc-12
i386        buildonly-randconfig-002-20241206    clang-19
i386        buildonly-randconfig-002-20241206    gcc-12
i386        buildonly-randconfig-002-20241207    clang-19
i386                 buildonly-randconfig-003    gcc-12
i386        buildonly-randconfig-003-20241206    clang-19
i386        buildonly-randconfig-003-20241206    gcc-12
i386        buildonly-randconfig-003-20241207    clang-19
i386                 buildonly-randconfig-004    gcc-12
i386        buildonly-randconfig-004-20241206    clang-19
i386        buildonly-randconfig-004-20241206    gcc-12
i386        buildonly-randconfig-004-20241207    clang-19
i386                 buildonly-randconfig-005    gcc-12
i386        buildonly-randconfig-005-20241206    clang-19
i386        buildonly-randconfig-005-20241207    clang-19
i386                 buildonly-randconfig-006    gcc-12
i386        buildonly-randconfig-006-20241206    clang-19
i386        buildonly-randconfig-006-20241206    gcc-12
i386        buildonly-randconfig-006-20241207    clang-19
i386                                defconfig    clang-19
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch                           defconfig    gcc-14.2.0
loongarch             randconfig-001-20241206    gcc-14.2.0
loongarch             randconfig-001-20241207    clang-19
loongarch             randconfig-002-20241206    gcc-14.2.0
loongarch             randconfig-002-20241207    clang-19
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
m68k                          amiga_defconfig    gcc-14.2.0
m68k                         apollo_defconfig    gcc-14.2.0
m68k                          atari_defconfig    gcc-14.2.0
m68k                                defconfig    gcc-14.2.0
m68k                            mac_defconfig    gcc-14.2.0
m68k                          multi_defconfig    gcc-13.2.0
m68k                          multi_defconfig    gcc-14.2.0
m68k                        mvme16x_defconfig    gcc-14.2.0
m68k                            q40_defconfig    clang-20
m68k                        stmark2_defconfig    clang-20
m68k                           sun3_defconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
microblaze                          defconfig    gcc-14.2.0
microblaze                      mmu_defconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                          ath25_defconfig    clang-20
mips                          ath79_defconfig    gcc-14.2.0
mips                        bcm47xx_defconfig    gcc-14.2.0
mips                           ip27_defconfig    gcc-14.2.0
mips                     loongson1b_defconfig    clang-15
mips                        maltaup_defconfig    clang-17
mips                           mtx1_defconfig    gcc-14.2.0
mips                        omega2p_defconfig    gcc-14.2.0
mips                        qi_lb60_defconfig    clang-20
mips                          rb532_defconfig    clang-17
mips                   sb1250_swarm_defconfig    clang-20
mips                   sb1250_swarm_defconfig    gcc-14.2.0
nios2                         3c120_defconfig    gcc-14.2.0
nios2                             allnoconfig    gcc-14.2.0
nios2                               defconfig    gcc-14.2.0
nios2                 randconfig-001-20241206    gcc-14.2.0
nios2                 randconfig-001-20241207    clang-19
nios2                 randconfig-002-20241206    gcc-14.2.0
nios2                 randconfig-002-20241207    clang-19
openrisc                          allnoconfig    clang-20
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-12
openrisc                  or1klitex_defconfig    gcc-14.2.0
openrisc                 simple_smp_defconfig    clang-20
openrisc                 simple_smp_defconfig    gcc-13.2.0
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-20
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-12
parisc                generic-64bit_defconfig    gcc-14.2.0
parisc                randconfig-001-20241206    gcc-14.2.0
parisc                randconfig-001-20241207    clang-19
parisc                randconfig-002-20241206    gcc-14.2.0
parisc                randconfig-002-20241207    clang-19
parisc64                         alldefconfig    clang-20
parisc64                            defconfig    gcc-14.2.0
powerpc                    adder875_defconfig    clang-15
powerpc                     akebono_defconfig    clang-17
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-20
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-20
powerpc                          allyesconfig    gcc-14.2.0
powerpc                      arches_defconfig    clang-20
powerpc                      arches_defconfig    gcc-14.2.0
powerpc                      bamboo_defconfig    gcc-14.2.0
powerpc                   bluestone_defconfig    gcc-13.2.0
powerpc                      cm5200_defconfig    clang-20
powerpc                   currituck_defconfig    clang-15
powerpc                   currituck_defconfig    gcc-14.2.0
powerpc                       ebony_defconfig    clang-18
powerpc                       eiger_defconfig    gcc-14.2.0
powerpc                     ep8248e_defconfig    clang-20
powerpc                    gamecube_defconfig    clang-20
powerpc                    ge_imp3a_defconfig    clang-20
powerpc                    ge_imp3a_defconfig    gcc-13.2.0
powerpc                    ge_imp3a_defconfig    gcc-14.2.0
powerpc                       holly_defconfig    clang-20
powerpc                       holly_defconfig    gcc-14.2.0
powerpc                        icon_defconfig    clang-20
powerpc                      mgcoge_defconfig    gcc-14.2.0
powerpc                 mpc8313_rdb_defconfig    gcc-13.2.0
powerpc                 mpc8315_rdb_defconfig    gcc-14.2.0
powerpc                 mpc832x_rdb_defconfig    clang-20
powerpc                 mpc832x_rdb_defconfig    gcc-13.2.0
powerpc                 mpc837x_rdb_defconfig    clang-20
powerpc                  mpc866_ads_defconfig    clang-20
powerpc                    mvme5100_defconfig    gcc-14.2.0
powerpc                      pmac32_defconfig    clang-15
powerpc                       ppc64_defconfig    clang-18
powerpc                      ppc6xx_defconfig    gcc-14.2.0
powerpc                         ps3_defconfig    gcc-14.2.0
powerpc                     rainier_defconfig    gcc-14.2.0
powerpc               randconfig-001-20241206    gcc-14.2.0
powerpc               randconfig-001-20241207    clang-19
powerpc               randconfig-002-20241206    gcc-14.2.0
powerpc               randconfig-002-20241207    clang-19
powerpc               randconfig-003-20241206    gcc-14.2.0
powerpc               randconfig-003-20241207    clang-19
powerpc                     redwood_defconfig    gcc-14.2.0
powerpc                    sam440ep_defconfig    gcc-14.2.0
powerpc                     skiroot_defconfig    gcc-14.2.0
powerpc                    socrates_defconfig    gcc-14.2.0
powerpc                     tqm8540_defconfig    clang-20
powerpc                     tqm8540_defconfig    gcc-14.2.0
powerpc                     tqm8541_defconfig    clang-20
powerpc                     tqm8541_defconfig    gcc-14.2.0
powerpc                     tqm8560_defconfig    clang-20
powerpc                 xes_mpc85xx_defconfig    gcc-14.2.0
powerpc64                        alldefconfig    clang-18
powerpc64             randconfig-001-20241207    clang-19
powerpc64             randconfig-002-20241206    gcc-14.2.0
powerpc64             randconfig-002-20241207    clang-19
powerpc64             randconfig-003-20241206    gcc-14.2.0
powerpc64             randconfig-003-20241207    clang-19
riscv                            allmodconfig    clang-20
riscv                            allmodconfig    gcc-14.2.0
riscv                             allnoconfig    clang-20
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-20
riscv                            allyesconfig    gcc-14.2.0
riscv                               defconfig    gcc-12
riscv                               defconfig    gcc-13.2.0
riscv                    nommu_virt_defconfig    gcc-14.2.0
riscv                 randconfig-001-20241206    gcc-14.2.0
riscv                 randconfig-001-20241207    gcc-14.2.0
riscv                 randconfig-002-20241206    gcc-14.2.0
riscv                 randconfig-002-20241207    gcc-14.2.0
s390                             allmodconfig    clang-20
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    gcc-12
s390                                defconfig    gcc-14.2.0
s390                  randconfig-001-20241206    gcc-14.2.0
s390                  randconfig-001-20241207    gcc-14.2.0
s390                  randconfig-002-20241206    gcc-14.2.0
s390                  randconfig-002-20241207    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                         ap325rxa_defconfig    clang-17
sh                         apsh4a3a_defconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                        dreamcast_defconfig    clang-18
sh                ecovec24-romimage_defconfig    gcc-13.2.0
sh                         ecovec24_defconfig    clang-20
sh                        edosk7705_defconfig    gcc-14.2.0
sh                        edosk7760_defconfig    gcc-14.2.0
sh                             espt_defconfig    gcc-14.2.0
sh                          kfr2r09_defconfig    clang-20
sh                          landisk_defconfig    clang-20
sh                          lboxre2_defconfig    gcc-14.2.0
sh                          polaris_defconfig    gcc-14.2.0
sh                          r7780mp_defconfig    clang-18
sh                    randconfig-001-20241206    gcc-14.2.0
sh                    randconfig-001-20241207    gcc-14.2.0
sh                    randconfig-002-20241206    gcc-14.2.0
sh                    randconfig-002-20241207    gcc-14.2.0
sh                          rsk7269_defconfig    clang-18
sh                          rsk7269_defconfig    clang-20
sh                      rts7751r2d1_defconfig    clang-20
sh                   rts7751r2dplus_defconfig    gcc-14.2.0
sh                          sdk7786_defconfig    gcc-14.2.0
sh                           se7206_defconfig    clang-20
sh                           se7343_defconfig    clang-15
sh                           se7343_defconfig    clang-20
sh                           se7722_defconfig    gcc-14.2.0
sh                           se7724_defconfig    gcc-14.2.0
sh                   secureedge5410_defconfig    clang-18
sh                   secureedge5410_defconfig    gcc-14.2.0
sh                           sh2007_defconfig    gcc-14.2.0
sh                        sh7763rdp_defconfig    clang-20
sh                  sh7785lcr_32bit_defconfig    gcc-14.2.0
sh                            titan_defconfig    gcc-14.2.0
sparc                            allmodconfig    gcc-14.2.0
sparc                             allnoconfig    gcc-14.2.0
sparc                 randconfig-001-20241206    gcc-14.2.0
sparc                 randconfig-001-20241207    gcc-14.2.0
sparc                 randconfig-002-20241206    gcc-14.2.0
sparc                 randconfig-002-20241207    gcc-14.2.0
sparc                       sparc32_defconfig    gcc-14.2.0
sparc64                          alldefconfig    gcc-14.2.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20241206    gcc-14.2.0
sparc64               randconfig-001-20241207    gcc-14.2.0
sparc64               randconfig-002-20241206    gcc-14.2.0
sparc64               randconfig-002-20241207    gcc-14.2.0
um                               alldefconfig    gcc-14.2.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-17
um                                allnoconfig    clang-20
um                               allyesconfig    clang-20
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20241206    gcc-14.2.0
um                    randconfig-001-20241207    gcc-14.2.0
um                    randconfig-002-20241206    gcc-14.2.0
um                           x86_64_defconfig    gcc-12
um                           x86_64_defconfig    gcc-13.2.0
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20241206    clang-19
x86_64      buildonly-randconfig-001-20241206    gcc-12
x86_64      buildonly-randconfig-001-20241207    clang-19
x86_64      buildonly-randconfig-002-20241206    clang-19
x86_64      buildonly-randconfig-002-20241206    gcc-12
x86_64      buildonly-randconfig-002-20241207    clang-19
x86_64      buildonly-randconfig-003-20241206    clang-19
x86_64      buildonly-randconfig-003-20241206    gcc-12
x86_64      buildonly-randconfig-003-20241207    clang-19
x86_64      buildonly-randconfig-004-20241206    clang-19
x86_64      buildonly-randconfig-004-20241207    clang-19
x86_64      buildonly-randconfig-005-20241206    clang-19
x86_64      buildonly-randconfig-005-20241206    gcc-11
x86_64      buildonly-randconfig-005-20241207    clang-19
x86_64      buildonly-randconfig-006-20241206    clang-19
x86_64      buildonly-randconfig-006-20241207    clang-19
x86_64                              defconfig    clang-19
xtensa                            allnoconfig    gcc-14.2.0
xtensa                  audio_kc705_defconfig    gcc-14.2.0
xtensa                       common_defconfig    gcc-13.2.0
xtensa                generic_kc705_defconfig    clang-20
xtensa                  nommu_kc705_defconfig    gcc-14.2.0
xtensa                randconfig-001-20241206    gcc-14.2.0
xtensa                randconfig-001-20241207    gcc-14.2.0
xtensa                randconfig-002-20241206    gcc-14.2.0
xtensa                randconfig-002-20241207    gcc-14.2.0
xtensa                    xip_kc705_defconfig    gcc-14.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

