Return-Path: <linux-wireless+bounces-8870-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 67EBF90528E
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2024 14:34:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBBCFB246A1
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2024 12:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58991170844;
	Wed, 12 Jun 2024 12:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="FmHvq7+F"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B214516FF55
	for <linux-wireless@vger.kernel.org>; Wed, 12 Jun 2024 12:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718195666; cv=none; b=oN/iKC8btHVAWVgfM2tvKbZiY1ey5PTfFTcVm+Qb88xUpk2DZ1wsD1c6+0uT1Hx5JvVeQ1QXVReE4HAOX57CFansYoeRZ0Xb4RTceEEszApBLC6kJjTaaOpJoEM3hAB8ILcn0SLJFwfG8NOyv1YEDbrpQHCisQdyhFdtTzGzw10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718195666; c=relaxed/simple;
	bh=6dwiF/4fKHuKWIchdzP+Aj20DiycieTtoFvyfTRkNC0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gH0+W/vSzIjMUyVNeSdNipfiPc1mRbZWg9dihwyYW1rxqJ+9Q5vEfj6zxvicSQR5UFZtjMhM2U6SbnBGM7FkS/scNNDbjgo7HPrCg2wd+6Lj5Zp8rS6x8PUGOnpWOHWVnZnELydS6sS7qJtuQ8ugAFsk+qLAWjGSwM/ZYJBO6WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=FmHvq7+F; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=RYGCb/7zJ4ItXo8KrsJnrmHHn4RYRPJ2yerAA2l7GJQ=;
	t=1718195664; x=1719405264; b=FmHvq7+FYjVPCFWymD8aziEITyij2IsWIHXqN+wTbqHVpHy
	U255bRIu3iW/9w12/rSmIn63jHm+8cDe+nowgkVDx3LUfLQkHovkxxh4L8Tnk3mif9zeiGEPpJxuf
	3SMFjGBBK7gC8QyH/aWjfl3NPWyv13IuNO+9vlDLu0XDua6SFGB/0gDEASRoTW42PW9nVBC6Mb8bG
	Vt0z37srdtVeEI3kKH94zRD+0iYfvS6gt9+4A01QPrAg7uyHHJYJOg5M0Ad51nIf5Xi6yWApp53Ek
	opbD0bc7l2NejW5c3EVvZJerVX8Ind7wDbjlhtvf9mEj6RrKfQpzYEfXviQi6o+Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sHNBG-0000000AGkC-0xHs;
	Wed, 12 Jun 2024 14:34:22 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH 2/4] wifi: mac80211: optionally pass chandef to ieee80211_sta_cur_vht_bw()
Date: Wed, 12 Jun 2024 14:32:04 +0200
Message-ID: <20240612143418.f70e05d9f306.Ifa0ce267de4f0ef3c21d063fb0cbf50e84d7d6ff@changeid>
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

We'll need this as well for channel switching cases, so
add the ability now to pass the chandef to calculate for.

Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/ieee80211_i.h |  8 +++++++-
 net/mac80211/vht.c         | 25 ++++++++++++++++---------
 2 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index e436ccb1ee3a..8318a729d90f 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2163,7 +2163,13 @@ ieee80211_sta_cap_rx_bw(struct link_sta_info *link_sta)
 	return _ieee80211_sta_cap_rx_bw(link_sta, NULL);
 }
 enum ieee80211_sta_rx_bandwidth
-ieee80211_sta_cur_vht_bw(struct link_sta_info *link_sta);
+_ieee80211_sta_cur_vht_bw(struct link_sta_info *link_sta,
+			  struct cfg80211_chan_def *chandef);
+static inline enum ieee80211_sta_rx_bandwidth
+ieee80211_sta_cur_vht_bw(struct link_sta_info *link_sta)
+{
+	return _ieee80211_sta_cur_vht_bw(link_sta, NULL);
+}
 void ieee80211_sta_init_nss(struct link_sta_info *link_sta);
 enum ieee80211_sta_rx_bandwidth
 ieee80211_chan_width_to_rx_bw(enum nl80211_chan_width width);
diff --git a/net/mac80211/vht.c b/net/mac80211/vht.c
index c280945fc9d6..bf6ef45af757 100644
--- a/net/mac80211/vht.c
+++ b/net/mac80211/vht.c
@@ -503,22 +503,29 @@ ieee80211_chan_width_to_rx_bw(enum nl80211_chan_width width)
 
 /* FIXME: rename/move - this deals with everything not just VHT */
 enum ieee80211_sta_rx_bandwidth
-ieee80211_sta_cur_vht_bw(struct link_sta_info *link_sta)
+_ieee80211_sta_cur_vht_bw(struct link_sta_info *link_sta,
+			  struct cfg80211_chan_def *chandef)
 {
 	struct sta_info *sta = link_sta->sta;
-	struct ieee80211_bss_conf *link_conf;
 	enum nl80211_chan_width bss_width;
 	enum ieee80211_sta_rx_bandwidth bw;
 
-	rcu_read_lock();
-	link_conf = rcu_dereference(sta->sdata->vif.link_conf[link_sta->link_id]);
-	if (WARN_ON(!link_conf))
-		bss_width = NL80211_CHAN_WIDTH_20_NOHT;
-	else
+	if (chandef) {
+		bss_width = chandef->width;
+	} else {
+		struct ieee80211_bss_conf *link_conf;
+
+		rcu_read_lock();
+		link_conf = rcu_dereference(sta->sdata->vif.link_conf[link_sta->link_id]);
+		if (WARN_ON_ONCE(!link_conf)) {
+			rcu_read_unlock();
+			return IEEE80211_STA_RX_BW_20;
+		}
 		bss_width = link_conf->chanreq.oper.width;
-	rcu_read_unlock();
+		rcu_read_unlock();
+	}
 
-	bw = ieee80211_sta_cap_rx_bw(link_sta);
+	bw = _ieee80211_sta_cap_rx_bw(link_sta, chandef);
 	bw = min(bw, link_sta->cur_max_bandwidth);
 
 	/* Don't consider AP's bandwidth for TDLS peers, section 11.23.1 of
-- 
2.45.2


