Return-Path: <linux-wireless+bounces-31817-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oJ0GAgk3j2n2MgEAu9opvQ
	(envelope-from <linux-wireless+bounces-31817-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Feb 2026 15:36:57 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 676451371D1
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Feb 2026 15:36:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5E6A0303E757
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Feb 2026 14:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E62136075E;
	Fri, 13 Feb 2026 14:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b="ogFZYxNQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251A236164E
	for <linux-wireless@vger.kernel.org>; Fri, 13 Feb 2026 14:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770993414; cv=none; b=COH82rZ+cL/4DUMHYalWhfPx7bKtBgXGIkFDHAGRn7e5dFisLoKio1CcL2otiYvMl+KU4TrSo7k3qiXFUcHArpegd/tUlwonQEZwEcO2eVFOVIjZM77wmx/jNz2ZYbteipotHFmKwbFUyVODI9qyQ8P3NaQfIzrZnNklIwcX+D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770993414; c=relaxed/simple;
	bh=mM4oCAgsNZ/wsfVoecYKcLvn1UsDBE+8S+WvGvwmBfk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RP6Usr/uBKumNKpeMI60VNuFwN6aDuymKwPXz5rNOizdVrjIE7A2An/mkL6jzR/GAPG3+WvAW+8hM38r0SzfLpi8In0Ek5HkLVXuwx7k+ky1nq5Iy6wRfUxDzyVKrp3gZjOMhmA07BE3wRfB855fKeobMUEOkR4s3/DDPePHRYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr; spf=pass smtp.mailfrom=freebox.fr; dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b=ogFZYxNQ; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freebox.fr
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-482f454be5bso30250835e9.0
        for <linux-wireless@vger.kernel.org>; Fri, 13 Feb 2026 06:36:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=freebox-fr.20230601.gappssmtp.com; s=20230601; t=1770993409; x=1771598209; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Pwnjdk/EpFtVilyv396Zg4GuaP+kgL1WguDKKzHZSNg=;
        b=ogFZYxNQUns2y2wBczeFPYyOpfJbg4ETdu/3Sizvd/UzERZ6sg0MGA3qLDR6n25dfg
         ex07tksmk3xDMvxPNkpDGcXvbHRDE4imhN3P5uC0UI9nkeqQNoqNvhfpjHEOARpDL0T+
         FamxzERZvrJj7l1yKSrM+u7rbLz7cLva5UWD7ugPbv1mx+Apk3BEKZSMUYyp1hpbGyfv
         +Cn+zteYxbRe2oARi7i+Ffuwdp8lnv9mnfOkL+8p1eI5gFA2FfLCcGmzRMt0OOenaoNw
         0xGF/eNd+xLbLJSNpu4FP19baCZzgoITONmrySe5Cpy1XnclP3I/9aEffsLQDZ/W+LKS
         C1qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770993409; x=1771598209;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pwnjdk/EpFtVilyv396Zg4GuaP+kgL1WguDKKzHZSNg=;
        b=J2oKoclhqVVBfSDY4sFeC7pQUeYmXRtc6OuZwmdIWqrYKYCwaZ0ScZc5n3jRoQctBb
         iAYYoTOcXWxR5U3Ng+GSFsJ3+mvSlEx40jqcDB5qb8wVANXfecGvEmG7tOHaIrP7WM/2
         HyalycHOXLarG5aCywUG07KtsEgEGrwSL2kzT0nlaL3XrOFV6/N25Jvxenb+Y4UW2x2y
         z2WnDU3inN/BqMmAIPZg2KiAasmRZmWKAZyj+/gzzbkkS5cPc/mTfqjDFWfi+K/8undq
         xKhJLrB8akmbFEYzcIB9nQqjDcO+RJwhPEGFeDHuYVWazsRZUfI6QhhPmMQveGKNRbht
         uJag==
X-Gm-Message-State: AOJu0YwyS6wzm8aKx6s1uEkRduG1D4doJ4W/vvAXu1RepFWNSE34NtpH
	2i0Ba/Hhr3hxWIjBD4t7N1twcwVsBIrQyWP4iBNBid1XwspePzmT7Z3W3y+4NQrSuGummNqFIXu
	AI66s
X-Gm-Gg: AZuq6aLXsyX4JiridXIPwHPTdyyv92SCLbhL1qcZQ5viNwykOhx1s05z64b39voxBWW
	USx7nQUm2IapnDBDT0v1zWap98mMHQS8Bvfvk+O/HE//fO/EIDhO45+dIARNhbzvaGYz5BZ3xJk
	RT3bnpgwr84jiw3Ymd8Q1+v3yJ3NiG7NsiSea2BPj+TQW5GwXVweSZ75U3KJLI3tRQB9qyi+VgC
	HwSxaAwPLKAt+lFnlXY5gQIlHwngho1goMt8Z47QBohf56htVaEl6BSR1NI2RfQpyNP8GRaX5Dv
	p1ZMXkWkHQAUapGsjl8ypQM7+zpujZl5poMD5CBBTorFPu+s6C71xRNsCe2rrl/pAJEofWxyv92
	qVWfE9xopUZitoI8WuDWKr0Fu1ggibm2M9D5HGVt35re1lF682x+PKUwGxK0e/F2oMJis5OfWoI
	kaJqWBqkkCYYBm/lHHZMCYzrycXb51wsQIqe7ytQxql5at2h7jzUhI8A==
X-Received: by 2002:a05:600c:5251:b0:47e:e2b8:66e6 with SMTP id 5b1f17b1804b1-48378da3e01mr5240985e9.14.1770993409176;
        Fri, 13 Feb 2026 06:36:49 -0800 (PST)
Received: from [192.168.108.101] (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4834d82a4afsm482419145e9.11.2026.02.13.06.36.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Feb 2026 06:36:48 -0800 (PST)
Message-ID: <4dcf82f8-21c1-4704-8575-7f526ce1c77f@freebox.fr>
Date: Fri, 13 Feb 2026 15:36:48 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next v3 2/2] wifi: mac80211_hwsim: Add UHR
 capabilities to the driver
To: Karthikeyan Kathirvel <karthikeyan.kathirvel@oss.qualcomm.com>,
 johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org
References: <20260212180128.257565-1-karthikeyan.kathirvel@oss.qualcomm.com>
 <20260212180128.257565-3-karthikeyan.kathirvel@oss.qualcomm.com>
Content-Language: en-US
From: Pablo MARTIN-GOMEZ <pmartin-gomez@freebox.fr>
In-Reply-To: <20260212180128.257565-3-karthikeyan.kathirvel@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[freebox-fr.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31817-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[freebox-fr.20230601.gappssmtp.com:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[freebox.fr];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pmartin-gomez@freebox.fr,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:email,freebox-fr.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 676451371D1
X-Rspamd-Action: no action

Hello,
On 12/02/2026 19:01, Karthikeyan Kathirvel wrote:
> Add UHR capabilities for bringing up the interface in UHR mode.
> This is required to validate UHR test cases.
>
> Signed-off-by: Karthikeyan Kathirvel <karthikeyan.kathirvel@oss.qualcomm.com>
> ---
>   drivers/net/wireless/virtual/mac80211_hwsim.c | 285 ++++++++++++++++++
>   1 file changed, 285 insertions(+)
>
> diff --git a/drivers/net/wireless/virtual/mac80211_hwsim.c b/drivers/net/wireless/virtual/mac80211_hwsim.c
> index 4d9f5f87e814..5a576bbb7688 100644
> --- a/drivers/net/wireless/virtual/mac80211_hwsim.c
> +++ b/drivers/net/wireless/virtual/mac80211_hwsim.c
> @@ -4478,6 +4478,49 @@ static const struct ieee80211_sband_iftype_data sband_capa_2ghz[] = {
>   			},
>   			/* PPE threshold information is not supported */
>   		},
> +		.uhr_cap = {
> +			.has_uhr = true,
> +			.mac = {
> +				.mac_cap[0] =
> +					IEEE80211_UHR_MAC_CAP0_DPS_SUPP |
> +					IEEE80211_UHR_MAC_CAP0_DPS_ASSIST_SUPP |
> +					IEEE80211_UHR_MAC_CAP0_DPS_AP_STATIC_HCM_SUPP |
> +					IEEE80211_UHR_MAC_CAP0_NPCA_SUPP |
> +					IEEE80211_UHR_MAC_CAP0_ENH_BSR_SUPP |
> +					IEEE80211_UHR_MAC_CAP0_ADD_MAP_TID_SUPP |
> +					IEEE80211_UHR_MAC_CAP0_EOTSP_SUPP,
> +				.mac_cap[1] =
> +					IEEE80211_UHR_MAC_CAP1_DSO_SUPP |
> +					IEEE80211_UHR_MAC_CAP1_PEDCA_SUPP |
> +					IEEE80211_UHR_MAC_CAP1_UL_LLI_SUPP |
> +					IEEE80211_UHR_MAC_CAP1_P2P_LLI_SUPP |
> +					IEEE80211_UHR_MAC_CAP1_PUO_SUPP |
> +					IEEE80211_UHR_MAC_CAP1_AP_PUO_SUPP |
> +					IEEE80211_UHR_MAC_CAP1_DUO_SUPP,
> +				.mac_cap[2] =
> +					IEEE80211_UHR_MAC_CAP2_OMC_UL_MU_DIS_RX_SUPP |
> +					IEEE80211_UHR_MAC_CAP2_AOM_SUPP |
> +					IEEE80211_UHR_MAC_CAP2_IFCS_LOC_SUPP |
> +					IEEE80211_UHR_MAC_CAP2_UHR_TRS_SUPP |
> +					IEEE80211_UHR_MAC_CAP2_TXSPG_SUPP |
> +					IEEE80211_UHR_MAC_CAP2_TXOP_RET_IN_TXSPG |
> +					IEEE80211_UHR_MAC_CAP2_UHR_OM_PU_TO_LOW,
> +				.mac_cap[3] =
> +					IEEE80211_UHR_MAC_CAP3_UHR_OM_PU_TO_HIGH |
> +					IEEE80211_UHR_MAC_CAP3_PARAM_UPD_ADV_NOTIF_INTV |
> +					IEEE80211_UHR_MAC_CAP3_UPD_IND_TIM_INTV_LOW,
> +				.mac_cap[4] =
> +					IEEE80211_UHR_MAC_CAP4_UPD_IND_TIM_INTV_HIGH |
> +					IEEE80211_UHR_MAC_CAP4_BOUNDED_ESS |
> +					IEEE80211_UHR_MAC_CAP4_BTM_ASSURANCE |
> +					IEEE80211_UHR_MAC_CAP4_CO_BF_SUPP,
> +			},
> +			.phy = {
> +				.cap =
> +					IEEE80211_UHR_PHY_CAP_ELR_RX |
> +					IEEE80211_UHR_PHY_CAP_ELR_TX,

`IEEE80211_UHR_PHY_CAP_MAX_NSS_RX_SND_NDP_LE80` and `IEEE80211_UHR_PHY_CAP_MAX_NSS_RX_DL_MU_LE80` are for 80MHz and lower, it should include 20/40 MHz of 2.4 GHz, no?

> +			},
> +		},
>   	},
>   	{
>   		.types_mask = BIT(NL80211_IFTYPE_AP) |
> @@ -4586,6 +4629,50 @@ static const struct ieee80211_sband_iftype_data sband_capa_2ghz[] = {
>   			},
>   			/* PPE threshold information is not supported */
>   		},
> +		.uhr_cap = {
> +			.has_uhr = true,
> +			.mac = {
> +				.mac_cap[0] =
> +					IEEE80211_UHR_MAC_CAP0_DPS_SUPP |
> +					IEEE80211_UHR_MAC_CAP0_DPS_ASSIST_SUPP |
> +					IEEE80211_UHR_MAC_CAP0_DPS_AP_STATIC_HCM_SUPP |
> +					IEEE80211_UHR_MAC_CAP0_NPCA_SUPP |
> +					IEEE80211_UHR_MAC_CAP0_ENH_BSR_SUPP |
> +					IEEE80211_UHR_MAC_CAP0_ADD_MAP_TID_SUPP |
> +					IEEE80211_UHR_MAC_CAP0_EOTSP_SUPP,
> +				.mac_cap[1] =
> +					IEEE80211_UHR_MAC_CAP1_DSO_SUPP |
> +					IEEE80211_UHR_MAC_CAP1_PEDCA_SUPP |
> +					IEEE80211_UHR_MAC_CAP1_DBE_SUPP |
> +					IEEE80211_UHR_MAC_CAP1_UL_LLI_SUPP |
> +					IEEE80211_UHR_MAC_CAP1_P2P_LLI_SUPP |
> +					IEEE80211_UHR_MAC_CAP1_PUO_SUPP |
> +					IEEE80211_UHR_MAC_CAP1_AP_PUO_SUPP |
> +					IEEE80211_UHR_MAC_CAP1_DUO_SUPP,
> +				.mac_cap[2] =
> +					IEEE80211_UHR_MAC_CAP2_OMC_UL_MU_DIS_RX_SUPP |
> +					IEEE80211_UHR_MAC_CAP2_AOM_SUPP |
> +					IEEE80211_UHR_MAC_CAP2_IFCS_LOC_SUPP |
> +					IEEE80211_UHR_MAC_CAP2_UHR_TRS_SUPP |
> +					IEEE80211_UHR_MAC_CAP2_TXSPG_SUPP |
> +					IEEE80211_UHR_MAC_CAP2_TXOP_RET_IN_TXSPG |
> +					IEEE80211_UHR_MAC_CAP2_UHR_OM_PU_TO_LOW,
> +				.mac_cap[3] =
> +					IEEE80211_UHR_MAC_CAP3_UHR_OM_PU_TO_HIGH |
> +					IEEE80211_UHR_MAC_CAP3_PARAM_UPD_ADV_NOTIF_INTV |
> +					IEEE80211_UHR_MAC_CAP3_UPD_IND_TIM_INTV_LOW,
> +				.mac_cap[4] =
> +					IEEE80211_UHR_MAC_CAP4_UPD_IND_TIM_INTV_HIGH |
> +					IEEE80211_UHR_MAC_CAP4_BOUNDED_ESS |
> +					IEEE80211_UHR_MAC_CAP4_BTM_ASSURANCE |
> +					IEEE80211_UHR_MAC_CAP4_CO_BF_SUPP,
> +			},
> +			.phy = {
> +				.cap =
> +					IEEE80211_UHR_PHY_CAP_ELR_RX |
> +					IEEE80211_UHR_PHY_CAP_ELR_TX,
Same
> +			},
> +		},
>   	},
>   #ifdef CONFIG_MAC80211_MESH
>   	{
> @@ -4755,6 +4842,55 @@ static const struct ieee80211_sband_iftype_data sband_capa_5ghz[] = {
>   			},
>   			/* PPE threshold information is not supported */
>   		},
> +		.uhr_cap = {
> +			.has_uhr = true,
> +			.mac = {
> +				.mac_cap[0] =
> +					IEEE80211_UHR_MAC_CAP0_DPS_SUPP |
> +					IEEE80211_UHR_MAC_CAP0_DPS_ASSIST_SUPP |
> +					IEEE80211_UHR_MAC_CAP0_DPS_AP_STATIC_HCM_SUPP |
> +					IEEE80211_UHR_MAC_CAP0_NPCA_SUPP |
> +					IEEE80211_UHR_MAC_CAP0_ENH_BSR_SUPP |
> +					IEEE80211_UHR_MAC_CAP0_ADD_MAP_TID_SUPP |
> +					IEEE80211_UHR_MAC_CAP0_EOTSP_SUPP,
> +				.mac_cap[1] =
> +					IEEE80211_UHR_MAC_CAP1_DSO_SUPP |
> +					IEEE80211_UHR_MAC_CAP1_PEDCA_SUPP |
> +					IEEE80211_UHR_MAC_CAP1_UL_LLI_SUPP |
> +					IEEE80211_UHR_MAC_CAP1_P2P_LLI_SUPP |
> +					IEEE80211_UHR_MAC_CAP1_PUO_SUPP |
> +					IEEE80211_UHR_MAC_CAP1_AP_PUO_SUPP |
> +					IEEE80211_UHR_MAC_CAP1_DUO_SUPP,
> +				.mac_cap[2] =
> +					IEEE80211_UHR_MAC_CAP2_OMC_UL_MU_DIS_RX_SUPP |
> +					IEEE80211_UHR_MAC_CAP2_AOM_SUPP |
> +					IEEE80211_UHR_MAC_CAP2_IFCS_LOC_SUPP |
> +					IEEE80211_UHR_MAC_CAP2_UHR_TRS_SUPP |
> +					IEEE80211_UHR_MAC_CAP2_TXSPG_SUPP |
> +					IEEE80211_UHR_MAC_CAP2_TXOP_RET_IN_TXSPG |
> +					IEEE80211_UHR_MAC_CAP2_UHR_OM_PU_TO_LOW,
> +				.mac_cap[3] =
> +					IEEE80211_UHR_MAC_CAP3_UHR_OM_PU_TO_HIGH |
> +					IEEE80211_UHR_MAC_CAP3_PARAM_UPD_ADV_NOTIF_INTV |
> +					IEEE80211_UHR_MAC_CAP3_UPD_IND_TIM_INTV_LOW,
> +				.mac_cap[4] =
> +					IEEE80211_UHR_MAC_CAP4_UPD_IND_TIM_INTV_HIGH |
> +					IEEE80211_UHR_MAC_CAP4_BOUNDED_ESS |
> +					IEEE80211_UHR_MAC_CAP4_BTM_ASSURANCE |
> +					IEEE80211_UHR_MAC_CAP4_CO_BF_SUPP,
> +			},
> +			.phy = {
> +				.cap =
> +					IEEE80211_UHR_PHY_CAP_MAX_NSS_RX_SND_NDP_LE80 |
> +					IEEE80211_UHR_PHY_CAP_MAX_NSS_RX_DL_MU_LE80 |
> +					IEEE80211_UHR_PHY_CAP_MAX_NSS_RX_SND_NDP_160 |
> +					IEEE80211_UHR_PHY_CAP_MAX_NSS_RX_DL_MU_160 |
> +					IEEE80211_UHR_PHY_CAP_MAX_NSS_RX_SND_NDP_320 |
> +					IEEE80211_UHR_PHY_CAP_MAX_NSS_RX_DL_MU_320 |
I'm not aware of an operating class that allows 320 MHz on 5 GHz (or 
even a non standard use of it), 
`IEEE80211_UHR_PHY_CAP_MAX_NSS_RX_SND_NDP_320` and 
`IEEE80211_UHR_PHY_CAP_MAX_NSS_RX_DL_MU_320` should be dropped
> +					IEEE80211_UHR_PHY_CAP_ELR_RX |
> +					IEEE80211_UHR_PHY_CAP_ELR_TX,
> +			},
> +		},
>   	},
>   	{
>   		.types_mask = BIT(NL80211_IFTYPE_AP) |
> @@ -4880,6 +5016,56 @@ static const struct ieee80211_sband_iftype_data sband_capa_5ghz[] = {
>   			},
>   			/* PPE threshold information is not supported */
>   		},
> +		.uhr_cap = {
> +			.has_uhr = true,
> +			.mac = {
> +				.mac_cap[0] =
> +					IEEE80211_UHR_MAC_CAP0_DPS_SUPP |
> +					IEEE80211_UHR_MAC_CAP0_DPS_ASSIST_SUPP |
> +					IEEE80211_UHR_MAC_CAP0_DPS_AP_STATIC_HCM_SUPP |
> +					IEEE80211_UHR_MAC_CAP0_NPCA_SUPP |
> +					IEEE80211_UHR_MAC_CAP0_ENH_BSR_SUPP |
> +					IEEE80211_UHR_MAC_CAP0_ADD_MAP_TID_SUPP |
> +					IEEE80211_UHR_MAC_CAP0_EOTSP_SUPP,
> +				.mac_cap[1] =
> +					IEEE80211_UHR_MAC_CAP1_DSO_SUPP |
> +					IEEE80211_UHR_MAC_CAP1_PEDCA_SUPP |
> +					IEEE80211_UHR_MAC_CAP1_DBE_SUPP |
> +					IEEE80211_UHR_MAC_CAP1_UL_LLI_SUPP |
> +					IEEE80211_UHR_MAC_CAP1_P2P_LLI_SUPP |
> +					IEEE80211_UHR_MAC_CAP1_PUO_SUPP |
> +					IEEE80211_UHR_MAC_CAP1_AP_PUO_SUPP |
> +					IEEE80211_UHR_MAC_CAP1_DUO_SUPP,
> +				.mac_cap[2] =
> +					IEEE80211_UHR_MAC_CAP2_OMC_UL_MU_DIS_RX_SUPP |
> +					IEEE80211_UHR_MAC_CAP2_AOM_SUPP |
> +					IEEE80211_UHR_MAC_CAP2_IFCS_LOC_SUPP |
> +					IEEE80211_UHR_MAC_CAP2_UHR_TRS_SUPP |
> +					IEEE80211_UHR_MAC_CAP2_TXSPG_SUPP |
> +					IEEE80211_UHR_MAC_CAP2_TXOP_RET_IN_TXSPG |
> +					IEEE80211_UHR_MAC_CAP2_UHR_OM_PU_TO_LOW,
> +				.mac_cap[3] =
> +					IEEE80211_UHR_MAC_CAP3_UHR_OM_PU_TO_HIGH |
> +					IEEE80211_UHR_MAC_CAP3_PARAM_UPD_ADV_NOTIF_INTV |
> +					IEEE80211_UHR_MAC_CAP3_UPD_IND_TIM_INTV_LOW,
> +				.mac_cap[4] =
> +					IEEE80211_UHR_MAC_CAP4_UPD_IND_TIM_INTV_HIGH |
> +					IEEE80211_UHR_MAC_CAP4_BOUNDED_ESS |
> +					IEEE80211_UHR_MAC_CAP4_BTM_ASSURANCE |
> +					IEEE80211_UHR_MAC_CAP4_CO_BF_SUPP,
> +			},
> +			.phy = {
> +				.cap =
> +					IEEE80211_UHR_PHY_CAP_MAX_NSS_RX_SND_NDP_LE80 |
> +					IEEE80211_UHR_PHY_CAP_MAX_NSS_RX_DL_MU_LE80 |
> +					IEEE80211_UHR_PHY_CAP_MAX_NSS_RX_SND_NDP_160 |
> +					IEEE80211_UHR_PHY_CAP_MAX_NSS_RX_DL_MU_160 |
> +					IEEE80211_UHR_PHY_CAP_MAX_NSS_RX_SND_NDP_320 |
> +					IEEE80211_UHR_PHY_CAP_MAX_NSS_RX_DL_MU_320 |

Same

[...]

Best regards,

Pablo MG


