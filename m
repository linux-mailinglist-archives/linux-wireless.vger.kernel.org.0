Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4681B438
	for <lists+linux-wireless@lfdr.de>; Mon, 13 May 2019 12:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729096AbfEMKoD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 May 2019 06:44:03 -0400
Received: from mga04.intel.com ([192.55.52.120]:54978 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727849AbfEMKoC (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 May 2019 06:44:02 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 May 2019 03:44:02 -0700
X-ExtLoop1: 1
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 13 May 2019 03:44:00 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 5A2FB141; Mon, 13 May 2019 13:43:59 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     =?UTF-8?q?Cl=C3=A9ment=20Perrochaud?= 
        <clement.perrochaud@effinnov.com>,
        Charles Gorand <charles.gorand@effinnov.com>,
        linux-nfc@lists.01.org, Samuel Ortiz <sameo@linux.intel.com>,
        linux-wireless@vger.kernel.org,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 00/12] NFC: nxp-nci: clean up and support new ID
Date:   Mon, 13 May 2019 13:43:46 +0300
Message-Id: <20190513104358.59716-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

It has been reported that some laptops, equipped with NXP NFC300, have
different ID then mentioned in the driver.

While at it, I found that the driver has a lot of duplication and redundant
platform data. The rest of the series (11 out of 12 patches) is dedicated to
clean the driver up.

Sedat, would be nice if you can compile kernel with this patch series applied
and test on your laptop.

In v2:
- added new ID patch
- added new clean up patch
- Cc'ed to linux-wireless@ as well, since linux-nfc@ bounces my mails
- Cc'ed to the reported of the problem with T470 laptop

Andy Shevchenko (12):
  NFC: nxp-nci: Add NXP1001 to the ACPI ID table
  NFC: nxp-nci: Get rid of platform data
  NFC: nxp-nci: Convert to use GPIO descriptor
  NFC: nxp-nci: Add GPIO ACPI mapping table
  NFC: nxp-nci: Get rid of code duplication in ->probe()
  NFC: nxp-nci: Get rid of useless label
  NFC: nxp-nci: Constify acpi_device_id
  NFC: nxp-nci: Drop of_match_ptr() use
  NFC: nxp-nci: Drop comma in terminator lines
  NFC: nxp-nci: Remove unused macro pr_fmt()
  NFC: nxp-nci: Remove 'default n' for tests
  NFC: nxp-nci: Convert to SPDX license tags

 MAINTAINERS                           |   1 -
 drivers/nfc/nxp-nci/Kconfig           |   1 -
 drivers/nfc/nxp-nci/core.c            |  15 +--
 drivers/nfc/nxp-nci/firmware.c        |  13 +--
 drivers/nfc/nxp-nci/i2c.c             | 147 ++++++--------------------
 drivers/nfc/nxp-nci/nxp-nci.h         |   1 -
 include/linux/platform_data/nxp-nci.h |  27 -----
 7 files changed, 37 insertions(+), 168 deletions(-)
 delete mode 100644 include/linux/platform_data/nxp-nci.h

-- 
2.20.1

