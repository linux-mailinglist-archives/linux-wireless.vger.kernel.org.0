Return-Path: <linux-wireless+bounces-2705-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CC2E841301
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 20:05:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCEE21F23658
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 19:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD1F731755;
	Mon, 29 Jan 2024 19:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="e3F/sQZL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D99014290
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jan 2024 19:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706555103; cv=none; b=T1E5r5Pp63XMcplTLaqmHCJb/zmcwHT1S+oc1J8tR5HIgbKIIVDLdGELdZKtXL1kjvhtmEOLLv4SFKJPhJZFXk4FvGuKMDopFuNUcsEH/7EqcBhRXIdklwAnlQKtPO/Gz5YCZNlDXAgjj2902wOZ6HYt1vvvHLHaJe9syu4SVco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706555103; c=relaxed/simple;
	bh=aUJw8lHt9wBagvcqvxcAGHAMJIw1Gqkck/Y1F7xckTI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Auqrs7R/dCAizyyEPNgJRh1nUY+E4YUdvj8r5pQOf03xsQoPEwHHoXdK64Q4QAqc2/JvNm0ByQRJRRjsJUFLuZFZaCfhrbqEFgAWQaRuuBjJbb0hZX37qDOKx12rwXVOoUH/Q6Qz05K1nRS2yjp9HjKHa8tWhTQIL7skul5nRGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=e3F/sQZL; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=SpyDBUKuC20VCKu+8OT+E+sPIsgGAsqVi4QD8tGGaoM=;
	t=1706555102; x=1707764702; b=e3F/sQZLSBtqL64imgJJZ9FpinCBNkpuac++UPzo7N+PcWW
	RDpNJfepxeuoQOksXJP0t2n1RVy/C7JTUssnDxY/NExDfG/wc2bM55wXkT0KueLy/zIOue3Kn0gfB
	Xbr9RKfJuY1BJlymlep9jrSZnAB41+efiLOFv4s+8+bN0TluNeXzh7wGt8/Q1qUFgs0NkBO+sS8L2
	RrX66a6OgAcwD2qqxlLo+Yciy76RPh9rms+IbHguvivafbkpUCuVYu5/dZHRaGWNXc8SnC3G6sFSw
	rDi227elvyokeWhlSicLjI0LgRnH9Oxm/tMOaEvVaBBWpKI3roxY0QsTGKz27sFw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rUWwF-0000000506V-2c7G;
	Mon, 29 Jan 2024 20:04:59 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 2/2] wifi: mac80211: implement MLO multicast deduplication
Date: Mon, 29 Jan 2024 20:04:57 +0100
Message-ID: <20240129200456.693b77d14b44.I491846f2bea0058c14eab6422962c10bfae9b675@changeid>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129200456.f0ff49c80006.I850d2785ab1640e56e262d3ad7343b87f6962552@changeid>
References: <20240129200456.f0ff49c80006.I850d2785ab1640e56e262d3ad7343b87f6962552@changeid>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

If the vif is an MLD then it may receive multicast from
different links, and should drop those frames according
to the SN. Implement that.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 include/linux/ieee80211.h  |  5 +++++
 net/mac80211/ieee80211_i.h |  4 +++-
 net/mac80211/mlme.c        |  3 +++
 net/mac80211/rx.c          | 22 ++++++++++++++++++++--
 4 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/include/linux/ieee80211.h b/include/linux/ieee80211.h
index b9367d5f04c4..e9078143b822 100644
--- a/include/linux/ieee80211.h
+++ b/include/linux/ieee80211.h
@@ -191,6 +191,11 @@ static inline bool ieee80211_sn_less(u16 sn1, u16 sn2)
 	return ((sn1 - sn2) & IEEE80211_SN_MASK) > (IEEE80211_SN_MODULO >> 1);
 }
 
