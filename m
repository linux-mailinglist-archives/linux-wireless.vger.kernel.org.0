Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D09A814EB7D
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Jan 2020 12:13:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728392AbgAaLNL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 31 Jan 2020 06:13:11 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:55770 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728342AbgAaLNL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 31 Jan 2020 06:13:11 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92.2)
        (envelope-from <luca@coelho.fi>)
        id 1ixUEW-0002GC-NL; Fri, 31 Jan 2020 13:13:09 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 31 Jan 2020 13:12:39 +0200
Message-Id: <20200131111300.891737-3-luca@coelho.fi>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200131111300.891737-1-luca@coelho.fi>
References: <20200131111300.891737-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.2
Subject: [PATCH 02/23] mac80211: simplify and improve HT/VHT/HE disable code
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Check early on that a device has support for QoS (at least 4
queues) when it supports HT/VHT/HE, so we don't have to check
this while connecting.

This lets us clean up the code there: move some of it into
channel preparation to clean up a bit more, and then change
the logic to only check the "wmm_used" flag.

Additionally, disable HE consistently when VHT is disabled.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 net/mac80211/main.c |  5 ++++
 net/mac80211/mlme.c | 68 ++++++++++++++++++++++++---------------------
 2 files changed, 42 insertions(+), 31 deletions(-)

diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index 4c2b5ba3ac09..34728cf94172 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -981,6 +981,11 @@ int ieee80211_register_hw(struct ieee80211_hw *hw)
 		if (!supp_he)
 			supp_he = !!ieee80211_get_he_sta_cap(sband);
 
+		/* HT, VHT, HE require QoS, thus >= 4 queues */
+		if (WARN_ON(local->hw.queues < IEEE80211_NUM_ACS &&
+			    (supp_ht || supp_vht || supp_he)))
+			return -EINVAL;
+
 		if (!sband->ht_cap.ht_supported)
 			continue;
 
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index cb6fd0a09e07..ffe8cb35ab43 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -164,7 +164,9 @@ ieee80211_determine_chantype(struct ieee80211_sub_if_data *sdata,
 	chandef->center_freq1 = channel->center_freq;
 
 	if (!ht_oper || !sta_ht_cap.ht_supported) {
-		ret = IEEE80211_STA_DISABLE_HT | IEEE80211_STA_DISABLE_VHT;
+		ret = IEEE80211_STA_DISABLE_HT |
+		      IEEE80211_STA_DISABLE_VHT |
+		      IEEE80211_STA_DISABLE_HE;
 		goto out;
 	}
 
@@ -185,7 +187,9 @@ ieee80211_determine_chantype(struct ieee80211_sub_if_data *sdata,
 			   "Wrong control channel: center-freq: %d ht-cfreq: %d ht->primary_chan: %d band: %d - Disabling HT\n",
 			   channel->center_freq, ht_cfreq,
 			   ht_oper->primary_chan, channel->band);
-		ret = IEEE80211_STA_DISABLE_HT | IEEE80211_STA_DISABLE_VHT;
+		ret = IEEE80211_STA_DISABLE_HT |
+		      IEEE80211_STA_DISABLE_VHT |
+		      IEEE80211_STA_DISABLE_HE;
 		goto out;
 	}
 
