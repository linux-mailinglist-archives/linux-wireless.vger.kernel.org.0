Return-Path: <linux-wireless+bounces-14702-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 727739B59E6
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Oct 2024 03:23:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C92DDB228E0
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Oct 2024 02:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E52421C461F;
	Wed, 30 Oct 2024 02:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="l/R9hW9+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA961C3F0E
	for <linux-wireless@vger.kernel.org>; Wed, 30 Oct 2024 02:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730254951; cv=none; b=t4m53tRgzIf0aTjyRr7ANCXG/+ivHKlgMN9nydprzFn5v3AA/4uv0W7/HvgZayBxio3boRYaxbhP0GMRVFMj28svJaeHoFdlmHCHNxvUnzK0CYKW4sh2jNa7GiAHOE/bO9nhNMD5DTBUyBvfxuPMT7kXYlB/RiWK41QQ0HfOjp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730254951; c=relaxed/simple;
	bh=XZTUvMw2l2n+sK3BClZ3FYDOBZYSgRJhN2eBLe7BF9A=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ts8Z+5J6W+6ze4UU1XLPFrp3KfHHAW0JLIjLLfSORXcMnNpZpFWWONjnVS86J3TRsQFT4pY6taIdXVNOhc5v4KpPLY4D5xcJZYpYtVgaK4KQeZ9jHgPdyFx6JVphhBknmoFgrgUKsPKMMPYtHASThMecW/IWvUPaPcvDrXeFjzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=l/R9hW9+; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 49U2MRZz83310671, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1730254947; bh=XZTUvMw2l2n+sK3BClZ3FYDOBZYSgRJhN2eBLe7BF9A=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=l/R9hW9+0iKa+rePw+cjwQm0WbPFYQwJqCFMR1htdCXfhRikLX8tkaC8IB3uxf0u/
	 nUauVgFxdL2olxaELqrlaNn3+J7RxoEqqdwEM5dXCnovcFaKKrZLi0EF9MuEl7db58
	 TGfe6jpzA+LsV7qx+WoTJz6i1mzzDfJtC/JTbkNJmdHRL3C0iUScUBry6gAlpVT/Ey
	 y8ky5HmzH2igd3xSRKkunggDfstfHwI5eLwgDRBE1KKbazZ3UGBVl+v9bqfy+I4+5j
	 49yiPJ/1nRoS5Sn9YOAtd8zh1CEEXBszexlTdVnNbOj7QnYd9Y4RsABOSGVJR6FJkX
	 r6burQV0SBcyg==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 49U2MRZz83310671
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 30 Oct 2024 10:22:27 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 30 Oct 2024 10:22:27 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 30 Oct
 2024 10:22:26 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH 7/8] wifi: rtw89: fw: use common function to parse security section for WiFi 6 chips
Date: Wed, 30 Oct 2024 10:21:34 +0800
Message-ID: <20241030022135.11688-8-pkshih@realtek.com>
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

The MSSC (multiple security section count) can be regular number (shown in
below figure) or 0xFF (supported already). For WiFi 7 or newer WiFi 6
chips, the MSSC will be 0xFF. But early WiFi 6 chip such as RTL8852B
could be either one of the cases.

Extend __parse_security_section() to support both with/without secure
boot mode accordingly.

           +---------------------------+ -\
           |      firmware header      |  |
           |                           |  |
           | +-----------------------+ |  |
           | | section type/size * N | |  |
           | +-----------------------+ |  |
           +---------------------------+ -/
           :                           :
           +---------------------------+ -\
           | secure section type (ID:9)|  |
           |                           |  |
      +----|-> [ security key data ]   |  |
      |    +---------------------------+ -/
      |    |MSS Pool for above section |
      |    |  [ security key data 1 ]  |
      +----|- [ security key data 2 ]  |
by mss_idx |  [ security key data 3 ]  |
           |  ...                 M    | * M = MSSC (MSSC != 0xFF)
           +---------------------------+

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.c | 57 +++++++++++++++++++------
 drivers/net/wireless/realtek/rtw89/fw.h |  1 +
 2 files changed, 46 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 4229065e07e8..538622c29e42 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -56,6 +56,11 @@ static void rtw89_fw_c2h_cmd_handle(struct rtw89_dev *rtwdev,
 				    struct sk_buff *skb);
 static int rtw89_h2c_tx_and_wait(struct rtw89_dev *rtwdev, struct sk_buff *skb,
 				 struct rtw89_wait_info *wait, unsigned int cond);
+static int __parse_security_section(struct rtw89_dev *rtwdev,
+				    struct rtw89_fw_bin_info *info,
+				    struct rtw89_fw_hdr_section_info *section_info,
+				    const void *content,
+				    u32 *mssc_len);
 
 static struct sk_buff *rtw89_fw_h2c_alloc_skb(struct rtw89_dev *rtwdev, u32 len,
 					      bool header)
