Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74B4E48CA84
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jan 2022 19:00:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355860AbiALSAF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Jan 2022 13:00:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:40300 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1355856AbiALSAE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Jan 2022 13:00:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642010404;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pEptlI5akvEi6pWcIuSbohMlWFpnQbMFTJDYOQOJcWA=;
        b=eweQfaDQPk5T+mM/whIvc8MXPPP2miLsGMoCxQhN8yg3xIqub0hf6XCwjAJfrhhErn3c7S
        TRSqNXVRx7/RlLr0u8yofB9HGuesPT7nDdtBDSnKRjQCNXQoN3wywaczzVkNN9B0NG/M7F
        DEXBuol76s4/6Ng7P0jfgPPYiNqLqPo=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-26-aKOO3lHsOk67lciVESnIWg-1; Wed, 12 Jan 2022 13:00:00 -0500
X-MC-Unique: aKOO3lHsOk67lciVESnIWg-1
Received: by mail-qt1-f200.google.com with SMTP id g9-20020ac842c9000000b002c7f117c948so1381392qtm.7
        for <linux-wireless@vger.kernel.org>; Wed, 12 Jan 2022 10:00:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pEptlI5akvEi6pWcIuSbohMlWFpnQbMFTJDYOQOJcWA=;
        b=04Dqew1vIgqDYMOBfNtHG9PdFdBWMsSiKo5K5bSFrjJLNkNEHdzW5v9EmGgIzLAGiQ
         990YI2mBfgZrGjTfTTIKDvhcJWVukQ/8eqccrQKZ3iuCYPV0TZItJWbzUPkJfV+jaJ5c
         HB2wXe6uYGvGrf1OrIFehDyAzal0zWeJ2pxTS35oPOHFDqh2sHjXoByk7CsudrurQscR
         pppSZ4wWWSW3S7sAxYKinEsgzPGGhZsLHK4XVqgOq2QUZTwvHjE0ANyHrU4H2zXjY9zO
         7GbIqsrtp5p2cMrJYR6MSQKGJWe7J7wMle9fjADz7/hCWO4o2Hgh6MSN+9Bj9lrBvAwX
         0xIA==
X-Gm-Message-State: AOAM532FNOT3fKCq9Phpo7fHGn+fRx8qO3SXF3HvovZ6Tqe3wZLxaOZV
        BMPx9/JUIXKAJdQmE/3KI+icsxX2uDH/oMtb7eb+p1stac+49L3us4mpDuiebZr5qC5kRZEGNjh
        jfAF45wd2TnH5ovP33romD5zUtK8=
X-Received: by 2002:a05:622a:3cf:: with SMTP id k15mr597350qtx.272.1642010400300;
        Wed, 12 Jan 2022 10:00:00 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwQBGTdrQXxArGr5p3XeAsoeIo3BayYJiCf8dTC8GaOhfVWk7kvK/kuco9fH+RuSWLMc5jOTA==
X-Received: by 2002:a05:622a:3cf:: with SMTP id k15mr597337qtx.272.1642010400083;
        Wed, 12 Jan 2022 10:00:00 -0800 (PST)
Received: from localhost (net-93-146-37-237.cust.vodafonedsl.it. [93.146.37.237])
        by smtp.gmail.com with ESMTPSA id d17sm331123qtb.71.2022.01.12.09.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 09:59:59 -0800 (PST)
Date:   Wed, 12 Jan 2022 18:59:56 +0100
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Felix Fietkau <nbd@nbd.name>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>, owen.peng@mediatek.com,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 0/6] introduce background radar support for mt7915 driver
Message-ID: <Yd8XHCHaBJGxYq+g@lore-desk>
References: <cover.1641996493.git.lorenzo@kernel.org>
 <Yd7jdaKTrTFDU36g@lore-desk>
 <CAL_JsqLzJCi+7ziZ6H=oBoQhi_onMXk7Hb9ry-Gv17S0_gYvwQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rzTC0dn+5h0fM9tq"
Content-Disposition: inline
In-Reply-To: <CAL_JsqLzJCi+7ziZ6H=oBoQhi_onMXk7Hb9ry-Gv17S0_gYvwQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--rzTC0dn+5h0fM9tq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Wed, Jan 12, 2022 at 8:19 AM Lorenzo Bianconi
> <lorenzo.bianconi@redhat.com> wrote:
> >
> > > Introduce radar/CAC background detection support for mt7915 driver
> > > Background radar/CAC detection allows to avoid the CAC downtime
> > > switching on a different channel during CAC detection on the selected
> > > radar channel.
> >
> > @Rob: I forgot to add devicetree ML in cc. Do I need to repost?
>=20
> Yes, that's the only way patchwork picks up patches and checks run.
>=20
> Rob
>=20

ack, posted v2.

Regards,
Lorenzo

--rzTC0dn+5h0fM9tq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYd8XHAAKCRA6cBh0uS2t
rHMnAP9ly482DLSNr2TVK3rdVQyQwe7Mn0Vi30+mg/JdpgywtQD/W55pFE6dT+de
1XsbcaDaHyeh4Ivq1krXcvON29TY5gI=
=VaN/
-----END PGP SIGNATURE-----

--rzTC0dn+5h0fM9tq--

