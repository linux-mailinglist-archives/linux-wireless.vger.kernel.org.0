Return-Path: <linux-wireless+bounces-3070-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E99BA847DDE
	for <lists+linux-wireless@lfdr.de>; Sat,  3 Feb 2024 01:33:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A1751C25561
	for <lists+linux-wireless@lfdr.de>; Sat,  3 Feb 2024 00:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB8B31FB4;
	Sat,  3 Feb 2024 00:33:46 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ECCD1C3D
	for <linux-wireless@vger.kernel.org>; Sat,  3 Feb 2024 00:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706920426; cv=none; b=KzRRRst2RgXiB7sVaCDKs6ypqlAkwNeyTir0suxdjnWglWB1784P53zUMIGRMRFSYZAsu+fDyfDwohwbDu9Ts8+AkGhij2v64lYooDuaJdKXr64rGkR0rB6YUCefkInRJN/vgKF4jn8QeqRqLVu0/siZ4F1rlEFjM0/TexLL/6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706920426; c=relaxed/simple;
	bh=LHedwlG44t/AVverNd4u1htiMcFInF0d3KJi8sukOwE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T+v9ZHRrhl8/nQKV03qGlhSUI5Mx0z2AVIdxqk1cPFUxeBtPiDeD5/7KGe/GevlWaIGaLy68PYajfXW9dSkWosELO8dHq1DCtISLbJCTWKD6sJqD+Y74qn9BRkA0/B28evexk0du9FLEfAlpAfQYDbxa8gkCYg+EE2a9kyCkvAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4130XcJG22300748, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 4130XcJG22300748
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 3 Feb 2024 08:33:38 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.32; Sat, 3 Feb 2024 08:33:38 +0800
Received: from [127.0.1.1] (172.16.16.254) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Sat, 3 Feb
 2024 08:33:38 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH 2/4] wifi: rtw89: fw: read firmware secure information from efuse
Date: Sat, 3 Feb 2024 08:32:49 +0800
Message-ID: <20240203003251.10641-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240203003251.10641-1-pkshih@realtek.com>
References: <20240203003251.10641-1-pkshih@realtek.com>
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
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

To support firmware secure boot, read secure information from efuse to
know if current hardware module can support secure boot with certain
cryptography method.

This information should be prepared before downloading firmware, so read
efuse right after power on at probe stage. The secure information includes
secure cryptography method and secure key index that are used to choose
proper key material when downloading firmware.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h     |  15 ++
 drivers/net/wireless/realtek/rtw89/efuse.h    |   1 +
 drivers/net/wireless/realtek/rtw89/efuse_be.c | 142 ++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/pci.c      |   2 +
 drivers/net/wireless/realtek/rtw89/rtw8922a.c |   3 +
 5 files changed, 163 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 30cc77ac78c5..8bbea97c3b1c 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -4030,6 +4030,19 @@ struct rtw89_fw_elm_info {
 	struct rtw89_phy_rfk_log_fmt *rfk_log_fmt;
 };
 
