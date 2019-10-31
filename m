Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D5B7EB932
	for <lists+linux-wireless@lfdr.de>; Thu, 31 Oct 2019 22:47:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728791AbfJaVrJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 31 Oct 2019 17:47:09 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:39120 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728598AbfJaVrI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 31 Oct 2019 17:47:08 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 1912660D62; Thu, 31 Oct 2019 21:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572558427;
        bh=PIXLFj2NVr14L2LDqQdMjNrSZaPvUmGRQ5pNW2FeDdI=;
        h=From:To:Cc:Subject:Date:From;
        b=GHw1beaVTmQB8g9MaB6dHEYp8OVT9jqAmsaWuk8zbt4rUEgfpyhGstbqhRE0IJMjZ
         w20yh2Hn9rRSbQ44irTRD8IfDuBvI2s+kyK/ymVQq8FODFSyS0gDWyPdqvlI0p5NUB
         gShFx2lpjltytymPmQ1cJV3y1FX0hn1nsL66b23Y=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from jouni.codeaurora.org (213-216-231-214.co.dnainternet.fi [213.216.231.214])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jouni@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BF64560B72;
        Thu, 31 Oct 2019 21:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572558415;
        bh=PIXLFj2NVr14L2LDqQdMjNrSZaPvUmGRQ5pNW2FeDdI=;
        h=From:To:Cc:Subject:Date:From;
        b=AtAJ0SaQKEfJo6eI5m30Cin88zWVO0sDdAbXgKOiNmat2tPVJoAnFlUvy8FYQuSo2
         whwcmOD5NuYuKqvTybA3dWystv40LOLMxb9sAK6u+TtDTaAeBokReRyo1AB3t445AO
         BrHljXf1HhE3pQO0fdSXXILHFOqxmt63aM/ucaWc=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BF64560B72
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jouni@codeaurora.org
From:   Jouni Malinen <jouni@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org,
        Gurumoorthi Gnanasambandhan <gguru@codeaurora.org>,
        Jouni Malinen <jouni@codeaurora.org>
Subject: [PATCH v2] cfg80211: VLAN offload support for set_key and set_sta_vlan
Date:   Thu, 31 Oct 2019 23:46:40 +0200
Message-Id: <20191031214640.5012-1-jouni@codeaurora.org>
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
VLAN-specific netdevs can be added using RTM_NEWLINK/IFLA_VLAN_ID
similarly to Ethernet. NL80211_CMD_NEW_KEY (for group keys),
NL80211_CMD_NEW_STATION, and NL80211_CMD_SET_STATION will optionally
specify vlan_id using NL80211_ATTR_VLAN_ID.

Signed-off-by: Gurumoorthi Gnanasambandhan <gguru@codeaurora.org>
Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
---
 include/net/cfg80211.h       |  4 ++++
 include/uapi/linux/nl80211.h | 26 ++++++++++++++++++++++++++
 net/wireless/nl80211.c       | 11 +++++++++++
 3 files changed, 41 insertions(+)

v2:
- enforce allowed range for NL80211_ATTR_VLAN_ID in nl80211_policy
- allow VLAN ID for a key to be specified only for group keys
- allow VLAN ID to be specified when adding a new STA, not just when
  updating an existing STA entry
  * note that it is indeed allowed to change VLAN binding during an
    association and that happens in many use cases in practice as well
    since the VLAN ID is received from a RADIUS server only after
    completing EAP authentication
- updated nl80211.h documentation based on received comments


diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 4ab2c49423dc..e309cc826b40 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -565,6 +565,7 @@ struct vif_params {
  *	with the get_key() callback, must be in little endian,
  *	length given by @seq_len.
  * @seq_len: length of @seq.
+ * @vlan_id: vlan_id for VLAN group key (if nonzero)
  * @mode: key install mode (RX_TX, NO_TX or SET_TX)
  */
 struct key_params {
@@ -572,6 +573,7 @@ struct key_params {
 	const u8 *seq;
 	int key_len;
 	int seq_len;
+	u16 vlan_id;
 	u32 cipher;
 	enum nl80211_key_mode mode;
 };
@@ -1124,6 +1126,7 @@ struct sta_txpwr {
  *	(bitmask of BIT(%NL80211_STA_FLAG_...))
  * @listen_interval: listen interval or -1 for no change
  * @aid: AID or zero for no change
+ * @vlan_id: VLAN ID for station (if nonzero)
  * @peer_aid: mesh peer AID or zero for no change
  * @plink_action: plink action to take
  * @plink_state: set the peer link state for a station
@@ -1159,6 +1162,7 @@ struct station_parameters {
 	u32 sta_modify_mask;
 	int listen_interval;
 	u16 aid;
+	u16 vlan_id;
 	u16 peer_aid;
 	u8 supported_rates_len;
 	u8 plink_action;
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 64135ab3a7ac..341e0e8cae46 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -248,6 +248,22 @@
  * %NL80211_ATTR_SAE_PASSWORD.
  */
 
+/**
+ * DOC: VLAN offload support for setting group keys and binding STAs to VLANs
+ *
+ * By setting @NL80211_EXT_FEATURE_VLAN_OFFLOAD flag drivers can indicate they
+ * support offloading VLAN functionality in a manner where the driver exposes a
+ * single netdev that uses VLAN tagged frames and separate VLAN-specific netdevs
+ * can then be added using RTM_NEWLINK/IFLA_VLAN_ID similarly to the Ethernet
+ * case. Frames received from stations that are not assigned to any VLAN are
+ * delivered on the main netdev and frames to such stations can be sent through
+ * that main netdev.
+ *
+ * %NL80211_CMD_NEW_KEY (for group keys), %NL80211_CMD_NEW_STATION, and
+ * %NL80211_CMD_SET_STATION will optionally specify vlan_id using
+ * %NL80211_ATTR_VLAN_ID.
+ */
+
 /**
  * enum nl80211_commands - supported nl80211 commands
  *
@@ -2381,6 +2397,9 @@ enum nl80211_commands {
  *	the allowed channel bandwidth configurations. (u8 attribute)
  *	Defined by IEEE P802.11ay/D4.0 section 9.4.2.251, Table 13.
  *
+ * @NL80211_ATTR_VLAN_ID: VLAN ID (1..4094) for the station and VLAN group key
+ *	(u16).
+ *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
  * @__NL80211_ATTR_AFTER_LAST: internal use
@@ -2843,6 +2862,8 @@ enum nl80211_attrs {
 	NL80211_ATTR_WIPHY_EDMG_CHANNELS,
 	NL80211_ATTR_WIPHY_EDMG_BW_CONFIG,
 
+	NL80211_ATTR_VLAN_ID,
+
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
@@ -5492,6 +5513,10 @@ enum nl80211_feature_flags {
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
@@ -5537,6 +5562,7 @@ enum nl80211_ext_feature_index {
 	NL80211_EXT_FEATURE_EXT_KEY_ID,
 	NL80211_EXT_FEATURE_STA_TX_PWR,
 	NL80211_EXT_FEATURE_SAE_OFFLOAD,
+	NL80211_EXT_FEATURE_VLAN_OFFLOAD,
 
 	/* add new features before the definition below */
 	NUM_NL80211_EXT_FEATURES,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index d1451e731bb8..50761a4102bd 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -624,6 +624,7 @@ const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 					.len = SAE_PASSWORD_MAX_LEN },
 	[NL80211_ATTR_TWT_RESPONDER] = { .type = NLA_FLAG },
 	[NL80211_ATTR_HE_OBSS_PD] = NLA_POLICY_NESTED(he_obss_pd_policy),
+	[NL80211_ATTR_VLAN_ID] = NLA_POLICY_RANGE(NLA_U16, 1, VLAN_N_VID - 2),
 };
 
 /* policy for the key attributes */
@@ -3940,6 +3941,10 @@ static int nl80211_new_key(struct sk_buff *skb, struct genl_info *info)
 	    key.type != NL80211_KEYTYPE_GROUP)
 		return -EINVAL;
 
+	if (key.type == NL80211_KEYTYPE_GROUP &&
+	    info->attrs[NL80211_ATTR_VLAN_ID])
+		key.p.vlan_id = nla_get_u16(info->attrs[NL80211_ATTR_VLAN_ID]);
+
 	if (!rdev->ops->add_key)
 		return -EOPNOTSUPP;
 
@@ -5711,6 +5716,9 @@ static int nl80211_set_station(struct sk_buff *skb, struct genl_info *info)
 	if (info->attrs[NL80211_ATTR_STA_AID])
 		params.aid = nla_get_u16(info->attrs[NL80211_ATTR_STA_AID]);
 
+	if (info->attrs[NL80211_ATTR_VLAN_ID])
+		params.vlan_id = nla_get_u16(info->attrs[NL80211_ATTR_VLAN_ID]);
+
 	if (info->attrs[NL80211_ATTR_STA_LISTEN_INTERVAL])
 		params.listen_interval =
 		     nla_get_u16(info->attrs[NL80211_ATTR_STA_LISTEN_INTERVAL]);
@@ -5856,6 +5864,9 @@ static int nl80211_new_station(struct sk_buff *skb, struct genl_info *info)
 	params.listen_interval =
 		nla_get_u16(info->attrs[NL80211_ATTR_STA_LISTEN_INTERVAL]);
 
+	if (info->attrs[NL80211_ATTR_VLAN_ID])
+		params.vlan_id = nla_get_u16(info->attrs[NL80211_ATTR_VLAN_ID]);
+
 	if (info->attrs[NL80211_ATTR_STA_SUPPORT_P2P_PS]) {
 		params.support_p2p_ps =
 			nla_get_u8(info->attrs[NL80211_ATTR_STA_SUPPORT_P2P_PS]);
-- 
2.20.1

