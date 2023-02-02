Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF041687CC8
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Feb 2023 12:58:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbjBBL6d (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 2 Feb 2023 06:58:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbjBBL6c (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 2 Feb 2023 06:58:32 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C64D38001A
        for <linux-wireless@vger.kernel.org>; Thu,  2 Feb 2023 03:58:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6E55A61AC3
        for <linux-wireless@vger.kernel.org>; Thu,  2 Feb 2023 11:58:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79B5DC433EF;
        Thu,  2 Feb 2023 11:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675339110;
        bh=aHIYVDB4QBzvaLw5nZhAS8dWTzidYBxnfIjidaH3gZE=;
        h=From:To:Cc:Subject:Date:From;
        b=uyPjx/mA827z8aOfycuIoPZ9fgC5/tyyhHaX+217L6jMoCCD4UMth1RTO2dxDPRwF
         PP8KxN4H2Ojndse/Aa4/ML02440U7QA5/BTTlpvYkJ/A/CB+g5yn/lgxoVCWihdrAP
         lJ1rBHvstWRzy48Ndq2TdfD4R0azaUsN07ElkWr0sOtqVNKQDCaCHF6HeyxgTr5TW8
         a65Pp3ZPGURzAb0ASL/cmLJwH2MiT5OACg+/v6uZA0V9C9oQBET1UXRN9+MZAw+R30
         ShE2B8MWX7dqjFq6DV2vQIhkfA6sXqptln7oq8lRwg9k+m+cO1wAXm3WMtWgTypZvV
         q5foIqGaj2FQg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org
Subject: [PATCH] wifi: mt76: mt76x0u: report firmware version through ethtool
Date:   Thu,  2 Feb 2023 12:58:23 +0100
Message-Id: <dbd95e7dd92a127103e2af4e6d122b4c54c07a97.1675338964.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Run mt76x02_set_ethtool_fwver utility routine in mt76x0u_load_firmware()
in order to report firmware version through ethtool

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76x0/usb_mcu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76x0/usb_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76x0/usb_mcu.c
index 45502fd4693f..6dc1f51f5658 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x0/usb_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x0/usb_mcu.c
@@ -148,6 +148,7 @@ static int mt76x0u_load_firmware(struct mt76x02_dev *dev)
 	mt76_wr(dev, MT_USB_DMA_CFG, val);
 
 	ret = mt76x0u_upload_firmware(dev, hdr);
+	mt76x02_set_ethtool_fwver(dev, hdr);
 	release_firmware(fw);
 
 	mt76_wr(dev, MT_FCE_PSE_CTRL, 1);
-- 
2.39.1

