Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7A517BEB8E
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Oct 2023 22:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378055AbjJIUWb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Oct 2023 16:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234540AbjJIUWa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Oct 2023 16:22:30 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 170A6A3
        for <linux-wireless@vger.kernel.org>; Mon,  9 Oct 2023 13:22:28 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-1dd54aca17cso3666542fac.3
        for <linux-wireless@vger.kernel.org>; Mon, 09 Oct 2023 13:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696882947; x=1697487747; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lPugHq+FTVI6wjFwU6/difcH2OtrbT6TMNdfc1s3ROI=;
        b=mbyyvPZNYS/WI8hYmDZeaPMxadYieXdAUF7NHjbzzzY5fOOGalWlt4BeiylpCSZDdN
         lRPsKmt5jbCWKfMa2Fxz56FgJVFy8jJuoNxJu/GcGtceYnxyyYV+NkAzIwZSqD4ts1ay
         2DV+4NMyb9PqKRJrfqjygZIWaAWUUgrzEPgCBZoAq8dmU+vRlbSImeCDSa32pXg9aqjr
         ne655+Dxrg/I7b0Py1JeEKhBW7bpI1/VjH8WsNwrEUl7XQs+RUALg6GitYZ+t5RWIL3s
         HNxwMFf96lNLI7fupV5UkErjElUxVBclSrQIVwERl3dPtgmkN5jU61R3ybNsz7cq/nUj
         pfvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696882947; x=1697487747;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lPugHq+FTVI6wjFwU6/difcH2OtrbT6TMNdfc1s3ROI=;
        b=N3GG+bt/8cmLeNFN0Mj9gGcfH1w4rVGRXOPyWkn6cD6MllIvTBz1CiwvDIv5uUCg5D
         fBIuTYAhF6yKXF4MRiDIVoyi9w/JObY1eVo8JUGzdO6utDQM+5ddXU5EnU7jKjhOOEPf
         +O4j8IAqxL4zCU9K3kKQnKCOlraZ5/ukOah7aZxgeoFemFwmPCeLF0b2AefRxhIDY1xg
         RaK4OVK0MSM144Ko6JiM2l1NWMUgaro3oX4Qo1WoHAEoSJWwpokU3ZemPxIpUHcqk3uh
         rWblXGoWAPBH4okugpQxsVgRXHGiCW8rtYgXPvZERMRKN90707sC2MfDZbjYbA2VwzcZ
         sp/Q==
X-Gm-Message-State: AOJu0Yy3TJLX0idg5KS2aVn3Y9qDSQ/E9jKSaLz9K9Gbx94Ai+Ii0kKL
        THKcfmiuaEfqF7A2iodhmcE=
X-Google-Smtp-Source: AGHT+IGAt+EExQlwSnJxDpIfnnKGNd+xYroi4LoWTYooHfAtyWnd53d/fFzBLwYhkhPYb2ZP0IjQyQ==
X-Received: by 2002:a05:6870:f708:b0:1dc:c65e:ded2 with SMTP id ej8-20020a056870f70800b001dcc65eded2mr17503474oab.12.1696882946933;
        Mon, 09 Oct 2023 13:22:26 -0700 (PDT)
Received: from [192.168.178.137] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id s13-20020a0ce30d000000b0063d038df3f3sm4122315qvl.52.2023.10.09.13.22.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Oct 2023 13:22:26 -0700 (PDT)
Message-ID: <cd9e71c8-2884-427a-a394-756f62ab09ba@gmail.com>
Date:   Mon, 9 Oct 2023 22:22:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: On brcm80211 maintenance and support
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>,
        Julian Calaby <julian.calaby@gmail.com>
Cc:     Dmitry Antipov <dmantipov@yandex.ru>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Hector Martin <marcan@marcan.st>,
        SHA-cyfmac-dev-list@infineon.com,
        brcm80211-dev-list.pdl@broadcom.com
References: <6f78e624-62ee-3ae5-1db4-a0411566def8@yandex.ru>
 <CAGRGNgU7aySyUny9aG_+wXiKJ7j1weosa-rZDY4_WAXbq-3ABg@mail.gmail.com>
 <87ttr454bh.fsf@kernel.org>
From:   Arend Van Spriel <aspriel@gmail.com>
In-Reply-To: <87ttr454bh.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 10/6/2023 2:21 PM, Kalle Valo wrote:
> Julian Calaby <julian.calaby@gmail.com> writes:
> 
>> Hi Dmitry,
>>
>> (relevant people and lists CC'd)
>>
>> On Fri, Oct 6, 2023 at 3:16 AM Dmitry Antipov <dmantipov@yandex.ru> wrote:
>>>
>>> Kalle,
>>>
>>> what's an actual status of brcm80211 driver? It seems
>>> that the relevant MAINTAINERS entries are no longer
>>> useful, and [1] states that Broadcom is just "disappeared".
>>
>> Arend hasn't posted since February:
>> https://lore.kernel.org/linux-wireless/63f72045-e51d-d9a4-a0ed-c221bcdcee03@gmail.com/
>>
>> Franky is still reviewing things as of early August:
>> https://lore.kernel.org/linux-wireless/CA+8PC_evb-6Y3dKnAN4BN=ODEVxY5-cDb6Lc72u0j1WBtx7p1A@mail.gmail.com/
>>
>> Hante hasn't posted since 2018:
>> https://lore.kernel.org/linux-wireless/4f6223b8083ed69432493a37d4f45b69@mail.gmail.com/
>>
>> Hector Martin has a bunch of Apple-specific patches downstream in the
>> Asahi Linux kernel and has been looking for guidance on how to
>> upstream it without any real answers:
>> https://lore.kernel.org/linux-wireless/181af6e9-799d-b730-dc14-ee2de2541f35@marcan.st/
>>
>> There's also speculation that the Raspberry Pi people have downstream
>> patches too, but I haven't been able to find anything concrete in a
>> very brief search.
> 
> Thanks for the research, that is helpful.
> 
>> Finally, the Cypress / Infineon people appear to be uninterested in
>> discussing the driver.
>>
>> I think it's pretty safe to say that this driver is nearly
>> unmaintained by Broadcom, definitely unmaintained by Cypress /
>> Infineon and Arend is unable to answer questions relating to anything
>> beyond the code as-written.
>>
>> Kalle, should this driver get orphaned?
> 
> We definitely need to consider that but let's first wait for Arend to
> comment.

Using my personal email account to comment. Broadcom has pulled away 
most resources from the brcm80211 drivers as there is no business 
interest for it and it turned into a one-fifth man show as I was granted 
to work one day a week on brcm80211. Nice theory but in practice other 
work always takes priority. So "nearly unmaintained" is no exaggeration. 
I probably can not meet the expectations some people in the community 
have regarding driver maintainers, but I can still review patch 
submissions although I should keep a better eye on the list to do that. 
It would not be my choice to abandon brcm80211, but if my contributions 
are considered insufficient than I will accept that fact.

Ever since Infineon took over Cypress wifi business things turned quiet 
soon. Their website still claims brcmfmac is the driver to use. Earlier 
this year I did have contact with them to hear whether they were 
committed to the driver. At least I got an answer, but not much more 
than that.

Regards,
Arend

