Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08B1F482D80
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Jan 2022 02:54:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbiACByX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 2 Jan 2022 20:54:23 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:59143 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230258AbiACByX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 2 Jan 2022 20:54:23 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 2031sGbyD028563, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 2031sGbyD028563
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 3 Jan 2022 09:54:16 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 3 Jan 2022 09:54:16 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Mon, 3 Jan
 2022 09:54:15 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH] rtw89: correct use of BA CAM
Date:   Mon, 3 Jan 2022 09:54:02 +0800
Message-ID: <20220103015402.19279-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.188]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 01/03/2022 01:44:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzEvMiCkVaTIIDA2OjQ5OjAw?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

BA CAM is used to ACK peer's packets, so it must be established when
IEEE80211_AMPDU_RX_START, and free it by IEEE80211_AMPDU_RX_STOP.

The hardware can support two static BA CAM entries, so I implement a bitmap
and a struct to record which entry is used and its corresponding tid. Also,
the hardware can learn and create dynamic BA CAM entries automatically if
received packets don't match static BA CAM. That means it can still work if
we don't use H2C to set static BA CAM. An exception is tid=0 should be
always allocated in static BA CAM, so an existing static BA CAM will be
replaced if it is full and peer is going to establish a BA with tid=0.

The new firmware use new format of this H2C, so I upgrade it as well.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c     | 45 +++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/core.h     | 11 +++++
 drivers/net/wireless/realtek/rtw89/fw.c       | 25 +++++++++--
 drivers/net/wireless/realtek/rtw89/fw.h       | 25 ++++++++++-
 drivers/net/wireless/realtek/rtw89/mac80211.c |  5 ++-
 5 files changed, 103 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 00ae86807dc21..3d1c4c3b4dcb1 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -1768,6 +1768,51 @@ void rtw89_core_release_all_bits_map(unsigned long *addr, unsigned int nbits)
 	bitmap_zero(addr, nbits);
 }
 
