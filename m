Return-Path: <linux-wireless+bounces-9701-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D9CF91CE10
	for <lists+linux-wireless@lfdr.de>; Sat, 29 Jun 2024 18:15:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFA9A1F219A1
	for <lists+linux-wireless@lfdr.de>; Sat, 29 Jun 2024 16:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8019742A81;
	Sat, 29 Jun 2024 16:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R2845BTU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A625C12D76C
	for <linux-wireless@vger.kernel.org>; Sat, 29 Jun 2024 16:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719677710; cv=none; b=u/4d2cwVEdng7pgGcZbgMzWtQTMcshty3nztiGJWjBl9v4ZrCJwYc0su0KW1jW6GWVUtHOK6aNQJ/hGlw6MEbTqFNewYm7u5Hvp4mgzyYwUHm29VS4Rl1+DzNtiNi8kkheNhuDh2WganRvrqkQR9kIT1h5MGTs5MV1j2PQatx3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719677710; c=relaxed/simple;
	bh=rTGyhcwf4OUHgBvXEe3zJi5skdV4iuU4JR87RTQpjKo=;
	h=Date:From:To:Cc:Subject:Message-ID; b=NdDWMSD2Xgri8FFRAW7MO5bcFC/5M6zbwPO2CAPWyawlcRx3+SrT1AIpCtmdrpEAKYSG5R+uJcujmxH3TCsa0U77wsea8vJ1N0Ky1Wm406qzh5DAq4N9J4Cewit3/86zcafoCXodxEBcAWvB3tAb0oc6Gx4uR4TrlcPefVdfEsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R2845BTU; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719677709; x=1751213709;
  h=date:from:to:cc:subject:message-id;
  bh=rTGyhcwf4OUHgBvXEe3zJi5skdV4iuU4JR87RTQpjKo=;
  b=R2845BTUg5/7eGXbrBFXdzZSttsZTm+6rVSnNBpdqfAD7kMbHw+MFiRI
   b4nVr2bqAvlWLeDoifDA74SwS07cqhrMjo0WZ5qG1lRCuNTiKQdtHRHXn
   T9v2QlbGUKoQs8H8gOw0dfYWrU6v7/dz/qH+o6VfSxekp7iZSbd+rJz0w
   JXq6vZCBxt5B6LtYNztfrWdvKnHSNK04i0D4Gmm4Bl13vLVmmslNyUd6O
   r8roeQEA2us/479uDgQhJhVCFVd3FhTgrzYPuPNsz9C6n1zGuP/efhyJA
   2XTS5mrPw1D0BwXts3Tupjn0yfhLkOyxoN7e5LL6mWLTawkv5BduRyiYh
   Q==;
X-CSE-ConnectionGUID: oUk2TkKsQw2LIXfBZWJBbA==
X-CSE-MsgGUID: jpADuP5WRNC0QPxAmwdscw==
X-IronPort-AV: E=McAfee;i="6700,10204,11117"; a="27434974"
X-IronPort-AV: E=Sophos;i="6.09,172,1716274800"; 
   d="scan'208";a="27434974"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2024 09:15:09 -0700
X-CSE-ConnectionGUID: IxllFJgsTluZ44NMccAE+A==
X-CSE-MsgGUID: lS8ReT7LSv2RsnFl94LNug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,172,1716274800"; 
   d="scan'208";a="45457884"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 29 Jun 2024 09:15:07 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sNajB-000Jfj-0E;
	Sat, 29 Jun 2024 16:15:05 +0000
Date: Sun, 30 Jun 2024 00:14:57 +0800
From: kernel test robot <lkp@intel.com>
To: Johannes Berg <johannes.berg@intel.com>
Cc: Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org
Subject: [wireless:for-next] BUILD SUCCESS
 816c6bec09ed5b90a58a1e12d5a606c5b6e23f47
Message-ID: <202406300055.7BGkLIox-lkp@intel.com>
User-Agent: s-nail v14.9.24
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git for-next
branch HEAD: 816c6bec09ed5b90a58a1e12d5a606c5b6e23f47  wifi: mac80211: fix BSS_CHANGED_UNSOL_BCAST_PROBE_RESP

elapsed time: 1856m

configs tested: 26
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

tested configs:
i386         buildonly-randconfig-001-20240629   gcc-7
i386         buildonly-randconfig-002-20240629   gcc-7
i386         buildonly-randconfig-003-20240629   gcc-7
i386         buildonly-randconfig-004-20240629   gcc-7
i386         buildonly-randconfig-005-20240629   gcc-7
i386         buildonly-randconfig-006-20240629   gcc-7
i386                  randconfig-001-20240629   gcc-7
i386                  randconfig-002-20240629   gcc-7
i386                  randconfig-003-20240629   gcc-7
i386                  randconfig-004-20240629   gcc-7
i386                  randconfig-005-20240629   gcc-7
i386                  randconfig-006-20240629   gcc-7
i386                  randconfig-011-20240629   gcc-7
i386                  randconfig-012-20240629   gcc-7
i386                  randconfig-013-20240629   gcc-7
i386                  randconfig-014-20240629   gcc-7
i386                  randconfig-015-20240629   gcc-7
i386                  randconfig-016-20240629   gcc-7
openrisc                          allnoconfig   gcc-13.2.0
parisc                            allnoconfig   gcc-13.2.0
powerpc                           allnoconfig   gcc-13.2.0
riscv                             allnoconfig   gcc-13.2.0
s390                              allnoconfig   clang-19
s390                              allnoconfig   gcc-13.2.0
um                                allnoconfig   clang-17
um                                allnoconfig   gcc-13.2.0

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

