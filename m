Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0E1A65A9DD
	for <lists+linux-wireless@lfdr.de>; Sun,  1 Jan 2023 12:53:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbjAALxp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 1 Jan 2023 06:53:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbjAALxo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 1 Jan 2023 06:53:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 904903897
        for <linux-wireless@vger.kernel.org>; Sun,  1 Jan 2023 03:53:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2898F60D2D
        for <linux-wireless@vger.kernel.org>; Sun,  1 Jan 2023 11:53:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3564AC433F1;
        Sun,  1 Jan 2023 11:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672574022;
        bh=ietCfeQjsD5D6tgi4L352UJjOh3jnY+LqpW/RypdV8I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N2jsiP5pYI0PtP1GIG6mh5jWglJWj9fTjQSczOeUN17Lz/RZYZPS5OhD6X4elfqca
         nK827VWfRQXeu7uznShyvwUZYMi6AqSeq84s+YijjYM+3nPq95PDs/7NrdG4XONgrD
         FWF0qYvhVGQrcl6pETJogzUEFJOGU0e+QfwUEn6jTHJ5j+w3bNUOwyyg/xP6e0v5/3
         c77e8Z28VaGYaFPeBHZ5DWIVRnFJ/SisXw6DwN6BSK5MWTyWCNEEhpa+zySMThnpMt
         zpYNqmGJ985xRQN3zocQIjgmVoitRDRqC6NwuMT7oX5t/MdFauAAS0GMkOejU13k5z
         9W2zFKns8MDBg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org
Subject: [PATCH 3/6] wifi: mt76: mt7615: avoid mcu_restart function pointer
Date:   Sun,  1 Jan 2023 12:53:20 +0100
Message-Id: <9bbf297fe9c3b0988733fad1a5fda77811b05318.1672573894.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1672573894.git.lorenzo@kernel.org>
References: <cover.1672573894.git.lorenzo@kernel.org>
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

Run mt7615_mcu_restart routine directly and avoid mcu_restart function
pointer whenever it is possible.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c      | 3 +--
 drivers/net/wireless/mediatek/mt76/mt7615/sdio_mcu.c | 1 -
 drivers/net/wireless/mediatek/mt76/mt7615/usb_mcu.c  | 1 -
 3 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 83f30305414d..eea398c79a98 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -1692,7 +1692,6 @@ int mt7615_mcu_init(struct mt7615_dev *dev)
 		.headroom = sizeof(struct mt7615_mcu_txd),
 		.mcu_skb_send_msg = mt7615_mcu_send_message,
 		.mcu_parse_response = mt7615_mcu_parse_response,
-		.mcu_restart = mt7615_mcu_restart,
 	};
 	int ret;
 
@@ -1732,7 +1731,7 @@ EXPORT_SYMBOL_GPL(mt7615_mcu_init);
 
 void mt7615_mcu_exit(struct mt7615_dev *dev)
 {
-	__mt76_mcu_restart(&dev->mt76);
+	mt7615_mcu_restart(&dev->mt76);
 	mt7615_mcu_set_fw_ctrl(dev);
 	skb_queue_purge(&dev->mt76.mcu.res_q);
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/sdio_mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/sdio_mcu.c
index dc9a2f0b45a5..b0094205ba95 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/sdio_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/sdio_mcu.c
@@ -137,7 +137,6 @@ int mt7663s_mcu_init(struct mt7615_dev *dev)
 		.tailroom = MT_USB_TAIL_SIZE,
 		.mcu_skb_send_msg = mt7663s_mcu_send_message,
 		.mcu_parse_response = mt7615_mcu_parse_response,
-		.mcu_restart = mt7615_mcu_restart,
 		.mcu_rr = mt76_connac_mcu_reg_rr,
 		.mcu_wr = mt76_connac_mcu_reg_wr,
 	};
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/usb_mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/usb_mcu.c
index 98bf2f6ae936..a8b1a0f8b2d7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/usb_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/usb_mcu.c
@@ -69,7 +69,6 @@ int mt7663u_mcu_init(struct mt7615_dev *dev)
 		.tailroom = MT_USB_TAIL_SIZE,
 		.mcu_skb_send_msg = mt7663u_mcu_send_message,
 		.mcu_parse_response = mt7615_mcu_parse_response,
-		.mcu_restart = mt7615_mcu_restart,
 	};
 	int ret;
 
-- 
2.38.1

