Return-Path: <linux-wireless+bounces-27620-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11EEAB978FF
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Sep 2025 23:17:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03D381B22935
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Sep 2025 21:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ABC730C357;
	Tue, 23 Sep 2025 21:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ShhZvlNl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75652309F12
	for <linux-wireless@vger.kernel.org>; Tue, 23 Sep 2025 21:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758662233; cv=none; b=XfaQJXs+/EvqhwDWhEUjaoBL8uJo25Vbl4+q0h/Y97fdvhDOJZXCU3z/CNhK23/67yZjFf8VXrMcc5k3Zscn4fadtqvlL865tkJDHaTsId32rFdCw4SyLJEGcxVmReeeix4Hh6jlGtERz3lTJKnnp+5O+C+ItcVLmxDvlGGtjt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758662233; c=relaxed/simple;
	bh=KhG0/qESg8xPDoR7+Kobe0HbWaARTSDV/EuUPSYI44w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D1R/pFAIi8NhtxkOH7zfCZQ4zhkuKVpTMo0MQZb6N+S/e3w4Z87ylkcBoE5JNEbBHLiJF2ETxFZpetig4fEDFCCSTR+3gAIGpnu8wcE1SBHS0QdXzNmxk5sUcCg/eQmiyPPTe/dkzT+ULUsfBJFeIbKq4s1/YhJAJG5Urp2yzpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ShhZvlNl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4C8BC4CEF7;
	Tue, 23 Sep 2025 21:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758662233;
	bh=KhG0/qESg8xPDoR7+Kobe0HbWaARTSDV/EuUPSYI44w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ShhZvlNlbDChe70VBzOwJSqPz2to0XV/LLBOom8DyXx2SYgsQQym+8NXk0U3/SwID
	 v/2INSFZ/F6sUV5Bj+bQVYHtMD2fdSprHi5xi7o+qrRS0yGhG3i8cYx0H58nV/EUd7
	 yWZS1EU6ZTsp+fxaL9NGUeqL8JsJfptzLyT4s1pY14O4G0Fp0iShEm4ZVkY+anzJ61
	 b8de3pXLbP5Kihv8oS9PD7VS9c5CGjj680MHru4+44/bmKKSDMwJ7S9Zv6GsciPABC
	 LV84q0MiFjv6ZvYe4Rpf4kPhwreULPk5laxeHsSuho+VsrlEkbeA4kBX3G5HjVfuoN
	 kwP+U7Hg30wxw==
Date: Tue, 23 Sep 2025 23:17:10 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: linux-wireless@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [bug report] wifi: mt76: mt7996: Set proper link destination
 address in mt7996_tx()
Message-ID: <aNMOVtzQGfPk0A5a@lore-desk>
References: <aNJTl89jpYob5XaR@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="An40zBhMVovHNHKt"
Content-Disposition: inline
In-Reply-To: <aNJTl89jpYob5XaR@stanley.mountain>


--An40zBhMVovHNHKt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Hello Lorenzo Bianconi,

Hi Dan,

