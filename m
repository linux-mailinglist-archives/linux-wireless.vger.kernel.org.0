Return-Path: <linux-wireless+bounces-15955-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64CCA9E6711
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Dec 2024 06:58:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1ED6A2837BD
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Dec 2024 05:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC780198A0F;
	Fri,  6 Dec 2024 05:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="nlYpXtlq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607B31B87C7
	for <linux-wireless@vger.kernel.org>; Fri,  6 Dec 2024 05:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733464685; cv=none; b=pjqgrhdnVDkehefTI0RiIo4/p9y1/dVs6IBHyp16SwocIuQfigrk+SYxH2++6uTvD/Jo9M+bDND55tqB22M0TfoBfv6xiO7exdulKVD/pq93lyL/ATBORIqKXIGQoVLHNRmg86o96f/cV2hMalZY3rcrlS94Av21HPsVSN1kdQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733464685; c=relaxed/simple;
	bh=QylHCf/pGmiREcJqaVhwKzVVg1BeAcZZiPw+QQiRO7Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=izPhQnhJ3alE1PQ8ZuLuI5PZVM9hn5cxlw2vbmFqBz3O99HRO0QibyT/W941633jnEDQluowYNRQP86dalWtWa14Cw0MWMQazqwtBAuANjOhqr3owJap1mf5qIpVYWpRxCEa6TdNFNvgm3WajOt1aHeZkbeoDDnyraQbyyp9T3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=nlYpXtlq; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4B65w1mL54128762, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1733464681; bh=QylHCf/pGmiREcJqaVhwKzVVg1BeAcZZiPw+QQiRO7Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=nlYpXtlqrcEt/XxH2Ttbu8cKAErZZo3dxocmcNi3I2vjOTmuzwzaVZhzg7QEb0kU4
	 IjJeT23dtE2EisoETPG9jUG9mKHIFGWiWjOtzBN/f2FgCHYriLO7wuILnZSA1aOby3
	 XItWNvtSSU84GXYN/QBc5pZ2Ft72QafkkZsHo8nosc9QIGMoxzfznfoUZAHIrKkO4U
	 m9UyBwHC91q8uiknD+YNa5ZMfWi63zzL+AovnJTk/BCGMXrOzO+17hldQZXJY4tN/V
	 O67dSdgrL/y3zw2VzHxc/h7EN/jWrY2pKDjaggeRInxNj2aqytLrPuNyJeODEDEC1b
	 5qzIHJnPmYZwQ==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4B65w1mL54128762
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 6 Dec 2024 13:58:01 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 6 Dec 2024 13:58:01 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 6 Dec
 2024 13:58:00 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <echuang@realtek.com>, <damon.chen@realtek.com>,
        <kevin_yang@realtek.com>
Subject: [PATCH 7/7] wifi: rtw89: 8922a: update format of RFK pre-notify H2C command v2
Date: Fri, 6 Dec 2024 13:57:16 +0800
Message-ID: <20241206055716.18598-8-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241206055716.18598-1-pkshih@realtek.com>
References: <20241206055716.18598-1-pkshih@realtek.com>
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

The RFK pre-notify H2C command is to tell firmware the channels driver is
using. Since the format is changed after 0.35.49.0, update it accordingly.

