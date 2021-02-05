Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB36E310542
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Feb 2021 07:57:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbhBEG5q (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 5 Feb 2021 01:57:46 -0500
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:42143 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231328AbhBEG5i (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 5 Feb 2021 01:57:38 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=alimailimapcm10staff010182156082;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0UNwO2eU_1612508200;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0UNwO2eU_1612508200)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 05 Feb 2021 14:56:45 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     m@bues.ch
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] ssb: Use true and false for bool variable
Date:   Fri,  5 Feb 2021 14:56:39 +0800
Message-Id: <1612508199-92282-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix the following coccicheck warnings:

./include/linux/ssb/ssb_driver_gige.h:89:8-9: WARNING: return of 0/1 in
function 'ssb_gige_one_dma_at_once' with return type bool.

./include/linux/ssb/ssb_driver_gige.h:79:8-9: WARNING: return of 0/1 in
function 'ssb_gige_have_roboswitch' with return type bool.

./include/linux/ssb/ssb_driver_gige.h:182:8-9: WARNING: return of 0/1 in
function 'ssb_gige_must_flush_posted_writes' with return type bool.

./include/linux/ssb/ssb_driver_gige.h:178:8-9: WARNING: return of 0/1 in
function 'ssb_gige_one_dma_at_once' with return type bool.

./include/linux/ssb/ssb_driver_gige.h:174:8-9: WARNING: return of 0/1 in
function 'ssb_gige_have_roboswitch' with return type bool.

./include/linux/ssb/ssb_driver_gige.h:170:8-9: WARNING: return of 0/1 in
function 'ssb_gige_is_rgmii' with return type bool.

./include/linux/ssb/ssb_driver_gige.h:162:8-9: WARNING: return of 0/1 in
function 'pdev_is_ssb_gige_core' with return type bool.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 include/linux/ssb/ssb_driver_gige.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/linux/ssb/ssb_driver_gige.h b/include/linux/ssb/ssb_driver_gige.h
index 31593b3..15ba0df 100644
--- a/include/linux/ssb/ssb_driver_gige.h
+++ b/include/linux/ssb/ssb_driver_gige.h
@@ -76,7 +76,7 @@ static inline bool ssb_gige_have_roboswitch(struct pci_dev *pdev)
 	if (dev)
 		return !!(dev->dev->bus->sprom.boardflags_lo &
 			  SSB_GIGE_BFL_ROBOSWITCH);
-	return 0;
+	return false;
 }
 
 /* Returns whether we can only do one DMA at once. */
@@ -86,7 +86,7 @@ static inline bool ssb_gige_one_dma_at_once(struct pci_dev *pdev)
 	if (dev)
 		return ((dev->dev->bus->chip_id == 0x4785) &&
 			(dev->dev->bus->chip_rev < 2));
-	return 0;
+	return false;
 }
 
 /* Returns whether we must flush posted writes. */
@@ -159,7 +159,7 @@ static inline void ssb_gige_exit(void)
 
 static inline bool pdev_is_ssb_gige_core(struct pci_dev *pdev)
 {
-	return 0;
+	return false;
 }
 static inline struct ssb_gige * pdev_to_ssb_gige(struct pci_dev *pdev)
 {
@@ -167,19 +167,19 @@ static inline struct ssb_gige * pdev_to_ssb_gige(struct pci_dev *pdev)
 }
 static inline bool ssb_gige_is_rgmii(struct pci_dev *pdev)
 {
-	return 0;
+	return false;
 }
 static inline bool ssb_gige_have_roboswitch(struct pci_dev *pdev)
 {
-	return 0;
+	return false;
 }
 static inline bool ssb_gige_one_dma_at_once(struct pci_dev *pdev)
 {
-	return 0;
+	return false;
 }
 static inline bool ssb_gige_must_flush_posted_writes(struct pci_dev *pdev)
 {
-	return 0;
+	return false;
 }
 static inline int ssb_gige_get_macaddr(struct pci_dev *pdev, u8 *macaddr)
 {
-- 
1.8.3.1

