Return-Path: <linux-wireless+bounces-12600-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F5096F6E7
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Sep 2024 16:34:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13B701F2582C
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Sep 2024 14:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 738A91CF7AD;
	Fri,  6 Sep 2024 14:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Skah3k90"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47621D04A0
	for <linux-wireless@vger.kernel.org>; Fri,  6 Sep 2024 14:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725633209; cv=none; b=Z5BawI55iZQD/vZUbAS1oG5k6IPJWjHU6obPIIp+a/PBScSCksULS+FPVu1BqTE7ZCJ5HXnKf68jVUCcN4N2k2+1nDe5emQPD6EYgDUTrv1I60dLbwqa4oDScFFs800MONOnRX/PWV5qQoEemSy6lgRKwmXPQUCXZXVQqrqRE+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725633209; c=relaxed/simple;
	bh=8939lK5mAqalMBlh8dAc0SNxVI38t+Vh122NLtgilHg=;
	h=Date:From:To:Cc:Subject:Message-ID; b=EwfW0x5Ii7X3E+3EabpzuED+wzFW44sGCRqdgOejG2tzf1w3Qs59J7j6ePLuKDfTUi1t6oCpOrFDip245U19q+AOsueNRqwKiWkb/Hd1koKXdt69aiQX8RxOLS7uiNsge++eK0PePuS3u6udzpQnrxn8uNQ62LYwAKDpd95ExY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Skah3k90; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725633208; x=1757169208;
  h=date:from:to:cc:subject:message-id;
  bh=8939lK5mAqalMBlh8dAc0SNxVI38t+Vh122NLtgilHg=;
  b=Skah3k90e4sOdKVIMkALAXF9Sy02MSvYZ1Qrx/59BkI5ekbjyOiOTviL
   5QUDc0nS9dAjznaNtuFZs6XVoPcTv1E5RV33veFFKcdNfqP/x1rBIl2dd
   YEww8a8hRW5THaER4/WPt5dhKyTMVPiLRpoJsW1i7hQ2EdrFa3vkAD+WP
   znbSv6csOd6JXwXbvk4IdA9t+18nP0x37RDgzw7sdi+Mtk+wr/2W3+bRa
   YsO+oUnTqZBHRhrilkJ1nYJV1l4bB1fFaUilJ/YtBP8srKyt1+ikwYjHO
   VEY0Kq6VaQCEBEpZoG7DLqo613IMNbRj9OgTpQjL34AYnmKs1GwoMVWyG
   g==;
X-CSE-ConnectionGUID: SF/1YFaoQ2Ct3szBo3Di7A==
X-CSE-MsgGUID: rZsc/6zeTausPimaG4u5bw==
X-IronPort-AV: E=McAfee;i="6700,10204,11187"; a="24266572"
X-IronPort-AV: E=Sophos;i="6.10,208,1719903600"; 
   d="scan'208";a="24266572"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2024 07:33:27 -0700
X-CSE-ConnectionGUID: VKr0E9ZESo6Kf1gYL4B4pQ==
X-CSE-MsgGUID: ZR7MwKAlT0mqMfh30UdaEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,208,1719903600"; 
   d="scan'208";a="70103891"
Received: from lkp-server01.sh.intel.com (HELO 9c6b1c7d3b50) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 06 Sep 2024 07:33:26 -0700
Received: from kbuild by 9c6b1c7d3b50 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sma1b-000BM3-31;
	Fri, 06 Sep 2024 14:33:23 +0000
Date: Fri, 06 Sep 2024 22:32:27 +0800
From: kernel test robot <lkp@intel.com>
To: Kalle Valo <kvalo@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>,
 linux-wireless@vger.kernel.org
Subject: [wireless-next:pending] BUILD SUCCESS
 9e1cca8fc9611ed4c8c27dfb3573fd3786df21a6
Message-ID: <202409062224.SOQTfyD9-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git pending
branch HEAD: 9e1cca8fc9611ed4c8c27dfb3573fd3786df21a6  Merge tag 'rtw-next-2024-09-05' of https://github.com/pkshih/rtw into pending

