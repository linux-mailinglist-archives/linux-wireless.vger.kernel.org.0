Return-Path: <linux-wireless+bounces-6049-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46FF489E409
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Apr 2024 21:59:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F02D128266D
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Apr 2024 19:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E30D15749A;
	Tue,  9 Apr 2024 19:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KAjA6hxX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6713F156F4E
	for <linux-wireless@vger.kernel.org>; Tue,  9 Apr 2024 19:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712692776; cv=none; b=jeE5K9B9qHRYwfQqpYKJv8xJcMT8npDXG+yjyOB507f6sRun86N4N0D1D5+8DatVeR4dciSeeiF7heHNSPQg9ieOOoM3BbRqcU+qHlast/fzjluffp5f8SLgW0cl+5gAOb5OJJY9u+mpck/pEL//qqDIPbpo6wBuEHNFo8hm07U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712692776; c=relaxed/simple;
	bh=sh9bjjwhj7rtaiSiP4L7fUB0tsjKqrL4pHwAr0EwHnM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ISgHPB1P6fqMqHp0L9Ml9IPAPAKa/0yOMjuUhHNOmCkROTpGXR646tYoe/FIKhI5YCOelVpEu7g9zMgkC42uysHduZnUMGUfIjM9RIUwwQDOm4kBqFllJZo/OBLyiMx01ou4gck6nTamNP27j8e8k3UfWaI+ewgIApNeC+SHWv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KAjA6hxX; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-516c97ddcd1so7100850e87.2
        for <linux-wireless@vger.kernel.org>; Tue, 09 Apr 2024 12:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712692772; x=1713297572; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=v5xoqjKchlCj4AcJ4D/9+T5g8GVi7et9mzFm+xA32mQ=;
        b=KAjA6hxXFKHNh6GA6U8njNdExyaVsy9i2QzWpn6pklNIv6i1q08LoGP543nkB71OyJ
         p28ROb5MvYpZ1F/b78+ZdcyE7GAMA/rpPvihViDaxZwOWpkEuPFQlUrg92mXCvWEmNt8
         h1b8CmqoxmfdXo6TiVnTadav2t5fG+vp8FULQ75imxo3G/BK6yDyZwRqlqJ5wco8xrgb
         umxe3h7akzI+PKrO6aDTwGQYz3f5587A4rXbr+JrffnxONWExvBisRuCjBYIDTHjkH2j
         vQI86o7SzYYc/eqn+qvhdbmKYEiWFT/Hn2s6NtHvEXMFrXCTO2GPuVoCYuiL/4587AEN
         jdkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712692772; x=1713297572;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v5xoqjKchlCj4AcJ4D/9+T5g8GVi7et9mzFm+xA32mQ=;
        b=O/mUwnEKVzlXMtYhnFQZ4HtUyUkFqvtGUQ7c1UA4sgYuYu7u0M9ouJzF4w0GlThMuj
         KLKIUKMUt4GY7ZHcrXqw6tRjhivXsUYf2rzj8E8BJ4sk9g5nrULf14hCaquqCq/oiNrI
         hIVhaCkRjyW7tdMJuOtLsCDvam8BQpd4aMggHhY3+Oq+9Cuud3m6jAIcjvDgP9PDnNa2
         IHqAecmJXX1O+nhvKWsYrVw8m2SljrzCuzWWhEl8xttIHf+rw+7giFoVnJ1vNPkfpBjm
         JQGKmOx+hsiQkdcKhu0Ylj4RY5LGfH6jYADGEM8URlZMRsfH4Psxu6nGM2y1CAZ+SDEZ
         eIcg==
X-Gm-Message-State: AOJu0Yxz9SdIsTV2DwW7Gi5pDJv/LMXu9a2efpSE/Ut4YX6zZRMPD7q0
	ZJBOAw6yykx8zOj9XqOneNRAlNmTmWjU/5bBjCn1j1qSwUWvNRpKcWDZtCsT2E0=
X-Google-Smtp-Source: AGHT+IFiyivtycWiyKU+qKnAyXat6b+ChPcWx95EOxhiPJLctDj2FAffJWodY0/FXVpMJRmLb/igaQ==
X-Received: by 2002:ac2:4c2d:0:b0:515:8acb:165e with SMTP id u13-20020ac24c2d000000b005158acb165emr214428lfq.68.1712692772271;
        Tue, 09 Apr 2024 12:59:32 -0700 (PDT)
Received: from [192.168.1.50] ([79.113.154.240])
        by smtp.gmail.com with ESMTPSA id r27-20020a170906365b00b00a47152e6d10sm6029632ejb.134.2024.04.09.12.59.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Apr 2024 12:59:31 -0700 (PDT)
Message-ID: <85055c05-b23d-4dc9-a300-d7e52f45f91a@gmail.com>
Date: Tue, 9 Apr 2024 22:59:30 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v4 11/14] wifi: rtlwifi: Add rtl8192du/dm.{c,h}
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

These contain functions related to the dynamic mechanism, which runs
every two seconds to adjust to changes in the environment.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
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


