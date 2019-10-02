Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53E84C45EC
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Oct 2019 04:31:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729803AbfJBCbq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Oct 2019 22:31:46 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:46019 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729789AbfJBCbq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Oct 2019 22:31:46 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x922VdfF031869, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x922VdfF031869
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 2 Oct 2019 10:31:39 +0800
Received: from localhost.localdomain (172.21.68.126) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.468.0; Wed, 2 Oct 2019 10:31:39 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>
Subject: [PATCH v2 11/12] rtw88: add deep PS PG mode for 8822c
Date:   Wed, 2 Oct 2019 10:31:27 +0800
Message-ID: <20191002023128.12090-12-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191002023128.12090-1-yhchuang@realtek.com>
References: <20191002023128.12090-1-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.126]
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Yan-Hsuan Chuang <yhchuang@realtek.com>

Compare with LCLK mode, PG mode saves more power, by turning
off more circuits. Therefore, to recover from PG mode, driver
needs to backup some information into rsvd page. Such as CAM
entries, DPK results.

As CAM entries can change, it is required to re-download CAM
entries after set_key.

Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---

v1 -> v2
  - rebase on top of wireless-drivers-next

 drivers/net/wireless/realtek/rtw88/fw.c       | 77 +++++++++++++++++++
 drivers/net/wireless/realtek/rtw88/fw.h       | 29 +++++++
 drivers/net/wireless/realtek/rtw88/mac80211.c |  6 ++
 drivers/net/wireless/realtek/rtw88/main.h     |  3 +
 drivers/net/wireless/realtek/rtw88/ps.c       | 10 ++-
 drivers/net/wireless/realtek/rtw88/ps.h       |  1 +
 drivers/net/wireless/realtek/rtw88/rtw8822c.c |  2 +-
 drivers/net/wireless/realtek/rtw88/sec.c      | 21 +++++
 drivers/net/wireless/realtek/rtw88/sec.h      |  1 +
 9 files changed, 147 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/fw.c b/drivers/net/wireless/realtek/rtw88/fw.c
index b082e2cc95f5..430d73cff32e 100644
--- a/drivers/net/wireless/realtek/rtw88/fw.c
+++ b/drivers/net/wireless/realtek/rtw88/fw.c
@@ -7,6 +7,7 @@
 #include "fw.h"
 #include "tx.h"
 #include "reg.h"
