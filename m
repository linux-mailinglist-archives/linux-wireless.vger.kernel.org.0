Return-Path: <linux-wireless+bounces-1584-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EC76826A6A
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Jan 2024 10:14:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B00AB2241F
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Jan 2024 09:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF92313AE0;
	Mon,  8 Jan 2024 09:14:12 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A566E13AD8
	for <linux-wireless@vger.kernel.org>; Mon,  8 Jan 2024 09:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4089E5AX03873468, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 4089E5AX03873468
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 8 Jan 2024 17:14:05 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Mon, 8 Jan 2024 17:14:05 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXDAG02.realtek.com.tw
 (172.21.6.101) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Mon, 8 Jan 2024
 17:14:04 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH 10/10] wifi: rtw89: add chip_ops::update_beacon to abstract update beacon operation
Date: Mon, 8 Jan 2024 17:13:59 +0800
Message-ID: <20240108091359.67636-1-pkshih@realtek.com>
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

Since coming WiFi 7 and existing chips use different update_beacon()
format, add to abstract selection of H2C command.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/chan.c     | 2 +-
 drivers/net/wireless/realtek/rtw89/core.c     | 2 +-
 drivers/net/wireless/realtek/rtw89/core.h     | 2 ++
 drivers/net/wireless/realtek/rtw89/fw.c       | 2 ++
 drivers/net/wireless/realtek/rtw89/fw.h       | 8 ++++++++
 drivers/net/wireless/realtek/rtw89/mac80211.c | 2 +-
 drivers/net/wireless/realtek/rtw89/rtw8851b.c | 1 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c | 1 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c | 1 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c | 1 +
 drivers/net/wireless/realtek/rtw89/rtw8922a.c | 1 +
 11 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/chan.c b/drivers/net/wireless/realtek/rtw89/chan.c
index cbf6821af6b8..21449cb9b069 100644
--- a/drivers/net/wireless/realtek/rtw89/chan.c
+++ b/drivers/net/wireless/realtek/rtw89/chan.c
@@ -1494,7 +1494,7 @@ static void rtw89_mcc_handle_beacon_noa(struct rtw89_dev *rtwdev, bool enable)
 	if (!rtwvif_go->chanctx_assigned)
 		return;
 
-	rtw89_fw_h2c_update_beacon(rtwdev, rtwvif_go);
+	rtw89_chip_h2c_update_beacon(rtwdev, rtwvif_go);
 }
 
 static void rtw89_mcc_start_beacon_noa(struct rtw89_dev *rtwdev)
diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index fd527a249996..ac7ae19429f9 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -3879,7 +3879,7 @@ void rtw89_core_update_beacon_work(struct work_struct *work)
 
 	rtwdev = rtwvif->rtwdev;
 	mutex_lock(&rtwdev->mutex);
