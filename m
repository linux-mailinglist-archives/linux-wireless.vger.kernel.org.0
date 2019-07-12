Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D94266C13
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jul 2019 14:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbfGLMIE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 12 Jul 2019 08:08:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:20306 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726318AbfGLMIE (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 12 Jul 2019 08:08:04 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D22F983F40;
        Fri, 12 Jul 2019 12:08:03 +0000 (UTC)
Received: from localhost (unknown [10.40.205.61])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 66A225DAAC;
        Fri, 12 Jul 2019 12:08:01 +0000 (UTC)
From:   Stanislaw Gruszka <sgruszka@redhat.com>
To:     linux-wireless@vger.kernel.org
Cc:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Ryder Lee <ryder.lee@mediatek.com>, Roy Luo <royluo@google.com>
Subject: [PATCH 1/3] mt76: mt76x02: use params->ssn value directly
Date:   Fri, 12 Jul 2019 14:07:58 +0200
Message-Id: <20190712120800.21506-1-sgruszka@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Fri, 12 Jul 2019 12:08:03 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

There is no point to use pointer to params->ssn.

Signed-off-by: Stanislaw Gruszka <sgruszka@redhat.com>
---
 drivers/net/wireless/mediatek/mt76/mt76x02_util.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_util.c b/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
index ad5323447ed4..fa45ed280ab1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
@@ -348,7 +348,7 @@ int mt76x02_ampdu_action(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	struct mt76x02_sta *msta = (struct mt76x02_sta *) sta->drv_priv;
 	struct ieee80211_txq *txq = sta->txq[params->tid];
 	u16 tid = params->tid;
-	u16 *ssn = &params->ssn;
+	u16 ssn = params->ssn;
 	struct mt76_txq *mtxq;
 
 	if (!txq)
@@ -359,7 +359,7 @@ int mt76x02_ampdu_action(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	switch (action) {
 	case IEEE80211_AMPDU_RX_START:
 		mt76_rx_aggr_start(&dev->mt76, &msta->wcid, tid,
-				   *ssn, params->buf_size);
+				   ssn, params->buf_size);
 		mt76_set(dev, MT_WCID_ADDR(msta->wcid.idx) + 4, BIT(16 + tid));
 		break;
 	case IEEE80211_AMPDU_RX_STOP:
@@ -378,7 +378,7 @@ int mt76x02_ampdu_action(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		ieee80211_send_bar(vif, sta->addr, tid, mtxq->agg_ssn);
 		break;
 	case IEEE80211_AMPDU_TX_START:
-		mtxq->agg_ssn = IEEE80211_SN_TO_SEQ(*ssn);
+		mtxq->agg_ssn = IEEE80211_SN_TO_SEQ(ssn);
 		ieee80211_start_tx_ba_cb_irqsafe(vif, sta->addr, tid);
 		break;
 	case IEEE80211_AMPDU_TX_STOP_CONT:
-- 
2.20.1

