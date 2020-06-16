Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04A421FAD28
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jun 2020 11:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbgFPJyT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 16 Jun 2020 05:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbgFPJyT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 16 Jun 2020 05:54:19 -0400
X-Greylist: delayed 5003 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 16 Jun 2020 02:54:19 PDT
Received: from mail.aperture-lab.de (mail.aperture-lab.de [IPv6:2a01:4f8:171:314c::100:a1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 032A1C08C5C2
        for <linux-wireless@vger.kernel.org>; Tue, 16 Jun 2020 02:54:18 -0700 (PDT)
From:   =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c0d3.blue; s=2018;
        t=1592301257;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=oErH0TNBeWyMm45ENk+vuH3RgkgdpFP6inOZq1vHKEM=;
        b=iNDhuEG0e9TFVKAtIhs/EJbwY1JMGzUcTu3xzzQuI8G2UgwSpw4v54hl7BEEtWWDUfWgcf
        9p1Zg4IP6be3211g+27Jsk7ORC7W3A/fY87YT5UMmW69wwFoqtvUHlaQFPSLdz4DhXwWwQ
        ADRObgg+QLh9YZSPTRGjjPF4aMd3jD99kkTzdAIGD5FMXhtgLtd0lMvQkteTn7Dh3PMsk9
        PPrfRELClEQ3lFxY/+5P407ISKnqM8CVcmFVNSa3zsjxzNML8RTIjQ7HvRoC+PHTphwhqE
        ilQ972Uv4d41CZ6WR7AF282VNc5AcJrzUnTFvHCOZJ+/qUpfXC3p6vWJ+zvpDA==
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org,
        =?UTF-8?q?Linus=20L=C3=BCssing?= <ll@simonwunderlich.de>,
        Sven Eckelmann <sven@narfation.org>,
        Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH] mac80211: mesh: add mesh_param "mesh_nolearn" to skip path discovery
Date:   Tue, 16 Jun 2020 11:53:57 +0200
Message-Id: <20200616095358.20143-1-linus.luessing@c0d3.blue>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
        auth=pass smtp.auth=linus.luessing@c0d3.blue smtp.mailfrom=linus.luessing@c0d3.blue
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Linus Lüssing <ll@simonwunderlich.de>

Currently, before being able to forward a packet between two 802.11s
nodes, both a PLINK handshake is performed upon receiving a beacon and
then later a PREQ/PREP exchange for path discovery is performed on
demand upon receiving a data frame to forward.

When running a mesh protocol on top of an 802.11s interface, like
batman-adv, we do not need the multi-hop mesh routing capabilities of
802.11s and usually set mesh_fwding=0. However, even with mesh_fwding=0
the PREQ/PREP path discovery is still performed on demand. Even though
in this scenario the next hop PREQ/PREP will determine is always the
direct 11s neighbor node.

The new mesh_nolearn parameter allows to skip the PREQ/PREP exchange in
this scenario, leading to a reduced delay, reduced packet buffering and
simplifies HWMP in general.

mesh_nolearn is still rather conservative in that if the packet destination
is not a direct 11s neighbor, it will fall back to PREQ/PREP path
discovery.

For normal, multi-hop 802.11s mesh routing it is usually not advisable
to enable mesh_nolearn as a transmission to a direct but distant neighbor
might be worse than reaching that same node via a more robust /
higher throughput etc. multi-hop path.

Cc: Sven Eckelmann <sven@narfation.org>
Cc: Simon Wunderlich <sw@simonwunderlich.de>
Signed-off-by: Linus Lüssing <ll@simonwunderlich.de>
---
 include/net/cfg80211.h        |  6 ++++++
 include/uapi/linux/nl80211.h  |  7 +++++++
 net/mac80211/cfg.c            |  2 ++
 net/mac80211/debugfs_netdev.c |  2 ++
 net/mac80211/mesh_hwmp.c      | 39 +++++++++++++++++++++++++++++++++++
 net/wireless/mesh.c           |  1 +
 net/wireless/nl80211.c        |  8 ++++++-
 net/wireless/trace.h          |  4 +++-
 8 files changed, 67 insertions(+), 2 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index fc7e8807838d..5ffb35592a23 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -1853,6 +1853,11 @@ struct bss_parameters {
  *      connected to a mesh gate in mesh formation info.  If false, the
  *      value in mesh formation is determined by the presence of root paths
  *      in the mesh path table
+ * @dot11MeshNolearn: Try to avoid multi-hop path discovery (e.g. PREQ/PREP
+ *      for HWMP) if the destination is a direct neighbor. Note that this might
+ *      not be the optimal decision as a multi-hop route might be better. So
+ *      if using this setting you will likely also want to disable
+ *      dot11MeshForwarding and use another mesh routing protocol on top.
  */
 struct mesh_config {
 	u16 dot11MeshRetryTimeout;
@@ -1884,6 +1889,7 @@ struct mesh_config {
 	enum nl80211_mesh_power_mode power_mode;
 	u16 dot11MeshAwakeWindowDuration;
 	u32 plink_timeout;
+	bool dot11MeshNolearn;
 };
 
 /**
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 4e6339ab1fce..f6560bb9644c 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -4236,6 +4236,12 @@ enum nl80211_mesh_power_mode {
  *	field.  If left unset then the mesh formation field will only
  *	advertise such if there is an active root mesh path.
  *
+ * @NL80211_MESHCONF_NOLEARN: Try to avoid multi-hop path discovery (e.g.
+ *      PREQ/PREP for HWMP) if the destination is a direct neighbor. Note that
+ *      this might not be the optimal decision as a multi-hop route might be
+ *      better. So if using this setting you will likely also want to disable
+ *      dot11MeshForwarding and use another mesh routing protocol on top.
+ *
  * @__NL80211_MESHCONF_ATTR_AFTER_LAST: internal use
  */
 enum nl80211_meshconf_params {
@@ -4269,6 +4275,7 @@ enum nl80211_meshconf_params {
 	NL80211_MESHCONF_AWAKE_WINDOW,
 	NL80211_MESHCONF_PLINK_TIMEOUT,
 	NL80211_MESHCONF_CONNECTED_TO_GATE,
+	NL80211_MESHCONF_NOLEARN,
 
 	/* keep last */
 	__NL80211_MESHCONF_ATTR_AFTER_LAST,
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 9b360544ad6f..f48e095e912a 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -2126,6 +2126,8 @@ static int ieee80211_update_mesh_config(struct wiphy *wiphy,
 	if (_chg_mesh_attr(NL80211_MESHCONF_CONNECTED_TO_GATE, mask))
 		conf->dot11MeshConnectedToMeshGate =
 			nconf->dot11MeshConnectedToMeshGate;
+	if (_chg_mesh_attr(NL80211_MESHCONF_NOLEARN, mask))
+		conf->dot11MeshNolearn = nconf->dot11MeshNolearn;
 	ieee80211_mbss_info_change_notify(sdata, BSS_CHANGED_BEACON);
 	return 0;
 }
diff --git a/net/mac80211/debugfs_netdev.c b/net/mac80211/debugfs_netdev.c
index d7e955127d5c..09eab2c3f380 100644
--- a/net/mac80211/debugfs_netdev.c
+++ b/net/mac80211/debugfs_netdev.c
@@ -638,6 +638,7 @@ IEEE80211_IF_FILE(dot11MeshAwakeWindowDuration,
 		  u.mesh.mshcfg.dot11MeshAwakeWindowDuration, DEC);
 IEEE80211_IF_FILE(dot11MeshConnectedToMeshGate,
 		  u.mesh.mshcfg.dot11MeshConnectedToMeshGate, DEC);
+IEEE80211_IF_FILE(dot11MeshNolearn, u.mesh.mshcfg.dot11MeshNolearn, DEC);
 #endif
 
 #define DEBUGFS_ADD_MODE(name, mode) \
@@ -762,6 +763,7 @@ static void add_mesh_config(struct ieee80211_sub_if_data *sdata)
 	MESHPARAMS_ADD(power_mode);
 	MESHPARAMS_ADD(dot11MeshAwakeWindowDuration);
 	MESHPARAMS_ADD(dot11MeshConnectedToMeshGate);
+	MESHPARAMS_ADD(dot11MeshNolearn);
 #undef MESHPARAMS_ADD
 }
 #endif
diff --git a/net/mac80211/mesh_hwmp.c b/net/mac80211/mesh_hwmp.c
index aa5150929996..cbf94c0b408f 100644
--- a/net/mac80211/mesh_hwmp.c
+++ b/net/mac80211/mesh_hwmp.c
@@ -1117,6 +1117,40 @@ void mesh_path_start_discovery(struct ieee80211_sub_if_data *sdata)
 	kfree(preq_node);
 }
 
+/**
+ * mesh_nexthop_resolve_nolearn - try to set next hop without path discovery
+ * @skb: 802.11 frame to be sent
+ * @sdata: network subif the frame will be sent through
+ *
+ * Check if the meshDA (addr3) of a unicast frame is a direct neighbor.
+ * And if so, set the RA (addr1) to it to transmit to this node directly,
+ * avoiding PREP/PREP path discovery.
+ *
+ * Returns: 0 if the next hop was found and -ENOENT otherwise.
+ */
+static int mesh_nexthop_resolve_nolearn(struct ieee80211_sub_if_data *sdata,
+					struct sk_buff *skb)
+{
+	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
+	struct sta_info *sta;
+
+	if (is_multicast_ether_addr(hdr->addr1))
+		return -ENOENT;
+
+	rcu_read_lock();
+	sta = sta_info_get(sdata, hdr->addr3);
+
+	if (!sta || sta->mesh->plink_state != NL80211_PLINK_ESTAB) {
+		rcu_read_unlock();
+		return -ENOENT;
+	}
+	rcu_read_unlock();
+
+	memcpy(hdr->addr1, hdr->addr3, ETH_ALEN);
+	memcpy(hdr->addr2, sdata->vif.addr, ETH_ALEN);
+	return 0;
+}
+
 /**
  * mesh_nexthop_resolve - lookup next hop; conditionally start path discovery
  *
@@ -1132,6 +1166,7 @@ void mesh_path_start_discovery(struct ieee80211_sub_if_data *sdata)
 int mesh_nexthop_resolve(struct ieee80211_sub_if_data *sdata,
 			 struct sk_buff *skb)
 {
+	struct ieee80211_if_mesh *ifmsh = &sdata->u.mesh;
 	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *) skb->data;
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
 	struct mesh_path *mpath;
@@ -1146,6 +1181,10 @@ int mesh_nexthop_resolve(struct ieee80211_sub_if_data *sdata,
 	if (info->control.flags & IEEE80211_TX_CTRL_SKIP_MPATH_LOOKUP)
 		return 0;
 
+	if (ifmsh->mshcfg.dot11MeshNolearn &&
+	    !mesh_nexthop_resolve_nolearn(sdata, skb))
+		return 0;
+
 	if (!mesh_nexthop_lookup(sdata, skb))
 		return 0;
 
diff --git a/net/wireless/mesh.c b/net/wireless/mesh.c
index eac5aa1419fc..e4e363138279 100644
--- a/net/wireless/mesh.c
+++ b/net/wireless/mesh.c
@@ -78,6 +78,7 @@ const struct mesh_config default_mesh_config = {
 	.power_mode = NL80211_MESH_POWER_ACTIVE,
 	.dot11MeshAwakeWindowDuration = MESH_DEFAULT_AWAKE_WINDOW,
 	.plink_timeout = MESH_DEFAULT_PLINK_TIMEOUT,
+	.dot11MeshNolearn = false,
 };
 
 const struct mesh_setup default_mesh_setup = {
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 263ae395ad44..b0b7f110064f 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -6884,7 +6884,9 @@ static int nl80211_get_mesh_config(struct sk_buff *skb,
 	    nla_put_u32(msg, NL80211_MESHCONF_PLINK_TIMEOUT,
 			cur_params.plink_timeout) ||
 	    nla_put_u8(msg, NL80211_MESHCONF_CONNECTED_TO_GATE,
-		       cur_params.dot11MeshConnectedToMeshGate))
+		       cur_params.dot11MeshConnectedToMeshGate) ||
+	    nla_put_u8(msg, NL80211_MESHCONF_NOLEARN,
+		       cur_params.dot11MeshNolearn))
 		goto nla_put_failure;
 	nla_nest_end(msg, pinfoattr);
 	genlmsg_end(msg, hdr);
@@ -6942,6 +6944,7 @@ nl80211_meshconf_params_policy[NL80211_MESHCONF_ATTR_MAX+1] = {
 	[NL80211_MESHCONF_AWAKE_WINDOW] = { .type = NLA_U16 },
 	[NL80211_MESHCONF_PLINK_TIMEOUT] = { .type = NLA_U32 },
 	[NL80211_MESHCONF_CONNECTED_TO_GATE] = NLA_POLICY_RANGE(NLA_U8, 0, 1),
+	[NL80211_MESHCONF_NOLEARN] = { .type = NLA_U8 },
 };
 
 static const struct nla_policy
@@ -7093,6 +7096,9 @@ do {									\
 				  NL80211_MESHCONF_AWAKE_WINDOW, nla_get_u16);
 	FILL_IN_MESH_PARAM_IF_SET(tb, cfg, plink_timeout, mask,
 				  NL80211_MESHCONF_PLINK_TIMEOUT, nla_get_u32);
+	FILL_IN_MESH_PARAM_IF_SET(tb, cfg, dot11MeshNolearn, 0, 1,
+				  mask, NL80211_MESHCONF_NOLEARN,
+				  nl80211_check_bool);
 	if (mask_out)
 		*mask_out = mask;
 
diff --git a/net/wireless/trace.h b/net/wireless/trace.h
index b23cab016521..6e218a0acd4e 100644
--- a/net/wireless/trace.h
+++ b/net/wireless/trace.h
@@ -68,7 +68,8 @@
 		       __field(u16, ht_opmode)				   \
 		       __field(u32, dot11MeshHWMPactivePathToRootTimeout)  \
 		       __field(u16, dot11MeshHWMProotInterval)		   \
-		       __field(u16, dot11MeshHWMPconfirmationInterval)
+		       __field(u16, dot11MeshHWMPconfirmationInterval)	   \
+		       __field(bool, dot11MeshNolearn)
 #define MESH_CFG_ASSIGN							      \
 	do {								      \
 		__entry->dot11MeshRetryTimeout = conf->dot11MeshRetryTimeout; \
@@ -109,6 +110,7 @@
 				conf->dot11MeshHWMProotInterval;	      \
 		__entry->dot11MeshHWMPconfirmationInterval =		      \
 				conf->dot11MeshHWMPconfirmationInterval;      \
+		__entry->dot11MeshNolearn = conf->dot11MeshNolearn;	      \
 	} while (0)
 
 #define CHAN_ENTRY __field(enum nl80211_band, band) \
-- 
2.27.0

