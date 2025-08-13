Return-Path: <linux-wireless+bounces-26367-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56658B24BD2
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Aug 2025 16:27:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 092417B437A
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Aug 2025 14:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 740932E92AF;
	Wed, 13 Aug 2025 14:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b="KPfcBm+U"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0835122B8D9
	for <linux-wireless@vger.kernel.org>; Wed, 13 Aug 2025 14:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755095222; cv=none; b=PPG7bRoZY77XCXU0/zniUN0qiljSn4SmLpDFDDMGV9Zh6uXPHen1ap0VWUeiDsvZBjihskE+8cKMR37GQYho38JwFfBXRXeDwRMHX3hnUIf9O+LJE0vjmLrW5qkdBg4UZkuDEutwnP7HxC5/48s7UFvbCU6cR7hi8N+yzn8+uKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755095222; c=relaxed/simple;
	bh=/iEY3R/tKlXZ/jM/JMYUfZLfxARcB+CIBfH/1aklnlg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HQUwcTsMzyAt/2yw1756YHY5h84mTpDKiXvxeb8jHnQmdWsTpnVSxCrHDzo6LJOXVAb/oD+P6rgxCP8PaZ59piQPeHj6f7rPn1kKna5NEsLZN4UWsauqx1wA3OI9zfKeZmtM64RVEGnJeY9uqwBNi1o2cZmOaUic9gn8rEessDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr; spf=pass smtp.mailfrom=freebox.fr; dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b=KPfcBm+U; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freebox.fr
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3b8d0f1fb49so3916999f8f.2
        for <linux-wireless@vger.kernel.org>; Wed, 13 Aug 2025 07:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=freebox-fr.20230601.gappssmtp.com; s=20230601; t=1755095216; x=1755700016; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1zSLYiA6flmnAvp9VS1OwIyP1lZvOfSArros20ecrzg=;
        b=KPfcBm+UGrg6EqP7PHPV6Wb7F5ETum0bamsNzDFl87BQRxmPuFwci3C8Ef7D35hBdr
         75J4hetZ4vADY9bsn9LQKPArGHf7VUFMogGkPaPn1Q1IKhj/6JrWrsscJtCXljfi1D3A
         WHsjWANLShkLEI9Gb7lFWmX5AXwkKIOhOVChoBnunvn4INwXMa3cmXn5iT3trHOeFDh0
         WK7O71Ujtlf9IH8QMaDh8HzVw82IfEG/Y7AuV9xvUqyQKxw7gxEUddI3eVPESanIVaXn
         z/eCuEywMPjT14prtWpxfeoNi5MbcpCGxGw1yDzvX67qJaSaT/ArZeR6MfpQ4LSdDmHQ
         RP7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755095216; x=1755700016;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1zSLYiA6flmnAvp9VS1OwIyP1lZvOfSArros20ecrzg=;
        b=ZupMdFX9A56p47qI/laaDZMNKfvWzFkSliGJ9Wk94FrAaFxu/8JgwBaFqzthzgVgHB
         AERHWhzSnO3FMBpW8jn9ZZMGQ9womzp8seEuwoojgd/poOEmEjMjWVzbRpVJzF6SKqmJ
         xmB3ZYNxjzX/qfpyX+35qcyQrpAC8Zu2wbByHiHZ9NQvw2Z+qsRgKvHsxoyUfsEysFEN
         NLsgi4bGGTfTQCDQ2VN37NibrFZ8ix50e14gkZ/XSekQRRk22hS9QsR7fFM/4E+c0jNy
         kCOP6Islki3ix6KRYdhWjAGSwNJMSD8ttti0DrP/srqkNEb2OVSvvWZ6iDUei1PJ7Qfv
         8Jxg==
X-Gm-Message-State: AOJu0Yyb7wxwnk2W9MbDUOmzwCAf76UmzuMif9oCjsFNQFFgqnGeRVoQ
	mZrvCItn1ZLtMlIHuwXqkDpR6ORSR4K+UuLU870BhFEvoIK0bulpb8Qm2j2TyE2tjJcsnBMYlFJ
	IjgC6
