Return-Path: <linux-wireless+bounces-22833-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D4FBAB2665
	for <lists+linux-wireless@lfdr.de>; Sun, 11 May 2025 05:52:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8889F18956A7
	for <lists+linux-wireless@lfdr.de>; Sun, 11 May 2025 03:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22769188A0E;
	Sun, 11 May 2025 03:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="qOeC6onk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0D116DC28
	for <linux-wireless@vger.kernel.org>; Sun, 11 May 2025 03:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746935569; cv=none; b=c69sZ1ODsUHbvOqkNSdg/K6PPwICxwW5HnURhN9QMqwPwzb/33RcqVMIsm50ZYXVr5g9bO7H6J62d0pHUAzWkxukFENbYDOeY1UAAFK9EkeiNLb7qoqOg2TIzK7WLk5I0RHG8iOnFMzLMxRP4o/Sy7TYSx/SG0Uol8O7L5i6OB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746935569; c=relaxed/simple;
	bh=6Gicu7XXOfpQj2iPi7AiM2DoRzy3Fc3gWKoj/pgDd3o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DzzIlp5jTOFDoc3GOpqTab0yUbwgVI7iNRAS3PGdQyHjf/J8NH2zygH+CUGddZYXJhTJv9+bzzOU0PWMMGbYLUp6qYE+XIrdCc77/kFO8q1tSpR7lVbceKGo/XAdz926zQJ/naA9Z8RxzoYsLI+mBDxXNNYvxoi6BzKFJQfUNfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=qOeC6onk; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 54B3qbeM73302876, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1746935557; bh=6Gicu7XXOfpQj2iPi7AiM2DoRzy3Fc3gWKoj/pgDd3o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=qOeC6onkkOV17aI2Sp6QYauUKoXl5aceaThsX74sJnbfYklVYXnACTVU47BBwI0RA
	 nUg/sC10aUsYgVnnN65TGhxMv/k/4YNqqmwExyBti6zAuLH21uZoeV+oR5ZnpPeg6/
	 uHsrcV1wSSaKupg5N1lNM+elhqM3uuq9VPE2yykbNznx184nbKhCt5FWbKFpnMkDq7
	 TUJHT/X5Fd7Cud9X/4acAT06f2zGtD2zyKoggir6emZBnYRBGg+QVgVMP+hzu9zBxg
	 Kx2/+rEQiKm5Zg4Z/TWKXByJEb4xNH/Ty9Y3bPfV5jY6fJKvPo4Q3eXeLkyyDsCVaK
	 Zkfp1xRGfqvWA==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 54B3qbeM73302876
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Sun, 11 May 2025 11:52:37 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 11 May 2025 11:52:38 +0800
Received: from [127.0.1.1] (10.22.224.86) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Sun, 11 May
 2025 11:52:37 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 1/6] wifi: rtw89: mcc: pass whom to stop at when pausing chanctx
Date: Sun, 11 May 2025 11:52:12 +0800
Message-ID: <20250511035217.10410-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250511035217.10410-1-pkshih@realtek.com>
References: <20250511035217.10410-1-pkshih@realtek.com>
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

When stopping MCC, FW can stop at a given MCC role following H2C command.
When pausing chanctx during MCC, in general, the caller expects to process
things with its chanctx. So, pass the caller as target and let FW stop MCC
at it.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/chan.c | 35 +++++++++++++++++------
 drivers/net/wireless/realtek/rtw89/chan.h |  7 ++++-
 drivers/net/wireless/realtek/rtw89/core.c |  6 +++-
 drivers/net/wireless/realtek/rtw89/fw.c   |  6 +++-
 4 files changed, 43 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/chan.c b/drivers/net/wireless/realtek/rtw89/chan.c
index 871befa63889..ff476bde39ab 100644
--- a/drivers/net/wireless/realtek/rtw89/chan.c
+++ b/drivers/net/wireless/realtek/rtw89/chan.c
@@ -2107,6 +2107,12 @@ static int rtw89_mcc_start(struct rtw89_dev *rtwdev)
 }
 
 struct rtw89_mcc_stop_sel {
+	struct {
+		const struct rtw89_vif_link *target;
+	} hint;
+
+	/* selection content */
+	bool filled;
 	u8 mac_id;
 	u8 slot_idx;
 };
