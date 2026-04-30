Return-Path: <linux-wireless+bounces-35658-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OG1hHEnh8mnyvAEAu9opvQ
	(envelope-from <linux-wireless+bounces-35658-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 06:57:45 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1117D49D68C
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 06:57:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 71F57300831C
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2026 04:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0946436C580;
	Thu, 30 Apr 2026 04:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20251104.gappssmtp.com header.i=@morsemicro-com.20251104.gappssmtp.com header.b="K5KqUtCY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E4F362138
	for <linux-wireless@vger.kernel.org>; Thu, 30 Apr 2026 04:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777525053; cv=none; b=d0fqBYcVHzO8hFr0WaK3SA8XxQznYw+XbwOlz9DnuPMsVmwMxa7+z+dkUtBaZJcslFXVa2mj2JszMqO9FP1eMyK7Ry7uuVYnRY5uFt/r5KA9bO5WbjuOYzf9iCha0N28uyCnv44hiJHK9ZiMaATupey6Gze3QaUJsrrQTJ0ofYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777525053; c=relaxed/simple;
	bh=7tHGxXuCYQUUU7qzvn/X5wfqjgENtq46uBi4O9qu4AQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=USVv5VUtIUWQ781MoGTs9y4UpIP+MQ0zgwFGSsfoNIjcLTx7JV0+rf6ig+qZGDREb2nDB8pFdwsOAiA5e/KeJhlOPUHJUInhKo7sm+xBZCVS25DApEUyEj7AhLmeoyvOYkVxEPkfHPBLwdKtRTSzM29Ihi146rJNMGh+Z5i7d9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20251104.gappssmtp.com header.i=@morsemicro-com.20251104.gappssmtp.com header.b=K5KqUtCY; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-82faf871346so357968b3a.0
        for <linux-wireless@vger.kernel.org>; Wed, 29 Apr 2026 21:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20251104.gappssmtp.com; s=20251104; t=1777525052; x=1778129852; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L88sInDtVP7+N0TQqLNr021f2vcKD/LjVB5YnZvvawA=;
        b=K5KqUtCY6XFDDNGtp6n+4HB0XXXckVnzARFYHXVK3zvJ7DUtv8Rz2nKS0JxlzPBF2q
         BBDbrtYS+elycSqrwbumsWW/Bb1fIuWmiC/f3nNx/6U6xMqkx8YbWhON69LOhjjaCdWG
         IW/ANE2cinWgxm3eUoYnPOgEBxkAkO/8Jh7XKY7LtG/S1G8HsQgBlhkcOjfAsGjCA16R
         oWmbwl/PMmbkIoj7XtZCga/F7ErZuF1nT4dNPJHK7I4GFyP8uQGVRzUzSQcd0xMDTqgK
         MA10JtarWkjMsaE4CVVw3WWPUZxHHzHFKmhG3BZiXEXBIde3tXW5QhSRtkNZcz3wdpAk
         INTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777525052; x=1778129852;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=L88sInDtVP7+N0TQqLNr021f2vcKD/LjVB5YnZvvawA=;
        b=plhaW6AbO5LN09xxybbKGyPCFPwgXevgPnOjpGh+vViGCW0yLDxkc7tOcdKyMip7bx
         mMADzOJeshVnyxBo/7d7k61Qj0WHFe5wq4J70q/r4RqLJIvsKXkcWRwEKFgS/fj8Ckpz
         qvaQ0l9PethGtX7IrTekUVr5ZKA+q9GhaZKra9vAPcG+nopYVElTTzTQlU29uyFdl4sK
         P5v32eUJS7m/R5THH/pFlyZVUWmeqcg9r2SEg5WmKu0zAnxe/uGAXh1VUV4MycrXpeVA
         n09nb4Dr9n8ly+LPgI3JZ5biLDjF4ZwWWn3BGLlB6h+46u47T50AWqT4NsuLP3F/wITZ
         FAGw==
X-Forwarded-Encrypted: i=1; AFNElJ/wvuH/KGdhc2rHm9TEtIr7kCIrbC6+buwf0m8QH/AB1J13W7z3a25cs5kbYgxgTqNXQaqb4dJSyIWx0ELQ+w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwtzDmPIqrIYbMqgVmvFU8WaSdkvCRAd+gcxYht6kd4KRj9Z8tN
	WVfu2ybDAjaiDNhhBY81z3xyVQX6g6qtpEWJO9po/SXYDFc/OA2zbl0Q3SuxT9KjxsE=
X-Gm-Gg: AeBDievjLTNCTobfIkVMuXqvY0EqdbRGNJmUegtzh1SWHFNatuc1MjQbTIM9uzyiFN7
	lOCNi+Sx1W8fqw53dlCI5i7L7nNwb0aFWzQtpwI0jK9rlDneP+gKhB8oXiCqwkZoFMMcHwD0ISy
	2e+4obRmWzTXfefdn0vKF9vf6+IRGwTAZJ1Q54jTzKTHhG/bFU3oJfTXsoKEptTYNb/Z6vpFCZF
	Zp1q5aVDWPfh2gghjLdADU0l7SpOTgvJXVW7cTEfIK5y4Wo6VsWoKydxCx745ifssMrIMk8d6DI
	/JYY52QpmlRLpf9IpXJbhD7Iq5u/JCJBQ7FvKhqLh5OSQSpOHYezHi1L8cCeshsyPCt4yg1PiTI
	vQbN9IAxUqN4yFntNS5eLV0X9PuTz1EH1XbKhOpHz2mPXdi++XO2Ds1o8ao5q0LUtkkY78HAD4D
	WxAqCYMEGVYBIpE5Scg63rF9Xq9YaPJRg8JWUaJPk5MJYJSr5We3xHERodKgL9/RB9vsrU2sPzp
	qjF3Bhm9+KwSlglBBe7tAKunGTHCfI7XBnLPO0M2g==
X-Received: by 2002:a05:6a00:1a8b:b0:82c:247b:ffdc with SMTP id d2e1a72fcca58-834fdbd8f3dmr1620006b3a.29.1777525051692;
        Wed, 29 Apr 2026 21:57:31 -0700 (PDT)
Received: from mma-H9MHD44.lan (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-834ed80df96sm3595073b3a.54.2026.04.29.21.57.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 21:57:31 -0700 (PDT)
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>,
	Dan Callaghan <dan.callaghan@morsemicro.com>,
	Arien Judge <arien.judge@morsemicro.com>
Cc: ayman.grais@morsemicro.com,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH wireless-next v2 11/31] wifi: mm81x: add hw.h
Date: Thu, 30 Apr 2026 14:55:37 +1000
Message-ID: <20260430045615.334669-12-lachlan.hodges@morsemicro.com>
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
X-Rspamd-Queue-Id: 1117D49D68C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[morsemicro-com.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[morsemicro.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[morsemicro-com.20251104.gappssmtp.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35658-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lachlan.hodges@morsemicro.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[morsemicro-com.20251104.gappssmtp.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,morsemicro.com:mid,morsemicro.com:email]

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