X-Gm-Gg: ASbGnctd99v4YY9SdL1Td+di8xPSbMDnQjd8WyrLwr4tjOpGpqdyKx9Pny88jevA1Nc
	KqJant2fveK1F1kPm1mTW6G+vrrwVPqTLLDpFOhn/r/snN4QUDs0PL8s+DnBQz5XwOKS1GheyTC
	QF1fXe9Rfu5t3hk+HFoTvcmWemV+tjkl1U43uO8KXG01CVQqgtzFWVCQntKompEFwaMZpITTkCi
	RJf58wrTadnd1lmwXiwsjMjKwEMYFROyopcIj3dhX9Z5lUuLUFG4xyvbtd61j+B+QXdTTCUC2ly
	u+2RNgMz7h1FkHbGLN915jy1eKG10nT+qTw09ip04J3BoODIyQk42iCy61CNrtupyXAfDW5JpXK
	Csplw3iM4AKimVqtgISrNf8uRO7bASwFWBKWA1kM/NmKBNhE24TxecbRexjegocPs
X-Google-Smtp-Source: AGHT+IF6pBNoWmXGf7vTZMQ381bW6+2j2NKIgb8N25SF99egd7XehItvSqzxpYLu0CgEzvEXOBUZPw==
X-Received: by 2002:a05:6000:2304:b0:3b7:6d94:a032 with SMTP id ffacd0b85a97d-3b917d2d474mr2550108f8f.3.1755095216092;
        Wed, 13 Aug 2025 07:26:56 -0700 (PDT)
Received: from [192.168.108.121] (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1a5868fesm4264065e9.16.2025.08.13.07.26.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 07:26:55 -0700 (PDT)
Message-ID: <db364a7e-0877-4069-9c06-26ab6ad4acd2@freebox.fr>
Date: Wed, 13 Aug 2025 16:26:54 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next] wifi: nl80211: Add EHT fixed Tx rate
 support
