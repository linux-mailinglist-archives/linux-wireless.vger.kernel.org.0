Return-Path: <linux-wireless+bounces-38124-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tu8zHcodPmoMAAkAu9opvQ
	(envelope-from <linux-wireless+bounces-38124-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2026 08:35:54 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F01B36CAACD
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2026 08:35:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=morsemicro-com.20251104.gappssmtp.com header.s=20251104 header.b="GLDJu3/R";
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38124-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38124-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed), DKIM not aligned (relaxed)" header.from=morsemicro.com (policy=none);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D1CF930F5F7E
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jun 2026 06:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4258F3DBD54;
	Fri, 26 Jun 2026 06:31:49 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01B53DB63C
	for <linux-wireless@vger.kernel.org>; Fri, 26 Jun 2026 06:31:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782455509; cv=none; b=VlnmvLseWPEOxgnp8gtgC39yifd4tbnsuMjaskYxRwWe9XGy5MFq2gQxOsLLTWlvCD4dk6yg+pSqFmhPGs+Ja+MEr7tX1tuHJROOvCIUVbHLuP+TFbSBXuQuqs6C6Dp3vzomZmYMGkJyw1C1KHdVZ4F8zrfVuV8wq/P8VgpMu9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782455509; c=relaxed/simple;
	bh=7tHGxXuCYQUUU7qzvn/X5wfqjgENtq46uBi4O9qu4AQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cOibsp/nzIAvYphktKagbirGvbZJpcoBIWnP1jHOV31TKO+z/4UNvrIJaSamWf0KRR3F0RLlhw2lEKar7op+u32bMjOmNIOqL3I1lhSI2ob5w/VLYM+ywLgCr5vtGwlxBDFIdblg7apQ5r8r/KYdgF5PxmdmWF2KS1L4aKZPcuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20251104.gappssmtp.com header.i=@morsemicro-com.20251104.gappssmtp.com header.b=GLDJu3/R; arc=none smtp.client-ip=74.125.82.44
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-137eb0d76beso919063c88.0
        for <linux-wireless@vger.kernel.org>; Thu, 25 Jun 2026 23:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20251104.gappssmtp.com; s=20251104; t=1782455507; x=1783060307; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L88sInDtVP7+N0TQqLNr021f2vcKD/LjVB5YnZvvawA=;
        b=GLDJu3/R5rpU5kUyEcWihRUfaCALwjCtvgtOMzhEXeRsX4P4w1JR4rfNkrQJAzxV6p
         v9AE1PmV4oC0SHRTjgOMIG+DxK49EqP579la9cM/f0tG4EcbKOJNHMAVwFU+07J5XME3
         UVdB6nLsi4F6LyNZ0rH/lyKB2YhR4crfLoeMQRV4SBuV/OyVPM6zgtCZin9qCDvlb7e8
         kqaXd3FBS37Uhlq26FmyDq9inEq4TbLcRyYF0x84Nnd18FKemAjYHBaILrLFF/O/fOon
         kVfmbVReEI2eyvvZd0hHc6pqRD6dsqPfkvrH3Yet+4/kPnpNFqIE4c8uCZdglPGFOZ8F
         1m8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782455507; x=1783060307;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=L88sInDtVP7+N0TQqLNr021f2vcKD/LjVB5YnZvvawA=;
        b=HvT2B7XbEziAcy5VUVjIA8N7fk0hMMnbi2i0xxYO3fFZiFfYKqkOwtXTMX3IcrANwC
         YBjdTxgSmwqWwPHeMa6pQUS9IZQceAkhVN4ixRW5whdlbQCn44MgyTS5Lwok6d/6Slzy
         Hpj0VXJXCcEjvQSHCKMFrQp0KS5T4yjJStyuNGk3+rU2aJxMpIUh2daM9U+vexFRHp5X
         xERqJs4k4RRe0oAlpxoFJDaslCVRnvkeNDEYlyslUF29OvHKdCAEzJS4L/GVRqhI2cUp
         gnBPrgXHw3Nw7v5uaKFyAIodQcH9ZaRWahP5y4lr0Yluj8mN//Oc4vibSccogyJ39c/O
         Rx6A==
X-Forwarded-Encrypted: i=1; AFNElJ+Sfw6W2stKp3SHGyMUtVqlayB7jSlYRz4K7h7VCIryRmPm9UAMwBr6SJQ96TwPzH02ZG1+AMOyMyHmgmi80Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+xw+Sgp7VdutdWhbWZre8x5Hitl0nervpReFiaZQZu/OEROmF
	bAzH8fg0W+eNzr6kqoCcXg6xR1jtOJbrMPVec30UAI8Z+IFEPb2PNcxP/ZV3lgZV1ig=
