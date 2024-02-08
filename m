Return-Path: <linux-wireless+bounces-3315-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9891C84D7C9
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Feb 2024 03:30:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12871286E1E
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Feb 2024 02:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F306A1CF91;
	Thu,  8 Feb 2024 02:30:01 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C601E892
	for <linux-wireless@vger.kernel.org>; Thu,  8 Feb 2024 02:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707359401; cv=none; b=U3ARuqXFVqcfXkOtWmfR/CnldtLKtuUGYpUY8rby9L6zLjCuWS2VcArjm1yA969wOnS7oM1ZbudFfQnQYBllpi2fOq5X5Zit/oc1dITrpHF0lDVA5hRlMILzx93pd7A0E+hmq3Ytun95TaddchuoKfPx69teg0d9GrQDEb4oWUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707359401; c=relaxed/simple;
	bh=OL/akGpQqFrQiyaM0DpGmR+k7CgZyA+P1H9PVBcB/iY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MNZ5YY3MPwMbKt6sn/ybbZrPEfvb4TQ9D1l5inw+tr0dcQKdfwI1RpZiLIQPaK/18fVvSq1lQf8G5FDNPWUQ9k+3GZs0srM3YI937mkfXE2PQXI/CzU8WmVoI0ZCUJ/Ewdf2t5iHZeC6FwrMQAYGix4y6MBfqrrXMg2Lb7gzmik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4182Ts0F2191876, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 4182Ts0F2191876
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 8 Feb 2024 10:29:54 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.32; Thu, 8 Feb 2024 10:29:54 +0800
Received: from [127.0.1.1] (172.16.17.45) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 8 Feb
 2024 10:29:53 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <gary.chang@realtek.com>, <phhuang@realtek.com>, <kevin_yang@realtek.com>,
        <linux-wireless@vger.kernel.org>
Subject: [PATCH 03/11] wifi: rtw89: mac: return held quota of DLE when changing MAC-1
Date: Thu, 8 Feb 2024 10:28:49 +0800
Message-ID: <20240208022857.14379-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240208022857.14379-1-pkshih@realtek.com>
References: <20240208022857.14379-1-pkshih@realtek.com>
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
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

DLE (data link engine) could hold quota when we are going to enable/disable
MAC-1 block, so trigger hardware to return all held quota.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/mac.c    | 19 ++++--
 drivers/net/wireless/realtek/rtw89/mac.h    |  4 +-
 drivers/net/wireless/realtek/rtw89/mac_be.c | 70 ++++++++++++++++++++-
 drivers/net/wireless/realtek/rtw89/reg.h    | 10 +++
 4 files changed, 95 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index dbf2d6fe4ea7..bad716cc9839 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -3192,13 +3192,11 @@ static int set_cpuio_ax(struct rtw89_dev *rtwdev,
 	return 0;
 }
 
