Return-Path: <linux-wireless+bounces-25156-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD83BAFF806
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 06:25:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1C3D3B3F0A
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 04:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F165219E7D1;
	Thu, 10 Jul 2025 04:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="O/FNaR0E"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76AA206F27
	for <linux-wireless@vger.kernel.org>; Thu, 10 Jul 2025 04:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752121525; cv=none; b=K/hc9hngXI74fz2SJqH1xk8KEDkcIdSkRxAWs9c7MbZYdfVqNiXtgX6Vlt/yjmUWCKAgxmzm0vHqY46z2wgUb4arDPdqBOIxYp2Ac6RzjRigGU/l1hiPet6doSwjpgAgLXbciauUIpwJm+ARJxtZ7AokmAp0x064P3PAPnI34AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752121525; c=relaxed/simple;
	bh=3Sh2NttqlRamv5dpmDQzpcOFUjSIfQd9nJn90sS+2jo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RvEorHUdt+NpnvyB9o2dma7weRl9kTpFIR5qrFi4KmtjLwusn0qS/IE5Qrh2WxgiH2cmkZNPtfRA/G86qPAS2Y8wsnFGq5omJUiTm4HB7ivnJBY2b+lnu7z4+sC8PZhiXoNyIgpVReomkV8ZBU9jrlwsBa7R3st6/p5iA/Daqfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=O/FNaR0E; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 56A4PM0H02455829, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1752121522; bh=vcoUVK2OaRpmUukBvdV4/L3vgdCm1e0qUPOJ+gL1geU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=O/FNaR0EuPX3GkDQI064hmg/9mVkitg6M6sKCrdf4APHI05Wb0k19tg+quMmxVaiU
	 5p1Ud+XSDJDvY5x+cncjj9sr8YMzpA4GmStG872rVDA58DfsgQXzxkn5l2jQ3He/Qr
	 QrccO9+WzHNpYqsZHym5wT7RUNlUa0yJquMrbeh5OtPYeLlFjx7Wn79g28Gk30TQA7
	 C5NbUXpfd3R5kCcG2RTdB/r+rpOQOhjPl2DExKrxzD+5L7yFgbBCvIjtRAiQPKPOw1
	 PYAARDJ+rxaZ9ugiLaNJ3+9pjbAMTtpya1u5Co2RecxGhreDg8ctR5kaMJHYAovZKy
	 pBcoQpDNCiKgw==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 56A4PM0H02455829
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 10 Jul 2025 12:25:22 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 10 Jul 2025 12:25:21 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 10 Jul
 2025 12:25:20 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 07/14] wifi: rtw89: check LPS H2C command complete by C2H reg instead of done ack
Date: Thu, 10 Jul 2025 12:24:16 +0800
Message-ID: <20250710042423.73617-8-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250710042423.73617-1-pkshih@realtek.com>
References: <20250710042423.73617-1-pkshih@realtek.com>
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

8852B after FW 0.29.127, 8852BT after FW 0.29.127 and 8922A after FW
0.35.76 driver check LPS H2C command received by FW using C2H reg instead
of done ack.

