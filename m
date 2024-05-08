Return-Path: <linux-wireless+bounces-7336-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC2B88BFB52
	for <lists+linux-wireless@lfdr.de>; Wed,  8 May 2024 12:53:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B0361F2309A
	for <lists+linux-wireless@lfdr.de>; Wed,  8 May 2024 10:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2C2781721;
	Wed,  8 May 2024 10:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AWNZUHS6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6E28004D
	for <linux-wireless@vger.kernel.org>; Wed,  8 May 2024 10:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715165594; cv=none; b=K48Ero3ONK0eYSblIEwdYgtuxzx11xLtggIptQgIsu6E+4RtJV351z5H6Xn7p3iu4MWyb9XX+xHiI5srbPAosqOmxJZT2SMIO9AVC0wGd4/bAlPpFeXjYn9Zqaeley3zmjoqBmEFDL0iuG08Up4wwbvufzTjOnfwFAol7hcxKhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715165594; c=relaxed/simple;
	bh=xItuV9Gr2oCsOY2UL7pHLtRpMjVSrRMrfPKRDIpv7MA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=d3+hZ3kGMh2LqdZ0EMYSicJwnDDWPohyZHcZp8zzHr+/lPjVeNaWvE+CSY3sKFM9xUbFaeoS5ypeHK9lnhv8pIH7fTiGj9anNQsnNtjOIqagfy6HynJwPVJCZhN5k6QzaUpaOnwBYVX1npgQjCTEraQMCCisUggFrjo6BdQiYYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AWNZUHS6; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a59b49162aeso917201566b.3
        for <linux-wireless@vger.kernel.org>; Wed, 08 May 2024 03:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715165591; x=1715770391; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4dFzgkgDd6Sn/drI0KYVuVbo2niKrZFW/DqHq/5zaYg=;
        b=AWNZUHS6OxNwQGxYEQrIvZMK+AWuf2hWNn96nVu/IaprwKadnCN/zyMZccJQphWxq8
         vRedFttrZmfEpQDtNKVtyOP9lyIpmOM1erw24ZADAed9lSFDMhbrOgJya1OG04+ODxMp
         nPAtpTgmhFM4fFNaXjsLWVpw2xKez8o+zekRcaKrcnNyERSiPyXNoh8Lq5bX3CEM3/Il
         Iq4b1Gowx/GKK9ylHgoPkz6PzTIKrzi62qGZeCxahzdDY7rblvDWHOGqbpXb6X/bFz+R
         /qvpaBkcW7SYc0XkgwERaHIRw1/briQL+LfYuqgea3Ye+4Axy/WGm2xF1C6I5bS15iZ5
         MBzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715165591; x=1715770391;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4dFzgkgDd6Sn/drI0KYVuVbo2niKrZFW/DqHq/5zaYg=;
        b=eHvZACQ3teBvD8pGLLmzGEGDq1RvtGznSWOPlIqVVVSwmrXiRGBxboyLtUdjinukjA
         F+V7Rml9jeUpw5vYEvhUzK9ZxEBNOCFJtqK9VSh2e+noadVOL63MbHX6a2IXRfWOItH+
         hNPqpECjIXvwD/Xz/T8Pd2x+xu2aUPmuJsQHDK7pJxMP8QPj4ODicvqTrV3nL/qzdEBg
         bq+QNoUOQBkcderFKpmnVnsTRZlCA9P4ILVXzlNQWUHvyXyfrS9M1LaRrrZZEpY68PAL
         wOCNxpYciPDxUEAZLc0c4GvIuL+JVDKKR6jMDdkvC9B/QT5nJ2njsDGKn57jGWmzcvtK
         L6mw==
X-Gm-Message-State: AOJu0YywtLTnA0Xbe5oRYJNhakHWb1yxfm4Z6Vv9EhLUZhurB/TxNPz+
	fzCqTl72czzjc06mcwplzmpOpZJN5jOEIm3/0YwmicHkZQ6ftOMSntkFGuFz
X-Google-Smtp-Source: AGHT+IFlE9n/50n3/I4NMtu1bhWXEQFAVTDypZzAVnwyqRj3ooG8beAKmMJZv9PXv1HgCgcvC9MH6g==
X-Received: by 2002:a17:906:4a11:b0:a59:ad15:6133 with SMTP id a640c23a62f3a-a59fb9dd014mr128790066b.71.1715165590976;
        Wed, 08 May 2024 03:53:10 -0700 (PDT)
Received: from [192.168.1.50] ([79.113.154.240])
        by smtp.gmail.com with ESMTPSA id qs34-20020a17090645a200b00a59af52e92esm4974337ejc.217.2024.05.08.03.53.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 May 2024 03:53:10 -0700 (PDT)
Message-ID: <efcc510f-b631-4b44-8b2d-42d501d6ba4e@gmail.com>
Date: Wed, 8 May 2024 13:53:09 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v5 08/11] wifi: rtlwifi: Add rtl8192du/dm.{c,h}
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

These contain functions related to the dynamic mechanism, which runs
every two seconds to adjust to changes in the environment.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
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
 .../wireless/realtek/rtlwifi/rtl8192du/dm.c   | 123 ++++++++++++++++++
 .../wireless/realtek/rtlwifi/rtl8192du/dm.h   |  10 ++
 2 files changed, 133 insertions(+)
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192du/dm.c
 create mode 100644 drivers/net/wireless/realtek/rtlwifi/rtl8192du/dm.h

diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192du/dm.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192du/dm.c
new file mode 100644
index 000000000000..add909f7726f
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192du/dm.c
@@ -0,0 +1,123 @@
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
index 000000000000..1373db2fd87d
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192du/dm.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright(c) 2009-2012  Realtek Corporation.*/
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


