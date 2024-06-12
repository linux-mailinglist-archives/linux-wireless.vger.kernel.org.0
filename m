Return-Path: <linux-wireless+bounces-8869-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F92C90528D
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2024 14:34:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B807B21703
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2024 12:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2DD316D4F6;
	Wed, 12 Jun 2024 12:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="vd1XWjp1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DFE816F0F3
	for <linux-wireless@vger.kernel.org>; Wed, 12 Jun 2024 12:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718195665; cv=none; b=AElVCELsJSzzrIpXlP8PbHVZuQzPcvC5znLil2XHNWIWqIeVgMuq7o5gVKoBzcHk3vj9eRavge2b3CgeGXXKPofiPQTYfNu/OKshUVvlGQmug0td0rKPfeJvyqKg/Wq0lz8OLpIMaHwz/NeO3x/If/TQniNRvFE+HYNgm0xEi34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718195665; c=relaxed/simple;
	bh=EDp7uGJRSm1GeTsVcCOYz7JF7KqL/Euyu4h7rq+54Tc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mkQ1J3FZwIO8r9HkbnKTcR3MlWykqIw2emKOfClsieYr2tipvX+eYVJTS2Hi7iy6yA6eameXWiVdJiwYNZEm2hz5Cn7Jd1BUPWkE/StyfbZEPhHarUfTsClu//weEtPovLdIJ9zEWorZl75Di3LWT0vOSalgzPKvFeTPnRH7yUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=vd1XWjp1; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=x9o0Qb5aiUOeUHccaEuviJ5t9rKzcFLjOj+9CsrZNZY=;
	t=1718195664; x=1719405264; b=vd1XWjp1FTMSPk9dmCvODOGq5kqTGykHod6pcC24qQnvooX
	DRde+52zrnbBAWaeWzmcuBMu7jBuqgxnZlPPYeB08u1DjGiG2oSA5M9PfuYeb+eOf92o7Zz9IYEf9
	N0iSwaJd62tK8bUJPDNbPjCWp0E2+W3OWfJTk/3WXzHG4LYdIClEdCHeq6MNhiej0Vr4ViRZJeLHZ
	jMWRqCFkyZF5Cvt6I5GD3ci78/EAzIgwM3pQIGHDJU9uJU4sD6N3lb0Tkq/HvzVdzuoX3PL6Qfs7/
	cylJSshfVnUWjkata5xWsIHa4bEzdjlKWbhe/opgPKdN0G7fnHgFdbu3153hjJrg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sHNBF-0000000AGkC-1b3F;
	Wed, 12 Jun 2024 14:34:21 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH 1/4] wifi: mac80211: optionally pass chandef to ieee80211_sta_cap_rx_bw()
Date: Wed, 12 Jun 2024 14:32:03 +0200
Message-ID: <20240612143418.772313f08b6a.If9708249e5870671e745d4c2b02e03b25092bea3@changeid>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240612123418.37295-6-johannes@sipsolutions.net>
References: <20240612123418.37295-6-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

We'll need this function to take a new chandef in
(some) channel switching cases, so prepare for that
by allowing that to be passed and using it if so.
Clean up the code a little bit while at it.

Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/ieee80211_i.h |  8 ++++++-
 net/mac80211/vht.c         | 48 +++++++++++++++++++-------------------
 2 files changed, 31 insertions(+), 25 deletions(-)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 3e735c9436d3..e436ccb1ee3a 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2155,7 +2155,13 @@ ieee80211_vht_cap_ie_to_sta_vht_cap(struct ieee80211_sub_if_data *sdata,
 				    const struct ieee80211_vht_cap *vht_cap_ie2,
 				    struct link_sta_info *link_sta);
 enum ieee80211_sta_rx_bandwidth
-ieee80211_sta_cap_rx_bw(struct link_sta_info *link_sta);
+_ieee80211_sta_cap_rx_bw(struct link_sta_info *link_sta,
+			 struct cfg80211_chan_def *chandef);
+static inline enum ieee80211_sta_rx_bandwidth
+ieee80211_sta_cap_rx_bw(struct link_sta_info *link_sta)
+{
+	return _ieee80211_sta_cap_rx_bw(link_sta, NULL);
+}
 enum ieee80211_sta_rx_bandwidth
 ieee80211_sta_cur_vht_bw(struct link_sta_info *link_sta);
 void ieee80211_sta_init_nss(struct link_sta_info *link_sta);
