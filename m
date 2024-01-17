Return-Path: <linux-wireless+bounces-2101-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C2D8308D9
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jan 2024 15:55:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DFF2B22673
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jan 2024 14:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA4DD20DCB;
	Wed, 17 Jan 2024 14:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="U1+wUjxY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kgCbnQPj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66AC720DC9
	for <linux-wireless@vger.kernel.org>; Wed, 17 Jan 2024 14:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705503326; cv=none; b=eZYH48Nw7TFPNUo0oeXp8NvObhHxLexoQjIVVLLPHJbAOrB+y5sXHWab84A3mD102JNSbRlObbCSLIOzmZ0eOubE6DeG4TUaS5yJGr5k/XXrR2pBSxdBhbjriklLyBgiu20UE8n/yf+QWLOD1qbJ9D45dZh/OtIuflZZRFuXY9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705503326; c=relaxed/simple;
	bh=7vbKaBcY5+T/+rlvLKukazcWUpa/DZLz7DdOLxQrmfM=;
	h=From:DKIM-Signature:DKIM-Signature:To:Cc:Subject:Date:Message-Id:
	 MIME-Version:Content-Transfer-Encoding; b=P891YvbFYG+jOTe8GehKhOOIYNhc8t1IhQsmd4Z++qjIlC03tTdgiFTjivU0Op1cTgTXM2ZJrMLqaUkpdOGQ8rfPxhEqq4mw1vu/Bt3/T65vhESwcurxRcU/hhqMS/LUM9a7ldBq+jhWyvwR2hygBWwBydzJaongpvuIsLhut/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=U1+wUjxY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kgCbnQPj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Martin Kaistra <martin.kaistra@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1705503321;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZciErcMG94nRazHpNWMDK/eJgGDY+5lgvyqivN/wuOI=;
	b=U1+wUjxYom4PCVhXFaBodcoJ4+wl1ZQhxsL0moygghh9sOt+N+ewtlaT+/GEgx41YQOtq3
	ZD89n9ATIV73/qBo+TyMqvR9D4mqYoKaLU4mX8uL0WsOT0aYTy5RYcLGg9nZAqzdrpM2Qf
	iRnC1Lo/Jno1rtBoOejCkBFRftsBVj4u4S0fupcf9uO4aFoljvh9B2wDJkZOQTFZnonIc2
	7w3HwcegVWTmbi/1YqdhCUc5Af8qDu3YgN9MhJZG0jtanOoyBav5aiPN4i7Q9jkd6grt/+
	kvuW1SwEy1NbuWvAn4au1K5hnWA56x/Hnu1L6/lawxwbmbH651vUONuraY+m3A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1705503321;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ZciErcMG94nRazHpNWMDK/eJgGDY+5lgvyqivN/wuOI=;
	b=kgCbnQPjkY+IvRIaKBb1KrOU3pEsaKYbDmOVeMwZwUeWtHIJuLmDUpTOfnXqbqKylx+HZL
	PlcP8rsiBdlGuwAg==
To: linux-wireless@vger.kernel.org
Cc: Jes Sorensen <Jes.Sorensen@gmail.com>,
	Kalle Valo <kvalo@kernel.org>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH] wifi: rtl8xxxu: update rate mask per sta
Date: Wed, 17 Jan 2024 15:55:16 +0100
Message-Id: <20240117145516.497966-1-martin.kaistra@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Until now, rtl8xxxu_watchdog_callback() only fetches RSSI and updates
the rate mask in station mode. This means, in AP mode only the default
rate mask is used.

In order to have the rate mask reflect the actual connection quality,
extend rtl8xxxu_watchdog_callback() to iterate over every sta. Like in
the rtw88 driver, add a function to collect all currently present stas
and then iterate over a list of copies to ensure no RCU lock problems
for register access via USB. Remove the existing RCU lock in
rtl8xxxu_refresh_rate_mask().

Since the currently used ieee80211_ave_rssi() is only for 'vif', add
driver-level tracking of RSSI per sta.

Signed-off-by: Martin Kaistra <martin.kaistra@linutronix.de>
---
 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu.h  |   8 +-
 .../wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 182 ++++++++++++++----
 2 files changed, 153 insertions(+), 37 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
