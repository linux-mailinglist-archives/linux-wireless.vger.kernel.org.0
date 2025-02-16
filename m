Return-Path: <linux-wireless+bounces-19010-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 08A49A3739D
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Feb 2025 10:46:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD6D916CEEC
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Feb 2025 09:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D298919B3CB;
	Sun, 16 Feb 2025 09:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xz/Z0U54"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5FE719AA58
	for <linux-wireless@vger.kernel.org>; Sun, 16 Feb 2025 09:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739699068; cv=none; b=m3whFfpPb+ZTTYG+yQsHplO6S7G3Q+4zNESUZt1zv2QUga4uxQjGy5i8ylKm5wJCmHtf1qZdIM6wf0Y0+aq5pRJ76LnlCM7cil4EGeRZouN2pGEwc0pzRUBbm+qsxNvWSmcRxBxlHmWGEjPT20n26XPustY6w7T0iTW6fHQEdTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739699068; c=relaxed/simple;
	bh=b0SghLYn1Kdj7RC0WPzmCU9oqp/OH0hHRl9OY9VXBl0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AVxRcRU0T0OSeynho+soSSRO00LkjC2EUdZO75xDOyfNGQie+7nWOmoRoq7qgBqbBPigu2Gy0/CyaNsb0OaVYXUswQzj6an/gFam22L+JalRqNX5EehL516VTYbgPvyrTTzuoYp/7N6OYakCxCMaI2/FzDsZh24EizRRKZONaek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xz/Z0U54; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739699067; x=1771235067;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=b0SghLYn1Kdj7RC0WPzmCU9oqp/OH0hHRl9OY9VXBl0=;
  b=Xz/Z0U54gjpI+L/H2yIf/WQsnrzMmFeNpHWLuR+y++I9flbOdjWt6lpu
   Km1o84zWLM6tWkeRZl7TB1bLVag+UtBV2g1pdl+sPDn5DJv9uf5AFFlKM
   lzFHLVMZwdDRYjSvY9QObX8VqIkVV4UWfr0kxPxGh5/lyoBsLyw2xYZ9B
   ibsk/H/lHDR2oKYh+6UOMAvjIo1zv5xt5LGPyaEUrg39gJrxBRHXbYTzL
   POFejFDfYcBHw7+idyoKqa//ku6VHSQqYKbM+afopylvx/7WP15RgUl2d
   cHv2N55gZFrG/LNXHdSKq92Hhw8fCYfMADuzi8NPyikvZIt/Oyq/gY1+0
   Q==;
X-CSE-ConnectionGUID: QQd+cHoCRoGWDUZ5y3nObw==
X-CSE-MsgGUID: B6b1+Y50S867Hvf76Uj7Zw==
X-IronPort-AV: E=McAfee;i="6700,10204,11346"; a="40323438"
X-IronPort-AV: E=Sophos;i="6.13,290,1732608000"; 
   d="scan'208";a="40323438"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2025 01:44:27 -0800
X-CSE-ConnectionGUID: IwNiYHjITkawIPwm7JuaZA==
X-CSE-MsgGUID: 8xPH12/wQnG/O2Y/I8JmHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="118785313"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2025 01:44:26 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 40/42] wifi: iwlwifi: mld: add KUnit utils.h/c
Date: Sun, 16 Feb 2025 11:43:19 +0200
Message-Id: <20250216111649.c60cd32e56bb.Ic18a38ab3bc23354b264f4044a9559979a94a5b8@changeid>
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

these file are implemeting utils for KUnit tests.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 .../wireless/intel/iwlwifi/mld/tests/utils.c  | 475 ++++++++++++++++++
 .../wireless/intel/iwlwifi/mld/tests/utils.h  | 124 +++++
 2 files changed, 599 insertions(+)
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/tests/utils.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/tests/utils.h

