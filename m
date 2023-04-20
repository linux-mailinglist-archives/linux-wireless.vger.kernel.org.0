Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C10EA6E959D
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Apr 2023 15:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbjDTNQC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 20 Apr 2023 09:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbjDTNQB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 20 Apr 2023 09:16:01 -0400
Received: from nbd.name (nbd.name [46.4.11.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2A2D270E
        for <linux-wireless@vger.kernel.org>; Thu, 20 Apr 2023 06:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
        s=20160729; h=To:In-Reply-To:Cc:References:Message-Id:Date:Subject:
        Mime-Version:From:Content-Transfer-Encoding:Content-Type:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=kXFnjDYK7gWVoksmPYs99aYNRzc25o0pHI/JaY9LFRY=; b=tzQLJefYPnmiqTwlTgmDm3Qpvt
        nCoDdM4smuUuc6Fce1at/F6q85vBAx4skUJxXCdP4Ug65znx0ny+UTvStoG5+AIrv578sZtSd0dLv
        /8rh+gtZ2seXTm/73pHQhVpkxK2iwU5VE41WNlKXrbUDQdUl/QPEXzmPWz2I0Wg36Owk=;
Received: from [2a01:598:b1a2:f936:a9ac:34e4:49fa:2af] (helo=smtpclient.apple)
        by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <nbd@nbd.name>)
        id 1ppU8h-00GfPu-Aw; Thu, 20 Apr 2023 15:15:55 +0200
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Felix Fietkau <nbd@nbd.name>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v1] wifi: mac80211: Initialize EWMA fail avg to 1
Date:   Thu, 20 Apr 2023 15:15:44 +0200
Message-Id: <04A41274-08B2-4473-AFD0-7D91D3850F4B@nbd.name>
References: <4f0efc62-0ca5-fe85-fdd8-9beca7ff94d7@uni-rostock.de>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        Karthik M <quic_karm@quicinc.com>,
        linux-wireless@vger.kernel.org,
        Tamizh Chelvam Raja <quic_tamizhr@quicinc.com>
In-Reply-To: <4f0efc62-0ca5-fe85-fdd8-9beca7ff94d7@uni-rostock.de>
To:     Benjamin Beichler <Benjamin.Beichler@uni-rostock.de>
X-Mailer: iPhone Mail (20E252)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org



> On 20. Apr 2023, at 15:00, Benjamin Beichler <Benjamin.Beichler@uni-rostoc=
k.de> wrote:
>=20
> =EF=BB=BFAm 20.04.2023 um 14:22 schrieb Felix Fietkau:
>>> On 20.04.23 12:27, Johannes Berg wrote:
>>> On Thu, 2023-04-20 at 11:30 +0200, Benjamin Beichler wrote:
>>>> > To me, basically, I see two ways to solve this:
>>>> >
>>>> > 1) we have DECLARE_EWMA_ZERO_VALID() or something like that which
>>>> >     *doesn't* treat 0 as an uninitialized value, and either has a
>>>> >     separate "not initialized yet" bit (but that's iffy storage wise)=
,
>>>> >     or simply has another argument to _init() for the initial value o=
r
>>>> >     so.
>>>> >
>>>> > 2) you don't just don't use 0 and 100 but say 1 and 100, that results=
 in
>>>> >     basically the same behaviour, but avoids the special 0.
>>>> >
>>>> > johannes
>>>>=20
>>>> I also ran into that problem in the past, and reviewing it again with a=

>>>> college, I think, this is a real bug in the EWMA implementation. I try
>>>> to provide a proper patch in the next days, but actually the EWMA
>>>> handles the internal value zero, always like in the initialization,
>>>> which is wrong, e.g., for positive/negative averaged values.
>>>=20
>>> Yes, it's always wrong as long as you feed it something zero, or values
>>> with different sign.
>>>=20
>>> For a lot of use cases, however, that doesn't matter. Originally, it was=

>>> used e.g. for signal strength averaging, average packet lengths, etc.
>>> where it really doesn't matter since you can never use 0 or values that
>>> have different sign.
>>>=20
>>>> A quick research shows, this bug is since the first implementation of
>>>> the ewma in the code ...
>>>>=20
>>>=20
>>> Yeah, I'm aware of that, I was around for it ;-)
>>>=20
>>> But see above, I'm not sure I'd even call it a bug, at least not
>>> originally with the users that we had intended.
>>>=20
>>> Hence I don't know if it's really good to fix this in general - for many=

>>> of these cases zero can still be treated specially (and like I mentioned=

>>> in my previous email, we can even here avoid 0), and then we don't spend=

>>> an extra byte (or likely 4) to hold a "first time" flag.
>>>=20
>>> Dunno. Maybe it's not worth thinking about the extra memory space vs.
>>> the extra maintenance cost. But maybe at least on 64-bit we could steal
>>> a bit from the unsigned long? Not sure what all the users are..
>> We don't actually need a full bit. We can just add 1 to the internal
>> value for initialized values. How about this (completely untested):
>> https://nbd.name/p/69b00c5b
>>=20
> Nice hack, but even a bit more dirty than before :-D

I disagree. With my =E2=80=9Chack=E2=80=9D at least the implementation will d=
o the right thing without the API user having to worry about 0 as a value. I=
t could use some comments to clarify the details, but I do think it makes th=
ings easier.

- Felix=
