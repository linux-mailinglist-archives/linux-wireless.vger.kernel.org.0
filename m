Return-Path: <linux-wireless+bounces-27363-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 551CDB7DA12
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Sep 2025 14:32:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECA93188A69D
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Sep 2025 22:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D11D92E03EF;
	Tue, 16 Sep 2025 22:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b="Ot26btH5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp9.infineon.com (smtp9.infineon.com [217.10.52.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B6E2E11AA
	for <linux-wireless@vger.kernel.org>; Tue, 16 Sep 2025 22:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.52.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758061292; cv=none; b=P5ljBqethgdzGYwjy4Ebkf9t3VeWa2m0fR14c/Ir1hWgZRajVpXUg5ENpcNDjlvkkIuSjxLZe28FC8QI3vVOkRsxycU6XK99EtyyVFfRl9yh4rSJbJNJ8AG1s8qsnDv95TmflTDl4OVghkhFf2AfioP7esgizB33VX5l+iZMOeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758061292; c=relaxed/simple;
	bh=t7Q0xLNMhXlbsJlB8iuRNSKXjaqASLaI5Vbbvc7o9t8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cp8Nwm2Wqpp1XxsnjaIBDjcTOCUmqZy6PGccvl1OQwQtIUlYB3QnCf1CVK7UsmVuu6fpDiFSYRj0kc6U9A5vOICvBmnmQtfwzZ7gKAUuC/9jrfRXpVK3sn+wdLT28BwiwCa+bWyOEzDGIOfRR/S57XlUPmYzisQBRSbZymS3dYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com; spf=pass smtp.mailfrom=infineon.com; dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b=Ot26btH5; arc=none smtp.client-ip=217.10.52.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infineon.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1758061290; x=1789597290;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=t7Q0xLNMhXlbsJlB8iuRNSKXjaqASLaI5Vbbvc7o9t8=;
  b=Ot26btH5aQENL9TVaIAw6r5VKVashtT1k/YFwe3OwRmM4X2DTLTotioN
   L2AVPRc+iM8n6ANIaLj6fC7OICrwKGbYOeaCnnwE0IV47Xm2ZIHo1GReA
   eICSu/JQN2BxBaSI/IFrxt/PI2rrOb+FE/N/mgj/Cq68cgY7ypgDM5ski
   M=;
X-CSE-ConnectionGUID: TRExxfeUQR2H+gvxC4gX/A==
X-CSE-MsgGUID: ujfEEahkQc2gatBbLERODQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11555"; a="64783375"
X-IronPort-AV: E=Sophos;i="6.18,270,1751234400"; 
   d="scan'208";a="64783375"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO MUCSE814.infineon.com) ([172.23.29.40])
  by smtp9.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 00:21:27 +0200
