Return-Path: <linux-wireless+bounces-32267-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GHyoGBUcoWlhqQQAu9opvQ
	(envelope-from <linux-wireless+bounces-32267-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 05:22:45 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C1AAE1B2A41
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 05:22:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 64EC131E4946
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 04:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99AD234A774;
	Fri, 27 Feb 2026 04:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="xeREni03"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42F65355803
	for <linux-wireless@vger.kernel.org>; Fri, 27 Feb 2026 04:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772165685; cv=none; b=m/xuyieQXLD4L536idEtxNF/qVcx7i8tHfOhsEUe9D4ExcsOOOo9fWPjUnSH5JZVemDt0QJTU+H/o/jqVb+pcTwL4kij4DhORqQeCS/hFFdaNV3PhyeFCr0irnClcJnII2+MpdhHYWMfaqBuTAXuTk6uaQDeKBFEJoxuSLQ2kq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772165685; c=relaxed/simple;
	bh=rMRtwsWnwfd8RYaC2gHD7ZCLs2VDmFei3BHXFgZXMRg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fd1X1sDIXBl579mONyq6LmN8TCILrTBRkaZRXQ8S6HRCHkHR41Ozg5+DppgcGyi1H9Fp1x4HsjM1RIKwFzYt+l3/6kImwDwqTy0P8Yn2ZXjujM3xoJqKsYgm+Sly8TgAGjK2iBsmXNNFPaQDNO9x9Q5Xkl2HvvkkMi7I2RCUZRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=xeREni03; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ad21f437eeso11952815ad.0
        for <linux-wireless@vger.kernel.org>; Thu, 26 Feb 2026 20:14:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1772165684; x=1772770484; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i+CFKlFW6pN63W+wn/uX5939ckwyLSy/hkZzjJqmna4=;
        b=xeREni03ldc/tel5M4bJlitUHLVIQssGd43Ym+W0lONi8GNpocCmOBTJgnOJvLEaFR
         sQtUl0Yj1OxaPFwiNBfJWdLVrqMlbgICxacJ8TmiEBfG/az4C5rnHUlpN8c3gd3RJLRM
         Ds4Rk/XUw6PQIx+lGc2vTXTG/OragmVfpqLQ1RQczluDc9EPVjcG8budoWuPd+3jAA3x
         jkGz9/pnahkdBuxgGgpCy5jvVEncza+6XB8Fyoj6xY454cAPuc8KvkD88TOYPZsnyfC2
         c8LbiQ2jdvNwdqBgnOTDv5ghKaW8Q7O+ACBaWbaU3PUo5VvXDtokAEEoFqcmGWiMm5Kf
         h2aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772165684; x=1772770484;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=i+CFKlFW6pN63W+wn/uX5939ckwyLSy/hkZzjJqmna4=;
        b=bwR7H4Dx3j2BZFKt0W4Pn7VmDp1a+YFFQhPVuR0ucjFN0h+vc890aEB8hz185N8ID8
         D7FTmk2ishm40KxYKyUmznXViJUGIymlOYWuT37cAEyc40BXzG59W4SD25JoGM5HqDRu
         PO8giycD2JbQoD2cq1d4hrRkBDz8CwchZ2ZjCUhSysn7tHrGgXRZ4kcUdo8JZ+X5rxBi
         6Lwkg9bWdeteMXlnvQkLRN+4oCpSVtyOL95EiqP+c0mV7j6Bd2gjaoYdgSpzjgCgXl0B
         GgTIApY7M1E26NvElZDpKZ/sycjaSCriDfEDF65oblC7PYZNDQrxXIiUgjr7DqU7HMc0
         OMQQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0zPCqtJZ+ieCOygB5YfRieFyE9GsaCyliLimg2UP1yDyzDuG1cW9ywGYThgFaaJSYwV6dop2Y81pI0qtgrQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxllQqTQ5BKnTO0i6BT5u+Ez7NDy4XVRXG/Rmle5bRWXZs2Gkk6
	mF7z/QCSLFT7fSeOYxR/saWOV53G/4RPMkWV3+yFl3lEKTg9JFHBhtj9AwWodGlXQ9Q=
X-Gm-Gg: ATEYQzzEE9+s3GyrMWH+DjHgeGD+5snlL/+Y4rI8aiXHw4Ok8slwX9W3fDfxKsJGoeD
	TL4nV1ITyxUCYY8ZXxthwzbgmiHZfoBMo3htzoy+AmxJltX65PDDvXQdwOla+zWbz8j0gI0VASA
	0z+n2S2y0DIS7ejmveVO6XeAWXlts557oUxkQ1SpmAW/BdIKCFpN737ZFzN7vTkNredqeoiDw9o
	Ey5gm/Yl5RbMDTvTzHG9/28aCagEUWYDcqlIM78pm2PuYerI2P4QWUVRUbQvM5YLqMIM+f0S8LD
	dF5MOc7BlmxfEb8HnzUyqxP3rAyZYV4xsVSjs/7FF5WG0YUDsPi2FANHBiIh1hBZZjmuylL9rMR
	z/WcDFPsKde0p2TGJTQkiGEfANCC06URD4UXt6lMSVk19UHRTlTP2deH/Fem+AF93faE8rT/MMK
	nKinY1+ilSq/A8/yDT/SC77suWQJgdceHYz/eXgqGBKp39u6fVarqKAGV8Pre+aZc9T93W5KnT3
	bvQp9TB/ED8yBpI9d/2jX7s4KGmlto=
X-Received: by 2002:a17:903:1a03:b0:2aa:e3d1:1430 with SMTP id d9443c01a7336-2ae2bbd72fbmr14624995ad.23.1772165683755;
        Thu, 26 Feb 2026 20:14:43 -0800 (PST)
Received: from mma-H9MHD44.lan (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb6ba5eesm41682865ad.68.2026.02.26.20.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 20:14:43 -0800 (PST)
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>,
	Dan Callaghan <dan.callaghan@morsemicro.com>,
	Arien Judge <arien.judge@morsemicro.com>
Cc: ayman.grais@morsemicro.com,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH wireless-next 28/35] wifi: mm81x: add yaps.h
Date: Fri, 27 Feb 2026 15:10:38 +1100
Message-ID: <20260227041108.66508-29-lachlan.hodges@morsemicro.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[morsemicro-com.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[morsemicro.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[morsemicro-com.20230601.gappssmtp.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32267-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lachlan.hodges@morsemicro.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,morsemicro.com:mid,morsemicro.com:email,morsemicro-com.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: C1AAE1B2A41
X-Rspamd-Action: no action

(Patches split per file for review, see cover letter for more
information)

Signed-off-by: Lachlan Hodges <lachlan.hodges@morsemicro.com>
---
 drivers/net/wireless/morsemicro/mm81x/yaps.h | 77 ++++++++++++++++++++
 1 file changed, 77 insertions(+)
 create mode 100644 drivers/net/wireless/morsemicro/mm81x/yaps.h

diff --git a/drivers/net/wireless/morsemicro/mm81x/yaps.h b/drivers/net/wireless/morsemicro/mm81x/yaps.h
new file mode 100644
index 000000000000..a362c58c2a15
--- /dev/null
+++ b/drivers/net/wireless/morsemicro/mm81x/yaps.h
@@ -0,0 +1,77 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2017-2026 Morse Micro
+ */
+
+#ifndef _MM81X_YAPS_H_
+#define _MM81X_YAPS_H_
+
+#include <linux/skbuff.h>
+#include <linux/workqueue.h>
+#include "skbq.h"
+
+#define YAPS_TX_SKBQ_MAX 4
+
+struct mm81x_hif_ops;
+extern const struct mm81x_hif_ops mm81x_yaps_ops;
+
+enum mm81x_yaps_to_chip_q {
+	MM81X_YAPS_TX_Q = 0,
+	MM81X_YAPS_CMD_Q,
+	MM81X_YAPS_BEACON_Q,
+	MM81X_YAPS_MGMT_Q,
+	/* Keep this last */
+	MM81X_YAPS_NUM_TC_Q
+};
+
+struct mm81x_yaps_pkt {
+	struct sk_buff *skb;
+	enum mm81x_yaps_to_chip_q tc_queue;
+};
+
+struct mm81x_yaps {
+	struct mm81x *mm;
+	struct mm81x_yaps_hw_aux_data *aux_data;
+	const struct mm81x_yaps_ops *ops;
+	u8 flags;
+	struct {
+		struct mm81x_yaps_pkt *to_chip_pkts;
+		struct mm81x_yaps_pkt *from_chip_pkts;
+	} hw;
+
+	/* Chip interface is stopping, new work should not be enqueued. */
+	bool finish;
+
+	struct mm81x_skbq data_tx_qs[YAPS_TX_SKBQ_MAX];
+	struct mm81x_skbq beacon_q;
+	struct mm81x_skbq mgmt_q;
+	struct mm81x_skbq data_rx_q;
+	struct mm81x_skbq cmd_q;
+	struct mm81x_skbq cmd_resp_q;
+
+	struct {
+		struct timer_list timer;
+		unsigned long retry_expiry;
+		bool is_full;
+	} chip_queue_full;
+};
+
+struct mm81x_yaps_ops {
+	int (*write_pkts)(struct mm81x_yaps *yaps, struct mm81x_yaps_pkt *pkts,
+			  int num_pkts, int *num_pkts_sent);
+	int (*read_pkts)(struct mm81x_yaps *yaps, struct mm81x_yaps_pkt *pkts,
+			 int num_pkts_max, int *num_pkts_received);
+	int (*update_status)(struct mm81x_yaps *yaps);
+};
+
+int mm81x_yaps_init(struct mm81x *mm);
+void mm81x_yaps_show(struct mm81x_yaps *yaps, struct seq_file *file);
+void mm81x_yaps_finish(struct mm81x *mm);
+void mm81x_yaps_flush_tx_data(struct mm81x *mm);
+void mm81x_yaps_flush_cmds(struct mm81x *mm);
+void mm81x_yaps_work(struct work_struct *work);
+void mm81x_yaps_stale_tx_work(struct work_struct *work);
+int mm81x_yaps_get_tx_status_pending_count(struct mm81x *mm);
+int mm81x_yaps_get_tx_buffered_count(struct mm81x *mm);
+
+#endif /* !_MM81X_YAPS_H_ */
-- 
2.43.0


