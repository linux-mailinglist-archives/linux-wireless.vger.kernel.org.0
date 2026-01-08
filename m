Return-Path: <linux-wireless+bounces-30547-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 178FDD03A4A
	for <lists+linux-wireless@lfdr.de>; Thu, 08 Jan 2026 16:04:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B12BA3010D72
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Jan 2026 15:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98C7A48380A;
	Thu,  8 Jan 2026 12:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="mvMXbNNh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85DD48381A
	for <linux-wireless@vger.kernel.org>; Thu,  8 Jan 2026 12:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767873822; cv=none; b=L+Z36CFZoRurSTtXG5h8mz2wJovvI7KHs5mnC+gnU+EWS59oAYzkuHLvv9H1+rzLh7q+CNESU/I0o+lS90D3UO6kpxBxVqyFthGiWpv3ouzJVkCI1nr3cidS+xVgWt/oUPyAGCWuOLmqyu4VhGyGi/5ZevTKXEObvWrndUtmE5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767873822; c=relaxed/simple;
	bh=yfBBw31iVxTNI/4jVjZq+1+S8SQZHiifJauRorkVTAs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XS/tOSaLAUUtwafBqzSBTaKDvfUoQneYSsaZz4osO2eHeDNjMzVjLsAtoEBZamkwww5QC4gv+lXTHS4PtUwEoeqFQMs0Zk9SKnHpQr5yNHlRAPDiud0+PXykQLs1JC7r9ftFQ0HRX58eKxXaCliqhXYCpaAvHEC1mVdGUscExXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=mvMXbNNh; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 608C3ZfuC969973, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1767873815; bh=BYds8aVC21GLRew06GIznY5vL3ZZia6nduzzL/0/vwI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=mvMXbNNhqKmGhrvyB7W3LwKPr3JJMd22UxyAFM3Y5hlsYE6v/fMT6E5sVdoauUs/+
	 rK/co4upcUXUVi21uw1Yo/MsCNfl9B0vZuS1I0KMq0q4VXeOI7QCiDQZAKE3Z5cblF
	 wmtDqhEYxy8HHhrkvWHbZyKi4M7jS42+QYmaUn+kn9APg+Bd9trLCfsFxZmTnwQmCG
	 gndvHkenstZDVC9Acz+B6n1zHjfx1yF26vKIy/YerQbPjeZEnbK1Q9Pg2jC2uVe9rX
	 7iJp+XxG20nnkmnfihGDgEZctI/kRaZlF2oat8LHo1PmBhoDpcs1XR+7b7XM5L8Nl8
	 GasyUjSLQiWtQ==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 608C3ZfuC969973
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 8 Jan 2026 20:03:35 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Thu, 8 Jan 2026 20:03:36 +0800
Received: from [127.0.1.1] (172.21.40.76) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Thu, 8 Jan 2026 20:03:36 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <leo.li@realtek.com>
Subject: [PATCH rtw-next 03/13] wifi: rtw89: coex: update coex software control for RTL8922D
Date: Thu, 8 Jan 2026 20:03:10 +0800
Message-ID: <20260108120320.2217402-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260108120320.2217402-1-pkshih@realtek.com>
References: <20260108120320.2217402-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Chia-Yuan Li <leo.li@realtek.com>

Update software control API due to 8922D PTA hardware changes.

Signed-off-by: Chia-Yuan Li <leo.li@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/mac.h    |  2 +
 drivers/net/wireless/realtek/rtw89/mac_be.c | 59 +++++++++++++++++-
 drivers/net/wireless/realtek/rtw89/reg.h    | 69 +++++++++++++++++++++
 3 files changed, 129 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index 79755032df2c..f2882ed23419 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -1358,6 +1358,8 @@ int rtw89_mac_cfg_gnt_v1(struct rtw89_dev *rtwdev,
 			 const struct rtw89_mac_ax_coex_gnt *gnt_cfg);
 int rtw89_mac_cfg_gnt_v2(struct rtw89_dev *rtwdev,
 			 const struct rtw89_mac_ax_coex_gnt *gnt_cfg);
