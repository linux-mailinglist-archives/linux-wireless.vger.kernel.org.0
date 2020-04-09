Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C54211A35C8
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Apr 2020 16:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbgDIOVy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 9 Apr 2020 10:21:54 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:50325 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726983AbgDIOVy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 9 Apr 2020 10:21:54 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1586442114; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=i1gSouDiH00xX0HT7wvzjIUQJlWlHVdRaCatVjB8XTY=;
 b=FhY5TktrTI2Wc0NKfl0YuTpU041G5PJm1KcK8NuPaVNAQqoJ45FBrrCr8ZN08ItRXnY7jgRc
 eb4Nlt2/ouka+0aTZOTcALJmmVIkOqpO0rro36zsDIzG28uB2xBj8lWiyzGD2uYNZNL6UcDm
 yPqDYCqb+DjFDDoZVGCih17DN/Q=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e8f2f70.7fe9129a7570-smtp-out-n01;
 Thu, 09 Apr 2020 14:21:36 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 7A9E7C433D2; Thu,  9 Apr 2020 14:21:36 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 21562C433CB;
        Thu,  9 Apr 2020 14:21:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 21562C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 2/2] ath10k: correct legacy rate in tx stats
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <0101016e82883ded-63f88383-cd90-4cb0-b9bb-3dd6a1e9f4e9-000000@us-west-2.amazonses.com>
References: <0101016e82883ded-63f88383-cd90-4cb0-b9bb-3dd6a1e9f4e9-000000@us-west-2.amazonses.com>
To:     Yu Wang <yyuwang@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20200409142136.7A9E7C433D2@smtp.codeaurora.org>
Date:   Thu,  9 Apr 2020 14:21:36 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Yu Wang <yyuwang@codeaurora.org> wrote:

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
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

My comments don't seem to go to patchwork, so trying again:

What about QCA988X and WCN3990, how do they behave? Does this patch
break those?

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
https://patchwork.kernel.org/patch/11251001/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