@@ -2116,6 +2122,7 @@ static void rtw89_mcc_stop_sel_fill(struct rtw89_mcc_stop_sel *sel,
 {
 	sel->mac_id = mcc_role->rtwvif_link->mac_id;
 	sel->slot_idx = mcc_role->slot_idx;
+	sel->filled = true;
 }
 
 static int rtw89_mcc_stop_sel_iterator(struct rtw89_dev *rtwdev,
@@ -2125,23 +2132,35 @@ static int rtw89_mcc_stop_sel_iterator(struct rtw89_dev *rtwdev,
 {
 	struct rtw89_mcc_stop_sel *sel = data;
 
+	if (mcc_role->rtwvif_link == sel->hint.target) {
+		rtw89_mcc_stop_sel_fill(sel, mcc_role);
+		return 1; /* break iteration */
+	}
+
+	if (sel->filled)
+		return 0;
+
 	if (!mcc_role->rtwvif_link->chanctx_assigned)
 		return 0;
 
 	rtw89_mcc_stop_sel_fill(sel, mcc_role);
-	return 1; /* break iteration */
+	return 0;
 }
 
-static void rtw89_mcc_stop(struct rtw89_dev *rtwdev)
+static void rtw89_mcc_stop(struct rtw89_dev *rtwdev,
+			   const struct rtw89_chanctx_pause_parm *pause)
 {
 	struct rtw89_mcc_info *mcc = &rtwdev->mcc;
 	struct rtw89_mcc_role *ref = &mcc->role_ref;
-	struct rtw89_mcc_stop_sel sel;
+	struct rtw89_mcc_stop_sel sel = {
+		.hint.target = pause ? pause->trigger : NULL,
+	};
 	int ret;
 
 	/* by default, stop at ref */
-	rtw89_mcc_stop_sel_fill(&sel, ref);
 	rtw89_iterate_mcc_roles(rtwdev, rtw89_mcc_stop_sel_iterator, &sel);
+	if (!sel.filled)
+		rtw89_mcc_stop_sel_fill(&sel, ref);
 
 	rtw89_debug(rtwdev, RTW89_DBG_CHAN, "MCC stop at <macid %d>\n", sel.mac_id);
 
@@ -2492,7 +2511,7 @@ void rtw89_chanctx_track(struct rtw89_dev *rtwdev)
 }
 
 void rtw89_chanctx_pause(struct rtw89_dev *rtwdev,
-			 enum rtw89_chanctx_pause_reasons rsn)
+			 const struct rtw89_chanctx_pause_parm *pause_parm)
 {
 	struct rtw89_hal *hal = &rtwdev->hal;
 	enum rtw89_entity_mode mode;
@@ -2502,12 +2521,12 @@ void rtw89_chanctx_pause(struct rtw89_dev *rtwdev,
 	if (hal->entity_pause)
 		return;
 
-	rtw89_debug(rtwdev, RTW89_DBG_CHAN, "chanctx pause (rsn: %d)\n", rsn);
+	rtw89_debug(rtwdev, RTW89_DBG_CHAN, "chanctx pause (rsn: %d)\n", pause_parm->rsn);
 
 	mode = rtw89_get_entity_mode(rtwdev);
 	switch (mode) {
 	case RTW89_ENTITY_MODE_MCC:
-		rtw89_mcc_stop(rtwdev);
+		rtw89_mcc_stop(rtwdev, pause_parm);
 		break;
 	default:
 		break;
@@ -2732,7 +2751,7 @@ void rtw89_chanctx_ops_unassign_vif(struct rtw89_dev *rtwdev,
 		cur = rtw89_get_entity_mode(rtwdev);
 		switch (cur) {
 		case RTW89_ENTITY_MODE_MCC:
-			rtw89_mcc_stop(rtwdev);
+			rtw89_mcc_stop(rtwdev, NULL);
 			break;
 		default:
 			break;
diff --git a/drivers/net/wireless/realtek/rtw89/chan.h b/drivers/net/wireless/realtek/rtw89/chan.h
index b42e044d7927..2a25563593af 100644
--- a/drivers/net/wireless/realtek/rtw89/chan.h
+++ b/drivers/net/wireless/realtek/rtw89/chan.h
@@ -46,6 +46,11 @@ enum rtw89_chanctx_pause_reasons {
 	RTW89_CHANCTX_PAUSE_REASON_ROC,
 };
 
+struct rtw89_chanctx_pause_parm {
+	const struct rtw89_vif_link *trigger;
+	enum rtw89_chanctx_pause_reasons rsn;
+};
+
 struct rtw89_chanctx_cb_parm {
 	int (*cb)(struct rtw89_dev *rtwdev, void *data);
 	void *data;
@@ -113,7 +118,7 @@ void rtw89_queue_chanctx_change(struct rtw89_dev *rtwdev,
 				enum rtw89_chanctx_changes change);
 void rtw89_chanctx_track(struct rtw89_dev *rtwdev);
 void rtw89_chanctx_pause(struct rtw89_dev *rtwdev,
-			 enum rtw89_chanctx_pause_reasons rsn);
+			 const struct rtw89_chanctx_pause_parm *parm);
 void rtw89_chanctx_proceed(struct rtw89_dev *rtwdev,
 			   const struct rtw89_chanctx_cb_parm *cb_parm);
 
diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 0b6fb30cbf52..3b2a2c6b9a44 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -3389,6 +3389,9 @@ static int rtw89_core_send_nullfunc(struct rtw89_dev *rtwdev,
 void rtw89_roc_start(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
 {
 	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
+	struct rtw89_chanctx_pause_parm pause_parm = {
+		.rsn = RTW89_CHANCTX_PAUSE_REASON_ROC,
+	};
 	struct ieee80211_hw *hw = rtwdev->hw;
 	struct rtw89_roc *roc = &rtwvif->roc;
 	struct rtw89_vif_link *rtwvif_link;
@@ -3410,7 +3413,8 @@ void rtw89_roc_start(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
 
 	roc->link_id = rtwvif_link->link_id;
 
-	rtw89_chanctx_pause(rtwdev, RTW89_CHANCTX_PAUSE_REASON_ROC);
+	pause_parm.trigger = rtwvif_link;
+	rtw89_chanctx_pause(rtwdev, &pause_parm);
 
 	ret = rtw89_core_send_nullfunc(rtwdev, rtwvif_link, true, true);
 	if (ret)
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 76350351dfb2..1abf69818fc6 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -7446,6 +7446,10 @@ int rtw89_hw_scan_start(struct rtw89_dev *rtwdev,
 	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev,
 						       rtwvif_link->chanctx_idx);
 	struct rtw89_vif *rtwvif = rtwvif_link->rtwvif;
+	struct rtw89_chanctx_pause_parm pause_parm = {
+		.rsn = RTW89_CHANCTX_PAUSE_REASON_HW_SCAN,
+		.trigger = rtwvif_link,
+	};
 	u32 rx_fltr = rtwdev->hal.rx_fltr;
 	u8 mac_addr[ETH_ALEN];
 	u32 reg;
@@ -7484,7 +7488,7 @@ int rtw89_hw_scan_start(struct rtw89_dev *rtwdev,
 	reg = rtw89_mac_reg_by_idx(rtwdev, mac->rx_fltr, rtwvif_link->mac_idx);
 	rtw89_write32_mask(rtwdev, reg, B_AX_RX_FLTR_CFG_MASK, rx_fltr);
 
-	rtw89_chanctx_pause(rtwdev, RTW89_CHANCTX_PAUSE_REASON_HW_SCAN);
+	rtw89_chanctx_pause(rtwdev, &pause_parm);
 
 	if (mode == RTW89_ENTITY_MODE_MCC)
 		rtw89_hw_scan_update_beacon_noa(rtwdev, req);
-- 
2.25.1


