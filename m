Return-Path: <linux-wireless+bounces-36372-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id beApEE4QBGpODAIAu9opvQ
	(envelope-from <linux-wireless+bounces-36372-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 13 May 2026 07:46:54 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C51B552DB89
	for <lists+linux-wireless@lfdr.de>; Wed, 13 May 2026 07:46:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5D94130DAB7F
	for <lists+linux-wireless@lfdr.de>; Wed, 13 May 2026 05:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EA733A5E8C;
	Wed, 13 May 2026 05:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jMcE9no1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914083A4F46
	for <linux-wireless@vger.kernel.org>; Wed, 13 May 2026 05:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778651077; cv=none; b=VbeHyxYlKBDPPMvErbX14cYM/VEF6evCRwGCCD/usQaqARq6x++DxQA3+DaHD/cklDKC29XSAqRf5RMwzzPhm1/LgZyrOSWJ6sFGirmyf568PWA42uNZ/clTLgwxn72QpIuqSZkklnQIJ1iygQQDPLq8YGLGNxjABj+pAl7zs9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778651077; c=relaxed/simple;
	bh=K2rMWKoFKKODgdvz+X+ZJzjG3sg5G/apJr6IZPALUGc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OM5XUcZ6rwExo8aUI9k7GWNBjTeTUxuvHAGd3dHYPiSbrMAbOGMNV0FyJLy9d7V8zdVldUcfaEaVGweTOSaI8tWrb6opQu644xh2sjIiYR5m3L2A26IPQWzJPqS5gxwP0OgBMMxWPCdw+1s67N5B2l3gudk6a2NdeUiXEJKFtFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jMcE9no1; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778651076; x=1810187076;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=K2rMWKoFKKODgdvz+X+ZJzjG3sg5G/apJr6IZPALUGc=;
  b=jMcE9no17GQ2/6UWmOfq/G2z6YveEbFbyDH3os/iKXEORNLi1FYIwHMx
   4ljAvQXHxSQ+ukRO/CEnv/7hwms2Y3nuadBcU7uiwDvLL/0VoWp08i2RN
   Fb4YtdJmve/N83y7u8KePYLXQnBB/i4hz95untUm0A7bwT0jAKFhX6WLj
   /5SgnMum3mr9BeOUW/NdaqBXXyn9lWG3Nr21GD2bPGdsgp5xdMWs+NngJ
   zKVls4PzWu+9hv6dtiybbC5897qB4v0Pk6lwoeAMDehTxSimkqSbqmsNl
   uOcS30WngiPcD5WUUD5J5PoR5yDIkgbSQZE620hffaD2rEnvu+A0KEl00
   w==;
X-CSE-ConnectionGUID: o+4ukdmTSOWVLVCeykzw8Q==
X-CSE-MsgGUID: wbLHWCFwRDOw6woQAJgq/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="79552854"
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="79552854"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 22:44:36 -0700
X-CSE-ConnectionGUID: /8y8UWLZR8yhQzazQSimfw==
X-CSE-MsgGUID: qKYapi0QTb2OKqZ1VL7uTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="238077954"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 22:44:34 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Ilan Peer <ilan.peer@intel.com>
Subject: [PATCH iwlwifi-next 15/15] wifi: iwlwifi: mld: set correct key mask for NAN
Date: Wed, 13 May 2026 08:44:02 +0300
Message-Id: <20260513084215.7e18e0718d22.Icbf4204a9f1190eb4102016ad5f1c5bdab49635b@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260513054402.2897702-1-miriam.rachel.korenblit@intel.com>
References: <20260513054402.2897702-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C51B552DB89
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-36372-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miriam.rachel.korenblit@intel.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:dkim]
X-Rspamd-Action: no action

From: Johannes Berg <johannes.berg@intel.com>

For NAN data, the supplicant may derive and install GTKs to
transmit with. As multicast data encryption is supported only
with firmware versions that support adding NAN multicast
data station, allow GTK installation only with such FW
versions. Otherwise, do not install the GTK to the device.

