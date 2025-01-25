Return-Path: <linux-wireless+bounces-17925-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6187A1C2FA
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Jan 2025 12:50:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 228C3167E6D
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Jan 2025 11:50:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC9561E1C26;
	Sat, 25 Jan 2025 11:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H1UJqSEQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C31C1DDA3C
	for <linux-wireless@vger.kernel.org>; Sat, 25 Jan 2025 11:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737805856; cv=none; b=smCj3KUJ6rNX9XhjkzoyqJoTDXYiQ0rdQXXeFHnzFHGIqJ4mPpfFJxtfpJwdlgyn3bpMdDdBY4xPdwy71gLRw/SlSaY9ucDRSoB2ev8buDmEj67DTf7JI7XGTbrGjFoW9yFta9R8r41hRHmnqresXjA8ma9GSrWo12phm3rDD9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737805856; c=relaxed/simple;
	bh=tLQxd9PZHnxIw8x47h8Ket6AvGPO8g7//q4h0rLHhcA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y4HUiE9NkJ+yve5Ir5Sxw4sGrKIjmhKzppA1oWZnCuuSTc+syMh1IvDT/IomLE7HiUPtrB2KCV/PrZdhbYS3JP94QF9oJwDfnEO8vlFObjOQviEoSMRH1SFjzB1o5pJUWvidAjjYvMPBNglI/JRxw906kM+9ku37RR8arD9W6Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H1UJqSEQ; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737805855; x=1769341855;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tLQxd9PZHnxIw8x47h8Ket6AvGPO8g7//q4h0rLHhcA=;
  b=H1UJqSEQve0dEZHOlZ+AIcQPsFz4z41e+NNkIhXUT3iXG8H8sBK9ta5O
   EFW3ckBebgqt+H3doIQTBfsAcWcKv41CLIq/NXViK+2QVZ+hjOTb5f0EV
   MLiMK9KOjLbE1qZn8V1GkaT0LYxaFVOnHNZy+Vun06yS3fulPJ/NAhjEE
   v4xBFi62qO5jpDOyRw4uxJ9aBVo6dsO7dxvkT/jH3kkFZrHpaDqyB7mcq
   ws4z09+QdTVqfIu40BqAMTEye50m/UBW3/2YqE+8SGetH2jU6v32zMxvr
   bAI8JUDK5mxIFOQV14ENH3H7HXG5/mUws5CM/yEDKjEkn2nTIFVZ+Xde3
   w==;
X-CSE-ConnectionGUID: LGxRLLpLTDGQ+0K0cvl+ng==
X-CSE-MsgGUID: 7VW1wmUsRSm7ye430G/tsg==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="38433476"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="38433476"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2025 03:50:54 -0800
X-CSE-ConnectionGUID: lO88u461THulesFgCqr6aw==
X-CSE-MsgGUID: QKB0x6pYTEWDxtaVcPsF5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="108437501"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 25 Jan 2025 03:50:52 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tbegc-000dmR-1S;
	Sat, 25 Jan 2025 11:50:50 +0000
Date: Sat, 25 Jan 2025 19:49:59 +0800
From: kernel test robot <lkp@intel.com>
To: Roopni Devanathan <quic_rdevanat@quicinc.com>,
	ath12k@lists.infradead.org
Cc: oe-kbuild-all@lists.linux.dev, linux-wireless@vger.kernel.org,
	Roopni Devanathan <quic_rdevanat@quicinc.com>
Subject: Re: [PATCH v2 3/5] wifi: mac80211: Set RTS threshold on per-radio
 basis
Message-ID: <202501251909.8i7nEm4H-lkp@intel.com>
References: <20250124171756.3418663-4-quic_rdevanat@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250124171756.3418663-4-quic_rdevanat@quicinc.com>

Hi Roopni,

kernel test robot noticed the following build warnings:

[auto build test WARNING on e7ef944b3e2c31b608800925e784f67596375770]

url:    https://github.com/intel-lab-lkp/linux/commits/Roopni-Devanathan/wifi-cfg80211-Add-Support-to-Set-RTS-Threshold-for-each-Radio/20250125-012016
base:   e7ef944b3e2c31b608800925e784f67596375770
patch link:    https://lore.kernel.org/r/20250124171756.3418663-4-quic_rdevanat%40quicinc.com
patch subject: [PATCH v2 3/5] wifi: mac80211: Set RTS threshold on per-radio basis
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20250125/202501251909.8i7nEm4H-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250125/202501251909.8i7nEm4H-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202501251909.8i7nEm4H-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/wireless/rsi/rsi_91x_mac80211.c:1211: warning: Function parameter or struct member 'radio_id' not described in 'rsi_mac80211_set_rts_threshold'


vim +1211 drivers/net/wireless/rsi/rsi_91x_mac80211.c

dad0d04fa7ba41 Fariya Fatima     2014-03-16  1200  
dad0d04fa7ba41 Fariya Fatima     2014-03-16  1201  /**
dad0d04fa7ba41 Fariya Fatima     2014-03-16  1202   * rsi_mac80211_set_rts_threshold() - This function sets rts threshold value.
dad0d04fa7ba41 Fariya Fatima     2014-03-16  1203   * @hw: Pointer to the ieee80211_hw structure.
dad0d04fa7ba41 Fariya Fatima     2014-03-16  1204   * @value: Rts threshold value.
dad0d04fa7ba41 Fariya Fatima     2014-03-16  1205   *
dad0d04fa7ba41 Fariya Fatima     2014-03-16  1206   * Return: 0 on success.
dad0d04fa7ba41 Fariya Fatima     2014-03-16  1207   */
dad0d04fa7ba41 Fariya Fatima     2014-03-16  1208  static int rsi_mac80211_set_rts_threshold(struct ieee80211_hw *hw,
607be4e860ab07 Roopni Devanathan 2025-01-24  1209  					  u8 radio_id,
dad0d04fa7ba41 Fariya Fatima     2014-03-16  1210  					  u32 value)
dad0d04fa7ba41 Fariya Fatima     2014-03-16 @1211  {
dad0d04fa7ba41 Fariya Fatima     2014-03-16  1212  	struct rsi_hw *adapter = hw->priv;
dad0d04fa7ba41 Fariya Fatima     2014-03-16  1213  	struct rsi_common *common = adapter->priv;
dad0d04fa7ba41 Fariya Fatima     2014-03-16  1214  
dad0d04fa7ba41 Fariya Fatima     2014-03-16  1215  	mutex_lock(&common->mutex);
dad0d04fa7ba41 Fariya Fatima     2014-03-16  1216  	common->rts_threshold = value;
dad0d04fa7ba41 Fariya Fatima     2014-03-16  1217  	mutex_unlock(&common->mutex);
dad0d04fa7ba41 Fariya Fatima     2014-03-16  1218  
dad0d04fa7ba41 Fariya Fatima     2014-03-16  1219  	return 0;
dad0d04fa7ba41 Fariya Fatima     2014-03-16  1220  }
dad0d04fa7ba41 Fariya Fatima     2014-03-16  1221  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

