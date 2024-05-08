Return-Path: <linux-wireless+bounces-7335-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FFD58BFB51
	for <lists+linux-wireless@lfdr.de>; Wed,  8 May 2024 12:52:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA07F1F2317D
	for <lists+linux-wireless@lfdr.de>; Wed,  8 May 2024 10:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C2FB481C4;
	Wed,  8 May 2024 10:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a4zY4C8s"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708727EF1E
	for <linux-wireless@vger.kernel.org>; Wed,  8 May 2024 10:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715165532; cv=none; b=ukAcmtZpfp6ci2Jl0yf0AnPhkseaRechjomST6FR24Dkd2KOmsF/z/EUKICC795N6hJbSCSQGAdJ1veHoaAFd4CCX9F4oKNpQi58eM4vG1nTv3ze4GYRMYq0eKHPjdySadmhEEsbQOvy8Ye/ZyRGio6neJde3V7dxneBsLnhfgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715165532; c=relaxed/simple;
	bh=cfqgfj12V12r1yyXP2U9dDfEaASCkL05pNpCcAhNoPY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=mIs9kLC21lySvC+VkvYWOSae0+50UUKBTDnDt2aNTmWxGLo84dt0bwa0RfYjGubQ74dRjMBTfekejvRI+6nH/wZeLIaOQqISpOeiWz/2Yopfqri5R9MWIb1eBcOZESZ37Sfdi79TwqGOuHLs7k0HTapOZq43hK9JcB7KXwPM4CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a4zY4C8s; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-41b5e74fa2fso33113155e9.1
        for <linux-wireless@vger.kernel.org>; Wed, 08 May 2024 03:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715165529; x=1715770329; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rUOi+pTGKCDycgfpVJRR16Kd/9WHh1OF44UtsrVzqws=;
        b=a4zY4C8svUTGrfVkrK6+2pYvzfGcy3SGkyW/f/o7uFG1WuzzT63bAwOuPZ/lLXpfLL
         Eir48mmXRvG8LfjI9daOD7vXc+AOLC6AHzK3FY179KrFcC2Z05nAm7UrOjenQmctGbDX
         CmAO5rWOqwE7kmPQp12clav1WlMF5jHA0SAXHzFGSMKSoCV19QoKX7wauF3mVVucAyV1
         DhrPbcI53Yy5mPtghX2op01i5lq65tY23VzGc1eTcd0xXqP0CO8C79tFO3uUhlxAwrIm
         iu4DHNd6uQbdJmpho/I85UQZtgTfqfs/R7eJXAJjrjRls9UMBc1t6bnPt3Xni7sPGquz
         qFFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715165529; x=1715770329;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rUOi+pTGKCDycgfpVJRR16Kd/9WHh1OF44UtsrVzqws=;
        b=G7btFQmAkOhIC2I41OXI4J3pWowdKJWix9k6RcXgtGBJElDH9kuDhOFXQwZepG6bV4
         mvHRHxqr1mcggzBJDtLwNfhGyDOSET6y42nzMG+gONHJrBdjJUiCspH8JTVVPwa+ky8B
         fK1j+3rkhtpyxJRDZhi3WbTM3DQTwhOVfYC1HysRKvJfvJ5SamB9XWBz3V57UfCthXVR
         nbK5b1GVUCY26fPVLPJfbaVTTbwUQ+0uNYmkH5707kVo1WTRbX0i6hn4nvx28GzX9kMs
         FiQSaDkg1/dWxhFThogt3CsGFFgeMoJrK+XsTwzt1LmXV/RmPwAC/SGeYfnT1lqRlkOu
         ESWA==
X-Gm-Message-State: AOJu0Yy0fUXn1HmldHBLfXzxweoZKeFu8J88WZAJMygsiRNBnSi6TGTk
	doTKKobLBAnfgFYsx8XN8Lu12RjOQqpW6QZ8dE3kpOTHMaEQh+7V0tvs5RKw
X-Google-Smtp-Source: AGHT+IEtw1oztXuRMmcufjvRviNb3TJKw1DpDrCMNgnz6Fgi+oIbvXEXTnYB9T7u53h8ZSIW9RlFkg==
X-Received: by 2002:a05:600c:a42:b0:419:678e:64ce with SMTP id 5b1f17b1804b1-41f721acc41mr16692215e9.36.1715165528743;
        Wed, 08 May 2024 03:52:08 -0700 (PDT)
Received: from [192.168.1.50] ([79.113.154.240])
        by smtp.gmail.com with ESMTPSA id j3-20020a056000124300b0034de3098980sm15076219wrx.97.2024.05.08.03.52.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 May 2024 03:52:08 -0700 (PDT)
Message-ID: <1868127e-1dcc-4a2f-95aa-a9ef1aad8f3a@gmail.com>
Date: Wed, 8 May 2024 13:52:07 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v5 07/11] wifi: rtlwifi: Add rtl8192du/fw.{c,h} and
 rtl8192du/led.{c,h}
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>,
 Larry Finger <Larry.Finger@lwfinger.net>,
 Stefan Lippers-Hollmann <s.l-h@gmx.de>,
 Christian Hewitt <chewitt@libreelec.tv>
References: <254558da-ea8b-40ea-bd5a-83d13796744f@gmail.com>
Content-Language: en-US
In-Reply-To: <254558da-ea8b-40ea-bd5a-83d13796744f@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

fw.c contains a function for loading the firmware.
led.c contains a function for controlling the LED.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
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


