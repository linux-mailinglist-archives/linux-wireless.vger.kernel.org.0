Return-Path: <linux-wireless+bounces-27389-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DD0FB7DE64
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Sep 2025 14:36:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C49542A06AE
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Sep 2025 22:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D5C41C5486;
	Tue, 16 Sep 2025 22:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b="RNYrrukc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp14.infineon.com (smtp14.infineon.com [217.10.52.160])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117AD31BC8C
	for <linux-wireless@vger.kernel.org>; Tue, 16 Sep 2025 22:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.52.160
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758061606; cv=none; b=qdtq2EfUA3ITfA2YFpP1qHJH4MgF0HdIciFDLoU0AngHf9MvBsMt2+PEHMwp/aG4Wol4ZJjCrVMkOJQtyEfvreupx0URWh8RnQro3uSXCVDBCovyn0CLeAKzepWqk35r5JX+oquZpBgyJoPHXa37UTh7UPrNeIYSVFp4YzEnmuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758061606; c=relaxed/simple;
	bh=3/KM/If46vgIv1PEYwr+Vx9iQUCKfkBwGlM9/6GET54=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rq0CStdcCUEix8DFyeo2pfIF4DL/nFxCt5rFGyEAq32zd7PIy/BAKQWJVdKStTJvoMBfK73hA+LyypjJ66CQjbd14ppPmiKceBxNorZKzpDlDpWaNgQo68GC9r8+SQbi4PRnB5uCHXkjyWWGpR8zvcJuvxdCGQLP4DO5E5nTHeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com; spf=pass smtp.mailfrom=infineon.com; dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b=RNYrrukc; arc=none smtp.client-ip=217.10.52.160
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infineon.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1758061598; x=1789597598;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3/KM/If46vgIv1PEYwr+Vx9iQUCKfkBwGlM9/6GET54=;
  b=RNYrrukcd6712YpsmcSaXlZ5QdDrF9FGMPzWalNXAZBQgFw+UGopAoXy
   7J3GhQSkxiD0OrwDAxr3BqDgvrwS7KGTq7bx1sHYs3EivOHrsQauVKSgx
   sB+BtTliZDT3t0QA/jR9++U28TgGmGCV22zvb5wCfE5WiepGpmY7RRCG2
   U=;
X-CSE-ConnectionGUID: NHWUO21QQ9On3QCiTW0dBg==
X-CSE-MsgGUID: yGoibocfQjKt2q8LzUQJZg==
X-IronPort-AV: E=McAfee;i="6800,10657,11555"; a="99294136"
X-IronPort-AV: E=Sophos;i="6.18,270,1751234400"; 
   d="scan'208";a="99294136"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO MUCSE812.infineon.com) ([172.23.29.38])
  by smtp14.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 00:26:36 +0200
