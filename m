Return-Path: <linux-wireless+bounces-30-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 241107F6CC5
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Nov 2023 08:18:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 730F0B20D43
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Nov 2023 07:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 859C6AD4B;
	Fri, 24 Nov 2023 07:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9CAD9A
	for <linux-wireless@vger.kernel.org>; Thu, 23 Nov 2023 23:18:18 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3AO7ICLa83551162, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3AO7ICLa83551162
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Nov 2023 15:18:12 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Fri, 24 Nov 2023 15:18:13 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 24 Nov
 2023 15:18:10 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 5/8] wifi: rtw89: mac: check queue empty according to chip gen
Date: Fri, 24 Nov 2023 15:17:00 +0800
Message-ID: <20231124071703.132549-6-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231124071703.132549-1-pkshih@realtek.com>
References: <20231124071703.132549-1-pkshih@realtek.com>
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
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

From: Zong-Zhe Yang <kevin_yang@realtek.com>

This function, currently called by WoWLAN flow, polls until specific HW
queues are empty. The polling bit definitions are not totally the same
between WiFi 6 and 7 chips. In addition, the check conditions are also
a little different. So, we differentiate the implementations according to
chip gen.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/mac.c    | 17 +++++---
 drivers/net/wireless/realtek/rtw89/mac.h    |  7 +++
 drivers/net/wireless/realtek/rtw89/mac_be.c | 47 +++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/reg.h    | 30 +++++++++++++
 4 files changed, 94 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index b5e32b830a17..074c1edb0d25 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -174,8 +174,8 @@ static int dle_dfi_quota(struct rtw89_dev *rtwdev,
 	return 0;
 }
 
