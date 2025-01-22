Return-Path: <linux-wireless+bounces-17815-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5281A18B9B
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Jan 2025 07:04:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 328F31883273
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Jan 2025 06:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B05C54738;
	Wed, 22 Jan 2025 06:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="thMjefaw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CBF61AF0DB
	for <linux-wireless@vger.kernel.org>; Wed, 22 Jan 2025 06:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737525828; cv=none; b=o6rZiXthNNAyJT1xqKTNrBrWTmGTvtRyUAZNl6XF5iVRP6TNF+/NBy8LdLvqZQcu3f1WVhwqC7qPcw1Uob09/UAXAqUd0t5sc9oXFxOAsELnyxOJhJkwz1wC5vPDmDDaejMXJdjqGFEvsYKSiKrUsBbVPZ99EMb49pGeNGnkQO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737525828; c=relaxed/simple;
	bh=M8bSCEK541XTVsy4VS1bMpFn7zI/JJcSur/yfBo2W1M=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=moOsQ0VSU4rhDCytS3LXv8CCESGfFVH/O/Budlvl+Dg0BNuIfIRJ+trkOE5aNAUtTkO6IKrW03j84p0dyLGp2fbe3CuWBOfkAR1s9jH3QMEkaMgoH/x1rqX8p0ReTh/i8qMNNGZcWgIwP2VcKFdfYW9oHfxHqDZWmSjAY8UEfKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=thMjefaw; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 50M63g7X22494514, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1737525822; bh=M8bSCEK541XTVsy4VS1bMpFn7zI/JJcSur/yfBo2W1M=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=thMjefawVjTQ7biD8MJSbnFhWD8EBkAEvWJXxtzKSsyit4wnSUZTW6gSNz4MotXiX
	 rID3bO0pE3St9Y7r5S3NMHI9Ukcio/KKEhSQudVqo5A0/ELrwzPNmhzXnepwTJTvoH
	 14gBjVzp9k4VA4WbA6CbwgHAf7M5OCR4yglaz1XqvlJTt3baJ0+3tWeQMZFHTOshxG
	 wtoDs9bHqDoqDvu8KkZb58ej2iH2pwopwlSQE6YkcTcOnLgWdfU/mAk+/fyms5Zw25
	 xOurQNe/i/9vVPVhHKSxMHBO3XiN0Vv85SbWZfBSyjNVU8Pdmttr+F67HUBiWpYrUv
	 /gP0QtOuGGlag==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 50M63g7X22494514
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 22 Jan 2025 14:03:42 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 22 Jan 2025 14:03:42 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 22 Jan
 2025 14:03:42 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH 02/10] wifi: rtw89: use wiphy_work() to replace ieee802111_work()
Date: Wed, 22 Jan 2025 14:03:02 +0800
Message-ID: <20250122060310.31976-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250122060310.31976-1-pkshih@realtek.com>
References: <20250122060310.31976-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

For certain works protected by driver mutex, use wiphy_work() directly
to have wiphy lock held naturally. Then every this kind of works is
protected by both wiphy lock and driver mutex.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/chan.c     |  6 +-
 drivers/net/wireless/realtek/rtw89/chan.h     |  2 +-
 drivers/net/wireless/realtek/rtw89/coex.c     | 38 ++++----
 drivers/net/wireless/realtek/rtw89/coex.h     | 14 +--
 drivers/net/wireless/realtek/rtw89/core.c     | 96 ++++++++++---------
 drivers/net/wireless/realtek/rtw89/core.h     | 36 +++----
 drivers/net/wireless/realtek/rtw89/fw.c       |  4 +-
 drivers/net/wireless/realtek/rtw89/fw.h       |  2 +-
 drivers/net/wireless/realtek/rtw89/mac80211.c | 21 ++--
 drivers/net/wireless/realtek/rtw89/phy.c      | 18 ++--
 drivers/net/wireless/realtek/rtw89/phy.h      |  4 +-
 drivers/net/wireless/realtek/rtw89/ser.c      |  9 +-
 12 files changed, 128 insertions(+), 122 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/chan.c b/drivers/net/wireless/realtek/rtw89/chan.c
index 4df4e04c3e67..9858894dfc23 100644
--- a/drivers/net/wireless/realtek/rtw89/chan.c
+++ b/drivers/net/wireless/realtek/rtw89/chan.c
@@ -2390,7 +2390,7 @@ static void rtw89_mcc_update_limit(struct rtw89_dev *rtwdev)
 	rtw89_iterate_mcc_roles(rtwdev, rtw89_mcc_upd_lmt_iterator, NULL);
 }
 
