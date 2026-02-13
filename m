Return-Path: <linux-wireless+bounces-31802-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EDCtFwLCjmkMEgEAu9opvQ
	(envelope-from <linux-wireless+bounces-31802-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Feb 2026 07:17:38 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC24C133388
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Feb 2026 07:17:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DED373031AE7
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Feb 2026 06:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A66E622D78A;
	Fri, 13 Feb 2026 06:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="dpRi9Gp1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92B251DA62E
	for <linux-wireless@vger.kernel.org>; Fri, 13 Feb 2026 06:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770963454; cv=none; b=Uom7AV012CsaJ0WWrA2hdXlElkZH7Il9uv8ty/hdcBuEk35iZxP+8TayVLRD1OfC0My/YCPZVQSkWRNo7fYabGwz/lNW4O0V3DLQhCvBpz6PEWfHNjvxM08jQL6edqA+Hc1ZN/CJworh3BsbcSx1tOVGtC6AFfje++Nm6yhjGDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770963454; c=relaxed/simple;
	bh=wHNOcG+ser3MRaDAaHqosyrN+WZFClCunLtCfZDEO0w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kl2zIULlzqR/NQ5HGLE2eYrrdxkbV15YNmc1XCkkHv5DBtiud6wgPdMqlVcQE5odqIONZ77aHPVTaZJtzM1zkqv6IeilV/Cq7HfxfNdlESdfn/3fl/GSNcTe2JBKPL2ml0Fx1ZqJfJS/dKGMrC3UOScVVwb1bEkiOqGJ6rc3Z20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=dpRi9Gp1; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 61D6HTLq81419659, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1770963450; bh=zfKHNvB3VJ6qvYqT26gfoQ3tca66hY9tM3wkT3D7aH8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=dpRi9Gp1S5xVGeDbv37TPuDpKR6mC9ROzkZB+vudLjhdoxueqmh9W8cM7LuqcC2tG
	 qsWPalO3Yf13yLgS0wJOHfiCXch+6sfQFaL2a/CqOmcgqtSWNStfit53rvhd4u0cI+
	 XdRXZaJDiU9p3uZXTxF6Y0pJpQ/jpZgoQtxErFvd3CRvXfdOK7+ZpsKHry737KmINI
	 cvBznHT0wXbNXh21EqxnODv3sCaxleVW/nrrXynOuN25G9jF7H/fhNrBEtXflBkxr0
	 EDjQyP8xBARkd/hDO2YUaRKWrp9VJGwTBDZeWj8ta2KyR8vsFJUy+oV+tf9GTWEndJ
	 owi49Cxe8uJ2Q==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 61D6HTLq81419659
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 13 Feb 2026 14:17:30 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 13 Feb 2026 14:17:30 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 13 Feb 2026 14:17:28 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Fri, 13 Feb 2026 14:17:28 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <damon.chen@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 08/12] wifi: rtw89: add H2C command to protect TX/RX for unused PHY
Date: Fri, 13 Feb 2026 14:15:48 +0800
Message-ID: <20260213061552.29997-9-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260213061552.29997-1-pkshih@realtek.com>
References: <20260213061552.29997-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-31802-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[realtek.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,realtek.com:mid,realtek.com:dkim,realtek.com:email];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: EC24C133388
X-Rspamd-Action: no action

From: Kuan-Chung Chen <damon.chen@realtek.com>

For BE chips, the unused PHY should pause transmissions and receptions.
This ensures that no unexpected packets are routed to an inactive PHY,
which could otherwise trigger SER L0 and lead to TX hang.

Signed-off-by: Kuan-Chung Chen <damon.chen@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.c       | 87 +++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/fw.h       | 51 +++++++++++
 drivers/net/wireless/realtek/rtw89/mac.c      |  3 +
 drivers/net/wireless/realtek/rtw89/mac80211.c |  5 ++
 drivers/net/wireless/realtek/rtw89/ps.c       |  2 +
 5 files changed, 148 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 64874907bfe0..bfa5cac24d88 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -6871,6 +6871,93 @@ int rtw89_fw_h2c_scan_offload_be(struct rtw89_dev *rtwdev,
 	return 0;
 }
 
