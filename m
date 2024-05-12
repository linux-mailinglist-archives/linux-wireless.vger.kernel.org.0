Return-Path: <linux-wireless+bounces-7555-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF058C37EC
	for <lists+linux-wireless@lfdr.de>; Sun, 12 May 2024 20:34:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20561B20CC9
	for <lists+linux-wireless@lfdr.de>; Sun, 12 May 2024 18:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 511B45028A;
	Sun, 12 May 2024 18:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="uCBDgrsL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764DF2D04E
	for <linux-wireless@vger.kernel.org>; Sun, 12 May 2024 18:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715538829; cv=none; b=fjmp5AKxpASq/t5qxZvQN7r0ZAlZSOS6O9lfDHifquoF87NPIatSeng3xlvXJCziV51y8T1jlP++4976GbrltFF2WBPCr86Kms8ffJVUlW1CxhJVs+stqNatxmKOOcw8SlO7tihoUyDiG3+TF7NJetU64i5hq0vVHkT47vVhdrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715538829; c=relaxed/simple;
	bh=nAwzhHKJlh8QoxhrrOjpOGMZHimc/czcIzpGuF9A/fM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sWEGjzdvRfE3DTKSDGzeGtROHTkW09TlJcGOcPSRdljuJtoxO0lz4vS2AQ9OJNJo/asPJt61Zr7qR85DPXg3AuX3rPOMtE7oVEWUoqrAnAQWfRiV458RrnSCd5XX+uavv2bU45utwUrkm4SfUieXLOB/qkmljP4gUPxZWqeNu5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=uCBDgrsL; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44CIXitR114066;
	Sun, 12 May 2024 13:33:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1715538824;
	bh=CxNSd0s6R4HuNr67z2L7Cr4w1fl/Re0skumEK8D5Nic=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=uCBDgrsLuQqlka2kenR9dfiHXwkZ4tuGWav52WEhtaa0L1yinSOJh+pEz5n5DIfeX
	 hEP5RV0/GyKD4y8BWHMcoAYTJM6+a4h+kEw78xkMOwYsSvrNzQWKJaq1pA/VXGUsYK
	 cnhuulRiqwBvGR9mGQABuSceuna896B36E8Ic9u4=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44CIXihl013790
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 12 May 2024 13:33:44 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 12
 May 2024 13:33:43 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 12 May 2024 13:33:43 -0500
Received: from localhost (uda0389739.dhcp.ti.com [137.167.1.114])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44CIXgPl074621;
	Sun, 12 May 2024 13:33:43 -0500
From: <michael.nemanov@ti.com>
To: <kvalo@kernel.org>, <linux-wireless@vger.kernel.org>
CC: <sabeeh-khan@ti.com>, Michael Nemanov <Michael.Nemanov@ti.com>,
        Michael
 Nemanov <michael.nemanov@ti.com>
Subject: [RFC PATCH 07/17] Add boot.c, boot.h
Date: Sun, 12 May 2024 21:32:37 +0300
Message-ID: <20240512183247.2190242-8-michael.nemanov@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240512183247.2190242-1-michael.nemanov@ti.com>
References: <20240512183247.2190242-1-michael.nemanov@ti.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

From: Michael Nemanov <Michael.Nemanov@ti.com>

Implements FW download for CC33xx. The FW comes in 2 parts - a 2nd stage
bootloader (cc33xx_2nd_loader.bin) and the actual FW (cc33xx_fw.bin).
Each file is requested from user space, and transferred to device
chunk by chunk. A dedicated IRQ is excepted after each stage
(Device power-on -> 2nd stage loader -> FW). This logic is implemnted in
cc33xx_init_fw.

Signed-off-by: Michael Nemanov <michael.nemanov@ti.com>
---
 drivers/net/wireless/ti/cc33xx/boot.c | 362 ++++++++++++++++++++++++++
 drivers/net/wireless/ti/cc33xx/boot.h |  23 ++
 2 files changed, 385 insertions(+)
 create mode 100644 drivers/net/wireless/ti/cc33xx/boot.c
 create mode 100644 drivers/net/wireless/ti/cc33xx/boot.h

diff --git a/drivers/net/wireless/ti/cc33xx/boot.c b/drivers/net/wireless/ti/cc33xx/boot.c
new file mode 100644
index 000000000000..7fcb97ed95e6
--- /dev/null
+++ b/drivers/net/wireless/ti/cc33xx/boot.c
@@ -0,0 +1,362 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/* Copyright (C) 2022-2024 Texas Instruments Inc.*/
+
+#include <linux/firmware.h>
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
+	int ret;
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
+	cc33xx_debug(DEBUG_BOOT,
+		     "Downloading %s to device", container_name);
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
index 000000000000..116d7bbab5f6
--- /dev/null
+++ b/drivers/net/wireless/ti/cc33xx/boot.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+/* Copyright (C) 2022-2024 Texas Instruments Inc.*/
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
2.25.1