index 03307da67c2c3..9f6e67218f49e 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
@@ -6,6 +6,7 @@
  */
 
 #include <asm/byteorder.h>
+#include <linux/average.h>
 
 #define RTL8XXXU_DEBUG_REG_WRITE	0x01
 #define RTL8XXXU_DEBUG_REG_READ		0x02
@@ -1858,6 +1859,8 @@ struct rtl8xxxu_priv {
 	int next_mbox;
 	int nr_out_eps;
 
+	/* Ensure no added or deleted stas while iterating */
+	struct mutex sta_mutex;
 	struct mutex h2c_mutex;
 	/* Protect the indirect register accesses of RTL8710BU. */
 	struct mutex syson_indirect_access_mutex;
@@ -1892,7 +1895,7 @@ struct rtl8xxxu_priv {
 	u8 pi_enabled:1;
 	u8 no_pape:1;
 	u8 int_buf[USB_INTR_CONTENT_LENGTH];
-	u8 rssi_level;
+	u8 rssi_level[RTL8XXXU_MAX_MAC_ID_NUM];
 	DECLARE_BITMAP(tx_aggr_started, IEEE80211_NUM_TIDS);
 	DECLARE_BITMAP(tid_tx_operational, IEEE80211_NUM_TIDS);
 
@@ -1913,11 +1916,14 @@ struct rtl8xxxu_priv {
 	DECLARE_BITMAP(cam_map, RTL8XXXU_MAX_SEC_CAM_NUM);
 };
 
+DECLARE_EWMA(rssi, 10, 16);
+
 struct rtl8xxxu_sta_info {
 	struct ieee80211_sta *sta;
 	struct ieee80211_vif *vif;
 
 	u8 macid;
+	struct ewma_rssi avg_rssi;
 };
 
 struct rtl8xxxu_vif {
diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
index 521faa48803c7..bf2539ab3ae0a 100644
--- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
+++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
@@ -4993,8 +4993,8 @@ rtl8xxxu_bss_info_changed(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	struct device *dev = &priv->udev->dev;
 	struct ieee80211_sta *sta;
 	struct rtl8xxxu_ra_report *rarpt;
+	u8 val8, macid;
 	u32 val32;
-	u8 val8;
 
 	rarpt = &priv->ra_report;
 
@@ -5017,6 +5017,7 @@ rtl8xxxu_bss_info_changed(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 				rcu_read_unlock();
 				goto error;
 			}
+			macid = rtl8xxxu_get_macid(priv, sta);
 
 			if (sta->deflink.ht_cap.ht_supported)
 				dev_info(dev, "%s: HT supported\n", __func__);
@@ -5041,10 +5042,10 @@ rtl8xxxu_bss_info_changed(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 
 			rtl8xxxu_update_ra_report(rarpt, highest_rate, sgi, bw);
 
-			priv->rssi_level = RTL8XXXU_RATR_STA_INIT;
+			priv->rssi_level[macid] = RTL8XXXU_RATR_STA_INIT;
 
 			priv->fops->update_rate_mask(priv, ramask, 0, sgi,
-						     bw == RATE_INFO_BW_40, 0);
+						     bw == RATE_INFO_BW_40, macid);
 
 			rtl8xxxu_write8(priv, REG_BCN_MAX_ERR, 0xff);
 
@@ -6317,6 +6318,76 @@ static void rtl8188e_c2hcmd_callback(struct work_struct *work)
 	}
 }
 
+#define rtl8xxxu_iterate_vifs_atomic(priv, iterator, data)			\
+	ieee80211_iterate_active_interfaces_atomic((priv)->hw,			\
+			IEEE80211_IFACE_ITER_NORMAL, iterator, data)
+
+struct rtl8xxxu_rx_addr_match_data {
+	struct rtl8xxxu_priv *priv;
+	struct ieee80211_hdr *hdr;
+	struct ieee80211_rx_status *rx_status;
+	u8 *bssid;
+};
+
+static void rtl8xxxu_rx_addr_match_iter(void *data, u8 *mac,
+					struct ieee80211_vif *vif)
+{
+	struct rtl8xxxu_rx_addr_match_data *iter_data = data;
+	struct ieee80211_sta *sta;
+	struct ieee80211_hdr *hdr = iter_data->hdr;
+	struct rtl8xxxu_priv *priv = iter_data->priv;
+	struct rtl8xxxu_sta_info *sta_info;
+	struct ieee80211_rx_status *rx_status = iter_data->rx_status;
+	u8 *bssid = iter_data->bssid;
+
+	if (!ether_addr_equal(vif->bss_conf.bssid, bssid))
+		return;
+
+	if (!(ether_addr_equal(vif->addr, hdr->addr1) ||
+	      ieee80211_is_beacon(hdr->frame_control)))
+		return;
+
+	sta = ieee80211_find_sta_by_ifaddr(priv->hw, hdr->addr2,
+					   vif->addr);
+	if (!sta)
+		return;
+
+	sta_info = (struct rtl8xxxu_sta_info *)sta->drv_priv;
+	ewma_rssi_add(&sta_info->avg_rssi, -rx_status->signal);
+}
+
+static inline u8 *get_hdr_bssid(struct ieee80211_hdr *hdr)
+{
+	__le16 fc = hdr->frame_control;
+	u8 *bssid;
+
+	if (ieee80211_has_tods(fc))
+		bssid = hdr->addr1;
+	else if (ieee80211_has_fromds(fc))
+		bssid = hdr->addr2;
+	else
+		bssid = hdr->addr3;
+
+	return bssid;
+}
+
+static void rtl8xxxu_rx_addr_match(struct rtl8xxxu_priv *priv,
+				   struct ieee80211_rx_status *rx_status,
+				   struct ieee80211_hdr *hdr)
+{
+	struct rtl8xxxu_rx_addr_match_data data = {};
+
+	if (ieee80211_is_ctl(hdr->frame_control))
+		return;
+
+	data.priv = priv;
+	data.hdr = hdr;
+	data.rx_status = rx_status;
+	data.bssid = get_hdr_bssid(hdr);
+
+	rtl8xxxu_iterate_vifs_atomic(priv, rtl8xxxu_rx_addr_match_iter, &data);
+}
+
 int rtl8xxxu_parse_rxdesc16(struct rtl8xxxu_priv *priv, struct sk_buff *skb)
 {
 	struct ieee80211_hw *hw = priv->hw;
@@ -6376,18 +6447,26 @@ int rtl8xxxu_parse_rxdesc16(struct rtl8xxxu_priv *priv, struct sk_buff *skb)
 			skb_queue_tail(&priv->c2hcmd_queue, skb);
 			schedule_work(&priv->c2hcmd_work);
 		} else {
+			struct ieee80211_hdr *hdr;
+
 			phy_stats = (struct rtl8723au_phy_stats *)skb->data;
 
 			skb_pull(skb, drvinfo_sz + desc_shift);
 
 			skb_trim(skb, pkt_len);
 
-			if (rx_desc->phy_stats)
+			hdr = (struct ieee80211_hdr *)skb->data;
+			if (rx_desc->phy_stats) {
 				priv->fops->parse_phystats(
 					priv, rx_status, phy_stats,
 					rx_desc->rxmcs,
-					(struct ieee80211_hdr *)skb->data,
+					hdr,
 					rx_desc->crc32 || rx_desc->icverr);
+				if (!rx_desc->crc32 && !rx_desc->icverr)
+					rtl8xxxu_rx_addr_match(priv,
+							       rx_status,
+							       hdr);
+			}
 
 			rx_status->mactime = rx_desc->tsfl;
 			rx_status->flag |= RX_FLAG_MACTIME_START;
@@ -6484,10 +6563,15 @@ int rtl8xxxu_parse_rxdesc24(struct rtl8xxxu_priv *priv, struct sk_buff *skb)
 		} else {
 			struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
 
-			if (rx_desc->phy_stats)
+			if (rx_desc->phy_stats) {
 				priv->fops->parse_phystats(priv, rx_status, phy_stats,
 							   rx_desc->rxmcs, hdr,
 							   rx_desc->crc32 || rx_desc->icverr);
+				if (!rx_desc->crc32 && !rx_desc->icverr)
+					rtl8xxxu_rx_addr_match(priv,
+							       rx_status,
+							       hdr);
+			}
 
 			rx_status->mactime = rx_desc->tsfl;
 			rx_status->flag |= RX_FLAG_MACTIME_START;
@@ -7119,7 +7203,7 @@ static void rtl8xxxu_refresh_rate_mask(struct rtl8xxxu_priv *priv,
 	u8 go_up_gap = 5;
 	u8 macid = rtl8xxxu_get_macid(priv, sta);
 
-	rssi_level = priv->rssi_level;
+	rssi_level = priv->rssi_level[macid];
 	snr = rtl8xxxu_signal_to_snr(signal);
 	snr_thresh_high = RTL8XXXU_SNR_THRESH_HIGH;
 	snr_thresh_low = RTL8XXXU_SNR_THRESH_LOW;
@@ -7144,18 +7228,16 @@ static void rtl8xxxu_refresh_rate_mask(struct rtl8xxxu_priv *priv,
 	else
 		rssi_level = RTL8XXXU_RATR_STA_LOW;
 
-	if (rssi_level != priv->rssi_level || force) {
+	if (rssi_level != priv->rssi_level[macid] || force) {
 		int sgi = 0;
 		u32 rate_bitmap = 0;
 
-		rcu_read_lock();
 		rate_bitmap = (sta->deflink.supp_rates[0] & 0xfff) |
 				(sta->deflink.ht_cap.mcs.rx_mask[0] << 12) |
 				(sta->deflink.ht_cap.mcs.rx_mask[1] << 20);
 		if (sta->deflink.ht_cap.cap &
 		    (IEEE80211_HT_CAP_SGI_40 | IEEE80211_HT_CAP_SGI_20))
 			sgi = 1;
-		rcu_read_unlock();
 
 		wireless_mode = rtl8xxxu_wireless_mode(hw, sta);
 		switch (wireless_mode) {
@@ -7236,7 +7318,7 @@ static void rtl8xxxu_refresh_rate_mask(struct rtl8xxxu_priv *priv,
 			break;
 		}
 
-		priv->rssi_level = rssi_level;
+		priv->rssi_level[macid] = rssi_level;
 		priv->fops->update_rate_mask(priv, rate_bitmap, ratr_idx, sgi, txbw_40mhz, macid);
 	}
 }
@@ -7329,40 +7411,60 @@ static void rtl8xxxu_track_cfo(struct rtl8xxxu_priv *priv)
 	rtl8xxxu_set_atc_status(priv, abs(cfo_average) >= CFO_TH_ATC);
 }
 
-static void rtl8xxxu_watchdog_callback(struct work_struct *work)
+static void rtl8xxxu_ra_iter(void *data, struct ieee80211_sta *sta)
 {
-	struct ieee80211_vif *vif;
-	struct rtl8xxxu_priv *priv;
-	int i;
+	struct rtl8xxxu_sta_info *sta_info = (struct rtl8xxxu_sta_info *)sta->drv_priv;
+	struct rtl8xxxu_priv *priv = data;
+	int signal = -ewma_rssi_read(&sta_info->avg_rssi);
 
-	priv = container_of(work, struct rtl8xxxu_priv, ra_watchdog.work);
-	for (i = 0; i < ARRAY_SIZE(priv->vifs); i++) {
-		vif = priv->vifs[i];
+	priv->fops->report_rssi(priv, rtl8xxxu_get_macid(priv, sta),
+				rtl8xxxu_signal_to_snr(signal));
+	rtl8xxxu_refresh_rate_mask(priv, signal, sta, false);
+}
 
-		if (!vif || vif->type != NL80211_IFTYPE_STATION)
-			continue;
+struct rtl8xxxu_stas_entry {
+	struct list_head list;
+	struct ieee80211_sta *sta;
+};
 
-		int signal;
-		struct ieee80211_sta *sta;
+struct rtl8xxxu_iter_stas_data {
+	struct rtl8xxxu_priv *priv;
+	struct list_head list;
+};
 
-		rcu_read_lock();
-		sta = ieee80211_find_sta(vif, vif->bss_conf.bssid);
-		if (!sta) {
-			struct device *dev = &priv->udev->dev;
+static void rtl8xxxu_collect_sta_iter(void *data, struct ieee80211_sta *sta)
+{
+	struct rtl8xxxu_iter_stas_data *iter_stas = data;
+	struct rtl8xxxu_stas_entry *stas_entry;
 
-			dev_dbg(dev, "%s: no sta found\n", __func__);
-			rcu_read_unlock();
-			continue;
-		}
-		rcu_read_unlock();
+	stas_entry = kmalloc(sizeof(*stas_entry), GFP_ATOMIC);
+	if (!stas_entry)
+		return;
 
-		signal = ieee80211_ave_rssi(vif);
+	stas_entry->sta = sta;
+	list_add_tail(&stas_entry->list, &iter_stas->list);
+}
+
+static void rtl8xxxu_watchdog_callback(struct work_struct *work)
+{
 
-		priv->fops->report_rssi(priv, rtl8xxxu_get_macid(priv, sta),
-					rtl8xxxu_signal_to_snr(signal));
+	struct rtl8xxxu_iter_stas_data iter_data;
+	struct rtl8xxxu_stas_entry *sta_entry, *tmp;
+	struct rtl8xxxu_priv *priv;
+
+	priv = container_of(work, struct rtl8xxxu_priv, ra_watchdog.work);
+	iter_data.priv = priv;
+	INIT_LIST_HEAD(&iter_data.list);
 
-		rtl8xxxu_refresh_rate_mask(priv, signal, sta, false);
+	mutex_lock(&priv->sta_mutex);
+	ieee80211_iterate_stations_atomic(priv->hw, rtl8xxxu_collect_sta_iter,
+					  &iter_data);
+	list_for_each_entry_safe(sta_entry, tmp, &iter_data.list, list) {
+		list_del_init(&sta_entry->list);
+		rtl8xxxu_ra_iter(priv, sta_entry->sta);
+		kfree(sta_entry);
 	}
+	mutex_unlock(&priv->sta_mutex);
 
 	if (priv->fops->set_crystal_cap)
 		rtl8xxxu_track_cfo(priv);
@@ -7504,10 +7606,14 @@ static int rtl8xxxu_sta_add(struct ieee80211_hw *hw,
 	struct rtl8xxxu_vif *rtlvif = (struct rtl8xxxu_vif *)vif->drv_priv;
 	struct rtl8xxxu_priv *priv = hw->priv;
 
+	mutex_lock(&priv->sta_mutex);
+	ewma_rssi_init(&sta_info->avg_rssi);
 	if (vif->type == NL80211_IFTYPE_AP) {
 		sta_info->macid = rtl8xxxu_acquire_macid(priv);
-		if (sta_info->macid >= RTL8XXXU_MAX_MAC_ID_NUM)
+		if (sta_info->macid >= RTL8XXXU_MAX_MAC_ID_NUM) {
+			mutex_unlock(&priv->sta_mutex);
 			return -ENOSPC;
+		}
 
 		rtl8xxxu_refresh_rate_mask(priv, 0, sta, true);
 		priv->fops->report_connect(priv, sta_info->macid, H2C_MACID_ROLE_STA, true);
@@ -7523,6 +7629,7 @@ static int rtl8xxxu_sta_add(struct ieee80211_hw *hw,
 			break;
 		}
 	}
+	mutex_unlock(&priv->sta_mutex);
 
 	return 0;
 }
@@ -7534,8 +7641,10 @@ static int rtl8xxxu_sta_remove(struct ieee80211_hw *hw,
 	struct rtl8xxxu_sta_info *sta_info = (struct rtl8xxxu_sta_info *)sta->drv_priv;
 	struct rtl8xxxu_priv *priv = hw->priv;
 
+	mutex_lock(&priv->sta_mutex);
 	if (vif->type == NL80211_IFTYPE_AP)
 		rtl8xxxu_release_macid(priv, sta_info->macid);
+	mutex_unlock(&priv->sta_mutex);
 
 	return 0;
 }
@@ -7767,6 +7876,7 @@ static int rtl8xxxu_probe(struct usb_interface *interface,
 	mutex_init(&priv->usb_buf_mutex);
 	mutex_init(&priv->syson_indirect_access_mutex);
 	mutex_init(&priv->h2c_mutex);
+	mutex_init(&priv->sta_mutex);
 	INIT_LIST_HEAD(&priv->tx_urb_free_list);
 	spin_lock_init(&priv->tx_urb_lock);
 	INIT_LIST_HEAD(&priv->rx_urb_pending_list);
-- 
2.39.2


