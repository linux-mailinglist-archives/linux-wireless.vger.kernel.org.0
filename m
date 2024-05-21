Return-Path: <linux-wireless+bounces-7911-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 250FB8CB2BD
	for <lists+linux-wireless@lfdr.de>; Tue, 21 May 2024 19:20:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CD89B21189
	for <lists+linux-wireless@lfdr.de>; Tue, 21 May 2024 17:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB47B149C4D;
	Tue, 21 May 2024 17:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="SDgsKxsr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF8C148840;
	Tue, 21 May 2024 17:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716311971; cv=none; b=N419U3cQ810KeUvRQWo/F3u00jqsRuphhsupFB2p1Hjo50TmwrUcO3DF8RQWZlvQmxehDuHcPv+ZbVXCtCpYn7BH6CC1QIdLo1cxOBDyxIUASsQJ0MGMiayCJYqEEOEmmIQXhmjYmQr2U/iahvDvezqxMk3mlcA36JHk37DWLKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716311971; c=relaxed/simple;
	bh=4twnRrinmflptudtvGkxZTkS/iUN5UXf4pbRx6QL4GQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fI6SObYXAlSh7W/3rkKysH062qMZSJUa29mpGJOEXDvERIkoWcGpsp5Jhgz1ZF9w6oKvy9/vK6gByJpd5CCtfarXm3HcCmS+WXWpE+g5yhwPkfRcMK9t+329U8Uu/tOAt+IHwwjhLz2WKE8RGPawX4pjlXL08kYiJSC+zzTN79k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=SDgsKxsr; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44LHJ3wd071208;
	Tue, 21 May 2024 12:19:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1716311943;
	bh=JPLCfWds4C3zXIHmF+Nr1V0sywmzsZ7Q6BgG9RAJ44o=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=SDgsKxsrSp3ZN0k7QwvEutoFHYHoQmao6Yb82v+At4ywiWy8kUtrT3nGQ0TNulKQs
	 oRlXoYPS2lf6l/D3/FyApxQ8JnKqUND+oO2bGdbw6IyckU7u1zU/zUkaID29iNrl/Y
	 GGnsm0zPvulw1PevlH2Ypx2ANWeKwiFjfSEmYIsY=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44LHJ3qm015080
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 21 May 2024 12:19:03 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 21
 May 2024 12:19:03 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 21 May 2024 12:19:03 -0500
Received: from localhost (uda0389739.dhcp.ti.com [137.167.1.114])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44LHJ2lj014118;
	Tue, 21 May 2024 12:19:02 -0500
From: <michael.nemanov@ti.com>
To: Kalle Valo <kvalo@kernel.org>, Johannes Berg <johannes.berg@intel.com>,
        Breno Leitao <leitao@debian.org>,
        Justin Stitt <justinstitt@google.com>,
        Kees
 Cook <keescook@chromium.org>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Sabeeh Khan <sabeeh-khan@ti.com>,
        Michael Nemanov
	<Michael.Nemanov@ti.com>,
        Michael Nemanov <michael.nemanov@ti.com>
Subject: [PATCH 05/17] Add acx.c, acx.h
Date: Tue, 21 May 2024 20:18:29 +0300
Message-ID: <20240521171841.884576-6-michael.nemanov@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240521171841.884576-1-michael.nemanov@ti.com>
References: <20240521171841.884576-1-michael.nemanov@ti.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

From: Michael Nemanov <Michael.Nemanov@ti.com>

These file contain various WLAN-oriented APIs

Signed-off-by: Michael Nemanov <michael.nemanov@ti.com>
---
 drivers/net/wireless/ti/cc33xx/acx.c | 1009 ++++++++++++++++++++++++++
 drivers/net/wireless/ti/cc33xx/acx.h |  835 +++++++++++++++++++++
 2 files changed, 1844 insertions(+)
 create mode 100644 drivers/net/wireless/ti/cc33xx/acx.c
 create mode 100644 drivers/net/wireless/ti/cc33xx/acx.h

