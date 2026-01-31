Return-Path: <linux-wireless+bounces-31411-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KK2xMvJVfWn9RQIAu9opvQ
	(envelope-from <linux-wireless+bounces-31411-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 31 Jan 2026 02:08:02 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E68ABFDEB
	for <lists+linux-wireless@lfdr.de>; Sat, 31 Jan 2026 02:08:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E2B3130115B7
	for <lists+linux-wireless@lfdr.de>; Sat, 31 Jan 2026 01:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F13F2116F6;
	Sat, 31 Jan 2026 01:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I2+PmuxQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE8925A659
	for <linux-wireless@vger.kernel.org>; Sat, 31 Jan 2026 01:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769821663; cv=none; b=ZagVEpYZLHtTymqQilGz2fB/CE3J3K7lKFPKKvvffMC1nJYpDvUe8cEBw0AMaTVtBfaSl7NC3RgAi5f0SjLm1x9ewB8nqxER3ltHe4T5edKBHbsrto/lhfWVtPRg4Ed4iO9EPttl7NQA82KPhVrqkOhIhKYYY339Xu4ITyE8H8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769821663; c=relaxed/simple;
	bh=+KmE0fijDhGaNjpeHJQcKUf8H5bneBUwsVLxK27tJv4=;
	h=Date:From:To:Cc:Subject:Message-ID; b=tidn4VwHpk/8TOg5gTHC+oD8t+17DTobbAQCL5uBMhgboMNtEJdIA1Q/qRkHUCLkeur/YhQzu08KCQSrTcKb952bqFFoZkNyuJvzAv83WiCoLIQgZGSk6WcGV7fbKChP/3XXTAU+pcQ99/w3b/HGk59BQQJpD/8+2NCiQVOnDsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I2+PmuxQ; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769821661; x=1801357661;
  h=date:from:to:cc:subject:message-id;
  bh=+KmE0fijDhGaNjpeHJQcKUf8H5bneBUwsVLxK27tJv4=;
  b=I2+PmuxQzJkX4xPH0feMt6+ha0RHbIqhTxP36QSU1z3WUsrIPgEM2I0z
   avWzz/Tz2UlT/VIW/5yaiBhAZ+5E7+UsedBMIEN/K0SaruJfdj4AySvyu
   bzsU9gWFPysNkTu+HV7NIJjJXN4oCuitMZ/hTb0GdaOx0z+fhW7kteYDb
   4k5F9GqXkKZo6QdNnaiaVzmoXeo62ceAjriWX6Pehzh1I+EzqIiQ/YVeD
   YilOY75n5qmEt0ZEKS3RrwCCOIYbQohfuhw3qXsBsLylYDRop1YHb4tQ4
   UZB1ay/mcNHFSGmY9ikpn02/VHwAI2tGubrwXjDqc4Uco9FFlfX4n2B9q
   g==;
X-CSE-ConnectionGUID: QQl5r82OQW+aVyK+Ue2D+Q==
X-CSE-MsgGUID: ABGCe2O8Q1CbaaEmek4e1w==
X-IronPort-AV: E=McAfee;i="6800,10657,11687"; a="71113284"
X-IronPort-AV: E=Sophos;i="6.21,264,1763452800"; 
   d="scan'208";a="71113284"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2026 17:07:41 -0800
X-CSE-ConnectionGUID: BLz7/T0wQBupfUsdF3INWg==
X-CSE-MsgGUID: BGWcy+LIQ7WGuvqf6b4knQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,264,1763452800"; 
   d="scan'208";a="213925529"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 30 Jan 2026 17:07:39 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vlzSa-00000000dWy-2fmz;
	Sat, 31 Jan 2026 01:07:36 +0000
Date: Sat, 31 Jan 2026 09:07:16 +0800
From: kernel test robot <lkp@intel.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>,
 linux-wireless@vger.kernel.org
Subject: [wireless-next:main] BUILD SUCCESS
 303c1a66a22068517793284524dd1d24b7316d1b
Message-ID: <202601310910.iUMPiU4H-lkp@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31411-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
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
X-Rspamd-Queue-Id: 3E68ABFDEB
X-Rspamd-Action: no action

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: 303c1a66a22068517793284524dd1d24b7316d1b  Merge tag 'wireless-next-2026-01-29' of https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next

elapsed time: 1002m

configs tested: 311
configs skipped: 9

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                            alldefconfig    gcc-15.2.0
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              alldefconfig    clang-22
arc                              allmodconfig    clang-16
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-22
arc                              allyesconfig    gcc-15.2.0
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260130    clang-17
arc                   randconfig-001-20260131    gcc-8.5.0
arc                   randconfig-002-20260130    clang-17
arc                   randconfig-002-20260131    gcc-8.5.0
arm                               allnoconfig    clang-22
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.2.0
arm                                 defconfig    clang-22
arm                                 defconfig    gcc-15.2.0
arm                            dove_defconfig    clang-22
arm                      jornada720_defconfig    clang-22
arm                        mvebu_v5_defconfig    gcc-15.2.0
arm                          pxa910_defconfig    clang-22
arm                   randconfig-001-20260130    clang-17
arm                   randconfig-001-20260131    gcc-8.5.0
arm                   randconfig-002-20260130    clang-17
arm                   randconfig-002-20260131    gcc-8.5.0
arm                   randconfig-003-20260130    clang-17
arm                   randconfig-003-20260131    gcc-8.5.0
arm                   randconfig-004-20260130    clang-17
arm                   randconfig-004-20260131    gcc-8.5.0
arm64                            allmodconfig    clang-19
arm64                            allmodconfig    clang-22
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260130    gcc-8.5.0
arm64                 randconfig-001-20260131    clang-22
arm64                 randconfig-002-20260130    gcc-8.5.0
arm64                 randconfig-002-20260131    clang-22
arm64                 randconfig-003-20260130    gcc-8.5.0
arm64                 randconfig-003-20260131    clang-22
arm64                 randconfig-004-20260130    clang-22
arm64                 randconfig-004-20260130    gcc-8.5.0
arm64                 randconfig-004-20260131    clang-22
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260130    gcc-15.2.0
csky                  randconfig-001-20260130    gcc-8.5.0
csky                  randconfig-001-20260131    clang-22
csky                  randconfig-002-20260130    gcc-15.2.0
csky                  randconfig-002-20260130    gcc-8.5.0
csky                  randconfig-002-20260131    clang-22
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-22
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    clang-22
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260130    clang-19
hexagon               randconfig-001-20260130    gcc-11.5.0
hexagon               randconfig-001-20260131    gcc-11.5.0
hexagon               randconfig-002-20260130    clang-18
hexagon               randconfig-002-20260130    gcc-11.5.0
hexagon               randconfig-002-20260131    gcc-11.5.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260130    clang-20
i386        buildonly-randconfig-001-20260131    clang-20
i386        buildonly-randconfig-002-20260130    clang-20
i386        buildonly-randconfig-002-20260131    clang-20
i386        buildonly-randconfig-003-20260130    clang-20
i386        buildonly-randconfig-003-20260131    clang-20
i386        buildonly-randconfig-004-20260130    clang-20
i386        buildonly-randconfig-004-20260130    gcc-14
i386        buildonly-randconfig-004-20260131    clang-20
i386        buildonly-randconfig-005-20260130    clang-20
i386        buildonly-randconfig-005-20260131    clang-20
i386        buildonly-randconfig-006-20260130    clang-20
i386        buildonly-randconfig-006-20260130    gcc-14
i386        buildonly-randconfig-006-20260131    clang-20
i386                                defconfig    clang-20
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260130    gcc-14
i386                  randconfig-002-20260130    gcc-14
i386                  randconfig-003-20260130    gcc-14
i386                  randconfig-004-20260130    gcc-14
i386                  randconfig-005-20260130    gcc-14
i386                  randconfig-006-20260130    gcc-14
i386                  randconfig-007-20260130    gcc-14
i386                  randconfig-011-20260130    clang-20
i386                  randconfig-011-20260130    gcc-14
i386                  randconfig-011-20260131    gcc-14
i386                  randconfig-012-20260130    clang-20
i386                  randconfig-012-20260130    gcc-14
i386                  randconfig-012-20260131    gcc-14
i386                  randconfig-013-20260130    clang-20
i386                  randconfig-013-20260130    gcc-14
i386                  randconfig-013-20260131    gcc-14
i386                  randconfig-014-20260130    clang-20
i386                  randconfig-014-20260131    gcc-14
i386                  randconfig-015-20260130    clang-20
i386                  randconfig-015-20260130    gcc-14
i386                  randconfig-015-20260131    gcc-14
i386                  randconfig-016-20260130    clang-20
i386                  randconfig-016-20260130    gcc-14
i386                  randconfig-016-20260131    gcc-14
i386                  randconfig-017-20260130    clang-20
i386                  randconfig-017-20260130    gcc-14
i386                  randconfig-017-20260131    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-22
loongarch                         allnoconfig    clang-22
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260130    clang-22
loongarch             randconfig-001-20260130    gcc-11.5.0
loongarch             randconfig-001-20260131    gcc-11.5.0
loongarch             randconfig-002-20260130    clang-18
loongarch             randconfig-002-20260130    gcc-11.5.0
loongarch             randconfig-002-20260131    gcc-11.5.0
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                             allyesconfig    gcc-15.2.0
m68k                                defconfig    clang-19
m68k                                defconfig    gcc-15.2.0
m68k                       m5275evb_defconfig    gcc-15.2.0
m68k                        m5307c3_defconfig    clang-22
m68k                          sun3x_defconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
microblaze                          defconfig    gcc-15.2.0
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                          ath25_defconfig    gcc-15.2.0
nios2                            allmodconfig    clang-22
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20260130    gcc-11.5.0
nios2                 randconfig-001-20260130    gcc-8.5.0
nios2                 randconfig-001-20260131    gcc-11.5.0
nios2                 randconfig-002-20260130    gcc-11.5.0
nios2                 randconfig-002-20260131    gcc-11.5.0
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
parisc                randconfig-001-20260130    gcc-14.3.0
parisc                randconfig-001-20260130    gcc-8.5.0
parisc                randconfig-001-20260131    gcc-8.5.0
parisc                randconfig-002-20260130    gcc-8.5.0
parisc                randconfig-002-20260131    gcc-8.5.0
parisc64                            defconfig    clang-19
parisc64                            defconfig    gcc-15.2.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.2.0
powerpc                      mgcoge_defconfig    clang-22
powerpc                     mpc5200_defconfig    clang-22
powerpc               randconfig-001-20260130    gcc-14.3.0
powerpc               randconfig-001-20260130    gcc-8.5.0
powerpc               randconfig-001-20260131    gcc-8.5.0
powerpc               randconfig-002-20260130    gcc-10.5.0
powerpc               randconfig-002-20260130    gcc-8.5.0
powerpc               randconfig-002-20260131    gcc-8.5.0
powerpc                     tqm5200_defconfig    gcc-15.2.0
powerpc64             randconfig-001-20260130    clang-22
powerpc64             randconfig-001-20260130    gcc-8.5.0
powerpc64             randconfig-001-20260131    gcc-8.5.0
powerpc64             randconfig-002-20260130    clang-22
powerpc64             randconfig-002-20260130    gcc-8.5.0
powerpc64             randconfig-002-20260131    gcc-8.5.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                    nommu_k210_defconfig    gcc-15.2.0
riscv                 randconfig-001-20260130    clang-22
riscv                 randconfig-001-20260130    gcc-14.3.0
riscv                 randconfig-001-20260131    gcc-8.5.0
riscv                 randconfig-002-20260130    clang-22
riscv                 randconfig-002-20260131    gcc-8.5.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260130    clang-22
s390                  randconfig-001-20260131    gcc-8.5.0
s390                  randconfig-002-20260130    clang-22
s390                  randconfig-002-20260131    gcc-8.5.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-22
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sh                    randconfig-001-20260130    clang-22
sh                    randconfig-001-20260130    gcc-9.5.0
sh                    randconfig-001-20260131    gcc-8.5.0
sh                    randconfig-002-20260130    clang-22
sh                    randconfig-002-20260130    gcc-13.4.0
sh                    randconfig-002-20260131    gcc-8.5.0
sh                     sh7710voipgw_defconfig    gcc-15.2.0
sparc                             allnoconfig    clang-22
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260131    gcc-14
sparc                 randconfig-002-20260131    gcc-14
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260131    gcc-14
sparc64               randconfig-002-20260131    gcc-14
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260131    gcc-14
um                    randconfig-002-20260131    gcc-14
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-22
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260130    clang-20
x86_64      buildonly-randconfig-001-20260131    gcc-14
x86_64      buildonly-randconfig-002-20260130    clang-20
x86_64      buildonly-randconfig-002-20260131    gcc-14
x86_64      buildonly-randconfig-003-20260130    clang-20
x86_64      buildonly-randconfig-003-20260131    gcc-14
x86_64      buildonly-randconfig-004-20260130    clang-20
x86_64      buildonly-randconfig-004-20260131    gcc-14
x86_64      buildonly-randconfig-005-20260130    clang-20
x86_64      buildonly-randconfig-005-20260131    gcc-14
x86_64      buildonly-randconfig-006-20260130    clang-20
x86_64      buildonly-randconfig-006-20260131    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260130    clang-20
x86_64                randconfig-001-20260131    clang-20
x86_64                randconfig-002-20260130    clang-20
x86_64                randconfig-002-20260131    clang-20
x86_64                randconfig-003-20260130    clang-20
x86_64                randconfig-003-20260131    clang-20
x86_64                randconfig-004-20260130    clang-20
x86_64                randconfig-004-20260131    clang-20
x86_64                randconfig-005-20260130    clang-20
x86_64                randconfig-005-20260131    clang-20
x86_64                randconfig-006-20260130    clang-20
x86_64                randconfig-006-20260131    clang-20
x86_64                randconfig-011-20260130    clang-20
x86_64                randconfig-011-20260131    clang-20
x86_64                randconfig-012-20260130    clang-20
x86_64                randconfig-012-20260131    clang-20
x86_64                randconfig-013-20260130    clang-20
x86_64                randconfig-013-20260131    clang-20
x86_64                randconfig-014-20260130    clang-20
x86_64                randconfig-014-20260130    gcc-14
x86_64                randconfig-014-20260131    clang-20
x86_64                randconfig-015-20260130    clang-20
x86_64                randconfig-015-20260131    clang-20
x86_64                randconfig-016-20260130    clang-20
x86_64                randconfig-016-20260130    gcc-14
x86_64                randconfig-016-20260131    clang-20
x86_64                randconfig-071-20260130    clang-20
x86_64                randconfig-071-20260131    gcc-14
x86_64                randconfig-072-20260130    clang-20
x86_64                randconfig-072-20260131    gcc-14
x86_64                randconfig-073-20260130    clang-20
x86_64                randconfig-073-20260131    gcc-14
x86_64                randconfig-074-20260130    clang-20
x86_64                randconfig-074-20260131    gcc-14
x86_64                randconfig-075-20260130    clang-20
x86_64                randconfig-075-20260131    gcc-14
x86_64                randconfig-076-20260130    clang-20
x86_64                randconfig-076-20260131    gcc-14
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
xtensa                randconfig-001-20260131    gcc-14
xtensa                randconfig-002-20260131    gcc-14

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

