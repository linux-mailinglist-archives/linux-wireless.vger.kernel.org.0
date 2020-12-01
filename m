Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6182CA3EE
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Dec 2020 14:36:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388974AbgLANfK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Dec 2020 08:35:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30917 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387723AbgLANfK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Dec 2020 08:35:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606829623;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uEOuZ03//h7eOIaNTSqraBUKB6vXrZdDDrDyqrtS2XQ=;
        b=hrowUvlTAXkYIJ+qtHt37KfGOG9xfNeReHeN0IjOdzvtqOxozC4YCQF0LsIw2RtdSbKwfq
        sZrBTIIGunxFZkXYa1gg4mrjanFOXaY9f9LPsmme972wy6mVDhJeKnvfSNAoXLzDRT5O3A
        eKWromqqEr28ttqCRoHA2eqKAjYiziU=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-561-S2QdU4QBMiGU8j2FJsTDkA-1; Tue, 01 Dec 2020 08:33:41 -0500
X-MC-Unique: S2QdU4QBMiGU8j2FJsTDkA-1
Received: by mail-ej1-f69.google.com with SMTP id dv25so149214ejb.15
        for <linux-wireless@vger.kernel.org>; Tue, 01 Dec 2020 05:33:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=uEOuZ03//h7eOIaNTSqraBUKB6vXrZdDDrDyqrtS2XQ=;
        b=c/cRgCT+isNsGWyzwzJNvT6+gaiU+tuGUgiNq7PRvF0QCJoKPfHCCYjUKwPaq09i0G
         TE7LXrIr5PsjgU8UxRuf48EvCCb7GqKHu0Gwzs21XIz/+OnRDJaHS6hR7uLGDQcZcVB5
         VBnmT/UF+HT911yIsLhjP/tj+495vm2hd1mu5vIzgg/qD0HsoUB5+lm5EzJl2uqbTBac
         A+ioHCG3hdyBOdB3Y933FAAQwwCaC4g+z0yd5vpFWIQGAjBBI5G8sSie8U3riKoGPbM0
         Sal3fFWCO45SsUPCXFZCqK6Q5lMDJAireDiDdZ/nrPNdhXee1Tm8/aSC35wv7RGSljxt
         r1IQ==
X-Gm-Message-State: AOAM531GiYR5fq00eg4g7HY23nX2/BQ0AmgW7hy8H81nxrHeZtxVqFBi
        YnxIp8W/eeb4a0gTkHDjTgawJNJiSrYjI2EM3pzLtbpONZdN8RM0tt7129Yij2aUEzpkC2HSsQt
        /JYzkg9DrGp1LAI+xsnLV4WdLlX4=
X-Received: by 2002:a50:d09b:: with SMTP id v27mr3009104edd.181.1606829618853;
        Tue, 01 Dec 2020 05:33:38 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx3kw0tc0VLaGxn5otWQ8TRnnkKF0QwSd6/z74SboVLIocAzNVUGnp7Qo0UGun4WIUQ+pow/g==
X-Received: by 2002:a50:d09b:: with SMTP id v27mr3009064edd.181.1606829618300;
        Tue, 01 Dec 2020 05:33:38 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id i21sm843226edt.92.2020.12.01.05.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 05:33:37 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 26804182EF0; Tue,  1 Dec 2020 14:33:37 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Zefir Kurtisi <zefir.kurtisi@westermo.com>,
        Zefir Kurtisi <zefku@westermo.com>,
        linux-wireless@vger.kernel.org
Cc:     Felix Fietkau <nbd@nbd.name>, qca-developer-program@qualcomm.com,
        Adrian Chadd <adrian@freebsd.org>
Subject: Re: [RFT] ath9k: multi-rate-retry fails at HW level
In-Reply-To: <d05e928a-c78d-d191-7ae0-6342e05d892a@westermo.com>
References: <2a8573d7-6683-3414-a8af-dab460772205@westermo.com>
 <878saqlsp8.fsf@toke.dk>
 <d05e928a-c78d-d191-7ae0-6342e05d892a@westermo.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 01 Dec 2020 14:33:37 +0100
Message-ID: <87r1o91wi6.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Zefir Kurtisi <zefir.kurtisi@westermo.com> writes:

