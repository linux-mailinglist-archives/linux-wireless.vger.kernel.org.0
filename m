Return-Path: <linux-wireless+bounces-30555-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D63DD0459A
	for <lists+linux-wireless@lfdr.de>; Thu, 08 Jan 2026 17:26:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AEF5F33D043F
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Jan 2026 15:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E19664984AD;
	Thu,  8 Jan 2026 12:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="ces9nwVR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3D049848B
	for <linux-wireless@vger.kernel.org>; Thu,  8 Jan 2026 12:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767873863; cv=none; b=Q80cZt0/xQ5vCM1Q4brnKi3a6Cx8cYRMqhksbffBnw9spD8t6tERHv5WV49F+aHr+521yDp3a4qZ0N3zoUEjPRnOsVKY36YSHT0lyb06R2lcfhHPIFGPtzZLXeI5wK89+Zw8DuEKXAEOn+XoYPXk5Mc4VeCqDVPRP5pf7tBnb5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767873863; c=relaxed/simple;
	bh=dqnn06Lo7FNYnp6mokp3M8NbNrxmHMQ4lTaYE+00S4k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fFcdGqWpQRj+B/bYwcnmPJlfVpfY/G6C8WkAEBFNrSHd/NYIWhrpsHPKvcfsiW2BG7I8WVVaZPrDpT7eJb4Kd4b4R+k6PH8ukN4Vf5GHej7yx36+1KXelOd1KIzqSJApCBEdMkSUMmloh4WHHbZ/0quM+e2ErKkdy54zyYkWluQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=ces9nwVR; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 608C4HjY4970709, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1767873857; bh=+DxTQmeI0owf7C1V/aqPdK5GgxtjCXZVtml4buLtN6M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=ces9nwVRN4Sx3quwHfcgQLfUs/iM2VJTbgiiRzllCmFNwXJLmXyWj34Mca+AlyMdt
	 qqB4KnBpYta7lIdxNAOPXvakg9buaUl1PpR3zZrGio1/JpnOkHTqLLhHGzARBagPv1
	 Fe8v2AGkKQNdmdprlKNLu8b6tp61vIHG3Qb50MnxHcKNC3zpYzCAmABz7k6XpTFAOU
	 a+hsUnLN0YDCIrPZlWkmteM/DHmFd+12yXAQa6+hK2FKRdpf3L3KB4HpV9q7BPRsHE
	 AKhISPdqsTuaQHKVeB3CP/wJMS1w4LsK9Jm/YKNfk0UFiE3+Roi8jF8XjhjZDETafk
	 bpwBCapsamHjw==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 608C4HjY4970709
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 8 Jan 2026 20:04:17 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 8 Jan 2026 20:04:18 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 8 Jan 2026 20:04:17 +0800
Received: from [127.0.1.1] (172.21.40.76) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Thu, 8 Jan 2026 20:04:17 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <leo.li@realtek.com>
Subject: [PATCH rtw-next 11/13] wifi: rtw89: mac: separate functions of CMAC power and function enable
Date: Thu, 8 Jan 2026 20:03:18 +0800
Message-ID: <20260108120320.2217402-12-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260108120320.2217402-1-pkshih@realtek.com>
References: <20260108120320.2217402-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

