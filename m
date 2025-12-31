Return-Path: <linux-wireless+bounces-30214-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0265BCEBA22
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Dec 2025 10:08:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C0513067057
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Dec 2025 09:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A0033112C2;
	Wed, 31 Dec 2025 09:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="XaDj1J2C"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3277D31618E
	for <linux-wireless@vger.kernel.org>; Wed, 31 Dec 2025 09:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767172035; cv=none; b=VoT/EwCmbpkrtX6zPW36PxYTXzwK4vrT/iHbxNoDlcFkZpRFjFH/DUl6PXeEdHt2u/qdZIJ4riBw8mKmN+px6k843mKEiA6jrbYxXTCEOSVaboq/S8T5PcQhvIGy8BXXpAiFOUzRLmekkcXTCHPY5W1aIeCJd8nQqAPVxrflgGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767172035; c=relaxed/simple;
	bh=cXlLP4pkF/DF4JirPgNJp2xn+Yc1z438vDre5Yy6uXY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aVDQZML2APZdSGvzgo21ZFpckHemlRKw5vgIgueifVbZdQyLG8gDc55IQg/rI73VI8YVhR1tYRlh+ftp9ZX9UpB6e3g9Z/w1OfftvdWp8S96No2YAH5Ox/pPtbgDC1kSCb4mszrdqfQgOppJM3cMr4ZWuBdsxienh8kyYXJlOVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=XaDj1J2C; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5BV97Ai74880541, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1767172030; bh=Pvz+Xt3sSIzcD+0gdelMI5nsyaLflj2qncicTG8SigY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=XaDj1J2COjv60+O5PhsdP22EOwtCEgK29ARM7CbPUHfCCdTosWRLGxnnp1EtiJjYN
	 dx3cWDjVsE4e34tZSMH8A4HhZwj1NbuHoUvo4h6XitTCWxQ8ZIK189YP8jQ4Alj8LS
	 ugJKz6IeB+x7cV/zho0U0zabKijntwX6qps0pilA4cEaTrCCjQbLuB128oO7OZLK3Y
	 aymKiOe+bKCDGAOUHx9PszIvl+Vj334cN9QV/os/uAfWqbhmlnSZmksWRxRAYSQag/
	 gpCSIYW9xAsO4K9DzVFD5/E2XTlAeCUzaAobhaW/tizfaI1CsjrSuIi9Zi5KNSK9Y/
	 cTsLkt1G6pyew==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5BV97Ai74880541
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 31 Dec 2025 17:07:10 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 31 Dec 2025 17:07:11 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 31 Dec 2025 17:07:10 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Wed, 31 Dec 2025 17:07:10 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <dian_syuan0116@realtek.com>,
        <damon.chen@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 01/11] wifi: rtw89: rfk: update RFK pre info V2 for RTL8922D
Date: Wed, 31 Dec 2025 17:06:37 +0800
Message-ID: <20251231090647.56407-2-pkshih@realtek.com>
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

