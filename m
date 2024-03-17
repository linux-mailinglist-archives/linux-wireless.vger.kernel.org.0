Return-Path: <linux-wireless+bounces-4817-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 065D487DF66
	for <lists+linux-wireless@lfdr.de>; Sun, 17 Mar 2024 19:55:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26F471C20833
	for <lists+linux-wireless@lfdr.de>; Sun, 17 Mar 2024 18:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FB121CF9B;
	Sun, 17 Mar 2024 18:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XACdFu1X"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B701CF80
	for <linux-wireless@vger.kernel.org>; Sun, 17 Mar 2024 18:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710701699; cv=none; b=GrBMaqyBX8HGemNVwfLz8Vh9keIv2ciAKT4dwkApr94O35nzp8XdzKf5b19Tz1EmKru1LVGfZpGYwJy7y+Ehz9m7EDV7CQekYy7DwBlto2PtCJuJLanLnv8+nJxXkOTAP3Abb8o3ySpkqL58N5Fg87IlLRWln+vU4gRB1oDrRg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710701699; c=relaxed/simple;
	bh=LAGKUXfttvjUOMgDhxAb1mbNc8S/Q/vlCIMD6KusezE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ja3uVRdi/8yTHolfzqycqwikCXRHn4b78/7CF2fsAT60+xPwpmNsJymRfqR6JsrDjsNMUTafxd7Mr7c0Axn5k7xBdYa2le20qxXBTPFL4NnffRmm+iiqUpFgSW5Nf/g0TGGRY7f2yn23xTLS58906M4u2c/dSFWLDM3jjhwnPkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XACdFu1X; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a2f22bfb4e6so494765666b.0
        for <linux-wireless@vger.kernel.org>; Sun, 17 Mar 2024 11:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710701695; x=1711306495; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kGPa57JvUE7lWy6scFY1lRTTwdluqq2NbRXWdX1mJo8=;
        b=XACdFu1XbN0bW2qhmDWtppKTXq+QfGL6UvtzpZM+GmLAhDefvx7UeHtXb5y85OPgea
         bAz6CZ5e1hRhh6iLWuLr6rqZpcgagbiQApPzXafSKCJ0+xytF7rUPwZscT0fh0+3CaBg
         /OXWDZ0TWwBNqTOGlXsFQZjaB76K9P73dVMRvLw1V7MaU+1SegUHLesifiPKWc7EsWyp
         mf8B8gE1IkjbMLDxeJ7eNGiGUqUWjjGDZz9o51vMwvTeNSJ+Cf0YV3VO5V2rkgGd5gF3
         EpnP7AxlGkBH0n71ij73ce9K1hJuTQsuKfm9lZWjfgfUk1ISiKnno/xjAMJOxk62XtHP
         wBcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710701695; x=1711306495;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kGPa57JvUE7lWy6scFY1lRTTwdluqq2NbRXWdX1mJo8=;
        b=SfCMPulIBwIK4ZNiujD5xaytgHwJ4zMTu8OjCDFxWEcCEslHAbkmU/F2WdH9mzKun9
         gdLNQZV41EsK8wBeRALHOhU9fInjs4XqXRMN7OmPfKON+hsfucrvp77jMIQAR5ry7LI+
         H5fxXMq4zTwZRaNTeJvMXZGq65m3fl6st/Hq12TnUbUPX/aMSunjJxeNPQY4KxeT89Fz
         2FS1VFCNeA+RKVGIaa0ToJR3Udw8yST/DVcpvJ/Hi4Ra4GotNpIy5s36LqkaBXNz/hax
         yEcD/yLTsoB9g44yBxbmP+WIfLGg5Le5gfnd9Dxan0i0v78qjV/XBZHLIF9T/80Vv/PW
         wd7Q==
X-Gm-Message-State: AOJu0YwoXA1hbyUDqe5q2BxNHWX6DrH+zGdZvjbTVgUK784wIpEio2V9
	X7NVgX3UbNl4eOb4+Uq8hSxt0hl5ZFX0HN91Ko6LvBVGoHqij2kHlQ26IqZ9
