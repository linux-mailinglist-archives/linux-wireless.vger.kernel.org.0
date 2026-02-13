Return-Path: <linux-wireless+bounces-31795-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uL2qOdrBjmkMEgEAu9opvQ
	(envelope-from <linux-wireless+bounces-31795-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Feb 2026 07:16:58 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E74B133356
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Feb 2026 07:16:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EB5A4301DFA1
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Feb 2026 06:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11315261B71;
	Fri, 13 Feb 2026 06:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="ACK2UgiD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529C8278753
	for <linux-wireless@vger.kernel.org>; Fri, 13 Feb 2026 06:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770963416; cv=none; b=CRLZ9zc3vL+zsbffxhYvGnUZ95xI0cdmSzcLen+8Ne9c07uZpNzy+xLH9VyY72TKdp5/JukWu+LKZMmpC7WguGN3qIaNPSTDomMy2DxvmQCk+7IMoD74MiFklJj5KjlCh+aJ4mQPymWhKzSCnIfJJEOywVfC/aTbPtvqe0nhwCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770963416; c=relaxed/simple;
	bh=dY7mJ5vGbuFLgZCzwrSIsksLjHZEi0maKp0P1FXI2QU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LAt8PLcCU2b0nuxeE6OkAG8k/saoxIUQZb5xaW8GKXYj5RdbywKepi3ShtuOg9KXR+fUQPXoF3ESpxf7isFdT7r39AO/s1frotwJ4Lp/GsI8io2XW/ehtpRLZZ42opO/scRf1nRNwDEdAyCLUOatPt8EeXrBr6OQj0sh1NbD1ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=ACK2UgiD; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 61D6GpwfE1418810, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1770963411; bh=NaktdtMK9qaMWhrdn3ltBF5a24dpaNQ1ncdrYR/KABw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=ACK2UgiDHZPvTPk/WdMF73/NVlj/YMcmS4jyJq6jAqppLdR9d7HtBiIX+cW1S3ovG
	 mcuZX6b9JiXVSdMvqoj+BNVcF2GI6YlqH6OLt2cIo1iPZMJ6/wCknTzanas4fQC5W4
	 20WvyF25zYgkTzyrxStsDczSiqu69CNhThbk2RHFitA9N5ueN05j+zQ7fMbkZRl4ZH
	 wcwFCYX4cAeD3WBS/VFKrUJJuBL7e1Riq1JiehqFeS5KrVf3R9ua0IqHX0UWHCwfeL
	 arZBlgBS9n85oFMI7MRBZP43iu4VjDPYw4dJynZYfkUEW2kjHeM4kh0/VOdBO+9R8o
	 9kASbmYFQvZ+A==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 61D6GpwfE1418810
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 13 Feb 2026 14:16:51 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 13 Feb 2026 14:16:52 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 13 Feb 2026 14:16:52 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS05.realtek.com.tw
 (10.21.1.55) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Fri, 13 Feb 2026 14:16:52 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <damon.chen@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 01/12] wifi: rtw89: fw: add fw_def struct to put firmware name and format version
