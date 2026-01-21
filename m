Return-Path: <linux-wireless+bounces-31039-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2Ep8C98tcGniWwAAu9opvQ
	(envelope-from <linux-wireless+bounces-31039-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Jan 2026 02:37:35 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C495D4F2DC
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Jan 2026 02:37:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 99C20626037
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Jan 2026 01:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB8B430E821;
	Wed, 21 Jan 2026 01:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VpGw7u7h"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7218F2E093C
	for <linux-wireless@vger.kernel.org>; Wed, 21 Jan 2026 01:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768959447; cv=none; b=rfP+2hemaEKnf9cNnUCY7lwvLLuC4fHqp5ml3dINaT4/9yO9q5T1uas5NJZyoX1w5E2UHRtkbKhaYMvUsfukrexK4Dm3NyZ/NoW0decPVrFW/CKIvBjLMv3378BMHctK7BdBhlvhvS+nD7YFsGcoIufkbb+hbsc3c5yTs477lqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768959447; c=relaxed/simple;
	bh=/gf70sDzl53L4vsXYgoZ5qARTR6ekJ51sXdTL4XZrtE=;
	h=Date:From:To:Cc:Subject:Message-ID; b=MyAr4wgW8cP0oPnPT/KHXep6i9tkeFYKrxfDonM+MVBCdirHm8x85tJ4E4sF5Nk9L2V/D0y2eE6cd5LkXwWmIrTjVksov4/1JIcorNre+DMTgNH2Er9rAWr4vHbTFpfUfJp6VQUMTcOsiy0OR1SGKcA3Seot/uf//LV13ygCRjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VpGw7u7h; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768959443; x=1800495443;
  h=date:from:to:cc:subject:message-id;
  bh=/gf70sDzl53L4vsXYgoZ5qARTR6ekJ51sXdTL4XZrtE=;
  b=VpGw7u7htGHMzsab4Wa1I3rQIQSgvUG7R/ZoohG2uEUjwU5TIZn5v1UE
   00kSOqiPqJOv3WzGYwwk8z/8kvDmLY6VqsphUS4e3/wQVAKy1qj6v9lIU
   bPAOhkNf3YbLiQ5qy/33/9894AGJHFoTC2wn3SfjWcrEPa7fPMZk+RhrJ
   B0AchNMZ6FKYghTutgCl2tlK46j38WmbeiFpPb51C1JUfb770pLCdVt9x
   +ZQXIGoYkqG5Bi+5hTuBAk5z9LUxOFEy+Yr1Z90mQeNA+tTMe75FlERBy
   C+3oE/WYeH9fAcxlTBgSX33tJSQP5nzIt43Mf/MDGyB9dowGl9qqEdPlh
   w==;
X-CSE-ConnectionGUID: hahtKoIwQneLwM8lOGYKfA==
X-CSE-MsgGUID: ckhVc2ISQ7GA/czWuOjcCA==
X-IronPort-AV: E=McAfee;i="6800,10657,11677"; a="72772821"
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; 
   d="scan'208";a="72772821"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2026 17:37:17 -0800
X-CSE-ConnectionGUID: gMg6toOSSWKpdWqcMvosXg==
X-CSE-MsgGUID: 7gaoCFJBQl6orW+zXxlqBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; 
   d="scan'208";a="243854472"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 20 Jan 2026 17:37:15 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1viN9k-00000000Pou-2vuh;
	Wed, 21 Jan 2026 01:37:12 +0000
Date: Wed, 21 Jan 2026 09:37:08 +0800
From: kernel test robot <lkp@intel.com>
To: Johannes Berg <johannes.berg@intel.com>
Cc: linux-wireless@vger.kernel.org
Subject: [wireless:for-next] BUILD SUCCESS
 50b359896fe55d0443ed550e1fabba71d242031a
Message-ID: <202601210902.5nY33k55-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31039-lists,linux-wireless=lfdr.de];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[intel.com,none];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-wireless@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: C495D4F2DC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git for-next
branch HEAD: 50b359896fe55d0443ed550e1fabba71d242031a  wifi: cfg80211: ignore link disabled flag from userspace

