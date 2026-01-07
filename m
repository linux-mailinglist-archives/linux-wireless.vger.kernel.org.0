Return-Path: <linux-wireless+bounces-30497-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CFDDCFE5CE
	for <lists+linux-wireless@lfdr.de>; Wed, 07 Jan 2026 15:45:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2E3FE308F1B8
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Jan 2026 14:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A1B834404F;
	Wed,  7 Jan 2026 14:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Wifsq+FU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88B5343D76
	for <linux-wireless@vger.kernel.org>; Wed,  7 Jan 2026 14:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767795849; cv=none; b=BYoxcHnD4wlqLpbVc67gGkitUMJlsNlYv5kW6DMzue8b7QgJRxSXn+ZexDGUdvoGGtKGMleUYsyLFZU1WsT+kBPI789hNWlqod4RfIKM8bxdXvEaQLYWu0vbverswB/WzXju0W7nOmgG1rLe3v/PsckPpEW7yaSG+jmWhS3rE/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767795849; c=relaxed/simple;
	bh=LsfBlJeIO5ZRdeDbpBH9nHHSBQeQgqlKMp02/l/lRl4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rFLNTHs4V3STEOipgGWcYcmu7rI24bw0nMXveVKgkyf4Q/qYJlD1SUH6jqsiTgn63X8whohFf8HqVUExvrQamVoMG5N8gQggUhDyLBJNy0jp9puzQYjmCTC0vZKLVFzJRbQxgkv55Rano7YucCgutHonmsTDkV8r0YNVfgkRROE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Wifsq+FU; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=1ruf9ZS/e7RlT6iek+MBovCVHy1Byle0UGUMb9faVzI=;
	t=1767795847; x=1769005447; b=Wifsq+FUdqLrYcRBZUOue+rRYsUwZSUwUMIc2yJmJzUAXy7
	EDvNatgP9CNnJL69LnGd2Il9cnl7goj10FcDrs4zlhW+tILJP8icpUvXvhUy+/gC72FpfQp/9E1Ii
	9WnWk0ezhs+IB3nFNbOqc6nQdYla2Ppef5dRjBo4GuquLwxatm5E3DKor+hrE3bLASY+WB2kBPSDA
	osFfD/XzzNzUsd+DdJ+vo9IWdbNcdWvjcxRFkDpr6wMPMbkLdWjxPtWfAnhWNb/R6XrBRjFWVMkRk
	WdaadqZQVJW+w03bMVjwkIliF4qGHqsfWctzFaDhhYeHd/NYXaMUvoAS0k7dtKmg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vdUSD-00000005agF-3ZDs;
	Wed, 07 Jan 2026 15:24:06 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [RFC wireless-next 35/46] wifi: mac80211: Accept frames on NAN DATA interfaces
Date: Wed,  7 Jan 2026 15:22:34 +0100
Message-ID: <20260107152325.043cfd9b6210.Iaa84cc3d063392f0150fcdf2bf610bdb41062f70@changeid>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260107142324.45386-48-johannes@sipsolutions.net>
References: <20260107142324.45386-48-johannes@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Miri Korenblit <miriam.rachel.korenblit@intel.com>

Accept frames there were received on NAN DATA interfaces:

- Data frames, both multicast or unicast
- Non-Public action frames, both multicast or unicast
- Unicast secure management frames
- FromDS and ToDS are 0.

While at it, check FromDS/ToDS also for NAN management frames.

Accept only data frames from devices that are part of the NAN
cluster.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/rx.c | 37 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index b38f860936c2..771fb07e84c3 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -4465,6 +4465,9 @@ static bool ieee80211_accept_frame(struct ieee80211_rx_data *rx)
 	u8 *bssid = ieee80211_get_bssid(hdr, skb->len, sdata->vif.type);
 	bool multicast = is_multicast_ether_addr(hdr->addr1) ||
 			 ieee80211_is_s1g_beacon(hdr->frame_control);
+	static const u8 nan_network_id[ETH_ALEN] __aligned(2) = {
+		0x51, 0x6F, 0x9A, 0x01, 0x00, 0x00
+	};
 
 	switch (sdata->vif.type) {
 	case NL80211_IFTYPE_STATION:
@@ -4593,6 +4596,10 @@ static bool ieee80211_accept_frame(struct ieee80211_rx_data *rx)
 		       (ieee80211_is_auth(hdr->frame_control) &&
 			ether_addr_equal(sdata->vif.addr, hdr->addr1));
 	case NL80211_IFTYPE_NAN:
+		if (ieee80211_has_tods(hdr->frame_control) ||
+		    ieee80211_has_fromds(hdr->frame_control))
+			return false;
+
 		/* Accept only frames that are addressed to the NAN cluster
 		 * (based on the Cluster ID). From these frames, accept only
 		 * action frames or authentication frames that are addressed to
@@ -4604,7 +4611,35 @@ static bool ieee80211_accept_frame(struct ieee80211_rx_data *rx)
 			 (ieee80211_is_auth(hdr->frame_control) &&
 			  ether_addr_equal(sdata->vif.addr, hdr->addr1)));
 	case NL80211_IFTYPE_NAN_DATA:
-		return false;
+		if (ieee80211_has_tods(hdr->frame_control) ||
+		    ieee80211_has_fromds(hdr->frame_control))
+			return false;
+
+		if (ieee80211_is_data(hdr->frame_control)) {
+			struct ieee80211_sub_if_data *nmi;
+
+			nmi = rcu_dereference(sdata->u.nan_data.nmi);
+			if (!nmi)
+				return false;
+
+			if (!ether_addr_equal(nmi->wdev.u.nan.cluster_id,
+					      hdr->addr3))
+				return false;
+
+			return multicast ||
+			       ether_addr_equal(sdata->vif.addr, hdr->addr1);
+		}
+
+		/* Non-public action frames (unicast or multicast) */
+		if (ieee80211_is_action(hdr->frame_control) &&
+		    !ieee80211_is_public_action(hdr, skb->len) &&
+		    (ether_addr_equal(nan_network_id, hdr->addr1) ||
+		     ether_addr_equal(sdata->vif.addr, hdr->addr1)))
+			return true;
+
+		/* Unicast secure management frames */
+		return ether_addr_equal(sdata->vif.addr, hdr->addr1) &&
+		       ieee80211_is_unicast_robust_mgmt_frame(skb);
 	default:
 		break;
 	}
-- 
2.52.0


