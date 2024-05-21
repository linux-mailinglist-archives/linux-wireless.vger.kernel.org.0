Return-Path: <linux-wireless+bounces-7913-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D0A8CB2BF
	for <lists+linux-wireless@lfdr.de>; Tue, 21 May 2024 19:21:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADECE1F245BF
	for <lists+linux-wireless@lfdr.de>; Tue, 21 May 2024 17:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43033149C7E;
	Tue, 21 May 2024 17:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="jDPZjgI4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8CE71494C3;
	Tue, 21 May 2024 17:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716311973; cv=none; b=QIwzeaza5nYt0ZGPKMS70niULcWECISrkWgLD9OWrT//oQD5oWxUjxp9tOg0zXSTwRphw/2F8u2jk64Po5js1bZ3zF7H8lycPQDN7yec2zHVoF/NGgpSpm/cGKWVvumvxIbYRmVWfD8WNxjZJ/DsWyWM/3Z+W5U2mabDpXHyhIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716311973; c=relaxed/simple;
	bh=XXc4ZVHQ3468HjMOkaUtp+1/c9gRX3ItG55fZxqHGSU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rWsFQF0v9RNrQ0vWkLnq2chekAA40eLkYbVJnZq6d/D9b0LztKPdkujFA0L0/y/mERI6lN/66Z5TAso8XEoK/VpuUJfVesm7aD1dGyLu3ydnw+FqEZdmmfeBLtwvxNoXWBLqRpZcg6zzJ8VwKsdqoJ11sqGymWD/0Lb7dU1yfGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=jDPZjgI4; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44LHJCT6090430;
	Tue, 21 May 2024 12:19:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1716311952;
	bh=tfgFIKVbwd3mJpFFiifa6H/UE8QctylrB+jQUaYNqs0=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=jDPZjgI4+rnCCZkebI3C1upbIIPOW8coWvS7113T28twTw/OWeVYsStaZU+fh8vwG
	 9Uof4wtydN/sUjE7J4snjVFFzXiouGSVeRAZAgKW44ncQZDzzx8bKOg959yr/+IsVN
	 IhIvXLtlpqqrNd+G1kxQnWsko4vwECVxzwdw9wxM=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44LHJCED015148
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 21 May 2024 12:19:12 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 21
 May 2024 12:19:12 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 21 May 2024 12:19:12 -0500
Received: from localhost (uda0389739.dhcp.ti.com [137.167.1.114])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44LHJBKB023437;
	Tue, 21 May 2024 12:19:11 -0500
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
Subject: [PATCH 11/17] Add init.c, init.h
Date: Tue, 21 May 2024 20:18:35 +0300
Message-ID: <20240521171841.884576-12-michael.nemanov@ti.com>
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

High-level init code for new vifs

Signed-off-by: Michael Nemanov <michael.nemanov@ti.com>
---
 drivers/net/wireless/ti/cc33xx/init.c | 236 ++++++++++++++++++++++++++
 drivers/net/wireless/ti/cc33xx/init.h |  15 ++
 2 files changed, 251 insertions(+)
 create mode 100644 drivers/net/wireless/ti/cc33xx/init.c
 create mode 100644 drivers/net/wireless/ti/cc33xx/init.h

