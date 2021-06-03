Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 324D5399C72
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Jun 2021 10:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbhFCIYb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 3 Jun 2021 04:24:31 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3528 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbhFCIYa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 3 Jun 2021 04:24:30 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Fwf2k373JzZcG2
        for <linux-wireless@vger.kernel.org>; Thu,  3 Jun 2021 16:19:58 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 3 Jun 2021 16:22:42 +0800
Received: from thunder-town.china.huawei.com (10.174.177.72) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 3 Jun 2021 16:22:42 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Michael Buesch <m@bues.ch>,
        linux-wireless <linux-wireless@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH v2 1/1] ssb: use DEVICE_ATTR_ADMIN_RW() helper macro
Date:   Thu, 3 Jun 2021 16:22:18 +0800
Message-ID: <20210603082218.11718-2-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20210603082218.11718-1-thunder.leizhen@huawei.com>
References: <20210603082218.11718-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.72]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Use DEVICE_ATTR_ADMIN_RW() helper macro instead of DEVICE_ATTR(), making
it simpler and easier to read.

Because the read and write function names of the sysfs attribute have been
normalized, there is a natural association.

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


