Return-Path: <linux-wireless+bounces-34100-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SBaVAr2fx2m0ZwUAu9opvQ
	(envelope-from <linux-wireless+bounces-34100-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 28 Mar 2026 10:30:37 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A4434DE94
	for <lists+linux-wireless@lfdr.de>; Sat, 28 Mar 2026 10:30:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 394DC302EE9C
	for <lists+linux-wireless@lfdr.de>; Sat, 28 Mar 2026 09:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46D212BE7BB;
	Sat, 28 Mar 2026 09:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fK+UBQEi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E970F233149
	for <linux-wireless@vger.kernel.org>; Sat, 28 Mar 2026 09:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774690095; cv=none; b=d2qInd2d252IDLbqJblxVEmoHUILsoo3O0a7ImoqKTF+uHzOhITINTjAUwIa1DKo57Tl3AWCcg9ZQ46l3shGN/btKB1eNscX0Q+vFpAO/N8aVuEs6u9nrJlkF9qDBNm028kZ3Iigxb+VIwlvaB0PNyQjPrWAsmynhw0wMJ3yuXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774690095; c=relaxed/simple;
	bh=qrrwfT1H0T4CnE8JJPsNrJPdJ9kpXk293MFbXt4apYM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=BW9//QcJTT2T4jNvd1Hzp/9Oj0CFA3yCN8tqkbxtHeEFbi+lAjn8kjHMnsp1Cz6ug57t09Oqzy0x4DpvBvCbpYICVKZU5rN91Jq7lqRqUoyaiEGCNcRs5OIZD0TmQ5yTZFuCRy0Ie1CcjgzWgLh4DXszAAFWfKPWuLisuyKRNfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fK+UBQEi; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774690093; x=1806226093;
  h=date:from:to:cc:subject:message-id;
  bh=qrrwfT1H0T4CnE8JJPsNrJPdJ9kpXk293MFbXt4apYM=;
  b=fK+UBQEi7q7+mS51VK0myzCch0m4oNHUJwDbbjBboJLj4vuDzbmxtKU6
   ujI7jS3zrIp0drEv6iPly2AJbSAkHW5S/PaOj8ZTxt9Wy+EfixALuCdgp
   W6v/hV1s+d8oiK8ctwjfhWIpGPgwFrtd/e1xT2z/nT3bmLkgIuydrp1KX
   K+MqiUA7bn5ESDRCaCJvqGW8wdfxiD6Ho/ui5mQWgfOPykgNfV51Oz2z4
   2pK5NKQzsae5xj2MNr9+pkTaJFHWvZQqRmt+Ij3SI35E5hJEmPNJNUgw3
   cbWH0VmvmlBN+86SJFlLIxNtTs/QW3IIP9tbq+4Z9+bNTv/xcTlDJ4Jk0
   Q==;
X-CSE-ConnectionGUID: F0WsIyNPQTKykVrl7LiyCw==
X-CSE-MsgGUID: vCRilMA2R1q7FHD7+rEA2w==
X-IronPort-AV: E=McAfee;i="6800,10657,11742"; a="75464242"
X-IronPort-AV: E=Sophos;i="6.23,145,1770624000"; 
   d="scan'208";a="75464242"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2026 02:28:13 -0700
X-CSE-ConnectionGUID: XKIsLMtJQvSu9ELbq7Typw==
X-CSE-MsgGUID: f1PPctTHTnW4wS97ODOQQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,145,1770624000"; 
   d="scan'208";a="230324389"
Received: from lkp-server01.sh.intel.com (HELO 3905d212be1b) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 28 Mar 2026 02:28:11 -0700
Received: from kbuild by 3905d212be1b with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w6Pxg-00000000BGj-2ADh;
	Sat, 28 Mar 2026 09:28:08 +0000
Date: Sat, 28 Mar 2026 17:27:35 +0800
From: kernel test robot <lkp@intel.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>,
 linux-wireless@vger.kernel.org
Subject: [wireless-next:main] BUILD SUCCESS
 dbd94b9831bc52a1efb7ff3de841ffc3457428ce
Message-ID: <202603281727.eHMK7ZQb-lkp@intel.com>
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
	DKIM_TRACE(0.00)[intel.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34100-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 49A4434DE94
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: dbd94b9831bc52a1efb7ff3de841ffc3457428ce  Merge tag 'wireless-next-2026-03-26' of https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next

elapsed time: 1547m

configs tested: 280
configs skipped: 12

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
arc                                 defconfig    gcc-15.2.0
arc                   randconfig-001-20260327    gcc-8.5.0
arc                   randconfig-001-20260328    gcc-15.2.0
arc                   randconfig-002-20260327    gcc-8.5.0
arc                   randconfig-002-20260328    gcc-15.2.0
arm                               allnoconfig    clang-23
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.2.0
arm                                 defconfig    gcc-15.2.0
arm                   randconfig-001-20260327    gcc-8.5.0
arm                   randconfig-001-20260328    gcc-15.2.0
arm                   randconfig-002-20260327    gcc-8.5.0
arm                   randconfig-002-20260328    gcc-15.2.0
arm                   randconfig-003-20260327    gcc-8.5.0
arm                   randconfig-003-20260328    gcc-15.2.0
arm                   randconfig-004-20260327    gcc-8.5.0
arm                   randconfig-004-20260328    gcc-15.2.0
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260327    clang-23
arm64                 randconfig-001-20260328    gcc-14.3.0
arm64                 randconfig-002-20260327    clang-23
arm64                 randconfig-002-20260328    gcc-14.3.0
arm64                 randconfig-003-20260327    clang-23
arm64                 randconfig-003-20260328    gcc-14.3.0
arm64                 randconfig-004-20260327    clang-23
arm64                 randconfig-004-20260328    gcc-14.3.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260327    clang-23
csky                  randconfig-001-20260328    gcc-14.3.0
csky                  randconfig-002-20260327    clang-23
csky                  randconfig-002-20260328    gcc-14.3.0
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-23
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260327    gcc-8.5.0
hexagon               randconfig-001-20260328    gcc-11.5.0
hexagon               randconfig-002-20260327    gcc-8.5.0
hexagon               randconfig-002-20260328    gcc-11.5.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260327    clang-20
i386        buildonly-randconfig-001-20260328    clang-20
i386        buildonly-randconfig-002-20260327    clang-20
i386        buildonly-randconfig-002-20260328    clang-20
i386        buildonly-randconfig-003-20260327    clang-20
i386        buildonly-randconfig-003-20260328    clang-20
i386        buildonly-randconfig-004-20260327    clang-20
i386        buildonly-randconfig-004-20260328    clang-20
i386        buildonly-randconfig-005-20260327    clang-20
i386        buildonly-randconfig-005-20260328    clang-20
i386        buildonly-randconfig-006-20260327    clang-20
i386        buildonly-randconfig-006-20260328    clang-20
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260327    clang-20
i386                  randconfig-001-20260328    clang-20
i386                  randconfig-002-20260327    clang-20
i386                  randconfig-002-20260328    clang-20
i386                  randconfig-003-20260327    clang-20
i386                  randconfig-003-20260328    clang-20
i386                  randconfig-004-20260327    clang-20
i386                  randconfig-004-20260328    clang-20
i386                  randconfig-005-20260327    clang-20
i386                  randconfig-005-20260328    clang-20
i386                  randconfig-006-20260327    clang-20
i386                  randconfig-006-20260328    clang-20
i386                  randconfig-007-20260327    clang-20
i386                  randconfig-007-20260328    clang-20
i386                  randconfig-011-20260327    gcc-14
i386                  randconfig-011-20260328    gcc-13
i386                  randconfig-012-20260327    gcc-14
i386                  randconfig-012-20260328    gcc-13
i386                  randconfig-013-20260327    gcc-14
i386                  randconfig-013-20260328    gcc-13
i386                  randconfig-014-20260327    gcc-14
i386                  randconfig-014-20260328    gcc-13
i386                  randconfig-015-20260327    gcc-14
i386                  randconfig-015-20260328    gcc-13
i386                  randconfig-016-20260327    gcc-14
i386                  randconfig-016-20260328    gcc-13
i386                  randconfig-017-20260327    gcc-14
i386                  randconfig-017-20260328    gcc-13
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260327    gcc-8.5.0
loongarch             randconfig-001-20260328    gcc-11.5.0
loongarch             randconfig-002-20260327    gcc-8.5.0
loongarch             randconfig-002-20260328    gcc-11.5.0
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
mips                           ci20_defconfig    clang-23
mips                     cu1000-neo_defconfig    gcc-15.2.0
mips                  decstation_64_defconfig    gcc-15.2.0
mips                           ip27_defconfig    gcc-15.2.0
nios2                            allmodconfig    clang-23
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-23
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260327    gcc-8.5.0
nios2                 randconfig-001-20260328    gcc-11.5.0
nios2                 randconfig-002-20260327    gcc-8.5.0
nios2                 randconfig-002-20260328    gcc-11.5.0
openrisc                         allmodconfig    clang-23
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    clang-23
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-23
parisc                           allyesconfig    clang-19
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260327    clang-18
parisc                randconfig-001-20260328    gcc-10.5.0
parisc                randconfig-002-20260327    clang-18
parisc                randconfig-002-20260328    gcc-10.5.0
parisc64                            defconfig    clang-19
powerpc                     akebono_defconfig    clang-23
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                 mpc837x_rdb_defconfig    gcc-15.2.0
powerpc               randconfig-001-20260327    clang-18
powerpc               randconfig-001-20260328    gcc-10.5.0
powerpc               randconfig-002-20260327    clang-18
powerpc               randconfig-002-20260328    gcc-10.5.0
powerpc64             randconfig-001-20260327    clang-18
powerpc64             randconfig-001-20260328    gcc-10.5.0
powerpc64             randconfig-002-20260327    clang-18
powerpc64             randconfig-002-20260328    gcc-10.5.0
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    clang-23
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260327    gcc-12.5.0
riscv                 randconfig-001-20260328    clang-23
riscv                 randconfig-002-20260327    gcc-12.5.0
riscv                 randconfig-002-20260328    clang-23
s390                             allmodconfig    clang-18
s390                             allmodconfig    clang-19
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260327    gcc-12.5.0
s390                  randconfig-001-20260328    clang-23
s390                  randconfig-002-20260327    gcc-12.5.0
s390                  randconfig-002-20260328    clang-23
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-23
sh                               allyesconfig    clang-19
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sh                    randconfig-001-20260327    gcc-12.5.0
sh                    randconfig-001-20260328    clang-23
sh                    randconfig-002-20260327    gcc-12.5.0
sh                    randconfig-002-20260328    clang-23
sh                           se7705_defconfig    gcc-15.2.0
sparc                             allnoconfig    clang-23
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260327    gcc-14
sparc                 randconfig-001-20260327    gcc-14.3.0
sparc                 randconfig-001-20260328    gcc-14
sparc                 randconfig-002-20260327    gcc-14
sparc                 randconfig-002-20260327    gcc-14.3.0
sparc                 randconfig-002-20260328    gcc-14
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260327    gcc-14
sparc64               randconfig-001-20260327    gcc-14.3.0
sparc64               randconfig-001-20260328    gcc-14
sparc64               randconfig-002-20260327    gcc-14
sparc64               randconfig-002-20260327    gcc-14.3.0
sparc64               randconfig-002-20260328    gcc-14
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260327    gcc-14
um                    randconfig-001-20260328    gcc-14
um                    randconfig-002-20260327    gcc-14
um                    randconfig-002-20260327    gcc-14.3.0
um                    randconfig-002-20260328    gcc-14
um                           x86_64_defconfig    clang-23
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260327    clang-20
x86_64      buildonly-randconfig-001-20260328    clang-20
x86_64      buildonly-randconfig-002-20260327    clang-20
x86_64      buildonly-randconfig-002-20260328    clang-20
x86_64      buildonly-randconfig-003-20260327    clang-20
x86_64      buildonly-randconfig-003-20260328    clang-20
x86_64      buildonly-randconfig-004-20260327    clang-20
x86_64      buildonly-randconfig-004-20260328    clang-20
x86_64      buildonly-randconfig-005-20260327    clang-20
x86_64      buildonly-randconfig-005-20260328    clang-20
x86_64      buildonly-randconfig-006-20260327    clang-20
x86_64      buildonly-randconfig-006-20260328    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260327    gcc-14
x86_64                randconfig-001-20260328    gcc-14
x86_64                randconfig-002-20260327    gcc-14
x86_64                randconfig-002-20260328    gcc-14
x86_64                randconfig-003-20260327    gcc-14
x86_64                randconfig-003-20260328    gcc-14
x86_64                randconfig-004-20260327    gcc-14
x86_64                randconfig-004-20260328    gcc-14
x86_64                randconfig-005-20260327    gcc-14
x86_64                randconfig-005-20260328    gcc-14
x86_64                randconfig-006-20260327    gcc-14
x86_64                randconfig-006-20260328    gcc-14
x86_64                randconfig-011-20260327    gcc-14
x86_64                randconfig-011-20260328    clang-20
x86_64                randconfig-012-20260327    gcc-14
x86_64                randconfig-012-20260328    clang-20
x86_64                randconfig-013-20260327    gcc-14
x86_64                randconfig-013-20260328    clang-20
x86_64                randconfig-014-20260327    gcc-14
x86_64                randconfig-014-20260328    clang-20
x86_64                randconfig-015-20260327    gcc-14
x86_64                randconfig-015-20260328    clang-20
x86_64                randconfig-016-20260327    gcc-14
x86_64                randconfig-016-20260328    clang-20
x86_64                randconfig-071-20260327    gcc-13
x86_64                randconfig-071-20260328    gcc-12
x86_64                randconfig-072-20260327    gcc-13
x86_64                randconfig-072-20260328    gcc-12
x86_64                randconfig-073-20260327    gcc-13
x86_64                randconfig-073-20260328    gcc-12
x86_64                randconfig-074-20260327    gcc-13
x86_64                randconfig-074-20260328    gcc-12
x86_64                randconfig-075-20260327    gcc-13
x86_64                randconfig-075-20260328    gcc-12
x86_64                randconfig-076-20260327    gcc-13
x86_64                randconfig-076-20260328    gcc-12
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-23
xtensa                           allyesconfig    clang-23
xtensa                           allyesconfig    gcc-15.2.0
xtensa                randconfig-001-20260327    gcc-14
xtensa                randconfig-001-20260327    gcc-14.3.0
xtensa                randconfig-001-20260328    gcc-14
xtensa                randconfig-002-20260327    gcc-14
xtensa                randconfig-002-20260327    gcc-14.3.0
xtensa                randconfig-002-20260328    gcc-14
xtensa                    smp_lx200_defconfig    gcc-15.2.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

