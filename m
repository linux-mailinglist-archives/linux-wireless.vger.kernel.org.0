Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 381841B43A
	for <lists+linux-wireless@lfdr.de>; Mon, 13 May 2019 12:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729126AbfEMKoE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 May 2019 06:44:04 -0400
Received: from mga01.intel.com ([192.55.52.88]:43929 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728459AbfEMKoD (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 May 2019 06:44:03 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 May 2019 03:44:03 -0700
X-ExtLoop1: 1
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 13 May 2019 03:44:00 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 9263D430; Mon, 13 May 2019 13:43:59 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     =?UTF-8?q?Cl=C3=A9ment=20Perrochaud?= 
        <clement.perrochaud@effinnov.com>,
        Charles Gorand <charles.gorand@effinnov.com>,
        linux-nfc@lists.01.org, Samuel Ortiz <sameo@linux.intel.com>,
        linux-wireless@vger.kernel.org,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 04/12] NFC: nxp-nci: Add GPIO ACPI mapping table
Date:   Mon, 13 May 2019 13:43:50 +0300
Message-Id: <20190513104358.59716-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190513104358.59716-1-andriy.shevchenko@linux.intel.com>
References: <20190513104358.59716-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In order to unify GPIO resource request prepare gpiod_get_index()
to behave correctly when there is no mapping provided by firmware.

Here we add explicit mapping between _CRS GpioIo() resources and
their names used in the driver.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/nfc/nxp-nci/i2c.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/nfc/nxp-nci/i2c.c b/drivers/nfc/nxp-nci/i2c.c
index 6f61368ae065..9a65dd6cd405 100644
--- a/drivers/nfc/nxp-nci/i2c.c
+++ b/drivers/nfc/nxp-nci/i2c.c
@@ -258,6 +258,15 @@ static irqreturn_t nxp_nci_i2c_irq_thread_fn(int irq, void *phy_id)
 	return IRQ_NONE;
 }
 
+static const struct acpi_gpio_params firmware_gpios = { 1, 0, false };
+static const struct acpi_gpio_params enable_gpios = { 2, 0, false };
+
+static const struct acpi_gpio_mapping acpi_nxp_nci_gpios[] = {
+	{ "enable-gpios", &enable_gpios, 1 },
+	{ "firmware-gpios", &firmware_gpios, 1 },
+	{ }
+};
+
 static int nxp_nci_i2c_parse_devtree(struct i2c_client *client)
 {
 	struct nxp_nci_i2c_phy *phy = i2c_get_clientdata(client);
@@ -280,9 +289,14 @@ static int nxp_nci_i2c_parse_devtree(struct i2c_client *client)
 static int nxp_nci_i2c_acpi_config(struct nxp_nci_i2c_phy *phy)
 {
 	struct i2c_client *client = phy->i2c_dev;
+	int r;
 
-	phy->gpiod_en = devm_gpiod_get_index(&client->dev, NULL, 2, GPIOD_OUT_LOW);
-	phy->gpiod_fw = devm_gpiod_get_index(&client->dev, NULL, 1, GPIOD_OUT_LOW);
+	r = devm_acpi_dev_add_driver_gpios(&client->dev, acpi_nxp_nci_gpios);
+	if (r)
+		return r;
+
+	phy->gpiod_en = devm_gpiod_get(&client->dev, "enable", GPIOD_OUT_LOW);
+	phy->gpiod_fw = devm_gpiod_get(&client->dev, "firmware", GPIOD_OUT_LOW);
 
 	if (IS_ERR(phy->gpiod_en) || IS_ERR(phy->gpiod_fw)) {
 		nfc_err(&client->dev, "No GPIOs\n");
-- 
2.20.1

