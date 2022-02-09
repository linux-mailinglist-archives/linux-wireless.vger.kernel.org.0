Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E7564AEE7A
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Feb 2022 10:53:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230476AbiBIJxI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Feb 2022 04:53:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiBIJxG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Feb 2022 04:53:06 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46C5FE076BEE
        for <linux-wireless@vger.kernel.org>; Wed,  9 Feb 2022 01:52:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2A229B81FE6
        for <linux-wireless@vger.kernel.org>; Wed,  9 Feb 2022 09:50:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C41CC340E7;
        Wed,  9 Feb 2022 09:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644400214;
        bh=RWtSMPPceppQlAn2mTe0OWVWuydONf0VJUEJWn8Ef1w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DYEoC/2mbxJZmcNqhbwWP+AebJ1sQQKpMuOLw0AMgUetcY0kQBpUwbC084l367Yxv
         s81FtIrqb3qKWIL6dm67G1u3pq8DDpgKlvRcUuSOBmLOUJeKbyUbeMRwaD/bgZCwhN
         z0ELb1WNuIemms7W4XlarZJqLOWi1CaY+fD2JOAQ+115m/pm5F485G4XMRBzyZKLFJ
         Qina0q3EnQeu2ZO6qLYyqLKnwnahK01XnJgZQknirY6+szMEfVRAGDfIXU4LE2ZGWl
         /ASBODAdm+y6DPNpUNMwbdWszAOuSv3Bi1HZo6cwUgZuZbz4kSozsjrN6Cof7G5xgT
         mpuZLK6JWH+3A==
Date:   Wed, 9 Feb 2022 10:50:10 +0100
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Deren Wu <Deren.Wu@mediatek.com>
Cc:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Soul Huang <Soul.Huang@mediatek.com>,
        YN Chen <YN.Chen@mediatek.com>,
        Leon Yen <Leon.Yen@mediatek.com>,
        Eric-SY Chang <Eric-SY.Chang@mediatek.com>,
        KM Lin <km.lin@mediatek.com>,
        Robin Chiu <robin.chiu@mediatek.com>,
        CH Yeh <ch.yeh@mediatek.com>, Posh Sun <posh.sun@mediatek.com>,
        Eric Liang <Eric.Liang@mediatek.com>,
        Stella Chang <Stella.Chang@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH v2] mt76: mt7921s: fix missing fc type/sub-type for
 802.11 pkts
Message-ID: <YgOOUlK3ecD4nnP4@lore-desk>
References: <41839f21510756e08919ae7930212817e37f40f0.1644370695.git.deren.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="SOFrcjsGoBJ5ESGP"
Content-Disposition: inline
In-Reply-To: <41839f21510756e08919ae7930212817e37f40f0.1644370695.git.deren.wu@mediatek.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--SOFrcjsGoBJ5ESGP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: Deren Wu <deren.wu@mediatek.com>
>=20
> For non-mmio devices, should set fc values to proper txwi config
>=20
> Fixes: 48fab5bbef40 ("mt76: mt7921: introduce mt7921s support")
> Tested-by: Sean Wang <sean.wang@mediatek.com>
> Co-developed-by: Leon Yen <Leon.Yen@mediatek.com>
> Signed-off-by: Leon Yen <Leon.Yen@mediatek.com>
> Signed-off-by: Deren Wu <deren.wu@mediatek.com>

Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

> ---
> v2: remove is_mmio which is just used once
> ---
>  drivers/net/wireless/mediatek/mt76/mt7921/mac.c | 12 +++++++++---
>  drivers/net/wireless/mediatek/mt76/mt7921/mac.h |  3 +++
>  2 files changed, 12 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7921/mac.c
> index d17558349a17..f0ebee670131 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
> @@ -912,9 +912,15 @@ mt7921_mac_write_txwi_80211(struct mt7921_dev *dev, =
__le32 *txwi,
>  		txwi[3] |=3D cpu_to_le32(val);
>  	}
> =20
> -	val =3D FIELD_PREP(MT_TXD7_TYPE, fc_type) |
> -	      FIELD_PREP(MT_TXD7_SUB_TYPE, fc_stype);
> -	txwi[7] |=3D cpu_to_le32(val);
> +	if (mt76_is_mmio(&dev->mt76)) {
> +		val =3D FIELD_PREP(MT_TXD7_TYPE, fc_type) |
> +		      FIELD_PREP(MT_TXD7_SUB_TYPE, fc_stype);
> +		txwi[7] |=3D cpu_to_le32(val);
> +	} else {
> +		val =3D FIELD_PREP(MT_TXD8_L_TYPE, fc_type) |
> +		      FIELD_PREP(MT_TXD8_L_SUB_TYPE, fc_stype);
> +		txwi[8] |=3D cpu_to_le32(val);
> +	}
>  }
> =20
>  void mt7921_mac_write_txwi(struct mt7921_dev *dev, __le32 *txwi,
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.h b/drivers/ne=
t/wireless/mediatek/mt76/mt7921/mac.h
> index 544a1c33126a..12e1cf8abe6e 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.h
> @@ -284,6 +284,9 @@ enum tx_mcu_port_q_idx {
>  #define MT_TXD7_HW_AMSDU		BIT(10)
>  #define MT_TXD7_TX_TIME			GENMASK(9, 0)
> =20
> +#define MT_TXD8_L_TYPE			GENMASK(5, 4)
> +#define MT_TXD8_L_SUB_TYPE		GENMASK(3, 0)
> +
>  #define MT_TX_RATE_STBC			BIT(13)
>  #define MT_TX_RATE_NSS			GENMASK(12, 10)
>  #define MT_TX_RATE_MODE			GENMASK(9, 6)
> --=20
> 2.18.0
>=20

--SOFrcjsGoBJ5ESGP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYgOOUgAKCRA6cBh0uS2t
rDgFAQCKVV6wy0e3mQL7KQMgMRadvxPkkH5xuYR6EIkI15X8dwD6AohdqxqC4JRr
t8Reqwcwiixk2+8yrVmuTf9o9Bn9Kww=
=13c3
-----END PGP SIGNATURE-----

--SOFrcjsGoBJ5ESGP--
