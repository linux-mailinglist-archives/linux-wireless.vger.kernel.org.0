Return-Path: <linux-wireless+bounces-27372-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 302C8B7DC0C
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Sep 2025 14:34:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D8B2325310
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Sep 2025 22:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 601012E0415;
	Tue, 16 Sep 2025 22:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b="B1A3rmiU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp14.infineon.com (smtp14.infineon.com [217.10.52.160])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567FD2248B0
	for <linux-wireless@vger.kernel.org>; Tue, 16 Sep 2025 22:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.52.160
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758061392; cv=none; b=unLyb6imKwLJEAO0CRqoNd+zLvQYXQ8JvfLn2FhzMfqthCNUmV1RMIFzZTzNEL+koELZLGl0nlw6VbcMQmL9q/QcEfDcenePe6MDopMFlrHPWUu0vjxjVX/TN4PmR2F6g3q+kcUcRvv8oW/p3nW0Vccm9Krc+AzH9mHrTMTRqJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758061392; c=relaxed/simple;
	bh=O7pltquYKdK7XxxSahfsydieoVkqCDfqsmS9/60aXg0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LcCbW99AhZr7xPh/FqRV2j7/6qvuY8AEIAeHAxc4KSJu6CztdQtMkWts2gLmuwbAUeu8vxq1WPonPE2oLFQcml0pBOlFgY4FzfABq4QyUvETAiX6JdE1enNzqgQAU1oTaVp9NJSayArQkyq8XvnFRFBeV/oVc/dSVrdzWtXMdGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com; spf=pass smtp.mailfrom=infineon.com; dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b=B1A3rmiU; arc=none smtp.client-ip=217.10.52.160
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infineon.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1758061388; x=1789597388;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=O7pltquYKdK7XxxSahfsydieoVkqCDfqsmS9/60aXg0=;
  b=B1A3rmiUFKfVWGn89mlmxwGttZOI4J2tjyqdcmpwn7eumqE+ZMPVoR3T
   OgBe3oOBG9RRziKjwmXjYAyYuCN7aW8YftxOmIQwFXpM4fmp43fLcfFq/
   jMNtKWTRLR+3NQZthIMcgcFvmkFtTTG76z0OFulpnLyZEwqL1n1qRaVAS
   0=;
X-CSE-ConnectionGUID: PIGsPV+tTa6u/b9B8OvCug==
X-CSE-MsgGUID: Ky8Gff0ZRa+x33EI/p7xDA==
X-IronPort-AV: E=McAfee;i="6800,10657,11555"; a="99293918"
X-IronPort-AV: E=Sophos;i="6.18,270,1751234400"; 
   d="scan'208";a="99293918"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO MUCSE805.infineon.com) ([172.23.29.31])
  by smtp14.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 00:23:06 +0200
