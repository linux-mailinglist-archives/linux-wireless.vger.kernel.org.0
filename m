Return-Path: <linux-wireless+bounces-9651-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 34C9891A1D5
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jun 2024 10:46:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA0701F21765
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jun 2024 08:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E1DF45BFD;
	Thu, 27 Jun 2024 08:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="bzQcJhQv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C066D819
	for <linux-wireless@vger.kernel.org>; Thu, 27 Jun 2024 08:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719477970; cv=none; b=CQ6cHkwhr3nTB2Hv49+BNR8PBUnh4ZH95AKtwbMnf3Hgr+qGHZkJfceLHlUKUjwBBY2HYgabl6L365Mvv3r0eL1253bHxaguve13tMyBnUiaGoddq0WJ65EcMyUV4zwUfAvXcR8Gq0VWXKd3ofD++sVc76kPwlTsRdokIsgooFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719477970; c=relaxed/simple;
	bh=Sf8N6psHjGr7ioNyCG7EdS48X5ErxfeebBE4N2nz+PE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tM0vsFeiPW51ofBwx50Qafyt0QpQDshWvFSJdZAEaUvQxUHqdl0XwgidC9l0DlmFgw1IEMSj6Qajyj/GhbIGLdbom9qWL1BzOza+g9UTI+0teuLzfsGjAtlSJBZXbIFrD46mT2NSUWVjcjde8I66qx7zd9CVX352dhOJnb9M41s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=bzQcJhQv; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=8y5foOycO2NntxzlE8ugzaVcRM3kL5ZEaYJXbbGo7bw=; t=1719477968; x=1720687568; 
	b=bzQcJhQvTXLpD6+iVprBx+iOvB55T0f97dFJmpitbaUPiUuAqSRxNgx0m8u2yd+uDLusXyjDSPj
	gjPiMHOOdp2w5q/kyb2kb7VlJ2QgTEMpiNDtVYGDIVYFnaoFpXwpzQA51WwXrkXnLaLDXdk7phACS
	TXbk1FXySW5S95qPMJjW+EPZXIUGVQx5QphPW8GF2xn0hs2ZkgxD4lcoqoYTsR0dVYoDz2Wo5lKYd
	Mrs5CbZWNX2fv4S3BYYxaBSwTvu5gij1uPmmBEBn7xxAc7ezFfU2TOepQmENrw4ycffo6ulJuiPr6
	cZRYFU0Xn6Vjus0EnJpqviTjcNMl+0HQfTFQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sMklV-00000006b53-3yB2;
	Thu, 27 Jun 2024 10:46:02 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-wireless@vger.kernel.org
Cc: Ilan Peer <ilan.peer@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH] wifi: mac80211: Use the link BSS configuration for beacon processing
Date: Thu, 27 Jun 2024 10:46:00 +0200
Message-ID: <20240627104600.bb2f0f697881.I675b6a8a186b717f3eef79113c27361fd1a7622c@changeid>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ilan Peer <ilan.peer@intel.com>

The beacon processing should be fully done in the context of the link.
This also resolves a bug with CQM handling with MLO as in such a case
the RSSI thresholds configuration is maintained in the link context and
not in the interface context.

Reviewed-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 net/mac80211/mlme.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 3d207d79d11f..80a10cd49565 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -6696,7 +6696,7 @@ static void ieee80211_rx_mgmt_beacon(struct ieee80211_link_data *link,
 {
 	struct ieee80211_sub_if_data *sdata = link->sdata;
 	struct ieee80211_if_managed *ifmgd = &sdata->u.mgd;
-	struct ieee80211_bss_conf *bss_conf = &sdata->vif.bss_conf;
+	struct ieee80211_bss_conf *bss_conf = link->conf;
 	struct ieee80211_vif_cfg *vif_cfg = &sdata->vif.cfg;
 	struct ieee80211_mgmt *mgmt = (void *) hdr;
 	size_t baselen;
@@ -6740,7 +6740,7 @@ static void ieee80211_rx_mgmt_beacon(struct ieee80211_link_data *link,
 	parse_params.len = len - baselen;
 
 	rcu_read_lock();
-	chanctx_conf = rcu_dereference(link->conf->chanctx_conf);
+	chanctx_conf = rcu_dereference(bss_conf->chanctx_conf);
 	if (!chanctx_conf) {
 		rcu_read_unlock();
 		return;
@@ -6770,11 +6770,11 @@ static void ieee80211_rx_mgmt_beacon(struct ieee80211_link_data *link,
 		ifmgd->assoc_data->need_beacon = false;
 		if (ieee80211_hw_check(&local->hw, TIMING_BEACON_ONLY) &&
 		    !ieee80211_is_s1g_beacon(hdr->frame_control)) {
-			link->conf->sync_tsf =
+			bss_conf->sync_tsf =
 				le64_to_cpu(mgmt->u.beacon.timestamp);
-			link->conf->sync_device_ts =
+			bss_conf->sync_device_ts =
 				rx_status->device_timestamp;
-			link->conf->sync_dtim_count = elems->dtim_count;
+			bss_conf->sync_dtim_count = elems->dtim_count;
 		}
 
 		if (elems->mbssid_config_ie)
@@ -6798,7 +6798,7 @@ static void ieee80211_rx_mgmt_beacon(struct ieee80211_link_data *link,
 	}
 
 	if (!ifmgd->associated ||
-	    !ieee80211_rx_our_beacon(bssid, link->conf->bss))
+	    !ieee80211_rx_our_beacon(bssid, bss_conf->bss))
 		return;
 	bssid = link->u.mgd.bssid;
 
@@ -6825,7 +6825,7 @@ static void ieee80211_rx_mgmt_beacon(struct ieee80211_link_data *link,
 	 */
 	if (!ieee80211_is_s1g_beacon(hdr->frame_control))
 		ncrc = crc32_be(0, (void *)&mgmt->u.beacon.beacon_int, 4);
-	parse_params.bss = link->conf->bss;
+	parse_params.bss = bss_conf->bss;
 	parse_params.filter = care_about_ies;
 	parse_params.crc = ncrc;
 	elems = ieee802_11_parse_elems_full(&parse_params);
@@ -6906,11 +6906,11 @@ static void ieee80211_rx_mgmt_beacon(struct ieee80211_link_data *link,
 	 */
 	if (ieee80211_hw_check(&local->hw, TIMING_BEACON_ONLY) &&
 	    !ieee80211_is_s1g_beacon(hdr->frame_control)) {
-		link->conf->sync_tsf =
+		bss_conf->sync_tsf =
 			le64_to_cpu(mgmt->u.beacon.timestamp);
-		link->conf->sync_device_ts =
+		bss_conf->sync_device_ts =
 			rx_status->device_timestamp;
-		link->conf->sync_dtim_count = elems->dtim_count;
+		bss_conf->sync_dtim_count = elems->dtim_count;
 	}
 
 	if ((ncrc == link->u.mgd.beacon_crc && link->u.mgd.beacon_crc_valid) ||
@@ -6973,10 +6973,10 @@ static void ieee80211_rx_mgmt_beacon(struct ieee80211_link_data *link,
 		goto free;
 	}
 
-	if (WARN_ON(!link->conf->chanreq.oper.chan))
+	if (WARN_ON(!bss_conf->chanreq.oper.chan))
 		goto free;
 
-	sband = local->hw.wiphy->bands[link->conf->chanreq.oper.chan->band];
+	sband = local->hw.wiphy->bands[bss_conf->chanreq.oper.chan->band];
 
 	changed |= ieee80211_recalc_twt_req(sdata, sband, link, link_sta, elems);
 
-- 
2.45.2


