Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C99FB66BDEB
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Jan 2023 13:35:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbjAPMfI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 16 Jan 2023 07:35:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbjAPMex (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 16 Jan 2023 07:34:53 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C35CF1E1D7
        for <linux-wireless@vger.kernel.org>; Mon, 16 Jan 2023 04:34:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673872445;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vw7SO1g/B13VPJ4ab5VbxajvkjRWMmjClgvP53tu2UM=;
        b=KYsH8KJKUTj1W5Exv+o0kq3T80Y2Bwe9WXgpAA/CM2tH1UV93BtkkMjFysqqmN/8ZiE45D
        iOuMwJkpTxzYCfd6F4UmTY5ZtXqceOP8HDWhRL/i4MvrfdZyFAMriOkaEEVKwEIhtJ8kNy
        ZBel07WZkbk/oiV4tdQg0X2AfBvZSEc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-26-kXzEiF1FOP-FZE2eV0S_mQ-1; Mon, 16 Jan 2023 07:34:03 -0500
X-MC-Unique: kXzEiF1FOP-FZE2eV0S_mQ-1
Received: by mail-wm1-f69.google.com with SMTP id bi11-20020a05600c3d8b00b003d9ebf905c9so12410807wmb.5
        for <linux-wireless@vger.kernel.org>; Mon, 16 Jan 2023 04:34:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vw7SO1g/B13VPJ4ab5VbxajvkjRWMmjClgvP53tu2UM=;
        b=CuwNB4T0Ihca/O8h9PmjgGtXIG3Dx7q5T8WVnA4+KK7UmPRvufPbaELU5V7q+k6WQT
         DXxSu1CJio9uaHJ6N9os9DyNcstk52pHhhnn4vmJmNp20T+B8gRBZbQ9+C55GDmyqIX/
         ndmbn206LDZn1IkzXqBbxgf59u0Yx6a5RbN/5PEC1A5FqPPts+n9B3qswjLoTwl00jC7
         FCpmGo4F3FW7h9XsrBe6y+cAa3/9MxABaLBfNbLphFCc19oo/AxJAZdRoTMWqOQ/DCea
         C5zbvIDu8+Wqi7u5l/fjUdZvD0yOTgQve+Y5Ccd4VO1kclo9q1yN8U+2qwGmoKyQN1Ql
         ABdQ==
X-Gm-Message-State: AFqh2kphPZqOQZmtTMVVk4+ChR7m9UC7sPZR45sxpgqgz72NZYH99HXo
        0PLx73fhgDQBWEurQTZWdIP+HRhLLd+OkveUGsn3FGp8lgqFWFBc90XdKqBCijw74FsKdWjDXj6
        ykV8WBl60ExzyeCDQA8P8bFeKO3Q=
X-Received: by 2002:a05:6000:1c19:b0:2bd:ebac:5dae with SMTP id ba25-20020a0560001c1900b002bdebac5daemr7333777wrb.15.1673872442665;
        Mon, 16 Jan 2023 04:34:02 -0800 (PST)
X-Google-Smtp-Source: AMrXdXssJaJ1T43QbFBDUOh5robjlOqRKGja/tOxAm/3nekWyYwDXk5/xS/prt1tKDqCSRK6MrU25A==
X-Received: by 2002:a05:6000:1c19:b0:2bd:ebac:5dae with SMTP id ba25-20020a0560001c1900b002bdebac5daemr7333767wrb.15.1673872442442;
        Mon, 16 Jan 2023 04:34:02 -0800 (PST)
Received: from localhost (net-188-216-77-84.cust.vodafonedsl.it. [188.216.77.84])
        by smtp.gmail.com with ESMTPSA id k5-20020adfd845000000b002bdd96d88b4sm10866479wrl.75.2023.01.16.04.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 04:34:01 -0800 (PST)
Date:   Mon, 16 Jan 2023 13:33:58 +0100
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     nbd@nbd.name, linux-wireless@vger.kernel.org
Subject: Re: [PATCH] wifi: mt76: mt7921: fix memory leak in
 mt7921_check_offload_capability
Message-ID: <Y8VENgmxvMA2i3XE@lore-desk>
References: <39ebf05085dd3069412c001ca9a31aa259de5a74.1672742135.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="G+6DUVCzk9UE2k3D"
Content-Disposition: inline
In-Reply-To: <39ebf05085dd3069412c001ca9a31aa259de5a74.1672742135.git.lorenzo@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--G+6DUVCzk9UE2k3D
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Fix possible memory leak in mt7921_check_offload_capability routine
> relasing fw data.
>=20
> Fixes: 034ae28b56f1 ("wifi: mt76: mt7921: introduce remain_on_channel sup=
port")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  drivers/net/wireless/mediatek/mt76/mt7921/init.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Felix,

This issue has already a fix in your tree, we can drop the patch as well.

Regards,
Lorenzo

>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drivers/n=
et/wireless/mediatek/mt76/mt7921/init.c
> index 542dfd425129..5ec0caa23c23 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
> @@ -175,7 +175,7 @@ u8 mt7921_check_offload_capability(struct device *dev=
, const char *fw_wm)
> =20
>  	if (!fw || !fw->data || fw->size < sizeof(*hdr)) {
>  		dev_err(dev, "Invalid firmware\n");
> -		return -EINVAL;
> +		goto out;
>  	}
> =20
>  	data =3D fw->data;
> @@ -205,7 +205,7 @@ u8 mt7921_check_offload_capability(struct device *dev=
, const char *fw_wm)
> =20
>  		data +=3D le16_to_cpu(rel_info->len) + rel_info->pad_len;
>  	}
> -
> +out:
>  	release_firmware(fw);
> =20
>  	return features ? features->data : 0;
> --=20
> 2.39.0
>=20

--G+6DUVCzk9UE2k3D
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCY8VENgAKCRA6cBh0uS2t
rPfKAP0bUbsno92V1WQMSq+17elYcrgR76IEOXkWQ3hFvoxJFgEAjFnLyzwVohct
jQ70f6xE526IbB7DaY3MlP7ANYzpVwc=
=6e3c
-----END PGP SIGNATURE-----

--G+6DUVCzk9UE2k3D--

