Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49D1E582075
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Jul 2022 08:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbiG0Gvv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 Jul 2022 02:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230472AbiG0Gv2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 Jul 2022 02:51:28 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 33A55DFCF
        for <linux-wireless@vger.kernel.org>; Tue, 26 Jul 2022 23:50:50 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 26R6oR5B1001384, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 26R6oR5B1001384
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Wed, 27 Jul 2022 14:50:27 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 27 Jul 2022 14:50:34 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.27; Wed, 27 Jul
 2022 14:50:32 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <tony0620emma@gmail.com>, <kvalo@kernel.org>
CC:     <gary.chang@realtek.com>, <phhuang@realtek.com>,
        <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH v3 1/4] rtw88: 8822c: extend supported probe request size
Date:   Wed, 27 Jul 2022 14:50:00 +0800
Message-ID: <20220727065003.28340-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220727065003.28340-1-pkshih@realtek.com>
References: <20220727065003.28340-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 07/27/2022 06:32:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzcvMjcgpFekyCAwMToxNDowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Po-Hao Huang <phhuang@realtek.com>

Some WSC IEs require size larger than we current supports. Extend size
to fit those demands. Separate the registered scan IE length by IC so
settings can be independent.

Since old firmware uses fewer page number, define a firmware feature to
be compatible with various firmware version.

Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/fw.c       | 15 +++++++++----
 drivers/net/wireless/realtek/rtw88/fw.h       | 18 +++++++++++++++-
 drivers/net/wireless/realtek/rtw88/main.c     | 21 ++++++++++++++++++-
 drivers/net/wireless/realtek/rtw88/main.h     |  4 +++-
 drivers/net/wireless/realtek/rtw88/rtw8723d.c |  3 ++-
 drivers/net/wireless/realtek/rtw88/rtw8821c.c |  3 ++-
 drivers/net/wireless/realtek/rtw88/rtw8822b.c |  3 ++-
 drivers/net/wireless/realtek/rtw88/rtw8822c.c |  3 ++-
 8 files changed, 59 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/fw.c b/drivers/net/wireless/realtek/rtw88/fw.c
