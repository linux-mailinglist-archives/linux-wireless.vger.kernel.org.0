Return-Path: <linux-wireless+bounces-14700-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C939B59E0
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Oct 2024 03:23:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C81E4284238
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Oct 2024 02:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFA31199E89;
	Wed, 30 Oct 2024 02:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="TxsUOq+3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3329A199385
	for <linux-wireless@vger.kernel.org>; Wed, 30 Oct 2024 02:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730254944; cv=none; b=Zu0LH37ivsAzo+Llu+bzZFWxhmPtqoQSN5TwLomH9/zL9b54eyJjZ6SAwrbHoglkLT4l8hFB75nIxDb9bnf1J9gehpdARC7Hq8Hh90NOOvgugfVdsvn3zJU90LVGWXy8kC+ioYnvHN4q5cRZr+JEI9uAdARs9WGUt5EBeHmyNAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730254944; c=relaxed/simple;
	bh=xjm6UDYOibqFsQb4645RGcN0B/lZHEDj2fle07zwuFU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AhpqyFC07cT1mACsRM0cUGNWMQDb9tBSRPVbeS010IZrdzgG1RnfL9Xy7UMlECR/y7PPB+YMMfcljxA2GYW7F3W9CLX8nFgRc1+tj9kSOURaE0ERkZGanJlDzFep8LRZ7J2AFTf4k9i3pAl4xmtZ8VjLC2cP1zBO5Gpo0XLCT48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=TxsUOq+3; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 49U2MKAl83310645, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1730254940; bh=xjm6UDYOibqFsQb4645RGcN0B/lZHEDj2fle07zwuFU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=TxsUOq+34MDTxU5tizBKhPB5o9gnYLxWB/y85ghWUx88yZn0dgzj7+4l51YBCjgLj
	 F3lnEr9lPH/Y4DYPB3dr6msUd1dO54asrBD6jPuRdRt6P+n0NN7YxxpZ6T65txRZsb
	 If/LvK6vAZHxey9QzmANldAZEyFekDX8HcJKTdZTOOrBd1193/k93c1q75lbiYcHLe
	 I3r5CusHMtMjDLTsOB95l+Gkt9LMYruhcCqRaKysUsUr8toD9msBz7cwNnggQo35RT
	 l8QK0XnJZnJ8sMdM8U1ZcxPoZhYtw0kpaK1c6lRQmn27ydoZn/ed96B5FHWXadA7Zg
	 xlvK6tLYOmp5w==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 49U2MKAl83310645
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 30 Oct 2024 10:22:20 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 30 Oct 2024 10:22:20 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 30 Oct
 2024 10:22:20 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH 5/8] wifi: rtw89: fw: set recorded IDMEM share mode in firmware header to register
Date: Wed, 30 Oct 2024 10:21:32 +0800
Message-ID: <20241030022135.11688-6-pkshih@realtek.com>
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

