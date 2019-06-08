Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BBC673A04C
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Jun 2019 16:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbfFHOos (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 8 Jun 2019 10:44:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:46508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726997AbfFHOos (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 8 Jun 2019 10:44:48 -0400
Received: from localhost.localdomain (unknown [151.66.40.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F301A206DF;
        Sat,  8 Jun 2019 14:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560005088;
        bh=i8zFviISTazOLJc7SYJdrmMB4mCyhEFOjiqXtx9Jjdc=;
        h=From:To:Cc:Subject:Date:From;
        b=SxbWq6BzkKmySby+i9JWTVCtbAc5eEGiSR0Lbvx0AqyoGGQNy1Rlv5v/BLfcslXa7
         2wDo9f+ZyrKx863705QfJ7TMtEvgSJmnOkrbwjTDp9QcSi98eEfTltpl2KNx78gf5Q
         nkhF4N8G7WBj/tWwpwQ+4Fn/kyKlsb5b3nkLvgqI=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com, royluo@google.com
Subject: [PATCH] mt76: mt7615: simplify mt7615_mcu_set_sta_rec routine
Date:   Sat,  8 Jun 2019 16:44:36 +0200
Message-Id: <09886024bfc9af6cd513c41bf542413ff4d36087.1560004247.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Move conn_type configuration directly in mt7615_mcu_set_sta_rec and
remove sta_rec_convert_vif_type since it is actually used just in
mt7615_mcu_set_sta_rec

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   | 33 +++++++------------
 1 file changed, 12 insertions(+), 21 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 76431d00a8ac..79baa455034c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -1040,30 +1040,11 @@ int mt7615_mcu_set_sta_rec_bmc(struct mt7615_dev *dev,
 				   &req, sizeof(req), true);
 }
 
-static void sta_rec_convert_vif_type(enum nl80211_iftype type, u32 *conn_type)
-{
-	switch (type) {
-	case NL80211_IFTYPE_AP:
-	case NL80211_IFTYPE_MESH_POINT:
-		if (conn_type)
-			*conn_type = CONNECTION_INFRA_STA;
-		break;
-	case NL80211_IFTYPE_STATION:
-		if (conn_type)
-			*conn_type = CONNECTION_INFRA_AP;
-		break;
-	default:
-		WARN_ON(1);
-		break;
-	};
-}
-
 int mt7615_mcu_set_sta_rec(struct mt7615_dev *dev, struct ieee80211_vif *vif,
 			   struct ieee80211_sta *sta, bool en)
 {
 	struct mt7615_vif *mvif = (struct mt7615_vif *)vif->drv_priv;
 	struct mt7615_sta *msta = (struct mt7615_sta *)sta->drv_priv;
-	u32 conn_type = 0;
 
 	struct {
 		struct sta_req_hdr hdr;
@@ -1085,8 +1066,18 @@ int mt7615_mcu_set_sta_rec(struct mt7615_dev *dev, struct ieee80211_vif *vif,
 	};
 	memcpy(req.basic.peer_addr, sta->addr, ETH_ALEN);
 
-	sta_rec_convert_vif_type(vif->type, &conn_type);
-	req.basic.conn_type = cpu_to_le32(conn_type);
+	switch (vif->type) {
+	case NL80211_IFTYPE_AP:
+	case NL80211_IFTYPE_MESH_POINT:
+		req.basic.conn_type = cpu_to_le32(CONNECTION_INFRA_STA);
+		break;
+	case NL80211_IFTYPE_STATION:
+		req.basic.conn_type = cpu_to_le32(CONNECTION_INFRA_AP);
+		break;
+	default:
+		WARN_ON(1);
+		break;
+	};
 
 	if (en) {
 		req.basic.conn_state = CONN_STATE_PORT_SECURE;
-- 
2.21.0

