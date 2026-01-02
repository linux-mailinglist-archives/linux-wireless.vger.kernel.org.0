Return-Path: <linux-wireless+bounces-30276-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EE90CEDF50
	for <lists+linux-wireless@lfdr.de>; Fri, 02 Jan 2026 08:17:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 60CC23016FB5
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Jan 2026 07:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A20793126B8;
	Fri,  2 Jan 2026 07:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="wELzO+9Y"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8AE3311C17
	for <linux-wireless@vger.kernel.org>; Fri,  2 Jan 2026 07:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767337791; cv=none; b=pf+XmnJVnfPZ4IVKWh3q70tZzORK3usahbIYThzor8/D+surQj2wdGHickSZeQ52YbiVT9lymwpp03Vx6AUntvQ2bBmJl5qmynI0gxWYDDMYo9YIxi1HShpKFxl5UoY4AzXxoz1zpaj1rrdIXxzaE3s+fkSAD9kQlDlAM+tItyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767337791; c=relaxed/simple;
	bh=7xcJim39G2f/f+e6dmjFgUej5GIOdqP5Ie5F/bVatiE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TnlMkhTDZKLgvqfchhsbEG55KVZMLBGR2D5IhhJ7mxGJSwqe+pBVQs5Y3wrKRaLlEvrosteRF65oKtFuLohP7adNKNMXEKD3YKkPpB+8+k/wfryI8vAVIeHFwt0RQ5/kshReURQ0D6eCbi59FtFn1SasrCVeOir8Srp+li1lYpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=wELzO+9Y; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 60279kXC2487114, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1767337786; bh=G5wJv0OSgr+yvjQ5e5KM6KjKR1Fd+do2TptxOtl2EgM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=wELzO+9Y+LlOM6P2+5f2d8CSoRmAmM286Z17jGsUb5o49xjbmPWYwwqMcHRSaxnYl
	 Bb9+CvdcpJN8wOEZvn/qcqTasdK19CCUpP/h33srRXJfz2wXsOBNEr0ZIeLFlbloFN
	 zrO1jZTDZhJqlVmYObrl1I2rYTRlpcI6mqu1zzQ/ypC/DlgIe5KUD0GmCfKV/ATn/2
	 1aXTWnkpqOigo80JHkLXmDMX6Ry6hcoImhnF2BPtYyIrzShjbL7e5iR7VY79f0Z2ji
	 RKUricCldOWOq88NCBbdDRxxkaB6IBvpViT7Jp9wHtQ0cLS/Bqtzm+FW9tA7DfV9un
	 SYeVMh79ygeTA==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 60279kXC2487114
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 2 Jan 2026 15:09:46 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 2 Jan 2026 15:09:47 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Fri, 2 Jan 2026 15:09:47 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH rtw-next 09/10] wifi: rtw89: fw: consider hardware AID for firmware elements
Date: Fri, 2 Jan 2026 15:08:39 +0800
Message-ID: <20260102070840.62047-10-pkshih@realtek.com>
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

The coming chip RTL8922D has variant of hardware with different AID. Add
AID field to header of firmware elements, and compare AID with the value
read from hardware.

Currently, apply this rule to BB and RF parameters.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.c | 40 ++++++++++++++++---------
 drivers/net/wireless/realtek/rtw89/fw.h |  3 +-
 2 files changed, 28 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 587b1ba0b14a..3624a0b617e4 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -1023,42 +1023,47 @@ int rtw89_build_phy_tbl_from_elm(struct rtw89_dev *rtwdev,
 				 const union rtw89_fw_element_arg arg)
 {
 	struct rtw89_fw_elm_info *elm_info = &rtwdev->fw.elm_info;
-	struct rtw89_phy_table *tbl;
+	struct rtw89_hal *hal = &rtwdev->hal;
+	struct rtw89_phy_table *tbl, **pp;
 	struct rtw89_reg2_def *regs;
-	enum rtw89_rf_path rf_path;
+	bool radio = false;
 	u32 n_regs, i;
+	u16 aid;
 	u8 idx;
 
-	tbl = kzalloc(sizeof(*tbl), GFP_KERNEL);
-	if (!tbl)
-		return -ENOMEM;
-
 	switch (le32_to_cpu(elm->id)) {
 	case RTW89_FW_ELEMENT_ID_BB_REG:
-		elm_info->bb_tbl = tbl;
+		pp = &elm_info->bb_tbl;
 		break;
 	case RTW89_FW_ELEMENT_ID_BB_GAIN:
-		elm_info->bb_gain = tbl;
+		pp = &elm_info->bb_gain;
 		break;
 	case RTW89_FW_ELEMENT_ID_RADIO_A:
 	case RTW89_FW_ELEMENT_ID_RADIO_B:
 	case RTW89_FW_ELEMENT_ID_RADIO_C:
 	case RTW89_FW_ELEMENT_ID_RADIO_D:
-		rf_path = arg.rf_path;
 		idx = elm->u.reg2.idx;
+		pp = &elm_info->rf_radio[idx];
 
-		elm_info->rf_radio[idx] = tbl;
-		tbl->rf_path = rf_path;
-		tbl->config = rtw89_phy_config_rf_reg_v1;
+		radio = true;
 		break;
 	case RTW89_FW_ELEMENT_ID_RF_NCTL:
-		elm_info->rf_nctl = tbl;
+		pp = &elm_info->rf_nctl;
 		break;
 	default:
-		kfree(tbl);
 		return -ENOENT;
 	}
 
+	aid = le16_to_cpu(elm->aid);
+	if (aid && aid != hal->aid)
+		return 1; /* ignore if aid not matched */
+	else if (*pp)
+		return 1; /* ignore if an element is existing */
+
+	tbl = kzalloc(sizeof(*tbl), GFP_KERNEL);
+	if (!tbl)
+		return -ENOMEM;
+
 	n_regs = le32_to_cpu(elm->size) / sizeof(tbl->regs[0]);
 	regs = kcalloc(n_regs, sizeof(*regs), GFP_KERNEL);
 	if (!regs)
@@ -1072,6 +1077,13 @@ int rtw89_build_phy_tbl_from_elm(struct rtw89_dev *rtwdev,
 	tbl->n_regs = n_regs;
 	tbl->regs = regs;
 
+	if (radio) {
+		tbl->rf_path = arg.rf_path;
+		tbl->config = rtw89_phy_config_rf_reg_v1;
+	}
+
+	*pp = tbl;
+
 	return 0;
 
 out:
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index 4b87d9e777c9..fed1286560de 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -4311,7 +4311,8 @@ struct rtw89_fw_element_hdr {
 	__le32 id; /* enum rtw89_fw_element_id */
 	__le32 size; /* exclude header size */
 	u8 ver[4];
-	__le32 rsvd0;
+	__le16 aid; /* should match rtw89_hal::aid */
+	__le16 rsvd0;
 	__le32 rsvd1;
 	__le32 rsvd2;
 	union {
-- 
2.25.1


