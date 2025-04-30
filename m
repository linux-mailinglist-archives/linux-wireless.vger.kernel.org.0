Return-Path: <linux-wireless+bounces-22228-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B27F2AA42B0
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Apr 2025 07:52:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21F011BC84B7
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Apr 2025 05:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E04C51E260A;
	Wed, 30 Apr 2025 05:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="PGRAA1WW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24991E32D3
	for <linux-wireless@vger.kernel.org>; Wed, 30 Apr 2025 05:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745992370; cv=none; b=DS669q3SaU2EhoHC/q8G+bqDPbDeFVR1faumXy4/TnmZ5nCCOtRZn5zDyA7C7b8Wlv0N22Y7U1Td1xWFFU3C+4iPA/wKZz+xY1HXcymo/4NOdWsDMAEYVVVQV5GPK5EvlbtLIKajw6o6HM3VeyTZv5B8FaGreyyOXFwTYbRl1wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745992370; c=relaxed/simple;
	bh=DksTVhnsco6q4FpzMBiRHkjauhAVk3Xugkg6/JA+DXw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dvz5ANbCLbDdQj5uvGDoINatmwPfbKzI3JcZDRRIIml6l+uiCgo9rlh/TjtaAKuGYqvj5a6azsUtZsbdcJY6XNIPWNmKk7o7nGManoTqDOZGKXjKikdKncxzeLuAXOhk3ezKA7lnsihfpLpEJTc4hdaHDm0k8+sYErJSUuMTva0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=PGRAA1WW; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 53U5qilV72508521, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1745992364; bh=DksTVhnsco6q4FpzMBiRHkjauhAVk3Xugkg6/JA+DXw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=PGRAA1WWe3H3lxynb+NkwjiM8orypMegKs0p8NNl3F4xSo3N8cpJMs4/LmC0SEpYO
	 EhVrOzRx8t4NtWQaSYy/xPmjgjd1f2DkDaeU+/fXaQgBern8LGO7EsMU5QGwod6B44
	 MW9VgySgE5lXShU3g95SqlRMbnbYeTHDIXXU3uM1LrfIoZOl/EkyHqhME6KfE8eJpq
	 Hcp4bXEsMxqam3A1tJ+rR09pVy+9gIYUr/cBwF1ibf3ocZr5mMfpi3Hy2tYXbhJ85O
	 Be8l6it0iSFigu2NvF9VdVidKkgj5IIImqmn+lMVIO86z6t15eMqI+1yEgrnCi9yaM
	 IC3GQ+B9rvwnw==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 53U5qilV72508521
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 30 Apr 2025 13:52:44 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 30 Apr 2025 13:52:44 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 30 Apr
 2025 13:52:43 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <damon.chen@realtek.com>
Subject: [PATCH rtw-next 1/2] wifi: rtw89: phy: add C2H event handler for report of FW scan
Date: Wed, 30 Apr 2025 13:51:56 +0800
Message-ID: <20250430055157.13623-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250430055157.13623-1-pkshih@realtek.com>
References: <20250430055157.13623-1-pkshih@realtek.com>
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

From: Kuan-Chung Chen <damon.chen@realtek.com>

Newer firmware will notify driver of the Packet Detection (PD)
value on the channel after switch channels during FW scan.

