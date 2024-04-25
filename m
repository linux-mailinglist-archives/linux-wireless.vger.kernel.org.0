Return-Path: <linux-wireless+bounces-6855-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F39C68B26DF
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Apr 2024 18:55:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76B871F232BF
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Apr 2024 16:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11E6614D2A6;
	Thu, 25 Apr 2024 16:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tcXX04eo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E082214A4C3
	for <linux-wireless@vger.kernel.org>; Thu, 25 Apr 2024 16:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714064099; cv=none; b=XMJOZbRgdGCyA5O+UCd+geYlM+9hn29jR3MzsAzNAvx0gpaR0xutAK1vgJt13OzhnegSu7j+rMM0+MRW5OJwbhNtRHCXCsM57Ud1Dw2VdaEOHyX72fz+SrCoka1p0JtV/Qiw37dj0UbJ2pwBOyz6Qd2DlRAq5EZqqiJTiVjPZyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714064099; c=relaxed/simple;
	bh=rkOZ4/fb0cF/1NwGsfEm1tXuUuMdCb3rueuQ7I6yJHc=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=UBL702EVvj3qLFWT2kTZNL/uQEDLTlsFB9cnkdQ3fPdkTqBIm1ZlkJRY9KxZPq3GXVu24TdvKvCZZsPjm1INO5bgrBLbtY1S609vF/3KW9Vsv6FNSre6YeMgZPVb2phVivk9qjCmIS51Y3fUObcX0r6udRO0qLKZJUftcfZ7TFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tcXX04eo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6759AC113CC;
	Thu, 25 Apr 2024 16:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714064098;
	bh=rkOZ4/fb0cF/1NwGsfEm1tXuUuMdCb3rueuQ7I6yJHc=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=tcXX04eoaV3NwAjZwtnP6XY8/IQA281DXZqJ8i8eHqGjcAFN5YmTbe8uM5vBLjiZH
	 9W0fgXqeOxmQWTc+tg2Kne60Gm3ZcK0hyQM52eji2wgIM9mrZb+K6Kg2SSte7v1XcG
	 MkFll+VLdg5DkIGtYsElEGR2rKuFiOWSLeLVqzyyZTpF362tN9M/NoNDHrj76uuXP/
	 IRfxii9LInAzY046Q2WxQzqPUCo4/+cyGczd2E5doy8U8AMZFFuwLtul/ukMyRWWl2
	 8uDM/yiKXdUlpoV5jUIAsPOaKQGyX0xNtBgUJHs6W8BzgePr3vl0s9g5TCM4Um0Xmt
	 HZZMUCcRf7jnA==
From: Kalle Valo <kvalo@kernel.org>
To: Lingbo Kong <quic_lingbok@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v4 1/3] wifi: ath12k: report station mode transmit rate
References: <20240419032122.7009-1-quic_lingbok@quicinc.com>
	<20240419032122.7009-2-quic_lingbok@quicinc.com>
Date: Thu, 25 Apr 2024 19:54:44 +0300
In-Reply-To: <20240419032122.7009-2-quic_lingbok@quicinc.com> (Lingbo Kong's
	message of "Fri, 19 Apr 2024 11:21:20 +0800")
Message-ID: <87bk5xs7qj.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lingbo Kong <quic_lingbok@quicinc.com> writes:

> Currently, the transmit rate of "iw dev xxx station dump" command
> always show an invalid value.
>
> To address this issue, ath12k parse the info of transmit complete
> report from firmware and indicate the transmit rate to mac80211.
>
> This patch affects the station mode of WCN7850 and QCN9274.
>
> After that, "iw dev xxx station dump" show the correct transmit rate.
> Such as:
>
> Station 00:03:7f:12:03:03 (on wlo1)
>         inactive time:  872 ms
>         rx bytes:       219111
>         rx packets:     1133
>         tx bytes:       53767
>         tx packets:     462
>         tx retries:     51
>         tx failed:      0
>         beacon loss:    0
>         beacon rx:      403
>         rx drop misc:   74
>         signal:         -95 dBm
>         beacon signal avg:      -18 dBm
>         tx bitrate:     1441.1 MBit/s 80MHz EHT-MCS 13 EHT-NSS 2 EHT-GI 0
>
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.2.1-00201-QCAHKSWPL_SILICONZ-1
>
> Signed-off-by: Lingbo Kong <quic_lingbok@quicinc.com>

I'm still going throught the patchset, please don't send a new version
yet. Few quick comments:

> +static void ath12k_dp_tx_update_txcompl(struct ath12k *ar, struct hal_tx_status *ts)
> +{
> +	struct ath12k_base *ab = ar->ab;
> +	struct ath12k_peer *peer;
> +	struct ath12k_sta *arsta;
> +	struct ieee80211_sta *sta;
> +	u16 rate;
> +	u8 rate_idx = 0;
> +	int ret;
> +
> +	spin_lock_bh(&ab->base_lock);

Did you analyse how this function, and especially taking the base_lock,
affects performance?

> +enum nl80211_he_ru_alloc ath12k_mac_he_ru_tones_to_nl80211_he_ru_alloc(u16 ru_tones)
> +{
> +	enum nl80211_he_ru_alloc ret;
> +
> +	switch (ru_tones) {
> +	case 26:
> +		ret = NL80211_RATE_INFO_HE_RU_ALLOC_26;
> +		break;
> +	case 52:
> +		ret = NL80211_RATE_INFO_HE_RU_ALLOC_52;
> +		break;
> +	case 106:
> +		ret = NL80211_RATE_INFO_HE_RU_ALLOC_106;
> +		break;
> +	case 242:
> +		ret = NL80211_RATE_INFO_HE_RU_ALLOC_242;
> +		break;
> +	case 484:
> +		ret = NL80211_RATE_INFO_HE_RU_ALLOC_484;
> +		break;
> +	case 996:
> +		ret = NL80211_RATE_INFO_HE_RU_ALLOC_996;
> +		break;
> +	case (996 * 2):
> +		ret = NL80211_RATE_INFO_HE_RU_ALLOC_2x996;
> +		break;
> +	default:
> +		ret = NL80211_RATE_INFO_HE_RU_ALLOC_26;
> +		break;
> +	}
> +
> +	return ret;
> +}

How does this function compare to ath12k_he_ru_tones_to_nl80211_he_ru_alloc()?

> +enum nl80211_eht_gi ath12k_mac_eht_gi_to_nl80211_eht_gi(u8 sgi)
> +{
> +	enum nl80211_eht_gi ret;
> +
> +	switch (sgi) {
> +	case RX_MSDU_START_SGI_0_8_US:
> +		ret = NL80211_RATE_INFO_EHT_GI_0_8;
> +		break;
> +	case RX_MSDU_START_SGI_1_6_US:
> +		ret = NL80211_RATE_INFO_EHT_GI_1_6;
> +		break;
> +	case RX_MSDU_START_SGI_3_2_US:
> +		ret = NL80211_RATE_INFO_EHT_GI_3_2;
> +		break;
> +	default:
> +		ret = NL80211_RATE_INFO_EHT_GI_0_8;
> +		break;
> +	}
> +
> +	return ret;
> +}

BTW the ret variable is unnessary, this could be simplified to:

switch (foo) {
case FOO1:
        return BAR1;
case FOO2:
        return BAR2;
default:
        return BAR3;
}

> +enum nl80211_eht_ru_alloc ath12k_mac_eht_ru_tones_to_nl80211_eht_ru_alloc(u16 ru_tones)
> +{
> +	enum nl80211_eht_ru_alloc ret;
> +
> +	switch (ru_tones) {
> +	case 26:
> +		ret = NL80211_RATE_INFO_EHT_RU_ALLOC_26;
> +		break;
> +	case 52:
> +		ret = NL80211_RATE_INFO_EHT_RU_ALLOC_52;
> +		break;
> +	case (52 + 26):
> +		ret = NL80211_RATE_INFO_EHT_RU_ALLOC_52P26;
> +		break;
> +	case 106:
> +		ret = NL80211_RATE_INFO_EHT_RU_ALLOC_106;
> +		break;
> +	case (106 + 26):
> +		ret = NL80211_RATE_INFO_EHT_RU_ALLOC_106P26;
> +		break;
> +	case 242:
> +		ret = NL80211_RATE_INFO_EHT_RU_ALLOC_242;
> +		break;
> +	case 484:
> +		ret = NL80211_RATE_INFO_EHT_RU_ALLOC_484;
> +		break;
> +	case (484 + 242):
> +		ret = NL80211_RATE_INFO_EHT_RU_ALLOC_484P242;
> +		break;
> +	case 996:
> +		ret = NL80211_RATE_INFO_EHT_RU_ALLOC_996;
> +		break;
> +	case (996 + 484):
> +		ret = NL80211_RATE_INFO_EHT_RU_ALLOC_996P484;
> +		break;
> +	case (996 + 484 + 242):
> +		ret = NL80211_RATE_INFO_EHT_RU_ALLOC_996P484P242;
> +		break;
> +	case (2 * 996):
> +		ret = NL80211_RATE_INFO_EHT_RU_ALLOC_2x996;
> +		break;
> +	case (2 * 996 + 484):
> +		ret = NL80211_RATE_INFO_EHT_RU_ALLOC_2x996P484;
> +		break;
> +	case (3 * 996):
> +		ret = NL80211_RATE_INFO_EHT_RU_ALLOC_3x996;
> +		break;
> +	case (3 * 996 + 484):
> +		ret = NL80211_RATE_INFO_EHT_RU_ALLOC_3x996P484;
> +		break;
> +	case (4 * 996):
> +		ret = NL80211_RATE_INFO_EHT_RU_ALLOC_4x996;
> +		break;
> +	default:
> +		ret = NL80211_RATE_INFO_EHT_RU_ALLOC_26;
> +	}
> +
> +	return ret;
> +}

Same here.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