diff --git a/drivers/net/wireless/intel/iwlwifi/mld/tests/utils.c b/drivers/net/wireless/intel/iwlwifi/mld/tests/utils.c
new file mode 100644
index 000000000000..a8c1e6c72138
--- /dev/null
+++ b/drivers/net/wireless/intel/iwlwifi/mld/tests/utils.c
@@ -0,0 +1,475 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * KUnit tests for channel helper functions
+ *
+ * Copyright (C) 2024-2025 Intel Corporation
+ */
+#include <kunit/test.h>
+#include <kunit/test-bug.h>
+
+#include "utils.h"
+
+#include <linux/device.h>
+
+#include "fw/api/scan.h"
+#include "fw/api/mac-cfg.h"
+#include "iwl-trans.h"
+#include "mld.h"
+#include "iface.h"
+#include "link.h"
+#include "phy.h"
+#include "sta.h"
+
+int iwlmld_kunit_test_init(struct kunit *test)
+{
+	struct iwl_mld *mld;
+	struct iwl_trans *trans;
+	const struct iwl_cfg *cfg;
+	struct iwl_fw *fw;
+	struct ieee80211_hw *hw;
+
+	KUNIT_ALLOC_AND_ASSERT(test, trans);
+	KUNIT_ALLOC_AND_ASSERT(test, trans->dev);
+	KUNIT_ALLOC_AND_ASSERT(test, cfg);
+	KUNIT_ALLOC_AND_ASSERT(test, fw);
+	KUNIT_ALLOC_AND_ASSERT(test, hw);
+	KUNIT_ALLOC_AND_ASSERT(test, hw->wiphy);
+
+	mutex_init(&hw->wiphy->mtx);
+
+	/* Allocate and initialize the mld structure */
+	KUNIT_ALLOC_AND_ASSERT(test, mld);
+	iwl_construct_mld(mld, trans, cfg, fw, hw, NULL);
+
+	fw->ucode_capa.num_stations = IWL_STATION_COUNT_MAX;
+	fw->ucode_capa.num_links = IWL_FW_MAX_LINK_ID + 1;
+
+	mld->fwrt.trans = trans;
+	mld->fwrt.fw = fw;
+	mld->fwrt.dev = trans->dev;
+
+	/* TODO: add priv_size to hw allocation and setup hw->priv to enable
+	 * testing mac80211 callbacks
+	 */
+
+	KUNIT_ALLOC_AND_ASSERT(test, mld->nvm_data);
+	KUNIT_ALLOC_AND_ASSERT_SIZE(test, mld->scan.cmd,
+				    sizeof(struct iwl_scan_req_umac_v17));
+	mld->scan.cmd_size = sizeof(struct iwl_scan_req_umac_v17);
+
+	/* This is not the state at the end of the regular opmode_start,
+	 * but it is more common to need it. Explicitly undo this if needed.
+	 */
+	mld->trans->state = IWL_TRANS_FW_ALIVE;
+	mld->fw_status.running = true;
+
+	/* Avoid passing mld struct around */
+	test->priv = mld;
+	return 0;
+}
+
+IWL_MLD_ALLOC_FN(link, bss_conf)
+
+static void iwlmld_kunit_init_link(struct ieee80211_vif *vif,
+				   struct ieee80211_bss_conf *link,
+				   struct iwl_mld_link *mld_link, int link_id)
+{
+	struct kunit *test = kunit_get_current_test();
+	struct iwl_mld *mld = test->priv;
+	struct iwl_mld_vif *mld_vif = iwl_mld_vif_from_mac80211(vif);
+	int ret;
+
+	/* setup mac80211 link */
+	rcu_assign_pointer(vif->link_conf[link_id], link);
+	link->link_id = link_id;
+	link->vif = vif;
+	link->beacon_int = 100;
+	link->dtim_period = 3;
+	link->qos = true;
+
+	/* and mld_link */
+	ret = iwl_mld_allocate_link_fw_id(mld, &mld_link->fw_id, link);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+	rcu_assign_pointer(mld_vif->link[link_id], mld_link);
+	rcu_assign_pointer(vif->link_conf[link_id], link);
+}
+
+IWL_MLD_ALLOC_FN(vif, vif)
+
+/* Helper function to add and initialize a VIF for KUnit tests */
+struct ieee80211_vif *iwlmld_kunit_add_vif(bool mlo, enum nl80211_iftype type)
+{
+	struct kunit *test = kunit_get_current_test();
+	struct iwl_mld *mld = test->priv;
+	struct ieee80211_vif *vif;
+	struct iwl_mld_vif *mld_vif;
+	int ret;
+
+	/* TODO: support more types */
+	KUNIT_ASSERT_EQ(test, type, NL80211_IFTYPE_STATION);
+
+	KUNIT_ALLOC_AND_ASSERT_SIZE(test, vif,
+				    sizeof(*vif) + sizeof(*mld_vif));
+
+	vif->type = type;
+	mld_vif = iwl_mld_vif_from_mac80211(vif);
+	mld_vif->mld = mld;
+
+	ret = iwl_mld_allocate_vif_fw_id(mld, &mld_vif->fw_id, vif);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	/* TODO: revisit (task=EHT) */
+	if (mlo)
+		return vif;
+
+	/* Initialize the default link */
+	iwlmld_kunit_init_link(vif, &vif->bss_conf, &mld_vif->deflink, 0);
+
+	return vif;
+}
+
+/* Use only for MLO vif */
+struct ieee80211_bss_conf *
+iwlmld_kunit_add_link(struct ieee80211_vif *vif, int link_id)
+{
+	struct kunit *test = kunit_get_current_test();
+	struct ieee80211_bss_conf *link;
+	struct iwl_mld_link *mld_link;
+
+	KUNIT_ALLOC_AND_ASSERT(test, link);
+	KUNIT_ALLOC_AND_ASSERT(test, mld_link);
+
+	iwlmld_kunit_init_link(vif, link, mld_link, link_id);
+	vif->valid_links |= BIT(link_id);
+
+	return link;
+}
+
+struct ieee80211_chanctx_conf *
+iwlmld_kunit_add_chanctx_from_def(struct cfg80211_chan_def *def)
+{
+	struct kunit *test = kunit_get_current_test();
+	struct iwl_mld *mld = test->priv;
+	struct ieee80211_chanctx_conf *ctx;
+	struct iwl_mld_phy *phy;
+	int fw_id;
+
+	KUNIT_ALLOC_AND_ASSERT_SIZE(test, ctx, sizeof(*ctx) + sizeof(*phy));
+
+	/* Setup the chanctx conf */
+	ctx->def = *def;
+	ctx->min_def = *def;
+	ctx->ap = *def;
+
+	/* and the iwl_mld_phy */
+	phy = iwl_mld_phy_from_mac80211(ctx);
+
+	fw_id = iwl_mld_allocate_fw_phy_id(mld);
+	KUNIT_ASSERT_GE(test, fw_id, 0);
+
+	phy->fw_id = fw_id;
+	phy->chandef = *iwl_mld_get_chandef_from_chanctx(ctx);
+
+	return ctx;
+}
+
+void iwlmld_kunit_assign_chanctx_to_link(struct ieee80211_vif *vif,
+					 struct ieee80211_bss_conf *link,
+					 struct ieee80211_chanctx_conf *ctx)
+{
+	struct kunit *test = kunit_get_current_test();
+	struct iwl_mld *mld = test->priv;
+	struct iwl_mld_link *mld_link;
+
+	KUNIT_EXPECT_NULL(test, rcu_access_pointer(link->chanctx_conf));
+	rcu_assign_pointer(link->chanctx_conf, ctx);
+
+	lockdep_assert_wiphy(mld->wiphy);
+
+	mld_link = iwl_mld_link_from_mac80211(link);
+
+	KUNIT_EXPECT_NULL(test, rcu_access_pointer(mld_link->chan_ctx));
+	KUNIT_EXPECT_FALSE(test, mld_link->active);
+
+	rcu_assign_pointer(mld_link->chan_ctx, ctx);
+	mld_link->active = true;
+
+	if (ieee80211_vif_is_mld(vif))
+		vif->active_links |= BIT(link->link_id);
+}
+
+IWL_MLD_ALLOC_FN(link_sta, link_sta)
+
+static void iwlmld_kunit_add_link_sta(struct ieee80211_sta *sta,
+				      struct ieee80211_link_sta *link_sta,
+				      struct iwl_mld_link_sta *mld_link_sta,
+				      u8 link_id)
+{
+	struct kunit *test = kunit_get_current_test();
+	struct iwl_mld_sta *mld_sta = iwl_mld_sta_from_mac80211(sta);
+	struct iwl_mld *mld = test->priv;
+	u8 fw_id;
+	int ret;
+
+	/* initialize mac80211's link_sta */
+	link_sta->link_id = link_id;
+	rcu_assign_pointer(sta->link[link_id], link_sta);
+
+	link_sta->sta = sta;
+
+	/* and the iwl_mld_link_sta */
+	ret = iwl_mld_allocate_link_sta_fw_id(mld, &fw_id, link_sta);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+	mld_link_sta->fw_id = fw_id;
+
+	rcu_assign_pointer(mld_sta->link[link_id], mld_link_sta);
+}
+
+static struct ieee80211_link_sta *
+iwlmld_kunit_alloc_link_sta(struct ieee80211_sta *sta, int link_id)
+{
+	struct kunit *test = kunit_get_current_test();
+	struct ieee80211_link_sta *link_sta;
+	struct iwl_mld_link_sta *mld_link_sta;
+
+	/* Only valid for MLO */
+	KUNIT_ASSERT_TRUE(test, sta->valid_links);
+
+	KUNIT_ALLOC_AND_ASSERT(test, link_sta);
+	KUNIT_ALLOC_AND_ASSERT(test, mld_link_sta);
+
+	iwlmld_kunit_add_link_sta(sta, link_sta, mld_link_sta, link_id);
+
+	sta->valid_links |= BIT(link_id);
+
+	return link_sta;
+}
+
+/* Allocate and initialize a STA with the first link_sta */
+static struct ieee80211_sta *
+iwlmld_kunit_add_sta(struct ieee80211_vif *vif, int link_id)
+{
+	struct kunit *test = kunit_get_current_test();
+	struct ieee80211_sta *sta;
+	struct iwl_mld_sta *mld_sta;
+
+	/* Allocate memory for ieee80211_sta with embedded iwl_mld_sta */
+	KUNIT_ALLOC_AND_ASSERT_SIZE(test, sta, sizeof(*sta) + sizeof(*mld_sta));
+
+	/* TODO: allocate and initialize the TXQs ? */
+
+	mld_sta = iwl_mld_sta_from_mac80211(sta);
+	mld_sta->vif = vif;
+	mld_sta->mld = test->priv;
+
+	/* TODO: adjust for internal stations */
+	mld_sta->sta_type = STATION_TYPE_PEER;
+
+	if (link_id >= 0) {
+		iwlmld_kunit_add_link_sta(sta, &sta->deflink,
+					  &mld_sta->deflink, link_id);
+		sta->valid_links = BIT(link_id);
+	} else {
+		iwlmld_kunit_add_link_sta(sta, &sta->deflink,
+					  &mld_sta->deflink, 0);
+	}
+	return sta;
+}
+
+/* Move s STA to a state */
+static void iwlmld_kunit_move_sta_state(struct ieee80211_vif *vif,
+					struct ieee80211_sta *sta,
+					enum ieee80211_sta_state state)
+{
+	struct kunit *test = kunit_get_current_test();
+	struct iwl_mld_sta *mld_sta;
+	struct iwl_mld_vif *mld_vif;
+
+	/* The sta will be removed automatically at the end of the test */
+	KUNIT_ASSERT_NE(test, state, IEEE80211_STA_NOTEXIST);
+
+	mld_sta = iwl_mld_sta_from_mac80211(sta);
+	mld_sta->sta_state = state;
+
+	mld_vif = iwl_mld_vif_from_mac80211(mld_sta->vif);
+	mld_vif->authorized = state == IEEE80211_STA_AUTHORIZED;
+
+	if (vif->type == NL80211_IFTYPE_STATION && !sta->tdls)
+		mld_vif->ap_sta = sta;
+}
+
+struct ieee80211_sta *iwlmld_kunit_setup_sta(struct ieee80211_vif *vif,
+					     enum ieee80211_sta_state state,
+					     int link_id)
+{
+	struct kunit *test = kunit_get_current_test();
+	struct ieee80211_sta *sta;
+
+	/* The sta will be removed automatically at the end of the test */
+	KUNIT_ASSERT_NE(test, state, IEEE80211_STA_NOTEXIST);
+
+	/* First - allocate and init the STA */
+	sta = iwlmld_kunit_add_sta(vif, link_id);
+
+	/* Now move it all the way to the wanted state */
+	for (enum ieee80211_sta_state _state = IEEE80211_STA_NONE;
+	     _state <= state; _state++)
+		iwlmld_kunit_move_sta_state(vif, sta, state);
+
+	return sta;
+}
+
+static void iwlmld_kunit_set_vif_associated(struct ieee80211_vif *vif)
+{
+	/* TODO: setup chanreq */
+	/* TODO setup capabilities */
+
+	vif->cfg.assoc = 1;
+}
+
+static struct ieee80211_vif *
+iwlmld_kunit_setup_assoc(bool mlo, u8 link_id, enum nl80211_band band)
+{
+	struct kunit *test = kunit_get_current_test();
+	struct iwl_mld *mld = test->priv;
+	struct ieee80211_vif *vif;
+	struct ieee80211_bss_conf *link;
+	struct ieee80211_chanctx_conf *chan_ctx;
+
+	KUNIT_ASSERT_TRUE(test, mlo || link_id == 0);
+
+	vif = iwlmld_kunit_add_vif(mlo, NL80211_IFTYPE_STATION);
+
+	if (mlo)
+		link = iwlmld_kunit_add_link(vif, link_id);
+	else
+		link = &vif->bss_conf;
+
+	chan_ctx = iwlmld_kunit_add_chanctx(band);
+
+	wiphy_lock(mld->wiphy);
+	iwlmld_kunit_assign_chanctx_to_link(vif, link, chan_ctx);
+	wiphy_unlock(mld->wiphy);
+
+	/* The AP sta will now be pointer to by mld_vif->ap_sta */
+	iwlmld_kunit_setup_sta(vif, IEEE80211_STA_AUTHORIZED, link_id);
+
+	iwlmld_kunit_set_vif_associated(vif);
+
+	return vif;
+}
+
+struct ieee80211_vif *iwlmld_kunit_setup_mlo_assoc(u16 valid_links,
+						   u8 assoc_link_id,
+						   enum nl80211_band band)
+{
+	struct kunit *test = kunit_get_current_test();
+	struct ieee80211_vif *vif;
+
+	KUNIT_ASSERT_TRUE(test,
+			  hweight16(valid_links) == 1 ||
+			  hweight16(valid_links) == 2);
+	KUNIT_ASSERT_TRUE(test, valid_links & BIT(assoc_link_id));
+
+	vif = iwlmld_kunit_setup_assoc(true, assoc_link_id, band);
+
+	/* Add the other link, if applicable */
+	if (hweight16(valid_links) > 1) {
+		u8 other_link_id = ffs(valid_links & ~BIT(assoc_link_id)) - 1;
+
+		iwlmld_kunit_add_link(vif, other_link_id);
+	}
+
+	return vif;
+}
+
+struct ieee80211_vif *iwlmld_kunit_setup_non_mlo_assoc(enum nl80211_band band)
+{
+	return iwlmld_kunit_setup_assoc(false, 0, band);
+}
+
+struct iwl_rx_packet *
+_iwl_mld_kunit_create_pkt(const void *notif, size_t notif_sz)
+{
+	struct kunit *test = kunit_get_current_test();
+	struct iwl_rx_packet *pkt;
+
+	KUNIT_ALLOC_AND_ASSERT_SIZE(test, pkt, sizeof(pkt) + notif_sz);
+
+	memcpy(pkt->data, notif, notif_sz);
+	pkt->len_n_flags = cpu_to_le32(sizeof(pkt->hdr) + notif_sz);
+
+	return pkt;
+}
+
+struct ieee80211_vif *iwlmld_kunit_assoc_emlsr(u16 valid_links,
+					       enum nl80211_band band1,
+					       enum nl80211_band band2)
+{
+	struct kunit *test = kunit_get_current_test();
+	struct iwl_mld *mld = test->priv;
+	struct ieee80211_vif *vif;
+	struct ieee80211_bss_conf *link;
+	struct ieee80211_chanctx_conf *chan_ctx;
+	struct ieee80211_sta *sta;
+	struct iwl_mld_vif *mld_vif;
+	u8 assoc_link_id, other_link_id;
+
+	KUNIT_ASSERT_TRUE(test, hweight16(valid_links) == 2);
+
+	assoc_link_id = ffs(valid_links) - 1;
+	other_link_id = ffs(valid_links & ~BIT(assoc_link_id)) - 1;
+
+	vif = iwlmld_kunit_setup_mlo_assoc(valid_links, assoc_link_id, band1);
+	mld_vif = iwl_mld_vif_from_mac80211(vif);
+
+	/* Activate second link */
+	wiphy_lock(mld->wiphy);
+
+	link = wiphy_dereference(mld->wiphy, vif->link_conf[other_link_id]);
+	KUNIT_EXPECT_NOT_NULL(test, link);
+
+	chan_ctx = iwlmld_kunit_add_chanctx(band2);
+	iwlmld_kunit_assign_chanctx_to_link(vif, link, chan_ctx);
+
+	wiphy_unlock(mld->wiphy);
+
+	/* And other link sta */
+	sta = mld_vif->ap_sta;
+	KUNIT_EXPECT_NOT_NULL(test, sta);
+
+	iwlmld_kunit_alloc_link_sta(sta, other_link_id);
+
+	return vif;
+}
+
+struct element *iwlmld_kunit_gen_element(u8 id, const void *data, size_t len)
+{
+	struct kunit *test = kunit_get_current_test();
+	struct element *elem;
+
+	KUNIT_ALLOC_AND_ASSERT_SIZE(test, elem, sizeof(*elem) + len);
+
+	elem->id = id;
+	elem->datalen = len;
+	memcpy(elem->data, data, len);
+
+	return elem;
+}
+
+struct iwl_mld_phy *iwlmld_kunit_get_phy_of_link(struct ieee80211_vif *vif,
+						 u8 link_id)
+{
+	struct kunit *test = kunit_get_current_test();
+	struct iwl_mld *mld = test->priv;
+	struct ieee80211_chanctx_conf *chanctx;
+	struct ieee80211_bss_conf *link =
+		wiphy_dereference(mld->wiphy, vif->link_conf[link_id]);
+
+	KUNIT_EXPECT_NOT_NULL(test, link);
+
+	chanctx = wiphy_dereference(mld->wiphy, link->chanctx_conf);
+	KUNIT_EXPECT_NOT_NULL(test, chanctx);
+
+	return iwl_mld_phy_from_mac80211(chanctx);
+}
diff --git a/drivers/net/wireless/intel/iwlwifi/mld/tests/utils.h b/drivers/net/wireless/intel/iwlwifi/mld/tests/utils.h
new file mode 100644
index 000000000000..1569e8e7cb90
--- /dev/null
+++ b/drivers/net/wireless/intel/iwlwifi/mld/tests/utils.h
@@ -0,0 +1,124 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/*
+ * Copyright (C) 2024-2025 Intel Corporation
+ */
+
+#ifndef __iwl_mld_kunit_utils_h__
+#define __iwl_mld_kunit_utils_h__
+
+#include <net/mac80211.h>
+#include <kunit/test-bug.h>
+
+struct iwl_mld;
+
+int iwlmld_kunit_test_init(struct kunit *test);
+
+enum nl80211_iftype;
+
+struct ieee80211_vif *iwlmld_kunit_add_vif(bool mlo, enum nl80211_iftype type);
+
+struct ieee80211_bss_conf *
+iwlmld_kunit_add_link(struct ieee80211_vif *vif, int link_id);
+
+#define KUNIT_ALLOC_AND_ASSERT_SIZE(test, ptr, size)			\
+do {									\
+	(ptr) = kunit_kzalloc((test), (size), GFP_KERNEL);		\
+	KUNIT_ASSERT_NOT_NULL((test), (ptr));				\
+} while (0)
+
+#define KUNIT_ALLOC_AND_ASSERT(test, ptr)				\
+	KUNIT_ALLOC_AND_ASSERT_SIZE(test, ptr, sizeof(*(ptr)))
+
+#define CHANNEL(_name, _band, _freq)				\
+static struct ieee80211_channel _name = {			\
+	.band = (_band),					\
+	.center_freq = (_freq),					\
+	.hw_value = (_freq),					\
+}
+
+#define CHANDEF(_name, _channel, _freq1, _width)		\
+__maybe_unused static struct cfg80211_chan_def _name = {	\
+	.chan = &(_channel),					\
+	.center_freq1 = (_freq1),				\
+	.width = (_width),					\
+}
+
+CHANNEL(chan_2ghz, NL80211_BAND_2GHZ, 2412);
+CHANNEL(chan_5ghz, NL80211_BAND_5GHZ, 5200);
+CHANNEL(chan_6ghz, NL80211_BAND_6GHZ, 6115);
+/* Feel free to add more */
+
+CHANDEF(chandef_2ghz, chan_2ghz, 2412, NL80211_CHAN_WIDTH_20);
+CHANDEF(chandef_5ghz, chan_5ghz, 5200, NL80211_CHAN_WIDTH_40);
+CHANDEF(chandef_6ghz, chan_6ghz, 6115, NL80211_CHAN_WIDTH_160);
+/* Feel free to add more */
+
+//struct cfg80211_chan_def;
+
+struct ieee80211_chanctx_conf *
+iwlmld_kunit_add_chanctx_from_def(struct cfg80211_chan_def *def);
+
+static inline struct ieee80211_chanctx_conf *
+iwlmld_kunit_add_chanctx(enum nl80211_band band)
+{
+	struct cfg80211_chan_def *chandef;
+
+	switch (band) {
+	case NL80211_BAND_2GHZ:
+		chandef = &chandef_2ghz;
+		break;
+	case NL80211_BAND_5GHZ:
+		chandef = &chandef_5ghz;
+		break;
+	default:
+	case NL80211_BAND_6GHZ:
+		chandef = &chandef_6ghz;
+		break;
+	}
+
+	return iwlmld_kunit_add_chanctx_from_def(chandef);
+}
+
+void iwlmld_kunit_assign_chanctx_to_link(struct ieee80211_vif *vif,
+					 struct ieee80211_bss_conf *link,
+					 struct ieee80211_chanctx_conf *ctx);
+
+/* Allocate a sta, initialize it and move it to the wanted state */
+struct ieee80211_sta *iwlmld_kunit_setup_sta(struct ieee80211_vif *vif,
+					     enum ieee80211_sta_state state,
+					     int link_id);
+
+struct ieee80211_vif *iwlmld_kunit_setup_mlo_assoc(u16 valid_links,
+						   u8 assoc_link_id,
+						   enum nl80211_band band);
+struct ieee80211_vif *iwlmld_kunit_setup_non_mlo_assoc(enum nl80211_band band);
+
+struct iwl_rx_packet *
+_iwl_mld_kunit_create_pkt(const void *notif, size_t notif_sz);
+
+#define iwl_mld_kunit_create_pkt(_notif)	\
+	_iwl_mld_kunit_create_pkt(&(_notif), sizeof(_notif))
+
+struct ieee80211_vif *iwlmld_kunit_assoc_emlsr(u16 valid_links,
+					       enum nl80211_band band1,
+					       enum nl80211_band band2);
+
+struct element *iwlmld_kunit_gen_element(u8 id, const void *data, size_t len);
+
+/**
+ * iwlmld_kunit_get_phy_of_link - Get the phy of a link
+ *
+ * @vif: The vif to get the phy from.
+ * @link_id: The id of the link to get the phy for.
+ *
+ * given a vif and link id, return the phy pointer of that link.
+ * This assumes that the link exists, and that it had a chanctx
+ * assigned.
+ * If this is not the case, the test will fail.
+ *
+ * Return: phy pointer.
+ */
+struct iwl_mld_phy *iwlmld_kunit_get_phy_of_link(struct ieee80211_vif *vif,
+						 u8 link_id);
+
+#endif /* __iwl_mld_kunit_utils_h__ */
-- 
2.34.1


