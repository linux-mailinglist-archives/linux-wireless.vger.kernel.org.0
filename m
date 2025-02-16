Return-Path: <linux-wireless+bounces-18981-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96324A3737C
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Feb 2025 10:44:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1053B16CF94
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Feb 2025 09:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41FE118EFDE;
	Sun, 16 Feb 2025 09:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dz8AvCJq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF3918DF86
	for <linux-wireless@vger.kernel.org>; Sun, 16 Feb 2025 09:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739699032; cv=none; b=o6ycgDNguoTDxpIV6iTcGFZX4FW7PHMZ8jmQcI0BItzYrpUymFglORqF+n8dXhAsdH9WMzUBriIC8v2XZeSjult/LoMmoHpSFoxH1eTK5mWfgkXeLQoEr4gTV/hUcPBZlFxiem1a14DDAxnmpznxAje6Ng6rQ5utvuHYL1B3lgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739699032; c=relaxed/simple;
	bh=xl1K3VohoIdz/MLxWjA8vP74dmM1klcQDtCPt7RIURo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=geblWuxAu6PAVsNc+9ANZPx+Ekh0RvzxZQwEuDShjYnUwTH/cgrfCMvu5kOqcZQhvS0UNRogwDFCgzzjy8ysjF+p0D0awLRXNdJfxdB25Hg1Frk/3j2XBoFix/ELBBTb2Knwzioio5+ru4Dq4+5j229wgGB6x4+qx3LGZrNTkic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dz8AvCJq; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739699030; x=1771235030;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xl1K3VohoIdz/MLxWjA8vP74dmM1klcQDtCPt7RIURo=;
  b=dz8AvCJqm0whoOGZuq2feDTvtri/1KbUFn8knHushc9EoNxoE8LV026m
   uMvNijwi/p2IY7icAqAJZW2csHc3lr6ccThft1imw0P6DIrgYitOop9Fm
   WvZEafirVF+lVCFt3UNEfEZsHW0Kij3yuobBFRyT8jm2SqjTXPWkf3Kv0
   6vM/pIkpWfMSoAS/ZlqEFa0qjkIBorUaSnnAf6IP1SKZjtYN59UsFtAm3
   MKEddboZB7OFsNm691SWdoO/l1JN7iviJabC+BVLCQndUCpgpah+ix96U
   6Aa4S90sUz5w/qnf+wLH/bssLZwvjTSjTBYGQszKA7U87ScaTTpviy9nB
   g==;
X-CSE-ConnectionGUID: xltSuKX4R16NCCfeq2uPwQ==
X-CSE-MsgGUID: OQg/rvnOR5WCh6KWFzU6+A==
X-IronPort-AV: E=McAfee;i="6700,10204,11346"; a="40323377"
X-IronPort-AV: E=Sophos;i="6.13,290,1732608000"; 
   d="scan'208";a="40323377"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2025 01:43:50 -0800
X-CSE-ConnectionGUID: NHMY9/QlRkWutzr6JZS7hg==
X-CSE-MsgGUID: wR7uF0y0SxGSYwbhFL3hVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="118785234"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2025 01:43:49 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 11/42] wifi: iwlwifi: mld: add file key.h/c
Date: Sun, 16 Feb 2025 11:42:50 +0200
Message-Id: <20250216111648.4d578bcadca0.I22c40e81f34794f45550a7598f4945f3c0717362@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250216094321.537988-1-miriam.rachel.korenblit@intel.com>
References: <20250216094321.537988-1-miriam.rachel.korenblit@intel.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

