Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC2CB57FABF
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Jul 2022 10:00:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233617AbiGYIAv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 Jul 2022 04:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233472AbiGYIAn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Jul 2022 04:00:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E678E6354
        for <linux-wireless@vger.kernel.org>; Mon, 25 Jul 2022 01:00:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 25E3BB80DEC
        for <linux-wireless@vger.kernel.org>; Mon, 25 Jul 2022 08:00:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61A87C341CE;
        Mon, 25 Jul 2022 08:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658736016;
        bh=M+ANK6zycupl8wyudZ7dhCND90FRLPpFDVsiA2vFXRE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U8ig1dzKzwvFUDI/byV4CpY6NemiZ0CmdTk88Wo1vhwcqaEOOaA3RJ/WIRijVfJYi
         KoME5KcoIBVOOfnPdbf+YrSR8IAcKGhMWmMH+0oX/gF8bq1X++SL6MtKttCLsN2Ed3
         Szof9qPy/TdW5j2Y85vC/i83eKAg/OR2U1Lf4EF3L9hmzMQnrLzeW0jntmbVu9yYu4
         irkYPaiUkRv1WO3K9qYnCqvM5jsUBIBDhli/bxPd3+MOs0lMbC0c+T/eLhzdl4L2hr
         jcCKtQxq4zCz3xIbKnfDXig8wTPOaivmy3Fb1oLkA8lGcfYUxjZHCFyWicxzLlnpCJ
         hrS4vjOdxalSw==
Date:   Mon, 25 Jul 2022 10:00:13 +0200
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
Subject: Re: [PATCH 1/2] mt76: mt7921: add mt7921_mutex_acquire at
 mt7921_[start, stop]_ap
Message-ID: <Yt5NjVwFXt205J5n@lore-desk>
References: <acb86f6ecd2f446e4102a2ef2e7a9c0003ae8b46.1658641200.git.objelf@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uPKDG0+cIiilZ9Xi"
Content-Disposition: inline
In-Reply-To: <acb86f6ecd2f446e4102a2ef2e7a9c0003ae8b46.1658641200.git.objelf@gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--uPKDG0+cIiilZ9Xi
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
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
>  .../net/wireless/mediatek/mt76/mt7921/main.c  | 21 ++++++++++++++-----
>  1 file changed, 16 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/n=
et/wireless/mediatek/mt76/mt7921/main.c
> index 1438a9f8d1fd..7a4a3ed1817e 100644
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
> +		goto failed;
> =20
>  	err =3D mt7921_mcu_set_bss_pm(dev, vif, true);
>  	if (err)
> -		return err;
> +		goto failed;
> +
> +	err =3D mt7921_mcu_sta_update(dev, NULL, vif, true,
> +				    MT76_STA_INFO_STATE_NONE);

nit: maybe better "out" instead of "failed"

> +failed:
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
> +		goto failed;
> =20
>  	mt76_connac_mcu_uni_add_bss(phy->mt76, vif, &mvif->sta.wcid, false);
> +
> +failed:

same here

> +	mt7921_mutex_release(dev);
>  }
> =20
>  const struct ieee80211_ops mt7921_ops =3D {
> --=20
> 2.25.1
>=20

--uPKDG0+cIiilZ9Xi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYt5NjQAKCRA6cBh0uS2t
rDdPAQDBI7y1gnpJ3qTOGAeOxSdJsoKxplc8uReMZh8HH/dXvQD/RBclGvQ3mMPW
AkOpg5aytWACHqSzpNkNGHXiwXL9GQY=
=fWlh
-----END PGP SIGNATURE-----

--uPKDG0+cIiilZ9Xi--
