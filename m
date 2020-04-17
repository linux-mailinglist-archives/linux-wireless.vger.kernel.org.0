Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 949D41AD7E5
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2020 09:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729475AbgDQHrq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Apr 2020 03:47:46 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:36988 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726382AbgDQHrJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Apr 2020 03:47:09 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 03H7l0Oi9020020, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 03H7l0Oi9020020
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 17 Apr 2020 15:47:00 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 17 Apr 2020 15:47:00 +0800
Received: from localhost.localdomain (172.21.68.128) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 17 Apr 2020 15:47:00 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>,
        <briannorris@chromium.org>, <kevin_yang@realtek.com>
Subject: [PATCH 02/40] rtw88: 8723d: add beamform wrapper functions
Date:   Fri, 17 Apr 2020 15:46:15 +0800
Message-ID: <20200417074653.15591-3-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200417074653.15591-1-yhchuang@realtek.com>
References: <20200417074653.15591-1-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.128]
X-ClientProxiedBy: RTEXMB03.realtek.com.tw (172.21.6.96) To
 RTEXMB04.realtek.com.tw (172.21.6.97)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ping-Ke Shih <pkshih@realtek.com>

8723D doesn't support beamform because rtw88 only supports VHT beamform
but 8723d doesn't have VHT capability. Though 8723d doesn't support
beamform, BSS_CHANGED_MU_GROUPS is still marked as changed when doing
disassociation. So, add wrapper functions for all beamform ops to make
sure they aren't NULL before calling.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/bf.c       |  7 +++---
 drivers/net/wireless/realtek/rtw88/bf.h       | 22 +++++++++++++++++++
 drivers/net/wireless/realtek/rtw88/mac80211.c |  7 ++----
 drivers/net/wireless/realtek/rtw88/main.c     |  7 +++---
 drivers/net/wireless/realtek/rtw88/rtw8723d.c |  3 +++
 5 files changed, 33 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/bf.c b/drivers/net/wireless/realtek/rtw88/bf.c
