Return-Path: <linux-wireless+bounces-35669-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gPZYCDfk8ml8vQEAu9opvQ
	(envelope-from <linux-wireless+bounces-35669-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 07:10:15 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7330849D89E
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 07:10:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A5793051BC8
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 04:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3474367F32;
	Thu, 30 Apr 2026 04:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20251104.gappssmtp.com header.i=@morsemicro-com.20251104.gappssmtp.com header.b="myxdCJNe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B23282F2B
	for <linux-wireless@vger.kernel.org>; Thu, 30 Apr 2026 04:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777525113; cv=none; b=e57UBcEToEzouoX7BDSU/4/6eGHDoUyCbkt/cUv2xSP6dTWT7YR7OVfl0kYzgllgyKlBA/yxxDradkxRc0qWsmX30ddcRz21Oj/NRrG8sOmru+4oNLguIdKELpqjlCmE6QW9GM8Mlcxywls/fu8Qv0fghv6mxTSv0InFsvfIfD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777525113; c=relaxed/simple;
	bh=nrLGN4apflFoj+m+fwlYbBhPybOEChJoVBuD6BAr1nE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mz958/NMRYz7mU4dxEaal+j7pUFK+w0NKk/Wc2iBY8SuLCKjeyaAbTQ5ZblctjaV6C+ywPLfjTqzPOzsjBCA9yRkLyHN3cE7pjWVHxEmGGLUsZ2MsMw585rJ1aUD8YwZC3Ndm3++CrBfE9zHsyONC3fljmsnIPEaUZCJzrfeR+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20251104.gappssmtp.com header.i=@morsemicro-com.20251104.gappssmtp.com header.b=myxdCJNe; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-82faf871346so358419b3a.0
        for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 21:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20251104.gappssmtp.com; s=20251104; t=1777525111; x=1778129911; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=htild0gTHrzSvMcZ7YAygFXUKBJHBB+sCDBaphNh0Aw=;
        b=myxdCJNekmAFcVqGZAQBvwqRt/6D30Q8xdkUhqbHXNGRU1zyDgXi5mdlyp3SNySwnS
         YIHmZl37oqCeFxIKYv6hl78vWAeFewE18iDnl8482n1HN9L6SxWIUFFVI2Elt4Nr1Lyf
         Gb7DVrpcWBatlA1JUj87T+0459vinfO6LPaNpV9AnL9c6itJmBYnV5aa/4+w+9WrpDRX
         w1wnsTdmtLgW/5y9HPHO45Yo+LUmwe22BG+bL9PeWv4ulzPDnJX+nXLW8eH69J8G7ymC
         Erx8DeIieW/vmbRpYkzGUfpbItvnNn7HeNwv4LAPd6BB8Ul+sjRsr6vobsuZ1QP8sKMc
         6nTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777525111; x=1778129911;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=htild0gTHrzSvMcZ7YAygFXUKBJHBB+sCDBaphNh0Aw=;
        b=D4vwpxc4uXdeVzi2+YhTIYUrcVWrtKPXVomlv14TbjxEBoRc20HiqTOxeKdxtSmNKL
         s6VKolC1SlFdWw+du8uZYBJ7Zjl4Xp2x2Ez6gLMPz7AKNP1AvKquBpj2vNhxX6K/KTLJ
         WyDegBkHqGLKR9WefzgIipg98XA+8gajmsO/56ghz4V457oKEuYhwhqIS5dTTNv8JPFW
         oXr7vpRwKZP0XMu52h8IGmLotQwWx0uvAi0Y28qBe4SNBbzQCM9M48ZHyT8VirlpEqw/
         MQeh9QX+5mflME5dOnzytN2qzcE9zDPl065AvJAgqPpZZYHpMsJPdR/7mIUczf60kb46
         wDSw==
X-Forwarded-Encrypted: i=1; AFNElJ/wJg32dxJo/DkTtoWQOrQIjWJDDRskfRYBdrOHgCvRwV2sNR8xlpNQGWMJltePIEjPa77T5/ZiWBrFKNFvcw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxpzNux2yjzCGrZIlH5PDuyuvUtiCafxOE64aZPRBbAAMJWXL6w
	ZGp7eMx6i/1iGgA2efnqPMVHhODciF7/kdVMcFEC2KSGZyapDHPJ4dyQidghmq5M5SY=
X-Gm-Gg: AeBDies6XTabU7wfLMJgoiiKlzFQBUxK7R8Rcrs53Ksv+9uexYcyPKSPhnFloTAp3Db
	bJr8PTJtgKRaf4J4Zse76YJRrAbFKcgdQIaiulIX2DF/LE+08GjZXcU3hD/Eew/MMH4MlnDu3Xk
	/TAjT0jqHPFDDHkK8D4mPzD7tNzIfu0qicUBBJTXFpj5XwsYq0V+lueocfmatW2Tq212CwLzKlP
	nifZYgU4cEg76ozSBaPiw+SAI3OuZQZx7ay985Jr4z1Eje4tszU8Dj+vtmlVB7HBi2UxbhPjJ2G
	tyd8litjef3OlpHB07ZgA0q82oRzj3pU3ErYk8GUWOfGSdnPUyS4HPRXObbwy9pC/1vBHyjgT7K
	Zj56x0lg523rxK8Dq1veNx8WZKb+BmGck0yLgeHKWZEItD1bcR2Qe/NIio4QUf+R9qiyGKg4/ZE
	TP8gDGjYEFCcUQBbmle051h/6jNN31Q/fTb7X76Hya8RwHjHfWyZCQWLBxpIjf+3bIF24GbjlHJ
	woMPL9lZZG0jf4wpVHzwRUxVG8TKj/RSApiaZIWEQ==
X-Received: by 2002:a05:6a00:9504:b0:82a:7aa3:a2fb with SMTP id d2e1a72fcca58-834fdc321a7mr1844463b3a.37.1777525111096;
        Wed, 29 Apr 2026 21:58:31 -0700 (PDT)
Received: from mma-H9MHD44.lan (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-834ed80df96sm3595073b3a.54.2026.04.29.21.58.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 21:58:30 -0700 (PDT)
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>,
	Dan Callaghan <dan.callaghan@morsemicro.com>,
	Arien Judge <arien.judge@morsemicro.com>
Cc: ayman.grais@morsemicro.com,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH wireless-next v2 22/31] wifi: mm81x: add sdio.c
Date: Thu, 30 Apr 2026 14:55:48 +1000
Message-ID: <20260430045615.334669-23-lachlan.hodges@morsemicro.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260430045615.334669-1-lachlan.hodges@morsemicro.com>
References: <20260430045615.334669-1-lachlan.hodges@morsemicro.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7330849D89E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[morsemicro-com.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[morsemicro.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[morsemicro-com.20251104.gappssmtp.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35669-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[morsemicro.com:mid,morsemicro.com:email,morsemicro-com.20251104.gappssmtp.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

(Patches split per file for review, will be a single commit alongside
SDIO ids once review is complete. See cover letter for more
information)

Signed-off-by: Lachlan Hodges <lachlan.hodges@morsemicro.com>
---
 drivers/net/wireless/morsemicro/mm81x/sdio.c | 614 +++++++++++++++++++
 1 file changed, 614 insertions(+)
 create mode 100644 drivers/net/wireless/morsemicro/mm81x/sdio.c

diff --git a/drivers/net/wireless/morsemicro/mm81x/sdio.c b/drivers/net/wireless/morsemicro/mm81x/sdio.c
new file mode 100644
index 000000000000..0832c9195a68
--- /dev/null
+++ b/drivers/net/wireless/morsemicro/mm81x/sdio.c
@@ -0,0 +1,614 @@
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
+static void mm81x_sdio_remove(struct sdio_func *func);
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
+							data + offset, len);
+			if (ret != block_len)
+				return -EIO;
+
+			offset += block_len;
+		}
+
+		if (byte_len) {
+			ret = mm81x_sdio_mem_read_byte(sdio, address + offset,
+						       data + offset, len);
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
+		ret = -EIO;
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
+		      SDIO_DEVICE_ID_MORSEMICRO_MM81XB2) },
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


