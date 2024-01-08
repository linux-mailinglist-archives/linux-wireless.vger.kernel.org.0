Return-Path: <linux-wireless+bounces-1577-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25914826A5E
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Jan 2024 10:12:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 608F0B22A52
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Jan 2024 09:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A765113FF5;
	Mon,  8 Jan 2024 09:12:08 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4794D13FF0
	for <linux-wireless@vger.kernel.org>; Mon,  8 Jan 2024 09:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4089C0f043872881, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 4089C0f043872881
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 8 Jan 2024 17:12:00 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Mon, 8 Jan 2024 17:12:01 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXDAG02.realtek.com.tw
 (172.21.6.101) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Mon, 8 Jan 2024
 17:12:00 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH 03/10] wifi: rtw89: add chip_ops::h2c_ba_cam() to configure BA CAM
Date: Mon, 8 Jan 2024 17:11:27 +0800
Message-ID: <20240108091134.67007-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240108091134.67007-1-pkshih@realtek.com>
References: <20240108091134.67007-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXDAG02.realtek.com.tw (172.21.6.101)
X-KSE-ServerInfo: RTEXDAG02.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

Since chips could use different version of BA CAM H2C command, add a
chip_ops to abstract the operation.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h     | 2 ++
 drivers/net/wireless/realtek/rtw89/fw.c       | 2 ++
 drivers/net/wireless/realtek/rtw89/fw.h       | 9 +++++++++
 drivers/net/wireless/realtek/rtw89/mac80211.c | 4 ++--
 drivers/net/wireless/realtek/rtw89/rtw8851b.c | 1 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c | 1 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c | 1 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c | 1 +
 drivers/net/wireless/realtek/rtw89/rtw8922a.c | 1 +
 9 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index ea6df859ba15..1e30408d2c7c 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -3196,6 +3196,8 @@ struct rtw89_chip_ops {
 	int (*h2c_dctl_sec_cam)(struct rtw89_dev *rtwdev,
 				struct rtw89_vif *rtwvif,
 				struct rtw89_sta *rtwsta);
+	int (*h2c_ba_cam)(struct rtw89_dev *rtwdev, struct rtw89_sta *rtwsta,
+			  bool valid, struct ieee80211_ampdu_params *params);
 
 	void (*btc_set_rfe)(struct rtw89_dev *rtwdev);
 	void (*btc_init_cfg)(struct rtw89_dev *rtwdev);
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 28bf8108a177..b1215200f5a1 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -1556,6 +1556,7 @@ int rtw89_fw_h2c_ba_cam(struct rtw89_dev *rtwdev, struct rtw89_sta *rtwsta,
 
 	return ret;
 }
+EXPORT_SYMBOL(rtw89_fw_h2c_ba_cam);
 
 static int rtw89_fw_h2c_init_ba_cam_v0_ext(struct rtw89_dev *rtwdev,
 					   u8 entry_idx, u8 uid)
@@ -1682,6 +1683,7 @@ int rtw89_fw_h2c_ba_cam_v1(struct rtw89_dev *rtwdev, struct rtw89_sta *rtwsta,
 
 	return ret;
 }
+EXPORT_SYMBOL(rtw89_fw_h2c_ba_cam_v1);
 
 int rtw89_fw_h2c_init_ba_cam_users(struct rtw89_dev *rtwdev, u8 users,
 				   u8 offset, u8 mac_idx)
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index 687623fb7e1d..6c51ee9a5fa8 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -3996,6 +3996,15 @@ static inline void rtw89_fw_h2c_init_ba_cam(struct rtw89_dev *rtwdev)
 		rtw89_fw_h2c_init_dynamic_ba_cam_v0_ext(rtwdev);
 }
 
