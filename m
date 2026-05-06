Return-Path: <linux-wireless+bounces-35965-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0ClFOSme+mk8QQMAu9opvQ
	(envelope-from <linux-wireless+bounces-35965-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 06 May 2026 03:49:29 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E70D4D5703
	for <lists+linux-wireless@lfdr.de>; Wed, 06 May 2026 03:49:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EE0D330471DE
	for <lists+linux-wireless@lfdr.de>; Wed,  6 May 2026 01:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2116258EFF;
	Wed,  6 May 2026 01:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E+1I59nz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77A9242D6B
	for <linux-wireless@vger.kernel.org>; Wed,  6 May 2026 01:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778032156; cv=none; b=VVHVJ/akEmmPpMy4iFBhawQ1b5XeIkL55HW6G3sQcoWZAJQw5K3tFXc8ZQw7w2HlHQkggqDkSyyxIbkJmgylhvfjOsViF8zytAbpU89vX1RMcE6KO+zjY5GtCx5QvuhZ1C4/YxZdD8WPZA8rEy3z0HLRho8ldDeuNArbZrhaaQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778032156; c=relaxed/simple;
	bh=NDYwGdPXO5eGxvKAfxiIU6qp5BrlH19jtP9DspHVnBs=;
	h=Date:From:To:Cc:Subject:Message-ID; b=k+h+POTmDtC1oCMDHiDzi7KZakwOw2Zraymoep62lyTbF0FfXcnKwV6eXwokiZk4VuKBxXYHouaaIj5mmKx+EC30P5GhSFuqitYJUKGwX+pW/x0ygp8vE204OenePj4APaPoPP6pvrRxkjA0ZlrAMgE775Lq+wKB4AxKeVvaMrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E+1I59nz; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778032155; x=1809568155;
  h=date:from:to:cc:subject:message-id;
  bh=NDYwGdPXO5eGxvKAfxiIU6qp5BrlH19jtP9DspHVnBs=;
  b=E+1I59nzxhVn3ifr2P4ggIndhyLg8ZrdVp3dKM0H3Lu9clR1tDCquu9/
   XyQeHSJ/IyrMiWHRvfVrzcpdGRudcICtpOm3Qc0rebj0XgWg3rXHITehc
   KhiCwVFJXFbD3CfKY45pOHkBuEl4Dwj3G3VMjezeDCgFglQ0rQbUc0wSG
   hJKjqp+FMTj/YgW7dRv3/8tSDYOFBijmhV8USyaiaAD3wD8y0IRSXiL3P
   0hTdApRqd+MOk+syA/VMqa7oxtlHCrmnNRUdRn/FG4dlU+GVyrgioV+h7
   KAH31ox9WVHnqACC4nKihTiCGRFPzJUGxYRz1BsPT0fx1PS0msODSZRDc
   Q==;
X-CSE-ConnectionGUID: rxCa3zWfRzSQ6X2ahPcQ7A==
X-CSE-MsgGUID: Q8yrc3csTy6XckUemX+6tA==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="78777924"
X-IronPort-AV: E=Sophos;i="6.23,218,1770624000"; 
   d="scan'208";a="78777924"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 18:49:14 -0700
X-CSE-ConnectionGUID: SS29Xyf8TQy3F4MnFN51iA==
X-CSE-MsgGUID: WUrijhJVRWaMLguoX5qC2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,218,1770624000"; 
   d="scan'208";a="236227167"
Received: from lkp-server01.sh.intel.com (HELO 9ec114424ce8) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 05 May 2026 18:49:13 -0700
Received: from kbuild by 9ec114424ce8 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wKRNu-000000000c5-0ux6;
	Wed, 06 May 2026 01:49:10 +0000
Date: Wed, 06 May 2026 09:48:11 +0800
From: kernel test robot <lkp@intel.com>
To: Johannes Berg <johannes.berg@intel.com>
Cc: linux-wireless@vger.kernel.org
Subject: [wireless-next:main] BUILD SUCCESS
 d2ffdadd4aca41d120e25f6a675dd6a4d77ce360
Message-ID: <202605060901.wJruIhFh-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
X-Rspamd-Queue-Id: 5E70D4D5703
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35965-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:dkim,intel.com:mid]

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: d2ffdadd4aca41d120e25f6a675dd6a4d77ce360  wifi: mac80211: check AP using NPCA has NPCA capability

