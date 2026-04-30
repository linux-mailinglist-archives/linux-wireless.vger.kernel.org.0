Return-Path: <linux-wireless+bounces-35648-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GHAOMg/h8mnyvAEAu9opvQ
	(envelope-from <linux-wireless+bounces-35648-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 06:56:47 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC3849D649
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 06:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AC5F43007A74
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 04:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD49A3624CB;
	Thu, 30 Apr 2026 04:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20251104.gappssmtp.com header.i=@morsemicro-com.20251104.gappssmtp.com header.b="tQPO0t73"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57FD52C2346
	for <linux-wireless@vger.kernel.org>; Thu, 30 Apr 2026 04:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777525001; cv=none; b=qIS+/UwZ5D0hJG6YQEy2ikI7sjcQL8d7pfO5GGprF/3LXpfLzGM0PDhqDudhTRPvW+Loc1MqqKzUiW74SUYU3ckY629VIME6VaGQqRCVUqKemwFCbLYQ2Ub8WaWbrlrh9zVcqH43dvMsCM+8FsBqzCYTILelE/2kmeZV0ydvrtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777525001; c=relaxed/simple;
	bh=8n+BFUdhDsBCw0istxO4mdMmXzGW06N0KXrjfqMuaEo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rOpWosFMOhbaTaWD5VF3FwZsxca8LU27ZxRGc53tyTVAlhihd+6xCj/4NZXmstbynMjzDy0Sfw4JFfmjv61R+suBWt886SliQDV4uCikbVNoFZhJ1LzwpM2Azkc4AjQGCp5La45WOpNOdsYoPcKeioELDRe3oqsDAj1oQyQGtFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20251104.gappssmtp.com header.i=@morsemicro-com.20251104.gappssmtp.com header.b=tQPO0t73; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-82f0884bcfaso377688b3a.1
        for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 21:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20251104.gappssmtp.com; s=20251104; t=1777525000; x=1778129800; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=70b5gHJQ01tflJdtIQ7zVJ9S9n0xaR/1XxJQbiyV9eM=;
        b=tQPO0t73cq2iCruSjKNZDNjQMUz6atoh1uMpWxsHyHo4vCVTRmZFKoP6MpIdIDtgeZ
         QaZ1GsxPtlEcyrIOBPl1bzN0O9lrcRHaYKaUkBxcKMQF9CyDcd7znkiWl+8HuYBio4H0
         44WHTLbN7rEbkOc9LIX7VQOFNjqrSjasgo4msnbi8S9htifmYxUrCIahivudwsn+0myl
         kZlU8m8k/CBYJXyufV4o+xxclfFPMU3XCTW/+kJlVTnwRyuyqz0XQHu0qGnmq3JjDv0W
         ajHh6qH5xvBDUUy+j30GolmFPHeQy8uCwe2MmFsMOU6uD2TJgTxUf2mgcucvdKnVq/39
         ZIYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777525000; x=1778129800;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=70b5gHJQ01tflJdtIQ7zVJ9S9n0xaR/1XxJQbiyV9eM=;
        b=MznyDw1DYFWHElF+0bXjXK8L8dfSElLYVw5UcJaWUfQ2fqQf+fQqW9d0SDNJxKUd7g
         fAFAsMBJCAv6nmD5oIg+aLL5S1DNnXk2y2nkk6LC1X/Czngtvd5Qw2Nryua6dDMOFS2/
         LMHSFL06f1iYgKsrqmkniBjBoUGuiWYI/jzkyCr0JT+UlTcM23KSbizLc9lgp2Ui6aFs
         Z23LHkEQusRh5vI3c+TZAMtk2tdZ2wPciMjHb67tCDRgzvsQlCN+deaJBWjyQ2SqDseL
         nd4Rh6t/ttRs9ISBg7HcL/5LOb0Vmxyvx5ijXioJDh6Z+wR0YguA7daA8fufekLPJRPW
         4K1w==
X-Forwarded-Encrypted: i=1; AFNElJ/NDfVqM0Ks9nF+yyHNuyZ44vDMiM4gjdtYqEgyOfmCFSeX3hYAq6LRRwkNCNu8teHPeSB+bbIalyBMHfQSZw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9rZdiRVXDdkj83DqZf+M7YNq8OQ3ghmzYOlHe5TgtskimnmQh
	fjacfhTMyF2GIgPcGi39mS6qNdACCXDwDYrPdB3ryqzTWT7J/jASTeNonqRmatrhITM=
X-Gm-Gg: AeBDievGXYaE9PZew6hLdTdfJIQjPYR2LRTG/4FLKt/ZyCHVCI5dcGVrumGNdRg9MpU
	6nEcP2OHOUTash9vulTzN9ZcBIg/AnLSl2GWfzh6oWUNt5wrUnRLRIv1DurQDwfjBox5R5p5/J/
	JDlSpZ/u7HonkGZ+nuliVanUZkk2qGFP1/FQkFRL/6QjqL5tdqvTswshOqBYQqTuBWrUOHh8w4B
	AaXB9B+yfFGqXlZGhI76XhavmVDrN+j9Rb7lat7sT2+mNwHQjshjgF2NF6glU6PMBkp8BO3+9Zf
	UzWuIFBrOK/+07jCo21373jpWvwY4NHRr+ih967E1ECB268/Cw6yQ19XWXH75kxVZ26PaFADCkw
	zZuvS73NeLh4PW1NJ0lKUnBQ1jt57sIDtWDdjLJmSUtLKNdGlno5jMSKy6kS+U8RgN7QWG6h9Ok
	q+8HWE/YFgAk3Z9uoWH1Wm+c6qYgmIz3sm9umwWsTikOAdtX3ie/gm+5e6yxfNB9n63Hjxvtl/i
	MYv6JVrBTTvsRHe7fHXD0OF5Da8gNGtSqKMKQkzVQ==
X-Received: by 2002:a05:6a00:1a8b:b0:82f:6e9:d1ba with SMTP id d2e1a72fcca58-834fdc480bcmr1670871b3a.37.1777524999697;
        Wed, 29 Apr 2026 21:56:39 -0700 (PDT)
Received: from mma-H9MHD44.lan (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-834ed80df96sm3595073b3a.54.2026.04.29.21.56.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 21:56:39 -0700 (PDT)
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>,
	Dan Callaghan <dan.callaghan@morsemicro.com>,
	Arien Judge <arien.judge@morsemicro.com>
Cc: ayman.grais@morsemicro.com,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH wireless-next v2 01/31] wifi: mm81x: add bus.h
Date: Thu, 30 Apr 2026 14:55:27 +1000
Message-ID: <20260430045615.334669-2-lachlan.hodges@morsemicro.com>
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
X-Rspamd-Queue-Id: BCC3849D649
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[morsemicro-com.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[morsemicro.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[morsemicro-com.20251104.gappssmtp.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35648-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lachlan.hodges@morsemicro.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

(Patches split per file for review, will be a single commit alongside
SDIO ids once review is complete. See cover letter for more
information)

Signed-off-by: Lachlan Hodges <lachlan.hodges@morsemicro.com>
---
 drivers/net/wireless/morsemicro/mm81x/bus.h | 99 +++++++++++++++++++++
 1 file changed, 99 insertions(+)
 create mode 100644 drivers/net/wireless/morsemicro/mm81x/bus.h

diff --git a/drivers/net/wireless/morsemicro/mm81x/bus.h b/drivers/net/wireless/morsemicro/mm81x/bus.h
new file mode 100644
index 000000000000..d2ccabc037fb
--- /dev/null
+++ b/drivers/net/wireless/morsemicro/mm81x/bus.h
@@ -0,0 +1,99 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2017-2026 Morse Micro
+ */
+
+#ifndef _MM81X_BUS_H_
+#define _MM81X_BUS_H_
+
+#include <linux/skbuff.h>
+#include "core.h"
+
+enum mm81x_bus_type {
+	MM81X_BUS_TYPE_USB,
+	MM81X_BUS_TYPE_SDIO,
+};
+
+struct mm81x_bus_ops {
+	int (*dm_read)(struct mm81x *mors, u32 addr, u8 *data, int len);
+	int (*dm_write)(struct mm81x *mors, u32 addr, const u8 *data, int len);
+	int (*reg32_read)(struct mm81x *mors, u32 addr, u32 *data);
+	int (*reg32_write)(struct mm81x *mors, u32 addr, u32 data);
+	int (*digital_reset)(struct mm81x *mors);
+	void (*set_bus_enable)(struct mm81x *mors, bool enable);
+	void (*config_burst_mode)(struct mm81x *mors, bool enable_burst);
+	void (*claim)(struct mm81x *mors);
+	void (*set_irq)(struct mm81x *mors, bool enable);
+	void (*release)(struct mm81x *mors);
+	unsigned int bulk_alignment;
+};
+
+/*
+ * Default TX alignment for buses which don't care. mac80211 will give us
+ * SKBs aligned to the 2 byte boundary, so 2 is effectively a noop.
+ */
+#define MM81X_BUS_DEFAULT_BULK_ALIGNMENT (2)
+
+/* mm81x_dm_read - len must be rounded up to the nearest 4-byte boundary */
+static inline int mm81x_dm_read(struct mm81x *mors, u32 addr, u8 *data, int len)
+{
+	return mors->bus_ops->dm_read(mors, addr, data, len);
+}
+
+static inline int mm81x_dm_write(struct mm81x *mors, u32 addr, const u8 *data,
+				 int len)
+{
+	return mors->bus_ops->dm_write(mors, addr, data, len);
+}
+
+static inline int mm81x_reg32_read(struct mm81x *mors, u32 addr, u32 *data)
+{
+	return mors->bus_ops->reg32_read(mors, addr, data);
+}
+
+static inline int mm81x_reg32_write(struct mm81x *mors, u32 addr, u32 data)
+{
+	return mors->bus_ops->reg32_write(mors, addr, data);
+}
+
+static inline int mm81x_bus_digital_reset(struct mm81x *mors)
+{
+	if (mors->bus_ops->digital_reset)
+		return mors->bus_ops->digital_reset(mors);
+
+	return 0;
+}
+
+static inline void mm81x_set_bus_enable(struct mm81x *mors, bool enable)
+{
+	mors->bus_ops->set_bus_enable(mors, enable);
+}
+
+static inline void mm81x_bus_config_burst_mode(struct mm81x *mors,
+					       bool enable_burst)
+{
+	if (mors->bus_ops->config_burst_mode)
+		mors->bus_ops->config_burst_mode(mors, enable_burst);
+}
+
+static inline void mm81x_claim_bus(struct mm81x *mors)
+{
+	mors->bus_ops->claim(mors);
+}
+
+static inline void mm81x_bus_set_irq(struct mm81x *mors, bool enable)
+{
+	mors->bus_ops->set_irq(mors, enable);
+}
+
+static inline void mm81x_release_bus(struct mm81x *mors)
+{
+	mors->bus_ops->release(mors);
+}
+
+static inline unsigned int mm81x_bus_get_alignment(struct mm81x *mors)
+{
+	return mors->bus_ops->bulk_alignment;
+}
+
+#endif /* !_MM81X_BUS_H_ */
-- 
2.43.0