+#include "sec.h"
 #include "debug.h"
 
 static void rtw_fw_c2h_cmd_handle_ext(struct rtw_dev *rtwdev,
@@ -397,6 +398,24 @@ static u8 rtw_get_rsvd_page_location(struct rtw_dev *rtwdev,
 	return location;
 }
 
+void rtw_fw_set_pg_info(struct rtw_dev *rtwdev)
+{
+	struct rtw_lps_conf *conf = &rtwdev->lps_conf;
+	u8 h2c_pkt[H2C_PKT_SIZE] = {0};
+	u8 loc_pg, loc_dpk;
+
+	loc_pg = rtw_get_rsvd_page_location(rtwdev, RSVD_LPS_PG_INFO);
+	loc_dpk = rtw_get_rsvd_page_location(rtwdev, RSVD_LPS_PG_DPK);
+
+	SET_H2C_CMD_ID_CLASS(h2c_pkt, H2C_CMD_LPS_PG_INFO);
+
+	LPS_PG_INFO_LOC(h2c_pkt, loc_pg);
+	LPS_PG_DPK_LOC(h2c_pkt, loc_dpk);
+	LPS_PG_SEC_CAM_EN(h2c_pkt, conf->sec_cam_backup);
+
+	rtw_fw_send_h2c_command(rtwdev, h2c_pkt);
+}
+
 void rtw_send_rsvd_page_h2c(struct rtw_dev *rtwdev)
 {
 	u8 h2c_pkt[H2C_PKT_SIZE] = {0};
@@ -442,6 +461,58 @@ rtw_beacon_get(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 	return skb_new;
 }
 
+static struct sk_buff *rtw_lps_pg_dpk_get(struct ieee80211_hw *hw)
+{
+	struct rtw_dev *rtwdev = hw->priv;
+	struct rtw_chip_info *chip = rtwdev->chip;
+	struct rtw_dpk_info *dpk_info = &rtwdev->dm_info.dpk_info;
+	struct rtw_lps_pg_dpk_hdr *dpk_hdr;
+	struct sk_buff *skb;
+	u32 size;
+
+	size = chip->tx_pkt_desc_sz + sizeof(*dpk_hdr);
+	skb = alloc_skb(size, GFP_KERNEL);
+	if (!skb)
+		return NULL;
+
+	skb_reserve(skb, chip->tx_pkt_desc_sz);
+	dpk_hdr = skb_put_zero(skb, sizeof(*dpk_hdr));
+	dpk_hdr->dpk_ch = dpk_info->dpk_ch;
+	dpk_hdr->dpk_path_ok = dpk_info->dpk_path_ok[0];
+	memcpy(dpk_hdr->dpk_txagc, dpk_info->dpk_txagc, 2);
+	memcpy(dpk_hdr->dpk_gs, dpk_info->dpk_gs, 4);
+	memcpy(dpk_hdr->coef, dpk_info->coef, 160);
+
+	return skb;
+}
+
+static struct sk_buff *rtw_lps_pg_info_get(struct ieee80211_hw *hw,
+					   struct ieee80211_vif *vif)
+{
+	struct rtw_dev *rtwdev = hw->priv;
+	struct rtw_chip_info *chip = rtwdev->chip;
+	struct rtw_lps_conf *conf = &rtwdev->lps_conf;
+	struct rtw_lps_pg_info_hdr *pg_info_hdr;
+	struct sk_buff *skb;
+	u32 size;
+
+	size = chip->tx_pkt_desc_sz + sizeof(*pg_info_hdr);
+	skb = alloc_skb(size, GFP_KERNEL);
+	if (!skb)
+		return NULL;
+
+	skb_reserve(skb, chip->tx_pkt_desc_sz);
+	pg_info_hdr = skb_put_zero(skb, sizeof(*pg_info_hdr));
+	pg_info_hdr->tx_bu_page_count = rtwdev->fifo.rsvd_drv_pg_num;
+	pg_info_hdr->macid = find_first_bit(rtwdev->mac_id_map, RTW_MAX_MAC_ID_NUM);
+	pg_info_hdr->sec_cam_count =
+		rtw_sec_cam_pg_backup(rtwdev, pg_info_hdr->sec_cam);
+
+	conf->sec_cam_backup = pg_info_hdr->sec_cam_count != 0;
+
+	return skb;
+}
+
 static struct sk_buff *rtw_get_rsvd_page_skb(struct ieee80211_hw *hw,
 					     struct ieee80211_vif *vif,
 					     enum rtw_rsvd_packet_type type)
@@ -464,6 +535,12 @@ static struct sk_buff *rtw_get_rsvd_page_skb(struct ieee80211_hw *hw,
 	case RSVD_QOS_NULL:
 		skb_new = ieee80211_nullfunc_get(hw, vif, true);
 		break;
+	case RSVD_LPS_PG_DPK:
+		skb_new = rtw_lps_pg_dpk_get(hw);
+		break;
+	case RSVD_LPS_PG_INFO:
+		skb_new = rtw_lps_pg_info_get(hw, vif);
+		break;
 	default:
 		return NULL;
 	}
diff --git a/drivers/net/wireless/realtek/rtw88/fw.h b/drivers/net/wireless/realtek/rtw88/fw.h
index e95d85bd097f..f4028ef63ee8 100644
--- a/drivers/net/wireless/realtek/rtw88/fw.h
+++ b/drivers/net/wireless/realtek/rtw88/fw.h
@@ -58,6 +58,8 @@ enum rtw_rsvd_packet_type {
 	RSVD_PROBE_RESP,
 	RSVD_NULL,
 	RSVD_QOS_NULL,
+	RSVD_LPS_PG_DPK,
+	RSVD_LPS_PG_INFO,
 };
 
 enum rtw_fw_rf_type {
@@ -86,6 +88,25 @@ struct rtw_iqk_para {
 	u8 segment_iqk;
 };
 
+struct rtw_lps_pg_dpk_hdr {
+	u16 dpk_path_ok;
+	u8 dpk_txagc[2];
+	u16 dpk_gs[2];
+	u32 coef[2][20];
+	u8 dpk_ch;
+} __packed;
+
+struct rtw_lps_pg_info_hdr {
+	u8 macid;
+	u8 mbssid;
+	u8 pattern_count;
+	u8 mu_tab_group_id;
+	u8 sec_cam_count;
+	u8 tx_bu_page_count;
+	u16 rsvd;
+	u8 sec_cam[MAX_PG_CAM_BACKUP_NUM];
+} __packed;
+
 struct rtw_rsvd_page {
 	struct list_head list;
 	struct sk_buff *skb;
@@ -146,6 +167,7 @@ static inline void rtw_h2c_pkt_set_header(u8 *h2c_pkt, u8 sub_id)
 #define H2C_CMD_RSVD_PAGE		0x0
 #define H2C_CMD_MEDIA_STATUS_RPT	0x01
 #define H2C_CMD_SET_PWR_MODE		0x20
+#define H2C_CMD_LPS_PG_INFO		0x2b
 #define H2C_CMD_RA_INFO			0x40
 #define H2C_CMD_RSSI_MONITOR		0x42
 
@@ -177,6 +199,12 @@ static inline void rtw_h2c_pkt_set_header(u8 *h2c_pkt, u8 sub_id)
 	le32p_replace_bits((__le32 *)(h2c_pkt) + 0x01, value, GENMASK(7, 5))
 #define SET_PWR_MODE_SET_PWR_STATE(h2c_pkt, value)                             \
 	le32p_replace_bits((__le32 *)(h2c_pkt) + 0x01, value, GENMASK(15, 8))
+#define LPS_PG_INFO_LOC(h2c_pkt, value)                                        \
+	le32p_replace_bits((__le32 *)(h2c_pkt) + 0x00, value, GENMASK(23, 16))
+#define LPS_PG_DPK_LOC(h2c_pkt, value)                                         \
+	le32p_replace_bits((__le32 *)(h2c_pkt) + 0x00, value, GENMASK(31, 24))
+#define LPS_PG_SEC_CAM_EN(h2c_pkt, value)                                      \
+	le32p_replace_bits((__le32 *)(h2c_pkt) + 0x00, value, BIT(8))
 #define SET_RSSI_INFO_MACID(h2c_pkt, value)                                    \
 	le32p_replace_bits((__le32 *)(h2c_pkt) + 0x00, value, GENMASK(15, 8))
 #define SET_RSSI_INFO_RSSI(h2c_pkt, value)                                     \
@@ -270,6 +298,7 @@ void rtw_fw_send_phydm_info(struct rtw_dev *rtwdev);
 
 void rtw_fw_do_iqk(struct rtw_dev *rtwdev, struct rtw_iqk_para *para);
 void rtw_fw_set_pwr_mode(struct rtw_dev *rtwdev);
+void rtw_fw_set_pg_info(struct rtw_dev *rtwdev);
 void rtw_fw_query_bt_info(struct rtw_dev *rtwdev);
 void rtw_fw_wl_ch_info(struct rtw_dev *rtwdev, u8 link, u8 ch, u8 bw);
 void rtw_fw_query_bt_mp_info(struct rtw_dev *rtwdev,
diff --git a/drivers/net/wireless/realtek/rtw88/mac80211.c b/drivers/net/wireless/realtek/rtw88/mac80211.c
index e241d054bf0f..22b13e45fcee 100644
--- a/drivers/net/wireless/realtek/rtw88/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw88/mac80211.c
@@ -272,6 +272,8 @@ static void rtw_ops_bss_info_changed(struct ieee80211_hw *hw,
 			rtw_add_rsvd_page(rtwdev, RSVD_PS_POLL, true);
 			rtw_add_rsvd_page(rtwdev, RSVD_QOS_NULL, true);
 			rtw_add_rsvd_page(rtwdev, RSVD_NULL, true);
+			rtw_add_rsvd_page(rtwdev, RSVD_LPS_PG_DPK, true);
+			rtw_add_rsvd_page(rtwdev, RSVD_LPS_PG_INFO, true);
 			rtw_fw_download_rsvd_page(rtwdev, vif);
 			rtw_send_rsvd_page_h2c(rtwdev);
 			rtw_coex_media_status_notify(rtwdev, conf->assoc);
@@ -435,6 +437,10 @@ static int rtw_ops_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 		break;
 	}
 
+	/* download new cam settings for PG to backup */
+	if (rtw_fw_lps_deep_mode == LPS_DEEP_MODE_PG)
+		rtw_fw_download_rsvd_page(rtwdev, vif);
+
 out:
 	mutex_unlock(&rtwdev->mutex);
 
diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index a59cbaefde4e..6221dc45fc2a 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -16,6 +16,7 @@
 
 #define RTW_MAX_MAC_ID_NUM		32
 #define RTW_MAX_SEC_CAM_NUM		32
+#define MAX_PG_CAM_BACKUP_NUM		8
 
 #define RTW_WATCH_DOG_DELAY_TIME	round_jiffies_relative(HZ * 2)
 
@@ -532,6 +533,7 @@ enum rtw_lps_mode {
 enum rtw_lps_deep_mode {
 	LPS_DEEP_MODE_NONE	= 0,
 	LPS_DEEP_MODE_LCLK	= 1,
+	LPS_DEEP_MODE_PG	= 2,
 };
 
 enum rtw_pwr_state {
@@ -548,6 +550,7 @@ struct rtw_lps_conf {
 	u8 rlbm;
 	u8 smart_ps;
 	u8 port_id;
+	bool sec_cam_backup;
 };
 
 enum rtw_hw_key_type {
diff --git a/drivers/net/wireless/realtek/rtw88/ps.c b/drivers/net/wireless/realtek/rtw88/ps.c
index 02e104ac7b9e..83db6cf6a219 100644
--- a/drivers/net/wireless/realtek/rtw88/ps.c
+++ b/drivers/net/wireless/realtek/rtw88/ps.c
@@ -74,10 +74,13 @@ void rtw_power_mode_change(struct rtw_dev *rtwdev, bool enter)
 
 	/* toggle to request power mode, others remain 0 */
 	request ^= request | BIT_RPWM_TOGGLE;
-	if (!enter)
+	if (!enter) {
 		request |= POWER_MODE_ACK;
-	else
+	} else {
 		request |= POWER_MODE_LCLK;
+		if (rtw_fw_lps_deep_mode == LPS_DEEP_MODE_PG)
+			request |= POWER_MODE_PG;
+	}
 
 	rtw_write8(rtwdev, rtwdev->hci.rpwm_addr, request);
 
@@ -141,6 +144,9 @@ static void __rtw_enter_lps_deep(struct rtw_dev *rtwdev)
 		return;
 	}
 
+	if (rtw_fw_lps_deep_mode == LPS_DEEP_MODE_PG)
+		rtw_fw_set_pg_info(rtwdev);
+
 	rtw_hci_deep_ps(rtwdev, true);
 }
 
diff --git a/drivers/net/wireless/realtek/rtw88/ps.h b/drivers/net/wireless/realtek/rtw88/ps.h
index 03b08bd98dc4..18f687cfe211 100644
--- a/drivers/net/wireless/realtek/rtw88/ps.h
+++ b/drivers/net/wireless/realtek/rtw88/ps.h
@@ -8,6 +8,7 @@
 #define RTW_LPS_THRESHOLD	2
 
 #define POWER_MODE_ACK		BIT(6)
+#define POWER_MODE_PG		BIT(4)
 #define POWER_MODE_LCLK		BIT(0)
 
 int rtw_enter_ips(struct rtw_dev *rtwdev);
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822c.c b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
index 579afdfcf685..7f81da8a2771 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
@@ -3747,7 +3747,7 @@ struct rtw_chip_info rtw8822c_hw_spec = {
 	.dig_min = 0x20,
 	.ht_supported = true,
 	.vht_supported = true,
-	.lps_deep_mode_supported = BIT(LPS_DEEP_MODE_LCLK),
+	.lps_deep_mode_supported = BIT(LPS_DEEP_MODE_LCLK) | BIT(LPS_DEEP_MODE_PG),
 	.sys_func_en = 0xD8,
 	.pwr_on_seq = card_enable_flow_8822c,
 	.pwr_off_seq = card_disable_flow_8822c,
diff --git a/drivers/net/wireless/realtek/rtw88/sec.c b/drivers/net/wireless/realtek/rtw88/sec.c
index c594fc02804d..d0d7fbb10d58 100644
--- a/drivers/net/wireless/realtek/rtw88/sec.c
+++ b/drivers/net/wireless/realtek/rtw88/sec.c
@@ -96,6 +96,27 @@ void rtw_sec_clear_cam(struct rtw_dev *rtwdev,
 	rtw_write32(rtwdev, RTW_SEC_CMD_REG, command);
 }
 
+u8 rtw_sec_cam_pg_backup(struct rtw_dev *rtwdev, u8 *used_cam)
+{
+	struct rtw_sec_desc *sec = &rtwdev->sec;
+	u8 offset = 0;
+	u8 count, n;
+
+	if (!used_cam)
+		return 0;
+
+	for (count = 0; count < MAX_PG_CAM_BACKUP_NUM; count++) {
+		n = find_next_bit(sec->cam_map, RTW_MAX_SEC_CAM_NUM, offset);
+		if (n == RTW_MAX_SEC_CAM_NUM)
+			break;
+
+		used_cam[count] = n;
+		offset = n + 1;
+	}
+
+	return count;
+}
+
 void rtw_sec_enable_sec_engine(struct rtw_dev *rtwdev)
 {
 	struct rtw_sec_desc *sec = &rtwdev->sec;
diff --git a/drivers/net/wireless/realtek/rtw88/sec.h b/drivers/net/wireless/realtek/rtw88/sec.h
index 8c50a895c797..efcf45433999 100644
--- a/drivers/net/wireless/realtek/rtw88/sec.h
+++ b/drivers/net/wireless/realtek/rtw88/sec.h
@@ -34,6 +34,7 @@ void rtw_sec_write_cam(struct rtw_dev *rtwdev,
 void rtw_sec_clear_cam(struct rtw_dev *rtwdev,
 		       struct rtw_sec_desc *sec,
 		       u8 hw_key_idx);
+u8 rtw_sec_cam_pg_backup(struct rtw_dev *rtwdev, u8 *used_cam);
 void rtw_sec_enable_sec_engine(struct rtw_dev *rtwdev);
 
 #endif
-- 
2.17.1