diff --git a/drivers/net/wireless/ti/cc33xx/init.c b/drivers/net/wireless/ti/cc33xx/init.c
new file mode 100644
index 000000000000..f338901ea96d
--- /dev/null
+++ b/drivers/net/wireless/ti/cc33xx/init.c
@@ -0,0 +1,236 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2022-2024 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+#include <linux/firmware.h>
+#include "acx.h"
+#include "cmd.h"
+#include "conf.h"
+#include "event.h"
+#include "tx.h"
+#include "init.h"
+
+static int cc33xx_init_phy_vif_config(struct cc33xx *cc,
+				      struct cc33xx_vif *wlvif)
+{
+	int ret;
+
+	ret = cc33xx_acx_slot(cc, wlvif, DEFAULT_SLOT_TIME);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static int cc33xx_init_sta_beacon_filter(struct cc33xx *cc,
+					 struct cc33xx_vif *wlvif)
+{
+	int ret;
+
+	ret = cc33xx_acx_beacon_filter_table(cc, wlvif);
+	if (ret < 0)
+		return ret;
+
+	/* disable beacon filtering until we get the first beacon */
+	ret = cc33xx_acx_beacon_filter_opt(cc, wlvif, false);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static int cc33xx_ap_init_templates(struct cc33xx *cc,
+				    struct ieee80211_vif *vif)
+{
+	struct cc33xx_vif *wlvif = cc33xx_vif_to_data(vif);
+	int ret;
+
+	/* when operating as AP we want to receive external beacons for
+	 * configuring ERP protection.
+	 */
+	ret = cc33xx_acx_beacon_filter_opt(cc, wlvif, false);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static void cc33xx_set_ba_policies(struct cc33xx *cc, struct cc33xx_vif *wlvif)
+{
+	/* Reset the BA RX indicators */
+	wlvif->ba_allowed = true;
+	cc->ba_rx_session_count = 0;
+
+	/* BA is supported in STA/AP modes */
+	wlvif->ba_support = (wlvif->bss_type != BSS_TYPE_AP_BSS &&
+				wlvif->bss_type != BSS_TYPE_STA_BSS);
+}
+
+/* vif-specifc initialization */
+static int cc33xx_init_sta_role(struct cc33xx *cc, struct cc33xx_vif *wlvif)
+{
+	int ret = cc33xx_acx_group_address_tbl(cc, true, NULL, 0);
+
+	if (ret < 0)
+		return ret;
+
+	/* Beacon filtering */
+	ret = cc33xx_init_sta_beacon_filter(cc, wlvif);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+/* vif-specific initialization */
+static int cc33xx_init_ap_role(struct cc33xx *cc, struct cc33xx_vif *wlvif)
+{
+	int ret;
+
+	/* initialize Tx power */
+	ret = cc33xx_acx_tx_power(cc, wlvif, wlvif->power_level);
+	if (ret < 0)
+		return ret;
+
+	if (cc->radar_debug_mode)
+		cc33xx_cmd_generic_cfg(cc, wlvif,
+				       CC33XX_CFG_FEATURE_RADAR_DEBUG,
+				       cc->radar_debug_mode, 0);
+
+	return 0;
+}
+
+int cc33xx_init_vif_specific(struct cc33xx *cc, struct ieee80211_vif *vif)
+{
+	struct cc33xx_vif *wlvif = cc33xx_vif_to_data(vif);
+	struct conf_tx_ac_category *conf_ac;
+	struct conf_tx_ac_category ac_conf[4];
+	struct conf_tx_tid tid_conf[8];
+	struct conf_tx_settings *tx_settings = &cc->conf.host_conf.tx;
+	struct conf_tx_ac_category *p_wl_host_ac_conf = &tx_settings->ac_conf0;
+	struct conf_tx_tid *p_wl_host_tid_conf = &tx_settings->tid_conf0;
+	bool is_ap = (wlvif->bss_type == BSS_TYPE_AP_BSS);
+	u8 ps_scheme = cc->conf.mac.ps_scheme;
+	int ret, i;
+
+	/* consider all existing roles before configuring psm. */
+
+	if (cc->ap_count == 0 && is_ap) { /* first AP */
+		ret = cc33xx_acx_sleep_auth(cc, CC33XX_PSM_ELP);
+		if (ret < 0)
+			return ret;
+
+		/* unmask ap events */
+		cc->event_mask |= cc->ap_event_mask;
+
+	/* first STA, no APs */
+	} else if (cc->sta_count == 0 && cc->ap_count == 0 && !is_ap) {
+		u8 sta_auth = cc->conf.host_conf.conn.sta_sleep_auth;
+		/* Configure for power according to debugfs */
+		if (sta_auth != CC33XX_PSM_ILLEGAL)
+			ret = cc33xx_acx_sleep_auth(cc, sta_auth);
+		/* Configure for ELP power saving */
+		else
+			ret = cc33xx_acx_sleep_auth(cc, CC33XX_PSM_ELP);
+
+		if (ret < 0)
+			return ret;
+	}
+
+	/* Mode specific init */
+	if (is_ap) {
+		ret = cc33xx_init_ap_role(cc, wlvif);
+		if (ret < 0)
+			return ret;
+	} else {
+		ret = cc33xx_init_sta_role(cc, wlvif);
+		if (ret < 0)
+			return ret;
+	}
+
+	cc33xx_init_phy_vif_config(cc, wlvif);
+
+	/* Default TID/AC configuration */
+	WARN_ON(tx_settings->tid_conf_count != tx_settings->ac_conf_count);
+	memcpy(ac_conf, p_wl_host_ac_conf, 4 * sizeof(struct conf_tx_ac_category));
+	memcpy(tid_conf, p_wl_host_tid_conf, 8 * sizeof(struct conf_tx_tid));
+
+	for (i = 0; i < tx_settings->tid_conf_count; i++) {
+		conf_ac =  &ac_conf[i];
+
+		/* If no ps poll is used, send legacy ps scheme in cmd */
+		if (ps_scheme == PS_SCHEME_NOPSPOLL)
+			ps_scheme = PS_SCHEME_LEGACY;
+
+		ret = cc33xx_tx_param_cfg(cc, wlvif, conf_ac->ac,
+					  conf_ac->cw_min, conf_ac->cw_max,
+					  conf_ac->aifsn, conf_ac->tx_op_limit,
+					  false, ps_scheme, conf_ac->is_mu_edca,
+					  conf_ac->mu_edca_aifs,
+					  conf_ac->mu_edca_ecw_min_max,
+					  conf_ac->mu_edca_timer);
+
+		if (ret < 0)
+			return ret;
+	}
+
+	/* Mode specific init - post mem init */
+	if (is_ap)
+		ret = cc33xx_ap_init_templates(cc, vif);
+
+	if (ret < 0)
+		return ret;
+
+	/* Configure initiator BA sessions policies */
+	cc33xx_set_ba_policies(cc, wlvif);
+
+	return 0;
+}
+
+int cc33xx_hw_init(struct cc33xx *cc)
+{
+	cc33xx_acx_init_mem_config(cc);
+
+	cc33xx_debug(DEBUG_TX, "available tx blocks: %d", 16);
+	cc->last_fw_rls_idx = 0;
+	cc->partial_rx.status = CURR_RX_START;
+	return 0;
+}
+
+int cc33xx_download_ini_params_and_wait(struct cc33xx *cc)
+{
+	struct cc33xx_cmd_ini_params_download *cmd;
+	size_t command_size = ALIGN((sizeof(*cmd) + sizeof(cc->conf)), 4);
+	int ret;
+
+	cc33xx_set_max_buffer_size(cc, INI_MAX_BUFFER_SIZE);
+
+	cc33xx_debug(DEBUG_ACX,
+		     "Downloading INI configurations to FW, payload Length: %zu",
+		     sizeof(cc->conf));
+
+	cmd = kzalloc(command_size, GFP_KERNEL);
+	if (!cmd) {
+		cc33xx_set_max_buffer_size(cc, CMD_MAX_BUFFER_SIZE);
+		return -ENOMEM;
+	}
+
+	cmd->length = cpu_to_le32(sizeof(cc->conf));
+
+	/* copy INI file params payload */
+	memcpy((cmd->payload), &cc->conf, sizeof(cc->conf));
+
+	ret = cc33xx_cmd_send(cc, CMD_DOWNLOAD_INI_PARAMS,
+			      cmd, command_size, 0);
+	if (ret < 0) {
+		cc33xx_warning("download INI params to FW command sending failed: %d",
+			       ret);
+	} else {
+		cc33xx_debug(DEBUG_BOOT, "INI Params downloaded successfully");
+	}
+
+	cc33xx_set_max_buffer_size(cc, CMD_MAX_BUFFER_SIZE);
+	kfree(cmd);
+	return ret;
+}
diff --git a/drivers/net/wireless/ti/cc33xx/init.h b/drivers/net/wireless/ti/cc33xx/init.h
new file mode 100644
index 000000000000..b0bc6a548611
--- /dev/null
+++ b/drivers/net/wireless/ti/cc33xx/init.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0-only
+ *
+ * Copyright (C) 2022-2024 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+#ifndef __INIT_H__
+#define __INIT_H__
+
+#include "cc33xx.h"
+
+int cc33xx_hw_init(struct cc33xx *cc);
+int cc33xx_download_ini_params_and_wait(struct cc33xx *cc);
+int cc33xx_init_vif_specific(struct cc33xx *cc, struct ieee80211_vif *vif);
+
+#endif /* __INIT_H__ */
-- 
2.25.1