+static inline
+int rtw89_chip_h2c_ba_cam(struct rtw89_dev *rtwdev, struct rtw89_sta *rtwsta,
+			  bool valid, struct ieee80211_ampdu_params *params)
+{
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+
+	return chip->ops->h2c_ba_cam(rtwdev, rtwsta, valid, params);
+}
+
 /* must consider compatibility; don't insert new in the mid */
 struct rtw89_fw_txpwr_byrate_entry {
 	u8 band;
diff --git a/drivers/net/wireless/realtek/rtw89/mac80211.c b/drivers/net/wireless/realtek/rtw89/mac80211.c
index 93889d2fface..915bd82586fc 100644
--- a/drivers/net/wireless/realtek/rtw89/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw89/mac80211.c
@@ -673,12 +673,12 @@ static int rtw89_ops_ampdu_action(struct ieee80211_hw *hw,
 		break;
 	case IEEE80211_AMPDU_RX_START:
 		mutex_lock(&rtwdev->mutex);
-		rtw89_fw_h2c_ba_cam(rtwdev, rtwsta, true, params);
+		rtw89_chip_h2c_ba_cam(rtwdev, rtwsta, true, params);
 		mutex_unlock(&rtwdev->mutex);
 		break;
 	case IEEE80211_AMPDU_RX_STOP:
 		mutex_lock(&rtwdev->mutex);
-		rtw89_fw_h2c_ba_cam(rtwdev, rtwsta, false, params);
+		rtw89_chip_h2c_ba_cam(rtwdev, rtwsta, false, params);
 		mutex_unlock(&rtwdev->mutex);
 		break;
 	default:
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b.c b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
index 5c167a9278ce..be9a65b17e0c 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
@@ -2334,6 +2334,7 @@ static const struct rtw89_chip_ops rtw8851b_chip_ops = {
 	.stop_sch_tx		= rtw89_mac_stop_sch_tx,
 	.resume_sch_tx		= rtw89_mac_resume_sch_tx,
 	.h2c_dctl_sec_cam	= NULL,
+	.h2c_ba_cam		= rtw89_fw_h2c_ba_cam,
 
 	.btc_set_rfe		= rtw8851b_btc_set_rfe,
 	.btc_init_cfg		= rtw8851b_btc_init_cfg,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index 0c76c52ce22c..481c1f59fda0 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -2078,6 +2078,7 @@ static const struct rtw89_chip_ops rtw8852a_chip_ops = {
 	.stop_sch_tx		= rtw89_mac_stop_sch_tx,
 	.resume_sch_tx		= rtw89_mac_resume_sch_tx,
 	.h2c_dctl_sec_cam	= NULL,
+	.h2c_ba_cam		= rtw89_fw_h2c_ba_cam,
 
 	.btc_set_rfe		= rtw8852a_btc_set_rfe,
 	.btc_init_cfg		= rtw8852a_btc_init_cfg,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index de887a35f3fb..fd1396601f44 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -2503,6 +2503,7 @@ static const struct rtw89_chip_ops rtw8852b_chip_ops = {
 	.stop_sch_tx		= rtw89_mac_stop_sch_tx,
 	.resume_sch_tx		= rtw89_mac_resume_sch_tx,
 	.h2c_dctl_sec_cam	= NULL,
+	.h2c_ba_cam		= rtw89_fw_h2c_ba_cam,
 
 	.btc_set_rfe		= rtw8852b_btc_set_rfe,
 	.btc_init_cfg		= rtw8852b_btc_init_cfg,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index 8618d0204f66..caa0ed7792b2 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -2848,6 +2848,7 @@ static const struct rtw89_chip_ops rtw8852c_chip_ops = {
 	.stop_sch_tx		= rtw89_mac_stop_sch_tx_v1,
 	.resume_sch_tx		= rtw89_mac_resume_sch_tx_v1,
 	.h2c_dctl_sec_cam	= rtw89_fw_h2c_dctl_sec_cam_v1,
+	.h2c_ba_cam		= rtw89_fw_h2c_ba_cam,
 
 	.btc_set_rfe		= rtw8852c_btc_set_rfe,
 	.btc_init_cfg		= rtw8852c_btc_init_cfg,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a.c b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
index 0e7300cc6d9e..b8c209fd8f34 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
@@ -614,6 +614,7 @@ static const struct rtw89_chip_ops rtw8922a_chip_ops = {
 	.read_phycap		= rtw8922a_read_phycap,
 	.pwr_on_func		= rtw8922a_pwr_on_func,
 	.pwr_off_func		= rtw8922a_pwr_off_func,
+	.h2c_ba_cam		= rtw89_fw_h2c_ba_cam_v1,
 };
 
 const struct rtw89_chip_info rtw8922a_chip_info = {
-- 
2.25.1


