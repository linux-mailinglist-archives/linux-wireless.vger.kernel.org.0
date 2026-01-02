Return-Path: <linux-wireless+bounces-30273-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 49715CEDF83
	for <lists+linux-wireless@lfdr.de>; Fri, 02 Jan 2026 08:20:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 454E0304229F
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Jan 2026 07:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A5A1311977;
	Fri,  2 Jan 2026 07:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="PzvVg77+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB3931196F
	for <linux-wireless@vger.kernel.org>; Fri,  2 Jan 2026 07:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767337776; cv=none; b=aTWYNz+sw69C2hUFpdpA28NTUbG8qyfePeRtb05ejxRlz/zwey+9jTTWBaCzTaR6voIrrWJo/han3TBpFFJCL1qge8BO6ZeHMlY+ZhcNldgMUdv2XrJ8SJKTejavY04SOXLicx1AD3M77hUppG+zDn/zjLBIJurXjDlhqiWpuOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767337776; c=relaxed/simple;
	bh=V32QCYpEI9xgMF6XAT+WTVfdsXbTFIRaYg+4zGSZzOY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PXdFVCy1CHQX/t8VJ+8GTA9fFxiCDsY2Q42ptWpNe5SUns11WzHLKMND+4yRBC2vawtOk6YrEsTFkXo5bUAJVxl/1jjaikWEV8cbeqw92DgeYruVz7S1iIrFko0hQOR+5QHgH+6sL3Us3x3uG27cFq0gAvFvOqS6niJONod2VqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=PzvVg77+; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 60279VbF4487035, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1767337771; bh=1NBEdha3CTsK5l+DEvpTiR4gocifN5qhZpU343e8hKA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=PzvVg77+//+V5Q1bVcnCAh8QTrpjkLthzDqohttmDeyMm5rxcJOHPj7c0BGuPuhDF
	 /cSoxriC5gei5Yss3NOuj2UdKmAFDl3xikfveY1ek5OnpNAeluZIlFKVoyfdNTjf9t
	 b3irCTuafPnr9IAmn7dLzWOvIBPlSMGxaNmnkSybDm7c7S7maY5ZnVHgotNPMDf+y1
	 8e60jXuHwstZUbiMZZ5pde1u3IPoZxoCZsJgkjuS5D4j0Y68Dz3m3I3wMg3aeukjgu
	 Herwncj3r/DOA/FeoZtHFupUrHQsqysTpLymGQdQEX3NsjckC03saPhmOQmdvhVb5T
	 K+pLIl57N2gHw==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 60279VbF4487035
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 2 Jan 2026 15:09:31 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 2 Jan 2026 15:09:32 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 2 Jan 2026 15:09:31 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Fri, 2 Jan 2026 15:09:31 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH rtw-next 06/10] wifi: rtw89: fw: add CMAC H2C command for TX AMPDU for RTL8922D
Date: Fri, 2 Jan 2026 15:08:36 +0800
Message-ID: <20260102070840.62047-7-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260102070840.62047-1-pkshih@realtek.com>
References: <20260102070840.62047-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

CMAC H2C command is to configure CMAC such as TX retry and padding. Add to
update CMAC function block while AMPDU is established.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.c | 66 +++++++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/fw.h |  3 ++
 2 files changed, 69 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index c0cbbe299b98..082c7d1a9ac5 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -4033,6 +4033,72 @@ int rtw89_fw_h2c_ampdu_cmac_tbl_g7(struct rtw89_dev *rtwdev,
 }
 EXPORT_SYMBOL(rtw89_fw_h2c_ampdu_cmac_tbl_g7);
 
+int rtw89_fw_h2c_ampdu_cmac_tbl_be(struct rtw89_dev *rtwdev,
+				   struct rtw89_vif_link *rtwvif_link,
+				   struct rtw89_sta_link *rtwsta_link)
+{
+	struct rtw89_sta *rtwsta = rtwsta_link->rtwsta;
+	struct rtw89_h2c_cctlinfo_ud_be *h2c;
+	u32 len = sizeof(*h2c);
+	struct sk_buff *skb;
+	u16 agg_num = 0;
+	u8 ba_bmap = 0;
+	int ret;
+	u8 tid;
+
+	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, len);
+	if (!skb) {
+		rtw89_err(rtwdev, "failed to alloc skb for ampdu cmac be\n");
+		return -ENOMEM;
+	}
+	skb_put(skb, len);
+	h2c = (struct rtw89_h2c_cctlinfo_ud_be *)skb->data;
+
+	for_each_set_bit(tid, rtwsta->ampdu_map, IEEE80211_NUM_TIDS) {
+		if (agg_num == 0)
+			agg_num = rtwsta->ampdu_params[tid].agg_num;
+		else
+			agg_num = min(agg_num, rtwsta->ampdu_params[tid].agg_num);
+	}
+
+	if (agg_num <= 0x20)
+		ba_bmap = 3;
+	else if (agg_num > 0x20 && agg_num <= 0x40)
+		ba_bmap = 0;
+	else if (agg_num > 0x40 && agg_num <= 0x80)
+		ba_bmap = 1;
+	else if (agg_num > 0x80 && agg_num <= 0x100)
+		ba_bmap = 2;
+	else if (agg_num > 0x100 && agg_num <= 0x200)
+		ba_bmap = 4;
+	else if (agg_num > 0x200 && agg_num <= 0x400)
+		ba_bmap = 5;
+
+	h2c->c0 = le32_encode_bits(rtwsta_link->mac_id, BE_CCTL_INFO_C0_V1_MACID) |
+		  le32_encode_bits(1, BE_CCTL_INFO_C0_V1_OP);
+
+	h2c->w3 = le32_encode_bits(ba_bmap, BE_CCTL_INFO_W3_BA_BMAP);
+	h2c->m3 = cpu_to_le32(BE_CCTL_INFO_W3_BA_BMAP);
+
+	rtw89_h2c_pkt_set_hdr(rtwdev, skb, FWCMD_TYPE_H2C,
+			      H2C_CAT_MAC, H2C_CL_MAC_FR_EXCHG,
+			      H2C_FUNC_MAC_CCTLINFO_UD_G7, 0, 0,
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
+EXPORT_SYMBOL(rtw89_fw_h2c_ampdu_cmac_tbl_be);
+
 int rtw89_fw_h2c_txtime_cmac_tbl(struct rtw89_dev *rtwdev,
 				 struct rtw89_sta_link *rtwsta_link)
 {
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index cd9d12dd1700..4976cb81a0d4 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -5015,6 +5015,9 @@ int rtw89_fw_h2c_assoc_cmac_tbl_be(struct rtw89_dev *rtwdev,
 int rtw89_fw_h2c_ampdu_cmac_tbl_g7(struct rtw89_dev *rtwdev,
 				   struct rtw89_vif_link *rtwvif_link,
 				   struct rtw89_sta_link *rtwsta_link);
+int rtw89_fw_h2c_ampdu_cmac_tbl_be(struct rtw89_dev *rtwdev,
+				   struct rtw89_vif_link *rtwvif_link,
+				   struct rtw89_sta_link *rtwsta_link);
 int rtw89_fw_h2c_txtime_cmac_tbl(struct rtw89_dev *rtwdev,
 				 struct rtw89_sta_link *rtwsta_link);
 int rtw89_fw_h2c_txtime_cmac_tbl_g7(struct rtw89_dev *rtwdev,
-- 
2.25.1


