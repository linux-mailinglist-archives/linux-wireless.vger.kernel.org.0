Return-Path: <linux-wireless+bounces-30221-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CA0CDCEBA31
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Dec 2025 10:09:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 704863038283
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Dec 2025 09:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F8FC2D660E;
	Wed, 31 Dec 2025 09:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="K6C64f6K"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D123112C2
	for <linux-wireless@vger.kernel.org>; Wed, 31 Dec 2025 09:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767172072; cv=none; b=s8vFEqcVn49giP05N5Nj0ZOYidWRcCeeU2GEOMYonUMejEhlj5CshVZB3MKefTJkMwt7ODZz1g9nFBKs1XKD+MKlOUAVPhBT5O55mMoKX17qAiXGZEzTlQD1vjLbwu7e7dWZurDBLjNxyJxhQU1RDFSQp2/H4+vVldHL6Kko58k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767172072; c=relaxed/simple;
	bh=jyxrHeELKAZfvYga3mxe/rTcCTsRkCdCb4pOuoxgiO4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BCfmo0eqzUg6v2ljh3ywGMmX4oczTx3OLdOTFhd5BuW987MN9pW8Z36EiTMaXycrpVWHOoTStzMyJCkSEKPtmjYK7J6Ns9xlUKBFSAOPKDq0+xKG668lLDgHwd1B4ICMHC5YPckhdP7ZBBihno+nfnMnbAi0IXcLR/Sap71qIPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=K6C64f6K; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5BV97mX22881262, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1767172068; bh=jtS0FvTA5FmpZSd5V0ylIOTAx/fC0rw6HWszrJmlJq8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=K6C64f6Ka+UJJrw5LwU4J9Z2do+o+QK3Vz9Tw8MuXqJkJ4y1EW8ffepxN66J8+EN2
	 FROr9cqN44Nr1Kxm8jJN3w8XyDYXT7sohVxqRsdEatYRrG188wWMvLoC0EdZl+HBrW
	 7x7+knSvjUCsd0oY1HZTRwIWTxG8Ptnp2Yq2VTRp5OHfGgk9xwnpdJ1mv9mnznj58B
	 7uOT6Yf3rSIqREXu8aH+GjIqKQaooAUxn05GP9Z2tSbC1w1WJT6EzL/o9zaef3dYG0
	 HLJzrv0ihVGzwVg3/CxX9c5w2KVwSr4tGnCeqmUzrSVB79Mw+NcK7piBq6L+26/lhQ
	 8Ha+93j66QNCQ==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5BV97mX22881262
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 31 Dec 2025 17:07:48 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 31 Dec 2025 17:07:48 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 31 Dec 2025 17:07:48 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS04.realtek.com.tw
 (10.21.1.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Wed, 31 Dec 2025 17:07:48 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <dian_syuan0116@realtek.com>,
        <damon.chen@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 08/11] wifi: rtw89: fw: change WITH_RFK_PRE_NOTIFY to be a FW feature group
Date: Wed, 31 Dec 2025 17:06:44 +0800
Message-ID: <20251231090647.56407-9-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251231090647.56407-1-pkshih@realtek.com>
References: <20251231090647.56407-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Zong-Zhe Yang <kevin_yang@realtek.com>

