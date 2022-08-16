Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C3A35957C4
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Aug 2022 12:14:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234295AbiHPKO2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 16 Aug 2022 06:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234389AbiHPKNs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 16 Aug 2022 06:13:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81771AD
        for <linux-wireless@vger.kernel.org>; Tue, 16 Aug 2022 01:00:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1B43FB81647
        for <linux-wireless@vger.kernel.org>; Tue, 16 Aug 2022 08:00:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E2B9C433C1;
        Tue, 16 Aug 2022 08:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660636835;
        bh=/zMMHKlKM8s9WCqb2q73VdEph+NkYHoIat6uFjL+JjI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UBtXnKDUgqs6foZAyBY89rUevgsPWiZMuICcUwFdXOE/qy9sa+g1tJS1zOFXRULvJ
         yQrqfzQ0nhJtK7Ca9Pdtz+o8z/49nwfWTtVGVHRFfQYAXmYAGdhCBazyA7ED19f3Od
         VKXuPn+NGk0KHo7maJ0kfbe6bmjFqeGHQebFr1K0qCJgG6WUZMjKpT4KeuI3b/1OMa
         ZyiX+3dPcqvBAUbFlEZ+l6sEvvg2V8KaRQJp8lq1FAuTSahNvrqD8WFsKviTlKllLv
         Wl9FY4eWjV1VQjTK4QBqTG0G6IpnpD8z4C0zyZrskWUf1yeZeIPlg17b7/NJTHDA1L
         oI8bWF/z/j2wQ==
Date:   Tue, 16 Aug 2022 10:00:31 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     sean.wang@mediatek.com
Cc:     nbd@nbd.name, lorenzo.bianconi@redhat.com, Soul.Huang@mediatek.com,
        YN.Chen@mediatek.com, Leon.Yen@mediatek.com,
        Eric-SY.Chang@mediatek.com, Deren.Wu@mediatek.com,
        km.lin@mediatek.com, jenhao.yang@mediatek.com,
        robin.chiu@mediatek.com, Eddie.Chen@mediatek.com,
        ch.yeh@mediatek.com, posh.sun@mediatek.com, ted.huang@mediatek.com,
        Stella.Chang@mediatek.com, Tom.Chou@mediatek.com,
        steve.lee@mediatek.com, jsiuda@google.com, frankgor@google.com,
        kuabhs@google.com, druth@google.com, abhishekpandit@google.com,
        shawnku@google.com, linux-wireless@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] mt76: mt7921: get rid of the false positive reset
Message-ID: <YvtOnx1/jXtKy86Q@lore-desk>
References: <95b03bb77ce93cb2cade98d947309cd669721939.1660519674.git.objelf@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ccOvUDBAjIrhQcpt"
Content-Disposition: inline
In-Reply-To: <95b03bb77ce93cb2cade98d947309cd669721939.1660519674.git.objelf@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--ccOvUDBAjIrhQcpt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: Sean Wang <sean.wang@mediatek.com>
>=20
> False positive reset would be possibly triggered by those commands we
> applied in suspend with HZ MCU timeout, especially it happened when we
> enabled kernel log in pm core to diagnose how much time we spend in each
> driver during suspend procedure. So we enlarge the value and align the MCU
> timeout as other commands we did to reduce the false positive reset.
>=20
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>

Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

> ---
>  drivers/net/wireless/mediatek/mt76/mt7921/pci_mcu.c  | 7 +------
>  drivers/net/wireless/mediatek/mt76/mt7921/sdio_mcu.c | 7 +------
>  drivers/net/wireless/mediatek/mt76/mt7921/usb.c      | 7 +------
>  3 files changed, 3 insertions(+), 18 deletions(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci_mcu.c b/driver=
s/net/wireless/mediatek/mt76/mt7921/pci_mcu.c
> index 5efda694fb9d..64568536c1e9 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/pci_mcu.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci_mcu.c
> @@ -30,12 +30,7 @@ mt7921_mcu_send_message(struct mt76_dev *mdev, struct =
sk_buff *skb,
>  	if (ret)
>  		return ret;
> =20
> -	if (cmd =3D=3D MCU_UNI_CMD(HIF_CTRL) ||
> -	    cmd =3D=3D MCU_UNI_CMD(SUSPEND) ||
> -	    cmd =3D=3D MCU_UNI_CMD(OFFLOAD))
> -		mdev->mcu.timeout =3D HZ;
> -	else
> -		mdev->mcu.timeout =3D 3 * HZ;
> +	mdev->mcu.timeout =3D 3 * HZ;
> =20
>  	if (cmd =3D=3D MCU_CMD(FW_SCATTER))
>  		txq =3D MT_MCUQ_FWDL;
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/sdio_mcu.c b/drive=
rs/net/wireless/mediatek/mt76/mt7921/sdio_mcu.c
> index e038d7404323..5c1489766d9f 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/sdio_mcu.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/sdio_mcu.c
> @@ -33,12 +33,7 @@ mt7921s_mcu_send_message(struct mt76_dev *mdev, struct=
 sk_buff *skb,
>  	if (ret)
>  		return ret;
> =20
> -	if (cmd =3D=3D MCU_UNI_CMD(HIF_CTRL) ||
> -	    cmd =3D=3D MCU_UNI_CMD(SUSPEND) ||
> -	    cmd =3D=3D MCU_UNI_CMD(OFFLOAD))
> -		mdev->mcu.timeout =3D HZ;
> -	else
> -		mdev->mcu.timeout =3D 3 * HZ;
> +	mdev->mcu.timeout =3D 3 * HZ;
> =20
>  	if (cmd =3D=3D MCU_CMD(FW_SCATTER))
>  		type =3D MT7921_SDIO_FWDL;
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/usb.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7921/usb.c
> index dd3b8884e162..d06cee386acd 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/usb.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/usb.c
> @@ -106,12 +106,7 @@ mt7921u_mcu_send_message(struct mt76_dev *mdev, stru=
ct sk_buff *skb,
>  	if (ret)
>  		return ret;
> =20
> -	if (cmd =3D=3D MCU_UNI_CMD(HIF_CTRL) ||
> -	    cmd =3D=3D MCU_UNI_CMD(SUSPEND) ||
> -	    cmd =3D=3D MCU_UNI_CMD(OFFLOAD))
> -		mdev->mcu.timeout =3D HZ;
> -	else
> -		mdev->mcu.timeout =3D 3 * HZ;
> +	mdev->mcu.timeout =3D 3 * HZ;
> =20
>  	if (cmd !=3D MCU_CMD(FW_SCATTER))
>  		ep =3D MT_EP_OUT_INBAND_CMD;
> --=20
> 2.25.1
>=20

--ccOvUDBAjIrhQcpt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYvtOnwAKCRA6cBh0uS2t
rN/KAQDfEBOueDc+W35AUsmTHAL9nFzJRbGYzP90wSMJZ3l2CwD9FpkaYX5DTU67
2YsunTsm5J0Sdo4op8DYAS6JoUFejgI=
=9TqW
-----END PGP SIGNATURE-----

--ccOvUDBAjIrhQcpt--
