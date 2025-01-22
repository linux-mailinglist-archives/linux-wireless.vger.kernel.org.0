Return-Path: <linux-wireless+bounces-17820-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D91A18BA1
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Jan 2025 07:04:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E78B71882077
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Jan 2025 06:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C2CE191F6C;
	Wed, 22 Jan 2025 06:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="dBNbabz2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258A718E361
	for <linux-wireless@vger.kernel.org>; Wed, 22 Jan 2025 06:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737525852; cv=none; b=sVlypqShizK3EgwTRvN4ynpdry5QnOMC9Yt/sd/RchEfTQ5Iim0CKWgclS8J2EYhjlkRBbweOlaTj2FIDWFiowWgxuQ9mtpWdXHxzv/V78Bztv/DdRUu2pt32do4o0gylWS9Qc1HA12NtFUeJH5BvZzwaIGuruBCb2PBrH9KSJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737525852; c=relaxed/simple;
	bh=UuXOklBI4EW+CISR+YL/a11K4TAv8MhZt6irAIriGvE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tlkHi5H3QXjAXpnju2N0BJKtMgF4ileqkn1v8bDzSeu22R3PepXGH8s7wR93z1IhztLpx+qtoaALm5HceRKVxlCMWatqWYqXfLnKnrF6+m4P88s1FTwd0SJ2p/hX/kv3CyVaaPe2jWzrjSTTua/0uswkUeTeSSS50CkCs/Ynxm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=dBNbabz2; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 50M646lmC2495113, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1737525846; bh=UuXOklBI4EW+CISR+YL/a11K4TAv8MhZt6irAIriGvE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=dBNbabz2GY5oSZ+gpAGpSSrBhaZAYgaLmCwicqx8WDgLiBk0YwhlHGYuhcwaMImje
	 d2dRjw69YO5+iQgbG8jvmBjHY01oU+ounlPSJ/bfT09OYd4FuxDgnww9b+T7u2mRa5
	 9tCjaWPBMt5KWDQyL5z3m1BcEocMjZGXhxzo9/auWvRnwMHXBj5kKsAGwamfv7GQI3
	 hDU7JzO9mBbB607hFKwKqedo6+Ct+Z9DnBuFHjspzY2NWiLroZtTHqR2xhuWPvRhMy
	 z48AD/Kmy8Pf36XkYwtAO22s5v8WdZFzrduP7rA0h1QjIrtNyOyY6HpP6682DUlrS/
	 b8OAcEI4+j7tg==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 50M646lmC2495113
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 22 Jan 2025 14:04:06 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 22 Jan 2025 14:04:07 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 22 Jan
 2025 14:04:06 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH 07/10] wifi: rtw89: remove consumers of driver mutex
Date: Wed, 22 Jan 2025 14:03:07 +0800
Message-ID: <20250122060310.31976-8-pkshih@realtek.com>
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

All need lock have taken both driver mutex and wiphy lock, so we can remove
driver mutex safely by below spatch script. Also, check every
lockdep_assert_wiphy() is executed without locks warning at runtime.

@ rule1_1 @
@@

- lockdep_assert_held(&rtwdev->mutex);
+ lockdep_assert_wiphy(rtwdev->hw->wiphy);

@ rule1_2 @
@@

- guard(mutex)(&rtwdev->mutex);
+ lockdep_assert_wiphy(rtwdev->hw->wiphy);

@ rule2_1 @
@@

- mutex_lock(&rtwdev->mutex);
+ lockdep_assert_wiphy(rtwdev->hw->wiphy);
  ...
- mutex_unlock(&rtwdev->mutex);

@ rule2_2 @
@@

- mutex_unlock(&rtwdev->mutex);
+ lockdep_assert_wiphy(rtwdev->hw->wiphy);
  ...
- mutex_lock(&rtwdev->mutex);

@ rule3_1 @
type t;
identifier fn;
@@
  t fn(struct wiphy *wiphy, ...)
  {
  ...
- lockdep_assert_wiphy(rtwdev->hw->wiphy);
+ lockdep_assert_wiphy(wiphy);
  ...
  }

@ rule3_1_1 @
type t;
identifier fn;
@@
  t fn(...)
  {
  ...
  struct wiphy *wiphy = ...;
  ...
- lockdep_assert_wiphy(rtwdev->hw->wiphy);
+ lockdep_assert_wiphy(wiphy);
  ...
  }

@ rule3_2 @
type t;
identifier fn;
@@
  t fn(struct ieee80211_hw *hw, ...)
  {
  ...
- lockdep_assert_wiphy(rtwdev->hw->wiphy);
+ lockdep_assert_wiphy(hw->wiphy);
  ...
  }

@ rule3_2_1 @
type t;
identifier fn;
@@
  t fn(...)
  {
  ...
  struct ieee80211_hw *hw = ...;
  ...
- lockdep_assert_wiphy(rtwdev->hw->wiphy);
+ lockdep_assert_wiphy(hw->wiphy);
  ...
  }

The compiler warnings will be fixed manually by latter patch:

  rtw89/mac80211.c:371:1: warning: statement expected after label

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/chan.c     |  19 ++-
 drivers/net/wireless/realtek/rtw89/coex.c     |  23 ++-
 drivers/net/wireless/realtek/rtw89/core.c     |  28 ++--
 drivers/net/wireless/realtek/rtw89/debug.c    |  24 +---
 drivers/net/wireless/realtek/rtw89/fw.c       |   7 +-
 drivers/net/wireless/realtek/rtw89/mac80211.c | 131 ++++++------------
 drivers/net/wireless/realtek/rtw89/phy.c      |   7 +-
 drivers/net/wireless/realtek/rtw89/ps.c       |   6 +-
 drivers/net/wireless/realtek/rtw89/regd.c     |   5 +-
 drivers/net/wireless/realtek/rtw89/sar.c      |   9 +-
 drivers/net/wireless/realtek/rtw89/ser.c      |   6 +-
 drivers/net/wireless/realtek/rtw89/util.h     |   2 +-
 drivers/net/wireless/realtek/rtw89/wow.c      |   3 +-
 13 files changed, 92 insertions(+), 178 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/chan.c b/drivers/net/wireless/realtek/rtw89/chan.c