X-Google-Smtp-Source: AGHT+IFrTS8qA5Ghz8e/XEItDOYUwaZiblvdhROA1iUVbF5LuGAmJIlFNFRhbECbWSWD9eW56wHoow==
X-Received: by 2002:a17:906:710e:b0:a46:2b87:9f38 with SMTP id x14-20020a170906710e00b00a462b879f38mr5811110ejj.29.1710701695476;
        Sun, 17 Mar 2024 11:54:55 -0700 (PDT)
Received: from [192.168.1.50] ([79.119.240.211])
        by smtp.gmail.com with ESMTPSA id qs28-20020a170906459c00b00a4550e8ae70sm4032071ejc.63.2024.03.17.11.54.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Mar 2024 11:54:55 -0700 (PDT)
Message-ID: <15b4aa69-460a-4bcd-a986-08a4e48ae26a@gmail.com>
Date: Sun, 17 Mar 2024 20:54:54 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 10/12] wifi: rtlwifi: Add rtl8192du/dm.{c,h}
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

These contain functions related to the dynamic mechanism, which runs
every two seconds to adjust to changes in the environment.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
Patch is new in v2, split from patch 3/3 in v1.
---
 .../wireless/realtek/rtlwifi/rtl8192du/dm.c   | 125 ++++++++++++++++++
 .../wireless/realtek/rtlwifi/rtl8192du/dm.h   |  10 ++
 2 files changed, 135 insertions(+)
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192du/dm.c
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192du/dm.h

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192du/dm.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192du/dm.c
new file mode 100644
index 000000000000..aa7032e0f71a
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192du/dm.c
@@ -0,0 +1,125 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright(c) 2009-2012  Realtek Corporation.*/
+
+#include "../wifi.h"
+#include "../base.h"
+#include "../core.h"
+#include "../rtl8192d/reg.h"
+#include "../rtl8192d/def.h"
+#include "../rtl8192d/dm_common.h"
+#include "../rtl8192d/fw_common.h"
+#include "../rtl8192d/phy_common.h"
+#include "phy.h"
+#include "dm.h"
+#include "fw.h"
+
+#define UNDEC_SM_PWDB	entry_min_undec_sm_pwdb
+
+static void rtl92d_dm_init_1r_cca(struct ieee80211_hw *hw)
+{
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	struct ps_t *dm_pstable = &rtlpriv->dm_pstable;
+
+	dm_pstable->pre_ccastate = CCA_MAX;
+	dm_pstable->cur_ccasate = CCA_MAX;
+}
+
+static void rtl92d_dm_1r_cca(struct ieee80211_hw *hw)
+{
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	struct ps_t *dm_pstable = &rtlpriv->dm_pstable;
+	struct rtl_hal *rtlhal = rtl_hal(rtlpriv);
+	int pwdb = rtlpriv->dm_digtable.min_undec_pwdb_for_dm;
+
+	if (rtlhal->macphymode != SINGLEMAC_SINGLEPHY ||
+	    rtlhal->current_bandtype != BAND_ON_5G)
+		return;
+
+	if (pwdb != 0) {
+		if (dm_pstable->pre_ccastate == CCA_2R ||
+		    dm_pstable->pre_ccastate == CCA_MAX)
+			dm_pstable->cur_ccasate = (pwdb >= 35) ? CCA_1R : CCA_2R;
+		else
+			dm_pstable->cur_ccasate = (pwdb <= 30) ? CCA_2R : CCA_1R;
+	} else {
+		dm_pstable->cur_ccasate = CCA_MAX;
+	}
+
+	if (dm_pstable->pre_ccastate == dm_pstable->cur_ccasate)
+		return;
+
+	rtl_dbg(rtlpriv, COMP_BB_POWERSAVING, DBG_TRACE,
+		"Old CCA state: %d new CCA state: %d\n",
+		dm_pstable->pre_ccastate, dm_pstable->cur_ccasate);
+
+	if (dm_pstable->cur_ccasate == CCA_1R) {
+		if (rtlpriv->phy.rf_type == RF_2T2R)
+			rtl_set_bbreg(hw, ROFDM0_TRXPATHENABLE, MASKBYTE0, 0x13);
+		else /* Is this branch reachable? */
+			rtl_set_bbreg(hw, ROFDM0_TRXPATHENABLE, MASKBYTE0, 0x23);
+	} else { /* CCA_2R or CCA_MAX */
+		rtl_set_bbreg(hw, ROFDM0_TRXPATHENABLE, MASKBYTE0, 0x33);
+	}
+}
+
+static void rtl92d_dm_pwdb_monitor(struct ieee80211_hw *hw)
+{
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	const u32 max_macid = 32;
+	u32 temp;
+
+	/* AP & ADHOC & MESH will return tmp */
+	if (rtlpriv->mac80211.opmode != NL80211_IFTYPE_STATION)
+		return;
+
+	/* Indicate Rx signal strength to FW. */
+	if (rtlpriv->dm.useramask) {
+		temp = rtlpriv->dm.undec_sm_pwdb << 16;
+		temp |= max_macid << 8;
+
+		rtl92d_fill_h2c_cmd(hw, H2C_RSSI_REPORT, 3, (u8 *)(&temp));
+	} else {
+		rtl_write_byte(rtlpriv, 0x4fe, (u8)rtlpriv->dm.undec_sm_pwdb);
+	}
+}
+
+void rtl92du_dm_init(struct ieee80211_hw *hw)
+{
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+
+	rtlpriv->dm.dm_type = DM_TYPE_BYDRIVER;
+	rtl_dm_diginit(hw, 0x20);
+	rtlpriv->dm_digtable.rx_gain_max = DM_DIG_FA_UPPER;
+	rtlpriv->dm_digtable.rx_gain_min = DM_DIG_FA_LOWER;
+	rtl92d_dm_init_edca_turbo(hw);
+	rtl92d_dm_init_1r_cca(hw);
+	rtl92d_dm_init_rate_adaptive_mask(hw);
+	rtl92d_dm_initialize_txpower_tracking(hw);
+}
+
+void rtl92du_dm_watchdog(struct ieee80211_hw *hw)
+{
+	struct rtl_ps_ctl *ppsc = rtl_psc(rtl_priv(hw));
+	bool fw_current_inpsmode = false;
+	bool fwps_awake = true;
+
+	/* 1. RF is OFF. (No need to do DM.)
+	 * 2. Fw is under power saving mode for FwLPS.
+	 *    (Prevent from SW/FW I/O racing.)
+	 * 3. IPS workitem is scheduled. (Prevent from IPS sequence
+	 *    to be swapped with DM.
+	 * 4. RFChangeInProgress is TRUE.
+	 *    (Prevent from broken by IPS/HW/SW Rf off.)
+	 */
+
+	if (ppsc->rfpwr_state == ERFON && !fw_current_inpsmode &&
+	    fwps_awake && !ppsc->rfchange_inprogress) {
+		rtl92d_dm_pwdb_monitor(hw);
+		rtl92d_dm_false_alarm_counter_statistics(hw);
+		rtl92d_dm_find_minimum_rssi(hw);
+		rtl92d_dm_dig(hw);
+		rtl92d_dm_check_txpower_tracking_thermal_meter(hw);
+		rtl92d_dm_check_edca_turbo(hw);
+		rtl92d_dm_1r_cca(hw);
+	}
+}
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192du/dm.h b/drivers/net/wireless/realtek/rtlwifi/rtl8192du/dm.h
new file mode 100644
index 000000000000..d036cf722384
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192du/dm.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright(c) 2009-2012  Realtek Corporation.*/
+
+#ifndef	__RTL92C_DM_H__
+#define __RTL92C_DM_H__
+
+void rtl92du_dm_init(struct ieee80211_hw *hw);
+void rtl92du_dm_watchdog(struct ieee80211_hw *hw);
+
+#endif
-- 
2.43.2

