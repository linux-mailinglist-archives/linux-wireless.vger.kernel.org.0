Return-Path: <linux-wireless+bounces-13066-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6930C97DB00
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Sep 2024 02:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1113B21CF7
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Sep 2024 00:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FA8764D;
	Sat, 21 Sep 2024 00:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X0hpZHZ0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281C8F9DF
	for <linux-wireless@vger.kernel.org>; Sat, 21 Sep 2024 00:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726878625; cv=none; b=rXnkD1WMnyW0CY2PKNK25xvLHDGIYyvZVOYfTZIchY2cWSx1kkOrpgqJxDlgJY0gU+A8aahDaluscgAmqX7tCFG3U8AeeBY6xoEGzxO/YJYBgBSdqJ1WqcV6Zjr9PgIjbmxTjgKfPFBCDBgVkiV9kp1vCoLKAABtpbVfSZdffJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726878625; c=relaxed/simple;
	bh=s+te0z3ucG6z+gzguc10aZssfb6s3ITe9G+YWhoNdRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZJLqoXf39Tlcdg8OrjvuoCsro7GxffD6MN1JPzuDIkqGcuyDMCCaBV9dQorcYKk00cSH2Vvaej/jMYAuNQoSaF9W1e+/GUrixM+4N9UO5uVzNnnCCYRwbPORukHU/AeBaEd+1fBlOpKcFhF7ELvNO2p9N3YXXWaQq7o04hUM3Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X0hpZHZ0; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726878622; x=1758414622;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=s+te0z3ucG6z+gzguc10aZssfb6s3ITe9G+YWhoNdRc=;
  b=X0hpZHZ08L4prDGN2gG6VJ6VYBxSGnnjsPsZzWA6O842XpN3UUt7mb1g
   BYxT1dQJzF3Wx+wR4V8naTAg9n6ynjm/j/WrgfoYG0yENW3PJ03LCOzR6
   jfYEBuajz5yPJgsV0BKMCMDncK+EMR/divBB1ZD84tP4W2eRBUNWS+Fa7
   42rBDUDmVWXX6DIGlKvyWzgwoHcKB97XSg8TSbbMez7d7xZ9XgPayK7cj
   gwECUQMr3bvqOgJWVljzJ2hnGzpVLjqC3HLXPh/HivEEa3JFpRmo8irm1
   8y3VXucOwcuYRE0Bm/Dc+DlnyoblgI/3SLT601ux9PoB6LgdzszhQYxWN
   g==;
X-CSE-ConnectionGUID: NcuDWl/6TSKasQ5y0YS/rw==
X-CSE-MsgGUID: asRCeQIUQKiVR4ppIPtdzg==
X-IronPort-AV: E=McAfee;i="6700,10204,11201"; a="25419270"
X-IronPort-AV: E=Sophos;i="6.10,245,1719903600"; 
   d="scan'208";a="25419270"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2024 17:30:21 -0700
X-CSE-ConnectionGUID: Ael24AiVTi2PSLfO9oo+CA==
X-CSE-MsgGUID: +wAAJHjuS2i3gRPMdipYMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,245,1719903600"; 
   d="scan'208";a="74865924"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 20 Sep 2024 17:30:20 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sro0v-000Eyp-0x;
	Sat, 21 Sep 2024 00:30:17 +0000
