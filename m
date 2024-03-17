Return-Path: <linux-wireless+bounces-4815-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DECF987DF61
	for <lists+linux-wireless@lfdr.de>; Sun, 17 Mar 2024 19:52:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 579341F212D9
	for <lists+linux-wireless@lfdr.de>; Sun, 17 Mar 2024 18:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6C951D537;
	Sun, 17 Mar 2024 18:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TMvO0Ku9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99ECE1D531
	for <linux-wireless@vger.kernel.org>; Sun, 17 Mar 2024 18:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710701562; cv=none; b=FcYmfYnI42wtr5s+rsgzGMfRSh7W8edHOil37dSdjeBo7NpEiCT0TjkhDXVdQjYIGKfFKf3mMC4ygXj4udNysYrbaJjvTychQKzgeedxtrcQAyexu9L1HB92g78Q0epwrfYqnb1pt2XFxqjicM15M9ymBuCxmU4CiRe1wlkTpEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710701562; c=relaxed/simple;
	bh=i8UL8p6asAf2+o9nUZUTZgKmwZdovaSr9oT3Nzo6I7s=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=agTQLe0GGskFarFMRQ4lN68TX2iFOgN4oYAJNTvmC/rBDqLhzXro1xUYJEAWbdX1JflNA2f1DY9A3A84W+lMGU1JFvZ0PuPezmjjvN33xPm/uSLsoNmNYNI/V8i64EV1xLSb+Elpyn67CUfem4n3lCVZKQ9av6Bb0+ZcPstNlTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TMvO0Ku9; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5689ebef670so4249879a12.1
        for <linux-wireless@vger.kernel.org>; Sun, 17 Mar 2024 11:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710701559; x=1711306359; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l8q5LANYg0Ykfp7CPis3GdzC9irNYX/vcAQUwG+jpzo=;
        b=TMvO0Ku9TYqfPjmo+g4GqeBKQ6sROtH2Uxlu4/acqspeU7Log/J2bYX+yNqCNetVKI
         rb8Sf3ZhT+x1zuo7xflfrfa9p8priYfTXYWUSIJD5Jg4Jp63sREWL1XlYhmt4uzt9XsI
         l+lrkXviJNVk1KlDc943RqyIvACztbqqUj4tVcLLEubuNOnenswsNCNJWN2mBfwpf/PT
         TreFOvFO+a1RBo36XrW/SEkr1w/oA1Y3Lq33tjpAc+t/nvwnWSwbxuLsEcWKHNXL2tZK
         CCHCe3Oiv9cx9P5SdZF5OqzF9Q1yHMhtW9gHqhVBrsRg6sukUyaP65ylUh7ViydYdJsd
         u5Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710701559; x=1711306359;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l8q5LANYg0Ykfp7CPis3GdzC9irNYX/vcAQUwG+jpzo=;
        b=e9PGg09aa55lqfvCdifZK7bezk9qO/yzwY0584qKFVHZhRNHvo58k6khpJVsnBA4xb
         kdB9qWYpgNqfb3SjkfLSYgyv/L9Y4Ms5rosPYP4luFH8iEfoybEr3d9CgnGlQRXoiZry
         QEUBc7svsOdONDWHQ8O+L+Z+72cvsvgE7woYYvMWwDebKoqCdvwIEPcPrQz1/UC1LlYs
         KfbIhtQVai0M1jCwtSh8A/rw8ErY0Nlwk3B9fsISEP1+LPJw3+lFp4rWZgb8Rj3g589B
         ODcCnv2y7vwiINrd4/9CLMlHFmCYOeWBbCQvVmwuFJbr7I7HPZzfzEGLnow9l7nlsykw
         i3Mw==
X-Gm-Message-State: AOJu0YztRHGl45MARHtq1rvttUWUtlXwtav0AKdGMOSZ/7qDmV7qf9YQ
	syRifHICmVjeY/ifVatFdwoWlTAW3LU1i3sELTMy9qtTLrllOgguoVye7D+z
