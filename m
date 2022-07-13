Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38DBF57332C
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Jul 2022 11:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236201AbiGMJpX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Jul 2022 05:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235360AbiGMJpL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Jul 2022 05:45:11 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A75D8DA7BF
        for <linux-wireless@vger.kernel.org>; Wed, 13 Jul 2022 02:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=UG6998tzPB4vfQA31sFw5jrnLWxWrkubrLmFM1LV+xQ=;
        t=1657705508; x=1658915108; b=E9usE1ZvDgTyau2VRsQI/ArFEWM6y1DnDg7/5LlNB/8Kmak
        vd7yZDkxqGec0wittiGOiQo4o7+uZWM2Jo05ZBvwZiGaf7GS24oFYaBK5OJU5NR3frkM6Pjr+2bpR
        nCjyAs4HWZrw23bJVu0oS46TL6MkEuyaEboZdB/i5lyPeOxMZVHqsdCBUThLxRYv0Ek4oxI+42CL2
        NjcxxIMEzV/PXE4Sn6h3Fi36lHiMTCw6e6F+1xpbgS4G7YR1pbXjxk9d5Ai3uPI8ul+MIQkim0WzN
        V8XnJ1IT8k39FnfWVT7apJJoHAyyZlnWcxAsxpECnPx6CSn18uYrfXQifhzJS5pA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oBYvZ-00EgvB-JK;
        Wed, 13 Jul 2022 11:45:05 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 03/76] wifi: mac80211: rx: accept link-addressed frames
Date:   Wed, 13 Jul 2022 11:43:49 +0200
Message-Id: <20220713114425.bf1302a63e1c.Idcd337705a4d1737a89bf9247ba73f82a0fc8b61@changeid>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220713094502.163926-1-johannes@sipsolutions.net>
References: <20220713094502.163926-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

When checking whether or not to accept a frame in RX,
take into account the configured link addresses. Also
look up the link station correctly.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/linux/ieee80211.h  | 52 ++++++++++++++++-------
 net/mac80211/ieee80211_i.h |  6 +++
 net/mac80211/mlme.c        | 32 ++++++++++++++
 net/mac80211/rx.c          | 63 ++++++++++++++++++++++++---
 net/mac80211/util.c        | 87 ++++++++++++++++++++++++--------------
 5 files changed, 187 insertions(+), 53 deletions(-)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index f386f9ed41f3..e75c73ca11ec 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -2046,25 +2046,38 @@ struct ieee80211_eht_cap_elem {
 	u8 optional[];
 } __packed;
 
+#define IEEE80211_EHT_OPER_INFO_PRESENT	                        0x1
+#define IEEE80211_EHT_OPER_DISABLED_SUBCHANNEL_BITMAP_PRESENT	0x2
+
 /**
  * struct ieee80211_eht_operation - eht operation element
  *
  * This structure is the "EHT Operation Element" fields as
- * described in P802.11be_D1.4 section 9.4.2.311
+ * described in P802.11be_D1.5 section 9.4.2.311
  *
- * FIXME: The spec is unclear how big the fields are, and doesn't
- *	  indicate the "Disabled Subchannel Bitmap Present" in the
- *	  structure (Figure 9-1002a) at all ...
+ * @params: EHT operation element parameters. See &IEEE80211_EHT_OPER_*
+ * @optional: optional parts
  */
 struct ieee80211_eht_operation {
-	u8 chan_width;
-	u8 ccfs;
-	u8 present_bm;
-
-	u8 disable_subchannel_bitmap[];
+	u8 params;
+	u8 optional[];
 } __packed;
 
-#define IEEE80211_EHT_OPER_DISABLED_SUBCHANNEL_BITMAP_PRESENT	0x1
+/**
+ * struct ieee80211_eht_operation_info - eht operation information
+ *
+ * @control: EHT operation information control.
+ * @ccfs0: defines a channel center frequency for a 20, 40, 80, 160, or 320 MHz
+ *     EHT BSS.
+ * @ccfs1: defines a channel center frequency for a 160 or 320 MHz EHT BSS.
+ * @optional: optional parts
+ */
+struct ieee80211_eht_operation_info {
+	u8 control;
+	u8 ccfs0;
+	u8 ccfs1;
+	u8 optional[];
+} __packed;
 
 /* 802.11ac VHT Capabilities */
 #define IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_3895			0x00000000
