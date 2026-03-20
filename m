Return-Path: <linux-wireless+bounces-33565-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kLqhCUECvWkO5gIAu9opvQ
	(envelope-from <linux-wireless+bounces-33565-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 09:16:01 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2200F2D70D0
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 09:16:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DDBEB304E75B
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 08:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9885837A4AE;
	Fri, 20 Mar 2026 08:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GK4q5BEL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9446A371CF4
	for <linux-wireless@vger.kernel.org>; Fri, 20 Mar 2026 08:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773994179; cv=none; b=gQvGT7WSlEfl98BLXcg3rkwXGqcMrW8HLiDUsvfmuprWNBfM2gN18Pl8DtmlvbBMhK2vl46HTQqgWVxxW2LjV6YbgC2O+OxvM/u6t6cPF0uos1EQ6gnO+lmTwB4fccrBLiR4n4O4ZTXBJOOmsjxvIgY0YlfSB4VnEqzrwLALKvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773994179; c=relaxed/simple;
	bh=2kTYUyoBMG19RPeOz6gA0AEIxsArD89weRkX0YRVlrY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YXZvgsYE/ZgTt9YEPOX6Y9kv1/2cP7gMYgB9gY3llpK6clYKJXs8sD+tOfeOXxT8So/7xpGC15HbVhfrO/npkTdJGLUkUS3BX734i4CnnBb1ayqXWhHvBqdvDcWgJyQeyHF//652Iz2UxFXFT2TB1Gxt7mHwgNRzN9bepfXi/RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GK4q5BEL; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773994177; x=1805530177;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2kTYUyoBMG19RPeOz6gA0AEIxsArD89weRkX0YRVlrY=;
  b=GK4q5BEL8w2VPKDYCCLHzMdpbFRIvxBl5mCTNADkYbI4IXiellLywjqN
   mLR7puaxAYzhui5TyzOJgj6W58k8ZXNlPMY+8tXUOYHM4CygvO/9IooJq
   8RlB3ZywGRmjsJVEmHNJL+wySPbWf0DdqA8Eo/JgVfOIwh2d4mTP+FPuV
   F+p61ysGfOJhcz54eJcIbzt+cPVKC4cWnDidxPOPGGF/P6ZGUCHLrzoxm
   hd31pod6WFbNSRAWMg2hX1xN/y3wmbK70JZon/YoKkrTqyzA8KUTLAVYH
   vlqQEaCkQSofMSsGwIViVT5fw14KAOVkOcqGVM3N1pmmhOe9h7Xj3uPuQ
   Q==;
X-CSE-ConnectionGUID: lHbT4bW7Q6+pHHNSffDbLQ==
X-CSE-MsgGUID: ZOfSbhJjSq2e82owqB4gsw==
X-IronPort-AV: E=McAfee;i="6800,10657,11734"; a="86154115"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="86154115"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 01:09:36 -0700
X-CSE-ConnectionGUID: /sZFaIeGSYmTEA7NBS/TKA==
X-CSE-MsgGUID: f77crqKeToy2s+sAXwGiaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="227692564"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 01:09:35 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-next 04/15] wifi: iwlwifi: mld: support changing iftype at runtime
Date: Fri, 20 Mar 2026 10:09:07 +0200
Message-Id: <20260320100746.2fb530f9d825.I7cc68fa36e40c9f3bef3be9c2982061cb9ea2300@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260320080918.2567780-1-miriam.rachel.korenblit@intel.com>
References: <20260320080918.2567780-1-miriam.rachel.korenblit@intel.com>
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
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33565-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 2200F2D70D0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Johannes Berg <johannes.berg@intel.com>

While the interface isn't really operating, which is already
required by mac80211, we can simply remove the MAC and add
it again to change the type. Implement this simple handling.

We could almost consider moving this to mac80211 itself, as
this kind of flow should be supportable by any device, but
for now keep it here.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/mld/mac80211.c | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
index 71a9a72c9ac0..5cd3cdffb570 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
@@ -754,6 +754,30 @@ void iwl_mld_mac80211_remove_interface(struct ieee80211_hw *hw,
 	mld->monitor.phy.valid = false;
 }
 
+static
+int iwl_mld_mac80211_change_interface(struct ieee80211_hw *hw,
+				      struct ieee80211_vif *vif,
+				      enum nl80211_iftype new_type, bool p2p)
+{
+	enum nl80211_iftype old_type = vif->type;
+	bool old_p2p = vif->p2p;
+	int ret;
+
+	iwl_mld_mac80211_remove_interface(hw, vif);
+
+	/* set the new type for adding it cleanly */
+	vif->type = new_type;
+	vif->p2p = p2p;
+
+	ret = iwl_mld_mac80211_add_interface(hw, vif);
+
+	/* restore for mac80211, it will change it again */
+	vif->type = old_type;
+	vif->p2p = old_p2p;
+
+	return ret;
+}
+
 struct iwl_mld_mc_iter_data {
 	struct iwl_mld *mld;
 	int port_id;
@@ -2735,6 +2759,7 @@ const struct ieee80211_ops iwl_mld_hw_ops = {
 	.get_antenna = iwl_mld_get_antenna,
 	.set_antenna = iwl_mld_set_antenna,
 	.add_interface = iwl_mld_mac80211_add_interface,
+	.change_interface = iwl_mld_mac80211_change_interface,
 	.remove_interface = iwl_mld_mac80211_remove_interface,
 	.conf_tx = iwl_mld_mac80211_conf_tx,
 	.prepare_multicast = iwl_mld_mac80211_prepare_multicast,
-- 
2.34.1


