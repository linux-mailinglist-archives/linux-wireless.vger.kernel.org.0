Return-Path: <linux-wireless+bounces-8020-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 557618CD612
	for <lists+linux-wireless@lfdr.de>; Thu, 23 May 2024 16:47:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCD481F24589
	for <lists+linux-wireless@lfdr.de>; Thu, 23 May 2024 14:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C91441879;
	Thu, 23 May 2024 14:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aCfZdRUt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4A86FA8
	for <linux-wireless@vger.kernel.org>; Thu, 23 May 2024 14:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716475616; cv=none; b=cSaImEx/30tw7LmmpoEOBE60pUbm12A8TlNNnbGpQ1tWI6/sYNG6M9bJa8Y1tWZj1QfcAF5Xq3Y/FCCauqt06dqDM6EWEDxkSCU6BbAvsQEUb+nD2FR37vuRDmE8qD444z2XGQLBdTnTP/gFlcxqcDLPqRceEfHRJxLX9uS+PUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716475616; c=relaxed/simple;
	bh=hkxPImuZg9H66t65OUHS2o7qSRq9CvvHhdtEVnjZ6vM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=EcXCNvNHgAhnvp3xgeXD1DQmZAEjIfWRX9/uYHca/KQsq9k1IGDjO3UhLByTwuPyQrtJLjxYnjX1yn0zxVDl85/+4ho7hHKFmYxWkiuJM0j5QMbUqv6MRtHJFjyUzQe+2iOVvRml84FaCkAUZJGrmMzszal9YqNKeOTBa4VMGxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aCfZdRUt; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a5a5c930cf6so1156771966b.0
        for <linux-wireless@vger.kernel.org>; Thu, 23 May 2024 07:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716475613; x=1717080413; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qaW5KlW3+fi/0ZDj/+usHf4RuhRjl4joXqHqmIq2pW4=;
        b=aCfZdRUteEube1Xor425UjW1n08Pstik+q3Qr89mHAwWPw5LGmbNjHWC8UYPznLWPc
         12ifVt1YxWhd/5svPS0A7Aj3bvV92Bo2weT+P2K4h3UKnAD/D9IvyNJUlFpWcnwLNqcg
         smqQvcbPLW4Cpmz1s3E8cxjj5/07hsZHxnEGxakY+H3KYR8LdjAmf0bxaYLSDYJX8Ulh
         uNYihw55UIioZR/Du1T9MhqyuqvEubAYsQgCwLS2LvDBLSxR2PWrRTADuXaUB4BcwxNS
         r4mELecatJrtWeAQ1VvH5FUYNVV51hHxQ5t4IWhef24wpIpkVUjxmKLSsfGZKK3bRM4I
         GJag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716475613; x=1717080413;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qaW5KlW3+fi/0ZDj/+usHf4RuhRjl4joXqHqmIq2pW4=;
        b=qRwoJlRxPhXbj+odUz/q+8g1wZqSPIRMqKse23/8pO/nXI1l5x5LFho/RWksuKWzw7
         ksCiUgkNeX9CxV5c5O7B8iGIH9ef6wJu+pdis3aNmq4HuHhxXcBqc+2GxaU9kOhcwE26
         CypNGAjxOdY9uwqlgH4NcpPXorW/Fn4OIxQjPOrnk5wk7LCrTG1+h2kxpXNifLV2afVc
         1oyGd9yRxeJRZbtoiMFmCUzv/LoABIvM8wXb+JD66UYiSfe/8ip67jYQMABssyUVsUNj
         oOgzLQP6f7qh44btgHLM9evsCg0U6fmVEI2zu4XHfE8qxtt5WpdB68vEDOnCjuKtdrEg
         Od5w==
X-Gm-Message-State: AOJu0YzSarg35tcuoG6RwQyHgZyx/gIcHe8jjmdm0p0kL0RhS3ybeTA7
	0W6HhiEXH9Iy80OFSojgUBXwYoLna4XBVBfaDd1cZ/lNToM6oYmNGJXtNw==
X-Google-Smtp-Source: AGHT+IEg9agilv26+VzXMfqk43ITwUH2aR0hg42HrwKTakcqqBAZzJ3Wu9qt9/aDPp1oFiZAMrCEKQ==
X-Received: by 2002:a17:906:eb0a:b0:a62:1b4f:6018 with SMTP id a640c23a62f3a-a622816709fmr340108266b.54.1716475613056;
        Thu, 23 May 2024 07:46:53 -0700 (PDT)
Received: from [192.168.0.50] ([81.196.40.5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a1781d29fsm1931619266b.25.2024.05.23.07.46.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 May 2024 07:46:52 -0700 (PDT)
Message-ID: <36258d72-11fd-4f70-84c6-782972f706ed@gmail.com>
Date: Thu, 23 May 2024 17:46:51 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v7 07/12] wifi: rtlwifi: Add rtl8192du/rf.{c,h}
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

These contain one RF configuration function and some functions related
to dual MAC operation.

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
2.45.1


