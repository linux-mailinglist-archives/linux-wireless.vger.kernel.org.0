Return-Path: <linux-wireless+bounces-15073-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 645899C0656
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2024 13:56:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23AAF28472F
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2024 12:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A96C215009;
	Thu,  7 Nov 2024 12:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="JfhY4Hns"
X-Original-To: linux-wireless@vger.kernel.org
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6066821442E;
	Thu,  7 Nov 2024 12:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730983984; cv=none; b=AjmuuKen+pTLDsqA/qWxig+25zXNsUaAgzrMA/5VhGfFPdn10lmC894MMld5+WCPZD/yf2B4lFd4gWAKUN7739NLxrtiQBaikr1fJzFEYyGZcgPRPef0X29ZL7bFinWYHR2l8KOAISOsXm0FA8kdY9HrP2j8QzR9aLEuYInENQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730983984; c=relaxed/simple;
	bh=Hf/7G60jaXIYK35ZCiFWQtP4c0TpBzXdq4DbMODo9/I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EGUeYkwars3uCgvpcefRmDd5Mpf5md5wyI6L8nIH2Hud0+d9CsuIDROReXcFdyfUai+NxCy+he5RRrznawRpo2+xkgutSJxveetnJ9XFKocO5FAhTCIDD1jEBfbdGO8DUrpAo2JxcJztHqsvll0w4ur7GcaeiwZtAADZ5VG5yzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=JfhY4Hns; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4A7CqtNP049083;
	Thu, 7 Nov 2024 06:52:55 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1730983975;
	bh=pfy1yy2gwNFOPkKPmfB3NTYFBRwvCDDq0Cd7DByNqtk=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=JfhY4HnsSgB35a40iyw8hb8dQa9d3JlyN4yKfez4tJNKmhnuGOO5siYnYC0W1nNh3
	 4vJy1J936IIsEeSsvGdH3XwrlH0tXndDipGA/8fA56loYQ9xellKWu6YliwB31Uh14
	 9hik7sz0Tdbs6xVZ90dExvwgBy3dS0CUrekLyu3U=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4A7Cqtoj100090;
	Thu, 7 Nov 2024 06:52:55 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 7
 Nov 2024 06:52:55 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 7 Nov 2024 06:52:55 -0600
Received: from localhost (udb0389739.dhcp.ti.com [137.167.1.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4A7CqsaZ054901;
	Thu, 7 Nov 2024 06:52:54 -0600
From: Michael Nemanov <michael.nemanov@ti.com>
To: Kalle Valo <kvalo@kernel.org>, "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo
 Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, <linux-wireless@vger.kernel.org>,
        <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Sabeeh Khan <sabeeh-khan@ti.com>, Michael Nemanov <michael.nemanov@ti.com>
Subject: [PATCH v5 12/17] wifi: cc33xx: Add init.c, init.h
Date: Thu, 7 Nov 2024 14:52:04 +0200
Message-ID: <20241107125209.1736277-13-michael.nemanov@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241107125209.1736277-1-michael.nemanov@ti.com>
References: <20241107125209.1736277-1-michael.nemanov@ti.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

High-level init code for new vifs

Signed-off-by: Michael Nemanov <michael.nemanov@ti.com>
---
 drivers/net/wireless/ti/cc33xx/init.c | 231 ++++++++++++++++++++++++++
 drivers/net/wireless/ti/cc33xx/init.h |  15 ++
 2 files changed, 246 insertions(+)
 create mode 100644 drivers/net/wireless/ti/cc33xx/init.c
 create mode 100644 drivers/net/wireless/ti/cc33xx/init.h

diff --git a/drivers/net/wireless/ti/cc33xx/init.c b/drivers/net/wireless/ti/cc33xx/init.c
new file mode 100644
index 000000000000..ff1fab1e0104
--- /dev/null
+++ b/drivers/net/wireless/ti/cc33xx/init.c
@@ -0,0 +1,231 @@
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
+	struct conf_tx_settings *tx_settings = &cc->conf.host_conf.tx;
+	struct conf_tx_ac_category *conf_ac = &tx_settings->ac_conf0;
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
+	if (WARN_ON(tx_settings->ac_conf_count != tx_settings->tid_conf_count) ||
+	    WARN_ON(tx_settings->ac_conf_count != CONF_TX_MAX_AC_COUNT))
+		return -EINVAL;
+
+	for (i = 0; i < tx_settings->tid_conf_count; i++) {
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
+
+		conf_ac++;
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
2.34.1


