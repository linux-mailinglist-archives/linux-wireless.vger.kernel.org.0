Return-Path: <linux-wireless+bounces-31249-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SOc5DwZqeWmPwwEAu9opvQ
	(envelope-from <linux-wireless+bounces-31249-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Jan 2026 02:44:38 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D2939C02B
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Jan 2026 02:44:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E486A30209E8
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Jan 2026 01:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDE0A256C84;
	Wed, 28 Jan 2026 01:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H3cRS7WP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B5E18B0A
	for <linux-wireless@vger.kernel.org>; Wed, 28 Jan 2026 01:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769564648; cv=none; b=bktYM1+3tqEwpYhFzYUNw8GiKZDdwJ8zN4UPbYBYNRYiMyQQppRdu6onGD8ZFKzuDvN8ehVVzLCyOTdpSFigTw2/EtuDMhzk/XeYUHhTSvIt7xO2dgkZSFKrYh9BVXZgQrYPA/Z3MuF1pTYUW522vP05cONH9dZlGXf7CKo1C6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769564648; c=relaxed/simple;
	bh=4SRxdceyVxxWSJoSV+rVdn4zRtVpdRbtmqufbUc0tAM=;
	h=Date:From:To:Cc:Subject:Message-ID; b=DFZXFHIfIqf9RFsSL+1eNZa7jUcFGYJzwlkXf/U2r+TxjNQTG2+V7xg7PSY1q6EWnEJylqlLxfkxOGx2FymMtUz4Tk8pDmMK3XSm+xhWxFZVw0FfviZck8zRzhMUWOorL+JLGIu7oMFkjSxkdFp9QqG2Dc833r5e1M879a1emms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H3cRS7WP; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769564646; x=1801100646;
  h=date:from:to:cc:subject:message-id;
  bh=4SRxdceyVxxWSJoSV+rVdn4zRtVpdRbtmqufbUc0tAM=;
  b=H3cRS7WPwquwWFBfcH+8KFabOqZwGsq+X2McRGrkKelb8qi//i5Q9UK9
   wH0mvcCIyF+ZK0OEBxNk3bmklCx+SDQh9lm0hF7lRxUJgIWncPgPlAHoi
   hKbD6+oa0lpNq4ScP+zgG7QDePZt1JF26t1W1r+DTVjtDftQq2j9gCYPe
   91O68xY6DDcJ3lwQFmxbRS/C/nH8xXFsccVwbf9dqLQO4fztBJ6FYH4y7
   ymh5jO9Z7hiLsboSnQ/usRYPxw43lCumwfOFyp7Z6bSHhCDxMOZCSuunt
   9HFNCmFfoKOu+nEZbTF3BkowGv4K02RrMoMzVDcnU0pxudWEkdOJEMv3l
   Q==;
X-CSE-ConnectionGUID: CJdaelNmSVOzy2PRGBGjkg==
X-CSE-MsgGUID: rOub+bkORkuHEwR503yR7g==
X-IronPort-AV: E=McAfee;i="6800,10657,11684"; a="69787348"
X-IronPort-AV: E=Sophos;i="6.21,257,1763452800"; 
   d="scan'208";a="69787348"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 17:44:05 -0800
X-CSE-ConnectionGUID: 59jlNSPkRKe1V8wyhrajGQ==
X-CSE-MsgGUID: shj/F/vxQHGh5pw6xHwRng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,257,1763452800"; 
   d="scan'208";a="212233194"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 27 Jan 2026 17:44:03 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vkubB-00000000Z6U-2mhX;
	Wed, 28 Jan 2026 01:44:01 +0000
Date: Wed, 28 Jan 2026 09:43:32 +0800
From: kernel test robot <lkp@intel.com>
To: Johannes Berg <johannes.berg@intel.com>
Cc: linux-wireless@vger.kernel.org
Subject: [wireless-next:main] BUILD SUCCESS
 c30e188bd2a886258be5facb970a804d8ef549b5
Message-ID: <202601280927.U5niIaiH-lkp@intel.com>
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
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-31249-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-wireless@vger.kernel.org];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:mid,intel.com:dkim]
X-Rspamd-Queue-Id: 2D2939C02B
X-Rspamd-Action: no action

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: c30e188bd2a886258be5facb970a804d8ef549b5  Merge tag 'iwlwifi-next-2026-01-21' of https://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next

elapsed time: 722m

