Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDA6F34B0EE
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Mar 2021 21:55:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbhCZUzN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 26 Mar 2021 16:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbhCZUzK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 26 Mar 2021 16:55:10 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34F39C0613B2
        for <linux-wireless@vger.kernel.org>; Fri, 26 Mar 2021 13:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=jhKzENU1PLNAjhiRYdLQjFD/7nBHDkHTeUOB3DFS3Pk=; b=BsjATYtNf/Xdf6hMXrhTg1jS4f
        +VdTKPGwcN4L8WJ9OY6LOaT28vq1ljSVaAlP0zk/HjsfzoQ3aIdFDImvY5y02GKMcW2yicgqMqMTc
        cGDjZIoEG3TayHoPOod7zLZwcmQqgpI2nrOT8izoeWVN2YgGrWUspEdkxSALLq3zeFhY=;
Received: from p4ff13c8d.dip0.t-ipconnect.de ([79.241.60.141] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1lPtU3-0001b7-Bj
        for linux-wireless@vger.kernel.org; Fri, 26 Mar 2021 21:55:07 +0100
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 1/3] mt76: mt7615: 0-terminate firmware log messages
Date:   Fri, 26 Mar 2021 21:55:03 +0100
Message-Id: <20210326205505.74383-1-nbd@nbd.name>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Avoid including garbage from previous rx data in the printk messages

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index e565fc770a0f..0b8f5dc6b121 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -423,6 +423,7 @@ mt7615_mcu_rx_log_message(struct mt7615_dev *dev, struct sk_buff *skb)
 		break;
 	}
 
+	skb->data[skb->len] = 0;
 	wiphy_info(mt76_hw(dev)->wiphy, "%s: %s", type, data);
 }
 
-- 
2.30.1

