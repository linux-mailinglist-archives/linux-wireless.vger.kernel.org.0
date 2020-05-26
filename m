Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B93A71CC049
	for <lists+linux-wireless@lfdr.de>; Sat,  9 May 2020 12:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbgEIKUU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 9 May 2020 06:20:20 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4320 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726877AbgEIKUT (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 9 May 2020 06:20:19 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 2719BB310B83E5E88FAF;
        Sat,  9 May 2020 18:20:16 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.487.0; Sat, 9 May 2020 18:20:08 +0800
From:   Yicong Yang <yangyicong@hisilicon.com>
To:     <helgaas@kernel.org>, <linux-pci@vger.kernel.org>
CC:     <kvalo@codeaurora.org>, <andreas.noever@gmail.com>,
        <rjw@rjwysocki.net>, <mika.westerberg@linux.intel.com>,
        <linux-wireless@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linuxarm@huawei.com>, <yangyicong@hisilicon.com>
Subject: [PATCH v3] PCI: Use pcie_find_root_port() to get root port of both PCI/PCIe device
Date:   Sat, 9 May 2020 18:19:28 +0800
Message-ID: <1589019568-5216-1-git-send-email-yangyicong@hisilicon.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Previously we use pcie_find_root_port() to get root port from a pcie
device, use pci_find_pcie_root_port() to get root port from a pci
device, which increase the complexity.

Unify the two functions and use pcie_find_root_port() to get root
port from both pci device and pcie device. Then there is no need to
distinguish the type of the device.

The callers of the function list below, they'll get no functional
change:
- iwl_trans_pcie_dump_regs()
- pcie_root_rcb_set()
- aer_inject()
- acpi_pci_bridge_d3()
- pci_configure_relaxed_ordering()

Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
Acked-by: Kalle Valo <kvalo@codeaurora.org> // for wireless
Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com> // for thunderbolt
---
Change since v2:
- archive the callers in the commit message
- rename pci_pcie_find_root_port() as pcie_find_root_port()
- use pci_upstream_bridge() to traverse the chain
Link: https://lore.kernel.org/linux-pci/1588768976-4852-1-git-send-email-yangyicong@hisilicon.com/

Change since v1:
- Add Mika's Ack for thunderbolt part
- Add description for pci_pcie_find_root_port()

 drivers/pci/pci-acpi.c       |  2 +-
 drivers/pci/pci.c            | 24 ------------------------
 drivers/pci/probe.c          |  2 +-
 drivers/pci/quirks.c         |  2 +-
 drivers/thunderbolt/switch.c |  4 ++--
 include/linux/pci.h          | 23 ++++++++++++++---------
 6 files changed, 19 insertions(+), 38 deletions(-)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index 0c02d50..d401370 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -948,7 +948,7 @@ static bool acpi_pci_bridge_d3(struct pci_dev *dev)
 	 * Look for a special _DSD property for the root port and if it
 	 * is set we know the hierarchy behind it supports D3 just fine.
 	 */
-	root = pci_find_pcie_root_port(dev);
+	root = pcie_find_root_port(dev);
 	if (!root)
 		return false;

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index d828ca8..fc5e7b6 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -695,30 +695,6 @@ struct resource *pci_find_resource(struct pci_dev *dev, struct resource *res)
 EXPORT_SYMBOL(pci_find_resource);

 /**
- * pci_find_pcie_root_port - return PCIe Root Port
- * @dev: PCI device to query
- *
- * Traverse up the parent chain and return the PCIe Root Port PCI Device
- * for a given PCI Device.
- */
-struct pci_dev *pci_find_pcie_root_port(struct pci_dev *dev)
-{
-	struct pci_dev *bridge, *highest_pcie_bridge = dev;
-
-	bridge = pci_upstream_bridge(dev);
-	while (bridge && pci_is_pcie(bridge)) {
-		highest_pcie_bridge = bridge;
-		bridge = pci_upstream_bridge(bridge);
-	}
-
-	if (pci_pcie_type(highest_pcie_bridge) != PCI_EXP_TYPE_ROOT_PORT)
-		return NULL;
-
-	return highest_pcie_bridge;
-}
-EXPORT_SYMBOL(pci_find_pcie_root_port);
-
-/**
  * pci_wait_for_pending - wait for @mask bit(s) to clear in status word @pos
  * @dev: the PCI device to operate on
  * @pos: config space offset of status word
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 512cb43..554cdca 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2015,7 +2015,7 @@ static void pci_configure_relaxed_ordering(struct pci_dev *dev)
 	 * For now, we only deal with Relaxed Ordering issues with Root
 	 * Ports. Peer-to-Peer DMA is another can of worms.
 	 */
-	root = pci_find_pcie_root_port(dev);
+	root = pcie_find_root_port(dev);
 	if (!root)
 		return;

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 29f473e..7aeeda5 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4253,7 +4253,7 @@ DECLARE_PCI_FIXUP_CLASS_EARLY(PCI_VENDOR_ID_AMD, 0x1a02, PCI_CLASS_NOT_DEFINED,
  */
 static void quirk_disable_root_port_attributes(struct pci_dev *pdev)
 {
-	struct pci_dev *root_port = pci_find_pcie_root_port(pdev);
+	struct pci_dev *root_port = pcie_find_root_port(pdev);

 	if (!root_port) {
 		pci_warn(pdev, "PCIe Completion erratum may cause device errors\n");
diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
index a2ce990..d92c755 100644
--- a/drivers/thunderbolt/switch.c
+++ b/drivers/thunderbolt/switch.c
@@ -263,7 +263,7 @@ static void nvm_authenticate_start_dma_port(struct tb_switch *sw)
 	 * itself. To be on the safe side keep the root port in D0 during
 	 * the whole upgrade process.
 	 */
-	root_port = pci_find_pcie_root_port(sw->tb->nhi->pdev);
+	root_port = pcie_find_root_port(sw->tb->nhi->pdev);
 	if (root_port)
 		pm_runtime_get_noresume(&root_port->dev);
 }
@@ -272,7 +272,7 @@ static void nvm_authenticate_complete_dma_port(struct tb_switch *sw)
 {
 	struct pci_dev *root_port;

-	root_port = pci_find_pcie_root_port(sw->tb->nhi->pdev);
+	root_port = pcie_find_root_port(sw->tb->nhi->pdev);
 	if (root_port)
 		pm_runtime_put(&root_port->dev);
 }
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 3840a54..98fb495 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1011,7 +1011,6 @@ void pci_bus_add_device(struct pci_dev *dev);
 void pci_read_bridge_bases(struct pci_bus *child);
 struct resource *pci_find_parent_resource(const struct pci_dev *dev,
 					  struct resource *res);
-struct pci_dev *pci_find_pcie_root_port(struct pci_dev *dev);
 u8 pci_swizzle_interrupt_pin(const struct pci_dev *dev, u8 pin);
 int pci_get_interrupt_pin(struct pci_dev *dev, struct pci_dev **bridge);
 u8 pci_common_swizzle(struct pci_dev *dev, u8 *pinp);
@@ -2124,17 +2123,23 @@ static inline int pci_pcie_type(const struct pci_dev *dev)
 	return (pcie_caps_reg(dev) & PCI_EXP_FLAGS_TYPE) >> 4;
 }

+/**
+ * pcie_find_root_port - Get the PCIe root port device
+ * @dev: PCI device
+ *
+ * Traverse up the parent chain and return the PCIe Root Port PCI Device
+ * for a given PCI/PCIe Device.
+ */
 static inline struct pci_dev *pcie_find_root_port(struct pci_dev *dev)
 {
-	while (1) {
-		if (!pci_is_pcie(dev))
-			break;
-		if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT)
-			return dev;
-		if (!dev->bus->self)
-			break;
-		dev = dev->bus->self;
+	struct pci_dev *root_port = pci_upstream_bridge(dev);
+
+	while (root_port) {
+		if (pci_pcie_type(root_port) == PCI_EXP_TYPE_ROOT_PORT)
+			return root_port;
+		root_port = pci_upstream_bridge(root_port);
 	}
+
 	return NULL;
 }

--
2.8.1

