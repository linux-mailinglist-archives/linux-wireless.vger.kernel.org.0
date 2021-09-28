Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49BC041AE62
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Sep 2021 14:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240457AbhI1MDj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 28 Sep 2021 08:03:39 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:12627 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240410AbhI1MDi (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 28 Sep 2021 08:03:38 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1632830519; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=HfBGPX+AtSvHhPxa35WuC6Y62tQn06H4I5i2eOknHF0=;
 b=IZFfStAIKy2eiv501vJwz6ZdxKA/Hn/3GKEAE041rvVkRtkK3zBEPc8jipG/WNLjcjvNwM5P
 y7UJgWPbBQ4zUK0BDDziPka1iTE2YO7YPiSStYmytjGWvienXt58pO3E2ka7oCN4aLwemUui
 3Qhiz+fHWTO2Ofcw99wUe5UDfVQ=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 6153040fb62327f2cb146827 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 28 Sep 2021 12:01:19
 GMT
Sender: ramess=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 651B0C43460; Tue, 28 Sep 2021 12:01:18 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: ramess)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id F037DC4338F;
        Tue, 28 Sep 2021 12:01:17 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 28 Sep 2021 17:31:17 +0530
From:   Rameshkumar Sundaram <ramess@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Jouni Malinen <jouni@codeaurora.org>, ath11k@lists.infradead.org,
        linux-wireless@vger.kernel.org,
        Sathishkumar Muruganandam <murugana@codeaurora.org>
Subject: Re: [PATCH 10/12] ath11k: Send PPDU_STATS_CFG with proper pdev mask
 to firmware
In-Reply-To: <87a6jxq8nx.fsf@codeaurora.org>
References: <20210721212029.142388-1-jouni@codeaurora.org>
 <20210721212029.142388-10-jouni@codeaurora.org>
 <87a6jxq8nx.fsf@codeaurora.org>
Message-ID: <83ee98a2c461e16800dd80ba75429b63@codeaurora.org>
X-Sender: ramess@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2021-09-28 16:16, Kalle Valo wrote:
> Jouni Malinen <jouni@codeaurora.org> writes:
> 
>> From: Rameshkumar Sundaram <ramess@codeaurora.org>
>> 
>> HTT_PPDU_STATS_CFG_PDEV_ID bit mask for target FW PPDU stats request
>> message was set as bit 8 to 15. Bit 8 is reserved for soc stats and
>> pdev id starts from bit 9. Hence change the bitmask as bit 9 to 15
>> and fill the proper pdev id in the request message.
>> 
>> Tested on: IPQ8074 hw2.0 AHB 
>> WLAN.HK.2.5.0.1-01092-QCAHKSWPL_SILICONZ-1
>> Tested on: IPQ6018 hw1.0 WLAN.HK.2.5.0.1-01067-QCAHKSWPL_SILICONZ-1
>> 
>> Fixes: 701e48a43e15 ("ath11k: add packet log support for QCA6390")
>> 
>> Co-developed-by: Sathishkumar Muruganandam <murugana@codeaurora.org>
>> Signed-off-by: Sathishkumar Muruganandam <murugana@codeaurora.org>
>> Signed-off-by: Rameshkumar Sundaram <ramess@codeaurora.org>
>> Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
>> ---
>>  drivers/net/wireless/ath/ath11k/dp.h    | 3 ++-
>>  drivers/net/wireless/ath/ath11k/dp_tx.c | 2 +-
>>  2 files changed, 3 insertions(+), 2 deletions(-)
>> 
>> diff --git a/drivers/net/wireless/ath/ath11k/dp.h 
>> b/drivers/net/wireless/ath/ath11k/dp.h
>> index b2e7621969c5..522d3a6ce253 100644
>> --- a/drivers/net/wireless/ath/ath11k/dp.h
>> +++ b/drivers/net/wireless/ath/ath11k/dp.h
>> @@ -541,7 +541,8 @@ struct htt_ppdu_stats_cfg_cmd {
>>  } __packed;
>> 
>>  #define HTT_PPDU_STATS_CFG_MSG_TYPE		GENMASK(7, 0)
>> -#define HTT_PPDU_STATS_CFG_PDEV_ID		GENMASK(15, 8)
>> +#define HTT_PPDU_STATS_CFG_SOC_STATS		BIT(8)
>> +#define HTT_PPDU_STATS_CFG_PDEV_ID		GENMASK(15, 9)
> 
> This part is clear after reading the commit log.
> 
>> --- a/drivers/net/wireless/ath/ath11k/dp_tx.c
>> +++ b/drivers/net/wireless/ath/ath11k/dp_tx.c
>> @@ -906,7 +906,7 @@ int ath11k_dp_tx_htt_h2t_ppdu_stats_req(struct 
>> ath11k *ar, u32 mask)
>>  		cmd->msg = FIELD_PREP(HTT_PPDU_STATS_CFG_MSG_TYPE,
>>  				      HTT_H2T_MSG_TYPE_PPDU_STATS_CFG);
>> 
>> -		pdev_mask = 1 << (i + 1);
>> +		pdev_mask = 1 << (ar->pdev_idx + i);
>>  		cmd->msg |= FIELD_PREP(HTT_PPDU_STATS_CFG_PDEV_ID, pdev_mask);
>>  		cmd->msg |= FIELD_PREP(HTT_PPDU_STATS_CFG_TLV_TYPE_BITMASK, mask);
> 
> But this part isn't. All I can see in the commit log is a vague comment
> "and fill the proper pdev id in the request message" and nothing else.
> Please provide a proper explanation for this change and I can then add
> that to the commit log.

Hi Kalle,
In patch 701e48a43e15 ("ath11k: add packet log support for QCA6390") ,
both HTT_PPDU_STATS_CFG_PDEV_ID and pdev_mask were changed, but this 
pdev_mask calculation
is not valid for platforms which has multiple pdevs with 1 rxdma per 
pdev, as this is writing same value(i.e. 2) for all pdevs.
Hence fixed it to consider pdev_idx as well, to make it compatible for 
both single and multi pd cases.

