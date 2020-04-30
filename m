Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 962111C0A52
	for <lists+linux-wireless@lfdr.de>; Fri,  1 May 2020 00:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727850AbgD3WVh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Apr 2020 18:21:37 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:15153 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726817AbgD3WVg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Apr 2020 18:21:36 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588285295; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=NytPtoFqAGejpXeuYyGvbqZ8RhcyRE8u4MR1LKbWK2Q=; b=N3dUYqEV9oXDy1n5gSKB2qsOAEVKnSpMNSmmgsFULVRX357Jkd+M760qN7XpS2ytRnayrnN8
 625zlgZ0G7y1dw6MnS/Ap0TF/kLUC9RLrGpPY/xLfbhc7IRX5rA6Yb2kTlxRXBrVI90KarXe
 B2WCOSjqRuzSatowltt9HCnfbOQ=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eab4f5b.7f1065d21308-smtp-out-n02;
 Thu, 30 Apr 2020 22:21:15 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 6F90CC432C2; Thu, 30 Apr 2020 22:21:14 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from rmanohar-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rmanohar)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9BAF9C433BA;
        Thu, 30 Apr 2020 22:21:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9BAF9C433BA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=rmanohar@codeaurora.org
From:   Rajkumar Manoharan <rmanohar@codeaurora.org>
To:     johannes@sipsolutions.net, kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org,
        Rajkumar Manoharan <rmanohar@codeaurora.org>
Subject: [PATCH v2 06/11] mac80211: handle HE 6 GHz Capability in HE STA processing
Date:   Thu, 30 Apr 2020 15:20:47 -0700
Message-Id: <1588285252-30034-6-git-send-email-rmanohar@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1588285252-30034-1-git-send-email-rmanohar@codeaurora.org>
References: <1588285252-30034-1-git-send-email-rmanohar@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

During association or mesh peering of HE STA in 6 GHz band, required
HT/VHT information has to be processed from 6 GHz band capabilities
as HT/VHT IEs are not allowed in 6 GHz.

