Return-Path: <linux-wireless+bounces-9730-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 408A291D28A
	for <lists+linux-wireless@lfdr.de>; Sun, 30 Jun 2024 17:54:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68C051C209C9
	for <lists+linux-wireless@lfdr.de>; Sun, 30 Jun 2024 15:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF0C13D53A;
	Sun, 30 Jun 2024 15:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gn8MEIE2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF95154429
	for <linux-wireless@vger.kernel.org>; Sun, 30 Jun 2024 15:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719762841; cv=none; b=btiZB2s4+zLPwp5qKQDml7WtCa0tp/ZY3VpkdlcNbPq4lSJTO4nFotRjC9Q2uDERI1nRAAP08KFjVY/7cS6dgwQxQzQIx8sn+6Ww1Zme6zi9CA92r4KNaKJivKOuOsOqjUy3U7XC1L6XL090mT4W0axNwHoLE7p9DaggK36rbF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719762841; c=relaxed/simple;
	bh=TvnV+1vxoHd4TZN3fOtt/u/uo4QOyQWl3kPlJkN971w=;
	h=Date:From:To:Cc:Subject:Message-ID; b=s5v9WCCzLif0Qd+54gAxyrr3RMviIlOxeVV03U5xZBahn4tLOdswqIizvV6U36yMN7MrximvX9RQidQHf+z1hdlcw7zlwwoD0tqZQi++IxqAJ1gszFe0TQKA7dpoq/U84OPlsbmRCb4rZxJKlCRk75H2M8O/xz26zYYGfogDAy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gn8MEIE2; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719762837; x=1751298837;
  h=date:from:to:cc:subject:message-id;
  bh=TvnV+1vxoHd4TZN3fOtt/u/uo4QOyQWl3kPlJkN971w=;
  b=Gn8MEIE2dBK4LScxkW7d7t5bHrHJZnf8hDoM6X4CuAODfkgr5d2itMtc
   KNnFRtZ97ZGq/pszr8aXiX4TOePKIN81wk6C16rOICDGmO1ILoJ0CCCmM
   kHBgHBmFycr6EOJeVgG7HhtzbVyhvyRW9HGiYCOm3uZIT0gnwictJD/pF
   DEEucZ0rW3PgUrwrSsnFWvYb6nUVDJx3Gy7XIhD2See8LLRLMWA2K9Hz6
   6WDd76Gm2clIaqwvCNZjnilIyvXBkWJ0gYNV0jpL3BxMkLLq9feCazThw
   MInMW+/Jj9xDi1Thkv+OrIFXB1RQWOWNZMMQH6nL5K82uNL7eOQ34n1mZ
   w==;
X-CSE-ConnectionGUID: IU0HUUKnTbKqEohmne9nQw==
X-CSE-MsgGUID: jlBXk0nCQh+lC6DWq9NyyA==
X-IronPort-AV: E=McAfee;i="6700,10204,11119"; a="17016481"
X-IronPort-AV: E=Sophos;i="6.09,174,1716274800"; 
   d="scan'208";a="17016481"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2024 08:53:56 -0700
X-CSE-ConnectionGUID: cFNvpkiSQM+cRkJ28Ej2Zw==
X-CSE-MsgGUID: y9ZkLz2jRIOoijpqDqy28A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,174,1716274800"; 
   d="scan'208";a="45244817"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 30 Jun 2024 08:53:55 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sNwsB-000LiW-2X;
	Sun, 30 Jun 2024 15:53:51 +0000
Date: Sun, 30 Jun 2024 23:53:03 +0800
From: kernel test robot <lkp@intel.com>
To: Johannes Berg <johannes.berg@intel.com>
Cc: Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org
Subject: [wireless-next:main] BUILD SUCCESS
 8c62617295d3c4cd03f1a02c3b9bf9d4e6d6e0c6
Message-ID: <202406302301.Oc0YTNCR-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: 8c62617295d3c4cd03f1a02c3b9bf9d4e6d6e0c6  wifi: mac80211: remove DEAUTH_NEED_MGD_TX_PREP

elapsed time: 3275m

configs tested: 62
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                   randconfig-001-20240630   gcc-13.2.0
arc                   randconfig-002-20240630   gcc-13.2.0
arm                               allnoconfig   clang-19
arm                   randconfig-001-20240630   gcc-13.2.0
arm                   randconfig-002-20240630   clang-17
arm64                             allnoconfig   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
hexagon                           allnoconfig   clang-19
i386         buildonly-randconfig-001-20240629   gcc-7
i386         buildonly-randconfig-001-20240630   clang-18
i386         buildonly-randconfig-002-20240629   gcc-7
i386         buildonly-randconfig-002-20240630   clang-18
i386         buildonly-randconfig-003-20240629   gcc-7
i386         buildonly-randconfig-003-20240630   clang-18
i386         buildonly-randconfig-004-20240629   gcc-7
i386         buildonly-randconfig-004-20240630   clang-18
i386         buildonly-randconfig-005-20240629   gcc-7
i386         buildonly-randconfig-005-20240630   clang-18
i386         buildonly-randconfig-006-20240629   gcc-7
i386         buildonly-randconfig-006-20240630   clang-18
i386                  randconfig-001-20240629   gcc-7
i386                  randconfig-001-20240630   clang-18
i386                  randconfig-002-20240629   gcc-7
i386                  randconfig-002-20240630   clang-18
i386                  randconfig-003-20240629   gcc-7
i386                  randconfig-003-20240630   clang-18
i386                  randconfig-004-20240629   gcc-7
i386                  randconfig-004-20240630   clang-18
i386                  randconfig-005-20240629   gcc-7
i386                  randconfig-005-20240630   clang-18
i386                  randconfig-006-20240629   gcc-7
i386                  randconfig-006-20240630   clang-18
i386                  randconfig-011-20240629   gcc-7
i386                  randconfig-011-20240630   clang-18
i386                  randconfig-012-20240629   gcc-7
i386                  randconfig-012-20240630   clang-18
i386                  randconfig-013-20240629   gcc-7
i386                  randconfig-013-20240630   clang-18
i386                  randconfig-014-20240629   gcc-7
i386                  randconfig-014-20240630   clang-18
i386                  randconfig-015-20240629   gcc-7
i386                  randconfig-015-20240630   clang-18
i386                  randconfig-016-20240629   gcc-7
i386                  randconfig-016-20240630   clang-18
loongarch                         allnoconfig   gcc-13.2.0
m68k                              allnoconfig   gcc-13.2.0
m68k                             allyesconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-13.2.0
openrisc                          allnoconfig   gcc-13.2.0
parisc                            allnoconfig   gcc-13.2.0
powerpc                           allnoconfig   gcc-13.2.0
riscv                             allnoconfig   gcc-13.2.0
s390                              allnoconfig   gcc-13.2.0
sh                                allnoconfig   gcc-13.2.0
um                                allnoconfig   gcc-13.2.0
x86_64                                  kexec   clang-18
x86_64                               rhel-8.3   clang-18
xtensa                            allnoconfig   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

