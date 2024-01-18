Return-Path: <linux-wireless+bounces-2134-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A9818310F9
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jan 2024 02:38:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF1B2B213D3
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jan 2024 01:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2D09259D;
	Thu, 18 Jan 2024 01:38:36 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E082573
	for <linux-wireless@vger.kernel.org>; Thu, 18 Jan 2024 01:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705541916; cv=none; b=HKvm0LpfS8MC0juhP/nu5aOV/ikMq+H5kALWVYBds6EpeRSkB4mKXA/zY0vTI78jZMjBuAmACZ+n7BXSIZZLA7B7WutFPtzlDrGo3qBF5F0SxQtirE4dD/CKvoPQGLO0gdj9wukEMy+dhlDbvtMqSM1zOpkPLUlkSS8fR1Makqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705541916; c=relaxed/simple;
	bh=DB4UdA2zEsmLgIZTNZeL6ZjkM18c02Q2vJMH46iTewM=;
	h=X-SpamFilter-By:Received:Received:Received:Received:From:To:CC:
	 Subject:Thread-Topic:Thread-Index:Date:Message-ID:References:
	 In-Reply-To:Accept-Language:Content-Language:x-originating-ip:
	 x-kse-serverinfo:x-kse-antispam-interceptor-info:
	 x-kse-antivirus-interceptor-info:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:
	 X-KSE-AntiSpam-Interceptor-Info:X-KSE-ServerInfo:
	 X-KSE-AntiSpam-Interceptor-Info:X-KSE-Antivirus-Interceptor-Info:
	 X-KSE-AntiSpam-Interceptor-Info; b=XblnIjS9vTOokqG8eZAxUdkgSIogHcecIKMLm6sKAOb5HMtXbVMzG9R6wLRmpnxTCJ1HmdLIwoTONOj5LQCw1Jh2nnphI7slc6qRtukQXEPhnA2nMJBzqTrSyeBDWDoF0Q7ZmGyirJNUoqXv+pQmBPu4LPjqZbt82MFzN5OVH+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 40I1bxJyB1247094, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 40I1bxJyB1247094
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Jan 2024 09:37:59 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Thu, 18 Jan 2024 09:37:58 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 18 Jan 2024 09:37:58 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::e4c4:c4f:4e4c:d23c]) by
 RTEXMBS04.realtek.com.tw ([fe80::e4c4:c4f:4e4c:d23c%5]) with mapi id
 15.01.2507.035; Thu, 18 Jan 2024 09:37:58 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Martin Kaistra <martin.kaistra@linutronix.de>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Jes Sorensen <Jes.Sorensen@gmail.com>, Kalle Valo <kvalo@kernel.org>,
        Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        Sebastian Andrzej Siewior
	<bigeasy@linutronix.de>
Subject: RE: [PATCH] wifi: rtl8xxxu: update rate mask per sta
Thread-Topic: [PATCH] wifi: rtl8xxxu: update rate mask per sta
Thread-Index: AQHaSVU1/kXlkXq/OEm3ZacX5mGlCLDevu1w
Date: Thu, 18 Jan 2024 01:37:58 +0000
Message-ID: <4d5f06f2407042f2862af7559ed66eac@realtek.com>
References: <20240117145516.497966-1-martin.kaistra@linutronix.de>
In-Reply-To: <20240117145516.497966-1-martin.kaistra@linutronix.de>
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
> Sent: Wednesday, January 17, 2024 10:55 PM
> To: linux-wireless@vger.kernel.org
> Cc: Jes Sorensen <Jes.Sorensen@gmail.com>; Kalle Valo <kvalo@kernel.org>;=
 Ping-Ke Shih
> <pkshih@realtek.com>; Bitterblue Smith <rtl8821cerfe2@gmail.com>; Sebasti=
an Andrzej Siewior
> <bigeasy@linutronix.de>
> Subject: [PATCH] wifi: rtl8xxxu: update rate mask per sta
>=20
> Until now, rtl8xxxu_watchdog_callback() only fetches RSSI and updates
> the rate mask in station mode. This means, in AP mode only the default
> rate mask is used.
>=20
> In order to have the rate mask reflect the actual connection quality,
> extend rtl8xxxu_watchdog_callback() to iterate over every sta. Like in
> the rtw88 driver, add a function to collect all currently present stas
> and then iterate over a list of copies to ensure no RCU lock problems
> for register access via USB. Remove the existing RCU lock in
> rtl8xxxu_refresh_rate_mask().
>=20
> Since the currently used ieee80211_ave_rssi() is only for 'vif', add
> driver-level tracking of RSSI per sta.
>=20
> Signed-off-by: Martin Kaistra <martin.kaistra@linutronix.de>

