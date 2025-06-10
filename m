Return-Path: <linux-wireless+bounces-23929-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D2AAAD3882
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Jun 2025 15:14:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 500BD1A02C9
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Jun 2025 13:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2AEF2DFA4C;
	Tue, 10 Jun 2025 13:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="gI4A4JA5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382A229A33F
	for <linux-wireless@vger.kernel.org>; Tue, 10 Jun 2025 13:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749560469; cv=none; b=ibh7SOoY4L3v08prGAFFf/rTjKq9oywped74+E/nqgcjk05Ena6WHveGNFT2BRjcfPnHs2UD3uA4JlpQhAj7Qt1vAhz5C3T5GTDOb7woMWMiseOKwD8JCg1BAjYaO0666JZkmBFiPE5bNE/1w5V0kg/qUvhZjMuoIEBRkj899qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749560469; c=relaxed/simple;
	bh=A9bpYS/olLxz3lidaq+o01WrVdzeccVcnTttCtz8Hhc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tcoYBvzIJyJltAe6TFb69tH4ycOFQSI1EztCgq+t38QzNRsJUb29gRp2LVqhyhOqjNbQibprbmOVW+aVQ07EKoTbrV/ucAECfHye5D0vXO2KOfD9iJmI3uHX/BUOHxLLvSBEEu8c2i2sLT7PnHKNEVK25bcK8Vfmn+8LKrFxnvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=gI4A4JA5; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 55AD142B02995441, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1749560464; bh=/oQetvWDs7ulJU6YPeKeEia7lS6NKJKInj93iM+I3cU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=gI4A4JA5wSN/8eupsuFaJxVHxrqStstfz9i1bxbwooMwZropk6aiWuhasWLuZvFWW
	 EG+B1rpCPN5SEgExxfRmdGQZzc2kbBR2hfoQC4xlpNs1uetBuHIyssX7147zMOJ/lM
	 VT85N7j2TWEsID/9f1nDgxI4DhG8AwHI5M8tlif+HN95tLwGv8RF3MVrXWfNCblw0M
	 6qnvMtleRzl6218Vv+XazyrAw7HBM64SPMYXAfJfrH673aYrATZKIgU7+MQTGuU7WW
	 Poe6ToP2Fffzpbu6572burt+h3e0iM8EZiHvd5T25+tRx1e5tHmtrx4mFqiXBsbp8N
	 U1q4qe5rBwVXw==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 55AD142B02995441
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 10 Jun 2025 21:01:04 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 10 Jun 2025 21:01:05 +0800
Received: from [127.0.1.1] (10.22.225.18) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 10 Jun
 2025 21:01:04 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 02/12] wifi: rtw89: mcc: update format of RF notify MCC H2C command
Date: Tue, 10 Jun 2025 21:00:24 +0800
Message-ID: <20250610130034.14692-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250610130034.14692-1-pkshih@realtek.com>
References: <20250610130034.14692-1-pkshih@realtek.com>
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

The RF notify MCC H2C command format of 8852C different from other
chip, therefore add v0 format to update it.

