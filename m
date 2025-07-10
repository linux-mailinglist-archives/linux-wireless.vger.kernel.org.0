Return-Path: <linux-wireless+bounces-25158-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF97AFF808
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 06:25:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBA8C3B3F0A
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 04:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B13A624728C;
	Thu, 10 Jul 2025 04:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="DID5L+Fm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE59F28002B
	for <linux-wireless@vger.kernel.org>; Thu, 10 Jul 2025 04:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752121536; cv=none; b=qMcpEy0LLLDBlvh5FJMhhz32vjIkswYYc+e1cmSeD+lVOR1qJmcejdVUPgx55N1bmpGk/Hf3ccnJO7oLMycZxQtZ9/o9RJl+xp/N9/pIyV6HdDIviZe2LpxGtTbg5gPwIStMmOan9YX9kYBV/3jqEtpTAV2bhgI3s43wZELSFGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752121536; c=relaxed/simple;
	bh=Jwkufq+++JvCDftsmb1u65Hsh20zppWE/FpAXrnWa8A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UGZExtGqYT3C7uSyWe6ein3PPT11XYyVbsWQof3lvNntAwFjVKAIflJVzK/tRS8IOKBMRxk4eUBYx49bs5UX+FIYBUFg2j05IUfkuSfMKVp/itnXZbHDfyM3tSzuazdRqfTz0LLj3HyqM5nvtH+r3ryV5jVEuQks/asFR5rrcco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=DID5L+Fm; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 56A4PXzB42455840, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1752121533; bh=BPY5xpHEOSdSOb2uLCOAxcE+Gj0yUslSamA4nAdI2RY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=DID5L+FmC7MFcDbvlIw7Di3afHr95uUxqxlat3OEX5zUYDcBKD92ejUjcwp6AZhDD
	 9uNhl7QhCTs8wA6IEhsUSOVs4pLN/4qZS/c8OmRMYrsIGSC8IHsNKD4l5uffnW5Jvx
	 K3LA/ygz0x8mYHX0tNSXJBU0vRhttPxpDaHCfltuu+IQjMrTfBwC7UiDrzlqgq46Op
	 3tHVqWyQLoS7lI4PjRXp23rKfRuU8lqcOtJf8qAeXEnQqdxLhaOtp+dFin5ysAyDYj
	 dReY/FjL7XguwAsZ/5STJ+WQrUbl8kJVbjyfQ+H8WOCBsJkMcmSOdacI6NQLzdk48Z
	 yVIzB6t5k7oIA==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 56A4PXzB42455840
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 10 Jul 2025 12:25:33 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 10 Jul 2025 12:25:32 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 10 Jul
 2025 12:25:31 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 09/14] wifi: rtw89: update SER L2 type default value
Date: Thu, 10 Jul 2025 12:24:18 +0800
Message-ID: <20250710042423.73617-10-pkshih@realtek.com>
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

8852BT after FW 0.29.127, 8852B after FW 0.29.128 and 8922A after FW
0.35.79, the SER L2 flow determines different L2 types by parameter,
the zero value will trigger FW SER L2 assert.

