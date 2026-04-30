Return-Path: <linux-wireless+bounces-35667-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KJUmNePi8mnyvAEAu9opvQ
	(envelope-from <linux-wireless+bounces-35667-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 07:04:35 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4092749D7E1
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 07:04:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9E0B83047BEA
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 04:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F9E9372EE0;
	Thu, 30 Apr 2026 04:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20251104.gappssmtp.com header.i=@morsemicro-com.20251104.gappssmtp.com header.b="sBH6MWMx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714B9372EC6
	for <linux-wireless@vger.kernel.org>; Thu, 30 Apr 2026 04:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777525102; cv=none; b=Tz6Dtx5wfQEoLenwHdtWEG0u9Ty8dC4W1LXc46nLbfMo/zLs6PJG/ytyaaAK/JXDXrmmnyQeSM+Bkl8M/2iOtwDb+8xEz95b/n1NsOY5eGtIc5Mblp6YqCgpy9oiV7/TPqoimMNn2OKWcY/eg00ACrfCkyAKRJtaeTFWn9802YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777525102; c=relaxed/simple;
	bh=U645tARfl/P0ORDY0mdr/ZR+rnYC/AJJ1y7ygKqCr7g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AXKEV2xSVBm/a6bS9yxMD7ppskHoj+4laUi4JEVmUwa+E8Fx+KgTON+ytoi+/3HocHiL8Zk0STG+FYgAtHyLfLhJX6IxnnCwkgUzcFzmdSk4bbF0jSqAyCSzTCfCx513I1YKkEHU+ysHYuBiPzuHZUPgEHFj/oy8WaGay1Zkayo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20251104.gappssmtp.com header.i=@morsemicro-com.20251104.gappssmtp.com header.b=sBH6MWMx; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-82f6b592fc7so216593b3a.3
        for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 21:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20251104.gappssmtp.com; s=20251104; t=1777525101; x=1778129901; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XRAz9mKh/2TTFRFfJjJcbS3Vcqg1dm+gTi4eN+rMaF0=;
        b=sBH6MWMxFePPX4k+HPWQD0HeI0kmljsnVXvrim8Q6q3CPoOG6VMj0TyApREqpx3owW
         uK/xhQ9CCtp0Jx9jSo0xuOciygA3jN59VcSZz9AGzbsvs4iuUDP4KYFpJ21o+QmiEuoG
         lCSWb4r6CesOyw789rg5i4tVR7C0LI3Et0qrr/eJiV03qhROeNQN1ao98UzOoKUJTHPc
         WXe2PlJr3pzWNOKwMpp/307TfF4Q+sCVO02Fbio4d2r2KbV5GUBk5L0ISfSRwisP+Pk/
         g6cgq4BpsU1O8GY2apBk+CL1vZqBWU7FVZw/0Rapuz+U59upQUg4CSSPRuMhTaO2aNGT
         bW3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777525101; x=1778129901;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XRAz9mKh/2TTFRFfJjJcbS3Vcqg1dm+gTi4eN+rMaF0=;
        b=EJyohamEiucbClG2IJZEqwtdM2bYt5OyBnKU4wSQaAKU5fi8Alt+FjEyPHOjTrqt5t
         5m4SaZxcm9hsCrrfWJtxcmQSiH0WoiPWS9/ywsnMzJGEJhoeRRHBLBewZstQmsCgmsql
         4J0pVG1/r1nYowfbr1eBs/8KTTi/XSJODMLSyBYbskMgaPuGsbnjB0fC7ey0E5ph5cle
         dpkVqR9JWtkH0lj2Ji531cCKCpp/aYKlqWmna+5N0LAhzq3vMlEFwQnyhEtEbZ7bVhR+
         +hO98Lcx1lhu99kfgGKUdGVVqOpla/LumQp/Sqr6tjVN2PfRsrXoLpv1ht5pAqNG0Z/z
         8WNw==
X-Forwarded-Encrypted: i=1; AFNElJ8WPCTRVffgUbNWG8mr2//q7TpeQPo7qdyqhtGKOYcFYQO8qAU2UJJyAgcl055Vq7beCYPlXGTvljj4fgOnDg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzc1NyHQVAgAovusxEZETWIGbGU7E9PNuA+BUs9FvBRXh1MSHLf
	GoGrw5OBOP2LVYHnPO4k1koU0eKR4jvehOorsrM4KjDzD7QHLmKjB1QBHDbbkKhLHqQ=
X-Gm-Gg: AeBDiesxWzz7OuBkL8Lz8RFnib0/wnX0j4Fdv4ILPIDxqPQ73SL93FHzPVu5KLM38xV
	33UPUWLuf6/8cOaCGPyYnZdKK5Y3Dh6TK2m0k8fJSHPIexeLQzjuM5o/6q8d4UZOain046cmTz5
	IBWBa3gAUhZHgeu4v90ISKnqN1dvIek5KkgjUISeJ/IYOydweSWMQwZ+CWOCShsk2wlE2N1kfT6
	e6+VSd6bGogUAvZ879LZcEacWFq5O2rDPOYqjfuZKCefYnBcQRzSqa3AP9tIf/UOeOa51JRAllw
	YX77hnvssrAd9K/G99sApPIuVZm0w7laTTVWMKJxGnUDzTRlmpoc+rM2Gcf5YnbGJkkgdUBRI71
	KvJ41cgJY0sp3xLwhnOxHRZUBTgMarEQ56l4lM6K0y0UlqDCpb860EILQTo9fKyPL4dXw27uPtF
	Dvbsroo23nuxGuc1ExDHTJFRdmxXDm23GXb8TFkdRSLYlHFgRAZGBw/TuwMZvxbEGafkhOaJIur
	U5hCTtIw9uinvJB+iHu1x5F7UEOmVNAtZErkmqWjA==
X-Received: by 2002:a05:6a00:2d1a:b0:82f:1d38:f68d with SMTP id d2e1a72fcca58-834fdc6affemr1693460b3a.34.1777525100790;
        Wed, 29 Apr 2026 21:58:20 -0700 (PDT)
Received: from mma-H9MHD44.lan (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-834ed80df96sm3595073b3a.54.2026.04.29.21.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 21:58:20 -0700 (PDT)
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>,
	Dan Callaghan <dan.callaghan@morsemicro.com>,
	Arien Judge <arien.judge@morsemicro.com>
Cc: ayman.grais@morsemicro.com,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH wireless-next v2 20/31] wifi: mm81x: add rc.h
Date: Thu, 30 Apr 2026 14:55:46 +1000
Message-ID: <20260430045615.334669-21-lachlan.hodges@morsemicro.com>
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
X-Rspamd-Queue-Id: 4092749D7E1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[morsemicro-com.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[morsemicro.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[morsemicro-com.20251104.gappssmtp.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35667-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lachlan.hodges@morsemicro.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,morsemicro-com.20251104.gappssmtp.com:dkim,morsemicro.com:mid,morsemicro.com:email]

(Patches split per file for review, will be a single commit alongside
SDIO ids once review is complete. See cover letter for more
information)

Signed-off-by: Lachlan Hodges <lachlan.hodges@morsemicro.com>
---
 drivers/net/wireless/morsemicro/mm81x/rc.h | 57 ++++++++++++++++++++++
 1 file changed, 57 insertions(+)
 create mode 100644 drivers/net/wireless/morsemicro/mm81x/rc.h

diff --git a/drivers/net/wireless/morsemicro/mm81x/rc.h b/drivers/net/wireless/morsemicro/mm81x/rc.h
new file mode 100644
index 000000000000..1a8d76d28c14
--- /dev/null
+++ b/drivers/net/wireless/morsemicro/mm81x/rc.h
@@ -0,0 +1,57 @@
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
+#define mm81x_rc_set_fixed_rate(mors, sta, mcs, bw, ss, guard) \
+	_mm81x_rc_set_fixed_rate(mors, sta, mcs, bw, ss, guard, __func__)
+bool _mm81x_rc_set_fixed_rate(struct mm81x *mors, struct ieee80211_sta *sta,
+			      int mcs, int bw, int ss, int guard,
+			      const char *caller);
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
+void mm81x_rc_reinit_stas(struct mm81x *mors, struct ieee80211_vif *vif);
+
+#endif /* !_MM81X_RC_H_ */
-- 
2.43.0


