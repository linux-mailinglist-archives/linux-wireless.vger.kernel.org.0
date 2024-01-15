Return-Path: <linux-wireless+bounces-1908-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 929A582D367
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jan 2024 04:38:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 614FE2815CC
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jan 2024 03:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0CF820E6;
	Mon, 15 Jan 2024 03:38:22 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20914186A
	for <linux-wireless@vger.kernel.org>; Mon, 15 Jan 2024 03:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 40F3cF3I13528795, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 40F3cF3I13528795
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Jan 2024 11:38:15 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.17; Mon, 15 Jan 2024 11:38:15 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 15 Jan
 2024 11:38:15 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH 3/8] wifi: rtw89: fw: add chip_ops to update CMAC table to associated station
Date: Mon, 15 Jan 2024 11:37:37 +0800
Message-ID: <20240115033742.16372-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240115033742.16372-1-pkshih@realtek.com>
References: <20240115033742.16372-1-pkshih@realtek.com>
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

For WiFi 7 chips, we add H2C command with rich fields to support MLO, so
add a chip_ops to generalize calling of update CMAC table.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c     | 4 ++--
 drivers/net/wireless/realtek/rtw89/core.h     | 3 +++
 drivers/net/wireless/realtek/rtw89/fw.c       | 2 ++
 drivers/net/wireless/realtek/rtw89/fw.h       | 9 +++++++++
 drivers/net/wireless/realtek/rtw89/mac80211.c | 4 ++--
 drivers/net/wireless/realtek/rtw89/rtw8851b.c | 1 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c | 1 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c | 1 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c | 1 +
 drivers/net/wireless/realtek/rtw89/rtw8922a.c | 1 +
 drivers/net/wireless/realtek/rtw89/wow.c      | 2 +-
 11 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index ac7ae19429f9..1a355fe0d986 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -3393,7 +3393,7 @@ int rtw89_core_sta_disconnect(struct rtw89_dev *rtwdev,
 		rtw89_fw_release_general_pkt_list_vif(rtwdev, rtwvif, true);
 	}
 
-	ret = rtw89_fw_h2c_assoc_cmac_tbl(rtwdev, vif, sta);
+	ret = rtw89_chip_h2c_assoc_cmac_tbl(rtwdev, vif, sta);
 	if (ret) {
 		rtw89_warn(rtwdev, "failed to send h2c cmac table\n");
 		return ret;
@@ -3442,7 +3442,7 @@ int rtw89_core_sta_assoc(struct rtw89_dev *rtwdev,
 		}
 	}
 
