Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73DE14714C8
	for <lists+linux-wireless@lfdr.de>; Sat, 11 Dec 2021 17:45:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbhLKQmC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 11 Dec 2021 11:42:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:49603 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230329AbhLKQmB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 11 Dec 2021 11:42:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639240921;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZKcJEEF5DlHrA1OxBLWQKY9VII5AxIf4/hVpU6/vKcI=;
        b=OsqPCJ3ugsYGDVM+PdcNZxS74b5gpb5meqLApqNScM7MBLZY7aKWa1Gurviy2h/TNLPzJN
        /mSBnbaYuP6CvHtXqqG7eqEDP3k5ebq0Syx3ACRYx7Vjb33yVTOtEoOYRJ6/SEIUUUOeIC
        nRNdaNQtjt3ZBbflECyrjTBCEzeGz44=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-230-3yheD4OrPwqdImd0AZEI1g-1; Sat, 11 Dec 2021 11:41:59 -0500
X-MC-Unique: 3yheD4OrPwqdImd0AZEI1g-1
Received: by mail-ed1-f69.google.com with SMTP id v22-20020a50a456000000b003e7cbfe3dfeso10681823edb.11
        for <linux-wireless@vger.kernel.org>; Sat, 11 Dec 2021 08:41:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZKcJEEF5DlHrA1OxBLWQKY9VII5AxIf4/hVpU6/vKcI=;
        b=j00ufXFldx6wPrYAFocsUAUaXpnubE0muBPMBRbxKflEzAAQC/Rqfxa7cMsTsCdQC7
         QPc0XUOBugOC9Kc8HN2ZX9Yi43abpQUrnwxrJHSq/WVrPFRdOe2dXAWtVuwYDsW8aDTq
         YFybIRNFyukrC6RoHu/m/kSK2yY8fucIIvZAMx6zHGSZ1BtJBOdpyLIFhPJNsmKdL7r+
         MrL6Dqgf4rPu9T+nh1AWsor6ARhPhLRhKhR0HkR38OrKUHDgjTBLEq0/wAaZorOXP94z
         WQ2X2jInVMqY0BGBh9IiS/Nsfu5EA2Y+r377flYwEO7oA55LOauktWpi9ppwGIHMmagN
         s3iQ==
X-Gm-Message-State: AOAM530RMqSS7ptZy0yTYVzKCxZNulZMlR5RrzWf6Rqr2+OznUd2/TaX
        Bjsu8JOxuNWWk8atxcYApdq9lMA5DWuk3u1q02rjYmie+B3pzn5PNjNYv1tfgQWYiIW+BNBdlMY
        J3nzP4Xlc2Oh8+mH3phM9352F8Tc=
X-Received: by 2002:aa7:d0d1:: with SMTP id u17mr47559169edo.135.1639240918786;
        Sat, 11 Dec 2021 08:41:58 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzWWoFATl8W7TYrbrSVBSd+HyXsl5FjgxcjiRTXWWq8c3ED7ymnWTZJAHXG0GHRaf2JgeM6Vw==
X-Received: by 2002:aa7:d0d1:: with SMTP id u17mr47559115edo.135.1639240918387;
        Sat, 11 Dec 2021 08:41:58 -0800 (PST)
Received: from localhost (net-37-182-17-175.cust.vodafonedsl.it. [37.182.17.175])
        by smtp.gmail.com with ESMTPSA id 29sm3346980edw.42.2021.12.11.08.41.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Dec 2021 08:41:57 -0800 (PST)
Date:   Sat, 11 Dec 2021 17:41:55 +0100
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
Subject: Re: [PATCH 1/2] mt76: mt7921s: make pm->suspended usage consistent
Message-ID: <YbTU08hzeTSJPIsp@lore-desk>
References: <87100999ebfd6e205e655a6355a3990ff89d3945.1639239996.git.objelf@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="P+2aLphRvD2BcDlm"
Content-Disposition: inline
In-Reply-To: <87100999ebfd6e205e655a6355a3990ff89d3945.1639239996.git.objelf@gmail.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--P+2aLphRvD2BcDlm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: Sean Wang <sean.wang@mediatek.com>
>=20
> Update pm->suspended usage to be consistent with mt7921e driver.
>=20
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
>  drivers/net/wireless/mediatek/mt76/mt7921/sdio.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c b/drivers/n=
et/wireless/mediatek/mt76/mt7921/sdio.c
> index 84be229a899d..44ee9369f6bf 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
> @@ -278,7 +278,6 @@ static int mt7921s_resume(struct device *__dev)
>  	struct mt76_dev *mdev =3D &dev->mt76;
>  	int err;
> =20
> -	pm->suspended =3D false;
>  	clear_bit(MT76_STATE_SUSPEND, &mdev->phy.state);
> =20
>  	err =3D mt7921_mcu_drv_pmctrl(dev);
> @@ -294,7 +293,11 @@ static int mt7921s_resume(struct device *__dev)
>  	if (!pm->ds_enable)
>  		mt76_connac_mcu_set_deep_sleep(mdev, false);
> =20
> -	return mt76_connac_mcu_set_hif_suspend(mdev, false);
> +	err =3D mt76_connac_mcu_set_hif_suspend(mdev, false);

should we check return value here? Something like:

	if (err)
		return err;
=09
	pm->suspended =3D false;
	return 0;

Or, is the chip up even if mt76_connac_mcu_set_hif_suspend() fails?

> +
> +	pm->suspended =3D false;
> +
> +	return err;
>  }
> =20
>  static const struct dev_pm_ops mt7921s_pm_ops =3D {
> --=20
> 2.25.1
>=20

--P+2aLphRvD2BcDlm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYbTU0wAKCRA6cBh0uS2t
rN+1AP0Wj4z3qiVUN7SCUJZY++EBa19nPihv1Eaqx50DPqa3RAD+NiufVMTBDqQZ
bSQajtQ8DR38y79NVkEDzIZyRWMACQk=
=dFa2
-----END PGP SIGNATURE-----

--P+2aLphRvD2BcDlm--

