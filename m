Return-Path: <linux-wireless+bounces-13136-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 291EF9850CE
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Sep 2024 04:02:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49C971C235EB
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Sep 2024 02:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E243C1EEE9;
	Wed, 25 Sep 2024 02:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="jrqAI7sO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E940F1494B5
	for <linux-wireless@vger.kernel.org>; Wed, 25 Sep 2024 02:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727229729; cv=none; b=ntjm/lPM44YHZ9UgKR+lo37zPjX9qhvQx2b02PdxUcjsPOcVzvNP0AnzzjKXdTs/69iAVgDDu57K2ZA5uj9f112rHY53vmRXKBvQxT3pDlRLBhl6RmhyQslHuFDMR9OaVG+apmC+CYRP8baZ6F5iUOypanePbcPzP0XpgUv1MkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727229729; c=relaxed/simple;
	bh=eg+Iiv7QTmd2ClJ9HmVBNtWU/ZDRJ7mumzfjkGOBbuE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iSx7lhrcoytr0GW4znUnkkNMafxZVkvnQtsk+OV0BIlKvpTDyIqA+juh+pTxOD7reWxXMvXtIbyLQ5xACcJubfuGM8ZtZA6cDz/QCRuEq2RQGePjGdWzt1q3XJI2+y78vcoocfBnK9mRfRs/1iX4VoCZqz0MS7LcdZLIGOHlPlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=jrqAI7sO; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 48P224EX03860270, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1727229724; bh=eg+Iiv7QTmd2ClJ9HmVBNtWU/ZDRJ7mumzfjkGOBbuE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=jrqAI7sOyH4lYo3Yod6vmYkGdpbzktNbfyt+1p+SlKiR8y141hvHIWpgPev7gqvI2
	 ypZ5NZW+sS7Z3VR63OPII95BIopg89bfSQln3dtSm3B/UWDrR7UlWBJAIVE3qa1E/m
	 S45B78hQE3jpi1S+Th1fmLJDwH1J6SDV+2cHuTm0QYB3v8iQeHTBHfIn4Lp+qGWAD6
	 LySJzrgKyXrK8xILNTgflFWzwk9SXnkHAou112lmlh8GZhekmQ1V92L72Q3gnN6aPV
	 8sntG4YqoRL3SP0dPnxSVYB7V1j4gb5E2RBc/W5YRmrSux/G/Uga+bK6u/Kg5W0XMT
	 x+nzWG/7loBTw==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.05/5.92) with ESMTPS id 48P224EX03860270
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 25 Sep 2024 10:02:04 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 25 Sep 2024 10:02:05 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 25 Sep
 2024 10:02:04 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <kevin_yang@realtek.com>
Subject: [PATCH 1/2] wifi: rtw89: initialize dual HW bands for MLO and control them by link
Date: Wed, 25 Sep 2024 10:01:18 +0800
Message-ID: <20240925020119.13170-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240925020119.13170-1-pkshih@realtek.com>
References: <20240925020119.13170-1-pkshih@realtek.com>
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