Date: Fri, 13 Feb 2026 14:15:41 +0800
Message-ID: <20260213061552.29997-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260213061552.29997-1-pkshih@realtek.com>
References: <20260213061552.29997-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-31795-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[realtek.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 8E74B133356
X-Rspamd-Action: no action

The RTL8922DE has a RTL8922DE-VS variant which uses different firmware
name and format version, and the rule to select firmware type will be
needed to extend. Prepare for coming patches.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c     |  3 ++-
 drivers/net/wireless/realtek/rtw89/core.h     | 25 +++++++++++++++++--
 drivers/net/wireless/realtek/rtw89/fw.c       | 10 +++++---
 drivers/net/wireless/realtek/rtw89/fw.h       |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8851b.c |  6 +++--
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |  6 +++--
 drivers/net/wireless/realtek/rtw89/rtw8852b.c |  6 +++--
 .../net/wireless/realtek/rtw89/rtw8852bt.c    |  6 +++--
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |  6 +++--
 drivers/net/wireless/realtek/rtw89/rtw8922a.c |  7 ++++--
 10 files changed, 57 insertions(+), 19 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 6e77522bcd8f..bba5e7669b1b 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -6753,7 +6753,8 @@ struct rtw89_dev *rtw89_alloc_ieee80211_hw(struct device *device,
 	bool support_mlo;
 	bool no_chanctx;
 
-	firmware = rtw89_early_fw_feature_recognize(device, chip, &early_fw, &fw_format);
+	firmware = rtw89_early_fw_feature_recognize(device, chip, variant,
+						    &early_fw, &fw_format);
 
 	ops = kmemdup(&rtw89_ops, sizeof(rtw89_ops), GFP_KERNEL);
 	if (!ops)
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 4778957d6b2d..5cb8aacf7644 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -4152,6 +4152,11 @@ struct rtw89_reg_imr {
 	u32 set;
 };
 
+struct rtw89_fw_def {
+	const char *fw_basename;
+	u8 fw_format_max;
+};
+
 struct rtw89_phy_table {
 	const struct rtw89_reg2_def *regs;
 	u32 n_regs;
@@ -4494,8 +4499,7 @@ struct rtw89_chip_info {
 	const struct rtw89_chip_ops *ops;
 	const struct rtw89_mac_gen_def *mac_def;
 	const struct rtw89_phy_gen_def *phy_def;
-	const char *fw_basename;
-	u8 fw_format_max;
+	struct rtw89_fw_def fw_def;
 	bool try_ce_fw;
 	u8 bbmcu_nr;
 	u32 needed_fw_elms;
@@ -4633,6 +4637,7 @@ struct rtw89_chip_info {
 struct rtw89_chip_variant {
 	bool no_mcs_12_13: 1;
 	u32 fw_min_ver_code;
+	const struct rtw89_fw_def *fw_def_override;
 };
 
 union rtw89_bus_info {
@@ -7379,6 +7384,22 @@ void rtw89_chip_calc_rx_gain_normal(struct rtw89_dev *rtwdev,
 		chip->ops->calc_rx_gain_normal(rtwdev, chan, path, phy_idx, calc);
 }
 
+static inline const struct rtw89_fw_def *
+__rtw89_chip_get_fw_def(const struct rtw89_chip_info *chip,
+			const struct rtw89_chip_variant *variant)
+{
+	if (variant && variant->fw_def_override)
+		return variant->fw_def_override;
+
+	return &chip->fw_def;
+}
+
+static inline
+const struct rtw89_fw_def *rtw89_chip_get_fw_def(struct rtw89_dev *rtwdev)
+{
+	return __rtw89_chip_get_fw_def(rtwdev->chip, rtwdev->variant);
+}
+
 static inline void rtw89_load_txpwr_table(struct rtw89_dev *rtwdev,
 					  const struct rtw89_txpwr_table *tbl)
 {
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index f84726f04669..638af4ebf628 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -965,18 +965,20 @@ static void rtw89_fw_recognize_features(struct rtw89_dev *rtwdev)
 const struct firmware *
 rtw89_early_fw_feature_recognize(struct device *device,
 				 const struct rtw89_chip_info *chip,
+				 const struct rtw89_chip_variant *variant,
 				 struct rtw89_fw_info *early_fw,
 				 int *used_fw_format)
 {
+	const struct rtw89_fw_def *fw_def = __rtw89_chip_get_fw_def(chip, variant);
 	const struct firmware *firmware;
 	char fw_name[64];
 	int fw_format;
 	u32 ver_code;
 	int ret;
 
-	for (fw_format = chip->fw_format_max; fw_format >= 0; fw_format--) {
+	for (fw_format = fw_def->fw_format_max; fw_format >= 0; fw_format--) {
 		rtw89_fw_get_filename(fw_name, sizeof(fw_name),
-				      chip->fw_basename, fw_format);
+				      fw_def->fw_basename, fw_format);
 
 		ret = request_firmware(&firmware, fw_name, device);
 		if (!ret) {
@@ -2024,11 +2026,11 @@ void rtw89_load_firmware_work(struct work_struct *work)
 {
 	struct rtw89_dev *rtwdev =
 		container_of(work, struct rtw89_dev, load_firmware_work);
-	const struct rtw89_chip_info *chip = rtwdev->chip;
+	const struct rtw89_fw_def *fw_def = rtw89_chip_get_fw_def(rtwdev);
 	char fw_name[64];
 
 	rtw89_fw_get_filename(fw_name, sizeof(fw_name),
-			      chip->fw_basename, rtwdev->fw.fw_format);
+			      fw_def->fw_basename, rtwdev->fw.fw_format);
 
 	rtw89_load_firmware_req(rtwdev, &rtwdev->fw.req, fw_name, false);
 }
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index d45b6ea6ea1b..c60d419616d6 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -5171,6 +5171,7 @@ int rtw89_fw_recognize_elements(struct rtw89_dev *rtwdev);
 const struct firmware *
 rtw89_early_fw_feature_recognize(struct device *device,
 				 const struct rtw89_chip_info *chip,
+				 const struct rtw89_chip_variant *variant,
 				 struct rtw89_fw_info *early_fw,
 				 int *used_fw_format);
 int rtw89_fw_download(struct rtw89_dev *rtwdev, enum rtw89_fw_type type,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b.c b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
index d6deb44a685b..171749f5002d 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
@@ -2580,8 +2580,10 @@ const struct rtw89_chip_info rtw8851b_chip_info = {
 	.ops			= &rtw8851b_chip_ops,
 	.mac_def		= &rtw89_mac_gen_ax,
 	.phy_def		= &rtw89_phy_gen_ax,
-	.fw_basename		= RTW8851B_FW_BASENAME,
-	.fw_format_max		= RTW8851B_FW_FORMAT_MAX,
+	.fw_def			= {
+		.fw_basename	= RTW8851B_FW_BASENAME,
+		.fw_format_max	= RTW8851B_FW_FORMAT_MAX,
+	},
 	.try_ce_fw		= true,
 	.bbmcu_nr		= 0,
 	.needed_fw_elms		= 0,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index 5ea7a36ab5ab..36d66f4e2dd0 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -2265,8 +2265,10 @@ const struct rtw89_chip_info rtw8852a_chip_info = {
 	.ops			= &rtw8852a_chip_ops,
 	.mac_def		= &rtw89_mac_gen_ax,
 	.phy_def		= &rtw89_phy_gen_ax,
-	.fw_basename		= RTW8852A_FW_BASENAME,
-	.fw_format_max		= RTW8852A_FW_FORMAT_MAX,
+	.fw_def			= {
+		.fw_basename	= RTW8852A_FW_BASENAME,
+		.fw_format_max	= RTW8852A_FW_FORMAT_MAX,
+	},
 	.try_ce_fw		= false,
 	.bbmcu_nr		= 0,
 	.needed_fw_elms		= 0,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index 197e3f5fb21b..602432c47ea3 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -911,8 +911,10 @@ const struct rtw89_chip_info rtw8852b_chip_info = {
 	.ops			= &rtw8852b_chip_ops,
 	.mac_def		= &rtw89_mac_gen_ax,
 	.phy_def		= &rtw89_phy_gen_ax,
-	.fw_basename		= RTW8852B_FW_BASENAME,
-	.fw_format_max		= RTW8852B_FW_FORMAT_MAX,
+	.fw_def			= {
+		.fw_basename	= RTW8852B_FW_BASENAME,
+		.fw_format_max	= RTW8852B_FW_FORMAT_MAX,
+	},
 	.try_ce_fw		= true,
 	.bbmcu_nr		= 0,
 	.needed_fw_elms		= 0,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852bt.c b/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
index 92bbd6e5d699..514861e48c25 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
@@ -757,8 +757,10 @@ const struct rtw89_chip_info rtw8852bt_chip_info = {
 	.ops			= &rtw8852bt_chip_ops,
 	.mac_def		= &rtw89_mac_gen_ax,
 	.phy_def		= &rtw89_phy_gen_ax,
-	.fw_basename		= RTW8852BT_FW_BASENAME,
-	.fw_format_max		= RTW8852BT_FW_FORMAT_MAX,
+	.fw_def			= {
+		.fw_basename	= RTW8852BT_FW_BASENAME,
+		.fw_format_max	= RTW8852BT_FW_FORMAT_MAX,
+	},
 	.try_ce_fw		= true,
 	.bbmcu_nr		= 0,
 	.needed_fw_elms		= RTW89_AX_GEN_DEF_NEEDED_FW_ELEMENTS_NO_6GHZ,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index de5d343f80a5..70ca8c3950d9 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -3106,8 +3106,10 @@ const struct rtw89_chip_info rtw8852c_chip_info = {
 	.ops			= &rtw8852c_chip_ops,
 	.mac_def		= &rtw89_mac_gen_ax,
 	.phy_def		= &rtw89_phy_gen_ax,
-	.fw_basename		= RTW8852C_FW_BASENAME,
-	.fw_format_max		= RTW8852C_FW_FORMAT_MAX,
+	.fw_def			= {
+		.fw_basename	= RTW8852C_FW_BASENAME,
+		.fw_format_max	= RTW8852C_FW_FORMAT_MAX,
+	},
 	.try_ce_fw		= false,
 	.bbmcu_nr		= 0,
 	.needed_fw_elms		= 0,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a.c b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
index f41b66b362c4..fd1b171b106c 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
@@ -2916,8 +2916,10 @@ const struct rtw89_chip_info rtw8922a_chip_info = {
 	.ops			= &rtw8922a_chip_ops,
 	.mac_def		= &rtw89_mac_gen_be,
 	.phy_def		= &rtw89_phy_gen_be,
-	.fw_basename		= RTW8922A_FW_BASENAME,
-	.fw_format_max		= RTW8922A_FW_FORMAT_MAX,
+	.fw_def			= {
+		.fw_basename	= RTW8922A_FW_BASENAME,
+		.fw_format_max	= RTW8922A_FW_FORMAT_MAX,
+	},
 	.try_ce_fw		= false,
 	.bbmcu_nr		= 1,
 	.needed_fw_elms		= RTW89_BE_GEN_DEF_NEEDED_FW_ELEMENTS,
@@ -3057,6 +3059,7 @@ EXPORT_SYMBOL(rtw8922a_chip_info);
 const struct rtw89_chip_variant rtw8922ae_vs_variant = {
 	.no_mcs_12_13 = true,
 	.fw_min_ver_code = RTW89_FW_VER_CODE(0, 35, 54, 0),
+	.fw_def_override = NULL,
 };
 EXPORT_SYMBOL(rtw8922ae_vs_variant);
 
-- 
2.25.1


