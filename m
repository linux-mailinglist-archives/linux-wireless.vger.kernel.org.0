Return-Path: <linux-wireless+bounces-7810-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E27D18C8DA0
	for <lists+linux-wireless@lfdr.de>; Fri, 17 May 2024 23:19:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E80EB20B47
	for <lists+linux-wireless@lfdr.de>; Fri, 17 May 2024 21:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1F712208F;
	Fri, 17 May 2024 21:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N/jxoYUT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E737B2F36
	for <linux-wireless@vger.kernel.org>; Fri, 17 May 2024 21:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715980736; cv=none; b=bREgYo04HbK12r4v/oLbd8Xaj7BripnTBiGP5Y5cjcErV7JCFu2pBkikJDoCKh3gSrt0xaA+/8r36E5esxsogSIWQKQPG7OfAH3ZfjeHLgIk8ix7KkSxbaE7V5WFPVSAvBLXyMROKcb+k8D1uKbz962nv19KV7ChAfLebk1PNws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715980736; c=relaxed/simple;
	bh=VLXwO+f+vHr1VgnansW+tgm7Yw4m6bUPBUYxUfzr3Fw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Un0Zzk7NMkA3bSblpkzYvSyD8ZCm+j5427HTMhgHW8ESLW/iRBbRedzgI1Y4fWdcr/60tgJ7I8g6KyLfU38BRcITcc41JhvpiP00i96Z9wzz8vw8sLMMVOa3dC6GDRaDD7XxrAkVtwwjlaxSp58/H6nPJX874NwU0FYFshdjSHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N/jxoYUT; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-34eb52bfca3so520248f8f.0
        for <linux-wireless@vger.kernel.org>; Fri, 17 May 2024 14:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715980733; x=1716585533; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1Ea3jL7cDrp0uf6Q02CHC/d/OAbjIGTCF0GDX7dNuaY=;
        b=N/jxoYUTxOozCWfpA7aiHDUD+PB48glBrQKGnFVPWrG0Vm3IM50tsS7gf4vdoja1nY
         i1YhbNGWvu2CBazWQrrkDU33P8EQS+680zDTZYJrzQlbAWAmJkP6PcCQS0M/GynppNi1
         brQH13cneAzPkbABAO7ytyxVIFveYxInHoiLr9iaP/I6K0bXqtQlqFhOCyI6/wkeLvWU
         i+s7Gm4YiQFD10Sj4OiTOf6YWbE9j1xnTBeuu7Ie1PJr0GsK0lJiB3k8RcX0ceP7RpYD
         6/rGxJSYI4utM6G/WQzWs+/9EdW3CG8xKywRW3OvRi31A21GnEt9+Ouc0K6/oFMCmVz/
         GDBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715980733; x=1716585533;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1Ea3jL7cDrp0uf6Q02CHC/d/OAbjIGTCF0GDX7dNuaY=;
        b=OmrZW8RFuDyBKXSBmXxiNS3xAf65Ig+IEJ/v7dTcJv1lp6RdZzD+yH7vPWYYDT1iG6
         PJx/w3zbxF0AvSn3Rnu+W9dftivNv41goe8RvsBFojNoVvRzIT8wJ79IixJ508k7a5va
         sBFeVMavnNZnxwxaOOBi0jxrFp3OxLPwaS5tiVlYM5Wk4x4eXWyPvHnsOb8EDf4Euft9
         m0SD/+x2OR/DVFec8BjT6r1G75OXGBv6M6ZXJqpV7C5ypZBueca1gJ1WhZsw9IkNrcd+
         f0jl8YEjdGkpWaS1UOFk4Y/qnHMKUfc54AH4cA1uruwx/vKdEq+DFk16SvnLDBIx/ncT
         O1FA==
X-Gm-Message-State: AOJu0Ywtg8n7vCRrB2+LIBlOnvJuqdSTTFDCbJJUIS+YfbGgSf8Eu8gm
	crtW7OREocp3HhucDbPlOVG0FH2xomFA/uV8Lanc0QiwQS9EN3gYkd87HzWg