Received: from MUCSE827.infineon.com (172.23.29.20) by MUCSE812.infineon.com
 (172.23.29.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.36; Wed, 17 Sep
 2025 00:26:35 +0200
Received: from ISCN5CG14747PP.infineon.com (10.161.6.196) by
 MUCSE827.infineon.com (172.23.29.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.36; Wed, 17 Sep 2025 00:26:30 +0200
From: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
To: <linux-wireless@vger.kernel.org>, Johannes Berg
	<johannes@sipsolutions.net>
CC: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>,
	<wlan-kernel-dev-list@infineon.com>
Subject: [PATCH wireless-next 34/57] wifi: inffmac: add sdio.c/h
Date: Wed, 17 Sep 2025 03:47:54 +0530
Message-ID: <20250916221821.4387-40-gokulkumar.sivakumar@infineon.com>
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
X-ClientProxiedBy: MUCSE817.infineon.com (172.23.29.43) To
 MUCSE827.infineon.com (172.23.29.20)

Implements the specific bus logic for Infineon devices connected to the
linux machine via an SDIO interface.

Signed-off-by: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
---
 drivers/net/wireless/infineon/inffmac/sdio.c | 5909 ++++++++++++++++++
 drivers/net/wireless/infineon/inffmac/sdio.h |  553 ++
 2 files changed, 6462 insertions(+)
 create mode 100644 drivers/net/wireless/infineon/inffmac/sdio.c
 create mode 100644 drivers/net/wireless/infineon/inffmac/sdio.h

diff --git a/drivers/net/wireless/infineon/inffmac/sdio.c b/drivers/net/wireless/infineon/inffmac/sdio.c
new file mode 100644
index 000000000000..93183545e987
--- /dev/null
+++ b/drivers/net/wireless/infineon/inffmac/sdio.c
@@ -0,0 +1,5909 @@
+// SPDX-License-Identifier: ISC
+/*
+ * Copyright (c) 2010 Broadcom Corporation
+ *
+ * Copyright (c) 2025, Infineon Technologies AG, or an affiliate of Infineon Technologies AG.
+ * All rights reserved.
+ */
+
+#include <linux/types.h>
+#include <linux/atomic.h>
+#include <linux/kernel.h>
+#include <linux/kthread.h>
+#include <linux/printk.h>
+#include <linux/pci_ids.h>
+#include <linux/netdevice.h>
+#include <linux/interrupt.h>
+#include <linux/sched/signal.h>
+#include <linux/mmc/sdio.h>
+#include <linux/mmc/sdio_ids.h>
+#include <linux/mmc/sdio_func.h>
+#include <linux/mmc/card.h>
+#include <linux/mmc/core.h>
+#include <linux/mmc/host.h>
+#include <linux/semaphore.h>
+#include <linux/firmware.h>
+#include <linux/module.h>
+#include <linux/debugfs.h>
+#include <linux/vmalloc.h>
+#include <linux/net_tstamp.h>
+#include <linux/unaligned.h>
+
+#include "defs.h"
+#include "utils.h"
+#include "hw_ids.h"
+#include "sdio.h"
+#include "chip.h"
+#include "firmware.h"
+#include "core.h"
+#include "common.h"
+#include "bcdc.h"
+#include "fwil.h"
+#include "bt_shared_sdio.h"
+#include "trxhdr.h"
+#include "feature.h"
+#include "chip_43022.h"
+#include "chip_5557x.h"
+#include "chip_5591x.h"
+#include "dfu.h"
+
+#define DCMD_RESP_TIMEOUT	msecs_to_jiffies(2500)
+#define CTL_DONE_TIMEOUT	msecs_to_jiffies(2500)
+#define ULP_HUDI_PROC_DONE_TIME	msecs_to_jiffies(2500)
+
+/* watermark expressed in number of words */
+#define DEFAULT_F2_WATERMARK    0x8
+
+#ifdef DEBUG
+
+#define INFF_TRAP_INFO_SIZE	80
+
+#define CBUF_LEN	(128)
+
+/* Device console log buffer state */
+#define CONSOLE_BUFFER_MAX	2024
+
+struct rte_log_le {
+	__le32 buf;		/* Can't be pointer on (64-bit) hosts */
+	__le32 buf_size;
+	__le32 idx;
+	char *_buf_compat;	/* Redundant pointer for backward compat. */
+};
+
+struct rte_console {
+	/* Virtual UART
+	 * When there is no UART (e.g. Quickturn),
+	 * the host should write a complete
+	 * input line directly into cbuf and then write
+	 * the length into vcons_in.
+	 * This may also be used when there is a real UART
+	 * (at risk of conflicting with
+	 * the real UART).  vcons_out is currently unused.
+	 */
+	uint vcons_in;
+	uint vcons_out;
+
+	/* Output (logging) buffer
+	 * Console output is written to a ring buffer log_buf at index log_idx.
+	 * The host may read the output when it sees log_idx advance.
+	 * Output will be lost if the output wraps around faster than the host
+	 * polls.
+	 */
+	struct rte_log_le log_le;
+
+	/* Console input line buffer
+	 * Characters are read one at a time into cbuf
+	 * until <CR> is received, then
+	 * the buffer is processed as a command line.
+	 * Also used for virtual UART.
+	 */
+	uint cbuf_idx;
+	char cbuf[CBUF_LEN];
+};
+
+#endif				/* DEBUG */
+#include "chipcommon.h"
+
+#include "bus.h"
+#include "debug.h"
+#include "tracepoint.h"
+
+#define TXQLEN		2048	/* bulk tx queue length */
+#define TXHI		(TXQLEN - 256)	/* turn on flow control above TXHI */
+#define TXLOW		(TXHI - 256)	/* turn off flow control below TXLOW */
+#define PRIOMASK	7
+
+#define TXRETRIES	2	/* # of retries for tx frames */
+
+#define INFF_RXBOUND	50	/* Default for max rx frames in
+				 * one scheduling
+				 */
+
+#define INFF_TXBOUND	20	/* Default for max tx frames in
+				 * one scheduling
+				 */
+
+#define INFF_TXMINMAX	1	/* Max tx frames if rx still pending */
+
+#define MEMBLOCK	2048	/* Block size used for downloading
+				 * of dongle image
+				 */
+#define MAX_DATA_BUF	(32 * 1024)	/* Must be large enough to hold
+					 * biggest possible glom
+					 */
+
+#define INFF_FIRSTREAD	BIT(6)
+
+/* SBSDIO_DEVICE_CTL */
+
+/* 1: device will assert busy signal when receiving CMD53 */
+#define SBSDIO_DEVCTL_SETBUSY		0x01
+/* 1: assertion of sdio interrupt is synchronous to the sdio clock */
+#define SBSDIO_DEVCTL_SPI_INTR_SYNC	0x02
+/* 1: mask all interrupts to host except the chipActive (rev 8) */
+#define SBSDIO_DEVCTL_CA_INT_ONLY	0x04
+/* 1: isolate internal sdio signals, put external pads in tri-state; requires
+ * sdio bus power cycle to clear (rev 9)
+ */
+#define SBSDIO_DEVCTL_PADS_ISO		0x08
+/* 1: enable F2 Watermark */
+#define SBSDIO_DEVCTL_F2WM_ENAB		0x10
+/* Force SD->SB reset mapping (rev 11) */
+#define SBSDIO_DEVCTL_SB_RST_CTL	0x30
+/*   Determined by CoreControl bit */
+#define SBSDIO_DEVCTL_RST_CORECTL	0x00
+/*   Force backplane reset */
+#define SBSDIO_DEVCTL_RST_BPRESET	0x10
+/*   Force no backplane reset */
+#define SBSDIO_DEVCTL_RST_NOBPRESET	0x20
+/* Reset SB Address to default value */
+#define SBSDIO_DEVCTL_ADDR_RESET    0x40
+
+/* direct(mapped) cis space */
+
+/* MAPPED common CIS address */
+#define SBSDIO_CIS_BASE_COMMON		0x1000
+/* maximum bytes in one CIS */
+#define SBSDIO_CIS_SIZE_LIMIT		0x200
+/* cis offset addr is < 17 bits */
+#define SBSDIO_CIS_OFT_ADDR_MASK	0x1FFFF
+
+/* manfid tuple length, include tuple, link bytes */
+#define SBSDIO_CIS_MANFID_TUPLE_LEN	6
+
+#define SD_REG(field) \
+		(offsetof(struct sdpcmd_regs, field))
+
+/* SDIO function 1 register CHIPCLKCSR */
+/* Force ALP request to backplane */
+#define SBSDIO_FORCE_ALP		0x01
+/* Force HT request to backplane */
+#define SBSDIO_FORCE_HT			0x02
+/* Force ILP request to backplane */
+#define SBSDIO_FORCE_ILP		0x04
+/* Make ALP ready (power up xtal) */
+#define SBSDIO_ALP_AVAIL_REQ		0x08
+/* Make HT ready (power up PLL) */
+#define SBSDIO_HT_AVAIL_REQ		0x10
+/* Squelch clock requests from HW */
+#define SBSDIO_FORCE_HW_CLKREQ_OFF	0x20
+/* Status: ALP is ready */
+#define SBSDIO_ALP_AVAIL		0x40
+/* Status: HT is ready */
+#define SBSDIO_HT_AVAIL			0x80
+#define SBSDIO_CSR_MASK			0x1F
+#define SBSDIO_AVBITS		(SBSDIO_HT_AVAIL | SBSDIO_ALP_AVAIL)
+#define SBSDIO_ALPAV(regval)	((regval) & SBSDIO_AVBITS)
+#define SBSDIO_HTAV(regval)	(((regval) & SBSDIO_AVBITS) == SBSDIO_AVBITS)
+#define SBSDIO_ALPONLY(regval)	({ \
+	typeof(regval) _regval = (regval); \
+	(SBSDIO_ALPAV(_regval) && !SBSDIO_HTAV(_regval)); \
+	})
+#define SBSDIO_CLKAV(regval, alponly) ({ \
+	typeof(regval) _regval = (regval); \
+	(SBSDIO_ALPAV(_regval) && (alponly ? 1 : SBSDIO_HTAV(_regval))); \
+	})
+#define ALP_WAIT_MIN 65
+#define ALP_WAIT_MAX 85
+
+/* intstatus */
+#define I_SMB_SW0       BIT(0)	/* To SB Mail S/W interrupt 0 */
+#define I_SMB_SW1       BIT(1)	/* To SB Mail S/W interrupt 1 */
+#define I_SMB_SW2       BIT(2)	/* To SB Mail S/W interrupt 2 */
+#define I_SMB_SW3       BIT(3)	/* To SB Mail S/W interrupt 3 */
+#define I_SMB_SW_MASK	0x0000000f	/* To SB Mail S/W interrupts mask */
+#define I_SMB_SW_SHIFT	0	/* To SB Mail S/W interrupts shift */
+#define I_HMB_SW0       BIT(4)	/* To Host Mail S/W interrupt 0 */
+#define I_HMB_SW1       BIT(5)	/* To Host Mail S/W interrupt 1 */
+#define I_HMB_SW2       BIT(6)	/* To Host Mail S/W interrupt 2 */
+#define I_HMB_SW3       BIT(7)	/* To Host Mail S/W interrupt 3 */
+#define I_HMB_SW_MASK	0x000000f0	/* To Host Mail S/W interrupts mask */
+#define I_HMB_SW_SHIFT	4	/* To Host Mail S/W interrupts shift */
+#define I_WR_OOSYNC     BIT(8)	/* Write Frame Out Of Sync */
+#define I_RD_OOSYNC     BIT(9)	/* Read Frame Out Of Sync */
+#define I_PC            BIT(10)	/* descriptor error */
+#define I_PD            BIT(11)	/* data error */
+#define I_DE            BIT(12)	/* Descriptor protocol Error */
+#define I_RU            BIT(13)	/* Receive descriptor Underflow */
+#define I_RO            BIT(14)	/* Receive fifo Overflow */
+#define I_XU            BIT(15)	/* Transmit fifo Underflow */
+#define I_RI            BIT(16)	/* Receive Interrupt */
+#define I_BUSPWR        BIT(17)	/* SDIO Bus Power Change (rev 9) */
+#define I_XMTDATA_AVAIL BIT(23)	/* bits in fifo */
+#define I_XI            BIT(24)	/* Transmit Interrupt */
+#define I_RF_TERM       BIT(25)	/* Read Frame Terminate */
+#define I_WF_TERM       BIT(26)	/* Write Frame Terminate */
+#define I_PCMCIA_XU     BIT(27)	/* PCMCIA Transmit FIFO Underflow */
+#define I_SBINT         BIT(28)	/* sbintstatus Interrupt */
+#define I_CHIPACTIVE    BIT(29)	/* chip from doze to active state */
+#define I_SRESET        BIT(30)	/* CCCR RES interrupt */
+#define I_IOE2          BIT(31)	/* CCCR IOE2 Bit Changed */
+#define I_ERRORS        (I_PC | I_PD | I_DE | I_RU | I_RO | I_XU)
+#define I_DMA           (I_RI | I_XI | I_ERRORS)
+
+/* corecontrol */
+#define CC_CISRDY             BIT(0)	/* CIS Ready */
+#define CC_BPRESEN            BIT(1)	/* CCCR RES signal */
+#define CC_F2RDY              BIT(2)	/* set CCCR IOR2 bit */
+#define CC_CLRPADSISO         BIT(3)	/* clear SDIO pads isolation */
+#define CC_XMTDATAAVAIL_MODE  BIT(4)
+#define CC_XMTDATAAVAIL_CTRL  BIT(5)
+
+/* SDA_FRAMECTRL */
+#define SFC_RF_TERM   BIT(0)	/* Read Frame Terminate */
+#define SFC_WF_TERM   BIT(1)	/* Write Frame Terminate */
+#define SFC_CRC4WOOS  BIT(2)	/* CRC error for write out of sync */
+#define SFC_ABORTALL  BIT(3)	/* Abort all in-progress frames */
+
+/*
+ * Software allocation of To SB Mailbox resources
+ */
+
+/* tosbmailbox bits corresponding to intstatus bits */
+#define SMB_NAK      BIT(0)	/* Frame NAK */
+#define SMB_INT_ACK  BIT(1)	/* Host Interrupt ACK */
+#define SMB_USE_OOB  BIT(2)	/* Use OOB Wakeup */
+#define SMB_DEV_INT  BIT(3)	/* Miscellaneous Interrupt */
+
+/* tosbmailboxdata */
+#define SMB_DATA_VERSION_SHIFT	16	/* host protocol version */
+
+/*
+ * Software allocation of To Host Mailbox resources
+ */
+
+/* intstatus bits */
+#define I_HMB_FC_STATE	I_HMB_SW0	/* Flow Control State */
+#define I_HMB_FC_CHANGE	I_HMB_SW1	/* Flow Control State Changed */
+#define I_HMB_FRAME_IND	I_HMB_SW2	/* Frame Indication */
+#define I_HMB_HOST_INT	I_HMB_SW3	/* Miscellaneous Interrupt */
+
+/* tohostmailboxdata */
+#define HMB_DATA_NAKHANDLED	0x0001	/* retransmit NAK'd frame */
+#define HMB_DATA_DEVREADY	0x0002	/* talk to host after enable */
+#define HMB_DATA_FC		0x0004	/* per prio flowcontrol update flag */
+#define HMB_DATA_FWREADY	0x0008	/* fw ready for protocol activity */
+#define HMB_DATA_FWHALT		0x0010	/* firmware halted */
+
+#define HMB_DATA_FCDATA_MASK	0xff000000
+#define HMB_DATA_FCDATA_SHIFT	24
+
+#define HMB_DATA_VERSION_MASK	0x00ff0000
+#define HMB_DATA_VERSION_SHIFT	16
+
+/*
+ * Software-defined protocol header
+ */
+
+/* Current protocol version */
+#define SDPCM_PROT_VERSION	4
+
+/*
+ * Shared structure between dongle and the host.
+ * The structure contains pointers to trap or assert information.
+ */
+#define SDPCM_SHARED_VERSION       0x0003
+#define SDPCM_SHARED_VERSION_MASK  0x00FF
+#define SDPCM_SHARED_ASSERT_BUILT  0x0100
+#define SDPCM_SHARED_ASSERT        0x0200
+#define SDPCM_SHARED_TRAP          0x0400
+
+/* Space for header read, limit for data packets */
+#define MAX_HDR_READ	BIT(6)
+#define MAX_RX_DATASZ	2048
+
+/* Bump up limit on waiting for HT to account for first startup;
+ * if the image is doing a CRC calculation before programming the PMU
+ * for HT availability, it could take a couple hundred ms more, so
+ * max out at a 1 second (1000000us).
+ */
+#undef PMU_MAX_TRANSITION_DLY
+#define PMU_MAX_TRANSITION_DLY 1000000
+
+/* Value for ChipClockCSR during initial setup */
+#define INFF_INIT_CLKCTL1	(SBSDIO_FORCE_HW_CLKREQ_OFF |	\
+					SBSDIO_ALP_AVAIL_REQ)
+
+/* Flags for SDH calls */
+#define F2SYNC	(SDIO_REQ_4BYTE | SDIO_REQ_FIXED)
+
+#define INFF_IDLE_ACTIVE	0	/* Do not request any SD clock change
+					 * when idle
+					 */
+#define INFF_IDLE_STOP		(-1)	/* Request SD clock be stopped */
+#define INFF_IDLE_INTERVAL	1
+
+#define KSO_WAIT_US 50
+#define KSO_MAX_SEQ_TIME_NS (1000000 * 10) /* Ideal time for kso sequence 10ms in ns*/
+#define MAX_KSO_ATTEMPTS (PMU_MAX_TRANSITION_DLY / KSO_WAIT_US)
+
+static void inff_sdio_firmware_callback(struct device *dev, int err,
+					struct inff_fw_request *fwreq);
+static int inff_sdio_f2_ready(struct inff_sdio *bus);
+static int inff_ulp_event_notify(struct inff_if *ifp,
+				 const struct inff_event_msg *evtmsg,
+				 void *data);
+static void
+inff_sched_rxf(struct inff_sdio *bus, struct sk_buff *skb);
+
+#ifdef DEBUG
+/* Device console log buffer state */
+struct inff_console {
+	uint count;		/* Poll interval msec counter */
+	uint log_addr;		/* Log struct address (fixed) */
+	struct rte_log_le log_le;	/* Log struct (host copy) */
+	uint bufsize;		/* Size of log buffer */
+	u8 *buf;		/* Log buffer (host copy) */
+	uint last;		/* Last buffer read index */
+};
+
+struct inff_trap_info {
+	__le32		type;
+	__le32		epc;
+	__le32		cpsr;
+	__le32		spsr;
+	__le32		r0;	/* a1 */
+	__le32		r1;	/* a2 */
+	__le32		r2;	/* a3 */
+	__le32		r3;	/* a4 */
+	__le32		r4;	/* v1 */
+	__le32		r5;	/* v2 */
+	__le32		r6;	/* v3 */
+	__le32		r7;	/* v4 */
+	__le32		r8;	/* v5 */
+	__le32		r9;	/* sb/v6 */
+	__le32		r10;	/* sl/v7 */
+	__le32		r11;	/* fp/v8 */
+	__le32		r12;	/* ip */
+	__le32		r13;	/* sp */
+	__le32		r14;	/* lr */
+	__le32		pc;	/* r15 */
+};
+#endif				/* DEBUG */
+
+struct sdpcm_shared {
+	u32 flags;
+	u32 trap_addr;
+	u32 assert_exp_addr;
+	u32 assert_file_addr;
+	u32 assert_line;
+	u32 console_addr;	/* Address of struct rte_console */
+	u32 msgtrace_addr;
+	u8 tag[32];
+	u32 brpt_addr;
+};
+
+struct sdpcm_shared_le {
+	__le32 flags;
+	__le32 trap_addr;
+	__le32 assert_exp_addr;
+	__le32 assert_file_addr;
+	__le32 assert_line;
+	__le32 console_addr;	/* Address of struct rte_console */
+	__le32 msgtrace_addr;
+	u8 tag[32];
+	__le32 brpt_addr;
+};
+
+/* dongle SDIO bus specific header info */
+struct inff_sdio_hdrinfo {
+	u8 seq_num;
+	u8 channel;
+	u16 len;
+	u16 len_left;
+	u16 len_nxtfrm;
+	u8 dat_offset;
+	bool lastfrm;
+	u16 tail_pad;
+};
+
+struct task_ctl {
+	struct	task_struct *p_task;
+	struct	completion comp;
+};
+
+/*
+ * hold counter variables
+ */
+struct inff_sdio_count {
+	uint intrcount;		/* Count of device interrupt callbacks */
+	uint lastintrs;		/* Count as of last watchdog timer */
+	uint pollcnt;		/* Count of active polls */
+	uint regfails;		/* Count of R_REG failures */
+	uint tx_sderrs;		/* Count of tx attempts with sd errors */
+	uint fcqueued;		/* Tx packets that got queued */
+	uint rxrtx;		/* Count of rtx requests (NAK to dongle) */
+	uint rx_toolong;	/* Receive frames too long to receive */
+	uint rxc_errors;	/* SDIO errors when reading control frames */
+	uint rx_hdrfail;	/* SDIO errors on header reads */
+	uint rx_badhdr;		/* Bad received headers (roosync?) */
+	uint rx_badseq;		/* Mismatched rx sequence number */
+	uint fc_rcvd;		/* Number of flow-control events received */
+	uint fc_xoff;		/* Number which turned on flow-control */
+	uint fc_xon;		/* Number which turned off flow-control */
+	uint rxglomfail;	/* Failed deglom attempts */
+	uint rxglomframes;	/* Number of glom frames (superframes) */
+	uint rxglompkts;	/* Number of packets from glom frames */
+	uint f2rxhdrs;		/* Number of header reads */
+	uint f2rxdata;		/* Number of frame data reads */
+	uint f2txdata;		/* Number of f2 frame writes */
+	uint f1regdata;		/* Number of f1 register accesses */
+	uint tickcnt;		/* Number of watchdog been schedule */
+	ulong tx_ctlerrs;	/* Err of sending ctrl frames */
+	ulong tx_ctlpkts;	/* Ctrl frames sent to dongle */
+	ulong rx_ctlerrs;	/* Err of processing rx ctrl frames */
+	ulong rx_ctlpkts;	/* Ctrl frames processed from dongle */
+	ulong rx_readahead_cnt;	/* packets where header read-ahead was used */
+};
+
+/* misc chip info needed by some of the routines */
+/* Private data for SDIO bus interaction */
+struct inff_sdio {
+	struct inff_sdio_dev *sdiodev;	/* sdio device handler */
+	struct inff_chip *ci;	/* Chip info struct */
+	struct inff_core *sdio_core; /* sdio core info struct */
+
+	u32 hostintmask;	/* Copy of Host Interrupt Mask */
+	atomic_t intstatus;	/* Intstatus bits (events) pending */
+	atomic_t fcstate;	/* State of dongle flow-control */
+
+	uint blocksize;		/* Block size of SDIO transfers */
+	uint roundup;		/* Max roundup limit */
+
+	struct pktq txq;	/* Queue length used for flow-control */
+	u8 flowcontrol;	/* per prio flow control bitmask */
+	u8 tx_seq;		/* Transmit sequence number (next) */
+	u8 tx_max;		/* Maximum transmit sequence allowed */
+
+	u8 *hdrbuf;		/* buffer for handling rx frame */
+	u8 *rxhdr;		/* Header of current rx frame (in hdrbuf) */
+	u8 rx_seq;		/* Receive sequence number (expected) */
+	struct inff_sdio_hdrinfo cur_read;
+				/* info of current read frame */
+	bool rxskip;		/* Skip receive (awaiting NAK ACK) */
+	bool rxpending;		/* Data frame pending in dongle */
+
+	uint rxbound;		/* Rx frames to read before resched */
+	uint txbound;		/* Tx frames to send before resched */
+	uint txminmax;
+
+	struct sk_buff *glomd;	/* Packet containing glomming descriptor */
+	struct sk_buff_head glom; /* Packet list for glommed superframe */
+
+	u8 *rxbuf;		/* Buffer for receiving control packets */
+	uint rxblen;		/* Allocated length of rxbuf */
+	u8 *rxctl;		/* Aligned pointer into rxbuf */
+	u8 *rxctl_orig;		/* pointer for freeing rxctl */
+	uint rxlen;		/* Length of valid data in buffer */
+	spinlock_t rxctl_lock;	/* protection lock for ctrl frame resources */
+
+	u8 sdpcm_ver;	/* Bus protocol reported by dongle */
+
+	atomic_t ipend;		/* Device interrupt is pending */
+	uint spurious;		/* Count of spurious interrupts */
+
+#ifdef DEBUG
+	uint console_interval;
+	struct inff_console console;	/* Console output polling support */
+	uint console_addr;	/* Console address from shared struct */
+#endif				/* DEBUG */
+
+	uint clkstate;		/* State of sd and backplane clock(s) */
+	s32 idletime;		/* Control for activity timeout */
+	s32 idlecount;		/* Activity timeout counter */
+	s32 idleclock;		/* How to set bus driver when idle */
+	bool rxflow_mode;	/* Rx flow control mode */
+	bool rxflow;		/* Is rx flow control on */
+	bool alp_only;		/* Don't use HT clock (ALP only) */
+
+	u8 *ctrl_frame_buf;
+	u16 ctrl_frame_len;
+	bool ctrl_frame_stat;
+	int ctrl_frame_err;
+
+	spinlock_t txq_lock;		/* protect bus->txq */
+	wait_queue_head_t ctrl_wait;
+	wait_queue_head_t dcmd_resp_wait;
+
+	struct timer_list timer;
+	struct completion watchdog_wait;
+	struct task_struct *watchdog_tsk;
+	bool wd_active;
+
+	struct workqueue_struct *inff_wq;
+	struct work_struct datawork;
+	bool dpc_triggered;
+	bool dpc_running;
+
+	bool txoff;		/* Transmit flow-controlled */
+	struct inff_sdio_count sdcnt;
+	bool sr_enabled; /* SaveRestore enabled */
+	bool sleeping;
+
+	u8 tx_hdrlen;		/* sdio bus header length for tx packet */
+	bool txglom;		/* host tx glomming enable flag */
+	u16 head_align;		/* buffer pointer alignment */
+	u16 sgentry_align;	/* scatter-gather buffer alignment */
+	struct mutex sdsem;
+	bool chipid_preset;
+	#define MAXSKBPEND 1024
+	struct sk_buff *skbbuf[MAXSKBPEND];
+	u32 store_idx;
+	u32 sent_idx;
+	struct task_ctl	thr_rxf_ctl;
+	spinlock_t rxf_lock;	/* lock for rxf idx protection */
+	bool h1_ddr50_mode;	/* H1 DDR50 Mode enabled*/
+};
+
+/* clkstate */
+#define CLK_NONE	0
+#define CLK_SDONLY	1
+#define CLK_PENDING	2
+#define CLK_AVAIL	3
+
+#ifdef DEBUG
+static int qcount[NUMPRIO];
+#endif				/* DEBUG */
+
+#define DEFAULT_SDIO_DRIVE_STRENGTH	6	/* in milliamps */
+
+#define RETRYCHAN(chan) ((chan) == SDPCM_EVENT_CHANNEL)
+
+/* Limit on rounding up frames */
+static const uint max_roundup = 512;
+
+#ifdef CONFIG_ARCH_DMA_ADDR_T_64BIT
+#define ALIGNMENT  8
+#else
+#define ALIGNMENT  4
+#endif
+
+enum inff_sdio_frmtype {
+	INFF_SDIO_FT_NORMAL,
+	INFF_SDIO_FT_SUPER,
+	INFF_SDIO_FT_SUB,
+};
+
+#define SDIOD_DRVSTR_KEY(chip, pmu)     (((unsigned int)(chip) << 16) | (pmu))
+
+/* SDIO Pad drive strength to select value mappings */
+struct sdiod_drive_str {
+	u8 strength;	/* Pad Drive Strength in mA */
+	u8 sel;		/* Chip-specific select value */
+};
+
+/* SDIO Drive Strength to sel value table for PMU Rev 11 (1.8V) */
+static const struct sdiod_drive_str sdiod_drvstr_tab1_1v8[] = {
+	{32, 0x6},
+	{26, 0x7},
+	{22, 0x4},
+	{16, 0x5},
+	{12, 0x2},
+	{8, 0x3},
+	{4, 0x0},
+	{0, 0x1}
+};
+
+/* SDIO Drive Strength to sel value table for PMU Rev 13 (1.8v) */
+static const struct sdiod_drive_str sdiod_drive_strength_tab5_1v8[] = {
+	{6, 0x7},
+	{5, 0x6},
+	{4, 0x5},
+	{3, 0x4},
+	{2, 0x2},
+	{1, 0x1},
+	{0, 0x0}
+};
+
+/* SDIO Drive Strength to sel value table for PMU Rev 17 (1.8v) */
+static const struct sdiod_drive_str sdiod_drvstr_tab6_1v8[] = {
+	{3, 0x3},
+	{2, 0x2},
+	{1, 0x1},
+	{0, 0x0} };
+
+/* SDIO Drive Strength to sel value table for 43143 PMU Rev 17 (3.3V) */
+static const struct sdiod_drive_str sdiod_drvstr_tab2_3v3[] = {
+	{16, 0x7},
+	{12, 0x5},
+	{8,  0x3},
+	{4,  0x1}
+};
+
+/* per-board firmware binaries */
+#define INFF_55572_FIRMWARE_BASENAME INFF_FW_DEFAULT_PATH "inffmac55572-sdio"
+#define INFF_55500_FIRMWARE_BASENAME INFF_FW_DEFAULT_PATH "inffmac55500-sdio"
+#define INFF_43022_FIRMWARE_BASENAME INFF_FW_DEFAULT_PATH "inffmac43022-sdio"
+
+MODULE_FIRMWARE(INFF_55572_FIRMWARE_BASENAME ".trxse");
+MODULE_FIRMWARE(INFF_55500_FIRMWARE_BASENAME ".trxse");
+MODULE_FIRMWARE(INFF_43022_FIRMWARE_BASENAME ".trxs");
+
+static const struct inff_firmware_mapping inff_sdio_fwnames[] = {
+	INFF_FW_ENTRY(INF_CC_5557X_CHIP_ID, 0xFFFFFFFF, 55572),
+	INFF_FW_ENTRY(INF_CC_5551X_CHIP_ID, 0xFFFFFFFF, 55500),
+	INFF_FW_ENTRY(INF_CC_43022_CHIP_ID, 0xFFFFFFFF, 43022),
+};
+
+#define TXCTL_CREDITS	2
+
+bool inff_sdio_bus_sleep_state(struct inff_sdio *bus)
+{
+	return bus->sleeping;
+}
+
+static inline bool inff_sdio_bus_access_allowed(u32 addr)
+{
+	return (addr == SBSDIO_FUNC1_SLEEPCSR) ? true : false;
+}
+
+u8 inff_sdiod_func0_rb(struct inff_sdio_dev *sdiodev, u32 addr, int *ret)
+{
+	inff_dbg(SDIOEXT, "addr 0x%x\n", addr);
+
+	if (!inff_sdio_bus_sleep_state(sdiodev->bus) || sdiodev->ignore_bus_error)
+		return inff_sdiod_func0_rb_ext(sdiodev, addr, ret);
+
+	inff_err(" Error Access Not allowed\n");
+	if (ret)
+		*ret = -EPERM;
+	return 0xFF;
+}
+
+void inff_sdiod_func0_wb(struct inff_sdio_dev *sdiodev, u32 addr, u32 data,
+			 int *ret)
+{
+	inff_dbg(SDIOEXT, "addr 0x%x val 0x%x\n", addr, data);
+
+	if (!inff_sdio_bus_sleep_state(sdiodev->bus) || sdiodev->ignore_bus_error) {
+		inff_sdiod_func0_wb_ext(sdiodev, addr, data, ret);
+	} else {
+		inff_err(" Error Access Not allowed\n");
+		if (ret)
+			*ret = -EPERM;
+	}
+}
+
+u8 inff_sdiod_readb(struct inff_sdio_dev *sdiodev, u32 addr, int *ret)
+{
+	inff_dbg(SDIOEXT, "addr 0x%x\n", addr);
+
+	if (!inff_sdio_bus_sleep_state(sdiodev->bus) || inff_sdio_bus_access_allowed(addr))
+		return inff_sdiod_readb_ext(sdiodev, addr, ret);
+
+	inff_err(" Error Access Not allowed\n");
+	if (ret)
+		*ret = -EPERM;
+	return 0xFF;
+}
+
+void inff_sdiod_writeb(struct inff_sdio_dev *sdiodev, u32 addr, u32 data,
+		       int *ret)
+{
+	inff_dbg(SDIOEXT, "addr 0x%x val 0x%x\n", addr, data);
+
+	if (!inff_sdio_bus_sleep_state(sdiodev->bus) || inff_sdio_bus_access_allowed(addr)) {
+		inff_sdiod_writeb_ext(sdiodev, addr, data, ret);
+	} else {
+		inff_err(" Error Access Not allowed\n");
+		if (ret)
+			*ret = -EPERM;
+	}
+}
+
+u8 inff_sdiod_func_rb(struct inff_sdio_dev *sdiodev, struct sdio_func *func, u32 addr, int *ret)
+{
+	inff_dbg(SDIOEXT, "addr 0x%x\n", addr);
+
+	if (!inff_sdio_bus_sleep_state(sdiodev->bus))
+		return inff_sdiod_func_rb_ext(func, addr, ret);
+
+	inff_err(" Error Access Not allowed\n");
+	if (ret)
+		*ret = -EPERM;
+	return 0xFF;
+}
+
+void inff_sdiod_func_wb(struct inff_sdio_dev *sdiodev, struct sdio_func *func, u32 addr,
+			u32 data, int *ret)
+{
+	inff_dbg(SDIOEXT, "addr 0x%x val 0x%x\n", addr, data);
+
+	if (!inff_sdio_bus_sleep_state(sdiodev->bus)) {
+		inff_sdiod_func_wb_ext(func, addr, data, ret);
+	} else {
+		inff_err(" Error Access Not allowed\n");
+		if (ret)
+			*ret = -EPERM;
+	}
+}
+
+static void pkt_align(struct sk_buff *p, int len, int align)
+{
+	uint datalign;
+
+	datalign = (unsigned long)(p->data);
+	datalign = roundup(datalign, (align)) - datalign;
+	if (datalign)
+		skb_pull(p, datalign);
+	__skb_trim(p, len);
+}
+
+/* To check if there's window offered */
+static bool data_ok(struct inff_sdio *bus)
+{
+	return (u8)(bus->tx_max - bus->tx_seq) > TXCTL_CREDITS &&
+	       ((u8)(bus->tx_max - bus->tx_seq) & 0x80) == 0;
+}
+
+/* To check if there's window offered */
+static bool txctl_ok(struct inff_sdio *bus)
+{
+	return (bus->tx_max - bus->tx_seq) != 0 &&
+	       ((bus->tx_max - bus->tx_seq) & 0x80) == 0;
+}
+
+static int
+inff_sdio_kso_control(struct inff_sdio *bus, bool on)
+{
+	u8 wr_val = 0, rd_val, cmp_val, bmask;
+	int err = 0;
+	int err_cnt = 0;
+	int try_cnt = 0;
+	unsigned long kso_loop_time = 0;
+	struct timespec64 ts_start, ts_end, ts_delta;
+	struct inff_sdio_dev *sdiod = bus->sdiodev;
+
+	inff_dbg(SDIO, "Enter: on=%d\n", on);
+
+	sdio_retune_crc_disable(bus->sdiodev->func1);
+
+	/* Cannot re-tune if device is asleep; defer till we're awake */
+	if (on)
+		sdio_retune_hold_now(bus->sdiodev->func1);
+
+	wr_val = (on << SBSDIO_FUNC1_SLEEPCSR_KSO_SHIFT);
+
+	/* Start time of kso_sequence */
+	ktime_get_ts64(&ts_start);
+
+	/* Change bus width to 1-bit mode before kso 0 */
+	if (!on && bus->idleclock == INFF_IDLE_STOP)
+		inff_sdio_set_sdbus_clk_width(bus, SDIO_SDMODE_1BIT);
+
+	/* 1st KSO write goes to AOS wake up core if device is asleep  */
+	inff_sdiod_writeb(bus->sdiodev, SBSDIO_FUNC1_SLEEPCSR, wr_val, &err);
+
+	/* The chip could go down immediately after
+	 * KSO bit is cleared. So the further reads of KSO register could
+	 * fail. Thereby just bailing out immediately after clearing KSO
+	 * bit, to avoid polling of KSO bit.
+	 */
+	if (!on) {
+		bus->sdiodev->sbwad_valid = 0;
+		return err;
+	}
+
+	/* device WAKEUP through KSO:
+	 * write bit 0 & read back until
+	 * both bits 0 (kso bit) & 1 (dev on status) are set
+	 */
+	cmp_val = SBSDIO_FUNC1_SLEEPCSR_KSO_MASK |
+		SBSDIO_FUNC1_SLEEPCSR_DEVON_MASK;
+	bmask = cmp_val;
+
+	do {
+		/* reliable KSO bit set/clr:
+		 * the sdiod sleep write access is synced to PMU 32khz clk
+		 * just one write attempt may fail,
+		 * read it back until it matches written value
+		 */
+		rd_val = inff_sdiod_readb(bus->sdiodev, SBSDIO_FUNC1_SLEEPCSR,
+					  &err);
+		if (!err) {
+			if ((rd_val & bmask) == cmp_val)
+				break;
+		} else {
+			err_cnt++;
+		}
+
+		/* Do one KSO write-read-check without any delay in between the steps,
+		 * if Device is already up KSO sequence will complete immediately
+		 * without any delay for Host
+		 */
+		if (try_cnt == 0) {
+			/* If Device is already up then it will not reach here,
+			 * if the control reaches here it means device is in sleep
+			 * so delay for some time to let Device wake up before
+			 * starting subsequent KSO wr-rd-check sequence
+			 * Delay should be less than the time device takes to wakeup
+			 * in normal case, because giving more delay than what device needs
+			 * will lead to host being unnecessarily blocked here while device is
+			 * already up and ready, leading to more power consumptions of both
+			 * host and device, as well as overall increased response delays
+			 */
+			usleep_range(2500, 3000);
+		} else {
+			/* Initial delay is done, now do continuous KSO wr-rd-check
+			 * sequence with some small delay
+			 */
+			usleep_range(KSO_WAIT_US / 2, KSO_WAIT_US);
+		}
+
+		inff_sdiod_writeb(bus->sdiodev, SBSDIO_FUNC1_SLEEPCSR, wr_val,
+				  &err);
+
+	} while (try_cnt++ < MAX_KSO_ATTEMPTS);
+
+	ktime_get_ts64(&ts_end);
+	ts_delta = timespec64_sub(ts_end, ts_start);
+	kso_loop_time = timespec64_to_ns(&ts_delta);
+
+	if (try_cnt > MAX_KSO_ATTEMPTS)
+		inff_err("ERR: KSO=%d sequence failed after max tries=%d and err_cnt=%d\n"
+			  "kso_seq_time=%luns rd_val=0x%x err=%d\n",
+			   on, try_cnt, err_cnt, kso_loop_time, rd_val, err);
+
+	if (bus->idleclock == INFF_IDLE_STOP) {
+		/* Change the bus width to 4-bit mode on kso 1 */
+		sdiod->ignore_bus_error = true;
+		inff_sdio_set_sdbus_clk_width(bus, SDIO_SDMODE_4BIT);
+		sdiod->ignore_bus_error = false;
+	}
+
+	/* New KSO Sequence for H1 DDR50 Mode*/
+	if (bus->h1_ddr50_mode) {
+		u32 ret, chipid;
+
+		/* Set Flag to ignore SDIO Bus access error during KSO */
+		sdiod->ignore_bus_error = true;
+		chipid = inff_sdiod_readl(sdiod,
+					  bus->ci->ccsec->bus_corebase + SD_REG(chipid),
+					  &ret);
+		/* Clear Flag to ignore SDIO Bus access error during KSO */
+		sdiod->ignore_bus_error = false;
+		inff_dbg(SDIO, "chipid: 0x%x ret = 0x%x\n", chipid, ret);
+	}
+
+	sdio_retune_release(bus->sdiodev->func1);
+
+	if (kso_loop_time > KSO_MAX_SEQ_TIME_NS)
+		inff_err("ERR: KSO=%d sequence took %luns > expected %uns try_cnt=%d\n"
+			  "err_cnt=%d rd_val=0x%x err=%d\n",
+			   on, kso_loop_time, KSO_MAX_SEQ_TIME_NS, try_cnt, err_cnt, rd_val, err);
+
+	inff_dbg(SDIO, "INFO: KSO=%d try_cnt=%d err_cnt=%d kso_seq_time=%luns\n"
+			"rd_val=0x%x err=%d\n", on, try_cnt, err_cnt, kso_loop_time, rd_val, err);
+
+	sdio_retune_crc_enable(bus->sdiodev->func1);
+
+	return err;
+}
+
+#define HOSTINTMASK		(I_HMB_SW_MASK | I_CHIPACTIVE)
+
+/* Turn backplane clock on or off */
+static int inff_sdio_htclk(struct inff_sdio *bus, bool on, bool pendok)
+{
+	int err;
+	u8 clkctl, clkreq, devctl;
+	unsigned long timeout;
+
+	inff_dbg(SDIO, "Enter\n");
+
+	clkctl = 0;
+
+	if (bus->sr_enabled) {
+		bus->clkstate = (on ? CLK_AVAIL : CLK_SDONLY);
+		return 0;
+	}
+
+	if (on) {
+		/* Request HT Avail */
+		clkreq =
+		    bus->alp_only ? SBSDIO_ALP_AVAIL_REQ : SBSDIO_HT_AVAIL_REQ;
+
+		inff_sdiod_writeb(bus->sdiodev, SBSDIO_FUNC1_CHIPCLKCSR,
+				  clkreq, &err);
+		if (err) {
+			inff_err("HT Avail request error: %d\n", err);
+			return -EBADE;
+		}
+
+		/* Check current status */
+		clkctl = inff_sdiod_readb(bus->sdiodev,
+					  SBSDIO_FUNC1_CHIPCLKCSR, &err);
+		if (err) {
+			inff_err("HT Avail read error: %d\n", err);
+			return -EBADE;
+		}
+
+		/* Go to pending and await interrupt if appropriate */
+		if (!SBSDIO_CLKAV(clkctl, bus->alp_only) && pendok) {
+			/* Allow only clock-available interrupt */
+			devctl = inff_sdiod_readb(bus->sdiodev,
+						  SBSDIO_DEVICE_CTL, &err);
+			if (err) {
+				inff_err("Devctl error setting CA: %d\n", err);
+				return -EBADE;
+			}
+
+			devctl |= SBSDIO_DEVCTL_CA_INT_ONLY;
+			inff_sdiod_writeb(bus->sdiodev, SBSDIO_DEVICE_CTL,
+					  devctl, &err);
+			inff_dbg(SDIO, "CLKCTL: set PENDING\n");
+			bus->clkstate = CLK_PENDING;
+
+			return 0;
+		} else if (bus->clkstate == CLK_PENDING) {
+			/* Cancel CA-only interrupt filter */
+			devctl = inff_sdiod_readb(bus->sdiodev,
+						  SBSDIO_DEVICE_CTL, &err);
+			devctl &= ~SBSDIO_DEVCTL_CA_INT_ONLY;
+			inff_sdiod_writeb(bus->sdiodev, SBSDIO_DEVICE_CTL,
+					  devctl, &err);
+		}
+
+		/* Otherwise, wait here (polling) for HT Avail */
+		timeout = jiffies +
+			  msecs_to_jiffies(PMU_MAX_TRANSITION_DLY / 1000);
+		while (!SBSDIO_CLKAV(clkctl, bus->alp_only)) {
+			clkctl = inff_sdiod_readb(bus->sdiodev,
+						  SBSDIO_FUNC1_CHIPCLKCSR,
+						  &err);
+			if (time_after(jiffies, timeout))
+				break;
+
+			usleep_range(5000, 10000);
+		}
+		if (err) {
+			inff_err("HT Avail request error: %d\n", err);
+			return -EBADE;
+		}
+		if (!SBSDIO_CLKAV(clkctl, bus->alp_only)) {
+			inff_err("HT Avail timeout (%d): clkctl 0x%02x\n",
+				 PMU_MAX_TRANSITION_DLY, clkctl);
+			return -EBADE;
+		}
+
+		/* Mark clock available */
+		bus->clkstate = CLK_AVAIL;
+		inff_dbg(SDIO, "CLKCTL: turned ON\n");
+
+#if defined(DEBUG)
+		if (!bus->alp_only) {
+			if (SBSDIO_ALPONLY(clkctl))
+				inff_err("HT Clock should be on\n");
+		}
+#endif				/* defined (DEBUG) */
+
+	} else {
+		clkreq = 0;
+
+		if (bus->clkstate == CLK_PENDING) {
+			/* Cancel CA-only interrupt filter */
+			devctl = inff_sdiod_readb(bus->sdiodev,
+						  SBSDIO_DEVICE_CTL, &err);
+			devctl &= ~SBSDIO_DEVCTL_CA_INT_ONLY;
+			inff_sdiod_writeb(bus->sdiodev, SBSDIO_DEVICE_CTL,
+					  devctl, &err);
+		}
+
+		bus->clkstate = CLK_SDONLY;
+		inff_sdiod_writeb(bus->sdiodev, SBSDIO_FUNC1_CHIPCLKCSR,
+				  clkreq, &err);
+		inff_dbg(SDIO, "CLKCTL: turned OFF\n");
+		if (err) {
+			inff_err("Failed access turning clock off: %d\n",
+				 err);
+			return -EBADE;
+		}
+	}
+	return 0;
+}
+
+/**
+ *	inff_sdio_set_sdbus_clk_width - set SD clock enable/disable and sd_mode
+ *	@func: SDIO function attached to host
+ *	@flags: reusing existing mmc->pm_flags to pass idle clk disable/enable or
+ *		change sdbus width through mmc.
+ */
+int inff_sdio_set_sdbus_clk_width(struct inff_sdio *bus, unsigned int flags)
+{
+	struct mmc_host *host;
+	u8 ctrl;
+	int ret = 0;
+
+	if (WARN_ON(!bus))
+		return -EINVAL;
+
+	host = bus->sdiodev->func1->card->host;
+
+	inff_dbg(SDIO, "Enter\n");
+
+	if (flags == SDIO_IDLECLOCK_DIS || flags == SDIO_IDLECLOCK_EN) {
+		/* Switch OFF/ON SD CLOCK in sdio Host Controller */
+		host->pm_caps |= flags;
+		/* Call SDHCI interface function from ops */
+		host->ops->set_ios(host, &host->ios);
+	} else if (flags == SDIO_SDMODE_1BIT || flags == SDIO_SDMODE_4BIT) {
+		ctrl = inff_sdiod_func0_rb(bus->sdiodev, SDIO_CCCR_IF, &ret);
+		/* Check for Error */
+		if (ret)
+			return ret;
+
+		/* Clear first two bits
+		 * 00 - 1 bit wide
+		 * 10 - 4 bit wide
+		 */
+		ctrl &= ~SDIO_BUS_WIDTH_MASK;
+		/* set as 4-bit bus width */
+		if (flags == SDIO_SDMODE_4BIT)
+			ctrl |= SDIO_BUS_WIDTH_4BIT;
+
+		inff_sdiod_func0_wb(bus->sdiodev, SDIO_CCCR_IF, ctrl, &ret);
+		/* Update HOST CTRL register with 1 bit or 4 bit mode */
+		host->pm_caps |= flags;
+		/* Call SDHCI interface function from ops */
+		host->ops->set_ios(host, &host->ios);
+	}
+	return ret;
+}
+
+/* Change idle/active SD state */
+static int inff_sdio_sdclk(struct inff_sdio *bus, bool on)
+{
+	inff_dbg(SDIO, "Enter\n");
+
+	if (bus->idleclock == INFF_IDLE_STOP)
+		inff_sdio_set_sdbus_clk_width(bus, (on ?
+									   SDIO_IDLECLOCK_DIS :
+									   SDIO_IDLECLOCK_EN));
+
+	if (on)
+		bus->clkstate = CLK_SDONLY;
+	else
+		bus->clkstate = CLK_NONE;
+
+	return 0;
+}
+
+/* Transition SD and backplane clock readiness */
+int inff_sdio_clkctl(struct inff_sdio *bus, uint target, bool pendok)
+{
+#ifdef DEBUG
+	uint oldstate = bus->clkstate;
+#endif				/* DEBUG */
+
+	inff_dbg(SDIO, "Enter\n");
+
+	/* Early exit if we're already there */
+	if (bus->clkstate == target)
+		return 0;
+
+	switch (target) {
+	case CLK_AVAIL:
+		/* Make sure SD clock is available */
+		if (bus->clkstate == CLK_NONE)
+			inff_sdio_sdclk(bus, true);
+		/* Now request HT Avail on the backplane */
+		inff_sdio_htclk(bus, true, pendok);
+		break;
+
+	case CLK_SDONLY:
+#ifdef CONFIG_INFFMAC_BT_SHARED_SDIO
+		if (inff_btsdio_is_active(bus->sdiodev->bus_if)) {
+			inff_dbg(SDIO, "BT is active, not switching to CLK_SDONLY\n");
+			inff_sdio_wd_timer(bus, true);
+			break;
+		}
+#endif /* CONFIG_INFFMAC_BT_SHARED_SDIO */
+		/* Remove HT request, or bring up SD clock */
+		if (bus->clkstate == CLK_NONE)
+			inff_sdio_sdclk(bus, true);
+		else if (bus->clkstate == CLK_AVAIL)
+			inff_sdio_htclk(bus, false, false);
+		else
+			inff_err("request for %d -> %d\n",
+				 bus->clkstate, target);
+		break;
+
+	case CLK_NONE:
+#ifdef CONFIG_INFFMAC_BT_SHARED_SDIO
+		if (inff_btsdio_is_active(bus->sdiodev->bus_if)) {
+			inff_dbg(SDIO, "BT is active, not switching to CLK_NONE\n");
+			break;
+		}
+#endif /* CONFIG_INFFMAC_BT_SHARED_SDIO */
+
+		/* Make sure to remove HT request */
+		if (bus->clkstate == CLK_AVAIL)
+			inff_sdio_htclk(bus, false, false);
+		/* Now remove the SD clock */
+		inff_sdio_sdclk(bus, false);
+		break;
+	}
+#ifdef DEBUG
+	inff_dbg(SDIO, "%d -> %d\n", oldstate, bus->clkstate);
+#endif				/* DEBUG */
+
+	return 0;
+}
+
+static int
+inff_sdio_bus_sleep(struct inff_sdio *bus, bool sleep, bool pendok)
+{
+	int err = 0;
+	u8 clkcsr;
+
+#ifdef CONFIG_INFFMAC_BT_SHARED_SDIO
+	/* The following is the assumption based on which the hook is placed.
+	 * From WLAN driver, either from the active contexts OR from the
+	 * watchdog contexts, we will be attempting to go to sleep. At that
+	 * moment if we see that BT is still actively using the bus, we will
+	 * return -EBUSY from here, and the bus sleep state would not have
+	 * changed, so the caller can then schedule the watchdog again
+	 * which will come and attempt to sleep at a later point.
+	 *
+	 * In case if BT is the only one and is the last user, we don't switch
+	 * off the clock immediately, we allow the WLAN to decide when to sleep
+	 * i.e from the watchdog.
+	 * Now if the watchdog becomes active and attempts to switch off the
+	 * clock and if another WLAN context is active they are any way
+	 * serialized with sdlock.
+	 */
+	if (sleep && inff_btsdio_is_active(bus->sdiodev->bus_if)) {
+		inff_dbg(SDIO, "Bus cannot sleep when BT is active\n");
+		return -EBUSY;
+	}
+#endif /* CONFIG_INFFMAC_BT_SHARED_SDIO */
+
+	if (bus->ci->socitype == SOCI_CP) {
+		inff_dbg(SDIO, "CP chip don't support sleep yet\n");
+		return -ENODEV;
+	}
+
+	inff_dbg(SDIO, "Enter: request %s currently %s\n",
+		 (sleep ? "SLEEP" : "WAKE"),
+		 (bus->sleeping ? "SLEEP" : "WAKE"));
+
+	/* If SR is enabled control bus state with KSO */
+	if (bus->sr_enabled) {
+		/* Done if we're already in the requested state */
+		if (sleep == bus->sleeping)
+			goto end;
+
+		/* Going to sleep */
+		if (sleep) {
+			clkcsr = inff_sdiod_readb(bus->sdiodev,
+						  SBSDIO_FUNC1_CHIPCLKCSR,
+						  &err);
+			if ((clkcsr & SBSDIO_CSR_MASK) == 0) {
+				inff_dbg(SDIO, "no clock, set ALP\n");
+				inff_sdiod_writeb(bus->sdiodev,
+						  SBSDIO_FUNC1_CHIPCLKCSR,
+						  SBSDIO_ALP_AVAIL_REQ, &err);
+			}
+
+			err = inff_sdio_kso_control(bus, false);
+
+			if (bus->idleclock == INFF_IDLE_STOP)
+				inff_sdio_sdclk(bus, false);
+		} else {
+			if (bus->idleclock == INFF_IDLE_STOP && bus->clkstate == CLK_NONE)
+				inff_sdio_clkctl(bus, CLK_SDONLY, false);
+
+			err = inff_sdio_kso_control(bus, true);
+		}
+		if (err) {
+			inff_err("error while changing bus sleep state %d\n",
+				 err);
+			goto done;
+		}
+	}
+
+end:
+	/* control clocks */
+	if (sleep) {
+		if (!bus->sr_enabled)
+			inff_sdio_clkctl(bus, CLK_NONE, pendok);
+	} else {
+		inff_sdio_clkctl(bus, CLK_AVAIL, pendok);
+		inff_sdio_wd_timer(bus, true);
+	}
+	bus->sleeping = sleep;
+	inff_dbg(SDIO, "new state %s\n",
+		 (sleep ? "SLEEP" : "WAKE"));
+done:
+	inff_dbg(SDIO, "Exit: err=%d\n", err);
+	return err;
+}
+
+#ifdef DEBUG
+static inline bool inff_sdio_valid_shared_address(u32 addr)
+{
+	return !(addr == 0 || ((~addr >> 16) & 0xffff) == (addr & 0xffff));
+}
+
+static int inff_sdio_readshared(struct inff_sdio *bus,
+				struct sdpcm_shared *sh)
+{
+	u32 addr = 0;
+	int rv;
+	u32 shaddr = 0;
+	struct sdpcm_shared_le sh_le;
+	__le32 addr_le;
+
+	sdio_claim_host(bus->sdiodev->func1);
+	inff_sdio_bus_sleep(bus, false, false);
+
+	/*
+	 * Read last word in socram to determine
+	 * address of sdpcm_shared structure
+	 *
+	 * In 43022:secure-mode shared console address will be present at
+	 * (512KB-4) location because other RAM area will be Read-blocked
+	 * for host. Host can only read/write (384Kb-512Kb) RAM area.
+	 * Read block is controlled by OTP bit.
+	 */
+	if (bus->ci->chip == INF_CC_43022_CHIP_ID) {
+		shaddr = bus->ci->rambase + CM3_SOCRAM_WRITE_END_LOCATION - 4;
+	} else {
+		shaddr = bus->ci->rambase + bus->ci->ramsize - 4;
+		/* can't access PMU register in 43022 and bus->ci->srsize is zero
+		 * for 43022. So, skip the below statement for 43022.
+		 */
+		if (!bus->ci->rambase && inff_chip_sr_capable(bus->ci))
+			shaddr -= bus->ci->srsize;
+	}
+
+	rv = inff_sdiod_ramrw(bus->sdiodev, false, shaddr,
+			      (u8 *)&addr_le, 4);
+	if (rv < 0)
+		goto fail;
+
+	/*
+	 * Check if addr is valid.
+	 * NVRAM length at the end of memory should have been overwritten.
+	 */
+	addr = le32_to_cpu(addr_le);
+	if (!inff_sdio_valid_shared_address(addr)) {
+		inff_err("invalid sdpcm_shared address 0x%08X\n", addr);
+		rv = -EINVAL;
+		goto fail;
+	}
+
+	inff_dbg(INFO, "sdpcm_shared address 0x%08X\n", addr);
+
+	/* Read hndrte_shared structure */
+	rv = inff_sdiod_ramrw(bus->sdiodev, false, addr, (u8 *)&sh_le,
+			      sizeof(struct sdpcm_shared_le));
+	if (rv < 0)
+		goto fail;
+
+	sdio_release_host(bus->sdiodev->func1);
+
+	/* Endianness */
+	sh->flags = le32_to_cpu(sh_le.flags);
+	sh->trap_addr = le32_to_cpu(sh_le.trap_addr);
+	sh->assert_exp_addr = le32_to_cpu(sh_le.assert_exp_addr);
+	sh->assert_file_addr = le32_to_cpu(sh_le.assert_file_addr);
+	sh->assert_line = le32_to_cpu(sh_le.assert_line);
+	sh->console_addr = le32_to_cpu(sh_le.console_addr);
+	sh->msgtrace_addr = le32_to_cpu(sh_le.msgtrace_addr);
+
+	inff_dbg(INFO, "rte_console address is  is 0x%08x\n", sh->console_addr);
+
+	if ((sh->flags & SDPCM_SHARED_VERSION_MASK) > SDPCM_SHARED_VERSION) {
+		inff_err("sdpcm_shared version %d unsupported, drivers expects version <= %d\n",
+			 sh->flags & SDPCM_SHARED_VERSION_MASK,
+			 SDPCM_SHARED_VERSION);
+		return -EPROTO;
+	}
+	return 0;
+
+fail:
+	inff_err("unable to obtain sdpcm_shared info: rv=%d (addr=0x%x)\n",
+		 rv, addr);
+	sdio_release_host(bus->sdiodev->func1);
+	return rv;
+}
+
+static void inff_sdio_get_console_addr(struct inff_sdio *bus)
+{
+	struct sdpcm_shared sh;
+
+	if (inff_sdio_readshared(bus, &sh) == 0) {
+		/* reset the last read count when buffer address is updated */
+		bus->console.last = 0;
+		bus->console_addr = sh.console_addr;
+	}
+}
+#else
+static void inff_sdio_get_console_addr(struct inff_sdio *bus)
+{
+}
+#endif /* DEBUG */
+
+static u32 inff_sdio_hostmail(struct inff_sdio *bus, u32 *hmbd)
+{
+	struct inff_sdio_dev *sdiod = bus->sdiodev;
+	struct inff_core *core = bus->sdio_core;
+	u32 intstatus = 0;
+	u32 hmb_data;
+	u8 fcbits;
+	int ret;
+
+	inff_dbg(SDIO, "Enter\n");
+
+	/* Read mailbox data and ack that we did so */
+	hmb_data = inff_sdiod_readl(sdiod,
+				    core->base + SD_REG(tohostmailboxdata),
+				    &ret);
+	/* skip generating SMB_INT_ACK if there is no MB data */
+	if (!ret && hmb_data)
+		inff_sdiod_writel(sdiod, core->base + SD_REG(tosbmailbox),
+				  SMB_INT_ACK, &ret);
+
+	bus->sdcnt.f1regdata += 2;
+
+	/* dongle indicates the firmware has halted/crashed */
+	if (hmb_data & HMB_DATA_FWHALT) {
+		inff_dbg(SDIO, "mailbox indicates firmware halted\n");
+		inff_fw_crashed(&sdiod->func1->dev);
+	}
+
+	/* Dongle recomposed rx frames, accept them again */
+	if (hmb_data & HMB_DATA_NAKHANDLED) {
+		inff_dbg(SDIO, "Dongle reports NAK handled, expect rtx of %d\n",
+			 bus->rx_seq);
+		if (!bus->rxskip)
+			inff_err("unexpected NAKHANDLED!\n");
+
+		bus->rxskip = false;
+		intstatus |= I_HMB_FRAME_IND;
+	}
+
+	/*
+	 * DEVREADY does not occur with gSPI.
+	 */
+	if (hmb_data & (HMB_DATA_DEVREADY | HMB_DATA_FWREADY)) {
+		bus->sdpcm_ver =
+		    (hmb_data & HMB_DATA_VERSION_MASK) >>
+		    HMB_DATA_VERSION_SHIFT;
+		if (bus->sdpcm_ver != SDPCM_PROT_VERSION)
+			inff_err("ver mismatch, %d, expecting %d, hmb_data 0x%x\n",
+				 bus->sdpcm_ver, SDPCM_PROT_VERSION, hmb_data);
+		else
+			inff_dbg(SDIO, "Dongle ready, protocol version %d\n",
+				 bus->sdpcm_ver);
+
+		/*
+		 * Retrieve console state address now that firmware should have
+		 * updated it.
+		 */
+		inff_sdio_get_console_addr(bus);
+	}
+
+	/*
+	 * Flow Control has been moved into the RX headers and this out of band
+	 * method isn't used any more.
+	 * remaining backward compatible with older dongles.
+	 */
+	if (hmb_data & HMB_DATA_FC) {
+		fcbits = (hmb_data & HMB_DATA_FCDATA_MASK) >>
+							HMB_DATA_FCDATA_SHIFT;
+
+		if (fcbits & ~bus->flowcontrol)
+			bus->sdcnt.fc_xoff++;
+
+		if (bus->flowcontrol & ~fcbits)
+			bus->sdcnt.fc_xon++;
+
+		bus->sdcnt.fc_rcvd++;
+		bus->flowcontrol = fcbits;
+	}
+
+	/* Shouldn't be any others */
+	if (hmb_data & ~(HMB_DATA_DEVREADY |
+			 HMB_DATA_NAKHANDLED |
+			 HMB_DATA_FC |
+			 HMB_DATA_FWREADY |
+			 HMB_DATA_FWHALT |
+			 HMB_DATA_FCDATA_MASK | HMB_DATA_VERSION_MASK))
+		inff_err("Unknown mailbox data content: 0x%02x\n",
+			 hmb_data);
+	/* Populate hmb_data if argument is passed for DS1 check later */
+	if (hmbd)
+		*hmbd = hmb_data;
+
+	return intstatus;
+}
+
+static void inff_sdio_rxfail(struct inff_sdio *bus, bool abort, bool rtx)
+{
+	struct inff_sdio_dev *sdiod = bus->sdiodev;
+	struct inff_core *core = bus->sdio_core;
+	uint retries = 0;
+	u16 lastrbc;
+	u8 hi, lo;
+	int err;
+
+	inff_err("%sterminate frame%s\n",
+		 abort ? "abort command, " : "",
+		 rtx ? ", send NAK" : "");
+
+	if (abort)
+		inff_sdiod_abort(bus->sdiodev, bus->sdiodev->func2);
+
+	inff_sdiod_writeb(bus->sdiodev, SBSDIO_FUNC1_FRAMECTRL, SFC_RF_TERM,
+			  &err);
+	bus->sdcnt.f1regdata++;
+
+	/* Wait until the packet has been flushed (device/FIFO stable) */
+	for (lastrbc = retries = 0xffff; retries > 0; retries--) {
+		hi = inff_sdiod_readb(bus->sdiodev, SBSDIO_FUNC1_RFRAMEBCHI,
+				      &err);
+		lo = inff_sdiod_readb(bus->sdiodev, SBSDIO_FUNC1_RFRAMEBCLO,
+				      &err);
+		bus->sdcnt.f1regdata += 2;
+
+		if (hi == 0 && lo == 0)
+			break;
+
+		if ((hi > (lastrbc >> 8)) && (lo > (lastrbc & 0x00ff))) {
+			inff_err("count growing: last 0x%04x now 0x%04x\n",
+				 lastrbc, (hi << 8) + lo);
+		}
+		lastrbc = (hi << 8) + lo;
+	}
+
+	if (!retries)
+		inff_err("count never zeroed: last 0x%04x\n", lastrbc);
+	else
+		inff_dbg(SDIO, "flush took %d iterations\n", 0xffff - retries);
+
+	if (rtx) {
+		bus->sdcnt.rxrtx++;
+		inff_sdiod_writel(sdiod, core->base + SD_REG(tosbmailbox),
+				  SMB_NAK, &err);
+
+		bus->sdcnt.f1regdata++;
+		if (err == 0)
+			bus->rxskip = true;
+	}
+
+	/* Clear partial in any case */
+	bus->cur_read.len = 0;
+}
+
+static void inff_sdio_txfail(struct inff_sdio *bus)
+{
+	struct inff_sdio_dev *sdiodev = bus->sdiodev;
+	u8 i, hi, lo;
+
+	/* On failure, abort the command and terminate the frame */
+	inff_err("sdio error, abort command and terminate frame\n");
+	bus->sdcnt.tx_sderrs++;
+
+	inff_sdiod_abort(sdiodev, sdiodev->func2);
+	inff_sdiod_writeb(sdiodev, SBSDIO_FUNC1_FRAMECTRL, SFC_WF_TERM, NULL);
+	bus->sdcnt.f1regdata++;
+
+	for (i = 0; i < 3; i++) {
+		hi = inff_sdiod_readb(sdiodev, SBSDIO_FUNC1_WFRAMEBCHI, NULL);
+		lo = inff_sdiod_readb(sdiodev, SBSDIO_FUNC1_WFRAMEBCLO, NULL);
+		bus->sdcnt.f1regdata += 2;
+		if (hi == 0 && lo == 0)
+			break;
+	}
+}
+
+/* return total length of buffer chain */
+static uint inff_sdio_glom_len(struct inff_sdio *bus)
+{
+	struct sk_buff *p;
+	uint total;
+
+	total = 0;
+	skb_queue_walk(&bus->glom, p)
+		total += p->len;
+	return total;
+}
+
+static void inff_sdio_free_glom(struct inff_sdio *bus)
+{
+	struct sk_buff *cur, *next;
+
+	skb_queue_walk_safe(&bus->glom, cur, next) {
+		skb_unlink(cur, &bus->glom);
+		inff_pkt_buf_free_skb(cur);
+	}
+}
+
+/*
+ * inffmac sdio bus specific header
+ * This is the lowest layer header wrapped on the packets transmitted between
+ * host and WiFi dongle which contains information needed for SDIO core and
+ * firmware
+ *
+ * It consists of 3 parts: hardware header, hardware extension header and
+ * software header
+ * hardware header (frame tag) - 4 bytes
+ * Byte 0~1: Frame length
+ * Byte 2~3: Checksum, bit-wise inverse of frame length
+ * hardware extension header - 8 bytes
+ * Tx glom mode only, N/A for Rx or normal Tx
+ * Byte 0~1: Packet length excluding hw frame tag
+ * Byte 2: Reserved
+ * Byte 3: Frame flags, bit 0: last frame indication
+ * Byte 4~5: Reserved
+ * Byte 6~7: Tail padding length
+ * software header - 8 bytes
+ * Byte 0: Rx/Tx sequence number
+ * Byte 1: 4 MSB Channel number, 4 LSB arbitrary flag
+ * Byte 2: Length of next data frame, reserved for Tx
+ * Byte 3: Data offset
+ * Byte 4: Flow control bits, reserved for Tx
+ * Byte 5: Maximum Sequence number allowed by firmware for Tx, N/A for Tx packet
+ * Byte 6~7: Reserved
+ */
+#define SDPCM_HWHDR_LEN			4
+#define SDPCM_HWEXT_LEN			8
+#define SDPCM_SWHDR_LEN			8
+#define SDPCM_HDRLEN			(SDPCM_HWHDR_LEN + SDPCM_SWHDR_LEN)
+/* software header */
+#define SDPCM_SEQ_MASK			0x000000ff
+#define SDPCM_SEQ_WRAP			256
+#define SDPCM_CHANNEL_MASK		0x00000f00
+#define SDPCM_CHANNEL_SHIFT		8
+#define SDPCM_CONTROL_CHANNEL		0	/* Control */
+#define SDPCM_EVENT_CHANNEL		1	/* Asyc Event Indication */
+#define SDPCM_DATA_CHANNEL		2	/* Data Xmit/Recv */
+#define SDPCM_GLOM_CHANNEL		3	/* Coalesced packets */
+#define SDPCM_TEST_CHANNEL		15	/* Test/debug packets */
+#define SDPCM_GLOMDESC(p)		(((u8 *)p)[1] & 0x80)
+#define SDPCM_NEXTLEN_MASK		0x00ff0000
+#define SDPCM_NEXTLEN_SHIFT		16
+#define SDPCM_DOFFSET_MASK		0xff000000
+#define SDPCM_DOFFSET_SHIFT		24
+#define SDPCM_FCMASK_MASK		0x000000ff
+#define SDPCM_WINDOW_MASK		0x0000ff00
+#define SDPCM_WINDOW_SHIFT		8
+
+static inline u8 inff_sdio_getdatoffset(u8 *swheader)
+{
+	u32 hdrvalue;
+
+	hdrvalue = le32_to_cpu(*(__le32 *)swheader);
+	return (u8)((hdrvalue & SDPCM_DOFFSET_MASK) >> SDPCM_DOFFSET_SHIFT);
+}
+
+static inline bool inff_sdio_fromevntchan(u8 *swheader)
+{
+	u32 hdrvalue;
+	u8 ret;
+
+	hdrvalue = le32_to_cpu(*(__le32 *)swheader);
+	ret = (u8)((hdrvalue & SDPCM_CHANNEL_MASK) >> SDPCM_CHANNEL_SHIFT);
+
+	return (ret == SDPCM_EVENT_CHANNEL);
+}
+
+static int inff_sdio_hdparse(struct inff_sdio *bus, u8 *header,
+			     struct inff_sdio_hdrinfo *rd,
+			      enum inff_sdio_frmtype type)
+{
+	u16 len, checksum;
+	u8 rx_seq, fc, tx_seq_max;
+	u32 swheader;
+
+	trace_inff_sdpcm_hdr(SDPCM_RX, header);
+
+	/* hw header */
+	len = get_unaligned_le16(header);
+	checksum = get_unaligned_le16(header + sizeof(u16));
+	/* All zero means no more to read */
+	if (!(len | checksum)) {
+		bus->rxpending = false;
+		return -ENODATA;
+	}
+	if ((u16)(~(len ^ checksum))) {
+		inff_err("HW header checksum error\n");
+		bus->sdcnt.rx_badhdr++;
+		inff_sdio_rxfail(bus, false, false);
+		return -EIO;
+	}
+	if (len < SDPCM_HDRLEN) {
+		inff_err("HW header length error\n");
+		return -EPROTO;
+	}
+	if (type == INFF_SDIO_FT_SUPER &&
+	    (roundup(len, bus->blocksize) != rd->len)) {
+		inff_err("HW superframe header length error\n");
+		return -EPROTO;
+	}
+	if (type == INFF_SDIO_FT_SUB && len > rd->len) {
+		inff_err("HW subframe header length error\n");
+		return -EPROTO;
+	}
+	rd->len = len;
+
+	/* software header */
+	header += SDPCM_HWHDR_LEN;
+	swheader = le32_to_cpu(*(__le32 *)header);
+	if (type == INFF_SDIO_FT_SUPER && SDPCM_GLOMDESC(header)) {
+		inff_err("Glom descriptor found in superframe head\n");
+		rd->len = 0;
+		return -EINVAL;
+	}
+	rx_seq = (u8)(swheader & SDPCM_SEQ_MASK);
+	rd->channel = (swheader & SDPCM_CHANNEL_MASK) >> SDPCM_CHANNEL_SHIFT;
+	if (len > MAX_RX_DATASZ && rd->channel != SDPCM_CONTROL_CHANNEL &&
+	    type != INFF_SDIO_FT_SUPER) {
+		inff_err("HW header length too long\n");
+		bus->sdcnt.rx_toolong++;
+		inff_sdio_rxfail(bus, false, false);
+		rd->len = 0;
+		return -EPROTO;
+	}
+	if (type == INFF_SDIO_FT_SUPER && rd->channel != SDPCM_GLOM_CHANNEL) {
+		inff_err("Wrong channel for superframe\n");
+		rd->len = 0;
+		return -EINVAL;
+	}
+	if (type == INFF_SDIO_FT_SUB && rd->channel != SDPCM_DATA_CHANNEL &&
+	    rd->channel != SDPCM_EVENT_CHANNEL) {
+		inff_err("Wrong channel for subframe\n");
+		rd->len = 0;
+		return -EINVAL;
+	}
+	rd->dat_offset = inff_sdio_getdatoffset(header);
+	if (rd->dat_offset < SDPCM_HDRLEN || rd->dat_offset > rd->len) {
+		inff_err("seq %d: bad data offset\n", rx_seq);
+		bus->sdcnt.rx_badhdr++;
+		inff_sdio_rxfail(bus, false, false);
+		rd->len = 0;
+		return -ENXIO;
+	}
+	if (rd->seq_num != rx_seq) {
+		inff_dbg(SDIO, "seq %d, expected %d\n", rx_seq, rd->seq_num);
+		bus->sdcnt.rx_badseq++;
+		rd->seq_num = rx_seq;
+	}
+	/* no need to check the reset for subframe */
+	if (type == INFF_SDIO_FT_SUB)
+		return 0;
+	rd->len_nxtfrm = (swheader & SDPCM_NEXTLEN_MASK) >> SDPCM_NEXTLEN_SHIFT;
+	if (rd->len_nxtfrm << 4 > MAX_RX_DATASZ) {
+		/* only warm for NON glom packet */
+		if (rd->channel != SDPCM_GLOM_CHANNEL)
+			inff_err("seq %d: next length error\n", rx_seq);
+		rd->len_nxtfrm = 0;
+	}
+	swheader = le32_to_cpu(*(__le32 *)(header + 4));
+	fc = swheader & SDPCM_FCMASK_MASK;
+	if (bus->flowcontrol != fc) {
+		if (~bus->flowcontrol & fc)
+			bus->sdcnt.fc_xoff++;
+		if (bus->flowcontrol & ~fc)
+			bus->sdcnt.fc_xon++;
+		bus->sdcnt.fc_rcvd++;
+		bus->flowcontrol = fc;
+	}
+	tx_seq_max = (swheader & SDPCM_WINDOW_MASK) >> SDPCM_WINDOW_SHIFT;
+	if ((u8)(tx_seq_max - bus->tx_seq) > 0x40) {
+		inff_err("seq %d: max tx seq number error\n", rx_seq);
+		tx_seq_max = bus->tx_seq + 2;
+	}
+	bus->tx_max = tx_seq_max;
+
+	return 0;
+}
+
+static inline void inff_sdio_update_hwhdr(u8 *header, u16 frm_length)
+{
+	*(__le16 *)header = cpu_to_le16(frm_length);
+	*(((__le16 *)header) + 1) = cpu_to_le16(~frm_length);
+}
+
+static void inff_sdio_hdpack(struct inff_sdio *bus, u8 *header,
+			     struct inff_sdio_hdrinfo *hd_info)
+{
+	u32 hdrval;
+	u8 hdr_offset;
+
+	inff_sdio_update_hwhdr(header, hd_info->len);
+	hdr_offset = SDPCM_HWHDR_LEN;
+
+	if (bus->txglom) {
+		hdrval = (hd_info->len - hdr_offset) | (hd_info->lastfrm << 24);
+		*((__le32 *)(header + hdr_offset)) = cpu_to_le32(hdrval);
+		hdrval = (u16)hd_info->tail_pad << 16;
+		*(((__le32 *)(header + hdr_offset)) + 1) = cpu_to_le32(hdrval);
+		hdr_offset += SDPCM_HWEXT_LEN;
+	}
+
+	hdrval = hd_info->seq_num;
+	hdrval |= (hd_info->channel << SDPCM_CHANNEL_SHIFT) &
+		  SDPCM_CHANNEL_MASK;
+	hdrval |= (hd_info->dat_offset << SDPCM_DOFFSET_SHIFT) &
+		  SDPCM_DOFFSET_MASK;
+	*((__le32 *)(header + hdr_offset)) = cpu_to_le32(hdrval);
+	*(((__le32 *)(header + hdr_offset)) + 1) = 0;
+	trace_inff_sdpcm_hdr(SDPCM_TX + !!(bus->txglom), header);
+}
+
+static inline int inff_rxf_enqueue(struct inff_sdio *bus, struct sk_buff *skb)
+{
+	u32 store_idx;
+	u32 sent_idx;
+
+	if (!skb) {
+		inff_err("NULL skb!!!\n");
+		return -EINVAL;
+	}
+
+	spin_lock_bh(&bus->rxf_lock);
+	store_idx = bus->store_idx;
+	sent_idx = bus->sent_idx;
+	if (bus->skbbuf[store_idx]) {
+		/* Make sure the previous packets are processed */
+		spin_unlock_bh(&bus->rxf_lock);
+		inff_err("pktbuf not consumed %p, store idx %d sent idx %d\n",
+			 skb, store_idx, sent_idx);
+		msleep(1000);
+		return -EINVAL;
+	}
+	inff_dbg(DATA, "Store SKB %p. idx %d -> %d\n",
+		 skb, store_idx, (store_idx + 1) & (MAXSKBPEND - 1));
+	bus->skbbuf[store_idx] = skb;
+	bus->store_idx = (store_idx + 1) & (MAXSKBPEND - 1);
+	spin_unlock_bh(&bus->rxf_lock);
+
+	return 0;
+}
+
+static struct sk_buff *inff_rxf_dequeue(struct inff_sdio *bus)
+{
+	u32 store_idx;
+	u32 sent_idx;
+	struct sk_buff *skb;
+
+	spin_lock_bh(&bus->rxf_lock);
+
+	store_idx = bus->store_idx;
+	sent_idx = bus->sent_idx;
+	skb = bus->skbbuf[sent_idx];
+
+	if (!skb) {
+		spin_unlock_bh(&bus->rxf_lock);
+		inff_err("Dequeued packet is NULL, store idx %d sent idx %d\n",
+			 store_idx, sent_idx);
+		return NULL;
+	}
+
+	bus->skbbuf[sent_idx] = NULL;
+	bus->sent_idx = (sent_idx + 1) & (MAXSKBPEND - 1);
+
+	inff_dbg(DATA, "dequeue (%p), sent idx %d\n",
+		 skb, sent_idx);
+
+	spin_unlock_bh(&bus->rxf_lock);
+
+	return skb;
+}
+
+static u8 inff_sdio_rxglom(struct inff_sdio *bus, u8 rxseq)
+{
+	u16 dlen, totlen;
+	u8 *dptr, num = 0;
+	u16 sublen;
+	struct sk_buff *pfirst, *pnext;
+	struct sk_buff *skb_head = NULL, *skb_prev = NULL, *skb_to_rxfq = NULL;
+	int errcode;
+	u8 doff;
+	struct inff_sdio_hdrinfo rd_new;
+	struct inff_mp_device *settings = bus->sdiodev->settings;
+
+	/* If packets, issue read(s) and send up packet chain */
+	/* Return sequence numbers consumed? */
+
+	inff_dbg(SDIO, "start: glomd %p glom %p\n",
+		 bus->glomd, skb_peek(&bus->glom));
+
+	/* If there's a descriptor, generate the packet chain */
+	if (bus->glomd) {
+		pfirst = NULL;
+		pnext = NULL;
+		/* it is a u32 len to u16 dlen, should have a sanity check here. */
+		if (bus->glomd->len <= 0xFFFF) {
+			dlen = (u16)(bus->glomd->len);
+			if (!dlen || (dlen & 1)) {
+				inff_err("bad glomd len(%d), ignore descriptor\n",
+					 dlen);
+				dlen = 0;
+			}
+		} else {
+			inff_err("overflowed glomd len(%d), ignore descriptor\n",
+				 bus->glomd->len);
+			dlen = 0;
+		}
+		dptr = bus->glomd->data;
+
+		for (totlen = num = 0; dlen; num++) {
+			/* Get (and move past) next length */
+			sublen = get_unaligned_le16(dptr);
+			dlen -= sizeof(u16);
+			dptr += sizeof(u16);
+			if (sublen < SDPCM_HDRLEN ||
+			    (num == 0 && (sublen < (2 * SDPCM_HDRLEN)))) {
+				inff_err("descriptor len %d bad: %d\n",
+					 num, sublen);
+				pnext = NULL;
+				break;
+			}
+			if (sublen % bus->sgentry_align) {
+				inff_err("sublen %d not multiple of %d\n",
+					 sublen, bus->sgentry_align);
+			}
+			totlen += sublen;
+
+			/* For last frame, adjust read len so total
+			 * is a block multiple
+			 */
+			if (!dlen) {
+				sublen +=
+				    (roundup(totlen, bus->blocksize) - totlen);
+				totlen = roundup(totlen, bus->blocksize);
+			}
+
+			/* Allocate/chain packet for next subframe */
+			pnext = inff_pkt_buf_get_skb(sublen + bus->sgentry_align);
+			if (!pnext) {
+				inff_err("inff_pkt_buf_get_skb failed, num %d len %d\n",
+					 num, sublen);
+				break;
+			}
+			skb_queue_tail(&bus->glom, pnext);
+
+			/* Adhere to start alignment requirements */
+			pkt_align(pnext, sublen, bus->sgentry_align);
+		}
+
+		/* If all allocations succeeded, save packet chain
+		 * in bus structure
+		 */
+		if (pnext) {
+			inff_dbg(GLOM, "allocated %d-byte packet chain for %d subframes\n",
+				 totlen, num);
+			if (INFF_GLOM_ON() && bus->cur_read.len &&
+			    totlen != bus->cur_read.len) {
+				inff_dbg(GLOM, "glomdesc mismatch: nextlen %d glomdesc %d rxseq %d\n",
+					 bus->cur_read.len, totlen, rxseq);
+			}
+			pfirst = NULL;
+			pnext = NULL;
+		} else {
+			inff_sdio_free_glom(bus);
+			num = 0;
+		}
+
+		/* Done with descriptor packet */
+		inff_pkt_buf_free_skb(bus->glomd);
+		bus->glomd = NULL;
+		bus->cur_read.len = 0;
+	}
+
+	/* Ok -- either we just generated a packet chain,
+	 * or had one from before
+	 */
+	if (!skb_queue_empty(&bus->glom)) {
+		u32 len_glom = 0;
+
+		if (INFF_GLOM_ON()) {
+			inff_dbg(GLOM, "try superframe read, packet chain:\n");
+			skb_queue_walk(&bus->glom, pnext) {
+				inff_dbg(GLOM, "    %p: %p len 0x%04x (%d)\n",
+					 pnext, (u8 *)(pnext->data),
+					 pnext->len, pnext->len);
+			}
+		}
+
+		pfirst = skb_peek(&bus->glom);
+		len_glom = inff_sdio_glom_len(bus);
+		if (len_glom > 0xFFFF) {
+			inff_err("glom_len is %d bytes, overflowed\n",
+				 len_glom);
+			goto frame_error_handle;
+		} else {
+			dlen = (u16)len_glom;
+		}
+
+		/* Do an SDIO read for the superframe.  Configurable iovar to
+		 * read directly into the chained packet, or allocate a large
+		 * packet and copy into the chain.
+		 */
+		sdio_claim_host(bus->sdiodev->func1);
+		errcode = inff_sdiod_recv_chain(bus->sdiodev,
+						&bus->glom, dlen);
+		sdio_release_host(bus->sdiodev->func1);
+		bus->sdcnt.f2rxdata++;
+
+		/* On failure, kill the superframe */
+		if (errcode < 0) {
+			inff_err("glom read of %d bytes failed: %d\n",
+				 dlen, errcode);
+			goto frame_error_handle;
+		}
+
+		inff_dbg_hex_dump(INFF_GLOM_ON(),
+				  pfirst->data, min_t(int, pfirst->len, 48),
+				  "SUPERFRAME:\n");
+
+		rd_new.seq_num = rxseq;
+		rd_new.len = dlen;
+		sdio_claim_host(bus->sdiodev->func1);
+		errcode = inff_sdio_hdparse(bus, pfirst->data, &rd_new,
+					    INFF_SDIO_FT_SUPER);
+		sdio_release_host(bus->sdiodev->func1);
+		bus->cur_read.len = rd_new.len_nxtfrm << 4;
+
+		/* Remove superframe header, remember offset */
+		skb_pull(pfirst, rd_new.dat_offset);
+		num = 0;
+
+		/* Validate all the subframe headers */
+		skb_queue_walk(&bus->glom, pnext) {
+			/* leave when invalid subframe is found */
+			if (errcode)
+				break;
+
+			rd_new.len = pnext->len;
+			rd_new.seq_num = rxseq++;
+			sdio_claim_host(bus->sdiodev->func1);
+			errcode = inff_sdio_hdparse(bus, pnext->data, &rd_new,
+						    INFF_SDIO_FT_SUB);
+			sdio_release_host(bus->sdiodev->func1);
+			inff_dbg_hex_dump(INFF_GLOM_ON(),
+					  pnext->data, 32, "subframe:\n");
+
+			num++;
+		}
+
+		/* Terminate frame on error */
+		if (errcode)
+			goto frame_error_handle;
+
+		/* Basic SD framing looks ok - process each packet (header) */
+
+		skb_queue_walk_safe(&bus->glom, pfirst, pnext) {
+			dptr = (u8 *)(pfirst->data);
+			sublen = get_unaligned_le16(dptr);
+			doff = inff_sdio_getdatoffset(&dptr[SDPCM_HWHDR_LEN]);
+
+			inff_dbg_hex_dump(INFF_BYTES_ON() && INFF_DATA_ON(),
+					  dptr, pfirst->len,
+					  "Rx Subframe Data:\n");
+
+			__skb_trim(pfirst, sublen);
+			skb_pull(pfirst, doff);
+
+			if (pfirst->len == 0) {
+				skb_unlink(pfirst, &bus->glom);
+				inff_pkt_buf_free_skb(pfirst);
+				continue;
+			}
+
+			inff_dbg_hex_dump(INFF_GLOM_ON(),
+					  pfirst->data,
+					  min_t(int, pfirst->len, 32),
+					  "subframe %d to stack, %p (%p/%d) nxt/lnk %p/%p\n",
+					  bus->glom.qlen, pfirst, pfirst->data,
+					  pfirst->len, pfirst->next,
+					  pfirst->prev);
+			skb_unlink(pfirst, &bus->glom);
+			if (inff_sdio_fromevntchan(&dptr[SDPCM_HWHDR_LEN])) {
+				inff_rx_event(bus->sdiodev->dev, pfirst);
+				skb_to_rxfq = NULL;
+			} else {
+				skb_to_rxfq = inff_rx_frame(bus->sdiodev->dev, pfirst,
+							    false, false);
+			}
+
+			if (settings && settings->sdio_rxf_in_kthread_enabled && skb_to_rxfq) {
+				if (!skb_head)
+					skb_head = skb_to_rxfq;
+				else
+					skb_prev->next = skb_to_rxfq;
+
+				skb_prev = skb_to_rxfq;
+			}
+			bus->sdcnt.rxglompkts++;
+		}
+
+		bus->sdcnt.rxglomframes++;
+	}
+
+	if (settings && settings->sdio_rxf_in_kthread_enabled && skb_head)
+		inff_sched_rxf(bus, skb_head);
+
+	return num;
+
+frame_error_handle:
+	sdio_claim_host(bus->sdiodev->func1);
+	inff_sdio_rxfail(bus, true, false);
+	bus->sdcnt.rxglomfail++;
+	inff_sdio_free_glom(bus);
+	sdio_release_host(bus->sdiodev->func1);
+	bus->cur_read.len = 0;
+
+	return 0;
+}
+
+static int inff_sdio_dcmd_resp_wait(struct inff_sdio *bus, uint *condition,
+				    bool *pending)
+{
+	DECLARE_WAITQUEUE(wait, current);
+	int timeout = DCMD_RESP_TIMEOUT;
+
+	/* Wait until control frame is available */
+	add_wait_queue(&bus->dcmd_resp_wait, &wait);
+	set_current_state(TASK_INTERRUPTIBLE);
+
+	while (!(*condition) && (!signal_pending(current) && timeout))
+		timeout = schedule_timeout(timeout);
+
+	if (signal_pending(current))
+		*pending = true;
+
+	set_current_state(TASK_RUNNING);
+	remove_wait_queue(&bus->dcmd_resp_wait, &wait);
+
+	return timeout;
+}
+
+static int inff_sdio_dcmd_resp_wake(struct inff_sdio *bus)
+{
+	wake_up_interruptible(&bus->dcmd_resp_wait);
+
+	return 0;
+}
+
+static void
+inff_sdio_read_control(struct inff_sdio *bus, u8 *hdr, uint len, uint doff)
+{
+	uint rdlen, pad;
+	u8 *buf = NULL, *rbuf;
+	int sdret;
+
+	inff_dbg(SDIO, "Enter\n");
+	if (bus->rxblen)
+		buf = vzalloc(bus->rxblen);
+	if (!buf)
+		goto done;
+
+	rbuf = bus->rxbuf;
+	pad = ((unsigned long)rbuf % bus->head_align);
+	if (pad)
+		rbuf += (bus->head_align - pad);
+
+	/* Copy the already-read portion over */
+	memcpy(buf, hdr, INFF_FIRSTREAD);
+	if (len <= INFF_FIRSTREAD)
+		goto gotpkt;
+
+	/* Raise rdlen to next SDIO block to avoid tail command */
+	rdlen = len - INFF_FIRSTREAD;
+	if (bus->roundup && bus->blocksize && rdlen > bus->blocksize) {
+		pad = bus->blocksize - (rdlen % bus->blocksize);
+		if (pad <= bus->roundup && pad < bus->blocksize &&
+		    ((len + pad) < bus->sdiodev->bus_if->maxctl))
+			rdlen += pad;
+	} else if (rdlen % bus->head_align) {
+		rdlen += bus->head_align - (rdlen % bus->head_align);
+	}
+
+	/* Drop if the read is too big or it exceeds our maximum */
+	if ((rdlen + INFF_FIRSTREAD) > bus->sdiodev->bus_if->maxctl) {
+		inff_err("%d-byte control read exceeds %d-byte buffer\n",
+			 rdlen, bus->sdiodev->bus_if->maxctl);
+		inff_sdio_rxfail(bus, false, false);
+		goto done;
+	}
+
+	if ((len - doff) > bus->sdiodev->bus_if->maxctl) {
+		inff_err("%d-byte ctl frame (%d-byte ctl data) exceeds %d-byte limit\n",
+			 len, len - doff, bus->sdiodev->bus_if->maxctl);
+		bus->sdcnt.rx_toolong++;
+		inff_sdio_rxfail(bus, false, false);
+		goto done;
+	}
+
+	/* Read remain of frame body */
+	sdret = inff_sdiod_recv_buf(bus->sdiodev, SDIO_FUNC_2, rbuf, rdlen);
+	bus->sdcnt.f2rxdata++;
+
+	/* Control frame failures need retransmission */
+	if (sdret < 0) {
+		inff_err("read %d control bytes failed: %d\n",
+			 rdlen, sdret);
+		bus->sdcnt.rxc_errors++;
+		inff_sdio_rxfail(bus, true, true);
+		goto done;
+	} else {
+		memcpy(buf + INFF_FIRSTREAD, rbuf, rdlen);
+	}
+
+gotpkt:
+
+	inff_dbg_hex_dump(INFF_BYTES_ON() && INFF_CTL_ON(),
+			  buf, len, "RxCtrl:\n");
+
+	/* Point to valid data and indicate its length */
+	spin_lock_bh(&bus->rxctl_lock);
+	if (bus->rxctl) {
+		inff_err("last control frame is being processed.\n");
+		spin_unlock_bh(&bus->rxctl_lock);
+		vfree(buf);
+		goto done;
+	}
+	bus->rxctl = buf + doff;
+	bus->rxctl_orig = buf;
+	bus->rxlen = len - doff;
+	spin_unlock_bh(&bus->rxctl_lock);
+
+done:
+	/* Awake any waiters */
+	inff_sdio_dcmd_resp_wake(bus);
+}
+
+/* Pad read to blocksize for efficiency */
+static void inff_sdio_pad(struct inff_sdio *bus, u16 *pad, u16 *rdlen)
+{
+	if (bus->roundup && bus->blocksize && *rdlen > bus->blocksize) {
+		*pad = bus->blocksize - (*rdlen % bus->blocksize);
+		if (*pad <= bus->roundup && *pad < bus->blocksize &&
+		    *rdlen + *pad + INFF_FIRSTREAD < MAX_RX_DATASZ)
+			*rdlen += *pad;
+	} else if (*rdlen % bus->head_align) {
+		*rdlen += bus->head_align - (*rdlen % bus->head_align);
+	}
+}
+
+#ifdef CONFIG_INFFMAC_BT_SHARED_SDIO
+static bool inff_sdio_rx_pkt_is_avail(struct inff_sdio *bus)
+{
+	struct inff_sdio_dev *sdiod = bus->sdiodev;
+	u32 newstatus = 0;
+	u32 intstat_addr = bus->sdio_core->base + SD_REG(intstatus);
+	int err = 0;
+	bool ret = true;
+
+	if (!inff_btsdio_is_active(bus->sdiodev->bus_if))
+		return true;
+
+	/* read interrupt to get fifo status*/
+	newstatus = inff_sdiod_readl(sdiod, intstat_addr, &err);
+	if (err < 0) {
+		inff_err("read int status failed %d\n", err);
+		ret = false;
+	} else if (!(newstatus & I_XMTDATA_AVAIL)) {
+		/* no more frames */
+		inff_dbg(DATA, "no more frames, int status: 0x%08x\n", newstatus);
+		ret = false;
+	}
+
+	return ret;
+}
+#endif /* CONFIG_INFFMAC_BT_SHARED_SDIO */
+
+static uint inff_sdio_readframes(struct inff_sdio *bus, uint maxframes)
+{
+	struct sk_buff *pkt;		/* Packet for event or data frames */
+	u16 pad;		/* Number of pad bytes to read */
+	uint rxleft = 0;	/* Remaining number of frames allowed */
+	int ret;		/* Return code from calls */
+	uint rxcount = 0;	/* Total frames read */
+	struct inff_sdio_hdrinfo *rd = &bus->cur_read, rd_new;
+	u8 head_read = 0;
+	struct sk_buff *skb_to_rxfq = NULL, *skb_head = NULL, *skb_prev = NULL;
+	struct inff_mp_device *settings = bus->sdiodev->settings;
+
+	inff_dbg(SDIO, "Enter\n");
+
+	/* Not finished unless we encounter no more frames indication */
+	bus->rxpending = true;
+
+	for (rd->seq_num = bus->rx_seq, rxleft = maxframes;
+	     !bus->rxskip && rxleft && bus->sdiodev->state == INFF_SDIOD_DATA;
+	     rd->seq_num++, rxleft--) {
+		/* Handle glomming separately */
+		if (bus->glomd || !skb_queue_empty(&bus->glom)) {
+			u8 cnt;
+
+			inff_dbg(GLOM, "calling rxglom: glomd %p, glom %p\n",
+				 bus->glomd, skb_peek(&bus->glom));
+			cnt = inff_sdio_rxglom(bus, rd->seq_num);
+			inff_dbg(GLOM, "rxglom returned %d\n", cnt);
+			rd->seq_num += cnt - 1;
+			rxleft = (rxleft > cnt) ? (rxleft - cnt) : 1;
+			continue;
+		}
+
+		sdio_claim_host(bus->sdiodev->func1);
+
+#ifdef CONFIG_INFFMAC_BT_SHARED_SDIO
+		/* make sure rx pkt check and rece buf in the same critical section */
+		if (!inff_sdio_rx_pkt_is_avail(bus)) {
+			bus->rxpending = false;
+			sdio_release_host(bus->sdiodev->func1);
+			break;
+		}
+#endif /* CONFIG_INFFMAC_BT_SHARED_SDIO */
+
+		rd->len_left = rd->len;
+		/* read header first for unknown frame length */
+		if (!rd->len) {
+			ret = inff_sdiod_recv_buf(bus->sdiodev, SDIO_FUNC_2,
+						  bus->rxhdr, INFF_FIRSTREAD);
+			bus->sdcnt.f2rxhdrs++;
+			if (ret < 0) {
+				inff_err("RXHEADER FAILED: %d\n",
+					 ret);
+				bus->sdcnt.rx_hdrfail++;
+				inff_sdio_rxfail(bus, true, true);
+				sdio_release_host(bus->sdiodev->func1);
+				continue;
+			}
+
+			inff_dbg_hex_dump(INFF_BYTES_ON() || INFF_HDRS_ON(),
+					  bus->rxhdr, SDPCM_HDRLEN,
+					  "RxHdr:\n");
+
+			if (inff_sdio_hdparse(bus, bus->rxhdr, rd,
+					      INFF_SDIO_FT_NORMAL)) {
+				sdio_release_host(bus->sdiodev->func1);
+				if (!bus->rxpending)
+					break;
+
+				continue;
+			}
+
+			if (rd->channel == SDPCM_CONTROL_CHANNEL) {
+				inff_sdio_read_control(bus, bus->rxhdr,
+						       rd->len,
+						       rd->dat_offset);
+				/* prepare the descriptor for the next read */
+				rd->len = rd->len_nxtfrm << 4;
+				rd->len_nxtfrm = 0;
+				/* treat all packet as event if we don't know */
+				rd->channel = SDPCM_EVENT_CHANNEL;
+				sdio_release_host(bus->sdiodev->func1);
+				continue;
+			}
+			rd->len_left = rd->len > INFF_FIRSTREAD ?
+				       rd->len - INFF_FIRSTREAD : 0;
+			head_read = INFF_FIRSTREAD;
+		}
+
+		inff_sdio_pad(bus, &pad, &rd->len_left);
+
+		pkt = inff_pkt_buf_get_skb(rd->len_left + head_read +
+					    bus->head_align);
+		if (!pkt) {
+			/* Give up on data, request rtx of events */
+			inff_err("inff_pkt_buf_get_skb failed\n");
+			inff_sdio_rxfail(bus, false,
+					 RETRYCHAN(rd->channel));
+			sdio_release_host(bus->sdiodev->func1);
+			continue;
+		}
+		skb_pull(pkt, head_read);
+		pkt_align(pkt, rd->len_left, bus->head_align);
+
+		ret = inff_sdiod_recv_pkt(bus->sdiodev, SDIO_FUNC_2, pkt);
+		bus->sdcnt.f2rxdata++;
+		sdio_release_host(bus->sdiodev->func1);
+
+		if (ret < 0) {
+			inff_err("read %d bytes from channel %d failed: %d\n",
+				 rd->len, rd->channel, ret);
+			inff_pkt_buf_free_skb(pkt);
+			sdio_claim_host(bus->sdiodev->func1);
+			inff_sdio_rxfail(bus, true,
+					 RETRYCHAN(rd->channel));
+			sdio_release_host(bus->sdiodev->func1);
+			continue;
+		}
+
+		if (head_read) {
+			skb_push(pkt, head_read);
+			memcpy(pkt->data, bus->rxhdr, head_read);
+			head_read = 0;
+		} else {
+			memcpy(bus->rxhdr, pkt->data, SDPCM_HDRLEN);
+			rd_new.seq_num = rd->seq_num;
+			sdio_claim_host(bus->sdiodev->func1);
+			if (inff_sdio_hdparse(bus, bus->rxhdr, &rd_new,
+					      INFF_SDIO_FT_NORMAL)) {
+				rd->len = 0;
+				inff_sdio_rxfail(bus, true, true);
+				sdio_release_host(bus->sdiodev->func1);
+				inff_pkt_buf_free_skb(pkt);
+				continue;
+			}
+			bus->sdcnt.rx_readahead_cnt++;
+			if (rd->len != roundup(rd_new.len, 16)) {
+				inff_err("frame length mismatch:read %d, should be %d\n",
+					 rd->len,
+					 roundup(rd_new.len, 16) >> 4);
+				rd->len = 0;
+				inff_sdio_rxfail(bus, true, true);
+				sdio_release_host(bus->sdiodev->func1);
+				inff_pkt_buf_free_skb(pkt);
+				continue;
+			}
+			sdio_release_host(bus->sdiodev->func1);
+			rd->len_nxtfrm = rd_new.len_nxtfrm;
+			rd->channel = rd_new.channel;
+			rd->dat_offset = rd_new.dat_offset;
+
+			inff_dbg_hex_dump(!(INFF_BYTES_ON() &&
+					    INFF_DATA_ON()) &&
+					  INFF_HDRS_ON(),
+					  bus->rxhdr, SDPCM_HDRLEN,
+					  "RxHdr:\n");
+
+			if (rd_new.channel == SDPCM_CONTROL_CHANNEL) {
+				inff_err("readahead on control packet %d?\n",
+					 rd_new.seq_num);
+				/* Force retry w/normal header read */
+				rd->len = 0;
+				sdio_claim_host(bus->sdiodev->func1);
+				inff_sdio_rxfail(bus, false, true);
+				sdio_release_host(bus->sdiodev->func1);
+				inff_pkt_buf_free_skb(pkt);
+				continue;
+			}
+		}
+
+		inff_dbg_hex_dump(INFF_BYTES_ON() && INFF_DATA_ON(),
+				  pkt->data, rd->len, "Rx Data:\n");
+
+		/* Save superframe descriptor and allocate packet frame */
+		if (rd->channel == SDPCM_GLOM_CHANNEL) {
+			if (SDPCM_GLOMDESC(&bus->rxhdr[SDPCM_HWHDR_LEN])) {
+				inff_dbg(GLOM, "glom descriptor, %d bytes:\n",
+					 rd->len);
+				inff_dbg_hex_dump(INFF_GLOM_ON(),
+						  pkt->data, rd->len,
+						  "Glom Data:\n");
+				__skb_trim(pkt, rd->len);
+				skb_pull(pkt, SDPCM_HDRLEN);
+				bus->glomd = pkt;
+			} else {
+				inff_err("%s: glom superframe w/o descriptor!\n", __func__);
+				sdio_claim_host(bus->sdiodev->func1);
+				inff_sdio_rxfail(bus, false, false);
+				sdio_release_host(bus->sdiodev->func1);
+			}
+			/* prepare the descriptor for the next read */
+			rd->len = rd->len_nxtfrm << 4;
+			rd->len_nxtfrm = 0;
+			/* treat all packet as event if we don't know */
+			rd->channel = SDPCM_EVENT_CHANNEL;
+			continue;
+		}
+
+		/* Fill in packet len and prio, deliver upward */
+		__skb_trim(pkt, rd->len);
+		skb_pull(pkt, rd->dat_offset);
+
+		if (pkt->len == 0) {
+			inff_pkt_buf_free_skb(pkt);
+			skb_to_rxfq = NULL;
+		} else if (rd->channel == SDPCM_EVENT_CHANNEL) {
+			inff_rx_event(bus->sdiodev->dev, pkt);
+			skb_to_rxfq = NULL;
+		} else {
+			skb_to_rxfq = inff_rx_frame(bus->sdiodev->dev, pkt,
+						    false, false);
+		}
+
+		if (settings && settings->sdio_rxf_in_kthread_enabled && skb_to_rxfq) {
+			if (!skb_head)
+				skb_head = skb_to_rxfq;
+			else
+				skb_prev->next = skb_to_rxfq;
+
+			skb_prev = skb_to_rxfq;
+		}
+
+		/* prepare the descriptor for the next read */
+		rd->len = rd->len_nxtfrm << 4;
+		rd->len_nxtfrm = 0;
+		/* treat all packet as event if we don't know */
+		rd->channel = SDPCM_EVENT_CHANNEL;
+	}
+
+	if (settings && settings->sdio_rxf_in_kthread_enabled && skb_head)
+		inff_sched_rxf(bus, skb_head);
+
+	rxcount = maxframes - rxleft;
+	/* Message if we hit the limit */
+	if (!rxleft)
+		inff_dbg(DATA, "hit rx limit of %d frames\n", maxframes);
+	else
+		inff_dbg(DATA, "processed %d frames\n", rxcount);
+	/* Back off rxseq if awaiting rtx, update rx_seq */
+	if (bus->rxskip)
+		rd->seq_num--;
+	bus->rx_seq = rd->seq_num;
+
+	return rxcount;
+}
+
+static void
+inff_sdio_wait_event_wakeup(struct inff_sdio *bus)
+{
+	wake_up(&bus->ctrl_wait);
+}
+
+static int inff_sdio_txpkt_hdalign(struct inff_sdio *bus, struct sk_buff *pkt)
+{
+	struct inff_bus_stats *stats;
+	u16 head_pad;
+	u8 *dat_buf;
+
+	dat_buf = (u8 *)(pkt->data);
+
+	/* Check head padding */
+	head_pad = ((unsigned long)dat_buf % bus->head_align);
+	if (head_pad) {
+		if (skb_headroom(pkt) < head_pad) {
+			stats = &bus->sdiodev->bus_if->stats;
+			atomic_inc(&stats->pktcowed);
+			if (skb_cow_head(pkt, head_pad)) {
+				atomic_inc(&stats->pktcow_failed);
+				return -ENOMEM;
+			}
+			head_pad = 0;
+		}
+		skb_push(pkt, head_pad);
+		dat_buf = (u8 *)(pkt->data);
+	}
+	memset(dat_buf, 0, head_pad + bus->tx_hdrlen);
+	return head_pad;
+}
+
+/*
+ * struct inff_skbuff_cb reserves first two bytes in sk_buff::cb for
+ * bus layer usage.
+ */
+/* flag marking a dummy skb added for DMA alignment requirement */
+#define ALIGN_SKB_FLAG		0x8000
+/* bit mask of data length chopped from the previous packet */
+#define ALIGN_SKB_CHOP_LEN_MASK	0x7fff
+
+static int inff_sdio_txpkt_prep_sg(struct inff_sdio *bus,
+				   struct sk_buff_head *pktq,
+				   struct sk_buff *pkt, u16 total_len)
+{
+	struct inff_sdio_dev *sdiodev;
+	struct sk_buff *pkt_pad;
+	u16 tail_pad, tail_chop, chain_pad;
+	unsigned int blksize;
+	bool lastfrm;
+	int ntail, ret;
+
+	sdiodev = bus->sdiodev;
+	blksize = sdiodev->func2->cur_blksize;
+	/* sg entry alignment should be a divisor of block size */
+	WARN_ON(blksize % bus->sgentry_align);
+
+	/* Check tail padding */
+	lastfrm = skb_queue_is_last(pktq, pkt);
+	tail_pad = 0;
+	tail_chop = pkt->len % bus->sgentry_align;
+	if (tail_chop)
+		tail_pad = bus->sgentry_align - tail_chop;
+	chain_pad = (total_len + tail_pad) % blksize;
+	if (lastfrm && chain_pad)
+		tail_pad += blksize - chain_pad;
+	if (skb_tailroom(pkt) < tail_pad && pkt->len > blksize) {
+		pkt_pad = inff_pkt_buf_get_skb(tail_pad + tail_chop +
+						bus->head_align);
+		if (!pkt_pad)
+			return -ENOMEM;
+		ret = inff_sdio_txpkt_hdalign(bus, pkt_pad);
+		if (unlikely(ret < 0)) {
+			kfree_skb(pkt_pad);
+			return ret;
+		}
+		memcpy(pkt_pad->data,
+		       pkt->data + pkt->len - tail_chop,
+		       tail_chop);
+		*(u16 *)(pkt_pad->cb) = ALIGN_SKB_FLAG + tail_chop;
+		skb_trim(pkt, pkt->len - tail_chop);
+		skb_trim(pkt_pad, tail_pad + tail_chop);
+		__skb_queue_after(pktq, pkt, pkt_pad);
+	} else {
+		ntail = pkt->data_len + tail_pad -
+			(pkt->end - pkt->tail);
+		if (skb_cloned(pkt) || ntail > 0)
+			if (pskb_expand_head(pkt, 0, ntail, GFP_ATOMIC))
+				return -ENOMEM;
+		if (skb_linearize(pkt))
+			return -ENOMEM;
+		__skb_put(pkt, tail_pad);
+	}
+
+	return tail_pad;
+}
+
+/**
+ * inff_sdio_txpkt_prep - packet preparation for transmit
+ * @bus: inff_sdio structure pointer
+ * @pktq: packet list pointer
+ * @chan: virtual channel to transmit the packet
+ *
+ * Processes to be applied to the packet
+ *	- Align data buffer pointer
+ *	- Align data buffer length
+ *	- Prepare header
+ * Return: negative value if there is error
+ */
+static int
+inff_sdio_txpkt_prep(struct inff_sdio *bus, struct sk_buff_head *pktq,
+		     uint chan)
+{
+	u16 head_pad, total_len;
+	struct sk_buff *pkt_next;
+	u8 txseq;
+	int ret;
+	struct inff_sdio_hdrinfo hd_info = {0};
+
+	txseq = bus->tx_seq;
+	total_len = 0;
+	skb_queue_walk(pktq, pkt_next) {
+		/* alignment packet inserted in previous
+		 * loop cycle can be skipped as it is
+		 * already properly aligned and does not
+		 * need an sdpcm header.
+		 */
+		if (*(u16 *)pkt_next->cb & ALIGN_SKB_FLAG)
+			continue;
+
+		/* align packet data pointer */
+		ret = inff_sdio_txpkt_hdalign(bus, pkt_next);
+		if (ret < 0)
+			return ret;
+		head_pad = (u16)ret;
+		if (head_pad)
+			memset(pkt_next->data + bus->tx_hdrlen, 0, head_pad);
+
+		total_len += pkt_next->len;
+
+		hd_info.len = pkt_next->len;
+		hd_info.lastfrm = skb_queue_is_last(pktq, pkt_next);
+		if (bus->txglom && pktq->qlen > 1) {
+			ret = inff_sdio_txpkt_prep_sg(bus, pktq,
+						      pkt_next, total_len);
+			if (ret < 0)
+				return ret;
+			hd_info.tail_pad = (u16)ret;
+			total_len += (u16)ret;
+		}
+
+		hd_info.channel = chan;
+		hd_info.dat_offset = head_pad + bus->tx_hdrlen;
+		hd_info.seq_num = txseq++;
+
+		/* Now fill the header */
+		inff_sdio_hdpack(bus, pkt_next->data, &hd_info);
+
+		if (INFF_BYTES_ON() &&
+		    ((INFF_CTL_ON() && chan == SDPCM_CONTROL_CHANNEL) ||
+		     (INFF_DATA_ON() && chan != SDPCM_CONTROL_CHANNEL)))
+			inff_dbg_hex_dump(true, pkt_next->data, hd_info.len,
+					  "Tx Frame:\n");
+		else if (INFF_HDRS_ON())
+			inff_dbg_hex_dump(true, pkt_next->data,
+					  head_pad + bus->tx_hdrlen,
+					  "Tx Header:\n");
+	}
+	/* Hardware length tag of the first packet should be total
+	 * length of the chain (including padding)
+	 */
+	if (bus->txglom)
+		inff_sdio_update_hwhdr(__skb_peek(pktq)->data, total_len);
+	return 0;
+}
+
+/**
+ * inff_sdio_txpkt_postp - packet post processing for transmit
+ * @bus: inff_sdio structure pointer
+ * @pktq: packet list pointer
+ *
+ * Processes to be applied to the packet
+ *	- Remove head padding
+ *	- Remove tail padding
+ */
+static void
+inff_sdio_txpkt_postp(struct inff_sdio *bus, struct sk_buff_head *pktq)
+{
+	u8 *hdr;
+	u32 dat_offset;
+	u16 tail_pad;
+	u16 dummy_flags, chop_len;
+	struct sk_buff *pkt_next, *tmp, *pkt_prev;
+
+	skb_queue_walk_safe(pktq, pkt_next, tmp) {
+		dummy_flags = *(u16 *)(pkt_next->cb);
+		if (dummy_flags & ALIGN_SKB_FLAG) {
+			chop_len = dummy_flags & ALIGN_SKB_CHOP_LEN_MASK;
+			if (chop_len) {
+				pkt_prev = pkt_next->prev;
+				skb_put(pkt_prev, chop_len);
+			}
+			__skb_unlink(pkt_next, pktq);
+			inff_pkt_buf_free_skb(pkt_next);
+		} else {
+			hdr = pkt_next->data + bus->tx_hdrlen - SDPCM_SWHDR_LEN;
+			dat_offset = le32_to_cpu(*(__le32 *)hdr);
+			dat_offset = (dat_offset & SDPCM_DOFFSET_MASK) >>
+				     SDPCM_DOFFSET_SHIFT;
+			skb_pull(pkt_next, dat_offset);
+			if (bus->txglom) {
+				tail_pad = le16_to_cpu(*(__le16 *)(hdr - 2));
+				skb_trim(pkt_next, pkt_next->len - tail_pad);
+			}
+		}
+	}
+}
+
+/* Writes a HW/SW header into the packet and sends it. */
+/* Assumes: (a) header space already there, (b) caller holds lock */
+static int inff_sdio_txpkt(struct inff_sdio *bus, struct sk_buff_head *pktq,
+			   uint chan)
+{
+	int ret;
+	struct sk_buff *pkt_next, *tmp;
+
+	inff_dbg(TRACE, "Enter\n");
+
+	ret = inff_sdio_txpkt_prep(bus, pktq, chan);
+	if (ret)
+		goto done;
+
+	sdio_claim_host(bus->sdiodev->func1);
+	ret = inff_sdiod_send_pkt(bus->sdiodev, pktq);
+	bus->sdcnt.f2txdata++;
+
+	if (ret < 0)
+		inff_sdio_txfail(bus);
+
+	sdio_release_host(bus->sdiodev->func1);
+
+done:
+	inff_sdio_txpkt_postp(bus, pktq);
+	if (ret == 0)
+		bus->tx_seq = (bus->tx_seq + pktq->qlen) % SDPCM_SEQ_WRAP;
+	skb_queue_walk_safe(pktq, pkt_next, tmp) {
+		__skb_unlink(pkt_next, pktq);
+		inff_proto_bcdc_txcomplete(bus->sdiodev->dev, pkt_next,
+					   ret == 0);
+	}
+	return ret;
+}
+
+static uint inff_sdio_sendfromq(struct inff_sdio *bus, uint maxframes)
+{
+	struct sk_buff *pkt;
+	struct sk_buff_head pktq;
+	int ret = 0, prec_out, i;
+	uint cnt = 0;
+	u8 tx_prec_map, pkt_num, que_cnt;
+
+	inff_dbg(TRACE, "Enter\n");
+
+	tx_prec_map = ~bus->flowcontrol;
+
+	/* Send frames until the limit or some other event */
+	for (cnt = 0; (cnt < maxframes) && data_ok(bus);) {
+		pkt_num = 1;
+		que_cnt = bus->tx_max - bus->tx_seq;
+		if (bus->txglom) {
+			pkt_num = min_t(u8, que_cnt - TXCTL_CREDITS,
+					bus->sdiodev->txglomsz);
+		}
+
+		pkt_num = min_t(u32, pkt_num,
+				inff_pktq_mlen(&bus->txq, ~bus->flowcontrol));
+		__skb_queue_head_init(&pktq);
+		spin_lock_bh(&bus->txq_lock);
+		for (i = 0; i < pkt_num; i++) {
+			pkt = inff_pktq_mdeq(&bus->txq, tx_prec_map,
+					     &prec_out);
+			if (!pkt)
+				break;
+			__skb_queue_tail(&pktq, pkt);
+		}
+		spin_unlock_bh(&bus->txq_lock);
+		if (i == 0)
+			break;
+
+		ret = inff_sdio_txpkt(bus, &pktq, SDPCM_DATA_CHANNEL);
+
+		cnt += i;
+	}
+
+	/* Deflow-control stack if needed */
+	if (bus->sdiodev->state == INFF_SDIOD_DATA &&
+	    bus->txoff && (pktq_len(&bus->txq) < TXLOW)) {
+		bus->txoff = false;
+		inff_proto_bcdc_txflowblock(bus->sdiodev->dev, false);
+	}
+
+	return cnt;
+}
+
+static int inff_sdio_tx_ctrlframe(struct inff_sdio *bus, u8 *frame, u16 len)
+{
+	u8 doff;
+	u16 pad;
+	uint retries = 0;
+	struct inff_sdio_hdrinfo hd_info = {0};
+	int ret;
+
+	inff_dbg(SDIO, "Enter\n");
+
+	/* Back the pointer to make room for bus header */
+	frame -= bus->tx_hdrlen;
+	len += bus->tx_hdrlen;
+
+	/* Add alignment padding (optional for ctl frames) */
+	doff = ((unsigned long)frame % bus->head_align);
+	if (doff) {
+		frame -= doff;
+		len += doff;
+		memset(frame + bus->tx_hdrlen, 0, doff);
+	}
+
+	/* Round send length to next SDIO block */
+	pad = 0;
+	if (bus->roundup && bus->blocksize && len > bus->blocksize) {
+		pad = bus->blocksize - (len % bus->blocksize);
+		if (pad > bus->roundup || pad >= bus->blocksize)
+			pad = 0;
+	} else if (len % bus->head_align) {
+		pad = bus->head_align - (len % bus->head_align);
+	}
+	len += pad;
+
+	hd_info.len = len - pad;
+	hd_info.channel = SDPCM_CONTROL_CHANNEL;
+	hd_info.dat_offset = doff + bus->tx_hdrlen;
+	hd_info.seq_num = bus->tx_seq;
+	hd_info.lastfrm = true;
+	hd_info.tail_pad = pad;
+	inff_sdio_hdpack(bus, frame, &hd_info);
+
+	if (bus->txglom)
+		inff_sdio_update_hwhdr(frame, len);
+
+	inff_dbg_hex_dump(INFF_BYTES_ON() && INFF_CTL_ON(),
+			  frame, len, "Tx Frame:\n");
+	inff_dbg_hex_dump(!(INFF_BYTES_ON() && INFF_CTL_ON()) &&
+			  INFF_HDRS_ON(),
+			  frame, min_t(u16, len, 16), "TxHdr:\n");
+
+	do {
+		ret = inff_sdiod_send_buf(bus->sdiodev, SDIO_FUNC_2, frame, len);
+
+		if (ret < 0)
+			inff_sdio_txfail(bus);
+		else
+			bus->tx_seq = (bus->tx_seq + 1) % SDPCM_SEQ_WRAP;
+	} while (ret < 0 && retries++ < TXRETRIES);
+
+	return ret;
+}
+
+static bool inff_chip_is_ulp(struct inff_chip *ci)
+{
+	if (ci->chip == INF_CC_43022_CHIP_ID)
+		return true;
+	else
+		return false;
+}
+
+static bool inff_sdio_use_ht_avail(struct inff_chip *ci)
+{
+	if (ci->chip == INF_CC_5551X_CHIP_ID ||
+	    ci->chip == INF_CC_5557X_CHIP_ID)
+		return true;
+	else
+		return false;
+}
+
+static void inff_sdio_bus_stop(struct device *dev)
+{
+	struct inff_bus *bus_if = dev_get_drvdata(dev);
+	struct inff_sdio_dev *sdiodev = bus_if->bus_priv.sdio;
+	struct inff_sdio *bus = sdiodev->bus;
+	struct inff_core *core = bus->sdio_core;
+	u32 local_hostintmask;
+	u8 saveclk, bpreq;
+	int err;
+
+	inff_dbg(TRACE, "Enter\n");
+
+	if (bus->watchdog_tsk) {
+		send_sig(SIGTERM, bus->watchdog_tsk, 1);
+		kthread_stop(bus->watchdog_tsk);
+		bus->watchdog_tsk = NULL;
+	}
+
+	if (bus->thr_rxf_ctl.p_task) {
+		send_sig(SIGTERM, bus->thr_rxf_ctl.p_task, 1);
+		kthread_stop(bus->thr_rxf_ctl.p_task);
+		bus->thr_rxf_ctl.p_task = NULL;
+	}
+
+	if (sdiodev->state != INFF_SDIOD_NOMEDIUM) {
+		sdio_claim_host(sdiodev->func1);
+
+		/* Enable clock for device interrupts */
+		inff_sdio_bus_sleep(bus, false, false);
+
+		/* Disable and clear interrupts at the chip level also */
+		inff_sdiod_writel(sdiodev, core->base + SD_REG(hostintmask),
+				  0, NULL);
+
+		local_hostintmask = bus->hostintmask;
+		bus->hostintmask = 0;
+
+		/* Force backplane clocks to assure F2 interrupt propagates */
+		saveclk = inff_sdiod_readb(sdiodev, SBSDIO_FUNC1_CHIPCLKCSR,
+					   &err);
+		if (!err) {
+			bpreq = saveclk;
+			bpreq |= (inff_sdio_use_ht_avail(bus->ci) ||
+				   inff_chip_is_ulp(bus->ci)) ?
+				SBSDIO_HT_AVAIL_REQ : SBSDIO_FORCE_HT;
+			inff_sdiod_writeb(sdiodev,
+					  SBSDIO_FUNC1_CHIPCLKCSR,
+					  bpreq, &err);
+		}
+		if (err)
+			inff_err("Failed to force clock for F2: err %d\n",
+				 err);
+
+		/* Turn off the bus (F2), free any pending packets */
+		inff_dbg(INTR, "disable SDIO interrupts\n");
+		sdio_disable_func(sdiodev->func2);
+
+		/* Clear any pending interrupts now that F2 is disabled */
+		inff_sdiod_writel(sdiodev, core->base + SD_REG(intstatus),
+				  local_hostintmask, NULL);
+
+		sdio_release_host(sdiodev->func1);
+	}
+	/* Clear the data packet queues */
+	inff_pktq_flush(&bus->txq, true, NULL, NULL);
+
+	/* Clear any held glomming stuff */
+	inff_pkt_buf_free_skb(bus->glomd);
+	inff_sdio_free_glom(bus);
+
+	/* Clear rx control and wake any waiters */
+	spin_lock_bh(&bus->rxctl_lock);
+	bus->rxlen = 0;
+	spin_unlock_bh(&bus->rxctl_lock);
+	inff_sdio_dcmd_resp_wake(bus);
+
+	/* Reset some F2 state stuff */
+	bus->rxskip = false;
+	bus->tx_seq = 0;
+	bus->rx_seq = 0;
+}
+
+static inline void inff_sdio_clrintr(struct inff_sdio *bus)
+{
+	struct inff_sdio_dev *sdiodev;
+	unsigned long flags;
+
+	sdiodev = bus->sdiodev;
+	if (sdiodev->oob_irq_requested) {
+		spin_lock_irqsave(&sdiodev->irq_en_lock, flags);
+		if (!sdiodev->irq_en && !atomic_read(&bus->ipend)) {
+			enable_irq(sdiodev->settings->bus.sdio.oob_irq_nr);
+			sdiodev->irq_en = true;
+		}
+		spin_unlock_irqrestore(&sdiodev->irq_en_lock, flags);
+	}
+}
+
+static int inff_sdio_intr_rstatus(struct inff_sdio *bus)
+{
+	struct inff_core *core = bus->sdio_core;
+	u32 addr;
+	unsigned long val;
+	int ret;
+
+	addr = core->base + SD_REG(intstatus);
+
+	val = inff_sdiod_readl(bus->sdiodev, addr, &ret);
+	bus->sdcnt.f1regdata++;
+	if (ret != 0)
+		return ret;
+
+	val &= bus->hostintmask;
+	atomic_set(&bus->fcstate, !!(val & I_HMB_FC_STATE));
+
+	/* Clear interrupts */
+	if (val) {
+		inff_sdiod_writel(bus->sdiodev, addr, val, &ret);
+		bus->sdcnt.f1regdata++;
+		atomic_or(val, &bus->intstatus);
+	}
+
+	return ret;
+}
+
+/* This Function is used to retrieve important
+ * details from dongle related to ULP mode Mostly
+ * values/SHM details that will be vary depending
+ * on the firmware branches
+ */
+static void
+inff_sdio_ulp_preinit(struct device *dev)
+{
+	struct inff_bus *bus_if = dev_get_drvdata(dev);
+	struct inff_sdio_dev *sdiodev = bus_if->bus_priv.sdio;
+	struct inff_if *ifp = bus_if->drvr->iflist[0];
+
+	inff_dbg(ULP, "Enter\n");
+
+	/* Query ulp_sdioctrl iovar to get the ULP related SHM offsets */
+	inff_fil_iovar_data_get(ifp, "ulp_sdioctrl",
+				&sdiodev->fmac_ulp.ulp_shm_offset,
+				sizeof(sdiodev->fmac_ulp.ulp_shm_offset));
+
+	sdiodev->ulp = false;
+
+	inff_dbg(ULP, "m_ulp_ctrl_sdio[%x] m_ulp_wakeevt_ind [%x]\n",
+		 M_DS1_CTRL_SDIO(sdiodev->fmac_ulp),
+		 M_WAKEEVENT_IND(sdiodev->fmac_ulp));
+	inff_dbg(ULP, "m_ulp_wakeind [%x]\n",
+		 M_ULP_WAKE_IND(sdiodev->fmac_ulp));
+}
+
+/* Reinitialize ARM because In DS1 mode ARM got off */
+static int
+inff_sdio_ulp_reinit_fw(struct inff_sdio *bus)
+{
+	struct inff_sdio_dev *sdiodev = bus->sdiodev;
+	struct inff_fw_request *fwreq;
+	int err = 0;
+
+	/* After firmware redownload tx/rx seq are reset accordingly
+	 * these values are reset on FMAC side tx_max is initially set to 4,
+	 * which later is updated by FW.
+	 */
+	bus->tx_seq = 0;
+	bus->rx_seq = 0;
+	bus->tx_max = 4;
+
+	fwreq = inff_prepare_fw_request(sdiodev->settings->firmware_path,
+					bus->ci, inff_sdio_fwnames,
+					ARRAY_SIZE(inff_sdio_fwnames),
+					bus->sdiodev->settings->board_type);
+	if (!fwreq)
+		return -ENOMEM;
+
+	/* stop the watch dog -> idle time until reinit is done */
+	inff_sdio_wd_timer(bus, false);
+
+	err = inff_fw_get_firmwares(sdiodev->dev, fwreq,
+				    inff_sdio_firmware_callback);
+	if (err != 0) {
+		inff_err("async firmware request failed: %d\n", err);
+		kfree(fwreq);
+	}
+
+	return err;
+}
+
+/* Check if device is in DS1 mode and handshake with ULP UCODE */
+static bool
+inff_sdio_ulp_pre_redownload_check(struct inff_sdio *bus, u32 hmb_data)
+{
+	struct inff_sdio_dev *sdiod = bus->sdiodev;
+	int err = 0;
+	u32 value = 0;
+	u32 val32, ulp_wake_ind, wowl_wake_ind;
+	int reg_addr;
+	unsigned long timeout;
+	struct inff_ulp *fmac_ulp = &bus->sdiodev->fmac_ulp;
+	int i = 0;
+
+	/* If any host mail box data is present, ignore DS1 exit sequence */
+	if (hmb_data)
+		return false;
+	/* Skip if DS1 Exit is already in progress
+	 * This can happen if firmware download is taking more time
+	 */
+	if (fmac_ulp->ulp_state == FMAC_ULP_TRIGGERED)
+		return false;
+
+	value = inff_sdiod_func0_rb(sdiod, SDIO_CCCR_IOEx, &err);
+
+	if (value != SDIO_FUNC_ENABLE_1)
+		return false;
+
+	inff_dbg(ULP, "GOT THE INTERRUPT FROM UCODE\n");
+	sdiod->ulp = true;
+	fmac_ulp->ulp_state = FMAC_ULP_TRIGGERED;
+
+	/* D11 SHM and PMU can not be accessed from host in case of 43022.
+	 * so, this logic may have to be moved to DS2 FW. Until then, skip it
+	 * for DS2.
+	 */
+	if (bus->ci->chip != INF_CC_43022_CHIP_ID) {
+		ulp_wake_ind = D11SHM_RDW(sdiod,
+					  M_ULP_WAKE_IND(sdiod->fmac_ulp),
+					  &err);
+		wowl_wake_ind = D11SHM_RDW(sdiod,
+					   M_WAKEEVENT_IND(sdiod->fmac_ulp),
+					   &err);
+
+		inff_dbg(ULP, "wowl_wake_ind: 0x%08x, ulp_wake_ind: 0x%08x state %s\n",
+			 wowl_wake_ind, ulp_wake_ind, (fmac_ulp->ulp_state) ?
+			 "DS1 Exit Triggered" : "IDLE State");
+
+		if (wowl_wake_ind || ulp_wake_ind) {
+			/* RX wake Don't do anything.
+			 * Just bail out and re-download firmware.
+			 */
+			 /* Print out PHY TX error block when bit 9 set */
+			if ((ulp_wake_ind & C_DS1_PHY_TXERR) &&
+			    M_DS1_PHYTX_ERR_BLK(sdiod->fmac_ulp)) {
+				inff_err("Dump PHY TX Error SHM Locations\n");
+				for (i = 0; i < PHYTX_ERR_BLK_SIZE; i++) {
+					u32 tx_err;
+
+					tx_err = D11SHM_RDW(sdiod,
+							    (M_DS1_PHYTX_ERR_BLK(sdiod->fmac_ulp) +
+							    (i * 2)), &err);
+					pr_err("0x%x", tx_err);
+				}
+				inff_err("\n");
+			}
+		} else {
+			/* TX wake negotiate with MAC */
+			inff_dbg(ULP, "M_DS1_CTRL_SDIO: 0x%08x\n",
+				 (u32)D11SHM_RDW(sdiod,
+				 M_DS1_CTRL_SDIO(sdiod->fmac_ulp),
+				 &err));
+			val32 = D11SHM_RD(sdiod,
+					  M_DS1_CTRL_SDIO(sdiod->fmac_ulp),
+					  &err);
+			D11SHM_WR(sdiod, M_DS1_CTRL_SDIO(sdiod->fmac_ulp),
+				  val32, (C_DS1_CTRL_SDIO_DS1_EXIT |
+				  C_DS1_CTRL_REQ_VALID), &err);
+			val32 = D11REG_RD(sdiod, D11_MACCONTROL_REG, &err);
+			val32 = val32 | D11_MACCONTROL_REG_WAKE;
+			D11REG_WR(sdiod, D11_MACCONTROL_REG, val32, &err);
+
+			/* Poll for PROC_DONE to be set by ucode */
+			value = D11SHM_RDW(sdiod,
+					   M_DS1_CTRL_SDIO(sdiod->fmac_ulp),
+					   &err);
+			/* Wait here (polling) for C_DS1_CTRL_PROC_DONE */
+			timeout = jiffies + ULP_HUDI_PROC_DONE_TIME;
+			while (!(value & C_DS1_CTRL_PROC_DONE)) {
+				value = D11SHM_RDW(sdiod,
+						   M_DS1_CTRL_SDIO(sdiod->fmac_ulp),
+						   &err);
+				if (time_after(jiffies, timeout))
+					break;
+				usleep_range(1000, 2000);
+			}
+			inff_dbg(ULP, "M_DS1_CTRL_SDIO: 0x%08x\n",
+				 (u32)D11SHM_RDW(sdiod,
+				 M_DS1_CTRL_SDIO(sdiod->fmac_ulp), &err));
+			value = D11SHM_RDW(sdiod,
+					   M_DS1_CTRL_SDIO(sdiod->fmac_ulp),
+					   &err);
+			if (!(value & C_DS1_CTRL_PROC_DONE)) {
+				inff_err("Timeout Failed to enter DS1 Exit state!\n");
+				return false;
+			}
+		}
+		ulp_wake_ind = D11SHM_RDW(sdiod,
+					  M_ULP_WAKE_IND(sdiod->fmac_ulp),
+					  &err);
+		wowl_wake_ind = D11SHM_RDW(sdiod,
+					   M_WAKEEVENT_IND(sdiod->fmac_ulp),
+					   &err);
+		inff_dbg(ULP, "wowl_wake_ind: 0x%08x, ulp_wake_ind: 0x%08x\n",
+			 wowl_wake_ind, ulp_wake_ind);
+
+		/* skip setting min resource mask for secure chip */
+		reg_addr = CORE_CC_REG(inff_chip_get_pmu(bus->ci)->base,
+				       min_res_mask);
+		inff_sdiod_writel(sdiod, reg_addr,
+				  DEFAULT_43022_MIN_RES_MASK, &err);
+		if (err)
+			inff_err("min_res_mask failed\n");
+	}
+	return true;
+}
+
+static void inff_sdio_dpc(struct inff_sdio *bus)
+{
+	struct inff_sdio_dev *sdiod = bus->sdiodev;
+	u32 newstatus = 0;
+	u32 intstat_addr = bus->sdio_core->base + SD_REG(intstatus);
+	unsigned long intstatus;
+	uint txlimit = bus->txbound;	/* Tx frames to send before resched */
+	uint framecnt;			/* Temporary counter of tx/rx frames */
+	int err = 0;
+
+	inff_dbg(SDIO, "Enter\n");
+
+	sdio_claim_host(bus->sdiodev->func1);
+
+	/* If waiting for HTAVAIL, check status */
+	if (!bus->sr_enabled && bus->clkstate == CLK_PENDING) {
+		u8 clkctl, devctl = 0;
+
+#ifdef DEBUG
+		/* Check for inconsistent device control */
+		devctl = inff_sdiod_readb(bus->sdiodev, SBSDIO_DEVICE_CTL,
+					  &err);
+#endif				/* DEBUG */
+
+		/* Read CSR, if clock on switch to AVAIL, else ignore */
+		clkctl = inff_sdiod_readb(bus->sdiodev,
+					  SBSDIO_FUNC1_CHIPCLKCSR, &err);
+
+		inff_dbg(SDIO, "DPC: PENDING, devctl 0x%02x clkctl 0x%02x\n",
+			 devctl, clkctl);
+
+		if (SBSDIO_HTAV(clkctl)) {
+			devctl = inff_sdiod_readb(bus->sdiodev,
+						  SBSDIO_DEVICE_CTL, &err);
+			devctl &= ~SBSDIO_DEVCTL_CA_INT_ONLY;
+			inff_sdiod_writeb(bus->sdiodev,
+					  SBSDIO_DEVICE_CTL, devctl, &err);
+			bus->clkstate = CLK_AVAIL;
+		}
+	}
+
+	/* Make sure backplane clock is on */
+	inff_sdio_bus_sleep(bus, false, true);
+
+	/* Pending interrupt indicates new device status */
+	if (atomic_read(&bus->ipend) > 0) {
+		atomic_set(&bus->ipend, 0);
+		err = inff_sdio_intr_rstatus(bus);
+	}
+
+	/* Start with leftover status bits */
+	intstatus = atomic_xchg(&bus->intstatus, 0);
+
+	/* Handle flow-control change: read new state in case our ack
+	 * crossed another change interrupt.  If change still set, assume
+	 * FC ON for safety, let next loop through do the debounce.
+	 */
+	if (intstatus & I_HMB_FC_CHANGE) {
+		intstatus &= ~I_HMB_FC_CHANGE;
+		inff_sdiod_writel(sdiod, intstat_addr, I_HMB_FC_CHANGE, &err);
+
+		newstatus = inff_sdiod_readl(sdiod, intstat_addr, &err);
+
+		bus->sdcnt.f1regdata += 2;
+		atomic_set(&bus->fcstate,
+			   !!(newstatus & (I_HMB_FC_STATE | I_HMB_FC_CHANGE)));
+		intstatus |= (newstatus & bus->hostintmask);
+	}
+
+	/* Handle host mailbox indication */
+	if (intstatus & I_HMB_HOST_INT) {
+		u32 hmb_data = 0;
+
+		intstatus &= ~I_HMB_HOST_INT;
+		intstatus |= inff_sdio_hostmail(bus, &hmb_data);
+		if (inff_sdio_ulp_pre_redownload_check(bus, hmb_data)) {
+			/* Will toggle redownload_fw, after F2 enabled and
+			 * register IRQ.
+			 */
+			sdiod->redownload_fw = true;
+			inff_sdio_ulp_reinit_fw(bus);
+		}
+	}
+
+	sdio_release_host(bus->sdiodev->func1);
+
+	/* Generally don't ask for these, can get CRC errors... */
+	if (intstatus & I_WR_OOSYNC) {
+		inff_err("Dongle reports WR_OOSYNC\n");
+		intstatus &= ~I_WR_OOSYNC;
+	}
+
+	if (intstatus & I_RD_OOSYNC) {
+		inff_err("Dongle reports RD_OOSYNC\n");
+		intstatus &= ~I_RD_OOSYNC;
+	}
+
+	if (intstatus & I_SBINT) {
+		inff_err("Dongle reports SBINT\n");
+		intstatus &= ~I_SBINT;
+	}
+
+	/* Would be active due to wake-wlan in gSPI */
+	if (intstatus & I_CHIPACTIVE) {
+		inff_dbg(SDIO, "Dongle reports CHIPACTIVE\n");
+		intstatus &= ~I_CHIPACTIVE;
+	}
+
+	if (intstatus & I_HMB_FC_STATE) {
+		inff_dbg(INFO, "Dongle reports HMB_FC_STATE\n");
+		intstatus &= ~I_HMB_FC_STATE;
+	}
+
+	/* Ignore frame indications if rxskip is set */
+	if (bus->rxskip)
+		intstatus &= ~I_HMB_FRAME_IND;
+
+	/* On frame indication, read available frames */
+	if ((intstatus & I_HMB_FRAME_IND) && bus->clkstate == CLK_AVAIL &&
+	    !sdiod->redownload_fw) {
+		inff_sdio_readframes(bus, bus->rxbound);
+		if (!bus->rxpending)
+			intstatus &= ~I_HMB_FRAME_IND;
+	}
+
+	/* Keep still-pending events for next scheduling */
+	if (intstatus)
+		atomic_or(intstatus, &bus->intstatus);
+
+	inff_sdio_clrintr(bus);
+
+	if (bus->clkstate == CLK_AVAIL && inff_sdio_f2_ready(bus)) {
+		if (bus->ctrl_frame_stat && txctl_ok(bus)) {
+			sdio_claim_host(bus->sdiodev->func1);
+			if (bus->ctrl_frame_stat) {
+				err = inff_sdio_tx_ctrlframe(bus, bus->ctrl_frame_buf,
+							     bus->ctrl_frame_len);
+				bus->ctrl_frame_err = err;
+				wmb(); /*Ensure tx ctrlframe cache line entry is flushed*/
+				bus->ctrl_frame_stat = false;
+				if (err)
+					inff_err("sdio ctrlframe tx failed err=%d\n", err);
+			}
+			sdio_release_host(bus->sdiodev->func1);
+			inff_sdio_wait_event_wakeup(bus);
+		}
+		/* Send queued frames (limit 1 if rx may still be pending) */
+		if (!atomic_read(&bus->fcstate) && data_ok(bus) &&
+		    inff_pktq_mlen(&bus->txq, ~bus->flowcontrol) && txlimit) {
+			framecnt = bus->rxpending ? min(txlimit, bus->txminmax) :
+							txlimit;
+			inff_sdio_sendfromq(bus, framecnt);
+		}
+	}
+
+	if (bus->sdiodev->state != INFF_SDIOD_DATA || err != 0) {
+		inff_err("failed backplane access over SDIO, halting operation\n");
+		atomic_set(&bus->intstatus, 0);
+		if (bus->ctrl_frame_stat) {
+			sdio_claim_host(bus->sdiodev->func1);
+			if (bus->ctrl_frame_stat) {
+				bus->ctrl_frame_err = -ENODEV;
+				/* Ensure err is written to variable before wakeup */
+				wmb();
+				bus->ctrl_frame_stat = false;
+				inff_sdio_wait_event_wakeup(bus);
+			}
+			sdio_release_host(bus->sdiodev->func1);
+		}
+	} else if (atomic_read(&bus->intstatus) ||
+		   atomic_read(&bus->ipend) > 0 ||
+		   (!atomic_read(&bus->fcstate) &&
+		    inff_pktq_mlen(&bus->txq, ~bus->flowcontrol) &&
+		    data_ok(bus))) {
+		bus->dpc_triggered = true;
+	}
+}
+
+static struct pktq *inff_sdio_bus_gettxq(struct device *dev)
+{
+	struct inff_bus *bus_if = dev_get_drvdata(dev);
+	struct inff_sdio_dev *sdiodev = bus_if->bus_priv.sdio;
+	struct inff_sdio *bus = sdiodev->bus;
+
+	return &bus->txq;
+}
+
+static bool inff_sdio_prec_enq(struct pktq *q, struct sk_buff *pkt, int prec)
+{
+	struct sk_buff *p;
+	int eprec = -1;		/* precedence to evict from */
+
+	/* Fast case, precedence queue is not full and we are also not
+	 * exceeding total queue length
+	 */
+	if (!pktq_pfull(q, prec) && !pktq_full(q)) {
+		inff_pktq_penq(q, prec, pkt);
+		return true;
+	}
+
+	/* Determine precedence from which to evict packet, if any */
+	if (pktq_pfull(q, prec)) {
+		eprec = prec;
+	} else if (pktq_full(q)) {
+		p = inff_pktq_peek_tail(q, &eprec);
+		if (eprec > prec)
+			return false;
+	}
+
+	/* Evict if needed */
+	if (eprec >= 0) {
+		/* Detect queueing to unconfigured precedence */
+		if (eprec == prec)
+			return false;	/* refuse newer (incoming) packet */
+		/* Evict packet according to discard policy */
+		p = inff_pktq_pdeq_tail(q, eprec);
+		if (!p)
+			inff_err("inff_pktq_pdeq_tail() failed\n");
+		inff_pkt_buf_free_skb(p);
+	}
+
+	/* Enqueue */
+	p = inff_pktq_penq(q, prec, pkt);
+	if (!p)
+		inff_err("inff_pktq_penq() failed\n");
+
+	return p ? true : false;
+}
+
+static int inff_sdio_bus_txdata(struct device *dev, struct sk_buff *pkt)
+{
+	int ret = -EBADE;
+	uint prec;
+	struct inff_bus *bus_if = dev_get_drvdata(dev);
+	struct inff_sdio_dev *sdiodev = bus_if->bus_priv.sdio;
+	struct inff_sdio *bus = sdiodev->bus;
+
+	inff_dbg(TRACE, "Enter: pkt: data %p len %d\n", pkt->data, pkt->len);
+	if (sdiodev->state != INFF_SDIOD_DATA)
+		return -EIO;
+
+	/* Add space for the header */
+	skb_push(pkt, bus->tx_hdrlen);
+	/* precondition: IS_ALIGNED((unsigned long)(pkt->data), 2) */
+
+	/* In WLAN, priority is always set by the AP using WMM parameters
+	 * and this need not always follow the standard 802.1d priority.
+	 * Based on AP WMM config, map from 802.1d priority to corresponding
+	 * precedence level.
+	 */
+	prec = inff_map_prio_to_prec(bus_if->drvr->config,
+				     (pkt->priority & PRIOMASK));
+
+	/* Check for existing queue, current flow-control,
+	 * pending event, or pending clock
+	 */
+	inff_dbg(TRACE, "deferring pktq len %d\n", pktq_len(&bus->txq));
+	bus->sdcnt.fcqueued++;
+
+	skb_tx_timestamp(pkt);
+
+	/* Priority based enq */
+	spin_lock_bh(&bus->txq_lock);
+	/* reset bus_flags in packet cb */
+	*(u16 *)(pkt->cb) = 0;
+	if (!inff_sdio_prec_enq(&bus->txq, pkt, prec)) {
+		skb_pull(pkt, bus->tx_hdrlen);
+		inff_err("out of bus->txq !!!\n");
+		ret = -ENOSR;
+	} else {
+		ret = 0;
+	}
+
+	if (pktq_len(&bus->txq) >= TXHI) {
+		bus->txoff = true;
+		inff_proto_bcdc_txflowblock(dev, true);
+	}
+	spin_unlock_bh(&bus->txq_lock);
+
+#ifdef DEBUG
+	if (pktq_plen(&bus->txq, prec) > qcount[prec])
+		qcount[prec] = pktq_plen(&bus->txq, prec);
+#endif
+
+	inff_sdio_trigger_dpc(bus);
+	return ret;
+}
+
+#ifdef DEBUG
+#define CONSOLE_LINE_MAX	192
+
+static int inff_sdio_readconsole(struct inff_sdio *bus)
+{
+	struct inff_console *c = &bus->console;
+	u8 line[CONSOLE_LINE_MAX], ch;
+	u32 n, idx, addr;
+	int rv;
+
+	/* Don't do anything until FWREADY updates console address */
+	if (bus->console_addr == 0)
+		return 0;
+
+	/* Read console log struct */
+	addr = bus->console_addr + offsetof(struct rte_console, log_le);
+	rv = inff_sdiod_ramrw(bus->sdiodev, false, addr, (u8 *)&c->log_le,
+			      sizeof(c->log_le));
+	if (rv < 0)
+		return rv;
+
+	/* Allocate console buffer (one time only) */
+	if (!c->buf) {
+		c->bufsize = le32_to_cpu(c->log_le.buf_size);
+		c->buf = kmalloc(c->bufsize, GFP_ATOMIC);
+		if (!c->buf)
+			return -ENOMEM;
+	}
+
+	idx = le32_to_cpu(c->log_le.idx);
+
+	/* Protect against corrupt value */
+	if (idx > c->bufsize)
+		return -EBADE;
+
+	/* Skip reading the console buffer if the index pointer
+	 * has not moved
+	 */
+	if (idx == c->last)
+		return 0;
+
+	/* Read the console buffer */
+	addr = le32_to_cpu(c->log_le.buf);
+
+	/* During FW Control Switch from Bootloader to Ram
+	 * Console address read will return all 0's which is not a valid.
+	 * when we try to access 0 ram address we are getting SDIO error.
+	 */
+	if (addr == 0)
+		return 0;
+
+	rv = inff_sdiod_ramrw(bus->sdiodev, false, addr, c->buf, c->bufsize);
+	if (rv < 0)
+		return rv;
+
+	while (c->last != idx) {
+		for (n = 0; n < CONSOLE_LINE_MAX - 2; n++) {
+			if (c->last == idx) {
+				/* This would output a partial line.
+				 * Instead, back up
+				 * the buffer pointer and output this
+				 * line next time around.
+				 */
+				if (c->last >= n)
+					c->last -= n;
+				else
+					c->last = c->bufsize - n;
+				goto break2;
+			}
+			ch = c->buf[c->last];
+			c->last = (c->last + 1) % c->bufsize;
+			if (ch == '\n')
+				break;
+			line[n] = ch;
+		}
+
+		if (n > 0) {
+			if (line[n - 1] == '\r')
+				n--;
+			line[n] = 0;
+			pr_debug("CONSOLE: %s\n", line);
+		}
+	}
+break2:
+
+	return 0;
+}
+#endif				/* DEBUG */
+
+static int
+inff_sdio_bus_txctl(struct device *dev, unsigned char *msg, uint msglen)
+{
+	struct inff_bus *bus_if = dev_get_drvdata(dev);
+	struct inff_sdio_dev *sdiodev = bus_if->bus_priv.sdio;
+	struct inff_sdio *bus = sdiodev->bus;
+	int ret;
+
+	inff_dbg(TRACE, "Enter\n");
+	if (sdiodev->state != INFF_SDIOD_DATA)
+		return -EIO;
+
+	/* Send from dpc */
+	bus->ctrl_frame_buf = msg;
+	bus->ctrl_frame_len = msglen;
+	/* Ensure msg is written to variable before trigger dpc */
+	wmb();
+	bus->ctrl_frame_stat = true;
+
+	inff_sdio_trigger_dpc(bus);
+	wait_event_timeout(bus->ctrl_wait, !bus->ctrl_frame_stat,
+			   CTL_DONE_TIMEOUT);
+
+	ret = 0;
+	if (bus->ctrl_frame_stat) {
+		sdio_claim_host(bus->sdiodev->func1);
+		if (bus->ctrl_frame_stat) {
+			inff_dbg(SDIO, "ctrl_frame timeout\n");
+			bus->ctrl_frame_stat = false;
+			ret = -ETIMEDOUT;
+		}
+		sdio_release_host(bus->sdiodev->func1);
+	}
+	if (!ret) {
+		inff_dbg(SDIO, "ctrl_frame complete, err=%d\n",
+			 bus->ctrl_frame_err);
+		/* Ensure read completed */
+		rmb();
+		ret = bus->ctrl_frame_err;
+	}
+
+	if (ret)
+		bus->sdcnt.tx_ctlerrs++;
+	else
+		bus->sdcnt.tx_ctlpkts++;
+
+	return ret;
+}
+
+#ifdef DEBUG
+static int inff_sdio_dump_console(struct seq_file *seq, struct inff_sdio *bus,
+				  struct sdpcm_shared *sh)
+{
+	u32 addr, console_ptr, console_size, console_index;
+	char *conbuf = NULL;
+	__le32 sh_val;
+	int rv;
+
+	/* obtain console information from device memory */
+	addr = sh->console_addr + offsetof(struct rte_console, log_le);
+	rv = inff_sdiod_ramrw(bus->sdiodev, false, addr,
+			      (u8 *)&sh_val, sizeof(u32));
+	if (rv < 0)
+		return rv;
+	console_ptr = le32_to_cpu(sh_val);
+
+	addr = sh->console_addr + offsetof(struct rte_console, log_le.buf_size);
+	rv = inff_sdiod_ramrw(bus->sdiodev, false, addr,
+			      (u8 *)&sh_val, sizeof(u32));
+	if (rv < 0)
+		return rv;
+	console_size = le32_to_cpu(sh_val);
+
+	addr = sh->console_addr + offsetof(struct rte_console, log_le.idx);
+	rv = inff_sdiod_ramrw(bus->sdiodev, false, addr,
+			      (u8 *)&sh_val, sizeof(u32));
+	if (rv < 0)
+		return rv;
+	console_index = le32_to_cpu(sh_val);
+
+	/* allocate buffer for console data */
+	if (console_size <= CONSOLE_BUFFER_MAX)
+		conbuf = vzalloc(console_size + 1);
+
+	if (!conbuf)
+		return -ENOMEM;
+
+	/* obtain the console data from device */
+	conbuf[console_size] = '\0';
+	rv = inff_sdiod_ramrw(bus->sdiodev, false, console_ptr, (u8 *)conbuf,
+			      console_size);
+	if (rv < 0)
+		goto done;
+
+	rv = seq_write(seq, conbuf + console_index,
+		       console_size - console_index);
+	if (rv < 0)
+		goto done;
+
+	if (console_index > 0)
+		rv = seq_write(seq, conbuf, console_index - 1);
+
+done:
+	vfree(conbuf);
+	return rv;
+}
+
+static int inff_sdio_trap_info(struct seq_file *seq, struct inff_sdio *bus,
+			       struct sdpcm_shared *sh)
+{
+	int error;
+	struct inff_trap_info tr;
+
+	if ((sh->flags & SDPCM_SHARED_TRAP) == 0) {
+		inff_dbg(INFO, "no trap in firmware\n");
+		return 0;
+	}
+
+	error = inff_sdiod_ramrw(bus->sdiodev, false, sh->trap_addr, (u8 *)&tr,
+				 sizeof(struct inff_trap_info));
+	if (error < 0)
+		return error;
+
+	if (seq)
+		seq_printf(seq,
+			   "dongle trap info: type 0x%x @ epc 0x%08x\n"
+			   "  cpsr 0x%08x spsr 0x%08x sp 0x%08x\n"
+			   "  lr   0x%08x pc   0x%08x offset 0x%x\n"
+			   "  r0   0x%08x r1   0x%08x r2 0x%08x r3 0x%08x\n"
+			   "  r4   0x%08x r5   0x%08x r6 0x%08x r7 0x%08x\n",
+			   le32_to_cpu(tr.type), le32_to_cpu(tr.epc),
+			   le32_to_cpu(tr.cpsr), le32_to_cpu(tr.spsr),
+			   le32_to_cpu(tr.r13), le32_to_cpu(tr.r14),
+			   le32_to_cpu(tr.pc), sh->trap_addr,
+			   le32_to_cpu(tr.r0), le32_to_cpu(tr.r1),
+			   le32_to_cpu(tr.r2), le32_to_cpu(tr.r3),
+			   le32_to_cpu(tr.r4), le32_to_cpu(tr.r5),
+			   le32_to_cpu(tr.r6), le32_to_cpu(tr.r7));
+	else
+		pr_debug("dongle trap info: type 0x%x @ epc 0x%08x\n"
+			 "  cpsr 0x%08x spsr 0x%08x sp 0x%08x\n"
+			 "  lr   0x%08x pc   0x%08x offset 0x%x\n"
+			 "  r0   0x%08x r1   0x%08x r2 0x%08x r3 0x%08x\n"
+			 "  r4   0x%08x r5   0x%08x r6 0x%08x r7 0x%08x\n",
+			 le32_to_cpu(tr.type), le32_to_cpu(tr.epc),
+			 le32_to_cpu(tr.cpsr), le32_to_cpu(tr.spsr),
+			 le32_to_cpu(tr.r13), le32_to_cpu(tr.r14),
+			 le32_to_cpu(tr.pc), sh->trap_addr,
+			 le32_to_cpu(tr.r0), le32_to_cpu(tr.r1),
+			 le32_to_cpu(tr.r2), le32_to_cpu(tr.r3),
+			 le32_to_cpu(tr.r4), le32_to_cpu(tr.r5),
+			 le32_to_cpu(tr.r6), le32_to_cpu(tr.r7));
+	return 0;
+}
+
+static int inff_sdio_assert_info(struct seq_file *seq, struct inff_sdio *bus,
+				 struct sdpcm_shared *sh)
+{
+	int error = 0;
+	char file[80] = "?";
+	char expr[80] = "<???>";
+
+	if ((sh->flags & SDPCM_SHARED_ASSERT_BUILT) == 0) {
+		inff_dbg(INFO, "firmware not built with -assert\n");
+		return 0;
+	} else if ((sh->flags & SDPCM_SHARED_ASSERT) == 0) {
+		inff_dbg(INFO, "no assert in dongle\n");
+		return 0;
+	}
+
+	sdio_claim_host(bus->sdiodev->func1);
+	if (sh->assert_file_addr != 0) {
+		error = inff_sdiod_ramrw(bus->sdiodev, false,
+					 sh->assert_file_addr, (u8 *)file, 80);
+		if (error < 0)
+			return error;
+	}
+	if (sh->assert_exp_addr != 0) {
+		error = inff_sdiod_ramrw(bus->sdiodev, false,
+					 sh->assert_exp_addr, (u8 *)expr, 80);
+		if (error < 0)
+			return error;
+	}
+	sdio_release_host(bus->sdiodev->func1);
+
+	seq_printf(seq, "dongle assert: %s:%d: assert(%s)\n",
+		   file, sh->assert_line, expr);
+	return 0;
+}
+
+static int inff_sdio_checkdied(struct inff_sdio *bus)
+{
+	int error;
+	struct sdpcm_shared sh;
+
+	error = inff_sdio_readshared(bus, &sh);
+
+	if (error < 0)
+		return error;
+
+	if ((sh.flags & SDPCM_SHARED_ASSERT_BUILT) == 0)
+		inff_dbg(INFO, "firmware not built with -assert\n");
+	else if (sh.flags & SDPCM_SHARED_ASSERT)
+		inff_err("assertion in dongle\n");
+
+	if (sh.flags & SDPCM_SHARED_TRAP) {
+		inff_err("firmware trap in dongle\n");
+		inff_sdio_trap_info(NULL, bus, &sh);
+	}
+
+	return 0;
+}
+
+static int inff_sdio_died_dump(struct seq_file *seq, struct inff_sdio *bus)
+{
+	int error = 0;
+	struct sdpcm_shared sh;
+
+	error = inff_sdio_readshared(bus, &sh);
+	if (error < 0)
+		goto done;
+
+	error = inff_sdio_assert_info(seq, bus, &sh);
+	if (error < 0)
+		goto done;
+
+	error = inff_sdio_trap_info(seq, bus, &sh);
+	if (error < 0)
+		goto done;
+
+	error = inff_sdio_dump_console(seq, bus, &sh);
+
+done:
+	return error;
+}
+
+static int inff_sdio_forensic_read(struct seq_file *seq, void *data)
+{
+	struct inff_bus *bus_if = dev_get_drvdata(seq->private);
+	struct inff_sdio *bus = bus_if->bus_priv.sdio->bus;
+
+	return inff_sdio_died_dump(seq, bus);
+}
+
+static int inff_debugfs_sdio_count_read(struct seq_file *seq, void *data)
+{
+	struct inff_bus *bus_if = dev_get_drvdata(seq->private);
+	struct inff_sdio_dev *sdiodev = bus_if->bus_priv.sdio;
+	struct inff_sdio_count *sdcnt = &sdiodev->bus->sdcnt;
+
+	seq_printf(seq,
+		   "intrcount:    %u\nlastintrs:    %u\n"
+		   "pollcnt:      %u\nregfails:     %u\n"
+		   "tx_sderrs:    %u\nfcqueued:     %u\n"
+		   "rxrtx:        %u\nrx_toolong:   %u\n"
+		   "rxc_errors:   %u\nrx_hdrfail:   %u\n"
+		   "rx_badhdr:    %u\nrx_badseq:    %u\n"
+		   "fc_rcvd:      %u\nfc_xoff:      %u\n"
+		   "fc_xon:       %u\nrxglomfail:   %u\n"
+		   "rxglomframes: %u\nrxglompkts:   %u\n"
+		   "f2rxhdrs:     %u\nf2rxdata:     %u\n"
+		   "f2txdata:     %u\nf1regdata:    %u\n"
+		   "tickcnt:      %u\ntx_ctlerrs:   %lu\n"
+		   "tx_ctlpkts:   %lu\nrx_ctlerrs:   %lu\n"
+		   "rx_ctlpkts:   %lu\nrx_readahead: %lu\n",
+		   sdcnt->intrcount, sdcnt->lastintrs,
+		   sdcnt->pollcnt, sdcnt->regfails,
+		   sdcnt->tx_sderrs, sdcnt->fcqueued,
+		   sdcnt->rxrtx, sdcnt->rx_toolong,
+		   sdcnt->rxc_errors, sdcnt->rx_hdrfail,
+		   sdcnt->rx_badhdr, sdcnt->rx_badseq,
+		   sdcnt->fc_rcvd, sdcnt->fc_xoff,
+		   sdcnt->fc_xon, sdcnt->rxglomfail,
+		   sdcnt->rxglomframes, sdcnt->rxglompkts,
+		   sdcnt->f2rxhdrs, sdcnt->f2rxdata,
+		   sdcnt->f2txdata, sdcnt->f1regdata,
+		   sdcnt->tickcnt, sdcnt->tx_ctlerrs,
+		   sdcnt->tx_ctlpkts, sdcnt->rx_ctlerrs,
+		   sdcnt->rx_ctlpkts, sdcnt->rx_readahead_cnt);
+
+	return 0;
+}
+
+static void inff_sdio_debugfs_create(struct device *dev)
+{
+	struct inff_bus *bus_if = dev_get_drvdata(dev);
+	struct inff_pub *drvr = bus_if->drvr;
+	struct inff_sdio_dev *sdiodev = bus_if->bus_priv.sdio;
+	struct inff_sdio *bus = sdiodev->bus;
+	struct dentry *dentry = inff_debugfs_get_devdir(drvr);
+
+	if (IS_ERR_OR_NULL(dentry))
+		return;
+
+	bus->console_interval = INFF_CONSOLE;
+
+	inff_debugfs_add_entry(drvr, "forensics", inff_sdio_forensic_read);
+	inff_debugfs_add_entry(drvr, "counters",
+			       inff_debugfs_sdio_count_read);
+	debugfs_create_u32("console_interval", 0644, dentry,
+			   &bus->console_interval);
+}
+#else
+static int inff_sdio_checkdied(struct inff_sdio *bus)
+{
+	return 0;
+}
+
+static void inff_sdio_debugfs_create(struct device *dev)
+{
+}
+#endif /* DEBUG */
+
+static int
+inff_sdio_bus_rxctl(struct device *dev, unsigned char *msg, uint msglen)
+{
+	int timeleft;
+	uint rxlen = 0;
+	bool pending;
+	u8 *buf;
+	struct inff_bus *bus_if = dev_get_drvdata(dev);
+	struct inff_sdio_dev *sdiodev = bus_if->bus_priv.sdio;
+	struct inff_sdio *bus = sdiodev->bus;
+
+	inff_dbg(TRACE, "Enter\n");
+	if (sdiodev->state != INFF_SDIOD_DATA)
+		return -EIO;
+
+	/* Wait until control frame is available */
+	timeleft = inff_sdio_dcmd_resp_wait(bus, &bus->rxlen, &pending);
+
+	spin_lock_bh(&bus->rxctl_lock);
+	rxlen = bus->rxlen;
+	memcpy(msg, bus->rxctl, min(msglen, rxlen));
+	bus->rxctl = NULL;
+	buf = bus->rxctl_orig;
+	bus->rxctl_orig = NULL;
+	bus->rxlen = 0;
+	spin_unlock_bh(&bus->rxctl_lock);
+	vfree(buf);
+
+	if (rxlen) {
+		inff_dbg(CTL, "resumed on rxctl frame, got %d expected %d\n",
+			 rxlen, msglen);
+	} else if (timeleft == 0) {
+		inff_err("resumed on timeout\n");
+		inff_sdio_checkdied(bus);
+	} else if (!pending) {
+		inff_dbg(CTL, "resumed for unknown reason?\n");
+		inff_sdio_checkdied(bus);
+	} else {
+		inff_dbg(CTL, "cancelled\n");
+		return -ERESTARTSYS;
+	}
+
+	if (rxlen)
+		bus->sdcnt.rx_ctlpkts++;
+	else
+		bus->sdcnt.rx_ctlerrs++;
+
+	return rxlen ? (int)rxlen : -ETIMEDOUT;
+}
+
+#ifdef DEBUG
+static bool
+inff_sdio_verifymemory(struct inff_sdio_dev *sdiodev, u32 ram_addr,
+		       u8 *ram_data, uint ram_sz)
+{
+	char *ram_cmp;
+	int err;
+	bool ret = true;
+	int address;
+	int offset;
+	int len;
+
+	/* read back and verify */
+	inff_dbg(INFO, "Compare RAM dl & ul at 0x%08x; size=%d\n", ram_addr,
+		 ram_sz);
+	ram_cmp = kmalloc(MEMBLOCK, GFP_KERNEL);
+	/* do not proceed while no memory but  */
+	if (!ram_cmp)
+		return true;
+
+	address = ram_addr;
+	offset = 0;
+	while (offset < ram_sz) {
+		len = ((offset + MEMBLOCK) < ram_sz) ? MEMBLOCK :
+		      ram_sz - offset;
+		err = inff_sdiod_ramrw(sdiodev, false, address, ram_cmp, len);
+		if (err) {
+			inff_err("error %d on reading %d membytes at 0x%08x\n",
+				 err, len, address);
+			ret = false;
+			break;
+		} else if (memcmp(ram_cmp, &ram_data[offset], len)) {
+			inff_err("Downloaded RAM image is corrupted, block offset is %d, len is %d\n",
+				 offset, len);
+			ret = false;
+			break;
+		}
+		offset += len;
+		address += len;
+	}
+
+	kfree(ram_cmp);
+
+	return ret;
+}
+#else	/* DEBUG */
+static bool
+inff_sdio_verifymemory(struct inff_sdio_dev *sdiodev, u32 ram_addr,
+		       u8 *ram_data, uint ram_sz)
+{
+	return true;
+}
+#endif	/* DEBUG */
+
+/* In 43022:secure-mode TRX header should be copied at 512Kb RAM location
+ * Because for CM3 based chip rtecdc.bin(fw) should be at starting of RAM
+ */
+#define TRX_HDR_START_ADDR     0x7fd4c /* TRX header start address */
+#define TRX_HDR_SZ             0x2b4 /* TRX header size */
+
+static int inff_sdio_download_code_file(struct inff_sdio *bus,
+					const struct firmware *fw)
+{
+	struct trx_header_le *trx = (struct trx_header_le *)fw->data;
+	u32 fw_size;
+	u32 address;
+	u8 *image = NULL;
+	int err;
+
+	inff_dbg(TRACE, "Enter\n");
+
+	address = bus->ci->rambase;
+	fw_size = fw->size;
+
+	if (bus->ci->chip == INF_CC_43022_CHIP_ID) {
+		if (trx->magic == cpu_to_le32(TRX_MAGIC)) {
+			err = inff_sdiod_ramrw(bus->sdiodev, true, TRX_HDR_START_ADDR,
+					       (u8 *)fw->data, sizeof(struct trx_header_le));
+			fw_size -= sizeof(struct trx_header_le);
+			image = (u8 *)fw->data;
+			image = image + TRX_HDR_SZ;
+		}
+		err = inff_sdiod_ramrw(bus->sdiodev, true, address,
+				       image, fw_size);
+		if (err)
+			inff_err("error %d on writing %d membytes at 0x%08x\n",
+				 err, (int)fw_size, address);
+		else if (!inff_sdio_verifymemory(bus->sdiodev, address,
+						 image, fw_size))
+			err = -EIO;
+	} else {
+		if (trx->magic == cpu_to_le32(TRX_MAGIC)) {
+			if ((trx->flag_version >> 16) == TRX_VERSION5)
+				address -= sizeof(struct trxv5_header_le);
+			else
+				address -= sizeof(struct trx_header_le);
+			fw_size = le32_to_cpu(trx->len);
+		}
+
+		err = inff_sdiod_ramrw(bus->sdiodev, true, address,
+				       (u8 *)fw->data, fw_size);
+
+		if (err)
+			inff_err("error %d on writing %d membytes at 0x%08x\n",
+				 err, (int)fw_size, address);
+		else if (!inff_sdio_verifymemory(bus->sdiodev, address,
+						 (u8 *)fw->data, fw_size))
+			err = -EIO;
+	}
+
+	return err;
+}
+
+static int inff_sdio_download_nvram(struct inff_sdio *bus,
+				    void *vars, u32 varsz)
+{
+	int address;
+	int err;
+
+	inff_dbg(TRACE, "Enter\n");
+
+	/* In 43022:secure-mode NVRAM should be copied to 512KB RAM area */
+	if (bus->ci->chip == INF_CC_43022_CHIP_ID)
+		address = CM3_SOCRAM_WRITE_END_LOCATION - varsz + bus->ci->rambase;
+	else
+		address = bus->ci->ramsize - varsz + bus->ci->rambase;
+
+	err = inff_sdiod_ramrw(bus->sdiodev, true, address, vars, varsz);
+	if (err)
+		inff_err("error %d on writing %d nvram bytes at 0x%08x\n",
+			 err, varsz, address);
+	else if (!inff_sdio_verifymemory(bus->sdiodev, address, vars, varsz))
+		err = -EIO;
+
+	return err;
+}
+
+static int inff_sdio_download_firmware_43022(struct inff_sdio *bus,
+					     const struct firmware *fw,
+					     void *nvram, u32 nvlen)
+{
+	int inferror;
+	u32 rstvec;
+
+	sdio_claim_host(bus->sdiodev->func1);
+	inff_sdio_clkctl(bus, CLK_AVAIL, false);
+
+	rstvec = get_unaligned_le32(fw->data);
+	inff_dbg(SDIO, "firmware rstvec: %x\n", rstvec);
+
+	inferror = bus->ci->blhs->pre_nvramdl(bus->ci);
+	if (inferror) {
+		inff_err("NVRAM download preparation failed\n");
+		goto err;
+	}
+
+	inferror = inff_sdio_download_nvram(bus, nvram, nvlen);
+	if (inferror) {
+		inff_err("dongle nvram file download failed\n");
+		goto err;
+	}
+
+	inferror = bus->ci->blhs->post_nvramdl(bus->ci);
+	if (inferror) {
+		inff_err("error in post NVRAM download hs err=%d\n",
+			 inferror);
+		goto err;
+	}
+	inferror = bus->ci->blhs->prep_fwdl(bus->ci);
+
+	inferror = inff_sdio_download_code_file(bus, fw);
+	release_firmware(fw);
+	if (inferror) {
+		inff_err("dongle image file download failed\n");
+		inff_fw_nvram_free(nvram);
+		goto err;
+	}
+
+	inferror = bus->ci->blhs->post_fwdl(bus->ci);
+	if (inferror) {
+		inff_err("FW download failed, err=%d\n", inferror);
+		inff_fw_nvram_free(nvram);
+		goto err;
+	}
+	inferror = bus->ci->blhs->chk_validation(bus->ci);
+	if (inferror) {
+		inff_err("FW validation failed, err=%d\n", inferror);
+		inff_fw_nvram_free(nvram);
+		goto err;
+	}
+
+err:
+	inff_sdio_clkctl(bus, CLK_SDONLY, false);
+	sdio_release_host(bus->sdiodev->func1);
+	return inferror;
+}
+
+static int inff_sdio_download_firmware(struct inff_sdio *bus,
+				       const struct firmware *fw,
+				       void *nvram, u32 nvlen)
+{
+	int inferror;
+	u32 rstvec;
+
+	sdio_claim_host(bus->sdiodev->func1);
+	inff_sdio_clkctl(bus, CLK_AVAIL, false);
+
+	rstvec = get_unaligned_le32(fw->data);
+	inff_dbg(SDIO, "firmware rstvec: %x\n", rstvec);
+
+	inferror = bus->ci->blhs->prep_fwdl(bus->ci);
+	if (inferror) {
+		inff_err("FW download preparation failed\n");
+		release_firmware(fw);
+		inff_fw_nvram_free(nvram);
+		goto err;
+	}
+
+	inferror = inff_sdio_download_code_file(bus, fw);
+	release_firmware(fw);
+	if (inferror) {
+		inff_err("dongle image file download failed\n");
+		inff_fw_nvram_free(nvram);
+		goto err;
+	}
+
+	inferror = bus->ci->blhs->post_fwdl(bus->ci);
+	if (inferror) {
+		inff_err("FW download failed, err=%d\n", inferror);
+		inff_fw_nvram_free(nvram);
+		goto err;
+	}
+
+	inferror = bus->ci->blhs->chk_validation(bus->ci);
+	if (inferror) {
+		inff_err("FW valication failed, err=%d\n", inferror);
+		inff_fw_nvram_free(nvram);
+		goto err;
+	}
+
+	inferror = inff_sdio_download_nvram(bus, nvram, nvlen);
+	inff_fw_nvram_free(nvram);
+	if (inferror) {
+		inff_err("dongle nvram file download failed\n");
+		goto err;
+	}
+
+	bus->ci->blhs->post_nvramdl(bus->ci);
+
+err:
+	inff_sdio_clkctl(bus, CLK_SDONLY, false);
+	sdio_release_host(bus->sdiodev->func1);
+	return inferror;
+}
+
+static bool inff_sdio_aos_no_decode(struct inff_sdio *bus)
+{
+	if (bus->ci->chip == INF_CC_5557X_CHIP_ID ||
+	    bus->ci->chip == INF_CC_5551X_CHIP_ID ||
+	    bus->ci->chip == INF_CC_43022_CHIP_ID)
+		return true;
+	else
+		return false;
+}
+
+static void inff_sdio_sr_init(struct inff_sdio *bus)
+{
+	int err = 0;
+	u8 val;
+	u8 wakeupctrl;
+	u8 cardcap;
+	u8 chipclkcsr;
+
+	inff_dbg(TRACE, "Enter\n");
+
+	if (inff_sdio_use_ht_avail(bus->ci) ||
+	    inff_chip_is_ulp(bus->ci)) {
+		wakeupctrl = SBSDIO_FUNC1_WCTRL_ALPWAIT_SHIFT;
+		chipclkcsr = SBSDIO_HT_AVAIL_REQ;
+	} else {
+		wakeupctrl = SBSDIO_FUNC1_WCTRL_HTWAIT_SHIFT;
+		chipclkcsr = SBSDIO_FORCE_HT;
+	}
+
+	if (inff_sdio_aos_no_decode(bus)) {
+		cardcap = SDIO_CCCR_INFF_CARDCAP_CMD_NODEC;
+	} else {
+		cardcap = (SDIO_CCCR_INFF_CARDCAP_CMD14_SUPPORT |
+			   SDIO_CCCR_INFF_CARDCAP_CMD14_EXT);
+	}
+
+	val = inff_sdiod_readb(bus->sdiodev, SBSDIO_FUNC1_WAKEUPCTRL, &err);
+	if (err) {
+		inff_err("error reading SBSDIO_FUNC1_WAKEUPCTRL\n");
+		return;
+	}
+	val |= 1 << wakeupctrl;
+	inff_sdiod_writeb(bus->sdiodev, SBSDIO_FUNC1_WAKEUPCTRL, val, &err);
+	if (err) {
+		inff_err("error writing SBSDIO_FUNC1_WAKEUPCTRL\n");
+		return;
+	}
+
+	/* Add CMD14 Support */
+	inff_sdiod_func0_wb(bus->sdiodev, SDIO_CCCR_INFF_CARDCAP,
+			    cardcap,
+			    &err);
+	if (err) {
+		inff_err("error writing SDIO_CCCR_INFF_CARDCAP\n");
+		return;
+	}
+
+	inff_sdiod_writeb(bus->sdiodev, SBSDIO_FUNC1_CHIPCLKCSR,
+			  chipclkcsr, &err);
+	if (err) {
+		inff_err("error writing SBSDIO_FUNC1_CHIPCLKCSR\n");
+		return;
+	}
+
+	/* set flag */
+	bus->sr_enabled = true;
+	inff_dbg(INFO, "SR enabled\n");
+}
+
+/* enable KSO bit */
+static int inff_sdio_kso_init(struct inff_sdio *bus)
+{
+	struct inff_core *core = bus->sdio_core;
+	u8 kso_mask, kso_shift;
+	u8 val;
+	int err = 0;
+
+	inff_dbg(TRACE, "Enter\n");
+
+	/* KSO bit added in SDIO core rev 12 */
+	if (core->rev < 12)
+		return 0;
+
+	val = inff_sdiod_readb(bus->sdiodev, SBSDIO_FUNC1_SLEEPCSR, &err);
+	if (err) {
+		inff_err("error reading SBSDIO_FUNC1_SLEEPCSR\n");
+		return err;
+	}
+
+	switch (bus->ci->socitype) {
+	case SOCI_AI:
+		kso_mask = SBSDIO_FUNC1_SLEEPCSR_KSO_MASK;
+		kso_shift = SBSDIO_FUNC1_SLEEPCSR_KSO_SHIFT;
+		break;
+	case SOCI_CP:
+		kso_mask = SBSDIO_FUNC1_SLEEPCSR_BT_KSO_MASK;
+		kso_shift = SBSDIO_FUNC1_SLEEPCSR_BT_KSO_SHIFT;
+		break;
+	default:
+		inff_err("chip type %u is not supported\n",
+			 bus->ci->socitype);
+		return -ENODEV;
+	}
+
+	if (!(val & SBSDIO_FUNC1_SLEEPCSR_KSO_MASK)) {
+		val |= (SBSDIO_FUNC1_SLEEPCSR_KSO_EN <<
+			SBSDIO_FUNC1_SLEEPCSR_KSO_SHIFT);
+		inff_sdiod_writeb(bus->sdiodev, SBSDIO_FUNC1_SLEEPCSR,
+				  val, &err);
+		if (err) {
+			inff_err("error writing SBSDIO_FUNC1_SLEEPCSR\n");
+			return err;
+		}
+	}
+
+	return 0;
+}
+
+static int inff_sdio_bus_preinit(struct device *dev)
+{
+	struct inff_bus *bus_if = dev_get_drvdata(dev);
+	struct inff_sdio_dev *sdiodev = bus_if->bus_priv.sdio;
+	struct inff_sdio *bus = sdiodev->bus;
+	struct inff_core *core = bus->sdio_core;
+	u32 value;
+	__le32 iovar;
+	int err;
+
+	/* maxctl provided by common layer */
+	if (WARN_ON(!bus_if->maxctl))
+		return -EINVAL;
+
+	/* Allocate control receive buffer */
+	bus_if->maxctl += bus->roundup;
+	value = roundup((bus_if->maxctl + SDPCM_HDRLEN), ALIGNMENT);
+	value += bus->head_align;
+	bus->rxbuf = kmalloc(value, GFP_ATOMIC);
+	if (bus->rxbuf)
+		bus->rxblen = value;
+
+	/* the commands below use the terms tx and rx from
+	 * a device perspective, ie. bus:txglom affects the
+	 * bus transfers from device to host.
+	 */
+	if (core->rev < 12) {
+		/* for sdio core rev < 12, disable txgloming */
+		iovar = 0;
+		err = inff_iovar_data_set(dev, "bus:txglom", &iovar,
+					  sizeof(iovar));
+	} else {
+		/* otherwise, set txglomalign */
+		value = sdiodev->settings->bus.sdio.sd_sgentry_align;
+		/* SDIO ADMA requires at least 32 bit alignment */
+		iovar = cpu_to_le32(max_t(u32, value, ALIGNMENT));
+		err = inff_iovar_data_set(dev, "bus:txglomalign", &iovar,
+					  sizeof(iovar));
+	}
+
+	if (err < 0)
+		goto done;
+
+	/* initialize SHM address from firmware for DS1 */
+	if (!bus->sdiodev->ulp)
+		inff_sdio_ulp_preinit(dev);
+
+	bus->tx_hdrlen = SDPCM_HWHDR_LEN + SDPCM_SWHDR_LEN;
+	if (sdiodev->sg_support) {
+		bus->txglom = false;
+		iovar = cpu_to_le32(1);
+		err = inff_iovar_data_set(bus->sdiodev->dev, "bus:rxglom",
+					  &iovar, sizeof(iovar));
+		if (err < 0) {
+			/* bus:rxglom is allowed to fail */
+			err = 0;
+		} else {
+			bus->txglom = true;
+			bus->tx_hdrlen += SDPCM_HWEXT_LEN;
+		}
+	}
+	inff_bus_add_txhdrlen(bus->sdiodev->dev, bus->tx_hdrlen);
+
+done:
+	return err;
+}
+
+static size_t inff_sdio_bus_get_ramsize(struct device *dev)
+{
+	struct inff_bus *bus_if = dev_get_drvdata(dev);
+	struct inff_sdio_dev *sdiodev = bus_if->bus_priv.sdio;
+	struct inff_sdio *bus = sdiodev->bus;
+
+	return bus->ci->ramsize - bus->ci->srsize;
+}
+
+static int inff_sdio_bus_get_memdump(struct device *dev, void *data,
+				     size_t mem_size)
+{
+	struct inff_bus *bus_if = dev_get_drvdata(dev);
+	struct inff_sdio_dev *sdiodev = bus_if->bus_priv.sdio;
+	struct inff_sdio *bus = sdiodev->bus;
+	int err;
+	int address;
+	int offset;
+	int len;
+	int shift;
+
+	inff_dbg(INFO, "dump at 0x%08x: size=%zu\n", bus->ci->rambase,
+		 mem_size);
+
+	address = bus->ci->rambase;
+	shift = address % MEMBLOCK;
+	offset = 0;
+	err = 0;
+	sdio_claim_host(sdiodev->func1);
+	while (offset < mem_size) {
+		if (unlikely(shift)) {
+			/* if starting address is not 2K alignment, read to 2K boundary  */
+			len = ((offset + MEMBLOCK - shift) < mem_size) ? MEMBLOCK - shift :
+				mem_size - offset;
+			shift = 0;
+		} else {
+			len = ((offset + MEMBLOCK) < mem_size) ? MEMBLOCK :
+				mem_size - offset;
+		}
+
+		err = inff_sdiod_ramrw(sdiodev, false, address, data, len);
+		if (err) {
+			inff_err("error %d on reading %d membytes at 0x%08x\n",
+				 err, len, address);
+			/* Probably in non-readable region, ignore error */
+			if (err == -EILSEQ)
+				err = 0;
+			else
+				goto done;
+		}
+		data += len;
+		offset += len;
+		address += len;
+	}
+
+done:
+	sdio_release_host(sdiodev->func1);
+	return err;
+}
+
+void inff_sdio_trigger_dpc(struct inff_sdio *bus)
+{
+	bus->dpc_triggered = true;
+	queue_work(bus->inff_wq, &bus->datawork);
+}
+
+void inff_sdio_isr(struct inff_sdio *bus, bool in_isr)
+{
+	struct inff_sdio_dev *sdiod = bus->sdiodev;
+	struct inff_pub *drvr = sdiod->bus_if->drvr;
+	struct inff_if *ifp = inff_get_ifp(drvr, 0); // wlan0
+
+	inff_dbg(SDIO, "Enter\n");
+
+	if (!bus) {
+		inff_err("bus is null pointer, exiting\n");
+		return;
+	}
+
+	/* Count the interrupt call */
+	bus->sdcnt.intrcount++;
+	if (in_isr) {
+		atomic_set(&bus->ipend, 1);
+	} else {
+		/* Wake up the bus if in sleep */
+		if (inff_sdio_bus_sleep_state(bus))
+			inff_sdio_bus_sleep(bus, false, false);
+
+		if (inff_sdio_intr_rstatus(bus))
+			inff_err("failed backplane access\n");
+	}
+
+	if (bus->sdiodev->settings->sdio_in_isr) {
+		if (!mutex_trylock(&bus->sdsem)) {
+			bus->dpc_triggered = true;
+			queue_work(bus->inff_wq, &bus->datawork);
+		} else {
+			bus->dpc_triggered = true;
+
+			/* make sure dpc_triggered is true */
+			wmb();
+			while (READ_ONCE(bus->dpc_triggered)) {
+				bus->dpc_triggered = false;
+				if (ifp && ifp->drvr->settings->napi_enable && ifp->napi.poll) {
+					if (napi_schedule_prep(&ifp->napi)) {
+						__napi_schedule(&ifp->napi);
+						inff_dbg(SDIO, "NAPI scheduled on active if (%s)\n",
+							 ifp->ndev->name);
+					}
+				}
+				inff_sdio_dpc(bus);
+				bus->idlecount = 0;
+			}
+			mutex_unlock(&bus->sdsem);
+		}
+	} else {
+		bus->dpc_triggered = true;
+		queue_work(bus->inff_wq, &bus->datawork);
+	}
+}
+
+static void inff_sdio_bus_watchdog(struct inff_sdio *bus)
+{
+	inff_dbg(TIMER, "Enter\n");
+
+#ifdef DEBUG
+	/* Poll for console output periodically */
+	if (bus->sdiodev->state == INFF_SDIOD_DATA && INFF_FWCON_ON() &&
+	    bus->console_interval != 0) {
+		bus->console.count += jiffies_to_msecs(INFF_WD_POLL);
+		if (bus->console.count >= bus->console_interval) {
+			bus->console.count -= bus->console_interval;
+			sdio_claim_host(bus->sdiodev->func1);
+			/* Make sure backplane clock is on */
+			inff_sdio_bus_sleep(bus, false, false);
+			if (inff_sdio_readconsole(bus) < 0)
+				/* stop on error */
+				bus->console_interval = 0;
+			sdio_release_host(bus->sdiodev->func1);
+		}
+	}
+#endif				/* DEBUG */
+
+	/* On idle timeout clear activity flag and/or turn off clock */
+	if (!bus->dpc_triggered &&
+	    #ifdef CONFIG_INFFMAC_BT_SHARED_SDIO
+	    !inff_btsdio_is_active(bus->sdiodev->bus_if)) {
+	    #else
+	    true) {
+	    #endif
+		/* Ensure read completed */
+		rmb();
+		if (!bus->dpc_running && bus->idletime > 0 &&
+		    bus->clkstate == CLK_AVAIL) {
+			bus->idlecount++;
+			if (bus->idlecount >= bus->idletime) {
+				inff_dbg(SDIO, "idle\n");
+				sdio_claim_host(bus->sdiodev->func1);
+#ifdef DEBUG
+				if (!INFF_FWCON_ON() ||
+				    bus->console_interval == 0)
+#endif
+					inff_sdio_wd_timer(bus, false);
+				bus->idlecount = 0;
+
+				if (!bus->dpc_triggered && !bus->dpc_running)
+					inff_sdio_bus_sleep(bus, true, false);
+				else
+					inff_err("DPC active Skip sleep");
+
+				sdio_release_host(bus->sdiodev->func1);
+			}
+		} else {
+			bus->idlecount = 0;
+		}
+	} else {
+		bus->idlecount = 0;
+	}
+}
+
+static void inff_sdio_dataworker(struct work_struct *work)
+{
+	struct inff_sdio *bus = container_of(work, struct inff_sdio,
+					      datawork);
+
+	if (bus->sdiodev->settings->sdio_in_isr) {
+		if (mutex_trylock(&bus->sdsem)) {
+			bus->dpc_running = true;
+
+			/* make sure dpc_running is true */
+			wmb();
+			while (READ_ONCE(bus->dpc_triggered)) {
+				bus->dpc_triggered = false;
+				inff_sdio_dpc(bus);
+				bus->idlecount = 0;
+			}
+			mutex_unlock(&bus->sdsem);
+			bus->dpc_running = false;
+			if (inff_sdiod_freezing(bus->sdiodev)) {
+				inff_sdiod_change_state(bus->sdiodev, INFF_SDIOD_DOWN);
+				inff_sdiod_try_freeze(bus->sdiodev);
+				inff_sdiod_change_state(bus->sdiodev, INFF_SDIOD_DATA);
+			}
+		}
+	} else {
+		bus->dpc_running = true;
+
+		/* make sure dpc_running is true */
+		wmb();
+		while (READ_ONCE(bus->dpc_triggered)) {
+			bus->dpc_triggered = false;
+			inff_sdio_dpc(bus);
+			bus->idlecount = 0;
+		}
+		bus->dpc_running = false;
+		if (inff_sdiod_freezing(bus->sdiodev)) {
+			inff_sdiod_change_state(bus->sdiodev, INFF_SDIOD_DOWN);
+			inff_sdiod_try_freeze(bus->sdiodev);
+			inff_sdiod_change_state(bus->sdiodev, INFF_SDIOD_DATA);
+		}
+	}
+}
+
+static u32
+inff_sdio_ccsec_get_buscorebase(struct inff_sdio_dev *sdiodev)
+{
+	u8 devctl = 0;
+	u32 addr = 0;
+	int err = 0;
+
+	devctl = inff_sdiod_readb(sdiodev, SBSDIO_DEVICE_CTL, NULL);
+	inff_sdiod_writeb(sdiodev, SBSDIO_DEVICE_CTL, devctl | SBSDIO_DEVCTL_ADDR_RESET, &err);
+	if (err)
+		goto exit;
+
+	addr |= (inff_sdiod_readb(sdiodev, SBSDIO_FUNC1_SBADDRLOW, NULL) << 8) |
+			(inff_sdiod_readb(sdiodev, SBSDIO_FUNC1_SBADDRMID, NULL) << 16) |
+			(inff_sdiod_readb(sdiodev, SBSDIO_FUNC1_SBADDRHIGH, NULL) << 24);
+
+	inff_dbg(INFO, "sdiod core address is 0x%x\n", addr);
+exit:
+	if (err) {
+		inff_err("Get SDIO core base address failed, err=%d", err);
+		addr = 0;
+	}
+	inff_sdiod_writeb(sdiodev, SBSDIO_DEVICE_CTL, devctl, &err);
+
+	return addr;
+}
+
+static u32 inff_sdio_buscore_blhs_read(void *ctx, u32 reg_offset)
+{
+	struct inff_sdio_dev *sdiodev = (struct inff_sdio_dev *)ctx;
+
+	return (u32)inff_sdiod_readb(sdiodev, reg_offset, NULL);
+}
+
+static void inff_sdio_buscore_blhs_write(void *ctx, u32 reg_offset, u32 value)
+{
+	struct inff_sdio_dev *sdiodev = (struct inff_sdio_dev *)ctx;
+
+	inff_sdiod_writeb(sdiodev, reg_offset, (u8)value, NULL);
+}
+
+static int inff_sdio_buscoreprep(void *ctx)
+{
+	struct inff_sdio_dev *sdiodev = ctx;
+	int err = 0;
+	u8 clkval, clkset;
+
+	/* Try forcing SDIO core to do ALPAvail request only */
+	clkset = SBSDIO_FORCE_HW_CLKREQ_OFF | SBSDIO_ALP_AVAIL_REQ;
+	inff_sdiod_writeb(sdiodev, SBSDIO_FUNC1_CHIPCLKCSR, clkset, &err);
+	if (err) {
+		inff_err("error writing for HT off\n");
+		return err;
+	}
+
+	/* If register supported, wait for ALPAvail and then force ALP */
+	/* This may take up to 15 milliseconds */
+	clkval = inff_sdiod_readb(sdiodev, SBSDIO_FUNC1_CHIPCLKCSR, NULL);
+
+	if ((clkval & ~SBSDIO_AVBITS) != clkset) {
+		inff_err("ChipClkCSR access: wrote 0x%02x read 0x%02x\n",
+			 clkset, clkval);
+		return -EACCES;
+	}
+
+	SPINWAIT(((clkval = inff_sdiod_readb(sdiodev, SBSDIO_FUNC1_CHIPCLKCSR,
+					     NULL)),
+		 !SBSDIO_ALPAV(clkval)),
+		 PMU_MAX_TRANSITION_DLY);
+
+	if (!SBSDIO_ALPAV(clkval)) {
+		inff_err("timeout on ALPAV wait, clkval 0x%02x\n",
+			 clkval);
+		return -EBUSY;
+	}
+
+	clkset = SBSDIO_FORCE_HW_CLKREQ_OFF | SBSDIO_FORCE_ALP;
+	inff_sdiod_writeb(sdiodev, SBSDIO_FUNC1_CHIPCLKCSR, clkset, &err);
+	usleep_range(ALP_WAIT_MIN, ALP_WAIT_MAX);
+
+	/* Also, disable the extra SDIO pull-ups */
+	inff_sdiod_writeb(sdiodev, SBSDIO_FUNC1_SDIOPULLUP, 0, NULL);
+
+	return 0;
+}
+
+static void inff_sdio_buscore_activate(void *ctx, struct inff_chip *chip,
+				       u32 rstvec)
+{
+	struct inff_sdio_dev *sdiodev = ctx;
+	struct inff_core *core = sdiodev->bus->sdio_core;
+	u32 reg_addr;
+
+	/* clear all interrupts */
+	reg_addr = core->base + SD_REG(intstatus);
+	inff_sdiod_writel(sdiodev, reg_addr, 0xFFFFFFFF, NULL);
+
+	if (rstvec)
+		/* Write reset vector to address 0 */
+		inff_sdiod_ramrw(sdiodev, true, 0, (void *)&rstvec,
+				 sizeof(rstvec));
+}
+
+static u32 inff_sdio_buscore_read32(void *ctx, u32 addr)
+{
+	struct inff_sdio_dev *sdiodev = ctx;
+	u32 val;
+
+	val = inff_sdiod_readl(sdiodev, addr, NULL);
+
+	return val;
+}
+
+static void inff_sdio_buscore_write32(void *ctx, u32 addr, u32 val)
+{
+	struct inff_sdio_dev *sdiodev = ctx;
+
+	inff_sdiod_writel(sdiodev, addr, val, NULL);
+}
+
+static int
+inff_sdio_buscore_sec_attach(void *ctx, struct inff_blhs **blhs, struct inff_ccsec **ccsec,
+			     u32 flag, uint timeout, uint interval)
+{
+	struct inff_sdio_dev *sdiodev = (struct inff_sdio_dev *)ctx;
+	struct inff_blhs *blhsh = NULL;
+	struct inff_ccsec *ccsech = NULL;
+	u32 reg_addr;
+	u32 regdata;
+	u8 cardcap;
+	int err = 0, secure_mode;
+
+	if (sdiodev->func1->vendor != SDIO_VENDOR_ID_CYPRESS)
+		return 0;
+
+	/* 43022: Secure-mode OTP bit reading */
+	secure_mode = !inff_sdiod_readb(sdiodev, SBSDIO_FUNC1_SECURE_MODE, &err);
+	if (err)
+		inff_err("Failed to read SecureModeRegister = %d\n", err);
+
+	if (secure_mode) {
+		blhsh = kzalloc(sizeof(*blhsh), GFP_KERNEL);
+		if (!blhsh)
+			return -ENOMEM;
+		/* TODO : Get the address from si_backplane */
+		blhsh->d2h = INFF_SDIO_REG_D2H_MSG_0;
+		blhsh->h2d = INFF_SDIO_REG_H2D_MSG_0;
+		blhsh->read = inff_sdio_buscore_read32;
+		blhsh->write = inff_sdio_buscore_write32;
+
+		*blhs = blhsh;
+	}
+
+	cardcap = inff_sdiod_func0_rb(sdiodev, SDIO_CCCR_INFF_CARDCAP, NULL);
+	if (cardcap & SDIO_CCCR_INFF_CARDCAP_SECURE_MODE) {
+		blhsh = kzalloc(sizeof(*blhsh), GFP_KERNEL);
+		if (!blhsh)
+			return -ENOMEM;
+
+		blhsh->d2h = INFF_SDIO_REG_DAR_D2H_MSG_0;
+		blhsh->h2d = INFF_SDIO_REG_DAR_H2D_MSG_0;
+		blhsh->read = inff_sdio_buscore_blhs_read;
+		blhsh->write = inff_sdio_buscore_blhs_write;
+
+		blhsh->write(ctx, blhsh->h2d, 0);
+
+		SPINWAIT_MS((blhsh->read(ctx, blhsh->d2h) & flag) == 0,
+			    timeout, interval);
+
+		regdata = blhsh->read(ctx, blhsh->d2h);
+		if (!(regdata & flag)) {
+			inff_err("Timeout waiting for bootloader ready\n");
+			kfree(blhsh);
+			return -EPERM;
+		}
+		*blhs = blhsh;
+	}
+
+	if (cardcap & SDIO_CCCR_INFF_CARDCAP_CHIPID_PRESENT) {
+		ccsech = kzalloc(sizeof(*ccsech), GFP_KERNEL);
+		if (!ccsech) {
+			kfree(blhsh);
+			return -ENOMEM;
+		}
+		ccsech->bus_corebase = inff_sdio_ccsec_get_buscorebase(sdiodev);
+		reg_addr = ccsech->bus_corebase + SD_REG(eromptr);
+		ccsech->erombase = inff_sdio_buscore_read32(ctx, reg_addr);
+		reg_addr = ccsech->bus_corebase + SD_REG(chipid);
+		ccsech->chipid = inff_sdio_buscore_read32(ctx, reg_addr);
+		*ccsec = ccsech;
+	}
+
+	if (cardcap & SDIO_CCCR_INFF_CARDCAP_CHIPID_PRESENT) {
+		u32 reg_val;
+		u32 err;
+
+		/* Get SDIO Bus Mode*/
+		reg_val = inff_sdiod_func0_rb(sdiodev, SDIO_CCCR_SPEED, &err);
+		if (err) {
+			inff_err("error getting sdio bus speed\n");
+		} else {
+			if (reg_val & SDIO_SPEED_DDR50)
+				sdiodev->bus->h1_ddr50_mode = true;
+		}
+	}
+
+	return 0;
+}
+
+#define LOOP_TO_CHECK_FOR_BP_ENABLE    50000      /* Wait for 500msec */
+#define INTR_F1_WAIT_MIN               10
+#define INTR_F1_WAIT_MAX               20
+
+static int inff_get_intr_pending_data(void *ctx)
+{
+	struct inff_sdio_dev *sdiodev = (struct inff_sdio_dev *)ctx;
+	int loop = 0, status = 0, err = 0;
+	u32 reg_val = 0;
+
+	for (loop = 0; loop < LOOP_TO_CHECK_FOR_BP_ENABLE; loop++) {
+		sdio_claim_host(sdiodev->func1);
+		reg_val = inff_sdiod_func0_rb(sdiodev, SDIO_CCCR_INTx, &err);
+		sdio_release_host(sdiodev->func1);
+		status = reg_val & INTR_STATUS_FUNC1;
+
+		if (status) {
+			inff_err("[%d]: Backplane enabled.\n", loop);
+			break;
+		}
+		usleep_range(INTR_F1_WAIT_MIN, INTR_F1_WAIT_MAX);
+	}
+
+	/* Bootloader hung after backplane disable */
+	if (loop == LOOP_TO_CHECK_FOR_BP_ENABLE) {
+		err = -EBUSY;
+		inff_err("Device hung, return failure. time out %d ms\n",
+			 (LOOP_TO_CHECK_FOR_BP_ENABLE * 10) / 1000);
+	}
+
+	return 0;
+}
+
+static const struct inff_buscore_ops inff_sdio_buscore_ops = {
+	.prepare = inff_sdio_buscoreprep,
+	.activate = inff_sdio_buscore_activate,
+	.read32 = inff_sdio_buscore_read32,
+	.write32 = inff_sdio_buscore_write32,
+	.sec_attach = inff_sdio_buscore_sec_attach,
+	.get_intr_pend = inff_get_intr_pending_data,
+};
+
+static int
+inff_sdio_probe_attach(struct inff_sdio *bus)
+{
+	struct inff_sdio_dev *sdiodev;
+	u8 clkctl = 0;
+	int err = 0;
+	u32 reg_val;
+	u32 enum_base;
+	int ret = -EBADE;
+
+	sdiodev = bus->sdiodev;
+	sdio_claim_host(sdiodev->func1);
+
+	enum_base = inff_chip_enum_base(sdiodev->func1->device);
+
+	/*
+	 * Force PLL off until inff_chip_attach()
+	 * programs PLL control regs
+	 */
+
+	inff_sdiod_writeb(sdiodev, SBSDIO_FUNC1_CHIPCLKCSR, INFF_INIT_CLKCTL1,
+			  &err);
+	if (!err)
+		clkctl = inff_sdiod_readb(sdiodev, SBSDIO_FUNC1_CHIPCLKCSR,
+					  &err);
+
+	if (err || ((clkctl & ~SBSDIO_AVBITS) != INFF_INIT_CLKCTL1)) {
+		inff_err("ChipClkCSR access: err %d wrote 0x%02x read 0x%02x\n",
+			 err, INFF_INIT_CLKCTL1, clkctl);
+		goto fail;
+	}
+
+	bus->ci = inff_chip_attach(sdiodev, sdiodev->func1->device,
+				   &inff_sdio_buscore_ops);
+	if (IS_ERR(bus->ci)) {
+		inff_err("inff_chip_attach failed!\n");
+		bus->ci = NULL;
+		goto fail;
+	}
+
+	if (!bus->ci->ccsec)
+		pr_debug("F1 signature read @0x18000000=0x%4x\n",
+			 inff_sdiod_readl(sdiodev, enum_base, NULL));
+
+	/* Pick up the SDIO core info struct from chip.c */
+	bus->sdio_core   = inff_chip_get_core(bus->ci, INF_CORE_SDIO_DEV);
+	if (!bus->sdio_core)
+		goto fail;
+
+	/* Pick up the CHIPCOMMON core info struct, for bulk IO in infsdh.c */
+	sdiodev->cc_core = inff_chip_get_core(bus->ci, INF_CORE_CHIPCOMMON);
+	if (!sdiodev->cc_core)
+		goto fail;
+
+	sdiodev->settings = inff_get_module_param(sdiodev->dev,
+						  INFF_BUSTYPE_SDIO,
+						  bus->ci->chip,
+						  bus->ci->chiprev);
+	if (IS_ERR_OR_NULL(sdiodev->settings)) {
+		inff_err("Failed to get device parameters\n");
+		ret = PTR_ERR_OR_ZERO(sdiodev->settings);
+		goto fail;
+	}
+
+	if (sdiodev->settings->bus.sdio.oob_irq_supported) {
+		/*Below Module Params are not supported in OOB mode*/
+		sdiodev->settings->sdio_in_isr = 0;
+		sdiodev->settings->sdio_rxf_in_kthread_enabled = 0;
+		inff_dbg(TRACE, "OOB Enabled, Disable sdio_in_isr\n");
+	}
+
+	/* platform specific configuration:
+	 *   alignments must be at least 4 bytes for ADMA
+	 */
+	bus->head_align = ALIGNMENT;
+	bus->sgentry_align = ALIGNMENT;
+	if (sdiodev->settings->bus.sdio.sd_head_align > ALIGNMENT)
+		bus->head_align = sdiodev->settings->bus.sdio.sd_head_align;
+	if (sdiodev->settings->bus.sdio.sd_sgentry_align > ALIGNMENT)
+		bus->sgentry_align =
+				sdiodev->settings->bus.sdio.sd_sgentry_align;
+
+	/* allocate scatter-gather table. sg support
+	 * will be disabled upon allocation failure.
+	 */
+	inff_sdiod_sgtable_alloc(sdiodev);
+
+	/* wowl can be supported when KEEP_POWER is true and (WAKE_SDIO_IRQ
+	 * is true or when platform data OOB irq is true).
+	 */
+	if (IS_ENABLED(CONFIG_PM_SLEEP) &&
+	    (sdio_get_host_pm_caps(sdiodev->func1) & MMC_PM_KEEP_POWER) &&
+	    ((sdio_get_host_pm_caps(sdiodev->func1) & MMC_PM_WAKE_SDIO_IRQ) ||
+	    sdiodev->settings->bus.sdio.oob_irq_supported))
+		sdiodev->bus_if->wowl_supported = true;
+
+	if (inff_sdio_kso_init(bus)) {
+		inff_err("error enabling KSO\n");
+		goto fail;
+	}
+
+	if (bus->ci->socitype == SOCI_AI) {
+		/* Set card control so an SDIO card reset does a WLAN backplane reset */
+		reg_val = inff_sdiod_func0_rb(sdiodev, SDIO_CCCR_INFF_CARDCTRL, &err);
+		if (err)
+			goto fail;
+
+		reg_val |= SDIO_CCCR_INFF_CARDCTRL_WLANRESET;
+
+		inff_sdiod_func0_wb(sdiodev, SDIO_CCCR_INFF_CARDCTRL, reg_val, &err);
+		if (err)
+			goto fail;
+	}
+
+	sdio_release_host(sdiodev->func1);
+
+	inff_pktq_init(&bus->txq, (PRIOMASK + 1), TXQLEN);
+
+	/* allocate header buffer */
+	bus->hdrbuf = kzalloc(MAX_HDR_READ + bus->head_align, GFP_KERNEL);
+	if (!bus->hdrbuf)
+		return -ENOMEM;
+	/* Locate an appropriately-aligned portion of hdrbuf */
+	bus->rxhdr = (u8 *)roundup((unsigned long)&bus->hdrbuf[0],
+				    bus->head_align);
+
+	sdiodev->bus_if->chip_pub = bus->ci;
+
+	return 0;
+
+fail:
+	sdio_release_host(sdiodev->func1);
+	return ret;
+}
+
+static int inff_sdio_napi_poll(struct napi_struct *napi, int budget)
+{
+	struct inff_if *ifp;
+	unsigned int work_done = 0;
+
+	ifp = container_of(napi, struct inff_if, napi);
+	if (!ifp)
+		return budget;
+
+	inff_dbg(SDIO, "NAPI poll called, work_done %d, budget %d\n", work_done, budget);
+	napi_complete_done(napi, 0);
+
+	return work_done;
+}
+
+static void
+inff_sched_rxf(struct inff_sdio *bus, struct sk_buff *skb)
+{
+	inff_dbg(SDIO, "Enter\n");
+	do {
+		if (!inff_rxf_enqueue(bus, skb))
+			break;
+
+		inff_err("inff_rxf_enqueue failed\n");
+		goto done;
+	} while (1);
+
+	if (bus->thr_rxf_ctl.p_task)
+		complete(&bus->thr_rxf_ctl.comp);
+
+done:
+	return;
+}
+
+static int
+inff_sdio_rxf_thread(void *data)
+{
+	struct inff_sdio *bus = (struct inff_sdio *)data;
+	struct sched_param param;
+
+	allow_signal(SIGTERM);
+	/* This thread doesn't need any user-level access,
+	 * so get rid of all our resources
+	 */
+	memset(&param, 0, sizeof(struct sched_param));
+	param.sched_priority = 1;
+	if (param.sched_priority >= MAX_RT_PRIO / 2)
+		/* If the priority is MAX_RT_PRIO/2 or higher,
+		 * it is considered as high priority.
+		 * sched_priority of FIFO task dosen't
+		 * exceed MAX_RT_PRIO/2.
+		 */
+		sched_set_fifo(current);
+	else
+		/* For when you don't much care about FIFO,
+		 * but want to be above SCHED_NORMAL.
+		 */
+		sched_set_fifo_low(current);
+
+	while (1) {
+		if (kthread_should_stop())
+			break;
+
+		if (wait_for_completion_interruptible(&bus->thr_rxf_ctl.comp) == 0) {
+			struct sk_buff *skb = NULL;
+
+			smp_mb();/* ensure skb null */
+			skb = inff_rxf_dequeue(bus);
+			if (!skb) {
+				inff_err("nothing is dequeued, thread terminate\n");
+				break;
+			}
+
+			while (skb) {
+				struct sk_buff *skbnext = skb->next;
+
+				skb->next = NULL;
+				netif_rx(skb);
+				skb = skbnext;
+			}
+		} else {
+			break;
+		}
+	}
+	return 0;
+}
+
+static int
+inff_sdio_watchdog_thread(void *data)
+{
+	struct inff_sdio *bus = (struct inff_sdio *)data;
+	int wait;
+
+	allow_signal(SIGTERM);
+	/* Run until signal received */
+	inff_sdiod_freezer_count(bus->sdiodev);
+	while (1) {
+		if (kthread_should_stop())
+			break;
+		inff_sdiod_freezer_uncount(bus->sdiodev);
+		wait = wait_for_completion_interruptible(&bus->watchdog_wait);
+		inff_sdiod_freezer_count(bus->sdiodev);
+		inff_sdiod_try_freeze(bus->sdiodev);
+		if (!wait) {
+			inff_sdio_bus_watchdog(bus);
+			/* Count the tick for reference */
+			bus->sdcnt.tickcnt++;
+			reinit_completion(&bus->watchdog_wait);
+		} else {
+			break;
+		}
+	}
+	return 0;
+}
+
+static void
+inff_sdio_watchdog(struct timer_list *t)
+{
+	struct inff_sdio *bus = timer_container_of(bus, t, timer);
+
+	if (bus->watchdog_tsk) {
+		complete(&bus->watchdog_wait);
+		/* Reschedule the watchdog */
+		if (bus->wd_active)
+			mod_timer(&bus->timer,
+				  jiffies + INFF_WD_POLL);
+	}
+}
+
+static int inff_sdio_get_blob(struct device *dev, const struct firmware **fw,
+			      enum inff_blob_type type)
+{
+	struct inff_bus *bus_if = dev_get_drvdata(dev);
+	struct inff_sdio_dev *sdiodev = bus_if->bus_priv.sdio;
+	struct inff_sdio *bus = sdiodev->bus;
+	struct inff_chip_specific *chip_spec = &bus->ci->chip_spec;
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
+static int inff_sdio_bus_reset(struct device *dev)
+{
+	struct inff_bus *bus_if = dev_get_drvdata(dev);
+	struct inff_sdio_dev *sdiodev = bus_if->bus_priv.sdio;
+
+	inff_dbg(SDIO, "Enter\n");
+
+	/* start by unregistering irqs */
+	inff_sdiod_intr_unregister(sdiodev);
+
+	inff_sdiod_remove(sdiodev);
+
+	/* reset the adapter */
+	sdio_claim_host(sdiodev->func1);
+	mmc_hw_reset(sdiodev->func1->card);
+	sdio_release_host(sdiodev->func1);
+
+	inff_bus_change_state(sdiodev->bus_if, INFF_BUS_DOWN);
+	return 0;
+}
+
+static void inff_sdio_bus_remove(struct device *dev)
+{
+	struct inff_bus *bus_if = dev_get_drvdata(dev);
+	struct inff_sdio_dev *sdiod = bus_if->bus_priv.sdio;
+
+	device_release_driver(&sdiod->func2->dev);
+	device_release_driver(&sdiod->func1->dev);
+}
+
+static int inff_sdio_bus_set_fcmode(struct device *dev)
+{
+	struct inff_bus *bus_if = dev_get_drvdata(dev);
+	struct inff_sdio_dev *sdiodev = bus_if->bus_priv.sdio;
+
+	if (!inff_feat_is_enabled(bus_if->drvr->iflist[0], INFF_FEAT_PROPTXSTATUS)) {
+		bus_if->drvr->settings->fcmode = 0;
+		sdiodev->settings->fcmode = bus_if->drvr->settings->fcmode;
+		inff_dbg(INFO, "Set fcmode = %d\n", sdiodev->settings->fcmode);
+	}
+
+	return sdiodev->settings->fcmode;
+}
+
+static const struct inff_bus_ops inff_sdio_bus_ops = {
+	.stop = inff_sdio_bus_stop,
+	.preinit = inff_sdio_bus_preinit,
+	.txdata = inff_sdio_bus_txdata,
+	.txctl = inff_sdio_bus_txctl,
+	.rxctl = inff_sdio_bus_rxctl,
+	.gettxq = inff_sdio_bus_gettxq,
+	.wowl_config = inff_sdio_wowl_config,
+	.get_ramsize = inff_sdio_bus_get_ramsize,
+	.get_memdump = inff_sdio_bus_get_memdump,
+	.get_blob = inff_sdio_get_blob,
+	.debugfs_create = inff_sdio_debugfs_create,
+	.reset = inff_sdio_bus_reset,
+	.remove = inff_sdio_bus_remove,
+	.set_fcmode = inff_sdio_bus_set_fcmode,
+	.napi_poll = inff_sdio_napi_poll
+};
+
+static void inff_sdio_reset_cp(struct inff_sdio *bus)
+{
+	struct inff_sdio_dev *sdiodev = bus->sdiodev;
+	u32 reg_val = 0;
+	int err = 0;
+
+	/* Configure registers to trigger BT reset on
+	 * "SDIO Soft Reset", and set RES bit to trigger
+	 *  SDIO as well as BT reset
+	 */
+
+	/* Set card control so an SDIO card reset
+	 * does a BT backplane reset
+	 */
+	reg_val = inff_sdiod_func0_rb(sdiodev,
+				      SDIO_CCCR_INFF_CARDCTRL,
+				      &err);
+	if (err) {
+		inff_err("Failed to read SDIO_CCCR_INFF_CARDCTRL: %d\n", err);
+		return;
+	}
+
+	reg_val |= SDIO_CCCR_INFF_CARDCTRL_BTRESET;
+
+	inff_dbg(INFO, "Write CARDCTRL = 0x%x\n", reg_val);
+
+	inff_sdiod_func0_wb(sdiodev, SDIO_CCCR_INFF_CARDCTRL,
+			    reg_val, &err);
+	if (err) {
+		inff_err("Failed to write SDIO_CCCR_INFF_CARDCTRL: %d\n", err);
+		return;
+	}
+
+	inff_sdiod_func0_wb(sdiodev, SDIO_CCCR_ABORT,
+			    sdiodev->func1->num | SDIO_IO_CARD_RESET,
+			    &err);
+	if (err) {
+		inff_err("Failed to write SDIO_IO_CARD_RESET: %d\n", err);
+		return;
+	}
+}
+
+static void inff_sdio_reset(struct inff_sdio *bus)
+{
+#ifdef CONFIG_INFFMAC_BT_SHARED_SDIO
+	struct inff_bus *bus_if = bus->sdiodev->bus_if;
+#endif
+	u32 reg_val, read_reg;
+	int err = 0;
+
+	if (bus->ci->socitype == SOCI_CP) {
+		inff_sdio_reset_cp(bus);
+	} else if (bus->ci->chip == INF_CC_43022_CHIP_ID) {
+		/* Set card control so an SDIO card
+		 * reset does a WLAN backplane reset
+		 */
+		reg_val = inff_sdiod_func0_rb(bus->sdiodev,
+					      SDIO_CCCR_INFF_CARDCTRL,
+					      &err);
+		if (!err) {
+			/* For 43022 bit 1 and bit 2 are required
+			 * to be set for SDIO reset
+			 */
+			reg_val |= SDIO_CCCR_INFF_CARDCTRL_WLANRESET;
+#ifdef CONFIG_INFFMAC_BT_SHARED_SDIO
+			if (inff_btsdio_set_bt_reset(bus_if))
+				reg_val |= SDIO_CCCR_INFF_CARDCTRL_BTRESET;
+#endif /* CONFIG_INFFMAC_BT_SHARED_SDIO */
+			inff_sdiod_func0_wb(bus->sdiodev,
+					    SDIO_CCCR_INFF_CARDCTRL,
+					    reg_val, &err);
+			inff_dbg(INFO, "Write CARDCTRL = 0x%x err:%d\n",
+				 reg_val, err);
+			read_reg = inff_sdiod_func0_rb(bus->sdiodev,
+						       SDIO_CCCR_INFF_CARDCTRL,
+						       &err);
+			inff_dbg(INFO, "Card CTRL reg dump [0x%x], read err:%d\n",
+				 read_reg, err);
+		} else {
+			inff_err("Failed to read Card CTRL [err = %d]\n", err);
+		}
+		/* For 43022, bit 3 needs to be set
+		 * for IO Card reset
+		 */
+		reg_val = inff_sdiod_func0_rb(bus->sdiodev,
+					      SDIO_CCCR_IO_ABORT,
+					      &err);
+		if (!err) {
+			reg_val |= SDIO_CCCR_IO_ABORT_RES;
+			/* Setting IO Card Reset (RES) bit
+			 * in IOAbort register, after this point no
+			 * SDIO access is allowed till full SDIO init
+			 */
+			inff_sdiod_func0_wb(bus->sdiodev,
+					    SDIO_CCCR_IO_ABORT,
+					    reg_val, &err);
+		} else {
+			inff_err("Failed to read IO Abort [err = %d]\n", err);
+		}
+		mdelay(20);
+	} else {
+		bus->ci->blhs->init(bus->ci);
+
+		/* Configure registers to trigger WLAN reset on
+		 * "SDIO Soft Reset", and set RES bit to trigger
+		 *	SDIO as well as WLAN reset
+		 * (instead of using PMU/CC Watchdog register)
+		 */
+		if (bus->ci->ccsec) {
+			struct inff_sdio_dev *sdiodev;
+			int err = 0;
+			u32 reg_val = 0;
+
+			sdiodev = bus->sdiodev;
+			/* Set card control so an SDIO card reset
+			 * does a WLAN backplane reset
+			 */
+			reg_val = inff_sdiod_func0_rb(sdiodev,
+						      SDIO_CCCR_INFF_CARDCTRL,
+						      &err);
+			reg_val |= SDIO_CCCR_INFF_CARDCTRL_WLANRESET;
+#ifdef CONFIG_INFFMAC_BT_SHARED_SDIO
+			if (inff_btsdio_set_bt_reset(bus_if))
+				reg_val |= SDIO_CCCR_INFF_CARDCTRL_BTRESET;
+#endif /* CONFIG_INFFMAC_BT_SHARED_SDIO */
+			inff_sdiod_func0_wb(sdiodev,
+					    SDIO_CCCR_INFF_CARDCTRL,
+					    reg_val, &err);
+			inff_dbg(INFO, "Write CARDCTRL = 0x%x err:%d\n",
+				 reg_val, err);
+			inff_sdiod_func0_wb(sdiodev,
+					    SDIO_CCCR_ABORT,
+					    sdiodev->func1->num |
+					    SDIO_IO_CARD_RESET,
+					    NULL);
+		} else {
+			/* Reset the PMU, backplane and all the
+			 * cores by using the PMUWatchdogCounter.
+			 */
+			inff_chip_reset_watchdog(bus->ci);
+		}
+
+		bus->ci->blhs->post_wdreset(bus->ci);
+	}
+}
+
+#define INFF_SDIO_FW_CODE	0
+#define INFF_SDIO_FW_NVRAM	1
+#define INFF_SDIO_FW_CLM	2
+
+static int inff_sdio_enable_func2(struct inff_bus *bus_if)
+{
+	struct inff_sdio_dev *sdiod = bus_if->bus_priv.sdio;
+	struct inff_sdio *bus = sdiod->bus;
+	struct inff_core *core = bus->sdio_core;
+	u8 saveclk, bpreq;
+	u8 devctl;
+	int err;
+
+	sdio_claim_host(sdiod->func1);
+
+	/* Make sure backplane clock is on, needed to generate F2 interrupt */
+	inff_sdio_clkctl(bus, CLK_AVAIL, false);
+	if (bus->clkstate != CLK_AVAIL)
+		goto release;
+
+	/* Force clocks on backplane to be sure F2 interrupt propagates */
+	saveclk = inff_sdiod_readb(sdiod, SBSDIO_FUNC1_CHIPCLKCSR, &err);
+	if (!err) {
+		bpreq = saveclk;
+		bpreq |= (inff_sdio_use_ht_avail(bus->ci) ||
+			  inff_chip_is_ulp(bus->ci)) ?
+			SBSDIO_HT_AVAIL_REQ : SBSDIO_FORCE_HT;
+		inff_sdiod_writeb(sdiod, SBSDIO_FUNC1_CHIPCLKCSR,
+				  bpreq, &err);
+	}
+	if (err) {
+		inff_err("Failed to force clock for F2: err %d\n", err);
+		goto release;
+	}
+
+	/* Enable function 2 (frame transfers) */
+	inff_sdiod_writel(sdiod, core->base + SD_REG(tosbmailboxdata),
+			  SDPCM_PROT_VERSION << SMB_DATA_VERSION_SHIFT, NULL);
+
+	err = sdio_enable_func(sdiod->func2);
+
+	inff_dbg(INFO, "enable F2: err=%d\n", err);
+
+	/* If F2 successfully enabled, set core and enable interrupts */
+	if (!err) {
+		/* Set up the interrupt mask and enable interrupts */
+		bus->hostintmask = HOSTINTMASK;
+		inff_sdiod_writel(sdiod, core->base + SD_REG(hostintmask),
+				  bus->hostintmask, NULL);
+
+		switch (sdiod->func1->device) {
+		case SDIO_DEVICE_ID_CYPRESS_55572:
+		case SDIO_DEVICE_ID_CYPRESS_55500:
+			inff_dbg(INFO, "set F2 watermark to 0x%x*4 bytes\n",
+				 INF55572_F2_WATERMARK);
+			inff_sdiod_writeb(sdiod, SBSDIO_WATERMARK,
+					  INF55572_F2_WATERMARK, &err);
+			devctl = inff_sdiod_readb(sdiod, SBSDIO_DEVICE_CTL,
+						  &err);
+			devctl |= SBSDIO_DEVCTL_F2WM_ENAB;
+			inff_sdiod_writeb(sdiod, SBSDIO_DEVICE_CTL, devctl,
+					  &err);
+			inff_sdiod_writeb(sdiod, SBSDIO_FUNC1_MESBUSYCTRL,
+					  INF55572_F1_MESBUSYCTRL, &err);
+			break;
+		case SDIO_DEVICE_ID_CYPRESS_43022:
+			inff_dbg(INFO, "set F2 watermark to 0x%x*4 bytes\n",
+				 INF43022_F2_WATERMARK);
+			inff_sdiod_writeb(sdiod, SBSDIO_WATERMARK,
+					  INF43022_F2_WATERMARK, &err);
+			devctl = inff_sdiod_readb(sdiod, SBSDIO_DEVICE_CTL,
+						  &err);
+			devctl |= SBSDIO_DEVCTL_F2WM_ENAB;
+			inff_sdiod_writeb(sdiod, SBSDIO_DEVICE_CTL, devctl,
+					  &err);
+			inff_sdiod_writeb(sdiod, SBSDIO_FUNC1_MESBUSYCTRL,
+					  INF43022_MESBUSYCTRL, &err);
+			break;
+		case SDIO_DEVICE_ID_CYPRESS_55900:
+			inff_dbg(INFO, "set F2 watermark to 0x%x*4 bytes\n",
+				 INF55900_F2_WATERMARK);
+			inff_sdiod_writeb(sdiod, SBSDIO_WATERMARK,
+					  INF55900_F2_WATERMARK, &err);
+			devctl = inff_sdiod_readb(sdiod, SBSDIO_DEVICE_CTL,
+						  &err);
+			devctl |= SBSDIO_DEVCTL_F2WM_ENAB;
+			inff_sdiod_writeb(sdiod, SBSDIO_DEVICE_CTL, devctl,
+					  &err);
+			inff_sdiod_writeb(sdiod, SBSDIO_FUNC1_MESBUSYCTRL,
+					  INF55900_F1_MESBUSYCTRL, &err);
+			break;
+		default:
+			inff_sdiod_writeb(sdiod, SBSDIO_WATERMARK,
+					  DEFAULT_F2_WATERMARK, &err);
+			break;
+		}
+	} else {
+		/* Disable F2 again */
+		sdio_disable_func(sdiod->func2);
+		goto checkdied;
+	}
+	if (inff_chip_sr_capable(bus->ci)) {
+		inff_sdio_sr_init(bus);
+	} else {
+		/* Restore previous clock setting */
+		inff_sdiod_writeb(sdiod, SBSDIO_FUNC1_CHIPCLKCSR,
+				  saveclk, &err);
+	}
+
+	if (err == 0) {
+		/* Assign bus interface call back */
+		sdiod->bus_if->dev = sdiod->dev;
+		sdiod->bus_if->ops = &inff_sdio_bus_ops;
+		sdiod->bus_if->chip = bus->ci->chip;
+		sdiod->bus_if->chiprev = bus->ci->chiprev;
+
+		/* Allow full data communication using DPC from now on. */
+		inff_sdiod_change_state(bus->sdiodev, INFF_SDIOD_DATA);
+
+		err = inff_sdiod_intr_register(sdiod);
+		if (err != 0)
+			inff_err("intr register failed:%d\n", err);
+		bus->sdiodev->redownload_fw = false;
+	}
+
+	/* If we didn't come up, turn off backplane clock */
+	if (err != 0) {
+		inff_sdio_clkctl(bus, CLK_NONE, false);
+		goto checkdied;
+	}
+
+	/* Start the watchdog timer */
+	bus->sdcnt.tickcnt = 0;
+	inff_sdio_wd_timer(bus, true);
+	sdio_release_host(sdiod->func1);
+
+	if (!bus->sdiodev->ulp ||
+	    (bus->sdiodev->ulp && bus->sdiodev->fmac_ulp.ulp_state != FMAC_ULP_TRIGGERED)) {
+		err = inff_alloc(sdiod->dev, sdiod->settings);
+		if (err) {
+			inff_err("inff_alloc failed\n");
+			goto claim;
+		}
+
+		/* Attach to the common layer, reserve hdr space */
+		err = inff_attach(sdiod->dev, !bus->sdiodev->ulp);
+		if (err != 0) {
+			inff_err("inff_attach failed\n");
+			goto free;
+		}
+
+#ifdef CONFIG_INFFMAC_BT_SHARED_SDIO
+		inff_btsdio_init(bus_if);
+#endif
+
+		/* Register for ULP events */
+		if (sdiod->func1->device == SDIO_DEVICE_ID_CYPRESS_43022)
+			inff_fweh_register(bus_if->drvr, INFF_E_ULP,
+					   inff_ulp_event_notify);
+	}
+
+	if (bus->sdiodev->ulp) {
+		/* For ULP, after firmware redownload complete
+		 * set ULP state to IDLE
+		 */
+		if (bus->sdiodev->fmac_ulp.ulp_state == FMAC_ULP_TRIGGERED)
+			bus->sdiodev->fmac_ulp.ulp_state = FMAC_ULP_IDLE;
+	}
+
+	return 0;
+
+free:
+	inff_free(sdiod->dev);
+claim:
+	sdio_claim_host(sdiod->func1);
+checkdied:
+	inff_sdio_checkdied(bus);
+release:
+	sdio_release_host(sdiod->func1);
+	return err;
+}
+
+static int inff_sdio_enable_func3(struct inff_bus *bus_if)
+{
+	struct inff_sdio_dev *sdiod = bus_if->bus_priv.sdio;
+	u8 val = 0;
+	int err = 0;
+
+	sdio_claim_host(sdiod->func1);
+
+	/* download CP FW first if user provide this module parameter */
+	if (sdiod->settings->firmware_path[0] != '\0') {
+		err = inff_dfu_start(sdiod);
+		if (err) {
+			inff_err("DFU first download failed: %d\n", err);
+			goto release;
+		}
+
+		/* wait for image ready */
+		msleep(5000);
+	}
+
+	/* Enable SDIO function 3 */
+	val = inff_sdiod_func0_rb(sdiod, SDIO_CCCR_IOEx, &err);
+	if (err) {
+		inff_err("Failed to read SDIO_CCCR_IOEx: err %d\n", err);
+		goto release;
+	}
+
+	val |= SDIO_CCCR_IEN_FUNC3;
+	inff_sdiod_func0_wb(sdiod, SDIO_CCCR_IOEx, val, &err);
+	if (err) {
+		inff_err("Failed to write SDIO_CCCR_IOEx: err %d\n", err);
+		goto release;
+	}
+
+	inff_dbg(INFO, "Enable F3 successfully\n");
+
+	sdio_release_host(sdiod->func1);
+
+	err = inff_sdio_enable_func2(bus_if);
+	if (err)
+		goto fail;
+
+	return 0;
+
+release:
+	sdio_release_host(sdiod->func1);
+fail:
+	return err;
+}
+
+static void inff_sdio_firmware_callback(struct device *dev, int err,
+					struct inff_fw_request *fwreq)
+{
+	struct inff_bus *bus_if = dev_get_drvdata(dev);
+	struct inff_sdio_dev *sdiod = bus_if->bus_priv.sdio;
+	struct inff_sdio *bus = sdiod->bus;
+	struct inff_chip_specific *chip_spec = &bus->ci->chip_spec;
+	const struct firmware *code;
+	void *nvram;
+	u32 nvram_len;
+
+	inff_dbg(ULP, "Enter: dev=%s, err=%d\n", dev_name(dev), err);
+
+	if (err)
+		goto fail;
+
+	code = fwreq->items[INFF_SDIO_FW_CODE].binary;
+	nvram = fwreq->items[INFF_SDIO_FW_NVRAM].nv_data.data;
+	nvram_len = fwreq->items[INFF_SDIO_FW_NVRAM].nv_data.len;
+	chip_spec->clm_fw = fwreq->items[INFF_SDIO_FW_CLM].binary;
+	kfree(fwreq);
+
+	/* try to download image and nvram to the dongle */
+	bus->alp_only = true;
+	if (bus->ci->chip == INF_CC_43022_CHIP_ID)
+		err = inff_sdio_download_firmware_43022(bus, code, nvram, nvram_len);
+	else
+		err = inff_sdio_download_firmware(bus, code, nvram, nvram_len);
+
+	if (err)
+		goto fail;
+	bus->alp_only = false;
+
+	err = inff_sdio_enable_func2(bus_if);
+	if (err)
+		goto fail;
+
+	/* ready */
+	return;
+
+fail:
+	inff_dbg(TRACE, "failed: dev=%s, err=%d\n", dev_name(dev), err);
+	device_release_driver(&sdiod->func2->dev);
+	device_release_driver(dev);
+}
+
+struct inff_sdio *inff_sdio_probe(struct inff_sdio_dev *sdiodev)
+{
+	int ret;
+	struct inff_sdio *bus;
+	struct workqueue_struct *wq;
+	struct inff_fw_request *fwreq;
+
+	inff_dbg(TRACE, "Enter\n");
+
+	/* Allocate private bus interface state */
+	bus = kzalloc(sizeof(*bus), GFP_ATOMIC);
+	if (!bus) {
+		ret = -ENOMEM;
+		goto fail;
+	}
+
+	bus->sdiodev = sdiodev;
+	sdiodev->bus = bus;
+	skb_queue_head_init(&bus->glom);
+	bus->txbound = INFF_TXBOUND;
+	bus->rxbound = INFF_RXBOUND;
+	bus->txminmax = INFF_TXMINMAX;
+	bus->tx_seq = SDPCM_SEQ_WRAP - 1;
+
+	/* single-threaded workqueue */
+	wq = alloc_ordered_workqueue("inff_wq/%s", WQ_MEM_RECLAIM | WQ_HIGHPRI,
+				     dev_name(&sdiodev->func1->dev));
+	if (!wq) {
+		inff_err("insufficient memory to create txworkqueue\n");
+		ret = -ENOMEM;
+		goto fail;
+	}
+	inff_sdiod_freezer_count(sdiodev);
+	INIT_WORK(&bus->datawork, inff_sdio_dataworker);
+	bus->inff_wq = wq;
+
+	/* attempt to attach to the dongle */
+	ret = inff_sdio_probe_attach(bus);
+	if (ret < 0) {
+		inff_err("inff_sdio_probe_attach failed\n");
+		goto fail;
+	}
+
+	spin_lock_init(&bus->rxctl_lock);
+	spin_lock_init(&bus->txq_lock);
+	init_waitqueue_head(&bus->ctrl_wait);
+	init_waitqueue_head(&bus->dcmd_resp_wait);
+	/* Initialize thread based operation and lock */
+	mutex_init(&bus->sdsem);
+
+	/* too early to have drvr */
+	if (sdiodev->settings->sdio_rxf_in_kthread_enabled) {
+		memset(&bus->skbbuf[0], 0, sizeof(void *) * MAXSKBPEND);
+		init_completion(&bus->thr_rxf_ctl.comp);
+		spin_lock_init(&bus->rxf_lock);
+		bus->thr_rxf_ctl.p_task = kthread_run(inff_sdio_rxf_thread,
+						      bus, "inff_rxf/%s",
+						      dev_name(&sdiodev->func1->dev));
+		if (IS_ERR(bus->thr_rxf_ctl.p_task)) {
+			inff_err("inff_sdio_rxf_thread failed to start\n");
+			bus->thr_rxf_ctl.p_task = NULL;
+		}
+	}
+
+	/* Set up the watchdog timer */
+	timer_setup(&bus->timer, inff_sdio_watchdog, 0);
+	/* Initialize watchdog thread */
+	init_completion(&bus->watchdog_wait);
+	bus->watchdog_tsk = kthread_run(inff_sdio_watchdog_thread,
+					bus, "inff_wdog/%s",
+					dev_name(&sdiodev->func1->dev));
+	if (IS_ERR(bus->watchdog_tsk)) {
+		pr_warn("inff_watchdog thread failed to start\n");
+		bus->watchdog_tsk = NULL;
+	}
+	/* Initialize DPC thread */
+	bus->dpc_triggered = false;
+	bus->dpc_running = false;
+
+	/* default sdio bus header length for tx packet */
+	bus->tx_hdrlen = SDPCM_HWHDR_LEN + SDPCM_SWHDR_LEN;
+
+	/* Query the F2 block size, set roundup accordingly */
+	bus->blocksize = bus->sdiodev->func2->cur_blksize;
+	bus->roundup = min(max_roundup, bus->blocksize);
+
+	sdio_claim_host(bus->sdiodev->func1);
+
+	/* Disable F2 to clear any intermediate frame state on the dongle */
+	sdio_disable_func(bus->sdiodev->func2);
+
+	bus->rxflow = false;
+
+	/* Done with backplane-dependent accesses, can drop clock... */
+	inff_sdiod_writeb(bus->sdiodev, SBSDIO_FUNC1_CHIPCLKCSR, 0, NULL);
+
+	sdio_release_host(bus->sdiodev->func1);
+
+	/* ...and initialize clock/power states */
+	bus->clkstate = CLK_SDONLY;
+
+	bus->idletime = sdiodev->settings->sdio_bus_idle_time;
+
+	if (sdiodev->settings->idleclk_disable == INFFMAC_DISABLE) {
+		bus->idleclock = INFF_IDLE_ACTIVE;
+	} else if (sdiodev->settings->idleclk_disable == INFFMAC_ENABLE) {
+		bus->idleclock = INFF_IDLE_STOP;
+	} else if (sdiodev->settings->idleclk_disable == INFFMAC_AUTO) {
+		if (sdiodev->func1->device == SDIO_DEVICE_ID_CYPRESS_43022)
+			bus->idleclock = INFF_IDLE_STOP;
+		else
+			bus->idleclock = INFF_IDLE_ACTIVE;
+	} else {
+		inff_err("unexpected idleclk_disable%d\n", sdiodev->settings->idleclk_disable);
+	}
+
+	/* SR state */
+	bus->sr_enabled = false;
+
+	inff_dbg(INFO, "completed!!\n");
+
+	switch (bus->ci->socitype) {
+	case SOCI_AI:
+		fwreq = inff_prepare_fw_request(sdiodev->settings->firmware_path,
+						bus->ci, inff_sdio_fwnames,
+						ARRAY_SIZE(inff_sdio_fwnames),
+						bus->sdiodev->settings->board_type);
+		if (!fwreq) {
+			ret = -ENOMEM;
+			goto fail;
+		}
+
+		ret = inff_fw_get_firmwares(sdiodev->dev, fwreq,
+					    inff_sdio_firmware_callback);
+		if (ret != 0) {
+			inff_err("async firmware request failed: %d\n", ret);
+			kfree(fwreq);
+			goto fail;
+		}
+		break;
+	case SOCI_CP:
+		ret = inff_sdio_enable_func3(sdiodev->bus_if);
+		if (ret) {
+			inff_err("sdio function init failed: %d\n", ret);
+			goto fail;
+		}
+		break;
+	default:
+		inff_err("chip type %u is not supported\n",
+			 bus->ci->socitype);
+		goto fail;
+	}
+
+	return bus;
+
+fail:
+	inff_sdio_remove(bus);
+	return ERR_PTR(ret);
+}
+
+/* Detach and free everything */
+void inff_sdio_remove(struct inff_sdio *bus)
+{
+	struct inff_chip_specific *chip_spec = &bus->ci->chip_spec;
+
+	inff_dbg(TRACE, "Enter\n");
+	if (bus) {
+		/* Stop watchdog task */
+		if (bus->watchdog_tsk) {
+			send_sig(SIGTERM, bus->watchdog_tsk, 1);
+			kthread_stop(bus->watchdog_tsk);
+			bus->watchdog_tsk = NULL;
+		}
+
+		if (bus->thr_rxf_ctl.p_task) {
+			send_sig(SIGTERM, bus->thr_rxf_ctl.p_task, 1);
+			kthread_stop(bus->thr_rxf_ctl.p_task);
+			bus->thr_rxf_ctl.p_task = NULL;
+		}
+
+		/* De-register interrupt handler */
+		inff_sdiod_intr_unregister(bus->sdiodev);
+
+		inff_detach(bus->sdiodev->dev);
+		inff_free(bus->sdiodev->dev);
+
+		cancel_work_sync(&bus->datawork);
+		if (bus->inff_wq)
+			destroy_workqueue(bus->inff_wq);
+
+		if (bus->ci) {
+			if (bus->sdiodev->state != INFF_SDIOD_NOMEDIUM) {
+				sdio_claim_host(bus->sdiodev->func1);
+				inff_sdio_wd_timer(bus, false);
+				inff_sdio_clkctl(bus, CLK_AVAIL, false);
+				/* Leave the device in state where it is
+				 * 'passive'. This is done by resetting all
+				 * necessary cores.
+				 */
+				msleep(20);
+				if (bus->sdiodev->fmac_ulp.ulp_state ==
+					FMAC_ULP_ENTRY_RECV) {
+					inff_chip_ulp_reset_lhl_regs(bus->ci);
+					inff_chip_reset_pmu_regs(bus->ci);
+				} else {
+					inff_chip_set_passive(bus->ci);
+				}
+
+				inff_sdio_reset(bus);
+
+				inff_sdio_clkctl(bus, CLK_NONE, false);
+				sdio_release_host(bus->sdiodev->func1);
+			}
+			inff_chip_detach(bus->ci);
+		}
+		if (bus->sdiodev->settings)
+			inff_release_module_param(bus->sdiodev->settings);
+
+		release_firmware(chip_spec->clm_fw);
+		chip_spec->clm_fw = NULL;
+#ifdef CONFIG_INFFMAC_BT_SHARED_SDIO
+		inff_btsdio_deinit(bus->sdiodev->bus_if);
+#endif /* CONFIG_INFFMAC_BT_SHARED_SDIO */
+#if IS_BUILTIN(CONFIG_MMC)
+		sdio_claim_host(bus->sdiodev->func1);
+		mmc_hw_reset(bus->sdiodev->func1->card);
+		sdio_release_host(bus->sdiodev->func1);
+#endif
+
+		kfree(bus->rxbuf);
+		kfree(bus->hdrbuf);
+		kfree(bus);
+	}
+
+	inff_dbg(TRACE, "Disconnected\n");
+}
+
+void inff_sdio_wd_timer(struct inff_sdio *bus, bool active)
+{
+	/* Totally stop the timer */
+	if (!active && bus->wd_active) {
+		timer_delete_sync(&bus->timer);
+		bus->wd_active = false;
+		return;
+	}
+
+	/* don't start the wd until fw is loaded */
+	if (bus->sdiodev->state != INFF_SDIOD_DATA)
+		return;
+
+	if (active) {
+		if (!bus->wd_active) {
+			/* Create timer again when watchdog period is
+			 * dynamically changed or in the first instance
+			 */
+			bus->timer.expires = jiffies + INFF_WD_POLL;
+			add_timer(&bus->timer);
+			bus->wd_active = true;
+		} else {
+			/* Re arm the timer, at last watchdog period */
+			mod_timer(&bus->timer, jiffies + INFF_WD_POLL);
+		}
+	}
+}
+
+int inff_sdio_sleep(struct inff_sdio *bus, bool sleep)
+{
+	int ret;
+
+	sdio_claim_host(bus->sdiodev->func1);
+	ret = inff_sdio_bus_sleep(bus, sleep, false);
+	sdio_release_host(bus->sdiodev->func1);
+
+	return ret;
+}
+
+/* Check F2 Ready bit before sending data to Firmware */
+static int
+inff_sdio_f2_ready(struct inff_sdio *bus)
+{
+	int ret = -1;
+	int iordy_status = 0;
+
+	sdio_claim_host(bus->sdiodev->func1);
+	/* Read the status of IOR2 */
+	iordy_status = inff_sdiod_func0_rb(bus->sdiodev, SDIO_CCCR_IORx, NULL);
+
+	sdio_release_host(bus->sdiodev->func1);
+	ret = iordy_status & SDIO_FUNC_ENABLE_2;
+	return ret;
+}
+
+static int inff_ulp_event_notify(struct inff_if *ifp,
+				 const struct inff_event_msg *evtmsg,
+				  void *data)
+{
+	int err = 0;
+	struct inff_bus *bus_if = ifp->drvr->bus_if;
+	struct inff_sdio_dev *sdiodev;
+	struct inff_sdio *bus;
+	struct inff_ulp_event *ulp_event = (struct inff_ulp_event *)data;
+
+	sdiodev = bus_if->bus_priv.sdio;
+	bus = sdiodev->bus;
+
+	inff_dbg(ULP, "Chip went to DS1 state : action %d\n",
+		 ulp_event->ulp_dongle_action);
+	if (ulp_event->ulp_dongle_action == FMAC_ULP_ENTRY)
+		bus->sdiodev->fmac_ulp.ulp_state = FMAC_ULP_ENTRY_RECV;
+
+	return err;
+}
+
+u32 inff_sdio_get_enum_addr(struct inff_sdio *bus)
+{
+	return bus->sdio_core->base;
+}
diff --git a/drivers/net/wireless/infineon/inffmac/sdio.h b/drivers/net/wireless/infineon/inffmac/sdio.h
new file mode 100644
index 000000000000..d9f7865b5a56
--- /dev/null
+++ b/drivers/net/wireless/infineon/inffmac/sdio.h
@@ -0,0 +1,553 @@
+/* SPDX-License-Identifier: ISC */
+/*
+ * Copyright (c) 2010 Broadcom Corporation
+ *
+ * Copyright (c) 2025, Infineon Technologies AG, or an affiliate of Infineon Technologies AG.
+ * All rights reserved.
+ */
+
+#ifndef	INFF_SDIO_H
+#define	INFF_SDIO_H
+
+#include <linux/skbuff.h>
+#include <linux/firmware.h>
+#include "firmware.h"
+
+#define SDIOD_FBR_SIZE		0x100
+
+/* io_en */
+#define SDIO_FUNC_ENABLE_1	0x02
+#define SDIO_FUNC_ENABLE_2	0x04
+
+/* io_rdys */
+#define SDIO_FUNC_READY_1	0x02
+#define SDIO_FUNC_READY_2	0x04
+
+/* intr_status */
+#define INTR_STATUS_FUNC1	0x2
+#define INTR_STATUS_FUNC2	0x4
+
+/* mask of register map */
+#define REG_F0_REG_MASK		0x7FF
+#define REG_F1_MISC_MASK	0x1FFFF
+
+#define INFF_SDIO_REG_DAR_H2D_MSG_0	0x10030
+#define INFF_SDIO_REG_DAR_D2H_MSG_0	0x10038
+
+#define INFF_SDIO_REG_D2H_MSG_0	0x1800204C
+#define INFF_SDIO_REG_H2D_MSG_0	0x18002048
+
+#define CM3_SOCRAM_WRITE_END_LOCATION	0x80000
+
+/* Sdio rev 27 only */
+/* To read secure-mode bit */
+#define SBSDIO_FUNC1_SECURE_MODE	0x10001
+
+/* function 0 vendor specific CCCR registers */
+
+#define SDIO_CCCR_INTR_PND			0x05
+#define SDIO_CCCR_IO_ABORT			0x06
+#define SDIO_CCCR_IO_ABORT_RES			BIT(3)
+#define SDIO_CCCR_INFF_CARDCAP			0xf0
+#define SDIO_CCCR_INFF_CARDCAP_CMD14_SUPPORT	BIT(1)
+#define SDIO_CCCR_INFF_CARDCAP_CMD14_EXT	BIT(2)
+#define SDIO_CCCR_INFF_CARDCAP_CMD_NODEC	BIT(3)
+#define SDIO_CCCR_INFF_CARDCAP_CHIPID_PRESENT	BIT(6)
+#define SDIO_CCCR_INFF_CARDCAP_SECURE_MODE	BIT(7)
+
+/* Interrupt enable bits for each function */
+#define SDIO_CCCR_IEN_FUNC0			BIT(0)
+#define SDIO_CCCR_IEN_FUNC1			BIT(1)
+#define SDIO_CCCR_IEN_FUNC2			BIT(2)
+#define SDIO_CCCR_IEN_FUNC3			BIT(3)
+
+#define SDIO_CCCR_INFF_CARDCTRL			0xf1
+#define SDIO_CCCR_INFF_CARDCTRL_WLANRESET	BIT(1)
+#define SDIO_CCCR_INFF_CARDCTRL_BTRESET		BIT(2)
+
+#define SDIO_CCCR_INFF_SEPINT			0xf2
+#define SDIO_CCCR_INFF_SEPINT_MASK		BIT(0)
+#define SDIO_CCCR_INFF_SEPINT_OE		BIT(1)
+#define SDIO_CCCR_INFF_SEPINT_ACT_HI		BIT(2)
+
+/* function 1 miscellaneous registers */
+
+/* sprom command and status */
+#define SBSDIO_SPROM_CS			0x10000
+/* sprom info register */
+#define SBSDIO_SPROM_INFO		0x10001
+/* sprom indirect access data byte 0 */
+#define SBSDIO_SPROM_DATA_LOW		0x10002
+/* sprom indirect access data byte 1 */
+#define SBSDIO_SPROM_DATA_HIGH		0x10003
+/* sprom indirect access addr byte 0 */
+#define SBSDIO_SPROM_ADDR_LOW		0x10004
+/* gpio select */
+#define SBSDIO_GPIO_SELECT		0x10005
+/* gpio output */
+#define SBSDIO_GPIO_OUT			0x10006
+/* gpio enable */
+#define SBSDIO_GPIO_EN			0x10007
+/* rev < 7, watermark for sdio device TX path */
+#define SBSDIO_WATERMARK		0x10008
+/* control busy signal generation */
+#define SBSDIO_DEVICE_CTL		0x10009
+
+/* SB Address Window Low (b15) */
+#define SBSDIO_FUNC1_SBADDRLOW		0x1000A
+/* SB Address Window Mid (b23:b16) */
+#define SBSDIO_FUNC1_SBADDRMID		0x1000B
+/* SB Address Window High (b31:b24)    */
+#define SBSDIO_FUNC1_SBADDRHIGH		0x1000C
+/* Frame Control (frame term/abort) */
+#define SBSDIO_FUNC1_FRAMECTRL		0x1000D
+/* ChipClockCSR (ALP/HT ctl/status) */
+#define SBSDIO_FUNC1_CHIPCLKCSR		0x1000E
+/* SdioPullUp (on cmd, d0-d2) */
+#define SBSDIO_FUNC1_SDIOPULLUP		0x1000F
+/* Write Frame Byte Count Low */
+#define SBSDIO_FUNC1_WFRAMEBCLO		0x10019
+/* Write Frame Byte Count High */
+#define SBSDIO_FUNC1_WFRAMEBCHI		0x1001A
+/* Read Frame Byte Count Low */
+#define SBSDIO_FUNC1_RFRAMEBCLO		0x1001B
+/* Read Frame Byte Count High */
+#define SBSDIO_FUNC1_RFRAMEBCHI		0x1001C
+/* MesBusyCtl (rev 11) */
+#define SBSDIO_FUNC1_MESBUSYCTRL	0x1001D
+/* Watermark for sdio device RX path */
+#define SBSDIO_MESBUSY_RXFIFO_WM_MASK	0x7F
+#define SBSDIO_MESBUSY_RXFIFO_WM_SHIFT	0
+/* Enable busy capability for MES access */
+#define SBSDIO_MESBUSYCTRL_ENAB		0x80
+#define SBSDIO_MESBUSYCTRL_ENAB_SHIFT	7
+
+/* Sdio Core Rev 12 */
+#define SBSDIO_FUNC1_WAKEUPCTRL		0x1001E
+#define SBSDIO_FUNC1_WCTRL_ALPWAIT_MASK		0x1
+#define SBSDIO_FUNC1_WCTRL_ALPWAIT_SHIFT	0
+#define SBSDIO_FUNC1_WCTRL_HTWAIT_MASK		0x2
+#define SBSDIO_FUNC1_WCTRL_HTWAIT_SHIFT		1
+#define SBSDIO_FUNC1_SLEEPCSR		0x1001F
+#define SBSDIO_FUNC1_SLEEPCSR_KSO_MASK		0x1
+#define SBSDIO_FUNC1_SLEEPCSR_KSO_SHIFT		0
+#define SBSDIO_FUNC1_SLEEPCSR_KSO_EN		1
+#define SBSDIO_FUNC1_SLEEPCSR_DEVON_MASK	0x2
+#define SBSDIO_FUNC1_SLEEPCSR_DEVON_SHIFT	1
+#define SBSDIO_FUNC1_SLEEPCSR_BT_KSO_MASK	0x4
+#define SBSDIO_FUNC1_SLEEPCSR_BT_KSO_SHIFT	2
+
+#define SBSDIO_FUNC1_MISC_REG_START	0x10000	/* f1 misc register start */
+#define SBSDIO_FUNC1_MISC_REG_LIMIT	0x1001F	/* f1 misc register end */
+
+/* Sdio Core Rev 31 */
+/* Hard Reset SDIO core, output soft reset signal which should cause backplane reset */
+#define SDIO_IO_CARD_RESET                0x08
+
+/* function 1 OCP space */
+
+/* sb offset addr is <= 15 bits, 32k */
+#define SBSDIO_SB_OFT_ADDR_MASK		0x07FFF
+#define SBSDIO_SB_OFT_ADDR_LIMIT	0x08000
+/* with b15, maps to 32-bit SB access */
+#define SBSDIO_SB_ACCESS_2_4B_FLAG	0x08000
+
+/* Address bits from SBADDR regs */
+#define SBSDIO_SBWINDOW_MASK		0xffff8000
+
+#define SDIOH_READ              0	/* Read request */
+#define SDIOH_WRITE             1	/* Write request */
+
+#define SDIOH_DATA_FIX          0	/* Fixed addressing */
+#define SDIOH_DATA_INC          1	/* Incremental addressing */
+
+/* internal return code */
+#define SUCCESS	0
+#define ERROR	1
+
+/* Packet alignment for most efficient SDIO (can change based on platform) */
+#define INFF_SDALIGN	BIT(6)
+
+/* watchdog polling interval */
+#define INFF_WD_POLL	msecs_to_jiffies(10)
+
+/* SDIO function number definition */
+#define SDIO_FUNC_0		0
+#define SDIO_FUNC_1		1
+#define SDIO_FUNC_2		2
+#define SDIO_FUNC_3		3
+#define SDIO_FUNC_4		4
+#define SDIO_FUNC_5		5
+#define SDIO_FUNC_6		6
+#define SDIO_FUNC_7		7
+
+/**
+ * enum inff_sdiod_state - the state of the bus.
+ *
+ * @INFF_SDIOD_DOWN: Device can be accessed, no DPC.
+ * @INFF_SDIOD_DATA: Ready for data transfers, DPC enabled.
+ * @INFF_SDIOD_NOMEDIUM: No medium access to dongle possible.
+ */
+enum inff_sdiod_state {
+	INFF_SDIOD_DOWN,
+	INFF_SDIOD_DATA,
+	INFF_SDIOD_NOMEDIUM
+};
+
+struct inff_sdreg {
+	int func;
+	int offset;
+	int value;
+};
+
+struct inff_sdio;
+struct inff_sdiod_freezer;
+
+/* ULP SHM Offsets info */
+struct ulp_shm_info {
+	u32 m_ulp_ctrl_sdio;
+	u32 m_ulp_wakeevt_ind;
+	u32 m_ulp_wakeind;
+	u32 m_ulp_phytxblk;
+};
+
+/* FMAC ULP state machine */
+#define FMAC_ULP_IDLE		(0)
+#define FMAC_ULP_ENTRY_RECV		(1)
+#define FMAC_ULP_TRIGGERED		(2)
+
+/* INFF_E_ULP event data */
+#define FMAC_ULP_EVENT_VERSION		1
+#define FMAC_ULP_DISABLE_CONSOLE		1 /* Disable console */
+#define FMAC_ULP_UCODE_DOWNLOAD		2 /* Download ULP ucode file */
+#define FMAC_ULP_ENTRY		3 /* Inform ulp entry to Host */
+
+struct inff_ulp {
+	uint ulp_state;
+	struct ulp_shm_info ulp_shm_offset;
+};
+
+struct inff_ulp_event {
+	u16 version;
+	u16 ulp_dongle_action;
+};
+
+struct inff_sdio_dev {
+	struct sdio_func *func1;
+	struct sdio_func *func2;
+	struct sdio_func *func3;
+	u32 sbwad;			/* Save backplane window address */
+	bool sbwad_valid;			/* Save backplane window address */
+	struct inff_core *cc_core;	/* chipcommon core info struct */
+	struct inff_sdio *bus;
+	struct device *dev;
+	struct inff_bus *bus_if;
+	struct inff_mp_device *settings;
+	bool oob_irq_requested;
+	bool sd_irq_requested;
+	bool irq_en;			/* irq enable flags */
+	spinlock_t irq_en_lock;
+	bool sg_support;
+	uint max_request_size;
+	ushort max_segment_count;
+	uint max_segment_size;
+	uint txglomsz;
+	struct sg_table sgtable;
+	bool wowl_enabled;
+	bool func1_power_manageable;
+	bool func2_power_manageable;
+	enum inff_sdiod_state state;
+	struct inff_sdiod_freezer *freezer;
+	struct inff_ulp fmac_ulp;
+	bool ulp;
+	bool redownload_fw;
+	bool ignore_bus_error;	/* Ignore SDIO Bus access error*/
+};
+
+/* sdio core registers */
+struct sdpcmd_regs {
+	u32 corecontrol;		/* 0x00, rev8 */
+	u32 corestatus;			/* rev8 */
+	u32 PAD[1];
+	u32 biststatus;			/* rev8 */
+
+	/* PCMCIA access */
+	u16 pcmciamesportaladdr;	/* 0x010, rev8 */
+	u16 PAD[1];
+	u16 pcmciamesportalmask;	/* rev8 */
+	u16 PAD[1];
+	u16 pcmciawrframebc;		/* rev8 */
+	u16 PAD[1];
+	u16 pcmciaunderflowtimer;	/* rev8 */
+	u16 PAD[1];
+
+	/* interrupt */
+	u32 intstatus;			/* 0x020, rev8 */
+	u32 hostintmask;		/* rev8 */
+	u32 intmask;			/* rev8 */
+	u32 sbintstatus;		/* rev8 */
+	u32 sbintmask;			/* rev8 */
+	u32 funcintmask;		/* rev4 */
+	u32 PAD[2];
+	u32 tosbmailbox;		/* 0x040, rev8 */
+	u32 tohostmailbox;		/* rev8 */
+	u32 tosbmailboxdata;		/* rev8 */
+	u32 tohostmailboxdata;		/* rev8 */
+
+	/* synchronized access to registers in SDIO clock domain */
+	u32 sdioaccess;			/* 0x050, rev8 */
+	u32 PAD[3];
+
+	/* PCMCIA frame control */
+	u8 pcmciaframectrl;		/* 0x060, rev8 */
+	u8 PAD[3];
+	u8 pcmciawatermark;		/* rev8 */
+	u8 PAD[155];
+
+	/* interrupt batching control */
+	u32 intrcvlazy;			/* 0x100, rev8 */
+	u32 PAD[3];
+
+	/* counters */
+	u32 cmd52rd;			/* 0x110, rev8 */
+	u32 cmd52wr;			/* rev8 */
+	u32 cmd53rd;			/* rev8 */
+	u32 cmd53wr;			/* rev8 */
+	u32 abort;			/* rev8 */
+	u32 datacrcerror;		/* rev8 */
+	u32 rdoutofsync;		/* rev8 */
+	u32 wroutofsync;		/* rev8 */
+	u32 writebusy;			/* rev8 */
+	u32 readwait;			/* rev8 */
+	u32 readterm;			/* rev8 */
+	u32 writeterm;			/* rev8 */
+	u32 PAD[40];
+	u32 clockctlstatus;		/* rev8 */
+	u32 PAD[7];
+
+	u32 PAD[76];			/* DMA engines */
+
+	u32 chipid;			/* SDIO ChipID Register, 0x330, rev31 */
+	u32 eromptr;			/* SDIO EromPtrOffset Register, 0x334, rev31 */
+	u32 PAD[50];
+
+	/* SDIO/PCMCIA CIS region */
+	char cis[512];			/* 0x400-0x5ff, rev6 */
+
+	/* PCMCIA function control registers */
+	char pcmciafcr[256];		/* 0x600-6ff, rev6 */
+	u16 PAD[55];
+
+	/* PCMCIA backplane access */
+	u16 backplanecsr;		/* 0x76E, rev6 */
+	u16 backplaneaddr0;		/* rev6 */
+	u16 backplaneaddr1;		/* rev6 */
+	u16 backplaneaddr2;		/* rev6 */
+	u16 backplaneaddr3;		/* rev6 */
+	u16 backplanedata0;		/* rev6 */
+	u16 backplanedata1;		/* rev6 */
+	u16 backplanedata2;		/* rev6 */
+	u16 backplanedata3;		/* rev6 */
+	u16 PAD[31];
+
+	/* sprom "size" & "blank" info */
+	u16 spromstatus;		/* 0x7BE, rev2 */
+	u32 PAD[464];
+
+	u16 PAD[0x80];
+};
+
+/* Register/deregister interrupt handler. */
+int inff_sdiod_intr_register(struct inff_sdio_dev *sdiodev);
+void inff_sdiod_intr_unregister(struct inff_sdio_dev *sdiodev);
+
+/* SDIO device register access interface */
+/* Accessors for SDIO Function 0 */
+#define inff_sdiod_func0_rb_ext(sdiodev, addr, r) \
+	sdio_f0_readb((sdiodev)->func1, (addr), (r))
+
+#define inff_sdiod_func0_wb_ext(sdiodev, addr, v, ret) \
+	sdio_f0_writeb((sdiodev)->func1, (v), (addr), (ret))
+
+/* Accessors for SDIO Function 1 */
+#define inff_sdiod_readb_ext(sdiodev, addr, r) \
+	sdio_readb((sdiodev)->func1, (addr), (r))
+
+#define inff_sdiod_writeb_ext(sdiodev, addr, v, ret) \
+	sdio_writeb((sdiodev)->func1, (v), (addr), (ret))
+
+/* Accessors for SDIO specific function number */
+#define inff_sdiod_func_rb_ext(func, addr, r) \
+	sdio_readb((func), (addr), (r))
+
+#define inff_sdiod_func_wb_ext(func, addr, v, ret) \
+	sdio_writeb((func), (v), (addr), (ret))
+
+u8 inff_sdiod_func0_rb(struct inff_sdio_dev *sdiodev, u32 addr, int *ret);
+void inff_sdiod_func0_wb(struct inff_sdio_dev *sdiodev, u32 addr, u32 data,
+			 int *ret);
+u8 inff_sdiod_readb(struct inff_sdio_dev *sdiodev, u32 addr, int *ret);
+void inff_sdiod_writeb(struct inff_sdio_dev *sdiodev, u32 addr, u32 data,
+		       int *ret);
+u8 inff_sdiod_func_rb(struct inff_sdio_dev *sdiodev, struct sdio_func *func, u32 addr, int *ret);
+void inff_sdiod_func_wb(struct inff_sdio_dev *sdiodev, struct sdio_func *func, u32 addr,
+			u32 data, int *ret);
+
+u32 inff_sdiod_readl(struct inff_sdio_dev *sdiodev, u32 addr, int *ret);
+void inff_sdiod_writel(struct inff_sdio_dev *sdiodev, u32 addr, u32 data,
+		       int *ret);
+
+/* Buffer transfer to/from device (client) core via cmd53.
+ *   fn:       function number
+ *   flags:    backplane width, address increment, sync/async
+ *   buf:      pointer to memory data buffer
+ *   nbytes:   number of bytes to transfer to/from buf
+ *   pkt:      pointer to packet associated with buf (if any)
+ *   complete: callback function for command completion (async only)
+ *   handle:   handle for completion callback (first arg in callback)
+ * Returns 0 or error code.
+ * NOTE: Async operation is not currently supported.
+ */
+int inff_sdiod_send_pkt(struct inff_sdio_dev *sdiodev,
+			struct sk_buff_head *pktq);
+int inff_sdiod_send_buf(struct inff_sdio_dev *sdiodev, u8 fn,
+			u8 *buf, uint nbytes);
+
+int inff_sdiod_recv_pkt(struct inff_sdio_dev *sdiodev, u8 fn,
+			struct sk_buff *pkt);
+int inff_sdiod_recv_buf(struct inff_sdio_dev *sdiodev, u8 fn,
+			u8 *buf, uint nbytes);
+int inff_sdiod_recv_chain(struct inff_sdio_dev *sdiodev,
+			  struct sk_buff_head *pktq, uint totlen);
+
+/* Flags bits */
+
+/* Four-byte target (backplane) width (vs. two-byte) */
+#define SDIO_REQ_4BYTE	0x1
+/* Fixed address (FIFO) (vs. incrementing address) */
+#define SDIO_REQ_FIXED	0x2
+
+/* Read/write to memory block (F1, no FIFO) via CMD53 (sync only).
+ *   rw:       read or write (0/1)
+ *   addr:     direct SDIO address
+ *   buf:      pointer to memory data buffer
+ *   nbytes:   number of bytes to transfer to/from buf
+ * Returns 0 or error code.
+ */
+int inff_sdiod_ramrw(struct inff_sdio_dev *sdiodev, bool write, u32 address,
+		     u8 *data, uint size);
+
+/* Issue an abort to the specified function */
+int inff_sdiod_abort(struct inff_sdio_dev *sdiodev, struct sdio_func *func);
+
+void inff_sdiod_sgtable_alloc(struct inff_sdio_dev *sdiodev);
+void inff_sdiod_change_state(struct inff_sdio_dev *sdiodev,
+			     enum inff_sdiod_state state);
+bool inff_sdiod_freezing(struct inff_sdio_dev *sdiodev);
+void inff_sdiod_try_freeze(struct inff_sdio_dev *sdiodev);
+void inff_sdiod_freezer_count(struct inff_sdio_dev *sdiodev);
+void inff_sdiod_freezer_uncount(struct inff_sdio_dev *sdiodev);
+
+int inff_sdiod_probe(struct inff_sdio_dev *sdiodev);
+int inff_sdiod_remove(struct inff_sdio_dev *sdiodev);
+
+struct inff_sdio *inff_sdio_probe(struct inff_sdio_dev *sdiodev);
+void inff_sdio_remove(struct inff_sdio *bus);
+void inff_sdio_isr(struct inff_sdio *bus, bool in_isr);
+
+void inff_sdio_wd_timer(struct inff_sdio *bus, bool active);
+void inff_sdio_wowl_config(struct device *dev, bool enabled);
+int inff_sdio_sleep(struct inff_sdio *bus, bool sleep);
+int inff_sdio_set_sdbus_clk_width(struct inff_sdio *bus, unsigned int flags);
+int inff_sdio_clkctl(struct inff_sdio *bus, uint target, bool pendok);
+bool inff_sdio_bus_sleep_state(struct inff_sdio *bus);
+void inff_sdio_trigger_dpc(struct inff_sdio *bus);
+u32 inff_sdio_get_enum_addr(struct inff_sdio *bus);
+
+/* SHM offsets */
+#define M_DS1_CTRL_SDIO(ptr)	((ptr).ulp_shm_offset.m_ulp_ctrl_sdio)
+#define M_WAKEEVENT_IND(ptr)	((ptr).ulp_shm_offset.m_ulp_wakeevt_ind)
+#define M_ULP_WAKE_IND(ptr)		((ptr).ulp_shm_offset.m_ulp_wakeind)
+#define M_DS1_PHYTX_ERR_BLK(ptr)	((ptr).ulp_shm_offset.m_ulp_phytxblk)
+
+#define D11_BASE_ADDR			0x18001000
+#define D11_AXI_BASE_ADDR		0xE8000000
+#define D11_SHM_BASE_ADDR		(D11_AXI_BASE_ADDR + 0x4000)
+
+#define D11REG_ADDR(offset)	(D11_BASE_ADDR + (offset))
+#define D11IHR_ADDR(offset)	(D11_AXI_BASE_ADDR + 0x400 + (2 * (offset)))
+#define D11SHM_ADDR(offset)	(D11_SHM_BASE_ADDR + (offset))
+
+/* MacControl register */
+#define D11_MACCONTROL_REG			D11REG_ADDR(0x120)
+#define D11_MACCONTROL_REG_WAKE		0x4000000
+
+/* HUDI Sequence SHM bits */
+#define	C_DS1_CTRL_SDIO_DS1_SLEEP		0x1
+#define	C_DS1_CTRL_SDIO_MAC_ON			0x2
+#define	C_DS1_CTRL_SDIO_RADIO_PHY_ON	0x4
+#define	C_DS1_CTRL_SDIO_DS1_EXIT		0x8
+#define	C_DS1_CTRL_PROC_DONE			0x100
+#define	C_DS1_CTRL_REQ_VALID			0x200
+
+/* M_ULP_WAKEIND bits */
+#define	C_WATCHDOG_EXPIRY	BIT(0)
+#define	C_FCBS_ERROR		BIT(1)
+#define	C_RETX_FAILURE		BIT(2)
+#define	C_HOST_WAKEUP		BIT(3)
+#define	C_INVALID_FCBS_BLOCK	BIT(4)
+#define	C_HUDI_DS1_EXIT		BIT(5)
+#define	C_LOB_SLEEP		BIT(6)
+#define	C_DS1_PHY_TXERR		BIT(9)
+#define	C_DS1_WAKE_TIMER	BIT(10)
+
+#define PHYTX_ERR_BLK_SIZE		18
+#define D11SHM_FIRST2BYTE_MASK		0xFFFF0000
+#define D11SHM_SECOND2BYTE_MASK		0x0000FFFF
+#define D11SHM_2BYTE_SHIFT		16
+
+#define D11SHM_RD(sdh, offset, ret) \
+	inff_sdiod_readl(sdh, D11SHM_ADDR(offset), ret)
+
+/* SHM Read is motified based on SHM 4 byte alignment as SHM size is 2 bytes and
+ * 2 byte is currently not working on FMAC
+ * If SHM address is not 4 byte aligned, then right shift by 16
+ * otherwise, mask the first two MSB bytes
+ * Suppose data in address 7260 is 0x440002 and it is 4 byte aligned
+ * Correct SHM value is 0x2 for this SHM offset and next SHM value is 0x44
+ */
+#define D11SHM_RDW(sdh, offset, ret) ({ \
+	typeof(sdh) _sdh = (sdh); \
+	typeof(offset) _offset = (offset); \
+	typeof(ret) _ret = (ret); \
+	((_offset % 4) ? \
+		(inff_sdiod_readl(_sdh, D11SHM_ADDR(_offset), _ret) \
+		>> D11SHM_2BYTE_SHIFT) : \
+		(inff_sdiod_readl(_sdh, D11SHM_ADDR(_offset), _ret) \
+		& D11SHM_SECOND2BYTE_MASK)); \
+	})
+
+/* SHM is of size 2 bytes, 4 bytes write will overwrite other SHM's
+ * First read 4 bytes and then clear the required two bytes based on
+ * 4 byte alignment, then update the required value and write the
+ * 4 byte value now
+ */
+#define D11SHM_WR(sdh, offset, val, mask, ret) \
+	do { \
+		typeof(offset) _offet = (offset); \
+		typeof(val) _val = (val); \
+		typeof(mask) _mask = (mask); \
+		if ((_offet) % 4) \
+			_val = (_val & D11SHM_SECOND2BYTE_MASK) | \
+				((_mask) << D11SHM_2BYTE_SHIFT); \
+		else \
+			_val = (_mask) | (_val & D11SHM_FIRST2BYTE_MASK); \
+		inff_sdiod_writel(sdh, D11SHM_ADDR(_offet), _val, ret); \
+	} while (0)
+#define D11REG_WR(sdh, addr, val, ret) \
+	inff_sdiod_writel(sdh, addr, val, ret)
+
+#define D11REG_RD(sdh, addr, ret) \
+	inff_sdiod_readl(sdh, addr, ret)
+
+#endif /* INFF_SDIO_H */
-- 
2.25.1


