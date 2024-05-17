Return-Path: <linux-wireless+bounces-7808-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE0778C8D9E
	for <lists+linux-wireless@lfdr.de>; Fri, 17 May 2024 23:18:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71BDA281117
	for <lists+linux-wireless@lfdr.de>; Fri, 17 May 2024 21:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7D8E38DE0;
	Fri, 17 May 2024 21:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ss6QwWjP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34192208F
	for <linux-wireless@vger.kernel.org>; Fri, 17 May 2024 21:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715980683; cv=none; b=VeyQu6ImXtRt6XSmyyUcLzL5jsKlms/2L0P1Qrck8eyBZ3WNsdNb/KMEkalBZ4A1U7g10pLg7u7Dq+kXyFk8jmbmQl8QlUe5kFZV0FFQIkrykYWGK8lT2VE+/+mD6Cim13+BYKNDchiFiaRt/0VW4W1n+FlSaFsZZZnqvI+Ilkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715980683; c=relaxed/simple;
	bh=olvHBlcyOM+/DxVs0BiCoRO1aZa6S2qc4LQIwcQoLZc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=QxOrJd3tMUAIAMSIddW45IwraxQn99gTHaQdxoe5MglfX20Z7qYrk6zueTwZ2AhFrUtwvoGqetxrhtQi/p0TWqBYBYZ2gX7R72mRmWekQQCTIgCxQshJkyzeAtLyxFdL0Oe7izu7GzSR11VtNYd0Pb8mtbb7l4u7N2yoBxCfnBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ss6QwWjP; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-42011507a57so5509805e9.1
        for <linux-wireless@vger.kernel.org>; Fri, 17 May 2024 14:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715980680; x=1716585480; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TnIzkVYf6P8d0PVIuUfBmHKnC+XqarH8JJbVT95MCtg=;
        b=Ss6QwWjPS1sFkZrc2QnD7N2ArdU28md+VyOmW5gYkDoDnDaT+XuGfv+DxJTg/ydUIl
         v56gpR0Hfws47YrEL8ht8XhZC95qxcXwYwS9rL1ZChlmGj/+zPpiLYNnJrIDebeg5OTe
         vDLn+w3IYZmFDa2gWxZksv5wH//d56i+vEIiPpeq5yj2fDWvvCqB0XjTHdzmH75v3JNd
         n+NnhPg+ur5UOY5sjaHiJgN9Sjhb2eKkTAuXjgTHBOVm1ST2uhQwaXr9a5vrF1iIt6Fb
         h207tYjsPzqAM4Z6gGoQi2W9LTTVpFliEYQHQBOI9LCfJ94Euop4hNJNE6LX1C7jcDNo
         4V1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715980680; x=1716585480;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TnIzkVYf6P8d0PVIuUfBmHKnC+XqarH8JJbVT95MCtg=;
        b=Bg8KlycUzweSpbxDXt6JFa1kpEd6BqG7/7VwXUK4XuncDTcnAkUARrpOfcZt10jK7W
         hsSmxLAu1R4LX2ldfuaHekeU/d7v8+lP9jgmfvXKB8unZyiS86XPciVlyUMCldzh/FUj
         78YwlnlkJjHZ6ZsTl2NTXRxP2lR6pjGKsWTPRi1y3h/k8ZXM2wssPJ8ovW7VsENRHtRs
         WvKtBLcIvOlF1ybXUGCd+NsU2dJRpFcqykk8uLqVpGj4gTaf9ZE7G7G9YYS2+cJ1Jnvt
         wXgTXuYwSyqPr+Myp0XZ+HMrA26ZX2JKrsfx0rMnlrVJKSBkINL7oQkGrAPQJ6i4ZbqL
         kZsQ==
X-Gm-Message-State: AOJu0YxdpDu4k9393bCULz9uNi2vyHKfW2aL7a05qCF676oYWQR8z68B
	sogHD6iORgo+9rrC8AxqgcoEVUP64twuMZbeaSXqXfnFfDWcY638QFa8IF4N
