Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68C6B5B3BAF
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Sep 2022 17:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbiIIPRa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 9 Sep 2022 11:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232323AbiIIPR2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 9 Sep 2022 11:17:28 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4F54146713
        for <linux-wireless@vger.kernel.org>; Fri,  9 Sep 2022 08:17:24 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id c11so1499040qtw.8
        for <linux-wireless@vger.kernel.org>; Fri, 09 Sep 2022 08:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:from:to:cc:subject:date;
        bh=JmLFvsLTlGyHg4bA5UZivfHDcJeE740gQ5MCgMjFIRg=;
        b=EW/1sq8iX8Md8bUyROaD2S4jBYT1olqMbKj8Jb0Fm+h8pd0uzywxtVOl3Radmi3fod
         saL4nVUh61tYkaDbwbrbv3sWiJMgioBYrNbXmQ0W/wMgjdH+rcbJyVqMP1p8i2BtfRye
         B4gEPfr1BxXbB285V8RJqrDthggDXl2LSOzyWezXTFz08TL/okh1amZdq/7OnNbPnMww
         6fJ2ZfGu9wNEItDuSb42WcD3E3IxqGNGreq+cON5Zkza29lsG+JlRtAgVbmnBklwlgme
         wVyOlGPM63Qsc23Q46LSKQFHy6dAkl8zQSAc0kCYoAhb2HM4ifTRduG1e+ohiUB4JT5W
         J0fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date;
        bh=JmLFvsLTlGyHg4bA5UZivfHDcJeE740gQ5MCgMjFIRg=;
        b=wcwVXnvWGVusFapVBumcR9MpFyEqEVN9cGXnxMw7tn0RXBYM3DJMqJ8lSw2VWPz1ZT
         uw62a9AIM2HhJuSU/lcaWS7hz/dr7cpRcHKRUVMVIj3IVcdudB0ZG+a7Xi/4bkviL0Ae
         7b1TQWfDfs43jGE+L+h+jWcqwM/XX+lNPkrqfqvNK6mMnvznWklGEJVaV0brzoqgZhWN
         ZtMvDOjWno++sl/J6+5XgvW96/ToIDkJX1/IdKCB0N0m6lqofi8T1H7bwDd8wxxNpQbz
         7b8xI+bDs6AgZMc0xMmUFeY7CbjOUrZDoV3ZECxEGu1sN31Dsxv/PebVq2LipGh8BEfF
         8y2Q==
X-Gm-Message-State: ACgBeo0p3In+T5wcfvf7UH4Sc5fyC42TG7Q4NxE+lL1G3tOOae8FNYB+
        PxEayo9JQLUSTS4KkA3cmSw05f3c+bQ=
X-Google-Smtp-Source: AA6agR4/tq4z1pjwgw9+r2dqmOBt3QYtm0V7GEiS8Y7nuZvK+NXE/bie7lxUfVSON/4jbiDuUsPG5A==
X-Received: by 2002:a05:622a:5cc:b0:344:6d33:d17a with SMTP id d12-20020a05622a05cc00b003446d33d17amr12925774qtb.186.1662736643975;
        Fri, 09 Sep 2022 08:17:23 -0700 (PDT)
Received: from ?IPV6:2620:10d:c0a8:1102::1244? ([2620:10d:c091:480::41b])
        by smtp.gmail.com with ESMTPSA id j20-20020a05620a289400b006bbf85cad0fsm701556qkp.20.2022.09.09.08.17.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Sep 2022 08:17:23 -0700 (PDT)
From:   Jes Sorensen <jes.sorensen@gmail.com>
X-Google-Original-From: Jes Sorensen <Jes.Sorensen@gmail.com>
Message-ID: <bc1cb02f-be54-9429-ef1b-ccda41ea8f27@gmail.com>
Date:   Fri, 9 Sep 2022 11:17:22 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v2] wifi: rtl8xxxu: Fix skb misuse in TX queue selection
Content-Language: en-US
To:     Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        linux-wireless@vger.kernel.org
References: <7fa4819a-4f20-b2af-b7a6-8ee01ac49295@gmail.com>
 <acd30174-4541-7343-e49a-badd199f4151@gmail.com>
 <52f498b9-9fc1-aabb-fad8-ef6ce95b594b@gmail.com>
In-Reply-To: <52f498b9-9fc1-aabb-fad8-ef6ce95b594b@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 9/9/22 11:03, Bitterblue Smith wrote:
> On 07/09/2022 18:02, Jes Sorensen wrote:
>> On 8/31/22 12:12, Bitterblue Smith wrote:
> [...]
>>> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
>>> index 52240e945b58..8d6f693bf60b 100644
>>> --- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
>>> +++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
>>> @@ -5177,6 +5177,8 @@ static void rtl8xxxu_tx(struct ieee80211_hw *hw,
>>>  	if (control && control->sta)
>>>  		sta = control->sta;
>>>  
>>> +	queue = rtl8xxxu_queue_select(hw, skb);
>>> +
>>>  	tx_desc = skb_push(skb, tx_desc_size);
>>>  
>>>  	memset(tx_desc, 0, tx_desc_size);
>>> @@ -5189,7 +5191,6 @@ static void rtl8xxxu_tx(struct ieee80211_hw *hw,
>>>  	    is_broadcast_ether_addr(ieee80211_get_DA(hdr)))
>>>  		tx_desc->txdw0 |= TXDESC_BROADMULTICAST;
>>>  
>>> -	queue = rtl8xxxu_queue_select(hw, skb);
>>>  	tx_desc->txdw1 = cpu_to_le32(queue << TXDESC_QUEUE_SHIFT);
>>
>> This could actually be made more resilient from someone moving the code
>> around by passing in 'hdr' instead of relying on using skb->data in
>> rtl8xxxu_queue_select(). We could also get rid of the hw argument to
>> that function since it isn't used.
>>
>> Cheers,
>> Jes
>>
> 
> Good ideas! I'll do that when I'm done fiddling with the RTL8188FU.

Sounds good!

Thanks,
Jes

