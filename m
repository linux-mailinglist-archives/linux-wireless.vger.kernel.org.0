Return-Path: <linux-wireless+bounces-1406-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D7CD282222A
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jan 2024 20:37:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBDD21C229CB
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Jan 2024 19:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7033E168A4;
	Tue,  2 Jan 2024 19:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RW0ScEqs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C49168A2
	for <linux-wireless@vger.kernel.org>; Tue,  2 Jan 2024 19:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704224197; x=1735760197;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Dwd40iwCye8MOYZgPrKiLKOBw0CaB3ao+P27ceHxVzw=;
  b=RW0ScEqseqa7WE4fl1wQR+UQ1tZMcKDb11r6f9mpRpdPcrL3Kw33SVdr
   k9T0lMYicPwzLOjrk81X8AaZRto+Re86YB4bzETA4+5bj+GNFLMmnceae
   Ff9bzckM4tBJd8m+UwC2GWERRqXLhV5HgYcOs+HrbQ9IfA928TCLZGd4u
   NEcHUvlfVnRlkM5hp2Pj81hTEI+InorLFO2Vtd+3S8yZV2OusfWaAsrkd
   NSaFwzM+l1G+rtvAnwHHDHCYqwK6bV++9mQfiwgQYIvGV8mVhnLZiIedl
   HuAV3T+ptR5yyIMJvjy0MvEXldLq4pphp3ht6BOAfwzxwj5UA7n+w44mu
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="463314336"
X-IronPort-AV: E=Sophos;i="6.04,325,1695711600"; 
   d="scan'208";a="463314336"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2024 11:36:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="898624584"
X-IronPort-AV: E=Sophos;i="6.04,325,1695711600"; 
   d="scan'208";a="898624584"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2024 11:36:35 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>,
	Daniel Gabay <daniel.gabay@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 11/15] wifi: mac80211: add support for SPP A-MSDUs
Date: Tue,  2 Jan 2024 21:35:40 +0200
Message-Id: <20240102213313.b8ada4514e2b.I1ac25d5f158165b5a88062a5a5e4c4fbeecf9a5d@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240102193544.157749-1-miriam.rachel.korenblit@intel.com>
References: <20240102193544.157749-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

If software crypto is used, simply add support for SPP A-MSDUs
(and use it whenever enabled as required by the cfg80211 API).

If hardware crypto is used, leave it up to the driver to set
the NL80211_EXT_FEATURE_SPP_AMSDU_SUPPORT flag and then check
sta->spp_amsdu or the IEEE80211_KEY_FLAG_SPP_AMSDU key flag.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Daniel Gabay <daniel.gabay@intel.com>
Reviewed-by: Gregory Greenman <gregory.greenman@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 include/net/mac80211.h     |  5 +++++
 net/mac80211/cfg.c         |  3 +++
 net/mac80211/ieee80211_i.h |  1 +
 net/mac80211/key.c         |  4 ++++
 net/mac80211/main.c        |  5 ++++-
 net/mac80211/mlme.c        |  4 ++++
 net/mac80211/wpa.c         | 33 +++++++++++++++++++++++----------
 7 files changed, 44 insertions(+), 11 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 84cc66dd93c1..8d6ae22c09bf 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -2081,6 +2081,8 @@ static inline bool lockdep_vif_wiphy_mutex_held(struct ieee80211_vif *vif)
  * @IEEE80211_KEY_FLAG_GENERATE_MMIE: This flag should be set by the driver
  *	for a AES_CMAC key to indicate that it requires sequence number
  *	generation only