>=20
> Commit f940c9b7aef6 ("wifi: mt76: mt7996: Set proper link destination
> address in mt7996_tx()") from Jul 31, 2025 (linux-next), leads to the
> following Smatch static checker warning:
>=20
> 	drivers/net/wireless/mediatek/mt76/mt7996/main.c:1344 mt7996_tx()
> 	error: testing array offset 'link_id' after use.
>=20
> drivers/net/wireless/mediatek/mt76/mt7996/main.c
>     1288 static void mt7996_tx(struct ieee80211_hw *hw,
>     1289                       struct ieee80211_tx_control *control,
>     1290                       struct sk_buff *skb)
>     1291 {
>     1292         struct ieee80211_hdr *hdr =3D (struct ieee80211_hdr *)sk=
b->data;
>     1293         struct mt7996_dev *dev =3D mt7996_hw_dev(hw);
>     1294         struct ieee80211_sta *sta =3D control->sta;
>     1295         struct mt7996_sta *msta =3D sta ? (void *)sta->drv_priv =
: NULL;
>     1296         struct mt76_phy *mphy =3D hw->priv;
>     1297         struct ieee80211_tx_info *info =3D IEEE80211_SKB_CB(skb);
>     1298         struct ieee80211_vif *vif =3D info->control.vif;
>     1299         struct mt7996_vif *mvif =3D vif ? (void *)vif->drv_priv =
: NULL;
>     1300         struct mt76_wcid *wcid =3D &dev->mt76.global_wcid;
>     1301         u8 link_id =3D u32_get_bits(info->control.flags,
>     1302                                   IEEE80211_TX_CTRL_MLO_LINK);
>     1303=20
>     1304         rcu_read_lock();
>     1305=20
>     1306         /* Use primary link_id if the value from mac80211 is set=
 to
>     1307          * IEEE80211_LINK_UNSPECIFIED.
>     1308          */
>     1309         if (link_id =3D=3D IEEE80211_LINK_UNSPECIFIED) {
>     1310                 if (msta)
>     1311                         link_id =3D msta->deflink_id;
>     1312                 else if (mvif)
>     1313                         link_id =3D mvif->mt76.deflink_id;
>=20
> Can link_id be IEEE80211_LINK_UNSPECIFIED after this if statement?
>=20
>     1314         }
>     1315=20
>     1316         if (vif && ieee80211_vif_is_mld(vif)) {
>     1317                 struct ieee80211_bss_conf *link_conf;
>     1318=20
>     1319                 if (msta) {
>     1320                         struct ieee80211_link_sta *link_sta;
>     1321=20
>     1322                         link_sta =3D rcu_dereference(sta->link[l=
ink_id]);
>=20
> Some unchecked uses.  IEEE80211_LINK_UNSPECIFIED would be off-by-one.
>=20
>     1323                         if (!link_sta)
>     1324                                 link_sta =3D rcu_dereference(sta=
->link[msta->deflink_id]);
>     1325=20
>     1326                         if (link_sta) {
>     1327                                 memcpy(hdr->addr1, link_sta->add=
r, ETH_ALEN);
>     1328                                 if (ether_addr_equal(sta->addr, =
hdr->addr3))
>     1329                                         memcpy(hdr->addr3, link_=
sta->addr, ETH_ALEN);
>     1330                         }
>     1331                 }
>     1332=20
>     1333                 link_conf =3D rcu_dereference(vif->link_conf[lin=
k_id]);
>=20
> Here too.
>=20
>     1334                 if (link_conf) {
>     1335                         memcpy(hdr->addr2, link_conf->addr, ETH_=
ALEN);
>     1336                         if (ether_addr_equal(vif->addr, hdr->add=
r3))
>     1337                                 memcpy(hdr->addr3, link_conf->ad=
dr, ETH_ALEN);
>     1338                 }
>     1339         }
>     1340=20
>     1341         if (mvif) {
>     1342                 struct mt76_vif_link *mlink =3D &mvif->deflink.m=
t76;
>     1343=20
> --> 1344                 if (link_id < IEEE80211_LINK_UNSPECIFIED)
>=20
> Is this checker required?

I agree, we can get rid of this condition since if mvif (or msta) is not NU=
LL,
link_id can't be set to IEEE80211_LINK_UNSPECIFIED. I will post a fix for i=
t.

Regards,
Lorenzo

>=20
>     1345                         mlink =3D rcu_dereference(mvif->mt76.lin=
k[link_id]);
>     1346=20
>     1347                 if (mlink->wcid)
>     1348                         wcid =3D mlink->wcid;
>     1349=20
>     1350                 if (mvif->mt76.roc_phy &&
>     1351                     (info->flags & IEEE80211_TX_CTL_TX_OFFCHAN))=
 {
>     1352                         mphy =3D mvif->mt76.roc_phy;
>     1353                         if (mphy->roc_link)
>     1354                                 wcid =3D mphy->roc_link->wcid;
>     1355                 } else {
>     1356                         mphy =3D mt76_vif_link_phy(mlink);
>     1357                 }
>     1358         }
>     1359=20
>     1360         if (!mphy) {
>     1361                 ieee80211_free_txskb(hw, skb);
>     1362                 goto unlock;
>     1363         }
>     1364=20
>     1365         if (msta && link_id < IEEE80211_LINK_UNSPECIFIED) {
>=20
> And this?
>=20
>     1366                 struct mt7996_sta_link *msta_link;
>     1367=20
>     1368                 msta_link =3D rcu_dereference(msta->link[link_id=
]);
>     1369                 if (msta_link)
>     1370                         wcid =3D &msta_link->wcid;
>     1371         }
>     1372         mt76_tx(mphy, control->sta, wcid, skb);
>     1373 unlock:
>     1374         rcu_read_unlock();
>     1375 }
>=20
> regards,
> dan carpenter

--An40zBhMVovHNHKt
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaNMOVgAKCRA6cBh0uS2t
rEmuAQCfhPdoB2ydZLG0oiEYu3WByLvmWbGUIzxFkxt6qejqzQD+N7aCkpqp691j
A98HNHzctAvWmQHp8qNDdGRSNgUBBQM=
=CbLD
-----END PGP SIGNATURE-----

--An40zBhMVovHNHKt--