index 9858894dfc23..98f420208632 100644
--- a/drivers/net/wireless/realtek/rtw89/chan.c
+++ b/drivers/net/wireless/realtek/rtw89/chan.c
@@ -155,7 +155,7 @@ int rtw89_iterate_entity_chan(struct rtw89_dev *rtwdev,
 	int ret;
 	u8 idx;
 
-	lockdep_assert_held(&rtwdev->mutex);
+	lockdep_assert_wiphy(rtwdev->hw->wiphy);
 
 	for_each_set_bit(idx,  hal->entity_map, NUM_OF_RTW89_CHANCTX) {
 		chan = rtw89_chan_get(rtwdev, idx);
@@ -310,7 +310,7 @@ const struct rtw89_chan *__rtw89_mgnt_chan_get(struct rtw89_dev *rtwdev,
 	enum rtw89_entity_mode mode;
 	u8 role_index;
 
-	lockdep_assert_held(&rtwdev->mutex);
+	lockdep_assert_wiphy(rtwdev->hw->wiphy);
 
 	if (unlikely(link_index >= __RTW89_MLD_MAX_LINK_NUM)) {
 		WARN(1, "link index %u is invalid (max link inst num: %d)\n",
@@ -366,7 +366,7 @@ static void rtw89_entity_recalc_mgnt_roles(struct rtw89_dev *rtwdev)
 	u8 pos = 0;
 	int i, j;
 
-	lockdep_assert_held(&rtwdev->mutex);
+	lockdep_assert_wiphy(rtwdev->hw->wiphy);
 
 	for (i = 0; i < RTW89_MAX_INTERFACE_NUM; i++)
 		mgnt->active_roles[i] = NULL;
@@ -427,7 +427,7 @@ enum rtw89_entity_mode rtw89_entity_recalc(struct rtw89_dev *rtwdev)
 	struct rtw89_chan chan;
 	u8 idx;
 
-	lockdep_assert_held(&rtwdev->mutex);
+	lockdep_assert_wiphy(rtwdev->hw->wiphy);
 
 	bitmap_copy(recalc_map, hal->entity_map, NUM_OF_RTW89_CHANCTX);
 
@@ -2401,10 +2401,9 @@ void rtw89_chanctx_work(struct wiphy *wiphy, struct wiphy_work *work)
 	int ret;
 	int i;
 
-	mutex_lock(&rtwdev->mutex);
+	lockdep_assert_wiphy(wiphy);
 
 	if (hal->entity_pause) {
-		mutex_unlock(&rtwdev->mutex);
 		return;
 	}
 
@@ -2445,8 +2444,6 @@ void rtw89_chanctx_work(struct wiphy *wiphy, struct wiphy_work *work)
 	default:
 		break;
 	}
-
-	mutex_unlock(&rtwdev->mutex);
 }
 
 void rtw89_queue_chanctx_change(struct rtw89_dev *rtwdev,
@@ -2491,7 +2488,7 @@ void rtw89_chanctx_track(struct rtw89_dev *rtwdev)
 	struct rtw89_hal *hal = &rtwdev->hal;
 	enum rtw89_entity_mode mode;
 
-	lockdep_assert_held(&rtwdev->mutex);
+	lockdep_assert_wiphy(rtwdev->hw->wiphy);
 
 	if (hal->entity_pause)
 		return;
@@ -2512,7 +2509,7 @@ void rtw89_chanctx_pause(struct rtw89_dev *rtwdev,
 	struct rtw89_hal *hal = &rtwdev->hal;
 	enum rtw89_entity_mode mode;
 
-	lockdep_assert_held(&rtwdev->mutex);
+	lockdep_assert_wiphy(rtwdev->hw->wiphy);
 
 	if (hal->entity_pause)
 		return;
@@ -2555,7 +2552,7 @@ void rtw89_chanctx_proceed(struct rtw89_dev *rtwdev,
 	enum rtw89_entity_mode mode;
 	int ret;
 
-	lockdep_assert_held(&rtwdev->mutex);
+	lockdep_assert_wiphy(rtwdev->hw->wiphy);
 
 	if (unlikely(!hal->entity_pause)) {
 		rtw89_chanctx_proceed_cb(rtwdev, cb_parm);
diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index 1065f610d80f..a7b7675dca97 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -6721,7 +6721,7 @@ void rtw89_coex_act1_work(struct wiphy *wiphy, struct wiphy_work *work)
 	struct rtw89_btc_cx *cx = &btc->cx;
 	struct rtw89_btc_wl_info *wl = &cx->wl;
 
-	mutex_lock(&rtwdev->mutex);
+	lockdep_assert_wiphy(wiphy);
 	rtw89_debug(rtwdev, RTW89_DBG_BTC, "[BTC], %s(): enter\n", __func__);
 	dm->cnt_notify[BTC_NCNT_TIMER]++;
 	if (wl->status.map._4way)
@@ -6730,7 +6730,6 @@ void rtw89_coex_act1_work(struct wiphy *wiphy, struct wiphy_work *work)
 		wl->status.map.connecting = false;
 
 	_run_coex(rtwdev, BTC_RSN_ACT1_WORK);
-	mutex_unlock(&rtwdev->mutex);
 }
 
 void rtw89_coex_bt_devinfo_work(struct wiphy *wiphy, struct wiphy_work *work)
@@ -6741,12 +6740,11 @@ void rtw89_coex_bt_devinfo_work(struct wiphy *wiphy, struct wiphy_work *work)
 	struct rtw89_btc_dm *dm = &rtwdev->btc.dm;
 	struct rtw89_btc_bt_a2dp_desc *a2dp = &btc->cx.bt.link_info.a2dp_desc;
 
-	mutex_lock(&rtwdev->mutex);
+	lockdep_assert_wiphy(wiphy);
 	rtw89_debug(rtwdev, RTW89_DBG_BTC, "[BTC], %s(): enter\n", __func__);
 	dm->cnt_notify[BTC_NCNT_TIMER]++;
 	a2dp->play_latency = 0;
 	_run_coex(rtwdev, BTC_RSN_BT_DEVINFO_WORK);
-	mutex_unlock(&rtwdev->mutex);
 }
 
 void rtw89_coex_rfk_chk_work(struct wiphy *wiphy, struct wiphy_work *work)
@@ -6758,7 +6756,7 @@ void rtw89_coex_rfk_chk_work(struct wiphy *wiphy, struct wiphy_work *work)
 	struct rtw89_btc_cx *cx = &btc->cx;
 	struct rtw89_btc_wl_info *wl = &cx->wl;
 
-	mutex_lock(&rtwdev->mutex);
+	lockdep_assert_wiphy(wiphy);
 	rtw89_debug(rtwdev, RTW89_DBG_BTC, "[BTC], %s(): enter\n", __func__);
 	dm->cnt_notify[BTC_NCNT_TIMER]++;
 	if (wl->rfk_info.state != BTC_WRFK_STOP) {
@@ -6770,7 +6768,6 @@ void rtw89_coex_rfk_chk_work(struct wiphy *wiphy, struct wiphy_work *work)
 		_write_scbd(rtwdev, BTC_WSCB_WLRFK, false);
 		_run_coex(rtwdev, BTC_RSN_RFK_CHK_WORK);
 	}
-	mutex_unlock(&rtwdev->mutex);
 }
 
 static void _update_bt_scbd(struct rtw89_dev *rtwdev, bool only_update)
@@ -6874,7 +6871,7 @@ void _run_coex(struct rtw89_dev *rtwdev, enum btc_reason_and_action reason)
 	struct rtw89_btc_wl_role_info_v8 *wl_rinfo_v8 = &wl->role_info_v8;
 	u8 mode, igno_bt, always_freerun;
 
-	lockdep_assert_held(&rtwdev->mutex);
+	lockdep_assert_wiphy(rtwdev->hw->wiphy);
 
 	dm->run_reason = reason;
 	_update_dm_step(rtwdev, reason);
@@ -7311,10 +7308,9 @@ void rtw89_btc_ntfy_eapol_packet_work(struct wiphy *wiphy, struct wiphy_work *wo
 	struct rtw89_dev *rtwdev = container_of(work, struct rtw89_dev,
 						btc.eapol_notify_work);
 
-	mutex_lock(&rtwdev->mutex);
+	lockdep_assert_wiphy(wiphy);
 	rtw89_leave_ps_mode(rtwdev);
 	rtw89_btc_ntfy_specific_packet(rtwdev, PACKET_EAPOL);
-	mutex_unlock(&rtwdev->mutex);
 }
 
 void rtw89_btc_ntfy_arp_packet_work(struct wiphy *wiphy, struct wiphy_work *work)
@@ -7322,9 +7318,8 @@ void rtw89_btc_ntfy_arp_packet_work(struct wiphy *wiphy, struct wiphy_work *work
 	struct rtw89_dev *rtwdev = container_of(work, struct rtw89_dev,
 						btc.arp_notify_work);
 
-	mutex_lock(&rtwdev->mutex);
+	lockdep_assert_wiphy(wiphy);
 	rtw89_btc_ntfy_specific_packet(rtwdev, PACKET_ARP);
-	mutex_unlock(&rtwdev->mutex);
 }
 
 void rtw89_btc_ntfy_dhcp_packet_work(struct wiphy *wiphy, struct wiphy_work *work)
@@ -7332,10 +7327,9 @@ void rtw89_btc_ntfy_dhcp_packet_work(struct wiphy *wiphy, struct wiphy_work *wor
 	struct rtw89_dev *rtwdev = container_of(work, struct rtw89_dev,
 						btc.dhcp_notify_work);
 
-	mutex_lock(&rtwdev->mutex);
+	lockdep_assert_wiphy(wiphy);
 	rtw89_leave_ps_mode(rtwdev);
 	rtw89_btc_ntfy_specific_packet(rtwdev, PACKET_DHCP);
-	mutex_unlock(&rtwdev->mutex);
 }
 
 void rtw89_btc_ntfy_icmp_packet_work(struct wiphy *wiphy, struct wiphy_work *work)
@@ -7343,10 +7337,9 @@ void rtw89_btc_ntfy_icmp_packet_work(struct wiphy *wiphy, struct wiphy_work *wor
 	struct rtw89_dev *rtwdev = container_of(work, struct rtw89_dev,
 						btc.icmp_notify_work);
 
-	mutex_lock(&rtwdev->mutex);
+	lockdep_assert_wiphy(wiphy);
 	rtw89_leave_ps_mode(rtwdev);
 	rtw89_btc_ntfy_specific_packet(rtwdev, PACKET_ICMP);
-	mutex_unlock(&rtwdev->mutex);
 }
 
 static u8 _update_bt_rssi_level(struct rtw89_dev *rtwdev, u8 rssi)
diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 56c54a59144c..db5aeca64606 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -2079,7 +2079,7 @@ static void rtw89_cancel_6ghz_probe_work(struct wiphy *wiphy, struct wiphy_work
 	struct list_head *pkt_list = rtwdev->scan_info.pkt_list;
 	struct rtw89_pktofld_info *info;
 
-	mutex_lock(&rtwdev->mutex);
+	lockdep_assert_wiphy(wiphy);
 
 	if (!rtwdev->scanning)
 		goto out;
@@ -2097,7 +2097,6 @@ static void rtw89_cancel_6ghz_probe_work(struct wiphy *wiphy, struct wiphy_work
 	}
 
 out:
-	mutex_unlock(&rtwdev->mutex);
 }
 
 static void rtw89_core_cancel_6ghz_probe_tx(struct rtw89_dev *rtwdev,
@@ -3148,9 +3147,8 @@ static void rtw89_ips_work(struct wiphy *wiphy, struct wiphy_work *work)
 {
 	struct rtw89_dev *rtwdev = container_of(work, struct rtw89_dev,
 						ips_work);
-	mutex_lock(&rtwdev->mutex);
+	lockdep_assert_wiphy(wiphy);
 	rtw89_enter_ips_by_hwflags(rtwdev);
-	mutex_unlock(&rtwdev->mutex);
 }
 
 static void rtw89_core_txq_work(struct work_struct *w)
@@ -3292,7 +3290,7 @@ void rtw89_roc_start(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
 	u32 reg;
 	int ret;
 
-	lockdep_assert_held(&rtwdev->mutex);
+	lockdep_assert_wiphy(hw->wiphy);
 
 	rtw89_leave_ips_by_hwflags(rtwdev);
 	rtw89_leave_lps(rtwdev);
@@ -3346,7 +3344,7 @@ void rtw89_roc_end(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
 	u32 reg;
 	int ret;
 
-	lockdep_assert_held(&rtwdev->mutex);
+	lockdep_assert_wiphy(hw->wiphy);
 
 	ieee80211_remain_on_channel_expired(hw);
 
@@ -3389,7 +3387,7 @@ void rtw89_roc_work(struct wiphy *wiphy, struct wiphy_work *work)
 	struct rtw89_dev *rtwdev = rtwvif->rtwdev;
 	struct rtw89_roc *roc = &rtwvif->roc;
 
-	mutex_lock(&rtwdev->mutex);
+	lockdep_assert_wiphy(wiphy);
 
 	switch (roc->state) {
 	case RTW89_ROC_IDLE:
@@ -3402,8 +3400,6 @@ void rtw89_roc_work(struct wiphy *wiphy, struct wiphy_work *work)
 	default:
 		break;
 	}
-
-	mutex_unlock(&rtwdev->mutex);
 }
 
 static enum rtw89_tfc_lv rtw89_get_traffic_level(struct rtw89_dev *rtwdev,
@@ -3543,7 +3539,7 @@ static void rtw89_track_work(struct wiphy *wiphy, struct wiphy_work *work)
 	if (test_bit(RTW89_FLAG_FORBIDDEN_TRACK_WROK, rtwdev->flags))
 		return;
 
-	mutex_lock(&rtwdev->mutex);
+	lockdep_assert_wiphy(wiphy);
 
 	if (!test_bit(RTW89_FLAG_RUNNING, rtwdev->flags))
 		goto out;
@@ -3580,7 +3576,6 @@ static void rtw89_track_work(struct wiphy *wiphy, struct wiphy_work *work)
 		rtw89_enter_lps_track(rtwdev);
 
 out:
-	mutex_unlock(&rtwdev->mutex);
 }
 
 u8 rtw89_core_acquire_bit_map(unsigned long *addr, unsigned long size)
@@ -3614,7 +3609,7 @@ int rtw89_core_acquire_sta_ba_entry(struct rtw89_dev *rtwdev,
 	u8 idx;
 	int i;
 
-	lockdep_assert_held(&rtwdev->mutex);
+	lockdep_assert_wiphy(rtwdev->hw->wiphy);
 
 	idx = rtw89_core_acquire_bit_map(cam_info->ba_cam_map, chip->bacam_num);
 	if (idx == chip->bacam_num) {
@@ -3658,7 +3653,7 @@ int rtw89_core_release_sta_ba_entry(struct rtw89_dev *rtwdev,
 	struct rtw89_ba_cam_entry *entry = NULL, *tmp;
 	u8 idx;
 
-	lockdep_assert_held(&rtwdev->mutex);
+	lockdep_assert_wiphy(rtwdev->hw->wiphy);
 
 	list_for_each_entry_safe(entry, tmp, &rtwsta_link->ba_cam_list, list) {
 		if (entry->tid != tid)
@@ -4450,9 +4445,8 @@ void rtw89_core_update_beacon_work(struct wiphy *wiphy, struct wiphy_work *work)
 
 	rtwdev = rtwvif_link->rtwvif->rtwdev;
 
-	mutex_lock(&rtwdev->mutex);
+	lockdep_assert_wiphy(wiphy);
 	rtw89_chip_h2c_update_beacon(rtwdev, rtwvif_link);
-	mutex_unlock(&rtwdev->mutex);
 }
 
 int rtw89_wait_for_cond(struct rtw89_wait_info *wait, unsigned int cond)
@@ -4595,7 +4589,7 @@ void rtw89_core_stop(struct rtw89_dev *rtwdev)
 
 	clear_bit(RTW89_FLAG_RUNNING, rtwdev->flags);
 
-	mutex_unlock(&rtwdev->mutex);
+	lockdep_assert_wiphy(wiphy);
 
 	wiphy_work_cancel(wiphy, &rtwdev->c2h_work);
 	wiphy_work_cancel(wiphy, &rtwdev->cancel_6ghz_probe_work);
@@ -4613,8 +4607,6 @@ void rtw89_core_stop(struct rtw89_dev *rtwdev)
 	cancel_delayed_work_sync(&rtwdev->forbid_ba_work);
 	wiphy_delayed_work_cancel(wiphy, &rtwdev->antdiv_work);
 
-	mutex_lock(&rtwdev->mutex);
-
 	rtw89_btc_ntfy_poweroff(rtwdev);
 	rtw89_hci_flush_queues(rtwdev, BIT(rtwdev->hw->queues) - 1, true);
 	rtw89_mac_flush_txq(rtwdev, BIT(rtwdev->hw->queues) - 1, true);
diff --git a/drivers/net/wireless/realtek/rtw89/debug.c b/drivers/net/wireless/realtek/rtw89/debug.c
index 0863ed6acda2..56be6705e9ea 100644
--- a/drivers/net/wireless/realtek/rtw89/debug.c
+++ b/drivers/net/wireless/realtek/rtw89/debug.c
@@ -954,7 +954,7 @@ ssize_t rtw89_debug_priv_txpwr_table_get(struct rtw89_dev *rtwdev,
 	char *p = buf, *end = buf + bufsz;
 	ssize_t n;
 
-	mutex_lock(&rtwdev->mutex);
+	lockdep_assert_wiphy(rtwdev->hw->wiphy);
 	rtw89_leave_ps_mode(rtwdev);
 	chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
 
@@ -993,12 +993,9 @@ ssize_t rtw89_debug_priv_txpwr_table_get(struct rtw89_dev *rtwdev,
 		goto err;
 	p += n;
 
-	mutex_unlock(&rtwdev->mutex);
-
 	return p - buf;
 
 err:
-	mutex_unlock(&rtwdev->mutex);
 
 	return n;
 }
@@ -1201,7 +1198,7 @@ rtw89_debug_priv_mac_mem_dump_get(struct rtw89_dev *rtwdev,
 		}
 	}
 
-	mutex_lock(&rtwdev->mutex);
+	lockdep_assert_wiphy(rtwdev->hw->wiphy);
 	rtw89_leave_ps_mode(rtwdev);
 	if (grant_read)
 		rtw89_write32_set(rtwdev, R_AX_TCR1, B_AX_TCR_FORCE_READ_TXDFIFO);
@@ -1211,7 +1208,6 @@ rtw89_debug_priv_mac_mem_dump_get(struct rtw89_dev *rtwdev,
 				      debugfs_priv->mac_mem.len);
 	if (grant_read)
 		rtw89_write32_clr(rtwdev, R_AX_TCR1, B_AX_TCR_FORCE_READ_TXDFIFO);
-	mutex_unlock(&rtwdev->mutex);
 
 	return p - buf;
 }
@@ -3518,11 +3514,10 @@ rtw89_debug_priv_early_h2c_get(struct rtw89_dev *rtwdev,
 	char *p = buf, *end = buf + bufsz;
 	int seq = 0;
 
-	mutex_lock(&rtwdev->mutex);
+	lockdep_assert_wiphy(rtwdev->hw->wiphy);
 	list_for_each_entry(early_h2c, &rtwdev->early_h2c_list, list)
 		p += scnprintf(p, end - p, "%d: %*ph\n", ++seq,
 			       early_h2c->h2c_len, early_h2c->h2c);
-	mutex_unlock(&rtwdev->mutex);
 
 	return p - buf;
 }
@@ -3555,9 +3550,8 @@ rtw89_debug_priv_early_h2c_set(struct rtw89_dev *rtwdev,
 	early_h2c->h2c = h2c;
 	early_h2c->h2c_len = h2c_len;
 
-	mutex_lock(&rtwdev->mutex);
+	lockdep_assert_wiphy(rtwdev->hw->wiphy);
 	list_add_tail(&early_h2c->list, &rtwdev->early_h2c_list);
-	mutex_unlock(&rtwdev->mutex);
 
 out:
 	return count;
@@ -3633,10 +3627,9 @@ rtw89_debug_priv_fw_crash_set(struct rtw89_dev *rtwdev,
 		return -EINVAL;
 	}
 
-	mutex_lock(&rtwdev->mutex);
+	lockdep_assert_wiphy(rtwdev->hw->wiphy);
 	set_bit(RTW89_FLAG_CRASH_SIMULATING, rtwdev->flags);
 	ret = sim(rtwdev);
-	mutex_unlock(&rtwdev->mutex);
 
 	if (ret)
 		return ret;
@@ -3681,12 +3674,11 @@ static ssize_t rtw89_debug_priv_fw_log_manual_set(struct rtw89_dev *rtwdev,
 	if (kstrtobool(buf, &fw_log_manual))
 		goto out;
 
-	mutex_lock(&rtwdev->mutex);
+	lockdep_assert_wiphy(rtwdev->hw->wiphy);
 	log->enable = fw_log_manual;
 	if (log->enable)
 		rtw89_fw_log_prepare(rtwdev);
 	rtw89_fw_h2c_fw_log(rtwdev, fw_log_manual);
-	mutex_unlock(&rtwdev->mutex);
 out:
 	return count;
 }
@@ -4113,7 +4105,7 @@ static ssize_t rtw89_debug_priv_stations_get(struct rtw89_dev *rtwdev,
 	char *p = buf, *end = buf + bufsz;
 	u8 idx;
 
-	mutex_lock(&rtwdev->mutex);
+	lockdep_assert_wiphy(rtwdev->hw->wiphy);
 
 	p += scnprintf(p, end - p, "map:\n");
 	p += scnprintf(p, end - p, "\tmac_id:    %*ph\n",
@@ -4151,8 +4143,6 @@ static ssize_t rtw89_debug_priv_stations_get(struct rtw89_dev *rtwdev,
 	ieee80211_iterate_stations_atomic(rtwdev->hw, rtw89_sta_ids_get_iter, &iter_data);
 	p += iter_data.written_sz;
 
-	mutex_unlock(&rtwdev->mutex);
-
 	return p - buf;
 }
 
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 1703bce0957c..c8843349b5e6 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -5998,7 +5998,7 @@ void rtw89_fw_send_all_early_h2c(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_early_h2c *early_h2c;
 
-	lockdep_assert_held(&rtwdev->mutex);
+	lockdep_assert_wiphy(rtwdev->hw->wiphy);
 
 	list_for_each_entry(early_h2c, &rtwdev->early_h2c_list, list) {
 		rtw89_fw_h2c_raw(rtwdev, early_h2c->h2c, early_h2c->h2c_len);
@@ -6105,9 +6105,8 @@ void rtw89_fw_c2h_work(struct wiphy *wiphy, struct wiphy_work *work)
 
 	skb_queue_walk_safe(&rtwdev->c2h_queue, skb, tmp) {
 		skb_unlink(skb, &rtwdev->c2h_queue);
-		mutex_lock(&rtwdev->mutex);
+		lockdep_assert_wiphy(rtwdev->hw->wiphy);
 		rtw89_fw_c2h_cmd_handle(rtwdev, skb);
-		mutex_unlock(&rtwdev->mutex);
 		dev_kfree_skb_any(skb);
 	}
 }
@@ -6188,7 +6187,7 @@ int rtw89_fw_msg_reg(struct rtw89_dev *rtwdev,
 	u32 ret;
 
 	if (h2c_info && h2c_info->id != RTW89_FWCMD_H2CREG_FUNC_GET_FEATURE)
-		lockdep_assert_held(&rtwdev->mutex);
+		lockdep_assert_wiphy(rtwdev->hw->wiphy);
 
 	if (!h2c_info && !c2h_info)
 		return -EINVAL;
diff --git a/drivers/net/wireless/realtek/rtw89/mac80211.c b/drivers/net/wireless/realtek/rtw89/mac80211.c
index 7b3520e6389b..11516ede13e4 100644
--- a/drivers/net/wireless/realtek/rtw89/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw89/mac80211.c
@@ -59,9 +59,8 @@ static int rtw89_ops_start(struct ieee80211_hw *hw)
 	struct rtw89_dev *rtwdev = hw->priv;
 	int ret;
 
-	mutex_lock(&rtwdev->mutex);
+	lockdep_assert_wiphy(hw->wiphy);
 	ret = rtw89_core_start(rtwdev);
-	mutex_unlock(&rtwdev->mutex);
 
 	return ret;
 }
@@ -70,9 +69,8 @@ static void rtw89_ops_stop(struct ieee80211_hw *hw, bool suspend)
 {
 	struct rtw89_dev *rtwdev = hw->priv;
 
-	mutex_lock(&rtwdev->mutex);
+	lockdep_assert_wiphy(hw->wiphy);
 	rtw89_core_stop(rtwdev);
-	mutex_unlock(&rtwdev->mutex);
 }
 
 static int rtw89_ops_config(struct ieee80211_hw *hw, u32 changed)
@@ -82,7 +80,7 @@ static int rtw89_ops_config(struct ieee80211_hw *hw, u32 changed)
 	/* let previous ips work finish to ensure we don't leave ips twice */
 	wiphy_work_cancel(hw->wiphy, &rtwdev->ips_work);
 
-	mutex_lock(&rtwdev->mutex);
+	lockdep_assert_wiphy(hw->wiphy);
 	rtw89_leave_ps_mode(rtwdev);
 
 	if ((changed & IEEE80211_CONF_CHANGE_IDLE) &&
@@ -100,8 +98,6 @@ static int rtw89_ops_config(struct ieee80211_hw *hw, u32 changed)
 	    !rtwdev->scanning)
 		rtw89_enter_ips(rtwdev);
 
-	mutex_unlock(&rtwdev->mutex);
-
 	return 0;
 }
 
@@ -142,9 +138,8 @@ static int __rtw89_ops_add_iface_link(struct rtw89_dev *rtwdev,
 static void __rtw89_ops_remove_iface_link(struct rtw89_dev *rtwdev,
 					  struct rtw89_vif_link *rtwvif_link)
 {
-	mutex_unlock(&rtwdev->mutex);
+	lockdep_assert_wiphy(rtwdev->hw->wiphy);
 	wiphy_work_cancel(rtwdev->hw->wiphy, &rtwvif_link->update_beacon_work);
-	mutex_lock(&rtwdev->mutex);
 
 	rtw89_leave_ps_mode(rtwdev);
 
@@ -165,7 +160,7 @@ static int rtw89_ops_add_interface(struct ieee80211_hw *hw,
 	rtw89_debug(rtwdev, RTW89_DBG_STATE, "add vif %pM type %d, p2p %d\n",
 		    vif->addr, vif->type, vif->p2p);
 
-	mutex_lock(&rtwdev->mutex);
+	lockdep_assert_wiphy(hw->wiphy);
 
 	rtw89_leave_ips_by_hwflags(rtwdev);
 
@@ -213,8 +208,6 @@ static int rtw89_ops_add_interface(struct ieee80211_hw *hw,
 		goto unset_link;
 
 	rtw89_recalc_lps(rtwdev);
-
-	mutex_unlock(&rtwdev->mutex);
 	return 0;
 
 unset_link:
@@ -225,7 +218,6 @@ static int rtw89_ops_add_interface(struct ieee80211_hw *hw,
 release_macid:
 	rtw89_release_mac_id(rtwdev, mac_id);
 err:
-	mutex_unlock(&rtwdev->mutex);
 
 	return ret;
 }
@@ -244,7 +236,7 @@ static void rtw89_ops_remove_interface(struct ieee80211_hw *hw,
 
 	wiphy_delayed_work_cancel(hw->wiphy, &rtwvif->roc.roc_work);
 
-	mutex_lock(&rtwdev->mutex);
+	lockdep_assert_wiphy(hw->wiphy);
 
 	rtwvif_link = rtwvif->links[RTW89_VIF_IDLE_LINK_ID];
 	if (unlikely(!rtwvif_link)) {
@@ -265,8 +257,6 @@ static void rtw89_ops_remove_interface(struct ieee80211_hw *hw,
 
 	rtw89_recalc_lps(rtwdev);
 	rtw89_enter_ips_by_hwflags(rtwdev);
-
-	mutex_unlock(&rtwdev->mutex);
 }
 
 static int rtw89_ops_change_interface(struct ieee80211_hw *hw,
@@ -304,7 +294,7 @@ static void rtw89_ops_configure_filter(struct ieee80211_hw *hw,
 	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
 	u32 rx_fltr;
 
-	mutex_lock(&rtwdev->mutex);
+	lockdep_assert_wiphy(hw->wiphy);
 	rtw89_leave_ps_mode(rtwdev);
 
 	*new_flags &= FIF_ALLMULTI | FIF_OTHER_BSS | FIF_FCSFAIL |
@@ -374,7 +364,6 @@ static void rtw89_ops_configure_filter(struct ieee80211_hw *hw,
 			   rx_fltr);
 
 out:
-	mutex_unlock(&rtwdev->mutex);
 }
 
 static const u8 ac_to_fw_idx[IEEE80211_NUM_ACS] = {
@@ -689,7 +678,7 @@ static void rtw89_ops_vif_cfg_changed(struct ieee80211_hw *hw,
 	struct rtw89_dev *rtwdev = hw->priv;
 	struct rtw89_vif *rtwvif = vif_to_rtwvif(vif);
 
-	mutex_lock(&rtwdev->mutex);
+	lockdep_assert_wiphy(hw->wiphy);
 	rtw89_leave_ps_mode(rtwdev);
 
 	if (changed & BSS_CHANGED_ASSOC) {
@@ -712,8 +701,6 @@ static void rtw89_ops_vif_cfg_changed(struct ieee80211_hw *hw,
 
 	if (changed & BSS_CHANGED_ARP_FILTER)
 		rtwvif->ip_addr = vif->cfg.arp_addr_list[0];
-
-	mutex_unlock(&rtwdev->mutex);
 }
 
 static void rtw89_ops_link_info_changed(struct ieee80211_hw *hw,
@@ -725,7 +712,7 @@ static void rtw89_ops_link_info_changed(struct ieee80211_hw *hw,
 	struct rtw89_vif *rtwvif = vif_to_rtwvif(vif);
 	struct rtw89_vif_link *rtwvif_link;
 
-	mutex_lock(&rtwdev->mutex);
+	lockdep_assert_wiphy(hw->wiphy);
 	rtw89_leave_ps_mode(rtwdev);
 
 	rtwvif_link = rtwvif->links[conf->link_id];
@@ -765,7 +752,6 @@ static void rtw89_ops_link_info_changed(struct ieee80211_hw *hw,
 		rtw89_reg_6ghz_recalc(rtwdev, rtwvif_link, true);
 
 out:
-	mutex_unlock(&rtwdev->mutex);
 }
 
 static int rtw89_ops_start_ap(struct ieee80211_hw *hw,
@@ -778,7 +764,7 @@ static int rtw89_ops_start_ap(struct ieee80211_hw *hw,
 	const struct rtw89_chan *chan;
 	int ret = 0;
 
-	mutex_lock(&rtwdev->mutex);
+	lockdep_assert_wiphy(hw->wiphy);
 
 	rtwvif_link = rtwvif->links[link_conf->link_id];
 	if (unlikely(!rtwvif_link)) {
@@ -791,7 +777,6 @@ static int rtw89_ops_start_ap(struct ieee80211_hw *hw,
 
 	chan = rtw89_chan_get(rtwdev, rtwvif_link->chanctx_idx);
 	if (chan->band_type == RTW89_BAND_6G) {
-		mutex_unlock(&rtwdev->mutex);
 		return -EOPNOTSUPP;
 	}
 
@@ -816,7 +801,6 @@ static int rtw89_ops_start_ap(struct ieee80211_hw *hw,
 	rtw89_queue_chanctx_work(rtwdev);
 
 out:
-	mutex_unlock(&rtwdev->mutex);
 
 	return ret;
 }
@@ -829,7 +813,7 @@ void rtw89_ops_stop_ap(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	struct rtw89_vif *rtwvif = vif_to_rtwvif(vif);
 	struct rtw89_vif_link *rtwvif_link;
 
-	mutex_lock(&rtwdev->mutex);
+	lockdep_assert_wiphy(hw->wiphy);
 
 	rtwvif_link = rtwvif->links[link_conf->link_id];
 	if (unlikely(!rtwvif_link)) {
@@ -847,7 +831,6 @@ void rtw89_ops_stop_ap(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	rtw89_fw_h2c_join_info(rtwdev, rtwvif_link, NULL, true);
 
 out:
-	mutex_unlock(&rtwdev->mutex);
 }
 
 static int rtw89_ops_set_tim(struct ieee80211_hw *hw, struct ieee80211_sta *sta,
@@ -874,7 +857,7 @@ static int rtw89_ops_conf_tx(struct ieee80211_hw *hw,
 	struct rtw89_vif_link *rtwvif_link;
 	int ret = 0;
 
-	mutex_lock(&rtwdev->mutex);
+	lockdep_assert_wiphy(hw->wiphy);
 	rtw89_leave_ps_mode(rtwdev);
 
 	rtwvif_link = rtwvif->links[link_id];
@@ -890,7 +873,6 @@ static int rtw89_ops_conf_tx(struct ieee80211_hw *hw,
 	__rtw89_conf_tx(rtwdev, rtwvif_link, ac);
 
 out:
-	mutex_unlock(&rtwdev->mutex);
 
 	return ret;
 }
@@ -938,10 +920,9 @@ static int rtw89_ops_sta_state(struct ieee80211_hw *hw,
 	struct rtw89_dev *rtwdev = hw->priv;
 	int ret;
 
-	mutex_lock(&rtwdev->mutex);
+	lockdep_assert_wiphy(hw->wiphy);
 	rtw89_leave_ps_mode(rtwdev);
 	ret = __rtw89_ops_sta_state(hw, vif, sta, old_state, new_state);
-	mutex_unlock(&rtwdev->mutex);
 
 	return ret;
 }
@@ -954,7 +935,7 @@ static int rtw89_ops_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 	struct rtw89_dev *rtwdev = hw->priv;
 	int ret = 0;
 
-	mutex_lock(&rtwdev->mutex);
+	lockdep_assert_wiphy(hw->wiphy);
 	rtw89_leave_ps_mode(rtwdev);
 
 	switch (cmd) {
@@ -979,7 +960,6 @@ static int rtw89_ops_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 	}
 
 out:
-	mutex_unlock(&rtwdev->mutex);
 
 	return ret;
 }
@@ -1002,32 +982,28 @@ static int rtw89_ops_ampdu_action(struct ieee80211_hw *hw,
 	case IEEE80211_AMPDU_TX_STOP_CONT:
 	case IEEE80211_AMPDU_TX_STOP_FLUSH:
 	case IEEE80211_AMPDU_TX_STOP_FLUSH_CONT:
-		mutex_lock(&rtwdev->mutex);
+		lockdep_assert_wiphy(rtwdev->hw->wiphy);
 		clear_bit(RTW89_TXQ_F_AMPDU, &rtwtxq->flags);
 		clear_bit(tid, rtwsta->ampdu_map);
 		rtw89_chip_h2c_ampdu_cmac_tbl(rtwdev, rtwvif, rtwsta);
-		mutex_unlock(&rtwdev->mutex);
 		ieee80211_stop_tx_ba_cb_irqsafe(vif, sta->addr, tid);
 		break;
 	case IEEE80211_AMPDU_TX_OPERATIONAL:
-		mutex_lock(&rtwdev->mutex);
+		lockdep_assert_wiphy(rtwdev->hw->wiphy);
 		set_bit(RTW89_TXQ_F_AMPDU, &rtwtxq->flags);
 		rtwsta->ampdu_params[tid].agg_num = params->buf_size;
 		rtwsta->ampdu_params[tid].amsdu = params->amsdu;
 		set_bit(tid, rtwsta->ampdu_map);
 		rtw89_leave_ps_mode(rtwdev);
 		rtw89_chip_h2c_ampdu_cmac_tbl(rtwdev, rtwvif, rtwsta);
-		mutex_unlock(&rtwdev->mutex);
 		break;
 	case IEEE80211_AMPDU_RX_START:
-		mutex_lock(&rtwdev->mutex);
+		lockdep_assert_wiphy(rtwdev->hw->wiphy);
 		rtw89_chip_h2c_ba_cam(rtwdev, rtwsta, true, params);
-		mutex_unlock(&rtwdev->mutex);
 		break;
 	case IEEE80211_AMPDU_RX_STOP:
-		mutex_lock(&rtwdev->mutex);
+		lockdep_assert_wiphy(rtwdev->hw->wiphy);
 		rtw89_chip_h2c_ba_cam(rtwdev, rtwsta, false, params);
-		mutex_unlock(&rtwdev->mutex);
 		break;
 	default:
 		WARN_ON(1);
@@ -1041,11 +1017,10 @@ static int rtw89_ops_set_rts_threshold(struct ieee80211_hw *hw, u32 value)
 {
 	struct rtw89_dev *rtwdev = hw->priv;
 
-	mutex_lock(&rtwdev->mutex);
+	lockdep_assert_wiphy(hw->wiphy);
 	rtw89_leave_ps_mode(rtwdev);
 	if (test_bit(RTW89_FLAG_POWERON, rtwdev->flags))
 		rtw89_mac_update_rts_threshold(rtwdev);
-	mutex_unlock(&rtwdev->mutex);
 
 	return 0;
 }
@@ -1085,7 +1060,7 @@ static void rtw89_ops_flush(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 {
 	struct rtw89_dev *rtwdev = hw->priv;
 
-	mutex_lock(&rtwdev->mutex);
+	lockdep_assert_wiphy(hw->wiphy);
 	rtw89_leave_lps(rtwdev);
 	rtw89_hci_flush_queues(rtwdev, queues, drop);
 
@@ -1093,8 +1068,6 @@ static void rtw89_ops_flush(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		__rtw89_drop_packets(rtwdev, vif);
 	else
 		rtw89_mac_flush_txq(rtwdev, queues, drop);
-
-	mutex_unlock(&rtwdev->mutex);
 }
 
 struct rtw89_iter_bitrate_mask_data {
@@ -1141,10 +1114,9 @@ static int rtw89_ops_set_bitrate_mask(struct ieee80211_hw *hw,
 {
 	struct rtw89_dev *rtwdev = hw->priv;
 
-	mutex_lock(&rtwdev->mutex);
+	lockdep_assert_wiphy(hw->wiphy);
 	rtw89_phy_rate_pattern_vif(rtwdev, vif, mask);
 	rtw89_ra_mask_info_update(rtwdev, vif, mask);
-	mutex_unlock(&rtwdev->mutex);
 
 	return 0;
 }
@@ -1162,12 +1134,11 @@ int rtw89_ops_set_antenna(struct ieee80211_hw *hw, u32 tx_ant, u32 rx_ant)
 		return -EINVAL;
 	}
 
-	mutex_lock(&rtwdev->mutex);
+	lockdep_assert_wiphy(hw->wiphy);
 	hal->antenna_tx = tx_ant;
 	hal->antenna_rx = rx_ant;
 	hal->tx_path_diversity = false;
 	hal->ant_diversity_fixed = true;
-	mutex_unlock(&rtwdev->mutex);
 
 	return 0;
 }
@@ -1192,7 +1163,7 @@ static void rtw89_ops_sw_scan_start(struct ieee80211_hw *hw,
 	struct rtw89_vif *rtwvif = vif_to_rtwvif(vif);
 	struct rtw89_vif_link *rtwvif_link;
 
-	mutex_lock(&rtwdev->mutex);
+	lockdep_assert_wiphy(hw->wiphy);
 
 	rtwvif_link = rtw89_vif_get_link_inst(rtwvif, 0);
 	if (unlikely(!rtwvif_link)) {
@@ -1203,7 +1174,6 @@ static void rtw89_ops_sw_scan_start(struct ieee80211_hw *hw,
 	rtw89_core_scan_start(rtwdev, rtwvif_link, mac_addr, false);
 
 out:
-	mutex_unlock(&rtwdev->mutex);
 }
 
 static void rtw89_ops_sw_scan_complete(struct ieee80211_hw *hw,
@@ -1213,7 +1183,7 @@ static void rtw89_ops_sw_scan_complete(struct ieee80211_hw *hw,
 	struct rtw89_vif *rtwvif = vif_to_rtwvif(vif);
 	struct rtw89_vif_link *rtwvif_link;
 
-	mutex_lock(&rtwdev->mutex);
+	lockdep_assert_wiphy(hw->wiphy);
 
 	rtwvif_link = rtw89_vif_get_link_inst(rtwvif, 0);
 	if (unlikely(!rtwvif_link)) {
@@ -1224,7 +1194,6 @@ static void rtw89_ops_sw_scan_complete(struct ieee80211_hw *hw,
 	rtw89_core_scan_complete(rtwdev, rtwvif_link, false);
 
 out:
-	mutex_unlock(&rtwdev->mutex);
 }
 
 static void rtw89_ops_reconfig_complete(struct ieee80211_hw *hw,
@@ -1247,7 +1216,7 @@ static int rtw89_ops_hw_scan(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	if (!RTW89_CHK_FW_FEATURE(SCAN_OFFLOAD, &rtwdev->fw))
 		return 1;
 
-	mutex_lock(&rtwdev->mutex);
+	lockdep_assert_wiphy(hw->wiphy);
 
 	if (rtwdev->scanning || rtwvif->offchan) {
 		ret = -EBUSY;
@@ -1269,7 +1238,6 @@ static int rtw89_ops_hw_scan(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	}
 
 out:
-	mutex_unlock(&rtwdev->mutex);
 
 	return ret;
 }
@@ -1284,7 +1252,7 @@ static void rtw89_ops_cancel_hw_scan(struct ieee80211_hw *hw,
 	if (!RTW89_CHK_FW_FEATURE(SCAN_OFFLOAD, &rtwdev->fw))
 		return;
 
-	mutex_lock(&rtwdev->mutex);
+	lockdep_assert_wiphy(hw->wiphy);
 
 	if (!rtwdev->scanning)
 		goto out;
@@ -1298,7 +1266,6 @@ static void rtw89_ops_cancel_hw_scan(struct ieee80211_hw *hw,
 	rtw89_hw_scan_abort(rtwdev, rtwvif_link);
 
 out:
-	mutex_unlock(&rtwdev->mutex);
 }
 
 static void rtw89_ops_sta_rc_update(struct ieee80211_hw *hw,
@@ -1323,9 +1290,8 @@ static int rtw89_ops_add_chanctx(struct ieee80211_hw *hw,
 	struct rtw89_dev *rtwdev = hw->priv;
 	int ret;
 
-	mutex_lock(&rtwdev->mutex);
+	lockdep_assert_wiphy(hw->wiphy);
 	ret = rtw89_chanctx_ops_add(rtwdev, ctx);
-	mutex_unlock(&rtwdev->mutex);
 
 	return ret;
 }
@@ -1335,9 +1301,8 @@ static void rtw89_ops_remove_chanctx(struct ieee80211_hw *hw,
 {
 	struct rtw89_dev *rtwdev = hw->priv;
 
-	mutex_lock(&rtwdev->mutex);
+	lockdep_assert_wiphy(hw->wiphy);
 	rtw89_chanctx_ops_remove(rtwdev, ctx);
-	mutex_unlock(&rtwdev->mutex);
 }
 
 static void rtw89_ops_change_chanctx(struct ieee80211_hw *hw,
@@ -1346,9 +1311,8 @@ static void rtw89_ops_change_chanctx(struct ieee80211_hw *hw,
 {
 	struct rtw89_dev *rtwdev = hw->priv;
 
-	mutex_lock(&rtwdev->mutex);
+	lockdep_assert_wiphy(hw->wiphy);
 	rtw89_chanctx_ops_change(rtwdev, ctx, changed);
-	mutex_unlock(&rtwdev->mutex);
 }
 
 static int rtw89_ops_assign_vif_chanctx(struct ieee80211_hw *hw,
@@ -1361,7 +1325,7 @@ static int rtw89_ops_assign_vif_chanctx(struct ieee80211_hw *hw,
 	struct rtw89_vif_link *rtwvif_link;
 	int ret;
 
-	mutex_lock(&rtwdev->mutex);
+	lockdep_assert_wiphy(hw->wiphy);
 
 	rtwvif_link = rtwvif->links[link_conf->link_id];
 	if (unlikely(!rtwvif_link)) {
@@ -1375,7 +1339,6 @@ static int rtw89_ops_assign_vif_chanctx(struct ieee80211_hw *hw,
 	ret = rtw89_chanctx_ops_assign_vif(rtwdev, rtwvif_link, ctx);
 
 out:
-	mutex_unlock(&rtwdev->mutex);
 
 	return ret;
 }
@@ -1389,11 +1352,10 @@ static void rtw89_ops_unassign_vif_chanctx(struct ieee80211_hw *hw,
 	struct rtw89_vif *rtwvif = vif_to_rtwvif(vif);
 	struct rtw89_vif_link *rtwvif_link;
 
-	mutex_lock(&rtwdev->mutex);
+	lockdep_assert_wiphy(hw->wiphy);
 
 	rtwvif_link = rtwvif->links[link_conf->link_id];
 	if (unlikely(!rtwvif_link)) {
-		mutex_unlock(&rtwdev->mutex);
 		rtw89_err(rtwdev,
 			  "%s: rtwvif link (link_id %u) is not active\n",
 			  __func__, link_conf->link_id);
@@ -1401,7 +1363,6 @@ static void rtw89_ops_unassign_vif_chanctx(struct ieee80211_hw *hw,
 	}
 
 	rtw89_chanctx_ops_unassign_vif(rtwdev, rtwvif_link, ctx);
-	mutex_unlock(&rtwdev->mutex);
 }
 
 static int rtw89_ops_remain_on_channel(struct ieee80211_hw *hw,
@@ -1417,10 +1378,9 @@ static int rtw89_ops_remain_on_channel(struct ieee80211_hw *hw,
 	if (!rtwvif)
 		return -EINVAL;
 
-	mutex_lock(&rtwdev->mutex);
+	lockdep_assert_wiphy(hw->wiphy);
 
 	if (roc->state != RTW89_ROC_IDLE) {
-		mutex_unlock(&rtwdev->mutex);
 		return -EBUSY;
 	}
 
@@ -1438,8 +1398,6 @@ static int rtw89_ops_remain_on_channel(struct ieee80211_hw *hw,
 
 	rtw89_roc_start(rtwdev, rtwvif);
 
-	mutex_unlock(&rtwdev->mutex);
-
 	return 0;
 }
 
@@ -1454,9 +1412,8 @@ static int rtw89_ops_cancel_remain_on_channel(struct ieee80211_hw *hw,
 
 	wiphy_delayed_work_cancel(hw->wiphy, &rtwvif->roc.roc_work);
 
-	mutex_lock(&rtwdev->mutex);
+	lockdep_assert_wiphy(hw->wiphy);
 	rtw89_roc_end(rtwdev, rtwvif);
-	mutex_unlock(&rtwdev->mutex);
 
 	return 0;
 }
@@ -1477,14 +1434,13 @@ static int rtw89_ops_set_tid_config(struct ieee80211_hw *hw,
 {
 	struct rtw89_dev *rtwdev = hw->priv;
 
-	mutex_lock(&rtwdev->mutex);
+	lockdep_assert_wiphy(hw->wiphy);
 	if (sta)
 		rtw89_core_set_tid_config(rtwdev, sta, tid_config);
 	else
 		ieee80211_iterate_stations_atomic(rtwdev->hw,
 						  rtw89_set_tid_config_iter,
 						  tid_config);
-	mutex_unlock(&rtwdev->mutex);
 
 	return 0;
 }
@@ -1508,7 +1464,7 @@ static bool rtw89_ops_can_activate_links(struct ieee80211_hw *hw,
 {
 	struct rtw89_dev *rtwdev = hw->priv;
 
-	guard(mutex)(&rtwdev->mutex);
+	lockdep_assert_wiphy(hw->wiphy);
 
 	return rtw89_can_work_on_links(rtwdev, vif, active_links);
 }
@@ -1570,7 +1526,7 @@ int rtw89_ops_change_vif_links(struct ieee80211_hw *hw,
 	int ret = 0;
 	int i;
 
-	guard(mutex)(&rtwdev->mutex);
+	lockdep_assert_wiphy(hw->wiphy);
 
 	rtw89_debug(rtwdev, RTW89_DBG_STATE,
 		    "%s: old_links (0x%08x) -> new_links (0x%08x)\n",
@@ -1719,7 +1675,7 @@ int rtw89_ops_change_sta_links(struct ieee80211_hw *hw,
 	unsigned long set_links = new_links & ~old_links;
 	int ret = 0;
 
-	guard(mutex)(&rtwdev->mutex);
+	lockdep_assert_wiphy(hw->wiphy);
 
 	rtw89_debug(rtwdev, RTW89_DBG_STATE,
 		    "%s: old_links (0x%08x) -> new_links (0x%08x)\n",
@@ -1752,9 +1708,8 @@ static int rtw89_ops_suspend(struct ieee80211_hw *hw,
 	set_bit(RTW89_FLAG_FORBIDDEN_TRACK_WROK, rtwdev->flags);
 	wiphy_delayed_work_cancel(hw->wiphy, &rtwdev->track_work);
 
-	mutex_lock(&rtwdev->mutex);
+	lockdep_assert_wiphy(hw->wiphy);
 	ret = rtw89_wow_suspend(rtwdev, wowlan);
-	mutex_unlock(&rtwdev->mutex);
 
 	if (ret) {
 		rtw89_warn(rtwdev, "failed to suspend for wow %d\n", ret);
@@ -1770,11 +1725,10 @@ static int rtw89_ops_resume(struct ieee80211_hw *hw)
 	struct rtw89_dev *rtwdev = hw->priv;
 	int ret;
 
-	mutex_lock(&rtwdev->mutex);
+	lockdep_assert_wiphy(hw->wiphy);
 	ret = rtw89_wow_resume(rtwdev);
 	if (ret)
 		rtw89_warn(rtwdev, "failed to resume for wow %d\n", ret);
-	mutex_unlock(&rtwdev->mutex);
 
 	clear_bit(RTW89_FLAG_FORBIDDEN_TRACK_WROK, rtwdev->flags);
 	wiphy_delayed_work_queue(hw->wiphy, &rtwdev->track_work,
@@ -1804,12 +1758,10 @@ static void rtw89_set_rekey_data(struct ieee80211_hw *hw,
 		return;
 	}
 
-	mutex_lock(&rtwdev->mutex);
+	lockdep_assert_wiphy(hw->wiphy);
 
 	memcpy(gtk_info->kek, data->kek, data->kek_len);
 	memcpy(gtk_info->kck, data->kck, data->kck_len);
-
-	mutex_unlock(&rtwdev->mutex);
 }
 #endif
 
@@ -1817,7 +1769,7 @@ static void rtw89_ops_rfkill_poll(struct ieee80211_hw *hw)
 {
 	struct rtw89_dev *rtwdev = hw->priv;
 
-	mutex_lock(&rtwdev->mutex);
+	lockdep_assert_wiphy(hw->wiphy);
 
 	/* wl_disable GPIO get floating when entering LPS */
 	if (test_bit(RTW89_FLAG_RUNNING, rtwdev->flags))
@@ -1826,7 +1778,6 @@ static void rtw89_ops_rfkill_poll(struct ieee80211_hw *hw)
 	rtw89_core_rfkill_poll(rtwdev, false);
 
 out:
-	mutex_unlock(&rtwdev->mutex);
 }
 
 const struct ieee80211_ops rtw89_ops = {
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index fc8a93573144..26370eadf77f 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -4661,7 +4661,7 @@ void rtw89_phy_cfo_track_work(struct wiphy *wiphy, struct wiphy_work *work)
 						cfo_track_work.work);
 	struct rtw89_cfo_tracking_info *cfo = &rtwdev->cfo_tracking;
 
-	mutex_lock(&rtwdev->mutex);
+	lockdep_assert_wiphy(wiphy);
 	if (!cfo->cfo_trig_by_timer_en)
 		goto out;
 	rtw89_leave_ps_mode(rtwdev);
@@ -4669,7 +4669,6 @@ void rtw89_phy_cfo_track_work(struct wiphy *wiphy, struct wiphy_work *work)
 	wiphy_delayed_work_queue(wiphy, &rtwdev->cfo_track_work,
 				 msecs_to_jiffies(cfo->cfo_timer_ms));
 out:
-	mutex_unlock(&rtwdev->mutex);
 }
 
 static void rtw89_phy_cfo_start_work(struct rtw89_dev *rtwdev)
@@ -6537,7 +6536,7 @@ void rtw89_phy_antdiv_work(struct wiphy *wiphy, struct wiphy_work *work)
 						antdiv_work.work);
 	struct rtw89_antdiv_info *antdiv = &rtwdev->antdiv;
 
-	mutex_lock(&rtwdev->mutex);
+	lockdep_assert_wiphy(wiphy);
 
 	if (antdiv->training_count <= ANTDIV_TRAINNING_CNT) {
 		rtw89_phy_antdiv_training_state(rtwdev);
@@ -6545,8 +6544,6 @@ void rtw89_phy_antdiv_work(struct wiphy *wiphy, struct wiphy_work *work)
 		rtw89_phy_antdiv_decision_state(rtwdev);
 		rtw89_phy_antdiv_set_ant(rtwdev);
 	}
-
-	mutex_unlock(&rtwdev->mutex);
 }
 
 void rtw89_phy_antdiv_track(struct rtw89_dev *rtwdev)
diff --git a/drivers/net/wireless/realtek/rtw89/ps.c b/drivers/net/wireless/realtek/rtw89/ps.c
index 96ea04d90cd3..ac46a7baa00d 100644
--- a/drivers/net/wireless/realtek/rtw89/ps.c
+++ b/drivers/net/wireless/realtek/rtw89/ps.c
@@ -113,7 +113,7 @@ static void __rtw89_leave_lps(struct rtw89_dev *rtwdev,
 
 void rtw89_leave_ps_mode(struct rtw89_dev *rtwdev)
 {
-	lockdep_assert_held(&rtwdev->mutex);
+	lockdep_assert_wiphy(rtwdev->hw->wiphy);
 
 	__rtw89_leave_ps_mode(rtwdev);
 }
@@ -125,7 +125,7 @@ void rtw89_enter_lps(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
 	bool can_ps_mode = true;
 	unsigned int link_id;
 
-	lockdep_assert_held(&rtwdev->mutex);
+	lockdep_assert_wiphy(rtwdev->hw->wiphy);
 
 	if (test_and_set_bit(RTW89_FLAG_LEISURE_PS, rtwdev->flags))
 		return;
@@ -162,7 +162,7 @@ void rtw89_leave_lps(struct rtw89_dev *rtwdev)
 	struct rtw89_vif *rtwvif;
 	unsigned int link_id;
 
-	lockdep_assert_held(&rtwdev->mutex);
+	lockdep_assert_wiphy(rtwdev->hw->wiphy);
 
 	if (!test_and_clear_bit(RTW89_FLAG_LEISURE_PS, rtwdev->flags))
 		return;
diff --git a/drivers/net/wireless/realtek/rtw89/regd.c b/drivers/net/wireless/realtek/rtw89/regd.c
index 5b8d95c90d73..ccac7eb1bd0f 100644
--- a/drivers/net/wireless/realtek/rtw89/regd.c
+++ b/drivers/net/wireless/realtek/rtw89/regd.c
@@ -721,7 +721,7 @@ void rtw89_regd_notifier(struct wiphy *wiphy, struct regulatory_request *request
 	struct rtw89_dev *rtwdev = hw->priv;
 
 	wiphy_lock(wiphy);
-	mutex_lock(&rtwdev->mutex);
+	lockdep_assert_wiphy(wiphy);
 	rtw89_leave_ps_mode(rtwdev);
 
 	if (wiphy->regd) {
@@ -737,7 +737,6 @@ void rtw89_regd_notifier(struct wiphy *wiphy, struct regulatory_request *request
 	rtw89_core_set_chip_txpwr(rtwdev);
 
 exit:
-	mutex_unlock(&rtwdev->mutex);
 	wiphy_unlock(wiphy);
 }
 
@@ -988,7 +987,7 @@ int rtw89_reg_6ghz_recalc(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwvi
 	unsigned int changed = 0;
 	int ret;
 
-	lockdep_assert_held(&rtwdev->mutex);
+	lockdep_assert_wiphy(rtwdev->hw->wiphy);
 
 	/* The result of reg_6ghz_tpe may depend on reg_6ghz_power type,
 	 * so must do reg_6ghz_tpe_recalc() after reg_6ghz_power_recalc().
diff --git a/drivers/net/wireless/realtek/rtw89/sar.c b/drivers/net/wireless/realtek/rtw89/sar.c
index 1f67a2fbce81..949edb4bd4df 100644
--- a/drivers/net/wireless/realtek/rtw89/sar.c
+++ b/drivers/net/wireless/realtek/rtw89/sar.c
@@ -150,7 +150,7 @@ s8 rtw89_query_sar(struct rtw89_dev *rtwdev, u32 center_freq)
 	s32 cfg;
 	u8 fct;
 
-	lockdep_assert_held(&rtwdev->mutex);
+	lockdep_assert_wiphy(rtwdev->hw->wiphy);
 
 	if (src == RTW89_SAR_SOURCE_NONE)
 		return RTW89_SAR_TXPWR_MAC_MAX;
@@ -190,7 +190,7 @@ int rtw89_print_sar(struct rtw89_dev *rtwdev, char *buf, size_t bufsz,
 	s32 cfg;
 	u8 fct;
 
-	lockdep_assert_held(&rtwdev->mutex);
+	lockdep_assert_wiphy(rtwdev->hw->wiphy);
 
 	if (src == RTW89_SAR_SOURCE_NONE) {
 		p += scnprintf(p, end - p, "no SAR is applied\n");
@@ -241,7 +241,7 @@ static int rtw89_apply_sar_common(struct rtw89_dev *rtwdev,
 	enum rtw89_sar_sources src;
 	int ret = 0;
 
-	mutex_lock(&rtwdev->mutex);
+	lockdep_assert_wiphy(rtwdev->hw->wiphy);
 
 	src = rtwdev->sar.src;
 	if (src != RTW89_SAR_SOURCE_NONE && src != RTW89_SAR_SOURCE_COMMON) {
@@ -254,7 +254,6 @@ static int rtw89_apply_sar_common(struct rtw89_dev *rtwdev,
 	rtw89_core_set_chip_txpwr(rtwdev);
 
 exit:
-	mutex_unlock(&rtwdev->mutex);
 	return ret;
 }
 
@@ -328,7 +327,7 @@ static void rtw89_tas_state_update(struct rtw89_dev *rtwdev)
 	const struct rtw89_chan *chan;
 	int ret;
 
-	lockdep_assert_held(&rtwdev->mutex);
+	lockdep_assert_wiphy(rtwdev->hw->wiphy);
 
 	if (src == RTW89_SAR_SOURCE_NONE)
 		return;
diff --git a/drivers/net/wireless/realtek/rtw89/ser.c b/drivers/net/wireless/realtek/rtw89/ser.c
index 9658672ad274..b9607bdca6c8 100644
--- a/drivers/net/wireless/realtek/rtw89/ser.c
+++ b/drivers/net/wireless/realtek/rtw89/ser.c
@@ -157,9 +157,8 @@ static void ser_state_run(struct rtw89_ser *ser, u8 evt)
 		    ser_st_name(ser), ser_ev_name(ser, evt));
 
 	wiphy_lock(rtwdev->hw->wiphy);
-	mutex_lock(&rtwdev->mutex);
+	lockdep_assert_wiphy(rtwdev->hw->wiphy);
 	rtw89_leave_lps(rtwdev);
-	mutex_unlock(&rtwdev->mutex);
 	wiphy_unlock(rtwdev->hw->wiphy);
 
 	ser->st_tbl[ser->state].st_func(ser, evt);
@@ -714,9 +713,8 @@ static void ser_l2_reset_st_hdl(struct rtw89_ser *ser, u8 evt)
 	switch (evt) {
 	case SER_EV_STATE_IN:
 		wiphy_lock(rtwdev->hw->wiphy);
-		mutex_lock(&rtwdev->mutex);
+		lockdep_assert_wiphy(rtwdev->hw->wiphy);
 		ser_l2_reset_st_pre_hdl(ser);
-		mutex_unlock(&rtwdev->mutex);
 		wiphy_unlock(rtwdev->hw->wiphy);
 
 		ieee80211_restart_hw(rtwdev->hw);
diff --git a/drivers/net/wireless/realtek/rtw89/util.h b/drivers/net/wireless/realtek/rtw89/util.h
index 71c7d3502202..df283a858046 100644
--- a/drivers/net/wireless/realtek/rtw89/util.h
+++ b/drivers/net/wireless/realtek/rtw89/util.h
@@ -25,7 +25,7 @@ static inline bool rtw89_rtwvif_in_list(struct rtw89_dev *rtwdev,
 {
 	struct rtw89_vif *rtwvif;
 
-	lockdep_assert_held(&rtwdev->mutex);
+	lockdep_assert_wiphy(rtwdev->hw->wiphy);
 
 	rtw89_for_each_rtwvif(rtwdev, rtwvif)
 		if (rtwvif == new)
diff --git a/drivers/net/wireless/realtek/rtw89/wow.c b/drivers/net/wireless/realtek/rtw89/wow.c
index 01754d031bb4..6031633b2709 100644
--- a/drivers/net/wireless/realtek/rtw89/wow.c
+++ b/drivers/net/wireless/realtek/rtw89/wow.c
@@ -619,12 +619,11 @@ static struct ieee80211_key_conf *rtw89_wow_gtk_rekey(struct rtw89_dev *rtwdev,
 	/* ieee80211_gtk_rekey_add() will call set_key(), therefore we
 	 * need to unlock mutex
 	 */
-	mutex_unlock(&rtwdev->mutex);
+	lockdep_assert_wiphy(rtwdev->hw->wiphy);
 	if (ieee80211_vif_is_mld(wow_vif))
 		key = ieee80211_gtk_rekey_add(wow_vif, rekey_conf, rtwvif_link->link_id);
 	else
 		key = ieee80211_gtk_rekey_add(wow_vif, rekey_conf, -1);
-	mutex_lock(&rtwdev->mutex);
 
 	kfree(rekey_conf);
 	if (IS_ERR(key)) {
-- 
2.25.1


