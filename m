Return-Path: <linux-wireless+bounces-18985-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA84BA37381
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Feb 2025 10:44:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DF63188F015
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Feb 2025 09:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D30C18DB22;
	Sun, 16 Feb 2025 09:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mKwhqN9x"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C65190482
	for <linux-wireless@vger.kernel.org>; Sun, 16 Feb 2025 09:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739699038; cv=none; b=YZ8+eW2YwFoXfiK30AZcIXaRCsWhPFCaI+H3pvXnPJP5xBL5QCULitdyTglC2Xf1OuAAI0IcbmUuYwMNtdu68NCT8fVx4f59XphYChZ6Uq1VDyGwABKXSNSsuoKIF8l/ht/4suwvcpXuA/1gTWwph5Zi6YdkjPp6yYkReq4qRSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739699038; c=relaxed/simple;
	bh=DWghO8YnJLBgMprukG+wSMTKXUOeuw07YLNEFFqjhnA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C6kqYmDOYgJxZa6SQI0Oalzc3LHTG/A643gJ8erEjGlig57gZdJX9zPVFiUJEvVjIw2aeW4F3E+aTBKLEvFuwrm1AbhhDY7ZddtG7WEwP7pVnmquF1xcAms6NoBOUBz7lsK6vVu6ZfQCkA9bCX5v7yCEDS2f/af1v6N7g1foeYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mKwhqN9x; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739699037; x=1771235037;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DWghO8YnJLBgMprukG+wSMTKXUOeuw07YLNEFFqjhnA=;
  b=mKwhqN9xsocZR/K+YU6XiEo0eYsSRQuSJ2IDIhly/FClBY7Jb7QpZmP2
   XOyPWKwu960fZ00SyPAdj/fXUv6NiAk4a1OdLlmLmcQp3wRUX8dBKtv5/
   02wjLEwn10Fn/iz5dpdVvn8COrE4k8UnNR1jgy6xPscr714h5u3hQQa1H
   j3+wctn49tkUWA9dLokAXzZ6kCGUKAb5zQWEYSO6/AhauCUdrW986ITlv
   88qpjB0QUjJNO7FfF5DVFDJOvrO3UcMfKStOTrDw+x86vNsVDOdIjQuMR
   p9AbH4VCUI4ILUdbW5eFGsdVphd1o+qQKUBN5lP1m8amdnaPAePwm/tMz
   w==;
X-CSE-ConnectionGUID: 98ukeNfDRsWe1fHXoSpB4w==
X-CSE-MsgGUID: L4CDEk8LTCOBMfPYFWX4jw==
X-IronPort-AV: E=McAfee;i="6700,10204,11346"; a="40323388"
X-IronPort-AV: E=Sophos;i="6.13,290,1732608000"; 
   d="scan'208";a="40323388"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2025 01:43:56 -0800
X-CSE-ConnectionGUID: IBJJEJRYQDqLMWt4uRyE9Q==
X-CSE-MsgGUID: Lll1v32QRpKO8jRKylhtCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="118785243"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2025 01:43:55 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 16/42] wifi: iwlwifi: mld: add file mcc.h/c
Date: Sun, 16 Feb 2025 11:42:55 +0200
Message-Id: <20250216111648.51d1f50c48be.I4b7abd423406053c349e9a98b4b3597e562f0074@changeid>
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

