Return-Path: <linux-wireless+bounces-32260-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qLPrHLoaoWlhqQQAu9opvQ
	(envelope-from <linux-wireless+bounces-32260-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 05:16:58 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C92731B293D
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 05:16:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EE032307CDDC
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 04:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D184E349B00;
	Fri, 27 Feb 2026 04:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="XjIhsJNT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C256A346FC8
	for <linux-wireless@vger.kernel.org>; Fri, 27 Feb 2026 04:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772165642; cv=none; b=f1nyh0NjtbNeqoavhl3mRKT8tF+wAItaUzgH0Gtm/XaI8zif4YKrlh5XOG3taylh337UNUqajblQEB8jPH5HTqy0tJShaskHwGVUVOVHZj5cdQHpsxvu3NQy77qGAOE7R4Cd2S7FTuC16mM/PAX9W18CvavMM4WUWwpJKRoX+JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772165642; c=relaxed/simple;
	bh=XkQGnd4aNDcPvReIRT3oTF8gH+JO+Os42Gx/+yqgSdU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SrbJW2iRzmAGqxVga6LuSemDtKnnzlBWSOWIkIKnEZQIAvd18+iQDXsp/iMJm1hQj5qPHMkG6FSXqJw+O1POfibdjxziwj0JbX4xH9n495eivL9/B+zFsV+PCLQoJLFCP6Dwb8P+UtDFPyN/C5qUhi5v0mqFW9AUOfkoRM+tj8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=XjIhsJNT; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2aaf5d53eaaso11283455ad.0
        for <linux-wireless@vger.kernel.org>; Thu, 26 Feb 2026 20:13:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1772165639; x=1772770439; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RAoaA48fcBfAkvJd540cWIHSPUPMZziBWXifFscryNE=;
        b=XjIhsJNT7jQRrSZOFe1dN3dg/IFBHVDip/Bao4fn55iadkmZl9lX/qzOeiFJdwJO4W
         4aQdvn2VHqgpG49oyVg+05CG9V/VeLFz3ippSMChEVClTdAXlxMnZ8xuB847SQTIjPiS
         dCcFbm9n2rpwRxW55D79YEWP7vsNo9Z+PFPcnod02RqxS3HWQcMqNiGbfB7PCPKPTp9L
         a7/Z547Pjd0KYjSLXrguNKkarvVyxbXC3hJTZkW54DtugJksdmghFDq4yHusT9XszDS2
         cCaFqNGBiMsF1KI45dlgSkPSTjJMT3OK8ME9RfqyNtHpyyIJlw3Q7i37Cx6ww/lkLTne
         qIoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772165639; x=1772770439;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RAoaA48fcBfAkvJd540cWIHSPUPMZziBWXifFscryNE=;
        b=r7saPuuIStmP2J5yE06JLigo+GmsszbVNceCAcL5egJZWSgSbVMAzVymvSdqeSaRaC
         9Iqy3dbKsE0ScbQJxcEescynkvl7KYOlCQisJbJdY04qvHbh84YMUmv4p2x3BruLfc9v
         99X7Xqg7eqD1HUev7u5+gFWwhCYlVNyuXyT32s2QLw7NsUXCIxMZNeYLnurMPw1MElyX
         qOX3n0kGOE29IjXT8nln+pvsQIH/5WGXWAYp+2QW7YjX785BpcU2Ew3B3IrkfnRnUgW5
         2yiqf2ZYSi9n9jfPQWgRJ20K0u9Yx4G55hTtMvyXW29bVqJGfnK1Hpumf7Alo/qPns7l
         lT5Q==
X-Forwarded-Encrypted: i=1; AJvYcCXHt5VydlzaYU+mjDZacKRoFb01oCNKDAZ5dtCapaTF68WXJp/qTQgrz8BRNO8WWVmqhlqyiKYcLgS8+fLfsw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+bqwApkFkrJryi+1n01m+XXlUN4jfa/WzpfyxvziVrifKFsYY
	VVoqGuVhGitkR8g2ZbE0sRymrZ4NPvE2s+ZBRf9dwRDBC1YVXL66yrzeK493wFGZqJY=
X-Gm-Gg: ATEYQzwdavxyrhAvabsL6aeLVpRla3LXfmefkQ9vi4y3rE1F+Sprd1xYOfMZRDqEYL6
	qzVMX2ZPI6WIUFbYNoCdiQs8sOQ+VBY+X/15rNRvVCIUFtbDRREjKF22lRdaJKLjGQ3Bnhi8uSW
	ChjdZ+KBCEa65o1em3eFaHy0iGoy73rGEKZqOn5NLvWKorE5cRZsbAGWhW9Q3/sPr/dXCaZ5Fe1
	rKb9gtA6QGfOoetK4KJjrSi3ZTlSzJOB5rRbJuVARRKuGsKofW1GYD9EQI6RZRv/5qVJmHy0QLH
	mIRX+VPtzSPt9H4Z49+lwp+zbUrx1t4/9zopE+NqZCj7y3bJZovimFcB0s/fkbMH8QCw0kH6OhW
	R3jhDQanCxCIlEPC0O+H6DA28VO2wxYZOBoZBdWa1P5lYpbkWMrIGy6T5jMJ2xN9UF7+Mwxggtk
	oj33LSuNfHm+STahAT1dedbJubyi+/qC8lLw4azMyAN0YCYheeU4+EiMmh90ZiX30cU4j7ShcyK
	5e+2RiIbZ9o1Mrx0A02gtWUk+k+lQA=
X-Received: by 2002:a17:903:1b6b:b0:2ad:c66d:ad08 with SMTP id d9443c01a7336-2ae2e4b5cd6mr15162035ad.42.1772165639046;
        Thu, 26 Feb 2026 20:13:59 -0800 (PST)
Received: from mma-H9MHD44.lan (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb6ba5eesm41682865ad.68.2026.02.26.20.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 20:13:58 -0800 (PST)
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>,
	Dan Callaghan <dan.callaghan@morsemicro.com>,
	Arien Judge <arien.judge@morsemicro.com>
Cc: ayman.grais@morsemicro.com,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH wireless-next 21/35] wifi: mm81x: add rc.c
Date: Fri, 27 Feb 2026 15:10:31 +1100
Message-ID: <20260227041108.66508-22-lachlan.hodges@morsemicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260227041108.66508-1-lachlan.hodges@morsemicro.com>
References: <20260227041108.66508-1-lachlan.hodges@morsemicro.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[morsemicro-com.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[morsemicro.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[morsemicro-com.20230601.gappssmtp.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32260-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lachlan.hodges@morsemicro.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[morsemicro.com:mid,morsemicro.com:email,fixed_rate.ss:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,morsemicro-com.20230601.gappssmtp.com:dkim,fixed_rate.bw:url]
X-Rspamd-Queue-Id: C92731B293D
X-Rspamd-Action: no action

(Patches split per file for review, see cover letter for more
information)

Signed-off-by: Lachlan Hodges <lachlan.hodges@morsemicro.com>
---
 drivers/net/wireless/morsemicro/mm81x/rc.c | 559 +++++++++++++++++++++
 1 file changed, 559 insertions(+)
 create mode 100644 drivers/net/wireless/morsemicro/mm81x/rc.c

diff --git a/drivers/net/wireless/morsemicro/mm81x/rc.c b/drivers/net/wireless/morsemicro/mm81x/rc.c
new file mode 100644
index 000000000000..83954c3e5a4e
--- /dev/null
+++ b/drivers/net/wireless/morsemicro/mm81x/rc.c
@@ -0,0 +1,559 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2017-2026 Morse Micro
+ */
+#include <linux/slab.h>
+#include <linux/timer.h>
+#include "core.h"
+#include "mac.h"
+#include "bus.h"
+#include "debug.h"
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
+	struct mm81x *mm = mrc->mm;
+
+	queue_work(mm->net_wq, &mm->mrc.work);
+}
+
+void mm81x_rc_init(struct mm81x *mm)
+{
+	INIT_LIST_HEAD(&mm->mrc.stas);
+	spin_lock_init(&mm->mrc.lock);
+
+	INIT_WORK(&mm->mrc.work, mm81x_rc_work);
+	timer_setup(&mm->mrc.timer, mm81x_rc_timer, 0);
+
+	mm->mrc.mm = mm;
+	mod_timer(&mm->mrc.timer, jiffies + msecs_to_jiffies(100));
+}
+
+void mm81x_rc_deinit(struct mm81x *mm)
+{
+	cancel_work_sync(&mm->mrc.work);
+	timer_delete_sync_try(&mm->mrc.timer);
+}
+
+static void mm81x_rc_sta_config_guard_per_bw(struct ieee80211_sta *sta,
+					     struct mmrc_sta_capabilities *caps)
+{
+	caps->guard = MMRC_MASK(MMRC_GUARD_LONG);
+
+	if (caps->bandwidth & MMRC_MASK(MMRC_BW_1MHZ)) {
+		caps->sgi_per_bw |= SGI_PER_BW(MMRC_BW_1MHZ);
+		caps->guard |= MMRC_MASK(MMRC_GUARD_SHORT);
+	}
+
+	if (caps->bandwidth & MMRC_MASK(MMRC_BW_2MHZ)) {
+		caps->sgi_per_bw |= SGI_PER_BW(MMRC_BW_2MHZ);
+		caps->guard |= MMRC_MASK(MMRC_GUARD_SHORT);
+	}
+
+	if (caps->bandwidth & MMRC_MASK(MMRC_BW_4MHZ)) {
+		caps->sgi_per_bw |= SGI_PER_BW(MMRC_BW_4MHZ);
+		caps->guard |= MMRC_MASK(MMRC_GUARD_SHORT);
+	}
+
+	if (caps->bandwidth & MMRC_MASK(MMRC_BW_8MHZ)) {
+		caps->sgi_per_bw |= SGI_PER_BW(MMRC_BW_8MHZ);
+		caps->guard |= MMRC_MASK(MMRC_GUARD_SHORT);
+	}
+}
+
+static void mm81x_rc_sta_add_s1g_sta_caps(struct mm81x *mm,
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
+		caps->rates |= MMRC_MASK(MMRC_MCS9) | MMRC_MASK(MMRC_MCS8);
+		fallthrough;
+	case IEEE80211_VHT_MCS_SUPPORT_0_8: /* VHT 8 -> S1G 7 */
+		caps->rates |= MMRC_MASK(MMRC_MCS7) | MMRC_MASK(MMRC_MCS6) |
+			       MMRC_MASK(MMRC_MCS5) | MMRC_MASK(MMRC_MCS4) |
+			       MMRC_MASK(MMRC_MCS3);
+		fallthrough;
+	case IEEE80211_VHT_MCS_SUPPORT_0_7: /* VHT 7 -> S1G 2 */
+		caps->rates |= MMRC_MASK(MMRC_MCS2) | MMRC_MASK(MMRC_MCS1) |
+			       MMRC_MASK(MMRC_MCS0) | MMRC_MASK(MMRC_MCS10);
+		caps->spatial_streams |= (MMRC_MASK(nss_idx) & 0x0F);
+		break;
+
+	default:
+		mm81x_warn(mm, "Invalid MCS encoding 0x%02x for stream %d", mcs,
+			   nss_idx);
+	}
+}
+
+int mm81x_rc_sta_add(struct mm81x *mm, struct ieee80211_vif *vif,
+		     struct ieee80211_sta *sta)
+{
+	struct ieee80211_sta_s1g_cap *s1g_cap = &sta->deflink.s1g_cap;
+	struct mm81x_sta *msta = (struct mm81x_sta *)sta->drv_priv;
+	struct mmrc_sta_capabilities caps;
+	int oper_bw_mhz = cfg80211_chandef_get_width(&mm->chandef);
+	size_t table_mem_size;
+	struct mmrc_table *tb;
+
+	memset(&caps, 0, sizeof(caps));
+
+	mm81x_rc_sta_add_s1g_sta_caps(mm, &caps, s1g_cap);
+
+	/* Configure STA for support up to 8MHZ */
+	while (oper_bw_mhz > 0) {
+		caps.bandwidth |=
+			MMRC_MASK(MM81X_RC_BW_TO_MMRC_BW(oper_bw_mhz));
+		oper_bw_mhz >>= 1;
+	}
+
+	/* Configure STA for short and long guard */
+	mm81x_rc_sta_config_guard_per_bw(sta, &caps);
+
+	/* Set max rates */
+	if (mm->hw->max_rates > 0 && mm->hw->max_rates < IEEE80211_TX_MAX_RATES)
+		caps.max_rates = mm->hw->max_rates;
+	else
+		caps.max_rates = IEEE80211_TX_MAX_RATES;
+
+	/* Set max reties */
+	if (mm->hw->max_rate_tries >= MMRC_MIN_CHAIN_ATTEMPTS &&
+	    mm->hw->max_rate_tries < MMRC_MAX_CHAIN_ATTEMPTS)
+		caps.max_retries = mm->hw->max_rate_tries;
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
+	spin_lock_bh(&mm->mrc.lock);
+	kfree(msta->rc.tb);
+	msta->rc.tb = tb;
+	list_add(&msta->rc.list, &mm->mrc.stas);
+	msta->rc.last_update = jiffies;
+	spin_unlock_bh(&mm->mrc.lock);
+
+	return 0;
+}
+
+static void mm81x_rc_reinit_sta_iter(void *data, struct ieee80211_sta *sta)
+{
+	struct ieee80211_vif *vif = (struct ieee80211_vif *)data;
+	struct mm81x_sta *msta = (struct mm81x_sta *)sta->drv_priv;
+	struct mm81x_vif *mm_vif = ieee80211_vif_to_mm_vif(vif);
+	struct mm81x *mm = mm81x_vif_to_mm(mm_vif);
+	int oper_bw_mhz = cfg80211_chandef_get_width(&mm->chandef);
+
+	if (!msta || msta->vif != vif)
+		return;
+
+	mm81x_dbg(mm, MM81X_DBG_ANY,
+		  "Reinitialize sta %pM with new op_bw=%d, ts=%ld", sta->addr,
+		  oper_bw_mhz, jiffies);
+
+	mm81x_rc_sta_remove(mm, sta);
+	mm81x_rc_sta_add(mm, vif, sta);
+}
+
+void mm81x_rc_reinit_stas(struct mm81x *mm, struct ieee80211_vif *vif)
+{
+	ieee80211_iterate_stations_atomic(mm->hw, mm81x_rc_reinit_sta_iter,
+					  vif);
+}
+
+bool _mm81x_rc_set_fixed_rate(struct mm81x *mm, struct ieee80211_sta *sta,
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
+	spin_lock_bh(&mm->mrc.lock);
+	list_for_each(pos, &mm->mrc.stas) {
+		struct mm81x_rc_sta *mrc_sta =
+			list_entry(pos, struct mm81x_rc_sta, list);
+
+		if (&msta->rc == mrc_sta) {
+			ret_val = mmrc_set_fixed_rate(msta->rc.tb, fixed_rate);
+			break;
+		}
+	}
+	spin_unlock_bh(&mm->mrc.lock);
+
+	if (!ret_val)
+		mm81x_err(mm, "failed, caller %s ss %d bw %d mcs %d guard %d",
+			  caller, ss, bw, mcs, guard);
+
+	return ret_val;
+}
+
+void mm81x_rc_sta_remove(struct mm81x *mm, struct ieee80211_sta *sta)
+{
+	struct mm81x_sta *msta = (struct mm81x_sta *)sta->drv_priv;
+
+	spin_lock_bh(&mm->mrc.lock);
+	if (msta->rc.tb) {
+		list_del_init(&msta->rc.list);
+		kfree(msta->rc.tb);
+		msta->rc.tb = NULL;
+	}
+	spin_unlock_bh(&mm->mrc.lock);
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
+static int mm81x_rc_sta_get_rates(struct mm81x *mm, struct mm81x_sta *msta,
+				  struct mmrc_rate_table *rates, size_t size)
+{
+	int ret = -ENOENT;
+	struct list_head *pos;
+
+	spin_lock_bh(&mm->mrc.lock);
+	list_for_each(pos, &mm->mrc.stas) {
+		struct mm81x_rc_sta *mrc_sta =
+			list_entry(pos, struct mm81x_rc_sta, list);
+
+		if (&msta->rc == mrc_sta) {
+			ret = 0;
+			mmrc_get_rates(msta->rc.tb, rates, size);
+			break;
+		}
+	}
+	spin_unlock_bh(&mm->mrc.lock);
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
+void mm81x_rc_sta_fill_tx_rates(struct mm81x *mm,
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
+	ret = mm81x_rc_sta_get_rates(mm, msta, &rates, skb->len);
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
+static void mm81x_rc_sta_set_rates(struct mm81x *mm, struct mm81x_sta *msta,
+				   struct mmrc_rate_table *rates, int attempts,
+				   bool was_aggregated)
+{
+	struct list_head *pos;
+
+	spin_lock_bh(&mm->mrc.lock);
+	list_for_each(pos, &mm->mrc.stas) {
+		struct mm81x_rc_sta *mrc_sta =
+			list_entry(pos, struct mm81x_rc_sta, list);
+
+		if (&msta->rc == mrc_sta) {
+			mmrc_feedback(msta->rc.tb, rates, attempts,
+				      was_aggregated);
+			break;
+		}
+	}
+	spin_unlock_bh(&mm->mrc.lock);
+}
+
+void mm81x_rc_sta_feedback_rates(struct mm81x *mm, struct sk_buff *skb,
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
+	mm81x_rc_sta_set_rates(mm, msta, &rates, attempts,
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
+				mm81x_dbg(mm, MM81X_DBG_ANY,
+					  "TX ps filter set sta[%pM]",
+					  msta->addr);
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
+void mm81x_rc_sta_state_check(struct mm81x *mm, struct ieee80211_vif *vif,
+			      struct ieee80211_sta *sta,
+			      enum ieee80211_sta_state old_state,
+			      enum ieee80211_sta_state new_state)
+{
+	struct mm81x_sta *msta = (struct mm81x_sta *)sta->drv_priv;
+
+	/* Add to Morse RC STA list */
+	if (old_state < new_state && new_state == IEEE80211_STA_ASSOC) {
+		/* Newly associated, add to RC */
+		mm81x_rc_sta_add(mm, vif, sta);
+	} else if (old_state > new_state && (old_state == IEEE80211_STA_ASSOC ||
+					     old_state == IEEE80211_STA_AUTH)) {
+		/* Lost or failed association; remove from list */
+		mm81x_rc_sta_remove(mm, sta);
+	} else if (old_state < new_state && old_state == IEEE80211_STA_NONE &&
+		   msta->rc.list.prev) {
+		/*
+		 * Special case for driver warning issue causing a sta to be
+		 * left on the list
+		 */
+		mm81x_dbg(mm, MM81X_DBG_ANY, "Remove stale sta from rc list");
+		mm81x_rc_sta_remove(mm, sta);
+	}
+}
-- 
2.43.0


