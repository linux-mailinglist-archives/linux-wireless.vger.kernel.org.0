Return-Path: <linux-wireless+bounces-1790-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F6A82BB61
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jan 2024 07:53:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0E9C287FDF
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jan 2024 06:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DA645C908;
	Fri, 12 Jan 2024 06:52:50 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FBD55C901
	for <linux-wireless@vger.kernel.org>; Fri, 12 Jan 2024 06:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 40C6qNz352191042, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 40C6qNz352191042
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Jan 2024 14:52:24 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.32; Fri, 12 Jan 2024 14:52:24 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 12 Jan 2024 14:52:24 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e4c4:c4f:4e4c:d23c]) by
 RTEXMBS04.realtek.com.tw ([fe80::e4c4:c4f:4e4c:d23c%5]) with mapi id
 15.01.2507.035; Fri, 12 Jan 2024 14:52:24 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Martin Kaistra <martin.kaistra@linutronix.de>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Jes Sorensen <Jes.Sorensen@gmail.com>, Kalle Valo <kvalo@kernel.org>,
        Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        Sebastian Andrzej Siewior
	<bigeasy@linutronix.de>,
        Zenm Chen <zenmchen@gmail.com>
Subject: RE: [PATCH v2 19/21] wifi: rtl8xxxu: add hw crypto support for AP mode
Thread-Topic: [PATCH v2 19/21] wifi: rtl8xxxu: add hw crypto support for AP
 mode
Thread-Index: AQHaNC0sDGaHcKZrXkiVSN0UWy+01bDV2+dQ
Date: Fri, 12 Jan 2024 06:52:24 +0000
Message-ID: <92fa5949e8094739883e665abb23ac01@realtek.com>
References: <20231221164353.603258-1-martin.kaistra@linutronix.de>
 <20231221164353.603258-20-martin.kaistra@linutronix.de>
In-Reply-To: <20231221164353.603258-20-martin.kaistra@linutronix.de>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS01.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

Hi Martin,

> -----Original Message-----
> From: Martin Kaistra <martin.kaistra@linutronix.de>
> Sent: Friday, December 22, 2023 12:44 AM
> To: linux-wireless@vger.kernel.org
> Cc: Jes Sorensen <Jes.Sorensen@gmail.com>; Kalle Valo <kvalo@kernel.org>;=
 Ping-Ke Shih
> <pkshih@realtek.com>; Bitterblue Smith <rtl8821cerfe2@gmail.com>; Sebasti=
an Andrzej Siewior
> <bigeasy@linutronix.de>
> Subject: [PATCH v2 19/21] wifi: rtl8xxxu: add hw crypto support for AP mo=
de
>=20

[...]

Zenm reported [1] his RTL8192EU and RTL8192FU don't work in station mode,
and cause is this patch. Please try if you can reproduce the symptom, and
apply my suggestion to see if help.

[1] https://lore.kernel.org/linux-wireless/20240112045104.12282-1-zenmchen@=
gmail.com/T/#me0940f522249becf49f25bc281f1992c523673f6

>=20
> +static int rtl8xxxu_get_free_sec_cam(struct ieee80211_hw *hw)
> +{
> +       struct rtl8xxxu_priv *priv =3D hw->priv;

We need to reserve entries 0~3 for keys that aren't pairwise key.=20

> +
> +       return find_first_zero_bit(priv->cam_map, priv->fops->max_sec_cam=
_num);
> +}
> +
>  static int rtl8xxxu_set_key(struct ieee80211_hw *hw, enum set_key_cmd cm=
d,
>                             struct ieee80211_vif *vif,
>                             struct ieee80211_sta *sta,
>                             struct ieee80211_key_conf *key)
>  {
> +       struct rtl8xxxu_vif *rtlvif =3D (struct rtl8xxxu_vif *)vif->drv_p=
riv;
>         struct rtl8xxxu_priv *priv =3D hw->priv;
>         struct device *dev =3D &priv->udev->dev;
>         u8 mac_addr[ETH_ALEN];

[...]

> @@ -6899,16 +6915,28 @@ static int rtl8xxxu_set_key(struct ieee80211_hw *=
hw, enum set_key_cmd cmd,
>=20
>         switch (cmd) {
>         case SET_KEY:
> -               key->hw_key_idx =3D key->keyidx;
> +
> +               retval =3D rtl8xxxu_get_free_sec_cam(hw);
> +               if (retval < 0)
> +                       return -EOPNOTSUPP;
> +

if (key->flags & IEEE80211_KEY_FLAG_PAIRWISE)
	key->hw_key_idx =3D retval;
else
	key->hw_key_idx =3D key->keyidx;

> +               key->hw_key_idx =3D retval;
> +
> +               if (vif->type =3D=3D NL80211_IFTYPE_AP && !(key->flags & =
IEEE80211_KEY_FLAG_PAIRWISE))
> +                       rtlvif->hw_key_idx =3D key->hw_key_idx;
> +
>                 key->flags |=3D IEEE80211_KEY_FLAG_GENERATE_IV;
>                 rtl8xxxu_cam_write(priv, key, mac_addr);
> +               set_bit(key->hw_key_idx, priv->cam_map);
>                 retval =3D 0;
>                 break;
>         case DISABLE_KEY:
>                 rtl8xxxu_write32(priv, REG_CAM_WRITE, 0x00000000);
>                 val32 =3D CAM_CMD_POLLING | CAM_CMD_WRITE |
> -                       key->keyidx << CAM_CMD_KEY_SHIFT;
> +                       key->hw_key_idx << CAM_CMD_KEY_SHIFT;
>                 rtl8xxxu_write32(priv, REG_CAM_CMD, val32);
> +               rtlvif->hw_key_idx =3D 0xff;
> +               clear_bit(key->hw_key_idx, priv->cam_map);

Shouldn't swap these two statements? I missed that during reviewing.


>                 retval =3D 0;
>                 break;
>         default:
> --
> 2.39.2


