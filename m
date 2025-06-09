Return-Path: <linux-wireless+bounces-23888-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 68E78AD25B9
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jun 2025 20:36:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 778047A28AB
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Jun 2025 18:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 426461F4608;
	Mon,  9 Jun 2025 18:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HzDMOCL7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66D421D599
	for <linux-wireless@vger.kernel.org>; Mon,  9 Jun 2025 18:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749494163; cv=none; b=VcdHM9xWsbkK+LgmPz+E9OALZT8rmlrAXh+yiWfHCYb0dIL7Ln9M3JCrm4YzXk4Cs+NOkUG8Gwk5/bfEBf3R+IcuHZ3WfBdheZ7RyZfsUD210P86OeORfVxd43rOsE0YiB36x/7QnJcAMLUb0aAk0SMYnyKjHgYrvEj82z9lny0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749494163; c=relaxed/simple;
	bh=CLua36i9Wmsx88bRBnnkuRRJ0OlUTRO8GmCqHBCVREQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NQvN2F0ZsHmaO/valsF3Ee+iTLRLYx3aVBSYEbxydsm5x9kkZIwbp7L1jegwrRz9Zuo+Nl8wcHyZwLrL+Gl7FA2u5kLunVjqvHc6JnGfclO16zWWKK4mSBVivUYtCrcpjEwIZFTZXGnOo6fk9SIdrK/IaEWIPUDuBwPeqrZsNLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HzDMOCL7; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749494161; x=1781030161;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CLua36i9Wmsx88bRBnnkuRRJ0OlUTRO8GmCqHBCVREQ=;
  b=HzDMOCL7474EGsEyhRFqtfDWnzPBFoEpGgmC+qI9VGOWza4paJGAYxhy
   PyVgv7gO1Pq9ZDQmPqH7nE8Mokxfd5UZp/ZlqgT3WKIyJSllzskAg9jl2
   2mX/MouO94JA1cc2IYj8u9x9tsczQcl1dpsHTF4uBrV0T0ZUMY92NCuSW
   YcACb1tdFOlEkt0gfaU3AqgOmK3XCBjDqv143reY7J9P70umB+mae+2Nl
   /SU/5pusJ6qv2/S3TMWjtoeq0sjroeZVaTTJRxn/QzhUK/HEX05blqxKF
   78zDW15kSTOKRxet74cUqP+OU8JQamPm4wpj3UPlMcx72rnWV/jOiaFoe
   A==;
X-CSE-ConnectionGUID: SQzy1uB7SgW432orn1QbMQ==
X-CSE-MsgGUID: LjiREFJoT22Afs/yFawe/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11459"; a="55249778"
X-IronPort-AV: E=Sophos;i="6.16,223,1744095600"; 
   d="scan'208";a="55249778"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 11:36:01 -0700
X-CSE-ConnectionGUID: f5xYBevRSz+h0RGOTf8fhw==
X-CSE-MsgGUID: Idlg+1hvTraIDRvsXrAgeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,223,1744095600"; 
   d="scan'208";a="151732548"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 11:36:00 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH wireless-next 13/15] wifi: mac80211: send extended MLD capa/ops if AP has it
Date: Mon,  9 Jun 2025 21:35:25 +0300
Message-Id: <20250609213232.c9b8b3a6ca77.I1153d4283d1fbb9e5db60e7b939cc133a6345db5@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250609183527.3974138-1-miriam.rachel.korenblit@intel.com>
References: <20250609183527.3974138-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Currently the code only sends extended MLD capa/ops in
strict mode, but if the AP has it then it should also
be able to parse it. There could be cases where the AP
doesn't have it but we would want to advertise it (e.g.
if the AP supports nothing but we want to have BTM.),
but given the broken deployed APs out there right now
this is the best we can do.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/mlme.c | 54 +++++++++++++++++++++++++++++++++++++--------
 1 file changed, 45 insertions(+), 9 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 85f1d101fea3..d18a7a7e33c3 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -1939,14 +1939,7 @@ ieee80211_assoc_add_ml_elem(struct ieee80211_sub_if_data *sdata,
 	}
 	skb_put_data(skb, &mld_capa_ops, sizeof(mld_capa_ops));
 
-	/* Many APs have broken parsing of the extended MLD capa/ops field,
-	 * dropping (re-)association request frames or replying with association
-	 * response with a failure status if it's present. Without a clear
-	 * indication as to whether the AP supports parsing this field or not do
-	 * not include it in the common information unless strict mode is set.
-	 */
-	if (ieee80211_hw_check(&local->hw, STRICT) &&
-	    assoc_data->ext_mld_capa_ops) {
+	if (assoc_data->ext_mld_capa_ops) {
 		ml_elem->control |=
 			cpu_to_le16(IEEE80211_MLC_BASIC_PRES_EXT_MLD_CAPA_OP);
 		common->len += 2;
@@ -9353,6 +9346,39 @@ ieee80211_mgd_get_ap_ht_vht_capa(struct ieee80211_sub_if_data *sdata,
 	return err;
 }
 
+static bool
+ieee80211_mgd_assoc_bss_has_mld_ext_capa_ops(struct cfg80211_assoc_request *req)
+{
+	const struct cfg80211_bss_ies *ies;
+	struct cfg80211_bss *bss;
+	const struct element *ml;
+
+	/* not an MLO connection if link_id < 0, so irrelevant */
+	if (req->link_id < 0)
+		return false;
+
+	bss = req->links[req->link_id].bss;
+
+	guard(rcu)();
+	ies = rcu_dereference(bss->ies);
+	for_each_element_extid(ml, WLAN_EID_EXT_EHT_MULTI_LINK,
+			       ies->data, ies->len) {
+		const struct ieee80211_multi_link_elem *mle;
+
+		if (!ieee80211_mle_type_ok(ml->data + 1,
+					   IEEE80211_ML_CONTROL_TYPE_BASIC,
+					   ml->datalen - 1))
+			continue;
+
+		mle = (void *)(ml->data + 1);
+		if (mle->control & cpu_to_le16(IEEE80211_MLC_BASIC_PRES_EXT_MLD_CAPA_OP))
+			return true;
+	}
+
+	return false;
+
+}
+
 int ieee80211_mgd_assoc(struct ieee80211_sub_if_data *sdata,
 			struct cfg80211_assoc_request *req)
 {
@@ -9405,7 +9431,17 @@ int ieee80211_mgd_assoc(struct ieee80211_sub_if_data *sdata,
 	else
 		memcpy(assoc_data->ap_addr, cbss->bssid, ETH_ALEN);
 
-	assoc_data->ext_mld_capa_ops = cpu_to_le16(req->ext_mld_capa_ops);
+	/*
+	 * Many APs have broken parsing of the extended MLD capa/ops field,
+	 * dropping (re-)association request frames or replying with association
+	 * response with a failure status if it's present.
+	 * Set our value from the userspace request only in strict mode or if
+	 * the AP also had that field present.
+	 */
+	if (ieee80211_hw_check(&local->hw, STRICT) ||
+	    ieee80211_mgd_assoc_bss_has_mld_ext_capa_ops(req))
+		assoc_data->ext_mld_capa_ops =
+			cpu_to_le16(req->ext_mld_capa_ops);
 
 	if (ifmgd->associated) {
 		u8 frame_buf[IEEE80211_DEAUTH_FRAME_LEN];
-- 
2.34.1


