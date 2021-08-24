Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AF603F5BF5
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Aug 2021 12:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236225AbhHXKXo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 Aug 2021 06:23:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:59460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236208AbhHXKXo (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 Aug 2021 06:23:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 62D2C61357;
        Tue, 24 Aug 2021 10:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629800580;
        bh=V8eg2EfgB+Lq2e+61gNSvU3VgjEJN2bkZR+I3wsWlPQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b1uCQZk6HmH8qecyLAl4k0TWzs+wdvxsOA81oU2UDp+2gghhUFh3ad2LHTiH8uWZk
         nzJfNdXAGAIl4a4Kgh3IZgFmCNb9H3iQbIuu0+5f8Q9O2DPTDAtWE0W1J2e1mUz+ix
         +xtTV8cOWCvnQG0FH+K2+qosB7hlVw0kREzA0jN+uVDXD4TRGV1M3NmQWZpS814YYd
         xpMKiiKRWPJOda/UgzBmeBaZvJFpsVPYPcobeO5f5ZrsMNbQDQKOXaSZB17P5jGsEC
         C09GMiYdm2GQXI199HrSsok9LPmLa4NjB2Aw7sKVzS8fCKf46DSooNVq1AbJvABTkM
         BW0dREKQB6I8w==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, Deren.Wu@mediatek.com
Subject: [PATCH 2/9] mt76: connac: enable 6GHz band for hw scan
Date:   Tue, 24 Aug 2021 12:22:20 +0200
Message-Id: <183f3c5992833a013b4f09e2dbd642977ae545d7.1629799385.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1629799385.git.lorenzo@kernel.org>
References: <cover.1629799385.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This is a preliminary patch to support 6GHz band on mt7921 devices.

Tested-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../wireless/mediatek/mt76/mt76_connac_mcu.c  | 25 +++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index 8b72ed77881c..8858a06ebd95 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -1458,7 +1458,17 @@ int mt76_connac_mcu_hw_scan(struct mt76_phy *phy, struct ieee80211_vif *vif,
 		else
 			chan = &req->channels[i];
 
-		chan->band = scan_list[i]->band == NL80211_BAND_2GHZ ? 1 : 2;
+		switch (scan_list[i]->band) {
+		case NL80211_BAND_2GHZ:
+			chan->band = 1;
+			break;
+		case NL80211_BAND_6GHZ:
+			chan->band = 3;
+			break;
+		default:
+			chan->band = 2;
+			break;
+		}
 		chan->channel_num = scan_list[i]->hw_value;
 	}
 	req->channel_type = sreq->n_channels ? 4 : 0;
@@ -1567,7 +1577,18 @@ int mt76_connac_mcu_sched_scan_req(struct mt76_phy *phy,
 	req->channels_num = min_t(u8, sreq->n_channels, 64);
 	for (i = 0; i < req->channels_num; i++) {
 		chan = &req->channels[i];
-		chan->band = scan_list[i]->band == NL80211_BAND_2GHZ ? 1 : 2;
+
+		switch (scan_list[i]->band) {
+		case NL80211_BAND_2GHZ:
+			chan->band = 1;
+			break;
+		case NL80211_BAND_6GHZ:
+			chan->band = 3;
+			break;
+		default:
+			chan->band = 2;
+			break;
+		}
 		chan->channel_num = scan_list[i]->hw_value;
 	}
 
-- 
2.31.1

