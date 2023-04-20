Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 669C46E953E
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Apr 2023 15:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbjDTNBJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 20 Apr 2023 09:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbjDTNBI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 20 Apr 2023 09:01:08 -0400
Received: from mx1.uni-rostock.de (mx1.uni-rostock.de [139.30.22.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0394A72BC
        for <linux-wireless@vger.kernel.org>; Thu, 20 Apr 2023 06:00:51 -0700 (PDT)
DKIM-Signature: v=1; c=relaxed/relaxed; d=uni-rostock.de; s=itmze; 
 t=1681995649; bh=rc7f3eHH68lO2o9OBw5Uf7uK0dOhyJs7Z+EJUyodOmM=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id; 
 a=ed25519-sha256; b=
 TZvxHJzV1u0InFyfVUcLW5TxAoY18LMCzz4pKuQgUkfdpjWF0L1WI48WOesRd0dPSe9vOjpw/LHTuMHtcKqXDg==
DKIM-Signature: v=1; c=relaxed/relaxed; d=uni-rostock.de; s=itmz; 
 t=1681995649; bh=rc7f3eHH68lO2o9OBw5Uf7uK0dOhyJs7Z+EJUyodOmM=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id; 
 a=rsa-sha256; b=
 dEvXdYz7Y1gfWMfYTlEjYILHsDWfYZBaPaz1kZ99pUfqnyXhebT5n4u2JwhMTTUucmeEZEcNFOkaKiwG2cTjF7Trc6sWzhxas5K1MrQjnBOaHz718iu8pPDagyWh3pkDB7etslUkv67ByXwF0gv4ZiMxhkJ0AhFLBNtneaBA36E=
Received: from 139.30.22.84 by mx1.uni-rostock.de (Tls12, Aes256, Sha384,
 DiffieHellmanEllipticKey384); Thu, 20 Apr 2023 13:00:49 GMT
Received: from [139.30.201.34] (139.30.201.34) by mail1.uni-rostock.de
 (139.30.22.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Thu, 20 Apr
 2023 15:00:47 +0200
Message-ID: <4f0efc62-0ca5-fe85-fdd8-9beca7ff94d7@uni-rostock.de>
Date:   Thu, 20 Apr 2023 15:00:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v1] wifi: mac80211: Initialize EWMA fail avg to 1
Content-Language: de-DE
To:     Felix Fietkau <nbd@nbd.name>,
        Johannes Berg <johannes@sipsolutions.net>,
        Karthik M <quic_karm@quicinc.com>
CC:     <linux-wireless@vger.kernel.org>,
        Tamizh Chelvam Raja <quic_tamizhr@quicinc.com>
References: <20230417100258.22965-1-quic_karm@quicinc.com>
 <bc1903aa09391667262aeadf1859600579f0a9f1.camel@sipsolutions.net>
 <50a76761-5be3-8ea7-c2f3-a14c158aa039@uni-rostock.de>
 <e4dd26fa53ad2535f5a20be63a4b294d99306ffb.camel@sipsolutions.net>
 <6d97d1f3-9f77-a1c3-68b5-83065c87b4ba@nbd.name>
From:   Benjamin Beichler <Benjamin.Beichler@uni-rostock.de>
Organization: =?UTF-8?Q?Universit=c3=a4t_Rostock?=
In-Reply-To: <6d97d1f3-9f77-a1c3-68b5-83065c87b4ba@nbd.name>
Content-Type: text/plain; charset="UTF-8"; format=flowed
X-Originating-IP: [139.30.201.34]
X-ClientProxiedBy: EMAIL2.uni-rostock.de (139.30.22.82) To
 mail1.uni-rostock.de (139.30.22.84)
X-TM-SNTS-SMTP: BF481CF5BAA9850C82F4D28B023BCDBC09597E19397B1A960C97A89763ABE2062000:8
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MIME_QP_LONG_LINE,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Am 20.04.2023 um 14:22 schrieb Felix Fietkau:
> On 20.04.23 12:27, Johannes Berg wrote:
>> On Thu, 2023-04-20 at 11:30 +0200, Benjamin Beichler wrote:
>>> > To me, basically, I see two ways to solve this:
>>> >
>>> > 1) we have DECLARE=5FEWMA=5FZERO=5FVALID() or something like that which
>>> >=C2=A0=C2=A0=C2=A0=C2=A0 *doesn't* treat 0 as an uninitialized value, and=
 either has a
>>> >=C2=A0=C2=A0=C2=A0=C2=A0 separate "not initialized yet" bit (but that's i=
ffy storage 
>>> wise),
>>> >=C2=A0=C2=A0=C2=A0=C2=A0 or simply has another argument to =5Finit() for =
the initial 
>>> value or
>>> >=C2=A0=C2=A0=C2=A0=C2=A0 so.
>>> >
>>> > 2) you don't just don't use 0 and 100 but say 1 and 100, that 
>>> results in
>>> >=C2=A0=C2=A0=C2=A0=C2=A0 basically the same behaviour, but avoids the spe=
cial 0.
>>> >
>>> > johannes
>>>
>>> I also ran into that problem in the past, and reviewing it again with a
>>> college, I think, this is a real bug in the EWMA implementation. I try
>>> to provide a proper patch in the next days, but actually the EWMA
>>> handles the internal value zero, always like in the initialization,
>>> which is wrong, e.g., for positive/negative averaged values.
>>
>> Yes, it's always wrong as long as you feed it something zero, or values
>> with different sign.
>>
>> For a lot of use cases, however, that doesn't matter. Originally, it was
>> used e.g. for signal strength averaging, average packet lengths, etc.
>> where it really doesn't matter since you can never use 0 or values that
>> have different sign.
>>
>>> A quick research shows, this bug is since the first implementation of
>>> the ewma in the code ...
>>>
>>
>> Yeah, I'm aware of that, I was around for it ;-)
>>
>> But see above, I'm not sure I'd even call it a bug, at least not
>> originally with the users that we had intended.
>>
>> Hence I don't know if it's really good to fix this in general - for many
>> of these cases zero can still be treated specially (and like I mentioned
>> in my previous email, we can even here avoid 0), and then we don't spend
>> an extra byte (or likely 4) to hold a "first time" flag.
>>
>> Dunno. Maybe it's not worth thinking about the extra memory space vs.
>> the extra maintenance cost. But maybe at least on 64-bit we could steal
>> a bit from the unsigned long=3F Not sure what all the users are..
> We don't actually need a full bit. We can just add 1 to the internal
> value for initialized values. How about this (completely untested):
> https://nbd.name/p/69b00c5b
>
Nice hack, but even a bit more dirty than before :-D

I think being more explicit, does not hurt here.

Maybe we could rename it ewma=5F*=5Fadd=5For=5Finit and do a separate function=
 
with ewma=5F*=5Fadd. Since it is inlined, there will be no significant text 
size increase (except a driver uses both functions).


> - Felix
>

-- 
M.Sc. Benjamin Beichler

Universit=C3=A4t Rostock, Fakult=C3=A4t f=C3=BCr Informatik und Elektrotechnik
Institut f=C3=BCr Angewandte Mikroelektronik und Datentechnik

University of Rostock, Department of CS and EE
Institute of Applied Microelectronics and CE

Albert-Einstein-Str. 26
18059 Rostock
Deutschland/Germany

phone: +49 (0) 381 498 - 7278
email: Benjamin.Beichler@uni-rostock.de
www: http://www.imd.uni-rostock.de/
