Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E03F36A42C8
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Feb 2023 14:34:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbjB0Ne3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 27 Feb 2023 08:34:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbjB0NeO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 27 Feb 2023 08:34:14 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7FA020698
        for <linux-wireless@vger.kernel.org>; Mon, 27 Feb 2023 05:33:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677504801;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f/FzhhKEtTgugR/y3mXLSjzn0vLNSjQZIOnSkH/KjvI=;
        b=LDsDQtMi1GDC6lhV/AnF3u4po7k91BxDdLVz1KVMHJGPmaKA27E3OWPX9wJiWVTKrWPNoo
        3tfpW/WyTQkxPd5KRG/Xvkfn/lLYb+744bheVNaJ9ufchS9FhflTidL0DhA8S/LDU6cohA
        qX9hyubgZCbjyIckaaIh4wm+jlaNTOI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-411-PpcjKsFtNBKswWRokPBbPA-1; Mon, 27 Feb 2023 08:33:17 -0500
X-MC-Unique: PpcjKsFtNBKswWRokPBbPA-1
Received: by mail-wm1-f69.google.com with SMTP id m28-20020a05600c3b1c00b003e7d4662b83so5372515wms.0
        for <linux-wireless@vger.kernel.org>; Mon, 27 Feb 2023 05:33:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f/FzhhKEtTgugR/y3mXLSjzn0vLNSjQZIOnSkH/KjvI=;
        b=332sMYoO7su6GDFgDO2lVVlTaSLBBQWaCLbou5rXXawR4daf9GnxR9fepGueuddzE3
         t7onID7akguuD/hOrxHZAx30WLe8iP7TmtDkk04/siNp8LdjmEkHJis1KKf6/kPDKPXo
         O0Dx5/HSwEKzOgl1FLxL21dYfC2PnENX/o9JrFgZoatodSFkrgAH7zD4JR9R42xyRGzJ
         1+LOXNcb0LH31N86Wmu1vLpw8q4zkAZQm99LVHb/0w5EXqRsf1KuWO5FJn4jxxMkz1j1
         7JLGhDlQJy2jpK2lgRyr6dclZ8d/3eZkCacm0GXQE5oe9nB0bmP3WvxuLGSVAiqM2gqF
         RodQ==
X-Gm-Message-State: AO0yUKW7LxA0H5pteIkEG0lxEou/L3Masrn5eJEbjchXwDq5yqivTkH/
        OTcsxF/9DdoRBeQDNxafjBEiUpsLNC/9HJqXSKqnY+AiOlgXUD7cDHprigOetOGlDm/zfaNl+33
        41kIHDSBYNFVUrtm3Nu8UmtuMuDU=
X-Received: by 2002:a5d:4a01:0:b0:2c5:530d:4045 with SMTP id m1-20020a5d4a01000000b002c5530d4045mr22440794wrq.20.1677504796251;
        Mon, 27 Feb 2023 05:33:16 -0800 (PST)
X-Google-Smtp-Source: AK7set/Yz/Rv4CK4NnI11VoX+Rldy1Xt3bEfcajvfM5UFjwwMM3KQIUevlYVIj9yyeSBZmQssT/Hiw==
X-Received: by 2002:a5d:4a01:0:b0:2c5:530d:4045 with SMTP id m1-20020a5d4a01000000b002c5530d4045mr22440777wrq.20.1677504795917;
        Mon, 27 Feb 2023 05:33:15 -0800 (PST)
Received: from localhost (net-188-216-77-84.cust.vodafonedsl.it. [188.216.77.84])
        by smtp.gmail.com with ESMTPSA id p1-20020a056000018100b002c54fb024b2sm7198843wrx.61.2023.02.27.05.33.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 05:33:14 -0800 (PST)
Date:   Mon, 27 Feb 2023 14:33:12 +0100
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     Kang Chen <void0red@gmail.com>
Cc:     shayne.chen@mediatek.com, sean.wang@mediatek.com, kvalo@kernel.org,
        nbd@nbd.name, lorenzo@kernel.org, ryder.lee@mediatek.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] wifi: mt76: add a check of vzalloc in
 mt7615_coredump_work
Message-ID: <Y/yxGMvBbMGiehC6@lore-desk>
References: <20230227115717.3360755-1-void0red@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ifWNKEdM2/arQ3c2"
Content-Disposition: inline
In-Reply-To: <20230227115717.3360755-1-void0red@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--ifWNKEdM2/arQ3c2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> vzalloc may fails, dump might be null and will cause
> illegal address access later.

can you please add a Fixes tag?

Regards,
Lorenzo

>=20
> Signed-off-by: Kang Chen <void0red@gmail.com>
> ---
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

--ifWNKEdM2/arQ3c2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCY/yxGAAKCRA6cBh0uS2t
rLjcAP0QtrGC6pC4wqyPa3TdGMOKu6ih0Dlbdf4hC0hL6+BYTAEAxEIcRy+wsaR6
kT/4qA1YwxG1EmeDzGEy+PPTPp/NZAA=
=x8oL
-----END PGP SIGNATURE-----

--ifWNKEdM2/arQ3c2--

