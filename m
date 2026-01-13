Return-Path: <linux-wireless+bounces-30763-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 58047D1B3B4
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jan 2026 21:36:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A70F13003840
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jan 2026 20:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96EF1276051;
	Tue, 13 Jan 2026 20:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b="MSmt0gH/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp9.infineon.com (smtp9.infineon.com [217.10.52.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1952772D
	for <linux-wireless@vger.kernel.org>; Tue, 13 Jan 2026 20:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.52.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768336588; cv=none; b=gvOU6gIM9jhzbdP7Cxcuk59FUY0ucCeq1rkogkP2lIHzXLd3FDe9eaEh+EXcWMzeGB2JCphLF6dgT9XPoOM4E9GxSumDl6v9QEV6AaFs6uHTP+LybnlYj5OmBurEqfq9RaZMw29LXLdc7Bz3TDiejp2DXk94XnWfvT6v0HjVD9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768336588; c=relaxed/simple;
	bh=tEG2XLuHw9pPSWaLz4jWx8TE60BsSdjacFRMgV06SSg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q+s3gv3t+RpUTlmNv8zvSfdhIR8IO+mXWsP/zyR8psTamHJna9i6AWcAegFTmKB2W6aqKliui3hlzpYp7hZEf17amWPl0pbJag0ETioXFSFxGitQOF05Q5cfIGVtPvHV8pum97dKBQa0WjNf2gbEJpYZRv9YRghHC/XuBHUVxRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com; spf=pass smtp.mailfrom=infineon.com; dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b=MSmt0gH/; arc=none smtp.client-ip=217.10.52.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infineon.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1768336586; x=1799872586;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tEG2XLuHw9pPSWaLz4jWx8TE60BsSdjacFRMgV06SSg=;
  b=MSmt0gH/CyEXLcBZaS+KmZYRIJsOUeSiczFkdAHGisEoKh5XFeqamnM4
   rXPUAyTvFjqvYi6vgjkcHnx2J5jRlnslgIEj0QbxEuDBGHBQKNR9kr7rO
   f/57+aXltE+ETu3k+FYpItNtkmWogIZeBpvej0fd1nGLmTCLwZAARvNHN
   s=;
X-CSE-ConnectionGUID: Wq29a81tTTaqcJd0kHGlzA==
X-CSE-MsgGUID: xntkeZTsRUSKvB2OgCo+wQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="78107034"
X-IronPort-AV: E=Sophos;i="6.21,222,1763420400"; 
   d="scan'208";a="78107034"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO MUCSE814.infineon.com) ([172.23.29.40])
  by smtp9.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 21:36:24 +0100
