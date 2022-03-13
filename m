Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE2694D7551
	for <lists+linux-wireless@lfdr.de>; Sun, 13 Mar 2022 13:49:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233839AbiCMMul (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 13 Mar 2022 08:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233756AbiCMMui (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 13 Mar 2022 08:50:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A20870F6F
        for <linux-wireless@vger.kernel.org>; Sun, 13 Mar 2022 05:49:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E638660F3D
        for <linux-wireless@vger.kernel.org>; Sun, 13 Mar 2022 12:49:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9922C340EC;
        Sun, 13 Mar 2022 12:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647175770;
        bh=DVaBtUDkkMcB4eyNDjBZeuwCK+da3683tL6OZe4IULQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iDnOFiQ4D1dcfneNNYAx8GsoxYtnsLw+2oBx5hAx9/wku5Qus+jEHY0xzwEI9woA/
         OIHTS5j9131/OlrpEB+B4nuaIFBxqeonHiocTn2WJ17epXiU7svgrw8h5lnr2vyhkp
         xpR297btSWbMIakja/QsEkf7yIMf2CO1t3Yt7JUgTESE2kziFDguSxP5Trn0cbXGfq
         dbxXAOYncNK1q9O5W703aUMdJ3kAlxyGa0Pbr+i3CcuXntJQXsxFMhMwSBVv56LfwZ
         /3yJ09Umoc0Og8UOH7CXwweDEynjl0A3fmNyMGs+9GbwvYgjREdeKvCu3rwu23GSyz
         E6/uKvZ9t9msg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, deren.wu@mediatek.com,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v3 5/9] mt76: mt7921: update mt7921_skb_add_usb_sdio_hdr to support usb
Date:   Sun, 13 Mar 2022 13:48:55 +0100
Message-Id: <4ced0548dc8f60266cca3e1800b42f962d29a156.1647175554.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1647175554.git.lorenzo@kernel.org>
References: <cover.1647175554.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This is a preliminary patch to add mt7921u driver support.

Tested-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h   | 10 ++++++----
 drivers/net/wireless/mediatek/mt76/mt7921/sdio_mac.c |  2 +-
 drivers/net/wireless/mediatek/mt76/mt7921/sdio_mcu.c |  2 +-
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index 394a677140da..66b331d003b4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -352,12 +352,14 @@ static inline void mt7921_mcu_tx_cleanup(struct mt7921_dev *dev)
 	mt76_queue_tx_cleanup(dev, dev->mt76.q_mcu[MT_MCUQ_WA], false);
 }
 
-static inline void mt7921_skb_add_sdio_hdr(struct sk_buff *skb,
-					   enum mt7921_sdio_pkt_type type)
+static inline void
+mt7921_skb_add_usb_sdio_hdr(struct mt7921_dev *dev, struct sk_buff *skb,
+			    int type)
 {
-	u32 hdr;
+	u32 hdr, len;
 
-	hdr = FIELD_PREP(MT7921_SDIO_HDR_TX_BYTES, skb->len + sizeof(hdr)) |
+	len = mt76_is_usb(&dev->mt76) ? skb->len : skb->len + sizeof(hdr);
+	hdr = FIELD_PREP(MT7921_SDIO_HDR_TX_BYTES, len) |
 	      FIELD_PREP(MT7921_SDIO_HDR_PKT_TYPE, type);
 
 	put_unaligned_le32(hdr, skb_push(skb, sizeof(hdr)));
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/sdio_mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/sdio_mac.c
index 4fd1d4765b04..5462ab05fb13 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/sdio_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/sdio_mac.c
@@ -183,7 +183,7 @@ int mt7921s_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 	pktid = mt76_tx_status_skb_add(&dev->mt76, wcid, skb);
 	mt7921s_write_txwi(dev, wcid, qid, sta, key, pktid, skb);
 
-	mt7921_skb_add_sdio_hdr(skb, MT7921_SDIO_DATA);
+	mt7921_skb_add_usb_sdio_hdr(dev, skb, MT7921_SDIO_DATA);
 	pad = round_up(skb->len, 4) - skb->len;
 
 	err = mt76_skb_adjust_pad(skb, pad);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/sdio_mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/sdio_mcu.c
index 5d8af18c7026..54a5c712a3c3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/sdio_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/sdio_mcu.c
@@ -36,7 +36,7 @@ mt7921s_mcu_send_message(struct mt76_dev *mdev, struct sk_buff *skb,
 	if (cmd == MCU_CMD(FW_SCATTER))
 		type = MT7921_SDIO_FWDL;
 
-	mt7921_skb_add_sdio_hdr(skb, type);
+	mt7921_skb_add_usb_sdio_hdr(dev, skb, type);
 	pad = round_up(skb->len, 4) - skb->len;
 	__skb_put_zero(skb, pad);
 
-- 
2.35.1

