Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 335994F2008
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Apr 2022 01:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240973AbiDDXNb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 4 Apr 2022 19:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245394AbiDDXLw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 4 Apr 2022 19:11:52 -0400
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B50B26FE
        for <linux-wireless@vger.kernel.org>; Mon,  4 Apr 2022 15:51:02 -0700 (PDT)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.7.67.121])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id CFE5C1A0068
        for <linux-wireless@vger.kernel.org>; Mon,  4 Apr 2022 22:51:00 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 98C4A4C009F
        for <linux-wireless@vger.kernel.org>; Mon,  4 Apr 2022 22:51:00 +0000 (UTC)
Received: from ben-dt4.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id 0A3EB13C2B0;
        Mon,  4 Apr 2022 15:51:00 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 0A3EB13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1649112660;
        bh=1iwDxC6ujRhg/xJSQNybtzQggExjPVsczveA7x69l/A=;
        h=From:To:Cc:Subject:Date:From;
        b=LDfHC9lTdZZ0sn2AXkN7hnrbWDcnKFB0vjV1saLoQZVlHhHEU+4Af9qKlD66Hj2N+
         PbcE11gZE8LHfxMmF7NlpAONU/E1ztW/8hWz5+/aGBZSefh58RDoqulZXzTD4+bSdZ
         THpKOQioTvEqJ3GOnrDobU76c5zQ/u0WVP4ZfUVE=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [PATCH 1/2] mt76: mt7915:  retry pci probe logic up to 3 times.
Date:   Mon,  4 Apr 2022 15:50:57 -0700
Message-Id: <20220404225058.32475-1-greearb@candelatech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1649112661-LnSlg-cs1YHA
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

On my x86-64 system with 6 mtk7915 radios, one or more radios
often fails to start upon reboot.  So, do up to 3 retries in
the pci probe logic.  Example of this mitigation working:

[    8.637908] mt7915e 0000:06:00.0: ASIC revision: 79150000
[    8.638026] mt7915e 0000:06:00.0: mt7915:  register_device  Driver-Version: 5.17.0-ct
[   28.863203] mt7915e 0000:06:00.0: MCU: Initial Failure: Message 00000010 (cid 10 ext_cid: 0 seq 1) timeout.  Last successful cmd: 0x0
[   28.873960] mt7915e 0000:06:00.0: Failed to get patch semaphore: -110
[   28.879141] mt7915e 0000:06:00.0: mcu-init: Failed to load firmware, err: -11
[   28.879143] mt7915e 0000:06:00.0: mt7915_register_device failed, ret: -11
[   28.884796] mt7915e 0000:06:00.0: mt7915_pci_probe had error on try 1/3, ret: -11
[   28.891161] mt7915e 0000:06:00.0: ASIC revision: 79150094
[   28.891261] mt7915e 0000:06:00.0: mt7915:  register_device  Driver-Version: 5.17.0-ct
[   29.022875] mt7915e 0000:06:00.0: HW/SW Version: 0x8a108a10, Build Time: 20211222184017a
[   29.033934] mt7915e 0000:06:00.0: WM Firmware Version: ____000000, Build Time: 20211222184052
[   29.051992] mt7915e 0000:06:00.0: WA Firmware Version: DEV_000000, Build Time: 20211222184111
[   29.446014] mt7915e 0000:06:00.0: mt7915_pci_probe succeeded on try 2/3

A quick test of traffic shows the radio works fine after recovery.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 .../net/wireless/mediatek/mt76/mt7915/pci.c   | 61 +++++++++++++------
 1 file changed, 44 insertions(+), 17 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/pci.c b/drivers/net/wireless/mediatek/mt76/mt7915/pci.c
index 6f819c41a4c4..07cb8a699b75 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/pci.c
@@ -92,8 +92,8 @@ static int mt7915_pci_hif2_probe(struct pci_dev *pdev)
 	return 0;
 }
 
-static int mt7915_pci_probe(struct pci_dev *pdev,
-			    const struct pci_device_id *id)
+static int _mt7915_pci_probe(struct pci_dev *pdev,
+			     const struct pci_device_id *id)
 {
 	struct mt7915_dev *dev;
 	struct mt76_dev *mdev;
@@ -101,20 +101,6 @@ static int mt7915_pci_probe(struct pci_dev *pdev,
 	int irq;
 	int ret;
 
-	ret = pcim_enable_device(pdev);
-	if (ret)
-		return ret;
-
-	ret = pcim_iomap_regions(pdev, BIT(0), pci_name(pdev));
-	if (ret)
-		return ret;
-
-	pci_set_master(pdev);
-
-	ret = dma_set_mask(&pdev->dev, DMA_BIT_MASK(32));
-	if (ret)
-		return ret;
-
 	mt76_pci_disable_aspm(pdev);
 
 	if (id->device == 0x7916 || id->device == 0x790a)
@@ -161,8 +147,11 @@ static int mt7915_pci_probe(struct pci_dev *pdev,
 	}
 
 	ret = mt7915_register_device(dev);
-	if (ret)
+	if (ret) {
+		dev_err(dev->mt76.dev, "mt7915_register_device failed, ret: %d",
+			ret);
 		goto free_hif2_irq;
+	}
 
 	return 0;
 
@@ -181,6 +170,44 @@ static int mt7915_pci_probe(struct pci_dev *pdev,
 	return ret;
 }
 
+static int mt7915_pci_probe(struct pci_dev *pdev,
+			     const struct pci_device_id *id)
+{
+	int z;
+	int ret;
+
+	ret = pcim_enable_device(pdev);
+	if (ret)
+		return ret;
+
+	ret = pcim_iomap_regions(pdev, BIT(0), pci_name(pdev));
+	if (ret)
+		return ret;
+
+	pci_set_master(pdev);
+
+	ret = dma_set_mask(&pdev->dev, DMA_BIT_MASK(32));
+	if (ret)
+		return ret;
+
+	for (z = 0; z<3; z++) {
+		ret = _mt7915_pci_probe(pdev, id);
+		if (ret) {
+			dev_err(&pdev->dev, "mt7915_pci_probe had error on try %d/3, ret: %d",
+			       z + 1, ret);
+		} else {
+			/* It is worth a message to let user know we succeeded if
+			 * earlier attempts failed.
+			 */
+			if (z > 0)
+				dev_info(&pdev->dev, "mt7915_pci_probe succeeded on try %d/3",
+					 z + 1);
+			break;
+		}
+	}
+	return ret;
+}
+
 static void mt7915_hif_remove(struct pci_dev *pdev)
 {
 	struct mt7915_hif *hif = pci_get_drvdata(pdev);
-- 
2.20.1