To enable/disable CMAC function somewhere, separate controls of CMAC power
and function into individual functions. Also correct the hardware settings
by the way.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h   |  2 +
 drivers/net/wireless/realtek/rtw89/mac.c    |  2 +
 drivers/net/wireless/realtek/rtw89/mac_be.c | 97 ++++++++++++++++++---
 drivers/net/wireless/realtek/rtw89/reg.h    | 15 ++--
 4 files changed, 100 insertions(+), 16 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index f8d36343d68e..d8eb875e92ca 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -5138,6 +5138,8 @@ enum rtw89_flags {
 	RTW89_FLAG_DMAC_FUNC,
 	RTW89_FLAG_CMAC0_FUNC,
 	RTW89_FLAG_CMAC1_FUNC,
+	RTW89_FLAG_CMAC0_PWR,
+	RTW89_FLAG_CMAC1_PWR,
 	RTW89_FLAG_FW_RDY,
 	RTW89_FLAG_RUNNING,
 	RTW89_FLAG_PROBE_DONE,
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 5bf81ef0313b..f142d3f80e95 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -1559,6 +1559,8 @@ static int rtw89_mac_power_switch(struct rtw89_dev *rtwdev, bool on)
 		clear_bit(RTW89_FLAG_DMAC_FUNC, rtwdev->flags);
 		clear_bit(RTW89_FLAG_CMAC0_FUNC, rtwdev->flags);
 		clear_bit(RTW89_FLAG_CMAC1_FUNC, rtwdev->flags);
+		clear_bit(RTW89_FLAG_CMAC0_PWR, rtwdev->flags);
+		clear_bit(RTW89_FLAG_CMAC1_PWR, rtwdev->flags);
 		clear_bit(RTW89_FLAG_FW_RDY, rtwdev->flags);
 
 		rtw89_mac_update_scoreboard(rtwdev, MAC_AX_NOTIFY_PWR_MAJOR);
diff --git a/drivers/net/wireless/realtek/rtw89/mac_be.c b/drivers/net/wireless/realtek/rtw89/mac_be.c
index a0e5c99abb17..ef4de64d8661 100644
--- a/drivers/net/wireless/realtek/rtw89/mac_be.c
+++ b/drivers/net/wireless/realtek/rtw89/mac_be.c
@@ -754,28 +754,91 @@ static int dmac_func_en_be(struct rtw89_dev *rtwdev)
 	return 0;
 }
 
