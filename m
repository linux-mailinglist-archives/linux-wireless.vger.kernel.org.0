Return-Path: <linux-wireless+bounces-22614-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4939FAAB635
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 07:45:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45BA21BC484E
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 05:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7B0A330AD5;
	Tue,  6 May 2025 00:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IoeBMWgY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233EA278142;
	Mon,  5 May 2025 22:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485362; cv=none; b=eOPwGQNosZ5xHoJvbB1NaBUlsurCGMF5PgvkhIW7UI7YS0XJNZj/Dhw5vXlTZBaRPb7jIaOzkmtJacWXT9eMTYYn1wthODqr8yNia3jiur1IYqHQCixsKAtUIPMbIgxL5g9qfgxf/JuoXKnyhalhLyPwdhfz9mR+clTMD/nINIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485362; c=relaxed/simple;
	bh=kmTx7Nrc4mg0Uas3fyLFUKFjADesNNh1UoTavH5BHk8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rP0RmEuwiUOpDW5MO5Jym0TnhsRgB9xJfpZK5il/gvb+/2f0kKho9N9aWp4vfSZWbEiI1gHVKPRAz2lfi6T2nmjKsn28oBz/wWHWQkkgNM7B64jhakAJDMoiRVi1DLaOV5YJzIYMPq6S+alTEtC3pE6H9mU3Cb8WEVNPGCOFMys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IoeBMWgY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5727BC4CEEE;
	Mon,  5 May 2025 22:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485362;
	bh=kmTx7Nrc4mg0Uas3fyLFUKFjADesNNh1UoTavH5BHk8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IoeBMWgY3htiY6YU7J+uioDhOSvhUCGs9++CjTEKrcCpKcCPfCvdCczy02Hq1p3N6
	 5mdJ0nOowCPLYpWElW0LQMty7QlyZS9pBQq3DgGsKRLYzaK/WehKhjIyykXcuUyMqy
	 fFW8xALEJgPD+LJMic8Lmh8CWZ6XzRgDEUxr56ULWcePMWq4pdzEL+CYbVBnA53xvl
	 HrK5ZSrFWTb9sceOC9BKOJFbHSNpcEpFV0GU76uIOPPzBS/H9gXt90AeYjUgAph1q5
	 NvBoY0vxrGRkULnYh+uBd+6bdx8NPtMlPkj/suOnuSk2GHdqk/he1XDgLUuBcEn5tp
	 XnPbKvTIIMzDQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ping-Ke Shih <pkshih@realtek.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 289/486] wifi: rtw89: fw: add blacklist to avoid obsolete secure firmware
Date: Mon,  5 May 2025 18:36:05 -0400
Message-Id: <20250505223922.2682012-289-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
Content-Transfer-Encoding: 8bit

From: Ping-Ke Shih <pkshih@realtek.com>

[ Upstream commit f11d042b3a2e92ab1aa10e0da8e290bcdcf31d39 ]

To ensure secure chip only runs expected secure firmware, stop using
obsolete firmware in blacklist which weakness or flaw was found.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Link: https://patch.msgid.link/20250217064308.43559-2-pkshih@realtek.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/realtek/rtw89/core.h     |  2 +
 drivers/net/wireless/realtek/rtw89/fw.c       | 52 ++++++++++++++++++-
 drivers/net/wireless/realtek/rtw89/fw.h       | 12 +++++
 drivers/net/wireless/realtek/rtw89/rtw8851b.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c |  1 +
 .../net/wireless/realtek/rtw89/rtw8852bt.c    |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8922a.c |  1 +
 9 files changed, 71 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index ff3048d2489f1..4f64ea392e6c9 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -17,6 +17,7 @@ struct rtw89_dev;
 struct rtw89_pci_info;
 struct rtw89_mac_gen_def;
 struct rtw89_phy_gen_def;
+struct rtw89_fw_blacklist;
 struct rtw89_efuse_block_cfg;
 struct rtw89_h2c_rf_tssi;
 struct rtw89_fw_txpwr_track_cfg;
