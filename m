Return-Path: <linux-wireless+bounces-17176-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23FADA0505B
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Jan 2025 03:14:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01205166B41
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Jan 2025 02:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26FDC19C56D;
	Wed,  8 Jan 2025 02:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="kdQ2d7cr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12800181B8F
	for <linux-wireless@vger.kernel.org>; Wed,  8 Jan 2025 02:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736302218; cv=none; b=JeTgwjwSELtNxh6ldaD1U0KRZU5e5BZ7BaRm3Rygy3nsOZhZ5UNUsl5P20CnAa+MmCyy/h7oc40XjkQU8nc+PMhDbjsXEPcaDZ7i0vM+ui7cHjGBV+f1cT7XjCHUwIz549Ngh5upv0jJ0ceQp0M/kQl1YUEuv335fbhdRhWiZXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736302218; c=relaxed/simple;
	bh=JWbNkZAv/SwV6UBCiYw0QzdK5dXt3fufYrH/qCCcuZI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZY15/VqaYslZ18Kv0pNnASN1L0s+iT3KVRhEl5W3/GTzBFgm4HBPLhjgfSJn+EMybMF/thKKB6Ig8MGB6KyRo4QtBdGaWQZicl7z9crkhfoyfseQ2C67YvGnnrIyWWzqC84Yu008CyoK52oOniXkG48BTasvuxlYRiEQ3EW2Ab0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=kdQ2d7cr; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 5082ACcP4619990, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1736302212; bh=JWbNkZAv/SwV6UBCiYw0QzdK5dXt3fufYrH/qCCcuZI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=kdQ2d7crEQACm1jgw2WhXTT4uilOgSPOjUI8uJCggVYPy45zd+EBc4UGblPbLcNb1
	 pCdGNOJ2mlWyV5uLYlRKx7zsDUkW6lE3ldeQj5sD/OqnrueOl3y84Qv9wAoKkMPfjA
	 y2F7Rw4HMKKkxdpC1DTlbyFAii6kxo60EiqM0J2s9RWNQtmq8zP5rBGIvJfJ4f4C3w
	 BkU0jVmhqQFN9H5NfGNpAecyr3mpawnTFbV5RxC7kng9Lf7gHqK2hO5s0bD4nPO3I7
	 DFtFGicIiabXVA2QAvX56RzQs6S1mExFTaMrU9JmrRKitKWEg8f7LQK+VOKwTrHD5/
	 raa6/VRl/gNjQ==
