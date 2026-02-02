Return-Path: <linux-wireless+bounces-31484-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YGY4JDA2gWmUEwMAu9opvQ
	(envelope-from <linux-wireless+bounces-31484-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 03 Feb 2026 00:41:36 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EA517D2B30
	for <lists+linux-wireless@lfdr.de>; Tue, 03 Feb 2026 00:41:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 924093014579
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Feb 2026 23:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C50328263;
	Mon,  2 Feb 2026 23:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O0NF/vV1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3352D199252
	for <linux-wireless@vger.kernel.org>; Mon,  2 Feb 2026 23:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770075693; cv=none; b=JuKnNFaUrHGQKwa+ZTm23b8nsM8ET+WKlpAtAWsNmXBy9iBp9L/lRmWl4lcrXCLpy3Kd2VUFWb6wYaIQ5BMu38aUCD0wGinvijJS5SkaaOLQLQNedb9LvVozX7Vav8MwCDtrsz06r5RAOyqXiKsbSTGVu19XXZuBlQSuFbqwnow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770075693; c=relaxed/simple;
	bh=tceyKsQN268o83KjLnLqc86MQV2h2+NgXWrym9C0yMA=;
	h=Date:From:To:Cc:Subject:Message-ID; b=WqftSosEcrJgoHpbtwEvgi1Ilb9qQei9l7iOL6enAwUKvTLXLQsI5fBc68Sby7P1SZBss14gb+0Tkur3PtF8GbV6lU380M+NUsO+LkTCHjMGO9tsRi84pP+NyiwV6blxxmSxoZGp70GVvKwoQE823CLjozOTpXMYYIbfUd3nFIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O0NF/vV1; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770075691; x=1801611691;
  h=date:from:to:cc:subject:message-id;
  bh=tceyKsQN268o83KjLnLqc86MQV2h2+NgXWrym9C0yMA=;
  b=O0NF/vV1xEYzyHWMkt889/6a1rFUwoqyVbXOyUf8n3fgwoHE9+kB5j2/
   CX/gg/9L0SKIoSsIAIarFCkpQjr3m8aRmA6bAMY+hRcVqIkTVsMwEeY9I
   +qPbdaZ40Q9ttIi9Lybi8tKduV+AigMhS0jzpdZz4V1yvabVSb6pioHhM
   o4Svax31/EEe3acX49FZIwsSgQhsgbQBKeiC7BGBcyIMoM6Qy23DTDtsB
   ddGiBMNfIb6pk7zLYGHOuSIgg9URVKyL+YtWmd6uxTzWDw4KH4ey0T92M
   zX4KxEYXohKoI63AgcpM9kB86wThrIDXDP0BoW9HJCBC6qOESPDxDW2H7
   Q==;
X-CSE-ConnectionGUID: RkL6dD0sRTyoYTV2LOQXSQ==
X-CSE-MsgGUID: GVVb2FM6TK23vogm8txAJg==
X-IronPort-AV: E=McAfee;i="6800,10657,11690"; a="75096541"
X-IronPort-AV: E=Sophos;i="6.21,269,1763452800"; 
   d="scan'208";a="75096541"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2026 15:41:31 -0800
X-CSE-ConnectionGUID: KBOF/BoWRD2++9R3CF7mZw==
X-CSE-MsgGUID: msWRRhzsR7q/qr92LTLB2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,269,1763452800"; 
   d="scan'208";a="209133492"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 02 Feb 2026 15:41:29 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vn3Xq-00000000g33-3L6g;
	Mon, 02 Feb 2026 23:41:26 +0000
Date: Tue, 03 Feb 2026 07:40:49 +0800
From: kernel test robot <lkp@intel.com>
To: Johannes Berg <johannes.berg@intel.com>
Cc: linux-wireless@vger.kernel.org
Subject: [wireless-next:main] BUILD SUCCESS
 0d95280a2d54ebd3d38adc4ff67808009798978c
Message-ID: <202602030741.rP0cF2Hx-lkp@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31484-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EA517D2B30
X-Rspamd-Action: no action

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: 0d95280a2d54ebd3d38adc4ff67808009798978c  wifi: mac80211: Add eMLSR/eMLMR action frame parsing support

elapsed time: 726m

configs tested: 311
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              alldefconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-22
arc                              allyesconfig    gcc-15.2.0
arc                                 defconfig    gcc-15.2.0
arc                 nsimosci_hs_smp_defconfig    gcc-15.2.0
arc                   randconfig-001-20260202    gcc-14.3.0
arc                   randconfig-001-20260203    gcc-12.5.0
arc                   randconfig-002-20260202    gcc-14.3.0
arc                   randconfig-002-20260203    gcc-12.5.0
arm                               allnoconfig    clang-22
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.2.0
arm                     davinci_all_defconfig    clang-22
arm                                 defconfig    clang-22
arm                                 defconfig    gcc-15.2.0
arm                           h3600_defconfig    gcc-15.2.0
arm                            hisi_defconfig    gcc-15.2.0
arm                       netwinder_defconfig    gcc-15.2.0
arm                   randconfig-001-20260202    gcc-14.3.0
arm                   randconfig-001-20260203    gcc-12.5.0
arm                   randconfig-002-20260202    gcc-14.3.0
arm                   randconfig-002-20260203    gcc-12.5.0
arm                   randconfig-003-20260202    gcc-14.3.0
arm                   randconfig-003-20260203    gcc-12.5.0
arm                   randconfig-004-20260202    gcc-14.3.0
arm                   randconfig-004-20260203    gcc-12.5.0
arm                           sama7_defconfig    clang-22
arm                         socfpga_defconfig    gcc-15.2.0
arm64                            allmodconfig    clang-19
arm64                            allmodconfig    clang-22
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260203    gcc-15.2.0
arm64                 randconfig-002-20260203    gcc-15.2.0
arm64                 randconfig-003-20260203    gcc-15.2.0
arm64                 randconfig-004-20260203    gcc-15.2.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260203    gcc-15.2.0
csky                  randconfig-002-20260203    gcc-15.2.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-22
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    clang-22
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260202    clang-19
hexagon               randconfig-001-20260203    clang-22
hexagon               randconfig-002-20260202    clang-19
hexagon               randconfig-002-20260203    clang-22
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260202    gcc-14
i386        buildonly-randconfig-001-20260203    clang-20
i386        buildonly-randconfig-002-20260202    gcc-14
i386        buildonly-randconfig-002-20260203    clang-20
i386        buildonly-randconfig-003-20260202    gcc-14
i386        buildonly-randconfig-003-20260203    clang-20
i386        buildonly-randconfig-004-20260202    gcc-14
i386        buildonly-randconfig-004-20260203    clang-20
i386        buildonly-randconfig-005-20260202    gcc-14
i386        buildonly-randconfig-005-20260203    clang-20
i386        buildonly-randconfig-006-20260202    gcc-14
i386        buildonly-randconfig-006-20260203    clang-20
i386                                defconfig    clang-20
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260202    gcc-14
i386                  randconfig-001-20260203    clang-20
i386                  randconfig-002-20260202    gcc-14
i386                  randconfig-002-20260203    clang-20
i386                  randconfig-003-20260202    gcc-14
i386                  randconfig-003-20260203    clang-20
i386                  randconfig-004-20260202    gcc-14
i386                  randconfig-004-20260203    clang-20
i386                  randconfig-005-20260202    gcc-14
i386                  randconfig-005-20260203    clang-20
i386                  randconfig-006-20260202    gcc-14
i386                  randconfig-006-20260203    clang-20
i386                  randconfig-007-20260202    gcc-14
i386                  randconfig-007-20260203    clang-20
i386                  randconfig-011-20260202    clang-20
i386                  randconfig-012-20260202    clang-20
i386                  randconfig-013-20260202    clang-20
i386                  randconfig-014-20260202    clang-20
i386                  randconfig-015-20260202    clang-20
i386                  randconfig-016-20260202    clang-20
i386                  randconfig-017-20260202    clang-20
loongarch                        alldefconfig    gcc-15.2.0
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-22
loongarch                         allnoconfig    clang-22
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260202    clang-19
loongarch             randconfig-001-20260203    clang-22
loongarch             randconfig-002-20260202    clang-19
loongarch             randconfig-002-20260203    clang-22
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                             allyesconfig    gcc-15.2.0
m68k                          atari_defconfig    gcc-15.2.0
m68k                       bvme6000_defconfig    gcc-15.2.0
m68k                                defconfig    clang-19
m68k                            mac_defconfig    gcc-15.2.0
m68k                           sun3_defconfig    gcc-15.2.0
m68k                           virt_defconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                        bcm63xx_defconfig    clang-22
mips                        bcm63xx_defconfig    gcc-15.2.0
mips                  cavium_octeon_defconfig    clang-22
mips                     cu1000-neo_defconfig    gcc-15.2.0
mips                  decstation_64_defconfig    gcc-15.2.0
mips                          eyeq5_defconfig    gcc-15.2.0
mips                           ip32_defconfig    gcc-15.2.0
mips                      loongson3_defconfig    gcc-15.2.0
mips                        vocore2_defconfig    clang-22
nios2                         10m50_defconfig    clang-22
nios2                            allmodconfig    clang-22
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260202    clang-19
nios2                 randconfig-001-20260203    clang-22
nios2                 randconfig-002-20260202    clang-19
nios2                 randconfig-002-20260203    clang-22
openrisc                         allmodconfig    clang-22
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    clang-19
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                generic-64bit_defconfig    gcc-15.2.0
parisc                randconfig-001-20260202    gcc-8.5.0
parisc                randconfig-001-20260203    gcc-12.5.0
parisc                randconfig-002-20260202    gcc-8.5.0
parisc                randconfig-002-20260203    gcc-12.5.0
parisc64                            defconfig    clang-19
powerpc                     akebono_defconfig    gcc-15.2.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.2.0
powerpc                     mpc83xx_defconfig    gcc-15.2.0
powerpc                       ppc64_defconfig    gcc-15.2.0
powerpc               randconfig-001-20260202    gcc-14.3.0
powerpc               randconfig-001-20260202    gcc-8.5.0
powerpc               randconfig-001-20260203    gcc-12.5.0
powerpc               randconfig-002-20260202    clang-22
powerpc               randconfig-002-20260202    gcc-8.5.0
powerpc               randconfig-002-20260203    gcc-12.5.0
powerpc64             randconfig-001-20260202    gcc-12.5.0
powerpc64             randconfig-001-20260202    gcc-8.5.0
powerpc64             randconfig-001-20260203    gcc-12.5.0
powerpc64             randconfig-002-20260202    gcc-11.5.0
powerpc64             randconfig-002-20260202    gcc-8.5.0
powerpc64             randconfig-002-20260203    gcc-12.5.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260202    gcc-14.3.0
riscv                 randconfig-001-20260203    gcc-8.5.0
riscv                 randconfig-002-20260202    gcc-13.4.0
riscv                 randconfig-002-20260203    gcc-8.5.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260202    clang-22
s390                  randconfig-001-20260203    gcc-8.5.0
s390                  randconfig-002-20260203    gcc-8.5.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-22
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sh                        edosk7705_defconfig    gcc-15.2.0
sh                          kfr2r09_defconfig    gcc-15.2.0
sh                          landisk_defconfig    gcc-15.2.0
sh                    randconfig-001-20260202    gcc-15.2.0
sh                    randconfig-001-20260203    gcc-8.5.0
sh                    randconfig-002-20260202    gcc-15.2.0
sh                    randconfig-002-20260203    gcc-8.5.0
sh                          rsk7203_defconfig    gcc-15.2.0
sh                          sdk7780_defconfig    gcc-15.2.0
sh                     sh7710voipgw_defconfig    gcc-15.2.0
sh                        sh7757lcr_defconfig    clang-22
sh                        sh7763rdp_defconfig    clang-22
sh                            shmin_defconfig    gcc-15.2.0
sparc                             allnoconfig    clang-22
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260202    gcc-12.5.0
sparc                 randconfig-001-20260203    gcc-13.4.0
sparc                 randconfig-002-20260202    gcc-12.5.0
sparc                 randconfig-002-20260203    gcc-13.4.0
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260202    gcc-12.5.0
sparc64               randconfig-001-20260203    gcc-13.4.0
sparc64               randconfig-002-20260202    gcc-12.5.0
sparc64               randconfig-002-20260203    gcc-13.4.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260202    gcc-12.5.0
um                    randconfig-001-20260203    gcc-13.4.0
um                    randconfig-002-20260202    gcc-12.5.0
um                    randconfig-002-20260203    gcc-13.4.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-22
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260202    gcc-14
x86_64      buildonly-randconfig-001-20260203    clang-20
x86_64      buildonly-randconfig-002-20260202    gcc-14
x86_64      buildonly-randconfig-002-20260203    clang-20
x86_64      buildonly-randconfig-003-20260202    gcc-14
x86_64      buildonly-randconfig-003-20260203    clang-20
x86_64      buildonly-randconfig-004-20260202    gcc-14
x86_64      buildonly-randconfig-004-20260203    clang-20
x86_64      buildonly-randconfig-005-20260202    gcc-14
x86_64      buildonly-randconfig-005-20260203    clang-20
x86_64      buildonly-randconfig-006-20260202    gcc-14
x86_64      buildonly-randconfig-006-20260203    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260202    gcc-14
x86_64                randconfig-001-20260203    clang-20
x86_64                randconfig-002-20260202    gcc-14
x86_64                randconfig-002-20260203    clang-20
x86_64                randconfig-003-20260202    gcc-14
x86_64                randconfig-003-20260203    clang-20
x86_64                randconfig-004-20260202    gcc-14
x86_64                randconfig-004-20260203    clang-20
x86_64                randconfig-005-20260202    gcc-14
x86_64                randconfig-005-20260203    clang-20
x86_64                randconfig-006-20260202    gcc-14
x86_64                randconfig-006-20260203    clang-20
x86_64                randconfig-011-20260202    gcc-14
x86_64                randconfig-011-20260203    gcc-14
x86_64                randconfig-012-20260202    clang-20
x86_64                randconfig-012-20260202    gcc-14
x86_64                randconfig-012-20260203    gcc-14
x86_64                randconfig-013-20260202    clang-20
x86_64                randconfig-013-20260202    gcc-14
x86_64                randconfig-013-20260203    gcc-14
x86_64                randconfig-014-20260202    gcc-12
x86_64                randconfig-014-20260202    gcc-14
x86_64                randconfig-014-20260203    gcc-14
x86_64                randconfig-015-20260202    gcc-14
x86_64                randconfig-015-20260203    gcc-14
x86_64                randconfig-016-20260202    gcc-14
x86_64                randconfig-016-20260203    gcc-14
x86_64                randconfig-071-20260202    clang-20
x86_64                randconfig-071-20260203    gcc-14
x86_64                randconfig-072-20260202    clang-20
x86_64                randconfig-072-20260203    gcc-14
x86_64                randconfig-073-20260202    clang-20
x86_64                randconfig-073-20260203    gcc-14
x86_64                randconfig-074-20260202    clang-20
x86_64                randconfig-074-20260203    gcc-14
x86_64                randconfig-075-20260202    clang-20
x86_64                randconfig-075-20260203    gcc-14
x86_64                randconfig-076-20260202    clang-20
x86_64                randconfig-076-20260203    gcc-14
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
xtensa                randconfig-001-20260202    gcc-12.5.0
xtensa                randconfig-001-20260203    gcc-13.4.0
xtensa                randconfig-002-20260202    gcc-12.5.0
xtensa                randconfig-002-20260203    gcc-13.4.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

