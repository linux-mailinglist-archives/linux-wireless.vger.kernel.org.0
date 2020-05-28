Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB00E1E6B2F
	for <lists+linux-wireless@lfdr.de>; Thu, 28 May 2020 21:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406666AbgE1Tg6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 May 2020 15:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406664AbgE1Tgx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 May 2020 15:36:53 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FFF9C08C5C6
        for <linux-wireless@vger.kernel.org>; Thu, 28 May 2020 12:36:53 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jeOIr-0054OL-Dn; Thu, 28 May 2020 21:34:57 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Rajkumar Manoharan <rmanohar@codeaurora.org>,
        Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>,
        Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH v2 16/24] mac80211: Add HE 6GHz capabilities element to probe request
Date:   Thu, 28 May 2020 21:34:39 +0200
Message-Id: <20200528213443.8ee764f0cde0.I2b0c66b60e11818c97c9803e04a6a197c6376243@changeid>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200528213443.993f108e96ca.I0086ae42d672379380d04ac5effb2f3d5135731b@changeid>
References: <20200528213443.993f108e96ca.I0086ae42d672379380d04ac5effb2f3d5135731b@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ilan Peer <ilan.peer@intel.com>

On 6 GHz, the 6 GHz capabilities element should be added, do that.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
[add commit message]
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/net/cfg80211.h     | 20 ++++++++++++++++++++
 net/mac80211/ieee80211_i.h |  2 +-
 net/mac80211/scan.c        | 17 +++++++++--------
 net/mac80211/util.c        | 36 ++++++++++++++++++++++++++++--------
 4 files changed, 58 insertions(+), 17 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 9b76be3d561a..95b55eea2afb 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -512,6 +512,26 @@ ieee80211_get_he_sta_cap(const struct ieee80211_supported_band *sband)
 	return ieee80211_get_he_iftype_cap(sband, NL80211_IFTYPE_STATION);
 }
 
+/**
+ * ieee80211_get_he_6ghz_capa - return HE 6 GHz capabilities
+ * @sband: the sband to search for the STA on
+ * @iftype: the iftype to search for
+ *
+ * Return: the 6GHz capabilities
+ */
+static inline __le16
+ieee80211_get_he_6ghz_capa(const struct ieee80211_supported_band *sband,
+			   enum nl80211_iftype iftype)
+{
+	const struct ieee80211_sband_iftype_data *data =
+		ieee80211_get_sband_iftype_data(sband, iftype);
+
+	if (WARN_ON(!data || !data->he_cap.has_he))
+		return 0;
+
+	return data->he_6ghz_capa.capa;
+}
+
 /**
  * wiphy_read_of_freq_limits - read frequency limits from device tree
  *
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 24dc1fd57000..ec1a71ac65f2 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2144,7 +2144,7 @@ enum {
 	IEEE80211_PROBE_FLAG_RANDOM_SN		= BIT(2),
 };
 
-int ieee80211_build_preq_ies(struct ieee80211_local *local, u8 *buffer,
+int ieee80211_build_preq_ies(struct ieee80211_sub_if_data *sdata, u8 *buffer,
 			     size_t buffer_len,
 			     struct ieee80211_scan_ies *ie_desc,
 			     const u8 *ie, size_t ie_len,
diff --git a/net/mac80211/scan.c b/net/mac80211/scan.c
index d0c2e8012118..ad90bbe57457 100644
--- a/net/mac80211/scan.c
+++ b/net/mac80211/scan.c
@@ -313,8 +313,9 @@ ieee80211_prepare_scan_chandef(struct cfg80211_chan_def *chandef,
 }
 
 /* return false if no more work */
