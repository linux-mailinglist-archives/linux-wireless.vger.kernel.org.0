Return-Path: <linux-wireless+bounces-1066-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B7C5819897
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Dec 2023 07:28:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 916E21C22108
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Dec 2023 06:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6CAD11734;
	Wed, 20 Dec 2023 06:28:35 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316F111715
	for <linux-wireless@vger.kernel.org>; Wed, 20 Dec 2023 06:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3BK6SMST0515819, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3BK6SMST0515819
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Dec 2023 14:28:22 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Wed, 20 Dec 2023 14:28:22 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 20 Dec 2023 14:28:22 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7]) by
 RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7%5]) with mapi id
 15.01.2375.007; Wed, 20 Dec 2023 14:28:22 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Martin Kaistra <martin.kaistra@linutronix.de>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Jes Sorensen <Jes.Sorensen@gmail.com>, Kalle Valo <kvalo@kernel.org>,
        Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        Sebastian Andrzej Siewior
	<bigeasy@linutronix.de>
Subject: RE: [PATCH 19/20] wifi: rtl8xxxu: make supporting AP mode only on port 0 transparent
Thread-Topic: [PATCH 19/20] wifi: rtl8xxxu: make supporting AP mode only on
 port 0 transparent
Thread-Index: AQHaMb/t7UraxeutE0+U7Z3itK4it7Cxt0zA
Date: Wed, 20 Dec 2023 06:28:21 +0000
Message-ID: <56eed6a3e237435f9d21082ca12eeaec@realtek.com>
References: <20231218143645.433356-1-martin.kaistra@linutronix.de>
 <20231218143645.433356-20-martin.kaistra@linutronix.de>
In-Reply-To: <20231218143645.433356-20-martin.kaistra@linutronix.de>
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
> Sent: Monday, December 18, 2023 10:37 PM
> To: linux-wireless@vger.kernel.org
> Cc: Jes Sorensen <Jes.Sorensen@gmail.com>; Kalle Valo <kvalo@kernel.org>;=
 Ping-Ke Shih
> <pkshih@realtek.com>; Bitterblue Smith <rtl8821cerfe2@gmail.com>; Sebasti=
an Andrzej Siewior
> <bigeasy@linutronix.de>
> Subject: [PATCH 19/20] wifi: rtl8xxxu: make supporting AP mode only on po=
rt 0 transparent
>=20
> When the driver is used for concurrent mode, both virtual interfaces can
> be set to station or AP mode, though only one can be in AP mode at the
> same time.
>=20
> In order to keep the code simple, use only hw port 0 for AP mode. When
> an interface is added in AP mode which would be assigned to port 1, use
> a switch_port function to transparently swap the mapping between virtual
> interface and hw port.
>=20
> Signed-off-by: Martin Kaistra <martin.kaistra@linutronix.de>
> ---
>  .../wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 84 ++++++++++++++++++-
>  1 file changed, 82 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
> b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
> index 88730791091a7..595f447874f4d 100644
> --- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
> +++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
> @@ -6613,6 +6613,84 @@ static int rtl8xxxu_submit_int_urb(struct ieee8021=
1_hw *hw)
>         return ret;
>  }
>=20
> +static void rtl8xxxu_switch_ports(struct rtl8xxxu_priv *priv)
> +{

[...]

> +
> +       vif =3D priv->vifs[0];
> +       priv->vifs[0] =3D priv->vifs[1];
> +       priv->vifs[1] =3D vif;
> +       rtlvif =3D (struct rtl8xxxu_vif *)priv->vifs[1]->drv_priv;
> +       rtlvif->port_num =3D 1;

nit: Would it be better to swap port_num as well? Currently, port_num of vi=
fs[0]
will be set to 0 by caller, but not sure if further people could misuse thi=
s
function.


> +}
> +
>  static int rtl8xxxu_add_interface(struct ieee80211_hw *hw,
>                                   struct ieee80211_vif *vif)
>  {
> @@ -6640,8 +6718,10 @@ static int rtl8xxxu_add_interface(struct ieee80211=
_hw *hw,
>                 }
>                 break;
>         case NL80211_IFTYPE_AP:
> -               if (port_num =3D=3D 1)
> -                       return -EOPNOTSUPP;
> +               if (port_num =3D=3D 1) {
> +                       rtl8xxxu_switch_ports(priv);
> +                       port_num =3D 0;
> +               }
>=20
>                 rtl8xxxu_write8(priv, REG_BEACON_CTRL,
>                                 BEACON_DISABLE_TSF_UPDATE | BEACON_CTRL_M=
BSSID);
> --
> 2.39.2


