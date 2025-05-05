Return-Path: <linux-wireless+bounces-22434-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0FABAA8CF6
	for <lists+linux-wireless@lfdr.de>; Mon,  5 May 2025 09:25:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B9591722BC
	for <lists+linux-wireless@lfdr.de>; Mon,  5 May 2025 07:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E10821DB365;
	Mon,  5 May 2025 07:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="bwIM2Cp/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C49F1DED4A
	for <linux-wireless@vger.kernel.org>; Mon,  5 May 2025 07:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746429910; cv=none; b=Y4fg7GUYDpWq3XYhYETuVIOHAxelJ8S2ILZmftyij0C1ipwE3KWcJPbPrqsYgoKjpiAN4kZLqZDZg4d2Ps23/cRQyeOt6gv0hurSubwxd0uLUa53UXXNfdyoS9kQK/+uBGqVW4bcb+ZUqBX473AImMkNSGmpSxso8lYmPsyYY0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746429910; c=relaxed/simple;
	bh=LAPkI3mQD+zOLMJ8kB0XrUmNqSSgNnHEYZLSUYn0WAM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tMQoSP5710TON+HARawQgc33h6KF23biAlviVEa8J5WHkO5lnnRoqplz53Q8zt6Fedr585OeW5pZr3DKdBFs3z+fqLIE32B4in451mc68KHRhHVl5iyVKHSKtczzKcodl4pVAq7ZHDaj08cMpyu4ECKzVUwWuJSnG/ux/DsrqD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=bwIM2Cp/; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 5457P6sS43831165, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1746429906; bh=LAPkI3mQD+zOLMJ8kB0XrUmNqSSgNnHEYZLSUYn0WAM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=bwIM2Cp/CgzBr/hvQ2PDyeNLBltxN91RPFEQPQt/jPadem6aBXSOqY3Bn1XN5tqdk
	 TDxhfPv79X6T0k75V+th117By/eA/odsncnbea80+o9O9dC1gfaE7kG7axLWqyDZUQ
	 SBQdKouGg1gbYPTpb7SLahZySVRUqjG/KAAlwJyXsXV0he6bfZf8nplHqIJraXyPzc
	 SYbq98JSgkh7SphcDmVsHebLgEOhDWrV/8qRaO3whY2boJPRKqX3SEAkpyww+VRf4V
	 pGrtHoPsIRp1Gpo6+/r4oCdKK+pJAImojBVcYL4A+jYytSPXysUw+TkpaGNqbeHTNV
	 Spx/wYX40rYGg==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 5457P6sS43831165
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 5 May 2025 15:25:06 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 5 May 2025 15:25:06 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 5 May
 2025 15:25:05 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <phhuang@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 04/11] wifi: rtw89: chan: re-calculate MLO DBCC mode during setting channel
Date: Mon, 5 May 2025 15:24:33 +0800
Message-ID: <20250505072440.45113-5-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250505072440.45113-1-pkshih@realtek.com>
References: <20250505072440.45113-1-pkshih@realtek.com>
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

From: Zong-Zhe Yang <kevin_yang@realtek.com>

Wi-Fi 7 chips have dual HW bands. After impending MLO support, they
can work with HW-[0] / HW-[1] / HW-[0,1] according to active links.
So, during setting channel, also re-calculate the MLO DBCC mode flag.
Then, leaf chip functions of setting channel can configure with HWs
based on current case.

Besides, tweak the initial and idle MLO DBCC mode of Wi-Fi 7 chips to
MLO_1_PLUS_1_1RF to work with dual HW bands. And, after disconnecting,
due to no active links, MLO DBCC mode will re-calculate to idle case,
i.e. MLO_1_PLUS_1_1RF.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/chan.c | 32 +++++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/core.c |  2 +-
 2 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/chan.c b/drivers/net/wireless/realtek/rtw89/chan.c
index 4fec61ed3454..871befa63889 100644
--- a/drivers/net/wireless/realtek/rtw89/chan.c
+++ b/drivers/net/wireless/realtek/rtw89/chan.c
@@ -359,12 +359,41 @@ const struct rtw89_chan *__rtw89_mgnt_chan_get(struct rtw89_dev *rtwdev,
 }
 EXPORT_SYMBOL(__rtw89_mgnt_chan_get);
 
+static enum rtw89_mlo_dbcc_mode
+rtw89_entity_sel_mlo_dbcc_mode(struct rtw89_dev *rtwdev, u8 active_hws)
+{
+	if (rtwdev->chip->chip_gen != RTW89_CHIP_BE)
+		return MLO_DBCC_NOT_SUPPORT;
+
+	switch (active_hws) {
+	case BIT(0):
+		return MLO_2_PLUS_0_1RF;
+	case BIT(1):
+		return MLO_0_PLUS_2_1RF;
+	case BIT(0) | BIT(1):
+	default:
+		return MLO_1_PLUS_1_1RF;
+	}
+}
+
+static
+void rtw89_entity_recalc_mlo_dbcc_mode(struct rtw89_dev *rtwdev, u8 active_hws)
+{
+	enum rtw89_mlo_dbcc_mode mode;
+
+	mode = rtw89_entity_sel_mlo_dbcc_mode(rtwdev, active_hws);
+	rtwdev->mlo_dbcc_mode = mode;
+
+	rtw89_debug(rtwdev, RTW89_DBG_STATE, "recalc mlo dbcc mode to %d\n", mode);
+}
+
 static void rtw89_entity_recalc_mgnt_roles(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_hal *hal = &rtwdev->hal;
 	struct rtw89_entity_mgnt *mgnt = &hal->entity_mgnt;
 	struct rtw89_vif_link *link;
 	struct rtw89_vif *role;
+	u8 active_hws = 0;
 	u8 pos = 0;
 	int i, j;
 
@@ -413,10 +442,13 @@ static void rtw89_entity_recalc_mgnt_roles(struct rtw89_dev *rtwdev)
 				continue;
 
 			mgnt->chanctx_tbl[pos][i] = link->chanctx_idx;
+			active_hws |= BIT(i);
 		}
 
 		mgnt->active_roles[pos++] = role;
 	}
+
+	rtw89_entity_recalc_mlo_dbcc_mode(rtwdev, active_hws);
 }
 
 enum rtw89_entity_mode rtw89_entity_recalc(struct rtw89_dev *rtwdev)
diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index c5bb3452946e..1546e3d8e2e0 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -4966,7 +4966,7 @@ int rtw89_core_init(struct rtw89_dev *rtwdev)
 	if (rtwdev->chip->chip_gen == RTW89_CHIP_BE) {
 		rtwdev->dbcc_en = true;
 		rtwdev->mac.qta_mode = RTW89_QTA_DBCC;
-		rtwdev->mlo_dbcc_mode = MLO_2_PLUS_0_1RF;
+		rtwdev->mlo_dbcc_mode = MLO_1_PLUS_1_1RF;
 	}
 
 	rtwdev->bbs[RTW89_PHY_0].phy_idx = RTW89_PHY_0;
-- 
2.25.1


