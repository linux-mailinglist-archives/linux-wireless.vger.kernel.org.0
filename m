Return-Path: <linux-wireless+bounces-33636-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kI23EeXVvmlwewMAu9opvQ
	(envelope-from <linux-wireless+bounces-33636-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Mar 2026 18:31:17 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C252E68CF
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Mar 2026 18:31:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F1490302EE8C
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Mar 2026 17:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA6B317171;
	Sat, 21 Mar 2026 17:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c8oMGo/0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380F4339705
	for <linux-wireless@vger.kernel.org>; Sat, 21 Mar 2026 17:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774114186; cv=none; b=gi5C1das6rV6znW2lxCrmmJb5YQzQmkgvh/e9HuzvK0CGflPOfJ5+dBHB8fFiZ7w1dWSyp1WPQcCe4RRA/WDmtZCziyIFW/eHwi4edLIr4SVmOnWMxTvNAbw0J3hrNESaF7m5nKuOsgXcKu36WJzBcuEu+vX8YGaOgSA73h1DQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774114186; c=relaxed/simple;
	bh=k3IinWBObC/5v1ac+rlOCjo63Te3/wcrWS2TeHfLRtM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gDgEZPYL2FcIKiihlV8IntZx5AO8qaf2AZlbKQ3NIfHa2wghp05XcvYlV/ZGmqSN4Nbx460VXJgkly/V3PAPZNriKBAdMQt41lKKgcOzJgPNrnoo1qyO/vlNR3ZmfSQScS68pomA0gkOc+Z7LPMzZpdplVy1Hpk17L/WkEqI9wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c8oMGo/0; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774114185; x=1805650185;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=k3IinWBObC/5v1ac+rlOCjo63Te3/wcrWS2TeHfLRtM=;
  b=c8oMGo/0k+UNeR/F+P/GLKTkF1OQdeT0JtWfjEKHIdz8m0FLgIC0WVE8
   i6ExoabzID+segsRt3LdDDx/da6Ilep+7uKyAerlA5UVy/R25kv9MdXvc
   b4hadhu2JOL3rqtwLPCQtvzQClXkVyK+w10slrQ2LlVpXiCDbIsgdNNbo
   jgqiWGtiZAg2FGlYlq6aommZupMG4y8Q+q7Cf1Dzbo3rzMANpJRCBkD3e
   LM7hr+d9pJy2kvvsM5DWiF2zeCmnlFBSKeti0tTzl42IH+DmEKmXoYsNi
   sautGmRY0w3FIKpJFT5CmHn7OzkJLq3+KN2ZeVCkpw4BffdUGIpbp90rA
   g==;
X-CSE-ConnectionGUID: 79N0EICtTayRE3Ao6BF7Aw==
X-CSE-MsgGUID: ADm7ns7QStWjIPJlkURWhA==
X-IronPort-AV: E=McAfee;i="6800,10657,11736"; a="75244593"
X-IronPort-AV: E=Sophos;i="6.23,133,1770624000"; 
   d="scan'208";a="75244593"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2026 10:29:45 -0700
X-CSE-ConnectionGUID: 8RfwFIePT6GavWclXBsXFA==
X-CSE-MsgGUID: y7+2ZeuMTcGeIR+C2KtFyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,133,1770624000"; 
   d="scan'208";a="223813596"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2026 10:29:44 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Subject: [PATCH iwlwifi-next 09/15] wifi: iwlwifi: mld: update the TLC when we deactivate a link
Date: Sat, 21 Mar 2026 19:29:16 +0200
Message-Id: <20260321192637.317c66b11a31.I591118fa376ed967c0d1a47058c13834bc94605e@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260321172922.3938740-1-miriam.rachel.korenblit@intel.com>
References: <20260321172922.3938740-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-33636-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:dkim,intel.com:email]
X-Rspamd-Queue-Id: C1C252E68CF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

We hit a problem in the channel switch flow.
We had link 0 using PHY 0, so the TLC object in the firmware is using
PHY 0.
Then we switched channel, so mac80211 / iwlmld:
* deactivated link 0
* removed PHY 0
* added PHY 1
* modified link 0 to use PHY 1
* activated link 0.

The TLC object was not updated and the firmware was unhappy that the TLC
was still trying to use PHY 0.

Fix that by letting the TLC know about the PHY context before the link
activation.
When we are de-activating a link, let the TLC know so that it'll send a
TLC configuration command with an invalid PHY context to remove the
relationship between the TLC object and the PHY that is going to be
removed.

That last part is not implemented yet in the firmware, so leave this as
a TODO for now.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Tested-by: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
tested: Miriam Rachel Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/mld/mac80211.c |  4 ++
 drivers/net/wireless/intel/iwlwifi/mld/tlc.c  | 50 ++++++++++++++++++-
 drivers/net/wireless/intel/iwlwifi/mld/tlc.h  |  3 ++
 3 files changed, 56 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
