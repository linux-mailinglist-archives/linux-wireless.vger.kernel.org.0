Return-Path: <linux-wireless+bounces-32113-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UBU0EbBMnGnYDQQAu9opvQ
	(envelope-from <linux-wireless+bounces-32113-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Feb 2026 13:48:48 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D660F1766F8
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Feb 2026 13:48:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6A69130D2435
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Feb 2026 12:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DF8F365A02;
	Mon, 23 Feb 2026 12:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="EWZy9PhI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C26366078
	for <linux-wireless@vger.kernel.org>; Mon, 23 Feb 2026 12:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771850454; cv=none; b=P7dozV4nIFfNt0QEcp/NsevNG4k/Bqr7GqnDGfeMBJT2OSeUhQ4U6C6R0Lld5WG00d4PZV7nyA79iNk+VKFmcTuNO21LGHtJ+YjPax7O6caSH1njrsppZhthsMPNPnORECVWL/CwMKw2GpTMnVNYg7CIUzgaxNnSFL0uqam/WsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771850454; c=relaxed/simple;
	bh=SKne4Z/S5bDcREIAJed/9nKQ1UwsyBZoIIIScpNbnNc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aQm8Km9aaHPKKb/2lUxhBXeAxPK4PrsYFAS40dev/QN0juAf5To9Ebzg3FrJD83B1D00stVnQnZMIVSFiWnzvTMqSMMGr7FD/W8QO8S/34uVjKApyUy+IW607pGo52j2IvEGcmVfztno+sNL/kMVEw8w/Lu0dji/ZFeOZmHtfO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=EWZy9PhI; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=h8TJkcHlUlgSl6Qh7X0UHbMx6kkKs13xzmUUFDqYilk=;
	t=1771850453; x=1773060053; b=EWZy9PhI6jD4ZZxpBlc44b51uf/9mjq6PCrraxIGQFBVfxk
	DjW/wbXqtWCG+pSqR5e93jzpXZGj0n/fxGqyJ6LyH4heeVjykdH3BPXee84O2BeKPXfgrpjYeDpTu
	fK8zzwTauAWfzm1AFriEAkBaeA2bljpY3qEgzrs22skxsjZ8N6h+FLHMaLBCSqsuFDwxrbX5hAN09
	L00cpcotnAFM5fYUymabZTssFI5C46wt/tM7HMi2QslgNrCGPxmg0Oh9bDKIVhOIO21/i2TVI9/Ch
	zth93QmBiZdOuNV88suQeNsFJLNKsfNEMvDornj93Jycqz++Tn1uqXF/YdmSHMHw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1vuVF3-0000000H2xI-2XJC;
	Mon, 23 Feb 2026 13:40:49 +0100
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Rameshkumar Sundaram <rameshkumar.sundaram@oss.qualcomm.com>,
	Ramasamy Kaliappan <ramasamy.kaliappan@oss.qualcomm.com>,
	Benjamin Berg <benjamin.berg@intel.com>
Subject: [RFC PATCH v2 7/8] wifi: mac80211: pass station to ieee80211_tx_skb_tid
Date: Mon, 23 Feb 2026 13:38:26 +0100
Message-ID: <20260223133818.c932d807e54e.Ib7be90db0d3712d14e7a292023ff3d922baef860@changeid>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260223123818.384184-10-benjamin@sipsolutions.net>
References: <20260223123818.384184-10-benjamin@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[sipsolutions.net,none];
	R_DKIM_ALLOW(-0.20)[sipsolutions.net:s=mail];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-32113-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[benjamin@sipsolutions.net,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[sipsolutions.net:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sourmilk.net:email,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sipsolutions.net:dkim]
X-Rspamd-Queue-Id: D660F1766F8
X-Rspamd-Action: no action

From: Benjamin Berg <benjamin.berg@intel.com>

The station may be relevant for queuing and will also generally be
resolved in some cases. However, we want to be able to prevent looking
up the station based on the address.

Add a station parameter, which can be set to the correct station, to an
error value to prevent station lookup or to NULL to get the old
behaviour where the address is used to find the appropriate station.

Also disable the station lookup for ieee80211_tx_skb_tid_band already as
it does not make any sense to find a station when doing an off-channel
transmit.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
---
 net/mac80211/agg-tx.c      |  6 +++---
 net/mac80211/ht.c          |  4 ++--
 net/mac80211/ieee80211_i.h | 14 ++++++++------
 net/mac80211/offchannel.c  |  2 +-
 net/mac80211/rx.c          |  2 +-
 net/mac80211/tdls.c        |  4 ++--
 net/mac80211/tx.c          |  8 +++++---
 7 files changed, 22 insertions(+), 18 deletions(-)

diff --git a/net/mac80211/agg-tx.c b/net/mac80211/agg-tx.c
index d981b0fc57bf..6a5754351f08 100644
--- a/net/mac80211/agg-tx.c
+++ b/net/mac80211/agg-tx.c
@@ -9,7 +9,7 @@
  * Copyright 2007, Michael Wu <flamingice@sourmilk.net>
  * Copyright 2007-2010, Intel Corporation
  * Copyright(c) 2015-2017 Intel Deutschland GmbH
- * Copyright (C) 2018 - 2024 Intel Corporation
+ * Copyright (C) 2018 - 2024, 2026 Intel Corporation
  */
 
 #include <linux/ieee80211.h>
@@ -97,7 +97,7 @@ static void ieee80211_send_addba_request(struct sta_info *sta, u16 tid,
 	if (sta->sta.deflink.he_cap.has_he)
 		ieee80211_add_addbaext(skb, 0, agg_size);
 
-	ieee80211_tx_skb_tid(sdata, skb, tid, -1);
+	ieee80211_tx_skb_tid(sdata, skb, NULL, tid, -1);
 }
 
 void ieee80211_send_bar(struct ieee80211_vif *vif, u8 *ra, u16 tid, u16 ssn)
@@ -126,7 +126,7 @@ void ieee80211_send_bar(struct ieee80211_vif *vif, u8 *ra, u16 tid, u16 ssn)
 
 	IEEE80211_SKB_CB(skb)->flags |= IEEE80211_TX_INTFL_DONT_ENCRYPT |
 					IEEE80211_TX_CTL_REQ_TX_STATUS;
-	ieee80211_tx_skb_tid(sdata, skb, tid, -1);
+	ieee80211_tx_skb_tid(sdata, skb, NULL, tid, -1);
 }
 EXPORT_SYMBOL(ieee80211_send_bar);
 
diff --git a/net/mac80211/ht.c b/net/mac80211/ht.c
index 1c82a28b03de..f98f5a9a2ebe 100644
--- a/net/mac80211/ht.c
+++ b/net/mac80211/ht.c
@@ -9,7 +9,7 @@
  * Copyright 2007, Michael Wu <flamingice@sourmilk.net>
  * Copyright 2007-2010, Intel Corporation
  * Copyright 2017	Intel Deutschland GmbH
- * Copyright(c) 2020-2025 Intel Corporation
+ * Copyright(c) 2020-2026 Intel Corporation
  */
 
 #include <linux/ieee80211.h>
@@ -571,7 +571,7 @@ int ieee80211_send_smps_action(struct ieee80211_sub_if_data *sdata,
 	info->status_data = IEEE80211_STATUS_TYPE_SMPS |
 			    u16_encode_bits(status_link_id << 2 | smps,
 					    IEEE80211_STATUS_SUBDATA_MASK);
-	ieee80211_tx_skb_tid(sdata, skb, 7, link_id);
+	ieee80211_tx_skb_tid(sdata, skb, NULL, 7, link_id);
 
 	return 0;
 }
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index e60b814dd89e..793331c1d748 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2393,7 +2393,8 @@ void ieee80211_xmit(struct ieee80211_sub_if_data *sdata,
 		    struct sta_info *sta, struct sk_buff *skb);
 
 void __ieee80211_tx_skb_tid_band(struct ieee80211_sub_if_data *sdata,
-				 struct sk_buff *skb, int tid, int link_id,
+				 struct sk_buff *skb, struct sta_info *sta,
+				 int tid, int link_id,
 				 enum nl80211_band band);
 
 static inline bool ieee80211_require_encrypted_assoc(__le16 fc,
@@ -2411,22 +2412,23 @@ int ieee80211_lookup_ra_sta(struct ieee80211_sub_if_data *sdata,
 
 static inline void
 ieee80211_tx_skb_tid_band(struct ieee80211_sub_if_data *sdata,
-			  struct sk_buff *skb, int tid,
-			  enum nl80211_band band)
+			  struct sk_buff *skb, int tid, enum nl80211_band band)
 {
 	rcu_read_lock();
-	__ieee80211_tx_skb_tid_band(sdata, skb, tid, -1, band);
+	__ieee80211_tx_skb_tid_band(sdata, skb, ERR_PTR(-ENOENT),
+				    tid, -1, band);
 	rcu_read_unlock();
 }
 
 void ieee80211_tx_skb_tid(struct ieee80211_sub_if_data *sdata,
-			  struct sk_buff *skb, int tid, int link_id);
+			  struct sk_buff *skb, struct sta_info *sta,
+			  int tid, int link_id);
 
 static inline void ieee80211_tx_skb(struct ieee80211_sub_if_data *sdata,
 				    struct sk_buff *skb)
 {
 	/* Send all internal mgmt frames on VO. Accordingly set TID to 7. */
-	ieee80211_tx_skb_tid(sdata, skb, 7, -1);
+	ieee80211_tx_skb_tid(sdata, skb, NULL, 7, -1);
 }
 
 /**
diff --git a/net/mac80211/offchannel.c b/net/mac80211/offchannel.c
index ae82533e3c02..0a8b4c5e8c12 100644
--- a/net/mac80211/offchannel.c
+++ b/net/mac80211/offchannel.c
@@ -1026,7 +1026,7 @@ int ieee80211_mgmt_tx(struct wiphy *wiphy, struct wireless_dev *wdev,
 	}
 
 	if (!need_offchan) {
-		ieee80211_tx_skb_tid(sdata, skb, 7, link_id);
+		ieee80211_tx_skb_tid(sdata, skb, NULL, 7, link_id);
 		ret = 0;
 		goto out_unlock;
 	}
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index ec718b7f3e16..5109791546a7 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -4072,7 +4072,7 @@ ieee80211_rx_h_action_return(struct ieee80211_rx_data *rx)
 					local->hw.offchannel_tx_hw_queue;
 		}
 
-		__ieee80211_tx_skb_tid_band(rx->sdata, nskb, 7, -1,
+		__ieee80211_tx_skb_tid_band(rx->sdata, nskb, rx->sta, 7, -1,
 					    status->band);
 	}
 
diff --git a/net/mac80211/tdls.c b/net/mac80211/tdls.c
index dbbfe2d6842f..39a880ab7edb 100644
--- a/net/mac80211/tdls.c
+++ b/net/mac80211/tdls.c
@@ -6,7 +6,7 @@
  * Copyright 2014, Intel Corporation
  * Copyright 2014  Intel Mobile Communications GmbH
  * Copyright 2015 - 2016 Intel Deutschland GmbH
- * Copyright (C) 2019, 2021-2025 Intel Corporation
+ * Copyright (C) 2019, 2021-2026 Intel Corporation
  */
 
 #include <linux/ieee80211.h>
@@ -1067,7 +1067,7 @@ ieee80211_tdls_prep_mgmt_packet(struct wiphy *wiphy, struct net_device *dev,
 	}
 
 	if (action_code == WLAN_PUB_ACTION_TDLS_DISCOVER_RES) {
-		ieee80211_tx_skb_tid(sdata, skb, 7, link_id);
+		ieee80211_tx_skb_tid(sdata, skb, sta, 7, link_id);
 		return 0;
 	}
 
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 007f5a368d41..c788d48ef365 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -6235,7 +6235,8 @@ void ieee80211_unreserve_tid(struct ieee80211_sta *pubsta, u8 tid)
 EXPORT_SYMBOL(ieee80211_unreserve_tid);
 
 void __ieee80211_tx_skb_tid_band(struct ieee80211_sub_if_data *sdata,
-				 struct sk_buff *skb, int tid, int link_id,
+				 struct sk_buff *skb, struct sta_info *sta,
+				 int tid, int link_id,
 				 enum nl80211_band band)
 {
 	const struct ieee80211_hdr *hdr = (void *)skb->data;
@@ -6292,7 +6293,8 @@ void __ieee80211_tx_skb_tid_band(struct ieee80211_sub_if_data *sdata,
 }
 
 void ieee80211_tx_skb_tid(struct ieee80211_sub_if_data *sdata,
-			  struct sk_buff *skb, int tid, int link_id)
+			  struct sk_buff *skb, struct sta_info *sta,
+			  int tid, int link_id)
 {
 	struct ieee80211_chanctx_conf *chanctx_conf;
 	enum nl80211_band band;
@@ -6317,7 +6319,7 @@ void ieee80211_tx_skb_tid(struct ieee80211_sub_if_data *sdata,
 		band = 0;
 	}
 
-	__ieee80211_tx_skb_tid_band(sdata, skb, tid, link_id, band);
+	__ieee80211_tx_skb_tid_band(sdata, skb, sta, tid, link_id, band);
 	rcu_read_unlock();
 }
 
-- 
2.53.0


