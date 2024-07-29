Return-Path: <linux-wireless+bounces-10634-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A8A993FC5A
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jul 2024 19:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3A6F1F2219A
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jul 2024 17:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38AFC1741C6;
	Mon, 29 Jul 2024 17:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j/4na/Sa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0578186E37
	for <linux-wireless@vger.kernel.org>; Mon, 29 Jul 2024 17:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722273655; cv=none; b=O/P/vR0ZysWbAsBvW4IrT6RJB8NslJSPH/2e/SfXPUKqETRq+hV8xtLyWWA/sBMTambXFpVr5AjCIUvhoLJuAwRp+H+AMrSchFTotZ2OzNwmTFErvEHFBxbT8XKsaEmGF6SbcN6qNNqM6MujveMl3qIWW3T5W9DO6AGXtM3yb+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722273655; c=relaxed/simple;
	bh=24GjQpIXcyMWsTv4IcacVoKCLCACQD/IjA+vfvdumjI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZKl2qVSiWeCsyru75mLlHr/nDoAUOx0InEw6sACeS5fumVy0M+lQjAZIgkaTAg4rhPRCegxTxeoe/ygM0bKP0AA4xgfd816EOtZPiiOBxVQhedjM0GBGSEx4Dr5BzUXnykJvI+lUbmGeDLU6Zc6moPkTQObyP7EAlPvpWirf6qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j/4na/Sa; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722273654; x=1753809654;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=24GjQpIXcyMWsTv4IcacVoKCLCACQD/IjA+vfvdumjI=;
  b=j/4na/SaZb7RNZ2oWY9P8Z+o2OVfGNuy0MKV+fdn9lFWlUF1eW0bY3l9
   sCgGddRFuIYv5gvoAE4D5/W+/SQtOQlUF2orI+tgTjbN6UYtKr/lq31Dp
   15n1rtdJ3FTFXJLe4BddZJqlCwglF/MenfbpYdBSlRrtMkv7o0VpwXrXM
   uD0yAEHfE2bGhg43XMNDXgD8ItOu9gwMPfw40QS3WLah5qEbLnhp8x4ZH
   JTU+bJBjtE2IjFHIlwpQr8Q2iMAApE47n7V9Ryq8+KnSLl8xVg16WGg4I
   IB9L0MaArzD+UshaU6krjlSSBFQl7+JQM7ktspiO63gd1IhljSD8652vs
   Q==;
X-CSE-ConnectionGUID: 5jBlCMOlRvGtezK4k0PmHQ==
X-CSE-MsgGUID: TSImRTk4RhKVm96GzpowoA==
X-IronPort-AV: E=McAfee;i="6700,10204,11148"; a="31445629"
X-IronPort-AV: E=Sophos;i="6.09,246,1716274800"; 
   d="scan'208";a="31445629"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2024 10:20:54 -0700
X-CSE-ConnectionGUID: 5gTahAKNRuKCJaZPgopb7g==
X-CSE-MsgGUID: 0NH1VuCMStSjq/GJOVIP2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,246,1716274800"; 
   d="scan'208";a="54288352"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2024 10:20:52 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 14/17] wifi: iwlwiif: mvm: handle the new BT notif
Date: Mon, 29 Jul 2024 20:20:15 +0300
Message-Id: <20240729201718.00cfc07879c6.I8491483fda3b5888ea6ffa10fbd17807e443f943@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240729172018.1993751-1-miriam.rachel.korenblit@intel.com>
References: <20240729172018.1993751-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

Iterate all the links and check if any action must be taken.
The new notification impacts only the esr decision.

Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/coex.c | 36 ++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/coex.c b/drivers/net/wireless/intel/iwlwifi/mvm/coex.c
index 0bfe250c3bc8..b607961970e9 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/coex.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/coex.c
@@ -525,6 +525,35 @@ static void iwl_mvm_bt_notif_iterator(void *_data, u8 *mac,
 		iwl_mvm_bt_notif_per_link(mvm, vif, data, link_id);
 }
 
+/* must be called under rcu_read_lock */
+static void iwl_mvm_bt_coex_notif_iterator(void *_data, u8 *mac,
+					   struct ieee80211_vif *vif)
+{
+	struct iwl_mvm *mvm = _data;
+
+	lockdep_assert_held(&mvm->mutex);
+
+	if (vif->type != NL80211_IFTYPE_STATION)
+		return;
+
+	for (int link_id = 0;
+	     link_id < IEEE80211_MLD_MAX_NUM_LINKS;
+	     link_id++) {
+		struct ieee80211_bss_conf *link_conf =
+			rcu_dereference_check(vif->link_conf[link_id],
+					      lockdep_is_held(&mvm->mutex));
+		struct ieee80211_chanctx_conf *chanctx_conf =
+			rcu_dereference_check(link_conf->chanctx_conf,
+					      lockdep_is_held(&mvm->mutex));
+
+		if ((!chanctx_conf ||
+		     chanctx_conf->def.chan->band != NL80211_BAND_2GHZ))
+			continue;
+
+		iwl_mvm_bt_coex_update_link_esr(mvm, vif, link_id);
+	}
+}
+
 static void iwl_mvm_bt_coex_notif_handle(struct iwl_mvm *mvm)
 {
 	struct iwl_bt_iterator_data data = {
@@ -634,9 +663,14 @@ void iwl_mvm_rx_bt_coex_notif(struct iwl_mvm *mvm,
 	const struct iwl_rx_packet *pkt = rxb_addr(rxb);
 	const struct iwl_bt_coex_profile_notif *notif = (const void *)pkt->data;
 
+	lockdep_assert_held(&mvm->mutex);
+
 	mvm->last_bt_wifi_loss = *notif;
 
-	/* TODO: Iterate over vifs / links to take that into account */
+	ieee80211_iterate_active_interfaces(mvm->hw,
+					    IEEE80211_IFACE_ITER_NORMAL,
+					    iwl_mvm_bt_coex_notif_iterator,
+					    mvm);
 }
 
 void iwl_mvm_bt_rssi_event(struct iwl_mvm *mvm, struct ieee80211_vif *vif,
-- 
2.34.1