-	rtw89_fw_h2c_update_beacon(rtwdev, rtwvif);
+	rtw89_chip_h2c_update_beacon(rtwdev, rtwvif);
 	mutex_unlock(&rtwdev->mutex);
 }
 
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 87bf9cabc8af..77cb73f58f07 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -3196,6 +3196,8 @@ struct rtw89_chip_ops {
 	int (*h2c_dctl_sec_cam)(struct rtw89_dev *rtwdev,
 				struct rtw89_vif *rtwvif,
 				struct rtw89_sta *rtwsta);
+	int (*h2c_update_beacon)(struct rtw89_dev *rtwdev,
+				 struct rtw89_vif *rtwvif);
 	int (*h2c_ba_cam)(struct rtw89_dev *rtwdev, struct rtw89_sta *rtwsta,
 			  bool valid, struct ieee80211_ampdu_params *params);
 
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 42214af0e15a..55a9f4eb47be 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -2355,6 +2355,7 @@ int rtw89_fw_h2c_update_beacon(struct rtw89_dev *rtwdev,
 
 	return 0;
 }
+EXPORT_SYMBOL(rtw89_fw_h2c_update_beacon);
 
 int rtw89_fw_h2c_update_beacon_be(struct rtw89_dev *rtwdev,
 				  struct rtw89_vif *rtwvif)
@@ -2437,6 +2438,7 @@ int rtw89_fw_h2c_update_beacon_be(struct rtw89_dev *rtwdev,
 
 	return ret;
 }
+EXPORT_SYMBOL(rtw89_fw_h2c_update_beacon_be);
 
 #define H2C_ROLE_MAINTAIN_LEN 4
 int rtw89_fw_h2c_role_maintain(struct rtw89_dev *rtwdev,
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index dc1c805f1500..7fa7cd11c495 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -3946,6 +3946,14 @@ static inline void rtw89_fw_h2c_init_ba_cam(struct rtw89_dev *rtwdev)
 		rtw89_fw_h2c_init_dynamic_ba_cam_v0_ext(rtwdev);
 }
 
+static inline int rtw89_chip_h2c_update_beacon(struct rtw89_dev *rtwdev,
+					       struct rtw89_vif *rtwvif)
+{
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+
+	return chip->ops->h2c_update_beacon(rtwdev, rtwvif);
+}
+
 static inline
 int rtw89_chip_h2c_ba_cam(struct rtw89_dev *rtwdev, struct rtw89_sta *rtwsta,
 			  bool valid, struct ieee80211_ampdu_params *params)
diff --git a/drivers/net/wireless/realtek/rtw89/mac80211.c b/drivers/net/wireless/realtek/rtw89/mac80211.c
index 915bd82586fc..c023c182be6a 100644
--- a/drivers/net/wireless/realtek/rtw89/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw89/mac80211.c
@@ -452,7 +452,7 @@ static void rtw89_ops_bss_info_changed(struct ieee80211_hw *hw,
 	}
 
 	if (changed & BSS_CHANGED_BEACON)
-		rtw89_fw_h2c_update_beacon(rtwdev, rtwvif);
+		rtw89_chip_h2c_update_beacon(rtwdev, rtwvif);
 
 	if (changed & BSS_CHANGED_ERP_SLOT)
 		rtw89_conf_tx(rtwdev, rtwvif);
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b.c b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
index be9a65b17e0c..320e7a21d177 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
@@ -2334,6 +2334,7 @@ static const struct rtw89_chip_ops rtw8851b_chip_ops = {
 	.stop_sch_tx		= rtw89_mac_stop_sch_tx,
 	.resume_sch_tx		= rtw89_mac_resume_sch_tx,
 	.h2c_dctl_sec_cam	= NULL,
+	.h2c_update_beacon	= rtw89_fw_h2c_update_beacon,
 	.h2c_ba_cam		= rtw89_fw_h2c_ba_cam,
 
 	.btc_set_rfe		= rtw8851b_btc_set_rfe,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index 481c1f59fda0..3349397e3af1 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -2078,6 +2078,7 @@ static const struct rtw89_chip_ops rtw8852a_chip_ops = {
 	.stop_sch_tx		= rtw89_mac_stop_sch_tx,
 	.resume_sch_tx		= rtw89_mac_resume_sch_tx,
 	.h2c_dctl_sec_cam	= NULL,
+	.h2c_update_beacon	= rtw89_fw_h2c_update_beacon,
 	.h2c_ba_cam		= rtw89_fw_h2c_ba_cam,
 
 	.btc_set_rfe		= rtw8852a_btc_set_rfe,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index fd1396601f44..75da902a3c83 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -2503,6 +2503,7 @@ static const struct rtw89_chip_ops rtw8852b_chip_ops = {
 	.stop_sch_tx		= rtw89_mac_stop_sch_tx,
 	.resume_sch_tx		= rtw89_mac_resume_sch_tx,
 	.h2c_dctl_sec_cam	= NULL,
+	.h2c_update_beacon	= rtw89_fw_h2c_update_beacon,
 	.h2c_ba_cam		= rtw89_fw_h2c_ba_cam,
 
 	.btc_set_rfe		= rtw8852b_btc_set_rfe,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index caa0ed7792b2..d4041d731273 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -2848,6 +2848,7 @@ static const struct rtw89_chip_ops rtw8852c_chip_ops = {
 	.stop_sch_tx		= rtw89_mac_stop_sch_tx_v1,
 	.resume_sch_tx		= rtw89_mac_resume_sch_tx_v1,
 	.h2c_dctl_sec_cam	= rtw89_fw_h2c_dctl_sec_cam_v1,
+	.h2c_update_beacon	= rtw89_fw_h2c_update_beacon,
 	.h2c_ba_cam		= rtw89_fw_h2c_ba_cam,
 
 	.btc_set_rfe		= rtw8852c_btc_set_rfe,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a.c b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
index 395b4df29223..03dd97be08dc 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
@@ -614,6 +614,7 @@ static const struct rtw89_chip_ops rtw8922a_chip_ops = {
 	.read_phycap		= rtw8922a_read_phycap,
 	.pwr_on_func		= rtw8922a_pwr_on_func,
 	.pwr_off_func		= rtw8922a_pwr_off_func,
+	.h2c_update_beacon	= rtw89_fw_h2c_update_beacon_be,
 	.h2c_ba_cam		= rtw89_fw_h2c_ba_cam_v1,
 };
 
-- 
2.25.1


