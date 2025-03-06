Return-Path: <linux-wireless+bounces-19835-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DE965A540A8
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 03:28:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3613C7A6D39
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 02:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C4F2F9F8;
	Thu,  6 Mar 2025 02:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="qffaZTOF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44AA12907;
	Thu,  6 Mar 2025 02:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741228131; cv=none; b=cgVQsrL6HrSfvfVVgQxvNKOXBC/167T03RmMatckJa08yv8/FlO90h8nPSSTAqWHFdOZyz8MiZ9Shh6oClAu9v7CopPzWVL3/2LQNj3lC/7PuOMZykbf3zUZNsF0SdsUN9N9/xybfdC8TrBYuJBwLYSmKDkOGTQ+0Y72KtCCTc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741228131; c=relaxed/simple;
	bh=3dhtHCh58xOEShk9yT+stIKHGFWKjW+X/xW5WyTuYyo=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GpTV1uiOIEl2LzrgL+PPmNhtAP0VolrN2Zfj80jj1hvOtVVL0z5DZ8salsydiy1fuqrlwwrQo20BbsVo8HCtJQ5dcGTPFQOejqY5Ll295L03Qk1iCZsSfE98s1uQoLLcF2w0KKJCoadggr7cL6gr9WDYboQ+IGD7WP+6y/mjo6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=qffaZTOF; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 5262RLQQ02509779, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1741228041; bh=3dhtHCh58xOEShk9yT+stIKHGFWKjW+X/xW5WyTuYyo=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=qffaZTOFY6G5QtMg7KOMpJbczF9b5vgJpIkpbxYr2O/KxO9wvD3xvq9QfNPmZFptM
	 8q7rI5AU/l6JWLzoyB8nqvjLf+h0qdLC7eVUkxbjjT487yAzjxQVgHxz39HSgG8KFp
	 3rsVs+kdUIijke9XH1s83B8Ht1pZ9NrszD8FvBh0r8PPfO8ZHWovNvmOcVfbPxb/kZ
	 Qu9y9gFnlM3kjCHYfejymMy1cW8TIGQficJrEibYmASvKSF40LlUlWuifAbBfbXxaK
	 G2iDM2E+Lx+z/qBFOwC85g8mEGhm9pox6ljveYOLhR3QhT/jvuzlSCK4C13cBPA5cC
	 rLOLNtDs0BkXg==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 5262RLQQ02509779
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 6 Mar 2025 10:27:21 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 6 Mar 2025 10:27:21 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 6 Mar 2025 10:27:20 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Thu, 6 Mar 2025 10:27:20 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Shengyu Qu <wiagn233@outlook.com>, "nbd@nbd.name" <nbd@nbd.name>,
        "lorenzo@kernel.org" <lorenzo@kernel.org>,
        "ryder.lee@mediatek.com"
	<ryder.lee@mediatek.com>,
        "shayne.chen@mediatek.com"
	<shayne.chen@mediatek.com>,
        "sean.wang@mediatek.com"
	<sean.wang@mediatek.com>,
        "johannes@sipsolutions.net"
	<johannes@sipsolutions.net>,
        "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com"
	<angelogioacchino.delregno@collabora.com>,
        "miriam.rachel.korenblit@intel.com" <miriam.rachel.korenblit@intel.com>,
        "nicolas.cavallari@green-communications.fr"
	<nicolas.cavallari@green-communications.fr>,
        "howard-yh.hsu@mediatek.com"
	<howard-yh.hsu@mediatek.com>,
        "greearb@candelatech.com"
	<greearb@candelatech.com>,
        "christophe.jaillet@wanadoo.fr"
	<christophe.jaillet@wanadoo.fr>,
        "benjamin-jw.lin@mediatek.com"
	<benjamin-jw.lin@mediatek.com>,
        "mingyen.hsieh@mediatek.com"
	<mingyen.hsieh@mediatek.com>,
        "quic_adisi@quicinc.com"
	<quic_adisi@quicinc.com>,
        "deren.wu@mediatek.com" <deren.wu@mediatek.com>,
        "chui-hao.chiu@mediatek.com" <chui-hao.chiu@mediatek.com>,
        "gustavoars@kernel.org" <gustavoars@kernel.org>,
        "bo.jiao@mediatek.com"
	<bo.jiao@mediatek.com>,
        "sujuan.chen@mediatek.com"
	<sujuan.chen@mediatek.com>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>
