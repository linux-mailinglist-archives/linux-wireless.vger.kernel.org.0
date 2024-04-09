Return-Path: <linux-wireless+bounces-6047-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A88289E407
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Apr 2024 21:58:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AFCF1C20B4B
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Apr 2024 19:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 961C115749A;
	Tue,  9 Apr 2024 19:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fRpTis9b"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8601515820D
	for <linux-wireless@vger.kernel.org>; Tue,  9 Apr 2024 19:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712692690; cv=none; b=PDb4qOc02G31A8UCsDojPs/LIZQal7TpnKoh+9Q/V1ltAtC+OXj2kIC0j/Was0QLjoaenxIo8aFP5j+zSUAH2fLllDf3uzVqhyReH6sv5U3E5CQ/ohtNr1FE3hrX+w4qWJe8TAInUjP8oUE4a7KDW7yxuIFGO+5YZWbkYf/YfZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712692690; c=relaxed/simple;
	bh=BiQCWXP29URpPIy1Leypn7l5XOh/UebVuNIRfOWkVZQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=YzNc7wP6J0A8mmTtObukBzlUbcaMuzZV6UKjdB7JI4YuP/6nnKigk5g/tDOtpOYAqu+JDDhYKtXvHL+5oDqciaY1Igyjekjw//0XeYzaLYmTtdIpv3m014GAUXE/QlvYPDQZqQExClaVPi2QitW9tlgRY51mTL/tzHCVb4/aBWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fRpTis9b; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a51aac16b6eso255268266b.1
        for <linux-wireless@vger.kernel.org>; Tue, 09 Apr 2024 12:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712692687; x=1713297487; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XADItTqh52y+04Wst2D1FiB+wLDeeMvVMdu6Lj814hQ=;
        b=fRpTis9bueMkk1sONWn9T3khB7G/73XaNW82UeBf0bZyfwcIC2ciEqoJV3Yg3Av6YX
         fsCOTtsbfxVzKhumjpcuqPNheo/EU+qtrp9wLoJZK8t/+HYZ2+ilD/haFrssphmMQqhs
         yGPKhjoFgVmBZ09EIKC65XNayFzNUz1yKW1+iVsnd4D9HD+RSM8rqAnHPT43+Qsrb43C
         4L5OJEg1LLbxL1yr+lvbOZUeJS1CVwbZUrG2Aat++MAdGrc/QkMelJ/qoemz98jI/QHD
         v+1TDSXHBV6xd5/50A8clBFw0GxLrDmSbTg28aEK8T0AQCCmq173Aq6oFhoxXbO58kmq
         MgyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712692687; x=1713297487;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XADItTqh52y+04Wst2D1FiB+wLDeeMvVMdu6Lj814hQ=;
        b=UZ9BwdhdqgNj3GuZAvsnfKttkz4jWbuR1l63cJ02j3T5Rc18o5oyvGfk/tb5QTJ1SO
         kps6fD43upLSyxxHQ7z+ibTCFxapRoIV3flVLvjEcDu8u+iAAEbJ+z+jk1NHEVL7lbg5
         bo7P6com2Lj7TY01nw/SOOU93VIvUyL02NvEkpgzEpDaVqB6xO9fl3LlpjidaIxOaREx
         1xyfzen9KNhQHiZ8UbB6xVQxG2+YaR88DUtWU3OVkcoFMrqLhlqVEjdCgpK2VCSmnr4M
         s0YapoqGi0RV1GGImHkCBY6aV2HLNmerXqaLHWS6SKnX9Afl31Mfp8vUvw5S2ZxDQziY
         ZeXw==
X-Gm-Message-State: AOJu0YzRHZqv3oszZT3R8lp2zta4MGwT3rZSwIZ2PBUIPLjtHFLIncAh
	suj0g+Oc6nj3bxTOHlXrfbTHLHNAYqjWPhVQHGZ9BveYZloukknfyPusdTiF4bU=
X-Google-Smtp-Source: AGHT+IET7Ef7ogIwGP1Vp3epOC+Gelv8vMUHvSfXbZregYtx5FWA26ExIBoQdhnjzpRx3tj6lHztng==
X-Received: by 2002:a50:871c:0:b0:56e:3088:49a with SMTP id i28-20020a50871c000000b0056e3088049amr456037edb.37.1712692686661;
        Tue, 09 Apr 2024 12:58:06 -0700 (PDT)
Received: from [192.168.1.50] ([79.113.154.240])
        by smtp.gmail.com with ESMTPSA id k11-20020a056402048b00b0056bc0c44f02sm271101edv.96.2024.04.09.12.58.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Apr 2024 12:58:06 -0700 (PDT)
Message-ID: <7addeb61-3590-4a43-9165-56920daa55b7@gmail.com>
Date: Tue, 9 Apr 2024 22:58:05 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v4 09/14] wifi: rtlwifi: Add rtl8192du/rf.{c,h}
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

These contain one RF configuration function and some functions related
to dual MAC operation.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
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
 .../wireless/realtek/rtlwifi/rtl8192du/rf.c   | 244 ++++++++++++++++++
 .../wireless/realtek/rtlwifi/rtl8192du/rf.h   |  11 +
 2 files changed, 255 insertions(+)
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192du/rf.c
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192du/rf.h

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192du/rf.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192du/rf.c
new file mode 100644
index 000000000000..0b151a7ac96f
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192du/rf.c
@@ -0,0 +1,244 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright(c) 2009-2012  Realtek Corporation.*/
+
+#include "../wifi.h"
+#include "../rtl8192d/reg.h"
+#include "../rtl8192d/def.h"
+#include "../rtl8192d/phy_common.h"
+#include "../rtl8192d/rf_common.h"
+#include "phy.h"
+#include "rf.h"
+#include "dm.h"
+#include "hw.h"
+
+bool rtl92d_phy_enable_anotherphy(struct ieee80211_hw *hw, bool bmac0)
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
+void rtl92d_phy_powerdown_anotherphy(struct ieee80211_hw *hw, bool bmac0)
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
+bool rtl92d_phy_rf6052_config(struct ieee80211_hw *hw)
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
+			if (rtl92d_phy_enable_anotherphy(hw, true)) {
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
+			if (rtl92d_phy_enable_anotherphy(hw, false)) {
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
+				rtstatus = rtl92d_phy_config_rf_with_headerfile(
+						hw, radiob_txt,
+						(enum radio_path)rfpath);
+			else
+				rtstatus = rtl92d_phy_config_rf_with_headerfile(
+						hw, radioa_txt,
+						(enum radio_path)rfpath);
+			break;
+		case RF90_PATH_B:
+			rtstatus =
+			    rtl92d_phy_config_rf_with_headerfile(hw, radiob_txt,
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
+		rtl92d_phy_powerdown_anotherphy(hw, false);
+	else if (need_pwrdown_radiob)
+		rtl92d_phy_powerdown_anotherphy(hw, true);
+	rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE, "<---\n");
+
+	return rtstatus;
+}
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192du/rf.h b/drivers/net/wireless/realtek/rtlwifi/rtl8192du/rf.h
new file mode 100644
index 000000000000..86bf15496483
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192du/rf.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright(c) 2009-2012  Realtek Corporation.*/
+
+#ifndef __RTL92DU_RF_H__
+#define __RTL92DU_RF_H__
+
+bool rtl92d_phy_rf6052_config(struct ieee80211_hw *hw);
+bool rtl92d_phy_enable_anotherphy(struct ieee80211_hw *hw, bool bmac0);
+void rtl92d_phy_powerdown_anotherphy(struct ieee80211_hw *hw, bool bmac0);
+
+#endif
-- 
2.44.0


