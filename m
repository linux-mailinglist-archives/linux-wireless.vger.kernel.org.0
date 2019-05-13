Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD0141B445
	for <lists+linux-wireless@lfdr.de>; Mon, 13 May 2019 12:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729152AbfEMKoO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 May 2019 06:44:14 -0400
Received: from mga12.intel.com ([192.55.52.136]:2829 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728365AbfEMKoD (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 May 2019 06:44:03 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 May 2019 03:44:02 -0700
X-ExtLoop1: 1
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 13 May 2019 03:44:00 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 75EA22F5; Mon, 13 May 2019 13:43:59 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     =?UTF-8?q?Cl=C3=A9ment=20Perrochaud?= 
        <clement.perrochaud@effinnov.com>,
        Charles Gorand <charles.gorand@effinnov.com>,
        linux-nfc@lists.01.org, Samuel Ortiz <sameo@linux.intel.com>,
        linux-wireless@vger.kernel.org,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 02/12] NFC: nxp-nci: Get rid of platform data
Date:   Mon, 13 May 2019 13:43:48 +0300
Message-Id: <20190513104358.59716-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190513104358.59716-1-andriy.shevchenko@linux.intel.com>
References: <20190513104358.59716-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Legacy platform data must go away. We are on the safe side here since
there are no users of it in the kernel.

If anyone by any odd reason needs it the GPIO lookup tables and
built-in device properties at your service.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 MAINTAINERS                           |  1 -
 drivers/nfc/nxp-nci/core.c            |  1 -
 drivers/nfc/nxp-nci/i2c.c             |  9 +--------
 drivers/nfc/nxp-nci/nxp-nci.h         |  1 -
 include/linux/platform_data/nxp-nci.h | 27 ---------------------------
 5 files changed, 1 insertion(+), 38 deletions(-)
 delete mode 100644 include/linux/platform_data/nxp-nci.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 7707c28628b9..faa7493933de 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11068,7 +11068,6 @@ F:	include/net/nfc/
 F:	include/uapi/linux/nfc.h
 F:	drivers/nfc/
 F:	include/linux/platform_data/nfcmrvl.h
-F:	include/linux/platform_data/nxp-nci.h
 F:	Documentation/devicetree/bindings/net/nfc/
 
 NFS, SUNRPC, AND LOCKD CLIENTS
diff --git a/drivers/nfc/nxp-nci/core.c b/drivers/nfc/nxp-nci/core.c
index 2e4b004a96aa..1907b1fd57a7 100644
--- a/drivers/nfc/nxp-nci/core.c
+++ b/drivers/nfc/nxp-nci/core.c
@@ -25,7 +25,6 @@
 #include <linux/gpio.h>
 #include <linux/module.h>
 #include <linux/nfc.h>
-#include <linux/platform_data/nxp-nci.h>
 
 #include <net/nfc/nci_core.h>
 
diff --git a/drivers/nfc/nxp-nci/i2c.c b/drivers/nfc/nxp-nci/i2c.c
index fec904ad624b..549e09deb92f 100644
--- a/drivers/nfc/nxp-nci/i2c.c
+++ b/drivers/nfc/nxp-nci/i2c.c
@@ -34,7 +34,6 @@
 #include <linux/gpio/consumer.h>
 #include <linux/of_gpio.h>
 #include <linux/of_irq.h>
-#include <linux/platform_data/nxp-nci.h>
 #include <asm/unaligned.h>
 
 #include <net/nfc/nfc.h>
@@ -315,7 +314,6 @@ static int nxp_nci_i2c_probe(struct i2c_client *client,
 			    const struct i2c_device_id *id)
 {
 	struct nxp_nci_i2c_phy *phy;
-	struct nxp_nci_nfc_platform_data *pdata;
 	int r;
 
 	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
@@ -334,17 +332,12 @@ static int nxp_nci_i2c_probe(struct i2c_client *client,
 	phy->i2c_dev = client;
 	i2c_set_clientdata(client, phy);
 
-	pdata = client->dev.platform_data;
-
-	if (!pdata && client->dev.of_node) {
+	if (client->dev.of_node) {
 		r = nxp_nci_i2c_parse_devtree(client);
 		if (r < 0) {
 			nfc_err(&client->dev, "Failed to get DT data\n");
 			goto probe_exit;
 		}
-	} else if (pdata) {
-		phy->gpio_en = pdata->gpio_en;
-		phy->gpio_fw = pdata->gpio_fw;
 	} else if (ACPI_HANDLE(&client->dev)) {
 		r = nxp_nci_i2c_acpi_config(phy);
 		if (r < 0)
diff --git a/drivers/nfc/nxp-nci/nxp-nci.h b/drivers/nfc/nxp-nci/nxp-nci.h
index 20408cbff4f1..e584c92fad49 100644
--- a/drivers/nfc/nxp-nci/nxp-nci.h
+++ b/drivers/nfc/nxp-nci/nxp-nci.h
@@ -25,7 +25,6 @@
 #include <linux/completion.h>
 #include <linux/firmware.h>
 #include <linux/nfc.h>
-#include <linux/platform_data/nxp-nci.h>
 
 #include <net/nfc/nci_core.h>
 
diff --git a/include/linux/platform_data/nxp-nci.h b/include/linux/platform_data/nxp-nci.h
deleted file mode 100644
index d6ed28679bb2..000000000000
--- a/include/linux/platform_data/nxp-nci.h
+++ /dev/null
@@ -1,27 +0,0 @@
-/*
- * Generic platform data for the NXP NCI NFC chips.
- *
- * Copyright (C) 2014  NXP Semiconductors  All rights reserved.
- *
- * Authors: Clément Perrochaud <clement.perrochaud@nxp.com>
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU General Public License,
- * version 2, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
- * GNU General Public License for more details.
- */
-
-#ifndef _NXP_NCI_H_
-#define _NXP_NCI_H_
-
-struct nxp_nci_nfc_platform_data {
-	unsigned int gpio_en;
-	unsigned int gpio_fw;
-	unsigned int irq;
-};
-
-#endif /* _NXP_NCI_H_ */
-- 
2.20.1

