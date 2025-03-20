Return-Path: <linux-wireless+bounces-20600-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E93AA69EC8
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Mar 2025 04:29:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FB757B20BB
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Mar 2025 03:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCF9B1EDA15;
	Thu, 20 Mar 2025 03:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="ZdaxvjtJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA521EBFEB
	for <linux-wireless@vger.kernel.org>; Thu, 20 Mar 2025 03:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742441277; cv=none; b=BOfSmvtlxroADRAlqwYD0NfZBkSCjJwEmeeiUl6NhBJIVZwqMzn+LNjBiLD29hR97bOctbnfkb57i51Zqwkf9/2izPWv24IgxW8apVcJUvxcvD92P6gE7Nbido0MtF3+hxQHULBBXtlS0WFWpPtaHJjt+buM0f7P0Qah6Q14Fb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742441277; c=relaxed/simple;
	bh=cOlo97N04GUM0U77WKK/YIZTvCLSOzlx7Y8Rk8iGPhc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nIts7+lwjm3HSC9rObHYBJPG4I1lr+dVtLVtl1RFXaLIS7vnDUwkzdqOhOS1+/mZO78zdOWry9kCWv2HyL9qzcVI4Y9527R2bWzXNDUDn7yUWx9brQG/8NiAyqZzb0l+37iFgZ+gEyWrjvtFTrEfp7zj6RT3rjRFR4rTfJ965DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=ZdaxvjtJ; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 52K3RqhR61750923, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1742441272; bh=cOlo97N04GUM0U77WKK/YIZTvCLSOzlx7Y8Rk8iGPhc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=ZdaxvjtJ17eISvUex8H3mCQrROPnpmZNx4OFHaB6vWEuWfBfZW4hARmYo9ucsC0Ep
	 kbS7Dv9FaYSDkAueyOPyPwo0F/EQySq3kkCVLRMtZ0uyzzH6IaRre7Ps7/T4jsU/nO
	 kplixcC8ZVaZpT+cbja9hX+sHFXQ/YoeMs8P8bcPbJPBoV0kI5kg0DW1GMIvA/Qm8t
	 +uvXlOw7ejWiaezgjiAZ6oGhxq/+luqvDNjMs1qzIKz6NeDUoWnU/W7KWqvSDcvDWB
	 PDPJXO8Wb1+Itq6DXJXqeexD2jqDfdce9ZvCvB1VsrkUSQWNr0MpNwt5a6tYnLER5F
	 RiUpZcBanxOhA==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 52K3RqhR61750923
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 20 Mar 2025 11:27:52 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 20 Mar 2025 11:27:53 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 20 Mar
 2025 11:27:51 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 05/12] wifi: rtw89: acpi: introduce method evaluation function for reuse
Date: Thu, 20 Mar 2025 11:27:05 +0800
Message-ID: <20250320032712.20284-6-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250320032712.20284-1-pkshih@realtek.com>
References: <20250320032712.20284-1-pkshih@realtek.com>
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

The following implementations will evaluate different ACPI methods, but
the pre-process flow of them are the same. So, introduce a function for
these pre-process things. Besides, also change ACPI RTAG method to call
this function.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/acpi.c | 146 ++++++++++++++++++----
 drivers/net/wireless/realtek/rtw89/acpi.h |   5 +
 2 files changed, 126 insertions(+), 25 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/acpi.c b/drivers/net/wireless/realtek/rtw89/acpi.c
index b870a3df4072..97b069062ec8 100644
--- a/drivers/net/wireless/realtek/rtw89/acpi.c
+++ b/drivers/net/wireless/realtek/rtw89/acpi.c
@@ -12,6 +12,121 @@ static const guid_t rtw89_guid = GUID_INIT(0xD2A8C3E8, 0x4B69, 0x4F00,
 					   0x82, 0xBD, 0xFE, 0x86,
 					   0x07, 0x80, 0x3A, 0xA7);
 
