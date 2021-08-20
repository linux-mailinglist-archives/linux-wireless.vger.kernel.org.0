Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 339B83F2DEF
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Aug 2021 16:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240884AbhHTOWe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 20 Aug 2021 10:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240863AbhHTOWZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 20 Aug 2021 10:22:25 -0400
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [IPv6:2001:67c:2050::465:101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39D74C061575;
        Fri, 20 Aug 2021 07:21:47 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:105:465:1:1:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4GrkN96LFZzQk9P;
        Fri, 20 Aug 2021 16:21:45 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter03.heinlein-hosting.de (spamfilter03.heinlein-hosting.de [80.241.56.117]) (amavisd-new, port 10030)
        with ESMTP id hPyQUZQUV2HY; Fri, 20 Aug 2021 16:21:42 +0200 (CEST)
From:   =?UTF-8?q?Jonas=20Dre=C3=9Fler?= <verdre@v0yd.nl>
To:     Amitkumar Karwar <amitkarwar@gmail.com>,
        Ganapathi Bhat <ganapathi.bhat@nxp.com>,
        Xinming Hu <huxinming820@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     Tsuchiya Yuto <kitakar@gmail.com>,
        =?UTF-8?q?Jonas=20Dre=C3=9Fler?= <verdre@v0yd.nl>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
Subject: [PATCH v3 2/2] mwifiex: pcie: add reset_d3cold quirk for Surface gen4+ devices
Date:   Fri, 20 Aug 2021 16:20:50 +0200
Message-Id: <20210820142050.35741-3-verdre@v0yd.nl>
In-Reply-To: <20210820142050.35741-1-verdre@v0yd.nl>
References: <20210820142050.35741-1-verdre@v0yd.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E8ECA1898
X-Rspamd-UID: e25ff2
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Tsuchiya Yuto <kitakar@gmail.com>

To reset mwifiex on Surface gen4+ (Pro 4 or later gen) devices, it
seems that putting the wifi device into D3cold is required according
to errata.inf file on Windows installation (Windows/INF/errata.inf).

This patch adds a function that performs power-cycle (put into D3cold
then D0) and call the function at the end of reset_prepare().

Note: Need to also reset the parent device (bridge) of wifi on SB1;
it might be because the bridge of wifi always reports it's in D3hot.
When I tried to reset only the wifi device (not touching parent), it gave
the following error and the reset failed:

    acpi device:4b: Cannot transition to power state D0 for parent in D3hot
    mwifiex_pcie 0000:03:00.0: can't change power state from D3cold to D0 (config space inaccessible)

Signed-off-by: Tsuchiya Yuto <kitakar@gmail.com>
Signed-off-by: Jonas Dreßler <verdre@v0yd.nl>
---
 drivers/net/wireless/marvell/mwifiex/pcie.c   |   7 +
 .../wireless/marvell/mwifiex/pcie_quirks.c    | 123 ++++++++++++++++++
 .../wireless/marvell/mwifiex/pcie_quirks.h    |   3 +
 3 files changed, 133 insertions(+)

diff --git a/drivers/net/wireless/marvell/mwifiex/pcie.c b/drivers/net/wireless/marvell/mwifiex/pcie.c
index a530832c9421..c6ccce426b49 100644
--- a/drivers/net/wireless/marvell/mwifiex/pcie.c
+++ b/drivers/net/wireless/marvell/mwifiex/pcie.c
@@ -528,6 +528,13 @@ static void mwifiex_pcie_reset_prepare(struct pci_dev *pdev)
 	mwifiex_shutdown_sw(adapter);
 	clear_bit(MWIFIEX_IFACE_WORK_DEVICE_DUMP, &card->work_flags);
 	clear_bit(MWIFIEX_IFACE_WORK_CARD_RESET, &card->work_flags);
+
+	/* On MS Surface gen4+ devices FLR isn't effective to recover from
+	 * hangups, so we power-cycle the card instead.
+	 */
+	if (card->quirks & QUIRK_FW_RST_D3COLD)
+		mwifiex_pcie_reset_d3cold_quirk(pdev);
+
 	mwifiex_dbg(adapter, INFO, "%s, successful\n", __func__);
 
 	card->pci_reset_ongoing = true;
diff --git a/drivers/net/wireless/marvell/mwifiex/pcie_quirks.c b/drivers/net/wireless/marvell/mwifiex/pcie_quirks.c
index c1665ac5c5d9..0234cf3c2974 100644
--- a/drivers/net/wireless/marvell/mwifiex/pcie_quirks.c
+++ b/drivers/net/wireless/marvell/mwifiex/pcie_quirks.c
@@ -21,6 +21,72 @@
 
 /* quirk table based on DMI matching */
 static const struct dmi_system_id mwifiex_quirk_table[] = {
+	{
+		.ident = "Surface Pro 4",
+		.matches = {
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Microsoft Corporation"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Surface Pro 4"),
+		},
+		.driver_data = (void *)QUIRK_FW_RST_D3COLD,
+	},
+	{
+		.ident = "Surface Pro 5",
+		.matches = {
+			/* match for SKU here due to generic product name "Surface Pro" */
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Microsoft Corporation"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_SKU, "Surface_Pro_1796"),
+		},
+		.driver_data = (void *)QUIRK_FW_RST_D3COLD,
+	},
+	{
+		.ident = "Surface Pro 5 (LTE)",
+		.matches = {
+			/* match for SKU here due to generic product name "Surface Pro" */
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Microsoft Corporation"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_SKU, "Surface_Pro_1807"),
+		},
+		.driver_data = (void *)QUIRK_FW_RST_D3COLD,
+	},
+	{
+		.ident = "Surface Pro 6",
+		.matches = {
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Microsoft Corporation"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Surface Pro 6"),
+		},
+		.driver_data = (void *)QUIRK_FW_RST_D3COLD,
+	},
+	{
+		.ident = "Surface Book 1",
+		.matches = {
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Microsoft Corporation"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Surface Book"),
+		},
+		.driver_data = (void *)QUIRK_FW_RST_D3COLD,
+	},
+	{
+		.ident = "Surface Book 2",
+		.matches = {
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Microsoft Corporation"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Surface Book 2"),
+		},
+		.driver_data = (void *)QUIRK_FW_RST_D3COLD,
+	},
+	{
+		.ident = "Surface Laptop 1",
+		.matches = {
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Microsoft Corporation"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Surface Laptop"),
+		},
+		.driver_data = (void *)QUIRK_FW_RST_D3COLD,
+	},
+	{
+		.ident = "Surface Laptop 2",
+		.matches = {
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Microsoft Corporation"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "Surface Laptop 2"),
+		},
+		.driver_data = (void *)QUIRK_FW_RST_D3COLD,
+	},
 	{}
 };
 
