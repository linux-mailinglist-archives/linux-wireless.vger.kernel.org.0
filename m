Return-Path: <linux-wireless+bounces-28077-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4F82BEE13D
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Oct 2025 10:52:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F7243E4315
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Oct 2025 08:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 709D322ACE3;
	Sun, 19 Oct 2025 08:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gS5PIw+B"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94552C21E8
	for <linux-wireless@vger.kernel.org>; Sun, 19 Oct 2025 08:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760863967; cv=none; b=ZIflXbDMnm9E93GsqB4qboPh8uUUXkYGTJ3b6ggVN+s0M2Msk7VqTdNVgOqpc5ZzgGwEheynwnwQYuzJSYIV+Bq+OF5xux3Iqgy7y7NxZDyLQEoMcdtmJmFaY154rpLIsPa6Gp0hjuPjf3dtNx2TTTmWtbyrVO7eHX5o5Qx0D/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760863967; c=relaxed/simple;
	bh=/24kVyoG7J4NnAxTP9dVJWs81/AWqga33+88cShZGo0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mRzJRmdAm33bk2Uwe3s+IxwshiSlGc4RyjXttR54d9aPnV4W9jruivd/5+aTGRE/HQDwal/A/NDvba9E69pDtYXbIZy+l1+CPs3DT8p8LTZcHWe5j0fT/Vp8oyhyKc2bkwlqPlRt5S6btJb9ZMxCZqcQb8nzTSh4ynLuHMsS9AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gS5PIw+B; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760863963; x=1792399963;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/24kVyoG7J4NnAxTP9dVJWs81/AWqga33+88cShZGo0=;
  b=gS5PIw+BYQHBMOpiE5Idxqxqftiw2d6sgv64diNyFZ72zXcDphfFoQjI
   A9DO/GoT/4wQyO/0YwdYm0vCMOoplWKJPMXHyKysmYS+IkKXzgEY3GZ/f
   tDrPczJKDliBaSuYNWppl6+GnpLY4DAkRxRE2c4WYY6DgGanLQSXmrX31
   dP1/lBa7wzNDG3FEL11Av/1xtkQG53fPbnWEt9AUNlUXSNPHMkImT9wYF
   9VQR/Nez6mqgMgBPZonPGRmeBzxkT8ws2bNDv1kpqIPgIUfbEc637i1FN
   hhoqzLO/+ckHqJxyab2PkxbuEzLoWHWHss2kcaSJE5VZx8fNl9q1bwyV8
   A==;
X-CSE-ConnectionGUID: Jg2ZNBVzTCuTqA5XgdcJZQ==
X-CSE-MsgGUID: VgoXwY82T26jGcKQqDmQuQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="50588465"
X-IronPort-AV: E=Sophos;i="6.19,240,1754982000"; 
   d="scan'208";a="50588465"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2025 01:52:40 -0700
X-CSE-ConnectionGUID: FLgabfyZSqeX0Zb1pDQn8g==
X-CSE-MsgGUID: dWuXN+/lS5Ohxo0wkrZ4uA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,240,1754982000"; 
   d="scan'208";a="187516536"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2025 01:52:39 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Ilan Peer <ilan.peer@intel.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next v2] wifi: mac80211: Try to overcome bad HE operation in association response
Date: Sun, 19 Oct 2025 11:52:34 +0300
Message-Id: <20251019115152.e1cf791232a6.I69591428f2b9bde9df3c78c333e9b4fc264da0d9@changeid>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Ilan Peer <ilan.peer@intel.com>

Some APs, e.g., some versions of Aruba APs, have a bug where they
advertise invalid 6 GHz Operation Information in their HE operation
element in the association response. Since the information is invalid,
mac80211 cannot connect.

Try to overcome such cases by falling back to use the beacon/probe
response HE operation element. If this is possible, do not attempt
to connect with EHT and suffice with HE.

Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
v2: add the destination tree to the subject
---
 net/mac80211/mlme.c | 69 ++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 62 insertions(+), 7 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 3b5827ea438e..ac4cb1df8dc3 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -149,6 +149,45 @@ static int ecw2cw(int ecw)
 	return (1 << ecw) - 1;
 }
 