For WiFi 6 chips, firmware secure boot will run on a IDMEM mode specified
in firmware header. Retrieve the mode from firmware, and set to registers
accordingly.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.c     |  4 ++++
 drivers/net/wireless/realtek/rtw89/fw.h     |  3 +++
 drivers/net/wireless/realtek/rtw89/mac.c    | 15 +++++++++++++++
 drivers/net/wireless/realtek/rtw89/mac.h    | 11 +++++++++++
 drivers/net/wireless/realtek/rtw89/mac_be.c |  1 +
 drivers/net/wireless/realtek/rtw89/reg.h    |  2 ++
 6 files changed, 36 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 0af0e539e976..0b2987bd662e 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -141,6 +141,7 @@ static int rtw89_fw_hdr_parser_v0(struct rtw89_dev *rtwdev, const u8 *fw, u32 le
 	info->section_num = le32_get_bits(fw_hdr->w6, FW_HDR_W6_SEC_NUM);
 	base_hdr_len = struct_size(fw_hdr, sections, info->section_num);
 	info->dynamic_hdr_en = le32_get_bits(fw_hdr->w7, FW_HDR_W7_DYN_HDR);
+	info->idmem_share_mode = le32_get_bits(fw_hdr->w7, FW_HDR_W7_IDMEM_SHARE_MODE);
 
 	if (info->dynamic_hdr_en) {
 		info->hdr_len = le32_get_bits(fw_hdr->w3, FW_HDR_W3_LEN);
@@ -366,6 +367,7 @@ static int rtw89_fw_hdr_parser_v1(struct rtw89_dev *rtwdev, const u8 *fw, u32 le
 	info->dsp_checksum = le32_get_bits(fw_hdr->w6, FW_HDR_V1_W6_DSP_CHKSUM);
 	base_hdr_len = struct_size(fw_hdr, sections, info->section_num);
 	info->dynamic_hdr_en = le32_get_bits(fw_hdr->w7, FW_HDR_V1_W7_DYN_HDR);
+	info->idmem_share_mode = le32_get_bits(fw_hdr->w7, FW_HDR_V1_W7_IDMEM_SHARE_MODE);
 
 	if (info->dynamic_hdr_en) {
 		info->hdr_len = le32_get_bits(fw_hdr->w5, FW_HDR_V1_W5_HDR_SIZE);
@@ -1455,6 +1457,8 @@ static int rtw89_fw_download_suit(struct rtw89_dev *rtwdev,
 		return ret;
 	}
 
+	rtw89_fwdl_secure_idmem_share_mode(rtwdev, info.idmem_share_mode);
+
 	if (rtwdev->chip->chip_id == RTL8922A &&
 	    (fw_suit->type == RTW89_FW_NORMAL || fw_suit->type == RTW89_FW_WOWLAN))
 		rtw89_write32(rtwdev, R_BE_SECURE_BOOT_MALLOC_INFO, 0x20248000);
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index 83fcd5edc057..bd7680264849 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -276,6 +276,7 @@ struct rtw89_fw_bin_info {
 	u32 hdr_len;
 	bool dynamic_hdr_en;
 	u32 dynamic_hdr_len;
+	u8 idmem_share_mode;
 	bool dsp_checksum;
 	bool secure_section_exist;
 	struct rtw89_fw_hdr_section_info section_info[FWDL_SECTION_MAX_NUM];
@@ -564,6 +565,7 @@ struct rtw89_fw_hdr {
 #define FW_HDR_W6_SEC_NUM GENMASK(15, 8)
 #define FW_HDR_W7_PART_SIZE GENMASK(15, 0)
 #define FW_HDR_W7_DYN_HDR BIT(16)
+#define FW_HDR_W7_IDMEM_SHARE_MODE GENMASK(21, 18)
 #define FW_HDR_W7_CMD_VERSERION GENMASK(31, 24)
 
 struct rtw89_fw_hdr_section_v1 {
@@ -616,6 +618,7 @@ struct rtw89_fw_hdr_v1 {
 #define FW_HDR_V1_W6_DSP_CHKSUM BIT(24)
 #define FW_HDR_V1_W7_PART_SIZE GENMASK(15, 0)
 #define FW_HDR_V1_W7_DYN_HDR BIT(16)
+#define FW_HDR_V1_W7_IDMEM_SHARE_MODE GENMASK(21, 18)
 
 enum rtw89_fw_mss_pool_rmp_tbl_type {
 	MSS_POOL_RMP_TBL_BITMASK = 0x0,
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 7ed29bc69009..8985bd8fa38f 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -6621,6 +6621,20 @@ int rtw89_fwdl_check_path_ready_ax(struct rtw89_dev *rtwdev,
 					rtwdev, R_AX_WCPU_FW_CTRL);
 }
 
+static
+void rtw89_fwdl_secure_idmem_share_mode_ax(struct rtw89_dev *rtwdev, u8 mode)
+{
+	struct rtw89_fw_secure *sec = &rtwdev->fw.sec;
+
+	if (!sec->secure_boot)
+		return;
+
+	rtw89_write32_mask(rtwdev, R_AX_WCPU_FW_CTRL,
+			   B_AX_IDMEM_SHARE_MODE_RECORD_MASK, mode);
+	rtw89_write32_set(rtwdev, R_AX_WCPU_FW_CTRL,
+			  B_AX_IDMEM_SHARE_MODE_RECORD_VALID);
+}
+
 const struct rtw89_mac_gen_def rtw89_mac_gen_ax = {
 	.band1_offset = RTW89_MAC_AX_BAND_REG_OFFSET,
 	.filter_model_addr = R_AX_FILTER_MODEL_ADDR,
@@ -6674,6 +6688,7 @@ const struct rtw89_mac_gen_def rtw89_mac_gen_ax = {
 	.fwdl_enable_wcpu = rtw89_mac_enable_cpu_ax,
 	.fwdl_get_status = rtw89_fw_get_rdy_ax,
 	.fwdl_check_path_ready = rtw89_fwdl_check_path_ready_ax,
+	.fwdl_secure_idmem_share_mode = rtw89_fwdl_secure_idmem_share_mode_ax,
 	.parse_efuse_map = rtw89_parse_efuse_map_ax,
 	.parse_phycap_map = rtw89_parse_phycap_map_ax,
 	.cnv_efuse_state = rtw89_cnv_efuse_state_ax,
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index 4d4b505e3bc9..18579c020548 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -985,6 +985,7 @@ struct rtw89_mac_gen_def {
 				bool dlfw, bool include_bb);
 	u8 (*fwdl_get_status)(struct rtw89_dev *rtwdev, enum rtw89_fwdl_check_type type);
 	int (*fwdl_check_path_ready)(struct rtw89_dev *rtwdev, bool h2c_or_fwdl);
+	void (*fwdl_secure_idmem_share_mode)(struct rtw89_dev *rtwdev, u8 mode);
 	int (*parse_efuse_map)(struct rtw89_dev *rtwdev);
 	int (*parse_phycap_map)(struct rtw89_dev *rtwdev);
 	int (*cnv_efuse_state)(struct rtw89_dev *rtwdev, bool idle);
@@ -1495,4 +1496,14 @@ int rtw89_mac_get_dle_rsvd_qt_cfg(struct rtw89_dev *rtwdev,
 				  struct rtw89_mac_dle_rsvd_qt_cfg *cfg);
 int rtw89_mac_cpu_io_rx(struct rtw89_dev *rtwdev, bool wow_enable);
 
+static inline
+void rtw89_fwdl_secure_idmem_share_mode(struct rtw89_dev *rtwdev, u8 mode)
+{
+	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
+
+	if (!mac->fwdl_secure_idmem_share_mode)
+		return;
+
+	return mac->fwdl_secure_idmem_share_mode(rtwdev, mode);
+}
 #endif
diff --git a/drivers/net/wireless/realtek/rtw89/mac_be.c b/drivers/net/wireless/realtek/rtw89/mac_be.c
index e0d7cf9fd7ee..f7a396c8a3cd 100644
--- a/drivers/net/wireless/realtek/rtw89/mac_be.c
+++ b/drivers/net/wireless/realtek/rtw89/mac_be.c
@@ -2600,6 +2600,7 @@ const struct rtw89_mac_gen_def rtw89_mac_gen_be = {
 	.fwdl_enable_wcpu = rtw89_mac_fwdl_enable_wcpu_be,
 	.fwdl_get_status = fwdl_get_status_be,
 	.fwdl_check_path_ready = rtw89_fwdl_check_path_ready_be,
+	.fwdl_secure_idmem_share_mode = NULL,
 	.parse_efuse_map = rtw89_parse_efuse_map_be,
 	.parse_phycap_map = rtw89_parse_phycap_map_be,
 	.cnv_efuse_state = rtw89_cnv_efuse_state_be,
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 69678eab2309..18ec7c0252fb 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -196,6 +196,8 @@
 #define R_AX_HALT_C2H 0x016C
 
 #define R_AX_WCPU_FW_CTRL 0x01E0
+#define B_AX_IDMEM_SHARE_MODE_RECORD_MASK GENMASK(27, 24)
+#define B_AX_IDMEM_SHARE_MODE_RECORD_VALID BIT(23)
 #define B_AX_WCPU_FWDL_STS_MASK GENMASK(7, 5)
 #define B_AX_FWDL_PATH_RDY BIT(2)
 #define B_AX_H2C_PATH_RDY BIT(1)
-- 
2.25.1