+static u32 rtw89_acpi_traversal_object(struct rtw89_dev *rtwdev,
+				       const union acpi_object *obj, u8 *pos)
+{
+	const union acpi_object *elm;
+	unsigned int i;
+	u32 sub_len;
+	u32 len = 0;
+	u8 *tmp;
+
+	switch (obj->type) {
+	case ACPI_TYPE_INTEGER:
+		if (pos)
+			pos[len] = obj->integer.value;
+
+		len++;
+		break;
+	case ACPI_TYPE_BUFFER:
+		if (unlikely(obj->buffer.length == 0)) {
+			rtw89_debug(rtwdev, RTW89_DBG_ACPI,
+				    "%s: invalid buffer type\n", __func__);
+			goto err;
+		}
+
+		if (pos)
+			memcpy(pos, obj->buffer.pointer, obj->buffer.length);
+
+		len += obj->buffer.length;
+		break;
+	case ACPI_TYPE_PACKAGE:
+		if (unlikely(obj->package.count == 0)) {
+			rtw89_debug(rtwdev, RTW89_DBG_ACPI,
+				    "%s: invalid package type\n", __func__);
+			goto err;
+		}
+
+		for (i = 0; i < obj->package.count; i++) {
+			elm = &obj->package.elements[i];
+			tmp = pos ? pos + len : NULL;
+
+			sub_len = rtw89_acpi_traversal_object(rtwdev, elm, tmp);
+			if (unlikely(sub_len == 0))
+				goto err;
+
+			len += sub_len;
+		}
+		break;
+	default:
+		rtw89_debug(rtwdev, RTW89_DBG_ACPI, "%s: unhandled type: %d\n",
+			    __func__, obj->type);
+		goto err;
+	}
+
+	return len;
+
+err:
+	return 0;
+}
+
+static u32 rtw89_acpi_calculate_object_length(struct rtw89_dev *rtwdev,
+					      const union acpi_object *obj)
+{
+	return rtw89_acpi_traversal_object(rtwdev, obj, NULL);
+}
+
+static struct rtw89_acpi_data *
+rtw89_acpi_evaluate_method(struct rtw89_dev *rtwdev, const char *method)
+{
+	struct acpi_buffer buf = {ACPI_ALLOCATE_BUFFER, NULL};
+	struct rtw89_acpi_data *data = NULL;
+	acpi_handle root, handle;
+	union acpi_object *obj;
+	acpi_status status;
+	u32 len;
+
+	root = ACPI_HANDLE(rtwdev->dev);
+	if (!root) {
+		rtw89_debug(rtwdev, RTW89_DBG_ACPI,
+			    "acpi (%s): failed to get root\n", method);
+		return NULL;
+	}
+
+	status = acpi_get_handle(root, (acpi_string)method, &handle);
+	if (ACPI_FAILURE(status)) {
+		rtw89_debug(rtwdev, RTW89_DBG_ACPI,
+			    "acpi (%s): failed to get handle\n", method);
+		return NULL;
+	}
+
+	status = acpi_evaluate_object(handle, NULL, NULL, &buf);
+	if (ACPI_FAILURE(status)) {
+		rtw89_debug(rtwdev, RTW89_DBG_ACPI,
+			    "acpi (%s): failed to evaluate object\n", method);
+		return NULL;
+	}
+
+	obj = buf.pointer;
+	len = rtw89_acpi_calculate_object_length(rtwdev, obj);
+	if (unlikely(len == 0)) {
+		rtw89_debug(rtwdev, RTW89_DBG_ACPI,
+			    "acpi (%s): failed to traversal obj len\n", method);
+		goto out;
+	}
+
+	data = kzalloc(struct_size(data, buf, len), GFP_KERNEL);
+	if (!data)
+		goto out;
+
+	data->len = len;
+	rtw89_acpi_traversal_object(rtwdev, obj, data->buf);
+
+out:
+	ACPI_FREE(obj);
+	return data;
+}
+
 static
 int rtw89_acpi_dsm_get_value(struct rtw89_dev *rtwdev, union acpi_object *obj,
 			     u8 *value)
@@ -152,34 +267,15 @@ int rtw89_acpi_evaluate_dsm(struct rtw89_dev *rtwdev,
 int rtw89_acpi_evaluate_rtag(struct rtw89_dev *rtwdev,
 			     struct rtw89_acpi_rtag_result *res)
 {
-	struct acpi_buffer buf = {ACPI_ALLOCATE_BUFFER, NULL};
-	acpi_handle root, handle;
-	union acpi_object *obj;
-	acpi_status status;
+	const struct rtw89_acpi_data *data;
 	u32 buf_len;
 	int ret = 0;
 
-	root = ACPI_HANDLE(rtwdev->dev);
-	if (!root)
-		return -EOPNOTSUPP;
-
-	status = acpi_get_handle(root, (acpi_string)"RTAG", &handle);
-	if (ACPI_FAILURE(status))
-		return -EIO;
-
-	status = acpi_evaluate_object(handle, NULL, NULL, &buf);
-	if (ACPI_FAILURE(status))
+	data = rtw89_acpi_evaluate_method(rtwdev, "RTAG");
+	if (!data)
 		return -EIO;
 
-	obj = buf.pointer;
-	if (obj->type != ACPI_TYPE_BUFFER) {
-		rtw89_debug(rtwdev, RTW89_DBG_ACPI,
-			    "acpi: expect buffer but type: %d\n", obj->type);
-		ret = -EINVAL;
-		goto out;
-	}
-
-	buf_len = obj->buffer.length;
+	buf_len = data->len;
 	if (buf_len != sizeof(*res)) {
 		rtw89_debug(rtwdev, RTW89_DBG_ACPI, "%s: invalid buffer length: %u\n",
 			    __func__, buf_len);
@@ -187,12 +283,12 @@ int rtw89_acpi_evaluate_rtag(struct rtw89_dev *rtwdev,
 		goto out;
 	}
 
-	*res = *(struct rtw89_acpi_rtag_result *)obj->buffer.pointer;
+	*res = *(struct rtw89_acpi_rtag_result *)data->buf;
 
 	rtw89_hex_dump(rtwdev, RTW89_DBG_ACPI, "antenna_gain: ", res, sizeof(*res));
 
 out:
-	ACPI_FREE(obj);
+	kfree(data);
 	return ret;
 }
 
diff --git a/drivers/net/wireless/realtek/rtw89/acpi.h b/drivers/net/wireless/realtek/rtw89/acpi.h
index a7f583a2164f..1f5d732c33c0 100644
--- a/drivers/net/wireless/realtek/rtw89/acpi.h
+++ b/drivers/net/wireless/realtek/rtw89/acpi.h
@@ -7,6 +7,11 @@
 
 #include "core.h"
 
+struct rtw89_acpi_data {
+	u32 len;
+	u8 buf[] __counted_by(len);
+};
+
 enum rtw89_acpi_dsm_func {
 	RTW89_ACPI_DSM_FUNC_IDN_BAND_SUP = 2,
 	RTW89_ACPI_DSM_FUNC_6G_DIS = 3,
-- 
2.25.1