Subject: RE: [PATCH v8] wifi: mt76: mt7915: add wds support when wed is enabled
Thread-Topic: [PATCH v8] wifi: mt76: mt7915: add wds support when wed is
 enabled
Thread-Index: AQHbjb8lReN6YdafAkq12sgLw/MaUbNlWkUA
Date: Thu, 6 Mar 2025 02:27:20 +0000
Message-ID: <c56c9714c754451a8255ece79353da2b@realtek.com>
References: <TYCPR01MB84374EEAC0DDDA4223B8997298CB2@TYCPR01MB8437.jpnprd01.prod.outlook.com>
In-Reply-To: <TYCPR01MB84374EEAC0DDDA4223B8997298CB2@TYCPR01MB8437.jpnprd01.prod.outlook.com>
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

Shengyu Qu <wiagn233@outlook.com> wrote:

[...]

> @@ -1271,6 +1278,10 @@ static void mt7915_sta_set_4addr(struct ieee80211_=
hw *hw,
>  {
>         struct mt7915_dev *dev =3D mt7915_hw_dev(hw);
>         struct mt7915_sta *msta =3D (struct mt7915_sta *)sta->drv_priv;
> +       int min =3D MT76_WED_WDS_MIN, max =3D MT76_WED_WDS_MAX;
> +       struct ieee80211_sta *pre_sta;
> +       u8 flags =3D MT76_WED_DEFAULT;
> +       int temp_idx;

In general 'temp' is short for temperature. 'tmp' is preferred.

>=20
>         if (enabled)
>                 set_bit(MT_WCID_FLAG_4ADDR, &msta->wcid.flags);
> @@ -1280,6 +1291,30 @@ static void mt7915_sta_set_4addr(struct ieee80211_=
hw *hw,
>         if (!msta->wcid.sta)
>                 return;
>=20
> +       if (mtk_wed_device_active(&dev->mt76.mmio.wed) &&
> +           !is_mt7915(&dev->mt76) &&
> +           (msta->wcid.idx < min || msta->wcid.idx > max - 1)) {
> +               pre_sta =3D kzalloc(sizeof(*sta) + sizeof(*msta), GFP_KER=
NEL);
> +               memmove(pre_sta, sta, sizeof(*sta) + sizeof(*msta));

Seemingly, kmemdup() =3D kzalloc() + memmove().

> +
> +               flags =3D test_bit(MT_WCID_FLAG_4ADDR, &msta->wcid.flags)=
 ?
> +                       MT76_WED_WDS_ACTIVE : MT76_WED_ACTIVE;
> +
> +               temp_idx =3D __mt76_wcid_alloc(dev->mt76.wcid_mask, MT791=
5_WTBL_STA, flags);

Since __mt76_wcid_alloc() could return -1 for error case, shouldn't you han=
dle that?

> +               ((struct mt7915_sta *)pre_sta->drv_priv)->wcid.idx =3D (u=
16)temp_idx;

Define a local `struct mt7915_sta *pre_msta =3D (struct mt7915_sta *)pre_st=
a->drv_priv`
ahead. This statement would be simpler. Just `pre_msta-> wcid.idx =3D (u16)=
temp_idx`,
but casting of '(u16)' is still not very preferred.

> +               mt7915_mac_sta_add(&dev->mt76, vif, pre_sta);
> +               rcu_assign_pointer(dev->mt76.wcid[temp_idx], &msta->wcid)=
;
> +
> +               temp_idx =3D msta->wcid.idx;
> +               msta->wcid.idx =3D ((struct mt7915_sta *)pre_sta->drv_pri=
v)->wcid.idx;
> +               ((struct mt7915_sta *)pre_sta->drv_priv)->wcid.idx =3D (u=
16)temp_idx;
> +               rcu_assign_pointer(dev->mt76.wcid[temp_idx], NULL);
> +
> +               synchronize_rcu();
> +               mt7915_mac_sta_remove(&dev->mt76, vif, pre_sta);
> +               kfree(pre_sta);
> +       }
> +
>         mt76_connac_mcu_wtbl_update_hdr_trans(&dev->mt76, vif, sta);
>  }
>=20

[...]


