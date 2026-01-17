Return-Path: <linux-wireless+bounces-30927-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C2F0D38C54
	for <lists+linux-wireless@lfdr.de>; Sat, 17 Jan 2026 05:43:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4CFE93044C1D
	for <lists+linux-wireless@lfdr.de>; Sat, 17 Jan 2026 04:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F202FE567;
	Sat, 17 Jan 2026 04:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="UezQN/2V"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D10918C02E
	for <linux-wireless@vger.kernel.org>; Sat, 17 Jan 2026 04:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768624958; cv=none; b=JArpPl/lAxTJUeZWz+VDlyU67ihyNWBdC9BKot2SFE6jF/oR8vKgJFStb0ipQq0binLtnCHs+dVizyMQJC+vE0gPMfE7B9B2D1Fn1fJqdZOHkPHKTnmkhr565/d+xLspt44oScdeQoODwPbGwE4JE70sKby14pxc04bb02IIpm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768624958; c=relaxed/simple;
	bh=zaD6LkL85oOsDMPLJsU3WJdFaYVHxe753kOoddShgYI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SZ5iaq4h69qzcm8aDD/oaih/k19hnVSJtvbxmca5PDkwleYSuhv0vx6s+U+EsEpVA3s/rVlXEkeIAP3MOHzgHWs3xw6uKykWvc+j71dV+WqZPM3iXDO7iKC6c03pFS5sGyzmvMsWrK1kZlW2iH4r8GwiFK/lIdsgLtQo/ZnuUCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=UezQN/2V; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 60H4gYyR52464497, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1768624954; bh=rsYlFj1/+gx5MtlJr1W/A63eNlkOUgy6umzsH10xGeI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=UezQN/2VFJIXJ8oH/wHznISK6dj3Accra2J8NNBwqghZyA6cBmvGEpVeeAQ8H8sGY
	 HDi/5rQXR5cc7RNSMa5alCs9+/p/6TrecGxY0fBBI+6yaHa/3ranMcKNmnyOArM+f/
	 hhbZDjlk4XAicESkkFCNROG4GA47f9sanLISP+62EfxYV1HcVH1WDtxrOevB4MGEpG
	 gyx8a3Fm3AUmQSsWKG/zYjGHmPmjmIL05UH3KKYC7Q17L17gmJK5wvE4hn0ZmPnzXN
	 k0g3VAttUEbdchhEKCLel+AYXg2NN01edC91rSwMTpA0rMTDm6U59bvLj/82eLcqmF
	 ywe6hcIyR6CkA==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 60H4gYyR52464497
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Sat, 17 Jan 2026 12:42:34 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Sat, 17 Jan 2026 12:42:34 +0800
Received: from [127.0.1.1] (172.21.40.76) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Sat, 17 Jan 2026 12:42:34 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <echuang@realtek.com>, <phhuang@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 7/9] wifi: rtw89: mac: clear DTOP disable excluding CID7090 variant for RTL8922D
Date: Sat, 17 Jan 2026 12:41:55 +0800
Message-ID: <20260117044157.2392958-8-pkshih@realtek.com>
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

The data TX FIFO operation (DTOP) is a hardware component in TMAC circuit
to control TX flow, since CID7090 variant can clear DTOP by default, no
need it by driver.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/mac_be.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/mac_be.c b/drivers/net/wireless/realtek/rtw89/mac_be.c
index 142e892f85c4..e552711ffce4 100644
--- a/drivers/net/wireless/realtek/rtw89/mac_be.c
+++ b/drivers/net/wireless/realtek/rtw89/mac_be.c
@@ -1352,6 +1352,7 @@ static int spatial_reuse_init_be(struct rtw89_dev *rtwdev, u8 mac_idx)
 static int tmac_init_be(struct rtw89_dev *rtwdev, u8 mac_idx)
 {
 	const struct rtw89_chip_info *chip = rtwdev->chip;
+	struct rtw89_hal *hal = &rtwdev->hal;
 	u32 reg;
 
 	reg = rtw89_mac_reg_by_idx(rtwdev, R_BE_TB_PPDU_CTRL, mac_idx);
@@ -1363,7 +1364,7 @@ static int tmac_init_be(struct rtw89_dev *rtwdev, u8 mac_idx)
 		rtw89_write32_mask(rtwdev, reg, B_BE_EHT_HE_PPDU_2XLTF_ZLD_USTIMER_MASK, 0xe);
 	}
 
-	if (chip->chip_id == RTL8922D) {
+	if (chip->chip_id == RTL8922D && hal->cid != RTL8922D_CID7090) {
 		reg = rtw89_mac_reg_by_idx(rtwdev, R_BE_COMMON_PHYINTF_CTRL_0, mac_idx);
 		rtw89_write32_clr(rtwdev, reg, CLEAR_DTOP_DIS);
 	}
-- 
2.25.1


