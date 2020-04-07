Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2D991A06F7
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Apr 2020 08:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbgDGGFI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 7 Apr 2020 02:05:08 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:54828 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725802AbgDGGFI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 7 Apr 2020 02:05:08 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1586239508; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=l2BX3DW7f+kIAUgg3GSBQBTcbYplv8Hi35NXfP+n2a0=;
 b=soHSvvsvxJP7/WxuhFRe8n+bIrYx3i0GUPxjP5lJ0WW9HtVFYm+dgx2CEVglr2XfPjUkttn6
 3Zkz6YiLN6JLauSeAP8itZwl6KQn6KAUzU7QaH70/S3rsSNr8HwX6NpZhUDhqX9BAIOuwMVE
 hXoUNPZbBh1TRxdBch3cXpLGWp0=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e8c180a.7f6fd301c570-smtp-out-n01;
 Tue, 07 Apr 2020 06:04:58 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B56BAC433F2; Tue,  7 Apr 2020 06:04:58 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5CA73C433D2;
        Tue,  7 Apr 2020 06:04:58 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 07 Apr 2020 14:04:58 +0800
From:   Wen Gong <wgong@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v9 1/4] ath10k: disable TX complete indication of htt for
 sdio
In-Reply-To: <20200407054431.6B2A0C433BA@smtp.codeaurora.org>
References: <20200212080415.31265-2-wgong@codeaurora.org>
 <20200407054431.6B2A0C433BA@smtp.codeaurora.org>
Message-ID: <84039fe1187e3ec7546edd4f9fe5600a@codeaurora.org>
X-Sender: wgong@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2020-04-07 13:44, Kalle Valo wrote:

> This has new warnings:
> 
> drivers/net/wireless/ath/ath10k/htt_tx.c: In function
> 'ath10k_htt_htc_tx_complete':
> drivers/net/wireless/ath/ath10k/htt_tx.c:566:30: warning: 'msg_type'
> may be used uninitialized in this function [-Wmaybe-uninitialized]
> drivers/net/wireless/ath/ath10k/htt_tx.c:573:6: warning: 'flags1' may
> be used uninitialized in this function [-Wmaybe-uninitialized]
> drivers/net/wireless/ath/ath10k/htt_tx.c:577:42: warning: 'desc_hdr'
> may be used uninitialized in this function [-Wmaybe-uninitialized]
> 

I already run ath10k-check, but not see these warnings.
my gcc: gcc (Ubuntu 4.8.4-2ubuntu1~14.04.4) 4.8.4
so is it because my gcc too version too low?

>> From what I can see these are false positives, but please do double 
>> check that. In
> the pending branch I solved it like this:
> 
> --- a/drivers/net/wireless/ath/ath10k/htt_tx.c
> +++ b/drivers/net/wireless/ath/ath10k/htt_tx.c
> @@ -546,9 +546,9 @@ void ath10k_htt_htc_tx_complete(struct ath10k *ar,
> struct sk_buff *skb)
>         struct ath10k_htt *htt = &ar->htt;
>         struct htt_tx_done tx_done = {0};
>         struct htt_cmd_hdr *htt_hdr;
> -       struct htt_data_tx_desc *desc_hdr;
> -       u16 flags1;
> -       u8 msg_type;
> +       struct htt_data_tx_desc *desc_hdr = NULL;
> +       u16 flags1 = 0;
> +       u8 msg_type = 0;
> 
>         if (htt->disable_tx_comp) {
>                 htt_hdr = (struct htt_cmd_hdr *)skb->data;