index b6d1d71f4d30..a5912da327e2 100644
--- a/drivers/net/wireless/realtek/rtw88/bf.c
+++ b/drivers/net/wireless/realtek/rtw88/bf.c
@@ -10,7 +10,6 @@
 void rtw_bf_disassoc(struct rtw_dev *rtwdev, struct ieee80211_vif *vif,
 		     struct ieee80211_bss_conf *bss_conf)
 {
-	struct rtw_chip_info *chip = rtwdev->chip;
 	struct rtw_vif *rtwvif = (struct rtw_vif *)vif->drv_priv;
 	struct rtw_bfee *bfee = &rtwvif->bfee;
 	struct rtw_bf_info *bfinfo = &rtwdev->bf_info;
@@ -23,7 +22,7 @@ void rtw_bf_disassoc(struct rtw_dev *rtwdev, struct ieee80211_vif *vif,
 	else if (bfee->role == RTW_BFEE_SU)
 		bfinfo->bfer_su_cnt--;
 
-	chip->ops->config_bfee(rtwdev, rtwvif, bfee, false);
+	rtw_chip_config_bfee(rtwdev, rtwvif, bfee, false);
 
 	bfee->role = RTW_BFEE_NONE;
 }
@@ -71,7 +70,7 @@ void rtw_bf_assoc(struct rtw_dev *rtwdev, struct ieee80211_vif *vif,
 		bfee->aid = bss_conf->aid;
 		bfinfo->bfer_mu_cnt++;
 
-		chip->ops->config_bfee(rtwdev, rtwvif, bfee, true);
+		rtw_chip_config_bfee(rtwdev, rtwvif, bfee, true);
 	} else if ((ic_vht_cap->cap & IEEE80211_VHT_CAP_SU_BEAMFORMEE_CAPABLE) &&
 		   (vht_cap->cap & IEEE80211_VHT_CAP_SU_BEAMFORMER_CAPABLE)) {
 		if (bfinfo->bfer_su_cnt >= chip->bfer_su_max_num) {
@@ -97,7 +96,7 @@ void rtw_bf_assoc(struct rtw_dev *rtwdev, struct ieee80211_vif *vif,
 			}
 		}
 
-		chip->ops->config_bfee(rtwdev, rtwvif, bfee, true);
+		rtw_chip_config_bfee(rtwdev, rtwvif, bfee, true);
 	}
 
 out_unlock:
diff --git a/drivers/net/wireless/realtek/rtw88/bf.h b/drivers/net/wireless/realtek/rtw88/bf.h
index 96a8216dd11f..17855edb5006 100644
--- a/drivers/net/wireless/realtek/rtw88/bf.h
+++ b/drivers/net/wireless/realtek/rtw88/bf.h
@@ -89,4 +89,26 @@ void rtw_bf_set_gid_table(struct rtw_dev *rtwdev, struct ieee80211_vif *vif,
 void rtw_bf_phy_init(struct rtw_dev *rtwdev);
 void rtw_bf_cfg_csi_rate(struct rtw_dev *rtwdev, u8 rssi, u8 cur_rate,
 			 u8 fixrate_en, u8 *new_rate);
+static inline void rtw_chip_config_bfee(struct rtw_dev *rtwdev, struct rtw_vif *vif,
+					struct rtw_bfee *bfee, bool enable)
+{
+	if (rtwdev->chip->ops->config_bfee)
+		rtwdev->chip->ops->config_bfee(rtwdev, vif, bfee, enable);
+}
+
+static inline void rtw_chip_set_gid_table(struct rtw_dev *rtwdev,
+					  struct ieee80211_vif *vif,
+					  struct ieee80211_bss_conf *conf)
+{
+	if (rtwdev->chip->ops->set_gid_table)
+		rtwdev->chip->ops->set_gid_table(rtwdev, vif, conf);
+}
+
+static inline void rtw_chip_cfg_csi_rate(struct rtw_dev *rtwdev, u8 rssi, u8 cur_rate,
+					 u8 fixrate_en, u8 *new_rate)
+{
+	if (rtwdev->chip->ops->cfg_csi_rate)
+		rtwdev->chip->ops->cfg_csi_rate(rtwdev, rssi, cur_rate,
+						fixrate_en, new_rate);
+}
 #endif
diff --git a/drivers/net/wireless/realtek/rtw88/mac80211.c b/drivers/net/wireless/realtek/rtw88/mac80211.c
index a2e6ef4ad9ee..98d2ac22f6f6 100644
--- a/drivers/net/wireless/realtek/rtw88/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw88/mac80211.c
@@ -375,11 +375,8 @@ static void rtw_ops_bss_info_changed(struct ieee80211_hw *hw,
 	if (changed & BSS_CHANGED_BEACON)
 		rtw_fw_download_rsvd_page(rtwdev);
 
-	if (changed & BSS_CHANGED_MU_GROUPS) {
-		struct rtw_chip_info *chip = rtwdev->chip;
-
-		chip->ops->set_gid_table(rtwdev, vif, conf);
-	}
+	if (changed & BSS_CHANGED_MU_GROUPS)
+		rtw_chip_set_gid_table(rtwdev, vif, conf);
 
 	if (changed & BSS_CHANGED_ERP_SLOT)
 		rtw_conf_tx(rtwdev, rtwvif);
diff --git a/drivers/net/wireless/realtek/rtw88/main.c b/drivers/net/wireless/realtek/rtw88/main.c
index 1e1d2c774287..6dfe4895c352 100644
--- a/drivers/net/wireless/realtek/rtw88/main.c
+++ b/drivers/net/wireless/realtek/rtw88/main.c
@@ -137,7 +137,6 @@ struct rtw_watch_dog_iter_data {
 static void rtw_dynamic_csi_rate(struct rtw_dev *rtwdev, struct rtw_vif *rtwvif)
 {
 	struct rtw_bf_info *bf_info = &rtwdev->bf_info;
-	struct rtw_chip_info *chip = rtwdev->chip;
 	u8 fix_rate_enable = 0;
 	u8 new_csi_rate_idx;
 
@@ -145,9 +144,9 @@ static void rtw_dynamic_csi_rate(struct rtw_dev *rtwdev, struct rtw_vif *rtwvif)
 	    rtwvif->bfee.role != RTW_BFEE_MU)
 		return;
 
-	chip->ops->cfg_csi_rate(rtwdev, rtwdev->dm_info.min_rssi,
-				bf_info->cur_csi_rpt_rate,
-				fix_rate_enable, &new_csi_rate_idx);
+	rtw_chip_cfg_csi_rate(rtwdev, rtwdev->dm_info.min_rssi,
+			      bf_info->cur_csi_rpt_rate,
+			      fix_rate_enable, &new_csi_rate_idx);
 
 	if (new_csi_rate_idx != bf_info->cur_csi_rpt_rate)
 		bf_info->cur_csi_rpt_rate = new_csi_rate_idx;
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8723d.c b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
index cccf05ee6807..5798a5804af3 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8723d.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
@@ -16,6 +16,9 @@
 
 static struct rtw_chip_ops rtw8723d_ops = {
 	.set_antenna		= NULL,
+	.config_bfee		= NULL,
+	.set_gid_table		= NULL,
+	.cfg_csi_rate		= NULL,
 };
 
 struct rtw_chip_info rtw8723d_hw_spec = {
-- 
2.17.1

