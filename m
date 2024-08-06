Return-Path: <linux-wireless+bounces-11023-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61FBF949624
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Aug 2024 19:02:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4BD51F22DEA
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Aug 2024 17:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 562577BB15;
	Tue,  6 Aug 2024 17:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="iNsYGVtZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3905534CD8;
	Tue,  6 Aug 2024 17:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722963706; cv=none; b=iQSLCVuSQ+Rjut2bc5FENSn+F0HvenRAJfrRXC3a7NLQyMAEL91ytP2rPzfAXidaw1RL65Au2SMpQvN2TU18f3Ob7rDrEpuB4/loy/LXLVeonR8g2stnXW9RQ6EGrRLhRQ7dqdiMLZQhG9dhGbcYgmrtCsrUUbP1c4F4zPEwG60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722963706; c=relaxed/simple;
	bh=tf0/rvfl1Z0sqhpaveGoZMeRDQ4wwe7cwuqCV9e7lZk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j7C5AIBis7MM5RFh+WFYOThz8scVhZddr4hXIvpSH2z7TUeHWwVgZdhWybtVqCPzATkJbVxqWLLnWyXlQO8XWNyxEZfMIwCZRikNf8rFE9XaTpAsmDwl78JQ119egB9g0Sd/P/XIZUCa4WSqguN1HWI+tTPrUFnEawBU/TagaMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=iNsYGVtZ; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 476H1aw5055290;
	Tue, 6 Aug 2024 12:01:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1722963696;
	bh=6M2gCrcfXwkFWMolVCu/YHnoaeeNXVEltWX0sIwWdm4=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=iNsYGVtZa+qjKUpDajnpioweHuLXYH8GGSfuNR5JN60obAdeLXBor2loI9N6We1xA
	 2fbvoB6No3v1x3uQeLSw3SqpncAsQEgAIhK7+BFzEaEQPU0fvZtXK2AO53mhnoX1nv
	 eh8xVDyE/xdFSN2Kj1gUbmq3tRwnCStkUs2u9Lak=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 476H1a16067348
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 6 Aug 2024 12:01:36 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 6
 Aug 2024 12:01:36 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 6 Aug 2024 12:01:36 -0500