Received: from MUCSE827.infineon.com (172.23.29.20) by MUCSE814.infineon.com
 (172.23.29.40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Tue, 13 Jan
 2026 21:36:23 +0100
Received: from ISCN5CG14747PP.infineon.com (10.161.6.196) by
 MUCSE827.infineon.com (172.23.29.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Tue, 13 Jan 2026 21:36:21 +0100
From: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
To: <linux-wireless@vger.kernel.org>
CC: Johannes Berg <johannes@sipsolutions.net>, Arend van Spriel
	<arend.vanspriel@broadcom.com>, <marex@nabladev.com>,
	<wlan-kernel-dev-list@infineon.com>, <gokulkumar.sivakumar@infineon.com>
Subject: [PATCH wireless-next v2 09/34] wifi: inffmac: add dfu.c/h
Date: Wed, 14 Jan 2026 02:03:22 +0530
Message-ID: <20260113203350.16734-10-gokulkumar.sivakumar@infineon.com>
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
X-ClientProxiedBy: MUCSE815.infineon.com (172.23.29.41) To
 MUCSE827.infineon.com (172.23.29.20)

Driver implementation for doing Device Firmware Updates (DFU) on the WLAN
Device. Like for example Connecivity Processor (CP) chipsets have multiple
offloaded functionalities, which can be upgraded using this DFU support.

Signed-off-by: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
---
 drivers/net/wireless/infineon/inffmac/dfu.c | 883 ++++++++++++++++++++
 drivers/net/wireless/infineon/inffmac/dfu.h | 109 +++
 2 files changed, 992 insertions(+)
 create mode 100644 drivers/net/wireless/infineon/inffmac/dfu.c
 create mode 100644 drivers/net/wireless/infineon/inffmac/dfu.h

diff --git a/drivers/net/wireless/infineon/inffmac/dfu.c b/drivers/net/wireless/infineon/inffmac/dfu.c
new file mode 100644
index 000000000000..6ff092720088
--- /dev/null
+++ b/drivers/net/wireless/infineon/inffmac/dfu.c
@@ -0,0 +1,883 @@
+// SPDX-License-Identifier: ISC
+/*
+ * Copyright (c) 2025-2026, Infineon Technologies AG, or an affiliate of Infineon Technologies AG.
+ * All rights reserved.
+ */
+
+/*
+ * New IOT specific chips supports new FW download flow to NON-Volatile and Volatile memory.
+ * This is different from the regular Combo chip flow which downloads to RAM/SRAM.
+ * The update will be done to RRAM/FLASH/PSRAM portion of this category of chips.
+ * This would be done in
+ *  1. first time update to the product
+ *  2. dynamic update only to WRLS_Core
+ *  3. complete Product gets updated
+ */
+
+#include <linux/types.h>
+#include <linux/fs.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/atomic.h>
+#include <linux/kernel.h>
+#include <linux/delay.h>
+#include <linux/mmc/sdio_func.h>
+#include <linux/mmc/card.h>
+#include <linux/mmc/sdio_ids.h>
+#include <linux/mmc/host.h>
+
+#include "main.h"
+#include "sdio.h"
+#include "chip.h"
+#include "dev_cmd.h"
+#include "feature.h"
+#include "bus_proto.h"
+#include "dfu.h"
+
+struct inff_dfu_hex_data {
+	int    addr_mode;  /* mode of destination addr */
+	u16    hi_addr;    /* high byte of destination addr */
+	u32    dest_addr;  /* destination addr */
+	u8     *ds;        /* allocate memory for hex file data */
+};
+
+static char *inffmac_dfu_reg_addr2str(u32 addr)
+{
+	switch (addr) {
+	case SDIOD_D2H_MSG_0:
+		return "SDIOD_D2H_MSG_0";
+	case SDIOD_D2H_MSG_1:
+		return "SDIOD_D2H_MSG_1";
+	case SDIOD_D2H_MSG_4:
+		return "SDIOD_D2H_MSG_4";
+	case SDIOD_H2D_MSG_0:
+		return "SDIOD_H2D_MSG_0";
+	case SDIOD_H2D_MSG_4:
+		return "SDIOD_H2D_MSG_4";
+	default:
+		return "Non DEVICE_TO_HOST address";
+	}
+}
+
+static int inff_dfu_msg_readl(struct inff_sdio_dev *sdiodev, u32 addr, u32 *msg)
+{
+	u8 readmsg;
+	int err = 0;
+	*msg = 0;
+
+	/* Security handshake registers are 1 byte registers in SDIO clock domain */
+	readmsg = inff_sdiod_func_rb_ext(sdiodev->func3, addr, &err);
+	if (err) {
+		inff_err("%s err %d", inffmac_dfu_reg_addr2str(addr), err);
+		return -EFAULT;
+	}
+	*msg |= readmsg;
+
+	readmsg = inff_sdiod_func_rb_ext(sdiodev->func3, addr + 1, &err);
+	if (err) {
+		inff_err("%s err %d", inffmac_dfu_reg_addr2str(addr + 1), err);
+		return -EFAULT;
+	}
+	*msg |= (readmsg << 8);
+
+	readmsg = inff_sdiod_func_rb_ext(sdiodev->func3, addr + 2, &err);
+	if (err) {
+		inff_err("%s err %d", inffmac_dfu_reg_addr2str(addr + 2), err);
+		return -EFAULT;
+	}
+	*msg |= (readmsg << 16);
+
+	readmsg = inff_sdiod_func_rb_ext(sdiodev->func3, addr + 3, &err);
+	if (err) {
+		inff_err("%s err %d", inffmac_dfu_reg_addr2str(addr + 3), err);
+		return -EFAULT;
+	}
+	*msg |= (readmsg << 24);
+
+	return err;
+}
+
+static int inff_dfu_msg_writeb(struct inff_sdio_dev *sdiodev, u8 msg)
+{
+	int err = 0;
+
+	inff_sdiod_func_wb(sdiodev, sdiodev->func3, SDIOD_H2D_MSG_0, msg, &err);
+	if (err) {
+		inff_err("err %d", err);
+		return -EFAULT;
+	}
+	return 0;
+}
+
+static int inff_dfu_msg_writel(struct inff_sdio_dev *sdiodev, u32 msg)
+{
+	int err = 0;
+
+	/* Security handshake registers are 1 byte registers in SDIO clock domain */
+	inff_sdiod_func_wb(sdiodev, sdiodev->func3, SDIOD_H2D_MSG_4, ((msg >> 0) & 0xFF), &err);
+	if (err) {
+		inff_err("%s err %d", inffmac_dfu_reg_addr2str(SDIOD_H2D_MSG_4), err);
+		return -EFAULT;
+	}
+	inff_sdiod_func_wb(sdiodev, sdiodev->func3, (SDIOD_H2D_MSG_4 + 1),
+			   ((msg >> 8) & 0xFF), &err);
+	if (err) {
+		inff_err("%s err %d", inffmac_dfu_reg_addr2str(SDIOD_H2D_MSG_4 + 1), err);
+		return -EFAULT;
+	}
+	inff_sdiod_func_wb(sdiodev, sdiodev->func3, (SDIOD_H2D_MSG_4 + 2),
+			   ((msg >> 16) & 0xFF), &err);
+	if (err) {
+		inff_err("%s err %d", inffmac_dfu_reg_addr2str(SDIOD_H2D_MSG_4 + 2), err);
+		return -EFAULT;
+	}
+	inff_sdiod_func_wb(sdiodev, sdiodev->func3, (SDIOD_H2D_MSG_4 + 3),
+			   ((msg >> 24) & 0xFF), &err);
+	if (err) {
+		inff_err("%s err %d", inffmac_dfu_reg_addr2str(SDIOD_H2D_MSG_4 + 3), err);
+		return -EFAULT;
+	}
+
+	return 0;
+}
+
+static int inff_dfu_wait_msg(struct inff_sdio_dev *sdiodev, u32 addr, u32 msg)
+{
+	u32 readmsg = 0;
+	u32 readycnt = 0;
+	int err = 0;
+
+	while (readmsg != msg) {
+		usleep_range(INFF_DFU_CP_ROM_BOOT_DELAY, INFF_DFU_CP_ROM_BOOT_DELAY + 10);
+
+		/* Read the REG to check if desired message is ready */
+		readmsg = inff_sdiod_func_rb(sdiodev, sdiodev->func3, addr, &err);
+		if (err) {
+			inff_err("msg read failed %d", err);
+			return -EFAULT;
+		}
+
+		readycnt++;
+		if (readycnt == INFF_DFU_CP_IORDY_CNT) {
+			inff_err("msg = 0x%x expected = 0x%x\n", readmsg, msg);
+			return -EFAULT;
+		}
+	}
+
+	inff_dbg(SDIO, "msg = 0x%x cnt = %d", msg, readycnt);
+	return 0;
+}
+
+static u16 inff_dfu_extract_fw_hex_field(const char *fw_data, u16 sp, u16 cn)
+{
+	char field[8];
+	u16 v;
+	int result;
+
+	strncpy(field, fw_data + sp, cn);
+	field[cn] = '\0';
+
+	result = sscanf(field, "%hX", &v);
+	if (result)
+		return v;
+
+	return 0;
+}
+
+static int inff_dfu_get_next_line_len(const u8 *fw_data)
+{
+	u32 str_len = 0;
+	u8 *line_end = NULL;
+
+	line_end = strchr(fw_data, '\n');
+	if (*fw_data != ':' || !line_end)
+		return 0;
+
+	str_len = (u32)(line_end - fw_data);
+	inff_dbg(SDIOEXT, "next line len = %d", str_len);
+
+	return str_len;
+}
+
+static int inffmac_dfu_sdio_transfer_membytes(struct inff_sdio_dev *sdiodev, u32 address,
+					      u8 *data, u32 size)
+{
+	int err = 0;
+	u32 block1_offset = 0;
+	u32 block2_addr = 0;
+	u16 block1_size = 0;
+	u16 block2_size = 0;
+	u8 *block2_data = NULL;
+
+	do {
+		/* To avoid SDIO access crosses AXI 4k address boundaries crossing */
+		if (((address & SDIOD_ADDR_BOUND_MASK) + size) > SDIOD_ADDR_BOUND) {
+			inff_dbg(SDIO, "data cross 4K boundary\n");
+			/* The 1st 4k packet */
+			block1_offset = address & SDIOD_ADDR_BOUND_MASK;
+			block1_size = (SDIOD_ADDR_BOUND - block1_offset);
+
+			err = inff_sdiod_ramrw(sdiodev, true, address,
+					       data, block1_size);
+			if (err)
+				break;
+
+			/* The 2nd 4k packet */
+			block2_addr = address + block1_size;
+			block2_size = size - block1_size;
+			block2_data = data + block1_size;
+			err = inff_sdiod_ramrw(sdiodev, true, block2_addr,
+					       block2_data, block2_size);
+		} else {
+			err = inff_sdiod_ramrw(sdiodev, true, address, data, size);
+		}
+	} while (false);
+
+	return err;
+}
+
+static u32 inff_dfu_get_hfd_from_fw_data(const u8 **fw_data,
+					 struct inff_dfu_hex_data *hfd)
+{
+	int str_len;
+	u16 num_bytes, addr, data_pos, type, w, i;
+	u32 abs_base_addr32 = 0;
+	u32 nbytes = 0;
+
+	if (!hfd->ds) {
+		inff_err("String or data string NULL");
+		return nbytes;
+	}
+
+	while (nbytes == 0) {
+		str_len = inff_dfu_get_next_line_len(*fw_data);
+
+		if (str_len == 0) {
+			break;
+		} else if (str_len > INFF_DFU_CP_HEX_DATA_OFFSET) {
+			num_bytes = inff_dfu_extract_fw_hex_field(*fw_data,
+								  INFF_DFU_CP_HEX_NUMB_OFFSET,
+								  INFF_DFU_CP_HEX_NUMB_LEN);
+			addr = inff_dfu_extract_fw_hex_field(*fw_data,
+							     INFF_DFU_CP_HEX_ADDR_OFFSET,
+							     INFF_DFU_CP_HEX_ADDR_LEN);
+			type = inff_dfu_extract_fw_hex_field(*fw_data,
+							     INFF_DFU_CP_HEX_TYPE_OFFSET,
+							     INFF_DFU_CP_HEX_TYPE_LEN);
+			data_pos = INFF_DFU_CP_HEX_DATA_OFFSET;
+
+			for (i = 0; i < num_bytes; i++) {
+				w = inff_dfu_extract_fw_hex_field(*fw_data, data_pos,
+								  INFF_DFU_CP_HEX_NUMB_LEN);
+				hfd->ds[i] = (u8)(w & 0x00FF);
+				data_pos += INFF_DFU_CP_HEX_NUMB_LEN;
+			}
+			switch (type) {
+			case INFF_DFU_CP_HEX_LINE_TYPE_EXT_ADDR:
+				hfd->hi_addr = (hfd->ds[0] << 8) | hfd->ds[1];
+				hfd->addr_mode = INFF_DFU_CP_ADDR_MODE_EXTENDED;
+				inff_dbg(SDIO, "hfd->hi_addr0x%x ", hfd->hi_addr);
+				break;
+			case INFF_DFU_CP_HEX_LINE_TYPE_EXT_SEGMENT_ADDR:
+				hfd->hi_addr = (hfd->ds[0] << 8) | hfd->ds[1];
+				hfd->addr_mode = INFF_DFU_CP_ADDR_MODE_SEGMENT;
+				break;
+			case INFF_DFU_CP_HEX_LINE_TYPE_ABS_32BIT_ADDR:
+				abs_base_addr32 = (hfd->ds[0] << 24) | (hfd->ds[1] << 16) |
+					(hfd->ds[2] << 8) | hfd->ds[3];
+				hfd->addr_mode = INFF_DFU_CP_ADDR_MODE_LINEAR32;
+				break;
+			case INFF_DFU_CP_HEX_LINE_TYPE_DATA:
+				hfd->dest_addr = addr;
+				if (hfd->addr_mode == INFF_DFU_CP_ADDR_MODE_EXTENDED)
+					hfd->dest_addr += (hfd->hi_addr << 16);
+				else if (hfd->addr_mode == INFF_DFU_CP_ADDR_MODE_SEGMENT)
+					hfd->dest_addr += (hfd->hi_addr << 4);
+				else if (hfd->addr_mode == INFF_DFU_CP_ADDR_MODE_LINEAR32)
+					hfd->dest_addr += abs_base_addr32;
+				nbytes = num_bytes;
+				break;
+			}
+		}
+
+		/* End of file reached, exit loop */
+		if (type == INFF_DFU_CP_HEX_LINE_TYPE_END_OF_DATA) {
+			inff_dbg(SDIO, "End of data\n");
+			break;
+		}
+
+		/* move to next line */
+		*fw_data += str_len + 1;
+	}
+
+	inff_dbg(SDIO, "nbytes [%d]\n", nbytes);
+	return nbytes;
+}
+
+static int inff_dfu_cp_fw_img_download(struct inff_sdio_dev *sdiodev, const struct firmware *fw)
+{
+	struct inff_dfu_hex_data hfd = {INFF_DFU_CP_ADDR_MODE_EXTENDED, 0, 0, NULL};
+	const u8 *app_data = NULL;
+	u8 *mem_blk = NULL;
+	u8 *mem_ptr = NULL;
+	u32 rd;
+	int ret  = 0;
+	u8 sn = 1, nesn = 0;
+	u32 addrf = 0;
+	u32 readmsg = 0;
+	u16 bootfw_rsp_cnt = 0;
+
+	app_data = fw->data;
+	mem_blk = kmalloc(INFF_DFU_CP_BLK_SIZE + INFF_DFU_CP_SD_ALIGN, GFP_KERNEL);
+	if (!mem_blk) {
+		inff_err("Fail to allocate memory for FWDL block");
+		ret = -ENOMEM;
+		goto err;
+	}
+	mem_ptr = mem_blk;
+
+	if ((u32)(uintptr_t)mem_ptr % INFF_DFU_CP_SD_ALIGN)
+		mem_ptr += (INFF_DFU_CP_SD_ALIGN - ((u32)(uintptr_t)mem_blk %
+			    INFF_DFU_CP_SD_ALIGN));
+
+	hfd.ds = kmalloc(INFF_DFU_CP_MAX_STR_LEN, GFP_KERNEL);
+	if (!hfd.ds) {
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	/* Wait for boot fw ready message from Device */
+	ret = inff_dfu_wait_msg(sdiodev, SDIOD_D2H_MSG_1, INFF_DFU_CP_D2H_MSG_BOOTFW_READY);
+	if (ret)
+		goto err;
+
+	while ((rd = inff_dfu_get_hfd_from_fw_data(&app_data, &hfd)) > 0) {
+		u32 start_addr, start_data, end_addr, end_data, i, wbc, pad;
+
+		inff_dbg(SDIO, "SN = %d, NESN = %d, addr = 0x%x", sn, nesn, addrf);
+		inff_dbg(SDIOEXT, "\tread %d bytes at address %08x", rd, hfd.dest_addr);
+
+		start_addr = INFF_DFU_CP_MEM_OFFSET | (CYW5591x_FWDWNLD_RAM_WR_ADDR &
+				INFF_DFU_CP_START_ADDR_MASK);
+		wbc = 0;
+
+		/**
+		 * Make sure the start address is 4 byte aligned to avoid alignment issues
+		 * with SD host controllers
+		 */
+		if (!ISALIGNED(start_addr, INFF_DFU_CP_HEX_ALIGN_LEN)) {
+			pad        = start_addr % INFF_DFU_CP_HEX_ALIGN_LEN;
+			start_addr = ROUNDDN(start_addr, INFF_DFU_CP_HEX_ALIGN_LEN);
+			inff_dbg(SDIO, "Padding start address : %d  bytes\n", pad);
+			start_data = inff_sdiod_readl(sdiodev, start_addr, &ret);
+			if (ret) {
+				inff_err("start_addr:0x%x inff_sdiod_readl error:%d",
+					 start_addr, ret);
+				goto err;
+			}
+			for (i = 0; i < pad; i++, wbc++)
+				mem_ptr[wbc] = (u8)((u8 *)&start_data)[i];
+		}
+
+		/* length */
+		mem_ptr[0] = rd;
+		mem_ptr[1] = rd >> 8;
+		wbc += 2;
+
+		/* address */
+		mem_ptr[2] = hfd.dest_addr;
+		mem_ptr[3] = hfd.dest_addr >> 8;
+		mem_ptr[4] = hfd.dest_addr >> 16;
+		mem_ptr[5] = hfd.dest_addr >> 24;
+
+		wbc += 4;
+
+		inff_dbg(SDIO, "addr :0x%x\n", hfd.dest_addr);
+
+		memcpy(&mem_ptr[wbc], hfd.ds, rd);
+		wbc += rd;
+
+		inff_dbg(SDIO, "data copied %d bytes\n", rd);
+		/* Make sure the length is multiple of 4bytes to avoid alignment issues
+		 * with SD host controllers
+		 */
+		end_addr = start_addr + wbc;
+
+		if (!ISALIGNED(end_addr, 4)) {
+			end_data = inff_sdiod_readl(sdiodev, ROUNDDN(end_addr, 4), &ret);
+			if (ret) {
+				inff_err("end_addr:0x%x inff_sdiod_readl error:%d", end_addr,
+					 ret);
+				goto err;
+			}
+			for (i = (end_addr % 4); i < 4; i++, wbc++)
+				mem_ptr[wbc] = (u8)((u8 *)&end_data)[i];
+		}
+
+		inff_dbg(SDIO, "SDIO PKT size %d bytes\n", wbc);
+
+		if (((start_addr & 0xFFF) + wbc) <= 0x1000) {
+			ret = inffmac_dfu_sdio_transfer_membytes(sdiodev, start_addr,
+								 mem_ptr, wbc);
+			if (ret) {
+				inff_err("error %d on writing %d membytes at 0x%08x",
+					 ret, rd, start_addr);
+				goto err;
+			}
+		} else {
+			u32 wb = 0x1000 - (start_addr & 0xFFF);
+
+			ret = inffmac_dfu_sdio_transfer_membytes(sdiodev, start_addr,
+								 mem_ptr, wb);
+			if (ret) {
+				inff_err("error %d on writing %d membytes at 0x%08x",
+					 ret, rd, start_addr);
+				goto err;
+			}
+
+			usleep_range(INFF_DFU_CP_SDIORB_NEXT_DELAY, INFF_DFU_CP_SDIORB_NEXT_DELAY);
+
+			ret = inffmac_dfu_sdio_transfer_membytes(sdiodev, (start_addr + wb),
+								 (mem_ptr + wb), (wbc - wb));
+			if (ret) {
+				inff_err("error %d on writing %d membytes at 0x%08x",
+					 ret, rd, start_addr);
+				goto err;
+			}
+		}
+
+		ret = inff_dfu_msg_writel(sdiodev, CYW5591x_FWDWNLD_RAM_WR_ADDR | nesn);
+		if (ret)
+			goto err;
+
+		ret = inff_dfu_msg_writeb(sdiodev, INFF_DFU_CP_H2D_MSG_BOOTFW_DATA_LOADED);
+		if (ret)
+			goto err;
+
+		/* Wait for CP boot fw to process current chunk of data */
+		sn = nesn;
+		nesn = (nesn) ? 0 : 1;
+		addrf = hfd.dest_addr;
+		bootfw_rsp_cnt = 0;
+		/*Check if seq no is changed, Mindriver might not have processed the prev pkt */
+		do {
+			usleep_range(INFF_BOOTFW_RSP_DELAY, INFF_BOOTFW_RSP_DELAY + 10);
+			ret = inff_dfu_msg_readl(sdiodev, SDIOD_D2H_MSG_4, &readmsg);
+			if (ret)
+				goto err;
+			inff_dbg(SDIO, "expected sn =%d, received sn = %d\n", nesn,
+				 (readmsg & INFF_DFU_CP_SEQ_MASK));
+			bootfw_rsp_cnt++;
+			if  (bootfw_rsp_cnt == INFF_BOOTFW_RSP_MAX_CNT) {
+				inff_err("Boot FW response timeout cnt = %d\n",
+					 INFF_BOOTFW_RSP_MAX_CNT);
+				ret = -EFAULT;
+				goto err;
+			}
+		} while ((readmsg & INFF_DFU_CP_SEQ_MASK) != nesn);
+
+		/* Wait for boot fw ready message from Device before next chunk */
+		ret = inff_dfu_wait_msg(sdiodev, SDIOD_D2H_MSG_1,
+					INFF_DFU_CP_D2H_MSG_BOOTFW_READY);
+		if (ret)
+			goto err;
+
+		/* clear H2D message to prevent boot fw start to process chunk of data */
+		ret = inff_dfu_msg_writeb(sdiodev, 0);
+		if (ret)
+			goto err;
+	}
+
+	ret = inff_dfu_msg_writel(sdiodev, CYW5591x_IMAGE_LAUNCH_ADDR);
+	if (ret)
+		goto err;
+
+	ret = inff_dfu_msg_writeb(sdiodev, INFF_DFU_CP_H2D_MSG_BOOTFW_DATA_LOADED);
+	if (ret)
+		goto err;
+
+	ret = inff_dfu_wait_msg(sdiodev, SDIOD_D2H_MSG_0, INFF_DFU_CP_D2H_MSG_FW_VALIDAT_START);
+	if (ret)
+		goto err;
+err:
+	release_firmware(fw);
+	kfree(mem_blk);
+	kfree(hfd.ds);
+	return ret;
+}
+
+static int inff_dfu_cp_bootfw_download(struct inff_sdio_dev *sdiodev, const struct firmware *fw)
+{
+	struct inff_dfu_hex_data hfd = {INFF_DFU_CP_ADDR_MODE_EXTENDED, 0, 0, NULL};
+	const u8 *bootfw_data = NULL;
+	u8 *mem_blk = NULL;
+	u8 *mem_ptr = NULL;
+	u32 rd;
+	int ret  = 0;
+
+	bootfw_data = fw->data;
+	mem_blk = kmalloc(INFF_DFU_CP_BLK_SIZE + INFF_DFU_CP_SD_ALIGN, GFP_KERNEL);
+	mem_ptr = mem_blk;
+	if (!mem_ptr) {
+		inff_err("Fail to allocate memory for FWDL block");
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	if ((u32)(uintptr_t)mem_ptr % INFF_DFU_CP_SD_ALIGN)
+		mem_ptr += (INFF_DFU_CP_SD_ALIGN - ((u32)(uintptr_t)mem_blk %
+			    INFF_DFU_CP_SD_ALIGN));
+
+	hfd.ds = kmalloc(INFF_DFU_CP_MAX_STR_LEN, GFP_KERNEL);
+	if (!hfd.ds) {
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	while ((rd = inff_dfu_get_hfd_from_fw_data(&bootfw_data, &hfd)) > 0) {
+		u32 start_addr, start_data, end_addr, end_data, i, wbc, pad;
+
+		inff_dbg(SDIO, "\tread %d bytes at address %08x", rd, hfd.dest_addr);
+
+		start_addr = INFF_DFU_CP_MEM_OFFSET | (hfd.dest_addr & INFF_DFU_CP_START_ADDR_MASK);
+		wbc        = 0;
+
+		/**
+		 * Make sure the start address is 4 byte aligned to avoid alignment issues
+		 * with SD host controllers
+		 */
+		if (!ISALIGNED(start_addr, INFF_DFU_CP_HEX_ALIGN_LEN)) {
+			pad        = start_addr % INFF_DFU_CP_HEX_ALIGN_LEN;
+			start_addr = ROUNDDN(start_addr, INFF_DFU_CP_HEX_ALIGN_LEN);
+			start_data = inff_sdiod_readl(sdiodev, start_addr, &ret);
+			if (ret) {
+				inff_err("start_addr:0x%x inf_sdiod_readl error:%d",
+					 start_addr, ret);
+				goto err;
+			}
+			for (i = 0; i < pad; i++, wbc++)
+				mem_ptr[wbc] = (u8)((u8 *)&start_data)[i];
+		}
+		memcpy(&mem_ptr[wbc], hfd.ds, rd);
+		wbc += rd;
+		/**
+		 * Make sure the length is multiple of 4bytes to avoid alignment issues
+		 * with SD host controllers
+		 */
+		end_addr = start_addr + wbc;
+		if (!ISALIGNED(end_addr, 4)) {
+			end_data = inff_sdiod_readl(sdiodev, ROUNDDN(end_addr, 4), &ret);
+			if (ret) {
+				inff_err("end_addr:0x%x inf_sdiod_readl error:%d", end_addr,
+					 ret);
+				goto err;
+			}
+			for (i = (end_addr % 4); i < 4; i++, wbc++)
+				mem_ptr[wbc] = (u8)((u8 *)&end_data)[i];
+		}
+
+		if (((start_addr & 0xFFF) + wbc) <= 0x1000) {
+			ret = inffmac_dfu_sdio_transfer_membytes(sdiodev, start_addr,
+								 mem_ptr, wbc);
+			if (ret) {
+				inff_err("error %d on writing %d membytes at 0x%08x",
+					 ret, rd, start_addr);
+				goto err;
+			}
+		} else {
+			u32 wb = 0x1000 - (start_addr & 0xFFF);
+
+			ret = inffmac_dfu_sdio_transfer_membytes(sdiodev, start_addr,
+								 mem_ptr, wb);
+			if (ret) {
+				inff_err("error %d on writing %d membytes at 0x%08x",
+					 ret, rd, start_addr);
+				goto err;
+			}
+			usleep_range(INFF_DFU_CP_SDIORB_NEXT_DELAY,
+				     INFF_DFU_CP_SDIORB_NEXT_DELAY + 10);
+			ret = inffmac_dfu_sdio_transfer_membytes(sdiodev, (start_addr + wb),
+								 (mem_ptr + wb), (wbc - wb));
+			if (ret) {
+				inff_err("error %d on writing %d membytes at 0x%08x",
+					 ret, rd, start_addr);
+				goto err;
+			}
+		}
+	}
+
+err:
+	release_firmware(fw);
+	kfree(mem_blk);
+	kfree(hfd.ds);
+	return ret;
+}
+
+static int inff_dfu_cp_img_dwnld_start(struct inff_sdio_dev *sdiodev,
+				       const struct firmware *boot_fw,
+				       const struct firmware *cp_fw)
+{
+	int err = 0;
+
+	err = inff_dfu_wait_msg(sdiodev, SDIOD_D2H_MSG_0, INFF_DFU_CP_D2H_MSG_BL_READY);
+	if (err)
+		return -EFAULT;
+
+	err = inff_dfu_msg_writel(sdiodev, CYW5591x_BOOTFW_RAM_LD_ADDR);
+	if (err)
+		return -EFAULT;
+
+	err = inff_dfu_msg_writeb(sdiodev, INFF_DFU_CP_H2D_MSG_BOOT_FWLOAD_START);
+	if (err)
+		return -EFAULT;
+
+	err = inff_dfu_cp_bootfw_download(sdiodev, boot_fw);
+	if (err) {
+		inff_err("CP boot fw download failed[ret %d]", err);
+		return -EFAULT;
+	}
+	inff_dbg(INFO, "CP boot fw download done!!!\n");
+
+	err = inff_dfu_msg_writeb(sdiodev, INFF_DFU_CP_H2D_MSG_BOOT_FWLOAD_DONE);
+	if (err)
+		return -EFAULT;
+
+	err = inff_dfu_cp_fw_img_download(sdiodev, cp_fw);
+	if (err)
+		inff_err("Connected Processor image download failed [ret %d]", err);
+	else
+		inff_dbg(INFO, "Connected Processor image download done!!!\n");
+
+	return err;
+}
+
+int inff_dfu_cp_img_dwnld_init(struct inff_sdio_dev *sdiodev, const struct firmware *boot_fw,
+			       const struct firmware *cp_fw)
+{
+	int	ret = 0;
+	u8 fw_ready = 0;
+
+	ret = sdio_enable_func(sdiodev->func3);
+	if (ret) {
+		inff_err("enable func3 err %d", ret);
+		/* Disable F3 again */
+		sdio_disable_func(sdiodev->func3);
+		goto fail;
+	}
+
+	fw_ready = inff_sdiod_func_rb_ext(sdiodev->func3, SDIOD_D2H_MSG_0, &ret);
+	if (ret) {
+		inff_err("SDIOD_F3_D2H_MSG_0 err %d", ret);
+		ret = -EFAULT;
+		goto fail;
+	}
+
+	inff_dbg(SDIO, "FW Ready Flags 0x%x\n", fw_ready);
+	ret = inff_dfu_cp_img_dwnld_start(sdiodev, boot_fw, cp_fw);
+	if (ret)
+		goto fail;
+
+	return 0;
+fail:
+	return ret;
+}
+
+static int inff_dfu_cp_send_opcode_data(struct inff_if *ifp, u16 op_code, const u8 *data,
+					u16 data_len)
+{
+	static u8 pkt[INFF_DFU_CP_PKT_LEN_MAX] = { INFF_DFU_CP_OTA_CMD_ID };
+	*(u16 *)&pkt[INFF_DFU_CP_OPC_OFFSET] = op_code;
+	int ret = 0;
+
+	switch (op_code) {
+	case INFF_CONTROL_CP_DFU_PRE_DOWNLOAD:
+		ret = inff_cpcmd_data_set(ifp, INFF_CP_C_DFU,
+					  &pkt, INFF_DFU_CP_DAT_OFFSET);
+		break;
+	case INFF_CONTROL_CP_DFU_DOWNLOAD:
+		*(u16 *)&pkt[INFF_DFU_CP_LEN_OFFSET] = data_len;
+		memcpy(&pkt[INFF_DFU_CP_DAT_OFFSET], data, data_len);
+		ret = inff_cpcmd_data_set(ifp, INFF_CP_C_DFU,
+					  &pkt, (data_len + INFF_DFU_CP_DAT_OFFSET));
+		break;
+	case INFF_CONTROL_CP_DFU_DATA:
+		*(u16 *)&pkt[INFF_DFU_CP_LEN_OFFSET] = data_len;
+		if (!data)
+			return -1;
+		memcpy(&pkt[INFF_DFU_CP_DAT_OFFSET], data, data_len);
+		ret = inff_cpcmd_data_set(ifp, INFF_CP_C_DFU,
+					  &pkt, (data_len + INFF_DFU_CP_DAT_OFFSET));
+		break;
+	case INFF_CONTROL_CP_DFU_VERIFY:
+		ret = inff_cpcmd_data_set(ifp, INFF_CP_C_DFU,
+					  &pkt, INFF_DFU_CP_DAT_OFFSET);
+		break;
+	case INFF_CONTROL_CP_DFU_ABORT:
+		ret = inff_cpcmd_data_set(ifp, INFF_CP_C_DFU,
+					  &pkt, INFF_DFU_CP_DAT_OFFSET);
+		break;
+	default:
+		break;
+	}
+
+	if (ret) {
+		inff_err("DFU data send failed, ret=%d\n", ret);
+		return -1;
+	}
+
+	return 0;
+}
+
+static enum fw_upload_err inff_dfu_cp_prepare(struct fw_upload *fw_ul,
+					      const u8 *data, u32 data_size)
+{
+	struct inff_dfu *dfu = fw_ul->dd_handle;
+	struct inff_pub *drvr = dfu->drvr;
+	struct inff_if *ifp = inff_get_ifp(drvr, 0);
+	int ret = 0;
+
+	dfu->cancel_request = false;
+
+	ret = inff_dfu_cp_send_opcode_data(ifp, INFF_CONTROL_CP_DFU_PRE_DOWNLOAD, NULL, 0);
+
+	if (ret) {
+		inff_err("pre download failed, ret=%d\n", ret);
+		return FW_UPLOAD_ERR_BUSY;
+	}
+
+	ret = inff_dfu_cp_send_opcode_data(ifp, INFF_CONTROL_CP_DFU_DOWNLOAD,
+					   (const u8 *)&data_size, sizeof(data_size));
+	if (ret) {
+		inff_err("pre download set size failed, ret=%d\n", ret);
+		return FW_UPLOAD_ERR_INVALID_SIZE;
+	}
+
+	return FW_UPLOAD_ERR_NONE;
+}
+
+static enum fw_upload_err inff_dfu_cp_write(struct fw_upload *fw_ul, const u8 *data,
+					    u32 offset, u32 size, u32 *written)
+{
+	struct inff_dfu *dfu = fw_ul->dd_handle;
+	struct inff_pub *drvr = dfu->drvr;
+	struct inff_if *ifp = inff_get_ifp(drvr, 0);
+	int ret = 0;
+	u32 remains = size;
+	u32 offset_size = 0;
+
+	if (dfu->cancel_request)
+		return FW_UPLOAD_ERR_CANCELED;
+
+	inff_info("DFU image download in progress...\n");
+
+	while (remains > 0) {
+		u16 len = (remains > INFF_DFU_CP_PKT_CHUNK_LEN) ? INFF_DFU_CP_PKT_CHUNK_LEN :
+			  remains;
+
+		ret = inff_dfu_cp_send_opcode_data(ifp, INFF_CONTROL_CP_DFU_DATA,
+						   data + offset_size, len);
+		if (ret) {
+			inff_err("DFU write data failed, ret=%d\n", ret);
+			return FW_UPLOAD_ERR_INVALID_SIZE;
+		}
+		remains -= len;
+		offset_size += len;
+		inff_info(".");
+	}
+
+	inff_dbg(INFO, "\nDFU image download done, verification will start\n");
+	*written = offset_size;
+
+	return FW_UPLOAD_ERR_NONE;
+}
+
+static enum fw_upload_err inff_dfu_cp_poll_complete(struct fw_upload *fw_ul)
+{
+	struct inff_dfu *dfu = fw_ul->dd_handle;
+	struct inff_pub *drvr = dfu->drvr;
+	struct inff_if *ifp = inff_get_ifp(drvr, 0);
+	int ret = 0;
+
+	if (dfu->cancel_request)
+		return FW_UPLOAD_ERR_CANCELED;
+
+	ret = inff_dfu_cp_send_opcode_data(ifp, INFF_CONTROL_CP_DFU_VERIFY, NULL, 0);
+	if (ret) {
+		inff_err("DFU image verify failed, ret=%d\n", ret);
+		return FW_UPLOAD_ERR_FW_INVALID;
+	}
+
+	inff_info("\nDFU image download and validation done!!\n");
+
+	return FW_UPLOAD_ERR_NONE;
+}
+
+static void inff_dfu_cp_cancel(struct fw_upload *fw_ul)
+{
+	struct inff_dfu *dfu = fw_ul->dd_handle;
+	struct inff_pub *drvr = dfu->drvr;
+	struct inff_if *ifp = inff_get_ifp(drvr, 0);
+	int ret = 0;
+
+	dfu->cancel_request = true;
+
+	ret = inff_dfu_cp_send_opcode_data(ifp, INFF_CONTROL_CP_DFU_ABORT, NULL, 0);
+	if (ret)
+		inff_err("DFU cancel failed, ret=%d\n", ret);
+}
+
+static const struct fw_upload_ops inffmac_dfu_cp_ops = {
+	.prepare = inff_dfu_cp_prepare,
+	.write = inff_dfu_cp_write,
+	.poll_complete = inff_dfu_cp_poll_complete,
+	.cancel = inff_dfu_cp_cancel,
+};
+
+int inff_dfu_attach(struct inff_pub *drvr)
+{
+	struct device *dev = drvr->bus_if->dev;
+	struct inff_dfu *dfu = NULL;
+	const struct fw_upload_ops *dfu_ops = NULL;
+
+	switch (drvr->bus_if->chip_pub->socitype) {
+	case INFF_SOCI_AI:
+		/* TODO */
+		return 0;
+	case INFF_SOCI_CP:
+		dfu_ops = &inffmac_dfu_cp_ops;
+		break;
+	default:
+		inff_err("chip type %u is not supported\n",
+			 drvr->bus_if->chip_pub->socitype);
+		return -ENODEV;
+	}
+
+	/* allocate memory for DFU struct */
+	dfu = devm_kzalloc(dev, sizeof(*dfu), GFP_KERNEL);
+	if (!dfu)
+		return -ENOMEM;
+
+	dfu->drvr = drvr;
+	dfu->cancel_request = false;
+
+	/* register firmware upload feature */
+	dfu->fw_ul = firmware_upload_register(THIS_MODULE, dev, dev_name(dev),
+					      dfu_ops, dfu);
+
+	if (IS_ERR(dfu->fw_ul)) {
+		kfree(dfu);
+		inff_err("firmware_upload_register failed[%ld]\n", PTR_ERR(dfu->fw_ul));
+		return PTR_ERR(dfu->fw_ul);
+	}
+	drvr->dfu = dfu;
+	return 0;
+}
+
+void inff_dfu_detach(struct inff_pub *drvr)
+{
+	if (!drvr->dfu)
+		return;
+
+	firmware_upload_unregister(drvr->dfu->fw_ul);
+	drvr->dfu = NULL;
+}
diff --git a/drivers/net/wireless/infineon/inffmac/dfu.h b/drivers/net/wireless/infineon/inffmac/dfu.h
new file mode 100644
index 000000000000..d889286114eb
--- /dev/null
+++ b/drivers/net/wireless/infineon/inffmac/dfu.h
@@ -0,0 +1,109 @@
+/* SPDX-License-Identifier: ISC */
+/*
+ * Copyright (c) 2025-2026, Infineon Technologies AG, or an affiliate of Infineon Technologies AG.
+ * All rights reserved.
+ */
+
+#include "dev_cmd.h"
+#include "chip_5591x.h"
+#include "sdio.h"
+
+#ifndef INFF_DFU_H
+#define INFF_DFU_H
+
+#define SDIOD_ADDR_BOUND                     0x1000
+#define SDIOD_ADDR_BOUND_MASK                0xFFF
+
+/* Host to Device message */
+/* Below H2D Messages needs to align with the Minidirver used */
+#define  SDIOD_H2D_MSG_0                         0x10031
+#define  INFF_DFU_CP_H2D_MSG_BOOT_FWLOAD_START   BIT(0)
+#define  INFF_DFU_CP_H2D_MSG_BOOT_FWLOAD_DONE    BIT(1)
+#define  INFF_DFU_CP_H2D_MSG_BOOTFW_DATA_LOADED BIT(4)
+
+/* Device to Host message */
+#define SDIOD_D2H_MSG_0                        0x10039
+#define INFF_DFU_CP_D2H_MSG_BL_READY           BIT(1)
+#define INFF_DFU_CP_D2H_MSG_FW_VALIDAT_START   BIT(4)
+#define INFF_DFU_CP_D2H_MSG_FW_VALIDAT_DONE    BIT(6)
+
+#define SDIOD_D2H_MSG_1                        0x1003A
+#define INFF_DFU_CP_D2H_MSG_BOOTFW_READY       BIT(0)
+
+#define SDIOD_H2D_MSG_4                     0x10035
+
+#define SDIOD_D2H_MSG_4                     0x1003D
+
+#define INFF_DFU_CP_ROM_BOOT_DELAY          100  /* in usecs */
+
+/* wait for 5000 write/read cycles till F3 is enabled */
+#define INFF_DFU_CP_IORDY_CNT               5000
+
+#define INFF_BOOTFW_RSP_MAX_CNT             2000 /* wait for 2000*100 uS = 200 mS */
+#define INFF_BOOTFW_RSP_DELAY               100  /* 100 uS */
+
+#define INFF_DFU_CP_MEM_OFFSET                 0x19000000
+
+#define INFF_DFU_CP_OTA_CMD_ID                 (0x19)
+#define INFF_DFU_CP_OPC_OFFSET                 (1)
+#define INFF_DFU_CP_LEN_OFFSET                 (3)
+#define INFF_DFU_CP_DAT_OFFSET                 (5)
+
+#define INFF_DFU_CP_MAX_STR_LEN                (600)
+#define INFF_DFU_CP_BLK_SIZE                   (INFF_DFU_CP_MAX_STR_LEN / 2 + 8)
+#define INFF_DFU_CP_SD_ALIGN                   (32)
+
+#define INFF_DFU_CP_PKT_LEN_MAX                (600)
+#define INFF_DFU_CP_PKT_CHUNK_LEN              (256)
+
+#define INFF_CONTROL_CP_GROUP_DFU              (0xC0)
+#define INFF_CONTROL_CP_DFU_PRE_DOWNLOAD       ((INFF_CONTROL_CP_GROUP_DFU << 8) | 0x88)
+#define INFF_CONTROL_CP_DFU_DOWNLOAD           ((INFF_CONTROL_CP_GROUP_DFU << 8) | 0x89)
+#define INFF_CONTROL_CP_DFU_DATA               ((INFF_CONTROL_CP_GROUP_DFU << 8) | 0x8a)
+#define INFF_CONTROL_CP_DFU_VERIFY             ((INFF_CONTROL_CP_GROUP_DFU << 8) | 0x90)
+#define INFF_CONTROL_CP_DFU_ABORT              ((INFF_CONTROL_CP_GROUP_DFU << 8) | 0x92)
+
+#define INFF_DFU_CP_SDIORB_DELAY                10
+#define INFF_DFU_CP_SDIORB_NEXT_DELAY           1000
+
+#define INFF_DFU_CP_MEM_OFFSET                     0x19000000
+#define INFF_DFU_CP_START_ADDR_MASK                0x00FFFFFF
+
+#define INFF_DFU_CP_ADDR_MODE_UNKNOWN              0
+#define INFF_DFU_CP_ADDR_MODE_EXTENDED             1
+#define INFF_DFU_CP_ADDR_MODE_SEGMENT              2
+#define INFF_DFU_CP_ADDR_MODE_LINEAR32             3
+
+#define INFF_DFU_CP_HEX_LINE_TYPE_DATA             0
+#define INFF_DFU_CP_HEX_LINE_TYPE_END_OF_DATA      1
+#define INFF_DFU_CP_HEX_LINE_TYPE_EXT_SEGMENT_ADDR 2
+#define INFF_DFU_CP_HEX_LINE_TYPE_EXT_ADDR         4
+#define INFF_DFU_CP_HEX_LINE_TYPE_ABS_32BIT_ADDR   5
+
+#define INFF_DFU_CP_SEQ_MASK                       0x1
+
+#define INFF_DFU_CP_HEX_DATA_OFFSET       (9)
+#define INFF_DFU_CP_HEX_NUMB_OFFSET       (1)
+#define INFF_DFU_CP_HEX_ADDR_OFFSET       (3)
+#define INFF_DFU_CP_HEX_TYPE_OFFSET       (7)
+
+#define INFF_DFU_CP_HEX_NUMB_LEN          (2)
+#define INFF_DFU_CP_HEX_ADDR_LEN          (4)
+#define INFF_DFU_CP_HEX_TYPE_LEN          (2)
+#define INFF_DFU_CP_HEX_ALIGN_LEN         (4)
+
+#define ROUNDDN(p, align)                   ((p) & ~((align) - 1))
+#define	ISALIGNED(a, x)                     (((uintptr_t)(a) & ((x) - 1)) == 0)
+
+struct inff_dfu {
+	struct inff_pub *drvr;
+	struct fw_upload *fw_ul;
+	bool cancel_request;
+};
+
+int inff_dfu_attach(struct inff_pub *drvr);
+void inff_dfu_detach(struct inff_pub *drvr);
+int inff_dfu_cp_img_dwnld_init(struct inff_sdio_dev *sdiodev, const struct firmware *boot_fw,
+			       const struct firmware *cp_fw);
+
+#endif /* INFF_DFU_H */
-- 
2.25.1


