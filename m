Return-Path: <linux-wireless+bounces-35666-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UMIVAB7i8mkmvQEAu9opvQ
	(envelope-from <linux-wireless+bounces-35666-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 07:01:18 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C96ED49D745
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 07:01:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B62833024DFB
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 04:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B10937757A;
	Thu, 30 Apr 2026 04:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20251104.gappssmtp.com header.i=@morsemicro-com.20251104.gappssmtp.com header.b="Q9Hpjlja"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1A637703A
	for <linux-wireless@vger.kernel.org>; Thu, 30 Apr 2026 04:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777525099; cv=none; b=aX+pD5wcOgegD6uWaio0Xmt8v0N8MbtjM8O+iqj1Dpg0bokxQjcMuaAX8aMbn/PGnvJ9lGXNbH5gUH03NhAqaKBbcM9nvhQD34UGXrbsfxGmn46m7f1cmQktngxDCO27ZLflEF7XQVuJpO3NGjK1XcUwrCiOwIsFBvmOS8wIVJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777525099; c=relaxed/simple;
	bh=qCpFG5TOWLC1tbhiofFOEVfiTxBTcMQS/m4jnFn+AQg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IyPhLiH7RxhdhU0TUKfxRrr6g4xjVnXF5Hhyfgs8djbyRAEvFOlYcC823++V/MDlPmBBhmkV5kCLtH4OXII2JPhb9lv4nc3o76pIhonyzJsA0hqlSsyq+H/NUL9e030MrZ84vnRh1zkGALIrJtgAnlkEALu82comKlYcb91ejBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20251104.gappssmtp.com header.i=@morsemicro-com.20251104.gappssmtp.com header.b=Q9Hpjlja; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c79467f11abso270686a12.2
        for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 21:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20251104.gappssmtp.com; s=20251104; t=1777525096; x=1778129896; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K3PK/y84QT0+ICofxOXj5yqj1rmVWEKcCx7kSiGrt+4=;
        b=Q9HpjljaZVaotKE7au4eaZPqiVjUV7/Lj90UAd/b8f4SPleWrxBASBY+z5xCbzfd0n
         a0kZxa+SeBfmLu0Bs29xyYQppkmNnfGPJJIdslhjnPE8bBPlqtbL+ypZSngDMa6BUXah
         ulcb1XsREVfHo+/9tC8EFREclPaV57EpVFE068f0Hf6DtqQEIYC4GHH7ezBAW7i4JpQG
         Vd/BxLb1rMBG4h8G0QbgdApJCtGB4N8kZbvPH/M2fSWZxLnht6vA4oPWqDicKfj6fue7
         MVBz3WpXyp/rzo9x5XZUDdDuqYN8dK/6y8GIXkt6iCx3LXtafYlfwuFESuswBk89Dc4l
         gQWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777525096; x=1778129896;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K3PK/y84QT0+ICofxOXj5yqj1rmVWEKcCx7kSiGrt+4=;
        b=MQ7wTj3KRMN1iV0EU0u5OSr7uUzfMK9arqp+XNwNLGHgW7h6daVWktq9R6i7TFMY9a
         5XP8KwCbHMK0iuY6XA1OCjcirJ7AS44y3t17WXwsN4OwX/pIth4ijG9kEFauTd4oqK6W
         XUhoYafqTCggt7W71Gmgknw+PomH28tWebawJZe2Rmy+ANqYbhi69MC1uo/3ZUkOY8zw
         DWWnrlWAcSF1ZcrsYDoz7xwesnLzBZZQ7Wj9ojgCxF0Znft7WT4liEK+t5FyTWGcswzr
         9Fe/rHnqBuqhES2sHR33kQuMSF9dMKLLkdzAoCQqNU6Z/lACMm+7UklEUhQ6XNALy8Jb
         J+SA==
X-Forwarded-Encrypted: i=1; AFNElJ9ZnWbluVQ6CjtMmjt+9A92NoBBmlC2NtybeD9UMtrnQF3WRMmX2W00nNI3bjIZPgAP5PYtCuPdWz5nL/RmKg==@vger.kernel.org
X-Gm-Message-State: AOJu0YztsBtzhz1DW/9FBNui98OaLq55ju3D8dg3kD3JIruUr9vHuFSo
	4gkiFQPuc5adF9i6LQMo4pwWlVc0tNYwRzTGqS9fhdMGD0Qd2hqczYDNnqIPXIWc+Z1WEFRiXpc
	tN5JD
X-Gm-Gg: AeBDieuGJ/6FQv35wT+P9o/CUxabvtd2B/inHhgxZNG4xywTucCeLpV4cZ4E4Cxepp5
	iZI/SuvFALrFbUFSGKEvkuB+Pn61i9DRj+VX0lI6pZziDVbzzDdkfq/LRrBJWAqYoxH1aWQHRy7
	fWs+18KHmtjOMx4bv8m3rQ2kATtrs2jB20bsvjIU8CJmvOZiPopPXdNhaLTNxp4v6smibEZ2xKb
	sAlBXoiggfkToYNMB3Wn3eamisuc5Ft2hzkhstfhzRoKFLYG76fonnHnGGI3JHYq0gMsL+94EG1
	YDOT5GCjMJxbsHoQRi91+qCAyKQ0KXbeYDtPh7pl4zuadszydixtCDk3R/W5TzB4ss/eWQPLrDj
	OPcVTMMzEPojRfy9Fd/Y4xDr/5oihxO70fMvrXrAU/ogonE/b5SneaelL5/tjc+b8KWhsLFwQN+
	s/PZxWmC9vxOzxNGjbogoXTEjoMZbh84YdpgGTJziKchHMNqq1LPfHt50Ub85rnaxvcTzdhQvVx
	VZeF2i/ZKuU3Kuzo+TYpArTXjY+PZHw4+7wAA1N33j44AhYd+om
X-Received: by 2002:a05:6a00:1a86:b0:82f:623f:e5b3 with SMTP id d2e1a72fcca58-834fdbd8f0amr1620653b3a.34.1777525096507;
        Wed, 29 Apr 2026 21:58:16 -0700 (PDT)
Received: from mma-H9MHD44.lan (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-834ed80df96sm3595073b3a.54.2026.04.29.21.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 21:58:16 -0700 (PDT)
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>,
	Dan Callaghan <dan.callaghan@morsemicro.com>,
	Arien Judge <arien.judge@morsemicro.com>
Cc: ayman.grais@morsemicro.com,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH wireless-next v2 19/31] wifi: mm81x: add rc.c
Date: Thu, 30 Apr 2026 14:55:45 +1000
Message-ID: <20260430045615.334669-20-lachlan.hodges@morsemicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260430045615.334669-1-lachlan.hodges@morsemicro.com>
References: <20260430045615.334669-1-lachlan.hodges@morsemicro.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C96ED49D745
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[morsemicro-com.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[morsemicro.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[morsemicro-com.20251104.gappssmtp.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35666-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lachlan.hodges@morsemicro.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[morsemicro-com.20251104.gappssmtp.com:dkim,fixed_rate.ss:url,morsemicro.com:mid,morsemicro.com:email,fixed_rate.bw:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

(Patches split per file for review, will be a single commit alongside
SDIO ids once review is complete. See cover letter for more
information)

Signed-off-by: Lachlan Hodges <lachlan.hodges@morsemicro.com>
---
 drivers/net/wireless/morsemicro/mm81x/rc.c | 556 +++++++++++++++++++++
 1 file changed, 556 insertions(+)
 create mode 100644 drivers/net/wireless/morsemicro/mm81x/rc.c

diff --git a/drivers/net/wireless/morsemicro/mm81x/rc.c b/drivers/net/wireless/morsemicro/mm81x/rc.c
new file mode 100644
index 000000000000..c14e39aa2fa4
--- /dev/null
+++ b/drivers/net/wireless/morsemicro/mm81x/rc.c
@@ -0,0 +1,556 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2017-2026 Morse Micro
+ */
+#include <linux/slab.h>
+#include <linux/timer.h>
+#include "core.h"
+#include "mac.h"
+#include "bus.h"
+#include "rc.h"
+
+#define MM81X_RC_BW_TO_MMRC_BW(X)    \
+	(((X) == 1) ? MMRC_BW_1MHZ : \
+	 ((X) == 2) ? MMRC_BW_2MHZ : \
+	 ((X) == 4) ? MMRC_BW_4MHZ : \
+	 ((X) == 8) ? MMRC_BW_8MHZ : \
+		      MMRC_BW_2MHZ)
+
+static void mm81x_rc_work(struct work_struct *work)
+{
+	struct mm81x_rc *mrc = container_of(work, struct mm81x_rc, work);
+	struct list_head *pos;
+
+	spin_lock_bh(&mrc->lock);
+
+	list_for_each(pos, &mrc->stas) {
+		struct mm81x_rc_sta *mrc_sta =
+			container_of(pos, struct mm81x_rc_sta, list);
+		unsigned long now = jiffies;
+
+		mrc_sta->last_update = now;
+
+		mmrc_update(mrc_sta->tb);
+	}
+
+	spin_unlock_bh(&mrc->lock);
+
+	mod_timer(&mrc->timer, jiffies + msecs_to_jiffies(100));
+}
+
+static void mm81x_rc_timer(struct timer_list *t)
+{
+	struct mm81x_rc *mrc = timer_container_of(mrc, t, timer);
+	struct mm81x *mors = mrc->mors;
+
+	queue_work(mors->net_wq, &mors->mrc.work);
+}
+
+void mm81x_rc_init(struct mm81x *mors)
+{
+	INIT_LIST_HEAD(&mors->mrc.stas);
+	spin_lock_init(&mors->mrc.lock);
+
+	INIT_WORK(&mors->mrc.work, mm81x_rc_work);
+	timer_setup(&mors->mrc.timer, mm81x_rc_timer, 0);
+
+	mors->mrc.mors = mors;
+	mod_timer(&mors->mrc.timer, jiffies + msecs_to_jiffies(100));
+}
+
+void mm81x_rc_deinit(struct mm81x *mors)
+{
+	cancel_work_sync(&mors->mrc.work);
+	timer_delete_sync_try(&mors->mrc.timer);
+}
+
+static void mm81x_rc_sta_config_guard_per_bw(struct ieee80211_sta *sta,
+					     struct mmrc_sta_capabilities *caps)
+{
+	caps->guard = BIT(MMRC_GUARD_LONG);
+
+	if (caps->bandwidth & BIT(MMRC_BW_1MHZ)) {
+		caps->sgi_per_bw |= SGI_PER_BW(MMRC_BW_1MHZ);
+		caps->guard |= BIT(MMRC_GUARD_SHORT);
+	}
+
+	if (caps->bandwidth & BIT(MMRC_BW_2MHZ)) {
+		caps->sgi_per_bw |= SGI_PER_BW(MMRC_BW_2MHZ);
+		caps->guard |= BIT(MMRC_GUARD_SHORT);
+	}
+
+	if (caps->bandwidth & BIT(MMRC_BW_4MHZ)) {
+		caps->sgi_per_bw |= SGI_PER_BW(MMRC_BW_4MHZ);
+		caps->guard |= BIT(MMRC_GUARD_SHORT);
+	}
+
+	if (caps->bandwidth & BIT(MMRC_BW_8MHZ)) {
+		caps->sgi_per_bw |= SGI_PER_BW(MMRC_BW_8MHZ);
+		caps->guard |= BIT(MMRC_GUARD_SHORT);
+	}
+}
+
+static void mm81x_rc_sta_add_s1g_sta_caps(struct mm81x *mors,
+					  struct mmrc_sta_capabilities *caps,
+					  struct ieee80211_sta_s1g_cap *s1g_cap)
+{
+	int nss_idx = 0;
+	u8 rx_mcs = s1g_cap->nss_mcs[0] & 0x3; /* 1SS */
+	u8 tx_mcs = (s1g_cap->nss_mcs[2] >> 1) & 0x3; /* 1SS */
+	u8 mcs = min(rx_mcs, tx_mcs);
+
+	switch (mcs) {
+	case IEEE80211_VHT_MCS_SUPPORT_0_9: /* VHT 9 ->  S1G 9 */
+		caps->rates |= BIT(MMRC_MCS9) | BIT(MMRC_MCS8);
+		fallthrough;
+	case IEEE80211_VHT_MCS_SUPPORT_0_8: /* VHT 8 -> S1G 7 */
+		caps->rates |= BIT(MMRC_MCS7) | BIT(MMRC_MCS6) |
+			       BIT(MMRC_MCS5) | BIT(MMRC_MCS4) | BIT(MMRC_MCS3);
+		fallthrough;
+	case IEEE80211_VHT_MCS_SUPPORT_0_7: /* VHT 7 -> S1G 2 */
+		caps->rates |= BIT(MMRC_MCS2) | BIT(MMRC_MCS1) |
+			       BIT(MMRC_MCS0) | BIT(MMRC_MCS10);
+		caps->spatial_streams |= (BIT(nss_idx) & 0x0F);
+		break;
+
+	default:
+		dev_warn(mors->dev, "Invalid MCS encoding 0x%02x for stream %d",
+			 mcs, nss_idx);
+	}
+}
+
+int mm81x_rc_sta_add(struct mm81x *mors, struct ieee80211_vif *vif,
+		     struct ieee80211_sta *sta)
+{
+	struct ieee80211_sta_s1g_cap *s1g_cap = &sta->deflink.s1g_cap;
+	struct mm81x_sta *msta = (struct mm81x_sta *)sta->drv_priv;
+	struct mmrc_sta_capabilities caps;
+	int oper_bw_mhz = cfg80211_chandef_get_width(&mors->chandef);
+	size_t table_mem_size;
+	struct mmrc_table *tb;
+
+	memset(&caps, 0, sizeof(caps));
+
+	mm81x_rc_sta_add_s1g_sta_caps(mors, &caps, s1g_cap);
+
+	/* Configure STA for support up to 8MHZ */
+	while (oper_bw_mhz > 0) {
+		caps.bandwidth |= BIT(MM81X_RC_BW_TO_MMRC_BW(oper_bw_mhz));
+		oper_bw_mhz >>= 1;
+	}
+
+	/* Configure STA for short and long guard */
+	mm81x_rc_sta_config_guard_per_bw(sta, &caps);
+
+	/* Set max rates */
+	if (mors->hw->max_rates > 0 &&
+	    mors->hw->max_rates < IEEE80211_TX_MAX_RATES)
+		caps.max_rates = mors->hw->max_rates;
+	else
+		caps.max_rates = IEEE80211_TX_MAX_RATES;
+
+	/* Set max reties */
+	if (mors->hw->max_rate_tries >= MMRC_MIN_CHAIN_ATTEMPTS &&
+	    mors->hw->max_rate_tries < MMRC_MAX_CHAIN_ATTEMPTS)
+		caps.max_retries = mors->hw->max_rate_tries;
+	else
+		caps.max_retries = MMRC_MAX_CHAIN_ATTEMPTS;
+
+	WARN_ON(msta->rc.tb);
+	table_mem_size = mmrc_memory_required_for_caps(&caps);
+	tb = kzalloc(table_mem_size, GFP_KERNEL);
+	if (!tb)
+		return -ENOMEM;
+
+	/* Initialise the STA rate control table */
+	mmrc_sta_init(tb, &caps, msta->avg_rssi);
+
+	spin_lock_bh(&mors->mrc.lock);
+	kfree(msta->rc.tb);
+	msta->rc.tb = tb;
+	list_add(&msta->rc.list, &mors->mrc.stas);
+	msta->rc.last_update = jiffies;
+	spin_unlock_bh(&mors->mrc.lock);
+
+	return 0;
+}
+
+static void mm81x_rc_reinit_sta_iter(void *data, struct ieee80211_sta *sta)
+{
+	struct ieee80211_vif *vif = (struct ieee80211_vif *)data;
+	struct mm81x_sta *msta = (struct mm81x_sta *)sta->drv_priv;
+	struct mm81x_vif *mors_vif = ieee80211_vif_to_mors_vif(vif);
+	struct mm81x *mors = mm81x_vif_to_mors(mors_vif);
+	int oper_bw_mhz = cfg80211_chandef_get_width(&mors->chandef);
+
+	if (!msta || msta->vif != vif)
+		return;
+
+	dev_dbg(mors->dev, "Reinitialize sta %pM with new op_bw=%d, ts=%ld",
+		sta->addr, oper_bw_mhz, jiffies);
+
+	mm81x_rc_sta_remove(mors, sta);
+	mm81x_rc_sta_add(mors, vif, sta);
+}
+
+void mm81x_rc_reinit_stas(struct mm81x *mors, struct ieee80211_vif *vif)
+{
+	ieee80211_iterate_stations_atomic(mors->hw, mm81x_rc_reinit_sta_iter,
+					  vif);
+}
+
+bool _mm81x_rc_set_fixed_rate(struct mm81x *mors, struct ieee80211_sta *sta,
+			      int mcs, int bw, int ss, int guard,
+			      const char *caller)
+{
+	struct mm81x_sta *msta = (struct mm81x_sta *)sta->drv_priv;
+	struct list_head *pos;
+	struct mmrc_rate fixed_rate;
+	bool ret_val = true;
+
+	fixed_rate.rate = mcs;
+	fixed_rate.bw = bw;
+	/*
+	 * Code spatial streams is zero based while user starts at 1, like the
+	 * real spatial streams.
+	 */
+	fixed_rate.ss = (ss - 1);
+	fixed_rate.guard = guard;
+
+	spin_lock_bh(&mors->mrc.lock);
+	list_for_each(pos, &mors->mrc.stas) {
+		struct mm81x_rc_sta *mrc_sta =
+			list_entry(pos, struct mm81x_rc_sta, list);
+
+		if (&msta->rc == mrc_sta) {
+			ret_val = mmrc_set_fixed_rate(msta->rc.tb, fixed_rate);
+			break;
+		}
+	}
+	spin_unlock_bh(&mors->mrc.lock);
+
+	if (!ret_val)
+		dev_err(mors->dev,
+			"failed, caller %s ss %d bw %d mcs %d guard %d", caller,
+			ss, bw, mcs, guard);
+
+	return ret_val;
+}
+
+void mm81x_rc_sta_remove(struct mm81x *mors, struct ieee80211_sta *sta)
+{
+	struct mm81x_sta *msta = (struct mm81x_sta *)sta->drv_priv;
+
+	spin_lock_bh(&mors->mrc.lock);
+	if (msta->rc.tb) {
+		list_del_init(&msta->rc.list);
+		kfree(msta->rc.tb);
+		msta->rc.tb = NULL;
+	}
+	spin_unlock_bh(&mors->mrc.lock);
+}
+
+static void mm81x_rc_sta_fill_basic_rates(struct mm81x_skb_tx_info *tx_info,
+					  struct ieee80211_tx_info *info,
+					  int tx_bw)
+{
+	int i;
+	enum dot11_bandwidth bw_idx = mm81x_ratecode_bw_mhz_to_bw_index(tx_bw);
+	enum mm81x_rate_preamble pream = MM81X_RATE_PREAMBLE_S1G_SHORT;
+
+	mm81x_ratecode_mcs_index_set(&tx_info->rates[0].mm81x_ratecode, 0);
+	mm81x_ratecode_nss_index_set(&tx_info->rates[0].mm81x_ratecode,
+				     NSS_TO_NSS_IDX(1));
+	mm81x_ratecode_bw_index_set(&tx_info->rates[0].mm81x_ratecode, bw_idx);
+	if (bw_idx == DOT11_BANDWIDTH_1MHZ)
+		pream = MM81X_RATE_PREAMBLE_S1G_1M;
+	mm81x_ratecode_preamble_set(&tx_info->rates[0].mm81x_ratecode, pream);
+	tx_info->rates[0].count = 4;
+
+	for (i = 1; i < IEEE80211_TX_MAX_RATES; i++)
+		tx_info->rates[i].count = 0;
+
+	info->control.rates[0].idx = 0;
+	info->control.rates[0].count = tx_info->rates[0].count;
+	info->control.rates[0].flags = 0;
+	info->control.rates[1].idx = -1;
+}
+
+static int mm81x_rc_sta_get_rates(struct mm81x *mors, struct mm81x_sta *msta,
+				  struct mmrc_rate_table *rates, size_t size)
+{
+	int ret = -ENOENT;
+	struct list_head *pos;
+
+	spin_lock_bh(&mors->mrc.lock);
+	list_for_each(pos, &mors->mrc.stas) {
+		struct mm81x_rc_sta *mrc_sta =
+			list_entry(pos, struct mm81x_rc_sta, list);
+
+		if (&msta->rc == mrc_sta) {
+			ret = 0;
+			mmrc_get_rates(msta->rc.tb, rates, size);
+			break;
+		}
+	}
+	spin_unlock_bh(&mors->mrc.lock);
+
+	return ret;
+}
+
+static bool mm81x_rc_use_basic_rates(struct ieee80211_sta *sta,
+				     struct sk_buff *skb,
+				     struct ieee80211_hdr *hdr)
+{
+	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
+
+	if (!sta)
+		return true;
+
+	if (ieee80211_is_qos_nullfunc(hdr->frame_control) ||
+	    ieee80211_is_nullfunc(hdr->frame_control))
+		return true;
+
+	if (!ieee80211_is_data_qos(hdr->frame_control))
+		return true;
+
+	/* Use basic rates for EAPOL exchanges or when instructed */
+	if (unlikely((skb->protocol == cpu_to_be16(ETH_P_PAE) ||
+		      info->flags & IEEE80211_TX_CTL_USE_MINRATE)))
+		return true;
+
+	return false;
+}
+
+void mm81x_rc_sta_fill_tx_rates(struct mm81x *mors,
+				struct mm81x_skb_tx_info *tx_info,
+				struct sk_buff *skb, struct ieee80211_sta *sta,
+				int tx_bw, bool rts_allowed)
+{
+	int ret, i;
+	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
+	struct mm81x_sta *msta;
+	struct mmrc_rate_table rates;
+	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
+
+	BUILD_BUG_ON((MMRC_BW_1MHZ != (enum mmrc_bw)DOT11_BANDWIDTH_1MHZ ||
+		      MMRC_BW_2MHZ != (enum mmrc_bw)DOT11_BANDWIDTH_2MHZ ||
+		      MMRC_BW_4MHZ != (enum mmrc_bw)DOT11_BANDWIDTH_4MHZ ||
+		      MMRC_BW_16MHZ != (enum mmrc_bw)DOT11_BANDWIDTH_16MHZ));
+
+	memset(&info->control.rates, 0, sizeof(info->control.rates));
+	memset(&info->status.rates, 0, sizeof(info->status.rates));
+	mm81x_rc_sta_fill_basic_rates(tx_info, info, tx_bw);
+
+	/* Use basic rates for non data packets */
+	if (mm81x_rc_use_basic_rates(sta, skb, hdr))
+		return;
+
+	msta = (struct mm81x_sta *)sta->drv_priv;
+	if (!msta)
+		return;
+
+	ret = mm81x_rc_sta_get_rates(mors, msta, &rates, skb->len);
+	if (ret != 0)
+		return;
+
+	for (i = 0; i < IEEE80211_TX_MAX_RATES; i++) {
+		info->control.rates[i].flags = 0;
+		if (rates.rates[i].rate != MMRC_MCS_UNUSED) {
+			u8 mcs = rates.rates[i].rate;
+			u8 nss_index = rates.rates[i].ss;
+			enum dot11_bandwidth bw_idx =
+				(enum dot11_bandwidth)rates.rates[i].bw;
+			enum mm81x_rate_preamble pream =
+				MM81X_RATE_PREAMBLE_S1G_SHORT;
+
+			mm81x_ratecode_bw_index_set(
+				&tx_info->rates[i].mm81x_ratecode, bw_idx);
+			mm81x_ratecode_mcs_index_set(
+				&tx_info->rates[i].mm81x_ratecode, mcs);
+			mm81x_ratecode_nss_index_set(
+				&tx_info->rates[i].mm81x_ratecode, nss_index);
+			if (bw_idx == DOT11_BANDWIDTH_1MHZ)
+				pream = MM81X_RATE_PREAMBLE_S1G_1M;
+			mm81x_ratecode_preamble_set(
+				&tx_info->rates[i].mm81x_ratecode, pream);
+			tx_info->rates[i].count = rates.rates[i].attempts;
+
+			if (rts_allowed &&
+			    (rates.rates[i].flags & BIT(MMRC_FLAGS_CTS_RTS))) {
+				mm81x_ratecode_enable_rts(
+					&tx_info->rates[i].mm81x_ratecode);
+				info->control.rates[i].flags |=
+					IEEE80211_TX_RC_USE_RTS_CTS;
+			}
+
+			if (rates.rates[i].guard == MMRC_GUARD_SHORT) {
+				mm81x_ratecode_enable_sgi(
+					&tx_info->rates[i].mm81x_ratecode);
+				info->control.rates[i].flags |=
+					IEEE80211_TX_RC_SHORT_GI;
+			}
+
+			/* Update skb tx_info */
+			info->control.rates[i].idx = rates.rates[i].rate;
+			info->control.rates[i].count = rates.rates[i].attempts;
+		} else {
+			info->control.rates[i].idx = -1;
+			info->control.rates[i].count = 0;
+			tx_info->rates[i].count = 0;
+		}
+	}
+}
+
+static void mm81x_rc_sta_set_rates(struct mm81x *mors, struct mm81x_sta *msta,
+				   struct mmrc_rate_table *rates, int attempts,
+				   bool was_aggregated)
+{
+	struct list_head *pos;
+
+	spin_lock_bh(&mors->mrc.lock);
+	list_for_each(pos, &mors->mrc.stas) {
+		struct mm81x_rc_sta *mrc_sta =
+			list_entry(pos, struct mm81x_rc_sta, list);
+
+		if (&msta->rc == mrc_sta) {
+			mmrc_feedback(msta->rc.tb, rates, attempts,
+				      was_aggregated);
+			break;
+		}
+	}
+	spin_unlock_bh(&mors->mrc.lock);
+}
+
+void mm81x_rc_sta_feedback_rates(struct mm81x *mors, struct sk_buff *skb,
+				 struct ieee80211_sta *sta,
+				 struct mm81x_skb_tx_status *tx_sts,
+				 int attempts)
+{
+	int i;
+	u32 tx_airtime = 0;
+	struct mmrc_rate_table rates;
+	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
+	struct ieee80211_tx_info *txi = IEEE80211_SKB_CB(skb);
+	struct ieee80211_tx_rate *r = &txi->status.rates[0];
+	int count = min_t(int, MM81X_SKB_MAX_RATES, IEEE80211_TX_MAX_RATES);
+	struct mm81x_sta *msta = msta = (struct mm81x_sta *)sta->drv_priv;
+
+	/* Don't update rate info if basic rates were used */
+	if (mm81x_rc_use_basic_rates(sta, skb, hdr))
+		goto exit;
+
+	if (attempts <= 0)
+		/* Did we really send the packet? */
+		goto exit;
+
+	for (i = 0; i < count; i++) {
+		rates.rates[i].rate = mm81x_ratecode_mcs_index_get(
+			tx_sts->rates[i].mm81x_ratecode);
+		rates.rates[i].ss = mm81x_ratecode_nss_index_get(
+			tx_sts->rates[i].mm81x_ratecode);
+		rates.rates[i].guard =
+			mm81x_ratecode_sgi_get(tx_sts->rates[i].mm81x_ratecode);
+		rates.rates[i].bw = mm81x_ratecode_bw_index_get(
+			tx_sts->rates[i].mm81x_ratecode);
+		rates.rates[i].flags =
+			mm81x_ratecode_rts_get(tx_sts->rates[i].mm81x_ratecode);
+		rates.rates[i].attempts = tx_sts->rates[i].count;
+
+		tx_airtime +=
+			mmrc_calculate_rate_tx_time(&rates.rates[i], skb->len);
+	}
+
+	if (msta) {
+		/*
+		 * Save the rate information. This will be used to update
+		 * station's tx rate stats
+		 */
+		msta->last_sta_tx_rate.bw = rates.rates[0].bw;
+		msta->last_sta_tx_rate.rate = rates.rates[0].rate;
+		msta->last_sta_tx_rate.ss = rates.rates[0].ss;
+		msta->last_sta_tx_rate.guard = rates.rates[0].guard;
+	}
+
+	mm81x_rc_sta_set_rates(mors, msta, &rates, attempts,
+			       !!(le32_to_cpu(tx_sts->flags) &
+				  MM81X_TX_STATUS_WAS_AGGREGATED));
+
+	ieee80211_sta_register_airtime(sta, tx_sts->tid, tx_airtime, 0);
+
+exit:
+	ieee80211_tx_info_clear_status(txi);
+
+	if (!(le32_to_cpu(tx_sts->flags) & MM81X_TX_STATUS_FLAGS_NO_ACK) &&
+	    !(txi->flags & IEEE80211_TX_CTL_NO_ACK))
+		txi->flags |= IEEE80211_TX_STAT_ACK;
+
+	if (le32_to_cpu(tx_sts->flags) & MM81X_TX_STATUS_FLAGS_PS_FILTERED) {
+		txi->flags |= IEEE80211_TX_STAT_TX_FILTERED;
+
+		/*
+		 * Clear TX CTL AMPDU flag so that this frame gets rescheduled
+		 * in ieee80211_handle_filtered_frame(). This flag will get set
+		 * again by mac80211's tx path on rescheduling.
+		 */
+		txi->flags &= ~IEEE80211_TX_CTL_AMPDU;
+		if (msta) {
+			if (!msta->tx_ps_filter_en)
+				dev_dbg(mors->dev, "TX ps filter set sta[%pM]",
+					msta->addr);
+			msta->tx_ps_filter_en = true;
+		}
+	}
+
+	for (i = 0; i < count; i++) {
+		if (tx_sts->rates[i].count > 0) {
+			r[i].count = tx_sts->rates[i].count;
+			r[i].flags |= IEEE80211_TX_RC_MCS;
+		} else {
+			r[i].idx = -1;
+		}
+	}
+
+	/* single packet per A-MPDU (for now) */
+	if (txi->flags & IEEE80211_TX_CTL_AMPDU) {
+		txi->flags |= IEEE80211_TX_STAT_AMPDU;
+		txi->status.ampdu_len = 1;
+		txi->status.ampdu_ack_len =
+			txi->flags & IEEE80211_TX_STAT_ACK ? 1 : 0;
+	}
+
+	/*
+	 * Inform mac80211 that the SP (elicited by a PS-Poll or u-APSD) is
+	 * over
+	 */
+	if (sta && (txi->flags & IEEE80211_TX_STATUS_EOSP)) {
+		txi->flags &= ~IEEE80211_TX_STATUS_EOSP;
+		ieee80211_sta_eosp(sta);
+	}
+}
+
+void mm81x_rc_sta_state_check(struct mm81x *mors, struct ieee80211_vif *vif,
+			      struct ieee80211_sta *sta,
+			      enum ieee80211_sta_state old_state,
+			      enum ieee80211_sta_state new_state)
+{
+	struct mm81x_sta *msta = (struct mm81x_sta *)sta->drv_priv;
+
+	/* Add to Morse RC STA list */
+	if (old_state < new_state && new_state == IEEE80211_STA_ASSOC) {
+		/* Newly associated, add to RC */
+		mm81x_rc_sta_add(mors, vif, sta);
+	} else if (old_state > new_state && (old_state == IEEE80211_STA_ASSOC ||
+					     old_state == IEEE80211_STA_AUTH)) {
+		/* Lost or failed association; remove from list */
+		mm81x_rc_sta_remove(mors, sta);
+	} else if (old_state < new_state && old_state == IEEE80211_STA_NONE &&
+		   msta->rc.list.prev) {
+		/*
+		 * Special case for driver warning issue causing a sta to be
+		 * left on the list
+		 */
+		dev_dbg(mors->dev, "Remove stale sta from rc list");
+		mm81x_rc_sta_remove(mors, sta);
+	}
+}
-- 
2.43.0