+enum rtw89_fw_mss_dev_type {
+	RTW89_FW_MSS_DEV_TYPE_FWSEC_DEF = 0xF,
+	RTW89_FW_MSS_DEV_TYPE_FWSEC_INV = 0xFF,
+};
+
+struct rtw89_fw_secure {
+	bool secure_boot;
+	u32 sb_sel_mgn;
+	u8 mss_dev_type;
+	u8 mss_cust_idx;
+	u8 mss_key_num;
+};
+
 struct rtw89_fw_info {
 	struct rtw89_fw_req_info req;
 	int fw_format;
@@ -4044,6 +4057,7 @@ struct rtw89_fw_info {
 	struct rtw89_fw_log log;
 	u32 feature_map;
 	struct rtw89_fw_elm_info elm_info;
+	struct rtw89_fw_secure sec;
 };
 
 #define RTW89_CHK_FW_FEATURE(_feat, _fw) \
@@ -4196,6 +4210,7 @@ enum rtw89_flags {
 	RTW89_FLAG_CMAC1_FUNC,
 	RTW89_FLAG_FW_RDY,
 	RTW89_FLAG_RUNNING,
+	RTW89_FLAG_PROBE_DONE,
 	RTW89_FLAG_BFEE_MON,
 	RTW89_FLAG_BFEE_EN,
 	RTW89_FLAG_BFEE_TIMER_KEEP,
diff --git a/drivers/net/wireless/realtek/rtw89/efuse.h b/drivers/net/wireless/realtek/rtw89/efuse.h
index 5c6787179bad..72416f56a071 100644
--- a/drivers/net/wireless/realtek/rtw89/efuse.h
+++ b/drivers/net/wireless/realtek/rtw89/efuse.h
@@ -23,5 +23,6 @@ int rtw89_parse_efuse_map_be(struct rtw89_dev *rtwdev);
 int rtw89_parse_phycap_map_be(struct rtw89_dev *rtwdev);
 int rtw89_cnv_efuse_state_be(struct rtw89_dev *rtwdev, bool idle);
 int rtw89_read_efuse_ver(struct rtw89_dev *rtwdev, u8 *efv);
+int rtw89_efuse_read_fw_secure_be(struct rtw89_dev *rtwdev);
 
 #endif
diff --git a/drivers/net/wireless/realtek/rtw89/efuse_be.c b/drivers/net/wireless/realtek/rtw89/efuse_be.c
index 8e8b7cd315f7..0be26d5fdf7c 100644
--- a/drivers/net/wireless/realtek/rtw89/efuse_be.c
+++ b/drivers/net/wireless/realtek/rtw89/efuse_be.c
@@ -7,6 +7,31 @@
 #include "mac.h"
 #include "reg.h"
 
+#define EFUSE_EXTERNALPN_ADDR_BE 0x1580
+#define EFUSE_B1_MSSDEVTYPE_MASK GENMASK(3, 0)
+#define EFUSE_B1_MSSCUSTIDX0_MASK GENMASK(7, 4)
+#define EFUSE_SERIALNUM_ADDR_BE 0x1581
+#define EFUSE_B2_MSSKEYNUM_MASK GENMASK(3, 0)
+#define EFUSE_B2_MSSCUSTIDX1_MASK BIT(6)
+#define EFUSE_SB_CRYP_SEL_ADDR 0x1582
+#define EFUSE_SB_CRYP_SEL_SIZE 2
+#define EFUSE_SB_CRYP_SEL_DEFAULT 0xFFFF
+#define SB_SEL_MGN_MAX_SIZE 2
+#define EFUSE_SEC_BE_START 0x1580
+#define EFUSE_SEC_BE_SIZE 4
+
+enum rtw89_efuse_mss_dev_type {
+	MSS_DEV_TYPE_FWSEC_DEF = 0xF,
+	MSS_DEV_TYPE_FWSEC_WINLIN_INBOX = 0xC,
+	MSS_DEV_TYPE_FWSEC_NONLIN_INBOX_NON_COB = 0xA,
+	MSS_DEV_TYPE_FWSEC_NONLIN_INBOX_COB = 0x9,
+	MSS_DEV_TYPE_FWSEC_NONWIN_INBOX = 0x6,
+};
+
+static const u32 sb_sel_mgn[SB_SEL_MGN_MAX_SIZE] = {
+	0x8000100, 0xC000180
+};
+
 static void rtw89_enable_efuse_pwr_cut_ddv_be(struct rtw89_dev *rtwdev)
 {
 	const struct rtw89_chip_info *chip = rtwdev->chip;
@@ -418,3 +443,120 @@ int rtw89_parse_phycap_map_be(struct rtw89_dev *rtwdev)
 
 	return ret;
 }
+
+static u16 get_sb_cryp_sel_idx(u16 sb_cryp_sel)
+{
+	u8 low_bit, high_bit, cnt_zero = 0;
+	u8 idx, sel_form_v, sel_idx_v;
+	u16 sb_cryp_sel_v = 0x0;
+
+	sel_form_v = u16_get_bits(sb_cryp_sel, MASKBYTE0);
+	sel_idx_v = u16_get_bits(sb_cryp_sel, MASKBYTE1);
+
+	for (idx = 0; idx < 4; idx++) {
+		low_bit = !!(sel_form_v & BIT(idx));
+		high_bit = !!(sel_form_v & BIT(7 - idx));
+		if (low_bit != high_bit)
+			return U16_MAX;
+		if (low_bit)
+			continue;
+
+		cnt_zero++;
+		if (cnt_zero == 1)
+			sb_cryp_sel_v = idx * 16;
+		else if (cnt_zero > 1)
+			return U16_MAX;
+	}
+
+	low_bit = u8_get_bits(sel_idx_v, 0x0F);
+	high_bit = u8_get_bits(sel_idx_v, 0xF0);
+
+	if ((low_bit ^ high_bit) != 0xF)
+		return U16_MAX;
+
+	return sb_cryp_sel_v + low_bit;
+}
+
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
+int rtw89_efuse_read_fw_secure_be(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_fw_secure *sec = &rtwdev->fw.sec;
+	u32 sec_addr = EFUSE_SEC_BE_START;
+	u32 sec_size = EFUSE_SEC_BE_SIZE;
+	u16 sb_cryp_sel, sb_cryp_sel_idx;
+	u8 sec_map[EFUSE_SEC_BE_SIZE];
+	u8 mss_dev_type;
+	u8 b1, b2;
+	int ret;
+
+	ret = rtw89_dump_physical_efuse_map_be(rtwdev, sec_map,
+					       sec_addr, sec_size, false);
+	if (ret) {
+		rtw89_warn(rtwdev, "failed to dump secsel map\n");
+		return ret;
+	}
+
+	sb_cryp_sel = sec_map[EFUSE_SB_CRYP_SEL_ADDR - sec_addr] |
+		      sec_map[EFUSE_SB_CRYP_SEL_ADDR - sec_addr + 1] << 8;
+	if (sb_cryp_sel == EFUSE_SB_CRYP_SEL_DEFAULT)
+		goto out;
+
+	sb_cryp_sel_idx = get_sb_cryp_sel_idx(sb_cryp_sel);
+	if (sb_cryp_sel_idx >= SB_SEL_MGN_MAX_SIZE) {
+		rtw89_warn(rtwdev, "invalid SB cryp sel idx %d\n", sb_cryp_sel_idx);
+		goto out;
+	}
+
+	sec->sb_sel_mgn = sb_sel_mgn[sb_cryp_sel_idx];
+
+	b1 = sec_map[EFUSE_EXTERNALPN_ADDR_BE - sec_addr];
+	b2 = sec_map[EFUSE_SERIALNUM_ADDR_BE - sec_addr];
+
+	mss_dev_type = u8_get_bits(b1, EFUSE_B1_MSSDEVTYPE_MASK);
+	sec->mss_cust_idx = 0x1F - (u8_get_bits(b1, EFUSE_B1_MSSCUSTIDX0_MASK) |
+				    u8_get_bits(b2, EFUSE_B2_MSSCUSTIDX1_MASK) << 4);
+	sec->mss_key_num = 0xF - u8_get_bits(b2, EFUSE_B2_MSSKEYNUM_MASK);
+
+	sec->mss_dev_type = get_mss_dev_type_idx(rtwdev, mss_dev_type);
+	if (sec->mss_dev_type == RTW89_FW_MSS_DEV_TYPE_FWSEC_INV) {
+		rtw89_warn(rtwdev, "invalid mss_dev_type %d\n", mss_dev_type);
+		goto out;
+	}
+
+	sec->secure_boot = true;
+
+out:
+	rtw89_debug(rtwdev, RTW89_DBG_FW,
+		    "MSS secure_boot=%d dev_type=%d cust_idx=%d key_num=%d\n",
+		    sec->secure_boot, sec->mss_dev_type, sec->mss_cust_idx,
+		    sec->mss_key_num);
+
+	return 0;
+}
+EXPORT_SYMBOL(rtw89_efuse_read_fw_secure_be);
diff --git a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wireless/realtek/rtw89/pci.c
index b51ec3cbc715..67d7294e488a 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.c
+++ b/drivers/net/wireless/realtek/rtw89/pci.c
@@ -4180,6 +4180,8 @@ int rtw89_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		goto err_free_irq;
 	}
 
+	set_bit(RTW89_FLAG_PROBE_DONE, rtwdev->flags);
+
 	return 0;
 
 err_free_irq:
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a.c b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
index aefad3f2e612..c9e50fc38083 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
@@ -376,6 +376,9 @@ static int rtw8922a_pwr_on_func(struct rtw89_dev *rtwdev)
 	rtw89_write32_set(rtwdev, R_BE_FEN_RST_ENABLE, B_BE_FEN_BB_IP_RSTN |
 						       B_BE_FEN_BBPLAT_RSTB);
 
+	if (!test_bit(RTW89_FLAG_PROBE_DONE, rtwdev->flags))
+		rtw89_efuse_read_fw_secure_be(rtwdev);
+
 	return 0;
 }
 
-- 
2.25.1


