Return-Path: <linux-wireless+bounces-30385-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC137CF691E
	for <lists+linux-wireless@lfdr.de>; Tue, 06 Jan 2026 04:11:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 070E53060261
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Jan 2026 03:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B7B145B3E;
	Tue,  6 Jan 2026 03:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="qXN3e2+g"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1244A21D590
	for <linux-wireless@vger.kernel.org>; Tue,  6 Jan 2026 03:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767669000; cv=none; b=Sd/VL3xaqd0qim2sjHtvOPaUqRQMUiQwfdXhwTqxg/Fn0Qud/9BcbyRiroaitjx1OHDUV1bnGWW/92sq9pJAdEiNdIUD5kSF05MTxfiD81UdQKXCWZtjAgPrMGuMCqLRIBUEhFPythzcIGybaHVIIWYWSS74cq+OTegKgZIUJW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767669000; c=relaxed/simple;
	bh=Vno8QdGO4GQBy6wgDdghLKOUVhW2Bowvg570gjM2vzY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jvV2E9Tnd6PEXrsb3BG4Gec8SXGEzKNKoi0COn6jdVQOY/QaGFW1CsFFKZTdgpNPzQBYDrdO5htLgblY00WzEBQRRU8B8B8qyCSY0tjqHBrpqfogUxQr7/4bXG37b0jskIhEqtGpHBWF5/n3fkHrFHkzFF3exA0WQC8XKY2BaXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=qXN3e2+g; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 60639t1Z24169026, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1767668995; bh=eN6fUIFgW5xZdif96zv0kI/mJLlmzCmLuq22FvEZ0qo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=qXN3e2+gHvFlQ9J2hb99/s+Nk4D4nP92SkBbxzaWDL7QEap4Ei1n86E9V6fv7RRb1
	 O7yhYikTJIBP0mFtRpAzy1oFF6l9kcRAX3lRPZD+HWjtbG1DECcF0RFlDN0m/h6IQq
	 xod9Il03hJ50eUYYYWkzSg7yiBei9IEEtdidLuFhabQGGypL6bFwyMGEW2sGmcYCqf
	 Hz9U6F7tLsbu16jlxbjVyQzFPmz7Zbe6jPdcjg6dQQX0XV6lyQnuc47qpT+DlVT8gM
	 S4UnDfl8KIT9oC+qpYHMZAIHUNgbsMLl7NSHPOW/k1EGrBVk32GM4P80VRM315qXLK
	 P1Y2f7+UFpSEA==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 60639t1Z24169026
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 6 Jan 2026 11:09:55 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 6 Jan 2026 11:09:56 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 6 Jan 2026 11:09:55 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Tue, 6 Jan 2026 11:09:55 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH rtw-next v2 04/10] wifi: rtw89: fw: add CMAC H2C command to initialize default value for RTL8922D
Date: Tue, 6 Jan 2026 11:09:05 +0800
Message-ID: <20260106030911.15528-5-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260106030911.15528-1-pkshih@realtek.com>
References: <20260106030911.15528-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

CMAC H2C command is to configure CMAC such as TX retry and padding. Add to
reset CMAC function block to default value.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.c  |  86 +++++++++++++
 drivers/net/wireless/realtek/rtw89/fw.h  | 150 +++++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/mac.h |  12 ++
 3 files changed, 248 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index a8dda05afc3d..b4667097c93f 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -3423,6 +3423,92 @@ int rtw89_fw_h2c_default_cmac_tbl_g7(struct rtw89_dev *rtwdev,
 }
 EXPORT_SYMBOL(rtw89_fw_h2c_default_cmac_tbl_g7);
 
