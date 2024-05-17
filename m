Return-Path: <linux-wireless+bounces-7809-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 477578C8D9F
	for <lists+linux-wireless@lfdr.de>; Fri, 17 May 2024 23:18:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1B852810E4
	for <lists+linux-wireless@lfdr.de>; Fri, 17 May 2024 21:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 386DE38DE0;
	Fri, 17 May 2024 21:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FoTTuVzh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D07E2208F
	for <linux-wireless@vger.kernel.org>; Fri, 17 May 2024 21:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715980709; cv=none; b=JBYTYWJ84Gl6zesaJapZk6ddtDKdW34wsFc/SooQ9MmM4DGC3FPANxzXiXiWPRt/JkAQc/uHF8rMNO4dAn+T78ajt/WC+fJcriGg4P36luQq7ZQHfaU7FcdJjN2To3S28GWGXl9p15G71d3FO+AiGBU2blw8dkSTrUeSBo8wDZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715980709; c=relaxed/simple;
	bh=v9R8GTmgrhj5GUksTougGv3do4pu3VyqeSVnywX7h4g=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=PzahkJSauZjVCvxygW1qzWSPMZtYks2QPhnyichfEhE+TzwEQ/qdCaFmJrjauJrPDtIz20NDYZdgnm9lE0/WW+Y/+hQd7oRPFwTagqLY1+z46FAVLi6sFSxTw9Rmn0xKXQv2FAiVBq8PP2mYwaxKbE6piVFELmcJbhNKqe6OWZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FoTTuVzh; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-572d83e3c7eso5869536a12.3
        for <linux-wireless@vger.kernel.org>; Fri, 17 May 2024 14:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715980705; x=1716585505; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RI/hsJLoJ73t3yG+w8alX/vXZ3C9onvYxxqqQqC4WI0=;
        b=FoTTuVzh6SFXYTqxsf7OuBHVQN3somCSbFZhbB5he0NLsbZyKfh4wcDy+OZ7bumHTi
         xvbxAq0/lSlcIMnN2N42S+DbC1FKll7vFlCC5P3Ds43weKPXAC7d2uLt65QQ7Hm6IOy/
         Ti05maqleNiTcuWdial8FDRLmMpZ3QxsUoliILmEg+I9107yrkffeK7uRnenkkU1kqxK
         lpTwO8qmoIicKFGUNXlQcXXe4nBoHmKX9qfXT65fjY5xDe8pUFY4X8APDDO8czBN8irI
         PNVjI8QpyUtumODo0NIIqOM+EAp2lG2c/m6r9oA53DUGpdVvRJAg9u8GErZO7+yhkia4
         /83A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715980705; x=1716585505;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RI/hsJLoJ73t3yG+w8alX/vXZ3C9onvYxxqqQqC4WI0=;
        b=jUio41AiNFO2BZDPTPv8ICHolrAZAjdc8kt8mMsy0L368xfZbKU0F4aJv4eMPvzJ/L
         ro1VxxmTAmgspSiCEZlfvTp0acUviXDKgzHFgyZQUHByNr8XagLEmqB6LIEHvDTC3olr
         nRZkb4aiRa7Y70vmb601uiOR+mfdtbOx2uNJ/1nh+kLV8Y12AO+q4aYmESZ2Cy8ebSwN
         j6YOVSgexe4f08exZznnf0D0XHX7i+21nQnBlfKHPHD5PwU/LukiwlcAJiLDuw7mBbsm
         LUoCays9jXFNSDTBiLbhnRMsnsFE7lOAxRpa6pgN6LwGHiUkto2Ep553E/rcMsdkfvPz
         VNZw==
X-Gm-Message-State: AOJu0Yz3k8S3QK2HFBy5bB7Wsmh+irBVjP/mfwbdAGG01oNpuXHR4rSx
	q8e4gnYO9+bjPXJdk/ZBO6uU7axvoMgdjFVUqdmHafNBTHIfgoKVds//e+L2
X-Google-Smtp-Source: AGHT+IG2tj2WOrzK55UE5g97FENJqYvi/1G8H95YZEkqLKnvf+7pxw5fAcbTWYo+LvOMcl76IUlVMg==
X-Received: by 2002:a50:c306:0:b0:572:a049:c4bb with SMTP id 4fb4d7f45d1cf-5734d5ccca7mr15361876a12.20.1715980704552;
        Fri, 17 May 2024 14:18:24 -0700 (PDT)
Received: from [192.168.1.50] ([79.113.154.240])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-574ea09b972sm5336636a12.47.2024.05.17.14.18.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 May 2024 14:18:24 -0700 (PDT)
Message-ID: <af28b8fd-af02-4999-b7e9-3922be6459d6@gmail.com>
Date: Sat, 18 May 2024 00:18:23 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v6 07/11] wifi: rtlwifi: Add rtl8192du/fw.{c,h} and
 rtl8192du/led.{c,h}
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>,
 Larry Finger <Larry.Finger@lwfinger.net>,
 Stefan Lippers-Hollmann <s.l-h@gmx.de>,
 Christian Hewitt <chewitt@libreelec.tv>
