Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F29D03AC950
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Jun 2021 13:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbhFRLFY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 18 Jun 2021 07:05:24 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:48264 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229550AbhFRLFX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 18 Jun 2021 07:05:23 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.lan)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1luBx7-001YXx-Bn; Fri, 18 Jun 2021 13:42:23 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     johannes@sipsolutions.net
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Fri, 18 Jun 2021 13:41:50 +0300
Message-Id: <iwlwifi.20210618133832.ede114bc8b46.Ibcd9a5d98430e936344eb6d242ef8a65c2f59b74@changeid>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618104156.747775-1-luca@coelho.fi>
References: <20210618104156.747775-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: [PATCH 25/31] mac80211: remove use of ieee80211_get_he_sta_cap()
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

All uses of ieee80211_get_he_sta_cap() were actually wrong,
in net/mac80211/mlme.c they were wrong because that code is
also used for P2P (which is a different interface type), in
net/mac80211/main.c that should check all interface types.
Fix all that.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 net/mac80211/main.c |  9 +++++++--
 net/mac80211/mlme.c | 23 +++++++++++++++--------
 2 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index da3e0ca6aa31..2e3f8a479f83 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -1008,8 +1008,13 @@ int ieee80211_register_hw(struct ieee80211_hw *hw)
 		supp_ht = supp_ht || sband->ht_cap.ht_supported;
 		supp_vht = supp_vht || sband->vht_cap.vht_supported;
 
-		if (!supp_he)
-			supp_he = !!ieee80211_get_he_sta_cap(sband);
+		for (i = 0; i < sband->n_iftype_data; i++) {
+			const struct ieee80211_sband_iftype_data *iftd;
+
+			iftd = &sband->iftype_data[i];
+
+			supp_he = supp_he || (iftd && iftd->he_cap.has_he);
+		}
 
 		/* HT, VHT, HE require QoS, thus >= 4 queues */
 		if (WARN_ON(local->hw.queues < IEEE80211_NUM_ACS &&
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index a0d77539d1d9..a5d0f62de5c3 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -384,7 +384,9 @@ static int ieee80211_config_bw(struct ieee80211_sub_if_data *sdata,
 
 	/* don't check HE if we associated as non-HE station */
 	if (ifmgd->flags & IEEE80211_STA_DISABLE_HE ||
-	    !ieee80211_get_he_sta_cap(sband))
+	    !ieee80211_get_he_iftype_cap(sband,
+					 ieee80211_vif_type_p2p(&sdata->vif)))
+
 		he_oper = NULL;
 
 	if (WARN_ON_ONCE(!sta))
@@ -642,7 +644,8 @@ static void ieee80211_add_he_ie(struct ieee80211_sub_if_data *sdata,
 
 	rcu_read_unlock();
 
-	he_cap = ieee80211_get_he_sta_cap(sband);
+	he_cap = ieee80211_get_he_iftype_cap(sband,
+					     ieee80211_vif_type_p2p(&sdata->vif));
 	if (!he_cap || !reg_cap)
 		return;
 
@@ -3227,12 +3230,14 @@ static int ieee80211_recalc_twt_req(struct ieee80211_sub_if_data *sdata,
 	return 0;
 }
 
-static bool ieee80211_twt_bcast_support(struct ieee80211_bss_conf *bss_conf,
+static bool ieee80211_twt_bcast_support(struct ieee80211_sub_if_data *sdata,
+					struct ieee80211_bss_conf *bss_conf,
 					struct ieee80211_supported_band *sband,
 					struct sta_info *sta)
 {
 	const struct ieee80211_sta_he_cap *own_he_cap =
-		ieee80211_get_he_sta_cap(sband);
+		ieee80211_get_he_iftype_cap(sband,
+					    ieee80211_vif_type_p2p(&sdata->vif));
 
 	return bss_conf->he_support &&
 		(sta->sta.he_cap.he_cap_elem.mac_cap_info[2] &
@@ -3458,7 +3463,7 @@ static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
 	}
 
 	bss_conf->twt_broadcast =
-		ieee80211_twt_bcast_support(bss_conf, sband, sta);
+		ieee80211_twt_bcast_support(sdata, bss_conf, sband, sta);
 
 	if (bss_conf->he_support) {
 		bss_conf->he_bss_color.color =
@@ -4860,11 +4865,13 @@ static u8 ieee80211_ht_vht_rx_chains(struct ieee80211_sub_if_data *sdata,
 }
 
 static bool
-ieee80211_verify_sta_he_mcs_support(struct ieee80211_supported_band *sband,
+ieee80211_verify_sta_he_mcs_support(struct ieee80211_sub_if_data *sdata,
+				    struct ieee80211_supported_band *sband,
 				    const struct ieee80211_he_operation *he_op)
 {
 	const struct ieee80211_sta_he_cap *sta_he_cap =
-		ieee80211_get_he_sta_cap(sband);
+		ieee80211_get_he_iftype_cap(sband,
+					    ieee80211_vif_type_p2p(&sdata->vif));
 	u16 ap_min_req_set;
 	int i;
 
@@ -5017,7 +5024,7 @@ static int ieee80211_prep_channel(struct ieee80211_sub_if_data *sdata,
 		else
 			he_oper = NULL;
 
-		if (!ieee80211_verify_sta_he_mcs_support(sband, he_oper))
+		if (!ieee80211_verify_sta_he_mcs_support(sdata, sband, he_oper))
 			ifmgd->flags |= IEEE80211_STA_DISABLE_HE;
 	}
 
-- 
2.32.0

