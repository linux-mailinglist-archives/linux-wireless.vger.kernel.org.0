Return-Path: <linux-wireless+bounces-10558-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC89193DDC6
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Jul 2024 10:07:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E09128420D
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Jul 2024 08:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83B1218641;
	Sat, 27 Jul 2024 08:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="BSzOFxtV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2EA3CF65
	for <linux-wireless@vger.kernel.org>; Sat, 27 Jul 2024 08:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722067645; cv=none; b=j3BTxmG7MDvyYuHZcOclwk7vsLnGecRds+g4afejE/Oy8PeQeBww1PEb0nuwQp//1XuGpBJbCJKuTpG/0C+9nNWd2vlzve2WLn1nqYdazyWZzHISK5LZABrT40fo6gayfEmkKS1XA6TmRojwr7007wUADExUF94u0GAuHzzvo5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722067645; c=relaxed/simple;
	bh=plGzGv17NjedgJFQvix0C6vc7LmMj37exyCvaLQi+LY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rvuD+q3xrXJITiDP/SNvCtvah5iVR/bOzVjMrzRPP9ich3QA6SAvWZrrHXqExKAHN6vxIdqVWZ8qZTdyNEByvTqNMwZA9N41yC21LUKszGi6fZwEbScTPctmgygq9deviHyajeDYwLQmaiwG0pUgL3OzUlCG2tlHKm/c9O4Vj2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=BSzOFxtV; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 46R87IZT01417421, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1722067638; bh=plGzGv17NjedgJFQvix0C6vc7LmMj37exyCvaLQi+LY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=BSzOFxtVtP4e56fTEbg6D1UAPbaSg5V0GQf/FOogIUQY1cNAvnERhO5ifL+mYZ/kE
	 2ffyoLCsPwuvGd52PKBwAn8pbfzDJRNEaXQe5IcmVV0oG4oo5VQ4wt5xG6rHiXT0cs
	 KxfqiexWNjL4/MaxPv4yX5BnSh+KTbRLhwuKsaunHuQmw5vLkJBh7/G1De/iJpGJ2n
	 vuOfRcNLVOarJF+GHUzar1PGbn/rjh5b1OMvt3GmFHurFf5KcAQTN6cLA4ApAoPjMh
	 dIwax6yYD5kN+cJLS5GMeaMioC3s99YQ2rIyEoD2oq1z8/NZnb/Sxdt0VKK650+1z1
	 mpf0/zSOxrRXQ==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 46R87IZT01417421
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Sat, 27 Jul 2024 16:07:18 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sat, 27 Jul 2024 16:07:17 +0800
Received: from [127.0.1.1] (172.16.17.30) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Sat, 27 Jul
 2024 16:07:16 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <kevin_yang@realtek.com>
Subject: [PATCH 3/7] wifi: rtw89: rename sub_entity to chanctx
Date: Sat, 27 Jul 2024 16:06:46 +0800
Message-ID: <20240727080650.12195-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240727080650.12195-1-pkshih@realtek.com>
References: <20240727080650.12195-1-pkshih@realtek.com>
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

From: Zong-Zhe Yang <kevin_yang@realtek.com>

Originally, we planed to fill MAC_0/1 indicators with chanctx and
use sub_entity_xxx for these things. However, there are some reasons
listed below which make us give up this plan after we know our Wi-Fi 7
HW design.
	1. one link is bound to one HW band during its life time
	   but, one link might change chanctx dynamically
	2. in concurrent mode, assume 1st vif is MLD
	   1st vif's 2nd link might use the same chanctx as 2nd vif
	   but, they are not on the same HW band
So, we let sub_entity_xxx stuffs deal with only chanctx now. And, to be
more readable, we rename sub_entity related words to chanctx.

No logic is changed.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/chan.c     | 112 +++++++++---------
 drivers/net/wireless/realtek/rtw89/chan.h     |   6 +-
 drivers/net/wireless/realtek/rtw89/coex.c     |   2 +-
 drivers/net/wireless/realtek/rtw89/coex.h     |   2 +-
 drivers/net/wireless/realtek/rtw89/core.c     |  54 ++++-----
 drivers/net/wireless/realtek/rtw89/core.h     |  38 +++---
 drivers/net/wireless/realtek/rtw89/debug.c    |   2 +-
 drivers/net/wireless/realtek/rtw89/fw.c       |  18 +--
 drivers/net/wireless/realtek/rtw89/mac.c      |   4 +-
 drivers/net/wireless/realtek/rtw89/mac80211.c |   8 +-
 drivers/net/wireless/realtek/rtw89/phy.c      |  10 +-
 drivers/net/wireless/realtek/rtw89/regd.c     |   4 +-
 drivers/net/wireless/realtek/rtw89/rtw8851b.c |   6 +-
 .../net/wireless/realtek/rtw89/rtw8851b_rfk.c |  26 ++--
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |   2 +-
 .../net/wireless/realtek/rtw89/rtw8852a_rfk.c |  30 ++---
 .../wireless/realtek/rtw89/rtw8852b_common.c  |   4 +-
 .../net/wireless/realtek/rtw89/rtw8852b_rfk.c |  38 +++---
 .../wireless/realtek/rtw89/rtw8852bt_rfk.c    |  34 +++---
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |   2 +-
 .../net/wireless/realtek/rtw89/rtw8852c_rfk.c |  30 ++---
 drivers/net/wireless/realtek/rtw89/rtw8922a.c |   4 +-
 .../net/wireless/realtek/rtw89/rtw8922a_rfk.c |   8 +-
 drivers/net/wireless/realtek/rtw89/sar.c      |   2 +-
 24 files changed, 223 insertions(+), 223 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/chan.c b/drivers/net/wireless/realtek/rtw89/chan.c
