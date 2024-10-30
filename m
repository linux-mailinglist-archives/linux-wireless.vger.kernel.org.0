Return-Path: <linux-wireless+bounces-14697-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0C7A9B59DB
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Oct 2024 03:22:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9027128415C
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Oct 2024 02:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CAC2194C6C;
	Wed, 30 Oct 2024 02:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="TxSYVlrY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD42192D98
	for <linux-wireless@vger.kernel.org>; Wed, 30 Oct 2024 02:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730254936; cv=none; b=HLoiZ2stFAT5Z3eHvifhifUuUREdKEPZhv0J2LJR27fWSzs8JdRqx0uUVDGlb8lRJr+lbYnNpA0d3BiEnsH/OabcwfHWs3Osx1lXjA4uzYFtBMblsD2gvzyJrWzXZD0vnAm1mhBx3iqGX1zhrvSA/wBIRrHP9G6G2cAVGG6s1LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730254936; c=relaxed/simple;
	bh=Hr3MC1ql+qDbWjiIuqLHei9LXutGe2p0AHCmlifK6wg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PVNunN/8hPfiBz9b+lsLqIrUs5Sn6H4aAT1LtfaoDOymx/45VdRqNu2P6p3v94tgKbVGX2qXFwoEcTXk/NiOjYlroqDGZAPx2uVmz7WR+8JGB0516UoNrntYRxHHAMa/EEsk6Q2e5UJDD9MHUinb6oMad4dV0SuevkalbcCurDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=TxSYVlrY; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 49U2MBsyC3310595, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1730254931; bh=Hr3MC1ql+qDbWjiIuqLHei9LXutGe2p0AHCmlifK6wg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=TxSYVlrYqqZkfgZ6nyrHw2v5BYj6VbxQScCg1WJEWjLDTXb26er+wDyLnyPXHdOHP
	 qTnHyeitz0FNRVWJ3POJKQt6Nzn74hs+a5JtotORa/ea7XB1GC5CfgUmVX+u3um1id
	 p8OA/2l/Xt2Hx9vEBZqnbc1gMBkf1dYHvX1OE0evPazkGCJg1D7Sm25t620bhmioVW
	 EjIcDlYVBhQy42BDp7PZMI7Wh9p4mhXpQo8U4qyiLWthxDIePdtEVCPBOar1BCrxXo
	 AqIhYrJnLvM15lFgm2BaHttOfY/2zxusmRgqs58m37Fb6UUDJiRUiu6iAmL7rbxoGm
	 QGpx27xQ0/HDg==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 49U2MBsyC3310595
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 30 Oct 2024 10:22:11 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 30 Oct 2024 10:22:11 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 30 Oct
 2024 10:22:10 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH 2/8] wifi: rtw89: efuse: move recognize firmware MSS info v1 to common
Date: Wed, 30 Oct 2024 10:21:29 +0800
Message-ID: <20241030022135.11688-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241030022135.11688-1-pkshih@realtek.com>
References: <20241030022135.11688-1-pkshih@realtek.com>
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

The WiFi 6 chip use the same firmware MSS information v1 read from efuse,
so move this logic to common.

No change logic at all.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/efuse.c    | 59 +++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/efuse.h    |  1 +
 drivers/net/wireless/realtek/rtw89/efuse_be.c | 51 +---------------
 3 files changed, 62 insertions(+), 49 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/efuse.c b/drivers/net/wireless/realtek/rtw89/efuse.c
index 532623130c41..a02b04eecd05 100644
--- a/drivers/net/wireless/realtek/rtw89/efuse.c
+++ b/drivers/net/wireless/realtek/rtw89/efuse.c
@@ -11,11 +11,24 @@
 #define EF_CV_MASK GENMASK(7, 4)
 #define EF_CV_INV 15
 
+#define EFUSE_B1_MSSDEVTYPE_MASK GENMASK(3, 0)
+#define EFUSE_B1_MSSCUSTIDX0_MASK GENMASK(7, 4)
+#define EFUSE_B2_MSSKEYNUM_MASK GENMASK(3, 0)
+#define EFUSE_B2_MSSCUSTIDX1_MASK BIT(6)
+
 enum rtw89_efuse_bank {
 	RTW89_EFUSE_BANK_WIFI,
 	RTW89_EFUSE_BANK_BT,
 };
 