Date: Sat, 21 Sep 2024 08:30:07 +0800
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
Message-ID: <202409210841.FOhxxJK2-lkp@intel.com>
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
config: x86_64-randconfig-122-20240921 (https://download.01.org/0day-ci/archive/20240921/202409210841.FOhxxJK2-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240921/202409210841.FOhxxJK2-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202409210841.FOhxxJK2-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c:152:28: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [usertype] channel @@     got restricted __le32 [usertype] @@
   drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c:152:28: sparse:     expected restricted __le16 [usertype] channel
   drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c:152:28: sparse:     got restricted __le32 [usertype]
>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c:159:9: sparse: sparse: cast to restricted __le32
>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c:159:9: sparse: sparse: cast from restricted __le16
>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c:217:9: sparse: sparse: cast from restricted __le32
>> drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c:254:33: sparse: sparse: cast to restricted __be32

vim +152 drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c

   101	
   102	static
   103	int brcmf_cyw_mgmt_tx(struct wiphy *wiphy, struct wireless_dev *wdev,
   104			      struct cfg80211_mgmt_tx_params *params, u64 *cookie)
   105	{
   106		struct brcmf_cfg80211_info *cfg = wiphy_to_cfg(wiphy);
   107		struct ieee80211_channel *chan = params->chan;
   108		struct brcmf_pub *drvr = cfg->pub;
   109		const u8 *buf = params->buf;
   110		size_t len = params->len;
   111		const struct ieee80211_mgmt *mgmt;
   112		struct brcmf_cfg80211_vif *vif;
   113		s32 err = 0;
   114		bool ack = false;
   115		s32 chan_nr;
   116		u32 freq;
   117		struct brcmf_mf_params_le *mf_params;
   118		u32 mf_params_len;
   119		s32 ready;
   120	
   121		brcmf_dbg(TRACE, "Enter\n");
   122	
   123		mgmt = (const struct ieee80211_mgmt *)buf;
   124	
   125		if (!ieee80211_is_auth(mgmt->frame_control))
   126			return brcmf_cfg80211_mgmt_tx(wiphy, wdev, params, cookie);
   127	
   128		*cookie = 0;
   129		vif = container_of(wdev, struct brcmf_cfg80211_vif, wdev);
   130	
   131		reinit_completion(&vif->mgmt_tx);
   132		clear_bit(BRCMF_MGMT_TX_ACK, &vif->mgmt_tx_status);
   133		clear_bit(BRCMF_MGMT_TX_NOACK, &vif->mgmt_tx_status);
   134		clear_bit(BRCMF_MGMT_TX_OFF_CHAN_COMPLETED,
   135			  &vif->mgmt_tx_status);
   136		mf_params_len = offsetof(struct brcmf_mf_params_le, data) +
   137				(len - DOT11_MGMT_HDR_LEN);
   138		mf_params = kzalloc(mf_params_len, GFP_KERNEL);
   139		if (!mf_params)
   140			return -ENOMEM;
   141	
   142		mf_params->dwell_time = cpu_to_le32(MGMT_AUTH_FRAME_DWELL_TIME);
   143		mf_params->len = cpu_to_le16(len - DOT11_MGMT_HDR_LEN);
   144		mf_params->frame_control = mgmt->frame_control;
   145	
   146		if (chan)
   147			freq = chan->center_freq;
   148		else
   149			brcmf_fil_cmd_int_get(vif->ifp, BRCMF_C_GET_CHANNEL,
   150					      &freq);
   151		chan_nr = ieee80211_frequency_to_channel(freq);
 > 152		mf_params->channel = cpu_to_le32(chan_nr);
   153		memcpy(&mf_params->da[0], &mgmt->da[0], ETH_ALEN);
   154		memcpy(&mf_params->bssid[0], &mgmt->bssid[0], ETH_ALEN);
   155		mf_params->packet_id = cpu_to_le32(*cookie);
   156		memcpy(mf_params->data, &buf[DOT11_MGMT_HDR_LEN],
   157		       le16_to_cpu(mf_params->len));
   158	
 > 159		brcmf_dbg(TRACE, "Auth frame, cookie=%d, fc=%04x, len=%d, channel=%d\n",
   160			  le32_to_cpu(mf_params->packet_id),
   161			  le16_to_cpu(mf_params->frame_control),
   162			  le16_to_cpu(mf_params->len),
   163			  le32_to_cpu(mf_params->channel));
   164	
   165		vif->mgmt_tx_id = le32_to_cpu(mf_params->packet_id);
   166		set_bit(BRCMF_MGMT_TX_SEND_FRAME, &vif->mgmt_tx_status);
   167	
   168		err = brcmf_fil_bsscfg_data_set(vif->ifp, "mgmt_frame",
   169						mf_params, mf_params_len);
   170		if (err) {
   171			bphy_err(drvr, "Failed to send Auth frame: err=%d\n",
   172				 err);
   173			goto tx_status;
   174		}
   175	
   176		ready = wait_for_completion_timeout(&vif->mgmt_tx,
   177						    MGMT_AUTH_FRAME_WAIT_TIME);
   178		if (test_bit(BRCMF_MGMT_TX_ACK, &vif->mgmt_tx_status)) {
   179			brcmf_dbg(TRACE, "TX Auth frame operation is success\n");
   180			ack = true;
   181		} else {
   182			bphy_err(drvr, "TX Auth frame operation is %s: status=%ld)\n",
   183				 ready ? "failed" : "timedout", vif->mgmt_tx_status);
   184		}
   185	
   186	tx_status:
   187		cfg80211_mgmt_tx_status(wdev, *cookie, buf, len, ack,
   188					GFP_KERNEL);
   189		kfree(mf_params);
   190		return err;
   191	}
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
   227	static void brcmf_cyw_get_cfg80211_ops(struct brcmf_pub *drvr)
   228	{
   229		drvr->ops->mgmt_tx = brcmf_cyw_mgmt_tx;
   230		drvr->ops->external_auth = brcmf_cyw_external_auth;
   231	}
   232	
   233	static s32
   234	brcmf_cyw_notify_ext_auth_req(struct brcmf_if *ifp,
   235				      const struct brcmf_event_msg *e, void *data)
   236	{
   237		struct brcmf_pub *drvr = ifp->drvr;
   238		struct cfg80211_external_auth_params params;
   239		struct brcmf_auth_req_status_le *auth_req =
   240			(struct brcmf_auth_req_status_le *)data;
   241		s32 err = 0;
   242	
   243		brcmf_dbg(INFO, "Enter: event %s (%d) received\n",
   244			  brcmf_fweh_event_name(e->event_code), e->event_code);
   245	
   246		if (e->datalen < sizeof(*auth_req)) {
   247			bphy_err(drvr, "Event %s (%d) data too small. Ignore\n",
   248				 brcmf_fweh_event_name(e->event_code), e->event_code);
   249			return -EINVAL;
   250		}
   251	
   252		memset(&params, 0, sizeof(params));
   253		params.action = NL80211_EXTERNAL_AUTH_START;
 > 254		params.key_mgmt_suite = ntohl(WLAN_AKM_SUITE_SAE);
   255		params.status = WLAN_STATUS_SUCCESS;
   256		params.ssid.ssid_len = min_t(u32, 32, le32_to_cpu(auth_req->ssid_len));
   257		memcpy(params.ssid.ssid, auth_req->ssid, params.ssid.ssid_len);
   258		memcpy(params.bssid, auth_req->peer_mac, ETH_ALEN);
   259	
   260		err = cfg80211_external_auth_request(ifp->ndev, &params, GFP_ATOMIC);
   261		if (err)
   262			bphy_err(drvr, "Ext Auth request to supplicant failed (%d)\n",
   263				 err);
   264	
   265		return err;
   266	}
   267	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

