Return-Path: <linux-wireless+bounces-38114-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1FvNLswcPmrc/wgAu9opvQ
	(envelope-from <linux-wireless+bounces-38114-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2026 08:31:40 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 353AA6CAA5B
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2026 08:31:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=morsemicro-com.20251104.gappssmtp.com header.s=20251104 header.b=o7AlJ1z7;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38114-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38114-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=morsemicro.com (policy=none);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 20E66309596B
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2026 06:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF40A3B18A;
	Fri, 26 Jun 2026 06:30:50 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8738F239567
	for <linux-wireless@vger.kernel.org>; Fri, 26 Jun 2026 06:30:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782455450; cv=none; b=iwdoz2mYaLxCkY5S/UNjoEbtDOox0lrPrQ6Rte/jL2CtPP1i+1YYA5KcxxKrp6Ad1Y3r0xmhkah86REfU64UZRaiRfpZGQAvVa+5jXzE2X40QkEwFP2PVPUsW91vIKkOTscqiPPowbOVFO4/L4SuZfWFhyvZ18Dml0hOC3trP7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782455450; c=relaxed/simple;
	bh=8n+BFUdhDsBCw0istxO4mdMmXzGW06N0KXrjfqMuaEo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Er8jRVcSP4P1UJYEEnxvpaOUgN2mQp67BA3bDxPH7ynbMYv3KX4mYZf5pXQeNCrFRssrnGBQvJ7S8vjXLc9mQB79WlRERWpbhFahb5jKt1qEfGNLudXvuup/yZsMiLLJtfbGUB8rhHvj+2xKsxHgeUlVR695dS2Rw3YQ9OoI/bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20251104.gappssmtp.com header.i=@morsemicro-com.20251104.gappssmtp.com header.b=o7AlJ1z7; arc=none smtp.client-ip=74.125.82.53
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-137335bc3caso1274853c88.0
        for <linux-wireless@vger.kernel.org>; Thu, 25 Jun 2026 23:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20251104.gappssmtp.com; s=20251104; t=1782455449; x=1783060249; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=70b5gHJQ01tflJdtIQ7zVJ9S9n0xaR/1XxJQbiyV9eM=;
        b=o7AlJ1z7Yx0lhxRyao5aYuko53YL/O7dWFpo7iaQESHqx9xWZtFuOcmdc6JEFHAjlh
         +XloiVIUqMokEKnCFNWXtDVMPld7Sexluyq+16cdtpvktLnbHFa4LekcQokkkP3z090s
         yn0Zbl3mpnu0p4b1g8vZbzTA6XNZLzZPHuVIz19SF5HN6qLdT6PajlbN6QIASMwPgHq3
         /jsqxvJLOGKVVEOyFr5atCTLrkSRsUkgmaG69bTP563d2ma5mNXQ7PLx6LT1avwJr6EQ
         12nqJzNePx0Fxis7p4Q6jQAg88FPocmZOrYw+xdcNXcHK9c+wnCSqct1WQfbqU33dfNy
         tm4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782455449; x=1783060249;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=70b5gHJQ01tflJdtIQ7zVJ9S9n0xaR/1XxJQbiyV9eM=;
        b=SHX9jN/UpTOqWw729LVucKocKoqCz4DRfhjbMP0GNUzPAQNb4tIIJz64lHtDfiwFyv
         iDtxDtG1PHmoDN9ogVrQA1Utc7MDUPuRnV3TDjaEPOGQ/YqNr6L9/mC0N5zN9spRfwNY
         fNjqVtnM9n5rvhrb7jNLtY8R/dpNBJkrtsgVUdMH1lhkVmcrUgxj66wfS6BLGCu+JfyG
         7E74nXD5X4Tlj/iR/agiEleQfpgyIIRE0IsJycFR/O7hwV19oMnVW97thy7T+ZjfiC/Q
         bqZoz/J8lfeCO+nik4a8HYvjkcJVv3RwawOd2AbTKMT7fRJ09BzUmoe02X8i6qvgjkKo
         CVxw==
X-Forwarded-Encrypted: i=1; AFNElJ+yk4aJqqRjoFOL2nycwdkpAJwetYH7b+1N8dVJyBTWst/x4/B10xjG7CcOz9eTZya76P4kU8UmgedMMKCoHw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzX5F157owXhBXGJJiugivqRQjA9Eshj8wfFqsJHF8vXn3dGb+h
	hoHf/Ja/+Go2V5P/U+ZvyAzNuA6tfm1OsRG2UWHeCamUOFmWP8Cfb2he+Chy/qrJ0WY=
X-Gm-Gg: AfdE7cnnsniHguYtf0iG4a/75wo6QwS1l+/1XcXO3jY/OtdzW1gn/IU4Q0KA4d5j7gu
	h3oOuLQCUaA3F328zu1GLkcj2kxCFKTi0zHa65rHZSOAMLKcLH6ZCCAU8rnIDZDwhXwezYkadkX
	3u1DFadtBNmM3Uye3li4IhKFBzboXxgaCNdSNup+boVon498Bds9hOOoHXz3eZqiWGr6WwWDAmU
	VYfIUU+gIwAmfE0CmUkoa8GIekkPQ6EDV2KNX67mJzrTYVbK3S1QLHfkiXsenaqZD+8mzdgxuok
	eEmFE+khIQx9T9sj292Fh3Keu3uKfk+noPQceofOrMJFReFhsxZ893DwbFje1WJ3e8M4bePURxw
	fVg9EuJGTib52kUI1UNGaboglDr1u2WxRiQt1eHM4Y2GNFVYhYFobC03yLwcLYF/AQBE72fnyXN
	hhK341lu2REi+OEy8e9XmLNELsHvKcR8Zt6sdtW0X5vEy3SmtMjgsk2Dc1d/L6UTV1GgX+JOc1c
	gRW0JcdOsddQNQkpl3R
X-Received: by 2002:a05:7022:ff45:b0:139:85c2:d7b7 with SMTP id a92af1059eb24-139dbb1200dmr4715847c88.32.1782455448587;
        Thu, 25 Jun 2026 23:30:48 -0700 (PDT)
Received: from mma-H9MHD44.lan (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-139d91006bcsm15463687c88.13.2026.06.25.23.30.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 23:30:48 -0700 (PDT)
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>,
	Dan Callaghan <dan.callaghan@morsemicro.com>,
	Arien Judge <arien.judge@morsemicro.com>
Cc: ayman.grais@morsemicro.com,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH wireless-next v3 03/33] wifi: mm81x: add bus.h
Date: Fri, 26 Jun 2026 16:28:59 +1000
Message-ID: <20260626063014.1275235-4-lachlan.hodges@morsemicro.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[morsemicro.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-38114-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:lachlan.hodges@morsemicro.com,m:dan.callaghan@morsemicro.com,m:arien.judge@morsemicro.com,m:ayman.grais@morsemicro.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[lachlan.hodges@morsemicro.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[morsemicro-com.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[morsemicro-com.20251104.gappssmtp.com:dkim,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,morsemicro.com:email,morsemicro.com:mid,morsemicro.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 353AA6CAA5B

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