Received: from MUCSE827.infineon.com (172.23.29.20) by MUCSE805.infineon.com
 (172.23.29.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.36; Wed, 17 Sep
 2025 00:23:05 +0200
Received: from ISCN5CG14747PP.infineon.com (10.161.6.196) by
 MUCSE827.infineon.com (172.23.29.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.36; Wed, 17 Sep 2025 00:23:01 +0200
From: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
To: <linux-wireless@vger.kernel.org>, Johannes Berg
	<johannes@sipsolutions.net>
CC: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>,
	<wlan-kernel-dev-list@infineon.com>
Subject: [PATCH wireless-next 21/57] wifi: inffmac: add pcie.c/h
Date: Wed, 17 Sep 2025 03:47:37 +0530
Message-ID: <20250916221821.4387-23-gokulkumar.sivakumar@infineon.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250916221821.4387-1-gokulkumar.sivakumar@infineon.com>
References: <20250916221821.4387-1-gokulkumar.sivakumar@infineon.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MUCSE808.infineon.com (172.23.29.34) To
 MUCSE827.infineon.com (172.23.29.20)

Implements the specific bus logic for Infineon devices connected to the
linux machine via a PCIe interface.

Signed-off-by: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
---
 drivers/net/wireless/infineon/inffmac/pcie.c | 2909 ++++++++++++++++++
 drivers/net/wireless/infineon/inffmac/pcie.h |   19 +
 2 files changed, 2928 insertions(+)
 create mode 100644 drivers/net/wireless/infineon/inffmac/pcie.c
 create mode 100644 drivers/net/wireless/infineon/inffmac/pcie.h

diff --git a/drivers/net/wireless/infineon/inffmac/pcie.c b/drivers/net/wireless/infineon/inffmac/pcie.c
new file mode 100644
index 000000000000..5ec1bd7e3c52
--- /dev/null
+++ b/drivers/net/wireless/infineon/inffmac/pcie.c
@@ -0,0 +1,2909 @@
+// SPDX-License-Identifier: ISC
+/*
+ * Copyright (c) 2014 Broadcom Corporation
+ *
+ * Copyright (c) 2025, Infineon Technologies AG, or an affiliate of Infineon Technologies AG.
+ * All rights reserved.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/firmware.h>
+#include <linux/pci.h>
+#include <linux/vmalloc.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/sched.h>
+#include <linux/sched/signal.h>
+#include <linux/kthread.h>
+#include <linux/io.h>
+#include <linux/unaligned.h>
+#include "chipcommon.h"
+#include "utils.h"
+#include "hw_ids.h"
+
+/* Custom inff_err() that takes bus arg and passes it further */
+#define inff_err(bus, fmt, ...)					\
+	do {								\
+		if (IS_ENABLED(CONFIG_INF_DEBUG) ||			\
+		    IS_ENABLED(CONFIG_INF_TRACING) ||			\
+		    net_ratelimit())					\
+			__inff_err(bus, __func__, fmt, ##__VA_ARGS__);	\
+	} while (0)
+
+#include "debug.h"
+#include "bus.h"
+#include "commonring.h"
+#include "msgbuf.h"
+#include "pcie.h"
+#include "firmware.h"
+#include "chip.h"
+#include "core.h"
+#include "common.h"
+#include "cfg80211.h"
+#include "trxhdr.h"
+
+enum inff_pcie_state {
+	INFFMAC_PCIE_STATE_DOWN,
+	INFFMAC_PCIE_STATE_UP
+};
+
+/* per-board firmware binaries */
+#define INFF_55572_FIRMWARE_BASENAME INFF_FW_DEFAULT_PATH "inffmac55572-pcie"
+
+MODULE_FIRMWARE(INFF_55572_FIRMWARE_BASENAME ".trxse");
+
+static const struct inff_firmware_mapping inff_pcie_fwnames[] = {
+	INFF_FW_ENTRY(INF_CC_5557X_CHIP_ID, 0xFFFFFFFF, 55572),
+};
+
+#define INFF_PCIE_READ_SHARED_TIMEOUT	5000 /* msec */
+#define INFF_PCIE_FW_UP_TIMEOUT		5000 /* msec */
+
+#define INFF_PCIE_REG_MAP_SIZE			(32 * 1024)
+
+/* backplane address space accessed by BAR0 */
+#define	INFF_PCIE_BAR0_WINDOW			0x80
+#define INFF_PCIE_BAR0_REG_SIZE		0x1000
+#define	INFF_PCIE_BAR0_WRAPPERBASE		0x70
+
+#define INFF_PCIE_BAR0_WRAPBASE_DMP_OFFSET	0x1000
+#define INFF_PCIE_BAR0_PCIE_ENUM_OFFSET	0x2000
+#define INFF_CYW55572_PCIE_BAR0_PCIE_ENUM_OFFSET	0x3000
+
+#define INFF_PCIE_BAR1_WINDOW			0x84
+
+#define INFF_PCIE_ARMCR4REG_BANKIDX		0x40
+#define INFF_PCIE_ARMCR4REG_BANKPDA		0x4C
+
+#define INFF_PCIE_REG_INTSTATUS		0x90
+#define INFF_PCIE_REG_INTMASK			0x94
+#define INFF_PCIE_REG_SBMBX			0x98
+
+#define INFF_PCIE_REG_LINK_STATUS_CTRL		0xBC
+
+#define INFF_PCIE_PCIE2REG_INTMASK		0x24
+#define INFF_PCIE_PCIE2REG_MAILBOXINT		0x48
+#define INFF_PCIE_PCIE2REG_MAILBOXMASK		0x4C
+#define INFF_PCIE_PCIE2REG_CONFIGADDR		0x120
+#define INFF_PCIE_PCIE2REG_CONFIGDATA		0x124
+#define INFF_PCIE_PCIE2REG_H2D_MAILBOX_0	0x140
+#define INFF_PCIE_PCIE2REG_H2D_MAILBOX_1	0x144
+#define INFF_PCIE_PCIE2REG_DAR_D2H_MSG_0	0xA80
+#define INFF_PCIE_PCIE2REG_DAR_H2D_MSG_0	0xA90
+
+#define INFF_PCIE_64_PCIE2REG_INTMASK		0xC14
+#define INFF_PCIE_64_PCIE2REG_MAILBOXINT	0xC30
+#define INFF_PCIE_64_PCIE2REG_MAILBOXMASK	0xC34
+#define INFF_PCIE_64_PCIE2REG_H2D_MAILBOX_0	0xA20
+#define INFF_PCIE_64_PCIE2REG_H2D_MAILBOX_1	0xA24
+
+#define INFF_PCIE2_INTA			0x01
+#define INFF_PCIE2_INTB			0x02
+
+#define INFF_PCIE_INT_0			0x01
+#define INFF_PCIE_INT_1			0x02
+#define INFF_PCIE_INT_DEF			(INFF_PCIE_INT_0 | \
+						 INFF_PCIE_INT_1)
+
+#define INFF_PCIE_MB_INT_FN0_0			0x0100
+#define INFF_PCIE_MB_INT_FN0_1			0x0200
+#define	INFF_PCIE_MB_INT_D2H0_DB0		0x10000
+#define	INFF_PCIE_MB_INT_D2H0_DB1		0x20000
+#define	INFF_PCIE_MB_INT_D2H1_DB0		0x40000
+#define	INFF_PCIE_MB_INT_D2H1_DB1		0x80000
+#define	INFF_PCIE_MB_INT_D2H2_DB0		0x100000
+#define	INFF_PCIE_MB_INT_D2H2_DB1		0x200000
+#define	INFF_PCIE_MB_INT_D2H3_DB0		0x400000
+#define	INFF_PCIE_MB_INT_D2H3_DB1		0x800000
+
+#define INFF_PCIE_MB_INT_FN0			(INFF_PCIE_MB_INT_FN0_0 | \
+						 INFF_PCIE_MB_INT_FN0_1)
+#define INFF_PCIE_MB_INT_D2H_DB		(INFF_PCIE_MB_INT_D2H0_DB0 | \
+						 INFF_PCIE_MB_INT_D2H0_DB1 | \
+						 INFF_PCIE_MB_INT_D2H1_DB0 | \
+						 INFF_PCIE_MB_INT_D2H1_DB1 | \
+						 INFF_PCIE_MB_INT_D2H2_DB0 | \
+						 INFF_PCIE_MB_INT_D2H2_DB1 | \
+						 INFF_PCIE_MB_INT_D2H3_DB0 | \
+						 INFF_PCIE_MB_INT_D2H3_DB1)
+
+#define	INFF_PCIE_64_MB_INT_D2H0_DB0		0x1
+#define	INFF_PCIE_64_MB_INT_D2H0_DB1		0x2
+#define	INFF_PCIE_64_MB_INT_D2H1_DB0		0x4
+#define	INFF_PCIE_64_MB_INT_D2H1_DB1		0x8
+#define	INFF_PCIE_64_MB_INT_D2H2_DB0		0x10
+#define	INFF_PCIE_64_MB_INT_D2H2_DB1		0x20
+#define	INFF_PCIE_64_MB_INT_D2H3_DB0		0x40
+#define	INFF_PCIE_64_MB_INT_D2H3_DB1		0x80
+#define	INFF_PCIE_64_MB_INT_D2H4_DB0		0x100
+#define	INFF_PCIE_64_MB_INT_D2H4_DB1		0x200
+#define	INFF_PCIE_64_MB_INT_D2H5_DB0		0x400
+#define	INFF_PCIE_64_MB_INT_D2H5_DB1		0x800
+#define	INFF_PCIE_64_MB_INT_D2H6_DB0		0x1000
+#define	INFF_PCIE_64_MB_INT_D2H6_DB1		0x2000
+#define	INFF_PCIE_64_MB_INT_D2H7_DB0		0x4000
+#define	INFF_PCIE_64_MB_INT_D2H7_DB1		0x8000
+
+#define INFF_PCIE_64_MB_INT_D2H_DB		(INFF_PCIE_64_MB_INT_D2H0_DB0 | \
+						 INFF_PCIE_64_MB_INT_D2H0_DB1 | \
+						 INFF_PCIE_64_MB_INT_D2H1_DB0 | \
+						 INFF_PCIE_64_MB_INT_D2H1_DB1 | \
+						 INFF_PCIE_64_MB_INT_D2H2_DB0 | \
+						 INFF_PCIE_64_MB_INT_D2H2_DB1 | \
+						 INFF_PCIE_64_MB_INT_D2H3_DB0 | \
+						 INFF_PCIE_64_MB_INT_D2H3_DB1 | \
+						 INFF_PCIE_64_MB_INT_D2H4_DB0 | \
+						 INFF_PCIE_64_MB_INT_D2H4_DB1 | \
+						 INFF_PCIE_64_MB_INT_D2H5_DB0 | \
+						 INFF_PCIE_64_MB_INT_D2H5_DB1 | \
+						 INFF_PCIE_64_MB_INT_D2H6_DB0 | \
+						 INFF_PCIE_64_MB_INT_D2H6_DB1 | \
+						 INFF_PCIE_64_MB_INT_D2H7_DB0 | \
+						 INFF_PCIE_64_MB_INT_D2H7_DB1)
+
+#define INFF_PCIE_SHARED_VERSION_6		6
+#define INFF_PCIE_SHARED_VERSION_7		7
+#define INFF_PCIE_MIN_SHARED_VERSION		5
+#define INFF_PCIE_MAX_SHARED_VERSION		INFF_PCIE_SHARED_VERSION_7
+#define INFF_PCIE_SHARED_VERSION_MASK		0x00FF
+#define INFF_PCIE_SHARED_DMA_INDEX		0x10000
+#define INFF_PCIE_SHARED_DMA_2B_IDX		0x100000
+#define INFF_PCIE_SHARED_USE_MAILBOX		0x2000000
+#define INFF_PCIE_SHARED_HOSTRDY_DB1		0x10000000
+
+#define INFF_PCIE_FLAGS_HTOD_SPLIT		0x4000
+#define INFF_PCIE_FLAGS_DTOH_SPLIT		0x8000
+
+#define INFF_SHARED_MAX_RXBUFPOST_OFFSET	34
+#define INFF_SHARED_RING_BASE_OFFSET		52
+#define INFF_SHARED_RX_DATAOFFSET_OFFSET	36
+#define INFF_SHARED_CONSOLE_ADDR_OFFSET	20
+#define INFF_SHARED_HTOD_MB_DATA_ADDR_OFFSET	40
+#define INFF_SHARED_DTOH_MB_DATA_ADDR_OFFSET	44
+#define INFF_SHARED_RING_INFO_ADDR_OFFSET	48
+#define INFF_SHARED_DMA_SCRATCH_LEN_OFFSET	52
+#define INFF_SHARED_DMA_SCRATCH_ADDR_OFFSET	56
+#define INFF_SHARED_DMA_RINGUPD_LEN_OFFSET	64
+#define INFF_SHARED_DMA_RINGUPD_ADDR_OFFSET	68
+#define INFF_SHARED_HOST_CAP_OFFSET		84
+
+#define INFF_RING_H2D_RING_COUNT_OFFSET	0
+#define INFF_RING_D2H_RING_COUNT_OFFSET	1
+#define INFF_RING_H2D_RING_MEM_OFFSET		4
+#define INFF_RING_H2D_RING_STATE_OFFSET	8
+
+#define INFF_RING_MEM_BASE_ADDR_OFFSET		8
+#define INFF_RING_MAX_ITEM_OFFSET		4
+#define INFF_RING_LEN_ITEMS_OFFSET		6
+#define INFF_RING_MEM_SZ			16
+#define INFF_RING_STATE_SZ			8
+
+#define INFF_DEF_MAX_RXBUFPOST			255
+
+#define INFF_HOSTCAP_H2D_ENABLE_HOSTRDY	0x400
+#define INFF_HOSTCAP_DS_NO_OOB_DW			0x1000
+
+#define INFF_CONSOLE_BUFADDR_OFFSET		8
+#define INFF_CONSOLE_BUFSIZE_OFFSET		12
+#define INFF_CONSOLE_WRITEIDX_OFFSET		16
+
+#define INFF_DMA_D2H_SCRATCH_BUF_LEN		8
+#define INFF_DMA_D2H_RINGUPD_BUF_LEN		1024
+
+#define INFF_D2H_DEV_D3_ACK			0x00000001
+#define INFF_D2H_DEV_DS_ENTER_REQ		0x00000002
+#define INFF_D2H_DEV_DS_EXIT_NOTE		0x00000004
+#define INFF_D2H_DEV_FWHALT			0x10000000
+
+#define INFF_H2D_HOST_D3_INFORM		0x00000001
+#define INFF_H2D_HOST_DS_ACK			0x00000002
+#define INFF_H2D_HOST_D0_INFORM_IN_USE		0x00000008
+#define INFF_H2D_HOST_D0_INFORM		0x00000010
+
+#define INFF_PCIE_MBDATA_TIMEOUT		msecs_to_jiffies(2000)
+
+#define INFF_PCIE_CFGREG_STATUS_CMD		0x4
+#define INFF_PCIE_CFGREG_PM_CSR		0x4C
+#define INFF_PCIE_CFGREG_MSI_CAP		0x58
+#define INFF_PCIE_CFGREG_MSI_ADDR_L		0x5C
+#define INFF_PCIE_CFGREG_MSI_ADDR_H		0x60
+#define INFF_PCIE_CFGREG_MSI_DATA		0x64
+#define INFF_PCIE_CFGREG_REVID			0x6C
+#define INFF_PCIE_CFGREG_LINK_STATUS_CTRL	0xBC
+#define INFF_PCIE_CFGREG_LINK_STATUS_CTRL2	0xDC
+#define INFF_PCIE_CFGREG_RBAR_CTRL		0x228
+#define INFF_PCIE_CFGREG_PML1_SUB_CTRL1	0x248
+#define INFF_PCIE_CFGREG_REG_BAR2_CONFIG	0x4E0
+#define INFF_PCIE_CFGREG_REG_BAR3_CONFIG	0x4F4
+#define INFF_PCIE_CFGREG_REVID_SECURE_MODE	BIT(31)
+#define INFF_PCIE_LINK_STATUS_CTRL_ASPM_ENAB	3
+
+/* Magic number at a magic location to find RAM size */
+#define INFF_RAMSIZE_MAGIC			0x534d4152	/* SMAR */
+#define INFF_RAMSIZE_OFFSET			0x6c
+
+#define INFF_ENTROPY_SEED_LEN		64u
+#define INFF_ENTROPY_NONCE_LEN		16u
+#define INFF_ENTROPY_HOST_LEN		(INFF_ENTROPY_SEED_LEN + \
+					 INFF_ENTROPY_NONCE_LEN)
+#define INFF_NVRAM_OFFSET_TCM		4u
+#define INFF_NVRAM_COMPRS_FACTOR	4u
+#define INFF_NVRAM_RNG_SIGNATURE	0xFEEDC0DEu
+
+struct inff_rand_metadata {
+	u32 signature;
+	u32 count;
+};
+
+struct inff_pcie_console {
+	u32 base_addr;
+	u32 buf_addr;
+	u32 bufsize;
+	u32 read_idx;
+	u8 log_str[256];
+	u8 log_idx;
+};
+
+struct inff_pcie_shared_info {
+	u32 tcm_base_address;
+	u32 flags;
+	struct inff_pcie_ringbuf *commonrings[INFF_NROF_COMMON_MSGRINGS];
+	struct inff_pcie_ringbuf *flowrings;
+	u16 max_rxbufpost;
+	u16 max_flowrings;
+	u16 max_submissionrings;
+	u16 max_completionrings;
+	u32 rx_dataoffset;
+	u32 htod_mb_data_addr;
+	u32 dtoh_mb_data_addr;
+	u32 ring_info_addr;
+	struct inff_pcie_console console;
+	void *scratch;
+	dma_addr_t scratch_dmahandle;
+	void *ringupd;
+	dma_addr_t ringupd_dmahandle;
+	u8 version;
+};
+
+struct inff_pcie_core_info {
+	u32 base;
+	u32 wrapbase;
+};
+
+struct inff_pciedev_info {
+	enum inff_pcie_state state;
+	bool in_irq;
+	struct pci_dev *pdev;
+	const struct inff_pcie_reginfo *reginfo;
+	void __iomem *regs;
+	void __iomem *tcm;
+	u32 ram_base;
+	u32 ram_size;
+	struct inff_chip *ci;
+	u32 coreid;
+	struct inff_pcie_shared_info shared;
+	u8 hostready;
+	bool use_mailbox;
+	bool use_d0_inform;
+	wait_queue_head_t mbdata_resp_wait;
+	bool mbdata_completed;
+	bool irq_allocated;
+	bool wowl_enabled;
+	u8 dma_idx_sz;
+	void *idxbuf;
+	u32 idxbuf_sz;
+	dma_addr_t idxbuf_dmahandle;
+	u16 (*read_ptr)(struct inff_pciedev_info *devinfo, u32 mem_offset);
+	void (*write_ptr)(struct inff_pciedev_info *devinfo, u32 mem_offset,
+			  u16 value);
+	struct inff_mp_device *settings;
+	ulong bar1_size;
+#ifdef DEBUG
+	u32 console_interval;
+	bool console_active;
+	struct timer_list timer;
+#endif
+};
+
+struct inff_pcie_ringbuf {
+	struct inff_commonring commonring;
+	dma_addr_t dma_handle;
+	u32 w_idx_addr;
+	u32 r_idx_addr;
+	struct inff_pciedev_info *devinfo;
+	u8 id;
+};
+
+/**
+ * struct inff_pcie_dhi_ringinfo - dongle/host interface shared ring info
+ *
+ * @ringmem: dongle memory pointer to ring memory location
+ * @h2d_w_idx_ptr: h2d ring write indices dongle memory pointers
+ * @h2d_r_idx_ptr: h2d ring read indices dongle memory pointers
+ * @d2h_w_idx_ptr: d2h ring write indices dongle memory pointers
+ * @d2h_r_idx_ptr: d2h ring read indices dongle memory pointers
+ * @h2d_w_idx_hostaddr: h2d ring write indices host memory pointers
+ * @h2d_r_idx_hostaddr: h2d ring read indices host memory pointers
+ * @d2h_w_idx_hostaddr: d2h ring write indices host memory pointers
+ * @d2h_r_idx_hostaddr: d2h ring reaD indices host memory pointers
+ * @max_flowrings: maximum number of tx flow rings supported.
+ * @max_submissionrings: maximum number of submission rings(h2d) supported.
+ * @max_completionrings: maximum number of completion rings(d2h) supported.
+ */
+struct inff_pcie_dhi_ringinfo {
+	__le32			ringmem;
+	__le32			h2d_w_idx_ptr;
+	__le32			h2d_r_idx_ptr;
+	__le32			d2h_w_idx_ptr;
+	__le32			d2h_r_idx_ptr;
+	struct msgbuf_buf_addr	h2d_w_idx_hostaddr;
+	struct msgbuf_buf_addr	h2d_r_idx_hostaddr;
+	struct msgbuf_buf_addr	d2h_w_idx_hostaddr;
+	struct msgbuf_buf_addr	d2h_r_idx_hostaddr;
+	__le16			max_flowrings;
+	__le16			max_submissionrings;
+	__le16			max_completionrings;
+};
+
+struct inff_pcie_reginfo {
+	u32 intmask;
+	u32 mailboxint;
+	u32 mailboxmask;
+	u32 h2d_mailbox_0;
+	u32 h2d_mailbox_1;
+	u32 int_d2h_db;
+	u32 int_fn0;
+};
+
+static const struct inff_pcie_reginfo inff_reginfo_default = {
+	.intmask = INFF_PCIE_PCIE2REG_INTMASK,
+	.mailboxint = INFF_PCIE_PCIE2REG_MAILBOXINT,
+	.mailboxmask = INFF_PCIE_PCIE2REG_MAILBOXMASK,
+	.h2d_mailbox_0 = INFF_PCIE_PCIE2REG_H2D_MAILBOX_0,
+	.h2d_mailbox_1 = INFF_PCIE_PCIE2REG_H2D_MAILBOX_1,
+	.int_d2h_db = INFF_PCIE_MB_INT_D2H_DB,
+	.int_fn0 = INFF_PCIE_MB_INT_FN0,
+};
+
+static const struct inff_pcie_reginfo inff_reginfo_64 = {
+	.intmask = INFF_PCIE_64_PCIE2REG_INTMASK,
+	.mailboxint = INFF_PCIE_64_PCIE2REG_MAILBOXINT,
+	.mailboxmask = INFF_PCIE_64_PCIE2REG_MAILBOXMASK,
+	.h2d_mailbox_0 = INFF_PCIE_PCIE2REG_H2D_MAILBOX_0,
+	.h2d_mailbox_1 = INFF_PCIE_PCIE2REG_H2D_MAILBOX_1,
+	.int_d2h_db = INFF_PCIE_64_MB_INT_D2H_DB,
+	.int_fn0 = INFF_PCIE_MB_INT_FN0,
+};
+
+static void inff_pcie_setup(struct device *dev, int ret,
+			    struct inff_fw_request *fwreq);
+static void
+inff_pcie_fwcon_timer(struct inff_pciedev_info *devinfo, bool active);
+static void inff_pcie_debugfs_create(struct device *dev);
+static void inff_pcie_bus_console_init(struct inff_pciedev_info *devinfo);
+static void inff_pcie_bus_console_read(struct inff_pciedev_info *devinfo,
+				       bool error);
+static void
+inff_pcie_fwcon_timer(struct inff_pciedev_info *devinfo, bool active);
+static void inff_pcie_debugfs_create(struct device *dev);
+
+#ifdef CONFIG_INFFMAC_PCIE_BARWIN_SZ
+DEFINE_RAW_SPINLOCK(pcie_lock);
+#endif /* CONFIG_INFFMAC_PCIE_BARWIN_SZ */
+
+static u32
+inff_pcie_read_reg32(struct inff_pciedev_info *devinfo, u32 reg_offset)
+{
+	void __iomem *address = devinfo->regs + reg_offset;
+
+	return ioread32(address);
+}
+
+static void
+inff_pcie_write_reg32(struct inff_pciedev_info *devinfo, u32 reg_offset,
+		      u32 value)
+{
+	void __iomem *address = devinfo->regs + reg_offset;
+
+	iowrite32(value, address);
+}
+
+static u8
+inff_pcie_read_tcm8(struct inff_pciedev_info *devinfo, u32 mem_offset)
+{
+	void __iomem *address = devinfo->tcm + mem_offset;
+#ifdef CONFIG_INFFMAC_PCIE_BARWIN_SZ
+	unsigned long flags;
+	u8 value;
+
+	raw_spin_lock_irqsave(&pcie_lock, flags);
+	if ((address - devinfo->tcm) >= devinfo->bar1_size) {
+		pci_write_config_dword(devinfo->pdev, INFF_PCIE_BAR1_WINDOW,
+				       devinfo->bar1_size);
+		address = address - devinfo->bar1_size;
+	}
+	value = ioread8(address);
+	pci_write_config_dword(devinfo->pdev, INFF_PCIE_BAR1_WINDOW, 0x0);
+	raw_spin_unlock_irqrestore(&pcie_lock, flags);
+
+	return value;
+#else
+	struct pci_dev *pdev = devinfo->pdev;
+	struct inff_bus *bus = dev_get_drvdata(&pdev->dev);
+
+	if ((address - devinfo->tcm) >= devinfo->bar1_size) {
+		inff_err(bus,
+			 "mem_offset:%d exceeds device size=%ld\n",
+			 mem_offset, devinfo->bar1_size);
+		return -EINVAL;
+	}
+
+	return (ioread8(address));
+#endif /* CONFIG_INFFMAC_PCIE_BARWIN_SZ */
+}
+
+static u16
+inff_pcie_read_tcm16(struct inff_pciedev_info *devinfo, u32 mem_offset)
+{
+	void __iomem *address = devinfo->tcm + mem_offset;
+#ifdef CONFIG_INFFMAC_PCIE_BARWIN_SZ
+	u16 value;
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&pcie_lock, flags);
+	if ((address - devinfo->tcm) >= devinfo->bar1_size) {
+		pci_write_config_dword(devinfo->pdev, INFF_PCIE_BAR1_WINDOW,
+				       devinfo->bar1_size);
+		address = address - devinfo->bar1_size;
+	}
+	value = ioread16(address);
+	pci_write_config_dword(devinfo->pdev, INFF_PCIE_BAR1_WINDOW, 0x0);
+	raw_spin_unlock_irqrestore(&pcie_lock, flags);
+
+	return value;
+#else
+	struct pci_dev *pdev = devinfo->pdev;
+	struct inff_bus *bus = dev_get_drvdata(&pdev->dev);
+
+	if ((address - devinfo->tcm) >= devinfo->bar1_size) {
+		inff_err(bus, "mem_offset:%d exceeds device size=%ld\n",
+			 mem_offset, devinfo->bar1_size);
+		return -EINVAL;
+	}
+
+	return (ioread16(address));
+#endif /* CONFIG_INFFMAC_PCIE_BARWIN_SZ */
+}
+
+static void
+inff_pcie_write_tcm16(struct inff_pciedev_info *devinfo, u32 mem_offset,
+		      u16 value)
+{
+	void __iomem *address = devinfo->tcm + mem_offset;
+#ifdef CONFIG_INFFMAC_PCIE_BARWIN_SZ
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&pcie_lock, flags);
+	if ((address - devinfo->tcm) >= devinfo->bar1_size) {
+		pci_write_config_dword(devinfo->pdev, INFF_PCIE_BAR1_WINDOW,
+				       devinfo->bar1_size);
+		address = address - devinfo->bar1_size;
+	}
+
+	iowrite16(value, address);
+	pci_write_config_dword(devinfo->pdev, INFF_PCIE_BAR1_WINDOW, 0x0);
+	raw_spin_unlock_irqrestore(&pcie_lock, flags);
+#else
+	struct pci_dev *pdev = devinfo->pdev;
+	struct inff_bus *bus = dev_get_drvdata(&pdev->dev);
+
+	if ((address - devinfo->tcm) >= devinfo->bar1_size) {
+		inff_err(bus, "mem_offset:%d exceeds device size=%ld\n",
+			 mem_offset, devinfo->bar1_size);
+		return;
+	}
+
+	iowrite16(value, address);
+#endif /* CONFIG_INFFMAC_PCIE_BARWIN_SZ */
+}
+
+static u16
+inff_pcie_read_idx(struct inff_pciedev_info *devinfo, u32 mem_offset)
+{
+	u16 *address = devinfo->idxbuf + mem_offset;
+
+	return (*(address));
+}
+
+static void
+inff_pcie_write_idx(struct inff_pciedev_info *devinfo, u32 mem_offset,
+		    u16 value)
+{
+	u16 *address = devinfo->idxbuf + mem_offset;
+
+	*(address) = value;
+}
+
+static u32
+inff_pcie_read_tcm32(struct inff_pciedev_info *devinfo, u32 mem_offset)
+{
+	void __iomem *address = devinfo->tcm + mem_offset;
+#ifdef CONFIG_INFFMAC_PCIE_BARWIN_SZ
+	u32 value;
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&pcie_lock, flags);
+	if ((address - devinfo->tcm) >= devinfo->bar1_size) {
+		pci_write_config_dword(devinfo->pdev, INFF_PCIE_BAR1_WINDOW,
+				       devinfo->bar1_size);
+		address = address - devinfo->bar1_size;
+	}
+	value = ioread32(address);
+	pci_write_config_dword(devinfo->pdev, INFF_PCIE_BAR1_WINDOW, 0x0);
+	raw_spin_unlock_irqrestore(&pcie_lock, flags);
+
+	return value;
+#else
+	struct pci_dev *pdev = devinfo->pdev;
+	struct inff_bus *bus = dev_get_drvdata(&pdev->dev);
+
+	if ((address - devinfo->tcm) >= devinfo->bar1_size) {
+		inff_err(bus, "mem_offset:%d exceeds device size=%ld\n",
+			 mem_offset, devinfo->bar1_size);
+		return -EINVAL;
+	}
+
+	return (ioread32(address));
+#endif /* CONFIG_INFFMAC_PCIE_BARWIN_SZ */
+}
+
+static void
+inff_pcie_write_tcm32(struct inff_pciedev_info *devinfo, u32 mem_offset,
+		      u32 value)
+{
+	void __iomem *address = devinfo->tcm + mem_offset;
+#ifdef CONFIG_INFFMAC_PCIE_BARWIN_SZ
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&pcie_lock, flags);
+	if ((address - devinfo->tcm) >= devinfo->bar1_size) {
+		pci_write_config_dword(devinfo->pdev, INFF_PCIE_BAR1_WINDOW,
+				       devinfo->bar1_size);
+		address = address - devinfo->bar1_size;
+	}
+	iowrite32(value, address);
+	pci_write_config_dword(devinfo->pdev, INFF_PCIE_BAR1_WINDOW, 0x0);
+	raw_spin_unlock_irqrestore(&pcie_lock, flags);
+#else
+	struct pci_dev *pdev = devinfo->pdev;
+	struct inff_bus *bus = dev_get_drvdata(&pdev->dev);
+
+	if ((address - devinfo->tcm) >= devinfo->bar1_size) {
+		inff_err(bus, "mem_offset:%d exceeds device size=%ld\n",
+			 mem_offset, devinfo->bar1_size);
+		return;
+	}
+
+	iowrite32(value, address);
+#endif /* CONFIG_INFFMAC_PCIE_BARWIN_SZ */
+}
+
+static u32
+inff_pcie_read_ram32(struct inff_pciedev_info *devinfo, u32 mem_offset)
+{
+	void __iomem *address = devinfo->tcm + devinfo->ci->rambase
+		+ mem_offset;
+#ifdef CONFIG_INFFMAC_PCIE_BARWIN_SZ
+	u32 value;
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&pcie_lock, flags);
+	if ((address - devinfo->tcm) >= devinfo->bar1_size) {
+		pci_write_config_dword(devinfo->pdev, INFF_PCIE_BAR1_WINDOW,
+				       devinfo->bar1_size);
+		address = address - devinfo->bar1_size;
+	}
+	value = ioread32(address);
+	pci_write_config_dword(devinfo->pdev, INFF_PCIE_BAR1_WINDOW, 0x0);
+	raw_spin_unlock_irqrestore(&pcie_lock, flags);
+
+	return value;
+#else
+	struct pci_dev *pdev = devinfo->pdev;
+	struct inff_bus *bus = dev_get_drvdata(&pdev->dev);
+
+	if ((address - devinfo->tcm) >= devinfo->bar1_size) {
+		inff_err(bus, "mem_offset:%d exceeds device size=%ld\n",
+			 mem_offset, devinfo->bar1_size);
+		return -EINVAL;
+	}
+
+	return (ioread32(address));
+#endif /* CONFIG_INFFMAC_PCIE_BARWIN_SZ */
+}
+
+static void
+inff_pcie_write_ram32(struct inff_pciedev_info *devinfo, u32 mem_offset,
+		      u32 value)
+{
+	void __iomem *address = devinfo->tcm + devinfo->ci->rambase
+		+ mem_offset;
+#ifdef CONFIG_INFFMAC_PCIE_BARWIN_SZ
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&pcie_lock, flags);
+	if ((address - devinfo->tcm) >= devinfo->bar1_size) {
+		pci_write_config_dword(devinfo->pdev, INFF_PCIE_BAR1_WINDOW,
+				       devinfo->bar1_size);
+		address = address - devinfo->bar1_size;
+	}
+	iowrite32(value, address);
+	pci_write_config_dword(devinfo->pdev, INFF_PCIE_BAR1_WINDOW, 0x0);
+	raw_spin_unlock_irqrestore(&pcie_lock, flags);
+#else
+	struct pci_dev *pdev = devinfo->pdev;
+	struct inff_bus *bus = dev_get_drvdata(&pdev->dev);
+
+	if ((address - devinfo->tcm) >= devinfo->bar1_size) {
+		inff_err(bus, "mem_offset:%d exceeds device size=%ld\n",
+			 mem_offset, devinfo->bar1_size);
+		return;
+	}
+
+	iowrite32(value, address);
+#endif /* CONFIG_INFFMAC_PCIE_BARWIN_SZ */
+}
+
+static void
+inff_pcie_copy_mem_todev(struct inff_pciedev_info *devinfo, u32 mem_offset,
+			 void *srcaddr, u32 len)
+{
+	struct pci_dev *pdev = devinfo->pdev;
+#ifndef CONFIG_INFFMAC_PCIE_BARWIN_SZ
+	struct inff_bus *bus = dev_get_drvdata(&pdev->dev);
+#endif
+	void __iomem *address = devinfo->tcm + mem_offset;
+	__le32 *src32;
+	__le16 *src16;
+	u8 *src8;
+#ifdef CONFIG_INFFMAC_PCIE_BARWIN_SZ
+	unsigned long flags;
+#endif /* CONFIG_INFFMAC_PCIE_BARWIN_SZ */
+
+	if (((ulong)address & 4) || ((ulong)srcaddr & 4) || (len & 4)) {
+		if (((ulong)address & 2) || ((ulong)srcaddr & 2) || (len & 2)) {
+			src8 = (u8 *)srcaddr;
+			while (len) {
+#ifdef CONFIG_INFFMAC_PCIE_BARWIN_SZ
+				raw_spin_lock_irqsave(&pcie_lock, flags);
+				if ((address - devinfo->tcm) >=
+				    devinfo->bar1_size) {
+					pci_write_config_dword
+						(pdev,
+						 INFF_PCIE_BAR1_WINDOW,
+						 devinfo->bar1_size);
+					address = address -
+						devinfo->bar1_size;
+				}
+#else
+				if ((address - devinfo->tcm) >=
+				    devinfo->bar1_size) {
+					inff_err(bus,
+						 "mem_offset:%d exceeds device size=%ld\n",
+						 mem_offset, devinfo->bar1_size);
+					return;
+				}
+#endif /* CONFIG_INFFMAC_PCIE_BARWIN_SZ */
+				iowrite8(*src8, address);
+#ifdef CONFIG_INFFMAC_PCIE_BARWIN_SZ
+				raw_spin_unlock_irqrestore(&pcie_lock, flags);
+#endif /* CONFIG_INFFMAC_PCIE_BARWIN_SZ */
+				address++;
+				src8++;
+				len--;
+			}
+		} else {
+			len = len / 2;
+			src16 = (__le16 *)srcaddr;
+			while (len) {
+#ifdef CONFIG_INFFMAC_PCIE_BARWIN_SZ
+				raw_spin_lock_irqsave(&pcie_lock, flags);
+				if ((address - devinfo->tcm) >=
+					devinfo->bar1_size) {
+					pci_write_config_dword
+						(pdev,
+						INFF_PCIE_BAR1_WINDOW,
+						devinfo->bar1_size);
+					address = address -
+						devinfo->bar1_size;
+				}
+#else
+				if ((address - devinfo->tcm) >=
+				    devinfo->bar1_size) {
+					inff_err(bus,
+						 "mem_offset:%d exceeds device size=%ld\n",
+						 mem_offset, devinfo->bar1_size);
+					return;
+				}
+#endif /* CONFIG_INFFMAC_PCIE_BARWIN_SZ */
+				iowrite16(le16_to_cpu(*src16), address);
+#ifdef CONFIG_INFFMAC_PCIE_BARWIN_SZ
+				raw_spin_unlock_irqrestore(&pcie_lock, flags);
+#endif /* CONFIG_INFFMAC_PCIE_BARWIN_SZ */
+				address += 2;
+				src16++;
+				len--;
+			}
+		}
+	} else {
+		len = len / 4;
+		src32 = (__le32 *)srcaddr;
+		while (len) {
+#ifdef CONFIG_INFFMAC_PCIE_BARWIN_SZ
+			raw_spin_lock_irqsave(&pcie_lock, flags);
+			if ((address - devinfo->tcm) >=
+			    devinfo->bar1_size) {
+				pci_write_config_dword
+					(pdev,
+					 INFF_PCIE_BAR1_WINDOW,
+					 devinfo->bar1_size);
+				address = address - devinfo->bar1_size;
+			}
+#else
+			if ((address - devinfo->tcm) >=
+				devinfo->bar1_size) {
+				inff_err(bus,
+					 "mem_offset:%d exceeds device size=%ld\n",
+					 mem_offset, devinfo->bar1_size);
+				return;
+			}
+#endif /* CONFIG_INFFMAC_PCIE_BARWIN_SZ */
+			iowrite32(le32_to_cpu(*src32), address);
+#ifdef CONFIG_INFFMAC_PCIE_BARWIN_SZ
+			raw_spin_unlock_irqrestore(&pcie_lock, flags);
+#endif /* CONFIG_INFFMAC_PCIE_BARWIN_SZ */
+			address += 4;
+			src32++;
+			len--;
+		}
+	}
+#ifdef CONFIG_INFFMAC_PCIE_BARWIN_SZ
+	pci_write_config_dword(pdev, INFF_PCIE_BAR1_WINDOW, 0x0);
+#endif /* CONFIG_INFFMAC_PCIE_BARWIN_SZ */
+}
+
+static void
+inff_pcie_copy_dev_tomem(struct inff_pciedev_info *devinfo, u32 mem_offset,
+			 void *dstaddr, u32 len)
+{
+	struct pci_dev *pdev = devinfo->pdev;
+#ifndef CONFIG_INFFMAC_PCIE_BARWIN_SZ
+	struct inff_bus *bus = dev_get_drvdata(&pdev->dev);
+#endif
+	void __iomem *address = devinfo->tcm + mem_offset;
+	__le32 *dst32;
+	__le16 *dst16;
+	u8 *dst8;
+#ifdef CONFIG_INFFMAC_PCIE_BARWIN_SZ
+	unsigned long flags;
+#endif /* CONFIG_INFFMAC_PCIE_BARWIN_SZ */
+
+	if (((ulong)address & 4) || ((ulong)dstaddr & 4) || (len & 4)) {
+		if (((ulong)address & 2) || ((ulong)dstaddr & 2) || (len & 2)) {
+			dst8 = (u8 *)dstaddr;
+			while (len) {
+#ifdef CONFIG_INFFMAC_PCIE_BARWIN_SZ
+				raw_spin_lock_irqsave(&pcie_lock, flags);
+				if ((address - devinfo->tcm) >=
+				    devinfo->bar1_size) {
+					pci_write_config_dword
+						(pdev,
+						INFF_PCIE_BAR1_WINDOW,
+						devinfo->bar1_size);
+					address = address -
+						devinfo->bar1_size;
+				}
+#else
+				if ((address - devinfo->tcm) >=
+					devinfo->bar1_size) {
+					inff_err(bus,
+						 "mem_offset:%d exceeds device size=%ld\n",
+						 mem_offset, devinfo->bar1_size);
+					return;
+				}
+#endif /* CONFIG_INFFMAC_PCIE_BARWIN_SZ */
+				*dst8 = ioread8(address);
+#ifdef CONFIG_INFFMAC_PCIE_BARWIN_SZ
+				raw_spin_unlock_irqrestore(&pcie_lock, flags);
+#endif /* CONFIG_INFFMAC_PCIE_BARWIN_SZ */
+				address++;
+				dst8++;
+				len--;
+			}
+		} else {
+			len = len / 2;
+			dst16 = (__le16 *)dstaddr;
+			while (len) {
+#ifdef CONFIG_INFFMAC_PCIE_BARWIN_SZ
+				raw_spin_lock_irqsave(&pcie_lock, flags);
+				if ((address - devinfo->tcm) >=
+				    devinfo->bar1_size) {
+					pci_write_config_dword
+						(pdev,
+						INFF_PCIE_BAR1_WINDOW,
+						devinfo->bar1_size);
+					address = address -
+						devinfo->bar1_size;
+				}
+#else
+				if ((address - devinfo->tcm) >=
+					devinfo->bar1_size) {
+					inff_err(bus,
+						 "mem_offset:%d exceeds device size=%ld\n",
+						 mem_offset, devinfo->bar1_size);
+					return;
+				}
+#endif /* CONFIG_INFFMAC_PCIE_BARWIN_SZ */
+				*dst16 = cpu_to_le16(ioread16(address));
+#ifdef CONFIG_INFFMAC_PCIE_BARWIN_SZ
+				raw_spin_unlock_irqrestore(&pcie_lock, flags);
+#endif /* CONFIG_INFFMAC_PCIE_BARWIN_SZ */
+				address += 2;
+				dst16++;
+				len--;
+			}
+		}
+	} else {
+		len = len / 4;
+		dst32 = (__le32 *)dstaddr;
+		while (len) {
+#ifdef CONFIG_INFFMAC_PCIE_BARWIN_SZ
+			raw_spin_lock_irqsave(&pcie_lock, flags);
+			if ((address - devinfo->tcm) >=
+			    devinfo->bar1_size) {
+				pci_write_config_dword
+					(pdev,
+					INFF_PCIE_BAR1_WINDOW,
+					devinfo->bar1_size);
+				address = address - devinfo->bar1_size;
+			}
+#else
+			if ((address - devinfo->tcm) >=
+				devinfo->bar1_size) {
+				inff_err(bus,
+					 "mem_offset:%d exceeds device size=%ld\n",
+					 mem_offset, devinfo->bar1_size);
+				return;
+			}
+#endif /* CONFIG_INFFMAC_PCIE_BARWIN_SZ */
+			*dst32 = cpu_to_le32(ioread32(address));
+#ifdef CONFIG_INFFMAC_PCIE_BARWIN_SZ
+			raw_spin_unlock_irqrestore(&pcie_lock, flags);
+#endif /* CONFIG_INFFMAC_PCIE_BARWIN_SZ */
+			address += 4;
+			dst32++;
+			len--;
+		}
+	}
+#ifdef CONFIG_INFFMAC_PCIE_BARWIN_SZ
+	pci_write_config_dword(pdev, INFF_PCIE_BAR1_WINDOW, 0x0);
+#endif /* CONFIG_INFFMAC_PCIE_BARWIN_SZ */
+}
+
+#define WRITECC32(devinfo, reg, value) inff_pcie_write_reg32(devinfo, \
+		CHIPCREGOFFS(reg), value)
+
+static void
+inff_pcie_select_core(struct inff_pciedev_info *devinfo, u16 coreid)
+{
+	const struct pci_dev *pdev = devinfo->pdev;
+	struct inff_bus *bus = dev_get_drvdata(&pdev->dev);
+	struct inff_core *core;
+	u32 bar0_win;
+
+	core = inff_chip_get_core(devinfo->ci, coreid);
+	if (core) {
+		bar0_win = core->base;
+		pci_write_config_dword(pdev, INFF_PCIE_BAR0_WINDOW, bar0_win);
+		if (pci_read_config_dword(pdev, INFF_PCIE_BAR0_WINDOW,
+					  &bar0_win) == 0) {
+			if (bar0_win != core->base) {
+				bar0_win = core->base;
+				pci_write_config_dword(pdev,
+						       INFF_PCIE_BAR0_WINDOW,
+						       bar0_win);
+			}
+		}
+	} else {
+		inff_err(bus, "Unsupported core selected %x\n", coreid);
+	}
+}
+
+static void inff_pcie_reset_device(struct inff_pciedev_info *devinfo)
+{
+	struct inff_core *core;
+	static const u16 cfg_offset[] = {
+		INFF_PCIE_CFGREG_STATUS_CMD,
+		INFF_PCIE_CFGREG_PM_CSR,
+		INFF_PCIE_CFGREG_MSI_CAP,
+		INFF_PCIE_CFGREG_MSI_ADDR_L,
+		INFF_PCIE_CFGREG_MSI_ADDR_H,
+		INFF_PCIE_CFGREG_MSI_DATA,
+#ifdef CONFIG_INFFMAC_PCIE_BARWIN_SZ
+		INFF_PCIE_BAR1_WINDOW,
+#endif /* CONFIG_INFFMAC_PCIE_BARWIN_SZ */
+		INFF_PCIE_CFGREG_LINK_STATUS_CTRL2,
+		INFF_PCIE_CFGREG_RBAR_CTRL,
+		INFF_PCIE_CFGREG_PML1_SUB_CTRL1,
+		INFF_PCIE_CFGREG_REG_BAR2_CONFIG,
+		INFF_PCIE_CFGREG_REG_BAR3_CONFIG
+	};
+	u32 i;
+	u32 val;
+	u32 lsc;
+
+	if (!devinfo->ci)
+		return;
+
+	/* Disable ASPM */
+	inff_pcie_select_core(devinfo, INF_CORE_PCIE2);
+	pci_read_config_dword(devinfo->pdev, INFF_PCIE_REG_LINK_STATUS_CTRL,
+			      &lsc);
+	val = lsc & (~INFF_PCIE_LINK_STATUS_CTRL_ASPM_ENAB);
+	pci_write_config_dword(devinfo->pdev, INFF_PCIE_REG_LINK_STATUS_CTRL,
+			       val);
+
+	/* Watchdog reset */
+	devinfo->ci->blhs->init(devinfo->ci);
+	inff_pcie_select_core(devinfo, INF_CORE_CHIPCOMMON);
+	WRITECC32(devinfo, watchdog, 4);
+	msleep(100);
+	if (devinfo->ci->blhs->post_wdreset(devinfo->ci))
+		return;
+
+	/* Restore ASPM */
+	inff_pcie_select_core(devinfo, INF_CORE_PCIE2);
+	pci_write_config_dword(devinfo->pdev, INFF_PCIE_REG_LINK_STATUS_CTRL,
+			       lsc);
+
+	core = inff_chip_get_core(devinfo->ci, INF_CORE_PCIE2);
+	if (core->rev <= 13) {
+		for (i = 0; i < ARRAY_SIZE(cfg_offset); i++) {
+			inff_pcie_write_reg32(devinfo,
+					      INFF_PCIE_PCIE2REG_CONFIGADDR,
+					      cfg_offset[i]);
+			val = inff_pcie_read_reg32(devinfo,
+						   INFF_PCIE_PCIE2REG_CONFIGDATA);
+			inff_dbg(PCIE, "config offset 0x%04x, value 0x%04x\n",
+				 cfg_offset[i], val);
+			inff_pcie_write_reg32(devinfo,
+					      INFF_PCIE_PCIE2REG_CONFIGDATA,
+					      val);
+		}
+	}
+}
+
+static void inff_pcie_attach(struct inff_pciedev_info *devinfo)
+{
+	u32 config;
+
+	/* BAR1 window may not be sized properly */
+	inff_pcie_select_core(devinfo, INF_CORE_PCIE2);
+	inff_pcie_write_reg32(devinfo, INFF_PCIE_PCIE2REG_CONFIGADDR, 0x4e0);
+	config = inff_pcie_read_reg32(devinfo, INFF_PCIE_PCIE2REG_CONFIGDATA);
+	inff_pcie_write_reg32(devinfo, INFF_PCIE_PCIE2REG_CONFIGDATA, config);
+
+	device_wakeup_enable(&devinfo->pdev->dev);
+}
+
+static int inff_pcie_bus_readshared(struct inff_pciedev_info *devinfo,
+				    u32 nvram_csm)
+{
+	struct inff_bus *bus = dev_get_drvdata(&devinfo->pdev->dev);
+	u32 loop_counter;
+	u32 addr_le;
+	u32 addr = 0;
+
+	loop_counter = INFF_PCIE_READ_SHARED_TIMEOUT / 50;
+	while ((addr == 0 || addr == nvram_csm) && (loop_counter)) {
+		msleep(50);
+		addr_le = inff_pcie_read_ram32(devinfo,
+					       devinfo->ci->ramsize - 4);
+		addr = le32_to_cpu(addr_le);
+		loop_counter--;
+	}
+	if (addr == 0 || addr == nvram_csm || addr < devinfo->ci->rambase ||
+	    addr >= devinfo->ci->rambase + devinfo->ci->ramsize) {
+		inff_err(bus, "Invalid shared RAM address 0x%08x\n", addr);
+		return -ENODEV;
+	}
+	devinfo->shared.tcm_base_address = addr;
+	inff_dbg(PCIE, "Shared RAM addr: 0x%08x\n", addr);
+
+	inff_pcie_bus_console_init(devinfo);
+	return 0;
+}
+
+static int inff_pcie_enter_download_state(struct inff_pciedev_info *devinfo)
+{
+	struct inff_bus *bus = dev_get_drvdata(&devinfo->pdev->dev);
+	int err = 0;
+
+	err = devinfo->ci->blhs->prep_fwdl(devinfo->ci);
+	if (err) {
+		inff_err(bus, "FW download preparation failed");
+		return err;
+	}
+
+	if (!inff_pcie_bus_readshared(devinfo, 0))
+		inff_pcie_bus_console_read(devinfo, false);
+
+	return err;
+}
+
+static int inff_pcie_exit_download_state(struct inff_pciedev_info *devinfo,
+					 u32 resetintr)
+{
+	inff_pcie_bus_console_read(devinfo, false);
+	devinfo->ci->blhs->post_nvramdl(devinfo->ci);
+
+	return 0;
+}
+
+static int
+inff_pcie_send_mb_data(struct inff_pciedev_info *devinfo, u32 htod_mb_data)
+{
+	struct inff_pcie_shared_info *shared;
+	struct inff_bus *bus;
+	int err;
+	struct inff_core *core;
+	u32 addr;
+	u32 cur_htod_mb_data;
+	u32 i;
+
+	shared = &devinfo->shared;
+	bus = dev_get_drvdata(&devinfo->pdev->dev);
+	if (shared->version >= INFF_PCIE_SHARED_VERSION_6 &&
+	    !devinfo->use_mailbox) {
+		err = inff_msgbuf_tx_mbdata(bus->drvr, htod_mb_data);
+		if (err) {
+			inff_err(bus, "sendimg mbdata failed err=%d\n", err);
+			return err;
+		}
+	} else {
+		addr = shared->htod_mb_data_addr;
+		cur_htod_mb_data = inff_pcie_read_tcm32(devinfo, addr);
+
+		if (cur_htod_mb_data != 0)
+			inff_dbg(PCIE, "MB transaction is already pending 0x%04x\n",
+				 cur_htod_mb_data);
+
+		i = 0;
+		while (cur_htod_mb_data != 0) {
+			usleep_range(10000, 10001);
+			i++;
+			if (i > 100)
+				return -EIO;
+			cur_htod_mb_data = inff_pcie_read_tcm32(devinfo, addr);
+		}
+
+		inff_pcie_write_tcm32(devinfo, addr, htod_mb_data);
+		pci_write_config_dword(devinfo->pdev, INFF_PCIE_REG_SBMBX, 1);
+
+		/* Send mailbox interrupt twice as a hardware workaround */
+		core = inff_chip_get_core(devinfo->ci, INF_CORE_PCIE2);
+		if (core->rev <= 13)
+			pci_write_config_dword(devinfo->pdev,
+					       INFF_PCIE_REG_SBMBX, 1);
+	}
+	return 0;
+}
+
+static u32 inff_pcie_read_mb_data(struct inff_pciedev_info *devinfo)
+{
+	struct inff_pcie_shared_info *shared;
+	u32 addr;
+	u32 dtoh_mb_data;
+
+	shared = &devinfo->shared;
+	addr = shared->dtoh_mb_data_addr;
+	dtoh_mb_data = inff_pcie_read_tcm32(devinfo, addr);
+	inff_pcie_write_tcm32(devinfo, addr, 0);
+	return dtoh_mb_data;
+}
+
+void inff_pcie_handle_mb_data(struct inff_bus *bus_if, u32 d2h_mb_data)
+{
+	struct inff_pciedev *buspub = bus_if->bus_priv.pcie;
+	struct inff_pciedev_info *devinfo = buspub->devinfo;
+
+	inff_dbg(INFO, "D2H_MB_DATA: 0x%04x\n", d2h_mb_data);
+
+	if (d2h_mb_data & INFF_D2H_DEV_DS_ENTER_REQ) {
+		inff_dbg(INFO, "D2H_MB_DATA: DEEP SLEEP REQ\n");
+		inff_pcie_send_mb_data(devinfo, INFF_H2D_HOST_DS_ACK);
+		inff_dbg(INFO, "D2H_MB_DATA: sent DEEP SLEEP ACK\n");
+	}
+
+	if (d2h_mb_data & INFF_D2H_DEV_DS_EXIT_NOTE)
+		inff_dbg(INFO, "D2H_MB_DATA: DEEP SLEEP EXIT\n");
+	if (d2h_mb_data & INFF_D2H_DEV_D3_ACK) {
+		inff_dbg(INFO, "D2H_MB_DATA: D3 ACK\n");
+		devinfo->mbdata_completed = true;
+		wake_up(&devinfo->mbdata_resp_wait);
+	}
+
+	if (d2h_mb_data & INFF_D2H_DEV_FWHALT) {
+		inff_dbg(INFO, "D2H_MB_DATA: FW HALT\n");
+		inff_fw_crashed(&devinfo->pdev->dev);
+	}
+}
+
+static void inff_pcie_bus_console_init(struct inff_pciedev_info *devinfo)
+{
+	struct inff_pcie_shared_info *shared;
+	struct inff_pcie_console *console;
+	u32 buf_addr;
+	u32 addr;
+
+	shared = &devinfo->shared;
+	console = &shared->console;
+	addr = shared->tcm_base_address + INFF_SHARED_CONSOLE_ADDR_OFFSET;
+	console->base_addr = inff_pcie_read_tcm32(devinfo, addr);
+
+	addr = console->base_addr + INFF_CONSOLE_BUFADDR_OFFSET;
+	buf_addr = inff_pcie_read_tcm32(devinfo, addr);
+	/* reset console index when buffer address is updated */
+	if (console->buf_addr != buf_addr) {
+		console->buf_addr = buf_addr;
+		console->read_idx = 0;
+	}
+	addr = console->base_addr + INFF_CONSOLE_BUFSIZE_OFFSET;
+	console->bufsize = inff_pcie_read_tcm32(devinfo, addr);
+
+	inff_dbg(FWCON, "Console: base %x, buf %x, size %d\n",
+		 console->base_addr, console->buf_addr, console->bufsize);
+}
+
+/**
+ * inff_pcie_bus_console_read - reads firmware messages
+ *
+ * @devinfo: pointer to the device data structure
+ * @error: specifies if error has occurred (prints messages unconditionally)
+ */
+static void inff_pcie_bus_console_read(struct inff_pciedev_info *devinfo,
+				       bool error)
+{
+	struct pci_dev *pdev = devinfo->pdev;
+	struct inff_bus *bus = dev_get_drvdata(&pdev->dev);
+	struct inff_pcie_console *console;
+	u32 addr;
+	u8 ch;
+	u32 newidx;
+
+	if (!error && !INFF_FWCON_ON())
+		return;
+
+	console = &devinfo->shared.console;
+	if (!console->base_addr)
+		return;
+	addr = console->base_addr + INFF_CONSOLE_WRITEIDX_OFFSET;
+	newidx = inff_pcie_read_tcm32(devinfo, addr);
+	while (newidx != console->read_idx) {
+		addr = console->buf_addr + console->read_idx;
+		ch = inff_pcie_read_tcm8(devinfo, addr);
+		console->read_idx++;
+		if (console->read_idx == console->bufsize)
+			console->read_idx = 0;
+		if (ch == '\r')
+			continue;
+		console->log_str[console->log_idx] = ch;
+		console->log_idx++;
+		if ((ch != '\n') &&
+		    (console->log_idx == (sizeof(console->log_str) - 2))) {
+			ch = '\n';
+			console->log_str[console->log_idx] = ch;
+			console->log_idx++;
+		}
+		if (ch == '\n') {
+			console->log_str[console->log_idx] = 0;
+			if (error)
+				__inff_err(bus, __func__, "CONSOLE: %s",
+					   console->log_str);
+			else
+				pr_debug("CONSOLE: %s", console->log_str);
+			console->log_idx = 0;
+		}
+	}
+}
+
+static void inff_pcie_intr_disable(struct inff_pciedev_info *devinfo)
+{
+	inff_pcie_write_reg32(devinfo, devinfo->reginfo->mailboxmask, 0);
+}
+
+static void inff_pcie_interrupt_disable(struct device *dev)
+{
+	struct inff_bus *bus_if = dev_get_drvdata(dev);
+	struct inff_pciedev *pcie_bus_dev = bus_if->bus_priv.pcie;
+	struct inff_pciedev_info *devinfo = pcie_bus_dev->devinfo;
+
+	inff_pcie_intr_disable(devinfo);
+}
+
+static void inff_pcie_intr_enable(struct inff_pciedev_info *devinfo)
+{
+	inff_pcie_write_reg32(devinfo, devinfo->reginfo->mailboxmask,
+			      devinfo->reginfo->int_d2h_db |
+			      devinfo->reginfo->int_fn0);
+}
+
+static void inff_pcie_interrupt_enable(struct device *dev)
+{
+	struct inff_bus *bus_if = dev_get_drvdata(dev);
+	struct inff_pciedev *pcie_bus_dev = bus_if->bus_priv.pcie;
+	struct inff_pciedev_info *devinfo = pcie_bus_dev->devinfo;
+
+	inff_pcie_intr_enable(devinfo);
+}
+
+static void inff_pcie_hostready(struct inff_pciedev_info *devinfo)
+{
+	if (devinfo->shared.flags & INFF_PCIE_SHARED_HOSTRDY_DB1)
+		inff_pcie_write_reg32(devinfo,
+				      devinfo->reginfo->h2d_mailbox_1, 1);
+}
+
+static irqreturn_t inff_pcie_quick_check_isr(int irq, void *arg)
+{
+	struct inff_pciedev_info *devinfo = (struct inff_pciedev_info *)arg;
+
+	if (inff_pcie_read_reg32(devinfo, devinfo->reginfo->mailboxint)) {
+		inff_pcie_intr_disable(devinfo);
+		inff_dbg(PCIE, "Enter\n");
+		return IRQ_WAKE_THREAD;
+	}
+	return IRQ_NONE;
+}
+
+static irqreturn_t inff_pcie_isr_thread(int irq, void *arg)
+{
+	struct inff_pciedev_info *devinfo = (struct inff_pciedev_info *)arg;
+	u32 status;
+	u32 d2h_mbdata;
+	struct pci_dev *pdev = devinfo->pdev;
+	struct inff_bus *bus = dev_get_drvdata(&pdev->dev);
+
+	devinfo->in_irq = true;
+	status = inff_pcie_read_reg32(devinfo, devinfo->reginfo->mailboxint);
+	inff_dbg(PCIE, "Enter %x\n", status);
+	if (status) {
+		inff_pcie_write_reg32(devinfo, devinfo->reginfo->mailboxint,
+				      status);
+		if (status & devinfo->reginfo->int_fn0) {
+			d2h_mbdata = inff_pcie_read_mb_data(devinfo);
+			inff_pcie_handle_mb_data(bus, d2h_mbdata);
+		}
+		if (status & devinfo->reginfo->int_d2h_db) {
+			if (devinfo->state == INFFMAC_PCIE_STATE_UP)
+				inff_proto_msgbuf_rx_trigger(&devinfo->pdev->dev);
+		}
+	}
+	inff_pcie_bus_console_read(devinfo, false);
+	if (devinfo->state == INFFMAC_PCIE_STATE_UP)
+		inff_pcie_intr_enable(devinfo);
+	devinfo->in_irq = false;
+	return IRQ_HANDLED;
+}
+
+static int inff_pcie_request_irq(struct inff_pciedev_info *devinfo)
+{
+	struct pci_dev *pdev = devinfo->pdev;
+	struct inff_bus *bus = dev_get_drvdata(&pdev->dev);
+
+	inff_pcie_intr_disable(devinfo);
+
+	inff_dbg(PCIE, "Enter\n");
+
+	pci_enable_msi(pdev);
+	if (request_threaded_irq(pdev->irq, inff_pcie_quick_check_isr,
+				 inff_pcie_isr_thread, IRQF_SHARED,
+				 "inff_pcie_intr", devinfo)) {
+		pci_disable_msi(pdev);
+		inff_err(bus, "Failed to request IRQ %d\n", pdev->irq);
+		return -EIO;
+	}
+	devinfo->irq_allocated = true;
+	return 0;
+}
+
+static void inff_pcie_release_irq(struct inff_pciedev_info *devinfo)
+{
+	struct pci_dev *pdev = devinfo->pdev;
+	struct inff_bus *bus = dev_get_drvdata(&pdev->dev);
+	u32 status;
+	u32 count;
+
+	if (!devinfo->irq_allocated)
+		return;
+
+	inff_pcie_intr_disable(devinfo);
+	free_irq(pdev->irq, devinfo);
+	pci_disable_msi(pdev);
+
+	msleep(50);
+	count = 0;
+	while ((devinfo->in_irq) && (count < 20)) {
+		msleep(50);
+		count++;
+	}
+	if (devinfo->in_irq)
+		inff_err(bus, "Still in IRQ (processing) !!!\n");
+
+	status = inff_pcie_read_reg32(devinfo, devinfo->reginfo->mailboxint);
+	inff_pcie_write_reg32(devinfo, devinfo->reginfo->mailboxint, status);
+
+	devinfo->irq_allocated = false;
+}
+
+static int inff_pcie_ring_mb_write_rptr(void *ctx)
+{
+	struct inff_pcie_ringbuf *ring = (struct inff_pcie_ringbuf *)ctx;
+	struct inff_pciedev_info *devinfo = ring->devinfo;
+	struct inff_commonring *commonring = &ring->commonring;
+
+	if (devinfo->state != INFFMAC_PCIE_STATE_UP)
+		return -EIO;
+
+	inff_dbg(PCIE, "W r_ptr %d (%d), ring %d\n", commonring->r_ptr,
+		 commonring->w_ptr, ring->id);
+
+	devinfo->write_ptr(devinfo, ring->r_idx_addr, commonring->r_ptr);
+
+	return 0;
+}
+
+static int inff_pcie_ring_mb_write_wptr(void *ctx)
+{
+	struct inff_pcie_ringbuf *ring = (struct inff_pcie_ringbuf *)ctx;
+	struct inff_pciedev_info *devinfo = ring->devinfo;
+	struct inff_commonring *commonring = &ring->commonring;
+
+	if (devinfo->state != INFFMAC_PCIE_STATE_UP)
+		return -EIO;
+
+	inff_dbg(PCIE, "W w_ptr %d (%d), ring %d\n", commonring->w_ptr,
+		 commonring->r_ptr, ring->id);
+
+	devinfo->write_ptr(devinfo, ring->w_idx_addr, commonring->w_ptr);
+
+	return 0;
+}
+
+static int inff_pcie_ring_mb_ring_bell(void *ctx)
+{
+	struct inff_pcie_ringbuf *ring = (struct inff_pcie_ringbuf *)ctx;
+	struct inff_pciedev_info *devinfo = ring->devinfo;
+
+	if (devinfo->state != INFFMAC_PCIE_STATE_UP)
+		return -EIO;
+
+	inff_dbg(PCIE, "RING !\n");
+	/* Any arbitrary value will do, lets use 1 */
+	inff_pcie_write_reg32(devinfo, devinfo->reginfo->h2d_mailbox_0, 1);
+
+	return 0;
+}
+
+static int inff_pcie_ring_mb_update_rptr(void *ctx)
+{
+	struct inff_pcie_ringbuf *ring = (struct inff_pcie_ringbuf *)ctx;
+	struct inff_pciedev_info *devinfo = ring->devinfo;
+	struct inff_commonring *commonring = &ring->commonring;
+
+	if (devinfo->state != INFFMAC_PCIE_STATE_UP)
+		return -EIO;
+
+	commonring->r_ptr = devinfo->read_ptr(devinfo, ring->r_idx_addr);
+
+	inff_dbg(PCIE, "R r_ptr %d (%d), ring %d\n", commonring->r_ptr,
+		 commonring->w_ptr, ring->id);
+
+	return 0;
+}
+
+static int inff_pcie_ring_mb_update_wptr(void *ctx)
+{
+	struct inff_pcie_ringbuf *ring = (struct inff_pcie_ringbuf *)ctx;
+	struct inff_pciedev_info *devinfo = ring->devinfo;
+	struct inff_commonring *commonring = &ring->commonring;
+
+	if (devinfo->state != INFFMAC_PCIE_STATE_UP)
+		return -EIO;
+
+	commonring->w_ptr = devinfo->read_ptr(devinfo, ring->w_idx_addr);
+
+	inff_dbg(PCIE, "R w_ptr %d (%d), ring %d\n", commonring->w_ptr,
+		 commonring->r_ptr, ring->id);
+
+	return 0;
+}
+
+static void *
+inff_pcie_init_dmabuffer_for_device(struct inff_pciedev_info *devinfo,
+				    u32 size, u32 tcm_dma_phys_addr,
+				    dma_addr_t *dma_handle)
+{
+	void *ring;
+	u64 address;
+
+	ring = dma_alloc_coherent(&devinfo->pdev->dev, size, dma_handle,
+				  GFP_KERNEL);
+	if (!ring)
+		return NULL;
+
+	address = (u64)*dma_handle;
+	inff_pcie_write_tcm32(devinfo, tcm_dma_phys_addr,
+			      address & 0xffffffff);
+	inff_pcie_write_tcm32(devinfo, tcm_dma_phys_addr + 4, address >> 32);
+
+	return ring;
+}
+
+static struct inff_pcie_ringbuf *
+inff_pcie_alloc_dma_and_ring(struct inff_pciedev_info *devinfo, u32 ring_id,
+			     u32 tcm_ring_phys_addr)
+{
+	struct inff_bus *bus = dev_get_drvdata(&devinfo->pdev->dev);
+	void *dma_buf;
+	dma_addr_t dma_handle;
+	struct inff_pcie_ringbuf *ring;
+	u32 size;
+	u32 addr;
+	u32 ring_max_item, ring_item_size;
+	u32 commonring_depth = bus->drvr->settings->commonring_depth[ring_id];
+
+	if (devinfo->shared.version < INFF_PCIE_SHARED_VERSION_7)
+		ring_item_size = inff_ring_itemsize_pre_v7[ring_id];
+	else
+		ring_item_size = inff_ring_itemsize[ring_id];
+
+	if (commonring_depth >= INFF_RING_MAX_ITEM_LOWER_LIMIT &&
+	    commonring_depth <= INFF_RING_MAX_ITEM_UPPER_LIMIT)
+		ring_max_item = commonring_depth;
+	else
+		ring_max_item = inff_ring_max_item[ring_id];
+
+	size = ring_max_item * ring_item_size;
+	dma_buf = inff_pcie_init_dmabuffer_for_device(devinfo, size,
+						      tcm_ring_phys_addr +
+						      INFF_RING_MEM_BASE_ADDR_OFFSET,
+						      &dma_handle);
+	if (!dma_buf)
+		return NULL;
+
+	addr = tcm_ring_phys_addr + INFF_RING_MAX_ITEM_OFFSET;
+	inff_pcie_write_tcm16(devinfo, addr, ring_max_item);
+	addr = tcm_ring_phys_addr + INFF_RING_LEN_ITEMS_OFFSET;
+	inff_pcie_write_tcm16(devinfo, addr, ring_item_size);
+
+	ring = kzalloc(sizeof(*ring), GFP_KERNEL);
+	if (!ring) {
+		dma_free_coherent(&devinfo->pdev->dev, size, dma_buf,
+				  dma_handle);
+		return NULL;
+	}
+	inff_commonring_config(&ring->commonring, ring_max_item,
+			       ring_item_size, dma_buf);
+	ring->dma_handle = dma_handle;
+	ring->devinfo = devinfo;
+	inff_commonring_register_cb(&ring->commonring,
+				    inff_pcie_ring_mb_ring_bell,
+				    inff_pcie_ring_mb_update_rptr,
+				    inff_pcie_ring_mb_update_wptr,
+				    inff_pcie_ring_mb_write_rptr,
+				    inff_pcie_ring_mb_write_wptr, ring);
+
+	return ring;
+}
+
+static void inff_pcie_release_ringbuffer(struct device *dev,
+					 struct inff_pcie_ringbuf *ring)
+{
+	void *dma_buf;
+	u32 size;
+
+	if (!ring)
+		return;
+
+	dma_buf = ring->commonring.buf_addr;
+	if (dma_buf) {
+		size = ring->commonring.depth * ring->commonring.item_len;
+		dma_free_coherent(dev, size, dma_buf, ring->dma_handle);
+	}
+	kfree(ring);
+}
+
+static void inff_pcie_release_ringbuffers(struct inff_pciedev_info *devinfo)
+{
+	u32 i;
+
+	for (i = 0; i < INFF_NROF_COMMON_MSGRINGS; i++) {
+		inff_pcie_release_ringbuffer(&devinfo->pdev->dev,
+					     devinfo->shared.commonrings[i]);
+		devinfo->shared.commonrings[i] = NULL;
+	}
+	kfree(devinfo->shared.flowrings);
+	devinfo->shared.flowrings = NULL;
+	if (devinfo->idxbuf) {
+		dma_free_coherent(&devinfo->pdev->dev,
+				  devinfo->idxbuf_sz,
+				  devinfo->idxbuf,
+				  devinfo->idxbuf_dmahandle);
+		devinfo->idxbuf = NULL;
+	}
+}
+
+static int inff_pcie_init_ringbuffers(struct inff_pciedev_info *devinfo)
+{
+	struct inff_bus *bus = dev_get_drvdata(&devinfo->pdev->dev);
+	struct inff_pcie_ringbuf *ring;
+	struct inff_pcie_ringbuf *rings;
+	u32 d2h_w_idx_ptr;
+	u32 d2h_r_idx_ptr;
+	u32 h2d_w_idx_ptr;
+	u32 h2d_r_idx_ptr;
+	u32 ring_mem_ptr;
+	u32 i;
+	u64 address;
+	u32 bufsz;
+	u8 idx_offset;
+	struct inff_pcie_dhi_ringinfo ringinfo;
+	u16 max_flowrings;
+	u16 max_submissionrings;
+	u16 max_completionrings;
+#ifdef CONFIG_INFFMAC_PCIE_BARWIN_SZ
+	inff_pcie_copy_dev_tomem(devinfo, devinfo->shared.ring_info_addr,
+				 &ringinfo, sizeof(ringinfo));
+#else
+	memcpy_fromio(&ringinfo, devinfo->tcm + devinfo->shared.ring_info_addr,
+		      sizeof(ringinfo));
+#endif /* CONFIG_INFFMAC_PCIE_BARWIN_SZ */
+
+	if (devinfo->shared.version >= 6) {
+		max_submissionrings = le16_to_cpu(ringinfo.max_submissionrings);
+		max_flowrings = le16_to_cpu(ringinfo.max_flowrings);
+		max_completionrings = le16_to_cpu(ringinfo.max_completionrings);
+	} else {
+		max_submissionrings = le16_to_cpu(ringinfo.max_flowrings);
+		max_flowrings = max_submissionrings -
+				INFF_NROF_H2D_COMMON_MSGRINGS;
+		max_completionrings = INFF_NROF_D2H_COMMON_MSGRINGS;
+	}
+	if (max_flowrings > 256) {
+		inff_err(bus, "invalid max_flowrings(%d)\n", max_flowrings);
+		return -EIO;
+	}
+
+	if (devinfo->dma_idx_sz != 0) {
+		bufsz = (max_submissionrings + max_completionrings) *
+			devinfo->dma_idx_sz * 2;
+		devinfo->idxbuf = dma_alloc_coherent(&devinfo->pdev->dev, bufsz,
+						     &devinfo->idxbuf_dmahandle,
+						     GFP_KERNEL);
+		if (!devinfo->idxbuf)
+			devinfo->dma_idx_sz = 0;
+	}
+
+	if (devinfo->dma_idx_sz == 0) {
+		d2h_w_idx_ptr = le32_to_cpu(ringinfo.d2h_w_idx_ptr);
+		d2h_r_idx_ptr = le32_to_cpu(ringinfo.d2h_r_idx_ptr);
+		h2d_w_idx_ptr = le32_to_cpu(ringinfo.h2d_w_idx_ptr);
+		h2d_r_idx_ptr = le32_to_cpu(ringinfo.h2d_r_idx_ptr);
+		idx_offset = sizeof(u32);
+		devinfo->write_ptr = inff_pcie_write_tcm16;
+		devinfo->read_ptr = inff_pcie_read_tcm16;
+		inff_dbg(PCIE, "Using TCM indices\n");
+	} else {
+		memset(devinfo->idxbuf, 0, bufsz);
+		devinfo->idxbuf_sz = bufsz;
+		idx_offset = devinfo->dma_idx_sz;
+		devinfo->write_ptr = inff_pcie_write_idx;
+		devinfo->read_ptr = inff_pcie_read_idx;
+
+		h2d_w_idx_ptr = 0;
+		address = (u64)devinfo->idxbuf_dmahandle;
+		ringinfo.h2d_w_idx_hostaddr.low_addr =
+			cpu_to_le32(address & 0xffffffff);
+		ringinfo.h2d_w_idx_hostaddr.high_addr =
+			cpu_to_le32(address >> 32);
+
+		h2d_r_idx_ptr = h2d_w_idx_ptr +
+				max_submissionrings * idx_offset;
+		address += max_submissionrings * idx_offset;
+		ringinfo.h2d_r_idx_hostaddr.low_addr =
+			cpu_to_le32(address & 0xffffffff);
+		ringinfo.h2d_r_idx_hostaddr.high_addr =
+			cpu_to_le32(address >> 32);
+
+		d2h_w_idx_ptr = h2d_r_idx_ptr +
+				max_submissionrings * idx_offset;
+		address += max_submissionrings * idx_offset;
+		ringinfo.d2h_w_idx_hostaddr.low_addr =
+			cpu_to_le32(address & 0xffffffff);
+		ringinfo.d2h_w_idx_hostaddr.high_addr =
+			cpu_to_le32(address >> 32);
+
+		d2h_r_idx_ptr = d2h_w_idx_ptr +
+				max_completionrings * idx_offset;
+		address += max_completionrings * idx_offset;
+		ringinfo.d2h_r_idx_hostaddr.low_addr =
+			cpu_to_le32(address & 0xffffffff);
+		ringinfo.d2h_r_idx_hostaddr.high_addr =
+			cpu_to_le32(address >> 32);
+
+#ifdef CONFIG_INFFMAC_PCIE_BARWIN_SZ
+		inff_pcie_copy_mem_todev(devinfo,
+					 devinfo->shared.ring_info_addr,
+					 &ringinfo, sizeof(ringinfo));
+#else
+		memcpy_toio(devinfo->tcm + devinfo->shared.ring_info_addr,
+			    &ringinfo, sizeof(ringinfo));
+#endif /* CONFIG_INFFMAC_PCIE_BARWIN_SZ */
+		inff_dbg(PCIE, "Using host memory indices\n");
+	}
+
+	ring_mem_ptr = le32_to_cpu(ringinfo.ringmem);
+
+	for (i = 0; i < INFF_NROF_H2D_COMMON_MSGRINGS; i++) {
+		ring = inff_pcie_alloc_dma_and_ring(devinfo, i, ring_mem_ptr);
+		if (!ring)
+			goto fail;
+		ring->w_idx_addr = h2d_w_idx_ptr;
+		ring->r_idx_addr = h2d_r_idx_ptr;
+		ring->id = i;
+		devinfo->shared.commonrings[i] = ring;
+
+		h2d_w_idx_ptr += idx_offset;
+		h2d_r_idx_ptr += idx_offset;
+		ring_mem_ptr += INFF_RING_MEM_SZ;
+	}
+
+	for (i = INFF_NROF_H2D_COMMON_MSGRINGS;
+	     i < INFF_NROF_COMMON_MSGRINGS; i++) {
+		ring = inff_pcie_alloc_dma_and_ring(devinfo, i, ring_mem_ptr);
+		if (!ring)
+			goto fail;
+		ring->w_idx_addr = d2h_w_idx_ptr;
+		ring->r_idx_addr = d2h_r_idx_ptr;
+		ring->id = i;
+		devinfo->shared.commonrings[i] = ring;
+
+		d2h_w_idx_ptr += idx_offset;
+		d2h_r_idx_ptr += idx_offset;
+		ring_mem_ptr += INFF_RING_MEM_SZ;
+	}
+
+	devinfo->shared.max_flowrings = max_flowrings;
+	devinfo->shared.max_submissionrings = max_submissionrings;
+	devinfo->shared.max_completionrings = max_completionrings;
+	rings = kcalloc(max_flowrings, sizeof(*ring), GFP_KERNEL);
+	if (!rings)
+		goto fail;
+
+	inff_dbg(PCIE, "Nr of flowrings is %d\n", max_flowrings);
+
+	for (i = 0; i < max_flowrings; i++) {
+		ring = &rings[i];
+		ring->devinfo = devinfo;
+		ring->id = i + INFF_H2D_MSGRING_FLOWRING_IDSTART;
+		inff_commonring_register_cb(&ring->commonring,
+					    inff_pcie_ring_mb_ring_bell,
+					     inff_pcie_ring_mb_update_rptr,
+					     inff_pcie_ring_mb_update_wptr,
+					     inff_pcie_ring_mb_write_rptr,
+					     inff_pcie_ring_mb_write_wptr,
+					     ring);
+		ring->w_idx_addr = h2d_w_idx_ptr;
+		ring->r_idx_addr = h2d_r_idx_ptr;
+		h2d_w_idx_ptr += idx_offset;
+		h2d_r_idx_ptr += idx_offset;
+	}
+	devinfo->shared.flowrings = rings;
+
+	return 0;
+
+fail:
+	inff_err(bus, "Allocating ring buffers failed\n");
+	inff_pcie_release_ringbuffers(devinfo);
+	return -ENOMEM;
+}
+
+static void
+inff_pcie_release_scratchbuffers(struct inff_pciedev_info *devinfo)
+{
+	if (devinfo->shared.scratch)
+		dma_free_coherent(&devinfo->pdev->dev,
+				  INFF_DMA_D2H_SCRATCH_BUF_LEN,
+				  devinfo->shared.scratch,
+				  devinfo->shared.scratch_dmahandle);
+	if (devinfo->shared.ringupd)
+		dma_free_coherent(&devinfo->pdev->dev,
+				  INFF_DMA_D2H_RINGUPD_BUF_LEN,
+				  devinfo->shared.ringupd,
+				  devinfo->shared.ringupd_dmahandle);
+}
+
+static int inff_pcie_init_scratchbuffers(struct inff_pciedev_info *devinfo)
+{
+	struct inff_bus *bus = dev_get_drvdata(&devinfo->pdev->dev);
+	u64 address;
+	u32 addr;
+
+	devinfo->shared.scratch =
+		dma_alloc_coherent(&devinfo->pdev->dev,
+				   INFF_DMA_D2H_SCRATCH_BUF_LEN,
+				   &devinfo->shared.scratch_dmahandle,
+				   GFP_KERNEL);
+	if (!devinfo->shared.scratch)
+		goto fail;
+
+	addr = devinfo->shared.tcm_base_address +
+	       INFF_SHARED_DMA_SCRATCH_ADDR_OFFSET;
+	address = (u64)devinfo->shared.scratch_dmahandle;
+	inff_pcie_write_tcm32(devinfo, addr, address & 0xffffffff);
+	inff_pcie_write_tcm32(devinfo, addr + 4, address >> 32);
+	addr = devinfo->shared.tcm_base_address +
+	       INFF_SHARED_DMA_SCRATCH_LEN_OFFSET;
+	inff_pcie_write_tcm32(devinfo, addr, INFF_DMA_D2H_SCRATCH_BUF_LEN);
+
+	devinfo->shared.ringupd =
+		dma_alloc_coherent(&devinfo->pdev->dev,
+				   INFF_DMA_D2H_RINGUPD_BUF_LEN,
+				   &devinfo->shared.ringupd_dmahandle,
+				   GFP_KERNEL);
+	if (!devinfo->shared.ringupd)
+		goto fail;
+
+	addr = devinfo->shared.tcm_base_address +
+	       INFF_SHARED_DMA_RINGUPD_ADDR_OFFSET;
+	address = (u64)devinfo->shared.ringupd_dmahandle;
+	inff_pcie_write_tcm32(devinfo, addr, address & 0xffffffff);
+	inff_pcie_write_tcm32(devinfo, addr + 4, address >> 32);
+	addr = devinfo->shared.tcm_base_address +
+	       INFF_SHARED_DMA_RINGUPD_LEN_OFFSET;
+	inff_pcie_write_tcm32(devinfo, addr, INFF_DMA_D2H_RINGUPD_BUF_LEN);
+	return 0;
+
+fail:
+	inff_err(bus, "Allocating scratch buffers failed\n");
+	inff_pcie_release_scratchbuffers(devinfo);
+	return -ENOMEM;
+}
+
+static void inff_pcie_down(struct device *dev)
+{
+	struct inff_bus *bus_if = dev_get_drvdata(dev);
+	struct inff_pciedev *pcie_bus_dev = bus_if->bus_priv.pcie;
+	struct inff_pciedev_info *devinfo = pcie_bus_dev->devinfo;
+
+	inff_pcie_fwcon_timer(devinfo, false);
+}
+
+static int inff_pcie_preinit(struct device *dev)
+{
+	struct inff_bus *bus_if = dev_get_drvdata(dev);
+	struct inff_pciedev *buspub = bus_if->bus_priv.pcie;
+
+	inff_dbg(PCIE, "Enter\n");
+
+	inff_pcie_intr_enable(buspub->devinfo);
+	inff_pcie_hostready(buspub->devinfo);
+
+	return 0;
+}
+
+static int inff_pcie_tx(struct device *dev, struct sk_buff *skb)
+{
+	return 0;
+}
+
+static int inff_pcie_tx_ctlpkt(struct device *dev, unsigned char *msg,
+			       uint len)
+{
+	return 0;
+}
+
+static int inff_pcie_rx_ctlpkt(struct device *dev, unsigned char *msg,
+			       uint len)
+{
+	return 0;
+}
+
+static void inff_pcie_wowl_config(struct device *dev, bool enabled)
+{
+	struct inff_bus *bus_if = dev_get_drvdata(dev);
+	struct inff_pciedev *buspub = bus_if->bus_priv.pcie;
+	struct inff_pciedev_info *devinfo = buspub->devinfo;
+
+	inff_dbg(PCIE, "Configuring WOWL, enabled=%d\n", enabled);
+	devinfo->wowl_enabled = enabled;
+}
+
+static size_t inff_pcie_get_ramsize(struct device *dev)
+{
+	struct inff_bus *bus_if = dev_get_drvdata(dev);
+	struct inff_pciedev *buspub = bus_if->bus_priv.pcie;
+	struct inff_pciedev_info *devinfo = buspub->devinfo;
+
+	return devinfo->ci->ramsize - devinfo->ci->srsize;
+}
+
+static int inff_pcie_get_memdump(struct device *dev, void *data, size_t len)
+{
+	struct inff_bus *bus_if = dev_get_drvdata(dev);
+	struct inff_pciedev *buspub = bus_if->bus_priv.pcie;
+	struct inff_pciedev_info *devinfo = buspub->devinfo;
+
+	inff_dbg(PCIE, "dump at 0x%08X: len=%zu\n", devinfo->ci->rambase, len);
+	inff_pcie_copy_dev_tomem(devinfo, devinfo->ci->rambase, data, len);
+	return 0;
+}
+
+static int inff_pcie_get_blob(struct device *dev, const struct firmware **fw,
+			      enum inff_blob_type type)
+{
+	struct inff_bus *bus_if = dev_get_drvdata(dev);
+	struct inff_pciedev *buspub = bus_if->bus_priv.pcie;
+	struct inff_pciedev_info *devinfo = buspub->devinfo;
+	struct inff_chip_specific *chip_spec = &devinfo->ci->chip_spec;
+
+	switch (type) {
+	case INFF_BLOB_CLM:
+		*fw = chip_spec->clm_fw;
+		chip_spec->clm_fw = NULL;
+		break;
+	default:
+		return -ENOENT;
+	}
+
+	if (!*fw)
+		return -ENOENT;
+
+	return 0;
+}
+
+static int inff_pcie_reset(struct device *dev)
+{
+	struct inff_bus *bus_if = dev_get_drvdata(dev);
+	struct inff_pciedev *buspub = bus_if->bus_priv.pcie;
+	struct inff_pciedev_info *devinfo = buspub->devinfo;
+	struct inff_fw_request *fwreq;
+	int err;
+
+	inff_pcie_intr_disable(devinfo);
+
+	inff_pcie_bus_console_read(devinfo, true);
+
+	inff_detach(dev);
+
+	inff_pcie_release_irq(devinfo);
+	inff_pcie_release_scratchbuffers(devinfo);
+	inff_pcie_release_ringbuffers(devinfo);
+	inff_pcie_reset_device(devinfo);
+
+	fwreq = inff_prepare_fw_request(devinfo->settings->firmware_path,
+					devinfo->ci, inff_pcie_fwnames,
+					ARRAY_SIZE(inff_pcie_fwnames),
+					devinfo->settings->board_type);
+	if (!fwreq) {
+		dev_err(dev, "Failed to prepare FW request\n");
+		return -ENOMEM;
+	}
+
+	/* NVRAM reserves PCI domain 0 for SDK faked bus */
+	fwreq->domain_nr = pci_domain_nr(devinfo->pdev->bus) + 1;
+	fwreq->bus_nr = devinfo->pdev->bus->number;
+
+	err = inff_fw_get_firmwares(dev, fwreq, inff_pcie_setup);
+	if (err) {
+		dev_err(dev, "Failed to prepare FW request\n");
+		kfree(fwreq);
+	}
+
+	return err;
+}
+
+static const struct inff_bus_ops inff_pcie_bus_ops = {
+	.preinit = inff_pcie_preinit,
+	.txdata = inff_pcie_tx,
+	.stop = inff_pcie_down,
+	.txctl = inff_pcie_tx_ctlpkt,
+	.rxctl = inff_pcie_rx_ctlpkt,
+	.wowl_config = inff_pcie_wowl_config,
+	.get_ramsize = inff_pcie_get_ramsize,
+	.get_memdump = inff_pcie_get_memdump,
+	.get_blob = inff_pcie_get_blob,
+	.reset = inff_pcie_reset,
+	.debugfs_create = inff_pcie_debugfs_create,
+	.interrupt_enable = inff_pcie_interrupt_enable,
+	.interrupt_disable = inff_pcie_interrupt_disable,
+};
+
+static void
+inff_pcie_adjust_ramsize(struct inff_pciedev_info *devinfo, u8 *data,
+			 u32 data_len)
+{
+	__le32 *field;
+	u32 newsize;
+
+	if (data_len < INFF_RAMSIZE_OFFSET + 8)
+		return;
+
+	field = (__le32 *)&data[INFF_RAMSIZE_OFFSET];
+	if (le32_to_cpup(field) != INFF_RAMSIZE_MAGIC)
+		return;
+	field++;
+	newsize = le32_to_cpup(field);
+
+	inff_dbg(PCIE, "Found ramsize info in FW, adjusting to 0x%x\n",
+		 newsize);
+	devinfo->ci->ramsize = newsize;
+}
+
+static void
+inff_pcie_write_rand(struct inff_pciedev_info *devinfo, u32 nvram_csm)
+{
+	struct inff_rand_metadata rand_data;
+	u8 rand_buf[INFF_ENTROPY_HOST_LEN];
+	u32 count = INFF_ENTROPY_HOST_LEN;
+	u32 address;
+
+	address = devinfo->ci->rambase +
+		  (devinfo->ci->ramsize - INFF_NVRAM_OFFSET_TCM) -
+		  ((nvram_csm & 0xffff) * INFF_NVRAM_COMPRS_FACTOR) -
+		  sizeof(rand_data);
+	memset(rand_buf, 0, INFF_ENTROPY_HOST_LEN);
+	rand_data.signature = cpu_to_le32(INFF_NVRAM_RNG_SIGNATURE);
+	rand_data.count = cpu_to_le32(count);
+	inff_pcie_copy_mem_todev(devinfo, address, &rand_data,
+				 sizeof(rand_data));
+	address -= count;
+	get_random_bytes(rand_buf, count);
+	inff_pcie_copy_mem_todev(devinfo, address, rand_buf, count);
+}
+
+static int
+inff_pcie_init_share_ram_info(struct inff_pciedev_info *devinfo,
+			      u32 sharedram_addr)
+{
+	struct inff_bus *bus = dev_get_drvdata(&devinfo->pdev->dev);
+	struct inff_pcie_shared_info *shared;
+	u32 addr;
+	u32 host_cap;
+
+	shared = &devinfo->shared;
+	shared->tcm_base_address = sharedram_addr;
+
+	shared->flags = inff_pcie_read_tcm32(devinfo, sharedram_addr);
+	shared->version = (u8)(shared->flags & INFF_PCIE_SHARED_VERSION_MASK);
+	inff_dbg(PCIE, "PCIe protocol version %d\n", shared->version);
+	if (shared->version > INFF_PCIE_MAX_SHARED_VERSION ||
+	    shared->version < INFF_PCIE_MIN_SHARED_VERSION) {
+		inff_err(bus, "Unsupported PCIE version %d\n",
+			 shared->version);
+		return -EINVAL;
+	}
+
+	/* check firmware support dma indicies */
+	if (shared->flags & INFF_PCIE_SHARED_DMA_INDEX) {
+		if (shared->flags & INFF_PCIE_SHARED_DMA_2B_IDX)
+			devinfo->dma_idx_sz = sizeof(u16);
+		else
+			devinfo->dma_idx_sz = sizeof(u32);
+	}
+
+	addr = sharedram_addr + INFF_SHARED_MAX_RXBUFPOST_OFFSET;
+	shared->max_rxbufpost = inff_pcie_read_tcm16(devinfo, addr);
+	if (shared->max_rxbufpost == 0)
+		shared->max_rxbufpost = INFF_DEF_MAX_RXBUFPOST;
+
+	addr = sharedram_addr + INFF_SHARED_RX_DATAOFFSET_OFFSET;
+	shared->rx_dataoffset = inff_pcie_read_tcm32(devinfo, addr);
+
+	addr = sharedram_addr + INFF_SHARED_HTOD_MB_DATA_ADDR_OFFSET;
+	shared->htod_mb_data_addr = inff_pcie_read_tcm32(devinfo, addr);
+
+	addr = sharedram_addr + INFF_SHARED_DTOH_MB_DATA_ADDR_OFFSET;
+	shared->dtoh_mb_data_addr = inff_pcie_read_tcm32(devinfo, addr);
+
+	addr = sharedram_addr + INFF_SHARED_RING_INFO_ADDR_OFFSET;
+	shared->ring_info_addr = inff_pcie_read_tcm32(devinfo, addr);
+
+	if (shared->version >= INFF_PCIE_SHARED_VERSION_6) {
+		host_cap = shared->version;
+
+		/* Disable OOB Device Wake based DeepSleep State Machine */
+		host_cap |= INFF_HOSTCAP_DS_NO_OOB_DW;
+
+		devinfo->hostready =
+			((shared->flags & INFF_PCIE_SHARED_HOSTRDY_DB1)
+			 == INFF_PCIE_SHARED_HOSTRDY_DB1);
+		if (devinfo->hostready) {
+			inff_dbg(PCIE, "HostReady supported by dongle.\n");
+			host_cap |= INFF_HOSTCAP_H2D_ENABLE_HOSTRDY;
+		}
+		devinfo->use_mailbox =
+			((shared->flags & INFF_PCIE_SHARED_USE_MAILBOX)
+			 == INFF_PCIE_SHARED_USE_MAILBOX);
+		devinfo->use_d0_inform = false;
+		addr = sharedram_addr + INFF_SHARED_HOST_CAP_OFFSET;
+
+		inff_pcie_write_tcm32(devinfo, addr, host_cap);
+	} else {
+		devinfo->use_d0_inform = true;
+	}
+
+	inff_dbg(PCIE, "max rx buf post %d, rx dataoffset %d\n",
+		 shared->max_rxbufpost, shared->rx_dataoffset);
+
+	inff_pcie_bus_console_init(devinfo);
+	inff_pcie_bus_console_read(devinfo, false);
+
+	return 0;
+}
+
+static int inff_pcie_download_fw_nvram(struct inff_pciedev_info *devinfo,
+				       const struct firmware *fw, void *nvram,
+				       u32 nvram_len)
+{
+	struct inff_bus *bus = dev_get_drvdata(&devinfo->pdev->dev);
+	struct trx_header_le *trx = (struct trx_header_le *)fw->data;
+	u32 fw_size;
+	u32 sharedram_addr;
+	u32 sharedram_addr_written;
+	u32 loop_counter;
+	int err;
+	u32 address;
+	u32 resetintr;
+	u32 nvram_lenw;
+	u32 nvram_csm;
+	struct inff_chip_specific *chip_spec = &devinfo->ci->chip_spec;
+	struct inff_fw_dataset *fw_data = &chip_spec->fwdata[0];
+
+	inff_dbg(PCIE, "Halt ARM.\n");
+	err = inff_pcie_enter_download_state(devinfo);
+	if (err)
+		return err;
+
+	inff_dbg(PCIE, "Download FW %s\n", fw_data[INFF_FW_CODE].fwnames.path);
+	address = devinfo->ci->rambase;
+	fw_size = fw->size;
+	if (trx->magic == cpu_to_le32(TRX_MAGIC)) {
+		address -= sizeof(struct trx_header_le);
+		fw_size = le32_to_cpu(trx->len);
+	}
+	inff_pcie_copy_mem_todev(devinfo, address, (void *)fw->data, fw_size);
+
+	resetintr = get_unaligned_le32(fw->data);
+	release_firmware(fw);
+
+	inff_pcie_bus_console_read(devinfo, false);
+	err = devinfo->ci->blhs->post_fwdl(devinfo->ci);
+	if (err) {
+		inff_err(bus, "FW download failed, err=%d\n", err);
+		return err;
+	}
+
+	err = devinfo->ci->blhs->chk_validation(devinfo->ci);
+	if (err) {
+		inff_err(bus, "FW valication failed, err=%d\n", err);
+		return err;
+	}
+
+	if (nvram) {
+		inff_dbg(PCIE, "Download NVRAM %s\n", fw_data[INFF_FW_NVRAM].fwnames.path);
+		address = devinfo->ci->rambase + devinfo->ci->ramsize -
+			  nvram_len;
+
+		address -= 4;
+		inff_pcie_copy_mem_todev(devinfo, address, nvram, nvram_len);
+
+		/* Convert nvram_len to words to determine the length token */
+		nvram_lenw = nvram_len / 4;
+		nvram_csm = (~nvram_lenw << 16) | (nvram_lenw & 0x0000FFFF);
+		inff_fw_nvram_free(nvram);
+	} else {
+		nvram_csm = 0;
+		inff_dbg(PCIE, "No matching NVRAM file found %s\n",
+			 fw_data[INFF_FW_NVRAM].fwnames.path);
+	}
+
+	if (devinfo->ci->chip == INF_CC_5557X_CHIP_ID) {
+		/* Write the length token to the last word of RAM address */
+		inff_pcie_write_ram32(devinfo, devinfo->ci->ramsize - 4,
+				      cpu_to_le32(nvram_csm));
+
+		/* Write random numbers to TCM for randomizing heap address */
+		inff_pcie_write_rand(devinfo, nvram_csm);
+	}
+
+	sharedram_addr_written = inff_pcie_read_ram32(devinfo,
+						      devinfo->ci->ramsize -
+						      4);
+	inff_dbg(PCIE, "Bring ARM in running state\n");
+	err = inff_pcie_exit_download_state(devinfo, resetintr);
+	if (err)
+		return err;
+
+	if (!inff_pcie_bus_readshared(devinfo, nvram_csm))
+		inff_pcie_bus_console_read(devinfo, false);
+
+	inff_dbg(PCIE, "Wait for FW init\n");
+	sharedram_addr = sharedram_addr_written;
+	loop_counter = INFF_PCIE_FW_UP_TIMEOUT / 50;
+	while ((sharedram_addr == sharedram_addr_written) && (loop_counter)) {
+		msleep(50);
+		sharedram_addr = inff_pcie_read_ram32(devinfo,
+						      devinfo->ci->ramsize -
+						       4);
+		loop_counter--;
+	}
+	if (sharedram_addr == sharedram_addr_written) {
+		inff_err(bus, "FW failed to initialize\n");
+		return -ENODEV;
+	}
+	if (sharedram_addr < devinfo->ci->rambase ||
+	    sharedram_addr >= devinfo->ci->rambase + devinfo->ci->ramsize) {
+		inff_err(bus, "Invalid shared RAM address 0x%08x\n",
+			 sharedram_addr);
+		return -ENODEV;
+	}
+	inff_dbg(PCIE, "Shared RAM addr: 0x%08x\n", sharedram_addr);
+
+	return inff_pcie_init_share_ram_info(devinfo, sharedram_addr);
+}
+
+static int inff_pcie_get_resource(struct inff_pciedev_info *devinfo)
+{
+	struct pci_dev *pdev = devinfo->pdev;
+	struct inff_bus *bus = dev_get_drvdata(&pdev->dev);
+	int err;
+	phys_addr_t  bar0_addr, bar1_addr;
+	ulong bar1_size;
+
+	err = pci_enable_device(pdev);
+	if (err) {
+		inff_err(bus, "pci_enable_device failed err=%d\n", err);
+		return err;
+	}
+
+	pci_set_master(pdev);
+
+	/* Bar-0 mapped address */
+	bar0_addr = pci_resource_start(pdev, 0);
+	/* Bar-1 mapped address */
+	bar1_addr = pci_resource_start(pdev, 2);
+	/* read Bar-1 mapped memory range */
+	bar1_size = pci_resource_len(pdev, 2);
+	if (bar1_size == 0 || bar1_addr == 0) {
+		inff_err(bus, "BAR1 Not enabled, device size=%ld, addr=%#016llx\n",
+			 bar1_size, (unsigned long long)bar1_addr);
+		return -EINVAL;
+	}
+
+	devinfo->regs = ioremap(bar0_addr, INFF_PCIE_REG_MAP_SIZE);
+	devinfo->tcm = ioremap(bar1_addr, bar1_size);
+	devinfo->bar1_size = bar1_size;
+
+	if (!devinfo->regs || !devinfo->tcm) {
+		inff_err(bus, "ioremap() failed (%p,%p)\n", devinfo->regs,
+			 devinfo->tcm);
+		return -EINVAL;
+	}
+	inff_dbg(PCIE, "Phys addr : reg space = %p base addr %#016llx\n",
+		 devinfo->regs, (unsigned long long)bar0_addr);
+	inff_dbg(PCIE, "Phys addr : mem space = %p base addr %#016llx size 0x%x\n",
+		 devinfo->tcm, (unsigned long long)bar1_addr,
+		 (unsigned int)bar1_size);
+
+	return 0;
+}
+
+static void inff_pcie_release_resource(struct inff_pciedev_info *devinfo)
+{
+	if (devinfo->tcm)
+		iounmap(devinfo->tcm);
+	if (devinfo->regs)
+		iounmap(devinfo->regs);
+
+	pci_disable_device(devinfo->pdev);
+}
+
+static u32 inff_pcie_buscore_blhs_read(void *ctx, u32 reg_offset)
+{
+	struct inff_pciedev_info *devinfo = (struct inff_pciedev_info *)ctx;
+
+	inff_pcie_select_core(devinfo, INF_CORE_PCIE2);
+	return inff_pcie_read_reg32(devinfo, reg_offset);
+}
+
+static void inff_pcie_buscore_blhs_write(void *ctx, u32 reg_offset, u32 value)
+{
+	struct inff_pciedev_info *devinfo = (struct inff_pciedev_info *)ctx;
+
+	inff_pcie_select_core(devinfo, INF_CORE_PCIE2);
+	inff_pcie_write_reg32(devinfo, reg_offset, value);
+}
+
+static u32 inff_pcie_buscore_prep_addr(const struct pci_dev *pdev, u32 addr)
+{
+	u32 ret_addr;
+
+	ret_addr = addr & (INFF_PCIE_BAR0_REG_SIZE - 1);
+	addr &= ~(INFF_PCIE_BAR0_REG_SIZE - 1);
+	pci_write_config_dword(pdev, INFF_PCIE_BAR0_WINDOW, addr);
+
+	return ret_addr;
+}
+
+static u32 inff_pcie_buscore_read32(void *ctx, u32 addr)
+{
+	struct inff_pciedev_info *devinfo = (struct inff_pciedev_info *)ctx;
+
+	addr = inff_pcie_buscore_prep_addr(devinfo->pdev, addr);
+	return inff_pcie_read_reg32(devinfo, addr);
+}
+
+static void inff_pcie_buscore_write32(void *ctx, u32 addr, u32 value)
+{
+	struct inff_pciedev_info *devinfo = (struct inff_pciedev_info *)ctx;
+
+	addr = inff_pcie_buscore_prep_addr(devinfo->pdev, addr);
+	inff_pcie_write_reg32(devinfo, addr, value);
+}
+
+static int inff_pcie_buscoreprep(void *ctx)
+{
+	return inff_pcie_get_resource(ctx);
+}
+
+static int inff_pcie_buscore_reset(void *ctx, struct inff_chip *chip)
+{
+	struct inff_pciedev_info *devinfo = (struct inff_pciedev_info *)ctx;
+	struct inff_core *core;
+	u32 val, reg;
+
+	devinfo->ci = chip;
+	inff_pcie_reset_device(devinfo);
+
+	/* reginfo is not ready yet */
+	core = inff_chip_get_core(chip, INF_CORE_PCIE2);
+	if (core->rev >= 64)
+		reg = INFF_PCIE_64_PCIE2REG_MAILBOXINT;
+	else
+		reg = INFF_PCIE_PCIE2REG_MAILBOXINT;
+
+	val = inff_pcie_read_reg32(devinfo, reg);
+	if (val != 0xffffffff)
+		inff_pcie_write_reg32(devinfo, reg, val);
+
+	return 0;
+}
+
+static void inff_pcie_buscore_activate(void *ctx, struct inff_chip *chip,
+				       u32 rstvec)
+{
+	struct inff_pciedev_info *devinfo = (struct inff_pciedev_info *)ctx;
+
+	inff_pcie_write_tcm32(devinfo, 0, rstvec);
+}
+
+static int
+inff_pcie_buscore_sec_attach(void *ctx, struct inff_blhs **blhs, struct inff_ccsec **ccsec,
+			     u32 flag, uint timeout, uint interval)
+{
+	struct inff_pciedev_info *devinfo = (struct inff_pciedev_info *)ctx;
+	struct inff_bus *bus = dev_get_drvdata(&devinfo->pdev->dev);
+	struct inff_blhs *blhsh;
+	u32 regdata;
+	u32 pcie_enum;
+	u32 addr;
+
+	if (devinfo->pdev->vendor != INF_PCIE_VENDOR_ID_CYPRESS)
+		return 0;
+
+	pci_read_config_dword(devinfo->pdev, INFF_PCIE_CFGREG_REVID, &regdata);
+	if (regdata & INFF_PCIE_CFGREG_REVID_SECURE_MODE) {
+		blhsh = kzalloc(sizeof(*blhsh), GFP_KERNEL);
+		if (!blhsh)
+			return -ENOMEM;
+
+		blhsh->d2h = INFF_PCIE_PCIE2REG_DAR_D2H_MSG_0;
+		blhsh->h2d = INFF_PCIE_PCIE2REG_DAR_H2D_MSG_0;
+		blhsh->read = inff_pcie_buscore_blhs_read;
+		blhsh->write = inff_pcie_buscore_blhs_write;
+
+		/* Host indication for bootloarder to start the init */
+		if (devinfo->pdev->device == INF_PCIE_5557X_DEVICE_ID)
+			pcie_enum = INFF_CYW55572_PCIE_BAR0_PCIE_ENUM_OFFSET;
+		else
+			pcie_enum = INFF_PCIE_BAR0_PCIE_ENUM_OFFSET;
+
+		pci_read_config_dword(devinfo->pdev, PCI_BASE_ADDRESS_0,
+				      &regdata);
+		addr = regdata + pcie_enum + blhsh->h2d;
+		inff_pcie_buscore_write32(ctx, addr, 0);
+
+		addr = regdata + pcie_enum + blhsh->d2h;
+		SPINWAIT_MS((inff_pcie_buscore_read32(ctx, addr) & flag) == 0,
+			    timeout, interval);
+		regdata = inff_pcie_buscore_read32(ctx, addr);
+		if (!(regdata & flag)) {
+			inff_err(bus, "Timeout waiting for bootloader ready\n");
+			kfree(blhsh);
+			return -EPERM;
+		}
+		*blhs = blhsh;
+	}
+
+	return 0;
+}
+
+static const struct inff_buscore_ops inff_pcie_buscore_ops = {
+	.prepare = inff_pcie_buscoreprep,
+	.reset = inff_pcie_buscore_reset,
+	.activate = inff_pcie_buscore_activate,
+	.read32 = inff_pcie_buscore_read32,
+	.write32 = inff_pcie_buscore_write32,
+	.sec_attach = inff_pcie_buscore_sec_attach,
+};
+
+#define INFF_PCIE_FW_CODE	0
+#define INFF_PCIE_FW_NVRAM	1
+#define INFF_PCIE_FW_CLM	2
+
+static void inff_pcie_setup(struct device *dev, int ret,
+			    struct inff_fw_request *fwreq)
+{
+	const struct firmware *fw;
+	void *nvram;
+	struct inff_bus *bus;
+	struct inff_pciedev *pcie_bus_dev;
+	struct inff_pciedev_info *devinfo;
+	struct inff_commonring **flowrings;
+	struct inff_chip_specific *chip_spec;
+	u32 i, nvram_len;
+
+	bus = dev_get_drvdata(dev);
+	pcie_bus_dev = bus->bus_priv.pcie;
+	devinfo = pcie_bus_dev->devinfo;
+	chip_spec = &devinfo->ci->chip_spec;
+
+	/* check firmware loading result */
+	if (ret)
+		goto fail;
+
+	inff_pcie_attach(devinfo);
+
+	fw = fwreq->items[INFF_PCIE_FW_CODE].binary;
+	nvram = fwreq->items[INFF_PCIE_FW_NVRAM].nv_data.data;
+	nvram_len = fwreq->items[INFF_PCIE_FW_NVRAM].nv_data.len;
+	chip_spec->clm_fw = fwreq->items[INFF_PCIE_FW_CLM].binary;
+	kfree(fwreq);
+
+	ret = inff_chip_get_raminfo(devinfo->ci);
+	if (ret) {
+		inff_err(bus, "Failed to get RAM info\n");
+		release_firmware(fw);
+		inff_fw_nvram_free(nvram);
+		goto fail;
+	}
+
+	/* Some of the firmwares have the size of the memory of the device
+	 * defined inside the firmware. This is because part of the memory in
+	 * the device is shared and the division is determined by FW. Parse
+	 * the firmware and adjust the chip memory size now.
+	 */
+	inff_pcie_adjust_ramsize(devinfo, (u8 *)fw->data, fw->size);
+
+	ret = inff_pcie_download_fw_nvram(devinfo, fw, nvram, nvram_len);
+	if (ret) {
+		if (!inff_pcie_bus_readshared(devinfo, 0))
+			inff_pcie_bus_console_read(devinfo, true);
+		goto fail;
+	}
+
+	devinfo->state = INFFMAC_PCIE_STATE_UP;
+
+	ret = inff_pcie_init_ringbuffers(devinfo);
+	if (ret)
+		goto fail;
+
+	ret = inff_pcie_init_scratchbuffers(devinfo);
+	if (ret)
+		goto fail;
+
+	inff_pcie_select_core(devinfo, INF_CORE_PCIE2);
+	ret = inff_pcie_request_irq(devinfo);
+	if (ret)
+		goto fail;
+
+	/* hook the commonrings in the bus structure. */
+	for (i = 0; i < INFF_NROF_COMMON_MSGRINGS; i++)
+		bus->msgbuf->commonrings[i] =
+				&devinfo->shared.commonrings[i]->commonring;
+
+	flowrings = kcalloc(devinfo->shared.max_flowrings, sizeof(*flowrings),
+			    GFP_KERNEL);
+	if (!flowrings)
+		goto fail;
+
+	for (i = 0; i < devinfo->shared.max_flowrings; i++)
+		flowrings[i] = &devinfo->shared.flowrings[i].commonring;
+	bus->msgbuf->flowrings = flowrings;
+
+	bus->msgbuf->rx_dataoffset = devinfo->shared.rx_dataoffset;
+	bus->msgbuf->max_rxbufpost = devinfo->shared.max_rxbufpost;
+	bus->msgbuf->max_flowrings = devinfo->shared.max_flowrings;
+
+	init_waitqueue_head(&devinfo->mbdata_resp_wait);
+
+	ret = inff_attach(&devinfo->pdev->dev, true);
+	if (ret)
+		goto fail;
+
+	inff_pcie_bus_console_read(devinfo, false);
+
+	inff_pcie_fwcon_timer(devinfo, true);
+
+	return;
+
+fail:
+	inff_err(bus, "Dongle setup failed\n");
+	inff_pcie_bus_console_read(devinfo, true);
+	inff_fw_crashed(dev);
+	device_release_driver(dev);
+}
+
+#ifdef DEBUG
+static void
+inff_pcie_fwcon_timer(struct inff_pciedev_info *devinfo, bool active)
+{
+	if (!active) {
+		if (devinfo->console_active) {
+			timer_delete_sync(&devinfo->timer);
+			devinfo->console_active = false;
+		}
+		return;
+	}
+
+	/* don't start the timer */
+	if (devinfo->state != INFFMAC_PCIE_STATE_UP ||
+	    !devinfo->console_interval || !INFF_FWCON_ON())
+		return;
+
+	if (!devinfo->console_active) {
+		devinfo->timer.expires = jiffies + devinfo->console_interval;
+		add_timer(&devinfo->timer);
+		devinfo->console_active = true;
+	} else {
+		/* Reschedule the timer */
+		mod_timer(&devinfo->timer, jiffies + devinfo->console_interval);
+	}
+}
+
+static void
+inff_pcie_fwcon(struct timer_list *t)
+{
+	struct inff_pciedev_info *devinfo = timer_container_of(devinfo, t,
+							       timer);
+
+	if (!devinfo->console_active)
+		return;
+
+	inff_pcie_bus_console_read(devinfo, false);
+
+	/* Reschedule the timer if console interval is not zero */
+	mod_timer(&devinfo->timer, jiffies + devinfo->console_interval);
+}
+
+static int inff_pcie_console_interval_get(void *data, u64 *val)
+{
+	struct inff_pciedev_info *devinfo = data;
+
+	*val = devinfo->console_interval;
+
+	return 0;
+}
+
+static int inff_pcie_console_interval_set(void *data, u64 val)
+{
+	struct inff_pciedev_info *devinfo = data;
+
+	if (val > MAX_CONSOLE_INTERVAL)
+		return -EINVAL;
+
+	devinfo->console_interval = val;
+
+	if (!val && devinfo->console_active)
+		inff_pcie_fwcon_timer(devinfo, false);
+	else if (val)
+		inff_pcie_fwcon_timer(devinfo, true);
+
+	return 0;
+}
+
+DEFINE_SIMPLE_ATTRIBUTE(inff_pcie_console_interval_fops,
+			inff_pcie_console_interval_get,
+			inff_pcie_console_interval_set,
+			"%llu\n");
+
+static void inff_pcie_debugfs_create(struct device *dev)
+{
+	struct inff_bus *bus_if = dev_get_drvdata(dev);
+	struct inff_pub *drvr = bus_if->drvr;
+	struct inff_pciedev *pcie_bus_dev = bus_if->bus_priv.pcie;
+	struct inff_pciedev_info *devinfo = pcie_bus_dev->devinfo;
+	struct dentry *dentry = inff_debugfs_get_devdir(drvr);
+
+	if (IS_ERR_OR_NULL(dentry))
+		return;
+
+	devinfo->console_interval = INFF_CONSOLE;
+
+	debugfs_create_file("console_interval", 0644, dentry, devinfo,
+			    &inff_pcie_console_interval_fops);
+}
+
+#else
+void inff_pcie_fwcon_timer(struct inff_pciedev_info *devinfo, bool active)
+{
+}
+
+static void inff_pcie_debugfs_create(struct device *dev)
+{
+}
+#endif
+
+/* Forward declaration for pci_match_id() call */
+static const struct pci_device_id inff_pcie_devid_table[];
+
+static int
+inff_pcie_probe(struct pci_dev *pdev, const struct pci_device_id *id)
+{
+	int ret;
+	struct inff_fw_request *fwreq;
+	struct inff_pciedev_info *devinfo;
+	struct inff_pciedev *pcie_bus_dev;
+	struct inff_core *core;
+	struct inff_bus *bus;
+
+	if (!id) {
+		id = pci_match_id(inff_pcie_devid_table, pdev);
+		if (!id) {
+			pci_err(pdev, "Error could not find pci_device_id for %x:%x\n",
+				pdev->vendor, pdev->device);
+			return -ENODEV;
+		}
+	}
+
+	inff_dbg(PCIE, "Enter %x:%x\n", pdev->vendor, pdev->device);
+
+	ret = -ENOMEM;
+	devinfo = kzalloc(sizeof(*devinfo), GFP_KERNEL);
+	if (!devinfo)
+		return ret;
+
+	devinfo->pdev = pdev;
+	pcie_bus_dev = NULL;
+	devinfo->ci = inff_chip_attach(devinfo, pdev->device,
+				       &inff_pcie_buscore_ops);
+	if (IS_ERR(devinfo->ci)) {
+		ret = PTR_ERR(devinfo->ci);
+		devinfo->ci = NULL;
+		goto fail;
+	}
+
+	core = inff_chip_get_core(devinfo->ci, INF_CORE_PCIE2);
+	if (core->rev >= 64)
+		devinfo->reginfo = &inff_reginfo_64;
+	else
+		devinfo->reginfo = &inff_reginfo_default;
+
+	pcie_bus_dev = kzalloc(sizeof(*pcie_bus_dev), GFP_KERNEL);
+	if (!pcie_bus_dev) {
+		ret = -ENOMEM;
+		goto fail;
+	}
+
+	devinfo->settings = inff_get_module_param(&devinfo->pdev->dev,
+						  INFF_BUSTYPE_PCIE,
+						  devinfo->ci->chip,
+						  devinfo->ci->chiprev);
+	if (!devinfo->settings) {
+		ret = -ENOMEM;
+		goto fail;
+	}
+	ret = PTR_ERR_OR_ZERO(devinfo->settings);
+	if (ret < 0)
+		goto fail;
+
+	bus = kzalloc(sizeof(*bus), GFP_KERNEL);
+	if (!bus) {
+		ret = -ENOMEM;
+		goto fail;
+	}
+	bus->msgbuf = kzalloc(sizeof(*bus->msgbuf), GFP_KERNEL);
+	if (!bus->msgbuf) {
+		ret = -ENOMEM;
+		kfree(bus);
+		goto fail;
+	}
+
+	/* hook it all together. */
+	pcie_bus_dev->devinfo = devinfo;
+	pcie_bus_dev->bus = bus;
+	bus->dev = &pdev->dev;
+	bus->bus_priv.pcie = pcie_bus_dev;
+	bus->ops = &inff_pcie_bus_ops;
+	bus->proto_type = INFF_PROTO_MSGBUF;
+	bus->chip = devinfo->coreid;
+	bus->chip_pub = devinfo->ci;
+	bus->wowl_supported = pci_pme_capable(pdev, PCI_D3hot);
+	dev_set_drvdata(&pdev->dev, bus);
+
+	ret = inff_alloc(&devinfo->pdev->dev, devinfo->settings);
+	if (ret)
+		goto fail_bus;
+
+#ifdef DEBUG
+	/* Set up the fwcon timer */
+	timer_setup(&devinfo->timer, inff_pcie_fwcon, 0);
+#endif
+
+	fwreq = inff_prepare_fw_request(devinfo->settings->firmware_path,
+					devinfo->ci, inff_pcie_fwnames,
+					ARRAY_SIZE(inff_pcie_fwnames),
+					devinfo->settings->board_type);
+	if (!fwreq) {
+		ret = -ENOMEM;
+		goto fail_inff;
+	}
+
+	/* NVRAM reserves PCI domain 0 for SDK faked bus */
+	fwreq->domain_nr = pci_domain_nr(devinfo->pdev->bus) + 1;
+	fwreq->bus_nr = devinfo->pdev->bus->number;
+
+	ret = inff_fw_get_firmwares(bus->dev, fwreq, inff_pcie_setup);
+	if (ret < 0) {
+		kfree(fwreq);
+		goto fail_inff;
+	}
+	return 0;
+
+fail_inff:
+	inff_free(&devinfo->pdev->dev);
+fail_bus:
+	kfree(bus->msgbuf);
+	kfree(bus);
+fail:
+	inff_err(NULL, "failed %x:%x\n", pdev->vendor, pdev->device);
+	inff_pcie_release_resource(devinfo);
+	if (devinfo->ci)
+		inff_chip_detach(devinfo->ci);
+	if (devinfo->settings)
+		inff_release_module_param(devinfo->settings);
+	kfree(pcie_bus_dev);
+	kfree(devinfo);
+	return ret;
+}
+
+static void
+inff_pcie_remove(struct pci_dev *pdev)
+{
+	struct inff_pciedev_info *devinfo;
+	struct inff_chip_specific *chip_spec;
+	struct inff_bus *bus;
+
+	inff_dbg(PCIE, "Enter\n");
+
+	bus = dev_get_drvdata(&pdev->dev);
+	if (!bus)
+		return;
+
+	devinfo = bus->bus_priv.pcie->devinfo;
+	chip_spec = &devinfo->ci->chip_spec;
+
+	inff_pcie_bus_console_read(devinfo, false);
+	inff_pcie_fwcon_timer(devinfo, false);
+
+	devinfo->state = INFFMAC_PCIE_STATE_DOWN;
+	if (devinfo->ci)
+		inff_pcie_intr_disable(devinfo);
+
+	inff_detach(&pdev->dev);
+	inff_free(&pdev->dev);
+
+	kfree(bus->bus_priv.pcie);
+	kfree(bus->msgbuf->flowrings);
+	kfree(bus->msgbuf);
+	kfree(bus);
+
+	inff_pcie_release_irq(devinfo);
+	inff_pcie_release_scratchbuffers(devinfo);
+	inff_pcie_release_ringbuffers(devinfo);
+	inff_pcie_reset_device(devinfo);
+	inff_pcie_release_resource(devinfo);
+	release_firmware(chip_spec->clm_fw);
+
+	if (devinfo->ci)
+		inff_chip_detach(devinfo->ci);
+	if (devinfo->settings)
+		inff_release_module_param(devinfo->settings);
+
+	kfree(devinfo);
+	dev_set_drvdata(&pdev->dev, NULL);
+}
+
+#ifdef CONFIG_PM
+
+static int inff_pcie_pm_enter_D3(struct device *dev)
+{
+	struct inff_pciedev_info *devinfo;
+	struct inff_bus *bus;
+	struct inff_cfg80211_info *config;
+	int retry = INFF_PM_WAIT_MAXRETRY;
+
+	inff_dbg(PCIE, "Enter\n");
+
+	bus = dev_get_drvdata(dev);
+	devinfo = bus->bus_priv.pcie->devinfo;
+	config = bus->drvr->config;
+
+	while (retry &&
+	       config->pm_state == INFF_CFG80211_PM_STATE_SUSPENDING) {
+		usleep_range(10000, 20000);
+		retry--;
+	}
+	if (!retry && config->pm_state == INFF_CFG80211_PM_STATE_SUSPENDING)
+		inff_err(bus, "timed out wait for cfg80211 suspended\n");
+
+	inff_pcie_fwcon_timer(devinfo, false);
+	inff_bus_change_state(bus, INFF_BUS_DOWN);
+
+	devinfo->mbdata_completed = false;
+	inff_pcie_send_mb_data(devinfo, INFF_H2D_HOST_D3_INFORM);
+
+	wait_event_timeout(devinfo->mbdata_resp_wait, devinfo->mbdata_completed,
+			   INFF_PCIE_MBDATA_TIMEOUT);
+	if (!devinfo->mbdata_completed) {
+		inff_err(bus, "Timeout on response for entering D3 substate\n");
+		inff_bus_change_state(bus, INFF_BUS_UP);
+		return -EIO;
+	}
+
+	devinfo->state = INFFMAC_PCIE_STATE_DOWN;
+
+	return 0;
+}
+
+static int inff_pcie_pm_leave_D3(struct device *dev)
+{
+	struct inff_pciedev_info *devinfo;
+	struct inff_bus *bus;
+	struct pci_dev *pdev;
+	int err;
+
+	inff_dbg(PCIE, "Enter\n");
+
+	bus = dev_get_drvdata(dev);
+	devinfo = bus->bus_priv.pcie->devinfo;
+	inff_dbg(PCIE, "Enter, dev=%p, bus=%p\n", dev, bus);
+
+	/* Check if device is still up and running, if so we are ready */
+	if (inff_pcie_read_reg32(devinfo, devinfo->reginfo->intmask) != 0) {
+		inff_dbg(PCIE, "Try to wakeup device....\n");
+		if (devinfo->use_d0_inform) {
+			if (inff_pcie_send_mb_data(devinfo,
+						   INFF_H2D_HOST_D0_INFORM))
+				goto cleanup;
+		} else {
+			inff_pcie_hostready(devinfo);
+		}
+
+		inff_dbg(PCIE, "Hot resume, continue....\n");
+		devinfo->state = INFFMAC_PCIE_STATE_UP;
+		inff_pcie_select_core(devinfo, INF_CORE_PCIE2);
+		inff_bus_change_state(bus, INFF_BUS_UP);
+		inff_pcie_intr_enable(devinfo);
+		if (devinfo->use_d0_inform) {
+			inff_dbg(TRACE, "sending inff_pcie_hostready since use_d0_inform=%d\n",
+				 devinfo->use_d0_inform);
+			inff_pcie_hostready(devinfo);
+		}
+
+		inff_pcie_fwcon_timer(devinfo, true);
+		return 0;
+	}
+
+cleanup:
+	inff_chip_detach(devinfo->ci);
+	devinfo->ci = NULL;
+	pdev = devinfo->pdev;
+	inff_pcie_remove(pdev);
+
+	err = inff_pcie_probe(pdev, NULL);
+	if (err)
+		__inff_err(NULL, __func__, "probe after resume failed, err=%d\n", err);
+
+	return err;
+}
+
+static const struct dev_pm_ops inff_pciedrvr_pm = {
+	.suspend = inff_pcie_pm_enter_D3,
+	.resume = inff_pcie_pm_leave_D3,
+	.freeze = inff_pcie_pm_enter_D3,
+	.restore = inff_pcie_pm_leave_D3,
+};
+
+#endif /* CONFIG_PM */
+
+#define INFF_PCIE_DEVICE(dev_id) \
+	{ \
+		INF_PCIE_VENDOR_ID_CYPRESS, dev_id, \
+		PCI_ANY_ID, PCI_ANY_ID, \
+		PCI_CLASS_NETWORK_OTHER << 8, 0xffff00, \
+		0 \
+	} \
+
+static const struct pci_device_id inff_pcie_devid_table[] = {
+	INFF_PCIE_DEVICE(INF_PCIE_5557X_DEVICE_ID),
+	{ /* end: all zeroes */ }
+};
+
+MODULE_DEVICE_TABLE(pci, inff_pcie_devid_table);
+
+static struct pci_driver inff_pciedrvr = {
+	.name = KBUILD_MODNAME,
+	.id_table = inff_pcie_devid_table,
+	.probe = inff_pcie_probe,
+	.remove = inff_pcie_remove,
+#ifdef CONFIG_PM
+	.driver.pm = &inff_pciedrvr_pm,
+#endif
+	.driver.coredump = inff_dev_coredump,
+};
+
+int inff_pcie_register(void)
+{
+	inff_dbg(PCIE, "Enter\n");
+	return pci_register_driver(&inff_pciedrvr);
+}
+
+void inff_pcie_exit(void)
+{
+	inff_dbg(PCIE, "Enter\n");
+	pci_unregister_driver(&inff_pciedrvr);
+}
diff --git a/drivers/net/wireless/infineon/inffmac/pcie.h b/drivers/net/wireless/infineon/inffmac/pcie.h
new file mode 100644
index 000000000000..f319d9741e04
--- /dev/null
+++ b/drivers/net/wireless/infineon/inffmac/pcie.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: ISC */
+/*
+ * Copyright (c) 2014 Broadcom Corporation
+ *
+ * Copyright (c) 2025, Infineon Technologies AG, or an affiliate of Infineon Technologies AG.
+ * All rights reserved.
+ */
+
+#ifndef INFF_PCIE_H
+#define INFF_PCIE_H
+
+struct inff_pciedev {
+	struct inff_bus *bus;
+	struct inff_pciedev_info *devinfo;
+};
+
+void inff_pcie_handle_mb_data(struct inff_bus *bus_if, u32 d2h_mb_data);
+
+#endif /* INFF_PCIE_H */
-- 
2.25.1


