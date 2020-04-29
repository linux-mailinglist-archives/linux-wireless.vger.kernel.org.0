Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D99E91BE59A
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Apr 2020 19:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726524AbgD2RtE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 29 Apr 2020 13:49:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:59692 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726423AbgD2RtE (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 29 Apr 2020 13:49:04 -0400
Received: from localhost.localdomain.com (unknown [151.66.196.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C2D4C208FE;
        Wed, 29 Apr 2020 17:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588182543;
        bh=XyaCyX6NasKY8y249zF6XaHJE8b9TcC0AsHaX8FpsQQ=;
        h=From:To:Cc:Subject:Date:From;
        b=uNbXGPbCF6os6KOlfEmBUP+AiyaK07hzyol6EouD97lYHVtZKGny5TkH01Dsx5hBs
         CJeACNg9nQBGm0MHD4CPTMpM/wtJtwOZC0B7/TivtJjsjS6HvIl+G9TYdiASDW6Bv5
         jthPrT2DQq0dgxNIYACFm9JYezUMUfDXurEesCEk=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, linux-mediatek@lists.infradead.org
Subject: [PATCH] mt76: mt7615: fix ssid configuration in mt7615_mcu_hw_scan
Date:   Wed, 29 Apr 2020 19:48:53 +0200
Message-Id: <3a36f4878f8368f57b2b3f8ab396ba418e9447dd.1588182106.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix SSID configuration performing hw frequency scanning

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 57794827400c..727a55abda69 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -2713,9 +2713,9 @@ int mt7615_mcu_hw_scan(struct mt7615_phy *phy, struct ieee80211_vif *vif,
 {
 	struct mt7615_vif *mvif = (struct mt7615_vif *)vif->drv_priv;
 	struct cfg80211_scan_request *sreq = &scan_req->req;
+	int n_ssids = 0, err, i, duration = MT7615_SCAN_CHANNEL_TIME;
 	int ext_channels_num = max_t(int, sreq->n_channels - 32, 0);
 	struct ieee80211_channel **scan_list = sreq->channels;
-	int err, i, duration = MT7615_SCAN_CHANNEL_TIME;
 	struct mt7615_dev *dev = phy->dev;
 	bool ext_phy = phy != &dev->phy;
 	struct mt7615_mcu_scan_channel *chan;
@@ -2738,16 +2738,21 @@ int mt7615_mcu_hw_scan(struct mt7615_phy *phy, struct ieee80211_vif *vif,
 	req->seq_num = mvif->scan_seq_num | ext_phy << 7;
 	req->bss_idx = mvif->idx;
 	req->scan_type = 1;
-	req->ssid_type = 1;
 	req->probe_req_num = 2;
 	req->version = 1;
 	req->channel_type = 4;
 
 	for (i = 0; i < sreq->n_ssids; i++) {
+		if (!sreq->ssids[i].ssid_len)
+			continue;
+
 		req->ssids[i].ssid_len = cpu_to_le32(sreq->ssids[i].ssid_len);
 		memcpy(req->ssids[i].ssid, sreq->ssids[i].ssid,
 		       sreq->ssids[i].ssid_len);
+		n_ssids++;
 	}
+	req->ssid_type = n_ssids ? BIT(2) : BIT(0);
+	req->ssids_num = n_ssids;
 
 	req->timeout_value = cpu_to_le16(sreq->n_channels * duration);
 	req->channel_min_dwell_time = cpu_to_le16(duration);
-- 
2.25.4