@@ -301,7 +305,8 @@ ieee80211_determine_chantype(struct ieee80211_sub_if_data *sdata,
 						   IEEE80211_CHAN_DISABLED)) {
 		if (WARN_ON(chandef->width == NL80211_CHAN_WIDTH_20_NOHT)) {
 			ret = IEEE80211_STA_DISABLE_HT |
-			      IEEE80211_STA_DISABLE_VHT;
+			      IEEE80211_STA_DISABLE_VHT |
+			      IEEE80211_STA_DISABLE_HE;
 			break;
 		}
 
@@ -393,6 +398,7 @@ static int ieee80211_config_bw(struct ieee80211_sub_if_data *sdata,
 
 	if (flags != (ifmgd->flags & (IEEE80211_STA_DISABLE_HT |
 				      IEEE80211_STA_DISABLE_VHT |
+				      IEEE80211_STA_DISABLE_HE |
 				      IEEE80211_STA_DISABLE_40MHZ |
 				      IEEE80211_STA_DISABLE_80P80MHZ |
 				      IEEE80211_STA_DISABLE_160MHZ)) ||
@@ -4760,10 +4766,22 @@ static int ieee80211_prep_channel(struct ieee80211_sub_if_data *sdata,
 			  IEEE80211_STA_DISABLE_80P80MHZ |
 			  IEEE80211_STA_DISABLE_160MHZ);
 
+	/* disable HT/VHT/HE if we don't support them */
+	if (!sband->ht_cap.ht_supported) {
+		ifmgd->flags |= IEEE80211_STA_DISABLE_HT;
+		ifmgd->flags |= IEEE80211_STA_DISABLE_VHT;
+		ifmgd->flags |= IEEE80211_STA_DISABLE_HE;
+	}
+
+	if (!sband->vht_cap.vht_supported)
+		ifmgd->flags |= IEEE80211_STA_DISABLE_VHT;
+
+	if (!ieee80211_get_he_sta_cap(sband))
+		ifmgd->flags |= IEEE80211_STA_DISABLE_HE;
+
 	rcu_read_lock();
 
-	if (!(ifmgd->flags & IEEE80211_STA_DISABLE_HT) &&
-	    sband->ht_cap.ht_supported) {
+	if (!(ifmgd->flags & IEEE80211_STA_DISABLE_HT)) {
 		const u8 *ht_oper_ie, *ht_cap_ie;
 
 		ht_oper_ie = ieee80211_bss_get_ie(cbss, WLAN_EID_HT_OPERATION);
@@ -4780,8 +4798,7 @@ static int ieee80211_prep_channel(struct ieee80211_sub_if_data *sdata,
 		}
 	}
 
-	if (!(ifmgd->flags & IEEE80211_STA_DISABLE_VHT) &&
-	    sband->vht_cap.vht_supported) {
+	if (!(ifmgd->flags & IEEE80211_STA_DISABLE_VHT)) {
 		const u8 *vht_oper_ie, *vht_cap;
 
 		vht_oper_ie = ieee80211_bss_get_ie(cbss,
@@ -4791,9 +4808,10 @@ static int ieee80211_prep_channel(struct ieee80211_sub_if_data *sdata,
 		if (vht_oper && !ht_oper) {
 			vht_oper = NULL;
 			sdata_info(sdata,
-				   "AP advertised VHT without HT, disabling both\n");
+				   "AP advertised VHT without HT, disabling HT/VHT/HE\n");
 			ifmgd->flags |= IEEE80211_STA_DISABLE_HT;
 			ifmgd->flags |= IEEE80211_STA_DISABLE_VHT;
+			ifmgd->flags |= IEEE80211_STA_DISABLE_HE;
 		}
 
 		vht_cap = ieee80211_bss_get_ie(cbss, WLAN_EID_VHT_CAPABILITY);
@@ -4803,9 +4821,6 @@ static int ieee80211_prep_channel(struct ieee80211_sub_if_data *sdata,
 		}
 	}
 
-	if (!ieee80211_get_he_sta_cap(sband))
-		ifmgd->flags |= IEEE80211_STA_DISABLE_HE;
-
 	if (!(ifmgd->flags & IEEE80211_STA_DISABLE_HE)) {
 		const struct cfg80211_bss_ies *ies;
 		const u8 *he_oper_ie;
@@ -4834,8 +4849,9 @@ static int ieee80211_prep_channel(struct ieee80211_sub_if_data *sdata,
 		break;
 	}
 
-	if (!have_80mhz)
+	if (!have_80mhz) {
 		ifmgd->flags |= IEEE80211_STA_DISABLE_VHT;
+	}
 
 	ifmgd->flags |= ieee80211_determine_chantype(sdata, sband,
 						     cbss->channel,
@@ -5304,27 +5320,15 @@ int ieee80211_mgd_assoc(struct ieee80211_sub_if_data *sdata,
 		}
 	}
 
-	/* Also disable HT if we don't support it or the AP doesn't use WMM */
 	sband = local->hw.wiphy->bands[req->bss->channel->band];
-	if (!sband->ht_cap.ht_supported ||
-	    local->hw.queues < IEEE80211_NUM_ACS || !bss->wmm_used ||
-	    ifmgd->flags & IEEE80211_STA_DISABLE_WMM) {
-		ifmgd->flags |= IEEE80211_STA_DISABLE_HT;
-		if (!bss->wmm_used &&
-		    !(ifmgd->flags & IEEE80211_STA_DISABLE_WMM))
-			netdev_info(sdata->dev,
-				    "disabling HT as WMM/QoS is not supported by the AP\n");
-	}
 
-	/* disable VHT if we don't support it or the AP doesn't use WMM */
-	if (!sband->vht_cap.vht_supported ||
-	    local->hw.queues < IEEE80211_NUM_ACS || !bss->wmm_used ||
-	    ifmgd->flags & IEEE80211_STA_DISABLE_WMM) {
+	/* also disable HT/VHT/HE if the AP doesn't use WMM */
+	if (!bss->wmm_used) {
+		ifmgd->flags |= IEEE80211_STA_DISABLE_HT;
 		ifmgd->flags |= IEEE80211_STA_DISABLE_VHT;
-		if (!bss->wmm_used &&
-		    !(ifmgd->flags & IEEE80211_STA_DISABLE_WMM))
-			netdev_info(sdata->dev,
-				    "disabling VHT as WMM/QoS is not supported by the AP\n");
+		ifmgd->flags |= IEEE80211_STA_DISABLE_HE;
+		netdev_info(sdata->dev,
+			    "disabling HT/VHT/HE as WMM/QoS is not supported by the AP\n");
 	}
 
 	memcpy(&ifmgd->ht_capa, &req->ht_capa, sizeof(ifmgd->ht_capa));
@@ -5456,10 +5460,12 @@ int ieee80211_mgd_assoc(struct ieee80211_sub_if_data *sdata,
 	if (req->flags & ASSOC_REQ_DISABLE_HT) {
 		ifmgd->flags |= IEEE80211_STA_DISABLE_HT;
 		ifmgd->flags |= IEEE80211_STA_DISABLE_VHT;
+		ifmgd->flags |= IEEE80211_STA_DISABLE_HE;
 	}
 
-	if (req->flags & ASSOC_REQ_DISABLE_VHT)
+	if (req->flags & ASSOC_REQ_DISABLE_VHT) {
 		ifmgd->flags |= IEEE80211_STA_DISABLE_VHT;
+	}
 
 	err = ieee80211_prep_connection(sdata, req->bss, true, override);
 	if (err)
-- 
2.24.1

