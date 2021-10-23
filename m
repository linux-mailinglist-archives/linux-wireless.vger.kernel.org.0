Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96B17438373
	for <lists+linux-wireless@lfdr.de>; Sat, 23 Oct 2021 13:24:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbhJWL0b (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 23 Oct 2021 07:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbhJWL0a (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 23 Oct 2021 07:26:30 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E4F4C061764
        for <linux-wireless@vger.kernel.org>; Sat, 23 Oct 2021 04:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=40kRliw1J3bs8Bek3w+2j+Xm8OJ2PlDk7ZqoLZsYXTc=; b=XAg84bKspn39RtYPlTHUc/+v5M
        grybn9kIRsIgqxaDRzibPp6DV7AT8FJxWUSIxhcoLlzAyLiFs4bv2nGhjhcb12jQsSGinDpCmlG/Y
        fZyWHfv7e0g/Z8wWrmcYcm6T95hhNMf37AAP02V0V54Pyn8b8r2dR43WBVb8VQ8fUZC0=;
Received: from p4ff1322b.dip0.t-ipconnect.de ([79.241.50.43] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1meF8C-0007fX-R8
        for linux-wireless@vger.kernel.org; Sat, 23 Oct 2021 13:24:08 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH] mt76: connac: fix unresolved symbols when CONFIG_PM is unset
Date:   Sat, 23 Oct 2021 13:24:07 +0200
Message-Id: <20211023112407.26448-1-nbd@nbd.name>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

mt76_connac_mcu_reg_* functions are always needed by connac based drivers

Fixes: 87f9bf24ea84 ("mt76: connac: move mcu reg access utility routines in mt76_connac_lib module")
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index 32e25180fc1e..26b4b875dcc0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -2477,6 +2477,7 @@ void mt76_connac_mcu_set_suspend_iter(void *priv, u8 *mac,
 	mt76_connac_mcu_set_wow_ctrl(phy, vif, suspend, wowlan);
 }
 EXPORT_SYMBOL_GPL(mt76_connac_mcu_set_suspend_iter);
+#endif /* CONFIG_PM */
 
 u32 mt76_connac_mcu_reg_rr(struct mt76_dev *dev, u32 offset)
 {
@@ -2505,7 +2506,6 @@ void mt76_connac_mcu_reg_wr(struct mt76_dev *dev, u32 offset, u32 val)
 	mt76_mcu_send_msg(dev, MCU_CMD_REG_WRITE, &req, sizeof(req), false);
 }
 EXPORT_SYMBOL_GPL(mt76_connac_mcu_reg_wr);
-#endif /* CONFIG_PM */
 
 MODULE_AUTHOR("Lorenzo Bianconi <lorenzo@kernel.org>");
 MODULE_LICENSE("Dual BSD/GPL");
-- 
2.30.1

