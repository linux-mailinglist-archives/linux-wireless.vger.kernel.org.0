Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E04612D7411
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Dec 2020 11:41:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389463AbgLKKj7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 11 Dec 2020 05:39:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23505 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732088AbgLKKj2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 11 Dec 2020 05:39:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607683081;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6SEXvKig3Af6zfihsOVCC7bvRsLoZk4lpwMjto8pubo=;
        b=Y1FEOUYcmdaY2XOX2fdanv0kIfrtOzwENS5F1uCPpUtwhgLbG5lvlY3Gjvzo4toXbLg19q
        BycbdTzxiqXJNpysOFA6ub4NcuUxhAa6HXZ8ZNuSlTz5G7FLvE3fICORYvW+p56bEr5o4v
        eAeAI4ADGvva8pNpj8mFRncI1xCaH1o=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-285-j3YqnB1YMXqZ1swrCRK9eQ-1; Fri, 11 Dec 2020 05:37:59 -0500
X-MC-Unique: j3YqnB1YMXqZ1swrCRK9eQ-1
Received: by mail-wr1-f70.google.com with SMTP id q18so3133318wrc.20
        for <linux-wireless@vger.kernel.org>; Fri, 11 Dec 2020 02:37:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=6SEXvKig3Af6zfihsOVCC7bvRsLoZk4lpwMjto8pubo=;
        b=JPj38uBaPUGpEbp4eQlwuUA2zjyL/FRX2TaeAMjSLQ9DKMIJlAbNsTNykmhgppSu0k
         BAA6NEcxcgGjU2+/agc8xlgwcnk6FTnud5I/6O9GJ+JGuxtCs+ZymeCBEdAUNMP5p02e
         nki4/wwKzdLCyM9K15n4nxl/X5rlSOGFX39dEeE2lVEA60WTUGchImSlMtIj6pWJH/EP
         UwQxXrTmOvrkVya6MQvJow8/IHvPUWiS7Xe2J6R6edlOh/kBKgelwD+tDgpXzet6xas1
         3udsRvG/VSUfBS/SndBYo+9FGHjV36FQvJl2Cs7w6slYpzr8siVprX968HueT3fEATEI
         rrng==
X-Gm-Message-State: AOAM53361lfYvIklLqvQR8cF4H2U8MucM2lF4WSXgWGA0zMtc4J/rOyA
        xQh5vXMkUIl83O4IierQsGLCm05Rw4gF7UDxrtPOik3Tar3JfH5w38SSef1IgqmrqOqLNwXTmiE
        TQOQDG6LZwhwiNb23m7tGs1KNa6w=
X-Received: by 2002:adf:dd90:: with SMTP id x16mr12938079wrl.85.1607683077843;
        Fri, 11 Dec 2020 02:37:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwvr8apxXPdHlxK9BiX/SCe7LXNI69O/UZ3eXAxoxZfG5eggBmfh3p6uC4CWmegSqvUmBmJLg==
X-Received: by 2002:adf:dd90:: with SMTP id x16mr12938039wrl.85.1607683077386;
        Fri, 11 Dec 2020 02:37:57 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id w189sm2324111wmg.31.2020.12.11.02.37.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Dec 2020 02:37:56 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 34D8B180092; Fri, 11 Dec 2020 11:37:56 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Zefir Kurtisi <zefir.kurtisi@westermo.com>,
        Zefir Kurtisi <zefku@westermo.com>,
        linux-wireless@vger.kernel.org
Cc:     Felix Fietkau <nbd@nbd.name>, qca-developer-program@qualcomm.com,
        Adrian Chadd <adrian@freebsd.org>
Subject: Re: [RFT] ath9k: multi-rate-retry fails at HW level
In-Reply-To: <57d98dc9-7e5d-4d2e-335e-5948ef3645ad@westermo.com>
References: <2a8573d7-6683-3414-a8af-dab460772205@westermo.com>
 <878saqlsp8.fsf@toke.dk>
 <d05e928a-c78d-d191-7ae0-6342e05d892a@westermo.com>
 <87r1o91wi6.fsf@toke.dk>
 <57d98dc9-7e5d-4d2e-335e-5948ef3645ad@westermo.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 11 Dec 2020 11:37:56 +0100
Message-ID: <878sa44ohn.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Zefir Kurtisi <zefir.kurtisi@westermo.com> writes:

> On 01.12.20 14:33, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Zefir Kurtisi <zefir.kurtisi@westermo.com> writes:
>>=20
>>> CC +=3D adrian
>>>
>>> On 24.11.20 15:45, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>>>> Zefir Kurtisi <zefku@westermo.com> writes:
>>>>
>>>>> Hi,
>>>>>
>>>>> I am running into a strange issue with the ath9k operating a 9590
>>>>> device which to me seems like a HW issue, but since work on rate
>>>>> controllers is already going for decades, I hardly can imagine this
>>>>> never showed up.
>>>>>
>>>>> The issue observed is this: the TX status descriptors never report
>>>>> rateindex 1, it is always 0, 2, or 3, but never 1.
>>>>>
>>>>> I noticed this by overwriting the rate configuration provided by
>>>>> minstrel to a static setup, e.g. (7,3)(5,3)(3,3)(1,3), all MCS. The
>>>>> device operates as iperf client to a connected AP and continuously
>>>>> transmits data. While at that, the attenuation between the endpoints
>>>>> is gradually increased, expecting to see a gradual shift in the
>>>>> reported TX status rateindex from 0 to 3. But nada, the values
>>>>> reported are 0,2, and 3 - never 1.
>>>>>
>>>>> I double checked that the TX descriptors are correctly set with the
>>>>> rates and retry counts - all looking sane.
>>>>>
>>>>> More obvious, after changing the rate configuration to
>>>>> (7,3)(1,3)(5,3)(3,3) the expectation would be to have either 0 or 1
>>>>> reported as rateidx, since the transmission ought to be successful
>>>>> with the lowest rate or never. Again all rates are reported but 1.
>>>>>
>>>>> Now the question for me is: what is the HW exactly doing with such a
>>>>> configuration? Is it skipping the second rate, or is it just reporting
>>>>> wrong?
>>>>
>>>> You should be able to see this by looking at the rates the frames are
>>>> being sent at, shouldn't you?
>>>>
>>> Yes, did that and from there it points to that the second rate is just =
skipped.
>>>
>>> Here are some use cases and their sniffing results. Setup is a 11ng STA=
 connected
