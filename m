Return-Path: <linux-wireless+bounces-22450-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9043CAA8FA7
	for <lists+linux-wireless@lfdr.de>; Mon,  5 May 2025 11:33:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB2DB1752E9
	for <lists+linux-wireless@lfdr.de>; Mon,  5 May 2025 09:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CF7014A4F9;
	Mon,  5 May 2025 09:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="IPtu4UE6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2A934CF5
	for <linux-wireless@vger.kernel.org>; Mon,  5 May 2025 09:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746437590; cv=none; b=bs+ZSzGLepAqXqQKBszabCfL1BpWK7xJMBfI/ATvzN+8ysW1S6gv5LbSMjpB28L2J/hI8GpCp8svgdJ/SJOnYU4RdRtd0aXFgYFKn/CJEczUosueAsPsPrr8QEo90/Q+bnEFJ+fOqACQ8QTTrU6ZggnJx6xKUrrS2sMwEYm0MFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746437590; c=relaxed/simple;
	bh=pEi+K8rSvreBGJdxoOveyy2y/Yx1A+pWvjbE23Xd8c0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Bxucs29WpySlrVO5WX2xf9sOGQdEhdgcax+Ty5dwzxbIRKuYVU0/YUdCOoq1LF0O6jjOsPBhsue32euI2KdZi+0wmMs7IY2/2ISf/MZnD3WumaYb82CTaGSCBWEmOVbnBJtPDkhcGIaUmn46dpmr6kk0n+6qYbuIDQPyYow4RoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=IPtu4UE6; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 5459WKgK43977804, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1746437540; bh=pEi+K8rSvreBGJdxoOveyy2y/Yx1A+pWvjbE23Xd8c0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=IPtu4UE6uDUvu3FbydkFazYv0zlHReI3xYbNpZ2BTFtG5htRrrq3PT1K8wSb9TGHw
	 l08rSHWc0LA0U/8Qy7hZwT0oh/iQ0GT6LLuIqNZg+bHZ+JHnmo0YbdijdmyDusN6fD
	 KblYPTke1YFEGZi6tLx0UvfPcqo8RdLoKONQaUKb6utX9t9QmDXBG7uYYrRKErGlLM
	 gR7f3ZRFUfiO/LJ8zIipMdmCrSCHwFfo+hB0M1faDeMmh0nGUgz4Uy+76o/NqIm5RV
	 ZyFrpERSfIoBkXYIGRYMiytFT07W1EpNFoUoow9ZEqbUjVNMY4Lk4ueHzn7NnveYfn
	 Bi2TExE2QqNRA==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 5459WKgK43977804
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 5 May 2025 17:32:20 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 5 May 2025 17:32:20 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 5 May 2025 17:32:19 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Mon, 5 May 2025 17:32:19 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Allan Wang <allan.wang@mediatek.com>, "nbd@nbd.name" <nbd@nbd.name>,
        "lorenzo@kernel.org" <lorenzo@kernel.org>
CC: "deren.wu@mediatek.com" <deren.wu@mediatek.com>,
        "mingyen.hsieh@mediatek.com" <mingyen.hsieh@mediatek.com>,
        "Sean.Wang@mediatek.com" <Sean.Wang@mediatek.com>,
        "Soul.Huang@mediatek.com"
	<Soul.Huang@mediatek.com>,
        "Leon.Yen@mediatek.com" <Leon.Yen@mediatek.com>,
        "Michael.Lo@mediatek.com" <Michael.Lo@mediatek.com>,
        "Eric-SY.Chang@mediatek.com" <Eric-SY.Chang@mediatek.com>,
        "km.lin@mediatek.com" <km.lin@mediatek.com>,
        "robin.chiu@mediatek.com"
	<robin.chiu@mediatek.com>,
        "ch.yeh@mediatek.com" <ch.yeh@mediatek.com>,
        "posh.sun@mediatek.com" <posh.sun@mediatek.com>,
        "Quan.Zhou@mediatek.com"
	<Quan.Zhou@mediatek.com>,
        "Ryder.Lee@mediatek.com" <Ryder.Lee@mediatek.com>,
        "Shayne.Chen@mediatek.com" <Shayne.Chen@mediatek.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>
