Return-Path: <linux-wireless+bounces-3371-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56C7284F06B
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Feb 2024 07:53:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DB9C28A3AE
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Feb 2024 06:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE3D657B8;
	Fri,  9 Feb 2024 06:53:32 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54685657B0
	for <linux-wireless@vger.kernel.org>; Fri,  9 Feb 2024 06:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707461612; cv=none; b=mt7ny3dwFPGw5n8Bmp2VpWwGNYJCoJkgaUDErfCMzoEpGhN+IzWdh+/lubo/dkQV7s5pMfLrr6bxO4RMuIUfWoTd5p1Kq/TRlG8NlIuZQeOrPPVmXZZB4roDq4kEf+RDuUzT4Ep+sZ9NfecckiCgX4qJ807LITln5yTUkatDoHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707461612; c=relaxed/simple;
	bh=WR/sWaGqL5Rtc8crJbcSydW2ejQ96VglCtQ76gZ9oNI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AfowGxHpxIhQwly36Ya2PvZgvsrSzBGKsa80PANCk4Gty+6D6E4D6x2T68QSBem1iU6JCB/MI+SRp2DLbS9QkmHSuOsnUC5Twpii+Eu2HdmncWvRM/kWpSpNdGNWqudtt55J1VRXzn0jppETaeE8gUfXAf59SLGnpHQVuj3GsYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4196rIZE1548386, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 4196rIZE1548386
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 9 Feb 2024 14:53:18 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.17; Fri, 9 Feb 2024 14:53:18 +0800
Received: from [127.0.1.1] (172.16.16.210) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 9 Feb
 2024 14:53:18 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <gary.chang@realtek.com>, <phhuang@realtek.com>, <kevin_yang@realtek.com>,
        <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 01/11] wifi: rtw89: correct PHY register offset for PHY-1
Date: Fri, 9 Feb 2024 14:52:19 +0800
Message-ID: <20240209065229.34515-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240209065229.34515-1-pkshih@realtek.com>
References: <20240209065229.34515-1-pkshih@realtek.com>
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

PHY-1 can be seen as a copy of PHY-0, and the difference is their base
register address, so add a function to get offset to access PHY-1.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/phy.c    | 13 +++++++++----
 drivers/net/wireless/realtek/rtw89/phy.h    |  1 +
 drivers/net/wireless/realtek/rtw89/phy_be.c | 19 +++++++++++++++++++
 3 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index 9a8f5b764617..7c2f0ba996b1 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -13,6 +13,13 @@
 #include "txrx.h"
 #include "util.h"
 
+static u32 rtw89_phy0_phy1_offset(struct rtw89_dev *rtwdev, u32 addr)
+{
+	const struct rtw89_phy_gen_def *phy = rtwdev->chip->phy_def;
+
+	return phy->phy0_phy1_offset(rtwdev, addr);
+}
+
 static u16 get_max_amsdu_len(struct rtw89_dev *rtwdev,
 			     const struct rtw89_ra_report *report)
 {
@@ -1633,14 +1640,11 @@ static void rtw89_phy_init_rf_nctl(struct rtw89_dev *rtwdev)
 		rtw89_rfk_parser(rtwdev, chip->nctl_post_table);
 }
 
-static u32 rtw89_phy0_phy1_offset(struct rtw89_dev *rtwdev, u32 addr)
+static u32 rtw89_phy0_phy1_offset_ax(struct rtw89_dev *rtwdev, u32 addr)
 {
 	u32 phy_page = addr >> 8;
 	u32 ofst = 0;
 
-	if (rtwdev->chip->chip_gen == RTW89_CHIP_BE)
-		return addr < 0x10000 ? 0x20000 : 0;
-
 	switch (phy_page) {
 	case 0x6:
 	case 0x7:
@@ -6392,6 +6396,7 @@ const struct rtw89_phy_gen_def rtw89_phy_gen_ax = {
 	.ccx = &rtw89_ccx_regs_ax,
 	.physts = &rtw89_physts_regs_ax,
 	.cfo = &rtw89_cfo_regs_ax,
+	.phy0_phy1_offset = rtw89_phy0_phy1_offset_ax,
 	.config_bb_gain = rtw89_phy_config_bb_gain_ax,
 	.preinit_rf_nctl = rtw89_phy_preinit_rf_nctl_ax,
 	.bb_wrap_init = NULL,
diff --git a/drivers/net/wireless/realtek/rtw89/phy.h b/drivers/net/wireless/realtek/rtw89/phy.h
index d80ddc723e86..76234daab896 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.h
+++ b/drivers/net/wireless/realtek/rtw89/phy.h
@@ -510,6 +510,7 @@ struct rtw89_phy_gen_def {
 	const struct rtw89_ccx_regs *ccx;
 	const struct rtw89_physts_regs *physts;
 	const struct rtw89_cfo_regs *cfo;
+	u32 (*phy0_phy1_offset)(struct rtw89_dev *rtwdev, u32 addr);
 	void (*config_bb_gain)(struct rtw89_dev *rtwdev,
 			       const struct rtw89_reg2_def *reg,
 			       enum rtw89_rf_path rf_path,
diff --git a/drivers/net/wireless/realtek/rtw89/phy_be.c b/drivers/net/wireless/realtek/rtw89/phy_be.c
index 6849438a5f3c..be0148f2b96f 100644
--- a/drivers/net/wireless/realtek/rtw89/phy_be.c
+++ b/drivers/net/wireless/realtek/rtw89/phy_be.c
@@ -78,6 +78,24 @@ static const struct rtw89_cfo_regs rtw89_cfo_regs_be = {
 	.valid_0_mask = B_DCFO_OPT_EN_V1,
 };
 
+static u32 rtw89_phy0_phy1_offset_be(struct rtw89_dev *rtwdev, u32 addr)
+{
+	u32 phy_page = addr >> 8;
+	u32 ofst = 0;
+
+	if ((phy_page >= 0x4 && phy_page <= 0xF) ||
+	    (phy_page >= 0x20 && phy_page <= 0x2B) ||
+	    (phy_page >= 0x40 && phy_page <= 0x4f) ||
+	    (phy_page >= 0x60 && phy_page <= 0x6f) ||
+	    (phy_page >= 0xE4 && phy_page <= 0xE5) ||
+	    (phy_page >= 0xE8 && phy_page <= 0xED))
+		ofst = 0x1000;
+	else
+		ofst = 0x0;
+
+	return ofst;
+}
+
 union rtw89_phy_bb_gain_arg_be {
 	u32 addr;
 	struct {
@@ -952,6 +970,7 @@ const struct rtw89_phy_gen_def rtw89_phy_gen_be = {
 	.ccx = &rtw89_ccx_regs_be,
 	.physts = &rtw89_physts_regs_be,
 	.cfo = &rtw89_cfo_regs_be,
+	.phy0_phy1_offset = rtw89_phy0_phy1_offset_be,
 	.config_bb_gain = rtw89_phy_config_bb_gain_be,
 	.preinit_rf_nctl = rtw89_phy_preinit_rf_nctl_be,
 	.bb_wrap_init = rtw89_phy_bb_wrap_init_be,
-- 
2.25.1