-static int dle_dfi_qempty(struct rtw89_dev *rtwdev,
-			  struct rtw89_mac_dle_dfi_qempty *qempty)
+int rtw89_mac_dle_dfi_qempty_cfg(struct rtw89_dev *rtwdev,
+				 struct rtw89_mac_dle_dfi_qempty *qempty)
 {
 	struct rtw89_mac_dle_dfi_ctrl ctrl;
 	u32 ret;
@@ -220,7 +220,7 @@ static void rtw89_mac_dump_qta_lost(struct rtw89_dev *rtwdev)
 	qempty.dle_type = DLE_CTRL_TYPE_PLE;
 	qempty.grpsel = 0;
 	qempty.qempty = ~(u32)0;
-	ret = dle_dfi_qempty(rtwdev, &qempty);
+	ret = rtw89_mac_dle_dfi_qempty_cfg(rtwdev, &qempty);
 	if (ret)
 		rtw89_warn(rtwdev, "%s: query DLE fail\n", __func__);
 	else
@@ -1618,7 +1618,7 @@ int rtw89_mac_get_dle_rsvd_qt_cfg(struct rtw89_dev *rtwdev,
 	return 0;
 }
 
-static bool mac_is_txq_empty(struct rtw89_dev *rtwdev)
+static bool mac_is_txq_empty_ax(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_mac_dle_dfi_qempty qempty;
 	u32 grpnum, qtmp, val32, msk32;
@@ -1629,7 +1629,7 @@ static bool mac_is_txq_empty(struct rtw89_dev *rtwdev)
 
 	for (i = 0; i < grpnum; i++) {
 		qempty.grpsel = i;
-		ret = dle_dfi_qempty(rtwdev, &qempty);
+		ret = rtw89_mac_dle_dfi_qempty_cfg(rtwdev, &qempty);
 		if (ret) {
 			rtw89_warn(rtwdev, "dle dfi acq empty %d\n", ret);
 			return false;
@@ -1644,7 +1644,7 @@ static bool mac_is_txq_empty(struct rtw89_dev *rtwdev)
 	}
 
 	qempty.grpsel = rtwdev->chip->wde_qempty_mgq_grpsel;
-	ret = dle_dfi_qempty(rtwdev, &qempty);
+	ret = rtw89_mac_dle_dfi_qempty_cfg(rtwdev, &qempty);
 	if (ret) {
 		rtw89_warn(rtwdev, "dle dfi mgq empty %d\n", ret);
 		return false;
@@ -5797,6 +5797,7 @@ void rtw89_mac_pkt_drop_vif(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
 int rtw89_mac_ptk_drop_by_band_and_wait(struct rtw89_dev *rtwdev,
 					enum rtw89_mac_idx band)
 {
+	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
 	struct rtw89_pkt_drop_params params = {0};
 	bool empty;
 	int i, ret = 0, try_cnt = 3;
@@ -5805,7 +5806,7 @@ int rtw89_mac_ptk_drop_by_band_and_wait(struct rtw89_dev *rtwdev,
 	params.sel = RTW89_PKT_DROP_SEL_BAND_ONCE;
 
 	for (i = 0; i < try_cnt; i++) {
-		ret = read_poll_timeout(mac_is_txq_empty, empty, empty, 50,
+		ret = read_poll_timeout(mac->is_txq_empty, empty, empty, 50,
 					50000, false, rtwdev);
 		if (ret && !RTW89_CHK_FW_FEATURE(NO_PACKET_DROP, &rtwdev->fw))
 			rtw89_fw_h2c_pkt_drop(rtwdev, &params);
@@ -5864,5 +5865,7 @@ const struct rtw89_mac_gen_def rtw89_mac_gen_ax = {
 	.cnv_efuse_state = rtw89_cnv_efuse_state_ax,
 
 	.get_txpwr_cr = rtw89_mac_get_txpwr_cr_ax,
+
+	.is_txq_empty = mac_is_txq_empty_ax,
 };
 EXPORT_SYMBOL(rtw89_mac_gen_ax);
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index b16fa9bbd412..8beb278934bf 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -537,6 +537,9 @@ enum rtw89_mac_bf_rrsc_rate {
 #define B_CMAC1_MGQ_NO_PWRSAV	BIT(11)
 #define B_CMAC1_CPUMGQ		BIT(12)
 
+#define B_CMAC0_MGQ_NORMAL_BE	BIT(2)
+#define B_CMAC1_MGQ_NORMAL_BE	BIT(30)
+
 #define QEMP_ACQ_GRP_MACID_NUM	8
 #define QEMP_ACQ_GRP_QSEL_SH	4
 #define QEMP_ACQ_GRP_QSEL_MASK	0xF
@@ -910,6 +913,8 @@ struct rtw89_mac_gen_def {
 	bool (*get_txpwr_cr)(struct rtw89_dev *rtwdev,
 			     enum rtw89_phy_idx phy_idx,
 			     u32 reg_base, u32 *cr);
+
+	bool (*is_txq_empty)(struct rtw89_dev *rtwdev);
 };
 
 extern const struct rtw89_mac_gen_def rtw89_mac_gen_ax;
@@ -1015,6 +1020,8 @@ int rtw89_mac_check_mac_en(struct rtw89_dev *rtwdev, u8 band,
 			   enum rtw89_mac_hwmod_sel sel);
 int rtw89_mac_write_lte(struct rtw89_dev *rtwdev, const u32 offset, u32 val);
 int rtw89_mac_read_lte(struct rtw89_dev *rtwdev, const u32 offset, u32 *val);
+int rtw89_mac_dle_dfi_qempty_cfg(struct rtw89_dev *rtwdev,
+				 struct rtw89_mac_dle_dfi_qempty *qempty);
 int rtw89_mac_add_vif(struct rtw89_dev *rtwdev, struct rtw89_vif *vif);
 int rtw89_mac_port_update(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif);
 void rtw89_mac_port_tsf_sync(struct rtw89_dev *rtwdev,
diff --git a/drivers/net/wireless/realtek/rtw89/mac_be.c b/drivers/net/wireless/realtek/rtw89/mac_be.c
index 1c607316f652..612baa8b83d9 100644
--- a/drivers/net/wireless/realtek/rtw89/mac_be.c
+++ b/drivers/net/wireless/realtek/rtw89/mac_be.c
@@ -405,6 +405,51 @@ static void rtw89_mac_bf_assoc_be(struct rtw89_dev *rtwdev,
 	}
 }
 
+static bool mac_is_txq_empty_be(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_mac_dle_dfi_qempty qempty;
+	u32 val32, msk32;
+	u32 grpnum;
+	int ret;
+	int i;
+
+	grpnum = rtwdev->chip->wde_qempty_acq_grpnum;
+	qempty.dle_type = DLE_CTRL_TYPE_WDE;
+
+	for (i = 0; i < grpnum; i++) {
+		qempty.grpsel = i;
+		ret = rtw89_mac_dle_dfi_qempty_cfg(rtwdev, &qempty);
+		if (ret) {
+			rtw89_warn(rtwdev,
+				   "%s: failed to dle dfi acq empty: %d\n",
+				   __func__, ret);
+			return false;
+		}
+
+		/* Each acq group contains 32 queues (8 macid * 4 acq),
+		 * but here, we can simply check if all bits are set.
+		 */
+		if (qempty.qempty != MASKDWORD)
+			return false;
+	}
+
+	qempty.grpsel = rtwdev->chip->wde_qempty_mgq_grpsel;
+	ret = rtw89_mac_dle_dfi_qempty_cfg(rtwdev, &qempty);
+	if (ret) {
+		rtw89_warn(rtwdev, "%s: failed to dle dfi mgq empty: %d\n",
+			   __func__, ret);
+		return false;
+	}
+
+	msk32 = B_CMAC0_MGQ_NORMAL_BE | B_CMAC1_MGQ_NORMAL_BE;
+	if ((qempty.qempty & msk32) != msk32)
+		return false;
+
+	msk32 = B_BE_WDE_EMPTY_QUE_OTHERS;
+	val32 = rtw89_read32(rtwdev, R_BE_DLE_EMPTY0);
+	return (val32 & msk32) == msk32;
+}
+
 const struct rtw89_mac_gen_def rtw89_mac_gen_be = {
 	.band1_offset = RTW89_MAC_BE_BAND_REG_OFFSET,
 	.filter_model_addr = R_BE_FILTER_MODEL_ADDR,
@@ -435,5 +480,7 @@ const struct rtw89_mac_gen_def rtw89_mac_gen_be = {
 	.cnv_efuse_state = rtw89_cnv_efuse_state_be,
 
 	.get_txpwr_cr = rtw89_mac_get_txpwr_cr_be,
+
+	.is_txq_empty = mac_is_txq_empty_be,
 };
 EXPORT_SYMBOL(rtw89_mac_gen_be);
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 7a9ae6cd86e5..31b65322368c 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -4144,6 +4144,36 @@
 #define B_BE_LTR_CMAC1_RX_USE_PG_TH_MASK GENMASK(27, 16)
 #define B_BE_LTR_CMAC0_RX_USE_PG_TH_MASK GENMASK(11, 0)
 
+#define R_BE_DLE_EMPTY0 0x8430
+#define B_BE_PLE_EMPTY_QTA_DMAC_H2D BIT(27)
+#define B_BE_PLE_EMPTY_QTA_DMAC_CPUIO BIT(26)
+#define B_BE_PLE_EMPTY_QTA_DMAC_MPDU_TX BIT(25)
+#define B_BE_PLE_EMPTY_QTA_DMAC_WLAN_CPU BIT(24)
+#define B_BE_PLE_EMPTY_QTA_DMAC_H2C BIT(23)
+#define B_BE_PLE_EMPTY_QTA_DMAC_B1_TXPL BIT(22)
+#define B_BE_PLE_EMPTY_QTA_DMAC_B0_TXPL BIT(21)
+#define B_BE_WDE_EMPTY_QTA_DMAC_CPUIO BIT(20)
+#define B_BE_WDE_EMPTY_QTA_DMAC_PKTIN BIT(19)
+#define B_BE_WDE_EMPTY_QTA_DMAC_DATA_CPU BIT(18)
+#define B_BE_WDE_EMPTY_QTA_DMAC_WLAN_CPU BIT(17)
+#define B_BE_WDE_EMPTY_QTA_DMAC_HIF BIT(16)
+#define B_BE_WDE_EMPTY_QUE_CMAC_B1_HIQ BIT(15)
+#define B_BE_WDE_EMPTY_QUE_CMAC_B1_MBH BIT(14)
+#define B_BE_WDE_EMPTY_QUE_CMAC_B0_OTHERS BIT(13)
+#define B_BE_WDE_EMPTY_QUE_DMAC_MLO_ACQ BIT(12)
+#define B_BE_WDE_EMPTY_QUE_DMAC_MLO_MISC BIT(11)
+#define B_BE_WDE_EMPTY_QUE_DMAC_PKTIN BIT(10)
+#define B_BE_PLE_EMPTY_QUE_DMAC_SEC_TX BIT(9)
+#define B_BE_PLE_EMPTY_QUE_DMAC_MPDU_TX BIT(8)
+#define B_BE_WDE_EMPTY_QUE_OTHERS BIT(7)
+#define B_BE_WDE_EMPTY_QUE_CMAC_WMM3 BIT(6)
+#define B_BE_WDE_EMPTY_QUE_CMAC_WMM2 BIT(5)
+#define B_BE_WDE_EMPTY_QUE_CMAC0_WMM1 BIT(4)
+#define B_BE_WDE_EMPTY_QUE_CMAC0_WMM0 BIT(3)
+#define B_BE_WDE_EMPTY_QUE_CMAC1_MBH BIT(2)
+#define B_BE_WDE_EMPTY_QUE_CMAC0_MBH BIT(1)
+#define B_BE_WDE_EMPTY_QUE_CMAC0_ALL_AC BIT(0)
+
 #define R_BE_PLE_DBG_FUN_INTF_CTL 0x9110
 #define B_BE_PLE_DFI_ACTIVE BIT(31)
 #define B_BE_PLE_DFI_TRGSEL_MASK GENMASK(19, 16)
-- 
2.25.1


