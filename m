Return-Path: <linux-wireless+bounces-33551-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WIKkCGfdvGmb3wIAu9opvQ
	(envelope-from <linux-wireless+bounces-33551-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 06:38:47 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CDB32D5FDD
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 06:38:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DF18F3069AD4
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 05:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79DC52E62AC;
	Fri, 20 Mar 2026 05:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UIiFjYE6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B7C2D9EE8
	for <linux-wireless@vger.kernel.org>; Fri, 20 Mar 2026 05:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773985124; cv=none; b=D7jKQ435a4ONCPbqFRIETUT8Ad1+vwntkTOdsqxIYkP9FPoHmJZdEJQyKpFbk3EaoYU1vlSTz7qrDvotmmNqXIhgWBXWmlFLA5ahA/Jk93je7wBBqyvrEGAt4MciCKWUsqZrLrOV1XfSJ1uFra4YUP+GDmPA5ML0X7w3NhDsup4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773985124; c=relaxed/simple;
	bh=mjvE0RXuE28yAkLeeT7WfDc9a0TwHjJCgdgOaJS/PRo=;
	h=Date:From:To:Cc:Subject:Message-ID; b=vEFQgNj8DwUof7uNi/sNQI7+5l1LtbHIbAX8QODcKVqYPqP62hLSXArRETaqQzHJR3p1kPwbLC4JgOIYFCypVcu9UhEGYPV6SC//Xwu8FJwFHWo6s6nVLYNSqMSaFoOWxauGR+TOmwmNKa+7Z8fwxNZiulBLJagfoUvit+hFkYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UIiFjYE6; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773985122; x=1805521122;
  h=date:from:to:cc:subject:message-id;
  bh=mjvE0RXuE28yAkLeeT7WfDc9a0TwHjJCgdgOaJS/PRo=;
  b=UIiFjYE6Mtx+vcxzawg6zihGRM8Ua/YUx859BT3rteDWYVdCdybf5ESR
   EV4Bt6rL0IWSI8GEUvHuVIgSPw3xIux0bXRuweElryTVhen16lW/VUqU0
   gdefAt0YMl78Nozbi2nOEib6wz3VwwfTRhTi/mZANBOYkVb7HEjgIllgu
   h4+iJ3+Qk8owBp8PEpfc5nr6hLSrelg8/9dCUIrbpcsSWhiGk3gs0jIWc
   WFaTKNLO3daKkaAvIa2nTfOkWQVosOvPJ/KxhMIoxUpvVHRZWVNPKhOnu
   SrjMn0FeHaaDXrXmxw3pMucnIX7LJEumn1bH1zXhKFzesjbOZw7HPKGDQ
   w==;
X-CSE-ConnectionGUID: /qFvaEQrR2qXszca2lk0gw==
X-CSE-MsgGUID: ksUgsFD8Qq6VKVjTDZmPaw==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="77674253"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="77674253"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2026 22:38:42 -0700
X-CSE-ConnectionGUID: 6HMLH6atQCyFwZKI8oQKkQ==
X-CSE-MsgGUID: 3WjSZbtqQEiGSN1NnSgw+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="253684838"
Received: from lkp-server02.sh.intel.com (HELO a51c2a36b9df) ([10.239.97.151])
  by orviesa002.jf.intel.com with ESMTP; 19 Mar 2026 22:38:40 -0700
Received: from kbuild by a51c2a36b9df with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w3SXq-0000000020t-2EOH;
	Fri, 20 Mar 2026 05:37:27 +0000
Date: Fri, 20 Mar 2026 13:34:39 +0800
From: kernel test robot <lkp@intel.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>,
 linux-wireless@vger.kernel.org
Subject: [wireless:for-next] BUILD SUCCESS
 7c46bd845d89ad4772573cfe0f2a56b93db75cc7
Message-ID: <202603201332.O3fxsf7N-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
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
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33551-lists,linux-wireless=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.990];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2CDB32D5FDD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git for-next
branch HEAD: 7c46bd845d89ad4772573cfe0f2a56b93db75cc7  Merge tag 'wireless-2026-03-18' of https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless

elapsed time: 1619m

