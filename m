Return-Path: <linux-wireless+bounces-15310-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 230499CD4CF
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Nov 2024 01:50:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B213AB23DFE
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Nov 2024 00:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C09251F95A;
	Fri, 15 Nov 2024 00:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VD6I50GF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1317F1E53A
	for <linux-wireless@vger.kernel.org>; Fri, 15 Nov 2024 00:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731631802; cv=none; b=Ey5+f29DluPMDGB4uikxhuY68Ej3D4zkfuu20NCGCWlCJuU7FxOoFEF3ux6zWLG3eEULSa1EQhoY3mmd4u1L0IFVYfpOqjlhR1VcztklX1QmhChf/CuC6ImzORE7VZzHyCnvJndMPWlmT3mCtvDfP6Z5E0GqR4ZiUAE+mW4vbk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731631802; c=relaxed/simple;
	bh=flRJZxG+ymDyqDtwmsa6YYK4mk6x5MkE8Akv3OJ/QEQ=;
	h=Date:From:To:Cc:Subject:Message-ID; b=d2sotzAmkC4zeQkJgvD81E2R/veMixo+0J/ELdaB0FGIs8P+B1rG1/YXrOi15sJsrkWnNoLxa3VuzJ9RHevNVJQRL2/ZD0NcE/J8oxcEuW8cZgi4a0ca+ymaj7Xp4Wwx/YmkhhkJvIbjdYp02xlGpHRM9xJTRMoO9B8YZ+xtFPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VD6I50GF; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731631801; x=1763167801;
  h=date:from:to:cc:subject:message-id;
  bh=flRJZxG+ymDyqDtwmsa6YYK4mk6x5MkE8Akv3OJ/QEQ=;
  b=VD6I50GFCESt66tz5wzsTOGHVDLVRFKT+eiPK5suhs9aQXykbMi9oZT8
   mTvwyLB3m5yhMhmiShAkL2f4S6fFSG44ylPOdWe+w6y7fPmzD3b2LNpUe
   csAy7g+KIjzVWQGjlfsI+B4wrPcXCwY4S+F/OYWoB6fQ2ZokdxSvD5z+x
   Q4oTGyaYkuxvNLBa4QEczgxLE6BixjMsfs+O2LMAFuqlJeTLDdKA+bBE2
   oFEscgwnjT/1YM70L4fivgz751PkiuuH5CSj0sCTYNqTulXTmHAEGE3Yf
   G1IXkOsKAfF6eiH7tXKbVaxMgzI4qnC0gmfOvM70QRtrMlZ4vsYVq8myN
   w==;
X-CSE-ConnectionGUID: /fo4RE57ShCcLxHbQSwkfA==
X-CSE-MsgGUID: /FK95WvDRBum/SqsDvdS6g==
X-IronPort-AV: E=McAfee;i="6700,10204,11256"; a="19221402"
X-IronPort-AV: E=Sophos;i="6.12,155,1728975600"; 
   d="scan'208";a="19221402"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2024 16:50:00 -0800
X-CSE-ConnectionGUID: 3WJ/iif+S1ChIwgsZYX9Kw==
X-CSE-MsgGUID: 4yeBrf75TPaJi/noIWuKyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,155,1728975600"; 
   d="scan'208";a="92442267"
Received: from lkp-server02.sh.intel.com (HELO f5eddd9a323a) ([10.239.97.151])
  by fmviesa003.fm.intel.com with ESMTP; 14 Nov 2024 16:49:59 -0800
Received: from kbuild by f5eddd9a323a with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tBkWH-00009H-1L;
	Fri, 15 Nov 2024 00:49:13 +0000
Date: Fri, 15 Nov 2024 08:47:56 +0800
From: kernel test robot <lkp@intel.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>,
 Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org
Subject: [wireless-next:main] BUILD SUCCESS
 a71c69f51d1119db5f7812b35f16e8ef7786b3f2
Message-ID: <202411150847.qD8kSlGy-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: a71c69f51d1119db5f7812b35f16e8ef7786b3f2  Merge branch 'net-dsa-microchip-add-lan9646-switch-support'

elapsed time: 1163m

configs tested: 34
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
alpha       allyesconfig    gcc-14.2.0
arc         allmodconfig    gcc-13.2.0
arc         allyesconfig    gcc-13.2.0
arm         allmodconfig    gcc-14.2.0
arm         allyesconfig    gcc-14.2.0
arm64       allmodconfig    clang-20
hexagon     allmodconfig    clang-20
hexagon     allyesconfig    clang-20
i386        allmodconfig    gcc-12
i386         allnoconfig    gcc-12
i386        allyesconfig    gcc-12
i386           defconfig    clang-19
loongarch   allmodconfig    gcc-14.2.0
m68k        allmodconfig    gcc-14.2.0
m68k        allyesconfig    gcc-14.2.0
microblaze  allmodconfig    gcc-14.2.0
microblaze  allyesconfig    gcc-14.2.0
openrisc    allyesconfig    gcc-14.2.0
parisc      allmodconfig    gcc-14.2.0
parisc      allyesconfig    gcc-14.2.0
powerpc     allmodconfig    gcc-14.2.0
powerpc     allyesconfig    clang-20
riscv       allmodconfig    clang-20
riscv       allyesconfig    clang-20
s390        allmodconfig    clang-20
s390        allyesconfig    gcc-14.2.0
sh          allmodconfig    gcc-14.2.0
sh          allyesconfig    gcc-14.2.0
sparc       allmodconfig    gcc-14.2.0
um          allmodconfig    clang-20
um          allyesconfig    gcc-12
x86_64       allnoconfig    clang-19
x86_64      allyesconfig    clang-19
x86_64         defconfig    gcc-11

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

