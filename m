Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B36C8365CF8
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Apr 2021 18:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233089AbhDTQOw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Apr 2021 12:14:52 -0400
Received: from mga05.intel.com ([192.55.52.43]:42670 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233029AbhDTQOv (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Apr 2021 12:14:51 -0400
IronPort-SDR: rtLygMcZzPh6R7wPI9FiDs/Bte7wPjWJUPxCG93yYMZW0t+xaXHsjhc0N4q1jXBXpNo3kuH+kW
 0q90S6vt2wOQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9960"; a="280865892"
X-IronPort-AV: E=Sophos;i="5.82,237,1613462400"; 
   d="scan'208";a="280865892"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2021 09:14:20 -0700
IronPort-SDR: CcNWYsPYVQfFbkVjZICObBk5TaRxZVYugKKvQkzHGbcEaAO5+5ph0w+kUxGznlVGEmFqyx/Y9F
 gKXQRUNg+ulQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,237,1613462400"; 
   d="scan'208";a="454882790"
Received: from bgsxx0031.iind.intel.com ([10.106.222.40])
  by fmsmga002.fm.intel.com with ESMTP; 20 Apr 2021 09:14:18 -0700
From:   M Chetan Kumar <m.chetan.kumar@intel.com>
To:     netdev@vger.kernel.org, linux-wireless@vger.kernel.org
Cc:     johannes@sipsolutions.net, krishna.c.sudi@intel.com,
        linuxwwan@intel.com
Subject: [PATCH V2 01/16] net: iosm: entry point
Date:   Tue, 20 Apr 2021 21:42:55 +0530
Message-Id: <20210420161310.16189-2-m.chetan.kumar@intel.com>
X-Mailer: git-send-email 2.12.3
In-Reply-To: <20210420161310.16189-1-m.chetan.kumar@intel.com>
References: <20210420161310.16189-1-m.chetan.kumar@intel.com>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

1) Register IOSM driver with kernel to manage Intel WWAN PCIe
   device(PCI_VENDOR_ID_INTEL, INTEL_CP_DEVICE_7560_ID).
2) Exposes the EP PCIe device capability to Host PCIe core.
3) Initializes PCIe EP configuration and defines PCIe driver probe, remove
   and power management OPS.
4) Allocate and map(dma) skb memory for data communication from device to
   kernel and vice versa.

Signed-off-by: M Chetan Kumar <m.chetan.kumar@intel.com>
---
v2:
* Implement module_init() & exit() callbacks for rtnl_link.
* Documentation correction for function signature.
* Fix coverity warnings.
---
 drivers/net/wwan/iosm/iosm_ipc_pcie.c | 588 ++++++++++++++++++++++++++
 drivers/net/wwan/iosm/iosm_ipc_pcie.h | 211 +++++++++
 2 files changed, 799 insertions(+)
 create mode 100644 drivers/net/wwan/iosm/iosm_ipc_pcie.c
 create mode 100644 drivers/net/wwan/iosm/iosm_ipc_pcie.h

