Return-Path: <linux-wireless+bounces-4163-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3EF686AA97
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Feb 2024 09:58:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 546E41F21FC7
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Feb 2024 08:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55B343613D;
	Wed, 28 Feb 2024 08:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="LQ01Ctq5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D61339BD
	for <linux-wireless@vger.kernel.org>; Wed, 28 Feb 2024 08:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709110651; cv=none; b=f0m5tCQlaB7jA0NSmt8Z8wUS0yVfv2bk4hYMUXumWz47VVluWMknhkdxnSgUGpOvRjIQbnnwsV1iJEiuv7h/MzjYji4LkzHNioyOP43dc8uyTLGPZE+R2l1SXGklxp7UyDdroGxI3RXL6P/0+WiPNkjN9eB0n7fh5V5Xf/0XcFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709110651; c=relaxed/simple;
	bh=y8t2zj9P4gXoK9K/Ru3P78cTK5H2vKIMZVaZ9MxzqcU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gcgrvLA3D8SfRCbBbMIBaghgTf1VsGSnio3xNFxMcA1dybeIzuVqqxXQPcVjHL0Q5NyVY2nM79P6f84Wfok/v2jIaGzuMTiKFQdlJgfJbtp8qNUEhMSLZ663NCB/603ZRTyPafToYxZ9HnvMRIl4Rs+M8fhPTHuJJriLKwI0j78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=LQ01Ctq5; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=9aAUzDdHoPlA6zNv3RgK6D66msgBn41r1t5Sk5GvZBE=;
	t=1709110649; x=1710320249; b=LQ01Ctq5s+womSxlR4LuzhfdYh8oRihJDOeg6pxqTSLVpVQ
	ht9D4o41wew71kIA3p3jL2TwzHh/ntMHwk0XVCT9R/ylduT5DEWq2L64zsAABG2sMgwljPgANWmkO
	PM9mIM71wY/fLFNfVBpBWyVIPgCtZOm1QIIeJn/nAo0othC+WBAfhc9W6WL03Pnoi/jmkfmrgdLm4
	KiWYKUELuaNRZ47FJkItvLQOrWeApt+2oPiBt02F926rKiKrvx0Qz+BzXv8dxNiSl6mvhM3cusJZQ
	WbIGYBQTXFMvXP8Tf0pnCC20E6zbwMtksgZETcFpl9iALRlHFuXA/gJJqiXE9w6A==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rfFkj-0000000C0hJ-3f5U;
	Wed, 28 Feb 2024 09:57:26 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 7/8] wifi: mac80211: remove TDLS peers only on affected link
Date: Wed, 28 Feb 2024 09:55:47 +0100
Message-ID: <20240228095719.00d1d793f5b8.Ia9971316c6b3922dd371d64ac2198f91ed5ad9d2@changeid>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240228085718.21171-10-johannes@sipsolutions.net>
References: <20240228085718.21171-10-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

If a link does CSA, or if it changes SMPS mode, we need to
drop the TDLS peers, but we really should drop them only on
the affected link. Fix that.

Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/cfg.c         | 2 +-
 net/mac80211/ieee80211_i.h | 2 +-
 net/mac80211/mlme.c        | 7 ++++---
 net/mac80211/tdls.c        | 6 +++++-
 4 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
index 692f5c9f9678..54c58530cc6d 100644
--- a/net/mac80211/cfg.c
+++ b/net/mac80211/cfg.c
@@ -3208,7 +3208,7 @@ int __ieee80211_request_smps_mgd(struct ieee80211_sub_if_data *sdata,
 	if (err)
 		link->u.mgd.req_smps = old_req;
 	else if (smps_mode != IEEE80211_SMPS_OFF && tdls_peer_found)
-		ieee80211_teardown_tdls_peers(sdata);
+		ieee80211_teardown_tdls_peers(link);
 
 	return err;
 }
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 2f1e24a5d030..c97e237608c6 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2611,7 +2611,7 @@ int ieee80211_tdls_channel_switch(struct wiphy *wiphy, struct net_device *dev,
 void ieee80211_tdls_cancel_channel_switch(struct wiphy *wiphy,
 					  struct net_device *dev,
 					  const u8 *addr);
-void ieee80211_teardown_tdls_peers(struct ieee80211_sub_if_data *sdata);
+void ieee80211_teardown_tdls_peers(struct ieee80211_link_data *link);
 void ieee80211_tdls_handle_disconnect(struct ieee80211_sub_if_data *sdata,
 				      const u8 *peer, u16 reason);
 void
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 563b001496ce..a95468c98818 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -2115,12 +2115,13 @@ ieee80211_sta_process_chanswitch(struct ieee80211_link_data *link,
 	}
 
 	/*
-	 * Drop all TDLS peers - either we disconnect or move to a different
-	 * channel from this point on. There's no telling what our peer will do.
+	 * Drop all TDLS peers on the affected link - either we disconnect or
+	 * move to a different channel from this point on. There's no telling
+	 * what our peer will do.
 	 * The TDLS WIDER_BW scenario is also problematic, as peers might now
 	 * have an incompatible wider chandef.
 	 */
-	ieee80211_teardown_tdls_peers(sdata);
+	ieee80211_teardown_tdls_peers(link);
 
 	conf = rcu_dereference_protected(link->conf->chanctx_conf,
 					 lockdep_is_held(&local->hw.wiphy->mtx));
diff --git a/net/mac80211/tdls.c b/net/mac80211/tdls.c
index 42d9c06cbb84..f07b40916485 100644
--- a/net/mac80211/tdls.c
+++ b/net/mac80211/tdls.c
@@ -2028,8 +2028,9 @@ ieee80211_process_tdls_channel_switch(struct ieee80211_sub_if_data *sdata,
 	}
 }
 
-void ieee80211_teardown_tdls_peers(struct ieee80211_sub_if_data *sdata)
+void ieee80211_teardown_tdls_peers(struct ieee80211_link_data *link)
 {
+	struct ieee80211_sub_if_data *sdata = link->sdata;
 	struct sta_info *sta;
 	u16 reason = WLAN_REASON_TDLS_TEARDOWN_UNSPECIFIED;
 
@@ -2039,6 +2040,9 @@ void ieee80211_teardown_tdls_peers(struct ieee80211_sub_if_data *sdata)
 		    !test_sta_flag(sta, WLAN_STA_AUTHORIZED))
 			continue;
 
+		if (sta->deflink.link_id != link->link_id)
+			continue;
+
 		ieee80211_tdls_oper_request(&sdata->vif, sta->sta.addr,
 					    NL80211_TDLS_TEARDOWN, reason,
 					    GFP_ATOMIC);
-- 
2.43.2


