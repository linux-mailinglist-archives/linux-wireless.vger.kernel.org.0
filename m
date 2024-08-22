Return-Path: <linux-wireless+bounces-11816-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E46395C192
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Aug 2024 01:39:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EFF91C220C0
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Aug 2024 23:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D7E2183CCC;
	Thu, 22 Aug 2024 23:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dTr6QtTJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF6C1836ED;
	Thu, 22 Aug 2024 23:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724369952; cv=none; b=oDshj+9mMT8AFco6B8UdMZVR3xVPe9wmoTrlaeqmA0Vzl8oMz+56NwCnEyiz/+ukODbTLUbekJaiFBnFAiUBViVjf5DMJO6DLRkJNJgaFJoRF6MyJe/cZ2P1fc79Ubz+dqVfbz+BB2xrsikfggeozHRLEnFlDku/8N16swN0Q6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724369952; c=relaxed/simple;
	bh=sIxFb7phyP103k8jvVNt3nWalzWNNxGUURuGx6otySo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bfET+94fTFQ4RJSfTvZyxTI3APvbpHA8XTdg5b27VjyncuHDScGRLtK0k7ykEIvalX32V9ypV6CrnTXcr9RguxZ5lJXbjECwD/TdQesAFnyJTeQxDWQ6V7QHpnhdKsQ0pBwup+QhjPJaV+yvpeOzUvEsNTQAGBXyuWp0KiK6DwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dTr6QtTJ; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724369951; x=1755905951;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sIxFb7phyP103k8jvVNt3nWalzWNNxGUURuGx6otySo=;
  b=dTr6QtTJpvbvY8aCjhUrS+twfXjAOV4yNQosPtteq5cmGyBk6OFUGw5N
   igDIZ3Nj/59dj/RgHR8+vc1J1m2eeqNs+IFp3pK1RYdTWQO29kgsJxH4D
   hRAzxAsvghKtL4I05X/1RflW3MzYFfs3/M7dPbKzyA9X3530KXL+Fklnc
   Dl2TeurGS8PNPBPmOYEXxitYkq7SPVdityIbpkupm0whL1+6Cd7jHhEKo
   TEZMngz76V3CxoOF3Za+ODLux8jAGdwFzykDMtoOdT0jcrQ2EVbrzy8A/
   GqfWqNtuBz9Nvj/yT9E4kLEWzgvZM7hDrLKlhaA5PHOxFwhNmT/MHjDae
   w==;
X-CSE-ConnectionGUID: KwGbPLUdS/aAmCheH3VogQ==
X-CSE-MsgGUID: 9snuZTVoTXuR0gzL3GOiyQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11172"; a="26614760"
X-IronPort-AV: E=Sophos;i="6.10,168,1719903600"; 
   d="scan'208";a="26614760"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2024 16:39:10 -0700
X-CSE-ConnectionGUID: JHK45ctpRkmr+OFgl6kk8Q==
X-CSE-MsgGUID: YUquk5AoR1SIs2CQNrtZhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,168,1719903600"; 
   d="scan'208";a="61757259"
Received: from lkp-server01.sh.intel.com (HELO 9a732dc145d3) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 22 Aug 2024 16:39:07 -0700
Received: from kbuild by 9a732dc145d3 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1shHOT-000DI0-0b;
	Thu, 22 Aug 2024 23:39:05 +0000
Date: Fri, 23 Aug 2024 07:38:28 +0800
From: kernel test robot <lkp@intel.com>
To: Sascha Hauer <s.hauer@pengutronix.de>,
	Brian Norris <briannorris@chromium.org>,
	Francesco Dolcini <francesco@dolcini.it>,
	Kalle Valo <kvalo@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel@pengutronix.de,
	Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH 11/31] wifi: mwifiex: use priv index as bss_num
