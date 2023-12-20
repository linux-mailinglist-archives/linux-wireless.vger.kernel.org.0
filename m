Return-Path: <linux-wireless+bounces-1061-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE40819856
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Dec 2023 06:56:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23A53B23082
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Dec 2023 05:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47DFF1D52A;
	Wed, 20 Dec 2023 05:56:16 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E41E1D528
	for <linux-wireless@vger.kernel.org>; Wed, 20 Dec 2023 05:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3BK5u3OF1507987, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3BK5u3OF1507987
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Dec 2023 13:56:03 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Wed, 20 Dec 2023 13:56:03 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 20 Dec 2023 13:56:03 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7]) by
 RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7%5]) with mapi id
 15.01.2375.007; Wed, 20 Dec 2023 13:56:03 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Martin Kaistra <martin.kaistra@linutronix.de>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Jes Sorensen <Jes.Sorensen@gmail.com>, Kalle Valo <kvalo@kernel.org>,
        Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        Sebastian Andrzej Siewior
	<bigeasy@linutronix.de>
Subject: RE: [PATCH 09/20] wifi: rtl8xxxu: support multiple interfaces in set_aifs()
Thread-Topic: [PATCH 09/20] wifi: rtl8xxxu: support multiple interfaces in
 set_aifs()
Thread-Index: AQHaMb/JrstsK/ueY0Kd5ajvdUY6ybCxrjpQ
Date: Wed, 20 Dec 2023 05:56:03 +0000
Message-ID: <1c39a5b7d335409a8a044889cb769024@realtek.com>
References: <20231218143645.433356-1-martin.kaistra@linutronix.de>
 <20231218143645.433356-10-martin.kaistra@linutronix.de>
In-Reply-To: <20231218143645.433356-10-martin.kaistra@linutronix.de>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXDAG02.realtek.com.tw, 9
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
> Sent: Monday, December 18, 2023 10:37 PM
> To: linux-wireless@vger.kernel.org
> Cc: Jes Sorensen <Jes.Sorensen@gmail.com>; Kalle Valo <kvalo@kernel.org>;=
 Ping-Ke Shih
> <pkshih@realtek.com>; Bitterblue Smith <rtl8821cerfe2@gmail.com>; Sebasti=
an Andrzej Siewior
> <bigeasy@linutronix.de>
> Subject: [PATCH 09/20] wifi: rtl8xxxu: support multiple interfaces in set=
_aifs()
>=20
> In concurrent mode supported by this driver, both interfaces will use
> the same channel and same wireless mode.
> It is therefore possible to get the wireless mode by checking the first
> connected interface.
>=20
> Signed-off-by: Martin Kaistra <martin.kaistra@linutronix.de>
> ---
>  .../wireless/realtek/rtl8xxxu/rtl8xxxu_core.c  | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
> b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
> index 2b546bce01237..827e715f0e585 100644
> --- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
> +++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
> @@ -4913,14 +4913,18 @@ static void rtl8xxxu_set_aifs(struct rtl8xxxu_pri=
v *priv, u8 slot_time)
>         u8 aifs, aifsn, sifs;
>         int i;
>=20
> -       if (priv->vif) {
> -               struct ieee80211_sta *sta;
> +       for (i =3D 0; i < ARRAY_SIZE(priv->vifs); i++) {
> +               if (priv->vifs[i]) {

if (!priv->vifs[i])
        continue;

Then, you can only stir few code.=20

Ping-Ke


