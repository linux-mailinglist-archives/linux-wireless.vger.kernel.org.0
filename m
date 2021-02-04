Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 512C030EB19
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Feb 2021 04:42:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbhBDDlx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 3 Feb 2021 22:41:53 -0500
Received: from mail29.static.mailgun.info ([104.130.122.29]:31909 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229601AbhBDDlx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 3 Feb 2021 22:41:53 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1612410086; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=T6EudLrvQnPgGQjOQTFHIUEmOmA8Tkn1jsLZ+nZLPNQ=;
 b=QHVrdJwtHyV+q9+w87sC5TXdC+aT5tbCWS0PsznGjoYfxidLk6JUNnwPG5WHdTLOBjsaR8gk
 P+ousyicnk8BKbRT2FoDbsXmSkVW5XaMLTOMLoVUzhSriTBEJ/FNpjvEhdVkgu9T+lSraHwn
 /eGCG3RDcBK7+Pbt4e1uaChQugg=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 601b6cc80d9638bc4cb27cee (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 04 Feb 2021 03:40:56
 GMT
Sender: periyasa=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 9C6B3C433C6; Thu,  4 Feb 2021 03:40:56 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: periyasa)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 67129C433CA;
        Thu,  4 Feb 2021 03:40:55 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Thu, 04 Feb 2021 09:10:55 +0530
From:   Karthikeyan periyasamy <periyasa@codeaurora.org>
To:     Peter Oh <peter.oh@eero.com>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH] ath11k: Update tx descriptor search index properly
In-Reply-To: <ea3fb227-8324-dd73-f400-b6e591bc91df@eero.com>
References: <1608305041-21946-1-git-send-email-periyasa@codeaurora.org>
 <959ea12a-e35b-5867-c55e-7f62e2956b09@eero.com>
 <d6cbfd2aff787faa3be69252b2677df9@codeaurora.org>
 <08ef5e10-de7a-fe13-d23a-d1afa1dbd0e5@eero.com>
 <ea757176a6438f1b0cf9bee41f8a9f8c@codeaurora.org>
 <dc8f531f-2ab5-f690-2b94-917880682fcc@eero.com>
 <7e3bae2db30d90963f96bb9be82951f0@codeaurora.org>
 <ea3fb227-8324-dd73-f400-b6e591bc91df@eero.com>
Message-ID: <4eeb59233c041d26ca35fa8066691027@codeaurora.org>
X-Sender: periyasa@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2021-02-04 09:07, Peter Oh wrote:
> On 2/3/21 7:17 PM, Karthikeyan periyasamy wrote:
>> On 2021-02-04 08:38, Peter Oh wrote:
>>> On 2/3/21 5:08 PM, Karthikeyan periyasamy wrote:
>>>> On 2021-02-04 00:59, Peter Oh wrote:
>>>>> On 1/26/21 6:46 PM, Karthikeyan periyasamy wrote:
>>>>>> On 2020-12-19 00:53, Peter Oh wrote:
>>>>>>> On 12/18/20 7:24 AM, Karthikeyan Periyasamy wrote:
>>>>>>>> Tx descriptor search index field should be updated with hw peer 
>>>>>>>> id
>>>>>>>> and not by AST Hash. Incorrect search index causes throughput 
>>>>>>>> degradation
>>>>>>>> in all the platforms. so updated the search index field with hw 
>>>>>>>> peer id,
>>>>>>>> which is a common change applicable for all the platforms.
>>>>>>>> 
>>>>>>>> Tested-on: IPQ8074 hw2.0 AHB 
>>>>>>>> WLAN.HK.2.4.0.1-01492-QCAHKSWPL_SILICONZ-1
>>>>>>>> 
>>>>>>>> diff --git a/drivers/net/wireless/ath/ath11k/peer.c 
>>>>>>>> b/drivers/net/wireless/ath/ath11k/peer.c
>>>>>>>> index b69e7eb..f49abefa 100644
>>>>>>>> --- a/drivers/net/wireless/ath/ath11k/peer.c
>>>>>>>> +++ b/drivers/net/wireless/ath/ath11k/peer.c
>>>>>>>> 
>>>>>>>> @@ -309,7 +310,11 @@ int ath11k_peer_create(struct ath11k *ar, 
>>>>>>>> struct ath11k_vif *arvif,
>>>>>>>>         peer->pdev_idx = ar->pdev_idx;
>>>>>>>>       peer->sta = sta;
>>>>>>>> -    arvif->ast_hash = peer->ast_hash;
>>>>>>>> +
>>>>>>>> +    if (arvif->vif->type == NL80211_IFTYPE_STATION) {
>>>>>>>> +        arvif->ast_hash = peer->ast_hash;
>>>>>>>> +        arvif->ast_idx = peer->hw_peer_id;
>>>>>>>> +    }
>>>>>>> 
>>>>>>> How about non STATION type?
>>>>>>> 
>>>>>> 
>>>>>> no need of configuring the ast_idx, ast_hash field for non station 
>>>>>> type. Its recommended by HW/FW team.
>>>>>> 
>>>>> Can you add this comment in commit message?
>>>>> 
>>>> 
>>>> sure
>>>> 
>>>>> Also could you include the answer to "what conditions you observed 
>>>>> the
>>>>> throughput degradation?" in commit message too?
>>>> 
>>>> In all the scenario will see degradation. Its a general improvement.
>>>> 
>>> It sounds good and it will better if you share the number before and
>>> after the patch.
>> 
>> I have seen 10% increase in WDS scenario.
>> 
>> Thanks,
>> Karthikeyan P
> 
> Thank you for the sharing.
> 
> BTW, all such information should go to commit message.
> 
> Peter

I update in the commit message

Thanks,
Karthikeyan P