Message-ID: <202408230753.OZVsdQpL-lkp@intel.com>
References: <20240820-mwifiex-cleanup-v1-11-320d8de4a4b7@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240820-mwifiex-cleanup-v1-11-320d8de4a4b7@pengutronix.de>

Hi Sascha,

kernel test robot noticed the following build warnings:

[auto build test WARNING on daaf0dd0398d5e93b7304f35184ca182ed583681]

url:    https://github.com/intel-lab-lkp/linux/commits/Sascha-Hauer/wifi-mwifiex-remove-unnecessary-checks-for-valid-priv/20240820-200559
base:   daaf0dd0398d5e93b7304f35184ca182ed583681
patch link:    https://lore.kernel.org/r/20240820-mwifiex-cleanup-v1-11-320d8de4a4b7%40pengutronix.de
patch subject: [PATCH 11/31] wifi: mwifiex: use priv index as bss_num
config: arc-allmodconfig (https://download.01.org/0day-ci/archive/20240823/202408230753.OZVsdQpL-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240823/202408230753.OZVsdQpL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408230753.OZVsdQpL-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/net/wireless/marvell/mwifiex/sta_event.c: In function 'mwifiex_process_multi_chan_event':
>> drivers/net/wireless/marvell/mwifiex/sta_event.c:419:23: warning: variable 'bss_type' set but not used [-Wunused-but-set-variable]
     419 |         int intf_num, bss_type, bss_num, i;
         |                       ^~~~~~~~


vim +/bss_type +419 drivers/net/wireless/marvell/mwifiex/sta_event.c

ddd7ceb3f6dd90 drivers/net/wireless/mwifiex/sta_event.c         Avinash Patil 2015-06-22  410  
8d6b538a5eac1f drivers/net/wireless/mwifiex/sta_event.c         Avinash Patil 2015-06-22  411  void mwifiex_process_multi_chan_event(struct mwifiex_private *priv,
8d6b538a5eac1f drivers/net/wireless/mwifiex/sta_event.c         Avinash Patil 2015-06-22  412  				      struct sk_buff *event_skb)
8d6b538a5eac1f drivers/net/wireless/mwifiex/sta_event.c         Avinash Patil 2015-06-22  413  {
8d6b538a5eac1f drivers/net/wireless/mwifiex/sta_event.c         Avinash Patil 2015-06-22  414  	struct mwifiex_ie_types_multi_chan_info *chan_info;
2b0f997db43f01 drivers/net/wireless/mwifiex/sta_event.c         Zhaoyang Liu  2015-09-18  415  	struct mwifiex_ie_types_mc_group_info *grp_info;
2b0f997db43f01 drivers/net/wireless/mwifiex/sta_event.c         Zhaoyang Liu  2015-09-18  416  	struct mwifiex_adapter *adapter = priv->adapter;
2b0f997db43f01 drivers/net/wireless/mwifiex/sta_event.c         Zhaoyang Liu  2015-09-18  417  	struct mwifiex_ie_types_header *tlv;
2b0f997db43f01 drivers/net/wireless/mwifiex/sta_event.c         Zhaoyang Liu  2015-09-18  418  	u16 tlv_buf_left, tlv_type, tlv_len;
2b0f997db43f01 drivers/net/wireless/mwifiex/sta_event.c         Zhaoyang Liu  2015-09-18 @419  	int intf_num, bss_type, bss_num, i;
2b0f997db43f01 drivers/net/wireless/mwifiex/sta_event.c         Zhaoyang Liu  2015-09-18  420  	struct mwifiex_private *intf_priv;
8d6b538a5eac1f drivers/net/wireless/mwifiex/sta_event.c         Avinash Patil 2015-06-22  421  
2b0f997db43f01 drivers/net/wireless/mwifiex/sta_event.c         Zhaoyang Liu  2015-09-18  422  	tlv_buf_left = event_skb->len - sizeof(u32);
8d6b538a5eac1f drivers/net/wireless/mwifiex/sta_event.c         Avinash Patil 2015-06-22  423  	chan_info = (void *)event_skb->data + sizeof(u32);
8d6b538a5eac1f drivers/net/wireless/mwifiex/sta_event.c         Avinash Patil 2015-06-22  424  
2b0f997db43f01 drivers/net/wireless/mwifiex/sta_event.c         Zhaoyang Liu  2015-09-18  425  	if (le16_to_cpu(chan_info->header.type) != TLV_TYPE_MULTI_CHAN_INFO ||
2b0f997db43f01 drivers/net/wireless/mwifiex/sta_event.c         Zhaoyang Liu  2015-09-18  426  	    tlv_buf_left < sizeof(struct mwifiex_ie_types_multi_chan_info)) {
2b0f997db43f01 drivers/net/wireless/mwifiex/sta_event.c         Zhaoyang Liu  2015-09-18  427  		mwifiex_dbg(adapter, ERROR,
8d6b538a5eac1f drivers/net/wireless/mwifiex/sta_event.c         Avinash Patil 2015-06-22  428  			    "unknown TLV in chan_info event\n");
8d6b538a5eac1f drivers/net/wireless/mwifiex/sta_event.c         Avinash Patil 2015-06-22  429  		return;
8d6b538a5eac1f drivers/net/wireless/mwifiex/sta_event.c         Avinash Patil 2015-06-22  430  	}
8d6b538a5eac1f drivers/net/wireless/mwifiex/sta_event.c         Avinash Patil 2015-06-22  431  
2b0f997db43f01 drivers/net/wireless/mwifiex/sta_event.c         Zhaoyang Liu  2015-09-18  432  	adapter->usb_mc_status = le16_to_cpu(chan_info->status);
2b0f997db43f01 drivers/net/wireless/mwifiex/sta_event.c         Zhaoyang Liu  2015-09-18  433  	mwifiex_dbg(adapter, EVENT, "multi chan operation %s\n",
2b0f997db43f01 drivers/net/wireless/mwifiex/sta_event.c         Zhaoyang Liu  2015-09-18  434  		    adapter->usb_mc_status ? "started" : "over");
8d6b538a5eac1f drivers/net/wireless/mwifiex/sta_event.c         Avinash Patil 2015-06-22  435  
2b0f997db43f01 drivers/net/wireless/mwifiex/sta_event.c         Zhaoyang Liu  2015-09-18  436  	tlv_buf_left -= sizeof(struct mwifiex_ie_types_multi_chan_info);
2b0f997db43f01 drivers/net/wireless/mwifiex/sta_event.c         Zhaoyang Liu  2015-09-18  437  	tlv = (struct mwifiex_ie_types_header *)chan_info->tlv_buffer;
2b0f997db43f01 drivers/net/wireless/mwifiex/sta_event.c         Zhaoyang Liu  2015-09-18  438  
2b0f997db43f01 drivers/net/wireless/mwifiex/sta_event.c         Zhaoyang Liu  2015-09-18  439  	while (tlv_buf_left >= (int)sizeof(struct mwifiex_ie_types_header)) {
2b0f997db43f01 drivers/net/wireless/mwifiex/sta_event.c         Zhaoyang Liu  2015-09-18  440  		tlv_type = le16_to_cpu(tlv->type);
2b0f997db43f01 drivers/net/wireless/mwifiex/sta_event.c         Zhaoyang Liu  2015-09-18  441  		tlv_len  = le16_to_cpu(tlv->len);
2b0f997db43f01 drivers/net/wireless/mwifiex/sta_event.c         Zhaoyang Liu  2015-09-18  442  		if ((sizeof(struct mwifiex_ie_types_header) + tlv_len) >
2b0f997db43f01 drivers/net/wireless/mwifiex/sta_event.c         Zhaoyang Liu  2015-09-18  443  		    tlv_buf_left) {
2b0f997db43f01 drivers/net/wireless/mwifiex/sta_event.c         Zhaoyang Liu  2015-09-18  444  			mwifiex_dbg(adapter, ERROR, "wrong tlv: tlvLen=%d,\t"
2b0f997db43f01 drivers/net/wireless/mwifiex/sta_event.c         Zhaoyang Liu  2015-09-18  445  				    "tlvBufLeft=%d\n", tlv_len, tlv_buf_left);
2b0f997db43f01 drivers/net/wireless/mwifiex/sta_event.c         Zhaoyang Liu  2015-09-18  446  			break;
2b0f997db43f01 drivers/net/wireless/mwifiex/sta_event.c         Zhaoyang Liu  2015-09-18  447  		}
2b0f997db43f01 drivers/net/wireless/mwifiex/sta_event.c         Zhaoyang Liu  2015-09-18  448  		if (tlv_type != TLV_TYPE_MC_GROUP_INFO) {
2b0f997db43f01 drivers/net/wireless/mwifiex/sta_event.c         Zhaoyang Liu  2015-09-18  449  			mwifiex_dbg(adapter, ERROR, "wrong tlv type: 0x%x\n",
2b0f997db43f01 drivers/net/wireless/mwifiex/sta_event.c         Zhaoyang Liu  2015-09-18  450  				    tlv_type);
2b0f997db43f01 drivers/net/wireless/mwifiex/sta_event.c         Zhaoyang Liu  2015-09-18  451  			break;
2b0f997db43f01 drivers/net/wireless/mwifiex/sta_event.c         Zhaoyang Liu  2015-09-18  452  		}
2b0f997db43f01 drivers/net/wireless/mwifiex/sta_event.c         Zhaoyang Liu  2015-09-18  453  
2b0f997db43f01 drivers/net/wireless/mwifiex/sta_event.c         Zhaoyang Liu  2015-09-18  454  		grp_info = (struct mwifiex_ie_types_mc_group_info *)tlv;
2b0f997db43f01 drivers/net/wireless/mwifiex/sta_event.c         Zhaoyang Liu  2015-09-18  455  		intf_num = grp_info->intf_num;
2b0f997db43f01 drivers/net/wireless/mwifiex/sta_event.c         Zhaoyang Liu  2015-09-18  456  		for (i = 0; i < intf_num; i++) {
2b0f997db43f01 drivers/net/wireless/mwifiex/sta_event.c         Zhaoyang Liu  2015-09-18  457  			bss_type = grp_info->bss_type_numlist[i] >> 4;
2b0f997db43f01 drivers/net/wireless/mwifiex/sta_event.c         Zhaoyang Liu  2015-09-18  458  			bss_num = grp_info->bss_type_numlist[i] & BSS_NUM_MASK;
92ace9c7fa9726 drivers/net/wireless/marvell/mwifiex/sta_event.c Sascha Hauer  2024-08-20  459  			intf_priv = mwifiex_get_priv_by_id(adapter, bss_num);
2b0f997db43f01 drivers/net/wireless/mwifiex/sta_event.c         Zhaoyang Liu  2015-09-18  460  			if (!intf_priv) {
2b0f997db43f01 drivers/net/wireless/mwifiex/sta_event.c         Zhaoyang Liu  2015-09-18  461  				mwifiex_dbg(adapter, ERROR,
2b0f997db43f01 drivers/net/wireless/mwifiex/sta_event.c         Zhaoyang Liu  2015-09-18  462  					    "Invalid bss_type bss_num\t"
2b0f997db43f01 drivers/net/wireless/mwifiex/sta_event.c         Zhaoyang Liu  2015-09-18  463  					    "in multi channel event\n");
2b0f997db43f01 drivers/net/wireless/mwifiex/sta_event.c         Zhaoyang Liu  2015-09-18  464  				continue;
8d6b538a5eac1f drivers/net/wireless/mwifiex/sta_event.c         Avinash Patil 2015-06-22  465  			}
2b0f997db43f01 drivers/net/wireless/mwifiex/sta_event.c         Zhaoyang Liu  2015-09-18  466  			if (adapter->iface_type == MWIFIEX_USB) {
2b0f997db43f01 drivers/net/wireless/mwifiex/sta_event.c         Zhaoyang Liu  2015-09-18  467  				u8 ep;
2b0f997db43f01 drivers/net/wireless/mwifiex/sta_event.c         Zhaoyang Liu  2015-09-18  468  
2b0f997db43f01 drivers/net/wireless/mwifiex/sta_event.c         Zhaoyang Liu  2015-09-18  469  				ep = grp_info->hid_num.usb_ep_num;
2b0f997db43f01 drivers/net/wireless/mwifiex/sta_event.c         Zhaoyang Liu  2015-09-18  470  				if (ep == MWIFIEX_USB_EP_DATA ||
2b0f997db43f01 drivers/net/wireless/mwifiex/sta_event.c         Zhaoyang Liu  2015-09-18  471  				    ep == MWIFIEX_USB_EP_DATA_CH2)
2b0f997db43f01 drivers/net/wireless/mwifiex/sta_event.c         Zhaoyang Liu  2015-09-18  472  					intf_priv->usb_port = ep;
2b0f997db43f01 drivers/net/wireless/mwifiex/sta_event.c         Zhaoyang Liu  2015-09-18  473  			}
2b0f997db43f01 drivers/net/wireless/mwifiex/sta_event.c         Zhaoyang Liu  2015-09-18  474  		}
2b0f997db43f01 drivers/net/wireless/mwifiex/sta_event.c         Zhaoyang Liu  2015-09-18  475  
2b0f997db43f01 drivers/net/wireless/mwifiex/sta_event.c         Zhaoyang Liu  2015-09-18  476  		tlv_buf_left -= sizeof(struct mwifiex_ie_types_header) +
2b0f997db43f01 drivers/net/wireless/mwifiex/sta_event.c         Zhaoyang Liu  2015-09-18  477  				tlv_len;
2b0f997db43f01 drivers/net/wireless/mwifiex/sta_event.c         Zhaoyang Liu  2015-09-18  478  		tlv = (void *)((u8 *)tlv + tlv_len +
2b0f997db43f01 drivers/net/wireless/mwifiex/sta_event.c         Zhaoyang Liu  2015-09-18  479  			       sizeof(struct mwifiex_ie_types_header));
2b0f997db43f01 drivers/net/wireless/mwifiex/sta_event.c         Zhaoyang Liu  2015-09-18  480  	}
2b0f997db43f01 drivers/net/wireless/mwifiex/sta_event.c         Zhaoyang Liu  2015-09-18  481  
7e4e5d2cd0817b drivers/net/wireless/mwifiex/sta_event.c         Zhaoyang Liu  2015-09-18  482  	if (adapter->iface_type == MWIFIEX_USB) {
7e4e5d2cd0817b drivers/net/wireless/mwifiex/sta_event.c         Zhaoyang Liu  2015-09-18  483  		adapter->tx_lock_flag = true;
7e4e5d2cd0817b drivers/net/wireless/mwifiex/sta_event.c         Zhaoyang Liu  2015-09-18  484  		adapter->usb_mc_setup = true;
7e4e5d2cd0817b drivers/net/wireless/mwifiex/sta_event.c         Zhaoyang Liu  2015-09-18  485  		mwifiex_multi_chan_resync(adapter);
7e4e5d2cd0817b drivers/net/wireless/mwifiex/sta_event.c         Zhaoyang Liu  2015-09-18  486  	}
8d6b538a5eac1f drivers/net/wireless/mwifiex/sta_event.c         Avinash Patil 2015-06-22  487  }
8d6b538a5eac1f drivers/net/wireless/mwifiex/sta_event.c         Avinash Patil 2015-06-22  488  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

