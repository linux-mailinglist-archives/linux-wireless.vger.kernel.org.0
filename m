Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1225E65A9DE
	for <lists+linux-wireless@lfdr.de>; Sun,  1 Jan 2023 12:53:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbjAALxu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 1 Jan 2023 06:53:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbjAALxs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 1 Jan 2023 06:53:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D61426DF
        for <linux-wireless@vger.kernel.org>; Sun,  1 Jan 2023 03:53:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EF2D460DBB
        for <linux-wireless@vger.kernel.org>; Sun,  1 Jan 2023 11:53:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F723C433F1;
        Sun,  1 Jan 2023 11:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672574026;
        bh=VlicA5pRm9FPXztodxfd7lmvBZraQWf45kNTGX/lDDw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o2sdadoQJozJi82tcE400vnPTl0depVumUOD3el0AqFP/JEL9nCUz/Mmi8P9sMIex
         Lf7Hxawx60wqW3Skzd+7ys4ZJcwzQYLlyX7ujxYdLoUGOkt/1H7cXtooA55A+FLovz
         i1HtiQdzKkVs7l0q5Dd/Y7xZ1852Icx6fg3fM4fLFEJyngpVLoRxbe7a7bFdzTZmbQ
         Q210YDSHLhbVIjw0YBCkXy65EkJJXuwegW+uB2d7Nt23ZkmiRiI7T/nJOCSl5pgaFV
         JfVDb8yFv8LUXRA0cQQu/6rb8UXWchVY0F8jKkXjErLzUeIiQyTYQidvS43ikRynCA
         r8cBFvzIeDrjg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org
Subject: [PATCH 4/6] wifi: mt76: mt7921: avoid mcu_restart function pointer
Date:   Sun,  1 Jan 2023 12:53:21 +0100
Message-Id: <286d79841c18bf0048e2a8e8e4896f6f053a8fe6.1672573894.git.lorenzo@kernel.org>
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

Avoid mcu_restart function pointer whenever it is possible.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7921/pci_mcu.c | 1 -
 drivers/net/wireless/mediatek/mt76/mt7921/usb.c     | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci_mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci_mcu.c
index 86340d3205c5..0e7ea35efa8d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/pci_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci_mcu.c
@@ -44,7 +44,6 @@ int mt7921e_mcu_init(struct mt7921_dev *dev)
 		.headroom = sizeof(struct mt76_connac2_mcu_txd),
 		.mcu_skb_send_msg = mt7921_mcu_send_message,
 		.mcu_parse_response = mt7921_mcu_parse_response,
-		.mcu_restart = mt76_connac_mcu_restart,
 	};
 	int err;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/usb.c b/drivers/net/wireless/mediatek/mt76/mt7921/usb.c
index 5321d20dcdcb..a277d9ef2db4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/usb.c
@@ -133,7 +133,6 @@ static int mt7921u_mcu_init(struct mt7921_dev *dev)
 		.tailroom = MT_USB_TAIL_SIZE,
 		.mcu_skb_send_msg = mt7921u_mcu_send_message,
 		.mcu_parse_response = mt7921_mcu_parse_response,
-		.mcu_restart = mt76_connac_mcu_restart,
 	};
 	int ret;
 
-- 
2.38.1

