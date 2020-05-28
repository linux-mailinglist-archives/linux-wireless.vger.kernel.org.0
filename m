Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49E6E1E5AA5
	for <lists+linux-wireless@lfdr.de>; Thu, 28 May 2020 10:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726940AbgE1IWQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 May 2020 04:22:16 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:55031 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726883AbgE1IWP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 May 2020 04:22:15 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 04S8MA1h8004578, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 04S8MA1h8004578
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 28 May 2020 16:22:10 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 28 May 2020 16:22:10 +0800
Received: from localhost.localdomain (172.21.68.128) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 28 May 2020 16:22:09 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <tehuang@realtek.com>
Subject: [PATCH 3/5] rtw88: 8821c: add beamformee support
Date:   Thu, 28 May 2020 16:22:05 +0800
Message-ID: <20200528082207.26521-4-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200528082207.26521-1-yhchuang@realtek.com>
References: <20200528082207.26521-1-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.128]
X-ClientProxiedBy: RTEXMB02.realtek.com.tw (172.21.6.95) To
 RTEXMB04.realtek.com.tw (172.21.6.97)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Tzu-En Huang <tehuang@realtek.com>

Beamforming is a technique used for directional signal transmission
or reception. Beamformee is the role for reception, and the rx performance
will be better in middle distance transmission. 8821c supports beamfomee.
After association, if 8821c is acting as a beamformee, related beamformee
settings for 8821c will be applied.

Since 8821c only support 1ss rate, nc_index in beamformee setting need to
be adjusted based on chipset.

Signed-off-by: Tzu-En Huang <tehuang@realtek.com>
Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/bf.c       |  5 ++-
 drivers/net/wireless/realtek/rtw88/rtw8821c.c | 45 +++++++++++++++++++
 2 files changed, 48 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/bf.c b/drivers/net/wireless/realtek/rtw88/bf.c
index 8a070d5d9174..aff70e4ae028 100644
--- a/drivers/net/wireless/realtek/rtw88/bf.c
+++ b/drivers/net/wireless/realtek/rtw88/bf.c
@@ -183,7 +183,7 @@ void rtw_bf_del_sounding(struct rtw_dev *rtwdev)
 void rtw_bf_enable_bfee_su(struct rtw_dev *rtwdev, struct rtw_vif *vif,
 			   struct rtw_bfee *bfee)
 {
-	u8 nc_index = 1;
+	u8 nc_index = hweight8(rtwdev->hal.antenna_rx) - 1;
 	u8 nr_index = bfee->sound_dim;
 	u8 grouping = 0, codebookinfo = 1, coefficientsize = 3;
 	u32 addr_bfer_info, addr_csi_rpt, csi_param;
@@ -231,7 +231,8 @@ void rtw_bf_enable_bfee_mu(struct rtw_dev *rtwdev, struct rtw_vif *vif,
 {
 	struct rtw_bf_info *bf_info = &rtwdev->bf_info;
 	struct mu_bfer_init_para param;
-	u8 nc_index = 1, nr_index = 1;
+	u8 nc_index = hweight8(rtwdev->hal.antenna_rx) - 1;
+	u8 nr_index = 1;
 	u8 grouping = 0, codebookinfo = 1, coefficientsize = 0;
 	u32 csi_param;
 
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8821c.c b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
index f1250286766e..988dbe09c03d 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8821c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
@@ -101,6 +101,13 @@ static void rtw8821c_pwrtrack_init(struct rtw_dev *rtwdev)
 	dm_info->thermal_meter_k = rtwdev->efuse.thermal_meter_k;
 }
 
+static void rtw8821c_phy_bf_init(struct rtw_dev *rtwdev)
+{
+	rtw_bf_phy_init(rtwdev);
+	/* Grouping bitmap parameters */
+	rtw_write32(rtwdev, 0x1C94, 0xAFFFAFFF);
+}
+
 static void rtw8821c_phy_set_param(struct rtw_dev *rtwdev)
 {
 	u8 crystal_cap, val;
@@ -142,6 +149,8 @@ static void rtw8821c_phy_set_param(struct rtw_dev *rtwdev)
 	rtwdev->dm_info.cck_pd_default = rtw_read8(rtwdev, 0xaaa) & 0x1f;
 
 	rtw8821c_pwrtrack_init(rtwdev);
+
+	rtw8821c_phy_bf_init(rtwdev);
 }
 
 static int rtw8821c_mac_init(struct rtw_dev *rtwdev)
@@ -778,6 +787,37 @@ static void rtw8821c_pwr_track(struct rtw_dev *rtwdev)
 	dm_info->pwr_trk_triggered = false;
 }
 
+static void rtw8821c_bf_config_bfee_su(struct rtw_dev *rtwdev,
+				       struct rtw_vif *vif,
+				       struct rtw_bfee *bfee, bool enable)
+{
+	if (enable)
+		rtw_bf_enable_bfee_su(rtwdev, vif, bfee);
+	else
+		rtw_bf_remove_bfee_su(rtwdev, bfee);
+}
+
+static void rtw8821c_bf_config_bfee_mu(struct rtw_dev *rtwdev,
+				       struct rtw_vif *vif,
+				       struct rtw_bfee *bfee, bool enable)
+{
+	if (enable)
+		rtw_bf_enable_bfee_mu(rtwdev, vif, bfee);
+	else
+		rtw_bf_remove_bfee_mu(rtwdev, bfee);
+}
+
+static void rtw8821c_bf_config_bfee(struct rtw_dev *rtwdev, struct rtw_vif *vif,
+				    struct rtw_bfee *bfee, bool enable)
+{
+	if (bfee->role == RTW_BFEE_SU)
+		rtw8821c_bf_config_bfee_su(rtwdev, vif, bfee, enable);
+	else if (bfee->role == RTW_BFEE_MU)
+		rtw8821c_bf_config_bfee_mu(rtwdev, vif, bfee, enable);
+	else
+		rtw_warn(rtwdev, "wrong bfee role\n");
+}
+
 static void rtw8821c_phy_cck_pd_set(struct rtw_dev *rtwdev, u8 new_lvl)
 {
 	struct rtw_dm_info *dm_info = &rtwdev->dm_info;
@@ -1242,6 +1282,9 @@ static struct rtw_chip_ops rtw8821c_ops = {
 	.phy_calibration	= rtw8821c_phy_calibration,
 	.cck_pd_set		= rtw8821c_phy_cck_pd_set,
 	.pwr_track		= rtw8821c_pwr_track,
+	.config_bfee		= rtw8821c_bf_config_bfee,
+	.set_gid_table		= rtw_bf_set_gid_table,
+	.cfg_csi_rate		= rtw_bf_cfg_csi_rate,
 };
 
 static const u8 rtw8821c_pwrtrk_5gb_n[][RTW_PWR_TRK_TBL_SZ] = {
@@ -1387,6 +1430,8 @@ struct rtw_chip_info rtw8821c_hw_spec = {
 	.rx_ldpc = false,
 	.pwr_track_tbl = &rtw8821c_rtw_pwr_track_tbl,
 	.iqk_threshold = 8,
+	.bfer_su_max_num = 2,
+	.bfer_mu_max_num = 1,
 };
 EXPORT_SYMBOL(rtw8821c_hw_spec);
 
-- 
2.17.1

