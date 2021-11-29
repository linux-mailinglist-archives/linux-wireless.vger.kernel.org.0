Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81D5E461696
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Nov 2021 14:35:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343504AbhK2NiX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Nov 2021 08:38:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:27662 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1377732AbhK2NgS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Nov 2021 08:36:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638192780;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cJMx36hpuC8venvJ4ex2axV7qDK8Q88x2lTV2gAMz6k=;
        b=OfkPqlvdYJtZVcHVBaxUah26v6isY24NTOz86GI1UpC1YlaCq4zo7KzJehk1RYSR8yeXV3
        By8KHGy4OPwZBQq5ZI2ZrBCMAxPiZpIGqNWIw0umaWKAZ7uIkeFIFef14wGF0+lHbiWwv9
        z9h+r2j2sZeEVV0D05x3elkAdYbTQSE=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-429-_PrYFQmoMNiJ0SyWeVFqGA-1; Mon, 29 Nov 2021 08:32:58 -0500
X-MC-Unique: _PrYFQmoMNiJ0SyWeVFqGA-1
Received: by mail-ed1-f69.google.com with SMTP id a3-20020a05640213c300b003e7d12bb925so13786858edx.9
        for <linux-wireless@vger.kernel.org>; Mon, 29 Nov 2021 05:32:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cJMx36hpuC8venvJ4ex2axV7qDK8Q88x2lTV2gAMz6k=;
        b=j5ziJrk9oQmjXjMCR/nXYPoulbw/L2wT3G9YdDBjMbpZPz4PfwKE67f5LB7ZOGB8/y
         N7vQ8edDhmj6Ye/Bbj5Wt84xnS+I2ffEFYXFA5H2GlcM09m0Q74A7JUr3UEnoci4RiAu
         HUETXECn1bQvOCw2kvyNCTww6qXpvOnnr9kgOuUpiocXn3v4wvYFF5yjf58ieBVEuzF5
         LgAj6sSR415HHOZADt3dkZCM7+Gmo4irMj64JqY/qFpE+/AHWnY3DNc1m6QAVwA8ex6b
         SsZhCrnFE2UJCdqVQ2NbsWggMCXjmNtf6tGVtw8RiYZce+tjsXLMM7x0VX0Zrof/0W8/
         PKiQ==
X-Gm-Message-State: AOAM530vHyEoACsQrpdpqi4WgzVE4rRID/3ij0+s4zGLVQ0ESCOfDENS
        tGNGENsRqWXJBUksWgqzWQh8rHaUx/hNhefQOjTjDpRYfpP/f134HJXM2k2RNGr/Vm/y7RzxE0X
        KLnbddTAnR2G8fYEklpOS5jEsuWo=
X-Received: by 2002:a05:6402:11d2:: with SMTP id j18mr74999591edw.318.1638192777520;
        Mon, 29 Nov 2021 05:32:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxyGfILfLfkBUtV1feZBrWtakKaA1x2PQ1Q0eRA5mFdvbT4avY16MXcnhloTRwJqflNG7E9EQ==
X-Received: by 2002:a05:6402:11d2:: with SMTP id j18mr74999565edw.318.1638192777353;
        Mon, 29 Nov 2021 05:32:57 -0800 (PST)
Received: from localhost (net-93-151-197-210.cust.vodafonedsl.it. [93.151.197.210])
        by smtp.gmail.com with ESMTPSA id gt18sm7423034ejc.88.2021.11.29.05.32.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 05:32:56 -0800 (PST)
Date:   Mon, 29 Nov 2021 14:32:54 +0100
From:   lorenzo bianconi <lorenzo.bianconi@redhat.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>, sean.wang@mediatek.com,
        nbd@nbd.name, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com
Subject: Re: [PATCH wireless-drivers] mt76: fix possible pktid leak
Message-ID: <YaTWhgzLaOvr6PjB@lore-desk>
References: <a560caffcc24452fb48af53904bbe5c45ea5db93.1637602268.git.lorenzo@kernel.org>
 <163777451567.4686.3609119971518562275.kvalo@codeaurora.org>
 <YaDo21+/MBeeuTDN@lore-desk>
 <87fsrj3qxo.fsf@codeaurora.org>
 <YaD8lT5csiLvmBzS@lore-desk>
 <87sfvij4eh.fsf@codeaurora.org>
 <YaEJ6hQ0uC32+Mts@lore-desk>
 <YaJAUOkLoQ3mOjcQ@lore-desk>
 <874k7vgx8r.fsf@codeaurora.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="D8qjOYejXFUcOPkb"
Content-Disposition: inline
In-Reply-To: <874k7vgx8r.fsf@codeaurora.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--D8qjOYejXFUcOPkb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Lorenzo Bianconi <lorenzo@kernel.org> writes:
>=20
> >> > Lorenzo Bianconi <lorenzo@kernel.org> writes:
> >> >=20
> >> > >> Lorenzo Bianconi <lorenzo@kernel.org> writes:
> >> > >>=20
> >> > >> >> Lorenzo Bianconi <lorenzo@kernel.org> wrote:
> >> > >> >>=20
> >> > >> >> > Fix a possible idr pkt-id leak if the packet is dropped on t=
x side
> >> > >> >> >=20
> >> > >> >> > Fixes: bd1e3e7b693c ("mt76: introduce packet_id idr")
> >> > >> >> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> >> > >> >> > Acked-by: Felix Fietkau <nbd@nbd.name>
> >> > >> >>=20
> >> > >> >> Patch applied to wireless-drivers.git, thanks.
> >> > >> >>=20
> >> > >> >> 2a9e9857473b mt76: fix possible pktid leak
> >> > >> >
> >> > >> > Hi Kalle,
> >> > >> >
> >> > >> > Unfortunately I found a regression introduced by this patch
> >> > >> > for mt7663u (and I
> >> > >> > guess for mt7921s as well). Do you want me to post a fix or jus=
t a v2?
> >> > >>=20
> >> > >> I don't rebase my trees, so please post a fix. I was planning to =
submit
> >> > >> a pull request to net tree today, but is this so serious that I s=
hould
> >> > >> skip that?
> >> > >
> >> > > I have already tested mt7663u but I do not have mt7921s hw for tes=
ting (but the
> >> > > behaviour should be the same). I guess we can split the patch, jus=
t post the
> >> > > fix for mt7663u and let Sean the time to test it on mt7921s (I am =
not sure
> >> > > mt7921s is already available on the market). In this way you can s=
end the PR
> >> > > today. What do you think?
> >> >=20
> >> > I think it's best to wait, I prefer to have proper build testing on =
my
> >> > tree before I submit the pull request.
> >>=20
> >> ack, fine to me. Let's wait for Sean in this case.
> >
> > @Sean: if you want to test the code the patch is available here:
> > https://github.com/LorenzoBianconi/wireless-drivers/commit/1ffda36c7cbe=
3a6cfc31868895417d0cd6755306
>=20
> And if we can't find a quick fix let's just revert 2a9e9857473b. I can't
> wait too long.

ack, Deren verified the fix. I will post it now.

Regards,
Lorenzo

>=20
> --=20
> https://patchwork.kernel.org/project/linux-wireless/list/
>=20
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpa=
tches
>=20

--D8qjOYejXFUcOPkb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYaTWhgAKCRA6cBh0uS2t
rOSKAP9nqRN1ixJ6YG2t06EZ90Xm1xiSqz2Y+l3wB7DYpm4HfAEAsylhYX6Bg4VG
npzp6y3CK2F87mzDE7dfg2JkeQrBQg8=
=5+Hz
-----END PGP SIGNATURE-----

--D8qjOYejXFUcOPkb--

