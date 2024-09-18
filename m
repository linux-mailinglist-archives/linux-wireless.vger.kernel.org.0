Return-Path: <linux-wireless+bounces-12934-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A1B697B891
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Sep 2024 09:32:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09628B2266C
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Sep 2024 07:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76B3113792B;
	Wed, 18 Sep 2024 07:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sk9L93Lq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C67481AB
	for <linux-wireless@vger.kernel.org>; Wed, 18 Sep 2024 07:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726644726; cv=none; b=Vp68SJ8Z14//zAwP5eFVjWefJMVYSrk/UEqBE3eSOoNJRHNb+QmYrHKinCTdbm9SzsWkbnr0MzS1kAGt4wR1w2rGi5X9VgfC30MfLcy+HNK0ghrxmRISDilkRBw86BjBhgnoFTDsrSYwG/z8m0sBNWswdpZ0BrrcnbLlHXUM+Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726644726; c=relaxed/simple;
	bh=SOw9R90Sl/sSnltxJAdxMkI/Qf3vTl9cFFj/gFAsxZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HM6hstf2qdGWnKfF8u0AJ8AIONsYGAnBka9HQUUP9tl8wF74YYMCl91rxpoHqhwTkS3r4yFdkluLbH/ChPMHrXmlSXczQfLH1501kEHkomfmGDLjoaSZAzEhrHp/Ju0hn/3SAkishW7fy4hvbJwRxv9kSjjC0tR2R/m7jJ5PHJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Sk9L93Lq; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726644724; x=1758180724;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SOw9R90Sl/sSnltxJAdxMkI/Qf3vTl9cFFj/gFAsxZc=;
  b=Sk9L93LqGuh6YpVI3M1yFTltVQ+3aveKUnRiVMABeWnPHveS3arneMaO
   y5fAf6aY5grlkPVmvx8DWoJYjDJ38QIuAg+0xlL2asHTXoqjabMnIaR5f
   KBfXU/BCub/F8ayIwafB9guNJjD4SM08rZTPAolmgZJVXdKwzdIcqUdd5
   h5Zl8Qbs6iEHkukUaMJJFnKqqQEnYLAin1hWIgTik2l2tryw3tOGIINah
   xGnPhcnQfoHkAIr9F5Ji0EJBnzgMQf1CHhauIbJl3dk5ucJUtspWdUCvm
   5tLO+pyR2WIFYqCKLsMnEF2eGV0o/Utf51GI8aaP3V6tNOP+8QGndnGtV
   g==;
X-CSE-ConnectionGUID: 2ngL/xb4TUSkhu3k7uJIdw==
X-CSE-MsgGUID: m7a2cTZnQF27WR6KSKrlUQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11198"; a="25358525"
X-IronPort-AV: E=Sophos;i="6.10,238,1719903600"; 
   d="scan'208";a="25358525"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2024 00:32:03 -0700
X-CSE-ConnectionGUID: rkQDapKVThalQz0Tr/P90Q==
X-CSE-MsgGUID: tuNs6n35QOKVvQrkEup22Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,238,1719903600"; 
   d="scan'208";a="73805449"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 18 Sep 2024 00:32:01 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sqpAN-000Bz2-1O;
	Wed, 18 Sep 2024 07:31:59 +0000
Date: Wed, 18 Sep 2024 15:31:29 +0800
From: kernel test robot <lkp@intel.com>
To: Arend van Spriel <arend.vanspriel@broadcom.com>,
	Kalle Valo <kvalo@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	Arend van Spriel <arend.vanspriel@broadcom.com>,
	Chung-Hsien Hsu <chung-hsien.hsu@infineon.com>,
	Chi-hsien Lin <chi-hsien.lin@infineon.com>
Subject: Re: [RFT 3/3] wifi: brcmfmac: cyw: support external SAE
 authentication in station mode
Message-ID: <202409181714.QfWaGA1c-lkp@intel.com>
References: <20240915140049.181380-4-arend.vanspriel@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240915140049.181380-4-arend.vanspriel@broadcom.com>

Hi Arend,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 34c44eb31de9cb7202ff070900463d6c706392c4]

