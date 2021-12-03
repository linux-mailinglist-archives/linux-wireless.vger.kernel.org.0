Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1411B467C86
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Dec 2021 18:28:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353392AbhLCRbW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 3 Dec 2021 12:31:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29646 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245736AbhLCRbW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 3 Dec 2021 12:31:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638552477;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pjpVqfL0j9h8hFQ9g8tUuSN/8IcQIhyatEuo1e1FnXU=;
        b=JdZ77g69xsoVnUbuzExYyLwBxn64v9I9kBaTCC5IxwGyCTD+qv2vidLrrSCL2I/xVEECXJ
        1BMsuZETabD6UVLuxX3/EGPwWF7uPQZ2NEq07OY+O1vA6paXRgSlrHAfdlA1HBPJvocuX7
        kmUDKblc5qgECEe4gwCewiP7/ClT6ks=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-426-yoCgOO92NzGCfgrtmEf9EQ-1; Fri, 03 Dec 2021 12:27:56 -0500
X-MC-Unique: yoCgOO92NzGCfgrtmEf9EQ-1
Received: by mail-ed1-f69.google.com with SMTP id 30-20020a508e5e000000b003f02e458b17so3122419edx.17
        for <linux-wireless@vger.kernel.org>; Fri, 03 Dec 2021 09:27:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pjpVqfL0j9h8hFQ9g8tUuSN/8IcQIhyatEuo1e1FnXU=;
        b=fV1CmynP2JyXDD/pvPNZedmMJnWS4P61WMdfICPcE5pVaU8qntBBlKWjqjluAVeAMX
         ZjmxnbMP7xgkniZqXa9uUcQzDe/sVuhL1V+J6L84sNvUdsX9Ca8VXTW7CC1yVkUA8lcB
         wVnTeqeoDSv24fVT2OD5Uu3noZ0arhR/0MfHQz3id94gJPlqbz10dU9M0/FbcCuG9tA2
         9ODzIOBXngLZJM0yj+WW6w3Y7IvrDippmsxTkOM3E9pCTK0xZ3Odf4InhplLUDo7e286
         IHqJf0OO9VgztK5LX8BqEj7bVDL8r3TzU7FUBwXAD++GChUZl/9NinX6P1sHHiiXy9cy
         LUow==
X-Gm-Message-State: AOAM532e5sITYT/ytbwdn0nq7OKDBQSDA+F11Pza5VIUKqtOJDC1MWSu
        5m2z3P6527vXEuVNHyofJJojojS4Ps1o3nXhdo3lyI4YFBygcesrCCKb21dcKxQ33TFEq6ZA6ER
        2XDJJXc4p8YvS6xAIVgdol2UxWWQ=
X-Received: by 2002:a17:907:7805:: with SMTP id la5mr25244936ejc.188.1638552475017;
        Fri, 03 Dec 2021 09:27:55 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxzFoi4V1Y38uYwgXtOPfnQ5k5olvJt1hjcEEyiD5yXDa1bvSIH6+nbTGmE+8NMBdSK/Bg3ng==
X-Received: by 2002:a17:907:7805:: with SMTP id la5mr25244917ejc.188.1638552474834;
        Fri, 03 Dec 2021 09:27:54 -0800 (PST)
Received: from localhost (net-37-182-17-175.cust.vodafonedsl.it. [37.182.17.175])
        by smtp.gmail.com with ESMTPSA id a3sm2445752ejd.16.2021.12.03.09.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 09:27:54 -0800 (PST)
Date:   Fri, 3 Dec 2021 18:27:52 +0100
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     sean.wang@mediatek.com
Cc:     nbd@nbd.name, sven@narfation.org, jf@simonwunderlich.de,
        linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: mt76: MT7921K monitor mode not working
Message-ID: <YapTmM3EztojTS9F@lore-desk>
References: <YapBMGjLcjuBo/vw@lore-desk--annotate>
 <1638551402-3864-1-git-send-email-sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2d1Hv3ATuhUm5puw"
Content-Disposition: inline
In-Reply-To: <1638551402-3864-1-git-send-email-sean.wang@mediatek.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--2d1Hv3ATuhUm5puw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: Sean Wang <sean.wang@mediatek.com>
>=20
> >> On Thursday, 2 December 2021 23:13:31 CET Lorenzo Bianconi wrote:
> >> > IIRC you need to disable runtime-pm and deep-sleep to proper enable
> >> > monitor
> >> > mode:
> >> >
> >> > echo 0 > /sys/kernel/debug/ieee80211/phy<x>/mt76/runtime-pm
> >> > echo 0 > /sys/kernel/debug/ieee80211/phy<x>/mt76/deep-sleep
> >> >
> >> > Can you please give it whirl?
> >>
> >> Jan gave me the card. I've set it to a rather busy channel (2.4GHz
> >> channel 11), created a monitor interface, attached tcpdump and then
> >> waited what happens. I didn't get anything and then I've tried to set
> >> runtime-pm and deep- sleep to 0. This didn't change the behavior for
> >> me at lot. I saw two packets and then it went silent again.
> >>
> >> I wanted to try the same on a different card (ath11k) in the same
> >> system. But it crashed my complete system - so I had to recreate the
> >> test setup. This time, I've set runtime-pm + deep-sleep to 0 before
> >> creating mon0. After doing this, it seemed to work.
> >
> >interesting, adding Sean to the loop here.
> >It seems the fw is mainting a different state in this case.
>=20
> fw cannot receive any frame on monitor mode in deeply doze mode
>=20
> so it seemed to me we need a patch to explicitly disable pm runtime in dr=
iver when monitor interface is enabled until it is being disabled.

ack, I agree, but I guess the point here is what is the difference (from th=
e fw pov) if you disable
runtime-pm/deep-sleep before/after the vif is added. I guess it is supposed=
 to
be the same, right?

Regards,
Lorenzo

>=20
> >
> >@Sean: any pointers?
> >
> >Regards,
> >Lorenzo
> >
> >>
> >> Kind regards,
> >>	Sven
> >
>=20

--2d1Hv3ATuhUm5puw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYapTmAAKCRA6cBh0uS2t
rCiaAQDynMHJ4nmPLYaB2HHROmr2j3LJ0hZZVGq8xkq2pxcJSgD/bA94FR3SBt35
vdNr/NkAQiEihVIh5n00nvpWgMypBQA=
=YHOk
-----END PGP SIGNATURE-----

--2d1Hv3ATuhUm5puw--

