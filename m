Return-Path: <linux-wireless+bounces-9680-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0482591B5C9
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Jun 2024 06:47:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA7111C2230A
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Jun 2024 04:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC9BF249F9;
	Fri, 28 Jun 2024 04:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QxGuB6+3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF38A224D2;
	Fri, 28 Jun 2024 04:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719550027; cv=none; b=FzAQpEPBqvCGotY1ZNitlWawUvAtWcJPrzqAkQS7kIm/BAAD9fUhsO6UJUjQr8Af2z/MjXq58lmYkolBu+vyNvYZxi+l+H7wQu/lubTHk4BQdG8qK7G08i3k0v5LroopcuW4PqmYiRr2ErmgImK8fdIpHy4qKlM+xGtdNeAKdEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719550027; c=relaxed/simple;
	bh=OyGnYkVTMeo9E0tebP3hGIKqk4ivb+YBb/w6+AvD+AE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rgBT+Qvw/Y790yi9jbC7VzHKetufeDmmhNhoHWdNKWQNEUOB9kRDJBUrgiSre3QNmmPfZWXBrxShQJGnfnWSlO2k98FmHKxoWTwOjZyT37QmS/1MSxVHng42Nur3lXvAaxfsvV6gW1h9NSIF4gYZ7IoNBuXFxWr5uPfyXy8xzg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QxGuB6+3; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719550025; x=1751086025;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OyGnYkVTMeo9E0tebP3hGIKqk4ivb+YBb/w6+AvD+AE=;
  b=QxGuB6+3iT/QVDQTFze7dzyO8oGSjIfpZ1MFVlnAHwJRkCMo0tn5PTQN
   oOMHwNBYrAWocGzxIay40K/P+p4WBBlpO8Y+0g20Bv/YAuZmbuublCFs1
   vpdlVggD89v4dWcrqiefUHOvcVZWmlWF7UPX3CAi8UjL4loc7dNa3Q2ck
   MoJMNrCNyCSS4y9SoYXAuQIyw7i+v0+JqVUkqUgkd/NlkvLoQGzzfPuU1
   2NeydzlWYKllXBP1eq38gcV6aL+i4eiTvPUZ/60LMBCtr+9JW+gIrIC1Q
   ZD3kbzD6YbW/+5P/uGayimdBByaHQ9JIRd9MB1qAIsNnzqYjv01fqjcMn
   g==;
X-CSE-ConnectionGUID: WLspNH3lTLW3YPHrv2m6PQ==
X-CSE-MsgGUID: VwlnMdOHS8+R7nMDW/up8Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11116"; a="16537250"
X-IronPort-AV: E=Sophos;i="6.09,168,1716274800"; 
   d="scan'208";a="16537250"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 21:47:04 -0700
X-CSE-ConnectionGUID: ObfNnmmQSqu+01rg6yVn4g==
X-CSE-MsgGUID: fzcF+uXKR22dAqq/M/L0Cw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,168,1716274800"; 
   d="scan'208";a="45254061"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 27 Jun 2024 21:47:02 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sN3Vj-000Gnu-2f;
	Fri, 28 Jun 2024 04:46:59 +0000
Date: Fri, 28 Jun 2024 12:46:03 +0800
From: kernel test robot <lkp@intel.com>
To: David Lin <yu-hao.lin@nxp.com>, linux-wireless@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	briannorris@chromium.org, kvalo@kernel.org, francesco@dolcini.it,
	tsung-hsien.hsieh@nxp.com, David Lin <yu-hao.lin@nxp.com>
Subject: Re: [PATCH 42/43] wifi: nxpwifi: add Makefile and Kconfig files for
 nxpwifi compilation
Message-ID: <202406281235.idQnZtIJ-lkp@intel.com>
References: <20240621075208.513497-43-yu-hao.lin@nxp.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240621075208.513497-43-yu-hao.lin@nxp.com>

Hi David,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 238d636723a30311e20fde0a361662e829fe488b]

