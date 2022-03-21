Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B53544E258A
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Mar 2022 12:52:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346902AbiCULxO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Mar 2022 07:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346900AbiCULwo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Mar 2022 07:52:44 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B0C554AA
        for <linux-wireless@vger.kernel.org>; Mon, 21 Mar 2022 04:51:19 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id dr20so28925947ejc.6
        for <linux-wireless@vger.kernel.org>; Mon, 21 Mar 2022 04:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=31mi1xSjYY2wTa+khnQ3+dG3iEIyKWgXiXOvGCIrKBE=;
        b=jfFZ8VsFI1HdLREUwkEXd8rFqvLRXM+yai7M/Md38tN+Zgmen+m0EfUYdbVZ/eIXaw
         0u4nXDxU/wuVDeS3CMnlD2UvpWKsVkrry9fkMIbjeOenM+hWcoAjOMR1QJ2NUAEI6GAg
         wv8z8JNiN+MEtPMhqj8f0sXCyHFv2a3ILzzwrLiG1H2LbU816FLj2yreFtSYYjc/uJq5
         ZJxsH/WF9mYVu/levNzwoXmfH0cx7lqPEnx6B7al/tF8fh3K6vaubw4PpmZR9fqIJdRP
         I13VOepbJoH5HNNYmxfwlwvWGLw6dlJ/s2k8kW1B13nRPnMFkqwykh6PdTJ6yrxYj5ng
         wl3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=31mi1xSjYY2wTa+khnQ3+dG3iEIyKWgXiXOvGCIrKBE=;
        b=6ioapn2mRlV6xReXm7PYX5aQPC1k2IGdHCr+mk51/2GMagLFP7w4bCvySz1gyDtGFM
         WTCB0uKMFP8hmYGuaQkauUhEwfikloDDA7KO9kivPRP4zdiL4QGq067/j8ztxve83Z0V
         y6HaYhZqGxOWXxuEVJpG6+9f97UjHsUMA3yDEl0jPtfjS6C6vQ3bEEh9v4w3gRNxdGHz
         9COEyxUc3EXUQ4QQ/nWT+nBM8gU1dcBqIe/dLUI652LG8SG7CEKUJRATxUBtw2EluRBE
         AGp8pa9XLsAqM4eSmTss0jx0AQUW32jkxnPjmuso9iaS5ReWnmbOfASxTuy4kJ8/aGzm
         ApXQ==
X-Gm-Message-State: AOAM533r+cnwjd1Cnolt3jxMbgKgjlVgLKZj8w39vEm0UvWOOnSXhRim
        HqzyrzWmTsQcLbX4klPKHMHh7Tv715F2Ew==
X-Google-Smtp-Source: ABdhPJzhR3m6WoS4q0lvp2YisKZtGfj14YEvdA15dKdTpcMajLdKU8aw+FTomp6V/1deqGCz8I2D3g==
X-Received: by 2002:a17:907:ea1:b0:6df:7900:e4de with SMTP id ho33-20020a1709070ea100b006df7900e4demr19925395ejc.26.1647863477497;
        Mon, 21 Mar 2022 04:51:17 -0700 (PDT)
Received: from ?IPV6:2a02:1811:cc83:eef0:7bf1:a0f8:a9aa:ac98? (ptr-dtfv0pmq82wc9dcpm6w.18120a2.ip6.access.telenet.be. [2a02:1811:cc83:eef0:7bf1:a0f8:a9aa:ac98])
        by smtp.gmail.com with ESMTPSA id x12-20020a50d9cc000000b0040f70fe78f3sm7969608edj.36.2022.03.21.04.51.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Mar 2022 04:51:17 -0700 (PDT)
Message-ID: <306b8f3c-55ff-24a3-1f7f-31c0b9e247fc@gmail.com>
Date:   Mon, 21 Mar 2022 12:51:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH] ath11k: acquire ab->base_lock in unassign when finding
 the peer by addr
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Carl Huang <cjhuang@codeaurora.org>
References: <20220314215253.92658-1-dossche.niels@gmail.com>
 <87zgljmvne.fsf@kernel.org>
From:   Niels Dossche <dossche.niels@gmail.com>
In-Reply-To: <87zgljmvne.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 21/03/2022 11:45, Kalle Valo wrote:
> Niels Dossche <dossche.niels@gmail.com> writes:
> 
>> ath11k_peer_find_by_addr states via lockdep that ab->base_lock must be
>> held when calling that function in order to protect the list. All
>> callers except ath11k_mac_op_unassign_vif_chanctx have that lock
>> acquired when calling ath11k_peer_find_by_addr. That lock is also not
>> transitively held by a path towards ath11k_mac_op_unassign_vif_chanctx.
>> The solution is to acquire the lock when calling
>> ath11k_peer_find_by_addr inside ath11k_mac_op_unassign_vif_chanctx.
>>
>> Fixes: 701e48a43e15 ("ath11k: add packet log support for QCA6390")
>> Signed-off-by: Niels Dossche <dossche.niels@gmail.com>
>> ---
>>  drivers/net/wireless/ath/ath11k/mac.c | 12 +++++++++---
>>  1 file changed, 9 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
>> index 07f499d5ec92..5db2333478a2 100644
>> --- a/drivers/net/wireless/ath/ath11k/mac.c
>> +++ b/drivers/net/wireless/ath/ath11k/mac.c
>> @@ -7077,9 +7077,15 @@ ath11k_mac_op_unassign_vif_chanctx(struct ieee80211_hw *hw,
>>  	WARN_ON(!arvif->is_started);
>>  
>>  	if (ab->hw_params.vdev_start_delay &&
>> -	    arvif->vdev_type == WMI_VDEV_TYPE_MONITOR &&
>> -	    ath11k_peer_find_by_addr(ab, ar->mac_addr))
>> -		ath11k_peer_delete(ar, arvif->vdev_id, ar->mac_addr);
>> +	    arvif->vdev_type == WMI_VDEV_TYPE_MONITOR) {
>> +		struct ath11k_peer *peer;
> 
> In the pending branch I moved the declaration to the beginning of the
> function and added this to the commit log:
> 
> "I am currently working on a static analyser to detect missing locks and
> this was a reported case. I manually verified the report by looking at
> the code, but I do not have real hardware so this is compile tested
> only."
> 

Sounds good to me. Thanks!
