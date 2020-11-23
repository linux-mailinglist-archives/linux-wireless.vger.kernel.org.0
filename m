Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85D5E2C0C37
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Nov 2020 14:58:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730215AbgKWNwA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 Nov 2020 08:52:00 -0500
Received: from mga14.intel.com ([192.55.52.115]:1467 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729455AbgKWNwA (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 Nov 2020 08:52:00 -0500
IronPort-SDR: 8DGrpsG/NNWEvpaaFg4/0ZShseAGpkrhUvp+knltVkcIY55PUo7N50xeUtqX1J1ioG4QiXGX4X
 ovN/HKFqCSPw==
X-IronPort-AV: E=McAfee;i="6000,8403,9813"; a="170981420"
X-IronPort-AV: E=Sophos;i="5.78,363,1599548400"; 
   d="scan'208";a="170981420"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2020 05:51:57 -0800
IronPort-SDR: UQifH69zmVgoAk8Fcmsi27vDMYhwpRXueU0S2VFpig5KHoT4zJ7r+K4CHW4Ttqy8/0s11MkQuV
 T8hY1iOq+rig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,363,1599548400"; 
   d="scan'208";a="370035488"
Received: from bgsxx0031.iind.intel.com ([10.106.222.40])
  by orsmga007.jf.intel.com with ESMTP; 23 Nov 2020 05:51:55 -0800
From:   M Chetan Kumar <m.chetan.kumar@intel.com>
To:     netdev@vger.kernel.org, linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net, krishna.c.sudi@intel.com,
        m.chetan.kumar@intel.com
Subject: [RFC 03/18] net: iosm: mmio scratchpad
Date:   Mon, 23 Nov 2020 19:21:08 +0530
Message-Id: <20201123135123.48892-4-m.chetan.kumar@intel.com>
X-Mailer: git-send-email 2.12.3
In-Reply-To: <20201123135123.48892-1-m.chetan.kumar@intel.com>
References: <20201123135123.48892-1-m.chetan.kumar@intel.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

1) Initializes the Scratchpad region for Host-Device communication.
2) Exposes device capabilities like chip info and device execution
   stages.

Signed-off-by: M Chetan Kumar <m.chetan.kumar@intel.com>
---
 drivers/net/wwan/iosm/iosm_ipc_mmio.c | 222 ++++++++++++++++++++++++++++++++++
 drivers/net/wwan/iosm/iosm_ipc_mmio.h | 192 +++++++++++++++++++++++++++++
 2 files changed, 414 insertions(+)
 create mode 100644 drivers/net/wwan/iosm/iosm_ipc_mmio.c
 create mode 100644 drivers/net/wwan/iosm/iosm_ipc_mmio.h

