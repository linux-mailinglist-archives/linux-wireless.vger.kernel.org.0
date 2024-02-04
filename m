Return-Path: <linux-wireless+bounces-3091-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14106848A28
	for <lists+linux-wireless@lfdr.de>; Sun,  4 Feb 2024 02:27:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 459BC284452
	for <lists+linux-wireless@lfdr.de>; Sun,  4 Feb 2024 01:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53544613C;
	Sun,  4 Feb 2024 01:27:19 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14BA44685
	for <linux-wireless@vger.kernel.org>; Sun,  4 Feb 2024 01:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707010039; cv=none; b=SzQxzdp9s4OOtIlZxpAKoDDrCmm6PXjebbONe7cWOaIcOoTxKe1ZjzkI0WAXQnIIH3ZMV0PB+1Bizyk92+nD7qSwK9brqFAiKlFNBIoZ9sr0bhTAzkalqIk9ATBQHLZymWNngQRAwFwpjZhv+hyT2pRzVarFK3cVqZ8FuTEcBLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707010039; c=relaxed/simple;
	bh=ukeNLKsx5S/8GYeKZb22Wcs/uQ1PQmsuZeew1cserwY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B6pfh/3yIYS3BNQ5sKP9vtLM+3I+gfxgolbrpZOJRaW3BX3EtIOrnwm9EJ3TSvcAP5pOIDdwvWqXvQIWE2KeZ0+37zvoL9lV80GkUw1yKRh4u/Q1/F4P8gS3ssTQjEbOSanvOXT76NDY/SB4a3ZRGdNYgCmtXYv13+FRNGgz7Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4141R9Hp82615009, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 4141R9Hp82615009
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 4 Feb 2024 09:27:09 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.32; Sun, 4 Feb 2024 09:27:08 +0800
Received: from [127.0.1.1] (172.16.16.254) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Sun, 4 Feb
 2024 09:27:08 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 1/4] wifi: rtw89: fw: consider checksum length of security data
Date: Sun, 4 Feb 2024 09:26:24 +0800
Message-ID: <20240204012627.9647-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240204012627.9647-1-pkshih@realtek.com>
References: <20240204012627.9647-1-pkshih@realtek.com>
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

The newer firmware file provides security data with checksum, so we need to
consider the length. Otherwise it will fail to validate total firmware
length resulting in failed to probe.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.c | 3 +++
 drivers/net/wireless/realtek/rtw89/fw.h | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 2f3f2b503507..00417364ab22 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -177,6 +177,7 @@ static int rtw89_fw_hdr_parser_v1(struct rtw89_dev *rtwdev, const u8 *fw, u32 le
 	u32 i;
 
 	info->section_num = le32_get_bits(fw_hdr->w6, FW_HDR_V1_W6_SEC_NUM);
+	info->dsp_checksum = le32_get_bits(fw_hdr->w6, FW_HDR_V1_W6_DSP_CHKSUM);
 	base_hdr_len = struct_size(fw_hdr, sections, info->section_num);
 	info->dynamic_hdr_en = le32_get_bits(fw_hdr->w7, FW_HDR_V1_W7_DYN_HDR);
 
@@ -205,6 +206,8 @@ static int rtw89_fw_hdr_parser_v1(struct rtw89_dev *rtwdev, const u8 *fw, u32 le
 			section_info->mssc =
 				le32_get_bits(section->w2, FWSECTION_HDR_V1_W2_MSSC);
 			mssc_len += section_info->mssc * FWDL_SECURITY_SIGLEN;
+			if (info->dsp_checksum)
+				mssc_len += section_info->mssc * FWDL_SECURITY_CHKSUM_LEN;
 		} else {
 			section_info->mssc = 0;
 		}
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index ae69e455cd64..5b536c2e365d 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -237,6 +237,7 @@ struct rtw89_fw_bin_info {
 	u32 hdr_len;
 	bool dynamic_hdr_en;
 	u32 dynamic_hdr_len;
+	bool dsp_checksum;
 	struct rtw89_fw_hdr_section_info section_info[FWDL_SECTION_MAX_NUM];
 };
 
@@ -466,6 +467,7 @@ static inline void RTW89_SET_EDCA_PARAM(void *cmd, u32 val)
 
 #define FWDL_SECURITY_SECTION_TYPE 9
 #define FWDL_SECURITY_SIGLEN 512
+#define FWDL_SECURITY_CHKSUM_LEN 8
 
 struct rtw89_fw_dynhdr_sec {
 	__le32 w0;
@@ -568,6 +570,7 @@ struct rtw89_fw_hdr_v1 {
 #define FW_HDR_V1_W5_YEAR GENMASK(15, 0)
 #define FW_HDR_V1_W5_HDR_SIZE GENMASK(31, 16)
 #define FW_HDR_V1_W6_SEC_NUM GENMASK(15, 8)
+#define FW_HDR_V1_W6_DSP_CHKSUM BIT(24)
 #define FW_HDR_V1_W7_DYN_HDR BIT(16)
 
 static inline void SET_FW_HDR_PART_SIZE(void *fwhdr, u32 val)
-- 
2.25.1