X-Gm-Gg: AfdE7cnelIXPhB7pYS1ej/ZYYhQhLXwqnsxkzU0i9r8AoDRt7QnrULnetdUaTFmV5+7
	kZsV4rjBDis4C51T8ny7cEYgU8O+NiV5jcraip3IKTXtfEV7jXgwrxHuXjdzRnSRppGomG7pnLO
	vMkuX+AL9HuGwmfGhmry8JlGnn+NIo55HQWyYScsNjFJ4zFzGT8idXmmZErg6Gx95Jcxb37I3Wm
	+6I4N9Wm/UsTI3iQ6ZsPz5Y3Pcb/Crj9ESgSZkiFM3f6NtryZmc0Q0p7gseber3w980Fs3arwFW
	2MNsTDvQKKqK2HYhYM8vslx5Yxrco7zcQscAwl5IDWp0sl1GpAqpiovdU0tyDN7msop0aVWbpCP
	oUaNIiJqxCv7Wg0LLcFFlAqGpbyKG1PkkBYIznxspcugOvys0e8/JbTwPimBfJ+BTg4CZk7ZW5i
	1jCgplfcDNg78zNYVQdlme/10ega5gPVVun/BR7h9wqv5p3JSL1T2YD+mf7vguig/+oSp41vlnv
	23Z/HBP1ZykvVwlneiQ
X-Received: by 2002:a05:7022:438d:b0:138:38c7:6adc with SMTP id a92af1059eb24-139c3aa3885mr11304793c88.0.1782455506654;
        Thu, 25 Jun 2026 23:31:46 -0700 (PDT)
