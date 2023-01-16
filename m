Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1514166BDA3
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Jan 2023 13:18:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbjAPMSD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 16 Jan 2023 07:18:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbjAPMRs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 16 Jan 2023 07:17:48 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF2DA1CF6A
        for <linux-wireless@vger.kernel.org>; Mon, 16 Jan 2023 04:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673871425;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GJgwceiK7CKDfAJvNd6mq6RyJx2ljsjrq7HlURFazu8=;
        b=OmjHIXkNRwN2jWj9fJkGcymLnop8fFEQ4FAYz6Y17HflnBOwTdz2tyUks2jRcEtECtc3SM
        RGZenY3GY8rMawHtpPd125ix/VVpPf9ZNgt0zkWxbKlBGnQXhAykKAedW4bbMiEvesgKuP
        Jl6WQ69l8GsBs09Wizr3jazQf5ka+qo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-58-mg4US1InMpSdI-nSmoGQAg-1; Mon, 16 Jan 2023 07:17:04 -0500
X-MC-Unique: mg4US1InMpSdI-nSmoGQAg-1
Received: by mail-wm1-f71.google.com with SMTP id z22-20020a05600c0a1600b003db00dc4b69so573816wmp.5
        for <linux-wireless@vger.kernel.org>; Mon, 16 Jan 2023 04:17:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GJgwceiK7CKDfAJvNd6mq6RyJx2ljsjrq7HlURFazu8=;
        b=znN7jzh/xbt9UwhyAJO/OfOymOSK8Rn49kXbYVKPYSNxpV+J/618RTkB3cz6Hk4GXB
         LaeBbeeiNBd2VhW1qH8PCSscKZtzHMbc+FGLYt6rxD1x2VkXw72z4I/lDGEhxc33AzFW
         sSRwQYyLnYjVarTyIvCK75JMnzjzhzswCfdD81rRdiFp1TGk2cTRc7dTFq3vwqE9N7Tl
         WGeDCbMCw9ybzsvuj9NxgF0Kqz5LQIZpRmlXRhxLmI+ACLl395IuPXug7boDDzNYgqkU
         d+b2LG9qAuBRWAx43NSjRVy+NPefkNjJKx5nZ0sMAXGeT+TXV5uhouEckNF/sn2xjweZ
         pqgQ==
X-Gm-Message-State: AFqh2kro7rUD6ctS0OJjIFIiG758A1IaGxhi3re27WgDd56o8GGAGDD2
        VTqNCFJ+OKElMW71cKeA94v2Fx3YStWU5+uoKNoJ5ipY/PTRzhWEa67eaCxMs0+sY08aG1XJNSE
        hRlT63Wc7A7qvAyKWEK84Wff/Aw8=
X-Received: by 2002:a5d:5226:0:b0:2bd:e873:e20c with SMTP id i6-20020a5d5226000000b002bde873e20cmr7483082wra.70.1673871420789;
        Mon, 16 Jan 2023 04:17:00 -0800 (PST)
X-Google-Smtp-Source: AMrXdXseip94b/1Rv6G2SS4z6diEI6QXLkNOWxkrfsT0/jFCSBcm60ERKWrGyOyR+hS8jRLhPCBtAw==
X-Received: by 2002:a5d:5226:0:b0:2bd:e873:e20c with SMTP id i6-20020a5d5226000000b002bde873e20cmr7483066wra.70.1673871420545;
        Mon, 16 Jan 2023 04:17:00 -0800 (PST)
Received: from localhost (net-188-216-77-84.cust.vodafonedsl.it. [188.216.77.84])
        by smtp.gmail.com with ESMTPSA id e20-20020a5d5954000000b002be099f78c0sm1809780wri.69.2023.01.16.04.16.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 04:16:58 -0800 (PST)
Date:   Mon, 16 Jan 2023 13:16:56 +0100
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     nbd@nbd.name, linux-wireless@vger.kernel.org
Subject: Re: [PATCH] wifi: mt76: mt7915: fix memory leak in
 mt7915_rate_txpower_get
Message-ID: <Y8VAOJmo89bn0qo1@lore-desk>
References: <2ea534ec17856f65237939f3d437aad37ddc7753.1672740921.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="iu/RfxLzqMCsTZCq"
Content-Disposition: inline
In-Reply-To: <2ea534ec17856f65237939f3d437aad37ddc7753.1672740921.git.lorenzo@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--iu/RfxLzqMCsTZCq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Fix possible memory leak in mt7915_rate_txpower_get routine if
> mt7915_mcu_get_txpower_sku() fails.
>=20
> Fixes: e3296759f347 ("wifi: mt76: mt7915: enable per bandwidth power limi=
t support")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c b/driver=
s/net/wireless/mediatek/mt76/mt7915/debugfs.c
> index fb46c2c1784f..4730508652af 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
> @@ -990,14 +990,14 @@ mt7915_rate_txpower_get(struct file *file, char __u=
ser *user_buf,
>  	char *buf;
>  	u32 reg;
> =20
> -	buf =3D kzalloc(sz, GFP_KERNEL);
> -	if (!buf)
> -		return -ENOMEM;
> -
>  	ret =3D mt7915_mcu_get_txpower_sku(phy, txpwr, sizeof(txpwr));
>  	if (ret)
>  		return ret;
> =20
> +	buf =3D kzalloc(sz, GFP_KERNEL);
> +	if (!buf)
> +		return -ENOMEM;
> +
>  	/* Txpower propagation path: TMAC -> TXV -> BBP */
>  	len +=3D scnprintf(buf + len, sz - len,
>  			 "\nPhy%d Tx power table (channel %d)\n",
> --=20
> 2.39.0
>=20

Felix,

It seems there is already a fix for it in your tree so we can drop this pat=
ch.

Regards,
Lorenzo

--iu/RfxLzqMCsTZCq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCY8VAOAAKCRA6cBh0uS2t
rPk8AQCQcy3D9UTxz0yeYhKKhiVhljo1UMD5O2aknQuTLmPSqwEAvyrhZFY5/ej9
+agou0uuz7ZPTSYHIq9Lsx0XCIn0+QY=
=M+hI
-----END PGP SIGNATURE-----

--iu/RfxLzqMCsTZCq--

