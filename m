Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7869C2ACEB4
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Nov 2020 05:59:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730756AbgKJE7s (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Nov 2020 23:59:48 -0500
Received: from m42-4.mailgun.net ([69.72.42.4]:38891 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729454AbgKJE7r (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Nov 2020 23:59:47 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1604984386; h=Message-ID: References: In-Reply-To: Subject:
 To: From: Date: Content-Transfer-Encoding: Content-Type: MIME-Version:
 Sender; bh=MaB10dSDs4m3qPKJpKROb0mTeB/W4kEIiYvhD+CDHDk=; b=I/fAqC8R9Kvb947nuYUgxX98FcDOKK6Bdw7GMxCYVbNHy2SoSRBSW2A6rS2kPULH3QifA8+g
 DYaieCkB/+XOajdUvD4ev1mXpcZO4+ztV9hRulmTl8H0Ph1hHRDcjUWIwNnCioLzujd9Tg0B
 9id7+UCV1nHlO8o4/zgqNbGmF5o=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 5faa1e23f153feb1e8ef149f (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 10 Nov 2020 04:59:15
 GMT
Sender: mkenna=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 1EFC5C433C9; Tue, 10 Nov 2020 04:59:15 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: mkenna)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 03192C433C8;
        Tue, 10 Nov 2020 04:59:12 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 10 Nov 2020 10:29:12 +0530
From:   Maharaja Kennadyrajan <mkenna@codeaurora.org>
To:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
Subject: Re: [PATCH] ath11k: Fix the rx_filter flag setting for peer rssi
 stats
In-Reply-To: <1604408857-5912-1-git-send-email-mkenna@codeaurora.org>
References: <1604408857-5912-1-git-send-email-mkenna@codeaurora.org>
Message-ID: <4d2ad5a7a45c1d8c2550ebdbf634d688@codeaurora.org>
X-Sender: mkenna@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-11-03 18:37, Maharaja Kennadyrajan wrote:
> Set the rx_filter in ath11k_mac_config_mon_status_default(),
> only when the rx_filter value exists in ath11k_debug_rx_filter().
> 
> Without this change, rx_filter gets set to 0 and peer rssi stats
> aren't updating properly from firmware.
> 
> Tested-on: IPQ8074 WLAN.HK.2.1.0.1-01230-QCAHKSWPL_SILICONZ-4
> 
> Signed-off-by: Maharaja Kennadyrajan <mkenna@codeaurora.org>
> ---
>  drivers/net/wireless/ath/ath11k/mac.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/mac.c
> b/drivers/net/wireless/ath/ath11k/mac.c
> index 7f8dd47..c2d013a 100644
> --- a/drivers/net/wireless/ath/ath11k/mac.c
> +++ b/drivers/net/wireless/ath/ath11k/mac.c
> @@ -4094,7 +4094,8 @@ static int
> ath11k_mac_config_mon_status_default(struct ath11k *ar, bool enable)
> 
>  	if (enable) {
>  		tlv_filter = ath11k_mac_mon_status_filter_default;
> -		tlv_filter.rx_filter = ath11k_debugfs_rx_filter(ar);
> +		if (ath11k_debug_rx_filter(ar))
> +			tlv_filter.rx_filter = ath11k_debug_rx_filter(ar);
>  	}
> 
>  	for (i = 0; i < ab->hw_params.num_rxmda_per_pdev; i++) {

[Maha]: Hi all, please drop this patch as this patch needs a comment to 
be addressed.
I will send v2 patch.

Regards,
Maha
