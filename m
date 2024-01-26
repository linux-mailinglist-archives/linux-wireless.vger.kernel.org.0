Return-Path: <linux-wireless+bounces-2511-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E76B283D2A8
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jan 2024 03:42:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 919B528B552
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jan 2024 02:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EBAC1C0F;
	Fri, 26 Jan 2024 02:42:12 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80598BE3
	for <linux-wireless@vger.kernel.org>; Fri, 26 Jan 2024 02:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706236932; cv=none; b=aTkBcrZQxXw9HQXmcWUmL3MhQIo0Ut6XDfdY9mDDyqGSrkbNk2NmHyqqoiplbyS2fQ4oeLNACOUlm2gxzobUdaZ2u/QQqt3eF+HeDCQWuUgaXKTiNWibIzekOrQBqsP/prM+dgmx3xTwkZuTxP7DtJf3NTWBnLInRhvLtGwdxZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706236932; c=relaxed/simple;
	bh=1g0Z69ZWdF8fBMZHFmYgD5m66Lr0S9GKH+y5izd3Fu8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JSW3wUQE4fswWyiLg/6OJTNV4lEYPERvRYXHjBC9SLfCudeqXKZKAdYMlGMJl8DqAnPmvsXRduUS6dqA3PgVxIvAmPgjibTVmEfkR04IuHAeCN2iBiJ2A4tUFG0Hg1E5XZrqU+aMrwI3EOAwY3F9zQOeCn7u78bX1SK1dn8bCmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 40Q2fYdyD1959788, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 40Q2fYdyD1959788
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Jan 2024 10:41:34 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Fri, 26 Jan 2024 10:41:34 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 26 Jan 2024 10:41:33 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::c9b7:82a9:7e98:fa7f]) by
 RTEXMBS04.realtek.com.tw ([fe80::c9b7:82a9:7e98:fa7f%7]) with mapi id
 15.01.2507.035; Fri, 26 Jan 2024 10:41:33 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Martin Kaistra <martin.kaistra@linutronix.de>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Jes Sorensen <Jes.Sorensen@gmail.com>, Kalle Valo <kvalo@kernel.org>,
        Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        Sebastian Andrzej Siewior
	<bigeasy@linutronix.de>
Subject: RE: [PATCH v2] wifi: rtl8xxxu: update rate mask per sta
Thread-Topic: [PATCH v2] wifi: rtl8xxxu: update rate mask per sta
Thread-Index: AQHaTp8i41NhHRLX9kC7eSZNdMn/nrDrV10Q
Date: Fri, 26 Jan 2024 02:41:33 +0000
Message-ID: <e6011da5e0144d7ea3556d0ec99aa1a0@realtek.com>
References: <20240124082705.1098960-1-martin.kaistra@linutronix.de>
In-Reply-To: <20240124082705.1098960-1-martin.kaistra@linutronix.de>
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
> Sent: Wednesday, January 24, 2024 4:27 PM
> To: linux-wireless@vger.kernel.org
> Cc: Jes Sorensen <Jes.Sorensen@gmail.com>; Kalle Valo <kvalo@kernel.org>;=
 Ping-Ke Shih
> <pkshih@realtek.com>; Bitterblue Smith <rtl8821cerfe2@gmail.com>; Sebasti=
an Andrzej Siewior
> <bigeasy@linutronix.de>
> Subject: [PATCH v2] wifi: rtl8xxxu: update rate mask per sta
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
> ---
> changes v1->v2: move 'rssi_level' into struct rtl8xxxu_sta_info
> v1: https://lore.kernel.org/linux-wireless/20240117145516.497966-1-martin=
.kaistra@linutronix.de/

[...]

> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
> b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
> index 3b954c2fe448f..3820d3c308759 100644
> --- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
> +++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
> @@ -4993,8 +4993,8 @@ rtl8xxxu_bss_info_changed(struct ieee80211_hw *hw, =
struct ieee80211_vif *vif,
>         struct device *dev =3D &priv->udev->dev;
>         struct ieee80211_sta *sta;
>         struct rtl8xxxu_ra_report *rarpt;
> +       u8 val8, macid;
>         u32 val32;
> -       u8 val8;
>=20
>         rarpt =3D &priv->ra_report;
>=20
> @@ -5004,6 +5004,7 @@ rtl8xxxu_bss_info_changed(struct ieee80211_hw *hw, =
struct ieee80211_vif *vif,
>                 rtl8xxxu_set_linktype(priv, vif->type, rtlvif->port_num);
>=20
>                 if (vif->cfg.assoc) {
> +                       struct rtl8xxxu_sta_info *sta_info;

nit: I remember that declaration at beginning of function is preferred.=20

>                         u32 ramask;
>                         int sgi =3D 0;
>                         u8 highest_rate;
> @@ -5017,6 +5018,7 @@ rtl8xxxu_bss_info_changed(struct ieee80211_hw *hw, =
struct ieee80211_vif *vif,
>                                 rcu_read_unlock();
>                                 goto error;
>                         }
> +                       macid =3D rtl8xxxu_get_macid(priv, sta);
>=20
>                         if (sta->deflink.ht_cap.ht_supported)
>                                 dev_info(dev, "%s: HT supported\n", __fun=
c__);
> @@ -5037,14 +5039,15 @@ rtl8xxxu_bss_info_changed(struct ieee80211_hw *hw=
, struct ieee80211_vif *vif,
>                                 bw =3D RATE_INFO_BW_40;
>                         else
>                                 bw =3D RATE_INFO_BW_20;
> +
> +                       sta_info =3D (struct rtl8xxxu_sta_info *)sta->drv=
_priv;
> +                       sta_info->rssi_level =3D RTL8XXXU_RATR_STA_INIT;

For AP mode, we should do this as well at rtl8xxxu_sta_add() before calling
rtl8xxxu_refresh_rate_mask()?

>                         rcu_read_unlock();
>=20
>                         rtl8xxxu_update_ra_report(rarpt, highest_rate, sg=
i, bw);
>=20
> -                       priv->rssi_level =3D RTL8XXXU_RATR_STA_INIT;
> -
>                         priv->fops->update_rate_mask(priv, ramask, 0, sgi=
,
> -                                                    bw =3D=3D RATE_INFO_=
BW_40, 0);
> +                                                    bw =3D=3D RATE_INFO_=
BW_40, macid);
>=20
>                         rtl8xxxu_write8(priv, REG_BCN_MAX_ERR, 0xff);
>=20
> @@ -6317,6 +6320,76 @@ static void rtl8188e_c2hcmd_callback(struct work_s=
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

nit: Here checks bssid, addr1 and beacon frame. For me, if you want to comb=
ine
some of them, would it be reasonable to combine bssid and add1?=20

> +
> +       sta =3D ieee80211_find_sta_by_ifaddr(priv->hw, hdr->addr2,
> +                                          vif->addr);
> +       if (!sta)
> +               return;
> +
> +       sta_info =3D (struct rtl8xxxu_sta_info *)sta->drv_priv;
> +       ewma_rssi_add(&sta_info->avg_rssi, -rx_status->signal);
> +}
> +
> +static inline u8 *get_hdr_bssid(struct ieee80211_hdr *hdr)

Would you like to add a ieee80211_get_BSSID() to ieee80211.h in separated=20
patch? But I wonder if it is enough to check addr1 only?

> +{
> +       __le16 fc =3D hdr->frame_control;
> +       u8 *bssid;
> +
> +       if (ieee80211_has_tods(fc))
> +               bssid =3D hdr->addr1;
> +       else if (ieee80211_has_fromds(fc))
> +               bssid =3D hdr->addr2;
> +       else
> +               bssid =3D hdr->addr3;
> +
> +       return bssid;
> +}
> +
> +static void rtl8xxxu_rx_addr_match(struct rtl8xxxu_priv *priv,
> +                                  struct ieee80211_rx_status *rx_status,
> +                                  struct ieee80211_hdr *hdr)
> +{
> +       struct rtl8xxxu_rx_addr_match_data data =3D {};
> +
> +       if (ieee80211_is_ctl(hdr->frame_control))
> +               return;
> +
> +       data.priv =3D priv;
> +       data.hdr =3D hdr;
> +       data.rx_status =3D rx_status;
> +       data.bssid =3D get_hdr_bssid(hdr);
> +
> +       rtl8xxxu_iterate_vifs_atomic(priv, rtl8xxxu_rx_addr_match_iter, &=
data);
> +}
> +
>  int rtl8xxxu_parse_rxdesc16(struct rtl8xxxu_priv *priv, struct sk_buff *=
skb)
>  {
>         struct ieee80211_hw *hw =3D priv->hw;
> @@ -6376,18 +6449,26 @@ int rtl8xxxu_parse_rxdesc16(struct rtl8xxxu_priv =
*priv, struct sk_buff *skb)
>                         skb_queue_tail(&priv->c2hcmd_queue, skb);
>                         schedule_work(&priv->c2hcmd_work);
>                 } else {
> +                       struct ieee80211_hdr *hdr;
> +
>                         phy_stats =3D (struct rtl8723au_phy_stats *)skb->=
data;
>=20
>                         skb_pull(skb, drvinfo_sz + desc_shift);
>=20
>                         skb_trim(skb, pkt_len);
>=20
> -                       if (rx_desc->phy_stats)
> +                       hdr =3D (struct ieee80211_hdr *)skb->data;
> +                       if (rx_desc->phy_stats) {
>                                 priv->fops->parse_phystats(
>                                         priv, rx_status, phy_stats,
>                                         rx_desc->rxmcs,
> -                                       (struct ieee80211_hdr *)skb->data=
,
> +                                       hdr,
>                                         rx_desc->crc32 || rx_desc->icverr=
);
> +                               if (!rx_desc->crc32 && !rx_desc->icverr)
> +                                       rtl8xxxu_rx_addr_match(priv,
> +                                                              rx_status,
> +                                                              hdr);

This function name isn't clear, because it doesn't just match rx addr,
but it is to update RSSI by rx_status for corresponding station.=20

> +                       }
>=20
>                         rx_status->mactime =3D rx_desc->tsfl;
>                         rx_status->flag |=3D RX_FLAG_MACTIME_START;

[...]


