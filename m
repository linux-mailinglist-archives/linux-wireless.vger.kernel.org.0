Return-Path: <linux-wireless+bounces-36864-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WDA5Kj4JFGrVJAcAu9opvQ
	(envelope-from <linux-wireless+bounces-36864-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 25 May 2026 10:33:02 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 17CEC5C7CE4
	for <lists+linux-wireless@lfdr.de>; Mon, 25 May 2026 10:33:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9CA3D305F15E
	for <lists+linux-wireless@lfdr.de>; Mon, 25 May 2026 08:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F1B53E2743;
	Mon, 25 May 2026 08:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="Q84f+qMl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4170E3E172D
	for <linux-wireless@vger.kernel.org>; Mon, 25 May 2026 08:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779697619; cv=none; b=gX79GkMeEOLfWee5JQNc6nEIuUJZicuYq+yMdkLO2YRs2OgjzTU99urZy5oZD1BOSAwKKkZu0ESMBkGBQquDlXcDJaD66V540qYsp5ixn+uXLh1Z/kT2fAqrMug+kywWUWI2gNkH/bMCXZd3xVgvjjvuX9kBsFHKwp9yv3KxuS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779697619; c=relaxed/simple;
	bh=QX0cigJhOCuEyXddTfhos7bpPuxU+MEqOJsSxPNV3i0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jZuEwod8/0pTaTjwdKNabyxs0ee0JpAof53Cv6A8mwG95aZEL5pie8lHDni5/KpwqiGtj1MHGdD0Linnn8B1JbESD3dNIhyO4W35Bs1F/DO3SmkUQfAaCguQd34Yz8b74Doka+x//EYnIT3oCamqKUroIZ708OXpXAYens5bAUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=Q84f+qMl; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 64P8Qt1W2926187, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1779697615; bh=cjMai8JGUFEc8XsQtETsN9wdMTos8D0SlnaMM6omyXM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=Q84f+qMlwPfKFK26jmpUbFxojvXAcwdLb5cN8pDwNpDM8OBNdPCBACLQW6heiUo7i
	 q8sfCtWitr0pNzLTqyVJpb7Ui4ngi+b3JpyKD3c7f3wejkDnC7oOYGtVVFe9aRJvhA
	 sBASuD5dcls2s0bFRD0zXBICxEPy0FA28oDqI1kGolGCawBMXpmVM9Wu1k6g2GrZcx
	 tgbhEw8mMGfqauhnVw8BrZDJUmJb0Z0f9tp7r4gsmjK/fNdbZPbvHNsmhV5fKPelLl
	 IaVtSqB/G7ZoC8c+4SEKDz6+aqjpxVnnPJaPwqqUZi9RU4Nm4DFEjxm0doaU8NDnqE
	 VtVnGMKUmBr8A==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.28/5.94) with ESMTPS id 64P8Qt1W2926187
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 25 May 2026 16:26:55 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 25 May 2026 16:26:53 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS05.realtek.com.tw
 (10.21.1.55) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Mon, 25 May 2026 16:26:53 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <sc.lee@realtek.com>
Subject: [PATCH rtw-next] wifi: rtw89: usb: skip ACPI capability check for USB devices
Date: Mon, 25 May 2026 16:26:36 +0800
Message-ID: <20260525082636.31105-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36864-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,realtek.com:email,realtek.com:mid,realtek.com:dkim]
X-Rspamd-Queue-Id: 17CEC5C7CE4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: David Lee <sc.lee@realtek.com>

Skip the ACPI capability check for all USB devices by default,
allowing them to use their default configurations.

For USB dongles, customers will manage their own compliance and
certification. This initial patch focuses on the generic USB skip
infrastructure; specific customer certifications and localized
configurations will be handled by quirks afterward.

Signed-off-by: David Lee <sc.lee@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/regd.c | 24 +++++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/sar.c  |  4 ++++
 2 files changed, 28 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/regd.c b/drivers/net/wireless/realtek/rtw89/regd.c
