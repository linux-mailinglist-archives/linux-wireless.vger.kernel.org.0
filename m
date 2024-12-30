Return-Path: <linux-wireless+bounces-16888-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EBC79FE27E
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Dec 2024 05:56:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58FBC1881FFE
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Dec 2024 04:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2BA217084F;
	Mon, 30 Dec 2024 04:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VkosnRDG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2014A172767
	for <linux-wireless@vger.kernel.org>; Mon, 30 Dec 2024 04:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735534577; cv=none; b=hk9HJYI/qtJuX+KjJHj33q6VVuf/brg42nTiJy+n3Ju8v9c58pGKe57sPKhdkA0v0l9DmC9oEmgf+JANjzy6Beg+NbwZqU5cz3rMUGzRoPI0YqzRgCapl11mluR8bfsSlAgoEdpu4p2pYP3IhZszSM1c5N1cLJOmFrD2RGxXxss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735534577; c=relaxed/simple;
	bh=kkcGuKEh2GYRESUCmLuTT08iIN03tijid9pgeJO5T1Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pHruZU6MkrwtzpvQlZmCaGCGeRUwr8knc8rtHkGdI//6VSXz5Sgx/jeHQzyPSPsDZ7dGrNa9rmrdtkqbRqZQORCtOkqiVXHMtX3v1slKXDlnDzn7BkZwlsv/2ZN8e1WmA+bITVTD986/GfcbTUprUK61GXTd/DNYHC+M039+N8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VkosnRDG; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735534576; x=1767070576;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kkcGuKEh2GYRESUCmLuTT08iIN03tijid9pgeJO5T1Y=;
  b=VkosnRDGnO0EJxANkGURhy5qCoZoupSnkn7AEVqfodZKKvZ2ZqcvxreP
   e/YFUE+6LqW+i/RWTdXk708TAQ6FdMazTVwJDgqYpmU6kCCKEhdf7ET/3
   zIuvTrQMG1Bu11yK4fmo6/AIzOIOweMdTgPcT0FgNds2KiS3YMLIfXXD4
   xStr4Fu4Q9G1fXhnHzmmdtVBlalsdk5ZfYeIEPIczPGr6OOpY21iZh+55
   +IZCGzGqYHQIRf3wzUxKVL8NVX04gCsJVEwMRAkGjwTHNdTPjUgYwiiRZ
   mUjHUAo+OoXrOA47k7+GH8GxB5S8We4I+aQv+t/aCC/HcrMhRFSoIJnmH
   w==;
X-CSE-ConnectionGUID: AYkWyKgTQLWHwAvSnxwwtw==
X-CSE-MsgGUID: Kvu1RzBrQ4OKoBwzh4ALZw==
X-IronPort-AV: E=McAfee;i="6700,10204,11299"; a="46405010"
X-IronPort-AV: E=Sophos;i="6.12,275,1728975600"; 
   d="scan'208";a="46405010"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2024 20:56:16 -0800
X-CSE-ConnectionGUID: M3CS+2K4Qv2potfVu3tLoA==
X-CSE-MsgGUID: TVYdEpDPQeOzpd8hv+udLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="104758884"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2024 20:56:14 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 05/15] wifi: mac80211: mlme: improve messages from config_bw()
Date: Mon, 30 Dec 2024 06:55:44 +0200
Message-Id: <20241230065327.ee574cf7553b.Ie7c78877d20b5e9de4cce3cf8e4f1b9e0c7ee005@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241230045554.3746143-1-miriam.rachel.korenblit@intel.com>
References: <20241230045554.3746143-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

