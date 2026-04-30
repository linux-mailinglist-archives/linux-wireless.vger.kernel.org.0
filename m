Return-Path: <linux-wireless+bounces-35656-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mOuWK0Th8mnyvAEAu9opvQ
	(envelope-from <linux-wireless+bounces-35656-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 06:57:40 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B77A349D684
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 06:57:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D39833009819
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 04:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A46A367F32;
	Thu, 30 Apr 2026 04:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20251104.gappssmtp.com header.i=@morsemicro-com.20251104.gappssmtp.com header.b="DYXQR76f"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE8D282F2B
	for <linux-wireless@vger.kernel.org>; Thu, 30 Apr 2026 04:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777525045; cv=none; b=NI9FO4A5vG/dtNhOEzhxCY2ZWzQz4tkQoOYkMAtmXzVxhY9jsJEvpO9F6GGodaisurQl/x7IKhitJ5kvx04XSXjJm2hkdqEgMmgJr6HME87mJmkyofbgmTXqXMRDtJ8I5pbGzIJOkRgndoYpegsXs7lHL1uc6z7ruEgHw7gylE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777525045; c=relaxed/simple;
	bh=9cgrVmILa2osJR/5b2wSJKlz6VohPPL6tweliwJXwpI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aaZtTBjtFQzMLqkzJ7v9a4P6Mvjk8h0PGGTFhrwpf31YzBZt6KYSEF4Gehnh3VKw25wHYppLfOHzRgm4ZtqGTnCQr61rcuMhcnRxBIIPYmEiTbO/OQNcH4AGps9YRwqMYuSDGKtdof/hpJpfqvVRuuLjKKb2FoFlLff9DA2zizA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20251104.gappssmtp.com header.i=@morsemicro-com.20251104.gappssmtp.com header.b=DYXQR76f; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-834f1075805so370594b3a.2
        for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 21:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20251104.gappssmtp.com; s=20251104; t=1777525043; x=1778129843; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7T/9P9GeLp7WaMB4x4lTxH07fOZQmcHmhJKRuB/evVc=;
        b=DYXQR76fyH2+NI4peKGtpBz48nmDO0rQcyxhmIOoDB3n0BhGxcw6AcNCQ2q5ElgJTF
         XY6H+5BxYIXkDtaPYHV3pJRs0hDKJeY0YUk01rFZjMDjjH7tfl0mLJq0W+afNcOY6Vpa
         KeFMYZNnmMe3MjetvlJKiHN3222mJrorrXiOkKJTkxah7MKql84EznzPX7+nA9HWmodm
         fTH/+TU+yekWIGdMjA/V5izmisex9kVWNYv4xXITuLqRgzuMt0BLUIjYIV8zw4XbyJUk
         dnB99x+R74tZ0zWfCMXQA0wjWKCdCvTbaLyHCSQGIOkGloZmHOI3Z8/xI0Ya0MrDONzl
         BYfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777525043; x=1778129843;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7T/9P9GeLp7WaMB4x4lTxH07fOZQmcHmhJKRuB/evVc=;
        b=K058CQUS8bhU70A4JOE9/kUNnY5eNAQP1PTWaBOxjznYE2eJhy2VcfyKgIv3+2TpW3
         d/Vo0R9+arX91IO6pEVYghCFFajpnuGfc1xI0A2xZZZDjg3qE1cmx30ZiFo2AqJMn/B8
         49z8H9KxqIw3dQXCf4YPLXA07qv0XxselIHGHS2/hbE4fom6iQylMxFARO27GXLdEpzI
         vhFzn3SyRYXwW5y5stRGFuJ3TWV3/a/L3ifJqzvywSa0LNE22abKb8rZ7eH0Ut/zOfWQ
         CLk/exOaqZOUwj7McBScyV/lagXCpaqc9Xh8NhA/z2a+yOuOAp94o+9XdHEm2SxzDc5f
         V8rw==
X-Forwarded-Encrypted: i=1; AFNElJ/BKBvfkdNpOsQi0WAX/+nzd4Kj/9GgP5nBrz2MVHSBsvMoLo1Q40sKhfj+6doTx5D9dzkZoQWNVW/k0HMNSA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxyzj7UL8EDDQYsacnBvwKTYp8dBqwA58bsA5zLptRRhIRYKJgE
	1LMAXwmfmwKQMK44TbBC/FmiCOHTsS+th9vholRn7vJiVholQExVzsv41V6KGggI2JBGO/HJgy1
	yi8WX
X-Gm-Gg: AeBDievnVSBCLVchWhKp9vlEsSp639Epbpj1NhBXIAZbSGXF0iVoCAI8k4LXp+5okep
	yJvangB4qDU6Tk5phk/bE0kOPbNh0TkxdL03klsHj3C4ZmKBZRaJhKXqX+kwDwbIO9FbdBwVoiU
	Lr8QGONO1f8tLXB+X43XAqK9x8hthdJAhc0+PDevBciwzfTyxdpJV5LkMCdTA1mEhtR69xWjwBn
	B1i36TALIgnxz8CPE+QBhr7YIJVv0PTGMQUpIhMCJABhoWC7lGMu7zjCq9UjC3flBbozbjwrAXX
	Yp28MI4M7zGHFdx7Ca2yEiqV0qSXFfxUfASQ315JI2I9bC+4lIUBoTlZKOsvVCG8iR6KN/sD7Wj
	Pojk/HnJMHwCjnKXjhGoPDiXhEQX07jkArcA9AcOtkvcUuj7KqJ7SKo+NzDfviGX6OS591fG7bL
	u/EKVCKr6MCNWJieQzh/qo81sFzvDdojP3qX+BNlOQYv7dUD+w96JsmwYkNLxezRW0H1UyrrQ30
	AFcXrbtadmsedtqyPvZ+hZXR7uNDTMFdhh0WEF8cA==
X-Received: by 2002:a05:6a00:1821:b0:82f:964c:e3d0 with SMTP id d2e1a72fcca58-834fdc49ee1mr1883308b3a.39.1777525042434;
        Wed, 29 Apr 2026 21:57:22 -0700 (PDT)
Received: from mma-H9MHD44.lan (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-834ed80df96sm3595073b3a.54.2026.04.29.21.57.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 21:57:22 -0700 (PDT)
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>,
	Dan Callaghan <dan.callaghan@morsemicro.com>,
	Arien Judge <arien.judge@morsemicro.com>
Cc: ayman.grais@morsemicro.com,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH wireless-next v2 09/31] wifi: mm81x: add hif.h
Date: Thu, 30 Apr 2026 14:55:35 +1000
Message-ID: <20260430045615.334669-10-lachlan.hodges@morsemicro.com>
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
X-Rspamd-Queue-Id: B77A349D684
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
	TAGGED_FROM(0.00)[bounces-35656-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[morsemicro-com.20251104.gappssmtp.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,morsemicro.com:mid,morsemicro.com:email]

(Patches split per file for review, will be a single commit alongside
SDIO ids once review is complete. See cover letter for more
information)

Signed-off-by: Lachlan Hodges <lachlan.hodges@morsemicro.com>
---
 drivers/net/wireless/morsemicro/mm81x/hif.h | 117 ++++++++++++++++++++
 1 file changed, 117 insertions(+)
 create mode 100644 drivers/net/wireless/morsemicro/mm81x/hif.h

diff --git a/drivers/net/wireless/morsemicro/mm81x/hif.h b/drivers/net/wireless/morsemicro/mm81x/hif.h
new file mode 100644
index 000000000000..e3d23423049a
--- /dev/null
+++ b/drivers/net/wireless/morsemicro/mm81x/hif.h
@@ -0,0 +1,117 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2017-2026 Morse Micro
+ */
+
+#ifndef _MM81X_HIF_H_
+#define _MM81X_HIF_H_
+
+#include "core.h"
+
+struct mm81x_skbq;
+
+#define MM81X_HIF_BYPASS_TX_STATUS_IRQ_NUM (15)
+#define MM81X_HIF_BYPASS_CMD_RESP_IRQ_NUM (29)
+#define MM81X_HIF_IRQ_BYPASS_TX_STATUS_AVAILABLE \
+	BIT(MM81X_HIF_BYPASS_TX_STATUS_IRQ_NUM)
+#define MM81X_HIF_IRQ_BYPASS_CMD_RESP_AVAILABLE \
+	BIT(MM81X_HIF_BYPASS_CMD_RESP_IRQ_NUM)
+
+/* Hardware IF interrupt mask. We may use any interrupts in this range */
+#define MM81X_HIF_IRQ_MASK_ALL                                       \
+	(GENMASK(13, 0) | MM81X_HIF_IRQ_BYPASS_TX_STATUS_AVAILABLE | \
+	 MM81X_HIF_IRQ_BYPASS_CMD_RESP_AVAILABLE)
+
+enum mm81x_hif_flags {
+	MM81X_HIF_FLAGS_DIR_TO_HOST = BIT(0),
+	MM81X_HIF_FLAGS_DIR_TO_CHIP = BIT(1),
+	MM81X_HIF_FLAGS_COMMAND = BIT(2),
+	MM81X_HIF_FLAGS_BEACON = BIT(3),
+	MM81X_HIF_FLAGS_DATA = BIT(4)
+};
+
+struct mm81x_hif_ops {
+	int (*init)(struct mm81x *mors);
+	void (*flush_tx_data)(struct mm81x *mors);
+	void (*flush_cmds)(struct mm81x *mors);
+	void (*finish)(struct mm81x *mors);
+	void (*skbq_get_tx_qs)(struct mm81x *mors, struct mm81x_skbq **qs,
+			       int *num_qs);
+	struct mm81x_skbq *(*get_tx_cmd_queue)(struct mm81x *mors);
+	struct mm81x_skbq *(*get_tx_beacon_queue)(struct mm81x *mors);
+	struct mm81x_skbq *(*get_tx_mgmt_queue)(struct mm81x *mors);
+	struct mm81x_skbq *(*get_tx_data_queue)(struct mm81x *mors, int aci);
+	int (*handle_irq)(struct mm81x *mors, u32 status);
+	int (*get_tx_buffered_count)(struct mm81x *mors);
+	int (*get_tx_status_pending_count)(struct mm81x *mors);
+};
+
+static inline void mm81x_hif_clear_events(struct mm81x *mors)
+{
+	mors->hif.event_flags = 0;
+}
+
+static inline int mm81x_hif_init(struct mm81x *mors)
+{
+	return mors->hif.ops->init(mors);
+}
+
+static inline void mm81x_hif_flush_tx_data(struct mm81x *mors)
+{
+	mors->hif.ops->flush_tx_data(mors);
+}
+
+static inline void mm81x_hif_flush_cmds(struct mm81x *mors)
+{
+	mors->hif.ops->flush_cmds(mors);
+}
+
+static inline void mm81x_hif_finish(struct mm81x *mors)
+{
+	mors->hif.ops->finish(mors);
+}
+
+static inline void mm81x_hif_skbq_get_tx_qs(struct mm81x *mors,
+					    struct mm81x_skbq **qs, int *num_qs)
+{
+	mors->hif.ops->skbq_get_tx_qs(mors, qs, num_qs);
+}
+
+static inline struct mm81x_skbq *mm81x_hif_get_tx_cmd_queue(struct mm81x *mors)
+{
+	return mors->hif.ops->get_tx_cmd_queue(mors);
+}
+
+static inline struct mm81x_skbq *
+mm81x_hif_get_tx_beacon_queue(struct mm81x *mors)
+{
+	return mors->hif.ops->get_tx_beacon_queue(mors);
+}
+
+static inline struct mm81x_skbq *mm81x_hif_get_tx_mgmt_queue(struct mm81x *mors)
+{
+	return mors->hif.ops->get_tx_mgmt_queue(mors);
+}
+
+static inline struct mm81x_skbq *mm81x_hif_get_tx_data_queue(struct mm81x *mors,
+							     int aci)
+{
+	return mors->hif.ops->get_tx_data_queue(mors, aci);
+}
+
+static inline int mm81x_hif_handle_irq(struct mm81x *mors, u32 status)
+{
+	return mors->hif.ops->handle_irq(mors, status);
+}
+
+static inline int mm81x_hif_get_tx_buffered_count(struct mm81x *mors)
+{
+	return mors->hif.ops->get_tx_buffered_count(mors);
+}
+
+static inline int mm81x_hif_get_tx_status_pending_count(struct mm81x *mors)
+{
+	return mors->hif.ops->get_tx_status_pending_count(mors);
+}
+
+#endif /* _MM81X_HIF_H_ */
-- 
2.43.0


