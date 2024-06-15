Return-Path: <linux-wireless+bounces-9018-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED45A90985C
	for <lists+linux-wireless@lfdr.de>; Sat, 15 Jun 2024 14:47:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7655B2831A7
	for <lists+linux-wireless@lfdr.de>; Sat, 15 Jun 2024 12:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C988F1DFEF;
	Sat, 15 Jun 2024 12:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W4Mkv3TR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDEC919D8A2
	for <linux-wireless@vger.kernel.org>; Sat, 15 Jun 2024 12:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718455639; cv=none; b=oU4p6BGjt4XwIyimQsgcMUE3YV7o5fTATr4+8uKgsD09PSi/emMRHHjaTsWJCV01F+swxF12Up92OWSnHw5anBwQbuIrUzigpvzN5A2cHo5H1fBfQ6Q02dhD7/C+L7dyge1lGBi365+/Dt3O5gcXqG2NM7v+7TX7yJuE1v1XjO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718455639; c=relaxed/simple;
	bh=HSWx/W9E0f0BND2eZK2tveHMLpdRnEJ7W0pz+H9vlVI=;
	h=Date:From:To:Cc:Subject:Message-ID; b=uZo51tYlb+ZTS8vtmyRAavK7PKAIleS6imhsU2sbGf+TW6CPzrrCQIU/QGqqcX1yzfBSM8WQNYf05yIHOBvDh3jHv0vN5bASLZ7xmxpc2VCDnuSSgqHXdg072DNHgicnTX9LOQidz84YkRCV44Ek0OhoFW/d8+SIz8cU+bfefxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W4Mkv3TR; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718455637; x=1749991637;
  h=date:from:to:cc:subject:message-id;
  bh=HSWx/W9E0f0BND2eZK2tveHMLpdRnEJ7W0pz+H9vlVI=;
  b=W4Mkv3TRScF/g51E2fqtumfUK1R7eV3yFEO8tWetqPhERmJpCOtfVH8/
   IWEV5Ul45Gh4ihLxfmGr1XQVAKCEPL396w9uzrpqimP5+C3C/KCpRdckt
   jaFxkGKy/0QLbnCj92FMdtQ4pjDDD5EljmR5WNh/2hjNvdRMTX+gRib69
   ao7OR8C8Xtl+V4bRI1vog8KZilpV4zgSBf2pj4+COi8gJZJ5dzjfbxP+A
   L49q0GP4+jOyonJOGnnXjkj1ApbuwZilCnOUEPI1peZv234jpZIKMpDAD
   z5XFfsrtJXSGtoYNTTfeKT9VBNZ0oamWU//qyP/fLJYSGa1oYe1L2+gLA
   w==;
X-CSE-ConnectionGUID: jkxL3FXAS0GMSHLzFhtOHg==
X-CSE-MsgGUID: rSVCW8V2QuGQO+8pNBfDDQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11104"; a="25976893"
X-IronPort-AV: E=Sophos;i="6.08,240,1712646000"; 
   d="scan'208";a="25976893"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2024 05:47:17 -0700
X-CSE-ConnectionGUID: kXYQ0rJrS06G2qmv+/cZpg==
X-CSE-MsgGUID: eqyWUA0zQeqiKFAkIP9tng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,240,1712646000"; 
   d="scan'208";a="40708767"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 15 Jun 2024 05:47:15 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sISoL-000016-2s;
	Sat, 15 Jun 2024 12:47:13 +0000
Date: Sat, 15 Jun 2024 20:46:47 +0800
From: kernel test robot <lkp@intel.com>
To: Johannes Berg <johannes.berg@intel.com>
Cc: Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org
Subject: [wireless:for-next] BUILD SUCCESS
 0d9c2beed116e623ac30810d382bd67163650f98
Message-ID: <202406152044.Buy9uN4G-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git for-next
branch HEAD: 0d9c2beed116e623ac30810d382bd67163650f98  wifi: mac80211: fix monitor channel with chanctx emulation

elapsed time: 1738m

configs tested: 65
configs skipped: 2

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha                             allnoconfig   gcc-13.2.0
alpha                               defconfig   gcc-13.2.0
arc                               allnoconfig   gcc-13.2.0
arc                                 defconfig   gcc-13.2.0
arm                               allnoconfig   clang-19
arm                                 defconfig   clang-14
arm64                             allnoconfig   gcc-13.2.0
arm64                               defconfig   gcc-13.2.0
csky                              allnoconfig   gcc-13.2.0
csky                                defconfig   gcc-13.2.0
hexagon                           allnoconfig   clang-19
hexagon                             defconfig   clang-19
loongarch                         allnoconfig   gcc-13.2.0
loongarch                           defconfig   gcc-13.2.0
m68k                              allnoconfig   gcc-13.2.0
m68k                                defconfig   gcc-13.2.0
microblaze                        allnoconfig   gcc-13.2.0
microblaze                          defconfig   gcc-13.2.0
mips                              allnoconfig   gcc-13.2.0
nios2                             allnoconfig   gcc-13.2.0
nios2                               defconfig   gcc-13.2.0
openrisc                          allnoconfig   gcc-13.2.0
openrisc                            defconfig   gcc-13.2.0
parisc                            allnoconfig   gcc-13.2.0
parisc                              defconfig   gcc-13.2.0
parisc64                            defconfig   gcc-13.2.0
powerpc                           allnoconfig   gcc-13.2.0
riscv                             allnoconfig   gcc-13.2.0
riscv                               defconfig   clang-19
s390                              allnoconfig   clang-19
s390                                defconfig   clang-19
sh                                allnoconfig   gcc-13.2.0
sh                                  defconfig   gcc-13.2.0
sparc                             allnoconfig   gcc-13.2.0
sparc                               defconfig   gcc-13.2.0
sparc64                             defconfig   gcc-13.2.0
um                                allnoconfig   clang-17
um                                  defconfig   clang-19
um                             i386_defconfig   gcc-13
um                           x86_64_defconfig   clang-15
x86_64       buildonly-randconfig-001-20240615   gcc-9
x86_64       buildonly-randconfig-002-20240615   clang-18
x86_64       buildonly-randconfig-003-20240615   clang-18
x86_64       buildonly-randconfig-004-20240615   clang-18
x86_64       buildonly-randconfig-005-20240615   gcc-9
x86_64       buildonly-randconfig-006-20240615   clang-18
x86_64                randconfig-001-20240615   gcc-13
x86_64                randconfig-002-20240615   gcc-8
x86_64                randconfig-003-20240615   gcc-13
x86_64                randconfig-004-20240615   gcc-13
x86_64                randconfig-005-20240615   gcc-13
x86_64                randconfig-006-20240615   gcc-8
x86_64                randconfig-011-20240615   clang-18
x86_64                randconfig-012-20240615   gcc-13
x86_64                randconfig-013-20240615   clang-18
x86_64                randconfig-014-20240615   clang-18
x86_64                randconfig-015-20240615   clang-18
x86_64                randconfig-016-20240615   clang-18
x86_64                randconfig-071-20240615   clang-18
x86_64                randconfig-072-20240615   clang-18
x86_64                randconfig-073-20240615   gcc-7
x86_64                randconfig-074-20240615   gcc-13
x86_64                randconfig-075-20240615   clang-18
x86_64                randconfig-076-20240615   gcc-13
xtensa                            allnoconfig   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

