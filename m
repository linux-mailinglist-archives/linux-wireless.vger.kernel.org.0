Return-Path: <linux-wireless+bounces-30799-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DBF0D1BF82
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jan 2026 02:41:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 430E0300F054
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jan 2026 01:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62CF2874E1;
	Wed, 14 Jan 2026 01:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="slJeb/GC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4792B2EE5F5
	for <linux-wireless@vger.kernel.org>; Wed, 14 Jan 2026 01:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768354860; cv=none; b=Gn6RCzIWzizrykSJOSpIm4rTzejt7K7fnqYchhFlVTIcIADunD8i89sF/lVNkPnWjgMdHPouj+sPOYT+ZHPVghMIhupeuMeSDHHgib7llbt51RHVzynabla5m3NtzFEYK87W0/N+rjWitIiaUOqSdpLyoFQ5NsdeF2fnwu49j7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768354860; c=relaxed/simple;
	bh=C7WaNIBXQe+5wPI36NQqCA4nFVWdT2YzUZtyI+GXAVY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KHWoSrWoKzIxUGDZAahq9UDVsmXGU7yHFxWicKWGNGid5rlWRYVsgG1RMw/p136c2EWTQEbTvQLwLi+cH/s7oS8OxufExtMoAdPT75/RyYe+brnWo4Wm4kOxm2Dl3XAzTlim1+2JRAo842vZbOK+qADpc0cZKiIazhUtxvk/rGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=slJeb/GC; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 60E1euPQ34168596, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1768354856; bh=4PNGsDaJozFrE7lDhtmI8x7botBWKOFvQoAdhfrQPdE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=slJeb/GCh/E2TpxBLNOMoadwSlPW4GlMW20G8r/AJtRBqPDacDXoM/CTR8R2DyjM3
	 8GAJKppoTZIH5HAFqUn837hx7ebkBfgjSPSHYejDfjROwr3W9oTSirgoHv2BxWnoP3
	 GsnJxsEmmc6YqaGCpjdTpYGKRkeDE2bDCT/JEC1fAEiRw4NWaubmObpzNNnAEQeXsR
	 05e7/BJ/actJ/gNWF7R31040l3q1BrxmxQMb6ardF7T58TSI5cg7fx7NiQEi6xMrMk
	 GtnRPPVqDMF0aA2lpDUMxy61cScoFItpm1n5WzR56Yr6doaMcUVvnNSbiGygWuOSDV
	 hI01KZRHc3+Rg==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 60E1euPQ34168596
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 14 Jan 2026 09:40:56 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 14 Jan 2026 09:40:56 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Wed, 14 Jan 2026 09:40:56 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <echuang@realtek.com>, <phhuang@realtek.com>
Subject: [PATCH rtw-next 07/12] wifi: rtw89: phy: update bb wrapper TPU init
Date: Wed, 14 Jan 2026 09:39:45 +0800
Message-ID: <20260114013950.19704-8-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260114013950.19704-1-pkshih@realtek.com>
References: <20260114013950.19704-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Eric Huang <echuang@realtek.com>

Set DBW by rate to on in TPU (TX Power Unit) init, and extend to
initialize two hardware bands.

Signed-off-by: Eric Huang <echuang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/phy_be.c | 23 ++++++++++++++-------
 drivers/net/wireless/realtek/rtw89/reg.h    |  1 +
 2 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/phy_be.c b/drivers/net/wireless/realtek/rtw89/phy_be.c
index e333c3eb1e9b..766ea4404ffc 100644
--- a/drivers/net/wireless/realtek/rtw89/phy_be.c
+++ b/drivers/net/wireless/realtek/rtw89/phy_be.c
@@ -443,14 +443,23 @@ void rtw89_phy_bb_wrap_tx_path_by_macid_init(struct rtw89_dev *rtwdev)
 static void rtw89_phy_bb_wrap_tpu_set_all(struct rtw89_dev *rtwdev,
 					  enum rtw89_mac_idx mac_idx)
 {
-	u32 addr;
+	u32 addr, t;
+
+	addr = rtw89_mac_reg_by_idx(rtwdev, R_BE_PWR_FTM_SS, mac_idx);
+	rtw89_write32_mask(rtwdev, addr, B_BE_PWR_BY_RATE_DBW_ON, 0x3);
 
-	for (addr = R_BE_PWR_BY_RATE; addr <= R_BE_PWR_BY_RATE_END; addr += 4)
-		rtw89_write32(rtwdev, addr, 0);
-	for (addr = R_BE_PWR_RULMT_START; addr <= R_BE_PWR_RULMT_END; addr += 4)
-		rtw89_write32(rtwdev, addr, 0);
-	for (addr = R_BE_PWR_RATE_OFST_CTRL; addr <= R_BE_PWR_RATE_OFST_END; addr += 4)
-		rtw89_write32(rtwdev, addr, 0);
+	for (addr = R_BE_PWR_BY_RATE; addr <= R_BE_PWR_BY_RATE_END; addr += 4) {
+		t = rtw89_mac_reg_by_idx(rtwdev, addr, mac_idx);
+		rtw89_write32(rtwdev, t, 0);
+	}
+	for (addr = R_BE_PWR_RULMT_START; addr <= R_BE_PWR_RULMT_END; addr += 4) {
+		t = rtw89_mac_reg_by_idx(rtwdev, addr, mac_idx);
+		rtw89_write32(rtwdev, t, 0);
+	}
+	for (addr = R_BE_PWR_RATE_OFST_CTRL; addr <= R_BE_PWR_RATE_OFST_END; addr += 4) {
+		t = rtw89_mac_reg_by_idx(rtwdev, addr, mac_idx);
+		rtw89_write32(rtwdev, t, 0);
+	}
 
 	addr = rtw89_mac_reg_by_idx(rtwdev, R_BE_PWR_REF_CTRL, mac_idx);
 	rtw89_write32_mask(rtwdev, addr, B_BE_PWR_OFST_LMT_DB, 0);
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 815b7d08663e..d4f90b22e010 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -8084,6 +8084,7 @@
 
 #define R_BE_PWR_FTM 0x11B00
 #define R_BE_PWR_FTM_SS 0x11B04
+#define B_BE_PWR_BY_RATE_DBW_ON GENMASK(27, 26)
 
 #define R_BE_PWR_BY_RATE 0x11E00
 #define R_BE_PWR_BY_RATE_MAX 0x11FA8
-- 
2.25.1


