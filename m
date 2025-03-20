Return-Path: <linux-wireless+bounces-20585-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F1BA69D6D
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Mar 2025 02:10:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D0CE4601B1
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Mar 2025 01:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E143717AE11;
	Thu, 20 Mar 2025 01:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="XtzjTD4Q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF4742A87
	for <linux-wireless@vger.kernel.org>; Thu, 20 Mar 2025 01:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742433028; cv=none; b=GLWvNK8L49b8Ol9wUTLWrD7wnAnLWN6H7bvw3IP64KLRSmWUSIh9PCEjoFFxEltgmenQFy8wTDN3lGFMAmA3XgI/u26ywQ7x9rJqFy9H3TmAkomeJ0vU7YDHdUN5zoPdj2vVdtd0Ex5ePDGRjL0V8P0ZyMQX6/Y9CXHiz1zL5Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742433028; c=relaxed/simple;
	bh=7+ChFNXI+wsn77UYkahKm1WykFk+GyHqCAeMswDiO24=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SKQTwmc7fT1fm/A2QGT1Mkgb+1MDiBqMSnNmh8XCN7GerdCYTUKDp8cOCerSeyvlSuBXb5GMD6Z5RxN6liwYVKIi4p8sYOKWtWwOX3kvGxzPsk34jdbKJRq3d1X1MSTcpNZsEfZKeWnmYDyTbQJ34XLR8mKA8ss3WTRoZ1XHPiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=XtzjTD4Q; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 52K19m3621555958, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1742432988; bh=7+ChFNXI+wsn77UYkahKm1WykFk+GyHqCAeMswDiO24=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=XtzjTD4Q9F5pC90IAjj0BC+Ac/cJGQm8gdd64C2uTQEMoKnmR4S60WbrLYJVHqi8B
	 zHoqrchak0CIw43CJEchHwjYdU4Fr7j3srLKdK/9T43JjOPXdwcYGOdZfCEkxrLajR
	 wTx0FdffCpb6zNCgql5olCtbk/KeFvtfFafcrg1C9zI3qmxzR9LIVS4n3hSNDsaA73
	 Tyh6ab1s0xT7gfEhUVPQurKm8ePFgn1RhPviiWVh6wzoi9g/7wTzPqfoHM9QW+DytI
	 AtBRLmPRZamFEtmX72lsVmbL5KWe+h+8/FRzWkh7to4EAbopZILtkSck/ugoImXO+h
	 24RD5mvskkKNg==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 52K19m3621555958
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Mar 2025 09:09:48 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 20 Mar 2025 09:09:47 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 20 Mar 2025 09:09:47 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Thu, 20 Mar 2025 09:09:47 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Mingyen Hsieh <mingyen.hsieh@mediatek.com>, "nbd@nbd.name" <nbd@nbd.name>,
        "lorenzo@kernel.org" <lorenzo@kernel.org>
CC: "deren.wu@mediatek.com" <deren.wu@mediatek.com>,
        "Sean.Wang@mediatek.com"
	<Sean.Wang@mediatek.com>,
        "Leon.Yen@mediatek.com" <Leon.Yen@mediatek.com>,
        "Michael.Lo@mediatek.com" <Michael.Lo@mediatek.com>,
        "allan.wang@mediatek.com" <allan.wang@mediatek.com>,
        "Eric-SY.Chang@mediatek.com" <Eric-SY.Chang@mediatek.com>,
        "km.lin@mediatek.com" <km.lin@mediatek.com>,
        "Quan.Zhou@mediatek.com"
	<Quan.Zhou@mediatek.com>,
        "Ryder.Lee@mediatek.com" <Ryder.Lee@mediatek.com>,
        "Shayne.Chen@mediatek.com" <Shayne.Chen@mediatek.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>
Subject: RE: [PATCH 2/2] wifi: mt76: mt7925: add RNR scan support for 6GHz
Thread-Topic: [PATCH 2/2] wifi: mt76: mt7925: add RNR scan support for 6GHz
Thread-Index: AQHbmKL650tDkh2nqEW/vhkYjw6VmbN7MViw
Date: Thu, 20 Mar 2025 01:09:46 +0000
Message-ID: <9f126f5e6a9f456193d658031d15e673@realtek.com>
References: <20250319074426.3782102-1-mingyen.hsieh@mediatek.com>
 <20250319074426.3782102-2-mingyen.hsieh@mediatek.com>
