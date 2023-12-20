Return-Path: <linux-wireless+bounces-1064-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7610B819881
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Dec 2023 07:09:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20C9B1F28BEB
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Dec 2023 06:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 357301170D;
	Wed, 20 Dec 2023 06:09:17 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D55411715
	for <linux-wireless@vger.kernel.org>; Wed, 20 Dec 2023 06:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3BK692bpC511583, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3BK692bpC511583
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Dec 2023 14:09:02 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Wed, 20 Dec 2023 14:09:03 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 20 Dec 2023 14:09:02 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7]) by
 RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7%5]) with mapi id
 15.01.2375.007; Wed, 20 Dec 2023 14:09:02 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Martin Kaistra <martin.kaistra@linutronix.de>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Jes Sorensen <Jes.Sorensen@gmail.com>, Kalle Valo <kvalo@kernel.org>,
        Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        Sebastian Andrzej Siewior
	<bigeasy@linutronix.de>
Subject: RE: [PATCH 14/20] wifi: rtl8xxxu: support multiple interfaces in bss_info_changed()
Thread-Topic: [PATCH 14/20] wifi: rtl8xxxu: support multiple interfaces in
 bss_info_changed()
Thread-Index: AQHaMb/XCfGYf0r3GE6HcLdAcks2tbCxshoA
Date: Wed, 20 Dec 2023 06:09:01 +0000
Message-ID: <32b2f2efe2834578809303c9960fba6d@realtek.com>
References: <20231218143645.433356-1-martin.kaistra@linutronix.de>
 <20231218143645.433356-15-martin.kaistra@linutronix.de>
In-Reply-To: <20231218143645.433356-15-martin.kaistra@linutronix.de>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXDAG01.realtek.com.tw, 9
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



> -----Original Message-----
> From: Martin Kaistra <martin.kaistra@linutronix.de>
> Sent: Monday, December 18, 2023 10:37 PM
> To: linux-wireless@vger.kernel.org
> Cc: Jes Sorensen <Jes.Sorensen@gmail.com>; Kalle Valo <kvalo@kernel.org>;=
 Ping-Ke Shih
> <pkshih@realtek.com>; Bitterblue Smith <rtl8821cerfe2@gmail.com>; Sebasti=
an Andrzej Siewior
> <bigeasy@linutronix.de>
> Subject: [PATCH 14/20] wifi: rtl8xxxu: support multiple interfaces in bss=
_info_changed()
>=20
> Call set_linktype now with correct port_num. Only react to beacon
> changes if port_num =3D=3D 0, as we only support AP mode on this port.
>=20
> Signed-off-by: Martin Kaistra <martin.kaistra@linutronix.de>
> ---
>  .../wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 26 +++++++++++--------
>  1 file changed, 15 insertions(+), 11 deletions(-)
>=20
> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
> b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
> index 59dd50844f1ae..f929b01615d00 100644
> --- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
> +++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c

[...]

> @@ -5090,16 +5092,18 @@ rtl8xxxu_bss_info_changed(struct ieee80211_hw *hw=
, struct ieee80211_vif *vif,
>                 rtl8xxxu_set_basic_rates(priv, bss_conf->basic_rates);
>         }
>=20
> -       if (changed & BSS_CHANGED_BEACON_ENABLED) {
> -               if (bss_conf->enable_beacon)
> -                       rtl8xxxu_start_tx_beacon(priv);
> -               else
> -                       rtl8xxxu_stop_tx_beacon(priv);
> +       /* beacon only supported for port_num =3D 0 */
> +       if (rtlvif->port_num =3D=3D 0) {

As your design, AP mode must play on port 0. Could mac80211 notify driver B=
EACON
changed on port 1?=20

> +               if (changed & BSS_CHANGED_BEACON_ENABLED) {
> +                       if (bss_conf->enable_beacon)
> +                               rtl8xxxu_start_tx_beacon(priv);
> +                       else
> +                               rtl8xxxu_stop_tx_beacon(priv);
> +               }
> +               if (changed & BSS_CHANGED_BEACON)
> +                       schedule_work(&priv->update_beacon_work);
>         }
>=20
> -       if (changed & BSS_CHANGED_BEACON)
> -               schedule_work(&priv->update_beacon_work);
> -
>  error:
>         return;
>  }

Ping-Ke


