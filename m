Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC2721B43B
	for <lists+linux-wireless@lfdr.de>; Mon, 13 May 2019 12:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729123AbfEMKoD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 May 2019 06:44:03 -0400
Received: from mga03.intel.com ([134.134.136.65]:60951 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729120AbfEMKoD (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 May 2019 06:44:03 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 May 2019 03:44:02 -0700
X-ExtLoop1: 1
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 13 May 2019 03:44:00 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 822D2361; Mon, 13 May 2019 13:43:59 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     =?UTF-8?q?Cl=C3=A9ment=20Perrochaud?= 
        <clement.perrochaud@effinnov.com>,
        Charles Gorand <charles.gorand@effinnov.com>,
        linux-nfc@lists.01.org, Samuel Ortiz <sameo@linux.intel.com>,
        linux-wireless@vger.kernel.org,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 03/12] NFC: nxp-nci: Convert to use GPIO descriptor
Date:   Mon, 13 May 2019 13:43:49 +0300
Message-Id: <20190513104358.59716-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190513104358.59716-1-andriy.shevchenko@linux.intel.com>
References: <20190513104358.59716-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Since we got rid of platform data, the driver may use
GPIO descriptor directly.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/nfc/nxp-nci/core.c |  1 -
 drivers/nfc/nxp-nci/i2c.c  | 60 ++++++++++----------------------------
 2 files changed, 15 insertions(+), 46 deletions(-)

diff --git a/drivers/nfc/nxp-nci/core.c b/drivers/nfc/nxp-nci/core.c
index 1907b1fd57a7..b0b6db81a5e8 100644
--- a/drivers/nfc/nxp-nci/core.c
+++ b/drivers/nfc/nxp-nci/core.c
@@ -22,7 +22,6 @@
  */
 
 #include <linux/delay.h>
-#include <linux/gpio.h>
 #include <linux/module.h>
 #include <linux/nfc.h>
 
diff --git a/drivers/nfc/nxp-nci/i2c.c b/drivers/nfc/nxp-nci/i2c.c
index 549e09deb92f..6f61368ae065 100644
--- a/drivers/nfc/nxp-nci/i2c.c
+++ b/drivers/nfc/nxp-nci/i2c.c
@@ -32,8 +32,6 @@
 #include <linux/module.h>
 #include <linux/nfc.h>
 #include <linux/gpio/consumer.h>
-#include <linux/of_gpio.h>
-#include <linux/of_irq.h>
 #include <asm/unaligned.h>
 
 #include <net/nfc/nfc.h>
@@ -48,8 +46,8 @@ struct nxp_nci_i2c_phy {
 	struct i2c_client *i2c_dev;
 	struct nci_dev *ndev;
 
-	unsigned int gpio_en;
-	unsigned int gpio_fw;
+	struct gpio_desc *gpiod_en;
+	struct gpio_desc *gpiod_fw;
 
 	int hard_fault; /*
 			 * < 0 if hardware error occurred (e.g. i2c err)
@@ -62,8 +60,8 @@ static int nxp_nci_i2c_set_mode(void *phy_id,
 {
 	struct nxp_nci_i2c_phy *phy = (struct nxp_nci_i2c_phy *) phy_id;
 
-	gpio_set_value(phy->gpio_fw, (mode == NXP_NCI_MODE_FW) ? 1 : 0);
-	gpio_set_value(phy->gpio_en, (mode != NXP_NCI_MODE_COLD) ? 1 : 0);
+	gpiod_set_value(phy->gpiod_fw, (mode == NXP_NCI_MODE_FW) ? 1 : 0);
+	gpiod_set_value(phy->gpiod_en, (mode != NXP_NCI_MODE_COLD) ? 1 : 0);
 	usleep_range(10000, 15000);
 
 	if (mode == NXP_NCI_MODE_COLD)
@@ -263,30 +261,18 @@ static irqreturn_t nxp_nci_i2c_irq_thread_fn(int irq, void *phy_id)
 static int nxp_nci_i2c_parse_devtree(struct i2c_client *client)
 {
 	struct nxp_nci_i2c_phy *phy = i2c_get_clientdata(client);
-	struct device_node *pp;
-	int r;
-
-	pp = client->dev.of_node;
-	if (!pp)
-		return -ENODEV;
 
-	r = of_get_named_gpio(pp, "enable-gpios", 0);
-	if (r == -EPROBE_DEFER)
-		r = of_get_named_gpio(pp, "enable-gpios", 0);
-	if (r < 0) {
-		nfc_err(&client->dev, "Failed to get EN gpio, error: %d\n", r);
-		return r;
+	phy->gpiod_en = devm_gpiod_get(&client->dev, "enable", GPIOD_OUT_LOW);
+	if (IS_ERR(phy->gpiod_en)) {
+		nfc_err(&client->dev, "Failed to get EN gpio\n");
+		return PTR_ERR(phy->gpiod_en);
 	}
-	phy->gpio_en = r;
 
-	r = of_get_named_gpio(pp, "firmware-gpios", 0);
-	if (r == -EPROBE_DEFER)
-		r = of_get_named_gpio(pp, "firmware-gpios", 0);
-	if (r < 0) {
-		nfc_err(&client->dev, "Failed to get FW gpio, error: %d\n", r);
-		return r;
+	phy->gpiod_fw = devm_gpiod_get(&client->dev, "firmware", GPIOD_OUT_LOW);
+	if (IS_ERR(phy->gpiod_fw)) {
+		nfc_err(&client->dev, "Failed to get FW gpio\n");
+		return PTR_ERR(phy->gpiod_fw);
 	}
-	phy->gpio_fw = r;
 
 	return 0;
 }
@@ -294,19 +280,15 @@ static int nxp_nci_i2c_parse_devtree(struct i2c_client *client)
 static int nxp_nci_i2c_acpi_config(struct nxp_nci_i2c_phy *phy)
 {
 	struct i2c_client *client = phy->i2c_dev;
-	struct gpio_desc *gpiod_en, *gpiod_fw;
 
-	gpiod_en = devm_gpiod_get_index(&client->dev, NULL, 2, GPIOD_OUT_LOW);
-	gpiod_fw = devm_gpiod_get_index(&client->dev, NULL, 1, GPIOD_OUT_LOW);
+	phy->gpiod_en = devm_gpiod_get_index(&client->dev, NULL, 2, GPIOD_OUT_LOW);
+	phy->gpiod_fw = devm_gpiod_get_index(&client->dev, NULL, 1, GPIOD_OUT_LOW);
 
-	if (IS_ERR(gpiod_en) || IS_ERR(gpiod_fw)) {
+	if (IS_ERR(phy->gpiod_en) || IS_ERR(phy->gpiod_fw)) {
 		nfc_err(&client->dev, "No GPIOs\n");
 		return -EINVAL;
 	}
 
-	phy->gpio_en = desc_to_gpio(gpiod_en);
-	phy->gpio_fw = desc_to_gpio(gpiod_fw);
-
 	return 0;
 }
 
@@ -342,24 +324,12 @@ static int nxp_nci_i2c_probe(struct i2c_client *client,
 		r = nxp_nci_i2c_acpi_config(phy);
 		if (r < 0)
 			goto probe_exit;
-		goto nci_probe;
 	} else {
 		nfc_err(&client->dev, "No platform data\n");
 		r = -EINVAL;
 		goto probe_exit;
 	}
 
-	r = devm_gpio_request_one(&phy->i2c_dev->dev, phy->gpio_en,
-				  GPIOF_OUT_INIT_LOW, "nxp_nci_en");
-	if (r < 0)
-		goto probe_exit;
-
-	r = devm_gpio_request_one(&phy->i2c_dev->dev, phy->gpio_fw,
-				  GPIOF_OUT_INIT_LOW, "nxp_nci_fw");
-	if (r < 0)
-		goto probe_exit;
-
-nci_probe:
 	r = nxp_nci_probe(phy, &client->dev, &i2c_phy_ops,
 			  NXP_NCI_I2C_MAX_PAYLOAD, &phy->ndev);
 	if (r < 0)
-- 
2.20.1

