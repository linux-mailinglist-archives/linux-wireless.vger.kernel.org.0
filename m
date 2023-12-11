Return-Path: <linux-wireless+bounces-635-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC39C80C356
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Dec 2023 09:35:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 66E521F20F60
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Dec 2023 08:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E80F210E6;
	Mon, 11 Dec 2023 08:35:07 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73D92BD
	for <linux-wireless@vger.kernel.org>; Mon, 11 Dec 2023 00:35:03 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3BB8YuBB22598439, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3BB8YuBB22598439
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Dec 2023 16:34:56 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Mon, 11 Dec 2023 16:34:56 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Mon, 11 Dec
 2023 16:34:56 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH 3/6] wifi: rtw89: mac: add flags to check if CMAC and DMAC are enabled
Date: Mon, 11 Dec 2023 16:33:38 +0800
Message-ID: <20231211083341.118047-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231211083341.118047-1-pkshih@realtek.com>
References: <20231211083341.118047-1-pkshih@realtek.com>
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

Before accessing CMAC and DMAC registers, we should ensure they have been
powered on, so add flag to determine the state. For old chips, we read
registers and check corresponding bit, but it takes extra cost to read.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h     |  3 +++
 drivers/net/wireless/realtek/rtw89/mac.c      | 10 ++++++++--
 drivers/net/wireless/realtek/rtw89/mac.h      | 11 ++++++++++-
 drivers/net/wireless/realtek/rtw89/mac_be.c   | 17 +++++++++++++++++
 drivers/net/wireless/realtek/rtw89/rtw8922a.c |  4 ++++
 5 files changed, 42 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index b1e498ad149e..98b48699953e 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -4111,6 +4111,9 @@ struct rtw89_hal {
 
 enum rtw89_flags {
 	RTW89_FLAG_POWERON,
+	RTW89_FLAG_DMAC_FUNC,
+	RTW89_FLAG_CMAC0_FUNC,
+	RTW89_FLAG_CMAC1_FUNC,
 	RTW89_FLAG_FW_RDY,
 	RTW89_FLAG_RUNNING,
 	RTW89_FLAG_BFEE_MON,
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 2da9c7a9629c..62c4f407f76d 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -57,8 +57,8 @@ static u32 rtw89_mac_mem_read(struct rtw89_dev *rtwdev, u32 offset,
 	return rtw89_read32(rtwdev, mac->indir_access_addr);
 }
 
-int rtw89_mac_check_mac_en(struct rtw89_dev *rtwdev, u8 mac_idx,
-			   enum rtw89_mac_hwmod_sel sel)
+static int rtw89_mac_check_mac_en_ax(struct rtw89_dev *rtwdev, u8 mac_idx,
+				     enum rtw89_mac_hwmod_sel sel)
 {
 	u32 val, r_val;
 
@@ -1473,9 +1473,14 @@ static int rtw89_mac_power_switch(struct rtw89_dev *rtwdev, bool on)
 
 	if (on) {
 		set_bit(RTW89_FLAG_POWERON, rtwdev->flags);
+		set_bit(RTW89_FLAG_DMAC_FUNC, rtwdev->flags);
+		set_bit(RTW89_FLAG_CMAC0_FUNC, rtwdev->flags);
 		rtw89_write8(rtwdev, R_AX_SCOREBOARD + 3, MAC_AX_NOTIFY_TP_MAJOR);
 	} else {
 		clear_bit(RTW89_FLAG_POWERON, rtwdev->flags);
+		clear_bit(RTW89_FLAG_DMAC_FUNC, rtwdev->flags);
+		clear_bit(RTW89_FLAG_CMAC0_FUNC, rtwdev->flags);
+		clear_bit(RTW89_FLAG_CMAC1_FUNC, rtwdev->flags);
 		clear_bit(RTW89_FLAG_FW_RDY, rtwdev->flags);
 		rtw89_write8(rtwdev, R_AX_SCOREBOARD + 3, MAC_AX_NOTIFY_PWR_MAJOR);
 		rtw89_set_entity_state(rtwdev, false);
@@ -6100,6 +6105,7 @@ const struct rtw89_mac_gen_def rtw89_mac_gen_ax = {
 			B_AX_BFMEE_HE_NDPA_EN,
 	},
 
+	.check_mac_en = rtw89_mac_check_mac_en_ax,
 	.hci_func_en = rtw89_mac_hci_func_en_ax,
 	.dmac_func_pre_en = rtw89_mac_dmac_func_pre_en_ax,
 	.dle_func_en = dle_func_en_ax,
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index 44248900f426..2b5deb6ce9de 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -898,6 +898,8 @@ struct rtw89_mac_gen_def {
 	struct rtw89_reg_def muedca_ctrl;
 	struct rtw89_reg_def bfee_ctrl;
 
+	int (*check_mac_en)(struct rtw89_dev *rtwdev, u8 band,
+			    enum rtw89_mac_hwmod_sel sel);
 	void (*hci_func_en)(struct rtw89_dev *rtwdev);
 	void (*dmac_func_pre_en)(struct rtw89_dev *rtwdev);
 	void (*dle_func_en)(struct rtw89_dev *rtwdev, bool enable);
@@ -1044,8 +1046,15 @@ rtw89_write32_port_set(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
 void rtw89_mac_pwr_off(struct rtw89_dev *rtwdev);
 int rtw89_mac_partial_init(struct rtw89_dev *rtwdev, bool include_bb);
 int rtw89_mac_init(struct rtw89_dev *rtwdev);
+static inline
 int rtw89_mac_check_mac_en(struct rtw89_dev *rtwdev, u8 band,
-			   enum rtw89_mac_hwmod_sel sel);
+			   enum rtw89_mac_hwmod_sel sel)
+{
+	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
+
+	return mac->check_mac_en(rtwdev, band, sel);
+}
+
 int rtw89_mac_write_lte(struct rtw89_dev *rtwdev, const u32 offset, u32 val);
 int rtw89_mac_read_lte(struct rtw89_dev *rtwdev, const u32 offset, u32 *val);
 int rtw89_mac_dle_dfi_cfg(struct rtw89_dev *rtwdev, struct rtw89_mac_dle_dfi_ctrl *ctrl);
diff --git a/drivers/net/wireless/realtek/rtw89/mac_be.c b/drivers/net/wireless/realtek/rtw89/mac_be.c
index 23180d222623..fa3f5ef289cb 100644
--- a/drivers/net/wireless/realtek/rtw89/mac_be.c
+++ b/drivers/net/wireless/realtek/rtw89/mac_be.c
@@ -57,6 +57,22 @@ static const struct rtw89_port_reg rtw89_port_base_be = {
 		    R_BE_PORT_HGQ_WINDOW_CFG + 3},
 };
 
+static int rtw89_mac_check_mac_en_be(struct rtw89_dev *rtwdev, u8 mac_idx,
+				     enum rtw89_mac_hwmod_sel sel)
+{
+	if (sel == RTW89_DMAC_SEL &&
+	    test_bit(RTW89_FLAG_DMAC_FUNC, rtwdev->flags))
+		return 0;
+	if (sel == RTW89_CMAC_SEL && mac_idx == RTW89_MAC_0 &&
+	    test_bit(RTW89_FLAG_CMAC0_FUNC, rtwdev->flags))
+		return 0;
+	if (sel == RTW89_CMAC_SEL && mac_idx == RTW89_MAC_1 &&
+	    test_bit(RTW89_FLAG_CMAC1_FUNC, rtwdev->flags))
+		return 0;
+
+	return -EFAULT;
+}
+
 static void hfc_get_mix_info_be(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_hfc_param *param = &rtwdev->mac.hfc_param;
@@ -1145,6 +1161,7 @@ const struct rtw89_mac_gen_def rtw89_mac_gen_be = {
 			B_BE_BFMEE_HE_NDPA_EN | B_BE_BFMEE_EHT_NDPA_EN,
 	},
 
+	.check_mac_en = rtw89_mac_check_mac_en_be,
 	.hci_func_en = rtw89_mac_hci_func_en_be,
 	.dmac_func_pre_en = rtw89_mac_dmac_func_pre_en_be,
 	.dle_func_en = dle_func_en_be,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a.c b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
index 92677d7ce249..0e7300cc6d9e 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
@@ -257,6 +257,8 @@ static int rtw8922a_pwr_on_func(struct rtw89_dev *rtwdev)
 			  B_BE_H_AXIDMA_EN | B_BE_DMAC_MLO_EN | B_BE_PLRLS_EN |
 			  B_BE_P_AXIDMA_EN | B_BE_DLE_DATACPUIO_EN | B_BE_LTR_CTL_EN);
 
+	set_bit(RTW89_FLAG_DMAC_FUNC, rtwdev->flags);
+
 	rtw89_write32_set(rtwdev, R_BE_CMAC_SHARE_FUNC_EN,
 			  B_BE_CMAC_SHARE_EN | B_BE_RESPBA_EN | B_BE_ADDRSRCH_EN |
 			  B_BE_BTCOEX_EN);
@@ -266,6 +268,8 @@ static int rtw8922a_pwr_on_func(struct rtw89_dev *rtwdev)
 			  B_BE_PTCLTOP_EN | B_BE_SCHEDULER_EN | B_BE_TMAC_EN |
 			  B_BE_RMAC_EN | B_BE_TXTIME_EN | B_BE_RESP_PKTCTL_EN);
 
+	set_bit(RTW89_FLAG_CMAC0_FUNC, rtwdev->flags);
+
 	rtw89_write32_set(rtwdev, R_BE_FEN_RST_ENABLE, B_BE_FEN_BB_IP_RSTN |
 						       B_BE_FEN_BBPLAT_RSTB);
 
-- 
2.25.1


