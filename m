Return-Path: <linux-wireless+bounces-21659-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B10A91ECE
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Apr 2025 15:54:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36BC919E197C
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Apr 2025 13:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12AF224EF68;
	Thu, 17 Apr 2025 13:54:09 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFE0324EAA4
	for <linux-wireless@vger.kernel.org>; Thu, 17 Apr 2025 13:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744898049; cv=none; b=ubX9Sg0PhLoQTLgqZxGdEWbEJOpKBAECjsvPjQKVsKYEh8BuL0x2DytmkyNeWDWOkc7+yscelGvws2NHaGgo2uCZIjXYcpzjNyzuH/sD/ynaMiuWDGcRBnZXxWUF320j1hpg53ddRubUwpAiGnfG2j3m5lpAcv0abirod2/0UKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744898049; c=relaxed/simple;
	bh=TYqN0s/p4DPh6CuF9kfN0ED80d4CB9cr5uNaZng0yac=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=P/9o65MruxWDvPyQqAbTsCHlIQiZ5QtgLfz/Z1ZzXPJmW2GgsoB9LRIRI72Oau5/hPNcyuYrb5+WhJf+N743XdxCJ9LbcPJM2/zQsSftELHwdWbWeJSwp5nxXukolgWKqgtPeeEqgk8YrJasKHgR+4EJzNwTXUlRYG0/GkXXJcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: UZpbQ4hRSOun4MpRpSPpEA==
X-CSE-MsgGUID: uOilWCS4QFCrx5ViG5/oeQ==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 17 Apr 2025 22:54:06 +0900
Received: from localhost.localdomain (unknown [10.14.100.3])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 5131E4005B3F;
	Thu, 17 Apr 2025 22:54:02 +0900 (JST)
From: Alexander Savchenko <oleksandr.savchenko.dn@bp.renesas.com>
To: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes@sipsolutions.net>
Cc: Sergiy Petrov <sergiy.petrov.ue@bp.renesas.com>,
	Viktor Barna <viktor.barna.rj@bp.renesas.com>,
	Gal Gur <gal.gur.jx@renesas.com>,
	Alexander Savchenko <oleksandr.savchenko.dn@bp.renesas.com>
Subject: [PATCH 19/38] ra6w: add params.c
Date: Thu, 17 Apr 2025 16:52:17 +0300
Message-Id: <20250417135236.52410-20-oleksandr.savchenko.dn@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250417135236.52410-1-oleksandr.savchenko.dn@bp.renesas.com>
References: <20250417135236.52410-1-oleksandr.savchenko.dn@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

Part of the split. Please, take a look at the cover letter for more details

Reviewed-by: Viktor Barna <viktor.barna.rj@bp.renesas.com>
Reviewed-by: Gal Gur <gal.gur.jx@renesas.com>
Signed-off-by: Alexander Savchenko <oleksandr.savchenko.dn@bp.renesas.com>
---
 drivers/net/wireless/renesas/ra6w/params.c | 387 +++++++++++++++++++++
 1 file changed, 387 insertions(+)
 create mode 100644 drivers/net/wireless/renesas/ra6w/params.c

