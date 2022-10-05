Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAD385F54E2
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Oct 2022 15:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbiJENBU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 5 Oct 2022 09:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbiJENA5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 5 Oct 2022 09:00:57 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C751EC7B
        for <linux-wireless@vger.kernel.org>; Wed,  5 Oct 2022 06:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=zYTzPtFou7LG8AZ/3wuUacxlZN6bwNvFw56hntkHLaI=;
        t=1664974855; x=1666184455; b=g40U2NCPOcXeFLXtpuO8IacIvLWs5XscV7UBtIQC/+V5uvX
        EaLA/3w5qNz8JswpPNymwEy0a9BT+osst8XSmoWcSu7kYCY9YyUYb91axQFHbVJucAOBRzt5cqVBv
        HorY7NXnPEo3BRKCk5JWrYfUwfmz5fT19CZSVgI1n5LqsE7lQO5pmYVnGUK++zX9i5r7tdcXhLXGP
        T/38CfmiersUdo/Kq4MpLlRH8rNMRsQAwJ37b7xBxhk2hzRZd4I/rDQdSbpctFq2o1wGlSDVVpaji
        fjGREhHSfrd1i/Nupgsv1BYpiUI8P7MMTGc/Fqy8sY38n1CHV0abrutrCgci67/g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1og416-00G2RL-2K;
        Wed, 05 Oct 2022 15:00:52 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH 09/28] wifi: mac80211: Parse station profile from association response
Date:   Wed,  5 Oct 2022 15:00:29 +0200
Message-Id: <20221005145226.6833f7a815fd.I3ee14faebbb054ead7297fc7197e206301f1fcaa@changeid>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221005130048.217341-1-johannes@sipsolutions.net>
References: <20221005130048.217341-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ilan Peer <ilan.peer@intel.com>

When processing an association response frame for a Multi-Link
connection, extract the per station profile for each additional
link, and use it for parsing the link elements.

