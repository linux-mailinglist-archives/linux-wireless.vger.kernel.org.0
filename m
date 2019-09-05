Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78B1EAA8C7
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Sep 2019 18:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731437AbfIEQUv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Sep 2019 12:20:51 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:40276 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726263AbfIEQUv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Sep 2019 12:20:51 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1i5uV7-0004Fz-BA; Thu, 05 Sep 2019 16:20:49 +0000
From:   Colin King <colin.king@canonical.com>
To:     =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
        linux-wireless@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] bcma: make arrays pwr_info_offset and sprom_sizes static const, shrinks object size
Date:   Thu,  5 Sep 2019 17:20:49 +0100
Message-Id: <20190905162049.14333-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Arrays pwr_info_offset and sprom_sizes can be make static const rather
than populating them on the stack. Shrinks object size by 236 bytes.

Before:
   text	   data	    bss	    dec	    hex	filename
  11300	   1320	     64	  12684	   318c	drivers/bcma/sprom.o

After:
   text	   data	    bss	    dec	    hex	filename
  10904	   1480	     64	  12448	   30a0	drivers/bcma/sprom.o

(gcc version 9.2.1, amd64)

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/bcma/sprom.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/bcma/sprom.c b/drivers/bcma/sprom.c
index 206edd3ba668..bd2c923a6586 100644
--- a/drivers/bcma/sprom.c
+++ b/drivers/bcma/sprom.c
@@ -222,7 +222,7 @@ static void bcma_sprom_extract_r8(struct bcma_bus *bus, const u16 *sprom)
 {
 	u16 v, o;
 	int i;
-	u16 pwr_info_offset[] = {
+	static const u16 pwr_info_offset[] = {
 		SSB_SROM8_PWR_INFO_CORE0, SSB_SROM8_PWR_INFO_CORE1,
 		SSB_SROM8_PWR_INFO_CORE2, SSB_SROM8_PWR_INFO_CORE3
 	};
@@ -578,9 +578,11 @@ int bcma_sprom_get(struct bcma_bus *bus)
 {
 	u16 offset = BCMA_CC_SPROM;
 	u16 *sprom;
-	size_t sprom_sizes[] = { SSB_SPROMSIZE_WORDS_R4,
-				 SSB_SPROMSIZE_WORDS_R10,
-				 SSB_SPROMSIZE_WORDS_R11, };
+	static const size_t sprom_sizes[] = {
+		SSB_SPROMSIZE_WORDS_R4,
+		SSB_SPROMSIZE_WORDS_R10,
+		SSB_SPROMSIZE_WORDS_R11,
+	};
 	int i, err = 0;
 
 	if (!bus->drv_cc.core)
-- 
2.20.1