+int rtw89_fw_h2c_trx_protect(struct rtw89_dev *rtwdev,
+			     enum rtw89_phy_idx phy_idx, bool enable)
+{
+	struct rtw89_wait_info *wait = &rtwdev->mac.fw_ofld_wait;
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+	struct rtw89_h2c_trx_protect *h2c;
+	u32 len = sizeof(*h2c);
+	struct sk_buff *skb;
+	int ret;
+
+	if (chip->chip_gen != RTW89_CHIP_BE)
+		return 0;
+
+	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, len);
+	if (!skb) {
+		rtw89_err(rtwdev, "failed to alloc skb for h2c trx protect\n");
+		return -ENOMEM;
+	}
+
+	skb_put(skb, len);
+	h2c = (struct rtw89_h2c_trx_protect *)skb->data;
+
+	h2c->c0 = le32_encode_bits(BIT(phy_idx), RTW89_H2C_TRX_PROTECT_C0_BAND_BITMAP) |
+		  le32_encode_bits(0, RTW89_H2C_TRX_PROTECT_C0_OP_MODE);
+	h2c->c1 = le32_encode_bits(enable, RTW89_H2C_TRX_PROTECT_C1_RX_IN) |
+		  le32_encode_bits(enable, RTW89_H2C_TRX_PROTECT_C1_PPDU_STS) |
+		  le32_encode_bits(1, RTW89_H2C_TRX_PROTECT_C1_MSK_RX_IN) |
+		  le32_encode_bits(1, RTW89_H2C_TRX_PROTECT_C1_MSK_PPDU_STS);
+	h2c->w0 = le32_encode_bits(enable, RTW89_H2C_TRX_PROTECT_W0_TXEN_BE0) |
+		  le32_encode_bits(enable, RTW89_H2C_TRX_PROTECT_W0_TXEN_BK0) |
+		  le32_encode_bits(enable, RTW89_H2C_TRX_PROTECT_W0_TXEN_VI0) |
+		  le32_encode_bits(enable, RTW89_H2C_TRX_PROTECT_W0_TXEN_VO0) |
+		  le32_encode_bits(enable, RTW89_H2C_TRX_PROTECT_W0_TXEN_BE1) |
+		  le32_encode_bits(enable, RTW89_H2C_TRX_PROTECT_W0_TXEN_BK1) |
+		  le32_encode_bits(enable, RTW89_H2C_TRX_PROTECT_W0_TXEN_VI1) |
+		  le32_encode_bits(enable, RTW89_H2C_TRX_PROTECT_W0_TXEN_VO1) |
+		  le32_encode_bits(enable, RTW89_H2C_TRX_PROTECT_W0_TXEN_MG0) |
+		  le32_encode_bits(enable, RTW89_H2C_TRX_PROTECT_W0_TXEN_MG1) |
+		  le32_encode_bits(enable, RTW89_H2C_TRX_PROTECT_W0_TXEN_MG2) |
+		  le32_encode_bits(enable, RTW89_H2C_TRX_PROTECT_W0_TXEN_HI)  |
+		  le32_encode_bits(enable, RTW89_H2C_TRX_PROTECT_W0_TXEN_BCN) |
+		  le32_encode_bits(enable, RTW89_H2C_TRX_PROTECT_W0_TXEN_UL) |
+		  le32_encode_bits(enable, RTW89_H2C_TRX_PROTECT_W0_TXEN_TWT0) |
+		  le32_encode_bits(enable, RTW89_H2C_TRX_PROTECT_W0_TXEN_TWT1) |
+		  le32_encode_bits(enable, RTW89_H2C_TRX_PROTECT_W0_TXEN_TWT2) |
+		  le32_encode_bits(enable, RTW89_H2C_TRX_PROTECT_W0_TXEN_TWT3) |
+		  le32_encode_bits(enable, RTW89_H2C_TRX_PROTECT_W0_TXEN_SPEQ0) |
+		  le32_encode_bits(enable, RTW89_H2C_TRX_PROTECT_W0_TXEN_SPEQ1);
+	h2c->m0 = cpu_to_le32(RTW89_H2C_TRX_PROTECT_W0_TXEN_BE0 |
+			      RTW89_H2C_TRX_PROTECT_W0_TXEN_BK0 |
+			      RTW89_H2C_TRX_PROTECT_W0_TXEN_VI0 |
+			      RTW89_H2C_TRX_PROTECT_W0_TXEN_VO0 |
+			      RTW89_H2C_TRX_PROTECT_W0_TXEN_BE1 |
+			      RTW89_H2C_TRX_PROTECT_W0_TXEN_BK1 |
+			      RTW89_H2C_TRX_PROTECT_W0_TXEN_VI1 |
+			      RTW89_H2C_TRX_PROTECT_W0_TXEN_VO1 |
+			      RTW89_H2C_TRX_PROTECT_W0_TXEN_MG0 |
+			      RTW89_H2C_TRX_PROTECT_W0_TXEN_MG1 |
+			      RTW89_H2C_TRX_PROTECT_W0_TXEN_MG2 |
+			      RTW89_H2C_TRX_PROTECT_W0_TXEN_HI |
+			      RTW89_H2C_TRX_PROTECT_W0_TXEN_BCN |
+			      RTW89_H2C_TRX_PROTECT_W0_TXEN_UL |
+			      RTW89_H2C_TRX_PROTECT_W0_TXEN_TWT0 |
+			      RTW89_H2C_TRX_PROTECT_W0_TXEN_TWT1 |
+			      RTW89_H2C_TRX_PROTECT_W0_TXEN_TWT2 |
+			      RTW89_H2C_TRX_PROTECT_W0_TXEN_TWT3 |
+			      RTW89_H2C_TRX_PROTECT_W0_TXEN_SPEQ0 |
+			      RTW89_H2C_TRX_PROTECT_W0_TXEN_SPEQ1);
+	h2c->w1 = le32_encode_bits(enable, RTW89_H2C_TRX_PROTECT_W1_CHINFO_EN) |
+		  le32_encode_bits(enable, RTW89_H2C_TRX_PROTECT_W1_DFS_EN);
+	h2c->m1 = cpu_to_le32(RTW89_H2C_TRX_PROTECT_W1_CHINFO_EN |
+			      RTW89_H2C_TRX_PROTECT_W1_DFS_EN);
+
+	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
+			      H2C_CAT_MAC, H2C_CL_MAC_FW_OFLD,
+			      H2C_FUNC_TRX_PROTECT, 0, 1, len);
+
+	ret = rtw89_h2c_tx_and_wait(rtwdev, skb, wait,
+				    RTW89_FW_OFLD_WAIT_COND_TRX_PROTECT);
+	if (ret) {
+		rtw89_debug(rtwdev, RTW89_DBG_FW, "failed to trx protect\n");
+		return ret;
+	}
+
+	return 0;
+}
+
 int rtw89_fw_h2c_rf_reg(struct rtw89_dev *rtwdev,
 			struct rtw89_fw_h2c_rf_reg_info *info,
 			u16 len, u8 page)
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index c60d419616d6..80d260eb08cd 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -3106,6 +3106,44 @@ struct rtw89_h2c_scanofld_be {
 #define RTW89_H2C_SCANOFLD_BE_W9_SIZE_MACC GENMASK(15, 8)
 #define RTW89_H2C_SCANOFLD_BE_W9_SIZE_OP GENMASK(23, 16)
 
+struct rtw89_h2c_trx_protect {
+	__le32 c0;
+	__le32 c1;
+	__le32 w0;
+	__le32 m0;
+	__le32 w1;
+	__le32 m1;
+} __packed;
+
+#define RTW89_H2C_TRX_PROTECT_C0_BAND_BITMAP GENMASK(2, 0)
+#define RTW89_H2C_TRX_PROTECT_C0_OP_MODE GENMASK(4, 3)
+#define RTW89_H2C_TRX_PROTECT_C1_RX_IN BIT(0)
+#define RTW89_H2C_TRX_PROTECT_C1_PPDU_STS BIT(4)
+#define RTW89_H2C_TRX_PROTECT_C1_MSK_RX_IN BIT(16)
+#define RTW89_H2C_TRX_PROTECT_C1_MSK_PPDU_STS BIT(20)
+#define RTW89_H2C_TRX_PROTECT_W0_TXEN_BE0 BIT(0)
+#define RTW89_H2C_TRX_PROTECT_W0_TXEN_BK0 BIT(1)
+#define RTW89_H2C_TRX_PROTECT_W0_TXEN_VI0 BIT(2)
+#define RTW89_H2C_TRX_PROTECT_W0_TXEN_VO0 BIT(3)
+#define RTW89_H2C_TRX_PROTECT_W0_TXEN_BE1 BIT(4)
+#define RTW89_H2C_TRX_PROTECT_W0_TXEN_BK1 BIT(5)
+#define RTW89_H2C_TRX_PROTECT_W0_TXEN_VI1 BIT(6)
+#define RTW89_H2C_TRX_PROTECT_W0_TXEN_VO1 BIT(7)
+#define RTW89_H2C_TRX_PROTECT_W0_TXEN_MG0 BIT(8)
+#define RTW89_H2C_TRX_PROTECT_W0_TXEN_MG1 BIT(9)
+#define RTW89_H2C_TRX_PROTECT_W0_TXEN_MG2 BIT(10)
+#define RTW89_H2C_TRX_PROTECT_W0_TXEN_HI BIT(11)
+#define RTW89_H2C_TRX_PROTECT_W0_TXEN_BCN BIT(12)
+#define RTW89_H2C_TRX_PROTECT_W0_TXEN_UL BIT(13)
+#define RTW89_H2C_TRX_PROTECT_W0_TXEN_TWT0 BIT(14)
+#define RTW89_H2C_TRX_PROTECT_W0_TXEN_TWT1 BIT(15)
+#define RTW89_H2C_TRX_PROTECT_W0_TXEN_TWT2 BIT(16)
+#define RTW89_H2C_TRX_PROTECT_W0_TXEN_TWT3 BIT(17)
+#define RTW89_H2C_TRX_PROTECT_W0_TXEN_SPEQ0 BIT(18)
+#define RTW89_H2C_TRX_PROTECT_W0_TXEN_SPEQ1 BIT(19)
+#define RTW89_H2C_TRX_PROTECT_W1_CHINFO_EN BIT(0)
+#define RTW89_H2C_TRX_PROTECT_W1_DFS_EN BIT(1)
+
 struct rtw89_h2c_fwips {
 	__le32 w0;
 } __packed;
@@ -4598,6 +4636,7 @@ enum rtw89_fw_ofld_h2c_func {
 	H2C_FUNC_OFLD_TP		= 0x20,
 	H2C_FUNC_MAC_MACID_PAUSE_SLEEP	= 0x28,
 	H2C_FUNC_SCANOFLD_BE		= 0x2c,
+	H2C_FUNC_TRX_PROTECT		= 0x34,
 
 	NUM_OF_RTW89_FW_OFLD_H2C_FUNC,
 };
@@ -4608,6 +4647,7 @@ enum rtw89_fw_ofld_h2c_func {
 #define RTW89_FW_OFLD_WAIT_COND_PKT_OFLD(pkt_id, pkt_op) \
 	RTW89_FW_OFLD_WAIT_COND(RTW89_PKT_OFLD_WAIT_TAG(pkt_id, pkt_op), \
 				H2C_FUNC_PACKET_OFLD)
+#define RTW89_FW_OFLD_WAIT_COND_TRX_PROTECT RTW89_FW_OFLD_WAIT_COND(0, H2C_FUNC_TRX_PROTECT)
 
 #define RTW89_SCANOFLD_WAIT_COND_ADD_CH RTW89_FW_OFLD_WAIT_COND(0, H2C_FUNC_ADD_SCANOFLD_CH)
 
@@ -5294,6 +5334,8 @@ int rtw89_fw_h2c_scan_offload_be(struct rtw89_dev *rtwdev,
 				 struct rtw89_scan_option *opt,
 				 struct rtw89_vif_link *vif,
 				 bool wowlan);
+int rtw89_fw_h2c_trx_protect(struct rtw89_dev *rtwdev,
+			     enum rtw89_phy_idx phy_idx, bool enable);
 int rtw89_fw_h2c_rf_reg(struct rtw89_dev *rtwdev,
 			struct rtw89_fw_h2c_rf_reg_info *info,
 			u16 len, u8 page);
@@ -5469,6 +5511,15 @@ static inline void rtw89_fw_h2c_init_ba_cam(struct rtw89_dev *rtwdev)
 		rtw89_fw_h2c_init_dynamic_ba_cam_v0_ext(rtwdev);
 }
 
+static inline void rtw89_fw_h2c_init_trx_protect(struct rtw89_dev *rtwdev)
+{
+	u8 active_bands = rtw89_get_active_phy_bitmap(rtwdev);
+	int i;
+
+	for (i = 0; i < RTW89_PHY_NUM; i++)
+		rtw89_fw_h2c_trx_protect(rtwdev, i, active_bands & BIT(i));
+}
+
 static inline int rtw89_chip_h2c_default_cmac_tbl(struct rtw89_dev *rtwdev,
 						  struct rtw89_vif_link *rtwvif_link,
 						  struct rtw89_sta_link *rtwsta_link)
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 8472f1a63951..4d507eccaa00 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -5412,6 +5412,9 @@ rtw89_mac_c2h_done_ack(struct rtw89_dev *rtwdev, struct sk_buff *skb_c2h, u32 le
 			cond = RTW89_SCANOFLD_BE_WAIT_COND_START;
 			h2c_return &= RTW89_C2H_SCAN_DONE_ACK_RETURN;
 			break;
+		case H2C_FUNC_TRX_PROTECT:
+			cond = RTW89_FW_OFLD_WAIT_COND_TRX_PROTECT;
+			break;
 		}
 
 		data.err = !!h2c_return;
diff --git a/drivers/net/wireless/realtek/rtw89/mac80211.c b/drivers/net/wireless/realtek/rtw89/mac80211.c
index 315bb0d0759f..6b8f8bf2234d 100644
--- a/drivers/net/wireless/realtek/rtw89/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw89/mac80211.c
@@ -528,6 +528,8 @@ static int __rtw89_ops_sta_add(struct rtw89_dev *rtwdev,
 	if (vif->type == NL80211_IFTYPE_AP || sta->tdls)
 		rtw89_queue_chanctx_change(rtwdev, RTW89_CHANCTX_REMOTE_STA_CHANGE);
 
+	rtw89_fw_h2c_init_trx_protect(rtwdev);
+
 	return 0;
 
 unset_link:
@@ -1584,6 +1586,8 @@ static void __rtw89_ops_clr_vif_links(struct rtw89_dev *rtwdev,
 		if (unlikely(!rtwvif_link))
 			continue;
 
+		rtw89_fw_h2c_trx_protect(rtwdev, rtwvif_link->phy_idx, false);
+
 		__rtw89_ops_remove_iface_link(rtwdev, rtwvif_link);
 
 		rtw89_vif_unset_link(rtwvif, link_id);
@@ -1609,6 +1613,7 @@ static int __rtw89_ops_set_vif_links(struct rtw89_dev *rtwdev,
 				  __func__, link_id);
 			return ret;
 		}
+		rtw89_fw_h2c_trx_protect(rtwdev, rtwvif_link->phy_idx, true);
 	}
 
 	return 0;
diff --git a/drivers/net/wireless/realtek/rtw89/ps.c b/drivers/net/wireless/realtek/rtw89/ps.c
index aad2ee7926d6..125cf14fa581 100644
--- a/drivers/net/wireless/realtek/rtw89/ps.c
+++ b/drivers/net/wireless/realtek/rtw89/ps.c
@@ -226,6 +226,8 @@ void rtw89_leave_lps(struct rtw89_dev *rtwdev)
 	rtw89_for_each_rtwvif(rtwdev, rtwvif)
 		rtw89_vif_for_each_link(rtwvif, rtwvif_link, link_id)
 			rtw89_leave_lps_vif(rtwdev, rtwvif_link);
+
+	rtw89_fw_h2c_init_trx_protect(rtwdev);
 }
 
 void rtw89_enter_ips(struct rtw89_dev *rtwdev)
-- 
2.25.1


