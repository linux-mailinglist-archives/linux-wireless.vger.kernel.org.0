Return-Path: <linux-wireless+bounces-5033-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 128C488180A
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 20:41:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7CEA5B21A81
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 19:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1F9F53E2C;
	Wed, 20 Mar 2024 19:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="db7Qel8T"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF95E6A348
	for <linux-wireless@vger.kernel.org>; Wed, 20 Mar 2024 19:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710963673; cv=none; b=qksRR6XczbFsKWdTY5CvgXR51tsZS0hu0AGKTukfOu7J/wJCtPUw5BZNOcNqMaNnxqh1CcR6J4kfDESs7nooF0N8He86hDnLC9bZuvaa11S6HuVypYF6TmHz2gq8ZHvuUHPURMvsoLP1iTwnU30RM6333G9y+aXlvAWNtro31UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710963673; c=relaxed/simple;
	bh=vv3I/BOkFoSBitki+nSm6h/2+rVQ+9RUjNJ6eR+Qzho=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=QFshshE9DB6z4c3BXfxRSXmRtORdVKAufdL7OMVA9G6RrkaNN9XLFHXFFs+p+bb2uryfM9I2aXRe/e3IXAZmopTqLTvHODglddh8M0G5QjRXZ5K/EoEYr1MLX05u3O3bP5bxHGFTkwEBVgChkocO3Ye55fw/g3DZJ/AGSRrscMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=db7Qel8T; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-41468f6d584so1419265e9.0
        for <linux-wireless@vger.kernel.org>; Wed, 20 Mar 2024 12:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710963670; x=1711568470; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1nxfpbX81TtXaprLZlvHa7ksT74QknOsMLNhEyT6ifw=;
        b=db7Qel8ThhwimmwGswaFtkTxJeXrmCIbQEP438eH21F2Ib6G0olOKrwN4pSuTqlzek
         P9iHoPIvsE7gLaud1EiMK7tbeu7N25hGiylI5lwB+qyrGlrLWx9mMpqHByAoIJ7Lce5H
         H7FDOfbrVx1aVIQ1dk7ElywrHeSGJC8PycBXG++3poZrkzN4xaULlsEvs9tAdug+MEiM
         UTrY1J7Dy6E7TJ7fZW1FrtpBi1pzSSSDJ8POsFaeZPtSh5oyWpYvjPvUcYei9/eNigkw
         5hjNrJKKECwxp+2im360lgwxHNJTCvce8CBDRCCf9anbzIBOHPEGOcBRSKBJRwXTrEP2
         QlBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710963670; x=1711568470;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1nxfpbX81TtXaprLZlvHa7ksT74QknOsMLNhEyT6ifw=;
        b=iHNFDKB2dTDDI8OzooFIvyDl6DZ6I5XpKeALI9n+AAXngQ3AeaO21ofdxhUNCRe6gD
         WHO8D2ZnmsdCI9PJFVQYGKKnRVe4tSWKHSZDlfl27YK2glJrwqKbJpg7/0OsO7HIOA8Z
         KSgyERY9qp28vYEXK52T8GSy8xVmJJFttDA01A6GLBPvI+6JsHjI3AlqeDTWfMmTUKMt
         pkKbxBv7gHEkm/PhPLBUyLam57bTm8yOT8pqXoaho3XZpeHRac0eq1UfKISulvb4Q1c3
         JxCeVuIxtjF0OkJm2txP6TRuxDVUZJyKXc4bQOuUNxEGXJknohvi8dNJym5r16fiw2pA
         XqjA==
X-Gm-Message-State: AOJu0Yzm8TO5s0YgIbwQsfli7I/X8G93DyYhfe+p0fVA4gAhVKb+UyPH
	wwczeh4KLkKCVdnnw6og7AvCalfdP92u4qAkfp/k82ZXBW9JAoGu+rPkIks5
