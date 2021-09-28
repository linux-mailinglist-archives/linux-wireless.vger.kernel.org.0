Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B7EF41AD3E
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Sep 2021 12:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240264AbhI1Ksr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 Sep 2021 06:48:47 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:56722 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240280AbhI1Ksp (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 Sep 2021 06:48:45 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1632826026; h=Content-Type: MIME-Version: Message-ID:
 In-Reply-To: Date: References: Subject: Cc: To: From: Sender;
 bh=5VxBcWj7WadgElMm3An2ujPwLljXKPv67MUI7mVEm28=; b=FTd8i+z/+tO3EdnS5IHvrF/FsUKZv8wGmVcoyWO0Viv3HPo1439gfcdJq6w0uRRxVvA+XdfG
 1AZfxPfiN7gZVc9CDJLLSNS5PxMKUntZ5Toc95zet4We8sBJdr/751hFJNs+m3KsZy8+Gc0C
 pRhmu75AWV8iluU5DSKz7h5wK7w=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 6152f2a9713d5d6f96f7d4bc (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 28 Sep 2021 10:47:05
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id BD045C4360D; Tue, 28 Sep 2021 10:47:04 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from tykki (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E4E98C4338F;
        Tue, 28 Sep 2021 10:47:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org E4E98C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     Jouni Malinen <jouni@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Rameshkumar Sundaram <ramess@codeaurora.org>,
        Sathishkumar Muruganandam <murugana@codeaurora.org>
Subject: Re: [PATCH 10/12] ath11k: Send PPDU_STATS_CFG with proper pdev mask to firmware
References: <20210721212029.142388-1-jouni@codeaurora.org>
        <20210721212029.142388-10-jouni@codeaurora.org>
Date:   Tue, 28 Sep 2021 13:46:58 +0300
In-Reply-To: <20210721212029.142388-10-jouni@codeaurora.org> (Jouni Malinen's
        message of "Thu, 22 Jul 2021 00:20:27 +0300")
Message-ID: <87a6jxq8nx.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Jouni Malinen <jouni@codeaurora.org> writes:

> From: Rameshkumar Sundaram <ramess@codeaurora.org>
>
> HTT_PPDU_STATS_CFG_PDEV_ID bit mask for target FW PPDU stats request
> message was set as bit 8 to 15. Bit 8 is reserved for soc stats and
> pdev id starts from bit 9. Hence change the bitmask as bit 9 to 15
> and fill the proper pdev id in the request message.
>
> Tested on: IPQ8074 hw2.0 AHB WLAN.HK.2.5.0.1-01092-QCAHKSWPL_SILICONZ-1
> Tested on: IPQ6018 hw1.0 WLAN.HK.2.5.0.1-01067-QCAHKSWPL_SILICONZ-1
>
> Fixes: 701e48a43e15 ("ath11k: add packet log support for QCA6390")
>
> Co-developed-by: Sathishkumar Muruganandam <murugana@codeaurora.org>
> Signed-off-by: Sathishkumar Muruganandam <murugana@codeaurora.org>
> Signed-off-by: Rameshkumar Sundaram <ramess@codeaurora.org>
> Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
> ---
>  drivers/net/wireless/ath/ath11k/dp.h    | 3 ++-
>  drivers/net/wireless/ath/ath11k/dp_tx.c | 2 +-
>  2 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/wireless/ath/ath11k/dp.h b/drivers/net/wireless/ath/ath11k/dp.h
> index b2e7621969c5..522d3a6ce253 100644
> --- a/drivers/net/wireless/ath/ath11k/dp.h
> +++ b/drivers/net/wireless/ath/ath11k/dp.h
> @@ -541,7 +541,8 @@ struct htt_ppdu_stats_cfg_cmd {
>  } __packed;
>  
>  #define HTT_PPDU_STATS_CFG_MSG_TYPE		GENMASK(7, 0)
> -#define HTT_PPDU_STATS_CFG_PDEV_ID		GENMASK(15, 8)
> +#define HTT_PPDU_STATS_CFG_SOC_STATS		BIT(8)
> +#define HTT_PPDU_STATS_CFG_PDEV_ID		GENMASK(15, 9)

This part is clear after reading the commit log.

> --- a/drivers/net/wireless/ath/ath11k/dp_tx.c
> +++ b/drivers/net/wireless/ath/ath11k/dp_tx.c
> @@ -906,7 +906,7 @@ int ath11k_dp_tx_htt_h2t_ppdu_stats_req(struct ath11k *ar, u32 mask)
>  		cmd->msg = FIELD_PREP(HTT_PPDU_STATS_CFG_MSG_TYPE,
>  				      HTT_H2T_MSG_TYPE_PPDU_STATS_CFG);
>  
> -		pdev_mask = 1 << (i + 1);
> +		pdev_mask = 1 << (ar->pdev_idx + i);
>  		cmd->msg |= FIELD_PREP(HTT_PPDU_STATS_CFG_PDEV_ID, pdev_mask);
>  		cmd->msg |= FIELD_PREP(HTT_PPDU_STATS_CFG_TLV_TYPE_BITMASK, mask);

But this part isn't. All I can see in the commit log is a vague comment
"and fill the proper pdev id in the request message" and nothing else.
Please provide a proper explanation for this change and I can then add
that to the commit log.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
