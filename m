Return-Path: <linux-wireless+bounces-17575-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A24A12F05
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Jan 2025 00:17:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA3CA7A133F
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jan 2025 23:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3353A1DAC80;
	Wed, 15 Jan 2025 23:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CwzcOaNf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5D31DC982
	for <linux-wireless@vger.kernel.org>; Wed, 15 Jan 2025 23:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736983060; cv=none; b=OUFsYA+iKyg9Zj1fyKNqa7/7Mi3RsvekXnlQXGGbRrpsBup7PCR2iXXweX/DAbybzZLkkB2FrpYEIn8YBj8YfEj+VRHfpDOj/WFm2fc8ASUNSFFcDMPXKE3Wa1/zX9f4JU8Sp5QF1+Y6f4bR/4RBjQb59oMa4Ff1sgShAE7qeUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736983060; c=relaxed/simple;
	bh=KpiWwHPBU8cn7bfIaWcZtYTJFTB9Ri7oDlqiBOCgGzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UESEbAKVMMPSAt0Ido1pKYvRj/xbjhuAyXSoa8GLNu3LoihI5DuzeGAl0osD9hHt/JX9TTVj37RbXZbynTEIbrO3bWnGYRCVycWmnjoLiTusFHGIV7K49OH6XZxvbujB9p2cDeYMd8eGPaKcEba2E2RoqV8XvXfgCaC1cPHBsTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CwzcOaNf; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736983057; x=1768519057;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KpiWwHPBU8cn7bfIaWcZtYTJFTB9Ri7oDlqiBOCgGzY=;
  b=CwzcOaNflH9hThBhlWwxC9v+KLi2LGs4WSbgPh4K+vck9Id3D7My2UCD
   gAYpuWOL2q9yfmE1M87KyRaFogjXu5U8WZWFGR7lrKWLqMBA5M/7LkBsj
   9F9UbIPpr/DYBaf5W9WNDlm8Z7M1DECb11p5AFoaLCWaeUUNo2r6xFQQu
   aaeMU3O+/JcB4K234pdogbXb7DQZMqoHuF33e3JMhTTCdIbrV65yDYdlM
   08sYqncpTXAacEllVrRawdKGPhEgtvZsuli8u1A3DAno5F7M16QEZoaPl
   VPWGtGhF57njMNsHKxUC3DPY77UYexU78Bcw5UtvdXi8fRfs5LpuUkcFu
   w==;
X-CSE-ConnectionGUID: 9BwlgluLRVqrOLMJbk6zrQ==
X-CSE-MsgGUID: 6iY0SSYTS7mTXqos9tHqbw==
X-IronPort-AV: E=McAfee;i="6700,10204,11316"; a="48734518"
X-IronPort-AV: E=Sophos;i="6.13,207,1732608000"; 
   d="scan'208";a="48734518"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2025 15:17:37 -0800
X-CSE-ConnectionGUID: kgZIbBxjQdGjPvS6DawAcQ==
X-CSE-MsgGUID: TS12OjrKSU+x5+ILfGs6PA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,207,1732608000"; 
   d="scan'208";a="110266871"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 15 Jan 2025 15:17:36 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tYCdg-000QzP-2Y;
	Wed, 15 Jan 2025 23:17:32 +0000
Date: Thu, 16 Jan 2025 07:16:46 +0800
From: kernel test robot <lkp@intel.com>
To: Aloka Dixit <quic_alokad@quicinc.com>, ath11k@lists.infradead.org,
	ath12k@lists.infradead.org, linux-wireless@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Aloka Dixit <quic_alokad@quicinc.com>
Subject: Re: [PATCH 1/5] wifi: ath11k: refactor transmitted arvif retrieval
Message-ID: <202501160626.Jbb3GHnk-lkp@intel.com>
References: <20250114223612.2979310-2-quic_alokad@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250114223612.2979310-2-quic_alokad@quicinc.com>

Hi Aloka,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 0c5fcd9069dd5f984e39820629acbfbe0f1b4256]

