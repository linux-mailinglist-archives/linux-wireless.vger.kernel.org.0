Return-Path: <linux-wireless+bounces-7573-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95BBE8C3A16
	for <lists+linux-wireless@lfdr.de>; Mon, 13 May 2024 04:15:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D99091F22B9D
	for <lists+linux-wireless@lfdr.de>; Mon, 13 May 2024 02:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FE6312BF38;
	Mon, 13 May 2024 02:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ayjDv5ct"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF194C9F;
	Mon, 13 May 2024 02:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715566511; cv=none; b=suIUIqc8MS7hteMCe8HlKgi5l80RVUkeavBsKQAtxiQEB/T0pdMXqUaGG1ktEXzxVhY5QvHRxvCJxNtEOVjxbGXvb93FdYOmTWZWggvmFFVjeEY658S0xgOArwYJwomsmnobjO7zybkSdc+JZ809WiK0GjbQszsn8xJrs9GO4ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715566511; c=relaxed/simple;
	bh=0VAOcaO47ViYN0bE4o2MNcHqcHxmHC8zeryv8HizuaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CnX1q/ZQE5sZnf2RgzXCw5L4GO0x+fWDuX21w/60zCVKLlHpBnYau5ZKjAYK81zZnTr8ljJMmGK6O5975IpnK4djZXM/8hG4ulpLnQ7y7eiaPM4Y3UVAaA+UJAOo0THco4aYyNz8THx/WgsMGcyH+lQJ6RNE6SyPvdojI2FqPWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ayjDv5ct; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715566510; x=1747102510;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0VAOcaO47ViYN0bE4o2MNcHqcHxmHC8zeryv8HizuaA=;
  b=ayjDv5ctxKLBgRhYKkQccXx9KgFlNYDWbep57w8+rglCtZNK5z8BG58d
   ldsxKXGj1wXdWnu1s8VAUbBqTCHuInTtItOzS50VdwCMAd4Hp2cLWqptd
   vT5V17uhqalC/k3f8q5jYW0837q8NcIGRbWJMlWU3wgAULrpwuygYJQh3
   NKxBNH43oc67v8WwV4dvpsc261kI1igylOmb6PZ/gmlseis2GOmue6iqI
   6KtybdUneKtHqU4F0wu5nfPKK7qEujASerAtr9CZdmEPvWN5aD8yP+ESA
   xoPYjR6tzehku+shsfI+pHw17epywuVQNaTLy25gucLRhgz3qtoKosQ2h
   A==;
X-CSE-ConnectionGUID: qvw5hd+VS5mmjOup73q5mA==
X-CSE-MsgGUID: VQclhbORTq6opQOMrmAkEQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11071"; a="11336591"
X-IronPort-AV: E=Sophos;i="6.08,157,1712646000"; 
   d="scan'208";a="11336591"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2024 19:15:09 -0700
X-CSE-ConnectionGUID: x+dHR9TqReyTglgKWezljw==
X-CSE-MsgGUID: ZJXzqTgfRGeK6QDn7kbW9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,157,1712646000"; 
   d="scan'208";a="34870413"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 12 May 2024 19:15:04 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s6LDR-0009P1-1Y;
	Mon, 13 May 2024 02:15:01 +0000
Date: Mon, 13 May 2024 10:14:57 +0800
From: kernel test robot <lkp@intel.com>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	gregkh@linuxfoundation.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	johannes@sipsolutions.net, philipp.g.hortmann@gmail.com,
	tdavies@darkphysics.net, garyrookard@fastmail.org,
	straube.linux@gmail.com
Cc: oe-kbuild-all@lists.linux.dev, linux-staging@lists.linux.dev,
	netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH 1/3] lib80211: Handle const struct lib80211_crypto_ops in
 lib80211
Message-ID: <202405130949.5EW85uAq-lkp@intel.com>
References: <d6306f7c76015653e9539ddbcd1ed74d1681a98f.1715443223.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6306f7c76015653e9539ddbcd1ed74d1681a98f.1715443223.git.christophe.jaillet@wanadoo.fr>

