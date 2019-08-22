Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0174998DDB
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Aug 2019 10:36:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732467AbfHVIgZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 22 Aug 2019 04:36:25 -0400
Received: from nbd.name ([46.4.11.11]:50900 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731266AbfHVIgZ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 22 Aug 2019 04:36:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=eGWDiMsmzMnH8naBfU6xquaGySQrqEM70W+4s1cFeiI=; b=irsq7RzRSPT0B2W4V7d1GIBcLW
        6zGz/gD7lPXZe2oNlqhklQsLa/UUsQ+MZYNCALPTdiYTlDbGO5QamFGPwkl8xjyuifliJkxAwdZSW
        CtANUlSMUB1uo7rKLdo2tQwoJfITeuvH9FQywYTxuBicuTFDxGRtJBj23vb35jBA3r2E=;
Received: from p54ae9443.dip0.t-ipconnect.de ([84.174.148.67] helo=maeck.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1i0iZz-0004vP-2K; Thu, 22 Aug 2019 10:36:23 +0200
Received: by maeck.local (Postfix, from userid 501)
        id 92BAE63FDE30; Thu, 22 Aug 2019 10:36:22 +0200 (CEST)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Cc:     Balakrishna Bandi <b.balakrishna@globaledgesoft.com>
Subject: [PATCH 1/2] mt76: do not send BAR frame on tx aggregation flush stop
Date:   Thu, 22 Aug 2019 10:36:21 +0200
Message-Id: <20190822083622.48998-1-nbd@nbd.name>
X-Mailer: git-send-email 2.17.0
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

There is no need to send a BAR frame after stopping aggregation, and doing
so could lead to sending class 3 frames after deauthentication from an AP

Signed-off-by: Balakrishna Bandi <b.balakrishna@globaledgesoft.com>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt7603/main.c  | 1 -
 drivers/net/wireless/mediatek/mt76/mt7615/main.c  | 1 -
 drivers/net/wireless/mediatek/mt76/mt76x02_util.c | 1 -
 3 files changed, 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/main.c b/drivers/net/wireless/mediatek/mt76/mt7603/main.c
index e35c1e4da7ea..25d5b1608bc9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/main.c
@@ -578,7 +578,6 @@ mt7603_ampdu_action(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	case IEEE80211_AMPDU_TX_STOP_FLUSH:
 	case IEEE80211_AMPDU_TX_STOP_FLUSH_CONT:
 		mtxq->aggr = false;
-		ieee80211_send_bar(vif, sta->addr, tid, mtxq->agg_ssn);
 		mt7603_mac_tx_ba_reset(dev, msta->wcid.idx, tid, -1);
 		break;
 	case IEEE80211_AMPDU_TX_START:
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index e2a84f717051..87c748715b5d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -473,7 +473,6 @@ mt7615_ampdu_action(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	case IEEE80211_AMPDU_TX_STOP_FLUSH:
 	case IEEE80211_AMPDU_TX_STOP_FLUSH_CONT:
 		mtxq->aggr = false;
-		ieee80211_send_bar(vif, sta->addr, tid, mtxq->agg_ssn);
 		mt7615_mcu_set_tx_ba(dev, params, 0);
 		break;
 	case IEEE80211_AMPDU_TX_START:
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_util.c b/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
index dbd9d99225ff..aec73a0295e8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
@@ -390,7 +390,6 @@ int mt76x02_ampdu_action(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	case IEEE80211_AMPDU_TX_STOP_FLUSH:
 	case IEEE80211_AMPDU_TX_STOP_FLUSH_CONT:
 		mtxq->aggr = false;
-		ieee80211_send_bar(vif, sta->addr, tid, mtxq->agg_ssn);
 		break;
 	case IEEE80211_AMPDU_TX_START:
 		mtxq->agg_ssn = IEEE80211_SN_TO_SEQ(ssn);
-- 
2.17.0

