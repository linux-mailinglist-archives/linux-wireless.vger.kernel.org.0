Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 774413997FE
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Jun 2021 04:21:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbhFCCXI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Jun 2021 22:23:08 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3519 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbhFCCXI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Jun 2021 22:23:08 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4FwV1n4SxnzZcFc
        for <linux-wireless@vger.kernel.org>; Thu,  3 Jun 2021 10:18:37 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 3 Jun 2021 10:21:22 +0800
Received: from thunder-town.china.huawei.com (10.174.177.72) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 3 Jun 2021 10:21:22 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Michael Buesch <m@bues.ch>,
        linux-wireless <linux-wireless@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 1/1] ssb: use DEVICE_ATTR_ADMIN_RW macro
Date:   Thu, 3 Jun 2021 10:21:11 +0800
Message-ID: <20210603022111.11279-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.72]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Use DEVICE_ATTR_ADMIN_RW macro helper instead of plain DEVICE_ATTR, which
makes the code a bit shorter and easier to read.

It normalizes the name of the hook function for read and write operations
of the property file, so it's also easier to associate and find.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/ssb/pci.c    | 16 +++++++---------
 drivers/ssb/pcmcia.c | 16 +++++++---------
 2 files changed, 14 insertions(+), 18 deletions(-)

diff --git a/drivers/ssb/pci.c b/drivers/ssb/pci.c
index dac54041ad8d28a..148bcb99c212877 100644
--- a/drivers/ssb/pci.c
+++ b/drivers/ssb/pci.c
@@ -1117,9 +1117,9 @@ const struct ssb_bus_ops ssb_pci_ops = {
 #endif
 };
 
-static ssize_t ssb_pci_attr_sprom_show(struct device *pcidev,
-				       struct device_attribute *attr,
-				       char *buf)
+static ssize_t ssb_sprom_show(struct device *pcidev,
+			      struct device_attribute *attr,
+			      char *buf)
 {
 	struct pci_dev *pdev = container_of(pcidev, struct pci_dev, dev);
 	struct ssb_bus *bus;
@@ -1131,9 +1131,9 @@ static ssize_t ssb_pci_attr_sprom_show(struct device *pcidev,
 	return ssb_attr_sprom_show(bus, buf, sprom_do_read);
 }
 
-static ssize_t ssb_pci_attr_sprom_store(struct device *pcidev,
-					struct device_attribute *attr,
-					const char *buf, size_t count)
+static ssize_t ssb_sprom_store(struct device *pcidev,
+			       struct device_attribute *attr,
+			       const char *buf, size_t count)
 {
 	struct pci_dev *pdev = container_of(pcidev, struct pci_dev, dev);
 	struct ssb_bus *bus;
@@ -1146,9 +1146,7 @@ static ssize_t ssb_pci_attr_sprom_store(struct device *pcidev,
 				    sprom_check_crc, sprom_do_write);
 }
 
-static DEVICE_ATTR(ssb_sprom, 0600,
-		   ssb_pci_attr_sprom_show,
-		   ssb_pci_attr_sprom_store);
+static DEVICE_ATTR_ADMIN_RW(ssb_sprom);
 
 void ssb_pci_exit(struct ssb_bus *bus)
 {
diff --git a/drivers/ssb/pcmcia.c b/drivers/ssb/pcmcia.c
index d7d730c245c5687..45502098e0c785d 100644
--- a/drivers/ssb/pcmcia.c
+++ b/drivers/ssb/pcmcia.c
@@ -723,9 +723,9 @@ int ssb_pcmcia_get_invariants(struct ssb_bus *bus,
 	return -ENODEV;
 }
 
-static ssize_t ssb_pcmcia_attr_sprom_show(struct device *pcmciadev,
-					  struct device_attribute *attr,
-					  char *buf)
+static ssize_t ssb_sprom_show(struct device *pcmciadev,
+			      struct device_attribute *attr,
+			      char *buf)
 {
 	struct pcmcia_device *pdev =
 		container_of(pcmciadev, struct pcmcia_device, dev);
@@ -739,9 +739,9 @@ static ssize_t ssb_pcmcia_attr_sprom_show(struct device *pcmciadev,
 				   ssb_pcmcia_sprom_read_all);
 }
 
-static ssize_t ssb_pcmcia_attr_sprom_store(struct device *pcmciadev,
-					   struct device_attribute *attr,
-					   const char *buf, size_t count)
+static ssize_t ssb_sprom_store(struct device *pcmciadev,
+			       struct device_attribute *attr,
+			       const char *buf, size_t count)
 {
 	struct pcmcia_device *pdev =
 		container_of(pcmciadev, struct pcmcia_device, dev);
@@ -756,9 +756,7 @@ static ssize_t ssb_pcmcia_attr_sprom_store(struct device *pcmciadev,
 				    ssb_pcmcia_sprom_write_all);
 }
 
-static DEVICE_ATTR(ssb_sprom, 0600,
-		   ssb_pcmcia_attr_sprom_show,
-		   ssb_pcmcia_attr_sprom_store);
+static DEVICE_ATTR_ADMIN_RW(ssb_sprom);
 
 static int ssb_pcmcia_cor_setup(struct ssb_bus *bus, u8 cor)
 {
-- 
2.26.0.106.g9fadedd