To: Muna Sinada <muna.sinada@oss.qualcomm.com>, johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, Aloka Dixit <aloka.dixit@oss.qualcomm.com>
References: <20250812213652.3763535-1-muna.sinada@oss.qualcomm.com>
Content-Language: en-US
From: Pablo MARTIN-GOMEZ <pmartin-gomez@freebox.fr>
In-Reply-To: <20250812213652.3763535-1-muna.sinada@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/08/2025 23:36, Muna Sinada wrote:
> Add new attributes to support EHT MCS/NSS Tx rates and EHT GI/LTF.
> Parse EHT fixed MCS/NSS Tx rates and EHT GI/LTF values passed by the
> userspace, validate and add as part of cfg80211_bitrate_mask.
>
> MCS mask is constructed by new function, eht_build_mcs_mask(). Max NSS
> supported for MCS rates of 7, 9, 11 and 13 is utilized to set MCS
> bitmask for each NSS. MCS rates 14, and 15 if supported, are set only
> for NSS = 0.
>
> Co-developed-by: Aloka Dixit <aloka.dixit@oss.qualcomm.com>
> Signed-off-by: Aloka Dixit <aloka.dixit@oss.qualcomm.com>
> Signed-off-by: Muna Sinada <muna.sinada@oss.qualcomm.com>
> ---
>   include/net/cfg80211.h       |   3 +
>   include/uapi/linux/nl80211.h |  32 ++++++
>   net/wireless/nl80211.c       | 214 ++++++++++++++++++++++++++++++++++-
>   3 files changed, 246 insertions(+), 3 deletions(-)
[...]
>   
> +static int eht_build_mcs_mask(struct genl_info *info,
> +			      const struct ieee80211_sta_he_cap *he_cap,
> +			      const struct ieee80211_sta_eht_cap *eht_cap,
> +			      u16 *mcs_mask)
> +{
I would probably prefer if `eht_*_mcs_mask` followed `he_*_mcs_mask` 
structures: no possible error for `eht_build_mcs_mask` and all the 
checks in `eht_set_mcs_mask`
> +	struct net_device *dev = info->user_ptr[1];
> +	struct wireless_dev *wdev = dev->ieee80211_ptr;
> +	u8 mcs_nss_len, nss, mcs_7 = 0, mcs_9 = 0, mcs_11 = 0, mcs_13 = 0;
> +	bool mcs_14 = false, mcs_15 = false;
> +	unsigned int link_id = nl80211_link_id(info->attrs);
> +
> +	mcs_nss_len = ieee80211_eht_mcs_nss_size(&he_cap->he_cap_elem,
> +						 &eht_cap->eht_cap_elem,
> +						 wdev->iftype ==
> +							NL80211_IFTYPE_STATION);
> +
> +	if (eht_cap->eht_cap_elem.phy_cap_info[6] &
> +	    IEEE80211_EHT_PHY_CAP6_EHT_DUP_6GHZ_SUPP)
> +		mcs_14 = true;
> +
> +	if (eht_cap->eht_cap_elem.phy_cap_info[6] &
> +	    IEEE80211_EHT_PHY_CAP6_MCS15_SUPP_MASK)
> +		mcs_15 = true;
This is not correct. `IEEE80211_EHT_PHY_CAP6_MCS15_SUPP_MASK` is for the 
support of EHT-MCS 15 in MRU, not the support of EHT-MCS 15 in general. 
The support of MCS 15 is mandatory, even though a STA can opt-out using 
it in EHT Operation IE with the `MCS-15 Disable` bit. So we either need 
to always set `mcs_15` to `true` or change `ieee80211_sta_eht_cap` to 
store the operation IE value (if it's provided, or something like this) 
to be able to do a check here.
> +
> +	if (mcs_nss_len == 4) {
> +		const struct ieee80211_eht_mcs_nss_supp_20mhz_only *mcs =
> +					&eht_cap->eht_mcs_nss_supp.only_20mhz;
> +
> +		mcs_7 = u8_get_bits(mcs->rx_tx_mcs7_max_nss,
> +				    IEEE80211_EHT_MCS_NSS_TX);
> +		mcs_9 = u8_get_bits(mcs->rx_tx_mcs9_max_nss,
> +				    IEEE80211_EHT_MCS_NSS_TX);
> +		mcs_11 = u8_get_bits(mcs->rx_tx_mcs11_max_nss,
> +				     IEEE80211_EHT_MCS_NSS_TX);
> +		mcs_13 = u8_get_bits(mcs->rx_tx_mcs13_max_nss,
> +				     IEEE80211_EHT_MCS_NSS_TX);
> +
> +	} else {
> +		const struct ieee80211_eht_mcs_nss_supp_bw *mcs;
> +		enum nl80211_chan_width width;
> +
> +		switch (wdev->iftype) {
> +		case NL80211_IFTYPE_ADHOC:
> +			width = wdev->u.ibss.chandef.width;
> +			break;
> +		case NL80211_IFTYPE_AP:
> +		case NL80211_IFTYPE_P2P_GO:
> +			if (wdev->valid_links)
> +				width = wdev->links[link_id].ap.chandef.width;
> +			else
> +				width = wdev->u.ap.preset_chandef.width;
> +			break;
> +		case NL80211_IFTYPE_MESH_POINT:
> +			width = wdev->u.mesh.chandef.width;
> +			break;
> +		case NL80211_IFTYPE_OCB:
> +			width = wdev->u.ocb.chandef.width;
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +
> +		switch (width) {
> +		case NL80211_CHAN_WIDTH_320:
> +			mcs = &eht_cap->eht_mcs_nss_supp.bw._320;
> +			break;
> +		case NL80211_CHAN_WIDTH_160:
> +			mcs = &eht_cap->eht_mcs_nss_supp.bw._160;
> +			break;
> +		case NL80211_CHAN_WIDTH_80:
> +		case NL80211_CHAN_WIDTH_40:
> +		case NL80211_CHAN_WIDTH_20:
> +			mcs = &eht_cap->eht_mcs_nss_supp.bw._80;
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +
> +		mcs_7 = u8_get_bits(mcs->rx_tx_mcs9_max_nss,
> +				    IEEE80211_EHT_MCS_NSS_TX);
> +		mcs_9 = u8_get_bits(mcs->rx_tx_mcs9_max_nss,
> +				    IEEE80211_EHT_MCS_NSS_TX);
> +		mcs_11 = u8_get_bits(mcs->rx_tx_mcs11_max_nss,
> +				     IEEE80211_EHT_MCS_NSS_TX);
> +		mcs_13 = u8_get_bits(mcs->rx_tx_mcs13_max_nss,
> +				     IEEE80211_EHT_MCS_NSS_TX);
> +	}
> +
> +	for (nss = 0; nss < NL80211_EHT_NSS_MAX; nss++) {
> +		if (nss == 0) {
> +			if (mcs_14)
> +				mcs_mask[nss] |= 0x4000;
> +			if (mcs_15)
> +				mcs_mask[nss] |= 0x8000;
> +		}
Better put this if block outside the loop.
> +
> +		if (!mcs_7)
> +			continue;
> +		mcs_mask[nss] |= 0x00FF;
> +		mcs_7--;
> +
> +		if (!mcs_9)
> +			continue;
> +		mcs_mask[nss] |= 0x0300;
> +		mcs_9--;
> +
> +		if (!mcs_11)
> +			continue;
> +		mcs_mask[nss] |= 0x0C00;
> +		mcs_11--;
> +
> +		if (!mcs_13)
> +			continue;
> +		mcs_mask[nss] |= 0x3000;
> +		mcs_13--;
> +	}
> +
> +	return 0;
> +}
> +
> +static bool eht_set_mcs_mask(struct genl_info *info, struct wireless_dev *wdev,
> +			     struct ieee80211_supported_band *sband,
> +			     struct nl80211_txrate_eht *txrate,
> +			     u16 mcs[NL80211_EHT_NSS_MAX])
> +{
> +	const struct ieee80211_sta_he_cap *he_cap;
> +	const struct ieee80211_sta_eht_cap *eht_cap;
> +	u16 tx_mcs_mask[NL80211_EHT_NSS_MAX] = { 0 };
> +	u8 i;
> +
> +	he_cap = ieee80211_get_he_iftype_cap(sband, wdev->iftype);
> +	if (!he_cap)
> +		return false;
> +
> +	eht_cap = ieee80211_get_eht_iftype_cap(sband, wdev->iftype);
> +	if (!eht_cap)
> +		return false;
> +
> +	/* Checks for MCS 14 */
> +	if (txrate->mcs[0] & 0x4000) {
> +		if (sband->band != NL80211_BAND_6GHZ)
> +			return false;
> +
> +		if (!(eht_cap->eht_cap_elem.phy_cap_info[6] &
> +		      IEEE80211_EHT_PHY_CAP6_EHT_DUP_6GHZ_SUPP))
> +			return false;
> +	}
> +
> +	/* Checks for MCS 15 */
> +	if ((txrate->mcs[0] & 0x8000) &&
> +	    (!(eht_cap->eht_cap_elem.phy_cap_info[6] &
> +	       IEEE80211_EHT_PHY_CAP6_MCS15_SUPP_MASK)))
> +		return false;
> +
> +	if (eht_build_mcs_mask(info, he_cap, eht_cap, tx_mcs_mask))
> +		return false;
> +
> +	memset(mcs, 0, sizeof(u16) * NL80211_EHT_NSS_MAX);
> +	for (i = 0; i < NL80211_EHT_NSS_MAX; i++) {
> +		if ((tx_mcs_mask[i] & txrate->mcs[i]) == txrate->mcs[i])
> +			mcs[i] = txrate->mcs[i];
> +		else
> +			return false;
> +	}
> +
> +	return true;
> +}
> +
>   static int nl80211_parse_tx_bitrate_mask(struct genl_info *info,
>   					 struct nlattr *attrs[],
>   					 enum nl80211_attrs attr,
> @@ -5404,7 +5580,7 @@ static int nl80211_parse_tx_bitrate_mask(struct genl_info *info,
>   	struct nlattr *tb[NL80211_TXRATE_MAX + 1];
>   	struct cfg80211_registered_device *rdev = info->user_ptr[0];
>   	struct wireless_dev *wdev = dev->ieee80211_ptr;
> -	int rem, i;
> +	int rem, i, ret;
>   	struct nlattr *tx_rates;
>   	struct ieee80211_supported_band *sband;
>   	u16 vht_tx_mcs_map, he_tx_mcs_map;
> @@ -5413,6 +5589,7 @@ static int nl80211_parse_tx_bitrate_mask(struct genl_info *info,
>   	/* Default to all rates enabled */
>   	for (i = 0; i < NUM_NL80211_BANDS; i++) {
>   		const struct ieee80211_sta_he_cap *he_cap;
> +		const struct ieee80211_sta_eht_cap *eht_cap;
>   
>   		if (!default_all_enabled)
>   			break;
> @@ -5441,6 +5618,19 @@ static int nl80211_parse_tx_bitrate_mask(struct genl_info *info,
>   
>   		mask->control[i].he_gi = 0xFF;
>   		mask->control[i].he_ltf = 0xFF;
> +
> +		eht_cap = ieee80211_get_eht_iftype_cap(sband, wdev->iftype);
> +		if (!eht_cap)
> +			continue;
> +
> +		ret = eht_build_mcs_mask(info, he_cap, eht_cap,
> +					 mask->control[i].eht_mcs);
> +		if (ret)
> +			return ret;
> +
> +		mask->control[i].eht_gi = 0xFF;
> +		mask->control[i].eht_ltf = 0xFF;
> +
>   	}
>   
>   	/* if no rates are given set it back to the defaults */
> @@ -5512,13 +5702,27 @@ static int nl80211_parse_tx_bitrate_mask(struct genl_info *info,
>   			mask->control[band].he_ltf =
>   				nla_get_u8(tb[NL80211_TXRATE_HE_LTF]);
>   
> +		if (tb[NL80211_TXRATE_EHT] &&
> +		    !eht_set_mcs_mask(info, wdev, sband,
> +				      nla_data(tb[NL80211_TXRATE_EHT]),
> +				      mask->control[band].eht_mcs))
> +			return -EINVAL;
> +
> +		if (tb[NL80211_TXRATE_EHT_GI])
> +			mask->control[band].eht_gi =
> +				nla_get_u8(tb[NL80211_TXRATE_EHT_GI]);
> +		if (tb[NL80211_TXRATE_EHT_LTF])
> +			mask->control[band].eht_ltf =
> +				nla_get_u8(tb[NL80211_TXRATE_EHT_LTF]);
> +
>   		if (mask->control[band].legacy == 0) {
> -			/* don't allow empty legacy rates if HT, VHT or HE
> +			/* don't allow empty legacy rates if HT, VHT, HE or EHT
>   			 * are not even supported.
>   			 */
>   			if (!(rdev->wiphy.bands[band]->ht_cap.ht_supported ||
>   			      rdev->wiphy.bands[band]->vht_cap.vht_supported ||
> -			      ieee80211_get_he_iftype_cap(sband, wdev->iftype)))
> +			      ieee80211_get_he_iftype_cap(sband, wdev->iftype) ||
> +			      ieee80211_get_eht_iftype_cap(sband, wdev->iftype)))
>   				return -EINVAL;
>   
>   			for (i = 0; i < IEEE80211_HT_MCS_MASK_LEN; i++)
> @@ -5533,6 +5737,10 @@ static int nl80211_parse_tx_bitrate_mask(struct genl_info *info,
>   				if (mask->control[band].he_mcs[i])
>   					goto out;
>   
> +			for (i = 0; i < NL80211_EHT_NSS_MAX; i++)
> +				if (mask->control[band].eht_mcs[i])
> +					goto out;
> +
>   			/* legacy and mcs rates may not be both empty */
>   			return -EINVAL;
>   		}

Shouldn't this patch also modify `validate_beacon_tx_rate` function?

> base-commit: d9104cec3e8fe4b458b74709853231385779001f

Best regards,

Pablo MG