References: <0c22c048-c372-4596-b2c6-612c6ec7ab77@gmail.com>
Content-Language: en-US
In-Reply-To: <0c22c048-c372-4596-b2c6-612c6ec7ab77@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

fw.c contains a function for loading the firmware.
led.c contains a function for controlling the LED.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v6:
 - Update copyright year.
 - Remove some unused includes.
 - Make all functions use the prefix "rtl92du".

v5:
 - No change.

v4:
 - Fix fw.h and led.h header guards.
 - Add empty lines.
 - Delete globalmutex_for_fwdownload and simplify rtl92d_download_fw.
   It can't run in parallel because mutex_for_hw_init in rtl92du_hw_init
   protects the entire function.

v3:
 - No change.

v2:
 - Patch is new in v2, split from patch 3/3 in v1.
---
 .../wireless/realtek/rtlwifi/rtl8192du/fw.c   | 63 +++++++++++++++++++
 .../wireless/realtek/rtlwifi/rtl8192du/fw.h   |  9 +++
 .../wireless/realtek/rtlwifi/rtl8192du/led.c  | 10 +++
 .../wireless/realtek/rtlwifi/rtl8192du/led.h  |  9 +++
 4 files changed, 91 insertions(+)
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192du/fw.c
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192du/fw.h
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192du/led.c
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192du/led.h

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192du/fw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192du/fw.c
new file mode 100644
index 000000000000..f74e4e84fe39
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192du/fw.c
@@ -0,0 +1,63 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright(c) 2024  Realtek Corporation.*/
+
+#include "../wifi.h"
+#include "../rtl8192d/reg.h"
+#include "../rtl8192d/def.h"
+#include "../rtl8192d/fw_common.h"
+#include "fw.h"
+
+int rtl92du_download_fw(struct ieee80211_hw *hw)
+{
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	struct rtl_hal *rtlhal = rtl_hal(rtlpriv);
+	enum version_8192d version = rtlhal->version;
+	u8 *pfwheader;
+	u8 *pfwdata;
+	u32 fwsize;
+	int err;
+
+	if (rtlpriv->max_fw_size == 0 || !rtlhal->pfirmware)
+		return 1;
+
+	fwsize = rtlhal->fwsize;
+	pfwheader = rtlhal->pfirmware;
+	pfwdata = rtlhal->pfirmware;
+	rtlhal->fw_version = (u16)GET_FIRMWARE_HDR_VERSION(pfwheader);
+	rtlhal->fw_subversion = (u16)GET_FIRMWARE_HDR_SUB_VER(pfwheader);
+
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+		"FirmwareVersion(%d), FirmwareSubVersion(%d), Signature(%#x)\n",
+		rtlhal->fw_version, rtlhal->fw_subversion,
+		GET_FIRMWARE_HDR_SIGNATURE(pfwheader));
+
+	if (IS_FW_HEADER_EXIST(pfwheader)) {
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+			"Shift 32 bytes for FW header!!\n");
+		pfwdata = pfwdata + 32;
+		fwsize = fwsize - 32;
+	}
+
+	if (rtl92d_is_fw_downloaded(rtlpriv))
+		goto exit;
+
+	/* If 8051 is running in RAM code, driver should
+	 * inform Fw to reset by itself, or it will cause
+	 * download Fw fail.
+	 */
+	if (rtl_read_byte(rtlpriv, REG_MCUFWDL) & BIT(7)) {
+		rtl92d_firmware_selfreset(hw);
+		rtl_write_byte(rtlpriv, REG_MCUFWDL, 0x00);
+	}
+
+	rtl92d_enable_fw_download(hw, true);
+	rtl92d_write_fw(hw, version, pfwdata, fwsize);
+	rtl92d_enable_fw_download(hw, false);
+
+	err = rtl92d_fw_free_to_go(hw);
+	if (err)
+		pr_err("fw is not ready to run!\n");
+exit:
+	err = rtl92d_fw_init(hw);
+	return err;
+}
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192du/fw.h b/drivers/net/wireless/realtek/rtlwifi/rtl8192du/fw.h
new file mode 100644
index 000000000000..7904bfbda4ba
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192du/fw.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright(c) 2024  Realtek Corporation.*/
+
+#ifndef __RTL92DU_FW_H__
+#define __RTL92DU_FW_H__
+
+int rtl92du_download_fw(struct ieee80211_hw *hw);
+
+#endif
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192du/led.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192du/led.c
new file mode 100644
index 000000000000..6c12dfbd6367
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192du/led.c
@@ -0,0 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright(c) 2024  Realtek Corporation.*/
+
+#include "../wifi.h"
+#include "led.h"
+
+void rtl92du_led_control(struct ieee80211_hw *hw, enum led_ctl_mode ledaction)
+{
+	/* The hardware has control. */
+}
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192du/led.h b/drivers/net/wireless/realtek/rtlwifi/rtl8192du/led.h
new file mode 100644
index 000000000000..d7ebc8afcc7b
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192du/led.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright(c) 2024  Realtek Corporation.*/
+
+#ifndef __RTL92DU_LED_H__
+#define __RTL92DU_LED_H__
+
+void rtl92du_led_control(struct ieee80211_hw *hw, enum led_ctl_mode ledaction);
+
+#endif
-- 
2.44.0


