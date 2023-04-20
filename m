Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E0966E929B
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Apr 2023 13:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234842AbjDTL25 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 20 Apr 2023 07:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234432AbjDTL2h (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 20 Apr 2023 07:28:37 -0400
Received: from mx1.uni-rostock.de (mx1.uni-rostock.de [139.30.22.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56EEF186
        for <linux-wireless@vger.kernel.org>; Thu, 20 Apr 2023 04:27:38 -0700 (PDT)
DKIM-Signature: v=1; c=relaxed/relaxed; d=uni-rostock.de; s=itmze; 
 t=1681989140; bh=QUqY7pC8lL+MX38rl3VDzowCYLkNUS1wUK3+U61EDXM=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id; 
 a=ed25519-sha256; b=
 z1t9tj6fBDCTgOW0M/riQIh+yDwOSd7N9KNpFaGiL1x6/bPK8hJ/gZ8HeHl7uzWR/H2/sog+9HKmTvvTjqtOBg==
DKIM-Signature: v=1; c=relaxed/relaxed; d=uni-rostock.de; s=itmz; 
 t=1681989140; bh=QUqY7pC8lL+MX38rl3VDzowCYLkNUS1wUK3+U61EDXM=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id; 
 a=rsa-sha256; b=
 ZZWn/YcV3SrauGIpyzJHZhH1mk5M5gFJtdfgHClE0NegmQ7Zw8Wh9EXe0ZjEqllggEFInSXi6HW+A476ltN8x0o9ORRJ+VviTxx///x2q25nVQrBqQYYqhffEtKkbkeJ+jbwacIg/adDabaqjEuIdD7bz41vfG24rjZT2pQ/C+U=
Received: from 139.30.22.84 by mx1.uni-rostock.de (Tls12, Aes256, Sha384,
 DiffieHellmanEllipticKey384); Thu, 20 Apr 2023 11:12:20 GMT
Received: from [139.30.201.34] (139.30.201.34) by mail1.uni-rostock.de
 (139.30.22.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Thu, 20 Apr
 2023 13:12:18 +0200
Message-ID: <ed9249a7-04f6-572f-c35c-6880b3f9ebec@uni-rostock.de>
Date:   Thu, 20 Apr 2023 13:12:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v1] wifi: mac80211: Initialize EWMA fail avg to 1
Content-Language: de-DE
To:     Johannes Berg <johannes@sipsolutions.net>,
        Karthik M <quic_karm@quicinc.com>
CC:     <linux-wireless@vger.kernel.org>,
        Tamizh Chelvam Raja <quic_tamizhr@quicinc.com>
References: <20230417100258.22965-1-quic_karm@quicinc.com>
 <bc1903aa09391667262aeadf1859600579f0a9f1.camel@sipsolutions.net>
 <50a76761-5be3-8ea7-c2f3-a14c158aa039@uni-rostock.de>
 <e4dd26fa53ad2535f5a20be63a4b294d99306ffb.camel@sipsolutions.net>
From:   Benjamin Beichler <Benjamin.Beichler@uni-rostock.de>
Organization: =?UTF-8?Q?Universit=c3=a4t_Rostock?=
In-Reply-To: <e4dd26fa53ad2535f5a20be63a4b294d99306ffb.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
X-Originating-IP: [139.30.201.34]
X-ClientProxiedBy: EMAIL2.uni-rostock.de (139.30.22.82) To
 mail1.uni-rostock.de (139.30.22.84)
X-TM-SNTS-SMTP: 5295FCA9975EB77C32C987FFB4221B33B6002EFDAD75B013F775E5F1B0790DE92000:8
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



>>> To me, basically, I see two ways to solve this:
>>>
>>> 1) we have DECLARE=5FEWMA=5FZERO=5FVALID() or something like that which
>>>      *doesn't* treat 0 as an uninitialized value, and either has a
>>>      separate "not initialized yet" bit (but that's iffy storage wise),
>>>      or simply has another argument to =5Finit() for the initial value or
>>>      so.
>>>
>>> 2) you don't just don't use 0 and 100 but say 1 and 100, that results in
>>>      basically the same behaviour, but avoids the special 0.
>>>
>>> johannes
>> I also ran into that problem in the past, and reviewing it again with a
>> college, I think, this is a real bug in the EWMA implementation. I try
>> to provide a proper patch in the next days, but actually the EWMA
>> handles the internal value zero, always like in the initialization,
>> which is wrong, e.g., for positive/negative averaged values.
> Yes, it's always wrong as long as you feed it something zero, or values
> with different sign.
>
> For a lot of use cases, however, that doesn't matter. Originally, it was
> used e.g. for signal strength averaging, average packet lengths, etc.
> where it really doesn't matter since you can never use 0 or values that
> have different sign.
>
>> A quick research shows, this bug is since the first implementation of
>> the ewma in the code ...
>>
> Yeah, I'm aware of that, I was around for it ;-)
>
> But see above, I'm not sure I'd even call it a bug, at least not
> originally with the users that we had intended.
>
> Hence I don't know if it's really good to fix this in general - for many
> of these cases zero can still be treated specially (and like I mentioned
> in my previous email, we can even here avoid 0), and then we don't spend
> an extra byte (or likely 4) to hold a "first time" flag.
>
> Dunno. Maybe it's not worth thinking about the extra memory space vs.
> the extra maintenance cost. But maybe at least on 64-bit we could steal
> a bit from the unsigned long=3F Not sure what all the users are...
I thought of introducing a separate function to initialize the 
"average", which could be optimized away, when unused. I had a look at 
the usage, and it looks like 10-15 places, which should work with 
initializing or simply weight the new value always, instead of the 
special case.

For me the problem is, that the current implementation is unintuitive or 
at least badly documented.
And I would even claim the same argument, that for most users, the 
behavior for initialization also does not matter, therefore I would use 
the mathematically more natural implementation :-)


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
