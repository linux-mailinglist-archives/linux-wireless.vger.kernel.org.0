Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92CE747E936
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Dec 2021 22:55:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231553AbhLWVzT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Dec 2021 16:55:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbhLWVzS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Dec 2021 16:55:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AE3AC061401
        for <linux-wireless@vger.kernel.org>; Thu, 23 Dec 2021 13:55:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 35D53B81D14
        for <linux-wireless@vger.kernel.org>; Thu, 23 Dec 2021 21:55:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55DC2C36AE5;
        Thu, 23 Dec 2021 21:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640296515;
        bh=NwAHAzWkVhpvKi7Wfo4ukOyedvley1Ug2shyJU22PxE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R4l0IR6/vk6KRJi9GuAANoW0zxStx14mfDpfZ3Z573X41EbwGPtHFS+GnrNh2uDCb
         6q8RasSkLwHY88sRcWgEQf865aZTeHCIF1II2nxIyfW/CCb3sl+GvCD5DfyimydK+5
         na+bVlqCD+MlfrkufuVbggCY4NE+RW7hIoLQ0tC2jfmoadwkDBwv0td2D+1N0Cl7UX
         aO9Vyql7QhiCFD0mkdy0FisKOiUdwJq38b2qm1n5E4F/goJURTZPph3ZzNSJn+GVuf
         zL6ufOTO7uJ63yTY4HHGiYz9bUcxvLC3HxeqZaYZ37HMLjcjefTuSyRoRbgkmRwJ/C
         KNxp5uzujsyRA==
Date:   Thu, 23 Dec 2021 22:55:11 +0100
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Bo Jiao <bo.jiao@mediatek.com>
Cc:     Felix Fietkau <nbd@nbd.name>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Xing Song <xing.song@mediatek.com>,
        Sujuan Chen <sujuan.chen@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH 1/1] mt76: add mt7916 to set wlan_idx_hi
Message-ID: <YcTwP6Hu5VoTMHEq@lore-desk>
References: <cover.1640175865.git.Bo.Jiao@mediatek.com>
 <5b82d68ee7c879591e22da51bfdb4af2e5fad228.1640175865.git.Bo.Jiao@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ceznv8vUbhznFNWi"
Content-Disposition: inline
In-Reply-To: <5b82d68ee7c879591e22da51bfdb4af2e5fad228.1640175865.git.Bo.Jiao@mediatek.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--ceznv8vUbhznFNWi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: Bo Jiao <Bo.Jiao@mediatek.com>
>=20
> since mt7916 support up to 544 wcid entries,
> add it to set wlan_idx_hi.
>=20
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
> Signed-off-by: Bo Jiao <Bo.Jiao@mediatek.com>
> ---
>  drivers/net/wireless/mediatek/mt76/mt76_connac.h     | 5 +++++
>  drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h | 2 +-
>  2 files changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac.h b/drivers/n=
et/wireless/mediatek/mt76/mt76_connac.h
> index e999d71..8701f04 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76_connac.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
> @@ -110,6 +110,11 @@ static inline bool is_mt7915(struct mt76_dev *dev)
>  	return mt76_chip(dev) =3D=3D 0x7915;
>  }
> =20
> +static inline bool is_mt7916(struct mt76_dev *dev)
> +{
> +	return mt76_chip(dev) =3D=3D 0x7906;
> +}
> +
>  static inline u8 mt76_connac_chan_bw(struct cfg80211_chan_def *chandef)
>  {
>  	static const u8 width_to_bw[] =3D {
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drive=
rs/net/wireless/mediatek/mt76/mt76_connac_mcu.h
> index edad583..fc9a084 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
> @@ -1464,7 +1464,7 @@ mt76_connac_mcu_get_wlan_idx(struct mt76_dev *dev, =
struct mt76_wcid *wcid,
>  {
>  	*wlan_idx_hi =3D 0;
> =20
> -	if (is_mt7921(dev) || is_mt7915(dev)) {
> +	if (is_mt7921(dev) || is_mt7915(dev) || is_mt7916(dev)) {
>  		*wlan_idx_lo =3D wcid ? to_wcid_lo(wcid->idx) : 0;
>  		*wlan_idx_hi =3D wcid ? to_wcid_hi(wcid->idx) : 0;

I guess I have already included the fix here:
https://patchwork.kernel.org/project/linux-wireless/patch/df4d462f1ef4cfc1a=
e4f6482051a28a10c78262b.1640260901.git.lorenzo@kernel.org/

Regards,
Lorenzo

>  	} else {
> --=20
> 2.18.0
>=20

--ceznv8vUbhznFNWi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYcTwPwAKCRA6cBh0uS2t
rCPcAQCr/p0C/RnsjkSJjTopA5nKQTY2CUKmdRS//yflEvUnAAD/YuuBNRLO4D0L
8Sidc+yynctBR6QF5F+dvJUo2sUTzQg=
=6Ahn
-----END PGP SIGNATURE-----

--ceznv8vUbhznFNWi--
