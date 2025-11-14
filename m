Return-Path: <linux-wireless+bounces-28949-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7760C5B74F
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Nov 2025 07:05:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 791FF3ACF70
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Nov 2025 06:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F1A42E6137;
	Fri, 14 Nov 2025 06:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="bdQNtBKI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE472DCBF7
	for <linux-wireless@vger.kernel.org>; Fri, 14 Nov 2025 06:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763100139; cv=none; b=oXdwtd6eyM4+xVRGWJiHScxa5FA7N0cBSm56TxTiY/6tTsNGUnciq4ctk+9LrK0MQV4t3u4qGOF4ei++tRbMMKGJ5J/IiTOsBFOov/CqfNVHRgVsjZFwl4h3BTs7zq08Y2s6xhFVS08/PAF/gRzF8mlCmtH/Yfjl/K07alRfa2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763100139; c=relaxed/simple;
	bh=WknfmKGHS1cIZls1GyoI7c3T2iHPJQ15Y37fbrwjl6U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SOknIUiyHKixuEv1XUfCVulD1ASX2yb+t2TFvFaQASkFADbco2+8FxKPH4qLfxBSfdCYFIIn9rHsf2lbYyRWxE5+Gj1jjqLawoL02c/E69JxCRIVvX2FJZasQcifi31ZZESPJNMjmn9bWE5OzzuEWm3lZLB2ifGTJWd09HI1JxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=bdQNtBKI; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5AE62F6M01037600, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1763100135; bh=J9NRoEKjnKSK85wYaELLmFu1IVPug3p7z2qiPxoRLVA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=bdQNtBKIq3uAocJz4WHKZYCJy1DE6EbSyFG/sK3/e+oIw1BH589qP1qMt5KZLgwBY
	 tcm+zZlPuUYOKPyxpfW0orxPckIhT1rkjiogQ69BohTUS0zbCFhwKBzo61utgMyFaT
	 2wodwzK/At14BsL6ZPWrLUmDDnzASi4YQ86NjBX63mtV696bUJuR865G6g/fHJpZUl
	 G3yUXmYSh9Kkn2jv03L895J0UYrx2afgydrmL1LlVKJOVHkSODiulxHE4iAaSXoq0T
	 yjN3pOxOkhlnpSfnIGoewHFW+qGacfwysJoFRNZj1pYb/6jD9Fo1YVFZGY0TqA6dW+
	 TbjXOqkwBjvCA==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5AE62F6M01037600
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 14 Nov 2025 14:02:15 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Fri, 14 Nov 2025 14:02:15 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTKEXHMBS04.realtek.com.tw
 (10.21.1.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27 via Frontend
 Transport; Fri, 14 Nov 2025 14:02:15 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>
Subject: [PATCH v2 rtw-next 02/14] wifi: rtw89: fw: part size to download firmware by header info
Date: Fri, 14 Nov 2025 14:01:16 +0800
Message-ID: <20251114060128.35363-3-pkshih@realtek.com>
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

The part size is the unit to download firmware piece by piece. Old chips
use 2020 bytes as a piece, but in new chips the part size is defined in
firmware header. Change to use the value dynamically.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
v2: no change
---
 drivers/net/wireless/realtek/rtw89/fw.c | 31 +++++++++++++++----------
 drivers/net/wireless/realtek/rtw89/fw.h |  1 +
 2 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 515e9f098380..b234df109634 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -161,6 +161,11 @@ static int rtw89_fw_hdr_parser_v0(struct rtw89_dev *rtwdev, const u8 *fw, u32 le
 	info->dynamic_hdr_en = le32_get_bits(fw_hdr->w7, FW_HDR_W7_DYN_HDR);
 	info->idmem_share_mode = le32_get_bits(fw_hdr->w7, FW_HDR_W7_IDMEM_SHARE_MODE);
 
+	if (chip->chip_gen == RTW89_CHIP_AX)
+		info->part_size = FWDL_SECTION_PER_PKT_LEN;
+	else
+		info->part_size = le32_get_bits(fw_hdr->w7, FW_HDR_W7_PART_SIZE);
+
 	if (info->dynamic_hdr_en) {
 		info->hdr_len = le32_get_bits(fw_hdr->w3, FW_HDR_W3_LEN);
 		info->dynamic_hdr_len = info->hdr_len - base_hdr_len;
@@ -439,6 +444,7 @@ static int rtw89_fw_hdr_parser_v1(struct rtw89_dev *rtwdev, const u8 *fw, u32 le
 				  struct rtw89_fw_bin_info *info)
 {
 	const struct rtw89_fw_hdr_v1 *fw_hdr = (const struct rtw89_fw_hdr_v1 *)fw;
+	const struct rtw89_chip_info *chip = rtwdev->chip;
 	struct rtw89_fw_hdr_section_info *section_info;
 	const struct rtw89_fw_dynhdr_hdr *fwdynhdr;
 	const struct rtw89_fw_hdr_section_v1 *section;
@@ -455,6 +461,11 @@ static int rtw89_fw_hdr_parser_v1(struct rtw89_dev *rtwdev, const u8 *fw, u32 le
 	info->dynamic_hdr_en = le32_get_bits(fw_hdr->w7, FW_HDR_V1_W7_DYN_HDR);
 	info->idmem_share_mode = le32_get_bits(fw_hdr->w7, FW_HDR_V1_W7_IDMEM_SHARE_MODE);
 
+	if (chip->chip_gen == RTW89_CHIP_AX)
+		info->part_size = FWDL_SECTION_PER_PKT_LEN;
+	else
+		info->part_size = le32_get_bits(fw_hdr->w7, FW_HDR_V1_W7_PART_SIZE);
+
 	if (info->dynamic_hdr_en) {
 		info->hdr_len = le32_get_bits(fw_hdr->w5, FW_HDR_V1_W5_HDR_SIZE);
 		info->dynamic_hdr_len = info->hdr_len - base_hdr_len;
@@ -1516,8 +1527,7 @@ static u32 __rtw89_fw_download_tweak_hdr_v0(struct rtw89_dev *rtwdev,
 	struct rtw89_fw_hdr_section *section;
 	int i;
 
-	le32p_replace_bits(&fw_hdr->w7, FWDL_SECTION_PER_PKT_LEN,
-			   FW_HDR_W7_PART_SIZE);
+	le32p_replace_bits(&fw_hdr->w7, info->part_size, FW_HDR_W7_PART_SIZE);
 
 	for (i = 0; i < info->section_num; i++) {
 		section_info = &info->section_info[i];
@@ -1542,8 +1552,7 @@ static u32 __rtw89_fw_download_tweak_hdr_v1(struct rtw89_dev *rtwdev,
 	u8 dst_sec_idx = 0;
 	u8 sec_idx;
 
-	le32p_replace_bits(&fw_hdr->w7, FWDL_SECTION_PER_PKT_LEN,
-			   FW_HDR_V1_W7_PART_SIZE);
+	le32p_replace_bits(&fw_hdr->w7, info->part_size, FW_HDR_V1_W7_PART_SIZE);
 
 	for (sec_idx = 0; sec_idx < info->section_num; sec_idx++) {
 		section_info = &info->section_info[sec_idx];
@@ -1645,7 +1654,8 @@ static int rtw89_fw_download_hdr(struct rtw89_dev *rtwdev,
 }
 
 static int __rtw89_fw_download_main(struct rtw89_dev *rtwdev,
-				    struct rtw89_fw_hdr_section_info *info)
+				    struct rtw89_fw_hdr_section_info *info,
+				    u32 part_size)
 {
 	struct sk_buff *skb;
 	const u8 *section = info->addr;
@@ -1666,20 +1676,17 @@ static int __rtw89_fw_download_main(struct rtw89_dev *rtwdev,
 	}
 
 	if (info->key_addr && info->key_len) {
-		if (residue_len > FWDL_SECTION_PER_PKT_LEN || info->len < info->key_len)
+		if (residue_len > part_size || info->len < info->key_len)
 			rtw89_warn(rtwdev,
 				   "ignore to copy key data because of len %d, %d, %d, %d\n",
-				   info->len, FWDL_SECTION_PER_PKT_LEN,
+				   info->len, part_size,
 				   info->key_len, residue_len);
 		else
 			copy_key = true;
 	}
 
 	while (residue_len) {
-		if (residue_len >= FWDL_SECTION_PER_PKT_LEN)
-			pkt_len = FWDL_SECTION_PER_PKT_LEN;
-		else
-			pkt_len = residue_len;
+		pkt_len = min(residue_len, part_size);
 
 		skb = rtw89_fw_h2c_alloc_skb_no_hdr(rtwdev, pkt_len);
 		if (!skb) {
@@ -1734,7 +1741,7 @@ static int rtw89_fw_download_main(struct rtw89_dev *rtwdev,
 	int ret;
 
 	while (section_num--) {
-		ret = __rtw89_fw_download_main(rtwdev, section_info);
+		ret = __rtw89_fw_download_main(rtwdev, section_info, info->part_size);
 		if (ret)
 			return ret;
 		section_info++;
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index 6620256e3f22..87c55a1a9d94 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -297,6 +297,7 @@ struct rtw89_fw_hdr_section_info {
 
 struct rtw89_fw_bin_info {
 	u8 section_num;
+	u32 part_size;
 	u32 hdr_len;
 	bool dynamic_hdr_en;
 	u32 dynamic_hdr_len;
-- 
2.25.1