this file is handling key-related operations

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/key.c | 358 +++++++++++++++++++
 drivers/net/wireless/intel/iwlwifi/mld/key.h |  39 ++
 2 files changed, 397 insertions(+)
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/key.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/key.h

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/key.c b/drivers/net/wireless/intel/iwlwifi/mld/key.c
new file mode 100644
index 000000000000..0eff13e5ffd5
--- /dev/null
+++ b/drivers/net/wireless/intel/iwlwifi/mld/key.c
@@ -0,0 +1,358 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * Copyright (C) 2024 Intel Corporation
+ */
+#include "key.h"
+#include "iface.h"
+#include "sta.h"
+#include "fw/api/datapath.h"
+
+static u32 iwl_mld_get_key_flags(struct iwl_mld *mld,
+				 struct ieee80211_vif *vif,
+				 struct ieee80211_sta *sta,
+				 struct ieee80211_key_conf *key)
+{
+	struct iwl_mld_vif *mld_vif = iwl_mld_vif_from_mac80211(vif);
+	bool pairwise = key->flags & IEEE80211_KEY_FLAG_PAIRWISE;
+	bool igtk = key->keyidx == 4 || key->keyidx == 5;
+	u32 flags = 0;
+
+	if (!pairwise)
+		flags |= IWL_SEC_KEY_FLAG_MCAST_KEY;
+
+	switch (key->cipher) {
+	case WLAN_CIPHER_SUITE_TKIP:
+		flags |= IWL_SEC_KEY_FLAG_CIPHER_TKIP;
+		break;
+	case WLAN_CIPHER_SUITE_AES_CMAC:
+	case WLAN_CIPHER_SUITE_CCMP:
+		flags |= IWL_SEC_KEY_FLAG_CIPHER_CCMP;
+		break;
+	case WLAN_CIPHER_SUITE_GCMP_256:
+	case WLAN_CIPHER_SUITE_BIP_GMAC_256:
+		flags |= IWL_SEC_KEY_FLAG_KEY_SIZE;
+		fallthrough;
+	case WLAN_CIPHER_SUITE_GCMP:
+	case WLAN_CIPHER_SUITE_BIP_GMAC_128:
+		flags |= IWL_SEC_KEY_FLAG_CIPHER_GCMP;
+		break;
+	}
+
+	if (!sta && vif->type == NL80211_IFTYPE_STATION)
+		sta = mld_vif->ap_sta;
+
+	/* If we are installing an iGTK (in AP or STA mode), we need to tell
+	 * the firmware this key will en/decrypt MGMT frames.
+	 * Same goes if we are installing a pairwise key for an MFP station.
+	 * In case we're installing a groupwise key (which is not an iGTK),
+	 * then, we will not use this key for MGMT frames.
+	 */
+	if ((sta && sta->mfp && pairwise) || igtk)
+		flags |= IWL_SEC_KEY_FLAG_MFP;
+
+	if (key->flags & IEEE80211_KEY_FLAG_SPP_AMSDU)
+		flags |= IWL_SEC_KEY_FLAG_SPP_AMSDU;
+
+	return flags;
+}
+
+static u32 iwl_mld_get_key_sta_mask(struct iwl_mld *mld,
+				    struct ieee80211_vif *vif,
+				    struct ieee80211_sta *sta,
+				    struct ieee80211_key_conf *key)
+{
+	struct iwl_mld_vif *mld_vif = iwl_mld_vif_from_mac80211(vif);
+	struct ieee80211_link_sta *link_sta;
+	int sta_id;
+
+	lockdep_assert_wiphy(mld->wiphy);
+
+	/* AP group keys are per link and should be on the mcast/bcast STA */
+	if (vif->type == NL80211_IFTYPE_AP &&
+	    !(key->flags & IEEE80211_KEY_FLAG_PAIRWISE)) {
+		struct iwl_mld_link *link = NULL;
+
+		if (key->link_id >= 0)
+			link = iwl_mld_link_dereference_check(mld_vif,
+							      key->link_id);
+
+		if (WARN_ON(!link))
+			return 0;
+
+		/* In this stage we should have both the bcast and mcast STAs */
+		if (WARN_ON(link->bcast_sta.sta_id == IWL_INVALID_STA ||
+			    link->mcast_sta.sta_id == IWL_INVALID_STA))
+			return 0;
+
+		/* IGTK/BIGTK to bcast STA */
+		if (key->keyidx >= 4)
+			return BIT(link->bcast_sta.sta_id);
+
+		/* GTK for data to mcast STA */
+		return BIT(link->mcast_sta.sta_id);
+	}
+
+	/* for client mode use the AP STA also for group keys */
+	if (!sta && vif->type == NL80211_IFTYPE_STATION)
+		sta = mld_vif->ap_sta;
+
+	/* STA should be non-NULL now */
+	if (WARN_ON(!sta))
+		return 0;
+
+	/* Key is not per-link, get the full sta mask */
+	if (key->link_id < 0)
+		return iwl_mld_fw_sta_id_mask(mld, sta);
+
+	/* The link_sta shouldn't be NULL now, but this is checked in
+	 * iwl_mld_fw_sta_id_mask
+	 */
+	link_sta = link_sta_dereference_check(sta, key->link_id);
+
+	sta_id = iwl_mld_fw_sta_id_from_link_sta(mld, link_sta);
+	if (sta_id < 0)
+		return 0;
+
+	return BIT(sta_id);
+}
+
+static int iwl_mld_add_key_to_fw(struct iwl_mld *mld, u32 sta_mask,
+				 u32 key_flags, struct ieee80211_key_conf *key)
+{
+	struct iwl_sec_key_cmd cmd = {
+		.action = cpu_to_le32(FW_CTXT_ACTION_ADD),
+		.u.add.sta_mask = cpu_to_le32(sta_mask),
+		.u.add.key_id = cpu_to_le32(key->keyidx),
+		.u.add.key_flags = cpu_to_le32(key_flags),
+		.u.add.tx_seq = cpu_to_le64(atomic64_read(&key->tx_pn)),
+	};
+	bool tkip = key->cipher == WLAN_CIPHER_SUITE_TKIP;
+	int max_key_len = sizeof(cmd.u.add.key);
+
+	if (WARN_ON(!sta_mask))
+		return -EINVAL;
+
+	if (WARN_ON(key->keylen > max_key_len))
+		return -EINVAL;
+
+	memcpy(cmd.u.add.key, key->key, key->keylen);
+
+	if (tkip) {
+		memcpy(cmd.u.add.tkip_mic_rx_key,
+		       key->key + NL80211_TKIP_DATA_OFFSET_RX_MIC_KEY,
+		       8);
+		memcpy(cmd.u.add.tkip_mic_tx_key,
+		       key->key + NL80211_TKIP_DATA_OFFSET_TX_MIC_KEY,
+		       8);
+	}
+
+	return iwl_mld_send_cmd_pdu(mld, WIDE_ID(DATA_PATH_GROUP, SEC_KEY_CMD),
+				    &cmd);
+}
+
+static void iwl_mld_remove_key_from_fw(struct iwl_mld *mld, u32 sta_mask,
+				       u32 key_flags, u32 keyidx)
+{
+	struct iwl_sec_key_cmd cmd = {
+		.action = cpu_to_le32(FW_CTXT_ACTION_REMOVE),
+		.u.remove.sta_mask = cpu_to_le32(sta_mask),
+		.u.remove.key_id = cpu_to_le32(keyidx),
+		.u.remove.key_flags = cpu_to_le32(key_flags),
+	};
+
+	if (WARN_ON(!sta_mask))
+		return;
+
+	iwl_mld_send_cmd_pdu(mld, WIDE_ID(DATA_PATH_GROUP, SEC_KEY_CMD), &cmd);
+}
+
+void iwl_mld_remove_key(struct iwl_mld *mld, struct ieee80211_vif *vif,
+			struct ieee80211_sta *sta,
+			struct ieee80211_key_conf *key)
+{
+	u32 sta_mask = iwl_mld_get_key_sta_mask(mld, vif, sta, key);
+	u32 key_flags = iwl_mld_get_key_flags(mld, vif, sta, key);
+	struct iwl_mld_vif *mld_vif = iwl_mld_vif_from_mac80211(vif);
+
+	lockdep_assert_wiphy(mld->wiphy);
+
+	if (!sta_mask)
+		return;
+
+	if (key->keyidx == 4 || key->keyidx == 5) {
+		struct iwl_mld_link *mld_link;
+		unsigned int link_id = 0;
+
+		/* set to -1 for non-MLO right now */
+		if (key->link_id >= 0)
+			link_id = key->link_id;
+
+		mld_link = iwl_mld_link_dereference_check(mld_vif, link_id);
+		if (WARN_ON(!mld_link))
+			return;
+
+		if (mld_link->igtk == key)
+			mld_link->igtk = NULL;
+
+		mld->num_igtks--;
+	}
+
+	iwl_mld_remove_key_from_fw(mld, sta_mask, key_flags, key->keyidx);
+
+	/* no longer in HW */
+	key->hw_key_idx = STA_KEY_IDX_INVALID;
+}
+
+int iwl_mld_add_key(struct iwl_mld *mld,
+		    struct ieee80211_vif *vif,
+		    struct ieee80211_sta *sta,
+		    struct ieee80211_key_conf *key)
+{
+	u32 sta_mask = iwl_mld_get_key_sta_mask(mld, vif, sta, key);
+	u32 key_flags = iwl_mld_get_key_flags(mld, vif, sta, key);
+	struct iwl_mld_vif *mld_vif = iwl_mld_vif_from_mac80211(vif);
+	struct iwl_mld_link *mld_link = NULL;
+	bool igtk = key->keyidx == 4 || key->keyidx == 5;
+	int ret;
+
+	lockdep_assert_wiphy(mld->wiphy);
+
+	if (!sta_mask)
+		return -EINVAL;
+
+	if (igtk) {
+		if (mld->num_igtks == IWL_MAX_NUM_IGTKS)
+			return -EOPNOTSUPP;
+
+		u8 link_id = 0;
+
+		/* set to -1 for non-MLO right now */
+		if (key->link_id >= 0)
+			link_id = key->link_id;
+
+		mld_link = iwl_mld_link_dereference_check(mld_vif, link_id);
+
+		if (WARN_ON(!mld_link))
+			return -EINVAL;
+
+		if (mld_link->igtk) {
+			IWL_DEBUG_MAC80211(mld, "remove old IGTK %d\n",
+					   mld_link->igtk->keyidx);
+			iwl_mld_remove_key(mld, vif, sta, mld_link->igtk);
+		}
+
+		WARN_ON(mld_link->igtk);
+	}
+
+	ret = iwl_mld_add_key_to_fw(mld, sta_mask, key_flags, key);
+	if (ret)
+		return ret;
+
+	if (mld_link) {
+		mld_link->igtk = key;
+		mld->num_igtks++;
+	}
+
+	/* We don't really need this, but need it to be not invalid,
+	 * so we will know if the key is in fw.
+	 */
+	key->hw_key_idx = 0;
+
+	return 0;
+}
+
+struct remove_ap_keys_iter_data {
+	u8 link_id;
+	struct ieee80211_sta *sta;
+};
+
+static void iwl_mld_remove_ap_keys_iter(struct ieee80211_hw *hw,
+					struct ieee80211_vif *vif,
+					struct ieee80211_sta *sta,
+					struct ieee80211_key_conf *key,
+					void *_data)
+{
+	struct iwl_mld *mld = IWL_MAC80211_GET_MLD(hw);
+	struct remove_ap_keys_iter_data *data = _data;
+
+	if (key->hw_key_idx == STA_KEY_IDX_INVALID)
+		return;
+
+	/* All the pairwise keys should have been removed by now */
+	if (WARN_ON(sta))
+		return;
+
+	if (key->link_id >= 0 && key->link_id != data->link_id)
+		return;
+
+	iwl_mld_remove_key(mld, vif, data->sta, key);
+}
+
+void iwl_mld_remove_ap_keys(struct iwl_mld *mld, struct ieee80211_vif *vif,
+			    struct ieee80211_sta *sta, unsigned int link_id)
+{
+	struct remove_ap_keys_iter_data iter_data = {
+		.link_id = link_id,
+		.sta = sta,
+	};
+
+	if (WARN_ON_ONCE(vif->type != NL80211_IFTYPE_STATION))
+		return;
+
+	ieee80211_iter_keys(mld->hw, vif,
+			    iwl_mld_remove_ap_keys_iter,
+			    &iter_data);
+}
+
+struct iwl_mvm_sta_key_update_data {
+	struct ieee80211_sta *sta;
+	u32 old_sta_mask;
+	u32 new_sta_mask;
+	int err;
+};
+
+static void iwl_mld_update_sta_key_iter(struct ieee80211_hw *hw,
+					struct ieee80211_vif *vif,
+					struct ieee80211_sta *sta,
+					struct ieee80211_key_conf *key,
+					void *_data)
+{
+	struct iwl_mvm_sta_key_update_data *data = _data;
+	struct iwl_mld *mld = IWL_MAC80211_GET_MLD(hw);
+	struct iwl_sec_key_cmd cmd = {
+		.action = cpu_to_le32(FW_CTXT_ACTION_MODIFY),
+		.u.modify.old_sta_mask = cpu_to_le32(data->old_sta_mask),
+		.u.modify.new_sta_mask = cpu_to_le32(data->new_sta_mask),
+		.u.modify.key_id = cpu_to_le32(key->keyidx),
+		.u.modify.key_flags =
+			cpu_to_le32(iwl_mld_get_key_flags(mld, vif, sta, key)),
+	};
+	int err;
+
+	/* only need to do this for pairwise keys (link_id == -1) */
+	if (sta != data->sta || key->link_id >= 0)
+		return;
+
+	err = iwl_mld_send_cmd_pdu(mld, WIDE_ID(DATA_PATH_GROUP, SEC_KEY_CMD),
+				   &cmd);
+
+	if (err)
+		data->err = err;
+}
+
+int iwl_mld_update_sta_keys(struct iwl_mld *mld,
+			    struct ieee80211_vif *vif,
+			    struct ieee80211_sta *sta,
+			    u32 old_sta_mask,
+			    u32 new_sta_mask)
+{
+	struct iwl_mvm_sta_key_update_data data = {
+		.sta = sta,
+		.old_sta_mask = old_sta_mask,
+		.new_sta_mask = new_sta_mask,
+	};
+
+	ieee80211_iter_keys(mld->hw, vif, iwl_mld_update_sta_key_iter,
+			    &data);
+	return data.err;
+}
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/key.h b/drivers/net/wireless/intel/iwlwifi/mld/key.h
new file mode 100644
index 000000000000..96f033fe2cef
--- /dev/null
+++ b/drivers/net/wireless/intel/iwlwifi/mld/key.h
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * Copyright (C) 2024 Intel Corporation
+ */
+#ifndef __iwl_mld_key_h__
+#define __iwl_mld_key_h__
+
+#include "mld.h"
+#include <net/mac80211.h>
+#include "fw/api/sta.h"
+
+void iwl_mld_remove_key(struct iwl_mld *mld,
+			struct ieee80211_vif *vif,
+			struct ieee80211_sta *sta,
+			struct ieee80211_key_conf *key);
+int iwl_mld_add_key(struct iwl_mld *mld,
+		    struct ieee80211_vif *vif,
+		    struct ieee80211_sta *sta,
+		    struct ieee80211_key_conf *key);
+void iwl_mld_remove_ap_keys(struct iwl_mld *mld,
+			    struct ieee80211_vif *vif,
+			    struct ieee80211_sta *sta,
+			    unsigned int link_id);
+
+int iwl_mld_update_sta_keys(struct iwl_mld *mld,
+			    struct ieee80211_vif *vif,
+			    struct ieee80211_sta *sta,
+			    u32 old_sta_mask,
+			    u32 new_sta_mask);
+
+static inline void
+iwl_mld_cleanup_keys_iter(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+			  struct ieee80211_sta *sta,
+			  struct ieee80211_key_conf *key, void *data)
+{
+	key->hw_key_idx = STA_KEY_IDX_INVALID;
+}
+
+#endif /* __iwl_mld_key_h__ */
-- 
2.34.1