@@ -132,7 +137,8 @@ static int rtw89_fw_hdr_parser_v0(struct rtw89_dev *rtwdev, const u8 *fw, u32 le
 	const u8 *fw_end = fw + len;
 	const u8 *bin;
 	u32 base_hdr_len;
-	u32 mssc_len = 0;
+	u32 mssc_len;
+	int ret;
 	u32 i;
 
 	if (!info)
@@ -164,29 +170,47 @@ static int rtw89_fw_hdr_parser_v0(struct rtw89_dev *rtwdev, const u8 *fw, u32 le
 		section = &fw_hdr->sections[i];
 		section_info->type =
 			le32_get_bits(section->w1, FWSECTION_HDR_W1_SECTIONTYPE);
+		section_info->len = le32_get_bits(section->w1, FWSECTION_HDR_W1_SEC_SIZE);
+
+		if (le32_get_bits(section->w1, FWSECTION_HDR_W1_CHECKSUM))
+			section_info->len += FWDL_SECTION_CHKSUM_LEN;
+		section_info->redl = le32_get_bits(section->w1, FWSECTION_HDR_W1_REDL);
+		section_info->dladdr =
+			le32_get_bits(section->w0, FWSECTION_HDR_W0_DL_ADDR) & 0x1fffffff;
+		section_info->addr = bin;
+
 		if (section_info->type == FWDL_SECURITY_SECTION_TYPE) {
 			section_info->mssc =
 				le32_get_bits(section->w2, FWSECTION_HDR_W2_MSSC);
-			mssc_len += section_info->mssc * FWDL_SECURITY_SIGLEN;
+
+			ret = __parse_security_section(rtwdev, info, section_info,
+						       bin, &mssc_len);
+			if (ret)
+				return ret;
 
 			if (sec->secure_boot && chip->chip_id == RTL8852B)
 				section_info->len_override = 960;
 		} else {
 			section_info->mssc = 0;
+			mssc_len = 0;
 		}
 
-		section_info->len = le32_get_bits(section->w1, FWSECTION_HDR_W1_SEC_SIZE);
-		if (le32_get_bits(section->w1, FWSECTION_HDR_W1_CHECKSUM))
-			section_info->len += FWDL_SECTION_CHKSUM_LEN;
-		section_info->redl = le32_get_bits(section->w1, FWSECTION_HDR_W1_REDL);
-		section_info->dladdr =
-			le32_get_bits(section->w0, FWSECTION_HDR_W0_DL_ADDR) & 0x1fffffff;
-		section_info->addr = bin;
-		bin += section_info->len;
+		rtw89_debug(rtwdev, RTW89_DBG_FW,
+			    "section[%d] type=%d len=0x%-6x mssc=%d mssc_len=%d addr=%tx\n",
+			    i, section_info->type, section_info->len,
+			    section_info->mssc, mssc_len, bin - fw);
+		rtw89_debug(rtwdev, RTW89_DBG_FW,
+			    "           ignore=%d key_addr=%p (0x%tx) key_len=%d key_idx=%d\n",
+			    section_info->ignore, section_info->key_addr,
+			    section_info->key_addr ?
+			    section_info->key_addr - section_info->addr : 0,
+			    section_info->key_len, section_info->key_idx);
+
+		bin += section_info->len + mssc_len;
 		section_info++;
 	}
 
-	if (fw_end != bin + mssc_len) {
+	if (fw_end != bin) {
 		rtw89_err(rtwdev, "[ERR]fw bin size\n");
 		return -EINVAL;
 	}
@@ -326,9 +350,10 @@ static int __parse_security_section(struct rtw89_dev *rtwdev,
 				    const void *content,
 				    u32 *mssc_len)
 {
+	struct rtw89_fw_secure *sec = &rtwdev->fw.sec;
 	int ret;
 
-	if (section_info->mssc == FORMATTED_MSSC) {
+	if ((section_info->mssc & FORMATTED_MSSC_MASK) == FORMATTED_MSSC) {
 		ret = __parse_formatted_mssc(rtwdev, info, section_info,
 					     content, mssc_len);
 		if (ret)
@@ -338,6 +363,14 @@ static int __parse_security_section(struct rtw89_dev *rtwdev,
 		if (info->dsp_checksum)
 			*mssc_len += section_info->mssc * FWDL_SECURITY_CHKSUM_LEN;
 
+		if (sec->secure_boot) {
+			if (sec->mss_idx >= section_info->mssc)
+				return -EFAULT;
+			section_info->key_addr = content + section_info->len +
+						 sec->mss_idx * FWDL_SECURITY_SIGLEN;
+			section_info->key_len = FWDL_SECURITY_SIGLEN;
+		}
+
 		info->secure_section_exist = true;
 	}
 
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index bd7680264849..efa63d444821 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -583,6 +583,7 @@ struct rtw89_fw_hdr_section_v1 {
 #define FWSECTION_HDR_V1_W1_REDL BIT(29)
 #define FWSECTION_HDR_V1_W2_MSSC GENMASK(7, 0)
 #define FORMATTED_MSSC 0xFF
+#define FORMATTED_MSSC_MASK GENMASK(7, 0)
 #define FWSECTION_HDR_V1_W2_BBMCU_IDX GENMASK(27, 24)
 
 struct rtw89_fw_hdr_v1 {
-- 
2.25.1


