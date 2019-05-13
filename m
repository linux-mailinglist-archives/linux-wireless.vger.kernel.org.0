Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E71021B43E
	for <lists+linux-wireless@lfdr.de>; Mon, 13 May 2019 12:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729139AbfEMKoH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 May 2019 06:44:07 -0400
Received: from mga05.intel.com ([192.55.52.43]:20725 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729132AbfEMKoG (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 May 2019 06:44:06 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 May 2019 03:44:05 -0700
X-ExtLoop1: 1
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 13 May 2019 03:44:04 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id AA3D1492; Mon, 13 May 2019 13:43:59 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     =?UTF-8?q?Cl=C3=A9ment=20Perrochaud?= 
        <clement.perrochaud@effinnov.com>,
        Charles Gorand <charles.gorand@effinnov.com>,
        linux-nfc@lists.01.org, Samuel Ortiz <sameo@linux.intel.com>,
        linux-wireless@vger.kernel.org,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 06/12] NFC: nxp-nci: Get rid of useless label
Date:   Mon, 13 May 2019 13:43:52 +0300
Message-Id: <20190513104358.59716-7-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190513104358.59716-1-andriy.shevchenko@linux.intel.com>
References: <20190513104358.59716-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Return directly in ->probe() since there no special cleaning is needed.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/nfc/nxp-nci/i2c.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/nfc/nxp-nci/i2c.c b/drivers/nfc/nxp-nci/i2c.c
index 9eeb59d1199a..6379f2198524 100644
--- a/drivers/nfc/nxp-nci/i2c.c
+++ b/drivers/nfc/nxp-nci/i2c.c
@@ -276,16 +276,13 @@ static int nxp_nci_i2c_probe(struct i2c_client *client,
 
 	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
 		nfc_err(&client->dev, "Need I2C_FUNC_I2C\n");
-		r = -ENODEV;
-		goto probe_exit;
+		return -ENODEV;
 	}
 
 	phy = devm_kzalloc(&client->dev, sizeof(struct nxp_nci_i2c_phy),
 			   GFP_KERNEL);
-	if (!phy) {
-		r = -ENOMEM;
-		goto probe_exit;
-	}
+	if (!phy)
+		return -ENOMEM;
 
 	phy->i2c_dev = client;
 	i2c_set_clientdata(client, phy);
@@ -309,7 +306,7 @@ static int nxp_nci_i2c_probe(struct i2c_client *client,
 	r = nxp_nci_probe(phy, &client->dev, &i2c_phy_ops,
 			  NXP_NCI_I2C_MAX_PAYLOAD, &phy->ndev);
 	if (r < 0)
-		goto probe_exit;
+		return r;
 
 	r = request_threaded_irq(client->irq, NULL,
 				 nxp_nci_i2c_irq_thread_fn,
@@ -318,7 +315,6 @@ static int nxp_nci_i2c_probe(struct i2c_client *client,
 	if (r < 0)
 		nfc_err(&client->dev, "Unable to register IRQ handler\n");
 
-probe_exit:
 	return r;
 }
 
-- 
2.20.1