this file is handling mobile country/regdomain functionality

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mld/mcc.c | 329 +++++++++++++++++++
 drivers/net/wireless/intel/iwlwifi/mld/mcc.h |  17 +
 2 files changed, 346 insertions(+)
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/mcc.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/mcc.h

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mcc.c b/drivers/net/wireless/intel/iwlwifi/mld/mcc.c
new file mode 100644
index 000000000000..daca14e208bd
--- /dev/null
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mcc.c
@@ -0,0 +1,329 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * Copyright (C) 2024 Intel Corporation
+ */
+
+#include <net/cfg80211.h>
+#include <net/mac80211.h>
+
+#include <fw/dbg.h>
+#include <iwl-nvm-parse.h>
+
+#include "mld.h"
+#include "hcmd.h"
+#include "mcc.h"
+
+/* It is the caller's responsibility to free the pointer returned here */
+static struct iwl_mcc_update_resp_v8 *
+iwl_mld_parse_mcc_update_resp_v8(const struct iwl_rx_packet *pkt)
+{
+	const struct iwl_mcc_update_resp_v8 *mcc_resp_v8 = (const void *)pkt->data;
+	int n_channels = __le32_to_cpu(mcc_resp_v8->n_channels);
+	struct iwl_mcc_update_resp_v8 *resp_cp;
+	int notif_len = struct_size(resp_cp, channels, n_channels);
+
+	if (iwl_rx_packet_payload_len(pkt) != notif_len)
+		return ERR_PTR(-EINVAL);
+
+	resp_cp = kmemdup(mcc_resp_v8, notif_len, GFP_KERNEL);
+	if (!resp_cp)
+		return ERR_PTR(-ENOMEM);
+
+	return resp_cp;
+}
+
+/* It is the caller's responsibility to free the pointer returned here */
+static struct iwl_mcc_update_resp_v8 *
+iwl_mld_parse_mcc_update_resp_v5_v6(const struct iwl_rx_packet *pkt)
+{
+	const struct iwl_mcc_update_resp_v4 *mcc_resp_v4 = (const void *)pkt->data;
+	struct iwl_mcc_update_resp_v8 *resp_cp;
+	int n_channels = __le32_to_cpu(mcc_resp_v4->n_channels);
+	int resp_len;
+
+	if (iwl_rx_packet_payload_len(pkt) !=
+	    struct_size(mcc_resp_v4, channels, n_channels))
+		return ERR_PTR(-EINVAL);
+
+	resp_len = struct_size(resp_cp, channels, n_channels);
+	resp_cp = kzalloc(resp_len, GFP_KERNEL);
+	if (!resp_cp)
+		return ERR_PTR(-ENOMEM);
+
+	resp_cp->status = mcc_resp_v4->status;
+	resp_cp->mcc = mcc_resp_v4->mcc;
+	resp_cp->cap = cpu_to_le32(le16_to_cpu(mcc_resp_v4->cap));
+	resp_cp->source_id = mcc_resp_v4->source_id;
+	resp_cp->geo_info = mcc_resp_v4->geo_info;
+	resp_cp->n_channels = mcc_resp_v4->n_channels;
+	memcpy(resp_cp->channels, mcc_resp_v4->channels,
+	       n_channels * sizeof(__le32));
+
+	return resp_cp;
+}
+
+/* It is the caller's responsibility to free the pointer returned here */
+static struct iwl_mcc_update_resp_v8 *
+iwl_mld_update_mcc(struct iwl_mld *mld, const char *alpha2,
+		   enum iwl_mcc_source src_id)
+{
+	int resp_ver = iwl_fw_lookup_notif_ver(mld->fw, LONG_GROUP,
+					       MCC_UPDATE_CMD, 0);
+	struct iwl_mcc_update_cmd mcc_update_cmd = {
+		.mcc = cpu_to_le16(alpha2[0] << 8 | alpha2[1]),
+		.source_id = (u8)src_id,
+	};
+	struct iwl_mcc_update_resp_v8 *resp_cp;
+	struct iwl_rx_packet *pkt;
+	struct iwl_host_cmd cmd = {
+		.id = MCC_UPDATE_CMD,
+		.flags = CMD_WANT_SKB,
+		.data = { &mcc_update_cmd },
+		.len[0] = sizeof(mcc_update_cmd),
+	};
+	int ret;
+	u16 mcc;
+
+	IWL_DEBUG_LAR(mld, "send MCC update to FW with '%c%c' src = %d\n",
+		      alpha2[0], alpha2[1], src_id);
+
+	ret = iwl_mld_send_cmd(mld, &cmd);
+	if (ret)
+		return ERR_PTR(ret);
+
+	pkt = cmd.resp_pkt;
+
+	/* For Wifi-7 radios, we get version 8
+	 * For Wifi-6E radios, we get version 6
+	 * For Wifi-6 radios, we get version 5, but 5, 6, and 4 are compatible.
+	 */
+	switch (resp_ver) {
+	case 5:
+	case 6:
+		resp_cp = iwl_mld_parse_mcc_update_resp_v5_v6(pkt);
+		break;
+	case 8:
+		resp_cp = iwl_mld_parse_mcc_update_resp_v8(pkt);
+		break;
+	default:
+		IWL_FW_CHECK_FAILED(mld, "Unknown MCC_UPDATE_CMD version %d\n", resp_ver);
+		resp_cp = ERR_PTR(-EINVAL);
+	}
+
+	if (IS_ERR(resp_cp))
+		goto exit;
+
+	mcc = le16_to_cpu(resp_cp->mcc);
+
+	IWL_FW_CHECK(mld, !mcc, "mcc can't be 0: %d\n", mcc);
+
+	IWL_DEBUG_LAR(mld,
+		      "MCC response status: 0x%x. new MCC: 0x%x ('%c%c')\n",
+		      le32_to_cpu(resp_cp->status), mcc, mcc >> 8, mcc & 0xff);
+
+exit:
+	iwl_free_resp(&cmd);
+	return resp_cp;
+}
+
+/* It is the caller's responsibility to free the pointer returned here */
+struct ieee80211_regdomain *
+iwl_mld_get_regdomain(struct iwl_mld *mld,
+		      const char *alpha2,
+		      enum iwl_mcc_source src_id,
+		      bool *changed)
+{
+	struct ieee80211_regdomain *regd = NULL;
+	struct iwl_mcc_update_resp_v8 *resp;
+	u8 resp_ver = iwl_fw_lookup_notif_ver(mld->fw, IWL_ALWAYS_LONG_GROUP,
+					      MCC_UPDATE_CMD, 0);
+
+	IWL_DEBUG_LAR(mld, "Getting regdomain data for %s from FW\n", alpha2);
+
+	lockdep_assert_wiphy(mld->wiphy);
+
+	resp = iwl_mld_update_mcc(mld, alpha2, src_id);
+	if (IS_ERR(resp)) {
+		IWL_DEBUG_LAR(mld, "Could not get update from FW %ld\n",
+			      PTR_ERR(resp));
+		resp = NULL;
+		goto out;
+	}
+
+	if (changed) {
+		u32 status = le32_to_cpu(resp->status);
+
+		*changed = (status == MCC_RESP_NEW_CHAN_PROFILE ||
+			    status == MCC_RESP_ILLEGAL);
+	}
+	IWL_DEBUG_LAR(mld, "MCC update response version: %d\n", resp_ver);
+
+	regd = iwl_parse_nvm_mcc_info(mld->trans->dev, mld->cfg,
+				      __le32_to_cpu(resp->n_channels),
+				      resp->channels,
+				      __le16_to_cpu(resp->mcc),
+				      __le16_to_cpu(resp->geo_info),
+				      le32_to_cpu(resp->cap), resp_ver);
+
+	if (IS_ERR(regd)) {
+		IWL_DEBUG_LAR(mld, "Could not get parse update from FW %ld\n",
+			      PTR_ERR(regd));
+		goto out;
+	}
+
+	IWL_DEBUG_LAR(mld, "setting alpha2 from FW to %s (0x%x, 0x%x) src=%d\n",
+		      regd->alpha2, regd->alpha2[0],
+		      regd->alpha2[1], resp->source_id);
+
+	mld->mcc_src = resp->source_id;
+
+	if (!iwl_puncturing_is_allowed_in_bios(mld->bios_enable_puncturing,
+					       le16_to_cpu(resp->mcc)))
+		ieee80211_hw_set(mld->hw, DISALLOW_PUNCTURING);
+	else
+		__clear_bit(IEEE80211_HW_DISALLOW_PUNCTURING, mld->hw->flags);
+
+out:
+	kfree(resp);
+	return regd;
+}
+
+/* It is the caller's responsibility to free the pointer returned here */
+static struct ieee80211_regdomain *
+iwl_mld_get_current_regdomain(struct iwl_mld *mld,
+			      bool *changed)
+{
+	return iwl_mld_get_regdomain(mld, "ZZ",
+				     MCC_SOURCE_GET_CURRENT, changed);
+}
+
+void iwl_mld_update_changed_regdomain(struct iwl_mld *mld)
+{
+	struct ieee80211_regdomain *regd;
+	bool changed;
+
+	regd = iwl_mld_get_current_regdomain(mld, &changed);
+
+	if (IS_ERR_OR_NULL(regd))
+		return;
+
+	if (changed)
+		regulatory_set_wiphy_regd(mld->wiphy, regd);
+	kfree(regd);
+}
+
+static int iwl_mld_apply_last_mcc(struct iwl_mld *mld,
+				  const char *alpha2)
+{
+	struct ieee80211_regdomain *regd;
+	u32 used_src;
+	bool changed;
+	int ret;
+
+	/* save the last source in case we overwrite it below */
+	used_src = mld->mcc_src;
+
+	/* Notify the firmware we support wifi location updates */
+	regd = iwl_mld_get_current_regdomain(mld, NULL);
+	if (!IS_ERR_OR_NULL(regd))
+		kfree(regd);
+
+	/* Now set our last stored MCC and source */
+	regd = iwl_mld_get_regdomain(mld, alpha2, used_src,
+				     &changed);
+	if (IS_ERR_OR_NULL(regd))
+		return -EIO;
+
+	/* update cfg80211 if the regdomain was changed */
+	if (changed)
+		ret = regulatory_set_wiphy_regd_sync(mld->wiphy, regd);
+	else
+		ret = 0;
+
+	kfree(regd);
+	return ret;
+}
+
+int iwl_mld_init_mcc(struct iwl_mld *mld)
+{
+	const struct ieee80211_regdomain *r;
+	struct ieee80211_regdomain *regd;
+	char mcc[3];
+	int retval;
+
+	/* try to replay the last set MCC to FW */
+	r = wiphy_dereference(mld->wiphy, mld->wiphy->regd);
+
+	if (r)
+		return iwl_mld_apply_last_mcc(mld, r->alpha2);
+
+	regd = iwl_mld_get_current_regdomain(mld, NULL);
+	if (IS_ERR_OR_NULL(regd))
+		return -EIO;
+
+	if (!iwl_bios_get_mcc(&mld->fwrt, mcc)) {
+		kfree(regd);
+		regd = iwl_mld_get_regdomain(mld, mcc, MCC_SOURCE_BIOS, NULL);
+		if (IS_ERR_OR_NULL(regd))
+			return -EIO;
+	}
+
+	retval = regulatory_set_wiphy_regd_sync(mld->wiphy, regd);
+
+	kfree(regd);
+	return retval;
+}
+
+static void iwl_mld_find_assoc_vif_iterator(void *data, u8 *mac,
+					    struct ieee80211_vif *vif)
+{
+	bool *assoc = data;
+
+	if (vif->type == NL80211_IFTYPE_STATION &&
+	    vif->cfg.assoc)
+		*assoc = true;
+}
+
+static bool iwl_mld_is_a_vif_assoc(struct iwl_mld *mld)
+{
+	bool assoc = false;
+
+	ieee80211_iterate_active_interfaces_atomic(mld->hw,
+						   IEEE80211_IFACE_ITER_NORMAL,
+						   iwl_mld_find_assoc_vif_iterator,
+						   &assoc);
+	return assoc;
+}
+
+void iwl_mld_handle_update_mcc(struct iwl_mld *mld, struct iwl_rx_packet *pkt)
+{
+	struct iwl_mcc_chub_notif *notif = (void *)pkt->data;
+	enum iwl_mcc_source src;
+	char mcc[3];
+	struct ieee80211_regdomain *regd;
+	bool changed;
+
+	lockdep_assert_wiphy(mld->wiphy);
+
+	if (iwl_mld_is_a_vif_assoc(mld) &&
+	    notif->source_id == MCC_SOURCE_WIFI) {
+		IWL_DEBUG_LAR(mld, "Ignore mcc update while associated\n");
+		return;
+	}
+
+	mcc[0] = le16_to_cpu(notif->mcc) >> 8;
+	mcc[1] = le16_to_cpu(notif->mcc) & 0xff;
+	mcc[2] = '\0';
+	src = notif->source_id;
+
+	IWL_DEBUG_LAR(mld,
+		      "RX: received chub update mcc cmd (mcc '%s' src %d)\n",
+		      mcc, src);
+	regd = iwl_mld_get_regdomain(mld, mcc, src, &changed);
+	if (IS_ERR_OR_NULL(regd))
+		return;
+
+	if (changed)
+		regulatory_set_wiphy_regd(mld->hw->wiphy, regd);
+	kfree(regd);
+}
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/mcc.h b/drivers/net/wireless/intel/iwlwifi/mld/mcc.h
new file mode 100644
index 000000000000..2b31e5b5e2ed
--- /dev/null
+++ b/drivers/net/wireless/intel/iwlwifi/mld/mcc.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/*
+ * Copyright (C) 2024 Intel Corporation
+ */
+#ifndef __iwl_mld_mcc_h__
+#define __iwl_mld_mcc_h__
+
+int iwl_mld_init_mcc(struct iwl_mld *mld);
+void iwl_mld_handle_update_mcc(struct iwl_mld *mld, struct iwl_rx_packet *pkt);
+void iwl_mld_update_changed_regdomain(struct iwl_mld *mld);
+struct ieee80211_regdomain *
+iwl_mld_get_regdomain(struct iwl_mld *mld,
+		      const char *alpha2,
+		      enum iwl_mcc_source src_id,
+		      bool *changed);
+
+#endif /* __iwl_mld_mcc_h__ */
-- 
2.34.1


