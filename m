Return-Path: <linux-wireless+bounces-32269-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EFrzHzAcoWlhqQQAu9opvQ
	(envelope-from <linux-wireless+bounces-32269-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 05:23:12 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D60421B2A60
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 05:23:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6A60C31EE295
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 04:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DB8635A938;
	Fri, 27 Feb 2026 04:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="AovsTbgU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B8735A389
	for <linux-wireless@vger.kernel.org>; Fri, 27 Feb 2026 04:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772165697; cv=none; b=QM+dz30QaZ4ggeCjpAjkTDhqH/BnxGZqkEPetgNy0YqSAr860uatoigrdXH29iHThMAo9ePps3Ra6fwpLqCcsdrtNc6jje5Z5W/EMZNJhUz7IYJTfg8h2G1prVlAwA0moRuTDr55aMcaxjoXu6LQhZh54xn6IE0pe/FMPjw8KUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772165697; c=relaxed/simple;
	bh=O+RsGj36VL3ev/Tdder4ACRGUEEc7mkPjiMg1Wrgt0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JNu1J3Z/9wWDgJplFVwCB/nLaZj1ka6fVabh4tThriF7dJnnFCaKSdWijJizD7+TGFsj74+A4qMUkn1KMdAiMzHEEl9FkuHYYsCAQBk+bT4Tylx2zwdir/NTW3B89yHjJyzW+eq1WmDO/wEP0p0SHwHrddWVsLUHMR+T/LQXM14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=AovsTbgU; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2aaf43014d0so12894305ad.2
        for <linux-wireless@vger.kernel.org>; Thu, 26 Feb 2026 20:14:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1772165696; x=1772770496; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QoJwh2Ku0EL5eX/YAnzaRSvq0JHqG3AslBQLMu9EjgY=;
        b=AovsTbgUfWgHhPn+3bh/Ew7XzTNzUYlgXQsjxzZ4Y/Xkbed2gWQypvHNXxMbbzTkzQ
         ASJ0BDrCAO6BDLntYZjRzhhZcvGoQapJBQJZhWYzBsS5NKvPS+7L5wqsA1XzNjKANC6S
         o4/5D4eeBH3/nQ/53r3+uxvET4dflkU497VZLusFJF7sGCWynZ6aukmj5Lu2MayWls+E
         DCSH6pEsJ8/J0RKTl2SBh4zsXKKZKYo5ZpULIR3RW/PzLTQq8qEBTbZA1eGe1q9OnY/u
         337ldvnXGZlcUNURoqFZ1KpYlFotclOswYKdaW8QSDE4dK8YhqR/eobWBlzFL/GejV6I
         08IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772165696; x=1772770496;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QoJwh2Ku0EL5eX/YAnzaRSvq0JHqG3AslBQLMu9EjgY=;
        b=q4KdyxHArFUxp5Gp4p9nbqdnayYPjsxaF2xBE0zapBTOykrDlJMAxATXAnhhjjZj2m
         PMAAb45cQcy8d+7khBMaviJKHnA9eQUrhL7uewqf2dtPMdL+lHLeI2vum5dZV05Zp0AD
         khrwt5wCDX3mf+U6W1zydAngaTR7U2/gBatqzbMM3JSs0nMKbuHzq0pU21ZJr0Ndmgb1
         WFDsY1s5Wk11exAedtO21FLiT6k+/83W9kH4FblVDx948ML6f3506OZpHYF5khgb9tQA
         kSwEKmL4K2fxdLyOoU0SXpI4YNOr0dmdYOWbdzsFma6mMsM3WicQceTZ/SZtAhzjBSG8
         DJjA==
X-Forwarded-Encrypted: i=1; AJvYcCXh0NIl+TUJghspaR4nDt7Zk+hTsj5gVBoVHqxrG+KmeooeCKpsvdtC75hllYoqw/+bbZizYpKwOHGB+beQRg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyob/9IboJwK02T6BCfenygB5v3kYZjaQRCxk53YGQRYW0T4uCa
	+iZg/NlhJH1LLAAmnbQuRW0xwkn4QUL49cGtor1JTvzESiiCytWL4lIy8fKKiHWAp38=
X-Gm-Gg: ATEYQzwsSoPFbwVH65MzlTWFr2C8uBklrbpCRa2I0XLu95dKRcY/EdwQA4mku39ei0H
	ENI9eFcEavwe9R3E7/AMKAFe8XRPT4wRZnElsTfmWzmvv+4qPu70bsnywWU4ZWdEITS/kSvR7DO
	J4zuFrXfdVqh1WpXUbm4zIC9Xr7tO4YQb/vznZooPu410IRjPJy6vZ/wZf6zoITHU+GWDQexCfR
	FqU/NpWheBc8o2GmdMfqC5XpN65pqFGE0KVwaYUi1LIKPnF7g+S7EnO07O84afE581W566n5bZG
	yyXzSeXURiWlN+AF5C0nJIvWGEsg/kb4vPh4JOMBaxu2IrbxOQS6hAaQMZSj0iT4ArDjTSVTQUq
	fQEw34An43+2jPt1ixx+mGh86J/UAUL2nsfwPgUkeE8ums9jAm4Cn8KGktJsby+1W7ttozwxgKg
	9RjZ48ftbf+Ra1sOhowrF022aggp7DZ3JZOsO6IDhOouI5BeNbpl2O4a+fCR/ipQhLydMktRRS7
	s9hUXfg2Cto0TjSpFQVhZSitCjOQAA=
X-Received: by 2002:a17:902:ccd0:b0:2a9:327f:aa31 with SMTP id d9443c01a7336-2ae2e418865mr11329895ad.21.1772165695861;
        Thu, 26 Feb 2026 20:14:55 -0800 (PST)
Received: from mma-H9MHD44.lan (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb6ba5eesm41682865ad.68.2026.02.26.20.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 20:14:55 -0800 (PST)
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>,
	Dan Callaghan <dan.callaghan@morsemicro.com>,
	Arien Judge <arien.judge@morsemicro.com>
Cc: ayman.grais@morsemicro.com,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH wireless-next 30/35] wifi: mm81x: add yaps_hw.h
Date: Fri, 27 Feb 2026 15:10:40 +1100
Message-ID: <20260227041108.66508-31-lachlan.hodges@morsemicro.com>
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
	TAGGED_FROM(0.00)[bounces-32269-lists,linux-wireless=lfdr.de];
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
X-Rspamd-Queue-Id: D60421B2A60
X-Rspamd-Action: no action

(Patches split per file for review, see cover letter for more
information)

Signed-off-by: Lachlan Hodges <lachlan.hodges@morsemicro.com>
---
 .../net/wireless/morsemicro/mm81x/yaps_hw.h   | 52 +++++++++++++++++++
 1 file changed, 52 insertions(+)
 create mode 100644 drivers/net/wireless/morsemicro/mm81x/yaps_hw.h

diff --git a/drivers/net/wireless/morsemicro/mm81x/yaps_hw.h b/drivers/net/wireless/morsemicro/mm81x/yaps_hw.h
new file mode 100644
index 000000000000..8a04ced01fa2
--- /dev/null
+++ b/drivers/net/wireless/morsemicro/mm81x/yaps_hw.h
@@ -0,0 +1,52 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2017-2026 Morse Micro
+ */
+
+#ifndef _MM81X_YAPS_HW_H_
+#define _MM81X_YAPS_HW_H_
+
+#include <linux/types.h>
+#include <linux/crc7.h>
+
+#define MM81X_INT_YAPS_FC_PKT_WAITING_IRQN 0
+#define MM81X_INT_YAPS_FC_PACKET_FREED_UP_IRQN 1
+
+struct mm81x_yaps_hw_table {
+	/* NOTE: We need these padding bytes for yaps to work */
+	u8 padding[4];
+	__le32 ysl_addr;
+	__le32 yds_addr;
+	__le32 status_regs_addr;
+
+	/* Alloc pool sizes */
+	__le16 tc_tx_pool_size;
+	__le16 fc_rx_pool_size;
+	u8 tc_cmd_pool_size;
+	u8 tc_beacon_pool_size;
+	u8 tc_mgmt_pool_size;
+	u8 fc_resp_pool_size;
+	u8 fc_tx_sts_pool_size;
+	u8 fc_aux_pool_size;
+
+	/* To chip/from chip queue sizes */
+	u8 tc_tx_q_size;
+	u8 tc_cmd_q_size;
+	u8 tc_beacon_q_size;
+	u8 tc_mgmt_q_size;
+	u8 fc_q_size;
+	u8 fc_done_q_size;
+
+	__le16 yaps_reserved_page_size;
+	__le16 reserved_unused;
+} __packed;
+
+struct mm81x;
+
+void mm81x_yaps_hw_enable_irqs(struct mm81x *mm, bool enable);
+int mm81x_yaps_hw_init(struct mm81x *mm);
+void mm81x_yaps_hw_finish(struct mm81x *mm);
+void mm81x_yaps_hw_read_table(struct mm81x *mm,
+			      struct mm81x_yaps_hw_table *tbl_ptr);
+
+#endif /* !_MM81X_YAPS_HW_H_ */
-- 
2.43.0