+static inline bool ieee80211_sn_less_eq(u16 sn1, u16 sn2)
+{
+	return ((sn2 - sn1) & IEEE80211_SN_MASK) <= (IEEE80211_SN_MODULO >> 1);
+}
+
 static inline u16 ieee80211_sn_add(u16 sn1, u16 sn2)
 {
 	return (sn1 + sn2) & IEEE80211_SN_MASK;
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 534cac3fc8df..46b517cf47ea 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -5,7 +5,7 @@
  * Copyright 2006-2007	Jiri Benc <jbenc@suse.cz>
  * Copyright 2007-2010	Johannes Berg <johannes@sipsolutions.net>
  * Copyright 2013-2015  Intel Mobile Communications GmbH
- * Copyright (C) 2018-2022 Intel Corporation
+ * Copyright (C) 2018-2024 Intel Corporation
  */
 
 #ifndef IEEE80211_I_H
@@ -523,6 +523,8 @@ struct ieee80211_if_managed {
 
 	unsigned int flags;
 
+	u16 mcast_seq_last;
+
 	bool status_acked;
 	bool status_received;
 	__le16 status_fc;
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 64367cb141ca..d5293e715558 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -3350,6 +3350,8 @@ static void ieee80211_set_disassoc(struct ieee80211_sub_if_data *sdata,
 	wiphy_delayed_work_cancel(sdata->local->hw.wiphy,
 				  &ifmgd->neg_ttlm_timeout_work);
 	ieee80211_vif_set_links(sdata, 0, 0);
+
+	ifmgd->mcast_seq_last = IEEE80211_SN_MODULO;
 }
 
 static void ieee80211_reset_ap_probe(struct ieee80211_sub_if_data *sdata)
@@ -7514,6 +7516,7 @@ void ieee80211_sta_setup_sdata(struct ieee80211_sub_if_data *sdata)
 	spin_lock_init(&ifmgd->teardown_lock);
 	ifmgd->teardown_skb = NULL;
 	ifmgd->orig_teardown_skb = NULL;
+	ifmgd->mcast_seq_last = IEEE80211_SN_MODULO;
 }
 
 static void ieee80211_recalc_smps_work(struct wiphy *wiphy,
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 16d8783a469d..1ee00547c0a4 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -1434,13 +1434,31 @@ ieee80211_rx_h_check_dup(struct ieee80211_rx_data *rx)
 		return RX_CONTINUE;
 
 	if (ieee80211_is_ctl(hdr->frame_control) ||
-	    ieee80211_is_any_nullfunc(hdr->frame_control) ||
-	    is_multicast_ether_addr(hdr->addr1))
+	    ieee80211_is_any_nullfunc(hdr->frame_control))
 		return RX_CONTINUE;
 
 	if (!rx->sta)
 		return RX_CONTINUE;
 
+	if (unlikely(is_multicast_ether_addr(hdr->addr1))) {
+		struct ieee80211_sub_if_data *sdata = rx->sdata;
+		u16 sn = ieee80211_get_sn(hdr);
+
+		if (!ieee80211_is_data_present(hdr->frame_control))
+			return RX_CONTINUE;
+
+		if (!ieee80211_vif_is_mld(&sdata->vif) ||
+		    sdata->vif.type != NL80211_IFTYPE_STATION)
+			return RX_CONTINUE;
+
+		if (sdata->u.mgd.mcast_seq_last != IEEE80211_SN_MODULO &&
+		    ieee80211_sn_less_eq(sn, sdata->u.mgd.mcast_seq_last))
+			return RX_DROP_U_DUP;
+
+		sdata->u.mgd.mcast_seq_last = sn;
+		return RX_CONTINUE;
+	}
+
 	if (unlikely(ieee80211_has_retry(hdr->frame_control) &&
 		     rx->sta->last_seq_ctrl[rx->seqno_idx] == hdr->seq_ctrl)) {
 		I802_DEBUG_INC(rx->local->dot11FrameDuplicateCount);
-- 
2.43.0


