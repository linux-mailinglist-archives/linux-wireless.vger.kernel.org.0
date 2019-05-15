Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19A161F340
	for <lists+linux-wireless@lfdr.de>; Wed, 15 May 2019 14:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729144AbfEOMM0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 May 2019 08:12:26 -0400
Received: from gauss.credativ.com ([93.94.130.89]:38862 "EHLO
        gauss.credativ.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728696AbfEOMMY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 May 2019 08:12:24 -0400
Received: from gauss.credativ.com (localhost [127.0.0.1])
        by gauss.credativ.com (Postfix) with ESMTP id 6D2091E3470;
        Wed, 15 May 2019 14:04:16 +0200 (CEST)
Received: from iniza.credativ.lan (fw-front.credativ.com [62.154.226.94])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sdi@gauss.credativ.com)
        by gauss.credativ.com (Postfix) with ESMTPSA id 466211E1A54;
        Wed, 15 May 2019 14:04:16 +0200 (CEST)
From:   Sedat Dilek <sedat.dilek@credativ.de>
To:     =?UTF-8?q?Cl=C3=A9ment=20Perrochaud?= 
        <clement.perrochaud@effinnov.com>,
        Charles Gorand <charles.gorand@effinnov.com>,
        Samuel Ortiz <sameo@linux.intel.com>, linux-nfc@lists.01.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sedat Dilek <sedat.dilek@credativ.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: [PATCH 2/2] NFC: nxp-nci: Fix recommendation for NFC_NXP_NCI_I2C Kconfig
Date:   Wed, 15 May 2019 14:04:07 +0200
Message-Id: <20190515120407.19227-1-sedat.dilek@credativ.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This is a simple cleanup to the Kconfig help text as discussed in [1].

[1] https://marc.info/?t=155774435600001&r=1&w=2

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Suggested-by: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Signed-off-by: Sedat Dilek <sedat.dilek@credativ.de>
---
 drivers/nfc/nxp-nci/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nfc/nxp-nci/Kconfig b/drivers/nfc/nxp-nci/Kconfig
index 16473cfcb1d8..a38c426452ca 100644
--- a/drivers/nfc/nxp-nci/Kconfig
+++ b/drivers/nfc/nxp-nci/Kconfig
@@ -21,4 +21,4 @@ config NFC_NXP_NCI_I2C
 
 	  To compile this driver as a module, choose m here. The module will
 	  be called nxp_nci_i2c.
-	  Say Y if unsure.
+	  Say N if unsure.
-- 
2.20.1

