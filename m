Return-Path: <linux-wireless+bounces-30922-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EC7A0D38C49
	for <lists+linux-wireless@lfdr.de>; Sat, 17 Jan 2026 05:42:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1B5FE300D811
	for <lists+linux-wireless@lfdr.de>; Sat, 17 Jan 2026 04:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D59F118C02E;
	Sat, 17 Jan 2026 04:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="g/afW0y3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088812D77EA
	for <linux-wireless@vger.kernel.org>; Sat, 17 Jan 2026 04:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768624932; cv=none; b=MgNgkzE16AC1BwdlR1L9jZlV4QkUIKch+jDRzxsJJl6mYj28BxIr3WEDJmOWDbzzpo6pwKKtkjN5sqq+1meYUcwzc29QwWS5gi/azIknexdLO39viaBWES3bNoPUvKdPNUQ8taKhD8ogSdHv5CLhGtKEO61U3kFo8VLbFn4d1ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768624932; c=relaxed/simple;
	bh=9gRHvUKYoOSFhRFX1LWDkMMAHCeQUxq7n5RHisy5g9o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BnPZneyCb9KVMhcJABPrPbGY3kOOEw5tynoKwhj5/0O4P/4ZFirLibKB1Yb9ZM8dBAm3mTOXCCAJiwyN6wBrvAGE45UYAZGvskHnsJFpogSF8ZiqORjKGECvDaWoJRksbdfpXYJxTrPM7IxyTv58PoYVKzKokhyoFK5KH1MWutE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=g/afW0y3; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 60H4g8lcD2464444, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1768624928; bh=WMjwjmQmKoNPY9yqLNqJjbuyqbXxJayx8MC4epFhZgU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=g/afW0y3mqG9ilCMwVuv/AUQL0j3qCFm2GGamaqGVDoFBSniu1+q80NQ1fL6MJ3Ow
	 /DxPuiWiIj3ZMrGgw0RN8VkCZ90zDikuBWXi9OcYf7xLpvOQm6tzzoYRkft/BYx751
	 z/az+FUmlWB3g0VzUiz0fKYn+5FoH7l+NotkkQ7FhE25xwZwXqYkg0WTA+uhpoaAHr
	 thFaeHlbdvWrK3E4Iq0tiZ2jlphALLGeUijPOEdehUw8WvqzwzUb3GrHdg+oHdjX9w
	 7MBwz4Z9yWqZAMqToHqmcN3vizXRwVNQVSCzgHoPDBhK/M7+c4Me60Pt1Z8jC98wA5
	 Nmsj/yVRDc1Yg==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 60H4g8lcD2464444
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Sat, 17 Jan 2026 12:42:08 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Sat, 17 Jan 2026 12:42:09 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Sat, 17 Jan 2026 12:42:08 +0800
Received: from [127.0.1.1] (172.21.40.76) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Sat, 17 Jan 2026 12:42:08 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <echuang@realtek.com>, <phhuang@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 2/9] wifi: rtw89: phy: handle C2H event for PS mode report
Date: Sat, 17 Jan 2026 12:41:50 +0800
Message-ID: <20260117044157.2392958-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260117044157.2392958-1-pkshih@realtek.com>
References: <20260117044157.2392958-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Eric Huang <echuang@realtek.com>

Introduce support for processing the new PS C2H report, enabling
detailed debugging of low-power state hardware changes.

Signed-off-by: Eric Huang <echuang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/debug.h |  1 +
 drivers/net/wireless/realtek/rtw89/fw.h    | 20 ++++++++
 drivers/net/wireless/realtek/rtw89/phy.c   | 59 ++++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/phy.h   |  1 +
 4 files changed, 81 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/debug.h b/drivers/net/wireless/realtek/rtw89/debug.h
