Return-Path: <linux-wireless+bounces-32246-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gNYECZUaoWlhqQQAu9opvQ
	(envelope-from <linux-wireless+bounces-32246-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 05:16:21 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7667F1B2920
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 05:16:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6ABD631982C5
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 04:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 357B2345750;
	Fri, 27 Feb 2026 04:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="lCNepb+k"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB49C34575D
	for <linux-wireless@vger.kernel.org>; Fri, 27 Feb 2026 04:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772165548; cv=none; b=QSjUJviXEjrdeephzDhs7W2HCepukMdvjOr7dF+pG3YY+Tgv9LhlhDG/06p4rv4oAsdk3epa9g2E5szm4KfYM6ukHlRsAHxxDvI/MLW2JzkRrZRrtZ5P4xqWlfBOVg6XWkA+LquDYex5QguWV2dhuPWleRjdwQPtm70D/aD+uaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772165548; c=relaxed/simple;
	bh=uhPvIiRxUKpBpixS8LMdkKCNaB2U0kSZ+jTeXLUOues=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eR7Z4rdVBNA+KzDf7xtPbsb8/00R3w4QanBkgw8HRKlFIovug511tLvM4xA2n/xC1IKK+FQipK1tO11exR04kMiCDJsFFKrMVVODhLkxkpnCaSd3fcXS4Zu23L0EyHg0tIJhXDiC9L0dTpuK7GE7aisK24dSq5SME5q+0mZcjeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=lCNepb+k; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2ab46931cf1so19550425ad.0
        for <linux-wireless@vger.kernel.org>; Thu, 26 Feb 2026 20:12:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1772165546; x=1772770346; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qJdPeZ2EAGcNfbGTpjNeMNRIo91IFcCDcu/vjHqa//8=;
        b=lCNepb+klEL1nRXAYmGv1eUYw8KbApj1uiuRDo/ig+97UfStm/4UUkTo9rZY3/8V0G
         dM6F4OoDWbSrJDWuwmPo2S4NQKcyhDCU03S79cv/MRZJ1jWdFTg6MjmaqNQeOG7GRyvQ
         tPKw+5GmtwDR3NdkT6A8VaP3WFj6yba+JsNlB2S3CxEYDwtPgyOHDSJZUDlEexP5D2u6
         b3Ml3gITg96YSqyTWoFjpG2tdRF3ciOZWm1e8L1wV0QCnIflfTN7yeeMdJjETe138RQh
         U+ETcvDaa43y5ck3saYA13gDc/qb8cbARmDvhEn4vb0NR0ytGhUhKs3MtTpelvmVBzTv
         uy2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772165546; x=1772770346;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qJdPeZ2EAGcNfbGTpjNeMNRIo91IFcCDcu/vjHqa//8=;
        b=Ny8J9rOV/esc+WdUWPBFBxH9YXer2TFrVtD/sD6lwo0GECkgUDOCCwvFg7MTVLhOn3
         K7iz9uIhmuT+b69lieFgkx5oGMO0INz9XobXXqVR6iM4vijypJgQPhtRvnSSkakkJzZ8
         KI3gbaBgeYmPEmeTECN7ZAqJXvmrVL0ADaG+hQBo/aLcN1IcWhvbBbEYWykaq9Vak3U/
         TJe/N9kohPSjMho7IL8yUvlPm7C2wOdt273rbDB5uJM93cnTV/BBJIakyHp8G98SXxrM
         g/h4Qel/e2+Qs39pgS6Zf1E/tnDEjljnNmNS3R3saKJslmbbZtxW60p7gSliXKjqp14x
         JWvg==
X-Forwarded-Encrypted: i=1; AJvYcCVJ/qyQ0JORnjANCHT0wPaYCJqUHeuNWG4h3JAauWmCRrUT/7f+qSWmoB148fR2j22aW+SQd8dv+jSY1UJXIA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyAM9VFXnMXSm9NClcAuoP18KYUdTgGvwufgxO2KHp96147QECV
	lWlU56BYmYsV6/XbBHzR2iUG89TfJdVYiqSMUHaR0QfzYjN1GeMZr5BNMck4vgjCVTs=
X-Gm-Gg: ATEYQzxV81kVqiZVTh1l6XkNdw2ezFAcjwKjxuprCOrKAgfPH56g5sYb8NGqWjOwCCz
	81yACGE4DxBdpUXPfqalpR8ZwfonQmWRKLQJ5Xi+DyXVPJ6vOHsi1mgieiTrxenF7aMxX00pIPk
	/kQPDPXiX3PGFdMMxomhR+cPvBJv4rTUOtW+4Sxpyoe7HeqpK8EUwtlhLCD723W6W1g2kLcYFqi
	ckS34w79Q2DC088Yn4azkvM7NcAR24WyMOPvpIVOLrC8Brhv90ZUeaXl7qryGZjn67jN0aHEI+Y
	jO9wNiuzYvlUylHxZZAWXViADxN8vrrvtjxDvABdwm42yJRtQncpmzxZA80phabd5bl57vZvW9i
	ig/zOSiG0KukGksCXT23b46+w6gti9VVDSevDN5ifPvviB09N7++3++ZtGaOqo8BfYtBwq1J8ko
	UL6IKSglS6dnB163rIiomhsaYTKKgw5h8MfmCbysROy0wvPjHCSxu91aQ5I5g+RZR++IYNZFj1I
	vcPqw5TbNMoi6t2EaQpa2b1maxi0MbLDI9SPp5EKg==
X-Received: by 2002:a17:903:2c0e:b0:2aa:e47d:e3b with SMTP id d9443c01a7336-2adf779a7e4mr52696365ad.0.1772165546317;
        Thu, 26 Feb 2026 20:12:26 -0800 (PST)
Received: from mma-H9MHD44.lan (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb6ba5eesm41682865ad.68.2026.02.26.20.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 20:12:26 -0800 (PST)
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>,
	Dan Callaghan <dan.callaghan@morsemicro.com>,
	Arien Judge <arien.judge@morsemicro.com>
Cc: ayman.grais@morsemicro.com,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH wireless-next 07/35] wifi: mm81x: add debug.c
Date: Fri, 27 Feb 2026 15:10:17 +1100
Message-ID: <20260227041108.66508-8-lachlan.hodges@morsemicro.com>
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
	TAGGED_FROM(0.00)[bounces-32246-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vaf.va:url,morsemicro.com:mid,morsemicro.com:email,morsemicro-com.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 7667F1B2920
X-Rspamd-Action: no action

(Patches split per file for review, see cover letter for more
information)

Signed-off-by: Lachlan Hodges <lachlan.hodges@morsemicro.com>
---
 drivers/net/wireless/morsemicro/mm81x/debug.c | 87 +++++++++++++++++++
 1 file changed, 87 insertions(+)
 create mode 100644 drivers/net/wireless/morsemicro/mm81x/debug.c

diff --git a/drivers/net/wireless/morsemicro/mm81x/debug.c b/drivers/net/wireless/morsemicro/mm81x/debug.c
new file mode 100644
index 000000000000..6c9720fa452c
--- /dev/null
+++ b/drivers/net/wireless/morsemicro/mm81x/debug.c
@@ -0,0 +1,87 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2017-2026 Morse Micro
+ */
+#include <linux/printk.h>
+#include <linux/ratelimit.h>
+#include <linux/stdarg.h>
+#include "core.h"
+#include "debug.h"
+
+void mm81x_info(struct mm81x *mm, const char *fmt, ...)
+{
+	struct va_format vaf = { .fmt = fmt };
+	va_list args;
+
+	va_start(args, fmt);
+	vaf.va = &args;
+	dev_info(mm->dev, "%pV\n", &vaf);
+	va_end(args);
+}
+
+void mm81x_err(struct mm81x *mm, const char *fmt, ...)
+{
+	struct va_format vaf = { .fmt = fmt };
+	va_list args;
+
+	va_start(args, fmt);
+	vaf.va = &args;
+	dev_err(mm->dev, "%pV\n", &vaf);
+	va_end(args);
+}
+
+void __mm81x_warn(struct device *dev, const char *fmt, ...)
+{
+	struct va_format vaf = { .fmt = fmt };
+	va_list args;
+
+	va_start(args, fmt);
+	vaf.va = &args;
+	dev_warn_ratelimited(dev, "%pV\n", &vaf);
+	va_end(args);
+}
+
+#ifdef CONFIG_MM81X_DEBUG
+void __mm81x_dbg(struct mm81x *mm, enum mm81x_debug_mask mask, const char *fmt,
+		 ...)
+{
+	struct va_format vaf;
+	va_list args;
+
+	va_start(args, fmt);
+	vaf.fmt = fmt;
+	vaf.va = &args;
+	dev_dbg(mm->dev, "%pV\n", &vaf);
+	va_end(args);
+}
+
+void mm81x_dbg_dump(struct mm81x *mm, enum mm81x_debug_mask mask,
+		    const char *msg, const char *prefix, const void *buf,
+		    size_t len)
+{
+	const u8 *ptr = buf;
+	char line[256];
+
+	if (!(mm81x_debug_mask & mask))
+		return;
+
+	if (msg)
+		__mm81x_dbg(mm, mask, "%s", msg);
+
+	if (!buf || !len)
+		return;
+
+	while (ptr < (const u8 *)buf + len) {
+		size_t off = ptr - (const u8 *)buf;
+		size_t n = min_t(size_t, 16, (const u8 *)buf + len - ptr);
+		size_t p = 0;
+
+		p += scnprintf(line + p, sizeof(line) - p,
+			       "%s%08zx: ", prefix ? prefix : "", off);
+		hex_dump_to_buffer(ptr, n, 16, 1, line + p, sizeof(line) - p,
+				   true);
+		dev_dbg(mm->dev, "%s\n", line);
+		ptr += n;
+	}
+}
+#endif /* CONFIG_MM81X_DEBUG */
-- 
2.43.0


