Return-Path: <linux-wireless+bounces-847-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A82BA81579B
	for <lists+linux-wireless@lfdr.de>; Sat, 16 Dec 2023 05:59:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E937287992
	for <lists+linux-wireless@lfdr.de>; Sat, 16 Dec 2023 04:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0E5814AA5;
	Sat, 16 Dec 2023 04:59:14 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91D014009
	for <linux-wireless@vger.kernel.org>; Sat, 16 Dec 2023 04:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3BG4wxy772055315, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3BG4wxy772055315
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 16 Dec 2023 12:58:59 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Sat, 16 Dec 2023 12:58:59 +0800
Received: from [127.0.1.1] (172.16.17.49) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Sat, 16 Dec
 2023 12:58:58 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH 1/2] wifi: rtw89: mac: add sys_init and filter option for WiFi 7 chips
Date: Sat, 16 Dec 2023 12:57:38 +0800
Message-ID: <20231216045739.10432-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231216045739.10432-1-pkshih@realtek.com>
References: <20231216045739.10432-1-pkshih@realtek.com>
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

The sys_init is to enable hardware function block of DMAC (data-path MAC),
CMAC (control-path MAC) and others called 'chip_func'. To understand the
functionality of this function, we keep some functions as empty.

The other is typ_fltr_opt that is to configure filter option to decide
whether RX packets engine can forward packets to host or WiFi CPU.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/mac_be.c | 111 ++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/reg.h    |  14 +++
 2 files changed, 125 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/mac_be.c b/drivers/net/wireless/realtek/rtw89/mac_be.c
index fa3f5ef289cb..762a4e2f9c28 100644
--- a/drivers/net/wireless/realtek/rtw89/mac_be.c
+++ b/drivers/net/wireless/realtek/rtw89/mac_be.c
@@ -566,6 +566,114 @@ static int rtw89_fwdl_check_path_ready_be(struct rtw89_dev *rtwdev,
 					rtwdev, R_BE_WCPU_FW_CTRL);
 }
 
