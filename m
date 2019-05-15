Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 915271F34E
	for <lists+linux-wireless@lfdr.de>; Wed, 15 May 2019 14:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729171AbfEOMM1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 May 2019 08:12:27 -0400
Received: from gauss.credativ.com ([93.94.130.89]:38863 "EHLO
        gauss.credativ.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727385AbfEOMMY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 May 2019 08:12:24 -0400
X-Greylist: delayed 564 seconds by postgrey-1.27 at vger.kernel.org; Wed, 15 May 2019 08:12:22 EDT
Received: from gauss.credativ.com (localhost [127.0.0.1])
        by gauss.credativ.com (Postfix) with ESMTP id EB9971E319C;
        Wed, 15 May 2019 14:02:54 +0200 (CEST)
Received: from iniza.credativ.lan (fw-front.credativ.com [62.154.226.94])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sdi@gauss.credativ.com)
        by gauss.credativ.com (Postfix) with ESMTPSA id C04CB1E1A54;
        Wed, 15 May 2019 14:02:54 +0200 (CEST)
From:   Sedat Dilek <sedat.dilek@credativ.de>
To:     Samuel Ortiz <sameo@linux.intel.com>,
        Charles Gorand <charles.gorand@effinnov.com>,
        =?UTF-8?q?Cl=C3=A9ment=20Perrochaud?= 
        <clement.perrochaud@effinnov.com>, linux-nfc@lists.01.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sedat Dilek <sedat.dilek@credativ.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: [PATCH 1/2] NFC: nxp-nci: Clarify on supported chips
Date:   Wed, 15 May 2019 14:02:33 +0200
Message-Id: <20190515120233.19159-1-sedat.dilek@credativ.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patch clarifies on the supported NXP NCI chips and families
and lists PN547 and PN548 separately which are known as NPC100
respectively NPC300.

This helps to find informations and identify drivers on vendor's
support websites.

This patch is on top of Andy Shevchenko's patchset:
"[PATCH v2 00/12] NFC: nxp-nci: clean up and support new ID"

For details see the discussion in [1] and [2].

I add the references to the linux-wireless mailing-list and patchwork
URLs as Linux NFC is marked orphan now (see commit "NFC: Orphan the
subsystem").

NOTE: Tested above patchset against Linux v5.1.1 and v5.1.2.

[1] https://marc.info/?t=155774435600001&r=1&w=2
[2] https://patchwork.kernel.org/project/linux-wireless/list/?submitter=33142
[3] https://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git/commit/?id=d0a7e8cb3c9d7d4fa2bcdd557be19f0841e2a3be

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Suggested-by: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Signed-off-by: Sedat Dilek <sedat.dilek@credativ.de>
---
 drivers/nfc/nxp-nci/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nfc/nxp-nci/Kconfig b/drivers/nfc/nxp-nci/Kconfig
index a28c4265354d..16473cfcb1d8 100644
--- a/drivers/nfc/nxp-nci/Kconfig
+++ b/drivers/nfc/nxp-nci/Kconfig
@@ -2,8 +2,8 @@ config NFC_NXP_NCI
 	tristate "NXP-NCI NFC driver"
 	depends on NFC_NCI
 	---help---
-	  Generic core driver for NXP NCI chips such as the NPC100
-	  or PN7150 families.
+	  Generic core driver for NXP NCI chips such as the NPC100 (PN547),
+	  NPC300 (PN548) or PN7150 families.
 	  This is a driver based on the NCI NFC kernel layers and
 	  will thus not work with NXP libnfc library.
 
-- 
2.20.1