+ * @IEEE80211_KEY_FLAG_SPP_AMSDU: SPP A-MSDUs can be used with this key
+ *	(set by mac80211 from the sta->spp_amsdu flag)
  */
 enum ieee80211_key_flags {
 	IEEE80211_KEY_FLAG_GENERATE_IV_MGMT	= BIT(0),
@@ -2094,6 +2096,7 @@ enum ieee80211_key_flags {
 	IEEE80211_KEY_FLAG_PUT_MIC_SPACE	= BIT(8),
 	IEEE80211_KEY_FLAG_NO_AUTO_TX		= BIT(9),
 	IEEE80211_KEY_FLAG_GENERATE_MMIE	= BIT(10),
+	IEEE80211_KEY_FLAG_SPP_AMSDU		= BIT(11),
 };
 
 /**
@@ -2392,6 +2395,7 @@ struct ieee80211_link_sta {
  *	would be assigned to link[link_id] where link_id is the id assigned
  *	by the AP.
  * @valid_links: bitmap of valid links, or 0 for non-MLO
+ * @spp_amsdu: indicates whether the STA uses SPP A-MSDU or not.
  */
 struct ieee80211_sta {
 	u8 addr[ETH_ALEN];
@@ -2405,6 +2409,7 @@ struct ieee80211_sta {
 	bool tdls_initiator;
 	bool mfp;
 	bool mlo;
+	bool spp_amsdu;
 	u8 max_amsdu_subframes;
 
 	struct ieee80211_sta_aggregates *cur;
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 035b18a01853..9b5889ea8643 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -1942,6 +1942,9 @@ static int sta_apply_parameters(struct ieee80211_local *local,
 			clear_sta_flag(sta, WLAN_STA_TDLS_PEER);
 	}
 
+	if (mask & BIT(NL80211_STA_FLAG_SPP_AMSDU))
+		sta->sta.spp_amsdu = set & BIT(NL80211_STA_FLAG_SPP_AMSDU);
+
 	/* mark TDLS channel switch support, if the AP allows it */
 	if (test_sta_flag(sta, WLAN_STA_TDLS_PEER) &&
 	    !sdata->deflink.u.mgd.tdls_chan_switch_prohibited &&
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index a821f84f8bb6..e25d47a8455e 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -441,6 +441,7 @@ struct ieee80211_mgd_assoc_data {
 	bool timeout_started;
 	bool comeback; /* whether the AP has requested association comeback */
 	bool s1g;
+	bool spp_amsdu;
 
 	unsigned int assoc_link_id;
 
diff --git a/net/mac80211/key.c b/net/mac80211/key.c
index af74d7f9d94d..a2cce62c97b7 100644
--- a/net/mac80211/key.c
+++ b/net/mac80211/key.c
@@ -925,6 +925,10 @@ int ieee80211_key_link(struct ieee80211_key *key,
 	 */
 	key->color = atomic_inc_return(&key_color);
 
+	/* keep this flag for easier access later */
+	if (sta && sta->sta.spp_amsdu)
+		key->conf.flags |= IEEE80211_KEY_FLAG_SPP_AMSDU;
+
 	increment_tailroom_need_count(sdata);
 
 	ret = ieee80211_key_replace(sdata, link, sta, pairwise, old_key, key);
diff --git a/net/mac80211/main.c b/net/mac80211/main.c
index 13c417eda281..d48fa1147c14 100644
--- a/net/mac80211/main.c
+++ b/net/mac80211/main.c
@@ -735,8 +735,11 @@ struct ieee80211_hw *ieee80211_alloc_hw_nm(size_t priv_data_len,
 				      NL80211_EXT_FEATURE_SCAN_MIN_PREQ_CONTENT);
 	}
 
-	if (!ops->set_key)
+	if (!ops->set_key) {
 		wiphy->flags |= WIPHY_FLAG_IBSS_RSN;
+		wiphy_ext_feature_set(wiphy,
+				      NL80211_EXT_FEATURE_SPP_AMSDU_SUPPORT);
+	}
 
 	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_TXQS);
 	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_RRM);
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 2f81f045eb07..5ded60320132 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -5132,6 +5132,8 @@ static bool ieee80211_assoc_success(struct ieee80211_sub_if_data *sdata,
 	if (WARN_ON(!sta))
 		goto out_err;
 
+	sta->sta.spp_amsdu = assoc_data->spp_amsdu;
+
 	if (ieee80211_vif_is_mld(&sdata->vif)) {
 		for (link_id = 0; link_id < IEEE80211_MLD_MAX_NUM_LINKS; link_id++) {
 			if (!assoc_data->link[link_id].bss)
@@ -8225,6 +8227,8 @@ int ieee80211_mgd_assoc(struct ieee80211_sub_if_data *sdata,
 	assoc_data->wmm = bss->wmm_used &&
 			  (local->hw.queues >= IEEE80211_NUM_ACS);
 
+	assoc_data->spp_amsdu = req->flags & ASSOC_REQ_SPP_AMSDU;
+
 	/*
 	 * IEEE802.11n does not allow TKIP/WEP as pairwise ciphers in HT mode.
 	 * We still associate in non-HT mode (11a/b/g) if any one of these
diff --git a/net/mac80211/wpa.c b/net/mac80211/wpa.c
index 94dae7cb6dbd..e40529b8c5c9 100644
--- a/net/mac80211/wpa.c
+++ b/net/mac80211/wpa.c
@@ -315,7 +315,7 @@ ieee80211_crypto_tkip_decrypt(struct ieee80211_rx_data *rx)
  * Calculate AAD for CCMP/GCMP, returning qos_tid since we
  * need that in CCMP also for b_0.
  */
-static u8 ccmp_gcmp_aad(struct sk_buff *skb, u8 *aad)
+static u8 ccmp_gcmp_aad(struct sk_buff *skb, u8 *aad, bool spp_amsdu)
 {
 	struct ieee80211_hdr *hdr = (void *)skb->data;
 	__le16 mask_fc;
@@ -340,7 +340,14 @@ static u8 ccmp_gcmp_aad(struct sk_buff *skb, u8 *aad)
 		len_a += 6;
 
 	if (ieee80211_is_data_qos(hdr->frame_control)) {
-		qos_tid = ieee80211_get_tid(hdr);
+		qos_tid = *ieee80211_get_qos_ctl(hdr);
+
+		if (spp_amsdu)
+			qos_tid &= IEEE80211_QOS_CTL_TID_MASK |
+				   IEEE80211_QOS_CTL_A_MSDU_PRESENT;
+		else
+			qos_tid &= IEEE80211_QOS_CTL_TID_MASK;
+
 		mask_fc &= ~cpu_to_le16(IEEE80211_FCTL_ORDER);
 		len_a += 2;
 	} else {
@@ -369,10 +376,11 @@ static u8 ccmp_gcmp_aad(struct sk_buff *skb, u8 *aad)
 	return qos_tid;
 }
 
-static void ccmp_special_blocks(struct sk_buff *skb, u8 *pn, u8 *b_0, u8 *aad)
+static void ccmp_special_blocks(struct sk_buff *skb, u8 *pn, u8 *b_0, u8 *aad,
+				bool spp_amsdu)
 {
 	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
-	u8 qos_tid = ccmp_gcmp_aad(skb, aad);
+	u8 qos_tid = ccmp_gcmp_aad(skb, aad, spp_amsdu);
 
 	/* In CCM, the initial vectors (IV) used for CTR mode encryption and CBC
 	 * mode authentication are not allowed to collide, yet both are derived
@@ -479,7 +487,8 @@ static int ccmp_encrypt_skb(struct ieee80211_tx_data *tx, struct sk_buff *skb,
 		return 0;
 
 	pos += IEEE80211_CCMP_HDR_LEN;
-	ccmp_special_blocks(skb, pn, b_0, aad);
+	ccmp_special_blocks(skb, pn, b_0, aad,
+			    key->conf.flags & IEEE80211_KEY_FLAG_SPP_AMSDU);
 	return ieee80211_aes_ccm_encrypt(key->u.ccmp.tfm, b_0, aad, pos, len,
 					 skb_put(skb, mic_len));
 }
@@ -557,7 +566,8 @@ ieee80211_crypto_ccmp_decrypt(struct ieee80211_rx_data *rx,
 			u8 aad[2 * AES_BLOCK_SIZE];
 			u8 b_0[AES_BLOCK_SIZE];
 			/* hardware didn't decrypt/verify MIC */
-			ccmp_special_blocks(skb, pn, b_0, aad);
+			ccmp_special_blocks(skb, pn, b_0, aad,
+					    key->conf.flags & IEEE80211_KEY_FLAG_SPP_AMSDU);
 
 			if (ieee80211_aes_ccm_decrypt(
 				    key->u.ccmp.tfm, b_0, aad,
@@ -581,7 +591,8 @@ ieee80211_crypto_ccmp_decrypt(struct ieee80211_rx_data *rx,
 	return RX_CONTINUE;
 }
 
-static void gcmp_special_blocks(struct sk_buff *skb, u8 *pn, u8 *j_0, u8 *aad)
+static void gcmp_special_blocks(struct sk_buff *skb, u8 *pn, u8 *j_0, u8 *aad,
+				bool spp_amsdu)
 {
 	struct ieee80211_hdr *hdr = (void *)skb->data;
 
@@ -591,7 +602,7 @@ static void gcmp_special_blocks(struct sk_buff *skb, u8 *pn, u8 *j_0, u8 *aad)
 	j_0[14] = 0;
 	j_0[AES_BLOCK_SIZE - 1] = 0x01;
 
-	ccmp_gcmp_aad(skb, aad);
+	ccmp_gcmp_aad(skb, aad, spp_amsdu);
 }
 
 static inline void gcmp_pn2hdr(u8 *hdr, const u8 *pn, int key_id)
@@ -680,7 +691,8 @@ static int gcmp_encrypt_skb(struct ieee80211_tx_data *tx, struct sk_buff *skb)
 		return 0;
 
 	pos += IEEE80211_GCMP_HDR_LEN;
-	gcmp_special_blocks(skb, pn, j_0, aad);
+	gcmp_special_blocks(skb, pn, j_0, aad,
+			    key->conf.flags & IEEE80211_KEY_FLAG_SPP_AMSDU);
 	return ieee80211_aes_gcm_encrypt(key->u.gcmp.tfm, j_0, aad, pos, len,
 					 skb_put(skb, IEEE80211_GCMP_MIC_LEN));
 }
@@ -753,7 +765,8 @@ ieee80211_crypto_gcmp_decrypt(struct ieee80211_rx_data *rx)
 			u8 aad[2 * AES_BLOCK_SIZE];
 			u8 j_0[AES_BLOCK_SIZE];
 			/* hardware didn't decrypt/verify MIC */
-			gcmp_special_blocks(skb, pn, j_0, aad);
+			gcmp_special_blocks(skb, pn, j_0, aad,
+					    key->conf.flags & IEEE80211_KEY_FLAG_SPP_AMSDU);
 
 			if (ieee80211_aes_gcm_decrypt(
 				    key->u.gcmp.tfm, j_0, aad,
-- 
2.34.1