url:    https://github.com/intel-lab-lkp/linux/commits/Arend-van-Spriel/wifi-brcmfmac-support-per-vendor-cfg80211-callbacks-and-firmware-events/20240915-220310
base:   34c44eb31de9cb7202ff070900463d6c706392c4
patch link:    https://lore.kernel.org/r/20240915140049.181380-4-arend.vanspriel%40broadcom.com
patch subject: [RFT 3/3] wifi: brcmfmac: cyw: support external SAE authentication in station mode
config: i386-allmodconfig (https://download.01.org/0day-ci/archive/20240918/202409181714.QfWaGA1c-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240918/202409181714.QfWaGA1c-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409181714.QfWaGA1c-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c: In function 'brcmf_cyw_mgmt_tx':
>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c:118:13: warning: variable 'timeout' set but not used [-Wunused-but-set-variable]
     118 |         s32 timeout;
         |             ^~~~~~~
   drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c: At top level:
>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c:52:42: warning: 'brcmf_cyw_event_map' defined but not used [-Wunused-const-variable=]
      52 | static const struct brcmf_fweh_event_map brcmf_cyw_event_map = {
         |                                          ^~~~~~~~~~~~~~~~~~~


vim +/timeout +118 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c

    51	
  > 52	static const struct brcmf_fweh_event_map brcmf_cyw_event_map = {
    53		.items = {
    54			{ BRCMF_E_EXT_AUTH_REQ, BRCMF_CYW_E_EXT_AUTH_REQ },
    55			{ BRCMF_E_EXT_AUTH_FRAME_RX, BRCMF_CYW_E_EXT_AUTH_FRAME_RX },
    56			{ BRCMF_E_MGMT_FRAME_TXSTATUS, BRCMF_CYW_E_MGMT_FRAME_TXS },
    57			{
    58				BRCMF_E_MGMT_FRAME_OFFCHAN_DONE,
    59				BRCMF_CYW_E_MGMT_FRAME_TXS_OC
    60			},
    61		},
    62		.n_items = 1
    63	};
    64	
    65	static int brcmf_cyw_alloc_fweh_info(struct brcmf_pub *drvr)
    66	{
    67		struct brcmf_fweh_info *fweh;
    68	
    69		fweh = kzalloc(struct_size(fweh, evt_handler, BRCMF_CYW_E_LAST),
    70			       GFP_KERNEL);
    71		if (!fweh)
    72			return -ENOMEM;
    73	
    74		fweh->num_event_codes = BRCMF_CYW_E_LAST;
    75		drvr->fweh = fweh;
    76		return 0;
    77	}
    78	
    79	static int brcmf_cyw_activate_events(struct brcmf_if *ifp)
    80	{
    81		struct brcmf_fweh_info *fweh = ifp->drvr->fweh;
    82		struct brcmf_eventmsgs_ext *eventmask_msg;
    83		u32 msglen;
    84		int err;
    85	
    86		msglen = sizeof(*eventmask_msg) + fweh->event_mask_len;
    87		eventmask_msg = kzalloc(msglen, GFP_KERNEL);
    88		if (!eventmask_msg)
    89			return -ENOMEM;
    90		eventmask_msg->ver = EVENTMSGS_VER;
    91		eventmask_msg->command = CYW_EVENTMSGS_SET_MASK;
    92		eventmask_msg->len = fweh->event_mask_len;
    93		memcpy(eventmask_msg->mask, fweh->event_mask, fweh->event_mask_len);
    94	
    95		err = brcmf_fil_iovar_data_set(ifp, "event_msgs_ext", eventmask_msg,
    96					       msglen);
    97		kfree(eventmask_msg);
    98		return err;
    99	}
   100	
   101	static
   102	int brcmf_cyw_mgmt_tx(struct wiphy *wiphy, struct wireless_dev *wdev,
   103			      struct cfg80211_mgmt_tx_params *params, u64 *cookie)
   104	{
   105		struct brcmf_cfg80211_info *cfg = wiphy_to_cfg(wiphy);
   106		struct ieee80211_channel *chan = params->chan;
   107		struct brcmf_pub *drvr = cfg->pub;
   108		const u8 *buf = params->buf;
   109		size_t len = params->len;
   110		const struct ieee80211_mgmt *mgmt;
   111		struct brcmf_cfg80211_vif *vif;
   112		s32 err = 0;
   113		bool ack = false;
   114		s32 chan_nr;
   115		u32 freq;
   116		struct brcmf_mf_params_le *mf_params;
   117		u32 mf_params_len;
 > 118		s32 timeout;
   119	
   120		brcmf_dbg(TRACE, "Enter\n");
   121	
   122		mgmt = (const struct ieee80211_mgmt *)buf;
   123	
   124		if (!ieee80211_is_auth(mgmt->frame_control))
   125			return brcmf_cfg80211_mgmt_tx(wiphy, wdev, params, cookie);
   126	
   127		*cookie = 0;
   128		vif = container_of(wdev, struct brcmf_cfg80211_vif, wdev);
   129	
   130		reinit_completion(&vif->mgmt_tx);
   131		clear_bit(BRCMF_MGMT_TX_ACK, &vif->mgmt_tx_status);
   132		clear_bit(BRCMF_MGMT_TX_NOACK, &vif->mgmt_tx_status);
   133		clear_bit(BRCMF_MGMT_TX_OFF_CHAN_COMPLETED,
   134			  &vif->mgmt_tx_status);
   135		mf_params_len = offsetof(struct brcmf_mf_params_le, data) +
   136				(len - DOT11_MGMT_HDR_LEN);
   137		mf_params = kzalloc(mf_params_len, GFP_KERNEL);
   138		if (!mf_params)
   139			return -ENOMEM;
   140	
   141		mf_params->dwell_time = cpu_to_le32(MGMT_AUTH_FRAME_DWELL_TIME);
   142		mf_params->len = cpu_to_le16(len - DOT11_MGMT_HDR_LEN);
   143		mf_params->frame_control = mgmt->frame_control;
   144	
   145		if (chan)
   146			freq = chan->center_freq;
   147		else
   148			brcmf_fil_cmd_int_get(vif->ifp, BRCMF_C_GET_CHANNEL,
   149					      &freq);
   150		chan_nr = ieee80211_frequency_to_channel(freq);
   151		mf_params->channel = cpu_to_le32(chan_nr);
   152		memcpy(&mf_params->da[0], &mgmt->da[0], ETH_ALEN);
   153		memcpy(&mf_params->bssid[0], &mgmt->bssid[0], ETH_ALEN);
   154		mf_params->packet_id = cpu_to_le32(*cookie);
   155		memcpy(mf_params->data, &buf[DOT11_MGMT_HDR_LEN],
   156		       le16_to_cpu(mf_params->len));
   157	
   158		brcmf_dbg(TRACE, "Auth frame, cookie=%d, fc=%04x, len=%d, channel=%d\n",
   159			  le32_to_cpu(mf_params->packet_id),
   160			  le16_to_cpu(mf_params->frame_control),
   161			  le16_to_cpu(mf_params->len),
   162			  le32_to_cpu(mf_params->channel));
   163	
   164		vif->mgmt_tx_id = le32_to_cpu(mf_params->packet_id);
   165		set_bit(BRCMF_MGMT_TX_SEND_FRAME, &vif->mgmt_tx_status);
   166	
   167		err = brcmf_fil_bsscfg_data_set(vif->ifp, "mgmt_frame",
   168						mf_params, mf_params_len);
   169		if (err) {
   170			bphy_err(drvr, "Failed to send Auth frame: err=%d\n",
   171				 err);
   172			goto tx_status;
   173		}
   174	
   175		timeout =
   176			wait_for_completion_timeout(&vif->mgmt_tx,
   177						    MGMT_AUTH_FRAME_WAIT_TIME);
   178		if (test_bit(BRCMF_MGMT_TX_ACK, &vif->mgmt_tx_status)) {
   179			brcmf_dbg(TRACE, "TX Auth frame operation is success\n");
   180			ack = true;
   181		} else {
   182			bphy_err(drvr, "TX Auth frame operation is failed: status=%ld)\n",
   183				 vif->mgmt_tx_status);
   184		}
   185	
   186	tx_status:
   187		cfg80211_mgmt_tx_status(wdev, *cookie, buf, len, ack,
   188					GFP_KERNEL);
   189		kfree(mf_params);
   190		return err;
   191	}
   192	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

