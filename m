Return-Path: <linux-wireless+bounces-3072-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A418E847DE0
	for <lists+linux-wireless@lfdr.de>; Sat,  3 Feb 2024 01:34:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05D69290FA6
	for <lists+linux-wireless@lfdr.de>; Sat,  3 Feb 2024 00:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE0BB5C9A;
	Sat,  3 Feb 2024 00:33:57 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A1653A1
	for <linux-wireless@vger.kernel.org>; Sat,  3 Feb 2024 00:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706920437; cv=none; b=XtkbQ2xOelEU0NjAruu1ZQMx5A5tY7VuQ8RKLFgwKzySEqxxbmVsaNHKd3Ofl5vRkXg5J+H0DlJ9fKVnljXh4leOByRV/vS13jrE5+ItjaEO8rl4wMCDVGavXJJ+THmU/OPwrZ2ySljxhlQC+MuLW7g4ijD6tBnbqQ8VIzF0hW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706920437; c=relaxed/simple;
	bh=XGg5vaQSKlPc+mHn7axNEQqysRbjmc4Z8/nyssGLl2U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I6Wpbg/xtfMggRpgVea66sZb5E7UWJYMR+71NgZqa2Lf6uyOZ/fOi+ANog3UAXarE+1HyElEWGWrRfFSeu3bZXicw8ptHO3ZGaFI3TmFNKIeup0IqjdR9eFgNz9mLeXbDx7N9B0l37w+4tCpRXAY1PLWWGEaVPiVGVguSvkzlSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4130XnHtA2300759, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 4130XnHtA2300759
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 3 Feb 2024 08:33:49 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.32; Sat, 3 Feb 2024 08:33:50 +0800
Received: from [127.0.1.1] (172.16.16.254) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Sat, 3 Feb
 2024 08:33:49 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH 4/4] wifi: rtw89: fw: download firmware with key data for secure boot
Date: Sat, 3 Feb 2024 08:32:51 +0800
Message-ID: <20240203003251.10641-5-pkshih@realtek.com>
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

Since firmware header contains multiple secure sections, we need to trim
ignored sections, and then download firmware header with single one secure
section.

For secure boot, when downloading secure section, copy security key data
from MSS poll by key_idx read from efuse. If non-secure boot, no need this
extra copy.

           +---------------------------+ -\
           |      firmware header      |  |
           |                           |  |
           | +-----------------------+ |  | only preserve single one secure
           | | section type/size * N | |  | section
           | | ...                   | |  |
           | +-----------------------+ |  |
           +---------------------------+ -/
           :                           :
           +---------------------------+ -\
           | secure section type (ID:9)|  |
           |                           |  |
      +----|-> [ security key data ]   |  |
      |    +---------------------------+ -/
      |    |MSS Pool for above section |
      |    |  [ security key data 0 ]  |
      +----|- [ security key data 1 ]  |
by key_idx |  [ security key data 2 ]  |
           |  ...                      |
           +---------------------------+

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.c | 95 +++++++++++++++++++++++--
 drivers/net/wireless/realtek/rtw89/fw.h |  7 +-
 2 files changed, 91 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 4f648071a5be..61d6297475e5 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -1098,9 +1098,56 @@ static void rtw89_h2c_pkt_set_hdr_fwdl(struct rtw89_dev *rtwdev,
 					   len + H2C_HEADER_LEN));
 }
 