+enum rtw89_efuse_mss_dev_type {
+	MSS_DEV_TYPE_FWSEC_DEF = 0xF,
+	MSS_DEV_TYPE_FWSEC_WINLIN_INBOX = 0xC,
+	MSS_DEV_TYPE_FWSEC_NONLIN_INBOX_NON_COB = 0xA,
+	MSS_DEV_TYPE_FWSEC_NONLIN_INBOX_COB = 0x9,
+	MSS_DEV_TYPE_FWSEC_NONWIN_INBOX = 0x6,
+};
+
 static int rtw89_switch_efuse_bank(struct rtw89_dev *rtwdev,
 				   enum rtw89_efuse_bank bank)
 {
@@ -355,6 +368,52 @@ int rtw89_read_efuse_ver(struct rtw89_dev *rtwdev, u8 *ecv)
 }
 EXPORT_SYMBOL(rtw89_read_efuse_ver);
 
+static u8 get_mss_dev_type_idx(struct rtw89_dev *rtwdev, u8 mss_dev_type)
+{
+	switch (mss_dev_type) {
+	case MSS_DEV_TYPE_FWSEC_WINLIN_INBOX:
+		mss_dev_type = 0x0;
+		break;
+	case MSS_DEV_TYPE_FWSEC_NONLIN_INBOX_NON_COB:
+		mss_dev_type = 0x1;
+		break;
+	case MSS_DEV_TYPE_FWSEC_NONLIN_INBOX_COB:
+		mss_dev_type = 0x2;
+		break;
+	case MSS_DEV_TYPE_FWSEC_NONWIN_INBOX:
+		mss_dev_type = 0x3;
+		break;
+	case MSS_DEV_TYPE_FWSEC_DEF:
+		mss_dev_type = RTW89_FW_MSS_DEV_TYPE_FWSEC_DEF;
+		break;
+	default:
+		rtw89_warn(rtwdev, "unknown mss_dev_type %d", mss_dev_type);
+		mss_dev_type = RTW89_FW_MSS_DEV_TYPE_FWSEC_INV;
+		break;
+	}
+
+	return mss_dev_type;
+}
+
+int rtw89_efuse_recognize_mss_info_v1(struct rtw89_dev *rtwdev, u8 b1, u8 b2)
+{
+	struct rtw89_fw_secure *sec = &rtwdev->fw.sec;
+	u8 mss_dev_type;
+
+	mss_dev_type = u8_get_bits(b1, EFUSE_B1_MSSDEVTYPE_MASK);
+	sec->mss_cust_idx = 0x1F - (u8_get_bits(b1, EFUSE_B1_MSSCUSTIDX0_MASK) |
+				    u8_get_bits(b2, EFUSE_B2_MSSCUSTIDX1_MASK) << 4);
+	sec->mss_key_num = 0xF - u8_get_bits(b2, EFUSE_B2_MSSKEYNUM_MASK);
+
+	sec->mss_dev_type = get_mss_dev_type_idx(rtwdev, mss_dev_type);
+	if (sec->mss_dev_type == RTW89_FW_MSS_DEV_TYPE_FWSEC_INV) {
+		rtw89_warn(rtwdev, "invalid mss_dev_type %d\n", mss_dev_type);
+		return -ENOENT;
+	}
+
+	return 0;
+}
+
 int rtw89_efuse_read_fw_secure_ax(struct rtw89_dev *rtwdev)
 {
 	return 0;
diff --git a/drivers/net/wireless/realtek/rtw89/efuse.h b/drivers/net/wireless/realtek/rtw89/efuse.h
index a2f6f36e697f..a96fc1044791 100644
--- a/drivers/net/wireless/realtek/rtw89/efuse.h
+++ b/drivers/net/wireless/realtek/rtw89/efuse.h
@@ -23,6 +23,7 @@ int rtw89_parse_efuse_map_be(struct rtw89_dev *rtwdev);
 int rtw89_parse_phycap_map_be(struct rtw89_dev *rtwdev);
 int rtw89_cnv_efuse_state_be(struct rtw89_dev *rtwdev, bool idle);
 int rtw89_read_efuse_ver(struct rtw89_dev *rtwdev, u8 *efv);
+int rtw89_efuse_recognize_mss_info_v1(struct rtw89_dev *rtwdev, u8 b1, u8 b2);
 int rtw89_efuse_read_fw_secure_ax(struct rtw89_dev *rtwdev);
 int rtw89_efuse_read_fw_secure_be(struct rtw89_dev *rtwdev);
 
diff --git a/drivers/net/wireless/realtek/rtw89/efuse_be.c b/drivers/net/wireless/realtek/rtw89/efuse_be.c
index 756aaf886af9..64768923b0f0 100644
--- a/drivers/net/wireless/realtek/rtw89/efuse_be.c
+++ b/drivers/net/wireless/realtek/rtw89/efuse_be.c
@@ -8,11 +8,7 @@
 #include "reg.h"
 
 #define EFUSE_EXTERNALPN_ADDR_BE 0x1580
-#define EFUSE_B1_MSSDEVTYPE_MASK GENMASK(3, 0)
-#define EFUSE_B1_MSSCUSTIDX0_MASK GENMASK(7, 4)
 #define EFUSE_SERIALNUM_ADDR_BE 0x1581
-#define EFUSE_B2_MSSKEYNUM_MASK GENMASK(3, 0)
-#define EFUSE_B2_MSSCUSTIDX1_MASK BIT(6)
 #define EFUSE_SB_CRYP_SEL_ADDR 0x1582
 #define EFUSE_SB_CRYP_SEL_SIZE 2
 #define EFUSE_SB_CRYP_SEL_DEFAULT 0xFFFF
@@ -20,14 +16,6 @@
 #define EFUSE_SEC_BE_START 0x1580
 #define EFUSE_SEC_BE_SIZE 4
 
-enum rtw89_efuse_mss_dev_type {
-	MSS_DEV_TYPE_FWSEC_DEF = 0xF,
-	MSS_DEV_TYPE_FWSEC_WINLIN_INBOX = 0xC,
-	MSS_DEV_TYPE_FWSEC_NONLIN_INBOX_NON_COB = 0xA,
-	MSS_DEV_TYPE_FWSEC_NONLIN_INBOX_COB = 0x9,
-	MSS_DEV_TYPE_FWSEC_NONWIN_INBOX = 0x6,
-};
-
 static const u32 sb_sel_mgn[SB_SEL_MGN_MAX_SIZE] = {
 	0x8000100, 0xC000180
 };
@@ -477,33 +465,6 @@ static u16 get_sb_cryp_sel_idx(u16 sb_cryp_sel)
 	return sb_cryp_sel_v + low_bit;
 }
 
