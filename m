Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F425592A1D
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Aug 2022 09:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241390AbiHOHIE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 15 Aug 2022 03:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241417AbiHOHH4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 15 Aug 2022 03:07:56 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 683D71CB3F
        for <linux-wireless@vger.kernel.org>; Mon, 15 Aug 2022 00:07:51 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 27F77QxD4005761, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 27F77QxD4005761
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Mon, 15 Aug 2022 15:07:26 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Mon, 15 Aug 2022 15:07:38 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Mon, 15 Aug
 2022 15:07:38 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 3/3] wifi: rtw89: correct BA CAM allocation
Date:   Mon, 15 Aug 2022 15:07:03 +0800
Message-ID: <20220815070703.26965-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220815070703.26965-1-pkshih@realtek.com>
References: <20220815070703.26965-1-pkshih@realtek.com>
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
X-KSE-Antiphishing-Bases: 08/15/2022 06:50:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzgvMTUgpFekyCAwMjozODowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

BA CAM entries are global resource of hardware, so move the bitmap and
instances to rtw89_cam_info, and then use link list from rtw89_sta to
these instances.

To check the allocation, add ba_cam to debugfs:

  map:
  	mac_id:    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  	addr_cam:  01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  	bssid_cam: 01 00 00 00 00 00 00 00
  	sec_cam:   00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  	ba_cam:    03 00 00 00 00 00 00 00
  VIF [0] 94:08:53:8e:ef:21
  	bssid_cam_idx=0
  	addr_cam_idx=0
  	-> bssid_cam_idx=0
  	sec_cam_bitmap=00 00 00 00 00 00 00 00
  STA [0] 38:78:62:8b:cb:c6
  	addr_cam_idx=0
  	-> bssid_cam_idx=0
  	sec_cam_bitmap=00 00 00 00 00 00 00 00
  	ba_cam tid[6]=0, tid[1]=1

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c  | 51 +++++++++++++++-------
 drivers/net/wireless/realtek/rtw89/core.h  |  7 +--
 drivers/net/wireless/realtek/rtw89/debug.c | 27 ++++++++++++
 drivers/net/wireless/realtek/rtw89/ser.c   |  8 +++-
 4 files changed, 73 insertions(+), 20 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 2ec4cc11b29e1..608896dd0d158 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -2270,23 +2270,42 @@ int rtw89_core_acquire_sta_ba_entry(struct rtw89_dev *rtwdev,
 				    struct rtw89_sta *rtwsta, u8 tid, u8 *cam_idx)
 {
 	const struct rtw89_chip_info *chip = rtwdev->chip;
-	struct rtw89_ba_cam_entry *entry;
+	struct rtw89_cam_info *cam_info = &rtwdev->cam_info;
+	struct rtw89_ba_cam_entry *entry = NULL, *tmp;
 	u8 idx;
+	int i;
+
+	lockdep_assert_held(&rtwdev->mutex);
 
-	idx = rtw89_core_acquire_bit_map(rtwsta->ba_cam_map, chip->bacam_num);
+	idx = rtw89_core_acquire_bit_map(cam_info->ba_cam_map, chip->bacam_num);
 	if (idx == chip->bacam_num) {
-		/* allocate a static BA CAM to tid=0, so replace the existing
+		/* allocate a static BA CAM to tid=0/5, so replace the existing
 		 * one if BA CAM is full. Hardware will process the original tid
 		 * automatically.
 		 */
-		if (tid != 0)
+		if (tid != 0 && tid != 5)
 			return -ENOSPC;
 
-		idx = 0;
+		for_each_set_bit(i, cam_info->ba_cam_map, chip->bacam_num) {
+			tmp = &cam_info->ba_cam_entry[i];
+			if (tmp->tid == 0 || tmp->tid == 5)
+				continue;
+
+			idx = i;
+			entry = tmp;
+			list_del(&entry->list);
+			break;
+		}
+
+		if (!entry)
+			return -ENOSPC;
+	} else {
+		entry = &cam_info->ba_cam_entry[idx];
 	}
 
-	entry = &rtwsta->ba_cam_entry[idx];
 	entry->tid = tid;
+	list_add_tail(&entry->list, &rtwsta->ba_cam_list);
+
 	*cam_idx = idx;
 
 	return 0;
@@ -2295,20 +2314,21 @@ int rtw89_core_acquire_sta_ba_entry(struct rtw89_dev *rtwdev,
 int rtw89_core_release_sta_ba_entry(struct rtw89_dev *rtwdev,
 				    struct rtw89_sta *rtwsta, u8 tid, u8 *cam_idx)
 {
-	const struct rtw89_chip_info *chip = rtwdev->chip;
-	struct rtw89_ba_cam_entry *entry;
-	int i;
+	struct rtw89_cam_info *cam_info = &rtwdev->cam_info;
+	struct rtw89_ba_cam_entry *entry = NULL, *tmp;
+	u8 idx;
 
-	for (i = 0; i < chip->bacam_num; i++) {
-		if (!test_bit(i, rtwsta->ba_cam_map))
-			continue;
+	lockdep_assert_held(&rtwdev->mutex);
 
-		entry = &rtwsta->ba_cam_entry[i];
+	list_for_each_entry_safe(entry, tmp, &rtwsta->ba_cam_list, list) {
 		if (entry->tid != tid)
 			continue;
 
-		rtw89_core_release_bit_map(rtwsta->ba_cam_map, i);
-		*cam_idx = i;
+		idx = entry - cam_info->ba_cam_entry;
+		list_del(&entry->list);
+
+		rtw89_core_release_bit_map(cam_info->ba_cam_map, idx);
+		*cam_idx = idx;
 		return 0;
 	}
 
@@ -2371,6 +2391,7 @@ int rtw89_core_sta_add(struct rtw89_dev *rtwdev,
 
 	rtwsta->rtwvif = rtwvif;
 	rtwsta->prev_rssi = 0;
+	INIT_LIST_HEAD(&rtwsta->ba_cam_list);
 
 	for (i = 0; i < ARRAY_SIZE(sta->txq); i++)
 		rtw89_core_txq_init(rtwdev, sta->txq[i]);
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index d06cfb8025318..6fd129f03b89d 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -1916,6 +1916,7 @@ struct rtw89_ra_report {
 DECLARE_EWMA(rssi, 10, 16);
 
 struct rtw89_ba_cam_entry {
+	struct list_head list;
 	u8 tid;
 };
 
@@ -1978,6 +1979,7 @@ struct rtw89_sta {
 	__le32 htc_template;
 	struct rtw89_addr_cam_entry addr_cam; /* AP mode or TDLS peer only */
 	struct rtw89_bssid_cam_entry bssid_cam; /* TDLS peer only */
+	struct list_head ba_cam_list;
 
 	bool use_cfg_mask;
 	struct cfg80211_bitrate_mask mask;
@@ -1986,9 +1988,6 @@ struct rtw89_sta {
 	u32 ampdu_max_time:4;
 	bool cctl_tx_retry_limit;
 	u32 data_tx_cnt_lmt:6;
-
-	DECLARE_BITMAP(ba_cam_map, RTW89_MAX_BA_CAM_NUM);
-	struct rtw89_ba_cam_entry ba_cam_entry[RTW89_MAX_BA_CAM_NUM];
 };
 
 struct rtw89_efuse {
@@ -2560,6 +2559,8 @@ struct rtw89_cam_info {
 	DECLARE_BITMAP(addr_cam_map, RTW89_MAX_ADDR_CAM_NUM);
 	DECLARE_BITMAP(bssid_cam_map, RTW89_MAX_BSSID_CAM_NUM);
 	DECLARE_BITMAP(sec_cam_map, RTW89_MAX_SEC_CAM_NUM);
+	DECLARE_BITMAP(ba_cam_map, RTW89_MAX_BA_CAM_NUM);
+	struct rtw89_ba_cam_entry ba_cam_entry[RTW89_MAX_BA_CAM_NUM];
 };
 
 enum rtw89_sar_sources {
diff --git a/drivers/net/wireless/realtek/rtw89/debug.c b/drivers/net/wireless/realtek/rtw89/debug.c
index 829c61da99bb9..1a7ba12229cc8 100644
--- a/drivers/net/wireless/realtek/rtw89/debug.c
+++ b/drivers/net/wireless/realtek/rtw89/debug.c
@@ -2433,6 +2433,26 @@ void rtw89_vif_ids_get_iter(void *data, u8 *mac, struct ieee80211_vif *vif)
 	rtw89_dump_addr_cam(m, &rtwvif->addr_cam);
 }
 
+static void rtw89_dump_ba_cam(struct seq_file *m, struct rtw89_sta *rtwsta)
+{
+	struct rtw89_vif *rtwvif = rtwsta->rtwvif;
+	struct rtw89_dev *rtwdev = rtwvif->rtwdev;
+	struct rtw89_ba_cam_entry *entry;
+	bool first = true;
+
+	list_for_each_entry(entry, &rtwsta->ba_cam_list, list) {
+		if (first) {
+			seq_puts(m, "\tba_cam ");
+			first = false;
+		} else {
+			seq_puts(m, ", ");
+		}
+		seq_printf(m, "tid[%u]=%ld", entry->tid,
+			   entry - rtwdev->cam_info.ba_cam_entry);
+	}
+	seq_puts(m, "\n");
+}
+
 static void rtw89_sta_ids_get_iter(void *data, struct ieee80211_sta *sta)
 {
 	struct rtw89_sta *rtwsta = (struct rtw89_sta *)sta->drv_priv;
@@ -2441,6 +2461,7 @@ static void rtw89_sta_ids_get_iter(void *data, struct ieee80211_sta *sta)
 	seq_printf(m, "STA [%d] %pM %s\n", rtwsta->mac_id, sta->addr,
 		   sta->tdls ? "(TDLS)" : "");
 	rtw89_dump_addr_cam(m, &rtwsta->addr_cam);
+	rtw89_dump_ba_cam(m, rtwsta);
 }
 
 static int rtw89_debug_priv_stations_get(struct seq_file *m, void *v)
@@ -2449,6 +2470,8 @@ static int rtw89_debug_priv_stations_get(struct seq_file *m, void *v)
 	struct rtw89_dev *rtwdev = debugfs_priv->rtwdev;
 	struct rtw89_cam_info *cam_info = &rtwdev->cam_info;
 
+	mutex_lock(&rtwdev->mutex);
+
 	seq_puts(m, "map:\n");
 	seq_printf(m, "\tmac_id:    %*ph\n", (int)sizeof(rtwdev->mac_id_map),
 		   rtwdev->mac_id_map);
@@ -2458,12 +2481,16 @@ static int rtw89_debug_priv_stations_get(struct seq_file *m, void *v)
 		   cam_info->bssid_cam_map);
 	seq_printf(m, "\tsec_cam:   %*ph\n", (int)sizeof(cam_info->sec_cam_map),
 		   cam_info->sec_cam_map);
+	seq_printf(m, "\tba_cam:    %*ph\n", (int)sizeof(cam_info->ba_cam_map),
+		   cam_info->ba_cam_map);
 
 	ieee80211_iterate_active_interfaces_atomic(rtwdev->hw,
 		IEEE80211_IFACE_ITER_NORMAL, rtw89_vif_ids_get_iter, m);
 
 	ieee80211_iterate_stations_atomic(rtwdev->hw, rtw89_sta_ids_get_iter, m);
 
+	mutex_unlock(&rtwdev->mutex);
+
 	return 0;
 }
 
diff --git a/drivers/net/wireless/realtek/rtw89/ser.c b/drivers/net/wireless/realtek/rtw89/ser.c
index 726223f25dc69..33aaa4dd05ef0 100644
--- a/drivers/net/wireless/realtek/rtw89/ser.c
+++ b/drivers/net/wireless/realtek/rtw89/ser.c
@@ -298,7 +298,7 @@ static void ser_reset_vif(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
 	rtwvif->trigger = false;
 }
 
-static void ser_sta_deinit_addr_cam_iter(void *data, struct ieee80211_sta *sta)
+static void ser_sta_deinit_cam_iter(void *data, struct ieee80211_sta *sta)
 {
 	struct rtw89_vif *rtwvif = (struct rtw89_vif *)data;
 	struct rtw89_dev *rtwdev = rtwvif->rtwdev;
@@ -308,15 +308,19 @@ static void ser_sta_deinit_addr_cam_iter(void *data, struct ieee80211_sta *sta)
 		rtw89_cam_deinit_addr_cam(rtwdev, &rtwsta->addr_cam);
 	if (sta->tdls)
 		rtw89_cam_deinit_bssid_cam(rtwdev, &rtwsta->bssid_cam);
+
+	INIT_LIST_HEAD(&rtwsta->ba_cam_list);
 }
 
 static void ser_deinit_cam(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
 {
 	ieee80211_iterate_stations_atomic(rtwdev->hw,
-					  ser_sta_deinit_addr_cam_iter,
+					  ser_sta_deinit_cam_iter,
 					  rtwvif);
 
 	rtw89_cam_deinit(rtwdev, rtwvif);
+
+	bitmap_zero(rtwdev->cam_info.ba_cam_map, RTW89_MAX_BA_CAM_NUM);
 }
 
 static void ser_reset_mac_binding(struct rtw89_dev *rtwdev)
-- 
2.25.1

