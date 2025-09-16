Return-Path: <linux-wireless+bounces-27391-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB721B7DD32
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Sep 2025 14:35:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CDFC3BF472
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Sep 2025 22:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D9231C5486;
	Tue, 16 Sep 2025 22:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b="JvtscHTO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp14.infineon.com (smtp14.infineon.com [217.10.52.160])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB32B18C03F
	for <linux-wireless@vger.kernel.org>; Tue, 16 Sep 2025 22:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.52.160
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758061624; cv=none; b=eAvQIXX+9XVLC/LYXjNRuhAwCQ3CkCxobqclcWUmmEeDJ9uBQrCwBkIjzudztd7GsvdWCp3i4JlirzQyHBKt91PKExB6maGSVv+gidKhUXYXhl9/qIn0fVQ0dllvQuTFGboJQYrQl+XPctlKT4wuvGfknOTeJVpVAnYihlKQVVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758061624; c=relaxed/simple;
	bh=Zxmu0F7hFVwQhvMvVKjp4yOYVa5qxTWFBcWXE3Q4qXI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E2l8lwH/u1ZKBmDWjegAM1R0eDhm3yqa756OiNe2OJ2s9qulchxzKdK7kHzjn7Z2qdNGBtDVto29uOXMxR7cn/jsR5z4zEthyVl71CARF40t9PWypBgF9tRA7uxg3lKCrvKJ4TVF5WD5KE1V0qqZgWMZodegn/zL6Uv+oL3awP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com; spf=pass smtp.mailfrom=infineon.com; dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b=JvtscHTO; arc=none smtp.client-ip=217.10.52.160
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infineon.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1758061622; x=1789597622;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Zxmu0F7hFVwQhvMvVKjp4yOYVa5qxTWFBcWXE3Q4qXI=;
  b=JvtscHTOMbnjFeItiOXSGNVAcGHNaG08sSCJ21w7zwSvstDomOI9ozVm
   qImU4ue5is0bcgBk3GDZWlQqSMT3BiredyrPGNDY5jlGPHVcaG+ofASmi
   CWVIADoeGlf5cIcbDfOdReTleZ2cYrmVTneaKzvgean3G9d9gWIUqC6NC
   0=;
X-CSE-ConnectionGUID: t6brALBlTk23UP6NP4W4aw==
X-CSE-MsgGUID: 46uNMfrNQUKh6mKOMZZPcA==
X-IronPort-AV: E=McAfee;i="6800,10657,11555"; a="99294165"
X-IronPort-AV: E=Sophos;i="6.18,270,1751234400"; 
   d="scan'208";a="99294165"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO MUCSE803.infineon.com) ([172.23.29.29])
  by smtp14.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 00:27:00 +0200
