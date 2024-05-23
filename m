Return-Path: <linux-wireless+bounces-8022-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA0C98CD614
	for <lists+linux-wireless@lfdr.de>; Thu, 23 May 2024 16:47:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04970B20407
	for <lists+linux-wireless@lfdr.de>; Thu, 23 May 2024 14:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEE7D2901;
	Thu, 23 May 2024 14:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KrTwhW/Z"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270FD1879
	for <linux-wireless@vger.kernel.org>; Thu, 23 May 2024 14:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716475665; cv=none; b=mBpqFtv4yGbK9OUIBu1Vbc5AyxHu3wrgcqwe1T1zkA+9UoWGAC3aI3WVl1QRWo0AdZkCo4dBkkBQMYNl0Tziwr4p/aJKSLiL16t7t9WMrvabC900ZnHrEL3KnvGyu5t0rdmRpfY8Y0YO9EObIYdu2wnNAQaHpT6UceYH00ycjKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716475665; c=relaxed/simple;
	bh=Ei0I7owjSctY3LlnYt6iR/InPNyQGmRNftrtRmqoEsY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=mkqCJJe96VWN+tPY7pGe816ovJefKmzQzKkQpIskA43AOI4W9jtsR3kh4WyKnjRnO8e9uzup+C3um+50WOhmp3KbkFs3qqTyRZQPiyZVJoIq2WAnxvqr5RzxGFLw7SOUreEYgqElNS83Nd3fLOp994ZNCqiVfUo27+EGAdbmjV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KrTwhW/Z; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-56e56ee8d5cso13339313a12.2
        for <linux-wireless@vger.kernel.org>; Thu, 23 May 2024 07:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716475662; x=1717080462; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=B79LNqQEK26xisDMB5NkzeExFmHs3Un0tKGodgKp7Wk=;
        b=KrTwhW/Zs1wju5UqA8HOD8JI67wuEX1Eds5xn0Pcn8nnwc0+rtUTngz2VwUiRjQbtM
         gFva8v2nz7/xK7QVhO5xJ310RPYBcAMFC49a1Pz4Z2OAV83aU1MdbdryfQvzbNKt0taU
         rZ3rueeaBWOJFpxuS9+cerp/4vhudbf9YAt5kN3/n4c1fi8p65po19Sk0mhRUwTrTzB/
         S9ridsLM90nEum+VgnCeF207RVpIKmj0mbJox8PWaynUEL8OpexrU7QItIKbSwnLmuhS
         a9FowmXEQ+4DDyPRiMrlT26sAFNFk29IqP6ScV54hZ3NfcFI25HpXnvpdYYSDfx4G1bi
         Wa1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716475662; x=1717080462;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B79LNqQEK26xisDMB5NkzeExFmHs3Un0tKGodgKp7Wk=;
        b=DAqnlJQKD6aU9FUFtzg9NZyMEAJqf7BfEXgntMBc8ZJlhAYDZk7Lw65EGZwCG72r/F
         SMZtdl/wkI+/MFS2u4Q+yRex+OzZl4tn/3adYQasy7iytWYBb7ok7OJenB3UXRkzYd8S
         fZy6v7/R2O/HSTNfrHalr6z1zMYKXle+PSsnMUJmEA8MQVGyOr2J2PGSQZXZLTVdJogE
         ZLmlgLA713hci/JfsEwvVV/QpV/Yt0wfVHIX/wu2Auha8k4SmrEKgg0YEEi+/eZNjyO+
         obKL2YRLr++8HU6ZA0UY0bzz4lYgb1gvsEYfBpn5YEtJOHAiFBHEXXGeBbY6xq8JynNT
         vCRw==
X-Gm-Message-State: AOJu0YwLPt17pOcyOwI411QPBeR6cSBN0M9buGjqZzjpABqLZBCBuKXW
	YYEP522xLCHhcLXE9tHwSSbDCejhXLWCRS7N4y6mYY9J9mZjBpvksTt1SQ==
X-Google-Smtp-Source: AGHT+IFnCC2kYxys6iIB0yriKQ1yitpYaJmD077Uzu2eO/48/9Ir4qxAA62CDNvux/aqsUlsZjf2Cw==
X-Received: by 2002:a50:aa96:0:b0:575:2ccb:8138 with SMTP id 4fb4d7f45d1cf-57832c2e591mr3777698a12.29.1716475662385;
        Thu, 23 May 2024 07:47:42 -0700 (PDT)
Received: from [192.168.0.50] ([81.196.40.5])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5734d4cf324sm19334910a12.24.2024.05.23.07.47.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 May 2024 07:47:42 -0700 (PDT)
Message-ID: <a010ed6d-efb0-456d-bd4a-dfc6da23e7aa@gmail.com>
Date: Thu, 23 May 2024 17:47:40 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v7 09/12] wifi: rtlwifi: Add rtl8192du/dm.{c,h}
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

These contain functions related to the dynamic mechanism, which runs
every two seconds to adjust to changes in the environment.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v7:
 - No change.

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
2.45.1


