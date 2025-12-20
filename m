Return-Path: <linux-wireless+bounces-30033-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D73CD336E
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Dec 2025 17:21:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A55C3011EF0
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Dec 2025 16:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9938C30BF6C;
	Sat, 20 Dec 2025 16:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fuetCjue"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52C230B52B;
	Sat, 20 Dec 2025 16:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766247688; cv=none; b=BG6QyY/xKbvXvWlnABTlhJKZnAH77458+wkGVqpCLtcu8FoTevo2SVArmhyrPpD/5x/qjU7/H2Q1P5gB5z0qH8fiAdmXnF43u1YGwasazeePnl5WCqeH1AsXxgMiZLMd91JB4Y4ioWKgNRmUHhOo0yLM8OCNDfPwLdlUQwBLuc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766247688; c=relaxed/simple;
	bh=M6OKeqRYm4T/gTgflSPXWGhNilkyUfsYAEKOPTK/+hQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UBenmW5IgNh047dzQGHmguJjckuQgYJvxD4SAjJnCyYhMA6joZla8nulFvdBCID2IJ6Twfd4OTzadYs+zgwNuByYXK68rszTBQtN5GShY+n2nsXYUnQK6SGhXyDfqa59UUd7aJx+F9mNDxiUqQ3y0jfQw+ImkhDLACbkQWWMDNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fuetCjue; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766247687; x=1797783687;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=M6OKeqRYm4T/gTgflSPXWGhNilkyUfsYAEKOPTK/+hQ=;
  b=fuetCjueunv/G4jbaa+IYUknlFR4Pi7ijyYVWT3gmvqQcvqA2YdsS1BR
   cCPcBLVleftaFndf3JRqy+q6EJdnqJa78QdYuMVeuhsj4Nff5zcL2kkvQ
   fkgMLBdjWEzaBHqocHJ0xkOPnuqU342zUpXwdx3rv6NyPuDLQ7EqAVxwr
   qmlhk93zLqVlID+BgBBnzm+i9IqVAxMjh+aioCHSL/ng6s/7dXK8xV7eF
   o9/DA01yLBT02hKMrgGtWWGmQAJ5dzX9BTb+lAnv6jYkqFh4W8kgH7shC
   +Q/E4tGB1kUxuhb3u+tYaw3/lJvskp2wJZC8BSOPziSimTZ0s36p2MlND
   A==;
X-CSE-ConnectionGUID: baiKQzCJTGKkesroxBSwVA==
X-CSE-MsgGUID: y9UanKXfR7qJwQchKF7EXg==
X-IronPort-AV: E=McAfee;i="6800,10657,11648"; a="67375373"
X-IronPort-AV: E=Sophos;i="6.21,164,1763452800"; 
   d="scan'208";a="67375373"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2025 08:21:26 -0800
X-CSE-ConnectionGUID: Y8quD3aHQxS9TPQlAtiCUg==
X-CSE-MsgGUID: oz11ZpJOSYOZ0X6FSje0Tg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,164,1763452800"; 
   d="scan'208";a="222604687"
Received: from lkp-server01.sh.intel.com (HELO 0d09efa1b85f) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 20 Dec 2025 08:21:24 -0800
Received: from kbuild by 0d09efa1b85f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vWzhq-000000004rn-2PVx;
	Sat, 20 Dec 2025 16:21:22 +0000
Date: Sun, 21 Dec 2025 00:20:25 +0800
From: kernel test robot <lkp@intel.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-mmc@vger.kernel.org,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/4] wifi: rsi: sdio: Reduce use of #ifdef for
 CONFIG_PM
Message-ID: <202512210032.6Skz9prt-lkp@intel.com>
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
config: nios2-allmodconfig (https://download.01.org/0day-ci/archive/20251221/202512210032.6Skz9prt-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251221/202512210032.6Skz9prt-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512210032.6Skz9prt-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/net/wireless/rsi/rsi_91x_sdio.c: In function 'rsi_shutdown':
>> drivers/net/wireless/rsi/rsi_91x_sdio.c:1454:41: error: 'struct wiphy' has no member named 'wowlan_config'
    1454 |         if (hw && hw->wiphy && hw->wiphy->wowlan_config) {
         |                                         ^~
>> drivers/net/wireless/rsi/rsi_91x_sdio.c:1455:21: error: implicit declaration of function 'rsi_config_wowlan' [-Werror=implicit-function-declaration]
    1455 |                 if (rsi_config_wowlan(adapter, hw->wiphy->wowlan_config))
         |                     ^~~~~~~~~~~~~~~~~
   drivers/net/wireless/rsi/rsi_91x_sdio.c:1455:57: error: 'struct wiphy' has no member named 'wowlan_config'
    1455 |                 if (rsi_config_wowlan(adapter, hw->wiphy->wowlan_config))
         |                                                         ^~
   cc1: some warnings being treated as errors


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

