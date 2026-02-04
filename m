Return-Path: <linux-wireless+bounces-31519-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qGPIK0cNg2k+hAMAu9opvQ
	(envelope-from <linux-wireless+bounces-31519-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Feb 2026 10:11:35 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F0B5E39D8
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Feb 2026 10:11:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4611B301159A
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Feb 2026 09:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0575639A808;
	Wed,  4 Feb 2026 09:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RQBgWpxM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B767C261B91
	for <linux-wireless@vger.kernel.org>; Wed,  4 Feb 2026 09:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770195975; cv=none; b=oyN65RKyiVjPEpLFNAlsXhfPBI35mnuzPa+YQ/wh5hIc7wM+zq1ewBRPlYEcFyIW+RSTj+wufZZxhvhH/vM7w9u46mkXFwrJcguVbMg4ffEfqPN9QVfIL0jE9bwEisgHP23n9xQT0vrUFjGniteV7JKaq0BA8ZIR7MtGv4UzNic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770195975; c=relaxed/simple;
	bh=Ck709aiRHjSN3AF32YrW0FsRjRR3iKkiE3SYaClF7kc=;
	h=Date:From:To:Cc:Subject:Message-ID; b=UkzvaFcBEUp233qKsv/NvL/0WwQa6OF8jx5jYLnWFhlgV+d4utsruoN/mGMmqwhfcz5CTA9KcJeNOpCgAmmosuj6MiyGfvl2NWWngb4Q2iSERNa1jE7olUvIw1dvyzKX5aWbVARtVTMsGTs/CRpltT9yhH5js2DPVsMmRzmBR4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RQBgWpxM; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770195976; x=1801731976;
  h=date:from:to:cc:subject:message-id;
  bh=Ck709aiRHjSN3AF32YrW0FsRjRR3iKkiE3SYaClF7kc=;
  b=RQBgWpxMmo38/34oDNgEHqkePcHSu5zCdj9gGmZs4vcmdUgjsppYEzbF
   T7Kl2MPFuf36b7RSn9B++3uD3OjhVO7hIjfUC8gMKBK2d7zJVXlGXbu6P
   x0Jvp3hzgn9lQqXynyFP2w2F+nsCBO6+nlw0aillLKg7twYoxkBVcCxH1
   vpmsYjT8rPzVLlcIhcuNr576H+YCu2EnKLqeOh3ephsYbnOlgGU343ijc
   qa93xu2EETD1CrZ+lSuC+dV2gKTRWUSgzncoK4JS+E36F3HRSSFRnDEIX
   rnlk82ievTLzajM8f5YpSa4hW/cjBzlMKx4yn32LQFDpzvIz91hZch22X
   Q==;
X-CSE-ConnectionGUID: qG25rJHBR8K613/g4Yf48g==
X-CSE-MsgGUID: 4Hry1a0eTWKi76DXV67oBQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="70397824"
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; 
   d="scan'208";a="70397824"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2026 01:06:15 -0800
X-CSE-ConnectionGUID: Yp4QkCgtTO2MtFov83/K9w==
X-CSE-MsgGUID: DR9GqlLdRkeDg0fX5rAaKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,272,1763452800"; 
   d="scan'208";a="214641957"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 04 Feb 2026 01:06:14 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vnYpv-00000000hcg-12uZ;
	Wed, 04 Feb 2026 09:06:11 +0000
Date: Wed, 04 Feb 2026 17:05:34 +0800
From: kernel test robot <lkp@intel.com>
To: Johannes Berg <johannes.berg@intel.com>
Cc: linux-wireless@vger.kernel.org
Subject: [wireless-next:main] BUILD SUCCESS
 9825fa8f49905275acef6c8e7fcd017d04616311
Message-ID: <202602041726.LAHeSk6m-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31519-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:mid,intel.com:dkim]
X-Rspamd-Queue-Id: 0F0B5E39D8
X-Rspamd-Action: no action

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: 9825fa8f49905275acef6c8e7fcd017d04616311  wifi: brcmsmac: phy: Remove unreachable error handling code

elapsed time: 1223m

