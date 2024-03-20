Return-Path: <linux-wireless+bounces-4990-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1305A8815C7
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 17:40:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 813C42818FB
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 16:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D17015C3;
	Wed, 20 Mar 2024 16:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FVc19hfP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2901515A5
	for <linux-wireless@vger.kernel.org>; Wed, 20 Mar 2024 16:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710952796; cv=none; b=oK9RMFSTtmB0HtnznBZYhElzmTh4by3kFQft5Jdk1C4Ns+0jLOyy3k9nv83/k/5GOQfzuG3LGlIlcRjrCGZ5a/VtFwUDzRmNRr87fpKp1MlP1YgmDD0JP/KbUt8rkqTq7yrNUywMR8/2Sc8am1fPXHkphpz26ZFfKpWP20T7TnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710952796; c=relaxed/simple;
	bh=pdueHAqME/RXgy8B9mFyZ15nNoudCV+XV4ekjt1t7PU=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=Bhe1dasMKyRgB9sAgJ2YgOfr0Q6zQDcDqwFQvvTR0pAylGtX7PDTxyfifDYaMn2fRyOPVQlPl3EEow6ICp0MUBSRSf+v/zC0yNkWEq85Ve1/U4i1dhnVqSN3/eWLql4NcTXbfJP9SROzTABcYDk/thc+4Z2e7reVP2orh/tdU1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FVc19hfP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1C6FC43399;
	Wed, 20 Mar 2024 16:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710952795;
	bh=pdueHAqME/RXgy8B9mFyZ15nNoudCV+XV4ekjt1t7PU=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=FVc19hfPlD2Pe6iXcWwRKFQRVVTIBwSeK81M7Ns2vV4MoygQSFn9S7DkIGNqU/wfe
	 dd+qCyPc078egc4X5E2JCEsh3R5ohsY1zvRGUhcReCzm8POz2JWc4EXjj4cNtfTGjj
	 ettr+m+vnRaZGi31BZPdWVL00f0siVr6Hk8LzcBl/1tl6JYfDod+aYQeTt6ALg3tjo
	 zzwx8j585+To2OE+ca5IJHVmR+Qzdy8OAav3k3CRM6w7P456VzP7N6NsXkr/B5SDyv
	 BSBIykRtw7GTM9A3EXuzv0VTfwNreM3GDNkT2pAyjwQUk54iiKc38sHeLYpXETiFgY
	 15FIDX5s5ezpg==
From: Kalle Valo <kvalo@kernel.org>
To: Lingbo Kong <quic_lingbok@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] wifi: ath12k: report signal for iw dev xxx station dump
References: <20240219111417.1185-1-quic_lingbok@quicinc.com>
Date: Wed, 20 Mar 2024 18:39:52 +0200
In-Reply-To: <20240219111417.1185-1-quic_lingbok@quicinc.com> (Lingbo Kong's
	message of "Mon, 19 Feb 2024 19:14:17 +0800")
Message-ID: <87o7b8amcn.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lingbo Kong <quic_lingbok@quicinc.com> writes:

> The signal of "iw dev xxx station dump" always show 0 dBm. This is because
> currently signal is only set in ath12k_mgmt_rx_event function, and not set
> for rx data packet. So, change to get signal from firmware and report to
> mac80211.
>
> After that, "iw dev xxx station dump" show the correct signal such as:
> signal: -50 dBm
> signal: -49 dBm
>
> Tested-on: WCN7850 hw2.0 PCI
> WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
>
> Signed-off-by: Lingbo Kong <quic_lingbok@quicinc.com>

I'll omit the cosmetics for now and focus on the big picture.

First of all, no mention of WCN7850 and QCN9274 in the commit message.
Not good.

> --- a/drivers/net/wireless/ath/ath12k/hw.c
> +++ b/drivers/net/wireless/ath/ath12k/hw.c
> @@ -920,6 +920,8 @@ static const struct ath12k_hw_params ath12k_hw_params[] = {
>  		.otp_board_id_register = QCN9274_QFPROM_RAW_RFA_PDET_ROW13_LSB,
>  
>  		.supports_sta_ps = false,
> +
> +		.supports_rssi_stats = false,
>  	},
>  	{
>  		.name = "wcn7850 hw2.0",
> @@ -993,6 +995,8 @@ static const struct ath12k_hw_params ath12k_hw_params[] = {
>  		.otp_board_id_register = 0,
>  
>  		.supports_sta_ps = true,
> +
> +		.supports_rssi_stats = true,
>  	},
>  	{
>  		.name = "qcn9274 hw2.0",
> @@ -1061,6 +1065,8 @@ static const struct ath12k_hw_params ath12k_hw_params[] = {
>  		.otp_board_id_register = QCN9274_QFPROM_RAW_RFA_PDET_ROW13_LSB,
>  
>  		.supports_sta_ps = false,
> +
> +		.supports_rssi_stats = false,
>  	},
>  };

Ok, based on this you enable this only for WCN7850 hw2.0. Why is that?

We really should get rid of "I work only on WCN7850 and not care about
QCN9274" mindset. And of course the other team says "I work only on
QCN9274 and not care about WCN7850", sigh. If you work on ath12k you
need to consider *BOTH* WCN7850 and QCN9274 families!

>  static void ath12k_mac_op_sta_statistics(struct ieee80211_hw *hw,
>  					 struct ieee80211_vif *vif,
>  					 struct ieee80211_sta *sta,
>  					 struct station_info *sinfo)
>  {
>  	struct ath12k_sta *arsta = ath12k_sta_to_arsta(sta);
> +	struct ath12k *ar = arsta->arvif->ar;
> +	s8 signal;
>  
>  	sinfo->rx_duration = arsta->rx_duration;
>  	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_RX_DURATION);
> @@ -7473,8 +7503,19 @@ static void ath12k_mac_op_sta_statistics(struct ieee80211_hw *hw,
>  	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_BITRATE);
>  
>  	/* TODO: Use real NF instead of default one. */
> -	sinfo->signal = arsta->rssi_comb + ATH12K_DEFAULT_NOISE_FLOOR;
> -	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_SIGNAL);
> +	signal = arsta->rssi_comb;
> +
> +	if (!signal &&
> +	    arsta->arvif->vdev_type == WMI_VDEV_TYPE_STA &&
> +	    ar->ab->hw_params->supports_rssi_stats &&
> +	    !(ath12k_mac_get_fw_stats(ar, ar->pdev->pdev_id, 0,
> +				      WMI_REQUEST_VDEV_STAT)))
> +		signal = arsta->rssi_beacon;
> +
> +	if (signal) {
> +		sinfo->signal = signal;
> +		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_SIGNAL);
> +	}
>  }

If I'm reading the patch correctly this is the sequence:

1. ath12k_mac_op_sta_statistics() is called

2. WMI_REQUEST_STATS_CMDID is sent to the firmware

3. ath12k_mac_op_sta_statistics() returns

4. firmware sends WMI_UPDATE_STATS_EVENTID to host

5. ath12k_wmi_tlv_fw_stats_data_parse() stores signal to arsta->rssi_beacon

So doesn't this mean that ath12k_mac_op_sta_statistics() actually uses
the previous value? And if ath12k_mac_op_sta_statistics() is called very
seldom, like once an hour, the signal value can be one hour wrong?

Also I don't see any protection when accessing arsta->rssi_beacon.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

