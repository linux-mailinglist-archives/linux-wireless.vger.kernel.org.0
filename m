Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A2F434BC53
	for <lists+linux-wireless@lfdr.de>; Sun, 28 Mar 2021 14:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbhC1Mbt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 28 Mar 2021 08:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbhC1MbQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 28 Mar 2021 08:31:16 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD3BC0613B1
        for <linux-wireless@vger.kernel.org>; Sun, 28 Mar 2021 05:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=LmOaA+qG3kp/Cd6KttDCu/vz2MQC2txR191H0I3M3KY=; b=fFOn/QNeu84Z868auMk7VZYabr
        OZhA+kg5NzOMrgARgE4lQwXhqYWnB3x907GRmzpNrS5OMVUPdhfcoeCLympcl63JXFQnxM4bd+FL/
        h9UlUCyrqJNfv4XxR4bx1X1/+x3wi7c7UCUpZD+nNKkNSDnmNcOLTff3k3E+2kLZldYo=;
Received: from p4ff13c8d.dip0.t-ipconnect.de ([79.241.60.141] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1lQUZQ-0001Tv-Un
        for linux-wireless@vger.kernel.org; Sun, 28 Mar 2021 14:31:09 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 1/2] mt76: mt7615: limit firmware log message printk to buffer length
Date:   Sun, 28 Mar 2021 14:31:06 +0200
Message-Id: <20210328123107.74828-1-nbd@nbd.name>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Avoid including garbage from previous rx data

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 3855acbd4a5d..600c5366c099 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -424,7 +424,8 @@ mt7615_mcu_rx_log_message(struct mt7615_dev *dev, struct sk_buff *skb)
 		break;
 	}
 
-	wiphy_info(mt76_hw(dev)->wiphy, "%s: %s", type, data);
+	wiphy_info(mt76_hw(dev)->wiphy, "%s: %*s", type,
+		   (int)(skb->len - sizeof(*rxd)), data);
 }
 
 static void
-- 
2.30.1