+int rtw89_core_acquire_sta_ba_entry(struct rtw89_sta *rtwsta, u8 tid, u8 *cam_idx)
+{
+	struct rtw89_ba_cam_entry *entry;
+	u8 idx;
+
+	idx = rtw89_core_acquire_bit_map(rtwsta->ba_cam_map, RTW89_BA_CAM_NUM);
+	if (idx == RTW89_BA_CAM_NUM) {
+		/* allocate a static BA CAM to tid=0, so replace the existing
+		 * one if BA CAM is full. Hardware will process the original tid
+		 * automatically.
+		 */
+		if (tid != 0)
+			return -ENOSPC;
+
+		idx = 0;
+	}
+
+	entry = &rtwsta->ba_cam_entry[idx];
+	entry->tid = tid;
+	*cam_idx = idx;
+
+	return 0;
+}
+
+int rtw89_core_release_sta_ba_entry(struct rtw89_sta *rtwsta, u8 tid, u8 *cam_idx)
+{
+	struct rtw89_ba_cam_entry *entry;
+	int i;
+
+	for (i = 0; i < RTW89_BA_CAM_NUM; i++) {
+		if (!test_bit(i, rtwsta->ba_cam_map))
+			continue;
+
+		entry = &rtwsta->ba_cam_entry[i];
+		if (entry->tid != tid)
+			continue;
+
+		rtw89_core_release_bit_map(rtwsta->ba_cam_map, i);
+		*cam_idx = i;
+		return 0;
+	}
+
+	return -ENOENT;
+}
+
 #define RTW89_TYPE_MAPPING(_type)	\
 	case NL80211_IFTYPE_ ## _type:	\
 		rtwvif->wifi_role = RTW89_WIFI_ROLE_ ## _type;	\
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 7c84556ec4ada..afadfc5349d35 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -1831,6 +1831,12 @@ struct rtw89_ra_report {
 
 DECLARE_EWMA(rssi, 10, 16);
 
+#define RTW89_BA_CAM_NUM 2
+
+struct rtw89_ba_cam_entry {
+	u8 tid;
+};
+
 struct rtw89_sta {
 	u8 mac_id;
 	bool disassoc;
@@ -1852,6 +1858,9 @@ struct rtw89_sta {
 	u32 ampdu_max_time:4;
 	bool cctl_tx_retry_limit;
 	u32 data_tx_cnt_lmt:6;
+
+	DECLARE_BITMAP(ba_cam_map, RTW89_BA_CAM_NUM);
+	struct rtw89_ba_cam_entry ba_cam_entry[RTW89_BA_CAM_NUM];
 };
 
 #define RTW89_MAX_ADDR_CAM_NUM		128
@@ -3371,6 +3380,8 @@ void rtw89_set_channel(struct rtw89_dev *rtwdev);
 u8 rtw89_core_acquire_bit_map(unsigned long *addr, unsigned long size);
 void rtw89_core_release_bit_map(unsigned long *addr, u8 bit);
 void rtw89_core_release_all_bits_map(unsigned long *addr, unsigned int nbits);
+int rtw89_core_acquire_sta_ba_entry(struct rtw89_sta *rtwsta, u8 tid, u8 *cam_idx);
+int rtw89_core_release_sta_ba_entry(struct rtw89_sta *rtwsta, u8 tid, u8 *cam_idx);
 void rtw89_vif_type_mapping(struct ieee80211_vif *vif, bool assoc);
 int rtw89_chip_info_setup(struct rtw89_dev *rtwdev);
 u16 rtw89_ra_report_to_bitrate(struct rtw89_dev *rtwdev, u8 rpt_rate);
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index d4b59fbe73659..79bc3e20ab94b 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -555,11 +555,27 @@ int rtw89_fw_h2c_cam(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
 	return -EBUSY;
 }
 
-#define H2C_BA_CAM_LEN 4
-int rtw89_fw_h2c_ba_cam(struct rtw89_dev *rtwdev, bool valid, u8 macid,
-			struct ieee80211_ampdu_params *params)
+#define H2C_BA_CAM_LEN 8
+int rtw89_fw_h2c_ba_cam(struct rtw89_dev *rtwdev, struct rtw89_sta *rtwsta,
+			bool valid, struct ieee80211_ampdu_params *params)
 {
+	u8 macid = rtwsta->mac_id;
 	struct sk_buff *skb;
+	u8 entry_idx;
+	int ret;
+
+	ret = valid ?
+	      rtw89_core_acquire_sta_ba_entry(rtwsta, params->tid, &entry_idx) :
+	      rtw89_core_release_sta_ba_entry(rtwsta, params->tid, &entry_idx);
+	if (ret) {
+		/* it still works even if we don't have static BA CAM, because
+		 * hardware can create dynamic BA CAM automatically.
+		 */
+		rtw89_debug(rtwdev, RTW89_DBG_TXRX,
+			    "failed to %s entry tid=%d for h2c ba cam\n",
+			    valid ? "alloc" : "free", params->tid);
+		return 0;
+	}
 
 	skb = rtw89_fw_h2c_alloc_skb_with_hdr(H2C_BA_CAM_LEN);
 	if (!skb) {
@@ -568,6 +584,7 @@ int rtw89_fw_h2c_ba_cam(struct rtw89_dev *rtwdev, bool valid, u8 macid,
 	}
 	skb_put(skb, H2C_BA_CAM_LEN);
 	SET_BA_CAM_MACID(skb->data, macid);
+	SET_BA_CAM_ENTRY_IDX(skb->data, entry_idx);
 	if (!valid)
 		goto end;
 	SET_BA_CAM_VALID(skb->data, valid);
@@ -577,7 +594,7 @@ int rtw89_fw_h2c_ba_cam(struct rtw89_dev *rtwdev, bool valid, u8 macid,
 	else
 		SET_BA_CAM_BMAP_SIZE(skb->data, 0);
 	/* If init req is set, hw will set the ssn */
-	SET_BA_CAM_INIT_REQ(skb->data, 0);
+	SET_BA_CAM_INIT_REQ(skb->data, 1);
 	SET_BA_CAM_SSN(skb->data, params->ssn);
 
 end:
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index 2d36dc27222ff..b10f6e6a534c4 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -1226,6 +1226,26 @@ static inline void SET_BA_CAM_SSN(void *h2c, u32 val)
 	le32p_replace_bits((__le32 *)h2c, val, GENMASK(31, 20));
 }
 
+static inline void SET_BA_CAM_UID(void *h2c, u32 val)
+{
+	le32p_replace_bits((__le32 *)h2c + 1, val, GENMASK(7, 0));
+}
+
+static inline void SET_BA_CAM_STD_EN(void *h2c, u32 val)
+{
+	le32p_replace_bits((__le32 *)h2c + 1, val, BIT(8));
+}
+
+static inline void SET_BA_CAM_BAND(void *h2c, u32 val)
+{
+	le32p_replace_bits((__le32 *)h2c + 1, val, BIT(9));
+}
+
+static inline void SET_BA_CAM_ENTRY_IDX_V1(void *h2c, u32 val)
+{
+	le32p_replace_bits((__le32 *)h2c + 1, val, GENMASK(31, 28));
+}
+
 static inline void SET_LPS_PARM_MACID(void *h2c, u32 val)
 {
 	le32p_replace_bits((__le32 *)h2c, val, GENMASK(7, 0));
@@ -1785,8 +1805,9 @@ int rtw89_fw_h2c_raw(struct rtw89_dev *rtwdev, const u8 *buf, u16 len);
 void rtw89_fw_send_all_early_h2c(struct rtw89_dev *rtwdev);
 void rtw89_fw_free_all_early_h2c(struct rtw89_dev *rtwdev);
 int rtw89_fw_h2c_general_pkt(struct rtw89_dev *rtwdev, u8 macid);
-int rtw89_fw_h2c_ba_cam(struct rtw89_dev *rtwdev, bool valid, u8 macid,
-			struct ieee80211_ampdu_params *params);
+int rtw89_fw_h2c_ba_cam(struct rtw89_dev *rtwdev, struct rtw89_sta *rtwsta,
+			bool valid, struct ieee80211_ampdu_params *params);
+
 int rtw89_fw_h2c_lps_parm(struct rtw89_dev *rtwdev,
 			  struct rtw89_lps_parm *lps_param);
 struct sk_buff *rtw89_fw_h2c_alloc_skb_with_hdr(u32 len);
diff --git a/drivers/net/wireless/realtek/rtw89/mac80211.c b/drivers/net/wireless/realtek/rtw89/mac80211.c
index a322259f4cc4a..0fa6477021ffc 100644
--- a/drivers/net/wireless/realtek/rtw89/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw89/mac80211.c
@@ -476,7 +476,6 @@ static int rtw89_ops_ampdu_action(struct ieee80211_hw *hw,
 	case IEEE80211_AMPDU_TX_STOP_FLUSH_CONT:
 		mutex_lock(&rtwdev->mutex);
 		clear_bit(RTW89_TXQ_F_AMPDU, &rtwtxq->flags);
-		rtw89_fw_h2c_ba_cam(rtwdev, false, rtwsta->mac_id, params);
 		mutex_unlock(&rtwdev->mutex);
 		ieee80211_stop_tx_ba_cb_irqsafe(vif, sta->addr, tid);
 		break;
@@ -486,11 +485,13 @@ static int rtw89_ops_ampdu_action(struct ieee80211_hw *hw,
 		rtwsta->ampdu_params[tid].agg_num = params->buf_size;
 		rtwsta->ampdu_params[tid].amsdu = params->amsdu;
 		rtw89_leave_ps_mode(rtwdev);
-		rtw89_fw_h2c_ba_cam(rtwdev, true, rtwsta->mac_id, params);
 		mutex_unlock(&rtwdev->mutex);
 		break;
 	case IEEE80211_AMPDU_RX_START:
+		rtw89_fw_h2c_ba_cam(rtwdev, rtwsta, true, params);
+		break;
 	case IEEE80211_AMPDU_RX_STOP:
+		rtw89_fw_h2c_ba_cam(rtwdev, rtwsta, false, params);
 		break;
 	default:
 		WARN_ON(1);
-- 
2.25.1