For NAN management, there are no GTKs, but there are IGTKs
and BIGTKs, which need to be installed for the NAN broadcast
and NAN management stations. This is supported only with
firmware versions that allow adding NAN broadcast station
and NAN management station.

Handle both of these cases by adjusting the station mask
appropriately, returning a zero station mask for the GTK
and allowing that to not be an error/warning message.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Co-developed-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../net/wireless/intel/iwlwifi/mld/iface.c    |  2 +
 .../net/wireless/intel/iwlwifi/mld/iface.h    |  3 ++
 drivers/net/wireless/intel/iwlwifi/mld/key.c  | 50 +++++++++++++++++--
 .../net/wireless/intel/iwlwifi/mld/mac80211.c |  1 -
 drivers/net/wireless/intel/iwlwifi/mld/sta.c  |  8 ++-
 5 files changed, 59 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/iface.c b/drivers/net/wireless/intel/iwlwifi/mld/iface.c
index 399efeb469f6..2b837c6fa5fe 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/iface.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/iface.c
@@ -66,6 +66,8 @@ void iwl_mld_cleanup_vif(void *data, u8 *mac, struct ieee80211_vif *vif)
 			iwl_mld_free_internal_sta(mld, &mld_vif->nan.bcast_sta);
 		if (mld_vif->nan.mgmt_sta.sta_id != IWL_INVALID_STA)
 			iwl_mld_free_internal_sta(mld, &mld_vif->nan.mgmt_sta);
