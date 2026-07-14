Return-Path: <linux-wireless+bounces-39067-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YV68Ex9DVmqs2QAAu9opvQ
	(envelope-from <linux-wireless+bounces-39067-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 16:09:35 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B94F87558C5
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 16:09:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=NUb8u6SR;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-39067-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-39067-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B865430FF259
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jul 2026 14:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 534844446F8;
	Tue, 14 Jul 2026 14:02:53 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68F5466B4B
	for <linux-wireless@vger.kernel.org>; Tue, 14 Jul 2026 14:02:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784037773; cv=none; b=V8+tGUDrA53taadkN2Db8oactIiji2nfwPYniL9g3nl6NUuFH3RR+kcuguwkgHIsRxJVvmjjHww9DqheCMt4HvRN02lUmpE37MXq7o2HQ/9zgpkoGMpUZUdA7plW2vqcr6lBi/7WzlVK7WI5q29nvFjYjgqX2lfKNfhWVJznpfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784037773; c=relaxed/simple;
	bh=kToOHH2LMGOkjzhmHvcFtiTtvHdqP0NHtTDvEqxGlmw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FzGdB+qkqtv0TVUvd6DKbNZ/u7z0Flioy44igU7O5hDQKAJsAZV/5tw9CMdk3mVqlUWtc5K5al3G22KCXpNdmOzNY5jTkZ1hfksQK9a4cvkjVYNfHEg/3uBsk0vGtO+XsGy9GCPmHKCErjP1BSXuOoWCY/biYUq01dBBNxIX3rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NUb8u6SR; arc=none smtp.client-ip=198.175.65.16
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784037772; x=1815573772;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kToOHH2LMGOkjzhmHvcFtiTtvHdqP0NHtTDvEqxGlmw=;
  b=NUb8u6SRnVbZinFzleb6O5EpHzUmVz3bmxZmzouJ7xQJ1G0uD2dqjSOc
   KvWUkodPMgo075xfjr9UNHVItvsOcO5g2gRdhfuVbF360r9MyOXctKTKJ
   ye4dqKILMoJf5i0POUX2bge+SGZqATsNMiGQOxMg0dDOsgYB2IqtbdBp2
   V8MDV17hiabZDG7VjhGKH8nspA8cjOi+3Y7I5zbKPaadyR+9kGR4Kkirt
   M46bJ6UWU21uZnPJFdRYi/1BcgNoc63l7UAZLOdJHm/KEe5OYAFFWQrRV
   7B47vD1cqxC1WpuFH42tt7MJCGHdjFxLFxfKnVxzA84XIDfth+lY7htCe
   w==;
X-CSE-ConnectionGUID: j+wuMKBfRHebki+0qdazBQ==
X-CSE-MsgGUID: Ld7zb+W9Qgmhxj0K0w3EOw==
X-IronPort-AV: E=McAfee;i="6800,10657,11846"; a="84855101"
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; 
   d="scan'208";a="84855101"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 07:02:51 -0700
X-CSE-ConnectionGUID: srnNLb2uRjuFHI3/aUnlCQ==
X-CSE-MsgGUID: E0aBEv4lQde7RiCeoomeRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; 
   d="scan'208";a="254737866"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 07:02:50 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH v2 iwlwifi-next 07/15] wifi: iwlwifi: mvm: validate monitor notif link_id
Date: Tue, 14 Jul 2026 17:02:10 +0300
Message-Id: <20260714165826.7601d05649a4.I237f58a007af761468057c9c09039953a3bb37da@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260714140218.2887000-1-miriam.rachel.korenblit@intel.com>
References: <20260714140218.2887000-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-39067-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:linux-wireless@vger.kernel.org,m:emmanuel.grumbach@intel.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,changeid:mid,intel.com:from_mime,intel.com:email,intel.com:dkim,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B94F87558C5

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

MONITOR_NOTIF link_id is firmware-provided. Validate link_id range
with IWL_FW_CHECK before vif lookup. Payload length is already
checked by RX_HANDLER.
Use iwl_mvm_rcu_dereference_vif_id which does all we need which allows
us to drop iwl_mvm_get_vif_by_macid.

Assisted-by: GitHubCopilot:gpt-5.3-codex
Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  1 -
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |  4 +--
 .../net/wireless/intel/iwlwifi/mvm/utils.c    | 30 -------------------
 3 files changed, 2 insertions(+), 33 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index 4420005ef69e..979b39314981 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -2405,7 +2405,6 @@ void iwl_mvm_sync_rx_queues_internal(struct iwl_mvm *mvm,
 				     bool sync,
 				     const void *data, u32 size);
 struct ieee80211_vif *iwl_mvm_get_bss_vif(struct iwl_mvm *mvm);
-struct ieee80211_vif *iwl_mvm_get_vif_by_macid(struct iwl_mvm *mvm, u32 macid);
 bool iwl_mvm_is_vif_assoc(struct iwl_mvm *mvm);
 
 #define MVM_TCM_PERIOD_MSEC 500
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
index 2297392db955..f43895c2f3c6 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ops.c
@@ -155,8 +155,8 @@ static void iwl_mvm_rx_monitor_notif(struct iwl_mvm *mvm,
 	if (notif->type != cpu_to_le32(IWL_DP_MON_NOTIF_TYPE_EXT_CCA))
 		return;
 
-	/* FIXME: should fetch the link and not the vif */
-	vif = iwl_mvm_get_vif_by_macid(mvm, notif->link_id);
+	/* mac_id = link_id since we don't support MLO */
+	vif = iwl_mvm_rcu_dereference_vif_id(mvm, notif->link_id, false);
 	if (!vif || vif->type != NL80211_IFTYPE_STATION)
 		return;
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/utils.c b/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
index 7eae10982869..2fd4a9961145 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
@@ -689,36 +689,6 @@ struct ieee80211_vif *iwl_mvm_get_bss_vif(struct iwl_mvm *mvm)
 	return bss_iter_data.vif;
 }
 
-struct iwl_bss_find_iter_data {
-	struct ieee80211_vif *vif;
-	u32 macid;
-};
-
-static void iwl_mvm_bss_find_iface_iterator(void *_data, u8 *mac,
-					    struct ieee80211_vif *vif)
-{
-	struct iwl_bss_find_iter_data *data = _data;
-	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
-
-	if (mvmvif->id == data->macid)
-		data->vif = vif;
-}
-
-struct ieee80211_vif *iwl_mvm_get_vif_by_macid(struct iwl_mvm *mvm, u32 macid)
-{
-	struct iwl_bss_find_iter_data data = {
-		.macid = macid,
-	};
-
-	lockdep_assert_held(&mvm->mutex);
-
-	ieee80211_iterate_active_interfaces_atomic(
-		mvm->hw, IEEE80211_IFACE_ITER_NORMAL,
-		iwl_mvm_bss_find_iface_iterator, &data);
-
-	return data.vif;
-}
-
 struct iwl_sta_iter_data {
 	bool assoc;
 };
-- 
2.34.1


