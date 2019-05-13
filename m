Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B71C1B43C
	for <lists+linux-wireless@lfdr.de>; Mon, 13 May 2019 12:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729134AbfEMKoG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 May 2019 06:44:06 -0400
Received: from mga12.intel.com ([192.55.52.136]:2829 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729125AbfEMKoF (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 May 2019 06:44:05 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 May 2019 03:44:05 -0700
X-ExtLoop1: 1
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 13 May 2019 03:44:03 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id D28374F8; Mon, 13 May 2019 13:43:59 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     =?UTF-8?q?Cl=C3=A9ment=20Perrochaud?= 
        <clement.perrochaud@effinnov.com>,
        Charles Gorand <charles.gorand@effinnov.com>,
        linux-nfc@lists.01.org, Samuel Ortiz <sameo@linux.intel.com>,
        linux-wireless@vger.kernel.org,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 09/12] NFC: nxp-nci: Drop comma in terminator lines
Date:   Mon, 13 May 2019 13:43:55 +0300
Message-Id: <20190513104358.59716-10-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190513104358.59716-1-andriy.shevchenko@linux.intel.com>
References: <20190513104358.59716-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

There is no need to have a comma after terminator entry
in the arrays of IDs.

This may prevent the misguided addition behind the terminator
without compiler notice.

Drop the comma in terminator lines for good.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/nfc/nxp-nci/i2c.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nfc/nxp-nci/i2c.c b/drivers/nfc/nxp-nci/i2c.c
index 69c98f2018e3..6114787e13a3 100644
--- a/drivers/nfc/nxp-nci/i2c.c
+++ b/drivers/nfc/nxp-nci/i2c.c
@@ -336,7 +336,7 @@ MODULE_DEVICE_TABLE(i2c, nxp_nci_i2c_id_table);
 
 static const struct of_device_id of_nxp_nci_i2c_match[] = {
 	{ .compatible = "nxp,nxp-nci-i2c", },
-	{},
+	{}
 };
 MODULE_DEVICE_TABLE(of, of_nxp_nci_i2c_match);
 
@@ -344,7 +344,7 @@ MODULE_DEVICE_TABLE(of, of_nxp_nci_i2c_match);
 static const struct acpi_device_id acpi_id[] = {
 	{ "NXP1001" },
 	{ "NXP7471" },
-	{ },
+	{ }
 };
 MODULE_DEVICE_TABLE(acpi, acpi_id);
 #endif
-- 
2.20.1

