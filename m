Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AF4F7EF6B8
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Nov 2023 18:04:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231793AbjKQREJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Nov 2023 12:04:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbjKQREI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Nov 2023 12:04:08 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 080B2A7
        for <linux-wireless@vger.kernel.org>; Fri, 17 Nov 2023 09:04:06 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 338C4C433C8;
        Fri, 17 Nov 2023 17:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700240645;
        bh=SE10d0YuQ39spzw8CX44mjTAHinWuf0O2W3zAeufCsQ=;
        h=From:To:Cc:Subject:Date:From;
        b=m2M6IHbLXqz5ADij96lkOVBEYUDmp56zgCr2sUJlD6n7Y+vBx9jN7EJRarMXON5uA
         x69zaOHp4Ni4IjJf3kdKn+Ge4YgBSkQIbCNWUBjz03lRkneCYGqqfDTSe2hDlF6Cpo
         b70OOIDee59w+o3xrva8QvQliQfAApNA1smZDL26wFEkwbmHpDjVf+HSF8jue2dnOs
         73QoapzEl+Z3LxeSfep/jI5fNsyKD4ohadK8IpKxX1LTk7LvsCFgCDMbCr615PjERD
         V7Nw3jDof5MiddWlI+szvxSM5I3T2x0Unmm3BJBfVFYj+tLmvNe95F7N6iVh07ftDf
         tvey7SMY0U1tg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org
Subject: [PATCH] wifi: mt76: mt7996: fix endianness in mt7996_mcu_wed_rro_event
Date:   Fri, 17 Nov 2023 18:03:50 +0100
Message-ID: <21ad5fbd15a8fd76285b0200be36c991a0fcfb13.1700240565.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix tag endianness in mt7996_mcu_wed_rro_event routine

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index 61de5e041627..03a9474120b7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -536,7 +536,7 @@ mt7996_mcu_wed_rro_event(struct mt7996_dev *dev, struct sk_buff *skb)
 
 	skb_pull(skb, sizeof(struct mt7996_mcu_rxd) + 4);
 
-	switch (event->tag) {
+	switch (le16_to_cpu(event->tag)) {
 	case UNI_WED_RRO_BA_SESSION_STATUS: {
 		struct mt7996_mcu_wed_rro_ba_event *e;
 
-- 
2.42.0

