Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C665530EB14
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Feb 2021 04:39:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234299AbhBDDia (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 3 Feb 2021 22:38:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234165AbhBDDiS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 3 Feb 2021 22:38:18 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25236C0613D6
        for <linux-wireless@vger.kernel.org>; Wed,  3 Feb 2021 19:37:38 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id y205so1234876pfc.5
        for <linux-wireless@vger.kernel.org>; Wed, 03 Feb 2021 19:37:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eero.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=dQcZ9kr2eRxPZi8AE7aZJtfRw3wUMvLj2JFrqWoE+hU=;
        b=HBHpo3TueSQGotd+hW3e8PzgY3oLpvezf/8R8rNNlqmDdbwBcbp2GigrxjSTKl+bEt
         GfRB5gCRCzPo9tY+6yEyGWTjBT+sIXFsVztcWkoFMx85bhOZpmSMczIQOad8H1h4Ga/E
         UAl4NKg0Q1gVdIdQXV/icNaemtZzxJriEb61w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=dQcZ9kr2eRxPZi8AE7aZJtfRw3wUMvLj2JFrqWoE+hU=;
        b=mmyNkY5XDFXHYXlEduV1Jz/HC4k4yL574Af6jT+Td9DzEZLv0kW8bq9Jmqg4EiuEGw
         5ETSk4Rk/3FAWgvO5cE1Vfj9MPm/BJI2mmjjiDJVD1moVlHdUrSMKVjkLK6/FEA6ATJq
         JkiCtiLPJ2PHgVXjGM8jGJdHaRY0OT3/3NS3kCPR0qhWjdrLHz3pV+lJDe9U7khDX1RJ
         NoiaOYKzmi+6vmWP+h8YB1uEWRLDxShQPtMY1QxwZM6DbkpgLqIr2MKrhIStXJwoOq5w
         OmOSkUi9ryv0ovHBNSrnJg0mlwOA5HP5JLONZlg1RTAouyPJBcC2KgA0irdu1aWWeh2s
         NTew==
X-Gm-Message-State: AOAM532G4eHW5BXhhtsq7qCVt7/VhsoELGlK1G/J+cosb+gxqynK0ZNN
        aPhlK3gq3Ff1lKvAvNAU+QJf6L4fp7QKQspH
X-Google-Smtp-Source: ABdhPJxpsEcbDYJCtgsf4DAwa8asGxvxa9jyoyAFiL0bxLNNuEGRuwKGG4gMv+ZaWG+jSU0Ku5MyaQ==
X-Received: by 2002:aa7:8b0f:0:b029:1c0:e782:ba29 with SMTP id f15-20020aa78b0f0000b02901c0e782ba29mr6064608pfd.37.1612409857509;
        Wed, 03 Feb 2021 19:37:37 -0800 (PST)
Received: from [192.168.4.200] (107-196-182-50.lightspeed.sntcca.sbcglobal.net. [107.196.182.50])
        by smtp.gmail.com with ESMTPSA id 124sm3872977pfc.196.2021.02.03.19.37.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Feb 2021 19:37:37 -0800 (PST)
Subject: Re: [PATCH] ath11k: Update tx descriptor search index properly
To:     Karthikeyan periyasamy <periyasa@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
References: <1608305041-21946-1-git-send-email-periyasa@codeaurora.org>
 <959ea12a-e35b-5867-c55e-7f62e2956b09@eero.com>
 <d6cbfd2aff787faa3be69252b2677df9@codeaurora.org>
 <08ef5e10-de7a-fe13-d23a-d1afa1dbd0e5@eero.com>
 <ea757176a6438f1b0cf9bee41f8a9f8c@codeaurora.org>
 <dc8f531f-2ab5-f690-2b94-917880682fcc@eero.com>
 <7e3bae2db30d90963f96bb9be82951f0@codeaurora.org>
From:   Peter Oh <peter.oh@eero.com>
Message-ID: <ea3fb227-8324-dd73-f400-b6e591bc91df@eero.com>
Date:   Wed, 3 Feb 2021 19:37:35 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <7e3bae2db30d90963f96bb9be82951f0@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


On 2/3/21 7:17 PM, Karthikeyan periyasamy wrote:
> On 2021-02-04 08:38, Peter Oh wrote:
>> On 2/3/21 5:08 PM, Karthikeyan periyasamy wrote:
>>> On 2021-02-04 00:59, Peter Oh wrote:
>>>> On 1/26/21 6:46 PM, Karthikeyan periyasamy wrote:
>>>>> On 2020-12-19 00:53, Peter Oh wrote:
>>>>>> On 12/18/20 7:24 AM, Karthikeyan Periyasamy wrote:
>>>>>>> Tx descriptor search index field should be updated with hw peer id
>>>>>>> and not by AST Hash. Incorrect search index causes throughput 
>>>>>>> degradation
>>>>>>> in all the platforms. so updated the search index field with hw 
>>>>>>> peer id,
>>>>>>> which is a common change applicable for all the platforms.
>>>>>>>
>>>>>>> Tested-on: IPQ8074 hw2.0 AHB 
>>>>>>> WLAN.HK.2.4.0.1-01492-QCAHKSWPL_SILICONZ-1
>>>>>>>
>>>>>>> diff --git a/drivers/net/wireless/ath/ath11k/peer.c 
>>>>>>> b/drivers/net/wireless/ath/ath11k/peer.c
>>>>>>> index b69e7eb..f49abefa 100644
>>>>>>> --- a/drivers/net/wireless/ath/ath11k/peer.c
>>>>>>> +++ b/drivers/net/wireless/ath/ath11k/peer.c
>>>>>>>
>>>>>>> @@ -309,7 +310,11 @@ int ath11k_peer_create(struct ath11k *ar, 
>>>>>>> struct ath11k_vif *arvif,
>>>>>>>         peer->pdev_idx = ar->pdev_idx;
>>>>>>>       peer->sta = sta;
>>>>>>> -    arvif->ast_hash = peer->ast_hash;
>>>>>>> +
>>>>>>> +    if (arvif->vif->type == NL80211_IFTYPE_STATION) {
>>>>>>> +        arvif->ast_hash = peer->ast_hash;
>>>>>>> +        arvif->ast_idx = peer->hw_peer_id;
>>>>>>> +    }
>>>>>>
>>>>>> How about non STATION type?
>>>>>>
>>>>>
>>>>> no need of configuring the ast_idx, ast_hash field for non station 
>>>>> type. Its recommended by HW/FW team.
>>>>>
>>>> Can you add this comment in commit message?
>>>>
>>>
>>> sure
>>>
>>>> Also could you include the answer to "what conditions you observed the
>>>> throughput degradation?" in commit message too?
>>>
>>> In all the scenario will see degradation. Its a general improvement.
>>>
>> It sounds good and it will better if you share the number before and
>> after the patch.
>
> I have seen 10% increase in WDS scenario.
>
> Thanks,
> Karthikeyan P

Thank you for the sharing.

BTW, all such information should go to commit message.

Peter

