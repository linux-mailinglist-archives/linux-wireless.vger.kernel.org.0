Return-Path: <linux-wireless+bounces-15131-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B01DB9C178F
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Nov 2024 09:13:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40D741F2395C
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Nov 2024 08:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B494B1D0E33;
	Fri,  8 Nov 2024 08:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VaJccCY/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3FF7DA95
	for <linux-wireless@vger.kernel.org>; Fri,  8 Nov 2024 08:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731053581; cv=none; b=I9hlNG/YDeU9m3AxGtUcsdQKQ5VBRUkgxiNY6dXjI4Wu8INKgUmWgHIblLRJv0DUGJV5N0qbY2KaGHlv21QnV3iHxk8ezv0FibSJS9qKXHztvFZmKeEITnDthlNMKYXcN+M/3vD7B9PIANCa8cYplYDfUZEHlhtZSLelGzGrU9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731053581; c=relaxed/simple;
	bh=UIox2C88Odjz6PdNPB/UcKbOX1ovyVk/uJhVEcwxf0E=;
	h=Date:From:To:Cc:Subject:Message-ID; b=KY28axTxFPdcZsHXoKHiiv7TJoddVeWe3CVASN4RAj5U7AWq78YRSg5uJydvMR1IEiVL1OFgR/UU1EMTw3Nuf4m1G804/KnbX/hPVqamZK/84hSTYI3NMTRmmxLInlFRoIaeYgBw+HHpAQtM0LFSIpyK3akAfv4JHhKfn6QNnZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VaJccCY/; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731053577; x=1762589577;
  h=date:from:to:cc:subject:message-id;
  bh=UIox2C88Odjz6PdNPB/UcKbOX1ovyVk/uJhVEcwxf0E=;
  b=VaJccCY/hWTvkcWPWO25PMbebQmNafcfLsVYvQoq+tUJkTYRXzi2IFWY
   P2zy6BnQzmuoKuHrOwGf4l0CT+0123yRS0cATMdKAsgai3erNo6yMJ1/J
   /ZzSWD/cMIoJx6LER1iyR0wdHGA3CCMU5HJTHWv4Slkti0jkiGo2LPCSy
   mWiM4N2fkNhfnP3sMb0xFXWA/JDNgszpaTLx7lW2B6T3zpMb+3CEth78L
   GBFDLn+tbNHsBP6VVnjsy1oqofqS/DLKqaPJztOC7FR2IliT/SmEf9QFv
   0sRrerXkIDiZnCc8Jr8joXaiwXsEY6/9rZoKF4xmj391tL3sTXWll/lJJ
   A==;
X-CSE-ConnectionGUID: z+Zf49glRU+GcmyVwakiLA==
X-CSE-MsgGUID: 0C58y6CyTH60nMnx5HOMng==
X-IronPort-AV: E=McAfee;i="6700,10204,11249"; a="41536175"
X-IronPort-AV: E=Sophos;i="6.12,137,1728975600"; 
   d="scan'208";a="41536175"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2024 00:12:56 -0800
X-CSE-ConnectionGUID: pRrPGi7FQ7iXR51MGEdlrg==
X-CSE-MsgGUID: vBKYC0N/SJ6icv+FTNDbbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,137,1728975600"; 
   d="scan'208";a="85671501"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 08 Nov 2024 00:12:55 -0800
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t9K6v-000rCM-02;
	Fri, 08 Nov 2024 08:12:53 +0000
Date: Fri, 08 Nov 2024 16:12:08 +0800
From: kernel test robot <lkp@intel.com>
To: Johannes Berg <johannes.berg@intel.com>
Cc: Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org
Subject: [wireless-next:main] BUILD SUCCESS
 c95f1fcd557dcae2cd2763159aedbd9bd538d190
Message-ID: <202411081602.7aJzN8OK-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: c95f1fcd557dcae2cd2763159aedbd9bd538d190  wifi: iwlwifi: mvm: don't call power_update_mac in fast suspend

elapsed time: 1020m

