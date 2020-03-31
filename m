Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1390F1994A6
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Mar 2020 13:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730535AbgCaLD2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 31 Mar 2020 07:03:28 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:11765 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730410AbgCaLD2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 31 Mar 2020 07:03:28 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1585652607; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=2rsGgE6kxJOfKICJK2M5MN0aGFpCfcgS/HPOQr3wV6w=; b=QilaceDS27uYFE7Dc+YTv45G6E+aTPzF3gtn6H4u2C9HxhaVEchTHg0Ak7J9ha7eSmCITsj1
 ftjUciuV3wfKcPw+vb5rZ5zvLYnF50T//Ar5w24i6z7OGpIg0LlGIbiGyUlM7YCVj42LlC8i
 15dQZ+fE0rV+EoiqoHnCZVLVe/4=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e83237e.7facd3ebe148-smtp-out-n02;
 Tue, 31 Mar 2020 11:03:26 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B8195C433BA; Tue, 31 Mar 2020 11:03:26 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 837BCC433D2;
        Tue, 31 Mar 2020 11:03:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 837BCC433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Qiujun Huang <hqjagain@gmail.com>
Cc:     ath9k-devel@qca.qualcomm.com, davem@davemloft.net,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, anenbupt@gmail.com
Subject: Re: [PATCH] ath9k: fix stack-out-of-bounds Write in ath9k_hif_usb_rx_cb
References: <1585625296-31013-1-git-send-email-hqjagain@gmail.com>
Date:   Tue, 31 Mar 2020 14:03:22 +0300
In-Reply-To: <1585625296-31013-1-git-send-email-hqjagain@gmail.com> (Qiujun
        Huang's message of "Tue, 31 Mar 2020 11:28:16 +0800")
Message-ID: <87bloc23d1.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Qiujun Huang <hqjagain@gmail.com> writes:

> Add barrier to accessing the stack array skb_pool.
>
> Reported-by: syzbot+d403396d4df67ad0bd5f@syzkaller.appspotmail.com
> Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
> ---
>  drivers/net/wireless/ath/ath9k/hif_usb.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/net/wireless/ath/ath9k/hif_usb.c b/drivers/net/wireless/ath/ath9k/hif_usb.c
> index dd0c323..c4a2b72 100644
> --- a/drivers/net/wireless/ath/ath9k/hif_usb.c
> +++ b/drivers/net/wireless/ath/ath9k/hif_usb.c
> @@ -612,6 +612,11 @@ static void ath9k_hif_usb_rx_stream(struct hif_device_usb *hif_dev,
>  			hif_dev->remain_skb = nskb;
>  			spin_unlock(&hif_dev->rx_lock);
>  		} else {
> +			if (pool_index == MAX_PKT_NUM_IN_TRANSFER) {
> +				dev_err(&hif_dev->udev->dev,
> +					"ath9k_htc: over RX MAX_PKT_NUM\n");
> +				goto err;
> +			}

What about 'pool_index >= MAX_PKT_NUM_IN_TRANSFER' just to be on the
safe side? Ah, but then error handling won't work:

err:
	for (i = 0; i < pool_index; i++) {
		RX_STAT_ADD(skb_completed_bytes, skb_pool[i]->len);
		ath9k_htc_rx_msg(hif_dev->htc_handle, skb_pool[i],
				 skb_pool[i]->len, USB_WLAN_RX_PIPE);
		RX_STAT_INC(skb_completed);
	}

Maybe that should use 'min(pool_index, MAX_PKT_NUM_IN_TRANSFER - 1)' or
something? Or maybe it's just overengineerin, dunno.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