diff --git a/drivers/net/wwan/iosm/iosm_ipc_pcie.c b/drivers/net/wwan/iosm/iosm_ipc_pcie.c
new file mode 100644
index 000000000000..8a3a8cd68a6a
--- /dev/null
+++ b/drivers/net/wwan/iosm/iosm_ipc_pcie.c
@@ -0,0 +1,588 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2020-21 Intel Corporation.
+ */
+
+#include <linux/acpi.h>
+#include <linux/bitfield.h>
+#include <linux/module.h>
+#include <net/rtnetlink.h>
+
+#include "iosm_ipc_imem.h"
+#include "iosm_ipc_pcie.h"
+#include "iosm_ipc_protocol.h"
+
+#define DRV_AUTHOR "Intel Corporation <linuxwwan@intel.com>"
+
+MODULE_AUTHOR(DRV_AUTHOR);
+MODULE_DESCRIPTION("IOSM Driver");
+MODULE_LICENSE("GPL v2");
+
+/* WWAN GUID */
+static guid_t wwan_acpi_guid = GUID_INIT(0xbad01b75, 0x22a8, 0x4f48, 0x87, 0x92,
+				       0xbd, 0xde, 0x94, 0x67, 0x74, 0x7d);
+
+static void ipc_pcie_resources_release(struct iosm_pcie *ipc_pcie)
+{
+	/* Free the MSI resources. */
+	ipc_release_irq(ipc_pcie);
+
+	/* Free mapped doorbell scratchpad bus memory into CPU space. */
+	iounmap(ipc_pcie->scratchpad);
+
+	/* Free mapped IPC_REGS bus memory into CPU space. */
+	iounmap(ipc_pcie->ipc_regs);
+
+	/* Releases all PCI I/O and memory resources previously reserved by a
+	 * successful call to pci_request_regions.  Call this function only
+	 * after all use of the PCI regions has ceased.
+	 */
+	pci_release_regions(ipc_pcie->pci);
+}
+
+static void ipc_cleanup(struct iosm_pcie *ipc_pcie)
+{
+	/* Free the shared memory resources. */
+	ipc_imem_cleanup(ipc_pcie->imem);
+
+	ipc_pcie_resources_release(ipc_pcie);
+
+	/* Signal to the system that the PCI device is not in use. */
+	pci_disable_device(ipc_pcie->pci);
+}
+
+static void ipc_pcie_deinit(struct iosm_pcie *ipc_pcie)
+{
+	kfree(ipc_pcie->imem);
+	kfree(ipc_pcie);
+}
+
+static void iosm_ipc_remove(struct pci_dev *pci)
+{
+	struct iosm_pcie *ipc_pcie = pci_get_drvdata(pci);
+
+	ipc_cleanup(ipc_pcie);
+
+	ipc_pcie_deinit(ipc_pcie);
+}
+
+static int ipc_pcie_resources_request(struct iosm_pcie *ipc_pcie)
+{
+	struct pci_dev *pci = ipc_pcie->pci;
+	u32 cap = 0;
+	u32 ret;
+
+	/* Reserved PCI I/O and memory resources.
+	 * Mark all PCI regions associated with PCI device pci as
+	 * being reserved by owner IOSM_IPC.
+	 */
+	ret = pci_request_regions(pci, "IOSM_IPC");
+	if (ret) {
+		dev_err(ipc_pcie->dev, "failed pci request regions");
+		goto pci_request_region_fail;
+	}
+
+	/* Reserve the doorbell IPC REGS memory resources.
+	 * Remap the memory into CPU space. Arrange for the physical address
+	 * (BAR) to be visible from this driver.
+	 * pci_ioremap_bar() ensures that the memory is marked uncachable.
+	 */
+	ipc_pcie->ipc_regs = pci_ioremap_bar(pci, ipc_pcie->ipc_regs_bar_nr);
+
+	if (!ipc_pcie->ipc_regs) {
+		dev_err(ipc_pcie->dev, "IPC REGS ioremap error");
+		ret = -EBUSY;
+		goto ipc_regs_remap_fail;
+	}
+
+	/* Reserve the MMIO scratchpad memory resources.
+	 * Remap the memory into CPU space. Arrange for the physical address
+	 * (BAR) to be visible from this driver.
+	 * pci_ioremap_bar() ensures that the memory is marked uncachable.
+	 */
+	ipc_pcie->scratchpad =
+		pci_ioremap_bar(pci, ipc_pcie->scratchpad_bar_nr);
+
+	if (!ipc_pcie->scratchpad) {
+		dev_err(ipc_pcie->dev, "doorbell scratchpad ioremap error");
+		ret = -EBUSY;
+		goto scratch_remap_fail;
+	}
+
+	/* Install the irq handler triggered by CP. */
+	ret = ipc_acquire_irq(ipc_pcie);
+	if (ret) {
+		dev_err(ipc_pcie->dev, "acquiring MSI irq failed!");
+		goto irq_acquire_fail;
+	}
+
+	/* Enable bus-mastering for the IOSM IPC device. */
+	pci_set_master(pci);
+
+	/* Enable LTR if possible
+	 * This is needed for L1.2!
+	 */
+	pcie_capability_read_dword(ipc_pcie->pci, PCI_EXP_DEVCAP2, &cap);
+	if (cap & PCI_EXP_DEVCAP2_LTR)
+		pcie_capability_set_word(ipc_pcie->pci, PCI_EXP_DEVCTL2,
+					 PCI_EXP_DEVCTL2_LTR_EN);
+
+	dev_dbg(ipc_pcie->dev, "link between AP and CP is fully on");
+
+	return ret;
+
+irq_acquire_fail:
+	iounmap(ipc_pcie->scratchpad);
+scratch_remap_fail:
+	iounmap(ipc_pcie->ipc_regs);
+ipc_regs_remap_fail:
+	pci_release_regions(pci);
+pci_request_region_fail:
+	return ret;
+}
+
+bool ipc_pcie_check_aspm_enabled(struct iosm_pcie *ipc_pcie,
+				 bool parent)
+{
+	struct pci_dev *pdev;
+	u16 value = 0;
+	u32 enabled;
+
+	if (parent)
+		pdev = ipc_pcie->pci->bus->self;
+	else
+		pdev = ipc_pcie->pci;
+
+	pcie_capability_read_word(pdev, PCI_EXP_LNKCTL, &value);
+	enabled = value & PCI_EXP_LNKCTL_ASPMC;
+	dev_dbg(ipc_pcie->dev, "ASPM L1: 0x%04X 0x%03X", pdev->device, value);
+
+	return (enabled == PCI_EXP_LNKCTL_ASPM_L1 ||
+		enabled == PCI_EXP_LNKCTL_ASPMC);
+}
+
+bool ipc_pcie_check_data_link_active(struct iosm_pcie *ipc_pcie)
+{
+	struct pci_dev *parent;
+	u16 link_status = 0;
+
+	if (!ipc_pcie->pci->bus || !ipc_pcie->pci->bus->self) {
+		dev_err(ipc_pcie->dev, "root port not found");
+		return false;
+	}
+
+	parent = ipc_pcie->pci->bus->self;
+
+	pcie_capability_read_word(parent, PCI_EXP_LNKSTA, &link_status);
+	dev_dbg(ipc_pcie->dev, "Link status: 0x%04X", link_status);
+
+	return link_status & PCI_EXP_LNKSTA_DLLLA;
+}
+
+static bool ipc_pcie_check_aspm_supported(struct iosm_pcie *ipc_pcie,
+					  bool parent)
+{
+	struct pci_dev *pdev;
+	u32 support;
+	u32 cap = 0;
+
+	if (parent)
+		pdev = ipc_pcie->pci->bus->self;
+	else
+		pdev = ipc_pcie->pci;
+	pcie_capability_read_dword(pdev, PCI_EXP_LNKCAP, &cap);
+	support = u32_get_bits(cap, PCI_EXP_LNKCAP_ASPMS);
+	if (support < PCI_EXP_LNKCTL_ASPM_L1) {
+		dev_dbg(ipc_pcie->dev, "ASPM L1 not supported: 0x%04X",
+			pdev->device);
+		return false;
+	}
+	return true;
+}
+
+void ipc_pcie_config_aspm(struct iosm_pcie *ipc_pcie)
+{
+	bool parent_aspm_enabled, dev_aspm_enabled;
+
+	/* check if both root port and child supports ASPM L1 */
+	if (!ipc_pcie_check_aspm_supported(ipc_pcie, true) ||
+	    !ipc_pcie_check_aspm_supported(ipc_pcie, false))
+		return;
+
+	parent_aspm_enabled = ipc_pcie_check_aspm_enabled(ipc_pcie, true);
+	dev_aspm_enabled = ipc_pcie_check_aspm_enabled(ipc_pcie, false);
+
+	dev_dbg(ipc_pcie->dev, "ASPM parent: %s device: %s",
+		parent_aspm_enabled ? "Enabled" : "Disabled",
+		dev_aspm_enabled ? "Enabled" : "Disabled");
+}
+
+/* Initializes PCIe endpoint configuration */
+static void ipc_pcie_config_init(struct iosm_pcie *ipc_pcie)
+{
+	/* BAR0 is used for doorbell */
+	ipc_pcie->ipc_regs_bar_nr = IPC_DOORBELL_BAR0;
+
+	/* update HW configuration */
+	ipc_pcie->scratchpad_bar_nr = IPC_SCRATCHPAD_BAR2;
+	ipc_pcie->doorbell_reg_offset = IPC_DOORBELL_CH_OFFSET;
+	ipc_pcie->doorbell_write = IPC_WRITE_PTR_REG_0;
+	ipc_pcie->doorbell_capture = IPC_CAPTURE_PTR_REG_0;
+}
+
+/* This will read the BIOS WWAN RTD3 settings:
+ * D0L1.2/D3L2/Disabled
+ */
+static enum ipc_pcie_sleep_state imc_ipc_read_bios_cfg(struct device *dev)
+{
+	union acpi_object *object;
+	acpi_handle handle_acpi;
+
+	handle_acpi = ACPI_HANDLE(dev);
+	if (!handle_acpi) {
+		pr_debug("pci device is NOT ACPI supporting device\n");
+		goto default_ret;
+	}
+
+	object = acpi_evaluate_dsm(handle_acpi, &wwan_acpi_guid, 0, 3, NULL);
+
+	if (object && object->integer.value == 3)
+		return IPC_PCIE_D3L2;
+
+default_ret:
+	return IPC_PCIE_D0L12;
+}
+
+static int iosm_ipc_probe(struct pci_dev *pci,
+			  const struct pci_device_id *pci_id)
+{
+	struct iosm_pcie *ipc_pcie = kzalloc(sizeof(*ipc_pcie), GFP_KERNEL);
+
+	pr_debug("Probing device 0x%X from the vendor 0x%X", pci_id->device,
+		 pci_id->vendor);
+
+	if (!ipc_pcie)
+		goto ret_fail;
+
+	/* Initialize ipc dbg component for the PCIe device */
+	ipc_pcie->dev = &pci->dev;
+
+	/* Set the driver specific data. */
+	pci_set_drvdata(pci, ipc_pcie);
+
+	/* Save the address of the PCI device configuration. */
+	ipc_pcie->pci = pci;
+
+	/* Update platform configuration */
+	ipc_pcie_config_init(ipc_pcie);
+
+	/* Initialize the device before it is used. Ask low-level code
+	 * to enable I/O and memory. Wake up the device if it was suspended.
+	 */
+	if (pci_enable_device(pci)) {
+		dev_err(ipc_pcie->dev, "failed to enable the AP PCIe device");
+		/* If enable of PCIe device has failed then calling ipc_cleanup
+		 * will panic the system. More over ipc_cleanup() is required to
+		 * be called after ipc_imem_mount()
+		 */
+		goto pci_enable_fail;
+	}
+
+	ipc_pcie_config_aspm(ipc_pcie);
+	dev_dbg(ipc_pcie->dev, "PCIe device enabled.");
+
+	/* Read WWAN RTD3 BIOS Setting
+	 */
+	ipc_pcie->d3l2_support = imc_ipc_read_bios_cfg(&pci->dev);
+
+	ipc_pcie->suspend = 0;
+
+	if (ipc_pcie_resources_request(ipc_pcie))
+		goto resources_req_fail;
+
+	/* Establish the link to the imem layer. */
+	ipc_pcie->imem = ipc_imem_init(ipc_pcie, pci->device,
+				       ipc_pcie->scratchpad, ipc_pcie->dev);
+	if (!ipc_pcie->imem) {
+		dev_err(ipc_pcie->dev, "failed to init imem");
+		goto imem_init_fail;
+	}
+
+	return 0;
+
+imem_init_fail:
+	ipc_pcie_resources_release(ipc_pcie);
+resources_req_fail:
+	pci_disable_device(pci);
+pci_enable_fail:
+	kfree(ipc_pcie);
+ret_fail:
+	return -EIO;
+}
+
+static const struct pci_device_id iosm_ipc_ids[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, INTEL_CP_DEVICE_7560_ID) },
+	{}
+};
+
+/* Enter sleep in s2idle case
+ */
+static int __maybe_unused iosm_ipc_suspend_s2idle(struct iosm_pcie *ipc_pcie)
+{
+	ipc_cp_irq_sleep_control(ipc_pcie, IPC_MEM_DEV_PM_FORCE_SLEEP);
+
+	/* Complete all memory stores before setting bit */
+	smp_mb__before_atomic();
+
+	set_bit(0, &ipc_pcie->suspend);
+
+	/* Complete all memory stores after setting bit */
+	smp_mb__after_atomic();
+
+	ipc_imem_pm_s2idle_sleep(ipc_pcie->imem, true);
+
+	return 0;
+}
+
+/* Resume from sleep in s2idle case
+ */
+static int __maybe_unused iosm_ipc_resume_s2idle(struct iosm_pcie *ipc_pcie)
+{
+	ipc_cp_irq_sleep_control(ipc_pcie, IPC_MEM_DEV_PM_FORCE_ACTIVE);
+
+	ipc_imem_pm_s2idle_sleep(ipc_pcie->imem, false);
+
+	/* Complete all memory stores before clearing bit. */
+	smp_mb__before_atomic();
+
+	clear_bit(0, &ipc_pcie->suspend);
+
+	/* Complete all memory stores after clearing bit. */
+	smp_mb__after_atomic();
+	return 0;
+}
+
+int __maybe_unused iosm_ipc_suspend(struct iosm_pcie *ipc_pcie)
+{
+	struct pci_dev *pdev;
+	int ret;
+
+	pdev = ipc_pcie->pci;
+
+	/* Execute D3 one time. */
+	if (pdev->current_state != PCI_D0) {
+		dev_dbg(ipc_pcie->dev, "done for PM=%d", pdev->current_state);
+		return 0;
+	}
+
+	/* The HAL shall ask the shared memory layer whether D3 is allowed. */
+	ipc_imem_pm_suspend(ipc_pcie->imem);
+
+	/* Save the PCI configuration space of a device before suspending. */
+	ret = pci_save_state(pdev);
+
+	if (ret) {
+		dev_err(ipc_pcie->dev, "pci_save_state error=%d", ret);
+		return ret;
+	}
+
+	/* Set the power state of a PCI device.
+	 * Transition a device to a new power state, using the device's PCI PM
+	 * registers.
+	 */
+	ret = pci_set_power_state(pdev, PCI_D3cold);
+
+	if (ret) {
+		dev_err(ipc_pcie->dev, "pci_set_power_state error=%d", ret);
+		return ret;
+	}
+
+	dev_dbg(ipc_pcie->dev, "SUSPEND done");
+	return ret;
+}
+
+int __maybe_unused iosm_ipc_resume(struct iosm_pcie *ipc_pcie)
+{
+	int ret;
+
+	/* Set the power state of a PCI device.
+	 * Transition a device to a new power state, using the device's PCI PM
+	 * registers.
+	 */
+	ret = pci_set_power_state(ipc_pcie->pci, PCI_D0);
+
+	if (ret) {
+		dev_err(ipc_pcie->dev, "pci_set_power_state error=%d", ret);
+		return ret;
+	}
+
+	pci_restore_state(ipc_pcie->pci);
+
+	/* The HAL shall inform the shared memory layer that the device is
+	 * active.
+	 */
+	ipc_imem_pm_resume(ipc_pcie->imem);
+
+	dev_dbg(ipc_pcie->dev, "RESUME done");
+	return ret;
+}
+
+static int __maybe_unused iosm_ipc_suspend_cb(struct device *dev)
+{
+	struct iosm_pcie *ipc_pcie;
+	struct pci_dev *pdev;
+
+	pdev = to_pci_dev(dev);
+
+	ipc_pcie = pci_get_drvdata(pdev);
+
+	switch (ipc_pcie->d3l2_support) {
+	case IPC_PCIE_D0L12:
+		iosm_ipc_suspend_s2idle(ipc_pcie);
+		break;
+	case IPC_PCIE_D3L2:
+		iosm_ipc_suspend(ipc_pcie);
+		break;
+	}
+
+	return 0;
+}
+
+static int __maybe_unused iosm_ipc_resume_cb(struct device *dev)
+{
+	struct iosm_pcie *ipc_pcie;
+	struct pci_dev *pdev;
+
+	pdev = to_pci_dev(dev);
+
+	ipc_pcie = pci_get_drvdata(pdev);
+
+	switch (ipc_pcie->d3l2_support) {
+	case IPC_PCIE_D0L12:
+		iosm_ipc_resume_s2idle(ipc_pcie);
+		break;
+	case IPC_PCIE_D3L2:
+		iosm_ipc_resume(ipc_pcie);
+		break;
+	}
+
+	return 0;
+}
+
+static SIMPLE_DEV_PM_OPS(iosm_ipc_pm, iosm_ipc_suspend_cb, iosm_ipc_resume_cb);
+
+static struct pci_driver iosm_ipc_driver = {
+	.name = KBUILD_MODNAME,
+	.probe = iosm_ipc_probe,
+	.remove = iosm_ipc_remove,
+	.driver = {
+		.pm = &iosm_ipc_pm,
+	},
+	.id_table = iosm_ipc_ids,
+};
+
+int ipc_pcie_addr_map(struct iosm_pcie *ipc_pcie, unsigned char *data, size_t size,
+		      dma_addr_t *mapping, int direction)
+{
+	if (ipc_pcie->pci) {
+		*mapping = dma_map_single(&ipc_pcie->pci->dev, data, size,
+					  direction);
+		if (dma_mapping_error(&ipc_pcie->pci->dev, *mapping)) {
+			dev_err(ipc_pcie->dev, "dma mapping failed");
+			return -EINVAL;
+		}
+	}
+	return 0;
+}
+
+void ipc_pcie_addr_unmap(struct iosm_pcie *ipc_pcie, size_t size,
+			 dma_addr_t mapping, int direction)
+{
+	if (!mapping)
+		return;
+	if (ipc_pcie->pci)
+		dma_unmap_single(&ipc_pcie->pci->dev, mapping, size, direction);
+}
+
+struct sk_buff *ipc_pcie_alloc_local_skb(struct iosm_pcie *ipc_pcie,
+					 gfp_t flags, size_t size)
+{
+	struct sk_buff *skb;
+
+	if (!ipc_pcie || !size) {
+		pr_err("invalid pcie object or size");
+		return NULL;
+	}
+
+	skb = __netdev_alloc_skb(NULL, size, flags);
+	if (!skb)
+		return NULL;
+
+	IPC_CB(skb)->op_type = (u8)UL_DEFAULT;
+	IPC_CB(skb)->mapping = 0;
+
+	return skb;
+}
+
+struct sk_buff *ipc_pcie_alloc_skb(struct iosm_pcie *ipc_pcie, size_t size,
+				   gfp_t flags, dma_addr_t *mapping,
+				   int direction, size_t headroom)
+{
+	struct sk_buff *skb = ipc_pcie_alloc_local_skb(ipc_pcie, flags,
+						       size + headroom);
+	if (!skb)
+		return NULL;
+
+	if (headroom)
+		skb_reserve(skb, headroom);
+
+	if (ipc_pcie_addr_map(ipc_pcie, skb->data, size, mapping, direction)) {
+		dev_kfree_skb(skb);
+		return NULL;
+	}
+
+	BUILD_BUG_ON(sizeof(*IPC_CB(skb)) > sizeof(skb->cb));
+
+	/* Store the mapping address in skb scratch pad for later usage */
+	IPC_CB(skb)->mapping = *mapping;
+	IPC_CB(skb)->direction = direction;
+	IPC_CB(skb)->len = size;
+
+	return skb;
+}
+
+void ipc_pcie_kfree_skb(struct iosm_pcie *ipc_pcie, struct sk_buff *skb)
+{
+	if (!skb)
+		return;
+
+	ipc_pcie_addr_unmap(ipc_pcie, IPC_CB(skb)->len, IPC_CB(skb)->mapping,
+			    IPC_CB(skb)->direction);
+	IPC_CB(skb)->mapping = 0;
+	dev_kfree_skb(skb);
+}
+
+static int __init iosm_ipc_init(void)
+{
+	if (pci_register_driver(&iosm_ipc_driver)) {
+		pr_err("registering of IOSM PCIe driver failed");
+		return -1;
+	}
+
+	if (rtnl_link_register(&iosm_netlink)) {
+		pr_err("IOSM RTNL register failed");
+		pci_unregister_driver(&iosm_ipc_driver);
+		return -1;
+	}
+
+	return 0;
+}
+
+static void __exit iosm_ipc_exit(void)
+{
+	rtnl_link_unregister(&iosm_netlink);
+	pci_unregister_driver(&iosm_ipc_driver);
+}
+
+module_init(iosm_ipc_init);
+module_exit(iosm_ipc_exit);
diff --git a/drivers/net/wwan/iosm/iosm_ipc_pcie.h b/drivers/net/wwan/iosm/iosm_ipc_pcie.h
new file mode 100644
index 000000000000..9623fff7f030
--- /dev/null
+++ b/drivers/net/wwan/iosm/iosm_ipc_pcie.h
@@ -0,0 +1,211 @@
+/* SPDX-License-Identifier: GPL-2.0-only
+ *
+ * Copyright (C) 2020-21 Intel Corporation.
+ */
+
+#ifndef IOSM_IPC_PCIE_H
+#define IOSM_IPC_PCIE_H
+
+#include <linux/device.h>
+#include <linux/pci.h>
+#include <linux/skbuff.h>
+
+#include "iosm_ipc_irq.h"
+
+extern struct rtnl_link_ops iosm_netlink;
+
+/* Device ID */
+#define INTEL_CP_DEVICE_7560_ID 0x7560
+
+/* Define for BAR area usage */
+#define IPC_DOORBELL_BAR0 0
+#define IPC_SCRATCHPAD_BAR2 2
+
+/* Defines for DOORBELL registers information */
+#define IPC_DOORBELL_CH_OFFSET BIT(5)
+#define IPC_WRITE_PTR_REG_0 BIT(4)
+#define IPC_CAPTURE_PTR_REG_0 BIT(3)
+
+/* Number of MSI used for IPC */
+#define IPC_MSI_VECTORS 1
+
+/* Total number of Maximum IPC IRQ vectors used for IPC */
+#define IPC_IRQ_VECTORS IPC_MSI_VECTORS
+
+/**
+ * enum ipc_pcie_sleep_state - Enum type to different sleep state transitions
+ * @IPC_PCIE_D0L12:	Put the sleep state in D0L12
+ * @IPC_PCIE_D3L2:	Put the sleep state in D3L2
+ */
+enum ipc_pcie_sleep_state {
+	IPC_PCIE_D0L12,
+	IPC_PCIE_D3L2,
+};
+
+/**
+ * struct iosm_pcie - IPC_PCIE struct.
+ * @pci:			Address of the device description
+ * @dev:			Pointer to generic device structure
+ * @ipc_regs:			Remapped CP doorbell address of the irq register
+ *				set, to fire the doorbell irq.
+ * @scratchpad:			Remapped CP scratchpad address, to send the
+ *				configuration. tuple and the IPC descriptors
+ *				to CP in the ROM phase. The config tuple
+ *				information are saved on the MSI scratchpad.
+ * @imem:			Pointer to imem data struct
+ * @ipc_regs_bar_nr:		BAR number to be used for IPC doorbell
+ * @scratchpad_bar_nr:		BAR number to be used for Scratchpad
+ * @nvec:			number of requested irq vectors
+ * @doorbell_reg_offset:	doorbell_reg_offset
+ * @doorbell_write:		doorbell write register
+ * @doorbell_capture:		doorbell capture resgister
+ * @suspend:			S2IDLE sleep/active
+ * @d3l2_support:		Read WWAN RTD3 BIOS setting for D3L2 support
+ */
+struct iosm_pcie {
+	struct pci_dev *pci;
+	struct device *dev;
+	void __iomem *ipc_regs;
+	void __iomem *scratchpad;
+	struct iosm_imem *imem;
+	int ipc_regs_bar_nr;
+	int scratchpad_bar_nr;
+	int nvec;
+	u32 doorbell_reg_offset;
+	u32 doorbell_write;
+	u32 doorbell_capture;
+	unsigned long suspend;
+	enum ipc_pcie_sleep_state d3l2_support;
+};
+
+/**
+ * struct ipc_skb_cb - Struct definition of the socket buffer which is mapped to
+ *		       the cb field of sbk
+ * @mapping:	Store physical or IOVA mapped address of skb virtual add.
+ * @direction:	DMA direction
+ * @len:	Length of the DMA mapped region
+ * @op_type:    Expected values are defined about enum ipc_ul_usr_op.
+ */
+struct ipc_skb_cb {
+	dma_addr_t mapping;
+	int direction;
+	int len;
+	u8 op_type;
+};
+
+/**
+ * enum ipc_ul_usr_op - Control operation to execute the right action on
+ *			the user interface.
+ * @UL_USR_OP_BLOCKED:	The uplink app was blocked until CP confirms that the
+ *			uplink buffer was consumed triggered by the IRQ.
+ * @UL_MUX_OP_ADB:	In MUX mode the UL ADB shall be addedd to the free list.
+ * @UL_DEFAULT:		SKB in non muxing mode
+ */
+enum ipc_ul_usr_op {
+	UL_USR_OP_BLOCKED,
+	UL_MUX_OP_ADB,
+	UL_DEFAULT,
+};
+
+/**
+ * ipc_pcie_addr_map - Maps the kernel's virtual address to either IOVA
+ *		       address space or Physical address space, the mapping is
+ *		       stored in the skb's cb.
+ * @ipc_pcie:	Pointer to struct iosm_pcie
+ * @data:	Skb mem containing data
+ * @size:	Data size
+ * @mapping:	Dma mapping address
+ * @direction:	Data direction
+ *
+ * Returns: 0 on success and failure value on error
+ */
+int ipc_pcie_addr_map(struct iosm_pcie *ipc_pcie, unsigned char *data,
+		      size_t size, dma_addr_t *mapping, int direction);
+
+/**
+ * ipc_pcie_addr_unmap - Unmaps the skb memory region from IOVA address space
+ * @ipc_pcie:	Pointer to struct iosm_pcie
+ * @size:	Data size
+ * @mapping:	Dma mapping address
+ * @direction:	Data direction
+ */
+void ipc_pcie_addr_unmap(struct iosm_pcie *ipc_pcie, size_t size,
+			 dma_addr_t mapping, int direction);
+
+/**
+ * ipc_pcie_alloc_skb - Allocate an uplink SKB for the given size.
+ * @ipc_pcie:	Pointer to struct iosm_pcie
+ * @size:	Size of the SKB required.
+ * @flags:	Allocation flags
+ * @mapping:	Copies either mapped IOVA add. or converted Phy address
+ * @direction:	DMA data direction
+ * @headroom:	Header data offset
+ *
+ * Returns: Pointer to ipc_skb on Success, NULL on failure.
+ */
+struct sk_buff *ipc_pcie_alloc_skb(struct iosm_pcie *ipc_pcie, size_t size,
+				   gfp_t flags, dma_addr_t *mapping,
+				   int direction, size_t headroom);
+
+/**
+ * ipc_pcie_alloc_local_skb - Allocate a local SKB for the given size.
+ * @ipc_pcie:	Pointer to struct iosm_pcie
+ * @flags:	Allocation flags
+ * @size:	Size of the SKB required.
+ *
+ * Returns: Pointer to ipc_skb on Success, NULL on failure.
+ */
+struct sk_buff *ipc_pcie_alloc_local_skb(struct iosm_pcie *ipc_pcie,
+					 gfp_t flags, size_t size);
+
+/**
+ * ipc_pcie_kfree_skb - Free skb allocated by ipc_pcie_alloc_*_skb().
+ * @ipc_pcie:	Pointer to struct iosm_pcie
+ * @skb:	Pointer to the skb
+ */
+void ipc_pcie_kfree_skb(struct iosm_pcie *ipc_pcie, struct sk_buff *skb);
+
+/**
+ * ipc_pcie_check_data_link_active - Check Data Link Layer Active
+ * @ipc_pcie:	Pointer to struct iosm_pcie
+ *
+ * Returns: true if active, otherwise false
+ */
+bool ipc_pcie_check_data_link_active(struct iosm_pcie *ipc_pcie);
+
+/**
+ * iosm_ipc_suspend - Callback invoked by pm_runtime_suspend. It decrements
+ *		     the device's usage count then, carry out a suspend,
+ *		     either synchronous or asynchronous.
+ * @ipc_pcie:	Pointer to struct iosm_pcie
+ *
+ * Returns: 0 on success and failure value on error
+ */
+int iosm_ipc_suspend(struct iosm_pcie *ipc_pcie);
+
+/**
+ * iosm_ipc_resume - Callback invoked by pm_runtime_resume. It increments
+ *		    the device's usage count then, carry out a resume,
+ *		    either synchronous or asynchronous.
+ * @ipc_pcie:	Pointer to struct iosm_pcie
+ *
+ * Returns: 0 on success and failure value on error
+ */
+int iosm_ipc_resume(struct iosm_pcie *ipc_pcie);
+
+/**
+ * ipc_pcie_check_aspm_enabled - Check if ASPM L1 is already enabled
+ * @ipc_pcie:			 Pointer to struct iosm_pcie
+ * @parent:			 True if checking ASPM L1 for parent else false
+ *
+ * Returns: true if ASPM is already enabled else false
+ */
+bool ipc_pcie_check_aspm_enabled(struct iosm_pcie *ipc_pcie,
+				 bool parent);
+/**
+ * ipc_pcie_config_aspm - Configure ASPM L1
+ * @ipc_pcie:	Pointer to struct iosm_pcie
+ */
+void ipc_pcie_config_aspm(struct iosm_pcie *ipc_pcie);
+
+#endif
-- 
2.25.1

