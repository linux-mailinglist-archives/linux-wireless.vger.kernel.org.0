Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 273874115D8
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Sep 2021 15:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236287AbhITNdF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Sep 2021 09:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235040AbhITNc4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Sep 2021 09:32:56 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC5C6C061766
        for <linux-wireless@vger.kernel.org>; Mon, 20 Sep 2021 06:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=lTOmMbESn9xSZLahzCi3JtrmsuPy1VcqRAReTikd31U=;
        t=1632144689; x=1633354289; b=qSG77BDuRcSl5n4SfytlRCynMIUzTi6GZHRj94ltwv3dMQl
        yn9jpBWAPwK7fzW0NkqAczMf9WeF6MUpRA8Vmd9foRIe6/tfOHql3tF8vPPx7aIBQsJoWa72Yb7c5
        oeVpoQI9xdsILKwY7+tv+w3YIW79w7lHAkitTLMYQQQUWPG9oTgkGzpQerMzCrZSkUyZQDO4eMjCs
        x79OFdEnQRvR9A+DtXK1QgYEaUfpcbD7KFyJQdtObs8UvJ5SxqvdWUn2iHCKvRJbw63z0BdlasxTU
        WeTwQ8YGSE+7QfIcs6Y3A3ZHVlY7y8a8iH+3wCdC6vofNocAz1tKWnra/dVvptUQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.95-RC2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mSJOI-009S8n-Nx;
        Mon, 20 Sep 2021 15:31:27 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 3/6] mac80211: mesh: clean up rx_bcn_presp API
Date:   Mon, 20 Sep 2021 15:31:20 +0200
Message-Id: <20210920153122.ffe0b4ba8fcc.I1824b773a0fbae4453e1433c184678ca14e8df45@changeid>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210920153122.e733e4d412bf.Ib6a2ff9e9cc9bc6fca50fce631ec1ce725cc926b@changeid>
References: <20210920153122.e733e4d412bf.Ib6a2ff9e9cc9bc6fca50fce631ec1ce725cc926b@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

We currently pass the entire elements to the rx_bcn_presp()
method, but only need mesh_config. Additionally, we use the
length of the elements to calculate back the entire frame's
length, but that's confusing - just pass the length of the
frame instead.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/ieee80211_i.h |  7 +++----
 net/mac80211/mesh.c        |  4 ++--
 net/mac80211/mesh_sync.c   | 25 +++++++++++--------------
 3 files changed, 16 insertions(+), 20 deletions(-)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 159af6c3ffb0..d74031bb4ae6 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -631,10 +631,9 @@ struct ieee80211_if_ocb {
  */
 struct ieee802_11_elems;
 struct ieee80211_mesh_sync_ops {
-	void (*rx_bcn_presp)(struct ieee80211_sub_if_data *sdata,
-			     u16 stype,
-			     struct ieee80211_mgmt *mgmt,
-			     struct ieee802_11_elems *elems,
+	void (*rx_bcn_presp)(struct ieee80211_sub_if_data *sdata, u16 stype,
+			     struct ieee80211_mgmt *mgmt, unsigned int len,
+			     const struct ieee80211_meshconf_ie *mesh_cfg,
 			     struct ieee80211_rx_status *rx_status);
 
 	/* should be called with beacon_data under RCU read lock */
diff --git a/net/mac80211/mesh.c b/net/mac80211/mesh.c
index 97095b7c9c64..65e9335b3614 100644
--- a/net/mac80211/mesh.c
+++ b/net/mac80211/mesh.c
@@ -1353,8 +1353,8 @@ static void ieee80211_mesh_rx_bcn_presp(struct ieee80211_sub_if_data *sdata,
 	}
 
 	if (ifmsh->sync_ops)
-		ifmsh->sync_ops->rx_bcn_presp(sdata,
-			stype, mgmt, &elems, rx_status);
+		ifmsh->sync_ops->rx_bcn_presp(sdata, stype, mgmt, len,
+					      elems.mesh_config, rx_status);
 }
 
 int ieee80211_mesh_finish_csa(struct ieee80211_sub_if_data *sdata)
diff --git a/net/mac80211/mesh_sync.c b/net/mac80211/mesh_sync.c
index fde93de2b80a..8a0f481e5af6 100644
--- a/net/mac80211/mesh_sync.c
+++ b/net/mac80211/mesh_sync.c
@@ -35,12 +35,12 @@ struct sync_method {
 /**
  * mesh_peer_tbtt_adjusting - check if an mp is currently adjusting its TBTT
  *
- * @ie: information elements of a management frame from the mesh peer
+ * @cfg: mesh config element from the mesh peer (or %NULL)
  */
-static bool mesh_peer_tbtt_adjusting(struct ieee802_11_elems *ie)
+static bool mesh_peer_tbtt_adjusting(const struct ieee80211_meshconf_ie *cfg)
 {
-	return (ie->mesh_config->meshconf_cap &
-			IEEE80211_MESHCONF_CAPAB_TBTT_ADJUSTING) != 0;
+	return cfg &&
+	       (cfg->meshconf_cap & IEEE80211_MESHCONF_CAPAB_TBTT_ADJUSTING);
 }
 
 void mesh_sync_adjust_tsf(struct ieee80211_sub_if_data *sdata)
@@ -76,11 +76,11 @@ void mesh_sync_adjust_tsf(struct ieee80211_sub_if_data *sdata)
 	}
 }
 
-static void mesh_sync_offset_rx_bcn_presp(struct ieee80211_sub_if_data *sdata,
-				   u16 stype,
-				   struct ieee80211_mgmt *mgmt,
-				   struct ieee802_11_elems *elems,
-				   struct ieee80211_rx_status *rx_status)
+static void
+mesh_sync_offset_rx_bcn_presp(struct ieee80211_sub_if_data *sdata, u16 stype,
+			      struct ieee80211_mgmt *mgmt, unsigned int len,
+			      const struct ieee80211_meshconf_ie *mesh_cfg,
+			      struct ieee80211_rx_status *rx_status)
 {
 	struct ieee80211_if_mesh *ifmsh = &sdata->u.mesh;
 	struct ieee80211_local *local = sdata->local;
@@ -101,10 +101,7 @@ static void mesh_sync_offset_rx_bcn_presp(struct ieee80211_sub_if_data *sdata,
 	 */
 	if (ieee80211_have_rx_timestamp(rx_status))
 		t_r = ieee80211_calculate_rx_timestamp(local, rx_status,
-						       24 + 12 +
-						       elems->total_len +
-						       FCS_LEN,
-						       24);
+						       len + FCS_LEN, 24);
 	else
 		t_r = drv_get_tsf(local, sdata);
 
@@ -119,7 +116,7 @@ static void mesh_sync_offset_rx_bcn_presp(struct ieee80211_sub_if_data *sdata,
 	 * dot11MeshNbrOffsetMaxNeighbor non-peer non-MBSS neighbors
 	 */
 
-	if (elems->mesh_config && mesh_peer_tbtt_adjusting(elems)) {
+	if (mesh_peer_tbtt_adjusting(mesh_cfg)) {
 		msync_dbg(sdata, "STA %pM : is adjusting TBTT\n",
 			  sta->sta.addr);
 		goto no_sync;
-- 
2.31.1

