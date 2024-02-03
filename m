Return-Path: <linux-wireless+bounces-3071-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BEC1847DDF
	for <lists+linux-wireless@lfdr.de>; Sat,  3 Feb 2024 01:33:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2D741F2B520
	for <lists+linux-wireless@lfdr.de>; Sat,  3 Feb 2024 00:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48BE746A4;
	Sat,  3 Feb 2024 00:33:53 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067F13FE0
	for <linux-wireless@vger.kernel.org>; Sat,  3 Feb 2024 00:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706920433; cv=none; b=g695ZHBxVXOPhYFLQcmKmTro6cc6Uri8yDojbx3IgaoMwbW5QWCsQPdrhekcmHYM5aNueltbFXhO4tYdftWE3iGYfsXOKaFxXuZk6AqlHke3FraUPgTY+zUbKbo8rB9PLIZwJVafHzMmaKVzsLpVCrUN755Njc/UTMJAQuaOVhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706920433; c=relaxed/simple;
	bh=E3GNsEQE+KIYl+LoS8irv0RJSGZ7lQ9JujORh6Ja96Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pCMQVl9wjNatNS4i3g6zg4GvRSnwEuyo+nVeEhQOzMDfQBsPxVvKvgqQRnAUs8qaNemqv908ZsUnwq36Q6SFIm8hc1bD4vW4HyXb1eK6G29bddChn2G9/jMHABFdB+oQPslvn2k82LMLHjc859e8CkD4N3dKdD4CiMIVCZvrTn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4130XiEC22300751, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 4130XiEC22300751
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 3 Feb 2024 08:33:44 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.17; Sat, 3 Feb 2024 08:33:45 +0800
Received: from [127.0.1.1] (172.16.16.254) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Sat, 3 Feb
 2024 08:33:44 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH 3/4] wifi: rtw89: fw: parse secure section from firmware file
Date: Sat, 3 Feb 2024 08:32:50 +0800
Message-ID: <20240203003251.10641-4-pkshih@realtek.com>
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

A firmware file can contains more than one section with secure type, so
use secure information from efuse to choose the one with matched
cryptography method. Then choose key data from MSS poll (multiple security
section pool; see below picture) according to key_index from efuse.

Note that the size of MSS pool isn't included in section size defined
in firmware header, so we also need to parse header of MSS pool to get
its size as shift to parse next section.

If secure boot isn't supported by current hardware, the first secure
section will be adopted, and no need additional process to key data.

  +---------------------------+
  |      firmware header      |
  |                           |
  | +-----------------------+ |
  | | section type/size * N-|-|-------+
  | | ...                   | |       |
  | +-----------------------+ |       |
  +---------------------------+       |
  :                           :       |
  +---------------------------+ -\    |
  | secure section type (ID:9)|  |    |
  |                           |  | <--+
  |                           |  |
  +---------------------------+ -/
  |MSS Pool for above section |
  |                           |
  |                           |
  +---------------------------+

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/fw.c | 202 ++++++++++++++++++++++--
 drivers/net/wireless/realtek/rtw89/fw.h |  39 +++++
 2 files changed, 227 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 00417364ab22..4f648071a5be 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -13,6 +13,8 @@
 #include "reg.h"
 #include "util.h"
 
