Return-Path: <linux-wireless+bounces-26-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 567017F6CBD
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Nov 2023 08:18:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BACE1B20E60
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Nov 2023 07:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB3D67465;
	Fri, 24 Nov 2023 07:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D7A9A
	for <linux-wireless@vger.kernel.org>; Thu, 23 Nov 2023 23:18:13 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3AO7I5XV03551130, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3AO7I5XV03551130
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Nov 2023 15:18:05 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Fri, 24 Nov 2023 15:18:06 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 24 Nov
 2023 15:18:05 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 2/8] wifi: rtw89: mac: add to get DLE reserved quota
Date: Fri, 24 Nov 2023 15:16:57 +0800
Message-ID: <20231124071703.132549-3-pkshih@realtek.com>
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

The reserved quota of DLE (data link engine) is used for processing next
packet. Add this to get quota number, and then WiFi 7 chips can use them.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h |  2 +
 drivers/net/wireless/realtek/rtw89/mac.c  | 55 +++++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/mac.h  | 19 ++++++++
 3 files changed, 76 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 4a8331cf2c2d..4fcad17dd9b7 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -3791,8 +3791,10 @@ enum rtw89_hcifc_mode {
 };
 
 struct rtw89_dle_info {
+	const struct rtw89_rsvd_quota *rsvd_qt;
 	enum rtw89_qta_mode qta_mode;
 	u16 ple_pg_size;
+	u16 ple_free_pg;
 	u16 c0_rx_qta;
 	u16 c1_rx_qta;
 };
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index b93a00f56cb9..ac14865a114a 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -1555,7 +1555,9 @@ static const struct rtw89_dle_mem *get_dle_mem_cfg(struct rtw89_dev *rtwdev,
 		return NULL;
 	}
 
+	mac->dle_info.rsvd_qt = cfg->rsvd_qt;
 	mac->dle_info.ple_pg_size = cfg->ple_size->pge_size;
+	mac->dle_info.ple_free_pg = cfg->ple_size->lnk_pge_num;
 	mac->dle_info.qta_mode = mode;
 	mac->dle_info.c0_rx_qta = cfg->ple_min_qt->cma0_dma;
 	mac->dle_info.c1_rx_qta = cfg->ple_min_qt->cma1_dma;
@@ -1563,6 +1565,59 @@ static const struct rtw89_dle_mem *get_dle_mem_cfg(struct rtw89_dev *rtwdev,
 	return cfg;
 }
 
+int rtw89_mac_get_dle_rsvd_qt_cfg(struct rtw89_dev *rtwdev,
+				  enum rtw89_mac_dle_rsvd_qt_type type,
+				  struct rtw89_mac_dle_rsvd_qt_cfg *cfg)
+{
+	struct rtw89_dle_info *dle_info = &rtwdev->mac.dle_info;
+	const struct rtw89_rsvd_quota *rsvd_qt = dle_info->rsvd_qt;
+
+	switch (type) {
+	case DLE_RSVD_QT_MPDU_INFO:
+		cfg->pktid = dle_info->ple_free_pg;
+		cfg->pg_num = rsvd_qt->mpdu_info_tbl;
+		break;
+	case DLE_RSVD_QT_B0_CSI:
+		cfg->pktid = dle_info->ple_free_pg + rsvd_qt->mpdu_info_tbl;
+		cfg->pg_num = rsvd_qt->b0_csi;
+		break;
+	case DLE_RSVD_QT_B1_CSI:
+		cfg->pktid = dle_info->ple_free_pg +
+			     rsvd_qt->mpdu_info_tbl + rsvd_qt->b0_csi;
+		cfg->pg_num = rsvd_qt->b1_csi;
+		break;
+	case DLE_RSVD_QT_B0_LMR:
+		cfg->pktid = dle_info->ple_free_pg +
+			     rsvd_qt->mpdu_info_tbl + rsvd_qt->b0_csi + rsvd_qt->b1_csi;
+		cfg->pg_num = rsvd_qt->b0_lmr;
+		break;
+	case DLE_RSVD_QT_B1_LMR:
+		cfg->pktid = dle_info->ple_free_pg +
+			     rsvd_qt->mpdu_info_tbl + rsvd_qt->b0_csi + rsvd_qt->b1_csi +
+			     rsvd_qt->b0_lmr;
+		cfg->pg_num = rsvd_qt->b1_lmr;
+		break;
+	case DLE_RSVD_QT_B0_FTM:
+		cfg->pktid = dle_info->ple_free_pg +
+			     rsvd_qt->mpdu_info_tbl + rsvd_qt->b0_csi + rsvd_qt->b1_csi +
+			     rsvd_qt->b0_lmr + rsvd_qt->b1_lmr;
+		cfg->pg_num = rsvd_qt->b0_ftm;
+		break;
+	case DLE_RSVD_QT_B1_FTM:
+		cfg->pktid = dle_info->ple_free_pg +
+			     rsvd_qt->mpdu_info_tbl + rsvd_qt->b0_csi + rsvd_qt->b1_csi +
+			     rsvd_qt->b0_lmr + rsvd_qt->b1_lmr + rsvd_qt->b0_ftm;
+		cfg->pg_num = rsvd_qt->b1_ftm;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	cfg->size = (u32)cfg->pg_num * dle_info->ple_pg_size;
+
+	return 0;
+}
+
 static bool mac_is_txq_empty(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_mac_dle_dfi_qempty qempty;
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index 511ee5dc4240..b16fa9bbd412 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -650,6 +650,22 @@ struct rtw89_mac_dle_dfi_qempty {
 	u32 qempty;
 };
 
+enum rtw89_mac_dle_rsvd_qt_type {
+	DLE_RSVD_QT_MPDU_INFO,
+	DLE_RSVD_QT_B0_CSI,
+	DLE_RSVD_QT_B1_CSI,
+	DLE_RSVD_QT_B0_LMR,
+	DLE_RSVD_QT_B1_LMR,
+	DLE_RSVD_QT_B0_FTM,
+	DLE_RSVD_QT_B1_FTM,
+};
+
+struct rtw89_mac_dle_rsvd_qt_cfg {
+	u16 pktid;
+	u16 pg_num;
+	u32 size;
+};
+
 enum rtw89_mac_error_scenario {
 	RTW89_RXI300_ERROR		= 1,
 	RTW89_WCPU_CPU_EXCEPTION	= 2,
@@ -1254,5 +1270,8 @@ int rtw89_mac_resize_ple_rx_quota(struct rtw89_dev *rtwdev, bool wow);
 int rtw89_mac_ptk_drop_by_band_and_wait(struct rtw89_dev *rtwdev,
 					enum rtw89_mac_idx band);
 void rtw89_mac_hw_mgnt_sec(struct rtw89_dev *rtwdev, bool wow);
+int rtw89_mac_get_dle_rsvd_qt_cfg(struct rtw89_dev *rtwdev,
+				  enum rtw89_mac_dle_rsvd_qt_type type,
+				  struct rtw89_mac_dle_rsvd_qt_cfg *cfg);
 
 #endif
-- 
2.25.1


