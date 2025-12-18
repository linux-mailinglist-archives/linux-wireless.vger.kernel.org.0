Return-Path: <linux-wireless+bounces-29887-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 99CC8CCA80F
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Dec 2025 07:40:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E04753016D8F
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Dec 2025 06:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B3513242C2;
	Thu, 18 Dec 2025 06:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="o7occ/YF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03CE326D77
	for <linux-wireless@vger.kernel.org>; Thu, 18 Dec 2025 06:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766039536; cv=none; b=HIyRFuhlG7M4d4P0pGer0RKAZCAbWH17Wq8XPiyxY7JRNuF5oyShTHqD/Y6scqvcMyspgRm6j12ADKpkU2IrlhZVUYH7iYTTRtlPSh0jIrEPwXjgj7Ss6u8Cl1sY3kcZIRvTNHcs4p4PR1Q4Ip3m+36SDDMooFEDtkNmMLHfI6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766039536; c=relaxed/simple;
	bh=2maNEKh/VopgoegrtQ/ZK7odVt088ims/0FieQoN4Xk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F9QQC6jxkC225TlmPR5H0XARKW0nx4qEZ+reXGz2qmORrrrGi9bRv6iGtzKR1LWO2qXZ4HO060mdjvGZZQDSdzfL2j5TPf1YSqCJdPMTlxcCQv9B9QMUiYUufZYLDKzih8yUUm0qsrTP+IWDsMW02ndpvXcNr1raEr1awx427VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=o7occ/YF; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5BI6W9tL43329919, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1766039529; bh=BV1XuFenjPBxz6DGdBaXdBaLcaxqcRJHVK3YvHv78YU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=o7occ/YFrEcgdnsdVR2909Ae8XC/MvaK6cJaoKz3c7u1WfpW1NR++0RM/mnDSLtNN
	 ksdb2crd/R6tmaFqLOD1Azy4w3F1PyG6cQvRONpm7z6wIdfvYcuACT5sm7v126ylsz
	 qvt043QIzce71KeYCk94QUex5dK2QgQN4m2YuLZYXTfpQnjiaGDj+LuCQk8/ysRKsE
	 sa/SVJ+iNSdeCACUldnAmZKJknIFc8SimhGY0GY3WWqTXqoppm+eaugqEEe7SME4w4
	 zBiheWvxkoGaXnMR449H8dg5oXv8tsbfniD1kAEEesQANwhw3/K5NC52JFEka/3eBa
	 eWNlWmhotHsEg==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5BI6W9tL43329919
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 18 Dec 2025 14:32:09 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 18 Dec 2025 14:32:09 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS04.realtek.com.tw
 (10.21.1.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Thu, 18 Dec 2025 14:32:09 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <damon.chen@realtek.com>,
        <kevin_yang@realtek.com>
Subject: [PATCH rtw-next v2 06/12] wifi: rtw89: ser: L1 skip polling status if FW runs event mode
Date: Thu, 18 Dec 2025 14:31:11 +0800
Message-ID: <20251218063117.26278-7-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251218063117.26278-1-pkshih@realtek.com>
References: <20251218063117.26278-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Zong-Zhe Yang <kevin_yang@realtek.com>

Originally, polling FW status was required during recovering from L1.
Now, because newer FW support event mode, the polling can be skipped.
Add a FW feature flag and configure the supported chips.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h |  1 +
 drivers/net/wireless/realtek/rtw89/fw.c   |  4 ++++
 drivers/net/wireless/realtek/rtw89/mac.c  | 11 +++++++++--
 3 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 92636cfc5ca5..4c35b968ac36 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -4682,6 +4682,7 @@ enum rtw89_fw_feature {
 	RTW89_FW_FEATURE_LPS_DACK_BY_C2H_REG,
 	RTW89_FW_FEATURE_BEACON_TRACKING,
 	RTW89_FW_FEATURE_ADDR_CAM_V0,
+	RTW89_FW_FEATURE_SER_L1_BY_EVENT,
 };
 
 struct rtw89_fw_suit {
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 0f278476d55b..7150892a6274 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -826,6 +826,7 @@ static const struct __fw_feat_cfg fw_feat_tbl[] = {
 	__CFG_FW_FEAT(RTL8851B, ge, 0, 29, 37, 1, TX_WAKE),
 	__CFG_FW_FEAT(RTL8851B, ge, 0, 29, 37, 1, SCAN_OFFLOAD),
 	__CFG_FW_FEAT(RTL8851B, ge, 0, 29, 41, 0, CRASH_TRIGGER_TYPE_0),
+	__CFG_FW_FEAT(RTL8851B, ge, 0, 29, 127, 0, SER_L1_BY_EVENT),
 	__CFG_FW_FEAT(RTL8852A, le, 0, 13, 29, 0, OLD_HT_RA_FORMAT),
 	__CFG_FW_FEAT(RTL8852A, ge, 0, 13, 35, 0, SCAN_OFFLOAD),
 	__CFG_FW_FEAT(RTL8852A, ge, 0, 13, 35, 0, TX_WAKE),
@@ -840,6 +841,7 @@ static const struct __fw_feat_cfg fw_feat_tbl[] = {
 	__CFG_FW_FEAT(RTL8852B, ge, 0, 29, 29, 15, BEACON_LOSS_COUNT_V1),
 	__CFG_FW_FEAT(RTL8852B, lt, 0, 29, 30, 0, NO_WOW_CPU_IO_RX),
 	__CFG_FW_FEAT(RTL8852B, ge, 0, 29, 127, 0, LPS_DACK_BY_C2H_REG),
+	__CFG_FW_FEAT(RTL8852B, ge, 0, 29, 127, 0, SER_L1_BY_EVENT),
 	__CFG_FW_FEAT(RTL8852B, ge, 0, 29, 128, 0, CRASH_TRIGGER_TYPE_1),
 	__CFG_FW_FEAT(RTL8852B, ge, 0, 29, 128, 0, SCAN_OFFLOAD_EXTRA_OP),
 	__CFG_FW_FEAT(RTL8852B, ge, 0, 29, 128, 0, BEACON_TRACKING),
@@ -852,6 +854,7 @@ static const struct __fw_feat_cfg fw_feat_tbl[] = {
 	__CFG_FW_FEAT(RTL8852BT, ge, 0, 29, 127, 0, SCAN_OFFLOAD_EXTRA_OP),
 	__CFG_FW_FEAT(RTL8852BT, ge, 0, 29, 127, 0, LPS_DACK_BY_C2H_REG),
 	__CFG_FW_FEAT(RTL8852BT, ge, 0, 29, 127, 0, CRASH_TRIGGER_TYPE_1),
+	__CFG_FW_FEAT(RTL8852BT, ge, 0, 29, 127, 0, SER_L1_BY_EVENT),
 	__CFG_FW_FEAT(RTL8852C, le, 0, 27, 33, 0, NO_DEEP_PS),
 	__CFG_FW_FEAT(RTL8852C, ge, 0, 0, 0, 0, RFK_NTFY_MCC_V0),
 	__CFG_FW_FEAT(RTL8852C, ge, 0, 27, 34, 0, TX_WAKE),
@@ -863,6 +866,7 @@ static const struct __fw_feat_cfg fw_feat_tbl[] = {
 	__CFG_FW_FEAT(RTL8852C, ge, 0, 27, 128, 0, LPS_DACK_BY_C2H_REG),
 	__CFG_FW_FEAT(RTL8852C, ge, 0, 27, 128, 0, CRASH_TRIGGER_TYPE_1),
 	__CFG_FW_FEAT(RTL8852C, ge, 0, 27, 129, 1, BEACON_TRACKING),
+	__CFG_FW_FEAT(RTL8852C, ge, 0, 29, 94, 0, SER_L1_BY_EVENT),
 	__CFG_FW_FEAT(RTL8922A, ge, 0, 34, 30, 0, CRASH_TRIGGER_TYPE_0),
 	__CFG_FW_FEAT(RTL8922A, ge, 0, 34, 11, 0, MACID_PAUSE_SLEEP),
 	__CFG_FW_FEAT(RTL8922A, ge, 0, 34, 35, 0, SCAN_OFFLOAD),
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index e0c4503c4ec2..e5f2fa3b2b37 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -848,6 +848,7 @@ EXPORT_SYMBOL(rtw89_mac_get_err_status);
 int rtw89_mac_set_err_status(struct rtw89_dev *rtwdev, u32 err)
 {
 	struct rtw89_ser *ser = &rtwdev->ser;
+	bool ser_l1_hdl = false;
 	u32 halt;
 	int ret = 0;
 
@@ -856,6 +857,12 @@ int rtw89_mac_set_err_status(struct rtw89_dev *rtwdev, u32 err)
 		return -EINVAL;
 	}
 
+	if (err == MAC_AX_ERR_L1_DISABLE_EN || err == MAC_AX_ERR_L1_RCVY_EN)
+		ser_l1_hdl = true;
+
+	if (RTW89_CHK_FW_FEATURE(SER_L1_BY_EVENT, &rtwdev->fw) && ser_l1_hdl)
+		goto set;
+
 	ret = read_poll_timeout(rtw89_read32, halt, (halt == 0x0), 1000,
 				100000, false, rtwdev, R_AX_HALT_H2C_CTRL);
 	if (ret) {
@@ -863,10 +870,10 @@ int rtw89_mac_set_err_status(struct rtw89_dev *rtwdev, u32 err)
 		return -EFAULT;
 	}
 
+set:
 	rtw89_write32(rtwdev, R_AX_HALT_H2C, err);
 
-	if (ser->prehandle_l1 &&
-	    (err == MAC_AX_ERR_L1_DISABLE_EN || err == MAC_AX_ERR_L1_RCVY_EN))
+	if (ser->prehandle_l1 && ser_l1_hdl)
 		return 0;
 
 	rtw89_write32(rtwdev, R_AX_HALT_H2C_CTRL, B_AX_HALT_H2C_TRIGGER);
-- 
2.25.1


