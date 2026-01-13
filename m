Return-Path: <linux-wireless+bounces-30766-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D5F5D1B3F0
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jan 2026 21:39:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BC805304EDA9
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jan 2026 20:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C7523033FC;
	Tue, 13 Jan 2026 20:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b="SEJ3QKHE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp11.infineon.com (smtp11.infineon.com [217.10.52.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B86276051
	for <linux-wireless@vger.kernel.org>; Tue, 13 Jan 2026 20:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.52.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768336618; cv=none; b=j5rb9V8CcEmrQoSYikJHXYdP3u5Ss1k4+i0WmwaswA5tkKG9dRI2qcuUA+WcL5zemWleyUcjf4f7DUrE6IhVSIdex4tybbRKKYEGnDnSQ+ujkPMRRtklU88cEPfuIRepFN3IwHSxOus+y/TQ5V/wp7CjoEQmW/XXGbAF9hehqb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768336618; c=relaxed/simple;
	bh=rAeKRGS+jRUrVEz+RvVqlOzCkiKoNnS2o8HBaKEx8Lo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i5Uymj61ox8WlO3E/vGGnHZjXto8ZxpO2JvG8tRyqqNvMYfkF/KAG8bFb3Xdkl1RFAxqLr1i95Cb2zxVqHSqpVrnFti7EBBKagzqXvMfjq/Y31D0qLAM7+x/SHy4nx7oRD+gNBoefytbeyUN3aFGJUrywrJ7uHTjy0YA91u48Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com; spf=pass smtp.mailfrom=infineon.com; dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b=SEJ3QKHE; arc=none smtp.client-ip=217.10.52.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infineon.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1768336614; x=1799872614;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rAeKRGS+jRUrVEz+RvVqlOzCkiKoNnS2o8HBaKEx8Lo=;
  b=SEJ3QKHErXwxIzUtGDtfMQmzRbKxCtwhWxNiVEyyDAnhE60re0cqfyxH
   RYXxwwQTbSFFT/otRQEjLPN9qlPtUZdf0wyOfMUqqCpGNtQQvKWs+vRpG
   C8QFeXcFmDsJ4/qJZuNj5Nsx6L2QQ5uFcHSWArQZIfSe9dcEncpmONz4w
   s=;
X-CSE-ConnectionGUID: N4nAX31KReWzgTujtuQxtA==
X-CSE-MsgGUID: VcvH/MjYSoif9opQKQgFbg==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="126568263"
X-IronPort-AV: E=Sophos;i="6.21,222,1763420400"; 
   d="scan'208";a="126568263"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO MUCSE805.infineon.com) ([172.23.29.31])
  by smtp11.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 21:35:43 +0100
