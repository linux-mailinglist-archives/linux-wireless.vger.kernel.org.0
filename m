Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28C31585477
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Jul 2022 19:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236263AbiG2R0v (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 29 Jul 2022 13:26:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232888AbiG2R0u (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 29 Jul 2022 13:26:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6DD111472
        for <linux-wireless@vger.kernel.org>; Fri, 29 Jul 2022 10:26:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4C11661EC0
        for <linux-wireless@vger.kernel.org>; Fri, 29 Jul 2022 17:26:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C038C433D6;
        Fri, 29 Jul 2022 17:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659115607;
        bh=TTETB8o7PvQdP2mX6Ys+iLsrFmlIEx9xlCqi+ww3iz8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mEp2i0yO10ftohBAY8DWk0IaVKxuui91sT2nh87qBhawO10UMafu9r0Dx8cEjWVT1
         KW7ik3QLGiXbmEut0/bS5c86tUmxFFdlLarCGSxtCHPRX/cdkiUwJPT/JsOiTOB53s
         JaWDX04KiOB7E1zb6IvYxtEhWs9ESdR1eJFqZich1t+Fp1PGhvwqArekbDXVGNQnbN
         BeKvNbPJiin7+BOcyvhbESpgLu9A0zmD1HQymp+ygO5IAA9L/YBcolY1Mm9KgTE36Y
         47/PsYayw1+6KHcg34YMEFxIcdWGQ1kLgjsNC/uGIlZZk8+GaswyiHlrU4+kCYJuYR
         iI3ITF0b9YI4w==
Date:   Fri, 29 Jul 2022 19:26:43 +0200
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
Subject: Re: [PATCH RESEND v2 1/2] mt76: mt7921: add mt7921_mutex_acquire at
 mt7921_[start, stop]_ap
Message-ID: <YuQYU2SxIyHvIODd@lore-desk>
References: <6353fe62ebeb0f78aa34b40e9c1745061b229f6c.1659105379.git.objelf@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="QR/FOKVDFLb314yh"
Content-Disposition: inline
In-Reply-To: <6353fe62ebeb0f78aa34b40e9c1745061b229f6c.1659105379.git.objelf@gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--QR/FOKVDFLb314yh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: Sean Wang <sean.wang@mediatek.com>
>=20
> Add mt7921_mutex_acquire at mt7921_[start, stop]_ap to fix the race
> with the context holding dev->muxtex and the driver might access the
> device in low power state.
>=20
> Fixes: 9d958b60ebc2 ("mt76: mt7921: fix command timeout in AP stop period=
")
> Tested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabor=
a.com>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>

Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

> ---
> v2: use "out" label instead and add the Tested-by tag from AngeloGioacchi=
no
> ---
>  .../net/wireless/mediatek/mt76/mt7921/main.c  | 21 ++++++++++++++-----
>  1 file changed, 16 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/n=
et/wireless/mediatek/mt76/mt7921/main.c
> index 1438a9f8d1fd..63fd33dcd3af 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
> @@ -1526,17 +1526,23 @@ mt7921_start_ap(struct ieee80211_hw *hw, struct i=
eee80211_vif *vif,
>  	struct mt7921_dev *dev =3D mt7921_hw_dev(hw);
>  	int err;
> =20
> +	mt7921_mutex_acquire(dev);
> +
>  	err =3D mt76_connac_mcu_uni_add_bss(phy->mt76, vif, &mvif->sta.wcid,
>  					  true);
>  	if (err)
> -		return err;
> +		goto out;
> =20
>  	err =3D mt7921_mcu_set_bss_pm(dev, vif, true);
>  	if (err)
> -		return err;
> +		goto out;
> +
> +	err =3D mt7921_mcu_sta_update(dev, NULL, vif, true,
> +				    MT76_STA_INFO_STATE_NONE);
> +out:
> +	mt7921_mutex_release(dev);
> =20
> -	return mt7921_mcu_sta_update(dev, NULL, vif, true,
> -				     MT76_STA_INFO_STATE_NONE);
> +	return err;
>  }
> =20
>  static void
> @@ -1548,11 +1554,16 @@ mt7921_stop_ap(struct ieee80211_hw *hw, struct ie=
ee80211_vif *vif,
>  	struct mt7921_dev *dev =3D mt7921_hw_dev(hw);
>  	int err;
> =20
> +	mt7921_mutex_acquire(dev);
> +
>  	err =3D mt7921_mcu_set_bss_pm(dev, vif, false);
>  	if (err)
> -		return;
> +		goto out;
> =20
>  	mt76_connac_mcu_uni_add_bss(phy->mt76, vif, &mvif->sta.wcid, false);
> +
> +out:
> +	mt7921_mutex_release(dev);
>  }
> =20
>  const struct ieee80211_ops mt7921_ops =3D {
> --=20
> 2.25.1
>=20

--QR/FOKVDFLb314yh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYuQYUwAKCRA6cBh0uS2t
rFYcAQC6fw/AttTCMgPr9rVM0wmTBsyrie78IoSnVZuckMiTowD/XAqFayOYJfR5
7SHvc7DoQBYK1I1uiYWy6SiuAewu5wQ=
=YI9g
-----END PGP SIGNATURE-----

--QR/FOKVDFLb314yh--
