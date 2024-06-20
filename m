Return-Path: <linux-wireless+bounces-9267-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C46290FC6C
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jun 2024 07:58:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 954E41C212F1
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jun 2024 05:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74D2C381DE;
	Thu, 20 Jun 2024 05:58:53 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356402744C
	for <linux-wireless@vger.kernel.org>; Thu, 20 Jun 2024 05:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718863133; cv=none; b=Z+sBbQsnu8z8KZNT0d1AqRdo+F8f97FxBsdDaB8CUunZ4rZ+2jJ0sUQygQ/m50akWghTnfma7Bw7JzBOxRwHcor55T+O4fqb/9f5l8Eo3R9HydHUA3lF/4I0uraoGlARwVJ7huZoC9ioPpwA4U07Hlh2WvrAuAYBv3ACdb6qgnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718863133; c=relaxed/simple;
	bh=HKqAg5HIy3nU8MozLzqh+iqlKnArnudUvmOcllZZbZc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lzDMNFGCQVWnjdRU/XiZpGBTPKCyrRVXWm608Zb9v7WtODGRZEVgyf6Zk/jpKIp900sI57Lc7sh8VDUtCBHfQzR0BQizPiaKBYMggroS7AVpBl1GFQQAB4/8NxZDh+o+GE3QomcpGlr2jk9sPUVkQ80ClQgPJhcc4eVBV5GMcyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 45K5wmF632577647, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 45K5wmF632577647
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 20 Jun 2024 13:58:48 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 20 Jun 2024 13:58:48 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 20 Jun
 2024 13:58:48 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>
Subject: [PATCH 3/7] wifi: rtw89: wow: update config mac for 802.11ax chip
Date: Thu, 20 Jun 2024 13:58:21 +0800
Message-ID: <20240620055825.17592-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240620055825.17592-1-pkshih@realtek.com>
References: <20240620055825.17592-1-pkshih@realtek.com>
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

From: Chih-Kang Chang <gary.chang@realtek.com>

The 802.11ax chip also needs rtw89_mac_cpu_io_rx(), which notifies Firmware
to start or stop WoWLAN and waits until Firmware process over. Then,
the driver can continue processing to avoid unexpected behavior.

Signed-off-by: Chih-Kang Chang <gary.chang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/mac.c    | 29 +++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/mac.h    |  1 +
 drivers/net/wireless/realtek/rtw89/mac_be.c | 20 --------------
 drivers/net/wireless/realtek/rtw89/reg.h    |  1 +
 4 files changed, 31 insertions(+), 20 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index b759fa8fbca9..73462f3343e3 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -6320,9 +6320,30 @@ int rtw89_mac_ptk_drop_by_band_and_wait(struct rtw89_dev *rtwdev,
 	return ret;
 }
 
