Return-Path: <linux-wireless+bounces-16955-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28F419FF2D6
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Jan 2025 06:06:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4748B3A1A6D
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Jan 2025 05:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED0531799F;
	Wed,  1 Jan 2025 05:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hoctPk88"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418C9DF60
	for <linux-wireless@vger.kernel.org>; Wed,  1 Jan 2025 05:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735707961; cv=none; b=JK1sxAXTD5YlZqml7yNcyBMkvrGHQbzEh29s3ZIVox4i2dM/47sl1kTnyo8RVAsQXLqOpU577ZII8FMOe0kEg0TwxO5YWrvFNw2XRmWcLYrfW9apsj+7xuIXAoSwQYLK6T1Dcn6u1dpao7BDn9LjQG2xb2IDG16oW5IPXKCL08M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735707961; c=relaxed/simple;
	bh=kkcGuKEh2GYRESUCmLuTT08iIN03tijid9pgeJO5T1Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EtXpBYktqIxSrdYc4dhY74IVjgX9H+Ir0IYZd8ut/Af9YJQAjVwfR74D9l34WdKXm4qdKH+BEuKtoN1IRxMGFghE1W6qnwArTF93HAmwIed0GVaDBgvB74/lj9mkM4BtPsyf4jQWxy8fhsrty9jjMxFhmpZ2kBx42PE7DmyI0Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hoctPk88; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735707960; x=1767243960;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kkcGuKEh2GYRESUCmLuTT08iIN03tijid9pgeJO5T1Y=;
  b=hoctPk88oBFoI6f+AFP94cQJ1wQ/Ytc+KW7I73lW1CSmXn5XROjFLuRe
   +9lK/iYQYXNe9QGjKHv9/3spe2s+sG4wKLo7zBkb5KcPGRb3VWz6oAP1V
   a6m0rEOJv/J+8JIloCMWzyuyKg5RYgVVRDEMJ2yX+FqNnhM6W7UU2H0NW
   x3c/8BofcqFRPbdZQ94FSfZmTKDUaLvVRBF8ZsHEwFwAGGBbpClmtANOb
   41KgFUzTcDPPm0VpMYevuIN8snWgHSne5bLvs+ZpOXugwxMIquxdflKu8
   MykveUfm5QsOOMRw+6H/tutvegCsAMMWzt9lrJEqwMMgwyUWuhqj/5/MP
   g==;
X-CSE-ConnectionGUID: tnPusHYFRz+NVcb+r4QQzQ==
X-CSE-MsgGUID: lBXenn3ATXm6w65nV1UMnQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11302"; a="36194409"
X-IronPort-AV: E=Sophos;i="6.12,281,1728975600"; 
   d="scan'208";a="36194409"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2024 21:06:00 -0800
X-CSE-ConnectionGUID: IlQsF3t8QmittHL6AY2ydg==
X-CSE-MsgGUID: /8ReYPkGTnq1itwTUDryPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,281,1728975600"; 
   d="scan'208";a="101618882"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2024 21:05:59 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 05/19] wifi: mac80211: mlme: improve messages from config_bw()
Date: Wed,  1 Jan 2025 07:05:25 +0200
Message-Id: <20250101070249.ee574cf7553b.Ie7c78877d20b5e9de4cce3cf8e4f1b9e0c7ee005@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250101050539.1718643-1-miriam.rachel.korenblit@intel.com>
References: <20250101050539.1718643-1-miriam.rachel.korenblit@intel.com>
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