Signed-off-by: Chih-Kang Chang <gary.chang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h |  1 +
 drivers/net/wireless/realtek/rtw89/fw.c   | 38 +++++++++++++++++------
 drivers/net/wireless/realtek/rtw89/fw.h   |  8 +++++
 3 files changed, 37 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index dca76b1c1029..8c2a71ecfc0d 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -4525,6 +4525,7 @@ enum rtw89_fw_feature {
 	RTW89_FW_FEATURE_NO_POWER_DIFFERENCE,
 	RTW89_FW_FEATURE_BEACON_LOSS_COUNT_V1,
 	RTW89_FW_FEATURE_SCAN_OFFLOAD_EXTRA_OP,
+	RTW89_FW_FEATURE_RFK_NTFY_MCC_V0,
 };
 
 struct rtw89_fw_suit {
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 06fb97a05a89..cde22f692dc2 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -833,6 +833,7 @@ static const struct __fw_feat_cfg fw_feat_tbl[] = {
 	__CFG_FW_FEAT(RTL8852BT, ge, 0, 29, 91, 0, SCAN_OFFLOAD),
 	__CFG_FW_FEAT(RTL8852BT, ge, 0, 29, 110, 0, BEACON_FILTER),
 	__CFG_FW_FEAT(RTL8852C, le, 0, 27, 33, 0, NO_DEEP_PS),
+	__CFG_FW_FEAT(RTL8852C, ge, 0, 0, 0, 0, RFK_NTFY_MCC_V0),
 	__CFG_FW_FEAT(RTL8852C, ge, 0, 27, 34, 0, TX_WAKE),
 	__CFG_FW_FEAT(RTL8852C, ge, 0, 27, 36, 0, SCAN_OFFLOAD),
 	__CFG_FW_FEAT(RTL8852C, ge, 0, 27, 40, 0, CRASH_TRIGGER),
@@ -5889,31 +5890,48 @@ int rtw89_fw_h2c_rf_reg(struct rtw89_dev *rtwdev,
 int rtw89_fw_h2c_rf_ntfy_mcc(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_rfk_mcc_info_data *rfk_mcc = rtwdev->rfk_mcc.data;
+	struct rtw89_fw_h2c_rf_get_mccch_v0 *mccch_v0;
 	struct rtw89_fw_h2c_rf_get_mccch *mccch;
+	u32 len = sizeof(*mccch);
 	struct sk_buff *skb;
+	u8 ver = U8_MAX;
 	int ret;
 	u8 idx;
 
-	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, sizeof(*mccch));
+	if (RTW89_CHK_FW_FEATURE(RFK_NTFY_MCC_V0, &rtwdev->fw)) {
+		len = sizeof(*mccch_v0);
+		ver = 0;
+	}
+
+	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, len);
 	if (!skb) {
 		rtw89_err(rtwdev, "failed to alloc skb for h2c cxdrv_ctrl\n");
 		return -ENOMEM;
 	}
-	skb_put(skb, sizeof(*mccch));
-	mccch = (struct rtw89_fw_h2c_rf_get_mccch *)skb->data;
+	skb_put(skb, len);
 
 	idx = rfk_mcc->table_idx;
-	mccch->ch_0 = cpu_to_le32(rfk_mcc->ch[0]);
-	mccch->ch_1 = cpu_to_le32(rfk_mcc->ch[1]);
-	mccch->band_0 = cpu_to_le32(rfk_mcc->band[0]);
-	mccch->band_1 = cpu_to_le32(rfk_mcc->band[1]);
-	mccch->current_channel = cpu_to_le32(rfk_mcc->ch[idx]);
-	mccch->current_band_type = cpu_to_le32(rfk_mcc->band[idx]);
+	if (ver == 0) {
+		mccch_v0 = (struct rtw89_fw_h2c_rf_get_mccch_v0 *)skb->data;
+		mccch_v0->ch_0 = cpu_to_le32(rfk_mcc->ch[0]);
+		mccch_v0->ch_1 = cpu_to_le32(rfk_mcc->ch[1]);
+		mccch_v0->band_0 = cpu_to_le32(rfk_mcc->band[0]);
+		mccch_v0->band_1 = cpu_to_le32(rfk_mcc->band[1]);
+		mccch_v0->current_band_type = cpu_to_le32(rfk_mcc->band[idx]);
+		mccch_v0->current_channel = cpu_to_le32(rfk_mcc->ch[idx]);
+	} else {
+		mccch = (struct rtw89_fw_h2c_rf_get_mccch *)skb->data;
+		mccch->ch_0_0 = cpu_to_le32(rfk_mcc->ch[0]);
+		mccch->ch_0_1 = cpu_to_le32(rfk_mcc->ch[0]);
+		mccch->ch_1_0 = cpu_to_le32(rfk_mcc->ch[1]);
+		mccch->ch_1_1 = cpu_to_le32(rfk_mcc->ch[1]);
+		mccch->current_channel = cpu_to_le32(rfk_mcc->ch[idx]);
+	}
 
 	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
 			      H2C_CAT_OUTSRC, H2C_CL_OUTSRC_RF_FW_NOTIFY,
 			      H2C_FUNC_OUTSRC_RF_GET_MCCCH, 0, 0,
-			      sizeof(*mccch));
+			      len);
 
 	ret = rtw89_h2c_tx(rtwdev, skb, false);
 	if (ret) {
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index 36abf1b59240..f9d5bcbc7c7e 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -4356,6 +4356,14 @@ enum rtw89_rfk_offload_h2c_func {
 };
 
 struct rtw89_fw_h2c_rf_get_mccch {
+	__le32 ch_0_0;
+	__le32 ch_0_1;
+	__le32 ch_1_0;
+	__le32 ch_1_1;
+	__le32 current_channel;
+} __packed;
+
+struct rtw89_fw_h2c_rf_get_mccch_v0 {
 	__le32 ch_0;
 	__le32 ch_1;
 	__le32 band_0;
-- 
2.25.1