index 358320051d1e..897602e5f9e7 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
@@ -1148,6 +1148,8 @@ int iwl_mld_assign_vif_chanctx(struct ieee80211_hw *hw,
 
 	/* Now activate the link */
 	if (iwl_mld_can_activate_link(mld, vif, link)) {
+		iwl_mld_tlc_update_phy(mld, vif, link);
+
 		ret = iwl_mld_activate_link(mld, link);
 		if (ret)
 			goto err;
@@ -1209,6 +1211,8 @@ void iwl_mld_unassign_vif_chanctx(struct ieee80211_hw *hw,
 
 	RCU_INIT_POINTER(mld_link->chan_ctx, NULL);
 
+	iwl_mld_tlc_update_phy(mld, vif, link);
+
 	/* in the non-MLO case, remove/re-add the link to clean up FW state.
 	 * In MLO, it'll be done in drv_change_vif_link
 	 */
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/tlc.c b/drivers/net/wireless/intel/iwlwifi/mld/tlc.c
index ede385909e38..78d6162d9297 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/tlc.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/tlc.c
@@ -9,6 +9,7 @@
 #include "hcmd.h"
 #include "sta.h"
 #include "phy.h"
+#include "iface.h"
 
 #include "fw/api/rs.h"
 #include "fw/api/context.h"
@@ -530,6 +531,7 @@ static void iwl_mld_send_tlc_cmd(struct iwl_mld *mld,
 				 struct ieee80211_bss_conf *link)
 {
 	struct iwl_mld_sta *mld_sta = iwl_mld_sta_from_mac80211(link_sta->sta);
+	struct iwl_mld_link *mld_link = iwl_mld_link_from_mac80211(link);
 	enum nl80211_band band = link->chanreq.oper.chan->band;
 	struct ieee80211_supported_band *sband = mld->hw->wiphy->bands[band];
 	const struct ieee80211_sta_he_cap *own_he_cap =
@@ -566,7 +568,10 @@ static void iwl_mld_send_tlc_cmd(struct iwl_mld *mld,
 
 	cmd.sta_mask = cpu_to_le32(BIT(fw_sta_id));
 
-	chan_ctx = rcu_dereference_wiphy(mld->wiphy, link->chanctx_conf);
+	if (WARN_ON_ONCE(!mld_link))
+		return;
+
+	chan_ctx = rcu_dereference_wiphy(mld->wiphy, mld_link->chan_ctx);
 	if (WARN_ON(!chan_ctx))
 		return;
 
@@ -658,6 +663,49 @@ void iwl_mld_config_tlc_link(struct iwl_mld *mld,
 	iwl_mld_send_tlc_cmd(mld, vif, link_sta, link_conf);
 }
 
+void iwl_mld_tlc_update_phy(struct iwl_mld *mld, struct ieee80211_vif *vif,
+			    struct ieee80211_bss_conf *link_conf)
+{
+	struct iwl_mld_link *mld_link = iwl_mld_link_from_mac80211(link_conf);
+	struct ieee80211_chanctx_conf *chan_ctx;
+	int link_id = link_conf->link_id;
+	struct ieee80211_sta *sta;
+
+	lockdep_assert_wiphy(mld->wiphy);
+
+	if (WARN_ON(!mld_link))
+		return;
+
+	chan_ctx = rcu_dereference_wiphy(mld->wiphy, mld_link->chan_ctx);
+
+	for_each_station(sta, mld->hw) {
+		struct iwl_mld_sta *mld_sta = iwl_mld_sta_from_mac80211(sta);
+		struct iwl_mld_link_sta *mld_link_sta;
+		struct ieee80211_link_sta *link_sta;
+
+		if (mld_sta->vif != vif)
+			continue;
+
+		link_sta = link_sta_dereference_protected(sta, link_id);
+		if (!link_sta)
+			continue;
+
+		mld_link_sta = iwl_mld_link_sta_dereference_check(mld_sta,
+								  link_id);
+
+		/* In recovery flow, the station may not be (yet) in the
+		 * firmware, don't send a TLC command for a station the
+		 * firmware does not know.
+		 */
+		if (!mld_link_sta || !mld_link_sta->in_fw)
+			continue;
+
+		if (chan_ctx)
+			iwl_mld_config_tlc_link(mld, vif, link_conf, link_sta);
+		/* TODO: else, remove the TLC object in the firmware */
+	}
+}
+
 void iwl_mld_config_tlc(struct iwl_mld *mld, struct ieee80211_vif *vif,
 			struct ieee80211_sta *sta)
 {
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/tlc.h b/drivers/net/wireless/intel/iwlwifi/mld/tlc.h
index c32f42e8840b..c7ff209c9ab6 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/tlc.h
+++ b/drivers/net/wireless/intel/iwlwifi/mld/tlc.h
@@ -20,4 +20,7 @@ void iwl_mld_handle_tlc_notif(struct iwl_mld *mld,
 
 int iwl_mld_send_tlc_dhc(struct iwl_mld *mld, u8 sta_id, u32 type, u32 data);
 
+void iwl_mld_tlc_update_phy(struct iwl_mld *mld, struct ieee80211_vif *vif,
+			    struct ieee80211_bss_conf *link_conf);
+
 #endif /* __iwl_mld_tlc_h__ */
-- 
2.34.1


