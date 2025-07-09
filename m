Return-Path: <linux-wireless+bounces-25077-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ACDAAFE08B
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 08:52:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25BA73AB20E
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 06:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBD5D26A1A4;
	Wed,  9 Jul 2025 06:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="K1h1ThZk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7164126D4EE
	for <linux-wireless@vger.kernel.org>; Wed,  9 Jul 2025 06:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752043854; cv=none; b=ANra7Iz6ty2CRUCl6AhUYjM3PLlsKZUM0dhS29IUwNj4oBfloixF4OIPi0iz30hFMsAkaWsg7yQGxy0/lb1ZigqfmsGclYxGU8mnUUcOm/ej8gP7+1E89dKoGLVVzoHJd11yEumyazd6KSUcW4uLLY27QMCyvFBuuZsj/dDISAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752043854; c=relaxed/simple;
	bh=bI3AFTTjNmcNy1O0ZOVKxMNZ13KQ1Ra8waExhbFzC8I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=omyst5F4eMUD3t/9sjXkmxsYF0dFTCNZsYzJx43nuhc/SWLi+DI3cALYmOQVKyLGpaK/wGx0gqc8PqSnesMuMrO3siBdqMWRm5TVpJdWm3IuF+l5JZgvsftmvvFy7p12sffNMZuPmqR7YrHRoUTpNou8erQT29D9eBrePjtuiVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=K1h1ThZk; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5696onrE7863817, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1752043850; bh=Ea+C871tftZUEX9oTlWIshl0+VLGx4/9/VkJvB7S3Wk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=K1h1ThZkxyN8raF97SuGa1dQR4deap7ZXaHKXLpOC3+nUVYhETD4xw0Ny8f6LxUqF
	 uulHJgXd9rVfkRr2k+G1qtC39YW9uZnGKXa45sKvLerMU2ioSyxiddBAFzwJL7jgmY
	 QKagwiwFVuetzfTrw4SPlKeWUINvIaEqXe4JCqDCn4Av6q+0cqQ2G6b3hjaLnfC62e
	 B6bGpFqxMzYr8g40AJJzgZF4btgKU1iW/LRhYE4JQ4jeJ7d9h/D3moKFK4VauD3mqz
	 kAaD/lEVtcIyT6dXHhfl6dufvQsp86ApN9SfXSTDMEEii/27ziekygbmVN8T4Zyzwc
	 ox6bofXuigWHA==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 5696onrE7863817
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 9 Jul 2025 14:50:50 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 9 Jul 2025 14:51:19 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 9 Jul
 2025 14:51:18 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 4/4] wifi: rtw89: regd/acpi: support 6 GHz VLP policy via ACPI DSM
Date: Wed, 9 Jul 2025 14:50:06 +0800
Message-ID: <20250709065006.32028-5-pkshih@realtek.com>
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

Process ACPI DSM function 11 to get 6 GHz VLP support by country. If
not allowed, return error to block the connection. By default, i.e.
ACPI DSM function is not configured, disallow 6 GHz VLP on country US
and country CA, because some platform-level certifications are needed
in FCC regulation before operating on 6 GHz VLP connection.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/acpi.c | 47 ++++++++++++++++
 drivers/net/wireless/realtek/rtw89/acpi.h | 15 +++++
 drivers/net/wireless/realtek/rtw89/core.h |  1 +
 drivers/net/wireless/realtek/rtw89/regd.c | 68 +++++++++++++++++++++++
 4 files changed, 131 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/acpi.c b/drivers/net/wireless/realtek/rtw89/acpi.c
index c35a36e0f4d9..f1e758a5f32b 100644
--- a/drivers/net/wireless/realtek/rtw89/acpi.c
+++ b/drivers/net/wireless/realtek/rtw89/acpi.c
@@ -236,6 +236,50 @@ int rtw89_acpi_dsm_get_policy_6ghz_sp(struct rtw89_dev *rtwdev,
 	return 0;
 }
 
