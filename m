Return-Path: <linux-wireless+bounces-28712-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AE5EC44C85
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 03:37:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 031FC3AE120
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Nov 2025 02:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B3911862;
	Mon, 10 Nov 2025 02:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="DTvKLjiS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275E66A8D2
	for <linux-wireless@vger.kernel.org>; Mon, 10 Nov 2025 02:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762742273; cv=none; b=Rt5olE/eLjDeP0FgrFNVwKHticcpUnyBjSNJTt6vwNZcj9uUJQ5VkSPef9edKnIgx+zXUWpJCPlxchAycgzOz2DEzEQKiYPLZ/JBpwqRyyFwtUkkerUEPgZyXvtKZ66dUsrRgADMz0CjthTeXZ287h5NafmKTg+JZXpb9tlZ0NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762742273; c=relaxed/simple;
	bh=CJa4FhdTSG1mlE7ECDeMKx2nkyWFK/h0RllPCqmpXJc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fHPy+KMpP489sOuKz4kK6eAYIAyc+/dFY0k5lSCYupI8AyE+7GB2i5eZ9TosK/yuZ/iuUJwzSjxnKjgnvOtIpNirSJimh/h8DWt4cZLk5mX9zf065Wj0BLwtIUDmb+QnJBy9Xysf8sTFlWUkaVToLYk0I5eBCl4/1Ulc3sx7m6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=DTvKLjiS; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5AA2bdLB3710842, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1762742259; bh=agOOyar+DPtEEMvIMIGLfuAFh5yIpnDgJe+xp1ObD8U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=DTvKLjiSbQ0zRFQdWIicM8QB5F5G0TezlX4ZiGyyKQSk0dFfp/bKSug4QPYQ88yJs
	 Bgj3WQJV7Sce6BaGCqWOKJOunyfD7fU98wSaebgkoccJe3oq8Dsm88a1Ln16cJKSwc
	 Y6KbqIYgYwMwh9gEv9e/RBaRlv0nA+BqHGEKgGj3IwbDXy9uh02BBBlVreAcoV00tm
	 LNpzmI/Q1MLPQ/BfDMAfygcLp/rtooIkjuLfKqRezkQKZb0HiY/NZ5EF7TzNyVoNNM
	 nJF0ttKRGnBDS33YcXtfkCpWFNEmAwpdYhob+E6HOtmX6o5VXMg8gePa7QB+VrcKso
	 S2gAueqoHxMKw==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 5AA2bdLB3710842
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Nov 2025 10:37:39 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Mon, 10 Nov 2025 10:37:39 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Mon, 10 Nov 2025 10:37:39 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTKEXHMBS04.realtek.com.tw
 (10.21.1.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27 via Frontend
 Transport; Mon, 10 Nov 2025 10:37:39 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <geert@linux-m68k.org>
Subject: [RFT rtw-next] wifi: rtw89: use separated function to set RX filter
Date: Mon, 10 Nov 2025 10:37:07 +0800
Message-ID: <20251110023707.6272-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Normally use rtw89_write32_mask() with a consecutive bit mask, but mask of
RX filter B_AX_RX_FLTR_CFG_MASK is bits 31-22 and 15-0, which excludes bits
of B_AX_RX_MPDU_MAX_LEN_MASK (bits 21-16).

Though the original logic is well to set RX filter, change it to a separate
function to avoid the tricky design.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c     |  5 +----
 drivers/net/wireless/realtek/rtw89/fw.c       | 10 ++--------
 drivers/net/wireless/realtek/rtw89/mac.c      | 14 ++++++++++++++
 drivers/net/wireless/realtek/rtw89/mac.h      |  1 +
 drivers/net/wireless/realtek/rtw89/mac80211.c | 11 ++---------
 5 files changed, 20 insertions(+), 21 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 1d30ff27bce1..3353fa854f50 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -4084,12 +4084,10 @@ void rtw89_roc_start(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
 
 void rtw89_roc_end(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
 {
-	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
 	struct ieee80211_hw *hw = rtwdev->hw;
 	struct rtw89_roc *roc = &rtwvif->roc;
 	struct rtw89_vif_link *rtwvif_link;
 	struct rtw89_vif *tmp_vif;
-	u32 reg;
 	int ret;
 
 	lockdep_assert_wiphy(hw->wiphy);
@@ -4106,8 +4104,7 @@ void rtw89_roc_end(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
 		return;
 	}
 
-	reg = rtw89_mac_reg_by_idx(rtwdev, mac->rx_fltr, rtwvif_link->mac_idx);
-	rtw89_write32_mask(rtwdev, reg, B_AX_RX_FLTR_CFG_MASK, rtwdev->hal.rx_fltr);
+	rtw89_mac_set_rx_fltr(rtwdev, rtwvif_link->mac_idx, rtwdev->hal.rx_fltr);
 
 	roc->state = RTW89_ROC_IDLE;
 	rtw89_config_roc_chandef(rtwdev, rtwvif_link, NULL);
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 96f0463e66d6..6befff39f23e 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -8053,7 +8053,6 @@ int rtw89_hw_scan_start(struct rtw89_dev *rtwdev,
 			struct rtw89_vif_link *rtwvif_link,
 			struct ieee80211_scan_request *scan_req)
 {
-	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
 	enum rtw89_entity_mode mode = rtw89_get_entity_mode(rtwdev);
 	struct cfg80211_scan_request *req = &scan_req->req;
 	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev,
@@ -8065,7 +8064,6 @@ int rtw89_hw_scan_start(struct rtw89_dev *rtwdev,
 	};
 	u32 rx_fltr = rtwdev->hal.rx_fltr;
 	u8 mac_addr[ETH_ALEN];
-	u32 reg;
 	int ret;
 
 	/* clone op and keep it during scan */
@@ -8105,8 +8103,7 @@ int rtw89_hw_scan_start(struct rtw89_dev *rtwdev,
 	rx_fltr &= ~B_AX_A_BC;
 	rx_fltr &= ~B_AX_A_A1_MATCH;
 
-	reg = rtw89_mac_reg_by_idx(rtwdev, mac->rx_fltr, rtwvif_link->mac_idx);
-	rtw89_write32_mask(rtwdev, reg, B_AX_RX_FLTR_CFG_MASK, rx_fltr);
+	rtw89_mac_set_rx_fltr(rtwdev, rtwvif_link->mac_idx, rx_fltr);
 
 	rtw89_chanctx_pause(rtwdev, &pause_parm);
 	rtw89_phy_dig_suspend(rtwdev);
@@ -8124,20 +8121,17 @@ struct rtw89_hw_scan_complete_cb_data {
 
 static int rtw89_hw_scan_complete_cb(struct rtw89_dev *rtwdev, void *data)
 {
-	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
 	enum rtw89_entity_mode mode = rtw89_get_entity_mode(rtwdev);
 	struct rtw89_hw_scan_complete_cb_data *cb_data = data;
 	struct rtw89_vif_link *rtwvif_link = cb_data->rtwvif_link;
 	struct cfg80211_scan_info info = {
 		.aborted = cb_data->aborted,
 	};
-	u32 reg;
 
 	if (!rtwvif_link)
 		return -EINVAL;
 
-	reg = rtw89_mac_reg_by_idx(rtwdev, mac->rx_fltr, rtwvif_link->mac_idx);
-	rtw89_write32_mask(rtwdev, reg, B_AX_RX_FLTR_CFG_MASK, rtwdev->hal.rx_fltr);
+	rtw89_mac_set_rx_fltr(rtwdev, rtwvif_link->mac_idx, rtwdev->hal.rx_fltr);
 
 	rtw89_core_scan_complete(rtwdev, rtwvif_link, true);
 	ieee80211_scan_completed(rtwdev->hw, &info);
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 0a8474002cb7..e11a54f33c8a 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -2519,6 +2519,20 @@ static int rtw89_mac_typ_fltr_opt_ax(struct rtw89_dev *rtwdev,
 	return 0;
 }
 
+void rtw89_mac_set_rx_fltr(struct rtw89_dev *rtwdev, u8 mac_idx, u32 rx_fltr)
+{
+	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
+	u32 reg;
+	u32 val;
+
+	reg = rtw89_mac_reg_by_idx(rtwdev, mac->rx_fltr, mac_idx);
+
+	val = rtw89_read32(rtwdev, reg);
+	/* B_AX_RX_FLTR_CFG_MASK is not a consecutive bit mask */
+	val = (val & ~B_AX_RX_FLTR_CFG_MASK) | (rx_fltr & B_AX_RX_FLTR_CFG_MASK);
+	rtw89_write32(rtwdev, reg, val);
+}
+
 static int rx_fltr_init_ax(struct rtw89_dev *rtwdev, u8 mac_idx)
 {
 	int ret, i;
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index ce3474a7ba03..ac7eacb29faa 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -1336,6 +1336,7 @@ int rtw89_mac_cfg_ppdu_status_bands(struct rtw89_dev *rtwdev, bool enable)
 	return rtw89_mac_cfg_ppdu_status(rtwdev, RTW89_MAC_1, enable);
 }
 
+void rtw89_mac_set_rx_fltr(struct rtw89_dev *rtwdev, u8 mac_idx, u32 rx_fltr);
 void rtw89_mac_update_rts_threshold(struct rtw89_dev *rtwdev);
 void rtw89_mac_flush_txq(struct rtw89_dev *rtwdev, u32 queues, bool drop);
 int rtw89_mac_coex_init(struct rtw89_dev *rtwdev, const struct rtw89_mac_ax_coex *coex);
diff --git a/drivers/net/wireless/realtek/rtw89/mac80211.c b/drivers/net/wireless/realtek/rtw89/mac80211.c
index a19304ff8306..3d33f859d293 100644
--- a/drivers/net/wireless/realtek/rtw89/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw89/mac80211.c
@@ -303,7 +303,6 @@ static void rtw89_ops_configure_filter(struct ieee80211_hw *hw,
 				       u64 multicast)
 {
 	struct rtw89_dev *rtwdev = hw->priv;
-	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
 	u32 rx_fltr;
 
 	lockdep_assert_wiphy(hw->wiphy);
@@ -365,16 +364,10 @@ static void rtw89_ops_configure_filter(struct ieee80211_hw *hw,
 		rx_fltr &= ~B_AX_A_A1_MATCH;
 	}
 
-	rtw89_write32_mask(rtwdev,
-			   rtw89_mac_reg_by_idx(rtwdev, mac->rx_fltr, RTW89_MAC_0),
-			   B_AX_RX_FLTR_CFG_MASK,
-			   rx_fltr);
+	rtw89_mac_set_rx_fltr(rtwdev, RTW89_MAC_0, rx_fltr);
 	if (!rtwdev->dbcc_en)
 		return;
-	rtw89_write32_mask(rtwdev,
-			   rtw89_mac_reg_by_idx(rtwdev, mac->rx_fltr, RTW89_MAC_1),
-			   B_AX_RX_FLTR_CFG_MASK,
-			   rx_fltr);
+	rtw89_mac_set_rx_fltr(rtwdev, RTW89_MAC_1, rx_fltr);
 }
 
 static const u8 ac_to_fw_idx[IEEE80211_NUM_ACS] = {
-- 
2.25.1