Subject: RE: [PATCH] wifi: mt76: mt7925: add rfkill_poll for hardware rfkill
Thread-Topic: [PATCH] wifi: mt76: mt7925: add rfkill_poll for hardware rfkill
Thread-Index: AQHbvZOVfpHFzMbbC0e6vR0ZbyOdv7PDxISg
Date: Mon, 5 May 2025 09:32:19 +0000
Message-ID: <794916dfd01545579d2fe7f523b5b29a@realtek.com>
References: <20250505073734.3923790-1-allan.wang@mediatek.com>
In-Reply-To: <20250505073734.3923790-1-allan.wang@mediatek.com>
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

Allan Wang <allan.wang@mediatek.com> wrote:

[...]

> @@ -2205,6 +2208,18 @@ static void mt7925_unassign_vif_chanctx(struct iee=
e80211_hw *hw,
>         mutex_unlock(&dev->mt76.mutex);
>  }
>=20
> +static void mt7925_rfkill_poll(struct ieee80211_hw *hw)
> +{
> +       struct mt792x_phy *phy =3D mt792x_hw_phy(hw);
> +       int ret =3D 0;

no need initializer.

> +
> +       mt792x_mutex_acquire(phy->dev);
> +       ret =3D mt7925_mcu_wf_rf_pin_ctrl(phy);
> +       mt792x_mutex_release(phy->dev);
> +
> +       wiphy_rfkill_set_hw_state(hw->wiphy, ret ? false : true);

wiphy_rfkill_set_hw_state(hw->wiphy, ret =3D=3D 0);

or

wiphy_rfkill_set_hw_state(hw->wiphy, !ret);

> +}
> +
>  const struct ieee80211_ops mt7925_ops =3D {
>         .tx =3D mt792x_tx,
>         .start =3D mt7925_start,
> @@ -2265,6 +2280,7 @@ const struct ieee80211_ops mt7925_ops =3D {
>         .link_info_changed =3D mt7925_link_info_changed,
>         .change_vif_links =3D mt7925_change_vif_links,
>         .change_sta_links =3D mt7925_change_sta_links,
> +       .rfkill_poll =3D mt7925_rfkill_poll,
>  };
>  EXPORT_SYMBOL_GPL(mt7925_ops);
>=20
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
> b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
> index 286f602623c0..31fa092d2c8c 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
> @@ -3633,6 +3633,45 @@ int mt7925_mcu_set_rate_txpower(struct mt76_phy *p=
hy)
>         return 0;
>  }
>=20
> +int mt7925_mcu_wf_rf_pin_ctrl(struct mt792x_phy *phy)
> +{
> +#define UNI_CMD_RADIO_STATUS_GET       0
> +       struct mt792x_dev *dev =3D phy->dev;
> +       struct sk_buff *skb;
> +       int ret;
> +

Should avoid empty line in declarations?=20

> +       struct {
> +               __le16 tag;
> +               __le16 len;
> +               u8 rsv[4];
> +       } __packed req =3D {
> +               .tag =3D UNI_CMD_RADIO_STATUS_GET,
> +               .len =3D cpu_to_le16(sizeof(req)),
> +       };
> +
> +       struct mt7925_radio_status_event {
> +               __le16 tag;
> +               __le16 len;
> +
> +               u8 data;
> +               u8 rsv[3];
> +       } __packed * status;

I remember this should be "__packed *status", but checkpatch reports
false-alarm.=20

> +
> +       ret =3D mt76_mcu_send_and_get_msg(&dev->mt76,
> +                                       MCU_UNI_CMD(RADIO_STATUS),
> +                                       &req, sizeof(req), true, &skb);
> +       if (ret)
> +               return ret;
> +
> +       skb_pull(skb, sizeof(struct tlv));
> +       status =3D (struct mt7925_radio_status_event *)skb->data;
> +       ret =3D (int)status->data;

I feel int casting is unnecessary.

> +
> +       dev_kfree_skb(skb);
> +
> +       return ret;
> +}
> +
>  int mt7925_mcu_set_rxfilter(struct mt792x_dev *dev, u32 fif,
>                             u8 bit_op, u32 bit_map)
>  {

[...]


