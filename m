Return-Path: <linux-wireless+bounces-14481-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 112E09AF5BD
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Oct 2024 01:13:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 942EB1F22681
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Oct 2024 23:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3279D21733F;
	Thu, 24 Oct 2024 23:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LbkQX00x"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2273414F9FD
	for <linux-wireless@vger.kernel.org>; Thu, 24 Oct 2024 23:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729811612; cv=none; b=ayPzKso9CB6fshWu6eiIojr2LJa3f12spFj5bTGWZFilWXkEyO+SLudW9FcpuxLZtBQul3luMVgN04boSakG+qbja+jrYWYRnGenCbdLoDPDoARxuQY5w+lBN+D6CID5vK//sE+RtF2IBvcZvMm9iDMWYFk0esTnoU0L7pkO0GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729811612; c=relaxed/simple;
	bh=WERx23HchfW8VgE459/zUQMkLmg6oJ+vzkPuXBrAcKE=;
	h=Date:From:To:Cc:Subject:Message-ID; b=f6X1phjoasQmaOG5L7A0WBYRKNPYwiD32wWuF7yvdae8Je9wkSrXHmqBX7VIWZAonMq/+QAFg0s3Rjd3wott/4oZcUdnY9NP4UZTQLDR5R1xmOp4+foe2GSb6Wzi8w/BshR9y07mrx0dNIGdYM/vQQsENzJMI+y8CmsehDOhc4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LbkQX00x; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729811610; x=1761347610;
  h=date:from:to:cc:subject:message-id;
  bh=WERx23HchfW8VgE459/zUQMkLmg6oJ+vzkPuXBrAcKE=;
  b=LbkQX00xJs86WDSbUAY6yfvShWzmMmr10ioeGoLKGKjicaEVBxFJidIa
   eQUuBIFPQ9bYXlXatdt7WEt6x5eUNyUmmwTLv4pVYoxNvYpGWK2pAUr+z
   KOfPOZnlsQsX/TAFYI/9FNrzQx3ISVEN3F7e7GVpQBcxZCeTYR7JLX8xH
   hYqt1YoGPRXEWBXAzXchpe6+DtfjQZbr4vZ2k0xuEKdoWGy5h9NrP/XnY
   rTRwsoKtHKhVu18gwfsCP4R0xD9bMbuI/CWLNXS3V/ICgF1ELwY0b5tmJ
   gSy0M3pEwRr/XuYgFvT4alp1b4Z2hXxB0KU8AUeCjHwcEkp/NbGJ5I44D
   g==;
X-CSE-ConnectionGUID: 7pw/MdcMTZq2EDmVNmxEUQ==
X-CSE-MsgGUID: jcGTY7BTSDOiEAWdF6ib6g==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29242093"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29242093"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 16:13:29 -0700
X-CSE-ConnectionGUID: 1AUtKmHSRcqmxoMaB1KzPw==
X-CSE-MsgGUID: 2ojyOUIoRRmnFGmyaD2+1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,230,1725346800"; 
   d="scan'208";a="85535962"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 24 Oct 2024 16:13:27 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t471A-000XGC-2D;
	Thu, 24 Oct 2024 23:13:24 +0000
Date: Fri, 25 Oct 2024 07:12:43 +0800
From: kernel test robot <lkp@intel.com>
To: Johannes Berg <johannes.berg@intel.com>
Cc: Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org
Subject: [wireless-next:main] BUILD SUCCESS
 eaed5fc0c322d75cfcdbc7a16c0c5023d9e4f6fe
Message-ID: <202410250735.7DQPIPNN-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: eaed5fc0c322d75cfcdbc7a16c0c5023d9e4f6fe  mac80211: Remove NOP call to ieee80211_hw_config

elapsed time: 1843m

