Return-Path: <linux-wireless+bounces-17629-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F6FEA14A25
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Jan 2025 08:29:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8468F3AA8FD
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Jan 2025 07:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D628D1F790F;
	Fri, 17 Jan 2025 07:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="uYU+uszn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7633E1F8669
	for <linux-wireless@vger.kernel.org>; Fri, 17 Jan 2025 07:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737098965; cv=none; b=ZZa9eSZrv4PwOFbw2AuHPVTBHY+wtY6vCHUK97787jFD32oikHvZcstUDbBgtRPR3wV2KeHCtkgyB8zAwj8GHrkmSG4qFxD/5vs0qls17aoR3yV4KJZl338YZ0zwfR8aJoB/vzar5fKd6pr1EvkoHZuVFZZgxSXxtTBw5ituBKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737098965; c=relaxed/simple;
	bh=aXSQOHMpbxH8fgblbR6kPhiShECkG+kuDLA2lr7lyYw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sGphNp1eEgoPtZ9zsUny3jqthwA4S7eqbKrikOplYoOuuyCqrsmpY59x9NgfWERDaSnSsFKQSNYzm0cVD5paMgMtXY9rjlz/TRTknM/1w6YHvNvgVEqrppFu5SRHd8w50TG0OaN68sRaerNhLi5ndA3Tds/VoTVwwsvRE4V6NAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=uYU+uszn; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 50H7TLBA02337838, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1737098961; bh=aXSQOHMpbxH8fgblbR6kPhiShECkG+kuDLA2lr7lyYw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=uYU+usznNGSPNrz1/XJ0HEVrG7dJNG9i0OPTzVF4elXq7GK015+Jrprc8poRJ9ylV
	 I8JQfTwG4rWPTnGCVy0I/eGnzqCAiiZhU33I7S9ioLk94wOc064mU7EDJMK9lW361F
	 YxH8EwOcK3C0Zhd18QW+YbZZ+rkGH9nD34NHnvk/tlNTCfqxPD7N4grSgA1KZn4UHh
	 SkU/7O9Ip+A+2cR2cY4JBQFP2EqW5CfbLYDVe7tGq5KSLyX+p8N4Ajt593Hs9xv9yF
	 nb0PvBdRdW6j8RBfzKPq4FyDTcxZhfXVnxlkpK9p1KawGVcenu9gEFDDEgq52UI/TA
	 8YUZdI4HuTigg==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 50H7TLBA02337838
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 17 Jan 2025 15:29:21 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 17 Jan 2025 15:29:21 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 17 Jan
 2025 15:29:21 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH 6/8] wifi: rtw89: phy: support EDCCA per PHY
Date: Fri, 17 Jan 2025 15:28:26 +0800
Message-ID: <20250117072828.16728-7-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250117072828.16728-1-pkshih@realtek.com>
References: <20250117072828.16728-1-pkshih@realtek.com>
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

Dynamic mechanism EDCCA (Energy Detection Clear Channel Assessment) is to
dynamically adjusted to make EDCCA suitable for situations.

Use PHY context to support two PHY.

