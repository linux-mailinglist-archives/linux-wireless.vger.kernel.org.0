Return-Path: <linux-wireless+bounces-32257-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yKmmI30aoWlhqQQAu9opvQ
	(envelope-from <linux-wireless+bounces-32257-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 05:15:57 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 32BDE1B2911
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 05:15:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 99467305E98F
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 04:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B9E2347BCA;
	Fri, 27 Feb 2026 04:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="0DxVzpKM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE09346E41
	for <linux-wireless@vger.kernel.org>; Fri, 27 Feb 2026 04:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772165623; cv=none; b=XBO0dwiqezrahUBzueExx9dnoeQFvY2VVmSmFI6gu6KCZsSVJE03Vql7gOekQlhFuVGgdn0Bo8qAQfyF2j4Ut+4cfTZLIvtjI5wceOfBaRg7yAJcE797Ia+V92sjJ4/ejVPzPDHU3zE7yZjVFkCA2DY7skGNmtRtVAVmnxGz/yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772165623; c=relaxed/simple;
	bh=bQz7ExbPI8T0NaVyALSY7q2kTRK6G1lgRdq6S1Qv03E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KiSEa06R/H91k2ODY3XKnKqcSIQN38F1wsxnjz9ZPRtqxCfcFLdXAN2zr/a1g63p9OtaX1PMlleX8wUvK1QpFyj9B59QQbolEzHJAK+IC7UyZCxpYDycIvrQRrKhPSZrwZA4dZqtWgkQtMl3hOinKfvus85rWRcGNaFYpsAxQpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=0DxVzpKM; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2a9296b3926so12853725ad.1
        for <linux-wireless@vger.kernel.org>; Thu, 26 Feb 2026 20:13:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1772165621; x=1772770421; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NQCv+ZfapTBt4PH5IW/PkLo3Lq+datV01QaG3KC/txU=;
        b=0DxVzpKMYZ12sIN6G4uz7MvoCiD2UPg9WiDnaM/gJVaNbQcNVrbqYTxfwmPFIVdfAC
         i6JFXA91KQuohNeFKuqfXHaxwz70+PUJ18n4w8jCEGLN9TVVVUfCIMrgmbL6F4BztO1k
         3eWF96XRFcMhEnKNyAFPlSlk1Ge+SmasixYYuEWtdoIk0l+dbwAJb5wa6b5x8i9JL6lQ
         D9/XKw+MOyC3clngAbbJZTA6ukH3SnYUKdzh83edRyPt2XCpve0JIlsjbSdhlR6E0qf1
         jUN8TzclE2VbdHQVn6UbjaO0yLuC4VO3IkKYnCoG4GFE5Kbgt+2iouUgnq05pXYhMSRr
         IRDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772165621; x=1772770421;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NQCv+ZfapTBt4PH5IW/PkLo3Lq+datV01QaG3KC/txU=;
        b=QlBD/eojv+w2sbNrwbeOSiHcAb4rK7uwb7gI4gZujVtUPISDZl2oWMIAWqArpRVmxb
         IAvO2W1qa/yCj2mZezy90e0c6Ro68H4aMwmU8PGgOQM/Ngak3WoJT9cgm3yNsRmquH3z
         snXZrKXYSbKks8x8ria/EfUM0QHRgGbTw36PoFvywpbZTfFYl9GSe+2iO+L9AItGqvI/
         B224soNpKBUSMacEsUb04/WsNC4XrTAWk71dJnkCVe4PD5Td1jVMJEugGNmSEuUztu8G
         yhC+AMjef3O0QQVUopwCR3ybt4UPpGjWCK1A0jaxTyDNgrb2fcLU0MP6Lx6hpEAnboEr
         GFzQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJCAkE7BQTpPnEf1cOFPP2SKaq+uyKbzp9XgJhXQTR4ZGplc47UUSdH8ep8zPb+w8sgHGOvMIWwUZs6VT1jw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxJm04myQX4NtN92CRtzk5r9NJDv2sN2nZNDHBn0F08P8LugFIi
	8oNjQG3mxNPPgjpL3GEYXuFnapHrOMG8R31zkF/hrFtDMDzo9/DbeXmRbvk6yNZLul8=
X-Gm-Gg: ATEYQzzO2ubW4Ez2VxF/fnIe9A8KtsJNaw3xq3NCJEFK3zJVKjwgIUk27INv9aLHUN+
	Z9TbH7jOl3bqpR6kSw5I1LFcdHdTYdnaVUlr0QELNpr/7Aeagl3F5frnNVNcS0Uje+BnC+Pj5MW
	242TKr3tKZRTLZLcJRO83J6pyzxJgrkDdFmEs5soctn9ny/aMaqB8jPwKLxj6y6+N/eS6+TlKc8
	y6/mxBIv55eCFGtL3ZRMp9HeIfxCRm61+zk6NSSkbSjSpgFFd0nkalMcsrOzTjEDILNOqfOCwxL
	IMKY8wdcd7md6syMbZG1W9qHQa43enIV4h8rU4swtrslyLfsM4s1yyAYyciN+kd4KKtrTtVH7ED
	BsL3y8cTDTTo6KfSIRQjidaV0o6oNiaruwXJ7/QLHx7Mol8hHvQN0Nn4IMVy+fF9RLWtqcUC7Gf
	a8l/WE8WsHD8U0QhE4OanBabtHoVyszlQE8n1UDHN8nKpQxAIn/6tMXqvyCgHLnYeT2sTGQfT3s
	pZU5PFbYJUN3NT1mgZynZ8xK9Cgiv4jN+j8u1B9UA==
X-Received: by 2002:a17:903:2410:b0:2a9:5b28:94c0 with SMTP id d9443c01a7336-2ae2e3cdea5mr11650215ad.27.1772165621047;
        Thu, 26 Feb 2026 20:13:41 -0800 (PST)
Received: from mma-H9MHD44.lan (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb6ba5eesm41682865ad.68.2026.02.26.20.13.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 20:13:40 -0800 (PST)
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>,
	Dan Callaghan <dan.callaghan@morsemicro.com>,
	Arien Judge <arien.judge@morsemicro.com>
Cc: ayman.grais@morsemicro.com,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH wireless-next 18/35] wifi: mm81x: add ps.c
Date: Fri, 27 Feb 2026 15:10:28 +1100
Message-ID: <20260227041108.66508-19-lachlan.hodges@morsemicro.com>
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
	TAGGED_FROM(0.00)[bounces-32257-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lachlan.hodges@morsemicro.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,morsemicro.com:mid,morsemicro.com:email,morsemicro-com.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 32BDE1B2911
X-Rspamd-Action: no action

(Patches split per file for review, see cover letter for more
information)

Signed-off-by: Lachlan Hodges <lachlan.hodges@morsemicro.com>
---
 drivers/net/wireless/morsemicro/mm81x/ps.c | 239 +++++++++++++++++++++
 1 file changed, 239 insertions(+)
 create mode 100644 drivers/net/wireless/morsemicro/mm81x/ps.c

diff --git a/drivers/net/wireless/morsemicro/mm81x/ps.c b/drivers/net/wireless/morsemicro/mm81x/ps.c
new file mode 100644
index 000000000000..432165697acf
--- /dev/null
+++ b/drivers/net/wireless/morsemicro/mm81x/ps.c
@@ -0,0 +1,239 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2017-2026 Morse Micro
+ */
+#include <linux/types.h>
+#include <linux/atomic.h>
+#include <linux/slab.h>
+#include <linux/mutex.h>
+#include <linux/workqueue.h>
+#include <linux/completion.h>
+#include <linux/gpio/consumer.h>
+#include <linux/jiffies.h>
+#include "hif.h"
+#include "debug.h"
+#include "skbq.h"
+#include "mac.h"
+#include "bus.h"
+#include "ps.h"
+
+#define MM81X_WAKEUP_DELAY_MS 10
+
+static bool mm81x_ps_is_busy_pin_asserted(struct mm81x *mm)
+{
+	bool active_high =
+		!(mm->firmware_flags & MM81X_FW_FLAGS_BUSY_ACTIVE_LOW);
+
+	if (!mm->ps.gpios_supported)
+		return false;
+
+	return (gpiod_get_value_cansleep(mm->ps.busy_gpio) == active_high);
+}
+
+static void mm81x_ps_set_wake_gpio(struct mm81x *mm, bool raise)
+{
+	if (!mm->ps.gpios_supported)
+		return;
+
+	gpiod_set_value_cansleep(mm->ps.wake_gpio, raise);
+
+	mm81x_dbg(mm, MM81X_DBG_ANY, "%s wake up pin",
+		  (raise) ? "set" : "cleared");
+}
+
+static void mm81x_ps_wait_after_wake_pin_raise(struct mm81x *mm)
+{
+	unsigned long timeout;
+
+	if (!mm->ps.gpios_supported)
+		return;
+
+	if (mm81x_ps_is_busy_pin_asserted(mm))
+		return;
+
+	timeout = msecs_to_jiffies(MM81X_WAKEUP_DELAY_MS);
+	wait_for_completion_timeout(mm->ps.awake, timeout);
+}
+
+static void mm81x_ps_wakeup(struct mm81x_ps *mps)
+{
+	DECLARE_COMPLETION_ONSTACK(awake);
+	struct mm81x *mm = container_of(mps, struct mm81x, ps);
+
+	if (!mps->enable || !mps->suspended)
+		return;
+
+	WRITE_ONCE(mps->awake, &awake);
+	mm81x_ps_set_wake_gpio(mm, true);
+	mm81x_ps_wait_after_wake_pin_raise(mm);
+	WRITE_ONCE(mps->awake, NULL);
+
+	mm81x_set_bus_enable(mm, true);
+	mps->suspended = false;
+}
+
+static void mm81x_ps_sleep(struct mm81x_ps *mps)
+{
+	struct mm81x *mm = container_of(mps, struct mm81x, ps);
+
+	if (!mps->enable || mps->suspended)
+		return;
+
+	mps->suspended = true;
+	mm81x_set_bus_enable(mm, false);
+	mm81x_ps_set_wake_gpio(mm, false);
+}
+
+static irqreturn_t mm81x_ps_irq_handle(int irq, void *arg)
+{
+	struct mm81x_ps *mps = (struct mm81x_ps *)arg;
+	struct mm81x *mm = container_of(mps, struct mm81x, ps);
+	struct completion *awake = READ_ONCE(mps->awake);
+
+	if (awake)
+		complete(awake);
+	else
+		queue_work(mm->chip_wq, &mps->async_wake_work);
+
+	return IRQ_HANDLED;
+}
+
+static void mm81x_ps_async_wake_work(struct work_struct *work)
+{
+	struct mm81x_ps *mps =
+		container_of(work, struct mm81x_ps, async_wake_work);
+	struct mm81x *mm = container_of(mps, struct mm81x, ps);
+
+	if (mm81x_ps_is_busy_pin_asserted(mm)) {
+		mutex_lock(&mps->lock);
+		mm81x_ps_wakeup(mps);
+		mutex_unlock(&mps->lock);
+	}
+}
+
+static void mm81x_ps_evaluate(struct mm81x_ps *mps)
+{
+	struct mm81x *mm = container_of(mps, struct mm81x, ps);
+	bool needs_wake = false;
+	unsigned long expire;
+	unsigned long flags_on_entry =
+		(mm->hif.event_flags &
+		 ~BIT(MM81X_HIF_EVT_DATA_TRAFFIC_PAUSE_PEND));
+
+	if (!mps->enable)
+		return;
+
+	needs_wake = (mps->wakers > 0);
+	needs_wake |= (flags_on_entry > 0);
+	needs_wake |= (mm81x_hif_get_tx_buffered_count(mm) > 0);
+
+	if (needs_wake) {
+		mm81x_ps_wakeup(mps);
+		return;
+	}
+
+	if (!mm81x_ps_is_busy_pin_asserted(mm)) {
+		mm81x_ps_sleep(mps);
+		return;
+	}
+
+	expire = msecs_to_jiffies(DEFAULT_BUS_TIMEOUT_MS);
+	cancel_delayed_work(&mps->delayed_eval_work);
+	queue_delayed_work(mm->chip_wq, &mps->delayed_eval_work, expire);
+}
+
+static void mm81x_ps_evaluate_work(struct work_struct *work)
+{
+	struct mm81x_ps *mps =
+		container_of(work, struct mm81x_ps, delayed_eval_work.work);
+
+	if (mps->enable) {
+		mutex_lock(&mps->lock);
+		mm81x_ps_evaluate(mps);
+		mutex_unlock(&mps->lock);
+	}
+}
+
+static int mm81x_ps_irq_init(struct mm81x *mm)
+{
+	int irq;
+	struct mm81x_ps *mps = &mm->ps;
+
+	if (!mm->ps.gpios_supported)
+		return 0;
+
+	irq = gpiod_to_irq(mm->ps.busy_gpio);
+	if (irq < 0)
+		return irq;
+
+	return request_irq(irq, (irq_handler_t)mm81x_ps_irq_handle,
+			   (mm->firmware_flags &
+			    MM81X_FW_FLAGS_BUSY_ACTIVE_LOW) ?
+				   IRQF_TRIGGER_FALLING :
+				   IRQF_TRIGGER_RISING,
+			   "mm81x_notify", mps);
+}
+
+static void mm81x_ps_irq_deinit(struct mm81x *mm)
+{
+	struct mm81x_ps *mps = &mm->ps;
+
+	if (mm->ps.gpios_supported)
+		free_irq(gpiod_to_irq(mm->ps.busy_gpio), mps);
+}
+
+void mm81x_ps_enable(struct mm81x *mm)
+{
+	struct mm81x_ps *mps = &mm->ps;
+
+	if (mps->enable) {
+		mutex_lock(&mps->lock);
+		if (mps->wakers == 0) {
+			WARN_ON_ONCE(1);
+		} else {
+			mps->wakers--;
+			mm81x_ps_evaluate(mps);
+		}
+		mutex_unlock(&mps->lock);
+	}
+}
+
+void mm81x_ps_disable(struct mm81x *mm)
+{
+	struct mm81x_ps *mps = &mm->ps;
+
+	if (mps->enable) {
+		mutex_lock(&mps->lock);
+		mps->wakers++;
+		mm81x_ps_evaluate(mps);
+		mutex_unlock(&mps->lock);
+	}
+}
+
+int mm81x_ps_init(struct mm81x *mm)
+{
+	struct mm81x_ps *mps = &mm->ps;
+
+	mps->enable = !(mm->bus_type == MM81X_BUS_TYPE_SDIO &&
+			!mm->ps.gpios_supported);
+	mps->suspended = true;
+	mps->wakers = 1; /* we default to being on */
+	mutex_init(&mps->lock);
+
+	INIT_WORK(&mps->async_wake_work, mm81x_ps_async_wake_work);
+	INIT_DELAYED_WORK(&mps->delayed_eval_work, mm81x_ps_evaluate_work);
+
+	return mm81x_ps_irq_init(mm);
+}
+
+void mm81x_ps_finish(struct mm81x *mm)
+{
+	struct mm81x_ps *mps = &mm->ps;
+
+	if (mps->enable) {
+		mps->enable = false;
+		mm81x_ps_irq_deinit(mm);
+		cancel_work_sync(&mps->async_wake_work);
+		cancel_delayed_work_sync(&mps->delayed_eval_work);
+	}
+}
-- 
2.43.0


