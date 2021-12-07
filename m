Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 167F146B878
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Dec 2021 11:09:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234807AbhLGKM2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 7 Dec 2021 05:12:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:55251 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234785AbhLGKM1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 7 Dec 2021 05:12:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638871737;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Y1qc17Wzkg9QMJ9/oH1d2JR/jyCeyLONuO+KPdMgSh4=;
        b=Gba/ysmCyO99ootlAolnTSp1byV1ROn+6sNn62WA/9k9nfJvFuJGJltK5wNNU63U8JRXhW
        rkOOi4Lyp7svaciMLShajzUXB6OMpE+OxpC+LwoEIdPljE7JfEoXLh23NgiUx0WsE8UFeM
        XxsT4ovbc/qh0sPUC4VYDnXpMLEhY6U=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-525-V1zgQJVSPBay8_Ncey3Ykg-1; Tue, 07 Dec 2021 05:08:53 -0500
X-MC-Unique: V1zgQJVSPBay8_Ncey3Ykg-1
Received: by mail-wr1-f72.google.com with SMTP id q17-20020adfcd91000000b0017bcb12ad4fso2752092wrj.12
        for <linux-wireless@vger.kernel.org>; Tue, 07 Dec 2021 02:08:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Y1qc17Wzkg9QMJ9/oH1d2JR/jyCeyLONuO+KPdMgSh4=;
        b=5/2xlPZdBn+NRpnLT4drmdFMpMlGVbAkWv/mC6zKhBDUkIx37VYjg2LntYZ7gN49Ub
         XrRddoRFnKHOWW2xScfxzSMGhVaWj7Z9so1gd6YGQJHaDh2fRRky46EGHQeiit5YHR9b
         DS5Dr0oqlJY0uMbA/kTcsHtjTrYm67O6RFx3dYkl7ouFtPMaifVg4QZgM5PcedUlYaKE
         XtXVUXWnggsUyzV16zk9R6+YsmeI6UkJLU0XAFKQHkWtGPOyGAd3E9ap911fELrIYPrf
         faCNTboi0RPw/LR2D8IkaMUUDLbfTb7I8zex8rvLHbtYisXe+0gPQg2NOFhxAps5AwP9
         jDpQ==
X-Gm-Message-State: AOAM5337hbbw5mCNoCi01KAd3/718d9vLb1wU9torws9prnzwlZJJLwl
        EuivB9c9Tp9C2qiOriRjHT3+eYGfAcbTKMxtPxFJElpDdsEkXiI2O7MKQMuvgu4+GrKLkv9IdZG
        yYclW4np73bGUeQfbZMc7RDNeHgo=
X-Received: by 2002:a5d:4843:: with SMTP id n3mr48648883wrs.335.1638871731835;
        Tue, 07 Dec 2021 02:08:51 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxC3Wg4ZRZ5NwLZWUnPZjez4JLkBG0PxpuxKgTsBZotBk5ER9r/VoLvB8Lo0nqag9Mw3b9xTA==
X-Received: by 2002:a5d:4843:: with SMTP id n3mr48648844wrs.335.1638871731649;
        Tue, 07 Dec 2021 02:08:51 -0800 (PST)
Received: from localhost (net-37-182-17-175.cust.vodafonedsl.it. [37.182.17.175])
        by smtp.gmail.com with ESMTPSA id g5sm18307403wri.45.2021.12.07.02.08.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 02:08:50 -0800 (PST)
Date:   Tue, 7 Dec 2021 11:08:49 +0100
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     sean.wang@mediatek.com
Cc:     nbd@nbd.name, Soul.Huang@mediatek.com, YN.Chen@mediatek.com,
        Leon.Yen@mediatek.com, Eric-SY.Chang@mediatek.com,
        Mark-YW.Chen@mediatek.com, Deren.Wu@mediatek.com,
        km.lin@mediatek.com, robin.chiu@mediatek.com,
        Eddie.Chen@mediatek.com, ch.yeh@mediatek.com,
        posh.sun@mediatek.com, ted.huang@mediatek.com,
        Eric.Liang@mediatek.com, Stella.Chang@mediatek.com,
        Tom.Chou@mediatek.com, steve.lee@mediatek.com, jsiuda@google.com,
        frankgor@google.com, jemele@google.com, abhishekpandit@google.com,
        shawnku@google.com, linux-wireless@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] mt76: mt7921: fix possible resume failure
Message-ID: <Ya8ysehFjoEGGEf+@lore-desk>
References: <ff1e35dcaa0a56c04339bba2ebd2c68bf815919c.1638844068.git.objelf@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7oJp8/YxkC2x5kNk"
Content-Disposition: inline
In-Reply-To: <ff1e35dcaa0a56c04339bba2ebd2c68bf815919c.1638844068.git.objelf@gmail.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--7oJp8/YxkC2x5kNk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: Sean Wang <sean.wang@mediatek.com>
>=20
> Fix the possible resume failure due to mt76_connac_mcu_set_hif_suspend
> timeout.
>=20
> That is because clearing the flag pm->suspended too early opened up a race
> window, where mt7921_poll_tx/rx scheduled a ps_work to put the device in
> doze mode, that is unexpected for the device is being resumed from the
> suspend state and would make the remaining MCU comamnds in resume handler
> failed to execute.

do we have a similar issue in mt7921s_resume()?

>=20
> Fixes: ffa1bf97425b ("mt76: mt7921: introduce PM support")
> Co-developed-by: YN Chen <YN.Chen@mediatek.com>
> Signed-off-by: YN Chen <YN.Chen@mediatek.com>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
>  drivers/net/wireless/mediatek/mt76/mt7921/pci.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7921/pci.c
> index 5635de3c80b1..21a48f02ab60 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
> @@ -315,7 +315,6 @@ static int mt7921_pci_resume(struct pci_dev *pdev)
>  	struct mt76_connac_pm *pm =3D &dev->pm;
>  	int i, err;
> =20
> -	pm->suspended =3D false;
>  	err =3D pci_set_power_state(pdev, PCI_D0);
>  	if (err)
>  		return err;
> @@ -353,7 +352,11 @@ static int mt7921_pci_resume(struct pci_dev *pdev)
>  	if (!pm->ds_enable)
>  		mt76_connac_mcu_set_deep_sleep(&dev->mt76, false);
> =20
> -	return mt76_connac_mcu_set_hif_suspend(mdev, false);
> +	err =3D mt76_connac_mcu_set_hif_suspend(mdev, false);
> +
> +	pm->suspended =3D false;
> +
> +	return err;
>  }
>  #endif /* CONFIG_PM */
> =20
> --=20
> 2.25.1
>=20

--7oJp8/YxkC2x5kNk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYa8ysQAKCRA6cBh0uS2t
rGBdAQDY8aCjO7iCtMqaQQL5IrkI60tKUwqIm9xROabHgiY61gD/XyTTgv5OrKa9
xbm/p9w5lGdB8sZghE+yq7urQ3vowQg=
=VfrE
-----END PGP SIGNATURE-----

--7oJp8/YxkC2x5kNk--

