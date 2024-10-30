Return-Path: <linux-wireless+bounces-14699-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF3089B59DF
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Oct 2024 03:23:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52E271F24164
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Oct 2024 02:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98894199222;
	Wed, 30 Oct 2024 02:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="aaYAGFzR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B6CF198E71
	for <linux-wireless@vger.kernel.org>; Wed, 30 Oct 2024 02:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730254941; cv=none; b=ZkLNj5rNKmFEY26X1JA1D2nlfCujkP7hxjUDXCWFXpZXaU4eXt8Aeibdbdft3+oxyqy0CW3jf4Ky/I7cBup9+vpwLkIRoLEMd/Bzs5CTciada6lY89paA4kRNve5EAlamRmGwIv1Ch6d0rWZP6p0VIYdLJZSC8C6emg5lMt3EHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730254941; c=relaxed/simple;
	bh=E0uxXp6vgW3SYQK+w8UrYYFuaAKn6ryxDlOCkNM0IVo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sa3xLrpCegfTBNTmVnSh+WAb6Zy22DjgykrHV7sLhV8L+23S73z5XwnUHCLrzOWjcpR9ifxu98Pd9EPe4uI31HE56/5I4gMK+qQQ6nhg4NQKREKvF6W2OA+mSi8WEoodQnhsNsjjmJ6A41CcJ2GlVsB1uTU2xqR8MQ0zXsfOvJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=aaYAGFzR; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 49U2MHRd83310608, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1730254937; bh=E0uxXp6vgW3SYQK+w8UrYYFuaAKn6ryxDlOCkNM0IVo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=aaYAGFzRdkNtw65z0O+5eKruelR2NNxwt2AJ12lEhGw69B1tS9aMSjzOJA0E7Ds7T
	 dcFJ8f5zUukysBhxltBCgZaJ65ro/k153FGfvRLkUQocsODu8tHWSl1Z4e/obGUe/D
	 haF6mr1k4xHEnacmiVSl+RvOY1/GvFwjKdrqYWJEhs6Cr2LsaC5Fad/abxDXcL3vf6
	 jZv++Ab/4Vam4dPrT0WKOq0434uysAXtFnhWKkpfNhk5hNAP3mTjeEWuuOkDSc88NA
	 Ialsz6pMrCdKtoK8JWdK9xNj8M+2GuEd+XUV5ikF46DcU6c4p+h8XOyR09u4cypNa1
	 VIdk0sUp/yDKQ==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 49U2MHRd83310608
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 30 Oct 2024 10:22:17 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 30 Oct 2024 10:22:17 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 30 Oct
 2024 10:22:17 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH 4/8] wifi: rtw89: fw: shrink download size of security section for RTL8852B
Date: Wed, 30 Oct 2024 10:21:31 +0800
Message-ID: <20241030022135.11688-5-pkshih@realtek.com>
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

For RTL8852B, when current firmware is secure boot, the security section
needs a special treatment that shrink its size to 960.

As figure below, not only shrink the amount of download size of security
section (2), but also need to modify the section size in firmware header
(1) that is also downloaded to chip.

   +---------------------------+
   |      firmware header      |
   |                           |
   | +-----------------------+ |
   | | section type, size N -|-|-------+
   | | ...               (1) | |       |
   | +-----------------------+ |       |
   +---------------------------+       | 2048 shrink to 960
   :                           :       |
   +---------------------------+ -\    |
   |  security section type 9  |  |    |
   |           (2)             |  | <--+
   |                           |  |
   +---------------------------+ -/

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.c | 36 ++++++++++++++++++++++---
 drivers/net/wireless/realtek/rtw89/fw.h |  1 +
 2 files changed, 34 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 1fc1ee46b3a3..0af0e539e976 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -124,7 +124,9 @@ static int rtw89_fw_hdr_parser_v0(struct rtw89_dev *rtwdev, const u8 *fw, u32 le
 				  struct rtw89_fw_bin_info *info)
 {
 	const struct rtw89_fw_hdr *fw_hdr = (const struct rtw89_fw_hdr *)fw;
+	const struct rtw89_chip_info *chip = rtwdev->chip;
 	struct rtw89_fw_hdr_section_info *section_info;
+	struct rtw89_fw_secure *sec = &rtwdev->fw.sec;
 	const struct rtw89_fw_dynhdr_hdr *fwdynhdr;
 	const struct rtw89_fw_hdr_section *section;
 	const u8 *fw_end = fw + len;
@@ -165,6 +167,9 @@ static int rtw89_fw_hdr_parser_v0(struct rtw89_dev *rtwdev, const u8 *fw, u32 le
 			section_info->mssc =
 				le32_get_bits(section->w2, FWSECTION_HDR_W2_MSSC);
 			mssc_len += section_info->mssc * FWDL_SECURITY_SIGLEN;
+
+			if (sec->secure_boot && chip->chip_id == RTL8852B)
+				section_info->len_override = 960;
 		} else {
 			section_info->mssc = 0;
 		}
@@ -1155,9 +1160,24 @@ static u32 __rtw89_fw_download_tweak_hdr_v0(struct rtw89_dev *rtwdev,
 					    struct rtw89_fw_bin_info *info,
 					    struct rtw89_fw_hdr *fw_hdr)
 {
+	struct rtw89_fw_hdr_section_info *section_info;
+	struct rtw89_fw_hdr_section *section;
+	int i;
+
 	le32p_replace_bits(&fw_hdr->w7, FWDL_SECTION_PER_PKT_LEN,
 			   FW_HDR_W7_PART_SIZE);
 
+	for (i = 0; i < info->section_num; i++) {
+		section_info = &info->section_info[i];
+
+		if (!section_info->len_override)
+			continue;
+
+		section = &fw_hdr->sections[i];
+		le32p_replace_bits(&section->w1, section_info->len_override,
+				   FWSECTION_HDR_W1_SEC_SIZE);
+	}
+
 	return 0;
 }
 
@@ -1286,10 +1306,20 @@ static int __rtw89_fw_download_main(struct rtw89_dev *rtwdev,
 	if (info->ignore)
 		return 0;
 
+	if (info->len_override) {
+		if (info->len_override > info->len)
+			rtw89_warn(rtwdev, "override length %u larger than original %u\n",
+				   info->len_override, info->len);
+		else
+			residue_len = info->len_override;
+	}
+
 	if (info->key_addr && info->key_len) {
-		if (info->len > FWDL_SECTION_PER_PKT_LEN || info->len < info->key_len)
-			rtw89_warn(rtwdev, "ignore to copy key data because of len %d, %d, %d\n",
-				   info->len, FWDL_SECTION_PER_PKT_LEN, info->key_len);
+		if (residue_len > FWDL_SECTION_PER_PKT_LEN || info->len < info->key_len)
+			rtw89_warn(rtwdev,
+				   "ignore to copy key data because of len %d, %d, %d, %d\n",
+				   info->len, FWDL_SECTION_PER_PKT_LEN,
+				   info->key_len, residue_len);
 		else
 			copy_key = true;
 	}
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index 2e2035705881..83fcd5edc057 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -261,6 +261,7 @@ struct rtw89_fw_hdr_section_info {
 	u8 redl;
 	const u8 *addr;
 	u32 len;
+	u32 len_override;
 	u32 dladdr;
 	u32 mssc;
 	u8 type;
-- 
2.25.1


