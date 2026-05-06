Return-Path: <linux-wireless+bounces-36044-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iEUTM/q2+2njDgAAu9opvQ
	(envelope-from <linux-wireless+bounces-36044-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 06 May 2026 23:47:38 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 717EB4E0B85
	for <lists+linux-wireless@lfdr.de>; Wed, 06 May 2026 23:47:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BB2223009CDC
	for <lists+linux-wireless@lfdr.de>; Wed,  6 May 2026 21:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0558C31F9B5;
	Wed,  6 May 2026 21:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZvoyFewK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3702F239085
	for <linux-wireless@vger.kernel.org>; Wed,  6 May 2026 21:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778104055; cv=none; b=uEV0IUQoImPGgOehOC9e8voV7YBCD1eLuZzrHAAyOhMBCmtcpa4vrDUqHAUklcOG/3Atrlu56hAqZcP0lwfajqBx4IZtyzGsKnzvQtESaXhP5Rc5PF2v7DPUUej3iEawlbEeRk4hUF3oUfpYN31+4zQjiCQ9rlPqn+4dnceoOC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778104055; c=relaxed/simple;
	bh=P+V1sqcYOCscMc9QzZ+Y6cBZuq6eERv4ivhIqHn6/Ng=;
	h=Date:From:To:Cc:Subject:Message-ID; b=hVrtix/kHa27Cgc6FWF+mgOx4mwFUo4TlEza21s0LuxvOM9G/bfpBnKClXOJ+7XB+oVDOJuwu0+uWluZGkSXhI9kXCfEIP0eieBBo0B3B83vexTNgxn4SyCqNz+M2sh2Iult6wnKkQAcHJTOgm+ATG9ABlgWoeU0+8up5TpL7fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZvoyFewK; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778104054; x=1809640054;
  h=date:from:to:cc:subject:message-id;
  bh=P+V1sqcYOCscMc9QzZ+Y6cBZuq6eERv4ivhIqHn6/Ng=;
  b=ZvoyFewK7l9d9zamT//SBy0ff5QE1aRf0e5ht8IdTN4pvC+q99+Uni1L
   71JIPYxKBcMcPttGc8DhzrrcVpENmuvbar64t576xBCzylySA5mcmFEdS
   GoFS2sOb1EM9qKikbo+DTXlapgQTkM0bjVBbu3zA4iiF8JALk9+q1EzoV
   QhN4qYR5s5hFd2C4FL0mNWUk7udh2CKqGjfMHA/NR7hdtHgHatLgu8yiV
   5Qhm5w91eKdwHP/UVdZMjDJi6djWtvi0AOw1Nzfs+Aqf1Zf4C1IMV7xH9
   8mVv/qtwiMyKbWFyLSMnYGsEcS3PHGOK+Nufm+yY9psX49ceL/XI9cN85
   w==;
X-CSE-ConnectionGUID: uQ5cBVHISiWJlAALiR0DOA==
X-CSE-MsgGUID: bN/PYTwSTY6SHco2pxFpPA==
X-IronPort-AV: E=McAfee;i="6800,10657,11778"; a="79065104"
X-IronPort-AV: E=Sophos;i="6.23,220,1770624000"; 
   d="scan'208";a="79065104"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 14:47:34 -0700
X-CSE-ConnectionGUID: QJ2P01EeRjS63H1Qiet+kQ==
X-CSE-MsgGUID: yWRq+qg8RcWv88rtnf2vag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,220,1770624000"; 
   d="scan'208";a="241255704"
Received: from lkp-server01.sh.intel.com (HELO 9ec114424ce8) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 06 May 2026 14:47:32 -0700
Received: from kbuild by 9ec114424ce8 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wKk5a-000000001FX-0aPV;
	Wed, 06 May 2026 21:47:30 +0000
Date: Thu, 07 May 2026 05:47:27 +0800
From: kernel test robot <lkp@intel.com>
To: Johannes Berg <johannes.berg@intel.com>
Cc: linux-wireless@vger.kernel.org
Subject: [wireless:for-next] BUILD SUCCESS
 79240f3f6d766b342b57c32397d643e1cfa26b81
Message-ID: <202605070516.E9F27a5p-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: 717EB4E0B85
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TAGGED_FROM(0.00)[bounces-36044-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git for-next
branch HEAD: 79240f3f6d766b342b57c32397d643e1cfa26b81  wifi: nl80211: re-check wiphy netns in nl80211_prepare_wdev_dump() continuation

elapsed time: 727m

configs tested: 243
configs skipped: 20

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-23
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260506    gcc-12.5.0
arc                   randconfig-002-20260506    gcc-12.5.0
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                                 defconfig    gcc-15.2.0
arm                   randconfig-001-20260506    gcc-12.5.0
arm                   randconfig-002-20260506    gcc-12.5.0
arm                   randconfig-003-20260506    gcc-12.5.0
arm                   randconfig-004-20260506    gcc-12.5.0
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                          randconfig-001    gcc-15.2.0
arm64                 randconfig-001-20260506    gcc-15.2.0
arm64                 randconfig-001-20260507    gcc-15.2.0
arm64                          randconfig-002    gcc-15.2.0
arm64                 randconfig-002-20260506    gcc-15.2.0
arm64                 randconfig-002-20260507    gcc-15.2.0
arm64                          randconfig-003    gcc-15.2.0
arm64                 randconfig-003-20260506    gcc-15.2.0
arm64                 randconfig-003-20260507    gcc-15.2.0
arm64                          randconfig-004    gcc-15.2.0
arm64                 randconfig-004-20260506    gcc-15.2.0
arm64                 randconfig-004-20260507    gcc-15.2.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                           randconfig-001    gcc-15.2.0
csky                  randconfig-001-20260506    gcc-15.2.0
csky                  randconfig-001-20260507    gcc-15.2.0
csky                           randconfig-002    gcc-15.2.0
csky                  randconfig-002-20260506    gcc-15.2.0
csky                  randconfig-002-20260507    gcc-15.2.0
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon                        randconfig-001    gcc-11.5.0
hexagon               randconfig-001-20260506    clang-23
hexagon               randconfig-001-20260506    gcc-11.5.0
hexagon                        randconfig-002    gcc-11.5.0
hexagon               randconfig-002-20260506    clang-23
hexagon               randconfig-002-20260506    gcc-11.5.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386                 buildonly-randconfig-001    clang-20
i386        buildonly-randconfig-001-20260506    clang-20
i386        buildonly-randconfig-001-20260506    gcc-14
i386                 buildonly-randconfig-002    clang-20
i386        buildonly-randconfig-002-20260506    clang-20
i386        buildonly-randconfig-002-20260506    gcc-14
i386                 buildonly-randconfig-003    clang-20
i386        buildonly-randconfig-003-20260506    clang-20
i386                 buildonly-randconfig-004    clang-20
i386        buildonly-randconfig-004-20260506    clang-20
i386                 buildonly-randconfig-005    clang-20
i386        buildonly-randconfig-005-20260506    clang-20
i386                 buildonly-randconfig-006    clang-20
i386        buildonly-randconfig-006-20260506    clang-20
i386        buildonly-randconfig-006-20260506    gcc-14
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260506    gcc-14
i386                  randconfig-002-20260506    gcc-14
i386                  randconfig-003-20260506    gcc-14
i386                  randconfig-004-20260506    gcc-14
i386                  randconfig-005-20260506    gcc-14
i386                  randconfig-006-20260506    gcc-14
i386                  randconfig-007-20260506    gcc-14
i386                           randconfig-011    clang-20
i386                  randconfig-011-20260506    clang-20
i386                           randconfig-012    clang-20
i386                  randconfig-012-20260506    clang-20
i386                           randconfig-013    clang-20
i386                  randconfig-013-20260506    clang-20
i386                           randconfig-014    clang-20
i386                  randconfig-014-20260506    clang-20
i386                           randconfig-015    clang-20
i386                  randconfig-015-20260506    clang-20
i386                           randconfig-016    clang-20
i386                  randconfig-016-20260506    clang-20
i386                           randconfig-017    clang-20
i386                  randconfig-017-20260506    clang-20
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch                      randconfig-001    gcc-11.5.0
loongarch             randconfig-001-20260506    clang-23
loongarch             randconfig-001-20260506    gcc-11.5.0
loongarch                      randconfig-002    gcc-11.5.0
loongarch             randconfig-002-20260506    clang-23
loongarch             randconfig-002-20260506    gcc-11.5.0
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                         apollo_defconfig    gcc-15.2.0
m68k                                defconfig    clang-19
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
mips                       lemote2f_defconfig    gcc-15.2.0
nios2                            allmodconfig    clang-23
nios2                             allnoconfig    clang-23
nios2                               defconfig    clang-19
nios2                          randconfig-001    gcc-11.5.0
nios2                 randconfig-001-20260506    clang-23
nios2                 randconfig-001-20260506    gcc-11.5.0
nios2                          randconfig-002    gcc-11.5.0
nios2                 randconfig-002-20260506    clang-23
nios2                 randconfig-002-20260506    gcc-11.5.0
openrisc                         allmodconfig    clang-23
openrisc                          allnoconfig    clang-23
openrisc                            defconfig    gcc-15.2.0
openrisc                       virt_defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-23
parisc                           allyesconfig    clang-19
parisc                              defconfig    gcc-15.2.0
parisc                         randconfig-001    gcc-13.4.0
parisc                randconfig-001-20260506    gcc-13.4.0
parisc                randconfig-001-20260507    gcc-8.5.0
parisc                         randconfig-002    gcc-13.4.0
parisc                randconfig-002-20260506    gcc-13.4.0
parisc                randconfig-002-20260507    gcc-8.5.0
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                        randconfig-001    gcc-13.4.0
powerpc               randconfig-001-20260506    gcc-13.4.0
powerpc               randconfig-001-20260507    gcc-8.5.0
powerpc                        randconfig-002    gcc-13.4.0
powerpc               randconfig-002-20260506    gcc-13.4.0
powerpc               randconfig-002-20260507    gcc-8.5.0
powerpc64             randconfig-001-20260506    gcc-13.4.0
powerpc64             randconfig-001-20260507    gcc-8.5.0
powerpc64                      randconfig-002    gcc-13.4.0
powerpc64             randconfig-002-20260506    gcc-13.4.0
powerpc64             randconfig-002-20260507    gcc-8.5.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260506    gcc-8.5.0
riscv                 randconfig-002-20260506    gcc-8.5.0
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260506    gcc-8.5.0
s390                  randconfig-002-20260506    gcc-8.5.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                               allyesconfig    clang-19
sh                                  defconfig    gcc-14
sh                    randconfig-001-20260506    gcc-8.5.0
sh                    randconfig-002-20260506    gcc-8.5.0
sparc                             allnoconfig    clang-23
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260506    gcc-11.5.0
sparc                 randconfig-001-20260507    gcc-12.5.0
sparc                 randconfig-002-20260506    gcc-11.5.0
sparc                 randconfig-002-20260507    gcc-12.5.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260507    gcc-12.5.0
sparc64               randconfig-002-20260507    gcc-12.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260506    gcc-11.5.0
um                    randconfig-001-20260507    gcc-12.5.0
um                    randconfig-002-20260507    gcc-12.5.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260506    clang-20
x86_64      buildonly-randconfig-002-20260506    clang-20
x86_64      buildonly-randconfig-003-20260506    clang-20
x86_64      buildonly-randconfig-004-20260506    clang-20
x86_64      buildonly-randconfig-005-20260506    clang-20
x86_64      buildonly-randconfig-006-20260506    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                         randconfig-001    clang-20
x86_64                randconfig-001-20260506    clang-20
x86_64                randconfig-001-20260506    gcc-13
x86_64                         randconfig-002    clang-20
x86_64                randconfig-002-20260506    clang-20
x86_64                         randconfig-003    clang-20
x86_64                randconfig-003-20260506    clang-20
x86_64                         randconfig-004    clang-20
x86_64                randconfig-004-20260506    clang-20
x86_64                         randconfig-005    clang-20
x86_64                randconfig-005-20260506    clang-20
x86_64                randconfig-005-20260506    gcc-13
x86_64                         randconfig-006    clang-20
x86_64                randconfig-006-20260506    clang-20
x86_64                randconfig-011-20260506    clang-20
x86_64                randconfig-012-20260506    clang-20
x86_64                randconfig-013-20260506    clang-20
x86_64                randconfig-014-20260506    clang-20
x86_64                randconfig-015-20260506    clang-20
x86_64                randconfig-016-20260506    clang-20
x86_64                randconfig-071-20260506    clang-20
x86_64                randconfig-071-20260507    clang-20
x86_64                randconfig-072-20260506    clang-20
x86_64                randconfig-072-20260507    clang-20
x86_64                randconfig-073-20260506    clang-20
x86_64                randconfig-073-20260507    clang-20
x86_64                randconfig-074-20260506    clang-20
x86_64                randconfig-074-20260507    clang-20
x86_64                randconfig-075-20260506    clang-20
x86_64                randconfig-075-20260507    clang-20
x86_64                randconfig-076-20260506    clang-20
x86_64                randconfig-076-20260507    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-23
xtensa                           allyesconfig    clang-23
xtensa                randconfig-001-20260506    gcc-11.5.0
xtensa                randconfig-001-20260507    gcc-12.5.0
xtensa                randconfig-002-20260506    gcc-11.5.0
xtensa                randconfig-002-20260507    gcc-12.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