configs tested: 227
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-15.2.0
alpha                            allyesconfig    gcc-15.2.0
alpha                               defconfig    gcc-15.2.0
arc                              allmodconfig    clang-16
arc                              allmodconfig    gcc-15.2.0
arc                               allnoconfig    gcc-15.2.0
arc                              allyesconfig    clang-23
arc                              allyesconfig    gcc-15.2.0
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260319    gcc-11.5.0
arc                   randconfig-001-20260320    gcc-13.4.0
arc                   randconfig-002-20260319    gcc-11.5.0
arc                   randconfig-002-20260320    gcc-13.4.0
arm                               allnoconfig    clang-23
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.2.0
arm                        clps711x_defconfig    clang-23
arm                                 defconfig    gcc-15.2.0
arm                   randconfig-001-20260319    gcc-11.5.0
arm                   randconfig-001-20260320    gcc-13.4.0
arm                   randconfig-002-20260319    gcc-11.5.0
arm                   randconfig-002-20260320    gcc-13.4.0
arm                   randconfig-003-20260319    gcc-11.5.0
arm                   randconfig-003-20260320    gcc-13.4.0
arm                   randconfig-004-20260319    gcc-11.5.0
arm                   randconfig-004-20260320    gcc-13.4.0
arm                       spear13xx_defconfig    gcc-15.2.0
arm64                            allmodconfig    clang-19
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260320    clang-17
arm64                 randconfig-002-20260320    clang-17
arm64                 randconfig-003-20260320    clang-17
arm64                 randconfig-004-20260320    clang-17
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260320    clang-17
csky                  randconfig-002-20260320    clang-17
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260320    gcc-8.5.0
hexagon               randconfig-002-20260320    gcc-8.5.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260319    gcc-14
i386        buildonly-randconfig-001-20260320    gcc-14
i386        buildonly-randconfig-002-20260319    gcc-14
i386        buildonly-randconfig-002-20260320    gcc-14
i386        buildonly-randconfig-003-20260319    gcc-14
i386        buildonly-randconfig-003-20260320    gcc-14
i386        buildonly-randconfig-004-20260319    gcc-14
i386        buildonly-randconfig-004-20260320    gcc-14
i386        buildonly-randconfig-005-20260319    gcc-14
i386        buildonly-randconfig-005-20260320    gcc-14
i386        buildonly-randconfig-006-20260319    gcc-14
i386        buildonly-randconfig-006-20260320    gcc-14
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260319    gcc-14
i386                  randconfig-001-20260320    clang-20
i386                  randconfig-002-20260319    gcc-14
i386                  randconfig-002-20260320    clang-20
i386                  randconfig-003-20260319    gcc-14
i386                  randconfig-003-20260320    clang-20
i386                  randconfig-004-20260319    gcc-14
i386                  randconfig-004-20260320    clang-20
i386                  randconfig-005-20260319    gcc-14
i386                  randconfig-005-20260320    clang-20
i386                  randconfig-006-20260319    gcc-14
i386                  randconfig-006-20260320    clang-20
i386                  randconfig-007-20260319    gcc-14
i386                  randconfig-007-20260320    clang-20
i386                  randconfig-011-20260319    clang-20
i386                  randconfig-011-20260320    clang-20
i386                  randconfig-012-20260319    clang-20
i386                  randconfig-012-20260320    clang-20
i386                  randconfig-013-20260319    clang-20
i386                  randconfig-013-20260320    clang-20
i386                  randconfig-014-20260319    clang-20
i386                  randconfig-014-20260320    clang-20
i386                  randconfig-015-20260319    clang-20
i386                  randconfig-015-20260320    clang-20
i386                  randconfig-016-20260319    clang-20
i386                  randconfig-016-20260320    clang-20
i386                  randconfig-017-20260319    clang-20
i386                  randconfig-017-20260320    clang-20
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260320    gcc-8.5.0
loongarch             randconfig-002-20260320    gcc-8.5.0
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                             allyesconfig    gcc-15.2.0
m68k                                defconfig    clang-19
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
nios2                            allmodconfig    clang-23
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-23
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260320    gcc-8.5.0
nios2                 randconfig-002-20260320    gcc-8.5.0
openrisc                         allmodconfig    clang-23
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    clang-23
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-23
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    clang-19
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260320    gcc-10.5.0
parisc                randconfig-002-20260320    gcc-10.5.0
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                           allnoconfig    gcc-15.2.0
powerpc               randconfig-001-20260320    gcc-10.5.0
powerpc               randconfig-002-20260320    gcc-10.5.0
powerpc64             randconfig-001-20260320    gcc-10.5.0
powerpc64             randconfig-002-20260320    gcc-10.5.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260320    gcc-8.5.0
riscv                 randconfig-002-20260320    gcc-8.5.0
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260320    gcc-8.5.0
s390                  randconfig-002-20260320    gcc-8.5.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sh                    randconfig-001-20260320    gcc-8.5.0
sh                    randconfig-002-20260320    gcc-8.5.0
sparc                            alldefconfig    gcc-15.2.0
sparc                             allnoconfig    clang-23
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260319    gcc-8.5.0
sparc                 randconfig-001-20260320    gcc-14
sparc                 randconfig-002-20260319    gcc-8.5.0
sparc                 randconfig-002-20260320    gcc-14
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260319    gcc-8.5.0
sparc64               randconfig-001-20260320    gcc-14
sparc64               randconfig-002-20260319    gcc-8.5.0
sparc64               randconfig-002-20260320    gcc-14
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260319    gcc-8.5.0
um                    randconfig-001-20260320    gcc-14
um                    randconfig-002-20260319    gcc-8.5.0
um                    randconfig-002-20260320    gcc-14
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260320    clang-20
x86_64      buildonly-randconfig-002-20260320    clang-20
x86_64      buildonly-randconfig-003-20260320    clang-20
x86_64      buildonly-randconfig-004-20260320    clang-20
x86_64      buildonly-randconfig-005-20260320    clang-20
x86_64      buildonly-randconfig-006-20260320    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260320    clang-20
x86_64                randconfig-002-20260320    clang-20
x86_64                randconfig-003-20260320    clang-20
x86_64                randconfig-004-20260320    clang-20
x86_64                randconfig-005-20260320    clang-20
x86_64                randconfig-006-20260320    clang-20
x86_64                randconfig-071-20260320    gcc-14
x86_64                randconfig-072-20260320    gcc-14
x86_64                randconfig-073-20260320    gcc-14
x86_64                randconfig-074-20260320    gcc-14
x86_64                randconfig-075-20260320    gcc-14
x86_64                randconfig-076-20260320    gcc-14
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-23
xtensa                            allnoconfig    gcc-15.2.0
xtensa                           allyesconfig    clang-23
xtensa                           allyesconfig    gcc-15.2.0
xtensa                randconfig-001-20260319    gcc-8.5.0
xtensa                randconfig-001-20260320    gcc-14
xtensa                randconfig-002-20260319    gcc-8.5.0
xtensa                randconfig-002-20260320    gcc-14

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

