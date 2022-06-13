Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B26E9549980
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jun 2022 19:06:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239643AbiFMRGY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Jun 2022 13:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240834AbiFMRF5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Jun 2022 13:05:57 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43A6BEACC9
        for <linux-wireless@vger.kernel.org>; Mon, 13 Jun 2022 05:07:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 5CAD4CE1177
        for <linux-wireless@vger.kernel.org>; Mon, 13 Jun 2022 12:07:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B212DC36B0B;
        Mon, 13 Jun 2022 12:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655122034;
        bh=LktYqRqF2oFABXpYCYBZEKxpFBn0kXZjpYr52KKMTGA=;
        h=From:To:Cc:Subject:Date:From;
        b=DQD+/y0rSuD30ZiUp38S8mrxWvKKoQd7ZdWqhf0sFKXyCVc12JdRo0XvN6d5bnexI
         lEa5PbW3lBf1zZUm+78HdgGMxEa3FRvqr6pL7HEnPn7sFweRgICNq2VcicSs79WxPL
         gvuz7CLURMtL46RAmeC/zYPwwOFEGTOiqnnfM0S1iz5clfsUjNTnN9Ml+EevRBp87o
         mIAaYepZpXqtNz5dW/vYz1txWtNLPcvXSa/jh5hPW/vS8Ocr7+Ll254fiirlHAqnFv
         +G/9V4FaFLNhUQwCC/ut5CcBplOnLCl+2V0i1ui/LdRB4K42nNDrrT6f/Xtq3dWZKY
         mafZHzZysqKRA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: [PATCH] mt76: mt7921: do not update pm states in case of error
Date:   Mon, 13 Jun 2022 14:07:08 +0200
Message-Id: <7e928b3d6dd453b9d4a2e5d25bd53d40e0fdfb95.1655121981.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Do not update pm stats if mt7921e_mcu_fw_pmctrl routine returns an
error.

Fixes: 36873246f78a2 ("mt76: mt7921: add awake and doze time accounting")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7921/pci_mcu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci_mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci_mcu.c
index 36669e5aeef3..a1ab5f878f81 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/pci_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci_mcu.c
@@ -102,7 +102,7 @@ int mt7921e_mcu_fw_pmctrl(struct mt7921_dev *dev)
 {
 	struct mt76_phy *mphy = &dev->mt76.phy;
 	struct mt76_connac_pm *pm = &dev->pm;
-	int i, err = 0;
+	int i;
 
 	for (i = 0; i < MT7921_DRV_OWN_RETRY_COUNT; i++) {
 		mt76_wr(dev, MT_CONN_ON_LPCTL, PCIE_LPCR_HOST_SET_OWN);
@@ -114,12 +114,12 @@ int mt7921e_mcu_fw_pmctrl(struct mt7921_dev *dev)
 	if (i == MT7921_DRV_OWN_RETRY_COUNT) {
 		dev_err(dev->mt76.dev, "firmware own failed\n");
 		clear_bit(MT76_STATE_PM, &mphy->state);
-		err = -EIO;
+		return -EIO;
 	}
 
 	pm->stats.last_doze_event = jiffies;
 	pm->stats.awake_time += pm->stats.last_doze_event -
 				pm->stats.last_wake_event;
 
-	return err;
+	return 0;
 }
-- 
2.36.1

