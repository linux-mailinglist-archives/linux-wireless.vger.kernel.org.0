Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6DA92ABCC1
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Sep 2019 17:41:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391707AbfIFPkz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 6 Sep 2019 11:40:55 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:50329 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731817AbfIFPkz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 6 Sep 2019 11:40:55 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1i6GM1-00042X-PR; Fri, 06 Sep 2019 15:40:53 +0000
From:   Colin King <colin.king@canonical.com>
To:     Michael Buesch <m@bues.ch>, linux-wireless@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ssb: make array pwr_info_offset static const, makes object smaller
Date:   Fri,  6 Sep 2019 16:40:53 +0100
Message-Id: <20190906154053.32218-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Don't populate the array pwr_info_offset on the stack but instead make it
static const. Makes the object code smaller by 207 bytes.

Before:
   text	   data	    bss	    dec	    hex	filename
  26066	   3000	     64	  29130	   71ca	drivers/ssb/pci.o

After:
   text	   data	    bss	    dec	    hex	filename
  25763	   3096	     64	  28923	   70fb	drivers/ssb/pci.o

(gcc version 9.2.1, amd64)

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/ssb/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ssb/pci.c b/drivers/ssb/pci.c
index da2d2ab8104d..7c3ae52f2b15 100644
--- a/drivers/ssb/pci.c
+++ b/drivers/ssb/pci.c
@@ -595,7 +595,7 @@ static void sprom_extract_r8(struct ssb_sprom *out, const u16 *in)
 {
 	int i;
 	u16 o;
-	u16 pwr_info_offset[] = {
+	static const u16 pwr_info_offset[] = {
 		SSB_SROM8_PWR_INFO_CORE0, SSB_SROM8_PWR_INFO_CORE1,
 		SSB_SROM8_PWR_INFO_CORE2, SSB_SROM8_PWR_INFO_CORE3
 	};
-- 
2.20.1

