Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 706AE34B0EC
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Mar 2021 21:55:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbhCZUzM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 26 Mar 2021 16:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbhCZUzK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 26 Mar 2021 16:55:10 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E1D4C0613B1
        for <linux-wireless@vger.kernel.org>; Fri, 26 Mar 2021 13:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=x9cmCsO1uImiXvM9RAGzUQu9DDYzzvh9206/GlpUpvE=; b=IBdk5Bx+dhuYpzBiaOCjj4MWnR
        ctC9pmSe5JzHbyaLJyzt4pf5AEomXiIRxD7F/BDsaMmmgK14sAtgQnS+z5kgkdc2U/d7oD4U01llC
        IUwPK+6w7lVCJTZOvKPfxMRMwhQE3b0IqAd3T9JtfVzfjjH96gkucVAdBRxOk/JrVdzo=;
Received: from p4ff13c8d.dip0.t-ipconnect.de ([79.241.60.141] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1lPtU3-0001b7-IW
        for linux-wireless@vger.kernel.org; Fri, 26 Mar 2021 21:55:07 +0100
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 2/3] mt76: mt7915: 0-terminate firmware log messages
Date:   Fri, 26 Mar 2021 21:55:04 +0100
Message-Id: <20210326205505.74383-2-nbd@nbd.name>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210326205505.74383-1-nbd@nbd.name>
References: <20210326205505.74383-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Avoid including garbage from previous rx data in the printk messages

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 9d0911ac1d90..138f55d9fc02 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -521,6 +521,7 @@ mt7915_mcu_rx_log_message(struct mt7915_dev *dev, struct sk_buff *skb)
 		break;
 	}
 
+	skb->data[skb->len] = 0;
 	wiphy_info(mt76_hw(dev)->wiphy, "%s: %s", type, data);
 }
 
-- 
2.30.1

