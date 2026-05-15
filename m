Return-Path: <linux-wireless+bounces-36470-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8F/wMsgRB2rgrQIAu9opvQ
	(envelope-from <linux-wireless+bounces-36470-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 14:30:00 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 644F454F909
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 14:30:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3128E30FC174
	for <lists+linux-wireless@lfdr.de>; Fri, 15 May 2026 12:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C736B47DD78;
	Fri, 15 May 2026 12:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LVENvc+d"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B43C47A0DB
	for <linux-wireless@vger.kernel.org>; Fri, 15 May 2026 12:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778847011; cv=none; b=ETFTIz7ziSR20mh5J4oagAOQbhxlEVRchZNnRWDYy07LWyMEZSCxLBcfaQYwRpDKrf8WQO8X4a8YoDQRI+1EsvXY8vnkseRRNBYoMq/8m14L8hTkWwITo8taabthqqiQDA8k1x2vjlM+FqAvwDn7Q26Y/cWGwvkL2DUr81TsVf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778847011; c=relaxed/simple;
	bh=MOMSGsUKE/V14OVBYqOisjpq3d0GZt0evwYyAMwsEgo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LEeKutdyeVXwtVKxmQBmB5Z6N3SifTHv0v5Xitx7uH/gdUxmlZmuJG/mrqp9I0AzluNTlv2EK5sBSFhWvJQY2IaSXxKNe/7J4d0NG4hsKPYZihb32kQRZzUZZ+3qxX1oCEqTbQDlbl+P6Fuvt8jKTUx7N/fA4N79RBxXdIXeUgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LVENvc+d; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778847010; x=1810383010;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MOMSGsUKE/V14OVBYqOisjpq3d0GZt0evwYyAMwsEgo=;
  b=LVENvc+d4Mcu7RhrXMDi5S7xfvPE5M8+ASB573dVBf1wIVhWgzxpTS0h
   WbbbzxcI6tKPz8668eZBPIWk7YngxH4cH3VajiuYoZnopGVOyqmQVvC45
   DRkSq+XS10mmX5LBI2eoxoIeSuURSohgClDWAEwj5oQfaZxj9rJBMjuQv
   x2+e7Q/kXWwpsK0roh1914Aziwy6clYfCpzUvsij65ED2dt3kHS6kGP+r
   aQ60K70SGsqs1moV2srN3tPEoFtgrtkLcerxPxgsBZjFnFHM659EMGpfK
   bZZfGkhDDD1xSLDN3ctEVFe9ir5n/TUW5/JOZ0aCnXX0rWNSTVSf9gZt6
   g==;
X-CSE-ConnectionGUID: SBdH3l6tRtq7cZUev5mUBw==
X-CSE-MsgGUID: yq3VBoQYSyiyfOgsmLgQZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11786"; a="91185675"
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="91185675"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 05:10:10 -0700
X-CSE-ConnectionGUID: tYV6hC92T4eVF8zlFaOM3w==
X-CSE-MsgGUID: pNTGIHR0Rzie8YmhsGHUvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,236,1770624000"; 
   d="scan'208";a="243649991"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2026 05:10:09 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v2 iwlwifi-next 05/15] wifi: iwlwifi: mld: evacuate NAN channels on link switch
Date: Fri, 15 May 2026 15:09:38 +0300
Message-Id: <20260515150751.a193c0f41b1f.I1d56c8d8d61d110422271971843b71a93f5ec354@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260515120948.1157329-1-miriam.rachel.korenblit@intel.com>
References: <20260515120948.1157329-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 644F454F909
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-36470-lists,linux-wireless=lfdr.de];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

The FW API doesn't allow a station (of certain types, including
STATION_TYPE_PEER) to not be correlated to any link. Therefore,
when switching links, mac80211 first adds the new link and then
removes the old one.

In case we have a NAN interface that operates on 3 links and a
BSS interface that operates on the 4th link, there won't be any
room to perform a link switch that temporarily needs two links
for the BSS interface, but the firmware only has four total.

