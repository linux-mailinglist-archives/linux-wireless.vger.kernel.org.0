Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32E0134A30D
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Mar 2021 09:16:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbhCZIQH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 26 Mar 2021 04:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbhCZIQD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 26 Mar 2021 04:16:03 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40DB7C0613B0
        for <linux-wireless@vger.kernel.org>; Fri, 26 Mar 2021 01:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=pvAtyShbVj7Y9521LZVVG96FooJS7oeEhie3UPMjACs=; b=iP6lZ+fFUfNT2o8eTQBUFJSanj
        t8Jz4RjiZhLW0LX+qG0UFwnokjqicILUOLDPhvh6vxtUmtMdN4H/dHqPgJQo0idPKFUpH8evLurJ1
        jyPTo9mRCUYHX2l7OfY77KsGYwfniCJ+0XZSq0Z/g1Cqp9+ZnYydrs41E2QGUKAR4nQE=;
Received: from p4ff13c8d.dip0.t-ipconnect.de ([79.241.60.141] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1lPhdR-0007bD-FO
        for linux-wireless@vger.kernel.org; Fri, 26 Mar 2021 09:16:01 +0100
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 2/2] mt76: mt7915: refresh repeater entry MAC address when setting BSSID
Date:   Fri, 26 Mar 2021 09:15:52 +0100
Message-Id: <20210326081552.21736-2-nbd@nbd.name>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210326081552.21736-1-nbd@nbd.name>
References: <20210326081552.21736-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When disassociating and clearing the BSSID of a repeater entry used by a client
mode interface, the corresponding MAC address entry can get lost too, causing
the client interface to not be able to associate anymore.
Fix this by also refreshing the MAC address when setting the BSSID

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 29b5039cc286..9d0911ac1d90 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -1008,8 +1008,10 @@ int mt7915_mcu_add_bss_info(struct mt7915_phy *phy,
 	struct mt7915_vif *mvif = (struct mt7915_vif *)vif->drv_priv;
 	struct sk_buff *skb;
 
-	if (mvif->omac_idx >= REPEATER_BSSID_START)
+	if (mvif->omac_idx >= REPEATER_BSSID_START) {
+		mt7915_mcu_muar_config(phy, vif, false, enable);
 		mt7915_mcu_muar_config(phy, vif, true, enable);
+	}
 
 	skb = mt7915_mcu_alloc_sta_req(phy->dev, mvif, NULL,
 				       MT7915_BSS_UPDATE_MAX_SIZE);
-- 
2.30.1