+static int cmac_pwr_en_be(struct rtw89_dev *rtwdev, u8 mac_idx, bool en)
+{
+	if (mac_idx > RTW89_MAC_1)
+		return -EINVAL;
+
+	if (mac_idx == RTW89_MAC_0) {
+		if (en == test_bit(RTW89_FLAG_CMAC0_PWR, rtwdev->flags))
+			return 0;
+
+		if (en) {
+			rtw89_write32_set(rtwdev, R_BE_AFE_CTRL1,
+					  B_BE_R_SYM_WLCMAC0_ALL_EN);
+			rtw89_write32_clr(rtwdev, R_BE_FEN_RST_ENABLE,
+					  B_BE_R_SYM_ISO_CMAC02PP);
+			rtw89_write32_set(rtwdev, R_BE_FEN_RST_ENABLE,
+					  B_BE_CMAC0_FEN);
+
+			set_bit(RTW89_FLAG_CMAC0_PWR, rtwdev->flags);
+		} else {
+			rtw89_write32_clr(rtwdev, R_BE_FEN_RST_ENABLE,
+					  B_BE_CMAC0_FEN);
+			rtw89_write32_set(rtwdev, R_BE_FEN_RST_ENABLE,
+					  B_BE_R_SYM_ISO_CMAC02PP);
+			rtw89_write32_clr(rtwdev, R_BE_AFE_CTRL1,
+					  B_BE_R_SYM_WLCMAC0_ALL_EN);
+
+			clear_bit(RTW89_FLAG_CMAC0_PWR, rtwdev->flags);
+		}
+	} else {
+		if (en == test_bit(RTW89_FLAG_CMAC1_PWR, rtwdev->flags))
+			return 0;
+
+		if (en) {
+			rtw89_write32_set(rtwdev, R_BE_AFE_CTRL1,
+					  B_BE_R_SYM_WLCMAC1_ALL_EN);
+			rtw89_write32_clr(rtwdev, R_BE_FEN_RST_ENABLE,
+					  B_BE_R_SYM_ISO_CMAC12PP);
+			rtw89_write32_set(rtwdev, R_BE_FEN_RST_ENABLE,
+					  B_BE_CMAC1_FEN);
+
+			set_bit(RTW89_FLAG_CMAC1_PWR, rtwdev->flags);
+		} else {
+			rtw89_write32_clr(rtwdev, R_BE_FEN_RST_ENABLE,
+					  B_BE_CMAC1_FEN);
+			rtw89_write32_set(rtwdev, R_BE_FEN_RST_ENABLE,
+					  B_BE_R_SYM_ISO_CMAC12PP);
+			rtw89_write32_clr(rtwdev, R_BE_AFE_CTRL1,
+					  B_BE_R_SYM_WLCMAC1_ALL_EN);
+
+			clear_bit(RTW89_FLAG_CMAC1_PWR, rtwdev->flags);
+		}
+	}
+
+	return 0;
+}
+
 static int cmac_func_en_be(struct rtw89_dev *rtwdev, u8 mac_idx, bool en)
 {
+	enum rtw89_flags pwr_flag, func_flag;
 	u32 reg;
 
 	if (mac_idx > RTW89_MAC_1)
 		return -EINVAL;
 
-	if (mac_idx == RTW89_MAC_0)
+	if (mac_idx == RTW89_MAC_0) {
+		pwr_flag = RTW89_FLAG_CMAC0_PWR;
+		func_flag = RTW89_FLAG_CMAC0_FUNC;
+	} else {
+		pwr_flag = RTW89_FLAG_CMAC1_PWR;
+		func_flag = RTW89_FLAG_CMAC1_FUNC;
+	}
+
+	if (!test_bit(pwr_flag, rtwdev->flags)) {
+		rtw89_warn(rtwdev, "CMAC %u power cut did not release\n", mac_idx);
 		return 0;
+	}
 
 	if (en) {
-		rtw89_write32_set(rtwdev, R_BE_AFE_CTRL1, B_BE_AFE_CTRL1_SET);
-		rtw89_write32_clr(rtwdev, R_BE_SYS_ISO_CTRL_EXTEND, B_BE_R_SYM_ISO_CMAC12PP);
-		rtw89_write32_set(rtwdev, R_BE_FEN_RST_ENABLE, B_BE_CMAC1_FEN);
-
 		reg = rtw89_mac_reg_by_idx(rtwdev, R_BE_CK_EN, mac_idx);
 		rtw89_write32_set(rtwdev, reg, B_BE_CK_EN_SET);
 
 		reg = rtw89_mac_reg_by_idx(rtwdev, R_BE_CMAC_FUNC_EN, mac_idx);
 		rtw89_write32_set(rtwdev, reg, B_BE_CMAC_FUNC_EN_SET);
 
-		set_bit(RTW89_FLAG_CMAC1_FUNC, rtwdev->flags);
+		set_bit(func_flag, rtwdev->flags);
 	} else {
 		reg = rtw89_mac_reg_by_idx(rtwdev, R_BE_CMAC_FUNC_EN, mac_idx);
 		rtw89_write32_clr(rtwdev, reg, B_BE_CMAC_FUNC_EN_SET);
@@ -783,11 +846,7 @@ static int cmac_func_en_be(struct rtw89_dev *rtwdev, u8 mac_idx, bool en)
 		reg = rtw89_mac_reg_by_idx(rtwdev, R_BE_CK_EN, mac_idx);
 		rtw89_write32_clr(rtwdev, reg, B_BE_CK_EN_SET);
 
-		rtw89_write32_clr(rtwdev, R_BE_FEN_RST_ENABLE, B_BE_CMAC1_FEN);
-		rtw89_write32_set(rtwdev, R_BE_SYS_ISO_CTRL_EXTEND, B_BE_R_SYM_ISO_CMAC12PP);
-		rtw89_write32_clr(rtwdev, R_BE_AFE_CTRL1, B_BE_AFE_CTRL1_SET);
-
-		clear_bit(RTW89_FLAG_CMAC1_FUNC, rtwdev->flags);
+		clear_bit(func_flag, rtwdev->flags);
 	}
 
 	return 0;
@@ -806,6 +865,10 @@ static int sys_init_be(struct rtw89_dev *rtwdev)
 	if (ret)
 		return ret;
 
+	ret = cmac_pwr_en_be(rtwdev, RTW89_MAC_0, true);
+	if (ret)
+		return ret;
+
 	ret = cmac_func_en_be(rtwdev, RTW89_MAC_0, true);
 	if (ret)
 		return ret;
@@ -1814,6 +1877,12 @@ static int band1_enable_be(struct rtw89_dev *rtwdev)
 		return ret;
 	}
 