To mitigate this, try to evacuate a NAN channel in this scenario:
First try to evacuate a NAN channel using the same phy as the BSS
link being deactivated, since we expect NAN to follow the BSS
channel configuration. If that doesn't work, try to evacuate any
NAN channel.

Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/mld/mac80211.c | 95 ++++++++++++++++++-
 1 file changed, 94 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
index 9dc540720ecd..92858b8f7395 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
@@ -2585,15 +2585,108 @@ iwl_mld_mac80211_mgd_protect_tdls_discover(struct ieee80211_hw *hw,
 			ret);
 }
 
+static int iwl_mld_count_free_link_ids(struct iwl_mld *mld)
+{
+	int free_count = 0;
+
+	for (int i = 0; i < mld->fw->ucode_capa.num_links; i++) {
+		if (!rcu_access_pointer(mld->fw_id_to_bss_conf[i]))
+			free_count++;
+	}
+
+	return free_count;
+}
+
+static bool
+iwl_mld_chanctx_used_by_other_vif(struct ieee80211_hw *hw,
+				  struct ieee80211_vif *vif,
+				  struct ieee80211_chanctx_conf *chanctx_conf)
+{
+	struct ieee80211_bss_conf *iter_link;
+	struct ieee80211_vif *iter_vif;
+	int link_id;
+
+	for_each_active_interface(iter_vif, hw) {
+		if (vif == iter_vif)
+			continue;
+
+		/* NAN doesn't have active links, so we don't count NAN users */
+		for_each_vif_active_link(iter_vif, iter_link, link_id) {
+			if (rcu_access_pointer(iter_link->chanctx_conf) ==
+			    chanctx_conf)
+				return true;
+		}
+	}
+
+	return false;
+}
+
 static bool iwl_mld_can_activate_links(struct ieee80211_hw *hw,
 				       struct ieee80211_vif *vif,
 				       u16 desired_links)
 {
 	struct iwl_mld *mld = IWL_MAC80211_GET_MLD(hw);
 	int n_links = hweight16(desired_links);
+	int n_add = hweight16(desired_links & ~vif->active_links);
+	unsigned long to_deactivate = vif->active_links & ~desired_links;
+	int free_link_ids;
+	int i;
 
 	/* Check if HW supports the wanted number of links */
-	return n_links <= iwl_mld_max_active_links(mld, vif);
+	if (n_links > iwl_mld_max_active_links(mld, vif))
+		return false;
+
+	/*
+	 * During link switch, mac80211 first adds the new links, then removes
+	 * the old ones. This means we temporarily need extra link objects
+	 * during the transition. Check if we have enough free link IDs.
+	 */
+
+	free_link_ids = iwl_mld_count_free_link_ids(mld);
+
+	if (free_link_ids >= n_add)
+		return true;
+
+	if (!mld->nan_device_vif)
+		return false;
+
+	/*
+	 * Not enough free link IDs. First try to evacuate NAN from the
+	 * channel context of a link that is going to be deactivated.
+	 */
+	for_each_set_bit(i, &to_deactivate, IEEE80211_MLD_MAX_NUM_LINKS) {
+		struct ieee80211_bss_conf *link_conf;
+		struct ieee80211_chanctx_conf *chanctx_conf;
+
+		link_conf = link_conf_dereference_protected(vif, i);
+		if (!link_conf)
+			continue;
+
+		chanctx_conf = wiphy_dereference(mld->wiphy, link_conf->chanctx_conf);
+		if (!chanctx_conf)
+			continue;
+
+		if (iwl_mld_chanctx_used_by_other_vif(hw, vif, chanctx_conf))
+			continue;
+
+		if (ieee80211_nan_try_evacuate(hw, chanctx_conf)) {
+			free_link_ids = iwl_mld_count_free_link_ids(mld);
+			/*
+			 * Evacuation of one channel should do the job. If not,
+			 * something bad is happening. Don't try to evacuate more
+			 */
+			return free_link_ids >= n_add;
+		}
+	}
+
+	/* Couldn't find/evacuate any channel going to go unused, try any */
+	if (ieee80211_nan_try_evacuate(hw, NULL)) {
+		free_link_ids = iwl_mld_count_free_link_ids(mld);
+		if (free_link_ids >= n_add)
+			return true;
+	}
+
+	return false;
 }
 
 static int
-- 
2.34.1