The H2C command of RFK pre info is to tell current operating channels to
firmware, so RF calibrations can rely on these information as arguments
to configure hardware.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h |  1 +
 drivers/net/wireless/realtek/rtw89/fw.c   | 26 +++++++++++++++++++----
 drivers/net/wireless/realtek/rtw89/fw.h   |  8 ++++++-
 3 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 93b633d39e47..b42d3a4df4bf 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -4684,6 +4684,7 @@ enum rtw89_fw_feature {
 	RTW89_FW_FEATURE_WOW_REASON_V1,
 	RTW89_FW_FEATURE_RFK_PRE_NOTIFY_V0,
 	RTW89_FW_FEATURE_RFK_PRE_NOTIFY_V1,
+	RTW89_FW_FEATURE_RFK_PRE_NOTIFY_V2,
 	RTW89_FW_FEATURE_RFK_RXDCK_V0,
 	RTW89_FW_FEATURE_RFK_IQK_V0,
 	RTW89_FW_FEATURE_NO_WOW_CPU_IO_RX,
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 40e5d5fab651..d05b15ea022a 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -885,6 +885,7 @@ static const struct __fw_feat_cfg fw_feat_tbl[] = {
 	__CFG_FW_FEAT(RTL8922A, ge, 0, 35, 46, 0, NOTIFY_AP_INFO),
 	__CFG_FW_FEAT(RTL8922A, lt, 0, 35, 47, 0, CH_INFO_BE_V0),
 	__CFG_FW_FEAT(RTL8922A, lt, 0, 35, 49, 0, RFK_PRE_NOTIFY_V1),
+	__CFG_FW_FEAT(RTL8922A, ge, 0, 35, 49, 0, RFK_PRE_NOTIFY_V2),
 	__CFG_FW_FEAT(RTL8922A, lt, 0, 35, 51, 0, NO_PHYCAP_P1),
 	__CFG_FW_FEAT(RTL8922A, lt, 0, 35, 64, 0, NO_POWER_DIFFERENCE),
 	__CFG_FW_FEAT(RTL8922A, ge, 0, 35, 71, 0, BEACON_LOSS_COUNT_V1),
@@ -6368,6 +6369,7 @@ int rtw89_fw_h2c_rf_pre_ntfy(struct rtw89_dev *rtwdev,
 	struct rtw89_fw_h2c_rfk_pre_info_common *common;
 	struct rtw89_fw_h2c_rfk_pre_info_v0 *h2c_v0;
 	struct rtw89_fw_h2c_rfk_pre_info_v1 *h2c_v1;
+	struct rtw89_fw_h2c_rfk_pre_info_v2 *h2c_v2;
 	struct rtw89_fw_h2c_rfk_pre_info *h2c;
 	u8 tbl_sel[NUM_OF_RTW89_FW_RFK_PATH];
 	u32 len = sizeof(*h2c);
@@ -6377,7 +6379,10 @@ int rtw89_fw_h2c_rf_pre_ntfy(struct rtw89_dev *rtwdev,
 	u32 val32;
 	int ret;
 
-	if (RTW89_CHK_FW_FEATURE(RFK_PRE_NOTIFY_V1, &rtwdev->fw)) {
+	if (RTW89_CHK_FW_FEATURE(RFK_PRE_NOTIFY_V2, &rtwdev->fw)) {
+		len = sizeof(*h2c_v2);
+		ver = 2;
+	} else if (RTW89_CHK_FW_FEATURE(RFK_PRE_NOTIFY_V1, &rtwdev->fw)) {
 		len = sizeof(*h2c_v1);
 		ver = 1;
 	} else if (RTW89_CHK_FW_FEATURE(RFK_PRE_NOTIFY_V0, &rtwdev->fw)) {
@@ -6391,8 +6396,21 @@ int rtw89_fw_h2c_rf_pre_ntfy(struct rtw89_dev *rtwdev,
 		return -ENOMEM;
 	}
 	skb_put(skb, len);
+
+	if (ver <= 2)
+		goto old_format;
+
 	h2c = (struct rtw89_fw_h2c_rfk_pre_info *)skb->data;
-	common = &h2c->base_v1.common;
+
+	h2c->mlo_mode = cpu_to_le32(rtwdev->mlo_dbcc_mode);
+	h2c->phy_idx = cpu_to_le32(phy_idx);
+	h2c->mlo_1_1 = cpu_to_le32(rtw89_is_mlo_1_1(rtwdev));
+
+	goto done;
+
+old_format:
+	h2c_v2 = (struct rtw89_fw_h2c_rfk_pre_info_v2 *)skb->data;
+	common = &h2c_v2->base_v1.common;
 
 	common->mlo_mode = cpu_to_le32(rtwdev->mlo_dbcc_mode);
 
@@ -6419,7 +6437,7 @@ int rtw89_fw_h2c_rf_pre_ntfy(struct rtw89_dev *rtwdev,
 		if (ver <= 1)
 			continue;
 
-		h2c->cur_bandwidth[path] =
+		h2c_v2->cur_bandwidth[path] =
 			cpu_to_le32(rfk_mcc->data[path].bw[tbl_sel[path]]);
 	}
 
@@ -6450,7 +6468,7 @@ int rtw89_fw_h2c_rf_pre_ntfy(struct rtw89_dev *rtwdev,
 	}
 
 	if (rtw89_is_mlo_1_1(rtwdev)) {
-		h2c_v1 = &h2c->base_v1;
+		h2c_v1 = &h2c_v2->base_v1;
 		h2c_v1->mlo_1_1 = cpu_to_le32(1);
 	}
 done:
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index 6a297fad148b..f12728ccb31f 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -4574,11 +4574,17 @@ struct rtw89_fw_h2c_rfk_pre_info_v1 {
 	__le32 mlo_1_1;
 } __packed;
 
-struct rtw89_fw_h2c_rfk_pre_info {
+struct rtw89_fw_h2c_rfk_pre_info_v2 {
 	struct rtw89_fw_h2c_rfk_pre_info_v1 base_v1;
 	__le32 cur_bandwidth[NUM_OF_RTW89_FW_RFK_PATH];
 } __packed;
 
+struct rtw89_fw_h2c_rfk_pre_info {
+	__le32 mlo_mode;
+	__le32 phy_idx;
+	__le32 mlo_1_1;
+} __packed;
+
 struct rtw89_h2c_rf_tssi {
 	__le16 len;
 	u8 phy;
-- 
2.25.1


