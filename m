Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36FFD633E23
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Nov 2022 14:52:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233906AbiKVNwi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Nov 2022 08:52:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233959AbiKVNw2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Nov 2022 08:52:28 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C05F4BB4
        for <linux-wireless@vger.kernel.org>; Tue, 22 Nov 2022 05:52:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5772661711
        for <linux-wireless@vger.kernel.org>; Tue, 22 Nov 2022 13:52:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59B82C433C1;
        Tue, 22 Nov 2022 13:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669125146;
        bh=hrsIOpZeHK1YykWfNWYwhQVe6Rrlv8pF3P3npcxM7h0=;
        h=From:To:Cc:Subject:Date:From;
        b=dYDUvB9FPXoaysr4v6AdMSPXHUeN9NGwWrvzzNfN1z8QkfciqmfzyARzBT/GgXbA1
         +tLnZnH4LV0QKifTZ4YCN27GCvDUR7lQKqUTGeG7tlVKyCWINK+L1k4av6LJ51Lmsu
         u5aR68r1A2vG3TdLCf6aCeV9ERXS4Nf6tVGpSJ3c7VTO0+lv9zqePXQNrUaGeOOgNe
         YsyHJgYdAWgiGaiHPhM18ShqQo4Il2PKhjNdMDXVB6DO9hEvDnVXnLyCAe0DP0meRU
         H9SPIIhA9/vDtPqP1P5USbFWU+qdhWrwgATyVQ1svOm3sV8aMJxVGWCUv9e+vgx6pv
         wmU4VJPYuEwCg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: [PATCH] wifi: mt76: mt76x0: remove dead code in mt76x0_phy_get_target_power
Date:   Tue, 22 Nov 2022 14:52:08 +0100
Message-Id: <6d2455d7a112dc316911d14c72d9c6345b7f21ff.1669125082.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tx_rate can't be greater than 3 in mt76x0_phy_get_target_power routine
for cck rates. Get rid of dead code.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76x0/phy.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76x0/phy.c b/drivers/net/wireless/mediatek/mt76/mt76x0/phy.c
index 8a89fe49db36..6c6c8ada7943 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x0/phy.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x0/phy.c
@@ -595,9 +595,6 @@ mt76x0_phy_get_target_power(struct mt76x02_dev *dev, u8 tx_mode,
 	case 0:
 		/* cck rates */
 		tx_rate = (info[0] & 0x60) >> 5;
-		if (tx_rate > 3)
-			return -EINVAL;
-
 		*target_power = cur_power + dev->rate_power.cck[tx_rate];
 		*target_pa_power = mt76x0_phy_get_rf_pa_mode(dev, 0, tx_rate);
 		break;
-- 
2.38.1

