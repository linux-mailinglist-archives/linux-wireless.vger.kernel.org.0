Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EFC51C8228
	for <lists+linux-wireless@lfdr.de>; Thu,  7 May 2020 08:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725857AbgEGGHZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 7 May 2020 02:07:25 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:39252 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725793AbgEGGHY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 7 May 2020 02:07:24 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588831644; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=w52CLOliTGUIv4DY+s5b588tvhYB84FRFaDJLCmhljA=; b=de/HD2zdVOq3RPWsnytvR5WZXl9+v6Q8ixtBPebBLKEeyAKPRuKzDJzuwN9vlyMk6xRSABjt
 rb4cGziMUz6uVNkAyisjFcBB09qICJrTDcf/dXzEhEoBVdIPz7dLDMMm+Y2IdTkYoVKcJFIE
 BFTiy6zRT+v8eqIaNR2E6KInWas=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eb3a593.7feb87a099d0-smtp-out-n02;
 Thu, 07 May 2020 06:07:15 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 91184C433BA; Thu,  7 May 2020 06:07:15 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EBEAEC433D2;
        Thu,  7 May 2020 06:07:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EBEAEC433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Rakesh Pillai <pillair@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ath10k: Remove msdu from idr when management pkt send fails
References: <1588667015-25490-1-git-send-email-pillair@codeaurora.org>
Date:   Thu, 07 May 2020 09:07:11 +0300
In-Reply-To: <1588667015-25490-1-git-send-email-pillair@codeaurora.org>
        (Rakesh Pillai's message of "Tue, 5 May 2020 13:53:35 +0530")
Message-ID: <875zd88ei8.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Rakesh Pillai <pillair@codeaurora.org> writes:

> Currently when the sending of any management pkt
> via wmi command fails, the packet is being unmapped
> freed in the error handling. But the idr entry added,
> which is used to track these packet is not getting removed.
>
> Hence, during unload, in wmi cleanup, all the entries
> in IDR are removed and the corresponding buffer is
> attempted to be freed. This can cause a situation where
> one packet is attempted to be freed twice.
>
> Fix this error by rmeoving the msdu from the idr
> list when the sending of a management packet over
> wmi fails.
>
> Tested HW: WCN3990
> Tested FW: WLAN.HL.3.1-01040-QCAHLSWMTPLZ-1
>
> Fixes: 1807da49733e ("ath10k: wmi: add management tx by reference support over wmi")
> Signed-off-by: Rakesh Pillai <pillair@codeaurora.org>

[...]

> --- a/drivers/net/wireless/ath/ath10k/wmi-ops.h
> +++ b/drivers/net/wireless/ath/ath10k/wmi-ops.h
> @@ -133,6 +133,7 @@ struct wmi_ops {
>  	struct sk_buff *(*gen_mgmt_tx_send)(struct ath10k *ar,
>  					    struct sk_buff *skb,
>  					    dma_addr_t paddr);
> +	int (*cleanup_mgmt_tx_send)(struct ath10k *ar, struct sk_buff *msdu);
>  	struct sk_buff *(*gen_dbglog_cfg)(struct ath10k *ar, u64 module_enable,
>  					  u32 log_level);
>  	struct sk_buff *(*gen_pktlog_enable)(struct ath10k *ar, u32 filter);
> @@ -442,6 +443,15 @@ ath10k_wmi_get_txbf_conf_scheme(struct ath10k *ar)
>  }
>  
>  static inline int
> +ath10k_wmi_cleanup_mgmt_tx_send(struct ath10k *ar, struct sk_buff *msdu)
> +{
> +	if (!ar->wmi.ops->cleanup_mgmt_tx_send)
> +		return -EOPNOTSUPP;
> +
> +	return ar->wmi.ops->cleanup_mgmt_tx_send(ar, msdu);
> +}
> +
> +static inline int
>  ath10k_wmi_mgmt_tx_send(struct ath10k *ar, struct sk_buff *msdu,
>  			dma_addr_t paddr)
>  {
> @@ -457,8 +467,11 @@ ath10k_wmi_mgmt_tx_send(struct ath10k *ar, struct sk_buff *msdu,
>  
>  	ret = ath10k_wmi_cmd_send(ar, skb,
>  				  ar->wmi.cmd->mgmt_tx_send_cmdid);
> -	if (ret)
> +	if (ret) {
> +		/* remove this msdu from idr tracking */
> +		ath10k_wmi_cleanup_mgmt_tx_send(ar, msdu);
>  		return ret;
> +	}

I missed that this call was in wmi-ops.h, but the idea is that file
should be just a dumb wrapper and not have any logic. So I moved this to
mac.c, the functionality should be the same but please do check my
changes:

https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=master-pending&id=71195d2244ed812c73dc617f7536566400f7ce87

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