configs tested: 190
configs skipped: 4

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-14.2.0
alpha                            allyesconfig    gcc-14.2.0
arc                              allmodconfig    clang-20
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-14.2.0
arc                              allyesconfig    clang-20
arc                              allyesconfig    gcc-13.2.0
arc                      axs103_smp_defconfig    clang-20
arc                            hsdk_defconfig    clang-14
arc                   randconfig-001-20241108    gcc-13.2.0
arc                   randconfig-002-20241108    gcc-13.2.0
arc                    vdk_hs38_smp_defconfig    clang-20
arm                              allmodconfig    clang-20
arm                              allmodconfig    gcc-14.2.0
arm                               allnoconfig    gcc-14.2.0
arm                              allyesconfig    clang-20
arm                              allyesconfig    gcc-14.2.0
arm                            dove_defconfig    clang-14
arm                          ep93xx_defconfig    clang-14
arm                        keystone_defconfig    clang-20
arm                   randconfig-001-20241108    gcc-14.2.0
arm                   randconfig-002-20241108    gcc-14.2.0
arm                   randconfig-003-20241108    clang-15
arm                   randconfig-004-20241108    clang-20
arm                           sama7_defconfig    clang-14
arm64                            allmodconfig    clang-20
arm64                             allnoconfig    gcc-14.2.0
arm64                 randconfig-001-20241108    clang-20
arm64                 randconfig-002-20241108    gcc-14.2.0
arm64                 randconfig-003-20241108    clang-20
arm64                 randconfig-004-20241108    gcc-14.2.0
csky                              allnoconfig    gcc-14.2.0
csky                  randconfig-001-20241108    gcc-14.2.0
csky                  randconfig-002-20241108    gcc-14.2.0
hexagon                          allmodconfig    clang-20
hexagon                           allnoconfig    gcc-14.2.0
hexagon                          allyesconfig    clang-20
hexagon               randconfig-001-20241108    clang-16
hexagon               randconfig-002-20241108    clang-20
i386                             allmodconfig    clang-19
i386                             allmodconfig    gcc-12
i386                              allnoconfig    clang-19
i386                              allnoconfig    gcc-12
i386                             allyesconfig    clang-19
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20241108    clang-19
i386        buildonly-randconfig-002-20241108    clang-19
i386        buildonly-randconfig-003-20241108    gcc-12
i386        buildonly-randconfig-004-20241108    clang-19
i386        buildonly-randconfig-005-20241108    clang-19
i386        buildonly-randconfig-006-20241108    clang-19
i386                                defconfig    clang-19
i386                  randconfig-001-20241108    clang-19
i386                  randconfig-002-20241108    clang-19
i386                  randconfig-003-20241108    clang-19
i386                  randconfig-004-20241108    gcc-12
i386                  randconfig-005-20241108    clang-19
i386                  randconfig-006-20241108    gcc-12
i386                  randconfig-011-20241108    gcc-12
i386                  randconfig-012-20241108    clang-19
i386                  randconfig-013-20241108    clang-19
i386                  randconfig-014-20241108    clang-19
i386                  randconfig-015-20241108    gcc-12
i386                  randconfig-016-20241108    gcc-12
loongarch                        allmodconfig    gcc-14.2.0
loongarch                         allnoconfig    gcc-14.2.0
loongarch             randconfig-001-20241108    gcc-14.2.0
loongarch             randconfig-002-20241108    gcc-14.2.0
m68k                             alldefconfig    clang-20
m68k                             allmodconfig    gcc-14.2.0
m68k                              allnoconfig    gcc-14.2.0
m68k                             allyesconfig    gcc-14.2.0
microblaze                       allmodconfig    gcc-14.2.0
microblaze                        allnoconfig    gcc-14.2.0
microblaze                       allyesconfig    gcc-14.2.0
mips                              allnoconfig    gcc-14.2.0
mips                      maltaaprp_defconfig    clang-14
mips                   sb1250_swarm_defconfig    clang-14
nios2                             allnoconfig    gcc-14.2.0
nios2                 randconfig-001-20241108    gcc-14.2.0
nios2                 randconfig-002-20241108    gcc-14.2.0
openrisc                          allnoconfig    clang-20
openrisc                          allnoconfig    gcc-14.2.0
openrisc                         allyesconfig    gcc-14.2.0
openrisc                            defconfig    gcc-12
openrisc                       virt_defconfig    clang-14
parisc                           allmodconfig    gcc-14.2.0
parisc                            allnoconfig    clang-20
parisc                            allnoconfig    gcc-14.2.0
parisc                           allyesconfig    gcc-14.2.0
parisc                              defconfig    gcc-12
parisc                randconfig-001-20241108    gcc-14.2.0
parisc                randconfig-002-20241108    gcc-14.2.0
powerpc                          allmodconfig    gcc-14.2.0
powerpc                           allnoconfig    clang-20
powerpc                           allnoconfig    gcc-14.2.0
powerpc                          allyesconfig    clang-20
powerpc                    amigaone_defconfig    clang-14
powerpc                      cm5200_defconfig    clang-20
powerpc                   lite5200b_defconfig    clang-14
powerpc                     mpc512x_defconfig    clang-14
powerpc               mpc834x_itxgp_defconfig    clang-14
powerpc                  mpc885_ads_defconfig    clang-20
powerpc                      pasemi_defconfig    clang-20
powerpc               randconfig-001-20241108    clang-15
powerpc               randconfig-002-20241108    clang-15
powerpc               randconfig-003-20241108    clang-20
powerpc                     sequoia_defconfig    clang-14
powerpc                  storcenter_defconfig    clang-20
powerpc                     taishan_defconfig    clang-20
powerpc                     tqm8541_defconfig    clang-20
powerpc64             randconfig-001-20241108    clang-20
powerpc64             randconfig-002-20241108    gcc-14.2.0
powerpc64             randconfig-003-20241108    clang-20
riscv                            allmodconfig    clang-20
riscv                             allnoconfig    clang-20
riscv                             allnoconfig    gcc-14.2.0
riscv                            allyesconfig    clang-20
riscv                               defconfig    gcc-12
riscv                 randconfig-001-20241108    clang-20
riscv                 randconfig-002-20241108    gcc-14.2.0
s390                             alldefconfig    clang-14
s390                             allmodconfig    clang-20
s390                             allmodconfig    gcc-14.2.0
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.2.0
s390                                defconfig    gcc-12
s390                  randconfig-001-20241108    gcc-14.2.0
s390                  randconfig-002-20241108    gcc-14.2.0
sh                               allmodconfig    gcc-14.2.0
sh                                allnoconfig    gcc-14.2.0
sh                               allyesconfig    gcc-14.2.0
sh                                  defconfig    gcc-12
sh                               j2_defconfig    clang-20
sh                          kfr2r09_defconfig    clang-14
sh                            migor_defconfig    clang-14
sh                    randconfig-001-20241108    gcc-14.2.0
sh                    randconfig-002-20241108    gcc-14.2.0
sh                   rts7751r2dplus_defconfig    clang-20
sh                          sdk7786_defconfig    clang-20
sh                            titan_defconfig    clang-20
sparc                            allmodconfig    gcc-14.2.0
sparc64                             defconfig    gcc-12
sparc64               randconfig-001-20241108    gcc-14.2.0
sparc64               randconfig-002-20241108    gcc-14.2.0
um                               allmodconfig    clang-20
um                                allnoconfig    clang-17
um                                allnoconfig    clang-20
um                               allyesconfig    gcc-12
um                                  defconfig    gcc-12
um                             i386_defconfig    gcc-12
um                    randconfig-001-20241108    clang-15
um                    randconfig-002-20241108    gcc-12
um                           x86_64_defconfig    gcc-12
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64      buildonly-randconfig-001-20241108    gcc-12
x86_64      buildonly-randconfig-002-20241108    clang-19
x86_64      buildonly-randconfig-003-20241108    clang-19
x86_64      buildonly-randconfig-004-20241108    clang-19
x86_64      buildonly-randconfig-005-20241108    gcc-12
x86_64      buildonly-randconfig-006-20241108    clang-19
x86_64                              defconfig    clang-19
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-19
x86_64                                  kexec    gcc-12
x86_64                randconfig-001-20241108    gcc-12
x86_64                randconfig-002-20241108    clang-19
x86_64                randconfig-003-20241108    gcc-12
x86_64                randconfig-004-20241108    clang-19
x86_64                randconfig-005-20241108    gcc-12
x86_64                randconfig-006-20241108    clang-19
x86_64                randconfig-011-20241108    gcc-12
x86_64                randconfig-012-20241108    gcc-12
x86_64                randconfig-013-20241108    gcc-12
x86_64                randconfig-014-20241108    gcc-12
x86_64                randconfig-015-20241108    clang-19
x86_64                randconfig-016-20241108    gcc-12
x86_64                randconfig-071-20241108    clang-19
x86_64                randconfig-072-20241108    gcc-12
x86_64                randconfig-073-20241108    clang-19
x86_64                randconfig-074-20241108    clang-19
x86_64                randconfig-075-20241108    gcc-12
x86_64                randconfig-076-20241108    clang-19
x86_64                               rhel-8.3    gcc-12
xtensa                            allnoconfig    gcc-14.2.0
xtensa                generic_kc705_defconfig    clang-20
xtensa                randconfig-001-20241108    gcc-14.2.0
xtensa                randconfig-002-20241108    gcc-14.2.0
xtensa                         virt_defconfig    clang-14

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

