Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56DAB30EAB1
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Feb 2021 04:10:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231475AbhBDDJh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 3 Feb 2021 22:09:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233533AbhBDDJc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 3 Feb 2021 22:09:32 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A5D7C061573
        for <linux-wireless@vger.kernel.org>; Wed,  3 Feb 2021 19:08:52 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id u15so1000455plf.1
        for <linux-wireless@vger.kernel.org>; Wed, 03 Feb 2021 19:08:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eero.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=X5SP/RYZJKYSVivEWNfD0sIb8eTHHQjIvVqVxhsjpNg=;
        b=lxDReiF9ZKqvpQzv+XoaPGetd5FSdV1f4kSyHLXdfcb+/mN08Uf3L+QmPrKihGKe5H
         CoZtii394Zbd7oIE1EmEh6b97FIppxZJX8B25be6AZGHP0HfRjL5O3X3m3ND69iwC21o
         nt65bLUp3ciIjOQs2033B+hgGxBO57jDNVqJU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=X5SP/RYZJKYSVivEWNfD0sIb8eTHHQjIvVqVxhsjpNg=;
        b=FAH9Ui7odj8Oj0IrD/RgcDvynGZXBiEK/6gMtvsE2WPEU2qYN8zhC2hh++sWq4UFVG
         ZsktOj7fLee89cKZ2h4A7N1/OFj2rvit3JQudzzWYyStbACoN1wNkv2iznW06ZDFypxV
         zGoqvqva8WCjoeyaCSDj0YcmH0Pq04bQLpxySR9F6UUxDhCSwkfJpIsmo0QClJAqPcBh
         Q2pu/bZCMdXJEn6W/f2BJRWYo0CfQ2wZzREx9eBgS6/RGeTpgiSCCoV4NjDcdMImw5ql
         zIZ+gkhlFt9nZENVJiQRck0ViUWilAP1NjIotD7p6c0OX3wl9oOkIiUhYIPmeFX6cpcB
         AMUw==
X-Gm-Message-State: AOAM533vlxOgjJ9UmDDpzd8v7gJxc01zrtZY2eWmEb8qx72lPISSG2TA
        oo+qYMta8TqyRDR1s14+UPqrmjRthblaSOPn
X-Google-Smtp-Source: ABdhPJxOwJump7KatZyew1+XbzPkief5EiCZBvjXqLCkOGNgj5cm/+obj745U8VvLzeme3/ueAMtnw==
X-Received: by 2002:a17:90a:b703:: with SMTP id l3mr5966492pjr.60.1612408131594;
        Wed, 03 Feb 2021 19:08:51 -0800 (PST)
Received: from [192.168.4.200] (107-196-182-50.lightspeed.sntcca.sbcglobal.net. [107.196.182.50])
        by smtp.gmail.com with ESMTPSA id v126sm1822305pfv.163.2021.02.03.19.08.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Feb 2021 19:08:51 -0800 (PST)
Subject: Re: [PATCH] ath11k: Update tx descriptor search index properly
To:     Karthikeyan periyasamy <periyasa@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
References: <1608305041-21946-1-git-send-email-periyasa@codeaurora.org>
 <959ea12a-e35b-5867-c55e-7f62e2956b09@eero.com>
 <d6cbfd2aff787faa3be69252b2677df9@codeaurora.org>
 <08ef5e10-de7a-fe13-d23a-d1afa1dbd0e5@eero.com>
 <ea757176a6438f1b0cf9bee41f8a9f8c@codeaurora.org>
From:   Peter Oh <peter.oh@eero.com>
Message-ID: <dc8f531f-2ab5-f690-2b94-917880682fcc@eero.com>
Date:   Wed, 3 Feb 2021 19:08:49 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <ea757176a6438f1b0cf9bee41f8a9f8c@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 2/3/21 5:08 PM, Karthikeyan periyasamy wrote:
> On 2021-02-04 00:59, Peter Oh wrote:
>> On 1/26/21 6:46 PM, Karthikeyan periyasamy wrote:
>>> On 2020-12-19 00:53, Peter Oh wrote:
>>>> On 12/18/20 7:24 AM, Karthikeyan Periyasamy wrote:
>>>>> Tx descriptor search index field should be updated with hw peer id
>>>>> and not by AST Hash. Incorrect search index causes throughput 
>>>>> degradation
>>>>> in all the platforms. so updated the search index field with hw 
>>>>> peer id,
>>>>> which is a common change applicable for all the platforms.
>>>>>
>>>>> Tested-on: IPQ8074 hw2.0 AHB 
>>>>> WLAN.HK.2.4.0.1-01492-QCAHKSWPL_SILICONZ-1
>>>>>
>>>>> diff --git a/drivers/net/wireless/ath/ath11k/peer.c 
>>>>> b/drivers/net/wireless/ath/ath11k/peer.c
>>>>> index b69e7eb..f49abefa 100644
>>>>> --- a/drivers/net/wireless/ath/ath11k/peer.c
>>>>> +++ b/drivers/net/wireless/ath/ath11k/peer.c
>>>>>
>>>>> @@ -309,7 +310,11 @@ int ath11k_peer_create(struct ath11k *ar, 
>>>>> struct ath11k_vif *arvif,
>>>>>         peer->pdev_idx = ar->pdev_idx;
>>>>>       peer->sta = sta;
>>>>> -    arvif->ast_hash = peer->ast_hash;
>>>>> +
>>>>> +    if (arvif->vif->type == NL80211_IFTYPE_STATION) {
>>>>> +        arvif->ast_hash = peer->ast_hash;
>>>>> +        arvif->ast_idx = peer->hw_peer_id;
>>>>> +    }
>>>>
>>>> How about non STATION type?
>>>>
>>>
>>> no need of configuring the ast_idx, ast_hash field for non station 
>>> type. Its recommended by HW/FW team.
>>>
>> Can you add this comment in commit message?
>>
>
> sure
>
>> Also could you include the answer to "what conditions you observed the
>> throughput degradation?" in commit message too?
>
> In all the scenario will see degradation. Its a general improvement.
>
It sounds good and it will better if you share the number before and 
after the patch.


Thanks,

Peter