+
+		mld_vif->nan.tx_igtk = NULL;
 	}
 
 	if (vif->type == NL80211_IFTYPE_NAN_DATA &&
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/iface.h b/drivers/net/wireless/intel/iwlwifi/mld/iface.h
index c6a7588df1fa..bc6f45ff76f8 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/iface.h
+++ b/drivers/net/wireless/intel/iwlwifi/mld/iface.h
@@ -160,6 +160,8 @@ struct iwl_mld_emlsr {
  * @nan.mgmt_sta: internal station used for NAN management frames, e.g., SDFs
  *	and NAFs.
  * @nan.mcast_data_sta: internal station used for multicast NAN Data frames.
+ * @nan.tx_igtk: TX IGTK key for NAN, tracked separately since NAN does not
+ *	use the vif links.
  */
 struct iwl_mld_vif {
 	/* Add here fields that need clean up on restart */
@@ -189,6 +191,7 @@ struct iwl_mld_vif {
 		struct iwl_mld_int_sta bcast_sta;
 		struct iwl_mld_int_sta mgmt_sta;
 		struct iwl_mld_int_sta mcast_data_sta;
+		struct ieee80211_key_conf *tx_igtk;
 	} nan;
 
 	struct iwl_mld_emlsr emlsr;
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/key.c b/drivers/net/wireless/intel/iwlwifi/mld/key.c
index 151e35b851f7..a6454d90d0e3 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/key.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/key.c
@@ -63,6 +63,40 @@ static u32 iwl_mld_get_key_sta_mask(struct iwl_mld *mld,
 
 	lockdep_assert_wiphy(mld->wiphy);
 
+	if (vif->type == NL80211_IFTYPE_NAN_DATA && !sta) {
+		/* Older firmware versions do not support transmission of
+		 * multicast data frames.
+		 */
+		if (!iwl_mld_nan_use_nan_stations(mld))
+			return 0;
+
+		if (WARN_ON(mld_vif->nan.mcast_data_sta.sta_id ==
+			    IWL_INVALID_STA))
+			return 0;
+
+		return BIT(mld_vif->nan.mcast_data_sta.sta_id);
+	}
+
+	if (vif->type == NL80211_IFTYPE_NAN && !sta) {
+		/* Older firmware versions do not support installation of
+		 * IGTK/BIGTK keys.
+		 */
+		if (!iwl_mld_nan_use_nan_stations(mld))
+			return 0;
+
+		if (WARN_ON(mld_vif->nan.bcast_sta.sta_id == IWL_INVALID_STA ||
+			    mld_vif->nan.mgmt_sta.sta_id == IWL_INVALID_STA))
+			return 0;
+
+		if (key->keyidx >= 4 && key->keyidx <= 5)
+			return BIT(mld_vif->nan.mgmt_sta.sta_id);
+
+		if (key->keyidx >= 6 && key->keyidx <= 7)
+			return BIT(mld_vif->nan.bcast_sta.sta_id);
+
+		return 0;
+	}
+
 	/* AP group keys are per link and should be on the mcast/bcast STA */
 	if (vif->type == NL80211_IFTYPE_AP &&
 	    !(key->flags & IEEE80211_KEY_FLAG_PAIRWISE)) {
@@ -204,7 +238,7 @@ iwl_mld_get_igtk_ptr(struct ieee80211_vif *vif,
 			return &mld_sta->deflink.rx_igtk;
 		}
 
-		return &mld_vif->deflink.tx_igtk;
+		return &mld_vif->nan.tx_igtk;
 	case NL80211_IFTYPE_AP:
 		mld_link = iwl_mld_link_dereference_check(mld_vif, link_id);
 		if (WARN_ON(!mld_link))
@@ -254,8 +288,16 @@ int iwl_mld_add_key(struct iwl_mld *mld,
 
 	lockdep_assert_wiphy(mld->wiphy);
 
-	if (!sta_mask)
+	if (!sta_mask) {
+		/* for NAN (GTK) indicate SW-only, it's not used at all */
+		if (vif->type == NL80211_IFTYPE_NAN_DATA && !sta &&
+		    !iwl_mld_nan_use_nan_stations(mld))
+			return 1;
+
+		/* otherwise that's not valid */
+		IWL_WARN(mld, "empty STA mask for key %d\n", key->keyidx);
 		return -EINVAL;
+	}
 
 	igtk_ptr = iwl_mld_get_igtk_ptr(vif, sta, key);
 	if (igtk_ptr) {
@@ -270,8 +312,10 @@ int iwl_mld_add_key(struct iwl_mld *mld,
 	}
 
 	ret = iwl_mld_add_key_to_fw(mld, sta_mask, key_flags, key);
-	if (ret)
+	if (ret) {
+		IWL_WARN(mld, "failed to add key to FW (%d)\n", ret);
 		return ret;
+	}
 
 	if (igtk_ptr) {
 		WARN_ON(*igtk_ptr);
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
index b6df09812dae..9736b43155d6 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mac80211.c
@@ -2248,7 +2248,6 @@ static int iwl_mld_set_key_add(struct iwl_mld *mld,
 
 	ret = iwl_mld_add_key(mld, vif, sta, key);
 	if (ret) {
-		IWL_WARN(mld, "set key failed (%d)\n", ret);
 		if (ptk_pn) {
 			RCU_INIT_POINTER(mld_sta->ptk_pn[keyidx], NULL);
 			kfree(ptk_pn);
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/sta.c b/drivers/net/wireless/intel/iwlwifi/mld/sta.c
index cd13238ed613..77eeeed66116 100644
--- a/drivers/net/wireless/intel/iwlwifi/mld/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mld/sta.c
@@ -1089,8 +1089,14 @@ iwl_mld_set_internal_sta_to_fw(struct iwl_mld *mld,
 	 * On the other hand, FW will never check this flag during RX since
 	 * an AP/GO doesn't receive protected broadcast management frames.
 	 * So, we can set it unconditionally.
+	 *
+	 * For NAN stations associated with a NAN Device, the MFP bit must be
+	 * set to 1, as otherwise the FW will assert when a key associated with
+	 * these stations would be added.
 	 */
-	if (internal_sta->sta_type == STATION_TYPE_BCAST_MGMT)
+	if (internal_sta->sta_type == STATION_TYPE_BCAST_MGMT ||
+	    internal_sta->sta_type == STATION_TYPE_NAN_BCAST ||
+	    internal_sta->sta_type == STATION_TYPE_NAN_MGMT)
 		cmd.mfp = cpu_to_le32(1);
 
 	if (addr) {
-- 
2.34.1


