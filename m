Return-Path: <linux-wireless+bounces-27384-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB2F0B7DC7B
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Sep 2025 14:34:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0E8F1C05CEB
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Sep 2025 22:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE5AF1C5486;
	Tue, 16 Sep 2025 22:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b="n1NxiG29"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp11.infineon.com (smtp11.infineon.com [217.10.52.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773DB2E2DF2
	for <linux-wireless@vger.kernel.org>; Tue, 16 Sep 2025 22:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.52.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758061535; cv=none; b=IXDXeOx+R5fEL9vzSFMByPsERPK6z5KvyM5xYFHDImezPTFGe0ZjdPTxd4z00F11qqTxuh3WE6UuBFyUNLSuCH9sl1yuKT6RxwvS4Bqlmo1Dj7aFI4E5R6HoUmq7DznlhnXavY8k5gtTnIHbMtpZJNnMTrIh8eXDjYRiSBp7GbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758061535; c=relaxed/simple;
	bh=Ndbwc2Fdd1LCvXbYksUMTxo3c/HGWPHTjCiO5WdpkbI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RW3d2U+JPPeKm9rOtwXmilYSdN+T/pRblnyPWWBaoTCZWMoKCQEgeSD6MacD2spYJVJnWk6lH2BVCISOSiDXsgi3At0SFk3kqeciwWOFLeSCt+d4CG5yHCm6wmR+nw8oQ7EEWrPqQvsoHyt6SOw2OiDTp3FgyoLmoJcKOoxaQKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com; spf=pass smtp.mailfrom=infineon.com; dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b=n1NxiG29; arc=none smtp.client-ip=217.10.52.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infineon.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1758061534; x=1789597534;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ndbwc2Fdd1LCvXbYksUMTxo3c/HGWPHTjCiO5WdpkbI=;
  b=n1NxiG29kF3rCuoOIirvFRj+lulYApEq+SU9nYZsM6JXXBsTqJaUoMeH
   495ElNEGwdF1OmRehEWxON9tNvepdABDokLlJYLN+XhT0N/PvhLWfFHHm
   46pkgojdkkgjwFjJfViXW83Hsz2c82TyZUmMKYuQ0tvSuRUyWsDfrw9a6
   I=;
X-CSE-ConnectionGUID: mQmS4EI4STGlfN5w6Xqo5w==
X-CSE-MsgGUID: /hRvF/HHSh28YQG/l0QrFg==
X-IronPort-AV: E=McAfee;i="6800,10657,11555"; a="110918567"
X-IronPort-AV: E=Sophos;i="6.18,270,1751234400"; 
   d="scan'208";a="110918567"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO MUCSE805.infineon.com) ([172.23.29.31])
  by smtp11.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2025 00:25:32 +0200
Received: from MUCSE827.infineon.com (172.23.29.20) by MUCSE805.infineon.com
 (172.23.29.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.36; Wed, 17 Sep
 2025 00:25:31 +0200
Received: from ISCN5CG14747PP.infineon.com (10.161.6.196) by
 MUCSE827.infineon.com (172.23.29.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.36; Wed, 17 Sep 2025 00:25:28 +0200
From: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
To: <linux-wireless@vger.kernel.org>, Johannes Berg
	<johannes@sipsolutions.net>
CC: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>,
	<wlan-kernel-dev-list@infineon.com>
Subject: [PATCH wireless-next 29/57] wifi: inffmac: add dfu.c/h
Date: Wed, 17 Sep 2025 03:47:49 +0530
Message-ID: <20250916221821.4387-35-gokulkumar.sivakumar@infineon.com>
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
X-ClientProxiedBy: MUCSE803.infineon.com (172.23.29.29) To
 MUCSE827.infineon.com (172.23.29.20)

Driver implementation for doing Device Firmware Updates (DFU) on the WLAN
Device. Like for example Connecivity Processor (CP) chipsets have multiple
offloaded functionalities, which can be upgraded using this DFU support.

Signed-off-by: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
---
 drivers/net/wireless/infineon/inffmac/dfu.c | 416 ++++++++++++++++++++
 drivers/net/wireless/infineon/inffmac/dfu.h |  39 ++
 2 files changed, 455 insertions(+)
 create mode 100644 drivers/net/wireless/infineon/inffmac/dfu.c
 create mode 100644 drivers/net/wireless/infineon/inffmac/dfu.h

diff --git a/drivers/net/wireless/infineon/inffmac/dfu.c b/drivers/net/wireless/infineon/inffmac/dfu.c
new file mode 100644
index 000000000000..bf53bdecab9f
--- /dev/null
+++ b/drivers/net/wireless/infineon/inffmac/dfu.c
@@ -0,0 +1,416 @@
+// SPDX-License-Identifier: ISC
+/*
+ * Copyright (c) 2025, Infineon Technologies AG, or an affiliate of Infineon Technologies AG.
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
+#include "defs.h"
+#include "bus.h"
+#include "sdio.h"
+#include "chip.h"
+#include "core.h"
+#include "common.h"
+#include "fwil.h"
+#include "feature.h"
+#include "dfu.h"
+
+struct inff_dfu_hex_data {
+	u32    dest_addr;  /* destination addr */
+	u8     *ds;        /* allocate memory for hex file data */
+};
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
+
+	return 0;
+}
+
+static int inff_dfu_wait_msg(struct inff_sdio_dev *sdiodev, u32 msg)
+{
+	u32 readmsg = 0;
+	u32 readycnt = 0;
+	int err = 0;
+
+	while (readmsg != msg) {
+		usleep_range(INFF_DFU_ROM_BOOT_DELAY, INFF_DFU_ROM_BOOT_DELAY + 10);
+
+		/* Read the REG to check if desired message is ready */
+		readmsg = inff_sdiod_func_rb(sdiodev, sdiodev->func3, SDIOD_D2H_MSG_0, &err);
+		if (err) {
+			inff_err("read fail %d", err);
+			return -EFAULT;
+		}
+
+		readycnt++;
+		if (readycnt == INFF_DFU_IORDY_CNT) {
+			inff_err("msg = 0x%x expected = 0x%x", readmsg, msg);
+			return -EFAULT;
+		}
+	}
+
+	inff_dbg(SDIO, "msg = 0x%x cnt = %d", msg, readycnt);
+
+	return 0;
+}
+
+static u16 inff_dfu_extract_fw_hex_field(const char *fw_data, u16 sp, u16 cn)
+{
+	char field[8];
+	u16 v;
+	int result;
+
+	strscpy(field, fw_data + sp, cn);
+	field[cn] = '\0';
+
+	result = kstrtou16(field, 0, &v);
+
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
+	inff_dbg(SDIO, "next line len = %d", str_len);
+
+	return str_len;
+}
+
+static u32 inff_dfu_get_hfd_from_fw_data(const u8 **fw_data,
+					 struct inff_dfu_hex_data *hfd)
+{
+	int str_len;
+	u16 num_bytes, addr, data_pos, w, i;
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
+		} else if (str_len > 9) {
+			num_bytes = inff_dfu_extract_fw_hex_field(*fw_data, 1, 2);
+			addr = inff_dfu_extract_fw_hex_field(*fw_data, 3, 4);
+
+			data_pos = 7;
+
+			for (i = 0; i < num_bytes; i++) {
+				w = inff_dfu_extract_fw_hex_field(*fw_data, data_pos, 2);
+				hfd->ds[i] = (u8)(w & 0x00FF);
+				data_pos += 2;
+			}
+
+			hfd->dest_addr = addr;
+		}
+
+		/* move to next line */
+		*fw_data += str_len + 1;
+	}
+
+	return nbytes;
+}
+
+static int inff_dfu_start_download(struct inff_sdio_dev *sdiodev)
+{
+	struct inff_dfu_hex_data hfd = {0, NULL};
+	const struct firmware *fw = NULL;
+	char dfu_path[INFF_FW_ALTPATH_LEN] = INFF_FW_DEFAULT_PATH;
+	const u8 *dfu_data = NULL;
+	u8 *mem_blk = NULL;
+	u8 *mem_ptr = NULL;
+	u32 rd;
+	int ret = 0;
+
+	inff_dbg(SDIO, "image path = %s", sdiodev->settings->firmware_path);
+
+	strcat(dfu_path, sdiodev->settings->firmware_path);
+
+	ret = request_firmware_direct(&fw, dfu_path, sdiodev->dev);
+	if (ret) {
+		inff_err("failed to load file %s ret %d\n", dfu_path, ret);
+		goto err;
+	}
+
+	dfu_data = fw->data;
+
+	mem_blk = kmalloc(INFF_DFU_BLK_SIZE + INFF_DFU_SD_ALIGN, GFP_KERNEL);
+	if (!mem_blk) {
+		ret = -ENOMEM;
+		goto err;
+	}
+	mem_ptr = mem_blk;
+
+	if ((u32)(uintptr_t)mem_ptr % INFF_DFU_SD_ALIGN)
+		mem_ptr += (INFF_DFU_SD_ALIGN - ((u32)(uintptr_t)mem_blk % INFF_DFU_SD_ALIGN));
+
+	hfd.ds = kmalloc(INFF_DFU_MAX_STR_LEN, GFP_KERNEL);
+	if (!hfd.ds) {
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	/* Wait for ready message from Device */
+	ret = inff_dfu_wait_msg(sdiodev, INFF_DFU_D2H_MSG_READY);
+	if (ret)
+		goto err;
+
+	while ((rd = inff_dfu_get_hfd_from_fw_data(&dfu_data, &hfd)) > 0) {
+		u32 wbc;
+
+		inff_dbg(SDIO, "\tread %d bytes at address %08x", rd, hfd.dest_addr);
+		wbc = 0;
+
+		/* length */
+		mem_ptr[0] = rd;
+		mem_ptr[1] = rd >> 8;
+
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
+		inff_dbg(SDIO, "SDIO PKT size %d bytes\n", wbc);
+
+		ret = inff_sdiod_ramrw(sdiodev, true, INFF_DFU_MEM_OFFSET, mem_ptr, wbc);
+		if (ret) {
+			inff_err("error %d on writing %d membytes", ret, rd);
+			goto err;
+		}
+
+		ret = inff_dfu_msg_writeb(sdiodev, INFF_DFU_H2D_MSG_DATA);
+		if (ret)
+			goto err;
+
+		/* Wait for ready message from Device before next chunk */
+		ret = inff_dfu_wait_msg(sdiodev, INFF_DFU_D2H_MSG_READY);
+		if (ret)
+			goto err;
+
+		/* clear H2D message to prevent minidriver start to process chunk of data */
+		ret = inff_dfu_msg_writeb(sdiodev, 0);
+		if (ret)
+			goto err;
+	}
+
+	ret = inff_dfu_wait_msg(sdiodev, INFF_DFU_D2H_MSG_FW_VALIDAT);
+	if (ret)
+		goto err;
+err:
+	release_firmware(fw);
+	kfree(mem_blk);
+	kfree(hfd.ds);
+	return ret;
+}
+
+int inff_dfu_start(struct inff_sdio_dev *sdiodev)
+{
+	int	ret = 0;
+
+	ret = sdio_enable_func(sdiodev->func3);
+	if (ret) {
+		inff_err("enable func3 err %d", ret);
+		/* Disable F3 again */
+		sdio_disable_func(sdiodev->func3);
+		goto fail;
+	}
+
+	ret = inff_dfu_msg_writeb(sdiodev, INFF_DFU_H2D_MSG_START);
+	if (ret)
+		goto fail;
+
+	/* download start */
+	ret = inff_dfu_start_download(sdiodev);
+	if (ret)
+		goto fail;
+
+	inff_dbg(SDIO, "Download Image Done!");
+
+	return 0;
+fail:
+	inff_err("Download Image Fail! %d", ret);
+
+	return ret;
+}
+
+static enum fw_upload_err inff_dfu_cp_prepare(struct fw_upload *fw_ul,
+					      const u8 *data, u32 size)
+{
+	struct inff_dfu *dfu = fw_ul->dd_handle;
+	struct inff_pub *drvr = dfu->drvr;
+	int ret = 0;
+
+	dfu->cancel_request = false;
+
+	ret = inff_fil_iovar_data_set(drvr->iflist[0], "dfu_pre_download", NULL, 0);
+	if (ret) {
+		inff_err("pre download failed, ret=%d\n", ret);
+		return FW_UPLOAD_ERR_BUSY;
+	}
+
+	return FW_UPLOAD_ERR_NONE;
+}
+
+static enum fw_upload_err inff_dfu_cp_write(struct fw_upload *fw_ul,
+					    const u8 *data, u32 offset, u32 size, u32 *written)
+{
+	struct inff_dfu *dfu = fw_ul->dd_handle;
+	struct inff_pub *drvr = dfu->drvr;
+	int ret = 0;
+
+	if (dfu->cancel_request)
+		return FW_UPLOAD_ERR_CANCELED;
+
+	ret = inff_fil_iovar_data_set(drvr->iflist[0], "dfu_write_size", &size, sizeof(size));
+	if (ret) {
+		inff_err("write size failed, ret=%d\n", ret);
+		return FW_UPLOAD_ERR_INVALID_SIZE;
+	}
+
+	ret = inff_fil_iovar_data_set(drvr->iflist[0], "dfu_write_data", data, size);
+	if (ret) {
+		inff_err("write data failed, ret=%d\n", ret);
+		return FW_UPLOAD_ERR_FW_INVALID;
+	}
+
+	*written = size;
+
+	return FW_UPLOAD_ERR_NONE;
+}
+
+static enum fw_upload_err inff_dfu_cp_poll_complete(struct fw_upload *fw_ul)
+{
+	struct inff_dfu *dfu = fw_ul->dd_handle;
+	struct inff_pub *drvr = dfu->drvr;
+	int ret = 0;
+
+	if (dfu->cancel_request)
+		return FW_UPLOAD_ERR_CANCELED;
+
+	ret = inff_fil_iovar_data_set(drvr->iflist[0], "dfu_verify", NULL, 0);
+	if (ret) {
+		inff_err("verify failed, ret=%d\n", ret);
+		return FW_UPLOAD_ERR_FW_INVALID;
+	}
+
+	return FW_UPLOAD_ERR_NONE;
+}
+
+static void inff_dfu_cp_cancel(struct fw_upload *fw_ul)
+{
+	struct inff_dfu *dfu = fw_ul->dd_handle;
+
+	dfu->cancel_request = true;
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
+	struct fw_upload *fw_ul = NULL;
+
+	switch (drvr->bus_if->chip_pub->socitype) {
+	case SOCI_AI:
+		/* TODO */
+		return 0;
+	case SOCI_CP:
+		dfu_ops = &inffmac_dfu_cp_ops;
+		break;
+	default:
+		inff_err("chip type %u is not supported\n",
+			 drvr->bus_if->chip_pub->socitype);
+		return -ENODEV;
+	}
+
+	/* allocate memory for DFU struct */
+	dfu = kzalloc(sizeof(*dfu), GFP_KERNEL);
+	if (!dfu)
+		return -ENOMEM;
+
+	/* register firmware upload feature */
+	fw_ul = firmware_upload_register(THIS_MODULE, dev, dev_name(dev),
+					 dfu_ops, dfu);
+	if (IS_ERR(fw_ul)) {
+		kfree(dfu);
+		return PTR_ERR(fw_ul);
+	}
+
+	dfu->drvr = drvr;
+	dfu->fw_ul = fw_ul;
+	dfu->cancel_request = false;
+
+	drvr->dfu = dfu;
+
+	return 0;
+}
+
+void inff_dfu_detach(struct inff_pub *drvr)
+{
+	if (!drvr->dfu)
+		return;
+
+	firmware_upload_unregister(drvr->dfu->fw_ul);
+	kfree(drvr->dfu);
+	drvr->dfu = NULL;
+}
diff --git a/drivers/net/wireless/infineon/inffmac/dfu.h b/drivers/net/wireless/infineon/inffmac/dfu.h
new file mode 100644
index 000000000000..a12c8d58ffc9
--- /dev/null
+++ b/drivers/net/wireless/infineon/inffmac/dfu.h
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: ISC */
+/*
+ * Copyright (c) 2025, Infineon Technologies AG, or an affiliate of Infineon Technologies AG.
+ * All rights reserved.
+ */
+
+#ifndef INFF_DFU_H
+#define INFF_DFU_H
+
+#define INFF_DFU_ROM_BOOT_DELAY        100 /* in usecs */
+#define INFF_DFU_IORDY_CNT             1000 /* wait for 1000 write/read cycles till F3 is enabled */
+
+/* host to device message */
+#define SDIOD_H2D_MSG_0 0x10031
+#define  INFF_DFU_H2D_MSG_START        BIT(0)
+#define  INFF_DFU_H2D_MSG_DATA         BIT(1)
+
+/* device to Host message */
+#define SDIOD_D2H_MSG_0 0x10039
+#define  INFF_DFU_D2H_MSG_READY        BIT(0)
+#define  INFF_DFU_D2H_MSG_FW_VALIDAT   BIT(1)
+
+#define INFF_DFU_MEM_OFFSET            0x19000000
+
+#define INFF_DFU_MAX_STR_LEN           600
+#define INFF_DFU_BLK_SIZE              (INFF_DFU_MAX_STR_LEN / 2 + 8)
+#define INFF_DFU_SD_ALIGN              32
+
+struct inff_dfu {
+	struct inff_pub *drvr;
+	struct fw_upload *fw_ul;
+	bool cancel_request;
+};
+
+int inff_dfu_start(struct inff_sdio_dev *sdiodev);
+int inff_dfu_attach(struct inff_pub *drvr);
+void inff_dfu_detach(struct inff_pub *drvr);
+
+#endif /* INFF_DFU_H */
-- 
2.25.1