@@ -35,4 +101,61 @@ void mwifiex_initialize_quirks(struct pcie_service_card *card)
 
 	if (!card->quirks)
 		dev_info(&pdev->dev, "no quirks enabled\n");
+	if (card->quirks & QUIRK_FW_RST_D3COLD)
+		dev_info(&pdev->dev, "quirk reset_d3cold enabled\n");
+}
+
+static void mwifiex_pcie_set_power_d3cold(struct pci_dev *pdev)
+{
+	dev_info(&pdev->dev, "putting into D3cold...\n");
+
+	pci_save_state(pdev);
+	if (pci_is_enabled(pdev))
+		pci_disable_device(pdev);
+	pci_set_power_state(pdev, PCI_D3cold);
+}
+
+static int mwifiex_pcie_set_power_d0(struct pci_dev *pdev)
+{
+	int ret;
+
+	dev_info(&pdev->dev, "putting into D0...\n");
+
+	pci_set_power_state(pdev, PCI_D0);
+	ret = pci_enable_device(pdev);
+	if (ret) {
+		dev_err(&pdev->dev, "pci_enable_device failed\n");
+		return ret;
+	}
+	pci_restore_state(pdev);
+
+	return 0;
+}
+
+int mwifiex_pcie_reset_d3cold_quirk(struct pci_dev *pdev)
+{
+	struct pci_dev *parent_pdev = pci_upstream_bridge(pdev);
+	int ret;
+
+	/* Power-cycle (put into D3cold then D0) */
+	dev_info(&pdev->dev, "Using reset_d3cold quirk to perform FW reset\n");
+
+	/* We need to perform power-cycle also for bridge of wifi because
+	 * on some devices (e.g. Surface Book 1), the OS for some reasons
+	 * can't know the real power state of the bridge.
+	 * When tried to power-cycle only wifi, the reset failed with the
+	 * following dmesg log:
+	 * "Cannot transition to power state D0 for parent in D3hot".
+	 */
+	mwifiex_pcie_set_power_d3cold(pdev);
+	mwifiex_pcie_set_power_d3cold(parent_pdev);
+
+	ret = mwifiex_pcie_set_power_d0(parent_pdev);
+	if (ret)
+		return ret;
+	ret = mwifiex_pcie_set_power_d0(pdev);
+	if (ret)
+		return ret;
+
+	return 0;
 }
diff --git a/drivers/net/wireless/marvell/mwifiex/pcie_quirks.h b/drivers/net/wireless/marvell/mwifiex/pcie_quirks.h
index 18eacc8c2d3a..8ec4176d698f 100644
--- a/drivers/net/wireless/marvell/mwifiex/pcie_quirks.h
+++ b/drivers/net/wireless/marvell/mwifiex/pcie_quirks.h
@@ -17,4 +17,7 @@
 
 #include "pcie.h"
 
+#define QUIRK_FW_RST_D3COLD	BIT(0)
+
 void mwifiex_initialize_quirks(struct pcie_service_card *card);
+int mwifiex_pcie_reset_d3cold_quirk(struct pci_dev *pdev);
-- 
2.31.1

