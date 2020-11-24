Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15AC72C29FC
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Nov 2020 15:46:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389255AbgKXOpQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 Nov 2020 09:45:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:37230 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388319AbgKXOpQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 Nov 2020 09:45:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606229114;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EZ/jeYBlyZkL5pjYnppCWoaG2cKZhox2o7qCEtKhG0I=;
        b=RgikeUvzk/7CMwsw5IaHq1wUkpO4EfGyfqpcMswj0u7D0tDMqSpBvZmvRV2GI0UulFxZfU
        Ludc/N6S8lX3JRE8lfg/030t1FgRfn6m5RN7JsRXYm9RN1pz4b78DtgPerirOKwFz3QSdr
        koNti5L0MYxI+vpvHDHfEoFP8towZv8=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-112-f1SmNKZwP9uG7AuN7RjfVA-1; Tue, 24 Nov 2020 09:45:11 -0500
X-MC-Unique: f1SmNKZwP9uG7AuN7RjfVA-1
Received: by mail-ed1-f70.google.com with SMTP id l24so7997445edt.16
        for <linux-wireless@vger.kernel.org>; Tue, 24 Nov 2020 06:45:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=EZ/jeYBlyZkL5pjYnppCWoaG2cKZhox2o7qCEtKhG0I=;
        b=G5OemJ5ZyXEqu8ZF3AfujM6X/S7+RNNHkfBYEfHUHXCmjYh2RaNIe9ngFvSxjVn+kw
         SuPkAzQOHJdMRxIxjR7t4Ex+z0sGCIDjsqbqdAQCItriCrfkn9+oB+cD4MU7Bv1lVfel
         Wsdtah+ApXcDeafnO4Uh2to+Hm2KfXa2/iqMAJUiJCiMX3G2MT8QmooxfVBQvVSpry47
         IiBIcacEMF2c92l6NcIX4QyNXIEehh2QCzRkyytLNbYyef8V5c9NHV1bOd5WiuR+rHVJ
         Fe5aKCx6NMZ5XacFkxQTEzTEE3LwIsYRSQrDyzB/3y7amJPNqpK569wW4S3VFdchclO9
         VjCQ==
X-Gm-Message-State: AOAM530JNZzf84qLtnq8881xJKNH9IFB7G5x9DSBy0vQEJgoddUZkKzw
        r5frnFtoZAc2Hy/pUVNq2BVOilIW17HM9rtRjEkdgzhjwyV8dmA57eqF4epsJm4K0SisHkaJEVh
        wzWCkv4tftbOtmIHdMoMBkgEf6kE=
X-Received: by 2002:a17:906:7813:: with SMTP id u19mr4404881ejm.153.1606229109466;
        Tue, 24 Nov 2020 06:45:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzyEs2sazzmjTn/Q0JkyTkay8/sglK+7l6a0MpfUxY6e5qqLPIuJFgeIP9l/26rRYDuuzToiA==
X-Received: by 2002:a17:906:7813:: with SMTP id u19mr4404853ejm.153.1606229109179;
        Tue, 24 Nov 2020 06:45:09 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id v16sm6934709ejx.57.2020.11.24.06.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 06:45:08 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id B48D3183065; Tue, 24 Nov 2020 15:45:07 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Zefir Kurtisi <zefku@westermo.com>, linux-wireless@vger.kernel.org
Cc:     Felix Fietkau <nbd@nbd.name>, qca-developer-program@qualcomm.com
Subject: Re: [RFT] ath9k: multi-rate-retry fails at HW level
In-Reply-To: <2a8573d7-6683-3414-a8af-dab460772205@westermo.com>
References: <2a8573d7-6683-3414-a8af-dab460772205@westermo.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 24 Nov 2020 15:45:07 +0100
Message-ID: <878saqlsp8.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Zefir Kurtisi <zefku@westermo.com> writes:

> Hi,
>
> I am running into a strange issue with the ath9k operating a 9590
> device which to me seems like a HW issue, but since work on rate
> controllers is already going for decades, I hardly can imagine this
> never showed up.
>
> The issue observed is this: the TX status descriptors never report
> rateindex 1, it is always 0, 2, or 3, but never 1.
>
> I noticed this by overwriting the rate configuration provided by
> minstrel to a static setup, e.g. (7,3)(5,3)(3,3)(1,3), all MCS. The
> device operates as iperf client to a connected AP and continuously
> transmits data. While at that, the attenuation between the endpoints
> is gradually increased, expecting to see a gradual shift in the
> reported TX status rateindex from 0 to 3. But nada, the values
> reported are 0,2, and 3 - never 1.
>
> I double checked that the TX descriptors are correctly set with the
> rates and retry counts - all looking sane.
>
> More obvious, after changing the rate configuration to
> (7,3)(1,3)(5,3)(3,3) the expectation would be to have either 0 or 1
> reported as rateidx, since the transmission ought to be successful
> with the lowest rate or never. Again all rates are reported but 1.
>
> Now the question for me is: what is the HW exactly doing with such a
> configuration? Is it skipping the second rate, or is it just reporting
> wrong?

You should be able to see this by looking at the rates the frames are
being sent at, shouldn't you?

> Both possibilities have great impact, since upper layers (like
> airtime) use the returned rateidx to calculate and configure operating
> parameters at runtime.

Have you actually observed any issues from this? If it's just skipping a
rate, minstrel should still be able to make decisions based on the
actual values returned, no?

> If this is a know issue, nevermind and thanks for pointing me to it. Otherwise if
> some of you have the named device operational, it would help a lot to get the
> issue confirmed. Just apply the attached patch and perform some TX testing in
> either attenuation adjustable or varying link condition setups. Whenever a frame
> is reported to have been transmitted at a rateidx > 0, the collected stats are
> logged, e.g.
> MRR: 2: [51029, 0, 4741, 6454]
>
> In essence, the failure is confirmed if the counter for 1 is 0 or very low
> compared to higher numbers for 0, 2, or 3.

Tried your patch and couldn't reproduce. Not the same hardware, though.
Mine is:

01:00.0 Network controller: Qualcomm Atheros AR9287 Wireless Network Adapter (PCI-Express) (rev 01)

-Toke