+static bool
+ieee80211_chandef_he_6ghz_oper_bss(struct ieee80211_sub_if_data *sdata,
+				   struct cfg80211_bss *cbss,
+				   struct cfg80211_chan_def *chandef)
+{
+	const struct ieee80211_he_operation *he_operation;
+	const struct cfg80211_bss_ies *ies;
+	const struct element *elem;
+	bool ret;
+
+	if (ieee80211_hw_check(&sdata->local->hw, STRICT) || !cbss)
+		return false;
+
+	guard(rcu)();
+
+	ies = rcu_dereference(cbss->ies);
+	if (!ies)
+		return false;
+
+	elem = cfg80211_find_ext_elem(WLAN_EID_EXT_HE_OPERATION, ies->data,
+				      ies->len);
+	if (!elem || elem->datalen < sizeof(*he_operation) + 1 ||
+	    elem->datalen < ieee80211_he_oper_size(elem->data + 1))
+		return false;
+
+	he_operation = (const struct ieee80211_he_operation *)(elem->data + 1);
+
+	/* As this is a workaround to allow connection to Wi-Fi 6E APs, check
+	 * only for HE operation and do not check EHT operation.
+	 */
+	ret = ieee80211_chandef_he_6ghz_oper(sdata->local, he_operation, NULL,
+					     chandef);
+	if (ret)
+		sdata_info(sdata,
+			   "Using HE 6 GHz operation information from BSS elems\n");
+
+	return ret;
+}
+
 static enum ieee80211_conn_mode
 ieee80211_determine_ap_chan(struct ieee80211_sub_if_data *sdata,
 			    struct ieee80211_channel *channel,
@@ -156,7 +195,8 @@ ieee80211_determine_ap_chan(struct ieee80211_sub_if_data *sdata,
 			    const struct ieee802_11_elems *elems,
 			    bool ignore_ht_channel_mismatch,
 			    const struct ieee80211_conn_settings *conn,
-			    struct cfg80211_chan_def *chandef)
+			    struct cfg80211_chan_def *chandef,
+			    struct cfg80211_bss *cbss)
 {
 	const struct ieee80211_ht_operation *ht_oper = elems->ht_operation;
 	const struct ieee80211_vht_operation *vht_oper = elems->vht_operation;
@@ -212,7 +252,20 @@ ieee80211_determine_ap_chan(struct ieee80211_sub_if_data *sdata,
 		if (!ieee80211_chandef_he_6ghz_oper(sdata->local, he_oper,
 						    eht_oper, chandef)) {
 			sdata_info(sdata, "bad HE/EHT 6 GHz operation\n");
-			return IEEE80211_CONN_MODE_LEGACY;
+
+			/* Some APs, e.g. some versions of Aruba AP-635,
+			 * advertise bad HE operation in their association
+			 * response. In such cases, try to use the HE operation
+			 * from beacon/probe response if possible.
+			 */
+			if (!ieee80211_chandef_he_6ghz_oper_bss(sdata, cbss,
+								chandef))
+				return IEEE80211_CONN_MODE_LEGACY;
+
+			/* The above check verifies only HE operation, and
+			 * doesn't check EHT operation, thus set the mode to HE.
+			 */
+			return IEEE80211_CONN_MODE_HE;
 		}
 
 		return mode;
@@ -1017,7 +1070,8 @@ ieee80211_determine_chan_mode(struct ieee80211_sub_if_data *sdata,
 		return ERR_PTR(-ENOMEM);
 
 	ap_mode = ieee80211_determine_ap_chan(sdata, channel, bss->vht_cap_info,
-					      elems, false, conn, ap_chandef);
+					      elems, false, conn, ap_chandef,
+					      cbss);
 
 	/* this should be impossible since parsing depends on our mode */
 	if (WARN_ON(ap_mode > conn->mode)) {
@@ -1231,7 +1285,8 @@ EXPORT_SYMBOL_IF_MAC80211_KUNIT(ieee80211_determine_chan_mode);
 
 static int ieee80211_config_bw(struct ieee80211_link_data *link,
 			       struct ieee802_11_elems *elems,
-			       bool update, u64 *changed, u16 stype)
+			       bool update, u64 *changed, u16 stype,
+			       struct cfg80211_bss *cbss)
 {
 	struct ieee80211_channel *channel = link->conf->chanreq.oper.chan;
 	struct ieee80211_sub_if_data *sdata = link->sdata;
@@ -1271,7 +1326,7 @@ static int ieee80211_config_bw(struct ieee80211_link_data *link,
 
 	ap_mode = ieee80211_determine_ap_chan(sdata, channel, vht_cap_info,
 					      elems, true, &link->u.mgd.conn,
-					      &ap_chandef);
+					      &ap_chandef, cbss);
 
 	if (ap_mode != link->u.mgd.conn.mode) {
 		link_info(link,
@@ -5396,7 +5451,7 @@ static bool ieee80211_assoc_config_link(struct ieee80211_link_data *link,
 				link_id == assoc_data->assoc_link_id,
 				changed,
 				le16_to_cpu(mgmt->frame_control) &
-					IEEE80211_FCTL_STYPE)) {
+					IEEE80211_FCTL_STYPE, cbss)) {
 		ret = false;
 		goto out;
 	}
@@ -7628,7 +7683,7 @@ static void ieee80211_rx_mgmt_beacon(struct ieee80211_link_data *link,
 	changed |= ieee80211_recalc_twt_req(sdata, sband, link, link_sta, elems);
 
 	if (ieee80211_config_bw(link, elems, true, &changed,
-				IEEE80211_STYPE_BEACON)) {
+				IEEE80211_STYPE_BEACON, NULL)) {
 		ieee80211_set_disassoc(sdata, IEEE80211_STYPE_DEAUTH,
 				       WLAN_REASON_DEAUTH_LEAVING,
 				       true, deauth_buf);
-- 
2.34.1


