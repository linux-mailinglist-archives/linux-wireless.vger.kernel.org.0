Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A97166C14
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jul 2019 14:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbfGLMII (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 12 Jul 2019 08:08:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38384 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726318AbfGLMII (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 12 Jul 2019 08:08:08 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id DE53C30C0DFE;
        Fri, 12 Jul 2019 12:08:07 +0000 (UTC)
Received: from localhost (unknown [10.40.205.61])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DD3381001B3C;
        Fri, 12 Jul 2019 12:08:04 +0000 (UTC)
From:   Stanislaw Gruszka <sgruszka@redhat.com>
To:     linux-wireless@vger.kernel.org
Cc:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Ryder Lee <ryder.lee@mediatek.com>, Roy Luo <royluo@google.com>
Subject: [PATCH 2/3] mt76: mt7603: use params->ssn value directly
Date:   Fri, 12 Jul 2019 14:07:59 +0200
Message-Id: <20190712120800.21506-2-sgruszka@redhat.com>
In-Reply-To: <20190712120800.21506-1-sgruszka@redhat.com>
References: <20190712120800.21506-1-sgruszka@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Fri, 12 Jul 2019 12:08:07 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

There is no point to use pointer to params->ssn.

Signed-off-by: Stanislaw Gruszka <sgruszka@redhat.com>
---
 drivers/net/wireless/mediatek/mt76/mt7603/main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/main.c b/drivers/net/wireless/mediatek/mt76/mt7603/main.c
index e5d4cb6381a8..d70f42dac923 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/main.c
@@ -569,7 +569,7 @@ mt7603_ampdu_action(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	struct ieee80211_txq *txq = sta->txq[params->tid];
 	struct mt7603_sta *msta = (struct mt7603_sta *)sta->drv_priv;
 	u16 tid = params->tid;
-	u16 *ssn = &params->ssn;
+	u16 ssn = params->ssn;
 	u8 ba_size = params->buf_size;
 	struct mt76_txq *mtxq;
 
@@ -580,7 +580,7 @@ mt7603_ampdu_action(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 
 	switch (action) {
 	case IEEE80211_AMPDU_RX_START:
-		mt76_rx_aggr_start(&dev->mt76, &msta->wcid, tid, *ssn,
+		mt76_rx_aggr_start(&dev->mt76, &msta->wcid, tid, ssn,
 				   params->buf_size);
 		mt7603_mac_rx_ba_reset(dev, sta->addr, tid);
 		break;
@@ -599,7 +599,7 @@ mt7603_ampdu_action(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		mt7603_mac_tx_ba_reset(dev, msta->wcid.idx, tid, -1);
 		break;
 	case IEEE80211_AMPDU_TX_START:
-		mtxq->agg_ssn = IEEE80211_SN_TO_SEQ(*ssn);
+		mtxq->agg_ssn = IEEE80211_SN_TO_SEQ(ssn);
 		ieee80211_start_tx_ba_cb_irqsafe(vif, sta->addr, tid);
 		break;
 	case IEEE80211_AMPDU_TX_STOP_CONT:
-- 
2.20.1

