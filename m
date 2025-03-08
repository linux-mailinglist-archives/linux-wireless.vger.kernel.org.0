Return-Path: <linux-wireless+bounces-20032-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 661AEA57E58
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Mar 2025 22:06:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCD92188DA9E
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Mar 2025 21:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E9951A4E9D;
	Sat,  8 Mar 2025 21:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lUKo3vLb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67E41EDA00
	for <linux-wireless@vger.kernel.org>; Sat,  8 Mar 2025 21:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741467987; cv=none; b=o15EgVUuNyNT7gdGk/vXulIudsfFVlG4GP1qea5pZkOWAbehHgFwx8rulREJKrMzfI389xcCXtNWaUUruuTkFLlCjkyDwnLatvNBN1NI6G6Fx/hAzupmgrC6h37AMczoA8QQ7/o+GVYRA5RuEvj1kYLxgLCK+ouBUbLkuGeAsDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741467987; c=relaxed/simple;
	bh=kdBYZdaB8/26drJFity98xmPQnxsQqiq068PnVbHqac=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FUQyagchgAtLQcBpkRcjGNxzRU3RKcgh35zQw4yvK5RF9ltHxoXM9mmhUBk4hA4RB6rTK3qWG0TZBxaA/ZAGzZaEvDNSIZt+qmsKmGwp1+uLLF8RjAWj9xBSp2vDFEA3CO6D79L5q5Fm5hFkJI3ooLpT5MUbfxPIPgCMPCaMfcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lUKo3vLb; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741467986; x=1773003986;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kdBYZdaB8/26drJFity98xmPQnxsQqiq068PnVbHqac=;
  b=lUKo3vLbSWmKXvH5hMNSce2aPLjpa61fSwBiU7yzxo41NZSXk4CBFgMJ
   FKD9AyZrYDdvxBRYxvZVRAFK9RG56o2fECSb0/O3AFB4Ghm5i6LAcflZr
   7k+gem/JGCi1GTSC0+4UGMu3sjpBpJ4qK5huVpI9A5qSOEnx+6b8hi3mz
   NfIjuJsWYNXn7SWJJ7mE4TP+AhiVJ438uHYRXxZ09EYx/YZTpYAce03/u
   Lfrohe6QbBRkjvdaGZ46SE4smP8pikpgufGxIjzJNeKeL6G+P/0mabeQD
   O95pgkeBcRon/YuzWncMtpDpOgNowD8SO2dyOXGr4t4EWS17HykY5SnWM
   A==;
X-CSE-ConnectionGUID: N1IAg9ASSjK7dPJmv/GIqg==
X-CSE-MsgGUID: KQvsV4S1TxiQDbM9xjOxXA==
X-IronPort-AV: E=McAfee;i="6700,10204,11367"; a="42413041"
X-IronPort-AV: E=Sophos;i="6.14,233,1736841600"; 
   d="scan'208";a="42413041"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2025 13:03:58 -0800
X-CSE-ConnectionGUID: gEAuHhTMTb+XsM3Motn7Jg==
X-CSE-MsgGUID: Drkt7a3KTtePDZShnLPWTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,233,1736841600"; 
   d="scan'208";a="124644361"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2025 13:03:57 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH RESEND wireless-next 03/15] wifi: mac80211: mlme: support extended MLD capa/ops in assoc
