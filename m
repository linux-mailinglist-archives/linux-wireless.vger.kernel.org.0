Return-Path: <linux-wireless+bounces-4142-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E9F386AA61
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Feb 2024 09:47:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE966284155
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Feb 2024 08:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F1182D046;
	Wed, 28 Feb 2024 08:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="BFG7n+Bg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0B62D608
	for <linux-wireless@vger.kernel.org>; Wed, 28 Feb 2024 08:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709110069; cv=none; b=F5Pf06/osOdJ8b3f8Q/yYZJEldcHqw05pYhr5euDES70th2S0inikd5WQqdmYOaSAGRpDjT0j6zIC1DDHEdnTQquuzniv9Nq3gUznIvsox7Wl2AAH073nnVpyXxs8pRHJ//Vfg1B8A7VX3/DFL8KtKwNPeuB8IBerC3t78L/bYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709110069; c=relaxed/simple;
	bh=ey49+WZyg49bzk/NgfYBR4M4pJUU/DmfdJztlDK1jZs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d2ycJIaArs5n2EmfvF8jbMQEkwv5VTjIUgYYSCkDbsa0TbN/Q9ySQbyU9EpOTqoijCOFCJ7T0en/WTB3sWE+3TyA1UzzF6azTY1ghQKXoRBTIh2hfe3HF/iA/nnOVNKJgxQgAjEIdQyCdeF19bE6ps6qqMRuZ2oABZticzqrYOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=BFG7n+Bg; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=bvkk/5Xt9/QlIs4gF6HaJSFaavS5FQyORqcoDH3pqFQ=; t=1709110067; x=1710319667; 
	b=BFG7n+BgELVhRkD2qlg522Lqc988UXIdaZe5LSR9IcW4AcPKMe5F1RoHOPebYQi9dPTrJ+f0LCY
	3ny81e/UHi+JPaPP2dyg4adlmMMOrKpO/qEzB4IjTFWNcRf3KfYNT8heTB6GPmJ+JHklgA4iyabwA
	DxoJw1ilMSbx7DfN2ZK8scJV7D9ZF0P/90H9s6+NF/Izib7LwhlobAyJ/g1h85JQtKb0MRbsFAMr7
	cXKTjajlA4XqdoKKY4/aM/RgQUGul1jNuFSGN+eQPOV+iCwCm/o60U6qO44U2IqQQpUqj9aVOuovJ
	EBsfwCPE5pdcK3rWPTiI3UOp9/execsQituA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rfFbM-0000000C06T-2MoB;
	Wed, 28 Feb 2024 09:47:44 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Ilan Peer <ilan.peer@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH] wifi: mac80211: Allow beacons to update BSS table regardless of scan
Date: Wed, 28 Feb 2024 09:47:39 +0100
Message-ID: <20240228094742.e508605f495b.I3ab24ab3543319e31165111b28bcdcc622b5cf02@changeid>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ilan Peer <ilan.peer@intel.com>

When a beacon is received use it to update the BSS table regardless
of the scanning state. Do so only when there are active non-monitor
interfaces. Also, while at it, in any case accept beacons only with
broadcast address.

Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/scan.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/net/mac80211/scan.c b/net/mac80211/scan.c
index bca2a259fda6..0429e59ba387 100644
--- a/net/mac80211/scan.c
+++ b/net/mac80211/scan.c
@@ -257,7 +257,6 @@ static bool ieee80211_scan_accept_presp(struct ieee80211_sub_if_data *sdata,
 void ieee80211_scan_rx(struct ieee80211_local *local, struct sk_buff *skb)
 {
 	struct ieee80211_rx_status *rx_status = IEEE80211_SKB_RXCB(skb);
-	struct ieee80211_sub_if_data *sdata1, *sdata2;
 	struct ieee80211_mgmt *mgmt = (void *)skb->data;
 	struct ieee80211_bss *bss;
 	struct ieee80211_channel *channel;
@@ -281,12 +280,6 @@ void ieee80211_scan_rx(struct ieee80211_local *local, struct sk_buff *skb)
 	if (skb->len < min_hdr_len)
 		return;
 
-	sdata1 = rcu_dereference(local->scan_sdata);
-	sdata2 = rcu_dereference(local->sched_scan_sdata);
-
-	if (likely(!sdata1 && !sdata2))
-		return;
-
 	if (test_and_clear_bit(SCAN_BEACON_WAIT, &local->scanning)) {
 		/*
 		 * we were passive scanning because of radar/no-IR, but
@@ -304,10 +297,17 @@ void ieee80211_scan_rx(struct ieee80211_local *local, struct sk_buff *skb)
 		return;
 
 	if (ieee80211_is_probe_resp(mgmt->frame_control)) {
+		struct ieee80211_sub_if_data *sdata1, *sdata2;
 		struct cfg80211_scan_request *scan_req;
 		struct cfg80211_sched_scan_request *sched_scan_req;
 		u32 scan_req_flags = 0, sched_scan_req_flags = 0;
 
+		sdata1 = rcu_dereference(local->scan_sdata);
+		sdata2 = rcu_dereference(local->sched_scan_sdata);
+
+		if (likely(!sdata1 && !sdata2))
+			return;
+
 		scan_req = rcu_dereference(local->scan_req);
 		sched_scan_req = rcu_dereference(local->sched_scan_req);
 
@@ -327,8 +327,16 @@ void ieee80211_scan_rx(struct ieee80211_local *local, struct sk_buff *skb)
 						 sched_scan_req_flags,
 						 mgmt->da))
 			return;
+	} else {
+		/* Beacons are expected only with broadcast address */
+		if (!is_broadcast_ether_addr(mgmt->da))
+			return;
 	}
 
+	/* Do not update the BSS table in case of only monitor interfaces */
+	if (local->open_count == local->monitors)
+		return;
+
 	bss = ieee80211_bss_info_update(local, rx_status,
 					mgmt, skb->len,
 					channel);
-- 
2.43.2


