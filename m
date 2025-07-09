Return-Path: <linux-wireless+bounces-25140-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 487D6AFF32D
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 22:39:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 998E85840D9
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 20:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 719D1253F1B;
	Wed,  9 Jul 2025 20:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N+z9pdrS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D9B2528E1
	for <linux-wireless@vger.kernel.org>; Wed,  9 Jul 2025 20:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752093519; cv=none; b=r10tH0oji9dYgmNI4/QEzmG6w1kTCCOJYWGqEimIHSHNiHkvhy7fFCRhixkz59BU9lBGz7RUcxVMfXdGqJWE5FaEs71gO0qXga7m6/7hr+kqi/wDk4z5S6FfGY0ELShcpipG/KvD5MvZH9uoqM+6gQyqJig3d6jBgjqSqJ5gVPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752093519; c=relaxed/simple;
	bh=7FwsIBETJjRHxDxLPEhTkeVicyFG4S1790oYA9ybUL8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gcSARbEGsMYdsplecEVrt2XmDYo1j+GES0l4R06yGtE9f8Iq97jHc8ICdePd8vhDO8w5VFrBWv32QpC3Y78++qWt2ZuRVRglDRtjbtds3UrLFaYQ40RDIi2LwNX9zPaeyRHRQPb0WfbR1Tkpse9J4wPWh3NniMiC+zDYeHZgHLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N+z9pdrS; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752093517; x=1783629517;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7FwsIBETJjRHxDxLPEhTkeVicyFG4S1790oYA9ybUL8=;
  b=N+z9pdrSQ5fwc+dW/Nvl8O3dO4P6LdLDdt8/TR2/EijDu3Qzy2I/nxED
   3UodXB2g9pHqDsCaJwLnubV2lmjeqYwyCGuIy2c3FrX6DvGb7gE3Z7rPL
   1UE+M4yxbZ2sya3H7FzujBkecX3PS+L0QeQgF7gmBMGvoEsb3vTErYX4E
   EBM9KaH3/Jc5FDRuuz7EgnSHFJVyHqPWCT8SJ66MnK0+LdQoD8aKVmmWf
   QaGmlg0k0MrEbnA104KbZE3dvj2PwqYAF+GxxBcyLoFV24ul1I9GRxVPT
   nKXqEi8mM9nRl9rjb7PgMlCKuwdShrXZ1nvZWS+O+4JNpMKvaKeWUWKWu
   Q==;
X-CSE-ConnectionGUID: d8CCv70gSKSGeHSVMt/dfA==
X-CSE-MsgGUID: OOvGJpraRLGBBdsQ8fNcvA==
X-IronPort-AV: E=McAfee;i="6800,10657,11489"; a="56974461"
X-IronPort-AV: E=Sophos;i="6.16,299,1744095600"; 
   d="scan'208";a="56974461"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 13:38:37 -0700
X-CSE-ConnectionGUID: rA63X6q6Qg68XYB+WQ61dA==
X-CSE-MsgGUID: g/BnltKASLig/2JGVA8Z1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,299,1744095600"; 
   d="scan'208";a="161533254"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 13:38:37 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH wireless-next 11/11] wifi: mac80211: don't use TPE data from assoc response
Date: Wed,  9 Jul 2025 23:38:03 +0300
Message-Id: <20250709233537.caa1ca853f5a.I588271f386731978163aa9d84ae75d6f79633e16@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250709203803.1736809-1-miriam.rachel.korenblit@intel.com>
References: <20250709203803.1736809-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Since there's no TPE element in the (re)assoc response, trying
to use the data from it just leads to using the defaults, even
though the real values had been set during authentication from
the discovered BSS information.

Fix this by simply not handling the TPE data in assoc response
since it's not intended to be present, if it changes later the
necessary changes will be made by tracking beacons later.

As a side effect, by passing the real frame subtype, now print
a correct value for ML reconfiguration responses.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/mlme.c | 33 ++++++++++++++++++++++++++++-----
 1 file changed, 28 insertions(+), 5 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index d64b09d07db3..2dc97b0095d3 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -1214,18 +1214,36 @@ EXPORT_SYMBOL_IF_MAC80211_KUNIT(ieee80211_determine_chan_mode);
 
 static int ieee80211_config_bw(struct ieee80211_link_data *link,
 			       struct ieee802_11_elems *elems,
-			       bool update, u64 *changed,
-			       const char *frame)
+			       bool update, u64 *changed, u16 stype)
 {
 	struct ieee80211_channel *channel = link->conf->chanreq.oper.chan;
 	struct ieee80211_sub_if_data *sdata = link->sdata;
 	struct ieee80211_chan_req chanreq = {};
 	struct cfg80211_chan_def ap_chandef;
 	enum ieee80211_conn_mode ap_mode;
+	const char *frame;
 	u32 vht_cap_info = 0;
 	u16 ht_opmode;
 	int ret;
 
+	switch (stype) {
+	case IEEE80211_STYPE_BEACON:
+		frame = "beacon";
+		break;
+	case IEEE80211_STYPE_ASSOC_RESP:
+		frame = "assoc response";
+		break;
+	case IEEE80211_STYPE_REASSOC_RESP:
+		frame = "reassoc response";
+		break;
+	case IEEE80211_STYPE_ACTION:
+		/* the only action frame that gets here */
+		frame = "ML reconf response";
+		break;
+	default:
+		return -EINVAL;
+	}
+
 	/* don't track any bandwidth changes in legacy/S1G modes */
 	if (link->u.mgd.conn.mode == IEEE80211_CONN_MODE_LEGACY ||
 	    link->u.mgd.conn.mode == IEEE80211_CONN_MODE_S1G)
@@ -1274,7 +1292,9 @@ static int ieee80211_config_bw(struct ieee80211_link_data *link,
 			ieee80211_min_bw_limit_from_chandef(&chanreq.oper))
 		ieee80211_chandef_downgrade(&chanreq.oper, NULL);
 
-	if (ap_chandef.chan->band == NL80211_BAND_6GHZ &&
+	/* TPE element is not present in (re)assoc/ML reconfig response */
+	if (stype == IEEE80211_STYPE_BEACON &&
+	    ap_chandef.chan->band == NL80211_BAND_6GHZ &&
 	    link->u.mgd.conn.mode >= IEEE80211_CONN_MODE_HE) {
 		ieee80211_rearrange_tpe(&elems->tpe, &ap_chandef,
 					&chanreq.oper);
@@ -5345,7 +5365,9 @@ static bool ieee80211_assoc_config_link(struct ieee80211_link_data *link,
 	/* check/update if AP changed anything in assoc response vs. scan */
 	if (ieee80211_config_bw(link, elems,
 				link_id == assoc_data->assoc_link_id,
-				changed, "assoc response")) {
+				changed,
+				le16_to_cpu(mgmt->frame_control) &
+					IEEE80211_FCTL_STYPE)) {
 		ret = false;
 		goto out;
 	}
@@ -7537,7 +7559,8 @@ static void ieee80211_rx_mgmt_beacon(struct ieee80211_link_data *link,
 
 	changed |= ieee80211_recalc_twt_req(sdata, sband, link, link_sta, elems);
 
-	if (ieee80211_config_bw(link, elems, true, &changed, "beacon")) {
+	if (ieee80211_config_bw(link, elems, true, &changed,
+				IEEE80211_STYPE_BEACON)) {
 		ieee80211_set_disassoc(sdata, IEEE80211_STYPE_DEAUTH,
 				       WLAN_REASON_DEAUTH_LEAVING,
 				       true, deauth_buf);
-- 
2.34.1


