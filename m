Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB3FD1B43D
	for <lists+linux-wireless@lfdr.de>; Mon, 13 May 2019 12:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbfEMKoH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 May 2019 06:44:07 -0400
Received: from mga05.intel.com ([192.55.52.43]:20725 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729125AbfEMKoG (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 May 2019 06:44:06 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 May 2019 03:44:05 -0700
X-ExtLoop1: 1
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 13 May 2019 03:44:04 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id EB579709; Mon, 13 May 2019 13:43:59 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     =?UTF-8?q?Cl=C3=A9ment=20Perrochaud?= 
        <clement.perrochaud@effinnov.com>,
        Charles Gorand <charles.gorand@effinnov.com>,
        linux-nfc@lists.01.org, Samuel Ortiz <sameo@linux.intel.com>,
        linux-wireless@vger.kernel.org,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 11/12] NFC: nxp-nci: Remove 'default n' for tests
Date:   Mon, 13 May 2019 13:43:57 +0300
Message-Id: <20190513104358.59716-12-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190513104358.59716-1-andriy.shevchenko@linux.intel.com>
References: <20190513104358.59716-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

It seems contributors follow the style of Kconfig entries where explicit
'default n' is present.  The default 'default' is 'n' already, thus, drop
these lines from Kconfig to make it more clear.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/nfc/nxp-nci/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/nfc/nxp-nci/Kconfig b/drivers/nfc/nxp-nci/Kconfig
index 37b40612520d..a28c4265354d 100644
--- a/drivers/nfc/nxp-nci/Kconfig
+++ b/drivers/nfc/nxp-nci/Kconfig
@@ -1,7 +1,6 @@
 config NFC_NXP_NCI
 	tristate "NXP-NCI NFC driver"
 	depends on NFC_NCI
-	default n
 	---help---
 	  Generic core driver for NXP NCI chips such as the NPC100
 	  or PN7150 families.
-- 
2.20.1

