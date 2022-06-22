Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA0E65549CE
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Jun 2022 14:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242073AbiFVMLa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 22 Jun 2022 08:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbiFVML3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 22 Jun 2022 08:11:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 573563DA55
        for <linux-wireless@vger.kernel.org>; Wed, 22 Jun 2022 05:11:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0C752B81E35
        for <linux-wireless@vger.kernel.org>; Wed, 22 Jun 2022 12:11:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F506C3411B;
        Wed, 22 Jun 2022 12:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655899885;
        bh=ySEhGBP4dL5OJFL8JLdXSfxY0+baNjQznRJbeJ1nnXI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IJRCKpl7gh6jCLVilJGRem27SdxkwCYkXQcbDEM0WspKNf1cgWyUMgvsBsmvlEN0b
         uitlF3vIwXyY+EyBtt2mxPWc+GL4lfeLjdjF2Vw92xSBDRD4tEhuKR+1B5/sSEMf9y
         /+zoL2g5Sw9Z+j/FM97OrEnVxB9YiocTrduLa6epsAry0w1NSwONqSGRAGX3ZMIsvo
         Qg3teKboW7nBk2vDA5CPWlVyIR96a8CLQwPh2emH8oKZax3Ft2mw671BG2VZVFP8xj
         OKpYySak/OB7vtz2OcNcBlL0KC3BrTQZYVlQAaTDjUFBGHG1pfGwiPe09bhdO5Bb7e
         95LnrriABOXWg==
Date:   Wed, 22 Jun 2022 14:11:21 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, deren.wu@mediatek.com,
        ryder.lee@mediatek.com
Subject: Re: [PATCH 2/6] mt76: move mt7615_txp_ptr in mt76_connac module
Message-ID: <YrMG6caJqbCx1b2+@localhost.localdomain>
References: <cover.1655649421.git.lorenzo@kernel.org>
 <c5a0f03bc5ca1e994bb6010033058d07848bef0c.1655649422.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Fw66DQZwoHHlAc0n"
Content-Disposition: inline
In-Reply-To: <c5a0f03bc5ca1e994bb6010033058d07848bef0c.1655649422.git.lorenzo@kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--Fw66DQZwoHHlAc0n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[...]

> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7921/pci.c
> index 624eb75c15cd..dde7709edc6c 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
> @@ -230,7 +230,7 @@ static int mt7921_pci_probe(struct pci_dev *pdev,
>  {
>  	static const struct mt76_driver_ops drv_ops =3D {
>  		/* txwi_size =3D txd size + txp size */
> -		.txwi_size =3D MT_TXD_SIZE + sizeof(struct mt7921_txp_common),
> +		.txwi_size =3D MT_TXD_SIZE + sizeof(struct mt76_connac_txp_common),

I spotted a minor issue in this patch, we should use mt76_connac_hw_txp her=
e.
@Felix: please drop this patch, I will post v2 soon.

Regards,
Lorenzo

>  		.drv_flags =3D MT_DRV_TXWI_NO_FREE | MT_DRV_HW_MGMT_TXQ,
>  		.survey_flags =3D SURVEY_INFO_TIME_TX |
>  				SURVEY_INFO_TIME_RX |
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c b/driver=
s/net/wireless/mediatek/mt76/mt7921/pci_mac.c
> index 9608b5ae8820..8e051bdae673 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci_mac.c
> @@ -9,8 +9,8 @@ static void
>  mt7921_write_hw_txp(struct mt7921_dev *dev, struct mt76_tx_info *tx_info,
>  		    void *txp_ptr, u32 id)
>  {
> -	struct mt7921_hw_txp *txp =3D txp_ptr;
> -	struct mt7921_txp_ptr *ptr =3D &txp->ptr[0];
> +	struct mt76_connac_hw_txp *txp =3D txp_ptr;
> +	struct mt76_connac_txp_ptr *ptr =3D &txp->ptr[0];
>  	int i, nbuf =3D tx_info->nbuf - 1;
> =20
>  	tx_info->buf[0].len =3D MT_TXD_SIZE + sizeof(*txp);
> @@ -44,8 +44,8 @@ int mt7921e_tx_prepare_skb(struct mt76_dev *mdev, void =
*txwi_ptr,
>  	struct mt7921_dev *dev =3D container_of(mdev, struct mt7921_dev, mt76);
>  	struct ieee80211_tx_info *info =3D IEEE80211_SKB_CB(tx_info->skb);
>  	struct ieee80211_key_conf *key =3D info->control.hw_key;
> +	struct mt76_connac_txp_common *txp;
>  	struct mt76_txwi_cache *t;
> -	struct mt7921_txp_common *txp;
>  	int id, pid;
>  	u8 *txwi =3D (u8 *)txwi_ptr;
> =20
> @@ -75,8 +75,8 @@ int mt7921e_tx_prepare_skb(struct mt76_dev *mdev, void =
*txwi_ptr,
>  	mt76_connac2_mac_write_txwi(mdev, txwi_ptr, tx_info->skb, wcid, key,
>  				    pid, 0);
> =20
> -	txp =3D (struct mt7921_txp_common *)(txwi + MT_TXD_SIZE);
> -	memset(txp, 0, sizeof(struct mt7921_txp_common));
> +	txp =3D (struct mt76_connac_txp_common *)(txwi + MT_TXD_SIZE);
> +	memset(txp, 0, sizeof(struct mt76_connac_txp_common));
>  	mt7921_write_hw_txp(dev, tx_info, txp, id);
> =20
>  	tx_info->skb =3D DMA_DUMMY_DATA;
> @@ -87,13 +87,13 @@ int mt7921e_tx_prepare_skb(struct mt76_dev *mdev, voi=
d *txwi_ptr,
>  static void
>  mt7921_txp_skb_unmap(struct mt76_dev *dev, struct mt76_txwi_cache *t)
>  {
> -	struct mt7921_txp_common *txp;
> +	struct mt76_connac_txp_common *txp;
>  	int i;
> =20
>  	txp =3D mt76_connac_txwi_to_txp(dev, t);
> =20
>  	for (i =3D 0; i < ARRAY_SIZE(txp->hw.ptr); i++) {
> -		struct mt7921_txp_ptr *ptr =3D &txp->hw.ptr[i];
> +		struct mt76_connac_txp_ptr *ptr =3D &txp->hw.ptr[i];
>  		bool last;
>  		u16 len;
> =20
> @@ -271,8 +271,8 @@ void mt7921e_tx_complete_skb(struct mt76_dev *mdev, s=
truct mt76_queue_entry *e)
> =20
>  	/* error path */
>  	if (e->skb =3D=3D DMA_DUMMY_DATA) {
> +		struct mt76_connac_txp_common *txp;
>  		struct mt76_txwi_cache *t;
> -		struct mt7921_txp_common *txp;
>  		u16 token;
> =20
>  		txp =3D mt76_connac_txwi_to_txp(mdev, e->txwi);
> --=20
> 2.36.1
>=20

--Fw66DQZwoHHlAc0n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYrMG5gAKCRA6cBh0uS2t
rFt6AQCciFquvHEILXt+x2NOt/VrBbzrcKzyIjwmT3oZcV+uXgEAuHaUjrUr85cl
FQq3u8b0fW6s6NWTSM/O0j/2c67qQA0=
=Ylor
-----END PGP SIGNATURE-----

--Fw66DQZwoHHlAc0n--