diff --git a/net/mac80211/vht.c b/net/mac80211/vht.c
index 642891cafbaf..c280945fc9d6 100644
--- a/net/mac80211/vht.c
+++ b/net/mac80211/vht.c
@@ -351,7 +351,8 @@ ieee80211_vht_cap_ie_to_sta_vht_cap(struct ieee80211_sub_if_data *sdata,
 
 /* FIXME: move this to some better location - parses HE/EHT now */
 enum ieee80211_sta_rx_bandwidth
-ieee80211_sta_cap_rx_bw(struct link_sta_info *link_sta)
+_ieee80211_sta_cap_rx_bw(struct link_sta_info *link_sta,
+			 struct cfg80211_chan_def *chandef)
 {
 	unsigned int link_id = link_sta->link_id;
 	struct ieee80211_sub_if_data *sdata = link_sta->sta->sdata;
@@ -361,44 +362,43 @@ ieee80211_sta_cap_rx_bw(struct link_sta_info *link_sta)
 	u32 cap_width;
 
 	if (he_cap->has_he) {
-		struct ieee80211_bss_conf *link_conf;
-		enum ieee80211_sta_rx_bandwidth ret;
+		enum nl80211_band band;
 		u8 info;
 
-		rcu_read_lock();
-		link_conf = rcu_dereference(sdata->vif.link_conf[link_id]);
+		if (chandef) {
+			band = chandef->chan->band;
+		} else {
+			struct ieee80211_bss_conf *link_conf;
 
-		if (eht_cap->has_eht &&
-		    link_conf->chanreq.oper.chan->band == NL80211_BAND_6GHZ) {
+			rcu_read_lock();
+			link_conf = rcu_dereference(sdata->vif.link_conf[link_id]);
+			band = link_conf->chanreq.oper.chan->band;
+			rcu_read_unlock();
+		}
+
+		if (eht_cap->has_eht && band == NL80211_BAND_6GHZ) {
 			info = eht_cap->eht_cap_elem.phy_cap_info[0];
 
-			if (info & IEEE80211_EHT_PHY_CAP0_320MHZ_IN_6GHZ) {
-				ret = IEEE80211_STA_RX_BW_320;
-				goto out;
-			}
+			if (info & IEEE80211_EHT_PHY_CAP0_320MHZ_IN_6GHZ)
+				return IEEE80211_STA_RX_BW_320;
 		}
 
 		info = he_cap->he_cap_elem.phy_cap_info[0];
 
-		if (link_conf->chanreq.oper.chan->band == NL80211_BAND_2GHZ) {
+		if (band == NL80211_BAND_2GHZ) {
 			if (info & IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_IN_2G)
-				ret = IEEE80211_STA_RX_BW_40;
-			else
-				ret = IEEE80211_STA_RX_BW_20;
-			goto out;
+				return IEEE80211_STA_RX_BW_40;
+			return IEEE80211_STA_RX_BW_20;
 		}
 
 		if (info & IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_160MHZ_IN_5G ||
 		    info & IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_80PLUS80_MHZ_IN_5G)
-			ret = IEEE80211_STA_RX_BW_160;
-		else if (info & IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_80MHZ_IN_5G)
-			ret = IEEE80211_STA_RX_BW_80;
-		else
-			ret = IEEE80211_STA_RX_BW_20;
-out:
-		rcu_read_unlock();
+			return IEEE80211_STA_RX_BW_160;
 
-		return ret;
+		if (info & IEEE80211_HE_PHY_CAP0_CHANNEL_WIDTH_SET_40MHZ_80MHZ_IN_5G)
+			return IEEE80211_STA_RX_BW_80;
+
+		return IEEE80211_STA_RX_BW_20;
 	}
 
 	if (!vht_cap->vht_supported)
-- 
2.45.2


