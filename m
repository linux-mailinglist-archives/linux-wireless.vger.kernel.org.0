Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A11234A438
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Mar 2021 10:24:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbhCZJWP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 26 Mar 2021 05:22:15 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:54391 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbhCZJWC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 26 Mar 2021 05:22:02 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 12Q9LsXoA032609, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmbs04.realtek.com.tw[172.21.6.97])
        by rtits2.realtek.com.tw (8.15.2/2.70/5.88) with ESMTPS id 12Q9LsXoA032609
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 26 Mar 2021 17:21:54 +0800
Received: from localhost (172.21.69.146) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Fri, 26 Mar
 2021 17:21:54 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <tony0620emma@gmail.com>, <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <phhuang@realtek.com>
Subject: [PATCH] rtw88: update statistics to fw for fine-tuning performance
Date:   Fri, 26 Mar 2021 17:21:47 +0800
Message-ID: <20210326092147.30252-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.146]
X-ClientProxiedBy: RTEXMBS03.realtek.com.tw (172.21.6.96) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Po-Hao Huang <phhuang@realtek.com>

Since firmware can't have proper statistics, driver update the statistics
periodically to firmware to assist in tuning performance.

Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/fw.c  | 15 +++++++++++++++
 drivers/net/wireless/realtek/rtw88/fw.h  | 13 +++++++++++++
 drivers/net/wireless/realtek/rtw88/phy.c |  1 +
 3 files changed, 29 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/fw.c b/drivers/net/wireless/realtek/rtw88/fw.c
index 76c43830dfc2..ea2cd4db1d3c 100644
--- a/drivers/net/wireless/realtek/rtw88/fw.c
+++ b/drivers/net/wireless/realtek/rtw88/fw.c
@@ -512,6 +512,21 @@ void rtw_fw_media_status_report(struct rtw_dev *rtwdev, u8 mac_id, bool connect)
 	rtw_fw_send_h2c_command(rtwdev, h2c_pkt);
 }
 
+void rtw_fw_update_wl_phy_info(struct rtw_dev *rtwdev)
+{
+	struct rtw_traffic_stats *stats = &rtwdev->stats;
+	struct rtw_dm_info *dm_info = &rtwdev->dm_info;
+	u8 h2c_pkt[H2C_PKT_SIZE] = {0};
+
+	SET_H2C_CMD_ID_CLASS(h2c_pkt, H2C_CMD_WL_PHY_INFO);
+	SET_WL_PHY_INFO_TX_TP(h2c_pkt, stats->tx_throughput);
+	SET_WL_PHY_INFO_RX_TP(h2c_pkt, stats->rx_throughput);
+	SET_WL_PHY_INFO_TX_RATE_DESC(h2c_pkt, dm_info->tx_rate);
+	SET_WL_PHY_INFO_RX_RATE_DESC(h2c_pkt, dm_info->curr_rx_rate);
+	SET_WL_PHY_INFO_RX_EVM(h2c_pkt, dm_info->rx_evm_dbm[RF_PATH_A]);
+	rtw_fw_send_h2c_command(rtwdev, h2c_pkt);
+}
+
 void rtw_fw_set_pwr_mode(struct rtw_dev *rtwdev)
 {
 	struct rtw_lps_conf *conf = &rtwdev->lps_conf;
diff --git a/drivers/net/wireless/realtek/rtw88/fw.h b/drivers/net/wireless/realtek/rtw88/fw.h
index c3d4c83dd5df..7c5b1d75e26f 100644
--- a/drivers/net/wireless/realtek/rtw88/fw.h
+++ b/drivers/net/wireless/realtek/rtw88/fw.h
@@ -345,6 +345,7 @@ static inline void rtw_h2c_pkt_set_header(u8 *h2c_pkt, u8 sub_id)
 #define H2C_CMD_LPS_PG_INFO		0x2b
 #define H2C_CMD_RA_INFO			0x40
 #define H2C_CMD_RSSI_MONITOR		0x42
+#define H2C_CMD_WL_PHY_INFO		0x58
 
 #define H2C_CMD_COEX_TDMA_TYPE		0x60
 #define H2C_CMD_QUERY_BT_INFO		0x61
@@ -370,6 +371,17 @@ static inline void rtw_h2c_pkt_set_header(u8 *h2c_pkt, u8 sub_id)
 #define MEDIA_STATUS_RPT_SET_MACID(h2c_pkt, value)                             \
 	le32p_replace_bits((__le32 *)(h2c_pkt) + 0x00, value, GENMASK(23, 16))
 
+#define SET_WL_PHY_INFO_TX_TP(h2c_pkt, value)				       \
+	le32p_replace_bits((__le32 *)(h2c_pkt) + 0x00, value, GENMASK(17, 8))
+#define SET_WL_PHY_INFO_RX_TP(h2c_pkt, value)				       \
+	le32p_replace_bits((__le32 *)(h2c_pkt) + 0x00, value, GENMASK(27, 18))
+#define SET_WL_PHY_INFO_TX_RATE_DESC(h2c_pkt, value)			       \
+	le32p_replace_bits((__le32 *)(h2c_pkt) + 0x01, value, GENMASK(7, 0))
+#define SET_WL_PHY_INFO_RX_RATE_DESC(h2c_pkt, value)			       \
+	le32p_replace_bits((__le32 *)(h2c_pkt) + 0x01, value, GENMASK(15, 8))
+#define SET_WL_PHY_INFO_RX_EVM(h2c_pkt, value)				       \
+	le32p_replace_bits((__le32 *)(h2c_pkt) + 0x01, value, GENMASK(23, 16))
+
 #define SET_PWR_MODE_SET_MODE(h2c_pkt, value)                                  \
 	le32p_replace_bits((__le32 *)(h2c_pkt) + 0x00, value, GENMASK(14, 8))
 #define SET_PWR_MODE_SET_RLBM(h2c_pkt, value)                                  \
@@ -564,6 +576,7 @@ void rtw_fw_bt_wifi_control(struct rtw_dev *rtwdev, u8 op_code, u8 *data);
 void rtw_fw_send_rssi_info(struct rtw_dev *rtwdev, struct rtw_sta_info *si);
 void rtw_fw_send_ra_info(struct rtw_dev *rtwdev, struct rtw_sta_info *si);
 void rtw_fw_media_status_report(struct rtw_dev *rtwdev, u8 mac_id, bool conn);
+void rtw_fw_update_wl_phy_info(struct rtw_dev *rtwdev);
 int rtw_fw_write_data_rsvd_page(struct rtw_dev *rtwdev, u16 pg_addr,
 				u8 *buf, u32 size);
 void rtw_remove_rsvd_page(struct rtw_dev *rtwdev,
diff --git a/drivers/net/wireless/realtek/rtw88/phy.c b/drivers/net/wireless/realtek/rtw88/phy.c
index fac89d644305..7f0318f80038 100644
--- a/drivers/net/wireless/realtek/rtw88/phy.c
+++ b/drivers/net/wireless/realtek/rtw88/phy.c
@@ -683,6 +683,7 @@ static void rtw_phy_pwr_track(struct rtw_dev *rtwdev)
 
 static void rtw_phy_ra_track(struct rtw_dev *rtwdev)
 {
+	rtw_fw_update_wl_phy_info(rtwdev);
 	rtw_phy_ra_info_update(rtwdev);
 	rtw_phy_rrsr_update(rtwdev);
 }
-- 
2.21.0