Received: from mail.realtek.com (ewssrv.realtek.com[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 5082ACcP4619990
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 8 Jan 2025 10:10:12 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 8 Jan 2025 10:10:12 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 8 Jan
 2025 10:10:11 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 1/2] wifi: rtw89: read hardware capabilities part 1 via firmware command
Date: Wed, 8 Jan 2025 10:09:54 +0800
Message-ID: <20250108020955.14668-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250108020955.14668-1-pkshih@realtek.com>
References: <20250108020955.14668-1-pkshih@realtek.com>
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

Firmware after version 0.35.51.0 defines and exports more hardware
capabilities, which driver will consider reported QAM field as
EHT MCS capability to register hardware.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2:
 - correct version (0.35.39.0 -> 0.35.51.0) that firmware can support to
   read hardware capabilities part1. 
---
 drivers/net/wireless/realtek/rtw89/core.h |  1 +
 drivers/net/wireless/realtek/rtw89/fw.c   |  1 +
 drivers/net/wireless/realtek/rtw89/fw.h   | 16 +++++
 drivers/net/wireless/realtek/rtw89/mac.c  | 87 ++++++++++++++++++++---
 4 files changed, 95 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 37722a0b6a8b..5b086ab36a3c 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -4468,6 +4468,7 @@ enum rtw89_fw_feature {
 	RTW89_FW_FEATURE_NOTIFY_AP_INFO,
 	RTW89_FW_FEATURE_CH_INFO_BE_V0,
 	RTW89_FW_FEATURE_LPS_CH_INFO,
+	RTW89_FW_FEATURE_NO_PHYCAP_P1,
 };
 
 struct rtw89_fw_suit {
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 90db15685728..2dc4bf4b1691 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -734,6 +734,7 @@ static const struct __fw_feat_cfg fw_feat_tbl[] = {
 	__CFG_FW_FEAT(RTL8922A, ge, 0, 35, 46, 0, NOTIFY_AP_INFO),
 	__CFG_FW_FEAT(RTL8922A, lt, 0, 35, 47, 0, CH_INFO_BE_V0),
 	__CFG_FW_FEAT(RTL8922A, lt, 0, 35, 49, 0, RFK_PRE_NOTIFY_V1),
+	__CFG_FW_FEAT(RTL8922A, lt, 0, 35, 51, 0, NO_PHYCAP_P1),
 };
 
 static void rtw89_fw_iterate_feature_cfg(struct rtw89_fw_info *fw,
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index a3fe183c2ab0..2026bc2fd2ac 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -47,6 +47,19 @@ struct rtw89_c2hreg_phycap {
 #define RTW89_C2HREG_PHYCAP_W2_HW_TYPE GENMASK(7, 0)
 #define RTW89_C2HREG_PHYCAP_W3_ANT_TX_NUM GENMASK(15, 8)
 #define RTW89_C2HREG_PHYCAP_W3_ANT_RX_NUM GENMASK(23, 16)
+#define RTW89_C2HREG_PHYCAP_W3_BAND_SEL GENMASK(31, 24)
+
+#define RTW89_C2HREG_PHYCAP_P1_W0_B1_RX_NSS GENMASK(23, 16)
+#define RTW89_C2HREG_PHYCAP_P1_W0_B1_BW GENMASK(31, 24)
+#define RTW89_C2HREG_PHYCAP_P1_W1_B1_TX_NSS GENMASK(7, 0)
+#define RTW89_C2HREG_PHYCAP_P1_W1_B1_ANT_TX_NUM GENMASK(15, 8)
+#define RTW89_C2HREG_PHYCAP_P1_W1_B1_ANT_RX_NUM GENMASK(23, 16)
+#define RTW89_C2HREG_PHYCAP_P1_W1_B1_BAND_SEL GENMASK(31, 24)
+#define RTW89_C2HREG_PHYCAP_P1_W2_QAM GENMASK(7, 0)
+#define RTW89_C2HREG_PHYCAP_P1_W2_QAM_256  0x1
+#define RTW89_C2HREG_PHYCAP_P1_W2_QAM_1024 0x2
+#define RTW89_C2HREG_PHYCAP_P1_W2_QAM_4096 0x3
+#define RTW89_C2HREG_PHYCAP_P1_W2_B1_QAM GENMASK(15, 8)
 
 #define RTW89_C2HREG_AOAC_RPT_1_W0_KEY_IDX GENMASK(23, 16)
 #define RTW89_C2HREG_AOAC_RPT_1_W1_IV_0 GENMASK(7, 0)
@@ -92,6 +105,8 @@ struct rtw89_h2creg_sch_tx_en {
 
 #define RTW89_H2CREG_WOW_CPUIO_RX_CTRL_EN GENMASK(23, 16)
 
+#define RTW89_H2CREG_GET_FEATURE_PART_NUM GENMASK(23, 16)
+
 #define RTW89_H2CREG_MAX 4
 #define RTW89_C2HREG_MAX 4
 #define RTW89_C2HREG_HDR_LEN 2
@@ -138,6 +153,7 @@ enum rtw89_mac_c2h_type {
 	RTW89_FWCMD_C2HREG_FUNC_PHY_CAP,
 	RTW89_FWCMD_C2HREG_FUNC_TX_PAUSE_RPT,
 	RTW89_FWCMD_C2HREG_FUNC_WOW_CPUIO_RX_ACK = 0xA,
+	RTW89_FWCMD_C2HREG_FUNC_PHY_CAP_PART1 = 0xC,
 	RTW89_FWCMD_C2HREG_FUNC_NULL = 0xFF,
 };
 
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index c78066fd4504..e362214669db 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -2898,22 +2898,42 @@ static int cmac_init_ax(struct rtw89_dev *rtwdev, u8 mac_idx)
 }
 
 static int rtw89_mac_read_phycap(struct rtw89_dev *rtwdev,
-				 struct rtw89_mac_c2h_info *c2h_info)
+				 struct rtw89_mac_c2h_info *c2h_info, u8 part_num)
 {
 	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
-	struct rtw89_mac_h2c_info h2c_info = {0};
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+	struct rtw89_mac_h2c_info h2c_info = {};
+	enum rtw89_mac_c2h_type c2h_type;
+	u8 content_len;
 	u32 ret;
 
+	if (chip->chip_gen == RTW89_CHIP_AX)
+		content_len = 0;
+	else
+		content_len = 2;
+
+	switch (part_num) {
+	case 0:
+		c2h_type = RTW89_FWCMD_C2HREG_FUNC_PHY_CAP;
+		break;
+	case 1:
+		c2h_type = RTW89_FWCMD_C2HREG_FUNC_PHY_CAP_PART1;
+		break;
+	default:
+		return -EINVAL;
+	}
+
 	mac->cnv_efuse_state(rtwdev, false);
 
 	h2c_info.id = RTW89_FWCMD_H2CREG_FUNC_GET_FEATURE;
-	h2c_info.content_len = 0;
+	h2c_info.content_len = content_len;
+	h2c_info.u.hdr.w0 = u32_encode_bits(part_num, RTW89_H2CREG_GET_FEATURE_PART_NUM);
 
 	ret = rtw89_fw_msg_reg(rtwdev, &h2c_info, c2h_info);
 	if (ret)
 		goto out;
 
-	if (c2h_info->id != RTW89_FWCMD_C2HREG_FUNC_PHY_CAP)
+	if (c2h_info->id != c2h_type)
 		ret = -EINVAL;
 
 out:
@@ -2922,20 +2942,20 @@ static int rtw89_mac_read_phycap(struct rtw89_dev *rtwdev,
 	return ret;
 }
 
-int rtw89_mac_setup_phycap(struct rtw89_dev *rtwdev)
+static int rtw89_mac_setup_phycap_part0(struct rtw89_dev *rtwdev)
 {
-	struct rtw89_efuse *efuse = &rtwdev->efuse;
-	struct rtw89_hal *hal = &rtwdev->hal;
 	const struct rtw89_chip_info *chip = rtwdev->chip;
-	struct rtw89_mac_c2h_info c2h_info = {0};
 	const struct rtw89_c2hreg_phycap *phycap;
+	struct rtw89_efuse *efuse = &rtwdev->efuse;
+	struct rtw89_mac_c2h_info c2h_info = {};
+	struct rtw89_hal *hal = &rtwdev->hal;
 	u8 tx_nss;
 	u8 rx_nss;
 	u8 tx_ant;
 	u8 rx_ant;
-	u32 ret;
+	int ret;
 
-	ret = rtw89_mac_read_phycap(rtwdev, &c2h_info);
+	ret = rtw89_mac_read_phycap(rtwdev, &c2h_info, 0);
 	if (ret)
 		return ret;
 
@@ -2979,6 +2999,53 @@ int rtw89_mac_setup_phycap(struct rtw89_dev *rtwdev)
 	return 0;
 }
 
+static int rtw89_mac_setup_phycap_part1(struct rtw89_dev *rtwdev)
+{
+	const struct rtw89_c2hreg_phycap *phycap;
+	struct rtw89_mac_c2h_info c2h_info = {};
+	u8 qam_raw, qam;
+	int ret;
+
+	ret = rtw89_mac_read_phycap(rtwdev, &c2h_info, 1);
+	if (ret)
+		return ret;
+
+	phycap = &c2h_info.u.phycap;
+
+	qam_raw = u32_get_bits(phycap->w2, RTW89_C2HREG_PHYCAP_P1_W2_QAM);
+
+	switch (qam_raw) {
+	case RTW89_C2HREG_PHYCAP_P1_W2_QAM_256:
+	case RTW89_C2HREG_PHYCAP_P1_W2_QAM_1024:
+	case RTW89_C2HREG_PHYCAP_P1_W2_QAM_4096:
+		qam = qam_raw;
+		break;
+	default:
+		qam = RTW89_C2HREG_PHYCAP_P1_W2_QAM_4096;
+		break;
+	}
+
+	rtw89_debug(rtwdev, RTW89_DBG_FW, "phycap qam=%d/%d\n", qam_raw, qam);
+
+	return 0;
+}
+
+int rtw89_mac_setup_phycap(struct rtw89_dev *rtwdev)
+{
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+	int ret;
+
+	ret = rtw89_mac_setup_phycap_part0(rtwdev);
+	if (ret)
+		return ret;
+
+	if (chip->chip_gen == RTW89_CHIP_AX ||
+	    RTW89_CHK_FW_FEATURE(NO_PHYCAP_P1, &rtwdev->fw))
+		return 0;
+
+	return rtw89_mac_setup_phycap_part1(rtwdev);
+}
+
 static int rtw89_hw_sch_tx_en_h2c(struct rtw89_dev *rtwdev, u8 band,
 				  u16 tx_en_u16, u16 mask_u16)
 {
-- 
2.25.1