configs tested: 101
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig    gcc-13.3.0
arc                              allmodconfig    gcc-13.2.0
arc                               allnoconfig    gcc-13.2.0
arc                              allyesconfig    gcc-13.2.0
arc                   randconfig-001-20241025    gcc-13.2.0
arc                   randconfig-002-20241025    gcc-13.2.0
arm                               allnoconfig    clang-20
arm                   randconfig-001-20241025    gcc-14.1.0
arm                   randconfig-002-20241025    gcc-14.1.0
arm                   randconfig-003-20241025    gcc-14.1.0
arm                   randconfig-004-20241025    gcc-14.1.0
arm64                             allnoconfig    gcc-14.1.0
arm64                 randconfig-001-20241025    clang-16
arm64                 randconfig-002-20241025    clang-14
arm64                 randconfig-003-20241025    clang-20
arm64                 randconfig-004-20241025    gcc-14.1.0
csky                              allnoconfig    gcc-14.1.0
csky                  randconfig-001-20241025    gcc-14.1.0
csky                  randconfig-002-20241025    gcc-14.1.0
hexagon                           allnoconfig    clang-20
hexagon               randconfig-001-20241025    clang-20
hexagon               randconfig-002-20241025    clang-20
i386                             allmodconfig    gcc-12
i386                              allnoconfig    gcc-12
i386                             allyesconfig    gcc-12
i386        buildonly-randconfig-001-20241024    gcc-12
i386        buildonly-randconfig-001-20241025    clang-19
i386        buildonly-randconfig-002-20241024    clang-19
i386        buildonly-randconfig-002-20241025    gcc-12
i386        buildonly-randconfig-003-20241024    gcc-12
i386        buildonly-randconfig-003-20241025    clang-19
i386        buildonly-randconfig-004-20241024    gcc-12
i386        buildonly-randconfig-004-20241025    gcc-12
i386        buildonly-randconfig-005-20241024    clang-19
i386        buildonly-randconfig-005-20241025    gcc-12
i386        buildonly-randconfig-006-20241024    clang-19
i386        buildonly-randconfig-006-20241025    gcc-12
i386                                defconfig    clang-19
i386                  randconfig-001-20241024    clang-19
i386                  randconfig-001-20241025    gcc-12
i386                  randconfig-002-20241024    gcc-12
i386                  randconfig-002-20241025    clang-19
i386                  randconfig-003-20241024    clang-19
i386                  randconfig-003-20241025    clang-19
i386                  randconfig-004-20241024    clang-19
i386                  randconfig-004-20241025    gcc-12
i386                  randconfig-005-20241024    clang-19
i386                  randconfig-006-20241024    clang-19
i386                  randconfig-011-20241024    gcc-12
i386                  randconfig-012-20241024    clang-19
i386                  randconfig-013-20241024    gcc-12
i386                  randconfig-014-20241024    gcc-12
i386                  randconfig-015-20241024    gcc-12
i386                  randconfig-016-20241024    clang-19
loongarch                         allnoconfig    gcc-14.1.0
loongarch             randconfig-001-20241025    gcc-14.1.0
loongarch             randconfig-002-20241025    gcc-14.1.0
m68k                              allnoconfig    gcc-14.1.0
microblaze                        allnoconfig    gcc-14.1.0
mips                              allnoconfig    gcc-14.1.0
nios2                             allnoconfig    gcc-14.1.0
nios2                 randconfig-001-20241025    gcc-14.1.0
nios2                 randconfig-002-20241025    gcc-14.1.0
openrisc                          allnoconfig    gcc-14.1.0
openrisc                         allyesconfig    gcc-14.1.0
parisc                           allmodconfig    gcc-14.1.0
parisc                            allnoconfig    gcc-14.1.0
parisc                           allyesconfig    gcc-14.1.0
parisc                randconfig-001-20241025    gcc-14.1.0
parisc                randconfig-002-20241025    gcc-14.1.0
powerpc                           allnoconfig    gcc-14.1.0
powerpc               randconfig-001-20241025    gcc-14.1.0
powerpc               randconfig-002-20241025    clang-14
powerpc               randconfig-003-20241025    clang-14
powerpc64             randconfig-001-20241025    clang-20
powerpc64             randconfig-002-20241025    gcc-14.1.0
powerpc64             randconfig-003-20241025    clang-20
riscv                             allnoconfig    gcc-14.1.0
riscv                 randconfig-001-20241025    gcc-14.1.0
riscv                 randconfig-002-20241025    gcc-14.1.0
s390                             allmodconfig    clang-20
s390                              allnoconfig    clang-20
s390                             allyesconfig    gcc-14.1.0
s390                  randconfig-001-20241025    gcc-14.1.0
s390                  randconfig-002-20241025    clang-20
sh                               allmodconfig    gcc-14.1.0
sh                                allnoconfig    gcc-14.1.0
sh                               allyesconfig    gcc-14.1.0
sh                    randconfig-001-20241025    gcc-14.1.0
sh                    randconfig-002-20241025    gcc-14.1.0
sparc                            allmodconfig    gcc-14.1.0
sparc64               randconfig-001-20241025    gcc-14.1.0
sparc64               randconfig-002-20241025    gcc-14.1.0
um                                allnoconfig    clang-17
x86_64                            allnoconfig    clang-19
x86_64                           allyesconfig    clang-19
x86_64                              defconfig    gcc-11
x86_64                                  kexec    clang-18
x86_64                               rhel-8.3    gcc-12
x86_64                    rhel-8.3-kselftests    gcc-12
xtensa                            allnoconfig    gcc-14.1.0

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

