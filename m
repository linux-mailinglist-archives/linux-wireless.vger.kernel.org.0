Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80D8919136A
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Mar 2020 15:40:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbgCXOkm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 Mar 2020 10:40:42 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:43458 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727464AbgCXOkm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 Mar 2020 10:40:42 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1585060841; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=VfQKcT7khd2+6JZyPuSQg6Rf6tDnonZTjbtFC7brpe0=; b=Q8p92ppUobs4/VDROOOiRZAr2KuxatXmGzkp820EhVMsoOIzsXD/O6xL7DdLc3zYg+Bh3KTM
 RZODfH9wRAOixlTvoOAnChUVvqQhGRXIQXYak2AS3OZKtH7rz6we+thcT6X0kgv4f4nI5Jkp
 Xgln4d37vQ/KR9PJJD/2+fjFkb4=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e7a1bd9.7f5fc7f560d8-smtp-out-n02;
 Tue, 24 Mar 2020 14:40:25 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 10A50C433BA; Tue, 24 Mar 2020 14:40:25 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 46117C433CB;
        Tue, 24 Mar 2020 14:40:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 46117C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Yu Wang <yyuwang@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v2 2/2] ath10k: correct legacy rate in tx stats
References: <1574147982-3956-1-git-send-email-yyuwang@codeaurora.org>
        <0101016e82882548-361b3da4-fd9b-4ba9-95b6-a5d782d4a1c8-000000@us-west-2.amazonses.com>
Date:   Tue, 24 Mar 2020 16:40:21 +0200
In-Reply-To: <0101016e82882548-361b3da4-fd9b-4ba9-95b6-a5d782d4a1c8-000000@us-west-2.amazonses.com>
        (Yu Wang's message of "Tue, 19 Nov 2019 07:19:50 +0000")
Message-ID: <87h7yd4y0a.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Yu Wang <yyuwang@codeaurora.org> writes:

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

[...]

> @@ -3723,6 +3729,74 @@ static void ath10k_htt_rx_sec_ind_handler(struct ath10k *ar,
>  	spin_unlock_bh(&ar->data_lock);
>  }
>  
> +static int
> +ath10k_htt_update_ratecode(struct ath10k *ar, struct ath10k_sta *arsta,
> +			   u8 *ratecode)
> +{
> +	u8 hw_rate, preamble;
> +	u16 bitrate;
> +	int i;
> +	const struct ieee80211_rate *bitrates;
> +	bool cck;
> +	struct ieee80211_chanctx_conf *conf = NULL;
> +	enum nl80211_band band;
> +	struct ieee80211_supported_band *sband;
> +
> +	if (!ratecode)
> +		return -EINVAL;
> +
> +	/* only for legacy ratecode */
> +	preamble = ATH10K_HW_PREAMBLE(*ratecode);
> +	if (preamble != WMI_RATE_PREAMBLE_CCK &&
> +	    preamble != WMI_RATE_PREAMBLE_OFDM)
> +		return 0;
> +
> +	if (!arsta->arvif || !arsta->arvif->vif)
> +		return -EINVAL;
> +
> +	WARN_ON(!rcu_read_lock_held());
> +	conf = rcu_dereference(arsta->arvif->vif->chanctx_conf);
> +	if (!conf)
> +		return -EINVAL;
> +
> +	band = conf->def.chan->band;
> +	sband = &ar->mac.sbands[band];
> +	if (!sband->bitrates)
> +		return -EINVAL;
> +
> +	if (WARN_ON_ONCE(sband->n_bitrates > S8_MAX))
> +		return -EINVAL;
> +
> +	cck = (preamble == WMI_RATE_PREAMBLE_CCK);
> +	hw_rate = ATH10K_HW_LEGACY_RATE(*ratecode);
> +	for (i = 0; i < sband->n_bitrates; i++) {
> +		bitrates = &sband->bitrates[i];
> +		if (ath10k_mac_bitrate_is_cck(bitrates->bitrate) != cck)
> +			continue;
> +
> +		if (bitrates->hw_value == hw_rate ||
> +		    (bitrates->flags & IEEE80211_RATE_SHORT_PREAMBLE &&
> +		     bitrates->hw_value_short == hw_rate)) {
> +			bitrate = bitrates->bitrate;
> +
> +			/* The bitrate will be recovered in
> +			 * ath10k_update_per_peer_tx_stats().
> +			 */
> +			if (bitrate == 55)
> +				bitrate = 60;
> +
> +			bitrate = bitrate / 10;

Here you use magic value 60 but in ath10k_update_per_peer_tx_stats() you
use magic value 50:

> +		/* from 1Mbps to 100Kbps */
> +		rate = rate * 10;
> +		if (rate == 50)
> +			rate = 55;

Am I missing something or how is this supposed to work?

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
