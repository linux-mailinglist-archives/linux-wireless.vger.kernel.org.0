Return-Path: <linux-wireless+bounces-20167-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8A8BA5BE8C
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Mar 2025 12:10:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 057E9168B3F
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Mar 2025 11:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9660250C1C;
	Tue, 11 Mar 2025 11:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="w5PQ0fhI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBDF23F295
	for <linux-wireless@vger.kernel.org>; Tue, 11 Mar 2025 11:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741691410; cv=none; b=Q4dMYYpcR4kGKcCVYnVSG2XQ2k8DsF0QPywvcim4lYyeLwzriC7QA0pyK3u2R3kZUyATBNhZINKGODvyx3TANjJP/NZyr063tD8su1EuppLBqtKvAljEGoZdOzdAWbhDLOPPaoB9c7D9vJ9TyvmOqliQSgnSK43zBD1iMfh1X1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741691410; c=relaxed/simple;
	bh=sndIPybr33k+pwCiLZ7oRrToZn5TBff+KJMZdDUiNNk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uIOFSiCD/I8b6McHrI+HImojJ5Z5sbfDs4/KF0cctEaOBtbx65qSldzBJABIetSo3E9AWtoZ0hZgsE7PjJ6fcTeI6UAqxek0PCT476553G1E1fDWL5hVnP6Hk4FM05v4kJGADefrDX6nECn5mxgFejLzAnjQjeary720TXXmWhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=w5PQ0fhI; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=0nIGdyXBNyqmkdGdSKh7c7g7CNu1WwFIdaaagQwLmG0=; t=1741691409; x=1742901009; 
	b=w5PQ0fhILKCmcKv/GihsFNXSL/QXkd08R+OowSJvqhSW+mDimdOFVc276mWYEG8yNisX+4e4TMu
	KtfVCGB9ACLnP4/bScDb5HwRBQom3EZ/EjaxuXMPmdRDmHyig7JMhBFn6l7oDUUb9rUb10B/IHrKI
	prVBGBNOHftSHNhTnBoLSW3aGLE9jAyMZAZS/TZakKOVCE5TXwjuy37MGObDd4wRc8Vo2kJf3MT/I
	q41V+27+w3bajxel/tI0c3V/hSxHIrSMwUvcI7bwqjQZHzErYDuUgHKPWrxP4TKkbnZeemNm/Ylr/
	jNphJn32NuL0ME0J60BTY5vDpQYVG+6F0jsQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1trxUs-00000007ol7-2GPG;
	Tue, 11 Mar 2025 12:10:06 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH wireless-next 1/2] wifi: mac80211: remove SSID from ML reconf
Date: Tue, 11 Mar 2025 12:10:03 +0100
Message-ID: <20250311121004.fdf08f90bc30.I07f88d3a6f592a0df65d48f55d65c46a4d261007@changeid>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

The ML reconfiguration frame shouldn't contain an SSID,
remove it.

Fixes: 36e05b0b8390 ("wifi: mac80211: Support dynamic link addition and removal")
Reviewed-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/mlme.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index bfd3653a5b84..3dae02345ab8 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -10233,8 +10233,8 @@ ieee80211_build_ml_reconf_req(struct ieee80211_sub_if_data *sdata,
 		size += 2 + sizeof(struct ieee80211_mle_per_sta_profile) +
 			ETH_ALEN;
 
-		/* SSID element + WMM */
-		size += 2 + sdata->vif.cfg.ssid_len + 9;
+		/* WMM */
+		size += 9;
 		size += ieee80211_link_common_elems_size(sdata, iftype, cbss,
 							 elems_len);
 	}
@@ -10346,11 +10346,6 @@ ieee80211_build_ml_reconf_req(struct ieee80211_sub_if_data *sdata,
 
 			capab_pos = skb_put(skb, 2);
 
-			skb_put_u8(skb, WLAN_EID_SSID);
-			skb_put_u8(skb, sdata->vif.cfg.ssid_len);
-			skb_put_data(skb, sdata->vif.cfg.ssid,
-				     sdata->vif.cfg.ssid_len);
-
 			extra_used =
 				ieee80211_add_link_elems(sdata, skb, &capab, NULL,
 							 add_links_data->link[link_id].elems,
-- 
2.48.1


