Return-Path: <linux-wireless+bounces-3069-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8DAD847DDD
	for <lists+linux-wireless@lfdr.de>; Sat,  3 Feb 2024 01:33:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8486B2899B1
	for <lists+linux-wireless@lfdr.de>; Sat,  3 Feb 2024 00:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B701C10E6;
	Sat,  3 Feb 2024 00:33:40 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB64643
	for <linux-wireless@vger.kernel.org>; Sat,  3 Feb 2024 00:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706920420; cv=none; b=RfC6KbxKHuo0Uej+Wj+GaX3wzu0HyaNnyy5bPcK6si6+wW3u+wpD/9Uf3IpIIzKlWefT1JMEhGLpbyWSRiBa+A3tkya415QcKxSBC0AuPms5+g/gUO0YiSK0f48UmsxubdYRuH98aR429bVEMOYPnBf0Zkhf6g2mKvfGO32XFrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706920420; c=relaxed/simple;
	bh=ukeNLKsx5S/8GYeKZb22Wcs/uQ1PQmsuZeew1cserwY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MxOI5UZpxKoVu+3Zd/W0xoudiEI3wKCvWdmpSofv59l0Uj/SixzC3sL6WkXPytb4wbkBmYgZ2posHBb+QME9zImmYQlRK4iNEy5JZ6crAwPX25R1rqraqLGQL5sC56OU1foetfBJzEawIfXpHjCRfbqoT7tSVCynUnKe6NQVOG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4130XWmN42300745, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 4130XWmN42300745
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 3 Feb 2024 08:33:32 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.17; Sat, 3 Feb 2024 08:33:32 +0800
Received: from [127.0.1.1] (172.16.16.254) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Sat, 3 Feb
 2024 08:33:32 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH 1/4] wifi: rtw89: fw: consider checksum length of security data
Date: Sat, 3 Feb 2024 08:32:48 +0800
Message-ID: <20240203003251.10641-2-pkshih@realtek.com>
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


