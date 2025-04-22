Return-Path: <linux-wireless+bounces-21807-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5109DA95AA1
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Apr 2025 03:47:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BBD8173E1A
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Apr 2025 01:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1807F10957;
	Tue, 22 Apr 2025 01:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="ODM1PUIF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300D4156678
	for <linux-wireless@vger.kernel.org>; Tue, 22 Apr 2025 01:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745286430; cv=none; b=Pe6/Rts2TjLhE491y+5WjVnIu7LOYHGDM2YNmvTcOgevYy0tkmJxnKGuW3DYlMbY0Rd8W4vTmXekVNlaevCXc5W5yHIIM4BSs2iBzvK97/XLOI/lTLP/SZtdlPpcimxTjIrR4Qdrd4y3GOEA0R/4h1SWxB9mUKGMueBzer2t1/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745286430; c=relaxed/simple;
	bh=bzPhe8WNL/DxynvkevWT7FneX1cLHNTx2qMPY38WDmM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R/kewnQJOL5KDi0/wL2GtUzQZiGUtjR076QiwHpEnzpR2V6j4A/SDVogMTQoP/UxrcCnWwA27uf/KYKaJOZ/ybophpbGTgC8erSQXmHFMn7kzmxcibcaVJn/fIap4jc+CHT7QTumoevfuYXhhSRVbCauDCF6n5foHCdZLUzW0yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=ODM1PUIF; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 53M1l4Ra93859506, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1745286424; bh=bzPhe8WNL/DxynvkevWT7FneX1cLHNTx2qMPY38WDmM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=ODM1PUIFZBPSS9kn2gjQOQx6SPKJCpeY7ydA/a0JWGzfCNQcyrV4cseGUiOSzJuoB
	 4Ocue3UJVHZs9Q3Hk/n1yJ1XSwd5P1ZppLPq8gWi+MeAP3cieOXppC+dxxcCysPGHj
	 3KTqYuh2O0Z09ZIw8jGeLzvjZ6wR9CGRy2706zCLqZ8FiAGYEcnpxErMvp6yI5oflh
	 7EFHsmbqN90PF5Ivw5n+PYseFSq7m/s0FPIcaf/ART1s0XynNlDiyk37aezTtdQ3i1
	 UYddFKH9ufyoru1iUo+/QBvjosXdYxCYrumyTwTSi+eNuiBsru4QXQ5LWOsiUb1IZ4
	 MytJs8aFqnI8A==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 53M1l4Ra93859506
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 22 Apr 2025 09:47:04 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 22 Apr 2025 09:47:04 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 22 Apr
 2025 09:47:03 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <damon.chen@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 02/12] wifi: rtw89: acpi: introduce country specific TAS enabling
Date: Tue, 22 Apr 2025 09:46:10 +0800
Message-ID: <20250422014620.18421-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250422014620.18421-1-pkshih@realtek.com>
References: <20250422014620.18421-1-pkshih@realtek.com>
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

From: Kuan-Chung Chen <damon.chen@realtek.com>

A new ACPI table entry format for TAS is defined, which includes
a "specific country" field. In this field, determine which
country can enable TAS.

Signed-off-by: Kuan-Chung Chen <damon.chen@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/acpi.c | 45 +++++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/acpi.h | 16 ++++++++
 drivers/net/wireless/realtek/rtw89/core.h |  1 +
 drivers/net/wireless/realtek/rtw89/regd.c | 13 ++++++-
 drivers/net/wireless/realtek/rtw89/sar.c  | 14 +++++--
 5 files changed, 84 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/acpi.c b/drivers/net/wireless/realtek/rtw89/acpi.c
index c97cc29cc663..581d6d4154d3 100644
--- a/drivers/net/wireless/realtek/rtw89/acpi.c
+++ b/drivers/net/wireless/realtek/rtw89/acpi.c
@@ -236,6 +236,49 @@ int rtw89_acpi_dsm_get_policy_6ghz_sp(struct rtw89_dev *rtwdev,
 	return 0;
 }
 
+static bool chk_acpi_policy_tas_sig(const struct rtw89_acpi_policy_tas *p)
+{
+	return p->signature[0] == 0x52 &&
+	       p->signature[1] == 0x54 &&
+	       p->signature[2] == 0x4B &&
+	       p->signature[3] == 0x05;
+}
+
+static int rtw89_acpi_dsm_get_policy_tas(struct rtw89_dev *rtwdev,
+					 union acpi_object *obj,
+					 struct rtw89_acpi_policy_tas **policy)
+{
+	const struct rtw89_acpi_policy_tas *ptr;
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
+	if (!chk_acpi_policy_tas_sig(ptr)) {
+		rtw89_debug(rtwdev, RTW89_DBG_ACPI, "%s: bad signature\n", __func__);
+		return -EINVAL;
+	}
+
+	*policy = kmemdup(ptr, sizeof(*ptr), GFP_KERNEL);
+	if (!*policy)
+		return -ENOMEM;
+
+	rtw89_hex_dump(rtwdev, RTW89_DBG_ACPI, "policy_tas: ", *policy,
+		       sizeof(*ptr));
+	return 0;
+}
+
 int rtw89_acpi_evaluate_dsm(struct rtw89_dev *rtwdev,
 			    enum rtw89_acpi_dsm_func func,
 			    struct rtw89_acpi_dsm_result *res)
