Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13707C47D1
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Oct 2019 08:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727167AbfJBGfq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Oct 2019 02:35:46 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:57697 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726882AbfJBGfo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Oct 2019 02:35:44 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x926ZbYV013060, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x926ZbYV013060
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 2 Oct 2019 14:35:38 +0800
Received: from localhost.localdomain (172.21.68.126) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.468.0; Wed, 2 Oct 2019 14:35:37 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>
Subject: [PATCH 05/14] rtw88: report tx rate to mac80211 stack
Date:   Wed, 2 Oct 2019 14:35:22 +0800
Message-ID: <20191002063531.18135-6-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191002063531.18135-1-yhchuang@realtek.com>
References: <20191002063531.18135-1-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.126]
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Tzu-En Huang <tehuang@realtek.com>

Whenever the firmware increases/decreases the bit rate used
to transmit to a peer, it sends an RA report through C2H to
driver. Driver can then record the bit rate in the peer's
struct rtw_sta_info, and report to mac80211 when it asks us
for the statistics of the sta by ieee80211_ops::sta_statistics

Signed-off-by: Tzu-En Huang <tehuang@realtek.com>
Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/fw.c       | 73 +++++++++++++++++++
 drivers/net/wireless/realtek/rtw88/fw.h       |  6 ++
 drivers/net/wireless/realtek/rtw88/mac80211.c | 12 +++
 drivers/net/wireless/realtek/rtw88/main.c     | 12 +++
 drivers/net/wireless/realtek/rtw88/main.h     | 10 +++
 drivers/net/wireless/realtek/rtw88/rx.c       | 22 +-----
 drivers/net/wireless/realtek/rtw88/util.c     | 27 +++++++
 7 files changed, 143 insertions(+), 19 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/fw.c b/drivers/net/wireless/realtek/rtw88/fw.c
index 430d73cff32e..4b41bf531998 100644
--- a/drivers/net/wireless/realtek/rtw88/fw.c
+++ b/drivers/net/wireless/realtek/rtw88/fw.c
@@ -9,6 +9,7 @@
 #include "reg.h"
 #include "sec.h"
 #include "debug.h"
+#include "util.h"
 
 static void rtw_fw_c2h_cmd_handle_ext(struct rtw_dev *rtwdev,
 				      struct sk_buff *skb)
@@ -28,6 +29,75 @@ static void rtw_fw_c2h_cmd_handle_ext(struct rtw_dev *rtwdev,
 	}
 }
 
