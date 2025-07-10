Return-Path: <linux-wireless+bounces-25157-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63644AFF807
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 06:25:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C82FB3AF992
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 04:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B703227F19F;
	Thu, 10 Jul 2025 04:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="AH2A4gM2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE145206F27
	for <linux-wireless@vger.kernel.org>; Thu, 10 Jul 2025 04:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752121530; cv=none; b=Q9j8yg8Z/1gEAobdMocyibq0AgEuGmYKeNo11mIXuq8pPneuKJmQHzoSNHSCEzeGayZYw2MC3hnIKsNqPjD0iy9ow3Clfu2UwMWz/HxPYF5hF495AfsYN8xMyhT68U8RMUPKvwql8ZqiqLnFCo4WoZpyRAhIxEng+lAvVglLQgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752121530; c=relaxed/simple;
	bh=9w+7+q+5VCkP+BZ7pQgmSRxChamaSzpl8YqZAlTMBwo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bBtFyqN/z73e47uH5CPAOqucu9OsLW3kxNUgk8o1cLcLJX2Xq/DB9iqVKBJGEmX4kz7st9os4KC0N1gUBi45UcLspL9ECI5rK2lGKm4lLzRlrSky01mXSSjQG6/LAbMCvCPG/aatOsXJYXmQiWN9moWl4g2JPbfSBZ+CGvxrY9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=AH2A4gM2; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 56A4PRgS42455834, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1752121527; bh=Ec9+DTA3DvSOqpeFlOFN/mRXp2QhIcmjfVlgMGivYlo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=AH2A4gM2219rLkE9QQOdTjwlPGu0jkBZg2TkViyd1p2KFU7esIrQBzhfn8EZBM10I
	 L1abnmBCt6PwxFUk/GCw9WFnHB/g86YncexWJqQmK6hQ8VtwXb3vW/t0C9yy6rUxFl
	 lPqC3cCcf4XKlAfvShfUA80MiyOQDTmHirLnDS14OkxEPIft8b9gWsDdWJDVr8sYiO
	 P7EfyeT4rTmwOyxfX/SWcy2vITnbwRsQ62vMLFK9hHWt2XbsR9IRABjcA2VF7y1WOk
	 wmOKiyFEHoExeXsG10Sc81dJV2Tt1LOm2hksMB5VLmAKZiRUngFl4RRObBU+G8Jhlm
	 brNAl5tAYG4XQ==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 56A4PRgS42455834
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 10 Jul 2025 12:25:27 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 10 Jul 2025 12:25:26 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 10 Jul
 2025 12:25:26 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 08/14] wifi: rtw89: introduce fw feature group and redefine CRASH_TRIGGER
Date: Thu, 10 Jul 2025 12:24:17 +0800
Message-ID: <20250710042423.73617-9-pkshih@realtek.com>
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

From: Zong-Zhe Yang <kevin_yang@realtek.com>

Some FW features may have variants on how to deal with in leaf functions,
e.g. H2C commands. However, from SW component point of view, it might not
matter which variant is supported exactly. In some cases, SW component may
just care whether any of the variants is supported or not.

So, introduce a concept of FW feature group which can manage a set of FW
features and can easily be checked if at least one of them is supported.

Since CRASH_TRIGGER will have variants and then matches the case mentioned
above, so redefine CRASH_TRIGGER as a FW feature group and add a variant
of type 0 for original handling.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h  | 15 ++++++++++++++-
 drivers/net/wireless/realtek/rtw89/debug.c |  2 +-
 drivers/net/wireless/realtek/rtw89/fw.c    | 12 ++++++------
 3 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 470a97ec24ac..0d02036d3cc4 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -4583,11 +4583,20 @@ enum rtw89_fw_type {
 	RTW89_FW_LOGFMT = 255,
 };
 