>>> to AP with the attenuation adjusted such that MCS 7 fails, while MCS 5 =
and below
>>> succeed. Monitor is sniffing while sending a single ping from AP to STA.
>>>
>>> With a rate configuration of (7/2)(3/2)(1/2) we get:
>>> 14:02:42.923880 9481489761us tsft 2412 MHz 11n -68dBm signal 65.0 Mb/s =
MCS 7 20
>>> MHz long GI RX-STBC0 -68dBm signal antenna 0 Data IV:  e Pad 20 KeyID 0
>>> 14:02:42.923909 9481490037us tsft 2412 MHz 11n -69dBm signal 65.0 Mb/s =
MCS 7 20
>>> MHz long GI RX-STBC0 -69dBm signal antenna 0 Data IV:  e Pad 20 KeyID 0
>>> 14:02:42.925244 9481491044us tsft 2412 MHz 11n -68dBm signal 13.0 Mb/s =
MCS 1 20
>>> MHz long GI RX-STBC0 -68dBm signal antenna 0 Data IV:  e Pad 20 KeyID 0
>>>
>>>
>>> with (7/2)(1/2)(3/2):
>>> 13:59:37.073147 9295637087us tsft 2412 MHz 11n -69dBm signal 65.0 Mb/s =
MCS 7 20
>>> MHz long GI RX-STBC0 -69dBm signal antenna 0 Data IV:  c Pad 20 KeyID 0
>>> 13:59:37.073467 9295637438us tsft 2412 MHz 11n -69dBm signal 65.0 Mb/s =
MCS 7 20
>>> MHz long GI RX-STBC0 -69dBm signal antenna 0 Data IV:  c Pad 20 KeyID 0
>>> 13:59:37.074591 9295638498us tsft 2412 MHz 11n -68dBm signal 26.0 Mb/s =
MCS 3 20
>>> MHz long GI RX-STBC0 -68dBm signal antenna 0 Data IV:  c Pad 20 KeyID 0
>>>
>>> and with (7/2)(3/2):
>>> 14:04:27.269806 9585836783us tsft 2412 MHz 11n -69dBm signal 65.0 Mb/s =
MCS 7 20
>>> MHz long GI RX-STBC0 -69dBm signal antenna 0 Data IV: 10 Pad 20 KeyID 0
>>> 14:04:27.270342 9585837344us tsft 2412 MHz 11n -68dBm signal 65.0 Mb/s =
MCS 7 20
>>> MHz long GI RX-STBC0 -68dBm signal antenna 0 Data IV: 10 Pad 20 KeyID 0
>>> 14:04:27.271368 9585838370us tsft 2412 MHz 11n -68dBm signal 65.0 Mb/s =
MCS 7 20
>>> MHz long GI RX-STBC0 -68dBm signal antenna 0 Data IV: 10 Pad 20 KeyID 0
>>> [..]
>>>
>>> a total of 14 attempts at MCS 7 with the ping finally failing.
>>>
>>>>> Both possibilities have great impact, since upper layers (like
>>>>> airtime) use the returned rateidx to calculate and configure operating
>>>>> parameters at runtime.
>>>>
>>>> Have you actually observed any issues from this? If it's just skipping=
 a
>>>> rate, minstrel should still be able to make decisions based on the
>>>> actual values returned, no?
>>>>
>>> The issues arise from the fact that the driver reports a
>>> (tx-rateindex/tx-attemp-index) per TX descriptor, leaving the driver to=
 calculate
>>> what was put on air based on these two values. If one had rates set to
>>> (7/2)(3/7)(1/2) and the TX status reports (tx-rateindex=3D2/tx-attempt-=
index=3D0),
>>> driver assumes there were 10 attempts in total while in fact they were =
3 when the
>>> second rate is skipped. What direct effect this has on RC I can't grasp=
, but it
>>> definitively falsifies statistics.
>>>
>>> Same goes for airtime: check how this falsifies its calculation in
>>> ath_tx_count_airtime().
>>=20
>> Ah, right, I was assuming that rates[1].count would be reset to zero
>> somehow. Have you confirmed that the attempts actually go up on in the
>> Minstrel stats for the skipped rate?
>>=20
>>> Also, the above mentioned is an immediate visible issue: if RC
>>> provides two rates e.g. (7/3)(5/3) of which the first is too high and
>>> the second is not even attempted, frames don't make it through.
>>=20
>> Yeah, rate control would likely take longer to converge to the right
>> rate. I suppose if this is a hardware model-specific issue that a quirks
>> bit could be added to instruct Minstrel to disregard the second index.
>> But it does sound a bit odd; have you verified that it's consistent on
>> different units of the same model (and not just a busted device)?
>>=20
>
> False alarm.
>
> We got confirmation that the observed failure with that exact chip
> revision is not happening on a different platform. It still might be a
> HW issue specific to our rarely used PPC platform, but it is not an
> ath9k malfunction. I'll dig further into that and report back if it is
> relevant for the list.
>
> Thanks Toke for the feedback and insights and sorry for noise.

You're welcome, and great to hear that you got closer to a resolution :)

-Toke