-static bool ieee80211_prep_hw_scan(struct ieee80211_local *local)
+static bool ieee80211_prep_hw_scan(struct ieee80211_sub_if_data *sdata)
 {
+	struct ieee80211_local *local = sdata->local;
 	struct cfg80211_scan_request *req;
 	struct cfg80211_chan_def chandef;
 	u8 bands_used = 0;
@@ -361,7 +362,7 @@ static bool ieee80211_prep_hw_scan(struct ieee80211_local *local)
 	if (req->flags & NL80211_SCAN_FLAG_MIN_PREQ_CONTENT)
 		flags |= IEEE80211_PROBE_FLAG_MIN_CONTENT;
 
-	ielen = ieee80211_build_preq_ies(local,
+	ielen = ieee80211_build_preq_ies(sdata,
 					 (u8 *)local->hw_scan_req->req.ie,
 					 local->hw_scan_ies_bufsize,
 					 &local->hw_scan_req->ies,
@@ -401,9 +402,12 @@ static void __ieee80211_scan_completed(struct ieee80211_hw *hw, bool aborted)
 	if (WARN_ON(!local->scan_req))
 		return;
 
+	scan_sdata = rcu_dereference_protected(local->scan_sdata,
+					       lockdep_is_held(&local->mtx));
+
 	if (hw_scan && !aborted &&
 	    !ieee80211_hw_check(&local->hw, SINGLE_SCAN_ON_ALL_BANDS) &&
-	    ieee80211_prep_hw_scan(local)) {
+	    ieee80211_prep_hw_scan(scan_sdata)) {
 		int rc;
 
 		rc = drv_hw_scan(local,
@@ -432,9 +436,6 @@ static void __ieee80211_scan_completed(struct ieee80211_hw *hw, bool aborted)
 		cfg80211_scan_done(scan_req, &local->scan_info);
 	}
 	RCU_INIT_POINTER(local->scan_req, NULL);
-
-	scan_sdata = rcu_dereference_protected(local->scan_sdata,
-					       lockdep_is_held(&local->mtx));
 	RCU_INIT_POINTER(local->scan_sdata, NULL);
 
 	local->scanning = 0;
@@ -776,7 +777,7 @@ static int __ieee80211_start_scan(struct ieee80211_sub_if_data *sdata,
 	ieee80211_recalc_idle(local);
 
 	if (hw_scan) {
-		WARN_ON(!ieee80211_prep_hw_scan(local));
+		WARN_ON(!ieee80211_prep_hw_scan(sdata));
 		rc = drv_hw_scan(local, sdata, local->hw_scan_req);
 	} else {
 		rc = ieee80211_start_sw_scan(local, sdata);
@@ -1274,7 +1275,7 @@ int __ieee80211_request_sched_scan_start(struct ieee80211_sub_if_data *sdata,
 
 	ieee80211_prepare_scan_chandef(&chandef, req->scan_width);
 
-	ieee80211_build_preq_ies(local, ie, num_bands * iebufsz,
+	ieee80211_build_preq_ies(sdata, ie, num_bands * iebufsz,
 				 &sched_scan_ies, req->ie,
 				 req->ie_len, bands_used, rate_masks, &chandef,
 				 flags);
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index cbe24d303f0d..21c94094a699 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -1663,7 +1663,20 @@ void ieee80211_send_deauth_disassoc(struct ieee80211_sub_if_data *sdata,
 	}
 }
 
-static int ieee80211_build_preq_ies_band(struct ieee80211_local *local,
+static u8 *ieee80211_write_he_6ghz_cap(u8 *pos, __le16 cap, u8 *end)
+{
+	if ((end - pos) < 5)
+		return pos;
+
+	*pos++ = WLAN_EID_EXTENSION;
+	*pos++ = 1 + sizeof(cap);
+	*pos++ = WLAN_EID_EXT_HE_6GHZ_CAPA;
+	memcpy(pos, &cap, sizeof(cap));
+
+	return pos + 2;
+}
+
+static int ieee80211_build_preq_ies_band(struct ieee80211_sub_if_data *sdata,
 					 u8 *buffer, size_t buffer_len,
 					 const u8 *ie, size_t ie_len,
 					 enum nl80211_band band,
@@ -1671,6 +1684,7 @@ static int ieee80211_build_preq_ies_band(struct ieee80211_local *local,
 					 struct cfg80211_chan_def *chandef,
 					 size_t *offset, u32 flags)
 {
+	struct ieee80211_local *local = sdata->local;
 	struct ieee80211_supported_band *sband;
 	const struct ieee80211_sta_he_cap *he_cap;
 	u8 *pos = buffer, *end = buffer + buffer_len;
@@ -1848,6 +1862,14 @@ static int ieee80211_build_preq_ies_band(struct ieee80211_local *local,
 		pos = ieee80211_ie_build_he_cap(pos, he_cap, end);
 		if (!pos)
 			goto out_err;
+
+		if (sband->band == NL80211_BAND_6GHZ) {
+			enum nl80211_iftype iftype =
+				ieee80211_vif_type_p2p(&sdata->vif);
+			__le16 cap = ieee80211_get_he_6ghz_capa(sband, iftype);
+
+			pos = ieee80211_write_he_6ghz_cap(pos, cap, end);
+		}
 	}
 
 	/*
@@ -1862,7 +1884,7 @@ static int ieee80211_build_preq_ies_band(struct ieee80211_local *local,
 	return pos - buffer;
 }
 
-int ieee80211_build_preq_ies(struct ieee80211_local *local, u8 *buffer,
+int ieee80211_build_preq_ies(struct ieee80211_sub_if_data *sdata, u8 *buffer,
 			     size_t buffer_len,
 			     struct ieee80211_scan_ies *ie_desc,
 			     const u8 *ie, size_t ie_len,
@@ -1877,7 +1899,7 @@ int ieee80211_build_preq_ies(struct ieee80211_local *local, u8 *buffer,
 
 	for (i = 0; i < NUM_NL80211_BANDS; i++) {
 		if (bands_used & BIT(i)) {
-			pos += ieee80211_build_preq_ies_band(local,
+			pos += ieee80211_build_preq_ies_band(sdata,
 							     buffer + pos,
 							     buffer_len - pos,
 							     ie, ie_len, i,
@@ -1939,7 +1961,7 @@ struct sk_buff *ieee80211_build_probe_req(struct ieee80211_sub_if_data *sdata,
 		return NULL;
 
 	rate_masks[chan->band] = ratemask;
-	ies_len = ieee80211_build_preq_ies(local, skb_tail_pointer(skb),
+	ies_len = ieee80211_build_preq_ies(sdata, skb_tail_pointer(skb),
 					   skb_tailroom(skb), &dummy_ie_desc,
 					   ie, ie_len, BIT(chan->band),
 					   rate_masks, &chandef, flags);
@@ -2879,10 +2901,8 @@ void ieee80211_ie_build_he_6ghz_cap(struct ieee80211_sub_if_data *sdata,
 	}
 
 	pos = skb_put(skb, 2 + 1 + sizeof(cap));
-	*pos++ = WLAN_EID_EXTENSION;
-	*pos++ = 1 + sizeof(cap);
-	*pos++ = WLAN_EID_EXT_HE_6GHZ_CAPA;
-	put_unaligned_le16(cap, pos);
+	ieee80211_write_he_6ghz_cap(pos, cpu_to_le16(cap),
+				    pos + 2 + 1 + sizeof(cap));
 }
 
 u8 *ieee80211_ie_build_ht_oper(u8 *pos, struct ieee80211_sta_ht_cap *ht_cap,
-- 
2.26.2