configs tested: 217
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
arc                              allyesconfig    clang-22
arc                              allyesconfig    gcc-15.2.0
arc                      axs103_smp_defconfig    gcc-15.2.0
arc                                 defconfig    gcc-15.2.0
arc                     nsimosci_hs_defconfig    gcc-15.2.0
arc                 nsimosci_hs_smp_defconfig    gcc-15.2.0
arc                   randconfig-001-20260128    gcc-8.5.0
arc                   randconfig-002-20260128    gcc-8.5.0
arm                               allnoconfig    clang-22
arm                               allnoconfig    gcc-15.2.0
arm                              allyesconfig    clang-16
arm                              allyesconfig    gcc-15.2.0
arm                                 defconfig    gcc-15.2.0
arm                          pxa3xx_defconfig    clang-22
arm                   randconfig-001-20260128    gcc-8.5.0
arm                   randconfig-002-20260128    gcc-8.5.0
arm                   randconfig-003-20260128    gcc-8.5.0
arm                   randconfig-004-20260128    gcc-8.5.0
arm64                            allmodconfig    clang-19
arm64                            allmodconfig    clang-22
arm64                             allnoconfig    gcc-15.2.0
arm64                               defconfig    gcc-15.2.0
arm64                 randconfig-001-20260128    gcc-14.3.0
arm64                 randconfig-002-20260128    gcc-14.3.0
arm64                 randconfig-003-20260128    gcc-14.3.0
arm64                 randconfig-004-20260128    gcc-14.3.0
csky                             allmodconfig    gcc-15.2.0
csky                              allnoconfig    gcc-15.2.0
csky                                defconfig    gcc-15.2.0
csky                  randconfig-001-20260128    gcc-14.3.0
csky                  randconfig-002-20260128    gcc-14.3.0
hexagon                          allmodconfig    clang-17
hexagon                          allmodconfig    gcc-15.2.0
hexagon                           allnoconfig    clang-22
hexagon                           allnoconfig    gcc-15.2.0
hexagon                             defconfig    gcc-15.2.0
hexagon               randconfig-001-20260128    clang-22
hexagon               randconfig-002-20260128    clang-22
i386                             allmodconfig    clang-20
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                              allnoconfig    gcc-15.2.0
i386                             allyesconfig    clang-20
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260128    clang-20
i386        buildonly-randconfig-002-20260128    clang-20
i386        buildonly-randconfig-003-20260128    clang-20
i386        buildonly-randconfig-004-20260128    clang-20
i386        buildonly-randconfig-005-20260128    clang-20
i386        buildonly-randconfig-006-20260128    clang-20
i386                                defconfig    gcc-15.2.0
i386                  randconfig-001-20260128    gcc-14
i386                  randconfig-002-20260128    gcc-14
i386                  randconfig-003-20260128    gcc-14
i386                  randconfig-004-20260128    gcc-14
i386                  randconfig-005-20260128    gcc-14
i386                  randconfig-006-20260128    gcc-14
i386                  randconfig-007-20260128    gcc-14
i386                  randconfig-011-20260128    clang-20
i386                  randconfig-012-20260128    gcc-14
i386                  randconfig-013-20260128    gcc-14
i386                  randconfig-014-20260128    clang-20
i386                  randconfig-015-20260128    clang-20
i386                  randconfig-016-20260128    gcc-14
i386                  randconfig-017-20260128    clang-20
loongarch                        allmodconfig    clang-19
loongarch                        allmodconfig    clang-22
loongarch                         allnoconfig    clang-22
loongarch                         allnoconfig    gcc-15.2.0
loongarch                           defconfig    clang-19
loongarch             randconfig-001-20260128    clang-22
loongarch             randconfig-002-20260128    clang-22
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
mips                     cu1830-neo_defconfig    gcc-15.2.0
mips                           ip27_defconfig    gcc-15.2.0
mips                           ip30_defconfig    gcc-15.2.0
nios2                            allmodconfig    clang-22
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    clang-22
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    clang-19
nios2                 randconfig-001-20260128    clang-22
nios2                 randconfig-002-20260128    clang-22
openrisc                         allmodconfig    clang-22
openrisc                         allmodconfig    gcc-15.2.0
openrisc                          allnoconfig    clang-22
openrisc                          allnoconfig    gcc-15.2.0
openrisc                            defconfig    gcc-15.2.0
parisc                           allmodconfig    gcc-15.2.0
parisc                            allnoconfig    clang-22
parisc                            allnoconfig    gcc-15.2.0
parisc                           allyesconfig    gcc-15.2.0
parisc                              defconfig    gcc-15.2.0
parisc                randconfig-001-20260128    gcc-11.5.0
parisc                randconfig-002-20260128    gcc-11.5.0
parisc                randconfig-002-20260128    gcc-12.5.0
parisc64                         alldefconfig    gcc-15.2.0
parisc64                            defconfig    clang-19
powerpc                          allmodconfig    gcc-15.2.0
powerpc                           allnoconfig    clang-22
powerpc                           allnoconfig    gcc-15.2.0
powerpc                        fsp2_defconfig    gcc-15.2.0
powerpc                      mgcoge_defconfig    clang-22
powerpc                     mpc83xx_defconfig    clang-22
powerpc                    mvme5100_defconfig    gcc-15.2.0
powerpc                      ppc6xx_defconfig    gcc-15.2.0
powerpc               randconfig-001-20260128    clang-22
powerpc               randconfig-001-20260128    gcc-11.5.0
powerpc               randconfig-002-20260128    gcc-11.5.0
powerpc               randconfig-002-20260128    gcc-8.5.0
powerpc                     redwood_defconfig    clang-22
powerpc64             randconfig-001-20260128    clang-22
powerpc64             randconfig-001-20260128    gcc-11.5.0
powerpc64             randconfig-002-20260128    clang-22
powerpc64             randconfig-002-20260128    gcc-11.5.0
riscv                            allmodconfig    clang-22
riscv                             allnoconfig    clang-22
riscv                             allnoconfig    gcc-15.2.0
riscv                            allyesconfig    clang-16
riscv                               defconfig    gcc-15.2.0
riscv                 randconfig-001-20260128    gcc-13.4.0
riscv                 randconfig-002-20260128    gcc-13.4.0
s390                             allmodconfig    clang-18
s390                              allnoconfig    clang-22
s390                             allyesconfig    gcc-15.2.0
s390                                defconfig    gcc-15.2.0
s390                  randconfig-001-20260128    gcc-13.4.0
s390                  randconfig-002-20260128    gcc-13.4.0
sh                               allmodconfig    gcc-15.2.0
sh                                allnoconfig    clang-22
sh                                allnoconfig    gcc-15.2.0
sh                               allyesconfig    gcc-15.2.0
sh                                  defconfig    gcc-14
sh                    randconfig-001-20260128    gcc-13.4.0
sh                    randconfig-002-20260128    gcc-13.4.0
sparc                             allnoconfig    clang-22
sparc                             allnoconfig    gcc-15.2.0
sparc                               defconfig    gcc-15.2.0
sparc                 randconfig-001-20260128    gcc-11.5.0
sparc                 randconfig-001-20260128    gcc-8.5.0
sparc                 randconfig-002-20260128    gcc-11.5.0
sparc                 randconfig-002-20260128    gcc-8.5.0
sparc                       sparc64_defconfig    gcc-15.2.0
sparc64                          allmodconfig    clang-22
sparc64                             defconfig    gcc-14
sparc64               randconfig-001-20260128    gcc-11.5.0
sparc64               randconfig-001-20260128    gcc-12.5.0
sparc64               randconfig-002-20260128    gcc-10.5.0
sparc64               randconfig-002-20260128    gcc-11.5.0
um                               allmodconfig    clang-19
um                                allnoconfig    clang-22
um                               allyesconfig    gcc-14
um                               allyesconfig    gcc-15.2.0
um                                  defconfig    gcc-14
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260128    gcc-11.5.0
um                    randconfig-001-20260128    gcc-12
um                    randconfig-002-20260128    clang-22
um                    randconfig-002-20260128    gcc-11.5.0
um                           x86_64_defconfig    gcc-14
x86_64                           allmodconfig    clang-20
x86_64                            allnoconfig    clang-20
x86_64                            allnoconfig    clang-22
x86_64                           allyesconfig    clang-20
x86_64      buildonly-randconfig-001-20260128    gcc-14
x86_64      buildonly-randconfig-002-20260128    gcc-14
x86_64      buildonly-randconfig-003-20260128    gcc-14
x86_64      buildonly-randconfig-004-20260128    gcc-14
x86_64      buildonly-randconfig-005-20260128    gcc-14
x86_64      buildonly-randconfig-006-20260128    gcc-14
x86_64                              defconfig    gcc-14
x86_64                                  kexec    clang-20
x86_64                randconfig-011-20260128    clang-20
x86_64                randconfig-012-20260128    clang-20
x86_64                randconfig-012-20260128    gcc-14
x86_64                randconfig-013-20260128    clang-20
x86_64                randconfig-014-20260128    clang-20
x86_64                randconfig-015-20260128    clang-20
x86_64                randconfig-015-20260128    gcc-14
x86_64                randconfig-016-20260128    clang-20
x86_64                randconfig-071-20260128    clang-20
x86_64                randconfig-072-20260128    clang-20
x86_64                randconfig-073-20260128    clang-20
x86_64                randconfig-074-20260128    clang-20
x86_64                randconfig-075-20260128    clang-20
x86_64                randconfig-076-20260128    clang-20
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
xtensa                  nommu_kc705_defconfig    gcc-15.2.0
xtensa                randconfig-001-20260128    gcc-11.5.0
xtensa                randconfig-001-20260128    gcc-8.5.0
xtensa                randconfig-002-20260128    gcc-11.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

