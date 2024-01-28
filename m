Return-Path: <linux-wireless+bounces-2605-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC4B083F45B
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Jan 2024 07:36:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 593A2283763
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Jan 2024 06:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B029D7484;
	Sun, 28 Jan 2024 06:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TOtsd0zq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA956FB8
	for <linux-wireless@vger.kernel.org>; Sun, 28 Jan 2024 06:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706423780; cv=none; b=mcCD6/+Ip8avCaVzOnyi7HYmiReTsHaAZ0rWLamDvwr52x4F1efy+LKLjyZglWNmXgayNDYoyEEqntbGqgeIZjy3yJaPzouxa2njpPJGDKHIotFfpSykKFlLqR3ch3Bb01bY60jVB772/4mOgPi7uUteylDElcYLJl0BYlqFhgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706423780; c=relaxed/simple;
	bh=IkKswsgufv9d9v1e0P+Y3b7KYq7ic3X/OHmHF0ze/88=;
	h=Date:From:To:Cc:Subject:Message-ID; b=P2JPbvr2EpoROrbDfedwnoDVWdbTvGkam0bfMHMdoGpGUFLa5wvocYE24O8CYJGP9JRzRlgSy+gVRtq8Oh+i1dT4JqlQlYKkyLhyVRveGAK9xMABsqTys+E8IuCqdMApFfgdKNX2vgTif7BjRzG11uNYfyytBreV8fQBxNyWxNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TOtsd0zq; arc=none smtp.client-ip=134.134.136.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706423778; x=1737959778;
  h=date:from:to:cc:subject:message-id;
  bh=IkKswsgufv9d9v1e0P+Y3b7KYq7ic3X/OHmHF0ze/88=;
  b=TOtsd0zqoxCPgImn4PIsFMP3TimJsA3ECr1gF/0RTu3NMjhxIXczM7TK
   xCC0ycSq+e8zDDiSyaPjmr3M3CYVkhzhXLepl/0QeqqwlcuG2sgbiVjlr
   ZOkWln3WO6Z5fzLdOyf7ccy4RPxpxprq6dOncowUx1Bs8/nuke+PGXy/P
   F+29lIL0bsUZcIav8LQs6Q1OczubbRuoXJn23qv8lR12BimhO5XIPU4nj
   3/rEwH4dSVHkMF5s/SS8I1ZrjBC/P04DqkkHyka3jl/+l75gySdDJf5s8
   GMmugTmm8bBqlu9DgEaeBkf/e+BQs8tOJlGyTAdlvYeszB2lJUpV5PY5+
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10966"; a="406467987"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="406467987"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2024 22:36:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10966"; a="960596297"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="960596297"
Received: from lkp-server01.sh.intel.com (HELO 370188f8dc87) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 27 Jan 2024 22:36:16 -0800
Received: from kbuild by 370188f8dc87 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rTym6-0003AK-1V;
	Sun, 28 Jan 2024 06:36:14 +0000
Date: Sun, 28 Jan 2024 14:35:19 +0800
From: kernel test robot <lkp@intel.com>
To: Johannes Berg <johannes.berg@intel.com>
Cc: Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org
Subject: [wireless-next:main] BUILD SUCCESS
 28b3df1fe6ba2cb439ba109f095aa841fef3a54f
Message-ID: <202401281416.Pla73RUm-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless-next.git main
branch HEAD: 28b3df1fe6ba2cb439ba109f095aa841fef3a54f  kunit: add wireless unit tests

elapsed time: 2628m

configs tested: 49
configs skipped: 1

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
i386         buildonly-randconfig-001-20240127   gcc  
i386         buildonly-randconfig-002-20240127   gcc  
i386         buildonly-randconfig-003-20240127   gcc  
i386         buildonly-randconfig-004-20240127   gcc  
i386         buildonly-randconfig-005-20240127   gcc  
i386         buildonly-randconfig-006-20240127   gcc  
i386                  randconfig-001-20240127   gcc  
i386                  randconfig-002-20240127   gcc  
i386                  randconfig-003-20240127   gcc  
i386                  randconfig-004-20240127   gcc  
i386                  randconfig-005-20240127   gcc  
i386                  randconfig-006-20240127   gcc  
i386                  randconfig-011-20240127   clang
i386                  randconfig-012-20240127   clang
i386                  randconfig-013-20240127   clang
i386                  randconfig-014-20240127   clang
i386                  randconfig-015-20240127   clang
i386                  randconfig-016-20240127   clang
openrisc                          allnoconfig   gcc  
openrisc                         allyesconfig   gcc  
openrisc                            defconfig   gcc  
parisc                           allmodconfig   gcc  
parisc                            allnoconfig   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc64                            defconfig   gcc  
powerpc                          allmodconfig   clang
powerpc                           allnoconfig   gcc  
riscv                             allnoconfig   clang
riscv                               defconfig   gcc  
s390                             allmodconfig   gcc  
s390                              allnoconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
sh                               allmodconfig   gcc  
sh                                allnoconfig   gcc  
sh                               allyesconfig   gcc  
sh                                  defconfig   gcc  
sparc                            allmodconfig   gcc  
sparc                             allnoconfig   gcc  
sparc                               defconfig   gcc  
sparc64                          allmodconfig   gcc  
sparc64                          allyesconfig   gcc  
sparc64                             defconfig   gcc  
um                                allnoconfig   clang
um                                  defconfig   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
xtensa                            allnoconfig   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