X-Google-Smtp-Source: AGHT+IHVtDv0To2JGdiJnC2LNWhJ1FgigRjkXZPVY0/2F83hi1VNlgTVW1ITk2pDnHXmu6c2nxKzpQ==
X-Received: by 2002:a17:906:2ac8:b0:a46:bbe6:f234 with SMTP id m8-20020a1709062ac800b00a46bbe6f234mr888521eje.58.1710701558802;
        Sun, 17 Mar 2024 11:52:38 -0700 (PDT)
Received: from [192.168.1.50] ([79.119.240.211])
        by smtp.gmail.com with ESMTPSA id qs28-20020a170906459c00b00a4550e8ae70sm4032071ejc.63.2024.03.17.11.52.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Mar 2024 11:52:38 -0700 (PDT)
Message-ID: <1bd5aa8f-0c59-40c9-9ae6-1a8df9f08aea@gmail.com>
Date: Sun, 17 Mar 2024 20:52:37 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 08/12] wifi: rtlwifi: Add rtl8192du/rf.{c,h}
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

These contain one RF configuration function and some functions related
to dual MAC operation.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
Patch is new in v2, split from patch 3/3 in v1.
---
 .../wireless/realtek/rtlwifi/rtl8192du/rf.c   | 236 ++++++++++++++++++
 .../wireless/realtek/rtlwifi/rtl8192du/rf.h   |  11 +
 2 files changed, 247 insertions(+)
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192du/rf.c
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192du/rf.h

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192du/rf.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192du/rf.c
new file mode 100644
index 000000000000..afdf03940015
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192du/rf.c
@@ -0,0 +1,236 @@
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
+	/* Single phy mode: use radio_a radio_b config path_A path_B */
+	/* separately by MAC0, and MAC1 needn't configure RF; */
+	/* Dual PHY mode:MAC0 use radio_a config 1st phy path_A, */
+	/* MAC1 use radio_b config 2nd PHY path_A. */
+	/* DMDP,MAC0 on G band,MAC1 on A band. */
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
+		pphyreg = &rtlphy->phyreg_def[rfpath];
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
+		rtl_set_bbreg(hw, pphyreg->rfintfe, BRFSI_RFENV << 16, 0x1);
+		udelay(1);
+		rtl_set_bbreg(hw, pphyreg->rfintfo, BRFSI_RFENV, 0x1);
+		udelay(1);
+		/* Set bit number of Address and Data for RF register */
+		rtl_set_bbreg(hw, pphyreg->rfhssi_para2,
+			      B3WIREADDRESSLENGTH, 0x0);
+		udelay(1);
+		rtl_set_bbreg(hw, pphyreg->rfhssi_para2, B3WIREDATALENGTH, 0x0);
+		udelay(1);
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
+		if (!rtstatus) {
+			rtl_dbg(rtlpriv, COMP_INIT, DBG_TRACE,
+				"Radio[%d] Fail!!\n", rfpath);
+			goto phy_rf_cfg_fail;
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
+	return rtstatus;
+
+phy_rf_cfg_fail:
+	return rtstatus;
+}
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192du/rf.h b/drivers/net/wireless/realtek/rtlwifi/rtl8192du/rf.h
new file mode 100644
index 000000000000..c097d90cc99c
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192du/rf.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright(c) 2009-2012  Realtek Corporation.*/
+
+#ifndef __RTL92D_RF_H__
+#define __RTL92D_RF_H__
+
+bool rtl92d_phy_rf6052_config(struct ieee80211_hw *hw);
+bool rtl92d_phy_enable_anotherphy(struct ieee80211_hw *hw, bool bmac0);
+void rtl92d_phy_powerdown_anotherphy(struct ieee80211_hw *hw, bool bmac0);
+
+#endif
-- 
2.43.2