index a364e7adb079..7cdceb24f52d 100644
--- a/drivers/net/wireless/realtek/rtw89/debug.h
+++ b/drivers/net/wireless/realtek/rtw89/debug.h
@@ -31,6 +31,7 @@ enum rtw89_debug_mask {
 	RTW89_DBG_CHAN = BIT(20),
 	RTW89_DBG_ACPI = BIT(21),
 	RTW89_DBG_EDCCA = BIT(22),
+	RTW89_DBG_PS = BIT(23),
 
 	RTW89_DBG_UNEXP = BIT(31),
 };
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index 018b3bed57d2..12e798f01df7 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -3829,6 +3829,26 @@ struct rtw89_c2h_ra_rpt {
 #define RTW89_C2H_RA_RPT_W3_MD_SEL_B2 BIT(15)
 #define RTW89_C2H_RA_RPT_W3_BW_B2 BIT(16)
 
+struct rtw89_c2h_lps_rpt {
+	struct rtw89_c2h_hdr hdr;
+	u8 type;
+	u8 cnt_bbcr;
+	u8 cnt_bbmcucr;
+	u8 cnt_rfcr;
+	u8 data[];
+	/*
+	 * The layout of data:
+	 *   u8 info[][4], size = total_len - size of below fields
+	 *   __le16 bbcr_addr[], size = cnt_bbcr
+	 *   __le32 bbcr_data[], size = cnt_bbcr
+	 *   __le16 bbmcucr_addr[], size = cnt_bbmcucr
+	 *   __le32 bbmcucr_data[], size = cnt_bbmcucr
+	 *   __le16 rfcr_addr[],   size = cnt_rfcr
+	 *   __le32 rfcr_data_a[], size = cnt_rfcr
+	 *   __le32 rfcr_data_b[], size = cnt_rfcr
+	 */
+} __packed;
+
 struct rtw89_c2h_fw_scan_rpt {
 	struct rtw89_c2h_hdr hdr;
 	u8 phy_idx;
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index 0b72d3dcf666..6059f40f34b3 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -3217,6 +3217,64 @@ rtw89_phy_c2h_lowrt_rty(struct rtw89_dev *rtwdev, struct sk_buff *c2h, u32 len)
 {
 }
 
+static void
+rtw89_phy_c2h_lps_rpt(struct rtw89_dev *rtwdev, struct sk_buff *c2h, u32 len)
+{
+	const struct rtw89_c2h_lps_rpt *c2h_rpt = (const void *)c2h->data;
+	const __le32 *data_a, *data_b;
+	u16 len_info, cr_len, idx;
+	const __le16 *addr;
+	const u8 *info;
+
+	/* elements size of BBCR/BBMCUCR/RFCR are 6/6/10 bytes respectively */
+	cr_len = c2h_rpt->cnt_bbcr * 6 +
+		 c2h_rpt->cnt_bbmcucr * 6 +
+		 c2h_rpt->cnt_rfcr * 10;
+	len_info = len - (sizeof(*c2h_rpt) + cr_len);
+
+	if (len < sizeof(*c2h_rpt) + cr_len || len_info % 4 != 0) {
+		rtw89_debug(rtwdev, RTW89_DBG_PS,
+			    "Invalid LPS RPT len(%d) TYPE(%d) CRCNT: BB(%d) MCU(%d) RF(%d)\n",
+			    len, c2h_rpt->type, c2h_rpt->cnt_bbcr,
+			    c2h_rpt->cnt_bbmcucr, c2h_rpt->cnt_rfcr);
+		return;
+	}
+
+	rtw89_debug(rtwdev, RTW89_DBG_PS,
+		    "LPS RPT TYPE(%d), CRCNT: BB(%d) MCU(%d) RF(%d)\n",
+		    c2h_rpt->type, c2h_rpt->cnt_bbcr,
+		    c2h_rpt->cnt_bbmcucr, c2h_rpt->cnt_rfcr);
+
+	info = &c2h_rpt->data[0];
+	for (idx = 0; idx < len_info; idx += 4, info += 4)
+		rtw89_debug(rtwdev, RTW89_DBG_PS,
+			    "BB LPS INFO (%02d) - 0x%02x,0x%02x,0x%02x,0x%02x\n",
+			    idx, info[3], info[2], info[1], info[0]);
+
+	addr = (const void *)(info);
+	data_a = (const void *)(addr + c2h_rpt->cnt_bbcr);
+	for (idx = 0; idx < c2h_rpt->cnt_bbcr; idx++, addr++, data_a++)
+		rtw89_debug(rtwdev, RTW89_DBG_PS,
+			    "LPS BB CR - 0x%04x=0x%08x\n",
+			    le16_to_cpu(*addr), le32_to_cpu(*data_a));
+
+	addr = (const void *)data_a;
+	data_a = (const void *)(addr + c2h_rpt->cnt_bbmcucr);
+	for (idx = 0; idx < c2h_rpt->cnt_bbmcucr; idx++, addr++, data_a++)
+		rtw89_debug(rtwdev, RTW89_DBG_PS,
+			    "LPS BBMCU - 0x%04x=0x%08x\n",
+			    le16_to_cpu(*addr), le32_to_cpu(*data_a));
+
+	addr = (const void *)data_a;
+	data_a = (const void *)(addr + c2h_rpt->cnt_rfcr);
+	data_b = (const void *)(data_a + c2h_rpt->cnt_rfcr);
+	for (idx = 0; idx < c2h_rpt->cnt_rfcr; idx++, addr++, data_a++, data_b++)
+		rtw89_debug(rtwdev, RTW89_DBG_PS,
+			    "LPS RFCR - 0x%04x=0x%05x,0x%05x\n",
+			    le16_to_cpu(*addr), le32_to_cpu(*data_a),
+			    le32_to_cpu(*data_b));
+}
+
 static void
 rtw89_phy_c2h_fw_scan_rpt(struct rtw89_dev *rtwdev, struct sk_buff *c2h, u32 len)
 {
@@ -3238,6 +3296,7 @@ void (* const rtw89_phy_c2h_dm_handler[])(struct rtw89_dev *rtwdev,
 	[RTW89_PHY_C2H_DM_FUNC_SIGB] = NULL,
 	[RTW89_PHY_C2H_DM_FUNC_LOWRT_RTY] = rtw89_phy_c2h_lowrt_rty,
 	[RTW89_PHY_C2H_DM_FUNC_MCC_DIG] = NULL,
+	[RTW89_PHY_C2H_DM_FUNC_LPS] = rtw89_phy_c2h_lps_rpt,
 	[RTW89_PHY_C2H_DM_FUNC_FW_SCAN] = rtw89_phy_c2h_fw_scan_rpt,
 };
 
diff --git a/drivers/net/wireless/realtek/rtw89/phy.h b/drivers/net/wireless/realtek/rtw89/phy.h
index 9caacffd0af8..5c6df5bfbe10 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.h
+++ b/drivers/net/wireless/realtek/rtw89/phy.h
@@ -165,6 +165,7 @@ enum rtw89_phy_c2h_dm_func {
 	RTW89_PHY_C2H_DM_FUNC_SIGB,
 	RTW89_PHY_C2H_DM_FUNC_LOWRT_RTY,
 	RTW89_PHY_C2H_DM_FUNC_MCC_DIG,
+	RTW89_PHY_C2H_DM_FUNC_LPS = 0x9,
 	RTW89_PHY_C2H_DM_FUNC_FW_SCAN = 0xc,
 	RTW89_PHY_C2H_DM_FUNC_NUM,
 };
-- 
2.25.1


