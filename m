Return-Path: <linux-wireless+bounces-19044-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 58BE5A37BA1
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Feb 2025 07:44:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1723B16A39F
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Feb 2025 06:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0440519048F;
	Mon, 17 Feb 2025 06:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="In6wUvwf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902AD18DB3A
	for <linux-wireless@vger.kernel.org>; Mon, 17 Feb 2025 06:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739774640; cv=none; b=X6OqAYdLUzLLwwiLaKA2iXs9v1UAfpmjAjDopAji602TYKxO66yMEPdBc0ZztXLu5MwFTSDzGcw6b0ZUdtKk9hVKO2csiuQamKyE8rvjUIbdCp47Np1q2HKVs3WhZar7Fq76iJMPsPoNj8dPVv16/ECKhaKCQXKhn0rHyUrQthA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739774640; c=relaxed/simple;
	bh=QzDhFC+qjq5po4vKdM5rekFhw+66eb3zvX0TJ76zaNw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KTAozW7aQFtOWL2bpoqL8ylzUB50LCpXHNojmmjWP4bEMxcdIFqkj8U2UHS3Rw8knd6jZ7wgRsiI1gvxNejlBsAgCnvEFhkHCHOkltT7uzywMlo/wjMT/kGhTwpVkwOzDcQPfqo5WbCDrR8vKTTOdOmtiF5+l8Pj2LQE4YPd9Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=In6wUvwf; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 51H6htSbB2646680, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1739774636; bh=QzDhFC+qjq5po4vKdM5rekFhw+66eb3zvX0TJ76zaNw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=In6wUvwfddsgh4wky2DJuZ6axLO/Q/01p8vP4uo0Z2c8eaxAwtMiNpT5yzDTIIf9k
	 o7gJ7zZV77zCLYIN3jJvYFDUQLASQDCU3lZzCQHInMkO972yQO+R/P75ZoSiJRRAG9
	 HZ48hligExY5xZXTRgHrMXBbSzxngIOw2aa4EzlTUs72tfO2GP+Dt/aKYwmclabRgm
	 pyVSsYeVItHW3Z8ZuAoIYpS3hJeMDL295SOHVcYvfj+ue7IPKOyHTIlpICpGQ2INHH
	 b4DCM/XI3LiNcJz5twA3v0TUZymCQqdiD2URBM9tJjZqa5td9ij7/Z5G9L8OtvhYIb
	 WSkfXMrZWv6eA==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 51H6htSbB2646680
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 17 Feb 2025 14:43:55 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 17 Feb 2025 14:43:56 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 17 Feb
 2025 14:43:56 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH 1/5] wifi: rtw89: fw: add blacklist to avoid obsolete secure firmware
Date: Mon, 17 Feb 2025 14:43:04 +0800
Message-ID: <20250217064308.43559-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250217064308.43559-1-pkshih@realtek.com>
References: <20250217064308.43559-1-pkshih@realtek.com>
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

To ensure secure chip only runs expected secure firmware, stop using
obsolete firmware in blacklist which weakness or flaw was found.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
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
index b3fdd8eded21..5044d78435b8 100644
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
@@ -4257,6 +4258,7 @@ struct rtw89_chip_info {
 	bool try_ce_fw;
 	u8 bbmcu_nr;
 	u32 needed_fw_elms;
+	const struct rtw89_fw_blacklist *fw_blacklist;
 	u32 fifo_size;
 	bool small_fifo_size;
 	u32 dle_scc_rsvd_size;
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 35b86970db2a..17f80f1f23df 100644
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
@@ -344,6 +354,46 @@ static int __parse_formatted_mssc(struct rtw89_dev *rtwdev,
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
@@ -374,7 +424,7 @@ static int __parse_security_section(struct rtw89_dev *rtwdev,
 		info->secure_section_exist = true;
 	}
 
-	return 0;
+	return __check_secure_blacklist(rtwdev, info, section_info, content);
 }
 
 static int rtw89_fw_hdr_parser_v1(struct rtw89_dev *rtwdev, const u8 *fw, u32 len,
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index 994d109a9c3c..31d44513b181 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -663,6 +663,11 @@ struct rtw89_fw_mss_pool_hdr {
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
@@ -673,6 +678,13 @@ union rtw89_fw_section_mssc_content {
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
index 82289dbad1f4..8fba6413a5cb 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
@@ -2458,6 +2458,7 @@ const struct rtw89_chip_info rtw8851b_chip_info = {
 	.try_ce_fw		= true,
 	.bbmcu_nr		= 0,
 	.needed_fw_elms		= 0,
+	.fw_blacklist		= NULL,
 	.fifo_size		= 196608,
 	.small_fifo_size	= true,
 	.dle_scc_rsvd_size	= 98304,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index 2046832d021f..1b958c559aac 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -2175,6 +2175,7 @@ const struct rtw89_chip_info rtw8852a_chip_info = {
 	.try_ce_fw		= false,
 	.bbmcu_nr		= 0,
 	.needed_fw_elms		= 0,
+	.fw_blacklist		= NULL,
 	.fifo_size		= 458752,
 	.small_fifo_size	= false,
 	.dle_scc_rsvd_size	= 0,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index 652914a36245..780fc19d617f 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -811,6 +811,7 @@ const struct rtw89_chip_info rtw8852b_chip_info = {
 	.try_ce_fw		= true,
 	.bbmcu_nr		= 0,
 	.needed_fw_elms		= 0,
+	.fw_blacklist		= &rtw89_fw_blacklist_default,
 	.fifo_size		= 196608,
 	.small_fifo_size	= true,
 	.dle_scc_rsvd_size	= 98304,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852bt.c b/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
index 6f15245b2f74..1173496a075d 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
@@ -745,6 +745,7 @@ const struct rtw89_chip_info rtw8852bt_chip_info = {
 	.try_ce_fw		= true,
 	.bbmcu_nr		= 0,
 	.needed_fw_elms		= RTW89_AX_GEN_DEF_NEEDED_FW_ELEMENTS_NO_6GHZ,
+	.fw_blacklist		= &rtw89_fw_blacklist_default,
 	.fifo_size		= 458752,
 	.small_fifo_size	= true,
 	.dle_scc_rsvd_size	= 98304,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index ecc1ff358583..c61e4953bc97 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -2967,6 +2967,7 @@ const struct rtw89_chip_info rtw8852c_chip_info = {
 	.try_ce_fw		= false,
 	.bbmcu_nr		= 0,
 	.needed_fw_elms		= 0,
+	.fw_blacklist		= &rtw89_fw_blacklist_default,
 	.fifo_size		= 458752,
 	.small_fifo_size	= false,
 	.dle_scc_rsvd_size	= 0,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a.c b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
index 898a65a721dc..da26ba22e7e6 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
@@ -2728,6 +2728,7 @@ const struct rtw89_chip_info rtw8922a_chip_info = {
 	.try_ce_fw		= false,
 	.bbmcu_nr		= 1,
 	.needed_fw_elms		= RTW89_BE_GEN_DEF_NEEDED_FW_ELEMENTS,
+	.fw_blacklist		= &rtw89_fw_blacklist_default,
 	.fifo_size		= 589824,
 	.small_fifo_size	= false,
 	.dle_scc_rsvd_size	= 0,
-- 
2.25.1


