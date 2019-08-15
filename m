Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 409E08ED11
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Aug 2019 15:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732377AbfHONjO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 15 Aug 2019 09:39:14 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:44496 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732299AbfHONjN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 15 Aug 2019 09:39:13 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 1F34D607DF; Thu, 15 Aug 2019 13:39:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1565876353;
        bh=fup6DNaN6qOdIX+VRu2tTIkM6QhOn+epEsz4x2IZYlM=;
        h=From:To:Cc:Subject:Date:From;
        b=mfETrM6540mpFJ4LMm2ZOuW/kLVY0WmL/VPWBAGLw4DkcI65wIqJglROEYKpX5kC5
         lKm7kWIwGUw3u7fEBqhaQH06QtIR5eZLMQk7PLlv2GVBmM1C6nWyKWGWIUOBjgBgA0
         0g14qnd1qY7SB5NfZKkE4Erz2QYwxu+PW/P31m7s=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from jouni.codeaurora.org (87-93-55-163.bb.dnainternet.fi [87.93.55.163])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jouni@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 90F43607DF;
        Thu, 15 Aug 2019 13:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1565876340;
        bh=fup6DNaN6qOdIX+VRu2tTIkM6QhOn+epEsz4x2IZYlM=;
        h=From:To:Cc:Subject:Date:From;
        b=PIaMwe3FOZp22BwZ20jLsLduCotx8nqvbQLo4e4aAZWz0ot4FP4BhDR0gASb6bVNF
         vpTD/ES8/PTWEJ0LIclJEQhPBGBHFf5WTQlkBTMkdxoD8pBSCF/PieaMR6uxlzecMK
         nlX6vEZQIz1MUmQOROPB50EgUQSsKoa21nXSEnLE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 90F43607DF
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jouni@codeaurora.org
From:   Jouni Malinen <jouni@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        Gurumoorthi Gnanasambandhan <gguru@codeaurora.org>,
        Jouni Malinen <jouni@codeaurora.org>
Subject: [PATCH] cfg80211: VLAN offload support for set_key and set_sta_vlan
Date:   Thu, 15 Aug 2019 16:38:25 +0300
Message-Id: <20190815133825.8131-1-jouni@codeaurora.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Gurumoorthi Gnanasambandhan <gguru@codeaurora.org>

This provides an alternative mechanism for AP VLAN support where a
single netdev is used with VLAN tagged frames instead of separate
netdevs for each VLAN without tagged frames from the WLAN driver.

By setting NL80211_EXT_FEATURE_VLAN_OFFLOAD flag the driver indicates
support for a single netdev with VLAN tagged frames. Separate
VLAN-specific netdevs are added using vcongig similar to Ethernet.
NL80211_CMD_NEW_KEY and NL80211_CMD_SET_STATION will optionally specify
vlan_id using NL80211_ATTR_VLAN_ID.

