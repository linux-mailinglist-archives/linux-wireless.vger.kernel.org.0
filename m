Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0CEBF9853
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Nov 2019 19:14:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbfKLSOi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 12 Nov 2019 13:14:38 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:45431 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726906AbfKLSOi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 12 Nov 2019 13:14:38 -0500
Received: by mail-pf1-f194.google.com with SMTP id z4so13886483pfn.12
        for <linux-wireless@vger.kernel.org>; Tue, 12 Nov 2019 10:14:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eero.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=CDVh9KmZPeXWfFbHu3hiOOuFGhqbuWMc9hlCyeNXCRI=;
        b=ufWOLfZwBgUe1/vDKpoBg3JpMwnSE4lPtYSaDnWKBXawOrVNSGUhJx5FROHinHV6JR
         RoVNjtkfDa+eniECxvRVuuS/tDNYDtaVkLneKgzFFz9fUZXJcwsPJU9SinFrBiHP+gf3
         j7ffG3dlVbKaJ7OqLUac5ViE2DddFUdFpwmFo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=CDVh9KmZPeXWfFbHu3hiOOuFGhqbuWMc9hlCyeNXCRI=;
        b=kk9H+xinl382kuo6sLFwhwaymDySfQxxuFaOjhm5LMsys8D6oXRiDUnd8DlyDqe2Ru
         H+gtSNhdQEmIn7QOK9kNuRdhzUOnVxJ8XWkCvz4ScoVpFlJ1HU90cIpb6jD6Js2jOrED
         UZ6/n2LbQh4udRiJlimqnj4r1CG702IdCMaMuae/XPdVs2oXwu+pprlsUku/93sIVnSm
         jUQHIrxwsiDo8KTGCC06AtUU/HjF36xRSE+POssRBA6J1kNWVEMVCFyxjJwWg67mFC/q
         fNPjmxidOb/GBMLukpj0P7Hr7zFJ/xRi27JKKaEoAQyQuDDs4i/M0oP5SzgpmEnirFw0
         xEAQ==
X-Gm-Message-State: APjAAAXbgST6wDz9SWzLrA9Xc4LmvCot3r6StAblP8UwdRBMuvvlCJdu
        /Zw/ggoAzCQDlfpBMG5Tj1we0TEfPT0cgA==
X-Google-Smtp-Source: APXvYqyX8/JpbsxXQZtsbS9l6qINuj546ceSuShmwfxShp+BhQscpMPzSET4Tq7rVV9ddNMFRfnjnQ==
X-Received: by 2002:a62:b504:: with SMTP id y4mr4639013pfe.251.1573582477537;
        Tue, 12 Nov 2019 10:14:37 -0800 (PST)
Received: from [10.0.2.15] (eero.static.monkeybrains.net. [199.116.72.162])
        by smtp.gmail.com with ESMTPSA id y12sm4763593pjy.0.2019.11.12.10.14.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Nov 2019 10:14:36 -0800 (PST)
Subject: Re: [PATCH 2/2] ath10k: correct legacy rate in tx stats
To:     Yu Wang <yyuwang@codeaurora.org>, ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
References: <1573559148-4844-1-git-send-email-yyuwang@codeaurora.org>
 <1573559148-4844-3-git-send-email-yyuwang@codeaurora.org>
From:   Peter Oh <peter.oh@eero.com>
Message-ID: <8c633afa-085d-9cf1-549e-afcfee89c96a@eero.com>
Date:   Tue, 12 Nov 2019 10:14:34 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1573559148-4844-3-git-send-email-yyuwang@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 11/12/19 3:45 AM, Yu Wang wrote:
> When working in station mode, after connected to a legacy
> AP, 11g only, for example, the tx bitrate is incorrect in
> output of command 'iw wlan0 link'.
>
> That's because the legacy tx bitrate value reported by
> firmware is not well handled:
> For QCA6174, the value represents rate index, but treated
> as a real rate;
> For QCA9888, the value is real rate, with unit 'Mbps', but
> treated as '100kbps'.
>
> To fix this issue:
> 1. Translate the rate index to real rate for QCA6174;
> 2. Translate the rate from 'Mbps' to 'kbps' for QCA9888.
>
> Tested with:
> QCA6174 PCIe with firmware WLAN.RM.4.4.1.c3-00031.
> QCA6174 SDIO with firmware WLAN.RMH.4.4.1-00029.
> QCA9888 PCIe with firmware 10.4-3.9.0.2-00040.
>
> Signed-off-by: Yu Wang <yyuwang@codeaurora.org>
> ---
>
> diff --git a/drivers/net/wireless/ath/ath10k/htt_rx.c b/drivers/net/wireless/ath/ath10k/htt_rx.c
> @@ -3454,10 +3440,12 @@ ath10k_update_per_peer_tx_stats(struct ath10k *ar,
>   {
>   	struct ath10k_sta *arsta = (struct ath10k_sta *)sta->drv_priv;
>   	struct ieee80211_chanctx_conf *conf = NULL;
> -	u8 rate = 0, sgi;
> -	s8 rate_idx = 0;
> +	u8 sgi;
> +	s8 rate_idx = -1;
>   	bool skip_auto_rate;
>   	struct rate_info txrate;
> +	enum nl80211_band band;
> +	struct ieee80211_supported_band *sband;
>   
>   	lockdep_assert_held(&ar->data_lock);
>   
> @@ -3475,7 +3463,7 @@ ath10k_update_per_peer_tx_stats(struct ath10k *ar,
>   		return;
>   
>   	if (txrate.flags == WMI_RATE_PREAMBLE_VHT && txrate.mcs > 9) {
> -		ath10k_warn(ar, "Invalid VHT mcs %hhd peer stats",  txrate.mcs);
> +		ath10k_warn(ar, "Invalid VHT mcs %hhd peer stats", txrate.mcs);
>   		return;
>   	}
>   
> @@ -3490,14 +3478,19 @@ ath10k_update_per_peer_tx_stats(struct ath10k *ar,
>   	memset(&arsta->tx_info.status, 0, sizeof(arsta->tx_info.status));
>   	if (txrate.flags == WMI_RATE_PREAMBLE_CCK ||
>   	    txrate.flags == WMI_RATE_PREAMBLE_OFDM) {
> -		rate = ATH10K_HW_LEGACY_RATE(peer_stats->ratecode);
> -		/* This is hacky, FW sends CCK rate 5.5Mbps as 6 */
> -		if (rate == 6 && txrate.flags == WMI_RATE_PREAMBLE_CCK)
> -			rate = 5;
> -		rate_idx = ath10k_get_legacy_rate_idx(ar, rate);
> -		if (rate_idx < 0)
> +		if (!arsta->arvif || !arsta->arvif->vif)
> +			return;
> +
> +		conf = rcu_dereference(arsta->arvif->vif->chanctx_conf);
> +		if (!conf)
> +			return;
> +
> +		band = conf->def.chan->band;
> +		sband = &ar->mac.sbands[band];
> +		if (ath10k_wmi_get_legacy_rate(ar, sband, peer_stats->ratecode,
> +					       &arsta->txrate.legacy,
> +					       &rate_idx))

Using wmi ops to parse rate info breaks ath10k driver architecture, 
since the rate info comes from htt layer and nothing related to wmi.


Thanks,

Peter

