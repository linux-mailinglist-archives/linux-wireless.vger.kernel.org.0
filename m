Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB0321A364F
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Apr 2020 16:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727705AbgDIOyC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 9 Apr 2020 10:54:02 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:37177 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726940AbgDIOyC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 9 Apr 2020 10:54:02 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1586444042; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=8m8N/spe2Z+u0ec7luPWZFv5RMC+ATlrKjVKAVXWqrA=; b=hKb9tbLiGg8NtmVaLniGnK0hufbVzMeqIutsAGdmKd4zpedPbj0Kp9aurH0C580I4hCad6gp
 j+6YH3Fatfd8ebVnYJWQxsryRaQE4868J5TlJcsWw08u6+cjAxbYehqpae5z//3rK4qdZO3i
 bb/99xrwib0l0XPV23mxoQ239Ds=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e8f36ee.7fcc035910a0-smtp-out-n01;
 Thu, 09 Apr 2020 14:53:34 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 170C0C433CB; Thu,  9 Apr 2020 14:53:33 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 26616C433D2;
        Thu,  9 Apr 2020 14:53:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 26616C433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Wen Gong <wgong@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v9 3/4] ath10k: add htt TX bundle for sdio
References: <20200212080415.31265-1-wgong@codeaurora.org>
        <20200212080415.31265-4-wgong@codeaurora.org>
Date:   Thu, 09 Apr 2020 17:53:29 +0300
In-Reply-To: <20200212080415.31265-4-wgong@codeaurora.org> (Wen Gong's message
        of "Wed, 12 Feb 2020 16:04:14 +0800")
Message-ID: <87tv1su2vq.fsf@kamboji.qca.qualcomm.com>
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

> --- a/drivers/net/wireless/ath/ath10k/core.c
> +++ b/drivers/net/wireless/ath/ath10k/core.c
> @@ -3208,6 +3208,11 @@ struct ath10k *ath10k_core_create(size_t priv_size, struct device *dev,
>  	if (!ar->workqueue_aux)
>  		goto err_free_wq;
>  
> +	ar->workqueue_tx_complete =
> +		create_singlethread_workqueue("ath10k_tx_complete_wq");
> +	if (!ar->workqueue_tx_complete)
> +		goto err_free_aux_wq;

We already have three threads:

ath/ath10k/core.c:      ar->workqueue = create_singlethread_workqueue("ath10k_wq");
ath/ath10k/core.c:      ar->workqueue_aux = create_singlethread_workqueue("ath10k_aux_wq");
ath/ath10k/sdio.c:      ar_sdio->workqueue = create_singlethread_workqueue("ath10k_sdio_wq");

Do we really need a fourth one? For example, why can't we use
ar->workqueue_aux?

-- 
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
