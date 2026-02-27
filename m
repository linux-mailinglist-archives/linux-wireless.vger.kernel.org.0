Return-Path: <linux-wireless+bounces-32262-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6KRTBp0coWlhqQQAu9opvQ
	(envelope-from <linux-wireless+bounces-32262-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 05:25:01 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 300B91B2A9B
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 05:25:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B67083173A8E
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 04:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1AF9346E46;
	Fri, 27 Feb 2026 04:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="Ik4GWRnv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1529B34574B
	for <linux-wireless@vger.kernel.org>; Fri, 27 Feb 2026 04:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772165653; cv=none; b=DMnCjHmQjVNOMnA3g1lyipw911Ttq0/NOz2wDBeYRie8GPAfCwwDIZWsIA7zQ2j+K/xzbmOYZ74+ZDQAKQA41BAWdcD2ABMKNWDu0vx72xA3L+KQTIedXJmB6frV94NB8OGSJv1dvY4zNpN0fY5W/v62vpS8wdr46qMLUIfLfSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772165653; c=relaxed/simple;
	bh=QvhRd/k3fbHAPDr6LTLRsZ6U+Lav7Gjr8aqtxWuKNqE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aFaRBUEsj7uhwNvDp3iBDqecFoC+xHZx3PYv9eEIDrHsAZ/LGaIsdLbiUT4rZ1AIGG+UV/jHwIHB49NDFsEFZM4v4+BLb/zuoNePLQbkc9wKtEAF4S9EPVn50GUL2ir5btzTk2s63IQ06dgeKGvKijQ3ladU9KmEPs0W3srOWlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=Ik4GWRnv; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2ab232cc803so8542675ad.3
        for <linux-wireless@vger.kernel.org>; Thu, 26 Feb 2026 20:14:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1772165651; x=1772770451; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R2ITqWlcyWbskRFIKd0WjZ3UJROnX6P7UpySd9pdiiQ=;
        b=Ik4GWRnv07fA103FK/d1zuzU4twk1UgwlaRpT/94dscJfcpMiZUk0fiu2YfFRCURSI
         xJ3AvCIxF54iJZJJO+XtvOvs8w9ccJDztnV2UfbQG7aldjstx6XZEbAoD49KHjVOfv/u
         lqtWW3AOuUhCsjgNulL8leoDEqGmyEFPpGmOsl53wmgImw56Qhb7LzOne/Q/MFMBdcfL
         ETb26Bk6LiMT832fb00k4HVnoK2noeqUeYY+g9v6E19S3EDpyDc3WjCIenSkVCOZ/4wS
         nz5bXkG9f5Mqh2WY+0F8ROj80k/y1ORkfx6XCT16sp7/YQ3ToFA+M8s0N7Enc3862Nq9
         1RBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772165651; x=1772770451;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=R2ITqWlcyWbskRFIKd0WjZ3UJROnX6P7UpySd9pdiiQ=;
        b=RW1G6kfWyiupoCK5sCQE8WXZXOECmk1heldg9YCZyH8CxKgo4N1R+Nh9VRE0J4bnT5
         8oRI325U6aaK8qEY5Y5ZAIGWSiMa0X6cKoDN6j3362bmR4uG6VrJ++gZuxhTCTF6PQLh
         VSaxIHy1fmLp8lchJqsWQDZbY2HoRvsXR6U2IobhnPMZwYHYKsxGxOS3YmZfKrqOX6iD
         HNLWaTNvYgz0MQ00VffE+GiojVJjZkBl+hH/c5HjSQwmFUlFARc5vV9fNG+cRSvry0ci
         VlyYMb+Xleb3Wl1Fe/4b9IlqDaoMx0RlKdEEPYzbiCEb5GeKP+y8GclooK1Uxs7kFU78
         HQuw==
X-Forwarded-Encrypted: i=1; AJvYcCXSaR7HCSARvf49bF4l0fsWKsW1wXW21VvpASQEDXfcxHbLs2ed4AEIIYtbn9Ywds7dzI7dD5gzNyW3eLrmlQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyEPuSDnZKKk1F/T+CBet5NtYjXmEom6BvsZHx9CB7aDt2zkocM
	QrkslOfGNujSbfZ4G2mNfCpBCc0YDAazvlOKWhhUzutqTjhwLA51mlUHP1xwngnffB8=
X-Gm-Gg: ATEYQzz32YP7WLylIHd3b+jjRewt6wL/v2H2Yqiba/00oNL3UpPRd/lS9HyPL2QVsLY
	av9ldV8QXDB+5ROYJK9FNrFzQaET7ZiDSRPM5LXh3vJ3q4ZGUYHFMrS6tuIIRciGz7yfNdzD3kJ
	4ryKGG9lhJ5cZicyb66hqV1bv8YIOAGAhT3hTMYoUTaZWmgouF9Q40EfT8k3LQy/76NoHWrGDDm
	F+ns+RVW7fvVbrB3yG5NgrKuE7lNNWLU1/y3K76qvsIHGlqXnJ47xR9mTebnp3/QbyZmhqfFg4K
	pdCSRXb6bsQGtR8Ix6Suw5hOAqSR3HhIHU5In4tRDUU4oJjUD0EaQU0G3/TZpZRk8ULN2cfs3L9
	0sICjJaDoqeiIMuklk1gMSrPOCWWbhYIWL1h+gYcXD8ooD5j3RMmTRHnjv+v7mJ5Xu3X2ftIYDZ
	r126U+TC4sCJu3Yo6gbvUEpWjEoPtLsIrgyWNTKUKu6MAAxS+pq+aKQvC3Tf6zJJDmfrkkKz41A
	DgwPs8CJX53oLVOoDQrhHmJwZRAyFKiA26X8/uCrA==
X-Received: by 2002:a17:903:2289:b0:2a0:e223:f6e6 with SMTP id d9443c01a7336-2ae2e4d6622mr14213735ad.46.1772165651304;
        Thu, 26 Feb 2026 20:14:11 -0800 (PST)
Received: from mma-H9MHD44.lan (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb6ba5eesm41682865ad.68.2026.02.26.20.14.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 20:14:11 -0800 (PST)
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>,
	Dan Callaghan <dan.callaghan@morsemicro.com>,
	Arien Judge <arien.judge@morsemicro.com>
Cc: ayman.grais@morsemicro.com,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH wireless-next 23/35] wifi: mm81x: add sdio.c
Date: Fri, 27 Feb 2026 15:10:33 +1100
Message-ID: <20260227041108.66508-24-lachlan.hodges@morsemicro.com>
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
	TAGGED_FROM(0.00)[bounces-32262-lists,linux-wireless=lfdr.de];
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
X-Rspamd-Queue-Id: 300B91B2A9B
X-Rspamd-Action: no action

(Patches split per file for review, see cover letter for more
information)

Signed-off-by: Lachlan Hodges <lachlan.hodges@morsemicro.com>
---
 drivers/net/wireless/morsemicro/mm81x/sdio.c | 803 +++++++++++++++++++
 1 file changed, 803 insertions(+)
 create mode 100644 drivers/net/wireless/morsemicro/mm81x/sdio.c

diff --git a/drivers/net/wireless/morsemicro/mm81x/sdio.c b/drivers/net/wireless/morsemicro/mm81x/sdio.c
new file mode 100644
index 000000000000..260d7075984e
--- /dev/null
+++ b/drivers/net/wireless/morsemicro/mm81x/sdio.c
@@ -0,0 +1,803 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2017-2026 Morse Micro
+ */
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/workqueue.h>
+#include <linux/mmc/card.h>
+#include <linux/mmc/mmc.h>
+#include <linux/mmc/host.h>
+#include <linux/mmc/sdio_func.h>
+#include <linux/mmc/sdio_ids.h>
+#include <linux/mmc/sdio.h>
+#include <linux/mmc/sd.h>
+#include <linux/of_gpio.h>
+#include <linux/gpio/consumer.h>
+#include "hw.h"
+#include "core.h"
+#include "bus.h"
+#include "mac.h"
+#include "fw.h"
+#include "debug.h"
+#include "hif.h"
+
+/*
+ * Value to indicate that the base address for bulk/register
+ * read/writes has yet to be set
+ */
+#define MM81X_SDIO_BASE_ADDR_UNSET 0xFFFFFFFF
+
+#define MM81X_SDIO_ALIGNMENT (8)
+
+#define MM81X_SDIO_REG_ADDRESS_BASE 0x10000
+#define MM81X_SDIO_REG_ADDRESS_WINDOW_0 MM81X_SDIO_REG_ADDRESS_BASE
+#define MM81X_SDIO_REG_ADDRESS_WINDOW_1 (MM81X_SDIO_REG_ADDRESS_BASE + 1)
+#define MM81X_SDIO_REG_ADDRESS_CONFIG (MM81X_SDIO_REG_ADDRESS_BASE + 2)
+
+struct mm81x_sdio {
+	bool enabled;
+	u32 bulk_addr_base;
+	u32 register_addr_base;
+	struct sdio_func *func;
+	const struct sdio_device_id *id;
+};
+
+static void mm81x_sdio_of_probe(struct device *dev, struct mm81x_ps *ps,
+				const struct of_device_id *match_table)
+{
+	struct device_node *np = dev->of_node;
+	const struct of_device_id *of_id;
+
+	if (!np) {
+		dev_warn(dev, "Device node not found\n");
+		return;
+	}
+
+	of_id = of_match_node(match_table, np);
+	if (!of_id) {
+		dev_warn(dev, "Couldn't match device table\n");
+		return;
+	}
+
+	ps->wake_gpio = devm_gpiod_get_optional(dev, "wake", GPIOD_OUT_HIGH);
+	ps->busy_gpio = devm_gpiod_get_optional(dev, "busy", GPIOD_IN);
+
+	ps->gpios_supported = (!IS_ERR_OR_NULL(ps->wake_gpio) &&
+			       !IS_ERR_OR_NULL(ps->busy_gpio));
+	if (!ps->gpios_supported) {
+		dev_warn(
+			dev,
+			"wake-gpios and busy-gpios not defined, powersave disabled\n");
+	}
+}
+
+static void mm81x_sdio_remove(struct sdio_func *func);
+
+static void sdio_log_err(struct mm81x_sdio *sdio, const char *operation,
+			 unsigned int fn, unsigned int address,
+			 unsigned int len, int ret)
+{
+	struct mm81x *mm = sdio->func ? sdio_get_drvdata(sdio->func) : NULL;
+
+	if (!mm)
+		return;
+
+	mm81x_err(mm, "sdio: %s fn=%d 0x%08x:%d r=0x%08x b=0x%08x (ret:%d)",
+		  operation, fn, address, len, sdio->register_addr_base,
+		  sdio->bulk_addr_base, ret);
+}
+
+static void irq_handler(struct sdio_func *func1)
+{
+	int handled;
+	struct sdio_func *func = func1->card->sdio_func[1];
+	struct mm81x *mm = sdio_get_drvdata(func);
+	struct mm81x_sdio *sdio = (struct mm81x_sdio *)mm->drv_priv;
+
+	WARN_ON_ONCE(!mm);
+
+	(void)sdio;
+
+	handled = mm81x_hw_irq_handle(mm);
+	if (!handled)
+		mm81x_dbg(mm, MM81X_DBG_SDIO, "%s: nothing was handled\n",
+			  __func__);
+}
+
+static int mm81x_sdio_enable_irq(struct mm81x_sdio *sdio)
+{
+	int ret;
+	struct sdio_func *func = sdio->func;
+	struct sdio_func *func1 = func->card->sdio_func[0];
+	struct mm81x *mm = sdio_get_drvdata(func);
+
+	sdio_claim_host(func);
+	ret = sdio_claim_irq(func1, irq_handler);
+	if (ret)
+		mm81x_err(mm, "Failed to enable sdio irq: %d\n", ret);
+
+	sdio_release_host(func);
+	return ret;
+}
+
+static void mm81x_sdio_disable_irq(struct mm81x_sdio *sdio)
+{
+	struct sdio_func *func = sdio->func;
+	struct sdio_func *func1 = func->card->sdio_func[0];
+
+	sdio_claim_host(func);
+	sdio_release_irq(func1);
+	sdio_release_host(func);
+}
+
+static void mm81x_sdio_set_irq(struct mm81x *mm, bool enable)
+{
+	struct mm81x_sdio *sdio = (struct mm81x_sdio *)mm->drv_priv;
+
+	if (enable)
+		mm81x_sdio_enable_irq(sdio);
+	else
+		mm81x_sdio_disable_irq(sdio);
+}
+
+static u32 mm81x_sdio_calculate_base_address(u32 address, u8 access)
+{
+	return (address & MM81X_SDIO_RW_ADDR_BOUNDARY_MASK) | (access & 0x3);
+}
+
+static void mm81x_sdio_reset_base_address(struct mm81x_sdio *sdio)
+{
+	sdio->bulk_addr_base = MM81X_SDIO_BASE_ADDR_UNSET;
+	sdio->register_addr_base = MM81X_SDIO_BASE_ADDR_UNSET;
+}
+
+static int mm81x_sdio_set_func_address_base(struct mm81x_sdio *sdio,
+					    u32 address, u8 access, bool bulk)
+{
+	int ret = 0;
+	u8 base[4];
+	const char *operation = "set_address_base";
+	u32 calculated_addr_base =
+		mm81x_sdio_calculate_base_address(address, access);
+	u32 *current_addr_base = bulk ? &sdio->bulk_addr_base :
+					&sdio->register_addr_base;
+	bool base_addr_is_unset =
+		(*current_addr_base == MM81X_SDIO_BASE_ADDR_UNSET);
+	struct sdio_func *func2 = sdio->func;
+	struct sdio_func *func1 = sdio->func->card->sdio_func[0];
+	struct sdio_func *func_to_use = bulk ? func2 : func1;
+	struct mm81x *mm = sdio_get_drvdata(sdio->func);
+	int retries = 0;
+	static const int max_retries = 3;
+
+	if ((*current_addr_base) == calculated_addr_base && !base_addr_is_unset)
+		return ret;
+
+	base[0] = (u8)((address & 0x00FF0000) >> 16);
+	base[1] = (u8)((address & 0xFF000000) >> 24);
+	base[2] = access & 0x3; /* 1, 2 or 4 byte access */
+
+retry:
+	if (base_addr_is_unset ||
+	    (base[0] != (u8)(((*current_addr_base) & 0x00FF0000) >> 16))) {
+		sdio_writeb(func_to_use, base[0],
+			    MM81X_SDIO_REG_ADDRESS_WINDOW_0, &ret);
+		if (ret) {
+			sdio_log_err(sdio, operation, func_to_use->num,
+				     MM81X_SDIO_REG_ADDRESS_WINDOW_0, 1, ret);
+			goto err;
+		}
+	}
+
+	if (base_addr_is_unset ||
+	    (base[1] != (u8)(((*current_addr_base) & 0xFF000000) >> 24))) {
+		sdio_writeb(func_to_use, base[1],
+			    MM81X_SDIO_REG_ADDRESS_WINDOW_1, &ret);
+		if (ret) {
+			sdio_log_err(sdio, operation, func_to_use->num,
+				     MM81X_SDIO_REG_ADDRESS_WINDOW_1, 1, ret);
+			goto err;
+		}
+	}
+
+	if (base_addr_is_unset ||
+	    (base[2] != (u8)(((*current_addr_base) & 0x3)))) {
+		sdio_writeb(func_to_use, base[2], MM81X_SDIO_REG_ADDRESS_CONFIG,
+			    &ret);
+		if (ret) {
+			sdio_log_err(sdio, operation, func_to_use->num,
+				     MM81X_SDIO_REG_ADDRESS_CONFIG, 1, ret);
+			goto err;
+		}
+	}
+
+	*current_addr_base = calculated_addr_base;
+	if (retries)
+		mm81x_dbg(mm, MM81X_DBG_SDIO, "%s succeeded after %d retries\n",
+			  __func__, retries);
+
+	return ret;
+err:
+	retries++;
+	if (ret == -ETIMEDOUT && retries <= max_retries) {
+		mm81x_dbg(mm, MM81X_DBG_SDIO,
+			  "%s failed (%d), retrying (%d/%d)\n", __func__, ret,
+			  retries, max_retries);
+		goto retry;
+	}
+
+	*current_addr_base = MM81X_SDIO_BASE_ADDR_UNSET;
+	return ret;
+}
+
+static struct sdio_func *mm81x_sdio_get_func(struct mm81x_sdio *sdio,
+					     u32 address, ssize_t size,
+					     u8 access)
+{
+	int ret = 0;
+	u32 calculated_base_address =
+		mm81x_sdio_calculate_base_address(address, access);
+	struct sdio_func *func2 = sdio->func;
+	struct sdio_func *func1 = sdio->func ? sdio->func->card->sdio_func[0] :
+					       NULL;
+	struct mm81x *mm = sdio->func ? sdio_get_drvdata(sdio->func) : NULL;
+	struct sdio_func *func_to_use;
+
+	WARN_ON(!mm);
+
+	/* Order matters here, please don't re-order */
+	if (size > sizeof(u32)) {
+		ret = mm81x_sdio_set_func_address_base(sdio, address, access,
+						       true);
+		WARN_ON_ONCE(sdio->bulk_addr_base == 0);
+		func_to_use = func2;
+	} else if (sdio->bulk_addr_base == calculated_base_address && func2) {
+		func_to_use = func2;
+	} else if (func1) {
+		ret = mm81x_sdio_set_func_address_base(sdio, address, access,
+						       false);
+		WARN_ON_ONCE(sdio->register_addr_base == 0);
+		func_to_use = func1;
+	} else {
+		ret = mm81x_sdio_set_func_address_base(sdio, address, access,
+						       true);
+		WARN_ON_ONCE(sdio->bulk_addr_base == 0);
+		func_to_use = func2;
+	}
+
+	return ret ? NULL : func_to_use;
+}
+
+static int mm81x_sdio_regl_write(struct mm81x_sdio *sdio, u32 address,
+				 u32 value)
+{
+	ssize_t ret = 0;
+	struct mm81x *mm = sdio->func ? sdio_get_drvdata(sdio->func) : NULL;
+	u32 original_address = address;
+	struct sdio_func *func_to_use;
+
+	if (!mm) {
+		ret = -EINVAL;
+		goto exit;
+	}
+
+	func_to_use = mm81x_sdio_get_func(sdio, address, sizeof(u32),
+					  MM81X_CONFIG_ACCESS_4BYTE);
+	if (!func_to_use) {
+		ret = -EIO;
+		goto exit;
+	}
+
+	address &= 0x0000FFFF; /* remove base and keep offset */
+	sdio_writel(func_to_use, (__force u32)cpu_to_le32(value),
+		    (__force u32)cpu_to_le32(address), (int *)&ret);
+
+	if (ret)
+		sdio_log_err(sdio, "writel", func_to_use->num, address,
+			     sizeof(u32), ret);
+	else
+		ret = sizeof(value);
+
+	if (original_address == MM81X_REG_RESET(mm) &&
+	    value == MM81X_REG_RESET_VALUE(mm)) {
+		mm81x_dbg(mm, MM81X_DBG_SDIO,
+			  "SDIO reset detected, invalidating base addr\n");
+		mm81x_sdio_reset_base_address(sdio);
+	}
+exit:
+	return (int)ret;
+}
+
+static int mm81x_sdio_regl_read(struct mm81x_sdio *sdio, u32 address,
+				u32 *value)
+{
+	ssize_t ret = 0;
+	struct mm81x *mm = sdio->func ? sdio_get_drvdata(sdio->func) : NULL;
+	struct sdio_func *func_to_use;
+
+	if (!mm) {
+		ret = -EINVAL;
+		goto exit;
+	}
+
+	func_to_use = mm81x_sdio_get_func(sdio, address, sizeof(u32),
+					  MM81X_CONFIG_ACCESS_4BYTE);
+	if (!func_to_use) {
+		ret = -EIO;
+		goto exit;
+	}
+
+	address &= 0x0000FFFF; /* remove base and keep offset */
+	*value = sdio_readl(func_to_use, (__force u32)cpu_to_le32(address),
+			    (int *)&ret);
+	if (ret)
+		sdio_log_err(sdio, "readl", func_to_use->num, address,
+			     sizeof(u32), ret);
+	else
+		ret = sizeof(*value);
+exit:
+	return (int)ret;
+}
+
+static int mm81x_sdio_mem_write(struct mm81x_sdio *sdio, u32 address, u8 *data,
+				ssize_t size)
+{
+	ssize_t ret = 0;
+	struct mm81x *mm = sdio->func ? sdio_get_drvdata(sdio->func) : NULL;
+	int access = (size & 0x03) ? MM81X_CONFIG_ACCESS_1BYTE :
+				     MM81X_CONFIG_ACCESS_4BYTE;
+	struct sdio_func *func_to_use;
+
+	if (!mm) {
+		ret = -EINVAL;
+		goto exit;
+	}
+
+	func_to_use = mm81x_sdio_get_func(sdio, address, size, access);
+	if (!func_to_use) {
+		ret = -EIO;
+		goto exit;
+	}
+
+	address &= 0x0000FFFF; /* remove base and keep offset */
+	if (access == MM81X_CONFIG_ACCESS_4BYTE) {
+		if (unlikely(!IS_ALIGNED((uintptr_t)data,
+					 mm->bus_ops->bulk_alignment))) {
+			ret = -EBADE;
+			goto exit;
+		}
+
+		/* Use ex write */
+		ret = sdio_memcpy_toio(func_to_use, address, data, size);
+
+		if (ret) {
+			sdio_log_err(sdio, "memcpy_toio", func_to_use->num,
+				     address, size, ret);
+			goto exit;
+		}
+	} else {
+		int i;
+
+		for (i = 0; i < size; i++) {
+			sdio_writeb(func_to_use, data[i], address + i,
+				    (int *)&ret);
+			if (ret) {
+				sdio_log_err(sdio, "writeb", func_to_use->num,
+					     address + i, 1, ret);
+				goto exit;
+			}
+		}
+	}
+	ret = size;
+exit:
+	return ret;
+}
+
+static void mm81x_sdio_claim_host(struct mm81x *mm)
+{
+	struct mm81x_sdio *sdio = (struct mm81x_sdio *)mm->drv_priv;
+	struct sdio_func *func = sdio->func;
+
+	sdio_claim_host(func);
+}
+
+static void mm81x_sdio_release_host(struct mm81x *mm)
+{
+	struct mm81x_sdio *sdio = (struct mm81x_sdio *)mm->drv_priv;
+	struct sdio_func *func = sdio->func;
+
+	sdio_release_host(func);
+}
+
+static int mm81x_sdio_mem_read(struct mm81x_sdio *sdio, u32 address, u8 *data,
+			       ssize_t size)
+{
+	ssize_t ret = 0;
+	struct mm81x *mm = sdio->func ? sdio_get_drvdata(sdio->func) : NULL;
+	int access = (size & 0x03) ? MM81X_CONFIG_ACCESS_1BYTE :
+				     MM81X_CONFIG_ACCESS_4BYTE;
+	struct sdio_func *func_to_use;
+
+	if (!mm) {
+		ret = -EINVAL;
+		goto exit;
+	}
+
+	func_to_use = mm81x_sdio_get_func(sdio, address, size, access);
+	if (!func_to_use) {
+		ret = -EIO;
+		goto exit;
+	}
+
+	address &= 0x0000FFFF; /* remove base and keep offset */
+	if (access == MM81X_CONFIG_ACCESS_4BYTE) {
+		if (unlikely(!IS_ALIGNED((uintptr_t)data,
+					 mm->bus_ops->bulk_alignment))) {
+			ret = -EBADE;
+			goto exit;
+		}
+
+		ret = sdio_memcpy_fromio(func_to_use, data, address, size);
+		if (ret) {
+			sdio_log_err(sdio, "memcpy_fromio", func_to_use->num,
+				     address, size, ret);
+			goto exit;
+		}
+
+		/*
+		 * Observed sometimes that SDIO read repeats the first 4-bytes
+		 * word twice, overwriting second word (hence, tail will be
+		 * overwritten with 'sync' byte). When this happens, reading
+		 * will fetch the correct word. NB: if repeated again, pass it
+		 * anyway and upper layers will handle it
+		 */
+		if (size >= 8 && memcmp(data, data + 4, 4) == 0)
+			sdio_memcpy_fromio(func_to_use, data, address, 8);
+	} else {
+		int i;
+
+		for (i = 0; i < size; i++) {
+			data[i] = sdio_readb(func_to_use, address + i,
+					     (int *)&ret);
+			if (ret) {
+				sdio_log_err(sdio, "readb", func_to_use->num,
+					     address + i, 1, ret);
+				goto exit;
+			}
+		}
+	}
+	ret = size;
+exit:
+	return ret;
+}
+
+static int mm81x_sdio_dm_write(struct mm81x *mm, u32 address, const u8 *data,
+			       int len)
+{
+	int ret = 0;
+	struct mm81x_sdio *sdio = (struct mm81x_sdio *)mm->drv_priv;
+	int remaining = len;
+	int offset = 0;
+
+	if (WARN_ON(len < 0))
+		return -EINVAL;
+
+	while (remaining > 0) {
+		/*
+		 * We can only write up to the end of a single window in
+		 * each write operation.
+		 */
+		u32 window_end = (address + offset) |
+				 ~MM81X_SDIO_RW_ADDR_BOUNDARY_MASK;
+
+		len = min(remaining, (int)(window_end + 1 - address - offset));
+		ret = mm81x_sdio_mem_write(sdio, address + offset,
+					   (u8 *)(data + offset), len);
+		if (ret != len)
+			return -EIO;
+
+		offset += len;
+		WARN_ON_ONCE(len > remaining);
+		remaining -= len;
+	}
+
+	return 0;
+}
+
+static int mm81x_sdio_dm_read(struct mm81x *mm, u32 address, u8 *data, int len)
+{
+	int ret = 0;
+	struct mm81x_sdio *sdio = (struct mm81x_sdio *)mm->drv_priv;
+	int remaining = len;
+	int offset = 0;
+
+	if (WARN_ON(len < 0))
+		return -EINVAL;
+
+	WARN_ON_ONCE(len % 4);
+
+	while (remaining > 0) {
+		/*
+		 * We can only read up to the end of a single window in
+		 * each read operation.
+		 */
+		u32 window_end = (address + offset) |
+				 ~MM81X_SDIO_RW_ADDR_BOUNDARY_MASK;
+
+		len = min(remaining, (int)(window_end + 1 - address - offset));
+		ret = mm81x_sdio_mem_read(sdio, address + offset, data + offset,
+					  len);
+		if (ret != len)
+			return -EIO;
+
+		offset += len;
+		WARN_ON_ONCE(len > remaining);
+		remaining -= len;
+	}
+
+	return 0;
+}
+
+static int mm81x_sdio_reg32_write(struct mm81x *mm, u32 address, u32 val)
+{
+	ssize_t ret = 0;
+	struct mm81x_sdio *sdio = (struct mm81x_sdio *)mm->drv_priv;
+
+	ret = mm81x_sdio_regl_write(sdio, address, val);
+	if (ret == sizeof(val))
+		return 0;
+
+	return -EIO;
+}
+
+static int mm81x_sdio_reg32_read(struct mm81x *mm, u32 address, u32 *val)
+{
+	ssize_t ret = 0;
+	struct mm81x_sdio *sdio = (struct mm81x_sdio *)mm->drv_priv;
+
+	ret = mm81x_sdio_regl_read(sdio, address, val);
+	if (ret == sizeof(*val)) {
+		*val = le32_to_cpup((__le32 *)val);
+		return 0;
+	}
+	return -EIO;
+}
+
+static void mm81x_sdio_bus_enable(struct mm81x *mm, bool enable)
+{
+	struct mm81x_sdio *sdio = (struct mm81x_sdio *)mm->drv_priv;
+	struct sdio_func *func = sdio->func;
+	struct mmc_host *host = func->card->host;
+
+	sdio_claim_host(func);
+
+	if (enable) {
+		/*
+		 * No need to do anything special to re-enable the sdio bus.
+		 * This will happen automatically when a read/write is
+		 * attempted and sdio->bulk_addr_base == 0.
+		 */
+		sdio->enabled = true;
+		host->ops->enable_sdio_irq(host, 1);
+		mm81x_dbg(mm, MM81X_DBG_SDIO, "%s: enabling bus\n", __func__);
+	} else {
+		host->ops->enable_sdio_irq(host, 0);
+		mm81x_sdio_reset_base_address(sdio);
+		sdio->enabled = false;
+		mm81x_dbg(mm, MM81X_DBG_SDIO, "%s: disabling bus\n", __func__);
+	}
+
+	sdio_release_host(func);
+}
+
+static void mm81x_sdio_reset(struct sdio_func *func)
+{
+	/* reset the adapter */
+	sdio_claim_host(func);
+	sdio_disable_func(func);
+	sdio_release_host(func);
+
+	mdelay(20);
+
+	sdio_claim_host(func);
+	sdio_disable_func(func);
+	mmc_hw_reset(func->card);
+	sdio_enable_func(func);
+	sdio_release_host(func);
+}
+
+static void mm81x_sdio_config_burst_mode(struct mm81x *mm, bool enable_burst)
+{
+	u8 burst_mode = (enable_burst) ? SDIO_WORD_BURST_SIZE_16 :
+					 SDIO_WORD_BURST_DISABLE;
+
+	mm81x_hw_enable_burst_mode(mm, burst_mode);
+}
+
+static const struct mm81x_bus_ops mm81x_sdio_ops = {
+	.dm_read = mm81x_sdio_dm_read,
+	.dm_write = mm81x_sdio_dm_write,
+	.reg32_read = mm81x_sdio_reg32_read,
+	.reg32_write = mm81x_sdio_reg32_write,
+	.set_bus_enable = mm81x_sdio_bus_enable,
+	.claim = mm81x_sdio_claim_host,
+	.release = mm81x_sdio_release_host,
+	.config_burst_mode = mm81x_sdio_config_burst_mode,
+	.set_irq = mm81x_sdio_set_irq,
+	.bulk_alignment = MM81X_SDIO_ALIGNMENT
+};
+
+static int mm81x_sdio_enable(struct mm81x_sdio *sdio)
+{
+	int ret;
+	struct sdio_func *func = sdio->func;
+	struct mm81x *mm = sdio_get_drvdata(func);
+
+	sdio_claim_host(func);
+	ret = sdio_enable_func(func);
+	if (ret)
+		mm81x_err(mm, "sdio_enable_func failed: %d\n", ret);
+	sdio_release_host(func);
+	return ret;
+}
+
+static void mm81x_sdio_release(struct mm81x_sdio *sdio)
+{
+	struct sdio_func *func = sdio->func;
+
+	sdio_claim_host(func);
+	sdio_disable_func(func);
+	sdio_release_host(func);
+}
+
+static const struct of_device_id mm81x_of_match_table[] = {
+	{
+		.compatible = "morsemicro,mm81x",
+	},
+	{},
+};
+
+static int mm81x_sdio_probe(struct sdio_func *func,
+			    const struct sdio_device_id *id)
+{
+	int ret = 0;
+	u32 chip_id;
+	struct mm81x *mm = NULL;
+	struct mm81x_sdio *sdio;
+	struct device *dev = &func->dev;
+
+	if (func->num == 1)
+		return 0;
+
+	if (func->num != 2)
+		return -ENODEV;
+
+	mm = mm81x_mac_create(sizeof(*sdio), dev);
+	if (!mm) {
+		dev_err(dev, "mm81x_mac_create failed\n");
+		return -ENOMEM;
+	}
+
+	mm->bus_ops = &mm81x_sdio_ops;
+	mm->bus_type = MM81X_BUS_TYPE_SDIO;
+
+	sdio = (struct mm81x_sdio *)mm->drv_priv;
+	sdio->func = func;
+	sdio->id = id;
+	sdio->enabled = true;
+	mm81x_sdio_reset_base_address(sdio);
+
+	sdio_set_drvdata(func, mm);
+
+	ret = mm81x_sdio_enable(sdio);
+	if (ret) {
+		mm81x_err(mm, "mm81x_sdio_enable failed: %d\n", ret);
+		goto err_destroy_mac;
+	}
+
+	ret = mm81x_core_attach_regs(mm);
+	if (ret) {
+		mm81x_err(mm, "mm81x_core_attach_regs failed: %d\n", ret);
+		goto err_destroy_sdio;
+	}
+
+	mm81x_claim_bus(mm);
+	ret = mm81x_reg32_read(mm, MM81X_REG_CHIP_ID(mm), &chip_id);
+	mm81x_release_bus(mm);
+	if (ret || chip_id != mm->chip_id) {
+		mm81x_err(mm, "Chip ID read failed: %d\n", ret);
+		goto err_destroy_sdio;
+	}
+
+	mm81x_dbg(mm, MM81X_DBG_SDIO,
+		  "Morse Micro SDIO device found, chip ID=0x%04x\n",
+		  mm->chip_id);
+
+	mm81x_sdio_of_probe(dev, &mm->ps, mm81x_of_match_table);
+	mm81x_sdio_config_burst_mode(mm, true);
+
+	mm81x_core_init_mac_addr(mm);
+
+	ret = mm81x_core_create(mm);
+	if (ret)
+		goto err_destroy_sdio;
+
+	ret = mm81x_sdio_enable_irq(sdio);
+	if (ret) {
+		mm81x_err(mm, "mm81x_sdio_enable_irq failed: %d\n", ret);
+		goto err_destroy_core;
+	}
+
+	ret = mm81x_mac_register(mm);
+	if (ret) {
+		mm81x_err(mm, "mm81x_mac_register failed: %d\n", ret);
+		goto err_disable_irq;
+	}
+
+	return 0;
+
+err_disable_irq:
+	mm81x_sdio_disable_irq(sdio);
+err_destroy_core:
+	mm81x_core_destroy(mm);
+err_destroy_sdio:
+	mm81x_sdio_release(sdio);
+err_destroy_mac:
+	mm81x_mac_destroy(mm);
+	return ret;
+}
+
+static void mm81x_sdio_remove(struct sdio_func *func)
+{
+	struct mm81x *mm = sdio_get_drvdata(func);
+	struct mm81x_sdio *sdio = (struct mm81x_sdio *)mm->drv_priv;
+
+	dev_info(&func->dev, "sdio removed func %d vendor 0x%x device 0x%x\n",
+		 func->num, func->vendor, func->device);
+
+	if (!mm)
+		return;
+
+	mm81x_mac_unregister(mm);
+	mm81x_sdio_disable_irq(sdio);
+	mm81x_core_destroy(mm);
+	mm81x_sdio_release(sdio);
+	mm81x_sdio_reset(func);
+	mm81x_mac_destroy(mm);
+	sdio_set_drvdata(func, NULL);
+}
+
+static const struct sdio_device_id mm81x_sdio_devices[] = {
+	{ SDIO_DEVICE(SDIO_VENDOR_ID_MORSEMICRO,
+		      SDIO_VENDOR_ID_MORSEMICRO_MM81XB1) },
+	{ SDIO_DEVICE(SDIO_VENDOR_ID_MORSEMICRO,
+		      SDIO_VENDOR_ID_MORSEMICRO_MM81XB2) },
+	{},
+};
+
+MODULE_DEVICE_TABLE(sdio, mm81x_sdio_devices);
+
+static struct sdio_driver mm81x_sdio_driver = {
+	.name = "mm81x_sdio",
+	.id_table = mm81x_sdio_devices,
+	.probe = mm81x_sdio_probe,
+	.remove = mm81x_sdio_remove,
+};
+
+int __init mm81x_sdio_init(void)
+{
+	int ret;
+
+	ret = sdio_register_driver(&mm81x_sdio_driver);
+	if (ret)
+		pr_err("sdio_register_driver() failed: %d\n", ret);
+
+	return ret;
+}
+
+void __exit mm81x_sdio_exit(void)
+{
+	sdio_unregister_driver(&mm81x_sdio_driver);
+}
-- 
2.43.0


