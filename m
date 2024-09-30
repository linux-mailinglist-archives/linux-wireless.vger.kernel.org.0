Return-Path: <linux-wireless+bounces-13321-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16DCA98A087
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Sep 2024 13:28:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BB5A1C24BAE
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Sep 2024 11:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E39E1199E8D;
	Mon, 30 Sep 2024 11:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="hKCq+v+D"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A76B198A1B;
	Mon, 30 Sep 2024 11:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727695317; cv=none; b=HME3rtDWd45Dva6F2P6YU7tGpHVKhrTJAGhNcWG+MYvAyhCwJUqjUoeD3VHXDzLwGKYUh6LbveHoLPw5e3PtBRhqNRWwslz/H8PxSOLnlYAGj5MWK67L317kSZ83ZDasYNqWf7ajRkWPi73zksCCSSzXlVV7+CapTeAWsklekX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727695317; c=relaxed/simple;
	bh=wlSJzOFwNkVwK6xhV9kGwcyLBVel4D1ySXl/FG5utrs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N2qPbZB6jAjifC0FNaGQmxGl1HTiQvLznuXmP9JHkych/AfBghv4QRI6A9hUwa83lWb/pIhaYCEz5bmgbX/0jNJMwERf55llT7t1I3C/CbVd2sq9rcguAn+682netKHebTZoN4mxRAo7uvBpCJHCB3JTkMCahjyrze546RvpqL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=hKCq+v+D; arc=none smtp.client-ip=192.134.164.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TN+wnXyWailQ6qfE02yp7w4g8GHrjDQVwQg6y7qPRjc=;
  b=hKCq+v+DH0RjVxpepkxEilNpVdaZZAlhESNrzRtL8fd78LMFK/FXsSOk
   MDBBdu9Ss5UfB8xZSIdqnm2JdLiRAnr9Jb3K6shFP0CAKmikUW4Z8hZeq
   x54ZKx8iZbAbnOLRSh1NGjbiLfQ1iF1vVvUoFxNJnBRj0nYigBLLWuide
   Y=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.11,165,1725314400"; 
   d="scan'208";a="185956906"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 13:21:28 +0200
From: Julia Lawall <Julia.Lawall@inria.fr>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: kernel-janitors@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 27/35] mac80211: Reorganize kerneldoc parameter names
Date: Mon, 30 Sep 2024 13:21:13 +0200
Message-Id: <20240930112121.95324-28-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240930112121.95324-1-Julia.Lawall@inria.fr>
References: <20240930112121.95324-1-Julia.Lawall@inria.fr>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reorganize kerneldoc parameter names to match the parameter
order in the function header.

Problems identified using Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 net/mac80211/mesh_hwmp.c    |    6 +++---
 net/mac80211/mesh_pathtbl.c |   10 +++++-----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/net/mac80211/mesh_hwmp.c b/net/mac80211/mesh_hwmp.c
index 024f48db6b05..0b13a6648e08 100644
--- a/net/mac80211/mesh_hwmp.c
+++ b/net/mac80211/mesh_hwmp.c
@@ -220,12 +220,12 @@ static void prepare_frame_for_deferred_tx(struct ieee80211_sub_if_data *sdata,
 /**
  * mesh_path_error_tx - Sends a PERR mesh management frame
  *
+ * @sdata: local mesh subif
  * @ttl: allowed remaining hops
  * @target: broken destination
  * @target_sn: SN of the broken destination
  * @target_rcode: reason code for this PERR
  * @ra: node this frame is addressed to
- * @sdata: local mesh subif
  *
  * Note: This function may be called with driver locks taken that the driver
  * also acquires in the TX path.  To avoid a deadlock we don't transmit the
@@ -1137,8 +1137,8 @@ void mesh_path_start_discovery(struct ieee80211_sub_if_data *sdata)
 /**
  * mesh_nexthop_resolve - lookup next hop; conditionally start path discovery
  *
- * @skb: 802.11 frame to be sent
  * @sdata: network subif the frame will be sent through
+ * @skb: 802.11 frame to be sent
  *
  * Lookup next hop for given skb and start path discovery if no
  * forwarding information is found.
@@ -1245,8 +1245,8 @@ void mesh_path_refresh(struct ieee80211_sub_if_data *sdata,
  * this function is considered "using" the associated mpath, so preempt a path
  * refresh if this mpath expires soon.
  *
- * @skb: 802.11 frame to be sent
  * @sdata: network subif the frame will be sent through
+ * @skb: 802.11 frame to be sent
  *
  * Returns: 0 if the next hop was found. Nonzero otherwise.
  */
diff --git a/net/mac80211/mesh_pathtbl.c b/net/mac80211/mesh_pathtbl.c
index 30c0d89203af..9f9cb5af0a97 100644
--- a/net/mac80211/mesh_pathtbl.c
+++ b/net/mac80211/mesh_pathtbl.c
@@ -300,8 +300,8 @@ __mesh_path_lookup_by_idx(struct mesh_table *tbl, int idx)
 
 /**
  * mesh_path_lookup_by_idx - look up a path in the mesh path table by its index
- * @idx: index
  * @sdata: local subif, or NULL for all entries
+ * @idx: index
  *
  * Returns: pointer to the mesh path structure, or NULL if not found.
  *
@@ -315,8 +315,8 @@ mesh_path_lookup_by_idx(struct ieee80211_sub_if_data *sdata, int idx)
 
 /**
  * mpp_path_lookup_by_idx - look up a path in the proxy path table by its index
- * @idx: index
  * @sdata: local subif, or NULL for all entries
+ * @idx: index
  *
  * Returns: pointer to the proxy path structure, or NULL if not found.
  *
@@ -670,8 +670,8 @@ void mesh_fast_tx_flush_addr(struct ieee80211_sub_if_data *sdata,
 
 /**
  * mesh_path_add - allocate and add a new path to the mesh path table
- * @dst: destination address of the path (ETH_ALEN length)
  * @sdata: local subif
+ * @dst: destination address of the path (ETH_ALEN length)
  *
  * Returns: 0 on success
  *
@@ -916,8 +916,8 @@ static int table_path_del(struct mesh_table *tbl,
 /**
  * mesh_path_del - delete a mesh path from the table
  *
- * @addr: dst address (ETH_ALEN length)
  * @sdata: local subif
+ * @addr: dst address (ETH_ALEN length)
  *
  * Returns: 0 if successful
  */
@@ -996,8 +996,8 @@ int mesh_path_send_to_gates(struct mesh_path *mpath)
 /**
  * mesh_path_discard_frame - discard a frame whose path could not be resolved
  *
- * @skb: frame to discard
  * @sdata: network subif the frame was to be sent through
+ * @skb: frame to discard
  *
  * Locking: the function must me called within a rcu_read_lock region
  */


