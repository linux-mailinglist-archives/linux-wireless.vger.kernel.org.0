Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BEF71B442
	for <lists+linux-wireless@lfdr.de>; Mon, 13 May 2019 12:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729141AbfEMKoK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 May 2019 06:44:10 -0400
Received: from mga04.intel.com ([192.55.52.120]:54978 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728459AbfEMKoH (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 May 2019 06:44:07 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 May 2019 03:44:06 -0700
X-ExtLoop1: 1
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 13 May 2019 03:44:03 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 02B80725; Mon, 13 May 2019 13:43:59 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     =?UTF-8?q?Cl=C3=A9ment=20Perrochaud?= 
        <clement.perrochaud@effinnov.com>,
        Charles Gorand <charles.gorand@effinnov.com>,
        linux-nfc@lists.01.org, Samuel Ortiz <sameo@linux.intel.com>,
        linux-wireless@vger.kernel.org,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 12/12] NFC: nxp-nci: Convert to SPDX license tags
Date:   Mon, 13 May 2019 13:43:58 +0300
Message-Id: <20190513104358.59716-13-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190513104358.59716-1-andriy.shevchenko@linux.intel.com>
References: <20190513104358.59716-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Replace boiler plate licenses texts with the SPDX license
identifiers in the mei nfc files header.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/nfc/nxp-nci/core.c     | 13 +------------
 drivers/nfc/nxp-nci/firmware.c | 13 +------------
 drivers/nfc/nxp-nci/i2c.c      | 13 +------------
 3 files changed, 3 insertions(+), 36 deletions(-)

diff --git a/drivers/nfc/nxp-nci/core.c b/drivers/nfc/nxp-nci/core.c
index b0b6db81a5e8..643347cac007 100644
--- a/drivers/nfc/nxp-nci/core.c
+++ b/drivers/nfc/nxp-nci/core.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Generic driver for NXP NCI NFC chips
  *
@@ -7,18 +8,6 @@
  *
  * Derived from PN544 device driver:
  * Copyright (C) 2012  Intel Corporation. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU General Public License,
- * version 2, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #include <linux/delay.h>
diff --git a/drivers/nfc/nxp-nci/firmware.c b/drivers/nfc/nxp-nci/firmware.c
index e50c6f67bb39..231c93b3dc5f 100644
--- a/drivers/nfc/nxp-nci/firmware.c
+++ b/drivers/nfc/nxp-nci/firmware.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Generic driver for NXP NCI NFC chips
  *
@@ -7,18 +8,6 @@
  *
  * Derived from PN544 device driver:
  * Copyright (C) 2012  Intel Corporation. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU General Public License,
- * version 2, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #include <linux/completion.h>
diff --git a/drivers/nfc/nxp-nci/i2c.c b/drivers/nfc/nxp-nci/i2c.c
index 703f4c8fa751..69ab576ef438 100644
--- a/drivers/nfc/nxp-nci/i2c.c
+++ b/drivers/nfc/nxp-nci/i2c.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * I2C link layer for the NXP NCI driver
  *
@@ -9,18 +10,6 @@
  *
  * Derived from PN544 device driver:
  * Copyright (C) 2012  Intel Corporation. All rights reserved.
- *
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU General Public License,
- * version 2, as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 
 #include <linux/acpi.h>
-- 
2.20.1

