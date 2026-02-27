Return-Path: <linux-wireless+bounces-32251-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OK4dKVwboWlhqQQAu9opvQ
	(envelope-from <linux-wireless+bounces-32251-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 05:19:40 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 445E81B2998
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 05:19:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DBE4C31AFBAA
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 04:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B0E434678C;
	Fri, 27 Feb 2026 04:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="j2t0puve"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825DE345731
	for <linux-wireless@vger.kernel.org>; Fri, 27 Feb 2026 04:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772165579; cv=none; b=EidyudvVHqtw3v7R8gLVQvm0GKl9Lbiu+iJMGgkCOPaMpePJ5zE9UGHcPzxjjND5GmsL8cCMpv4kyiOz88/Pfu3ZEM3kdfmiy8U5xGmqNj6g7yK+J7wbHlnUeLGMuYDSk8X5ISNA4gXtQ43shUsR5e9JYDmzJlpNwyEOfMH0Ojg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772165579; c=relaxed/simple;
	bh=V0YLV9rSXDSxYelMXp1Fc6DLFADHydvwfN5/yS0lZEg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eJTs7B44kp8IoYV+JiOBx8CBmrrTAiBBtW2ii8Gf8eExiMkayyLskzOKe9knS12H6sKcbdEs2aOCzCfHMqQlZDPWY0MpiZy1eK4ARUyRbMtDfHFTipP6kvnZIKBQosEPBRxR7/bXF/KbpLr5q/r5K2cxvnW8094v+7dUyh+9VGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=j2t0puve; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2aae146b604so12352985ad.3
        for <linux-wireless@vger.kernel.org>; Thu, 26 Feb 2026 20:12:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1772165577; x=1772770377; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qpCWALXZ87fU2nHHWZ9HGchdpaTvS2orCHPVE2cP+Zw=;
        b=j2t0puveyTuXalKUwKwfblXOvLkNq+o0azGOpX8FRRgr2VIqMVmzvkqqUiJUE3ge4U
         Wt3WV2Wq91AKHvnsOX8hgL2YwDOAieDcQD57SFAJs4FqsqI5WMZ4nnae2IO2FVsDdOIo
         vtDEMrUK4O65S6uj8PCxusL2QrPx7JmCHkP4F5hdv7U18XLlANLsxRK/cDYmLLDMtS0C
         cRDuI1q+b2XVE/hPUuyTEFqcziygBhbYNxRQ4650y9DiCrplM61dBLOLZ4aDFi2AI+cE
         Ivh4cinIEUsuAgwHhBueiiRO1LTf2PC6Fb/qn//9tr0FGpIvzVim0kJYlNMZa4nOu518
         D6Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772165577; x=1772770377;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qpCWALXZ87fU2nHHWZ9HGchdpaTvS2orCHPVE2cP+Zw=;
        b=U3T4RmC6z3WJyV2cn3wR/sCvlfNHT1hQ8jjBjbArF4me3pKEuq71RdskqWzHNsHgkZ
         qgbE5MsEwD9M5WXcWJspsN4y+WulUEXZebwrwZjcZnK7PMhKenV+1G3EMMPNjXV0hUaO
         W3s850qYZHEDJ9cC4mHQHikCZKMF+vn+hhDjnXBhNVrTc9dFp8DW3HitVVAEe6GRc8Nn
         rAjG30BICdgcAA+W27mJYdepALBfkxb3p5Dk0yzuZ2MrzFAc8qDt3+MDmdDXGmJFvERK
         1XBRZXbJwVhHww/s1FsIHk5loSJjg5asGNHRxJJarR5rgurf6dz9H5wpnhB0dwU7aAAn
         21sg==
X-Forwarded-Encrypted: i=1; AJvYcCUqc2+C6lFrz0GWKQcjEbB5OZrhHdTSiXjBMF4+BiaJbgJpJ0/7R+0VQIbvWlVaz1dAWOZbR0vZGyVMB9ALoQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyovwZzvHwLkJj94Q9Wvce2Zzuu8OF+i/KlsmA/63xD7aDJllQc
	EYf+bv3AsnVocLF6Q5KFIR3/6p0mLwD/D7xYsNb/QkzXzYRSaK2J49D+NVIyqpvEEhU=
X-Gm-Gg: ATEYQzwIsspM594eOQ0t2L09eMnCWD8jB7QCfXm2Gf9Ta/+2UmId1MjbTTa2Gwk4QGf
	pIo03MTl+N8rH4ikCInkX6hV8ElQK4kuKTEukRD5RSPcbwUMP9pKOk6vS1efcbkUrkmo2zVVf7u
	vrq5VqgyN0Wz31ikBMq5sMsx50nh7HrhtfjnJGgYUalJxQwDfeO59vR//lMBZiAtwqve2/Dlrw7
	RmUw8SFHNf8IRpBVz7ZV6SoLIdrfynKN1T1iynLS7OEViWb3IhlzJdzVz+NfvaXF2w9nkxrgfif
	n4ap7gGSj/3nvwikYv4DuC57qD6wcLni83A595ZCxVAFC2VRzhoxdMAR6B6D6GxeupQah5rHMaN
	8danPW6oh8fvTr479evycvorfZ5uZnUA06/RgjwkFqIU4/l+MOxDdXMjNl8WN+PX1RfUTnbyB9p
	Q4/uHP2soom91fX5/PyybHxSffDG46mO+6HLy+PB5F0ZAlqyzJbFBBInCE6s/ryAfwB6HscU0NC
	64/RK8/jQ9KGNqJOBfs7ba7QhpEF4ZwdAK097qkHw==
X-Received: by 2002:a17:903:1a06:b0:2aa:f0ec:3701 with SMTP id d9443c01a7336-2ae2e3e9a31mr12352965ad.2.1772165576867;
        Thu, 26 Feb 2026 20:12:56 -0800 (PST)
Received: from mma-H9MHD44.lan (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb6ba5eesm41682865ad.68.2026.02.26.20.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 20:12:56 -0800 (PST)
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>,
	Dan Callaghan <dan.callaghan@morsemicro.com>,
	Arien Judge <arien.judge@morsemicro.com>
Cc: ayman.grais@morsemicro.com,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH wireless-next 12/35] wifi: mm81x: add hw.c
Date: Fri, 27 Feb 2026 15:10:22 +1100
Message-ID: <20260227041108.66508-13-lachlan.hodges@morsemicro.com>
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
	TAGGED_FROM(0.00)[bounces-32251-lists,linux-wireless=lfdr.de];
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
X-Rspamd-Queue-Id: 445E81B2998
X-Rspamd-Action: no action

(Patches split per file for review, see cover letter for more
information)

Signed-off-by: Lachlan Hodges <lachlan.hodges@morsemicro.com>
---
 drivers/net/wireless/morsemicro/mm81x/hw.c | 372 +++++++++++++++++++++
 1 file changed, 372 insertions(+)
 create mode 100644 drivers/net/wireless/morsemicro/mm81x/hw.c

diff --git a/drivers/net/wireless/morsemicro/mm81x/hw.c b/drivers/net/wireless/morsemicro/mm81x/hw.c
new file mode 100644
index 000000000000..83cfc2c693af
--- /dev/null
+++ b/drivers/net/wireless/morsemicro/mm81x/hw.c
@@ -0,0 +1,372 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2017-2026 Morse Micro
+ */
+#include <linux/firmware.h>
+#include <linux/delay.h>
+#include <linux/types.h>
+#include <linux/gpio.h>
+#include "hif.h"
+#include "debug.h"
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
+static void mm81x_hw_otp_power_up(struct mm81x *mm)
+{
+	mm81x_reg32_write(mm, MM8108_REG_OTPCTRL_PENVDD2, 1);
+	udelay(2);
+
+	mm81x_reg32_write(mm, MM8108_REG_OTPCTRL_PLDO, 1);
+	usleep_range(10, 20);
+
+	mm81x_reg32_write(mm, MM8108_REG_OTPCTRL_PDSTB, 1);
+	udelay(3);
+}
+
+static void mm81x_hw_otp_power_down(struct mm81x *mm)
+{
+	mm81x_reg32_write(mm, MM8108_REG_OTPCTRL_PDSTB, 0);
+	mm81x_reg32_write(mm, MM8108_REG_OTPCTRL_PLDO, 0);
+	mm81x_reg32_write(mm, MM8108_REG_OTPCTRL_PENVDD2, 0);
+}
+
+static void mm81x_hw_otp_read_enable(struct mm81x *mm)
+{
+	mm81x_reg32_write(mm, MM8108_REG_OTPCTRL_PTM, 0);
+	mm81x_reg32_write(mm, MM8108_REG_OTPCTRL_PCE, 1);
+	usleep_range(10, 20);
+}
+
+static void mm81x_hw_otp_read_disable(struct mm81x *mm)
+{
+	mm81x_reg32_write(mm, MM8108_REG_OTPCTRL_PCE, 0);
+	udelay(1);
+}
+
+static int mm81x_hw_otp_read(struct mm81x *mm, u8 bank_num, u32 *buf,
+			     u8 ignore_ecc)
+{
+	u32 auto_rd_start_tmp;
+	u32 auto_rd_start = 1;
+	int i;
+
+	mm81x_reg32_write(mm, MM8108_REG_OTPCTRL_PA, bank_num);
+	mm81x_reg32_write(mm, MM8108_REG_OTPCTRL_PECCRDB, ignore_ecc);
+
+	mm81x_reg32_read(mm, MM8108_REG_OTPCTRL_ACTION_AUTO_RD_START,
+			 &auto_rd_start_tmp);
+	auto_rd_start_tmp &= 0xfffffffe;
+
+	mm81x_reg32_write(mm, MM8108_REG_OTPCTRL_ACTION_AUTO_RD_START,
+			  auto_rd_start | auto_rd_start_tmp);
+
+	/* Attempt reading up to 5 times. */
+	for (i = 0; i < 5 && auto_rd_start; i++) {
+		usleep_range(15, 20);
+		mm81x_reg32_read(mm, MM8108_REG_OTPCTRL_ACTION_AUTO_RD_START,
+				 &auto_rd_start_tmp);
+		auto_rd_start = auto_rd_start_tmp & 0x1;
+	}
+
+	if (i == 5)
+		return -EIO;
+
+	mm81x_reg32_read(mm, MM8108_REG_OTPCTRL_PDOUT, buf);
+
+	return 0;
+}
+
+int mm81x_hw_otp_get_board_type(struct mm81x *mm)
+{
+	int board_type = 0;
+	u32 otp_word = 0;
+	int ret;
+
+	mm81x_claim_bus(mm);
+	mm81x_hw_otp_power_up(mm);
+	mm81x_hw_otp_read_enable(mm);
+
+	ret = mm81x_hw_otp_read(mm, MM81X_OTP_BOARD_TYPE_BANK_NUM, &otp_word,
+				1);
+
+	mm81x_hw_otp_read_disable(mm);
+	mm81x_hw_otp_power_down(mm);
+	mm81x_release_bus(mm);
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
+int mm81x_hw_otp_get_mac_addr(struct mm81x *mm)
+{
+	u32 mac1 = 0;
+	u32 mac2 = 0;
+	int ret = 0;
+
+	mm81x_claim_bus(mm);
+	mm81x_hw_otp_power_up(mm);
+	mm81x_hw_otp_read_enable(mm);
+
+	ret = mm81x_hw_otp_read(mm, MM81X_OTP_MAC_ADDR_1_BANK_NUM, &mac1, 1);
+	if (ret)
+		goto exit;
+
+	ret = mm81x_hw_otp_read(mm, MM81X_OTP_MAC_ADDR_2_BANK_NUM, &mac2, 1);
+	if (ret)
+		goto exit;
+
+	*((u16 *)&mm->macaddr[0]) = (mac1 & MM81X_OTP_MAC_ADDR_1_MASK) >> 16;
+	*((u32 *)&mm->macaddr[2]) = mac2;
+
+exit:
+	mm81x_hw_otp_read_disable(mm);
+	mm81x_hw_otp_power_down(mm);
+	mm81x_release_bus(mm);
+
+	return ret;
+}
+
+void mm81x_hw_irq_enable(struct mm81x *mm, u32 irq, bool enable)
+{
+	u32 irq_en, irq_en_addr = irq < 32 ? MM81X_REG_INT1_EN(mm) :
+					     MM81X_REG_INT2_EN(mm);
+	u32 irq_clr_addr = irq < 32 ? MM81X_REG_INT1_CLR(mm) :
+				      MM81X_REG_INT2_CLR(mm);
+	u32 mask = irq < 32 ? (1 << irq) : (1 << (irq - 32));
+
+	mm81x_claim_bus(mm);
+	mm81x_reg32_read(mm, irq_en_addr, &irq_en);
+	if (enable)
+		irq_en |= (mask);
+	else
+		irq_en &= ~(mask);
+	mm81x_reg32_write(mm, irq_clr_addr, mask);
+	mm81x_reg32_write(mm, irq_en_addr, irq_en);
+	mm81x_release_bus(mm);
+}
+
+int mm81x_hw_irq_handle(struct mm81x *mm)
+{
+	u32 status1 = 0;
+
+	mm81x_reg32_read(mm, MM81X_REG_INT1_STS(mm), &status1);
+
+	if (status1 & MM81X_HIF_IRQ_MASK_ALL)
+		mm81x_hif_handle_irq(mm, status1);
+
+	if (status1 & MM81X_INT_BEACON_VIF_MASK_ALL)
+		mm81x_mac_beacon_irq_handle(mm, status1);
+
+	mm81x_reg32_write(mm, MM81X_REG_INT1_CLR(mm), status1);
+
+	return status1 ? 1 : 0;
+}
+
+void mm81x_hw_irq_clear(struct mm81x *mm)
+{
+	mm81x_claim_bus(mm);
+	mm81x_reg32_write(mm, MM81X_REG_INT1_CLR(mm), 0xFFFFFFFF);
+	mm81x_reg32_write(mm, MM81X_REG_INT2_CLR(mm), 0xFFFFFFFF);
+	mm81x_release_bus(mm);
+}
+
+int mm81x_hw_toggle_aon_latch(struct mm81x *mm)
+{
+	u32 address = MM81X_REG_AON_LATCH_ADDR(mm);
+	u32 mask = MM81X_REG_AON_LATCH_MASK(mm);
+	u32 latch;
+
+	if (address) {
+		mm81x_reg32_read(mm, address, &latch);
+		mm81x_reg32_write(mm, address, latch & ~(mask));
+		mdelay(5);
+		mm81x_reg32_write(mm, address, latch | mask);
+		mdelay(5);
+		mm81x_reg32_write(mm, address, latch & ~(mask));
+		mdelay(5);
+	}
+
+	return 0;
+}
+
+void mm81x_hw_enable_stop_notifications(struct mm81x *mm, bool enable)
+{
+	mm81x_hw_irq_enable(mm, MM81X_INT_HW_STOP_NOTIFICATION_NUM, enable);
+}
+
+void mm81x_hw_enable_burst_mode(struct mm81x *mm, const u8 burst_mode)
+{
+	u32 reg32_value;
+
+	mm81x_claim_bus(mm);
+	if (mm81x_reg32_read(mm, MM8108_REG_SDIO_DEVICE_ADDR, &reg32_value))
+		goto end;
+
+	reg32_value &= ~(u32)(SDIO_WORD_BURST_MASK
+			      << MM8108_REG_SDIO_DEVICE_BURST_OFFSET);
+	reg32_value |= (u32)(burst_mode << MM8108_REG_SDIO_DEVICE_BURST_OFFSET);
+
+	mm81x_dbg(mm, MM81X_DBG_ANY,
+		  "Setting Burst mode to %d Writing 0x%08X to the register",
+		  burst_mode, reg32_value);
+
+	if (mm81x_reg32_write(mm, MM8108_REG_SDIO_DEVICE_ADDR, reg32_value))
+		goto end;
+
+end:
+	mm81x_release_bus(mm);
+}
+
+static int mm81x_hw_enable_internal_slow_clock(struct mm81x *mm)
+{
+	u32 rc_clock_reg_value;
+	int ret = 0;
+
+	mm81x_dbg(mm, MM81X_DBG_ANY, "Enabling internal slow clock");
+
+	ret = mm81x_reg32_read(mm, MM8108_REG_RC_CLK_POWER_OFF_ADDR,
+			       &rc_clock_reg_value);
+	if (ret)
+		goto exit;
+
+	rc_clock_reg_value &= ~MM8108_REG_RC_CLK_POWER_OFF_MASK;
+	ret = mm81x_reg32_write(mm, MM8108_REG_RC_CLK_POWER_OFF_ADDR,
+				rc_clock_reg_value);
+	if (ret)
+		goto exit;
+
+	ret = mm81x_hw_toggle_aon_latch(mm);
+	if (ret)
+		goto exit;
+
+	/* Wait for the clock to turn on and settle */
+	mdelay(MM8108_SLOW_RC_POWER_ON_DELAY_MS);
+exit:
+	return ret;
+}
+
+int mm81x_hw_digital_reset(struct mm81x *mm)
+{
+	int ret = 0;
+
+	mm81x_claim_bus(mm);
+
+	/* This should be the first step in digital reset, do not reorder */
+	ret = mm81x_hw_enable_internal_slow_clock(mm);
+	if (ret)
+		goto exit;
+
+	if (mm->bus_type == MM81X_BUS_TYPE_USB) {
+#ifdef CONFIG_MM81X_USB
+		ret = mm81x_usb_ndr_reset(mm);
+#endif
+		goto usb_done;
+	}
+
+	if (MM81X_REG_RESET(mm) != 0)
+		ret = mm81x_reg32_write(mm, MM81X_REG_RESET(mm),
+					MM81X_REG_RESET_VALUE(mm));
+
+usb_done:
+	msleep(MM8108_RESET_DELAY_TIME_MS);
+exit:
+	mm81x_release_bus(mm);
+
+	if (!ret)
+		mm->chip_was_reset = true;
+
+	return ret;
+}
+
+void mm81x_hw_pre_firmware_ndr_hook(struct mm81x *mm)
+{
+	/* We need disable bursting for firmware download/init procedure */
+	mm81x_bus_config_burst_mode(mm, false);
+}
+
+void mm81x_hw_post_firmware_ndr_hook(struct mm81x *mm)
+{
+	/* We are safe here to reenable bursting again, if supported */
+	mm81x_bus_config_burst_mode(mm, true);
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


