Return-Path: <linux-wireless+bounces-38135-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NiYcHeIePmpDAAkAu9opvQ
	(envelope-from <linux-wireless+bounces-38135-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2026 08:40:34 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C4A96CAB4A
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2026 08:40:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=morsemicro-com.20251104.gappssmtp.com header.s=20251104 header.b=MQQVx8xY;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38135-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38135-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=morsemicro.com (policy=none);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F3A463044EE0
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2026 06:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB2F3DB322;
	Fri, 26 Jun 2026 06:32:58 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6CA53DB63A
	for <linux-wireless@vger.kernel.org>; Fri, 26 Jun 2026 06:32:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782455578; cv=none; b=phIcDOHhBRrxANHON/jt+M+ebNyv6JCzHqfJhwKDIZC99spaSv53YSx4Y8Ed44LTqXQRvvVoKHu/eMHhbcorJtcJNoW5TDN4LRr5L5GLg7P229LoSAjc9b2rR48nGLKnwuqK/R1l5AZfzbWvk9DU+ud+ZjSguQ+wHuXeCTNlqp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782455578; c=relaxed/simple;
	bh=dZwsQfzaLEUrPa5HH6zvVLpLWAFCooVVz3R7JtjyqRk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i09aDiY6G9d5ANLfGvISlLIWc78cVaut2nq1S2jYvfpp5qGUAngFOANjBV/suEFM7DxfOn/SWb+kZ3Gi6Kyov4yZK1+A+rUjOMZvbsHY7lh4/GQ/O3aJgkj6ImEiesHLuJmlSv2zdak7fXef9T6R5oHTcOOOK/+Y/hLU8RhsSlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20251104.gappssmtp.com header.i=@morsemicro-com.20251104.gappssmtp.com header.b=MQQVx8xY; arc=none smtp.client-ip=74.125.82.182
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-30c944aacbaso945198eec.1
        for <linux-wireless@vger.kernel.org>; Thu, 25 Jun 2026 23:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20251104.gappssmtp.com; s=20251104; t=1782455576; x=1783060376; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kbJrqLJjGsjQ0IhqbC6qyVO8BU/5GHzwFEAQmS8hMyY=;
        b=MQQVx8xYwWA1eq4ELqcPzt2oiJ0XbwXjru9tGiNiMXPft8JRQIodE3+y78Cg4PENv4
         q2ujz3lWUJeZzIxq/V0k3eYsaKn3eSAMHHq7q693sMyec1e4ZoJ7rTmo9NERk6+//Zn+
         UmamWdqDXc5pG7OiuwBLzGrXIZeqBcBpgOy/i5lx9Gp3UTGeyzHwo58LkVgyez28w8i3
         kHWiL3zO0Yr4EOhYercN+JyNGbJ/AZGxvISbEcdHvvHXPTqp+wYxtoGDjBajjxVHqln4
         izS7CrowhGsbzAfhGzhpk0fLTWO63UD3IS0KWsDYNz1AGxrWKlrdbx2KLdagaZAT7kKn
         f2xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782455576; x=1783060376;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kbJrqLJjGsjQ0IhqbC6qyVO8BU/5GHzwFEAQmS8hMyY=;
        b=Eu5Q6ItrHf9JKHU/vApnva669nKTP5FmcSC6jKikEvS++sD0Jx7Iqr+JhqOvCASAn2
         amBcQEmfXvTIJTIuCQwq9tjxNMN6jm+hX4xyQU59PGeYO3+HpnNyBbebHl1vmpJIt6oA
         sNyv85Qtk/OAojcq6n6FDk5KsvvbziyVuDurz4hl8TABlzCPMoQiHdwjpi6VpsNUw7De
         04ahMm6d2Xgij0EDK5fr/a9J5o4xzUNYTUu2yVjKtLNv/3ezKKEvApOKlFKYlsFW9Ccf
         wyjwpQBZQ1pSIFftSN0C6j9RQL0Jpn9Oay8Qvant6joNNzfFoLH3p5ICuLAxupsCEmu6
         mL5A==
X-Forwarded-Encrypted: i=1; AHgh+RrEY4B9pFjpqBdp0L7AgO+reNXL39CR9FboPMm3dQaUfmqJJMsS5o2yDI2ELUuKu275NRGuFsDuFMdWzzXvsw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzF2Gz/ZmFqaew2+tZXe8skIeY2RTieOSFGQ7j7AW0uXIYLDoe0
	Ly36PZVGWDm2G4N3bjUcbxgHwzQbR9FnJz0pb/zg+eEV6srLb7NoTpAsq0ZH/Y/DTO4=
X-Gm-Gg: AfdE7ckop8ZctWEQImqpe0BXdvdVTdD/LXMVrjKyQzDP586OCJXCvhuGH4VPM/NKjwu
	8w9S9SjT2i0OFlIhzy86ZQblZTw8mbDusU2Bysx2aaazJV9UcA+EvXl8TDshVC4xOOnr/VYVuhN
	9jLg1B91GyYCM+0dSzRUbxpQ+hccpr3O9WENjRvqYP/Rl6U5sD8TE/mdK12PaF/F/8lQ3TlDIsM
	R9pJQTIX7+CK0z5vTijtYxfKu2rBvOUGjm3dkujRCbEpzIgouWN2YNYQQbQa8isVsX9Tqcm/aWu
	NfQrQCH9pYUD4mookzhYMRVDKV4vu3P9hDyQzhvyU80sSigM8UgBxM8LLh/VjuXclV3WQIuFfbf
	yksiyQAcltQpBuEFlmfd0MIQJpM5pr98gidFK/cXIVysp4Kg2O7eE9SwNWjuT/C/5sgTdGpvaUZ
	PjMDCpkYKzvhCDK6XP24ilKFrqrCDjx2LJ4CEIYCKnILoEogrYJ4lMGLMgQgdhGwNFH/KZPL5WF
	FwwN9RL38YzmcBon9hFTDJW+DTqG+8=
X-Received: by 2002:a05:7300:6ca7:b0:30c:4f01:2219 with SMTP id 5a478bee46e88-30c84d9b515mr5173952eec.4.1782455575660;
        Thu, 25 Jun 2026 23:32:55 -0700 (PDT)
Received: from mma-H9MHD44.lan (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-139d91006bcsm15463687c88.13.2026.06.25.23.32.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 23:32:55 -0700 (PDT)
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>,
	Dan Callaghan <dan.callaghan@morsemicro.com>,
	Arien Judge <arien.judge@morsemicro.com>
Cc: ayman.grais@morsemicro.com,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH wireless-next v3 24/33] wifi: mm81x: add sdio.c
Date: Fri, 26 Jun 2026 16:29:20 +1000
Message-ID: <20260626063014.1275235-25-lachlan.hodges@morsemicro.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[morsemicro.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-38135-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:lachlan.hodges@morsemicro.com,m:dan.callaghan@morsemicro.com,m:arien.judge@morsemicro.com,m:ayman.grais@morsemicro.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[lachlan.hodges@morsemicro.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[morsemicro-com.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[morsemicro-com.20251104.gappssmtp.com:dkim,morsemicro.com:email,morsemicro.com:mid,morsemicro.com:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7C4A96CAB4A

(Patches split per file for review, will be a single commit alongside
SDIO ids once review is complete. See cover letter for more
information)

Signed-off-by: Lachlan Hodges <lachlan.hodges@morsemicro.com>
---
 drivers/net/wireless/morsemicro/mm81x/sdio.c | 613 +++++++++++++++++++
 1 file changed, 613 insertions(+)
 create mode 100644 drivers/net/wireless/morsemicro/mm81x/sdio.c

diff --git a/drivers/net/wireless/morsemicro/mm81x/sdio.c b/drivers/net/wireless/morsemicro/mm81x/sdio.c
new file mode 100644
index 000000000000..96fce187dd35
--- /dev/null
+++ b/drivers/net/wireless/morsemicro/mm81x/sdio.c
@@ -0,0 +1,613 @@
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
+#include "hw.h"
+#include "core.h"
+#include "bus.h"
+#include "mac.h"
+#include "fw.h"
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
+static void irq_handler(struct sdio_func *func1)
+{
+	struct sdio_func *func = func1->card->sdio_func[1];
+	struct mm81x *mors = sdio_get_drvdata(func);
+
+	mm81x_hw_irq_handle(mors);
+}
+
+static int mm81x_sdio_enable_irq(struct mm81x_sdio *sdio)
+{
+	int ret;
+	struct sdio_func *func = sdio->func;
+	struct sdio_func *func1 = func->card->sdio_func[0];
+	struct mm81x *mors = sdio_get_drvdata(func);
+
+	sdio_claim_host(func);
+	ret = sdio_claim_irq(func1, irq_handler);
+	if (ret)
+		dev_err(mors->dev, "Failed to enable sdio irq: %d\n", ret);
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
+static void mm81x_sdio_set_irq(struct mm81x *mors, bool enable)
+{
+	struct mm81x_sdio *sdio = (struct mm81x_sdio *)mors->drv_priv;
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
+					    struct sdio_func *func, u32 address,
+					    u8 access)
+{
+	int ret = 0;
+	int retries = 0;
+	static const int max_retries = 3;
+	struct sdio_func *func2 = sdio->func;
+	struct mm81x *mors = sdio_get_drvdata(sdio->func);
+	s32 calculated_addr_base =
+		mm81x_sdio_calculate_base_address(address, access);
+	u32 *current_addr_base = func == func2 ? &sdio->bulk_addr_base :
+						 &sdio->register_addr_base;
+
+	if ((*current_addr_base) == calculated_addr_base &&
+	    *current_addr_base != MM81X_SDIO_BASE_ADDR_UNSET)
+		return ret;
+
+retry:
+	sdio_writeb(func, (u8)u32_get_bits(address, GENMASK(23, 16)),
+		    MM81X_SDIO_REG_ADDRESS_WINDOW_0, &ret);
+	if (ret)
+		goto err;
+
+	sdio_writeb(func, (u8)u32_get_bits(address, GENMASK(31, 24)),
+		    MM81X_SDIO_REG_ADDRESS_WINDOW_1, &ret);
+	if (ret)
+		goto err;
+
+	sdio_writeb(func, access & 0x3, MM81X_SDIO_REG_ADDRESS_CONFIG, &ret);
+	if (ret)
+		goto err;
+
+	*current_addr_base = calculated_addr_base;
+	if (retries)
+		dev_dbg(mors->dev, "%s succeeded after %d retries\n", __func__,
+			retries);
+
+	return ret;
+err:
+	retries++;
+	if (ret == -ETIMEDOUT && retries <= max_retries) {
+		dev_dbg(mors->dev, "%s failed (%d), retrying (%d/%d)\n",
+			__func__, ret, retries, max_retries);
+		goto retry;
+	}
+
+	*current_addr_base = MM81X_SDIO_BASE_ADDR_UNSET;
+	return ret;
+}
+
+static int mm81x_sdio_mem_write_block(struct mm81x_sdio *sdio, u32 address,
+				      u8 *data, ssize_t size)
+{
+	int ret;
+	struct sdio_func *func2 = sdio->func;
+	struct mm81x *mors = sdio_get_drvdata(sdio->func);
+
+	mm81x_sdio_set_func_address_base(sdio, func2, address,
+					 MM81X_CONFIG_ACCESS_4BYTE);
+	if (unlikely(!IS_ALIGNED((uintptr_t)data,
+				 mors->bus_ops->bulk_alignment))) {
+		ret = -EBADE;
+		goto exit;
+	}
+
+	address &= 0x0000FFFF; /* remove base and keep offset */
+	ret = sdio_memcpy_toio(func2, address, data, size);
+	if (ret)
+		goto exit;
+
+	ret = size;
+exit:
+	return ret;
+}
+
+static int mm81x_sdio_mem_write_byte(struct mm81x_sdio *sdio, u32 address,
+				     u8 *data, ssize_t size)
+{
+	int i, ret;
+	struct sdio_func *func1 = sdio->func->card->sdio_func[0];
+
+	mm81x_sdio_set_func_address_base(sdio, func1, address,
+					 MM81X_CONFIG_ACCESS_1BYTE);
+
+	address &= 0x0000FFFF; /* remove base and keep offset */
+	for (i = 0; i < size; i++) {
+		sdio_writeb(func1, data[i], address + i, (int *)&ret);
+		if (ret)
+			goto exit;
+	}
+
+	ret = size;
+exit:
+	return ret;
+}
+
+static void mm81x_sdio_claim_host(struct mm81x *mors)
+{
+	struct mm81x_sdio *sdio = (struct mm81x_sdio *)mors->drv_priv;
+	struct sdio_func *func = sdio->func;
+
+	sdio_claim_host(func);
+}
+
+static void mm81x_sdio_release_host(struct mm81x *mors)
+{
+	struct mm81x_sdio *sdio = (struct mm81x_sdio *)mors->drv_priv;
+	struct sdio_func *func = sdio->func;
+
+	sdio_release_host(func);
+}
+
+static int mm81x_sdio_mem_read_block(struct mm81x_sdio *sdio, u32 address,
+				     u8 *data, ssize_t size)
+{
+	int ret;
+	struct sdio_func *func2 = sdio->func;
+	struct mm81x *mors = sdio_get_drvdata(sdio->func);
+
+	mm81x_sdio_set_func_address_base(sdio, func2, address,
+					 MM81X_CONFIG_ACCESS_4BYTE);
+	if (unlikely(!IS_ALIGNED((uintptr_t)data,
+				 mors->bus_ops->bulk_alignment))) {
+		ret = -EBADE;
+		goto exit;
+	}
+
+	address &= 0x0000FFFF; /* remove base and keep offset */
+	ret = sdio_memcpy_fromio(func2, data, address, size);
+	if (ret)
+		goto exit;
+
+	/*
+	 * Observed sometimes that SDIO read repeats the first 4-bytes
+	 * word twice, overwriting second word (hence, tail will be
+	 * overwritten with 'sync' byte). When this happens, reading
+	 * will fetch the correct word. NB: if repeated again, pass it
+	 * anyway and upper layers will handle it
+	 */
+
+	if (size >= 8 && memcmp(data, data + 4, 4) == 0)
+		sdio_memcpy_fromio(func2, data, address, 8);
+
+	ret = size;
+exit:
+	return ret;
+}
+
+static int mm81x_sdio_mem_read_byte(struct mm81x_sdio *sdio, u32 address,
+				    u8 *data, ssize_t size)
+{
+	int i, ret;
+	struct sdio_func *func1 = sdio->func->card->sdio_func[0];
+
+	mm81x_sdio_set_func_address_base(sdio, func1, address,
+					 MM81X_CONFIG_ACCESS_1BYTE);
+
+	address &= 0x0000FFFF; /* remove base and keep offset */
+	for (i = 0; i < size; i++) {
+		data[i] = sdio_readb(func1, address + i, (int *)&ret);
+		if (ret)
+			goto exit;
+	}
+
+	ret = size;
+exit:
+	return ret;
+}
+
+static int mm81x_sdio_dm_write(struct mm81x *mors, u32 address, const u8 *data,
+			       int len)
+{
+	int ret = 0;
+	int block_len, byte_len;
+	struct mm81x_sdio *sdio = (struct mm81x_sdio *)mors->drv_priv;
+	int remaining = len;
+	int offset = 0;
+
+	if (remaining > 0 && address & 0x3) {
+		len = 4 - (address & 0x3);
+		ret = mm81x_sdio_mem_write_byte(sdio, address, (u8 *)data, len);
+		if (ret != len)
+			return -EIO;
+
+		offset += len;
+		remaining -= len;
+	}
+
+	while ((remaining) > 0) {
+		/*
+		 * We can only write up to the end of a single window in
+		 * each write operation.
+		 */
+		u32 window_end = (address + offset) |
+				 ~MM81X_SDIO_RW_ADDR_BOUNDARY_MASK;
+
+		len = min(remaining, (int)(window_end + 1 - address - offset));
+		block_len = len & ~0x3;
+		byte_len = len & 0x3;
+
+		if (block_len) {
+			ret = mm81x_sdio_mem_write_block(sdio, address + offset,
+							 (u8 *)(data + offset),
+							 block_len);
+			if (ret != block_len)
+				return -EIO;
+
+			offset += block_len;
+		}
+
+		if (byte_len) {
+			ret = mm81x_sdio_mem_write_byte(sdio, address + offset,
+							(u8 *)(data + offset),
+							byte_len);
+			if (ret != byte_len)
+				return -EIO;
+
+			offset += byte_len;
+		}
+
+		remaining -= len;
+	}
+
+	return 0;
+}
+
+static int mm81x_sdio_dm_read(struct mm81x *mors, u32 address, u8 *data,
+			      int len)
+{
+	int ret = 0;
+	int block_len, byte_len;
+	struct mm81x_sdio *sdio = (struct mm81x_sdio *)mors->drv_priv;
+	int remaining = len;
+	int offset = 0;
+
+	if (remaining > 0 && address & 0x3) {
+		len = 4 - (address & 0x3);
+		ret = mm81x_sdio_mem_read_byte(sdio, address, data, len);
+		if (ret != len)
+			return -EIO;
+
+		offset += len;
+		remaining -= len;
+	}
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
+		block_len = len & ~0x3;
+		byte_len = len & 0x3;
+
+		if (block_len) {
+			ret = mm81x_sdio_mem_read_block(sdio, address + offset,
+							data + offset,
+							block_len);
+			if (ret != block_len)
+				return -EIO;
+
+			offset += block_len;
+		}
+
+		if (byte_len) {
+			ret = mm81x_sdio_mem_read_byte(sdio, address + offset,
+						       data + offset, byte_len);
+			if (ret != byte_len)
+				return -EIO;
+
+			offset += byte_len;
+		}
+
+		remaining -= len;
+	}
+
+	return 0;
+}
+
+static int mm81x_sdio_reg32_write(struct mm81x *mors, u32 address, u32 val)
+{
+	ssize_t ret = 0;
+	u32 original_address = address;
+	struct mm81x_sdio *sdio = (struct mm81x_sdio *)mors->drv_priv;
+	struct sdio_func *func1 = sdio->func->card->sdio_func[0];
+
+	mm81x_sdio_set_func_address_base(sdio, func1, address,
+					 MM81X_CONFIG_ACCESS_4BYTE);
+
+	address &= 0x0000FFFF;
+	sdio_writel(func1, (__force u32)cpu_to_le32(val),
+		    (__force u32)cpu_to_le32(address), (int *)&ret);
+	if (ret)
+		goto error;
+
+	return 0;
+
+error:
+	if (original_address == MM81X_REG_RESET(mors) &&
+	    val == MM81X_REG_RESET_VALUE(mors)) {
+		dev_dbg(mors->dev,
+			"SDIO reset detected, invalidating base addr\n");
+		mm81x_sdio_reset_base_address(sdio);
+	}
+
+	return -EIO;
+}
+
+static int mm81x_sdio_reg32_read(struct mm81x *mors, u32 address, u32 *val)
+{
+	u32 value;
+	ssize_t ret = 0;
+	struct mm81x_sdio *sdio = (struct mm81x_sdio *)mors->drv_priv;
+	struct sdio_func *func1 = sdio->func->card->sdio_func[0];
+
+	mm81x_sdio_set_func_address_base(sdio, func1, address,
+					 MM81X_CONFIG_ACCESS_4BYTE);
+
+	address &= 0x0000FFFF;
+	value = sdio_readl(func1, (__force u32)cpu_to_le32(address),
+			   (int *)&ret);
+	if (ret)
+		return ret;
+
+	*val = le32_to_cpup((__le32 *)&value);
+	return 0;
+}
+
+static void mm81x_sdio_bus_enable(struct mm81x *mors, bool enable)
+{
+	struct mm81x_sdio *sdio = (struct mm81x_sdio *)mors->drv_priv;
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
+		dev_dbg(mors->dev, "%s: enabling bus\n", __func__);
+	} else {
+		host->ops->enable_sdio_irq(host, 0);
+		mm81x_sdio_reset_base_address(sdio);
+		sdio->enabled = false;
+		dev_dbg(mors->dev, "%s: disabling bus\n", __func__);
+	}
+
+	sdio_release_host(func);
+}
+
+static void mm81x_sdio_reset(struct sdio_func *func)
+{
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
+static void mm81x_sdio_config_burst_mode(struct mm81x *mors, bool enable_burst)
+{
+	u8 burst_mode = (enable_burst) ? SDIO_WORD_BURST_SIZE_16 :
+					 SDIO_WORD_BURST_DISABLE;
+
+	mm81x_hw_enable_burst_mode(mors, burst_mode);
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
+	struct mm81x *mors = sdio_get_drvdata(func);
+
+	sdio_claim_host(func);
+	ret = sdio_enable_func(func);
+	if (ret)
+		dev_err(mors->dev, "sdio_enable_func failed: %d\n", ret);
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
+static int mm81x_sdio_probe(struct sdio_func *func,
+			    const struct sdio_device_id *id)
+{
+	int ret = 0;
+	struct mm81x *mors = NULL;
+	struct mm81x_sdio *sdio;
+	struct device *dev = &func->dev;
+
+	if (func->num == 1)
+		return 0;
+
+	if (func->num != 2)
+		return -ENODEV;
+
+	mors = mm81x_core_alloc(sizeof(*sdio), dev);
+	if (!mors)
+		return -ENOMEM;
+
+	mors->bus_ops = &mm81x_sdio_ops;
+	mors->bus_type = MM81X_BUS_TYPE_SDIO;
+
+	sdio = (struct mm81x_sdio *)mors->drv_priv;
+	sdio->func = func;
+	sdio->id = id;
+	sdio->enabled = true;
+	mm81x_sdio_reset_base_address(sdio);
+
+	sdio_set_drvdata(func, mors);
+
+	ret = mm81x_sdio_enable(sdio);
+	if (ret)
+		goto err_core_free;
+
+	mm81x_sdio_config_burst_mode(mors, true);
+
+	ret = mm81x_core_init(mors);
+	if (ret)
+		goto err_sdio_release;
+
+	ret = mm81x_sdio_enable_irq(sdio);
+	if (ret)
+		goto err_core_deinit;
+
+	ret = mm81x_core_register(mors);
+	if (ret)
+		goto err_disable_irq;
+
+	return 0;
+
+err_disable_irq:
+	mm81x_sdio_disable_irq(sdio);
+err_core_deinit:
+	mm81x_core_deinit(mors);
+err_sdio_release:
+	mm81x_sdio_release(sdio);
+err_core_free:
+	mm81x_core_free(mors);
+	return ret;
+}
+
+static void mm81x_sdio_remove(struct sdio_func *func)
+{
+	struct mm81x *mors = sdio_get_drvdata(func);
+	struct mm81x_sdio *sdio = (struct mm81x_sdio *)mors->drv_priv;
+
+	if (!mors)
+		return;
+
+	mm81x_core_unregister(mors);
+	mm81x_sdio_disable_irq(sdio);
+	mm81x_core_deinit(mors);
+	mm81x_sdio_release(sdio);
+	mm81x_sdio_reset(func);
+	mm81x_core_free(mors);
+	sdio_set_drvdata(func, NULL);
+}
+
+static const struct sdio_device_id mm81x_sdio_devices[] = {
+	{ SDIO_DEVICE(SDIO_VENDOR_ID_MORSEMICRO,
+		      SDIO_DEVICE_ID_MORSEMICRO_MM8108) },
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
+module_sdio_driver(mm81x_sdio_driver);
+
+MODULE_AUTHOR("Morse Micro");
+MODULE_DESCRIPTION("Driver support for Morse Micro MM81X SDIO devices");
+MODULE_LICENSE("Dual BSD/GPL");
-- 
2.43.0