@@ -257,6 +300,8 @@ int rtw89_acpi_evaluate_dsm(struct rtw89_dev *rtwdev,
 	else if (func == RTW89_ACPI_DSM_FUNC_6GHZ_SP_SUP)
 		ret = rtw89_acpi_dsm_get_policy_6ghz_sp(rtwdev, obj,
 							&res->u.policy_6ghz_sp);
+	else if (func == RTW89_ACPI_DSM_FUNC_TAS_EN)
+		ret = rtw89_acpi_dsm_get_policy_tas(rtwdev, obj, &res->u.policy_tas);
 	else
 		ret = rtw89_acpi_dsm_get_value(rtwdev, obj, &res->u.value);
 
diff --git a/drivers/net/wireless/realtek/rtw89/acpi.h b/drivers/net/wireless/realtek/rtw89/acpi.h
index 8ec9011bfefb..8c918ee02d2e 100644
--- a/drivers/net/wireless/realtek/rtw89/acpi.h
+++ b/drivers/net/wireless/realtek/rtw89/acpi.h
@@ -31,6 +31,13 @@ enum rtw89_acpi_policy_mode {
 	RTW89_ACPI_POLICY_ALLOW = 1,
 };
 
+enum rtw89_acpi_conf_tas {
+	RTW89_ACPI_CONF_TAS_US = BIT(0),
+	RTW89_ACPI_CONF_TAS_CA = BIT(1),
+	RTW89_ACPI_CONF_TAS_KR = BIT(2),
+	RTW89_ACPI_CONF_TAS_OTHERS = BIT(7),
+};
+
 struct rtw89_acpi_country_code {
 	/* below are allowed:
 	 * * ISO alpha2 country code
@@ -59,12 +66,21 @@ struct rtw89_acpi_policy_6ghz_sp {
 	u8 rsvd;
 } __packed;
 
+struct rtw89_acpi_policy_tas {
+	u8 signature[4];
+	u8 revision;
+	u8 enable;
+	u8 enabled_countries;
+	u8 rsvd[3];
+} __packed;
+
 struct rtw89_acpi_dsm_result {
 	union {
 		u8 value;
 		/* caller needs to free it after using */
 		struct rtw89_acpi_policy_6ghz *policy_6ghz;
 		struct rtw89_acpi_policy_6ghz_sp *policy_6ghz_sp;
+		struct rtw89_acpi_policy_tas *policy_tas;
 	} u;
 };
 
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 68c8bcee2832..54843f95746c 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -4753,6 +4753,7 @@ enum rtw89_tas_state {
 struct rtw89_tas_info {
 	u16 tx_ratio_history[RTW89_TAS_TX_RATIO_WINDOW];
 	u64 txpwr_history[RTW89_TAS_TXPWR_WINDOW];
+	u8 enabled_countries;
 	u8 txpwr_head_idx;
 	u8 txpwr_tail_idx;
 	u8 tx_ratio_idx;
diff --git a/drivers/net/wireless/realtek/rtw89/regd.c b/drivers/net/wireless/realtek/rtw89/regd.c
index 49e9540f2049..61a2ee0d3d57 100644
--- a/drivers/net/wireless/realtek/rtw89/regd.c
+++ b/drivers/net/wireless/realtek/rtw89/regd.c
@@ -758,11 +758,22 @@ static void rtw89_regd_apply_policy_tas(struct rtw89_dev *rtwdev)
 	struct rtw89_regulatory_info *regulatory = &rtwdev->regulatory;
 	const struct rtw89_regd *regd = regulatory->regd;
 	struct rtw89_tas_info *tas = &rtwdev->tas;
+	u8 tas_country;
 
 	if (!tas->enable)
 		return;
 
-	tas->block_regd = !test_bit(RTW89_REGD_FUNC_TAS, regd->func_bitmap);
+	if (memcmp("US", regd->alpha2, 2) == 0)
+		tas_country = RTW89_ACPI_CONF_TAS_US;
+	else if (memcmp("CA", regd->alpha2, 2) == 0)
+		tas_country = RTW89_ACPI_CONF_TAS_CA;
+	else if (memcmp("KR", regd->alpha2, 2) == 0)
+		tas_country = RTW89_ACPI_CONF_TAS_KR;
+	else
+		tas_country = RTW89_ACPI_CONF_TAS_OTHERS;
+
+	tas->block_regd = !(tas->enabled_countries & tas_country &&
+			    test_bit(RTW89_REGD_FUNC_TAS, regd->func_bitmap));
 }
 
 static void rtw89_regd_apply_policy_ant_gain(struct rtw89_dev *rtwdev)
diff --git a/drivers/net/wireless/realtek/rtw89/sar.c b/drivers/net/wireless/realtek/rtw89/sar.c
index d15dafcae39b..517b66022f18 100644
--- a/drivers/net/wireless/realtek/rtw89/sar.c
+++ b/drivers/net/wireless/realtek/rtw89/sar.c
@@ -695,9 +695,9 @@ static void rtw89_tas_init(struct rtw89_dev *rtwdev)
 {
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 	struct rtw89_tas_info *tas = &rtwdev->tas;
+	const struct rtw89_acpi_policy_tas *ptr;
 	struct rtw89_acpi_dsm_result res = {};
 	int ret;
-	u8 val;
 
 	if (!chip->support_tas)
 		return;
@@ -709,8 +709,9 @@ static void rtw89_tas_init(struct rtw89_dev *rtwdev)
 		return;
 	}
 
-	val = res.u.value;
-	switch (val) {
+	ptr = res.u.policy_tas;
+
+	switch (ptr->enable) {
 	case 0:
 		tas->enable = false;
 		break;
@@ -723,8 +724,13 @@ static void rtw89_tas_init(struct rtw89_dev *rtwdev)
 
 	if (!tas->enable) {
 		rtw89_debug(rtwdev, RTW89_DBG_SAR, "TAS not enable\n");
-		return;
+		goto out;
 	}
+
+	tas->enabled_countries = ptr->enabled_countries;
+
+out:
+	kfree(ptr);
 }
 
 void rtw89_tas_reset(struct rtw89_dev *rtwdev, bool force)
-- 
2.25.1


