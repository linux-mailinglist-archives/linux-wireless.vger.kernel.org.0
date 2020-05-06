Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2960A1C6DD7
	for <lists+linux-wireless@lfdr.de>; Wed,  6 May 2020 11:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729099AbgEFJ6p (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 6 May 2020 05:58:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:58486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729028AbgEFJ6o (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 6 May 2020 05:58:44 -0400
Received: from localhost.localdomain.com (unknown [151.48.155.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3DFE3206D5;
        Wed,  6 May 2020 09:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588759124;
        bh=tDM70yGhQ9s6C5jix3X7uohreLM0rGZ7R/MDTtcN09M=;
        h=From:To:Cc:Subject:Date:From;
        b=xeBbpxEwyQ+qZnmaOFC03sSvLjXkqi2PBsiveS6Gx+PzpIfl27J8wxWyKId4/MfLW
         N5mnzEg5pRofiELpI9CPS5AwUV0IY/j0yoUn6+vmmvAJj2JG4rFHCDt/Mjw+fXzUvO
         JicX9N8DFS8fJqATVg4GsooQNC+4Cqim9NYJnkPg=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com
Subject: [PATCH] mt76: mt7615: scan all channels if not specified
Date:   Wed,  6 May 2020 11:58:32 +0200
Message-Id: <b5dc17d9ffdefb70ca8b8efe821897e6b38f5edc.1588759049.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Configure the mcu to scan all available channels if mac80211 does not
provide any frequency list

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 19b59a7550b6..96bf39a4a3da 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -2806,7 +2806,6 @@ int mt7615_mcu_hw_scan(struct mt7615_phy *phy, struct ieee80211_vif *vif,
 	req->scan_type = sreq->n_ssids ? 1 : 0;
 	req->probe_req_num = sreq->n_ssids ? 2 : 0;
 	req->version = 1;
-	req->channel_type = 4;
 
 	for (i = 0; i < sreq->n_ssids; i++) {
 		if (!sreq->ssids[i].ssid_len)
@@ -2835,6 +2834,7 @@ int mt7615_mcu_hw_scan(struct mt7615_phy *phy, struct ieee80211_vif *vif,
 		chan->band = scan_list[i]->band == NL80211_BAND_2GHZ ? 1 : 2;
 		chan->channel_num = scan_list[i]->hw_value;
 	}
+	req->channel_type = sreq->n_channels ? 4 : 0;
 
 	if (sreq->ie_len > 0) {
 		memcpy(req->ies, sreq->ie, sreq->ie_len);
@@ -2930,7 +2930,7 @@ int mt7615_mcu_sched_scan_req(struct mt7615_phy *phy,
 		req->match[i].ssid_len = match->ssid.ssid_len;
 	}
 
-	req->channel_type = 4;
+	req->channel_type = sreq->n_channels ? 4 : 0;
 	req->channels_num = min_t(u8, sreq->n_channels, 64);
 	for (i = 0; i < req->channels_num; i++) {
 		chan = &req->channels[i];
-- 
2.26.2

