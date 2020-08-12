Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 447AD242BC9
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Aug 2020 17:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbgHLPBW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 12 Aug 2020 11:01:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726611AbgHLPBI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 12 Aug 2020 11:01:08 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF149C06138A
        for <linux-wireless@vger.kernel.org>; Wed, 12 Aug 2020 08:01:02 -0700 (PDT)
Received: from [149.224.82.90] (helo=localhost.localdomain)
        by ds12 with esmtpa (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1k5sFO-0002OP-QU; Wed, 12 Aug 2020 17:00:59 +0200
From:   John Crispin <john@phrozen.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        John Crispin <john@phrozen.org>
Subject: [PATCH V3 8/9] ath11k: add EMA beacon support
Date:   Wed, 12 Aug 2020 17:00:49 +0200
Message-Id: <20200812150050.2683396-9-john@phrozen.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200812150050.2683396-1-john@phrozen.org>
References: <20200812150050.2683396-1-john@phrozen.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

We need to update the beacon in multiple bssid mode after each completion
event to get the next EMA beacon.

Signed-off-by: John Crispin <john@phrozen.org>
---
 drivers/net/wireless/ath/ath11k/mac.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 08e7f4ac8a26..306f123c09a7 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -791,7 +791,10 @@ static int ath11k_mac_setup_bcn_tmpl(struct ath11k_vif *arvif)
 	if (arvif->vdev_type != WMI_VDEV_TYPE_AP)
 		return 0;
 
-	bcn = ieee80211_beacon_get_template(hw, vif, &offs);
+	if (arvif->vif->multiple_bssid.non_transmitted)
+		return 0;
+
+	bcn = ieee80211_beacon_get_template_ema(hw, vif, &offs);
 	if (!bcn) {
 		ath11k_warn(ab, "failed to get beacon template from mac80211\n");
 		return -EPERM;
@@ -822,16 +825,23 @@ static int ath11k_mac_setup_bcn_tmpl(struct ath11k_vif *arvif)
 void ath11k_mac_bcn_tx_event(struct ath11k_vif *arvif)
 {
 	struct ieee80211_vif *vif = arvif->vif;
+	int multiple_bssid = 0;
 
-	if (!vif->cca_active)
+	if (!vif->multiple_bssid.non_transmitted &&
+	    !list_empty(&vif->multiple_bssid.list))
+		multiple_bssid = 1;
+
+	if (!multiple_bssid && !vif->cca_active)
 		return;
 
-	if (ieee80211_beacon_cntdwn_is_complete(vif)) {
+	if (vif->cca_active && ieee80211_beacon_cntdwn_is_complete(vif)) {
 		ieee80211_cca_finish(vif);
 		return;
 	}
 
-	ieee80211_beacon_update_cntdwn(vif);
+	if (vif->cca_active)
+		ieee80211_beacon_update_cntdwn(vif);
+
 	ath11k_mac_setup_bcn_tmpl(arvif);
 }
 
-- 
2.25.1

