Return-Path: <linux-wireless+bounces-30388-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E74DCF694E
	for <lists+linux-wireless@lfdr.de>; Tue, 06 Jan 2026 04:14:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F17B03078DB4
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Jan 2026 03:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8619820A5E5;
	Tue,  6 Jan 2026 03:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="uD9pumiC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC22B258CE5
	for <linux-wireless@vger.kernel.org>; Tue,  6 Jan 2026 03:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767669015; cv=none; b=rDuDHZCkPRVDiyLQ2fepDkFw11JO2sYb6+a0RMGqsW+85JmPWmE4bkrX4Eq3r621lO6FE1GNc2kI5bB0sc2ONDdDJjnR8W4kmmbr1nsC6+wqkLrANULmVtRJ2ZrhHchdB4dPMLwTREKnw51BzOILoBmKlPA9WMs2IvcblNeXZCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767669015; c=relaxed/simple;
	bh=tkygPrqLASlQWy33LPalrbVMkJ3UytdkCz3FWD3X80Y=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E8alwzhJ0zCzG669uEQc9fJ1U5eEDADv4obe0jZvKs5cAFE6UyNHLH7le3vmzn0zr0As+Z8GBJsUz9+GQIza4I13G3G1RegeVM+YrzsDHg81VU2zL6BtA3UPWntl6iJR6UlblCNCK3GEMjSGep4oE7aN53mnem158hA9Fba2j8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=uD9pumiC; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6063ABFj84169116, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1767669011; bh=0fJDdAOwvCGZkdNCHtu4IO+F2/JVWyM/5qptbesiw5g=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=uD9pumiCIaj7jiKOggxfkMTNroupNB+r4j7GdcWr73LkdAhXJEzB2UAwSgSl1aqW5
	 JKKLDBA6T0CuwKYFJUeTGdnjSWnA15nMBbnQ5d1u1g2AVinJm/kcM3qhgS4o3BGaLz
	 RESKShTzRyIym+gYBKkJAdaniqX+/RxfMR/lqf/QwUvxsFxxRE3IxXYYzJ6XXvjAUe
	 oTzMQGhPEjIgTcNVxzJ/oqC8o2hIRLqIWwf7ak+91EgPHcvEBt81A9bRKkwCMQItg3
	 GutZOwuh62jHtmC9mzgVc2oq1icPZMwckJ0NifbdEFkXbnCrLm8Tmp+XRGUBEQqf7o
	 6vHCNZEQ+cUKQ==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 6063ABFj84169116
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 6 Jan 2026 11:10:11 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 6 Jan 2026 11:10:11 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 6 Jan 2026 11:10:11 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Tue, 6 Jan 2026 11:10:11 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH rtw-next v2 07/10] wifi: rtw89: fw: add CMAC H2C command for TX time for RTL8922D
Date: Tue, 6 Jan 2026 11:09:08 +0800
Message-ID: <20260106030911.15528-8-pkshih@realtek.com>
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
update CMAC function block when BT-coex want shorter TX time due to
timeslot assignment, or when MCC want higher retry time to improve
connection rate.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.c | 54 +++++++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/fw.h |  2 +
 2 files changed, 56 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 082c7d1a9ac5..300d70ac22f8 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -4196,6 +4196,60 @@ int rtw89_fw_h2c_txtime_cmac_tbl_g7(struct rtw89_dev *rtwdev,
 }
 EXPORT_SYMBOL(rtw89_fw_h2c_txtime_cmac_tbl_g7);
 
+int rtw89_fw_h2c_txtime_cmac_tbl_be(struct rtw89_dev *rtwdev,
+				    struct rtw89_sta_link *rtwsta_link)
+{
+	struct rtw89_h2c_cctlinfo_ud_be *h2c;
+	u32 len = sizeof(*h2c);
+	struct sk_buff *skb;
+	int ret;
+
+	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, len);
+	if (!skb) {
+		rtw89_err(rtwdev, "failed to alloc skb for txtime_cmac_be\n");
+		return -ENOMEM;
+	}
+	skb_put(skb, len);
+	h2c = (struct rtw89_h2c_cctlinfo_ud_be *)skb->data;
+
+	h2c->c0 = le32_encode_bits(rtwsta_link->mac_id, BE_CCTL_INFO_C0_V1_MACID) |
+		  le32_encode_bits(1, BE_CCTL_INFO_C0_V1_OP);
+
+	if (rtwsta_link->cctl_tx_time) {
+		h2c->w3 |= le32_encode_bits(1, BE_CCTL_INFO_W3_AMPDU_TIME_SEL);
+		h2c->m3 |= cpu_to_le32(BE_CCTL_INFO_W3_AMPDU_TIME_SEL);
+
+		h2c->w2 |= le32_encode_bits(rtwsta_link->ampdu_max_time,
+					   BE_CCTL_INFO_W2_AMPDU_MAX_TIME);
+		h2c->m2 |= cpu_to_le32(BE_CCTL_INFO_W2_AMPDU_MAX_TIME);
+	}
+	if (rtwsta_link->cctl_tx_retry_limit) {
+		h2c->w2 |= le32_encode_bits(1, BE_CCTL_INFO_W2_DATA_TXCNT_LMT_SEL) |
+			   le32_encode_bits(rtwsta_link->data_tx_cnt_lmt,
+					    BE_CCTL_INFO_W2_DATA_TX_CNT_LMT);
+		h2c->m2 |= cpu_to_le32(BE_CCTL_INFO_W2_DATA_TXCNT_LMT_SEL |
+				       BE_CCTL_INFO_W2_DATA_TX_CNT_LMT);
+	}
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
+EXPORT_SYMBOL(rtw89_fw_h2c_txtime_cmac_tbl_be);
+
 int rtw89_fw_h2c_punctured_cmac_tbl_g7(struct rtw89_dev *rtwdev,
 				       struct rtw89_vif_link *rtwvif_link,
 				       u16 punctured)
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index 4976cb81a0d4..2a2d101b9071 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -5022,6 +5022,8 @@ int rtw89_fw_h2c_txtime_cmac_tbl(struct rtw89_dev *rtwdev,
 				 struct rtw89_sta_link *rtwsta_link);
 int rtw89_fw_h2c_txtime_cmac_tbl_g7(struct rtw89_dev *rtwdev,
 				    struct rtw89_sta_link *rtwsta_link);
+int rtw89_fw_h2c_txtime_cmac_tbl_be(struct rtw89_dev *rtwdev,
+				    struct rtw89_sta_link *rtwsta_link);
 int rtw89_fw_h2c_punctured_cmac_tbl_g7(struct rtw89_dev *rtwdev,
 				       struct rtw89_vif_link *rtwvif_link,
 				       u16 punctured);
-- 
2.25.1