elapsed time: 940m

configs tested: 316
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
arc                              allyesconfig    gcc-15.2.0
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260120    gcc-10.5.0
arc                   randconfig-001-20260121    clang-18
arc                   randconfig-002-20260120    gcc-8.5.0
arc                   randconfig-002-20260121    clang-18
arc                    vdk_hs38_smp_defconfig    clang-22
arm                               allnoconfig    clang-22
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.2.0
arm                         assabet_defconfig    clang-22
arm                          collie_defconfig    gcc-15.2.0
arm                                 defconfig    clang-22
arm                                 defconfig    gcc-15.2.0
arm                          gemini_defconfig    gcc-15.2.0
arm                         mv78xx0_defconfig    gcc-15.2.0
arm                         orion5x_defconfig    gcc-15.2.0
arm                   randconfig-001-20260120    clang-22
arm                   randconfig-001-20260121    clang-18
arm                   randconfig-002-20260120    gcc-13.4.0
arm                   randconfig-002-20260121    clang-18
arm                   randconfig-003-20260120    clang-22
arm                   randconfig-003-20260121    clang-18
arm                   randconfig-004-20260120    clang-22
arm                   randconfig-004-20260121    clang-18
arm                           stm32_defconfig    clang-22
arm64                            allmodconfig    clang-19
arm64                            allmodconfig    clang-22
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260120    gcc-12.5.0
arm64                 randconfig-001-20260121    gcc-15.2.0
arm64                 randconfig-002-20260120    gcc-8.5.0
arm64                 randconfig-002-20260121    gcc-15.2.0
arm64                 randconfig-003-20260120    clang-22
arm64                 randconfig-003-20260121    gcc-15.2.0
arm64                 randconfig-004-20260120    clang-22
arm64                 randconfig-004-20260121    gcc-15.2.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260120    gcc-15.2.0
csky                  randconfig-001-20260121    gcc-15.2.0
csky                  randconfig-002-20260120    gcc-15.2.0
csky                  randconfig-002-20260121    gcc-15.2.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-22
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    clang-22
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260120    clang-22
hexagon               randconfig-001-20260121    gcc-15.2.0
hexagon               randconfig-002-20260120    clang-22
hexagon               randconfig-002-20260121    gcc-15.2.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260120    gcc-14
i386        buildonly-randconfig-001-20260121    clang-20
i386        buildonly-randconfig-002-20260120    gcc-14
i386        buildonly-randconfig-002-20260121    clang-20
i386        buildonly-randconfig-003-20260120    gcc-14
i386        buildonly-randconfig-003-20260121    clang-20
i386        buildonly-randconfig-004-20260120    clang-20
i386        buildonly-randconfig-004-20260121    clang-20
i386        buildonly-randconfig-005-20260120    gcc-14
i386        buildonly-randconfig-005-20260121    clang-20
i386        buildonly-randconfig-006-20260120    gcc-14
i386        buildonly-randconfig-006-20260121    clang-20
i386                                defconfig    clang-20
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260120    gcc-14
i386                  randconfig-001-20260121    clang-20
i386                  randconfig-002-20260120    gcc-12
i386                  randconfig-002-20260121    clang-20
i386                  randconfig-003-20260120    clang-20
i386                  randconfig-003-20260121    clang-20
i386                  randconfig-004-20260120    clang-20
i386                  randconfig-004-20260121    clang-20
i386                  randconfig-005-20260120    clang-20
i386                  randconfig-005-20260121    clang-20
i386                  randconfig-006-20260120    clang-20
i386                  randconfig-006-20260121    clang-20
i386                  randconfig-007-20260120    gcc-14
i386                  randconfig-007-20260121    clang-20
i386                  randconfig-011-20260120    clang-20
i386                  randconfig-011-20260121    gcc-14
i386                  randconfig-012-20260120    gcc-14
i386                  randconfig-012-20260121    gcc-14
i386                  randconfig-013-20260120    clang-20
i386                  randconfig-013-20260121    gcc-14
i386                  randconfig-014-20260120    clang-20
i386                  randconfig-014-20260121    gcc-14
i386                  randconfig-015-20260120    clang-20
i386                  randconfig-015-20260121    gcc-14
i386                  randconfig-016-20260120    clang-20
i386                  randconfig-016-20260121    gcc-14
i386                  randconfig-017-20260120    clang-20
i386                  randconfig-017-20260121    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-22
loongarch                         allnoconfig    clang-22
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch                loongson64_defconfig    gcc-15.2.0
loongarch             randconfig-001-20260120    gcc-12.5.0
loongarch             randconfig-001-20260121    gcc-15.2.0
loongarch             randconfig-002-20260120    gcc-15.2.0
loongarch             randconfig-002-20260121    gcc-15.2.0
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                             allyesconfig    gcc-15.2.0
m68k                         apollo_defconfig    clang-22
m68k                                defconfig    clang-19
m68k                                defconfig    gcc-15.2.0
m68k                        m5307c3_defconfig    gcc-15.2.0
m68k                        mvme16x_defconfig    gcc-15.2.0
m68k                           sun3_defconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
microblaze                          defconfig    gcc-15.2.0
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                      fuloong2e_defconfig    gcc-15.2.0
mips                malta_qemu_32r6_defconfig    gcc-15.2.0
mips                         rt305x_defconfig    gcc-15.2.0
nios2                            allmodconfig    clang-22
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                               defconfig    gcc-11.5.0
nios2                 randconfig-001-20260120    gcc-11.5.0
nios2                 randconfig-001-20260121    gcc-15.2.0
nios2                 randconfig-002-20260120    gcc-11.5.0
nios2                 randconfig-002-20260121    gcc-15.2.0
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
parisc                randconfig-001-20260120    gcc-8.5.0
parisc                randconfig-001-20260121    gcc-9.5.0
parisc                randconfig-002-20260120    gcc-9.5.0
parisc                randconfig-002-20260121    gcc-9.5.0
parisc64                            defconfig    clang-19
parisc64                            defconfig    gcc-15.2.0
powerpc                    adder875_defconfig    gcc-15.2.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.2.0
powerpc                       holly_defconfig    clang-22
powerpc                 linkstation_defconfig    gcc-15.2.0
powerpc                 mpc8313_rdb_defconfig    gcc-15.2.0
powerpc                     powernv_defconfig    gcc-15.2.0
powerpc               randconfig-001-20260120    clang-19
powerpc               randconfig-001-20260121    gcc-9.5.0
powerpc               randconfig-002-20260120    gcc-10.5.0
powerpc               randconfig-002-20260121    gcc-9.5.0
powerpc                     tqm8560_defconfig    clang-22
powerpc64             randconfig-001-20260120    gcc-12.5.0
powerpc64             randconfig-001-20260121    gcc-9.5.0
powerpc64             randconfig-002-20260120    clang-22
powerpc64             randconfig-002-20260121    gcc-9.5.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    clang-22
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260120    gcc-13.4.0
riscv                 randconfig-001-20260121    clang-16
riscv                 randconfig-002-20260120    gcc-10.5.0
riscv                 randconfig-002-20260121    clang-16
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    clang-22
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260120    gcc-15.2.0
s390                  randconfig-001-20260121    clang-16
s390                  randconfig-002-20260120    clang-22
s390                  randconfig-002-20260121    clang-16
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-22
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.2.0
sh                         apsh4a3a_defconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sh                        edosk7760_defconfig    clang-22
sh                        edosk7760_defconfig    gcc-15.2.0
sh                          r7780mp_defconfig    gcc-15.2.0
sh                    randconfig-001-20260120    gcc-15.2.0
sh                    randconfig-001-20260121    clang-16
sh                    randconfig-002-20260120    gcc-11.5.0
sh                    randconfig-002-20260121    clang-16
sh                          rsk7201_defconfig    gcc-15.2.0
sh                           se7343_defconfig    gcc-15.2.0
sh                           se7705_defconfig    gcc-15.2.0
sparc                            alldefconfig    clang-22
sparc                            alldefconfig    gcc-15.2.0
sparc                             allnoconfig    clang-22
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260120    gcc-8.5.0
sparc                 randconfig-001-20260121    gcc-8.5.0
sparc                 randconfig-002-20260120    gcc-8.5.0
sparc                 randconfig-002-20260121    gcc-8.5.0
sparc                       sparc64_defconfig    gcc-15.2.0
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260120    clang-22
sparc64               randconfig-001-20260121    gcc-8.5.0
sparc64               randconfig-002-20260120    clang-20
sparc64               randconfig-002-20260121    gcc-8.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260120    gcc-14
um                    randconfig-001-20260121    gcc-8.5.0
um                    randconfig-002-20260120    gcc-14
um                    randconfig-002-20260121    gcc-8.5.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-22
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260120    gcc-14
x86_64      buildonly-randconfig-001-20260121    clang-20
x86_64      buildonly-randconfig-002-20260120    gcc-14
x86_64      buildonly-randconfig-002-20260121    clang-20
x86_64      buildonly-randconfig-003-20260120    gcc-14
x86_64      buildonly-randconfig-003-20260121    clang-20
x86_64      buildonly-randconfig-004-20260120    clang-20
x86_64      buildonly-randconfig-004-20260121    clang-20
x86_64      buildonly-randconfig-005-20260120    gcc-14
x86_64      buildonly-randconfig-005-20260121    clang-20
x86_64      buildonly-randconfig-006-20260120    gcc-14
x86_64      buildonly-randconfig-006-20260121    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260121    clang-20
x86_64                randconfig-002-20260121    clang-20
x86_64                randconfig-002-20260121    gcc-14
x86_64                randconfig-003-20260121    clang-20
x86_64                randconfig-003-20260121    gcc-14
x86_64                randconfig-004-20260121    clang-20
x86_64                randconfig-004-20260121    gcc-14
x86_64                randconfig-005-20260121    clang-20
x86_64                randconfig-006-20260121    clang-20
x86_64                randconfig-011-20260120    clang-20
x86_64                randconfig-011-20260121    gcc-14
x86_64                randconfig-012-20260120    gcc-12
x86_64                randconfig-012-20260121    gcc-14
x86_64                randconfig-013-20260120    clang-20
x86_64                randconfig-013-20260121    gcc-14
x86_64                randconfig-014-20260120    gcc-14
x86_64                randconfig-014-20260121    gcc-14
x86_64                randconfig-015-20260120    clang-20
x86_64                randconfig-015-20260121    gcc-14
x86_64                randconfig-016-20260120    gcc-14
x86_64                randconfig-016-20260121    gcc-14
x86_64                randconfig-071-20260120    gcc-14
x86_64                randconfig-071-20260121    clang-20
x86_64                randconfig-072-20260120    gcc-14
x86_64                randconfig-072-20260121    clang-20
x86_64                randconfig-073-20260120    clang-20
x86_64                randconfig-073-20260121    clang-20
x86_64                randconfig-074-20260120    gcc-14
x86_64                randconfig-074-20260121    clang-20
x86_64                randconfig-075-20260120    clang-20
x86_64                randconfig-075-20260121    clang-20
x86_64                randconfig-076-20260120    clang-20
x86_64                randconfig-076-20260121    clang-20
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
xtensa                randconfig-001-20260120    gcc-13.4.0
xtensa                randconfig-001-20260121    gcc-8.5.0
xtensa                randconfig-002-20260120    gcc-8.5.0
xtensa                randconfig-002-20260121    gcc-8.5.0
xtensa                    smp_lx200_defconfig    gcc-15.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