+static bool chk_acpi_policy_6ghz_vlp_sig(const struct rtw89_acpi_policy_6ghz_vlp *p)
+{
+	return p->signature[0] == 0x52 &&
+	       p->signature[1] == 0x54 &&
+	       p->signature[2] == 0x4B &&
+	       p->signature[3] == 0x0B;
+}
+
+static
+int rtw89_acpi_dsm_get_policy_6ghz_vlp(struct rtw89_dev *rtwdev,
+				       union acpi_object *obj,
+				       struct rtw89_acpi_policy_6ghz_vlp **policy)
+{
+	const struct rtw89_acpi_policy_6ghz_vlp *ptr;
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
+	if (!chk_acpi_policy_6ghz_vlp_sig(ptr)) {
+		rtw89_debug(rtwdev, RTW89_DBG_ACPI, "%s: bad signature\n", __func__);
+		return -EINVAL;
+	}
+
+	*policy = kmemdup(ptr, sizeof(*ptr), GFP_KERNEL);
+	if (!*policy)
+		return -ENOMEM;
+
+	rtw89_hex_dump(rtwdev, RTW89_DBG_ACPI, "policy_6ghz_vlp: ", *policy,
+		       sizeof(*ptr));
+	return 0;
+}
+
 static bool chk_acpi_policy_tas_sig(const struct rtw89_acpi_policy_tas *p)
 {
 	return p->signature[0] == 0x52 &&
@@ -345,6 +389,9 @@ int rtw89_acpi_evaluate_dsm(struct rtw89_dev *rtwdev,
 	else if (func == RTW89_ACPI_DSM_FUNC_6GHZ_SP_SUP)
 		ret = rtw89_acpi_dsm_get_policy_6ghz_sp(rtwdev, obj,
 							&res->u.policy_6ghz_sp);
+	else if (func == RTW89_ACPI_DSM_FUNC_6GHZ_VLP_SUP)
+		ret = rtw89_acpi_dsm_get_policy_6ghz_vlp(rtwdev, obj,
+							 &res->u.policy_6ghz_vlp);
 	else if (func == RTW89_ACPI_DSM_FUNC_TAS_EN)
 		ret = rtw89_acpi_dsm_get_policy_tas(rtwdev, obj, &res->u.policy_tas);
 	else if (func == RTW89_ACPI_DSM_FUNC_REG_RULES_EN)
diff --git a/drivers/net/wireless/realtek/rtw89/acpi.h b/drivers/net/wireless/realtek/rtw89/acpi.h
index 5811afebc2e6..48a46f2005b1 100644
--- a/drivers/net/wireless/realtek/rtw89/acpi.h
+++ b/drivers/net/wireless/realtek/rtw89/acpi.h
@@ -20,6 +20,7 @@ enum rtw89_acpi_dsm_func {
 	RTW89_ACPI_DSM_FUNC_UNII4_SUP = 6,
 	RTW89_ACPI_DSM_FUNC_6GHZ_SP_SUP = 7,
 	RTW89_ACPI_DSM_FUNC_REG_RULES_EN = 10,
+	RTW89_ACPI_DSM_FUNC_6GHZ_VLP_SUP = 11,
 };
 
 enum rtw89_acpi_conf_unii4 {
@@ -68,6 +69,19 @@ struct rtw89_acpi_policy_6ghz_sp {
 	u8 rsvd;
 } __packed;
 
+enum rtw89_acpi_conf_6ghz_vlp {
+	RTW89_ACPI_CONF_6GHZ_VLP_US = BIT(0),
+	RTW89_ACPI_CONF_6GHZ_VLP_CA = BIT(1),
+};
+
+struct rtw89_acpi_policy_6ghz_vlp {
+	u8 signature[4];
+	u8 revision;
+	u8 override;
+	u8 conf;
+	u8 rsvd;
+} __packed;
+
 struct rtw89_acpi_policy_tas {
 	u8 signature[4];
 	u8 revision;
@@ -93,6 +107,7 @@ struct rtw89_acpi_dsm_result {
 		/* caller needs to free it after using */
 		struct rtw89_acpi_policy_6ghz *policy_6ghz;
 		struct rtw89_acpi_policy_6ghz_sp *policy_6ghz_sp;
+		struct rtw89_acpi_policy_6ghz_vlp *policy_6ghz_vlp;
 		struct rtw89_acpi_policy_tas *policy_tas;
 		struct rtw89_acpi_policy_reg_rules *policy_reg_rules;
 	} u;
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 1d8f89e83c9a..8c53c5db0cbc 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -5386,6 +5386,7 @@ struct rtw89_regulatory_info {
 	DECLARE_BITMAP(block_unii4, RTW89_REGD_MAX_COUNTRY_NUM);
 	DECLARE_BITMAP(block_6ghz, RTW89_REGD_MAX_COUNTRY_NUM);
 	DECLARE_BITMAP(block_6ghz_sp, RTW89_REGD_MAX_COUNTRY_NUM);
+	DECLARE_BITMAP(block_6ghz_vlp, RTW89_REGD_MAX_COUNTRY_NUM);
 };
 
 enum rtw89_ifs_clm_application {
diff --git a/drivers/net/wireless/realtek/rtw89/regd.c b/drivers/net/wireless/realtek/rtw89/regd.c
index 42678ff2a045..58582f8d2b74 100644
--- a/drivers/net/wireless/realtek/rtw89/regd.c
+++ b/drivers/net/wireless/realtek/rtw89/regd.c
@@ -521,6 +521,55 @@ static void rtw89_regd_setup_policy_6ghz_sp(struct rtw89_dev *rtwdev)
 	kfree(ptr);
 }
 
+static void rtw89_regd_setup_policy_6ghz_vlp(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_regulatory_info *regulatory = &rtwdev->regulatory;
+	const struct rtw89_acpi_policy_6ghz_vlp *ptr = NULL;
+	struct rtw89_acpi_dsm_result res = {};
+	bool enable;
+	u8 index;
+	int ret;
+	u8 val;
+
+	/* By default, allow 6 GHz VLP on all countries except US and CA. */
+	val = ~(RTW89_ACPI_CONF_6GHZ_VLP_US | RTW89_ACPI_CONF_6GHZ_VLP_CA);
+
+	ret = rtw89_acpi_evaluate_dsm(rtwdev, RTW89_ACPI_DSM_FUNC_6GHZ_VLP_SUP, &res);
+	if (ret) {
+		rtw89_debug(rtwdev, RTW89_DBG_REGD,
+			    "acpi: cannot eval policy 6ghz-vlp: %d\n", ret);
+		goto bottom;
+	}
+
+	ptr = res.u.policy_6ghz_vlp;
+
+	switch (ptr->override) {
+	default:
+		rtw89_debug(rtwdev, RTW89_DBG_REGD,
+			    "%s: unknown override case: %d\n", __func__,
+			    ptr->override);
+		fallthrough;
+	case 0:
+		break;
+	case 1:
+		val = ptr->conf;
+		break;
+	}
+
+bottom:
+	index = rtw89_regd_get_index_by_name(rtwdev, "US");
+	enable = u8_get_bits(val, RTW89_ACPI_CONF_6GHZ_VLP_US);
+	if (!enable && index != RTW89_REGD_MAX_COUNTRY_NUM)
+		set_bit(index, regulatory->block_6ghz_vlp);
+
+	index = rtw89_regd_get_index_by_name(rtwdev, "CA");
+	enable = u8_get_bits(val, RTW89_ACPI_CONF_6GHZ_VLP_CA);
+	if (!enable && index != RTW89_REGD_MAX_COUNTRY_NUM)
+		set_bit(index, regulatory->block_6ghz_vlp);
+
+	kfree(ptr);
+}
+
 static void rtw89_regd_setup_6ghz(struct rtw89_dev *rtwdev, struct wiphy *wiphy)
 {
 	const struct rtw89_chip_info *chip = rtwdev->chip;
@@ -564,6 +613,7 @@ static void rtw89_regd_setup_6ghz(struct rtw89_dev *rtwdev, struct wiphy *wiphy)
 	if (regd_allow_6ghz) {
 		rtw89_regd_setup_policy_6ghz(rtwdev);
 		rtw89_regd_setup_policy_6ghz_sp(rtwdev);
+		rtw89_regd_setup_policy_6ghz_vlp(rtwdev);
 		return;
 	}
 
@@ -1059,7 +1109,16 @@ static int rtw89_reg_6ghz_power_recalc(struct rtw89_dev *rtwdev,
 				       struct rtw89_vif_link *rtwvif_link, bool active,
 				       unsigned int *changed)
 {
+	struct rtw89_regulatory_info *regulatory = &rtwdev->regulatory;
+	const struct rtw89_regd *regd = regulatory->regd;
+	bool blocked[NUM_OF_RTW89_REG_6GHZ_POWER] = {};
+	u8 index = rtw89_regd_get_index(rtwdev, regd);
 	struct ieee80211_bss_conf *bss_conf;
+	bool dflt = false;
+
+	if (index == RTW89_REGD_MAX_COUNTRY_NUM ||
+	    test_bit(index, regulatory->block_6ghz_vlp))
+		blocked[RTW89_REG_6GHZ_POWER_VLP] = true;
 
 	rcu_read_lock();
 
@@ -1078,6 +1137,7 @@ static int rtw89_reg_6ghz_power_recalc(struct rtw89_dev *rtwdev,
 			break;
 		default:
 			rtwvif_link->reg_6ghz_power = RTW89_REG_6GHZ_POWER_DFLT;
+			dflt = true;
 			break;
 		}
 	} else {
@@ -1086,6 +1146,14 @@ static int rtw89_reg_6ghz_power_recalc(struct rtw89_dev *rtwdev,
 
 	rcu_read_unlock();
 
+	if (!dflt && blocked[rtwvif_link->reg_6ghz_power]) {
+		rtw89_debug(rtwdev, RTW89_DBG_REGD,
+			    "%c%c 6 GHz power type-%u is blocked by policy\n",
+			    regd->alpha2[0], regd->alpha2[1],
+			    rtwvif_link->reg_6ghz_power);
+		return -EINVAL;
+	}
+
 	*changed += __rtw89_reg_6ghz_power_recalc(rtwdev);
 	return 0;
 }
-- 
2.25.1