To support MLO, we initialize things on dual HW bands of Wi-Fi 7 chip.
And, each link will indicate which HW band it's bound to. So, in link
control flow, we control major things based on target link's HW band
instead of hardcode like RTW89_PHY_X or RTW89_MAC_X.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c     | 22 ++---
 drivers/net/wireless/realtek/rtw89/core.h     | 19 +++-
 drivers/net/wireless/realtek/rtw89/fw.c       | 33 ++++---
 drivers/net/wireless/realtek/rtw89/fw.h       |  4 -
 drivers/net/wireless/realtek/rtw89/mac.c      | 12 ++-
 drivers/net/wireless/realtek/rtw89/mac.h      | 17 +++-
 drivers/net/wireless/realtek/rtw89/mac80211.c |  2 +-
 drivers/net/wireless/realtek/rtw89/mac_be.c   |  2 +-
 drivers/net/wireless/realtek/rtw89/phy.c      | 90 +++++++++++++------
 drivers/net/wireless/realtek/rtw89/phy.h      |  4 +
 drivers/net/wireless/realtek/rtw89/phy_be.c   | 12 ++-
 drivers/net/wireless/realtek/rtw89/rtw8922a.c | 17 +++-
 12 files changed, 162 insertions(+), 72 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 5b8e65f6de6a..6200755b5ce9 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -3150,6 +3150,7 @@ void rtw89_roc_start(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
 	struct rtw89_vif_link *rtwvif_link;
 	struct cfg80211_chan_def roc_chan;
 	struct rtw89_vif *tmp_vif;
+	u32 reg;
 	int ret;
 
 	lockdep_assert_held(&rtwdev->mutex);
@@ -3185,9 +3186,9 @@ void rtw89_roc_start(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
 	cfg80211_chandef_create(&roc_chan, &roc->chan, NL80211_CHAN_NO_HT);
 	rtw89_config_roc_chandef(rtwdev, rtwvif_link->chanctx_idx, &roc_chan);
 	rtw89_set_channel(rtwdev);
-	rtw89_write32_clr(rtwdev,
-			  rtw89_mac_reg_by_idx(rtwdev, mac->rx_fltr, RTW89_MAC_0),
-			  B_AX_A_UC_CAM_MATCH | B_AX_A_BC_CAM_MATCH);
+
+	reg = rtw89_mac_reg_by_idx(rtwdev, mac->rx_fltr, rtwvif_link->mac_idx);
+	rtw89_write32_clr(rtwdev, reg, B_AX_A_UC_CAM_MATCH | B_AX_A_BC_CAM_MATCH);
 
 	ieee80211_ready_on_channel(hw);
 	cancel_delayed_work(&rtwvif->roc.roc_work);
@@ -3202,6 +3203,7 @@ void rtw89_roc_end(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
 	struct rtw89_roc *roc = &rtwvif->roc;
 	struct rtw89_vif_link *rtwvif_link;
 	struct rtw89_vif *tmp_vif;
+	u32 reg;
 	int ret;
 
 	lockdep_assert_held(&rtwdev->mutex);
@@ -3217,10 +3219,8 @@ void rtw89_roc_end(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
 		return;
 	}
 
-	rtw89_write32_mask(rtwdev,
-			   rtw89_mac_reg_by_idx(rtwdev, mac->rx_fltr, RTW89_MAC_0),
-			   B_AX_RX_FLTR_CFG_MASK,
-			   rtwdev->hal.rx_fltr);
+	reg = rtw89_mac_reg_by_idx(rtwdev, mac->rx_fltr, rtwvif_link->mac_idx);
+	rtw89_write32_mask(rtwdev, reg, B_AX_RX_FLTR_CFG_MASK, rtwdev->hal.rx_fltr);
 
 	roc->state = RTW89_ROC_IDLE;
 	rtw89_config_roc_chandef(rtwdev, rtwvif_link->chanctx_idx, NULL);
@@ -4399,8 +4399,8 @@ int rtw89_core_start(struct rtw89_dev *rtwdev)
 
 	rtw89_phy_dm_init(rtwdev);
 
-	rtw89_mac_cfg_ppdu_status(rtwdev, RTW89_MAC_0, true);
-	rtw89_mac_update_rts_threshold(rtwdev, RTW89_MAC_0);
+	rtw89_mac_cfg_ppdu_status_bands(rtwdev, true);
+	rtw89_mac_update_rts_threshold(rtwdev);
 
 	rtw89_tas_reset(rtwdev);
 
@@ -4751,7 +4751,7 @@ void rtw89_core_scan_start(struct rtw89_dev *rtwdev, struct rtw89_vif_link *rtwv
 		rtw89_leave_ips_by_hwflags(rtwdev);
 
 	ether_addr_copy(rtwvif_link->mac_addr, mac_addr);
-	rtw89_btc_ntfy_scan_start(rtwdev, RTW89_PHY_0, chan->band_type);
+	rtw89_btc_ntfy_scan_start(rtwdev, rtwvif_link->phy_idx, chan->band_type);
 	rtw89_chip_rfk_scan(rtwdev, rtwvif_link, true);
 	rtw89_hci_recalc_int_mit(rtwdev);
 	rtw89_phy_config_edcca(rtwdev, true);
@@ -4777,7 +4777,7 @@ void rtw89_core_scan_complete(struct rtw89_dev *rtwdev,
 	rtw89_fw_h2c_cam(rtwdev, rtwvif_link, NULL, NULL);
 
 	rtw89_chip_rfk_scan(rtwdev, rtwvif_link, false);
-	rtw89_btc_ntfy_scan_finish(rtwdev, RTW89_PHY_0);
+	rtw89_btc_ntfy_scan_finish(rtwdev, rtwvif_link->phy_idx);
 	rtw89_phy_config_edcca(rtwdev, false);
 
 	rtwdev->scanning = false;
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index ac9f9d33436c..f1f10b7b0731 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -6484,8 +6484,12 @@ static inline void rtw89_chip_set_txpwr_ctrl(struct rtw89_dev *rtwdev)
 {
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 
-	if (chip->ops->set_txpwr_ctrl)
-		chip->ops->set_txpwr_ctrl(rtwdev,  RTW89_PHY_0);
+	if (!chip->ops->set_txpwr_ctrl)
+		return;
+
+	chip->ops->set_txpwr_ctrl(rtwdev,  RTW89_PHY_0);
+	if (rtwdev->dbcc_en)
+		chip->ops->set_txpwr_ctrl(rtwdev,  RTW89_PHY_1);
 }
 
 static inline void rtw89_chip_power_trim(struct rtw89_dev *rtwdev)
@@ -6496,8 +6500,8 @@ static inline void rtw89_chip_power_trim(struct rtw89_dev *rtwdev)
 		chip->ops->power_trim(rtwdev);
 }
 
-static inline void rtw89_chip_init_txpwr_unit(struct rtw89_dev *rtwdev,
-					      enum rtw89_phy_idx phy_idx)
+static inline void __rtw89_chip_init_txpwr_unit(struct rtw89_dev *rtwdev,
+						enum rtw89_phy_idx phy_idx)
 {
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 
@@ -6505,6 +6509,13 @@ static inline void rtw89_chip_init_txpwr_unit(struct rtw89_dev *rtwdev,
 		chip->ops->init_txpwr_unit(rtwdev, phy_idx);
 }
 
+static inline void rtw89_chip_init_txpwr_unit(struct rtw89_dev *rtwdev)
+{
+	__rtw89_chip_init_txpwr_unit(rtwdev, RTW89_PHY_0);
+	if (rtwdev->dbcc_en)
+		__rtw89_chip_init_txpwr_unit(rtwdev, RTW89_PHY_1);
+}
+
 static inline u8 rtw89_chip_get_thermal(struct rtw89_dev *rtwdev,
 					enum rtw89_rf_path rf_path)
 {
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 3c4a3302d43d..3f73a5853959 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -4761,6 +4761,7 @@ int rtw89_fw_h2c_add_pkt_offload(struct rtw89_dev *rtwdev, u8 *id,
 	return 0;
 }
 
+static
 int rtw89_fw_h2c_scan_list_offload(struct rtw89_dev *rtwdev, int ch_num,
 				   struct list_head *chan_list)
 {
@@ -4832,8 +4833,10 @@ int rtw89_fw_h2c_scan_list_offload(struct rtw89_dev *rtwdev, int ch_num,
 	return 0;
 }
 
+static
 int rtw89_fw_h2c_scan_list_offload_be(struct rtw89_dev *rtwdev, int ch_num,
-				      struct list_head *chan_list)
+				      struct list_head *chan_list,
+				      struct rtw89_vif_link *rtwvif_link)
 {
 	struct rtw89_wait_info *wait = &rtwdev->mac.fw_ofld_wait;
 	struct rtw89_h2c_chinfo_elem_be *elem;
@@ -4858,7 +4861,8 @@ int rtw89_fw_h2c_scan_list_offload_be(struct rtw89_dev *rtwdev, int ch_num,
 
 	h2c->ch_num = ch_num;
 	h2c->elem_size = sizeof(*elem) / 4; /* in unit of 4 bytes */
-	h2c->arg = u8_encode_bits(RTW89_PHY_0, RTW89_H2C_CHINFO_ARG_MAC_IDX_MASK);
+	h2c->arg = u8_encode_bits(rtwvif_link->mac_idx,
+				  RTW89_H2C_CHINFO_ARG_MAC_IDX_MASK);
 
 	list_for_each_entry(ch_info, chan_list, list) {
 		elem = (struct rtw89_h2c_chinfo_elem_be *)skb_put(skb, sizeof(*elem));
@@ -4965,7 +4969,7 @@ int rtw89_fw_h2c_scan_offload_ax(struct rtw89_dev *rtwdev,
 
 	h2c->w0 = le32_encode_bits(rtwvif_link->mac_id, RTW89_H2C_SCANOFLD_W0_MACID) |
 		  le32_encode_bits(rtwvif_link->port, RTW89_H2C_SCANOFLD_W0_PORT_ID) |
-		  le32_encode_bits(RTW89_PHY_0, RTW89_H2C_SCANOFLD_W0_BAND) |
+		  le32_encode_bits(rtwvif_link->mac_idx, RTW89_H2C_SCANOFLD_W0_BAND) |
 		  le32_encode_bits(option->enable, RTW89_H2C_SCANOFLD_W0_OPERATION);
 
 	h2c->w1 = le32_encode_bits(true, RTW89_H2C_SCANOFLD_W1_NOTIFY_END) |
@@ -6521,7 +6525,8 @@ int rtw89_pno_scan_add_chan_list_be(struct rtw89_dev *rtwdev,
 		list_add_tail(&ch_info->list, &chan_list);
 	}
 
-	ret = rtw89_fw_h2c_scan_list_offload_be(rtwdev, list_len, &chan_list);
+	ret = rtw89_fw_h2c_scan_list_offload_be(rtwdev, list_len, &chan_list,
+						rtwvif_link);
 
 out:
 	list_for_each_entry_safe(ch_info, tmp, &chan_list, list) {
@@ -6581,7 +6586,8 @@ int rtw89_hw_scan_add_chan_list_be(struct rtw89_dev *rtwdev,
 	}
 
 	rtwdev->scan_info.last_chan_idx = idx;
-	ret = rtw89_fw_h2c_scan_list_offload_be(rtwdev, list_len, &chan_list);
+	ret = rtw89_fw_h2c_scan_list_offload_be(rtwdev, list_len, &chan_list,
+						rtwvif_link);
 
 out:
 	list_for_each_entry_safe(ch_info, tmp, &chan_list, list) {
@@ -6619,6 +6625,7 @@ void rtw89_hw_scan_start(struct rtw89_dev *rtwdev,
 	struct rtw89_vif *rtwvif = rtwvif_link->rtwvif;
 	u32 rx_fltr = rtwdev->hal.rx_fltr;
 	u8 mac_addr[ETH_ALEN];
+	u32 reg;
 
 	/* clone op and keep it during scan */
 	rtwdev->scan_info.op_chan = *chan;
@@ -6641,10 +6648,9 @@ void rtw89_hw_scan_start(struct rtw89_dev *rtwdev,
 	rx_fltr &= ~B_AX_A_BCN_CHK_EN;
 	rx_fltr &= ~B_AX_A_BC;
 	rx_fltr &= ~B_AX_A_A1_MATCH;
-	rtw89_write32_mask(rtwdev,
-			   rtw89_mac_reg_by_idx(rtwdev, mac->rx_fltr, RTW89_MAC_0),
-			   B_AX_RX_FLTR_CFG_MASK,
-			   rx_fltr);
+
+	reg = rtw89_mac_reg_by_idx(rtwdev, mac->rx_fltr, rtwvif_link->mac_idx);
+	rtw89_write32_mask(rtwdev, reg, B_AX_RX_FLTR_CFG_MASK, rx_fltr);
 
 	rtw89_chanctx_pause(rtwdev, RTW89_CHANCTX_PAUSE_REASON_HW_SCAN);
 }
@@ -6659,16 +6665,15 @@ void rtw89_hw_scan_complete(struct rtw89_dev *rtwdev,
 		.aborted = aborted,
 	};
 	struct rtw89_vif *rtwvif;
+	u32 reg;
 
 	if (!rtwvif_link)
 		return;
 
 	rtwvif = rtwvif_link->rtwvif;
 
-	rtw89_write32_mask(rtwdev,
-			   rtw89_mac_reg_by_idx(rtwdev, mac->rx_fltr, RTW89_MAC_0),
-			   B_AX_RX_FLTR_CFG_MASK,
-			   rtwdev->hal.rx_fltr);
+	reg = rtw89_mac_reg_by_idx(rtwdev, mac->rx_fltr, rtwvif_link->mac_idx);
+	rtw89_write32_mask(rtwdev, reg, B_AX_RX_FLTR_CFG_MASK, rtwdev->hal.rx_fltr);
 
 	rtw89_core_scan_complete(rtwdev, rtwvif_link, true);
 	ieee80211_scan_completed(rtwdev->hw, &info);
@@ -6747,7 +6752,7 @@ int rtw89_hw_scan_offload(struct rtw89_dev *rtwdev,
 	if (rtwdev->chip->chip_gen == RTW89_CHIP_BE) {
 		opt.operation = enable ? RTW89_SCAN_OP_START : RTW89_SCAN_OP_STOP;
 		opt.scan_mode = RTW89_SCAN_MODE_SA;
-		opt.band = RTW89_PHY_0;
+		opt.band = rtwvif_link->mac_idx;
 		opt.num_macc_role = 0;
 		opt.mlo_mode = rtwdev->mlo_dbcc_mode;
 		opt.num_opch = connected ? 1 : 0;
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index a083bed3822b..d338c3aec725 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -4527,10 +4527,6 @@ int rtw89_fw_h2c_cxdrv_rfk(struct rtw89_dev *rtwdev, u8 type);
 int rtw89_fw_h2c_del_pkt_offload(struct rtw89_dev *rtwdev, u8 id);
 int rtw89_fw_h2c_add_pkt_offload(struct rtw89_dev *rtwdev, u8 *id,
 				 struct sk_buff *skb_ofld);
-int rtw89_fw_h2c_scan_list_offload(struct rtw89_dev *rtwdev, int ch_num,
-				   struct list_head *chan_list);
-int rtw89_fw_h2c_scan_list_offload_be(struct rtw89_dev *rtwdev, int ch_num,
-				      struct list_head *chan_list);
 int rtw89_fw_h2c_scan_offload_ax(struct rtw89_dev *rtwdev,
 				 struct rtw89_scan_option *opt,
 				 struct rtw89_vif_link *vif,
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 4e15d539e3d1..6a0262e512ea 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -5543,7 +5543,8 @@ int rtw89_mac_cfg_ppdu_status_ax(struct rtw89_dev *rtwdev, u8 mac_idx, bool enab
 	return 0;
 }
 
-void rtw89_mac_update_rts_threshold(struct rtw89_dev *rtwdev, u8 mac_idx)
+static
+void __rtw89_mac_update_rts_threshold(struct rtw89_dev *rtwdev, u8 mac_idx)
 {
 #define MAC_AX_TIME_TH_SH  5
 #define MAC_AX_LEN_TH_SH   4
@@ -5573,6 +5574,13 @@ void rtw89_mac_update_rts_threshold(struct rtw89_dev *rtwdev, u8 mac_idx)
 	rtw89_write16_mask(rtwdev, reg, B_AX_RTS_LEN_TH_MASK, len_th);
 }
 
+void rtw89_mac_update_rts_threshold(struct rtw89_dev *rtwdev)
+{
+	__rtw89_mac_update_rts_threshold(rtwdev, RTW89_MAC_0);
+	if (rtwdev->dbcc_en)
+		__rtw89_mac_update_rts_threshold(rtwdev, RTW89_MAC_1);
+}
+
 void rtw89_mac_flush_txq(struct rtw89_dev *rtwdev, u32 queues, bool drop)
 {
 	bool empty;
@@ -6446,7 +6454,7 @@ void rtw89_mac_pkt_drop_sta(struct rtw89_dev *rtwdev,
 	struct rtw89_pkt_drop_params params = {0};
 	int i;
 
-	params.mac_band = RTW89_MAC_0;
+	params.mac_band = rtwvif_link->mac_idx;
 	params.macid = rtwsta_link->mac_id;
 	params.port = rtwvif_link->port;
 	params.mbssid = 0;
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index 0c269961a573..e59c1fcfea46 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -1222,7 +1222,22 @@ int rtw89_mac_cfg_ppdu_status(struct rtw89_dev *rtwdev, u8 mac_idx, bool enable)
 	return mac->cfg_ppdu_status(rtwdev, mac_idx, enable);
 }
 
-void rtw89_mac_update_rts_threshold(struct rtw89_dev *rtwdev, u8 mac_idx);
+static inline
+int rtw89_mac_cfg_ppdu_status_bands(struct rtw89_dev *rtwdev, bool enable)
+{
+	int ret;
+
+	ret = rtw89_mac_cfg_ppdu_status(rtwdev, RTW89_MAC_0, enable);
+	if (ret)
+		return ret;
+
+	if (!rtwdev->dbcc_en)
+		return 0;
+
+	return rtw89_mac_cfg_ppdu_status(rtwdev, RTW89_MAC_1, enable);
+}
+
+void rtw89_mac_update_rts_threshold(struct rtw89_dev *rtwdev);
 void rtw89_mac_flush_txq(struct rtw89_dev *rtwdev, u32 queues, bool drop);
 int rtw89_mac_coex_init(struct rtw89_dev *rtwdev, const struct rtw89_mac_ax_coex *coex);
 int rtw89_mac_coex_init_v1(struct rtw89_dev *rtwdev,
diff --git a/drivers/net/wireless/realtek/rtw89/mac80211.c b/drivers/net/wireless/realtek/rtw89/mac80211.c
index 44ba4dc181b5..1ee63a85308f 100644
--- a/drivers/net/wireless/realtek/rtw89/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw89/mac80211.c
@@ -1031,7 +1031,7 @@ static int rtw89_ops_set_rts_threshold(struct ieee80211_hw *hw, u32 value)
 	mutex_lock(&rtwdev->mutex);
 	rtw89_leave_ps_mode(rtwdev);
 	if (test_bit(RTW89_FLAG_POWERON, rtwdev->flags))
-		rtw89_mac_update_rts_threshold(rtwdev, RTW89_MAC_0);
+		rtw89_mac_update_rts_threshold(rtwdev);
 	mutex_unlock(&rtwdev->mutex);
 
 	return 0;
diff --git a/drivers/net/wireless/realtek/rtw89/mac_be.c b/drivers/net/wireless/realtek/rtw89/mac_be.c
index f22eaa83297f..30943462640f 100644
--- a/drivers/net/wireless/realtek/rtw89/mac_be.c
+++ b/drivers/net/wireless/realtek/rtw89/mac_be.c
@@ -773,7 +773,7 @@ static int dmac_init_be(struct rtw89_dev *rtwdev, u8 mac_idx)
 		return ret;
 	}
 
-	ret = rtw89_mac_preload_init(rtwdev, RTW89_MAC_0, rtwdev->mac.qta_mode);
+	ret = rtw89_mac_preload_init(rtwdev, mac_idx, rtwdev->mac.qta_mode);
 	if (ret) {
 		rtw89_err(rtwdev, "[ERR]preload init %d\n", ret);
 		return ret;
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index 1527b08e0c92..7f90316a0f2f 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -1114,14 +1114,21 @@ static bool rtw89_chip_rf_v1(struct rtw89_dev *rtwdev)
 	return rtwdev->chip->ops->write_rf == rtw89_phy_write_rf_v1;
 }
 
-static void rtw89_phy_bb_reset(struct rtw89_dev *rtwdev,
-			       enum rtw89_phy_idx phy_idx)
+static void __rtw89_phy_bb_reset(struct rtw89_dev *rtwdev,
+				 enum rtw89_phy_idx phy_idx)
 {
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 
 	chip->ops->bb_reset(rtwdev, phy_idx);
 }
 
+static void rtw89_phy_bb_reset(struct rtw89_dev *rtwdev)
+{
+	__rtw89_phy_bb_reset(rtwdev, RTW89_PHY_0);
+	if (rtwdev->dbcc_en)
+		__rtw89_phy_bb_reset(rtwdev, RTW89_PHY_1);
+}
+
 static void rtw89_phy_config_bb_reg(struct rtw89_dev *rtwdev,
 				    const struct rtw89_reg2_def *reg,
 				    enum rtw89_rf_path rf_path,
@@ -1667,13 +1674,15 @@ void rtw89_phy_init_bb_reg(struct rtw89_dev *rtwdev)
 	if (rtwdev->dbcc_en)
 		rtw89_phy_init_reg(rtwdev, bb_table, rtw89_phy_config_bb_reg,
 				   (void *)RTW89_PHY_1);
-	rtw89_chip_init_txpwr_unit(rtwdev, RTW89_PHY_0);
+
+	rtw89_chip_init_txpwr_unit(rtwdev);
 
 	bb_gain_table = elm_info->bb_gain ? elm_info->bb_gain : chip->bb_gain_table;
 	if (bb_gain_table)
 		rtw89_phy_init_reg(rtwdev, bb_gain_table,
 				   chip->phy_def->config_bb_gain, NULL);
-	rtw89_phy_bb_reset(rtwdev, RTW89_PHY_0);
+
+	rtw89_phy_bb_reset(rtwdev);
 }
 
 static u32 rtw89_phy_nctl_poll(struct rtw89_dev *rtwdev)
@@ -1793,6 +1802,24 @@ void rtw89_phy_write32_idx(struct rtw89_dev *rtwdev, u32 addr, u32 mask,
 }
 EXPORT_SYMBOL(rtw89_phy_write32_idx);
 
+void rtw89_phy_write32_idx_set(struct rtw89_dev *rtwdev, u32 addr, u32 bits,
+			       enum rtw89_phy_idx phy_idx)
+{
+	if (rtwdev->dbcc_en && phy_idx == RTW89_PHY_1)
+		addr += rtw89_phy0_phy1_offset(rtwdev, addr);
+	rtw89_phy_write32_set(rtwdev, addr, bits);
+}
+EXPORT_SYMBOL(rtw89_phy_write32_idx_set);
+
+void rtw89_phy_write32_idx_clr(struct rtw89_dev *rtwdev, u32 addr, u32 bits,
+			       enum rtw89_phy_idx phy_idx)
+{
+	if (rtwdev->dbcc_en && phy_idx == RTW89_PHY_1)
+		addr += rtw89_phy0_phy1_offset(rtwdev, addr);
+	rtw89_phy_write32_clr(rtwdev, addr, bits);
+}
+EXPORT_SYMBOL(rtw89_phy_write32_idx_clr);
+
 u32 rtw89_phy_read32_idx(struct rtw89_dev *rtwdev, u32 addr, u32 mask,
 			 enum rtw89_phy_idx phy_idx)
 {
@@ -5406,7 +5433,8 @@ static u32 rtw89_phy_get_ie_bitmap_addr(enum rtw89_phy_status_bitmap ie_page)
 }
 
 static u32 rtw89_physts_get_ie_bitmap(struct rtw89_dev *rtwdev,
-				      enum rtw89_phy_status_bitmap ie_page)
+				      enum rtw89_phy_status_bitmap ie_page,
+				      enum rtw89_phy_idx phy_idx)
 {
 	u32 addr;
 
@@ -5415,12 +5443,12 @@ static u32 rtw89_physts_get_ie_bitmap(struct rtw89_dev *rtwdev,
 
 	addr = rtw89_phy_get_ie_bitmap_addr(ie_page);
 
-	return rtw89_phy_read32(rtwdev, addr);
+	return rtw89_phy_read32_idx(rtwdev, addr, MASKDWORD, phy_idx);
 }
 
 static void rtw89_physts_set_ie_bitmap(struct rtw89_dev *rtwdev,
 				       enum rtw89_phy_status_bitmap ie_page,
-				       u32 val)
+				       u32 val, enum rtw89_phy_idx phy_idx)
 {
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 	u32 addr;
@@ -5432,22 +5460,22 @@ static void rtw89_physts_set_ie_bitmap(struct rtw89_dev *rtwdev,
 		val &= B_PHY_STS_BITMAP_MSK_52A;
 
 	addr = rtw89_phy_get_ie_bitmap_addr(ie_page);
-	rtw89_phy_write32(rtwdev, addr, val);
+	rtw89_phy_write32_idx(rtwdev, addr, MASKDWORD, val, phy_idx);
 }
 
 static void rtw89_physts_enable_ie_bitmap(struct rtw89_dev *rtwdev,
 					  enum rtw89_phy_status_bitmap bitmap,
 					  enum rtw89_phy_status_ie_type ie,
-					  bool enable)
+					  bool enable, enum rtw89_phy_idx phy_idx)
 {
-	u32 val = rtw89_physts_get_ie_bitmap(rtwdev, bitmap);
+	u32 val = rtw89_physts_get_ie_bitmap(rtwdev, bitmap, phy_idx);
 
 	if (enable)
 		val |= BIT(ie);
 	else
 		val &= ~BIT(ie);
 
-	rtw89_physts_set_ie_bitmap(rtwdev, bitmap, val);
+	rtw89_physts_set_ie_bitmap(rtwdev, bitmap, val, phy_idx);
 }
 
 static void rtw89_physts_enable_fail_report(struct rtw89_dev *rtwdev,
@@ -5458,44 +5486,52 @@ static void rtw89_physts_enable_fail_report(struct rtw89_dev *rtwdev,
 	const struct rtw89_physts_regs *physts = phy->physts;
 
 	if (enable) {
-		rtw89_phy_write32_clr(rtwdev, physts->setting_addr,
-				      physts->dis_trigger_fail_mask);
-		rtw89_phy_write32_clr(rtwdev, physts->setting_addr,
-				      physts->dis_trigger_brk_mask);
+		rtw89_phy_write32_idx_clr(rtwdev, physts->setting_addr,
+					  physts->dis_trigger_fail_mask, phy_idx);
+		rtw89_phy_write32_idx_clr(rtwdev, physts->setting_addr,
+					  physts->dis_trigger_brk_mask, phy_idx);
 	} else {
-		rtw89_phy_write32_set(rtwdev, physts->setting_addr,
-				      physts->dis_trigger_fail_mask);
-		rtw89_phy_write32_set(rtwdev, physts->setting_addr,
-				      physts->dis_trigger_brk_mask);
+		rtw89_phy_write32_idx_set(rtwdev, physts->setting_addr,
+					  physts->dis_trigger_fail_mask, phy_idx);
+		rtw89_phy_write32_idx_set(rtwdev, physts->setting_addr,
+					  physts->dis_trigger_brk_mask, phy_idx);
 	}
 }
 
-static void rtw89_physts_parsing_init(struct rtw89_dev *rtwdev)
+static void __rtw89_physts_parsing_init(struct rtw89_dev *rtwdev,
+					enum rtw89_phy_idx phy_idx)
 {
 	u8 i;
 
-	rtw89_physts_enable_fail_report(rtwdev, false, RTW89_PHY_0);
+	rtw89_physts_enable_fail_report(rtwdev, false, phy_idx);
 
 	for (i = 0; i < RTW89_PHYSTS_BITMAP_NUM; i++) {
 		if (i >= RTW89_CCK_PKT)
 			rtw89_physts_enable_ie_bitmap(rtwdev, i,
 						      RTW89_PHYSTS_IE09_FTR_0,
-						      true);
+						      true, phy_idx);
 		if ((i >= RTW89_CCK_BRK && i <= RTW89_VHT_MU) ||
 		    (i >= RTW89_RSVD_9 && i <= RTW89_CCK_PKT))
 			continue;
 		rtw89_physts_enable_ie_bitmap(rtwdev, i,
 					      RTW89_PHYSTS_IE24_OFDM_TD_PATH_A,
-					      true);
+					      true, phy_idx);
 	}
 	rtw89_physts_enable_ie_bitmap(rtwdev, RTW89_VHT_PKT,
-				      RTW89_PHYSTS_IE13_DL_MU_DEF, true);
+				      RTW89_PHYSTS_IE13_DL_MU_DEF, true, phy_idx);
 	rtw89_physts_enable_ie_bitmap(rtwdev, RTW89_HE_PKT,
-				      RTW89_PHYSTS_IE13_DL_MU_DEF, true);
+				      RTW89_PHYSTS_IE13_DL_MU_DEF, true, phy_idx);
 
 	/* force IE01 for channel index, only channel field is valid */
 	rtw89_physts_enable_ie_bitmap(rtwdev, RTW89_CCK_PKT,
-				      RTW89_PHYSTS_IE01_CMN_OFDM, true);
+				      RTW89_PHYSTS_IE01_CMN_OFDM, true, phy_idx);
+}
+
+static void rtw89_physts_parsing_init(struct rtw89_dev *rtwdev)
+{
+	__rtw89_physts_parsing_init(rtwdev, RTW89_PHY_0);
+	if (rtwdev->dbcc_en)
+		__rtw89_physts_parsing_init(rtwdev, RTW89_PHY_1);
 }
 
 static void rtw89_phy_dig_read_gain_table(struct rtw89_dev *rtwdev, int type)
@@ -6246,7 +6282,7 @@ void rtw89_phy_set_bss_color(struct rtw89_dev *rtwdev,
 	struct ieee80211_vif *vif = rtwvif_link_to_vif(rtwvif_link);
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 	const struct rtw89_reg_def *bss_clr_vld = &chip->bss_clr_vld;
-	enum rtw89_phy_idx phy_idx = RTW89_PHY_0;
+	enum rtw89_phy_idx phy_idx = rtwvif_link->phy_idx;
 	struct ieee80211_bss_conf *bss_conf;
 	u8 bss_color;
 
diff --git a/drivers/net/wireless/realtek/rtw89/phy.h b/drivers/net/wireless/realtek/rtw89/phy.h
index 727b69c45a52..c683f4d7d29b 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.h
+++ b/drivers/net/wireless/realtek/rtw89/phy.h
@@ -815,6 +815,10 @@ void rtw89_phy_config_rf_reg_v1(struct rtw89_dev *rtwdev,
 void rtw89_phy_dm_init(struct rtw89_dev *rtwdev);
 void rtw89_phy_write32_idx(struct rtw89_dev *rtwdev, u32 addr, u32 mask,
 			   u32 data, enum rtw89_phy_idx phy_idx);
+void rtw89_phy_write32_idx_set(struct rtw89_dev *rtwdev, u32 addr, u32 bits,
+			       enum rtw89_phy_idx phy_idx);
+void rtw89_phy_write32_idx_clr(struct rtw89_dev *rtwdev, u32 addr, u32 bits,
+			       enum rtw89_phy_idx phy_idx);
 u32 rtw89_phy_read32_idx(struct rtw89_dev *rtwdev, u32 addr, u32 mask,
 			 enum rtw89_phy_idx phy_idx);
 s8 *rtw89_phy_raw_byr_seek(struct rtw89_dev *rtwdev,
diff --git a/drivers/net/wireless/realtek/rtw89/phy_be.c b/drivers/net/wireless/realtek/rtw89/phy_be.c
index 72eda9bbd3ae..37d8f254ae32 100644
--- a/drivers/net/wireless/realtek/rtw89/phy_be.c
+++ b/drivers/net/wireless/realtek/rtw89/phy_be.c
@@ -398,10 +398,9 @@ static void rtw89_phy_bb_wrap_ul_pwr(struct rtw89_dev *rtwdev)
 	}
 }
 
-static void rtw89_phy_bb_wrap_init_be(struct rtw89_dev *rtwdev)
+static void __rtw89_phy_bb_wrap_init_be(struct rtw89_dev *rtwdev,
+					enum rtw89_mac_idx mac_idx)
 {
-	enum rtw89_mac_idx mac_idx = RTW89_MAC_0;
-
 	rtw89_phy_bb_wrap_pwr_by_macid_init(rtwdev);
 	rtw89_phy_bb_wrap_tx_path_by_macid_init(rtwdev);
 	rtw89_phy_bb_wrap_listen_path_en_init(rtwdev);
@@ -411,6 +410,13 @@ static void rtw89_phy_bb_wrap_init_be(struct rtw89_dev *rtwdev)
 	rtw89_phy_bb_wrap_ul_pwr(rtwdev);
 }
 
+static void rtw89_phy_bb_wrap_init_be(struct rtw89_dev *rtwdev)
+{
+	__rtw89_phy_bb_wrap_init_be(rtwdev, RTW89_MAC_0);
+	if (rtwdev->dbcc_en)
+		__rtw89_phy_bb_wrap_init_be(rtwdev, RTW89_MAC_1);
+}
+
 static void rtw89_phy_ch_info_init_be(struct rtw89_dev *rtwdev)
 {
 	rtw89_phy_write32_mask(rtwdev, R_CHINFO_SEG, B_CHINFO_SEG_LEN, 0x0);
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a.c b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
index 2aff7e29992f..58c9721ac3ab 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
@@ -1991,14 +1991,23 @@ static void rtw8922a_rfk_init(struct rtw89_dev *rtwdev)
 	memset(rfk_mcc, 0, sizeof(*rfk_mcc));
 }
 
+static void __rtw8922a_rfk_init_late(struct rtw89_dev *rtwdev,
+				     enum rtw89_phy_idx phy_idx,
+				     const struct rtw89_chan *chan)
+{
+	rtw89_phy_rfk_pre_ntfy_and_wait(rtwdev, phy_idx, 5);
+
+	rtw89_phy_rfk_dack_and_wait(rtwdev, phy_idx, chan, 58);
+	rtw89_phy_rfk_rxdck_and_wait(rtwdev, phy_idx, chan, false, 32);
+}
+
 static void rtw8922a_rfk_init_late(struct rtw89_dev *rtwdev)
 {
 	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
 
-	rtw89_phy_rfk_pre_ntfy_and_wait(rtwdev, RTW89_PHY_0, 5);
-
-	rtw89_phy_rfk_dack_and_wait(rtwdev, RTW89_PHY_0, chan, 58);
-	rtw89_phy_rfk_rxdck_and_wait(rtwdev, RTW89_PHY_0, chan, false, 32);
+	__rtw8922a_rfk_init_late(rtwdev, RTW89_PHY_0, chan);
+	if (rtwdev->dbcc_en)
+		__rtw8922a_rfk_init_late(rtwdev, RTW89_PHY_1, chan);
 }
 
 static void _wait_rx_mode(struct rtw89_dev *rtwdev, u8 kpath)
-- 
2.25.1