elapsed time: 1472m

configs tested: 157
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-14.1.0
alpha                            allyesconfig   clang-20
arc                               allnoconfig   gcc-14.1.0
arc                   randconfig-001-20240906   clang-20
arc                   randconfig-002-20240906   clang-20
arm                               allnoconfig   gcc-14.1.0
arm                         bcm2835_defconfig   clang-20
arm                      footbridge_defconfig   clang-20
arm                         nhk8815_defconfig   clang-20
arm                   randconfig-001-20240906   clang-20
arm                   randconfig-002-20240906   clang-20
arm                   randconfig-003-20240906   clang-20
arm                   randconfig-004-20240906   clang-20
arm                         s5pv210_defconfig   clang-20
arm64                             allnoconfig   gcc-14.1.0
arm64                 randconfig-001-20240906   clang-20
arm64                 randconfig-002-20240906   clang-20
arm64                 randconfig-003-20240906   clang-20
arm64                 randconfig-004-20240906   clang-20
csky                              allnoconfig   gcc-14.1.0
csky                  randconfig-001-20240906   clang-20
csky                  randconfig-002-20240906   clang-20
hexagon                          allmodconfig   clang-20
hexagon                           allnoconfig   gcc-14.1.0
hexagon                          allyesconfig   clang-20
hexagon               randconfig-001-20240906   clang-20
hexagon               randconfig-002-20240906   clang-20
i386                             allmodconfig   clang-18
i386                              allnoconfig   clang-18
i386                             allyesconfig   clang-18
i386         buildonly-randconfig-001-20240906   gcc-12
i386         buildonly-randconfig-002-20240906   gcc-12
i386         buildonly-randconfig-003-20240906   gcc-12
i386         buildonly-randconfig-004-20240906   gcc-12
i386         buildonly-randconfig-005-20240906   gcc-12
i386         buildonly-randconfig-006-20240906   gcc-12
i386                                defconfig   clang-18
i386                  randconfig-001-20240906   gcc-12
i386                  randconfig-002-20240906   gcc-12
i386                  randconfig-003-20240906   gcc-12
i386                  randconfig-004-20240906   gcc-12
i386                  randconfig-005-20240906   gcc-12
i386                  randconfig-006-20240906   gcc-12
i386                  randconfig-011-20240906   gcc-12
i386                  randconfig-012-20240906   gcc-12
i386                  randconfig-013-20240906   gcc-12
i386                  randconfig-014-20240906   gcc-12
i386                  randconfig-015-20240906   gcc-12
i386                  randconfig-016-20240906   gcc-12
loongarch                        allmodconfig   gcc-14.1.0
loongarch                         allnoconfig   gcc-14.1.0
loongarch             randconfig-001-20240906   clang-20
loongarch             randconfig-002-20240906   clang-20
m68k                             allmodconfig   gcc-14.1.0
m68k                              allnoconfig   gcc-14.1.0
m68k                             allyesconfig   gcc-14.1.0
microblaze                       allmodconfig   gcc-14.1.0
microblaze                        allnoconfig   gcc-14.1.0
microblaze                       allyesconfig   gcc-14.1.0
mips                              allnoconfig   gcc-14.1.0
mips                     loongson1c_defconfig   clang-20
mips                      malta_kvm_defconfig   clang-20
nios2                             allnoconfig   gcc-14.1.0
nios2                 randconfig-001-20240906   clang-20
nios2                 randconfig-002-20240906   clang-20
openrisc                          allnoconfig   clang-20
openrisc                         allyesconfig   gcc-14.1.0
openrisc                            defconfig   gcc-12
parisc                           allmodconfig   gcc-14.1.0
parisc                            allnoconfig   clang-20
parisc                           allyesconfig   gcc-14.1.0
parisc                              defconfig   gcc-12
parisc                randconfig-001-20240906   clang-20
parisc                randconfig-002-20240906   clang-20
powerpc                          allmodconfig   gcc-14.1.0
powerpc                           allnoconfig   clang-20
powerpc                          allyesconfig   gcc-14.1.0
powerpc                      arches_defconfig   clang-20
powerpc                   bluestone_defconfig   clang-20
powerpc                 linkstation_defconfig   clang-20
powerpc                 mpc8315_rdb_defconfig   clang-20
powerpc                      ppc44x_defconfig   clang-20
powerpc               randconfig-001-20240906   clang-20
powerpc               randconfig-002-20240906   clang-20
powerpc               randconfig-003-20240906   clang-20
powerpc                      tqm8xx_defconfig   clang-20
powerpc64             randconfig-001-20240906   clang-20
powerpc64             randconfig-002-20240906   clang-20
powerpc64             randconfig-003-20240906   clang-20
riscv                            allmodconfig   gcc-14.1.0
riscv                             allnoconfig   clang-20
riscv                            allyesconfig   gcc-14.1.0
riscv                               defconfig   gcc-12
riscv                 randconfig-001-20240906   clang-20
riscv                 randconfig-002-20240906   clang-20
s390                             allmodconfig   gcc-14.1.0
s390                              allnoconfig   clang-20
s390                             allyesconfig   gcc-14.1.0
s390                                defconfig   gcc-12
s390                  randconfig-001-20240906   clang-20
s390                  randconfig-002-20240906   clang-20
sh                               allmodconfig   gcc-14.1.0
sh                                allnoconfig   gcc-14.1.0
sh                               allyesconfig   gcc-14.1.0
sh                                  defconfig   gcc-12
sh                          landisk_defconfig   clang-20
sh                    randconfig-001-20240906   clang-20
sh                    randconfig-002-20240906   clang-20
sh                          sdk7780_defconfig   clang-20
sh                             sh03_defconfig   clang-20
sh                     sh7710voipgw_defconfig   clang-20
sh                            titan_defconfig   clang-20
sparc                            allmodconfig   gcc-14.1.0
sparc64                             defconfig   gcc-12
sparc64               randconfig-001-20240906   clang-20
sparc64               randconfig-002-20240906   clang-20
um                               allmodconfig   clang-20
um                                allnoconfig   clang-20
um                               allyesconfig   clang-20
um                                  defconfig   gcc-12
um                             i386_defconfig   gcc-12
um                    randconfig-001-20240906   clang-20
um                    randconfig-002-20240906   clang-20
um                           x86_64_defconfig   gcc-12
x86_64                            allnoconfig   clang-18
x86_64                           allyesconfig   clang-18
x86_64       buildonly-randconfig-001-20240906   clang-18
x86_64       buildonly-randconfig-002-20240906   clang-18
x86_64       buildonly-randconfig-003-20240906   clang-18
x86_64       buildonly-randconfig-004-20240906   clang-18
x86_64       buildonly-randconfig-005-20240906   clang-18
x86_64       buildonly-randconfig-006-20240906   clang-18
x86_64                              defconfig   clang-18
x86_64                                  kexec   gcc-12
x86_64                randconfig-001-20240906   clang-18
x86_64                randconfig-002-20240906   clang-18
x86_64                randconfig-003-20240906   clang-18
x86_64                randconfig-004-20240906   clang-18
x86_64                randconfig-005-20240906   clang-18
x86_64                randconfig-006-20240906   clang-18
x86_64                randconfig-011-20240906   clang-18
x86_64                randconfig-012-20240906   clang-18
x86_64                randconfig-013-20240906   clang-18
x86_64                randconfig-014-20240906   clang-18
x86_64                randconfig-015-20240906   clang-18
x86_64                randconfig-016-20240906   clang-18
x86_64                randconfig-071-20240906   clang-18
x86_64                randconfig-072-20240906   clang-18
x86_64                randconfig-073-20240906   clang-18
x86_64                randconfig-074-20240906   clang-18
x86_64                randconfig-075-20240906   clang-18
x86_64                randconfig-076-20240906   clang-18
x86_64                          rhel-8.3-rust   clang-18
x86_64                               rhel-8.3   gcc-12
xtensa                            allnoconfig   gcc-14.1.0
xtensa                randconfig-001-20240906   clang-20
xtensa                randconfig-002-20240906   clang-20

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

