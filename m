Return-Path: <linux-wireless+bounces-13085-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD47897E8AE
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Sep 2024 11:29:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 841E41F20F16
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Sep 2024 09:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E14F319343C;
	Mon, 23 Sep 2024 09:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RO6GkOS7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE055194A48
	for <linux-wireless@vger.kernel.org>; Mon, 23 Sep 2024 09:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727083750; cv=none; b=lvj3VNI5cPrswfm0gow1eSmtRzd9rtCq87UoJXDpWdVHNooXH4R6QZfELxK6DOASwpHyxao3gYuySnNZdcQtMjmUL13IbMCtBvLjE5VLUznAOTHqZgBAR72LHmFVxThtUh2DIW4P/zpySpmrNBbir72ihahEB0QZhOIgMoU2fts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727083750; c=relaxed/simple;
	bh=Bk59W87LVlCacjN9E/LG78wZaPbF/uY6XmFf+lXdy7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lzd64OfAgFuoXN6UKBev5Si6Ha26+7DGOnxVSdv2vJ88FU/xEB9+JHQN7xb5eExCCURqxrj0ts6WqUc8wz/wjaQJHt/Q1FtgWI64r01JyNN1qRm+b8iJp87MxedOZqFjyIouWyW1oERhu1/mQBnm38rXht1RJJ0fT49HxS08PyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RO6GkOS7; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727083748; x=1758619748;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Bk59W87LVlCacjN9E/LG78wZaPbF/uY6XmFf+lXdy7c=;
  b=RO6GkOS7lRUq/B/tBF9vX7WcrxsVEQG/juf0flWCIZXsVL4WL12zCe7f
   TqNVoimseI4/PpKUcz9a4QyyIEfvIMQi8u2B9ptKYpFFzgVLUrpbwSD11
   0TCEesrJ0xn7I11MNYQsDmxJjR5xKB9ERP3Jw+B4gjk12FIyjF1LmkUU6
   nW8DqDg0Y4eCRq9WbFHRg7R9fBA6GawL/LIesEONpvcHk7qEbQ/FDcPDC
   BxkTXMhc243z3HQGkpCdnMhk+pRwUQa1VCbqeziSw/i5qZEwO5QTR7bQ1
   7aUiSF+o6r5TQpjGVVMaybDxTUdgaWXnnQo79xkceXDvmLBLm92cgTtpq
   w==;
X-CSE-ConnectionGUID: ncNTOkk3Sjuy9//fOEEtHA==
X-CSE-MsgGUID: bxgt1D8eQTWvPpIqWKHfuQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11202"; a="26176306"
X-IronPort-AV: E=Sophos;i="6.10,251,1719903600"; 
   d="scan'208";a="26176306"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2024 02:29:08 -0700
X-CSE-ConnectionGUID: DoMW2LYSR52TYrXcqpGd8Q==
X-CSE-MsgGUID: nq3kfNiSTNW5ixeU8AHArA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,251,1719903600"; 
   d="scan'208";a="70595878"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 23 Sep 2024 02:29:06 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ssfNQ-000H5O-0X;
	Mon, 23 Sep 2024 09:29:04 +0000
Date: Mon, 23 Sep 2024 17:28:50 +0800
From: kernel test robot <lkp@intel.com>
To: Arend van Spriel <arend.vanspriel@broadcom.com>,
	Kalle Valo <kvalo@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	Arend van Spriel <arend.vanspriel@broadcom.com>,
	Chung-Hsien Hsu <chung-hsien.hsu@infineon.com>,
	Chi-hsien Lin <chi-hsien.lin@infineon.com>
Subject: Re: [RFT v2 3/3] wifi: brcmfmac: cyw: support external SAE
 authentication in station mode
Message-ID: <202409231704.8hLEAwe6-lkp@intel.com>
References: <20240918191109.41960-4-arend.vanspriel@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240918191109.41960-4-arend.vanspriel@broadcom.com>

Hi Arend,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 5a4d42c1688c88f3be6aef46b0ea6c32694cd2b8]

url:    https://github.com/intel-lab-lkp/linux/commits/Arend-van-Spriel/wifi-brcmfmac-support-per-vendor-cfg80211-callbacks-and-firmware-events/20240919-031359
base:   5a4d42c1688c88f3be6aef46b0ea6c32694cd2b8
patch link:    https://lore.kernel.org/r/20240918191109.41960-4-arend.vanspriel%40broadcom.com
patch subject: [RFT v2 3/3] wifi: brcmfmac: cyw: support external SAE authentication in station mode
config: i386-randconfig-r132-20240922 (https://download.01.org/0day-ci/archive/20240923/202409231704.8hLEAwe6-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240923/202409231704.8hLEAwe6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409231704.8hLEAwe6-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c:152:28: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [usertype] channel @@     got restricted __le32 [usertype] @@
   drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c:152:28: sparse:     expected restricted __le16 [usertype] channel
   drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c:152:28: sparse:     got restricted __le32 [usertype]
   drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c:159:9: sparse: sparse: cast to restricted __le32
   drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c:159:9: sparse: sparse: cast from restricted __le16
>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c:217:9: sparse: sparse: incorrect type in argument 3 (different base types) @@     expected unsigned int @@     got restricted __le32 [addressable] [assigned] [usertype] ssid_len @@
   drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c:217:9: sparse:     expected unsigned int
   drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c:217:9: sparse:     got restricted __le32 [addressable] [assigned] [usertype] ssid_len
   drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c:254:33: sparse: sparse: cast to restricted __be32

vim +217 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c

   192	
   193	static int
   194	brcmf_cyw_external_auth(struct wiphy *wiphy, struct net_device *dev,
   195				struct cfg80211_external_auth_params *params)
   196	{
   197		struct brcmf_if *ifp;
   198		struct brcmf_pub *drvr;
   199		struct brcmf_auth_req_status_le auth_status;
   200		int ret = 0;
   201	
   202		brcmf_dbg(TRACE, "Enter\n");
   203	
   204		ifp = netdev_priv(dev);
   205		drvr = ifp->drvr;
   206		if (params->status == WLAN_STATUS_SUCCESS) {
   207			auth_status.flags = cpu_to_le16(BRCMF_EXTAUTH_SUCCESS);
   208		} else {
   209			bphy_err(drvr, "External authentication failed: status=%d\n",
   210				 params->status);
   211			auth_status.flags = cpu_to_le16(BRCMF_EXTAUTH_FAIL);
   212		}
   213	
   214		memcpy(auth_status.peer_mac, params->bssid, ETH_ALEN);
   215		auth_status.ssid_len = cpu_to_le32(min_t(u8, params->ssid.ssid_len,
   216							 IEEE80211_MAX_SSID_LEN));
 > 217		memcpy(auth_status.ssid, params->ssid.ssid, auth_status.ssid_len);
   218	
   219		ret = brcmf_fil_iovar_data_set(ifp, "auth_status", &auth_status,
   220					       sizeof(auth_status));
   221		if (ret < 0)
   222			bphy_err(drvr, "auth_status iovar failed: ret=%d\n", ret);
   223	
   224		return ret;
   225	}
   226	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