+int rtw89_mac_cpu_io_rx(struct rtw89_dev *rtwdev, bool wow_enable)
+{
+	struct rtw89_mac_h2c_info h2c_info = {};
+	struct rtw89_mac_c2h_info c2h_info = {};
+	u32 ret;
+
+	h2c_info.id = RTW89_FWCMD_H2CREG_FUNC_WOW_CPUIO_RX_CTRL;
+	h2c_info.content_len = sizeof(h2c_info.u.hdr);
+	h2c_info.u.hdr.w0 = u32_encode_bits(wow_enable, RTW89_H2CREG_WOW_CPUIO_RX_CTRL_EN);
+
+	ret = rtw89_fw_msg_reg(rtwdev, &h2c_info, &c2h_info);
+	if (ret)
+		return ret;
+
+	if (c2h_info.id != RTW89_FWCMD_C2HREG_FUNC_WOW_CPUIO_RX_ACK)
+		ret = -EINVAL;
+
+	return ret;
+}
+
 static int rtw89_wow_config_mac_ax(struct rtw89_dev *rtwdev, bool enable_wow)
 {
 	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
+	const struct rtw89_chip_info *chip = rtwdev->chip;
 	int ret;
 
 	if (enable_wow) {
@@ -6333,12 +6354,19 @@ static int rtw89_wow_config_mac_ax(struct rtw89_dev *rtwdev, bool enable_wow)
 		}
 
 		rtw89_write32_set(rtwdev, R_AX_RX_FUNCTION_STOP, B_AX_HDR_RX_STOP);
+		rtw89_mac_cpu_io_rx(rtwdev, enable_wow);
 		rtw89_write32_clr(rtwdev, mac->rx_fltr, B_AX_SNIFFER_MODE);
 		rtw89_mac_cfg_ppdu_status(rtwdev, RTW89_MAC_0, false);
 		rtw89_write32(rtwdev, R_AX_ACTION_FWD0, 0);
 		rtw89_write32(rtwdev, R_AX_ACTION_FWD1, 0);
 		rtw89_write32(rtwdev, R_AX_TF_FWD, 0);
 		rtw89_write32(rtwdev, R_AX_HW_RPT_FWD, 0);
+
+		if (chip->chip_id == RTL8852A || rtw89_is_rtl885xb(rtwdev))
+			rtw89_write8(rtwdev, R_BE_DBG_WOW_READY, WOWLAN_NOT_READY);
+		else
+			rtw89_write32_set(rtwdev, R_AX_DBG_WOW,
+					  B_AX_DBG_WOW_CPU_IO_RX_EN);
 	} else {
 		ret = rtw89_mac_resize_ple_rx_quota(rtwdev, false);
 		if (ret) {
@@ -6346,6 +6374,7 @@ static int rtw89_wow_config_mac_ax(struct rtw89_dev *rtwdev, bool enable_wow)
 			return ret;
 		}
 
+		rtw89_mac_cpu_io_rx(rtwdev, enable_wow);
 		rtw89_write32_clr(rtwdev, R_AX_RX_FUNCTION_STOP, B_AX_HDR_RX_STOP);
 		rtw89_mac_cfg_ppdu_status(rtwdev, RTW89_MAC_0, true);
 		rtw89_write32(rtwdev, R_AX_ACTION_FWD0, TRXCFG_MPDU_PROC_ACT_FRWD);
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index a580cb719233..cc9f914d440c 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -1446,5 +1446,6 @@ int rtw89_mac_dle_quota_change(struct rtw89_dev *rtwdev, enum rtw89_qta_mode mod
 int rtw89_mac_get_dle_rsvd_qt_cfg(struct rtw89_dev *rtwdev,
 				  enum rtw89_mac_dle_rsvd_qt_type type,
 				  struct rtw89_mac_dle_rsvd_qt_cfg *cfg);
+int rtw89_mac_cpu_io_rx(struct rtw89_dev *rtwdev, bool wow_enable);
 
 #endif
diff --git a/drivers/net/wireless/realtek/rtw89/mac_be.c b/drivers/net/wireless/realtek/rtw89/mac_be.c
index 934bdf3b398f..f212b67771d5 100644
--- a/drivers/net/wireless/realtek/rtw89/mac_be.c
+++ b/drivers/net/wireless/realtek/rtw89/mac_be.c
@@ -2312,26 +2312,6 @@ static void rtw89_mac_dump_qta_lost_be(struct rtw89_dev *rtwdev)
 	dump_err_status_dispatcher_be(rtwdev);
 }
 
-static int rtw89_mac_cpu_io_rx(struct rtw89_dev *rtwdev, bool wow_enable)
-{
-	struct rtw89_mac_h2c_info h2c_info = {};
-	struct rtw89_mac_c2h_info c2h_info = {};
-	u32 ret;
-
-	h2c_info.id = RTW89_FWCMD_H2CREG_FUNC_WOW_CPUIO_RX_CTRL;
-	h2c_info.content_len = sizeof(h2c_info.u.hdr);
-	h2c_info.u.hdr.w0 = u32_encode_bits(wow_enable, RTW89_H2CREG_WOW_CPUIO_RX_CTRL_EN);
-
-	ret = rtw89_fw_msg_reg(rtwdev, &h2c_info, &c2h_info);
-	if (ret)
-		return ret;
-
-	if (c2h_info.id != RTW89_FWCMD_C2HREG_FUNC_WOW_CPUIO_RX_ACK)
-		ret = -EINVAL;
-
-	return ret;
-}
-
 static int rtw89_wow_config_mac_be(struct rtw89_dev *rtwdev, bool enable_wow)
 {
 	if (enable_wow) {
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index fd81cf863bea..c9f6bdc84d03 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -312,6 +312,7 @@
 #define B_AX_S0_LDO_VSEL_F_MASK GENMASK(22, 21)
 
 #define R_AX_DBG_WOW 0x0504
+#define B_AX_DBG_WOW_CPU_IO_RX_EN BIT(8)
 
 #define R_AX_SEC_CTRL 0x0C00
 #define B_AX_SEC_IDMEM_SIZE_CONFIG_MASK GENMASK(17, 16)
-- 
2.25.1