-void rtw89_chanctx_work(struct work_struct *work)
+void rtw89_chanctx_work(struct wiphy *wiphy, struct wiphy_work *work)
 {
 	struct rtw89_dev *rtwdev = container_of(work, struct rtw89_dev,
 						chanctx_work.work);
@@ -2477,8 +2477,8 @@ void rtw89_queue_chanctx_change(struct rtw89_dev *rtwdev,
 	rtw89_debug(rtwdev, RTW89_DBG_CHAN,
 		    "queue chanctx work for mode %d with delay %d us\n",
 		    mode, delay);
-	ieee80211_queue_delayed_work(rtwdev->hw, &rtwdev->chanctx_work,
-				     usecs_to_jiffies(delay));
+	wiphy_delayed_work_queue(rtwdev->hw->wiphy, &rtwdev->chanctx_work,
+				 usecs_to_jiffies(delay));
 }
 
 void rtw89_queue_chanctx_work(struct rtw89_dev *rtwdev)
diff --git a/drivers/net/wireless/realtek/rtw89/chan.h b/drivers/net/wireless/realtek/rtw89/chan.h
index 092a6f676894..e6391f6f2aa7 100644
--- a/drivers/net/wireless/realtek/rtw89/chan.h
+++ b/drivers/net/wireless/realtek/rtw89/chan.h
@@ -99,7 +99,7 @@ void rtw89_config_roc_chandef(struct rtw89_dev *rtwdev,
 			      const struct cfg80211_chan_def *chandef);
 void rtw89_entity_init(struct rtw89_dev *rtwdev);
 enum rtw89_entity_mode rtw89_entity_recalc(struct rtw89_dev *rtwdev);
-void rtw89_chanctx_work(struct work_struct *work);
+void rtw89_chanctx_work(struct wiphy *wiphy, struct wiphy_work *work);
 void rtw89_queue_chanctx_work(struct rtw89_dev *rtwdev);
 void rtw89_queue_chanctx_change(struct rtw89_dev *rtwdev,
 				enum rtw89_chanctx_changes change);
diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index 755c157c815d..c51c06909966 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -6712,7 +6712,7 @@ static void _update_wl_info_v8(struct rtw89_dev *rtwdev, u8 role_id, u8 rlink_id
 	_fw_set_drv_info(rtwdev, CXDRVINFO_ROLE);
 }
 
-void rtw89_coex_act1_work(struct work_struct *work)
+void rtw89_coex_act1_work(struct wiphy *wiphy, struct wiphy_work *work)
 {
 	struct rtw89_dev *rtwdev = container_of(work, struct rtw89_dev,
 						coex_act1_work.work);
@@ -6733,7 +6733,7 @@ void rtw89_coex_act1_work(struct work_struct *work)
 	mutex_unlock(&rtwdev->mutex);
 }
 
-void rtw89_coex_bt_devinfo_work(struct work_struct *work)
+void rtw89_coex_bt_devinfo_work(struct wiphy *wiphy, struct wiphy_work *work)
 {
 	struct rtw89_dev *rtwdev = container_of(work, struct rtw89_dev,
 						coex_bt_devinfo_work.work);
@@ -6749,7 +6749,7 @@ void rtw89_coex_bt_devinfo_work(struct work_struct *work)
 	mutex_unlock(&rtwdev->mutex);
 }
 
-void rtw89_coex_rfk_chk_work(struct work_struct *work)
+void rtw89_coex_rfk_chk_work(struct wiphy *wiphy, struct wiphy_work *work)
 {
 	struct rtw89_dev *rtwdev = container_of(work, struct rtw89_dev,
 						coex_rfk_chk_work.work);
@@ -7278,7 +7278,7 @@ void rtw89_btc_ntfy_specific_packet(struct rtw89_dev *rtwdev,
 			    "[BTC], %s(): EAPOL_End cnt=%d\n",
 			    __func__, cnt);
 		wl->status.map._4way = false;
-		cancel_delayed_work(&rtwdev->coex_act1_work);
+		wiphy_delayed_work_cancel(rtwdev->hw->wiphy, &rtwdev->coex_act1_work);
 		break;
 	case PACKET_ARP:
 		cnt = ++cx->cnt_wl[BTC_WCNT_ARP];
@@ -7297,16 +7297,16 @@ void rtw89_btc_ntfy_specific_packet(struct rtw89_dev *rtwdev,
 	}
 
 	if (delay_work) {
-		cancel_delayed_work(&rtwdev->coex_act1_work);
-		ieee80211_queue_delayed_work(rtwdev->hw,
-					     &rtwdev->coex_act1_work, delay);
+		wiphy_delayed_work_cancel(rtwdev->hw->wiphy, &rtwdev->coex_act1_work);
+		wiphy_delayed_work_queue(rtwdev->hw->wiphy,
+					 &rtwdev->coex_act1_work, delay);
 	}
 
 	btc->dm.cnt_notify[BTC_NCNT_SPECIAL_PACKET]++;
 	_run_coex(rtwdev, BTC_RSN_NTFY_SPECIFIC_PACKET);
 }
 
-void rtw89_btc_ntfy_eapol_packet_work(struct work_struct *work)
+void rtw89_btc_ntfy_eapol_packet_work(struct wiphy *wiphy, struct wiphy_work *work)
 {
 	struct rtw89_dev *rtwdev = container_of(work, struct rtw89_dev,
 						btc.eapol_notify_work);
@@ -7317,7 +7317,7 @@ void rtw89_btc_ntfy_eapol_packet_work(struct work_struct *work)
 	mutex_unlock(&rtwdev->mutex);
 }
 
-void rtw89_btc_ntfy_arp_packet_work(struct work_struct *work)
+void rtw89_btc_ntfy_arp_packet_work(struct wiphy *wiphy, struct wiphy_work *work)
 {
 	struct rtw89_dev *rtwdev = container_of(work, struct rtw89_dev,
 						btc.arp_notify_work);
@@ -7327,7 +7327,7 @@ void rtw89_btc_ntfy_arp_packet_work(struct work_struct *work)
 	mutex_unlock(&rtwdev->mutex);
 }
 
-void rtw89_btc_ntfy_dhcp_packet_work(struct work_struct *work)
+void rtw89_btc_ntfy_dhcp_packet_work(struct wiphy *wiphy, struct wiphy_work *work)
 {
 	struct rtw89_dev *rtwdev = container_of(work, struct rtw89_dev,
 						btc.dhcp_notify_work);
@@ -7338,7 +7338,7 @@ void rtw89_btc_ntfy_dhcp_packet_work(struct work_struct *work)
 	mutex_unlock(&rtwdev->mutex);
 }
 
-void rtw89_btc_ntfy_icmp_packet_work(struct work_struct *work)
+void rtw89_btc_ntfy_icmp_packet_work(struct wiphy *wiphy, struct wiphy_work *work)
 {
 	struct rtw89_dev *rtwdev = container_of(work, struct rtw89_dev,
 						btc.icmp_notify_work);
@@ -7525,9 +7525,9 @@ static void _update_bt_info(struct rtw89_dev *rtwdev, u8 *buf, u32 len)
 		a2dp->vendor_id = 0;
 		a2dp->flush_time = 0;
 		a2dp->play_latency = 1;
-		ieee80211_queue_delayed_work(rtwdev->hw,
-					     &rtwdev->coex_bt_devinfo_work,
-					     RTW89_COEX_BT_DEVINFO_WORK_PERIOD);
+		wiphy_delayed_work_queue(rtwdev->hw->wiphy,
+					 &rtwdev->coex_bt_devinfo_work,
+					 RTW89_COEX_BT_DEVINFO_WORK_PERIOD);
 	}
 
 	_run_coex(rtwdev, BTC_RSN_UPDATE_BT_INFO);
@@ -7776,7 +7776,7 @@ static bool _ntfy_wl_rfk(struct rtw89_dev *rtwdev, u8 phy_path,
 		wl->rfk_info.state = BTC_WRFK_STOP;
 
 		_write_scbd(rtwdev, BTC_WSCB_WLRFK, false);
-		cancel_delayed_work(&rtwdev->coex_rfk_chk_work);
+		wiphy_delayed_work_cancel(rtwdev->hw->wiphy, &rtwdev->coex_rfk_chk_work);
 		break;
 	default:
 		rtw89_debug(rtwdev, RTW89_DBG_BTC,
@@ -7790,9 +7790,9 @@ static bool _ntfy_wl_rfk(struct rtw89_dev *rtwdev, u8 phy_path,
 			_run_coex(rtwdev, BTC_RSN_NTFY_WL_RFK);
 
 		if (wl->rfk_info.state == BTC_WRFK_START)
-			ieee80211_queue_delayed_work(rtwdev->hw,
-						     &rtwdev->coex_rfk_chk_work,
-						     RTW89_COEX_RFK_CHK_WORK_PERIOD);
+			wiphy_delayed_work_queue(rtwdev->hw->wiphy,
+						 &rtwdev->coex_rfk_chk_work,
+						 RTW89_COEX_RFK_CHK_WORK_PERIOD);
 	}
 
 	rtw89_debug(rtwdev, RTW89_DBG_BTC,
@@ -7810,6 +7810,8 @@ void rtw89_btc_ntfy_wl_rfk(struct rtw89_dev *rtwdev, u8 phy_map,
 	bool allow;
 	int ret;
 
+	lockdep_assert_wiphy(rtwdev->hw->wiphy);
+
 	band = FIELD_GET(BTC_RFK_BAND_MAP, phy_map);
 
 	rtw89_debug(rtwdev, RTW89_DBG_RFK,
diff --git a/drivers/net/wireless/realtek/rtw89/coex.h b/drivers/net/wireless/realtek/rtw89/coex.h
index 757d03675cf4..30134f58d531 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.h
+++ b/drivers/net/wireless/realtek/rtw89/coex.h
@@ -267,10 +267,10 @@ void rtw89_btc_ntfy_scan_finish(struct rtw89_dev *rtwdev, u8 phy_idx);
 void rtw89_btc_ntfy_switch_band(struct rtw89_dev *rtwdev, u8 phy_idx, u8 band);
 void rtw89_btc_ntfy_specific_packet(struct rtw89_dev *rtwdev,
 				    enum btc_pkt_type pkt_type);
-void rtw89_btc_ntfy_eapol_packet_work(struct work_struct *work);
-void rtw89_btc_ntfy_arp_packet_work(struct work_struct *work);
-void rtw89_btc_ntfy_dhcp_packet_work(struct work_struct *work);
-void rtw89_btc_ntfy_icmp_packet_work(struct work_struct *work);
+void rtw89_btc_ntfy_eapol_packet_work(struct wiphy *wiphy, struct wiphy_work *work);
+void rtw89_btc_ntfy_arp_packet_work(struct wiphy *wiphy, struct wiphy_work *work);
+void rtw89_btc_ntfy_dhcp_packet_work(struct wiphy *wiphy, struct wiphy_work *work);
+void rtw89_btc_ntfy_icmp_packet_work(struct wiphy *wiphy, struct wiphy_work *work);
 void rtw89_btc_ntfy_role_info(struct rtw89_dev *rtwdev,
 			      struct rtw89_vif_link *rtwvif_link,
 			      struct rtw89_sta_link *rtwsta_link,
@@ -283,9 +283,9 @@ void rtw89_btc_ntfy_wl_sta(struct rtw89_dev *rtwdev);
 void rtw89_btc_c2h_handle(struct rtw89_dev *rtwdev, struct sk_buff *skb,
 			  u32 len, u8 class, u8 func);
 void rtw89_btc_dump_info(struct rtw89_dev *rtwdev, struct seq_file *m);
-void rtw89_coex_act1_work(struct work_struct *work);
-void rtw89_coex_bt_devinfo_work(struct work_struct *work);
-void rtw89_coex_rfk_chk_work(struct work_struct *work);
+void rtw89_coex_act1_work(struct wiphy *wiphy, struct wiphy_work *work);
+void rtw89_coex_bt_devinfo_work(struct wiphy *wiphy, struct wiphy_work *work);
+void rtw89_coex_rfk_chk_work(struct wiphy *wiphy, struct wiphy_work *work);
 void rtw89_coex_power_on(struct rtw89_dev *rtwdev);
 void rtw89_btc_set_policy(struct rtw89_dev *rtwdev, u16 policy_type);
 void rtw89_btc_set_policy_v1(struct rtw89_dev *rtwdev, u16 policy_type);
diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index b730f70c82aa..56c54a59144c 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -913,16 +913,17 @@ static enum btc_pkt_type
 rtw89_core_tx_btc_spec_pkt_notify(struct rtw89_dev *rtwdev,
 				  struct rtw89_core_tx_request *tx_req)
 {
+	struct wiphy *wiphy = rtwdev->hw->wiphy;
 	struct sk_buff *skb = tx_req->skb;
 	struct udphdr *udphdr;
 
 	if (IEEE80211_SKB_CB(skb)->control.flags & IEEE80211_TX_CTRL_PORT_CTRL_PROTO) {
-		ieee80211_queue_work(rtwdev->hw, &rtwdev->btc.eapol_notify_work);
+		wiphy_work_queue(wiphy, &rtwdev->btc.eapol_notify_work);
 		return PACKET_EAPOL;
 	}
 
 	if (skb->protocol == htons(ETH_P_ARP)) {
-		ieee80211_queue_work(rtwdev->hw, &rtwdev->btc.arp_notify_work);
+		wiphy_work_queue(wiphy, &rtwdev->btc.arp_notify_work);
 		return PACKET_ARP;
 	}
 
@@ -932,14 +933,14 @@ rtw89_core_tx_btc_spec_pkt_notify(struct rtw89_dev *rtwdev,
 		if (((udphdr->source == htons(67) && udphdr->dest == htons(68)) ||
 		     (udphdr->source == htons(68) && udphdr->dest == htons(67))) &&
 		    skb->len > 282) {
-			ieee80211_queue_work(rtwdev->hw, &rtwdev->btc.dhcp_notify_work);
+			wiphy_work_queue(wiphy, &rtwdev->btc.dhcp_notify_work);
 			return PACKET_DHCP;
 		}
 	}
 
 	if (skb->protocol == htons(ETH_P_IP) &&
 	    ip_hdr(skb)->protocol == IPPROTO_ICMP) {
-		ieee80211_queue_work(rtwdev->hw, &rtwdev->btc.icmp_notify_work);
+		wiphy_work_queue(wiphy, &rtwdev->btc.icmp_notify_work);
 		return PACKET_ICMP;
 	}
 
@@ -2071,7 +2072,7 @@ static void rtw89_stats_trigger_frame(struct rtw89_dev *rtwdev,
 	}
 }
 
-static void rtw89_cancel_6ghz_probe_work(struct work_struct *work)
+static void rtw89_cancel_6ghz_probe_work(struct wiphy *wiphy, struct wiphy_work *work)
 {
 	struct rtw89_dev *rtwdev = container_of(work, struct rtw89_dev,
 						cancel_6ghz_probe_work);
@@ -2131,7 +2132,7 @@ static void rtw89_core_cancel_6ghz_probe_tx(struct rtw89_dev *rtwdev,
 	}
 
 	if (queue_work)
-		ieee80211_queue_work(rtwdev->hw, &rtwdev->cancel_6ghz_probe_work);
+		wiphy_work_queue(rtwdev->hw->wiphy, &rtwdev->cancel_6ghz_probe_work);
 }
 
 static void rtw89_vif_sync_bcn_tsf(struct rtw89_vif_link *rtwvif_link,
@@ -3143,7 +3144,7 @@ static void rtw89_core_txq_schedule(struct rtw89_dev *rtwdev, u8 ac, bool *reinv
 	ieee80211_txq_schedule_end(hw, ac);
 }
 
-static void rtw89_ips_work(struct work_struct *work)
+static void rtw89_ips_work(struct wiphy *wiphy, struct wiphy_work *work)
 {
 	struct rtw89_dev *rtwdev = container_of(work, struct rtw89_dev,
 						ips_work);
@@ -3330,9 +3331,9 @@ void rtw89_roc_start(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
 	rtw89_write32_clr(rtwdev, reg, B_AX_A_UC_CAM_MATCH | B_AX_A_BC_CAM_MATCH);
 
 	ieee80211_ready_on_channel(hw);
-	cancel_delayed_work(&rtwvif->roc.roc_work);
-	ieee80211_queue_delayed_work(hw, &rtwvif->roc.roc_work,
-				     msecs_to_jiffies(rtwvif->roc.duration));
+	wiphy_delayed_work_cancel(hw->wiphy, &rtwvif->roc.roc_work);
+	wiphy_delayed_work_queue(hw->wiphy, &rtwvif->roc.roc_work,
+				 msecs_to_jiffies(rtwvif->roc.duration));
 }
 
 void rtw89_roc_end(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
@@ -3377,11 +3378,11 @@ void rtw89_roc_end(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
 	queue_work(rtwdev->txq_wq, &rtwdev->txq_work);
 
 	if (hw->conf.flags & IEEE80211_CONF_IDLE)
-		ieee80211_queue_delayed_work(hw, &roc->roc_work,
-					     msecs_to_jiffies(RTW89_ROC_IDLE_TIMEOUT));
+		wiphy_delayed_work_queue(hw->wiphy, &roc->roc_work,
+					 msecs_to_jiffies(RTW89_ROC_IDLE_TIMEOUT));
 }
 
-void rtw89_roc_work(struct work_struct *work)
+void rtw89_roc_work(struct wiphy *wiphy, struct wiphy_work *work)
 {
 	struct rtw89_vif *rtwvif = container_of(work, struct rtw89_vif,
 						roc.roc_work.work);
@@ -3533,7 +3534,7 @@ void rtw89_traffic_stats_init(struct rtw89_dev *rtwdev,
 	ewma_tp_init(&stats->rx_ewma_tp);
 }
 
-static void rtw89_track_work(struct work_struct *work)
+static void rtw89_track_work(struct wiphy *wiphy, struct wiphy_work *work)
 {
 	struct rtw89_dev *rtwdev = container_of(work, struct rtw89_dev,
 						track_work.work);
@@ -3547,8 +3548,8 @@ static void rtw89_track_work(struct work_struct *work)
 	if (!test_bit(RTW89_FLAG_RUNNING, rtwdev->flags))
 		goto out;
 
-	ieee80211_queue_delayed_work(rtwdev->hw, &rtwdev->track_work,
-				     RTW89_TRACK_WORK_PERIOD);
+	wiphy_delayed_work_queue(wiphy, &rtwdev->track_work,
+				 RTW89_TRACK_WORK_PERIOD);
 
 	tfc_changed = rtw89_traffic_stats_track(rtwdev);
 	if (rtwdev->scanning)
@@ -4438,7 +4439,7 @@ static void rtw89_core_ppdu_sts_init(struct rtw89_dev *rtwdev)
 		rtwdev->ppdu_sts.curr_rx_ppdu_cnt[i] = U8_MAX;
 }
 
-void rtw89_core_update_beacon_work(struct work_struct *work)
+void rtw89_core_update_beacon_work(struct wiphy *wiphy, struct wiphy_work *work)
 {
 	struct rtw89_dev *rtwdev;
 	struct rtw89_vif_link *rtwvif_link = container_of(work, struct rtw89_vif_link,
@@ -4568,8 +4569,8 @@ int rtw89_core_start(struct rtw89_dev *rtwdev)
 		return ret;
 	}
 
-	ieee80211_queue_delayed_work(rtwdev->hw, &rtwdev->track_work,
-				     RTW89_TRACK_WORK_PERIOD);
+	wiphy_delayed_work_queue(rtwdev->hw->wiphy, &rtwdev->track_work,
+				 RTW89_TRACK_WORK_PERIOD);
 
 	set_bit(RTW89_FLAG_RUNNING, rtwdev->flags);
 
@@ -4583,6 +4584,7 @@ int rtw89_core_start(struct rtw89_dev *rtwdev)
 
 void rtw89_core_stop(struct rtw89_dev *rtwdev)
 {
+	struct wiphy *wiphy = rtwdev->hw->wiphy;
 	struct rtw89_btc *btc = &rtwdev->btc;
 
 	/* Prvent to stop twice; enter_ips and ops_stop */
@@ -4595,21 +4597,21 @@ void rtw89_core_stop(struct rtw89_dev *rtwdev)
 
 	mutex_unlock(&rtwdev->mutex);
 
-	cancel_work_sync(&rtwdev->c2h_work);
-	cancel_work_sync(&rtwdev->cancel_6ghz_probe_work);
-	cancel_work_sync(&btc->eapol_notify_work);
-	cancel_work_sync(&btc->arp_notify_work);
-	cancel_work_sync(&btc->dhcp_notify_work);
-	cancel_work_sync(&btc->icmp_notify_work);
+	wiphy_work_cancel(wiphy, &rtwdev->c2h_work);
+	wiphy_work_cancel(wiphy, &rtwdev->cancel_6ghz_probe_work);
+	wiphy_work_cancel(wiphy, &btc->eapol_notify_work);
+	wiphy_work_cancel(wiphy, &btc->arp_notify_work);
+	wiphy_work_cancel(wiphy, &btc->dhcp_notify_work);
+	wiphy_work_cancel(wiphy, &btc->icmp_notify_work);
 	cancel_delayed_work_sync(&rtwdev->txq_reinvoke_work);
-	cancel_delayed_work_sync(&rtwdev->track_work);
-	cancel_delayed_work_sync(&rtwdev->chanctx_work);
-	cancel_delayed_work_sync(&rtwdev->coex_act1_work);
-	cancel_delayed_work_sync(&rtwdev->coex_bt_devinfo_work);
-	cancel_delayed_work_sync(&rtwdev->coex_rfk_chk_work);
-	cancel_delayed_work_sync(&rtwdev->cfo_track_work);
+	wiphy_delayed_work_cancel(wiphy, &rtwdev->track_work);
+	wiphy_delayed_work_cancel(wiphy, &rtwdev->chanctx_work);
+	wiphy_delayed_work_cancel(wiphy, &rtwdev->coex_act1_work);
+	wiphy_delayed_work_cancel(wiphy, &rtwdev->coex_bt_devinfo_work);
+	wiphy_delayed_work_cancel(wiphy, &rtwdev->coex_rfk_chk_work);
+	wiphy_delayed_work_cancel(wiphy, &rtwdev->cfo_track_work);
 	cancel_delayed_work_sync(&rtwdev->forbid_ba_work);
-	cancel_delayed_work_sync(&rtwdev->antdiv_work);
+	wiphy_delayed_work_cancel(wiphy, &rtwdev->antdiv_work);
 
 	mutex_lock(&rtwdev->mutex);
 
@@ -4825,14 +4827,14 @@ int rtw89_core_init(struct rtw89_dev *rtwdev)
 	INIT_WORK(&rtwdev->ba_work, rtw89_core_ba_work);
 	INIT_WORK(&rtwdev->txq_work, rtw89_core_txq_work);
 	INIT_DELAYED_WORK(&rtwdev->txq_reinvoke_work, rtw89_core_txq_reinvoke_work);
-	INIT_DELAYED_WORK(&rtwdev->track_work, rtw89_track_work);
-	INIT_DELAYED_WORK(&rtwdev->chanctx_work, rtw89_chanctx_work);
-	INIT_DELAYED_WORK(&rtwdev->coex_act1_work, rtw89_coex_act1_work);
-	INIT_DELAYED_WORK(&rtwdev->coex_bt_devinfo_work, rtw89_coex_bt_devinfo_work);
-	INIT_DELAYED_WORK(&rtwdev->coex_rfk_chk_work, rtw89_coex_rfk_chk_work);
-	INIT_DELAYED_WORK(&rtwdev->cfo_track_work, rtw89_phy_cfo_track_work);
+	wiphy_delayed_work_init(&rtwdev->track_work, rtw89_track_work);
+	wiphy_delayed_work_init(&rtwdev->chanctx_work, rtw89_chanctx_work);
+	wiphy_delayed_work_init(&rtwdev->coex_act1_work, rtw89_coex_act1_work);
+	wiphy_delayed_work_init(&rtwdev->coex_bt_devinfo_work, rtw89_coex_bt_devinfo_work);
+	wiphy_delayed_work_init(&rtwdev->coex_rfk_chk_work, rtw89_coex_rfk_chk_work);
+	wiphy_delayed_work_init(&rtwdev->cfo_track_work, rtw89_phy_cfo_track_work);
 	INIT_DELAYED_WORK(&rtwdev->forbid_ba_work, rtw89_forbid_ba_work);
-	INIT_DELAYED_WORK(&rtwdev->antdiv_work, rtw89_phy_antdiv_work);
+	wiphy_delayed_work_init(&rtwdev->antdiv_work, rtw89_phy_antdiv_work);
 	rtwdev->txq_wq = alloc_workqueue("rtw89_tx_wq", WQ_UNBOUND | WQ_HIGHPRI, 0);
 	if (!rtwdev->txq_wq)
 		return -ENOMEM;
@@ -4847,10 +4849,10 @@ int rtw89_core_init(struct rtw89_dev *rtwdev)
 	rtw89_init_wait(&rtwdev->wow.wait);
 	rtw89_init_wait(&rtwdev->mac.ps_wait);
 
-	INIT_WORK(&rtwdev->c2h_work, rtw89_fw_c2h_work);
-	INIT_WORK(&rtwdev->ips_work, rtw89_ips_work);
+	wiphy_work_init(&rtwdev->c2h_work, rtw89_fw_c2h_work);
+	wiphy_work_init(&rtwdev->ips_work, rtw89_ips_work);
+	wiphy_work_init(&rtwdev->cancel_6ghz_probe_work, rtw89_cancel_6ghz_probe_work);
 	INIT_WORK(&rtwdev->load_firmware_work, rtw89_load_firmware_work);
-	INIT_WORK(&rtwdev->cancel_6ghz_probe_work, rtw89_cancel_6ghz_probe_work);
 
 	skb_queue_head_init(&rtwdev->c2h_queue);
 	rtw89_core_ppdu_sts_init(rtwdev);
@@ -4870,10 +4872,10 @@ int rtw89_core_init(struct rtw89_dev *rtwdev)
 	rtwdev->bbs[RTW89_PHY_0].phy_idx = RTW89_PHY_0;
 	rtwdev->bbs[RTW89_PHY_1].phy_idx = RTW89_PHY_1;
 
-	INIT_WORK(&btc->eapol_notify_work, rtw89_btc_ntfy_eapol_packet_work);
-	INIT_WORK(&btc->arp_notify_work, rtw89_btc_ntfy_arp_packet_work);
-	INIT_WORK(&btc->dhcp_notify_work, rtw89_btc_ntfy_dhcp_packet_work);
-	INIT_WORK(&btc->icmp_notify_work, rtw89_btc_ntfy_icmp_packet_work);
+	wiphy_work_init(&btc->eapol_notify_work, rtw89_btc_ntfy_eapol_packet_work);
+	wiphy_work_init(&btc->arp_notify_work, rtw89_btc_ntfy_arp_packet_work);
+	wiphy_work_init(&btc->dhcp_notify_work, rtw89_btc_ntfy_dhcp_packet_work);
+	wiphy_work_init(&btc->icmp_notify_work, rtw89_btc_ntfy_icmp_packet_work);
 
 	init_completion(&rtwdev->fw.req.completion);
 	init_completion(&rtwdev->rfk_wait.completion);
@@ -4949,7 +4951,7 @@ void rtw89_core_scan_complete(struct rtw89_dev *rtwdev,
 	rtw89_for_each_active_bb(rtwdev, bb)
 		bb->dig.bypass_dig = true;
 	if (hw_scan && (rtwdev->hw->conf.flags & IEEE80211_CONF_IDLE))
-		ieee80211_queue_work(rtwdev->hw, &rtwdev->ips_work);
+		wiphy_work_queue(rtwdev->hw->wiphy, &rtwdev->ips_work);
 }
 
 static void rtw89_read_chip_ver(struct rtw89_dev *rtwdev)
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 0b34dae609be..947e8b094912 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -3175,10 +3175,10 @@ struct rtw89_btc {
 	struct rtw89_btc_btf_fwinfo fwinfo;
 	struct rtw89_btc_dbg dbg;
 
-	struct work_struct eapol_notify_work;
-	struct work_struct arp_notify_work;
-	struct work_struct dhcp_notify_work;
-	struct work_struct icmp_notify_work;
+	struct wiphy_work eapol_notify_work;
+	struct wiphy_work arp_notify_work;
+	struct wiphy_work dhcp_notify_work;
+	struct wiphy_work icmp_notify_work;
 
 	u32 bt_req_len;
 
@@ -3445,7 +3445,7 @@ enum rtw89_roc_state {
 
 struct rtw89_roc {
 	struct ieee80211_channel chan;
-	struct delayed_work roc_work;
+	struct wiphy_delayed_work roc_work;
 	enum ieee80211_roc_type type;
 	enum rtw89_roc_state state;
 	int duration;
@@ -3515,7 +3515,7 @@ struct rtw89_vif_link {
 	bool pre_pwr_diff_en;
 	bool pwr_diff_en;
 	u8 def_tri_idx;
-	struct work_struct update_beacon_work;
+	struct wiphy_work update_beacon_work;
 	struct rtw89_addr_cam_entry addr_cam;
 	struct rtw89_bssid_cam_entry bssid_cam;
 	struct ieee80211_tx_queue_params tx_params[IEEE80211_NUM_ACS];
@@ -5652,10 +5652,10 @@ struct rtw89_dev {
 	struct rtw89_cam_info cam_info;
 
 	struct sk_buff_head c2h_queue;
-	struct work_struct c2h_work;
-	struct work_struct ips_work;
+	struct wiphy_work c2h_work;
+	struct wiphy_work ips_work;
+	struct wiphy_work cancel_6ghz_probe_work;
 	struct work_struct load_firmware_work;
-	struct work_struct cancel_6ghz_probe_work;
 
 	struct list_head early_h2c_list;
 
@@ -5700,14 +5700,14 @@ struct rtw89_dev {
 		struct rtw89_edcca_bak edcca_bak;
 	} bbs[RTW89_PHY_NUM];
 
-	struct delayed_work track_work;
-	struct delayed_work chanctx_work;
-	struct delayed_work coex_act1_work;
-	struct delayed_work coex_bt_devinfo_work;
-	struct delayed_work coex_rfk_chk_work;
-	struct delayed_work cfo_track_work;
+	struct wiphy_delayed_work track_work;
+	struct wiphy_delayed_work chanctx_work;
+	struct wiphy_delayed_work coex_act1_work;
+	struct wiphy_delayed_work coex_bt_devinfo_work;
+	struct wiphy_delayed_work coex_rfk_chk_work;
+	struct wiphy_delayed_work cfo_track_work;
 	struct delayed_work forbid_ba_work;
-	struct delayed_work antdiv_work;
+	struct wiphy_delayed_work antdiv_work;
 	struct rtw89_ppdu_sts_info ppdu_sts;
 	u8 total_sta_assoc;
 	bool scanning;
@@ -7150,8 +7150,8 @@ void rtw89_complete_cond(struct rtw89_wait_info *wait, unsigned int cond,
 			 const struct rtw89_completion_data *data);
 int rtw89_core_start(struct rtw89_dev *rtwdev);
 void rtw89_core_stop(struct rtw89_dev *rtwdev);
-void rtw89_core_update_beacon_work(struct work_struct *work);
-void rtw89_roc_work(struct work_struct *work);
+void rtw89_core_update_beacon_work(struct wiphy *wiphy, struct wiphy_work *work);
+void rtw89_roc_work(struct wiphy *wiphy, struct wiphy_work *work);
 void rtw89_roc_start(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif);
 void rtw89_roc_end(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif);
 void rtw89_core_scan_start(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvif_link,
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 5cc9ab78c09f..1703bce0957c 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -6059,7 +6059,7 @@ void rtw89_fw_c2h_irqsafe(struct rtw89_dev *rtwdev, struct sk_buff *c2h)
 
 enqueue:
 	skb_queue_tail(&rtwdev->c2h_queue, c2h);
-	ieee80211_queue_work(rtwdev->hw, &rtwdev->c2h_work);
+	wiphy_work_queue(rtwdev->hw->wiphy, &rtwdev->c2h_work);
 }
 
 static void rtw89_fw_c2h_cmd_handle(struct rtw89_dev *rtwdev,
@@ -6097,7 +6097,7 @@ static void rtw89_fw_c2h_cmd_handle(struct rtw89_dev *rtwdev,
 		rtw89_hex_dump(rtwdev, RTW89_DBG_FW, "C2H: ", skb->data, skb->len);
 }
 
-void rtw89_fw_c2h_work(struct work_struct *work)
+void rtw89_fw_c2h_work(struct wiphy *wiphy, struct wiphy_work *work)
 {
 	struct rtw89_dev *rtwdev = container_of(work, struct rtw89_dev,
 						c2h_work);
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index 3cc514de073a..620eeb65ddc1 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -4588,7 +4588,7 @@ int rtw89_fw_h2c_dctl_sec_cam_v2(struct rtw89_dev *rtwdev,
 				 struct rtw89_vif_link *rtwvif_link,
 				 struct rtw89_sta_link *rtwsta_link);
 void rtw89_fw_c2h_irqsafe(struct rtw89_dev *rtwdev, struct sk_buff *c2h);
-void rtw89_fw_c2h_work(struct work_struct *work);
+void rtw89_fw_c2h_work(struct wiphy *wiphy, struct wiphy_work *work);
 int rtw89_fw_h2c_role_maintain(struct rtw89_dev *rtwdev,
 			       struct rtw89_vif_link *rtwvif_link,
 			       struct rtw89_sta_link *rtwsta_link,
diff --git a/drivers/net/wireless/realtek/rtw89/mac80211.c b/drivers/net/wireless/realtek/rtw89/mac80211.c
index b3669e0074df..7b3520e6389b 100644
--- a/drivers/net/wireless/realtek/rtw89/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw89/mac80211.c
@@ -80,7 +80,7 @@ static int rtw89_ops_config(struct ieee80211_hw *hw, u32 changed)
 	struct rtw89_dev *rtwdev = hw->priv;
 
 	/* let previous ips work finish to ensure we don't leave ips twice */
-	cancel_work_sync(&rtwdev->ips_work);
+	wiphy_work_cancel(hw->wiphy, &rtwdev->ips_work);
 
 	mutex_lock(&rtwdev->mutex);
 	rtw89_leave_ps_mode(rtwdev);
@@ -115,7 +115,7 @@ static int __rtw89_ops_add_iface_link(struct rtw89_dev *rtwdev,
 
 	rtw89_vif_type_mapping(rtwvif_link, false);
 
-	INIT_WORK(&rtwvif_link->update_beacon_work, rtw89_core_update_beacon_work);
+	wiphy_work_init(&rtwvif_link->update_beacon_work, rtw89_core_update_beacon_work);
 	INIT_LIST_HEAD(&rtwvif_link->general_pkt_list);
 
 	rtwvif_link->hit_rule = 0;
@@ -143,7 +143,7 @@ static void __rtw89_ops_remove_iface_link(struct rtw89_dev *rtwdev,
 					  struct rtw89_vif_link *rtwvif_link)
 {
 	mutex_unlock(&rtwdev->mutex);
-	cancel_work_sync(&rtwvif_link->update_beacon_work);
+	wiphy_work_cancel(rtwdev->hw->wiphy, &rtwvif_link->update_beacon_work);
 	mutex_lock(&rtwdev->mutex);
 
 	rtw89_leave_ps_mode(rtwdev);
@@ -198,7 +198,7 @@ static int rtw89_ops_add_interface(struct ieee80211_hw *hw,
 
 	rtwvif->offchan = false;
 	rtwvif->roc.state = RTW89_ROC_IDLE;
-	INIT_DELAYED_WORK(&rtwvif->roc.roc_work, rtw89_roc_work);
+	wiphy_delayed_work_init(&rtwvif->roc.roc_work, rtw89_roc_work);
 
 	rtw89_traffic_stats_init(rtwdev, &rtwvif->stats);
 
@@ -242,7 +242,7 @@ static void rtw89_ops_remove_interface(struct ieee80211_hw *hw,
 	rtw89_debug(rtwdev, RTW89_DBG_STATE, "remove vif %pM type %d p2p %d\n",
 		    vif->addr, vif->type, vif->p2p);
 
-	cancel_delayed_work_sync(&rtwvif->roc.roc_work);
+	wiphy_delayed_work_cancel(hw->wiphy, &rtwvif->roc.roc_work);
 
 	mutex_lock(&rtwdev->mutex);
 
@@ -853,14 +853,13 @@ void rtw89_ops_stop_ap(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 static int rtw89_ops_set_tim(struct ieee80211_hw *hw, struct ieee80211_sta *sta,
 			     bool set)
 {
-	struct rtw89_dev *rtwdev = hw->priv;
 	struct rtw89_sta *rtwsta = sta_to_rtwsta(sta);
 	struct rtw89_vif *rtwvif = rtwsta->rtwvif;
 	struct rtw89_vif_link *rtwvif_link;
 	unsigned int link_id;
 
 	rtw89_vif_for_each_link(rtwvif, rtwvif_link, link_id)
-		ieee80211_queue_work(rtwdev->hw, &rtwvif_link->update_beacon_work);
+		wiphy_work_queue(hw->wiphy, &rtwvif_link->update_beacon_work);
 
 	return 0;
 }
@@ -1453,7 +1452,7 @@ static int rtw89_ops_cancel_remain_on_channel(struct ieee80211_hw *hw,
 	if (!rtwvif)
 		return -EINVAL;
 
-	cancel_delayed_work_sync(&rtwvif->roc.roc_work);
+	wiphy_delayed_work_cancel(hw->wiphy, &rtwvif->roc.roc_work);
 
 	mutex_lock(&rtwdev->mutex);
 	rtw89_roc_end(rtwdev, rtwvif);
@@ -1751,7 +1750,7 @@ static int rtw89_ops_suspend(struct ieee80211_hw *hw,
 	int ret;
 
 	set_bit(RTW89_FLAG_FORBIDDEN_TRACK_WROK, rtwdev->flags);
-	cancel_delayed_work_sync(&rtwdev->track_work);
+	wiphy_delayed_work_cancel(hw->wiphy, &rtwdev->track_work);
 
 	mutex_lock(&rtwdev->mutex);
 	ret = rtw89_wow_suspend(rtwdev, wowlan);
@@ -1778,8 +1777,8 @@ static int rtw89_ops_resume(struct ieee80211_hw *hw)
 	mutex_unlock(&rtwdev->mutex);
 
 	clear_bit(RTW89_FLAG_FORBIDDEN_TRACK_WROK, rtwdev->flags);
-	ieee80211_queue_delayed_work(rtwdev->hw, &rtwdev->track_work,
-				     RTW89_TRACK_WORK_PERIOD);
+	wiphy_delayed_work_queue(hw->wiphy, &rtwdev->track_work,
+				 RTW89_TRACK_WORK_PERIOD);
 
 	return ret ? 1 : 0;
 }
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index 5b0cf8314fb2..2f8694fe4bd1 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -4651,7 +4651,7 @@ static void rtw89_phy_cfo_dm(struct rtw89_dev *rtwdev)
 	rtw89_phy_cfo_statistics_reset(rtwdev);
 }
 
-void rtw89_phy_cfo_track_work(struct work_struct *work)
+void rtw89_phy_cfo_track_work(struct wiphy *wiphy, struct wiphy_work *work)
 {
 	struct rtw89_dev *rtwdev = container_of(work, struct rtw89_dev,
 						cfo_track_work.work);
@@ -4662,8 +4662,8 @@ void rtw89_phy_cfo_track_work(struct work_struct *work)
 		goto out;
 	rtw89_leave_ps_mode(rtwdev);
 	rtw89_phy_cfo_dm(rtwdev);
-	ieee80211_queue_delayed_work(rtwdev->hw, &rtwdev->cfo_track_work,
-				     msecs_to_jiffies(cfo->cfo_timer_ms));
+	wiphy_delayed_work_queue(wiphy, &rtwdev->cfo_track_work,
+				 msecs_to_jiffies(cfo->cfo_timer_ms));
 out:
 	mutex_unlock(&rtwdev->mutex);
 }
@@ -4672,8 +4672,8 @@ static void rtw89_phy_cfo_start_work(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_cfo_tracking_info *cfo = &rtwdev->cfo_tracking;
 
-	ieee80211_queue_delayed_work(rtwdev->hw, &rtwdev->cfo_track_work,
-				     msecs_to_jiffies(cfo->cfo_timer_ms));
+	wiphy_delayed_work_queue(rtwdev->hw->wiphy, &rtwdev->cfo_track_work,
+				 msecs_to_jiffies(cfo->cfo_timer_ms));
 }
 
 void rtw89_phy_cfo_track(struct rtw89_dev *rtwdev)
@@ -6523,11 +6523,11 @@ static void rtw89_phy_antdiv_training_state(struct rtw89_dev *rtwdev)
 	}
 
 	antdiv->training_count++;
-	ieee80211_queue_delayed_work(rtwdev->hw, &rtwdev->antdiv_work,
-				     state_period);
+	wiphy_delayed_work_queue(rtwdev->hw->wiphy, &rtwdev->antdiv_work,
+				 state_period);
 }
 
-void rtw89_phy_antdiv_work(struct work_struct *work)
+void rtw89_phy_antdiv_work(struct wiphy *wiphy, struct wiphy_work *work)
 {
 	struct rtw89_dev *rtwdev = container_of(work, struct rtw89_dev,
 						antdiv_work.work);
@@ -6563,7 +6563,7 @@ void rtw89_phy_antdiv_track(struct rtw89_dev *rtwdev)
 		return;
 
 	antdiv->training_count = 0;
-	ieee80211_queue_delayed_work(rtwdev->hw, &rtwdev->antdiv_work, 0);
+	wiphy_delayed_work_queue(rtwdev->hw->wiphy, &rtwdev->antdiv_work, 0);
 }
 
 static void __rtw89_phy_env_monitor_init(struct rtw89_dev *rtwdev,
diff --git a/drivers/net/wireless/realtek/rtw89/phy.h b/drivers/net/wireless/realtek/rtw89/phy.h
index 33d466c519e3..cec165e222e7 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.h
+++ b/drivers/net/wireless/realtek/rtw89/phy.h
@@ -978,7 +978,7 @@ void rtw89_phy_rfk_tssi_fill_fwcmd_tmeter_tbl(struct rtw89_dev *rtwdev,
 					      const struct rtw89_chan *chan,
 					      struct rtw89_h2c_rf_tssi *h2c);
 void rtw89_phy_cfo_track(struct rtw89_dev *rtwdev);
-void rtw89_phy_cfo_track_work(struct work_struct *work);
+void rtw89_phy_cfo_track_work(struct wiphy *wiphy, struct wiphy_work *work);
 void rtw89_phy_cfo_parse(struct rtw89_dev *rtwdev, s16 cfo_val,
 			 struct rtw89_rx_phy_ppdu *phy_ppdu);
 void rtw89_phy_stat_track(struct rtw89_dev *rtwdev);
@@ -991,7 +991,7 @@ void rtw89_phy_tx_path_div_track(struct rtw89_dev *rtwdev);
 void rtw89_phy_antdiv_parse(struct rtw89_dev *rtwdev,
 			    struct rtw89_rx_phy_ppdu *phy_ppdu);
 void rtw89_phy_antdiv_track(struct rtw89_dev *rtwdev);
-void rtw89_phy_antdiv_work(struct work_struct *work);
+void rtw89_phy_antdiv_work(struct wiphy *wiphy, struct wiphy_work *work);
 void rtw89_phy_set_bss_color(struct rtw89_dev *rtwdev,
 			     struct rtw89_vif_link *rtwvif_link);
 void rtw89_phy_tssi_ctrl_set_bandedge_cfg(struct rtw89_dev *rtwdev,
diff --git a/drivers/net/wireless/realtek/rtw89/ser.c b/drivers/net/wireless/realtek/rtw89/ser.c
index d0c8584308c0..9658672ad274 100644
--- a/drivers/net/wireless/realtek/rtw89/ser.c
+++ b/drivers/net/wireless/realtek/rtw89/ser.c
@@ -485,10 +485,13 @@ static void ser_l1_reset_pre_st_hdl(struct rtw89_ser *ser, u8 evt)
 static void ser_reset_trx_st_hdl(struct rtw89_ser *ser, u8 evt)
 {
 	struct rtw89_dev *rtwdev = container_of(ser, struct rtw89_dev, ser);
+	struct wiphy *wiphy = rtwdev->hw->wiphy;
 
 	switch (evt) {
 	case SER_EV_STATE_IN:
-		cancel_delayed_work_sync(&rtwdev->track_work);
+		wiphy_lock(wiphy);
+		wiphy_delayed_work_cancel(wiphy, &rtwdev->track_work);
+		wiphy_unlock(wiphy);
 		drv_stop_tx(ser);
 
 		if (hal_stop_dma(ser)) {
@@ -519,8 +522,8 @@ static void ser_reset_trx_st_hdl(struct rtw89_ser *ser, u8 evt)
 		hal_enable_dma(ser);
 		drv_resume_rx(ser);
 		drv_resume_tx(ser);
-		ieee80211_queue_delayed_work(rtwdev->hw, &rtwdev->track_work,
-					     RTW89_TRACK_WORK_PERIOD);
+		wiphy_delayed_work_queue(wiphy, &rtwdev->track_work,
+					 RTW89_TRACK_WORK_PERIOD);
 		break;
 
 	default:
-- 
2.25.1


