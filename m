Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB0E05397FA
	for <lists+linux-wireless@lfdr.de>; Tue, 31 May 2022 22:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347753AbiEaUcZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 31 May 2022 16:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347752AbiEaUcY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 31 May 2022 16:32:24 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BA5A2E08E
        for <linux-wireless@vger.kernel.org>; Tue, 31 May 2022 13:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1654029141; x=1685565141;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0FN3bOxIhdy/N2r45nd/6ZtoVXh9fCyHLUsbHUleE0I=;
  b=eszDEMKu/fMO1VTy2du+5FHh3eOXmzXgsli+O4Ag63HAOWoQKxy0f/gD
   bPe/Ez8IgqGoIHZH8TgZ+SYMEcvrPn0Fv24+IxhMMiYcGoZ6RzncLxVLv
   uDV9a7CrGmvqSa89nprG6pRPa6+bdcaSEpzKYxv0Hf33Srp7QPN7jHrou
   4=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 31 May 2022 13:32:20 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2022 13:32:20 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 31 May 2022 13:32:20 -0700
Received: from [10.110.67.112] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 31 May
 2022 13:32:19 -0700
Message-ID: <cfb03aa3-1a98-8131-0090-93c8ae918e7f@quicinc.com>
Date:   Tue, 31 May 2022 13:32:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 2/2] ath11k: fix missing skb drop on htc_tx_completion
 error
Content-Language: en-US
To:     Christian 'Ansuel' Marangi <ansuelsmth@gmail.com>,
        <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>
References: <20220528142516.20819-1-ansuelsmth@gmail.com>
 <20220528142516.20819-2-ansuelsmth@gmail.com>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20220528142516.20819-2-ansuelsmth@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 5/28/2022 7:25 AM, Christian 'Ansuel' Marangi wrote:
> On htc_tx_completion error the skb is not dropped. This is wrong since
> the completion_handler logic expect the skb to be consumed anyway even
> when an error is triggerer. Not freeing the skb on error is a memory

nit: s/triggerer/triggered/

Kalle can fix this when he merges so no need to post a correction

> leak since the skb won't be freed anywere else. Correctly free the
> packet on eid >= ATH11K_HTC_EP_COUNT before returning.
> 
> Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.5.0.1-01208-QCAHKSWPL_SILICONZ-1
> 
> Fixes: f951380a6022 ("ath11k: Disabling credit flow for WMI path")
> Signed-off-by: Christian 'Ansuel' Marangi <ansuelsmth@gmail.com>

Reviewed-by: Jeff Johnson <quic_jjohnson@quicinc.com>

> ---
>   drivers/net/wireless/ath/ath11k/htc.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/ath/ath11k/htc.c b/drivers/net/wireless/ath/ath11k/htc.c
> index 069c29a4fac7..ca3aedc0252d 100644
> --- a/drivers/net/wireless/ath/ath11k/htc.c
> +++ b/drivers/net/wireless/ath/ath11k/htc.c
> @@ -258,8 +258,10 @@ void ath11k_htc_tx_completion_handler(struct ath11k_base *ab,
>   	u8 eid;
>   
>   	eid = ATH11K_SKB_CB(skb)->eid;
> -	if (eid >= ATH11K_HTC_EP_COUNT)
> +	if (eid >= ATH11K_HTC_EP_COUNT) {
> +		dev_kfree_skb_any(skb);
>   		return;
> +	}
>   
>   	ep = &htc->endpoint[eid];
>   	spin_lock_bh(&htc->tx_lock);

