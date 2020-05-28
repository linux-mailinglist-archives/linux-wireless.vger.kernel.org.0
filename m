Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFE751E5C4A
	for <lists+linux-wireless@lfdr.de>; Thu, 28 May 2020 11:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387473AbgE1Job (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 May 2020 05:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387470AbgE1Joa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 May 2020 05:44:30 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61EE9C05BD1E
        for <linux-wireless@vger.kernel.org>; Thu, 28 May 2020 02:44:30 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1jeF5Q-004mD7-Mo; Thu, 28 May 2020 11:44:28 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Rajkumar Manoharan <rmanohar@codeaurora.org>
Subject: [RFC 09/10] mac80211: build HE operation with 6 GHz oper information
Date:   Thu, 28 May 2020 11:44:15 +0200
Message-Id: <20200528094428.23474-1-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200528114415.3596a1eedb31.Ic15e681a0e249eab7350a06ceb582cca8bb9a080@changeid>
References: <20200528114415.3596a1eedb31.Ic15e681a0e249eab7350a06ceb582cca8bb9a080@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Rajkumar Manoharan <rmanohar@codeaurora.org>

Add 6 GHz operation information (IEEE 802.11ax/D6.0, Figure 9-787k)
while building HE operation element for non-HE AP. This field is used to
determine channel information in the absence of HT/VHT IEs.

Signed-off-by: Rajkumar Manoharan <rmanohar@codeaurora.org>
Link: https://lore.kernel.org/r/1589399105-25472-8-git-send-email-rmanohar@codeaurora.org
[fix skb allocation size]
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/ieee80211_i.h |  2 +-
 net/mac80211/mesh.c        | 12 ++++++--
 net/mac80211/mesh_plink.c  |  1 +
 net/mac80211/util.c        | 63 +++++++++++++++++++++++++++++++++++---
 4 files changed, 70 insertions(+), 8 deletions(-)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 344ea828e806..9f874ce500f6 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2179,7 +2179,7 @@ u8 *ieee80211_ie_build_he_cap(u8 *pos,
 			      u8 *end);
 void ieee80211_ie_build_he_6ghz_cap(struct ieee80211_sub_if_data *sdata,
 				    struct sk_buff *skb);
-u8 *ieee80211_ie_build_he_oper(u8 *pos);
+u8 *ieee80211_ie_build_he_oper(u8 *pos, struct cfg80211_chan_def *chandef);
 int ieee80211_parse_bitrates(struct cfg80211_chan_def *chandef,
 			     const struct ieee80211_supported_band *sband,
 			     const u8 *srates, int srates_len, u32 *rates);
diff --git a/net/mac80211/mesh.c b/net/mac80211/mesh.c
index 5e8d72bdbb98..6378d9cb70d3 100644
--- a/net/mac80211/mesh.c
+++ b/net/mac80211/mesh.c
@@ -565,6 +565,7 @@ int mesh_add_he_oper_ie(struct ieee80211_sub_if_data *sdata,
 {
 	const struct ieee80211_sta_he_cap *he_cap;
 	struct ieee80211_supported_band *sband;
+	u32 len;
 	u8 *pos;
 
 	sband = ieee80211_get_sband(sdata);
@@ -578,11 +579,15 @@ int mesh_add_he_oper_ie(struct ieee80211_sub_if_data *sdata,
 	    sdata->vif.bss_conf.chandef.width == NL80211_CHAN_WIDTH_10)
 		return 0;
 
-	if (skb_tailroom(skb) < 2 + 1 + sizeof(struct ieee80211_he_operation))
+	len = 2 + 1 + sizeof(struct ieee80211_he_operation);
+	if (sdata->vif.bss_conf.chandef.chan->band == NL80211_BAND_6GHZ)
+		len += sizeof(struct ieee80211_he_oper_6ghz_op_info);
+
+	if (skb_tailroom(skb) < len)
 		return -ENOMEM;
 
-	pos = skb_put(skb, 2 + 1 + sizeof(struct ieee80211_he_operation));
-	ieee80211_ie_build_he_oper(pos);
+	pos = skb_put(skb, len);
+	ieee80211_ie_build_he_oper(pos, &sdata->vif.bss_conf.chandef);
 
 	return 0;
 }
@@ -773,6 +778,7 @@ ieee80211_mesh_build_beacon(struct ieee80211_if_mesh *ifmsh)
 		   2 + sizeof(struct ieee80211_vht_operation) +
 		   ie_len_he_cap +
 		   2 + 1 + sizeof(struct ieee80211_he_operation) +
+			   sizeof(struct ieee80211_he_oper_6ghz_op_info) +
 		   2 + 1 + sizeof(struct ieee80211_he_6ghz_capa) +
 		   ifmsh->ie_len;
 
diff --git a/net/mac80211/mesh_plink.c b/net/mac80211/mesh_plink.c
index 3aca89c97f36..b555fafd53c1 100644
--- a/net/mac80211/mesh_plink.c
+++ b/net/mac80211/mesh_plink.c
@@ -238,6 +238,7 @@ static int mesh_plink_frame_tx(struct ieee80211_sub_if_data *sdata,
 			    2 + sizeof(struct ieee80211_vht_operation) +
 			    ie_len_he_cap +
 			    2 + 1 + sizeof(struct ieee80211_he_operation) +
+				    sizeof(struct ieee80211_he_oper_6ghz_op_info) +
 			    2 + 1 + sizeof(struct ieee80211_he_6ghz_capa) +
 			    2 + 8 + /* peering IE */
 			    sdata->u.mesh.ie_len);
diff --git a/net/mac80211/util.c b/net/mac80211/util.c
index 40c82951d801..c31114e2a9b1 100644
--- a/net/mac80211/util.c
+++ b/net/mac80211/util.c
@@ -3010,13 +3010,18 @@ u8 *ieee80211_ie_build_vht_oper(u8 *pos, struct ieee80211_sta_vht_cap *vht_cap,
 	return pos + sizeof(struct ieee80211_vht_operation);
 }
 
-u8 *ieee80211_ie_build_he_oper(u8 *pos)
+u8 *ieee80211_ie_build_he_oper(u8 *pos, struct cfg80211_chan_def *chandef)
 {
 	struct ieee80211_he_operation *he_oper;
+	struct ieee80211_he_oper_6ghz_op_info *he_6ghz_op;
 	u32 he_oper_params;
+	u8 ie_len = 1 + sizeof(struct ieee80211_he_operation);
+
+	if (chandef->chan->band == NL80211_BAND_6GHZ)
+		ie_len += sizeof(struct ieee80211_he_oper_6ghz_op_info);
 
 	*pos++ = WLAN_EID_EXTENSION;
-	*pos++ = 1 + sizeof(struct ieee80211_he_operation);
+	*pos++ = ie_len;
 	*pos++ = WLAN_EID_EXT_HE_OPERATION;
 
 	he_oper_params = 0;
@@ -3026,16 +3031,66 @@ u8 *ieee80211_ie_build_he_oper(u8 *pos)
 				IEEE80211_HE_OPERATION_ER_SU_DISABLE);
 	he_oper_params |= u32_encode_bits(1,
 				IEEE80211_HE_OPERATION_BSS_COLOR_DISABLED);
+	if (chandef->chan->band == NL80211_BAND_6GHZ)
+		he_oper_params |= u32_encode_bits(1,
+				IEEE80211_HE_OPERATION_6GHZ_OP_INFO);
 
 	he_oper = (struct ieee80211_he_operation *)pos;
 	he_oper->he_oper_params = cpu_to_le32(he_oper_params);
 
 	/* don't require special HE peer rates */
 	he_oper->he_mcs_nss_set = cpu_to_le16(0xffff);
+	pos += sizeof(struct ieee80211_he_operation);
 
-	/* TODO add VHT operational and 6GHz operational subelement? */
+	if (chandef->chan->band != NL80211_BAND_6GHZ)
+		goto out;
 
-	return pos + sizeof(struct ieee80211_vht_operation);
+	/* TODO add VHT operational */
+	he_6ghz_op = (struct ieee80211_he_oper_6ghz_op_info *)pos;
+	he_6ghz_op->min_rate = 6; /* 6 Mbps */
+	he_6ghz_op->primary_chan =
+		ieee80211_frequency_to_channel(chandef->chan->center_freq);
+	he_6ghz_op->center_freq_seg0_idx =
+		ieee80211_frequency_to_channel(chandef->center_freq1);
+	if (chandef->center_freq2)
+		he_6ghz_op->center_freq_seg1_idx =
+			ieee80211_frequency_to_channel(chandef->center_freq2);
+	else
+		he_6ghz_op->center_freq_seg1_idx = 0;
+
+	switch (chandef->width) {
+	case NL80211_CHAN_WIDTH_160:
+		/* Convert 160 MHz channel width to new style as interop
+		 * workaround.
+		 */
+		he_6ghz_op->control =
+			IEEE80211_HE_6GHZ_CHANWIDTH_160MHZ_80P80MHZ;
+		he_6ghz_op->center_freq_seg1_idx =
+			he_6ghz_op->center_freq_seg0_idx;
+		if (chandef->chan->center_freq < chandef->center_freq1)
+			he_6ghz_op->center_freq_seg0_idx -= 8;
+		else
+			he_6ghz_op->center_freq_seg0_idx += 8;
+		fallthrough;
+	case NL80211_CHAN_WIDTH_80P80:
+		he_6ghz_op->control =
+			IEEE80211_HE_6GHZ_CHANWIDTH_160MHZ_80P80MHZ;
+		break;
+	case NL80211_CHAN_WIDTH_80:
+		he_6ghz_op->control = IEEE80211_HE_6GHZ_CHANWIDTH_80MHZ;
+		break;
+	case NL80211_CHAN_WIDTH_40:
+		he_6ghz_op->control = IEEE80211_HE_6GHZ_CHANWIDTH_40MHZ;
+		break;
+	default:
+		he_6ghz_op->control = IEEE80211_HE_6GHZ_CHANWIDTH_20MHZ;
+		break;
+	}
+
+	pos += sizeof(struct ieee80211_he_oper_6ghz_op_info);
+
+out:
+	return pos;
 }
 
 bool ieee80211_chandef_ht_oper(const struct ieee80211_ht_operation *ht_oper,
-- 
2.26.2