index 28466cb35ea2..14fab6b1a74a 100644
--- a/drivers/net/wireless/realtek/rtw89/regd.c
+++ b/drivers/net/wireless/realtek/rtw89/regd.c
@@ -360,6 +360,7 @@ static void rtw89_regd_setup_unii4(struct rtw89_dev *rtwdev,
 				   struct wiphy *wiphy)
 {
 	struct rtw89_regulatory_info *regulatory = &rtwdev->regulatory;
+	bool skip_acpi_dsm = rtwdev->hci.type == RTW89_HCI_TYPE_USB;
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 	struct ieee80211_supported_band *sband;
 	struct rtw89_acpi_dsm_result res = {};
@@ -377,6 +378,9 @@ static void rtw89_regd_setup_unii4(struct rtw89_dev *rtwdev,
 		return;
 	}
 
+	if (skip_acpi_dsm)
+		return;
+
 	bitmap_fill(regulatory->block_unii4, RTW89_REGD_MAX_COUNTRY_NUM);
 
 	ret = rtw89_acpi_evaluate_dsm(rtwdev, RTW89_ACPI_DSM_FUNC_UNII4_SUP, &res);
@@ -426,6 +430,7 @@ static void __rtw89_regd_setup_policy_6ghz(struct rtw89_dev *rtwdev, bool block,
 static void rtw89_regd_setup_policy_6ghz(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_regulatory_info *regulatory = &rtwdev->regulatory;
+	bool skip_acpi_dsm = rtwdev->hci.type == RTW89_HCI_TYPE_USB;
 	const struct rtw89_acpi_country_code *country;
 	const struct rtw89_acpi_policy_6ghz *ptr;
 	struct rtw89_acpi_dsm_result res = {};
@@ -433,6 +438,9 @@ static void rtw89_regd_setup_policy_6ghz(struct rtw89_dev *rtwdev)
 	int i, j;
 	int ret;
 
+	if (skip_acpi_dsm)
+		return;
+
 	ret = rtw89_acpi_evaluate_dsm(rtwdev, RTW89_ACPI_DSM_FUNC_6G_BP, &res);
 	if (ret) {
 		rtw89_debug(rtwdev, RTW89_DBG_REGD,
@@ -478,12 +486,16 @@ static void rtw89_regd_setup_policy_6ghz(struct rtw89_dev *rtwdev)
 static void rtw89_regd_setup_policy_6ghz_sp(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_regulatory_info *regulatory = &rtwdev->regulatory;
+	bool skip_acpi_dsm = rtwdev->hci.type == RTW89_HCI_TYPE_USB;
 	const struct rtw89_acpi_policy_6ghz_sp *ptr;
 	struct rtw89_acpi_dsm_result res = {};
 	bool enable;
 	u8 index;
 	int ret;
 
+	if (skip_acpi_dsm)
+		return;
+
 	ret = rtw89_acpi_evaluate_dsm(rtwdev, RTW89_ACPI_DSM_FUNC_6GHZ_SP_SUP, &res);
 	if (ret) {
 		rtw89_debug(rtwdev, RTW89_DBG_REGD,
@@ -524,6 +536,7 @@ static void rtw89_regd_setup_policy_6ghz_sp(struct rtw89_dev *rtwdev)
 static void rtw89_regd_setup_policy_6ghz_vlp(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_regulatory_info *regulatory = &rtwdev->regulatory;
+	bool skip_acpi_dsm = rtwdev->hci.type == RTW89_HCI_TYPE_USB;
 	const struct rtw89_acpi_policy_6ghz_vlp *ptr = NULL;
 	struct rtw89_acpi_dsm_result res = {};
 	bool enable;
@@ -531,6 +544,9 @@ static void rtw89_regd_setup_policy_6ghz_vlp(struct rtw89_dev *rtwdev)
 	int ret;
 	u8 val;
 
+	if (skip_acpi_dsm)
+		return;
+
 	/* By default, allow 6 GHz VLP on all countries except US and CA. */
 	val = ~(RTW89_ACPI_CONF_6GHZ_VLP_US | RTW89_ACPI_CONF_6GHZ_VLP_CA);
 
@@ -574,6 +590,7 @@ static void rtw89_regd_setup_6ghz(struct rtw89_dev *rtwdev, struct wiphy *wiphy)
 {
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 	bool chip_support_6ghz = chip->support_bands & BIT(NL80211_BAND_6GHZ);
+	bool skip_acpi_dsm = rtwdev->hci.type == RTW89_HCI_TYPE_USB;
 	bool regd_allow_6ghz = chip_support_6ghz;
 	struct ieee80211_supported_band *sband;
 	struct rtw89_acpi_dsm_result res = {};
@@ -583,6 +600,9 @@ static void rtw89_regd_setup_6ghz(struct rtw89_dev *rtwdev, struct wiphy *wiphy)
 	if (!chip_support_6ghz)
 		goto bottom;
 
+	if (skip_acpi_dsm)
+		goto bottom;
+
 	ret = rtw89_acpi_evaluate_dsm(rtwdev, RTW89_ACPI_DSM_FUNC_6G_DIS, &res);
 	if (ret) {
 		rtw89_debug(rtwdev, RTW89_DBG_REGD,
@@ -661,10 +681,14 @@ const char *rtw89_regd_get_string(enum rtw89_regulation_type regd)
 static void rtw89_regd_setup_reg_rules(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_regulatory_info *regulatory = &rtwdev->regulatory;
+	bool skip_acpi_dsm = rtwdev->hci.type == RTW89_HCI_TYPE_USB;
 	const struct rtw89_acpi_policy_reg_rules *ptr;
 	struct rtw89_acpi_dsm_result res = {};
 	int ret;
 
+	if (skip_acpi_dsm)
+		return;
+
 	regulatory->txpwr_uk_follow_etsi = true;
 
 	ret = rtw89_acpi_evaluate_dsm(rtwdev, RTW89_ACPI_DSM_FUNC_REG_RULES_EN, &res);
diff --git a/drivers/net/wireless/realtek/rtw89/sar.c b/drivers/net/wireless/realtek/rtw89/sar.c
index 7886ffaf5695..6fe3822eb598 100644
--- a/drivers/net/wireless/realtek/rtw89/sar.c
+++ b/drivers/net/wireless/realtek/rtw89/sar.c
@@ -693,6 +693,7 @@ static bool rtw89_tas_rolling_average(struct rtw89_dev *rtwdev)
 
 static void rtw89_tas_init(struct rtw89_dev *rtwdev)
 {
+	bool skip_acpi_dsm = rtwdev->hci.type == RTW89_HCI_TYPE_USB;
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 	struct rtw89_tas_info *tas = &rtwdev->tas;
 	const struct rtw89_acpi_policy_tas *ptr;
@@ -702,6 +703,9 @@ static void rtw89_tas_init(struct rtw89_dev *rtwdev)
 	if (!chip->support_tas)
 		return;
 
+	if (skip_acpi_dsm)
+		return;
+
 	ret = rtw89_acpi_evaluate_dsm(rtwdev, RTW89_ACPI_DSM_FUNC_TAS_EN, &res);
 	if (ret) {
 		rtw89_debug(rtwdev, RTW89_DBG_SAR,

base-commit: 6b964941bbfe6e0f18b1a5e008486dbb62df440a
-- 
2.25.1


