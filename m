Return-Path: <linux-wireless+bounces-6048-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 837E889E408
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Apr 2024 21:59:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBA06B21221
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Apr 2024 19:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 686F915749A;
	Tue,  9 Apr 2024 19:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VL6NQJxo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F193156F4E
	for <linux-wireless@vger.kernel.org>; Tue,  9 Apr 2024 19:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712692741; cv=none; b=NuTEVzFJgnzbuweC2zc24eEfM2/4qvuK4uuUdEknLZDyJkpgXMozdCsQr7SF9dS8bk5UOVvsqFC/E37o1OiJmKH26BpRCd+ZFU9VZZNO9zOmoU3OsWqX0oSTxe1O8WklS652A8LZ0LDJJEUpENu8Fa3EXKb7yq4Q2tuPwVasu0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712692741; c=relaxed/simple;
	bh=4zZMoWZ+abAPEZHN81Ch089gBElESjPhx5Cq+pQZ9u4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=eqEnjCpX+zj3mGj9h63PDLrtEa9RxaUQMIzfo0exxNFsVqkm9lrihuVVVY5bxD+I9K4xwurL4mh0jDEoLIIJFCA6bfPbk4Zu6P2kyh3ShHfQP/ERGkgFFIWJ+PCj3JJmPsMfT8ozg1qQqHSiYeUuuEL0N6KEQqEGMCqOexJsW98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VL6NQJxo; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-516d6e23253so4706643e87.1
        for <linux-wireless@vger.kernel.org>; Tue, 09 Apr 2024 12:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712692737; x=1713297537; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TTDBETWvgfspHsqCcmbZiPdgDcc0NAGoCEJDQpyzTrQ=;
        b=VL6NQJxoCdRnnDmtEr+aHOwhwq1EShC7bhp8TcmfQDmJ+CsgjYGNJg1cp9S17VZMx+
         /UbHC/aZA2UJfGDO2h9Ckhi8E/bm3lb0ZOMKAL22PhSRDzjPp2xrFBZCFI116PUfWCZG
         1BdenQI3A895uDB0KF2PXd3Bcck5rKEsUYNf/92hg2H30a19yoYr5uRon8FQMAblJ/ra
         I5JQY94w6Ibwibo92Pu30YoLUy/XYHDAJVLhdIei426opkJv4UVXg5DuqPNZGQVJPMDz
         v+XeMHfn741Sh7mKier/4W9tR/W5FlgryhKw6oxGtZ0XYkPmiii0KOSbuLU2rxvbqz92
         HOtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712692737; x=1713297537;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TTDBETWvgfspHsqCcmbZiPdgDcc0NAGoCEJDQpyzTrQ=;
        b=k9ryEE51+Ki3/UNt6/rwW08jLTp79AoeChC20rpm+FmtHBj01AdWDJhWAsoGwfzT9U
         k3Q7NXVI8AhsD0Iwe/pIJ2emyF8VDPIyjIAhGXVncQaXgZK8kj+d1MS3P/XHCa55uhMf
         Zs5gjugzWg2AaikI3lQrKCNSyT+CmmVrNo1xmNdLX6W88H4JM0OMbXrG27J444y9QO/f
         ag6wvs7ndoCBmza6/A77b/LixENGaA4fcRYXZV++mhv5quVPKRAw3f+gUU6tDVZ81yq1
         zHd+UGhDT4ICDJHCskbrId5U8gIzR+YrfTreJ3it8v4e4CLARa26Xr+C/RSWHHzv/asa
         1XgA==
X-Gm-Message-State: AOJu0Yw1QWqt3c5UF0y7o7L6hN4MWeEA0tlPQeDiBq2Lup//HTXi4zX1
	GwMWMGZXjl5u8ulpBXj9Z5DZaQDpflf8uXXYM2J7tFxSZMaZQXSnnHr99lCBA3o=
X-Google-Smtp-Source: AGHT+IGaGV1SmEvrxmZnFnUeGzS2PU6Ttl7jJt/QUaX1vVO36WoQLGgzwZJrm1EyQArWNxZQe8kOpw==
X-Received: by 2002:a19:6b16:0:b0:513:db34:7caf with SMTP id d22-20020a196b16000000b00513db347cafmr354660lfa.17.1712692737250;
        Tue, 09 Apr 2024 12:58:57 -0700 (PDT)
Received: from [192.168.1.50] ([79.113.154.240])
        by smtp.gmail.com with ESMTPSA id og15-20020a1709071dcf00b00a47423b4c33sm6027305ejc.128.2024.04.09.12.58.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Apr 2024 12:58:56 -0700 (PDT)
Message-ID: <4dddf301-47c8-45dd-ae82-c6b8a83cfeb7@gmail.com>
Date: Tue, 9 Apr 2024 22:58:55 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v4 10/14] wifi: rtlwifi: Add rtl8192du/fw.{c,h} and
 rtl8192du/led.{c,h}
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>,
 Larry Finger <Larry.Finger@lwfinger.net>,
 Stefan Lippers-Hollmann <s.l-h@gmx.de>,
 Christian Hewitt <chewitt@libreelec.tv>
References: <91d932b3-5c72-4416-920e-f2bf4fc9b039@gmail.com>
Content-Language: en-US
In-Reply-To: <91d932b3-5c72-4416-920e-f2bf4fc9b039@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

fw.c contains a function for loading the firmware.
led.c contains a function for controlling the LED.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
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
 .../wireless/realtek/rtlwifi/rtl8192du/fw.c   | 65 +++++++++++++++++++
 .../wireless/realtek/rtlwifi/rtl8192du/fw.h   |  9 +++
 .../wireless/realtek/rtlwifi/rtl8192du/led.c  | 10 +++
 .../wireless/realtek/rtlwifi/rtl8192du/led.h  |  9 +++
 4 files changed, 93 insertions(+)
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192du/fw.c
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192du/fw.h
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192du/led.c
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192du/led.h

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192du/fw.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192du/fw.c
new file mode 100644
index 000000000000..21219e514ee5
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192du/fw.c
@@ -0,0 +1,65 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright(c) 2009-2012  Realtek Corporation.*/
+
+#include "../wifi.h"
+#include "../base.h"
+#include "../efuse.h"
+#include "../rtl8192d/reg.h"
+#include "../rtl8192d/def.h"
+#include "../rtl8192d/fw_common.h"
+#include "fw.h"
+
+int rtl92d_download_fw(struct ieee80211_hw *hw)
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
index 000000000000..2c835f3b4e92
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192du/fw.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright(c) 2009-2012  Realtek Corporation.*/
+
+#ifndef __RTL92DU_FW_H__
+#define __RTL92DU_FW_H__
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
index 000000000000..2f0c1329f05f
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192du/led.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright(c) 2009-2012  Realtek Corporation.*/
+
+#ifndef __RTL92DU_LED_H__
+#define __RTL92DU_LED_H__
+
+void rtl92de_led_control(struct ieee80211_hw *hw, enum led_ctl_mode ledaction);
+
+#endif
-- 
2.44.0