Received: from MUCSE827.infineon.com (172.23.29.20) by MUCSE805.infineon.com
 (172.23.29.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Tue, 13 Jan
 2026 21:35:42 +0100
Received: from ISCN5CG14747PP.infineon.com (10.161.6.196) by
 MUCSE827.infineon.com (172.23.29.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 13 Jan 2026 21:35:40 +0100
From: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
To: <linux-wireless@vger.kernel.org>
CC: Johannes Berg <johannes@sipsolutions.net>, Arend van Spriel
	<arend.vanspriel@broadcom.com>, <marex@nabladev.com>,
	<wlan-kernel-dev-list@infineon.com>, <gokulkumar.sivakumar@infineon.com>
Subject: [PATCH wireless-next v2 06/34] wifi: inffmac: add chip.c/h
Date: Wed, 14 Jan 2026 02:03:19 +0530
Message-ID: <20260113203350.16734-7-gokulkumar.sivakumar@infineon.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260113203350.16734-1-gokulkumar.sivakumar@infineon.com>
References: <20260113203350.16734-1-gokulkumar.sivakumar@infineon.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MUCSE802.infineon.com (172.23.29.28) To
 MUCSE827.infineon.com (172.23.29.20)

Driver implementation for managing the chip and also do the chip operations
needed for the Infineon-proprietary secured firmware architecture. This new
secure firmware architecture demands a unique vendor-specific handshake
between the host machine and new Infineon chipsets for both bring up and
normal operation, because of firmware encryption and firmware signature
validation.

Signed-off-by: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
---
 drivers/net/wireless/infineon/inffmac/chip.c | 1626 ++++++++++++++++++
 drivers/net/wireless/infineon/inffmac/chip.h |  636 +++++++
 2 files changed, 2262 insertions(+)
 create mode 100644 drivers/net/wireless/infineon/inffmac/chip.c
 create mode 100644 drivers/net/wireless/infineon/inffmac/chip.h

diff --git a/drivers/net/wireless/infineon/inffmac/chip.c b/drivers/net/wireless/infineon/inffmac/chip.c
new file mode 100644
index 000000000000..ee66bb2dba03
--- /dev/null
+++ b/drivers/net/wireless/infineon/inffmac/chip.c
@@ -0,0 +1,1626 @@
+// SPDX-License-Identifier: ISC
+/*
+ * Copyright (c) 2014 Broadcom Corporation
+ *
+ * Copyright (c) 2025-2026, Infineon Technologies AG, or an affiliate of Infineon Technologies AG.
+ * All rights reserved.
+ */
+#include <linux/kernel.h>
+#include <linux/delay.h>
+#include <linux/list.h>
+#include <linux/mmc/sdio_ids.h>
+#include <linux/ssb/ssb_regs.h>
+
+#include "main.h"
+#include "utils.h"
+#include "debug.h"
+#include "chip.h"
+#include "chip_43022.h"
+#include "chip_5551x.h"
+#include "chip_5557x.h"
+#include "chip_5591x.h"
+
+#define INFF_SI_ENUM_BASE_DEFAULT	0x18000000
+
+/* Chipcommon Core CHIPID */
+#define	CID_ID_MASK		0x0000ffff	/* Chip Id mask */
+#define	CID_REV_MASK		0x000f0000	/* Chip Revision mask */
+#define	CID_REV_SHIFT		16		/* Chip Revision shift */
+#define	CID_PKG_MASK		0x00f00000	/* Package Option mask */
+#define	CID_PKG_SHIFT		20		/* Package Option shift */
+#define	CID_CC_MASK		0x0f000000	/* CoreCount (corerev >= 4) */
+#define CID_CC_SHIFT		24
+#define	CID_TYPE_MASK		0xf0000000	/* Chip Type */
+#define CID_TYPE_SHIFT		28
+
+/* Chipcommon capabilities */
+#define	CC_CAP_UARTS_MASK	0x00000003	/* Number of UARTs */
+#define CC_CAP_MIPSEB		0x00000004	/* MIPS is in big-endian mode */
+#define CC_CAP_UCLKSEL		0x00000018	/* UARTs clock select */
+/* UARTs are driven by internal divided clock */
+#define CC_CAP_UINTCLK		0x00000008
+#define CC_CAP_UARTGPIO		0x00000020	/* UARTs own GPIOs 15:12 */
+#define CC_CAP_EXTBUS_MASK	0x000000c0	/* External bus mask */
+#define CC_CAP_EXTBUS_NONE	0x00000000	/* No ExtBus present */
+#define CC_CAP_EXTBUS_FULL	0x00000040	/* ExtBus: PCMCIA, IDE & Prog */
+#define CC_CAP_EXTBUS_PROG	0x00000080	/* ExtBus: ProgIf only */
+#define	CC_CAP_FLASH_MASK	0x00000700	/* Type of flash */
+#define	CC_CAP_PLL_MASK		0x00038000	/* Type of PLL */
+#define CC_CAP_PWR_CTL		0x00040000	/* Power control */
+#define CC_CAP_OTPSIZE		0x00380000	/* OTP Size (0 = none) */
+#define CC_CAP_OTPSIZE_SHIFT	19		/* OTP Size shift */
+#define CC_CAP_OTPSIZE_BASE	5		/* OTP Size base */
+#define CC_CAP_JTAGP		0x00400000	/* JTAG Master Present */
+#define CC_CAP_ROM		0x00800000	/* Internal boot rom active */
+#define CC_CAP_BKPLN64		0x08000000	/* 64-bit backplane */
+#define	CC_CAP_PMU		0x10000000	/* PMU Present, rev >= 20 */
+#define	CC_CAP_SROM		0x40000000	/* Srom Present, rev >= 32 */
+/* Nand flash present, rev >= 35 */
+#define	CC_CAP_NFLASH		0x80000000
+
+#define	CC_CAP2_SECI		0x00000001	/* SECI Present, rev >= 36 */
+/* GSIO (spi/i2c) present, rev >= 37 */
+#define	CC_CAP2_GSIO		0x00000002
+
+/* Chip Common registers */
+/* PMU registers (rev >= 20) */
+#define INF_CC_PMU_CTL                 0x0600		/* PMU control */
+#define  INF_CC_PMU_CTL_ILP_DIV        0xFFFF0000	/* ILP div mask */
+#define  INF_CC_PMU_CTL_ILP_DIV_SHIFT  16
+#define  INF_CC_PMU_CTL_RES            0x00006000	/* reset control mask */
+#define  INF_CC_PMU_CTL_RES_SHIFT      13
+#define  INF_CC_PMU_CTL_RES_RELOAD     0x2		/* reload POR values */
+#define  INF_CC_PMU_CTL_PLL_UPD        0x00000400
+#define  INF_CC_PMU_CTL_NOILPONW       0x00000200	/* No ILP on wait */
+#define  INF_CC_PMU_CTL_HTREQEN        0x00000100	/* HT req enable */
+#define  INF_CC_PMU_CTL_ALPREQEN       0x00000080	/* ALP req enable */
+#define  INF_CC_PMU_CTL_XTALFREQ       0x0000007C	/* Crystal freq */
+#define  INF_CC_PMU_CTL_XTALFREQ_SHIFT 2
+#define  INF_CC_PMU_CTL_ILPDIVEN       0x00000002	/* ILP div enable */
+#define  INF_CC_PMU_CTL_LPOSEL         0x00000001	/* LPO sel */
+
+#define INF_CC_CAP_EXT                 0x00AC		/* Capabilities */
+#define  INF_CC_CAP_EXT_SECI_PRESENT   0x00000001
+#define  INF_CC_CAP_EXT_GSIO_PRESENT   0x00000002
+#define  INF_CC_CAP_EXT_GCI_PRESENT    0x00000004
+#define  INF_CC_CAP_EXT_SECI_PUART_PRESENT	0x00000008    /* UART present */
+#define  INF_CC_CAP_EXT_SRENG_REG_PRESENT       0x00000010
+#define  INF_CC_CAP_EXT_ASCU_PRESENT   0x00000020
+#define  INF_CC_CAP_EXT_AOB_PRESENT    0x00000040
+
+#define INF_CC_SROM_CONTROL            0x0190
+#define  INF_CC_SROM_CONTROL_START     0x80000000
+#define  INF_CC_SROM_CONTROL_BUSY      0x80000000
+#define  INF_CC_SROM_CONTROL_OPCODE    0x60000000
+#define  INF_CC_SROM_CONTROL_OP_READ   0x00000000
+#define  INF_CC_SROM_CONTROL_OP_WRITE  0x20000000
+#define  INF_CC_SROM_CONTROL_OP_WRDIS  0x40000000
+#define  INF_CC_SROM_CONTROL_OP_WREN   0x60000000
+#define  INF_CC_SROM_CONTROL_OTPSEL    0x00000010
+#define  INF_CC_SROM_CONTROL_OTP_PRESENT       0x00000020
+#define  INF_CC_SROM_CONTROL_LOCK      0x00000008
+#define  INF_CC_SROM_CONTROL_SIZE_MASK 0x00000006
+#define  INF_CC_SROM_CONTROL_SIZE_1K   0x00000000
+#define  INF_CC_SROM_CONTROL_SIZE_4K   0x00000002
+#define  INF_CC_SROM_CONTROL_SIZE_16K  0x00000004
+#define  INF_CC_SROM_CONTROL_SIZE_SHIFT        1
+#define  INF_CC_SROM_CONTROL_PRESENT   0x00000001
+
+/* PMU CORE */
+/* pmucapabilities */
+#define PCAP_REV_MASK	0x000000ff
+#define PCAP_RC_MASK	0x00001f00
+#define PCAP_RC_SHIFT	8
+#define PCAP_TC_MASK	0x0001e000
+#define PCAP_TC_SHIFT	13
+#define PCAP_PC_MASK	0x001e0000
+#define PCAP_PC_SHIFT	17
+#define PCAP_VC_MASK	0x01e00000
+#define PCAP_VC_SHIFT	21
+#define PCAP_CC_MASK	0x1e000000
+#define PCAP_CC_SHIFT	25
+#define PCAP5_PC_MASK	0x003e0000	/* PMU corerev >= 5 */
+#define PCAP5_PC_SHIFT	17
+#define PCAP5_VC_MASK	0x07c00000
+#define PCAP5_VC_SHIFT	22
+#define PCAP5_CC_MASK	0xf8000000
+#define PCAP5_CC_SHIFT	27
+/* pmucapabilites_ext PMU rev >= 15 */
+#define PCAPEXT_SR_SUPPORTED_MASK       BIT(1)
+/* retention_ctl PMU rev >= 15 */
+#define PMU_RCTL_MACPHY_DISABLE_MASK    BIT(26)
+#define PMU_RCTL_LOGIC_DISABLE_MASK     BIT(27)
+
+/*
+ * Maximum delay for the PMU state transition in us.
+ * This is an upper bound intended for spinwaits etc.
+ */
+#define PMU_MAX_TRANSITION_DLY	15000
+
+/* SR CORE */
+/* sr_control0, rev >= 48 */
+#define CC_SR_CTL0_ENABLE_MASK			BIT(0)
+#define CC_SR_CTL0_ENABLE_SHIFT		0
+#define CC_SR_CTL0_EN_SR_ENG_CLK_SHIFT	1 /* sr_clk to sr_memory enable */
+#define CC_SR_CTL0_RSRC_TRIGGER_SHIFT	2 /* Rising edge resource trigger 0 to
+					   * sr_engine
+					   */
+#define CC_SR_CTL0_MIN_DIV_SHIFT	6 /* Min division value for fast clk
+					   * in sr_engine
+					   */
+#define CC_SR_CTL0_EN_SBC_STBY_SHIFT		16
+#define CC_SR_CTL0_EN_SR_ALP_CLK_MASK_SHIFT	18
+#define CC_SR_CTL0_EN_SR_HT_CLK_SHIFT		19
+#define CC_SR_CTL0_ALLOW_PIC_SHIFT	20 /* Allow pic to separate power
+					    * domains
+					    */
+#define CC_SR_CTL0_MAX_SR_LQ_CLK_CNT_SHIFT	25
+#define CC_SR_CTL0_EN_MEM_DISABLE_FOR_SLEEP	30
+
+#define INFF_IOCTL			0x0408	/* IO control */
+#define  INFF_IOCTL_CLK			0x0001
+#define  INFF_IOCTL_FGC			0x0002
+#define INFF_RESET_CTL			0x0800
+#define  INFF_RESET_CTL_RESET		0x0001
+
+/* PL-368 DMP definitions */
+#define DMP_DESC_TYPE_MSK	0x0000000F
+#define  DMP_DESC_EMPTY		0x00000000
+#define  DMP_DESC_VALID		0x00000001
+#define  DMP_DESC_COMPONENT	0x00000001
+#define  DMP_DESC_MASTER_PORT	0x00000003
+#define  DMP_DESC_ADDRESS	0x00000005
+#define  DMP_DESC_ADDRSIZE_GT32	0x00000008
+#define  DMP_DESC_EOT		0x0000000F
+
+#define DMP_COMP_DESIGNER	0xFFF00000
+#define DMP_COMP_DESIGNER_S	20
+#define DMP_COMP_PARTNUM	0x000FFF00
+#define DMP_COMP_PARTNUM_S	8
+#define DMP_COMP_CLASS		0x000000F0
+#define DMP_COMP_CLASS_S	4
+#define DMP_COMP_REVISION	0xFF000000
+#define DMP_COMP_REVISION_S	24
+#define DMP_COMP_NUM_SWRAP	0x00F80000
+#define DMP_COMP_NUM_SWRAP_S	19
+#define DMP_COMP_NUM_MWRAP	0x0007C000
+#define DMP_COMP_NUM_MWRAP_S	14
+#define DMP_COMP_NUM_SPORT	0x00003E00
+#define DMP_COMP_NUM_SPORT_S	9
+#define DMP_COMP_NUM_MPORT	0x000001F0
+#define DMP_COMP_NUM_MPORT_S	4
+
+#define DMP_MASTER_PORT_UID	0x0000FF00
+#define DMP_MASTER_PORT_UID_S	8
+#define DMP_MASTER_PORT_NUM	0x000000F0
+#define DMP_MASTER_PORT_NUM_S	4
+
+#define DMP_SLAVE_ADDR_BASE	0xFFFFF000
+#define DMP_SLAVE_ADDR_BASE_S	12
+#define DMP_SLAVE_PORT_NUM	0x00000F00
+#define DMP_SLAVE_PORT_NUM_S	8
+#define DMP_SLAVE_TYPE		0x000000C0
+#define DMP_SLAVE_TYPE_S	6
+#define  DMP_SLAVE_TYPE_SLAVE	0
+#define  DMP_SLAVE_TYPE_BRIDGE	1
+#define  DMP_SLAVE_TYPE_SWRAP	2
+#define  DMP_SLAVE_TYPE_MWRAP	3
+#define DMP_SLAVE_SIZE_TYPE	0x00000030
+#define DMP_SLAVE_SIZE_TYPE_S	4
+#define  DMP_SLAVE_SIZE_4K	0
+#define  DMP_SLAVE_SIZE_8K	1
+#define  DMP_SLAVE_SIZE_16K	2
+#define  DMP_SLAVE_SIZE_DESC	3
+
+/* ARM CR4 core specific control flag bits */
+#define ARMCR4_INFF_IOCTL_CPUHALT	0x0020
+
+/* D11 core specific control flag bits */
+#define D11_INFF_IOCTL_PHYCLOCKEN	0x0004
+#define D11_INFF_IOCTL_PHYRESET		0x0008
+
+/* chip core base & ramsize */
+
+/* Max possibly supported memory size (limited by IO mapped memory) */
+#define INFF_CHIP_MAX_MEMSIZE		(4 * 1024 * 1024)
+
+#define INVALID_RAMBASE			((u32)(~0))
+
+/* bankidx and bankinfo reg defines corerev >= 8 */
+#define SOCRAM_BANKINFO_RETNTRAM_MASK	0x00010000
+#define SOCRAM_BANKINFO_SZMASK		0x0000007f
+#define SOCRAM_BANKIDX_ROM_MASK		0x00000100
+
+#define SOCRAM_BANKIDX_MEMTYPE_SHIFT	8
+/* socram bankinfo memtype */
+#define SOCRAM_MEMTYPE_RAM		0
+#define SOCRAM_MEMTYPE_R0M		1
+#define SOCRAM_MEMTYPE_DEVRAM		2
+
+#define SOCRAM_BANKINFO_SZBASE		8192
+#define	SRCI_SRNB_MASK		0xf0
+#define	SRCI_SRNB_MASK_EXT	0x100
+#define	SRCI_SRNB_SHIFT		4
+
+struct inff_sbsocramregs {
+	u32 coreinfo;
+	u32 bwalloc;
+	u32 extracoreinfo;
+	u32 biststat;
+	u32 bankidx;
+	u32 standbyctrl;
+
+	u32 errlogstatus;	/* rev 6 */
+	u32 errlogaddr;	/* rev 6 */
+	/* used for patching rev 3 & 5 */
+	u32 cambankidx;
+	u32 cambankstandbyctrl;
+	u32 cambankpatchctrl;
+	u32 cambankpatchtblbaseaddr;
+	u32 cambankcmdreg;
+	u32 cambankdatareg;
+	u32 cambankmaskreg;
+	u32 pad0[1];
+	u32 bankinfo;	/* corev 8 */
+	u32 bankpda;
+	u32 pad1[14];
+	u32 extmemconfig;
+	u32 extmemparitycsr;
+	u32 extmemparityerrdata;
+	u32 extmemparityerrcnt;
+	u32 extmemwrctrlandsize;
+	u32 pad2[84];
+	u32 workaround;
+	u32 pwrctl;		/* corerev >= 2 */
+	u32 pad3[133];
+	u32 sr_control;     /* corerev >= 15 */
+	u32 sr_status;      /* corerev >= 15 */
+	u32 sr_address;     /* corerev >= 15 */
+	u32 sr_data;        /* corerev >= 15 */
+};
+
+#define SOCRAMREGOFFS(_f)	offsetof(struct inff_sbsocramregs, _f)
+#define SYSMEMREGOFFS(_f)	offsetof(struct inff_sbsocramregs, _f)
+
+#define ARMCR4_CAP		(0x04)
+#define ARMCR4_BANKIDX		(0x40)
+#define ARMCR4_BANKINFO		(0x44)
+#define ARMCR4_BANKPDA		(0x4C)
+
+#define	ARMCR4_TCBBNB_MASK	0xf0
+#define	ARMCR4_TCBBNB_SHIFT	4
+#define	ARMCR4_TCBANB_MASK	0xf
+#define	ARMCR4_TCBANB_SHIFT	0
+
+#define	ARMCR4_BSZ_MASK		0x7f
+#define	ARMCR4_BSZ_MULT		8192
+#define	ARMCR4_BLK_1K_MASK	0x200
+
+#define INFF_BLHS_POLL_INTERVAL			10	/* msec */
+#define INFF_BLHS_D2H_READY_TIMEOUT			100	/* msec */
+#define INFF_BLHS_D2H_TRXHDR_PARSE_DONE_TIMEOUT	50	/* msec */
+
+#define INFF_BLHS_D2H_VALDN_DONE_TIMEOUT		1000	/* msec */
+#define INFF_BLHS_D2H_MV_NVRAM_DONE_TIMEOUT		(100)	/* msec */
+#define INFF_BLHS_D2H_BP_CLK_DISABLE_REQ_TIMEOUT	(5 * 1000)	/* msec */
+
+/* Bootloader handshake flags - dongle to host */
+#define INFF_BLHS_D2H_START			BIT(0)
+#define INFF_BLHS_D2H_READY			BIT(1)
+#define INFF_BLHS_D2H_STEADY			BIT(2)
+#define INFF_BLHS_D2H_TRXHDR_PARSE_DONE	BIT(3)
+#define INFF_BLHS_D2H_VALDN_START		BIT(4)
+#define INFF_BLHS_D2H_VALDN_RESULT		BIT(5)
+#define INFF_BLHS_D2H_VALDN_DONE		BIT(6)
+#define INFF_BLHS_D2H_MV_NVRAM_DONE		BIT(7)
+#define INFF_BLHS_D2H_BP_CLK_DISABLE_REQ	BIT(8)
+
+/* Bootloader handshake flags - host to dongle */
+#define INFF_BLHS_H2D_DL_FW_START		BIT(0)
+#define INFF_BLHS_H2D_DL_FW_DONE		BIT(1)
+#define INFF_BLHS_H2D_DL_NVRAM_DONE		BIT(2)
+#define INFF_BLHS_H2D_BL_RESET_ON_ERROR	BIT(3)
+#define INFF_BLHS_H2D_DL_NVRAM_START		BIT(4)
+#define INFF_BLHS_H2D_BP_CLK_DISABLE_ACK	BIT(5)
+
+static bool inff_chip_ai_iscoreup(struct inff_core_priv *core)
+{
+	struct inff_chip_priv *ci;
+	u32 regdata;
+	bool ret;
+
+	ci = core->chip;
+	regdata = ci->ops->read32(ci->ctx, core->wrapbase + INFF_IOCTL);
+	ret = (regdata & (INFF_IOCTL_FGC | INFF_IOCTL_CLK)) == INFF_IOCTL_CLK;
+
+	regdata = ci->ops->read32(ci->ctx, core->wrapbase + INFF_RESET_CTL);
+	ret = ret && ((regdata & INFF_RESET_CTL_RESET) == 0);
+
+	return ret;
+}
+
+static void inff_chip_ai_coredisable(struct inff_core_priv *core,
+				     u32 prereset, u32 reset)
+{
+	struct inff_chip_priv *ci;
+	u32 regdata;
+
+	ci = core->chip;
+
+	/* if core is already in reset, skip reset */
+	regdata = ci->ops->read32(ci->ctx, core->wrapbase + INFF_RESET_CTL);
+	if ((regdata & INFF_RESET_CTL_RESET) != 0)
+		goto in_reset_configure;
+
+	/* configure reset */
+	ci->ops->write32(ci->ctx, core->wrapbase + INFF_IOCTL,
+			 prereset | INFF_IOCTL_FGC | INFF_IOCTL_CLK);
+	ci->ops->read32(ci->ctx, core->wrapbase + INFF_IOCTL);
+
+	/* put in reset */
+	ci->ops->write32(ci->ctx, core->wrapbase + INFF_RESET_CTL,
+			 INFF_RESET_CTL_RESET);
+	usleep_range(10, 20);
+
+	/* wait till reset is 1 */
+	SPINWAIT(ci->ops->read32(ci->ctx, core->wrapbase + INFF_RESET_CTL) !=
+		 INFF_RESET_CTL_RESET, 300);
+
+in_reset_configure:
+	/* in-reset configure */
+	ci->ops->write32(ci->ctx, core->wrapbase + INFF_IOCTL,
+			 reset | INFF_IOCTL_FGC | INFF_IOCTL_CLK);
+	ci->ops->read32(ci->ctx, core->wrapbase + INFF_IOCTL);
+}
+
+static void inff_chip_ai_resetcore(struct inff_core_priv *core, u32 prereset,
+				   u32 reset, u32 postreset)
+{
+	struct inff_chip_priv *ci;
+	int count;
+	struct inff_core *d11core2 = NULL;
+	struct inff_core_priv *d11priv2 = NULL;
+
+	ci = core->chip;
+
+	/* special handle two D11 cores reset */
+	if (core->pub.id == INF_CORE_80211) {
+		d11core2 = inff_chip_get_d11core(&ci->pub, 1);
+		if (d11core2) {
+			inff_dbg(INFO, "found two d11 cores, reset both\n");
+			d11priv2 = container_of(d11core2,
+						struct inff_core_priv, pub);
+		}
+	}
+
+	/* must disable first to work for arbitrary current core state */
+	inff_chip_ai_coredisable(core, prereset, reset);
+	if (d11priv2)
+		inff_chip_ai_coredisable(d11priv2, prereset, reset);
+
+	count = 0;
+	while (ci->ops->read32(ci->ctx, core->wrapbase + INFF_RESET_CTL) &
+	       INFF_RESET_CTL_RESET) {
+		ci->ops->write32(ci->ctx, core->wrapbase + INFF_RESET_CTL, 0);
+		count++;
+		if (count > 50)
+			break;
+		usleep_range(40, 60);
+	}
+
+	if (d11priv2) {
+		count = 0;
+		while (ci->ops->read32(ci->ctx,
+				       d11priv2->wrapbase + INFF_RESET_CTL) &
+				       INFF_RESET_CTL_RESET) {
+			ci->ops->write32(ci->ctx,
+					 d11priv2->wrapbase + INFF_RESET_CTL,
+					 0);
+			count++;
+			if (count > 50)
+				break;
+			usleep_range(40, 60);
+		}
+	}
+
+	ci->ops->write32(ci->ctx, core->wrapbase + INFF_IOCTL,
+			 postreset | INFF_IOCTL_CLK);
+	ci->ops->read32(ci->ctx, core->wrapbase + INFF_IOCTL);
+
+	if (d11priv2) {
+		ci->ops->write32(ci->ctx, d11priv2->wrapbase + INFF_IOCTL,
+				 postreset | INFF_IOCTL_CLK);
+		ci->ops->read32(ci->ctx, d11priv2->wrapbase + INFF_IOCTL);
+	}
+}
+
+char *inff_chip_name(u32 id, u32 rev, char *buf, uint len)
+{
+	const char *fmt;
+
+	fmt = ((id > 0xa000) || (id < 0x4000)) ? "BCM%d/%u" : "BCM%x/%u";
+	snprintf(buf, len, fmt, id, rev);
+	return buf;
+}
+
+static bool inff_chip_find_coreid(struct inff_chip_priv *ci, u16 coreid)
+{
+	struct inff_core_priv *core;
+
+	list_for_each_entry(core, &ci->cores, list) {
+		inff_dbg(TRACE, " core 0x%x:%-2d base 0x%08x wrap 0x%08x\n",
+			 core->pub.id, core->pub.rev, core->pub.base,
+			 core->wrapbase);
+		if (core->pub.id == coreid)
+			return true;
+	}
+
+	return false;
+}
+
+static struct inff_core *inff_chip_add_core(struct inff_chip_priv *ci,
+					    u16 coreid, u32 base,
+					    u32 wrapbase)
+{
+	struct inff_core_priv *core;
+
+	core = kzalloc(sizeof(*core), GFP_KERNEL);
+	if (!core)
+		return ERR_PTR(-ENOMEM);
+
+	core->pub.id = coreid;
+	core->pub.base = base;
+	core->chip = ci;
+	core->wrapbase = wrapbase;
+
+	list_add_tail(&core->list, &ci->cores);
+	return &core->pub;
+}
+
+/* safety check for chipinfo */
+static int inff_chip_cores_check(struct inff_chip_priv *ci)
+{
+	struct inff_core_priv *core;
+	bool need_socram = false;
+	bool has_socram = false;
+	bool cpu_found = false;
+	int idx = 1;
+
+	list_for_each_entry(core, &ci->cores, list) {
+		inff_dbg(INFO, " [%-2d] core 0x%x:%-3d base 0x%08x wrap 0x%08x\n",
+			 idx++, core->pub.id, core->pub.rev, core->pub.base,
+			  core->wrapbase);
+
+		switch (core->pub.id) {
+		case INF_CORE_ARM_CM3:
+			cpu_found = true;
+			need_socram = true;
+			break;
+		case INF_CORE_INTERNAL_MEM:
+			has_socram = true;
+			break;
+		case INF_CORE_ARM_CR4:
+			cpu_found = true;
+			break;
+		default:
+			break;
+		}
+	}
+
+	if (!cpu_found) {
+		inff_err("CPU core not detected\n");
+		return -ENXIO;
+	}
+	/* check RAM core presence for ARM CM3 core */
+	if (need_socram && !has_socram) {
+		inff_err("RAM core not provided with ARM CM3 core\n");
+		return -ENODEV;
+	}
+	return 0;
+}
+
+static u32 inff_chip_core_read32(struct inff_core_priv *core, u16 reg)
+{
+	return core->chip->ops->read32(core->chip->ctx, core->pub.base + reg);
+}
+
+static void inff_chip_core_write32(struct inff_core_priv *core,
+				   u16 reg, u32 val)
+{
+	core->chip->ops->write32(core->chip->ctx, core->pub.base + reg, val);
+}
+
+static bool inff_chip_socram_banksize(struct inff_core_priv *core, u8 idx,
+				      u32 *banksize)
+{
+	u32 bankinfo;
+	u32 bankidx = (SOCRAM_MEMTYPE_RAM << SOCRAM_BANKIDX_MEMTYPE_SHIFT);
+
+	bankidx |= idx;
+	inff_chip_core_write32(core, SOCRAMREGOFFS(bankidx), bankidx);
+	bankinfo = inff_chip_core_read32(core, SOCRAMREGOFFS(bankinfo));
+	*banksize = (bankinfo & SOCRAM_BANKINFO_SZMASK) + 1;
+	*banksize *= SOCRAM_BANKINFO_SZBASE;
+	return !!(bankinfo & SOCRAM_BANKINFO_RETNTRAM_MASK);
+}
+
+static void inff_chip_socram_ramsize(struct inff_core_priv *sr, u32 *ramsize,
+				     u32 *srsize)
+{
+	u32 coreinfo;
+	uint nb, banksize;
+	bool retent;
+	int i;
+
+	*ramsize = 0;
+	*srsize = 0;
+
+	/* chip has its own specific pre-assigned ramsize. */
+	if (sr->chip->pub.chip_spec.hw_chip_ramsize) {
+		*ramsize = sr->chip->pub.chip_spec.hw_chip_ramsize;
+		return;
+	}
+
+	if (WARN_ON(sr->pub.rev < 4))
+		return;
+
+	if (!inff_chip_iscoreup(&sr->pub))
+		inff_chip_resetcore(&sr->pub, 0, 0, 0);
+
+	/* Get info for determining size */
+	coreinfo = inff_chip_core_read32(sr, SOCRAMREGOFFS(coreinfo));
+
+	/* length of SRAM Banks increased for corerev greater than 23 */
+	nb = (coreinfo & (SRCI_SRNB_MASK | SRCI_SRNB_MASK_EXT)) >> SRCI_SRNB_SHIFT;
+	for (i = 0; i < nb; i++) {
+		retent = inff_chip_socram_banksize(sr, i, &banksize);
+		*ramsize += banksize;
+		if (retent)
+			*srsize += banksize;
+	}
+}
+
+/** Return the SYS MEM size */
+static u32 inff_chip_sysmem_ramsize(struct inff_core_priv *sysmem)
+{
+	u32 memsize = 0;
+	u32 coreinfo;
+	u32 idx;
+	u32 nb;
+	u32 banksize;
+
+	if (!inff_chip_iscoreup(&sysmem->pub))
+		inff_chip_resetcore(&sysmem->pub, 0, 0, 0);
+
+	coreinfo = inff_chip_core_read32(sysmem, SYSMEMREGOFFS(coreinfo));
+	nb = (coreinfo & SRCI_SRNB_MASK) >> SRCI_SRNB_SHIFT;
+
+	for (idx = 0; idx < nb; idx++) {
+		inff_chip_socram_banksize(sysmem, idx, &banksize);
+		memsize += banksize;
+	}
+
+	return memsize;
+}
+
+/** Return the TCM-RAM size of the ARMCR4 core. */
+static u32 inff_chip_tcm_ramsize(struct inff_core_priv *cr4)
+{
+	u32 corecap;
+	u32 memsize = 0;
+	u32 nab;
+	u32 nbb;
+	u32 totb;
+	u32 bxinfo;
+	u32 blksize;
+	u32 idx;
+
+	corecap = inff_chip_core_read32(cr4, ARMCR4_CAP);
+
+	nab = (corecap & ARMCR4_TCBANB_MASK) >> ARMCR4_TCBANB_SHIFT;
+	nbb = (corecap & ARMCR4_TCBBNB_MASK) >> ARMCR4_TCBBNB_SHIFT;
+	totb = nab + nbb;
+
+	for (idx = 0; idx < totb; idx++) {
+		inff_chip_core_write32(cr4, ARMCR4_BANKIDX, idx);
+		bxinfo = inff_chip_core_read32(cr4, ARMCR4_BANKINFO);
+		blksize = ARMCR4_BSZ_MULT;
+		if (bxinfo & ARMCR4_BLK_1K_MASK)
+			blksize >>= 3;
+
+		memsize += ((bxinfo & ARMCR4_BSZ_MASK) + 1) * blksize;
+	}
+
+	return memsize;
+}
+
+static u32 inff_chip_tcm_rambase(struct inff_chip_priv *ci)
+{
+	if (ci) {
+		if (ci->pub.chip_spec.hw_chip_rambase)
+			return ci->pub.chip_spec.hw_chip_rambase;
+
+		inff_err("chip: %s hasn't assigned rambase.\n", ci->pub.name);
+	}
+	return INVALID_RAMBASE;
+}
+
+int inff_chip_get_raminfo(struct inff_chip *pub)
+{
+	struct inff_chip_priv *ci = container_of(pub, struct inff_chip_priv,
+						  pub);
+	struct inff_core_priv *mem_core;
+	struct inff_core *mem;
+
+	mem = inff_chip_get_core(&ci->pub, INF_CORE_ARM_CR4);
+	if (mem) {
+		mem_core = container_of(mem, struct inff_core_priv, pub);
+		ci->pub.ramsize = inff_chip_tcm_ramsize(mem_core);
+
+		ci->pub.ramsize -= (pub->chip_spec.hw_chip_tcam_size +
+				    pub->chip_spec.hw_chip_trxhdr_size);
+
+		ci->pub.rambase = inff_chip_tcm_rambase(ci);
+		if (ci->pub.rambase == INVALID_RAMBASE) {
+			inff_err("RAM base not provided with ARM CR4 core\n");
+			return -EINVAL;
+		}
+	} else {
+		mem = inff_chip_get_core(&ci->pub, INF_CORE_SYS_MEM);
+		if (mem) {
+			mem_core = container_of(mem, struct inff_core_priv,
+						pub);
+			ci->pub.ramsize = inff_chip_sysmem_ramsize(mem_core);
+			ci->pub.rambase = inff_chip_tcm_rambase(ci);
+			if (ci->pub.rambase == INVALID_RAMBASE) {
+				inff_err("RAM base not provided with ARM CA7 core\n");
+				return -EINVAL;
+			}
+		} else {
+			mem = inff_chip_get_core(&ci->pub,
+						 INF_CORE_INTERNAL_MEM);
+			if (!mem) {
+				inff_err("No memory cores found\n");
+				return -ENOMEM;
+			}
+			mem_core = container_of(mem, struct inff_core_priv,
+						pub);
+			inff_chip_socram_ramsize(mem_core, &ci->pub.ramsize,
+						 &ci->pub.srsize);
+		}
+	}
+	inff_dbg(INFO, "RAM: base=0x%x size=%d (0x%x) sr=%d (0x%x)\n",
+		 ci->pub.rambase, ci->pub.ramsize, ci->pub.ramsize,
+		 ci->pub.srsize, ci->pub.srsize);
+
+	if (!ci->pub.ramsize) {
+		inff_err("RAM size is undetermined\n");
+		return -ENOMEM;
+	}
+
+	if (ci->pub.ramsize > INFF_CHIP_MAX_MEMSIZE) {
+		inff_err("RAM size is incorrect\n");
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static u32 inff_chip_dmp_get_desc(struct inff_chip_priv *ci, u32 *eromaddr,
+				  u8 *type)
+{
+	u32 val;
+
+	/* read next descriptor */
+	val = ci->ops->read32(ci->ctx, *eromaddr);
+	*eromaddr += 4;
+
+	if (!type)
+		return val;
+
+	/* determine descriptor type */
+	*type = (val & DMP_DESC_TYPE_MSK);
+	if ((*type & ~DMP_DESC_ADDRSIZE_GT32) == DMP_DESC_ADDRESS)
+		*type = DMP_DESC_ADDRESS;
+
+	return val;
+}
+
+static int inff_chip_dmp_get_regaddr(struct inff_chip_priv *ci, u32 *eromaddr,
+				     u32 *regbase, u32 *wrapbase)
+{
+	u8 desc;
+	u32 val, szdesc;
+	u8 stype, sztype, wraptype;
+
+	*regbase = 0;
+	*wrapbase = 0;
+
+	val = inff_chip_dmp_get_desc(ci, eromaddr, &desc);
+	if (desc == DMP_DESC_MASTER_PORT) {
+		wraptype = DMP_SLAVE_TYPE_MWRAP;
+	} else if (desc == DMP_DESC_ADDRESS) {
+		/* revert erom address */
+		*eromaddr -= 4;
+		wraptype = DMP_SLAVE_TYPE_SWRAP;
+	} else {
+		*eromaddr -= 4;
+		return -EILSEQ;
+	}
+
+	do {
+		/* locate address descriptor */
+		do {
+			val = inff_chip_dmp_get_desc(ci, eromaddr, &desc);
+			/* unexpected table end */
+			if (desc == DMP_DESC_EOT) {
+				*eromaddr -= 4;
+				return -EFAULT;
+			}
+		} while (desc != DMP_DESC_ADDRESS &&
+			 desc != DMP_DESC_COMPONENT);
+
+		/* stop if we crossed current component border */
+		if (desc == DMP_DESC_COMPONENT) {
+			*eromaddr -= 4;
+			return 0;
+		}
+
+		/* skip upper 32-bit address descriptor */
+		if (val & DMP_DESC_ADDRSIZE_GT32)
+			inff_chip_dmp_get_desc(ci, eromaddr, NULL);
+
+		sztype = (val & DMP_SLAVE_SIZE_TYPE) >> DMP_SLAVE_SIZE_TYPE_S;
+
+		/* next size descriptor can be skipped */
+		if (sztype == DMP_SLAVE_SIZE_DESC) {
+			szdesc = inff_chip_dmp_get_desc(ci, eromaddr, NULL);
+			/* skip upper size descriptor if present */
+			if (szdesc & DMP_DESC_ADDRSIZE_GT32)
+				inff_chip_dmp_get_desc(ci, eromaddr, NULL);
+		}
+
+		/* look for 4K or 8K register regions */
+		if (sztype != DMP_SLAVE_SIZE_4K &&
+		    sztype != DMP_SLAVE_SIZE_8K)
+			continue;
+
+		stype = (val & DMP_SLAVE_TYPE) >> DMP_SLAVE_TYPE_S;
+
+		/* only regular slave and wrapper */
+		if (*regbase == 0 && stype == DMP_SLAVE_TYPE_SLAVE)
+			*regbase = val & DMP_SLAVE_ADDR_BASE;
+		if (*wrapbase == 0 && stype == wraptype)
+			*wrapbase = val & DMP_SLAVE_ADDR_BASE;
+	} while (*regbase == 0 || *wrapbase == 0);
+
+	return 0;
+}
+
+static
+int inff_chip_dmp_erom_scan(struct inff_chip_priv *ci)
+{
+	struct inff_core *core;
+	u32 eromaddr;
+	u8 desc_type = 0;
+	u32 val;
+	u16 id;
+	u8 nmw, nsw, rev;
+	u32 base, wrap;
+	int err;
+
+	if (ci->pub.ccsec)
+		eromaddr = ci->pub.ccsec->erombase;
+	else
+		eromaddr = ci->ops->read32(ci->ctx,
+				   CORE_CC_REG(ci->pub.enum_base, eromptr));
+
+	while (desc_type != DMP_DESC_EOT) {
+		val = inff_chip_dmp_get_desc(ci, &eromaddr, &desc_type);
+		if (!(val & DMP_DESC_VALID))
+			continue;
+
+		if (desc_type == DMP_DESC_EMPTY)
+			continue;
+
+		/* need a component descriptor */
+		if (desc_type != DMP_DESC_COMPONENT)
+			continue;
+
+		id = (val & DMP_COMP_PARTNUM) >> DMP_COMP_PARTNUM_S;
+
+		/* next descriptor must be component as well */
+		val = inff_chip_dmp_get_desc(ci, &eromaddr, &desc_type);
+		if (WARN_ON((val & DMP_DESC_TYPE_MSK) != DMP_DESC_COMPONENT))
+			return -EFAULT;
+
+		/* only look at cores with master port(s) */
+		nmw = (val & DMP_COMP_NUM_MWRAP) >> DMP_COMP_NUM_MWRAP_S;
+		nsw = (val & DMP_COMP_NUM_SWRAP) >> DMP_COMP_NUM_SWRAP_S;
+		rev = (val & DMP_COMP_REVISION) >> DMP_COMP_REVISION_S;
+
+		/* need core with ports */
+		if (nmw + nsw == 0 &&
+		    id != INF_CORE_PMU &&
+		    id != INF_CORE_GCI &&
+			id != INF_CORE_SR)
+			continue;
+
+		/* try to obtain register address info */
+		err = inff_chip_dmp_get_regaddr(ci, &eromaddr, &base, &wrap);
+		if (err)
+			continue;
+
+		/* finally a core to be added */
+		core = inff_chip_add_core(ci, id, base, wrap);
+		if (IS_ERR(core))
+			return PTR_ERR(core);
+
+		core->rev = rev;
+	}
+
+	return 0;
+}
+
+inline
+u32 inff_chip_enum_base(u16 devid)
+{
+	return INFF_SI_ENUM_BASE_DEFAULT;
+}
+
+inline
+u32 inff_chip_get_hw_caps_replaycnts(struct inff_chip *pub)
+{
+	return pub->chip_spec.hw_caps_replaycnts;
+}
+
+static void inff_blhs_init(struct inff_chip *pub)
+{
+	struct inff_chip_priv *chip;
+	u32 addr;
+
+	chip = container_of(pub, struct inff_chip_priv, pub);
+	addr = pub->blhs->h2d;
+	inff_dbg(TRACE,
+		 "h2d value before initing: 0x%08x (addr 0x%08x)\n",
+		 pub->blhs->read(chip->ctx, addr),
+		 addr);
+	pub->blhs->write(chip->ctx, addr, 0);
+}
+
+static int inff_blhs_is_bootloader_ready(struct inff_chip_priv *chip)
+{
+	u32 regdata;
+	u32 addr;
+
+	addr = chip->pub.blhs->d2h;
+	SPINWAIT_MS((chip->pub.blhs->read(chip->ctx, addr) &
+		    INFF_BLHS_D2H_READY) == 0,
+		    INFF_BLHS_D2H_READY_TIMEOUT,
+		    INFF_BLHS_POLL_INTERVAL);
+
+	regdata = chip->pub.blhs->read(chip->ctx, addr);
+	if (!(regdata & INFF_BLHS_D2H_READY)) {
+		inff_err("Timeout waiting for bootloader ready, waittime %d ms addr 0x%x\n",
+			 INFF_BLHS_D2H_READY_TIMEOUT,
+			 addr);
+		return -EPERM;
+	}
+
+	inff_dbg(TRACE, "bootloader is ready\n");
+	return 0;
+}
+
+static int inff_blhs_pre_nvram_download(struct inff_chip *pub)
+{
+	struct inff_chip_priv *chip;
+	u32 addr;
+	int err;
+
+	/* Host indication for bootloader to start the init */
+	inff_blhs_init(pub);
+
+	chip = container_of(pub, struct inff_chip_priv, pub);
+	err = inff_blhs_is_bootloader_ready(chip);
+	if (err)
+		return err;
+
+	/* Host notification about NVRAM download start */
+	addr = pub->blhs->h2d;
+	pub->blhs->write(chip->ctx, addr, INFF_BLHS_H2D_DL_NVRAM_START);
+
+	return 0;
+}
+
+static int inff_blhs_ack_wait_dongle_access(struct inff_chip *pub)
+{
+	struct inff_chip_priv *chip;
+	u32 addr;
+	int err = 0;
+
+	chip = container_of(pub, struct inff_chip_priv, pub);
+
+	addr = pub->blhs->d2h;
+	SPINWAIT_MS((pub->blhs->read(chip->ctx, addr) &
+		     INFF_BLHS_D2H_BP_CLK_DISABLE_REQ) == 0,
+		    INFF_BLHS_D2H_BP_CLK_DISABLE_REQ_TIMEOUT,
+		    INFF_BLHS_POLL_INTERVAL);
+
+	addr = pub->blhs->h2d;
+	pub->blhs->write(chip->ctx, addr, INFF_BLHS_H2D_BP_CLK_DISABLE_ACK);
+
+	if (chip->ops->get_intr_pend)
+		err = chip->ops->get_intr_pend(chip->ctx);
+
+	return err;
+}
+
+static int inff_blhs_prep_fw_download(struct inff_chip *pub)
+{
+	struct inff_chip_priv *chip;
+	u32 addr;
+	int err;
+
+	chip = container_of(pub, struct inff_chip_priv, pub);
+	/* Host indication for bootloader to start the init */
+	if (!(pub->chip == INF_CC_43022_CHIP_ID)) {
+		inff_blhs_init(pub);
+
+		chip = container_of(pub, struct inff_chip_priv, pub);
+		err = inff_blhs_is_bootloader_ready(chip);
+		if (err)
+			return err;
+	}
+	/* Host notification about FW download start */
+	addr = pub->blhs->h2d;
+	pub->blhs->write(chip->ctx, addr, INFF_BLHS_H2D_DL_FW_START);
+
+	return 0;
+}
+
+static int inff_blhs_post_fw_download(struct inff_chip *pub)
+{
+	struct inff_chip_priv *chip;
+	u32 addr;
+	u32 regdata;
+	int err = 0;
+
+	chip = container_of(pub, struct inff_chip_priv, pub);
+	addr = pub->blhs->h2d;
+	pub->blhs->write(chip->ctx, addr, INFF_BLHS_H2D_DL_FW_DONE);
+
+	if (pub->chip == INF_CC_43022_CHIP_ID) {
+		err = inff_blhs_ack_wait_dongle_access(pub);
+	} else {
+		addr = pub->blhs->d2h;
+		SPINWAIT_MS((pub->blhs->read(chip->ctx, addr) &
+			     INFF_BLHS_D2H_TRXHDR_PARSE_DONE) == 0,
+			    INFF_BLHS_D2H_TRXHDR_PARSE_DONE_TIMEOUT,
+			    INFF_BLHS_POLL_INTERVAL);
+
+		regdata = pub->blhs->read(chip->ctx, addr);
+		if (!(regdata & INFF_BLHS_D2H_TRXHDR_PARSE_DONE)) {
+			inff_err("TRX header parsing failed\n");
+
+			/* Host indication for bootloader to get reset on error */
+			addr = pub->blhs->h2d;
+			regdata = pub->blhs->read(chip->ctx, addr);
+			regdata |= INFF_BLHS_H2D_BL_RESET_ON_ERROR;
+			pub->blhs->write(chip->ctx, addr, regdata);
+
+			return -EPERM;
+		}
+	}
+
+	return err;
+}
+
+static int inff_blhs_post_nvram_download(struct inff_chip *pub)
+{
+	struct inff_chip_priv *chip;
+	u32 addr;
+	u32 regdata;
+
+	chip = container_of(pub, struct inff_chip_priv, pub);
+	addr = pub->blhs->h2d;
+	if (pub->chip == INF_CC_43022_CHIP_ID) {
+		regdata = pub->blhs->read(chip->ctx, addr);
+		regdata |= INFF_BLHS_H2D_DL_NVRAM_DONE;
+		pub->blhs->write(chip->ctx, addr, regdata);
+
+		addr = pub->blhs->d2h;
+		SPINWAIT_MS((pub->blhs->read(chip->ctx, addr) &
+			     INFF_BLHS_D2H_MV_NVRAM_DONE) == 0,
+			    INFF_BLHS_D2H_MV_NVRAM_DONE_TIMEOUT,
+			    INFF_BLHS_POLL_INTERVAL);
+		/* check if the NVRAM move has been done */
+		regdata = pub->blhs->read(chip->ctx, addr);
+		if ((regdata & INFF_BLHS_D2H_MV_NVRAM_DONE)) {
+			inff_dbg(INFO,
+				 "NVRAM moved to the end of the RAM. regdata 0x%08x\n",
+				 regdata);
+		} else {
+		/* Timeout waiting for the NVRAM to be moved to the end of the RAM. */
+			inff_err("Timeout: %dms for INFF_BLHS_D2H_MV_NVRAM_DONE regdata 0x%08x\n",
+				 INFF_BLHS_D2H_MV_NVRAM_DONE_TIMEOUT, regdata);
+			return -EPERM;
+		}
+	} else {
+		regdata = pub->blhs->read(chip->ctx, addr);
+		regdata |= INFF_BLHS_H2D_DL_NVRAM_DONE;
+		pub->blhs->write(chip->ctx, addr, regdata);
+	}
+	return 0;
+}
+
+static int inff_blhs_chk_validation(struct inff_chip *pub)
+{
+	struct inff_chip_priv *chip;
+	u32 addr;
+	u32 regdata;
+
+	chip = container_of(pub, struct inff_chip_priv, pub);
+	addr = pub->blhs->d2h;
+	SPINWAIT_MS((pub->blhs->read(chip->ctx, addr) &
+		    INFF_BLHS_D2H_VALDN_DONE) == 0,
+		    INFF_BLHS_D2H_VALDN_DONE_TIMEOUT,
+		    INFF_BLHS_POLL_INTERVAL);
+
+	regdata = pub->blhs->read(chip->ctx, addr);
+	if (!(regdata & INFF_BLHS_D2H_VALDN_DONE) ||
+	    !(regdata & INFF_BLHS_D2H_VALDN_RESULT)) {
+		inff_err("TRX image validation check failed, timeout %d\n",
+			 INFF_BLHS_D2H_VALDN_DONE_TIMEOUT);
+
+		/* Host notification for bootloader to get reset on error */
+		addr = pub->blhs->h2d;
+		regdata = pub->blhs->read(chip->ctx, addr);
+		regdata |= INFF_BLHS_H2D_BL_RESET_ON_ERROR;
+		pub->blhs->write(chip->ctx, addr, regdata);
+
+		return -EPERM;
+	}
+
+	inff_dbg(INFO, "TRX Image validation check completed successfully\n");
+	return 0;
+}
+
+static int inff_blhs_post_watchdog_reset(struct inff_chip *pub)
+{
+	struct inff_chip_priv *chip;
+	int err;
+
+	/* Host indication for bootloader to start the init */
+	inff_blhs_init(pub);
+
+	chip = container_of(pub, struct inff_chip_priv, pub);
+	err = inff_blhs_is_bootloader_ready(chip);
+
+	return err;
+}
+
+static int inff_chip_recognition(struct inff_chip_priv *ci)
+{
+	u32 regdata;
+	int ret;
+	const u32 READ_FAILED = 0xFFFFFFFF;
+
+	/* Get CC core rev
+	 * Chipid is in bus core if CC space is protected or
+	 * it is assume to be at offset 0 from SI_ENUM_BASE
+	 * For different chiptypes or old sdio hosts w/o chipcommon,
+	 * other ways of recognition should be added here.
+	 */
+	if (ci->pub.ccsec)
+		regdata = ci->pub.ccsec->chipid;
+	else
+		regdata = ci->ops->read32(ci->ctx,
+				  CORE_CC_REG(ci->pub.enum_base, chipid));
+	if (regdata == READ_FAILED) {
+		inff_err("MMIO read failed: 0x%08x\n", regdata);
+		return -ENODEV;
+	}
+
+	ci->pub.chip = regdata & CID_ID_MASK;
+	ci->pub.chiprev = (regdata & CID_REV_MASK) >> CID_REV_SHIFT;
+	ci->pub.socitype = (regdata & CID_TYPE_MASK) >> CID_TYPE_SHIFT;
+
+	inff_chip_name(ci->pub.chip, ci->pub.chiprev,
+		       ci->pub.name, sizeof(ci->pub.name));
+	inff_dbg(INFO, "found %s chip: %s\n",
+		 ci->pub.socitype == INFF_SOCI_AI ? "AXI" : "N/A", ci->pub.name);
+
+	switch (ci->pub.chip) {
+	case INF_CC_5557X_CHIP_ID:
+		inff_chip_5557x_init(&ci->pub);
+		break;
+	case INF_CC_5551X_CHIP_ID:
+		inff_chip_5551x_init(&ci->pub);
+		break;
+	case INF_CC_43022_CHIP_ID:
+		inff_chip_43022_init(&ci->pub);
+		break;
+	case INF_CC_5591X_CHIP_ID:
+		inff_chip_5591x_init(&ci->pub);
+		break;
+	default:
+		inff_err("chip %u is not supported\n",
+			 ci->pub.chip);
+		return -ENODEV;
+	}
+
+	switch (ci->pub.socitype) {
+	case INFF_SOCI_AI:
+		ci->iscoreup = inff_chip_ai_iscoreup;
+		ci->coredisable = inff_chip_ai_coredisable;
+		ci->resetcore = inff_chip_ai_resetcore;
+		break;
+	case INFF_SOCI_CP:
+		break;
+	default:
+		inff_err("chip backplane type %u is not supported\n",
+			 ci->pub.socitype);
+		return -ENODEV;
+	}
+
+	inff_chip_dmp_erom_scan(ci);
+
+	ret = inff_chip_cores_check(ci);
+	if (ret)
+		return ret;
+
+	if (ci->pub.socitype == INFF_SOCI_CP) {
+		if (ci->ops->reset)
+			ci->ops->reset(ci->ctx, &ci->pub);
+		return 0;
+	}
+	/* assure chip is passive for core access */
+	inff_chip_set_passive(&ci->pub);
+
+	/* Call bus specific reset function now. Cores have been determined
+	 * but further access may require a chip specific reset at this point.
+	 */
+	if (ci->ops->reset) {
+		ci->ops->reset(ci->ctx, &ci->pub);
+		inff_chip_set_passive(&ci->pub);
+	}
+
+	return inff_chip_get_raminfo(&ci->pub);
+}
+
+static int inff_chip_setup(struct inff_chip_priv *chip)
+{
+	struct inff_chip *pub;
+	struct inff_core_priv *cc;
+	struct inff_core *pmu;
+	u32 base;
+	u32 val;
+	int ret = 0;
+
+	pub = &chip->pub;
+	cc = list_first_entry(&chip->cores, struct inff_core_priv, list);
+	base = cc->pub.base;
+
+	/* get chipcommon capabilities */
+	pub->cc_caps = chip->ops->read32(chip->ctx,
+					 CORE_CC_REG(base, capabilities));
+	pub->cc_caps_ext = chip->ops->read32(chip->ctx,
+					     CORE_CC_REG(base,
+							 capabilities_ext));
+
+	/* get pmu caps & rev */
+	pmu = inff_chip_get_pmu(pub); /* after reading cc_caps_ext */
+	if (pub->cc_caps & CC_CAP_PMU) {
+		val = chip->ops->read32(chip->ctx,
+					CORE_CC_REG(pmu->base, pmucapabilities));
+		pub->pmurev = val & PCAP_REV_MASK;
+		pub->pmucaps = val;
+	}
+
+	inff_dbg(INFO, "ccrev=%d, pmurev=%d, pmucaps=0x%x\n",
+		 cc->pub.rev, pub->pmurev, pub->pmucaps);
+
+	/* execute bus core specific setup */
+	if (chip->ops->setup)
+		ret = chip->ops->setup(chip->ctx, pub);
+
+	return ret;
+}
+
+struct inff_chip *inff_chip_attach(int socitype, void *ctx, u16 devid,
+				   const struct inff_buscore_ops *ops)
+{
+	struct inff_chip_priv *chip;
+	struct inff_blhs *blhs;
+	struct inff_ccsec *ccsec;
+	int err = 0;
+
+	if (WARN_ON(!ops->read32))
+		err = -EINVAL;
+	if (WARN_ON(!ops->write32))
+		err = -EINVAL;
+	if (WARN_ON(!ops->prepare))
+		err = -EINVAL;
+	if (WARN_ON(!ops->activate))
+		err = -EINVAL;
+	if (err < 0)
+		return ERR_PTR(-EINVAL);
+
+	chip = kzalloc(sizeof(*chip), GFP_KERNEL);
+	if (!chip)
+		return ERR_PTR(-ENOMEM);
+
+	INIT_LIST_HEAD(&chip->cores);
+	chip->num_cores = 0;
+	chip->ops = ops;
+	chip->ctx = ctx;
+
+	switch (socitype) {
+	case INFF_SOCI_CP:
+		if (chip->ops->sec_attach) {
+			ccsec = NULL;
+			err = chip->ops->sec_attach(chip->ctx, NULL, &ccsec,
+						    0, 0, 0);
+			if (err < 0)
+				goto fail;
+
+			chip->pub.ccsec = ccsec;
+		}
+		break;
+	case INFF_SOCI_AI:
+		chip->pub.enum_base = inff_chip_enum_base(devid);
+
+		err = ops->prepare(ctx);
+		if (err < 0)
+			goto fail;
+
+		blhs = NULL;
+		ccsec = NULL;
+		if (chip->ops->sec_attach) {
+			err = chip->ops->sec_attach(chip->ctx, &blhs, &ccsec,
+						    INFF_BLHS_D2H_READY,
+						    INFF_BLHS_D2H_READY_TIMEOUT,
+						    INFF_BLHS_POLL_INTERVAL);
+			if (err < 0)
+				goto fail;
+
+			chip->pub.blhs = blhs;
+			chip->pub.ccsec = ccsec;
+			if (blhs) {
+				blhs->init = inff_blhs_init;
+				blhs->pre_nvramdl = inff_blhs_pre_nvram_download;
+				blhs->prep_fwdl = inff_blhs_prep_fw_download;
+				blhs->post_fwdl = inff_blhs_post_fw_download;
+				blhs->post_nvramdl = inff_blhs_post_nvram_download;
+				blhs->chk_validation = inff_blhs_chk_validation;
+				blhs->post_wdreset = inff_blhs_post_watchdog_reset;
+			} else {
+				err = -EPERM;
+				inff_err("chip must support blhs!\n");
+				goto fail;
+			}
+		} else {
+			err = -EPERM;
+			inff_err("Dongle didn't support Secure Attach!\n");
+			goto fail;
+		}
+		break;
+	default:
+		err = -EPERM;
+		inff_err("Unsupport Chip type for Chip Attach!\n");
+		goto fail;
+	}
+
+	err = inff_chip_recognition(chip);
+	if (err < 0)
+		goto fail;
+
+	err = inff_chip_setup(chip);
+	if (err < 0)
+		goto fail;
+
+	return &chip->pub;
+
+fail:
+	inff_chip_detach(&chip->pub);
+	return ERR_PTR(err);
+}
+
+void inff_chip_detach(struct inff_chip *pub)
+{
+	struct inff_chip_priv *chip;
+	struct inff_core_priv *core;
+	struct inff_core_priv *tmp;
+
+	chip = container_of(pub, struct inff_chip_priv, pub);
+	list_for_each_entry_safe(core, tmp, &chip->cores, list) {
+		list_del(&core->list);
+		kfree(core);
+	}
+
+	kfree(pub->blhs);
+	kfree(pub->ccsec);
+	kfree(chip);
+}
+
+struct inff_core *inff_chip_get_d11core(struct inff_chip *pub, u8 unit)
+{
+	struct inff_chip_priv *chip;
+	struct inff_core_priv *core;
+
+	chip = container_of(pub, struct inff_chip_priv, pub);
+	list_for_each_entry(core, &chip->cores, list) {
+		if (core->pub.id == INF_CORE_80211) {
+			if (unit-- == 0)
+				return &core->pub;
+		}
+	}
+	return NULL;
+}
+
+struct inff_core *inff_chip_get_core(struct inff_chip *pub, u16 coreid)
+{
+	struct inff_chip_priv *chip;
+	struct inff_core_priv *core;
+
+	chip = container_of(pub, struct inff_chip_priv, pub);
+	list_for_each_entry(core, &chip->cores, list)
+		if (core->pub.id == coreid)
+			return &core->pub;
+
+	return NULL;
+}
+
+struct inff_core *inff_chip_get_chipcommon(struct inff_chip *pub)
+{
+	struct inff_chip_priv *chip;
+	struct inff_core_priv *cc;
+
+	chip = container_of(pub, struct inff_chip_priv, pub);
+	cc = list_first_entry(&chip->cores, struct inff_core_priv, list);
+	if (WARN_ON(!cc || cc->pub.id != INF_CORE_CHIPCOMMON))
+		return inff_chip_get_core(pub, INF_CORE_CHIPCOMMON);
+	return &cc->pub;
+}
+
+struct inff_core *inff_chip_get_pmu(struct inff_chip *pub)
+{
+	struct inff_core *cc = inff_chip_get_chipcommon(pub);
+	struct inff_core *pmu;
+
+	/* See if there is separated PMU core available */
+	if (cc->rev >= 35 &&
+	    pub->cc_caps_ext & INF_CC_CAP_EXT_AOB_PRESENT) {
+		pmu = inff_chip_get_core(pub, INF_CORE_PMU);
+		if (pmu)
+			return pmu;
+	}
+
+	/* Fallback to ChipCommon core for older hardware */
+	return cc;
+}
+
+static struct inff_core *inff_chip_get_gci(struct inff_chip *pub)
+{
+	struct inff_core *gci;
+
+	gci = inff_chip_get_core(pub, INF_CORE_GCI);
+	return gci;
+}
+
+bool inff_chip_iscoreup(struct inff_core *pub)
+{
+	struct inff_core_priv *core;
+
+	core = container_of(pub, struct inff_core_priv, pub);
+	return core->chip->iscoreup(core);
+}
+
+void inff_chip_coredisable(struct inff_core *pub, u32 prereset, u32 reset)
+{
+	struct inff_core_priv *core;
+
+	core = container_of(pub, struct inff_core_priv, pub);
+	core->chip->coredisable(core, prereset, reset);
+}
+
+void inff_chip_resetcore(struct inff_core *pub, u32 prereset, u32 reset,
+			 u32 postreset)
+{
+	struct inff_core_priv *core;
+
+	core = container_of(pub, struct inff_core_priv, pub);
+	core->chip->resetcore(core, prereset, reset, postreset);
+}
+
+static bool inff_chip_cm3_set_active(struct inff_chip_priv *chip)
+{
+	struct inff_core *core;
+
+	core = inff_chip_get_core(&chip->pub, INF_CORE_INTERNAL_MEM);
+	if (!inff_chip_iscoreup(core)) {
+		inff_err("SOCRAM core is down after reset?\n");
+		return false;
+	}
+
+	chip->ops->activate(chip->ctx, &chip->pub, 0);
+
+	core = inff_chip_get_core(&chip->pub, INF_CORE_ARM_CM3);
+	inff_chip_resetcore(core, 0, 0, 0);
+
+	return true;
+}
+
+static inline void
+inff_chip_cr4_set_passive(struct inff_chip_priv *chip)
+{
+	int i;
+	struct inff_core *core;
+
+	/* Disable the cores only and let the firmware enable them. */
+	for (i = 0; (core = inff_chip_get_d11core(&chip->pub, i)); i++)
+		inff_chip_coredisable(core, D11_INFF_IOCTL_PHYRESET |
+				       D11_INFF_IOCTL_PHYCLOCKEN,
+				       D11_INFF_IOCTL_PHYCLOCKEN);
+}
+
+static bool inff_chip_cr4_set_active(struct inff_chip_priv *chip, u32 rstvec)
+{
+	struct inff_core *core;
+
+	chip->ops->activate(chip->ctx, &chip->pub, rstvec);
+
+	/* restore ARM */
+	core = inff_chip_get_core(&chip->pub, INF_CORE_ARM_CR4);
+	inff_chip_resetcore(core, ARMCR4_INFF_IOCTL_CPUHALT, 0, 0);
+
+	return true;
+}
+
+void inff_chip_set_passive(struct inff_chip *pub)
+{
+	struct inff_chip_priv *chip;
+	struct inff_core *arm;
+
+	chip = container_of(pub, struct inff_chip_priv, pub);
+	arm = inff_chip_get_core(pub, INF_CORE_ARM_CR4);
+	if (arm) {
+		inff_chip_cr4_set_passive(chip);
+		return;
+	}
+}
+
+bool inff_chip_set_active(struct inff_chip *pub, u32 rstvec)
+{
+	struct inff_chip_priv *chip;
+	struct inff_core *arm;
+
+	chip = container_of(pub, struct inff_chip_priv, pub);
+	arm = inff_chip_get_core(pub, INF_CORE_ARM_CR4);
+	if (arm)
+		return inff_chip_cr4_set_active(chip, rstvec);
+	arm = inff_chip_get_core(pub, INF_CORE_ARM_CM3);
+	if (arm)
+		return inff_chip_cm3_set_active(chip);
+
+	return false;
+}
+
+bool inff_chip_sr_capable(struct inff_chip *pub)
+{
+	u32 base, addr, reg;
+	struct inff_chip_priv *chip;
+	struct inff_core *pmu = inff_chip_get_pmu(pub);
+
+	/* old chips with PMU version less than 17 don't support save restore */
+	if (pub->pmurev < 17)
+		return false;
+
+	base = inff_chip_get_chipcommon(pub)->base;
+	chip = container_of(pub, struct inff_chip_priv, pub);
+
+	switch (pub->chip) {
+	case INF_CC_43022_CHIP_ID:
+		addr = CORE_CC_REG(pmu->base, retention_ctl);
+		reg = chip->ops->read32(chip->ctx, addr);
+		return (reg & (PMU_RCTL_MACPHY_DISABLE_MASK |
+			       PMU_RCTL_LOGIC_DISABLE_MASK)) == 0;
+	case INF_CC_5551X_CHIP_ID:
+	case INF_CC_5557X_CHIP_ID:
+		return inff_chip_find_coreid(chip, INF_CORE_SR);
+	default:
+		inff_err("unsupported chip:0x%x\n", pub->chip);
+	}
+	return false;
+}
+
+void inff_chip_reset_pmu_regs(struct inff_chip *pub)
+{
+	struct inff_chip_priv *chip;
+	u32 addr;
+	u32 base;
+
+	chip = container_of(pub, struct inff_chip_priv, pub);
+	base = inff_chip_get_pmu(pub)->base;
+
+	switch (pub->chip) {
+	case INF_CC_43022_CHIP_ID:
+		/* SW scratch */
+		addr = CORE_CC_REG(base, swscratch);
+		chip->ops->write32(chip->ctx, addr, 0);
+
+		/* PMU status */
+		addr = CORE_CC_REG(base, pmustatus);
+		chip->ops->write32(chip->ctx, addr,
+			INF43022_PMU_STATUS_MASK);
+
+		/* PMU control ext */
+		addr = CORE_CC_REG(base, pmucontrol_ext);
+		chip->ops->write32(chip->ctx, addr,
+			INF43022_PMU_CONTROL_EXT_MASK);
+		break;
+
+	default:
+		inff_err("Unsupported chip id\n");
+		break;
+	}
+}
+
+void inff_chip_ulp_reset_lhl_regs(struct inff_chip *pub)
+{
+	struct inff_chip_priv *chip;
+	u32 base;
+	u32 addr;
+
+	chip = container_of(pub, struct inff_chip_priv, pub);
+	base = inff_chip_get_gci(pub)->base;
+
+	/* LHL Top Level Power Sequence Control */
+	addr = CORE_GCI_REG(base, lhl_top_pwrseq_ctl_adr);
+	chip->ops->write32(chip->ctx, addr, 0);
+
+	/* GPIO Interrupt Enable0 */
+	addr = CORE_GCI_REG(base, gpio_int_en_port_adr[0]);
+	chip->ops->write32(chip->ctx, addr, 0);
+
+	/* GPIO Interrupt Status0 */
+	addr = CORE_GCI_REG(base, gpio_int_st_port_adr[0]);
+	chip->ops->write32(chip->ctx, addr, ~0);
+
+	/* WL ARM Timer0 Interrupt Mask */
+	addr = CORE_GCI_REG(base, lhl_wl_armtim0_intrp_adr);
+	chip->ops->write32(chip->ctx, addr, 0);
+
+	/* WL ARM Timer0 Interrupt Status */
+	addr = CORE_GCI_REG(base, lhl_wl_armtim0_st_adr);
+	chip->ops->write32(chip->ctx, addr, ~0);
+
+	/* WL ARM Timer */
+	addr = CORE_GCI_REG(base, lhl_wl_armtim0_adr);
+	chip->ops->write32(chip->ctx, addr, 0);
+
+	/* WL MAC Timer0 Interrupt Mask */
+	addr = CORE_GCI_REG(base, lhl_wl_mactim0_intrp_adr);
+	chip->ops->write32(chip->ctx, addr, 0);
+
+	/* WL MAC Timer0 Interrupt Status */
+	addr = CORE_GCI_REG(base, lhl_wl_mactim0_st_adr);
+	chip->ops->write32(chip->ctx, addr, ~0);
+
+	/* WL MAC TimerInt0 */
+	addr = CORE_GCI_REG(base, lhl_wl_mactim_int0_adr);
+	chip->ops->write32(chip->ctx, addr, 0x0);
+}
+
+void inff_chip_reset_watchdog(struct inff_chip *pub)
+{
+	/*FIXME: redundent function already.*/
+
+	switch (pub->chip) {
+	case INF_CC_43022_CHIP_ID:
+		inff_dbg(INFO, "DO NOTHING FOR 43022 here... can't access PMU registers\n");
+		break;
+	default:
+		break;
+	}
+}
diff --git a/drivers/net/wireless/infineon/inffmac/chip.h b/drivers/net/wireless/infineon/inffmac/chip.h
new file mode 100644
index 000000000000..94092eacddf3
--- /dev/null
+++ b/drivers/net/wireless/infineon/inffmac/chip.h
@@ -0,0 +1,636 @@
+/* SPDX-License-Identifier: ISC */
+/*
+ * Copyright (c) 2014 Broadcom Corporation
+ *
+ * Copyright (c) 2025-2026, Infineon Technologies AG, or an affiliate of Infineon Technologies AG.
+ * All rights reserved.
+ */
+
+#ifndef INFF_CHIP_H
+#define INFF_CHIP_H
+
+#include <linux/types.h>
+#include <linux/firmware.h>
+
+#include "firmware.h"
+
+/* Chip Core ID values. */
+#define INF_CORE_CHIPCOMMON            0x800
+#define INF_CORE_INTERNAL_MEM          0x80E
+#define INF_CORE_80211                 0x812
+#define INF_CORE_PMU                   0x827
+#define INF_CORE_SDIO_DEV              0x829
+#define INF_CORE_ARM_CM3               0x82A
+#define INF_CORE_PCIE2                 0x83C    /* PCI Express Gen2 */
+#define INF_CORE_ARM_CR4               0x83E
+#define INF_CORE_GCI                   0x840
+#define INF_CORE_SR                    0x841
+#define INF_CORE_SYS_MEM               0x849
+#define INF_CORE_DEFAULT               0xFFF
+
+#define INF_MAX_NR_CORES               16
+#define INF_CORE_SIZE                  0x1000
+
+/* CHIPCOMMON CORE */
+struct inff_chipcregs {
+	u32 chipid;		/* 0x0 */
+	u32 capabilities;
+	u32 corecontrol;	/* corerev >= 1 */
+	u32 bist;
+
+	/* OTP */
+	u32 otpstatus;	/* 0x10, corerev >= 10 */
+	u32 otpcontrol;
+	u32 otpprog;
+	u32 otplayout;	/* corerev >= 23 */
+
+	/* Interrupt control */
+	u32 intstatus;	/* 0x20 */
+	u32 intmask;
+
+	/* Chip specific regs */
+	u32 chipcontrol;	/* 0x28, rev >= 11 */
+	u32 chipstatus;	/* 0x2c, rev >= 11 */
+
+	/* Jtag Master */
+	u32 jtagcmd;		/* 0x30, rev >= 10 */
+	u32 jtagir;
+	u32 jtagdr;
+	u32 jtagctrl;
+
+	/* serial flash interface registers */
+	u32 flashcontrol;	/* 0x40 */
+	u32 flashaddress;
+	u32 flashdata;
+	u32 pad0[1];
+
+	/* Silicon backplane configuration broadcast control */
+	u32 broadcastaddress;	/* 0x50 */
+	u32 broadcastdata;
+
+	/* gpio - cleared only by power-on-reset */
+	u32 gpiopullup;	/* 0x58, corerev >= 20 */
+	u32 gpiopulldown;	/* 0x5c, corerev >= 20 */
+	u32 gpioin;		/* 0x60 */
+	u32 gpioout;		/* 0x64 */
+	u32 gpioouten;	/* 0x68 */
+	u32 gpiocontrol;	/* 0x6C */
+	u32 gpiointpolarity;	/* 0x70 */
+	u32 gpiointmask;	/* 0x74 */
+
+	/* GPIO events corerev >= 11 */
+	u32 gpioevent;
+	u32 gpioeventintmask;
+
+	/* Watchdog timer */
+	u32 watchdog;	/* 0x80 */
+
+	/* GPIO events corerev >= 11 */
+	u32 gpioeventintpolarity;
+
+	/* GPIO based LED powersave registers corerev >= 16 */
+	u32 gpiotimerval;	/* 0x88 */
+	u32 gpiotimeroutmask;
+
+	/* clock control */
+	u32 clockcontrol_n;	/* 0x90 */
+	u32 clockcontrol_sb;	/* aka m0 */
+	u32 clockcontrol_pci;	/* aka m1 */
+	u32 clockcontrol_m2;	/* mii/uart/mipsref */
+	u32 clockcontrol_m3;	/* cpu */
+	u32 clkdiv;		/* corerev >= 3 */
+	u32 gpiodebugsel;	/* corerev >= 28 */
+	u32 capabilities_ext;	/* 0xac  */
+
+	/* pll delay registers (corerev >= 4) */
+	u32 pll_on_delay;	/* 0xb0 */
+	u32 fref_sel_delay;
+	u32 slow_clk_ctl;	/* 5 < corerev < 10 */
+	u32 pad1;
+
+	/* Instaclock registers (corerev >= 10) */
+	u32 system_clk_ctl;	/* 0xc0 */
+	u32 clkstatestretch;
+	u32 pad2[2];
+
+	/* Indirect backplane access (corerev >= 22) */
+	u32 bp_addrlow;	/* 0xd0 */
+	u32 bp_addrhigh;
+	u32 bp_data;
+	u32 pad3;
+	u32 bp_indaccess;
+	u32 pad4[3];
+
+	/* More clock dividers (corerev >= 32) */
+	u32 clkdiv2;
+	u32 pad5[2];
+
+	/* In AI chips, pointer to erom */
+	u32 eromptr;		/* 0xfc */
+
+	/* ExtBus control registers (corerev >= 3) */
+	u32 pcmcia_config;	/* 0x100 */
+	u32 pcmcia_memwait;
+	u32 pcmcia_attrwait;
+	u32 pcmcia_iowait;
+	u32 ide_config;
+	u32 ide_memwait;
+	u32 ide_attrwait;
+	u32 ide_iowait;
+	u32 prog_config;
+	u32 prog_waitcount;
+	u32 flash_config;
+	u32 flash_waitcount;
+	u32 SECI_config;	/* 0x130 SECI configuration */
+	u32 pad6[3];
+
+	/* Enhanced Coexistence Interface (ECI) registers (corerev >= 21) */
+	u32 eci_output;	/* 0x140 */
+	u32 eci_control;
+	u32 eci_inputlo;
+	u32 eci_inputmi;
+	u32 eci_inputhi;
+	u32 eci_inputintpolaritylo;
+	u32 eci_inputintpolaritymi;
+	u32 eci_inputintpolarityhi;
+	u32 eci_intmasklo;
+	u32 eci_intmaskmi;
+	u32 eci_intmaskhi;
+	u32 eci_eventlo;
+	u32 eci_eventmi;
+	u32 eci_eventhi;
+	u32 eci_eventmasklo;
+	u32 eci_eventmaskmi;
+	u32 eci_eventmaskhi;
+	u32 pad7[3];
+
+	/* SROM interface (corerev >= 32) */
+	u32 sromcontrol;	/* 0x190 */
+	u32 sromaddress;
+	u32 sromdata;
+	u32 pad8[17];
+
+	/* Clock control and hardware workarounds (corerev >= 20) */
+	u32 clk_ctl_st;	/* 0x1e0 */
+	u32 hw_war;
+	u32 pad9[70];
+
+	/* UARTs */
+	u8 uart0data;	/* 0x300 */
+	u8 uart0imr;
+	u8 uart0fcr;
+	u8 uart0lcr;
+	u8 uart0mcr;
+	u8 uart0lsr;
+	u8 uart0msr;
+	u8 uart0scratch;
+	u8 pad10[248];		/* corerev >= 1 */
+
+	u8 uart1data;	/* 0x400 */
+	u8 uart1imr;
+	u8 uart1fcr;
+	u8 uart1lcr;
+	u8 uart1mcr;
+	u8 uart1lsr;
+	u8 uart1msr;
+	u8 uart1scratch;
+	u32 pad11[62];
+
+	/* save/restore, corerev >= 48 */
+	u32 sr_capability;          /* 0x500 */
+	u32 sr_control0;            /* 0x504 */
+	u32 sr_control1;            /* 0x508 */
+	u32 gpio_control;           /* 0x50C */
+	u32 pad12[60];
+
+	/* PMU registers (corerev >= 20) */
+	u32 pmucontrol;	/* 0x600 */
+	u32 pmucapabilities;
+	u32 pmustatus;
+	u32 res_state;
+	u32 res_pending;
+	u32 pmutimer;
+	u32 min_res_mask;
+	u32 max_res_mask;
+	u32 res_table_sel;
+	u32 res_dep_mask;
+	u32 res_updn_timer;
+	u32 res_timer;
+	u32 clkstretch;
+	u32 pmuwatchdog;
+	u32 gpiosel;		/* 0x638, rev >= 1 */
+	u32 gpioenable;	/* 0x63c, rev >= 1 */
+	u32 res_req_timer_sel;
+	u32 res_req_timer;
+	u32 res_req_mask;
+	u32 pmucapabilities_ext; /* 0x64c, pmurev >=15 */
+	u32 chipcontrol_addr;	/* 0x650 */
+	u32 chipcontrol_data;	/* 0x654 */
+	u32 regcontrol_addr;
+	u32 regcontrol_data;
+	u32 pllcontrol_addr;
+	u32 pllcontrol_data;
+	u32 pmustrapopt;	/* 0x668, corerev >= 28 */
+	u32 pmu_xtalfreq;	/* 0x66C, pmurev >= 10 */
+	u32 retention_ctl;          /* 0x670, pmurev >= 15 */
+	u32 pad13[3];
+	u32 retention_grpidx;       /* 0x680 */
+	u32 retention_grpctl;       /* 0x684 */
+	u32 mac_res_req_timer;      /* 0x688 */
+	u32 mac_res_req_mask;       /* 0x68c */
+	u32 pad14[18];
+	u32 pmucontrol_ext;         /* 0x6d8 */
+	u32 slowclkperiod;          /* 0x6dc */
+	u32 pad15[8];
+	u32 pmuintmask0;            /* 0x700 */
+	u32 pmuintmask1;            /* 0x704 */
+	u32 pad16[14];
+	u32 pmuintstatus;           /* 0x740 */
+	u32 extwakeupstatus;        /* 0x744 */
+	u32 watchdog_res_mask;      /* 0x748 */
+	u32 swscratch;              /* 0x750 */
+	u32 pad17[3];
+	u32 extwakemask[2];         /* 0x760-0x764 */
+	u32 pad18[2];
+	u32 extwakereqmask[2];      /* 0x770-0x774 */
+	u32 pad19[2];
+	u32 pmuintctrl0;            /* 0x780 */
+	u32 pmuintctrl1;            /* 0x784 */
+	u32 pad20[2];
+	u32 extwakectrl[2];         /* 0x790 */
+};
+
+#define CHIPCREGOFFS(field)	offsetof(struct inff_chipcregs, field)
+#define CORE_CC_REG(base, field) \
+		((base) + CHIPCREGOFFS(field))
+
+#define INF_CC_5557X_CHIP_ID		0xd908
+#define INF_CC_5551X_CHIP_ID		0xD8CC
+#define INF_CC_5591X_CHIP_ID		0xDA5C
+#define INF_CC_43022_CHIP_ID		43022
+
+/* GCI CORE */
+struct inff_chipgciregs {
+	u32 gci_corecaps0;                             /* 0x000 */
+	u32 gci_corecaps1;                             /* 0x004 */
+	u32 gci_corecaps2;                             /* 0x008 */
+	u32 gci_corectrl;                              /* 0x00c */
+	u32 gci_corestat;                              /* 0x010 */
+	u32 gci_intstat;                               /* 0x014 */
+	u32 gci_intmask;                               /* 0x018 */
+	u32 gci_wakemask;                              /* 0x01c */
+	u32 gci_levelintstat;                          /* 0x020 */
+	u32 gci_eventintstat;                          /* 0x024 */
+	u32 gci_wakelevelintstat;                      /* 0x028 */
+	u32 gci_wakeeventintstat;                      /* 0x02c */
+	u32 semaphoreintstatus;                        /* 0x030 */
+	u32 semaphoreintmask;                          /* 0x034 */
+	u32 semaphorerequest;                          /* 0x038 */
+	u32 semaphorereserve;                          /* 0x03c */
+	u32 gci_indirect_addr;                         /* 0x040 */
+	u32 gci_gpioctl;                               /* 0x044 */
+	u32 gci_gpiostatus;                            /* 0x048 */
+	u32 gci_gpiomask;                              /* 0x04c */
+	u32 eventsummary;                              /* 0x050 */
+	u32 gci_miscctl;                               /* 0x054 */
+	u32 gci_gpiointmask;                           /* 0x058 */
+	u32 gci_gpiowakemask;                          /* 0x05c */
+	u32 gci_input[32];                             /* 0x060 */
+	u32 gci_event[32];                             /* 0x0e0 */
+	u32 gci_output[4];                             /* 0x160 */
+	u32 gci_control_0;                             /* 0x170 */
+	u32 gci_control_1;                             /* 0x174 */
+	u32 gci_intpolreg;                             /* 0x178 */
+	u32 gci_levelintmask;                          /* 0x17c */
+	u32 gci_eventintmask;                          /* 0x180 */
+	u32 wakelevelintmask;                          /* 0x184 */
+	u32 wakeeventintmask;                          /* 0x188 */
+	u32 hwmask;                                    /* 0x18c */
+	u32 pad0;
+	u32 gci_inbandeventintmask;                    /* 0x194 */
+	u32 pad1;
+	u32 gci_inbandeventstatus;                     /* 0x19c */
+	u32 gci_seciauxtx;                             /* 0x1a0 */
+	u32 gci_seciauxrx;                             /* 0x1a4 */
+	u32 gci_secitx_datatag;                        /* 0x1a8 */
+	u32 gci_secirx_datatag;                        /* 0x1ac */
+	u32 gci_secitx_datamask;                       /* 0x1b0 */
+	u32 gci_seciusef0tx_reg;                       /* 0x1b4 */
+	u32 gci_secif0tx_offset;                       /* 0x1b8 */
+	u32 gci_secif0rx_offset;                       /* 0x1bc */
+	u32 gci_secif1tx_offset;                       /* 0x1c0 */
+	u32 gci_rxfifo_common_ctrl;                    /* 0x1c4 */
+	u32 gci_rxfifoctrl;                            /* 0x1c8 */
+	u32 gci_hw_sema_status;                        /* 0x1cc */
+	u32 gci_seciuartescval;                        /* 0x1d0 */
+	u32 gic_seciuartautobaudctr;                   /* 0x1d4 */
+	u32 gci_secififolevel;                         /* 0x1d8 */
+	u32 gci_seciuartdata;                          /* 0x1dc */
+	u32 gci_secibauddiv;                           /* 0x1e0 */
+	u32 gci_secifcr;                               /* 0x1e4 */
+	u32 gci_secilcr;                               /* 0x1e8 */
+	u32 gci_secimcr;                               /* 0x1ec */
+	u32 gci_secilsr;                               /* 0x1f0 */
+	u32 gci_secimsr;                               /* 0x1f4 */
+	u32 gci_baudadj;                               /* 0x1f8 */
+	u32 gci_inbandintmask;                         /* 0x1fc */
+	u32 gci_chipctrl;                              /* 0x200 */
+	u32 gci_chipsts;                               /* 0x204 */
+	u32 gci_gpioout;                               /* 0x208 */
+	u32 gci_gpioout_read;                          /* 0x20C */
+	u32 gci_mpwaketx;                              /* 0x210 */
+	u32 gci_mpwakedetect;                          /* 0x214 */
+	u32 gci_seciin_ctrl;                           /* 0x218 */
+	u32 gci_seciout_ctrl;                          /* 0x21C */
+	u32 gci_seciin_auxfifo_en;                     /* 0x220 */
+	u32 gci_seciout_txen_txbr;                     /* 0x224 */
+	u32 gci_seciin_rxbrstatus;                     /* 0x228 */
+	u32 gci_seciin_rxerrstatus;                    /* 0x22C */
+	u32 gci_seciin_fcstatus;                       /* 0x230 */
+	u32 gci_seciout_txstatus;                      /* 0x234 */
+	u32 gci_seciout_txbrstatus;                    /* 0x238 */
+	u32 wlan_mem_info;                             /* 0x23C */
+	u32 wlan_bankxinfo;                            /* 0x240 */
+	u32 bt_smem_select;                            /* 0x244 */
+	u32 bt_smem_stby;                              /* 0x248 */
+	u32 bt_smem_status;                            /* 0x24C */
+	u32 wlan_bankxactivepda;                       /* 0x250 */
+	u32 wlan_bankxsleeppda;                        /* 0x254 */
+	u32 wlan_bankxkill;                            /* 0x258 */
+	u32 pad2[41];
+	u32 gci_chipid;                                /* 0x300 */
+	u32 pad3[3];
+	u32 otpstatus;                                 /* 0x310 */
+	u32 otpcontrol;                                /* 0x314 */
+	u32 otpprog;                                   /* 0x318 */
+	u32 otplayout;                                 /* 0x31c */
+	u32 otplayoutextension;                        /* 0x320 */
+	u32 otpcontrol1;                               /* 0x324 */
+	u32 otpprogdata;                               /* 0x328 */
+	u32 pad4[52];
+	u32 otp_ecc_status;                            /* 0x3FC */
+	u32 pad5[512];
+	u32 lhl_core_capab_adr;                        /* 0xC00 */
+	u32 lhl_main_ctl_adr;                          /* 0xC04 */
+	u32 lhl_pmu_ctl_adr;                           /* 0xC08 */
+	u32 lhl_extlpo_ctl_adr;                        /* 0xC0C */
+	u32 lpo_ctl_adr;                               /* 0xC10 */
+	u32 lhl_lpo2_ctl_adr;                          /* 0xC14 */
+	u32 lhl_osc32k_ctl_adr;                        /* 0xC18 */
+	u32 lhl_clk_status_adr;                        /* 0xC1C */
+	u32 lhl_clk_det_ctl_adr;                       /* 0xC20 */
+	u32 lhl_clk_sel_adr;                           /* 0xC24 */
+	u32 hidoff_cnt_adr[2];                         /* 0xC28-0xC2C */
+	u32 lhl_autoclk_ctl_adr;                       /* 0xC30 */
+	u32 pad6;
+	u32 lhl_hibtim_adr;                            /* 0xC38 */
+	u32 lhl_wl_ilp_val_adr;                        /* 0xC3C */
+	u32 lhl_wl_armtim0_intrp_adr;                  /* 0xC40 */
+	u32 lhl_wl_armtim0_st_adr;                     /* 0xC44 */
+	u32 lhl_wl_armtim0_adr;                        /* 0xC48 */
+	u32 pad7[9];
+	u32 lhl_wl_mactim0_intrp_adr;                  /* 0xC70 */
+	u32 lhl_wl_mactim0_st_adr;                     /* 0xC74 */
+	u32 lhl_wl_mactim_int0_adr;                    /* 0xC78 */
+	u32 lhl_wl_mactim_frac0_adr;                   /* 0xC7C */
+	u32 lhl_wl_mactim1_intrp_adr;                  /* 0xC80 */
+	u32 lhl_wl_mactim1_st_adr;                     /* 0xC84 */
+	u32 lhl_wl_mactim_int1_adr;                    /* 0xC88 */
+	u32 lhl_wl_mactim_frac1_adr;                   /* 0xC8C */
+	u32 pad8[8];
+	u32 gpio_int_en_port_adr[4];                   /* 0xCB0-0xCBC */
+	u32 gpio_int_st_port_adr[4];                   /* 0xCC0-0xCCC */
+	u32 gpio_ctrl_iocfg_p_adr[64];                 /* 0xCD0-0xDCC */
+	u32 gpio_gctrl_iocfg_p0_p39_adr;               /* 0xDD0 */
+	u32 gpio_gdsctrl_iocfg_p0_p25_p30_p39_adr;     /* 0xDD4 */
+	u32 gpio_gdsctrl_iocfg_p26_p29_adr;            /* 0xDD8 */
+	u32 pad9[8];
+	u32 lhl_gpio_din0_adr;                         /* 0xDFC */
+	u32 lhl_gpio_din1_adr;                         /* 0xE00 */
+	u32 lhl_wkup_status_adr;                       /* 0xE04 */
+	u32 lhl_ctl_adr;                               /* 0xE08 */
+	u32 lhl_adc_ctl_adr;                           /* 0xE0C */
+	u32 lhl_qdxyz_in_dly_adr;                      /* 0xE10 */
+	u32 lhl_optctl_adr;                            /* 0xE14 */
+	u32 lhl_optct2_adr;                            /* 0xE18 */
+	u32 lhl_scanp_cntr_init_val_adr;               /* 0xE1C */
+	u32 lhl_opt_togg_val_adr[6];                   /* 0xE20-0xE34 */
+	u32 lhl_optx_smp_val_adr;                      /* 0xE38 */
+	u32 lhl_opty_smp_val_adr;                      /* 0xE3C */
+	u32 lhl_optz_smp_val_adr;                      /* 0xE40 */
+	u32 lhl_hidoff_keepstate_adr[3];               /* 0xE44-0xE4C */
+	u32 lhl_bt_slmboot_ctl0_adr[4];                /* 0xE50-0xE5C */
+	u32 lhl_wl_fw_ctl;                             /* 0xE60 */
+	u32 lhl_wl_hw_ctl_adr[2];                      /* 0xE64-0xE68 */
+	u32 lhl_bt_hw_ctl_adr;                         /* 0xE6C */
+	u32 lhl_top_pwrseq_en_adr;                     /* 0xE70 */
+	u32 lhl_top_pwrdn_ctl_adr;                     /* 0xE74 */
+	u32 lhl_top_pwrup_ctl_adr;                     /* 0xE78 */
+	u32 lhl_top_pwrseq_ctl_adr;                    /* 0xE7C */
+	u32 lhl_top_pwrdn2_ctl_adr;                    /* 0xE80 */
+	u32 lhl_top_pwrup2_ctl_adr;                    /* 0xE84 */
+	u32 wpt_regon_intrp_cfg_adr;                   /* 0xE88 */
+	u32 bt_regon_intrp_cfg_adr;                    /* 0xE8C */
+	u32 wl_regon_intrp_cfg_adr;                    /* 0xE90 */
+	u32 regon_intrp_st_adr;                        /* 0xE94 */
+	u32 regon_intrp_en_adr;                        /* 0xE98 */
+
+};
+
+#define CHIPGCIREGOFFS(field) offsetof(struct inff_chipgciregs, field)
+#define CORE_GCI_REG(base, field) \
+		((base) + CHIPGCIREGOFFS(field))
+
+#define INFF_CHIP_COMMON_HW_CAPS_REPLAYCNTS		16
+
+/* SOC Interconnect types (aka chip types) */
+#define INFF_SOCI_UNSPEC	0
+#define INFF_SOCI_AI		1
+#define INFF_SOCI_CP		5
+
+/**
+ * struct inff_blhs - bootloader handshake handle related information.
+ *
+ * @d2h: offset of dongle to host register for the handshake.
+ * @h2d: offset of host to dongle register for the handshake.
+ * @init: bootloader handshake initialization.
+ * @prep_fwdl: handshake before firmware download.
+ * @post_fwdl: handshake after firmware download.
+ * @post_nvramdl: handshake after nvram download.
+ * @chk_validation: handshake for firmware validation check.
+ * @post_wdreset: handshake after watchdog reset.
+ * @read: read value with register offset for the handshake.
+ * @write: write value with register offset for the handshake.
+ */
+struct inff_blhs {
+	u32 d2h;
+	u32 h2d;
+	void (*init)(struct inff_chip *pub);
+	int (*pre_nvramdl)(struct inff_chip *pub);
+	int (*prep_fwdl)(struct inff_chip *pub);
+	int (*post_fwdl)(struct inff_chip *pub);
+	int (*post_nvramdl)(struct inff_chip *pub);
+	int (*chk_validation)(struct inff_chip *pub);
+	int (*post_wdreset)(struct inff_chip *pub);
+	u32 (*read)(void *ctx, u32 addr);
+	void (*write)(void *ctx, u32 addr, u32 value);
+};
+
+struct inff_ccsec {
+	u32	bus_corebase;
+	u32 erombase;
+	u32 chipid;
+};
+
+enum inff_fw_file_types {
+	INFF_FW_CODE = 0,
+	INFF_FW_NVRAM,
+	INFF_FW_CLM,
+	INFF_FW_BIN_MAX_TYPE,
+};
+
+enum inff_cp_fw_file_types {
+	INFF_FW_CP = 0,
+	INFF_FW_BOOT,
+	INFF_FW_CP_BIN_MAX_TYPE,
+};
+
+struct inff_fw_dataset {
+	enum inff_fw_type type;
+	struct inff_fw_name fwnames;
+};
+
+struct inff_chip_specific {
+	u32 hw_caps_replaycnts;
+	u32 hw_reg_pmu_status_msk;
+	u32 hw_reg_pmu_ctrl_ext_msk;
+	u32 hw_chip_ramsize;
+	u32 hw_chip_rambase;
+	u32 hw_chip_tcam_size;
+	u32 hw_chip_trxhdr_size;
+
+	struct inff_fw_dataset fwdata[INFF_FW_BIN_MAX_TYPE];
+	char fw_name[INFF_FW_NAME_LEN];
+	char boot_fw_name[INFF_FW_NAME_LEN];
+	char nvram_name[INFF_FW_NAME_LEN];
+	char clm_name[INFF_FW_NAME_LEN];
+	const struct firmware *clm_fw;
+
+	/* TODO: firmware download flow ops. */
+};
+
+/**
+ * struct inff_chip - chip level information.
+ *
+ * @chip: chip identifier.
+ * @chiprev: chip revision.
+ * @enum_base: base address of core enumeration space.
+ * @cc_caps: chipcommon core capabilities.
+ * @cc_caps_ext: chipcommon core extended capabilities.
+ * @pmucaps: PMU capabilities.
+ * @pmurev: PMU revision.
+ * @rambase: RAM base address (only applicable for ARM CR4 chips).
+ * @ramsize: amount of RAM on chip including retention.
+ * @srsize: amount of retention RAM on chip.
+ * @socitype: SOC interconnect type.
+ * @name: string representation of the chip identifier.
+ * @blhs: bootlooder handshake handle.
+ */
+struct inff_chip {
+	u32 chip;
+	u32 chiprev;
+	u32 enum_base;
+	u32 cc_caps;
+	u32 cc_caps_ext;
+	u32 pmucaps;
+	u32 pmurev;
+	u32 rambase;
+	u32 ramsize;
+	u32 srsize;
+	u32 socitype;
+	char name[12];
+	struct inff_blhs *blhs;
+	struct inff_ccsec *ccsec;
+	struct inff_chip_specific chip_spec;
+};
+
+/**
+ * struct inff_core - core related information.
+ *
+ * @id: core identifier.
+ * @rev: core revision.
+ * @base: base address of core register space.
+ */
+struct inff_core {
+	u16 id;
+	u16 rev;
+	u32 base;
+};
+
+struct inff_core_priv {
+	struct inff_core pub;
+	u32 wrapbase;
+	struct list_head list;
+	struct inff_chip_priv *chip;
+};
+
+struct inff_chip_priv {
+	struct inff_chip pub;
+	const struct inff_buscore_ops *ops;
+	void *ctx;
+	/* assured first core is chipcommon, second core is buscore */
+	struct list_head cores;
+	u16 num_cores;
+
+	bool (*iscoreup)(struct inff_core_priv *core);
+	void (*coredisable)(struct inff_core_priv *core, u32 prereset,
+			    u32 reset);
+	void (*resetcore)(struct inff_core_priv *core, u32 prereset, u32 reset,
+			  u32 postreset);
+};
+
+/**
+ * struct inff_buscore_ops - buscore specific callbacks.
+ *
+ * @read32: read 32-bit value over bus.
+ * @write32: write 32-bit value over bus.
+ * @prepare: prepare bus for core configuration.
+ * @setup: bus-specific core setup.
+ * @active: chip becomes active.
+ *	The callback should use the provided @rstvec when non-zero.
+ * @blhs_attach: attach bootloader handshake handle
+ */
+struct inff_buscore_ops {
+	u32 (*read32)(void *ctx, u32 addr);
+	void (*write32)(void *ctx, u32 addr, u32 value);
+	int (*prepare)(void *ctx);
+	int (*reset)(void *ctx, struct inff_chip *chip);
+	int (*setup)(void *ctx, struct inff_chip *chip);
+	void (*activate)(void *ctx, struct inff_chip *chip, u32 rstvec);
+	int (*sec_attach)(void *ctx, struct inff_blhs **blhs, struct inff_ccsec **ccsec,
+			  u32 flag, uint timeout, uint interval);
+	int (*get_intr_pend)(void *ctx);
+};
+
+int inff_chip_get_raminfo(struct inff_chip *pub);
+struct inff_chip *inff_chip_attach(int socitype, void *ctx, u16 devid,
+				   const struct inff_buscore_ops *ops);
+void inff_chip_detach(struct inff_chip *chip);
+struct inff_core *inff_chip_get_core(struct inff_chip *chip, u16 coreid);
+struct inff_core *inff_chip_get_d11core(struct inff_chip *pub, u8 unit);
+struct inff_core *inff_chip_get_chipcommon(struct inff_chip *chip);
+struct inff_core *inff_chip_get_pmu(struct inff_chip *pub);
+bool inff_chip_iscoreup(struct inff_core *core);
+void inff_chip_coredisable(struct inff_core *core, u32 prereset, u32 reset);
+void inff_chip_resetcore(struct inff_core *core, u32 prereset, u32 reset,
+			 u32 postreset);
+void inff_chip_set_passive(struct inff_chip *ci);
+bool inff_chip_set_active(struct inff_chip *ci, u32 rstvec);
+bool inff_chip_sr_capable(struct inff_chip *pub);
+char *inff_chip_name(u32 chipid, u32 chiprev, char *buf, uint len);
+u32 inff_chip_enum_base(u16 devid);
+u32 inff_chip_get_hw_caps_replaycnts(struct inff_chip *pub);
+void inff_chip_reset_watchdog(struct inff_chip *pub);
+void inff_chip_ulp_reset_lhl_regs(struct inff_chip *pub);
+void inff_chip_reset_pmu_regs(struct inff_chip *pub);
+#endif /* INFF_CHIP_H */
-- 
2.25.1