X-Google-Smtp-Source: AGHT+IFjci0fwyY9AKDxq/ONLzspt/Kr5nSjVeLHgXnV1KZAGLBQPIZoCD5dRFpICsHx1emW44GknQ==
X-Received: by 2002:a05:600c:458e:b0:412:dca9:aa83 with SMTP id r14-20020a05600c458e00b00412dca9aa83mr14925030wmo.21.1710963670219;
        Wed, 20 Mar 2024 12:41:10 -0700 (PDT)
Received: from [192.168.1.50] ([79.119.240.211])
        by smtp.gmail.com with ESMTPSA id bd6-20020a05600c1f0600b0041330d49604sm3176610wmb.45.2024.03.20.12.41.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Mar 2024 12:41:09 -0700 (PDT)
Message-ID: <254c1ce0-3d28-4f7f-97c2-e94515e3dc66@gmail.com>
Date: Wed, 20 Mar 2024 21:41:09 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v3 09/12] wifi: rtlwifi: Add rtl8192du/fw.{c,h} and
 rtl8192du/led.{c,h}
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>,
 Larry Finger <Larry.Finger@lwfinger.net>,
 Stefan Lippers-Hollmann <s.l-h@gmx.de>,
 Christian Hewitt <chewitt@libreelec.tv>
References: <7f4b3309-1580-48f3-9426-29f1eb4052fd@gmail.com>
In-Reply-To: <7f4b3309-1580-48f3-9426-29f1eb4052fd@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

fw.c contains a function for loading the firmware.
led.c contains a function for controlling the LED.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v3:
 - No change.

v2:
 - Patch is new in v2, split from patch 3/3 in v1.
