Return-Path: <linux-wireless+bounces-31749-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id APXUAwoTjWl/ygAAu9opvQ
	(envelope-from <linux-wireless+bounces-31749-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Feb 2026 00:38:50 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A01B128560
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Feb 2026 00:38:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6DC6B302B313
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Feb 2026 23:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77A28357A4A;
	Wed, 11 Feb 2026 23:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y2KlrCGT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549E435770A
	for <linux-wireless@vger.kernel.org>; Wed, 11 Feb 2026 23:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770853119; cv=none; b=dwaVYQwcfsMDITapFMOKc1QOZxh51jWJejDvRWAKXFo202Jlk5oWxZpX0HX8WUsEdPgelN+29Pju6KmprNIu4himHxYDyenMjcY8YjLELrgmxTQQ3bG2KPaCOyJN0oX6Mrahhy7FsCanfFBw3p2GPv/zQk8VzW6HVqR3neOCc00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770853119; c=relaxed/simple;
	bh=BXdBKuSZD36GvdOr+aec7UUiWZmuPjcOl3GpF3Wkubw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ts+euayHBZIS2HwGDqFTR28vpm3P5Mj7jxxD4ugMYI2hdSqIsVI71yyRh+wBSfzP4P7El5GXuPGNxZM9yphg8tBhqocej+R5N+MxFLaxbfSRFhdfjn3YiAJB8yTxG+8QsN3EgqDauFE78RFu5aAvUsYkNJRfacOAPSrKgFZrFhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y2KlrCGT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1425C4CEF7;
	Wed, 11 Feb 2026 23:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770853119;
	bh=BXdBKuSZD36GvdOr+aec7UUiWZmuPjcOl3GpF3Wkubw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Y2KlrCGTVdmBp3vAS299KRWMUZrqjKcGvNLmxV7+RxVgJiS6MLvI3vCvUZHYD1Fjx
	 D4x4J4pYK2ElsIFYDhbE+sH9E531DE1qGhNnopOv+GCd3CSlX6bcgxhPOGjvOX4WZS
	 oZqjsmgfZZpRxEI9YLxI+SKCvZaNfRKbHEIpl1mvLpSGGi0MwZHsTwBMluqWywphO8
	 Y7IBhsVU+a2M0YysC9zMjY7BCDae/OazXIDO6OX0gQClnwigM5K1MBDufKnW67BgHc
	 hx29sLvzyegFOxfpTFaU3MznQQ6RqYHsIhJJYPE+eL0yBKm/5PeSibdPG8IRHf+FTV
	 1Dtt7rAgYCw7g==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Thu, 12 Feb 2026 00:38:11 +0100
Subject: [PATCH RFC 1/2] wifi: mac80211: Add the capability to offload MLO
 link reconfiguration countdown in the NIC fw
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260212-mt7996-link-reconf-v1-1-2b110340d6c4@kernel.org>
References: <20260212-mt7996-link-reconf-v1-0-2b110340d6c4@kernel.org>
In-Reply-To: <20260212-mt7996-link-reconf-v1-0-2b110340d6c4@kernel.org>
To: Johannes Berg <johannes@sipsolutions.net>, Felix Fietkau <nbd@nbd.name>, 
 Ryder Lee <ryder.lee@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>, 
 Sean Wang <sean.wang@mediatek.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Aditya Kumar Singh <aditya.kumar.singh@oss.qualcomm.com>, 
 Ping-Ke Shih <pkshih@realtek.com>, 
 Jeff Johnson <jeff.johnson@oss.qualcomm.com>, 
 linux-wireless@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Lorenzo Bianconi <lorenzo@kernel.org>
X-Mailer: b4 0.14.2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31749-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[sipsolutions.net,nbd.name,mediatek.com,gmail.com,collabora.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lorenzo@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 3A01B128560
X-Rspamd-Action: no action

Introduce the capability to offload the countdown for MLO link
reconfiguration IE if supported by the underlay driver/firmware.
MLO link reconfiguration IE is added to beacons/probe replies sent by
the MLD AP if the specified link is going to be removed.
The driver is supposed to set the WIPHY_FLAG_MLO_RECONF_ADV_OFFLOAD flag
to notify mac80211/hostapd it supports this capability in hw/fw.
Moreover, the driver is supposed to generate an event to notify
mac80211/hostapd when the countdown is completed calling
ieee80211_mlo_reconf_complete_notify() utility routine.
mac80211/cfg80211 will generate a
NL80211_CMD_MLO_RECONF_ADV_OFFLOAD_EVENT event for hostapd.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 include/net/cfg80211.h       | 13 ++++++++++
 include/net/mac80211.h       | 13 ++++++++++
 include/uapi/linux/nl80211.h | 12 +++++++++
 net/mac80211/cfg.c           | 16 ++++++++++++
 net/mac80211/ieee80211_i.h   |  5 ++++
 net/mac80211/iface.c         | 14 ++++++++++
 net/wireless/nl80211.c       | 61 ++++++++++++++++++++++++++++++++++++++++++++
 7 files changed, 134 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index fc01de19c7981a906a5303899e7000d8193c60a8..b3ce45674e3004b592b95c4dc08ba53929f27908 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -5329,6 +5329,8 @@ struct cfg80211_ops {
  * @WIPHY_FLAG_SUPPORTS_NSTR_NONPRIMARY: support connection to non-primary link
  *	of an NSTR mobile AP MLD.
  * @WIPHY_FLAG_DISABLE_WEXT: disable wireless extensions for this device
+ * @WIPHY_FLAG_MLO_RECONF_ADV_OFFLOAD: The underly driver supports link
+ *	reconfiguration countdown in hw.
  */
 enum wiphy_flags {
 	WIPHY_FLAG_SUPPORTS_EXT_KEK_KCK		= BIT(0),
@@ -5357,6 +5359,7 @@ enum wiphy_flags {
 	WIPHY_FLAG_HAS_CHANNEL_SWITCH		= BIT(23),
 	WIPHY_FLAG_NOTIFY_REGDOM_BY_DRIVER	= BIT(24),
 	WIPHY_FLAG_CHANNEL_CHANGE_ON_BEACON     = BIT(25),
+	WIPHY_FLAG_MLO_RECONF_ADV_OFFLOAD	= BIT(26),
 };
 
 /**
@@ -10314,6 +10317,16 @@ struct cfg80211_mlo_reconf_done_data {
 void cfg80211_mlo_reconf_add_done(struct net_device *dev,
 				  struct cfg80211_mlo_reconf_done_data *data);
 
+/**
+ * cfg80211_mlo_reconf_complete_notify - Notify about MLO reconfiguration
+ * countdown completion.
+ * @dev: network device.
+ * @link_bitmap: bitmap representing the links the driver was announcing in
+ * the Reconfiguration Multi-Link element.
+ */
+void cfg80211_mlo_reconf_complete_notify(struct net_device *dev,
+					 u16 link_bitmap);
+
 /**
  * cfg80211_schedule_channels_check - schedule regulatory check if needed
  * @wdev: the wireless device to check
diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 7f9d96939a4ea715eea288a83aeb9a0aa863c8df..ced70e42c4a4db65c86bd8a43c8b42428663adf0 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -7801,6 +7801,19 @@ void
 ieee80211_obss_color_collision_notify(struct ieee80211_vif *vif,
 				      u64 color_bitmap, u8 link_id);
 
+
+/**
+ * ieee80211_mlo_reconf_complete_notify - notify userland about MLO
+ * link reconfiguration announcement completion.
+ *
+ * @vif: &struct ieee80211_vif pointer from the add_interface callback.
+ * @link_bitmap: bitmap representing the links the driver was announcing in
+ * the Reconfiguration Multi-Link element.
+ *
+ */
+void ieee80211_mlo_reconf_complete_notify(struct ieee80211_vif *vif,
+					  u16 link_bitmap);
+
 /**
  * ieee80211_is_tx_data - check if frame is a data frame
  *
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index b63f718509060dd4b7b59e2d6cc2aad280acaa22..5c7c80d5f1e5addb78e40514db8b30bbf6041fd4 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -1361,6 +1361,10 @@
  *	user space that the NAN new cluster has been joined. The cluster ID is
  *	indicated by %NL80211_ATTR_MAC.
  *
+ * @NL80211_CMD_MLO_RECONF_ADV_OFFLOAD_EVENT: This command is used to notify
+ *	user space the underlay driver has completed the MLO link
+ *	reconfiguration announcement countdown.
+ *
  * @NL80211_CMD_MAX: highest used command number
  * @__NL80211_CMD_AFTER_LAST: internal use
  */
@@ -1624,6 +1628,8 @@ enum nl80211_commands {
 	NL80211_CMD_NAN_NEXT_DW_NOTIFICATION,
 	NL80211_CMD_NAN_CLUSTER_JOINED,
 
+	NL80211_CMD_MLO_RECONF_ADV_OFFLOAD_EVENT,
+
 	/* add new commands above here */
 
 	/* used to define NL80211_CMD_MAX below */
@@ -2984,6 +2990,10 @@ enum nl80211_commands {
  *	this feature during association. This is a flag attribute.
  *	Currently only supported in mac80211 drivers.
  *
+ * @NL80211_ATTR_MLO_RECONF_ADV_OFFLOAD: Flag attribute to indicate user space
+ *	the driver supports link reconfiguration countdown in hw when a link is
+ *	removed.
+ *
  * @NUM_NL80211_ATTR: total number of nl80211_attrs available
  * @NL80211_ATTR_MAX: highest attribute number currently defined
  * @__NL80211_ATTR_AFTER_LAST: internal use
@@ -3557,6 +3567,8 @@ enum nl80211_attrs {
 	NL80211_ATTR_UHR_CAPABILITY,
 	NL80211_ATTR_DISABLE_UHR,
 
+	NL80211_ATTR_MLO_RECONF_ADV_OFFLOAD,
+
 	/* add attributes here, update the policy in nl80211.c */
 
 	__NL80211_ATTR_AFTER_LAST,
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 5d04d7d550b0b0af2d84148317aa152ad5647986..b20086160fd8741450e0f863d93cc2cd6964470d 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -5318,6 +5318,22 @@ ieee80211_obss_color_collision_notify(struct ieee80211_vif *vif,
 }
 EXPORT_SYMBOL_GPL(ieee80211_obss_color_collision_notify);
 
+void ieee80211_mlo_reconf_complete_notify(struct ieee80211_vif *vif,
+					  u16 link_bitmap)
+{
+	struct ieee80211_sub_if_data *sdata = vif_to_sdata(vif);
+
+	if (vif->type != NL80211_IFTYPE_AP)
+		return;
+
+	if (test_and_set_bit(IEEE80211_IF_AP_RECONF_LINKS, &sdata->u.ap.flags))
+		return;
+
+	sdata->u.ap.reconf_links = link_bitmap;
+	wiphy_work_queue(sdata->local->hw.wiphy, &sdata->work);
+}
+EXPORT_SYMBOL_GPL(ieee80211_mlo_reconf_complete_notify);
+
 static int
 ieee80211_color_change(struct wiphy *wiphy, struct net_device *dev,
 		       struct cfg80211_color_change_settings *params)
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index e60b814dd89e03a5b6dd7537375b49246e5b78a5..74bc6311e430a2374afe790a7aa5686f5a62c351 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -325,6 +325,8 @@ struct ps_data {
 	int sb_count; /* num short beacons til next long beacon */
 };
 
+#define IEEE80211_IF_AP_RECONF_LINKS	BIT(0)
+
 struct ieee80211_if_ap {
 	struct list_head vlans; /* write-protected with RTNL and local->mtx */
 
@@ -333,6 +335,9 @@ struct ieee80211_if_ap {
 
 	bool multicast_to_unicast;
 	bool active;
+
+	unsigned long flags;
+	u16 reconf_links;
 };
 
 struct ieee80211_if_vlan {
diff --git a/net/mac80211/iface.c b/net/mac80211/iface.c
index 676b2a43c9f2f2de03f4dd3993bf5c0ba2de0d36..6cfee360b2e7bb08cf15be84a35a0825538725e3 100644
--- a/net/mac80211/iface.c
+++ b/net/mac80211/iface.c
@@ -1776,6 +1776,17 @@ static void ieee80211_iface_process_status(struct ieee80211_sub_if_data *sdata,
 	}
 }
 
+static void ieee80211_ap_work(struct ieee80211_sub_if_data *sdata)
+{
+	if (!test_bit(IEEE80211_IF_AP_RECONF_LINKS, &sdata->u.ap.flags))
+		return;
+
+	cfg80211_mlo_reconf_complete_notify(sdata->dev,
+					    sdata->u.ap.reconf_links);
+	sdata->u.ap.reconf_links = 0;
+	clear_bit(IEEE80211_IF_AP_RECONF_LINKS, &sdata->u.ap.flags);
+}
+
 static void ieee80211_iface_work(struct wiphy *wiphy, struct wiphy_work *work)
 {
 	struct ieee80211_sub_if_data *sdata =
@@ -1817,6 +1828,9 @@ static void ieee80211_iface_work(struct wiphy *wiphy, struct wiphy_work *work)
 
 	/* then other type-dependent work */
 	switch (sdata->vif.type) {
+	case NL80211_IFTYPE_AP:
+		ieee80211_ap_work(sdata);
+		break;
 	case NL80211_IFTYPE_STATION:
 		ieee80211_sta_work(sdata);
 		break;
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 6e58b238a1f89323585607b05b25a954abc44ffe..fd670bfd61034a99f0537b2a529984661fb505e7 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -946,6 +946,7 @@ static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] = {
 	[NL80211_ATTR_UHR_CAPABILITY] =
 		NLA_POLICY_VALIDATE_FN(NLA_BINARY, validate_uhr_capa, 255),
 	[NL80211_ATTR_DISABLE_UHR] = { .type = NLA_FLAG },
+	[NL80211_ATTR_MLO_RECONF_ADV_OFFLOAD] = { .type = NLA_FLAG },
 };
 
 /* policy for the key attributes */
@@ -3338,6 +3339,9 @@ static int nl80211_send_wiphy(struct cfg80211_registered_device *rdev,
 				rdev->wiphy.hw_timestamp_max_peers))
 			goto nla_put_failure;
 
+		if (rdev->wiphy.flags & WIPHY_FLAG_MLO_RECONF_ADV_OFFLOAD)
+			nla_put_flag(msg, NL80211_ATTR_MLO_RECONF_ADV_OFFLOAD);
+
 		state->split_start++;
 		break;
 	case 17:
@@ -20066,6 +20070,63 @@ void cfg80211_links_removed(struct net_device *dev, u16 link_mask)
 }
 EXPORT_SYMBOL(cfg80211_links_removed);
 
+void cfg80211_mlo_reconf_complete_notify(struct net_device *dev,
+					 u16 link_bitmap)
+{
+	struct wireless_dev *wdev = dev->ieee80211_ptr;
+	struct wiphy *wiphy = wdev->wiphy;
+	struct cfg80211_registered_device *rdev = wiphy_to_rdev(wiphy);
+	struct nlattr *links;
+	struct sk_buff *msg;
+	void *hdr;
+
+	if (WARN_ON(wdev->iftype != NL80211_IFTYPE_AP))
+		return;
+
+	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
+	if (!msg)
+		return;
+
+	hdr = nl80211hdr_put(msg, 0, 0, 0,
+			     NL80211_CMD_MLO_RECONF_ADV_OFFLOAD_EVENT);
+	if (!hdr)
+		goto nla_put_failure;
+
+	if (nla_put_u32(msg, NL80211_ATTR_WIPHY, rdev->wiphy_idx) ||
+	    nla_put_u32(msg, NL80211_ATTR_IFINDEX, dev->ifindex))
+		goto nla_put_failure;
+
+	links = nla_nest_start(msg, NL80211_ATTR_MLO_LINKS);
+	if (!links)
+		goto nla_put_failure;
+
+	while (link_bitmap) {
+		int link_id = __ffs(link_bitmap);
+		struct nlattr *link;
+
+		link = nla_nest_start(msg, link_id + 1);
+		if (!link)
+			goto nla_put_failure;
+
+		if (nla_put_u8(msg, NL80211_ATTR_MLO_LINK_ID, link_id))
+			goto nla_put_failure;
+
+		nla_nest_end(msg, link);
+		link_bitmap &= ~(1 << link_id);
+	}
+
+	nla_nest_end(msg, links);
+	genlmsg_end(msg, hdr);
+
+	genlmsg_multicast_netns(&nl80211_fam, wiphy_net(&rdev->wiphy), msg, 0,
+				NL80211_MCGRP_MLME, GFP_KERNEL);
+	return;
+
+nla_put_failure:
+	nlmsg_free(msg);
+}
+EXPORT_SYMBOL_GPL(cfg80211_mlo_reconf_complete_notify);
+
 void nl80211_mlo_reconf_add_done(struct net_device *dev,
 				 struct cfg80211_mlo_reconf_done_data *data)
 {

-- 
2.53.0


