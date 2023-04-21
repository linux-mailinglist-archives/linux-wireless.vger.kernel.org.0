Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BDD26EA847
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Apr 2023 12:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231239AbjDUKYF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 21 Apr 2023 06:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231267AbjDUKYE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 21 Apr 2023 06:24:04 -0400
Received: from mx2.uni-rostock.de (mx2.uni-rostock.de [139.30.22.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 532D5173F
        for <linux-wireless@vger.kernel.org>; Fri, 21 Apr 2023 03:23:52 -0700 (PDT)
DKIM-Signature: v=1; c=relaxed/relaxed; d=uni-rostock.de; s=itmze; 
 t=1682072630; bh=U7QT9ilCZnPZNVGePCUchBngRYiA3WKJk6lip6SeH7Q=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id; 
 a=ed25519-sha256; b=
 K8tRD9H411ma/CqgZoG/9Jzpl5voy56TBMSNCrN7OxXJ3IEMNzuOOtSe8NubkdykH0okz2fwJixlVODAgcTOCg==
DKIM-Signature: v=1; c=relaxed/relaxed; d=uni-rostock.de; s=itmz; 
 t=1682072630; bh=U7QT9ilCZnPZNVGePCUchBngRYiA3WKJk6lip6SeH7Q=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id; 
 a=rsa-sha256; b=
 Gvp0Ya5Yx5N1SSv4EXQcG7ecAzm36wSeYsmZucT0d3+pGeN8Kk+00yKhg/UXfozoCh/uaf0NXwmdHMoCYutimZsVOJIk114/BJ9kTcVI+APO+sXrFTUGP3m88Z/x9UbDTQYqko4IYVbPshlTngTdN9ZXzco1nMcw3neUZaM1Cp8=
Received: from 139.30.22.84 by mx2.uni-rostock.de (Tls12, Aes256, Sha384,
 DiffieHellmanEllipticKey384); Fri, 21 Apr 2023 10:23:50 GMT
Received: from [172.16.0.2] (104.28.223.198) by mail1.uni-rostock.de
 (139.30.22.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Fri, 21 Apr
 2023 12:23:17 +0200
Message-ID: <9d2bb3e4-4d37-fc9e-08c6-a862c6fda7d5@uni-rostock.de>
Date:   Fri, 21 Apr 2023 12:23:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
From:   Benjamin Beichler <Benjamin.Beichler@uni-rostock.de>
Subject: Re: [PATCH v1] wifi: mac80211: Initialize EWMA fail avg to 1
To:     Felix Fietkau <nbd@nbd.name>
CC:     Johannes Berg <johannes@sipsolutions.net>,
        Karthik M <quic_karm@quicinc.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Tamizh Chelvam Raja <quic_tamizhr@quicinc.com>
References: <4f0efc62-0ca5-fe85-fdd8-9beca7ff94d7@uni-rostock.de>
 <04A41274-08B2-4473-AFD0-7D91D3850F4B@nbd.name>
Content-Language: de-DE
Organization: =?UTF-8?Q?Universit=c3=a4t_Rostock?=
In-Reply-To: <04A41274-08B2-4473-AFD0-7D91D3850F4B@nbd.name>
Content-Type: text/plain; charset="UTF-8"; format=flowed
X-Originating-IP: [104.28.223.198]
X-ClientProxiedBy: EMAIL2.uni-rostock.de (139.30.22.82) To
 mail1.uni-rostock.de (139.30.22.84)
X-TM-SNTS-SMTP: 51E65A1DD2F4D3A736FF91C4FD8F42FBC1AC89040252036DFF0D634CCEAAAE252000:8
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MIME_QP_LONG_LINE,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Am 20.04.2023 um 15:15 schrieb Felix Fietkau:
>> On 20. Apr 2023, at 15:00, Benjamin Beichler<Benjamin.Beichler@uni-rostock.=
de>  wrote:
>>
>> =EF=BB=BFAm 20.04.2023 um 14:22 schrieb Felix Fietkau:
>>>> On 20.04.23 12:27, Johannes Berg wrote:
>>>> On Thu, 2023-04-20 at 11:30 +0200, Benjamin Beichler wrote:
>>>>>> To me, basically, I see two ways to solve this:
>>>>>>
>>>>>> 1) we have DECLARE=5FEWMA=5FZERO=5FVALID() or something like that which
>>>>>>      *doesn't* treat 0 as an uninitialized value, and either has a
>>>>>>      separate "not initialized yet" bit (but that's iffy storage wise),
>>>>>>      or simply has another argument to =5Finit() for the initial value =
or
>>>>>>      so.
>>>>>>
>>>>>> 2) you don't just don't use 0 and 100 but say 1 and 100, that results i=
n
>>>>>>      basically the same behaviour, but avoids the special 0.
>>>>>>
>>>>>> johannes
>>>>> I also ran into that problem in the past, and reviewing it again with a
>>>>> college, I think, this is a real bug in the EWMA implementation. I try
>>>>> to provide a proper patch in the next days, but actually the EWMA
>>>>> handles the internal value zero, always like in the initialization,
>>>>> which is wrong, e.g., for positive/negative averaged values.
>>>> Yes, it's always wrong as long as you feed it something zero, or values
>>>> with different sign.
>>>>
>>>> For a lot of use cases, however, that doesn't matter. Originally, it was
>>>> used e.g. for signal strength averaging, average packet lengths, etc.
>>>> where it really doesn't matter since you can never use 0 or values that
>>>> have different sign.
>>>>
>>>>> A quick research shows, this bug is since the first implementation of
>>>>> the ewma in the code ...
>>>>>
>>>> Yeah, I'm aware of that, I was around for it ;-)
>>>>
>>>> But see above, I'm not sure I'd even call it a bug, at least not
>>>> originally with the users that we had intended.
>>>>
>>>> Hence I don't know if it's really good to fix this in general - for many
>>>> of these cases zero can still be treated specially (and like I mentioned
>>>> in my previous email, we can even here avoid 0), and then we don't spend
>>>> an extra byte (or likely 4) to hold a "first time" flag.
>>>>
>>>> Dunno. Maybe it's not worth thinking about the extra memory space vs.
>>>> the extra maintenance cost. But maybe at least on 64-bit we could steal
>>>> a bit from the unsigned long=3F Not sure what all the users are..
>>> We don't actually need a full bit. We can just add 1 to the internal
>>> value for initialized values. How about this (completely untested):
>>> https://nbd.name/p/69b00c5b
>>>
>> Nice hack, but even a bit more dirty than before :-D
> I disagree. With my =E2=80=9Chack=E2=80=9D at least the implementation will =
do the right thing without the API user having to worry about 0 as a value. It=
 could use some comments to clarify the details, but I do think it makes thing=
s easier.

I would like to cite Johannes here:

> I mean, I guess I can see where this patch makes some sense like from a
> code point of view, this is sort of the minimal code change you could
> make to make the existing code work, but ... I'd argue you're optimising
> to the wrong metric here, "minimal code changes to fix the bug" should
> normally not be your metric, it should be "code changes that make this
> clearer and avoid the problem", or something like that=3F
I agree that you solve the problem, but it is not clearer. And as a user I exp=
ect to have a classical EWMA, which I initialize with a proper value and then =
use it with normal inputs (where I include zero and negative numbers).
 From my understanding, you shifted the problem only to one digit before zero,=
 which may even not solve it for the mesh case here (but maybe I did not catch=
 it right).

I may also argue, that you introduce 2 additions into the hot path to avoid a =
separate init function, which is mostly called once. And it even introduces no=
n-intuitive behavior in corner cases.
However, even the mostly unused branch on the value of internal for initializa=
tion is suboptimal for the hot path and would be an indicator for a separate i=
nit function.

 From my dig into the usages, most do not care for initialization or do it exp=
licitly with bogus add calls, which can be simply replaced.


Benjamin

