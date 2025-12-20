Return-Path: <linux-wireless+bounces-30034-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 21E47CD34B8
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Dec 2025 19:00:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D4225300FF83
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Dec 2025 18:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5884323C39A;
	Sat, 20 Dec 2025 18:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GMq93kfV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6845F1F1534;
	Sat, 20 Dec 2025 18:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766253640; cv=none; b=KXn8IJDSkzXpArE8EHfIR3XfzpQvStOcngpDI335xwzDwQKsynowfWz6yujBmnHgf+bDjMj5zpWJW9+0QtqlD8E6FA34I4eIokRHHrsUelRQQ/RsqP88blp7H1QRG2eIrmVOMV0IRGBtXYsKrrDccLviHA5KSn8CuLBArOuRBb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766253640; c=relaxed/simple;
	bh=iZOzBrN9E6HT9Vz/gHHRFRpMcm7hVTbfgPpqMMo+7fg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ItGj15gnET7div157k+yME1RJ9nxZOzT5KfiNg3qK6md/hk+O6CPoEkf11s2el73sjRhyvLKDME4azkKwwiNNB7tCejPPM62dfbe1saJXWIx12gmsAZBlcSQ1h63wrE5jp9tRiLv9ku0pXM5u5+Fu8w0ua3Ky0afFDEOVTimciI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GMq93kfV; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766253639; x=1797789639;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iZOzBrN9E6HT9Vz/gHHRFRpMcm7hVTbfgPpqMMo+7fg=;
  b=GMq93kfV5g0KVgwBNb8SwQu/stCzFBtyIyGw8tGtGZxHINZKsit/3AkI
   X9BiS5CxYtS9qxZcFiHuadOz4GHA5/z54iJtvGYNAIMPaQVtUxKPfIaEE
   ViHOoBkCJHbZx8FLiq/Km8ngDVCfyyfjU+0zy8zThAFLNF6pTUQ/MHh/c
   qzvcgrIzrUnd+8UQcI3eEBBaPbIjdLNScayqzOzNx/026HSs60JhU87ih
   iUHMSpmrE+A1rI9ptuNU9oo0usNHjChMQUDzV8KWi0Z6hQAKKFvhpDPHj
   dFxQZ7fig/N7R5TawjTjs2WOo0ZaGAIiezMSZKw+GJwvMbttas4bToAe6
   A==;
X-CSE-ConnectionGUID: OTOmN5FuTImjSEcWHsSj/Q==
X-CSE-MsgGUID: S6xV9BrFR/W30X8y4spsjg==
X-IronPort-AV: E=McAfee;i="6800,10657,11648"; a="93655464"
X-IronPort-AV: E=Sophos;i="6.21,164,1763452800"; 
   d="scan'208";a="93655464"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2025 10:00:38 -0800
X-CSE-ConnectionGUID: URlEA9PHS3Grb2hfNuJ1lg==
X-CSE-MsgGUID: akQG4a5tSN6nQJS3wlgYiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,164,1763452800"; 
   d="scan'208";a="199180350"
Received: from lkp-server01.sh.intel.com (HELO 0d09efa1b85f) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 20 Dec 2025 10:00:33 -0800
Received: from kbuild by 0d09efa1b85f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vX1Fo-000000004zh-2i2t;
	Sat, 20 Dec 2025 18:00:32 +0000
Date: Sun, 21 Dec 2025 01:59:46 +0800
From: kernel test robot <lkp@intel.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-mmc@vger.kernel.org, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/4] wifi: rsi: sdio: Reduce use of #ifdef for
 CONFIG_PM
Message-ID: <202512210133.jrzKgXWS-lkp@intel.com>
References: <f291cca2741f6ac994b2bde1fb9d21194fec4d3e.1765968841.git.ukleinek@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f291cca2741f6ac994b2bde1fb9d21194fec4d3e.1765968841.git.ukleinek@kernel.org>

Hi Uwe,

kernel test robot noticed the following build errors:

[auto build test ERROR on 8f0b4cce4481fb22653697cced8d0d04027cb1e8]

