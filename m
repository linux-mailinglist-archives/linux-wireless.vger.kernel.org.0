Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E16D36C24C
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Apr 2021 12:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235181AbhD0KFw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 27 Apr 2021 06:05:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:55396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230341AbhD0KFu (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 27 Apr 2021 06:05:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BC236613C5;
        Tue, 27 Apr 2021 10:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619517905;
        bh=WccPtnp9AkXba1B2VvgliyQx341WmI3CyGXemNVgsZY=;
        h=From:To:Cc:Subject:Date:From;
        b=kd9TP0SiOXohg8kHqWdA9xNiRG5IRXYyQ5vV2apmm49y71Mj14IyPs5j08yIKiLpU
         PAYoQ4OnthY2Mz5tQ4GVgwX/sRBekhdJdNIK1hhVbpN9JS7pROwmvU3hZq0QnqpTg/
         +54uvmtROa4p8XVp3aOOi/Ryb1VZUzFTF19FwU5xb9uSBUzO4tuFM1PIVEU1oLqvig
         QIzMIGj4lq54UwuZQfO7IxxHiNPHRU68X2hF7OTPl8kL3ESBUYzO/pPCAC8xnNWqy4
         jQW+ucURr0JZpS87uttkO3+upAFicNhzLIjntKjN5I9osVrzgh1SiQ8MzEgcuXrnYr
         EjITgvNO9krOg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: [PATCH] mt76: fix possible NULL pointer dereference in mt76_tx
Date:   Tue, 27 Apr 2021 12:05:00 +0200
Message-Id: <6f0d5deedca8e8dd273e7c1ceda256c9ac2f4e3a.1619517788.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Even if this is not a real issue since mt76_tx is never run with wcid set
to NULL, fix a theoretical NULL pointer dereference in mt76_tx routine

Fixes: db9f11d3433f7 ("mt76: store wcid tx rate info in one u32 reduce locking")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/tx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/tx.c b/drivers/net/wireless/mediatek/mt76/tx.c
index 53ea8de82df0..441d06e30b1a 100644
--- a/drivers/net/wireless/mediatek/mt76/tx.c
+++ b/drivers/net/wireless/mediatek/mt76/tx.c
@@ -285,7 +285,7 @@ mt76_tx(struct mt76_phy *phy, struct ieee80211_sta *sta,
 		skb_set_queue_mapping(skb, qid);
 	}
 
-	if (!(wcid->tx_info & MT_WCID_TX_INFO_SET))
+	if (wcid && !(wcid->tx_info & MT_WCID_TX_INFO_SET))
 		ieee80211_get_tx_rates(info->control.vif, sta, skb,
 				       info->control.rates, 1);
 
-- 
2.30.2

