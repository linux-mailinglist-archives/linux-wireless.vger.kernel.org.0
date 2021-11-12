Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B58B144E2EB
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Nov 2021 09:19:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232346AbhKLIWV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 12 Nov 2021 03:22:21 -0500
Received: from so254-9.mailgun.net ([198.61.254.9]:31987 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230464AbhKLIWU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 12 Nov 2021 03:22:20 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1636705170; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=vJ8XMjUmB9hs5cs/fta2oLXbbtvRPmJPu2pUdlMQqRY=; b=TzxS0cRFP8wRwiYsBZRXZ+/noX4isVM9dgh8YgBMJHih+hadPWXRSiKEoGPZGwt8G1RyOBWk
 /PYL3w5QYYffR+pNf8r1LbumZ8GHPlK7oEcz2m3cfZP98LeYrue7xUHxh3FqlX7eC2FfXJF3
 zUTbsCDRUy2VvilVwPargzf1mAs=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 618e239272f0f555984f8318 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 12 Nov 2021 08:19:30
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id AF23FC4360D; Fri, 12 Nov 2021 08:19:29 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8D8A8C4338F;
        Fri, 12 Nov 2021 08:19:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 8D8A8C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Jouni Malinen <jouni@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Seevalamuthu Mariappan <seevalam@codeaurora.org>,
        Anilkumar Kolli <akolli@codeaurora.org>
Subject: Re: [PATCH 12/12] ath11k: Change QCN9074 firmware to operate in mode-2
References: <20210721212029.142388-1-jouni@codeaurora.org>
        <20210721212029.142388-12-jouni@codeaurora.org>
Date:   Fri, 12 Nov 2021 10:19:23 +0200
In-Reply-To: <20210721212029.142388-12-jouni@codeaurora.org> (Jouni Malinen's
        message of "Thu, 22 Jul 2021 00:20:29 +0300")
Message-ID: <871r3lkcqc.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Jouni Malinen <jouni@codeaurora.org> writes:

> From: Seevalamuthu Mariappan <seevalam@codeaurora.org>
>
> In mode-2 QCN9074 firmware uses 15 MB of host memory and firmware
> request 1 MB size segments in QMI, whereas in mode-0 firmware uses 45 MB
> of host memory and each segment is of 2 MB size. In mode-2 firmware
> operates with reduced number of vdevs and peers.
>
> Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.4.0.1-01838-QCAHKSWPL_SILICONZ-1
>
> Signed-off-by: Seevalamuthu Mariappan <seevalam@codeaurora.org>
> Co-developed-by: Anilkumar Kolli <akolli@codeaurora.org>
> Signed-off-by: Anilkumar Kolli <akolli@codeaurora.org>
> Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
> ---
>  drivers/net/wireless/ath/ath11k/core.c | 23 ++++++++++++++++++++++-
>  drivers/net/wireless/ath/ath11k/core.h |  6 ++++++
>  drivers/net/wireless/ath/ath11k/hw.c   | 14 +++++++-------
>  drivers/net/wireless/ath/ath11k/hw.h   | 20 +++++++++++---------
>  drivers/net/wireless/ath/ath11k/mac.c  | 10 +++++-----
>  drivers/net/wireless/ath/ath11k/qmi.c  |  2 +-
>  6 files changed, 52 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
> index d2ab3b134632..9f2c9795767e 100644
> --- a/drivers/net/wireless/ath/ath11k/core.c
> +++ b/drivers/net/wireless/ath/ath11k/core.c
> @@ -77,6 +77,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
>  		.supports_shadow_regs = false,
>  		.idle_ps = false,
>  		.cold_boot_calib = true,
> +		.fw_mem_mode = 0,
>  		.supports_suspend = false,
>  		.hal_desc_sz = sizeof(struct hal_rx_desc_ipq8074),
>  		.fix_l1ss = true,

[...]

> +static const struct ath11k_num_vdevs_peers ath11k_vdevs_peers[] = {
> +	{
> +		.num_vdevs = (16 + 1),
> +		.num_peers = 512,
> +	},
> +	{
> +		.num_vdevs = (8 + 1),
> +		.num_peers = 128,
> +	},
> +	{
> +		.num_vdevs = 8,
> +		.num_peers = 128,
> +	},
> +};

I am worried about this array. It implies that _all_ hardware support
these modes but is that really the case? I would guess that these are
very much hardware and firmware specific values.

So because of that I would feel clearer to have num_vdevs and num_peers
in ath11k_hw_params, to make it clear that the values are hardware
specific. And then have fw_mem_mode, num_vdevs and num_peers in their
own struct within struct ath11k_hw_params, just like spectral has
grouped valued together.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
