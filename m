Return-Path: <linux-wireless+bounces-30389-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1446DCF6951
	for <lists+linux-wireless@lfdr.de>; Tue, 06 Jan 2026 04:14:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 38E18304BE5C
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Jan 2026 03:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E63F8224AF2;
	Tue,  6 Jan 2026 03:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="pD7ZPmue"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1EA1145B3E
	for <linux-wireless@vger.kernel.org>; Tue,  6 Jan 2026 03:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767669020; cv=none; b=WgCcYwXaUb3zXah80I4/HeSLapJCvaFNYyMjGtbTambGGJVNcfxQyYgdcQbzDqYsSUZU8dBEXYHN2ZCRpwCyNFZTTFlc9gaF1vp82FDu86VwXia/NCLqWkM9B2GDRf+sqx58CVQjhWJTOQkroASNnw54HQy+Bn1928gS6CUFjdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767669020; c=relaxed/simple;
	bh=f+ScTsiCwEwrzPMQeENkE5eXkGKZiv5aEm6NXsfu59U=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b6oDfJNB0c2HjFG2KtGoviUSSZUXC00aWeSINz+pQZusytHwTEqqXdlpfJ5YdmSmt49/Qsojn9LDa59o8rdHYI9yNFjK7dNOJKmrDuFMcWjQjqsieMaYHVo7crY1WtyVQnMDXUmvBn6LZJf/06zJJ4gj9sHAqQF3DGcuB9xTBgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=pD7ZPmue; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6063AG8i84169142, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1767669016; bh=IaNKn2n/Rz78BI8k0aeQ97ptCNqkIdkbzc0kRKNkKGk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=pD7ZPmueMD4RPrPKzRz/4GECy/xMPfN2pDvGS3sA78LcU4lXdSCqIwyl9peRYMd5q
	 YkmKWeFEuZubOfUtO7vMuv8CLHQPIcaHNqS+K5JBb0v5CFlwhjuPWKVyemd6KpuLZP
	 zlcnsQTmMjroTRchFd/vt17TK59XdGOtaPQ3HK+uJRMxCRIulLSPYjnvxc1D5Leb2b
	 48AHhmT5pWgFUusXhvEeUIA9tTVlySB1WT4rrM8ZyO38MDjEaS8pDnlfvY8+x5wb/A
	 dfGwR3/jzaVYREa0u7lUxhPHn5jVNZSe63o7GVJOLbDdgBC7TTtTNQ0no10mLXEBi2
	 TzryNS795Z2eQ==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 6063AG8i84169142
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 6 Jan 2026 11:10:16 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 6 Jan 2026 11:10:16 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 6 Jan 2026 11:10:16 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS04.realtek.com.tw
 (10.21.1.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Tue, 6 Jan 2026 11:10:16 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH rtw-next v2 08/10] wifi: rtw89: fw: add CMAC H2C command for punctured for RTL8922D
Date: Tue, 6 Jan 2026 11:09:09 +0800
Message-ID: <20260106030911.15528-9-pkshih@realtek.com>
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
update CMAC function block while puncturing is changing.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.c | 42 +++++++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/fw.h |  3 ++
 2 files changed, 45 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 300d70ac22f8..587b1ba0b14a 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -4293,6 +4293,48 @@ int rtw89_fw_h2c_punctured_cmac_tbl_g7(struct rtw89_dev *rtwdev,
 }
 EXPORT_SYMBOL(rtw89_fw_h2c_punctured_cmac_tbl_g7);
 
+int rtw89_fw_h2c_punctured_cmac_tbl_be(struct rtw89_dev *rtwdev,
+				       struct rtw89_vif_link *rtwvif_link,
+				       u16 punctured)
+{
+	struct rtw89_h2c_cctlinfo_ud_be *h2c;
+	u32 len = sizeof(*h2c);
+	struct sk_buff *skb;
+	int ret;
+
+	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, len);
+	if (!skb) {
+		rtw89_err(rtwdev, "failed to alloc skb for punctured cmac be\n");
+		return -ENOMEM;
+	}
+	skb_put(skb, len);
+	h2c = (struct rtw89_h2c_cctlinfo_ud_be *)skb->data;
+
+	h2c->c0 = le32_encode_bits(rtwvif_link->mac_id, BE_CCTL_INFO_C0_V1_MACID) |
+		  le32_encode_bits(1, BE_CCTL_INFO_C0_V1_OP);
+
+	h2c->w4 = le32_encode_bits(~punctured, BE_CCTL_INFO_W4_ACT_SUBCH_CBW);
+	h2c->m4 = cpu_to_le32(BE_CCTL_INFO_W4_ACT_SUBCH_CBW);
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
+EXPORT_SYMBOL(rtw89_fw_h2c_punctured_cmac_tbl_be);
+
 int rtw89_fw_h2c_txpath_cmac_tbl(struct rtw89_dev *rtwdev,
 				 struct rtw89_sta_link *rtwsta_link)
 {
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index 2a2d101b9071..4b87d9e777c9 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -5027,6 +5027,9 @@ int rtw89_fw_h2c_txtime_cmac_tbl_be(struct rtw89_dev *rtwdev,
 int rtw89_fw_h2c_punctured_cmac_tbl_g7(struct rtw89_dev *rtwdev,
 				       struct rtw89_vif_link *rtwvif_link,
 				       u16 punctured);
+int rtw89_fw_h2c_punctured_cmac_tbl_be(struct rtw89_dev *rtwdev,
+				       struct rtw89_vif_link *rtwvif_link,
+				       u16 punctured);
 int rtw89_fw_h2c_txpath_cmac_tbl(struct rtw89_dev *rtwdev,
 				 struct rtw89_sta_link *rtwsta_link);
 int rtw89_fw_h2c_update_beacon(struct rtw89_dev *rtwdev,
-- 
2.25.1