+int rtw89_mac_cfg_gnt_v3(struct rtw89_dev *rtwdev,
+			 const struct rtw89_mac_ax_coex_gnt *gnt_cfg);
 
 static inline
 int rtw89_mac_cfg_plt(struct rtw89_dev *rtwdev, struct rtw89_mac_ax_plt *plt)
diff --git a/drivers/net/wireless/realtek/rtw89/mac_be.c b/drivers/net/wireless/realtek/rtw89/mac_be.c
index 0b29f43b38bd..06538122c57a 100644
--- a/drivers/net/wireless/realtek/rtw89/mac_be.c
+++ b/drivers/net/wireless/realtek/rtw89/mac_be.c
@@ -2003,12 +2003,65 @@ int rtw89_mac_cfg_gnt_v2(struct rtw89_dev *rtwdev,
 }
 EXPORT_SYMBOL(rtw89_mac_cfg_gnt_v2);
 
+int rtw89_mac_cfg_gnt_v3(struct rtw89_dev *rtwdev,
+			 const struct rtw89_mac_ax_coex_gnt *gnt_cfg)
+{
+	u32 val = 0;
+
+	if (gnt_cfg->band[0].gnt_bt)
+		val |= B_BE_PTA_GNT_BT0_BB_VAL | B_BE_PTA_GNT_BT0_RX_BB0_VAL |
+		       B_BE_PTA_GNT_BT0_TX_BB0_VAL;
+
+	if (gnt_cfg->band[0].gnt_bt_sw_en)
+		val |= B_BE_PTA_GNT_BT0_BB_SWCTRL | B_BE_PTA_GNT_BT0_RX_BB0_SWCTRL |
+		       B_BE_PTA_GNT_BT0_TX_BB0_SWCTRL;
+
+	if (gnt_cfg->band[0].gnt_wl)
+		val |= B_BE_PTA_GNT_WL_BB0_VAL;
+
+	if (gnt_cfg->band[0].gnt_wl_sw_en)
+		val |= B_BE_PTA_GNT_WL_BB0_SWCTRL;
+
+	if (gnt_cfg->band[1].gnt_bt)
+		val |= B_BE_PTA_GNT_BT0_BB_VAL | B_BE_PTA_GNT_BT0_RX_BB1_VAL |
+		       B_BE_PTA_GNT_BT0_TX_BB1_VAL;
+
+	if (gnt_cfg->band[1].gnt_bt_sw_en)
+		val |= B_BE_PTA_GNT_BT0_BB_SWCTRL | B_BE_PTA_GNT_BT0_RX_BB1_SWCTRL |
+		       B_BE_PTA_GNT_BT0_TX_BB1_SWCTRL;
+
+	if (gnt_cfg->band[1].gnt_wl)
+		val |= B_BE_PTA_GNT_WL_BB1_VAL;
+
+	if (gnt_cfg->band[1].gnt_wl_sw_en)
+		val |= B_BE_PTA_GNT_WL_BB1_SWCTRL;
+
+	if (gnt_cfg->bt[0].wlan_act_en)
+		val |= B_BE_PTA_WL_ACT0_SWCTRL | B_BE_PTA_WL_ACT_RX_BT0_SWCTRL |
+			   B_BE_PTA_WL_ACT_TX_BT0_SWCTRL;
+	if (gnt_cfg->bt[0].wlan_act)
+		val |= B_BE_PTA_WL_ACT0_VAL | B_BE_PTA_WL_ACT_RX_BT0_VAL |
+			   B_BE_PTA_WL_ACT_TX_BT0_VAL;
+	if (gnt_cfg->bt[1].wlan_act_en)
+		val |= B_BE_PTA_WL_ACT1_SWCTRL | B_BE_PTA_WL_ACT_RX_BT1_SWCTRL |
+			   B_BE_PTA_WL_ACT_TX_BT1_SWCTRL;
+	if (gnt_cfg->bt[1].wlan_act)
+		val |= B_BE_PTA_WL_ACT1_VAL | B_BE_PTA_WL_ACT_RX_BT1_VAL |
+			   B_BE_PTA_WL_ACT_TX_BT1_VAL;
+
+	rtw89_write32(rtwdev, R_BE_PTA_GNT_SW_CTRL, val);
+
+	return 0;
+}
+EXPORT_SYMBOL(rtw89_mac_cfg_gnt_v3);
+
 int rtw89_mac_cfg_ctrl_path_v2(struct rtw89_dev *rtwdev, bool wl)
 {
 	struct rtw89_btc *btc = &rtwdev->btc;
 	struct rtw89_btc_dm *dm = &btc->dm;
 	struct rtw89_mac_ax_gnt *g = dm->gnt.band;
 	struct rtw89_mac_ax_wl_act *gbt = dm->gnt.bt;
+	const struct rtw89_chip_info *chip = rtwdev->chip;
 	int i;
 
 	if (wl)
@@ -2023,7 +2076,11 @@ int rtw89_mac_cfg_ctrl_path_v2(struct rtw89_dev *rtwdev, bool wl)
 		gbt[i].wlan_act_en = 0;
 	}
 