Received: from mma-H9MHD44.lan (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-139d91006bcsm15463687c88.13.2026.06.25.23.31.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 23:31:46 -0700 (PDT)
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>,
	Dan Callaghan <dan.callaghan@morsemicro.com>,
	Arien Judge <arien.judge@morsemicro.com>
Cc: ayman.grais@morsemicro.com,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH wireless-next v3 13/33] wifi: mm81x: add hw.h
Date: Fri, 26 Jun 2026 16:29:09 +1000
Message-ID: <20260626063014.1275235-14-lachlan.hodges@morsemicro.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[morsemicro.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-38124-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:lachlan.hodges@morsemicro.com,m:dan.callaghan@morsemicro.com,m:arien.judge@morsemicro.com,m:ayman.grais@morsemicro.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[lachlan.hodges@morsemicro.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[morsemicro-com.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[morsemicro-com.20251104.gappssmtp.com:dkim,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,morsemicro.com:email,morsemicro.com:mid,morsemicro.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F01B36CAACD

(Patches split per file for review, will be a single commit alongside
SDIO ids once review is complete. See cover letter for more
information)

Signed-off-by: Lachlan Hodges <lachlan.hodges@morsemicro.com>
---
 drivers/net/wireless/morsemicro/mm81x/hw.h | 176 +++++++++++++++++++++
 1 file changed, 176 insertions(+)
 create mode 100644 drivers/net/wireless/morsemicro/mm81x/hw.h

diff --git a/drivers/net/wireless/morsemicro/mm81x/hw.h b/drivers/net/wireless/morsemicro/mm81x/hw.h
new file mode 100644
index 000000000000..e22948f037bf
--- /dev/null
+++ b/drivers/net/wireless/morsemicro/mm81x/hw.h
@@ -0,0 +1,176 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2017-2026 Morse Micro
+ */
+
+#ifndef _MM81X_HW_H_
+#define _MM81X_HW_H_
+
+#include <linux/gpio/consumer.h>
+#include "core.h"
+#include "command_defs.h"
+
+/* This should be at a fixed location for a family of chipset */
+#define MM8108_REG_CHIP_ID 0x00002d20
+
+#define MM81X_SDIO_RW_ADDR_BOUNDARY_MASK ((u32)0xFFFF0000)
+
+#define MM81X_CONFIG_ACCESS_1BYTE 0
+#define MM81X_CONFIG_ACCESS_2BYTE 1
+#define MM81X_CONFIG_ACCESS_4BYTE 2
+
+#define MM81X_REG_TRGR_BASE(mors) ((mors)->regs->trgr_base_address)
+#define MM81X_REG_TRGR1_STS(mors) (MM81X_REG_TRGR_BASE(mors) + 0x00)
+#define MM81X_REG_TRGR1_SET(mors) (MM81X_REG_TRGR_BASE(mors) + 0x04)
+#define MM81X_REG_TRGR1_CLR(mors) (MM81X_REG_TRGR_BASE(mors) + 0x08)
+#define MM81X_REG_TRGR1_EN(mors) (MM81X_REG_TRGR_BASE(mors) + 0x0C)
+#define MM81X_REG_TRGR2_STS(mors) (MM81X_REG_TRGR_BASE(mors) + 0x10)
+#define MM81X_REG_TRGR2_SET(mors) (MM81X_REG_TRGR_BASE(mors) + 0x14)
+#define MM81X_REG_TRGR2_CLR(mors) (MM81X_REG_TRGR_BASE(mors) + 0x18)
+#define MM81X_REG_TRGR2_EN(mors) (MM81X_REG_TRGR_BASE(mors) + 0x1C)
+
+#define MM81X_REG_INT_BASE(mors) ((mors)->regs->irq_base_address)
+#define MM81X_REG_INT1_STS(mors) (MM81X_REG_INT_BASE(mors) + 0x00)
+#define MM81X_REG_INT1_SET(mors) (MM81X_REG_INT_BASE(mors) + 0x04)
+#define MM81X_REG_INT1_CLR(mors) (MM81X_REG_INT_BASE(mors) + 0x08)
+#define MM81X_REG_INT1_EN(mors) (MM81X_REG_INT_BASE(mors) + 0x0C)
+#define MM81X_REG_INT2_STS(mors) (MM81X_REG_INT_BASE(mors) + 0x10)
+#define MM81X_REG_INT2_SET(mors) (MM81X_REG_INT_BASE(mors) + 0x14)
+#define MM81X_REG_INT2_CLR(mors) (MM81X_REG_INT_BASE(mors) + 0x18)
+#define MM81X_REG_INT2_EN(mors) (MM81X_REG_INT_BASE(mors) + 0x1C)
+
+#define MM81X_REG_CHIP_ID(mors) ((mors)->regs->chip_id_address)
+
+#define MM81X_REG_MSI(mors) ((mors)->regs->msi_address)
+#define MM81X_REG_MSI_HOST_INT(mors) ((mors)->regs->msi_value)
+
+#define MM81X_REG_HOST_MAGIC_VALUE(mors) ((mors)->regs->magic_num_value)
+
+#define MM81X_REG_RESET(mors) ((mors)->regs->cpu_reset_address)
+#define MM81X_REG_RESET_VALUE(mors) ((mors)->regs->cpu_reset_value)
+
+#define MM81X_REG_HOST_MANIFEST_PTR(mors) ((mors)->regs->manifest_ptr_address)
+
+#define MM81X_REG_EARLY_CLK_CTRL_VALUE(mors) \
+	((mors)->regs->early_clk_ctrl_value)
+
+#define MM81X_REG_CLK_CTRL(mors) ((mors)->regs->clk_ctrl_address)
+#define MM81X_REG_CLK_CTRL_VALUE(mors) ((mors)->regs->clk_ctrl_value)
+
+#define MM81X_REG_BOOT_ADDR(mors) ((mors)->regs->boot_address)
+#define MM81X_REG_BOOT_ADDR_VALUE(mors) ((mors)->regs->boot_value)
+
+#define MM81X_REG_AON_ADDR(mors) ((mors)->regs->aon)
+#define MM81X_REG_AON_COUNT(mors) ((mors)->regs->aon_count)
+#define MM81X_REG_AON_LATCH_ADDR(mors) ((mors)->regs->aon_latch)
+#define MM81X_REG_AON_LATCH_MASK(mors) ((mors)->regs->aon_latch_mask)
+#define MM81X_REG_AON_USB_RESET(mors) ((mors)->regs->aon_reset_usb_value)
+
+/* Bit 17 to 24 reserved for the beacon VIF 0 to 7 interrupts */
+#define MM81X_INT_BEACON_VIF_MASK_ALL (GENMASK(24, 17))
+#define MM81X_INT_BEACON_BASE_NUM (17)
+
+/* PV0 NDP probe interrupts (VIF 0 and 1). */
+#define MM81X_INT_NDP_PROBE_REQ_PV0_VIF_MASK_ALL (GENMASK(26, 25))
+#define MM81X_INT_NDP_PROBE_REQ_PV0_BASE_NUM (25)
+
+/* Bit 27 Chip to Host stop notify */
+#define MM81X_INT_HW_STOP_NOTIFICATION_NUM (27)
+#define MM81X_INT_HW_STOP_NOTIFICATION BIT(MM81X_INT_HW_STOP_NOTIFICATION_NUM)
+
+#define CHIP_TYPE_SILICON 0x0
+
+/* Chip ID */
+#define MM8108XX_ID 0x9
+
+/* Chip Rev */
+#define MM8108B2_REV 0x8
+
+/* Chip Rev String */
+#define MM8108B_STRING "b"
+#define MM8108B2_REV_STRING MM8108B_STRING "2"
+
+/* Chip ID for MM8108 */
+#define MM8108B2_ID \
+	MM81X_DEVICE_ID(MM8108XX_ID, MM8108B2_REV, CHIP_TYPE_SILICON)
+
+#define FW_RAM_ONLY_STRING ""
+#define FW_ROM_LINKED_STRING "-rl"
+#define FW_ROM_ALL_STRING "-ro"
+
+/*
+ * Minimum time we must wait between attempting to reload the HW after a
+ * stop notification
+ */
+#define HW_RELOAD_AFTER_STOP_WINDOW 5
+
+enum host_table_firmware_flags {
+	MM81X_FW_FLAGS_SUPPORT_S1G = BIT(0),
+	MM81X_FW_FLAGS_BUSY_ACTIVE_LOW = BIT(1),
+	MM81X_FW_FLAGS_REPORTS_TX_BEACON_COMPLETION = BIT(2),
+	MM81X_FW_FLAGS_SUPPORT_HW_SCAN = BIT(3),
+	MM81X_FW_FLAGS_SUPPORT_CHIP_HALT_IRQ = BIT(4),
+};
+
+struct host_table {
+	__le32 magic_number;
+	__le32 fw_version_number;
+	__le32 host_flags;
+	__le32 firmware_flags;
+	__le32 memcmd_cmd_addr;
+	__le32 memcmd_resp_addr;
+	__le32 ext_host_tbl_addr;
+} __packed;
+
+struct mm81x_regs {
+	u32 chip_id_address;
+	u32 irq_base_address;
+	u32 trgr_base_address;
+	u32 cpu_reset_address;
+	u32 cpu_reset_value;
+	u32 msi_address;
+	u32 msi_value;
+	u32 manifest_ptr_address;
+	u32 magic_num_value;
+	u32 clk_ctrl_address;
+	u32 clk_ctrl_value;
+	u32 early_clk_ctrl_value;
+	u32 boot_address;
+	u32 boot_value;
+	u32 pager_base_address;
+	u32 aon_latch;
+	u32 aon_latch_mask;
+	u32 aon_reset_usb_value;
+	u32 aon;
+	u8 aon_count;
+};
+
+int mm81x_hw_otp_get_board_type(struct mm81x *mors);
+bool mm81x_hw_otp_valid_board_type(u32 board_type);
+int mm81x_hw_otp_get_mac_addr(struct mm81x *mors);
+
+void mm81x_hw_irq_enable(struct mm81x *mors, u32 irq, bool enable);
+int mm81x_hw_irq_handle(struct mm81x *mors);
+void mm81x_hw_irq_clear(struct mm81x *mors);
+void mm81x_hw_toggle_aon_latch(struct mm81x *mors);
+void mm81x_hw_enable_burst_mode(struct mm81x *mors, const u8 burst_mode);
+int mm81x_hw_digital_reset(struct mm81x *mors);
+void mm81x_hw_pre_firmware_ndr_hook(struct mm81x *mors);
+void mm81x_hw_post_firmware_ndr_hook(struct mm81x *mors);
+
+enum sdio_burst_mode {
+	SDIO_WORD_BURST_DISABLE =
+		0, /* Intentionally duplicate to make it clear it's disabled */
+	SDIO_WORD_BURST_SIZE_0 = 0, /* 000: no bursting (single 32bit word) */
+	SDIO_WORD_BURST_SIZE_2 = 1, /* 001: bursts of 2 words */
+	SDIO_WORD_BURST_SIZE_4 = 2, /* 010: bursts of 4 words */
+	SDIO_WORD_BURST_SIZE_8 = 3, /* 011: bursts of 8 words */
+	SDIO_WORD_BURST_SIZE_16 = 4, /* 100: bursts of 16 words */
+	SDIO_WORD_BURST_MASK = 7,
+};
+
+extern const struct mm81x_regs mm8108_regs;
+
+void mm81x_hw_enable_stop_notifications(struct mm81x *mors, bool enable);
+
+#endif /* !_MM81X_HW_H_ */
-- 
2.43.0


