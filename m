Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C70B23C93A
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Aug 2020 11:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727808AbgHEJdj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 5 Aug 2020 05:33:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727941AbgHEJcj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 5 Aug 2020 05:32:39 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D46E7C06174A
        for <linux-wireless@vger.kernel.org>; Wed,  5 Aug 2020 02:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=Eo8peQlLnPjOUnbR8IFj/Qs1mD6cRBHFgCR+LOGMc/Y=; b=TFhU7f2PQf2Z9ukoLYQBzqfPlJ
        sMgsVIJFCtHhPlIgedMkvG6NzCGvraF1i3GDuBxb0jHjcy1GvRBEgidv15FRFaBK3qj8hW7+aSKRq
        JWFeHyDLt3+0y9aOGRa23yskz6BVCc7M47J8vfsT/pLibCUPOMxnbwnVQ2H2ICkH4kLo=;
Received: from p54ae996c.dip0.t-ipconnect.de ([84.174.153.108] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1k3Fmn-0008Si-AC
        for linux-wireless@vger.kernel.org; Wed, 05 Aug 2020 11:32:37 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 1/2] mt76: mt7915: fix crash on tx rate report for invalid stations
Date:   Wed,  5 Aug 2020 11:32:34 +0200
Message-Id: <20200805093235.52506-1-nbd@nbd.name>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Check wcid RCU pointer before using it

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 01fa9ca31d0e..949a387e8f93 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -522,6 +522,9 @@ mt7915_mcu_tx_rate_report(struct mt7915_dev *dev, struct sk_buff *skb)
 		return;
 
 	wcid = rcu_dereference(dev->mt76.wcid[wcidx]);
+	if (!wcid)
+		return;
+
 	msta = container_of(wcid, struct mt7915_sta, wcid);
 	stats = &msta->stats;
 
-- 
2.24.0

