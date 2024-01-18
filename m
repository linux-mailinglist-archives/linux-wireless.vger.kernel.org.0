Return-Path: <linux-wireless+bounces-2144-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E416883156F
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jan 2024 10:05:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AED01F25CCC
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jan 2024 09:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 738F2134C3;
	Thu, 18 Jan 2024 09:04:55 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F8820B02
	for <linux-wireless@vger.kernel.org>; Thu, 18 Jan 2024 09:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705568695; cv=none; b=mFl2KM3DMm4zrvfenfthIG1AF1Lyj4mcutcNIm5BEg42zigRInU+SY7Yaw9MuDWbJ6bCcpFzgsRu/GbYOc2ejpUv7FNmJmyAoHZqpKVQeank4Nndw8x46w2EUqq4ANGTrHFSUsLlTq4PcHyfjBZPCXhgHLf/WLQt2lx6/2qUtzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705568695; c=relaxed/simple;
	bh=/fxWUQcrEXohj4h3G6WuKGyImmC8ZHzB73EEUTvfrbE=;
	h=X-SpamFilter-By:Received:Received:Received:From:To:CC:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy; b=kcjdBwR9pqO0BomUeE2rDoup1ZFOiAAW4OlryXTucSFQcJQqkUNYsaBXMq4b2yJXw0fG2TWffG3DVfTvlEzMe/YNyEF6CJJuFtbWoLf7Bb6K6Nl9KHWELggCU0dKVGjUPNIXsnmyH3OH8aGtBT6cM9+jymuIENj198Ne0UdArmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 40I94lt861580085, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 40I94lt861580085
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Jan 2024 17:04:47 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.17; Thu, 18 Jan 2024 17:04:47 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 18 Jan
 2024 17:04:46 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <hsuan8331@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 2/6] wifi: rtw89: 8922a: add chip_ops::{enable,disable}_bb_rf
Date: Thu, 18 Jan 2024 17:04:09 +0800
Message-ID: <20240118090413.130989-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240118090413.130989-1-pkshih@realtek.com>
References: <20240118090413.130989-1-pkshih@realtek.com>
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

When we are going to up interface to make connection, turn on BB and RF
hardware power by enable_bb_rf ops. Oppositely, using disable_bb_rf to
turn them off.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/reg.h      | 36 +++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/rtw8922a.c | 19 ++++++++++
 2 files changed, 55 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index b411bf726849..c4a9ddeb38e0 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -4488,6 +4488,42 @@
 #define B_BE_RMAC_PPDU_HANG_CNT_MASK GENMASK(23, 16)
 #define B_BE_SER_L0_COUNTER_MASK GENMASK(8, 0)
 
+#define R_BE_DMAC_SYS_CR32B 0x842C
+#define B_BE_DMAC_BB_PHY1_MASK GENMASK(31, 16)
+#define B_BE_DMAC_BB_PHY0_MASK GENMASK(15, 0)
+#define B_BE_DMAC_BB_CTRL_39 BIT(31)
+#define B_BE_DMAC_BB_CTRL_38 BIT(30)
+#define B_BE_DMAC_BB_CTRL_37 BIT(29)
+#define B_BE_DMAC_BB_CTRL_36 BIT(28)
+#define B_BE_DMAC_BB_CTRL_35 BIT(27)
+#define B_BE_DMAC_BB_CTRL_34 BIT(26)
+#define B_BE_DMAC_BB_CTRL_33 BIT(25)
+#define B_BE_DMAC_BB_CTRL_32 BIT(24)
+#define B_BE_DMAC_BB_CTRL_31 BIT(23)
+#define B_BE_DMAC_BB_CTRL_30 BIT(22)
+#define B_BE_DMAC_BB_CTRL_29 BIT(21)
+#define B_BE_DMAC_BB_CTRL_28 BIT(20)
+#define B_BE_DMAC_BB_CTRL_27 BIT(19)
+#define B_BE_DMAC_BB_CTRL_26 BIT(18)
+#define B_BE_DMAC_BB_CTRL_25 BIT(17)
+#define B_BE_DMAC_BB_CTRL_24 BIT(16)
+#define B_BE_DMAC_BB_CTRL_23 BIT(15)
+#define B_BE_DMAC_BB_CTRL_22 BIT(14)
+#define B_BE_DMAC_BB_CTRL_21 BIT(13)
+#define B_BE_DMAC_BB_CTRL_20 BIT(12)
+#define B_BE_DMAC_BB_CTRL_19 BIT(11)
+#define B_BE_DMAC_BB_CTRL_18 BIT(10)
+#define B_BE_DMAC_BB_CTRL_17 BIT(9)
+#define B_BE_DMAC_BB_CTRL_16 BIT(8)
+#define B_BE_DMAC_BB_CTRL_15 BIT(7)
+#define B_BE_DMAC_BB_CTRL_14 BIT(6)
+#define B_BE_DMAC_BB_CTRL_13 BIT(5)
+#define B_BE_DMAC_BB_CTRL_12 BIT(4)
+#define B_BE_DMAC_BB_CTRL_11 BIT(3)
+#define B_BE_DMAC_BB_CTRL_10 BIT(2)
+#define B_BE_DMAC_BB_CTRL_9 BIT(1)
+#define B_BE_DMAC_BB_CTRL_8 BIT(0)
+
 #define R_BE_DLE_EMPTY0 0x8430
 #define B_BE_PLE_EMPTY_QTA_DMAC_H2D BIT(27)
 #define B_BE_PLE_EMPTY_QTA_DMAC_CPUIO BIT(26)
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a.c b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
index 070d0c716659..53c6826e8226 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
@@ -807,6 +807,23 @@ static void rtw8922a_set_channel(struct rtw89_dev *rtwdev,
 	rtw8922a_set_channel_bb(rtwdev, chan, phy_idx);
 }
 
+static int rtw8922a_mac_enable_bb_rf(struct rtw89_dev *rtwdev)
+{
+	rtw89_write8_set(rtwdev, R_BE_FEN_RST_ENABLE,
+			 B_BE_FEN_BBPLAT_RSTB | B_BE_FEN_BB_IP_RSTN);
+	rtw89_write32(rtwdev, R_BE_DMAC_SYS_CR32B, 0x7FF97FF9);
+
+	return 0;
+}
+
+static int rtw8922a_mac_disable_bb_rf(struct rtw89_dev *rtwdev)
+{
+	rtw89_write8_clr(rtwdev, R_BE_FEN_RST_ENABLE,
+			 B_BE_FEN_BBPLAT_RSTB | B_BE_FEN_BB_IP_RSTN);
+
+	return 0;
+}
+
 #ifdef CONFIG_PM
 static const struct wiphy_wowlan_support rtw_wowlan_stub_8922a = {
 	.flags = WIPHY_WOWLAN_MAGIC_PKT | WIPHY_WOWLAN_DISCONNECT,
@@ -817,6 +834,8 @@ static const struct wiphy_wowlan_support rtw_wowlan_stub_8922a = {
 #endif
 
 static const struct rtw89_chip_ops rtw8922a_chip_ops = {
+	.enable_bb_rf		= rtw8922a_mac_enable_bb_rf,
+	.disable_bb_rf		= rtw8922a_mac_disable_bb_rf,
 	.set_channel		= rtw8922a_set_channel,
 	.read_efuse		= rtw8922a_read_efuse,
 	.read_phycap		= rtw8922a_read_phycap,
-- 
2.25.1


