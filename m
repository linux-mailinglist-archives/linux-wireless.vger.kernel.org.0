Return-Path: <linux-wireless+bounces-38133-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id oWLoCpcdPmr7/wgAu9opvQ
	(envelope-from <linux-wireless+bounces-38133-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2026 08:35:03 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C115E6CAAB0
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2026 08:35:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=morsemicro-com.20251104.gappssmtp.com header.s=20251104 header.b="vl4/ebOi";
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38133-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38133-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=morsemicro.com (policy=none);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D3D523073311
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2026 06:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2230E3DD523;
	Fri, 26 Jun 2026 06:32:46 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E333DBD44
	for <linux-wireless@vger.kernel.org>; Fri, 26 Jun 2026 06:32:43 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782455566; cv=none; b=T5EWDuvCvzfETLQ5AwOnQqsKTRc2Mdyw3HdTefHvdqxNlH4Nitv8/XlR7BTVR1CXBsmK1kTILjrEb6n+aDPAHTyrIx9m4YIJATbTwFMx5Ti4cQyKsU7NyIE4KqSj4WS3YukGbs8Sfo5rl2yhsMTkluqmKYUfxKVSlUZhCkdD7yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782455566; c=relaxed/simple;
	bh=saiskrqRg/kDqXGcJr/FZMd6EDITcxsGmSiPsiyJ/eA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NZ2EEeDqvd38SvUgh8AkknXPBXPK4pmbEfSqboNLxCBzz9WLsqsH5YJrSiBCzM635Xc8Hd0CGgB6lxhz+oJUJCCfIPA1/7byz7VFvpWCSd3RZffAsRDQI9Olf+h6PWka/ToG0MDh4d92Hi+k1VsHYj0n335xVJR4k+rpvu5aCMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20251104.gappssmtp.com header.i=@morsemicro-com.20251104.gappssmtp.com header.b=vl4/ebOi; arc=none smtp.client-ip=74.125.82.47
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-13986d61b4eso1856217c88.0
        for <linux-wireless@vger.kernel.org>; Thu, 25 Jun 2026 23:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20251104.gappssmtp.com; s=20251104; t=1782455563; x=1783060363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ftlJTtwHCXLMyplI6uv1ItiMO+rmbnr8Rj5vkieyP0=;
        b=vl4/ebOic9tqDBuYQts2tgZdP2psP2JAzEhbxc4P1sBIg754ENwSo/tcyUiaYXFB3B
         PFGlfdtZMam8/I70R9lpoXIrTIswX/eVhjUSMjOCZ6f2aA84sSyjHlkvvtdBb4Q8++6n
         JLsLsDCLI6LpH/bt39ta20T1VwmwsgLubHZNYkg07yJ/x4KEX6zQrfq09W62tdGoSrr7
         qexnYrCdDkqqIcM+jVIz9Qtu7a57mzaw84x/wIENl6oJ9tJqgStvNK/nItzYfttjAwff
         zx28w5qlEIok77kLXhBvPb57s51ySC6aLEwcQohFAT6rgbPGjc1kTawLcvooUcfeVIv2
         PP2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782455563; x=1783060363;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4ftlJTtwHCXLMyplI6uv1ItiMO+rmbnr8Rj5vkieyP0=;
        b=nqiWBLfmiGQUor+aAQW1S3Z1CBfKnfcgG0Dr3Vq5qgIxxSe51pozNc7ahwQl5/IQOy
         lqznuQcnupsOmBB4TUER0i4JGbC05QfMWYi0O8H+hI+gyp3vHKaB/4y5vUl9FeObjfVn
         DlLu4M6SyL8KzIDKA686FOcvDC8HBEilkrpoxKFPV7dOlZVlmcSD/IPsbgwHNKa6vVYd
         jqw7RLx7E7Zh3O3mS7qZ259TuzmH2A9oCr+LuS6Zo+5hKbyo8YeepRJ6lSkyqHt+LHn4
         rPhkmscBG1t/Z3ftG/nTX9S5/vjcJKp1ib2QWT3k6PNMiAGwwFMCzg5CVepVkcQLy/mx
         o+4g==
X-Forwarded-Encrypted: i=1; AFNElJ9/5h4DfxJpbeoRGM0FmQohLQfYuU8NJZuFDQHbmIFrocFkUESLa00wpJwya4B/m4UKUGtrGHaOrS/sFEcHiQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyrIbtv+69kNSNF/aM4J/uN0XK/ww2s5nBk34Bd600lZOd7M7Zi
	5AyG0aZ3e0NC1mRHslirLXpei755JFHKPxgrfW+/noXHqgxH3ALnoGeWpwkMQrMP6dI=
X-Gm-Gg: AfdE7cn+Z4+nvLnptr3GlRL+HR28T9Gb81nDk8Cp3oH4JYBi971E51Nktf5jI1G5JA7
	TWRjxJ8U5SUf/wKKfPhfSFslkkI+t19OB/+2mECoWqWnVSQl+XE9+K5zcbc9LYvC0mukOX3WU3i
	cL1ZXqFnJ6s75Owmy68uwF4YCrGWOx6t4hftom3Hxm8eSx4scQ1tpBK7MMJYHkOWqET7QJ17Wxs
	41gGsGkv9DXfQsGpo3XyY+sWYl03cIEXAInEReXlpuJ8GdixpyVnf6ss4gVas2EtZtA+st8Ogaf
	zAIztYqLxir5BhBRrBiFoO3r4GS1fOxYZqZoLW7nJPYrMSIJ4AkVsDMyLwcvZIN1AfH1zdWY5kp
	Oi4Jq++4PtO7h4Vl7aML2PjeJV4dva7H1f52/gfY6uuHslLCdmHH9VhFc2AdHlrKQ+C7Lnnxq5g
	Mzp3gFJzVUW8z6p8mLHbxQQgNbVvyZc8d8y/ImAU8SpwFexzE0R6pP1q3W9mAUtivRrAL7VapKy
	5iHEf20fWgkCxMlyE9D
X-Received: by 2002:a05:7022:4390:b0:138:507:debe with SMTP id a92af1059eb24-139dbac0aadmr4783011c88.14.1782455562885;
        Thu, 25 Jun 2026 23:32:42 -0700 (PDT)
Received: from mma-H9MHD44.lan (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-139d91006bcsm15463687c88.13.2026.06.25.23.32.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 23:32:42 -0700 (PDT)
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>,
	Dan Callaghan <dan.callaghan@morsemicro.com>,
	Arien Judge <arien.judge@morsemicro.com>
Cc: ayman.grais@morsemicro.com,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH wireless-next v3 22/33] wifi: mm81x: add rc.h
Date: Fri, 26 Jun 2026 16:29:18 +1000
Message-ID: <20260626063014.1275235-23-lachlan.hodges@morsemicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260626063014.1275235-1-lachlan.hodges@morsemicro.com>
References: <20260626063014.1275235-1-lachlan.hodges@morsemicro.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[morsemicro-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[morsemicro.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-38133-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:lachlan.hodges@morsemicro.com,m:dan.callaghan@morsemicro.com,m:arien.judge@morsemicro.com,m:ayman.grais@morsemicro.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[lachlan.hodges@morsemicro.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[morsemicro-com.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[lachlan.hodges@morsemicro.com,linux-wireless@vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,morsemicro.com:email,morsemicro.com:mid,morsemicro.com:from_mime,morsemicro-com.20251104.gappssmtp.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C115E6CAAB0

(Patches split per file for review, will be a single commit alongside
SDIO ids once review is complete. See cover letter for more
information)

Signed-off-by: Lachlan Hodges <lachlan.hodges@morsemicro.com>
---
 drivers/net/wireless/morsemicro/mm81x/rc.h | 51 ++++++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 drivers/net/wireless/morsemicro/mm81x/rc.h

diff --git a/drivers/net/wireless/morsemicro/mm81x/rc.h b/drivers/net/wireless/morsemicro/mm81x/rc.h
new file mode 100644
index 000000000000..53f129024408
--- /dev/null
+++ b/drivers/net/wireless/morsemicro/mm81x/rc.h
@@ -0,0 +1,51 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2017-2026 Morse Micro
+ */
+
+#ifndef _MM81X_RC_H_
+#define _MM81X_RC_H_
+
+#include <linux/list.h>
+#include <linux/workqueue.h>
+#include "core.h"
+#include "mmrc.h"
+
+struct mm81x_vif;
+
+#define INIT_MAX_RATES_NUM 4
+
+struct mm81x_rc {
+	/* Serialise rate control queue manipulation and timer functions */
+	spinlock_t lock;
+	struct list_head stas;
+	struct timer_list timer;
+	struct work_struct work;
+	struct mm81x *mors;
+};
+
+struct mm81x_rc_sta {
+	struct mmrc_table *tb;
+	struct list_head list;
+	unsigned long last_update;
+};
+
+void mm81x_rc_init(struct mm81x *mors);
+void mm81x_rc_deinit(struct mm81x *mors);
+int mm81x_rc_sta_add(struct mm81x *mors, struct ieee80211_vif *vif,
+		     struct ieee80211_sta *sta);
+void mm81x_rc_sta_remove(struct mm81x *mors, struct ieee80211_sta *sta);
+void mm81x_rc_sta_fill_tx_rates(struct mm81x *mors,
+				struct mm81x_skb_tx_info *tx_info,
+				struct sk_buff *skb, struct ieee80211_sta *sta,
+				int tx_bw, bool rts_allowed);
+void mm81x_rc_sta_feedback_rates(struct mm81x *mors, struct sk_buff *skb,
+				 struct ieee80211_sta *sta,
+				 struct mm81x_skb_tx_status *tx_sts,
+				 int tx_attempts);
+void mm81x_rc_sta_state_check(struct mm81x *mors, struct ieee80211_vif *vif,
+			      struct ieee80211_sta *sta,
+			      enum ieee80211_sta_state old_state,
+			      enum ieee80211_sta_state new_state);
+
+#endif /* !_MM81X_RC_H_ */
-- 
2.43.0