In-Reply-To: <20250319074426.3782102-2-mingyen.hsieh@mediatek.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Mingyen Hsieh <mingyen.hsieh@mediatek.com> wrote:
> From: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
>=20
> Enhance the mt7925 to include RNR scan support. It adds
> the necessary RNR information to the scan command.
>=20
> Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
> ---
>  .../net/wireless/mediatek/mt76/mt7925/mcu.c   | 35 +++++++++++++++++--
>  .../net/wireless/mediatek/mt76/mt7925/mcu.h   | 17 +++++----
>  2 files changed, 43 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
> b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
> index 243adace8799..7e24c4aa1e61 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
> @@ -3042,6 +3042,7 @@ int mt7925_mcu_hw_scan(struct mt76_phy *phy, struct=
 ieee80211_vif *vif,
>         struct mt76_dev *mdev =3D phy->dev;
>         struct mt76_connac_mcu_scan_channel *chan;
>         struct sk_buff *skb;
> +       u32 short_ssid[MT7925_RNR_SCAN_MAX_BSSIDS] =3D {0};

Using '=3D {}' as initializer would be more general for array and struct.

>=20
>         struct scan_hdr_tlv *hdr;
>         struct scan_req_tlv *req;
> @@ -3054,8 +3055,8 @@ int mt7925_mcu_hw_scan(struct mt76_phy *phy, struct=
 ieee80211_vif *vif,
>         int max_len;
>=20
>         max_len =3D sizeof(*hdr) + sizeof(*req) + sizeof(*ssid) +
> -                               sizeof(*bssid) + sizeof(*chan_info) +
> -                               sizeof(*misc) + sizeof(*ie);
> +                 sizeof(*bssid) * MT7925_RNR_SCAN_MAX_BSSIDS +
> +                 sizeof(*chan_info) + sizeof(*misc) + sizeof(*ie);
>=20
>         skb =3D mt76_mcu_msg_alloc(mdev, NULL, max_len);
>         if (!skb)
> @@ -3078,7 +3079,11 @@ int mt7925_mcu_hw_scan(struct mt76_phy *phy, struc=
t ieee80211_vif *vif,
>         for (i =3D 0; i < sreq->n_ssids; i++) {
>                 if (!sreq->ssids[i].ssid_len)
>                         continue;
> +               if (i > MT7925_RNR_SCAN_MAX_BSSIDS)
> +                       break;
>=20
> +               short_ssid[i] =3D ~crc32_le(~0, sreq->ssids[i].ssid,
> +                               sreq->ssids[i].ssid_len);

Have you run checkpatch? Third argument doesn't align with open parenthesis=
.=20

>                 ssid->ssids[i].ssid_len =3D cpu_to_le32(sreq->ssids[i].ss=
id_len);
>                 memcpy(ssid->ssids[i].ssid, sreq->ssids[i].ssid,
>                        sreq->ssids[i].ssid_len);
> @@ -3087,6 +3092,32 @@ int mt7925_mcu_hw_scan(struct mt76_phy *phy, struc=
t ieee80211_vif *vif,
>         ssid->ssid_type =3D n_ssids ? BIT(2) : BIT(0);
>         ssid->ssids_num =3D n_ssids;
>=20
> +       if (sreq->n_6ghz_params) {
> +               u8 j;
> +
> +               mt76_connac_mcu_build_rnr_scan_param(mdev, sreq);
> +
> +               for (j =3D 0; j < mdev->rnr.bssid_num; j++) {
> +                       if (j > MT7925_RNR_SCAN_MAX_BSSIDS)
> +                               break;
> +
> +                       tlv =3D mt76_connac_mcu_add_tlv(skb, UNI_SCAN_BSS=
ID,
> +                                                     sizeof(*bssid));
> +                       bssid =3D (struct scan_bssid_tlv *)tlv;
> +
> +                       memcpy(bssid->bssid, mdev->rnr.bssid[j], ETH_ALEN=
);

If addresses of dst and src BSSID are aligned u16, then ether_addr_copy().

> +                       bssid->match_ch =3D mdev->rnr.channel[j];
> +                       bssid->match_ssid_ind =3D MT7925_RNR_SCAN_MAX_BSS=
IDS;
> +                       bssid->match_short_ssid_ind =3D MT7925_RNR_SCAN_M=
AX_BSSIDS;
> +               }
> +               req->scan_func |=3D SCAN_FUNC_RNR_SCAN;
> +       } else {
> +               tlv =3D mt76_connac_mcu_add_tlv(skb, UNI_SCAN_BSSID, size=
of(*bssid));
> +               bssid =3D (struct scan_bssid_tlv *)tlv;
> +
> +               memcpy(bssid->bssid, sreq->bssid, ETH_ALEN);
> +       }
> +
>         tlv =3D mt76_connac_mcu_add_tlv(skb, UNI_SCAN_BSSID, sizeof(*bssi=
d));
>         bssid =3D (struct scan_bssid_tlv *)tlv;
>=20
>=20


