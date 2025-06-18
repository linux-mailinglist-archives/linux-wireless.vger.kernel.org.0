Return-Path: <linux-wireless+bounces-24249-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 405FBADECF7
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Jun 2025 14:47:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C4FB1883972
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Jun 2025 12:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 050AC145FE0;
	Wed, 18 Jun 2025 12:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="CeEniXEs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2142DFF15
	for <linux-wireless@vger.kernel.org>; Wed, 18 Jun 2025 12:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750250854; cv=none; b=s69zN6/DNPwWi9rAKWxbe6wbEU9WIV1x0GPGx3tyw1q6swZWmu6NxmlWbWvqyf4x//mLjZSkIlU+wd3s9NUFkpn7L57QUMK9MltZyPQ7WKPfPna6ioWDvHuscClNZAXRxs71H6DpFvrmpoFXBYJE7BXetBhJfRMWzS2DRhCYWJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750250854; c=relaxed/simple;
	bh=k/GqLLkg0G4HPFqFLGWpmjPXrrdpy/xU8T4iEsIzjjw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mbt0BY6Fjf6xe3vgqkzkvz5rcHjpqaUjjxGkoAB4Qf6Dpg8b07svBAGwYsiFcryw7urgsSJwo5n0LX2zR0KWAlLTuJAEweL1WJNIyev5JzQgmWQpU8VR12BzacsgI156gS4+Iu4SBO/lK2FeOrDxZm5j4IkPj2eCdGqmZej3KN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=CeEniXEs; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 55IClTRE14151151, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1750250849; bh=k4pYUig0/82UjKbyAWMpfnzgmmEIsQ+FVbK1fXnYcAM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=CeEniXEsaZ1NUR6pUq/ENxz56E+hJZoqr+BHBkNTbO8rvq0rofXGcN4zwD8zBS2tw
	 XYa/qyA6+pq172vZ6/rYhV95GRd4ghn+hG37WGqcYeIufwrRSbAzGlnE5dfPkW8gqk
	 gyjqKfYBwL4b3h9PgZI15hKDOIPMEA6Yx0DjcpNCUFm8JniFfMfatoQ69cZZTd+CGo
	 4hSirH44ayTjXUK/m/obflXXZymbW+KiWnvWs2toyq3S9ra88yjX9/r85mgFqK3SSc
	 vtLNiO0ojfEdv2NDEsGEE1qBx8EpRRLbW0DO3i4j1ovJPTltfVazV9ATVhr0J3rl6T
	 ArfLPDBKhzkTA==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 55IClTRE14151151
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 18 Jun 2025 20:47:29 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 18 Jun 2025 20:47:37 +0800
Received: from [127.0.1.1] (10.22.224.135) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 18 Jun
 2025 20:47:34 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <timlee@realtek.com>, <echuang@realtek.com>, <damon.chen@realtek.com>,
        <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 2/6] wifi: rtw89: update EDCCA report for subband 40M/80M/sub-20M
Date: Wed, 18 Jun 2025 20:46:45 +0800
Message-ID: <20250618124649.11436-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250618124649.11436-1-pkshih@realtek.com>
References: <20250618124649.11436-1-pkshih@realtek.com>
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

From: Eric Huang <echuang@realtek.com>

EDCCA report is obtained from the hardware to display OBSS interference
and their respective power levels for each subband. Modify the query
settings to improve resolution for debugging purposes.

Signed-off-by: Eric Huang <echuang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/phy.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index a05841304e0e..f81bee4149bf 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -7128,7 +7128,7 @@ static void rtw89_phy_edcca_log(struct rtw89_dev *rtwdev, struct rtw89_bb_ctx *b
 	const struct rtw89_edcca_p_regs *edcca_p_regs;
 	bool flag_fb, flag_p20, flag_s20, flag_s40, flag_s80;
 	s8 pwdb_fb, pwdb_p20, pwdb_s20, pwdb_s40, pwdb_s80;
-	u8 path, per20_bitmap;
+	u8 path, per20_bitmap = 0;
 	u8 pwdb[8];
 	u32 tmp;
 
@@ -7158,14 +7158,11 @@ static void rtw89_phy_edcca_log(struct rtw89_dev *rtwdev, struct rtw89_bb_ctx *b
 	pwdb_fb = u32_get_bits(tmp, MASKBYTE3);
 
 	rtw89_phy_write32_mask(rtwdev, edcca_p_regs->rpt_sel,
-			       edcca_p_regs->rpt_sel_mask, 4);
+			       edcca_p_regs->rpt_sel_mask, 5);
 	tmp = rtw89_phy_read32(rtwdev, edcca_p_regs->rpt_b);
 	pwdb_s80 = u32_get_bits(tmp, MASKBYTE1);
 	pwdb_s40 = u32_get_bits(tmp, MASKBYTE2);
 
-	per20_bitmap = rtw89_phy_read32_mask(rtwdev, edcca_p_regs->rpt_a,
-					     MASKBYTE0);
-
 	if (rtwdev->chip->chip_id == RTL8922A) {
 		rtw89_phy_write32_mask(rtwdev, edcca_regs->rpt_sel_be,
 				       edcca_regs->rpt_sel_be_mask, 4);
@@ -7174,6 +7171,8 @@ static void rtw89_phy_edcca_log(struct rtw89_dev *rtwdev, struct rtw89_bb_ctx *b
 		pwdb[1] = u32_get_bits(tmp, MASKBYTE2);
 		pwdb[2] = u32_get_bits(tmp, MASKBYTE1);
 		pwdb[3] = u32_get_bits(tmp, MASKBYTE0);
+		per20_bitmap = rtw89_phy_read32_mask(rtwdev, edcca_p_regs->rpt_a,
+						     MASKBYTE0);
 
 		rtw89_phy_write32_mask(rtwdev, edcca_regs->rpt_sel_be,
 				       edcca_regs->rpt_sel_be_mask, 5);
@@ -7190,7 +7189,7 @@ static void rtw89_phy_edcca_log(struct rtw89_dev *rtwdev, struct rtw89_bb_ctx *b
 		pwdb[1] = u32_get_bits(tmp, MASKBYTE2);
 
 		rtw89_phy_write32_mask(rtwdev, edcca_p_regs->rpt_sel,
-				       edcca_p_regs->rpt_sel_mask, 1);
+				       edcca_p_regs->rpt_sel_mask, 5);
 		tmp = rtw89_phy_read32(rtwdev, edcca_p_regs->rpt_a);
 		pwdb[2] = u32_get_bits(tmp, MASKBYTE3);
 		pwdb[3] = u32_get_bits(tmp, MASKBYTE2);
-- 
2.25.1


