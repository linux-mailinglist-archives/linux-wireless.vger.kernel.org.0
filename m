Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4EC33D019C
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jul 2021 20:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232555AbhGTRnh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Jul 2021 13:43:37 -0400
Received: from dispatch1-us1.ppe-hosted.com ([67.231.154.184]:49658 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234850AbhGTRmf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Jul 2021 13:42:35 -0400
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.110.51.172])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id F1CE4A0075
        for <linux-wireless@vger.kernel.org>; Tue, 20 Jul 2021 18:23:00 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id C4C6114007E
        for <linux-wireless@vger.kernel.org>; Tue, 20 Jul 2021 18:23:00 +0000 (UTC)
Received: from ben-dt4.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id 4F0C813C2B3;
        Tue, 20 Jul 2021 11:23:00 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 4F0C813C2B3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1626805380;
        bh=WMYkJ3alIxDDY4APHAc4Y7K299HxyU/pxpWbGtRC3xg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g7D2Iis3UJt4CuPwC5sW5Thhy9+sPXhQAmfNapAEsUo8M3FkrRBtUlPJRg5rWTU9g
         H59s7J7A6Kxvmm9H7WEtqUMFx1qAcZqFOn4Xyx/SVd7GMrnWWkToM4lDeiUbwIJUIN
         oMve2kdy/VEGKCLNy0jG0++bxBgbRR1nAR3qp6Es=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [PATCH 02/11] mt76 - mt7915:  Fix potential NPE in TXS processing.
Date:   Tue, 20 Jul 2021 11:22:46 -0700
Message-Id: <20210720182256.30536-2-greearb@candelatech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210720182256.30536-1-greearb@candelatech.com>
References: <20210720182256.30536-1-greearb@candelatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1626805381-y-D30EVUkUmc
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

If skb is null, then don't try to dereference it.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 9b3637c4cb12..1f644c4f3686 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -1321,7 +1321,7 @@ mt7915_mac_add_txs_skb(struct mt7915_dev *dev, struct mt76_wcid *wcid, int pid,
 
 	/* TODO:  Gather stats anyway, even if we are not matching on an skb. */
 	if (!skb)
-		goto out;
+		goto out_no_skb;
 
 	txs = le32_to_cpu(txs_data[0]);
 	txs5 = le32_to_cpu(txs_data[5]);
@@ -1427,6 +1427,8 @@ mt7915_mac_add_txs_skb(struct mt7915_dev *dev, struct mt76_wcid *wcid, int pid,
 
 out:
 	mt76_tx_status_skb_done(mdev, skb, &list, wcid);
+
+out_no_skb:
 	mt76_tx_status_unlock(mdev, &list);
 
 	return !!skb;
-- 
2.20.1