Actually, WITH_RFK_PRE_NOTIFY means supporting one of RFK_PRE_NOTIFY_Vx.
So, change it to be a FW feature group which contains RFK_PRE_NOTIFY_Vx.
Then, because WITH_RFK_PRE_NOTIFY is abandoned after some FW versions by
chip, disable WITH_RFK_PRE_NOTIFY correspondingly in FW feature table.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c     |  4 ++--
 drivers/net/wireless/realtek/rtw89/core.h     | 10 ++++++----
 drivers/net/wireless/realtek/rtw89/fw.c       |  5 +++--
 drivers/net/wireless/realtek/rtw89/mac80211.c |  2 +-
 drivers/net/wireless/realtek/rtw89/phy.c      |  2 +-
 5 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 96fb2839379f..191caafbd0fb 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -478,7 +478,7 @@ void rtw89_chip_rfk_channel(struct rtw89_dev *rtwdev,
 	bool prehdl_link = false;
 
 	if (chip->chip_gen != RTW89_CHIP_AX &&
-	    !RTW89_CHK_FW_FEATURE(WITH_RFK_PRE_NOTIFY, &rtwdev->fw) &&
+	    !RTW89_CHK_FW_FEATURE_GROUP(WITH_RFK_PRE_NOTIFY, &rtwdev->fw) &&
 	    !mon && !rtw89_entity_check_hw(rtwdev, rtwvif_link->phy_idx))
 		prehdl_link = true;
 
@@ -6244,7 +6244,7 @@ int rtw89_core_mlsr_switch(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
 		goto wake_queue;
 	}
 
-	if (RTW89_CHK_FW_FEATURE(WITH_RFK_PRE_NOTIFY, &rtwdev->fw))
+	if (RTW89_CHK_FW_FEATURE_GROUP(WITH_RFK_PRE_NOTIFY, &rtwdev->fw))
 		rtw89_chip_rfk_channel(rtwdev, target);
 
 	rtwvif->mlo_mode = RTW89_MLO_MODE_MLSR;
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 8010ee070108..38a64b0bfb5c 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -4682,10 +4682,12 @@ enum rtw89_fw_feature {
 	RTW89_FW_FEATURE_MACID_PAUSE_SLEEP,
 	RTW89_FW_FEATURE_SCAN_OFFLOAD_BE_V0,
 	RTW89_FW_FEATURE_WOW_REASON_V1,
-	RTW89_FW_FEATURE_RFK_PRE_NOTIFY_V0,
-	RTW89_FW_FEATURE_RFK_PRE_NOTIFY_V1,
-	RTW89_FW_FEATURE_RFK_PRE_NOTIFY_V2,
-	RTW89_FW_FEATURE_WITH_RFK_PRE_NOTIFY,
+	RTW89_FW_FEATURE_GROUP(WITH_RFK_PRE_NOTIFY,
+			       RTW89_FW_FEATURE_RFK_PRE_NOTIFY_V0,
+			       RTW89_FW_FEATURE_RFK_PRE_NOTIFY_V1,
+			       RTW89_FW_FEATURE_RFK_PRE_NOTIFY_V2,
+			       RTW89_FW_FEATURE_RFK_PRE_NOTIFY_V3,
+	),
 	RTW89_FW_FEATURE_RFK_RXDCK_V0,
 	RTW89_FW_FEATURE_RFK_IQK_V0,
 	RTW89_FW_FEATURE_NO_WOW_CPU_IO_RX,
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 4ba99e7078fe..fed9b3db1543 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -918,7 +918,7 @@ static const struct __fw_feat_cfg fw_feat_tbl[] = {
 	__CFG_FW_FEAT(RTL8922A, ge, 0, 35, 76, 0, LPS_DACK_BY_C2H_REG),
 	__CFG_FW_FEAT(RTL8922A, ge, 0, 35, 79, 0, CRASH_TRIGGER_TYPE_1),
 	__CFG_FW_FEAT(RTL8922A, ge, 0, 35, 80, 0, BEACON_TRACKING),
-	__CFG_FW_FEAT(RTL8922A, le, 0, 35, 80, 0, WITH_RFK_PRE_NOTIFY),
+	__DIS_FW_FEAT(RTL8922A, ge, 0, 35, 84, 0, WITH_RFK_PRE_NOTIFY, G),
 	__CFG_FW_FEAT(RTL8922A, lt, 0, 35, 84, 0, ADDR_CAM_V0),
 };
 
@@ -6414,7 +6414,8 @@ int rtw89_fw_h2c_rf_pre_ntfy(struct rtw89_dev *rtwdev,
 	u32 val32;
 	int ret;
 
-	if (RTW89_CHK_FW_FEATURE(RFK_PRE_NOTIFY_V2, &rtwdev->fw)) {
+	if (RTW89_CHK_FW_FEATURE(RFK_PRE_NOTIFY_V3, &rtwdev->fw)) {
+	} else if (RTW89_CHK_FW_FEATURE(RFK_PRE_NOTIFY_V2, &rtwdev->fw)) {
 		len = sizeof(*h2c_v2);
 		ver = 2;
 	} else if (RTW89_CHK_FW_FEATURE(RFK_PRE_NOTIFY_V1, &rtwdev->fw)) {
diff --git a/drivers/net/wireless/realtek/rtw89/mac80211.c b/drivers/net/wireless/realtek/rtw89/mac80211.c
index 96dc94c1f556..ba71709a9bc9 100644
--- a/drivers/net/wireless/realtek/rtw89/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw89/mac80211.c
@@ -720,7 +720,7 @@ static void rtw89_ops_vif_cfg_changed(struct ieee80211_hw *hw,
 	if (changed & BSS_CHANGED_MLD_VALID_LINKS) {
 		struct rtw89_vif_link *cur = rtw89_get_designated_link(rtwvif);
 
-		if (RTW89_CHK_FW_FEATURE(WITH_RFK_PRE_NOTIFY, &rtwdev->fw))
+		if (RTW89_CHK_FW_FEATURE_GROUP(WITH_RFK_PRE_NOTIFY, &rtwdev->fw))
 			rtw89_chip_rfk_channel(rtwdev, cur);
 
 		if (hweight16(vif->active_links) == 1)
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index d0e5d52964de..f56b433a1674 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -3808,7 +3808,7 @@ int rtw89_phy_rfk_pre_ntfy_and_wait(struct rtw89_dev *rtwdev,
 {
 	int ret;
 
-	if (RTW89_CHK_FW_FEATURE(WITH_RFK_PRE_NOTIFY, &rtwdev->fw))
+	if (RTW89_CHK_FW_FEATURE_GROUP(WITH_RFK_PRE_NOTIFY, &rtwdev->fw))
 		goto pre_ntfy;
 
 	return rtw89_fw_h2c_rf_pre_ntfy_mcc(rtwdev, phy_idx);
-- 
2.25.1


