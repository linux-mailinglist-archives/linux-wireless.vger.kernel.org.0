Return-Path: <linux-wireless+bounces-6251-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D3528A2DE5
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Apr 2024 14:00:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF0D22835C9
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Apr 2024 12:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5155C56754;
	Fri, 12 Apr 2024 11:59:49 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6982656760
	for <linux-wireless@vger.kernel.org>; Fri, 12 Apr 2024 11:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712923189; cv=none; b=O6nf6FXElqSQ9AIQw63YdBs0jEjjhMmQyMGye/DlkmZzNMzohVqODbePbArV37gYU9H6vUbnOcdOE/4BdMK+WWPporo/tlnXsCz8dmwg2U7tPYqaJ/AdZhJPtQ+Xu9NNp0yVNrnQrPp/0N0V7MwIQqieacIbpkIRvl7UkR62O9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712923189; c=relaxed/simple;
	bh=yO86qH3eooFmxiEXh35rdx2goBBDv0L5TDjj5vGJ1iA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KC8pJoq37P8AjxFDxztvMdYZUdeVrjHAjYnrYXCpbBMMQzs3ScGR3bsU5otl8wHHhWTpt2OpYZszB5/YSyO8fD8YBKG0M7kWay2FmCSSZDo26wbjqmw4gsfhj47pvETphe9c8oga1QxVUS5fwwyofGY4goDzAUNNoL9T3xPcH4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 43CBxjUbB2094318, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 43CBxjUbB2094318
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 12 Apr 2024 19:59:45 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 12 Apr 2024 19:59:45 +0800
Received: from [127.0.1.1] (172.16.17.25) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 12 Apr
 2024 19:59:44 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <kevin_yang@realtek.com>
Subject: [PATCH 7/8] wifi: rtw89: acpi: process 6 GHz SP policy from ACPI DSM
Date: Fri, 12 Apr 2024 19:57:28 +0800
Message-ID: <20240412115729.8316-8-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240412115729.8316-1-pkshih@realtek.com>
References: <20240412115729.8316-1-pkshih@realtek.com>
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

Realtek ACPI DSM func 7, RTW89_ACPI_DSM_FUNC_6GHZ_SP_SUP, accepts a format
via ACPI buffer as below.

| index | description                      |
--------------------------------------------
| [0-3] | signature                        |
| [4]   | revision                         |
| [5]   | override driver settings, or not |
| [6]   | configuration if override        |
| [7]   | reserved                         |

	where field of [6] is a bitmap by country,
	and for now, only define BIT(0) is for US.

Through this function with overriding, BIOS can indicate to allow/block
6 GHz SP power by country.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/acpi.c | 47 +++++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/acpi.h | 14 +++++++
 2 files changed, 61 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/acpi.c b/drivers/net/wireless/realtek/rtw89/acpi.c
index 2e7326a8e3e4..908e980a4b72 100644
--- a/drivers/net/wireless/realtek/rtw89/acpi.c
+++ b/drivers/net/wireless/realtek/rtw89/acpi.c
@@ -77,6 +77,50 @@ int rtw89_acpi_dsm_get_policy_6ghz(struct rtw89_dev *rtwdev,
 	return 0;
 }
 
+static bool chk_acpi_policy_6ghz_sp_sig(const struct rtw89_acpi_policy_6ghz_sp *p)
+{
+	return p->signature[0] == 0x52 &&
+	       p->signature[1] == 0x54 &&
+	       p->signature[2] == 0x4B &&
+	       p->signature[3] == 0x07;
+}
+
+static
+int rtw89_acpi_dsm_get_policy_6ghz_sp(struct rtw89_dev *rtwdev,
+				      union acpi_object *obj,
+				      struct rtw89_acpi_policy_6ghz_sp **policy)
+{
+	const struct rtw89_acpi_policy_6ghz_sp *ptr;
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
+	if (!chk_acpi_policy_6ghz_sp_sig(ptr)) {
+		rtw89_debug(rtwdev, RTW89_DBG_ACPI, "%s: bad signature\n", __func__);
+		return -EINVAL;
+	}
+
+	*policy = kmemdup(ptr, sizeof(*ptr), GFP_KERNEL);
+	if (!*policy)
+		return -ENOMEM;
+
+	rtw89_hex_dump(rtwdev, RTW89_DBG_ACPI, "policy_6ghz_sp: ", *policy,
+		       sizeof(*ptr));
+	return 0;
+}
+
 int rtw89_acpi_evaluate_dsm(struct rtw89_dev *rtwdev,
 			    enum rtw89_acpi_dsm_func func,
 			    struct rtw89_acpi_dsm_result *res)
@@ -95,6 +139,9 @@ int rtw89_acpi_evaluate_dsm(struct rtw89_dev *rtwdev,
 	if (func == RTW89_ACPI_DSM_FUNC_6G_BP)
 		ret = rtw89_acpi_dsm_get_policy_6ghz(rtwdev, obj,
 						     &res->u.policy_6ghz);
+	else if (func == RTW89_ACPI_DSM_FUNC_6GHZ_SP_SUP)
+		ret = rtw89_acpi_dsm_get_policy_6ghz_sp(rtwdev, obj,
+							&res->u.policy_6ghz_sp);
 	else
 		ret = rtw89_acpi_dsm_get_value(rtwdev, obj, &res->u.value);
 
diff --git a/drivers/net/wireless/realtek/rtw89/acpi.h b/drivers/net/wireless/realtek/rtw89/acpi.h
index 5182797e68b6..d274be1775bf 100644
--- a/drivers/net/wireless/realtek/rtw89/acpi.h
+++ b/drivers/net/wireless/realtek/rtw89/acpi.h
@@ -13,6 +13,7 @@ enum rtw89_acpi_dsm_func {
 	RTW89_ACPI_DSM_FUNC_6G_BP = 4,
 	RTW89_ACPI_DSM_FUNC_TAS_EN = 5,
 	RTW89_ACPI_DSM_FUNC_UNII4_SUP = 6,
+	RTW89_ACPI_DSM_FUNC_6GHZ_SP_SUP = 7,
 };
 
 enum rtw89_acpi_conf_unii4 {
@@ -41,11 +42,24 @@ struct rtw89_acpi_policy_6ghz {
 	struct rtw89_acpi_country_code country_list[] __counted_by(country_count);
 } __packed;
 
+enum rtw89_acpi_conf_6ghz_sp {
+	RTW89_ACPI_CONF_6GHZ_SP_US = BIT(0),
+};
+
+struct rtw89_acpi_policy_6ghz_sp {
+	u8 signature[4];
+	u8 revision;
+	u8 override;
+	u8 conf;
+	u8 rsvd;
+} __packed;
+
 struct rtw89_acpi_dsm_result {
 	union {
 		u8 value;
 		/* caller needs to free it after using */
 		struct rtw89_acpi_policy_6ghz *policy_6ghz;
+		struct rtw89_acpi_policy_6ghz_sp *policy_6ghz_sp;
 	} u;
 };
 
-- 
2.25.1


