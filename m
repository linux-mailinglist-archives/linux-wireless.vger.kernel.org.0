Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E69D31305D
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Feb 2021 12:14:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232654AbhBHLNX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 8 Feb 2021 06:13:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:55320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232965AbhBHLKe (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 8 Feb 2021 06:10:34 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A0EEF64E37;
        Mon,  8 Feb 2021 11:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612782576;
        bh=6H53zMW2E74KBJCGbq23Apj96Kf1NGymx1WwrP/kk8g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eFQIpE1WO1cjJhr0726KLEUsgw8yYlR3JwYcmpozV98F7+pGcRQ+faSJiOhwymK86
         DJ7EAC2eJRo/Rhsem/2QjsdBoO5n4tvMPm0Fh/3WkTS/tHPxfXmP9fT1/PsO6Hh+kl
         2pO+BVu5KzjtiAnVNQ+/61rgLoWclMCFHUdsVmFn7xC6TeJ1Bydelp1aTfkCh7nJaQ
         naqoCSoglVSEIy6K1fUvu265ESsPo6WT+E6jWMNVFkopaz5BCezam73DPOUXFjBzoZ
         Iifrb+eZQ32V/CVhYEStfTlsW/85tXyKzaOLH3dM3F6Ek8sBGYeficcyMNigCOr5Ij
         hQFYYIK8FhRkw==
Date:   Mon, 8 Feb 2021 12:09:31 +0100
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Felix Fietkau <nbd@nbd.name>,
        linux-wireless <linux-wireless@vger.kernel.org>
Subject: Re: pull request: mt76 2021-01-29
Message-ID: <20210208110931.GC2593@lore-desk>
References: <3eba5570-7cff-f51e-4050-aa0054f98f81@nbd.name>
 <20210208102728.BBBE3C433CA@smtp.codeaurora.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="NU0Ex4SbNnrxsi6C"
Content-Disposition: inline
In-Reply-To: <20210208102728.BBBE3C433CA@smtp.codeaurora.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--NU0Ex4SbNnrxsi6C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[...]
> b8135057988e mt76: mt7915: simplify mt7915_mcu_send_message routine
> c203dd621780 mt76: mt7915: rework mcu API
>=20
> This was not easy to fix. Felix & Lorenzo, please carefully check my reso=
lution
> in the pending branch:

Hi Kalle,

it is not easy to check a patch of a patch :) one comment inline.

Regards,
Lorenzo

>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/wireless-drivers-ne=
xt.git/commit/?h=3Dpending&id=3Ddfe85c17c7c7183e1d409b948fae9d8e545cb25d
>=20
> This is the diff output of my resolution:
>=20
> diff --cc drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
> index e211a2bd4d3c,0296f2aa7997..000000000000
> --- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
> @@@ -255,10 -248,10 +248,10 @@@ mt7915_mcu_send_message(struct mt76_de
>   {
>         struct mt7915_dev *dev =3D container_of(mdev, struct mt7915_dev, =
mt76);
>         struct mt7915_mcu_txd *mcu_txd;
> -       u8 seq, pkt_fmt, qidx;
>  -      enum mt76_txq_id txq;
>  +      enum mt76_mcuq_id qid;
>         __le32 *txd;
>         u32 val;
> +       u8 seq;
>  =20
>         /* TODO: make dynamic based on msg type */
>         mdev->mcu.timeout =3D 20 * HZ;
> @@@ -267,22 -260,16 +260,16 @@@
>         if (!seq)
>                 seq =3D ++dev->mt76.mcu.msg_seq & 0xf;
>  =20
> -       if (cmd =3D=3D -MCU_CMD_FW_SCATTER) {
>  -      if (cmd =3D=3D MCU_CMD(FW_SCATTER)) {
>  -              txq =3D MT_MCUQ_FWDL;
> ++      if (cmd =3D=3D MCU_CMD_FW_SCATTER) {

I think it should be MCU_CMD(FW_SCATTER) here instead of MCU_CMD_FW_SCATTER.

>  +              qid =3D MT_MCUQ_FWDL;
>                 goto exit;
>         }
>  =20
>         mcu_txd =3D (struct mt7915_mcu_txd *)skb_push(skb, sizeof(*mcu_tx=
d));
> -=20
> -       if (test_bit(MT76_STATE_MCU_RUNNING, &dev->mphy.state)) {
> +       if (test_bit(MT76_STATE_MCU_RUNNING, &dev->mphy.state))
>  -              txq =3D MT_MCUQ_WA;
>  +              qid =3D MT_MCUQ_WA;
> -               qidx =3D MT_TX_MCU_PORT_RX_Q0;
> -               pkt_fmt =3D MT_TX_TYPE_CMD;
> -       } else {
> +       else
>  -              txq =3D MT_MCUQ_WM;
>  +              qid =3D MT_MCUQ_WM;
> -               qidx =3D MT_TX_MCU_PORT_RX_Q0;
> -               pkt_fmt =3D MT_TX_TYPE_CMD;
> -       }
>  =20
>         txd =3D mcu_txd->txd;
>=20
> --=20
> https://patchwork.kernel.org/project/linux-wireless/patch/3eba5570-7cff-f=
51e-4050-aa0054f98f81@nbd.name/
>=20
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpa=
tches
>=20

--NU0Ex4SbNnrxsi6C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYCEb6QAKCRA6cBh0uS2t
rM9XAQDQfYz3HqfQPE84D3gzw6iNr3/EVBy1KKhEjVm0ZzCVDAD/ZSGMFOc2gslk
Bm0mLYYgTDl7fs21UUVwPRX4bBd3EAc=
=Ad6l
-----END PGP SIGNATURE-----

--NU0Ex4SbNnrxsi6C--
