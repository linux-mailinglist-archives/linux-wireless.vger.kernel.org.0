Return-Path: <linux-wireless+bounces-28953-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E7AC5B764
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Nov 2025 07:05:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 070F03A4D65
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Nov 2025 06:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A80C25C80D;
	Fri, 14 Nov 2025 06:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="gCYMB5gQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D082DE719
	for <linux-wireless@vger.kernel.org>; Fri, 14 Nov 2025 06:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763100160; cv=none; b=NWwoGWPw8bJh2wdZAn3aP0WO142wbZLn0AX/8BpHXcvYrdjTIJI2oQgFkD+Q258zGeQ0kEsNJlH1nwZdnNTGeeGUt2AYJV4RbuEc2QgWS12/X2A1gRG1zp9yrsVnnKhSfKmigYO+KDOQghjbjoVl63dDCIx+hsp4HFGPgOS12mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763100160; c=relaxed/simple;
	bh=UrKsaSR/5DaBThwNisC8oJAN1R7m517S+rm6ZL8gg/w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iyegWic3STe2lK20nBwwSmB7IYCYBJ03kcoJZQWPug4ZR7CNGyUrnFRkUz6uT4wGeFBdBTVBgzs6ZLE3F+f6z3h4+KQlCs94eMp0+UN1qoUNMhoxToazkcTyXZFdHNbpPd4XcrYv63/FWQ2GoDLeWeUdhFlxfdX53XKbdPh7Iso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=gCYMB5gQ; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5AE62abV61038279, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1763100156; bh=8B+G7/22sgHw1J1OxvzokdeYqH/mNxA7cA0RLOOZPDo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=gCYMB5gQXTgjIDeypEQn0BJNxF5b3OjZiN4aCN00cvWzG/8smmjAV27rZWW/1hD6m
	 KcSHHvpJmo4NEOfozTo8dp5InpLTaOXljwi2Rhd3RowMfHNYNZ/tI82a2yDOhnpcO2
	 mKMLEd2z2NvmTZ5my53vCbxBFpGd9QKWNqiowtXXElkc0JJamkzubgh5S4LP4kyuWi
	 KPm0oWPw/R4NYswHaiGnoTUbqlHTJTAV1cBJpfYZyS7HepKs4wBL3K0FbZ7DHM5lzh
	 9aaPYcgnPDq4Pbj8O5FUYXu5lRQxQn61eoO4cWEnvkOhiVGHexHMt6oPP78NriKEOA
	 wro0MUb6aeE+w==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5AE62abV61038279
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 14 Nov 2025 14:02:36 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Fri, 14 Nov 2025 14:02:37 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Fri, 14 Nov 2025 14:02:36 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTKEXHMBS04.realtek.com.tw
 (10.21.1.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27 via Frontend
 Transport; Fri, 14 Nov 2025 14:02:36 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>
Subject: [PATCH v2 rtw-next 06/14] wifi: rtw89: mac: update wcpu_on to download firmware for RTL8922D
Date: Fri, 14 Nov 2025 14:01:20 +0800
Message-ID: <20251114060128.35363-7-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251114060128.35363-1-pkshih@realtek.com>
References: <20251114060128.35363-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The RTL8922D does more settings before downloading firmware, so add them
accordingly. Also, update the missed settings for RTL8922A.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2: use rtw89_write32() to write R_BE_SECURE_BOOT_MALLOC_INFO
---
 drivers/net/wireless/realtek/rtw89/mac_be.c |  7 +++++++
 drivers/net/wireless/realtek/rtw89/reg.h    | 23 +++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/mac_be.c b/drivers/net/wireless/realtek/rtw89/mac_be.c
index c3620db8aff6..556e5f98e8d4 100644
--- a/drivers/net/wireless/realtek/rtw89/mac_be.c
+++ b/drivers/net/wireless/realtek/rtw89/mac_be.c
@@ -458,6 +458,7 @@ static void set_cpu_en(struct rtw89_dev *rtwdev, bool include_bb)
 
 static int wcpu_on(struct rtw89_dev *rtwdev, u8 boot_reason, bool dlfw)
 {
+	const struct rtw89_chip_info *chip = rtwdev->chip;
 	u32 val32;
 	int ret;
 
@@ -479,6 +480,7 @@ static int wcpu_on(struct rtw89_dev *rtwdev, u8 boot_reason, bool dlfw)
 
 	rtw89_write32(rtwdev, R_BE_UDM1, 0);
 	rtw89_write32(rtwdev, R_BE_UDM2, 0);
+	rtw89_write32(rtwdev, R_BE_BOOT_DBG, 0x0);
 	rtw89_write32(rtwdev, R_BE_HALT_H2C, 0);
 	rtw89_write32(rtwdev, R_BE_HALT_C2H, 0);
 	rtw89_write32(rtwdev, R_BE_HALT_H2C_CTRL, 0);
@@ -493,6 +495,11 @@ static int wcpu_on(struct rtw89_dev *rtwdev, u8 boot_reason, bool dlfw)
 			  B_BE_WDT_WAKE_PCIE_EN | B_BE_WDT_WAKE_USB_EN);
 	rtw89_write32_clr(rtwdev, R_BE_WCPU_FW_CTRL,
 			  B_BE_WDT_PLT_RST_EN | B_BE_WCPU_ROM_CUT_GET);
+	rtw89_write32(rtwdev, R_BE_SECURE_BOOT_MALLOC_INFO, 0);
+	rtw89_write32_clr(rtwdev, R_BE_GPIO_MUXCFG, B_BE_BOOT_MODE);
+
+	if (chip->chip_id != RTL8922A)
+		rtw89_write32_set(rtwdev, R_BE_WCPU_FW_CTRL, B_BE_HOST_EXIST);
 
 	rtw89_write16_mask(rtwdev, R_BE_BOOT_REASON, B_BE_BOOT_REASON_MASK, boot_reason);
 	rtw89_write32_clr(rtwdev, R_BE_PLATFORM_ENABLE, B_BE_WCPU_EN);
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 152fd8366dd7..5b4a459cf29c 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -3963,6 +3963,24 @@
 #define R_BE_EFUSE_CTRL_1_V1 0x0034
 #define B_BE_EF_DATA_MASK GENMASK(31, 0)
 
+#define R_BE_GPIO_MUXCFG 0x0040
+#define B_BE_WCPU_AUTO_EN BIT(26)
+#define B_BE_WCPU_JTAG_EN BIT(24)
+#define B_BE_WCPU_DBG_EN BIT(23)
+#define B_BE_JTAG_CHAIN_EN BIT(20)
+#define B_BE_BOOT_MODE BIT(19)
+#define B_BE_WL_EECS_EXT_32K_SEL BIT(18)
+#define B_BE_WL_SEC_BONDING_OPT_STS BIT(17)
+#define B_BE_SECSIC_SEL BIT(16)
+#define B_BE_ENHTP BIT(14)
+#define B_BE_ENSIC BIT(12)
+#define B_BE_SIC_SWRST BIT(11)
+#define B_BE_PINMUX_PTA_EN BIT(10)
+#define B_BE_WL_BT_PTA_SEC BIT(9)
+#define B_BE_ENUARTTX BIT(8)
+#define B_BE_DBG_GNT_BT_S1_POLARITY BIT(4)
+#define B_BE_ENUARTRX BIT(2)
+
 #define R_BE_GPIO_EXT_CTRL 0x0060
 #define B_BE_GPIO_MOD_15_TO_8_MASK GENMASK(31, 24)
 #define B_BE_GPIO_MOD_9 BIT(25)
@@ -4323,6 +4341,7 @@
 #define B_BE_RUN_ENV_MASK GENMASK(31, 30)
 #define B_BE_WCPU_FWDL_STATUS_MASK GENMASK(29, 26)
 #define B_BE_WDT_PLT_RST_EN BIT(17)
+#define B_BE_HOST_EXIST BIT(16)
 #define B_BE_FW_SEC_AUTH_DONE BIT(14)
 #define B_BE_FW_CPU_UTIL_STS_EN BIT(13)
 #define B_BE_BBMCU1_FWDL_EN BIT(12)
@@ -4599,6 +4618,10 @@
 #define B_BE_HCI_RXDMA_EN BIT(1)
 #define B_BE_HCI_TXDMA_EN BIT(0)
 
+#define R_BE_BOOT_DBG 0x78F0
+#define B_BE_BOOT_STATUS_MASK GENMASK(31, 16)
+#define B_BE_SECUREBOOT_STATUS_MASK GENMASK(15, 0)
+
 #define R_BE_DBG_WOW_READY 0x815E
 #define B_BE_DBG_WOW_READY GENMASK(7, 0)
 
-- 
2.25.1


