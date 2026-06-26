Return-Path: <linux-wireless+bounces-38118-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hvPZES8dPmrq/wgAu9opvQ
	(envelope-from <linux-wireless+bounces-38118-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2026 08:33:19 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AEEB56CAA80
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2026 08:33:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=morsemicro-com.20251104.gappssmtp.com header.s=20251104 header.b=hQ41jDtv;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38118-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38118-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=morsemicro.com (policy=none);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ABF3E30BF22F
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2026 06:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 329163DB327;
	Fri, 26 Jun 2026 06:31:16 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05BE3DB328
	for <linux-wireless@vger.kernel.org>; Fri, 26 Jun 2026 06:31:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782455476; cv=none; b=oONVw4pKnSRiIqTTiv32EdT22UUYpnqWBmbPttZ2v/p7ovEwCdvFn7T1O3CaXbUA+YwhuncbmSx7eey5JhH2mhMZbrpGIgNQCzhE/a4Ig7u+kt/JOohwWTkDHplpI8M31hKrcZHJYioCE2LK5kEPN6gueQKzVYmRiKZWozjAk/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782455476; c=relaxed/simple;
	bh=es6NEHMM46sssDEvQ3mA+SWx7xg7DaWBFHoUBMG6Qjo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NaL4OsNrUiqyjlZJoBUsKm9Rj+52JOBCFEnId0dSNQwZt9CZu2/q+Rf+TqQ2cRuJjlRScqEERyvefrV+kkJUQhNd3S6wmN408CYXx+ASxAea3lcIzlk+w+jGwQnrvBPki/+mgrCX9S9RkmEt480yW2QCKsSDMVzRpAuDslP1rZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20251104.gappssmtp.com header.i=@morsemicro-com.20251104.gappssmtp.com header.b=hQ41jDtv; arc=none smtp.client-ip=74.125.82.52
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-139986373b8so872295c88.0
        for <linux-wireless@vger.kernel.org>; Thu, 25 Jun 2026 23:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20251104.gappssmtp.com; s=20251104; t=1782455474; x=1783060274; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qfmslz8cAnA8/7/9BeScgbtq/rTUkCRM6UXJi/7S+kw=;
        b=hQ41jDtvnyQiiu9JixylKHTcTkxwPow/ZVl0C1E735vS3zUAlnpS7XZiJEY9dmr2bE
         DwK9s2+v/6lCjwxDFokffTtvqB7qpmzpz68Fd6SC83T+FZy25IcS78/9LlS/1AhOqEBN
         Vs+gJxAgklI3ud0yx2UOIdfGpF5NP8jEzgwYi4IzaUcoJ2n9RMuptLkgEJ/t4WvUQyb3
         R08Dlq+qCBEuJcn2kz135172vwZI3HNQDMsaeWtyFDmRdIlFghFm+2tpoct7dB5UeBuS
         2QZoWHCUEoBhUMQPh0R4cAIhRTKJdq82Kr/8uFFZXkEa3koUMlAUcECSuJBbklpl0TKw
         NMqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782455474; x=1783060274;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qfmslz8cAnA8/7/9BeScgbtq/rTUkCRM6UXJi/7S+kw=;
        b=PwoJVEYRzY9TPxvMNqDqshH7y3LqP+DdV91ZLoH94oe8E1zed4N9Pkbogkh9hvzF3L
         Fs1U5Lg72/QxlIhNtvZ7PcBffINFr6cuZdRKE32AsYwpsp90LiJSrvOH1kmtWJk7xWz0
         AhTHIB+ymPH6tWVFMj0YVdIbgacYNdV+7xpYrY1QP4qJQVP/MSxr9lJ5AdNqV1eCn0os
         E348vJ7+HIlu+pH6KFdzq6q1hNvHCSse9abXVkOZDzl/TEZ7jjxnI6belEgREcIlta/C
         +1RmPpRdCXNel7NdIL0YSto9NaJa9r1tG9E2f8GlomhM8uB7m0gwiFT5EtDeoZWgtYnb
         Z/Yw==
X-Forwarded-Encrypted: i=1; AFNElJ8DJYf7Y3XdKZzXKZPkkgqsHWZ7b18I38IAtLrJpe3shI6c+yHk82iy9Y//SOUw9LF2liFOe4SkjiqhHMIzmA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwS4C55wVOff2oDmvVRvZpTYxmQVxXCfrK4j2eq7K5gB/zZwn4k
	9eGd03L2qXP9S42abMZyWj9V5V1EQliRzk/SInOVlPhGdJdV7/3uCEwZBfzZbb5rFtU=
X-Gm-Gg: AfdE7ckBFyvSI7r4FHxbFqSSjBtVa/lPQTjoJVLulkMvQKFtPmQ9jGZFcx7WwVPZscQ
	3Ybug6Ueu7P2Kjm0875bCXdxXxukbETmErtTBkqTbZz6qO5Id5AZeyzgNb4qCasX9XJwJH41c3t
	rIgBGZh+6CiVQjwDJIcSYBWVBP2zfMt/8VKxolv/fCf0wVnbmyoPDzDBXmsLJ4a4/Fv3YHggM9V
	WUgIlGaZGZZHLqwKGhDMkkBHWXaffeTiokNOa1NhvoSC/H+IauMAVww5ptjbqL0of1x7J2kc9LP
	NOIsifZWWxKV5fJrp4WNOb/aXNgpkBrhhf/C9LpMoPChwQgk6Jzd5RC1W4JW99efgFa5U3G3KX2
	Cd/YxA9wi3WO6zY4m2Vj02SDwn5QBdCQKyIqZbxExtAKHAMO6aYz7hAtiqiQCDmtvI5rO9cfLPj
	L6UZFDXf4A+rgeqTDCAAZYq8JWI4jVUi4V21NtXmHUS7xQBfe+oYZ6X7dV0Jpldauu0rdIPiX8q
	FqsFmXMSit/DX3+WAcBz1Cnr2qexNg=
X-Received: by 2002:a05:7022:699e:b0:136:d029:459 with SMTP id a92af1059eb24-139dbb906f0mr5820780c88.22.1782455473851;
        Thu, 25 Jun 2026 23:31:13 -0700 (PDT)
Received: from mma-H9MHD44.lan (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-139d91006bcsm15463687c88.13.2026.06.25.23.31.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 23:31:13 -0700 (PDT)
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>,
	Dan Callaghan <dan.callaghan@morsemicro.com>,
	Arien Judge <arien.judge@morsemicro.com>
Cc: ayman.grais@morsemicro.com,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH wireless-next v3 07/33] wifi: mm81x: add core.c
Date: Fri, 26 Jun 2026 16:29:03 +1000
Message-ID: <20260626063014.1275235-8-lachlan.hodges@morsemicro.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[morsemicro.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-38118-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,morsemicro-com.20251104.gappssmtp.com:dkim,morsemicro.com:email,morsemicro.com:mid,morsemicro.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AEEB56CAA80

(Patches split per file for review, will be a single commit alongside
SDIO ids once review is complete. See cover letter for more
information)

Signed-off-by: Lachlan Hodges <lachlan.hodges@morsemicro.com>
---
 drivers/net/wireless/morsemicro/mm81x/core.c | 142 +++++++++++++++++++
 1 file changed, 142 insertions(+)
 create mode 100644 drivers/net/wireless/morsemicro/mm81x/core.c

diff --git a/drivers/net/wireless/morsemicro/mm81x/core.c b/drivers/net/wireless/morsemicro/mm81x/core.c
new file mode 100644
index 000000000000..33548a6aea6c
--- /dev/null
+++ b/drivers/net/wireless/morsemicro/mm81x/core.c
@@ -0,0 +1,142 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2017-2026 Morse Micro
+ */
+#include <linux/module.h>
+#include "core.h"
+#include "bus.h"
+#include "hif.h"
+#include "mac.h"
+
+static int mm81x_core_attach_regs(struct mm81x *mors)
+{
+	int ret = 0;
+
+	mm81x_claim_bus(mors);
+	ret = mm81x_reg32_read(mors, MM8108_REG_CHIP_ID, &mors->chip_id);
+	mm81x_release_bus(mors);
+
+	if (ret < 0) {
+		dev_err(mors->dev, "failed to read chip id %d", ret);
+		return ret;
+	}
+
+	switch (mors->chip_id) {
+	case (MM8108B2_ID):
+		mors->regs = &mm8108_regs;
+		mors->hif.ops = &mm81x_yaps_ops;
+		break;
+	default:
+		return -ENODEV;
+	}
+
+	return ret;
+}
+
+static char *mm81x_core_get_revision_string(u32 chip_id)
+{
+	u8 chip_rev = MM81X_DEVICE_GET_CHIP_REV(chip_id);
+
+	switch (chip_rev) {
+	case MM8108B2_REV:
+		return MM8108B2_REV_STRING;
+	default:
+		return "??";
+	}
+}
+
+static void mm81x_core_init_mac_addr(struct mm81x *mors)
+{
+	int ret = mm81x_hw_otp_get_mac_addr(mors);
+
+	if (ret || !is_valid_ether_addr(mors->macaddr))
+		eth_random_addr(mors->macaddr);
+}
+
+char *mm81x_core_get_fw_path(u32 chip_id)
+{
+	return kasprintf(GFP_KERNEL,
+			 MM81X_FW_DIR "/" MM8108_FW_BASE
+				      "%s" FW_ROM_LINKED_STRING MM81X_FW_EXT,
+			 mm81x_core_get_revision_string(chip_id));
+}
+EXPORT_SYMBOL_GPL(mm81x_core_get_fw_path);
+
+struct mm81x *mm81x_core_alloc(size_t priv_size, struct device *dev)
+{
+	return mm81x_mac_alloc(priv_size, dev);
+}
+EXPORT_SYMBOL_GPL(mm81x_core_alloc);
+
+int mm81x_core_init(struct mm81x *mors)
+{
+	int ret;
+
+	set_bit(MM81X_STATE_CHIP_UNRESPONSIVE, &mors->state_flags);
+	set_bit(MM81X_STATE_RELOAD_FW_AFTER_START, &mors->state_flags);
+
+	mm81x_core_init_mac_addr(mors);
+
+	ret = mm81x_core_attach_regs(mors);
+	if (ret)
+		return ret;
+
+	mors->chip_wq = create_singlethread_workqueue("chip_wq");
+	if (!mors->chip_wq)
+		return -ENOMEM;
+
+	mors->net_wq = create_singlethread_workqueue("net_wq");
+	if (!mors->net_wq) {
+		ret = -ENOMEM;
+		goto err_chip_wq;
+	}
+
+	ret = mm81x_hif_init(mors);
+	if (ret)
+		goto err_wqs;
+
+	return 0;
+
+err_wqs:
+	flush_workqueue(mors->net_wq);
+	destroy_workqueue(mors->net_wq);
+
+err_chip_wq:
+	flush_workqueue(mors->chip_wq);
+	destroy_workqueue(mors->chip_wq);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(mm81x_core_init);
+
+int mm81x_core_register(struct mm81x *mors)
+{
+	return mm81x_mac_register(mors);
+}
+EXPORT_SYMBOL_GPL(mm81x_core_register);
+
+void mm81x_core_unregister(struct mm81x *mors)
+{
+	mm81x_mac_unregister(mors);
+}
+EXPORT_SYMBOL_GPL(mm81x_core_unregister);
+
+void mm81x_core_deinit(struct mm81x *mors)
+{
+	mm81x_hif_finish(mors);
+	flush_workqueue(mors->net_wq);
+	destroy_workqueue(mors->net_wq);
+	flush_workqueue(mors->chip_wq);
+	destroy_workqueue(mors->chip_wq);
+}
+EXPORT_SYMBOL_GPL(mm81x_core_deinit);
+
+void mm81x_core_free(struct mm81x *mors)
+{
+	mm81x_mac_free(mors);
+}
+EXPORT_SYMBOL_GPL(mm81x_core_free);
+
+MODULE_AUTHOR("Morse Micro");
+MODULE_DESCRIPTION("Driver support for Morse Micro MM81X core");
+MODULE_LICENSE("Dual BSD/GPL");
-- 
2.43.0


