Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B58472A9063
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Nov 2020 08:33:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725842AbgKFHdP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 6 Nov 2020 02:33:15 -0500
Received: from z5.mailgun.us ([104.130.96.5]:26634 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726337AbgKFHdP (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 6 Nov 2020 02:33:15 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1604647994; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=uTvB8Mor1JbG2jndQGF9TSwWEmumpzwqPV0akWOhJR8=; b=gs+8uh0rBeEydKmHv5Q1K2vfmgwCZw22Fr9eGTfvN+I57zdjrxBsjO0q989tsHzFWvOmVZuy
 L4PbkhkUlCZvquxKpwttkJgngYut3NIDG29ABdVxFj2brN8kY81zDn44muA/dGHligaeLUGN
 62+BAfKPZlGjFlzLJ1/BvPwJRps=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 5fa4fc2e98aeba5841c01f92 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 06 Nov 2020 07:33:02
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 3D97FC433C6; Fri,  6 Nov 2020 07:33:02 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 78105C433CB;
        Fri,  6 Nov 2020 07:33:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 78105C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Wen Gong <wgong@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH] ath10k: cancel rx worker in hif_stop for SDIO
References: <1604558036-4056-1-git-send-email-wgong@codeaurora.org>
Date:   Fri, 06 Nov 2020 09:32:58 +0200
In-Reply-To: <1604558036-4056-1-git-send-email-wgong@codeaurora.org> (Wen
        Gong's message of "Thu, 5 Nov 2020 14:33:56 +0800")
Message-ID: <87r1p7kkid.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <wgong@codeaurora.org> writes:

> The rx worker of SDIO should be cancelled after disable interrupt, and
> release rx sk_buff in queue, otherwise the rx worker maybe still run
> after hif_stop. And it should be cancelled before napi_synchronize in
> hif_stop, because the rx worker of SDIO will call napi_schedule, it
> should have no napi_schedule before napi_synchronize, otherwise it
> lead napi_synchronize wait untill napi_complete.
>
> Tested-on: QCA6174 hw3.2 SDIO WLAN.RMH.4.4.1-00049
>
> Signed-off-by: Wen Gong <wgong@codeaurora.org>
> ---
>  drivers/net/wireless/ath/ath10k/sdio.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/net/wireless/ath/ath10k/sdio.c b/drivers/net/wireless/ath/ath10k/sdio.c
> index 81ddaafb6721..2c619ef8a87c 100644
> --- a/drivers/net/wireless/ath/ath10k/sdio.c
> +++ b/drivers/net/wireless/ath/ath10k/sdio.c
> @@ -1962,9 +1962,15 @@ static void ath10k_sdio_hif_stop(struct ath10k *ar)
>  {
>  	struct ath10k_sdio_bus_request *req, *tmp_req;
>  	struct ath10k_sdio *ar_sdio = ath10k_sdio_priv(ar);
> +	struct sk_buff *skb;
>  
>  	ath10k_sdio_irq_disable(ar);
>  
> +	cancel_work_sync(&ar_sdio->async_work_rx);
> +
> +	while (skb = skb_dequeue(&ar_sdio->rx_head))
> +		dev_kfree_skb_any(skb);

This gives a warning:

drivers/net/wireless/ath/ath10k/sdio.c: In function 'ath10k_sdio_hif_stop':
drivers/net/wireless/ath/ath10k/sdio.c:1971:9: warning: suggest parentheses around assignment used as truth value [-Wparentheses]

Fixed in the pending branch.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