+	ret = cmac_pwr_en_be(rtwdev, RTW89_MAC_1, true);
+	if (ret) {
+		rtw89_err(rtwdev, "[ERR]CMAC%d pwr en %d\n", RTW89_MAC_1, ret);
+		return ret;
+	}
+
 	ret = cmac_func_en_be(rtwdev, RTW89_MAC_1, true);
 	if (ret) {
 		rtw89_err(rtwdev, "[ERR]CMAC%d func en %d\n", RTW89_MAC_1, ret);
@@ -1857,6 +1926,12 @@ static int band1_disable_be(struct rtw89_dev *rtwdev)
 		return ret;
 	}
 
+	ret = cmac_pwr_en_be(rtwdev, RTW89_MAC_1, false);
+	if (ret) {
+		rtw89_err(rtwdev, "[ERR]CMAC%d pwr dis %d\n", RTW89_MAC_1, ret);
+		return ret;
+	}
+
 	ret = rtw89_mac_dle_quota_change(rtwdev, rtwdev->mac.qta_mode, false);
 	if (ret) {
 		rtw89_err(rtwdev, "[ERR]DLE quota change %d\n", ret);
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index bfb1ebcc9fc2..8233841bb8ff 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -3943,6 +3943,11 @@
 #define B_BE_R_SYM_WLCMAC0_P2_PC_EN BIT(26)
 #define B_BE_R_SYM_WLCMAC0_P1_PC_EN BIT(25)
 #define B_BE_R_SYM_WLCMAC0_PC_EN BIT(24)
+#define B_BE_R_SYM_WLCMAC0_ALL_EN (B_BE_R_SYM_WLCMAC0_PC_EN | \
+				   B_BE_R_SYM_WLCMAC0_P1_PC_EN | \
+				   B_BE_R_SYM_WLCMAC0_P2_PC_EN | \
+				   B_BE_R_SYM_WLCMAC0_P3_PC_EN | \
+				   B_BE_R_SYM_WLCMAC0_P4_PC_EN)
 #define B_BE_DATAMEM_PC3_EN BIT(23)
 #define B_BE_DATAMEM_PC2_EN BIT(22)
 #define B_BE_DATAMEM_PC1_EN BIT(21)
@@ -3964,11 +3969,11 @@
 #define B_BE_R_SYM_WLCMAC1_P2_PC_EN BIT(2)
 #define B_BE_R_SYM_WLCMAC1_P1_PC_EN BIT(1)
 #define B_BE_R_SYM_WLCMAC1_PC_EN BIT(0)
-#define B_BE_AFE_CTRL1_SET (B_BE_R_SYM_WLCMAC1_PC_EN | \
-			    B_BE_R_SYM_WLCMAC1_P1_PC_EN | \
-			    B_BE_R_SYM_WLCMAC1_P2_PC_EN | \
-			    B_BE_R_SYM_WLCMAC1_P3_PC_EN | \
-			    B_BE_R_SYM_WLCMAC1_P4_PC_EN)
+#define B_BE_R_SYM_WLCMAC1_ALL_EN (B_BE_R_SYM_WLCMAC1_PC_EN | \
+				   B_BE_R_SYM_WLCMAC1_P1_PC_EN | \
+				   B_BE_R_SYM_WLCMAC1_P2_PC_EN | \
+				   B_BE_R_SYM_WLCMAC1_P3_PC_EN | \
+				   B_BE_R_SYM_WLCMAC1_P4_PC_EN)
 
 #define R_BE_EFUSE_CTRL 0x0030
 #define B_BE_EF_MODE_SEL_MASK GENMASK(31, 30)
-- 
2.25.1