> CC +=3D adrian
>
> On 24.11.20 15:45, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> Zefir Kurtisi <zefku@westermo.com> writes:
>>=20
>>> Hi,
>>>
>>> I am running into a strange issue with the ath9k operating a 9590
>>> device which to me seems like a HW issue, but since work on rate
>>> controllers is already going for decades, I hardly can imagine this
>>> never showed up.
>>>
>>> The issue observed is this: the TX status descriptors never report
>>> rateindex 1, it is always 0, 2, or 3, but never 1.
>>>
>>> I noticed this by overwriting the rate configuration provided by
>>> minstrel to a static setup, e.g. (7,3)(5,3)(3,3)(1,3), all MCS. The
>>> device operates as iperf client to a connected AP and continuously
>>> transmits data. While at that, the attenuation between the endpoints
>>> is gradually increased, expecting to see a gradual shift in the
>>> reported TX status rateindex from 0 to 3. But nada, the values
>>> reported are 0,2, and 3 - never 1.
>>>
>>> I double checked that the TX descriptors are correctly set with the
>>> rates and retry counts - all looking sane.
>>>
>>> More obvious, after changing the rate configuration to
>>> (7,3)(1,3)(5,3)(3,3) the expectation would be to have either 0 or 1
>>> reported as rateidx, since the transmission ought to be successful
>>> with the lowest rate or never. Again all rates are reported but 1.
>>>
>>> Now the question for me is: what is the HW exactly doing with such a
>>> configuration? Is it skipping the second rate, or is it just reporting
>>> wrong?
>>=20
>> You should be able to see this by looking at the rates the frames are
>> being sent at, shouldn't you?
>>=20
> Yes, did that and from there it points to that the second rate is just sk=
ipped.
>
> Here are some use cases and their sniffing results. Setup is a 11ng STA c=
onnected
> to AP with the attenuation adjusted such that MCS 7 fails, while MCS 5 an=
d below
> succeed. Monitor is sniffing while sending a single ping from AP to STA.
>
> With a rate configuration of (7/2)(3/2)(1/2) we get:
> 14:02:42.923880 9481489761us tsft 2412 MHz 11n -68dBm signal 65.0 Mb/s MC=
S 7 20
> MHz long GI RX-STBC0 -68dBm signal antenna 0 Data IV:  e Pad 20 KeyID 0
> 14:02:42.923909 9481490037us tsft 2412 MHz 11n -69dBm signal 65.0 Mb/s MC=
S 7 20
> MHz long GI RX-STBC0 -69dBm signal antenna 0 Data IV:  e Pad 20 KeyID 0
> 14:02:42.925244 9481491044us tsft 2412 MHz 11n -68dBm signal 13.0 Mb/s MC=
S 1 20
> MHz long GI RX-STBC0 -68dBm signal antenna 0 Data IV:  e Pad 20 KeyID 0
>
>
> with (7/2)(1/2)(3/2):
> 13:59:37.073147 9295637087us tsft 2412 MHz 11n -69dBm signal 65.0 Mb/s MC=
S 7 20
> MHz long GI RX-STBC0 -69dBm signal antenna 0 Data IV:  c Pad 20 KeyID 0
> 13:59:37.073467 9295637438us tsft 2412 MHz 11n -69dBm signal 65.0 Mb/s MC=
S 7 20
> MHz long GI RX-STBC0 -69dBm signal antenna 0 Data IV:  c Pad 20 KeyID 0
> 13:59:37.074591 9295638498us tsft 2412 MHz 11n -68dBm signal 26.0 Mb/s MC=
S 3 20
> MHz long GI RX-STBC0 -68dBm signal antenna 0 Data IV:  c Pad 20 KeyID 0
>
> and with (7/2)(3/2):
> 14:04:27.269806 9585836783us tsft 2412 MHz 11n -69dBm signal 65.0 Mb/s MC=
S 7 20
> MHz long GI RX-STBC0 -69dBm signal antenna 0 Data IV: 10 Pad 20 KeyID 0
> 14:04:27.270342 9585837344us tsft 2412 MHz 11n -68dBm signal 65.0 Mb/s MC=
S 7 20
> MHz long GI RX-STBC0 -68dBm signal antenna 0 Data IV: 10 Pad 20 KeyID 0
> 14:04:27.271368 9585838370us tsft 2412 MHz 11n -68dBm signal 65.0 Mb/s MC=
S 7 20
> MHz long GI RX-STBC0 -68dBm signal antenna 0 Data IV: 10 Pad 20 KeyID 0
> [..]
>
> a total of 14 attempts at MCS 7 with the ping finally failing.
>
>>> Both possibilities have great impact, since upper layers (like
>>> airtime) use the returned rateidx to calculate and configure operating
>>> parameters at runtime.
>>=20
>> Have you actually observed any issues from this? If it's just skipping a
>> rate, minstrel should still be able to make decisions based on the
>> actual values returned, no?
>>=20
> The issues arise from the fact that the driver reports a
> (tx-rateindex/tx-attemp-index) per TX descriptor, leaving the driver to c=
alculate
> what was put on air based on these two values. If one had rates set to
> (7/2)(3/7)(1/2) and the TX status reports (tx-rateindex=3D2/tx-attempt-in=
dex=3D0),
> driver assumes there were 10 attempts in total while in fact they were 3 =
when the
> second rate is skipped. What direct effect this has on RC I can't grasp, =
but it
> definitively falsifies statistics.
>
> Same goes for airtime: check how this falsifies its calculation in
> ath_tx_count_airtime().

Ah, right, I was assuming that rates[1].count would be reset to zero
somehow. Have you confirmed that the attempts actually go up on in the
Minstrel stats for the skipped rate?

> Also, the above mentioned is an immediate visible issue: if RC
> provides two rates e.g. (7/3)(5/3) of which the first is too high and
> the second is not even attempted, frames don't make it through.

Yeah, rate control would likely take longer to converge to the right
rate. I suppose if this is a hardware model-specific issue that a quirks
bit could be added to instruct Minstrel to disregard the second index.
But it does sound a bit odd; have you verified that it's consistent on
different units of the same model (and not just a busted device)?

-Toke

