Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3676A46321E
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Nov 2021 12:17:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237792AbhK3LUZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 30 Nov 2021 06:20:25 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:49984 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S236273AbhK3LUW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 30 Nov 2021 06:20:22 -0500
Received: from 91-156-5-105.elisa-laajakaista.fi ([91.156.5.105] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <luca@coelho.fi>)
        id 1ms188-0013Y3-EH; Tue, 30 Nov 2021 13:17:01 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     johannes@sipsolutions.net
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Tue, 30 Nov 2021 13:16:59 +0200
Message-Id: <iwlwifi.20211130131608.ac51d574458c.If197b45c5b31d2fbd254fa12c2d7c736f304d4ae@changeid>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <iwlwifi.20211129152938.9e81043f04f6.If197b45c5b31d2fbd254fa12c2d7c736f304d4ae@changeid>
References: <iwlwifi.20211129152938.9e81043f04f6.If197b45c5b31d2fbd254fa12c2d7c736f304d4ae@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH v2] mac80211: add more HT/VHT/HE state logging
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Add more logging in places that affect HT/VHT/HE state, so
things get easier to debug.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---

In v2:
  * removed "if (vht_cap)" in one of the changes.  Merge mistake.

net/mac80211/mlme.c | 45 +++++++++++++++++++++++++++++++++------------
 1 file changed, 33 insertions(+), 12 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 54ab0e1ef6ca..666955ef300f 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -164,12 +164,15 @@ ieee80211_determine_chantype(struct ieee80211_sub_if_data *sdata,
 	chandef->freq1_offset = channel->freq_offset;
 
 	if (channel->band == NL80211_BAND_6GHZ) {
-		if (!ieee80211_chandef_he_6ghz_oper(sdata, he_oper, chandef))
+		if (!ieee80211_chandef_he_6ghz_oper(sdata, he_oper, chandef)) {
+			mlme_dbg(sdata,
+				 "bad 6 GHz operation, disabling HT/VHT/HE\n");
 			ret = IEEE80211_STA_DISABLE_HT |
 			      IEEE80211_STA_DISABLE_VHT |
 			      IEEE80211_STA_DISABLE_HE;
-		else
+		} else {
 			ret = 0;
+		}
 		vht_chandef = *chandef;
 		goto out;
 	} else if (sband->band == NL80211_BAND_S1GHZ) {
@@ -190,6 +193,7 @@ ieee80211_determine_chantype(struct ieee80211_sub_if_data *sdata,
 	ieee80211_apply_htcap_overrides(sdata, &sta_ht_cap);
 
 	if (!ht_oper || !sta_ht_cap.ht_supported) {
+		mlme_dbg(sdata, "HT operation missing / HT not supported\n");
 		ret = IEEE80211_STA_DISABLE_HT |
 		      IEEE80211_STA_DISABLE_VHT |
 		      IEEE80211_STA_DISABLE_HE;
@@ -223,6 +227,7 @@ ieee80211_determine_chantype(struct ieee80211_sub_if_data *sdata,
 	if (sta_ht_cap.cap & IEEE80211_HT_CAP_SUP_WIDTH_20_40) {
 		ieee80211_chandef_ht_oper(ht_oper, chandef);
 	} else {
+		mlme_dbg(sdata, "40 MHz not supported\n");
 		/* 40 MHz (and 80 MHz) must be supported for VHT */
 		ret = IEEE80211_STA_DISABLE_VHT;
 		/* also mark 40 MHz disabled */
@@ -231,6 +236,7 @@ ieee80211_determine_chantype(struct ieee80211_sub_if_data *sdata,
 	}
 
 	if (!vht_oper || !sband->vht_cap.vht_supported) {
+		mlme_dbg(sdata, "VHT operation missing / VHT not supported\n");
 		ret = IEEE80211_STA_DISABLE_VHT;
 		goto out;
 	}
@@ -253,7 +259,7 @@ ieee80211_determine_chantype(struct ieee80211_sub_if_data *sdata,
 						&vht_chandef)) {
 			if (!(ifmgd->flags & IEEE80211_STA_DISABLE_HE))
 				sdata_info(sdata,
-					   "HE AP VHT information is invalid, disable HE\n");
+					   "HE AP VHT information is invalid, disabling HE\n");
 			ret = IEEE80211_STA_DISABLE_HE;
 			goto out;
 		}
@@ -263,7 +269,7 @@ ieee80211_determine_chantype(struct ieee80211_sub_if_data *sdata,
 					       &vht_chandef)) {
 		if (!(ifmgd->flags & IEEE80211_STA_DISABLE_VHT))
 			sdata_info(sdata,
-				   "AP VHT information is invalid, disable VHT\n");
+				   "AP VHT information is invalid, disabling VHT\n");
 		ret = IEEE80211_STA_DISABLE_VHT;
 		goto out;
 	}
@@ -271,7 +277,7 @@ ieee80211_determine_chantype(struct ieee80211_sub_if_data *sdata,
 	if (!cfg80211_chandef_valid(&vht_chandef)) {
 		if (!(ifmgd->flags & IEEE80211_STA_DISABLE_VHT))
 			sdata_info(sdata,
-				   "AP VHT information is invalid, disable VHT\n");
+				   "AP VHT information is invalid, disabling VHT\n");
 		ret = IEEE80211_STA_DISABLE_VHT;
 		goto out;
 	}
@@ -284,7 +290,7 @@ ieee80211_determine_chantype(struct ieee80211_sub_if_data *sdata,
 	if (!cfg80211_chandef_compatible(chandef, &vht_chandef)) {
 		if (!(ifmgd->flags & IEEE80211_STA_DISABLE_VHT))
 			sdata_info(sdata,
-				   "AP VHT information doesn't match HT, disable VHT\n");
+				   "AP VHT information doesn't match HT, disabling VHT\n");
 		ret = IEEE80211_STA_DISABLE_VHT;
 		goto out;
 	}
@@ -5036,19 +5042,23 @@ static int ieee80211_prep_channel(struct ieee80211_sub_if_data *sdata,
 
 	/* disable HT/VHT/HE if we don't support them */
 	if (!sband->ht_cap.ht_supported && !is_6ghz) {
+		mlme_dbg(sdata, "HT not supported, disabling HT/VHT/HE\n");
 		ifmgd->flags |= IEEE80211_STA_DISABLE_HT;
 		ifmgd->flags |= IEEE80211_STA_DISABLE_VHT;
 		ifmgd->flags |= IEEE80211_STA_DISABLE_HE;
 	}
 
 	if (!sband->vht_cap.vht_supported && is_5ghz) {
+		mlme_dbg(sdata, "VHT not supported, disabling VHT/HE\n");
 		ifmgd->flags |= IEEE80211_STA_DISABLE_VHT;
 		ifmgd->flags |= IEEE80211_STA_DISABLE_HE;
 	}
 
 	if (!ieee80211_get_he_iftype_cap(sband,
-					 ieee80211_vif_type_p2p(&sdata->vif)))
+					 ieee80211_vif_type_p2p(&sdata->vif))) {
+		mlme_dbg(sdata, "HE not supported, disabling it\n");
 		ifmgd->flags |= IEEE80211_STA_DISABLE_HE;
+	}
 
 	if (!(ifmgd->flags & IEEE80211_STA_DISABLE_HT) && !is_6ghz) {
 		ht_oper = elems->ht_operation;
@@ -5072,6 +5082,8 @@ static int ieee80211_prep_channel(struct ieee80211_sub_if_data *sdata,
 		}
 
 		if (!elems->vht_cap_elem) {
+			sdata_info(sdata,
+				   "bad VHT capabilities, disabling VHT\n");
 			ifmgd->flags |= IEEE80211_STA_DISABLE_VHT;
 			vht_oper = NULL;
 		}
@@ -5119,8 +5131,10 @@ static int ieee80211_prep_channel(struct ieee80211_sub_if_data *sdata,
 		break;
 	}
 
-	if (!have_80mhz)
+	if (!have_80mhz) {
+		sdata_info(sdata, "80 MHz not supported, disabling VHT\n");
 		ifmgd->flags |= IEEE80211_STA_DISABLE_VHT;
+	}
 
 	if (sband->band == NL80211_BAND_S1GHZ) {
 		s1g_oper = elems->s1g_oper;
@@ -5684,12 +5698,14 @@ int ieee80211_mgd_assoc(struct ieee80211_sub_if_data *sdata,
 	else if (!is_6ghz)
 		ifmgd->flags |= IEEE80211_STA_DISABLE_HT;
 	vht_elem = ieee80211_bss_get_elem(req->bss, WLAN_EID_VHT_CAPABILITY);
-	if (vht_elem && vht_elem->datalen >= sizeof(struct ieee80211_vht_cap))
+	if (vht_elem && vht_elem->datalen >= sizeof(struct ieee80211_vht_cap)) {
 		memcpy(&assoc_data->ap_vht_cap, vht_elem->data,
 		       sizeof(struct ieee80211_vht_cap));
-	else if (is_5ghz)
+	} else if (is_5ghz) {
+		sdata_info(sdata, "VHT capa missing/short, disabling VHT/HE\n");
 		ifmgd->flags |= IEEE80211_STA_DISABLE_VHT |
 				IEEE80211_STA_DISABLE_HE;
+	}
 	rcu_read_unlock();
 
 	if (WARN((sdata->vif.driver_flags & IEEE80211_VIF_SUPPORTS_UAPSD) &&
@@ -5763,16 +5779,21 @@ int ieee80211_mgd_assoc(struct ieee80211_sub_if_data *sdata,
 	}
 
 	if (req->flags & ASSOC_REQ_DISABLE_HT) {
+		mlme_dbg(sdata, "HT disabled by flag, disabling HT/VHT/HE\n");
 		ifmgd->flags |= IEEE80211_STA_DISABLE_HT;
 		ifmgd->flags |= IEEE80211_STA_DISABLE_VHT;
 		ifmgd->flags |= IEEE80211_STA_DISABLE_HE;
 	}
 
-	if (req->flags & ASSOC_REQ_DISABLE_VHT)
+	if (req->flags & ASSOC_REQ_DISABLE_VHT) {
+		mlme_dbg(sdata, "VHT disabled by flag, disabling VHT\n");
 		ifmgd->flags |= IEEE80211_STA_DISABLE_VHT;
+	}
 
-	if (req->flags & ASSOC_REQ_DISABLE_HE)
+	if (req->flags & ASSOC_REQ_DISABLE_HE) {
+		mlme_dbg(sdata, "HE disabled by flag, disabling VHT\n");
 		ifmgd->flags |= IEEE80211_STA_DISABLE_HE;
+	}
 
 	err = ieee80211_prep_connection(sdata, req->bss, true, override);
 	if (err)
-- 
2.33.1