X-Google-Smtp-Source: AGHT+IHKaHb6yZbPKRpppmp76bS1MVDHwqPbwCsz0Fp/JuMx/81pV7zz2QtwpPisUeSX8lw33RqqSA==
X-Received: by 2002:a05:600c:5116:b0:41b:fa34:9e48 with SMTP id 5b1f17b1804b1-41feac55e26mr220593865e9.30.1715980733118;
        Fri, 17 May 2024 14:18:53 -0700 (PDT)
Received: from [192.168.1.50] ([79.113.154.240])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17b17844sm1148125866b.190.2024.05.17.14.18.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 May 2024 14:18:52 -0700 (PDT)
Message-ID: <d55de1c2-5945-4fbe-a65a-56536f9935c6@gmail.com>
Date: Sat, 18 May 2024 00:18:51 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v6 08/11] wifi: rtlwifi: Add rtl8192du/dm.{c,h}
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

These contain functions related to the dynamic mechanism, which runs
every two seconds to adjust to changes in the environment.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v6:
 - Update copyright year.
 - Remove some unused includes.
 - Make all functions use the prefix "rtl92du".
 - Unindent rtl92du_dm_watchdog.

v5:
 - No change.

v4:
 - Replace tab with space in rtl8192du/dm.h.
 - Fix dm.h header guard.
 - Delete unused UNDEC_SM_PWDB macro.

v3:
 - No change.

v2:
 - Patch is new in v2, split from patch 3/3 in v1.
---
 .../wireless/realtek/rtlwifi/rtl8192du/dm.c   | 120 ++++++++++++++++++
 .../wireless/realtek/rtlwifi/rtl8192du/dm.h   |  10 ++
 2 files changed, 130 insertions(+)
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192du/dm.c
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192du/dm.h

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192du/dm.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192du/dm.c
new file mode 100644
index 000000000000..dd57707a9184
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192du/dm.c
@@ -0,0 +1,120 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright(c) 2024  Realtek Corporation.*/
+
+#include "../wifi.h"
+#include "../core.h"
+#include "../rtl8192d/reg.h"
+#include "../rtl8192d/def.h"
+#include "../rtl8192d/dm_common.h"
+#include "../rtl8192d/fw_common.h"
+#include "dm.h"
+
+static void rtl92du_dm_init_1r_cca(struct ieee80211_hw *hw)
+{
+	struct rtl_priv *rtlpriv = rtl_priv(hw);
+	struct ps_t *dm_pstable = &rtlpriv->dm_pstable;
+
+	dm_pstable->pre_ccastate = CCA_MAX;
+	dm_pstable->cur_ccasate = CCA_MAX;
+}
+
+static void rtl92du_dm_1r_cca(struct ieee80211_hw *hw)
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
+static void rtl92du_dm_pwdb_monitor(struct ieee80211_hw *hw)
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
+	rtl92du_dm_init_1r_cca(hw);
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
+	if (ppsc->rfpwr_state != ERFON || fw_current_inpsmode ||
+	    !fwps_awake || ppsc->rfchange_inprogress)
+		return;
+
+	rtl92du_dm_pwdb_monitor(hw);
+	rtl92d_dm_false_alarm_counter_statistics(hw);
+	rtl92d_dm_find_minimum_rssi(hw);
+	rtl92d_dm_dig(hw);
+	rtl92d_dm_check_txpower_tracking_thermal_meter(hw);
+	rtl92d_dm_check_edca_turbo(hw);
+	rtl92du_dm_1r_cca(hw);
+}
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192du/dm.h b/drivers/net/wireless/realtek/rtlwifi/rtl8192du/dm.h
new file mode 100644
index 000000000000..2f283bf1e4d8
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192du/dm.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright(c) 2024  Realtek Corporation.*/
+
+#ifndef __RTL92DU_DM_H__
+#define __RTL92DU_DM_H__
+
+void rtl92du_dm_init(struct ieee80211_hw *hw);
+void rtl92du_dm_watchdog(struct ieee80211_hw *hw);
+
+#endif
-- 
2.44.0


