Return-Path: <linux-wireless+bounces-5034-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91428881811
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 20:42:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15AB91F230FC
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 19:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99F0853E2C;
	Wed, 20 Mar 2024 19:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nchS9Zly"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C9185654
	for <linux-wireless@vger.kernel.org>; Wed, 20 Mar 2024 19:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710963749; cv=none; b=OAyrnmmaM/sutE3ZFLIwYaLc/T8UzLJHlOiHOO1xFXKqd+qbsY7441U/CcTaypLTmyVKwYEwKqLih3hF/mGR4Aue/hIH9vWZgC11F9gSHw5Q5XM8XfiO6Dyxsa9SOhMg3QO0QVK3yFlUsZp/OqkZJWFf5reOV91x+cVH6ONePmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710963749; c=relaxed/simple;
	bh=BBiX4zlfE4bOzB49iGwPxn8FaS6XRiFanPLHuQvHpmQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=i86BQPVfo9o8Kd511epkAvFlYusq5g4H7w2ag3qxujOvKwRRXCuJ2dVp8EYJTz+22Dpm3FGIcHi5Z26eLTSqMKcVM/8HFd7TWIP8OJFZqoW9qhjWNbhpdEbPU9+vk/MwC193ogmDaHbzaftRKsoNcy8noo86vxFllBYmKpSsjD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nchS9Zly; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4146e742cfeso1676215e9.0
        for <linux-wireless@vger.kernel.org>; Wed, 20 Mar 2024 12:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710963746; x=1711568546; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CJiVCFHoVuhjW5tVRricFq+UxHDHt25Eo9GSqpg8e0Q=;
        b=nchS9ZlyluMAflJLFTV2ZWkMKIgD29buJ7r0J2NuV0M6hj6kGNCoDSflbJbZfSNefB
         5FzOYTraAxsLzs5cFAz5ln+gDHh51YJxNZyBRKxoU8jz5ytmw2K4mHukYO/VD6LEQHpT
         FNgd7EsS5g9lshsXKexehLSi5VIR5kKwI2D1LTx61JVo6P7BtyfrsR4Unk0XycO0toxb
         QB0g45wbc1A8lFdYLYqBsklXnR0OxR5sKIXOHyBCOXHlr+tql1sckSG3q3V64d8tk1aI
         jh8CxOyu/btZlvW6N938UrsmdKa5iX6OfHULMs6TeudB+wVituM2sW4aCbbaVHL5hd2k
         Y9Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710963746; x=1711568546;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CJiVCFHoVuhjW5tVRricFq+UxHDHt25Eo9GSqpg8e0Q=;
        b=BGgvPuC7Lx0SfOjOhPwL1ykjcBm+Q9SMhYqK2xDqt+gtTBBJlB7MNDJKJT730P4Ya2
         iOvCgAePkc2e1W5G15PRlb2kzZ4WdXWkAZOFSS9hyDoEC3kXT0PC/TPBW8RSXxRPc4bD
         x4WaYYFzR4UqtTtg6nK/5S9phleG4a76xEHOI0erpPaBggIjKlMbjxM19VCoJYDnsWHy
         /7CXGbS3BWM5T4bpVVGTj7c1olqGZxNRXz16p5amTpB9xdAok3xTTwrYzE40V8rcnzLb
         XKUDmMjLXBmvhuc+5Wb4QSeQekTB7DfiHzCjWqkB6yUf+9L0rlbvE2SRGZI3Y855njTC
         VF1Q==
X-Gm-Message-State: AOJu0Ywx0Ti9SIT89NbmzovIhBRYFjNGIuM5FyjkXZpng8imvAP/n1/5
	X6Rp/soi4J5Nsu1BQnIJndnVqzhLV/g7VrHjjB1fCobCp4hi66BB96198wrB
X-Google-Smtp-Source: AGHT+IGoUftnaHZNpl55uYnMiAp6l6zG6QUt4KwgIDm1kGuntQFtHGhWBnsaaMF896mgZMMRDK1tgA==
X-Received: by 2002:a05:600c:1c05:b0:413:2954:d5bc with SMTP id j5-20020a05600c1c0500b004132954d5bcmr2168928wms.27.1710963745878;
        Wed, 20 Mar 2024 12:42:25 -0700 (PDT)
Received: from [192.168.1.50] ([79.119.240.211])
        by smtp.gmail.com with ESMTPSA id bd6-20020a05600c1f0600b0041330d49604sm3176610wmb.45.2024.03.20.12.42.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Mar 2024 12:42:25 -0700 (PDT)
Message-ID: <5af3c18f-b96a-4599-b3a4-328c8f402693@gmail.com>
Date: Wed, 20 Mar 2024 21:42:24 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v3 10/12] wifi: rtlwifi: Add rtl8192du/dm.{c,h}
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>,
 Larry Finger <Larry.Finger@lwfinger.net>,
 Stefan Lippers-Hollmann <s.l-h@gmx.de>,
 Christian Hewitt <chewitt@libreelec.tv>
References: <7f4b3309-1580-48f3-9426-29f1eb4052fd@gmail.com>
In-Reply-To: <7f4b3309-1580-48f3-9426-29f1eb4052fd@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

These contain functions related to the dynamic mechanism, which runs
every two seconds to adjust to changes in the environment.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v3:
 - No change.

v2:
 - Patch is new in v2, split from patch 3/3 in v1.
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