Received: from MUCSE827.infineon.com (172.23.29.20) by MUCSE814.infineon.com
 (172.23.29.40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.36; Wed, 17 Sep
 2025 00:21:26 +0200
Received: from ISCN5CG14747PP.infineon.com (10.161.6.196) by
 MUCSE827.infineon.com (172.23.29.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.36; Wed, 17 Sep 2025 00:21:23 +0200
From: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
To: <linux-wireless@vger.kernel.org>, Johannes Berg
	<johannes@sipsolutions.net>
CC: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>,
	<wlan-kernel-dev-list@infineon.com>
Subject: [PATCH wireless-next 14/57] wifi: inffmac: add chip.c/h
Date: Wed, 17 Sep 2025 03:47:29 +0530
Message-ID: <20250916221821.4387-15-gokulkumar.sivakumar@infineon.com>
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
X-ClientProxiedBy: MUCSE824.infineon.com (172.23.29.55) To
 MUCSE827.infineon.com (172.23.29.20)

Driver implementation for managing the chip and also do the chip operations
needed for the Infineon-proprietary secured firmware architecture. This new
secure firmware architecture demands a unique vendor-specific handshake
between the host machine and new Infineon chipsets for both bring up and
normal operation, because of firmware encryption and firmware signature
validation.

Signed-off-by: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
---
 drivers/net/wireless/infineon/inffmac/chip.c | 1507 ++++++++++++++++++
 drivers/net/wireless/infineon/inffmac/chip.h |  223 +++
 2 files changed, 1730 insertions(+)
 create mode 100644 drivers/net/wireless/infineon/inffmac/chip.c
 create mode 100644 drivers/net/wireless/infineon/inffmac/chip.h

diff --git a/drivers/net/wireless/infineon/inffmac/chip.c b/drivers/net/wireless/infineon/inffmac/chip.c
new file mode 100644
index 000000000000..1770e1261060
--- /dev/null
+++ b/drivers/net/wireless/infineon/inffmac/chip.c
@@ -0,0 +1,1507 @@
+// SPDX-License-Identifier: ISC
+/*
+ * Copyright (c) 2014 Broadcom Corporation
+ *
+ * Copyright (c) 2025, Infineon Technologies AG, or an affiliate of Infineon Technologies AG.
+ * All rights reserved.
+ */
+#include <linux/kernel.h>
+#include <linux/delay.h>
+#include <linux/list.h>
+#include <linux/ssb/ssb_regs.h>
+
+#include "defs.h"
+#include "core.h"
+#include "hw_ids.h"
+#include "utils.h"
+#include "chipcommon.h"
+#include "debug.h"
+#include "chip.h"
+#include "chip_43022.h"
+#include "chip_5551x.h"
+#include "chip_5557x.h"
+#include "chip_5591x.h"
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
+struct sbconfig {
+	u32 PAD[2];
+	u32 sbipsflag;	/* initiator port ocp slave flag */
+	u32 PAD[3];
+	u32 sbtpsflag;	/* target port ocp slave flag */
+	u32 PAD[11];
+	u32 sbtmerrloga;	/* (sonics >= 2.3) */
+	u32 PAD;
+	u32 sbtmerrlog;	/* (sonics >= 2.3) */
+	u32 PAD[3];
+	u32 sbadmatch3;	/* address match3 */
+	u32 PAD;
+	u32 sbadmatch2;	/* address match2 */
+	u32 PAD;
+	u32 sbadmatch1;	/* address match1 */
+	u32 PAD[7];
+	u32 sbimstate;	/* initiator agent state */
+	u32 sbintvec;	/* interrupt mask */
+	u32 sbtmstatelow;	/* target state */
+	u32 sbtmstatehigh;	/* target state */
+	u32 sbbwa0;		/* bandwidth allocation table0 */
+	u32 PAD;
+	u32 sbimconfiglow;	/* initiator configuration */
+	u32 sbimconfighigh;	/* initiator configuration */
+	u32 sbadmatch0;	/* address match0 */
+	u32 PAD;
+	u32 sbtmconfiglow;	/* target configuration */
+	u32 sbtmconfighigh;	/* target configuration */
+	u32 sbbconfig;	/* broadcast configuration */
+	u32 PAD;
+	u32 sbbstate;	/* broadcast state */
+	u32 PAD[3];
+	u32 sbactcnfg;	/* activate configuration */
+	u32 PAD[3];
+	u32 sbflagst;	/* current sbflags */
+	u32 PAD[3];
+	u32 sbidlow;		/* identification */
+	u32 sbidhigh;	/* identification */
+};
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
+struct sbsocramregs {
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
+	u32 PAD[1];
+	u32 bankinfo;	/* corev 8 */
+	u32 bankpda;
+	u32 PAD[14];
+	u32 extmemconfig;
+	u32 extmemparitycsr;
+	u32 extmemparityerrdata;
+	u32 extmemparityerrcnt;
+	u32 extmemwrctrlandsize;
+	u32 PAD[84];
+	u32 workaround;
+	u32 pwrctl;		/* corerev >= 2 */
+	u32 PAD[133];
+	u32 sr_control;     /* corerev >= 15 */
+	u32 sr_status;      /* corerev >= 15 */
+	u32 sr_address;     /* corerev >= 15 */
+	u32 sr_data;        /* corerev >= 15 */
+};
+
+#define SOCRAMREGOFFS(_f)	offsetof(struct sbsocramregs, _f)
+#define SYSMEMREGOFFS(_f)	offsetof(struct sbsocramregs, _f)
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
+u32 inff_chip_enum_base(u16 devid)
+{
+	return INFF_SI_ENUM_BASE_DEFAULT;
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
+		 ci->pub.socitype == SOCI_AI ? "AXI" : "N/A", ci->pub.name);
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
+	case SOCI_AI:
+		ci->iscoreup = inff_chip_ai_iscoreup;
+		ci->coredisable = inff_chip_ai_coredisable;
+		ci->resetcore = inff_chip_ai_resetcore;
+		break;
+	case SOCI_CP:
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
+struct inff_chip *inff_chip_attach(void *ctx, u16 devid,
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
+	chip->pub.enum_base = inff_chip_enum_base(devid);
+
+	err = ops->prepare(ctx);
+	if (err < 0)
+		goto fail;
+
+	blhs = NULL;
+	ccsec = NULL;
+	if (chip->ops->sec_attach) {
+		err = chip->ops->sec_attach(chip->ctx, &blhs, &ccsec,
+					     INFF_BLHS_D2H_READY,
+					     INFF_BLHS_D2H_READY_TIMEOUT,
+					     INFF_BLHS_POLL_INTERVAL);
+		if (err < 0)
+			goto fail;
+
+		chip->pub.blhs = blhs;
+		chip->pub.ccsec = ccsec;
+		if (blhs) {
+			blhs->init = inff_blhs_init;
+			blhs->pre_nvramdl = inff_blhs_pre_nvram_download;
+			blhs->prep_fwdl = inff_blhs_prep_fw_download;
+			blhs->post_fwdl = inff_blhs_post_fw_download;
+			blhs->post_nvramdl = inff_blhs_post_nvram_download;
+			blhs->chk_validation = inff_blhs_chk_validation;
+			blhs->post_wdreset = inff_blhs_post_watchdog_reset;
+		} else {
+			err = -EPERM;
+			inff_err("chip must support blhs!\n");
+			goto fail;
+		}
+	} else {
+		err = -EPERM;
+		inff_err("Dongle didn't support Secure Attach!\n");
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
+	/* Disable the cores only and let the firmware enable them.
+	 * Releasing reset ourselves breaks BCM4387 in weird ways.
+	 */
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
+	inff_dbg(TRACE, "Enter\n");
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
+	inff_dbg(TRACE, "Enter\n");
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
+	inff_dbg(TRACE, "Enter\n");
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
+	inff_dbg(TRACE, "Enter\n");
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
+	inff_dbg(TRACE, "Enter\n");
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
+	inff_dbg(TRACE, "Enter\n");
+
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
index 000000000000..fe825a8eb05b
--- /dev/null
+++ b/drivers/net/wireless/infineon/inffmac/chip.h
@@ -0,0 +1,223 @@
+/* SPDX-License-Identifier: ISC */
+/*
+ * Copyright (c) 2014 Broadcom Corporation
+ *
+ * Copyright (c) 2025, Infineon Technologies AG, or an affiliate of Infineon Technologies AG.
+ * All rights reserved.
+ */
+
+#ifndef INFF_CHIP_H
+#define INFF_CHIP_H
+
+#include <linux/types.h>
+#include <linux/firmware.h>
+#include <cfg80211.h>
+#include "firmware.h"
+
+#define INFF_SI_ENUM_BASE_DEFAULT	0x18000000
+
+#define CORE_CC_REG(base, field) \
+		((base) + offsetof(struct chipcregs, field))
+
+#define CORE_GCI_REG(base, field) \
+		((base) + offsetof(struct chipgciregs, field))
+
+#define INFF_IOCTL			0x0408	/* IO control */
+#define  INFF_IOCTL_CLK			0x0001
+#define  INFF_IOCTL_FGC			0x0002
+#define INFF_RESET_CTL			0x0800
+#define  INFF_RESET_CTL_RESET		0x0001
+
+struct inff_blhs;
+
+#define INFF_CHIP_COMMON_HW_CAPS_REPLAYCNTS		16
+
+/* SOC Interconnect types (aka chip types) */
+#define SOCI_AI		1
+#define SOCI_CP		5
+
+enum inff_fw_file_types {
+	INFF_FW_CODE = 0,
+	INFF_FW_NVRAM,
+	INFF_FW_CLM,
+	INFF_FW_BIN_MAX_TYPE,
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
+	char nvram_name[INFF_FW_NAME_LEN];
+	char clm_name[INFF_FW_NAME_LEN];
+	const struct firmware *clm_fw;
+
+	/* TODO: firmware download flow ops. */
+};
+
+struct inff_chip_mlo_priv {
+	void (*get_eht_cap)(struct ieee80211_supported_band *band,
+			    struct ieee80211_sband_iftype_data *data);
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
+	struct inff_chip_mlo_priv chip_mlo_priv;
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
+int inff_chip_get_raminfo(struct inff_chip *pub);
+struct inff_chip *inff_chip_attach(void *ctx, u16 devid,
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
+void inff_chip_reset_watchdog(struct inff_chip *pub);
+void inff_chip_ulp_reset_lhl_regs(struct inff_chip *pub);
+void inff_chip_reset_pmu_regs(struct inff_chip *pub);
+
+#endif /* INFF_CHIP_H */
-- 
2.25.1