-int rtw89_mac_dle_quota_change(struct rtw89_dev *rtwdev, enum rtw89_qta_mode mode)
+int rtw89_mac_dle_quota_change(struct rtw89_dev *rtwdev, enum rtw89_qta_mode mode,
+			       bool band1_en)
 {
 	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
 	const struct rtw89_dle_mem *cfg;
-	struct rtw89_cpuio_ctrl ctrl_para = {0};
-	u16 pkt_id;
-	int ret;
 
 	cfg = get_dle_mem_cfg(rtwdev, mode);
 	if (!cfg) {
@@ -3213,6 +3211,16 @@ int rtw89_mac_dle_quota_change(struct rtw89_dev *rtwdev, enum rtw89_qta_mode mod
 
 	dle_quota_cfg(rtwdev, cfg, INVALID_QT_WCPU);
 
+	return mac->dle_quota_change(rtwdev, band1_en);
+}
+
+static int dle_quota_change_ax(struct rtw89_dev *rtwdev, bool band1_en)
+{
+	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
+	struct rtw89_cpuio_ctrl ctrl_para = {0};
+	u16 pkt_id;
+	int ret;
+
 	ret = mac->dle_buf_req(rtwdev, 0x20, true, &pkt_id);
 	if (ret) {
 		rtw89_err(rtwdev, "[ERR]WDE DLE buf req\n");
@@ -3301,7 +3309,7 @@ static int band1_enable_ax(struct rtw89_dev *rtwdev)
 		return ret;
 	}
 
-	ret = rtw89_mac_dle_quota_change(rtwdev, rtwdev->mac.qta_mode);
+	ret = rtw89_mac_dle_quota_change(rtwdev, rtwdev->mac.qta_mode, true);
 	if (ret) {
 		rtw89_err(rtwdev, "[ERR]DLE quota change %d\n", ret);
 		return ret;
@@ -6218,6 +6226,7 @@ const struct rtw89_mac_gen_def rtw89_mac_gen_ax = {
 	.wde_quota_cfg = wde_quota_cfg_ax,
 	.ple_quota_cfg = ple_quota_cfg_ax,
 	.set_cpuio = set_cpuio_ax,
+	.dle_quota_change = dle_quota_change_ax,
 
 	.disable_cpu = rtw89_mac_disable_cpu_ax,
 	.fwdl_enable_wcpu = rtw89_mac_enable_cpu_ax,
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index 7aea57804e93..b0a3b2a9eb5b 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -932,6 +932,7 @@ struct rtw89_mac_gen_def {
 			      const struct rtw89_ple_quota *max_cfg);
 	int (*set_cpuio)(struct rtw89_dev *rtwdev,
 			 struct rtw89_cpuio_ctrl *ctrl_para, bool wd);
+	int (*dle_quota_change)(struct rtw89_dev *rtwdev, bool band1_en);
 
 	void (*disable_cpu)(struct rtw89_dev *rtwdev);
 	int (*fwdl_enable_wcpu)(struct rtw89_dev *rtwdev, u8 boot_reason,
@@ -1388,7 +1389,8 @@ int rtw89_mac_resize_ple_rx_quota(struct rtw89_dev *rtwdev, bool wow);
 int rtw89_mac_ptk_drop_by_band_and_wait(struct rtw89_dev *rtwdev,
 					enum rtw89_mac_idx band);
 void rtw89_mac_hw_mgnt_sec(struct rtw89_dev *rtwdev, bool wow);
-int rtw89_mac_dle_quota_change(struct rtw89_dev *rtwdev, enum rtw89_qta_mode mode);
+int rtw89_mac_dle_quota_change(struct rtw89_dev *rtwdev, enum rtw89_qta_mode mode,
+			       bool band1_en);
 int rtw89_mac_get_dle_rsvd_qt_cfg(struct rtw89_dev *rtwdev,
 				  enum rtw89_mac_dle_rsvd_qt_type type,
 				  struct rtw89_mac_dle_rsvd_qt_cfg *cfg);
diff --git a/drivers/net/wireless/realtek/rtw89/mac_be.c b/drivers/net/wireless/realtek/rtw89/mac_be.c
index 13e6fa7a3ae8..e2e0a7549b53 100644
--- a/drivers/net/wireless/realtek/rtw89/mac_be.c
+++ b/drivers/net/wireless/realtek/rtw89/mac_be.c
@@ -1449,6 +1449,71 @@ static int set_cpuio_be(struct rtw89_dev *rtwdev,
 	return 0;
 }
 
+static int dle_upd_qta_aval_page_be(struct rtw89_dev *rtwdev,
+				    enum rtw89_mac_dle_ctrl_type type,
+				    enum rtw89_mac_dle_ple_quota_id quota_id)
+{
+	u32 val;
+
+	if (type == DLE_CTRL_TYPE_WDE) {
+		rtw89_write32_mask(rtwdev, R_BE_WDE_BUFMGN_CTL,
+				   B_BE_WDE_AVAL_UPD_QTAID_MASK, quota_id);
+		rtw89_write32_set(rtwdev, R_BE_WDE_BUFMGN_CTL, B_BE_WDE_AVAL_UPD_REQ);
+
+		return read_poll_timeout(rtw89_read32, val,
+					 !(val & B_BE_WDE_AVAL_UPD_REQ),
+					 1, 2000, false, rtwdev, R_BE_WDE_BUFMGN_CTL);
+	} else if (type == DLE_CTRL_TYPE_PLE) {
+		rtw89_write32_mask(rtwdev, R_BE_PLE_BUFMGN_CTL,
+				   B_BE_PLE_AVAL_UPD_QTAID_MASK, quota_id);
+		rtw89_write32_set(rtwdev, R_BE_PLE_BUFMGN_CTL, B_BE_PLE_AVAL_UPD_REQ);
+
+		return read_poll_timeout(rtw89_read32, val,
+					 !(val & B_BE_PLE_AVAL_UPD_REQ),
+					 1, 2000, false, rtwdev, R_BE_PLE_BUFMGN_CTL);
+	}
+
+	rtw89_warn(rtwdev, "%s wrong type %d\n", __func__, type);
+	return -EINVAL;
+}
+
+static int dle_quota_change_be(struct rtw89_dev *rtwdev, bool band1_en)
+{
+	int ret;
+
+	if (band1_en) {
+		ret = dle_upd_qta_aval_page_be(rtwdev, DLE_CTRL_TYPE_PLE,
+					       PLE_QTAID_B0_TXPL);
+		if (ret) {
+			rtw89_err(rtwdev, "update PLE B0 TX avail page fail %d\n", ret);
+			return ret;
+		}
+
+		ret = dle_upd_qta_aval_page_be(rtwdev, DLE_CTRL_TYPE_PLE,
+					       PLE_QTAID_CMAC0_RX);
+		if (ret) {
+			rtw89_err(rtwdev, "update PLE CMAC0 RX avail page fail %d\n", ret);
+			return ret;
+		}
+	} else {
+		ret = dle_upd_qta_aval_page_be(rtwdev, DLE_CTRL_TYPE_PLE,
+					       PLE_QTAID_B1_TXPL);
+		if (ret) {
+			rtw89_err(rtwdev, "update PLE B1 TX avail page fail %d\n", ret);
+			return ret;
+		}
+
+		ret = dle_upd_qta_aval_page_be(rtwdev, DLE_CTRL_TYPE_PLE,
+					       PLE_QTAID_CMAC1_RX);
+		if (ret) {
+			rtw89_err(rtwdev, "update PLE CMAC1 RX avail page fail %d\n", ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
 static int preload_init_be(struct rtw89_dev *rtwdev, u8 mac_idx,
 			   enum rtw89_qta_mode mode)
 {
@@ -1538,7 +1603,7 @@ static int band1_enable_be(struct rtw89_dev *rtwdev)
 		return ret;
 	}
 
-	ret = rtw89_mac_dle_quota_change(rtwdev, rtwdev->mac.qta_mode);
+	ret = rtw89_mac_dle_quota_change(rtwdev, rtwdev->mac.qta_mode, true);
 	if (ret) {
 		rtw89_err(rtwdev, "[ERR]DLE quota change %d\n", ret);
 		return ret;
@@ -1593,7 +1658,7 @@ static int band1_disable_be(struct rtw89_dev *rtwdev)
 		return ret;
 	}
 
-	ret = rtw89_mac_dle_quota_change(rtwdev, rtwdev->mac.qta_mode);
+	ret = rtw89_mac_dle_quota_change(rtwdev, rtwdev->mac.qta_mode, false);
 	if (ret) {
 		rtw89_err(rtwdev, "[ERR]DLE quota change %d\n", ret);
 		return ret;
@@ -2347,6 +2412,7 @@ const struct rtw89_mac_gen_def rtw89_mac_gen_be = {
 	.wde_quota_cfg = wde_quota_cfg_be,
 	.ple_quota_cfg = ple_quota_cfg_be,
 	.set_cpuio = set_cpuio_be,
+	.dle_quota_change = dle_quota_change_be,
 
 	.disable_cpu = rtw89_mac_disable_cpu_be,
 	.fwdl_enable_wcpu = rtw89_mac_fwdl_enable_wcpu_be,
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 6368b2b32c0c..20b538526541 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -5020,6 +5020,11 @@
 #define B_BE_WDE_START_BOUND_MASK GENMASK(14, 8)
 #define B_BE_WDE_PAGE_SEL_MASK GENMASK(1, 0)
 
+#define R_BE_WDE_BUFMGN_CTL 0x8C10
+#define B_BE_WDE_AVAL_UPD_REQ BIT(29)
+#define B_BE_WDE_AVAL_UPD_QTAID_MASK GENMASK(27, 24)
+#define B_BE_WDE_BUFMGN_FRZTMR_MODE BIT(0)
+
 #define R_BE_WDE_ERR_IMR 0x8C38
 #define B_BE_WDE_DATCHN_CAMREQ_ERR_INT_EN BIT(29)
 #define B_BE_WDE_DATCHN_ADRERR_ERR_INT_EN BIT(28)
@@ -5136,6 +5141,11 @@
 #define B_BE_PLE_START_BOUND_MASK GENMASK(14, 8)
 #define B_BE_PLE_PAGE_SEL_MASK GENMASK(1, 0)
 
+#define R_BE_PLE_BUFMGN_CTL 0x9010
+#define B_BE_PLE_AVAL_UPD_REQ BIT(29)
+#define B_BE_PLE_AVAL_UPD_QTAID_MASK GENMASK(27, 24)
+#define B_BE_PLE_BUFMGN_FRZTMR_MODE BIT(0)
+
 #define R_BE_PLE_ERR_IMR 0x9038
 #define B_BE_PLE_DATCHN_CAMREQ_ERR_INT_EN BIT(29)
 #define B_BE_PLE_DATCHN_ADRERR_ERR_INT_EN BIT(28)
-- 
2.25.1


