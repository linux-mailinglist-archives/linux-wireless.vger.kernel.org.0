Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 054E448F373
	for <lists+linux-wireless@lfdr.de>; Sat, 15 Jan 2022 01:22:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231485AbiAOAWW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Jan 2022 19:22:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:53914 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230450AbiAOAWV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Jan 2022 19:22:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642206141;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IOTMjcsFlAXOs8F/XDJPlk4E5ciP5rKuxIodhPB+eOw=;
        b=e5AwzlfASxVtLeDCmMOvAaK2Ny8fSQT1LJ7P17QI53CQaMMvtuR1ESSSAWfgCYMMMThDvc
        nDy9s4YMrnwx4RFqj53JC1/oT92//RkZ0ZtrMych505MBVBIAXKlYuHKY0W9nA5b9z9Khq
        2ZFpODNxrOIAfFKXq/10e6HmMsI6mtg=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-255-zPh0fO52Om6UP405KLW4CA-1; Fri, 14 Jan 2022 19:22:19 -0500
X-MC-Unique: zPh0fO52Om6UP405KLW4CA-1
Received: by mail-ed1-f70.google.com with SMTP id l10-20020a056402124a00b0040186fbe40dso940845edw.7
        for <linux-wireless@vger.kernel.org>; Fri, 14 Jan 2022 16:22:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IOTMjcsFlAXOs8F/XDJPlk4E5ciP5rKuxIodhPB+eOw=;
        b=F6Grm6Kpmbi60vGcsehUFl0TLcaxUGrLmaM0Jq5BJftaFmuAB+IWfUh9G9ST8MXxpU
         mByMi0yBBjq1vttJXImNt8PDTY74gS8Y2MCOEoXUX+97XiUvKgPUPcinwKLQkc+JeIhQ
         0ad8578fO3uJJDe08EeYAtCvOHx85B4/K1tifE/c+rYexGNzTy3FKpmxG7iaBXXhJAHM
         xB1HJk+wsqfD5OjlKZvnH4My8LAtJOqBni4nLJsI7CeOgr7MjVA4wyb3wfIpjSu4skak
         9vAn4ztrweo2G7qYas19PPQqdC5ThuWQjRt+JLGG5pOf+PEuXGKV6xC+LGpXRaYsLo8F
         yIag==
X-Gm-Message-State: AOAM533AFSki2p+SzX5Xx9EjpAS8wZVxawXzZ58bRI5KrlRab/soiYLW
        lW3yz0Dtm2ZSZyf5m48amAG1wVcdI1YJsyrpsxMDNEbFVnGE5zF9+PCCsEIS9nPg9LNje82/Wzf
        r7Nf/QLGfk1LYilnsY89+vcbtgUQ=
X-Received: by 2002:a17:906:5d12:: with SMTP id g18mr9100683ejt.524.1642206138485;
        Fri, 14 Jan 2022 16:22:18 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwHbUuP9yCC0Syz/FEFHdMn3EIDMrhDwVbKAhmAz8WLt/qVA9am2nzcPig3xq9CWbl/ECeTBQ==
X-Received: by 2002:a17:906:5d12:: with SMTP id g18mr9100673ejt.524.1642206138315;
        Fri, 14 Jan 2022 16:22:18 -0800 (PST)
Received: from localhost (net-93-146-37-237.cust.vodafonedsl.it. [93.146.37.237])
        by smtp.gmail.com with ESMTPSA id e16sm2821140edu.15.2022.01.14.16.22.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jan 2022 16:22:17 -0800 (PST)
Date:   Sat, 15 Jan 2022 01:22:15 +0100
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     sean.wang@mediatek.com
Cc:     nbd@nbd.name, Soul.Huang@mediatek.com, YN.Chen@mediatek.com,
        Leon.Yen@mediatek.com, Eric-SY.Chang@mediatek.com,
        Mark-YW.Chen@mediatek.com, Deren.Wu@mediatek.com,
        km.lin@mediatek.com, jenhao.yang@mediatek.com,
        robin.chiu@mediatek.com, Eddie.Chen@mediatek.com,
        ch.yeh@mediatek.com, posh.sun@mediatek.com, ted.huang@mediatek.com,
        Eric.Liang@mediatek.com, Stella.Chang@mediatek.com,
        Tom.Chou@mediatek.com, steve.lee@mediatek.com, jsiuda@google.com,
        frankgor@google.com, jemele@google.com, abhishekpandit@google.com,
        shawnku@google.com, linux-wireless@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2 2/2] mt76: mt7921s: run sleep mode by default
Message-ID: <YeITtw2P89PN0nh8@lore-desk>
References: <c09673a115c39f7af692efb984a5dc0c75238a64.1642204233.git.objelf@gmail.com>
 <ddbc5499b76989c7d67fcbc31eb19ff535156dfa.1642204233.git.objelf@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3ZxKOMiV+WaUfZ/B"
Content-Disposition: inline
In-Reply-To: <ddbc5499b76989c7d67fcbc31eb19ff535156dfa.1642204233.git.objelf@gmail.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--3ZxKOMiV+WaUfZ/B
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Jan 15, Sean Wang wrote:
> From: Sean Wang <sean.wang@mediatek.com>
>=20
> Apply sleep mode by default to reduce power consumption as possible.

Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

>=20
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
> v1 -> v2: rebase on the top of
> 	  ("mt76: mt7921: toggle runtime-pm adding a monitor vif")
> ---
>  drivers/net/wireless/mediatek/mt76/mt7921/init.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drivers/n=
et/wireless/mediatek/mt76/mt7921/init.c
> index 6059d8a0f227..fa6af85bba7b 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
> @@ -226,14 +226,10 @@ int mt7921_register_device(struct mt7921_dev *dev)
>  	dev->pm.idle_timeout =3D MT7921_PM_TIMEOUT;
>  	dev->pm.stats.last_wake_event =3D jiffies;
>  	dev->pm.stats.last_doze_event =3D jiffies;
> -
> -	/* TODO: mt7921s run sleep mode on default  */
> -	if (mt76_is_mmio(&dev->mt76)) {
> -		dev->pm.enable_user =3D true;
> -		dev->pm.enable =3D true;
> -		dev->pm.ds_enable_user =3D true;
> -		dev->pm.ds_enable =3D true;
> -	}
> +	dev->pm.enable_user =3D true;
> +	dev->pm.enable =3D true;
> +	dev->pm.ds_enable_user =3D true;
> +	dev->pm.ds_enable =3D true;
> =20
>  	if (mt76_is_sdio(&dev->mt76))
>  		hw->extra_tx_headroom +=3D MT_SDIO_TXD_SIZE + MT_SDIO_HDR_SIZE;
> --=20
> 2.25.1
>=20

--3ZxKOMiV+WaUfZ/B
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYeITtwAKCRA6cBh0uS2t
rOMJAQDBplG0yTmRNOJh8aKzzetqboDPc3/i787qyVAhD/7pLQD8D4vV5TPSFZ9x
12jADQqQ6c9U0UgvJHAADexQfbIs8QE=
=dm9T
-----END PGP SIGNATURE-----

--3ZxKOMiV+WaUfZ/B--

