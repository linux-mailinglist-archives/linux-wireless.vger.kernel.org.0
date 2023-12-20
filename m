Return-Path: <linux-wireless+bounces-1060-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E947681984C
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Dec 2023 06:51:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E90D286C16
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Dec 2023 05:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1715716406;
	Wed, 20 Dec 2023 05:51:35 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01BEB16403
	for <linux-wireless@vger.kernel.org>; Wed, 20 Dec 2023 05:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3BK5p2ntD507082, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3BK5p2ntD507082
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Dec 2023 13:51:03 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Wed, 20 Dec 2023 13:51:03 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 20 Dec 2023 13:51:02 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7]) by
 RTEXMBS04.realtek.com.tw ([fe80::40c2:6c24:2df4:e6c7%5]) with mapi id
 15.01.2375.007; Wed, 20 Dec 2023 13:51:02 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Martin Kaistra <martin.kaistra@linutronix.de>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Jes Sorensen <Jes.Sorensen@gmail.com>, Kalle Valo <kvalo@kernel.org>,
        Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        Sebastian Andrzej Siewior
	<bigeasy@linutronix.de>
Subject: RE: [PATCH 07/20] wifi: rtl8xxxu: extend check for matching bssid to both interfaces
Thread-Topic: [PATCH 07/20] wifi: rtl8xxxu: extend check for matching bssid to
 both interfaces
Thread-Index: AQHaMb/F+8FmqtnoUU+G0r/J9qn1AbCxpxFA
Date: Wed, 20 Dec 2023 05:51:02 +0000
Message-ID: <cddf0a0b59a1425fa0e37743feaaafa4@realtek.com>
References: <20231218143645.433356-1-martin.kaistra@linutronix.de>
 <20231218143645.433356-8-martin.kaistra@linutronix.de>
In-Reply-To: <20231218143645.433356-8-martin.kaistra@linutronix.de>
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
> Subject: [PATCH 07/20] wifi: rtl8xxxu: extend check for matching bssid to=
 both interfaces
>=20
> The driver will support two interfaces soon, which both can be in
> station mode, so extend the check, whether cfo information should be
> parsed, to cover both interfaces.
>=20
> For better code readability put the lines with priv->vifs[port_num] in a
> separate function.
>=20
> Signed-off-by: Martin Kaistra <martin.kaistra@linutronix.de>
> ---
>  .../wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 22 ++++++++++++-------
>  1 file changed, 14 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
> b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
> index fd6b6e2eba038..c3039049e9f5b 100644
> --- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
> +++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
> @@ -5706,6 +5706,16 @@ static void rtl8xxxu_update_beacon_work_callback(s=
truct work_struct *work)
>         rtl8xxxu_send_beacon_frame(hw, vif);
>  }
>=20
> +static inline bool rtl8xxxu_is_packet_match_bssid(struct rtl8xxxu_priv *=
priv,
> +                                                 struct ieee80211_hdr *h=
dr,
> +                                                 int port_num)
> +{
> +       return priv->vifs[port_num] &&
> +               priv->vifs[port_num]->type =3D=3D NL80211_IFTYPE_STATION =
&&
> +               priv->vifs[port_num]->cfg.assoc &&
> +               ether_addr_equal(priv->vifs[port_num]->bss_conf.bssid, hd=
r->addr2);

nit: coding style: align "priv->vifs", like

return priv->vifs[...]
       priv->vifs[port_num]....


> +}
> +
>  void rtl8723au_rx_parse_phystats(struct rtl8xxxu_priv *priv,
>                                  struct ieee80211_rx_status *rx_status,
>                                  struct rtl8723au_phy_stats *phy_stats,
> @@ -5722,12 +5732,10 @@ void rtl8723au_rx_parse_phystats(struct rtl8xxxu_=
priv *priv,
>                 rx_status->signal =3D priv->fops->cck_rssi(priv, phy_stat=
s);
>         } else {
>                 bool parse_cfo =3D priv->fops->set_crystal_cap &&
> -                                priv->vif &&
> -                                priv->vif->type =3D=3D NL80211_IFTYPE_ST=
ATION &&
> -                                priv->vif->cfg.assoc &&
>                                  !crc_icv_err &&
>                                  !ieee80211_is_ctl(hdr->frame_control) &&
> -                                ether_addr_equal(priv->vif->bss_conf.bss=
id, hdr->addr2);
> +                                (rtl8xxxu_is_packet_match_bssid(priv, hd=
r, 0) ||
> +                                 rtl8xxxu_is_packet_match_bssid(priv, hd=
r, 1));

I feel that driver can only track single one CFO (carrier frequency offset)
from AP. Considering STA+STA case with two different APs, it would cause
ping-pong CFO values between two APs.=20

A simple way is just to ignore CFO for STA+STA case. Another way is to
reference the methods implemented by rtw89 where function name is
rtw89_phy_multi_sta_cfo_calc(). One method is to record CFO tail for each
mac_id and use the average as target CFO value to hardware.

Ping-Ke


