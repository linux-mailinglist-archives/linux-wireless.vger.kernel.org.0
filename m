Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E82F109AF1
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Nov 2019 10:16:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727578AbfKZJQR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 26 Nov 2019 04:16:17 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45667 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727483AbfKZJQR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 26 Nov 2019 04:16:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574759775;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vb+oxQxZRkNlkuBEQUYVCl/O5AvuVY4nZz95WVzmQq8=;
        b=KPJacqge+BMAzmRYMzQQJftxDejx2BuTj31hl/rlzH5+X5s2pSvlL2dhZDfIihiWK9Fd9d
        TrSvHqn6W5mk6j9kC9bcAXwK7SfhLeLSoh0NOTrI6FZMWNWuVTsKFdDS8SrMI3+7tez1Zl
        YpG7dkiYU4WuEaLF4PfzjXPGEisdOz8=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-348-1m40VoXRMT-kk4noMGX22g-1; Tue, 26 Nov 2019 04:16:14 -0500
Received: by mail-lf1-f71.google.com with SMTP id x23so3745772lfc.5
        for <linux-wireless@vger.kernel.org>; Tue, 26 Nov 2019 01:16:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=+GixzF/KaQHv0D6//vs+c5ZE/FXLP7KWC/hh8q0IT38=;
        b=j6HV/1GEbrpfydmtK5ZFDXgbJVRg/qSMwpqugHP+vMIKrN3t8lI5JI1IG5rt1Ri9Cc
         2qRfOqwbp4QQYe7MDmVaRkcOV112zQvaQ9aIDUK4yoelTqlrUnSMJe54aghyXmm7C36h
         LgDgla8Iwzojao/wceXUti8NDlnO8cAZOXj3YnstKfTNJMFYSlHJKaOBRKsReLWMZZUw
         XIBIYUOWvAURRL1BoR9JJ+lcWJqwgX4px2/wVdTyWikJmRK9FoYPcxNbjttZQgPYJC1V
         Sd0+NeWjs/soJeT4C08Nzg1boweISTgDn6l4TPaNi3JkexNbGmx5NGBjcYh8u+88oE4Z
         g4qQ==
X-Gm-Message-State: APjAAAUCWN7AQyXplItnkTWTIV5pxkyCxp6b2e9IARTLztFr6loSj/fm
        QKJKhgrLj0s7Sf4o1diNJlgixmUjiVbRMFytFsQ29QdFI3I+0WMTZKP265SSKd2sf32m1Y/5SDL
        7/LuydgZceGLm/uwpTXKYj5weFn4=
X-Received: by 2002:a19:f811:: with SMTP id a17mr23461977lff.132.1574759772744;
        Tue, 26 Nov 2019 01:16:12 -0800 (PST)
X-Google-Smtp-Source: APXvYqxi4cxslTGXaPEgklZisShtCL52V7ndFFVsbgvulKaJ2kiSJRyrQs7o0m+akem1uQZYddlS3g==
X-Received: by 2002:a19:f811:: with SMTP id a17mr23461957lff.132.1574759772531;
        Tue, 26 Nov 2019 01:16:12 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id s27sm4937135lfc.31.2019.11.26.01.16.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2019 01:16:11 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id DC18D1818BF; Tue, 26 Nov 2019 10:16:10 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Roy Luo <royluo@google.com>, Kalle Valo <kvalo@codeaurora.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] mt76: Off by one in mt76_calc_rx_airtime()
In-Reply-To: <20191126091150.GA1759@kadam>
References: <20191121213935.2cbgh3qmd4hv4v5a@kili.mountain> <87v9r7ysg0.fsf@toke.dk> <20191126091150.GA1759@kadam>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 26 Nov 2019 10:16:10 +0100
Message-ID: <87h82ryp45.fsf@toke.dk>
MIME-Version: 1.0
X-MC-Unique: 1m40VoXRMT-kk4noMGX22g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dan Carpenter <dan.carpenter@oracle.com> writes:

> On Tue, Nov 26, 2019 at 09:04:15AM +0100, Toke H=C3=B8iland-J=C3=B8rgense=
n wrote:
>> Dan Carpenter <dan.carpenter@oracle.com> writes:
>>=20
>> > The sband->bitrates[] array has "sband->n_bitrates" elements so this
>> > check needs to be >=3D instead of > or we could read beyond the end of=
 the
>> > array.
>> >
>> > These values come from when we call mt76_register_device():
>> >
>> > =09ret =3D mt76_register_device(&dev->mt76, true, mt7603_rates,
>> > =09=09=09=09   ARRAY_SIZE(mt7603_rates));
>> >
>> > Here sband->bitrates[] is mt7603_rates[] and ->n_bitrates is the
>> > ARRAY_SIZE()
>> >
>> > Fixes: 5ce09c1a7907 ("mt76: track rx airtime for airtime fairness and =
survey")
>> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>> > ---
>> >  drivers/net/wireless/mediatek/mt76/airtime.c | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > diff --git a/drivers/net/wireless/mediatek/mt76/airtime.c b/drivers/ne=
t/wireless/mediatek/mt76/airtime.c
>> > index 55116f395f9a..a4a785467748 100644
>> > --- a/drivers/net/wireless/mediatek/mt76/airtime.c
>> > +++ b/drivers/net/wireless/mediatek/mt76/airtime.c
>> > @@ -242,7 +242,7 @@ u32 mt76_calc_rx_airtime(struct mt76_dev *dev, str=
uct mt76_rx_status *status,
>> >  =09=09=09return 0;
>> > =20
>> >  =09=09sband =3D dev->hw->wiphy->bands[status->band];
>> > -=09=09if (!sband || status->rate_idx > sband->n_bitrates)
>> > +=09=09if (!sband || status->rate_idx >=3D sband->n_bitrates)
>> >  =09=09=09return 0;
>> > =20
>> >  =09=09rate =3D &sband->bitrates[status->rate_idx];
>>=20
>> This code has recently been ported to mac80211 (net/mac80211/airtime.c).
>> It seems that the bug is also present there; care to send a patch for
>> that as well? :)
>
> Oh.  Thanks for pointing that out.  I actually saw the static checker
> warning for that and ignored it thinking that it was the same code.
> :P

Well, it's copy-pasted from the same code ;)

The plan is to get rid of the version inside mt76; was waiting for the
trees to converge, though, so I guess after the merge window?

> I will send a fix for it.

Great, thanks!

-Toke

