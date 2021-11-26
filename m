Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D47845F00A
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Nov 2021 15:40:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377832AbhKZOnj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 26 Nov 2021 09:43:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352938AbhKZOli (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 26 Nov 2021 09:41:38 -0500
X-Greylist: delayed 566 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 26 Nov 2021 06:11:38 PST
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90EE5C0698DC
        for <linux-wireless@vger.kernel.org>; Fri, 26 Nov 2021 06:11:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 97FDBB827E9
        for <linux-wireless@vger.kernel.org>; Fri, 26 Nov 2021 14:02:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A39E6C93056;
        Fri, 26 Nov 2021 14:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637935328;
        bh=B3b6FkCqKoRuHAJc8ef4v3ZpBQerGLnSidN6gMgf2gU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lk+He6tNs4vB5v5r4S4YmUgFlM7UbxtwBVBG2sIvsBXuwfiE6HXaGfV91UU6FsFGS
         IrRXKq6iuCtTT+VJmKgoaXNBoid+ygs6CJ1/q3pesDUD7QU8uJuS9uBjoHu/3aL9qu
         1FRSq/W77SXw4KiO2sVVADW7Je0E/dr/sa1/0iTwgdaNYdCr5AamWFzj6C8O3HteYz
         yG+CFK0f/7mhd4nldHrin+Q6J3JH5/tlcOQwbnaIauGW/SvG4VE5yAsTCuOqepA+b2
         TAKwJAPpujUBY/zWEJAvSxoqQGVwmFCB9R14vVgwNKn0+CPBYXv7eRwLD4a9Uh9f7O
         21nRpLsZvVmhA==
Date:   Fri, 26 Nov 2021 15:02:03 +0100
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     nbd@nbd.name, linux-wireless@vger.kernel.org,
        lorenzo.bianconi@redhat.com, sean.wang@mediatek.com,
        ryder.lee@mediatek.com
Subject: Re: [PATCH wireless-drivers] mt76: fix possible pktid leak
Message-ID: <YaDo21+/MBeeuTDN@lore-desk>
References: <a560caffcc24452fb48af53904bbe5c45ea5db93.1637602268.git.lorenzo@kernel.org>
 <163777451567.4686.3609119971518562275.kvalo@codeaurora.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="S9AIYEuM7HvSKYM9"
Content-Disposition: inline
In-Reply-To: <163777451567.4686.3609119971518562275.kvalo@codeaurora.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--S9AIYEuM7HvSKYM9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Lorenzo Bianconi <lorenzo@kernel.org> wrote:
>=20
> > Fix a possible idr pkt-id leak if the packet is dropped on tx side
> >=20
> > Fixes: bd1e3e7b693c ("mt76: introduce packet_id idr")
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > Acked-by: Felix Fietkau <nbd@nbd.name>
>=20
> Patch applied to wireless-drivers.git, thanks.
>=20
> 2a9e9857473b mt76: fix possible pktid leak

Hi Kalle,

Unfortunately I found a regression introduced by this patch for mt7663u (an=
d I
guess for mt7921s as well). Do you want me to post a fix or just a v2?
Sorry for the noise.

@Sean: can you please test the following patch on mt7921s? (I do not have t=
he hw).

Regards,
Lorenzo

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/usb_sdio.c b/drivers=
/net/wireless/mediatek/mt76/mt7615/usb_sdio.c
index bfe6c1579dc1..c51c1d82083e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/usb_sdio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/usb_sdio.c
@@ -43,10 +43,9 @@ EXPORT_SYMBOL_GPL(mt7663_usb_sdio_reg_map);
 static void
 mt7663_usb_sdio_write_txwi(struct mt7615_dev *dev, struct mt76_wcid *wcid,
 			   enum mt76_txq_id qid, struct ieee80211_sta *sta,
-			   int pid, struct sk_buff *skb)
+			   struct ieee80211_key_conf *key, int pid,
+			   struct sk_buff *skb)
 {
-	struct ieee80211_tx_info *info =3D IEEE80211_SKB_CB(skb);
-	struct ieee80211_key_conf *key =3D info->control.hw_key;
 	__le32 *txwi;
=20
 	txwi =3D (__le32 *)(skb->data - MT_USB_TXD_SIZE);
@@ -188,6 +187,7 @@ int mt7663_usb_sdio_tx_prepare_skb(struct mt76_dev *mde=
v, void *txwi_ptr,
 	struct mt7615_dev *dev =3D container_of(mdev, struct mt7615_dev, mt76);
 	struct sk_buff *skb =3D tx_info->skb;
 	struct ieee80211_tx_info *info =3D IEEE80211_SKB_CB(skb);
+	struct ieee80211_key_conf *key =3D info->control.hw_key;
 	struct mt7615_sta *msta;
 	int pad, err, pktid;
=20
@@ -205,7 +205,7 @@ int mt7663_usb_sdio_tx_prepare_skb(struct mt76_dev *mde=
v, void *txwi_ptr,
 	}
=20
 	pktid =3D mt76_tx_status_skb_add(&dev->mt76, wcid, skb);
-	mt7663_usb_sdio_write_txwi(dev, wcid, qid, sta, pktid, skb);
+	mt7663_usb_sdio_write_txwi(dev, wcid, qid, sta, key, pktid, skb);
 	if (mt76_is_usb(mdev)) {
 		u32 len =3D skb->len;
=20
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/sdio_mac.c b/drivers=
/net/wireless/mediatek/mt76/mt7921/sdio_mac.c
index 85b3d88f8ecc..c7d54e5c8392 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/sdio_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/sdio_mac.c
@@ -142,10 +142,9 @@ int mt7921s_mac_reset(struct mt7921_dev *dev)
 static void
 mt7921s_write_txwi(struct mt7921_dev *dev, struct mt76_wcid *wcid,
 		   enum mt76_txq_id qid, struct ieee80211_sta *sta,
-		   int pid, struct sk_buff *skb)
+		   struct ieee80211_key_conf *key, int pid,
+		   struct sk_buff *skb)
 {
-	struct ieee80211_tx_info *info =3D IEEE80211_SKB_CB(skb);
-	struct ieee80211_key_conf *key =3D info->control.hw_key;
 	__le32 *txwi;
=20
 	txwi =3D (__le32 *)(skb->data - MT_SDIO_TXD_SIZE);
@@ -161,6 +160,7 @@ int mt7921s_tx_prepare_skb(struct mt76_dev *mdev, void =
*txwi_ptr,
 {
 	struct mt7921_dev *dev =3D container_of(mdev, struct mt7921_dev, mt76);
 	struct ieee80211_tx_info *info =3D IEEE80211_SKB_CB(tx_info->skb);
+	struct ieee80211_key_conf *key =3D info->control.hw_key;
 	struct sk_buff *skb =3D tx_info->skb;
 	int err, pad, pktid;
=20
@@ -180,7 +180,7 @@ int mt7921s_tx_prepare_skb(struct mt76_dev *mdev, void =
*txwi_ptr,
 	}
=20
 	pktid =3D mt76_tx_status_skb_add(&dev->mt76, wcid, skb);
-	mt7921s_write_txwi(dev, wcid, qid, sta, pktid, skb);
+	mt7921s_write_txwi(dev, wcid, qid, sta, key, pktid, skb);
=20
 	mt7921_skb_add_sdio_hdr(skb, MT7921_SDIO_DATA);
 	pad =3D round_up(skb->len, 4) - skb->len;

>=20
> --=20
> https://patchwork.kernel.org/project/linux-wireless/patch/a560caffcc24452=
fb48af53904bbe5c45ea5db93.1637602268.git.lorenzo@kernel.org/
>=20
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpa=
tches
>=20

--S9AIYEuM7HvSKYM9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYaDo2wAKCRA6cBh0uS2t
rLGHAQDoEWCdu8pgBsEra+Q+zZfimm7Nd9o8cpJZIVB/sAb4KwEAoZNP3z7yYE5j
Wei6dEyWbPHuX5SJL5+qJN8GqgPTAwo=
=xHP9
-----END PGP SIGNATURE-----

--S9AIYEuM7HvSKYM9--
