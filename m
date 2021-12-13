Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B63E4728CA
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Dec 2021 11:15:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240067AbhLMKOq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Dec 2021 05:14:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240105AbhLMKKw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Dec 2021 05:10:52 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDEFEC014A7C
        for <linux-wireless@vger.kernel.org>; Mon, 13 Dec 2021 01:53:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B7BFFB80E73
        for <linux-wireless@vger.kernel.org>; Mon, 13 Dec 2021 09:53:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6984C34601;
        Mon, 13 Dec 2021 09:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639389227;
        bh=v7Lg+J16vRQFISY4twI+8sD57NLw7i8MiOwfhdznK+o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s0Djrd5RBGfyMWUO11UbkwkExyeoQVutnpI/n2Lj9NPQwQjqokhl2zmxtDJIAosy0
         tALPIRGEVSlKub8Nps4nBEot/UmLzS5KYxXjs3LIUOHLZzpzz+OwCL0yGgvCNJtHzF
         mw9KwyX7KshOEpAN5pjrUJ9gWeUR2Qg4hjObUruloVyPQa+EZ1qxbAQ09pxIGNoEDC
         T//bqIeuJ/H0jEmB9POl62OCr+joQvO5uIwmOgfrSAVBVvRiAObXjOJNnBuNSyHwBy
         taXI6+Yz9u6KjiyZGqjXssNV7wtMlCz92+ZnrBsmLVcWg9RGsCfTxVDLHPm5g8arZT
         kHhJ/ltNQMPZQ==
Date:   Mon, 13 Dec 2021 10:53:43 +0100
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     sean.wang@mediatek.com
Cc:     lorenzo.bianconi@redhat.com, nbd@nbd.name, Soul.Huang@mediatek.com,
        YN.Chen@mediatek.com, Leon.Yen@mediatek.com,
        Eric-SY.Chang@mediatek.com, Mark-YW.Chen@mediatek.com,
        Deren.Wu@mediatek.com, km.lin@mediatek.com,
        jenhao.yang@mediatek.com, robin.chiu@mediatek.com,
        Eddie.Chen@mediatek.com, ch.yeh@mediatek.com,
        posh.sun@mediatek.com, ted.huang@mediatek.com,
        Eric.Liang@mediatek.com, Stella.Chang@mediatek.com,
        Tom.Chou@mediatek.com, steve.lee@mediatek.com, jsiuda@google.com,
        frankgor@google.com, jemele@google.com, abhishekpandit@google.com,
        shawnku@google.com, linux-wireless@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 1/2] mt76: mt7921s: make pm->suspended usage consistent
Message-ID: <YbcYJ47OKfh0A5Vt@lore-desk>
References: <YbTU08hzeTSJPIsp@lore-desk--annotate>
 <1639242882-15796-1-git-send-email-sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0SXPcFI+nToIgH3R"
Content-Disposition: inline
In-Reply-To: <1639242882-15796-1-git-send-email-sean.wang@mediatek.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--0SXPcFI+nToIgH3R
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: Sean Wang <sean.wang@mediatek.com>
>=20
> >> From: Sean Wang <sean.wang@mediatek.com>
> >>
> >> Update pm->suspended usage to be consistent with mt7921e driver.
> >>
> >> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> >> ---
> >>  drivers/net/wireless/mediatek/mt76/mt7921/sdio.c | 7 +++++--
> >>  1 file changed, 5 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c b/driver=
s/net/wireless/mediatek/mt76/mt7921/sdio.c
> >> index 84be229a899d..44ee9369f6bf 100644
> >> --- a/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
> >> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
> >> @@ -278,7 +278,6 @@ static int mt7921s_resume(struct device *__dev)
> >>	struct mt76_dev *mdev =3D &dev->mt76;
> >>	int err;
> >>
> >> -	pm->suspended =3D false;
> >>	clear_bit(MT76_STATE_SUSPEND, &mdev->phy.state);
> >>
> >>	err =3D mt7921_mcu_drv_pmctrl(dev);
> >> @@ -294,7 +293,11 @@ static int mt7921s_resume(struct device *__dev)
> >>	if (!pm->ds_enable)
> >>		mt76_connac_mcu_set_deep_sleep(mdev, false);
> >>
> >> -	return mt76_connac_mcu_set_hif_suspend(mdev, false);
> >> +	err =3D mt76_connac_mcu_set_hif_suspend(mdev, false);
> >
> >should we check return value here? Something like:
> >
> >	if (err)
> >		return err;
> >
> >	pm->suspended =3D false;
> >	return 0;
> >
> >Or, is the chip up even if mt76_connac_mcu_set_hif_suspend() fails?
>=20
> yes, chip is eventually up again by recovered with the following wifi res=
et
>=20
> with current logic, if do so (not mark pm->suspended back as false to sho=
w suspend/resume is over),
>=20
> the pm runtime would not be enabled again after the wifi reset

maybe we should just set pm->suspended =3D false; in mt7921_mac_reset_work(=
) as
we do for hw_full_reset, wdyt?

Regards,
Lorenzo

>=20
> >> +
> >> +	pm->suspended =3D false;
> >> +
> >> +	return err;
> >>  }
> >>
> >>  static const struct dev_pm_ops mt7921s_pm_ops =3D {
> >> --
> >> 2.25.1
> >>

--0SXPcFI+nToIgH3R
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYbcYJwAKCRA6cBh0uS2t
rJ4JAQCttsm1F7E9ENH4GfBlVaclyHUhAnjDI9hi6Bcl2Y/deQEA/+HpBfUhu78I
/hJgrRrPGMZvkS/H1w2m0a4xUcgGWgs=
=ioOx
-----END PGP SIGNATURE-----

--0SXPcFI+nToIgH3R--
