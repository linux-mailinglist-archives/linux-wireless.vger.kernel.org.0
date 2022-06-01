Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB9B53AFE2
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jun 2022 00:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbiFAUwX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Jun 2022 16:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231181AbiFAUwK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Jun 2022 16:52:10 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEAE21C926F
        for <linux-wireless@vger.kernel.org>; Wed,  1 Jun 2022 13:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1654116662; x=1685652662;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0nFXnQ37/awaKQICaD8CGQ++kuJwX2JMyTTgWh2bDxE=;
  b=VHiR0GvCn2W45lgzQHg7s5A17FIZ9Ff8KGJcONJkH8Q50ANkzkpCK262
   yotjYmVvAIXXUsaR72za8hnzJihQjUg9xI+irIZF11nk0TxG/Piqwruou
   0voB3Eu/JBJ15YqwbYfO/EnzGTFiW/zyYpvFme0D2+RSTfFLLb3jZM8TM
   g=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 01 Jun 2022 12:09:50 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2022 12:09:50 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 1 Jun 2022 12:09:50 -0700
Received: from [10.110.9.238] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 1 Jun 2022
 12:09:48 -0700
Message-ID: <4f289038-c5ca-ce55-edc8-45ff98efc716@quicinc.com>
Date:   Wed, 1 Jun 2022 12:09:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 1/2] ath11k: fix missing srng_access_end in CE
Content-Language: en-US
To:     Christian 'Ansuel' Marangi <ansuelsmth@gmail.com>,
        <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>
References: <20220528142516.20819-1-ansuelsmth@gmail.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20220528142516.20819-1-ansuelsmth@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 5/28/2022 7:25 AM, Christian 'Ansuel' Marangi wrote:
> When a CE completed send next operation is done, the srng access end is
> never called. Correctly end the srng access to make sure we have the
> correct values in the srng struct.
> 
> Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.5.0.1-01208-QCAHKSWPL_SILICONZ-1
> 
> Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")
> Signed-off-by: Christian 'Ansuel' Marangi <ansuelsmth@gmail.com>
> ---
>   drivers/net/wireless/ath/ath11k/ce.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/ce.c b/drivers/net/wireless/ath/ath11k/ce.c
> index c14c51f38709..665205d2322e 100644
> --- a/drivers/net/wireless/ath/ath11k/ce.c
> +++ b/drivers/net/wireless/ath/ath11k/ce.c
> @@ -490,6 +490,8 @@ static struct sk_buff *ath11k_ce_completed_send_next(struct ath11k_ce_pipe *pipe
>   	pipe->src_ring->sw_index = sw_index;
>   
>   err_unlock:
> +	ath11k_hal_srng_access_end(ab, srng);
> +
>   	spin_unlock_bh(&srng->lock);
>   
>   	spin_unlock_bh(&ab->ce.ce_lock);

NAK -- Not calling ath11k_hal_srng_access_end() is intentional.

CE_SRC ring is a special ring, we perform tx_request and tx_completion 
on the same ring. The completion processing frees SKBs associated to the 
ce_desc, this is what ath11k_ce_completed_send_next() does, it does not 
update the head pointer to hw because the ce_desc at hp does not have 
any new data, it is just available for new messages. ath11k_ce_send() 
retrieves a processed (processed by ath11k_ce_completed_send_next) 
ce_desc and sets it up for the new message. Then it updates the hw about 
the newly available ce_desc by calling ath11k_hal_srng_access_end().

If you want to do anything here, adding a comment based upon the above 
would be good.

/jeff