@@ -2773,10 +2786,12 @@ ieee80211_he_spr_size(const u8 *he_spr_ie)
 #define IEEE80211_EHT_MAC_CAP0_TRIG_TXOP_SHARING_MODE2		0x08
 #define IEEE80211_EHT_MAC_CAP0_RESTRICTED_TWT			0x10
 #define IEEE80211_EHT_MAC_CAP0_SCS_TRAFFIC_DESC			0x20
-#define IEEE80211_EHT_MAC_CAP0_MAX_AMPDU_LEN_MASK		0xc0
-#define		IEEE80211_EHT_MAC_CAP0_MAX_AMPDU_LEN_3895	0
-#define		IEEE80211_EHT_MAC_CAP0_MAX_AMPDU_LEN_7991	1
-#define		IEEE80211_EHT_MAC_CAP0_MAX_AMPDU_LEN_11454	2
+#define IEEE80211_EHT_MAC_CAP0_MAX_MPDU_LEN_MASK		0xc0
+#define	IEEE80211_EHT_MAC_CAP0_MAX_MPDU_LEN_3895	        0
+#define	IEEE80211_EHT_MAC_CAP0_MAX_MPDU_LEN_7991	        1
+#define	IEEE80211_EHT_MAC_CAP0_MAX_MPDU_LEN_11454	        2
+
+#define IEEE80211_EHT_MAC_CAP1_MAX_AMPDU_LEN_MASK		0x01
 
 /* EHT PHY capabilities as defined in P802.11be_D1.4 section 9.4.2.313.3 */
 #define IEEE80211_EHT_PHY_CAP0_320MHZ_IN_6GHZ			0x02
@@ -2949,8 +2964,13 @@ ieee80211_eht_oper_size_ok(const u8 *data, u8 len)
 	if (len < needed)
 		return false;
 