diff --git a/drivers/net/wwan/iosm/iosm_ipc_mmio.c b/drivers/net/wwan/iosm/iosm_ipc_mmio.c
new file mode 100644
index 000000000000..eb685f6c720d
--- /dev/null
+++ b/drivers/net/wwan/iosm/iosm_ipc_mmio.c
@@ -0,0 +1,222 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2020 Intel Corporation.
+ */
+
+#include <linux/delay.h>
+#include <linux/io.h>
+#include <linux/slab.h>
+
+#include "iosm_ipc_mmio.h"
+#include "iosm_ipc_sio.h"
+
+/* Definition of MMIO offsets
+ * note that MMIO_CI offsets are relative to end of chip info structure
+ */
+
+/* MMIO chip info size in bytes */
+#define MMIO_CHIP_INFO_SIZE 60
+
+/* CP execution stage */
+#define MMIO_OFFSET_EXECUTION_STAGE 0x00
+
+/* Boot ROM Chip Info struct */
+#define MMIO_OFFSET_CHIP_INFO 0x04
+
+#define MMIO_OFFSET_ROM_EXIT_CODE 0x40
+
+#define MMIO_OFFSET_PSI_ADDRESS 0x54
+
+#define MMIO_OFFSET_PSI_SIZE 0x5C
+
+#define MMIO_OFFSET_IPC_STATUS 0x60
+
+#define MMIO_OFFSET_CONTEXT_INFO 0x64
+
+#define MMIO_OFFSET_BASE_ADDR 0x6C
+
+#define MMIO_OFFSET_END_ADDR 0x74
+
+#define MMIO_OFFSET_CP_VERSION 0xF0
+
+#define MMIO_OFFSET_CP_CAPABILITIES 0xF4
+
+/* Timeout in 20 msec to wait for the modem boot code to write a valid
+ * execution stage into mmio area
+ */
+#define IPC_MMIO_EXEC_STAGE_TIMEOUT 50
+
+/* check if exec stage has one of the valid values */
+static bool ipc_mmio_is_valid_exec_stage(enum ipc_mem_exec_stage stage)
+{
+	switch (stage) {
+	case IPC_MEM_EXEC_STAGE_BOOT:
+	case IPC_MEM_EXEC_STAGE_PSI:
+	case IPC_MEM_EXEC_STAGE_EBL:
+	case IPC_MEM_EXEC_STAGE_RUN:
+	case IPC_MEM_EXEC_STAGE_CRASH:
+	case IPC_MEM_EXEC_STAGE_CD_READY:
+		return true;
+	default:
+		return false;
+	}
+}
+
+void ipc_mmio_update_cp_capability(struct iosm_mmio *ipc_mmio)
+{
+	u32 cp_cap;
+	unsigned int ver;
+
+	ver = ipc_mmio_get_cp_version(ipc_mmio);
+	cp_cap = readl(ipc_mmio->base + ipc_mmio->offset.cp_capability);
+
+	ipc_mmio->has_mux_lite = (ver >= IOSM_CP_VERSION) &&
+				 !(cp_cap & DL_AGGR) && !(cp_cap & UL_AGGR);
+
+	ipc_mmio->has_ul_flow_credit =
+		(ver >= IOSM_CP_VERSION) && (cp_cap & UL_FLOW_CREDIT);
+}
+
+struct iosm_mmio *ipc_mmio_init(void __iomem *mmio, struct device *dev)
+{
+	struct iosm_mmio *ipc_mmio = kzalloc(sizeof(*ipc_mmio), GFP_KERNEL);
+	int retries = IPC_MMIO_EXEC_STAGE_TIMEOUT;
+	enum ipc_mem_exec_stage stage;
+
+	if (!ipc_mmio)
+		return NULL;
+
+	ipc_mmio->dev = dev;
+
+	ipc_mmio->base = mmio;
+
+	ipc_mmio->offset.exec_stage = MMIO_OFFSET_EXECUTION_STAGE;
+
+	/* Check for a valid execution stage to make sure that the boot code
+	 * has correctly initialized the MMIO area.
+	 */
+	do {
+		stage = ipc_mmio_get_exec_stage(ipc_mmio);
+		if (ipc_mmio_is_valid_exec_stage(stage))
+			break;
+
+		msleep(20);
+	} while (retries-- > 0);
+
+	if (!retries) {
+		dev_err(ipc_mmio->dev, "invalid exec stage %X", stage);
+		goto init_fail;
+	}
+
+	ipc_mmio->offset.chip_info = MMIO_OFFSET_CHIP_INFO;
+
+	/* read chip info size and version from chip info structure */
+	ipc_mmio->chip_info_version =
+		ioread8(ipc_mmio->base + ipc_mmio->offset.chip_info);
+
+	/* Increment of 2 is needed as the size value in the chip info
+	 * excludes the version and size field, which are always present
+	 */
+	ipc_mmio->chip_info_size =
+		ioread8(ipc_mmio->base + ipc_mmio->offset.chip_info + 1) + 2;
+
+	if (ipc_mmio->chip_info_size != MMIO_CHIP_INFO_SIZE) {
+		dev_err(ipc_mmio->dev, "Unexpected Chip Info");
+		goto init_fail;
+	}
+
+	ipc_mmio->offset.rom_exit_code = MMIO_OFFSET_ROM_EXIT_CODE;
+
+	ipc_mmio->offset.psi_address = MMIO_OFFSET_PSI_ADDRESS;
+	ipc_mmio->offset.psi_size = MMIO_OFFSET_PSI_SIZE;
+	ipc_mmio->offset.ipc_status = MMIO_OFFSET_IPC_STATUS;
+	ipc_mmio->offset.context_info = MMIO_OFFSET_CONTEXT_INFO;
+	ipc_mmio->offset.ap_win_base = MMIO_OFFSET_BASE_ADDR;
+	ipc_mmio->offset.ap_win_end = MMIO_OFFSET_END_ADDR;
+
+	ipc_mmio->offset.cp_version = MMIO_OFFSET_CP_VERSION;
+	ipc_mmio->offset.cp_capability = MMIO_OFFSET_CP_CAPABILITIES;
+
+	return ipc_mmio;
+
+init_fail:
+	kfree(ipc_mmio);
+	return NULL;
+}
+
+enum ipc_mem_exec_stage ipc_mmio_get_exec_stage(struct iosm_mmio *ipc_mmio)
+{
+	if (!ipc_mmio)
+		return IPC_MEM_EXEC_STAGE_INVALID;
+
+	return (enum ipc_mem_exec_stage)readl(ipc_mmio->base +
+					      ipc_mmio->offset.exec_stage);
+}
+
+void ipc_mmio_copy_chip_info(struct iosm_mmio *ipc_mmio, void *dest,
+			     size_t size)
+{
+	if (ipc_mmio && dest)
+		memcpy_fromio(dest, ipc_mmio->base + ipc_mmio->offset.chip_info,
+			      size);
+}
+
+enum ipc_mem_device_ipc_state ipc_mmio_get_ipc_state(struct iosm_mmio *ipc_mmio)
+{
+	if (!ipc_mmio)
+		return IPC_MEM_DEVICE_IPC_INVALID;
+
+	return (enum ipc_mem_device_ipc_state)
+		readl(ipc_mmio->base + ipc_mmio->offset.ipc_status);
+}
+
+enum rom_exit_code ipc_mmio_get_rom_exit_code(struct iosm_mmio *ipc_mmio)
+{
+	if (!ipc_mmio)
+		return IMEM_ROM_EXIT_FAIL;
+
+	return (enum rom_exit_code)readl(ipc_mmio->base +
+					 ipc_mmio->offset.rom_exit_code);
+}
+
+void ipc_mmio_config(struct iosm_mmio *ipc_mmio)
+{
+	if (!ipc_mmio)
+		return;
+
+	/* AP memory window (full window is open and active so that modem checks
+	 * each AP address) 0 means don't check on modem side.
+	 */
+	iowrite64_lo_hi(0, ipc_mmio->base + ipc_mmio->offset.ap_win_base);
+	iowrite64_lo_hi(0, ipc_mmio->base + ipc_mmio->offset.ap_win_end);
+
+	iowrite64_lo_hi(ipc_mmio->context_info_addr,
+			ipc_mmio->base + ipc_mmio->offset.context_info);
+}
+
+void ipc_mmio_set_psi_addr_and_size(struct iosm_mmio *ipc_mmio, dma_addr_t addr,
+				    u32 size)
+{
+	if (!ipc_mmio)
+		return;
+
+	iowrite64_lo_hi(addr, ipc_mmio->base + ipc_mmio->offset.psi_address);
+	writel(size, ipc_mmio->base + ipc_mmio->offset.psi_size);
+}
+
+void ipc_mmio_set_contex_info_addr(struct iosm_mmio *ipc_mmio, phys_addr_t addr)
+{
+	if (!ipc_mmio)
+		return;
+
+	/* store context_info address. This will be stored in the mmio area
+	 * during IPC_MEM_DEVICE_IPC_INIT state via ipc_mmio_config()
+	 */
+	ipc_mmio->context_info_addr = addr;
+}
+
+int ipc_mmio_get_cp_version(struct iosm_mmio *ipc_mmio)
+{
+	return ipc_mmio ? readl(ipc_mmio->base + ipc_mmio->offset.cp_version) :
+			  -1;
+}
diff --git a/drivers/net/wwan/iosm/iosm_ipc_mmio.h b/drivers/net/wwan/iosm/iosm_ipc_mmio.h
new file mode 100644
index 000000000000..bbd6bd8383b5
--- /dev/null
+++ b/drivers/net/wwan/iosm/iosm_ipc_mmio.h
@@ -0,0 +1,192 @@
+/* SPDX-License-Identifier: GPL-2.0-only
+ *
+ * Copyright (C) 2020 Intel Corporation.
+ */
+
+#ifndef IOSM_IPC_MMIO_H
+#define IOSM_IPC_MMIO_H
+
+/* Minimal IOSM CP VERSION which has valid CP_CAPABILITIES field */
+#define IOSM_CP_VERSION 0x0100UL
+
+/* DL dir Aggregation support mask */
+#define DL_AGGR BIT(23)
+
+/* UL dir Aggregation support mask */
+#define UL_AGGR BIT(22)
+
+/* UL flow credit support mask */
+#define UL_FLOW_CREDIT BIT(21)
+
+/* Possible states of the IPC finite state machine. */
+enum ipc_mem_device_ipc_state {
+	IPC_MEM_DEVICE_IPC_UNINIT,
+	IPC_MEM_DEVICE_IPC_INIT,
+	IPC_MEM_DEVICE_IPC_RUNNING,
+	IPC_MEM_DEVICE_IPC_RECOVERY,
+	IPC_MEM_DEVICE_IPC_ERROR,
+	IPC_MEM_DEVICE_IPC_DONT_CARE,
+	IPC_MEM_DEVICE_IPC_INVALID = -1
+};
+
+/* Boot ROM exit status. */
+enum rom_exit_code {
+	IMEM_ROM_EXIT_OPEN_EXT = 0x01,
+	IMEM_ROM_EXIT_OPEN_MEM = 0x02,
+	IMEM_ROM_EXIT_CERT_EXT = 0x10,
+	IMEM_ROM_EXIT_CERT_MEM = 0x20,
+	IMEM_ROM_EXIT_FAIL = 0xFF
+};
+
+/* Boot stages */
+enum ipc_mem_exec_stage {
+	IPC_MEM_EXEC_STAGE_RUN = 0x600DF00D,
+	IPC_MEM_EXEC_STAGE_CRASH = 0x8BADF00D,
+	IPC_MEM_EXEC_STAGE_CD_READY = 0xBADC0DED,
+	IPC_MEM_EXEC_STAGE_BOOT = 0xFEEDB007,
+	IPC_MEM_EXEC_STAGE_PSI = 0xFEEDBEEF,
+	IPC_MEM_EXEC_STAGE_EBL = 0xFEEDCAFE,
+	IPC_MEM_EXEC_STAGE_INVALID = 0xFFFFFFFF,
+};
+
+struct mmio_offset {
+	int exec_stage;
+	int chip_info;
+	int rom_exit_code;
+	int psi_address;
+	int psi_size;
+	int ipc_status;
+	int context_info;
+	int ap_win_base;
+	int ap_win_end;
+	int cp_version;
+	int cp_capability;
+};
+
+/**
+ * struct iosm_mmio - MMIO region mapped to the doorbell scratchpad.
+ * @base:		Base address of MMIO region
+ * @dev:		Pointer to device structure
+ * @offset:		Start offset
+ * @context_info_addr:	Physical base address of context info structure
+ * @chip_info_version:	Version of chip info structure
+ * @chip_info_size:	Size of chip info structure
+ * @has_mux_lite:	It doesn't support mux aggergation
+ * @has_ul_flow_credit:	Ul flow credit support
+ * @has_slp_no_prot:	Device sleep no protocol support
+ * @has_mcr_support:	Usage of mcr support
+ */
+struct iosm_mmio {
+	unsigned char __iomem *base;
+	struct device *dev;
+	struct mmio_offset offset;
+	phys_addr_t context_info_addr;
+	unsigned int chip_info_version;
+	unsigned int chip_info_size;
+	u8 has_mux_lite : 1;
+	u8 has_ul_flow_credit : 1;
+	u8 has_slp_no_prot : 1;
+	u8 has_mcr_support : 1;
+};
+
+/**
+ * ipc_mmio_init - Allocate mmio instance data
+ * @mmio_addr:	Mapped AP base address of the MMIO area.
+ * @dev:	Pointer to device structure
+ *
+ * Returns: address of mmio instance data
+ */
+struct iosm_mmio *ipc_mmio_init(void __iomem *mmio_addr, struct device *dev);
+
+/**
+ * ipc_mmio_set_psi_addr_and_size - Set start address and size of the
+ *				    primary system image (PSI) for the
+ *				    boot rom dowload app.
+ * @ipc_mmio:	Pointer to mmio instance
+ * @addr:	PSI address
+ * @size:	PSI immage size
+ */
+void ipc_mmio_set_psi_addr_and_size(struct iosm_mmio *ipc_mmio, dma_addr_t addr,
+				    u32 size);
+
+/**
+ * ipc_mmio_set_contex_info_addr - Stores the Context Info Address in
+ *				   MMIO instance to share it with CP during
+ *				   mmio_init.
+ * @ipc_mmio:	Pointer to mmio instance
+ * @addr:	64-bit address of AP context information.
+ */
+void ipc_mmio_set_contex_info_addr(struct iosm_mmio *ipc_mmio,
+				   phys_addr_t addr);
+
+/**
+ * ipc_mmio_get_cp_version - Write context info and AP memory range addresses.
+ *			     This needs to be called when CP is in
+ *			     IPC_MEM_DEVICE_IPC_INIT state
+ * @ipc_mmio:	Pointer to mmio instance
+ *
+ * Returns: cp version else -1
+ */
+int ipc_mmio_get_cp_version(struct iosm_mmio *ipc_mmio);
+
+/**
+ * ipc_mmio_get_cp_version - Get the CP IPC version
+ * @ipc_mmio:	Pointer to mmio instance
+ *
+ * Returns: version number on success and -1 on failure.
+ */
+int ipc_mmio_get_cp_version(struct iosm_mmio *ipc_mmio);
+
+/**
+ * ipc_mmio_get_rom_exit_code - Get exit code from CP boot rom download app
+ * @ipc_mmio:	Pointer to mmio instance
+ *
+ * Returns: exit code from CP boot rom download APP
+ */
+enum rom_exit_code ipc_mmio_get_rom_exit_code(struct iosm_mmio *ipc_mmio);
+
+/**
+ * ipc_mmio_get_exec_stage - Query CP execution stage
+ * @ipc_mmio:	Pointer to mmio instance
+ *
+ * Returns: CP execution stage
+ */
+enum ipc_mem_exec_stage ipc_mmio_get_exec_stage(struct iosm_mmio *ipc_mmio);
+
+/**
+ * ipc_mmio_get_ipc_state - Query CP IPC state
+ * @ipc_mmio:	Pointer to mmio instance
+ *
+ * Returns: CP IPC state
+ */
+enum ipc_mem_device_ipc_state
+ipc_mmio_get_ipc_state(struct iosm_mmio *ipc_mmio);
+
+/**
+ * ipc_mmio_copy_chip_info - Copy size bytes of CP chip info structure
+ *			     into caller provided buffer
+ * @ipc_mmio:	Pointer to mmio instance
+ * @dest:	Pointer to caller provided buff
+ * @size:	Number of bytes to copy
+ */
+void ipc_mmio_copy_chip_info(struct iosm_mmio *ipc_mmio, void *dest,
+			     size_t size);
+
+/**
+ * ipc_mmio_config - Write context info and AP memory range addresses.
+ *		     This needs to be called when CP is in
+ *		     IPC_MEM_DEVICE_IPC_INIT state
+ *
+ * @ipc_mmio:	Pointer to mmio instance
+ */
+void ipc_mmio_config(struct iosm_mmio *ipc_mmio);
+
+/**
+ * ipc_mmio_update_cp_capability - Read and update modem capability, from mmio
+ *				   capability offset
+ *
+ * @ipc_mmio:	Pointer to mmio instance
+ */
+void ipc_mmio_update_cp_capability(struct iosm_mmio *ipc_mmio);
+
+#endif
-- 
2.12.3