X-Google-Smtp-Source: AGHT+IGfqX1ImTIh+f/OF4A+EpxiUC/XJbSPKG7OWpgfAgQd9bTnU4YVxafn4bfPFaG3MDMmxpmORw==
X-Received: by 2002:a05:600c:5250:b0:420:1670:d606 with SMTP id 5b1f17b1804b1-4201670d93amr122537235e9.16.1715980680165;
        Fri, 17 May 2024 14:18:00 -0700 (PDT)
Received: from [192.168.1.50] ([79.113.154.240])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502bbbbfecsm22380764f8f.105.2024.05.17.14.17.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 May 2024 14:17:59 -0700 (PDT)
Message-ID: <eda95e7a-6ce5-4fb8-bf00-fc2e443d4104@gmail.com>
Date: Sat, 18 May 2024 00:17:59 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v6 06/11] wifi: rtlwifi: Add rtl8192du/rf.{c,h}
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

These contain one RF configuration function and some functions related
to dual MAC operation.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v6:
 - Update copyright year.
 - Remove some unused includes.
 - Make all functions use the prefix "rtl92du".

v5:
 - No change.

v4:
 - Fix rf.h header guard.
 - Fix comment style.
 - Delete unnecessary label and goto.
 - Add empty lines.

v3:
 - No change.

v2:
 - Patch is new in v2, split from patch 3/3 in v1.
