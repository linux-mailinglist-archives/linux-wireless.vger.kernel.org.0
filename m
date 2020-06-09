Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01A131F3425
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jun 2020 08:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbgFIGhl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 9 Jun 2020 02:37:41 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:42354 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726886AbgFIGhl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 9 Jun 2020 02:37:41 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1591684661; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=reOd9SJWFYGO0ZUe81fiFygXGGIlBmXify7Omrkn6G4=; b=YgnNL3Hq8ppJW6iGiuYnckNW2oG2/f0KUHFzU4Rlv66tOPI1iyPHv1OzA/JcqLLgSksD1JYL
 +JCOLV4CDPvav6na61Cga6BAZLZsimOn+oGeSQCPkognRIJSy1G+h20RbB8BTWwRkzSVwTAz
 MRO670owXfV28Lv6q4KdBHTBt4Q=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n11.prod.us-east-1.postgun.com with SMTP id
 5edf2e33d9f1a4ceef5a4c15 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 09 Jun 2020 06:37:39
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 06AC1C433C6; Tue,  9 Jun 2020 06:37:39 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A4CDCC433CA;
        Tue,  9 Jun 2020 06:37:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A4CDCC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v5 7/8] ath11k: Send multiple scan_chan_list messages if required
References: <20200603001724.12161-1-pradeepc@codeaurora.org>
        <20200603001724.12161-8-pradeepc@codeaurora.org>
Date:   Tue, 09 Jun 2020 09:37:35 +0300
In-Reply-To: <20200603001724.12161-8-pradeepc@codeaurora.org> (Pradeep Kumar
        Chitrapu's message of "Tue, 2 Jun 2020 17:17:23 -0700")
Message-ID: <87ftb4zqvk.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Pradeep Kumar Chitrapu <pradeepc@codeaurora.org> writes:

> With addition of 6Ghz channels, it is possible that wmi buffer size can
> exceed the maximum wmi buffer size. So iterate over the channel list,
> and send multiple messages till channel list is empty.
> Also mark PSC channel flag for 6GHz channels accordingly.
>
> Signed-off-by: Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
> ---
>  drivers/net/wireless/ath/ath11k/wmi.c | 170 ++++++++++++++------------
>  drivers/net/wireless/ath/ath11k/wmi.h |   3 +
>  2 files changed, 98 insertions(+), 75 deletions(-)
>
> diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
> index 239a336f55f4..ad3a7b68d308 100644
> --- a/drivers/net/wireless/ath/ath11k/wmi.c
> +++ b/drivers/net/wireless/ath/ath11k/wmi.c
> @@ -2194,91 +2194,111 @@ int ath11k_wmi_send_scan_chan_list_cmd(struct ath11k *ar,
>  	struct channel_param *tchan_info;
>  	struct wmi_tlv *tlv;
>  	void *ptr;
> -	int i, ret, len;
> +	int i, ret = 0, len;
> +	u16 num_send_chans, num_sends = 0, max_chan_limit = 0;
>  	u32 *reg1, *reg2;
>  

[...]

> +		ret = ath11k_wmi_cmd_send(wmi, skb, WMI_SCAN_CHAN_LIST_CMDID);
> +		if (ret) {
> +			ath11k_warn(ar->ab, "failed to send WMI_SCAN_CHAN_LIST cmd\n");
> +			dev_kfree_skb(skb);
> +			goto end;
> +		}
> +
> +		num_sends++;
> +	}
> +end:
>  	return ret;
>  }

The end label is useless, I removed that and replaced the goto with
'return ret'. And I replaced the return in the end to 'return 0' which
made it possible to not initialise the ret variable. Please check my
changes in the pending branch (which I will push shortly).

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