Signed-off-by: Rajkumar Manoharan <rmanohar@codeaurora.org>
---
 include/net/cfg80211.h     | 10 +++++++++
 net/mac80211/cfg.c         |  3 ++-
 net/mac80211/he.c          | 51 ++++++++++++++++++++++++++++++++++++++++++++++
 net/mac80211/ieee80211_i.h |  2 ++
 net/mac80211/mesh_plink.c  |  4 +++-
 net/mac80211/mlme.c        |  1 +
 6 files changed, 69 insertions(+), 2 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 0797a296c083..2c7bfc170604 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -332,15 +332,25 @@ struct ieee80211_sta_vht_cap {
  * to describe 802.11ax HE capabilities for a STA.
  *
  * @has_he: true iff HE data is valid.
+ * @has_he_6ghz: true iff HE 6 GHz data is valid.
  * @he_cap_elem: Fixed portion of the HE capabilities element.
  * @he_mcs_nss_supp: The supported NSS/MCS combinations.
  * @ppe_thres: Holds the PPE Thresholds data.
+ * @ampdu_factor: Maximum A-MPDU length factor used in 6 GHz.
+ * @ampdu_density: Minimum A-MPDU spacing used in 6 GHz.
+ * @cap: HE 6 GHz Band capability.
  */
 struct ieee80211_sta_he_cap {
 	bool has_he;
+	bool has_he_6ghz;
 	struct ieee80211_he_cap_elem he_cap_elem;
 	struct ieee80211_he_mcs_nss_supp he_mcs_nss_supp;
 	u8 ppe_thres[IEEE80211_HE_PPE_THRES_MAX_LEN];
+	struct {
+		u8 ampdu_factor;
+		u8 ampdu_density;
+		u16 cap;
+	} he_6ghz;
 };
 
 /**
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 0f72813fed53..591c3c7324e3 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1508,7 +1508,8 @@ static int sta_apply_parameters(struct ieee80211_local *local,
 	if (params->he_capa)
 		ieee80211_he_cap_ie_to_sta_he_cap(sdata, sband,
 						  (void *)params->he_capa,
-						  params->he_capa_len, sta);
+						  params->he_capa_len,
+						  params->he_6ghz_capa, sta);
 
 	if (params->opmode_notif_used) {
 		/* returned value is only needed for rc update, but the
diff --git a/net/mac80211/he.c b/net/mac80211/he.c
index f520552b22be..4376fa5e6336 100644
--- a/net/mac80211/he.c
+++ b/net/mac80211/he.c
@@ -12,10 +12,14 @@ void
 ieee80211_he_cap_ie_to_sta_he_cap(struct ieee80211_sub_if_data *sdata,
 				  struct ieee80211_supported_band *sband,
 				  const u8 *he_cap_ie, u8 he_cap_len,
+				  const struct ieee80211_he_6ghz_band_cap
+					*he_6ghz_cap_ie,
 				  struct sta_info *sta)
 {
 	struct ieee80211_sta_he_cap *he_cap = &sta->sta.he_cap;
 	struct ieee80211_he_cap_elem *he_cap_ie_elem = (void *)he_cap_ie;
+	enum ieee80211_smps_mode smps_mode;
+	u16 cap;
 	u8 he_ppe_size;
 	u8 mcs_nss_size;
 	u8 he_total_size;
@@ -53,6 +57,53 @@ ieee80211_he_cap_ie_to_sta_he_cap(struct ieee80211_sub_if_data *sdata,
 
 	sta->cur_max_bandwidth = ieee80211_sta_cap_rx_bw(sta);
 	sta->sta.bandwidth = ieee80211_sta_cur_vht_bw(sta);
+
+	if (!he_6ghz_cap_ie)
+		return;
+
+	cap = __le16_to_cpu(he_6ghz_cap_ie->capab);
+
+	he_cap->he_6ghz.ampdu_density =
+		FIELD_GET(IEEE80211_HE_6GHZ_CAP_MIN_MPDU_START_SPACE_MASK,
+			  cap);
+	he_cap->he_6ghz.ampdu_factor =
+		FIELD_GET(IEEE80211_HE_6GHZ_CAP_MAX_A_MPDU_LENGTH_EXPONENT_MASK,
+			  cap);
+
+	switch (FIELD_GET(IEEE80211_HE_6GHZ_CAP_MAX_MPDU_LENGTH_MASK, cap)) {
+	case IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_11454:
+		sta->sta.max_amsdu_len = IEEE80211_MAX_MPDU_LEN_VHT_11454;
+		break;
+	case IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_7991:
+		sta->sta.max_amsdu_len = IEEE80211_MAX_MPDU_LEN_VHT_7991;
+		break;
+	case IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_3895:
+	default:
+		sta->sta.max_amsdu_len = IEEE80211_MAX_MPDU_LEN_VHT_3895;
+		break;
+	}
+
+	switch (FIELD_GET(IEEE80211_HE_6GHZ_CAP_SMPS_MASK, cap)) {
+	case WLAN_HT_CAP_SM_PS_INVALID:
+	case WLAN_HT_CAP_SM_PS_STATIC:
+		smps_mode = IEEE80211_SMPS_STATIC;
+		break;
+	case WLAN_HT_CAP_SM_PS_DYNAMIC:
+		smps_mode = IEEE80211_SMPS_DYNAMIC;
+		break;
+	case WLAN_HT_CAP_SM_PS_DISABLED:
+		smps_mode = IEEE80211_SMPS_OFF;
+		break;
+	}
+
+	if (sta->sdata->vif.type == NL80211_IFTYPE_AP ||
+	    sta->sdata->vif.type == NL80211_IFTYPE_AP_VLAN)
+		sta->sta.smps_mode = smps_mode;
+	else
+		sta->sta.smps_mode = IEEE80211_SMPS_OFF;
+
+	he_cap->he_6ghz.cap = cap;
+	he_cap->has_he_6ghz = true;
 }
 
 void
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 5e33746d7210..78a95a11458c 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1892,6 +1892,8 @@ void
 ieee80211_he_cap_ie_to_sta_he_cap(struct ieee80211_sub_if_data *sdata,
 				  struct ieee80211_supported_band *sband,
 				  const u8 *he_cap_ie, u8 he_cap_len,
+				  const struct ieee80211_he_6ghz_band_cap
+					*he_6ghz_cap_ie,
 				  struct sta_info *sta);
 void
 ieee80211_he_spr_ie_to_bss_conf(struct ieee80211_vif *vif,
diff --git a/net/mac80211/mesh_plink.c b/net/mac80211/mesh_plink.c
index 737c5f4dbf52..e3e29b8d641d 100644
--- a/net/mac80211/mesh_plink.c
+++ b/net/mac80211/mesh_plink.c
@@ -441,7 +441,9 @@ static void mesh_sta_info_init(struct ieee80211_sub_if_data *sdata,
 					    elems->vht_cap_elem, sta);
 
 	ieee80211_he_cap_ie_to_sta_he_cap(sdata, sband, elems->he_cap,
-					  elems->he_cap_len, sta);
+					  elems->he_cap_len,
+					  elems->he_6ghz_cap_elem,
+					  sta);
 
 	if (bw != sta->sta.bandwidth)
 		changed |= IEEE80211_RC_BW_CHANGED;
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 16d75da0996a..58a082efc3b3 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -3381,6 +3381,7 @@ static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
 		ieee80211_he_cap_ie_to_sta_he_cap(sdata, sband,
 						  elems->he_cap,
 						  elems->he_cap_len,
+						  elems->he_6ghz_cap_elem,
 						  sta);
 
 		bss_conf->he_support = sta->sta.he_cap.has_he;
-- 
2.7.4