url:    https://github.com/intel-lab-lkp/linux/commits/David-Lin/wifi-nxpwifi-add-11ac-c/20240625-161306
base:   238d636723a30311e20fde0a361662e829fe488b
patch link:    https://lore.kernel.org/r/20240621075208.513497-43-yu-hao.lin%40nxp.com
patch subject: [PATCH 42/43] wifi: nxpwifi: add Makefile and Kconfig files for nxpwifi compilation
config: i386-randconfig-062-20240628 (https://download.01.org/0day-ci/archive/20240628/202406281235.idQnZtIJ-lkp@intel.com/config)
compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240628/202406281235.idQnZtIJ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406281235.idQnZtIJ-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/net/wireless/nxp/nxpwifi/uap_cmd.c:541:19: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [usertype] size @@     got unsigned int @@
   drivers/net/wireless/nxp/nxpwifi/uap_cmd.c:541:19: sparse:     expected restricted __le16 [usertype] size
   drivers/net/wireless/nxp/nxpwifi/uap_cmd.c:541:19: sparse:     got unsigned int
>> drivers/net/wireless/nxp/nxpwifi/uap_cmd.c:554:29: sparse: sparse: cast from restricted __le16
>> drivers/net/wireless/nxp/nxpwifi/uap_cmd.c:573:19: sparse: sparse: bad assignment (+=) to restricted __le16
   drivers/net/wireless/nxp/nxpwifi/uap_cmd.c:584:27: sparse: sparse: bad assignment (+=) to restricted __le16
   drivers/net/wireless/nxp/nxpwifi/uap_cmd.c:596:27: sparse: sparse: bad assignment (+=) to restricted __le16
   drivers/net/wireless/nxp/nxpwifi/uap_cmd.c:609:27: sparse: sparse: bad assignment (+=) to restricted __le16
   drivers/net/wireless/nxp/nxpwifi/uap_cmd.c:622:27: sparse: sparse: bad assignment (+=) to restricted __le16
   drivers/net/wireless/nxp/nxpwifi/uap_cmd.c:640:27: sparse: sparse: bad assignment (+=) to restricted __le16
   drivers/net/wireless/nxp/nxpwifi/uap_cmd.c:653:27: sparse: sparse: bad assignment (+=) to restricted __le16
   drivers/net/wireless/nxp/nxpwifi/uap_cmd.c:666:21: sparse: sparse: cast from restricted __le16

vim +541 drivers/net/wireless/nxp/nxpwifi/uap_cmd.c

309a0039e40257 David Lin 2024-06-21  521  
309a0039e40257 David Lin 2024-06-21  522  /* This function prepares AP specific add station command.
309a0039e40257 David Lin 2024-06-21  523   */
309a0039e40257 David Lin 2024-06-21  524  static int
309a0039e40257 David Lin 2024-06-21  525  nxpwifi_cmd_uap_add_new_station(struct nxpwifi_private *priv,
309a0039e40257 David Lin 2024-06-21  526  				struct host_cmd_ds_command *cmd,
309a0039e40257 David Lin 2024-06-21  527  				u16 cmd_no, void *data_buf,
309a0039e40257 David Lin 2024-06-21  528  				u16 cmd_action, u32 cmd_type)
309a0039e40257 David Lin 2024-06-21  529  {
309a0039e40257 David Lin 2024-06-21  530  	struct host_cmd_ds_add_station *new_sta = &cmd->params.sta_info;
309a0039e40257 David Lin 2024-06-21  531  	struct nxpwifi_sta_info *add_sta = (struct nxpwifi_sta_info *)data_buf;
309a0039e40257 David Lin 2024-06-21  532  	struct station_parameters *params = add_sta->params;
309a0039e40257 David Lin 2024-06-21  533  	struct nxpwifi_sta_node *sta_ptr;
309a0039e40257 David Lin 2024-06-21  534  	u8 *pos, *cmd_end;
309a0039e40257 David Lin 2024-06-21  535  	u16 tlv_len;
309a0039e40257 David Lin 2024-06-21  536  	struct nxpwifi_ie_types_sta_flag *sta_flag;
309a0039e40257 David Lin 2024-06-21  537  	int i;
309a0039e40257 David Lin 2024-06-21  538  
309a0039e40257 David Lin 2024-06-21  539  	cmd->command = cpu_to_le16(HOST_CMD_ADD_NEW_STATION);
309a0039e40257 David Lin 2024-06-21  540  	new_sta->action = cpu_to_le16(cmd_action);
309a0039e40257 David Lin 2024-06-21 @541  	cmd->size = sizeof(struct host_cmd_ds_add_station) + S_DS_GEN;
309a0039e40257 David Lin 2024-06-21  542  
309a0039e40257 David Lin 2024-06-21  543  	if (cmd_action == HOST_ACT_ADD_STA)
309a0039e40257 David Lin 2024-06-21  544  		sta_ptr = nxpwifi_add_sta_entry(priv, add_sta->peer_mac);
309a0039e40257 David Lin 2024-06-21  545  	else
309a0039e40257 David Lin 2024-06-21  546  		sta_ptr = nxpwifi_get_sta_entry(priv, add_sta->peer_mac);
309a0039e40257 David Lin 2024-06-21  547  
309a0039e40257 David Lin 2024-06-21  548  	if (!sta_ptr)
309a0039e40257 David Lin 2024-06-21  549  		return -1;
309a0039e40257 David Lin 2024-06-21  550  
309a0039e40257 David Lin 2024-06-21  551  	memcpy(new_sta->peer_mac, add_sta->peer_mac, ETH_ALEN);
309a0039e40257 David Lin 2024-06-21  552  
309a0039e40257 David Lin 2024-06-21  553  	if (cmd_action == HOST_ACT_REMOVE_STA) {
309a0039e40257 David Lin 2024-06-21 @554  		cmd->size = cpu_to_le16(cmd->size);
309a0039e40257 David Lin 2024-06-21  555  		return 0;
309a0039e40257 David Lin 2024-06-21  556  	}
309a0039e40257 David Lin 2024-06-21  557  
309a0039e40257 David Lin 2024-06-21  558  	new_sta->aid = cpu_to_le16(params->aid);
309a0039e40257 David Lin 2024-06-21  559  	new_sta->listen_interval = cpu_to_le32(params->listen_interval);
309a0039e40257 David Lin 2024-06-21  560  	new_sta->cap_info = cpu_to_le16(params->capability);
309a0039e40257 David Lin 2024-06-21  561  
309a0039e40257 David Lin 2024-06-21  562  	pos = new_sta->tlv;
309a0039e40257 David Lin 2024-06-21  563  	cmd_end = (u8 *)cmd;
309a0039e40257 David Lin 2024-06-21  564  	cmd_end += (NXPWIFI_SIZE_OF_CMD_BUFFER - 1);
309a0039e40257 David Lin 2024-06-21  565  
309a0039e40257 David Lin 2024-06-21  566  	if (params->sta_flags_set & NL80211_STA_FLAG_WME)
309a0039e40257 David Lin 2024-06-21  567  		sta_ptr->is_wmm_enabled = 1;
309a0039e40257 David Lin 2024-06-21  568  	sta_flag = (struct nxpwifi_ie_types_sta_flag *)pos;
309a0039e40257 David Lin 2024-06-21  569  	sta_flag->header.type = cpu_to_le16(TLV_TYPE_UAP_STA_FLAGS);
309a0039e40257 David Lin 2024-06-21  570  	sta_flag->header.len = cpu_to_le16(sizeof(__le32));
309a0039e40257 David Lin 2024-06-21  571  	sta_flag->sta_flags = cpu_to_le32(params->sta_flags_set);
309a0039e40257 David Lin 2024-06-21  572  	pos += sizeof(struct nxpwifi_ie_types_sta_flag);
309a0039e40257 David Lin 2024-06-21 @573  	cmd->size += sizeof(struct nxpwifi_ie_types_sta_flag);
309a0039e40257 David Lin 2024-06-21  574  
309a0039e40257 David Lin 2024-06-21  575  	if (params->ext_capab_len) {
309a0039e40257 David Lin 2024-06-21  576  		u8 *data = (u8 *)params->ext_capab;
309a0039e40257 David Lin 2024-06-21  577  		u16 len = params->ext_capab_len;
309a0039e40257 David Lin 2024-06-21  578  
309a0039e40257 David Lin 2024-06-21  579  		tlv_len = nxpwifi_append_data_tlv(WLAN_EID_EXT_CAPABILITY,
309a0039e40257 David Lin 2024-06-21  580  						  data, len, pos, cmd_end);
309a0039e40257 David Lin 2024-06-21  581  		if (!tlv_len)
309a0039e40257 David Lin 2024-06-21  582  			return -1;
309a0039e40257 David Lin 2024-06-21  583  		pos += tlv_len;
309a0039e40257 David Lin 2024-06-21  584  		cmd->size += tlv_len;
309a0039e40257 David Lin 2024-06-21  585  	}
309a0039e40257 David Lin 2024-06-21  586  
309a0039e40257 David Lin 2024-06-21  587  	if (params->link_sta_params.supported_rates_len) {
309a0039e40257 David Lin 2024-06-21  588  		u8 *data = (u8 *)params->link_sta_params.supported_rates;
309a0039e40257 David Lin 2024-06-21  589  		u16 len = params->link_sta_params.supported_rates_len;
309a0039e40257 David Lin 2024-06-21  590  
309a0039e40257 David Lin 2024-06-21  591  		tlv_len = nxpwifi_append_data_tlv(WLAN_EID_SUPP_RATES,
309a0039e40257 David Lin 2024-06-21  592  						  data, len, pos, cmd_end);
309a0039e40257 David Lin 2024-06-21  593  		if (!tlv_len)
309a0039e40257 David Lin 2024-06-21  594  			return -1;
309a0039e40257 David Lin 2024-06-21  595  		pos += tlv_len;
309a0039e40257 David Lin 2024-06-21  596  		cmd->size += tlv_len;
309a0039e40257 David Lin 2024-06-21  597  	}
309a0039e40257 David Lin 2024-06-21  598  
309a0039e40257 David Lin 2024-06-21  599  	if (params->uapsd_queues || params->max_sp) {
309a0039e40257 David Lin 2024-06-21  600  		u8 qos_capability = params->uapsd_queues | (params->max_sp << 5);
309a0039e40257 David Lin 2024-06-21  601  		u8 *data = &qos_capability;
309a0039e40257 David Lin 2024-06-21  602  		u16 len = sizeof(u8);
309a0039e40257 David Lin 2024-06-21  603  
309a0039e40257 David Lin 2024-06-21  604  		tlv_len = nxpwifi_append_data_tlv(WLAN_EID_QOS_CAPA,
309a0039e40257 David Lin 2024-06-21  605  						  data, len, pos, cmd_end);
309a0039e40257 David Lin 2024-06-21  606  		if (!tlv_len)
309a0039e40257 David Lin 2024-06-21  607  			return -1;
309a0039e40257 David Lin 2024-06-21  608  		pos += tlv_len;
309a0039e40257 David Lin 2024-06-21  609  		cmd->size += tlv_len;
309a0039e40257 David Lin 2024-06-21  610  		sta_ptr->is_wmm_enabled = 1;
309a0039e40257 David Lin 2024-06-21  611  	}
309a0039e40257 David Lin 2024-06-21  612  
309a0039e40257 David Lin 2024-06-21  613  	if (params->link_sta_params.ht_capa) {
309a0039e40257 David Lin 2024-06-21  614  		u8 *data = (u8 *)params->link_sta_params.ht_capa;
309a0039e40257 David Lin 2024-06-21  615  		u16 len = sizeof(struct ieee80211_ht_cap);
309a0039e40257 David Lin 2024-06-21  616  
309a0039e40257 David Lin 2024-06-21  617  		tlv_len = nxpwifi_append_data_tlv(WLAN_EID_HT_CAPABILITY,
309a0039e40257 David Lin 2024-06-21  618  						  data, len, pos, cmd_end);
309a0039e40257 David Lin 2024-06-21  619  		if (!tlv_len)
309a0039e40257 David Lin 2024-06-21  620  			return -1;
309a0039e40257 David Lin 2024-06-21  621  		pos += tlv_len;
309a0039e40257 David Lin 2024-06-21  622  		cmd->size += tlv_len;
309a0039e40257 David Lin 2024-06-21  623  		sta_ptr->is_11n_enabled = 1;
309a0039e40257 David Lin 2024-06-21  624  		sta_ptr->max_amsdu =
309a0039e40257 David Lin 2024-06-21  625  			le16_to_cpu(params->link_sta_params.ht_capa->cap_info) &
309a0039e40257 David Lin 2024-06-21  626  			IEEE80211_HT_CAP_MAX_AMSDU ?
309a0039e40257 David Lin 2024-06-21  627  			NXPWIFI_TX_DATA_BUF_SIZE_8K :
309a0039e40257 David Lin 2024-06-21  628  			NXPWIFI_TX_DATA_BUF_SIZE_4K;
309a0039e40257 David Lin 2024-06-21  629  	}
309a0039e40257 David Lin 2024-06-21  630  
309a0039e40257 David Lin 2024-06-21  631  	if (params->link_sta_params.vht_capa) {
309a0039e40257 David Lin 2024-06-21  632  		u8 *data = (u8 *)params->link_sta_params.vht_capa;
309a0039e40257 David Lin 2024-06-21  633  		u16 len = sizeof(struct ieee80211_vht_cap);
309a0039e40257 David Lin 2024-06-21  634  
309a0039e40257 David Lin 2024-06-21  635  		tlv_len = nxpwifi_append_data_tlv(WLAN_EID_VHT_CAPABILITY,
309a0039e40257 David Lin 2024-06-21  636  						  data, len, pos, cmd_end);
309a0039e40257 David Lin 2024-06-21  637  		if (!tlv_len)
309a0039e40257 David Lin 2024-06-21  638  			return -1;
309a0039e40257 David Lin 2024-06-21  639  		pos += tlv_len;
309a0039e40257 David Lin 2024-06-21  640  		cmd->size += tlv_len;
309a0039e40257 David Lin 2024-06-21  641  		sta_ptr->is_11ac_enabled = 1;
309a0039e40257 David Lin 2024-06-21  642  	}
309a0039e40257 David Lin 2024-06-21  643  
309a0039e40257 David Lin 2024-06-21  644  	if (params->link_sta_params.opmode_notif_used) {
309a0039e40257 David Lin 2024-06-21  645  		u8 *data = &params->link_sta_params.opmode_notif;
309a0039e40257 David Lin 2024-06-21  646  		u16 len = sizeof(u8);
309a0039e40257 David Lin 2024-06-21  647  
309a0039e40257 David Lin 2024-06-21  648  		tlv_len = nxpwifi_append_data_tlv(WLAN_EID_OPMODE_NOTIF,
309a0039e40257 David Lin 2024-06-21  649  						  data, len, pos, cmd_end);
309a0039e40257 David Lin 2024-06-21  650  		if (!tlv_len)
309a0039e40257 David Lin 2024-06-21  651  			return -1;
309a0039e40257 David Lin 2024-06-21  652  		pos += tlv_len;
309a0039e40257 David Lin 2024-06-21  653  		cmd->size += tlv_len;
309a0039e40257 David Lin 2024-06-21  654  	}
309a0039e40257 David Lin 2024-06-21  655  
309a0039e40257 David Lin 2024-06-21  656  	for (i = 0; i < MAX_NUM_TID; i++) {
309a0039e40257 David Lin 2024-06-21  657  		if (sta_ptr->is_11n_enabled)
309a0039e40257 David Lin 2024-06-21  658  			sta_ptr->ampdu_sta[i] =
309a0039e40257 David Lin 2024-06-21  659  				      priv->aggr_prio_tbl[i].ampdu_user;
309a0039e40257 David Lin 2024-06-21  660  		else
309a0039e40257 David Lin 2024-06-21  661  			sta_ptr->ampdu_sta[i] = BA_STREAM_NOT_ALLOWED;
309a0039e40257 David Lin 2024-06-21  662  	}
309a0039e40257 David Lin 2024-06-21  663  
309a0039e40257 David Lin 2024-06-21  664  	memset(sta_ptr->rx_seq, 0xff, sizeof(sta_ptr->rx_seq));
309a0039e40257 David Lin 2024-06-21  665  
309a0039e40257 David Lin 2024-06-21  666  	cmd->size = cpu_to_le16(cmd->size);
309a0039e40257 David Lin 2024-06-21  667  
309a0039e40257 David Lin 2024-06-21  668  	return 0;
309a0039e40257 David Lin 2024-06-21  669  }
309a0039e40257 David Lin 2024-06-21  670  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