Hi Christophe,

kernel test robot noticed the following build warnings:

[auto build test WARNING on staging/staging-testing]
[also build test WARNING on staging/staging-next staging/staging-linus wireless-next/main wireless/main linus/master v6.9 next-20240510]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Christophe-JAILLET/lib80211-Handle-const-struct-lib80211_crypto_ops-in-lib80211/20240512-003642
base:   staging/staging-testing
patch link:    https://lore.kernel.org/r/d6306f7c76015653e9539ddbcd1ed74d1681a98f.1715443223.git.christophe.jaillet%40wanadoo.fr
patch subject: [PATCH 1/3] lib80211: Handle const struct lib80211_crypto_ops in lib80211
config: csky-randconfig-r132-20240513 (https://download.01.org/0day-ci/archive/20240513/202405130949.5EW85uAq-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20240513/202405130949.5EW85uAq-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405130949.5EW85uAq-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/net/wireless/intel/ipw2x00/libipw_wx.c:587:13: sparse: sparse: incorrect type in assignment (different modifiers) @@     expected struct lib80211_crypto_ops *ops @@     got struct lib80211_crypto_ops const * @@
   drivers/net/wireless/intel/ipw2x00/libipw_wx.c:587:13: sparse:     expected struct lib80211_crypto_ops *ops
   drivers/net/wireless/intel/ipw2x00/libipw_wx.c:587:13: sparse:     got struct lib80211_crypto_ops const *
   drivers/net/wireless/intel/ipw2x00/libipw_wx.c:590:21: sparse: sparse: incorrect type in assignment (different modifiers) @@     expected struct lib80211_crypto_ops *ops @@     got struct lib80211_crypto_ops const * @@
   drivers/net/wireless/intel/ipw2x00/libipw_wx.c:590:21: sparse:     expected struct lib80211_crypto_ops *ops
   drivers/net/wireless/intel/ipw2x00/libipw_wx.c:590:21: sparse:     got struct lib80211_crypto_ops const *

vim +587 drivers/net/wireless/intel/ipw2x00/libipw_wx.c

b453872c35cfcb net/ieee80211/ieee80211_wx.c                   Jeff Garzik        2005-05-12  501  
b0a4e7d8a291de drivers/net/wireless/ipw2x00/libipw_wx.c       John W. Linville   2009-08-20  502  int libipw_wx_set_encodeext(struct libipw_device *ieee,
e0d369d1d969fc net/ieee80211/ieee80211_wx.c                   James Ketrenos     2005-09-21  503  			       struct iw_request_info *info,
e0d369d1d969fc net/ieee80211/ieee80211_wx.c                   James Ketrenos     2005-09-21  504  			       union iwreq_data *wrqu, char *extra)
e0d369d1d969fc net/ieee80211/ieee80211_wx.c                   James Ketrenos     2005-09-21  505  {
e0d369d1d969fc net/ieee80211/ieee80211_wx.c                   James Ketrenos     2005-09-21  506  	struct net_device *dev = ieee->dev;
e0d369d1d969fc net/ieee80211/ieee80211_wx.c                   James Ketrenos     2005-09-21  507  	struct iw_point *encoding = &wrqu->encoding;
e0d369d1d969fc net/ieee80211/ieee80211_wx.c                   James Ketrenos     2005-09-21  508  	struct iw_encode_ext *ext = (struct iw_encode_ext *)extra;
e0d369d1d969fc net/ieee80211/ieee80211_wx.c                   James Ketrenos     2005-09-21  509  	int i, idx, ret = 0;
ccd0fda3a6d918 net/ieee80211/ieee80211_wx.c                   James Ketrenos     2005-09-21  510  	int group_key = 0;
e0d369d1d969fc net/ieee80211/ieee80211_wx.c                   James Ketrenos     2005-09-21  511  	const char *alg, *module;
274bfb8dc5ffa1 net/ieee80211/ieee80211_wx.c                   John W. Linville   2008-10-29  512  	struct lib80211_crypto_ops *ops;
274bfb8dc5ffa1 net/ieee80211/ieee80211_wx.c                   John W. Linville   2008-10-29  513  	struct lib80211_crypt_data **crypt;
e0d369d1d969fc net/ieee80211/ieee80211_wx.c                   James Ketrenos     2005-09-21  514  
b0a4e7d8a291de drivers/net/wireless/ipw2x00/libipw_wx.c       John W. Linville   2009-08-20  515  	struct libipw_security sec = {
e0d369d1d969fc net/ieee80211/ieee80211_wx.c                   James Ketrenos     2005-09-21  516  		.flags = 0,
e0d369d1d969fc net/ieee80211/ieee80211_wx.c                   James Ketrenos     2005-09-21  517  	};
e0d369d1d969fc net/ieee80211/ieee80211_wx.c                   James Ketrenos     2005-09-21  518  
e0d369d1d969fc net/ieee80211/ieee80211_wx.c                   James Ketrenos     2005-09-21  519  	idx = encoding->flags & IW_ENCODE_INDEX;
e0d369d1d969fc net/ieee80211/ieee80211_wx.c                   James Ketrenos     2005-09-21  520  	if (idx) {
e0d369d1d969fc net/ieee80211/ieee80211_wx.c                   James Ketrenos     2005-09-21  521  		if (idx < 1 || idx > WEP_KEYS)
e0d369d1d969fc net/ieee80211/ieee80211_wx.c                   James Ketrenos     2005-09-21  522  			return -EINVAL;
e0d369d1d969fc net/ieee80211/ieee80211_wx.c                   James Ketrenos     2005-09-21  523  		idx--;
e0d369d1d969fc net/ieee80211/ieee80211_wx.c                   James Ketrenos     2005-09-21  524  	} else
274bfb8dc5ffa1 net/ieee80211/ieee80211_wx.c                   John W. Linville   2008-10-29  525  		idx = ieee->crypt_info.tx_keyidx;
e0d369d1d969fc net/ieee80211/ieee80211_wx.c                   James Ketrenos     2005-09-21  526  
ccd0fda3a6d918 net/ieee80211/ieee80211_wx.c                   James Ketrenos     2005-09-21  527  	if (ext->ext_flags & IW_ENCODE_EXT_GROUP_KEY) {
274bfb8dc5ffa1 net/ieee80211/ieee80211_wx.c                   John W. Linville   2008-10-29  528  		crypt = &ieee->crypt_info.crypt[idx];
ccd0fda3a6d918 net/ieee80211/ieee80211_wx.c                   James Ketrenos     2005-09-21  529  		group_key = 1;
ccd0fda3a6d918 net/ieee80211/ieee80211_wx.c                   James Ketrenos     2005-09-21  530  	} else {
e189277a3f1cbb net/ieee80211/ieee80211_wx.c                   Volker Braun       2005-10-24  531  		/* some Cisco APs use idx>0 for unicast in dynamic WEP */
e189277a3f1cbb net/ieee80211/ieee80211_wx.c                   Volker Braun       2005-10-24  532  		if (idx != 0 && ext->alg != IW_ENCODE_ALG_WEP)
e0d369d1d969fc net/ieee80211/ieee80211_wx.c                   James Ketrenos     2005-09-21  533  			return -EINVAL;
e0d369d1d969fc net/ieee80211/ieee80211_wx.c                   James Ketrenos     2005-09-21  534  		if (ieee->iw_mode == IW_MODE_INFRA)
274bfb8dc5ffa1 net/ieee80211/ieee80211_wx.c                   John W. Linville   2008-10-29  535  			crypt = &ieee->crypt_info.crypt[idx];
e0d369d1d969fc net/ieee80211/ieee80211_wx.c                   James Ketrenos     2005-09-21  536  		else
e0d369d1d969fc net/ieee80211/ieee80211_wx.c                   James Ketrenos     2005-09-21  537  			return -EINVAL;
e0d369d1d969fc net/ieee80211/ieee80211_wx.c                   James Ketrenos     2005-09-21  538  	}
e0d369d1d969fc net/ieee80211/ieee80211_wx.c                   James Ketrenos     2005-09-21  539  
e0d369d1d969fc net/ieee80211/ieee80211_wx.c                   James Ketrenos     2005-09-21  540  	sec.flags |= SEC_ENABLED | SEC_ENCRYPT;
e0d369d1d969fc net/ieee80211/ieee80211_wx.c                   James Ketrenos     2005-09-21  541  	if ((encoding->flags & IW_ENCODE_DISABLED) ||
e0d369d1d969fc net/ieee80211/ieee80211_wx.c                   James Ketrenos     2005-09-21  542  	    ext->alg == IW_ENCODE_ALG_NONE) {
e0d369d1d969fc net/ieee80211/ieee80211_wx.c                   James Ketrenos     2005-09-21  543  		if (*crypt)
274bfb8dc5ffa1 net/ieee80211/ieee80211_wx.c                   John W. Linville   2008-10-29  544  			lib80211_crypt_delayed_deinit(&ieee->crypt_info, crypt);
e0d369d1d969fc net/ieee80211/ieee80211_wx.c                   James Ketrenos     2005-09-21  545  
e0d369d1d969fc net/ieee80211/ieee80211_wx.c                   James Ketrenos     2005-09-21  546  		for (i = 0; i < WEP_KEYS; i++)
274bfb8dc5ffa1 net/ieee80211/ieee80211_wx.c                   John W. Linville   2008-10-29  547  			if (ieee->crypt_info.crypt[i] != NULL)
e0d369d1d969fc net/ieee80211/ieee80211_wx.c                   James Ketrenos     2005-09-21  548  				break;
e0d369d1d969fc net/ieee80211/ieee80211_wx.c                   James Ketrenos     2005-09-21  549  
e0d369d1d969fc net/ieee80211/ieee80211_wx.c                   James Ketrenos     2005-09-21  550  		if (i == WEP_KEYS) {
e0d369d1d969fc net/ieee80211/ieee80211_wx.c                   James Ketrenos     2005-09-21  551  			sec.enabled = 0;
e0d369d1d969fc net/ieee80211/ieee80211_wx.c                   James Ketrenos     2005-09-21  552  			sec.encrypt = 0;
e0d369d1d969fc net/ieee80211/ieee80211_wx.c                   James Ketrenos     2005-09-21  553  			sec.level = SEC_LEVEL_0;
e0d369d1d969fc net/ieee80211/ieee80211_wx.c                   James Ketrenos     2005-09-21  554  			sec.flags |= SEC_LEVEL;
e0d369d1d969fc net/ieee80211/ieee80211_wx.c                   James Ketrenos     2005-09-21  555  		}
e0d369d1d969fc net/ieee80211/ieee80211_wx.c                   James Ketrenos     2005-09-21  556  		goto done;
e0d369d1d969fc net/ieee80211/ieee80211_wx.c                   James Ketrenos     2005-09-21  557  	}
e0d369d1d969fc net/ieee80211/ieee80211_wx.c                   James Ketrenos     2005-09-21  558  
e0d369d1d969fc net/ieee80211/ieee80211_wx.c                   James Ketrenos     2005-09-21  559  	sec.enabled = 1;
e0d369d1d969fc net/ieee80211/ieee80211_wx.c                   James Ketrenos     2005-09-21  560  	sec.encrypt = 1;
e0d369d1d969fc net/ieee80211/ieee80211_wx.c                   James Ketrenos     2005-09-21  561  
ccd0fda3a6d918 net/ieee80211/ieee80211_wx.c                   James Ketrenos     2005-09-21  562  	if (group_key ? !ieee->host_mc_decrypt :
ccd0fda3a6d918 net/ieee80211/ieee80211_wx.c                   James Ketrenos     2005-09-21  563  	    !(ieee->host_encrypt || ieee->host_decrypt ||
ccd0fda3a6d918 net/ieee80211/ieee80211_wx.c                   James Ketrenos     2005-09-21  564  	      ieee->host_encrypt_msdu))
e0d369d1d969fc net/ieee80211/ieee80211_wx.c                   James Ketrenos     2005-09-21  565  		goto skip_host_crypt;
e0d369d1d969fc net/ieee80211/ieee80211_wx.c                   James Ketrenos     2005-09-21  566  
e0d369d1d969fc net/ieee80211/ieee80211_wx.c                   James Ketrenos     2005-09-21  567  	switch (ext->alg) {
e0d369d1d969fc net/ieee80211/ieee80211_wx.c                   James Ketrenos     2005-09-21  568  	case IW_ENCODE_ALG_WEP:
e0d369d1d969fc net/ieee80211/ieee80211_wx.c                   James Ketrenos     2005-09-21  569  		alg = "WEP";
274bfb8dc5ffa1 net/ieee80211/ieee80211_wx.c                   John W. Linville   2008-10-29  570  		module = "lib80211_crypt_wep";
e0d369d1d969fc net/ieee80211/ieee80211_wx.c                   James Ketrenos     2005-09-21  571  		break;
e0d369d1d969fc net/ieee80211/ieee80211_wx.c                   James Ketrenos     2005-09-21  572  	case IW_ENCODE_ALG_TKIP:
e0d369d1d969fc net/ieee80211/ieee80211_wx.c                   James Ketrenos     2005-09-21  573  		alg = "TKIP";
274bfb8dc5ffa1 net/ieee80211/ieee80211_wx.c                   John W. Linville   2008-10-29  574  		module = "lib80211_crypt_tkip";
e0d369d1d969fc net/ieee80211/ieee80211_wx.c                   James Ketrenos     2005-09-21  575  		break;
e0d369d1d969fc net/ieee80211/ieee80211_wx.c                   James Ketrenos     2005-09-21  576  	case IW_ENCODE_ALG_CCMP:
e0d369d1d969fc net/ieee80211/ieee80211_wx.c                   James Ketrenos     2005-09-21  577  		alg = "CCMP";
274bfb8dc5ffa1 net/ieee80211/ieee80211_wx.c                   John W. Linville   2008-10-29  578  		module = "lib80211_crypt_ccmp";
e0d369d1d969fc net/ieee80211/ieee80211_wx.c                   James Ketrenos     2005-09-21  579  		break;
e0d369d1d969fc net/ieee80211/ieee80211_wx.c                   James Ketrenos     2005-09-21  580  	default:
b0a4e7d8a291de drivers/net/wireless/ipw2x00/libipw_wx.c       John W. Linville   2009-08-20  581  		LIBIPW_DEBUG_WX("%s: unknown crypto alg %d\n",
e0d369d1d969fc net/ieee80211/ieee80211_wx.c                   James Ketrenos     2005-09-21  582  				   dev->name, ext->alg);
e0d369d1d969fc net/ieee80211/ieee80211_wx.c                   James Ketrenos     2005-09-21  583  		ret = -EINVAL;
e0d369d1d969fc net/ieee80211/ieee80211_wx.c                   James Ketrenos     2005-09-21  584  		goto done;
e0d369d1d969fc net/ieee80211/ieee80211_wx.c                   James Ketrenos     2005-09-21  585  	}
e0d369d1d969fc net/ieee80211/ieee80211_wx.c                   James Ketrenos     2005-09-21  586  
274bfb8dc5ffa1 net/ieee80211/ieee80211_wx.c                   John W. Linville   2008-10-29 @587  	ops = lib80211_get_crypto_ops(alg);
e0d369d1d969fc net/ieee80211/ieee80211_wx.c                   James Ketrenos     2005-09-21  588  	if (ops == NULL) {
e0d369d1d969fc net/ieee80211/ieee80211_wx.c                   James Ketrenos     2005-09-21  589  		request_module(module);
274bfb8dc5ffa1 net/ieee80211/ieee80211_wx.c                   John W. Linville   2008-10-29  590  		ops = lib80211_get_crypto_ops(alg);
e0d369d1d969fc net/ieee80211/ieee80211_wx.c                   James Ketrenos     2005-09-21  591  	}
e0d369d1d969fc net/ieee80211/ieee80211_wx.c                   James Ketrenos     2005-09-21  592  	if (ops == NULL) {
b0a4e7d8a291de drivers/net/wireless/ipw2x00/libipw_wx.c       John W. Linville   2009-08-20  593  		LIBIPW_DEBUG_WX("%s: unknown crypto alg %d\n",
e0d369d1d969fc net/ieee80211/ieee80211_wx.c                   James Ketrenos     2005-09-21  594  				   dev->name, ext->alg);
e0d369d1d969fc net/ieee80211/ieee80211_wx.c                   James Ketrenos     2005-09-21  595  		ret = -EINVAL;
e0d369d1d969fc net/ieee80211/ieee80211_wx.c                   James Ketrenos     2005-09-21  596  		goto done;
e0d369d1d969fc net/ieee80211/ieee80211_wx.c                   James Ketrenos     2005-09-21  597  	}
e0d369d1d969fc net/ieee80211/ieee80211_wx.c                   James Ketrenos     2005-09-21  598  
e0d369d1d969fc net/ieee80211/ieee80211_wx.c                   James Ketrenos     2005-09-21  599  	if (*crypt == NULL || (*crypt)->ops != ops) {
274bfb8dc5ffa1 net/ieee80211/ieee80211_wx.c                   John W. Linville   2008-10-29  600  		struct lib80211_crypt_data *new_crypt;
e0d369d1d969fc net/ieee80211/ieee80211_wx.c                   James Ketrenos     2005-09-21  601  
274bfb8dc5ffa1 net/ieee80211/ieee80211_wx.c                   John W. Linville   2008-10-29  602  		lib80211_crypt_delayed_deinit(&ieee->crypt_info, crypt);
e0d369d1d969fc net/ieee80211/ieee80211_wx.c                   James Ketrenos     2005-09-21  603  
0da974f4f303a6 net/ieee80211/ieee80211_wx.c                   Panagiotis Issaris 2006-07-21  604  		new_crypt = kzalloc(sizeof(*new_crypt), GFP_KERNEL);
e0d369d1d969fc net/ieee80211/ieee80211_wx.c                   James Ketrenos     2005-09-21  605  		if (new_crypt == NULL) {
e0d369d1d969fc net/ieee80211/ieee80211_wx.c                   James Ketrenos     2005-09-21  606  			ret = -ENOMEM;
e0d369d1d969fc net/ieee80211/ieee80211_wx.c                   James Ketrenos     2005-09-21  607  			goto done;
e0d369d1d969fc net/ieee80211/ieee80211_wx.c                   James Ketrenos     2005-09-21  608  		}
e0d369d1d969fc net/ieee80211/ieee80211_wx.c                   James Ketrenos     2005-09-21  609  		new_crypt->ops = ops;
e0d369d1d969fc net/ieee80211/ieee80211_wx.c                   James Ketrenos     2005-09-21  610  		if (new_crypt->ops && try_module_get(new_crypt->ops->owner))
6eb6edf04acd09 net/ieee80211/ieee80211_wx.c                   James Ketrenos     2005-09-22  611  			new_crypt->priv = new_crypt->ops->init(idx);
e0d369d1d969fc net/ieee80211/ieee80211_wx.c                   James Ketrenos     2005-09-21  612  		if (new_crypt->priv == NULL) {
e0d369d1d969fc net/ieee80211/ieee80211_wx.c                   James Ketrenos     2005-09-21  613  			kfree(new_crypt);
e0d369d1d969fc net/ieee80211/ieee80211_wx.c                   James Ketrenos     2005-09-21  614  			ret = -EINVAL;
e0d369d1d969fc net/ieee80211/ieee80211_wx.c                   James Ketrenos     2005-09-21  615  			goto done;
e0d369d1d969fc net/ieee80211/ieee80211_wx.c                   James Ketrenos     2005-09-21  616  		}
e0d369d1d969fc net/ieee80211/ieee80211_wx.c                   James Ketrenos     2005-09-21  617  		*crypt = new_crypt;
e0d369d1d969fc net/ieee80211/ieee80211_wx.c                   James Ketrenos     2005-09-21  618  	}
e0d369d1d969fc net/ieee80211/ieee80211_wx.c                   James Ketrenos     2005-09-21  619  
e0d369d1d969fc net/ieee80211/ieee80211_wx.c                   James Ketrenos     2005-09-21  620  	if (ext->key_len > 0 && (*crypt)->ops->set_key &&
e0d369d1d969fc net/ieee80211/ieee80211_wx.c                   James Ketrenos     2005-09-21  621  	    (*crypt)->ops->set_key(ext->key, ext->key_len, ext->rx_seq,
e0d369d1d969fc net/ieee80211/ieee80211_wx.c                   James Ketrenos     2005-09-21  622  				   (*crypt)->priv) < 0) {
b0a4e7d8a291de drivers/net/wireless/ipw2x00/libipw_wx.c       John W. Linville   2009-08-20  623  		LIBIPW_DEBUG_WX("%s: key setting failed\n", dev->name);
e0d369d1d969fc net/ieee80211/ieee80211_wx.c                   James Ketrenos     2005-09-21  624  		ret = -EINVAL;
e0d369d1d969fc net/ieee80211/ieee80211_wx.c                   James Ketrenos     2005-09-21  625  		goto done;
e0d369d1d969fc net/ieee80211/ieee80211_wx.c                   James Ketrenos     2005-09-21  626  	}
e0d369d1d969fc net/ieee80211/ieee80211_wx.c                   James Ketrenos     2005-09-21  627  
e0d369d1d969fc net/ieee80211/ieee80211_wx.c                   James Ketrenos     2005-09-21  628        skip_host_crypt:
e0d369d1d969fc net/ieee80211/ieee80211_wx.c                   James Ketrenos     2005-09-21  629  	if (ext->ext_flags & IW_ENCODE_EXT_SET_TX_KEY) {
274bfb8dc5ffa1 net/ieee80211/ieee80211_wx.c                   John W. Linville   2008-10-29  630  		ieee->crypt_info.tx_keyidx = idx;
e0d369d1d969fc net/ieee80211/ieee80211_wx.c                   James Ketrenos     2005-09-21  631  		sec.active_key = idx;
e0d369d1d969fc net/ieee80211/ieee80211_wx.c                   James Ketrenos     2005-09-21  632  		sec.flags |= SEC_ACTIVE_KEY;
e0d369d1d969fc net/ieee80211/ieee80211_wx.c                   James Ketrenos     2005-09-21  633  	}
e0d369d1d969fc net/ieee80211/ieee80211_wx.c                   James Ketrenos     2005-09-21  634  
e0d369d1d969fc net/ieee80211/ieee80211_wx.c                   James Ketrenos     2005-09-21  635  	if (ext->alg != IW_ENCODE_ALG_NONE) {
260a9ad9446723 drivers/net/wireless/intel/ipw2x00/libipw_wx.c Dan Carpenter      2021-04-14  636  		int key_len = clamp_val(ext->key_len, 0, SCM_KEY_LEN);
260a9ad9446723 drivers/net/wireless/intel/ipw2x00/libipw_wx.c Dan Carpenter      2021-04-14  637  
260a9ad9446723 drivers/net/wireless/intel/ipw2x00/libipw_wx.c Dan Carpenter      2021-04-14  638  		memcpy(sec.keys[idx], ext->key, key_len);
260a9ad9446723 drivers/net/wireless/intel/ipw2x00/libipw_wx.c Dan Carpenter      2021-04-14  639  		sec.key_sizes[idx] = key_len;
e0d369d1d969fc net/ieee80211/ieee80211_wx.c                   James Ketrenos     2005-09-21  640  		sec.flags |= (1 << idx);
e0d369d1d969fc net/ieee80211/ieee80211_wx.c                   James Ketrenos     2005-09-21  641  		if (ext->alg == IW_ENCODE_ALG_WEP) {
e0d369d1d969fc net/ieee80211/ieee80211_wx.c                   James Ketrenos     2005-09-21  642  			sec.encode_alg[idx] = SEC_ALG_WEP;
e0d369d1d969fc net/ieee80211/ieee80211_wx.c                   James Ketrenos     2005-09-21  643  			sec.flags |= SEC_LEVEL;
e0d369d1d969fc net/ieee80211/ieee80211_wx.c                   James Ketrenos     2005-09-21  644  			sec.level = SEC_LEVEL_1;
e0d369d1d969fc net/ieee80211/ieee80211_wx.c                   James Ketrenos     2005-09-21  645  		} else if (ext->alg == IW_ENCODE_ALG_TKIP) {
e0d369d1d969fc net/ieee80211/ieee80211_wx.c                   James Ketrenos     2005-09-21  646  			sec.encode_alg[idx] = SEC_ALG_TKIP;
e0d369d1d969fc net/ieee80211/ieee80211_wx.c                   James Ketrenos     2005-09-21  647  			sec.flags |= SEC_LEVEL;
e0d369d1d969fc net/ieee80211/ieee80211_wx.c                   James Ketrenos     2005-09-21  648  			sec.level = SEC_LEVEL_2;
e0d369d1d969fc net/ieee80211/ieee80211_wx.c                   James Ketrenos     2005-09-21  649  		} else if (ext->alg == IW_ENCODE_ALG_CCMP) {
e0d369d1d969fc net/ieee80211/ieee80211_wx.c                   James Ketrenos     2005-09-21  650  			sec.encode_alg[idx] = SEC_ALG_CCMP;
e0d369d1d969fc net/ieee80211/ieee80211_wx.c                   James Ketrenos     2005-09-21  651  			sec.flags |= SEC_LEVEL;
e0d369d1d969fc net/ieee80211/ieee80211_wx.c                   James Ketrenos     2005-09-21  652  			sec.level = SEC_LEVEL_3;
e0d369d1d969fc net/ieee80211/ieee80211_wx.c                   James Ketrenos     2005-09-21  653  		}
ccd0fda3a6d918 net/ieee80211/ieee80211_wx.c                   James Ketrenos     2005-09-21  654  		/* Don't set sec level for group keys. */
ccd0fda3a6d918 net/ieee80211/ieee80211_wx.c                   James Ketrenos     2005-09-21  655  		if (group_key)
ccd0fda3a6d918 net/ieee80211/ieee80211_wx.c                   James Ketrenos     2005-09-21  656  			sec.flags &= ~SEC_LEVEL;
e0d369d1d969fc net/ieee80211/ieee80211_wx.c                   James Ketrenos     2005-09-21  657  	}
e0d369d1d969fc net/ieee80211/ieee80211_wx.c                   James Ketrenos     2005-09-21  658        done:
e0d369d1d969fc net/ieee80211/ieee80211_wx.c                   James Ketrenos     2005-09-21  659  	if (ieee->set_security)
3fc7bc8ea792b4 drivers/net/wireless/ipw2x00/libipw_wx.c       Paul Bolle         2012-09-21  660  		ieee->set_security(dev, &sec);
e0d369d1d969fc net/ieee80211/ieee80211_wx.c                   James Ketrenos     2005-09-21  661  
e0d369d1d969fc net/ieee80211/ieee80211_wx.c                   James Ketrenos     2005-09-21  662  	return ret;
e0d369d1d969fc net/ieee80211/ieee80211_wx.c                   James Ketrenos     2005-09-21  663  }
e0d369d1d969fc net/ieee80211/ieee80211_wx.c                   James Ketrenos     2005-09-21  664  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