Signed-off-by: Kuan-Chung Chen <damon.chen@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.h  | 13 +++++++++
 drivers/net/wireless/realtek/rtw89/phy.c | 35 ++++++++++++++++++++++--
 drivers/net/wireless/realtek/rtw89/phy.h |  1 +
 3 files changed, 46 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index 0d89083df49a..8e6e71971a7e 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -3620,6 +3620,19 @@ struct rtw89_c2h_ra_rpt {
 #define RTW89_C2H_RA_RPT_W3_MD_SEL_B2 BIT(15)
 #define RTW89_C2H_RA_RPT_W3_BW_B2 BIT(16)
 
+struct rtw89_c2h_fw_scan_rpt {
+	struct rtw89_c2h_hdr hdr;
+	u8 phy_idx;
+	u8 band;
+	u8 center_ch;
+	u8 ofdm_pd_idx; /* in unit of 2 dBm */
+#define PD_LOWER_BOUND_BASE 102
+	s8 cck_pd_idx;
+	u8 rsvd0;
+	u8 rsvd1;
+	u8 rsvd2;
+} __packed;
+
 /* For WiFi 6 chips:
  *   VHT, HE, HT-old: [6:4]: NSS, [3:0]: MCS
  *   HT-new: [6:5]: NA, [4:0]: MCS
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index 270f40e44c0b..e358cb83dae8 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -3023,6 +3023,35 @@ void (* const rtw89_phy_c2h_ra_handler[])(struct rtw89_dev *rtwdev,
 	[RTW89_PHY_C2H_FUNC_TXSTS] = NULL,
 };
 
+static void
+rtw89_phy_c2h_lowrt_rty(struct rtw89_dev *rtwdev, struct sk_buff *c2h, u32 len)
+{
+}
+
+static void
+rtw89_phy_c2h_fw_scan_rpt(struct rtw89_dev *rtwdev, struct sk_buff *c2h, u32 len)
+{
+	const struct rtw89_c2h_fw_scan_rpt *c2h_rpt =
+		(const struct rtw89_c2h_fw_scan_rpt *)c2h->data;
+
+	rtw89_debug(rtwdev, RTW89_DBG_DIG,
+		    "%s: band: %u, op_chan: %u, PD_low_bd(ofdm, cck): (-%d, %d), phy_idx: %u\n",
+		    __func__, c2h_rpt->band, c2h_rpt->center_ch,
+		    PD_LOWER_BOUND_BASE - (c2h_rpt->ofdm_pd_idx << 1),
+		    c2h_rpt->cck_pd_idx, c2h_rpt->phy_idx);
+}
+
+static
+void (* const rtw89_phy_c2h_dm_handler[])(struct rtw89_dev *rtwdev,
+					  struct sk_buff *c2h, u32 len) = {
+	[RTW89_PHY_C2H_DM_FUNC_FW_TEST] = NULL,
+	[RTW89_PHY_C2H_DM_FUNC_FW_TRIG_TX_RPT] = NULL,
+	[RTW89_PHY_C2H_DM_FUNC_SIGB] = NULL,
+	[RTW89_PHY_C2H_DM_FUNC_LOWRT_RTY] = rtw89_phy_c2h_lowrt_rty,
+	[RTW89_PHY_C2H_DM_FUNC_MCC_DIG] = NULL,
+	[RTW89_PHY_C2H_DM_FUNC_FW_SCAN] = rtw89_phy_c2h_fw_scan_rpt,
+};
+
 static void rtw89_phy_c2h_rfk_rpt_log(struct rtw89_dev *rtwdev,
 				      enum rtw89_phy_c2h_rfk_log_func func,
 				      void *content, u16 len)
@@ -3558,9 +3587,9 @@ void rtw89_phy_c2h_handle(struct rtw89_dev *rtwdev, struct sk_buff *skb,
 			handler = rtw89_phy_c2h_rfk_report_handler[func];
 		break;
 	case RTW89_PHY_C2H_CLASS_DM:
-		if (func == RTW89_PHY_C2H_DM_FUNC_LOWRT_RTY)
-			return;
-		fallthrough;
+		if (func < ARRAY_SIZE(rtw89_phy_c2h_dm_handler))
+			handler = rtw89_phy_c2h_dm_handler[func];
+		break;
 	default:
 		rtw89_info(rtwdev, "PHY c2h class %d not support\n", class);
 		return;
diff --git a/drivers/net/wireless/realtek/rtw89/phy.h b/drivers/net/wireless/realtek/rtw89/phy.h
index cafb1a06d7b8..5b451f1cfaac 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.h
+++ b/drivers/net/wireless/realtek/rtw89/phy.h
@@ -164,6 +164,7 @@ enum rtw89_phy_c2h_dm_func {
 	RTW89_PHY_C2H_DM_FUNC_SIGB,
 	RTW89_PHY_C2H_DM_FUNC_LOWRT_RTY,
 	RTW89_PHY_C2H_DM_FUNC_MCC_DIG,
+	RTW89_PHY_C2H_DM_FUNC_FW_SCAN = 0xc,
 	RTW89_PHY_C2H_DM_FUNC_NUM,
 };
 
-- 
2.25.1


