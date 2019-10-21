Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8B72DF4D0
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Oct 2019 20:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728185AbfJUSH1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Oct 2019 14:07:27 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46468 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbfJUSH1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Oct 2019 14:07:27 -0400
Received: by mail-pf1-f194.google.com with SMTP id q5so8889948pfg.13;
        Mon, 21 Oct 2019 11:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KbHCUVncfbVXzjoVKRZ8xqvM9JfSFpXWmdqMW9SfaRQ=;
        b=AzBfPCx1mtbp3iuy/W5OD0UDNgvG4jUT19hQfYJ4VVhIEI3NaBv/3+aprYHzZWKxru
         4UzwF8F5+xwyfAUIkhs6BA+joBq0c4P5pRUeO5ar4i7B0zpg/EvvKYU0na09vL0sw0OW
         jpJyCxQKZDmMfGE6iFga6aXe5QuBu/1wuCBeNlhY/3yaDVdNqvfHcdmAC0vnwzK50PtP
         iWNGlvuJoaMoIqszWxRRc3X0fOE2AB/jrDcYZurE3mI+rh0RxmEZdy6o/m+xfEmbCivW
         C+/RFYSclGNMO2TBjiQfix+3/W4CSYYRKv7/EoE3XgXJv+tD+o9VJg2l+FaI8r9VXmhA
         HyXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KbHCUVncfbVXzjoVKRZ8xqvM9JfSFpXWmdqMW9SfaRQ=;
        b=O21t3HwifA1BDD1J/XLPvEVPV9wNbEFX0z7zIVfM7y6sqn3N8cAjVqLhy8GSlQEQFe
         fGB5DXcllE/nnZxoBC6x0TLvBdUDZMdl4Ct3059PT3H3NzWLXm6+MmQ8X3H3drxb8WZW
         5aOs6xGu9KQA+7i9XTke0rkIFos3qCTq7Pxz7zQlbY7bFIMAObMDWu9S2cTb3OU1hwJm
         NZ27VAIzMbLlF5QdLweEC1vvA6g4LY0pSSsXbu303SrCXvrzJMHD08pDwAQHEAxzfK6L
         dB1BoL91N5gofQckNNa/qIEIk2dUnNSqp/YrGq2K8v/DyCVTJZ3b6WPbrNzfzuNbhXOL
         N8+A==
X-Gm-Message-State: APjAAAVSnJlYE5ooZPshy0X5sVpnSdH5G8RPk7dc9PFwiNV/BeB3ATgr
        5cplukKnYT6Cxx+WkCJEymZ6xKMYjGs=
X-Google-Smtp-Source: APXvYqz4ol6E1J9UjCRv3ntNUDsTxd5HsAkUIbQ7RTpcxDNl9LJKdS8DuSVmyHX3xgxsAfYCP6r7KA==
X-Received: by 2002:a62:ae06:: with SMTP id q6mr24361988pff.96.1571681246647;
        Mon, 21 Oct 2019 11:07:26 -0700 (PDT)
Received: from localhost.localdomain ([124.253.151.72])
        by smtp.googlemail.com with ESMTPSA id ep10sm31335388pjb.2.2019.10.21.11.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2019 11:07:26 -0700 (PDT)
From:   Yadav Lamichhane <tuxomega1@gmail.com>
To:     tuxomega1@gmail.com
Cc:     zajec5@gmail.com, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] BCMA: driver_chipcommon_pmu: fixed a block comment coding style.
Date:   Mon, 21 Oct 2019 23:35:13 +0530
Message-Id: <20191021180513.2106-1-tuxomega1@gmail.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fixed a coding style issue.

Signed-off-by: Yadav Lamichhane <tuxomega1@gmail.com>
---
 drivers/bcma/driver_chipcommon_pmu.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/bcma/driver_chipcommon_pmu.c b/drivers/bcma/driver_chipcommon_pmu.c
index f4161064365c..3056f81efca4 100644
--- a/drivers/bcma/driver_chipcommon_pmu.c
+++ b/drivers/bcma/driver_chipcommon_pmu.c
@@ -233,8 +233,10 @@ static void bcma_pmu_workarounds(struct bcma_drv_cc *cc)
 
 	switch (bus->chipinfo.id) {
 	case BCMA_CHIP_ID_BCM4313:
-		/* enable 12 mA drive strenth for 4313 and set chipControl
-		   register bit 1 */
+		/*
+		 * enable 12 mA drive strenth for 4313 and set chipControl
+		 * register bit 1
+		 */
 		bcma_chipco_chipctl_maskset(cc, 0,
 					    ~BCMA_CCTRL_4313_12MA_LED_DRIVE,
 					    BCMA_CCTRL_4313_12MA_LED_DRIVE);
@@ -246,8 +248,10 @@ static void bcma_pmu_workarounds(struct bcma_drv_cc *cc)
 		break;
 	case BCMA_CHIP_ID_BCM43224:
 	case BCMA_CHIP_ID_BCM43421:
-		/* enable 12 mA drive strenth for 43224 and set chipControl
-		   register bit 15 */
+		/*
+		 * enable 12 mA drive strenth for 43224 and set chipControl
+		 * register bit 15
+		 */
 		if (bus->chipinfo.rev == 0) {
 			bcma_cc_maskset32(cc, BCMA_CC_CHIPCTL,
 					  ~BCMA_CCTRL_43224_GPIO_TOGGLE,
@@ -500,8 +504,10 @@ void bcma_pmu_spuravoid_pllupdate(struct bcma_drv_cc *cc, int spuravoid)
 	case BCMA_CHIP_ID_BCM53572:
 		/* 5357[ab]0, 43236[ab]0, and 6362b0 */
 
-		/* BCM5357 needs to touch PLL1_PLLCTL[02],
-		   so offset PLL0_PLLCTL[02] by 6 */
+		/*
+		 * BCM5357 needs to touch PLL1_PLLCTL[02],
+		 * so offset PLL0_PLLCTL[02] by 6
+		 */
 		phypll_offset = (bus->chipinfo.id == BCMA_CHIP_ID_BCM5357 ||
 		       bus->chipinfo.id == BCMA_CHIP_ID_BCM4749 ||
 		       bus->chipinfo.id == BCMA_CHIP_ID_BCM53572) ? 6 : 0;
@@ -619,8 +625,10 @@ void bcma_pmu_spuravoid_pllupdate(struct bcma_drv_cc *cc, int spuravoid)
 	case BCMA_CHIP_ID_BCM43228:
 	case BCMA_CHIP_ID_BCM43428:
 		/* LCNXN */
-		/* PLL Settings for spur avoidance on/off mode,
-		   no on2 support for 43228A0 */
+		/*
+		 * PLL Settings for spur avoidance on/off mode,
+		 * no on2 support for 43228A0
+		 */
 		if (spuravoid == 1) {
 			bcma_pmu_spuravoid_pll_write(cc, BCMA_CC_PMU_PLL_CTL0,
 						     0x01100014);
-- 
2.21.0

