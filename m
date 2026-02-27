Return-Path: <linux-wireless+bounces-32258-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uO2pI5UaoWlhqQQAu9opvQ
	(envelope-from <linux-wireless+bounces-32258-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 05:16:21 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A6DD1B2927
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 05:16:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 36A2F3079ABF
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 04:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27EC7346AEB;
	Fri, 27 Feb 2026 04:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="ShDgD9E4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049EF3469FA
	for <linux-wireless@vger.kernel.org>; Fri, 27 Feb 2026 04:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772165630; cv=none; b=R62gybGbViTaWDxyb5fuOQca3OlC23zgxr8W9jJuSpictbQS8EX0vAZtxbBmq4gj9uiWAkoMUPR0+RjyjQkDGEjjQDUKkLUCSlEcCQKWJw4OylGxmU/HGlzH0vXZmvVXvEw7NZ8OMX0UogAnE2+bVCH8MrDtVE1phZ3j7sI3bZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772165630; c=relaxed/simple;
	bh=sQhx412N54DaE5xn5CGb102Bn4qxRwURUoEqZz/dREA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lU3+fZGL0gk/QNy3tQ+EHvCYb2Jat/wGquzpCSTKDKIa8cqaXBeBNIUaqo6Er+UeIbjqnSiV0SqwK0Ohka76CGw7ez51rg0VLM0G7YJIdDmKjvQ7Wcy3WR4NxBgfQ+sQUbGCpZ1E+nieqVzEUQ4j4OPD7wxpwtqAIcuM3U8rR4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=ShDgD9E4; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-82748095892so478919b3a.0
        for <linux-wireless@vger.kernel.org>; Thu, 26 Feb 2026 20:13:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1772165627; x=1772770427; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6TyY5H+SZ6iaT3CpD1Je8BXonYWi4uPcgKw0zcn9P3k=;
        b=ShDgD9E4fdRXQJqhUgp64iz+sPEySjgdtw+51iQ3PYCvQ8uIau7igmrBPAH86lskIj
         9Xu3w/7tETBebKtKJQ9pELF5nUbNq4DCx3ZehDE0HMR2lxONCcUA3vPQBHc2PEhXhx0L
         qN7Uby+9W+DX/l14/UEODf5MHiGpC68KoxYvL3Qc0BlbkwmzrfawLSoNfHa8HJexfO8x
         qI3qH/LM7bTsUtEjwwP4GRaIXe6ulYYZ3B70A06IsAonvkq5rMabCGOMJktmSjFBufyL
         6Bmc4hTSEYVl7JTlzRzHRUtk5Bhg8QtE+g4RTJqH2kcBCeaB30BNLbtOHFebu/zIWdx4
         yxOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772165627; x=1772770427;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6TyY5H+SZ6iaT3CpD1Je8BXonYWi4uPcgKw0zcn9P3k=;
        b=kn5318bJhbZOR3BVHZQ45EIS0yIfrEcxPr8hujXOI91tyFCbLvm1WN+hW/hILQfnts
         MmEGxWWujlqze8Dzn5/jVhhRKzMPYw9p4796NewOmIgRT2+1zRKXktNTLEQw0QOvAGGS
         zTMan/woa8+//KFbME/Lw6T/beNEWXc2KNAevnMzq40EYIiKTxjlEken9S3GiMGD4ePi
         Jb0r/Cxzh6pSDiPqKQnTUXQBZGbt1OmYUqK/FpvXO7D/TYzT0l4rC9FNPHz0MeFgZZ8o
         dT/82aWammDPSPAWTzTLW6IQJqBtdHkk5OHG72VWMQaIuE2lS59/w9czxYTuCBRkUmTY
         lILg==
X-Forwarded-Encrypted: i=1; AJvYcCV3+a09IQKRPpzH41ehmUJkXV7p7LAfhq6tPSNfEAfVWWJrnA7gaV8LeXdIw9qfWRMC1kspCXFadk98/BbxGg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxDtf3R4HoZgxLqhwVEVTF1RTU+2u9Cj7pHnGxK71rthTvZPVDn
	Eu+gnnCk35UNA7OBfjRrwDD2I2SJVBMcTCWYVBJrb+5s5iP+c/h+WHMn8z04JRLXgdY=
X-Gm-Gg: ATEYQzzWbXBNpXEUCuah5hHhI4jlKzAxjPQ7PbMAtNvNiPDH2MilxSlhXWxkbHBnQ2U
	TX+EFYkbgM/ZGoDahIugiIYJdzVIeWN5Zd81KM1fntW7gCUnAi41T0mZ7FaJGa9H6oPJyOawbSS
	zSj/DOWe+ULyfiP1zs0+yFf/5Yx+0NZFjTv3G+VNsSD6ARYKVdeOYvuiVThLkTClW9m2dkK4VC4
	toHAfWvicNdkcKuck7CekPCjtXk4aGE7wMje+3PsK1w9iEc4zv8kU9ssEcC+qdl9ki1vKb66sGG
	RRLBG6ayHNxytb1yDR5HFCVSdfZm9d1eGwE34b3bTXWUzx4YrkOxFvEte8lvLOITVKFhunfTCiK
	+JlT1Ka1mp2rRDWCVgJkzcymAInjipeMB+grC//cmAmkWJaX9zVebiDjwkPuMWVQjznfcTBvVyu
	QQUAvFZDdk5H6KdAjhoEued+xS1K1lqaxjhDAMwgxJTP9qZdmSR0D9hN+zNFJMPy9GiGqXrlgan
	9wpfNczM7iQz2y442D/T0vAG/FXdqY/eXnT6uTLbw==
X-Received: by 2002:a05:6a20:56a3:b0:38d:efcb:2e8a with SMTP id adf61e73a8af0-395c3b41486mr1358656637.68.1772165627448;
        Thu, 26 Feb 2026 20:13:47 -0800 (PST)
Received: from mma-H9MHD44.lan (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb6ba5eesm41682865ad.68.2026.02.26.20.13.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 20:13:47 -0800 (PST)
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>,
	Dan Callaghan <dan.callaghan@morsemicro.com>,
	Arien Judge <arien.judge@morsemicro.com>
Cc: ayman.grais@morsemicro.com,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH wireless-next 19/35] wifi: mm81x: add ps.h
Date: Fri, 27 Feb 2026 15:10:29 +1100
Message-ID: <20260227041108.66508-20-lachlan.hodges@morsemicro.com>
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
	TAGGED_FROM(0.00)[bounces-32258-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,morsemicro.com:mid,morsemicro.com:email,morsemicro-com.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 7A6DD1B2927
X-Rspamd-Action: no action

(Patches split per file for review, see cover letter for more
information)

Signed-off-by: Lachlan Hodges <lachlan.hodges@morsemicro.com>
---
 drivers/net/wireless/morsemicro/mm81x/ps.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 drivers/net/wireless/morsemicro/mm81x/ps.h

diff --git a/drivers/net/wireless/morsemicro/mm81x/ps.h b/drivers/net/wireless/morsemicro/mm81x/ps.h
new file mode 100644
index 000000000000..6a33efa2cdb7
--- /dev/null
+++ b/drivers/net/wireless/morsemicro/mm81x/ps.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2017-2026 Morse Micro
+ */
+
+#ifndef _MM81X_PS_H_
+#define _MM81X_PS_H_
+
+#include "core.h"
+
+/* This should be nominally <= the dynamic ps timeout */
+#define NETWORK_BUS_TIMEOUT_MS (90)
+
+/* The default period of time to wait to re-evaluate powersave */
+#define DEFAULT_BUS_TIMEOUT_MS (50)
+
+void mm81x_ps_disable(struct mm81x *mm);
+void mm81x_ps_enable(struct mm81x *mm);
+int mm81x_ps_init(struct mm81x *mm);
+void mm81x_ps_finish(struct mm81x *mm);
+
+#endif /* !_MM81X_PS_H_ */
-- 
2.43.0