index 4fdab03296956..efa51b2f53025 100644
--- a/drivers/net/wireless/realtek/rtw88/fw.c
+++ b/drivers/net/wireless/realtek/rtw88/fw.c
@@ -1844,13 +1844,20 @@ static int _rtw_hw_scan_update_probe_req(struct rtw_dev *rtwdev, u8 num_probes,
 	struct rtw_chip_info *chip = rtwdev->chip;
 	struct sk_buff *skb, *tmp;
 	u8 page_offset = 1, *buf, page_size = chip->page_size;
-	u8 pages = page_offset + num_probes * RTW_PROBE_PG_CNT;
 	u16 pg_addr = rtwdev->fifo.rsvd_h2c_info_addr, loc;
 	u16 buf_offset = page_size * page_offset;
 	u8 tx_desc_sz = chip->tx_pkt_desc_sz;
+	u8 page_cnt, pages;
 	unsigned int pkt_len;
 	int ret;
 
+	if (rtw_fw_feature_ext_check(&rtwdev->fw, FW_FEATURE_EXT_OLD_PAGE_NUM))
+		page_cnt = RTW_OLD_PROBE_PG_CNT;
+	else
+		page_cnt = RTW_PROBE_PG_CNT;
+
+	pages = page_offset + num_probes * page_cnt;
+
 	buf = kzalloc(page_size * pages, GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
@@ -1859,7 +1866,7 @@ static int _rtw_hw_scan_update_probe_req(struct rtw_dev *rtwdev, u8 num_probes,
 	skb_queue_walk_safe(probe_req_list, skb, tmp) {
 		skb_unlink(skb, probe_req_list);
 		rtw_fill_rsvd_page_desc(rtwdev, skb, RSVD_PROBE_REQ);
-		if (skb->len > page_size * RTW_PROBE_PG_CNT) {
+		if (skb->len > page_size * page_cnt) {
 			ret = -EINVAL;
 			goto out;
 		}
@@ -1869,8 +1876,8 @@ static int _rtw_hw_scan_update_probe_req(struct rtw_dev *rtwdev, u8 num_probes,
 		loc = pg_addr - rtwdev->fifo.rsvd_boundary + page_offset;
 		__rtw_fw_update_pkt(rtwdev, RTW_PACKET_PROBE_REQ, pkt_len, loc);
 
-		buf_offset += RTW_PROBE_PG_CNT * page_size;
-		page_offset += RTW_PROBE_PG_CNT;
+		buf_offset += page_cnt * page_size;
+		page_offset += page_cnt;
 		kfree_skb(skb);
 	}
 
diff --git a/drivers/net/wireless/realtek/rtw88/fw.h b/drivers/net/wireless/realtek/rtw88/fw.h
index 7a37675c61e89..bd3b9318b2438 100644
--- a/drivers/net/wireless/realtek/rtw88/fw.h
+++ b/drivers/net/wireless/realtek/rtw88/fw.h
@@ -41,7 +41,8 @@
 #define RTW_EX_CH_INFO_HDR_SIZE		2
 #define RTW_SCAN_WIDTH			0
 #define RTW_PRI_CH_IDX			1
-#define RTW_PROBE_PG_CNT		2
+#define RTW_OLD_PROBE_PG_CNT		2
+#define RTW_PROBE_PG_CNT		4
 
 enum rtw_c2h_cmd_id {
 	C2H_CCX_TX_RPT = 0x03,
@@ -120,6 +121,10 @@ enum rtw_fw_feature {
 	FW_FEATURE_MAX = BIT(31),
 };
 
+enum rtw_fw_feature_ext {
+	FW_FEATURE_EXT_OLD_PAGE_NUM = BIT(0),
+};
+
 enum rtw_beacon_filter_offload_mode {
 	BCN_FILTER_OFFLOAD_MODE_0 = 0,
 	BCN_FILTER_OFFLOAD_MODE_1,
@@ -323,6 +328,11 @@ struct rtw_fw_hdr_legacy {
 	__le32 rsvd5;
 } __packed;
 
+#define RTW_FW_VER_CODE(ver, sub_ver, idx)	\
+	(((ver) << 16) | ((sub_ver) << 8) | (idx))
+#define RTW_FW_SUIT_VER_CODE(s)	\
+	RTW_FW_VER_CODE((s).version, (s).sub_version, (s).sub_index)
+
 /* C2H */
 #define GET_CCX_REPORT_SEQNUM_V0(c2h_payload)	(c2h_payload[6] & 0xfc)
 #define GET_CCX_REPORT_STATUS_V0(c2h_payload)	(c2h_payload[0] & 0xc0)
@@ -770,6 +780,12 @@ static inline bool rtw_fw_feature_check(struct rtw_fw_state *fw,
 	return !!(fw->feature & feature);
 }
 
+static inline bool rtw_fw_feature_ext_check(struct rtw_fw_state *fw,
+					    enum rtw_fw_feature_ext feature)
+{
+	return !!(fw->feature_ext & feature);
+}
+
 void rtw_fw_c2h_cmd_rx_irqsafe(struct rtw_dev *rtwdev, u32 pkt_offset,
 			       struct sk_buff *skb);
 void rtw_fw_c2h_cmd_handle(struct rtw_dev *rtwdev, struct sk_buff *skb);
diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index 985ee36efc0f3..7e4c63cc3fff8 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -1552,6 +1552,21 @@ static void rtw_init_vht_cap(struct rtw_dev *rtwdev,
 	vht_cap->vht_mcs.tx_highest = highest;
 }
 
+static u16 rtw_get_max_scan_ie_len(struct rtw_dev *rtwdev)
+{
+	u16 len;
+
+	len = rtwdev->chip->max_scan_ie_len;
+
+	if (!rtw_fw_feature_check(&rtwdev->fw, FW_FEATURE_SCAN_OFFLOAD) &&
+	    rtwdev->chip->id == RTW_CHIP_TYPE_8822C)
+		len = IEEE80211_MAX_DATA_LEN;
+	else if (rtw_fw_feature_ext_check(&rtwdev->fw, FW_FEATURE_EXT_OLD_PAGE_NUM))
+		len -= RTW_OLD_PROBE_PG_CNT * TX_PAGE_SIZE;
+
+	return len;
+}
+
 static void rtw_set_supported_band(struct ieee80211_hw *hw,
 				   struct rtw_chip_info *chip)
 {
@@ -1631,6 +1646,10 @@ static void __update_firmware_feature(struct rtw_dev *rtwdev,
 
 	feature = le32_to_cpu(fw_hdr->feature);
 	fw->feature = feature & FW_FEATURE_SIG ? feature : 0;
+
+	if (rtwdev->chip->id == RTW_CHIP_TYPE_8822C &&
+	    RTW_FW_SUIT_VER_CODE(rtwdev->fw) < RTW_FW_VER_CODE(9, 9, 13))
+		fw->feature_ext |= FW_FEATURE_EXT_OLD_PAGE_NUM;
 }
 
 static void __update_firmware_info(struct rtw_dev *rtwdev,
@@ -2132,7 +2151,7 @@ int rtw_register_hw(struct rtw_dev *rtwdev, struct ieee80211_hw *hw)
 
 	hw->wiphy->features |= NL80211_FEATURE_SCAN_RANDOM_MAC_ADDR;
 	hw->wiphy->max_scan_ssids = RTW_SCAN_MAX_SSIDS;
-	hw->wiphy->max_scan_ie_len = RTW_SCAN_MAX_IE_LEN;
+	hw->wiphy->max_scan_ie_len = rtw_get_max_scan_ie_len(rtwdev);
 
 	wiphy_ext_feature_set(hw->wiphy, NL80211_EXT_FEATURE_CAN_REPLACE_PTK0);
 	wiphy_ext_feature_set(hw->wiphy, NL80211_EXT_FEATURE_SCAN_RANDOM_SN);
diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index 7db627fc26be9..69d0a700c2ae9 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -22,7 +22,6 @@
 #define MAX_PG_CAM_BACKUP_NUM		8
 
 #define RTW_SCAN_MAX_SSIDS		4
-#define RTW_SCAN_MAX_IE_LEN		128
 
 #define RTW_MAX_PATTERN_NUM		12
 #define RTW_MAX_PATTERN_MASK_SIZE	16
@@ -33,6 +32,7 @@
 #define RFREG_MASK			0xfffff
 #define INV_RF_DATA			0xffffffff
 #define TX_PAGE_SIZE_SHIFT		7
+#define TX_PAGE_SIZE			(1 << TX_PAGE_SIZE_SHIFT)
 
 #define RTW_CHANNEL_WIDTH_MAX		3
 #define RTW_RF_PATH_MAX			4
@@ -1232,6 +1232,7 @@ struct rtw_chip_info {
 	const char *wow_fw_name;
 	const struct wiphy_wowlan_support *wowlan_stub;
 	const u8 max_sched_scan_ssids;
+	const u16 max_scan_ie_len;
 
 	/* coex paras */
 	u32 coex_para_ver;
@@ -1853,6 +1854,7 @@ struct rtw_fw_state {
 	u8 sub_index;
 	u16 h2c_version;
 	u32 feature;
+	u32 feature_ext;
 };
 
 enum rtw_sar_sources {
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8723d.c b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
index 993bd6b1d723e..0a4f770fcbb7e 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8723d.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
@@ -2720,7 +2720,7 @@ const struct rtw_chip_info rtw8723d_hw_spec = {
 	.max_power_index = 0x3f,
 	.csi_buf_pg_num = 0,
 	.band = RTW_BAND_2G,
-	.page_size = 128,
+	.page_size = TX_PAGE_SIZE,
 	.dig_min = 0x20,
 	.ht_supported = true,
 	.vht_supported = false,
@@ -2748,6 +2748,7 @@ const struct rtw_chip_info rtw8723d_hw_spec = {
 	.pwr_track_tbl = &rtw8723d_rtw_pwr_track_tbl,
 	.iqk_threshold = 8,
 	.ampdu_density = IEEE80211_HT_MPDU_DENSITY_16,
+	.max_scan_ie_len = IEEE80211_MAX_DATA_LEN,
 
 	.coex_para_ver = 0x2007022f,
 	.bt_desired_ver = 0x2f,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8821c.c b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
index 025262a8970eb..9afdc5ce86b43 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8821c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
@@ -1898,7 +1898,7 @@ const struct rtw_chip_info rtw8821c_hw_spec = {
 	.max_power_index = 0x3f,
 	.csi_buf_pg_num = 0,
 	.band = RTW_BAND_2G | RTW_BAND_5G,
-	.page_size = 128,
+	.page_size = TX_PAGE_SIZE,
 	.dig_min = 0x1c,
 	.ht_supported = true,
 	.vht_supported = true,
@@ -1926,6 +1926,7 @@ const struct rtw_chip_info rtw8821c_hw_spec = {
 	.bfer_su_max_num = 2,
 	.bfer_mu_max_num = 1,
 	.ampdu_density = IEEE80211_HT_MPDU_DENSITY_2,
+	.max_scan_ie_len = IEEE80211_MAX_DATA_LEN,
 
 	.coex_para_ver = 0x19092746,
 	.bt_desired_ver = 0x46,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822b.c b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
index 321848870561e..690e35c98f6e5 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822b.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
@@ -2517,7 +2517,7 @@ const struct rtw_chip_info rtw8822b_hw_spec = {
 	.max_power_index = 0x3f,
 	.csi_buf_pg_num = 0,
 	.band = RTW_BAND_2G | RTW_BAND_5G,
-	.page_size = 128,
+	.page_size = TX_PAGE_SIZE,
 	.dig_min = 0x1c,
 	.ht_supported = true,
 	.vht_supported = true,
@@ -2549,6 +2549,7 @@ const struct rtw_chip_info rtw8822b_hw_spec = {
 	.l2h_th_ini_cs = 10 + EDCCA_IGI_BASE,
 	.l2h_th_ini_ad = -14 + EDCCA_IGI_BASE,
 	.ampdu_density = IEEE80211_HT_MPDU_DENSITY_2,
+	.max_scan_ie_len = IEEE80211_MAX_DATA_LEN,
 
 	.coex_para_ver = 0x20070206,
 	.bt_desired_ver = 0x6,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822c.c b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
index 09f9e4adcf349..fccb15dfb9595 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
@@ -5330,7 +5330,7 @@ const struct rtw_chip_info rtw8822c_hw_spec = {
 	.max_power_index = 0x7f,
 	.csi_buf_pg_num = 50,
 	.band = RTW_BAND_2G | RTW_BAND_5G,
-	.page_size = 128,
+	.page_size = TX_PAGE_SIZE,
 	.dig_min = 0x20,
 	.default_1ss_tx_path = BB_PATH_A,
 	.path_div_supported = true,
@@ -5375,6 +5375,7 @@ const struct rtw_chip_info rtw8822c_hw_spec = {
 	.wowlan_stub = &rtw_wowlan_stub_8822c,
 	.max_sched_scan_ssids = 4,
 #endif
+	.max_scan_ie_len = (RTW_PROBE_PG_CNT - 1) * TX_PAGE_SIZE,
 	.coex_para_ver = 0x22020720,
 	.bt_desired_ver = 0x20,
 	.scbd_support = true,
-- 
2.25.1