Signed-off-by: Chih-Kang Chang <gary.chang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h |  1 +
 drivers/net/wireless/realtek/rtw89/fw.c   | 33 ++++++++++++++++-------
 drivers/net/wireless/realtek/rtw89/fw.h   |  7 ++++-
 3 files changed, 31 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index c2b5eeb4a4f1..155538370a89 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -4462,6 +4462,7 @@ enum rtw89_fw_feature {
 	RTW89_FW_FEATURE_SCAN_OFFLOAD_BE_V0,
 	RTW89_FW_FEATURE_WOW_REASON_V1,
 	RTW89_FW_FEATURE_RFK_PRE_NOTIFY_V0,
+	RTW89_FW_FEATURE_RFK_PRE_NOTIFY_V1,
 	RTW89_FW_FEATURE_RFK_RXDCK_V0,
 	RTW89_FW_FEATURE_NO_WOW_CPU_IO_RX,
 	RTW89_FW_FEATURE_NOTIFY_AP_INFO,
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index e5f3efe3a7e6..90db15685728 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -733,6 +733,7 @@ static const struct __fw_feat_cfg fw_feat_tbl[] = {
 	__CFG_FW_FEAT(RTL8922A, lt, 0, 35, 42, 0, RFK_RXDCK_V0),
 	__CFG_FW_FEAT(RTL8922A, ge, 0, 35, 46, 0, NOTIFY_AP_INFO),
 	__CFG_FW_FEAT(RTL8922A, lt, 0, 35, 47, 0, CH_INFO_BE_V0),
+	__CFG_FW_FEAT(RTL8922A, lt, 0, 35, 49, 0, RFK_PRE_NOTIFY_V1),
 };
 
 static void rtw89_fw_iterate_feature_cfg(struct rtw89_fw_info *fw,
@@ -5540,7 +5541,9 @@ int rtw89_fw_h2c_rf_pre_ntfy(struct rtw89_dev *rtwdev,
 			     enum rtw89_phy_idx phy_idx)
 {
 	struct rtw89_rfk_mcc_info *rfk_mcc = &rtwdev->rfk_mcc;
+	struct rtw89_fw_h2c_rfk_pre_info_common *common;
 	struct rtw89_fw_h2c_rfk_pre_info_v0 *h2c_v0;
+	struct rtw89_fw_h2c_rfk_pre_info_v1 *h2c_v1;
 	struct rtw89_fw_h2c_rfk_pre_info *h2c;
 	u8 tbl_sel[NUM_OF_RTW89_FW_RFK_PATH];
 	u32 len = sizeof(*h2c);
@@ -5550,7 +5553,10 @@ int rtw89_fw_h2c_rf_pre_ntfy(struct rtw89_dev *rtwdev,
 	u32 val32;
 	int ret;
 
-	if (RTW89_CHK_FW_FEATURE(RFK_PRE_NOTIFY_V0, &rtwdev->fw)) {
+	if (RTW89_CHK_FW_FEATURE(RFK_PRE_NOTIFY_V1, &rtwdev->fw)) {
+		len = sizeof(*h2c_v1);
+		ver = 1;
+	} else if (RTW89_CHK_FW_FEATURE(RFK_PRE_NOTIFY_V0, &rtwdev->fw)) {
 		len = sizeof(*h2c_v0);
 		ver = 0;
 	}
@@ -5562,17 +5568,18 @@ int rtw89_fw_h2c_rf_pre_ntfy(struct rtw89_dev *rtwdev,
 	}
 	skb_put(skb, len);
 	h2c = (struct rtw89_fw_h2c_rfk_pre_info *)skb->data;
+	common = &h2c->base_v1.common;
 
-	h2c->common.mlo_mode = cpu_to_le32(rtwdev->mlo_dbcc_mode);
+	common->mlo_mode = cpu_to_le32(rtwdev->mlo_dbcc_mode);
 
 	BUILD_BUG_ON(NUM_OF_RTW89_FW_RFK_TBL > RTW89_RFK_CHS_NR);
 	BUILD_BUG_ON(ARRAY_SIZE(rfk_mcc->data) < NUM_OF_RTW89_FW_RFK_PATH);
 
 	for (tbl = 0; tbl < NUM_OF_RTW89_FW_RFK_TBL; tbl++) {
 		for (path = 0; path < NUM_OF_RTW89_FW_RFK_PATH; path++) {
-			h2c->common.dbcc.ch[path][tbl] =
+			common->dbcc.ch[path][tbl] =
 				cpu_to_le32(rfk_mcc->data[path].ch[tbl]);
-			h2c->common.dbcc.band[path][tbl] =
+			common->dbcc.band[path][tbl] =
 				cpu_to_le32(rfk_mcc->data[path].band[tbl]);
 		}
 	}
@@ -5580,13 +5587,19 @@ int rtw89_fw_h2c_rf_pre_ntfy(struct rtw89_dev *rtwdev,
 	for (path = 0; path < NUM_OF_RTW89_FW_RFK_PATH; path++) {
 		tbl_sel[path] = rfk_mcc->data[path].table_idx;
 
-		h2c->common.tbl.cur_ch[path] =
+		common->tbl.cur_ch[path] =
 			cpu_to_le32(rfk_mcc->data[path].ch[tbl_sel[path]]);
-		h2c->common.tbl.cur_band[path] =
+		common->tbl.cur_band[path] =
 			cpu_to_le32(rfk_mcc->data[path].band[tbl_sel[path]]);
+
+		if (ver <= 1)
+			continue;
+
+		h2c->cur_bandwidth[path] =
+			cpu_to_le32(rfk_mcc->data[path].bw[tbl_sel[path]]);
 	}
 
-	h2c->common.phy_idx = cpu_to_le32(phy_idx);
+	common->phy_idx = cpu_to_le32(phy_idx);
 
 	if (ver == 0) { /* RFK_PRE_NOTIFY_V0 */
 		h2c_v0 = (struct rtw89_fw_h2c_rfk_pre_info_v0 *)skb->data;
@@ -5612,8 +5625,10 @@ int rtw89_fw_h2c_rf_pre_ntfy(struct rtw89_dev *rtwdev,
 		goto done;
 	}
 
-	if (rtw89_is_mlo_1_1(rtwdev))
-		h2c->mlo_1_1 = cpu_to_le32(1);
+	if (rtw89_is_mlo_1_1(rtwdev)) {
+		h2c_v1 = &h2c->base_v1;
+		h2c_v1->mlo_1_1 = cpu_to_le32(1);
+	}
 done:
 	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
 			      H2C_CAT_OUTSRC, H2C_CL_OUTSRC_RF_FW_RFK,
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index 2dfc584da7d6..a3fe183c2ab0 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -4293,11 +4293,16 @@ struct rtw89_fw_h2c_rfk_pre_info_v0 {
 	} __packed mlo;
 } __packed;
 
-struct rtw89_fw_h2c_rfk_pre_info {
+struct rtw89_fw_h2c_rfk_pre_info_v1 {
 	struct rtw89_fw_h2c_rfk_pre_info_common common;
 	__le32 mlo_1_1;
 } __packed;
 
+struct rtw89_fw_h2c_rfk_pre_info {
+	struct rtw89_fw_h2c_rfk_pre_info_v1 base_v1;
+	__le32 cur_bandwidth[NUM_OF_RTW89_FW_RFK_PATH];
+} __packed;
+
 struct rtw89_h2c_rf_tssi {
 	__le16 len;
 	u8 phy;
-- 
2.25.1


