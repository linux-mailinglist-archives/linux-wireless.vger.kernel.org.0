Return-Path: <linux-wireless+bounces-25076-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2631BAFE087
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 08:52:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68AEA584307
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 06:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1ABD271454;
	Wed,  9 Jul 2025 06:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="JUy37APN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27EE4271456
	for <linux-wireless@vger.kernel.org>; Wed,  9 Jul 2025 06:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752043850; cv=none; b=OzQmqVUdaxwrCQ95vhfHD8WxCKBiEEiTlBQ8D8gaz1qVkOp95ieyUR5ITm/1LsbvCg11MNjqKftF1KpGs6L42huM5qXfWIDo20H7rp5tTyaMokW/DZA+2rQj8uuk3IK053Wf3cL6OId1wLfbgP5+OVC4i//xjJtWjRTOZGydrmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752043850; c=relaxed/simple;
	bh=/nNMSQwIBRpt1XK2FkC2giHMv1OweDdojdtIVnb4TCM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D+a8iYTDesaKxDHgU0I7iH/AZr9E07qZoVNOVdzC9ka5XLvhvhLGx+mEdpTSHaJm9WfNOs6w5aIhA2l1MRy5eDZFVt3GPjq5ILQIjt4FaiOf3y9Sl633bsgLH/5BwP6JUvp5SmQO0LPqDpI4nkm+IZWf5RPcIPTzlIgl8VV7rsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=JUy37APN; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5696oiBfB863807, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1752043844; bh=HxcZJA16Cb67kaMGOCoMY4TAPlSYwItcjv/D81lHipw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=JUy37APNYODqUBHt95L8zMYOsBrNF3fS52/4yaCStjZUiDJ6CSGcjaSAc9CaJ0L77
	 rsqAEWl3FFhgps7gTBregTW5c4BSfI0cAdY6Ari3Qla6aM7nvyOaIAtrWcCkfJtIxL
	 A6Thi7Xs7a0PozHMo7VYhXpo2CrwwgVw2cgrHi9LU1vKzbwJ0JVlgFiYp1n6h400+H
	 GbgEt3CflVOkQLoqbVO5qLxdFHz1KnDoLRSwqc3pNLod6ON9LfVUbJKg8YPvtx7ljN
	 JLEjvIBAsXM6IUz64HNf335eJd+CaNqCIQQ8GkfrDBPb4bjc8Ij6VcFJ3LmyoXGA/Y
	 PVXNupRYZ9C9g==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 5696oiBfB863807
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 9 Jul 2025 14:50:44 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 9 Jul 2025 14:51:14 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 9 Jul
 2025 14:51:13 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 3/4] wifi: rtw89: regd/acpi: support regulatory rules via ACPI DSM and parse rule of regd_UK
Date: Wed, 9 Jul 2025 14:50:05 +0800
Message-ID: <20250709065006.32028-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250709065006.32028-1-pkshih@realtek.com>
References: <20250709065006.32028-1-pkshih@realtek.com>
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

From: Zong-Zhe Yang <kevin_yang@realtek.com>

ACPI DSM function 10 is defined for the enablement for Realtek regulatory
rules. The first rule is whether to allow regd_UK regulatory settings or
not. If not, the strict one, i.e. regd_ETSI, regulatory settings will be
used on country GB.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/acpi.c | 48 +++++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/acpi.h | 13 ++++++
 drivers/net/wireless/realtek/rtw89/regd.c | 27 ++++++++++++-
 3 files changed, 87 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/acpi.c b/drivers/net/wireless/realtek/rtw89/acpi.c
index 581d6d4154d3..c35a36e0f4d9 100644
--- a/drivers/net/wireless/realtek/rtw89/acpi.c
+++ b/drivers/net/wireless/realtek/rtw89/acpi.c
@@ -279,6 +279,51 @@ static int rtw89_acpi_dsm_get_policy_tas(struct rtw89_dev *rtwdev,
 	return 0;
 }
 
+static
+bool chk_acpi_policy_reg_rules_sig(const struct rtw89_acpi_policy_reg_rules *p)
+{
+	return p->signature[0] == 0x52 &&
+	       p->signature[1] == 0x54 &&
+	       p->signature[2] == 0x4B &&
+	       p->signature[3] == 0x0A;
+}
+
+static
+int rtw89_acpi_dsm_get_policy_reg_rules(struct rtw89_dev *rtwdev,
+					union acpi_object *obj,
+					struct rtw89_acpi_policy_reg_rules **policy)
+{
+	const struct rtw89_acpi_policy_reg_rules *ptr;
+	u32 buf_len;
+
+	if (obj->type != ACPI_TYPE_BUFFER) {
+		rtw89_debug(rtwdev, RTW89_DBG_ACPI,
+			    "acpi: expect buffer but type: %d\n", obj->type);
+		return -EINVAL;
+	}
+
+	buf_len = obj->buffer.length;
+	if (buf_len < sizeof(*ptr)) {
+		rtw89_debug(rtwdev, RTW89_DBG_ACPI, "%s: invalid buffer length: %u\n",
+			    __func__, buf_len);
+		return -EINVAL;
+	}
+
+	ptr = (typeof(ptr))obj->buffer.pointer;
+	if (!chk_acpi_policy_reg_rules_sig(ptr)) {
+		rtw89_debug(rtwdev, RTW89_DBG_ACPI, "%s: bad signature\n", __func__);
+		return -EINVAL;
+	}
+
+	*policy = kmemdup(ptr, sizeof(*ptr), GFP_KERNEL);
+	if (!*policy)
+		return -ENOMEM;
+
+	rtw89_hex_dump(rtwdev, RTW89_DBG_ACPI, "policy_reg_rules: ", *policy,
+		       sizeof(*ptr));
+	return 0;
+}
+
 int rtw89_acpi_evaluate_dsm(struct rtw89_dev *rtwdev,
 			    enum rtw89_acpi_dsm_func func,
 			    struct rtw89_acpi_dsm_result *res)