-static u8 get_mss_dev_type_idx(struct rtw89_dev *rtwdev, u8 mss_dev_type)
-{
-	switch (mss_dev_type) {
-	case MSS_DEV_TYPE_FWSEC_WINLIN_INBOX:
-		mss_dev_type = 0x0;
-		break;
-	case MSS_DEV_TYPE_FWSEC_NONLIN_INBOX_NON_COB:
-		mss_dev_type = 0x1;
-		break;
-	case MSS_DEV_TYPE_FWSEC_NONLIN_INBOX_COB:
-		mss_dev_type = 0x2;
-		break;
-	case MSS_DEV_TYPE_FWSEC_NONWIN_INBOX:
-		mss_dev_type = 0x3;
-		break;
-	case MSS_DEV_TYPE_FWSEC_DEF:
-		mss_dev_type = RTW89_FW_MSS_DEV_TYPE_FWSEC_DEF;
-		break;
-	default:
-		rtw89_warn(rtwdev, "unknown mss_dev_type %d", mss_dev_type);
-		mss_dev_type = RTW89_FW_MSS_DEV_TYPE_FWSEC_INV;
-		break;
-	}
-
-	return mss_dev_type;
-}
-
 int rtw89_efuse_read_fw_secure_be(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_fw_secure *sec = &rtwdev->fw.sec;
@@ -511,7 +472,6 @@ int rtw89_efuse_read_fw_secure_be(struct rtw89_dev *rtwdev)
 	u32 sec_size = EFUSE_SEC_BE_SIZE;
 	u16 sb_cryp_sel, sb_cryp_sel_idx;
 	u8 sec_map[EFUSE_SEC_BE_SIZE];
-	u8 mss_dev_type;
 	u8 b1, b2;
 	int ret;
 
@@ -538,16 +498,9 @@ int rtw89_efuse_read_fw_secure_be(struct rtw89_dev *rtwdev)
 	b1 = sec_map[EFUSE_EXTERNALPN_ADDR_BE - sec_addr];
 	b2 = sec_map[EFUSE_SERIALNUM_ADDR_BE - sec_addr];
 
-	mss_dev_type = u8_get_bits(b1, EFUSE_B1_MSSDEVTYPE_MASK);
-	sec->mss_cust_idx = 0x1F - (u8_get_bits(b1, EFUSE_B1_MSSCUSTIDX0_MASK) |
-				    u8_get_bits(b2, EFUSE_B2_MSSCUSTIDX1_MASK) << 4);
-	sec->mss_key_num = 0xF - u8_get_bits(b2, EFUSE_B2_MSSKEYNUM_MASK);
-
-	sec->mss_dev_type = get_mss_dev_type_idx(rtwdev, mss_dev_type);
-	if (sec->mss_dev_type == RTW89_FW_MSS_DEV_TYPE_FWSEC_INV) {
-		rtw89_warn(rtwdev, "invalid mss_dev_type %d\n", mss_dev_type);
+	ret = rtw89_efuse_recognize_mss_info_v1(rtwdev, b1, b2);
+	if (ret)
 		goto out;
-	}
 
 	sec->secure_boot = true;
 
-- 
2.25.1