configs tested: 277
configs skipped: 5

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-22
arc                          axs101_defconfig    gcc-15.2.0
arc                          axs103_defconfig    clang-22
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260203    gcc-12.5.0
arc                   randconfig-001-20260203    gcc-8.5.0
arc                   randconfig-001-20260204    gcc-8.5.0
arc                   randconfig-002-20260203    gcc-12.5.0
arc                   randconfig-002-20260204    gcc-8.5.0
arm                              alldefconfig    gcc-15.2.0
arm                               allnoconfig    clang-22
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.2.0
arm                                 defconfig    gcc-15.2.0
arm                          ep93xx_defconfig    gcc-15.2.0
arm                         lpc32xx_defconfig    gcc-15.2.0
arm                          moxart_defconfig    clang-22
arm                        mvebu_v5_defconfig    gcc-15.2.0
arm                        mvebu_v7_defconfig    clang-22
arm                           omap1_defconfig    gcc-15.2.0
arm                          pxa910_defconfig    gcc-15.2.0
arm                            qcom_defconfig    gcc-15.2.0
arm                   randconfig-001-20260203    gcc-12.5.0
arm                   randconfig-001-20260203    gcc-8.5.0
arm                   randconfig-001-20260204    gcc-8.5.0
arm                   randconfig-002-20260203    clang-18
arm                   randconfig-002-20260203    gcc-12.5.0
arm                   randconfig-002-20260204    gcc-8.5.0
arm                   randconfig-003-20260203    gcc-10.5.0
arm                   randconfig-003-20260203    gcc-12.5.0
arm                   randconfig-003-20260204    gcc-8.5.0
arm                   randconfig-004-20260203    clang-16
arm                   randconfig-004-20260203    gcc-12.5.0
arm                   randconfig-004-20260204    gcc-8.5.0
arm                         socfpga_defconfig    gcc-15.2.0
arm                        spear3xx_defconfig    gcc-15.2.0
arm                           sunxi_defconfig    gcc-15.2.0
arm                       versatile_defconfig    gcc-15.2.0
arm                        vexpress_defconfig    gcc-15.2.0
arm64                            allmodconfig    clang-22
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260204    gcc-11.5.0
arm64                 randconfig-002-20260204    gcc-11.5.0
arm64                 randconfig-003-20260204    gcc-11.5.0
arm64                 randconfig-004-20260204    gcc-11.5.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260204    gcc-11.5.0
csky                  randconfig-002-20260204    gcc-11.5.0
hexagon                          alldefconfig    gcc-15.2.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-22
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260204    gcc-15.2.0
hexagon               randconfig-002-20260204    gcc-15.2.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260203    gcc-14
i386        buildonly-randconfig-001-20260204    gcc-14
i386        buildonly-randconfig-002-20260203    gcc-13
i386        buildonly-randconfig-002-20260204    gcc-14
i386        buildonly-randconfig-003-20260203    clang-20
i386        buildonly-randconfig-003-20260204    gcc-14
i386        buildonly-randconfig-004-20260203    clang-20
i386        buildonly-randconfig-004-20260204    gcc-14
i386        buildonly-randconfig-005-20260203    clang-20
i386        buildonly-randconfig-005-20260204    gcc-14
i386        buildonly-randconfig-006-20260203    clang-20
i386        buildonly-randconfig-006-20260204    gcc-14
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260204    gcc-14
i386                  randconfig-002-20260204    gcc-14
i386                  randconfig-003-20260204    clang-20
i386                  randconfig-003-20260204    gcc-14
i386                  randconfig-004-20260204    gcc-12
i386                  randconfig-004-20260204    gcc-14
i386                  randconfig-005-20260204    gcc-14
i386                  randconfig-006-20260204    gcc-14
i386                  randconfig-007-20260204    gcc-14
i386                  randconfig-011-20260203    gcc-14
i386                  randconfig-011-20260204    clang-20
i386                  randconfig-012-20260203    gcc-14
i386                  randconfig-012-20260204    clang-20
i386                  randconfig-012-20260204    gcc-14
i386                  randconfig-013-20260203    gcc-14
i386                  randconfig-013-20260204    clang-20
i386                  randconfig-014-20260203    gcc-14
i386                  randconfig-014-20260204    clang-20
i386                  randconfig-015-20260203    gcc-14
i386                  randconfig-015-20260204    clang-20
i386                  randconfig-015-20260204    gcc-13
i386                  randconfig-016-20260203    gcc-14
i386                  randconfig-016-20260204    clang-20
i386                  randconfig-017-20260203    gcc-14
i386                  randconfig-017-20260204    clang-20
loongarch                        allmodconfig    clang-22
loongarch                         allnoconfig    clang-22
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260204    gcc-15.2.0
loongarch             randconfig-002-20260204    gcc-15.2.0
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                             allyesconfig    gcc-15.2.0
m68k                                defconfig    clang-19
m68k                        m5272c3_defconfig    clang-22
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                          ath79_defconfig    gcc-15.2.0
mips                          eyeq5_defconfig    gcc-15.2.0
mips                            gpr_defconfig    clang-22
mips                      malta_kvm_defconfig    clang-22
mips                        vocore2_defconfig    clang-22
nios2                         10m50_defconfig    clang-22
nios2                         10m50_defconfig    gcc-15.2.0
nios2                            allmodconfig    clang-22
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260204    gcc-15.2.0
nios2                 randconfig-002-20260204    gcc-15.2.0
openrisc                         alldefconfig    gcc-15.2.0
openrisc                         allmodconfig    clang-22
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
openrisc                    or1ksim_defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    clang-19
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260204    gcc-8.5.0
parisc                randconfig-002-20260204    gcc-8.5.0
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.2.0
powerpc                      bamboo_defconfig    gcc-15.2.0
powerpc                      cm5200_defconfig    clang-22
powerpc                     ep8248e_defconfig    gcc-15.2.0
powerpc                        icon_defconfig    clang-22
powerpc                     kmeter1_defconfig    clang-22
powerpc               randconfig-001-20260204    gcc-8.5.0
powerpc               randconfig-002-20260204    gcc-8.5.0
powerpc                     redwood_defconfig    clang-22
powerpc                     tqm8541_defconfig    gcc-15.2.0
powerpc64                        alldefconfig    clang-22
powerpc64             randconfig-001-20260204    gcc-8.5.0
powerpc64             randconfig-002-20260204    gcc-8.5.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                    nommu_k210_defconfig    gcc-15.2.0
riscv             nommu_k210_sdcard_defconfig    clang-22
riscv                 randconfig-001-20260203    gcc-8.5.0
riscv                 randconfig-001-20260204    gcc-8.5.0
riscv                 randconfig-002-20260203    gcc-8.5.0
riscv                 randconfig-002-20260204    gcc-8.5.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260203    gcc-8.5.0
s390                  randconfig-001-20260204    gcc-8.5.0
s390                  randconfig-002-20260203    gcc-8.5.0
s390                  randconfig-002-20260204    gcc-8.5.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-22
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sh                          lboxre2_defconfig    gcc-15.2.0
sh                    randconfig-001-20260203    gcc-8.5.0
sh                    randconfig-001-20260204    gcc-8.5.0
sh                    randconfig-002-20260203    gcc-8.5.0
sh                    randconfig-002-20260204    gcc-8.5.0
sh                          rsk7201_defconfig    clang-22
sh                     sh7710voipgw_defconfig    gcc-15.2.0
sh                   sh7724_generic_defconfig    gcc-15.2.0
sh                            shmin_defconfig    gcc-15.2.0
sparc                             allnoconfig    clang-22
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260204    gcc-8.5.0
sparc                 randconfig-002-20260204    gcc-8.5.0
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260204    gcc-8.5.0
sparc64               randconfig-002-20260204    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                             i386_defconfig    gcc-15.2.0
um                    randconfig-001-20260204    gcc-8.5.0
um                    randconfig-002-20260204    gcc-8.5.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-22
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260203    clang-20
x86_64      buildonly-randconfig-001-20260204    clang-20
x86_64      buildonly-randconfig-002-20260203    clang-20
x86_64      buildonly-randconfig-002-20260204    clang-20
x86_64      buildonly-randconfig-003-20260203    clang-20
x86_64      buildonly-randconfig-003-20260204    clang-20
x86_64      buildonly-randconfig-004-20260203    clang-20
x86_64      buildonly-randconfig-004-20260204    clang-20
x86_64      buildonly-randconfig-005-20260203    clang-20
x86_64      buildonly-randconfig-005-20260204    clang-20
x86_64      buildonly-randconfig-006-20260203    clang-20
x86_64      buildonly-randconfig-006-20260204    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260204    gcc-14
x86_64                randconfig-002-20260204    gcc-14
x86_64                randconfig-003-20260204    gcc-14
x86_64                randconfig-004-20260204    gcc-14
x86_64                randconfig-005-20260204    gcc-14
x86_64                randconfig-006-20260204    gcc-14
x86_64                randconfig-011-20260204    clang-20
x86_64                randconfig-012-20260204    clang-20
x86_64                randconfig-013-20260204    clang-20
x86_64                randconfig-014-20260204    clang-20
x86_64                randconfig-015-20260204    clang-20
x86_64                randconfig-016-20260204    clang-20
x86_64                randconfig-071-20260204    gcc-14
x86_64                randconfig-072-20260204    gcc-14
x86_64                randconfig-073-20260204    gcc-14
x86_64                randconfig-074-20260204    gcc-14
x86_64                randconfig-075-20260204    gcc-14
x86_64                randconfig-076-20260204    gcc-14
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-22
xtensa                            allnoconfig    gcc-15.2.0
xtensa                           allyesconfig    clang-22
xtensa                           allyesconfig    gcc-15.2.0
xtensa                          iss_defconfig    gcc-15.2.0
xtensa                randconfig-001-20260204    gcc-8.5.0
xtensa                randconfig-002-20260204    gcc-8.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