+int rtw89_fw_h2c_default_cmac_tbl_be(struct rtw89_dev *rtwdev,
+				     struct rtw89_vif_link *rtwvif_link,
+				     struct rtw89_sta_link *rtwsta_link)
+{
+	u8 mac_id = rtwsta_link ? rtwsta_link->mac_id : rtwvif_link->mac_id;
+	bool preld = rtw89_mac_chk_preload_allow(rtwdev);
+	struct rtw89_h2c_cctlinfo_ud_be *h2c;
+	u32 len = sizeof(*h2c);
+	struct sk_buff *skb;
+	int ret;
+
+	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, len);
+	if (!skb) {
+		rtw89_err(rtwdev, "failed to alloc skb for default cmac be\n");
+		return -ENOMEM;
+	}
+	skb_put(skb, len);
+	h2c = (struct rtw89_h2c_cctlinfo_ud_be *)skb->data;
+
+	h2c->c0 = le32_encode_bits(mac_id, BE_CCTL_INFO_C0_V1_MACID) |
+		  le32_encode_bits(1, BE_CCTL_INFO_C0_V1_OP);
+
+	h2c->w0 = le32_encode_bits(4, BE_CCTL_INFO_W0_DATARATE);
+	h2c->m0 = cpu_to_le32(BE_CCTL_INFO_W0_ALL);
+
+	h2c->w1 = le32_encode_bits(4, BE_CCTL_INFO_W1_DATA_RTY_LOWEST_RATE) |
+		  le32_encode_bits(0xa, BE_CCTL_INFO_W1_RTSRATE) |
+		  le32_encode_bits(4, BE_CCTL_INFO_W1_RTS_RTY_LOWEST_RATE);
+	h2c->m1 = cpu_to_le32(BE_CCTL_INFO_W1_ALL);
+
+	h2c->w1 = le32_encode_bits(preld, BE_CCTL_INFO_W2_PRELOAD_ENABLE);
+	h2c->m2 = cpu_to_le32(BE_CCTL_INFO_W2_ALL);
+
+	h2c->m3 = cpu_to_le32(BE_CCTL_INFO_W3_ALL);
+
+	h2c->w4 = le32_encode_bits(0xFFFF, BE_CCTL_INFO_W4_ACT_SUBCH_CBW);
+	h2c->m4 = cpu_to_le32(BE_CCTL_INFO_W4_ALL);
+
+	h2c->w5 = le32_encode_bits(2, BE_CCTL_INFO_W5_NOMINAL_PKT_PADDING0_V1) |
+		  le32_encode_bits(2, BE_CCTL_INFO_W5_NOMINAL_PKT_PADDING1_V1) |
+		  le32_encode_bits(2, BE_CCTL_INFO_W5_NOMINAL_PKT_PADDING2_V1) |
+		  le32_encode_bits(2, BE_CCTL_INFO_W5_NOMINAL_PKT_PADDING3_V1) |
+		  le32_encode_bits(2, BE_CCTL_INFO_W5_NOMINAL_PKT_PADDING4_V1);
+	h2c->m5 = cpu_to_le32(BE_CCTL_INFO_W5_ALL);
+
+	h2c->w6 = le32_encode_bits(0xb, BE_CCTL_INFO_W6_RESP_REF_RATE);
+	h2c->m6 = cpu_to_le32(BE_CCTL_INFO_W6_ALL);
+
+	h2c->w7 = le32_encode_bits(1, BE_CCTL_INFO_W7_NC) |
+		  le32_encode_bits(1, BE_CCTL_INFO_W7_NR) |
+		  le32_encode_bits(1, BE_CCTL_INFO_W7_CB) |
+		  le32_encode_bits(0x1, BE_CCTL_INFO_W7_CSI_PARA_EN) |
+		  le32_encode_bits(0xb, BE_CCTL_INFO_W7_CSI_FIX_RATE);
+	h2c->m7 = cpu_to_le32(BE_CCTL_INFO_W7_ALL);
+
+	h2c->m8 = cpu_to_le32(BE_CCTL_INFO_W8_ALL);
+
+	h2c->w14 = le32_encode_bits(0, BE_CCTL_INFO_W14_VO_CURR_RATE) |
+		   le32_encode_bits(0, BE_CCTL_INFO_W14_VI_CURR_RATE) |
+		   le32_encode_bits(0, BE_CCTL_INFO_W14_BE_CURR_RATE_L);
+	h2c->m14 = cpu_to_le32(BE_CCTL_INFO_W14_ALL);
+
+	h2c->w15 = le32_encode_bits(0, BE_CCTL_INFO_W15_BE_CURR_RATE_H) |
+		   le32_encode_bits(0, BE_CCTL_INFO_W15_BK_CURR_RATE) |
+		   le32_encode_bits(0, BE_CCTL_INFO_W15_MGNT_CURR_RATE);
+	h2c->m15 = cpu_to_le32(BE_CCTL_INFO_W15_ALL);
+
+	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
+			      H2C_CAT_MAC, H2C_CL_MAC_FR_EXCHG,
+			      H2C_FUNC_MAC_CCTLINFO_UD_G7, 0, 1,
+			      len);
+
+	ret = rtw89_h2c_tx(rtwdev, skb, false);
+	if (ret) {
+		rtw89_err(rtwdev, "failed to send h2c\n");
+		goto fail;
+	}
+
+	return 0;
+fail:
+	dev_kfree_skb_any(skb);
+
+	return ret;
+}
+EXPORT_SYMBOL(rtw89_fw_h2c_default_cmac_tbl_be);
+
 static void __get_sta_he_pkt_padding(struct rtw89_dev *rtwdev,
 				     struct ieee80211_link_sta *link_sta,
 				     u8 *pads)
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index 479df9df0b28..77f0ca1e9115 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -1518,6 +1518,153 @@ struct rtw89_h2c_cctlinfo_ud_g7 {
 #define CCTLINFO_G7_W15_MGNT_CURR_RATE GENMASK(27, 16)
 #define CCTLINFO_G7_W15_ALL GENMASK(27, 0)
 
+struct rtw89_h2c_cctlinfo_ud_be {
+	__le32 c0;
+	__le32 w0;
+	__le32 w1;
+	__le32 w2;
+	__le32 w3;
+	__le32 w4;
+	__le32 w5;
+	__le32 w6;
+	__le32 w7;
+	__le32 w8;
+	__le32 w9;
+	__le32 w10;
+	__le32 w11;
+	__le32 w12;
+	__le32 w13;
+	__le32 w14;
+	__le32 w15;
+	__le32 m0;
+	__le32 m1;
+	__le32 m2;
+	__le32 m3;
+	__le32 m4;
+	__le32 m5;
+	__le32 m6;
+	__le32 m7;
+	__le32 m8;
+	__le32 m9;
+	__le32 m10;
+	__le32 m11;
+	__le32 m12;
+	__le32 m13;
+	__le32 m14;
+	__le32 m15;
+} __packed;
+
+#define BE_CCTL_INFO_C0_V1_MACID GENMASK(9, 0)
+#define BE_CCTL_INFO_C0_V1_OP BIT(10)
+
+#define BE_CCTL_INFO_W0_DATARATE GENMASK(11, 0)
+#define BE_CCTL_INFO_W0_DATA_GI_LTF GENMASK(14, 12)
+#define BE_CCTL_INFO_W0_TRYRATE BIT(15)
+#define BE_CCTL_INFO_W0_ARFR_CTRL GENMASK(17, 16)
+#define BE_CCTL_INFO_W0_DIS_HE1SS_STBC BIT(18)
+#define BE_CCTL_INFO_W0_ACQ_RPT_EN BIT(20)
+#define BE_CCTL_INFO_W0_MGQ_RPT_EN BIT(21)
+#define BE_CCTL_INFO_W0_ULQ_RPT_EN BIT(22)
+#define BE_CCTL_INFO_W0_TWTQ_RPT_EN BIT(23)
+#define BE_CCTL_INFO_W0_FORCE_TXOP BIT(24)
+#define BE_CCTL_INFO_W0_DISRTSFB BIT(25)
+#define BE_CCTL_INFO_W0_DISDATAFB BIT(26)
+#define BE_CCTL_INFO_W0_NSTR_EN BIT(27)
+#define BE_CCTL_INFO_W0_AMPDU_DENSITY GENMASK(31, 28)
+#define BE_CCTL_INFO_W0_ALL (GENMASK(31, 20) | GENMASK(18, 0))
+#define BE_CCTL_INFO_W1_DATA_RTY_LOWEST_RATE GENMASK(11, 0)
+#define BE_CCTL_INFO_W1_RTS_TXCNT_LMT GENMASK(15, 12)
+#define BE_CCTL_INFO_W1_RTSRATE GENMASK(27, 16)
+#define BE_CCTL_INFO_W1_RTS_RTY_LOWEST_RATE GENMASK(31, 28)
+#define BE_CCTL_INFO_W1_ALL GENMASK(31, 0)
+#define BE_CCTL_INFO_W2_DATA_TX_CNT_LMT GENMASK(5, 0)
+#define BE_CCTL_INFO_W2_DATA_TXCNT_LMT_SEL BIT(6)
+#define BE_CCTL_INFO_W2_MAX_AGG_NUM_SEL BIT(7)
+#define BE_CCTL_INFO_W2_RTS_EN BIT(8)
+#define BE_CCTL_INFO_W2_CTS2SELF_EN BIT(9)
+#define BE_CCTL_INFO_W2_CCA_RTS GENMASK(11, 10)
+#define BE_CCTL_INFO_W2_HW_RTS_EN BIT(12)
+#define BE_CCTL_INFO_W2_RTS_DROP_DATA_MODE GENMASK(14, 13)
+#define BE_CCTL_INFO_W2_PRELOAD_ENABLE BIT(15)
+#define BE_CCTL_INFO_W2_AMPDU_MAX_LEN GENMASK(26, 16)
+#define BE_CCTL_INFO_W2_UL_MU_DIS BIT(27)
+#define BE_CCTL_INFO_W2_AMPDU_MAX_TIME GENMASK(31, 28)
+#define BE_CCTL_INFO_W2_ALL GENMASK(31, 0)
+#define BE_CCTL_INFO_W3_MAX_AGG_NUM GENMASK(7, 0)
+#define BE_CCTL_INFO_W3_DATA_BW GENMASK(10, 8)
+#define BE_CCTL_INFO_W3_DATA_BW_ER BIT(11)
+#define BE_CCTL_INFO_W3_BA_BMAP GENMASK(14, 12)
+#define BE_CCTL_INFO_W3_VCS_STBC BIT(15)
+#define BE_CCTL_INFO_W3_VO_LFTIME_SEL GENMASK(18, 16)
+#define BE_CCTL_INFO_W3_VI_LFTIME_SEL GENMASK(21, 19)
+#define BE_CCTL_INFO_W3_BE_LFTIME_SEL GENMASK(24, 22)
+#define BE_CCTL_INFO_W3_BK_LFTIME_SEL GENMASK(27, 25)
+#define BE_CCTL_INFO_W3_AMPDU_TIME_SEL BIT(28)
+#define BE_CCTL_INFO_W3_AMPDU_LEN_SEL BIT(29)
+#define BE_CCTL_INFO_W3_RTS_TXCNT_LMT_SEL BIT(30)
+#define BE_CCTL_INFO_W3_LSIG_TXOP_EN BIT(31)
+#define BE_CCTL_INFO_W3_ALL GENMASK(31, 0)
+#define BE_CCTL_INFO_W4_MULTI_PORT_ID GENMASK(2, 0)
+#define BE_CCTL_INFO_W4_BYPASS_PUNC BIT(3)
+#define BE_CCTL_INFO_W4_MBSSID GENMASK(7, 4)
+#define BE_CCTL_INFO_W4_TID_DISABLE_V1 GENMASK(15, 8)
+#define BE_CCTL_INFO_W4_ACT_SUBCH_CBW GENMASK(31, 16)
+#define BE_CCTL_INFO_W4_ALL GENMASK(31, 0)
+#define BE_CCTL_INFO_W5_ADDR_CAM_INDEX_V1 GENMASK(9, 0)
+#define BE_CCTL_INFO_W5_SR_MCS_SU GENMASK(14, 10)
+#define BE_CCTL_INFO_W5_A_CTRL_BQR_V1 BIT(15)
+#define BE_CCTL_INFO_W5_A_CTRL_BSR_V1 BIT(16)
+#define BE_CCTL_INFO_W5_A_CTRL_CAS_V1 BIT(17)
+#define BE_CCTL_INFO_W5_DATA_ER_V1 BIT(18)
+#define BE_CCTL_INFO_W5_DATA_DCM_V1 BIT(19)
+#define BE_CCTL_INFO_W5_DATA_LDPC_V1 BIT(20)
+#define BE_CCTL_INFO_W5_DATA_STBC_V1 BIT(21)
+#define BE_CCTL_INFO_W5_NOMINAL_PKT_PADDING0_V1 GENMASK(23, 22)
+#define BE_CCTL_INFO_W5_NOMINAL_PKT_PADDING1_V1 GENMASK(25, 24)
+#define BE_CCTL_INFO_W5_NOMINAL_PKT_PADDING2_V1 GENMASK(27, 26)
+#define BE_CCTL_INFO_W5_NOMINAL_PKT_PADDING3_V1 GENMASK(29, 28)
+#define BE_CCTL_INFO_W5_NOMINAL_PKT_PADDING4_V1 GENMASK(31, 30)
+#define BE_CCTL_INFO_W5_ALL GENMASK(31, 0)
+#define BE_CCTL_INFO_W6_AID12_PAID GENMASK(11, 0)
+#define BE_CCTL_INFO_W6_RESP_REF_RATE GENMASK(23, 12)
+#define BE_CCTL_INFO_W6_ULDL BIT(31)
+#define BE_CCTL_INFO_W6_ALL (BIT(31) | GENMASK(23, 0))
+#define BE_CCTL_INFO_W7_NC GENMASK(2, 0)
+#define BE_CCTL_INFO_W7_NR GENMASK(5, 3)
+#define BE_CCTL_INFO_W7_NG GENMASK(7, 6)
+#define BE_CCTL_INFO_W7_CB GENMASK(9, 8)
+#define BE_CCTL_INFO_W7_CS GENMASK(11, 10)
+#define BE_CCTL_INFO_W7_CSI_STBC_EN BIT(13)
+#define BE_CCTL_INFO_W7_CSI_LDPC_EN BIT(14)
+#define BE_CCTL_INFO_W7_CSI_PARA_EN BIT(15)
+#define BE_CCTL_INFO_W7_CSI_FIX_RATE GENMASK(27, 16)
+#define BE_CCTL_INFO_W7_CSI_BW GENMASK(31, 29)
+#define BE_CCTL_INFO_W7_ALL GENMASK(31, 0)
+#define BE_CCTL_INFO_W8_ALL_ACK_SUPPORT_V1 BIT(0)
+#define BE_CCTL_INFO_W8_BSR_QUEUE_SIZE_FORMAT_V1 BIT(1)
+#define BE_CCTL_INFO_W8_BSR_OM_UPD_EN_V1 BIT(2)
+#define BE_CCTL_INFO_W8_MACID_FWD_IDC_V1 BIT(3)
+#define BE_CCTL_INFO_W8_AZ_SEC_EN BIT(4)
+#define BE_CCTL_INFO_W8_BF_SEC_EN BIT(5)
+#define BE_CCTL_INFO_W8_FIX_UL_ADDRCAM_IDX_V1 BIT(6)
+#define BE_CCTL_INFO_W8_CTRL_CNT_VLD_V1 BIT(7)
+#define BE_CCTL_INFO_W8_CTRL_CNT_V1 GENMASK(11, 8)
+#define BE_CCTL_INFO_W8_RESP_SEC_TYPE GENMASK(15, 12)
+#define BE_CCTL_INFO_W8_ALL GENMASK(15, 0)
+#define BE_CCTL_INFO_W9_EMLSR_TRANS_DLY GENMASK(2, 0)
+#define BE_CCTL_INFO_W9_ALL GENMASK(2, 0)
+#define BE_CCTL_INFO_W10_SW_EHT_NLTF GENMASK(1, 0)
+#define BE_CCTL_INFO_W10_TB_MLO_MODE BIT(2)
+#define BE_CCTL_INFO_W10_ALL GENMASK(2, 0)
+#define BE_CCTL_INFO_W14_VO_CURR_RATE GENMASK(11, 0)
+#define BE_CCTL_INFO_W14_VI_CURR_RATE GENMASK(23, 12)
+#define BE_CCTL_INFO_W14_BE_CURR_RATE_L GENMASK(31, 24)
+#define BE_CCTL_INFO_W14_ALL GENMASK(31, 0)
+#define BE_CCTL_INFO_W15_BE_CURR_RATE_H GENMASK(3, 0)
+#define BE_CCTL_INFO_W15_BK_CURR_RATE GENMASK(15, 4)
+#define BE_CCTL_INFO_W15_MGNT_CURR_RATE GENMASK(27, 16)
+#define BE_CCTL_INFO_W15_ALL GENMASK(27, 0)
+
 struct rtw89_h2c_bcn_upd {
 	__le32 w0;
 	__le32 w1;
@@ -4847,6 +4994,9 @@ int rtw89_fw_h2c_default_cmac_tbl(struct rtw89_dev *rtwdev,
 int rtw89_fw_h2c_default_cmac_tbl_g7(struct rtw89_dev *rtwdev,
 				     struct rtw89_vif_link *rtwvif_link,
 				     struct rtw89_sta_link *rtwsta_link);
+int rtw89_fw_h2c_default_cmac_tbl_be(struct rtw89_dev *rtwdev,
+				     struct rtw89_vif_link *rtwvif_link,
+				     struct rtw89_sta_link *rtwsta_link);
 int rtw89_fw_h2c_default_dmac_tbl_v2(struct rtw89_dev *rtwdev,
 				     struct rtw89_vif_link *rtwvif_link,
 				     struct rtw89_sta_link *rtwsta_link);
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index 79755032df2c..0d9928f7ac8a 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -1737,4 +1737,16 @@ void rtw89_tx_rpt_skbs_purge(struct rtw89_dev *rtwdev)
 			rtw89_tx_rpt_tx_status(rtwdev, skbs[i],
 					       RTW89_TX_MACID_DROP);
 }
+
+static inline bool rtw89_mac_chk_preload_allow(struct rtw89_dev *rtwdev)
+{
+	if (rtwdev->hci.type != RTW89_HCI_TYPE_PCIE)
+		return false;
+
+	if (rtwdev->chip->chip_id == RTL8922D && rtwdev->hal.cid == RTL8922D_CID7090)
+		return true;
+
+	return false;
+}
+
 #endif
-- 
2.25.1