+static const u8 mss_signature[] = {0x4D, 0x53, 0x53, 0x4B, 0x50, 0x4F, 0x4F, 0x4C};
+
 union rtw89_fw_element_arg {
 	size_t offset;
 	enum rtw89_rf_path rf_path;
@@ -163,6 +165,161 @@ static int rtw89_fw_hdr_parser_v0(struct rtw89_dev *rtwdev, const u8 *fw, u32 le
 	return 0;
 }
 
+static int __get_mssc_key_idx(struct rtw89_dev *rtwdev,
+			      const struct rtw89_fw_mss_pool_hdr *mss_hdr,
+			      u32 rmp_tbl_size, u32 *key_idx)
+{
+	struct rtw89_fw_secure *sec = &rtwdev->fw.sec;
+	u32 sel_byte_idx;
+	u32 mss_sel_idx;
+	u8 sel_bit_idx;
+	int i;
+
+	if (sec->mss_dev_type == RTW89_FW_MSS_DEV_TYPE_FWSEC_DEF) {
+		if (!mss_hdr->defen)
+			return -ENOENT;
+
+		mss_sel_idx = sec->mss_cust_idx * le16_to_cpu(mss_hdr->msskey_num_max) +
+			      sec->mss_key_num;
+	} else {
+		if (mss_hdr->defen)
+			mss_sel_idx = FWDL_MSS_POOL_DEFKEYSETS_SIZE << 3;
+		else
+			mss_sel_idx = 0;
+		mss_sel_idx += sec->mss_dev_type * le16_to_cpu(mss_hdr->msskey_num_max) *
+						   le16_to_cpu(mss_hdr->msscust_max) +
+			       sec->mss_cust_idx * le16_to_cpu(mss_hdr->msskey_num_max) +
+			       sec->mss_key_num;
+	}
+
+	sel_byte_idx = mss_sel_idx >> 3;
+	sel_bit_idx = mss_sel_idx & 0x7;
+
+	if (sel_byte_idx >= rmp_tbl_size)
+		return -EFAULT;
+
+	if (!(mss_hdr->rmp_tbl[sel_byte_idx] & BIT(sel_bit_idx)))
+		return -ENOENT;
+
+	*key_idx = hweight8(mss_hdr->rmp_tbl[sel_byte_idx] & (BIT(sel_bit_idx) - 1));
+
+	for (i = 0; i < sel_byte_idx; i++)
+		*key_idx += hweight8(mss_hdr->rmp_tbl[i]);
+
+	return 0;
+}
+
+static int __parse_formatted_mssc(struct rtw89_dev *rtwdev,
+				  struct rtw89_fw_bin_info *info,
+				  struct rtw89_fw_hdr_section_info *section_info,
+				  const struct rtw89_fw_hdr_section_v1 *section,
+				  const void *content,
+				  u32 *mssc_len)
+{
+	const struct rtw89_fw_mss_pool_hdr *mss_hdr = content + section_info->len;
+	const union rtw89_fw_section_mssc_content *section_content = content;
+	struct rtw89_fw_secure *sec = &rtwdev->fw.sec;
+	u32 rmp_tbl_size;
+	u32 key_sign_len;
+	u32 real_key_idx;
+	u32 sb_sel_ver;
+	int ret;
+
+	if (memcmp(mss_signature, mss_hdr->signature, sizeof(mss_signature)) != 0) {
+		rtw89_err(rtwdev, "[ERR] wrong MSS signature\n");
+		return -ENOENT;
+	}
+
+	if (mss_hdr->rmpfmt == MSS_POOL_RMP_TBL_BITMASK) {
+		rmp_tbl_size = (le16_to_cpu(mss_hdr->msskey_num_max) *
+				le16_to_cpu(mss_hdr->msscust_max) *
+				mss_hdr->mssdev_max) >> 3;
+		if (mss_hdr->defen)
+			rmp_tbl_size += FWDL_MSS_POOL_DEFKEYSETS_SIZE;
+	} else {
+		rtw89_err(rtwdev, "[ERR] MSS Key Pool Remap Table Format Unsupport:%X\n",
+			  mss_hdr->rmpfmt);
+		return -EINVAL;
+	}
+
+	if (rmp_tbl_size + sizeof(*mss_hdr) != le32_to_cpu(mss_hdr->key_raw_offset)) {
+		rtw89_err(rtwdev, "[ERR] MSS Key Pool Format Error:0x%X + 0x%X != 0x%X\n",
+			  rmp_tbl_size, (int)sizeof(*mss_hdr),
+			  le32_to_cpu(mss_hdr->key_raw_offset));
+		return -EINVAL;
+	}
+
+	key_sign_len = le16_to_cpu(section_content->key_sign_len.v) >> 2;
+	if (!key_sign_len)
+		key_sign_len = 512;
+
+	if (info->dsp_checksum)
+		key_sign_len += FWDL_SECURITY_CHKSUM_LEN;
+
+	*mssc_len = sizeof(*mss_hdr) + rmp_tbl_size +
+		    le16_to_cpu(mss_hdr->keypair_num) * key_sign_len;
+
+	if (!sec->secure_boot)
+		goto out;
+
+	sb_sel_ver = le32_to_cpu(section_content->sb_sel_ver.v);
+	if (sb_sel_ver && sb_sel_ver != sec->sb_sel_mgn)
+		goto ignore;
+
+	ret = __get_mssc_key_idx(rtwdev, mss_hdr, rmp_tbl_size, &real_key_idx);
+	if (ret)
+		goto ignore;
+
+	section_info->key_addr = content + section_info->len +
+				le32_to_cpu(mss_hdr->key_raw_offset) +
+				key_sign_len * real_key_idx;
+	section_info->key_len = key_sign_len;
+	section_info->key_idx = real_key_idx;
+
+out:
+	if (info->secure_section_exist) {
+		section_info->ignore = true;
+		return 0;
+	}
+
+	info->secure_section_exist = true;
+
+	return 0;
+
+ignore:
+	section_info->ignore = true;
+
+	return 0;
+}
+
+static int __parse_security_section(struct rtw89_dev *rtwdev,
+				    struct rtw89_fw_bin_info *info,
+				    struct rtw89_fw_hdr_section_info *section_info,
+				    const struct rtw89_fw_hdr_section_v1 *section,
+				    const void *content,
+				    u32 *mssc_len)
+{
+	int ret;
+
+	section_info->mssc =
+		le32_get_bits(section->w2, FWSECTION_HDR_V1_W2_MSSC);
+
+	if (section_info->mssc == FORMATTED_MSSC) {
+		ret = __parse_formatted_mssc(rtwdev, info, section_info,
+					     section, content, mssc_len);
+		if (ret)
+			return -EINVAL;
+	} else {
+		*mssc_len = section_info->mssc * FWDL_SECURITY_SIGLEN;
+		if (info->dsp_checksum)
+			*mssc_len += section_info->mssc * FWDL_SECURITY_CHKSUM_LEN;
+
+		info->secure_section_exist = true;
+	}
+
+	return 0;
+}
+
 static int rtw89_fw_hdr_parser_v1(struct rtw89_dev *rtwdev, const u8 *fw, u32 len,
 				  struct rtw89_fw_bin_info *info)
 {
@@ -173,7 +330,8 @@ static int rtw89_fw_hdr_parser_v1(struct rtw89_dev *rtwdev, const u8 *fw, u32 le
 	const u8 *fw_end = fw + len;
 	const u8 *bin;
 	u32 base_hdr_len;
-	u32 mssc_len = 0;
+	u32 mssc_len;
+	int ret;
 	u32 i;
 
 	info->section_num = le32_get_bits(fw_hdr->w6, FW_HDR_V1_W6_SEC_NUM);
@@ -200,18 +358,9 @@ static int rtw89_fw_hdr_parser_v1(struct rtw89_dev *rtwdev, const u8 *fw, u32 le
 	section_info = info->section_info;
 	for (i = 0; i < info->section_num; i++) {
 		section = &fw_hdr->sections[i];
+
 		section_info->type =
 			le32_get_bits(section->w1, FWSECTION_HDR_V1_W1_SECTIONTYPE);
-		if (section_info->type == FWDL_SECURITY_SECTION_TYPE) {
-			section_info->mssc =
-				le32_get_bits(section->w2, FWSECTION_HDR_V1_W2_MSSC);
-			mssc_len += section_info->mssc * FWDL_SECURITY_SIGLEN;
-			if (info->dsp_checksum)
-				mssc_len += section_info->mssc * FWDL_SECURITY_CHKSUM_LEN;
-		} else {
-			section_info->mssc = 0;
-		}
-
 		section_info->len =
 			le32_get_bits(section->w1, FWSECTION_HDR_V1_W1_SEC_SIZE);
 		if (le32_get_bits(section->w1, FWSECTION_HDR_V1_W1_CHECKSUM))
@@ -220,15 +369,40 @@ static int rtw89_fw_hdr_parser_v1(struct rtw89_dev *rtwdev, const u8 *fw, u32 le
 		section_info->dladdr =
 			le32_get_bits(section->w0, FWSECTION_HDR_V1_W0_DL_ADDR);
 		section_info->addr = bin;
-		bin += section_info->len;
+
+		if (section_info->type == FWDL_SECURITY_SECTION_TYPE) {
+			ret = __parse_security_section(rtwdev, info, section_info,
+						       section, bin, &mssc_len);
+			if (ret)
+				return ret;
+		} else {
+			section_info->mssc = 0;
+			mssc_len = 0;
+		}
+
+		rtw89_debug(rtwdev, RTW89_DBG_FW,
+			    "section[%d] type=%d len=0x%-6x mssc=%d mssc_len=%d addr=%lx\n",
+			    i, section_info->type, section_info->len,
+			    section_info->mssc, mssc_len, bin - fw);
+		rtw89_debug(rtwdev, RTW89_DBG_FW,
+			    "           ignore=%d key_addr=%p (0x%lx) key_len=%d key_idx=%d\n",
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
 
+	if (!info->secure_section_exist)
+		rtw89_warn(rtwdev, "no firmware secure section\n");
+
 	return 0;
 }
 
@@ -1106,7 +1280,7 @@ static int rtw89_fw_download_suit(struct rtw89_dev *rtwdev,
 				  struct rtw89_fw_suit *fw_suit)
 {
 	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
-	struct rtw89_fw_bin_info info;
+	struct rtw89_fw_bin_info info = {};
 	int ret;
 
 	ret = rtw89_fw_hdr_parser(rtwdev, fw_suit, &info);
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index 5b536c2e365d..c05ddb0d5900 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -230,6 +230,10 @@ struct rtw89_fw_hdr_section_info {
 	u32 dladdr;
 	u32 mssc;
 	u8 type;
+	bool ignore;
+	const u8 *key_addr;
+	u32 key_len;
+	u32 key_idx;
 };
 
 struct rtw89_fw_bin_info {
@@ -238,6 +242,7 @@ struct rtw89_fw_bin_info {
 	bool dynamic_hdr_en;
 	u32 dynamic_hdr_len;
 	bool dsp_checksum;
+	bool secure_section_exist;
 	struct rtw89_fw_hdr_section_info section_info[FWDL_SECTION_MAX_NUM];
 };
 
@@ -538,6 +543,7 @@ struct rtw89_fw_hdr_section_v1 {
 #define FWSECTION_HDR_V1_W1_CHECKSUM BIT(28)
 #define FWSECTION_HDR_V1_W1_REDL BIT(29)
 #define FWSECTION_HDR_V1_W2_MSSC GENMASK(7, 0)
+#define FORMATTED_MSSC 0xFF
 #define FWSECTION_HDR_V1_W2_BBMCU_IDX GENMASK(27, 24)
 
 struct rtw89_fw_hdr_v1 {
@@ -578,6 +584,39 @@ static inline void SET_FW_HDR_PART_SIZE(void *fwhdr, u32 val)
 	le32p_replace_bits((__le32 *)fwhdr + 7, val, GENMASK(15, 0));
 }
 
+enum rtw89_fw_mss_pool_rmp_tbl_type {
+	MSS_POOL_RMP_TBL_BITMASK = 0x0,
+	MSS_POOL_RMP_TBL_RECORD = 0x1,
+};
+
+#define FWDL_MSS_POOL_DEFKEYSETS_SIZE 8
+
+struct rtw89_fw_mss_pool_hdr {
+	u8 signature[8]; /* equal to mss_signature[] */
+	__le32 rmp_tbl_offset;
+	__le32 key_raw_offset;
+	u8 defen;
+	u8 rsvd[3];
+	u8 rmpfmt; /* enum rtw89_fw_mss_pool_rmp_tbl_type */
+	u8 mssdev_max;
+	__le16 keypair_num;
+	__le16 msscust_max;
+	__le16 msskey_num_max;
+	__le32 rsvd3;
+	u8 rmp_tbl[];
+} __packed;
+
+union rtw89_fw_section_mssc_content {
+	struct {
+		u8 pad[58];
+		__le32 v;
+	} __packed sb_sel_ver;
+	struct {
+		u8 pad[60];
+		__le16 v;
+	} __packed key_sign_len;
+} __packed;
+
 static inline void SET_CTRL_INFO_MACID(void *table, u32 val)
 {
 	le32p_replace_bits((__le32 *)(table) + 0, val, GENMASK(6, 0));
-- 
2.25.1


