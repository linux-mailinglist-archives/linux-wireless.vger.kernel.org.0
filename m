Return-Path: <linux-wireless+bounces-7334-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB5598BFB50
	for <lists+linux-wireless@lfdr.de>; Wed,  8 May 2024 12:51:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90F242839D2
	for <lists+linux-wireless@lfdr.de>; Wed,  8 May 2024 10:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB6AC7E588;
	Wed,  8 May 2024 10:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iulVFpl5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CCEC481C4
	for <linux-wireless@vger.kernel.org>; Wed,  8 May 2024 10:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715165488; cv=none; b=ZD7ORhvyTj07JFthxT9YCea0B6I/oZu6SJO34igdUMHIcd91ge5QmvHBCBzeAvMsm0+OfdHwPJVD6uXtjj/HXBIdVUM0d+ics4KFINV3PvOFjbXMM93vlRMEtthWc0tvOn7lohE4v1373d3yDrwIg5T9by4Hr8Hb+BdFh+PAnKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715165488; c=relaxed/simple;
	bh=pPrNmMEJhxK52zWTgmw9bYYyLA9AzR9m8UfXuIAxKyY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=NIkMW1iVIk9vC8XL9rwv6DfQITdpE9Wq2r8v959tFx/iu7gjae1cT8nAm6KRuiWCqwwoO7od9YTS2yveSWwwq55FdtPpQiGc4wP+D0RHfTO74uj/7PGZM5oRWXV4mu2e2HQxQjhZYX8zd3SpjI5p8SVr2PXrHHCA0EXCfjzC20k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iulVFpl5; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-41ebcf01013so4021955e9.0
        for <linux-wireless@vger.kernel.org>; Wed, 08 May 2024 03:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715165485; x=1715770285; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FspBGoJ8tYorEqZUds9bcHy/cOdpd06+DLxfazu6FWA=;
        b=iulVFpl5IinAoVDw96UT7W3qe/ADLBs1e0W1KJNDuKjCEOA10nawbeDL/cMV1+xEM2
         5NfYXqySc+7xKanJGhth4pES0ObsaWYLoY/H3x6ZhP5xbHatHB/w1w+PqpNxHzVpU7er
         MeKA0ZK+ZKf+JtnQ1hUcAuUpE9CKVNFrHrRJCajkVKrgqeB4mZysipJ3vr43vjeT7uTP
         0QVQnu6y7RKHmZu0dB3qSujWcgFMsvAEllqMhk2pCcEgggyn97CZ+d1czuKWzW7fwW6/
         fVr14FIbb7OEnlSDjIW10UAwArfJxNR/R6rfyrbXquRS//icBtzyWj+m7JeMfKfXulGU
         1sUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715165485; x=1715770285;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FspBGoJ8tYorEqZUds9bcHy/cOdpd06+DLxfazu6FWA=;
        b=opY6H9ykEL+vsvovI2juZKobbl33M2zrEMPaGEuvBfNrhgHLEoEr7c+H60YQ9VfnDP
         7aSrqm6wh+Sk6LP4sZUvk8rOanpnfZ/78lnhQbqeDBPklzIaELEnKAl2I3ZFzh03NiwZ
         DN+Y5wfSJcxWla30cZMqs0kG/glbP2ut1n8uHIm2oUB4+53uXDSNDt0praXMGmRz+xnS
         /GH7XL8zDsFaGjJGep9jEUp71/g2Bb3IXc7NHY8QBPZwWoVAqHCbs/qVWHCKshVIpKyC
         MDBLb2e5snp4LeuyJsCopO7tIlZ5DwvELbvJAYZHntP/cBFa2iekw7G4YWrsR63mOjXo
         BGog==
X-Gm-Message-State: AOJu0YwOx6ydXWwShKY9r/yPLQ7J9gEy7lBuQCnS9AgCljI2/4yKVgPF
	WgJ9AvGM4Bx/zoaqeEesvAkR3McKWu2gwE0Ws0KNPWRMb4lqGm+XNVTv6rvY
X-Google-Smtp-Source: AGHT+IFBqIVxslwSOoBMERkDts/5HD1IWM/mSzzSLP6/h3u5zpGwQYURxVsSC31/IlMajqHrhMi5yA==
X-Received: by 2002:a05:600c:1c8d:b0:41a:4623:7ee9 with SMTP id 5b1f17b1804b1-41f2d63b8e1mr48273165e9.10.1715165485304;
        Wed, 08 May 2024 03:51:25 -0700 (PDT)
Received: from [192.168.1.50] ([79.113.154.240])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41f882089cbsm18558635e9.48.2024.05.08.03.51.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 May 2024 03:51:25 -0700 (PDT)
Message-ID: <a52bb10b-d733-4923-8a88-efd4cbed7a9a@gmail.com>
Date: Wed, 8 May 2024 13:51:24 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v5 06/11] wifi: rtlwifi: Add rtl8192du/rf.{c,h}
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

These contain one RF configuration function and some functions related
to dual MAC operation.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
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


