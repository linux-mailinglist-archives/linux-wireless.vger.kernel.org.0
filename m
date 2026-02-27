Return-Path: <linux-wireless+bounces-32252-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ADL2IhUboWlhqQQAu9opvQ
	(envelope-from <linux-wireless+bounces-32252-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 05:18:29 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E2A6A1B296B
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 05:18:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C81C931B2D40
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 04:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DFAB346A06;
	Fri, 27 Feb 2026 04:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b="hXnxoMGL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970AD346AFD
	for <linux-wireless@vger.kernel.org>; Fri, 27 Feb 2026 04:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772165584; cv=none; b=LcAcngXQISP24gr/VC6jlpnchKLFhWZeJKgI1BE95MvQJgIpjM4/Vag14syiYuHLEsbpafAp5PUGGgbLq49w+MZWMsyIQN4eVk3hcCTkOFge8pQYVlesDfhPKNSOm1o7Qw7MpoqeGg7zED5T24GEVgy1muKzQfKwdo7QypAhokU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772165584; c=relaxed/simple;
	bh=9l2QdzQsxhcf2/rFHd4iTiPcTxFvCPGExnuaM+tITaY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JcmG2i0JSvtqFmEmPN96vkvJIQ5hc2yHqWXac7HKPj3WBOji10Q07YYlLdwTb/eX9sZsCJ4hM3f3RjTgCOfBuhO0ltq5Jc9rb9VIsnmMxX5wQGkPZzuiGuVO/JI9BKC8Xk4iPighier96TslUFmlUCagz9gWZBEoyH2BU2BwGXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com; spf=pass smtp.mailfrom=morsemicro.com; dkim=pass (2048-bit key) header.d=morsemicro-com.20230601.gappssmtp.com header.i=@morsemicro-com.20230601.gappssmtp.com header.b=hXnxoMGL; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=morsemicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=morsemicro.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-82748257f5fso497107b3a.1
        for <linux-wireless@vger.kernel.org>; Thu, 26 Feb 2026 20:13:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20230601.gappssmtp.com; s=20230601; t=1772165582; x=1772770382; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OSPAUNylvQSnB4ceOsMbPIoakPgTf6KQBzCOdwDXhCs=;
        b=hXnxoMGLDN0j0dXwbcZ05sw1EvSKounbgnpwwHdkT4Gh6ZYDKJQVBsG39PxiMVLcc+
         jD+KE0GygqsScJaOdyQy2VJRp+2mHOUgqyygrXVgHxFZwaC0rx4HVkfs7TjiWnUwPaLC
         YoT8xAPD0vnyqXaDBzRjVoOvTaqshxXryUDMAAZxSfWgmV6MrkT9NzWwRnwEdANRaNe4
         DmWTqLgHQwVTcapweMzn3ug1PrC7OMpyLoK8H2achmOClTTKABX/ZQ4hkk1Uqst2CORJ
         v2ZY9Jusfqt613VUGsqHDbZl7VzRQ5o5Dex3T/UrEU922UnuzVh9OlBYHMvwMY4ag+k3
         3VVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772165582; x=1772770382;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OSPAUNylvQSnB4ceOsMbPIoakPgTf6KQBzCOdwDXhCs=;
        b=FCOg09bLRrisTzAnM28Rl3ZM+NQJEgOzwZu262mN3c2MH5whhOZkdcP3m+ixeUk/re
         3Z6RP4j9LhA5w4IAsUaR0FHjrekgDNEFdFeDWQG6IG3cW2a0izff28KnznEPvfNqCbJF
         vwLlxo5Oc4xCbUqzlAKxOMY5UMdfFpa3IxMcH3D6GuER/T8Pg8tcAJtjiEaJ14r4UUQK
         Q/XwywM78UFiMgHzV6d0GOfl48FH9NLGdC/Lc5OyCSP+5936swZa4O07V+ycNfXpsdyC
         IfjmkeJD60QGLBdkgSitjFWU/Ey2jvVOS3hnNjHNA0dhg0dSUiuwGLgR0d8zT8aYNIAL
         f5DA==
X-Forwarded-Encrypted: i=1; AJvYcCWxg0JNJvuw58HGZCEm7+aX3E9d/KNIpwEETQ5GnIHYmWvlQyaPHnV5RnKAX4zVuFbo0IMBcDtXG198A9A0aA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/ImHdlSU4r2buNotg+zpFUeZEnDSeKTQM7pJojWKBGd82Gc/+
	MVjh5q5hWfKzM2yNUnEdqfs03z8cj5WDFt0P5nx3Jv01PTz/2kKFvO7m4BZyrI2Eygo=
X-Gm-Gg: ATEYQzw0nAEP0ayILBQ4D3nzuy25EEwesIiDnf0nEsD5NL8fURlux4T0BLrmnayLGts
	HE7cZxH3tDgSTUXBPTOWZ3U1rLSS5MkLzEyS6XvqCuQtB6P+nV10l23Rr4K5Ti3RtfGXKtr+68S
	8CKi42v1hponRL/eJRihR4WlMTEi2xFfP8ww/tIzKdtwJoW/Otes4wlP140uGObbKNdamH33WKO
	Qias9p6zQIyXEJ1uYxfriyjOPPjwJLlAHq4zWCqRmOsPsyGxUyeSrMPk6YuVoYy9mgIUUvw87NV
	s2DWju1c41cgSC0gaUYCWsO88f5SkLWV4Whd2xLFCPOpVe9KJbHcPjuxee5iD+MxEAgTncCSpOP
	NIr60vLMOZrpsNrL/3jeAZZAwzr83GSUbAoK8NQHRmOKsuTD8CzHw+vm+zOZZKTiyW/vjFg93TU
	sAClPb+H+pSE2LZZTRbXWubhf2J0uUbzn0Idsx8K34DnDeYhi54FdczT4nhTXjz2A3RiyGTDkIi
	wU02DA4bvGAkD+F2k862E7Ogbl4b8o=
X-Received: by 2002:a05:6a21:594:b0:394:6440:c13 with SMTP id adf61e73a8af0-395c476ef25mr1322968637.29.1772165582093;
        Thu, 26 Feb 2026 20:13:02 -0800 (PST)
Received: from mma-H9MHD44.lan (60-242-93-14.static.tpgi.com.au. [60.242.93.14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb6ba5eesm41682865ad.68.2026.02.26.20.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 20:13:01 -0800 (PST)
From: Lachlan Hodges <lachlan.hodges@morsemicro.com>
To: johannes@sipsolutions.net,
	Lachlan Hodges <lachlan.hodges@morsemicro.com>,
	Dan Callaghan <dan.callaghan@morsemicro.com>,
	Arien Judge <arien.judge@morsemicro.com>
Cc: ayman.grais@morsemicro.com,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH wireless-next 13/35] wifi: mm81x: add hw.h
Date: Fri, 27 Feb 2026 15:10:23 +1100
Message-ID: <20260227041108.66508-14-lachlan.hodges@morsemicro.com>
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
	TAGGED_FROM(0.00)[bounces-32252-lists,linux-wireless=lfdr.de];
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
X-Rspamd-Queue-Id: E2A6A1B296B
X-Rspamd-Action: no action

(Patches split per file for review, see cover letter for more
information)

Signed-off-by: Lachlan Hodges <lachlan.hodges@morsemicro.com>
---
 drivers/net/wireless/morsemicro/mm81x/hw.h | 175 +++++++++++++++++++++
 1 file changed, 175 insertions(+)
 create mode 100644 drivers/net/wireless/morsemicro/mm81x/hw.h

diff --git a/drivers/net/wireless/morsemicro/mm81x/hw.h b/drivers/net/wireless/morsemicro/mm81x/hw.h
new file mode 100644
index 000000000000..3087bd9c73b0
--- /dev/null
+++ b/drivers/net/wireless/morsemicro/mm81x/hw.h
@@ -0,0 +1,175 @@
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
+#define MM81X_REG_TRGR_BASE(mm) ((mm)->regs->trgr_base_address)
+#define MM81X_REG_TRGR1_STS(mm) (MM81X_REG_TRGR_BASE(mm) + 0x00)
+#define MM81X_REG_TRGR1_SET(mm) (MM81X_REG_TRGR_BASE(mm) + 0x04)
+#define MM81X_REG_TRGR1_CLR(mm) (MM81X_REG_TRGR_BASE(mm) + 0x08)
+#define MM81X_REG_TRGR1_EN(mm) (MM81X_REG_TRGR_BASE(mm) + 0x0C)
+#define MM81X_REG_TRGR2_STS(mm) (MM81X_REG_TRGR_BASE(mm) + 0x10)
+#define MM81X_REG_TRGR2_SET(mm) (MM81X_REG_TRGR_BASE(mm) + 0x14)
+#define MM81X_REG_TRGR2_CLR(mm) (MM81X_REG_TRGR_BASE(mm) + 0x18)
+#define MM81X_REG_TRGR2_EN(mm) (MM81X_REG_TRGR_BASE(mm) + 0x1C)
+
+#define MM81X_REG_INT_BASE(mm) ((mm)->regs->irq_base_address)
+#define MM81X_REG_INT1_STS(mm) (MM81X_REG_INT_BASE(mm) + 0x00)
+#define MM81X_REG_INT1_SET(mm) (MM81X_REG_INT_BASE(mm) + 0x04)
+#define MM81X_REG_INT1_CLR(mm) (MM81X_REG_INT_BASE(mm) + 0x08)
+#define MM81X_REG_INT1_EN(mm) (MM81X_REG_INT_BASE(mm) + 0x0C)
+#define MM81X_REG_INT2_STS(mm) (MM81X_REG_INT_BASE(mm) + 0x10)
+#define MM81X_REG_INT2_SET(mm) (MM81X_REG_INT_BASE(mm) + 0x14)
+#define MM81X_REG_INT2_CLR(mm) (MM81X_REG_INT_BASE(mm) + 0x18)
+#define MM81X_REG_INT2_EN(mm) (MM81X_REG_INT_BASE(mm) + 0x1C)
+
+#define MM81X_REG_CHIP_ID(mm) ((mm)->regs->chip_id_address)
+
+#define MM81X_REG_MSI(mm) ((mm)->regs->msi_address)
+#define MM81X_REG_MSI_HOST_INT(mm) ((mm)->regs->msi_value)
+
+#define MM81X_REG_HOST_MAGIC_VALUE(mm) ((mm)->regs->magic_num_value)
+
+#define MM81X_REG_RESET(mm) ((mm)->regs->cpu_reset_address)
+#define MM81X_REG_RESET_VALUE(mm) ((mm)->regs->cpu_reset_value)
+
+#define MM81X_REG_HOST_MANIFEST_PTR(mm) ((mm)->regs->manifest_ptr_address)
+
+#define MM81X_REG_EARLY_CLK_CTRL_VALUE(mm) ((mm)->regs->early_clk_ctrl_value)
+
+#define MM81X_REG_CLK_CTRL(mm) ((mm)->regs->clk_ctrl_address)
+#define MM81X_REG_CLK_CTRL_VALUE(mm) ((mm)->regs->clk_ctrl_value)
+
+#define MM81X_REG_BOOT_ADDR(mm) ((mm)->regs->boot_address)
+#define MM81X_REG_BOOT_ADDR_VALUE(mm) ((mm)->regs->boot_value)
+
+#define MM81X_REG_AON_ADDR(mm) ((mm)->regs->aon)
+#define MM81X_REG_AON_COUNT(mm) ((mm)->regs->aon_count)
+#define MM81X_REG_AON_LATCH_ADDR(mm) ((mm)->regs->aon_latch)
+#define MM81X_REG_AON_LATCH_MASK(mm) ((mm)->regs->aon_latch_mask)
+#define MM81X_REG_AON_USB_RESET(mm) ((mm)->regs->aon_reset_usb_value)
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
+int mm81x_hw_otp_get_board_type(struct mm81x *mm);
+bool mm81x_hw_otp_valid_board_type(u32 board_type);
+int mm81x_hw_otp_get_mac_addr(struct mm81x *mm);
+
+void mm81x_hw_irq_enable(struct mm81x *mm, u32 irq, bool enable);
+int mm81x_hw_irq_handle(struct mm81x *mm);
+void mm81x_hw_irq_clear(struct mm81x *mm);
+int mm81x_hw_toggle_aon_latch(struct mm81x *mm);
+void mm81x_hw_enable_burst_mode(struct mm81x *mm, const u8 burst_mode);
+int mm81x_hw_digital_reset(struct mm81x *mm);
+void mm81x_hw_pre_firmware_ndr_hook(struct mm81x *mm);
+void mm81x_hw_post_firmware_ndr_hook(struct mm81x *mm);
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
+void mm81x_hw_enable_stop_notifications(struct mm81x *mm, bool enable);
+
+#endif /* !_MM81X_HW_H_ */
-- 
2.43.0


