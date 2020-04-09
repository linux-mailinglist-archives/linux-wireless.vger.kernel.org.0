Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1992E1A3690
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Apr 2020 17:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727884AbgDIPGB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 9 Apr 2020 11:06:01 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:56197 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727801AbgDIPGB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 9 Apr 2020 11:06:01 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1586444761; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=7KHDKvLbxU/THY3EFbTz9kpu3q/j3kdS9KYHkOOT2xA=; b=VNXccUG9LXQh/RtWtLA5TOJDSR1tNU1jzcIZBspHDFS0/1wV8u1ME36kl7iK7ZGYWOyyw96N
 mNNXsujSzpAe6PMUiSvQZD8I9pZJhM5CpYlMvEnkE3fYwlX50F4vuIbiiLID1vUO8HrzzpOw
 yFGvOAhXhZuFXWNkDZjVg8l/NG4=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e8f39ce.7f6ee94fcc00-smtp-out-n02;
 Thu, 09 Apr 2020 15:05:50 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 4B0C4C43636; Thu,  9 Apr 2020 15:05:49 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A29E4C433BA;
        Thu,  9 Apr 2020 15:05:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A29E4C433BA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Wen Gong <wgong@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v9 3/4] ath10k: add htt TX bundle for sdio
References: <20200212080415.31265-1-wgong@codeaurora.org>
        <20200212080415.31265-4-wgong@codeaurora.org>
Date:   Thu, 09 Apr 2020 18:05:45 +0300
In-Reply-To: <20200212080415.31265-4-wgong@codeaurora.org> (Wen Gong's message
        of "Wed, 12 Feb 2020 16:04:14 +0800")
Message-ID: <87pncgu2ba.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <wgong@codeaurora.org> writes:

> The transmission utilization ratio for sdio bus for small packet is
> slow, because the space and time cost for sdio bus is same for large
> length packet and small length packet. So the speed of data for large
> length packet is higher than small length.
>
> Test result of different length of data:
>
> data packet(byte)   cost time(us)   calculated rate(Mbps)
>       256               28                73
>       512               33               124
>      1024               35               234
>      1792               45               318
>     14336              168               682
>     28672              333               688
>     57344              660               695
>
> This patch change the TX packet from single packet to a large length
> bundle packet, max size is 32, it results in significant performance
> improvement on TX path.
>
> This patch only effect sdio chip, it will not effect PCI, SNOC etc.
> It only enable bundle for sdio chip.
>
> Tested with QCA6174 SDIO with firmware
> WLAN.RMH.4.4.1-00017-QCARMSWP-1.
>
> Signed-off-by: Wen Gong <wgong@codeaurora.org>

[...]

> +	if (ep->tx_credits < credits) {
> +		ath10k_dbg(ar, ATH10K_DBG_HTC,
> +			   "htc insufficient credits ep %d required %d available %d consume %d\n",
> +			   eid, credits, ep->tx_credits, consume);
> +		ret = -EAGAIN;
> +		goto unlock;
> +	}
> +
> +	if (consume) {
> +		ep->tx_credits -= credits;
> +		ath10k_dbg(ar, ATH10K_DBG_HTC,
> +			   "htc ep %d consumed %d credits (total %d)\n",

"htc ep %d consumed %d credits total %d\n"

[...]

> +	ath10k_dbg(ar, ATH10K_DBG_HTC, "bundle skb: len:%d\n", bundle_skb->len);

"htc bundle skb len %d\n"

In other words, start with "htc" and don't use colons or parenthesis.
This applies to most of debug messages in this patch.

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