@@ -302,6 +347,9 @@ int rtw89_acpi_evaluate_dsm(struct rtw89_dev *rtwdev,
 							&res->u.policy_6ghz_sp);
 	else if (func == RTW89_ACPI_DSM_FUNC_TAS_EN)
 		ret = rtw89_acpi_dsm_get_policy_tas(rtwdev, obj, &res->u.policy_tas);
+	else if (func == RTW89_ACPI_DSM_FUNC_REG_RULES_EN)
+		ret = rtw89_acpi_dsm_get_policy_reg_rules(rtwdev, obj,
+							  &res->u.policy_reg_rules);
 	else
 		ret = rtw89_acpi_dsm_get_value(rtwdev, obj, &res->u.value);
 
diff --git a/drivers/net/wireless/realtek/rtw89/acpi.h b/drivers/net/wireless/realtek/rtw89/acpi.h
index 8cf261505539..5811afebc2e6 100644
--- a/drivers/net/wireless/realtek/rtw89/acpi.h
+++ b/drivers/net/wireless/realtek/rtw89/acpi.h
@@ -19,6 +19,7 @@ enum rtw89_acpi_dsm_func {
 	RTW89_ACPI_DSM_FUNC_TAS_EN = 5,
 	RTW89_ACPI_DSM_FUNC_UNII4_SUP = 6,
 	RTW89_ACPI_DSM_FUNC_6GHZ_SP_SUP = 7,
+	RTW89_ACPI_DSM_FUNC_REG_RULES_EN = 10,
 };
 
 enum rtw89_acpi_conf_unii4 {
@@ -75,6 +76,17 @@ struct rtw89_acpi_policy_tas {
 	u8 rsvd[3];
 } __packed;
 
+enum rtw89_acpi_conf_reg_rules {
+	RTW89_ACPI_CONF_REG_RULE_REGD_UK = BIT(0),
+};
+
+struct rtw89_acpi_policy_reg_rules {
+	u8 signature[4];
+	u8 revision;
+	u8 conf;
+	u8 rsvd[3];
+} __packed;
+
 struct rtw89_acpi_dsm_result {
 	union {
 		u8 value;
@@ -82,6 +94,7 @@ struct rtw89_acpi_dsm_result {
 		struct rtw89_acpi_policy_6ghz *policy_6ghz;
 		struct rtw89_acpi_policy_6ghz_sp *policy_6ghz_sp;
 		struct rtw89_acpi_policy_tas *policy_tas;
+		struct rtw89_acpi_policy_reg_rules *policy_reg_rules;
 	} u;
 };
 
diff --git a/drivers/net/wireless/realtek/rtw89/regd.c b/drivers/net/wireless/realtek/rtw89/regd.c
index ea44b8311cb2..42678ff2a045 100644
--- a/drivers/net/wireless/realtek/rtw89/regd.c
+++ b/drivers/net/wireless/realtek/rtw89/regd.c
@@ -608,6 +608,30 @@ const char *rtw89_regd_get_string(enum rtw89_regulation_type regd)
 	return rtw89_regd_string[regd];
 }
 
+static void rtw89_regd_setup_reg_rules(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_regulatory_info *regulatory = &rtwdev->regulatory;
+	const struct rtw89_acpi_policy_reg_rules *ptr;
+	struct rtw89_acpi_dsm_result res = {};
+	int ret;
+
+	regulatory->txpwr_uk_follow_etsi = true;
+
+	ret = rtw89_acpi_evaluate_dsm(rtwdev, RTW89_ACPI_DSM_FUNC_REG_RULES_EN, &res);
+	if (ret) {
+		rtw89_debug(rtwdev, RTW89_DBG_REGD,
+			    "acpi: cannot eval policy reg-rules: %d\n", ret);
+		return;
+	}
+
+	ptr = res.u.policy_reg_rules;
+
+	regulatory->txpwr_uk_follow_etsi =
+		!u8_get_bits(ptr->conf, RTW89_ACPI_CONF_REG_RULE_REGD_UK);
+
+	kfree(ptr);
+}
+
 int rtw89_regd_setup(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_regulatory_info *regulatory = &rtwdev->regulatory;
@@ -624,7 +648,8 @@ int rtw89_regd_setup(struct rtw89_dev *rtwdev)
 	}
 
 	regulatory->reg_6ghz_power = RTW89_REG_6GHZ_POWER_DFLT;
-	regulatory->txpwr_uk_follow_etsi = true;
+
+	rtw89_regd_setup_reg_rules(rtwdev);
 
 	if (!wiphy)
 		return -EINVAL;
-- 
2.25.1


