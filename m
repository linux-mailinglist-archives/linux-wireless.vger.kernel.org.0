Return-Path: <linux-wireless+bounces-28896-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1309AC55D08
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Nov 2025 06:35:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C76AD4E0F98
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Nov 2025 05:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87239286D7D;
	Thu, 13 Nov 2025 05:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="aBUekYUZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A8B26FA6E
	for <linux-wireless@vger.kernel.org>; Thu, 13 Nov 2025 05:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763012147; cv=none; b=C6d9RQHtBuTBzQUzCEQYikR+4HllSZfvMY5Szl4l1KpeS5180ARYqe5TEu5UCKhtnt2HDBhv89BPpAwAQgYQr0USwnneESg1MqYSFW18r3w5t5Z5iAr772Cu0x7qZrGTIK3YICYfXBtQP0+YfYWx9cpdejHUBw+t056jkjxc+Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763012147; c=relaxed/simple;
	bh=0ASCBWiAIiZ0wql5yvaRSgN6JflyTFlon4amziUDbj4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=B80gLAGPvqplZz64FWp6c7n8SR0iTG/Uznevu4P38zdPzZAnYtydKuZ6NctBLkucfzophSZMjxoL0X6yLRQodWUFTxKxosgI9RhR5MIzjy2q5f3y80uswLDFplqgerbwzH99Hv27cvGIxIsihBJKeadBw2KeNULg6sCZcebW+W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=aBUekYUZ; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5AD5ZYpC43033217, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1763012134; bh=YCixyb3gc6KAx9KnHYInpm16YdPmLAURkuAOG1sX4qo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=aBUekYUZ94+TxQ1i9QZvPjNujWbvEQSWSykXoWxdm4wrw4gXx7T1stcfWRazCaTbl
	 oHgVIpD2eB3feZhpbI65Mj4jK6yeIZbN5MZR06XosYeP2yel0IvgeGq8hQPAizBKX1
	 lcAhKEzMuJbtsV6N5gYWW9053rKrpzbqiKKdBQUtQdtMskGeDZHzH5FIY8hPi+I3ik
	 DIuk2fhb4kkbNyPy2YzV4GRWSfKd/95RHtbsmVs0RMekJ2bJuxFpPuKgJcHsX1thNb
	 0rcVJhy+SZRZpEAiCDrsF7+1JY7DjPFjTrP8CzamvHZW0gFeZvlUzIAi14cfKNDSgn
	 epghusiA3Jkaw==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5AD5ZYpC43033217
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 13:35:34 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Thu, 13 Nov 2025 13:35:34 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27 via Frontend
 Transport; Thu, 13 Nov 2025 13:35:34 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <geert@linux-m68k.org>
Subject: [PATCH rtw-next] wifi: rtw89: use separated function to set RX filter
Date: Thu, 13 Nov 2025 13:34:59 +0800
Message-ID: <20251113053459.34995-1-pkshih@realtek.com>
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

Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
Hi Geert,

