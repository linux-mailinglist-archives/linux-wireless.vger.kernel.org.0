Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52F863F95C2
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Aug 2021 10:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232429AbhH0II2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 27 Aug 2021 04:08:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:40552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229934AbhH0II1 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 27 Aug 2021 04:08:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ADEEB60F92;
        Fri, 27 Aug 2021 08:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630051659;
        bh=803+olIs/kRyZpa883FwRkm2iNYeZZsVCqv6D4j1FKE=;
        h=From:To:Cc:Subject:Date:From;
        b=WRCxT74wVAsBPmZFW8ayXXWCjGfhW5pIi4sm+Bu6Uw4YJWkFkI+f853PQEoK1rZTJ
         ibtO/iTJH5TLQNxwjZa0z+ttwIi2GNMf9ueBZ8dIueLnnpuMEUy5P5CvPf/0YAv6zw
         EGen2e4jetH/d9RktBFWPWOMW+47/6rBTV8iaIJiwcQSRLpg8FUKbN+ngKZm7PCrEp
         JuGsbEg6V+4sthRAmf6MR7qYWhJN3CcZ0ia3a+QS2bu+3Ijcpwa0Lzd4FRngOsGCVX
         OkJIYCbEeCwE60jEW++sTUAzZwcKsLncVw3vUpgyjBSSIR/f654XCzq/xhuF8AoXZz
         zkn2GJiqK09Cw==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: [PATCH mac80211-next] mac80211: check hostapd configuration parsing twt requests
Date:   Fri, 27 Aug 2021 10:07:19 +0200
Message-Id: <516057fe4ca73ad257e8c2762e25f4b7872957fc.1630051438.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Check twt_responder in ieee80211_process_rx_twt_action routine
in order to take into account the case where twt has been disabled
in hostapd configuration.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 net/mac80211/rx.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 99ed68f7dc36..8acc743559c3 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -3216,10 +3216,7 @@ static bool
 ieee80211_process_rx_twt_action(struct ieee80211_rx_data *rx)
 {
 	struct ieee80211_mgmt *mgmt = (struct ieee80211_mgmt *)rx->skb->data;
-	struct ieee80211_rx_status *status = IEEE80211_SKB_RXCB(rx->skb);
 	struct ieee80211_sub_if_data *sdata = rx->sdata;
-	const struct ieee80211_sta_he_cap *hecap;
-	struct ieee80211_supported_band *sband;
 
 	/* TWT actions are only supported in AP for the moment */
 	if (sdata->vif.type != NL80211_IFTYPE_AP)
@@ -3228,14 +3225,7 @@ ieee80211_process_rx_twt_action(struct ieee80211_rx_data *rx)
 	if (!rx->local->ops->add_twt_setup)
 		return false;
 
-	sband = rx->local->hw.wiphy->bands[status->band];
-	hecap = ieee80211_get_he_iftype_cap(sband,
-					    ieee80211_vif_type_p2p(&sdata->vif));
-	if (!hecap)
-		return false;
-
-	if (!(hecap->he_cap_elem.mac_cap_info[0] &
-	      IEEE80211_HE_MAC_CAP0_TWT_RES))
+	if (!sdata->vif.bss_conf.twt_responder)
 		return false;
 
 	if (!rx->sta)
-- 
2.31.1