Signed-off-by: Chih-Kang Chang <gary.chang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h |  1 +
 drivers/net/wireless/realtek/rtw89/fw.c   | 36 +++++++++++++++--------
 drivers/net/wireless/realtek/rtw89/fw.h   |  9 +++---
 3 files changed, 30 insertions(+), 16 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 0d02036d3cc4..e764ad849111 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -4596,6 +4596,7 @@ enum rtw89_fw_feature {
 	RTW89_FW_FEATURE_TX_WAKE,
 	RTW89_FW_FEATURE_GROUP(CRASH_TRIGGER,
 			       RTW89_FW_FEATURE_CRASH_TRIGGER_TYPE_0,
+			       RTW89_FW_FEATURE_CRASH_TRIGGER_TYPE_1,
 	),
 	RTW89_FW_FEATURE_NO_PACKET_DROP,
 	RTW89_FW_FEATURE_NO_DEEP_PS,
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index fca79212e34f..6b94445577fd 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -828,12 +828,14 @@ static const struct __fw_feat_cfg fw_feat_tbl[] = {
 	__CFG_FW_FEAT(RTL8852B, ge, 0, 29, 29, 7, BEACON_FILTER),
 	__CFG_FW_FEAT(RTL8852B, lt, 0, 29, 30, 0, NO_WOW_CPU_IO_RX),
 	__CFG_FW_FEAT(RTL8852B, ge, 0, 29, 127, 0, LPS_DACK_BY_C2H_REG),
+	__CFG_FW_FEAT(RTL8852B, ge, 0, 29, 128, 0, CRASH_TRIGGER_TYPE_1),
 	__CFG_FW_FEAT(RTL8852BT, ge, 0, 29, 74, 0, NO_LPS_PG),
 	__CFG_FW_FEAT(RTL8852BT, ge, 0, 29, 74, 0, TX_WAKE),
 	__CFG_FW_FEAT(RTL8852BT, ge, 0, 29, 90, 0, CRASH_TRIGGER_TYPE_0),
 	__CFG_FW_FEAT(RTL8852BT, ge, 0, 29, 91, 0, SCAN_OFFLOAD),
 	__CFG_FW_FEAT(RTL8852BT, ge, 0, 29, 110, 0, BEACON_FILTER),
 	__CFG_FW_FEAT(RTL8852BT, ge, 0, 29, 127, 0, LPS_DACK_BY_C2H_REG),
+	__CFG_FW_FEAT(RTL8852BT, ge, 0, 29, 127, 0, CRASH_TRIGGER_TYPE_1),
 	__CFG_FW_FEAT(RTL8852C, le, 0, 27, 33, 0, NO_DEEP_PS),
 	__CFG_FW_FEAT(RTL8852C, ge, 0, 0, 0, 0, RFK_NTFY_MCC_V0),
 	__CFG_FW_FEAT(RTL8852C, ge, 0, 27, 34, 0, TX_WAKE),
@@ -859,6 +861,7 @@ static const struct __fw_feat_cfg fw_feat_tbl[] = {
 	__CFG_FW_FEAT(RTL8922A, lt, 0, 35, 64, 0, NO_POWER_DIFFERENCE),
 	__CFG_FW_FEAT(RTL8922A, ge, 0, 35, 71, 0, BEACON_LOSS_COUNT_V1),
 	__CFG_FW_FEAT(RTL8922A, ge, 0, 35, 76, 0, LPS_DACK_BY_C2H_REG),
+	__CFG_FW_FEAT(RTL8922A, ge, 0, 35, 79, 0, CRASH_TRIGGER_TYPE_1),
 };
 
 static void rtw89_fw_iterate_feature_cfg(struct rtw89_fw_info *fw,
@@ -8009,41 +8012,50 @@ int rtw89_hw_scan_offload(struct rtw89_dev *rtwdev,
 	return ret;
 }
 
-#define H2C_FW_CPU_EXCEPTION_LEN 4
-#define H2C_FW_CPU_EXCEPTION_TYPE_DEF 0x5566
+#define H2C_FW_CPU_EXCEPTION_TYPE_0 0x5566
+#define H2C_FW_CPU_EXCEPTION_TYPE_1 0x0
 int rtw89_fw_h2c_trigger_cpu_exception(struct rtw89_dev *rtwdev)
 {
+	struct rtw89_h2c_trig_cpu_except *h2c;
+	u32 cpu_exception_type_def;
+	u32 len = sizeof(*h2c);
 	struct sk_buff *skb;
 	int ret;
 
-	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, H2C_FW_CPU_EXCEPTION_LEN);
+	if (RTW89_CHK_FW_FEATURE(CRASH_TRIGGER_TYPE_1, &rtwdev->fw))
+		cpu_exception_type_def = H2C_FW_CPU_EXCEPTION_TYPE_1;
+	else if (RTW89_CHK_FW_FEATURE(CRASH_TRIGGER_TYPE_0, &rtwdev->fw))
+		cpu_exception_type_def = H2C_FW_CPU_EXCEPTION_TYPE_0;
+	else
+		return -EOPNOTSUPP;
+
+	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, len);
 	if (!skb) {
 		rtw89_err(rtwdev,
 			  "failed to alloc skb for fw cpu exception\n");
 		return -ENOMEM;
 	}
 
-	skb_put(skb, H2C_FW_CPU_EXCEPTION_LEN);
-	RTW89_SET_FWCMD_CPU_EXCEPTION_TYPE(skb->data,
-					   H2C_FW_CPU_EXCEPTION_TYPE_DEF);
+	skb_put(skb, len);
+	h2c = (struct rtw89_h2c_trig_cpu_except *)skb->data;
+
+	h2c->w0 = le32_encode_bits(cpu_exception_type_def,
+				   RTW89_H2C_CPU_EXCEPTION_TYPE);
 
 	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
 			      H2C_CAT_TEST,
 			      H2C_CL_FW_STATUS_TEST,
 			      H2C_FUNC_CPU_EXCEPTION, 0, 0,
-			      H2C_FW_CPU_EXCEPTION_LEN);
+			      len);
 
 	ret = rtw89_h2c_tx(rtwdev, skb, false);
 	if (ret) {
 		rtw89_err(rtwdev, "failed to send h2c\n");
-		goto fail;
+		dev_kfree_skb_any(skb);
+		return ret;
 	}
 
 	return 0;
-
-fail:
-	dev_kfree_skb_any(skb);
-	return ret;
 }
 
 #define H2C_PKT_DROP_LEN 24
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index 629e54adcb83..98be7e72c685 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -1833,10 +1833,11 @@ struct rtw89_h2c_lps_ml_cmn_info {
 	u8 dup_bcn_ofst[RTW89_PHY_NUM];
 } __packed;
 
-static inline void RTW89_SET_FWCMD_CPU_EXCEPTION_TYPE(void *cmd, u32 val)
-{
-	le32p_replace_bits((__le32 *)cmd, val, GENMASK(31, 0));
-}
+struct rtw89_h2c_trig_cpu_except {
+	__le32 w0;
+} __packed;
+
+#define RTW89_H2C_CPU_EXCEPTION_TYPE GENMASK(31, 0)
 
 static inline void RTW89_SET_FWCMD_PKT_DROP_SEL(void *cmd, u32 val)
 {
-- 
2.25.1