+#define RTW89_FW_FEATURE_GROUP(_grp, _features...) \
+	RTW89_FW_FEATURE_##_grp##_MIN, \
+	__RTW89_FW_FEATURE_##_grp##_S = RTW89_FW_FEATURE_##_grp##_MIN - 1, \
+	_features \
+	__RTW89_FW_FEATURE_##_grp##_E, \
+	RTW89_FW_FEATURE_##_grp##_MAX = __RTW89_FW_FEATURE_##_grp##_E - 1
+
 enum rtw89_fw_feature {
 	RTW89_FW_FEATURE_OLD_HT_RA_FORMAT,
 	RTW89_FW_FEATURE_SCAN_OFFLOAD,
 	RTW89_FW_FEATURE_TX_WAKE,
-	RTW89_FW_FEATURE_CRASH_TRIGGER,
+	RTW89_FW_FEATURE_GROUP(CRASH_TRIGGER,
+			       RTW89_FW_FEATURE_CRASH_TRIGGER_TYPE_0,
+	),
 	RTW89_FW_FEATURE_NO_PACKET_DROP,
 	RTW89_FW_FEATURE_NO_DEEP_PS,
 	RTW89_FW_FEATURE_NO_LPS_PG,
@@ -4706,6 +4715,10 @@ struct rtw89_fw_info {
 #define RTW89_CHK_FW_FEATURE(_feat, _fw) \
 	(!!((_fw)->feature_map & BIT(RTW89_FW_FEATURE_ ## _feat)))
 
+#define RTW89_CHK_FW_FEATURE_GROUP(_grp, _fw) \
+	(!!((_fw)->feature_map & GENMASK(RTW89_FW_FEATURE_ ## _grp ## _MAX, \
+					 RTW89_FW_FEATURE_ ## _grp ## _MIN)))
+
 #define RTW89_SET_FW_FEATURE(_fw_feature, _fw) \
 	((_fw)->feature_map |= BIT(_fw_feature))
 
diff --git a/drivers/net/wireless/realtek/rtw89/debug.c b/drivers/net/wireless/realtek/rtw89/debug.c
index 4acb567b3ad4..afdfb9647fc1 100644
--- a/drivers/net/wireless/realtek/rtw89/debug.c
+++ b/drivers/net/wireless/realtek/rtw89/debug.c
@@ -3596,7 +3596,7 @@ rtw89_debug_priv_fw_crash_set(struct rtw89_dev *rtwdev,
 
 	switch (crash_type) {
 	case RTW89_DBG_SIM_CPU_EXCEPTION:
-		if (!RTW89_CHK_FW_FEATURE(CRASH_TRIGGER, &rtwdev->fw))
+		if (!RTW89_CHK_FW_FEATURE_GROUP(CRASH_TRIGGER, &rtwdev->fw))
 			return -EOPNOTSUPP;
 		sim = rtw89_fw_h2c_trigger_cpu_exception;
 		break;
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 8157774b2bb1..fca79212e34f 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -814,23 +814,23 @@ struct __fw_feat_cfg {
 static const struct __fw_feat_cfg fw_feat_tbl[] = {
 	__CFG_FW_FEAT(RTL8851B, ge, 0, 29, 37, 1, TX_WAKE),
 	__CFG_FW_FEAT(RTL8851B, ge, 0, 29, 37, 1, SCAN_OFFLOAD),
-	__CFG_FW_FEAT(RTL8851B, ge, 0, 29, 41, 0, CRASH_TRIGGER),
+	__CFG_FW_FEAT(RTL8851B, ge, 0, 29, 41, 0, CRASH_TRIGGER_TYPE_0),
 	__CFG_FW_FEAT(RTL8852A, le, 0, 13, 29, 0, OLD_HT_RA_FORMAT),
 	__CFG_FW_FEAT(RTL8852A, ge, 0, 13, 35, 0, SCAN_OFFLOAD),
 	__CFG_FW_FEAT(RTL8852A, ge, 0, 13, 35, 0, TX_WAKE),
-	__CFG_FW_FEAT(RTL8852A, ge, 0, 13, 36, 0, CRASH_TRIGGER),
+	__CFG_FW_FEAT(RTL8852A, ge, 0, 13, 36, 0, CRASH_TRIGGER_TYPE_0),
 	__CFG_FW_FEAT(RTL8852A, lt, 0, 13, 37, 0, NO_WOW_CPU_IO_RX),
 	__CFG_FW_FEAT(RTL8852A, lt, 0, 13, 38, 0, NO_PACKET_DROP),
 	__CFG_FW_FEAT(RTL8852B, ge, 0, 29, 26, 0, NO_LPS_PG),
 	__CFG_FW_FEAT(RTL8852B, ge, 0, 29, 26, 0, TX_WAKE),
-	__CFG_FW_FEAT(RTL8852B, ge, 0, 29, 29, 0, CRASH_TRIGGER),
+	__CFG_FW_FEAT(RTL8852B, ge, 0, 29, 29, 0, CRASH_TRIGGER_TYPE_0),
 	__CFG_FW_FEAT(RTL8852B, ge, 0, 29, 29, 0, SCAN_OFFLOAD),
 	__CFG_FW_FEAT(RTL8852B, ge, 0, 29, 29, 7, BEACON_FILTER),
 	__CFG_FW_FEAT(RTL8852B, lt, 0, 29, 30, 0, NO_WOW_CPU_IO_RX),
 	__CFG_FW_FEAT(RTL8852B, ge, 0, 29, 127, 0, LPS_DACK_BY_C2H_REG),
 	__CFG_FW_FEAT(RTL8852BT, ge, 0, 29, 74, 0, NO_LPS_PG),
 	__CFG_FW_FEAT(RTL8852BT, ge, 0, 29, 74, 0, TX_WAKE),
-	__CFG_FW_FEAT(RTL8852BT, ge, 0, 29, 90, 0, CRASH_TRIGGER),
+	__CFG_FW_FEAT(RTL8852BT, ge, 0, 29, 90, 0, CRASH_TRIGGER_TYPE_0),
 	__CFG_FW_FEAT(RTL8852BT, ge, 0, 29, 91, 0, SCAN_OFFLOAD),
 	__CFG_FW_FEAT(RTL8852BT, ge, 0, 29, 110, 0, BEACON_FILTER),
 	__CFG_FW_FEAT(RTL8852BT, ge, 0, 29, 127, 0, LPS_DACK_BY_C2H_REG),
@@ -838,11 +838,11 @@ static const struct __fw_feat_cfg fw_feat_tbl[] = {
 	__CFG_FW_FEAT(RTL8852C, ge, 0, 0, 0, 0, RFK_NTFY_MCC_V0),
 	__CFG_FW_FEAT(RTL8852C, ge, 0, 27, 34, 0, TX_WAKE),
 	__CFG_FW_FEAT(RTL8852C, ge, 0, 27, 36, 0, SCAN_OFFLOAD),
-	__CFG_FW_FEAT(RTL8852C, ge, 0, 27, 40, 0, CRASH_TRIGGER),
+	__CFG_FW_FEAT(RTL8852C, ge, 0, 27, 40, 0, CRASH_TRIGGER_TYPE_0),
 	__CFG_FW_FEAT(RTL8852C, ge, 0, 27, 56, 10, BEACON_FILTER),
 	__CFG_FW_FEAT(RTL8852C, ge, 0, 27, 80, 0, WOW_REASON_V1),
 	__CFG_FW_FEAT(RTL8852C, ge, 0, 27, 128, 0, BEACON_LOSS_COUNT_V1),
-	__CFG_FW_FEAT(RTL8922A, ge, 0, 34, 30, 0, CRASH_TRIGGER),
+	__CFG_FW_FEAT(RTL8922A, ge, 0, 34, 30, 0, CRASH_TRIGGER_TYPE_0),
 	__CFG_FW_FEAT(RTL8922A, ge, 0, 34, 11, 0, MACID_PAUSE_SLEEP),
 	__CFG_FW_FEAT(RTL8922A, ge, 0, 34, 35, 0, SCAN_OFFLOAD),
 	__CFG_FW_FEAT(RTL8922A, lt, 0, 35, 21, 0, SCAN_OFFLOAD_BE_V0),
-- 
2.25.1


