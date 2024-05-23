Return-Path: <linux-wireless+bounces-8021-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 344048CD613
	for <lists+linux-wireless@lfdr.de>; Thu, 23 May 2024 16:47:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1B621F21347
	for <lists+linux-wireless@lfdr.de>; Thu, 23 May 2024 14:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA3A54C8C;
	Thu, 23 May 2024 14:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ot3uikwE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7B56FB6
	for <linux-wireless@vger.kernel.org>; Thu, 23 May 2024 14:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716475644; cv=none; b=UFBw3ClQJt3YuaB/VyA0GwawC3JvAQvTWeWWCD+y7ojvc23jQaPJd1xwYyqSwaisxyZerJTo2WC/a8YJcTSgIY/koP0lLlPELRfqbzxNTZyeNBysv1hLlA3849JCxBxeK8rd2MS1fePQaS7Tie1RbrIlHZ027AXIB86lpdZEds4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716475644; c=relaxed/simple;
	bh=1nDApJvzoJqg3dB25Tj8BakDYNyOgw0WGU9zCYgpBEE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=OZfTNVTE6nm7rrH620x1lADjVEQCXEoBYc+V4TiXE/juU+DWaJaFlcZ6rvdwcXuCn26R9YI9+YplCBpug7DrMFEW7zdHoWHxN2jDJSzlfLaoGUg2ABsIMTUuH3xemDZ0VzKdpBCkaadQ9UD64xrVKmo1dBxyPoovtr6Icyun/y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ot3uikwE; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-56e1baf0380so12071207a12.3
        for <linux-wireless@vger.kernel.org>; Thu, 23 May 2024 07:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716475641; x=1717080441; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JNm6EkMfuml6R1mYTp4e9U0hTp+L/fLlIOjeSTRie7g=;
        b=Ot3uikwEgXhezsiyQK4gIOZ+0XHSte9J0TUcM+qDNcP7WkUPg8wHPpcg7zv1TGnJNb
         /M2aPPWGjLXUG1kIJnUW6eU8LXxMd5INfN5RTXEeZTEnPEipoXNluXM1D0bXp4aI5GCF
         SFYQxC+oUE2RKNC+LpDhBWtyxfjX2rxXwlfkgHjKoMQU5HQxDISXu6NBHTuvSi+lupIH
         3aGK2A+MzEHNL4g/pzxHz537fScwnV3J5socXxfQ3pTzBNRNfMlswxg031Vt2DyCVyDC
         ihmPTnoeqppsvAMcxgAAksFnwP2yu25QDsY96bOZCnamvm3pq3K9dUKS+6BhuUK6DbBs
         VQZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716475641; x=1717080441;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JNm6EkMfuml6R1mYTp4e9U0hTp+L/fLlIOjeSTRie7g=;
        b=i2VOw2EF0V4PwB0HnCdxE6Q4KZJpAJdq7FtXGb0IZAtH+8qIbgErlLKIrfSsHfmXtF
         6nyokoG2SYmmhf6Z6tl+P9E9niqDxdcKj6KPJ4zfhjWkp3NnfG+eNuiQ55AcrbxZHoUy
         jFs3C1J2dRd0byBCggsxXXA5EzEIjYhAKVqndA1VNH/PLKxWc0bS8BwE74nurRXSh7Er
         FY92CFrhHw1gICk7foXtXSpyn4TZkRiY1ulf7v2SzCjlr10w0YQeYzoxw7MurQQsi9oL
         Y/bFxU+DtzsKHRvLrLJWZXH/9iaVg7Gb4FlBFN+eiUXfkvGwyLBLQOE9PiHDFlW+p5zr
         lLeA==
X-Gm-Message-State: AOJu0YyHGBvWBVBdx1MbjB0cqCevzzcYW1UcS77Imbl8O6BA/kFzM1U7
	zbP5uUdmvSzvGyeTDOaz+iOm7XrLpKzNG+FqwpQT3P3+V/3bWCmYEyj3Cg==
X-Google-Smtp-Source: AGHT+IH7CrODgJiaVV/UfJRLgidWhemjILa84237Tsk5GNAixPd/pSBRmv0DssfMekjSAFxO53/t8Q==
X-Received: by 2002:a50:c09a:0:b0:572:6f3d:7208 with SMTP id 4fb4d7f45d1cf-57832be63eamr3575544a12.29.1716475641319;
        Thu, 23 May 2024 07:47:21 -0700 (PDT)
Received: from [192.168.0.50] ([81.196.40.5])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5733c2c7de4sm19790698a12.63.2024.05.23.07.47.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 May 2024 07:47:21 -0700 (PDT)
Message-ID: <a52b8907-267c-4811-90ca-5eb852a2aa09@gmail.com>
Date: Thu, 23 May 2024 17:47:19 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v7 08/12] wifi: rtlwifi: Add rtl8192du/fw.{c,h} and
 rtl8192du/led.{c,h}
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>,
 Larry Finger <Larry.Finger@lwfinger.net>,
 Stefan Lippers-Hollmann <s.l-h@gmx.de>,
 Christian Hewitt <chewitt@libreelec.tv>
References: <8805826b-60b9-4026-9509-7d92c3a43577@gmail.com>
Content-Language: en-US
In-Reply-To: <8805826b-60b9-4026-9509-7d92c3a43577@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

fw.c contains a function for loading the firmware.
led.c contains a function for controlling the LED.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v7:
 - No change.

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
2.45.1