+struct rtw_fw_iter_ra_data {
+	struct rtw_dev *rtwdev;
+	u8 *payload;
+};
+
+static void rtw_fw_ra_report_iter(void *data, struct ieee80211_sta *sta)
+{
+	struct rtw_fw_iter_ra_data *ra_data = data;
+	struct rtw_sta_info *si = (struct rtw_sta_info *)sta->drv_priv;
+	u8 mac_id, rate, sgi, bw;
+	u8 mcs, nss;
+	u32 bit_rate;
+
+	mac_id = GET_RA_REPORT_MACID(ra_data->payload);
+	if (si->mac_id != mac_id)
+		return;
+
+	si->ra_report.txrate.flags = 0;
+
+	rate = GET_RA_REPORT_RATE(ra_data->payload);
+	sgi = GET_RA_REPORT_SGI(ra_data->payload);
+	bw = GET_RA_REPORT_BW(ra_data->payload);
+
+	if (rate < DESC_RATEMCS0) {
+		si->ra_report.txrate.legacy = rtw_desc_to_bitrate(rate);
+		goto legacy;
+	}
+
+	rtw_desc_to_mcsrate(rate, &mcs, &nss);
+	if (rate >= DESC_RATEVHT1SS_MCS0)
+		si->ra_report.txrate.flags |= RATE_INFO_FLAGS_VHT_MCS;
+	else if (rate >= DESC_RATEMCS0)
+		si->ra_report.txrate.flags |= RATE_INFO_FLAGS_MCS;
+
+	if (rate >= DESC_RATEMCS0) {
+		si->ra_report.txrate.mcs = mcs;
+		si->ra_report.txrate.nss = nss;
+	}
+
+	if (sgi)
+		si->ra_report.txrate.flags |= RATE_INFO_FLAGS_SHORT_GI;
+
+	if (bw == RTW_CHANNEL_WIDTH_80)
+		si->ra_report.txrate.bw = RATE_INFO_BW_80;
+	else if (bw == RTW_CHANNEL_WIDTH_40)
+		si->ra_report.txrate.bw = RATE_INFO_BW_40;
+	else
+		si->ra_report.txrate.bw = RATE_INFO_BW_20;
+
+legacy:
+	bit_rate = cfg80211_calculate_bitrate(&si->ra_report.txrate);
+
+	si->ra_report.desc_rate = rate;
+	si->ra_report.bit_rate = bit_rate;
+}
+
+static void rtw_fw_ra_report_handle(struct rtw_dev *rtwdev, u8 *payload,
+				    u8 length)
+{
+	struct rtw_fw_iter_ra_data ra_data;
+
+	if (WARN(length < 7, "invalid ra report c2h length\n"))
+		return;
+
+	ra_data.rtwdev = rtwdev;
+	ra_data.payload = payload;
+	rtw_iterate_stas_atomic(rtwdev, rtw_fw_ra_report_iter, &ra_data);
+}
+
 void rtw_fw_c2h_cmd_handle(struct rtw_dev *rtwdev, struct sk_buff *skb)
 {
 	struct rtw_c2h_cmd *c2h;
@@ -50,6 +120,9 @@ void rtw_fw_c2h_cmd_handle(struct rtw_dev *rtwdev, struct sk_buff *skb)
 	case C2H_HALMAC:
 		rtw_fw_c2h_cmd_handle_ext(rtwdev, skb);
 		break;
+	case C2H_RA_RPT:
+		rtw_fw_ra_report_handle(rtwdev, c2h->payload, len);
+		break;
 	default:
 		break;
 	}