url:    https://github.com/intel-lab-lkp/linux/commits/Aloka-Dixit/wifi-ath11k-refactor-transmitted-arvif-retrieval/20250115-063922
base:   0c5fcd9069dd5f984e39820629acbfbe0f1b4256
patch link:    https://lore.kernel.org/r/20250114223612.2979310-2-quic_alokad%40quicinc.com
patch subject: [PATCH 1/5] wifi: ath11k: refactor transmitted arvif retrieval
config: hexagon-allyesconfig (https://download.01.org/0day-ci/archive/20250116/202501160626.Jbb3GHnk-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250116/202501160626.Jbb3GHnk-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202501160626.Jbb3GHnk-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/wireless/ath/ath11k/mac.c:6349:46: warning: variable 'tx_vif' is uninitialized when used here [-Wuninitialized]
    6349 |                 if (ar->hw->wiphy != ieee80211_vif_to_wdev(tx_vif)->wiphy)
         |                                                            ^~~~~~
   drivers/net/wireless/ath/ath11k/mac.c:6339:30: note: initialize the variable 'tx_vif' to silence this warning
    6339 |         struct ieee80211_vif *tx_vif;
         |                                     ^
         |                                      = NULL
   1 warning generated.


vim +/tx_vif +6349 drivers/net/wireless/ath/ath11k/mac.c

d5c65159f28953 Kalle Valo  2019-11-23  6333  
5a81610acf66c4 Aloka Dixit 2023-05-05  6334  static int ath11k_mac_setup_vdev_params_mbssid(struct ath11k_vif *arvif,
5a81610acf66c4 Aloka Dixit 2023-05-05  6335  					       u32 *flags, u32 *tx_vdev_id)
5a81610acf66c4 Aloka Dixit 2023-05-05  6336  {
5a81610acf66c4 Aloka Dixit 2023-05-05  6337  	struct ath11k *ar = arvif->ar;
5a81610acf66c4 Aloka Dixit 2023-05-05  6338  	struct ath11k_vif *tx_arvif;
5a81610acf66c4 Aloka Dixit 2023-05-05  6339  	struct ieee80211_vif *tx_vif;
5a81610acf66c4 Aloka Dixit 2023-05-05  6340  
5a81610acf66c4 Aloka Dixit 2023-05-05  6341  	*tx_vdev_id = 0;
72f88bc503a76c Aloka Dixit 2025-01-14  6342  	tx_arvif = ath11k_mac_get_tx_arvif(arvif);
72f88bc503a76c Aloka Dixit 2025-01-14  6343  	if (!tx_arvif) {
5a81610acf66c4 Aloka Dixit 2023-05-05  6344  		*flags = WMI_HOST_VDEV_FLAGS_NON_MBSSID_AP;
5a81610acf66c4 Aloka Dixit 2023-05-05  6345  		return 0;
5a81610acf66c4 Aloka Dixit 2023-05-05  6346  	}
5a81610acf66c4 Aloka Dixit 2023-05-05  6347  
5a81610acf66c4 Aloka Dixit 2023-05-05  6348  	if (arvif->vif->bss_conf.nontransmitted) {
5a81610acf66c4 Aloka Dixit 2023-05-05 @6349  		if (ar->hw->wiphy != ieee80211_vif_to_wdev(tx_vif)->wiphy)
5a81610acf66c4 Aloka Dixit 2023-05-05  6350  			return -EINVAL;
5a81610acf66c4 Aloka Dixit 2023-05-05  6351  
5a81610acf66c4 Aloka Dixit 2023-05-05  6352  		*flags = WMI_HOST_VDEV_FLAGS_NON_TRANSMIT_AP;
5a81610acf66c4 Aloka Dixit 2023-05-05  6353  		*tx_vdev_id = ath11k_vif_to_arvif(tx_vif)->vdev_id;
5a81610acf66c4 Aloka Dixit 2023-05-05  6354  	} else if (tx_arvif == arvif) {
5a81610acf66c4 Aloka Dixit 2023-05-05  6355  		*flags = WMI_HOST_VDEV_FLAGS_TRANSMIT_AP;
5a81610acf66c4 Aloka Dixit 2023-05-05  6356  	} else {
5a81610acf66c4 Aloka Dixit 2023-05-05  6357  		return -EINVAL;
5a81610acf66c4 Aloka Dixit 2023-05-05  6358  	}
5a81610acf66c4 Aloka Dixit 2023-05-05  6359  
5a81610acf66c4 Aloka Dixit 2023-05-05  6360  	if (arvif->vif->bss_conf.ema_ap)
5a81610acf66c4 Aloka Dixit 2023-05-05  6361  		*flags |= WMI_HOST_VDEV_FLAGS_EMA_MODE;
5a81610acf66c4 Aloka Dixit 2023-05-05  6362  
5a81610acf66c4 Aloka Dixit 2023-05-05  6363  	return 0;
5a81610acf66c4 Aloka Dixit 2023-05-05  6364  }
5a81610acf66c4 Aloka Dixit 2023-05-05  6365  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

