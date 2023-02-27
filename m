Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48B256A43B8
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Feb 2023 15:08:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbjB0OIA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 27 Feb 2023 09:08:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbjB0OH7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 27 Feb 2023 09:07:59 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 090E71F929
        for <linux-wireless@vger.kernel.org>; Mon, 27 Feb 2023 06:07:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677506830;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aFTvFQ3q5aWSqvyw9AelhhhkIt6I0O9TBRHfypnLJlQ=;
        b=T/k+nWsOpKO/V0f+Twyi0rSYEx910o9swI0pRzjF/etN/KrEfatZuzyFQHh8iMqHAX73H6
        nKK7Bvz2A1WAminH8rzc1MURCluqRXdv/h6CwsYQY5jkYWkCCpqS82O7HZFInRr9Vh9b9v
        YNQjg2uuqhvPSOYwbEXj6h1rVdWtHmI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-149-XdcIR6BwMMWb_vZQMZWaQQ-1; Mon, 27 Feb 2023 09:07:06 -0500
X-MC-Unique: XdcIR6BwMMWb_vZQMZWaQQ-1
Received: by mail-wm1-f69.google.com with SMTP id l23-20020a7bc457000000b003e206cbce8dso2421313wmi.7
        for <linux-wireless@vger.kernel.org>; Mon, 27 Feb 2023 06:07:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aFTvFQ3q5aWSqvyw9AelhhhkIt6I0O9TBRHfypnLJlQ=;
        b=aKdYmoqE49fyZ1MrojCr+GBRCjzeXn6dzi1FocFiHNe6vBABa1Icxwph+sCki8ooko
         1ZdiTsE5ETDbwTRjQB5Bndq/cCevtmC5BBru53d9sglAuqjzYeDcvcJKZUb3SxaUv0WQ
         4kFBW/PPkK6jyPoucjxM8pSMISnwUafQnEvycC1X6MYT2mT62QNG2oHJ6b0ZPMQc3M/B
         WtAEJrwTmB9bAHl9Jdwzk506FYkWn5fQt9UGxUhGDz/OSQJdAh2tOJWC3pgWV4j8Yo5T
         gCGAVT/i7oWY+W/JW4IgdswmIqqfkgrL2utUeXx/U7nsnG1xTVa/H8OWrNgpAEjrjawC
         nQ0A==
X-Gm-Message-State: AO0yUKW6zlvXGZ/nmg373R+0+U1ur7Z+2MD09H/3g/3yj7bQ4Zf4x8sH
        3JpXAlKiXA7Wxi5us7qXVKGSebn1ATnLstJG+M2MjstcQy+Ti7b/Z+zKWaUcSK1HHR6q9+jslL3
        Vavej1Gh/d4LmlUc/basuWDa0Pv0=
X-Received: by 2002:a5d:4f89:0:b0:2c7:1d70:561 with SMTP id d9-20020a5d4f89000000b002c71d700561mr9516584wru.45.1677506821180;
        Mon, 27 Feb 2023 06:07:01 -0800 (PST)
X-Google-Smtp-Source: AK7set9ec/Yueab8Bvk6eJi8LCRz4+aeuNEBluM/tCSwA288dNuu0Nq41jbKDNy7uFxhcbonKrPSew==
X-Received: by 2002:a5d:4f89:0:b0:2c7:1d70:561 with SMTP id d9-20020a5d4f89000000b002c71d700561mr9516553wru.45.1677506820885;
        Mon, 27 Feb 2023 06:07:00 -0800 (PST)
Received: from localhost (net-188-216-77-84.cust.vodafonedsl.it. [188.216.77.84])
        by smtp.gmail.com with ESMTPSA id g9-20020a056000118900b002c794495f6fsm6993704wrx.117.2023.02.27.06.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 06:07:00 -0800 (PST)
Date:   Mon, 27 Feb 2023 15:06:58 +0100
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     void0red <void0red@gmail.com>
Cc:     angelogioacchino.delregno@collabora.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, kvalo@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-wireless@vger.kernel.org,
        lorenzo@kernel.org, matthias.bgg@gmail.com, nbd@nbd.name,
        netdev@vger.kernel.org, pabeni@redhat.com, ryder.lee@mediatek.com,
        sean.wang@mediatek.com, shayne.chen@mediatek.com
Subject: Re: [PATCH v2] wifi: mt76: add a check of vzalloc in
 mt7615_coredump_work
Message-ID: <Y/y5Asxw3T3m4jCw@lore-desk>
References: <Y/yxGMvBbMGiehC6@lore-desk>
 <20230227135241.947052-1-void0red@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="suqa0cLxZu8I2O6i"
Content-Disposition: inline
In-Reply-To: <20230227135241.947052-1-void0red@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--suqa0cLxZu8I2O6i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: Kang Chen <void0red@gmail.com>
>=20
> vzalloc may fails, dump might be null and will cause
> illegal address access later.
>=20
> Fixes: d2bf7959d9c0 ("mt76: mt7663: introduce coredump support")
> Signed-off-by: Kang Chen <void0red@gmail.com>
> ---
> v2 -> v1: add Fixes tag
>=20
>  drivers/net/wireless/mediatek/mt76/mt7615/mac.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7615/mac.c
> index a95602473..73d84c301 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
> @@ -2367,6 +2367,9 @@ void mt7615_coredump_work(struct work_struct *work)
>  	}
> =20
>  	dump =3D vzalloc(MT76_CONNAC_COREDUMP_SZ);
> +	if (!dump)
> +		return;
> +
>  	data =3D dump;
> =20
>  	while (true) {
> --=20
> 2.34.1
>=20

revieweing the code I guess the right approach would be the one used in
mt7921_coredump_work():
- free pending skbs
- not run dev_coredumpv()

What do you think?

Regards,
Lorenzo

--suqa0cLxZu8I2O6i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCY/y5AgAKCRA6cBh0uS2t
rNvNAQChxct9I9hvxziffNgrIyEvdXvuQxbOt0yeiX8oblnPWwEA4qXx39acNsg6
Q0MSG7S8eufwOP2IXUXhOgXTb9tFZQw=
=ErB1
-----END PGP SIGNATURE-----

--suqa0cLxZu8I2O6i--

