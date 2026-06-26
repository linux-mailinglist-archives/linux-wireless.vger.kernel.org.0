Return-Path: <linux-wireless+bounces-38122-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vV+LLj4dPmrs/wgAu9opvQ
	(envelope-from <linux-wireless+bounces-38122-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2026 08:33:34 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BD7AB6CAA88
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2026 08:33:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=morsemicro-com.20251104.gappssmtp.com header.s=20251104 header.b=lZ7A9QrV;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38122-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38122-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=morsemicro.com (policy=none);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 18C3430449AB
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2026 06:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E4E63DB32D;
	Fri, 26 Jun 2026 06:31:38 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1862C3DB641
	for <linux-wireless@vger.kernel.org>; Fri, 26 Jun 2026 06:31:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782455498; cv=none; b=iT9xOAyYwmGTcAoqFhyp8vWxR2RWi7kccPS/tICiHnuf/KTpe5jmPj9+iX6i2m22+8W+3wUZto6RmJyBrQq0GAVLAPvbTpYWkJMSVBCV4tXSxi5FonyXFA2k4q3+eLQwcyJ9z3JJ8aSl4xZXvPYiY+tEIVL8i+Z1mRxkZ91Ev4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782455498; c=relaxed/simple;
	bh=9cgrVmILa2osJR/5b2wSJKlz6VohPPL6tweliwJXwpI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R57l6H250uJX0iwJrkSnH1NHHs0vVT8zxk53NHxx5O4E238cy5iTqS7XB7IkCCezUbLTQWXbguUlmBWCoFybQQTSsIJSHO4jtZNKSWCx0gl66q60kk9jWDgO7pQ20gRhbsHfPlV/9PKthtvJDpnDPDa6mgij8hsMK3VXUxydlq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20251104.gappssmtp.com header.i=@morsemicro-com.20251104.gappssmtp.com header.b=lZ7A9QrV; arc=none smtp.client-ip=74.125.82.42
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-13986d61b4fso906528c88.0
        for <linux-wireless@vger.kernel.org>; Thu, 25 Jun 2026 23:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20251104.gappssmtp.com; s=20251104; t=1782455496; x=1783060296; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7T/9P9GeLp7WaMB4x4lTxH07fOZQmcHmhJKRuB/evVc=;
        b=lZ7A9QrVYoCpY75nzoLdPuGm2ZWD6xTofZFJZH3m+fRrrVXBTvPi079MbWJmAlCZaX
         0I9rz+eC2wMJk3UD0cCKMcpue+wu1OdaxY2YdFnXjveQquUSQp7ic1GqK6u4Ycx5UrKY
         xK+z6eVlp3gW5wm7Xpgo1eNMGTwv7YXjoMwsvl16E5FMYLxyJt2XUq/DHGRRYpEHxFOg
         8+Nz3llDDm9LJJpNe8WdAqT3mcfuAd/knAeO3FYJ4uNLtskRrxPi2IZFsfqSndqUjyE6
         7cCUk4C8WrwF+4D6FO2kMwG+cYAGwo8Ff3PYPeyEGjEVFuFmCoDwwX33wGuoORaEC0UB
         wOkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782455496; x=1783060296;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7T/9P9GeLp7WaMB4x4lTxH07fOZQmcHmhJKRuB/evVc=;
        b=MxFUOP+gUdn6CsKAz164PETzDjqcYvO6ee9v4qbTNtcJRjQ/WTcY3kELAIMaa4/WjJ
         rmSYcxSfZuuPsQB6cfNqh7kBh66VYqLUb/lQKxk6NfgwxdROULV0FWjmfqQDPlv6pH8p
         tiCBzym27ADIF+T0m9koJczMUBcFvtI8ab+q6sBA/stnLRu286SXAmXedtoPyHaGu/8O
         vA+96M9Ps2c2RlQ2wo7xAn6lMMchH3AylMO7DRdGhx6IQxAupRNSwNOpf+G98sLj2+cp
         h2j/HEcZ/18+ApdPoMTiDjXtqSj1O0k3FdzpSZAfFJEKXRhQZhzZa7+PmX7jPorNBkNx
         odcg==
X-Forwarded-Encrypted: i=1; AFNElJ8jDEmK731j1ZWojz5oQv+KS+T55GXiLODIIfFob0XMv0Yh4Zv7wiDFj9zlf8aqC2FbMmDXooLCbdqJV/Ctgg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxdX5iCXvtzRs4FqVpPKhzkTPE/rha8mpgxWNqFnp01AhhgLomz
	pysZykljKprWmqO2CCmhboEXEQCbE/4dxoq2EOcuBx6x+TSDZPFYAU6yW2qXO0rII88=
X-Gm-Gg: AfdE7cmZ48CufdC97RQWgiaRLiYBE7B+cBV5dSl7huik9eCt0Wz1BW/ktwVTCKTnpPZ
	TuvNGmLASWTc+s3GkK7QfmfF37aILz7BwQaS/vFmg9FZ00A3GLhzJnHP93Jd5/AgQvcD4xEYEQC
	azzpO5JUKQPwcM/naAZAYbbAFEt4ZafFeecK11Q4t4OBhNrc01e7QMzbOjJIWqvQrK9TU0SF4Ed
	BBQmYjZbAm6APtn8nMgDkcPCddZsWaMwwaNegp24DvSPaH/tVi6mr7rzxJ5dU1alIB3kBME/z37
	NMgAhdnKU/IOzw9bSspxyLqNF8sHGg+mpFVkOa+yVbLwcBwFtfiqv4ShBXuldJDolN8TS4NStLe
	flupey3RUBUIf8rCEmIHLRAH3WH6qddEkX9fDCxwrIEsmca1McZs+1icmb5/QLJ7aiGjLw5jVTW
	FfAnuU5KFz7qr6iJKviprsygHZXs4vCxNJJ3SFhIsJ6F22BZy6wNtjqeUgeTByyRscftm8q6mkD
	XxLXCTQUlfDrUb0XSp0
X-Received: by 2002:a05:7022:ec0c:b0:136:e639:9c05 with SMTP id a92af1059eb24-139dbab9ce7mr4743121c88.31.1782455496238;
        Thu, 25 Jun 2026 23:31:36 -0700 (PDT)
Received: from mma-H9MHD44.lan (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-139d91006bcsm15463687c88.13.2026.06.25.23.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 23:31:35 -0700 (PDT)
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>,
	Dan Callaghan <dan.callaghan@morsemicro.com>,
	Arien Judge <arien.judge@morsemicro.com>
Cc: ayman.grais@morsemicro.com,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH wireless-next v3 11/33] wifi: mm81x: add hif.h
Date: Fri, 26 Jun 2026 16:29:07 +1000
Message-ID: <20260626063014.1275235-12-lachlan.hodges@morsemicro.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[morsemicro.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-38122-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:lachlan.hodges@morsemicro.com,m:dan.callaghan@morsemicro.com,m:arien.judge@morsemicro.com,m:ayman.grais@morsemicro.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[lachlan.hodges@morsemicro.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[morsemicro-com.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[morsemicro-com.20251104.gappssmtp.com:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,morsemicro.com:email,morsemicro.com:mid,morsemicro.com:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BD7AB6CAA88

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


