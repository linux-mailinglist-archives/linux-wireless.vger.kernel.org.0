Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D32A01F698F
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jun 2020 16:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727824AbgFKOCx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 11 Jun 2020 10:02:53 -0400
Received: from smail.rz.tu-ilmenau.de ([141.24.186.67]:46181 "EHLO
        smail.rz.tu-ilmenau.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbgFKOCx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 11 Jun 2020 10:02:53 -0400
Received: from legolas.fritz.box (unknown [87.147.49.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smail.rz.tu-ilmenau.de (Postfix) with ESMTPSA id 4F47B58005E;
        Thu, 11 Jun 2020 16:02:51 +0200 (CEST)
From:   Markus Theil <markus.theil@tu-ilmenau.de>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Markus Theil <markus.theil@tu-ilmenau.de>
Subject: [PATCH 1/2] nl80211: add connected to auth server to meshconf
Date:   Thu, 11 Jun 2020 16:02:37 +0200
Message-Id: <20200611140238.427461-1-markus.theil@tu-ilmenau.de>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Besides information about num of peerings and gate connectivity,
the mesh formation byte also contains a flag for authentication
server connectivity, that currently cannot be set in the mesh conf.
This patch adds this capability, which is necessary to implement
802.1X authentication in mesh mode.

Signed-off-by: Markus Theil <markus.theil@tu-ilmenau.de>
---
 include/net/cfg80211.h        | 1 +
 include/uapi/linux/nl80211.h  | 5 +++++
 net/mac80211/cfg.c            | 3 +++
 net/mac80211/debugfs_netdev.c | 3 +++
 net/mac80211/mesh.c           | 5 ++++-
 net/wireless/nl80211.c        | 8 +++++++-
 6 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index e150ea10daa5..6c9148ebdb83 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -1873,6 +1873,7 @@ struct mesh_config {
 	u16 dot11MeshHWMPnetDiameterTraversalTime;
 	u8 dot11MeshHWMPRootMode;
 	bool dot11MeshConnectedToMeshGate;
+	bool dot11MeshConnectedToAuthServer;
 	u16 dot11MeshHWMPRannInterval;
 	bool dot11MeshGateAnnouncementProtocol;
 	bool dot11MeshForwarding;
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 29587c95d14e..92238c63cad3 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -4241,6 +4241,10 @@ enum nl80211_mesh_power_mode {
  *	field.  If left unset then the mesh formation field will only
  *	advertise such if there is an active root mesh path.
  *
+ * @NL80211_MESHCONF_CONNECTED_TO_AS: If set to true then this mesh STA
+ *	will advertise that it is connected to a authentication server
+ *	in the mesh formation field.
+ *
  * @__NL80211_MESHCONF_ATTR_AFTER_LAST: internal use
  */
 enum nl80211_meshconf_params {
@@ -4274,6 +4278,7 @@ enum nl80211_meshconf_params {
 	NL80211_MESHCONF_AWAKE_WINDOW,
 	NL80211_MESHCONF_PLINK_TIMEOUT,
 	NL80211_MESHCONF_CONNECTED_TO_GATE,
+	NL80211_MESHCONF_CONNECTED_TO_AS,
 
 	/* keep last */
 	__NL80211_MESHCONF_ATTR_AFTER_LAST,
diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index e4e3a299af34..227d09b48f53 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -2126,6 +2126,9 @@ static int ieee80211_update_mesh_config(struct wiphy *wiphy,
 	if (_chg_mesh_attr(NL80211_MESHCONF_CONNECTED_TO_GATE, mask))
 		conf->dot11MeshConnectedToMeshGate =
 			nconf->dot11MeshConnectedToMeshGate;
+	if (_chg_mesh_attr(NL80211_MESHCONF_CONNECTED_TO_AS, mask))
+		conf->dot11MeshConnectedToAuthServer =
+			nconf->dot11MeshConnectedToAuthServer;
 	ieee80211_mbss_info_change_notify(sdata, BSS_CHANGED_BEACON);
 	return 0;
 }
diff --git a/net/mac80211/debugfs_netdev.c b/net/mac80211/debugfs_netdev.c
index d7e955127d5c..bbd1960db0c2 100644
--- a/net/mac80211/debugfs_netdev.c
+++ b/net/mac80211/debugfs_netdev.c
@@ -638,6 +638,8 @@ IEEE80211_IF_FILE(dot11MeshAwakeWindowDuration,
 		  u.mesh.mshcfg.dot11MeshAwakeWindowDuration, DEC);
 IEEE80211_IF_FILE(dot11MeshConnectedToMeshGate,
 		  u.mesh.mshcfg.dot11MeshConnectedToMeshGate, DEC);
+IEEE80211_IF_FILE(dot11MeshConnectedToAuthServer,
+		  u.mesh.mshcfg.dot11MeshConnectedToAuthServer, DEC);
 #endif
 
 #define DEBUGFS_ADD_MODE(name, mode) \
@@ -762,6 +764,7 @@ static void add_mesh_config(struct ieee80211_sub_if_data *sdata)
 	MESHPARAMS_ADD(power_mode);
 	MESHPARAMS_ADD(dot11MeshAwakeWindowDuration);
 	MESHPARAMS_ADD(dot11MeshConnectedToMeshGate);
+	MESHPARAMS_ADD(dot11MeshConnectedToAuthServer);
 #undef MESHPARAMS_ADD
 }
 #endif
diff --git a/net/mac80211/mesh.c b/net/mac80211/mesh.c
index 9ac854da7d63..326e3d72bfbb 100644
--- a/net/mac80211/mesh.c
+++ b/net/mac80211/mesh.c
@@ -260,6 +260,7 @@ int mesh_add_meshconf_ie(struct ieee80211_sub_if_data *sdata,
 	bool is_connected_to_gate = ifmsh->num_gates > 0 ||
 		ifmsh->mshcfg.dot11MeshGateAnnouncementProtocol ||
 		ifmsh->mshcfg.dot11MeshConnectedToMeshGate;
+	bool is_connected_to_as = ifmsh->mshcfg.dot11MeshConnectedToAuthServer;
 
 	if (skb_tailroom(skb) < 2 + meshconf_len)
 		return -ENOMEM;
@@ -284,7 +285,9 @@ int mesh_add_meshconf_ie(struct ieee80211_sub_if_data *sdata,
 	/* Mesh Formation Info - number of neighbors */
 	neighbors = atomic_read(&ifmsh->estab_plinks);
 	neighbors = min_t(int, neighbors, IEEE80211_MAX_MESH_PEERINGS);
-	*pos++ = (neighbors << 1) | is_connected_to_gate;
+	*pos++ = (is_connected_to_as << 7) |
+		 (neighbors << 1) |
+		 is_connected_to_gate;
 	/* Mesh capability */
 	*pos = 0x00;
 	*pos |= ifmsh->mshcfg.dot11MeshForwarding ?
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 259b25ccebef..c154bf09a8af 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -6884,7 +6884,9 @@ static int nl80211_get_mesh_config(struct sk_buff *skb,
 	    nla_put_u32(msg, NL80211_MESHCONF_PLINK_TIMEOUT,
 			cur_params.plink_timeout) ||
 	    nla_put_u8(msg, NL80211_MESHCONF_CONNECTED_TO_GATE,
-		       cur_params.dot11MeshConnectedToMeshGate))
+		       cur_params.dot11MeshConnectedToMeshGate) ||
+	    nla_put_u8(msg, NL80211_MESHCONF_CONNECTED_TO_AS,
+		       cur_params.dot11MeshConnectedToAuthServer))
 		goto nla_put_failure;
 	nla_nest_end(msg, pinfoattr);
 	genlmsg_end(msg, hdr);
@@ -6942,6 +6944,7 @@ nl80211_meshconf_params_policy[NL80211_MESHCONF_ATTR_MAX+1] = {
 	[NL80211_MESHCONF_AWAKE_WINDOW] = { .type = NLA_U16 },
 	[NL80211_MESHCONF_PLINK_TIMEOUT] = { .type = NLA_U32 },
 	[NL80211_MESHCONF_CONNECTED_TO_GATE] = NLA_POLICY_RANGE(NLA_U8, 0, 1),
+	[NL80211_MESHCONF_CONNECTED_TO_AS] = NLA_POLICY_RANGE(NLA_U8, 0, 1),
 };
 
 static const struct nla_policy
@@ -7054,6 +7057,9 @@ do {									\
 	FILL_IN_MESH_PARAM_IF_SET(tb, cfg, dot11MeshConnectedToMeshGate, mask,
 				  NL80211_MESHCONF_CONNECTED_TO_GATE,
 				  nla_get_u8);
+	FILL_IN_MESH_PARAM_IF_SET(tb, cfg, dot11MeshConnectedToAuthServer, mask,
+				  NL80211_MESHCONF_CONNECTED_TO_AS,
+				  nla_get_u8);
 	/*
 	 * Check HT operation mode based on
 	 * IEEE 802.11-2016 9.4.2.57 HT Operation element.
-- 
2.27.0