The ieee80211_config_bw() function is called in different
contexts: during association with the association response
and during beacon tracking with the beacon. This can be a
bit misleading, so disambiguate the messages for those.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/mlme.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 61c318f5239f..956eb265fe78 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -988,7 +988,8 @@ ieee80211_determine_chan_mode(struct ieee80211_sub_if_data *sdata,
 
 static int ieee80211_config_bw(struct ieee80211_link_data *link,
 			       struct ieee802_11_elems *elems,
-			       bool update, u64 *changed)
+			       bool update, u64 *changed,
+			       const char *frame)
 {
 	struct ieee80211_channel *channel = link->conf->chanreq.oper.chan;
 	struct ieee80211_sub_if_data *sdata = link->sdata;
@@ -1013,9 +1014,10 @@ static int ieee80211_config_bw(struct ieee80211_link_data *link,
 
 	if (ap_mode != link->u.mgd.conn.mode) {
 		link_info(link,
-			  "AP appears to change mode (expected %s, found %s), disconnect\n",
+			  "AP %pM appears to change mode (expected %s, found %s) in %s, disconnect\n",
+			  link->u.mgd.bssid,
 			  ieee80211_conn_mode_str(link->u.mgd.conn.mode),
-			  ieee80211_conn_mode_str(ap_mode));
+			  ieee80211_conn_mode_str(ap_mode), frame);
 		return -EINVAL;
 	}
 
@@ -1060,16 +1062,16 @@ static int ieee80211_config_bw(struct ieee80211_link_data *link,
 		return 0;
 
 	link_info(link,
-		  "AP %pM changed bandwidth, new used config is %d.%03d MHz, width %d (%d.%03d/%d MHz)\n",
-		  link->u.mgd.bssid, chanreq.oper.chan->center_freq,
+		  "AP %pM changed bandwidth in %s, new used config is %d.%03d MHz, width %d (%d.%03d/%d MHz)\n",
+		  link->u.mgd.bssid, frame, chanreq.oper.chan->center_freq,
 		  chanreq.oper.chan->freq_offset, chanreq.oper.width,
 		  chanreq.oper.center_freq1, chanreq.oper.freq1_offset,
 		  chanreq.oper.center_freq2);
 
 	if (!cfg80211_chandef_valid(&chanreq.oper)) {
 		sdata_info(sdata,
-			   "AP %pM changed caps/bw in a way we can't support - disconnect\n",
-			   link->u.mgd.bssid);
+			   "AP %pM changed caps/bw in %s in a way we can't support - disconnect\n",
+			   link->u.mgd.bssid, frame);
 		return -EINVAL;
 	}
 
@@ -1098,8 +1100,8 @@ static int ieee80211_config_bw(struct ieee80211_link_data *link,
 	ret = ieee80211_link_change_chanreq(link, &chanreq, changed);
 	if (ret) {
 		sdata_info(sdata,
-			   "AP %pM changed bandwidth to incompatible one - disconnect\n",
-			   link->u.mgd.bssid);
+			   "AP %pM changed bandwidth in %s to incompatible one - disconnect\n",
+			   link->u.mgd.bssid, frame);
 		return ret;
 	}
 
@@ -4898,7 +4900,7 @@ static bool ieee80211_assoc_config_link(struct ieee80211_link_data *link,
 	/* check/update if AP changed anything in assoc response vs. scan */
 	if (ieee80211_config_bw(link, elems,
 				link_id == assoc_data->assoc_link_id,
-				changed)) {
+				changed, "assoc response")) {
 		ret = false;
 		goto out;
 	}
@@ -7056,7 +7058,7 @@ static void ieee80211_rx_mgmt_beacon(struct ieee80211_link_data *link,
 
 	changed |= ieee80211_recalc_twt_req(sdata, sband, link, link_sta, elems);
 
-	if (ieee80211_config_bw(link, elems, true, &changed)) {
+	if (ieee80211_config_bw(link, elems, true, &changed, "beacon")) {
 		ieee80211_set_disassoc(sdata, IEEE80211_STYPE_DEAUTH,
 				       WLAN_REASON_DEAUTH_LEAVING,
 				       true, deauth_buf);
-- 
2.34.1


