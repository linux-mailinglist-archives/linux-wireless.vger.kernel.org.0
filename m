Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE734C7934
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Feb 2022 20:59:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbiB1Tws (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Feb 2022 14:52:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbiB1Twi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Feb 2022 14:52:38 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0DAA113DB5
        for <linux-wireless@vger.kernel.org>; Mon, 28 Feb 2022 11:51:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6E020615A8
        for <linux-wireless@vger.kernel.org>; Mon, 28 Feb 2022 19:39:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD737C340F2;
        Mon, 28 Feb 2022 19:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646077177;
        bh=/noxoNFKxCG1m6vrumaA850hbRpf1X8dMT8IzctwXLk=;
        h=From:To:Cc:Subject:Date:From;
        b=SgqIBJ2V3K0HEfKGmCjKsE1LPX4AfBLdZsBjjD41FXwstv4V7gJrcPsOgJ7C2MiOt
         fslHmSZdLU1awU9R2eruTBeg0EPthBipCFlxhqUvC+ZMfcxrSc5ySg9IDz39CkKs18
         AP4XlVLP6iX9RUgA4Y/lRgf4mzKrQWBw2OTPmhvCSzCy3xjjaFtfARtTlUULd89Zyg
         P0VaxDuusIDmapAm7s50W7yZ74CLhZz/9cgI6bub806kSZ6zFSfGKe255cpFJDoctX
         AY8gfCoqS7J4N7tbdts9vJtE71KKB7GRCXzS+yl7upVM9Zb508/oOHWN/ckvP3IKxU
         /KNSy74yV3O2Q==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: [PATCH] mt76: mt7615: honor ret from mt7615_mcu_restart in mt7663u_mcu_init
Date:   Mon, 28 Feb 2022 20:39:28 +0100
Message-Id: <3fb7d913cb65ac268bad120b696c143e9364a146.1646077040.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Check return value of mt7615_mcu_restart routine in mt7663u_mcu_init().

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/usb_mcu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/usb_mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/usb_mcu.c
index 0ebb4c3c336a..b560d0db6a92 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/usb_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/usb_mcu.c
@@ -57,7 +57,10 @@ int mt7663u_mcu_init(struct mt7615_dev *dev)
 
 	mt76_set(dev, MT_UDMA_TX_QSEL, MT_FW_DL_EN);
 	if (test_and_clear_bit(MT76_STATE_POWER_OFF, &dev->mphy.state)) {
-		mt7615_mcu_restart(&dev->mt76);
+		ret = mt7615_mcu_restart(&dev->mt76);
+		if (ret)
+			return ret;
+
 		if (!mt76_poll_msec(dev, MT_CONN_ON_MISC,
 				    MT_TOP_MISC2_FW_PWR_ON, 0, 500))
 			return -EIO;
-- 
2.35.1