I plan to have this change in next release cycle, and then you can send
your patches without errors caused by this.
---
 drivers/net/wireless/realtek/rtw89/core.c     |  5 +----
 drivers/net/wireless/realtek/rtw89/fw.c       | 10 ++--------
 drivers/net/wireless/realtek/rtw89/mac.c      | 14 ++++++++++++++
 drivers/net/wireless/realtek/rtw89/mac.h      |  1 +
 drivers/net/wireless/realtek/rtw89/mac80211.c | 11 ++---------
 5 files changed, 20 insertions(+), 21 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index a15a911484bb..b6b8500a0028 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -4169,12 +4169,10 @@ void rtw89_roc_start(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
 
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
@@ -4191,8 +4189,7 @@ void rtw89_roc_end(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
 		return;
 	}
 
-	reg = rtw89_mac_reg_by_idx(rtwdev, mac->rx_fltr, rtwvif_link->mac_idx);
-	rtw89_write32_mask(rtwdev, reg, B_AX_RX_FLTR_CFG_MASK, rtwdev->hal.rx_fltr);
+	rtw89_mac_set_rx_fltr(rtwdev, rtwvif_link->mac_idx, rtwdev->hal.rx_fltr);
 
 	roc->state = RTW89_ROC_IDLE;
 	rtw89_config_roc_chandef(rtwdev, rtwvif_link, NULL);
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 515e9f098380..e96c3725a1ea 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -8068,7 +8068,6 @@ int rtw89_hw_scan_start(struct rtw89_dev *rtwdev,
 			struct rtw89_vif_link *rtwvif_link,
 			struct ieee80211_scan_request *scan_req)
 {
-	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
 	enum rtw89_entity_mode mode = rtw89_get_entity_mode(rtwdev);
 	struct cfg80211_scan_request *req = &scan_req->req;
 	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev,
@@ -8080,7 +8079,6 @@ int rtw89_hw_scan_start(struct rtw89_dev *rtwdev,
 	};
 	u32 rx_fltr = rtwdev->hal.rx_fltr;
 	u8 mac_addr[ETH_ALEN];
-	u32 reg;
 	int ret;
 
 	/* clone op and keep it during scan */
@@ -8120,8 +8118,7 @@ int rtw89_hw_scan_start(struct rtw89_dev *rtwdev,
 	rx_fltr &= ~B_AX_A_BC;
 	rx_fltr &= ~B_AX_A_A1_MATCH;
 
-	reg = rtw89_mac_reg_by_idx(rtwdev, mac->rx_fltr, rtwvif_link->mac_idx);
-	rtw89_write32_mask(rtwdev, reg, B_AX_RX_FLTR_CFG_MASK, rx_fltr);
+	rtw89_mac_set_rx_fltr(rtwdev, rtwvif_link->mac_idx, rx_fltr);
 
 	rtw89_chanctx_pause(rtwdev, &pause_parm);
 	rtw89_phy_dig_suspend(rtwdev);
@@ -8139,20 +8136,17 @@ struct rtw89_hw_scan_complete_cb_data {
 
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
index dab0a76556c9..0786a9e32548 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -2543,6 +2543,20 @@ static int rtw89_mac_typ_fltr_opt_ax(struct rtw89_dev *rtwdev,
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
index 3cc97fd0c0ec..98cfd5c3cb3f 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -1339,6 +1339,7 @@ int rtw89_mac_cfg_ppdu_status_bands(struct rtw89_dev *rtwdev, bool enable)
 	return rtw89_mac_cfg_ppdu_status(rtwdev, RTW89_MAC_1, enable);
 }
 
+void rtw89_mac_set_rx_fltr(struct rtw89_dev *rtwdev, u8 mac_idx, u32 rx_fltr);
 void rtw89_mac_update_rts_threshold(struct rtw89_dev *rtwdev);
 void rtw89_mac_flush_txq(struct rtw89_dev *rtwdev, u32 queues, bool drop);
 int rtw89_mac_coex_init(struct rtw89_dev *rtwdev, const struct rtw89_mac_ax_coex *coex);
diff --git a/drivers/net/wireless/realtek/rtw89/mac80211.c b/drivers/net/wireless/realtek/rtw89/mac80211.c
index 6f7571c7c274..a335a04f413d 100644
--- a/drivers/net/wireless/realtek/rtw89/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw89/mac80211.c
@@ -307,7 +307,6 @@ static void rtw89_ops_configure_filter(struct ieee80211_hw *hw,
 				       u64 multicast)
 {
 	struct rtw89_dev *rtwdev = hw->priv;
-	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
 	u32 rx_fltr;
 
 	lockdep_assert_wiphy(hw->wiphy);
@@ -369,16 +368,10 @@ static void rtw89_ops_configure_filter(struct ieee80211_hw *hw,
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