For the EDCCA log part, registers to report EDCCA for PHY 1 is not a
simple offset from PHY 0, so add them by separate patch.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c |   6 +-
 drivers/net/wireless/realtek/rtw89/core.h |   3 +-
 drivers/net/wireless/realtek/rtw89/phy.c  | 107 +++++++++++++---------
 drivers/net/wireless/realtek/rtw89/phy.h  |   5 +-
 4 files changed, 73 insertions(+), 48 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index e39fb696ac13..b730f70c82aa 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -4906,6 +4906,7 @@ void rtw89_core_scan_start(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwv
 {
 	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev,
 						       rtwvif_link->chanctx_idx);
+	struct rtw89_bb_ctx *bb = rtw89_get_bb_ctx(rtwdev, rtwvif_link->phy_idx);
 
 	rtwdev->scanning = true;
 	rtw89_leave_lps(rtwdev);
@@ -4916,7 +4917,7 @@ void rtw89_core_scan_start(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwv
 	rtw89_btc_ntfy_scan_start(rtwdev, rtwvif_link->phy_idx, chan->band_type);
 	rtw89_chip_rfk_scan(rtwdev, rtwvif_link, true);
 	rtw89_hci_recalc_int_mit(rtwdev);
-	rtw89_phy_config_edcca(rtwdev, true);
+	rtw89_phy_config_edcca(rtwdev, bb, true);
 
 	rtw89_fw_h2c_cam(rtwdev, rtwvif_link, NULL, mac_addr);
 }
@@ -4941,7 +4942,8 @@ void rtw89_core_scan_complete(struct rtw89_dev *rtwdev,
 
 	rtw89_chip_rfk_scan(rtwdev, rtwvif_link, false);
 	rtw89_btc_ntfy_scan_finish(rtwdev, rtwvif_link->phy_idx);
-	rtw89_phy_config_edcca(rtwdev, false);
+	bb = rtw89_get_bb_ctx(rtwdev, rtwvif_link->phy_idx);
+	rtw89_phy_config_edcca(rtwdev, bb, false);
 
 	rtwdev->scanning = false;
 	rtw89_for_each_active_bb(rtwdev, bb)
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 0523f97fb0e1..e4e9ae6e609b 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -4767,7 +4767,6 @@ struct rtw89_hal {
 	enum rtw89_entity_mode entity_mode;
 	struct rtw89_entity_mgnt entity_mgnt;
 
-	struct rtw89_edcca_bak edcca_bak;
 	u32 disabled_dm_bitmap; /* bitmap of enum rtw89_dm_type */
 
 	u8 thermal_prot_th;
@@ -5682,7 +5681,6 @@ struct rtw89_dev {
 	struct rtw89_power_trim_info pwr_trim;
 
 	struct rtw89_cfo_tracking_info cfo_tracking;
-	struct rtw89_phy_ch_info ch_info;
 	union {
 		struct rtw89_phy_bb_gain_info ax;
 		struct rtw89_phy_bb_gain_info_be be;
@@ -5696,6 +5694,7 @@ struct rtw89_dev {
 		struct rtw89_env_monitor_info env_monitor;
 		struct rtw89_dig_info dig;
 		struct rtw89_phy_ch_info ch_info;
+		struct rtw89_edcca_bak edcca_bak;
 	} bbs[RTW89_PHY_NUM];
 
 	struct delayed_work track_work;
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index e07f874590d2..f1029da4a78e 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -6584,10 +6584,13 @@ static void rtw89_phy_env_monitor_init(struct rtw89_dev *rtwdev)
 		__rtw89_phy_env_monitor_init(rtwdev, bb);
 }
 
-static void rtw89_phy_edcca_init(struct rtw89_dev *rtwdev)
+static void __rtw89_phy_edcca_init(struct rtw89_dev *rtwdev,
+				   struct rtw89_bb_ctx *bb)
 {
 	const struct rtw89_edcca_regs *edcca_regs = rtwdev->chip->edcca_regs;
-	struct rtw89_edcca_bak *edcca_bak = &rtwdev->hal.edcca_bak;
+	struct rtw89_edcca_bak *edcca_bak = &bb->edcca_bak;
+
+	rtw89_debug(rtwdev, RTW89_DBG_EDCCA, "BB-%d edcca init\n", bb->phy_idx);
 
 	memset(edcca_bak, 0, sizeof(*edcca_bak));
 
@@ -6603,8 +6606,16 @@ static void rtw89_phy_edcca_init(struct rtw89_dev *rtwdev)
 		rtw89_phy_set_phy_regs(rtwdev, R_DFS_FFT_CG, B_DFS_FFT_EN, 1);
 	}
 
-	rtw89_phy_write32_mask(rtwdev, edcca_regs->tx_collision_t2r_st,
-			       edcca_regs->tx_collision_t2r_st_mask, 0x29);
+	rtw89_phy_write32_idx(rtwdev, edcca_regs->tx_collision_t2r_st,
+			      edcca_regs->tx_collision_t2r_st_mask, 0x29, bb->phy_idx);
+}
+
+static void rtw89_phy_edcca_init(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_bb_ctx *bb;
+
+	rtw89_for_each_capab_bb(rtwdev, bb)
+		__rtw89_phy_edcca_init(rtwdev, bb);
 }
 
 void rtw89_phy_dm_init(struct rtw89_dev *rtwdev)
@@ -6967,42 +6978,43 @@ void rtw89_decode_chan_idx(struct rtw89_dev *rtwdev, u8 chan_idx,
 }
 EXPORT_SYMBOL(rtw89_decode_chan_idx);
 
-void rtw89_phy_config_edcca(struct rtw89_dev *rtwdev, bool scan)
+void rtw89_phy_config_edcca(struct rtw89_dev *rtwdev,
+			    struct rtw89_bb_ctx *bb, bool scan)
 {
 	const struct rtw89_edcca_regs *edcca_regs = rtwdev->chip->edcca_regs;
-	struct rtw89_edcca_bak *edcca_bak = &rtwdev->hal.edcca_bak;
+	struct rtw89_edcca_bak *edcca_bak = &bb->edcca_bak;
 
 	if (scan) {
 		edcca_bak->a =
-			rtw89_phy_read32_mask(rtwdev, edcca_regs->edcca_level,
-					      edcca_regs->edcca_mask);
+			rtw89_phy_read32_idx(rtwdev, edcca_regs->edcca_level,
+					     edcca_regs->edcca_mask, bb->phy_idx);
 		edcca_bak->p =
-			rtw89_phy_read32_mask(rtwdev, edcca_regs->edcca_level,
-					      edcca_regs->edcca_p_mask);
+			rtw89_phy_read32_idx(rtwdev, edcca_regs->edcca_level,
+					     edcca_regs->edcca_p_mask, bb->phy_idx);
 		edcca_bak->ppdu =
-			rtw89_phy_read32_mask(rtwdev, edcca_regs->ppdu_level,
-					      edcca_regs->ppdu_mask);
-
-		rtw89_phy_write32_mask(rtwdev, edcca_regs->edcca_level,
-				       edcca_regs->edcca_mask, EDCCA_MAX);
-		rtw89_phy_write32_mask(rtwdev, edcca_regs->edcca_level,
-				       edcca_regs->edcca_p_mask, EDCCA_MAX);
-		rtw89_phy_write32_mask(rtwdev, edcca_regs->ppdu_level,
-				       edcca_regs->ppdu_mask, EDCCA_MAX);
+			rtw89_phy_read32_idx(rtwdev, edcca_regs->ppdu_level,
+					     edcca_regs->ppdu_mask, bb->phy_idx);
+
+		rtw89_phy_write32_idx(rtwdev, edcca_regs->edcca_level,
+				      edcca_regs->edcca_mask, EDCCA_MAX, bb->phy_idx);
+		rtw89_phy_write32_idx(rtwdev, edcca_regs->edcca_level,
+				      edcca_regs->edcca_p_mask, EDCCA_MAX, bb->phy_idx);
+		rtw89_phy_write32_idx(rtwdev, edcca_regs->ppdu_level,
+				      edcca_regs->ppdu_mask, EDCCA_MAX, bb->phy_idx);
 	} else {
-		rtw89_phy_write32_mask(rtwdev, edcca_regs->edcca_level,
-				       edcca_regs->edcca_mask,
-				       edcca_bak->a);
-		rtw89_phy_write32_mask(rtwdev, edcca_regs->edcca_level,
-				       edcca_regs->edcca_p_mask,
-				       edcca_bak->p);
-		rtw89_phy_write32_mask(rtwdev, edcca_regs->ppdu_level,
-				       edcca_regs->ppdu_mask,
-				       edcca_bak->ppdu);
+		rtw89_phy_write32_idx(rtwdev, edcca_regs->edcca_level,
+				      edcca_regs->edcca_mask,
+				      edcca_bak->a, bb->phy_idx);
+		rtw89_phy_write32_idx(rtwdev, edcca_regs->edcca_level,
+				      edcca_regs->edcca_p_mask,
+				      edcca_bak->p, bb->phy_idx);
+		rtw89_phy_write32_idx(rtwdev, edcca_regs->ppdu_level,
+				      edcca_regs->ppdu_mask,
+				      edcca_bak->ppdu, bb->phy_idx);
 	}
 }
 
-static void rtw89_phy_edcca_log(struct rtw89_dev *rtwdev)
+static void rtw89_phy_edcca_log(struct rtw89_dev *rtwdev, struct rtw89_bb_ctx *bb)
 {
 	const struct rtw89_edcca_regs *edcca_regs = rtwdev->chip->edcca_regs;
 	bool flag_fb, flag_p20, flag_s20, flag_s40, flag_s80;
@@ -7099,9 +7111,10 @@ static void rtw89_phy_edcca_log(struct rtw89_dev *rtwdev)
 		    pwdb_fb, pwdb_p20, pwdb_s20, pwdb_s40, pwdb_s80);
 }
 
-static u8 rtw89_phy_edcca_get_thre_by_rssi(struct rtw89_dev *rtwdev)
+static u8 rtw89_phy_edcca_get_thre_by_rssi(struct rtw89_dev *rtwdev,
+					   struct rtw89_bb_ctx *bb)
 {
-	struct rtw89_phy_ch_info *ch_info = &rtwdev->ch_info;
+	struct rtw89_phy_ch_info *ch_info = &bb->ch_info;
 	bool is_linked = rtwdev->total_sta_assoc > 0;
 	u8 rssi_min = ch_info->rssi_min >> 1;
 	u8 edcca_thre;
@@ -7117,13 +7130,13 @@ static u8 rtw89_phy_edcca_get_thre_by_rssi(struct rtw89_dev *rtwdev)
 	return edcca_thre;
 }
 
-void rtw89_phy_edcca_thre_calc(struct rtw89_dev *rtwdev)
+void rtw89_phy_edcca_thre_calc(struct rtw89_dev *rtwdev, struct rtw89_bb_ctx *bb)
 {
 	const struct rtw89_edcca_regs *edcca_regs = rtwdev->chip->edcca_regs;
-	struct rtw89_edcca_bak *edcca_bak = &rtwdev->hal.edcca_bak;
+	struct rtw89_edcca_bak *edcca_bak = &bb->edcca_bak;
 	u8 th;
 
-	th = rtw89_phy_edcca_get_thre_by_rssi(rtwdev);
+	th = rtw89_phy_edcca_get_thre_by_rssi(rtwdev, bb);
 	if (th == edcca_bak->th_old)
 		return;
 
@@ -7132,23 +7145,33 @@ void rtw89_phy_edcca_thre_calc(struct rtw89_dev *rtwdev)
 	rtw89_debug(rtwdev, RTW89_DBG_EDCCA,
 		    "[EDCCA]: Normal Mode, EDCCA_th = %d\n", th);
 
-	rtw89_phy_write32_mask(rtwdev, edcca_regs->edcca_level,
-			       edcca_regs->edcca_mask, th);
-	rtw89_phy_write32_mask(rtwdev, edcca_regs->edcca_level,
-			       edcca_regs->edcca_p_mask, th);
-	rtw89_phy_write32_mask(rtwdev, edcca_regs->ppdu_level,
-			       edcca_regs->ppdu_mask, th);
+	rtw89_phy_write32_idx(rtwdev, edcca_regs->edcca_level,
+			      edcca_regs->edcca_mask, th, bb->phy_idx);
+	rtw89_phy_write32_idx(rtwdev, edcca_regs->edcca_level,
+			      edcca_regs->edcca_p_mask, th, bb->phy_idx);
+	rtw89_phy_write32_idx(rtwdev, edcca_regs->ppdu_level,
+			      edcca_regs->ppdu_mask, th, bb->phy_idx);
+}
+
+static
+void __rtw89_phy_edcca_track(struct rtw89_dev *rtwdev, struct rtw89_bb_ctx *bb)
+{
+	rtw89_debug(rtwdev, RTW89_DBG_EDCCA, "BB-%d edcca track\n", bb->phy_idx);
+
+	rtw89_phy_edcca_thre_calc(rtwdev, bb);
+	rtw89_phy_edcca_log(rtwdev, bb);
 }
 
 void rtw89_phy_edcca_track(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_hal *hal = &rtwdev->hal;
+	struct rtw89_bb_ctx *bb;
 
 	if (hal->disabled_dm_bitmap & BIT(RTW89_DM_DYNAMIC_EDCCA))
 		return;
 
-	rtw89_phy_edcca_thre_calc(rtwdev);
-	rtw89_phy_edcca_log(rtwdev);
+	rtw89_for_each_active_bb(rtwdev, bb)
+		__rtw89_phy_edcca_track(rtwdev, bb);
 }
 
 enum rtw89_rf_path_bit rtw89_phy_get_kpath(struct rtw89_dev *rtwdev,
diff --git a/drivers/net/wireless/realtek/rtw89/phy.h b/drivers/net/wireless/realtek/rtw89/phy.h
index db748c7453cd..33d466c519e3 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.h
+++ b/drivers/net/wireless/realtek/rtw89/phy.h
@@ -1002,9 +1002,10 @@ void rtw89_phy_ul_tb_ctrl_track(struct rtw89_dev *rtwdev);
 u8 rtw89_encode_chan_idx(struct rtw89_dev *rtwdev, u8 central_ch, u8 band);
 void rtw89_decode_chan_idx(struct rtw89_dev *rtwdev, u8 chan_idx,
 			   u8 *ch, enum nl80211_band *band);
-void rtw89_phy_config_edcca(struct rtw89_dev *rtwdev, bool scan);
+void rtw89_phy_config_edcca(struct rtw89_dev *rtwdev,
+			    struct rtw89_bb_ctx *bb, bool scan);
 void rtw89_phy_edcca_track(struct rtw89_dev *rtwdev);
-void rtw89_phy_edcca_thre_calc(struct rtw89_dev *rtwdev);
+void rtw89_phy_edcca_thre_calc(struct rtw89_dev *rtwdev, struct rtw89_bb_ctx *bb);
 enum rtw89_rf_path_bit rtw89_phy_get_kpath(struct rtw89_dev *rtwdev,
 					   enum rtw89_phy_idx phy_idx);
 enum rtw89_rf_path rtw89_phy_get_syn_sel(struct rtw89_dev *rtwdev,
-- 
2.25.1