@@ -4232,6 +4233,7 @@ struct rtw89_chip_info {
 	bool try_ce_fw;
 	u8 bbmcu_nr;
 	u32 needed_fw_elms;
+	const struct rtw89_fw_blacklist *fw_blacklist;
 	u32 fifo_size;
 	bool small_fifo_size;
 	u32 dle_scc_rsvd_size;
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index f0e87af68d8cb..93d760b8b5e35 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -38,6 +38,16 @@ struct rtw89_arp_rsp {
 
 static const u8 mss_signature[] = {0x4D, 0x53, 0x53, 0x4B, 0x50, 0x4F, 0x4F, 0x4C};
 
+const struct rtw89_fw_blacklist rtw89_fw_blacklist_default = {
+	.ver = 0x00,
+	.list = {0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0,
+		 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0,
+		 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0,
+		 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0,
+	},
+};
+EXPORT_SYMBOL(rtw89_fw_blacklist_default);
+
 union rtw89_fw_element_arg {
 	size_t offset;
 	enum rtw89_rf_path rf_path;
@@ -315,6 +325,46 @@ static int __parse_formatted_mssc(struct rtw89_dev *rtwdev,
 	return 0;
 }
 
+static int __check_secure_blacklist(struct rtw89_dev *rtwdev,
+				    struct rtw89_fw_bin_info *info,
+				    struct rtw89_fw_hdr_section_info *section_info,
+				    const void *content)
+{
+	const struct rtw89_fw_blacklist *chip_blacklist = rtwdev->chip->fw_blacklist;
+	const union rtw89_fw_section_mssc_content *section_content = content;
+	struct rtw89_fw_secure *sec = &rtwdev->fw.sec;
+	u8 byte_idx;
+	u8 bit_mask;
+
+	if (!sec->secure_boot)
+		return 0;
+
+	if (!info->secure_section_exist || section_info->ignore)
+		return 0;
+
+	if (!chip_blacklist) {
+		rtw89_err(rtwdev, "chip no blacklist for secure firmware\n");
+		return -ENOENT;
+	}
+
+	byte_idx = section_content->blacklist.bit_in_chip_list >> 3;
+	bit_mask = BIT(section_content->blacklist.bit_in_chip_list & 0x7);
+
+	if (section_content->blacklist.ver > chip_blacklist->ver) {
+		rtw89_err(rtwdev, "chip blacklist out of date (%u, %u)\n",
+			  section_content->blacklist.ver, chip_blacklist->ver);
+		return -EINVAL;
+	}
+
+	if (chip_blacklist->list[byte_idx] & bit_mask) {
+		rtw89_err(rtwdev, "firmware %u in chip blacklist\n",
+			  section_content->blacklist.ver);
+		return -EPERM;
+	}
+
+	return 0;
+}
+
 static int __parse_security_section(struct rtw89_dev *rtwdev,
 				    struct rtw89_fw_bin_info *info,
 				    struct rtw89_fw_hdr_section_info *section_info,
@@ -340,7 +390,7 @@ static int __parse_security_section(struct rtw89_dev *rtwdev,
 		info->secure_section_exist = true;
 	}
 
-	return 0;
+	return __check_secure_blacklist(rtwdev, info, section_info, content);
 }
 
 static int rtw89_fw_hdr_parser_v1(struct rtw89_dev *rtwdev, const u8 *fw, u32 len,
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index ccbbc43f33fee..502ece540b9dc 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -639,6 +639,11 @@ struct rtw89_fw_mss_pool_hdr {
 } __packed;
 
 union rtw89_fw_section_mssc_content {
+	struct {
+		u8 pad[0x20];
+		u8 bit_in_chip_list;
+		u8 ver;
+	} __packed blacklist;
 	struct {
 		u8 pad[58];
 		__le32 v;
@@ -649,6 +654,13 @@ union rtw89_fw_section_mssc_content {
 	} __packed key_sign_len;
 } __packed;
 
+struct rtw89_fw_blacklist {
+	u8 ver;
+	u8 list[32];
+};
+
+extern const struct rtw89_fw_blacklist rtw89_fw_blacklist_default;
+
 static inline void SET_CTRL_INFO_MACID(void *table, u32 val)
 {
 	le32p_replace_bits((__le32 *)(table) + 0, val, GENMASK(6, 0));
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b.c b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
index f9766bf30e71d..0d2a1e712b345 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
@@ -2443,6 +2443,7 @@ const struct rtw89_chip_info rtw8851b_chip_info = {
 	.try_ce_fw		= true,
 	.bbmcu_nr		= 0,
 	.needed_fw_elms		= 0,
+	.fw_blacklist		= NULL,
 	.fifo_size		= 196608,
 	.small_fifo_size	= true,
 	.dle_scc_rsvd_size	= 98304,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index 42d369d2e916a..5f08207936c68 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -2159,6 +2159,7 @@ const struct rtw89_chip_info rtw8852a_chip_info = {
 	.try_ce_fw		= false,
 	.bbmcu_nr		= 0,
 	.needed_fw_elms		= 0,
+	.fw_blacklist		= NULL,
 	.fifo_size		= 458752,
 	.small_fifo_size	= false,
 	.dle_scc_rsvd_size	= 0,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index 364aa21cbd446..0e03d97ba1cf6 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -797,6 +797,7 @@ const struct rtw89_chip_info rtw8852b_chip_info = {
 	.try_ce_fw		= true,
 	.bbmcu_nr		= 0,
 	.needed_fw_elms		= 0,
+	.fw_blacklist		= &rtw89_fw_blacklist_default,
 	.fifo_size		= 196608,
 	.small_fifo_size	= true,
 	.dle_scc_rsvd_size	= 98304,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852bt.c b/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
index dab7e71ec6a14..1dd3e51bab9f3 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
@@ -731,6 +731,7 @@ const struct rtw89_chip_info rtw8852bt_chip_info = {
 	.try_ce_fw		= true,
 	.bbmcu_nr		= 0,
 	.needed_fw_elms		= RTW89_AX_GEN_DEF_NEEDED_FW_ELEMENTS_NO_6GHZ,
+	.fw_blacklist		= &rtw89_fw_blacklist_default,
 	.fifo_size		= 458752,
 	.small_fifo_size	= true,
 	.dle_scc_rsvd_size	= 98304,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index dbe77abb2c488..5e2592cf1a9fa 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -2936,6 +2936,7 @@ const struct rtw89_chip_info rtw8852c_chip_info = {
 	.try_ce_fw		= false,
 	.bbmcu_nr		= 0,
 	.needed_fw_elms		= 0,
+	.fw_blacklist		= &rtw89_fw_blacklist_default,
 	.fifo_size		= 458752,
 	.small_fifo_size	= false,
 	.dle_scc_rsvd_size	= 0,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a.c b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
index ef7747adbcc2b..64a41f24b2adb 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
@@ -2632,6 +2632,7 @@ const struct rtw89_chip_info rtw8922a_chip_info = {
 	.try_ce_fw		= false,
 	.bbmcu_nr		= 1,
 	.needed_fw_elms		= RTW89_BE_GEN_DEF_NEEDED_FW_ELEMENTS,
+	.fw_blacklist		= &rtw89_fw_blacklist_default,
 	.fifo_size		= 589824,
 	.small_fifo_size	= false,
 	.dle_scc_rsvd_size	= 0,
-- 
2.39.5


