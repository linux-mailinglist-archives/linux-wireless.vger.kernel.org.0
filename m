Return-Path: <linux-wireless+bounces-32296-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sDbnGKN+oWkUtgQAu9opvQ
	(envelope-from <linux-wireless+bounces-32296-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 12:23:15 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D6D1B67FF
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 12:23:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6EDA63093246
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 11:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB20C3EF0B9;
	Fri, 27 Feb 2026 11:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b="INPUoHLR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B9A3ED139
	for <linux-wireless@vger.kernel.org>; Fri, 27 Feb 2026 11:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772191351; cv=none; b=NcrEd359JT+D7eAe+yoiYZvIUJayeJWlsDIIfGUPFHFZndeC4uLs+RZPxSYeGoHQkKCSQgKzZgJjLkvVy2O0WT+7QlWwWcCCILOhur6wNtFm586gAncnVWnXAYrM19hE6A1xPmuqdDScGJgnoJ6UgwqUziaqyKeeYXiYNedfU0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772191351; c=relaxed/simple;
	bh=MuoyN2UgZRakSrrqIqS2DzAyxFJ0zQ1CYpqEqRa+prs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ow2D83Q25qHrJupYMa2Y+zlIaUGPU+19AFVu4fwNVbT05RMMTmRFQf0x55dVXH14bShSlumhxVSbZsZ7GRVcPVgdm3yQwu0c5Q82R/wnY6InXgaNHDbxvoPPz5U3mPIvc9yG1TB4/5zfw1MC1k9lIJTe4klMKqCYyys4v4lwHA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr; spf=pass smtp.mailfrom=freebox.fr; dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b=INPUoHLR; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freebox.fr
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4836f363ad2so22278175e9.1
        for <linux-wireless@vger.kernel.org>; Fri, 27 Feb 2026 03:22:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=freebox-fr.20230601.gappssmtp.com; s=20230601; t=1772191346; x=1772796146; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1smeIu7OU3wnxH078ZTR3PqKFqprq4GBKxMxhyJVsNM=;
        b=INPUoHLRVzPeau9eCvSNRgJ6Iw5FFEFhkzfL6LM4ZQYX5IazwAHz6hkJo//+NFivmr
         mTzPfIUqGyf62E7fiWmsrt5ycMrK4MCoP/MsX+AuvMs5hhJXr4PZQJZJA8tZsGwAeagg
         gNhSuOGaumULKCXt2AX/bInr3nAdfZ2z6tLj5EvKxjiG9YBTzaeTHWeB4lvko+Br4J8C
         75EfIbEwSRvrj+X8GCjaOyVuCUdVaCq1I5nOH3sqGdMKPY5cs8roNJi5DnmWSwmWtdfs
         yYoCIUnERddu9xWXOJPeBbQ79ddHh8v7Hq0Z6OnIVRb07s3hi8R3Zd6CiXpmID63Z3AU
         5V3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772191346; x=1772796146;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1smeIu7OU3wnxH078ZTR3PqKFqprq4GBKxMxhyJVsNM=;
        b=tO0F1sKXjpbnizcIVIRaZtmdqpik+J6dvZJiouxnHo6LCPuFoo7Q8Q0iC8vtG2yA/8
         k45+wAQzbSuXs77Defk+myDLCgXvT8CnpP5pEwoREBV3PtLxMJoLQK85SoCm4Xayxxab
         JqPNtqK2Rjbgc+QE+Rbvz+OWpcnlcRGAxHvmV2vDeE49iFGaPPr/Is9ML0PXHTsME0CN
         gm984PgDqWd/pUL87cOB7ymAA56VslhoifDgNfZtAfvZSQQNY7TyrpGJ3U/dh5ReqkHJ
         AQdv5flLolmetHCh+WeNPx8gPIPkM60Xd8tYJD906YXXr0052irDnm/nE3g/9ygo9CO0
         9RXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXDUp4u7nDQKWPVacFE8Gn2UjVgDeO86ICrVAL2b5wBo4S1FvXh8uGDOMa5l4aIKAnpRsV/aSGIy6wxJyxeVQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxnJ9lzi8Cvv3KOs9Lnq3s2I3C5ovpmevDpLEp4IKOtekoJMCDm
	jWHD5xpxvRdrKOMnZZVJjKP0XMRZc8xvibsQ5EgIpg+JF5KkFJEqb8BSdLVU5+EmanI=
X-Gm-Gg: ATEYQzwzL8CTUXUl0YSu0I/n0Il5bRaQRoKW+r+2cJ3DjCa6ol+EjF4DsDbq5HuZwlk
	lDNGWhQFZHL7PzSy+wKwIzW//ZL+LtyY8QyP5jp+hFyguDig3lnhUVJcsORYhDbHV/TjNvN1xOz
	gQABdGE7QntmsvzjBQbIhT/kbpIv044ZcKk1mK9Svl7PVgPfsJ7vg5jjombx5IIi87EXlyibL95
	vYPxNhwHNz14TqSil+Mh/M1qBrugMx1oj5+fPf4WWzgvePuHHClQOdvmQiPhTZMLuZyHCJVGYR2
	aFmg3pw9kHhH4OQfr5HVR0avNZ/oDMI5i5Pfa2ODeoiVqXTZAz6RNUn1O8C4zHvBAkjDlof7M5X
	nBvK9VSnuGwAth7MpkLwDtZ1DlTSYzXH9mKyRlYmG5CQ0s/YCyk3OnKv+2EgO7r1G84iWscyQay
	FzIvB4DWYaqHcCfxRDMr4doelBoK1svjJM4nEGtZOykhNrLMS25uviXQ==
X-Received: by 2002:a05:6000:4021:b0:432:84f9:8bea with SMTP id ffacd0b85a97d-4399de36932mr3990649f8f.51.1772191346008;
        Fri, 27 Feb 2026 03:22:26 -0800 (PST)
Received: from [192.168.108.101] (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4399c76b40esm5723634f8f.36.2026.02.27.03.22.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Feb 2026 03:22:25 -0800 (PST)
Message-ID: <418d3666-6bd2-4ea7-8e1b-4d49dda255a2@freebox.fr>
Date: Fri, 27 Feb 2026 12:22:25 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: move action code from per-type frame structs
To: Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
References: <20260226183607.67e71846b59e.I9a24328e3ffcaae179466a935f1c3345029f9961@changeid>
From: Pablo MARTIN-GOMEZ <pmartin-gomez@freebox.fr>
Content-Language: en-US
In-Reply-To: <20260226183607.67e71846b59e.I9a24328e3ffcaae179466a935f1c3345029f9961@changeid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[freebox-fr.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[freebox-fr.20230601.gappssmtp.com:+];
	TAGGED_FROM(0.00)[bounces-32296-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[freebox.fr];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pmartin-gomez@freebox.fr,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,freebox-fr.20230601.gappssmtp.com:dkim,freebox.fr:mid]
X-Rspamd-Queue-Id: C6D6D1B67FF
X-Rspamd-Action: no action

Hello,

On 26/02/2026 18:36, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> The action code actually serves to identify the type of action
> frame, so it really isn't part of the per-type structure. Pull
> it out and have it in the general action frame format.
> 
> In theory, whether or not the action code is present in this
> way is up to each category, but all categories that are defined
> right now all have that value.
> 
> While at it, and since this change requires changing all users,
> remove the 'u' and make it an anonymous union in this case, so
> that all code using this changes.
> 
> Change IEEE80211_MIN_ACTION_SIZE to take an argument which says
> how much of the frame is needed, e.g. category, action_code or
> the specific frame type that's defined in the union. Again this
> also ensures that all code is updated.
> 
> In some cases, fix bugs where the SKB length was checked after
> having accessed beyond the checked length, in particular in FTM
> code, e.g. ieee80211_is_ftm().
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
> v2: fix public action frame handling
> ---
>  drivers/net/wireless/ath/ath11k/mac.c         |   4 +-
>  drivers/net/wireless/ath/ath12k/mac.c         |   4 +-
>  drivers/net/wireless/ath/ath12k/wifi7/hw.c    |   2 +-
>  .../wireless/intel/iwlwifi/mld/time_sync.c    |   6 +-
>  .../intel/iwlwifi/mvm/ftm-initiator.c         |   7 +-
>  .../wireless/intel/iwlwifi/mvm/time-sync.c    |   6 +-
>  drivers/net/wireless/marvell/mwifiex/tdls.c   |  12 +-
>  drivers/net/wireless/marvell/mwl8k.c          |   4 +-
>  .../wireless/mediatek/mt76/mt76_connac_mac.c  |   4 +-
>  .../net/wireless/mediatek/mt76/mt7925/mac.c   |   2 +-
>  .../net/wireless/mediatek/mt76/mt7996/mac.c   |   2 +-
>  drivers/net/wireless/realtek/rtl8xxxu/core.c  |  14 +-
>  drivers/net/wireless/realtek/rtlwifi/base.c   |  28 ++--
>  drivers/net/wireless/realtek/rtlwifi/pci.c    |   2 +-
>  include/linux/ieee80211.h                     |  83 +++++-------
>  net/mac80211/agg-rx.c                         |  27 ++--
>  net/mac80211/agg-tx.c                         |  28 ++--
>  net/mac80211/eht.c                            |  21 ++-
>  net/mac80211/ht.c                             |  31 ++---
>  net/mac80211/ibss.c                           |  18 +--
>  net/mac80211/iface.c                          |  18 +--
>  net/mac80211/mesh.c                           |  14 +-
>  net/mac80211/mesh_hwmp.c                      |  20 ++-
>  net/mac80211/mesh_plink.c                     |  21 ++-
>  net/mac80211/mlme.c                           |  82 +++++-------
>  net/mac80211/rx.c                             | 123 ++++++++----------
>  net/mac80211/s1g.c                            |  28 ++--
>  net/mac80211/spectmgmt.c                      |  31 ++---
>  net/mac80211/tdls.c                           |  29 ++---
>  net/mac80211/util.c                           |   5 +-
>  net/mac80211/vht.c                            |  10 +-
>  31 files changed, 301 insertions(+), 385 deletions(-)
> 
[...]
> diff --git a/drivers/net/wireless/marvell/mwifiex/tdls.c b/drivers/net/wireless/marvell/mwifiex/tdls.c
> index 77a9a6de636d..95fd5a924226 100644
> --- a/drivers/net/wireless/marvell/mwifiex/tdls.c
> +++ b/drivers/net/wireless/marvell/mwifiex/tdls.c
> @@ -755,16 +755,12 @@ mwifiex_construct_tdls_action_frame(struct mwifiex_private *priv,
>  	switch (action_code) {
>  	case WLAN_PUB_ACTION_TDLS_DISCOVER_RES:
>  		/* See the layout of 'struct ieee80211_mgmt'. */
> -		extra = sizeof(mgmt->u.action.u.tdls_discover_resp) +
> -			sizeof(mgmt->u.action.category);
> +		extra = IEEE80211_MIN_ACTION_SIZE(tdls_discover_resp) - 24;
Not sure that is clearer than:
```
extra = sizeof(mgmt->u.action.u.tdls_discover_resp) +
        sizeof(mgmt->u.action.category) +
        sizeof(mgmt->u.action.action_code);
```
>  		skb_put(skb, extra);
>  		mgmt->u.action.category = WLAN_CATEGORY_PUBLIC;
> -		mgmt->u.action.u.tdls_discover_resp.action_code =
> -					      WLAN_PUB_ACTION_TDLS_DISCOVER_RES;
> -		mgmt->u.action.u.tdls_discover_resp.dialog_token =
> -								   dialog_token;
> -		mgmt->u.action.u.tdls_discover_resp.capability =
> -							     cpu_to_le16(capab);
> +		mgmt->u.action.action_code = WLAN_PUB_ACTION_TDLS_DISCOVER_RES;
> +		mgmt->u.action.tdls_discover_resp.dialog_token = dialog_token;
> +		mgmt->u.action.tdls_discover_resp.capability = cpu_to_le16(capab);
>  		/* move back for addr4 */
>  		memmove(pos + ETH_ALEN, &mgmt->u.action, extra);
>  		/* init address 4 */
[...]
> @@ -477,22 +478,22 @@ void ieee80211_process_addba_request(struct ieee80211_local *local,
>  	u8 dialog_token, addba_ext_data;
>  
>  	/* extract session parameters from addba request frame */
> -	dialog_token = mgmt->u.action.u.addba_req.dialog_token;
> -	timeout = le16_to_cpu(mgmt->u.action.u.addba_req.timeout);
> +	dialog_token = mgmt->u.action.addba_req.dialog_token;
> +	timeout = le16_to_cpu(mgmt->u.action.addba_req.timeout);
>  	start_seq_num =
> -		le16_to_cpu(mgmt->u.action.u.addba_req.start_seq_num) >> 4;
> +		le16_to_cpu(mgmt->u.action.addba_req.start_seq_num) >> 4;
>  
> -	capab = le16_to_cpu(mgmt->u.action.u.addba_req.capab);
> +	capab = le16_to_cpu(mgmt->u.action.addba_req.capab);
>  	ba_policy = (capab & IEEE80211_ADDBA_PARAM_POLICY_MASK) >> 1;
>  	tid = (capab & IEEE80211_ADDBA_PARAM_TID_MASK) >> 2;
>  	buf_size = (capab & IEEE80211_ADDBA_PARAM_BUF_SIZE_MASK) >> 6;
>  
>  	addba_ext_data =
>  		ieee80211_retrieve_addba_ext_data(sta,
> -						  mgmt->u.action.u.addba_req.variable,
> +						  mgmt->u.action.addba_req.variable,
>  						  len -
>  						  offsetof(typeof(*mgmt),
> -							   u.action.u.addba_req.variable),
> +							   u.action.addba_req.variable),
`offsetof(typeof(*mgmt), u.action.u.type.variable` is equivalent to
`IEEE80211_MIN_ACTION_SIZE(type)`, isn't clearer to use it?
>  						  &buf_size);
>  
>  	__ieee80211_start_rx_ba_session(sta, dialog_token, timeout,
> diff --git a/net/mac80211/agg-tx.c b/net/mac80211/agg-tx.c
> index d981b0fc57bf..de68f7da6f39 100644
> --- a/net/mac80211/agg-tx.c
> +++ b/net/mac80211/agg-tx.c
> @@ -9,7 +9,7 @@
>   * Copyright 2007, Michael Wu <flamingice@sourmilk.net>
>   * Copyright 2007-2010, Intel Corporation
>   * Copyright(c) 2015-2017 Intel Deutschland GmbH
> - * Copyright (C) 2018 - 2024 Intel Corporation
> + * Copyright (C) 2018-2026 Intel Corporation
>   */
>  
>  #include <linux/ieee80211.h>
> @@ -68,7 +68,7 @@ static void ieee80211_send_addba_request(struct sta_info *sta, u16 tid,
>  	struct ieee80211_mgmt *mgmt;
>  	u16 capab;
>  
> -	skb = dev_alloc_skb(sizeof(*mgmt) +
> +	skb = dev_alloc_skb(IEEE80211_MIN_ACTION_SIZE(addba_req) +
>  			    2 + sizeof(struct ieee80211_addba_ext_ie) +
>  			    local->hw.extra_tx_headroom);
>  	if (!skb)
> @@ -77,21 +77,21 @@ static void ieee80211_send_addba_request(struct sta_info *sta, u16 tid,
>  	skb_reserve(skb, local->hw.extra_tx_headroom);
>  	mgmt = ieee80211_mgmt_ba(skb, sta->sta.addr, sdata);
>  
> -	skb_put(skb, 1 + sizeof(mgmt->u.action.u.addba_req));
> +	skb_put(skb, 2 + sizeof(mgmt->u.action.addba_req));
>  
>  	mgmt->u.action.category = WLAN_CATEGORY_BACK;
> -	mgmt->u.action.u.addba_req.action_code = WLAN_ACTION_ADDBA_REQ;
> +	mgmt->u.action.action_code = WLAN_ACTION_ADDBA_REQ;
>  
> -	mgmt->u.action.u.addba_req.dialog_token = dialog_token;
> +	mgmt->u.action.addba_req.dialog_token = dialog_token;
>  	capab = IEEE80211_ADDBA_PARAM_AMSDU_MASK;
>  	capab |= IEEE80211_ADDBA_PARAM_POLICY_MASK;
>  	capab |= u16_encode_bits(tid, IEEE80211_ADDBA_PARAM_TID_MASK);
>  	capab |= u16_encode_bits(agg_size, IEEE80211_ADDBA_PARAM_BUF_SIZE_MASK);
>  
> -	mgmt->u.action.u.addba_req.capab = cpu_to_le16(capab);
> +	mgmt->u.action.addba_req.capab = cpu_to_le16(capab);
>  
> -	mgmt->u.action.u.addba_req.timeout = cpu_to_le16(timeout);
> -	mgmt->u.action.u.addba_req.start_seq_num =
> +	mgmt->u.action.addba_req.timeout = cpu_to_le16(timeout);
> +	mgmt->u.action.addba_req.start_seq_num =
>  					cpu_to_le16(start_seq_num << 4);
>  
>  	if (sta->sta.deflink.he_cap.has_he)
> @@ -978,15 +978,15 @@ void ieee80211_process_addba_resp(struct ieee80211_local *local,
>  
>  	lockdep_assert_wiphy(sta->local->hw.wiphy);
>  
> -	capab = le16_to_cpu(mgmt->u.action.u.addba_resp.capab);
> +	capab = le16_to_cpu(mgmt->u.action.addba_resp.capab);
>  	amsdu = capab & IEEE80211_ADDBA_PARAM_AMSDU_MASK;
>  	tid = u16_get_bits(capab, IEEE80211_ADDBA_PARAM_TID_MASK);
>  	buf_size = u16_get_bits(capab, IEEE80211_ADDBA_PARAM_BUF_SIZE_MASK);
>  
>  	ieee80211_retrieve_addba_ext_data(sta,
> -					  mgmt->u.action.u.addba_resp.variable,
> +					  mgmt->u.action.addba_resp.variable,
>  					  len - offsetof(typeof(*mgmt),
> -							 u.action.u.addba_resp.variable),
> +							 u.action.addba_resp.variable),
Ditto
>  					  &buf_size);
>  
>  	buf_size = min(buf_size, local->hw.max_tx_aggregation_subframes);
[...]
> @@ -1613,12 +1605,12 @@ void ieee80211_ibss_rx_queued_mgmt(struct ieee80211_sub_if_data *sdata,
>  		case WLAN_CATEGORY_SPECTRUM_MGMT:
>  			ies_len = skb->len -
>  				  offsetof(struct ieee80211_mgmt,
> -					   u.action.u.chan_switch.variable);
> +					   u.action.chan_switch.variable);
Ditto
>  
>  			if (ies_len < 0)
>  				break;
>  
> -			elems = ieee802_11_parse_elems(mgmt->u.action.u.chan_switch.variable,
> +			elems = ieee802_11_parse_elems(mgmt->u.action.chan_switch.variable,
>  						       ies_len,
>  						       IEEE80211_FTYPE_MGMT |
>  						       IEEE80211_STYPE_ACTION,
> diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
> index 676b2a43c9f2..2e391cec73a0 100644
> --- a/net/mac80211/iface.c
> +++ b/net/mac80211/iface.c
> @@ -1579,7 +1579,7 @@ static void ieee80211_iface_process_skb(struct ieee80211_local *local,
>  
>  		sta = sta_info_get_bss(sdata, mgmt->sa);
>  		if (sta) {
> -			switch (mgmt->u.action.u.addba_req.action_code) {
> +			switch (mgmt->u.action.action_code) {
>  			case WLAN_ACTION_ADDBA_REQ:
>  				ieee80211_process_addba_request(local, sta,
>  								mgmt, len);
> @@ -1599,9 +1599,9 @@ static void ieee80211_iface_process_skb(struct ieee80211_local *local,
>  		}
>  	} else if (ieee80211_is_action(mgmt->frame_control) &&
>  		   mgmt->u.action.category == WLAN_CATEGORY_HT) {
> -		switch (mgmt->u.action.u.ht_smps.action) {
> +		switch (mgmt->u.action.action_code) {
>  		case WLAN_HT_ACTION_NOTIFY_CHANWIDTH: {
> -			u8 chanwidth = mgmt->u.action.u.ht_notify_cw.chanwidth;
> +			u8 chanwidth = mgmt->u.action.ht_notify_cw.chanwidth;
>  			struct ieee80211_rx_status *status;
>  			struct link_sta_info *link_sta;
>  			struct sta_info *sta;
> @@ -1628,7 +1628,7 @@ static void ieee80211_iface_process_skb(struct ieee80211_local *local,
>  		}
>  	} else if (ieee80211_is_action(mgmt->frame_control) &&
>  		   mgmt->u.action.category == WLAN_CATEGORY_VHT) {
> -		switch (mgmt->u.action.u.vht_group_notif.action_code) {
> +		switch (mgmt->u.action.action_code) {
>  		case WLAN_VHT_ACTION_OPMODE_NOTIF: {
>  			struct ieee80211_rx_status *status;
>  			enum nl80211_band band;
> @@ -1637,7 +1637,7 @@ static void ieee80211_iface_process_skb(struct ieee80211_local *local,
>  
>  			status = IEEE80211_SKB_RXCB(skb);
>  			band = status->band;
> -			opmode = mgmt->u.action.u.vht_opmode_notif.operating_mode;
> +			opmode = mgmt->u.action.vht_opmode_notif.operating_mode;
>  
>  			sta = sta_info_get_bss(sdata, mgmt->sa);
>  
> @@ -1658,7 +1658,7 @@ static void ieee80211_iface_process_skb(struct ieee80211_local *local,
>  		}
>  	} else if (ieee80211_is_action(mgmt->frame_control) &&
>  		   mgmt->u.action.category == WLAN_CATEGORY_S1G) {
> -		switch (mgmt->u.action.u.s1g.action_code) {
> +		switch (mgmt->u.action.action_code) {
>  		case WLAN_S1G_TWT_TEARDOWN:
>  		case WLAN_S1G_TWT_SETUP:
>  			ieee80211_s1g_rx_twt_action(sdata, skb);
> @@ -1669,7 +1669,7 @@ static void ieee80211_iface_process_skb(struct ieee80211_local *local,
>  	} else if (ieee80211_is_action(mgmt->frame_control) &&
>  		   mgmt->u.action.category == WLAN_CATEGORY_PROTECTED_EHT) {
>  		if (sdata->vif.type == NL80211_IFTYPE_AP) {
> -			switch (mgmt->u.action.u.eml_omn.action_code) {
> +			switch (mgmt->u.action.action_code) {
>  			case WLAN_PROTECTED_EHT_ACTION_EML_OP_MODE_NOTIF:
>  				ieee80211_rx_eml_op_mode_notif(sdata, skb);
>  				break;
> @@ -1677,7 +1677,7 @@ static void ieee80211_iface_process_skb(struct ieee80211_local *local,
>  				break;
>  			}
>  		} else if (sdata->vif.type == NL80211_IFTYPE_STATION) {
> -			switch (mgmt->u.action.u.ttlm_req.action_code) {
> +			switch (mgmt->u.action.action_code) {
>  			case WLAN_PROTECTED_EHT_ACTION_TTLM_REQ:
>  				ieee80211_process_neg_ttlm_req(sdata, mgmt,
>  							       skb->len);
> @@ -1765,7 +1765,7 @@ static void ieee80211_iface_process_status(struct ieee80211_sub_if_data *sdata,
>  
>  	if (ieee80211_is_action(mgmt->frame_control) &&
>  	    mgmt->u.action.category == WLAN_CATEGORY_S1G) {
> -		switch (mgmt->u.action.u.s1g.action_code) {
> +		switch (mgmt->u.action.action_code) {
>  		case WLAN_S1G_TWT_TEARDOWN:
>  		case WLAN_S1G_TWT_SETUP:
>  			ieee80211_s1g_status_twt_action(sdata, skb);
> diff --git a/net/mac80211/mesh.c b/net/mac80211/mesh.c
> index 68901f1def0d..ccbf33fb23bd 100644
> --- a/net/mac80211/mesh.c
> +++ b/net/mac80211/mesh.c
> @@ -1,7 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /*
>   * Copyright (c) 2008, 2009 open80211s Ltd.
> - * Copyright (C) 2018 - 2025 Intel Corporation
> + * Copyright (C) 2018-2026 Intel Corporation
>   * Authors:    Luis Carlos Cobo <luisca@cozybit.com>
>   * 	       Javier Cardona <javier@cozybit.com>
>   */
> @@ -19,8 +19,7 @@ static struct kmem_cache *rm_cache;
>  
>  bool mesh_action_is_path_sel(struct ieee80211_mgmt *mgmt)
>  {
> -	return (mgmt->u.action.u.mesh_action.action_code ==
> -			WLAN_MESH_ACTION_HWMP_PATH_SELECTION);
> +	return mgmt->u.action.action_code == WLAN_MESH_ACTION_HWMP_PATH_SELECTION;
>  }
>  
>  void ieee80211s_init(void)
> @@ -1619,13 +1618,12 @@ static void mesh_rx_csa_frame(struct ieee80211_sub_if_data *sdata,
>  	size_t baselen;
>  	u8 *pos;
>  
> -	if (mgmt->u.action.u.measurement.action_code !=
> -	    WLAN_ACTION_SPCT_CHL_SWITCH)
> +	if (mgmt->u.action.action_code != WLAN_ACTION_SPCT_CHL_SWITCH)
>  		return;
>  
> -	pos = mgmt->u.action.u.chan_switch.variable;
> +	pos = mgmt->u.action.chan_switch.variable;
>  	baselen = offsetof(struct ieee80211_mgmt,
> -			   u.action.u.chan_switch.variable);
> +			   u.action.chan_switch.variable);
Ditto
>  	elems = ieee802_11_parse_elems(pos, len - baselen,
>  				       IEEE80211_FTYPE_MGMT |
>  				       IEEE80211_STYPE_ACTION,
> @@ -1668,7 +1666,7 @@ static void ieee80211_mesh_rx_mgmt_action(struct ieee80211_sub_if_data *sdata,
>  {
>  	switch (mgmt->u.action.category) {
>  	case WLAN_CATEGORY_SELF_PROTECTED:
> -		switch (mgmt->u.action.u.self_prot.action_code) {
> +		switch (mgmt->u.action.action_code) {
>  		case WLAN_SP_MESH_PEERING_OPEN:
>  		case WLAN_SP_MESH_PEERING_CLOSE:
>  		case WLAN_SP_MESH_PEERING_CONFIRM:
> diff --git a/net/mac80211/mesh_hwmp.c b/net/mac80211/mesh_hwmp.c
> index a41b57bd11ff..dad311e0833a 100644
> --- a/net/mac80211/mesh_hwmp.c
> +++ b/net/mac80211/mesh_hwmp.c
> @@ -1,7 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /*
>   * Copyright (c) 2008, 2009 open80211s Ltd.
> - * Copyright (C) 2019, 2021-2023, 2025 Intel Corporation
> + * Copyright (C) 2019, 2021-2023, 2025-2026 Intel Corporation
>   * Author:     Luis Carlos Cobo <luisca@cozybit.com>
>   */
>  
> @@ -105,12 +105,11 @@ static int mesh_path_sel_frame_tx(enum mpath_frame_type action, u8 flags,
>  				  u32 lifetime, u32 metric, u32 preq_id,
>  				  struct ieee80211_sub_if_data *sdata)
>  {
> +	int hdr_len = IEEE80211_MIN_ACTION_SIZE(mesh_action);
>  	struct ieee80211_local *local = sdata->local;
>  	struct sk_buff *skb;
>  	struct ieee80211_mgmt *mgmt;
>  	u8 *pos, ie_len;
> -	int hdr_len = offsetofend(struct ieee80211_mgmt,
> -				  u.action.u.mesh_action);
>  
>  	skb = dev_alloc_skb(local->tx_headroom +
>  			    hdr_len +
> @@ -127,8 +126,7 @@ static int mesh_path_sel_frame_tx(enum mpath_frame_type action, u8 flags,
>  	/* BSSID == SA */
>  	memcpy(mgmt->bssid, sdata->vif.addr, ETH_ALEN);
>  	mgmt->u.action.category = WLAN_CATEGORY_MESH_ACTION;
> -	mgmt->u.action.u.mesh_action.action_code =
> -					WLAN_MESH_ACTION_HWMP_PATH_SELECTION;
> +	mgmt->u.action.action_code = WLAN_MESH_ACTION_HWMP_PATH_SELECTION;
>  
>  	switch (action) {
>  	case MPATH_PREQ:
> @@ -237,13 +235,12 @@ int mesh_path_error_tx(struct ieee80211_sub_if_data *sdata,
>  		       u8 ttl, const u8 *target, u32 target_sn,
>  		       u16 target_rcode, const u8 *ra)
>  {
> +	int hdr_len = IEEE80211_MIN_ACTION_SIZE(mesh_action);
>  	struct ieee80211_local *local = sdata->local;
>  	struct sk_buff *skb;
>  	struct ieee80211_if_mesh *ifmsh = &sdata->u.mesh;
>  	struct ieee80211_mgmt *mgmt;
>  	u8 *pos, ie_len;
> -	int hdr_len = offsetofend(struct ieee80211_mgmt,
> -				  u.action.u.mesh_action);
>  
>  	if (time_before(jiffies, ifmsh->next_perr))
>  		return -EAGAIN;
> @@ -265,8 +262,7 @@ int mesh_path_error_tx(struct ieee80211_sub_if_data *sdata,
>  	/* BSSID == SA */
>  	memcpy(mgmt->bssid, sdata->vif.addr, ETH_ALEN);
>  	mgmt->u.action.category = WLAN_CATEGORY_MESH_ACTION;
> -	mgmt->u.action.u.mesh_action.action_code =
> -					WLAN_MESH_ACTION_HWMP_PATH_SELECTION;
> +	mgmt->u.action.action_code = WLAN_MESH_ACTION_HWMP_PATH_SELECTION;
>  	ie_len = 15;
>  	pos = skb_put(skb, 2 + ie_len);
>  	*pos++ = WLAN_EID_PERR;
> @@ -938,7 +934,7 @@ void mesh_rx_path_sel_frame(struct ieee80211_sub_if_data *sdata,
>  	struct sta_info *sta;
>  
>  	/* need action_code */
> -	if (len < IEEE80211_MIN_ACTION_SIZE + 1)
> +	if (len < IEEE80211_MIN_ACTION_SIZE(mesh_action))
>  		return;
>  
>  	rcu_read_lock();
> @@ -949,8 +945,8 @@ void mesh_rx_path_sel_frame(struct ieee80211_sub_if_data *sdata,
>  	}
>  	rcu_read_unlock();
>  
> -	baselen = (u8 *) mgmt->u.action.u.mesh_action.variable - (u8 *) mgmt;
> -	elems = ieee802_11_parse_elems(mgmt->u.action.u.mesh_action.variable,
> +	baselen = mgmt->u.action.mesh_action.variable - (u8 *)mgmt;
Another equivalent to `IEEE80211_MIN_ACTION_SIZE(type)`
> +	elems = ieee802_11_parse_elems(mgmt->u.action.mesh_action.variable,
>  				       len - baselen,
>  				       IEEE80211_FTYPE_MGMT |
>  				       IEEE80211_STYPE_ACTION,
> diff --git a/net/mac80211/mesh_plink.c b/net/mac80211/mesh_plink.c
> index 04c931cd2063..7d823a55636f 100644
> --- a/net/mac80211/mesh_plink.c
> +++ b/net/mac80211/mesh_plink.c
> @@ -1,7 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /*
>   * Copyright (c) 2008, 2009 open80211s Ltd.
> - * Copyright (C) 2019, 2021-2025 Intel Corporation
> + * Copyright (C) 2019, 2021-2026 Intel Corporation
>   * Author:     Luis Carlos Cobo <luisca@cozybit.com>
>   */
>  #include <linux/gfp.h>
> @@ -13,7 +13,7 @@
>  #include "rate.h"
>  #include "mesh.h"
>  
> -#define PLINK_CNF_AID(mgmt) ((mgmt)->u.action.u.self_prot.variable + 2)
> +#define PLINK_CNF_AID(mgmt) ((mgmt)->u.action.self_prot.variable + 2)
>  #define PLINK_GET_LLID(p) (p + 2)
>  #define PLINK_GET_PLID(p) (p + 4)
>  
> @@ -215,6 +215,7 @@ static int mesh_plink_frame_tx(struct ieee80211_sub_if_data *sdata,
>  			       enum ieee80211_self_protected_actioncode action,
>  			       u8 *da, u16 llid, u16 plid, u16 reason)
>  {
> +	int hdr_len = IEEE80211_MIN_ACTION_SIZE(self_prot);
>  	struct ieee80211_local *local = sdata->local;
>  	struct sk_buff *skb;
>  	struct ieee80211_tx_info *info;
> @@ -223,7 +224,6 @@ static int mesh_plink_frame_tx(struct ieee80211_sub_if_data *sdata,
>  	u16 peering_proto = 0;
>  	u8 *pos, ie_len = 4;
>  	u8 ie_len_he_cap, ie_len_eht_cap;
> -	int hdr_len = offsetofend(struct ieee80211_mgmt, u.action.u.self_prot);
>  	int err = -ENOMEM;
>  
>  	ie_len_he_cap = ieee80211_ie_len_he_cap(sdata);
> @@ -260,7 +260,7 @@ static int mesh_plink_frame_tx(struct ieee80211_sub_if_data *sdata,
>  	memcpy(mgmt->sa, sdata->vif.addr, ETH_ALEN);
>  	memcpy(mgmt->bssid, sdata->vif.addr, ETH_ALEN);
>  	mgmt->u.action.category = WLAN_CATEGORY_SELF_PROTECTED;
> -	mgmt->u.action.u.self_prot.action_code = action;
> +	mgmt->u.action.action_code = action;
>  
>  	if (action != WLAN_SP_MESH_PEERING_CLOSE) {
>  		struct ieee80211_supported_band *sband;
> @@ -1141,7 +1141,7 @@ mesh_process_plink_frame(struct ieee80211_sub_if_data *sdata,
>  		return;
>  	}
>  
> -	ftype = mgmt->u.action.u.self_prot.action_code;
> +	ftype = mgmt->u.action.action_code;
>  	if ((ftype == WLAN_SP_MESH_PEERING_OPEN && ie_len != 4) ||
>  	    (ftype == WLAN_SP_MESH_PEERING_CONFIRM && ie_len != 6) ||
>  	    (ftype == WLAN_SP_MESH_PEERING_CLOSE && ie_len != 6
> @@ -1224,8 +1224,8 @@ void mesh_rx_plink_frame(struct ieee80211_sub_if_data *sdata,
>  	size_t baselen;
>  	u8 *baseaddr;
>  
> -	/* need action_code, aux */
> -	if (len < IEEE80211_MIN_ACTION_SIZE + 3)
> +	/* need aux */
> +	if (len < IEEE80211_MIN_ACTION_SIZE(self_prot) + 1)
>  		return;
>  
>  	if (sdata->u.mesh.user_mpm)
> @@ -1238,10 +1238,9 @@ void mesh_rx_plink_frame(struct ieee80211_sub_if_data *sdata,
>  		return;
>  	}
>  
> -	baseaddr = mgmt->u.action.u.self_prot.variable;
> -	baselen = (u8 *) mgmt->u.action.u.self_prot.variable - (u8 *) mgmt;
> -	if (mgmt->u.action.u.self_prot.action_code ==
> -						WLAN_SP_MESH_PEERING_CONFIRM) {
> +	baseaddr = mgmt->u.action.self_prot.variable;
> +	baselen = mgmt->u.action.self_prot.variable - (u8 *)mgmt;
Ditto
> +	if (mgmt->u.action.action_code == WLAN_SP_MESH_PEERING_CONFIRM) {
>  		baseaddr += 4;
>  		baselen += 4;
>  
> diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
> index e83582b2c377..995855d49822 100644
> --- a/net/mac80211/mlme.c
> +++ b/net/mac80211/mlme.c
> @@ -7897,7 +7897,7 @@ ieee80211_send_neg_ttlm_req(struct ieee80211_sub_if_data *sdata,
>  	struct ieee80211_local *local = sdata->local;
>  	struct ieee80211_mgmt *mgmt;
>  	struct sk_buff *skb;
> -	int hdr_len = offsetofend(struct ieee80211_mgmt, u.action.u.ttlm_req);
> +	int hdr_len = IEEE80211_MIN_ACTION_SIZE(ttlm_req);
>  	int ttlm_max_len = 2 + 1 + sizeof(struct ieee80211_ttlm_elem) + 1 +
>  		2 * 2 * IEEE80211_TTLM_NUM_TIDS;
>  
> @@ -7914,9 +7914,8 @@ ieee80211_send_neg_ttlm_req(struct ieee80211_sub_if_data *sdata,
>  	memcpy(mgmt->bssid, sdata->vif.cfg.ap_addr, ETH_ALEN);
>  
>  	mgmt->u.action.category = WLAN_CATEGORY_PROTECTED_EHT;
> -	mgmt->u.action.u.ttlm_req.action_code =
> -		WLAN_PROTECTED_EHT_ACTION_TTLM_REQ;
> -	mgmt->u.action.u.ttlm_req.dialog_token = dialog_token;
> +	mgmt->u.action.action_code = WLAN_PROTECTED_EHT_ACTION_TTLM_REQ;
> +	mgmt->u.action.ttlm_req.dialog_token = dialog_token;
>  	ieee80211_neg_ttlm_add_suggested_map(skb, neg_ttlm);
>  	ieee80211_tx_skb(sdata, skb);
>  }
> @@ -7966,7 +7965,7 @@ ieee80211_send_neg_ttlm_res(struct ieee80211_sub_if_data *sdata,
>  	struct ieee80211_local *local = sdata->local;
>  	struct ieee80211_mgmt *mgmt;
>  	struct sk_buff *skb;
> -	int hdr_len = offsetofend(struct ieee80211_mgmt, u.action.u.ttlm_res);
> +	int hdr_len = IEEE80211_MIN_ACTION_SIZE(ttlm_res);
>  	int ttlm_max_len = 2 + 1 + sizeof(struct ieee80211_ttlm_elem) + 1 +
>  		2 * 2 * IEEE80211_TTLM_NUM_TIDS;
>  	u16 status_code;
> @@ -7984,9 +7983,8 @@ ieee80211_send_neg_ttlm_res(struct ieee80211_sub_if_data *sdata,
>  	memcpy(mgmt->bssid, sdata->vif.cfg.ap_addr, ETH_ALEN);
>  
>  	mgmt->u.action.category = WLAN_CATEGORY_PROTECTED_EHT;
> -	mgmt->u.action.u.ttlm_res.action_code =
> -		WLAN_PROTECTED_EHT_ACTION_TTLM_RES;
> -	mgmt->u.action.u.ttlm_res.dialog_token = dialog_token;
> +	mgmt->u.action.action_code = WLAN_PROTECTED_EHT_ACTION_TTLM_RES;
> +	mgmt->u.action.ttlm_res.dialog_token = dialog_token;
>  	switch (ttlm_res) {
>  	default:
>  		WARN_ON(1);
> @@ -8003,7 +8001,7 @@ ieee80211_send_neg_ttlm_res(struct ieee80211_sub_if_data *sdata,
>  		break;
>  	}
>  
> -	mgmt->u.action.u.ttlm_res.status_code = cpu_to_le16(status_code);
> +	mgmt->u.action.ttlm_res.status_code = cpu_to_le16(status_code);
>  	ieee80211_tx_skb(sdata, skb);
>  }
>  
> @@ -8103,10 +8101,9 @@ void ieee80211_process_neg_ttlm_req(struct ieee80211_sub_if_data *sdata,
>  	if (!ieee80211_vif_is_mld(&sdata->vif))
>  		return;
>  
> -	dialog_token = mgmt->u.action.u.ttlm_req.dialog_token;
> -	ies_len  = len - offsetof(struct ieee80211_mgmt,
> -				  u.action.u.ttlm_req.variable);
> -	elems = ieee802_11_parse_elems(mgmt->u.action.u.ttlm_req.variable,
> +	dialog_token = mgmt->u.action.ttlm_req.dialog_token;
> +	ies_len  = len - IEEE80211_MIN_ACTION_SIZE(ttlm_req);
Here you did it :)
> +	elems = ieee802_11_parse_elems(mgmt->u.action.ttlm_req.variable,
>  				       ies_len,
>  				       IEEE80211_FTYPE_MGMT |
>  				       IEEE80211_STYPE_ACTION,
> @@ -8157,8 +8154,7 @@ void ieee80211_process_neg_ttlm_res(struct ieee80211_sub_if_data *sdata,
>  				    struct ieee80211_mgmt *mgmt, size_t len)
>  {
>  	if (!ieee80211_vif_is_mld(&sdata->vif) ||
> -	    mgmt->u.action.u.ttlm_req.dialog_token !=
> -	    sdata->u.mgd.dialog_token_alloc)
> +	    mgmt->u.action.ttlm_res.dialog_token != sdata->u.mgd.dialog_token_alloc)
>  		return;
>  
>  	wiphy_delayed_work_cancel(sdata->local->hw.wiphy,
> @@ -8172,7 +8168,7 @@ void ieee80211_process_neg_ttlm_res(struct ieee80211_sub_if_data *sdata,
>  	 * This can be better implemented in the future, to handle request
>  	 * rejections.
>  	 */
> -	if (le16_to_cpu(mgmt->u.action.u.ttlm_res.status_code) != WLAN_STATUS_SUCCESS)
> +	if (le16_to_cpu(mgmt->u.action.ttlm_res.status_code) != WLAN_STATUS_SUCCESS)
>  		__ieee80211_disconnect(sdata);
>  }
>  
> @@ -8205,12 +8201,11 @@ static void ieee80211_teardown_ttlm_work(struct wiphy *wiphy,
>  
>  void ieee80211_send_teardown_neg_ttlm(struct ieee80211_vif *vif)
>  {
> +	int frame_len = IEEE80211_MIN_ACTION_SIZE(ttlm_tear_down);
>  	struct ieee80211_sub_if_data *sdata = vif_to_sdata(vif);
>  	struct ieee80211_local *local = sdata->local;
>  	struct ieee80211_mgmt *mgmt;
>  	struct sk_buff *skb;
> -	int frame_len = offsetofend(struct ieee80211_mgmt,
> -				  u.action.u.ttlm_tear_down);
>  	struct ieee80211_tx_info *info;
>  
>  	skb = dev_alloc_skb(local->hw.extra_tx_headroom + frame_len);
> @@ -8226,8 +8221,7 @@ void ieee80211_send_teardown_neg_ttlm(struct ieee80211_vif *vif)
>  	memcpy(mgmt->bssid, sdata->vif.cfg.ap_addr, ETH_ALEN);
>  
>  	mgmt->u.action.category = WLAN_CATEGORY_PROTECTED_EHT;
> -	mgmt->u.action.u.ttlm_tear_down.action_code =
> -		WLAN_PROTECTED_EHT_ACTION_TTLM_TEARDOWN;
> +	mgmt->u.action.action_code = WLAN_PROTECTED_EHT_ACTION_TTLM_TEARDOWN;
>  
>  	info = IEEE80211_SKB_CB(skb);
>  	info->flags |= IEEE80211_TX_CTL_REQ_TX_STATUS;
> @@ -8310,13 +8304,13 @@ void ieee80211_sta_rx_queued_mgmt(struct ieee80211_sub_if_data *sdata,
>  		case WLAN_CATEGORY_SPECTRUM_MGMT:
>  			ies_len = skb->len -
>  				  offsetof(struct ieee80211_mgmt,
> -					   u.action.u.chan_switch.variable);
> +					   u.action.chan_switch.variable);
Ditto
>  
>  			if (ies_len < 0)
>  				break;
>  
>  			/* CSA IE cannot be overridden, no need for BSSID */
> -			elems = ieee802_11_parse_elems(mgmt->u.action.u.chan_switch.variable,
> +			elems = ieee802_11_parse_elems(mgmt->u.action.chan_switch.variable,
>  						       ies_len,
>  						       IEEE80211_FTYPE_MGMT |
>  						       IEEE80211_STYPE_ACTION,
> @@ -8338,7 +8332,7 @@ void ieee80211_sta_rx_queued_mgmt(struct ieee80211_sub_if_data *sdata,
>  		case WLAN_CATEGORY_PROTECTED_DUAL_OF_ACTION:
>  			ies_len = skb->len -
>  				  offsetof(struct ieee80211_mgmt,
> -					   u.action.u.ext_chan_switch.variable);
> +					   u.action.ext_chan_switch.variable);
Ditto
>  
>  			if (ies_len < 0)
>  				break;
> @@ -8347,7 +8341,7 @@ void ieee80211_sta_rx_queued_mgmt(struct ieee80211_sub_if_data *sdata,
>  			 * extended CSA IE can't be overridden, no need for
>  			 * BSSID
>  			 */
> -			elems = ieee802_11_parse_elems(mgmt->u.action.u.ext_chan_switch.variable,
> +			elems = ieee802_11_parse_elems(mgmt->u.action.ext_chan_switch.variable,
>  						       ies_len,
>  						       IEEE80211_FTYPE_MGMT |
>  						       IEEE80211_STYPE_ACTION,
> @@ -8364,7 +8358,7 @@ void ieee80211_sta_rx_queued_mgmt(struct ieee80211_sub_if_data *sdata,
>  
>  				/* for the handling code pretend it was an IE */
>  				elems->ext_chansw_ie =
> -					&mgmt->u.action.u.ext_chan_switch.data;
> +					&mgmt->u.action.ext_chan_switch.data;
>  
>  				ieee80211_sta_process_chanswitch(link,
>  								 rx_status->mactime,
> @@ -10356,25 +10350,25 @@ void ieee80211_process_ml_reconf_resp(struct ieee80211_sub_if_data *sdata,
>  	u8 *pos;
>  
>  	if (!ieee80211_vif_is_mld(&sdata->vif) ||
> -	    len < offsetofend(typeof(*mgmt), u.action.u.ml_reconf_resp) ||
> -	    mgmt->u.action.u.ml_reconf_resp.dialog_token !=
> -	    sdata->u.mgd.reconf.dialog_token ||
> +	    len < IEEE80211_MIN_ACTION_SIZE(ml_reconf_resp) ||
> +	    mgmt->u.action.ml_reconf_resp.dialog_token !=
> +		sdata->u.mgd.reconf.dialog_token ||
>  	    !sta_changed_links)
>  		return;
>  
> -	pos = mgmt->u.action.u.ml_reconf_resp.variable;
> -	len -= offsetofend(typeof(*mgmt), u.action.u.ml_reconf_resp);
> +	pos = mgmt->u.action.ml_reconf_resp.variable;
> +	len -= offsetofend(typeof(*mgmt), u.action.ml_reconf_resp);
`len -= IEEE80211_MIN_ACTION_SIZE(ml_reconf_resp);`

[...]

Pablo MG

