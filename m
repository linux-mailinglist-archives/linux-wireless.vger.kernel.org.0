Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A62C1DE0A8
	for <lists+linux-wireless@lfdr.de>; Fri, 22 May 2020 09:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728312AbgEVHKr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 May 2020 03:10:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:36184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728253AbgEVHKr (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 May 2020 03:10:47 -0400
Received: from localhost.localdomain.com (unknown [151.48.155.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C34A2072C;
        Fri, 22 May 2020 07:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590131447;
        bh=SQlYDPydfwFdBMjoV74mHzaFhH/L+2o8RdjW4/NfzTw=;
        h=From:To:Cc:Subject:Date:From;
        b=IUymKygoDxgyeoFJWWly7OnQRam6ARyQtBU1zMYJFO3ZdTJPh2Y6Xcn2zjx+U3ENS
         xiR5/abAymGXZHHxq6edZ0mwDBAGmX6lLzQUkqelMh/jqpK/X1QDdk6DwUOsolGlIc
         naJV/znAbfJkm96VUHr308/Cqda2K8j90htFKySQ=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com
Subject: [PATCH] mt76: mt7615: fix hw_scan with ssid_type for specified SSID only
Date:   Fri, 22 May 2020 09:10:24 +0200
Message-Id: <d1a88c950e1c69183e98792bc8f02beb8d467ebc.1590130928.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Fix hw_scan with ssid_type for specified SSID only

The definition for ssid_type in current firmware is that
ssid_type BIT(2) set actually for specified SSID + wildcard SSID.
ssid_type BIT(2) and ssid_type_ext BIT(0) both set actually for
specified SSID only;

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c | 1 +
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.h | 6 ++++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 14c2b5d7dbbd..6e869b8c5e26 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -2898,6 +2898,7 @@ int mt7615_mcu_hw_scan(struct mt7615_phy *phy, struct ieee80211_vif *vif,
 		n_ssids++;
 	}
 	req->ssid_type = n_ssids ? BIT(2) : BIT(0);
+	req->ssid_type_ext = n_ssids ? BIT(0) : 0;
 	req->ssids_num = n_ssids;
 
 	/* increase channel time for passive scan */
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
index fd40d99f5a23..2314d0b23af1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.h
@@ -327,7 +327,8 @@ struct mt7615_hw_scan_req {
 		       */
 	u8 ssid_type; /* BIT(0) wildcard SSID
 		       * BIT(1) P2P wildcard SSID
-		       * BIT(2) specified SSID
+		       * BIT(2) specified SSID + wildcard SSID
+		       * BIT(2) + ssid_type_ext BIT(0) specified SSID only
 		       */
 	u8 ssids_num;
 	u8 probe_req_num; /* Number of probe request for each SSID */
@@ -362,7 +363,8 @@ struct mt7615_hw_scan_req {
 	struct mt7615_mcu_scan_ssid ext_ssids[6];
 	u8 bssid[ETH_ALEN];
 	u8 random_mac[ETH_ALEN]; /* valid when BIT(1) in scan_func is set. */
-	u8 pad[64];
+	u8 pad[63];
+	u8 ssid_type_ext;
 } __packed;
 
 #define SCAN_DONE_EVENT_MAX_CHANNEL_NUM	64
-- 
2.26.2

