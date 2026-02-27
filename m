Return-Path: <linux-wireless+bounces-32247-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8PmJMcQaoWlhqQQAu9opvQ
	(envelope-from <linux-wireless+bounces-32247-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 05:17:08 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FB5D1B2944
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 05:17:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1D0703079FC0
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 04:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2E5C3451AB;
	Fri, 27 Feb 2026 04:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="rVTm8F17"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F02F335BB4
	for <linux-wireless@vger.kernel.org>; Fri, 27 Feb 2026 04:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772165553; cv=none; b=TIoxTZatSEZj1JvVLejIaK6hJJn6v83euROueBk7dFbM6GD81ynh4wETeSG2p4KibLIju2vkXjFb65TeXAnxL0+JnR3+rCJIb077hsMGOUSaZM5uGrPCPQ7An0fD+YjtaBlJm1lZiCl+9pmxVOL5O7OC4+LcjuIfwYhsKbfRlEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772165553; c=relaxed/simple;
	bh=unQYu2Ohc/MBcYhLoJ/v1Nk9HRmz+c1tEWpPQS5PJCw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fXwdq/gX9UshrQHEixorYoOLOs4WZxO5fif1EfCN5qeqRHogMe7EvX5yDkS6J5gI1W/VjHuCfBdDS+S9mTLK7ISqXv3p9eCDOHTQUkci+F1bQL53ZsWN/G2QCrczmbJQm8JUYFCbCw/rXkyd4MTk41RZCeHxD8TpmKxjQp9orac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=rVTm8F17; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-82735a41920so654166b3a.2
        for <linux-wireless@vger.kernel.org>; Thu, 26 Feb 2026 20:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1772165552; x=1772770352; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7L0FEWRENRY/QG4aQhtjEYuquOlh7K7QFWVjDurvqog=;
        b=rVTm8F17rq+Cs7p9GRhaJD7XnGfvj0eSc1fdy1Ag96jo1oH4Q7cRf1p4rdIu011vCQ
         Dm0acTQbQBlaRROvypf4fgRnBpgO3IGc5Uc21vGUHzNOcHi8lQPpcwlGAxeXFfSx0V0F
         CVjkKbazQv0Sc9ruUflJ1V/Y/cg3qq/gnU+TclpNpuzf70hekKSfUzc4AWpMlYxsaHvw
         SxxHStt1KAEr+OU+JDDjVcl7kdmONWMM2fE1+4+Gsnsdt+mdK6LuS9MxBqXJiFb6tdFh
         gW/Y0xgr1TFROu559O4wYcbv8qeM4kbS/xACBpQpNsoVw66KOjzeyQMPg5Gg/N/x7bBc
         HBnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772165552; x=1772770352;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7L0FEWRENRY/QG4aQhtjEYuquOlh7K7QFWVjDurvqog=;
        b=ac+8O5rnGKrJuzKBfQvqpUVbw7nMSACBGNgKF1wKVFD+688abVHC8RoGISfhVfVoBp
         ks/KD5zbvwvxQmrKzcQRsPzIBqWUUP+KZkmuHf3R9u7bWM29UhInsPxgQ2vsZ34Uuhgg
         xfOPyjDoodCea8B0ZaZ0PB7dh+vYkDt4RY5vsf/ZhnO0tuslsPU+TCVBqxVYDJ2DJ5Dj
         YHN8C217lm39m49BifzPMM+y3Zh2EeubJpBfKo1jErv0bpaBo5zADTPAeCo4LWfg22xw
         J2N9nWdUe3smmmyT0r1ribxVU+YNcDSE1aq/9a7M/D34ExfWZle4tOw6YGAoA4IAk1eL
         FsJw==
X-Forwarded-Encrypted: i=1; AJvYcCUqbiLIEtKAWPgceJYxGvffZUWV+8u11FsRMluMZVKmgwjXG8qYnsj7aR1Qbh4l73c0Ssmlb0DBSd5wrSbcMw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxZy2X6iSAHfLoRiNq1UXhc8ZsbujPf7znsvAho6qeihrmiDfZu
	TesrrNkbsegfR8M3ODwMZZmFGa/wHSyEcxyl9TvEi/93ESVpYn5ZR2/P0r6SAHvmeO/h6JcSK5M
	cP1n8
X-Gm-Gg: ATEYQzw2ddVJVpEErUMYnFWZtPLdn3uq+l0z331w1juz9Drs7/IX5Y1R/Juq0pU/EMJ
	n9HySL0maZt9Y2rEjchvalzwCBiCsFmYmtw1usRt6RTEwd6kto/ISAN0ejTekXfWMqEe28Rs6r2
	qIgGP1Na9TdWWOHuGUMf/V5qsf+2pWHYXjBNOs1b7FZHU0eRjM6/qe8MEmX6O+lANAxC6j2Kg8H
	AZNXD85C4kNWx0Q3ylw3l9l9iVNhxhX7WHjm0IitlhaydQNtPEzGB4l1dD1x5JvwFM0svnMkizj
	beLg4Z+NsRrtYzNOlNZDxPG7wDyIv0AbF9Czdc8iN0t//iZjrudNv6oDSOOaXvXb2T/0It+YpJQ
	bYBXHF3kow+UXdBCNVrd11qf4MjDhSsrTg0xZ7QTCrMTYMAH9GLMHg70RTmNk1HvjTMKIJO108W
	/8Hkm7DlFV8nLFWdMg0yQPHFvgvYNOUuux0MgiOg+QwCjydYRC0OmQgsMjkXaPziRyL9KRgNXS+
	WVytgEsNSeNbmsxEXpkPDCBrYst9l4=
X-Received: by 2002:a05:6a21:3a44:b0:38b:e750:bc27 with SMTP id adf61e73a8af0-395c3b16dcfmr1447944637.58.1772165551915;
        Thu, 26 Feb 2026 20:12:31 -0800 (PST)
Received: from mma-H9MHD44.lan (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb6ba5eesm41682865ad.68.2026.02.26.20.12.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 20:12:31 -0800 (PST)
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>,
	Dan Callaghan <dan.callaghan@morsemicro.com>,
	Arien Judge <arien.judge@morsemicro.com>
Cc: ayman.grais@morsemicro.com,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH wireless-next 08/35] wifi: mm81x: add debug.h
Date: Fri, 27 Feb 2026 15:10:18 +1100
Message-ID: <20260227041108.66508-9-lachlan.hodges@morsemicro.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[morsemicro-com.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[morsemicro.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[morsemicro-com.20230601.gappssmtp.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32247-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,morsemicro.com:mid,morsemicro.com:email,morsemicro-com.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 0FB5D1B2944
X-Rspamd-Action: no action

(Patches split per file for review, see cover letter for more
information)

Signed-off-by: Lachlan Hodges <lachlan.hodges@morsemicro.com>
---
 drivers/net/wireless/morsemicro/mm81x/debug.h | 58 +++++++++++++++++++
 1 file changed, 58 insertions(+)
 create mode 100644 drivers/net/wireless/morsemicro/mm81x/debug.h

diff --git a/drivers/net/wireless/morsemicro/mm81x/debug.h b/drivers/net/wireless/morsemicro/mm81x/debug.h
new file mode 100644
index 000000000000..9f78386c3ab1
--- /dev/null
+++ b/drivers/net/wireless/morsemicro/mm81x/debug.h
@@ -0,0 +1,58 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2017-2026 Morse Micro
+ */
+
+#ifndef _MM81X_DEBUG_H_
+#define _MM81X_DEBUG_H_
+
+#include <linux/device.h>
+#include <linux/printk.h>
+#include <linux/types.h>
+
+struct mm81x;
+
+enum mm81x_debug_mask {
+	MM81X_DBG_FW = BIT(0),
+	MM81X_DBG_MAC = BIT(1),
+	MM81X_DBG_SKBQ = BIT(2),
+	MM81X_DBG_USB = BIT(3),
+	MM81X_DBG_SDIO = BIT(4),
+	MM81X_DBG_ANY = ~0U,
+};
+
+extern unsigned int mm81x_debug_mask;
+
+__printf(2, 3) void mm81x_info(struct mm81x *mm, const char *fmt, ...);
+__printf(2, 3) void mm81x_err(struct mm81x *mm, const char *fmt, ...);
+__printf(2, 3) void __mm81x_warn(struct device *dev, const char *fmt, ...);
+#define mm81x_warn(mm, fmt, ...) __mm81x_warn((mm)->dev, fmt, ##__VA_ARGS__)
+
+#ifdef CONFIG_MM81X_DEBUG
+__printf(3, 4) void __mm81x_dbg(struct mm81x *mm, enum mm81x_debug_mask mask,
+				const char *fmt, ...);
+
+void mm81x_dbg_dump(struct mm81x *mm, enum mm81x_debug_mask mask,
+		    const char *msg, const char *prefix, const void *buf,
+		    size_t len);
+#else
+static inline void __mm81x_dbg(struct mm81x *mm, enum mm81x_debug_mask mask,
+			       const char *fmt, ...)
+{
+}
+
+static inline void mm81x_dbg_dump(struct mm81x *mm, enum mm81x_debug_mask mask,
+				  const char *msg, const char *prefix,
+				  const void *buf, size_t len)
+{
+}
+#endif
+
+#define mm81x_dbg(mm, dbg_mask, fmt, ...)                              \
+	do {                                                           \
+		typeof(dbg_mask) __mask = (dbg_mask);                  \
+		if (mm81x_debug_mask & __mask)                         \
+			__mm81x_dbg((mm), __mask, fmt, ##__VA_ARGS__); \
+	} while (0)
+
+#endif /* _MM81X_DEBUG_H_ */
-- 
2.43.0


