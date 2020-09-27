Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 313AF27A309
	for <lists+linux-wireless@lfdr.de>; Sun, 27 Sep 2020 21:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbgI0Tz3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 27 Sep 2020 15:55:29 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:10070
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726440AbgI0TzU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 27 Sep 2020 15:55:20 -0400
X-IronPort-AV: E=Sophos;i="5.77,311,1596492000"; 
   d="scan'208";a="360169491"
Received: from palace.rsr.lip6.fr (HELO palace.lip6.fr) ([132.227.105.202])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/AES256-SHA256; 27 Sep 2020 21:55:12 +0200
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>
Cc:     =?UTF-8?q?Valdis=20Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        Joe Perches <joe@perches.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        kernel-janitors@vger.kernel.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 05/18] bcma: use semicolons rather than commas to separate statements
Date:   Sun, 27 Sep 2020 21:12:15 +0200
Message-Id: <1601233948-11629-6-git-send-email-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1601233948-11629-1-git-send-email-Julia.Lawall@inria.fr>
References: <1601233948-11629-1-git-send-email-Julia.Lawall@inria.fr>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Replace commas with semicolons.  What is done is essentially described by
the following Coccinelle semantic patch (http://coccinelle.lip6.fr/):

// <smpl>
@@ expression e1,e2; @@
e1
-,
+;
e2
... when any
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 drivers/bcma/driver_pci_host.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bcma/driver_pci_host.c b/drivers/bcma/driver_pci_host.c
index 88a93c266c19..6f8fc5f587fe 100644
--- a/drivers/bcma/driver_pci_host.c
+++ b/drivers/bcma/driver_pci_host.c
@@ -419,12 +419,12 @@ void bcma_core_pci_hostmode_init(struct bcma_drv_pci *pc)
 	pc_host->pci_ops.read = bcma_core_pci_hostmode_read_config;
 	pc_host->pci_ops.write = bcma_core_pci_hostmode_write_config;
 
-	pc_host->mem_resource.name = "BCMA PCIcore external memory",
+	pc_host->mem_resource.name = "BCMA PCIcore external memory";
 	pc_host->mem_resource.start = BCMA_SOC_PCI_DMA;
 	pc_host->mem_resource.end = BCMA_SOC_PCI_DMA + BCMA_SOC_PCI_DMA_SZ - 1;
 	pc_host->mem_resource.flags = IORESOURCE_MEM | IORESOURCE_PCI_FIXED;
 
-	pc_host->io_resource.name = "BCMA PCIcore external I/O",
+	pc_host->io_resource.name = "BCMA PCIcore external I/O";
 	pc_host->io_resource.start = 0x100;
 	pc_host->io_resource.end = 0x7FF;
 	pc_host->io_resource.flags = IORESOURCE_IO | IORESOURCE_PCI_FIXED;