url:    https://github.com/intel-lab-lkp/linux/commits/Uwe-Kleine-K-nig/sdio-Provide-a-bustype-shutdown-function/20251217-191920
base:   8f0b4cce4481fb22653697cced8d0d04027cb1e8
patch link:    https://lore.kernel.org/r/f291cca2741f6ac994b2bde1fb9d21194fec4d3e.1765968841.git.ukleinek%40kernel.org
patch subject: [PATCH v1 2/4] wifi: rsi: sdio: Reduce use of #ifdef for CONFIG_PM
config: hexagon-allmodconfig (https://download.01.org/0day-ci/archive/20251221/202512210133.jrzKgXWS-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251221/202512210133.jrzKgXWS-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512210133.jrzKgXWS-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/net/wireless/rsi/rsi_91x_sdio.c:1454:36: error: no member named 'wowlan_config' in 'struct wiphy'
    1454 |         if (hw && hw->wiphy && hw->wiphy->wowlan_config) {
         |                                ~~~~~~~~~  ^
>> drivers/net/wireless/rsi/rsi_91x_sdio.c:1455:7: error: call to undeclared function 'rsi_config_wowlan'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    1455 |                 if (rsi_config_wowlan(adapter, hw->wiphy->wowlan_config))
         |                     ^
   drivers/net/wireless/rsi/rsi_91x_sdio.c:1455:45: error: no member named 'wowlan_config' in 'struct wiphy'
    1455 |                 if (rsi_config_wowlan(adapter, hw->wiphy->wowlan_config))
         |                                                ~~~~~~~~~  ^
   3 errors generated.


vim +1454 drivers/net/wireless/rsi/rsi_91x_sdio.c

b6c8d06c8a6465 Karun Eagalapati  2017-10-27  1444  
063848c3e1558e Karun Eagalapati  2017-10-27  1445  static void rsi_shutdown(struct device *dev)
063848c3e1558e Karun Eagalapati  2017-10-27  1446  {
063848c3e1558e Karun Eagalapati  2017-10-27  1447  	struct sdio_func *pfunction = dev_to_sdio_func(dev);
063848c3e1558e Karun Eagalapati  2017-10-27  1448  	struct rsi_hw *adapter = sdio_get_drvdata(pfunction);
f9bf6e729f4ebc Wu Yunchuan       2023-08-03  1449  	struct rsi_91x_sdiodev *sdev = adapter->rsi_dev;
063848c3e1558e Karun Eagalapati  2017-10-27  1450  	struct ieee80211_hw *hw = adapter->hw;
063848c3e1558e Karun Eagalapati  2017-10-27  1451  
063848c3e1558e Karun Eagalapati  2017-10-27  1452  	rsi_dbg(ERR_ZONE, "SDIO Bus shutdown =====>\n");
063848c3e1558e Karun Eagalapati  2017-10-27  1453  
b241e260820b68 Marek Vasut       2023-05-28 @1454  	if (hw && hw->wiphy && hw->wiphy->wowlan_config) {
b241e260820b68 Marek Vasut       2023-05-28 @1455  		if (rsi_config_wowlan(adapter, hw->wiphy->wowlan_config))
063848c3e1558e Karun Eagalapati  2017-10-27  1456  			rsi_dbg(ERR_ZONE, "Failed to configure WoWLAN\n");
16bbc3eb83728c Martin Kepplinger 2020-01-29  1457  	}
063848c3e1558e Karun Eagalapati  2017-10-27  1458  
cbde979b33fa16 Siva Rebbagondla  2019-02-04  1459  	if (IS_ENABLED(CONFIG_RSI_COEX) && adapter->priv->coex_mode > 1 &&
cbde979b33fa16 Siva Rebbagondla  2019-02-04  1460  	    adapter->priv->bt_adapter) {
cbde979b33fa16 Siva Rebbagondla  2019-02-04  1461  		rsi_bt_ops.detach(adapter->priv->bt_adapter);
cbde979b33fa16 Siva Rebbagondla  2019-02-04  1462  		adapter->priv->bt_adapter = NULL;
cbde979b33fa16 Siva Rebbagondla  2019-02-04  1463  	}
cbde979b33fa16 Siva Rebbagondla  2019-02-04  1464  
063848c3e1558e Karun Eagalapati  2017-10-27  1465  	rsi_sdio_disable_interrupts(sdev->pfunction);
063848c3e1558e Karun Eagalapati  2017-10-27  1466  
063848c3e1558e Karun Eagalapati  2017-10-27  1467  	if (sdev->write_fail)
063848c3e1558e Karun Eagalapati  2017-10-27  1468  		rsi_dbg(INFO_ZONE, "###### Device is not ready #######\n");
063848c3e1558e Karun Eagalapati  2017-10-27  1469  
063848c3e1558e Karun Eagalapati  2017-10-27  1470  	rsi_dbg(INFO_ZONE, "***** RSI module shut down *****\n");
063848c3e1558e Karun Eagalapati  2017-10-27  1471  }
063848c3e1558e Karun Eagalapati  2017-10-27  1472  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