diff --git a/drivers/net/wireless/renesas/ra6w/params.c b/drivers/net/wireless/renesas/ra6w/params.c
new file mode 100644
index 000000000000..c428fe7b648b
--- /dev/null
+++ b/drivers/net/wireless/renesas/ra6w/params.c
@@ -0,0 +1,387 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * This file contains driver parameters operations.
+ *
+ * Copyright (C) [2022-2025] Renesas Electronics Corporation and/or its affiliates.
+ */
+
+#include <linux/version.h>
+#include <linux/module.h>
+#include <linux/rtnetlink.h>
+#include <net/cfg80211.h>
+
+#include "dbg.h"
+#include "core.h"
+#include "cfg80211.h"
+#include "params.h"
+
+#define RA6W_PHY_FEAT_CHBW_MASK	0x03000000
+#define RA6W_PHY_FEAT_CHBW_LSB	24
+#define RA6W_PHY_FEAT_NSS_MASK	0x00000F00
+#define RA6W_PHY_FEAT_NSS_LSB	8
+
+struct ra6w_params ra6w_params_list = {
+	.module_params = {
+		.stbc_enabled = true,
+		.ldpc_enabled = true,
+		.dpsm_enabled = true,
+		.ht_supported = true,
+		.rx_amsdu_size = 2,
+		.mcs_map_range = IEEE80211_VHT_MCS_SUPPORT_0_8,
+		.use_sgi = true,
+		.bfmer_enabled = true,
+		.he_mcs_map_range = IEEE80211_HE_MCS_SUPPORT_0_9,
+		.ap_uapsd_enabled = true,
+		.regdom_mode = "auto",
+		.log_level = RA6W_DEFAULT_LOG_LVL,
+	},
+	.features = {
+		.uapsd_threshold = RA6W_CFG80211_UAPSD_TIMEOUT,
+	}
+};
+
+static struct ieee80211_regdomain ra6w_regdom = {
+	.n_reg_rules = 2,
+	.alpha2 = "99",
+	.reg_rules = {
+		REG_RULE(2390 - 10, 2510 + 10, 20, 0, 20, 0),
+		REG_RULE(5150 - 10, 5970 + 10, 20, 0, 20, 0),
+	}
+};
+
+module_param_named(stbc_enabled, ra6w_params_list.module_params.stbc_enabled, bool, 0444);
+MODULE_PARM_DESC(stbc_enabled, "Enable STBC (Default: 1)");
+
+module_param_named(ldpc_enabled, ra6w_params_list.module_params.ldpc_enabled, bool, 0444);
+MODULE_PARM_DESC(ldpc_enabled, "Enable LDPC (Default: 1)");
+
+module_param_named(ant_div, ra6w_params_list.module_params.ant_div, bool, 0444);
+MODULE_PARM_DESC(ant_div, "Enable Antenna Diversity (Default: 0)");
+
+module_param_named(ht_supported, ra6w_params_list.module_params.ht_supported, bool, 0444);
+MODULE_PARM_DESC(ht_supported, "HT Enabled (Default: 1)");
+
+module_param_named(amsdu_require_spp,
+		   ra6w_params_list.module_params.amsdu_require_spp, bool, 0444);
+MODULE_PARM_DESC(amsdu_require_spp, "Require usage of SPP A-MSDU (Default: 0)");
+
+module_param_named(bfmer_enabled, ra6w_params_list.module_params.bfmer_enabled, bool, 0444);
+MODULE_PARM_DESC(bfmer_enabled, "Beem Former Enabled. (Default: 1)");
+
+module_param_named(dpsm_enabled, ra6w_params_list.module_params.dpsm_enabled, bool, 0444);
+MODULE_PARM_DESC(dpsm_enabled, "Dynamic Power Save Mode Enabled (Default: 1)");
+
+module_param_named(ap_uapsd_enabled, ra6w_params_list.module_params.ap_uapsd_enabled, bool, 0444);
+MODULE_PARM_DESC(ap_uapsd_enabled, "AP UAPSD Enabled. (Default: 1)");
+
+module_param_named(use_sgi, ra6w_params_list.module_params.use_sgi, bool, 0444);
+MODULE_PARM_DESC(use_sgi, "SGI. (Default: 1: on)");
+
+module_param_named(ccmp256_supported,
+		   ra6w_params_list.module_params.ccmp256_supported, bool, 0444);
+MODULE_PARM_DESC(ccmp256_supported, "CCMP256 Supported. (Default: 0)");
+
+module_param_named(regdom_mode, ra6w_params_list.module_params.regdom_mode, charp, 0444);
+MODULE_PARM_DESC(regdom_mode, "Regulatory mode (auto/self). default: auto");
+
+module_param_named(rx_amsdu_size, ra6w_params_list.module_params.rx_amsdu_size, byte, 0444);
+MODULE_PARM_DESC(rx_amsdu_size, "RX AMSDU SIZE. (Default: 2)");
+
+module_param_named(mcs_map_range, ra6w_params_list.module_params.mcs_map_range, byte, 0444);
+MODULE_PARM_DESC(mcs_map_range, "MCS MAP. (Default: 1");
+
+module_param_named(he_mcs_map_range, ra6w_params_list.module_params.he_mcs_map_range, byte, 0444);
+MODULE_PARM_DESC(he_mcs_map_range, "HE MCS MAP. (Default: 1)");
+
+module_param_named(log_level, ra6w_params_list.module_params.log_level, int, 0644);
+MODULE_PARM_DESC(log_level, "log_level (Default: 3: info)");
+
+static u8 ra6w_params_phy_bw_get(const struct ra6w_sys_info *sinfo)
+{
+	u32 phy_feat = le32_to_cpu(sinfo->fw_ver.phy_feature);
+
+	return (phy_feat & RA6W_PHY_FEAT_CHBW_MASK) >> RA6W_PHY_FEAT_CHBW_LSB;
+}
+
+static u8 ra6w_params_phy_nss_get(const struct ra6w_sys_info *sinfo)
+{
+	u32 phy_feat = le32_to_cpu(sinfo->fw_ver.phy_feature);
+
+	return (phy_feat & RA6W_PHY_FEAT_NSS_MASK) >> RA6W_PHY_FEAT_NSS_LSB;
+}
+
+static bool ra6w_params_mac_gcmp_get(const struct ra6w_sys_info *sinfo)
+{
+	u32 mac_feat = le32_to_cpu(sinfo->fw_ver.machw_features);
+
+	return mac_feat & BIT(RA6W_MAC_FEAT_GCMP_BIT);
+}
+
+static u8 ra6w_params_rx_amsdu_size_get(const struct ra6w_sys_info *sinfo)
+{
+	u32 feat = le32_to_cpu(sinfo->fw_ver.features);
+
+	return (feat >> RA6W_DEV_FEAT_AMSDU_MAX_SIZE_0_BIT) & 0x03;
+}
+
+static bool ra6w_params_feat(u32 dev_feat, enum ra6w_params_dev_feat id)
+{
+	return dev_feat & BIT(id);
+}
+
+static int ra6w_params_features_set(struct ra6w_core *core)
+{
+	int ret = 0;
+	u32 feat;
+	u32 phy_vers;
+	u16 max_sta_nb;
+	u8 max_vif_nb;
+	u8 amsdu_rx = 0;
+	struct ra6w_sys_info *sinfo = &core->sinfo;
+	struct ra6w_params_module_params *module_params = &ra6w_params_list.module_params;
+	struct ra6w_params_dev_features *features = &ra6w_params_list.features;
+
+	feat = le32_to_cpu(sinfo->fw_ver.features);
+	if (!ra6w_params_feat(feat, RA6W_DEV_FEAT_UMAC_BIT)) {
+		ra6w_err("UMAC is not supported\n");
+		return -ENOENT;
+	}
+
+	features->vht_supported = ra6w_params_feat(feat, RA6W_DEV_FEAT_VHT_BIT);
+	features->he_supported = ra6w_params_feat(feat, RA6W_DEV_FEAT_HE_BIT);
+	features->he_ul_on = ra6w_params_feat(feat, RA6W_DEV_FEAT_HE_BIT);
+	features->ps_supported = ra6w_params_feat(feat, RA6W_DEV_FEAT_PS_BIT);
+	features->amsdu_supported = ra6w_params_feat(feat, RA6W_DEV_FEAT_AMSDU_BIT);
+	features->bfmee_enabled = ra6w_params_feat(feat, RA6W_DEV_FEAT_BFMEE_BIT);
+	features->tdls_supported = ra6w_params_feat(feat, RA6W_DEV_FEAT_TDLS_BIT);
+	features->wapi_supported = ra6w_params_feat(feat, RA6W_DEV_FEAT_WAPI_BIT);
+	features->mfp_supported = ra6w_params_feat(feat, RA6W_DEV_FEAT_MFP_BIT);
+	features->radar_supported = ra6w_params_feat(feat, RA6W_DEV_FEAT_RADAR_BIT);
+	features->mu_mimo_rx_enabled = ra6w_params_feat(feat, RA6W_DEV_FEAT_MU_MIMO_RX_BIT);
+	features->mu_mimo_tx_enabled = ra6w_params_feat(feat, RA6W_DEV_FEAT_MU_MIMO_TX_BIT);
+	features->twt_enabled = ra6w_params_feat(feat, RA6W_DEV_FEAT_TWT_BIT);
+
+	amsdu_rx = ra6w_params_rx_amsdu_size_get(sinfo);
+	module_params->rx_amsdu_size = min(amsdu_rx, module_params->rx_amsdu_size);
+
+	if (!ra6w_params_feat(feat, RA6W_DEV_FEAT_UAPSD_BIT))
+		features->uapsd_threshold = 0;
+
+	features->bw_max = ra6w_params_phy_bw_get(sinfo);
+
+	if (!module_params->ht_supported) {
+		features->vht_supported = false;
+		features->he_supported = false;
+	}
+
+	if (features->he_supported && !module_params->ldpc_enabled)
+		module_params->he_mcs_map_range = min_t(u8, module_params->he_mcs_map_range,
+							IEEE80211_HE_MCS_SUPPORT_0_9);
+
+	phy_vers = le32_to_cpu(sinfo->fw_ver.phy_version);
+
+	if (!features->mu_mimo_rx_enabled || !features->bfmee_enabled)
+		features->mu_mimo_rx_enabled = false;
+
+	features->gcmp_supported = ra6w_params_mac_gcmp_get(sinfo);
+
+	if (core->sinfo.machw_support_type >= RA6W_MACHW_SUPPORT_HE)
+		module_params->ccmp256_supported = true;
+
+	features->nss = ra6w_params_phy_nss_get(sinfo);
+
+	max_sta_nb = le16_to_cpu(sinfo->fw_ver.max_sta_nb);
+	if (max_sta_nb != RA6W_CFG80211_STA_MAX) {
+		ra6w_err("Number of supported stations by driver not fit to FW (%d != %d)\n",
+			 RA6W_CFG80211_STA_MAX, max_sta_nb);
+		ret = -ENOENT;
+	}
+
+	max_vif_nb = sinfo->fw_ver.max_vif_nb;
+	if (max_vif_nb != RA6W_CFG80211_VIF_MAX) {
+		ra6w_err("Number of virtual interfaces in driver not fit to FW (%d != %d)\n",
+			 RA6W_CFG80211_VIF_MAX, max_vif_nb);
+		ret = -ENOENT;
+	}
+
+	return ret;
+}
+
+int ra6w_params_init(struct ra6w_core *core)
+{
+	return ra6w_params_features_set(core);
+}
+
+bool ra6w_params_regd_mode_is_auto(void)
+{
+	return !strcmp(ra6w_params_list.module_params.regdom_mode, "auto");
+}
+
+int ra6w_params_regd_set_self(struct wiphy *wiphy)
+{
+	struct ra6w_cfg80211_priv *priv = wiphy_priv(wiphy);
+	int ret;
+
+	if (!(wiphy->regulatory_flags & REGULATORY_WIPHY_SELF_MANAGED))
+		return 0;
+
+	ret = regulatory_set_wiphy_regd(wiphy, &ra6w_regdom);
+	if (ret)
+		return ret;
+
+	ra6w_info("regdom mode: self\n");
+
+	memcpy(priv->phy_config.country_code, ra6w_regdom.alpha2, sizeof(ra6w_regdom.alpha2));
+
+	return ra6w_ctrl_chan_config(&priv->core->ctrl, wiphy);
+}
+
+bool ra6w_params_ps_supported(void)
+{
+	return ra6w_params_list.features.ps_supported;
+}
+
+bool ra6w_params_dpsm_enabled(void)
+{
+	return ra6w_params_list.module_params.dpsm_enabled;
+}
+
+bool ra6w_params_amsdu_require_spp(void)
+{
+	return ra6w_params_list.module_params.amsdu_require_spp;
+}
+
+bool ra6w_params_ht_supported(void)
+{
+	return ra6w_params_list.module_params.ht_supported;
+}
+
+bool ra6w_params_vht_supported(void)
+{
+	return ra6w_params_list.features.vht_supported;
+}
+
+bool ra6w_params_he_supported(void)
+{
+	return ra6w_params_list.features.he_supported;
+}
+
+bool ra6w_params_he_ul_on(void)
+{
+	return ra6w_params_list.features.he_ul_on;
+}
+
+bool ra6w_params_wapi_supported(void)
+{
+	return ra6w_params_list.features.wapi_supported;
+}
+
+bool ra6w_params_mfp_supported(void)
+{
+	return ra6w_params_list.features.mfp_supported;
+}
+
+bool ra6w_params_ap_uapsd_enabled(void)
+{
+	return ra6w_params_list.module_params.ap_uapsd_enabled;
+}
+
+bool ra6w_params_tdls_supported(void)
+{
+	return ra6w_params_list.features.tdls_supported;
+}
+
+bool ra6w_params_gcmp_supported(void)
+{
+	return ra6w_params_list.features.gcmp_supported;
+}
+
+bool ra6w_params_ccmp256_supported(void)
+{
+	return ra6w_params_list.module_params.ccmp256_supported;
+}
+
+bool ra6w_params_bfmee_enabled(void)
+{
+	return ra6w_params_list.features.bfmee_enabled;
+}
+
+bool ra6w_params_bfmer_enabled(void)
+{
+	return ra6w_params_list.module_params.bfmer_enabled;
+}
+
+bool ra6w_params_ldpc_enabled(void)
+{
+	return ra6w_params_list.module_params.ldpc_enabled;
+}
+
+bool ra6w_params_stbc_enabled(void)
+{
+	return ra6w_params_list.module_params.stbc_enabled;
+}
+
+u8 ra6w_params_bw_max_get(void)
+{
+	return ra6w_params_list.features.bw_max;
+}
+
+bool ra6w_params_use_sgi(void)
+{
+	return ra6w_params_list.module_params.use_sgi;
+}
+
+bool ra6w_params_mu_mimo_rx_enabled(void)
+{
+	return ra6w_params_list.features.mu_mimo_rx_enabled;
+}
+
+bool ra6w_params_mu_mimo_tx_enabled(void)
+{
+	return ra6w_params_list.features.mu_mimo_tx_enabled;
+}
+
+bool ra6w_params_twt_enabled(void)
+{
+	return ra6w_params_list.features.twt_enabled;
+}
+
+u32 ra6w_params_uapsd_threshold(void)
+{
+	return ra6w_params_list.features.uapsd_threshold;
+}
+
+bool ra6w_params_ant_div(void)
+{
+	return ra6w_params_list.module_params.ant_div;
+}
+
+u32 ra6w_params_log_level(void)
+{
+	return ra6w_params_list.module_params.log_level;
+}
+
+void ra6w_params_log_level_set(u32 log_level)
+{
+	ra6w_params_list.module_params.log_level = log_level;
+}
+
+u8 ra6w_params_nss(void)
+{
+	return ra6w_params_list.features.nss;
+}
+
+u8 ra6w_params_rx_amsdu_size(void)
+{
+	return ra6w_params_list.module_params.rx_amsdu_size;
+}
+
+u8 ra6w_params_mcs_map_range(void)
+{
+	return ra6w_params_list.module_params.mcs_map_range;
+}
+
+u8 ra6w_params_he_mcs_map_range(void)
+{
+	return ra6w_params_list.module_params.he_mcs_map_range;
+}
-- 
2.17.1


