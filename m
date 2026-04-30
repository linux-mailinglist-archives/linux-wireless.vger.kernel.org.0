Return-Path: <linux-wireless+bounces-35657-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sDEzCW3i8mnyvAEAu9opvQ
	(envelope-from <linux-wireless+bounces-35657-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 07:02:37 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 30A9B49D789
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 07:02:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C1253308BF27
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 04:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A6362BFC85;
	Thu, 30 Apr 2026 04:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20251104.gappssmtp.com header.i=@morsemicro-com.20251104.gappssmtp.com header.b="QVihWXns"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A706F36AB54
	for <linux-wireless@vger.kernel.org>; Thu, 30 Apr 2026 04:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777525049; cv=none; b=Cugb645BAV344WyPCHvCAZfZlyxVSgmv+6y9ExtP91EbCoABpukWGg4FRVIEIqq4fv84fwkJuoih+8uaOLiSwFabw9/KtpI5gcE7eWagnnEz33BX5d5KVan2MEwRMMb3KM9eJdhIAP1ighlu/DqYov2p23+g6gs9H/iGwAtjpU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777525049; c=relaxed/simple;
	bh=lX3HYfZd5z2yVTWmJcCJTL9NGS+zCZ+ApRSfqWIbHjk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cChTQH6qaLFWepKE+ejbZXqw0Orlx2mhrB/D049UnRWSLLxg4lQfC3JDNNORebgrR5EAQokjFuZ1QDb4VGvTh2Qti0F49FGQUg5/4TPpy/RbBT4RcsP8tWgeq6tiO1NIYnVrhwPZHqZikYMuuDU2VLQD1XnEvvzJs4zKitSMfZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20251104.gappssmtp.com header.i=@morsemicro-com.20251104.gappssmtp.com header.b=QVihWXns; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-82418b0178cso278947b3a.1
        for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 21:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20251104.gappssmtp.com; s=20251104; t=1777525047; x=1778129847; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XGWmc2Tx/lxFcRZVLpkoAHdr1xzzQ2YeT2d+rZasI/M=;
        b=QVihWXnsABDGqQOToY+IFZrFkradM1p1LNcn8QviZr2M9WSfD7E+v45i0i7waegC+S
         OwvBnhwKfWGbocTQwepHTa7yXvloMNmuAqc+cvrpJdSLDBYFV95sXNCQWdr5aD8qhR1l
         fHh9OdTysq1YvAMptzYwN34E+N1mGTDF+b7cLFaKqGdG1E+442I6xsXKq1DHkBjNIybC
         ji4fJTxhLtLw43AZfiUA/TiyRHbMsomeMQwKzkGDmcHoENNGSe148rABdEmdeDYd2qGg
         Wv0dYwrCIQiNOhwwsofLRQKb4scmNvXRaXTzF2K8MSlQ1tYqsCEqtQ4gJiVQSSG3Se9R
         9R5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777525047; x=1778129847;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XGWmc2Tx/lxFcRZVLpkoAHdr1xzzQ2YeT2d+rZasI/M=;
        b=HdgDZO2Nv+nZ6SDe7v4cxs4aW/C60s8sOSiJ+nmNur4ygzOX2qJMs8anWusDthUqhy
         C4IZ8CND28R6TzhuCMg1UZpnDAvG+NpkyRWihyFRln1hLcNeGGaNw6wCtJZ25TiAAlZ7
         sn5btN+dlPqYjsljHIN47HIgEeQr/FFih4C4GaSzo/fP9MG4dx6UcHcWloLpZwb6gMTl
         2k5TIualv7cPB7qe1Lv0y/9ybO1ImexCsSzakdv56f8U8pCVpfrXcVLi+kgMuQAMkUkw
         4gYSMvOc1dgLTirE76bGFxzBP12huYgd480yqzH7z8Op5CjVA4VX6nsqVMlSTns2ZPDH
         NazA==
X-Forwarded-Encrypted: i=1; AFNElJ9CZqyi9v1SNjfjhKyWRuGu2k2/q7cNRmDncRVIt/gbz2lcd8dFWqSHbgyTgdhsv7WUZ3rKKcWTJ1+wKdn/hQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwQRetBVHOTA2vGZ9k6DBGTzkS4Mbp21I4usm2IygrvoUX4qWpN
	rZn9gIKnPBjSHUp+QBAShZJm/tD+QLJrr6sabsAUwsJtyLzXMFCzqUfiCW6EMBHi1PU=
X-Gm-Gg: AeBDievoUqye+eu0yZEfLtPxqxaU8hOx+Cm/3zv778jzEi0IWTeaohUpP9l5rTxtCpq
	2wHrZNxnp3FohO3SFfwpUnMs4/Jspf6psZ5Lj4MyVHeuQem4zpFloEVf1NA+A37qbFVFfz2GjVX
	oyM57QPwaqtWCAFsCeNnEt+oUbwT/UtR+N03L3R7AevR+LedeOkQAspuRKR+rhNJHW0qj0iVsKl
	mypA+XPa1uoHlqQOPkGwASbJYM0Q4rzP1maIt0vBbE1pPz3EMnRH+ZUhUcVM2UOMQsqA1qJtcPm
	fQLgLEY1aVbJ9kw4fGdHsUIj0N4aYdgpM4GrY9tUxnIy63nc5f232DIBQjgdTaJn0m0CY10oa5L
	iwZQzxbzVdj2jn6TuoRgJRoxloCjaJK+MhIvlYXQ11GAHT9miV5FzxZ04OyqNBF/kt593zMcTQK
	xcLF+K4qowI3ETxwdhORFD+90jdimvKs3qEbqiGxQwxdjd9poOPFs57NPlZ7chf8orXsEd4OrE3
	cE4hKCxrtuG1Chi1Sg3iBcoP+kRY8vFKHHCslU8mA==
X-Received: by 2002:a05:6a00:2d1a:b0:82f:1d38:f68d with SMTP id d2e1a72fcca58-834fdc6affemr1690611b3a.34.1777525046899;
        Wed, 29 Apr 2026 21:57:26 -0700 (PDT)
Received: from mma-H9MHD44.lan (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-834ed80df96sm3595073b3a.54.2026.04.29.21.57.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 21:57:26 -0700 (PDT)
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>,
	Dan Callaghan <dan.callaghan@morsemicro.com>,
	Arien Judge <arien.judge@morsemicro.com>
Cc: ayman.grais@morsemicro.com,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH wireless-next v2 10/31] wifi: mm81x: add hw.c
Date: Thu, 30 Apr 2026 14:55:36 +1000
Message-ID: <20260430045615.334669-11-lachlan.hodges@morsemicro.com>
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
X-Rspamd-Queue-Id: 30A9B49D789
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
	TAGGED_FROM(0.00)[bounces-35657-lists,linux-wireless=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[morsemicro-com.20251104.gappssmtp.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,morsemicro.com:mid,morsemicro.com:email]

(Patches split per file for review, will be a single commit alongside
SDIO ids once review is complete. See cover letter for more
information)

Signed-off-by: Lachlan Hodges <lachlan.hodges@morsemicro.com>
---
 drivers/net/wireless/morsemicro/mm81x/hw.c | 365 +++++++++++++++++++++
 1 file changed, 365 insertions(+)
 create mode 100644 drivers/net/wireless/morsemicro/mm81x/hw.c

diff --git a/drivers/net/wireless/morsemicro/mm81x/hw.c b/drivers/net/wireless/morsemicro/mm81x/hw.c
new file mode 100644
index 000000000000..afa4cb6d1dd0
--- /dev/null
+++ b/drivers/net/wireless/morsemicro/mm81x/hw.c
@@ -0,0 +1,365 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2017-2026 Morse Micro
+ */
+#include <linux/firmware.h>
+#include <linux/delay.h>
+#include <linux/types.h>
+#include <linux/gpio.h>
+#include "hif.h"
+#include "mac.h"
+#include "bus.h"
+#include "core.h"
+#include "fw.h"
+#include "yaps.h"
+
+#define MM8108_REG_HOST_MAGIC_VALUE 0xDEADBEEF
+#define MM8108_REG_RESET_VALUE 0xDEAD
+
+#define MM8108_REG_SDIO_DEVICE_ADDR 0x0000207C
+
+#define MM8108_REG_SDIO_DEVICE_BURST_OFFSET 9
+#define MM8108_REG_TRGR_BASE 0x00003c00
+#define MM8108_REG_INT_BASE 0x00003c50
+#define MM8108_REG_MSI_ADDRESS 0x00004100
+#define MM8108_REG_MSI_VALUE 0x1
+#define MM8108_REG_MANIFEST_PTR_ADDRESS 0x00002d40
+#define MM8108_REG_APPS_BOOT_ADDR 0x00002084
+#define MM8108_REG_RESET 0x000020AC
+#define MM8108_REG_AON_COUNT 2
+
+#define MM8108_REG_AON_ADDR 0x00002114
+#define MM8108_REG_AON_LATCH_ADDR 0x00405020
+#define MM8108_REG_AON_LATCH_MASK 0x1
+#define MM8108_REG_AON_RESET_USB_VALUE 0x8
+#define MM8108_APPS_MAC_DMEM_ADDR_START 0x00100000
+
+#define MM8108_REG_RC_CLK_POWER_OFF_ADDR 0x00405020
+#define MM8108_REG_RC_CLK_POWER_OFF_MASK 0x00000040
+#define MM8108_SLOW_RC_POWER_ON_DELAY_MS 2
+
+#define MM8108_RESET_DELAY_TIME_MS 400
+
+#define MM8108_REG_OTPCTRL_PLDO 0x00004014
+#define MM8108_REG_OTPCTRL_PENVDD2 0x00004010
+#define MM8108_REG_OTPCTRL_PDSTB 0x00004018
+#define MM8108_REG_OTPCTRL_PTM 0x0000401c
+#define MM8108_REG_OTPCTRL_PCE 0x00004020
+#define MM8108_REG_OTPCTRL_PA 0x00004034
+#define MM8108_REG_OTPCTRL_PECCRDB 0x00004048
+#define MM8108_REG_OTPCTRL_ACTION_AUTO_RD_START 0x0000400c
+#define MM8108_REG_OTPCTRL_PDOUT 0x00004040
+
+#define MM81X_OTP_MAC_ADDR_2_BANK_NUM 27
+#define MM81X_OTP_MAC_ADDR_1_BANK_NUM 26
+#define MM81X_OTP_MAC_ADDR_1_MASK GENMASK(31, 16)
+#define MM81X_OTP_BOARD_TYPE_BANK_NUM 26
+#define MM81X_OTP_BOARD_TYPE_MASK GENMASK(15, 0)
+
+#define MM810X_BOARD_TYPE_MAX_VALUE (MM81X_OTP_BOARD_TYPE_MASK - 1)
+
+static void mm81x_hw_otp_power_up(struct mm81x *mors)
+{
+	mm81x_reg32_write(mors, MM8108_REG_OTPCTRL_PENVDD2, 1);
+	udelay(2);
+
+	mm81x_reg32_write(mors, MM8108_REG_OTPCTRL_PLDO, 1);
+	usleep_range(10, 20);
+
+	mm81x_reg32_write(mors, MM8108_REG_OTPCTRL_PDSTB, 1);
+	udelay(3);
+}
+
+static void mm81x_hw_otp_power_down(struct mm81x *mors)
+{
+	mm81x_reg32_write(mors, MM8108_REG_OTPCTRL_PDSTB, 0);
+	mm81x_reg32_write(mors, MM8108_REG_OTPCTRL_PLDO, 0);
+	mm81x_reg32_write(mors, MM8108_REG_OTPCTRL_PENVDD2, 0);
+}
+
+static void mm81x_hw_otp_read_enable(struct mm81x *mors)
+{
+	mm81x_reg32_write(mors, MM8108_REG_OTPCTRL_PTM, 0);
+	mm81x_reg32_write(mors, MM8108_REG_OTPCTRL_PCE, 1);
+	usleep_range(10, 20);
+}
+
+static void mm81x_hw_otp_read_disable(struct mm81x *mors)
+{
+	mm81x_reg32_write(mors, MM8108_REG_OTPCTRL_PCE, 0);
+	udelay(1);
+}
+
+static int mm81x_hw_otp_read(struct mm81x *mors, u8 bank_num, u32 *buf,
+			     u8 ignore_ecc)
+{
+	u32 auto_rd_start_tmp;
+	u32 auto_rd_start = 1;
+	int i;
+
+	mm81x_reg32_write(mors, MM8108_REG_OTPCTRL_PA, bank_num);
+	mm81x_reg32_write(mors, MM8108_REG_OTPCTRL_PECCRDB, ignore_ecc);
+
+	mm81x_reg32_read(mors, MM8108_REG_OTPCTRL_ACTION_AUTO_RD_START,
+			 &auto_rd_start_tmp);
+	auto_rd_start_tmp &= 0xfffffffe;
+
+	mm81x_reg32_write(mors, MM8108_REG_OTPCTRL_ACTION_AUTO_RD_START,
+			  auto_rd_start | auto_rd_start_tmp);
+
+	/* Attempt reading up to 5 times. */
+	for (i = 0; i < 5 && auto_rd_start; i++) {
+		usleep_range(15, 20);
+		mm81x_reg32_read(mors, MM8108_REG_OTPCTRL_ACTION_AUTO_RD_START,
+				 &auto_rd_start_tmp);
+		auto_rd_start = auto_rd_start_tmp & 0x1;
+	}
+
+	if (i == 5)
+		return -EIO;
+
+	mm81x_reg32_read(mors, MM8108_REG_OTPCTRL_PDOUT, buf);
+
+	return 0;
+}
+
+int mm81x_hw_otp_get_board_type(struct mm81x *mors)
+{
+	int board_type = 0;
+	u32 otp_word = 0;
+	int ret;
+
+	mm81x_claim_bus(mors);
+	mm81x_hw_otp_power_up(mors);
+	mm81x_hw_otp_read_enable(mors);
+
+	ret = mm81x_hw_otp_read(mors, MM81X_OTP_BOARD_TYPE_BANK_NUM, &otp_word,
+				1);
+
+	mm81x_hw_otp_read_disable(mors);
+	mm81x_hw_otp_power_down(mors);
+	mm81x_release_bus(mors);
+
+	if (ret)
+		return -EINVAL;
+
+	board_type = otp_word & MM81X_OTP_BOARD_TYPE_MASK;
+
+	return board_type;
+}
+
+bool mm81x_hw_otp_valid_board_type(u32 board_type)
+{
+	return board_type > 0 && board_type < MM810X_BOARD_TYPE_MAX_VALUE;
+}
+
+int mm81x_hw_otp_get_mac_addr(struct mm81x *mors)
+{
+	u32 mac1 = 0;
+	u32 mac2 = 0;
+	int ret = 0;
+
+	mm81x_claim_bus(mors);
+	mm81x_hw_otp_power_up(mors);
+	mm81x_hw_otp_read_enable(mors);
+
+	ret = mm81x_hw_otp_read(mors, MM81X_OTP_MAC_ADDR_1_BANK_NUM, &mac1, 1);
+	if (ret)
+		goto exit;
+
+	ret = mm81x_hw_otp_read(mors, MM81X_OTP_MAC_ADDR_2_BANK_NUM, &mac2, 1);
+	if (ret)
+		goto exit;
+
+	*((u16 *)&mors->macaddr[0]) = (mac1 & MM81X_OTP_MAC_ADDR_1_MASK) >> 16;
+	*((u32 *)&mors->macaddr[2]) = mac2;
+
+exit:
+	mm81x_hw_otp_read_disable(mors);
+	mm81x_hw_otp_power_down(mors);
+	mm81x_release_bus(mors);
+
+	return ret;
+}
+
+void mm81x_hw_irq_enable(struct mm81x *mors, u32 irq, bool enable)
+{
+	u32 irq_en, irq_en_addr = irq < 32 ? MM81X_REG_INT1_EN(mors) :
+					     MM81X_REG_INT2_EN(mors);
+	u32 irq_clr_addr = irq < 32 ? MM81X_REG_INT1_CLR(mors) :
+				      MM81X_REG_INT2_CLR(mors);
+	u32 mask = irq < 32 ? (1 << irq) : (1 << (irq - 32));
+
+	mm81x_claim_bus(mors);
+	mm81x_reg32_read(mors, irq_en_addr, &irq_en);
+	if (enable)
+		irq_en |= (mask);
+	else
+		irq_en &= ~(mask);
+	mm81x_reg32_write(mors, irq_clr_addr, mask);
+	mm81x_reg32_write(mors, irq_en_addr, irq_en);
+	mm81x_release_bus(mors);
+}
+
+int mm81x_hw_irq_handle(struct mm81x *mors)
+{
+	u32 status1 = 0;
+
+	mm81x_reg32_read(mors, MM81X_REG_INT1_STS(mors), &status1);
+
+	if (status1 & MM81X_HIF_IRQ_MASK_ALL)
+		mm81x_hif_handle_irq(mors, status1);
+
+	if (status1 & MM81X_INT_BEACON_VIF_MASK_ALL)
+		mm81x_mac_beacon_irq_handle(mors, status1);
+
+	mm81x_reg32_write(mors, MM81X_REG_INT1_CLR(mors), status1);
+
+	return status1 ? 1 : 0;
+}
+EXPORT_SYMBOL_GPL(mm81x_hw_irq_handle);
+
+void mm81x_hw_irq_clear(struct mm81x *mors)
+{
+	mm81x_claim_bus(mors);
+	mm81x_reg32_write(mors, MM81X_REG_INT1_CLR(mors), 0xFFFFFFFF);
+	mm81x_reg32_write(mors, MM81X_REG_INT2_CLR(mors), 0xFFFFFFFF);
+	mm81x_release_bus(mors);
+}
+
+void mm81x_hw_toggle_aon_latch(struct mm81x *mors)
+{
+	u32 address = MM81X_REG_AON_LATCH_ADDR(mors);
+	u32 mask = MM81X_REG_AON_LATCH_MASK(mors);
+	u32 latch;
+
+	mm81x_reg32_read(mors, address, &latch);
+	mm81x_reg32_write(mors, address, latch & ~(mask));
+	mdelay(5);
+	mm81x_reg32_write(mors, address, latch | mask);
+	mdelay(5);
+	mm81x_reg32_write(mors, address, latch & ~(mask));
+	mdelay(5);
+}
+
+void mm81x_hw_enable_stop_notifications(struct mm81x *mors, bool enable)
+{
+	mm81x_hw_irq_enable(mors, MM81X_INT_HW_STOP_NOTIFICATION_NUM, enable);
+}
+
+void mm81x_hw_enable_burst_mode(struct mm81x *mors, const u8 burst_mode)
+{
+	u32 reg32_value;
+
+	mm81x_claim_bus(mors);
+	if (mm81x_reg32_read(mors, MM8108_REG_SDIO_DEVICE_ADDR, &reg32_value))
+		goto end;
+
+	reg32_value &= ~(u32)(SDIO_WORD_BURST_MASK
+			      << MM8108_REG_SDIO_DEVICE_BURST_OFFSET);
+	reg32_value |= (u32)(burst_mode << MM8108_REG_SDIO_DEVICE_BURST_OFFSET);
+
+	dev_dbg(mors->dev,
+		"Setting Burst mode to %d Writing 0x%08X to the register",
+		burst_mode, reg32_value);
+
+	if (mm81x_reg32_write(mors, MM8108_REG_SDIO_DEVICE_ADDR, reg32_value))
+		goto end;
+
+end:
+	mm81x_release_bus(mors);
+}
+EXPORT_SYMBOL_GPL(mm81x_hw_enable_burst_mode);
+
+static int mm81x_hw_enable_internal_slow_clock(struct mm81x *mors)
+{
+	u32 rc_clock_reg_value;
+	int ret = 0;
+
+	dev_dbg(mors->dev, "Enabling internal slow clock");
+
+	ret = mm81x_reg32_read(mors, MM8108_REG_RC_CLK_POWER_OFF_ADDR,
+			       &rc_clock_reg_value);
+	if (ret)
+		goto exit;
+
+	rc_clock_reg_value &= ~MM8108_REG_RC_CLK_POWER_OFF_MASK;
+	ret = mm81x_reg32_write(mors, MM8108_REG_RC_CLK_POWER_OFF_ADDR,
+				rc_clock_reg_value);
+	if (ret)
+		goto exit;
+
+	mm81x_hw_toggle_aon_latch(mors);
+
+	/* Wait for the clock to turn on and settle */
+	mdelay(MM8108_SLOW_RC_POWER_ON_DELAY_MS);
+exit:
+	return ret;
+}
+
+int mm81x_hw_digital_reset(struct mm81x *mors)
+{
+	int ret = 0;
+
+	mm81x_claim_bus(mors);
+
+	/* This should be the first step in digital reset, do not reorder */
+	ret = mm81x_hw_enable_internal_slow_clock(mors);
+	if (ret)
+		goto exit;
+
+	if (mors->bus_type == MM81X_BUS_TYPE_USB) {
+		ret = mm81x_bus_digital_reset(mors);
+		goto usb_done;
+	}
+
+	if (MM81X_REG_RESET(mors) != 0)
+		ret = mm81x_reg32_write(mors, MM81X_REG_RESET(mors),
+					MM81X_REG_RESET_VALUE(mors));
+
+usb_done:
+	msleep(MM8108_RESET_DELAY_TIME_MS);
+exit:
+	mm81x_release_bus(mors);
+
+	if (!ret)
+		mors->chip_was_reset = true;
+
+	return ret;
+}
+
+void mm81x_hw_pre_firmware_ndr_hook(struct mm81x *mors)
+{
+	/* We need disable bursting for firmware download/init procedure */
+	mm81x_bus_config_burst_mode(mors, false);
+}
+
+void mm81x_hw_post_firmware_ndr_hook(struct mm81x *mors)
+{
+	/* We are safe here to reenable bursting again, if supported */
+	mm81x_bus_config_burst_mode(mors, true);
+}
+
+const struct mm81x_regs mm8108_regs = {
+	.chip_id_address = MM8108_REG_CHIP_ID,
+	.irq_base_address = MM8108_REG_INT_BASE,
+	.trgr_base_address = MM8108_REG_TRGR_BASE,
+	.cpu_reset_address = MM8108_REG_RESET,
+	.cpu_reset_value = MM8108_REG_RESET_VALUE,
+	.manifest_ptr_address = MM8108_REG_MANIFEST_PTR_ADDRESS,
+	.msi_address = MM8108_REG_MSI_ADDRESS,
+	.msi_value = MM8108_REG_MSI_VALUE,
+	.magic_num_value = MM8108_REG_HOST_MAGIC_VALUE,
+	.early_clk_ctrl_value = 0,
+	.pager_base_address = MM8108_APPS_MAC_DMEM_ADDR_START,
+	.aon_latch = MM8108_REG_AON_LATCH_ADDR,
+	.aon_latch_mask = MM8108_REG_AON_LATCH_MASK,
+	.aon_reset_usb_value = MM8108_REG_AON_RESET_USB_VALUE,
+	.aon = MM8108_REG_AON_ADDR,
+	.aon_count = MM8108_REG_AON_COUNT,
+	.boot_address = MM8108_REG_APPS_BOOT_ADDR,
+};
+
+/* B2 ROM_LINKED */
+MODULE_FIRMWARE(MM81X_FW_DIR "/" MM8108_FW_BASE MM8108B2_REV_STRING
+			FW_ROM_LINKED_STRING MM81X_FW_EXT);
-- 
2.43.0