-	if (elem->present_bm & IEEE80211_EHT_OPER_DISABLED_SUBCHANNEL_BITMAP_PRESENT)
-		needed += 2;
+	if (elem->params & IEEE80211_EHT_OPER_INFO_PRESENT) {
+		needed += 3;
+
+		if (elem->params &
+		    IEEE80211_EHT_OPER_DISABLED_SUBCHANNEL_BITMAP_PRESENT)
+			needed += 2;
+	}
 
 	return len >= needed;
 }
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index f08060a36ef2..46413b6a8de3 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -231,6 +231,8 @@ struct ieee80211_rx_data {
 	 */
 	int security_idx;
 
+	int link_id;
+
 	union {
 		struct {
 			u32 iv32;
@@ -2302,6 +2304,10 @@ bool ieee80211_chandef_vht_oper(struct ieee80211_hw *hw, u32 vht_cap_info,
 				const struct ieee80211_vht_operation *oper,
 				const struct ieee80211_ht_operation *htop,
 				struct cfg80211_chan_def *chandef);
+void ieee80211_chandef_eht_oper(struct ieee80211_sub_if_data *sdata,
+				const struct ieee80211_eht_operation *eht_oper,
+				bool support_160, bool support_320,
+				struct cfg80211_chan_def *chandef);
 bool ieee80211_chandef_he_6ghz_oper(struct ieee80211_sub_if_data *sdata,
 				    const struct ieee80211_he_operation *he_oper,
 				    const struct ieee80211_eht_operation *eht_oper,
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 01a72d1fcfcc..8980dfef1ff1 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -303,6 +303,38 @@ ieee80211_determine_chantype(struct ieee80211_sub_if_data *sdata,
 
 	*chandef = vht_chandef;
 
+	/*
+	 * handle the case that the EHT operation indicates that it holds EHT
+	 * operation information (in case that the channel width differs from
+	 * the channel width reported in HT/VHT/HE).
+	 */
+	if (eht_oper && (eht_oper->params & IEEE80211_EHT_OPER_INFO_PRESENT)) {
+		struct cfg80211_chan_def eht_chandef = *chandef;
+
+		ieee80211_chandef_eht_oper(sdata, eht_oper,
+					   eht_chandef.width ==
+					   NL80211_CHAN_WIDTH_160,
+					   false, &eht_chandef);
+
+		if (!cfg80211_chandef_valid(&eht_chandef)) {
+			if (!(ifmgd->flags & IEEE80211_STA_DISABLE_EHT))
+				sdata_info(sdata,
+					   "AP EHT information is invalid, disabling EHT\n");
+			ret = IEEE80211_STA_DISABLE_EHT;
+			goto out;
+		}
+
+		if (!cfg80211_chandef_compatible(chandef, &eht_chandef)) {
+			if (!(ifmgd->flags & IEEE80211_STA_DISABLE_EHT))
+				sdata_info(sdata,
+					   "AP EHT information is incompatible, disabling EHT\n");
+			ret = IEEE80211_STA_DISABLE_EHT;
+			goto out;
+		}
+
+		*chandef = eht_chandef;
+	}
+
 	ret = 0;
 
 out:
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 834d2171f344..2aa593294a29 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -4028,6 +4028,7 @@ void ieee80211_release_reorder_timeout(struct sta_info *sta, int tid)
 		/* This is OK -- must be QoS data frame */
 		.security_idx = tid,
 		.seqno_idx = tid,
+		.link_id = -1,
 	};
 	struct tid_ampdu_rx *tid_agg_rx;
 
@@ -4064,6 +4065,7 @@ void ieee80211_mark_rx_ba_filtered_frames(struct ieee80211_sta *pubsta, u8 tid,
 		/* This is OK -- must be QoS data frame */
 		.security_idx = tid,
 		.seqno_idx = tid,
+		.link_id = -1,
 	};
 	int i, diff;
 
@@ -4140,6 +4142,31 @@ static inline int ieee80211_bssid_match(const u8 *raddr, const u8 *addr)
 	       is_broadcast_ether_addr(raddr);
 }
 
+static bool ieee80211_is_our_addr(struct ieee80211_sub_if_data *sdata,
+				  const u8 *addr, int *out_link_id)
+{
+	unsigned int link_id;
+
+	/* non-MLO, or MLD address replaced by hardware */
+	if (ether_addr_equal(sdata->vif.addr, addr))
+		return true;
+
+	if (!sdata->vif.valid_links)
+		return false;
+
+	for (link_id = 0; link_id < ARRAY_SIZE(sdata->vif.link_conf); link_id++) {
+		if (!sdata->vif.link_conf[link_id])
+			continue;
+		if (ether_addr_equal(sdata->vif.link_conf[link_id]->addr, addr)) {
+			if (out_link_id)
+				*out_link_id = link_id;
+			return true;
+		}
+	}
+
+	return false;
+}
+
 static bool ieee80211_accept_frame(struct ieee80211_rx_data *rx)
 {
 	struct ieee80211_sub_if_data *sdata = rx->sdata;
@@ -4158,7 +4185,7 @@ static bool ieee80211_accept_frame(struct ieee80211_rx_data *rx)
 			return false;
 		if (multicast)
 			return true;
-		return ether_addr_equal(sdata->vif.addr, hdr->addr1);
+		return ieee80211_is_our_addr(sdata, hdr->addr1, &rx->link_id);
 	case NL80211_IFTYPE_ADHOC:
 		if (!bssid)
 			return false;
@@ -4212,9 +4239,11 @@ static bool ieee80211_accept_frame(struct ieee80211_rx_data *rx)
 	case NL80211_IFTYPE_AP_VLAN:
 	case NL80211_IFTYPE_AP:
 		if (!bssid)
-			return ether_addr_equal(sdata->vif.addr, hdr->addr1);
+			return ieee80211_is_our_addr(sdata, hdr->addr1,
+						     &rx->link_id);
 
-		if (!ieee80211_bssid_match(bssid, sdata->vif.addr)) {
+		if (!is_broadcast_ether_addr(bssid) &&
+		    !ieee80211_is_our_addr(sdata, bssid, NULL)) {
 			/*
 			 * Accept public action frames even when the
 			 * BSSID doesn't match, this is used for P2P
@@ -4222,7 +4251,8 @@ static bool ieee80211_accept_frame(struct ieee80211_rx_data *rx)
 			 * itself never looks at these frames.
 			 */
 			if (!multicast &&
-			    !ether_addr_equal(sdata->vif.addr, hdr->addr1))
+			    !ieee80211_is_our_addr(sdata, hdr->addr1,
+						   &rx->link_id))
 				return false;
 			if (ieee80211_is_public_action(hdr, skb->len))
 				return true;
@@ -4740,6 +4770,7 @@ static void __ieee80211_rx_handle_8023(struct ieee80211_hw *hw,
 	rx.skb = skb;
 	rx.local = local;
 	rx.list = list;
+	rx.link_id = -1;
 
 	I802_DEBUG_INC(local->dot11ReceivedFragmentCount);
 
@@ -4779,6 +4810,7 @@ static void __ieee80211_rx_handle_packet(struct ieee80211_hw *hw,
 	__le16 fc;
 	struct ieee80211_rx_data rx;
 	struct ieee80211_sub_if_data *prev;
+	struct link_sta_info *link_sta;
 	struct rhlist_head *tmp;
 	int err = 0;
 
@@ -4787,6 +4819,7 @@ static void __ieee80211_rx_handle_packet(struct ieee80211_hw *hw,
 	rx.skb = skb;
 	rx.local = local;
 	rx.list = list;
+	rx.link_id = -1;
 
 	if (ieee80211_is_data(fc) || ieee80211_is_mgmt(fc))
 		I802_DEBUG_INC(local->dot11ReceivedFragmentCount);
@@ -4872,7 +4905,19 @@ static void __ieee80211_rx_handle_packet(struct ieee80211_hw *hw,
 			continue;
 		}
 
-		rx.sta = sta_info_get_bss(prev, hdr->addr2);
+		/*
+		 * Look up link station first, in case there's a
+		 * chance that they might have a link address that
+		 * is identical to the MLD address, that way we'll
+		 * have the link information if needed.
+		 */
+		link_sta = link_sta_info_get_bss(prev, hdr->addr2);
+		if (link_sta) {
+			rx.sta = link_sta->sta;
+			rx.link_id = link_sta->link_id;
+		} else {
+			rx.sta = sta_info_get_bss(prev, hdr->addr2);
+		}
 		rx.sdata = prev;
 		ieee80211_prepare_and_rx_handle(&rx, skb, false);
 
@@ -4880,7 +4925,13 @@ static void __ieee80211_rx_handle_packet(struct ieee80211_hw *hw,
 	}
 
 	if (prev) {
-		rx.sta = sta_info_get_bss(prev, hdr->addr2);
+		link_sta = link_sta_info_get_bss(prev, hdr->addr2);
+		if (link_sta) {
+			rx.sta = link_sta->sta;
+			rx.link_id = link_sta->link_id;
+		} else {
+			rx.sta = sta_info_get_bss(prev, hdr->addr2);
+		}
 		rx.sdata = prev;
 
 		if (ieee80211_prepare_and_rx_handle(&rx, skb, true))
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index bcb4aa7d7599..7b39e464fb1e 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -3448,6 +3448,58 @@ bool ieee80211_chandef_vht_oper(struct ieee80211_hw *hw, u32 vht_cap_info,
 	return true;
 }
 
+void ieee80211_chandef_eht_oper(struct ieee80211_sub_if_data *sdata,
+				const struct ieee80211_eht_operation *eht_oper,
+				bool support_160, bool support_320,
+				struct cfg80211_chan_def *chandef)
+{
+	struct ieee80211_eht_operation_info *info = (void *)eht_oper->optional;
+
+	chandef->center_freq1 =
+		ieee80211_channel_to_frequency(info->ccfs0,
+					       chandef->chan->band);
+
+	switch (u8_get_bits(info->control,
+			    IEEE80211_EHT_OPER_CHAN_WIDTH)) {
+	case IEEE80211_EHT_OPER_CHAN_WIDTH_20MHZ:
+		chandef->width = NL80211_CHAN_WIDTH_20;
+		break;
+	case IEEE80211_EHT_OPER_CHAN_WIDTH_40MHZ:
+		chandef->width = NL80211_CHAN_WIDTH_40;
+		break;
+	case IEEE80211_EHT_OPER_CHAN_WIDTH_80MHZ:
+		chandef->width = NL80211_CHAN_WIDTH_80;
+		break;
+	case IEEE80211_EHT_OPER_CHAN_WIDTH_160MHZ:
+		if (support_160) {
+			chandef->width = NL80211_CHAN_WIDTH_160;
+			chandef->center_freq1 =
+				ieee80211_channel_to_frequency(info->ccfs1,
+							       chandef->chan->band);
+		} else {
+			chandef->width = NL80211_CHAN_WIDTH_80;
+		}
+		break;
+	case IEEE80211_EHT_OPER_CHAN_WIDTH_320MHZ:
+		if (support_320) {
+			chandef->width = NL80211_CHAN_WIDTH_320;
+			chandef->center_freq1 =
+				ieee80211_channel_to_frequency(info->ccfs1,
+							       chandef->chan->band);
+		} else if (support_160) {
+			chandef->width = NL80211_CHAN_WIDTH_160;
+		} else {
+			chandef->width = NL80211_CHAN_WIDTH_80;
+
+			if (chandef->center_freq1 > chandef->chan->center_freq)
+				chandef->center_freq1 -= 40;
+			else
+				chandef->center_freq1 += 40;
+		}
+		break;
+	}
+}
+
 bool ieee80211_chandef_he_6ghz_oper(struct ieee80211_sub_if_data *sdata,
 				    const struct ieee80211_he_operation *he_oper,
 				    const struct ieee80211_eht_operation *eht_oper,
@@ -3528,7 +3580,8 @@ bool ieee80211_chandef_he_6ghz_oper(struct ieee80211_sub_if_data *sdata,
 		break;
 	}
 
-	if (!eht_oper) {
+	if (!eht_oper ||
+	    !(eht_oper->params & IEEE80211_EHT_OPER_INFO_PRESENT)) {
 		switch (u8_get_bits(he_6ghz_oper->control,
 				    IEEE80211_HE_6GHZ_OPER_CTRL_CHANWIDTH)) {
 		case IEEE80211_HE_6GHZ_OPER_CTRL_CHANWIDTH_20MHZ:
@@ -3572,36 +3625,8 @@ bool ieee80211_chandef_he_6ghz_oper(struct ieee80211_sub_if_data *sdata,
 		support_320 =
 			eht_phy_cap & IEEE80211_EHT_PHY_CAP0_320MHZ_IN_6GHZ;
 
-		switch (u8_get_bits(eht_oper->chan_width,
-				    IEEE80211_EHT_OPER_CHAN_WIDTH)) {
-		case IEEE80211_EHT_OPER_CHAN_WIDTH_20MHZ:
-			he_chandef.width = NL80211_CHAN_WIDTH_20;
-			break;
-		case IEEE80211_EHT_OPER_CHAN_WIDTH_40MHZ:
-			he_chandef.width = NL80211_CHAN_WIDTH_40;
-			break;
-		case IEEE80211_EHT_OPER_CHAN_WIDTH_80MHZ:
-			he_chandef.width = NL80211_CHAN_WIDTH_80;
-			break;
-		case IEEE80211_EHT_OPER_CHAN_WIDTH_160MHZ:
-			if (support_160)
-				he_chandef.width = NL80211_CHAN_WIDTH_160;
-			else
-				he_chandef.width = NL80211_CHAN_WIDTH_80;
-			break;
-		case IEEE80211_EHT_OPER_CHAN_WIDTH_320MHZ:
-			if (support_320)
-				he_chandef.width = NL80211_CHAN_WIDTH_320;
-			else if (support_160)
-				he_chandef.width = NL80211_CHAN_WIDTH_160;
-			else
-				he_chandef.width = NL80211_CHAN_WIDTH_80;
-			break;
-		}
-
-		he_chandef.center_freq1 =
-			ieee80211_channel_to_frequency(eht_oper->ccfs,
-						       NL80211_BAND_6GHZ);
+		ieee80211_chandef_eht_oper(sdata, eht_oper, support_160,
+					   support_320, &he_chandef);
 	}
 
 	if (!cfg80211_chandef_valid(&he_chandef)) {
-- 
2.36.1