-	ret = rtw89_fw_h2c_assoc_cmac_tbl(rtwdev, vif, sta);
+	ret = rtw89_chip_h2c_assoc_cmac_tbl(rtwdev, vif, sta);
 	if (ret) {
 		rtw89_warn(rtwdev, "failed to send h2c cmac table\n");
 		return ret;
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 88ae5cc85877..3a56fcaf892a 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -3197,6 +3197,9 @@ struct rtw89_chip_ops {
 	int (*h2c_dctl_sec_cam)(struct rtw89_dev *rtwdev,
 				struct rtw89_vif *rtwvif,
 				struct rtw89_sta *rtwsta);
+	int (*h2c_assoc_cmac_tbl)(struct rtw89_dev *rtwdev,
+				  struct ieee80211_vif *vif,
+				  struct ieee80211_sta *sta);
 	int (*h2c_update_beacon)(struct rtw89_dev *rtwdev,
 				 struct rtw89_vif *rtwvif);
 	int (*h2c_ba_cam)(struct rtw89_dev *rtwdev, struct rtw89_sta *rtwsta,
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 7c33b10a39be..fc1295d5d8e8 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -2231,6 +2231,7 @@ int rtw89_fw_h2c_assoc_cmac_tbl(struct rtw89_dev *rtwdev,
 
 	return ret;
 }
+EXPORT_SYMBOL(rtw89_fw_h2c_assoc_cmac_tbl);
 
 static void __get_sta_eht_pkt_padding(struct rtw89_dev *rtwdev,
 				      struct ieee80211_sta *sta, u8 *pads)
@@ -2401,6 +2402,7 @@ int rtw89_fw_h2c_assoc_cmac_tbl_g7(struct rtw89_dev *rtwdev,
 
 	return ret;
 }
+EXPORT_SYMBOL(rtw89_fw_h2c_assoc_cmac_tbl_g7);
 
 int rtw89_fw_h2c_txtime_cmac_tbl(struct rtw89_dev *rtwdev,
 				 struct rtw89_sta *rtwsta)
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index dad09e57b821..f1f119358b28 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -4094,6 +4094,15 @@ static inline int rtw89_chip_h2c_update_beacon(struct rtw89_dev *rtwdev,
 	return chip->ops->h2c_update_beacon(rtwdev, rtwvif);
 }
 
+static inline int rtw89_chip_h2c_assoc_cmac_tbl(struct rtw89_dev *rtwdev,
+						struct ieee80211_vif *vif,
+						struct ieee80211_sta *sta)
+{
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+
+	return chip->ops->h2c_assoc_cmac_tbl(rtwdev, vif, sta);
+}
+
 static inline
 int rtw89_chip_h2c_ba_cam(struct rtw89_dev *rtwdev, struct rtw89_sta *rtwsta,
 			  bool valid, struct ieee80211_ampdu_params *params)
diff --git a/drivers/net/wireless/realtek/rtw89/mac80211.c b/drivers/net/wireless/realtek/rtw89/mac80211.c
index c023c182be6a..71d5e6f7bb64 100644
--- a/drivers/net/wireless/realtek/rtw89/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw89/mac80211.c
@@ -497,7 +497,7 @@ static int rtw89_ops_start_ap(struct ieee80211_hw *hw,
 	ether_addr_copy(rtwvif->bssid, vif->bss_conf.bssid);
 	rtw89_cam_bssid_changed(rtwdev, rtwvif);
 	rtw89_mac_port_update(rtwdev, rtwvif);
-	rtw89_fw_h2c_assoc_cmac_tbl(rtwdev, vif, NULL);
+	rtw89_chip_h2c_assoc_cmac_tbl(rtwdev, vif, NULL);
 	rtw89_fw_h2c_role_maintain(rtwdev, rtwvif, NULL, RTW89_ROLE_TYPE_CHANGE);
 	rtw89_fw_h2c_join_info(rtwdev, rtwvif, NULL, true);
 	rtw89_fw_h2c_cam(rtwdev, rtwvif, NULL, NULL);
@@ -518,7 +518,7 @@ void rtw89_ops_stop_ap(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 
 	mutex_lock(&rtwdev->mutex);
 	rtw89_mac_stop_ap(rtwdev, rtwvif);
-	rtw89_fw_h2c_assoc_cmac_tbl(rtwdev, vif, NULL);
+	rtw89_chip_h2c_assoc_cmac_tbl(rtwdev, vif, NULL);
 	rtw89_fw_h2c_join_info(rtwdev, rtwvif, NULL, true);
 	mutex_unlock(&rtwdev->mutex);
 }
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b.c b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
index 558ab6c2c24a..2a4e7bd53e89 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
@@ -2334,6 +2334,7 @@ static const struct rtw89_chip_ops rtw8851b_chip_ops = {
 	.stop_sch_tx		= rtw89_mac_stop_sch_tx,
 	.resume_sch_tx		= rtw89_mac_resume_sch_tx,
 	.h2c_dctl_sec_cam	= NULL,
+	.h2c_assoc_cmac_tbl	= rtw89_fw_h2c_assoc_cmac_tbl,
 	.h2c_update_beacon	= rtw89_fw_h2c_update_beacon,
 	.h2c_ba_cam		= rtw89_fw_h2c_ba_cam,
 
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index 3349397e3af1..3190268dcea9 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -2078,6 +2078,7 @@ static const struct rtw89_chip_ops rtw8852a_chip_ops = {
 	.stop_sch_tx		= rtw89_mac_stop_sch_tx,
 	.resume_sch_tx		= rtw89_mac_resume_sch_tx,
 	.h2c_dctl_sec_cam	= NULL,
+	.h2c_assoc_cmac_tbl	= rtw89_fw_h2c_assoc_cmac_tbl,
 	.h2c_update_beacon	= rtw89_fw_h2c_update_beacon,
 	.h2c_ba_cam		= rtw89_fw_h2c_ba_cam,
 
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index 43e803cb06f2..4f312e61a88e 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -2503,6 +2503,7 @@ static const struct rtw89_chip_ops rtw8852b_chip_ops = {
 	.stop_sch_tx		= rtw89_mac_stop_sch_tx,
 	.resume_sch_tx		= rtw89_mac_resume_sch_tx,
 	.h2c_dctl_sec_cam	= NULL,
+	.h2c_assoc_cmac_tbl	= rtw89_fw_h2c_assoc_cmac_tbl,
 	.h2c_update_beacon	= rtw89_fw_h2c_update_beacon,
 	.h2c_ba_cam		= rtw89_fw_h2c_ba_cam,
 
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index e2393e621755..6b660a6660bd 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -2848,6 +2848,7 @@ static const struct rtw89_chip_ops rtw8852c_chip_ops = {
 	.stop_sch_tx		= rtw89_mac_stop_sch_tx_v1,
 	.resume_sch_tx		= rtw89_mac_resume_sch_tx_v1,
 	.h2c_dctl_sec_cam	= rtw89_fw_h2c_dctl_sec_cam_v1,
+	.h2c_assoc_cmac_tbl	= rtw89_fw_h2c_assoc_cmac_tbl,
 	.h2c_update_beacon	= rtw89_fw_h2c_update_beacon,
 	.h2c_ba_cam		= rtw89_fw_h2c_ba_cam,
 
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a.c b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
index 15809cb5c03c..abcf9d604cac 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
@@ -823,6 +823,7 @@ static const struct rtw89_chip_ops rtw8922a_chip_ops = {
 	.pwr_on_func		= rtw8922a_pwr_on_func,
 	.pwr_off_func		= rtw8922a_pwr_off_func,
 	.h2c_dctl_sec_cam	= rtw89_fw_h2c_dctl_sec_cam_v2,
+	.h2c_assoc_cmac_tbl	= rtw89_fw_h2c_assoc_cmac_tbl_g7,
 	.h2c_update_beacon	= rtw89_fw_h2c_update_beacon_be,
 	.h2c_ba_cam		= rtw89_fw_h2c_ba_cam_v1,
 };
diff --git a/drivers/net/wireless/realtek/rtw89/wow.c b/drivers/net/wireless/realtek/rtw89/wow.c
index 5c7ca36c09b6..4c17936795b6 100644
--- a/drivers/net/wireless/realtek/rtw89/wow.c
+++ b/drivers/net/wireless/realtek/rtw89/wow.c
@@ -519,7 +519,7 @@ static int rtw89_wow_swap_fw(struct rtw89_dev *rtwdev, bool wow)
 		return ret;
 	}
 
-	ret = rtw89_fw_h2c_assoc_cmac_tbl(rtwdev, wow_vif, wow_sta);
+	ret = rtw89_chip_h2c_assoc_cmac_tbl(rtwdev, wow_vif, wow_sta);
 	if (ret) {
 		rtw89_warn(rtwdev, "failed to send h2c assoc cmac tbl\n");
 		return ret;
-- 
2.25.1