[...]

> @@ -6317,6 +6318,76 @@ static void rtl8188e_c2hcmd_callback(struct work_s=
truct *work)
>         }
>  }
>=20
> +#define rtl8xxxu_iterate_vifs_atomic(priv, iterator, data)              =
       \
> +       ieee80211_iterate_active_interfaces_atomic((priv)->hw,           =
       \
> +                       IEEE80211_IFACE_ITER_NORMAL, iterator, data)
> +
> +struct rtl8xxxu_rx_addr_match_data {
> +       struct rtl8xxxu_priv *priv;
> +       struct ieee80211_hdr *hdr;
> +       struct ieee80211_rx_status *rx_status;
> +       u8 *bssid;
> +};
> +
> +static void rtl8xxxu_rx_addr_match_iter(void *data, u8 *mac,
> +                                       struct ieee80211_vif *vif)
> +{
> +       struct rtl8xxxu_rx_addr_match_data *iter_data =3D data;
> +       struct ieee80211_sta *sta;
> +       struct ieee80211_hdr *hdr =3D iter_data->hdr;
> +       struct rtl8xxxu_priv *priv =3D iter_data->priv;
> +       struct rtl8xxxu_sta_info *sta_info;
> +       struct ieee80211_rx_status *rx_status =3D iter_data->rx_status;
> +       u8 *bssid =3D iter_data->bssid;
> +
> +       if (!ether_addr_equal(vif->bss_conf.bssid, bssid))
> +               return;
> +
> +       if (!(ether_addr_equal(vif->addr, hdr->addr1) ||
> +             ieee80211_is_beacon(hdr->frame_control)))
> +               return;
> +
> +       sta =3D ieee80211_find_sta_by_ifaddr(priv->hw, hdr->addr2,
> +                                          vif->addr);

Can't we search for 'sta' by rx_desc->mac_id? Then, you don't need a lot of
code to check address.=20

> +       if (!sta)
> +               return;
> +
> +       sta_info =3D (struct rtl8xxxu_sta_info *)sta->drv_priv;
> +       ewma_rssi_add(&sta_info->avg_rssi, -rx_status->signal);
> +}
> +

[...]

> @@ -7119,7 +7203,7 @@ static void rtl8xxxu_refresh_rate_mask(struct rtl8x=
xxu_priv *priv,
>         u8 go_up_gap =3D 5;
>         u8 macid =3D rtl8xxxu_get_macid(priv, sta);
>=20
> -       rssi_level =3D priv->rssi_level;
> +       rssi_level =3D priv->rssi_level[macid];

Is it possible to move 'rssi_level' into struct rtl8xxxu_sta_info?

>         snr =3D rtl8xxxu_signal_to_snr(signal);
>         snr_thresh_high =3D RTL8XXXU_SNR_THRESH_HIGH;
>         snr_thresh_low =3D RTL8XXXU_SNR_THRESH_LOW;

[...]

> @@ -7329,40 +7411,60 @@ static void rtl8xxxu_track_cfo(struct rtl8xxxu_pr=
iv *priv)
>         rtl8xxxu_set_atc_status(priv, abs(cfo_average) >=3D CFO_TH_ATC);
>  }
>=20
> -static void rtl8xxxu_watchdog_callback(struct work_struct *work)
> +static void rtl8xxxu_ra_iter(void *data, struct ieee80211_sta *sta)
>  {
> -       struct ieee80211_vif *vif;
> -       struct rtl8xxxu_priv *priv;
> -       int i;
> +       struct rtl8xxxu_sta_info *sta_info =3D (struct rtl8xxxu_sta_info =
*)sta->drv_priv;
> +       struct rtl8xxxu_priv *priv =3D data;
> +       int signal =3D -ewma_rssi_read(&sta_info->avg_rssi);

The unit conversion of signal is a little complicated --
from physt to rx_status->signal to sta_info->avg_rssi.

I think you did it well. Just want to confirm have you checked the final re=
sult
is equal to before at runtime?

[...]


