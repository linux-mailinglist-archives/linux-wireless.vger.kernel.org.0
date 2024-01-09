Return-Path: <linux-wireless+bounces-1610-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC14827D49
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jan 2024 04:14:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D3FC285229
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jan 2024 03:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B4B257B;
	Tue,  9 Jan 2024 03:14:30 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC7123D5
	for <linux-wireless@vger.kernel.org>; Tue,  9 Jan 2024 03:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4093EFTw8157223, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 4093EFTw8157223
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Jan 2024 11:14:15 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Tue, 9 Jan 2024 11:14:16 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Tue, 9 Jan 2024 11:14:15 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e4c4:c4f:4e4c:d23c]) by
 RTEXMBS04.realtek.com.tw ([fe80::e4c4:c4f:4e4c:d23c%5]) with mapi id
 15.01.2507.035; Tue, 9 Jan 2024 11:14:15 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Martin Kaistra <martin.kaistra@linutronix.de>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Jes Sorensen <Jes.Sorensen@gmail.com>, Kalle Valo <kvalo@kernel.org>,
        Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        Sebastian Andrzej Siewior
	<bigeasy@linutronix.de>
Subject: RE: [PATCH] wifi: rtl8xxxu: enable channel switch support
Thread-Topic: [PATCH] wifi: rtl8xxxu: enable channel switch support
Thread-Index: AQHaQiODHEhpK9S3y0SNBT3W3hf7YbDQzGgg
Date: Tue, 9 Jan 2024 03:14:15 +0000
Message-ID: <3bc29348011242789a7ba1c2883d9b3a@realtek.com>
References: <20240108111103.121378-1-martin.kaistra@linutronix.de>
In-Reply-To: <20240108111103.121378-1-martin.kaistra@linutronix.de>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS06.realtek.com.tw, 9
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



> -----Original Message-----
> From: Martin Kaistra <martin.kaistra@linutronix.de>
> Sent: Monday, January 8, 2024 7:11 PM
> To: linux-wireless@vger.kernel.org
> Cc: Jes Sorensen <Jes.Sorensen@gmail.com>; Kalle Valo <kvalo@kernel.org>;=
 Ping-Ke Shih
> <pkshih@realtek.com>; Bitterblue Smith <rtl8821cerfe2@gmail.com>; Sebasti=
an Andrzej Siewior
> <bigeasy@linutronix.de>
> Subject: [PATCH] wifi: rtl8xxxu: enable channel switch support
>=20
> The CSA countdown in the beacon frames, which are sent out by firmware,
> needs to get updated by the driver. Do this at the end of the
> update_beacon_work function by sleeping for a bit shorter than the
> beacon interval and then either scheduling another run of
> update_beacon_work or calling ieee80211_csa_finish() when the end of the
> countdown is reached.
>=20
> Signed-off-by: Martin Kaistra <martin.kaistra@linutronix.de>
> ---
>  .../net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c   | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
> b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
> index 5fddbd6594a24..c4f3f52bde303 100644
> --- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
> +++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
> @@ -5696,7 +5696,7 @@ static void rtl8xxxu_send_beacon_frame(struct ieee8=
0211_hw *hw,
>         struct rtl8xxxu_priv *priv =3D hw->priv;
>         struct sk_buff *skb =3D ieee80211_beacon_get(hw, vif, 0);
>         struct device *dev =3D &priv->udev->dev;
> -       int retry;
> +       int retry, interval;
>         u8 val8;
>=20
>         /* BCN_VALID, write 1 to clear, cleared by SW */
> @@ -5722,6 +5722,15 @@ static void rtl8xxxu_send_beacon_frame(struct ieee=
80211_hw *hw,
>=20
>         if (!retry)
>                 dev_err(dev, "%s: Failed to read beacon valid bit\n", __f=
unc__);
> +
> +       if (vif->bss_conf.csa_active) {
> +               interval =3D 1024 * vif->bss_conf.beacon_int;
> +               usleep_range(interval - 2048, interval - 1024);

Can we use a delayed work? And, re-schedule it as early as possible to exec=
ute
this function in accurate interval of beacon_int, otherwise processing time=
 of
this function will be accumulated.=20

> +               if (ieee80211_beacon_cntdwn_is_complete(vif))
> +                       ieee80211_csa_finish(vif);
> +               else
> +                       schedule_work(&priv->update_beacon_work);
> +       }
>  }
>=20