Received: from localhost (udb0389739.dhcp.ti.com [137.167.1.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 476H1ZXY037094;
	Tue, 6 Aug 2024 12:01:35 -0500
From: Michael Nemanov <michael.nemanov@ti.com>
To: Kalle Valo <kvalo@kernel.org>, "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo
 Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, <linux-wireless@vger.kernel.org>,
        <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Sabeeh Khan <sabeeh-khan@ti.com>, Michael Nemanov <michael.nemanov@ti.com>
Subject: [PATCH v3 07/17] wifi: cc33xx: Add boot.c, boot.h
Date: Tue, 6 Aug 2024 20:00:08 +0300
Message-ID: <20240806170018.638585-8-michael.nemanov@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240806170018.638585-1-michael.nemanov@ti.com>
References: <20240806170018.638585-1-michael.nemanov@ti.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Implements FW download for CC33xx. The FW comes in 2 parts - a 2nd stage
bootloader (cc33xx_2nd_loader.bin) and the actual FW (cc33xx_fw.bin).
Each file is requested from user space, and transferred to device
chunk by chunk. A dedicated IRQ is excepted after each stage
(Device power-on -> 2nd stage loader -> FW). This logic is implemnted in
cc33xx_init_fw.

Signed-off-by: Michael Nemanov <michael.nemanov@ti.com>
---
 drivers/net/wireless/ti/cc33xx/boot.c | 363 ++++++++++++++++++++++++++
 drivers/net/wireless/ti/cc33xx/boot.h |  24 ++
 2 files changed, 387 insertions(+)
 create mode 100644 drivers/net/wireless/ti/cc33xx/boot.c
 create mode 100644 drivers/net/wireless/ti/cc33xx/boot.h

diff --git a/drivers/net/wireless/ti/cc33xx/boot.c b/drivers/net/wireless/ti/cc33xx/boot.c
new file mode 100644
index 000000000000..f734659f989c
--- /dev/null
+++ b/drivers/net/wireless/ti/cc33xx/boot.c
@@ -0,0 +1,363 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2022-2024 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+#include <linux/firmware.h>
+#include <linux/vmalloc.h>
+
+#include "boot.h"
+#include "cmd.h"
+#include "debug.h"
+#include "init.h"
+#include "io.h"
+
+#define CC33XX_BOOT_TIMEOUT 2000
+
+struct hwinfo_bitmap {
+	u32 disable_5g			: 1u;
+	u32 disable_6g			: 1u;
+	u32 disable_ble			: 1u;
+	u32 disable_ble_m0plus		: 1u;
+	u32 disable_m33			: 1u;
+	u64 udi				: 64u;
+	u32 pg_version			: 4u;
+	u32 metal_version		: 4u;
+	u32 boot_rom_version		: 4u;
+	u32 m3_rom_version		: 4u;
+	u32 fuse_rom_structure_version	: 4u;
+	u64 mac_address			: 48u;
+	u32 device_part_number		: 6u;
+	u32 package_type		: 4u;
+	u32 fw_rollback_protection_1	: 32u;
+	u32 fw_rollback_protection_2	: 32u;
+	u32 fw_rollback_protection_3	: 32u;
+	u32 reserved			: 13u;
+} /* Aligned with boot code, must not be __packed */;
+
+union hw_info {
+	struct hwinfo_bitmap	bitmap;
+	u8			bytes[sizeof(struct hwinfo_bitmap)];
+};
+
+/* Called from threaded irq context */
+void cc33xx_handle_boot_irqs(struct cc33xx *cc, u32 pending_interrupts)
+{
+	if (WARN_ON(!cc->fw_download))
+		return;
+
+	cc33xx_debug(DEBUG_BOOT, "BOOT IRQs: 0x%x", pending_interrupts);
+
+	atomic_or(pending_interrupts, &cc->fw_download->pending_irqs);
+	complete(&cc->fw_download->wait_on_irq);
+}
+
+static u8 *fetch_container(struct cc33xx *cc, const char *container_name,
+			   size_t *container_len)
+{
+	u8 *container_data = NULL;
+	const struct firmware *container;
+	int ret;
+
+	ret = request_firmware(&container, container_name, cc->dev);
+
+	if (ret < 0) {
+		cc33xx_error("could not get container %s: (%d)",
+			     container_name, ret);
+		return NULL;
+	}
+
+	if (container->size % 4) {
+		cc33xx_error("container size is not word-aligned: %zu",
+			     container->size);
+		goto out;
+	}
+
+	*container_len = container->size;
+	container_data = vmalloc(container->size);
+
+	if (!container_data) {
+		cc33xx_error("could not allocate memory for the container");
+		goto out;
+	}
+
+	memcpy(container_data, container->data, container->size);
+
+out:
+	release_firmware(container);
+	return container_data;
+}
+
+static int cc33xx_set_power_on(struct cc33xx *cc)
+{
+	int ret;
+
+	msleep(CC33XX_PRE_POWER_ON_SLEEP);
+	ret = cc33xx_power_on(cc);
+	if (ret < 0)
+		goto out;
+	msleep(CC33XX_POWER_ON_SLEEP);
+	cc33xx_io_reset(cc);
+	cc33xx_io_init(cc);
+
+out:
+	return ret;
+}
+
+static int cc33xx_chip_wakeup(struct cc33xx *cc)
+{
+	int ret = 0;
+
+	cc33xx_debug(DEBUG_BOOT, "Chip wakeup");
+
+	ret = cc33xx_set_power_on(cc);
+	if (ret < 0)
+		goto out;
+
+	if (!cc33xx_set_block_size(cc))
+		cc->quirks &= ~CC33XX_QUIRK_TX_BLOCKSIZE_ALIGN;
+
+out:
+	return ret;
+}
+
+static int wait_for_boot_irq(struct cc33xx *cc, u32 boot_irq_mask,
+			     unsigned long timeout)
+{
+	int ret;
+	u32 pending_irqs;
+	struct cc33xx_fw_download *fw_download;
+
+	fw_download = cc->fw_download;
+
+	ret = wait_for_completion_interruptible_timeout(&fw_download->wait_on_irq,
+							msecs_to_jiffies(timeout));
+
+	/* Fetch pending IRQs while clearing them in fw_download */
+	pending_irqs = atomic_fetch_and(0, &fw_download->pending_irqs);
+	pending_irqs &= ~HINT_COMMAND_COMPLETE;
+
+	reinit_completion(&fw_download->wait_on_irq);
+
+	if (ret == 0) {
+		cc33xx_error("boot IRQ timeout");
+		return -1;
+	} else if (ret < 0) {
+		cc33xx_error("boot IRQ completion error %d", ret);
+		return -2;
+	}
+
+	if (boot_irq_mask != pending_irqs) {
+		cc33xx_error("Unexpected IRQ received @ boot: 0x%x",
+			     pending_irqs);
+		return -3;
+	}
+
+	return 0;
+}
+
+static int download_container(struct cc33xx *cc, u8 *container, size_t len)
+{
+	int ret = 0;
+	u8 *current_transfer;
+	size_t current_transfer_size;
+	u8 *const container_end = container + len;
+	size_t max_transfer_size = cc->fw_download->max_transfer_size;
+	bool is_last_transfer;
+
+	current_transfer = container;
+
+	while (current_transfer < container_end) {
+		current_transfer_size = container_end - current_transfer;
+		current_transfer_size =
+			min(current_transfer_size, max_transfer_size);
+
+		is_last_transfer = (current_transfer + current_transfer_size >= container_end);
+
+		ret = cmd_download_container_chunk(cc,
+						   current_transfer,
+						   current_transfer_size,
+						   is_last_transfer);
+
+		current_transfer += current_transfer_size;
+
+		if (ret < 0) {
+			cc33xx_error("Chunk transfer failed");
+			goto out;
+		}
+	}
+
+out:
+	return ret;
+}
+
+static int container_download_and_wait(struct cc33xx *cc,
+				       const char *container_name,
+				       const u32 irq_wait_mask)
+{
+	int ret =  -1;
+	u8 *container_data;
+	size_t container_len;
+
+	cc33xx_debug(DEBUG_BOOT, "Downloading %s to device", container_name);
+
+	container_data = fetch_container(cc, container_name, &container_len);
+	if (!container_data)
+		return ret;
+
+	ret = download_container(cc, container_data, container_len);
+	if (ret < 0) {
+		cc33xx_error("Transfer error while downloading %s",
+			     container_name);
+		goto out;
+	}
+
+	ret = wait_for_boot_irq(cc, irq_wait_mask, CC33XX_BOOT_TIMEOUT);
+
+	if (ret < 0) {
+		cc33xx_error("%s boot signal timeout", container_name);
+		goto out;
+	}
+
+	cc33xx_debug(DEBUG_BOOT, "%s loaded successfully", container_name);
+	ret = 0;
+
+out:
+	vfree(container_data);
+	return ret;
+}
+
+static int fw_download_alloc(struct cc33xx *cc)
+{
+	if (WARN_ON(cc->fw_download))
+		return -EFAULT;
+
+	cc->fw_download = kzalloc(sizeof(*cc->fw_download), GFP_KERNEL);
+	if (!cc->fw_download)
+		return -ENOMEM;
+
+	init_completion(&cc->fw_download->wait_on_irq);
+
+	return 0;
+}
+
+static void fw_download_free(struct cc33xx *cc)
+{
+	if (WARN_ON(!cc->fw_download))
+		return;
+
+	kfree(cc->fw_download);
+	cc->fw_download = NULL;
+}
+
+static int get_device_info(struct cc33xx *cc)
+{
+	int ret;
+	union hw_info hw_info;
+	u64 mac_address;
+
+	ret = cmd_get_device_info(cc, hw_info.bytes, sizeof(hw_info.bytes));
+	if (ret < 0)
+		return ret;
+
+	cc33xx_debug(DEBUG_BOOT,
+		     "CC33XX device info: PG version: %d, Metal version: %d, Boot ROM version: %d, M3 ROM version: %d, MAC address: 0x%llx, Device part number: %d",
+		     hw_info.bitmap.pg_version, hw_info.bitmap.metal_version,
+		     hw_info.bitmap.boot_rom_version,
+		     hw_info.bitmap.m3_rom_version,
+		     (u64)hw_info.bitmap.mac_address,
+		     hw_info.bitmap.device_part_number);
+
+	cc->fw_download->max_transfer_size = 640;
+
+	mac_address = hw_info.bitmap.mac_address;
+
+	cc->fuse_rom_structure_version = hw_info.bitmap.fuse_rom_structure_version;
+	cc->pg_version = hw_info.bitmap.pg_version;
+	cc->device_part_number = hw_info.bitmap.device_part_number;
+	cc->disable_5g = hw_info.bitmap.disable_5g;
+	cc->disable_6g = hw_info.bitmap.disable_6g;
+
+	cc->efuse_mac_address[5] = (u8)(mac_address);
+	cc->efuse_mac_address[4] = (u8)(mac_address >> 8);
+	cc->efuse_mac_address[3] = (u8)(mac_address >> 16);
+	cc->efuse_mac_address[2] = (u8)(mac_address >> 24);
+	cc->efuse_mac_address[1] = (u8)(mac_address >> 32);
+	cc->efuse_mac_address[0] = (u8)(mac_address >> 40);
+
+	return 0;
+}
+
+int cc33xx_init_fw(struct cc33xx *cc)
+{
+	int ret;
+
+	cc->max_cmd_size = CC33XX_CMD_MAX_SIZE;
+
+	ret = fw_download_alloc(cc);
+	if (ret < 0)
+		return ret;
+
+	reinit_completion(&cc->fw_download->wait_on_irq);
+
+	ret = cc33xx_chip_wakeup(cc);
+	if (ret < 0)
+		goto power_off;
+
+	cc33xx_enable_interrupts(cc);
+
+	ret = wait_for_boot_irq(cc, HINT_ROM_LOADER_INIT_COMPLETE,
+				CC33XX_BOOT_TIMEOUT);
+	if (ret < 0)
+		goto disable_irq;
+
+	ret = get_device_info(cc);
+	if (ret < 0)
+		goto disable_irq;
+
+	ret = container_download_and_wait(cc, SECOND_LOADER_NAME,
+					  HINT_SECOND_LOADER_INIT_COMPLETE);
+	if (ret < 0)
+		goto disable_irq;
+
+	ret = container_download_and_wait(cc,  FW_NAME,
+					  HINT_FW_WAKEUP_COMPLETE);
+	if (ret < 0)
+		goto disable_irq;
+
+	ret = cc33xx_download_ini_params_and_wait(cc);
+
+	if (ret < 0)
+		goto disable_irq;
+
+	ret = wait_for_boot_irq(cc, HINT_FW_INIT_COMPLETE, CC33XX_BOOT_TIMEOUT);
+
+	if (ret < 0)
+		goto disable_irq;
+
+	ret = cc33xx_hw_init(cc);
+	if (ret < 0)
+		goto disable_irq;
+
+	/* Now we know if 11a is supported (info from the INI File), so disable
+	 * 11a channels if not supported
+	 */
+	cc->enable_11a = cc->conf.core.enable_5ghz;
+
+	cc33xx_debug(DEBUG_MAC80211, "11a is %ssupported",
+		     cc->enable_11a ? "" : "not ");
+
+	cc->state = CC33XX_STATE_ON;
+	ret = 0;
+	goto out;
+
+disable_irq:
+	cc33xx_disable_interrupts_nosync(cc);
+
+power_off:
+	cc33xx_power_off(cc);
+
+out:
+	fw_download_free(cc);
+	return ret;
+}
diff --git a/drivers/net/wireless/ti/cc33xx/boot.h b/drivers/net/wireless/ti/cc33xx/boot.h
new file mode 100644
index 000000000000..d5b7763dcd0f
--- /dev/null
+++ b/drivers/net/wireless/ti/cc33xx/boot.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0-only
+ *
+ * Copyright (C) 2022-2024 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+#ifndef __BOOT_H__
+#define __BOOT_H__
+
+#include "cc33xx.h"
+
+int cc33xx_init_fw(struct cc33xx *cc);
+
+void cc33xx_handle_boot_irqs(struct cc33xx *cc, u32 pending_interrupts);
+
+#define SECOND_LOADER_NAME "ti-connectivity/cc33xx_2nd_loader.bin"
+#define FW_NAME "ti-connectivity/cc33xx_fw.bin"
+
+struct cc33xx_fw_download {
+	atomic_t pending_irqs;
+	struct completion wait_on_irq;
+	size_t max_transfer_size;
+};
+
+#endif /* __BOOT_H__ */
-- 
2.34.1


