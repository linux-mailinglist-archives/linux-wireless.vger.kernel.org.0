Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2105C3B7CE7
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Jun 2021 07:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231414AbhF3FUY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 30 Jun 2021 01:20:24 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:35058 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230097AbhF3FUX (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 30 Jun 2021 01:20:23 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1625030275; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=r6StrvAgtSjDvxY5bx8SeVF3UJV/4tFr9nqHkH2GysI=;
 b=ml7LbDBxwlIDKdBG1nVfptnxKcHOCDMd/jPhnHnzIbZsUlJcTeuJbwaN3Jr4t7rH6GTTmSUg
 DWJWmKF8RXUYZxyq4t6zJCxSvY5q3oVrdCTYnDRfbWe99ss4GsQhr+kiu+5v/fyhK7YYDGZW
 ECOmc2ilPQ3dxB4TlT6VpdR8q5s=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 60dbfe805e3e57240b3cc7e2 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 30 Jun 2021 05:17:52
 GMT
Sender: ppranees=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 16608C433D3; Wed, 30 Jun 2021 05:17:52 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: ppranees)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 41CF5C433F1;
        Wed, 30 Jun 2021 05:17:51 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 30 Jun 2021 10:47:51 +0530
From:   P Praneesh <ppranees@codeaurora.org>
To:     Felix Fietkau <nbd@nbd.name>
Cc:     Jouni Malinen <jouni@codeaurora.org>,
        Kalle Valo <kvalo@codeaurora.org>, ath11k@lists.infradead.org,
        linux-wireless@vger.kernel.org,
        Karthikeyan Periyasamy <periyasa@codeaurora.org>
Subject: Re: [PATCH 12/12] ath11k: avoid unnecessary lock contention in
 tx_completion path
In-Reply-To: <b1dbd11a-e978-16ea-1473-7eb81399981c@nbd.name>
References: <20210615211407.92233-1-jouni@codeaurora.org>
 <20210615211407.92233-13-jouni@codeaurora.org>
 <b1dbd11a-e978-16ea-1473-7eb81399981c@nbd.name>
Message-ID: <01aa763e6a2cd58139a6b3685b8151a7@codeaurora.org>
X-Sender: ppranees@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2021-06-29 23:05, Felix Fietkau wrote:
> On 2021-06-15 23:14, Jouni Malinen wrote:
>> From: P Praneesh <ppranees@codeaurora.org>
>> 
>> Lock is not needed for the readable idr operation, so avoid 
>> spin_lock_bh
>> for the idr_find() call. No need to disable the bottom half preempt if
>> it is already in bottom half context, so modify the spin_lock_bh to
>> spin_lock in the data tx completion handler.
>> 
>> Tested-on: IPQ8074 hw2.0 AHB 
>> WLAN.HK.2.4.0.1-01734-QCAHKSWPL_SILICONZ-1 v2
>> 
>> Co-developed-by: Karthikeyan Periyasamy <periyasa@codeaurora.org>
>> Signed-off-by: Karthikeyan Periyasamy <periyasa@codeaurora.org>
>> Signed-off-by: P Praneesh <ppranees@codeaurora.org>
>> Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
>> ---
>>  drivers/net/wireless/ath/ath11k/dp_tx.c | 18 ++++++++----------
>>  1 file changed, 8 insertions(+), 10 deletions(-)
>> 
>> diff --git a/drivers/net/wireless/ath/ath11k/dp_tx.c 
>> b/drivers/net/wireless/ath/ath11k/dp_tx.c
>> index ab9ccf0eb274..659f9d98bc0c 100644
>> --- a/drivers/net/wireless/ath/ath11k/dp_tx.c
>> +++ b/drivers/net/wireless/ath/ath11k/dp_tx.c
>> @@ -288,19 +288,18 @@ static void ath11k_dp_tx_free_txbuf(struct 
>> ath11k_base *ab, u8 mac_id,
>>  	struct sk_buff *msdu;
>>  	struct ath11k_skb_cb *skb_cb;
>> 
>> -	spin_lock_bh(&tx_ring->tx_idr_lock);
>>  	msdu = idr_find(&tx_ring->txbuf_idr, msdu_id);
>> -	if (!msdu) {
>> +	if (unlikely(!msdu)) {
>>  		ath11k_warn(ab, "tx completion for unknown msdu_id %d\n",
>>  			    msdu_id);
>> -		spin_unlock_bh(&tx_ring->tx_idr_lock);
>>  		return;
>>  	}
>> 
>>  	skb_cb = ATH11K_SKB_CB(msdu);
>> 
>> +	spin_lock(&tx_ring->tx_idr_lock);
>>  	idr_remove(&tx_ring->txbuf_idr, msdu_id);
> Why are you doing the lookups twice instead of just using the return
> value of idr_remove?
> 
> - Felix
Yes, we will address this in the next version of the patch.