elapsed time: 732m

configs tested: 291
configs skipped: 29

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
arm                          exynos_defconfig    clang-23
arm                   randconfig-001-20260506    gcc-12.5.0
arm                   randconfig-002-20260506    gcc-12.5.0
arm                   randconfig-003-20260506    gcc-12.5.0
arm                   randconfig-004-20260506    gcc-12.5.0
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                          randconfig-001    gcc-14.3.0
arm64                 randconfig-001-20260505    gcc-14.3.0
arm64                 randconfig-001-20260506    gcc-15.2.0
arm64                          randconfig-002    gcc-14.3.0
arm64                 randconfig-002-20260505    gcc-14.3.0
arm64                 randconfig-002-20260506    gcc-15.2.0
arm64                          randconfig-003    gcc-14.3.0
arm64                 randconfig-003-20260505    gcc-14.3.0
arm64                 randconfig-003-20260506    gcc-15.2.0
arm64                          randconfig-004    gcc-14.3.0
arm64                 randconfig-004-20260505    gcc-14.3.0
arm64                 randconfig-004-20260506    gcc-15.2.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                           randconfig-001    gcc-14.3.0
csky                  randconfig-001-20260505    gcc-14.3.0
csky                  randconfig-001-20260506    gcc-15.2.0
csky                           randconfig-002    gcc-14.3.0
csky                  randconfig-002-20260505    gcc-14.3.0
csky                  randconfig-002-20260506    gcc-15.2.0
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon                        randconfig-001    gcc-11.5.0
hexagon               randconfig-001-20260505    clang-23
hexagon               randconfig-001-20260506    clang-23
hexagon               randconfig-001-20260506    gcc-11.5.0
hexagon                        randconfig-002    gcc-11.5.0
hexagon               randconfig-002-20260505    clang-23
hexagon               randconfig-002-20260506    clang-23
hexagon               randconfig-002-20260506    gcc-11.5.0
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386                 buildonly-randconfig-001    clang-20
i386        buildonly-randconfig-001-20260505    gcc-14
i386        buildonly-randconfig-001-20260506    clang-20
i386                 buildonly-randconfig-002    clang-20
i386        buildonly-randconfig-002-20260505    gcc-14
i386        buildonly-randconfig-002-20260506    clang-20
i386                 buildonly-randconfig-003    clang-20
i386        buildonly-randconfig-003-20260505    gcc-14
i386        buildonly-randconfig-003-20260506    clang-20
i386                 buildonly-randconfig-004    clang-20
i386        buildonly-randconfig-004-20260505    gcc-14
i386        buildonly-randconfig-004-20260506    clang-20
i386                 buildonly-randconfig-005    clang-20
i386        buildonly-randconfig-005-20260505    gcc-14
i386        buildonly-randconfig-005-20260506    clang-20
i386                 buildonly-randconfig-006    clang-20
i386        buildonly-randconfig-006-20260505    gcc-14
i386        buildonly-randconfig-006-20260506    clang-20
i386                                defconfig    gcc-15.2.0
i386                           randconfig-001    gcc-14
i386                  randconfig-001-20260505    clang-20
i386                  randconfig-001-20260506    gcc-14
i386                           randconfig-002    gcc-14
i386                  randconfig-002-20260505    clang-20
i386                  randconfig-002-20260506    gcc-14
i386                           randconfig-003    gcc-14
i386                  randconfig-003-20260505    clang-20
i386                  randconfig-003-20260506    gcc-14
i386                           randconfig-004    gcc-14
i386                  randconfig-004-20260505    clang-20
i386                  randconfig-004-20260506    gcc-14
i386                           randconfig-005    gcc-14
i386                  randconfig-005-20260505    clang-20
i386                  randconfig-005-20260506    gcc-14
i386                           randconfig-006    gcc-14
i386                  randconfig-006-20260505    clang-20
i386                  randconfig-006-20260506    gcc-14
i386                           randconfig-007    gcc-14
i386                  randconfig-007-20260505    clang-20
i386                  randconfig-007-20260506    gcc-14
i386                  randconfig-011-20260506    clang-20
i386                  randconfig-012-20260506    clang-20
i386                  randconfig-013-20260506    clang-20
i386                  randconfig-014-20260506    clang-20
i386                  randconfig-014-20260506    gcc-14
i386                  randconfig-015-20260506    clang-20
i386                  randconfig-015-20260506    gcc-14
i386                  randconfig-016-20260506    clang-20
i386                  randconfig-017-20260506    clang-20
loongarch                        allmodconfig    clang-23
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch                      randconfig-001    gcc-11.5.0
loongarch             randconfig-001-20260505    clang-23
loongarch             randconfig-001-20260506    clang-23
loongarch             randconfig-001-20260506    gcc-11.5.0
loongarch                      randconfig-002    gcc-11.5.0
loongarch             randconfig-002-20260505    clang-23
loongarch             randconfig-002-20260506    clang-23
loongarch             randconfig-002-20260506    gcc-11.5.0
m68k                             allmodconfig    gcc-15.2.0
m68k                              allnoconfig    gcc-15.2.0
m68k                             allyesconfig    clang-16
m68k                                defconfig    clang-19
m68k                                defconfig    gcc-15.2.0
microblaze                        allnoconfig    gcc-15.2.0
microblaze                       allyesconfig    gcc-15.2.0
microblaze                          defconfig    clang-19
microblaze                          defconfig    gcc-15.2.0
mips                             allmodconfig    gcc-15.2.0
mips                              allnoconfig    gcc-15.2.0
mips                             allyesconfig    gcc-15.2.0
nios2                            alldefconfig    gcc-11.5.0
nios2                            allmodconfig    clang-23
nios2                             allnoconfig    clang-23
nios2                               defconfig    clang-19
nios2                               defconfig    gcc-15.2.0
nios2                          randconfig-001    gcc-11.5.0
nios2                 randconfig-001-20260505    clang-23
nios2                 randconfig-001-20260506    clang-23
nios2                 randconfig-001-20260506    gcc-11.5.0
nios2                 randconfig-001-20260506    gcc-8.5.0
nios2                          randconfig-002    gcc-11.5.0
nios2                 randconfig-002-20260505    clang-23
nios2                 randconfig-002-20260506    clang-23
nios2                 randconfig-002-20260506    gcc-11.5.0
nios2                 randconfig-002-20260506    gcc-8.5.0
openrisc                         allmodconfig    clang-23
openrisc                          allnoconfig    clang-23
openrisc         de0_nano_multicore_defconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-23
parisc                           allyesconfig    clang-19
parisc                              defconfig    gcc-15.2.0
parisc                         randconfig-001    gcc-13.4.0
parisc                randconfig-001-20260505    gcc-14.3.0
parisc                randconfig-001-20260506    gcc-13.4.0
parisc                         randconfig-002    gcc-13.4.0
parisc                randconfig-002-20260505    gcc-14.3.0
parisc                randconfig-002-20260506    gcc-13.4.0
parisc64                            defconfig    clang-19
parisc64                            defconfig    gcc-15.2.0
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-23
powerpc                 mpc8315_rdb_defconfig    clang-23
powerpc                        randconfig-001    gcc-13.4.0
powerpc               randconfig-001-20260505    gcc-14.3.0
powerpc               randconfig-001-20260506    gcc-13.4.0
powerpc                        randconfig-002    gcc-13.4.0
powerpc               randconfig-002-20260505    gcc-14.3.0
powerpc               randconfig-002-20260506    gcc-13.4.0
powerpc64                      randconfig-001    gcc-13.4.0
powerpc64             randconfig-001-20260505    gcc-14.3.0
powerpc64             randconfig-001-20260506    gcc-13.4.0
powerpc64                      randconfig-002    gcc-13.4.0
powerpc64             randconfig-002-20260505    gcc-14.3.0
powerpc64             randconfig-002-20260506    gcc-13.4.0
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
sh                         ap325rxa_defconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sh                    randconfig-001-20260506    gcc-8.5.0
sh                    randconfig-002-20260506    gcc-8.5.0
sparc                             allnoconfig    clang-23
sparc                               defconfig    gcc-15.2.0
sparc                          randconfig-001    gcc-15.2.0
sparc                 randconfig-001-20260505    gcc-15.2.0
sparc                 randconfig-001-20260506    gcc-11.5.0
sparc                          randconfig-002    gcc-15.2.0
sparc                 randconfig-002-20260505    gcc-15.2.0
sparc                 randconfig-002-20260506    gcc-11.5.0
sparc64                          allmodconfig    clang-23
sparc64                             defconfig    gcc-14
sparc64                        randconfig-001    gcc-15.2.0
sparc64               randconfig-001-20260505    gcc-15.2.0
sparc64               randconfig-001-20260506    gcc-11.5.0
sparc64                        randconfig-002    gcc-15.2.0
sparc64               randconfig-002-20260505    gcc-15.2.0
sparc64               randconfig-002-20260506    gcc-11.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-23
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                             randconfig-001    gcc-15.2.0
um                    randconfig-001-20260505    gcc-15.2.0
um                    randconfig-001-20260506    gcc-11.5.0
um                             randconfig-002    gcc-15.2.0
um                    randconfig-002-20260505    gcc-15.2.0
um                    randconfig-002-20260506    gcc-11.5.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-23
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260506    clang-20
x86_64      buildonly-randconfig-002-20260506    clang-20
x86_64      buildonly-randconfig-002-20260506    gcc-14
x86_64      buildonly-randconfig-003-20260505    gcc-14
x86_64      buildonly-randconfig-003-20260506    clang-20
x86_64      buildonly-randconfig-004-20260506    clang-20
x86_64      buildonly-randconfig-005-20260505    gcc-14
x86_64      buildonly-randconfig-005-20260506    clang-20
x86_64      buildonly-randconfig-005-20260506    gcc-14
x86_64      buildonly-randconfig-006-20260505    gcc-14
x86_64      buildonly-randconfig-006-20260506    clang-20
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-001-20260505    clang-20
x86_64                randconfig-001-20260506    clang-20
x86_64                randconfig-002-20260505    clang-20
x86_64                randconfig-002-20260506    clang-20
x86_64                randconfig-003-20260505    clang-20
x86_64                randconfig-003-20260506    clang-20
x86_64                randconfig-004-20260505    clang-20
x86_64                randconfig-004-20260506    clang-20
x86_64                randconfig-005-20260505    clang-20
x86_64                randconfig-005-20260506    clang-20
x86_64                randconfig-006-20260505    clang-20
x86_64                randconfig-006-20260506    clang-20
x86_64                randconfig-011-20260506    clang-20
x86_64                randconfig-012-20260506    clang-20
x86_64                randconfig-013-20260506    clang-20
x86_64                randconfig-014-20260506    clang-20
x86_64                randconfig-015-20260506    clang-20
x86_64                randconfig-015-20260506    gcc-12
x86_64                randconfig-016-20260506    clang-20
x86_64                randconfig-016-20260506    gcc-12
x86_64                         randconfig-071    clang-20
x86_64                randconfig-071-20260505    clang-20
x86_64                randconfig-071-20260506    clang-20
x86_64                         randconfig-072    clang-20
x86_64                randconfig-072-20260505    clang-20
x86_64                randconfig-072-20260506    clang-20
x86_64                         randconfig-073    clang-20
x86_64                randconfig-073-20260505    clang-20
x86_64                randconfig-073-20260506    clang-20
x86_64                         randconfig-074    clang-20
x86_64                randconfig-074-20260505    clang-20
x86_64                randconfig-074-20260506    clang-20
x86_64                         randconfig-075    clang-20
x86_64                randconfig-075-20260505    clang-20
x86_64                randconfig-075-20260506    clang-20
x86_64                         randconfig-076    clang-20
x86_64                randconfig-076-20260505    clang-20
x86_64                randconfig-076-20260506    clang-20
x86_64                               rhel-9.4    clang-20
x86_64                           rhel-9.4-bpf    gcc-14
x86_64                          rhel-9.4-func    clang-20
x86_64                    rhel-9.4-kselftests    clang-20
x86_64                         rhel-9.4-kunit    gcc-14
x86_64                           rhel-9.4-ltp    gcc-14
x86_64                          rhel-9.4-rust    clang-20
xtensa                            allnoconfig    clang-23
xtensa                           allyesconfig    clang-23
xtensa                         randconfig-001    gcc-15.2.0
xtensa                randconfig-001-20260505    gcc-15.2.0
xtensa                randconfig-001-20260506    gcc-11.5.0
xtensa                         randconfig-002    gcc-15.2.0
xtensa                randconfig-002-20260505    gcc-15.2.0
xtensa                randconfig-002-20260506    gcc-11.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