-static int __rtw89_fw_download_hdr(struct rtw89_dev *rtwdev, const u8 *fw, u32 len)
+static u32 __rtw89_fw_download_tweak_hdr_v0(struct rtw89_dev *rtwdev,
+					    struct rtw89_fw_bin_info *info,
+					    struct rtw89_fw_hdr *fw_hdr)
 {
+	le32p_replace_bits(&fw_hdr->w7, FWDL_SECTION_PER_PKT_LEN,
+			   FW_HDR_W7_PART_SIZE);
+
+	return 0;
+}
+
+static u32 __rtw89_fw_download_tweak_hdr_v1(struct rtw89_dev *rtwdev,
+					    struct rtw89_fw_bin_info *info,
+					    struct rtw89_fw_hdr_v1 *fw_hdr)
+{
+	struct rtw89_fw_hdr_section_info *section_info;
+	struct rtw89_fw_hdr_section_v1 *section;
+	u8 dst_sec_idx = 0;
+	u8 sec_idx;
+
+	le32p_replace_bits(&fw_hdr->w7, FWDL_SECTION_PER_PKT_LEN,
+			   FW_HDR_V1_W7_PART_SIZE);
+
+	for (sec_idx = 0; sec_idx < info->section_num; sec_idx++) {
+		section_info = &info->section_info[sec_idx];
+		section = &fw_hdr->sections[sec_idx];
+
+		if (section_info->ignore)
+			continue;
+
+		if (dst_sec_idx != sec_idx)
+			fw_hdr->sections[dst_sec_idx] = *section;
+
+		dst_sec_idx++;
+	}
+
+	le32p_replace_bits(&fw_hdr->w6, dst_sec_idx, FW_HDR_V1_W6_SEC_NUM);
+
+	return (info->section_num - dst_sec_idx) * sizeof(*section);
+}
+
+static int __rtw89_fw_download_hdr(struct rtw89_dev *rtwdev,
+				   const struct rtw89_fw_suit *fw_suit,
+				   struct rtw89_fw_bin_info *info)
+{
+	u32 len = info->hdr_len - info->dynamic_hdr_len;
+	struct rtw89_fw_hdr_v1 *fw_hdr_v1;
+	const u8 *fw = fw_suit->data;
+	struct rtw89_fw_hdr *fw_hdr;
 	struct sk_buff *skb;
+	u32 truncated;
 	u32 ret = 0;
 
 	skb = rtw89_fw_h2c_alloc_skb_with_hdr(rtwdev, len);
@@ -1110,7 +1157,26 @@ static int __rtw89_fw_download_hdr(struct rtw89_dev *rtwdev, const u8 *fw, u32 l
 	}
 
 	skb_put_data(skb, fw, len);
-	SET_FW_HDR_PART_SIZE(skb->data, FWDL_SECTION_PER_PKT_LEN);
+
+	switch (fw_suit->hdr_ver) {
+	case 0:
+		fw_hdr = (struct rtw89_fw_hdr *)skb->data;
+		truncated = __rtw89_fw_download_tweak_hdr_v0(rtwdev, info, fw_hdr);
+		break;
+	case 1:
+		fw_hdr_v1 = (struct rtw89_fw_hdr_v1 *)skb->data;
+		truncated = __rtw89_fw_download_tweak_hdr_v1(rtwdev, info, fw_hdr_v1);
+		break;
+	default:
+		ret = -EOPNOTSUPP;
+		goto fail;
+	}
+
+	if (truncated) {
+		len -= truncated;
+		skb_trim(skb, len);
+	}
+
 	rtw89_h2c_pkt_set_hdr_fwdl(rtwdev, skb, FWCMD_TYPE_H2C,
 				   H2C_CAT_MAC, H2C_CL_MAC_FWDL,
 				   H2C_FUNC_MAC_FWHDR_DL, len);
@@ -1129,12 +1195,14 @@ static int __rtw89_fw_download_hdr(struct rtw89_dev *rtwdev, const u8 *fw, u32 l
 	return ret;
 }
 
-static int rtw89_fw_download_hdr(struct rtw89_dev *rtwdev, const u8 *fw, u32 len)
+static int rtw89_fw_download_hdr(struct rtw89_dev *rtwdev,
+				 const struct rtw89_fw_suit *fw_suit,
+				 struct rtw89_fw_bin_info *info)
 {
 	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
 	int ret;
 
-	ret = __rtw89_fw_download_hdr(rtwdev, fw, len);
+	ret = __rtw89_fw_download_hdr(rtwdev, fw_suit, info);
 	if (ret) {
 		rtw89_err(rtwdev, "[ERR]FW header download\n");
 		return ret;
@@ -1158,9 +1226,21 @@ static int __rtw89_fw_download_main(struct rtw89_dev *rtwdev,
 	struct sk_buff *skb;
 	const u8 *section = info->addr;
 	u32 residue_len = info->len;
+	bool copy_key = false;
 	u32 pkt_len;
 	int ret;
 
+	if (info->ignore)
+		return 0;
+
+	if (info->key_addr && info->key_len) {
+		if (info->len > FWDL_SECTION_PER_PKT_LEN || info->len < info->key_len)
+			rtw89_warn(rtwdev, "ignore to copy key data because of len %d, %d, %d\n",
+				   info->len, FWDL_SECTION_PER_PKT_LEN, info->key_len);
+		else
+			copy_key = true;
+	}
+
 	while (residue_len) {
 		if (residue_len >= FWDL_SECTION_PER_PKT_LEN)
 			pkt_len = FWDL_SECTION_PER_PKT_LEN;
@@ -1174,6 +1254,10 @@ static int __rtw89_fw_download_main(struct rtw89_dev *rtwdev,
 		}
 		skb_put_data(skb, section, pkt_len);
 
+		if (copy_key)
+			memcpy(skb->data + pkt_len - info->key_len,
+			       info->key_addr, info->key_len);
+
 		ret = rtw89_h2c_tx(rtwdev, skb, true);
 		if (ret) {
 			rtw89_err(rtwdev, "failed to send h2c\n");
@@ -1299,8 +1383,7 @@ static int rtw89_fw_download_suit(struct rtw89_dev *rtwdev,
 		return ret;
 	}
 
-	ret = rtw89_fw_download_hdr(rtwdev, fw_suit->data, info.hdr_len -
-							   info.dynamic_hdr_len);
+	ret = rtw89_fw_download_hdr(rtwdev, fw_suit, &info);
 	if (ret)
 		return ret;
 
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index c05ddb0d5900..58e4802cb766 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -526,6 +526,7 @@ struct rtw89_fw_hdr {
 #define FW_HDR_W4_MIN GENMASK(31, 24)
 #define FW_HDR_W5_YEAR GENMASK(31, 0)
 #define FW_HDR_W6_SEC_NUM GENMASK(15, 8)
+#define FW_HDR_W7_PART_SIZE GENMASK(15, 0)
 #define FW_HDR_W7_DYN_HDR BIT(16)
 #define FW_HDR_W7_CMD_VERSERION GENMASK(31, 24)
 
@@ -577,13 +578,9 @@ struct rtw89_fw_hdr_v1 {
 #define FW_HDR_V1_W5_HDR_SIZE GENMASK(31, 16)
 #define FW_HDR_V1_W6_SEC_NUM GENMASK(15, 8)
 #define FW_HDR_V1_W6_DSP_CHKSUM BIT(24)
+#define FW_HDR_V1_W7_PART_SIZE GENMASK(15, 0)
 #define FW_HDR_V1_W7_DYN_HDR BIT(16)
 
-static inline void SET_FW_HDR_PART_SIZE(void *fwhdr, u32 val)
-{
-	le32p_replace_bits((__le32 *)fwhdr + 7, val, GENMASK(15, 0));
-}
-
 enum rtw89_fw_mss_pool_rmp_tbl_type {
 	MSS_POOL_RMP_TBL_BITMASK = 0x0,
 	MSS_POOL_RMP_TBL_RECORD = 0x1,
-- 
2.25.1


