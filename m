Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BD7A48D4B0
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jan 2022 10:49:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbiAMJDL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Jan 2022 04:03:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:54274 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232728AbiAMJDK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Jan 2022 04:03:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642064589;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1mqmBL+C9EoY87rSv9X6H8gKMuL/4Q06aTTAYFVKzpI=;
        b=h2Kz7gXo0FW3sMdJfEb9lATACtY7jx5/EKWILOLbPoRtMALhB/oPe0/cMWW80r86J2BrsT
        4HsIAGEP+D9co6roAKMcG5zvUAo4h9OAc/VAFyr4W2wVkmyyTpP0wwyO+Z54XAPlhmlNPv
        yM+BzzfqOXIZXJCmffva+XX/2Fm5OuU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-65-qWgP5MgNPcS1T8F1_iMdSA-1; Thu, 13 Jan 2022 04:03:08 -0500
X-MC-Unique: qWgP5MgNPcS1T8F1_iMdSA-1
Received: by mail-wm1-f70.google.com with SMTP id a3-20020a05600c348300b0034a0dfc86aaso2869131wmq.6
        for <linux-wireless@vger.kernel.org>; Thu, 13 Jan 2022 01:03:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1mqmBL+C9EoY87rSv9X6H8gKMuL/4Q06aTTAYFVKzpI=;
        b=CY4TmGaczMaKv2zrpHXPysVu9xPLqXgsf4vVbfhDKpUBVp0EpjFxmPjF9GJpnAbHkm
         UPzeXgptFhfu61eaf2bGsaPH+5gy6P5MVd2HMR82a+DDyOZcVwZi2frthd/b1CX0QW8s
         QK/FBIfQS/Lq0yq8yraYKISWDUdJ6xOHkEXVc2pLE/C/pZLViGIztsdCQ2Wl9BQAygmb
         5mG6zpMJDHarxf4TFoFcfds4I5eqXTrBAbAmyrbHcu8GNlvUfL2F57ah+yPVIfBBIHza
         IgDbcqR43s+X3NbQjtdS3XWSuPUk64ZKNEvfM4iGwAxeIg3lk7lcMNi1qbiapmnJdMlI
         Z/Tw==
X-Gm-Message-State: AOAM531dy7Leyz/RQLTS5bXEbTy6T1WQ1Zmhu0JwMv4qKn02PFS0vwrt
        DosWrZT31jcpup+NPOFltOmOU6ijCPK6xjBCox+sdOkP4Ol9Klf+IsOuBXO5zQL6f8hfwN3E/Jo
        LQOzFLHQZfBfBjNiSmmqF+K2BFw4=
X-Received: by 2002:adf:cd92:: with SMTP id q18mr3027208wrj.705.1642064586789;
        Thu, 13 Jan 2022 01:03:06 -0800 (PST)
X-Google-Smtp-Source: ABdhPJynf47rm6EnbVMm/rqE81wiQKddc4pAT6+vAyNI4ydsepmMXmyoL1xxq6SktqSaVnrxGzWdGQ==
X-Received: by 2002:adf:cd92:: with SMTP id q18mr3027180wrj.705.1642064586525;
        Thu, 13 Jan 2022 01:03:06 -0800 (PST)
Received: from localhost (net-93-146-37-237.cust.vodafonedsl.it. [93.146.37.237])
        by smtp.gmail.com with ESMTPSA id f5sm2044102wri.52.2022.01.13.01.03.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jan 2022 01:03:06 -0800 (PST)
Date:   Thu, 13 Jan 2022 10:03:03 +0100
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
Subject: Re: [PATCH 3/3] mt76: mt7921s: run sleep mode by default
Message-ID: <Yd/qxxa5NRB4Nh6a@lore-desk>
References: <651a010d8ff888909b5b8363fa4b243aadc62d45.1642061035.git.objelf@gmail.com>
 <9025e5bd5212cab4bd72fd76d35b205980499056.1642061035.git.objelf@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mm8FNAEshZDj3JtJ"
Content-Disposition: inline
In-Reply-To: <9025e5bd5212cab4bd72fd76d35b205980499056.1642061035.git.objelf@gmail.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--mm8FNAEshZDj3JtJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: Sean Wang <sean.wang@mediatek.com>
>=20
> Apply sleep mode by default to reduce power consumption as possible.
>=20
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
>  drivers/net/wireless/mediatek/mt76/mt7921/init.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drivers/n=
et/wireless/mediatek/mt76/mt7921/init.c
> index ad59ef9839dc..0166a5503aef 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
> @@ -226,12 +226,8 @@ int mt7921_register_device(struct mt7921_dev *dev)
>  	dev->pm.idle_timeout =3D MT7921_PM_TIMEOUT;
>  	dev->pm.stats.last_wake_event =3D jiffies;
>  	dev->pm.stats.last_doze_event =3D jiffies;
> -
> -	/* TODO: mt7921s run sleep mode on default  */
> -	if (mt76_is_mmio(&dev->mt76)) {
> -		dev->pm.enable =3D true;
> -		dev->pm.ds_enable =3D true;
> -	}
> +	dev->pm.enable =3D true;
> +	dev->pm.ds_enable =3D true;

cool :)
can you please rebase this patch ontop of the following one?
Regards,
Lorenzo

https://patchwork.kernel.org/project/linux-wireless/patch/f6ad709b1a64152b5=
955e71b7eef9f9c4c7f127e.1641893305.git.lorenzo@kernel.org/

> =20
>  	if (mt76_is_sdio(&dev->mt76))
>  		hw->extra_tx_headroom +=3D MT_SDIO_TXD_SIZE + MT_SDIO_HDR_SIZE;
> --=20
> 2.25.1
>=20

--mm8FNAEshZDj3JtJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYd/qxwAKCRA6cBh0uS2t
rET2AQCQobzcikTcuq/BEtdjFrocGaxYJ2gcUDNGrg/jvZGC1AEAxxOQFaeI1dOl
lNegHjX9lDFExvmumSwGF/YgAShJGgQ=
=5lz0
-----END PGP SIGNATURE-----

--mm8FNAEshZDj3JtJ--