Date: Sat,  8 Mar 2025 23:03:29 +0200
Message-Id: <20250308225541.2e555beb0a76.I623f59023b47ec202fc0c7520f2b5f575b439927@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250308210341.2302222-1-miriam.rachel.korenblit@intel.com>
References: <20250308210341.2302222-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Support passing the value from userspace on to the AP in the
association and ML link reconfiguration requests. We may need
to also add a driver value to or in with the field, but for
now have no feature that is controlled by the driver.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 net/mac80211/ieee80211_i.h |  2 ++
 net/mac80211/mlme.c        | 32 ++++++++++++++++++++++++++++++--
 2 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index 5f92619f8584..a36563a07b3b 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -462,6 +462,8 @@ struct ieee80211_mgd_assoc_data {
 
 	unsigned int assoc_link_id;
 
+	__le16 ext_mld_capa_ops;
+
 	u8 fils_nonces[2 * FILS_NONCE_LEN];
 	u8 fils_kek[FILS_MAX_KEK_LEN];
 	size_t fils_kek_len;
diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 613959f19713..87ebeec2877d 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -1943,6 +1943,21 @@ ieee80211_assoc_add_ml_elem(struct ieee80211_sub_if_data *sdata,
 	}
 	skb_put_data(skb, &mld_capa_ops, sizeof(mld_capa_ops));
 
+	/* Many APs have broken parsing of the extended MLD capa/ops field,
+	 * dropping (re-)association request frames or replying with association
+	 * response with a failure status if it's present. Without a clear
+	 * indication as to whether the AP supports parsing this field or not do
+	 * not include it in the common information unless strict mode is set.
+	 */
+	if (ieee80211_hw_check(&local->hw, STRICT) &&
+	    assoc_data->ext_mld_capa_ops) {
+		ml_elem->control |=
+			cpu_to_le16(IEEE80211_MLC_BASIC_PRES_EXT_MLD_CAPA_OP);
+		common->len += 2;
+		skb_put_data(skb, &assoc_data->ext_mld_capa_ops,
+			     sizeof(assoc_data->ext_mld_capa_ops));
+	}
+
 	for (link_id = 0; link_id < IEEE80211_MLD_MAX_NUM_LINKS; link_id++) {
 		u16 link_present_elems[PRESENT_ELEMS_MAX] = {};
 		const u8 *extra_elems;
@@ -2112,6 +2127,7 @@ static int ieee80211_send_assoc(struct ieee80211_sub_if_data *sdata)
 		/* max common info field in basic multi-link element */
 		size += sizeof(struct ieee80211_mle_basic_common_info) +
 			2 + /* capa & op */
+			2 + /* ext capa & op */
 			2; /* EML capa */
 
 		/*
@@ -9366,6 +9382,8 @@ int ieee80211_mgd_assoc(struct ieee80211_sub_if_data *sdata,
 	else
 		memcpy(assoc_data->ap_addr, cbss->bssid, ETH_ALEN);
 
+	assoc_data->ext_mld_capa_ops = cpu_to_le16(req->ext_mld_capa_ops);
+
 	if (ifmgd->associated) {
 		u8 frame_buf[IEEE80211_DEAUTH_FRAME_LEN];
 
@@ -10136,7 +10154,7 @@ void ieee80211_process_ml_reconf_resp(struct ieee80211_sub_if_data *sdata,
 static struct sk_buff *
 ieee80211_build_ml_reconf_req(struct ieee80211_sub_if_data *sdata,
 			      struct ieee80211_mgd_assoc_data *add_links_data,
-			      u16 removed_links)
+			      u16 removed_links, __le16 ext_mld_capa_ops)
 {
 	struct ieee80211_local *local = sdata->local;
 	struct ieee80211_mgmt *mgmt;
@@ -10185,6 +10203,9 @@ ieee80211_build_ml_reconf_req(struct ieee80211_sub_if_data *sdata,
 			var_common_size += 2;
 	}
 
+	if (ext_mld_capa_ops)
+		var_common_size += 2;
+
 	/* Add the common information length */
 	size += common_size + var_common_size;
 
@@ -10269,6 +10290,12 @@ ieee80211_build_ml_reconf_req(struct ieee80211_sub_if_data *sdata,
 		skb_put_data(skb, &mld_capa_ops, sizeof(mld_capa_ops));
 	}
 
+	if (ext_mld_capa_ops) {
+		ml_elem->control |=
+			cpu_to_le16(IEEE80211_MLC_RECONF_PRES_EXT_MLD_CAPA_OP);
+		skb_put_data(skb, &ext_mld_capa_ops, sizeof(ext_mld_capa_ops));
+	}
+
 	if (sdata->u.mgd.flags & IEEE80211_STA_ENABLE_RRM)
 		capab |= WLAN_CAPABILITY_RADIO_MEASURE;
 
@@ -10535,7 +10562,8 @@ int ieee80211_mgd_assoc_ml_reconf(struct ieee80211_sub_if_data *sdata,
 	 * is expected to send the ML reconfiguration response frame on the link
 	 * on which the request was received.
 	 */
-	skb = ieee80211_build_ml_reconf_req(sdata, data, req->rem_links);
+	skb = ieee80211_build_ml_reconf_req(sdata, data, req->rem_links,
+					    cpu_to_le16(req->ext_mld_capa_ops));
 	if (!skb) {
 		err = -ENOMEM;
 		goto err_free;
-- 
2.34.1