Signed-off-by: Gurumoorthi Gnanasambandhan <gguru@codeaurora.org>
Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
---
 include/net/cfg80211.h       |  4 ++++
 include/uapi/linux/nl80211.h | 20 ++++++++++++++++++++
 net/wireless/nl80211.c       |  7 +++++++
 3 files changed, 31 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 35ec1f0a2bf9..3355f56ca0b8 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -509,6 +509,7 @@ struct vif_params {
  *	with the get_key() callback, must be in little endian,
  *	length given by @seq_len.
  * @seq_len: length of @seq.
+ * @vlan_id: vlan_id for VLAN group key (if nonzero)
  * @mode: key install mode (RX_TX, NO_TX or SET_TX)
  */
 struct key_params {
@@ -516,6 +517,7 @@ struct key_params {
 	const u8 *seq;
 	int key_len;
 	int seq_len;
+	u16 vlan_id;
 	u32 cipher;
 	enum nl80211_key_mode mode;
 };
@@ -1046,6 +1048,7 @@ struct sta_txpwr {
  *	(bitmask of BIT(%NL80211_STA_FLAG_...))
  * @listen_interval: listen interval or -1 for no change
  * @aid: AID or zero for no change
+ * @vlan_id: VLAN ID for station (if nonzero)
  * @peer_aid: mesh peer AID or zero for no change
  * @plink_action: plink action to take
  * @plink_state: set the peer link state for a station
@@ -1081,6 +1084,7 @@ struct station_parameters {
 	u32 sta_modify_mask;
 	int listen_interval;
 	u16 aid;
+	u16 vlan_id;
 	u16 peer_aid;
 	u8 supported_rates_len;
 	u8 plink_action;
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 822851d369ab..0af5740648e8 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -243,6 +243,17 @@
  * %NL80211_ATTR_SAE_PASSWORD.
  */
 
+/**
+ * DOC: VLAN offload support for setting group keys and binding STAs to VLANs
+ *
+ * By setting @NL80211_EXT_FEATURE_VLAN_OFFLOAD flag drivers can indicate they
+ * support offloading VLAN functionality in a manner where the driver exposes a
+ * single netdev that used VLAN tagged frames and separate VLAN-specific netdevs
+ * can then be added using vconfig similarly to the Ethernet case.
+ * %NL80211_CMD_NEW_KEY and %NL80211_CMD_SET_STATION will optionally specify
+ * vlan_id using NL80211_ATTR_VLAN_ID.
+ */
+
 /**
  * enum nl80211_commands - supported nl80211 commands
  *
@@ -2361,6 +2372,8 @@ enum nl80211_commands {
  * @NL80211_ATTR_HE_OBSS_PD: nested attribute for OBSS Packet Detection
  *	functionality.
  *
+ * @NL80211_ATTR_VLAN_ID: VLAN ID for the station and VLAN group key (u16).
+ *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
  * @__NL80211_ATTR_AFTER_LAST: internal use
@@ -2820,6 +2833,8 @@ enum nl80211_attrs {
 
 	NL80211_ATTR_HE_OBSS_PD,
 
+	NL80211_ATTR_VLAN_ID,
+
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
@@ -5452,6 +5467,10 @@ enum nl80211_feature_flags {
  * @NL80211_EXT_FEATURE_SAE_OFFLOAD: Device wants to do SAE authentication in
  *	station mode (SAE password is passed as part of the connect command).
  *
+ * @NL80211_EXT_FEATURE_VLAN_OFFLOAD: The driver supports a single netdev
+ *	with VLAN tagged frames and separate VLAN-specific netdevs added using
+ *	vconfig similarly to the Ethernet case.
+ *
  * @NUM_NL80211_EXT_FEATURES: number of extended features.
  * @MAX_NL80211_EXT_FEATURES: highest extended feature index.
  */
@@ -5497,6 +5516,7 @@ enum nl80211_ext_feature_index {
 	NL80211_EXT_FEATURE_EXT_KEY_ID,
 	NL80211_EXT_FEATURE_STA_TX_PWR,
 	NL80211_EXT_FEATURE_SAE_OFFLOAD,
+	NL80211_EXT_FEATURE_VLAN_OFFLOAD,
 
 	/* add new features before the definition below */
 	NUM_NL80211_EXT_FEATURES,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 1a107f29016b..860aec59003a 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -584,6 +584,7 @@ const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 					.len = SAE_PASSWORD_MAX_LEN },
 	[NL80211_ATTR_TWT_RESPONDER] = { .type = NLA_FLAG },
 	[NL80211_ATTR_HE_OBSS_PD] = NLA_POLICY_NESTED(he_obss_pd_policy),
+	[NL80211_ATTR_VLAN_ID] = { .type = NLA_U16 },
 };
 
 /* policy for the key attributes */
@@ -3865,6 +3866,9 @@ static int nl80211_new_key(struct sk_buff *skb, struct genl_info *info)
 	if (info->attrs[NL80211_ATTR_MAC])
 		mac_addr = nla_data(info->attrs[NL80211_ATTR_MAC]);
 
+	if (info->attrs[NL80211_ATTR_VLAN_ID])
+		key.p.vlan_id = nla_get_u16(info->attrs[NL80211_ATTR_VLAN_ID]);
+
 	if (key.type == -1) {
 		if (mac_addr)
 			key.type = NL80211_KEYTYPE_PAIRWISE;
@@ -5647,6 +5651,9 @@ static int nl80211_set_station(struct sk_buff *skb, struct genl_info *info)
 	if (info->attrs[NL80211_ATTR_STA_AID])
 		params.aid = nla_get_u16(info->attrs[NL80211_ATTR_STA_AID]);
 
+	if (info->attrs[NL80211_ATTR_VLAN_ID])
+		params.vlan_id = nla_get_u16(info->attrs[NL80211_ATTR_VLAN_ID]);
+
 	if (info->attrs[NL80211_ATTR_STA_LISTEN_INTERVAL])
 		params.listen_interval =
 		     nla_get_u16(info->attrs[NL80211_ATTR_STA_LISTEN_INTERVAL]);
-- 
2.20.1