-	return rtw89_mac_cfg_gnt_v2(rtwdev, &dm->gnt);
+	if (chip->chip_id == RTL8922A)
+		return rtw89_mac_cfg_gnt_v2(rtwdev, &dm->gnt);
+	else
+		return rtw89_mac_cfg_gnt_v3(rtwdev, &dm->gnt);
+
 }
 EXPORT_SYMBOL(rtw89_mac_cfg_ctrl_path_v2);
 
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index afe13c0c5629..de36cf5ef1a1 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -6202,6 +6202,75 @@
 #define B_BE_GNT_WL_BB_PWR_VAL BIT(1)
 #define B_BE_GNT_WL_BB_PWR_SWCTRL BIT(0)
 
+#define R_BE_PTA_GNT_SW_CTRL 0x0E348
+#define B_BE_PTA_WL_ACT0_VAL BIT(19)
+#define B_BE_PTA_WL_ACT0_SWCTRL BIT(18)
+#define B_BE_PTA_GNT_BT0_RX_BB1_VAL BIT(17)
+#define B_BE_PTA_GNT_BT0_RX_BB1_SWCTRL BIT(16)
+#define B_BE_PTA_GNT_BT0_TX_BB1_VAL BIT(15)
+#define B_BE_PTA_GNT_BT0_TX_BB1_SWCTRL BIT(14)
+#define B_BE_PTA_GNT_BT0_RX_BB0_VAL BIT(13)
+#define B_BE_PTA_GNT_BT0_RX_BB0_SWCTRL BIT(12)
+#define B_BE_PTA_GNT_BT0_TX_BB0_VAL BIT(11)
+#define B_BE_PTA_GNT_BT0_TX_BB0_SWCTRL BIT(10)
+#define B_BE_PTA_GNT_BT0_BB_VAL BIT(9)
+#define B_BE_PTA_GNT_BT0_BB_SWCTRL BIT(8)
+#define B_BE_PTA_WL_ACT_RX_BT0_VAL BIT(7)
+#define B_BE_PTA_WL_ACT_RX_BT0_SWCTRL BIT(6)
+#define B_BE_PTA_WL_ACT_TX_BT0_VAL BIT(5)
+#define B_BE_PTA_WL_ACT_TX_BT0_SWCTRL BIT(4)
+#define B_BE_PTA_GNT_WL_BB1_VAL BIT(3)
+#define B_BE_PTA_GNT_WL_BB1_SWCTRL BIT(2)
+#define B_BE_PTA_GNT_WL_BB0_VAL BIT(1)
+#define B_BE_PTA_GNT_WL_BB0_SWCTRL BIT(0)
+
+#define R_BE_PTA_GNT_VAL 0x0E34C
+#define B_BE_PTA_WL_ACT2 BIT(20)
+#define B_BE_PTA_GNT_ZB_TX_BB1 BIT(19)
+#define B_BE_PTA_GNT_ZB_TX_BB0 BIT(18)
+#define B_BE_PTA_WL_ACT1 BIT(17)
+#define B_BE_PTA_GNT_BT1_RX_BB1 BIT(16)
+#define B_BE_PTA_GNT_BT1_RX_BB0 BIT(15)
+#define B_BE_PTA_GNT_BT1_TX_BB1 BIT(14)
+#define B_BE_PTA_GNT_BT1_TX_BB0 BIT(13)
+#define B_BE_PTA_WL_ACT_RX_BT1 BIT(12)
+#define B_BE_PTA_WL_ACT_TX_BT1 BIT(11)
+#define B_BE_PTA_GNT_BT1_BB BIT(10)
+#define B_BE_PTA_WL_ACT0 BIT(9)
+#define B_BE_PTA_GNT_BT0_RX_BB1 BIT(8)
+#define B_BE_PTA_GNT_BT0_TX_BB1 BIT(7)
+#define B_BE_PTA_GNT_BT0_RX_BB0 BIT(6)
+#define B_BE_PTA_GNT_BT0_TX_BB0 BIT(5)
+#define B_BE_PTA_GNT_BT0_BB BIT(4)
+#define B_BE_PTA_WL_ACT_RX_BT0 BIT(3)
+#define B_BE_PTA_WL_ACT_TX_BT0 BIT(2)
+#define B_BE_PTA_GNT_WL_BB1 BIT(1)
+#define B_BE_PTA_GNT_WL_BB0 BIT(0)
+
+#define R_BE_PTA_GNT_ZL_SW_CTRL 0x0E350
+#define B_BE_PTA_WL_ACT2_VAL BIT(21)
+#define B_BE_PTA_WL_ACT2_SWCTRL BIT(20)
+#define B_BE_PTA_GNT_ZB_TX_BB1_VAL BIT(19)
+#define B_BE_PTA_GNT_ZB_TX_BB1_SWCTRL BIT(18)
+#define B_BE_PTA_GNT_ZB_TX_BB0_VAL BIT(17)
+#define B_BE_PTA_GNT_ZB_TX_BB0_SWCTRL BIT(16)
+#define B_BE_PTA_WL_ACT1_VAL BIT(15)
+#define B_BE_PTA_WL_ACT1_SWCTRL BIT(14)
+#define B_BE_PTA_GNT_BT1_RX_BB1_VAL BIT(13)
+#define B_BE_PTA_GNT_BT1_RX_BB1_SWCTRL BIT(12)
+#define B_BE_PTA_GNT_BT1_RX_BB0_VAL BIT(11)
+#define B_BE_PTA_GNT_BT1_RX_BB0_SWCTRL BIT(10)
+#define B_BE_PTA_GNT_BT1_TX_BB1_VAL BIT(9)
+#define B_BE_PTA_GNT_BT1_TX_BB1_SWCTRL BIT(8)
+#define B_BE_PTA_GNT_BT1_TX_BB0_VAL BIT(7)
+#define B_BE_PTA_GNT_BT1_TX_BB0_SWCTRL BIT(6)
+#define B_BE_PTA_WL_ACT_RX_BT1_VAL BIT(5)
+#define B_BE_PTA_WL_ACT_RX_BT1_SWCTRL BIT(4)
+#define B_BE_PTA_WL_ACT_TX_BT1_VAL BIT(3)
+#define B_BE_PTA_WL_ACT_TX_BT1_SWCTRL BIT(2)
+#define B_BE_PTA_GNT_BT1_BB_VAL BIT(1)
+#define B_BE_PTA_GNT_BT1_BB_SWCTRL BIT(0)
+
 #define R_BE_PWR_MACID_PATH_BASE 0x0E500
 #define R_BE_PWR_MACID_LMT_BASE 0x0ED00
 
-- 
2.25.1


