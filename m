Return-Path: <linux-wireless+bounces-32261-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aI4PLDYboWlhqQQAu9opvQ
	(envelope-from <linux-wireless+bounces-32261-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 05:19:02 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E28B41B2982
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 05:19:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 905E9306D7A4
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 04:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF44B346E40;
	Fri, 27 Feb 2026 04:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="v921LcFN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D99346AC2
	for <linux-wireless@vger.kernel.org>; Fri, 27 Feb 2026 04:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772165646; cv=none; b=lmKWDqz2jDY+cxxeAZ9/6km4xnR3Rn8grNGDSIe01TVq2X+K/nQZhRKRXLORg19syh7cSXWmc3owh9tNdLIPjueANbn6jiVbJ4JQhNLekkRDX0uj/rGZCp2WH86AHSLZIY9o1e6vMc/2n135M0AAoouYIIjyRrXIx6ADeLIzLzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772165646; c=relaxed/simple;
	bh=TqomViDOafziPuuhKX6ARsV3aEW33iQylrUp0kBN5J0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kceQSm4hqqVExD4XEYbP8o0Sel6sbyVA5hfLelcw2Gbzl8DzF18RGi+g1ML9/8VHI5Bty9ddJAoMqZrYwJFca6r3M+QbWR8CnYjFsw7BFX9XTaS6JubSMFk3UaKFZ3LmqtDxTrNMToKtIrXS2lV/dnOIKKJS4zF1KeIbVW0FNZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=v921LcFN; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2a8fba3f769so7779175ad.2
        for <linux-wireless@vger.kernel.org>; Thu, 26 Feb 2026 20:14:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1772165645; x=1772770445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eY+oeQaHzTf80ZfTS6fI7tNwuqaP+ljAM3P8VqeDaZM=;
        b=v921LcFNBZS1I88EO1YQpHBCfZYLiby2lijuYEBSszCZrhiCfMKAg1Tcq9f6HzQ408
         TtHDdgadhDAE7fBEYuriROmmUrAFlk2Pe+7c8W7kjnFk0PaKkvm+NSMWd2YyBGhYllHD
         vCvR+48grme/iykTw7oiYsWbUni8pbpxhfFSHKpx2smzKQil8te+cnleoawldNkw8tk5
         PNlQK0IfnueSLuDgm/HjnVxuxz4/loLrGBsvfEOp6bjOvz6ZXnga9gghjX0J68VF0nDX
         uLNEHIhP3tnifTnMJmhzDllFeCxgMVH+TL9NYZoxMGu9SPOLLbrCXGdaLZ615VPcOAAH
         ziGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772165645; x=1772770445;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eY+oeQaHzTf80ZfTS6fI7tNwuqaP+ljAM3P8VqeDaZM=;
        b=i5F3nW965mYnGjqNhVlRjSWOXUIm3KxUPAbp5+uPegDgtzfBYVpBr+gOcyjVDz15qG
         g0CdwZJwPE34dRNjtI9zb91w603Qk1UtzrvC8pkeFn3XXQiHSpupJr14kZUz2ytcjOBA
         4BPTHSYfptnqqfMuw0ze3Xznvrbez1+xn3k27t1OSs7dnAAo/I/CVrQ4kJpCAsXUoiKn
         Msob/TBHcdT5fZ8W1j2VsCDkuWZWcGGbJoIrUB7oDmT3C2fYFkv7B7a4oXNxeeZU4Fs7
         zOA9nnJbvP3etAyHFK2cvuJdC4XnDZy9B/2VC9abAGz29NQ6hDUtjwqFn0vUdj6gOLUo
         ViYA==
X-Forwarded-Encrypted: i=1; AJvYcCWa7pmZqWb5LTaQ1+k1C9Gq0AyS+vKcxNMf4r2SACZ7jhhuS3cTzmVG2hM/bg0WPSX/Sj+s1VaUygxJlNAveQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YySAgHfU+w4Cv6zU6rPBF6HCirZB3yOLUOdMg2L/3x/MraubUDB
	8JdJfUHzL/WD3IsJ7wxxWVpwMX0xWfhorbh1IcDWSCW7WCFaUrZtFa+FtKEmnBKWG7E=
X-Gm-Gg: ATEYQzyr0p/dz4na68c7vhxo8+htjI+vsYFxwxKjADoEZCKszNgV4HTFOAiDNEBSkPE
	DiRanvdI2OEGyqOWAcymxJ8DTwgvlO4h9MQ01zH/DEBIRmPh20Pv9S0VNEyiZv3pO2g7mtOXMij
	f5ab5KFz7PxgpaidMuXS2YgemagV3hZXwzbSKtW//nOx2tFNlWuvtp4AjITfoQTudreRkhgXMDO
	pkLy20hxlvcF+2RlJszLiC2ol2cXwMpQpGMHEerdLAdWMDHVubRKGHV66u7Gf1/pr2lgFHGo4n5
	je1Z3Q+eB6p3Tt4HzQX9braZ0HEyNxQwyl7cfuqPQ0lFGCeDlJnb1E0jkChbeKpyaUC6WU4CWD+
	xhYhvnzVG/T1Cbnh68ygCLLHIZpoEzd04eq6Z17IjmiyKjN6oT8UrQrr2BFSaszU1vCkYKw2/n3
	jdO7WfDGpJTZtI9FY0Mz7VXstOJXvaol8eY9EkP8JxyXFQfXNI4TNHJ+eqsaz+FJLNOC92FlLrQ
	S/4uKMds/kF372F9vHbxmxLfooPuFo=
X-Received: by 2002:a17:902:c94a:b0:2a0:d34f:aff3 with SMTP id d9443c01a7336-2ae2e3f14fbmr15618275ad.18.1772165644729;
        Thu, 26 Feb 2026 20:14:04 -0800 (PST)
Received: from mma-H9MHD44.lan (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb6ba5eesm41682865ad.68.2026.02.26.20.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 20:14:04 -0800 (PST)
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>,
	Dan Callaghan <dan.callaghan@morsemicro.com>,
	Arien Judge <arien.judge@morsemicro.com>
Cc: ayman.grais@morsemicro.com,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH wireless-next 22/35] wifi: mm81x: add rc.h
Date: Fri, 27 Feb 2026 15:10:32 +1100
Message-ID: <20260227041108.66508-23-lachlan.hodges@morsemicro.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[morsemicro-com.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[morsemicro.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[morsemicro-com.20230601.gappssmtp.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32261-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,morsemicro.com:mid,morsemicro.com:email,morsemicro-com.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: E28B41B2982
X-Rspamd-Action: no action

(Patches split per file for review, see cover letter for more
information)

Signed-off-by: Lachlan Hodges <lachlan.hodges@morsemicro.com>
---
 drivers/net/wireless/morsemicro/mm81x/rc.h | 62 ++++++++++++++++++++++
 1 file changed, 62 insertions(+)
 create mode 100644 drivers/net/wireless/morsemicro/mm81x/rc.h

diff --git a/drivers/net/wireless/morsemicro/mm81x/rc.h b/drivers/net/wireless/morsemicro/mm81x/rc.h
new file mode 100644
index 000000000000..0c391183680b
--- /dev/null
+++ b/drivers/net/wireless/morsemicro/mm81x/rc.h
@@ -0,0 +1,62 @@
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
+	struct mm81x *mm;
+};
+
+struct mm81x_rc_sta {
+	struct mmrc_table *tb;
+	struct list_head list;
+	unsigned long last_update;
+};
+
+void mm81x_rc_init(struct mm81x *mm);
+void mm81x_rc_deinit(struct mm81x *mm);
+int mm81x_rc_sta_add(struct mm81x *mm, struct ieee80211_vif *vif,
+		     struct ieee80211_sta *sta);
+#define mm81x_rc_set_fixed_rate(mm, sta, mcs, bw, ss, guard) \
+	_mm81x_rc_set_fixed_rate(mm, sta, mcs, bw, ss, guard, __func__)
+bool _mm81x_rc_set_fixed_rate(struct mm81x *mm, struct ieee80211_sta *sta,
+			      int mcs, int bw, int ss, int guard,
+			      const char *caller);
+void mm81x_rc_sta_remove(struct mm81x *mm, struct ieee80211_sta *sta);
+void mm81x_rc_sta_fill_tx_rates(struct mm81x *mm,
+				struct mm81x_skb_tx_info *tx_info,
+				struct sk_buff *skb, struct ieee80211_sta *sta,
+				int tx_bw, bool rts_allowed);
+void mm81x_rc_sta_feedback_rates(struct mm81x *mm, struct sk_buff *skb,
+				 struct ieee80211_sta *sta,
+				 struct mm81x_skb_tx_status *tx_sts,
+				 int tx_attempts);
+void mm81x_rc_sta_state_check(struct mm81x *mm, struct ieee80211_vif *vif,
+			      struct ieee80211_sta *sta,
+			      enum ieee80211_sta_state old_state,
+			      enum ieee80211_sta_state new_state);
+
+/*
+ * Reinitialize the associated stations when there is a change in BW.
+ * Must be called with mm->lock held
+ */
+void mm81x_rc_reinit_stas(struct mm81x *mm, struct ieee80211_vif *vif);
+
+#endif /* !_MM81X_RC_H_ */
-- 
2.43.0