---
 .../wireless/realtek/rtlwifi/rtl8192du/fw.c   | 109 ++++++++++++++++++
 .../wireless/realtek/rtlwifi/rtl8192du/fw.h   |   9 ++
 .../wireless/realtek/rtlwifi/rtl8192du/led.c  |  10 ++
 .../wireless/realtek/rtlwifi/rtl8192du/led.h  |   9 ++
 4 files changed, 137 insertions(+)
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192du/fw.c
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192du/fw.h
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192du/led.c
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192du/led.h

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192du/fw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192du/fw.c
new file mode 100644
index 000000000000..1521460f4f37
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192du/fw.c
@@ -0,0 +1,109 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright(c) 2009-2012  Realtek Corporation.*/
+
+#include "../wifi.h"
+#include "../pci.h"
+#include "../base.h"
+#include "../efuse.h"
+#include "../rtl8192d/reg.h"
+#include "../rtl8192d/def.h"
+#include "../rtl8192d/fw_common.h"
+#include "fw.h"
+#include "sw.h"
+
+int rtl92d_download_fw(struct ieee80211_hw *hw)
+{
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	struct rtl_hal *rtlhal = rtl_hal(rtlpriv);
+	enum version_8192d version = rtlhal->version;
+	bool fwdl_in_process = false;
+	bool fw_downloaded = false;
+	u32 fwsize, count;
+	u8 *pfwheader;
+	u8 *pfwdata;
+	u8 value;
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
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+		"FirmwareVersion(%d), FirmwareSubVersion(%d), Signature(%#x)\n",
+		rtlhal->fw_version, rtlhal->fw_subversion,
+		GET_FIRMWARE_HDR_SIGNATURE(pfwheader));
+	if (IS_FW_HEADER_EXIST(pfwheader)) {
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD,
+			"Shift 32 bytes for FW header!!\n");
+		pfwdata = pfwdata + 32;
+		fwsize = fwsize - 32;
+	}
+
+	mutex_lock(&globalmutex_for_fwdownload);
+	fw_downloaded = rtl92d_is_fw_downloaded(rtlpriv);
+	if ((rtl_read_byte(rtlpriv, 0x1f) & BIT(5)) == BIT(5))
+		fwdl_in_process = true;
+	else
+		fwdl_in_process = false;
+	if (fw_downloaded) {
+		mutex_unlock(&globalmutex_for_fwdownload);
+		goto exit;
+	} else if (fwdl_in_process) {
+		mutex_unlock(&globalmutex_for_fwdownload);
+		for (count = 0; count < 5000; count++) {
+			udelay(500);
+			mutex_lock(&globalmutex_for_fwdownload);
+			fw_downloaded = rtl92d_is_fw_downloaded(rtlpriv);
+			if ((rtl_read_byte(rtlpriv, 0x1f) & BIT(5)) == BIT(5))
+				fwdl_in_process = true;
+			else
+				fwdl_in_process = false;
+			mutex_unlock(&globalmutex_for_fwdownload);
+			if (fw_downloaded)
+				goto exit;
+			else if (!fwdl_in_process)
+				break;
+
+			rtl_dbg(rtlpriv, COMP_FW, DBG_DMESG,
+				"Wait for another mac download fw\n");
+		}
+		mutex_lock(&globalmutex_for_fwdownload);
+		value = rtl_read_byte(rtlpriv, 0x1f);
+		value |= BIT(5);
+		rtl_write_byte(rtlpriv, 0x1f, value);
+		mutex_unlock(&globalmutex_for_fwdownload);
+	} else {
+		value = rtl_read_byte(rtlpriv, 0x1f);
+		value |= BIT(5);
+		rtl_write_byte(rtlpriv, 0x1f, value);
+		mutex_unlock(&globalmutex_for_fwdownload);
+	}
+
+	/* If 8051 is running in RAM code, driver should
+	 * inform Fw to reset by itself, or it will cause
+	 * download Fw fail.
+	 */
+	if (rtl_read_byte(rtlpriv, REG_MCUFWDL) & BIT(7)) {
+		rtl92d_firmware_selfreset(hw);
+		rtl_write_byte(rtlpriv, REG_MCUFWDL, 0x00);
+	}
+	rtl92d_enable_fw_download(hw, true);
+	rtl92d_write_fw(hw, version, pfwdata, fwsize);
+	rtl92d_enable_fw_download(hw, false);
+	mutex_lock(&globalmutex_for_fwdownload);
+	err = rtl92d_fw_free_to_go(hw);
+	/* download fw over,clear 0x1f[5] */
+	value = rtl_read_byte(rtlpriv, 0x1f);
+	value &= (~BIT(5));
+	rtl_write_byte(rtlpriv, 0x1f, value);
+	mutex_unlock(&globalmutex_for_fwdownload);
+	if (err)
+		pr_err("fw is not ready to run!\n");
+exit:
+	err = rtl92d_fw_init(hw);
+	return err;
+}
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192du/fw.h b/drivers/net/wireless/realtek/rtlwifi/rtl8192du/fw.h
new file mode 100644
index 000000000000..857431fe8952
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192du/fw.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright(c) 2009-2012  Realtek Corporation.*/
+
+#ifndef __RTL92D__FW__H__
+#define __RTL92D__FW__H__
+
+int rtl92d_download_fw(struct ieee80211_hw *hw);
+
+#endif
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192du/led.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192du/led.c
new file mode 100644
index 000000000000..a2761f25e94e
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192du/led.c
@@ -0,0 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright(c) 2009-2012  Realtek Corporation.*/
+
+#include "../wifi.h"
+#include "led.h"
+
+void rtl92de_led_control(struct ieee80211_hw *hw, enum led_ctl_mode ledaction)
+{
+	/* The hardware has control. */
+}
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192du/led.h b/drivers/net/wireless/realtek/rtlwifi/rtl8192du/led.h
new file mode 100644
index 000000000000..b7f7a74d5261
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192du/led.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright(c) 2009-2012  Realtek Corporation.*/
+
+#ifndef __RTL92CE_LED_H__
+#define __RTL92CE_LED_H__
+
+void rtl92de_led_control(struct ieee80211_hw *hw, enum led_ctl_mode ledaction);
+
+#endif
-- 
2.43.2

