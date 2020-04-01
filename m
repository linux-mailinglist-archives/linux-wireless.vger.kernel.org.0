Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3205E19A545
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Apr 2020 08:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731847AbgDAGWL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Apr 2020 02:22:11 -0400
Received: from mail.adapt-ip.com ([173.164.178.19]:36702 "EHLO
        web.adapt-ip.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731741AbgDAGWK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Apr 2020 02:22:10 -0400
Received: from localhost (localhost [127.0.0.1])
        by web.adapt-ip.com (Postfix) with ESMTP id B68464F7A54;
        Wed,  1 Apr 2020 06:22:08 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at web.adapt-ip.com
Received: from web.adapt-ip.com ([127.0.0.1])
        by localhost (web.adapt-ip.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id RB39sZRx9Hvn; Wed,  1 Apr 2020 06:22:02 +0000 (UTC)
Received: from atlas.campbell.adapt-ip.com (gateway.adapt-ip.com [173.164.178.20])
        (Authenticated sender: thomas@adapt-ip.com)
        by web.adapt-ip.com (Postfix) with ESMTPSA id 3CA844F7A53;
        Wed,  1 Apr 2020 06:21:53 +0000 (UTC)
From:   Thomas Pedersen <thomas@adapt-ip.com>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>,
        Thomas Pedersen <thomas@adapt-ip.com>
Subject: [RFC 6/7] nl80211: add KHz frequency offset for most wifi commands
Date:   Tue, 31 Mar 2020 23:21:49 -0700
Message-Id: <20200401062150.3324-7-thomas@adapt-ip.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200401062150.3324-1-thomas@adapt-ip.com>
References: <20200401062150.3324-1-thomas@adapt-ip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

cfg80211 recently gained the ability to understand a
frequency offset component in KHz. Expose this in nl80211
through the new attributes NL80211_ATTR_WIPHY_FREQ_OFFSET,
NL80211_FREQUENCY_ATTR_OFFSET,
NL80211_ATTR_CENTER_FREQ1_OFFSET, and
NL80211_BSS_FREQUENCY_OFFSET.

These add support to send and receive a KHz offset
component with the following NL80211 commands:

- NL80211_CMD_FRAME
- NL80211_CMD_GET_SCAN
- NL80211_CMD_AUTHENTICATE
- NL80211_CMD_ASSOCIATE
- NL80211_CMD_CONNECT

Along with any other command which takes a chandef, ie:

TODO: several of these commands will eventually just
ignore the _OFFSET component, like _JOIN_MESH,
_CMD_RADAR_DETECT, etc. Should return an error to give
user a hint things won't work as expected?

- NL80211_CMD_SET_CHANNEL
- NL80211_CMD_SET_WIPHY
- NL80211_CMD_START_AP
- NL80211_CMD_RADAR_DETECT
- NL80211_CMD_NOTIFY_RADAR
- NL80211_CMD_CHANNEL_SWITCH
- NL80211_JOIN_IBSS
- NL80211_CMD_REMAIN_ON_CHANNEL
- NL80211_CMD_JOIN_CB
- NL80211_CMD_JOIN_MESH
- NL80211_CMD_TDLS_CHANNEL_SWITCH

Signed-off-by: Thomas Pedersen <thomas@adapt-ip.com>
---
 include/uapi/linux/nl80211.h | 49 ++++++++++++++++--------
 net/wireless/nl80211.c       | 72 +++++++++++++++++++++++++++---------
 2 files changed, 87 insertions(+), 34 deletions(-)

diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 2b691161830f..28401f039d75 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -296,13 +296,14 @@
  *	to get a list of all present wiphys.
  * @NL80211_CMD_SET_WIPHY: set wiphy parameters, needs %NL80211_ATTR_WIPHY or
  *	%NL80211_ATTR_IFINDEX; can be used to set %NL80211_ATTR_WIPHY_NAME,
- *	%NL80211_ATTR_WIPHY_TXQ_PARAMS, %NL80211_ATTR_WIPHY_FREQ (and the
- *	attributes determining the channel width; this is used for setting
- *	monitor mode channel),  %NL80211_ATTR_WIPHY_RETRY_SHORT,
- *	%NL80211_ATTR_WIPHY_RETRY_LONG, %NL80211_ATTR_WIPHY_FRAG_THRESHOLD,
- *	and/or %NL80211_ATTR_WIPHY_RTS_THRESHOLD.
- *	However, for setting the channel, see %NL80211_CMD_SET_CHANNEL
- *	instead, the support here is for backward compatibility only.
+ *	%NL80211_ATTR_WIPHY_TXQ_PARAMS, %NL80211_ATTR_WIPHY_FREQ,
+ *	%NL80211_ATTR_WIPHY_FREQ_OFFSET (and the attributes determining the
+ *	channel width; this is used for setting monitor mode channel),
+ *	%NL80211_ATTR_WIPHY_RETRY_SHORT, %NL80211_ATTR_WIPHY_RETRY_LONG,
+ *	%NL80211_ATTR_WIPHY_FRAG_THRESHOLD, and/or
+ *	%NL80211_ATTR_WIPHY_RTS_THRESHOLD.  However, for setting the channel,
+ *	see %NL80211_CMD_SET_CHANNEL instead, the support here is for backward
+ *	compatibility only.
  * @NL80211_CMD_NEW_WIPHY: Newly created wiphy, response to get request
  *	or rename notification. Has attributes %NL80211_ATTR_WIPHY and
  *	%NL80211_ATTR_WIPHY_NAME.
@@ -351,7 +352,8 @@
  *	%NL80211_ATTR_AUTH_TYPE, %NL80211_ATTR_INACTIVITY_TIMEOUT,
  *	%NL80211_ATTR_ACL_POLICY and %NL80211_ATTR_MAC_ADDRS.
  *	The channel to use can be set on the interface or be given using the
- *	%NL80211_ATTR_WIPHY_FREQ and the attributes determining channel width.
+ *	%NL80211_ATTR_WIPHY_FREQ and %NL80211_ATTR_WIPHY_FREQ_OFFSET, and the
+ *	attributes determining channel width.
  * @NL80211_CMD_NEW_BEACON: old alias for %NL80211_CMD_START_AP
  * @NL80211_CMD_STOP_AP: Stop AP operation on the given interface
  * @NL80211_CMD_DEL_BEACON: old alias for %NL80211_CMD_STOP_AP
@@ -536,11 +538,12 @@
  *	interface. %NL80211_ATTR_MAC is used to specify PeerSTAAddress (and
  *	BSSID in case of station mode). %NL80211_ATTR_SSID is used to specify
  *	the SSID (mainly for association, but is included in authentication
- *	request, too, to help BSS selection. %NL80211_ATTR_WIPHY_FREQ is used
- *	to specify the frequence of the channel in MHz. %NL80211_ATTR_AUTH_TYPE
- *	is used to specify the authentication type. %NL80211_ATTR_IE is used to
- *	define IEs (VendorSpecificInfo, but also including RSN IE and FT IEs)
- *	to be added to the frame.
+ *	request, too, to help BSS selection. %NL80211_ATTR_WIPHY_FREQ +
+ *	%NL80211_ATTR_WIPHY_FREQ_OFFSET is used to specify the frequence of the
+ *	channel in MHz. %NL80211_ATTR_AUTH_TYPE is used to specify the
+ *	authentication type. %NL80211_ATTR_IE is used to define IEs
+ *	(VendorSpecificInfo, but also including RSN IE and FT IEs) to be added
+ *	to the frame.
  *	When used as an event, this reports reception of an Authentication
  *	frame in station and IBSS modes when the local MLME processed the
  *	frame, i.e., it was for the local STA and was received in correct
@@ -595,8 +598,9 @@
  *	requests to connect to a specified network but without separating
  *	auth and assoc steps. For this, you need to specify the SSID in a
  *	%NL80211_ATTR_SSID attribute, and can optionally specify the association
- *	IEs in %NL80211_ATTR_IE, %NL80211_ATTR_AUTH_TYPE, %NL80211_ATTR_USE_MFP,
- *	%NL80211_ATTR_MAC, %NL80211_ATTR_WIPHY_FREQ, %NL80211_ATTR_CONTROL_PORT,
+ *	IEs in %NL80211_ATTR_IE, %NL80211_ATTR_AUTH_TYPE,
+ *	%NL80211_ATTR_USE_MFP, %NL80211_ATTR_MAC, %NL80211_ATTR_WIPHY_FREQ,
+ *	%NL80211_ATTR_WIPHY_FREQ_OFFSET, %NL80211_ATTR_CONTROL_PORT,
  *	%NL80211_ATTR_CONTROL_PORT_ETHERTYPE,
  *	%NL80211_ATTR_CONTROL_PORT_NO_ENCRYPT,
  *	%NL80211_ATTR_CONTROL_PORT_OVER_NL80211, %NL80211_ATTR_MAC_HINT, and
@@ -1422,7 +1426,8 @@ enum nl80211_commands {
  *	of &enum nl80211_chan_width, describing the channel width. See the
  *	documentation of the enum for more information.
  * @NL80211_ATTR_CENTER_FREQ1: Center frequency of the first part of the
- *	channel, used for anything but 20 MHz bandwidth
+ *	channel, used for anything but 20 MHz bandwidth. In S1G this is the
+ *	operating channel center frequency.
  * @NL80211_ATTR_CENTER_FREQ2: Center frequency of the second part of the
  *	channel, used only for 80+80 MHz bandwidth
  * @NL80211_ATTR_WIPHY_CHANNEL_TYPE: included with NL80211_ATTR_WIPHY_FREQ
@@ -2469,6 +2474,11 @@ enum nl80211_commands {
  *	entry without having to force a disconnection after the PMK timeout. If
  *	no roaming occurs between the reauth threshold and PMK expiration,
  *	disassociation is still forced.
+ * @NL80211_ATTR_WIPHY_FREQ_OFFSET: offset of the associated
+ *	%NL80211_ATTR_WIPHY_FREQ in positive KHz. Only valid when supplied with
+ *	an %NL80211_ATTR_WIPHY_FREQ_OFFSET.
+ * @NL80211_ATTR_CENTER_FREQ1_OFFSET: Center frequency offset in KHz for the
+ *	first channel segment specified in %NL80211_ATTR_CENTER_FREQ1.
  *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
@@ -2945,6 +2955,9 @@ enum nl80211_attrs {
 	NL80211_ATTR_PMK_LIFETIME,
 	NL80211_ATTR_PMK_REAUTH_THRESHOLD,
 
+	NL80211_ATTR_WIPHY_FREQ_OFFSET,
+	NL80211_ATTR_CENTER_FREQ1_OFFSET,
+
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
@@ -3666,6 +3679,7 @@ enum nl80211_wmm_rule {
  *	(see &enum nl80211_wmm_rule)
  * @NL80211_FREQUENCY_ATTR_NO_HE: HE operation is not allowed on this channel
  *	in current regulatory domain.
+ * @NL80211_FREQUENCY_ATTR_OFFSET: frequency offset in KHz
  * @NL80211_FREQUENCY_ATTR_MAX: highest frequency attribute number
  *	currently defined
  * @__NL80211_FREQUENCY_ATTR_AFTER_LAST: internal use
@@ -3696,6 +3710,7 @@ enum nl80211_frequency_attr {
 	NL80211_FREQUENCY_ATTR_NO_10MHZ,
 	NL80211_FREQUENCY_ATTR_WMM,
 	NL80211_FREQUENCY_ATTR_NO_HE,
+	NL80211_FREQUENCY_ATTR_OFFSET,
 
 	/* keep last */
 	__NL80211_FREQUENCY_ATTR_AFTER_LAST,
@@ -4466,6 +4481,7 @@ enum nl80211_bss_scan_width {
  * @NL80211_BSS_CHAIN_SIGNAL: per-chain signal strength of last BSS update.
  *	Contains a nested array of signal strength attributes (u8, dBm),
  *	using the nesting index as the antenna number.
+ * @NL80211_BSS_FREQUENCY_OFFSET: frequency offset in KHz
  * @__NL80211_BSS_AFTER_LAST: internal
  * @NL80211_BSS_MAX: highest BSS attribute
  */
@@ -4490,6 +4506,7 @@ enum nl80211_bss {
 	NL80211_BSS_PARENT_TSF,
 	NL80211_BSS_PARENT_BSSID,
 	NL80211_BSS_CHAIN_SIGNAL,
+	NL80211_BSS_FREQUENCY_OFFSET,
 
 	/* keep last */
 	__NL80211_BSS_AFTER_LAST,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index ff66f7d3e04f..ea9310f6d981 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -365,6 +365,7 @@ const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 
 	[NL80211_ATTR_CHANNEL_WIDTH] = { .type = NLA_U32 },
 	[NL80211_ATTR_CENTER_FREQ1] = { .type = NLA_U32 },
+	[NL80211_ATTR_CENTER_FREQ1_OFFSET] = { .type = NLA_U32 },
 	[NL80211_ATTR_CENTER_FREQ2] = { .type = NLA_U32 },
 
 	[NL80211_ATTR_WIPHY_RETRY_SHORT] = NLA_POLICY_MIN(NLA_U8, 1),
@@ -663,6 +664,7 @@ const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 	[NL80211_ATTR_CONTROL_PORT_NO_PREAUTH] = { .type = NLA_FLAG },
 	[NL80211_ATTR_PMK_LIFETIME] = NLA_POLICY_MIN(NLA_U32, 1),
 	[NL80211_ATTR_PMK_REAUTH_THRESHOLD] = NLA_POLICY_RANGE(NLA_U8, 1, 100),
+	[NL80211_ATTR_WIPHY_FREQ_OFFSET] = { .type = NLA_U32 },
 };
 
 /* policy for the key attributes */
@@ -947,6 +949,9 @@ static int nl80211_msg_put_channel(struct sk_buff *msg, struct wiphy *wiphy,
 			chan->center_freq))
 		goto nla_put_failure;
 
+	if (nla_put_u32(msg, NL80211_FREQUENCY_ATTR_OFFSET, chan->freq_offset))
+		goto nla_put_failure;
+
 	if ((chan->flags & IEEE80211_CHAN_DISABLED) &&
 	    nla_put_flag(msg, NL80211_FREQUENCY_ATTR_DISABLED))
 		goto nla_put_failure;
@@ -1352,13 +1357,11 @@ static int nl80211_key_allowed(struct wireless_dev *wdev)
 }
 
 static struct ieee80211_channel *nl80211_get_valid_chan(struct wiphy *wiphy,
-							struct nlattr *tb)
+							u32 freq)
 {
 	struct ieee80211_channel *chan;
 
-	if (tb == NULL)
-		return NULL;
-	chan = ieee80211_get_channel(wiphy, nla_get_u32(tb));
+	chan = ieee80211_get_channel_khz(wiphy, freq);
 	if (!chan || chan->flags & IEEE80211_CHAN_DISABLED)
 		return NULL;
 	return chan;
@@ -2813,13 +2816,17 @@ int nl80211_parse_chandef(struct cfg80211_registered_device *rdev,
 	if (!attrs[NL80211_ATTR_WIPHY_FREQ])
 		return -EINVAL;
 
-	control_freq = nla_get_u32(attrs[NL80211_ATTR_WIPHY_FREQ]);
+	control_freq = MHZ_TO_KHZ(
+			nla_get_u32(info->attrs[NL80211_ATTR_WIPHY_FREQ]));
+	if (info->attrs[NL80211_ATTR_WIPHY_FREQ_OFFSET])
+		control_freq +=
+		    nla_get_u32(info->attrs[NL80211_ATTR_WIPHY_FREQ_OFFSET]);
 
 	memset(chandef, 0, sizeof(*chandef));
-
-	chandef->chan = ieee80211_get_channel(&rdev->wiphy, control_freq);
+	chandef->chan = ieee80211_get_channel_khz(&rdev->wiphy, control_freq);
 	chandef->width = NL80211_CHAN_WIDTH_20_NOHT;
-	chandef->center_freq1 = control_freq;
+	chandef->center_freq1 = KHZ_TO_MHZ(control_freq);
+	chandef->freq1_offset = control_freq % 1000;
 	chandef->center_freq2 = 0;
 
 	/* Primary channel not allowed */
@@ -2870,6 +2877,9 @@ int nl80211_parse_chandef(struct cfg80211_registered_device *rdev,
 		if (attrs[NL80211_ATTR_CENTER_FREQ1])
 			chandef->center_freq1 =
 				nla_get_u32(attrs[NL80211_ATTR_CENTER_FREQ1]);
+		if (attrs[NL80211_ATTR_CENTER_FREQ1_OFFSET])
+			chandef->freq1_offset = nla_get_u32(
+				attrs[NL80211_ATTR_CENTER_FREQ1_OFFSET]);
 		if (attrs[NL80211_ATTR_CENTER_FREQ2])
 			chandef->center_freq2 =
 				nla_get_u32(attrs[NL80211_ATTR_CENTER_FREQ2]);
@@ -3302,6 +3312,9 @@ static int nl80211_send_chandef(struct sk_buff *msg,
 	if (nla_put_u32(msg, NL80211_ATTR_WIPHY_FREQ,
 			chandef->chan->center_freq))
 		return -ENOBUFS;
+	if (nla_put_u32(msg, NL80211_ATTR_WIPHY_FREQ_OFFSET,
+			chandef->chan->freq_offset))
+		return -ENOBUFS;
 	switch (chandef->width) {
 	case NL80211_CHAN_WIDTH_20_NOHT:
 	case NL80211_CHAN_WIDTH_20:
@@ -8906,6 +8919,8 @@ static int nl80211_send_bss(struct sk_buff *msg, struct netlink_callback *cb,
 		goto nla_put_failure;
 	if (nla_put_u16(msg, NL80211_BSS_CAPABILITY, res->capability) ||
 	    nla_put_u32(msg, NL80211_BSS_FREQUENCY, res->channel->center_freq) ||
+	    nla_put_u32(msg, NL80211_BSS_FREQUENCY_OFFSET,
+		        res->channel->freq_offset) ||
 	    nla_put_u32(msg, NL80211_BSS_CHAN_WIDTH, res->scan_width) ||
 	    nla_put_u32(msg, NL80211_BSS_SEEN_MS_AGO,
 			jiffies_to_msecs(jiffies - intbss->ts)))
@@ -9174,6 +9189,7 @@ static int nl80211_authenticate(struct sk_buff *skb, struct genl_info *info)
 	enum nl80211_auth_type auth_type;
 	struct key_parse key;
 	bool local_state_change;
+	u32 freq;
 
 	if (!info->attrs[NL80211_ATTR_MAC])
 		return -EINVAL;
@@ -9230,8 +9246,12 @@ static int nl80211_authenticate(struct sk_buff *skb, struct genl_info *info)
 		return -EOPNOTSUPP;
 
 	bssid = nla_data(info->attrs[NL80211_ATTR_MAC]);
-	chan = nl80211_get_valid_chan(&rdev->wiphy,
-				      info->attrs[NL80211_ATTR_WIPHY_FREQ]);
+	freq = MHZ_TO_KHZ(nla_get_u32(info->attrs[NL80211_ATTR_WIPHY_FREQ]));
+	if (info->attrs[NL80211_ATTR_WIPHY_FREQ_OFFSET])
+		freq +=
+		    nla_get_u32(info->attrs[NL80211_ATTR_WIPHY_FREQ_OFFSET]);
+
+	chan = nl80211_get_valid_chan(&rdev->wiphy, freq);
 	if (!chan)
 		return -EINVAL;
 
@@ -9421,6 +9441,7 @@ static int nl80211_associate(struct sk_buff *skb, struct genl_info *info)
 	struct cfg80211_assoc_request req = {};
 	const u8 *bssid, *ssid;
 	int err, ssid_len = 0;
+	u32 freq;
 
 	if (dev->ieee80211_ptr->conn_owner_nlportid &&
 	    dev->ieee80211_ptr->conn_owner_nlportid != info->snd_portid)
@@ -9440,8 +9461,11 @@ static int nl80211_associate(struct sk_buff *skb, struct genl_info *info)
 
 	bssid = nla_data(info->attrs[NL80211_ATTR_MAC]);
 
-	chan = nl80211_get_valid_chan(&rdev->wiphy,
-				      info->attrs[NL80211_ATTR_WIPHY_FREQ]);
+	freq = MHZ_TO_KHZ(nla_get_u32(info->attrs[NL80211_ATTR_WIPHY_FREQ]));
+	if (info->attrs[NL80211_ATTR_WIPHY_FREQ_OFFSET])
+		freq +=
+		    nla_get_u32(info->attrs[NL80211_ATTR_WIPHY_FREQ_OFFSET]);
+	chan = nl80211_get_valid_chan(&rdev->wiphy, freq);
 	if (!chan)
 		return -EINVAL;
 
@@ -10121,6 +10145,7 @@ static int nl80211_connect(struct sk_buff *skb, struct genl_info *info)
 	struct cfg80211_connect_params connect;
 	struct wiphy *wiphy;
 	struct cfg80211_cached_keys *connkeys = NULL;
+	u32 freq = 0;
 	int err;
 
 	memset(&connect, 0, sizeof(connect));
@@ -10191,14 +10216,21 @@ static int nl80211_connect(struct sk_buff *skb, struct genl_info *info)
 		connect.prev_bssid =
 			nla_data(info->attrs[NL80211_ATTR_PREV_BSSID]);
 
-	if (info->attrs[NL80211_ATTR_WIPHY_FREQ]) {
-		connect.channel = nl80211_get_valid_chan(
-			wiphy, info->attrs[NL80211_ATTR_WIPHY_FREQ]);
+	if (info->attrs[NL80211_ATTR_WIPHY_FREQ])
+		freq = MHZ_TO_KHZ(nla_get_u32(
+					info->attrs[NL80211_ATTR_WIPHY_FREQ]));
+	if (info->attrs[NL80211_ATTR_WIPHY_FREQ_OFFSET])
+		freq +=
+		    nla_get_u32(info->attrs[NL80211_ATTR_WIPHY_FREQ_OFFSET]);
+
+	if (freq) {
+		connect.channel = nl80211_get_valid_chan(wiphy, freq);
 		if (!connect.channel)
 			return -EINVAL;
 	} else if (info->attrs[NL80211_ATTR_WIPHY_FREQ_HINT]) {
-		connect.channel_hint = nl80211_get_valid_chan(
-			wiphy, info->attrs[NL80211_ATTR_WIPHY_FREQ_HINT]);
+		freq = nla_get_u32(info->attrs[NL80211_ATTR_WIPHY_FREQ_HINT]);
+		freq = MHZ_TO_KHZ(freq);
+		connect.channel_hint = nl80211_get_valid_chan(wiphy, freq);
 		if (!connect.channel_hint)
 			return -EINVAL;
 	}
@@ -16227,6 +16259,7 @@ int nl80211_send_mgmt(struct cfg80211_registered_device *rdev,
 	    nla_put_u64_64bit(msg, NL80211_ATTR_WDEV, wdev_id(wdev),
 			      NL80211_ATTR_PAD) ||
 	    nla_put_u32(msg, NL80211_ATTR_WIPHY_FREQ, KHZ_TO_MHZ(freq)) ||
+	    nla_put_u32(msg, NL80211_ATTR_WIPHY_FREQ_OFFSET, freq % 1000) ||
 	    (sig_dbm &&
 	     nla_put_u32(msg, NL80211_ATTR_RX_SIGNAL_DBM, sig_dbm)) ||
 	    nla_put(msg, NL80211_ATTR_FRAME, len, buf) ||
@@ -16877,7 +16910,10 @@ void cfg80211_report_obss_beacon(struct wiphy *wiphy,
 
 		if (nla_put_u32(msg, NL80211_ATTR_WIPHY, rdev->wiphy_idx) ||
 		    (freq &&
-		     nla_put_u32(msg, NL80211_ATTR_WIPHY_FREQ, KHZ_TO_MHZ(freq))) ||
+		     (nla_put_u32(msg, NL80211_ATTR_WIPHY_FREQ,
+				  KHZ_TO_MHZ(freq)) ||
+		      nla_put_u32(msg, NL80211_ATTR_WIPHY_FREQ_OFFSET,
+				  freq % 1000))) ||
 		    (sig_dbm &&
 		     nla_put_u32(msg, NL80211_ATTR_RX_SIGNAL_DBM, sig_dbm)) ||
 		    nla_put(msg, NL80211_ATTR_FRAME, len, frame))
-- 
2.20.1