diff --git a/drivers/net/wireless/realtek/rtw88/fw.h b/drivers/net/wireless/realtek/rtw88/fw.h
index f4028ef63ee8..fd34986a13d2 100644
--- a/drivers/net/wireless/realtek/rtw88/fw.h
+++ b/drivers/net/wireless/realtek/rtw88/fw.h
@@ -36,6 +36,7 @@
 enum rtw_c2h_cmd_id {
 	C2H_BT_INFO = 0x09,
 	C2H_BT_MP_INFO = 0x0b,
+	C2H_RA_RPT = 0x0c,
 	C2H_HW_FEATURE_REPORT = 0x19,
 	C2H_WLAN_INFO = 0x27,
 	C2H_HW_FEATURE_DUMP = 0xfd,
@@ -119,6 +120,11 @@ struct rtw_rsvd_page {
 #define GET_CCX_REPORT_SEQNUM(c2h_payload)	(c2h_payload[8] & 0xfc)
 #define GET_CCX_REPORT_STATUS(c2h_payload)	(c2h_payload[9] & 0xc0)
 
+#define GET_RA_REPORT_RATE(c2h_payload)		(c2h_payload[0] & 0x7f)
+#define GET_RA_REPORT_SGI(c2h_payload)		((c2h_payload[0] & 0x80) >> 7)
+#define GET_RA_REPORT_BW(c2h_payload)		(c2h_payload[6])
+#define GET_RA_REPORT_MACID(c2h_payload)	(c2h_payload[1])
+
 /* PKT H2C */
 #define H2C_PKT_CMD_ID 0xFF
 #define H2C_PKT_CATEGORY 0x01
diff --git a/drivers/net/wireless/realtek/rtw88/mac80211.c b/drivers/net/wireless/realtek/rtw88/mac80211.c
index fe58a99ca48e..9c77c86d3021 100644
--- a/drivers/net/wireless/realtek/rtw88/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw88/mac80211.c
@@ -578,6 +578,17 @@ static int rtw_ops_set_rts_threshold(struct ieee80211_hw *hw, u32 value)
 	return 0;
 }
 
+static void rtw_ops_sta_statistics(struct ieee80211_hw *hw,
+				   struct ieee80211_vif *vif,
+				   struct ieee80211_sta *sta,
+				   struct station_info *sinfo)
+{
+	struct rtw_sta_info *si = (struct rtw_sta_info *)sta->drv_priv;
+
+	sinfo->txrate = si->ra_report.txrate;
+	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_BITRATE);
+}
+
 const struct ieee80211_ops rtw_ops = {
 	.tx			= rtw_ops_tx,
 	.wake_tx_queue		= rtw_ops_wake_tx_queue,
@@ -596,5 +607,6 @@ const struct ieee80211_ops rtw_ops = {
 	.sw_scan_complete	= rtw_ops_sw_scan_complete,
 	.mgd_prepare_tx		= rtw_ops_mgd_prepare_tx,
 	.set_rts_threshold	= rtw_ops_set_rts_threshold,
+	.sta_statistics		= rtw_ops_sta_statistics,
 };
 EXPORT_SYMBOL(rtw_ops);
diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index 0cee91869daa..690a5c4d64e7 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -86,6 +86,18 @@ static struct ieee80211_rate rtw_ratetable[] = {
 	{.bitrate = 540, .hw_value = 0x0b,},
 };
 
+u16 rtw_desc_to_bitrate(u8 desc_rate)
+{
+	struct ieee80211_rate rate;
+
+	if (WARN(desc_rate >= ARRAY_SIZE(rtw_ratetable), "invalid desc rate\n"))
+		return 0;
+
+	rate = rtw_ratetable[desc_rate];
+
+	return rate.bitrate;
+}
+
 static struct ieee80211_supported_band rtw_band_2ghz = {
 	.band = NL80211_BAND_2GHZ,
 
diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index dcf806ac8155..cd34d4d77b52 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -592,6 +592,12 @@ struct rtw_tx_report {
 	struct timer_list purge_timer;
 };
 
+struct rtw_ra_report {
+	struct rate_info txrate;
+	u32 bit_rate;
+	u8 desc_rate;
+};
+
 struct rtw_txq {
 	struct list_head list;
 
@@ -623,6 +629,8 @@ struct rtw_sta_info {
 	u64 ra_mask;
 
 	DECLARE_BITMAP(tid_ba, IEEE80211_NUM_TIDS);
+
+	struct rtw_ra_report ra_report;
 };
 
 struct rtw_vif {
@@ -1430,6 +1438,7 @@ bool ltecoex_read_reg(struct rtw_dev *rtwdev, u16 offset, u32 *val);
 bool ltecoex_reg_write(struct rtw_dev *rtwdev, u16 offset, u32 value);
 void rtw_restore_reg(struct rtw_dev *rtwdev,
 		     struct rtw_backup_info *bckp, u32 num);
+void rtw_desc_to_mcsrate(u16 rate, u8 *mcs, u8 *nss);
 void rtw_set_channel(struct rtw_dev *rtwdev);
 void rtw_vif_port_config(struct rtw_dev *rtwdev, struct rtw_vif *rtwvif,
 			 u32 config);
@@ -1442,5 +1451,6 @@ int rtw_core_init(struct rtw_dev *rtwdev);
 void rtw_core_deinit(struct rtw_dev *rtwdev);
 int rtw_register_hw(struct rtw_dev *rtwdev, struct ieee80211_hw *hw);
 void rtw_unregister_hw(struct rtw_dev *rtwdev, struct ieee80211_hw *hw);
+u16 rtw_desc_to_bitrate(u8 desc_rate);
 
 #endif
diff --git a/drivers/net/wireless/realtek/rtw88/rx.c b/drivers/net/wireless/realtek/rtw88/rx.c
index 16b22eb57171..d97d2c2c57c2 100644
--- a/drivers/net/wireless/realtek/rtw88/rx.c
+++ b/drivers/net/wireless/realtek/rtw88/rx.c
@@ -103,25 +103,9 @@ void rtw_rx_fill_rx_status(struct rtw_dev *rtwdev,
 	else if (pkt_stat->rate >= DESC_RATEMCS0)
 		rx_status->encoding = RX_ENC_HT;
 
-	if (pkt_stat->rate >= DESC_RATEVHT1SS_MCS0 &&
-	    pkt_stat->rate <= DESC_RATEVHT1SS_MCS9) {
-		rx_status->nss = 1;
-		rx_status->rate_idx = pkt_stat->rate - DESC_RATEVHT1SS_MCS0;
-	} else if (pkt_stat->rate >= DESC_RATEVHT2SS_MCS0 &&
-		   pkt_stat->rate <= DESC_RATEVHT2SS_MCS9) {
-		rx_status->nss = 2;
-		rx_status->rate_idx = pkt_stat->rate - DESC_RATEVHT2SS_MCS0;
-	} else if (pkt_stat->rate >= DESC_RATEVHT3SS_MCS0 &&
-		   pkt_stat->rate <= DESC_RATEVHT3SS_MCS9) {
-		rx_status->nss = 3;
-		rx_status->rate_idx = pkt_stat->rate - DESC_RATEVHT3SS_MCS0;
-	} else if (pkt_stat->rate >= DESC_RATEVHT4SS_MCS0 &&
-		   pkt_stat->rate <= DESC_RATEVHT4SS_MCS9) {
-		rx_status->nss = 4;
-		rx_status->rate_idx = pkt_stat->rate - DESC_RATEVHT4SS_MCS0;
-	} else if (pkt_stat->rate >= DESC_RATEMCS0 &&
-		   pkt_stat->rate <= DESC_RATEMCS15) {
-		rx_status->rate_idx = pkt_stat->rate - DESC_RATEMCS0;
+	if (pkt_stat->rate >= DESC_RATEMCS0) {
+		rtw_desc_to_mcsrate(pkt_stat->rate, &rx_status->rate_idx,
+				    &rx_status->nss);
 	} else if (rx_status->band == NL80211_BAND_5GHZ &&
 		   pkt_stat->rate >= DESC_RATE6M &&
 		   pkt_stat->rate <= DESC_RATE54M) {
diff --git a/drivers/net/wireless/realtek/rtw88/util.c b/drivers/net/wireless/realtek/rtw88/util.c
index 212070c2baa8..10f1117c0cfb 100644
--- a/drivers/net/wireless/realtek/rtw88/util.c
+++ b/drivers/net/wireless/realtek/rtw88/util.c
@@ -70,3 +70,30 @@ void rtw_restore_reg(struct rtw_dev *rtwdev,
 		}
 	}
 }
+
+void rtw_desc_to_mcsrate(u16 rate, u8 *mcs, u8 *nss)
+{
+	if (rate <= DESC_RATE54M)
+		return;
+
+	if (rate >= DESC_RATEVHT1SS_MCS0 &&
+	    rate <= DESC_RATEVHT1SS_MCS9) {
+		*nss = 1;
+		*mcs = rate - DESC_RATEVHT1SS_MCS0;
+	} else if (rate >= DESC_RATEVHT2SS_MCS0 &&
+		   rate <= DESC_RATEVHT2SS_MCS9) {
+		*nss = 2;
+		*mcs = rate - DESC_RATEVHT2SS_MCS0;
+	} else if (rate >= DESC_RATEVHT3SS_MCS0 &&
+		   rate <= DESC_RATEVHT3SS_MCS9) {
+		*nss = 3;
+		*mcs = rate - DESC_RATEVHT3SS_MCS0;
+	} else if (rate >= DESC_RATEVHT4SS_MCS0 &&
+		   rate <= DESC_RATEVHT4SS_MCS9) {
+		*nss = 4;
+		*mcs = rate - DESC_RATEVHT4SS_MCS0;
+	} else if (rate >= DESC_RATEMCS0 &&
+		   rate <= DESC_RATEMCS15) {
+		*mcs = rate - DESC_RATEMCS0;
+	}
+}
-- 
2.17.1

