Return-Path: <linux-wireless+bounces-35663-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CGulCt3j8ml8vQEAu9opvQ
	(envelope-from <linux-wireless+bounces-35663-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 07:08:45 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8756A49D862
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 07:08:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D06B630B03C0
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 04:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF35236C580;
	Thu, 30 Apr 2026 04:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20251104.gappssmtp.com header.i=@morsemicro-com.20251104.gappssmtp.com header.b="Qu8Bha1j"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80CCB368941
	for <linux-wireless@vger.kernel.org>; Thu, 30 Apr 2026 04:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777525081; cv=none; b=keEv6AvBH2iyOOrDF+4DioTAmGw9fP5d9sdG8lcbb/M5yta159fzOFUpnK20+GMYU8DYRbgKTR/170vw7mx2x+4Nr3CeQooweESEIRdic/cANhfkK5E5MuJt7xw67GqQfpF/PryGwVQpovJUt7UtGNCCnMiarMgz5P/Vs0GYTTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777525081; c=relaxed/simple;
	bh=to6np16T64xFNAcW1qzYMMT0OV6KhI74RWJmQ3sA+pE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ES498bv/SQN+OMF4SFmu352I+Ue2Lu3m/+/eySLeY6dF5UFCA3F4gsz9mlgj8WiJRU7H9ZadrOoVbsSxO72UzFkwtB8SzchzDWuZOyN56vBs090IaTzSzSIV7uwXGDfBhjK9YS4qqx12SMD5DK5Z+dncjsLSfhsJ54h9zVUg0/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20251104.gappssmtp.com header.i=@morsemicro-com.20251104.gappssmtp.com header.b=Qu8Bha1j; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-82cebbdbdccso323788b3a.1
        for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 21:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20251104.gappssmtp.com; s=20251104; t=1777525080; x=1778129880; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c8Yt3MQQ7QZZcK6xo+vjOf0BGbRsje849ZFwtZL+Kfg=;
        b=Qu8Bha1jp6bI+lGreu5u/S9MxQx00jIY9Jbs6DJLVW/c7ZuptQP4a8629zIgqt/rRO
         UyEZbTe+IT+9tcvyZj/ThQFCachiJHnxyLIyqmF0LcG7JIKfmcNPNAdVSnPpS+a5D4JT
         w10RigKAWkED1/S+ovv9sr8LR+WZzZrFbVGBvW6FiDyMTjGfiUzIv5oR3w4SCKYWTGwe
         b2VgKn4ifFJwGTUrCFoX4Gw85jxmTc0rMSXLsT3pFTahoVLyuPcebTE/ziccL+QNJqLO
         ur41mRDHRQYp9F0VMYYngsyuNsnMJtjvRaqwVE5CEQXnMw4oHbJ+5oDE851WE8ymEZ95
         jRUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777525080; x=1778129880;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c8Yt3MQQ7QZZcK6xo+vjOf0BGbRsje849ZFwtZL+Kfg=;
        b=R+79ZGshD7kGR1n0Ong8RVkzPsnEUICgLFyaKdSfQ3p6qxZPLPH9z1UtiHjshe+p/7
         OfV97z9Em5OpLruxynQO1bl7DXaw4qJVLcbW9PkocKkkJEF0+YYqaJuzzfVDLt9I2GqI
         YGzjnAUXLk2kstHMhI9sCe1VRoTB85NwyA9AewhfMa1OJEyFOUzHXKUtP+g/VVut84tr
         AyikBzFCTHz0SlPy0en8WJZvONanZ3pTj5FijskG/x159BbHqG/uMpLtbktWPho3AzZf
         25bA/tCV7aSzgVSrdqEeZAY4IHSGy91Ac/ReuwT9UM30WpFk5BIrCPKqy/yaEWAWM7B4
         s2vA==
X-Forwarded-Encrypted: i=1; AFNElJ/DDaDk3m102kDDAMJ5CMwu2bwE0HFaN40Fd9v9zbsQI5Eplus8txmdbnZV/fqR1Hzf/nr/pbqKVAncEWtirQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxBTp24tWSuYxSzvy0M37ENdJ/TRH+sH36nPrXYqFDHp6zPcuTu
	Ih7a0hNXE5EgPMla4Ew6OpKeVoLwFTBv5FqTinTyronzSrovsppYbFkJNKqhm6CkXfY=
X-Gm-Gg: AeBDievYC49En9fYJ55FzSNEE9t8rXpm4toFLyXNx+zMpEtT9VwZZJ4oH32Ibfjpkc0
	bwqoCf6ky3rcg6DzstQKS8n82q3ibS5PfUVCht+p+2w7B2Srv6EQbVENvYOd2CLpLZYqblyJiXB
	nj5t/obONymPT5HvRxJJ2k742dzbTB17qIuumN/SIPERwoRh+FGQ0IU7SZw4xqPYWHzz/yHs1Ug
	F/bETd0Vg6V8tVsfz/th3i+GFwQidXhVoQNozKmimhvqKWfFtqIUco/p8PcwlxhrSu1a7+YuZDv
	dtDetLCDd/qbqfgvzvHmmZgGuQpPImvbPT0aC4DgM+K8VQsY5edJszjNSpfiByBDQt1yAEk7fHs
	jzigEqnDJN5g33EGs1Zkj3IaX2K2tGnO+dPRq9I6W8+tsj131H590EV9hq6cQcMSFpkGOa3y1VR
	kySN8LEvpNIQeTADZs+ndy8NY76G0oh7YvBO/I3AHdXhavLkLiaR5mPOHhdmyguStE+txcLd8Hd
	Xgw6C+iE6MjLQpjnd+EJOJG9TJEVdGI8tZXJHFB1g==
X-Received: by 2002:a05:6a00:94c2:b0:82f:47ec:944f with SMTP id d2e1a72fcca58-8350014a465mr1043309b3a.16.1777525079848;
        Wed, 29 Apr 2026 21:57:59 -0700 (PDT)
Received: from mma-H9MHD44.lan (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-834ed80df96sm3595073b3a.54.2026.04.29.21.57.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 21:57:59 -0700 (PDT)
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>,
	Dan Callaghan <dan.callaghan@morsemicro.com>,
	Arien Judge <arien.judge@morsemicro.com>
Cc: ayman.grais@morsemicro.com,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH wireless-next v2 16/31] wifi: mm81x: add ps.c
Date: Thu, 30 Apr 2026 14:55:42 +1000
Message-ID: <20260430045615.334669-17-lachlan.hodges@morsemicro.com>
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
X-Rspamd-Queue-Id: 8756A49D862
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[morsemicro-com.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[morsemicro.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[morsemicro-com.20251104.gappssmtp.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35663-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lachlan.hodges@morsemicro.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[morsemicro.com:mid,morsemicro.com:email,morsemicro-com.20251104.gappssmtp.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,delayed_eval_work.work:url]

(Patches split per file for review, will be a single commit alongside
SDIO ids once review is complete. See cover letter for more
information)

Signed-off-by: Lachlan Hodges <lachlan.hodges@morsemicro.com>
---
 drivers/net/wireless/morsemicro/mm81x/ps.c | 120 +++++++++++++++++++++
 1 file changed, 120 insertions(+)
 create mode 100644 drivers/net/wireless/morsemicro/mm81x/ps.c

diff --git a/drivers/net/wireless/morsemicro/mm81x/ps.c b/drivers/net/wireless/morsemicro/mm81x/ps.c
new file mode 100644
index 000000000000..ab67823452ee
--- /dev/null
+++ b/drivers/net/wireless/morsemicro/mm81x/ps.c
@@ -0,0 +1,120 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2017-2026 Morse Micro
+ */
+#include <linux/types.h>
+#include <linux/mutex.h>
+#include <linux/workqueue.h>
+#include "hif.h"
+#include "skbq.h"
+#include "mac.h"
+#include "bus.h"
+#include "ps.h"
+
+static void mm81x_ps_wakeup(struct mm81x_ps *mps)
+{
+	struct mm81x *mors = container_of(mps, struct mm81x, ps);
+
+	if (!mps->enable || !mps->suspended)
+		return;
+
+	mm81x_set_bus_enable(mors, true);
+	mps->suspended = false;
+}
+
+static void mm81x_ps_sleep(struct mm81x_ps *mps)
+{
+	struct mm81x *mors = container_of(mps, struct mm81x, ps);
+
+	if (!mps->enable || mps->suspended)
+		return;
+
+	mps->suspended = true;
+	mm81x_set_bus_enable(mors, false);
+}
+
+static void mm81x_ps_evaluate(struct mm81x_ps *mps)
+{
+	struct mm81x *mors = container_of(mps, struct mm81x, ps);
+	bool needs_wake = false;
+	unsigned long flags_on_entry =
+		(mors->hif.event_flags &
+		 ~BIT(MM81X_HIF_EVT_DATA_TRAFFIC_PAUSE_PEND));
+
+	if (!mps->enable)
+		return;
+
+	needs_wake = (mps->wakers > 0);
+	needs_wake |= (flags_on_entry > 0);
+	needs_wake |= (mm81x_hif_get_tx_buffered_count(mors) > 0);
+
+	if (needs_wake) {
+		mm81x_ps_wakeup(mps);
+		return;
+	}
+
+	mm81x_ps_sleep(mps);
+}
+
+static void mm81x_ps_evaluate_work(struct work_struct *work)
+{
+	struct mm81x_ps *mps =
+		container_of(work, struct mm81x_ps, delayed_eval_work.work);
+
+	if (mps->enable) {
+		mutex_lock(&mps->lock);
+		mm81x_ps_evaluate(mps);
+		mutex_unlock(&mps->lock);
+	}
+}
+
+void mm81x_ps_enable(struct mm81x *mors)
+{
+	struct mm81x_ps *mps = &mors->ps;
+
+	if (mps->enable) {
+		mutex_lock(&mps->lock);
+		if (mps->wakers == 0) {
+			WARN_ON_ONCE(1);
+		} else {
+			mps->wakers--;
+			mm81x_ps_evaluate(mps);
+		}
+		mutex_unlock(&mps->lock);
+	}
+}
+
+void mm81x_ps_disable(struct mm81x *mors)
+{
+	struct mm81x_ps *mps = &mors->ps;
+
+	if (mps->enable) {
+		mutex_lock(&mps->lock);
+		mps->wakers++;
+		mm81x_ps_evaluate(mps);
+		mutex_unlock(&mps->lock);
+	}
+}
+
+int mm81x_ps_init(struct mm81x *mors)
+{
+	struct mm81x_ps *mps = &mors->ps;
+
+	mps->enable = (mors->bus_type == MM81X_BUS_TYPE_USB);
+	mps->suspended = true;
+	mps->wakers = 1; /* we default to being on */
+	mutex_init(&mps->lock);
+	INIT_DELAYED_WORK(&mps->delayed_eval_work, mm81x_ps_evaluate_work);
+
+	return 0;
+}
+
+void mm81x_ps_finish(struct mm81x *mors)
+{
+	struct mm81x_ps *mps = &mors->ps;
+
+	if (mps->enable) {
+		mps->enable = false;
+		cancel_delayed_work_sync(&mps->delayed_eval_work);
+	}
+}
-- 
2.43.0