diff --git a/drivers/net/wireless/ti/cc33xx/acx.c b/drivers/net/wireless/ti/cc33xx/acx.c
new file mode 100644
index 000000000000..1b338b031c51
--- /dev/null
+++ b/drivers/net/wireless/ti/cc33xx/acx.c
@@ -0,0 +1,1009 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2022-2024 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+#include "acx.h"
+
+int cc33xx_acx_clear_statistics(struct cc33xx *cc)
+{
+	struct acx_header *acx;
+	int ret = 0;
+
+	cc33xx_debug(DEBUG_ACX, "acx clear statistics");
+
+	acx = kzalloc(sizeof(*acx), GFP_KERNEL);
+	if (!acx) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	ret = cc33xx_cmd_configure(cc, ACX_CLEAR_STATISTICS, acx, sizeof(*acx));
+	if (ret < 0) {
+		cc33xx_warning("failed to clear firmware statistics: %d", ret);
+		goto out;
+	}
+
+out:
+	kfree(acx);
+	return ret;
+}
+
+int cc33xx_acx_wake_up_conditions(struct cc33xx *cc, struct cc33xx_vif *wlvif,
+				  u8 wake_up_event, u8 listen_interval)
+{
+	struct acx_wake_up_condition *wake_up;
+	int ret;
+
+	cc33xx_debug(DEBUG_ACX,
+		     "acx wake up conditions (wake_up_event %d listen_interval %d)",
+		     wake_up_event, listen_interval);
+
+	wake_up = kzalloc(sizeof(*wake_up), GFP_KERNEL);
+	if (!wake_up) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	wake_up->wake_up_event = wake_up_event;
+	wake_up->listen_interval = listen_interval;
+
+	ret = cc33xx_cmd_configure(cc, WAKE_UP_CONDITIONS_CFG,
+				   wake_up, sizeof(*wake_up));
+	if (ret < 0) {
+		cc33xx_warning("could not set wake up conditions: %d", ret);
+		goto out;
+	}
+
+out:
+	kfree(wake_up);
+	return ret;
+}
+
+int cc33xx_acx_sleep_auth(struct cc33xx *cc, u8 sleep_auth)
+{
+	struct acx_sleep_auth *auth;
+	int ret;
+
+	cc33xx_debug(DEBUG_ACX, "acx sleep auth %d", sleep_auth);
+
+	auth = kzalloc(sizeof(*auth), GFP_KERNEL);
+	if (!auth) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	auth->sleep_auth = sleep_auth;
+
+	ret = cc33xx_cmd_configure(cc, ACX_SLEEP_AUTH, auth, sizeof(*auth));
+	if (ret < 0) {
+		cc33xx_error("could not configure sleep_auth to %d: %d",
+			     sleep_auth, ret);
+		goto out;
+	}
+
+	cc->sleep_auth = sleep_auth;
+out:
+	kfree(auth);
+	return ret;
+}
+
+int cc33xx_ble_enable(struct cc33xx *cc, u8 ble_enable)
+{
+	struct debug_header *buf;
+	int ret;
+
+	cc33xx_debug(DEBUG_ACX, "ble enable");
+
+	buf = kzalloc(sizeof(*buf), GFP_KERNEL);
+	if (!buf) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	ret = cc33xx_cmd_debug(cc, BLE_ENABLE, buf, sizeof(*buf));
+	if (ret < 0) {
+		cc33xx_error("could not enable ble");
+		goto out;
+	}
+
+	cc->ble_enable = 1;
+out:
+	kfree(buf);
+	return ret;
+}
+
+int cc33xx_acx_tx_power(struct cc33xx *cc, struct cc33xx_vif *wlvif,
+			int power)
+{
+	struct acx_tx_power_cfg *acx;
+	int ret;
+
+	cc33xx_debug(DEBUG_ACX, "acx TX_POWER_CFG %d", power);
+
+	if (power < CC33XX_MIN_TXPWR) {
+		cc33xx_warning("Configured Tx power %d dBm. Increasing to minimum %d dBm",
+			       power, CC33XX_MIN_TXPWR);
+		power = CC33XX_MIN_TXPWR;
+	} else if (power > CC33XX_MAX_TXPWR) {
+		cc33xx_warning("Configured Tx power %d dBm is bigger than upper limit: %d dBm. Attenuating to max limit",
+			       power, CC33XX_MAX_TXPWR);
+		power = CC33XX_MAX_TXPWR;
+	}
+
+	acx = kzalloc(sizeof(*acx), GFP_KERNEL);
+	if (!acx) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	acx->role_id = wlvif->role_id;
+	acx->tx_power = power;
+
+	ret = cc33xx_cmd_configure(cc, TX_POWER_CFG, acx, sizeof(*acx));
+	if (ret < 0) {
+		cc33xx_warning("Configure of tx power failed: %d", ret);
+		goto out;
+	}
+
+	wlvif->power_level = power;
+
+out:
+	kfree(acx);
+	return ret;
+}
+
+static int cc33xx_acx_mem_map(struct cc33xx *cc,
+			      struct acx_header *memeroy_map, size_t len)
+{
+	int ret;
+
+	cc33xx_debug(DEBUG_ACX, "acx mem map");
+
+	ret = cc33xx_cmd_interrogate(cc, MEM_MAP_INTR, memeroy_map,
+				     sizeof(struct acx_header), len);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static int cc33xx_acx_get_fw_versions(struct cc33xx *cc,
+				      struct cc33xx_acx_fw_versions *get_fw_versions,
+				      size_t len)
+{
+	int ret;
+
+	cc33xx_debug(DEBUG_ACX, "acx get FW versions");
+
+	ret = cc33xx_cmd_interrogate(cc, GET_FW_VERSIONS_INTR, get_fw_versions,
+				     sizeof(struct cc33xx_acx_fw_versions), len);
+	if (ret < 0)
+		return ret;
+	return 0;
+}
+
+int cc33xx_acx_slot(struct cc33xx *cc, struct cc33xx_vif *wlvif,
+		    enum acx_slot_type slot_time)
+{
+	struct acx_slot *slot;
+	int ret;
+
+	cc33xx_debug(DEBUG_ACX, "acx slot");
+
+	slot = kzalloc(sizeof(*slot), GFP_KERNEL);
+	if (!slot) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	slot->role_id = wlvif->role_id;
+	slot->slot_time = slot_time;
+	ret = cc33xx_cmd_configure(cc, SLOT_CFG, slot, sizeof(*slot));
+
+	if (ret < 0) {
+		cc33xx_warning("failed to set slot time: %d", ret);
+		goto out;
+	}
+
+out:
+	kfree(slot);
+	return ret;
+}
+
+int cc33xx_acx_group_address_tbl(struct cc33xx *cc, bool enable, void *mc_list, u32 mc_list_len)
+{
+	struct acx_dot11_grp_addr_tbl *acx;
+	int ret;
+
+	acx = kzalloc(sizeof(*acx), GFP_KERNEL);
+	if (!acx) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	cc33xx_debug(DEBUG_ACX, "acx group address tbl");
+
+	acx->enabled = enable;
+	acx->num_groups = mc_list_len;
+	memcpy(acx->mac_table, mc_list, mc_list_len * ETH_ALEN);
+
+	ret = cc33xx_cmd_configure(cc, DOT11_GROUP_ADDRESS_TBL,
+				   acx, sizeof(*acx));
+	if (ret < 0) {
+		cc33xx_warning("failed to set group addr table: %d", ret);
+		goto out;
+	}
+out:
+	kfree(acx);
+	return ret;
+}
+
+int cc33xx_acx_beacon_filter_opt(struct cc33xx *cc, struct cc33xx_vif *wlvif,
+				 bool enable_filter)
+{
+	struct acx_beacon_filter_option *beacon_filter = NULL;
+	int ret = 0;
+
+	cc33xx_debug(DEBUG_ACX, "acx beacon filter opt enable=%d",
+		     enable_filter);
+
+	if (enable_filter &&
+	    cc->conf.host_conf.conn.bcn_filt_mode == CONF_BCN_FILT_MODE_DISABLED)
+		goto out;
+
+	beacon_filter = kzalloc(sizeof(*beacon_filter), GFP_KERNEL);
+	if (!beacon_filter) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	beacon_filter->role_id = wlvif->role_id;
+	beacon_filter->enable = enable_filter;
+
+	/* When set to zero, and the filter is enabled, beacons
+	 * without the unicast TIM bit set are dropped.
+	 */
+	beacon_filter->max_num_beacons = 0;
+
+	ret = cc33xx_cmd_configure(cc, BEACON_FILTER_OPT,
+				   beacon_filter, sizeof(*beacon_filter));
+	if (ret < 0) {
+		cc33xx_warning("failed to set beacon filter opt: %d", ret);
+		goto out;
+	}
+
+out:
+	kfree(beacon_filter);
+	return ret;
+}
+
+int cc33xx_acx_beacon_filter_table(struct cc33xx *cc, struct cc33xx_vif *wlvif)
+{
+	struct acx_beacon_filter_ie_table *ie_table;
+	struct conf_bcn_filt_rule bcn_filt_ie[32];
+	struct conf_bcn_filt_rule *p_bcn_filt_ie;
+	int i, idx = 0;
+	int ret;
+	bool vendor_spec = false;
+
+	cc33xx_debug(DEBUG_ACX, "acx beacon filter table");
+
+	ie_table = kzalloc(sizeof(*ie_table), GFP_KERNEL);
+	if (!ie_table) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	/* configure default beacon pass-through rules */
+	ie_table->role_id = wlvif->role_id;
+	ie_table->num_ie = 0;
+	p_bcn_filt_ie =  &cc->conf.host_conf.conn.bcn_filt_ie0;
+	memcpy(bcn_filt_ie, p_bcn_filt_ie, 32 * sizeof(struct conf_bcn_filt_rule));
+	for (i = 0; i < cc->conf.host_conf.conn.bcn_filt_ie_count; i++) {
+		struct conf_bcn_filt_rule *r = &bcn_filt_ie[i];
+
+		ie_table->table[idx++] = r->ie;
+		ie_table->table[idx++] = r->rule;
+
+		if (r->ie == WLAN_EID_VENDOR_SPECIFIC) {
+			/* only one vendor specific ie allowed */
+			if (vendor_spec)
+				continue;
+
+			/* for vendor specific rules configure the
+			 * additional fields
+			 */
+			memcpy(&ie_table->table[idx], r->oui,
+			       CONF_BCN_IE_OUI_LEN);
+			idx += CONF_BCN_IE_OUI_LEN;
+			ie_table->table[idx++] = r->type;
+			memcpy(&ie_table->table[idx], r->version,
+			       CONF_BCN_IE_VER_LEN);
+			idx += CONF_BCN_IE_VER_LEN;
+			vendor_spec = true;
+		}
+
+		ie_table->num_ie++;
+	}
+
+	ret = cc33xx_cmd_configure(cc, BEACON_FILTER_TABLE,
+				   ie_table, sizeof(*ie_table));
+	if (ret < 0) {
+		cc33xx_warning("failed to set beacon filter table: %d", ret);
+		goto out;
+	}
+
+out:
+	kfree(ie_table);
+	return ret;
+}
+
+int cc33xx_assoc_info_cfg(struct cc33xx *cc, struct cc33xx_vif *wlvif,
+			  struct ieee80211_sta *sta, u16 aid)
+{
+	struct assoc_info_cfg *cfg;
+	int ret;
+
+	cc33xx_debug(DEBUG_ACX, "acx aid");
+
+	cfg = kzalloc(sizeof(*cfg), GFP_KERNEL);
+	if (!cfg) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	cfg->role_id = wlvif->role_id;
+	cfg->aid = cpu_to_le16(aid);
+	cfg->wmm_enabled = wlvif->wmm_enabled;
+
+	cfg->nontransmitted = wlvif->nontransmitted;
+	cfg->bssid_index = wlvif->bssid_index;
+	cfg->bssid_indicator = wlvif->bssid_indicator;
+	cfg->ht_supported = sta->deflink.ht_cap.ht_supported;
+	cfg->vht_supported = sta->deflink.vht_cap.vht_supported;
+	cfg->has_he = sta->deflink.he_cap.has_he;
+	memcpy(cfg->transmitter_bssid, wlvif->transmitter_bssid, ETH_ALEN);
+	ret = cc33xx_cmd_configure(cc, ASSOC_INFO_CFG, cfg, sizeof(*cfg));
+	if (ret < 0) {
+		cc33xx_warning("failed to set aid: %d", ret);
+		goto out;
+	}
+
+out:
+	kfree(cfg);
+	return ret;
+}
+
+int cc33xx_acx_set_preamble(struct cc33xx *cc, struct cc33xx_vif *wlvif,
+			    enum acx_preamble_type preamble)
+{
+	struct acx_preamble *acx;
+	int ret;
+
+	cc33xx_debug(DEBUG_ACX, "acx_set_preamble");
+
+	acx = kzalloc(sizeof(*acx), GFP_KERNEL);
+	if (!acx) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	acx->role_id = wlvif->role_id;
+	acx->preamble = preamble;
+
+	ret = cc33xx_cmd_configure(cc, PREAMBLE_TYPE_CFG, acx, sizeof(*acx));
+	if (ret < 0) {
+		cc33xx_warning("Setting of preamble failed: %d", ret);
+		goto out;
+	}
+
+out:
+	kfree(acx);
+	return ret;
+}
+
+int cc33xx_acx_cts_protect(struct cc33xx *cc, struct cc33xx_vif *wlvif,
+			   enum acx_ctsprotect_type ctsprotect)
+{
+	struct acx_ctsprotect *acx;
+	int ret;
+
+	cc33xx_debug(DEBUG_ACX, "acx_set_ctsprotect");
+
+	acx = kzalloc(sizeof(*acx), GFP_KERNEL);
+	if (!acx) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	acx->role_id = wlvif->role_id;
+	acx->ctsprotect = ctsprotect;
+
+	ret = cc33xx_cmd_configure(cc, CTS_PROTECTION_CFG, acx, sizeof(*acx));
+	if (ret < 0) {
+		cc33xx_warning("Setting of ctsprotect failed: %d", ret);
+		goto out;
+	}
+
+out:
+	kfree(acx);
+	return ret;
+}
+
+int cc33xx_acx_statistics(struct cc33xx *cc, void *stats)
+{
+	int ret;
+
+	cc33xx_debug(DEBUG_ACX, "acx statistics");
+
+	ret = cc33xx_cmd_interrogate(cc, ACX_STATISTICS, stats,
+				     sizeof(struct acx_header),
+				     sizeof(struct cc33xx_acx_statistics));
+	if (ret < 0) {
+		cc33xx_warning("acx statistics failed: %d", ret);
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+int cc33xx_update_ap_rates(struct cc33xx *cc, u8 role_id,
+			   u32 basic_rates_set, u32 supported_rates)
+{
+	struct ap_rates_class_cfg *cfg;
+	int ret;
+
+	cc33xx_debug(DEBUG_AP,
+		     "Attempting to Update Basic Rates and Supported Rates");
+
+	cfg = kzalloc(sizeof(*cfg), GFP_KERNEL);
+
+	if (!cfg) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	cfg->basic_rates_set = cpu_to_le32(basic_rates_set);
+	cfg->supported_rates = cpu_to_le32(supported_rates);
+	cfg->role_id = role_id;
+	ret = cc33xx_cmd_configure(cc, AP_RATES_CFG, cfg, sizeof(*cfg));
+	if (ret < 0) {
+		cc33xx_warning("Updating AP Rates  failed: %d", ret);
+		goto out;
+	}
+
+out:
+	kfree(cfg);
+	return ret;
+}
+
+int cc33xx_tx_param_cfg(struct cc33xx *cc, struct cc33xx_vif *wlvif, u8 ac,
+			u8 cw_min, u16 cw_max, u8 aifsn, u16 txop, bool acm,
+			u8 ps_scheme, u8 is_mu_edca, u8 mu_edca_aifs,
+			u8 mu_edca_ecw_min_max, u8 mu_edca_timer)
+{
+	struct tx_param_cfg *cfg;
+	int ret = 0;
+
+	cc33xx_debug(DEBUG_ACX,
+		     "tx param cfg %d cw_ming %d cw_max %d aifs %d txop %d",
+		     ac, cw_min, cw_max, aifsn, txop);
+
+	cc33xx_debug(DEBUG_ACX, "tx param cfg ps_scheme %d is_mu_edca %d mu_edca_aifs %d mu_edca_ecw_min_max %d mu_edca_timer %d",
+		     ps_scheme, is_mu_edca, mu_edca_aifs, mu_edca_ecw_min_max,
+		     mu_edca_timer);
+
+	cfg = kzalloc(sizeof(*cfg), GFP_KERNEL);
+
+	if (!cfg) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	cfg->role_id = wlvif->role_id;
+	cfg->ac = ac;
+	cfg->cw_min = cw_min;
+	cfg->cw_max = cpu_to_le16(cw_max);
+	cfg->aifsn = aifsn;
+	cfg->tx_op_limit = cpu_to_le16(txop);
+	cfg->acm = cpu_to_le16(acm);
+	cfg->ps_scheme = ps_scheme;
+	cfg->is_mu_edca = is_mu_edca;
+	cfg->mu_edca_aifs = mu_edca_aifs;
+	cfg->mu_edca_ecw_min_max = mu_edca_ecw_min_max;
+	cfg->mu_edca_timer = mu_edca_timer;
+
+	ret = cc33xx_cmd_configure(cc, TX_PARAMS_CFG, cfg, sizeof(*cfg));
+	if (ret < 0) {
+		cc33xx_warning("tx param cfg failed: %d", ret);
+		goto out;
+	}
+
+out:
+	kfree(cfg);
+	return ret;
+}
+
+int cc33xx_acx_init_mem_config(struct cc33xx *cc)
+{
+	int ret;
+
+	cc->target_mem_map = kzalloc(sizeof(*cc->target_mem_map),
+				     GFP_KERNEL);
+	if (!cc->target_mem_map) {
+		cc33xx_error("couldn't allocate target memory map");
+		return -ENOMEM;
+	}
+
+	/* we now ask for the firmware built memory map */
+	ret = cc33xx_acx_mem_map(cc, (void *)cc->target_mem_map,
+				 sizeof(struct cc33xx_acx_mem_map));
+	if (ret < 0) {
+		cc33xx_error("couldn't retrieve firmware memory map");
+		kfree(cc->target_mem_map);
+		cc->target_mem_map = NULL;
+		return ret;
+	}
+
+	/* initialize TX block book keeping */
+	cc->tx_blocks_available =
+		le32_to_cpu(cc->target_mem_map->num_tx_mem_blocks);
+	cc33xx_debug(DEBUG_TX, "available tx blocks: %d",
+		     cc->tx_blocks_available);
+
+	cc33xx_debug(DEBUG_TX,
+		     "available tx descriptor: %d available rx blocks %d",
+		     cc->target_mem_map->num_tx_descriptor,
+		     cc->target_mem_map->num_rx_mem_blocks);
+
+	return 0;
+}
+
+int cc33xx_acx_init_get_fw_versions(struct cc33xx *cc)
+{
+	int ret;
+
+	cc->all_versions.fw_ver = kzalloc(sizeof(*cc->all_versions.fw_ver),
+					  GFP_KERNEL);
+	if (!cc->all_versions.fw_ver) {
+		cc33xx_error("couldn't allocate cc33xx_acx_fw_versions");
+		return -ENOMEM;
+	}
+
+	ret = cc33xx_acx_get_fw_versions(cc, (void *)cc->all_versions.fw_ver,
+					 sizeof(struct cc33xx_acx_fw_versions));
+	if (ret < 0) {
+		cc33xx_error("couldn't retrieve firmware versions");
+		kfree(cc->all_versions.fw_ver);
+		cc->all_versions.fw_ver = NULL;
+		return ret;
+	}
+
+	return 0;
+}
+
+int cc33xx_acx_set_ht_information(struct cc33xx *cc, struct cc33xx_vif *wlvif,
+				  u16 ht_operation_mode, u32 he_oper_params,
+				  u16 he_oper_nss_set)
+{
+	struct cc33xx_acx_ht_information *acx;
+	int ret = 0;
+
+	cc33xx_debug(DEBUG_ACX, "acx ht information setting");
+
+	acx = kzalloc(sizeof(*acx), GFP_KERNEL);
+	if (!acx) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	acx->role_id = wlvif->role_id;
+	acx->ht_protection =
+		(u8)(ht_operation_mode & IEEE80211_HT_OP_MODE_PROTECTION);
+	acx->rifs_mode = 0;
+	acx->gf_protection =
+		!!(ht_operation_mode & IEEE80211_HT_OP_MODE_NON_GF_STA_PRSNT);
+
+	acx->dual_cts_protection = 0;
+
+	cc33xx_debug(DEBUG_ACX, "HE operation: 0x%xm mcs: 0x%x",
+		     he_oper_params, he_oper_nss_set);
+
+	acx->he_operation = cpu_to_le32(he_oper_params);
+	acx->bss_basic_mcs_set = cpu_to_le16(he_oper_nss_set);
+	acx->qos_info_more_data_ack_bit = 0;
+	ret = cc33xx_cmd_configure(cc, BSS_OPERATION_CFG, acx, sizeof(*acx));
+
+	if (ret < 0) {
+		cc33xx_warning("acx ht information setting failed: %d", ret);
+		goto out;
+	}
+
+out:
+	kfree(acx);
+	return ret;
+}
+
+/* setup BA session receiver setting in the FW. */
+int cc33xx_acx_set_ba_receiver_session(struct cc33xx *cc, u8 tid_index, u16 ssn,
+				       bool enable, u8 peer_hlid, u8 win_size)
+{
+	struct cc33xx_acx_ba_receiver_setup *acx;
+	int ret;
+
+	cc33xx_debug(DEBUG_ACX, "acx ba receiver session setting");
+
+	acx = kzalloc(sizeof(*acx), GFP_KERNEL);
+	if (!acx) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	acx->hlid = peer_hlid;
+	acx->tid = tid_index;
+	acx->enable = enable;
+	acx->win_size =	win_size;
+	acx->ssn = cpu_to_le16(ssn);
+
+	ret = cc33xx_cmd_configure_failsafe(cc, BA_SESSION_RX_SETUP_CFG,
+					    acx, sizeof(*acx),
+					    BIT(CMD_STATUS_NO_RX_BA_SESSION));
+	if (ret < 0) {
+		cc33xx_warning("acx ba receiver session failed: %d", ret);
+		goto out;
+	}
+
+	/* sometimes we can't start the session */
+	if (ret == CMD_STATUS_NO_RX_BA_SESSION) {
+		cc33xx_warning("no fw rx ba on tid %d", tid_index);
+		ret = -EBUSY;
+		goto out;
+	}
+
+	ret = 0;
+out:
+	kfree(acx);
+	return ret;
+}
+
+int cc33xx_acx_tsf_info(struct cc33xx *cc,
+			struct cc33xx_vif *wlvif, u64 *mactime)
+{
+	struct cc33xx_acx_fw_tsf_information *tsf_info;
+	int ret = 0;
+
+	tsf_info = kzalloc(sizeof(*tsf_info), GFP_KERNEL);
+	if (!tsf_info) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	tsf_info->role_id = wlvif->role_id;
+
+	*mactime = le32_to_cpu(tsf_info->current_tsf_low) |
+		((u64)le32_to_cpu(tsf_info->current_tsf_high) << 32);
+
+out:
+	kfree(tsf_info);
+	return ret;
+}
+
+int cc33xx_acx_config_ps(struct cc33xx *cc, struct cc33xx_vif *wlvif)
+{
+	struct cc33xx_acx_config_ps *config_ps;
+	int ret;
+
+	cc33xx_debug(DEBUG_ACX, "acx config ps");
+
+	config_ps = kzalloc(sizeof(*config_ps), GFP_KERNEL);
+	if (!config_ps) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	config_ps->exit_retries = cc->conf.host_conf.conn.psm_exit_retries;
+	config_ps->enter_retries = cc->conf.host_conf.conn.psm_entry_retries;
+	config_ps->null_data_rate = cpu_to_le32(wlvif->basic_rate);
+
+	ret = cc33xx_cmd_configure(cc, ACX_CONFIG_PS, config_ps,
+				   sizeof(*config_ps));
+
+	if (ret < 0) {
+		cc33xx_warning("acx config ps failed: %d", ret);
+		goto out;
+	}
+
+out:
+	kfree(config_ps);
+	return ret;
+}
+
+int cc33xx_acx_average_rssi(struct cc33xx *cc,
+			    struct cc33xx_vif *wlvif, s8 *avg_rssi)
+{
+	struct acx_roaming_stats *acx;
+	int ret = 0;
+
+	cc33xx_debug(DEBUG_ACX, "acx roaming statistics");
+
+	acx = kzalloc(sizeof(*acx), GFP_KERNEL);
+	if (!acx) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	acx->role_id = wlvif->role_id;
+
+	ret = cc33xx_cmd_interrogate(cc, RSSI_INTR,
+				     acx, sizeof(*acx), sizeof(*acx));
+	if (ret	< 0) {
+		cc33xx_warning("acx roaming statistics failed: %d", ret);
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	*avg_rssi = acx->rssi_beacon;
+
+out:
+	kfree(acx);
+	return ret;
+}
+
+static const u16 cc33xx_idx_to_rate_100kbps[] = {
+	10, 20, 55, 110, 60, 90, 120, 180, 240, 360, 480, 540
+};
+
+int cc33xx_acx_get_tx_rate(struct cc33xx *cc, struct cc33xx_vif *wlvif,
+			   struct station_info *sinfo)
+{
+	struct acx_preamble_and_tx_rate *acx;
+	int ret;
+
+	cc33xx_debug(DEBUG_ACX, "acx set tx rate");
+
+	acx = kzalloc(sizeof(*acx), GFP_KERNEL);
+	if (!acx) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	acx->role_id = wlvif->role_id;
+
+	ret = cc33xx_cmd_interrogate(cc, GET_PREAMBLE_AND_TX_RATE_INTR,
+				     acx, sizeof(*acx), sizeof(*acx));
+	if (ret	< 0) {
+		cc33xx_warning("acx get preamble and tx rate failed: %d", ret);
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	sinfo->txrate.flags = 0;
+	if (acx->preamble == CONF_PREAMBLE_TYPE_AC_VHT)
+		sinfo->txrate.flags = RATE_INFO_FLAGS_VHT_MCS;
+	else if ((acx->preamble >= CONF_PREAMBLE_TYPE_AX_SU) &&
+		 (acx->preamble <= CONF_PREAMBLE_TYPE_AX_TB_NDP_FB))
+		sinfo->txrate.flags = RATE_INFO_FLAGS_HE_MCS;
+	else if ((acx->preamble == CONF_PREAMBLE_TYPE_N_MIXED_MODE) ||
+		 (acx->preamble == CONF_PREAMBLE_TYPE_GREENFIELD))
+		sinfo->txrate.flags = RATE_INFO_FLAGS_MCS;
+
+	if (acx->tx_rate >= CONF_HW_RATE_INDEX_MCS0)
+		sinfo->txrate.mcs = acx->tx_rate - CONF_HW_RATE_INDEX_MCS0;
+	else
+		sinfo->txrate.legacy = cc33xx_idx_to_rate_100kbps[acx->tx_rate - 1];
+
+	sinfo->txrate.nss = 1;
+	sinfo->txrate.bw = RATE_INFO_BW_20;
+	sinfo->txrate.he_gi = NL80211_RATE_INFO_HE_GI_3_2;
+	sinfo->txrate.he_dcm = 0;
+	sinfo->txrate.he_ru_alloc = 0;
+	sinfo->txrate.n_bonded_ch = 0;
+	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_BITRATE);
+
+out:
+	kfree(acx);
+	return ret;
+}
+
+#ifdef CONFIG_PM
+/* Set the global behaviour of RX filters - On/Off + default action */
+int cc33xx_acx_default_rx_filter_enable(struct cc33xx *cc, bool enable,
+					enum rx_filter_action action)
+{
+	struct acx_default_rx_filter *acx;
+	int ret;
+
+	cc33xx_debug(DEBUG_ACX, "acx default rx filter en: %d act: %d",
+		     enable, action);
+
+	acx = kzalloc(sizeof(*acx), GFP_KERNEL);
+	if (!acx)
+		return -ENOMEM;
+
+	acx->enable = enable;
+	acx->default_action = action;
+	acx->special_packet_bitmask = 0;
+
+	ret = cc33xx_cmd_configure(cc, ACX_ENABLE_RX_DATA_FILTER, acx,
+				   sizeof(*acx));
+	if (ret < 0) {
+		cc33xx_warning("acx default rx filter enable failed: %d", ret);
+		goto out;
+	}
+
+out:
+	kfree(acx);
+	return ret;
+}
+
+static int cc33xx_rx_filter_get_fields_size(struct cc33xx_rx_filter *filter)
+{
+	int i, fields_size = 0;
+
+	for (i = 0; i < filter->num_fields; i++) {
+		fields_size += filter->fields[i].len - sizeof(u8 *)
+					+ sizeof(struct cc33xx_rx_filter_field);
+	}
+
+	return fields_size;
+}
+
+static void cc33xx_rx_filter_flatten_fields(struct cc33xx_rx_filter *filter,
+					    u8 *buf)
+{
+	int i;
+	struct cc33xx_rx_filter_field *field;
+
+	for (i = 0; i < filter->num_fields; i++) {
+		field = (struct cc33xx_rx_filter_field *)buf;
+
+		field->offset = filter->fields[i].offset;
+		field->flags = filter->fields[i].flags;
+		field->len = filter->fields[i].len;
+
+		memcpy(&field->pattern, filter->fields[i].pattern, field->len);
+		buf += sizeof(struct cc33xx_rx_filter_field) - sizeof(u8 *);
+		buf += field->len;
+	}
+}
+
+/* Configure or disable a specific RX filter pattern */
+int cc33xx_acx_set_rx_filter(struct cc33xx *cc, u8 index, bool enable,
+			     struct cc33xx_rx_filter *filter)
+{
+	struct acx_rx_filter_cfg *acx;
+	int fields_size = 0;
+	int acx_size;
+	int ret;
+
+	WARN_ON(enable && !filter);
+	WARN_ON(index >= CC33XX_MAX_RX_FILTERS);
+
+	cc33xx_debug(DEBUG_ACX,
+		     "acx set rx filter idx: %d enable: %d filter: %p",
+		     index, enable, filter);
+
+	if (enable) {
+		fields_size = cc33xx_rx_filter_get_fields_size(filter);
+
+		cc33xx_debug(DEBUG_ACX, "act: %d num_fields: %d field_size: %d",
+			     filter->action, filter->num_fields, fields_size);
+	}
+
+	acx_size = ALIGN(sizeof(*acx) + fields_size, 4);
+	acx = kzalloc(acx_size, GFP_KERNEL);
+
+	if (!acx)
+		return -ENOMEM;
+
+	acx->enable = enable;
+	acx->index = index;
+
+	if (enable) {
+		acx->num_fields = filter->num_fields;
+		acx->action = filter->action;
+		cc33xx_rx_filter_flatten_fields(filter, acx->fields);
+	}
+
+	cc33xx_dump(DEBUG_ACX, "RX_FILTER: ", acx, acx_size);
+
+	ret = cc33xx_cmd_configure(cc, ACX_SET_RX_DATA_FILTER, acx, acx_size);
+	if (ret < 0) {
+		cc33xx_warning("setting rx filter failed: %d", ret);
+		goto out;
+	}
+
+out:
+	kfree(acx);
+	return ret;
+}
+#endif /* CONFIG_PM */
+
+/* this command is basically the same as cc33xx_acx_ht_capabilities,
+ * with the addition of supported rates. they should be unified in
+ * the next fw api change
+ */
+int cc33xx_acx_set_peer_cap(struct cc33xx *cc,
+			    struct ieee80211_sta_ht_cap *ht_cap,
+			    struct ieee80211_sta_he_cap *he_cap,
+			    struct cc33xx_vif *wlvif, bool allow_ht_operation,
+			    u32 rate_set, u8 hlid)
+{
+	struct cc33xx_acx_peer_cap *acx;
+	int ret = 0;
+	u32 ht_capabilites = 0;
+	u8 *cap_info = NULL;
+	u8 dcm_max_const_rx_mask = IEEE80211_HE_PHY_CAP3_DCM_MAX_CONST_RX_MASK;
+	u8 partial_bw_ext_range = IEEE80211_HE_PHY_CAP6_PARTIAL_BW_EXT_RANGE;
+
+	cc33xx_debug(DEBUG_ACX,
+		     "acx set cap ht_supp: %d ht_cap: %d rates: 0x%x",
+		     ht_cap->ht_supported, ht_cap->cap, rate_set);
+
+	acx = kzalloc(sizeof(*acx), GFP_KERNEL);
+	if (!acx) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	if (allow_ht_operation && ht_cap->ht_supported) {
+		/* no need to translate capabilities - use the spec values */
+		ht_capabilites = ht_cap->cap;
+
+		/* this bit is not employed by the spec but only by FW to
+		 * indicate peer HT support
+		 */
+		ht_capabilites |= CC33XX_HT_CAP_HT_OPERATION;
+
+		/* get data from A-MPDU parameters field */
+		acx->ampdu_max_length = ht_cap->ampdu_factor;
+		acx->ampdu_min_spacing = ht_cap->ampdu_density;
+	}
+
+	acx->ht_capabilites = cpu_to_le32(ht_capabilites);
+	acx->supported_rates = cpu_to_le32(rate_set);
+
+	acx->role_id = wlvif->role_id;
+	acx->has_he = he_cap->has_he;
+	memcpy(acx->mac_cap_info, he_cap->he_cap_elem.mac_cap_info, 6);
+	cap_info = he_cap->he_cap_elem.phy_cap_info;
+	acx->nominal_packet_padding = (cap_info[8] & NOMINAL_PACKET_PADDING);
+	/* Max DCM constelation for RX - bits [4:3] in PHY capabilities byte 3 */
+	acx->dcm_max_constelation = (cap_info[3] & dcm_max_const_rx_mask) >> 3;
+	acx->er_upper_supported = ((cap_info[6] & partial_bw_ext_range) != 0);
+	ret = cc33xx_cmd_configure(cc, PEER_CAP_CFG, acx, sizeof(*acx));
+
+	if (ret < 0) {
+		cc33xx_warning("acx ht capabilities setting failed: %d", ret);
+		goto out;
+	}
+
+out:
+	kfree(acx);
+	return ret;
+}
+
+int cc33xx_acx_trigger_fw_assert(struct cc33xx *cc)
+{
+	struct debug_header *buf;
+	int ret;
+
+	cc33xx_debug(DEBUG_ACX, "acx trigger firmware assert");
+
+	buf = kzalloc(sizeof(*buf), GFP_KERNEL);
+	if (!buf) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	ret = cc33xx_cmd_debug(cc, TRIGGER_FW_ASSERT, buf, sizeof(*buf));
+	if (ret < 0) {
+		cc33xx_error("failed to trigger firmware assert");
+		goto out;
+	}
+
+out:
+	kfree(buf);
+	return ret;
+}
diff --git a/drivers/net/wireless/ti/cc33xx/acx.h b/drivers/net/wireless/ti/cc33xx/acx.h
new file mode 100644
index 000000000000..f250758c3da5
--- /dev/null
+++ b/drivers/net/wireless/ti/cc33xx/acx.h
@@ -0,0 +1,835 @@
+/* SPDX-License-Identifier: GPL-2.0-only
+ *
+ * Copyright (C) 2022-2024 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+#ifndef __ACX_H__
+#define __ACX_H__
+
+#include "cmd.h"
+#include "debug.h"
+
+enum {
+	/* Regular PS: simple sending of packets */
+	PS_SCHEME_LEGACY         = 0,
+	/* UPSD: sending a packet triggers a UPSD downstream*/
+	PS_SCHEME_UPSD_TRIGGER   = 1,
+	/* Mixed mode is partially supported: we are not going to sleep, and
+	 * triggers (on APSD AC's) are not sent when service period ends with
+	 * more_data = 1.
+	 */
+	PS_SCHEME_MIXED_MODE     = 2,
+	/* Legacy PSPOLL: a PSPOLL packet will be sent before every data packet
+	 * transmission in this queue.
+	 */
+	PS_SCHEME_LEGACY_PSPOLL  = 3,
+	/* Scheduled APSD mode. */
+	PS_SCHEME_SAPSD          = 4,
+	/* No PSPOLL: move to active after first packet. no need to sent pspoll */
+	PS_SCHEME_NOPSPOLL       = 5,
+
+	MAX_PS_SCHEME = PS_SCHEME_NOPSPOLL
+};
+
+/* Target's information element */
+struct acx_header {
+	struct cc33xx_cmd_header cmd;
+
+	/* acx (or information element) header */
+	__le16 id;
+
+	/* payload length (not including headers */
+	__le16 len;
+} __packed;
+
+struct debug_header {
+	struct cc33xx_cmd_header cmd;
+
+	/* debug (or information element) header */
+	__le16 id;
+
+	/* payload length (not including headers */
+	__le16 len;
+} __packed;
+
+enum cc33xx_role {
+	CC33XX_ROLE_STA = 0,
+	CC33XX_ROLE_IBSS,
+	CC33XX_ROLE_AP,
+	CC33XX_ROLE_DEVICE,
+	CC33XX_ROLE_P2P_CL,
+	CC33XX_ROLE_P2P_GO,
+	CC33XX_ROLE_MESH_POINT,
+
+	ROLE_TRANSCEIVER     = 16,
+
+	CC33XX_INVALID_ROLE_TYPE = 0xff
+};
+
+enum cc33xx_psm_mode {
+	/* Active mode */
+	CC33XX_PSM_CAM = 0,
+
+	/* Power save mode */
+	CC33XX_PSM_PS = 1,
+
+	/* Extreme low power */
+	CC33XX_PSM_ELP = 2,
+
+	CC33XX_PSM_MAX = CC33XX_PSM_ELP,
+
+	/* illegal out of band value of PSM mode */
+	CC33XX_PSM_ILLEGAL = 0xff
+};
+
+struct acx_sleep_auth {
+	struct acx_header header;
+
+	/* The sleep level authorization of the device. */
+	/* 0 - Always active*/
+	/* 1 - Power down mode: light / fast sleep*/
+	/* 2 - ELP mode: Deep / Max sleep*/
+	u8  sleep_auth;
+	u8  padding[3];
+} __packed;
+
+enum acx_slot_type {
+	SLOT_TIME_LONG = 0,
+	SLOT_TIME_SHORT = 1,
+	DEFAULT_SLOT_TIME = SLOT_TIME_SHORT,
+	MAX_SLOT_TIMES = 0xFF
+};
+
+struct acx_slot {
+	struct acx_header header;
+
+	u8 role_id;
+	u8 slot_time;
+	u8 reserved[2];
+} __packed;
+
+#define ACX_MC_ADDRESS_GROUP_MAX	(20)
+#define ADDRESS_GROUP_MAX_LEN		(ETH_ALEN * ACX_MC_ADDRESS_GROUP_MAX)
+
+struct acx_dot11_grp_addr_tbl {
+	struct acx_header header;
+
+	u8 enabled;
+	u8 num_groups;
+	u8 pad[2];
+	u8 mac_table[ADDRESS_GROUP_MAX_LEN];
+} __packed;
+
+struct acx_beacon_filter_option {
+	struct acx_header header;
+
+	u8 role_id;
+	u8 enable;
+	/* The number of beacons without the unicast TIM
+	 * bit set that the firmware buffers before
+	 * signaling the host about ready frames.
+	 * When set to 0 and the filter is enabled, beacons
+	 * without the unicast TIM bit set are dropped.
+	 */
+	u8 max_num_beacons;
+	u8 pad;
+} __packed;
+
+/* ACXBeaconFilterEntry (not 221)
+ * Byte Offset     Size (Bytes)    Definition
+ * ===========     ============    ==========
+ * 0               1               IE identifier
+ * 1               1               Treatment bit mask
+ *
+ * ACXBeaconFilterEntry (221)
+ * Byte Offset     Size (Bytes)    Definition
+ * ===========     ============    ==========
+ * 0               1               IE identifier
+ * 1               1               Treatment bit mask
+ * 2               3               OUI
+ * 5               1               Type
+ * 6               2               Version
+ *
+ *
+ * Treatment bit mask - The information element handling:
+ * bit 0 - The information element is compared and transferred
+ * in case of change.
+ * bit 1 - The information element is transferred to the host
+ * with each appearance or disappearance.
+ * Note that both bits can be set at the same time.
+ */
+
+enum {
+	BEACON_FILTER_TABLE_MAX_IE_NUM				= 32,
+	BEACON_FILTER_TABLE_MAX_VENDOR_SPECIFIC_IE_NUM		= 6,
+	BEACON_FILTER_TABLE_IE_ENTRY_SIZE			= 2,
+	BEACON_FILTER_TABLE_EXTRA_VENDOR_SPECIFIC_IE_SIZE	= 6
+};
+
+#define BEACON_FILTER_TABLE_MAX_SIZE					\
+		((BEACON_FILTER_TABLE_MAX_IE_NUM *			\
+		BEACON_FILTER_TABLE_IE_ENTRY_SIZE) +			\
+		(BEACON_FILTER_TABLE_MAX_VENDOR_SPECIFIC_IE_NUM *	\
+		BEACON_FILTER_TABLE_EXTRA_VENDOR_SPECIFIC_IE_SIZE))
+
+struct acx_beacon_filter_ie_table {
+	struct acx_header header;
+
+	u8 role_id;
+	u8 num_ie;
+	u8 pad[2];
+	u8 table[BEACON_FILTER_TABLE_MAX_SIZE];
+} __packed;
+
+struct acx_energy_detection {
+	struct acx_header header;
+
+	/* The RX Clear Channel Assessment threshold in the PHY */
+	__le16 rx_cca_threshold;
+	u8 tx_energy_detection;
+	u8 pad;
+} __packed;
+
+struct acx_event_mask {
+	struct acx_header header;
+
+	__le32 event_mask;
+	__le32 high_event_mask; /* Unused */
+} __packed;
+
+struct acx_tx_power_cfg {
+	struct acx_header header;
+
+	u8 role_id;
+	s8 tx_power;
+	u8 padding[2];
+} __packed;
+
+struct acx_wake_up_condition {
+	struct acx_header header;
+
+	u8 wake_up_event;
+	u8 listen_interval;
+	u8 padding[2];
+} __packed;
+
+struct assoc_info_cfg {
+	struct acx_header header;
+
+	u8 role_id;
+	__le16 aid;
+	u8 wmm_enabled;
+	u8 nontransmitted;
+	u8 bssid_index;
+	u8 bssid_indicator;
+	u8 transmitter_bssid[ETH_ALEN];
+	u8 ht_supported;
+	u8 vht_supported;
+	u8 has_he;
+} __packed;
+
+enum acx_preamble_type {
+	ACX_PREAMBLE_LONG = 0,
+	ACX_PREAMBLE_SHORT = 1
+};
+
+struct acx_preamble {
+	struct acx_header header;
+
+	/* When set, the WiLink transmits the frames with a short preamble and
+	 * when cleared, the WiLink transmits the frames with a long preamble.
+	 */
+	u8 role_id;
+	u8 preamble;
+	u8 padding[2];
+} __packed;
+
+enum acx_ctsprotect_type {
+	CTSPROTECT_DISABLE = 0,
+	CTSPROTECT_ENABLE = 1
+};
+
+struct acx_ctsprotect {
+	struct acx_header header;
+	u8 role_id;
+	u8 ctsprotect;
+	u8 padding[2];
+} __packed;
+
+struct ap_rates_class_cfg {
+	struct acx_header header;
+	u8 role_id;
+	__le32 basic_rates_set;
+	__le32 supported_rates;
+	u8 padding[3];
+} __packed;
+
+struct tx_param_cfg {
+	struct acx_header header;
+
+	u8 role_id;
+	u8 ac;
+	u8 aifsn;
+	u8 cw_min;
+
+	__le16 cw_max;
+	__le16 tx_op_limit;
+
+	__le16 acm;
+
+	u8 ps_scheme;
+
+	u8 is_mu_edca;
+	u8 mu_edca_aifs;
+	u8 mu_edca_ecw_min_max;
+	u8 mu_edca_timer;
+
+	u8 reserved;
+} __packed;
+
+struct cc33xx_acx_config_memory {
+	struct acx_header header;
+
+	u8 rx_mem_block_num;
+	u8 tx_min_mem_block_num;
+	u8 num_stations;
+	u8 num_ssid_profiles;
+	__le32 total_tx_descriptors;
+	u8 dyn_mem_enable;
+	u8 tx_free_req;
+	u8 rx_free_req;
+	u8 tx_min;
+	u8 fwlog_blocks;
+	u8 padding[3];
+} __packed;
+
+struct cc33xx_acx_mem_map {
+	struct acx_header header;
+
+	/* Number of blocks FW allocated for TX packets */
+	__le32 num_tx_mem_blocks;
+
+	/* Number of blocks FW allocated for RX packets */
+	__le32 num_rx_mem_blocks;
+
+	/* Number of TX descriptor that allocated. */
+	__le32 num_tx_descriptor;
+
+	__le32 tx_result;
+
+} __packed;
+
+struct cc33xx_acx_fw_versions {
+	struct acx_header header;
+
+	__le16 major_version;
+	__le16 minor_version;
+	__le16 api_version;
+	__le16 build_version;
+
+	u8 phy_version[6];
+	u8 padding[2];
+} __packed;
+
+/* special capability bit (not employed by the 802.11n spec) */
+#define CC33XX_HT_CAP_HT_OPERATION BIT(16)
+
+/* ACX_HT_BSS_OPERATION
+ * Configure HT capabilities - AP rules for behavior in the BSS.
+ */
+struct cc33xx_acx_ht_information {
+	struct acx_header header;
+
+	u8 role_id;
+
+	/* Values: 0 - RIFS not allowed, 1 - RIFS allowed */
+	u8 rifs_mode;
+
+	/* Values: 0 - 3 like in spec */
+	u8 ht_protection;
+
+	/* Values: 0 - GF protection not required, 1 - GF protection required */
+	u8 gf_protection;
+
+	/* Values: 0 - Dual CTS protection not required,
+	 *         1 - Dual CTS Protection required
+	 * Note: When this value is set to 1 FW will protect all TXOP with RTS
+	 * frame and will not use CTS-to-self regardless of the value of the
+	 * ACX_CTS_PROTECTION information element
+	 */
+	u8 dual_cts_protection;
+
+	__le32 he_operation;
+
+	__le16 bss_basic_mcs_set;
+	u8 qos_info_more_data_ack_bit;
+
+} __packed;
+
+struct cc33xx_acx_ba_receiver_setup {
+	struct acx_header header;
+
+	/* Specifies link id, range 0-31 */
+	u8 hlid;
+
+	u8 tid;
+
+	u8 enable;
+
+	/* Windows size in number of packets */
+	u8 win_size;
+
+	/* BA session starting sequence number.  RANGE 0-FFF */
+	__le16 ssn;
+
+	u8 padding[2];
+} __packed;
+
+struct cc33xx_acx_fw_tsf_information {
+	struct acx_header header;
+
+	u8 role_id;
+	u8 padding1[3];
+	__le32 current_tsf_high;
+	__le32 current_tsf_low;
+	__le32 last_bttt_high;
+	__le32 last_tbtt_low;
+	u8 last_dtim_count;
+	u8 padding2[3];
+} __packed;
+
+struct cc33xx_acx_config_ps {
+	struct acx_header header;
+
+	u8 exit_retries;
+	u8 enter_retries;
+	u8 padding[2];
+	__le32 null_data_rate;
+} __packed;
+
+#define ACX_RATE_MGMT_ALL_PARAMS 0xff
+
+struct acx_default_rx_filter {
+	struct acx_header header;
+	u8 enable;
+
+	/* action of type FILTER_XXX */
+	u8 default_action;
+
+	/* special packet bitmask - packet that use for trigger the host */
+	u8 special_packet_bitmask;
+
+	u8 padding;
+} __packed;
+
+struct acx_rx_filter_cfg {
+	struct acx_header header;
+
+	u8 enable;
+
+	/* 0 - WL1271_MAX_RX_FILTERS-1 */
+	u8 index;
+
+	u8 action;
+
+	u8 num_fields;
+	u8 fields[];
+} __packed;
+
+struct acx_roaming_stats {
+	struct acx_header header;
+
+	u8	role_id;
+	u8	pad[3];
+	__le32	missed_beacons;
+	u8	snr_data;
+	u8	snr_bacon;
+	s8	rssi_data;
+	s8	rssi_beacon;
+} __packed;
+
+enum cfg {
+	CTS_PROTECTION_CFG			= 0,
+	TX_PARAMS_CFG				= 1,
+	ASSOC_INFO_CFG				= 2,
+	PEER_CAP_CFG				= 3,
+	BSS_OPERATION_CFG			= 4,
+	SLOT_CFG				= 5,
+	PREAMBLE_TYPE_CFG			= 6,
+	DOT11_GROUP_ADDRESS_TBL			= 7,
+	BA_SESSION_RX_SETUP_CFG			= 8,
+	ACX_SLEEP_AUTH				= 9,
+	STATIC_CALIBRATION_CFG			= 10,
+	AP_RATES_CFG				= 11,
+	WAKE_UP_CONDITIONS_CFG			= 12,
+	SET_ANTENNA_SELECT_CFG			= 13,
+	TX_POWER_CFG				= 14,
+	VENDOR_IE_CFG				= 15,
+	START_COEX_STATISTICS_CFG		= 16,
+	BEACON_FILTER_OPT			= 17,
+	BEACON_FILTER_TABLE			= 18,
+	ACX_ENABLE_RX_DATA_FILTER		= 19,
+	ACX_SET_RX_DATA_FILTER			= 20,
+	ACX_GET_DATA_FILTER_STATISTICS		= 21,
+	TWT_SETUP				= 22,
+	TWT_TERMINATE				= 23,
+	TWT_SUSPEND				= 24,
+	TWT_RESUME				= 25,
+	ANT_DIV_ENABLE				= 26,
+	ANT_DIV_SET_RSSI_THRESHOLD		= 27,
+	ANT_DIV_SELECT_DEFAULT_ANTENNA		= 28,
+
+	LAST_CFG_VALUE,
+	MAX_DOT11_CFG = LAST_CFG_VALUE,
+
+	MAX_CFG = 0xFFFF	/*force enumeration to 16bits*/
+};
+
+enum cmd_debug {
+	UPLINK_MULTI_USER_CFG,
+	UPLINK_MULTI_USER_DATA_CFG,
+	OPERATION_MODE_CTRL_CFG,
+	UPLINK_POWER_HEADER_CFG,
+	MCS_FIXED_RATE_CFG,
+	GI_LTF_CFG,
+	TRANSMIT_OMI_CFG,
+	TB_ONLY_CFG,
+	BA_SESSION_CFG,
+	FORCE_PS_CFG,
+	RATE_OVERRRIDE_CFG,
+	BLS_CFG,
+	BLE_ENABLE,
+	SET_TSF,
+	RTS_TH_CFG,
+	LINK_ADAPT_CFG,
+	CALIB_BITMAP_CFG,
+	PWR_PARTIAL_MODES_CFG,
+	TRIGGER_FW_ASSERT,
+	BURST_MODE_CFG,
+
+	LAST_DEBUG_VALUE,
+
+	MAX_DEBUG = 0xFFFF /*force enumeration to 16bits*/
+
+};
+
+enum interrogate_opt {
+	MEM_MAP_INTR = 0,
+	GET_FW_VERSIONS_INTR = 1,
+	RSSI_INTR = 2,
+	GET_ANTENNA_SELECT_INTR = 3,
+	GET_PREAMBLE_AND_TX_RATE_INTR = 4,
+	GET_MAC_ADDRESS = 5,
+	READ_COEX_STATISTICS = 6,
+	LAST_IE_VALUE,
+	MAX_DOT11_IE = LAST_IE_VALUE,
+
+	MAX_IE = 0xFFFF /*force enumeration to 16bits*/
+};
+
+enum {
+	ACX_STATISTICS = LAST_CFG_VALUE,
+	ACX_CONFIG_PS,
+	ACX_CLEAR_STATISTICS		 = 0x0054,
+};
+
+struct cc33xx_acx_error_stats {
+	__le32 error_frame_non_ctrl;
+	__le32 error_frame_ctrl;
+	__le32 error_frame_during_protection;
+	__le32 null_frame_tx_start;
+	__le32 null_frame_cts_start;
+	__le32 bar_retry;
+	__le32 num_frame_cts_nul_flid;
+	__le32 tx_abort_failure;
+	__le32 tx_resume_failure;
+	__le32 rx_cmplt_db_overflow_cnt;
+	__le32 elp_while_rx_exch;
+	__le32 elp_while_tx_exch;
+	__le32 elp_while_tx;
+	__le32 elp_while_nvic_pending;
+	__le32 rx_excessive_frame_len;
+	__le32 burst_mismatch;
+	__le32 tbc_exch_mismatch;
+} __packed;
+
+#define NUM_OF_RATES_INDEXES 30
+struct cc33xx_acx_tx_stats {
+	__le32 tx_prepared_descs;
+	__le32 tx_cmplt;
+	__le32 tx_template_prepared;
+	__le32 tx_data_prepared;
+	__le32 tx_template_programmed;
+	__le32 tx_data_programmed;
+	__le32 tx_burst_programmed;
+	__le32 tx_starts;
+	__le32 tx_stop;
+	__le32 tx_start_templates;
+	__le32 tx_start_int_templates;
+	__le32 tx_start_fw_gen;
+	__le32 tx_start_data;
+	__le32 tx_start_null_frame;
+	__le32 tx_exch;
+	__le32 tx_retry_template;
+	__le32 tx_retry_data;
+	__le32 tx_retry_per_rate[NUM_OF_RATES_INDEXES];
+	__le32 tx_exch_pending;
+	__le32 tx_exch_expiry;
+	__le32 tx_done_template;
+	__le32 tx_done_data;
+	__le32 tx_done_int_template;
+	__le32 tx_cfe1;
+	__le32 tx_cfe2;
+	__le32 frag_called;
+	__le32 frag_mpdu_alloc_failed;
+	__le32 frag_init_called;
+	__le32 frag_in_process_called;
+	__le32 frag_tkip_called;
+	__le32 frag_key_not_found;
+	__le32 frag_need_fragmentation;
+	__le32 frag_bad_mblk_num;
+	__le32 frag_failed;
+	__le32 frag_cache_hit;
+	__le32 frag_cache_miss;
+} __packed;
+
+struct cc33xx_acx_rx_stats {
+	__le32 rx_beacon_early_term;
+	__le32 rx_out_of_mpdu_nodes;
+	__le32 rx_hdr_overflow;
+	__le32 rx_dropped_frame;
+	__le32 rx_done_stage;
+	__le32 rx_done;
+	__le32 rx_defrag;
+	__le32 rx_defrag_end;
+	__le32 rx_cmplt;
+	__le32 rx_pre_complt;
+	__le32 rx_cmplt_task;
+	__le32 rx_phy_hdr;
+	__le32 rx_timeout;
+	__le32 rx_rts_timeout;
+	__le32 rx_timeout_wa;
+	__le32 defrag_called;
+	__le32 defrag_init_called;
+	__le32 defrag_in_process_called;
+	__le32 defrag_tkip_called;
+	__le32 defrag_need_defrag;
+	__le32 defrag_decrypt_failed;
+	__le32 decrypt_key_not_found;
+	__le32 defrag_need_decrypt;
+	__le32 rx_tkip_replays;
+	__le32 rx_xfr;
+} __packed;
+
+struct cc33xx_acx_isr_stats {
+	__le32 irqs;
+} __packed;
+
+#define PWR_STAT_MAX_CONT_MISSED_BCNS_SPREAD 10
+
+struct cc33xx_acx_pwr_stats {
+	__le32 missing_bcns_cnt;
+	__le32 rcvd_bcns_cnt;
+	__le32 connection_out_of_sync;
+	__le32 cont_miss_bcns_spread[PWR_STAT_MAX_CONT_MISSED_BCNS_SPREAD];
+	__le32 rcvd_awake_bcns_cnt;
+	__le32 sleep_time_count;
+	__le32 sleep_time_avg;
+	__le32 sleep_cycle_avg;
+	__le32 sleep_percent;
+	__le32 ap_sleep_active_conf;
+	__le32 ap_sleep_user_conf;
+	__le32 ap_sleep_counter;
+} __packed;
+
+struct cc33xx_acx_rx_filter_stats {
+	__le32 beacon_filter;
+	__le32 arp_filter;
+	__le32 mc_filter;
+	__le32 dup_filter;
+	__le32 data_filter;
+	__le32 ibss_filter;
+	__le32 protection_filter;
+	__le32 accum_arp_pend_requests;
+	__le32 max_arp_queue_dep;
+} __packed;
+
+struct cc33xx_acx_rx_rate_stats {
+	__le32 rx_frames_per_rates[50];
+} __packed;
+
+#define AGGR_STATS_TX_AGG	16
+#define AGGR_STATS_RX_SIZE_LEN	16
+
+struct cc33xx_acx_aggr_stats {
+	__le32 tx_agg_rate[AGGR_STATS_TX_AGG];
+	__le32 tx_agg_len[AGGR_STATS_TX_AGG];
+	__le32 rx_size[AGGR_STATS_RX_SIZE_LEN];
+} __packed;
+
+#define PIPE_STATS_HW_FIFO	11
+
+struct cc33xx_acx_pipeline_stats {
+	__le32 hs_tx_stat_fifo_int;
+	__le32 hs_rx_stat_fifo_int;
+	__le32 enc_tx_stat_fifo_int;
+	__le32 enc_rx_stat_fifo_int;
+	__le32 rx_complete_stat_fifo_int;
+	__le32 pre_proc_swi;
+	__le32 post_proc_swi;
+	__le32 sec_frag_swi;
+	__le32 pre_to_defrag_swi;
+	__le32 defrag_to_rx_xfer_swi;
+	__le32 dec_packet_in;
+	__le32 dec_packet_in_fifo_full;
+	__le32 dec_packet_out;
+	__le16 pipeline_fifo_full[PIPE_STATS_HW_FIFO];
+	__le16 padding;
+} __packed;
+
+#define DIVERSITY_STATS_NUM_OF_ANT	2
+
+struct cc33xx_acx_diversity_stats {
+	__le32 num_of_packets_per_ant[DIVERSITY_STATS_NUM_OF_ANT];
+	__le32 total_num_of_toggles;
+} __packed;
+
+struct cc33xx_acx_thermal_stats {
+	__le16 irq_thr_low;
+	__le16 irq_thr_high;
+	__le16 tx_stop;
+	__le16 tx_resume;
+	__le16 false_irq;
+	__le16 adc_source_unexpected;
+} __packed;
+
+#define CC33XX_NUM_OF_CALIBRATIONS_ERRORS 18
+struct cc33xx_acx_calib_failure_stats {
+	__le16 fail_count[CC33XX_NUM_OF_CALIBRATIONS_ERRORS];
+	__le32 calib_count;
+} __packed;
+
+struct cc33xx_roaming_stats {
+	s32 rssi_level;
+} __packed;
+
+struct cc33xx_dfs_stats {
+	__le32 num_of_radar_detections;
+} __packed;
+
+struct cc33xx_acx_statistics {
+	struct acx_header header;
+
+	struct cc33xx_acx_error_stats		error;
+	struct cc33xx_acx_tx_stats		tx;
+	struct cc33xx_acx_rx_stats		rx;
+	struct cc33xx_acx_isr_stats		isr;
+	struct cc33xx_acx_pwr_stats		pwr;
+	struct cc33xx_acx_rx_filter_stats	rx_filter;
+	struct cc33xx_acx_rx_rate_stats		rx_rate;
+	struct cc33xx_acx_aggr_stats		aggr_size;
+	struct cc33xx_acx_pipeline_stats	pipeline;
+	struct cc33xx_acx_diversity_stats	diversity;
+	struct cc33xx_acx_thermal_stats		thermal;
+	struct cc33xx_acx_calib_failure_stats	calib;
+	struct cc33xx_roaming_stats		roaming;
+	struct cc33xx_dfs_stats			dfs;
+} __packed;
+
+/* ACX_PEER_CAP
+ * this struct is very similar to cc33xx_acx_ht_capabilities, with the
+ * addition of supported rates
+ */
+#define NOMINAL_PACKET_PADDING (0xC0)
+struct cc33xx_acx_peer_cap {
+	struct acx_header header;
+
+	u8 role_id;
+
+	/* rates supported by the remote peer */
+	__le32 supported_rates;
+
+	/* bitmask of capability bits supported by the peer */
+	__le32 ht_capabilites;
+	/* This the maximum A-MPDU length supported by the AP. The FW may not
+	 * exceed this length when sending A-MPDUs
+	 */
+	u8 ampdu_max_length;
+
+	/* This is the minimal spacing required when sending A-MPDUs to the AP*/
+	u8 ampdu_min_spacing;
+
+	/* HE capabilities */
+	u8 mac_cap_info[8];
+
+	/* Nominal packet padding value, used for determining the packet extension duration */
+	u8 nominal_packet_padding;
+
+	/* HE peer support */
+	bool has_he;
+
+	u8 dcm_max_constelation;
+
+	u8 er_upper_supported;
+
+	u8 padding;
+} __packed;
+
+struct acx_preamble_and_tx_rate {
+	struct acx_header header;
+	u16 tx_rate;
+	u8 preamble;
+	u8 role_id;
+} __packed;
+
+int cc33xx_acx_wake_up_conditions(struct cc33xx *cc, struct cc33xx_vif *wlvif,
+				  u8 wake_up_event, u8 listen_interval);
+int cc33xx_acx_sleep_auth(struct cc33xx *cc, u8 sleep_auth);
+int cc33xx_ble_enable(struct cc33xx *cc, u8 ble_enable);
+int cc33xx_acx_tx_power(struct cc33xx *cc, struct cc33xx_vif *wlvif, int power);
+int cc33xx_acx_slot(struct cc33xx *cc, struct cc33xx_vif *wlvif,
+		    enum acx_slot_type slot_time);
+int cc33xx_acx_group_address_tbl(struct cc33xx *cc, bool enable, void *mc_list, u32 mc_list_len);
+int cc33xx_acx_beacon_filter_opt(struct cc33xx *cc, struct cc33xx_vif *wlvif,
+				 bool enable_filter);
+int cc33xx_acx_beacon_filter_table(struct cc33xx *cc, struct cc33xx_vif *wlvif);
+int cc33xx_assoc_info_cfg(struct cc33xx *cc, struct cc33xx_vif *wlvif,
+			  struct ieee80211_sta *sta, u16 aid);
+int cc33xx_acx_set_preamble(struct cc33xx *cc, struct cc33xx_vif *wlvif,
+			    enum acx_preamble_type preamble);
+int cc33xx_acx_cts_protect(struct cc33xx *cc, struct cc33xx_vif *wlvif,
+			   enum acx_ctsprotect_type ctsprotect);
+int cc33xx_acx_statistics(struct cc33xx *cc, void *stats);
+int cc33xx_tx_param_cfg(struct cc33xx *cc, struct cc33xx_vif *wlvif, u8 ac,
+			u8 cw_min, u16 cw_max, u8 aifsn, u16 txop, bool acm,
+			u8 ps_scheme, u8 is_mu_edca, u8 mu_edca_aifs,
+			u8 mu_edca_ecw_min_max, u8 mu_edca_timer);
+int cc33xx_update_ap_rates(struct cc33xx *cc, u8 role_id,
+			   u32 basic_rates_set, u32 supported_rates);
+int cc33xx_acx_init_mem_config(struct cc33xx *cc);
+int cc33xx_acx_init_get_fw_versions(struct cc33xx *cc);
+int cc33xx_acx_set_ht_information(struct cc33xx *cc, struct cc33xx_vif *wlvif,
+				  u16 ht_operation_mode, u32 he_oper_params,
+				  u16 he_oper_nss_set);
+int cc33xx_acx_set_ba_receiver_session(struct cc33xx *cc, u8 tid_index, u16 ssn,
+				       bool enable, u8 peer_hlid, u8 win_size);
+int cc33xx_acx_tsf_info(struct cc33xx *cc,
+			struct cc33xx_vif *wlvif, u64 *mactime);
+int cc33xx_acx_config_ps(struct cc33xx *cc, struct cc33xx_vif *wlvif);
+int cc33xx_acx_get_tx_rate(struct cc33xx *cc, struct cc33xx_vif *wlvif,
+			   struct station_info *sinfo);
+int cc33xx_acx_average_rssi(struct cc33xx *cc,
+			    struct cc33xx_vif *wlvif, s8 *avg_rssi);
+int cc33xx_acx_default_rx_filter_enable(struct cc33xx *cc, bool enable,
+					enum rx_filter_action action);
+int cc33xx_acx_set_rx_filter(struct cc33xx *cc, u8 index, bool enable,
+			     struct cc33xx_rx_filter *filter);
+int cc33xx_acx_clear_statistics(struct cc33xx *cc);
+int cc33xx_acx_set_peer_cap(struct cc33xx *cc,
+			    struct ieee80211_sta_ht_cap *ht_cap,
+			    struct ieee80211_sta_he_cap *he_cap,
+			    struct cc33xx_vif *wlvif, bool allow_ht_operation,
+			    u32 rate_set, u8 hlid);
+int cc33xx_acx_trigger_fw_assert(struct cc33xx *cc);
+
+#endif /* __CC33XX_ACX_H__ */
-- 
2.25.1


