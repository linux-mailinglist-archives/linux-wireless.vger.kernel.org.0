Return-Path: <linux-wireless+bounces-38714-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Tlv8NDdDTGrtiQEAu9opvQ
	(envelope-from <linux-wireless+bounces-38714-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Jul 2026 02:07:19 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BC02A7166AA
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Jul 2026 02:07:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=a+Z7uadf;
	dmarc=pass (policy=none) header.from=intel.com;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38714-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38714-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E2B4C300A26D
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Jul 2026 00:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC1571DFF0;
	Tue,  7 Jul 2026 00:07:14 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19FC800
	for <linux-wireless@vger.kernel.org>; Tue,  7 Jul 2026 00:07:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783382834; cv=none; b=brjx5yFHFC0i3g2o/h95HG6XPy87rm3kteaulmpHKDNp0mNAQvwyypatNNaKasJ6CNnxfvc8zWqvke/ANCqPBeLLHLN7CDUoG7Ccq7gS5+XsF148PWbaL0AXDwJDT0N1CTtkK++DuFgMlwmKtHc5Dhj4w5WCS+bpICe4sKUWFiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783382834; c=relaxed/simple;
	bh=Avin1B2fyK/5EBLEzTYmyfg3Wq5GX5go2rz9c1j3FCk=;
	h=Date:From:To:Cc:Subject:Message-ID; b=Mto3hvLc4DvufHkY1RT5RPwYRruoiRUh7dzj/wMdQAq78sZhL3e1MdJGF/GmAUUnAudxAJP4R2eCfybVFV4duYkiFkpMIU0VWgWwYzPJbBwkq8sRSMppOD7ReGr9BlOFoJN0tXLUm2oYwuxOPG29RdiWruRp150cf+lKz6turYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a+Z7uadf; arc=none smtp.client-ip=192.198.163.14
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783382833; x=1814918833;
  h=date:from:to:cc:subject:message-id;
  bh=Avin1B2fyK/5EBLEzTYmyfg3Wq5GX5go2rz9c1j3FCk=;
  b=a+Z7uadfczm65OwJdFBFE+Ftx5EpcTsgF9iK9Sb1YNzRvTkKR0lMeS1n
   xdAniCKWiTuNTW6Ci3RlVYTBw/2UuFQ7BDMtzEjax4zZgN8BWclTyjPD3
   Ma8PiHVnAgZ2AW8x6HesIPbIY9c+DEnsyKoP6Fmn6IsR+d3s85ZDRGR7K
   SqzMn01xaSUDTj+JRANAYFRMh0ny7rVKi629pL/LAOvIJgD18Z/6S6YY2
   R3TtLpieaNy+aieGEQTNE8y/Hf+RD78C4pthLUMgPuvhXTxtqzDWOOlVz
   IfaHP5t/b53ob0Ybac5cu79a9H691AJnLZv5WGeHu+2C6ikNu+Bk8HEWP
   w==;
X-CSE-ConnectionGUID: KliUz4dWRgakwWGudIRgJQ==
X-CSE-MsgGUID: 6tXkzptbSzqnGPZM7Gdslw==
X-IronPort-AV: E=McAfee;i="6800,10657,11839"; a="84075181"
X-IronPort-AV: E=Sophos;i="6.25,151,1779174000"; 
   d="scan'208";a="84075181"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 17:07:12 -0700
X-CSE-ConnectionGUID: Jw21PN8FRuqWljxdxUdAEg==
X-CSE-MsgGUID: zapQRe/+R5KpY/eptdGEZg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,151,1779174000"; 
   d="scan'208";a="257721003"
Received: from lkp-server02.sh.intel.com (HELO ea128546eb3d) ([10.239.97.151])
  by orviesa004.jf.intel.com with ESMTP; 06 Jul 2026 17:07:11 -0700
Received: from kbuild by ea128546eb3d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wgtLA-00000000EtY-1veJ;
	Tue, 07 Jul 2026 00:07:08 +0000
Date: Tue, 07 Jul 2026 08:06:30 +0800
From: kernel test robot <lkp@intel.com>
To: Johannes Berg <johannes.berg@intel.com>
Cc: linux-wireless@vger.kernel.org
Subject: [wireless-next:main] BUILD REGRESSION
 2bfd9da88b95d89041c91c06acd1c38258edc38b
Message-ID: <202607070815.5dEIXdZ6-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-38714-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:johannes.berg@intel.com,m:linux-wireless@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[lkp@intel.com,linux-wireless@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lkp@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,intel.com:from_mime,intel.com:dkim,intel.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BC02A7166AA

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: 2bfd9da88b95d89041c91c06acd1c38258edc38b  wifi: cfg80211: support MAC address filtering in station dump for link stats

Error/Warning (recently discovered and may have been fixed):

    https://lore.kernel.org/oe-kbuild-all/202607070740.1XekJylA-lkp@intel.com

    (.text+0x4e00): multiple definition of `is_command_pending'; drivers/net/wireless/marvell/mwifiex/main.o:(.text+0x5880): first defined here
    alpha-linux-ld: drivers/net/wireless/nxp/nxpwifi/wmm.o:(.sdata+0x1c): multiple definition of `tos_to_tid_inv'; drivers/net/wireless/marvell/mwifiex/wmm.o:(.sdata+0x1c): first defined here

Unverified Error/Warning (likely false positive, kindly check if interested):

    drivers/net/wireless/nxp/nxpwifi/scan.c:2034:1: internal compiler error: in final_scan_insn_1, at final.cc:2823

Error/Warning ids grouped by kconfigs:

recent_errors
|-- alpha-allyesconfig
|   |-- multiple-definition-of-is_command_pending-drivers-net-wireless-marvell-mwifiex-main.o:(.text):first-defined-here
|   `-- multiple-definition-of-tos_to_tid_inv-drivers-net-wireless-marvell-mwifiex-wmm.o:(.sdata):first-defined-here
`-- csky-allmodconfig
    `-- drivers-net-wireless-nxp-nxpwifi-scan.c:internal-compiler-error:in-final_scan_insn_1-at-final.cc

elapsed time: 729m

configs tested: 186
configs skipped: 117

tested configs:
alpha                             allnoconfig    gcc-16.1.0
alpha                            allyesconfig    gcc-16.1.0
arc                              allmodconfig    gcc-16.1.0
arc                               allnoconfig    gcc-16.1.0
arc                              allyesconfig    gcc-16.1.0
arc                   randconfig-001-20260707    gcc-14.3.0
arc                   randconfig-002-20260707    gcc-12.5.0
arm                               allnoconfig    clang-17
arm                              allyesconfig    gcc-16.1.0
arm                                 defconfig    clang-23
arm                          pxa3xx_defconfig    clang-17
arm                   randconfig-001-20260707    gcc-8.5.0
arm                   randconfig-002-20260707    clang-17
arm                   randconfig-003-20260707    clang-17
arm                   randconfig-004-20260707    clang-23
arm64                            allmodconfig    clang-23
arm64                             allnoconfig    gcc-16.1.0
arm64                               defconfig    gcc-16.1.0
arm64                          randconfig-001    gcc-14.3.0
arm64                 randconfig-001-20260707    clang-23
arm64                          randconfig-002    gcc-8.5.0
arm64                 randconfig-002-20260707    clang-18
arm64                          randconfig-003    clang-20
arm64                 randconfig-003-20260707    clang-23
arm64                          randconfig-004    clang-23
arm64                 randconfig-004-20260707    clang-17
csky                             allmodconfig    gcc-16.1.0
csky                              allnoconfig    gcc-16.1.0
csky                           randconfig-001    gcc-13.4.0
csky                  randconfig-001-20260707    gcc-16.1.0
csky                           randconfig-002    gcc-14.3.0
csky                  randconfig-002-20260707    gcc-16.1.0
hexagon                          allmodconfig    clang-23
hexagon                           allnoconfig    clang-23
hexagon                        randconfig-001    clang-17
hexagon               randconfig-001-20260707    clang-23
hexagon                        randconfig-002    clang-23
hexagon               randconfig-002-20260707    clang-18
i386                             allmodconfig    gcc-14
i386                              allnoconfig    gcc-14
i386                             allyesconfig    gcc-14
i386        buildonly-randconfig-001-20260706    clang-22
i386        buildonly-randconfig-002-20260706    gcc-12
i386        buildonly-randconfig-003-20260706    clang-22
i386        buildonly-randconfig-004-20260706    clang-22
i386        buildonly-randconfig-004-20260707    gcc-14
i386        buildonly-randconfig-005-20260706    clang-22
i386        buildonly-randconfig-006-20260706    gcc-14
i386                                defconfig    clang-22
i386                  randconfig-001-20260707    gcc-13
i386                  randconfig-002-20260707    clang-22
i386                  randconfig-003-20260707    clang-22
i386                  randconfig-004-20260707    gcc-14
i386                  randconfig-005-20260707    clang-22
i386                  randconfig-006-20260707    clang-22
i386                  randconfig-007-20260707    clang-22
i386                  randconfig-011-20260707    gcc-14
i386                  randconfig-012-20260707    gcc-14
i386                  randconfig-013-20260707    clang-22
i386                  randconfig-014-20260707    gcc-14
i386                  randconfig-015-20260707    gcc-14
i386                  randconfig-016-20260707    gcc-14
i386                  randconfig-017-20260707    gcc-14
loongarch                        allmodconfig    clang-19
loongarch                         allnoconfig    clang-20
loongarch                           defconfig    clang-23
loongarch                      randconfig-001    clang-23
loongarch             randconfig-001-20260707    clang-18
loongarch                      randconfig-002    gcc-16.1.0
loongarch             randconfig-002-20260707    clang-19
m68k                             allmodconfig    gcc-16.1.0
m68k                              allnoconfig    gcc-16.1.0
m68k                             allyesconfig    gcc-16.1.0
m68k                                defconfig    gcc-16.1.0
microblaze                        allnoconfig    gcc-16.1.0
microblaze                       allyesconfig    gcc-16.1.0
microblaze                          defconfig    gcc-16.1.0
mips                             allmodconfig    gcc-16.1.0
mips                              allnoconfig    gcc-16.1.0
mips                             allyesconfig    gcc-16.1.0
nios2                            allmodconfig    gcc-11.5.0
nios2                             allnoconfig    gcc-11.5.0
nios2                               defconfig    gcc-11.5.0
nios2                          randconfig-001    gcc-11.5.0
nios2                 randconfig-001-20260707    gcc-11.5.0
nios2                          randconfig-002    gcc-8.5.0
nios2                 randconfig-002-20260707    gcc-11.5.0
openrisc                         allmodconfig    gcc-16.1.0
openrisc                          allnoconfig    gcc-16.1.0
openrisc                            defconfig    gcc-16.1.0
parisc                           allmodconfig    gcc-16.1.0
parisc                            allnoconfig    gcc-16.1.0
parisc                           allyesconfig    gcc-16.1.0
parisc                              defconfig    gcc-16.1.0
parisc                randconfig-001-20260707    gcc-15.2.0
parisc                randconfig-002-20260707    gcc-9.5.0
parisc64                            defconfig    gcc-16.1.0
powerpc                          allmodconfig    gcc-16.1.0
powerpc                           allnoconfig    gcc-16.1.0
powerpc               randconfig-001-20260707    clang-23
powerpc               randconfig-002-20260707    gcc-14.3.0
powerpc64             randconfig-001-20260707    gcc-8.5.0
powerpc64             randconfig-002-20260707    clang-22
riscv                            allmodconfig    clang-23
riscv                             allnoconfig    gcc-16.1.0
riscv                            allyesconfig    clang-23
riscv                               defconfig    clang-23
riscv             nommu_k210_sdcard_defconfig    gcc-16.1.0
riscv                 randconfig-001-20260707    gcc-14.3.0
riscv                 randconfig-002-20260707    gcc-8.5.0
s390                             allmodconfig    clang-23
s390                              allnoconfig    clang-23
s390                             allyesconfig    gcc-16.1.0
s390                                defconfig    clang-18
s390                  randconfig-001-20260707    clang-21
s390                  randconfig-002-20260707    gcc-13.4.0
sh                               allmodconfig    gcc-16.1.0
sh                                allnoconfig    gcc-16.1.0
sh                               allyesconfig    gcc-16.1.0
sh                                  defconfig    gcc-16.1.0
sh                    randconfig-001-20260707    gcc-16.1.0
sh                    randconfig-002-20260707    gcc-16.1.0
sparc                             allnoconfig    gcc-16.1.0
sparc                               defconfig    gcc-16.1.0
sparc                 randconfig-001-20260707    gcc-13.4.0
sparc                 randconfig-002-20260707    gcc-15.2.0
sparc64                          allmodconfig    clang-20
sparc64                             defconfig    clang-23
sparc64               randconfig-001-20260707    gcc-8.5.0
sparc64               randconfig-002-20260707    clang-23
um                               allmodconfig    clang-17
um                                allnoconfig    clang-17
um                               allyesconfig    gcc-14
um                                  defconfig    clang-23
um                             i386_defconfig    gcc-14
um                    randconfig-001-20260707    clang-18
um                    randconfig-002-20260707    clang-23
um                           x86_64_defconfig    clang-23
x86_64                           allmodconfig    clang-22
x86_64                            allnoconfig    clang-22
x86_64                           allyesconfig    clang-22
x86_64               buildonly-randconfig-001    gcc-12
x86_64      buildonly-randconfig-001-20260706    clang-22
x86_64               buildonly-randconfig-002    clang-22
x86_64      buildonly-randconfig-002-20260706    gcc-14
x86_64               buildonly-randconfig-003    gcc-14
x86_64      buildonly-randconfig-003-20260706    gcc-14
x86_64               buildonly-randconfig-004    gcc-14
x86_64      buildonly-randconfig-004-20260706    gcc-14
x86_64               buildonly-randconfig-005    gcc-14
x86_64      buildonly-randconfig-005-20260706    gcc-14
x86_64               buildonly-randconfig-006    clang-22
x86_64      buildonly-randconfig-006-20260706    clang-22
x86_64                              defconfig    gcc-14
x86_64                randconfig-001-20260706    gcc-14
x86_64                randconfig-001-20260707    clang-22
x86_64                randconfig-002-20260706    clang-22
x86_64                randconfig-002-20260707    gcc-14
x86_64                randconfig-003-20260706    clang-22
x86_64                randconfig-003-20260707    clang-22
x86_64                randconfig-004-20260706    gcc-14
x86_64                randconfig-004-20260707    clang-22
x86_64                randconfig-005-20260706    clang-22
x86_64                randconfig-005-20260707    gcc-14
x86_64                randconfig-006-20260706    gcc-13
x86_64                randconfig-006-20260707    gcc-12
x86_64                randconfig-011-20260706    clang-22
x86_64                randconfig-012-20260706    clang-22
x86_64                randconfig-012-20260707    gcc-14
x86_64                randconfig-013-20260706    gcc-14
x86_64                randconfig-014-20260706    gcc-12
x86_64                randconfig-014-20260707    gcc-14
x86_64                randconfig-015-20260706    gcc-14
x86_64                randconfig-015-20260707    gcc-14
x86_64                randconfig-016-20260706    gcc-12
x86_64                randconfig-071-20260707    clang-22
x86_64                randconfig-072-20260707    clang-22
x86_64                randconfig-073-20260707    clang-22
x86_64                randconfig-074-20260707    clang-22
x86_64                randconfig-075-20260707    clang-22
x86_64                randconfig-076-20260707    gcc-14
x86_64                          rhel-9.4-rust    clang-22
xtensa                            allnoconfig    gcc-16.1.0
xtensa                           allyesconfig    gcc-16.1.0
xtensa                randconfig-001-20260707    gcc-8.5.0
xtensa                randconfig-002-20260707    gcc-11.5.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