Signed-off-by: Chih-Kang Chang <gary.chang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h |  1 +
 drivers/net/wireless/realtek/rtw89/fw.c   | 11 ++++++++-
 drivers/net/wireless/realtek/rtw89/fw.h   |  4 ++++
 drivers/net/wireless/realtek/rtw89/ps.c   | 28 ++++++++++++++++++++++-
 4 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 031a69bae861..470a97ec24ac 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -4608,6 +4608,7 @@ enum rtw89_fw_feature {
 	RTW89_FW_FEATURE_BEACON_LOSS_COUNT_V1,
 	RTW89_FW_FEATURE_SCAN_OFFLOAD_EXTRA_OP,
 	RTW89_FW_FEATURE_RFK_NTFY_MCC_V0,
+	RTW89_FW_FEATURE_LPS_DACK_BY_C2H_REG,
 };
 
 struct rtw89_fw_suit {
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 20b7b4b15450..8157774b2bb1 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -827,11 +827,13 @@ static const struct __fw_feat_cfg fw_feat_tbl[] = {
 	__CFG_FW_FEAT(RTL8852B, ge, 0, 29, 29, 0, SCAN_OFFLOAD),
 	__CFG_FW_FEAT(RTL8852B, ge, 0, 29, 29, 7, BEACON_FILTER),
 	__CFG_FW_FEAT(RTL8852B, lt, 0, 29, 30, 0, NO_WOW_CPU_IO_RX),
+	__CFG_FW_FEAT(RTL8852B, ge, 0, 29, 127, 0, LPS_DACK_BY_C2H_REG),
 	__CFG_FW_FEAT(RTL8852BT, ge, 0, 29, 74, 0, NO_LPS_PG),
 	__CFG_FW_FEAT(RTL8852BT, ge, 0, 29, 74, 0, TX_WAKE),
 	__CFG_FW_FEAT(RTL8852BT, ge, 0, 29, 90, 0, CRASH_TRIGGER),
 	__CFG_FW_FEAT(RTL8852BT, ge, 0, 29, 91, 0, SCAN_OFFLOAD),
 	__CFG_FW_FEAT(RTL8852BT, ge, 0, 29, 110, 0, BEACON_FILTER),
+	__CFG_FW_FEAT(RTL8852BT, ge, 0, 29, 127, 0, LPS_DACK_BY_C2H_REG),
 	__CFG_FW_FEAT(RTL8852C, le, 0, 27, 33, 0, NO_DEEP_PS),
 	__CFG_FW_FEAT(RTL8852C, ge, 0, 0, 0, 0, RFK_NTFY_MCC_V0),
 	__CFG_FW_FEAT(RTL8852C, ge, 0, 27, 34, 0, TX_WAKE),
@@ -856,6 +858,7 @@ static const struct __fw_feat_cfg fw_feat_tbl[] = {
 	__CFG_FW_FEAT(RTL8922A, lt, 0, 35, 51, 0, NO_PHYCAP_P1),
 	__CFG_FW_FEAT(RTL8922A, lt, 0, 35, 64, 0, NO_POWER_DIFFERENCE),
 	__CFG_FW_FEAT(RTL8922A, ge, 0, 35, 71, 0, BEACON_LOSS_COUNT_V1),
+	__CFG_FW_FEAT(RTL8922A, ge, 0, 35, 76, 0, LPS_DACK_BY_C2H_REG),
 };
 
 static void rtw89_fw_iterate_feature_cfg(struct rtw89_fw_info *fw,
@@ -2824,8 +2827,14 @@ int rtw89_fw_h2c_lps_parm(struct rtw89_dev *rtwdev,
 			  struct rtw89_lps_parm *lps_param)
 {
 	struct sk_buff *skb;
+	bool done_ack;
 	int ret;
 
+	if (RTW89_CHK_FW_FEATURE(LPS_DACK_BY_C2H_REG, &rtwdev->fw))
+		done_ack = false;
+	else
+		done_ack = !lps_param->psmode;
+
 	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, H2C_LPS_PARM_LEN);
 	if (!skb) {
 		rtw89_err(rtwdev, "failed to alloc skb for fw dl\n");
@@ -2847,7 +2856,7 @@ int rtw89_fw_h2c_lps_parm(struct rtw89_dev *rtwdev,
 	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
 			      H2C_CAT_MAC,
 			      H2C_CL_MAC_PS,
-			      H2C_FUNC_MAC_LPS_PARM, 0, !lps_param->psmode,
+			      H2C_FUNC_MAC_LPS_PARM, 0, done_ack,
 			      H2C_LPS_PARM_LEN);
 
 	ret = rtw89_h2c_tx(rtwdev, skb, false);
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index 479a9f980b7f..629e54adcb83 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -87,6 +87,9 @@ struct rtw89_c2hreg_phycap {
 #define RTW89_C2HREG_AOAC_RPT_2_W3_IGTK_IPN_IV_6 GENMASK(7, 0)
 #define RTW89_C2HREG_AOAC_RPT_2_W3_IGTK_IPN_IV_7 GENMASK(15, 8)
 
+#define RTW89_C2HREG_PS_LEAVE_ACK_RET GENMASK(7, 0)
+#define RTW89_C2HREG_PS_LEAVE_ACK_MACID GENMASK(31, 16)
+
 struct rtw89_h2creg_hdr {
 	u32 w0;
 };
@@ -154,6 +157,7 @@ enum rtw89_mac_c2h_type {
 	RTW89_FWCMD_C2HREG_FUNC_TX_PAUSE_RPT,
 	RTW89_FWCMD_C2HREG_FUNC_WOW_CPUIO_RX_ACK = 0xA,
 	RTW89_FWCMD_C2HREG_FUNC_PHY_CAP_PART1 = 0xC,
+	RTW89_FWCMD_C2HREG_FUNC_PS_LEAVE_ACK = 0xD,
 	RTW89_FWCMD_C2HREG_FUNC_NULL = 0xFF,
 };
 
diff --git a/drivers/net/wireless/realtek/rtw89/ps.c b/drivers/net/wireless/realtek/rtw89/ps.c
index 3411d642c84a..652f8fc81b79 100644
--- a/drivers/net/wireless/realtek/rtw89/ps.c
+++ b/drivers/net/wireless/realtek/rtw89/ps.c
@@ -13,6 +13,31 @@
 #include "reg.h"
 #include "util.h"
 
+static int rtw89_fw_receive_lps_h2c_check(struct rtw89_dev *rtwdev, u8 macid)
+{
+	struct rtw89_mac_c2h_info c2h_info = {};
+	u16 c2hreg_macid;
+	u32 c2hreg_ret;
+	int ret;
+
+	if (!RTW89_CHK_FW_FEATURE(LPS_DACK_BY_C2H_REG, &rtwdev->fw))
+		return 0;
+
+	c2h_info.id = RTW89_FWCMD_C2HREG_FUNC_PS_LEAVE_ACK;
+	ret = rtw89_fw_msg_reg(rtwdev, NULL, &c2h_info);
+	if (ret)
+		return ret;
+
+	c2hreg_macid = u32_get_bits(c2h_info.u.c2hreg[0],
+				    RTW89_C2HREG_PS_LEAVE_ACK_MACID);
+	c2hreg_ret = u32_get_bits(c2h_info.u.c2hreg[1], RTW89_C2HREG_PS_LEAVE_ACK_RET);
+
+	if (macid != c2hreg_macid || c2hreg_ret)
+		rtw89_warn(rtwdev, "rtw89: check lps h2c received by firmware fail\n");
+
+	return 0;
+}
+
 static int rtw89_fw_leave_lps_check(struct rtw89_dev *rtwdev, u8 macid)
 {
 	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
@@ -106,7 +131,8 @@ static void __rtw89_leave_lps(struct rtw89_dev *rtwdev,
 	};
 
 	rtw89_fw_h2c_lps_parm(rtwdev, &lps_param);
-	rtw89_fw_leave_lps_check(rtwdev, 0);
+	rtw89_fw_receive_lps_h2c_check(rtwdev, rtwvif_link->mac_id);
+	rtw89_fw_leave_lps_check(rtwdev, rtwvif_link->mac_id);
 	rtw89_btc_ntfy_radio_state(rtwdev, BTC_RFCTRL_WL_ON);
 	rtw89_chip_digital_pwr_comp(rtwdev, rtwvif_link->phy_idx);
 }
-- 
2.25.1


