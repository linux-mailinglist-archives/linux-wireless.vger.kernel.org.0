Return-Path: <linux-wireless+bounces-32250-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ePJ1AQAaoWlhqQQAu9opvQ
	(envelope-from <linux-wireless+bounces-32250-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 05:13:52 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A54971B28B8
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 05:13:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B41D13064F16
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 04:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A59543370F4;
	Fri, 27 Feb 2026 04:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="z3UoKYrJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6345F345CA1
	for <linux-wireless@vger.kernel.org>; Fri, 27 Feb 2026 04:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772165572; cv=none; b=eDySRGQLBPxGBOZk9JKSAkEzhlkLr0Ap8fQ5srHcI9NxnH0OYfGwAXE1cyKEGLuMStsAF1U/3lkX3T0aQ4ig5YQoZVPSpf0hQ8zbdz4Nl1APqyiKzPqxGOJpEVBuMFg9ZrXsFuKazL6aLRn3ZXTphUQzzlIff+TxBKU/XmGh5a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772165572; c=relaxed/simple;
	bh=0hpMqC7iN1GU6/HGSB7LTfJeMBImyzsfLpG74B8WG/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ht/vLoUSgXpW8xzjcYcrusWfNBoOvJMpCGpO43joh2iLy/pjkBDk6wpRzkwajJ4ByllhFnuxZyQbrB2ASwnOJyPcLaucxnKYZTQjsnIb+vZB2l+B93Wlom2QwNsS5EF/HUdGVZJAXLJgmy/5QQR7WUHdDVWz4tyUlo7MYEQrCIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=z3UoKYrJ; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ade574f05eso11129395ad.3
        for <linux-wireless@vger.kernel.org>; Thu, 26 Feb 2026 20:12:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1772165571; x=1772770371; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yVZ6jZaREZIiz226cNa+rAmRJUyjsVN1xL65upg+7t0=;
        b=z3UoKYrJX67BOYU46lRUTdazGNW5w7lPswrHNYhBAsW2IycRmZOCrAouzI3x3bbook
         TV2dHzioAqJXM1aEeqOpT9RBtBBCeGRX3Rtmb41zR/6Z01fcYgVsrWGM8z3TIoUoMK8Q
         +DvgBOJwsYus7nj1kbf4i/RMOvt0rKqfBsBcnKgNxTNZqf4UOOAz8imtxu2YJ6pRU/B1
         B8a4D76NKd5/1o29ISpwy3BtZ0f45YBV7xlKYeeU+HDFYwpAwfl0i1dIW2a7v9BuH8nX
         F+IX7W3eYLNBfWvwHqTuje5kZW2nz7QleQUnmtk72HuWBLx8+Cffbe3JTBXrmQ/P58qS
         yeQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772165571; x=1772770371;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yVZ6jZaREZIiz226cNa+rAmRJUyjsVN1xL65upg+7t0=;
        b=ZSZpZZ56sL12vclkoX6gf4yCthpk5mOEutQSRSrI/iUpWimLOIvRIeagDJnApWk6Oe
         MviZWwpfIlCICfdkVRyb8eGeQpCaOJyAp1Cdh7HYVJGSDPz6FKIak/fSY80dL/LHarkQ
         8kjXmuV1CtKkr7DQ2N7ZYPcw6K+r1HStd6O5oRGMC0TcHaxCAc+dpXz763xcqSSgR7IJ
         Qs+D2A7yRSJQfka3iOAQVDhXk1Ha0xubU2aQ1qq7CHa1/d3sWbjp//CpMHrbwQWjJc6D
         FA2w6iDfYL50g7aRkRaVbRYrPqq9fyEBUMFCWD4Z5cb88r1XPQsTdUBg/bGOiH2Z4O8y
         lJvA==
X-Forwarded-Encrypted: i=1; AJvYcCWzlFLrpMaEPQ1lTW1GOSIMU/ZxNOkRT4kVAOQlh/cxN8ksK9r7ZirIwLL83HGK1+s8VOkaGQOdsS+7Z0j6jg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8DmcvvBRc0CnNLel6hoQagn8R69UiAiqTj4dPW04I97GUHwem
	1MvzBPqrRxt8Q9YDPo+kVJZJJ4rbwOKG1eyMYeDej12kFztaCWbTOd3LLYkMklV6dB8=
X-Gm-Gg: ATEYQzz2Q2DjsWJnTZYNgDpNbUdmeZJQS4rNSA35AK9ETdewRfTv1EV+vIBPyVFJzIF
	TtAk28TVYIee+xueIT8yguNDHRcU9L1fcArppAnElMRAGdfILCfl0HkxCUHpm51/GKBxUfjgkOm
	OhP/iRkjVlgXgOhSlLFPHT15IThWp60AJ6HJ/yHKhM7BkvdRQx7sQofEStTl4uZh6IMxDyJD44u
	I1BJpG/o/QCBuVQuU3PB1az2k2Q0ITZN0a+4DSC6FNMKnUEhw38IUBFAmjJYL3faCGfgeY+SfuK
	FupYhJIAjJqSjeZ/4XCai00Croi/1KhKjlSS887qLVz/ESxhx1ZSglEWEQcjNUy4FvfoBvCey3C
	93L+CGpSnfwonrtOqt38v3tSzbshBRRl7IeX1cvunHBvCI+7IEExy8nSl/fvMyRYioBwsaM08hT
	MQl+4p8caQVxaa8RdCB1Qb0evxLhjQS+5H4oTl27uJzHxg/PMDEGJ7Gm0lkRHLsphupSiV4pli4
	JkbZl5egkb7y3F2hPjqMaPgwCmsUIQ=
X-Received: by 2002:a17:902:8210:b0:2aa:e3c2:f925 with SMTP id d9443c01a7336-2ae2e47e0a1mr8851875ad.34.1772165570786;
        Thu, 26 Feb 2026 20:12:50 -0800 (PST)
Received: from mma-H9MHD44.lan (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb6ba5eesm41682865ad.68.2026.02.26.20.12.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 20:12:50 -0800 (PST)
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>,
	Dan Callaghan <dan.callaghan@morsemicro.com>,
	Arien Judge <arien.judge@morsemicro.com>
Cc: ayman.grais@morsemicro.com,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH wireless-next 11/35] wifi: mm81x: add hif.h
Date: Fri, 27 Feb 2026 15:10:21 +1100
Message-ID: <20260227041108.66508-12-lachlan.hodges@morsemicro.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[morsemicro-com.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[morsemicro.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[morsemicro-com.20230601.gappssmtp.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32250-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lachlan.hodges@morsemicro.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,morsemicro.com:mid,morsemicro.com:email,morsemicro-com.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: A54971B28B8
X-Rspamd-Action: no action

(Patches split per file for review, see cover letter for more
information)

Signed-off-by: Lachlan Hodges <lachlan.hodges@morsemicro.com>
---
 drivers/net/wireless/morsemicro/mm81x/hif.h | 116 ++++++++++++++++++++
 1 file changed, 116 insertions(+)
 create mode 100644 drivers/net/wireless/morsemicro/mm81x/hif.h

diff --git a/drivers/net/wireless/morsemicro/mm81x/hif.h b/drivers/net/wireless/morsemicro/mm81x/hif.h
new file mode 100644
index 000000000000..73c23a39d14b
--- /dev/null
+++ b/drivers/net/wireless/morsemicro/mm81x/hif.h
@@ -0,0 +1,116 @@
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
+	int (*init)(struct mm81x *mm);
+	void (*flush_tx_data)(struct mm81x *mm);
+	void (*flush_cmds)(struct mm81x *mm);
+	void (*finish)(struct mm81x *mm);
+	void (*skbq_get_tx_qs)(struct mm81x *mm, struct mm81x_skbq **qs,
+			       int *num_qs);
+	struct mm81x_skbq *(*get_tx_cmd_queue)(struct mm81x *mm);
+	struct mm81x_skbq *(*get_tx_beacon_queue)(struct mm81x *mm);
+	struct mm81x_skbq *(*get_tx_mgmt_queue)(struct mm81x *mm);
+	struct mm81x_skbq *(*get_tx_data_queue)(struct mm81x *mm, int aci);
+	int (*handle_irq)(struct mm81x *mm, u32 status);
+	int (*get_tx_buffered_count)(struct mm81x *mm);
+	int (*get_tx_status_pending_count)(struct mm81x *mm);
+};
+
+static inline void mm81x_hif_clear_events(struct mm81x *mm)
+{
+	mm->hif.event_flags = 0;
+}
+
+static inline int mm81x_hif_init(struct mm81x *mm)
+{
+	return mm->hif.ops->init(mm);
+}
+
+static inline void mm81x_hif_flush_tx_data(struct mm81x *mm)
+{
+	mm->hif.ops->flush_tx_data(mm);
+}
+
+static inline void mm81x_hif_flush_cmds(struct mm81x *mm)
+{
+	mm->hif.ops->flush_cmds(mm);
+}
+
+static inline void mm81x_hif_finish(struct mm81x *mm)
+{
+	mm->hif.ops->finish(mm);
+}
+
+static inline void mm81x_hif_skbq_get_tx_qs(struct mm81x *mm,
+					    struct mm81x_skbq **qs, int *num_qs)
+{
+	mm->hif.ops->skbq_get_tx_qs(mm, qs, num_qs);
+}
+
+static inline struct mm81x_skbq *mm81x_hif_get_tx_cmd_queue(struct mm81x *mm)
+{
+	return mm->hif.ops->get_tx_cmd_queue(mm);
+}
+
+static inline struct mm81x_skbq *mm81x_hif_get_tx_beacon_queue(struct mm81x *mm)
+{
+	return mm->hif.ops->get_tx_beacon_queue(mm);
+}
+
+static inline struct mm81x_skbq *mm81x_hif_get_tx_mgmt_queue(struct mm81x *mm)
+{
+	return mm->hif.ops->get_tx_mgmt_queue(mm);
+}
+
+static inline struct mm81x_skbq *mm81x_hif_get_tx_data_queue(struct mm81x *mm,
+							     int aci)
+{
+	return mm->hif.ops->get_tx_data_queue(mm, aci);
+}
+
+static inline int mm81x_hif_handle_irq(struct mm81x *mm, u32 status)
+{
+	return mm->hif.ops->handle_irq(mm, status);
+}
+
+static inline int mm81x_hif_get_tx_buffered_count(struct mm81x *mm)
+{
+	return mm->hif.ops->get_tx_buffered_count(mm);
+}
+
+static inline int mm81x_hif_get_tx_status_pending_count(struct mm81x *mm)
+{
+	return mm->hif.ops->get_tx_status_pending_count(mm);
+}
+
+#endif /* _MM81X_HIF_H_ */
-- 
2.43.0