+static int dmac_func_en_be(struct rtw89_dev *rtwdev)
+{
+	return 0;
+}
+
+static int cmac_func_en_be(struct rtw89_dev *rtwdev, u8 mac_idx, bool en)
+{
+	u32 reg;
+
+	if (mac_idx > RTW89_MAC_1)
+		return -EINVAL;
+
+	if (mac_idx == RTW89_MAC_0)
+		return 0;
+
+	if (en) {
+		rtw89_write32_set(rtwdev, R_BE_AFE_CTRL1, B_BE_AFE_CTRL1_SET);
+		rtw89_write32_clr(rtwdev, R_BE_SYS_ISO_CTRL_EXTEND, B_BE_R_SYM_ISO_CMAC12PP);
+		rtw89_write32_set(rtwdev, R_BE_FEN_RST_ENABLE, B_BE_CMAC1_FEN);
+
+		reg = rtw89_mac_reg_by_idx(rtwdev, R_BE_CK_EN, mac_idx);
+		rtw89_write32_set(rtwdev, reg, B_BE_CK_EN_SET);
+
+		reg = rtw89_mac_reg_by_idx(rtwdev, R_BE_CMAC_FUNC_EN, mac_idx);
+		rtw89_write32_set(rtwdev, reg, B_BE_CMAC_FUNC_EN_SET);
+
+		set_bit(RTW89_FLAG_CMAC1_FUNC, rtwdev->flags);
+	} else {
+		reg = rtw89_mac_reg_by_idx(rtwdev, R_BE_CMAC_FUNC_EN, mac_idx);
+		rtw89_write32_clr(rtwdev, reg, B_BE_CMAC_FUNC_EN_SET);
+
+		reg = rtw89_mac_reg_by_idx(rtwdev, R_BE_CK_EN, mac_idx);
+		rtw89_write32_clr(rtwdev, reg, B_BE_CK_EN_SET);
+
+		rtw89_write32_clr(rtwdev, R_BE_FEN_RST_ENABLE, B_BE_CMAC1_FEN);
+		rtw89_write32_set(rtwdev, R_BE_SYS_ISO_CTRL_EXTEND, B_BE_R_SYM_ISO_CMAC12PP);
+		rtw89_write32_clr(rtwdev, R_BE_AFE_CTRL1, B_BE_AFE_CTRL1_SET);
+
+		clear_bit(RTW89_FLAG_CMAC1_FUNC, rtwdev->flags);
+	}
+
+	return 0;
+}
+
+static int chip_func_en_be(struct rtw89_dev *rtwdev)
+{
+	return 0;
+}
+
+static int sys_init_be(struct rtw89_dev *rtwdev)
+{
+	int ret;
+
+	ret = dmac_func_en_be(rtwdev);
+	if (ret)
+		return ret;
+
+	ret = cmac_func_en_be(rtwdev, RTW89_MAC_0, true);
+	if (ret)
+		return ret;
+
+	ret = chip_func_en_be(rtwdev);
+	if (ret)
+		return ret;
+
+	return ret;
+}
+
+static int rtw89_mac_typ_fltr_opt_be(struct rtw89_dev *rtwdev,
+				     enum rtw89_machdr_frame_type type,
+				     enum rtw89_mac_fwd_target fwd_target,
+				     u8 mac_idx)
+{
+	u32 reg;
+	u32 val;
+
+	switch (fwd_target) {
+	case RTW89_FWD_DONT_CARE:
+		val = RX_FLTR_FRAME_DROP_BE;
+		break;
+	case RTW89_FWD_TO_HOST:
+	case RTW89_FWD_TO_WLAN_CPU:
+		val = RX_FLTR_FRAME_ACCEPT_BE;
+		break;
+	default:
+		rtw89_err(rtwdev, "[ERR]set rx filter fwd target err\n");
+		return -EINVAL;
+	}
+
+	switch (type) {
+	case RTW89_MGNT:
+		reg = rtw89_mac_reg_by_idx(rtwdev, R_BE_MGNT_FLTR, mac_idx);
+		break;
+	case RTW89_CTRL:
+		reg = rtw89_mac_reg_by_idx(rtwdev, R_BE_CTRL_FLTR, mac_idx);
+		break;
+	case RTW89_DATA:
+		reg = rtw89_mac_reg_by_idx(rtwdev, R_BE_DATA_FLTR, mac_idx);
+		break;
+	default:
+		rtw89_err(rtwdev, "[ERR]set rx filter type err\n");
+		return -EINVAL;
+	}
+	rtw89_write32(rtwdev, reg, val);
+
+	return 0;
+}
+
 static int dle_buf_req_be(struct rtw89_dev *rtwdev, u16 buf_len, bool wd, u16 *pkt_id)
 {
 	u32 val, reg;
@@ -1162,12 +1270,15 @@ const struct rtw89_mac_gen_def rtw89_mac_gen_be = {
 	},
 
 	.check_mac_en = rtw89_mac_check_mac_en_be,
+	.sys_init = sys_init_be,
 	.hci_func_en = rtw89_mac_hci_func_en_be,
 	.dmac_func_pre_en = rtw89_mac_dmac_func_pre_en_be,
 	.dle_func_en = dle_func_en_be,
 	.dle_clk_en = dle_clk_en_be,
 	.bf_assoc = rtw89_mac_bf_assoc_be,
 
+	.typ_fltr_opt = rtw89_mac_typ_fltr_opt_be,
+
 	.dle_mix_cfg = dle_mix_cfg_be,
 	.chk_dle_rdy = chk_dle_rdy_be,
 	.dle_buf_req = dle_buf_req_be,
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 65d8a0f36700..5c27af7d77fa 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -6545,6 +6545,20 @@
 #define B_BE_A_A1_MATCH BIT(1)
 #define B_BE_SNIFFER_MODE BIT(0)
 
+#define R_BE_CTRL_FLTR 0x11424
+#define R_BE_CTRL_FLTR_C1 0x15424
+#define B_BE_CTRL_STYPE_MASK GENMASK(15, 0)
+#define RX_FLTR_FRAME_DROP_BE 0x0000
+#define RX_FLTR_FRAME_ACCEPT_BE 0xFFFF
+
+#define R_BE_MGNT_FLTR 0x11428
+#define R_BE_MGNT_FLTR_C1 0x15428
+#define B_BE_MGNT_STYPE_MASK GENMASK(15, 0)
+
+#define R_BE_DATA_FLTR 0x1142C
+#define R_BE_DATA_FLTR_C1 0x1542C
+#define B_BE_DATA_STYPE_MASK GENMASK(15, 0)
+
 #define R_BE_CSIRPT_OPTION 0x11464
 #define R_BE_CSIRPT_OPTION_C1 0x15464
 #define B_BE_CSIPRT_EHTSU_AID_EN BIT(26)
-- 
2.25.1


