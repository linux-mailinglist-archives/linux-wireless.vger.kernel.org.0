Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01A7945730F
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Nov 2021 17:33:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236503AbhKSQgb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 19 Nov 2021 11:36:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:41826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234515AbhKSQgb (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 19 Nov 2021 11:36:31 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 916A661B1E;
        Fri, 19 Nov 2021 16:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637339609;
        bh=nScAo5n6e6SqOKYQkfL+ql80CPrujBLoCjMftmtbrkA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FzojX9zC3WQ0f3NLQPYWLojOAc2j5LZLBNEDVuIKREPMN1rZC4BwgWiNbvh0Nb65O
         Uxq+EHpDDRCWJzcY7FItyWERGLxkSWHlVRBYsPkEvtwBuyeSD1ZduUw28AjkHat0Ip
         o763bOHB4yeC6eRf8iZYwbnVRtHqBNc474SI0OEl6ebFG3JrxkS/kARCGw5WkQ3D71
         KWBVzfBg+JYSUNbiRKAYtiqRXSC2DpvQU1R+74ka8txq0QoHicbFkno3PWoak1WMlh
         CEL4DcD8bzR/4Ct4sKyFGzXKE2cH1tSOgw4+6x0aK/OiTy9C34ZWStR+BIfNBMPb9P
         rQcBu2dkzYcyA==
Date:   Fri, 19 Nov 2021 17:33:25 +0100
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     greearb@candelatech.com
Cc:     linux-wireless@vger.kernel.org
Subject: Re: [PATCH 01/11] mt76: mt7915: add comments about rx descriptor
 parsing
Message-ID: <YZfR1d2I6pqEzqT8@lore-desk>
References: <20211118164056.2965-1-greearb@candelatech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="0FfbtbBfAKSAYCVv"
Content-Disposition: inline
In-Reply-To: <20211118164056.2965-1-greearb@candelatech.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--0FfbtbBfAKSAYCVv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: Ben Greear <greearb@candelatech.com>
>=20
> This is a tricky beast to understand, so add some notes for
> next time someone is looking at this code and trying to compare
> against documents.
>=20
> Signed-off-by: Ben Greear <greearb@candelatech.com>
> ---
>=20
> txs and related patches rebased on top of 5.16
>=20
>  .../net/wireless/mediatek/mt76/mt7915/mac.c   | 23 +++++++++++++++----
>  1 file changed, 18 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7915/mac.c
> index 8e5b87af2efb..6fbd58ae9c88 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
> @@ -410,6 +410,7 @@ mt7915_mac_fill_rx(struct mt7915_dev *dev, struct sk_=
buff *skb)
>  	__le32 *rxd =3D (__le32 *)skb->data;
>  	__le32 *rxv =3D NULL;
>  	u32 mode =3D 0;
> +	/* table "PP -> HOST / X-CPU"  RX Format */
>  	u32 rxd0 =3D le32_to_cpu(rxd[0]);
>  	u32 rxd1 =3D le32_to_cpu(rxd[1]);
>  	u32 rxd2 =3D le32_to_cpu(rxd[2]);
> @@ -489,7 +490,7 @@ mt7915_mac_fill_rx(struct mt7915_dev *dev, struct sk_=
buff *skb)
> =20
>  	rxd +=3D 6;
>  	if (rxd1 & MT_RXD1_NORMAL_GROUP_4) {
> -		u32 v0 =3D le32_to_cpu(rxd[0]);
> +		u32 v0 =3D le32_to_cpu(rxd[0]); /* DW6 */
>  		u32 v2 =3D le32_to_cpu(rxd[2]);
> =20
>  		fc =3D cpu_to_le16(FIELD_GET(MT_RXD6_FRAME_CONTROL, v0));
> @@ -502,6 +503,7 @@ mt7915_mac_fill_rx(struct mt7915_dev *dev, struct sk_=
buff *skb)
>  	}
> =20
>  	if (rxd1 & MT_RXD1_NORMAL_GROUP_1) {
> +		/* DW10, assuming Group-4 enabled */
>  		u8 *data =3D (u8 *)rxd;
> =20
>  		if (status->flag & RX_FLAG_DECRYPTED) {
> @@ -533,6 +535,7 @@ mt7915_mac_fill_rx(struct mt7915_dev *dev, struct sk_=
buff *skb)
>  	}
> =20
>  	if (rxd1 & MT_RXD1_NORMAL_GROUP_2) {
> +		/* DW14, assuming group-1,4 */
>  		status->timestamp =3D le32_to_cpu(rxd[0]);
>  		status->flag |=3D RX_FLAG_MACTIME_START;
> =20
> @@ -558,18 +561,22 @@ mt7915_mac_fill_rx(struct mt7915_dev *dev, struct s=
k_buff *skb)
>  	if (rxd1 & MT_RXD1_NORMAL_GROUP_3) {
>  		u32 v0, v1, v2;
> =20
> -		rxv =3D rxd;
> +		rxv =3D rxd; /* DW16 assuming group 1,2,3,4 */
>  		rxd +=3D 2;
>  		if ((u8 *)rxd - skb->data >=3D skb->len)
>  			return -EINVAL;
> =20
> -		v0 =3D le32_to_cpu(rxv[0]);
> +		v0 =3D le32_to_cpu(rxv[0]);  /* DW16, P-VEC1 31:0 */
> +		/* DW17, RX_RCPI copied over P-VEC 64:32 Per RX Format doc. */

This seems not so useful for everybody.

>  		v1 =3D le32_to_cpu(rxv[1]);
> -		v2 =3D le32_to_cpu(rxv[2]);
> +		v2 =3D le32_to_cpu(rxv[2]); /* first DW of group-5, C-RXV */
> =20
>  		if (v0 & MT_PRXV_HT_AD_CODE)
>  			status->enc_flags |=3D RX_ENC_FLAG_LDPC;
> =20
> +		/* TODO:  When group-5 is enabled, use nss (and stbc) to
> +		 * calculate chains properly for this particular skb.
> +		 */
>  		status->chains =3D mphy->antenna_mask;
>  		status->chain_signal[0] =3D to_rssi(MT_PRXV_RCPI0, v1);
>  		status->chain_signal[1] =3D to_rssi(MT_PRXV_RCPI1, v1);
> @@ -581,12 +588,18 @@ mt7915_mac_fill_rx(struct mt7915_dev *dev, struct s=
k_buff *skb)
>  			if (!(status->chains & BIT(i)))
>  				continue;
> =20
> +			/* TODO:  Use db sum logic instead of max. */

This seems just a not for you :)

>  			status->signal =3D max(status->signal,
>  					     status->chain_signal[i]);
>  		}
> =20
> -		/* RXD Group 5 - C-RXV */
> +		/* RXD Group 5 - C-RXV.
> +		 * Group 5 Not currently enabled for 7915 except in
> +		 * monitor mode.
> +		 *   See MT_DMA_DCR0_RXD_G5_EN
> +		 */
>  		if (rxd1 & MT_RXD1_NORMAL_GROUP_5) {
> +			/* See RXV document ... */

This is not so useful :)

>  			u8 stbc =3D FIELD_GET(MT_CRXV_HT_STBC, v2);
>  			u8 gi =3D FIELD_GET(MT_CRXV_HT_SHORT_GI, v2);
>  			bool cck =3D false;
> --=20
> 2.20.1
>=20

--0FfbtbBfAKSAYCVv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYZfR1QAKCRA6cBh0uS2t
rHvWAQCT8Txs2c+1SWxkL8dc/cQUfu7IErpEY7i5j6SKBBTJqgEAn4M2Xkjx7vjP
0UFSVvc4lBmeRbEnCf2TrT45RoydPgs=
=ssw4
-----END PGP SIGNATURE-----

--0FfbtbBfAKSAYCVv--
