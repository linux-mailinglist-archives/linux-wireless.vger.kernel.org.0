Return-Path: <linux-wireless+bounces-30924-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C9E33D38C4B
	for <lists+linux-wireless@lfdr.de>; Sat, 17 Jan 2026 05:42:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5AE35302759E
	for <lists+linux-wireless@lfdr.de>; Sat, 17 Jan 2026 04:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA6A52FE567;
	Sat, 17 Jan 2026 04:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="HsYdbutc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A6118C02E
	for <linux-wireless@vger.kernel.org>; Sat, 17 Jan 2026 04:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768624942; cv=none; b=UFK3svmg8AonaPquBrNjCL/+WtTR3vr6UzCQNLFP7vX0eALGZ0zeNp2PWF7Iydre17wx+yyxzWla+XgEBCOjQlUA+5YzA9rC532tkMknaVlCxWT4GhP5EI9GGDP8n48G8poykd5YaScuc/gJWpC2I5VkFVsD3D0qZopjuYOIu4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768624942; c=relaxed/simple;
	bh=PrfUcjejrwlb7X5xNXEVFdp+trD2YQzAppZD49IUiXA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=egIMIxJzpECl2+THFEdwPJ/fKwBA40upQ1R19VnqO8SagmxMYhCI8iKSyFLBbAETXoMX94YMkgX3/6n9NMLXl/sbFj9WtevQWJtdjSHCUf6s5wqy+F/acHd9YlV5VrUxbJl1xNb9zgwxgOAvCMY4UApC/tZ6egq9SwWDZIgO4dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=HsYdbutc; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 60H4gIMk92464476, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1768624938; bh=D9Y4y1Icdffx/oZEWCk9su33dlCdWrPt7lVSUQhTo0s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=HsYdbutcXb5dRuXmhoyOCrG2B7ajHFsjkDuCTs76+1/Es9GtDgrkWf9uIA1dzx8Pl
	 Zl2VrOBJVm5NqH8PUC+bxr7cxC9APG/D4rF5+iIBcZmzcBT2f5VbhPhrtRRtOEaVYj
	 SMZc9rr+9PwuM43EiPMGREEeeOvC7sUUB6am1iBzAsRDk0a142gH8NmktMYE/oaM7T
	 PW4y1umDKppRFovI8Xuut7Yyv/UpJ0d1NH1xD5roylQS/gkTdqwzYejThHZMWQjJk/
	 Xv/IqIL+d6e1JwmpTaAfYDgO58SG5q+DvyMwMJhxPBdAkAvb5XBTZO0Zevg5NBi/zN
	 m4soYUx8KnfCA==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 60H4gIMk92464476
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Sat, 17 Jan 2026 12:42:18 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Sat, 17 Jan 2026 12:42:19 +0800
Received: from [127.0.1.1] (172.21.40.76) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Sat, 17 Jan 2026 12:42:19 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <echuang@realtek.com>, <phhuang@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 4/9] wifi: rtw89: phy: update edcca log parsing for RTL8922D
Date: Sat, 17 Jan 2026 12:41:52 +0800
Message-ID: <20260117044157.2392958-5-pkshih@realtek.com>
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

Before this change the rtw89_phy_edcca_log routine didn't handled
RTL8922D. This update expands the logic to recognize RTL8922D EDCCA
reports.

Signed-off-by: Eric Huang <echuang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/phy.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index 6059f40f34b3..5c7c76a53d60 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -7838,6 +7838,7 @@ static void rtw89_phy_edcca_log(struct rtw89_dev *rtwdev, struct rtw89_bb_ctx *b
 	bool flag_fb, flag_p20, flag_s20, flag_s40, flag_s80;
 	s8 pwdb_fb, pwdb_p20, pwdb_s20, pwdb_s40, pwdb_s80;
 	u8 path, per20_bitmap = 0;
+	u8 pwdb_sel = 5;
 	u8 pwdb[8];
 	u32 tmp;
 
@@ -7849,12 +7850,14 @@ static void rtw89_phy_edcca_log(struct rtw89_dev *rtwdev, struct rtw89_bb_ctx *b
 	else
 		edcca_p_regs = &edcca_regs->p[RTW89_PHY_0];
 
-	if (rtwdev->chip->chip_id == RTL8922A)
-		rtw89_phy_write32_mask(rtwdev, edcca_regs->rpt_sel_be,
-				       edcca_regs->rpt_sel_be_mask, 0);
-
 	rtw89_phy_write32_mask(rtwdev, edcca_p_regs->rpt_sel,
 			       edcca_p_regs->rpt_sel_mask, 0);
+	if (rtwdev->chip->chip_id == RTL8922A || rtwdev->chip->chip_id == RTL8922D) {
+		rtw89_phy_write32_mask(rtwdev, edcca_regs->rpt_sel_be,
+				       edcca_regs->rpt_sel_be_mask, 0);
+		per20_bitmap = rtw89_phy_read32_mask(rtwdev, edcca_p_regs->rpt_a,
+						     MASKBYTE0);
+	}
 	tmp = rtw89_phy_read32(rtwdev, edcca_p_regs->rpt_b);
 	path = u32_get_bits(tmp, B_EDCCA_RPT_B_PATH_MASK);
 	flag_s80 = u32_get_bits(tmp, B_EDCCA_RPT_B_S80);
@@ -7866,13 +7869,16 @@ static void rtw89_phy_edcca_log(struct rtw89_dev *rtwdev, struct rtw89_bb_ctx *b
 	pwdb_p20 = u32_get_bits(tmp, MASKBYTE2);
 	pwdb_fb = u32_get_bits(tmp, MASKBYTE3);
 
+	if (rtwdev->chip->chip_id == RTL8922D)
+		pwdb_sel = 2;
+
 	rtw89_phy_write32_mask(rtwdev, edcca_p_regs->rpt_sel,
-			       edcca_p_regs->rpt_sel_mask, 5);
+			       edcca_p_regs->rpt_sel_mask, pwdb_sel);
 	tmp = rtw89_phy_read32(rtwdev, edcca_p_regs->rpt_b);
 	pwdb_s80 = u32_get_bits(tmp, MASKBYTE1);
 	pwdb_s40 = u32_get_bits(tmp, MASKBYTE2);
 
-	if (rtwdev->chip->chip_id == RTL8922A) {
+	if (rtwdev->chip->chip_id == RTL8922A || rtwdev->chip->chip_id == RTL8922D) {
 		rtw89_phy_write32_mask(rtwdev, edcca_regs->rpt_sel_be,
 				       edcca_regs->rpt_sel_be_mask, 4);
 		tmp = rtw89_phy_read32(rtwdev, edcca_p_regs->rpt_b);
@@ -7880,8 +7886,6 @@ static void rtw89_phy_edcca_log(struct rtw89_dev *rtwdev, struct rtw89_bb_ctx *b
 		pwdb[1] = u32_get_bits(tmp, MASKBYTE2);
 		pwdb[2] = u32_get_bits(tmp, MASKBYTE1);
 		pwdb[3] = u32_get_bits(tmp, MASKBYTE0);
-		per20_bitmap = rtw89_phy_read32_mask(rtwdev, edcca_p_regs->rpt_a,
-						     MASKBYTE0);
 
 		rtw89_phy_write32_mask(rtwdev, edcca_regs->rpt_sel_be,
 				       edcca_regs->rpt_sel_be_mask, 5);
-- 
2.25.1


