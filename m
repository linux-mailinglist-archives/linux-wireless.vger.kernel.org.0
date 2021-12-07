Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1200946C432
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Dec 2021 21:08:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231920AbhLGULo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 7 Dec 2021 15:11:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:38552 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229867AbhLGULl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 7 Dec 2021 15:11:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638907690;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eBvl6LFe+aw+Rh35aeMDmSH951L6XzA7tNWjg1mtFG8=;
        b=JyO2g/jIuurJ279BeyHM9PlbGj5QcsPcWExtitJeYJ6I3hAmQUqBEhJt+I54JTX9iU4zs8
        d0noiVioJMuhvypjoLQAVy/FIDnTtHvb/HzpoAdmKF5O0n+g4sdZRFoRvHWa5vH0XiJamd
        eYPUdF+rWMsZBDZH9XiG5yVcoozOoDc=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-469-LzVaUnGpOkmYrbcO80b3hg-1; Tue, 07 Dec 2021 15:08:09 -0500
X-MC-Unique: LzVaUnGpOkmYrbcO80b3hg-1
Received: by mail-qt1-f199.google.com with SMTP id o12-20020a05622a008c00b002aff5552c89so368491qtw.23
        for <linux-wireless@vger.kernel.org>; Tue, 07 Dec 2021 12:08:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eBvl6LFe+aw+Rh35aeMDmSH951L6XzA7tNWjg1mtFG8=;
        b=ehBRIE45xog4m1otkvwCM4qaeppT8hYkyRvgih8iwGRgUZ2ICI/YNGjHKXTtrROIV3
         0jtaTcc/jkPTiylMo3qn+Wutu7InMYEgb3mQpEaH1eoZOazlMTEioLJ7Sx3e48fwxy0v
         A8JGFlMAHWhJ6kwZStUznl40b7tFqSYrc6ABgWvsp7Lcd3aM0ml1OsXP59dWSHahUWY3
         sGAVCM+3tkDhBrasS2bv6lgKZrk+EKLYRaVp0M8PdKBeUOYP834DqoyQIJjLMjScRHoM
         G33BsI4L4DMiV4nGtjqKru337vkNfFzXcANdJhSeuLuiUH3ZZ2DbcpL4G3qrLNwKGvLt
         pefQ==
X-Gm-Message-State: AOAM533qUjQDL8gnnoA0TGK1jwURHTLlkdCMiYc/iG8OlK8Pos/Wi1+x
        e4TF9lu5eAGVFWErvkfJU4ABpu20DxypinEO/eZtFkR5jLo3RvduWWNTgTDCpGJNxw+B7IKFbqM
        cilfr/i2fnaTwfFgh5WKxc1U3ZQg=
X-Received: by 2002:a05:620a:a09:: with SMTP id i9mr1614342qka.768.1638907688626;
        Tue, 07 Dec 2021 12:08:08 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx0skii4m+c+RFKdfj7DFNZr066Mgdfx30R34dkotQ/yRz5s9AsXxgsHMtbzJuR+BG5wkfEPg==
X-Received: by 2002:a05:620a:a09:: with SMTP id i9mr1614300qka.768.1638907688385;
        Tue, 07 Dec 2021 12:08:08 -0800 (PST)
Received: from localhost (net-37-182-17-175.cust.vodafonedsl.it. [37.182.17.175])
        by smtp.gmail.com with ESMTPSA id v2sm418115qkp.72.2021.12.07.12.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 12:08:07 -0800 (PST)
Date:   Tue, 7 Dec 2021 21:08:04 +0100
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
Message-ID: <Ya+/JNMaq2O3BKwb@lore-desk>
References: <Ya8ysehFjoEGGEf+@lore-desk--annotate>
 <1638897717-14465-1-git-send-email-sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="S3T/g1lnhrSI4XOY"
Content-Disposition: inline
In-Reply-To: <1638897717-14465-1-git-send-email-sean.wang@mediatek.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--S3T/g1lnhrSI4XOY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: Sean Wang <sean.wang@mediatek.com>
>=20
> >> From: Sean Wang <sean.wang@mediatek.com>
> >>
> >> Fix the possible resume failure due to mt76_connac_mcu_set_hif_suspend
> >> timeout.
> >>
> >> That is because clearing the flag pm->suspended too early opened up a
> >> race window, where mt7921_poll_tx/rx scheduled a ps_work to put the
> >> device in doze mode, that is unexpected for the device is being
> >> resumed from the suspend state and would make the remaining MCU
> >> comamnds in resume handler failed to execute.
> >
> >do we have a similar issue in mt7921s_resume()?
>=20
> We don't have the same issue found in mt7921s_resume because the driver
> guarantees all MCU commands (even in mt7921s_resume) always work in the a=
ctive
> state.
>=20
> But we can have the same patch for mt7921s just to make code consistent w=
ith
> mt7921e.

ack, agree.

Regards,
Lorenzo

>=20
> >
> >>
> >> Fixes: ffa1bf97425b ("mt76: mt7921: introduce PM support")
> >> Co-developed-by: YN Chen <YN.Chen@mediatek.com>
> >> Signed-off-by: YN Chen <YN.Chen@mediatek.com>
> >> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> >> ---
> >>  drivers/net/wireless/mediatek/mt76/mt7921/pci.c | 7 +++++--
> >>  1 file changed, 5 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
> >> b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
> >> index 5635de3c80b1..21a48f02ab60 100644
> >> --- a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
> >> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
> >> @@ -315,7 +315,6 @@ static int mt7921_pci_resume(struct pci_dev *pdev)
> >>	struct mt76_connac_pm *pm =3D &dev->pm;
> >>	int i, err;
> >>
> >> -	pm->suspended =3D false;
> >>	err =3D pci_set_power_state(pdev, PCI_D0);
> >>	if (err)
> >>		return err;
> >> @@ -353,7 +352,11 @@ static int mt7921_pci_resume(struct pci_dev *pdev)
> >>	if (!pm->ds_enable)
> >>		mt76_connac_mcu_set_deep_sleep(&dev->mt76, false);
> >>
> >> -	return mt76_connac_mcu_set_hif_suspend(mdev, false);
> >> +	err =3D mt76_connac_mcu_set_hif_suspend(mdev, false);
> >> +
> >> +	pm->suspended =3D false;
> >> +
> >> +	return err;
> >>  }
> >>  #endif /* CONFIG_PM */
> >>
> >> --
> >> 2.25.1
> >>
> >
>=20

--S3T/g1lnhrSI4XOY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYa+/JAAKCRA6cBh0uS2t
rP8HAQCJ8HWqVgvcuEgmYSstf5h0Sei/dsGM3SatXC1xegI7swD/ZNVyb1+PBtF8
uInGuoNrgIY7N6DVud2XrvNWF6dBjQ4=
=6lcp
-----END PGP SIGNATURE-----

--S3T/g1lnhrSI4XOY--

