Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5926630E349
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Feb 2021 20:31:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231124AbhBCTac (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 3 Feb 2021 14:30:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbhBCTa2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 3 Feb 2021 14:30:28 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C69AFC0613D6
        for <linux-wireless@vger.kernel.org>; Wed,  3 Feb 2021 11:29:47 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id i7so428004pgc.8
        for <linux-wireless@vger.kernel.org>; Wed, 03 Feb 2021 11:29:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eero.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=iiosoeqvZZM3bn/8qyuaFKyxIlwkumJhKeaE0qsY8nc=;
        b=Onmq0gObz39UFdM048agTK0US8MnjQTd3TP1ihWh6JZbCm/JyAApe1pgu/R4eavYhU
         Ag4QUH11CinXtbxR8Rnnc1RpG/NMvG1m+M57/Km0VbDpF5UCUiN/BKR99fYTO45GkK1G
         iAWA5yxxM6hb//MmTA9vEiq+5CfrM9b8fxlKA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=iiosoeqvZZM3bn/8qyuaFKyxIlwkumJhKeaE0qsY8nc=;
        b=n/VHYqe5JhGML4UkhEMc9Zd1j4o37X9s9XnjGIfXkRwmrXwuuwPC+YLB3oUatUdnQm
         WdFl832DtKaGfGvF2dQozcEHWRMo53qS9NJM+gzq4Q0glVAdof/93NqOtigyjDNsgmZm
         okTM0/X7/ktthT0pGEcGkV28jhvnxTBjWONThLi4u6UrMm95nqItSMO7W5mNd/ayw26m
         aUi0A2ixG66LhG07nbZbc44RaJuA40kd7XnBKVo+u74kjKGNNH4lKttfwT9HxYuAPo8w
         pA8vAM28QllZc9AqJJCN10PuOmmjXPEQKfgaZu0qebxvG//MmyXNO97NzRgtr1v5fsWq
         iVog==
X-Gm-Message-State: AOAM531hMPE8YjtQ37jWYmuozMVSODKhLN8RzuKbAbgghTJSjuvBSNVC
        vufVGP5eCcmmEHe9JD//KXwY5S4Rj+3aOL53
X-Google-Smtp-Source: ABdhPJyn9O3w3fkrzFlCGEkRxscPsCJoIGaxAw1uvbMtuPTlTvEpbRHHMWHBDWq7eR3kTE0ql0RgKQ==
X-Received: by 2002:aa7:9596:0:b029:1be:28cc:cfe8 with SMTP id z22-20020aa795960000b02901be28cccfe8mr4278881pfj.49.1612380587114;
        Wed, 03 Feb 2021 11:29:47 -0800 (PST)
Received: from [192.168.4.200] (107-196-182-50.lightspeed.sntcca.sbcglobal.net. [107.196.182.50])
        by smtp.gmail.com with ESMTPSA id 101sm2777067pjo.38.2021.02.03.11.29.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Feb 2021 11:29:46 -0800 (PST)
Subject: Re: [PATCH] ath11k: Update tx descriptor search index properly
To:     Karthikeyan periyasamy <periyasa@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
References: <1608305041-21946-1-git-send-email-periyasa@codeaurora.org>
 <959ea12a-e35b-5867-c55e-7f62e2956b09@eero.com>
 <d6cbfd2aff787faa3be69252b2677df9@codeaurora.org>
From:   Peter Oh <peter.oh@eero.com>
Message-ID: <08ef5e10-de7a-fe13-d23a-d1afa1dbd0e5@eero.com>
Date:   Wed, 3 Feb 2021 11:29:45 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <d6cbfd2aff787faa3be69252b2677df9@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 1/26/21 6:46 PM, Karthikeyan periyasamy wrote:
> On 2020-12-19 00:53, Peter Oh wrote:
>> On 12/18/20 7:24 AM, Karthikeyan Periyasamy wrote:
>>> Tx descriptor search index field should be updated with hw peer id
>>> and not by AST Hash. Incorrect search index causes throughput 
>>> degradation
>>> in all the platforms. so updated the search index field with hw peer 
>>> id,
>>> which is a common change applicable for all the platforms.
>>>
>>> Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.4.0.1-01492-QCAHKSWPL_SILICONZ-1
>>>
>>> diff --git a/drivers/net/wireless/ath/ath11k/peer.c 
>>> b/drivers/net/wireless/ath/ath11k/peer.c
>>> index b69e7eb..f49abefa 100644
>>> --- a/drivers/net/wireless/ath/ath11k/peer.c
>>> +++ b/drivers/net/wireless/ath/ath11k/peer.c
>>>
>>> @@ -309,7 +310,11 @@ int ath11k_peer_create(struct ath11k *ar, 
>>> struct ath11k_vif *arvif,
>>>         peer->pdev_idx = ar->pdev_idx;
>>>       peer->sta = sta;
>>> -    arvif->ast_hash = peer->ast_hash;
>>> +
>>> +    if (arvif->vif->type == NL80211_IFTYPE_STATION) {
>>> +        arvif->ast_hash = peer->ast_hash;
>>> +        arvif->ast_idx = peer->hw_peer_id;
>>> +    }
>>
>> How about non STATION type?
>>
>
> no need of configuring the ast_idx, ast_hash field for non station 
> type. Its recommended by HW/FW team.
>
Can you add this comment in commit message?

Also could you include the answer to "what conditions you observed the
throughput degradation?" in commit message too?


Thanks,

Peter