---
 .../wireless/realtek/rtlwifi/rtl8192du/rf.c   | 240 ++++++++++++++++++
 .../wireless/realtek/rtlwifi/rtl8192du/rf.h   |  11 +
 2 files changed, 251 insertions(+)
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192du/rf.c
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192du/rf.h

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192du/rf.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192du/rf.c
new file mode 100644
index 000000000000..044dd65eafd0
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192du/rf.c
@@ -0,0 +1,240 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright(c) 2024  Realtek Corporation.*/
+
+#include "../wifi.h"
+#include "../rtl8192d/reg.h"
+#include "../rtl8192d/phy_common.h"
+#include "phy.h"
+#include "rf.h"
+
+bool rtl92du_phy_enable_anotherphy(struct ieee80211_hw *hw, bool bmac0)
+{
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	struct rtl_hal *rtlhal = &rtlpriv->rtlhal;
+	u8 mac_on_bit = bmac0 ? MAC1_ON : MAC0_ON;
+	u8 mac_reg = bmac0 ? REG_MAC1 : REG_MAC0;
+	bool bresult = true; /* true: need to enable BB/RF power */
+	u32 maskforphyset = 0;
+	u16 val16;
+	u8 u1btmp;
+
+	rtlhal->during_mac0init_radiob = false;
+	rtlhal->during_mac1init_radioa = false;
+	rtl_dbg(rtlpriv, COMP_RF, DBG_LOUD, "===>\n");
+
+	/* MAC0 Need PHY1 load radio_b.txt . Driver use DBI to write. */
+	u1btmp = rtl_read_byte(rtlpriv, mac_reg);
+	if (!(u1btmp & mac_on_bit)) {
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD, "enable BB & RF\n");
+		/* Enable BB and RF power */
+
+		maskforphyset = bmac0 ? MAC0_ACCESS_PHY1 : MAC1_ACCESS_PHY0;
+
+		val16 = rtl_read_word(rtlpriv, REG_SYS_FUNC_EN | maskforphyset);
+		val16 &= 0xfffc;
+		rtl_write_word(rtlpriv, REG_SYS_FUNC_EN | maskforphyset, val16);
+
+		val16 = rtl_read_word(rtlpriv, REG_SYS_FUNC_EN | maskforphyset);
+		val16 |= BIT(13) | BIT(0) | BIT(1);
+		rtl_write_word(rtlpriv, REG_SYS_FUNC_EN | maskforphyset, val16);
+	} else {
+		/* We think if MAC1 is ON,then radio_a.txt
+		 * and radio_b.txt has been load.
+		 */
+		bresult = false;
+	}
+	rtl_dbg(rtlpriv, COMP_RF, DBG_LOUD, "<===\n");
+	return bresult;
+}
+
+void rtl92du_phy_powerdown_anotherphy(struct ieee80211_hw *hw, bool bmac0)
+{
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	struct rtl_hal *rtlhal = &rtlpriv->rtlhal;
+	u8 mac_on_bit = bmac0 ? MAC1_ON : MAC0_ON;
+	u8 mac_reg = bmac0 ? REG_MAC1 : REG_MAC0;
+	u32 maskforphyset = 0;
+	u8 u1btmp;
+
+	rtlhal->during_mac0init_radiob = false;
+	rtlhal->during_mac1init_radioa = false;
+	rtl_dbg(rtlpriv, COMP_RF, DBG_LOUD, "====>\n");
+
+	/* check MAC0 enable or not again now, if
+	 * enabled, not power down radio A.
+	 */
+	u1btmp = rtl_read_byte(rtlpriv, mac_reg);
+	if (!(u1btmp & mac_on_bit)) {
+		rtl_dbg(rtlpriv, COMP_INIT, DBG_LOUD, "power down\n");
+		/* power down RF radio A according to YuNan's advice. */
+		maskforphyset = bmac0 ? MAC0_ACCESS_PHY1 : MAC1_ACCESS_PHY0;
+		rtl_write_dword(rtlpriv, RFPGA0_XA_LSSIPARAMETER | maskforphyset,
+				0x00000000);
+	}
+	rtl_dbg(rtlpriv, COMP_RF, DBG_LOUD, "<====\n");
+}
+
+bool rtl92du_phy_rf6052_config(struct ieee80211_hw *hw)
+{
+	bool mac1_initradioa_first = false, mac0_initradiob_first = false;
+	bool need_pwrdown_radioa = false, need_pwrdown_radiob = false;
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	struct rtl_hal *rtlhal = &rtlpriv->rtlhal;
+	struct rtl_phy *rtlphy = &rtlpriv->phy;
+	struct bb_reg_def *pphyreg;
+	bool true_bpath = false;
+	bool rtstatus = true;
+	u32 u4_regvalue = 0;
+	u8 rfpath;
+
+	if (rtlphy->rf_type == RF_1T1R)
+		rtlphy->num_total_rfpath = 1;
+	else
+		rtlphy->num_total_rfpath = 2;
+
+	/* Single phy mode: use radio_a radio_b config path_A path_B
+	 * separately by MAC0, and MAC1 needn't configure RF;
+	 * Dual PHY mode: MAC0 use radio_a config 1st phy path_A,
+	 * MAC1 use radio_b config 2nd PHY path_A.
+	 * DMDP, MAC0 on G band, MAC1 on A band.
+	 */
+	if (rtlhal->macphymode == DUALMAC_DUALPHY) {
+		if (rtlhal->current_bandtype == BAND_ON_2_4G &&
+		    rtlhal->interfaceindex == 0) {
+			/* MAC0 needs PHY1 load radio_b.txt. */
+			if (rtl92du_phy_enable_anotherphy(hw, true)) {
+				rtlphy->num_total_rfpath = 2;
+				mac0_initradiob_first = true;
+			} else {
+				/* We think if MAC1 is ON,then radio_a.txt and
+				 * radio_b.txt has been load.
+				 */
+				return rtstatus;
+			}
+		} else if (rtlhal->current_bandtype == BAND_ON_5G &&
+			   rtlhal->interfaceindex == 1) {
+			/* MAC1 needs PHY0 load radio_a.txt. */
+			if (rtl92du_phy_enable_anotherphy(hw, false)) {
+				rtlphy->num_total_rfpath = 2;
+				mac1_initradioa_first = true;
+			} else {
+				/* We think if MAC0 is ON, then radio_a.txt and
+				 * radio_b.txt has been load.
+				 */
+				return rtstatus;
+			}
+		} else if (rtlhal->interfaceindex == 1) {
+			/* MAC0 enabled, only init radia B.   */
+			true_bpath = true;
+		}
+	}
+
+	for (rfpath = 0; rfpath < rtlphy->num_total_rfpath; rfpath++) {
+		/* Mac1 use PHY0 write */
+		if (mac1_initradioa_first) {
+			if (rfpath == RF90_PATH_A) {
+				rtlhal->during_mac1init_radioa = true;
+				need_pwrdown_radioa = true;
+			} else if (rfpath == RF90_PATH_B) {
+				rtlhal->during_mac1init_radioa = false;
+				mac1_initradioa_first = false;
+				rfpath = RF90_PATH_A;
+				true_bpath = true;
+				rtlphy->num_total_rfpath = 1;
+			}
+		} else if (mac0_initradiob_first) {
+			/* Mac0 use PHY1 write */
+			if (rfpath == RF90_PATH_A)
+				rtlhal->during_mac0init_radiob = false;
+			if (rfpath == RF90_PATH_B) {
+				rtlhal->during_mac0init_radiob = true;
+				mac0_initradiob_first = false;
+				need_pwrdown_radiob = true;
+				rfpath = RF90_PATH_A;
+				true_bpath = true;
+				rtlphy->num_total_rfpath = 1;
+			}
+		}
+
+		pphyreg = &rtlphy->phyreg_def[rfpath];
+
+		switch (rfpath) {
+		case RF90_PATH_A:
+		case RF90_PATH_C:
+			u4_regvalue = rtl_get_bbreg(hw, pphyreg->rfintfs,
+						    BRFSI_RFENV);
+			break;
+		case RF90_PATH_B:
+		case RF90_PATH_D:
+			u4_regvalue = rtl_get_bbreg(hw, pphyreg->rfintfs,
+						    BRFSI_RFENV << 16);
+			break;
+		}
+
+		rtl_set_bbreg(hw, pphyreg->rfintfe, BRFSI_RFENV << 16, 0x1);
+		udelay(1);
+		rtl_set_bbreg(hw, pphyreg->rfintfo, BRFSI_RFENV, 0x1);
+		udelay(1);
+
+		/* Set bit number of Address and Data for RF register */
+		rtl_set_bbreg(hw, pphyreg->rfhssi_para2,
+			      B3WIREADDRESSLENGTH, 0x0);
+		udelay(1);
+		rtl_set_bbreg(hw, pphyreg->rfhssi_para2, B3WIREDATALENGTH, 0x0);
+		udelay(1);
+
+		switch (rfpath) {
+		case RF90_PATH_A:
+			if (true_bpath)
+				rtstatus = rtl92du_phy_config_rf_with_headerfile(
+						hw, radiob_txt,
+						(enum radio_path)rfpath);
+			else
+				rtstatus = rtl92du_phy_config_rf_with_headerfile(
+						hw, radioa_txt,
+						(enum radio_path)rfpath);
+			break;
+		case RF90_PATH_B:
+			rtstatus =
+			    rtl92du_phy_config_rf_with_headerfile(hw, radiob_txt,
+						(enum radio_path)rfpath);
+			break;
+		case RF90_PATH_C:
+			break;
+		case RF90_PATH_D:
+			break;
+		}
+
+		switch (rfpath) {
+		case RF90_PATH_A:
+		case RF90_PATH_C:
+			rtl_set_bbreg(hw, pphyreg->rfintfs, BRFSI_RFENV,
+				      u4_regvalue);
+			break;
+		case RF90_PATH_B:
+		case RF90_PATH_D:
+			rtl_set_bbreg(hw, pphyreg->rfintfs, BRFSI_RFENV << 16,
+				      u4_regvalue);
+			break;
+		}
+
+		if (!rtstatus) {
+			rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE,
+				"Radio[%d] Fail!!\n", rfpath);
+			return rtstatus;
+		}
+	}
+
+	/* check MAC0 enable or not again, if enabled,
+	 * not power down radio A.
+	 * check MAC1 enable or not again, if enabled,
+	 * not power down radio B.
+	 */
+	if (need_pwrdown_radioa)
+		rtl92du_phy_powerdown_anotherphy(hw, false);
+	else if (need_pwrdown_radiob)
+		rtl92du_phy_powerdown_anotherphy(hw, true);
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE, "<---\n");
+
+	return rtstatus;
+}
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192du/rf.h b/drivers/net/wireless/realtek/rtlwifi/rtl8192du/rf.h
new file mode 100644
index 000000000000..4a92cbdd00c0
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192du/rf.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright(c) 2024  Realtek Corporation.*/
+
+#ifndef __RTL92DU_RF_H__
+#define __RTL92DU_RF_H__
+
+bool rtl92du_phy_rf6052_config(struct ieee80211_hw *hw);
+bool rtl92du_phy_enable_anotherphy(struct ieee80211_hw *hw, bool bmac0);
+void rtl92du_phy_powerdown_anotherphy(struct ieee80211_hw *hw, bool bmac0);
+
+#endif
-- 
2.44.0


