Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B687D549041
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Jun 2022 18:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386609AbiFMO7V (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Jun 2022 10:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352893AbiFMO5W (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Jun 2022 10:57:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE7E7DA60C
        for <linux-wireless@vger.kernel.org>; Mon, 13 Jun 2022 05:00:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4412260DC5
        for <linux-wireless@vger.kernel.org>; Mon, 13 Jun 2022 12:00:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAEA7C3411B;
        Mon, 13 Jun 2022 12:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655121651;
        bh=OMBoTUkoPXpaCnMes97pC4v5xZ5nJPconQzzqHwSPWs=;
        h=From:To:Cc:Subject:Date:From;
        b=oeJjJm2QSmSqQYBauL7/jNZYCYJuaOklsLX/v1NnE7PBd22o1VD4C+ivT7PqW+g8Y
         Xk+5KLhDofmf5mhxN6jdkh3UOmHUrafHWs8GKgi4D5blL1pvuJafddtFEMz0U+yR0M
         TrKRGFVINznFiGwu+y7OEWcGJLD+/gHnnEzQUkMUC5aeaGODb//CNojPXwCbc8uq/A
         k+80uFNmOwnB/bCzu9uRHdQH9JnrV0T/qQTbBFuCWZwcbevqLbPw9T3puEZU0EwnfY
         yAvwWUYKsXxv4DHbVu2dSszW5PkJmaqT3ihvCvfBZ3LKPShfVSWROy11azT0NdHPAP
         Tv3F+QCib+afQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH] mt76: mt7921s: remove unnecessary goto in mt7921s_mcu_drv_pmctrl
Date:   Mon, 13 Jun 2022 14:00:44 +0200
Message-Id: <8629a5e98d7dfbf88aae667e7f5aefbe5dd5b24f.1655121565.git.lorenzo@kernel.org>
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

Get rid of unnecessary goto in mt7921s_mcu_drv_pmctrl routine.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7921/sdio_mcu.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/sdio_mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/sdio_mcu.c
index 54a5c712a3c3..04cdebaec521 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/sdio_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/sdio_mcu.c
@@ -99,8 +99,8 @@ int mt7921s_mcu_drv_pmctrl(struct mt7921_dev *dev)
 	struct sdio_func *func = dev->mt76.sdio.func;
 	struct mt76_phy *mphy = &dev->mt76.phy;
 	struct mt76_connac_pm *pm = &dev->pm;
-	int err = 0;
 	u32 status;
+	int err;
 
 	sdio_claim_host(func);
 
@@ -118,8 +118,7 @@ int mt7921s_mcu_drv_pmctrl(struct mt7921_dev *dev)
 
 	if (err < 0) {
 		dev_err(dev->mt76.dev, "driver own failed\n");
-		err = -EIO;
-		goto out;
+		return -EIO;
 	}
 
 	clear_bit(MT76_STATE_PM, &mphy->state);
@@ -127,8 +126,8 @@ int mt7921s_mcu_drv_pmctrl(struct mt7921_dev *dev)
 	pm->stats.last_wake_event = jiffies;
 	pm->stats.doze_time += pm->stats.last_wake_event -
 			       pm->stats.last_doze_event;
-out:
-	return err;
+
+	return 0;
 }
 
 int mt7921s_mcu_fw_pmctrl(struct mt7921_dev *dev)
-- 
2.36.1