Received: from MUCSE827.infineon.com (172.23.29.20) by MUCSE803.infineon.com
 (172.23.29.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.36; Wed, 17 Sep
 2025 00:26:59 +0200
Received: from ISCN5CG14747PP.infineon.com (10.161.6.196) by
 MUCSE827.infineon.com (172.23.29.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.36; Wed, 17 Sep 2025 00:26:56 +0200
From: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
To: <linux-wireless@vger.kernel.org>, Johannes Berg
	<johannes@sipsolutions.net>
CC: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>,
	<wlan-kernel-dev-list@infineon.com>
Subject: [PATCH wireless-next 36/57] wifi: inffmac: add infsdh.c
Date: Wed, 17 Sep 2025 03:47:56 +0530
Message-ID: <20250916221821.4387-42-gokulkumar.sivakumar@infineon.com>
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
X-ClientProxiedBy: MUCSE801.infineon.com (172.23.29.27) To
 MUCSE827.infineon.com (172.23.29.20)

Implementation for managing the SDIO Device through the SD Host
Controller Driver.

Signed-off-by: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
---
 .../net/wireless/infineon/inffmac/infsdh.c    | 1367 +++++++++++++++++
 1 file changed, 1367 insertions(+)
 create mode 100644 drivers/net/wireless/infineon/inffmac/infsdh.c

diff --git a/drivers/net/wireless/infineon/inffmac/infsdh.c b/drivers/net/wireless/infineon/inffmac/infsdh.c
new file mode 100644
index 000000000000..96b034443b3e
--- /dev/null
+++ b/drivers/net/wireless/infineon/inffmac/infsdh.c
@@ -0,0 +1,1367 @@
+// SPDX-License-Identifier: ISC
+/*
+ * Copyright (c) 2010 Broadcom Corporation
+ *
+ * Copyright (c) 2025, Infineon Technologies AG, or an affiliate of Infineon Technologies AG.
+ * All rights reserved.
+ */
+/* ****************** SDIO CARD Interface Functions **************************/
+
+#include <linux/types.h>
+#include <linux/netdevice.h>
+#include <linux/pci.h>
+#include <linux/pci_ids.h>
+#include <linux/sched.h>
+#include <linux/completion.h>
+#include <linux/interrupt.h>
+#include <linux/scatterlist.h>
+#include <linux/mmc/sdio.h>
+#include <linux/mmc/core.h>
+#include <linux/mmc/sdio_func.h>
+#include <linux/mmc/card.h>
+#include <linux/mmc/host.h>
+#include <linux/pm_runtime.h>
+#include <linux/suspend.h>
+#include <linux/errno.h>
+#include <linux/module.h>
+#include <linux/acpi.h>
+#include <net/cfg80211.h>
+
+#include "defs.h"
+#include "hw_ids.h"
+#include "utils.h"
+#include "chipcommon.h"
+#include "chip.h"
+#include "bus.h"
+#include "debug.h"
+#include "sdio.h"
+#include "core.h"
+#include "common.h"
+#include "cfg80211.h"
+#include "fwsignal.h"
+#include "chip_5557x.h"
+#include "chip_5591x.h"
+
+#define SDIOH_API_ACCESS_RETRY_LIMIT	2
+
+#define DMA_ALIGN_MASK	0x03
+
+#define SDIO_FUNC1_BLOCKSIZE		64
+#define SDIO_FUNC2_BLOCKSIZE		512
+
+/* Maximum milliseconds to wait for F2 to come up */
+#define SDIO_WAIT_F2RDY	3000
+
+#define INFF_DEFAULT_RXGLOM_SIZE	32  /* max rx frames in glom chain */
+
+struct inff_sdiod_freezer {
+	atomic_t freezing;
+	atomic_t thread_count;
+	u32 frozen_count;
+	wait_queue_head_t thread_freeze;
+	struct completion resumed;
+};
+
+static irqreturn_t inff_sdiod_oob_irqhandler(int irq, void *dev_id)
+{
+	struct inff_bus *bus_if = dev_get_drvdata(dev_id);
+	struct inff_sdio_dev *sdiodev = bus_if->bus_priv.sdio;
+
+	inff_dbg(INTR, "OOB intr triggered\n");
+
+	/* out-of-band interrupt is level-triggered which won't
+	 * be cleared until dpc
+	 */
+	if (sdiodev->irq_en) {
+		disable_irq_nosync(irq);
+		sdiodev->irq_en = false;
+	}
+
+	inff_sdio_isr(sdiodev->bus, true);
+
+	return IRQ_HANDLED;
+}
+
+/* interrupt handler for SDIO function 1 interrupt */
+static void inff_sdiod_ib_irqhandler(struct sdio_func *func)
+{
+	struct inff_bus *bus_if = dev_get_drvdata(&func->dev);
+	struct inff_sdio_dev *sdiodev = bus_if->bus_priv.sdio;
+
+	inff_dbg(INTR, "F%d IB intr triggered\n", func->num);
+
+	inff_sdio_isr(sdiodev->bus, false);
+}
+
+/* dummy handler for SDIO function 2 interrupt */
+static void inff_sdiod_dummy_irqhandler(struct sdio_func *func)
+{
+}
+
+int inff_sdiod_intr_register(struct inff_sdio_dev *sdiodev)
+{
+	struct inff_sdio_platform_data *pdata;
+	int ret = 0;
+	u8 data;
+
+	pdata = &sdiodev->settings->bus.sdio;
+	if (pdata->oob_irq_supported) {
+		inff_dbg(SDIO, "Enter, register OOB IRQ %d\n",
+			 pdata->oob_irq_nr);
+		if (!sdiodev->oob_irq_requested) {
+			spin_lock_init(&sdiodev->irq_en_lock);
+			sdiodev->irq_en = true;
+
+			ret = request_irq(pdata->oob_irq_nr,
+					  inff_sdiod_oob_irqhandler,
+				  pdata->oob_irq_flags, "inff_oob_intr",
+				  &sdiodev->func1->dev);
+			if (ret != 0) {
+				inff_err("request_irq failed %d\n", ret);
+				return ret;
+			}
+			sdiodev->oob_irq_requested = true;
+
+			ret = enable_irq_wake(pdata->oob_irq_nr);
+			if (ret != 0) {
+				inff_err("enable_irq_wake failed %d\n", ret);
+				return ret;
+			}
+			disable_irq_wake(pdata->oob_irq_nr);
+		}
+		sdio_claim_host(sdiodev->func1);
+
+		/* must configure SDIO_CCCR_IENx to enable irq */
+		data = inff_sdiod_func0_rb(sdiodev, SDIO_CCCR_IENx, &ret);
+		data |= SDIO_CCCR_IEN_FUNC1 | SDIO_CCCR_IEN_FUNC2 |
+			SDIO_CCCR_IEN_FUNC0;
+		inff_sdiod_func0_wb(sdiodev, SDIO_CCCR_IENx, data, &ret);
+
+		/* redirect, configure and enable io for interrupt signal */
+		data = SDIO_CCCR_INFF_SEPINT_MASK | SDIO_CCCR_INFF_SEPINT_OE;
+		if (pdata->oob_irq_flags & IRQF_TRIGGER_HIGH)
+			data |= SDIO_CCCR_INFF_SEPINT_ACT_HI;
+		inff_sdiod_func0_wb(sdiodev, SDIO_CCCR_INFF_SEPINT,
+				    data, &ret);
+		sdio_release_host(sdiodev->func1);
+	} else {
+		inff_dbg(SDIO, "Entering\n");
+		sdio_claim_host(sdiodev->func1);
+		sdio_claim_irq(sdiodev->func1, inff_sdiod_ib_irqhandler);
+		sdio_claim_irq(sdiodev->func2, inff_sdiod_dummy_irqhandler);
+		sdio_release_host(sdiodev->func1);
+		sdiodev->sd_irq_requested = true;
+	}
+
+	return 0;
+}
+
+void inff_sdiod_intr_unregister(struct inff_sdio_dev *sdiodev)
+{
+	inff_dbg(SDIO, "Entering oob=%d sd=%d\n",
+		 sdiodev->oob_irq_requested,
+		  sdiodev->sd_irq_requested);
+
+	if (sdiodev->oob_irq_requested) {
+		struct inff_sdio_platform_data *pdata;
+
+		pdata = &sdiodev->settings->bus.sdio;
+		sdio_claim_host(sdiodev->func1);
+		inff_sdiod_func0_wb(sdiodev, SDIO_CCCR_INFF_SEPINT, 0, NULL);
+		inff_sdiod_func0_wb(sdiodev, SDIO_CCCR_IENx, 0, NULL);
+		sdio_release_host(sdiodev->func1);
+
+		sdiodev->oob_irq_requested = false;
+		free_irq(pdata->oob_irq_nr, &sdiodev->func1->dev);
+		sdiodev->irq_en = false;
+		sdiodev->oob_irq_requested = false;
+	}
+
+	if (sdiodev->sd_irq_requested) {
+		sdio_claim_host(sdiodev->func1);
+		sdio_release_irq(sdiodev->func2);
+		sdio_release_irq(sdiodev->func1);
+		sdio_release_host(sdiodev->func1);
+		sdiodev->sd_irq_requested = false;
+	}
+}
+
+void inff_sdiod_change_state(struct inff_sdio_dev *sdiodev,
+			     enum inff_sdiod_state state)
+{
+	if (sdiodev->state == INFF_SDIOD_NOMEDIUM ||
+	    state == sdiodev->state)
+		return;
+
+	inff_dbg(TRACE, "%d -> %d\n", sdiodev->state, state);
+	switch (sdiodev->state) {
+	case INFF_SDIOD_DATA:
+		/* any other state means bus interface is down */
+		inff_bus_change_state(sdiodev->bus_if, INFF_BUS_DOWN);
+		break;
+	case INFF_SDIOD_DOWN:
+		/* transition from DOWN to DATA means bus interface is up */
+		if (state == INFF_SDIOD_DATA)
+			inff_bus_change_state(sdiodev->bus_if, INFF_BUS_UP);
+		break;
+	default:
+		break;
+	}
+	sdiodev->state = state;
+}
+
+static int inff_sdiod_set_backplane_window(struct inff_sdio_dev *sdiodev,
+					   u32 addr)
+{
+	u32 v, bar0 = addr & SBSDIO_SBWINDOW_MASK;
+	int err = 0, i;
+
+	if (inff_sdio_bus_sleep_state(sdiodev->bus)) {
+		if (!sdiodev->ignore_bus_error)
+			inff_err("ERROR: Write operation when bus is in sleep state\n");
+		return -EPERM;
+	}
+
+	if (sdiodev->sbwad_valid && bar0 == sdiodev->sbwad)
+		return 0;
+
+	v = bar0 >> 8;
+
+	for (i = 0 ; i < 3 && !err ; i++, v >>= 8)
+		inff_sdiod_writeb(sdiodev, SBSDIO_FUNC1_SBADDRLOW + i,
+				  v & 0xff, &err);
+
+	if (!err) {
+		sdiodev->sbwad_valid = 1;
+		sdiodev->sbwad = bar0;
+	}
+
+	return err;
+}
+
+u32 inff_sdiod_readl(struct inff_sdio_dev *sdiodev, u32 addr, int *ret)
+{
+	u32 data = 0;
+	int retval;
+
+	inff_dbg(SDIOEXT, "addr 0x%x\n", addr);
+
+	if (inff_sdio_bus_sleep_state(sdiodev->bus)) {
+		if (!sdiodev->ignore_bus_error)
+			inff_err("ERROR: Read operation when bus is in sleep state\n");
+		if (ret)
+			*ret = -EPERM;
+		return data;
+	}
+
+	retval = inff_sdiod_set_backplane_window(sdiodev, addr);
+	if (retval)
+		goto out;
+
+	inff_dbg(SDIO, "reading from addr 0x%x bar0 0x%08x ", addr, sdiodev->sbwad);
+
+	addr &= SBSDIO_SB_OFT_ADDR_MASK;
+	addr |= SBSDIO_SB_ACCESS_2_4B_FLAG;
+
+	data = sdio_readl(sdiodev->func1, addr, &retval);
+
+	if (retval)
+		data = 0;
+
+	inff_dbg(SDIO, "data 0x%08x\n", data);
+out:
+	if (ret)
+		*ret = retval;
+
+	return data;
+}
+
+void inff_sdiod_writel(struct inff_sdio_dev *sdiodev, u32 addr,
+		       u32 data, int *ret)
+{
+	int retval;
+
+	inff_dbg(SDIOEXT, "addr 0x%x val 0x%x\n", addr, data);
+
+	if (inff_sdio_bus_sleep_state(sdiodev->bus)) {
+		if (!sdiodev->ignore_bus_error)
+			inff_err("ERROR: Write operation when bus is in sleep state\n");
+		if (ret)
+			*ret = -EPERM;
+		return;
+	}
+
+	retval = inff_sdiod_set_backplane_window(sdiodev, addr);
+	if (retval)
+		goto out;
+
+	inff_dbg(SDIO, "writing 0x%08x to addr 0x%x bar0 0x%08x\n", data, addr, sdiodev->sbwad);
+
+	addr &= SBSDIO_SB_OFT_ADDR_MASK;
+	addr |= SBSDIO_SB_ACCESS_2_4B_FLAG;
+
+	sdio_writel(sdiodev->func1, data, addr, &retval);
+
+out:
+	if (ret)
+		*ret = retval;
+}
+
+static int inff_sdiod_skbuff_read(struct inff_sdio_dev *sdiodev,
+				  struct sdio_func *func, u32 addr,
+				   struct sk_buff *skb)
+{
+	unsigned int req_sz;
+	int err;
+
+	if (inff_sdio_bus_sleep_state(sdiodev->bus)) {
+		if (!sdiodev->ignore_bus_error)
+			inff_err("ERROR: Read operation when bus is in sleep state\n");
+		return -EPERM;
+	}
+
+	/* Single skb use the standard mmc interface */
+	req_sz = skb->len + 3;
+	req_sz &= (uint)~3;
+
+	switch (func->num) {
+	case SDIO_FUNC_1:
+		err = sdio_memcpy_fromio(func, ((u8 *)(skb->data)), addr,
+					 req_sz);
+		break;
+	case SDIO_FUNC_2:
+	case SDIO_FUNC_3:
+		err = sdio_readsb(func, ((u8 *)(skb->data)), addr, req_sz);
+		break;
+	default:
+		/* bail out as things are really fishy here */
+		WARN(1, "invalid sdio function number: %d\n", func->num);
+		err = -ENOMEDIUM;
+	}
+
+	if (err == -ENOMEDIUM)
+		inff_sdiod_change_state(sdiodev, INFF_SDIOD_NOMEDIUM);
+
+	if (err && sdiodev->func2->device == SDIO_DEVICE_ID_CYPRESS_55572)
+		inff_fws_recv_err(sdiodev->bus_if->drvr);
+
+	return err;
+}
+
+static int inff_sdiod_skbuff_write(struct inff_sdio_dev *sdiodev,
+				   struct sdio_func *func, u32 addr,
+				   struct sk_buff *skb)
+{
+	unsigned int req_sz;
+	int err;
+
+	if (inff_sdio_bus_sleep_state(sdiodev->bus)) {
+		if (!sdiodev->ignore_bus_error)
+			inff_err("ERROR: Write operation when bus is in sleep state\n");
+		return -EPERM;
+	}
+
+	/* Single skb use the standard mmc interface */
+	req_sz = skb->len + 3;
+	req_sz &= (uint)~3;
+
+	if (func->num == SDIO_FUNC_1 || func->num == SDIO_FUNC_2)
+		err = sdio_memcpy_toio(func, addr, ((u8 *)(skb->data)), req_sz);
+	else if (func->num == SDIO_FUNC_3)
+		err = sdio_writesb(func, addr, ((u8 *)(skb->data)), req_sz);
+	else
+		return -EINVAL;
+
+	if (err == -ENOMEDIUM)
+		inff_sdiod_change_state(sdiodev, INFF_SDIOD_NOMEDIUM);
+
+	return err;
+}
+
+static int mmc_submit_one(struct mmc_data *md, struct mmc_request *mr,
+			  struct mmc_command *mc, int sg_cnt, int req_sz,
+			  int func_blk_sz, u32 *addr,
+			  struct inff_sdio_dev *sdiodev,
+			  struct sdio_func *func, int write)
+{
+	int ret;
+
+	if (inff_sdio_bus_sleep_state(sdiodev->bus)) {
+		if (!sdiodev->ignore_bus_error)
+			inff_err("ERROR: %s operation when bus is in sleep state\n",
+				 write ? "Write" : "Read");
+		return -EPERM;
+	}
+
+	md->sg_len = sg_cnt;
+	md->blocks = req_sz / func_blk_sz;
+	mc->arg |= (*addr & 0x1FFFF) << 9;	/* address */
+	mc->arg |= md->blocks & 0x1FF;	/* block count */
+	/* incrementing addr for function 1 */
+	if (func->num == SDIO_FUNC_1)
+		*addr += req_sz;
+
+	mmc_set_data_timeout(md, func->card);
+	mmc_wait_for_req(func->card->host, mr);
+
+	ret = mc->error ? mc->error : md->error;
+	if (ret == -ENOMEDIUM) {
+		inff_sdiod_change_state(sdiodev, INFF_SDIOD_NOMEDIUM);
+	} else if (ret != 0) {
+		inff_err("CMD53 sg block %s failed %d\n",
+			 write ? "write" : "read", ret);
+		ret = -EIO;
+	}
+
+	return ret;
+}
+
+/**
+ * inff_sdiod_sglist_rw - SDIO interface function for block data access
+ * @sdiodev: inffmac sdio device
+ * @func: SDIO function
+ * @write: direction flag
+ * @addr: dongle memory address as source/destination
+ * @pktlist: skb buffer head pointer
+ *
+ * This function takes the respbonsibility as the interface function to MMC
+ * stack for block data access. It assumes that the skb passed down by the
+ * caller has already been padded and aligned.
+ */
+static int inff_sdiod_sglist_rw(struct inff_sdio_dev *sdiodev,
+				struct sdio_func *func,
+				 bool write, u32 addr,
+				 struct sk_buff_head *pktlist)
+{
+	unsigned int req_sz, func_blk_sz, sg_cnt, sg_data_sz, pkt_offset;
+	unsigned int max_req_sz, src_offset, dst_offset;
+	unsigned char *pkt_data, *orig_data, *dst_data;
+	struct sk_buff_head local_list, *target_list;
+	struct sk_buff *pkt_next = NULL, *src;
+	unsigned short max_seg_cnt;
+	struct mmc_request mmc_req;
+	struct mmc_command mmc_cmd;
+	struct mmc_data mmc_dat;
+	struct scatterlist *sgl;
+	int ret = 0;
+
+	if (!pktlist->qlen)
+		return -EINVAL;
+
+	target_list = pktlist;
+	/* for host with broken sg support, prepare a page aligned list */
+	__skb_queue_head_init(&local_list);
+	if (!write && sdiodev->settings->bus.sdio.broken_sg_support) {
+		req_sz = 0;
+		skb_queue_walk(pktlist, pkt_next)
+			req_sz += pkt_next->len;
+		req_sz = ALIGN(req_sz, func->cur_blksize);
+		while (req_sz > PAGE_SIZE) {
+			pkt_next = inff_pkt_buf_get_skb(PAGE_SIZE);
+			if (!pkt_next) {
+				ret = -ENOMEM;
+				goto exit;
+			}
+			__skb_queue_tail(&local_list, pkt_next);
+			req_sz -= PAGE_SIZE;
+		}
+		pkt_next = inff_pkt_buf_get_skb(req_sz);
+		if (!pkt_next) {
+			ret = -ENOMEM;
+			goto exit;
+		}
+		__skb_queue_tail(&local_list, pkt_next);
+		target_list = &local_list;
+	}
+
+	func_blk_sz = func->cur_blksize;
+	max_req_sz = sdiodev->max_request_size;
+	max_seg_cnt = min_t(unsigned short, sdiodev->max_segment_count,
+			    target_list->qlen);
+
+	memset(&mmc_req, 0, sizeof(struct mmc_request));
+	memset(&mmc_cmd, 0, sizeof(struct mmc_command));
+	memset(&mmc_dat, 0, sizeof(struct mmc_data));
+
+	mmc_dat.sg = sdiodev->sgtable.sgl;
+	mmc_dat.blksz = func_blk_sz;
+	mmc_dat.flags = write ? MMC_DATA_WRITE : MMC_DATA_READ;
+	mmc_cmd.opcode = SD_IO_RW_EXTENDED;
+	mmc_cmd.arg = write ? 1 << 31 : 0;	/* write flag  */
+	mmc_cmd.arg |= (func->num & 0x7) << 28;	/* SDIO func num */
+	mmc_cmd.arg |= 1 << 27;			/* block mode */
+	/* for function 1 the addr will be incremented */
+	mmc_cmd.arg |= (func->num == SDIO_FUNC_1) ? 1 << 26 : 0;
+	mmc_cmd.flags = MMC_RSP_SPI_R5 | MMC_RSP_R5 | MMC_CMD_ADTC;
+	mmc_req.cmd = &mmc_cmd;
+	mmc_req.data = &mmc_dat;
+
+	req_sz = 0;
+	sg_cnt = 0;
+	sgl = sdiodev->sgtable.sgl;
+	skb_queue_walk(target_list, pkt_next) {
+		pkt_offset = 0;
+		while (pkt_offset < pkt_next->len) {
+			pkt_data = pkt_next->data + pkt_offset;
+			sg_data_sz = pkt_next->len - pkt_offset;
+			if (sg_data_sz > sdiodev->max_segment_size)
+				sg_data_sz = sdiodev->max_segment_size;
+			if (sg_data_sz > max_req_sz - req_sz)
+				sg_data_sz = max_req_sz - req_sz;
+
+			if (!sgl) {
+				/* out of (pre-allocated) scatterlist entries */
+				ret = -ENOMEM;
+				goto exit;
+			}
+			sg_set_buf(sgl, pkt_data, sg_data_sz);
+			sg_cnt++;
+
+			sgl = sg_next(sgl);
+			req_sz += sg_data_sz;
+			pkt_offset += sg_data_sz;
+			if (req_sz >= max_req_sz || sg_cnt >= max_seg_cnt) {
+				ret = mmc_submit_one(&mmc_dat, &mmc_req, &mmc_cmd,
+						     sg_cnt, req_sz, func_blk_sz,
+						     &addr, sdiodev, func, write);
+				if (ret)
+					goto exit_queue_walk;
+				req_sz = 0;
+				sg_cnt = 0;
+				sgl = sdiodev->sgtable.sgl;
+			}
+		}
+	}
+	if (sg_cnt)
+		ret = mmc_submit_one(&mmc_dat, &mmc_req, &mmc_cmd,
+				     sg_cnt, req_sz, func_blk_sz,
+				     &addr, sdiodev, func, write);
+exit_queue_walk:
+	if (!write && sdiodev->settings->bus.sdio.broken_sg_support) {
+		src = __skb_peek(&local_list);
+		src_offset = 0;
+		skb_queue_walk(pktlist, pkt_next) {
+			dst_offset = 0;
+
+			/* This is safe because we must have enough SKB data
+			 * in the local list to cover everything in pktlist.
+			 */
+			while (1) {
+				req_sz = pkt_next->len - dst_offset;
+				if (req_sz > src->len - src_offset)
+					req_sz = src->len - src_offset;
+
+				orig_data = src->data + src_offset;
+				dst_data = pkt_next->data + dst_offset;
+				memcpy(dst_data, orig_data, req_sz);
+
+				src_offset += req_sz;
+				if (src_offset == src->len) {
+					src_offset = 0;
+					src = skb_peek_next(src, &local_list);
+				}
+				dst_offset += req_sz;
+				if (dst_offset == pkt_next->len)
+					break;
+			}
+		}
+	}
+
+exit:
+	sg_init_table(sdiodev->sgtable.sgl, sdiodev->sgtable.orig_nents);
+	while ((pkt_next = __skb_dequeue(&local_list)) != NULL)
+		inff_pkt_buf_free_skb(pkt_next);
+
+	if (ret && sdiodev->func2->device == SDIO_DEVICE_ID_CYPRESS_55572)
+		inff_fws_recv_err(sdiodev->bus_if->drvr);
+
+	return ret;
+}
+
+int inff_sdiod_recv_buf(struct inff_sdio_dev *sdiodev, u8 fn,
+			u8 *buf, uint nbytes)
+{
+	struct sk_buff *mypkt = NULL;
+	int err = 0;
+
+	mypkt = inff_pkt_buf_get_skb(nbytes);
+	if (!mypkt) {
+		inff_err("inff_pkt_buf_get_skb failed: len %d\n",
+			 nbytes);
+		return -EIO;
+	}
+
+	err = inff_sdiod_recv_pkt(sdiodev, fn, mypkt);
+	if (!err)
+		memcpy(buf, mypkt->data, nbytes);
+
+	inff_pkt_buf_free_skb(mypkt);
+	return err;
+}
+
+int inff_sdiod_recv_pkt(struct inff_sdio_dev *sdiodev, u8 fn,
+			struct sk_buff *pkt)
+{
+	struct sdio_func *func = NULL;
+	u32 base_addr = 0;
+	u32 recv_addr = 0;
+	int err = 0;
+
+	if (fn == SDIO_FUNC_2) {
+		/* F2 is only DMA. HW ignore the address field in the cmd53 /cmd52. */
+		base_addr = sdiodev->cc_core->base;
+		recv_addr = base_addr & SBSDIO_SB_OFT_ADDR_MASK;
+		recv_addr |= SBSDIO_SB_ACCESS_2_4B_FLAG;
+		func = sdiodev->func2;
+	} else if (fn == SDIO_FUNC_3) {
+		/* F3 has registers and DMA. A DMA access is identified using the
+		 * address value 0x0. If the address field has any other value, it
+		 * won't be considered as F3 packet transfer. If the address corresponds
+		 * to a valid F3 register address, driver will get proper response,
+		 * otherwise driver will get error response.
+		 */
+		base_addr = 0;
+		recv_addr = 0;
+		func = sdiodev->func3;
+	} else {
+		inff_err("invalid function number: %d\n", fn);
+		return -EINVAL;
+	}
+
+	err = inff_sdiod_set_backplane_window(sdiodev, base_addr);
+	if (err)
+		goto done;
+
+	err = inff_sdiod_skbuff_read(sdiodev, func, recv_addr, pkt);
+
+	inff_dbg(DATA, "F%d, base addr: 0x%x, recv addr: 0x%x, size: %d, err: %d\n",
+		 fn, base_addr, recv_addr, pkt->len, err);
+done:
+	return err;
+}
+
+int inff_sdiod_recv_chain(struct inff_sdio_dev *sdiodev,
+			  struct sk_buff_head *pktq, uint totlen)
+{
+	struct sk_buff *glom_skb = NULL;
+	struct sk_buff *skb;
+	u32 addr = sdiodev->cc_core->base;
+	int err = 0;
+
+	inff_dbg(SDIO, "addr = 0x%x, size = %d\n",
+		 addr, pktq->qlen);
+
+	err = inff_sdiod_set_backplane_window(sdiodev, addr);
+	if (err)
+		goto done;
+
+	addr &= SBSDIO_SB_OFT_ADDR_MASK;
+	addr |= SBSDIO_SB_ACCESS_2_4B_FLAG;
+
+	if (pktq->qlen == 1) {
+		err = inff_sdiod_skbuff_read(sdiodev, sdiodev->func2, addr,
+					     __skb_peek(pktq));
+	} else if (!sdiodev->sg_support) {
+		glom_skb = inff_pkt_buf_get_skb(totlen);
+		if (!glom_skb)
+			return -ENOMEM;
+		err = inff_sdiod_skbuff_read(sdiodev, sdiodev->func2, addr,
+					     glom_skb);
+		if (err)
+			goto done;
+
+		skb_queue_walk(pktq, skb) {
+			memcpy(skb->data, glom_skb->data, skb->len);
+			skb_pull(glom_skb, skb->len);
+		}
+	} else {
+		err = inff_sdiod_sglist_rw(sdiodev, sdiodev->func2, false,
+					   addr, pktq);
+	}
+
+done:
+	inff_pkt_buf_free_skb(glom_skb);
+	return err;
+}
+
+int inff_sdiod_send_buf(struct inff_sdio_dev *sdiodev, u8 fn,
+			u8 *buf, uint nbytes)
+{
+	struct sk_buff *mypkt = NULL;
+	struct sdio_func *func = NULL;
+	u32 base_addr = 0;
+	u32 send_addr = 0;
+	int err = 0;
+
+	if (fn == 2) {
+		/* F2 is only DMA. HW ignore the address field in the cmd53 /cmd52. */
+		base_addr = sdiodev->cc_core->base;
+		send_addr = base_addr & SBSDIO_SB_OFT_ADDR_MASK;
+		send_addr |= SBSDIO_SB_ACCESS_2_4B_FLAG;
+		func = sdiodev->func2;
+	} else if (fn == 3) {
+		/* F3 has registers and DMA. A DMA access is identified using the
+		 * address value 0x0. If the address field has any other value, it
+		 * won't be considered as F3 packet transfer. If the address corresponds
+		 * to a valid F3 register address, driver will get proper response,
+		 * otherwise driver will get error response.
+		 */
+		base_addr = 0;
+		send_addr = 0;
+		func = sdiodev->func3;
+	} else {
+		inff_err("invalid function number: %d\n", fn);
+		return -EINVAL;
+	}
+
+	mypkt = inff_pkt_buf_get_skb(nbytes);
+
+	if (!mypkt) {
+		inff_err("inff_pkt_buf_get_skb failed: len %d\n",
+			 nbytes);
+		return -EIO;
+	}
+
+	memcpy(mypkt->data, buf, nbytes);
+
+	err = inff_sdiod_set_backplane_window(sdiodev, base_addr);
+	if (err)
+		goto out;
+
+	err = inff_sdiod_skbuff_write(sdiodev, func, send_addr, mypkt);
+
+	inff_dbg(DATA, "F%d, base addr: 0x%x, send addr: 0x%x, size: %d, err: %d\n",
+		 fn, base_addr, send_addr, mypkt->len, err);
+out:
+	inff_pkt_buf_free_skb(mypkt);
+
+	return err;
+}
+
+int inff_sdiod_send_pkt(struct inff_sdio_dev *sdiodev,
+			struct sk_buff_head *pktq)
+{
+	struct sk_buff *skb;
+	u32 addr = sdiodev->cc_core->base;
+	int err;
+
+	inff_dbg(SDIO, "addr = 0x%x, size = %d\n", addr, pktq->qlen);
+
+	err = inff_sdiod_set_backplane_window(sdiodev, addr);
+	if (err)
+		return err;
+
+	addr &= SBSDIO_SB_OFT_ADDR_MASK;
+	addr |= SBSDIO_SB_ACCESS_2_4B_FLAG;
+
+	if (pktq->qlen == 1 || !sdiodev->sg_support) {
+		skb_queue_walk(pktq, skb) {
+			err = inff_sdiod_skbuff_write(sdiodev, sdiodev->func2,
+						      addr, skb);
+			if (err)
+				break;
+		}
+	} else {
+		err = inff_sdiod_sglist_rw(sdiodev, sdiodev->func2, true,
+					   addr, pktq);
+	}
+
+	return err;
+}
+
+int
+inff_sdiod_ramrw(struct inff_sdio_dev *sdiodev, bool write, u32 address,
+		 u8 *data, uint size)
+{
+	int err = 0;
+	struct sk_buff *pkt;
+	u32 sdaddr;
+	uint dsize;
+
+	dsize = min_t(uint, SBSDIO_SB_OFT_ADDR_LIMIT, size);
+	pkt = __dev_alloc_skb(dsize, GFP_KERNEL);
+	if (!pkt) {
+		inff_err("dev_alloc_skb failed: len %d\n", dsize);
+		return -EIO;
+	}
+	pkt->priority = 0;
+
+	/* Determine initial transfer parameters */
+	sdaddr = address & SBSDIO_SB_OFT_ADDR_MASK;
+	if ((sdaddr + size) & SBSDIO_SBWINDOW_MASK)
+		dsize = (SBSDIO_SB_OFT_ADDR_LIMIT - sdaddr);
+	else
+		dsize = size;
+
+	sdio_claim_host(sdiodev->func1);
+
+	/* Do the transfer(s) */
+	while (size) {
+		/* Set the backplane window to include the start address */
+		err = inff_sdiod_set_backplane_window(sdiodev, address);
+		if (err)
+			break;
+
+		inff_dbg(SDIO, "%s %d bytes at offset 0x%08x in window 0x%08x\n",
+			 write ? "write" : "read", dsize,
+			 sdaddr, address & SBSDIO_SBWINDOW_MASK);
+
+		sdaddr &= SBSDIO_SB_OFT_ADDR_MASK;
+		sdaddr |= SBSDIO_SB_ACCESS_2_4B_FLAG;
+
+		skb_put(pkt, dsize);
+
+		if (write) {
+			memcpy(pkt->data, data, dsize);
+			err = inff_sdiod_skbuff_write(sdiodev, sdiodev->func1,
+						      sdaddr, pkt);
+		} else {
+			err = inff_sdiod_skbuff_read(sdiodev, sdiodev->func1,
+						     sdaddr, pkt);
+		}
+
+		if (err) {
+			inff_err("membytes transfer failed write=%d err=%d\n", write, err);
+			break;
+		}
+		if (!write)
+			memcpy(data, pkt->data, dsize);
+		skb_trim(pkt, 0);
+
+		/* Adjust for next transfer (if any) */
+		size -= dsize;
+		if (size) {
+			data += dsize;
+			address += dsize;
+			sdaddr = 0;
+			dsize = min_t(uint, SBSDIO_SB_OFT_ADDR_LIMIT, size);
+		}
+	}
+
+	dev_kfree_skb(pkt);
+
+	sdio_release_host(sdiodev->func1);
+
+	return err;
+}
+
+int inff_sdiod_abort(struct inff_sdio_dev *sdiodev, struct sdio_func *func)
+{
+	inff_dbg(SDIO, "Enter\n");
+
+	/* Issue abort cmd52 command through F0 */
+	inff_sdiod_func0_wb(sdiodev, SDIO_CCCR_ABORT, func->num, NULL);
+
+	inff_dbg(SDIO, "Exit\n");
+	return 0;
+}
+
+void inff_sdiod_sgtable_alloc(struct inff_sdio_dev *sdiodev)
+{
+	struct sdio_func *func;
+	struct mmc_host *host;
+	uint max_blocks;
+	uint nents;
+	int err;
+
+	func = sdiodev->func2;
+	host = func->card->host;
+	sdiodev->sg_support = host->max_segs > 1;
+	max_blocks = min_t(uint, host->max_blk_count, 511u);
+	sdiodev->max_request_size = min_t(uint, host->max_req_size,
+					  max_blocks * func->cur_blksize);
+	sdiodev->max_segment_count = min_t(uint, host->max_segs,
+					   SG_MAX_SINGLE_ALLOC);
+	sdiodev->max_segment_size = host->max_seg_size;
+
+	if (!sdiodev->sg_support)
+		return;
+
+	nents = max_t(uint, INFF_DEFAULT_RXGLOM_SIZE,
+		      sdiodev->settings->bus.sdio.txglomsz);
+	nents *= 2;
+
+	WARN_ON(nents > sdiodev->max_segment_count);
+
+	inff_dbg(TRACE, "nents=%d\n", nents);
+	err = sg_alloc_table(&sdiodev->sgtable, nents, GFP_KERNEL);
+	if (err < 0) {
+		inff_err("allocation failed: disable scatter-gather");
+		sdiodev->sg_support = false;
+	}
+
+	sdiodev->txglomsz = sdiodev->settings->bus.sdio.txglomsz;
+}
+
+static int inff_sdiod_freezer_attach(struct inff_sdio_dev *sdiodev)
+{
+	if (!IS_ENABLED(CONFIG_PM_SLEEP))
+		return 0;
+
+	sdiodev->freezer = kzalloc(sizeof(*sdiodev->freezer), GFP_KERNEL);
+	if (!sdiodev->freezer)
+		return -ENOMEM;
+	atomic_set(&sdiodev->freezer->thread_count, 0);
+	atomic_set(&sdiodev->freezer->freezing, 0);
+	init_waitqueue_head(&sdiodev->freezer->thread_freeze);
+	init_completion(&sdiodev->freezer->resumed);
+	return 0;
+}
+
+static void inff_sdiod_freezer_detach(struct inff_sdio_dev *sdiodev)
+{
+	if (sdiodev->freezer) {
+		WARN_ON(atomic_read(&sdiodev->freezer->freezing));
+		kfree(sdiodev->freezer);
+		sdiodev->freezer = NULL;
+	}
+}
+
+static int inff_sdiod_freezer_on(struct inff_sdio_dev *sdiodev)
+{
+	atomic_t *expect = &sdiodev->freezer->thread_count;
+	int res = 0;
+
+	sdiodev->freezer->frozen_count = 0;
+	reinit_completion(&sdiodev->freezer->resumed);
+	atomic_set(&sdiodev->freezer->freezing, 1);
+	inff_sdio_trigger_dpc(sdiodev->bus);
+	wait_event(sdiodev->freezer->thread_freeze,
+		   atomic_read(expect) == sdiodev->freezer->frozen_count);
+	sdio_claim_host(sdiodev->func1);
+	res = inff_sdio_sleep(sdiodev->bus, true);
+	sdio_release_host(sdiodev->func1);
+	return res;
+}
+
+static void inff_sdiod_freezer_off(struct inff_sdio_dev *sdiodev)
+{
+	sdio_claim_host(sdiodev->func1);
+	inff_sdio_sleep(sdiodev->bus, false);
+	sdio_release_host(sdiodev->func1);
+	atomic_set(&sdiodev->freezer->freezing, 0);
+	complete_all(&sdiodev->freezer->resumed);
+}
+
+bool inff_sdiod_freezing(struct inff_sdio_dev *sdiodev)
+{
+	return IS_ENABLED(CONFIG_PM_SLEEP) &&
+		atomic_read(&sdiodev->freezer->freezing);
+}
+
+void inff_sdiod_try_freeze(struct inff_sdio_dev *sdiodev)
+{
+	if (!inff_sdiod_freezing(sdiodev))
+		return;
+	sdiodev->freezer->frozen_count++;
+	wake_up(&sdiodev->freezer->thread_freeze);
+	wait_for_completion(&sdiodev->freezer->resumed);
+}
+
+void inff_sdiod_freezer_count(struct inff_sdio_dev *sdiodev)
+{
+	if (IS_ENABLED(CONFIG_PM_SLEEP))
+		atomic_inc(&sdiodev->freezer->thread_count);
+}
+
+void inff_sdiod_freezer_uncount(struct inff_sdio_dev *sdiodev)
+{
+	if (IS_ENABLED(CONFIG_PM_SLEEP))
+		atomic_dec(&sdiodev->freezer->thread_count);
+}
+
+int inff_sdiod_remove(struct inff_sdio_dev *sdiodev)
+{
+	sdiodev->state = INFF_SDIOD_DOWN;
+	if (sdiodev->bus) {
+		inff_sdio_remove(sdiodev->bus);
+		sdiodev->bus = NULL;
+	}
+
+	inff_sdiod_freezer_detach(sdiodev);
+
+	/* Disable functions 2 then 1. */
+	sdio_claim_host(sdiodev->func1);
+	sdio_disable_func(sdiodev->func2);
+	sdio_disable_func(sdiodev->func1);
+	sdio_release_host(sdiodev->func1);
+
+	sg_free_table(&sdiodev->sgtable);
+	sdiodev->sbwad = 0;
+	sdiodev->sbwad_valid = 0;
+
+	pm_runtime_allow(sdiodev->func1->card->host->parent);
+	return 0;
+}
+
+static void inff_sdiod_host_fixup(struct mmc_host *host)
+{
+	/* runtime-pm powers off the device */
+	pm_runtime_forbid(host->parent);
+	/* avoid removal detection upon resume */
+	host->caps |= MMC_CAP_NONREMOVABLE;
+}
+
+int inff_sdiod_probe(struct inff_sdio_dev *sdiodev)
+{
+	int ret = 0;
+	unsigned int f2_blksz = SDIO_FUNC2_BLOCKSIZE;
+
+	sdio_claim_host(sdiodev->func1);
+
+	ret = sdio_set_block_size(sdiodev->func1, SDIO_FUNC1_BLOCKSIZE);
+	if (ret) {
+		inff_err("Failed to set F1 blocksize\n");
+		sdio_release_host(sdiodev->func1);
+		return ret;
+	}
+	switch (sdiodev->func2->device) {
+	case SDIO_DEVICE_ID_CYPRESS_55572:
+	case SDIO_DEVICE_ID_CYPRESS_55500:
+		f2_blksz = SDIO_INF55572_FUNC2_BLOCKSIZE;
+		break;
+	case SDIO_DEVICE_ID_CYPRESS_55900:
+		f2_blksz = SDIO_INF55900_FUNC2_BLOCKSIZE;
+		break;
+	default:
+		break;
+	}
+
+	ret = sdio_set_block_size(sdiodev->func2, f2_blksz);
+	if (ret) {
+		inff_err("Failed to set F2 blocksize\n");
+		sdio_release_host(sdiodev->func1);
+		return ret;
+	}
+	inff_dbg(SDIO, "set F2 blocksize to %d\n", f2_blksz);
+
+	/* increase F2 timeout */
+	sdiodev->func2->enable_timeout = SDIO_WAIT_F2RDY;
+
+	/* Enable Function 1 */
+	ret = sdio_enable_func(sdiodev->func1);
+	sdio_release_host(sdiodev->func1);
+	if (ret) {
+		inff_err("Failed to enable F1: err=%d\n", ret);
+		goto out;
+	}
+
+	ret = inff_sdiod_freezer_attach(sdiodev);
+	if (ret)
+		goto out;
+
+	/* try to attach to the target device */
+	sdiodev->bus = inff_sdio_probe(sdiodev);
+	if (IS_ERR(sdiodev->bus)) {
+		ret = PTR_ERR(sdiodev->bus);
+		goto out;
+	}
+	inff_sdiod_host_fixup(sdiodev->func2->card->host);
+out:
+	if (ret)
+		inff_sdiod_remove(sdiodev);
+
+	return ret;
+}
+
+#define INFF_SDIO_DEVICE(dev_id)	\
+	{SDIO_DEVICE(SDIO_VENDOR_ID_CYPRESS, dev_id)}
+
+/* devices we support, null terminated */
+static const struct sdio_device_id inff_sdmmc_ids[] = {
+	INFF_SDIO_DEVICE(SDIO_DEVICE_ID_CYPRESS_55572),
+	INFF_SDIO_DEVICE(SDIO_DEVICE_ID_CYPRESS_55500),
+	INFF_SDIO_DEVICE(SDIO_DEVICE_ID_CYPRESS_43022),
+	INFF_SDIO_DEVICE(SDIO_DEVICE_ID_CYPRESS_55900),
+	{ /* end: all zeroes */ }
+};
+MODULE_DEVICE_TABLE(sdio, inff_sdmmc_ids);
+
+static void inff_sdiod_acpi_save_power_manageable(struct inff_sdio_dev *sdiodev)
+{
+#if IS_ENABLED(CONFIG_ACPI)
+	struct acpi_device *adev;
+
+	adev = ACPI_COMPANION(&sdiodev->func1->dev);
+	if (adev)
+		sdiodev->func1_power_manageable = adev->flags.power_manageable;
+
+	adev = ACPI_COMPANION(&sdiodev->func2->dev);
+	if (adev)
+		sdiodev->func2_power_manageable = adev->flags.power_manageable;
+#endif
+}
+
+static void inff_sdiod_acpi_set_power_manageable(struct inff_sdio_dev *sdiodev,
+						 int enable)
+{
+#if IS_ENABLED(CONFIG_ACPI)
+	struct acpi_device *adev;
+
+	adev = ACPI_COMPANION(&sdiodev->func1->dev);
+	if (adev)
+		adev->flags.power_manageable = enable ? sdiodev->func1_power_manageable : 0;
+
+	adev = ACPI_COMPANION(&sdiodev->func2->dev);
+	if (adev)
+		adev->flags.power_manageable = enable ? sdiodev->func2_power_manageable : 0;
+#endif
+}
+
+static int inff_ops_sdio_probe(struct sdio_func *func,
+			       const struct sdio_device_id *id)
+{
+	int err;
+	struct inff_sdio_dev *sdiodev;
+	struct inff_bus *bus_if;
+
+	if (!id) {
+		dev_err(&func->dev, "Error no sdio_device_id passed for %x:%x\n",
+			func->vendor, func->device);
+		return -ENODEV;
+	}
+
+	inff_dbg(SDIO, "Enter\n");
+	inff_dbg(SDIO, "Class=%x\n", func->class);
+	inff_dbg(SDIO, "sdio vendor ID: 0x%04x\n", func->vendor);
+	inff_dbg(SDIO, "sdio device ID: 0x%04x\n", func->device);
+	inff_dbg(SDIO, "Function#: %d\n", func->num);
+
+	/* Set MMC_QUIRK_LENIENT_FN0 for this card */
+	func->card->quirks |= MMC_QUIRK_LENIENT_FN0;
+
+	/* Set MMC_QUIRK_BLKSZ_FOR_BYTE_MODE for this card
+	 * Use func->cur_blksize by default
+	 */
+	func->card->quirks |= MMC_QUIRK_BLKSZ_FOR_BYTE_MODE;
+
+	/* Consume func num 1 but dont do anything with it. */
+	if (func->num == SDIO_FUNC_1 || func->num == SDIO_FUNC_3)
+		return 0;
+
+	/* Ignore anything but func 2 */
+	if (func->num != SDIO_FUNC_2)
+		return -ENODEV;
+
+	bus_if = kzalloc(sizeof(*bus_if), GFP_KERNEL);
+	if (!bus_if)
+		return -ENOMEM;
+	sdiodev = kzalloc(sizeof(*sdiodev), GFP_KERNEL);
+	if (!sdiodev) {
+		kfree(bus_if);
+		return -ENOMEM;
+	}
+
+	/* store refs to functions used. mmc_card does
+	 * not hold the F0 function pointer.
+	 */
+	sdiodev->func1 = func->card->sdio_func[0];
+	sdiodev->func2 = func;
+	sdiodev->func3 = func->card->sdio_func[2];
+
+	sdiodev->bus_if = bus_if;
+	bus_if->bus_priv.sdio = sdiodev;
+	bus_if->proto_type = INFF_PROTO_BCDC;
+	dev_set_drvdata(&func->dev, bus_if);
+	dev_set_drvdata(&sdiodev->func1->dev, bus_if);
+	sdiodev->dev = &sdiodev->func1->dev;
+	dev_set_drvdata(&sdiodev->func2->dev, bus_if);
+	if (sdiodev->func3) {
+		inff_dbg(SDIO, "Set F3 dev\n");
+		dev_set_drvdata(&sdiodev->func3->dev, bus_if);
+	}
+
+	inff_sdiod_acpi_save_power_manageable(sdiodev);
+	inff_sdiod_change_state(sdiodev, INFF_SDIOD_DOWN);
+
+	inff_dbg(SDIO, "F2 found, calling inff_sdiod_probe...\n");
+	err = inff_sdiod_probe(sdiodev);
+	if (err) {
+		inff_err("F2 error, probe failed %d...\n", err);
+		goto fail;
+	}
+
+	inff_dbg(SDIO, "F2 init completed...\n");
+	return 0;
+
+fail:
+	dev_set_drvdata(&func->dev, NULL);
+	dev_set_drvdata(&sdiodev->func1->dev, NULL);
+	dev_set_drvdata(&sdiodev->func2->dev, NULL);
+	kfree(sdiodev);
+	kfree(bus_if);
+	return err;
+}
+
+static void inff_ops_sdio_remove(struct sdio_func *func)
+{
+	struct inff_bus *bus_if;
+	struct inff_sdio_dev *sdiodev;
+
+	inff_dbg(SDIO, "Enter\n");
+	inff_dbg(SDIO, "sdio vendor ID: 0x%04x\n", func->vendor);
+	inff_dbg(SDIO, "sdio device ID: 0x%04x\n", func->device);
+	inff_dbg(SDIO, "Function: %d\n", func->num);
+
+	bus_if = dev_get_drvdata(&func->dev);
+	if (bus_if) {
+		sdiodev = bus_if->bus_priv.sdio;
+
+		/* start by unregistering irqs */
+		inff_sdiod_intr_unregister(sdiodev);
+
+		if (func->num != SDIO_FUNC_1)
+			return;
+
+		/* only proceed with rest of cleanup if func 1 */
+		inff_sdiod_remove(sdiodev);
+
+		dev_set_drvdata(&sdiodev->func1->dev, NULL);
+		dev_set_drvdata(&sdiodev->func2->dev, NULL);
+		if (sdiodev->func3) {
+			inff_dbg(SDIO, "Remove F3 dev\n");
+			dev_set_drvdata(&sdiodev->func3->dev, NULL);
+		}
+
+		kfree(bus_if);
+		kfree(sdiodev);
+	}
+
+	inff_dbg(SDIO, "Exit\n");
+}
+
+void inff_sdio_wowl_config(struct device *dev, bool enabled)
+{
+	struct inff_bus *bus_if = dev_get_drvdata(dev);
+	struct inff_sdio_dev *sdiodev = bus_if->bus_priv.sdio;
+	mmc_pm_flag_t pm_caps = sdio_get_host_pm_caps(sdiodev->func1);
+
+	/* Power must be preserved to be able to support WOWL. */
+	if (!(pm_caps & MMC_PM_KEEP_POWER))
+		goto notsup;
+
+	if (sdiodev->settings->bus.sdio.oob_irq_supported ||
+	    pm_caps & MMC_PM_WAKE_SDIO_IRQ) {
+		/* Stop ACPI from turning off the device when wowl is enabled */
+		inff_sdiod_acpi_set_power_manageable(sdiodev, !enabled);
+		sdiodev->wowl_enabled = enabled;
+		inff_dbg(SDIO, "Configuring WOWL, enabled=%d\n", enabled);
+		return;
+	}
+
+notsup:
+	inff_dbg(SDIO, "WOWL not supported\n");
+}
+
+static int inff_ops_sdio_suspend(struct device *dev)
+{
+	struct sdio_func *func;
+	struct inff_bus *bus_if;
+	struct inff_sdio_dev *sdiodev;
+	mmc_pm_flag_t sdio_flags;
+	struct inff_cfg80211_info *config;
+	int retry = INFF_PM_WAIT_MAXRETRY;
+	bool cap_power_off;
+	int ret = 0;
+
+	func = container_of(dev, struct sdio_func, dev);
+
+	cap_power_off = !!(func->card->host->caps & MMC_CAP_POWER_OFF_CARD);
+
+	bus_if = dev_get_drvdata(dev);
+	config = bus_if->drvr->config;
+
+	inff_dbg(SDIO, "Enter: F%d\n", func->num);
+
+	while (retry &&
+	       config->pm_state == INFF_CFG80211_PM_STATE_SUSPENDING) {
+		usleep_range(10000, 20000);
+		retry--;
+	}
+	if (!retry && config->pm_state == INFF_CFG80211_PM_STATE_SUSPENDING)
+		inff_err("timed out wait for cfg80211 suspended\n");
+
+	if (func->num != SDIO_FUNC_1)
+		return 0;
+
+	sdiodev = bus_if->bus_priv.sdio;
+
+	if (sdiodev->wowl_enabled || !cap_power_off) {
+		inff_sdiod_freezer_on(sdiodev);
+		inff_sdio_wd_timer(sdiodev->bus, 0);
+
+		sdio_flags = MMC_PM_KEEP_POWER;
+		if (sdiodev->wowl_enabled) {
+			if (sdiodev->settings->bus.sdio.oob_irq_supported)
+				enable_irq_wake(sdiodev->settings->bus.sdio.oob_irq_nr);
+			else
+				sdio_flags |= MMC_PM_WAKE_SDIO_IRQ;
+		}
+
+		if (sdio_set_host_pm_flags(sdiodev->func1, sdio_flags))
+			inff_err("Failed to set pm_flags %x\n", sdio_flags);
+
+	} else {
+		/* power will be cut so remove device, probe again in resume */
+		inff_sdiod_intr_unregister(sdiodev);
+		ret = inff_sdiod_remove(sdiodev);
+		if (ret)
+			inff_err("Failed to remove device on suspend\n");
+	}
+
+	return ret;
+}
+
+static int inff_ops_sdio_resume(struct device *dev)
+{
+	struct inff_bus *bus_if = dev_get_drvdata(dev);
+	struct inff_sdio_dev *sdiodev = bus_if->bus_priv.sdio;
+	struct sdio_func *func = container_of(dev, struct sdio_func, dev);
+	bool cap_power_off = !!(func->card->host->caps & MMC_CAP_POWER_OFF_CARD);
+	int ret = 0;
+
+	inff_dbg(SDIO, "Enter: F%d\n", func->num);
+	if (func->num != SDIO_FUNC_2)
+		return 0;
+
+	if (!sdiodev->wowl_enabled && cap_power_off) {
+		/* bus was powered off and device removed, probe again */
+		ret = inff_sdiod_probe(sdiodev);
+		if (ret)
+			inff_err("Failed to probe device on resume\n");
+	} else {
+		if (sdiodev->wowl_enabled && sdiodev->settings->bus.sdio.oob_irq_supported)
+			disable_irq_wake(sdiodev->settings->bus.sdio.oob_irq_nr);
+
+		inff_sdiod_freezer_off(sdiodev);
+	}
+
+	return ret;
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(inff_sdio_pm_ops,
+				inff_ops_sdio_suspend,
+				inff_ops_sdio_resume);
+
+static struct sdio_driver inff_sdmmc_driver = {
+	.probe = inff_ops_sdio_probe,
+	.remove = inff_ops_sdio_remove,
+	.name = KBUILD_MODNAME,
+	.id_table = inff_sdmmc_ids,
+	.drv = {
+		.pm = pm_sleep_ptr(&inff_sdio_pm_ops),
+		.coredump = inff_dev_coredump,
+	},
+};
+
+int inff_sdio_register(void)
+{
+	return sdio_register_driver(&inff_sdmmc_driver);
+}
+
+void inff_sdio_exit(void)
+{
+	inff_dbg(SDIO, "Enter\n");
+
+	sdio_unregister_driver(&inff_sdmmc_driver);
+}
-- 
2.25.1


