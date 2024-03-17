Return-Path: <linux-wireless+bounces-4816-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EC5AF87DF65
	for <lists+linux-wireless@lfdr.de>; Sun, 17 Mar 2024 19:54:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 630FAB20C20
	for <lists+linux-wireless@lfdr.de>; Sun, 17 Mar 2024 18:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B0DA1DFF9;
	Sun, 17 Mar 2024 18:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VMG2jail"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957211DDFC
	for <linux-wireless@vger.kernel.org>; Sun, 17 Mar 2024 18:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710701633; cv=none; b=KzrCS1GCXKcHg/6lLenN0jZp4YiXk9cqAelEOTzacOGrlzV0W/RCOU6SFJH9ceBwhVLEAHglaBOI+qhhuqSu7nEres3Uaa+bLcHeGL+zwmTs2Fhpkes2882YYBmZcb78HwLCH8JfoFMVvz5BtWevHgjjgLcInH7lKq33kaDrXps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710701633; c=relaxed/simple;
	bh=Jn7a88RWF1GiyNS3aFzNxc59VOZnAaA3Z9/cWCpXSdQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=IwJ912SMjg7SAV+eTAyD30jwQzX2o7h0BnevDEC+YFKA436tw6Gg2mVLjk61dQDs2D5XuFawyqJLSnGKM/py/XRDcp9ygFuE2bL+1YR7FAFb7JDWq6q+xzdFQwuWEGD1p/P5m/yRtAh8y4NWUvQMNlGXUIQFsNYaRRUBvED2lNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VMG2jail; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-513d212f818so4214716e87.2
        for <linux-wireless@vger.kernel.org>; Sun, 17 Mar 2024 11:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710701630; x=1711306430; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L00D6MzaitGBJc3Fk524VdE1xPRWBCgfkqI13EAnBDY=;
        b=VMG2jailutnl69QVgDGB53DbR/qMmmQuHmdsaZ3rRXTCcl+00DvH23aPlAdBi8RgJl
         K2zG33QDXdcq2LF7dPqMvwpi/enDmFzMut51kyhvVwC7AFVctqxUP0Q+FUuY0OIKjvaa
         SSJYCwt72IZeRRRQoc4SClwsO8BBMNlweAnHfx2jz5pmJ5aYvNwCk48Badd9d7usqXbG
         KEu8/Jr9GfD3VFwjlA5kVkGy2GLPmL2Tc1lIbau/ANfi0m9vzRIBAlPdtFV9B0u9pEtH
         UBD0vyrhLmuzui3PEqFR/YMBTeR3MkAEooaDu5EnI8bvw7HsHrQEqfKoHQigq+ZGx67a
         TR0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710701630; x=1711306430;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L00D6MzaitGBJc3Fk524VdE1xPRWBCgfkqI13EAnBDY=;
        b=FEeM7gA2XZMT0gOEySLEOu9a4BTvT5AgK/WYTuXC0Cuy6YXVe1aonZZFKwyPFRea/e
         JxYydFoiia0XJc81Ye8ze5vVCeE8TsJP0PHO54nfr2Cn/HJpldaAZ6BEVlpnjPWUmjyI
         Mdg09k9fjcjCkHMBL+yE4h7t5pfq5+OdArrA9mZmtza2li1sKZ0gzJ4VrzfU1vXBbCly
         GN3PJQcyBdmtZjq8mc8xw2AHNXyVVcFAxP4dqQeimD5wo29SC2a6Xr02LsEWWTcqjrzR
         uciEkyvQkaqyh3Rx3lSQjPeK+R0LPSteiENQHf7JqZKsiT39+jePLa5HFx2zUkkMH8ED
         RagA==
X-Gm-Message-State: AOJu0Yy1M1pjiBOf6dnfAHMJAzbgP4Sngp5puKE34dHKrF82B2C65exh
	vuf8rbnxXcTlYFQe78tsQfYF9TXH20BejaKASt88VnukC6QM3iDHx9Pn+uHO
X-Google-Smtp-Source: AGHT+IGXyA8j+vPKcOt2EO9cFXI7fHt4i7M1INlqZf8g9AKuEbNTMTwilVCfkvHKcgNzxBg13BUJNA==
X-Received: by 2002:a19:3810:0:b0:513:96ff:a04a with SMTP id f16-20020a193810000000b0051396ffa04amr5563825lfa.43.1710701629355;
        Sun, 17 Mar 2024 11:53:49 -0700 (PDT)
Received: from [192.168.1.50] ([79.119.240.211])
        by smtp.gmail.com with ESMTPSA id qs28-20020a170906459c00b00a4550e8ae70sm4032071ejc.63.2024.03.17.11.53.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Mar 2024 11:53:49 -0700 (PDT)
Message-ID: <4cb1a6aa-24f3-4dd0-8003-f7a3d3baa76c@gmail.com>
Date: Sun, 17 Mar 2024 20:53:48 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 09/12] wifi: rtlwifi: Add rtl8192du/fw.{c,h} and
 rtl8192du/led.{c,h}
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>,
 Larry Finger <Larry.Finger@lwfinger.net>,
 Stefan Lippers-Hollmann <s.l-h@gmx.de>,
 Christian Hewitt <chewitt@libreelec.tv>
References: <5c23149c-1487-438d-bb37-69e2dd8173dc@gmail.com>
In-Reply-To: <5c23149c-1487-438d-bb37-69e2dd8173dc@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

fw.c contains a function for loading the firmware.
led.c contains a function for controlling the LED.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
Patch is new in v2, split from patch 3/3 in v1.
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