As the Multi-Link element might be fragmented, add support for
reassembling a fragmented element. To simplify memory management
logic, extend 'struct ieee802_11_elems' to hold a scratch buffer,
which is used for the defragmentation. Once an element is
reconstructed in the scratch area, point the corresponding element
pointer to it. Currently only defragmentation of Multi-Link element
and the contained per-STA profile subelement is supported.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/linux/ieee80211.h  |   1 +
 net/mac80211/ieee80211_i.h |  26 ++++++-
 net/mac80211/mlme.c        |  17 ++++-
 net/mac80211/util.c        | 150 ++++++++++++++++++++++++++++++++++++-
 4 files changed, 188 insertions(+), 6 deletions(-)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index b935a85b2f44..f51e939f28f2 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -4666,6 +4666,7 @@ static inline bool ieee80211_mle_size_ok(const u8 *data, size_t len)
 
 enum ieee80211_mle_subelems {
 	IEEE80211_MLE_SUBELEM_PER_STA_PROFILE		= 0,
+	IEEE80211_MLE_SUBELEM_FRAGMENT		        = 254,
 };
 
 #define IEEE80211_MLE_STA_CONTROL_LINK_ID			0x000f
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 4e1d4c339f2d..5dcbc8de53fd 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -1707,8 +1707,27 @@ struct ieee802_11_elems {
 	u8 tx_pwr_env_num;
 	u8 eht_cap_len;
 
+	/* mult-link element can be de-fragmented and thus u8 is not sufficient */
+	size_t multi_link_len;
+
+	/*
+	 * store the per station profile pointer and length in case that the
+	 * parsing also handled Multi-Link element parsing for a specific link
+	 * ID.
+	 */
+	struct ieee80211_mle_per_sta_profile *prof;
+	size_t sta_prof_len;
+
 	/* whether a parse error occurred while retrieving these elements */
 	bool parse_error;
+
+	/*
+	 * scratch buffer that can be used for various element parsing related
+	 * tasks, e.g., element de-fragmentation etc.
+	 */
+	size_t scratch_len;
+	u8 *scratch_pos;
+	u8 scratch[];
 };
 
 static inline struct ieee80211_local *hw_to_local(
@@ -2197,9 +2216,13 @@ static inline void ieee80211_tx_skb(struct ieee80211_sub_if_data *sdata,
  *	represent a non-transmitting BSS in which case the data
  *	for that non-transmitting BSS is returned
  * @link_id: the link ID to parse elements for, if a STA profile
- *	is present in the multi-link element, or -1 to ignore
+ *	is present in the multi-link element, or -1 to ignore;
+ *	note that the code currently assumes parsing an association
+ *	(or re-association) response frame if this is given
  * @from_ap: frame is received from an AP (currently used only
  *	for EHT capabilities parsing)
+ * @scratch_len: if non zero, specifies the requested length of the scratch
+ *      buffer; otherwise, 'len' is used.
  */
 struct ieee80211_elems_parse_params {
 	const u8 *start;
@@ -2210,6 +2233,7 @@ struct ieee80211_elems_parse_params {
 	struct cfg80211_bss *bss;
 	int link_id;
 	bool from_ap;
+	size_t scratch_len;
 };
 
 struct ieee802_11_elems *
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 54b8d5065bbd..a7e06c8ddaf3 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -3923,11 +3923,12 @@ static bool ieee80211_assoc_config_link(struct ieee80211_link_data *link,
 	struct ieee80211_mgd_assoc_data *assoc_data = sdata->u.mgd.assoc_data;
 	struct ieee80211_bss_conf *bss_conf = link->conf;
 	struct ieee80211_local *local = sdata->local;
+	unsigned int link_id = link->link_id;
 	struct ieee80211_elems_parse_params parse_params = {
 		.start = elem_start,
 		.len = elem_len,
 		.bss = cbss,
-		.link_id = link == &sdata->deflink ? -1 : link->link_id,
+		.link_id = link_id == assoc_data->assoc_link_id ? -1 : link_id,
 		.from_ap = true,
 	};
 	bool is_6ghz = cbss->channel->band == NL80211_BAND_6GHZ;
@@ -3942,8 +3943,18 @@ static bool ieee80211_assoc_config_link(struct ieee80211_link_data *link,
 	if (!elems)
 		return false;
 
-	/* FIXME: use from STA profile element after parsing that */
-	capab_info = le16_to_cpu(mgmt->u.assoc_resp.capab_info);
+	if (link_id == assoc_data->assoc_link_id) {
+		capab_info = le16_to_cpu(mgmt->u.assoc_resp.capab_info);
+	} else if (!elems->prof) {
+		ret = false;
+		goto out;
+	} else {
+		const u8 *ptr = elems->prof->variable +
+				elems->prof->sta_info_len - 1;
+
+		/* FIXME: need to also handle the status code */
+		capab_info = get_unaligned_le16(ptr);
+	}
 
 	if (!is_s1g && !elems->supp_rates) {
 		sdata_info(sdata, "no SuppRates element in AssocResp\n");
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index bf7461c41bef..40b75fa82b15 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -1026,8 +1026,10 @@ ieee80211_parse_extension_element(u32 *crc,
 			elems->eht_operation = data;
 		break;
 	case WLAN_EID_EXT_EHT_MULTI_LINK:
-		if (ieee80211_mle_size_ok(data, len))
+		if (ieee80211_mle_size_ok(data, len)) {
 			elems->multi_link = (void *)data;
+			elems->multi_link_len = len;
+		}
 		break;
 	}
 }
@@ -1497,6 +1499,145 @@ static size_t ieee802_11_find_bssid_profile(const u8 *start, size_t len,
 	return found ? profile_len : 0;
 }
 
+static void ieee80211_defragment_element(struct ieee802_11_elems *elems,
+					 void **elem_ptr, size_t *len,
+					 size_t total_len, u8 frag_id)
+{
+	u8 *data = *elem_ptr, *pos, *start;
+	const struct element *elem;
+
+	/*
+	 * Since 'data' points to the data of the element, not the element
+	 * itself, allow 254 in case it was an extended element where the
+	 * extended ID isn't part of the data we see here and thus not part of
+	 * 'len' either.
+	 */
+	if (!data || (*len != 254 && *len != 255))
+		return;
+
+	start = elems->scratch_pos;
+
+	if (WARN_ON(*len > (elems->scratch + elems->scratch_len -
+			    elems->scratch_pos)))
+		return;
+
+	memcpy(elems->scratch_pos, data, *len);
+	elems->scratch_pos += *len;
+
+	pos = data + *len;
+	total_len -= *len;
+	for_each_element(elem, pos, total_len) {
+		if (elem->id != frag_id)
+			break;
+
+		if (WARN_ON(elem->datalen >
+			    (elems->scratch + elems->scratch_len -
+			     elems->scratch_pos)))
+			return;
+
+		memcpy(elems->scratch_pos, elem->data, elem->datalen);
+		elems->scratch_pos += elem->datalen;
+
+		*len += elem->datalen;
+	}
+
+	*elem_ptr = start;
+}
+
+static void ieee80211_mle_get_sta_prof(struct ieee802_11_elems *elems,
+				       u8 link_id)
+{
+	const struct ieee80211_multi_link_elem *ml = elems->multi_link;
+	size_t ml_len = elems->multi_link_len;
+	const struct element *sub;
+
+	if (!ml || !ml_len)
+		return;
+
+	if (le16_get_bits(ml->control, IEEE80211_ML_CONTROL_TYPE) !=
+	    IEEE80211_ML_CONTROL_TYPE_BASIC)
+		return;
+
+	for_each_mle_subelement(sub, (u8 *)ml, ml_len) {
+		struct ieee80211_mle_per_sta_profile *prof = (void *)sub->data;
+		u16 control;
+
+		if (sub->id != IEEE80211_MLE_SUBELEM_PER_STA_PROFILE)
+			continue;
+
+		if (!ieee80211_mle_sta_prof_size_ok(sub->data, sub->datalen))
+			return;
+
+		control = le16_to_cpu(prof->control);
+
+		if (link_id != u16_get_bits(control,
+					    IEEE80211_MLE_STA_CONTROL_LINK_ID))
+			continue;
+
+		if (!(control & IEEE80211_MLE_STA_CONTROL_COMPLETE_PROFILE))
+			return;
+
+		elems->prof = prof;
+		elems->sta_prof_len = sub->datalen;
+
+		/* the sub element can be fragmented */
+		ieee80211_defragment_element(elems, (void **)&elems->prof,
+					     &elems->sta_prof_len,
+					     ml_len - (sub->data - (u8 *)ml),
+					     IEEE80211_MLE_SUBELEM_FRAGMENT);
+		return;
+	}
+}
+
+static void ieee80211_mle_parse_link(struct ieee802_11_elems *elems,
+				     struct ieee80211_elems_parse_params *params)
+{
+	struct ieee80211_mle_per_sta_profile *prof;
+	struct ieee80211_elems_parse_params sub = {
+		.action = params->action,
+		.from_ap = params->from_ap,
+		.link_id = -1,
+	};
+	const struct element *non_inherit = NULL;
+	const u8 *end;
+
+	if (params->link_id == -1)
+		return;
+
+	ieee80211_defragment_element(elems, (void **)&elems->multi_link,
+				     &elems->multi_link_len,
+				     elems->total_len - ((u8 *)elems->multi_link -
+							 elems->ie_start),
+				     WLAN_EID_FRAGMENT);
+
+	ieee80211_mle_get_sta_prof(elems, params->link_id);
+	prof = elems->prof;
+
+	if (!prof)
+		return;
+
+	/* check if we have the 4 bytes for the fixed part in assoc response */
+	if (elems->sta_prof_len < sizeof(*prof) + prof->sta_info_len - 1 + 4) {
+		elems->prof = NULL;
+		elems->sta_prof_len = 0;
+		return;
+	}
+
+	/*
+	 * Skip the capability information and the status code that are expected
+	 * as part of the station profile in association response frames. Note
+	 * the -1 is because the 'sta_info_len' is accounted to as part of the
+	 * per-STA profile, but not part of the 'u8 variable[]' portion.
+	 */
+	sub.start = prof->variable + prof->sta_info_len - 1 + 4;
+	end = (const u8 *)prof + elems->sta_prof_len;
+	sub.len = end - sub.start;
+
+	non_inherit = cfg80211_find_ext_elem(WLAN_EID_EXT_NON_INHERITANCE,
+					     sub.start, sub.len);
+	_ieee802_11_parse_elems_full(&sub, elems, non_inherit);
+}
+
 struct ieee802_11_elems *
 ieee802_11_parse_elems_full(struct ieee80211_elems_parse_params *params)
 {
@@ -1504,12 +1645,15 @@ ieee802_11_parse_elems_full(struct ieee80211_elems_parse_params *params)
 	const struct element *non_inherit = NULL;
 	u8 *nontransmitted_profile;
 	int nontransmitted_profile_len = 0;
+	size_t scratch_len = params->scratch_len ?: 2 * params->len;
 
-	elems = kzalloc(sizeof(*elems), GFP_ATOMIC);
+	elems = kzalloc(sizeof(*elems) + scratch_len, GFP_ATOMIC);
 	if (!elems)
 		return NULL;
 	elems->ie_start = params->start;
 	elems->total_len = params->len;
+	elems->scratch_len = scratch_len;
+	elems->scratch_pos = elems->scratch;
 
 	nontransmitted_profile = kmalloc(params->len, GFP_ATOMIC);
 	if (nontransmitted_profile) {
@@ -1537,6 +1681,8 @@ ieee802_11_parse_elems_full(struct ieee80211_elems_parse_params *params)
 		_ieee802_11_parse_elems_full(&sub, elems, NULL);
 	}
 
+	ieee80211_mle_parse_link(elems, params);
+
 	if (elems->tim && !elems->parse_error) {
 		const struct ieee80211_tim_ie *tim_ie = elems->tim;
 
-- 
2.37.3

