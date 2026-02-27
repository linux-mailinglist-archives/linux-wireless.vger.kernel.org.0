Return-Path: <linux-wireless+bounces-32240-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iP08LoQZoWlhqQQAu9opvQ
	(envelope-from <linux-wireless+bounces-32240-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 05:11:48 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 608E91B284A
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 05:11:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A3DAC304D579
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 04:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E8CB341AB1;
	Fri, 27 Feb 2026 04:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="vwpPG05P"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E224345750
	for <linux-wireless@vger.kernel.org>; Fri, 27 Feb 2026 04:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772165507; cv=none; b=vFZDGWwm/xSqEHduPuIW5T6UVmLlE7TmmTvW1oqISjCKq+OVSgxr5EeuYCwOmpAiGEatN48Hhdvjglg4Iv/d99YmuiEC2nA//a982Mh4hhHsq4j2fgBMqyJ7piZB4rUh5m5gstEfIoVuNY7ZcC+nH0BUC/pVpGqWMf9d6Zzv3Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772165507; c=relaxed/simple;
	bh=c11IXnwxZ5RyIrOBBd15Hk6g/iseO2KVv2j6YYLopzE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YUMSUoaTo3veWVRZBLe/rEUXnMMzXoN7VWfivK6FgVgY9hfpQHcUQGCmnnvsiQNEAZCGsIn1LlP02Pw54tX8mfTA2zhtmI+csCfsvIyEdTLBgXyyKipOeDEtVZlZCX+6AP/dwr2m+fGP1MS2faqE2RRjWBonAIlcsQAU3gQ14gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=vwpPG05P; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2a871daa98fso12467635ad.1
        for <linux-wireless@vger.kernel.org>; Thu, 26 Feb 2026 20:11:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1772165505; x=1772770305; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CxqowGzg2CaK2KHQ3yg4HgobTjZp7H6lsiRmrF05V2E=;
        b=vwpPG05P0upqUe01e0G/ZAGrLDINji7K/ZdZtOL7hRZ+zUH2rmbEDeR+dVp6eQMago
         HzkIS7Wkz9epB1tbD7OqeznMQHM6co6GyNl+UFw+FyG/aMj5RisBm2f4ecu2qLZHHoBR
         2mVsqkDwfLxUCpzLciVGZWKejZhHNLIZil9X8j+NUk/jRuHhGdlcdJfbJFZzET/V7Geh
         XUUdf1VRwoVvPiWex3/Nya9Aaer7mIE965jDfjVibzUBBWbCst2k9qM86QYWsZHWJ4Qc
         bHO3VRMonp4Fgql/lB8NMaREY5ZGFmsWYmy6ANM4/KZGK4fRoqtEvUexe/o1LyTQc8H7
         l5JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772165505; x=1772770305;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CxqowGzg2CaK2KHQ3yg4HgobTjZp7H6lsiRmrF05V2E=;
        b=UzKqNa5gryKkjd1A7aWK9Bn04LFsFF0rVi7gj7/LpsCjPJSPzmEA9qfU0sEzPfxfVn
         GKnEDsjLGMLFFAAEDvlFW7+SF3uhKBJtmXB4SiMxtpmPNVr3Mfeax/uBYTCOWQ3ag4Xq
         YsGKQsGxhf7fvpOGtxehNza2On9xo2UuO+ZhPbzFjY+udAI+jrlW6aSaiZmBjLHAKsAM
         VRAEx7/Wf5KlGW7TXmlHT9b/8vR7WbASWdbCaKLkYYL9giz6QyXznqsqvM3PBU/yXPtn
         0Z20gPeHMisoZA8eNjJkUr3I5Mchi8swrthjhKwW8uhpq2iCjpIEwZmNSs3UdzZRWiIq
         7DKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWcJUd0/8qKjzfPAT6VJA9HxQSt6sRj6CxGH9UboTajJZ4gYzn3HDhDI/U0bvm1VX91LW5JG3nyFbCdhJP9tQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyz4kUsB4Brc2C7mDWO0JFVo32YBfCJ6eAcJFpj5XhO/mSJ9VaZ
	OcWRsy4f45Bn9k9o3ovG13aAnqCI/gPMy/wAaGCzaLAjcqK+ELXYXHZT3lYQMJBjXLQ=
X-Gm-Gg: ATEYQzz5EpSq9B5OrIKsdgfQlU+fivG5OEXLAfv+UE5IsF4ncWRv+e5Ohy20NrcpW8f
	onhJ6E74eT3ssmEpSYY/SL2jV7JW8tW4D6qjIl699/gC696VfQjmqtMtdovbQquwQBg51ppKLub
	rGNBHOd4PLEKAKc96jzeQOMo2+cVILFYFwuJhnRpaCpE5E2KK/zzSu8zeeIgeJXhfHBLBhTaDHm
	vQf2Mf3QT+LSwnRl2MaQ4IblBHX9tZ9VDBVtSRtjOBQR2m+qwvfyeWhpeTBlCISjPuu6VIKneIO
	IC1FvGgFyTDHP+DSpD5321ylCntPDN29uNPWP4vwFa1FCbOVvYKbY1T9eInfoes3C5JnmXT6nbO
	OiTNzfJEDZhnRRTPDJfdIIr2hWOGa7BjL4jK6781NvNhC7KVtnwmP++xTFyESkVtUaoEtA0wrbT
	pIwKl6oVIr+mR2haqHtcijpCbqnaaLfSHHbnke5HtctP7L3JTNV0tq++A2YncKV6M7UUNnwsgu0
	cW0mp9bRWM/6Le8JitIAWpuVObiel8=
X-Received: by 2002:a17:902:ccc4:b0:2ad:bdc5:ba9f with SMTP id d9443c01a7336-2ae2e4d93f2mr14601015ad.55.1772165505486;
        Thu, 26 Feb 2026 20:11:45 -0800 (PST)
Received: from mma-H9MHD44.lan (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb6ba5eesm41682865ad.68.2026.02.26.20.11.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 20:11:45 -0800 (PST)
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>,
	Dan Callaghan <dan.callaghan@morsemicro.com>,
	Arien Judge <arien.judge@morsemicro.com>
Cc: ayman.grais@morsemicro.com,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH wireless-next 01/35] wifi: mm81x: add bus.h
Date: Fri, 27 Feb 2026 15:10:11 +1100
Message-ID: <20260227041108.66508-2-lachlan.hodges@morsemicro.com>
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
	TAGGED_FROM(0.00)[bounces-32240-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[morsemicro.com:mid,morsemicro.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,morsemicro-com.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 608E91B284A
X-Rspamd-Action: no action

(Patches split per file for review, see cover letter for more
information)

Signed-off-by: Lachlan Hodges <lachlan.hodges@morsemicro.com>
---
 drivers/net/wireless/morsemicro/mm81x/bus.h | 90 +++++++++++++++++++++
 1 file changed, 90 insertions(+)
 create mode 100644 drivers/net/wireless/morsemicro/mm81x/bus.h

diff --git a/drivers/net/wireless/morsemicro/mm81x/bus.h b/drivers/net/wireless/morsemicro/mm81x/bus.h
new file mode 100644
index 000000000000..3c0b8bb1d8c3
--- /dev/null
+++ b/drivers/net/wireless/morsemicro/mm81x/bus.h
@@ -0,0 +1,90 @@
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
+	int (*dm_read)(struct mm81x *mm, u32 addr, u8 *data, int len);
+	int (*dm_write)(struct mm81x *mm, u32 addr, const u8 *data, int len);
+	int (*reg32_read)(struct mm81x *mm, u32 addr, u32 *data);
+	int (*reg32_write)(struct mm81x *mm, u32 addr, u32 data);
+	void (*set_bus_enable)(struct mm81x *mm, bool enable);
+	void (*config_burst_mode)(struct mm81x *mm, bool enable_burst);
+	void (*claim)(struct mm81x *mm);
+	void (*set_irq)(struct mm81x *mm, bool enable);
+	void (*release)(struct mm81x *mm);
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
+static inline int mm81x_dm_read(struct mm81x *mm, u32 addr, u8 *data, int len)
+{
+	return mm->bus_ops->dm_read(mm, addr, data, len);
+}
+
+static inline int mm81x_dm_write(struct mm81x *mm, u32 addr, const u8 *data,
+				 int len)
+{
+	return mm->bus_ops->dm_write(mm, addr, data, len);
+}
+
+static inline int mm81x_reg32_read(struct mm81x *mm, u32 addr, u32 *data)
+{
+	return mm->bus_ops->reg32_read(mm, addr, data);
+}
+
+static inline int mm81x_reg32_write(struct mm81x *mm, u32 addr, u32 data)
+{
+	return mm->bus_ops->reg32_write(mm, addr, data);
+}
+
+static inline void mm81x_set_bus_enable(struct mm81x *mm, bool enable)
+{
+	mm->bus_ops->set_bus_enable(mm, enable);
+}
+
+static inline void mm81x_bus_config_burst_mode(struct mm81x *mm,
+					       bool enable_burst)
+{
+	if (mm->bus_ops->config_burst_mode)
+		mm->bus_ops->config_burst_mode(mm, enable_burst);
+}
+
+static inline void mm81x_claim_bus(struct mm81x *mm)
+{
+	mm->bus_ops->claim(mm);
+}
+
+static inline void mm81x_bus_set_irq(struct mm81x *mm, bool enable)
+{
+	mm->bus_ops->set_irq(mm, enable);
+}
+
+static inline void mm81x_release_bus(struct mm81x *mm)
+{
+	mm->bus_ops->release(mm);
+}
+
+static inline unsigned int mm81x_bus_get_alignment(struct mm81x *mm)
+{
+	return mm->bus_ops->bulk_alignment;
+}
+
+#endif /* !_MM81X_BUS_H_ */
-- 
2.43.0


