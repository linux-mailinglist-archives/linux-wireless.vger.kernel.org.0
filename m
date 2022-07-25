Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0B0057FAFD
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Jul 2022 10:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233251AbiGYILE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 Jul 2022 04:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232082AbiGYILC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Jul 2022 04:11:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7722113CCB
        for <linux-wireless@vger.kernel.org>; Mon, 25 Jul 2022 01:11:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2A017B80DFD
        for <linux-wireless@vger.kernel.org>; Mon, 25 Jul 2022 08:11:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42975C341C6;
        Mon, 25 Jul 2022 08:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658736658;
        bh=k8xhLHCz3oUMcRpGF3e9jxuqOsueg5bn21ox6JISRtw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ERkoQNPTMPtjz3i79YEcC/+QEV8zRPz+8wYNeH/HzdwVBMtO/zlvbLTm5r7t3f9e6
         dAI1eduWKLraH+2FI0+9amVCPTkTD0XWi0pqwgM3YRFhUn/lw8Iw6/T5nMHccj4L46
         1LaslxUtAywpmDYW/i9se2SRyJWAARRygJLRFwSMgU3dJXod3qyo7fEUQyc0iOXpZj
         0xe9OOJ4EiiaO7IjwykYMxvhajwUbC/aBzxA2YembsyM4sHQy0FbHZdZ6Nss6UjBlx
         /n1NNYXde4HvxE2C4qntKNh4OeevB2iaNgRvAmUNjF3CvZQsSdZYEr5ARdU5xBjfSr
         yL8UgzakZeyLw==
Date:   Mon, 25 Jul 2022 10:10:55 +0200
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
Subject: Re: [PATCH 2/2] mt76: mt7921: add mt7921_mutex_acquire at
 mt7921_sta_set_decap_offload
Message-ID: <Yt5QDwm7FNPxj2CM@lore-desk>
References: <acb86f6ecd2f446e4102a2ef2e7a9c0003ae8b46.1658641200.git.objelf@gmail.com>
 <02ef9b9464024d2375caf598ae7c6b1e8e8e20de.1658641200.git.objelf@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="T2kgB8bWfD2P6HT/"
Content-Disposition: inline
In-Reply-To: <02ef9b9464024d2375caf598ae7c6b1e8e8e20de.1658641200.git.objelf@gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--T2kgB8bWfD2P6HT/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: Sean Wang <sean.wang@mediatek.com>
>=20
> Add mt7921_mutex_acquire at mt7921_[start, stop]_ap to fix the race
> with the context holding dev->muxtex and the driver might access the
> device in low power state.
>=20
> Fixes: 24299fc869f7 ("mt76: mt7921: enable rx header traslation offload")
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>

Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

> ---
>  drivers/net/wireless/mediatek/mt76/mt7921/main.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/n=
et/wireless/mediatek/mt76/mt7921/main.c
> index 7a4a3ed1817e..0d1b17e439dc 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
> @@ -1404,6 +1404,8 @@ static void mt7921_sta_set_decap_offload(struct iee=
e80211_hw *hw,
>  	struct mt7921_sta *msta =3D (struct mt7921_sta *)sta->drv_priv;
>  	struct mt7921_dev *dev =3D mt7921_hw_dev(hw);
> =20
> +	mt7921_mutex_acquire(dev);
> +
>  	if (enabled)
>  		set_bit(MT_WCID_FLAG_HDR_TRANS, &msta->wcid.flags);
>  	else
> @@ -1411,6 +1413,8 @@ static void mt7921_sta_set_decap_offload(struct iee=
e80211_hw *hw,
> =20
>  	mt76_connac_mcu_sta_update_hdr_trans(&dev->mt76, vif, &msta->wcid,
>  					     MCU_UNI_CMD(STA_REC_UPDATE));
> +
> +	mt7921_mutex_release(dev);
>  }
> =20
>  #if IS_ENABLED(CONFIG_IPV6)
> --=20
> 2.25.1
>=20

--T2kgB8bWfD2P6HT/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYt5QDgAKCRA6cBh0uS2t
rKDLAQDJSgEuAPWrrbsgIEDAYgBeimgvB7ya5R5qpINHW7/l4AEA1NTpWRg/Etb2
WZQokgeN6fjZjd37BcXID/UgyUe3bgs=
=wWb+
-----END PGP SIGNATURE-----

--T2kgB8bWfD2P6HT/--