index 0d848aef72b9..a67e16ded91d 100644
--- a/drivers/net/wireless/realtek/rtw89/chan.c
+++ b/drivers/net/wireless/realtek/rtw89/chan.c
@@ -124,12 +124,12 @@ void rtw89_chan_create(struct rtw89_chan *chan, u8 center_chan, u8 primary_chan,
 }
 
 bool rtw89_assign_entity_chan(struct rtw89_dev *rtwdev,
-			      enum rtw89_sub_entity_idx idx,
+			      enum rtw89_chanctx_idx idx,
 			      const struct rtw89_chan *new)
 {
 	struct rtw89_hal *hal = &rtwdev->hal;
-	struct rtw89_chan *chan = &hal->sub[idx].chan;
-	struct rtw89_chan_rcd *rcd = &hal->sub[idx].rcd;
+	struct rtw89_chan *chan = &hal->chanctx[idx].chan;
+	struct rtw89_chan_rcd *rcd = &hal->chanctx[idx].rcd;
 	bool band_changed;
 
 	rcd->prev_primary_channel = chan->primary_channel;
@@ -153,7 +153,7 @@ int rtw89_iterate_entity_chan(struct rtw89_dev *rtwdev,
 
 	lockdep_assert_held(&rtwdev->mutex);
 
-	for_each_set_bit(idx,  hal->entity_map, NUM_OF_RTW89_SUB_ENTITY) {
+	for_each_set_bit(idx,  hal->entity_map, NUM_OF_RTW89_CHANCTX) {
 		chan = rtw89_chan_get(rtwdev, idx);
 		ret = iterator(chan, data);
 		if (ret)
@@ -164,36 +164,36 @@ int rtw89_iterate_entity_chan(struct rtw89_dev *rtwdev,
 }
 
 static void __rtw89_config_entity_chandef(struct rtw89_dev *rtwdev,
-					  enum rtw89_sub_entity_idx idx,
+					  enum rtw89_chanctx_idx idx,
 					  const struct cfg80211_chan_def *chandef,
 					  bool from_stack)
 {
 	struct rtw89_hal *hal = &rtwdev->hal;
 
-	hal->sub[idx].chandef = *chandef;
+	hal->chanctx[idx].chandef = *chandef;
 
 	if (from_stack)
 		set_bit(idx, hal->entity_map);
 }
 
 void rtw89_config_entity_chandef(struct rtw89_dev *rtwdev,
-				 enum rtw89_sub_entity_idx idx,
+				 enum rtw89_chanctx_idx idx,
 				 const struct cfg80211_chan_def *chandef)
 {
 	__rtw89_config_entity_chandef(rtwdev, idx, chandef, true);
 }
 
 void rtw89_config_roc_chandef(struct rtw89_dev *rtwdev,
-			      enum rtw89_sub_entity_idx idx,
+			      enum rtw89_chanctx_idx idx,
 			      const struct cfg80211_chan_def *chandef)
 {
 	struct rtw89_hal *hal = &rtwdev->hal;
-	enum rtw89_sub_entity_idx cur;
+	enum rtw89_chanctx_idx cur;
 
 	if (chandef) {
 		cur = atomic_cmpxchg(&hal->roc_entity_idx,
-				     RTW89_SUB_ENTITY_IDLE, idx);
-		if (cur != RTW89_SUB_ENTITY_IDLE) {
+				     RTW89_CHANCTX_IDLE, idx);
+		if (cur != RTW89_CHANCTX_IDLE) {
 			rtw89_debug(rtwdev, RTW89_DBG_TXRX,
 				    "ROC still processing on entity %d\n", idx);
 			return;
@@ -202,11 +202,11 @@ void rtw89_config_roc_chandef(struct rtw89_dev *rtwdev,
 		hal->roc_chandef = *chandef;
 	} else {
 		cur = atomic_cmpxchg(&hal->roc_entity_idx, idx,
-				     RTW89_SUB_ENTITY_IDLE);
+				     RTW89_CHANCTX_IDLE);
 		if (cur == idx)
 			return;
 
-		if (cur == RTW89_SUB_ENTITY_IDLE)
+		if (cur == RTW89_CHANCTX_IDLE)
 			rtw89_debug(rtwdev, RTW89_DBG_TXRX,
 				    "ROC already finished on entity %d\n", idx);
 		else
@@ -220,7 +220,7 @@ static void rtw89_config_default_chandef(struct rtw89_dev *rtwdev)
 	struct cfg80211_chan_def chandef = {0};
 
 	rtw89_get_default_chandef(&chandef);
-	__rtw89_config_entity_chandef(rtwdev, RTW89_SUB_ENTITY_0, &chandef, false);
+	__rtw89_config_entity_chandef(rtwdev, RTW89_CHANCTX_0, &chandef, false);
 }
 
 void rtw89_entity_init(struct rtw89_dev *rtwdev)
@@ -228,9 +228,9 @@ void rtw89_entity_init(struct rtw89_dev *rtwdev)
 	struct rtw89_hal *hal = &rtwdev->hal;
 
 	hal->entity_pause = false;
-	bitmap_zero(hal->entity_map, NUM_OF_RTW89_SUB_ENTITY);
+	bitmap_zero(hal->entity_map, NUM_OF_RTW89_CHANCTX);
 	bitmap_zero(hal->changes, NUM_OF_RTW89_CHANCTX_CHANGES);
-	atomic_set(&hal->roc_entity_idx, RTW89_SUB_ENTITY_IDLE);
+	atomic_set(&hal->roc_entity_idx, RTW89_CHANCTX_IDLE);
 	rtw89_config_default_chandef(rtwdev);
 }
 
@@ -242,8 +242,8 @@ static void rtw89_entity_calculate_weight(struct rtw89_dev *rtwdev,
 	struct rtw89_vif *rtwvif;
 	int idx;
 
-	for_each_set_bit(idx, hal->entity_map, NUM_OF_RTW89_SUB_ENTITY) {
-		cfg = hal->sub[idx].cfg;
+	for_each_set_bit(idx, hal->entity_map, NUM_OF_RTW89_CHANCTX) {
+		cfg = hal->chanctx[idx].cfg;
 		if (!cfg) {
 			/* doesn't run with chanctx ops; one channel at most */
 			w->active_chanctxs = 1;
@@ -262,7 +262,7 @@ static void rtw89_entity_calculate_weight(struct rtw89_dev *rtwdev,
 
 enum rtw89_entity_mode rtw89_entity_recalc(struct rtw89_dev *rtwdev)
 {
-	DECLARE_BITMAP(recalc_map, NUM_OF_RTW89_SUB_ENTITY) = {};
+	DECLARE_BITMAP(recalc_map, NUM_OF_RTW89_CHANCTX) = {};
 	struct rtw89_hal *hal = &rtwdev->hal;
 	const struct cfg80211_chan_def *chandef;
 	struct rtw89_entity_weight w = {};
@@ -272,23 +272,23 @@ enum rtw89_entity_mode rtw89_entity_recalc(struct rtw89_dev *rtwdev)
 
 	lockdep_assert_held(&rtwdev->mutex);
 
-	bitmap_copy(recalc_map, hal->entity_map, NUM_OF_RTW89_SUB_ENTITY);
+	bitmap_copy(recalc_map, hal->entity_map, NUM_OF_RTW89_CHANCTX);
 
 	rtw89_entity_calculate_weight(rtwdev, &w);
 	switch (w.active_chanctxs) {
 	default:
 		rtw89_warn(rtwdev, "unknown ent chanctxs weight: %d\n",
 			   w.active_chanctxs);
-		bitmap_zero(recalc_map, NUM_OF_RTW89_SUB_ENTITY);
+		bitmap_zero(recalc_map, NUM_OF_RTW89_CHANCTX);
 		fallthrough;
 	case 0:
 		rtw89_config_default_chandef(rtwdev);
-		set_bit(RTW89_SUB_ENTITY_0, recalc_map);
+		set_bit(RTW89_CHANCTX_0, recalc_map);
 		fallthrough;
 	case 1:
 		mode = RTW89_ENTITY_MODE_SCC;
 		break;
-	case 2 ... NUM_OF_RTW89_SUB_ENTITY:
+	case 2 ... NUM_OF_RTW89_CHANCTX:
 		if (w.active_roles != NUM_OF_RTW89_MCC_ROLES) {
 			rtw89_debug(rtwdev, RTW89_DBG_CHAN,
 				    "unhandled ent: %d chanctxs %d roles\n",
@@ -304,7 +304,7 @@ enum rtw89_entity_mode rtw89_entity_recalc(struct rtw89_dev *rtwdev)
 		break;
 	}
 
-	for_each_set_bit(idx, recalc_map, NUM_OF_RTW89_SUB_ENTITY) {
+	for_each_set_bit(idx, recalc_map, NUM_OF_RTW89_CHANCTX) {
 		chandef = rtw89_chandef_get(rtwdev, idx);
 		rtw89_get_channel_params(chandef, &chan);
 		if (chan.channel == 0) {
@@ -650,7 +650,7 @@ static int rtw89_mcc_fill_role(struct rtw89_dev *rtwdev,
 
 	role->duration = role->beacon_interval / 2;
 
-	chan = rtw89_chan_get(rtwdev, rtwvif->sub_entity_idx);
+	chan = rtw89_chan_get(rtwdev, rtwvif->chanctx_idx);
 	role->is_2ghz = chan->band_type == RTW89_BAND_2G;
 	role->is_go = rtwvif->wifi_role == RTW89_WIFI_ROLE_P2P_GO;
 	role->is_gc = rtwvif->wifi_role == RTW89_WIFI_ROLE_P2P_CLIENT;
@@ -678,10 +678,10 @@ static void rtw89_mcc_fill_bt_role(struct rtw89_dev *rtwdev)
 }
 
 struct rtw89_mcc_fill_role_selector {
-	struct rtw89_vif *bind_vif[NUM_OF_RTW89_SUB_ENTITY];
+	struct rtw89_vif *bind_vif[NUM_OF_RTW89_CHANCTX];
 };
 
-static_assert((u8)NUM_OF_RTW89_SUB_ENTITY >= NUM_OF_RTW89_MCC_ROLES);
+static_assert((u8)NUM_OF_RTW89_CHANCTX >= NUM_OF_RTW89_MCC_ROLES);
 
 static int rtw89_mcc_fill_role_iterator(struct rtw89_dev *rtwdev,
 					struct rtw89_mcc_role *mcc_role,
@@ -719,14 +719,14 @@ static int rtw89_mcc_fill_all_roles(struct rtw89_dev *rtwdev)
 		if (!rtwvif->chanctx_assigned)
 			continue;
 
-		if (sel.bind_vif[rtwvif->sub_entity_idx]) {
+		if (sel.bind_vif[rtwvif->chanctx_idx]) {
 			rtw89_warn(rtwdev,
 				   "MCC skip extra vif <macid %d> on chanctx[%d]\n",
-				   rtwvif->mac_id, rtwvif->sub_entity_idx);
+				   rtwvif->mac_id, rtwvif->chanctx_idx);
 			continue;
 		}
 
-		sel.bind_vif[rtwvif->sub_entity_idx] = rtwvif;
+		sel.bind_vif[rtwvif->chanctx_idx] = rtwvif;
 	}
 
 	ret = rtw89_iterate_mcc_roles(rtwdev, rtw89_mcc_fill_role_iterator, &sel);
@@ -1390,7 +1390,7 @@ static int __mcc_fw_add_role(struct rtw89_dev *rtwdev, struct rtw89_mcc_role *ro
 	const struct rtw89_chan *chan;
 	int ret;
 
-	chan = rtw89_chan_get(rtwdev, role->rtwvif->sub_entity_idx);
+	chan = rtw89_chan_get(rtwdev, role->rtwvif->chanctx_idx);
 	req.central_ch_seg0 = chan->channel;
 	req.primary_ch = chan->primary_channel;
 	req.bandwidth = chan->band_width;
@@ -1448,7 +1448,7 @@ void __mrc_fw_add_role(struct rtw89_dev *rtwdev, struct rtw89_mcc_role *role,
 	slot_arg->duration = role->duration;
 	slot_arg->role_num = 1;
 
-	chan = rtw89_chan_get(rtwdev, role->rtwvif->sub_entity_idx);
+	chan = rtw89_chan_get(rtwdev, role->rtwvif->chanctx_idx);
 
 	slot_arg->roles[0].role_type = RTW89_H2C_MRC_ROLE_WIFI;
 	slot_arg->roles[0].is_master = role == ref;
@@ -2370,9 +2370,9 @@ void rtw89_chanctx_proceed(struct rtw89_dev *rtwdev)
 	rtw89_queue_chanctx_work(rtwdev);
 }
 
-static void rtw89_swap_sub_entity(struct rtw89_dev *rtwdev,
-				  enum rtw89_sub_entity_idx idx1,
-				  enum rtw89_sub_entity_idx idx2)
+static void rtw89_swap_chanctx(struct rtw89_dev *rtwdev,
+			       enum rtw89_chanctx_idx idx1,
+			       enum rtw89_chanctx_idx idx2)
 {
 	struct rtw89_hal *hal = &rtwdev->hal;
 	struct rtw89_vif *rtwvif;
@@ -2381,18 +2381,18 @@ static void rtw89_swap_sub_entity(struct rtw89_dev *rtwdev,
 	if (idx1 == idx2)
 		return;
 
-	hal->sub[idx1].cfg->idx = idx2;
-	hal->sub[idx2].cfg->idx = idx1;
+	hal->chanctx[idx1].cfg->idx = idx2;
+	hal->chanctx[idx2].cfg->idx = idx1;
 
-	swap(hal->sub[idx1], hal->sub[idx2]);
+	swap(hal->chanctx[idx1], hal->chanctx[idx2]);
 
 	rtw89_for_each_rtwvif(rtwdev, rtwvif) {
 		if (!rtwvif->chanctx_assigned)
 			continue;
-		if (rtwvif->sub_entity_idx == idx1)
-			rtwvif->sub_entity_idx = idx2;
-		else if (rtwvif->sub_entity_idx == idx2)
-			rtwvif->sub_entity_idx = idx1;
+		if (rtwvif->chanctx_idx == idx1)
+			rtwvif->chanctx_idx = idx2;
+		else if (rtwvif->chanctx_idx == idx2)
+			rtwvif->chanctx_idx = idx1;
 	}
 
 	cur = atomic_read(&hal->roc_entity_idx);
@@ -2410,14 +2410,14 @@ int rtw89_chanctx_ops_add(struct rtw89_dev *rtwdev,
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 	u8 idx;
 
-	idx = find_first_zero_bit(hal->entity_map, NUM_OF_RTW89_SUB_ENTITY);
+	idx = find_first_zero_bit(hal->entity_map, NUM_OF_RTW89_CHANCTX);
 	if (idx >= chip->support_chanctx_num)
 		return -ENOENT;
 
 	rtw89_config_entity_chandef(rtwdev, idx, &ctx->def);
 	cfg->idx = idx;
 	cfg->ref_count = 0;
-	hal->sub[idx].cfg = cfg;
+	hal->chanctx[idx].cfg = cfg;
 	return 0;
 }
 
@@ -2450,19 +2450,19 @@ int rtw89_chanctx_ops_assign_vif(struct rtw89_dev *rtwdev,
 	struct rtw89_chanctx_cfg *cfg = (struct rtw89_chanctx_cfg *)ctx->drv_priv;
 	struct rtw89_entity_weight w = {};
 
-	rtwvif->sub_entity_idx = cfg->idx;
+	rtwvif->chanctx_idx = cfg->idx;
 	rtwvif->chanctx_assigned = true;
 	cfg->ref_count++;
 
-	if (cfg->idx == RTW89_SUB_ENTITY_0)
+	if (cfg->idx == RTW89_CHANCTX_0)
 		goto out;
 
 	rtw89_entity_calculate_weight(rtwdev, &w);
 	if (w.active_chanctxs != 1)
 		goto out;
 
-	/* put the first active chanctx at RTW89_SUB_ENTITY_0 */
-	rtw89_swap_sub_entity(rtwdev, cfg->idx, RTW89_SUB_ENTITY_0);
+	/* put the first active chanctx at RTW89_CHANCTX_0 */
+	rtw89_swap_chanctx(rtwdev, cfg->idx, RTW89_CHANCTX_0);
 
 out:
 	return rtw89_set_channel(rtwdev);
@@ -2474,31 +2474,31 @@ void rtw89_chanctx_ops_unassign_vif(struct rtw89_dev *rtwdev,
 {
 	struct rtw89_chanctx_cfg *cfg = (struct rtw89_chanctx_cfg *)ctx->drv_priv;
 	struct rtw89_hal *hal = &rtwdev->hal;
-	enum rtw89_sub_entity_idx roll;
+	enum rtw89_chanctx_idx roll;
 	enum rtw89_entity_mode cur;
 	enum rtw89_entity_mode new;
 	int ret;
 
-	rtwvif->sub_entity_idx = RTW89_SUB_ENTITY_0;
+	rtwvif->chanctx_idx = RTW89_CHANCTX_0;
 	rtwvif->chanctx_assigned = false;
 	cfg->ref_count--;
 
 	if (cfg->ref_count != 0)
 		goto out;
 
-	if (cfg->idx != RTW89_SUB_ENTITY_0)
+	if (cfg->idx != RTW89_CHANCTX_0)
 		goto out;
 
-	roll = find_next_bit(hal->entity_map, NUM_OF_RTW89_SUB_ENTITY,
+	roll = find_next_bit(hal->entity_map, NUM_OF_RTW89_CHANCTX,
 			     cfg->idx + 1);
 	/* Follow rtw89_config_default_chandef() when rtw89_entity_recalc(). */
-	if (roll == NUM_OF_RTW89_SUB_ENTITY)
+	if (roll == NUM_OF_RTW89_CHANCTX)
 		goto out;
 
-	/* RTW89_SUB_ENTITY_0 is going to release, and another exists.
-	 * Make another roll down to RTW89_SUB_ENTITY_0 to replace.
+	/* RTW89_CHANCTX_0 is going to release, and another exists.
+	 * Make another roll down to RTW89_CHANCTX_0 to replace.
 	 */
-	rtw89_swap_sub_entity(rtwdev, cfg->idx, roll);
+	rtw89_swap_chanctx(rtwdev, cfg->idx, roll);
 
 out:
 	if (!hal->entity_pause) {
diff --git a/drivers/net/wireless/realtek/rtw89/chan.h b/drivers/net/wireless/realtek/rtw89/chan.h
index 5278ff8c513b..c6d31984e575 100644
--- a/drivers/net/wireless/realtek/rtw89/chan.h
+++ b/drivers/net/wireless/realtek/rtw89/chan.h
@@ -76,17 +76,17 @@ static inline void rtw89_set_entity_mode(struct rtw89_dev *rtwdev,
 void rtw89_chan_create(struct rtw89_chan *chan, u8 center_chan, u8 primary_chan,
 		       enum rtw89_band band, enum rtw89_bandwidth bandwidth);
 bool rtw89_assign_entity_chan(struct rtw89_dev *rtwdev,
-			      enum rtw89_sub_entity_idx idx,
+			      enum rtw89_chanctx_idx idx,
 			      const struct rtw89_chan *new);
 int rtw89_iterate_entity_chan(struct rtw89_dev *rtwdev,
 			      int (*iterator)(const struct rtw89_chan *chan,
 					      void *data),
 			      void *data);
 void rtw89_config_entity_chandef(struct rtw89_dev *rtwdev,
-				 enum rtw89_sub_entity_idx idx,
+				 enum rtw89_chanctx_idx idx,
 				 const struct cfg80211_chan_def *chandef);
 void rtw89_config_roc_chandef(struct rtw89_dev *rtwdev,
-			      enum rtw89_sub_entity_idx idx,
+			      enum rtw89_chanctx_idx idx,
 			      const struct cfg80211_chan_def *chandef);
 void rtw89_entity_init(struct rtw89_dev *rtwdev);
 enum rtw89_entity_mode rtw89_entity_recalc(struct rtw89_dev *rtwdev);
diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index 24929ef534e0..c1f6fcef904b 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -7169,7 +7169,7 @@ void rtw89_btc_ntfy_role_info(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif
 			      struct rtw89_sta *rtwsta, enum btc_role_state state)
 {
 	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev,
-						       rtwvif->sub_entity_idx);
+						       rtwvif->chanctx_idx);
 	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif);
 	struct ieee80211_sta *sta = rtwsta_to_sta(rtwsta);
 	struct rtw89_btc *btc = &rtwdev->btc;
diff --git a/drivers/net/wireless/realtek/rtw89/coex.h b/drivers/net/wireless/realtek/rtw89/coex.h
index 7678fb8bcf7e..72e3c77d2a3a 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.h
+++ b/drivers/net/wireless/realtek/rtw89/coex.h
@@ -293,7 +293,7 @@ static inline u8 rtw89_btc_phymap(struct rtw89_dev *rtwdev,
 				  enum rtw89_phy_idx phy_idx,
 				  enum rtw89_rf_path_bit paths)
 {
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
 	u8 phy_map;
 
 	phy_map = FIELD_PREP(BTC_RFK_PATH_MAP, paths) |
diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 7019f7d482a8..e9f453889006 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -346,8 +346,8 @@ void rtw89_core_set_chip_txpwr(struct rtw89_dev *rtwdev)
 	struct rtw89_hal *hal = &rtwdev->hal;
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 	const struct rtw89_chan *chan;
-	enum rtw89_sub_entity_idx sub_entity_idx;
-	enum rtw89_sub_entity_idx roc_idx;
+	enum rtw89_chanctx_idx chanctx_idx;
+	enum rtw89_chanctx_idx roc_idx;
 	enum rtw89_phy_idx phy_idx;
 	enum rtw89_entity_mode mode;
 	bool entity_active;
@@ -360,10 +360,10 @@ void rtw89_core_set_chip_txpwr(struct rtw89_dev *rtwdev)
 	switch (mode) {
 	case RTW89_ENTITY_MODE_SCC:
 	case RTW89_ENTITY_MODE_MCC:
-		sub_entity_idx = RTW89_SUB_ENTITY_0;
+		chanctx_idx = RTW89_CHANCTX_0;
 		break;
 	case RTW89_ENTITY_MODE_MCC_PREPARE:
-		sub_entity_idx = RTW89_SUB_ENTITY_1;
+		chanctx_idx = RTW89_CHANCTX_1;
 		break;
 	default:
 		WARN(1, "Invalid ent mode: %d\n", mode);
@@ -371,11 +371,11 @@ void rtw89_core_set_chip_txpwr(struct rtw89_dev *rtwdev)
 	}
 
 	roc_idx = atomic_read(&hal->roc_entity_idx);
-	if (roc_idx != RTW89_SUB_ENTITY_IDLE)
-		sub_entity_idx = roc_idx;
+	if (roc_idx != RTW89_CHANCTX_IDLE)
+		chanctx_idx = roc_idx;
 
 	phy_idx = RTW89_PHY_0;
-	chan = rtw89_chan_get(rtwdev, sub_entity_idx);
+	chan = rtw89_chan_get(rtwdev, chanctx_idx);
 	chip->ops->set_txpwr(rtwdev, chan, phy_idx);
 }
 
@@ -385,8 +385,8 @@ int rtw89_set_channel(struct rtw89_dev *rtwdev)
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 	const struct rtw89_chan_rcd *chan_rcd;
 	const struct rtw89_chan *chan;
-	enum rtw89_sub_entity_idx sub_entity_idx;
-	enum rtw89_sub_entity_idx roc_idx;
+	enum rtw89_chanctx_idx chanctx_idx;
+	enum rtw89_chanctx_idx roc_idx;
 	enum rtw89_mac_idx mac_idx;
 	enum rtw89_phy_idx phy_idx;
 	struct rtw89_channel_help_params bak;
@@ -399,10 +399,10 @@ int rtw89_set_channel(struct rtw89_dev *rtwdev)
 	switch (mode) {
 	case RTW89_ENTITY_MODE_SCC:
 	case RTW89_ENTITY_MODE_MCC:
-		sub_entity_idx = RTW89_SUB_ENTITY_0;
+		chanctx_idx = RTW89_CHANCTX_0;
 		break;
 	case RTW89_ENTITY_MODE_MCC_PREPARE:
-		sub_entity_idx = RTW89_SUB_ENTITY_1;
+		chanctx_idx = RTW89_CHANCTX_1;
 		break;
 	default:
 		WARN(1, "Invalid ent mode: %d\n", mode);
@@ -410,14 +410,14 @@ int rtw89_set_channel(struct rtw89_dev *rtwdev)
 	}
 
 	roc_idx = atomic_read(&hal->roc_entity_idx);
-	if (roc_idx != RTW89_SUB_ENTITY_IDLE)
-		sub_entity_idx = roc_idx;
+	if (roc_idx != RTW89_CHANCTX_IDLE)
+		chanctx_idx = roc_idx;
 
 	mac_idx = RTW89_MAC_0;
 	phy_idx = RTW89_PHY_0;
 
-	chan = rtw89_chan_get(rtwdev, sub_entity_idx);
-	chan_rcd = rtw89_chan_rcd_get(rtwdev, sub_entity_idx);
+	chan = rtw89_chan_get(rtwdev, chanctx_idx);
+	chan_rcd = rtw89_chan_rcd_get(rtwdev, chanctx_idx);
 
 	rtw89_chip_set_channel_prepare(rtwdev, &bak, chan, mac_idx, phy_idx);
 
@@ -441,7 +441,7 @@ void rtw89_get_channel(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
 {
 	const struct cfg80211_chan_def *chandef;
 
-	chandef = rtw89_chandef_get(rtwdev, rtwvif->sub_entity_idx);
+	chandef = rtw89_chandef_get(rtwdev, rtwvif->chanctx_idx);
 	rtw89_get_channel_params(chandef, chan);
 }
 
@@ -610,7 +610,7 @@ rtw89_core_tx_update_mgmt_info(struct rtw89_dev *rtwdev,
 	struct rtw89_vif *rtwvif = (struct rtw89_vif *)vif->drv_priv;
 	struct rtw89_tx_desc_info *desc_info = &tx_req->desc_info;
 	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev,
-						       rtwvif->sub_entity_idx);
+						       rtwvif->chanctx_idx);
 	u8 qsel, ch_dma;
 
 	qsel = desc_info->hiq ? RTW89_TX_QSEL_B0_HI : RTW89_TX_QSEL_B0_MGMT;
@@ -769,7 +769,7 @@ static u16 rtw89_core_get_data_rate(struct rtw89_dev *rtwdev,
 	struct ieee80211_sta *sta = tx_req->sta;
 	struct rtw89_vif *rtwvif = (struct rtw89_vif *)vif->drv_priv;
 	struct rtw89_phy_rate_pattern *rate_pattern = &rtwvif->rate_pattern;
-	enum rtw89_sub_entity_idx idx = rtwvif->sub_entity_idx;
+	enum rtw89_chanctx_idx idx = rtwvif->chanctx_idx;
 	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, idx);
 	u16 lowest_rate;
 
@@ -1959,7 +1959,7 @@ static void rtw89_correct_cck_chan(struct rtw89_dev *rtwdev,
 				   struct ieee80211_rx_status *status)
 {
 	const struct rtw89_chan_rcd *rcd =
-		rtw89_chan_rcd_get(rtwdev, RTW89_SUB_ENTITY_0);
+		rtw89_chan_rcd_get(rtwdev, RTW89_CHANCTX_0);
 	u16 chan = rcd->prev_primary_channel;
 	u8 band = rtw89_hw_to_nl80211_band(rcd->prev_band_type);
 
@@ -2363,7 +2363,7 @@ static void rtw89_core_update_rx_status(struct rtw89_dev *rtwdev,
 					struct ieee80211_rx_status *rx_status)
 {
 	const struct cfg80211_chan_def *chandef =
-		rtw89_chandef_get(rtwdev, RTW89_SUB_ENTITY_0);
+		rtw89_chandef_get(rtwdev, RTW89_CHANCTX_0);
 	u16 data_rate;
 	u8 data_rate_mode;
 	bool eht = false;
@@ -2856,7 +2856,7 @@ static void rtw89_core_sta_pending_tx_iter(void *data,
 	struct sk_buff *skb, *tmp;
 	int qsel, ret;
 
-	if (rtwvif->sub_entity_idx != rtwvif_target->sub_entity_idx)
+	if (rtwvif->chanctx_idx != rtwvif_target->chanctx_idx)
 		return;
 
 	if (skb_queue_len(&rtwsta->roc_queue) == 0)
@@ -2950,11 +2950,11 @@ void rtw89_roc_start(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
 			    "roc send null-1 failed: %d\n", ret);
 
 	rtw89_for_each_rtwvif(rtwdev, tmp)
-		if (tmp->sub_entity_idx == rtwvif->sub_entity_idx)
+		if (tmp->chanctx_idx == rtwvif->chanctx_idx)
 			tmp->offchan = true;
 
 	cfg80211_chandef_create(&roc_chan, &roc->chan, NL80211_CHAN_NO_HT);
-	rtw89_config_roc_chandef(rtwdev, rtwvif->sub_entity_idx, &roc_chan);
+	rtw89_config_roc_chandef(rtwdev, rtwvif->chanctx_idx, &roc_chan);
 	rtw89_set_channel(rtwdev);
 	rtw89_write32_clr(rtwdev,
 			  rtw89_mac_reg_by_idx(rtwdev, mac->rx_fltr, RTW89_MAC_0),
@@ -2987,7 +2987,7 @@ void rtw89_roc_end(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
 			   rtwdev->hal.rx_fltr);
 
 	roc->state = RTW89_ROC_IDLE;
-	rtw89_config_roc_chandef(rtwdev, rtwvif->sub_entity_idx, NULL);
+	rtw89_config_roc_chandef(rtwdev, rtwvif->chanctx_idx, NULL);
 	rtw89_chanctx_proceed(rtwdev);
 	ret = rtw89_core_send_nullfunc(rtwdev, rtwvif, true, false);
 	if (ret)
@@ -2995,7 +2995,7 @@ void rtw89_roc_end(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
 			    "roc send null-0 failed: %d\n", ret);
 
 	rtw89_for_each_rtwvif(rtwdev, tmp)
-		if (tmp->sub_entity_idx == rtwvif->sub_entity_idx)
+		if (tmp->chanctx_idx == rtwvif->chanctx_idx)
 			tmp->offchan = false;
 
 	rtw89_core_handle_sta_pending_tx(rtwdev, rtwvif);
@@ -3491,7 +3491,7 @@ int rtw89_core_sta_assoc(struct rtw89_dev *rtwdev,
 	struct rtw89_sta *rtwsta = (struct rtw89_sta *)sta->drv_priv;
 	struct rtw89_bssid_cam_entry *bssid_cam = rtw89_get_bssid_cam_of(rtwvif, rtwsta);
 	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev,
-						       rtwvif->sub_entity_idx);
+						       rtwvif->chanctx_idx);
 	int ret;
 
 	if (vif->type == NL80211_IFTYPE_AP || sta->tdls) {
@@ -4333,7 +4333,7 @@ void rtw89_core_scan_start(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
 			   const u8 *mac_addr, bool hw_scan)
 {
 	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev,
-						       rtwvif->sub_entity_idx);
+						       rtwvif->chanctx_idx);
 
 	rtwdev->scanning = true;
 	rtw89_leave_lps(rtwdev);
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 11fa003a9788..b3ede3c1fadf 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -820,12 +820,12 @@ enum rtw89_phy_idx {
 	RTW89_PHY_MAX
 };
 
-enum rtw89_sub_entity_idx {
-	RTW89_SUB_ENTITY_0 = 0,
-	RTW89_SUB_ENTITY_1 = 1,
+enum rtw89_chanctx_idx {
+	RTW89_CHANCTX_0 = 0,
+	RTW89_CHANCTX_1 = 1,
 
-	NUM_OF_RTW89_SUB_ENTITY,
-	RTW89_SUB_ENTITY_IDLE = NUM_OF_RTW89_SUB_ENTITY,
+	NUM_OF_RTW89_CHANCTX,
+	RTW89_CHANCTX_IDLE = NUM_OF_RTW89_CHANCTX,
 };
 
 enum rtw89_rf_path {
@@ -3403,7 +3403,7 @@ struct rtw89_vif {
 	struct rtw89_dev *rtwdev;
 	struct rtw89_roc roc;
 	bool chanctx_assigned; /* only valid when running with chanctx_ops */
-	enum rtw89_sub_entity_idx sub_entity_idx;
+	enum rtw89_chanctx_idx chanctx_idx;
 	enum rtw89_reg_6ghz_power reg_6ghz_power;
 	struct rtw89_reg_6ghz_tpe reg_6ghz_tpe;
 
@@ -4519,7 +4519,7 @@ struct rtw89_tas_info {
 };
 
 struct rtw89_chanctx_cfg {
-	enum rtw89_sub_entity_idx idx;
+	enum rtw89_chanctx_idx idx;
 	int ref_count;
 };
 
@@ -4544,7 +4544,7 @@ enum rtw89_entity_mode {
 	RTW89_ENTITY_MODE_UNHANDLED = -ESRCH,
 };
 
-struct rtw89_sub_entity {
+struct rtw89_chanctx {
 	struct cfg80211_chan_def chandef;
 	struct rtw89_chan chan;
 	struct rtw89_chan_rcd rcd;
@@ -4580,8 +4580,8 @@ struct rtw89_hal {
 	atomic_t roc_entity_idx;
 
 	DECLARE_BITMAP(changes, NUM_OF_RTW89_CHANCTX_CHANGES);
-	DECLARE_BITMAP(entity_map, NUM_OF_RTW89_SUB_ENTITY);
-	struct rtw89_sub_entity sub[NUM_OF_RTW89_SUB_ENTITY];
+	DECLARE_BITMAP(entity_map, NUM_OF_RTW89_CHANCTX);
+	struct rtw89_chanctx chanctx[NUM_OF_RTW89_CHANCTX];
 	struct cfg80211_chan_def roc_chandef;
 
 	bool entity_active;
@@ -6028,33 +6028,33 @@ void rtw89_chip_set_channel_done(struct rtw89_dev *rtwdev,
 
 static inline
 const struct cfg80211_chan_def *rtw89_chandef_get(struct rtw89_dev *rtwdev,
-						  enum rtw89_sub_entity_idx idx)
+						  enum rtw89_chanctx_idx idx)
 {
 	struct rtw89_hal *hal = &rtwdev->hal;
-	enum rtw89_sub_entity_idx roc_idx = atomic_read(&hal->roc_entity_idx);
+	enum rtw89_chanctx_idx roc_idx = atomic_read(&hal->roc_entity_idx);
 
 	if (roc_idx == idx)
 		return &hal->roc_chandef;
 
-	return &hal->sub[idx].chandef;
+	return &hal->chanctx[idx].chandef;
 }
 
 static inline
 const struct rtw89_chan *rtw89_chan_get(struct rtw89_dev *rtwdev,
-					enum rtw89_sub_entity_idx idx)
+					enum rtw89_chanctx_idx idx)
 {
 	struct rtw89_hal *hal = &rtwdev->hal;
 
-	return &hal->sub[idx].chan;
+	return &hal->chanctx[idx].chan;
 }
 
 static inline
 const struct rtw89_chan_rcd *rtw89_chan_rcd_get(struct rtw89_dev *rtwdev,
-						enum rtw89_sub_entity_idx idx)
+						enum rtw89_chanctx_idx idx)
 {
 	struct rtw89_hal *hal = &rtwdev->hal;
 
-	return &hal->sub[idx].rcd;
+	return &hal->chanctx[idx].rcd;
 }
 
 static inline
@@ -6064,9 +6064,9 @@ const struct rtw89_chan *rtw89_scan_chan_get(struct rtw89_dev *rtwdev)
 	struct rtw89_vif *rtwvif = vif_to_rtwvif_safe(vif);
 
 	if (rtwvif)
-		return rtw89_chan_get(rtwdev, rtwvif->sub_entity_idx);
+		return rtw89_chan_get(rtwdev, rtwvif->chanctx_idx);
 	else
-		return rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+		return rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
 }
 
 static inline void rtw89_chip_fem_setup(struct rtw89_dev *rtwdev)
diff --git a/drivers/net/wireless/realtek/rtw89/debug.c b/drivers/net/wireless/realtek/rtw89/debug.c
index 9e1353cce9cc..7c2c96dffd17 100644
--- a/drivers/net/wireless/realtek/rtw89/debug.c
+++ b/drivers/net/wireless/realtek/rtw89/debug.c
@@ -851,7 +851,7 @@ static int rtw89_debug_priv_txpwr_table_get(struct seq_file *m, void *v)
 
 	mutex_lock(&rtwdev->mutex);
 	rtw89_leave_ps_mode(rtwdev);
-	chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
 
 	rtw89_debug_priv_txpwr_table_get_regd(m, rtwdev, chan);
 
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 6ff7cd77a259..1db32418e912 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -2495,7 +2495,7 @@ int rtw89_fw_h2c_lps_parm(struct rtw89_dev *rtwdev,
 int rtw89_fw_h2c_lps_ch_info(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
 {
 	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev,
-						       rtwvif->sub_entity_idx);
+						       rtwvif->chanctx_idx);
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 	struct rtw89_h2c_lps_ch_info *h2c;
 	u32 len = sizeof(*h2c);
@@ -2814,7 +2814,7 @@ int rtw89_fw_h2c_assoc_cmac_tbl(struct rtw89_dev *rtwdev,
 	struct rtw89_sta *rtwsta = sta_to_rtwsta_safe(sta);
 	struct rtw89_vif *rtwvif = (struct rtw89_vif *)vif->drv_priv;
 	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev,
-						       rtwvif->sub_entity_idx);
+						       rtwvif->chanctx_idx);
 	struct sk_buff *skb;
 	u8 pads[RTW89_PPE_BW_NUM];
 	u8 mac_id = rtwsta ? rtwsta->mac_id : rtwvif->mac_id;
@@ -2947,7 +2947,7 @@ int rtw89_fw_h2c_assoc_cmac_tbl_g7(struct rtw89_dev *rtwdev,
 				   struct ieee80211_vif *vif,
 				   struct ieee80211_sta *sta)
 {
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
 	struct rtw89_vif *rtwvif = (struct rtw89_vif *)vif->drv_priv;
 	struct rtw89_sta *rtwsta = sta_to_rtwsta_safe(sta);
 	u8 mac_id = rtwsta ? rtwsta->mac_id : rtwvif->mac_id;
@@ -3210,7 +3210,7 @@ int rtw89_fw_h2c_update_beacon(struct rtw89_dev *rtwdev,
 			       struct rtw89_vif *rtwvif)
 {
 	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev,
-						       rtwvif->sub_entity_idx);
+						       rtwvif->chanctx_idx);
 	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif);
 	struct rtw89_h2c_bcn_upd *h2c;
 	struct sk_buff *skb_beacon;
@@ -3289,7 +3289,7 @@ EXPORT_SYMBOL(rtw89_fw_h2c_update_beacon);
 int rtw89_fw_h2c_update_beacon_be(struct rtw89_dev *rtwdev,
 				  struct rtw89_vif *rtwvif)
 {
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
 	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif);
 	struct rtw89_h2c_bcn_upd_be *h2c;
 	struct sk_buff *skb_beacon;
@@ -5209,7 +5209,7 @@ int rtw89_fw_h2c_rf_tssi(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx,
 			 enum rtw89_tssi_mode tssi_mode)
 {
 	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev,
-						       RTW89_SUB_ENTITY_0);
+						       RTW89_CHANCTX_0);
 	struct rtw89_hal *hal = &rtwdev->hal;
 	struct rtw89_h2c_rf_tssi *h2c;
 	u32 len = sizeof(*h2c);
@@ -5291,7 +5291,7 @@ int rtw89_fw_h2c_rf_iqk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
 int rtw89_fw_h2c_rf_dpk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
 {
 	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev,
-						       RTW89_SUB_ENTITY_0);
+						       RTW89_CHANCTX_0);
 	struct rtw89_h2c_rf_dpk *h2c;
 	u32 len = sizeof(*h2c);
 	struct sk_buff *skb;
@@ -5334,7 +5334,7 @@ int rtw89_fw_h2c_rf_dpk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
 int rtw89_fw_h2c_rf_txgapk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
 {
 	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev,
-						       RTW89_SUB_ENTITY_0);
+						       RTW89_CHANCTX_0);
 	struct rtw89_hal *hal = &rtwdev->hal;
 	struct rtw89_h2c_rf_txgapk *h2c;
 	u32 len = sizeof(*h2c);
@@ -5414,7 +5414,7 @@ int rtw89_fw_h2c_rf_dack(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
 int rtw89_fw_h2c_rf_rxdck(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
 {
 	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev,
-						       RTW89_SUB_ENTITY_0);
+						       RTW89_CHANCTX_0);
 	struct rtw89_h2c_rf_rxdck *h2c;
 	u32 len = sizeof(*h2c);
 	struct sk_buff *skb;
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index b479434e6301..7f2ca16bedcc 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -4781,14 +4781,14 @@ rtw89_mac_c2h_scanofld_rsp(struct rtw89_dev *rtwdev, struct sk_buff *skb,
 	case RTW89_SCAN_ENTER_OP_NOTIFY:
 	case RTW89_SCAN_ENTER_CH_NOTIFY:
 		if (rtw89_is_op_chan(rtwdev, band, chan)) {
-			rtw89_assign_entity_chan(rtwdev, rtwvif->sub_entity_idx,
+			rtw89_assign_entity_chan(rtwdev, rtwvif->chanctx_idx,
 						 &rtwdev->scan_info.op_chan);
 			rtw89_mac_enable_beacon_for_ap_vifs(rtwdev, true);
 			ieee80211_wake_queues(rtwdev->hw);
 		} else {
 			rtw89_chan_create(&new, chan, chan, band,
 					  RTW89_CHANNEL_WIDTH_20);
-			rtw89_assign_entity_chan(rtwdev, rtwvif->sub_entity_idx,
+			rtw89_assign_entity_chan(rtwdev, rtwvif->chanctx_idx,
 						 &new);
 		}
 		break;
diff --git a/drivers/net/wireless/realtek/rtw89/mac80211.c b/drivers/net/wireless/realtek/rtw89/mac80211.c
index 1508693032cb..9a0f74b92ea4 100644
--- a/drivers/net/wireless/realtek/rtw89/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw89/mac80211.c
@@ -90,7 +90,7 @@ static int rtw89_ops_config(struct ieee80211_hw *hw, u32 changed)
 		rtw89_leave_ips(rtwdev);
 
 	if (changed & IEEE80211_CONF_CHANGE_CHANNEL) {
-		rtw89_config_entity_chandef(rtwdev, RTW89_SUB_ENTITY_0,
+		rtw89_config_entity_chandef(rtwdev, RTW89_CHANCTX_0,
 					    &hw->conf.chandef);
 		rtw89_set_channel(rtwdev);
 	}
@@ -144,7 +144,7 @@ static int rtw89_ops_add_interface(struct ieee80211_hw *hw,
 	rtwvif->bcn_hit_cond = 0;
 	rtwvif->mac_idx = RTW89_MAC_0;
 	rtwvif->phy_idx = RTW89_PHY_0;
-	rtwvif->sub_entity_idx = RTW89_SUB_ENTITY_0;
+	rtwvif->chanctx_idx = RTW89_CHANCTX_0;
 	rtwvif->chanctx_assigned = false;
 	rtwvif->hit_rule = 0;
 	rtwvif->reg_6ghz_power = RTW89_REG_6GHZ_POWER_DFLT;
@@ -313,7 +313,7 @@ static u8 rtw89_aifsn_to_aifs(struct rtw89_dev *rtwdev,
 {
 	struct ieee80211_vif *vif = rtwvif_to_vif(rtwvif);
 	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev,
-						       rtwvif->sub_entity_idx);
+						       rtwvif->chanctx_idx);
 	u8 slot_time;
 	u8 sifs;
 
@@ -503,7 +503,7 @@ static int rtw89_ops_start_ap(struct ieee80211_hw *hw,
 
 	mutex_lock(&rtwdev->mutex);
 
-	chan = rtw89_chan_get(rtwdev, rtwvif->sub_entity_idx);
+	chan = rtw89_chan_get(rtwdev, rtwvif->chanctx_idx);
 	if (chan->band_type == RTW89_BAND_6G) {
 		mutex_unlock(&rtwdev->mutex);
 		return -EOPNOTSUPP;
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index ad11d1414874..aa20b3e9d3c6 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -302,7 +302,7 @@ static void rtw89_phy_ra_sta_update(struct rtw89_dev *rtwdev,
 	struct rtw89_phy_rate_pattern *rate_pattern = &rtwvif->rate_pattern;
 	struct rtw89_ra_info *ra = &rtwsta->ra;
 	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev,
-						       rtwvif->sub_entity_idx);
+						       rtwvif->chanctx_idx);
 	struct ieee80211_vif *vif = rtwvif_to_vif(rtwsta->rtwvif);
 	const u64 *high_rate_masks = rtw89_ra_mask_ht_rates;
 	u8 rssi = ewma_rssi_read(&rtwsta->avg_rssi);
@@ -528,7 +528,7 @@ void rtw89_phy_rate_pattern_vif(struct rtw89_dev *rtwdev,
 	struct rtw89_vif *rtwvif = (struct rtw89_vif *)vif->drv_priv;
 	struct rtw89_phy_rate_pattern next_pattern = {0};
 	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev,
-						       rtwvif->sub_entity_idx);
+						       rtwvif->chanctx_idx);
 	static const u16 hw_rate_he[][RTW89_CHIP_GEN_NUM] = {
 		RTW89_HW_RATE_BY_CHIP_GEN(HE_NSS1_MCS0),
 		RTW89_HW_RATE_BY_CHIP_GEN(HE_NSS2_MCS0),
@@ -4285,7 +4285,7 @@ void rtw89_phy_ul_tb_assoc(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
 {
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev,
-						       rtwvif->sub_entity_idx);
+						       rtwvif->chanctx_idx);
 	struct rtw89_phy_ul_tb_info *ul_tb_info = &rtwdev->ul_tb_info;
 
 	if (!chip->ul_tb_waveform_ctrl)
@@ -5367,7 +5367,7 @@ static void rtw89_phy_dig_update_rssi_info(struct rtw89_dev *rtwdev)
 static void rtw89_phy_dig_update_para(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_dig_info *dig = &rtwdev->dig;
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
 	bool is_linked = rtwdev->total_sta_assoc > 0;
 	const u16 *fa_th_src = NULL;
 
@@ -5611,7 +5611,7 @@ static void rtw89_phy_dig_config_igi(struct rtw89_dev *rtwdev)
 static void rtw89_phy_dig_dyn_pd_th(struct rtw89_dev *rtwdev, u8 rssi,
 				    bool enable)
 {
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
 	const struct rtw89_dig_regs *dig_regs = rtwdev->chip->dig_regs;
 	enum rtw89_bandwidth cbw = chan->band_width;
 	struct rtw89_dig_info *dig = &rtwdev->dig;
diff --git a/drivers/net/wireless/realtek/rtw89/regd.c b/drivers/net/wireless/realtek/rtw89/regd.c
index a251b0e3b16e..a7720a1f17a7 100644
--- a/drivers/net/wireless/realtek/rtw89/regd.c
+++ b/drivers/net/wireless/realtek/rtw89/regd.c
@@ -800,7 +800,7 @@ static bool __rtw89_reg_6ghz_tpe_recalc(struct rtw89_dev *rtwdev)
 		const struct rtw89_reg_6ghz_tpe *tmp;
 		const struct rtw89_chan *chan;
 
-		chan = rtw89_chan_get(rtwdev, rtwvif->sub_entity_idx);
+		chan = rtw89_chan_get(rtwdev, rtwvif->chanctx_idx);
 		if (chan->band_type != RTW89_BAND_6G)
 			continue;
 
@@ -872,7 +872,7 @@ static bool __rtw89_reg_6ghz_power_recalc(struct rtw89_dev *rtwdev)
 	u8 index;
 
 	rtw89_for_each_rtwvif(rtwdev, rtwvif) {
-		chan = rtw89_chan_get(rtwdev, rtwvif->sub_entity_idx);
+		chan = rtw89_chan_get(rtwdev, rtwvif->chanctx_idx);
 		if (chan->band_type != RTW89_BAND_6G)
 			continue;
 
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b.c b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
index 40cf84a79c46..25370ebe177b 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
@@ -1801,7 +1801,7 @@ rtw8851b_init_txpwr_unit(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
 static void rtw8851b_ctrl_nbtg_bt_tx(struct rtw89_dev *rtwdev, bool en,
 				     enum rtw89_phy_idx phy_idx)
 {
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
 
 	rtw89_phy_write_reg3_tbl(rtwdev, en ? &rtw8851b_btc_preagc_en_defs_tbl :
 						 &rtw8851b_btc_preagc_dis_defs_tbl);
@@ -1824,7 +1824,7 @@ static void rtw8851b_ctrl_nbtg_bt_tx(struct rtw89_dev *rtwdev, bool en,
 static void rtw8851b_ctrl_btg_bt_rx(struct rtw89_dev *rtwdev, bool en,
 				    enum rtw89_phy_idx phy_idx)
 {
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
 
 	if (en) {
 		rtw89_phy_write32_mask(rtwdev, R_PATH0_BT_SHARE_V1,
@@ -1869,7 +1869,7 @@ static void rtw8851b_ctrl_btg_bt_rx(struct rtw89_dev *rtwdev, bool en,
 static void rtw8851b_bb_ctrl_rx_path(struct rtw89_dev *rtwdev,
 				     enum rtw89_rf_path_bit rx_path)
 {
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
 	u32 rst_mask0;
 
 	if (rx_path == RF_A) {
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.c b/drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.c
index a221f94627f5..1312e299e1aa 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.c
@@ -523,7 +523,7 @@ static void _dac_cal(struct rtw89_dev *rtwdev, bool force)
 static void _rx_dck_info(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 			 enum rtw89_rf_path path, bool is_afe)
 {
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
 
 	rtw89_debug(rtwdev, RTW89_DBG_RFK,
 		    "[RX_DCK] ==== S%d RX DCK (%s / CH%d / %s / by %s)====\n", path,
@@ -1483,7 +1483,7 @@ static void _rfk_restore_rf_reg(struct rtw89_dev *rtwdev,
 static void _iqk_get_ch_info(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 			     u8 path)
 {
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
 	struct rtw89_iqk_info *iqk_info = &rtwdev->iqk;
 	u8 idx = 0;
 
@@ -1748,7 +1748,7 @@ static void _dpk_init(struct rtw89_dev *rtwdev, enum rtw89_rf_path path)
 static void _dpk_information(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 			     enum rtw89_rf_path path)
 {
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
 	struct rtw89_dpk_info *dpk = &rtwdev->dpk;
 
 	u8 kidx = dpk->cur_idx[path];
@@ -2619,7 +2619,7 @@ static void _rck(struct rtw89_dev *rtwdev, enum rtw89_rf_path path)
 static void _tssi_set_sys(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 			  enum rtw89_rf_path path)
 {
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
 	enum rtw89_band band = chan->band_type;
 
 	rtw89_rfk_parser(rtwdev, &rtw8851b_tssi_sys_defs_tbl);
@@ -2664,7 +2664,7 @@ static void _tssi_set_tmeter_tbl(struct rtw89_dev *rtwdev, enum rtw89_phy_idx ph
 	__val;						\
 })
 	struct rtw89_tssi_info *tssi_info = &rtwdev->tssi;
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
 	u8 ch = chan->channel;
 	u8 subband = chan->subband_type;
 	const s8 *thm_up_a = NULL;
@@ -2757,7 +2757,7 @@ static void _tssi_set_dac_gain_tbl(struct rtw89_dev *rtwdev, enum rtw89_phy_idx
 static void _tssi_slope_cal_org(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 				enum rtw89_rf_path path)
 {
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
 	enum rtw89_band band = chan->band_type;
 
 	rtw89_rfk_parser_by_cond(rtwdev, band == RTW89_BAND_2G,
@@ -2768,7 +2768,7 @@ static void _tssi_slope_cal_org(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy
 static void _tssi_alignment_default(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 				    enum rtw89_rf_path path, bool all)
 {
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
 	enum rtw89_band band = chan->band_type;
 
 	rtw89_rfk_parser_by_cond(rtwdev, band == RTW89_BAND_2G,
@@ -2947,7 +2947,7 @@ static s8 _tssi_get_ofdm_de(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 			    enum rtw89_rf_path path)
 {
 	struct rtw89_tssi_info *tssi_info = &rtwdev->tssi;
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
 	u32 gidx, gidx_1st, gidx_2nd;
 	u8 ch = chan->channel;
 	s8 de_1st;
@@ -2983,7 +2983,7 @@ static s8 _tssi_get_ofdm_trim_de(struct rtw89_dev *rtwdev, enum rtw89_phy_idx ph
 				 enum rtw89_rf_path path)
 {
 	struct rtw89_tssi_info *tssi_info = &rtwdev->tssi;
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
 	u32 tgidx, tgidx_1st, tgidx_2nd;
 	u8 ch = chan->channel;
 	s8 tde_1st;
@@ -3020,7 +3020,7 @@ static s8 _tssi_get_ofdm_trim_de(struct rtw89_dev *rtwdev, enum rtw89_phy_idx ph
 static void _tssi_set_efuse_to_de(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy)
 {
 	struct rtw89_tssi_info *tssi_info = &rtwdev->tssi;
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
 	u8 ch = chan->channel;
 	u8 gidx;
 	s8 ofdm_de;
@@ -3099,7 +3099,7 @@ static void _tssi_alimentk_done(struct rtw89_dev *rtwdev,
 				enum rtw89_phy_idx phy, enum rtw89_rf_path path)
 {
 	struct rtw89_tssi_info *tssi_info = &rtwdev->tssi;
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
 	u8 channel = chan->channel;
 	u8 band;
 
@@ -3338,7 +3338,7 @@ void rtw8851b_tssi(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy, bool hwtx_e
 
 void rtw8851b_tssi_scan(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy)
 {
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
 	u8 channel = chan->channel;
 	u32 i;
 
@@ -3361,7 +3361,7 @@ void rtw8851b_tssi_scan(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy)
 static void rtw8851b_tssi_default_txagc(struct rtw89_dev *rtwdev,
 					enum rtw89_phy_idx phy, bool enable)
 {
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
 	u8 channel = chan->channel;
 
 	rtw89_debug(rtwdev, RTW89_DBG_RFK, "======> %s   ch=%d\n",
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index 08e148328c62..365973bb1673 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -1536,7 +1536,7 @@ void rtw8852a_bb_set_pmac_tx(struct rtw89_dev *rtwdev,
 			     struct rtw8852a_bb_pmac_info *tx_info,
 			     enum rtw89_phy_idx idx)
 {
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
 
 	if (!tx_info->en_pmac_tx) {
 		rtw8852a_stop_pmac_tx(rtwdev, tx_info, idx);
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.c b/drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.c
index d86429e4a35f..b059f6ff6e8f 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.c
@@ -1356,7 +1356,7 @@ static void _iqk_get_ch_info(struct rtw89_dev *rtwdev,
 			     enum rtw89_phy_idx phy, u8 path)
 {
 	struct rtw89_iqk_info *iqk_info = &rtwdev->iqk;
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
 	u32 reg_rf18 = 0x0, reg_35c = 0x0;
 	u8 idx = 0;
 	u8 get_empty_table = false;
@@ -1852,7 +1852,7 @@ static void _dpk_information(struct rtw89_dev *rtwdev,
 			     enum rtw89_rf_path path)
 {
 	struct rtw89_dpk_info *dpk = &rtwdev->dpk;
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
 	u8 kidx = dpk->cur_idx[path];
 
 	dpk->bp[path][kidx].band = chan->band_type;
@@ -2330,7 +2330,7 @@ static u8 _dpk_agc(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 #define DPK_RXBB_UPPER 0x1f
 #define DPK_RXBB_LOWER 0
 #define DPK_GL_CRIT 7
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
 	u8 tmp_txagc, tmp_rxbb = 0, tmp_gl_idx = 0;
 	u8 agc_cnt = 0;
 	bool limited_rxbb = false;
@@ -2521,7 +2521,7 @@ static bool _dpk_reload_check(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 			      enum rtw89_rf_path path)
 {
 	struct rtw89_dpk_info *dpk = &rtwdev->dpk;
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
 	bool is_reload = false;
 	u8 idx, cur_band, cur_ch;
 
@@ -2655,7 +2655,7 @@ static void _dpk_cal_select(struct rtw89_dev *rtwdev, bool force,
 static bool _dpk_bypass_check(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy)
 {
 	struct rtw89_fem_info *fem = &rtwdev->fem;
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
 
 	if (fem->epa_2g && chan->band_type == RTW89_BAND_2G) {
 		rtw89_debug(rtwdev, RTW89_DBG_RFK,
@@ -2817,7 +2817,7 @@ static void _dpk_track(struct rtw89_dev *rtwdev)
 static void _tssi_rf_setting(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 			     enum rtw89_rf_path path)
 {
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
 	enum rtw89_band band = chan->band_type;
 
 	if (band == RTW89_BAND_2G)
@@ -2828,7 +2828,7 @@ static void _tssi_rf_setting(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 
 static void _tssi_set_sys(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy)
 {
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
 	enum rtw89_band band = chan->band_type;
 
 	rtw89_rfk_parser(rtwdev, &rtw8852a_tssi_sys_defs_tbl);
@@ -2840,7 +2840,7 @@ static void _tssi_set_sys(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy)
 static void _tssi_ini_txpwr_ctrl_bb(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 				    enum rtw89_rf_path path)
 {
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
 	enum rtw89_band band = chan->band_type;
 
 	rtw89_rfk_parser_by_cond(rtwdev, path == RF_PATH_A,
@@ -2883,7 +2883,7 @@ static void _tssi_set_tmeter_tbl(struct rtw89_dev *rtwdev, enum rtw89_phy_idx ph
 	__val;						\
 })
 	struct rtw89_tssi_info *tssi_info = &rtwdev->tssi;
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
 	u8 ch = chan->channel;
 	u8 subband = chan->subband_type;
 	const s8 *thm_up_a = NULL;
@@ -3078,7 +3078,7 @@ static void _tssi_set_txagc_offset_mv_avg(struct rtw89_dev *rtwdev,
 static void _tssi_pak(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 		      enum rtw89_rf_path path)
 {
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
 	u8 subband = chan->subband_type;
 
 	switch (subband) {
@@ -3255,7 +3255,7 @@ static s8 _tssi_get_ofdm_de(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 			    enum rtw89_rf_path path)
 {
 	struct rtw89_tssi_info *tssi_info = &rtwdev->tssi;
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
 	u8 ch = chan->channel;
 	u32 gidx, gidx_1st, gidx_2nd;
 	s8 de_1st = 0;
@@ -3293,7 +3293,7 @@ static s8 _tssi_get_ofdm_trim_de(struct rtw89_dev *rtwdev,
 				 enum rtw89_rf_path path)
 {
 	struct rtw89_tssi_info *tssi_info = &rtwdev->tssi;
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
 	u8 ch = chan->channel;
 	u32 tgidx, tgidx_1st, tgidx_2nd;
 	s8 tde_1st = 0;
@@ -3332,7 +3332,7 @@ static void _tssi_set_efuse_to_de(struct rtw89_dev *rtwdev,
 {
 #define __DE_MASK 0x003ff000
 	struct rtw89_tssi_info *tssi_info = &rtwdev->tssi;
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
 	static const u32 r_cck_long[RF_PATH_NUM_8852A] = {0x5858, 0x7858};
 	static const u32 r_cck_short[RF_PATH_NUM_8852A] = {0x5860, 0x7860};
 	static const u32 r_mcs_20m[RF_PATH_NUM_8852A] = {0x5838, 0x7838};
@@ -3461,7 +3461,7 @@ static void _tssi_track(struct rtw89_dev *rtwdev)
 static void _tssi_high_power(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy)
 {
 	struct rtw89_tssi_info *tssi_info = &rtwdev->tssi;
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
 	u8 ch = chan->channel, ch_tmp;
 	u8 bw = chan->band_width;
 	u8 band = chan->band_type;
@@ -3508,7 +3508,7 @@ static void _tssi_hw_tx(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 static void _tssi_pre_tx(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy)
 {
 	struct rtw89_tssi_info *tssi_info = &rtwdev->tssi;
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
 	const struct rtw89_chip_info *mac_reg = rtwdev->chip;
 	u8 ch = chan->channel, ch_tmp;
 	u8 bw = chan->band_width;
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b_common.c b/drivers/net/wireless/realtek/rtw89/rtw8852b_common.c
index 1745c2882acf..f364e76e2b34 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b_common.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b_common.c
@@ -1447,7 +1447,7 @@ void rtw8852bx_bb_set_pmac_tx(struct rtw89_dev *rtwdev,
 			      struct rtw8852bx_bb_pmac_info *tx_info,
 			      enum rtw89_phy_idx idx)
 {
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
 
 	if (!tx_info->en_pmac_tx) {
 		rtw8852bx_stop_pmac_tx(rtwdev, tx_info, idx);
@@ -1625,7 +1625,7 @@ static
 void __rtw8852bx_bb_ctrl_rx_path(struct rtw89_dev *rtwdev,
 				 enum rtw89_rf_path_bit rx_path)
 {
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
 	u32 rst_mask0;
 	u32 rst_mask1;
 
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c b/drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c
index 12354612441c..72072042aca6 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c
@@ -1384,7 +1384,7 @@ static void _iqk_by_path(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx, u
 
 static void _iqk_get_ch_info(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy, u8 path)
 {
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
 	struct rtw89_iqk_info *iqk_info = &rtwdev->iqk;
 	u32 reg_rf18;
 	u32 reg_35c;
@@ -1763,7 +1763,7 @@ static void _dpk_rx_dck(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 static void _dpk_information(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 			     enum rtw89_rf_path path)
 {
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
 	struct rtw89_dpk_info *dpk = &rtwdev->dpk;
 
 	u8 kidx = dpk->cur_idx[path];
@@ -1788,7 +1788,7 @@ static void _dpk_bb_afe_setting(struct rtw89_dev *rtwdev,
 				enum rtw89_phy_idx phy,
 				enum rtw89_rf_path path, u8 kpath)
 {
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
 
 	rtw89_rfk_parser(rtwdev, &rtw8852b_dpk_afe_defs_tbl);
 
@@ -1805,7 +1805,7 @@ static void _dpk_bb_afe_restore(struct rtw89_dev *rtwdev,
 				enum rtw89_phy_idx phy,
 				enum rtw89_rf_path path, u8 kpath)
 {
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
 
 	rtw89_rfk_parser(rtwdev, &rtw8852b_dpk_afe_restore_defs_tbl);
 
@@ -2219,7 +2219,7 @@ static u8 _dpk_agc(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 		   enum rtw89_rf_path path, u8 kidx, u8 init_txagc,
 		   bool loss_only)
 {
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
 	u8 step = DPK_AGC_STEP_SYNC_DGAIN;
 	u8 tmp_txagc, tmp_rxbb = 0, tmp_gl_idx = 0;
 	u8 goout = 0, agc_cnt = 0, limited_rxbb = 0;
@@ -2418,7 +2418,7 @@ static void _dpk_fill_result(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 static bool _dpk_reload_check(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 			      enum rtw89_rf_path path)
 {
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
 	struct rtw89_dpk_info *dpk = &rtwdev->dpk;
 	bool is_reload = false;
 	u8 idx, cur_band, cur_ch;
@@ -2545,7 +2545,7 @@ static void _dpk_cal_select(struct rtw89_dev *rtwdev, bool force,
 
 static bool _dpk_bypass_check(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy)
 {
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
 	struct rtw89_fem_info *fem = &rtwdev->fem;
 
 	if (fem->epa_2g && chan->band_type == RTW89_BAND_2G) {
@@ -2724,7 +2724,7 @@ static void _set_dpd_backoff(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy)
 static void _tssi_rf_setting(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 			     enum rtw89_rf_path path)
 {
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
 	enum rtw89_band band = chan->band_type;
 
 	if (band == RTW89_BAND_2G)
@@ -2736,7 +2736,7 @@ static void _tssi_rf_setting(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 static void _tssi_set_sys(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 			  enum rtw89_rf_path path)
 {
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
 	enum rtw89_band band = chan->band_type;
 
 	rtw89_rfk_parser(rtwdev, &rtw8852b_tssi_sys_defs_tbl);
@@ -2792,7 +2792,7 @@ static void _tssi_set_tmeter_tbl(struct rtw89_dev *rtwdev, enum rtw89_phy_idx ph
 	__val;						\
 })
 	struct rtw89_tssi_info *tssi_info = &rtwdev->tssi;
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
 	u8 ch = chan->channel;
 	u8 subband = chan->subband_type;
 	const s8 *thm_up_a = NULL;
@@ -2946,7 +2946,7 @@ static void _tssi_set_dac_gain_tbl(struct rtw89_dev *rtwdev, enum rtw89_phy_idx
 static void _tssi_slope_cal_org(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 				enum rtw89_rf_path path)
 {
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
 	enum rtw89_band band = chan->band_type;
 
 	if (path == RF_PATH_A)
@@ -2962,7 +2962,7 @@ static void _tssi_slope_cal_org(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy
 static void _tssi_alignment_default(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 				    enum rtw89_rf_path path, bool all)
 {
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
 	enum rtw89_band band = chan->band_type;
 	const struct rtw89_rfk_tbl *tbl = NULL;
 	u8 ch = chan->channel;
@@ -3234,7 +3234,7 @@ static s8 _tssi_get_ofdm_de(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 			    enum rtw89_rf_path path)
 {
 	struct rtw89_tssi_info *tssi_info = &rtwdev->tssi;
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
 	u8 ch = chan->channel;
 	u32 gidx, gidx_1st, gidx_2nd;
 	s8 de_1st;
@@ -3270,7 +3270,7 @@ static s8 _tssi_get_ofdm_trim_de(struct rtw89_dev *rtwdev, enum rtw89_phy_idx ph
 				 enum rtw89_rf_path path)
 {
 	struct rtw89_tssi_info *tssi_info = &rtwdev->tssi;
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
 	u8 ch = chan->channel;
 	u32 tgidx, tgidx_1st, tgidx_2nd;
 	s8 tde_1st;
@@ -3307,7 +3307,7 @@ static s8 _tssi_get_ofdm_trim_de(struct rtw89_dev *rtwdev, enum rtw89_phy_idx ph
 static void _tssi_set_efuse_to_de(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy)
 {
 	struct rtw89_tssi_info *tssi_info = &rtwdev->tssi;
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
 	u8 ch = chan->channel;
 	u8 gidx;
 	s8 ofdm_de;
@@ -3386,7 +3386,7 @@ static void _tssi_alimentk_done(struct rtw89_dev *rtwdev,
 				enum rtw89_phy_idx phy, enum rtw89_rf_path path)
 {
 	struct rtw89_tssi_info *tssi_info = &rtwdev->tssi;
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
 	u8 channel = chan->channel;
 	u8 band;
 
@@ -3574,7 +3574,7 @@ static void _tssi_alimentk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 	static const s16 power_2g[4] = {48, 20, 4, 4};
 	static const s16 power_5g[4] = {48, 20, 4, 4};
 	struct rtw89_tssi_info *tssi_info = &rtwdev->tssi;
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
 	s32 tssi_alim_offset_1, tssi_alim_offset_2, tssi_alim_offset_3;
 	u32 tssi_cw_rpt[RTW8852B_TSSI_PATH_NR] = {0};
 	u8 channel = chan->channel;
@@ -3856,7 +3856,7 @@ void rtw8852b_tssi(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy, bool hwtx_e
 
 void rtw8852b_tssi_scan(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy)
 {
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
 	struct rtw89_tssi_info *tssi_info = &rtwdev->tssi;
 	u8 channel = chan->channel;
 	u8 band;
@@ -3896,7 +3896,7 @@ void rtw8852b_tssi_scan(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy)
 static void rtw8852b_tssi_default_txagc(struct rtw89_dev *rtwdev,
 					enum rtw89_phy_idx phy, bool enable)
 {
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
 	u8 channel = chan->channel;
 
 	rtw89_debug(rtwdev, RTW89_DBG_RFK, "======> %s   ch=%d\n",
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.c b/drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.c
index e90a036db667..56ca3fea8459 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.c
@@ -1527,7 +1527,7 @@ static void _iqk_by_path(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx, u
 
 static void _iqk_get_ch_info(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy, u8 path)
 {
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
 	struct rtw89_iqk_info *iqk_info = &rtwdev->iqk;
 	u8 get_empty_table = false;
 	u32 reg_rf18;
@@ -1881,7 +1881,7 @@ static void _dpk_rx_dck(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 static void _dpk_information(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 			     enum rtw89_rf_path path)
 {
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
 	struct rtw89_dpk_info *dpk = &rtwdev->dpk;
 
 	u8 kidx = dpk->cur_idx[path];
@@ -2279,7 +2279,7 @@ static u8 _dpk_agc(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 		   enum rtw89_rf_path path, u8 kidx, u8 init_txagc,
 		   bool loss_only)
 {
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
 	struct rtw89_dpk_info *dpk = &rtwdev->dpk;
 	u8 goout = 0, agc_cnt = 0, limited_rxbb = 0, gl_cnt = 0;
 	u8 tmp_txagc, tmp_rxbb, tmp_gl_idx = 0;
@@ -2506,7 +2506,7 @@ static void _dpk_fill_result(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 static bool _dpk_reload_check(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 			      enum rtw89_rf_path path)
 {
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
 	struct rtw89_dpk_info *dpk = &rtwdev->dpk;
 	u8 idx, cur_band, cur_ch;
 	bool is_reload = false;
@@ -2648,7 +2648,7 @@ static void _dpk_cal_select(struct rtw89_dev *rtwdev,
 
 static bool _dpk_bypass_check(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy)
 {
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
 	struct rtw89_fem_info *fem = &rtwdev->fem;
 
 	if (fem->epa_2g && chan->band_type == RTW89_BAND_2G) {
@@ -2819,7 +2819,7 @@ static void _tssi_dpk_off(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy)
 static void _tssi_rf_setting(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 			     enum rtw89_rf_path path)
 {
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
 	enum rtw89_band band = chan->band_type;
 
 	if (band == RTW89_BAND_2G)
@@ -2831,7 +2831,7 @@ static void _tssi_rf_setting(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 static void _tssi_set_sys(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 			  enum rtw89_rf_path path)
 {
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
 	enum rtw89_band band = chan->band_type;
 
 	rtw89_rfk_parser(rtwdev, &rtw8852bt_tssi_sys_defs_tbl);
@@ -2893,7 +2893,7 @@ static void _tssi_set_tmeter_tbl(struct rtw89_dev *rtwdev, enum rtw89_phy_idx ph
 })
 	struct rtw89_fw_txpwr_track_cfg *trk = rtwdev->fw.elm_info.txpwr_trk;
 	struct rtw89_tssi_info *tssi_info = &rtwdev->tssi;
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
 	u8 ch = chan->channel;
 	u8 subband = chan->subband_type;
 	const s8 *thm_up_a = NULL;
@@ -3049,7 +3049,7 @@ static void _tssi_set_dac_gain_tbl(struct rtw89_dev *rtwdev, enum rtw89_phy_idx
 static void _tssi_slope_cal_org(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 				enum rtw89_rf_path path)
 {
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
 	enum rtw89_band band = chan->band_type;
 
 	if (path == RF_PATH_A)
@@ -3065,7 +3065,7 @@ static void _tssi_slope_cal_org(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy
 static void _tssi_alignment_default(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 				    enum rtw89_rf_path path, bool all)
 {
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
 	enum rtw89_band band = chan->band_type;
 	const struct rtw89_rfk_tbl *tbl = NULL;
 	u8 ch = chan->channel;
@@ -3313,7 +3313,7 @@ static s8 _tssi_get_ofdm_de(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 			    enum rtw89_rf_path path)
 {
 	struct rtw89_tssi_info *tssi_info = &rtwdev->tssi;
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
 	u8 ch = chan->channel;
 	u32 gidx, gidx_1st, gidx_2nd;
 	s8 de_1st;
@@ -3349,7 +3349,7 @@ static s8 _tssi_get_ofdm_trim_de(struct rtw89_dev *rtwdev, enum rtw89_phy_idx ph
 				 enum rtw89_rf_path path)
 {
 	struct rtw89_tssi_info *tssi_info = &rtwdev->tssi;
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
 	u8 ch = chan->channel;
 	u32 tgidx, tgidx_1st, tgidx_2nd;
 	s8 tde_1st;
@@ -3386,7 +3386,7 @@ static s8 _tssi_get_ofdm_trim_de(struct rtw89_dev *rtwdev, enum rtw89_phy_idx ph
 static void _tssi_set_efuse_to_de(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy)
 {
 	struct rtw89_tssi_info *tssi_info = &rtwdev->tssi;
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
 	u8 ch = chan->channel;
 	u8 gidx;
 	s8 ofdm_de;
@@ -3466,7 +3466,7 @@ static void _tssi_alimentk_done(struct rtw89_dev *rtwdev,
 				enum rtw89_phy_idx phy, enum rtw89_rf_path path)
 {
 	struct rtw89_tssi_info *tssi_info = &rtwdev->tssi;
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
 	u8 channel = chan->channel;
 	u8 band;
 
@@ -3655,7 +3655,7 @@ static void _tssi_alimentk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 	static const s16 power_2g[4] = {48, 20, 4, -8};
 	static const s16 power_5g[4] = {48, 20, 4, 4};
 	struct rtw89_tssi_info *tssi_info = &rtwdev->tssi;
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
 	s32 tssi_alim_offset_1, tssi_alim_offset_2, tssi_alim_offset_3;
 	u32 tssi_cw_rpt[RTW8852BT_TSSI_PATH_NR] = {};
 	u8 channel = chan->channel;
@@ -3934,7 +3934,7 @@ void rtw8852bt_tssi(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy, bool hwtx_
 
 void rtw8852bt_tssi_scan(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy)
 {
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
 	struct rtw89_tssi_info *tssi_info = &rtwdev->tssi;
 	u8 channel = chan->channel;
 	u8 band;
@@ -3974,7 +3974,7 @@ void rtw8852bt_tssi_scan(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy)
 static void rtw8852bt_tssi_default_txagc(struct rtw89_dev *rtwdev,
 					 enum rtw89_phy_idx phy, bool enable)
 {
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
 	u8 channel = chan->channel;
 
 	rtw89_debug(rtwdev, RTW89_DBG_RFK, "======> %s   ch=%d\n",
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index 193168dc7b6c..34517afc8290 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -2108,7 +2108,7 @@ rtw8852c_init_txpwr_unit(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
 
 static void rtw8852c_bb_cfg_rx_path(struct rtw89_dev *rtwdev, u8 rx_path)
 {
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
 	u8 band = chan->band_type;
 	u32 rst_mask0 = B_P0_TXPW_RSTB_MANON | B_P0_TXPW_RSTB_TSSI;
 	u32 rst_mask1 = B_P1_TXPW_RSTB_MANON | B_P1_TXPW_RSTB_TSSI;
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c b/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c
index 743f7014bf3e..7c529304c5b8 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c
@@ -1323,7 +1323,7 @@ static void _iqk_by_path(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx, u
 static void _iqk_get_ch_info(struct rtw89_dev *rtwdev,
 			     enum rtw89_phy_idx phy, u8 path)
 {
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
 	struct rtw89_iqk_info *iqk_info = &rtwdev->iqk;
 
 	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK]===>%s\n", __func__);
@@ -1903,7 +1903,7 @@ static void _dpk_information(struct rtw89_dev *rtwdev,
 			     enum rtw89_phy_idx phy,
 			     enum rtw89_rf_path path)
 {
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
 	struct rtw89_dpk_info *dpk = &rtwdev->dpk;
 
 	u8 kidx = dpk->cur_idx[path];
@@ -2497,7 +2497,7 @@ static void _dpk_idl_mpa(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 static bool _dpk_reload_check(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 			      enum rtw89_rf_path path)
 {
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
 	struct rtw89_dpk_info *dpk = &rtwdev->dpk;
 	bool is_reload = false;
 	u8 idx, cur_band, cur_ch;
@@ -2758,7 +2758,7 @@ static void _dpk_cal_select(struct rtw89_dev *rtwdev, bool force,
 static bool _dpk_bypass_check(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy)
 {
 	struct rtw89_fem_info *fem = &rtwdev->fem;
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
 	u8 band = chan->band_type;
 
 	if (rtwdev->hal.cv == CHIP_CAV && band != RTW89_BAND_2G) {
@@ -2893,7 +2893,7 @@ static void _dpk_track(struct rtw89_dev *rtwdev)
 static void _tssi_set_sys(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 			  enum rtw89_rf_path path)
 {
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
 	enum rtw89_bandwidth bw = chan->band_width;
 	enum rtw89_band band = chan->band_type;
 	u32 clk = 0x0;
@@ -2947,7 +2947,7 @@ static void _tssi_ini_txpwr_ctrl_bb_he_tb(struct rtw89_dev *rtwdev,
 static void _tssi_set_dck(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 			  enum rtw89_rf_path path)
 {
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
 	enum rtw89_band band = chan->band_type;
 
 	if (path == RF_PATH_A) {
@@ -2986,7 +2986,7 @@ static void _tssi_set_tmeter_tbl(struct rtw89_dev *rtwdev, enum rtw89_phy_idx ph
 	__val;						\
 })
 	struct rtw89_tssi_info *tssi_info = &rtwdev->tssi;
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
 	u8 ch = chan->channel;
 	u8 subband = chan->subband_type;
 	const s8 *thm_up_a = NULL;
@@ -3160,7 +3160,7 @@ static void _tssi_set_tmeter_tbl(struct rtw89_dev *rtwdev, enum rtw89_phy_idx ph
 static void _tssi_slope_cal_org(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 				enum rtw89_rf_path path)
 {
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
 	enum rtw89_band band = chan->band_type;
 
 	if (path == RF_PATH_A) {
@@ -3177,7 +3177,7 @@ static void _tssi_slope_cal_org(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy
 static void _tssi_set_aligk_default(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 				    enum rtw89_rf_path path)
 {
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
 	enum rtw89_band band = chan->band_type;
 	const struct rtw89_rfk_tbl *tbl;
 
@@ -3589,7 +3589,7 @@ static s8 _tssi_get_ofdm_de(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 			    enum rtw89_rf_path path)
 {
 	struct rtw89_tssi_info *tssi_info = &rtwdev->tssi;
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
 	enum rtw89_band band = chan->band_type;
 	u8 ch = chan->channel;
 	u32 gidx, gidx_1st, gidx_2nd;
@@ -3653,7 +3653,7 @@ static s8 _tssi_get_ofdm_trim_de(struct rtw89_dev *rtwdev,
 				 enum rtw89_rf_path path)
 {
 	struct rtw89_tssi_info *tssi_info = &rtwdev->tssi;
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
 	enum rtw89_band band = chan->band_type;
 	u8 ch = chan->channel;
 	u32 tgidx, tgidx_1st, tgidx_2nd;
@@ -3718,7 +3718,7 @@ static void _tssi_set_efuse_to_de(struct rtw89_dev *rtwdev,
 				  enum rtw89_phy_idx phy)
 {
 	struct rtw89_tssi_info *tssi_info = &rtwdev->tssi;
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
 	u8 ch = chan->channel;
 	u8 gidx;
 	s8 ofdm_de;
@@ -4079,10 +4079,10 @@ void rtw8852c_mcc_get_ch_info(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_i
 	mode = rtw89_get_entity_mode(rtwdev);
 	switch (mode) {
 	case RTW89_ENTITY_MODE_MCC_PREPARE:
-		chan_idx = RTW89_SUB_ENTITY_1;
+		chan_idx = RTW89_CHANCTX_1;
 		break;
 	default:
-		chan_idx = RTW89_SUB_ENTITY_0;
+		chan_idx = RTW89_CHANCTX_0;
 		break;
 	}
 
@@ -4202,7 +4202,7 @@ void rtw8852c_rx_dck(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy, bool is_a
 
 void rtw8852c_rx_dck_track(struct rtw89_dev *rtwdev)
 {
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
 	struct rtw89_rx_dck_info *rx_dck = &rtwdev->rx_dck;
 	enum rtw89_phy_idx phy_idx = RTW89_PHY_0;
 	u8 phy_map = rtw89_btc_phymap(rtwdev, phy_idx, 0);
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a.c b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
index 2af568a3264d..a22bab77f4b8 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
@@ -1682,7 +1682,7 @@ static int rtw8922a_ctrl_rx_path_tmac(struct rtw89_dev *rtwdev,
 
 static int rtw8922a_ctrl_mlo(struct rtw89_dev *rtwdev, enum rtw89_mlo_dbcc_mode mode)
 {
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
 
 	if (mode == MLO_1_PLUS_1_1RF || mode == DBCC_LEGACY) {
 		rtw89_phy_write32_mask(rtwdev, R_DBCC, B_DBCC_EN, 0x1);
@@ -2109,7 +2109,7 @@ static void rtw8922a_ctrl_nbtg_bt_tx(struct rtw89_dev *rtwdev, bool en,
 
 static void rtw8922a_bb_cfg_txrx_path(struct rtw89_dev *rtwdev)
 {
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
 	enum rtw89_band band = chan->band_type;
 	struct rtw89_hal *hal = &rtwdev->hal;
 	u8 ntx_path = RF_PATH_AB;
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a_rfk.c b/drivers/net/wireless/realtek/rtw89/rtw8922a_rfk.c
index 0ebcb06ae848..28907df7407d 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a_rfk.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a_rfk.c
@@ -256,7 +256,7 @@ static void rtw8922a_chlk_reload(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_rfk_mcc_info *rfk_mcc = &rtwdev->rfk_mcc;
 	struct rtw89_rfk_chan_desc desc[__RTW89_RFK_CHS_NR_V1] = {};
-	enum rtw89_sub_entity_idx sub_entity_idx;
+	enum rtw89_chanctx_idx chanctx_idx;
 	const struct rtw89_chan *chan;
 	enum rtw89_entity_mode mode;
 	u8 s0_tbl, s1_tbl;
@@ -265,14 +265,14 @@ static void rtw8922a_chlk_reload(struct rtw89_dev *rtwdev)
 	mode = rtw89_get_entity_mode(rtwdev);
 	switch (mode) {
 	case RTW89_ENTITY_MODE_MCC_PREPARE:
-		sub_entity_idx = RTW89_SUB_ENTITY_1;
+		chanctx_idx = RTW89_CHANCTX_1;
 		break;
 	default:
-		sub_entity_idx = RTW89_SUB_ENTITY_0;
+		chanctx_idx = RTW89_CHANCTX_0;
 		break;
 	}
 
-	chan = rtw89_chan_get(rtwdev, sub_entity_idx);
+	chan = rtw89_chan_get(rtwdev, chanctx_idx);
 
 	for (tbl_sel = 0; tbl_sel < ARRAY_SIZE(desc); tbl_sel++) {
 		struct rtw89_rfk_chan_desc *p = &desc[tbl_sel];
diff --git a/drivers/net/wireless/realtek/rtw89/sar.c b/drivers/net/wireless/realtek/rtw89/sar.c
index 1b2a400406ae..27826d909785 100644
--- a/drivers/net/wireless/realtek/rtw89/sar.c
+++ b/drivers/net/wireless/realtek/rtw89/sar.c
@@ -366,7 +366,7 @@ static void rtw89_tas_state_update(struct rtw89_dev *rtwdev)
 	if (src == RTW89_SAR_SOURCE_NONE)
 		return;
 
-	chan = rtw89_chan_get(rtwdev, RTW89_SUB_ENTITY_0);
+	chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
 	ret = sar_hdl->query_sar_config(rtwdev, chan->freq, &cfg);
 	if (ret)
 		return;
-- 
2.25.1


