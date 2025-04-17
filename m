Return-Path: <linux-wireless+bounces-21660-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA10A91ED6
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Apr 2025 15:54:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A5047B1F9E
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Apr 2025 13:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 216F224888D;
	Thu, 17 Apr 2025 13:54:13 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6583724EF78
	for <linux-wireless@vger.kernel.org>; Thu, 17 Apr 2025 13:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744898053; cv=none; b=jQVGhhhb/fRv4TDls2Bngk+QbNFd5vvV+u9dfJ51EKzFKh0RnrusSifjyqjVOm05FAASvOza19V4mcQ4BKcS+fGIZn6Bd6jCcZSfU0s/iQQ6ZpvClyR7bFoOumzoK4JJT2il4R/66GHg9W1psPdqsql93Y2qf+mDr50t1zUT5NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744898053; c=relaxed/simple;
	bh=8ZXIn7Cz7U+JCirf0fapXNBrCEverddBPeV7oVQQkTM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=SRpd14bKVk12tB1dh074q2a9pJ1aN8LKN2dOf3m+pyf27sXQaLoE7asFUHiq/E7Qa6/rNEYv22GuB5UWnNVRJHRssU6m5wxnA4NlNvCFPYBo7j361N9wrKMqaUMIlhrg6g0OX6zxnlfU6zdeI3ZccLNHr051+4+LskzcXy+KbzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: P2vtGiINRuqwwzMWiClDLQ==
X-CSE-MsgGUID: FFRJN6QkQZS3d0YiOLPp3A==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 17 Apr 2025 22:54:10 +0900
Received: from localhost.localdomain (unknown [10.14.100.3])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 722D7400502F;
	Thu, 17 Apr 2025 22:54:07 +0900 (JST)
From: Alexander Savchenko <oleksandr.savchenko.dn@bp.renesas.com>
To: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes@sipsolutions.net>
Cc: Sergiy Petrov <sergiy.petrov.ue@bp.renesas.com>,
	Viktor Barna <viktor.barna.rj@bp.renesas.com>,
	Gal Gur <gal.gur.jx@renesas.com>,
	Alexander Savchenko <oleksandr.savchenko.dn@bp.renesas.com>
Subject: [PATCH 20/38] ra6w: add params.h
Date: Thu, 17 Apr 2025 16:52:18 +0300
Message-Id: <20250417135236.52410-21-oleksandr.savchenko.dn@bp.renesas.com>
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
 drivers/net/wireless/renesas/ra6w/params.h | 149 +++++++++++++++++++++
 1 file changed, 149 insertions(+)
 create mode 100644 drivers/net/wireless/renesas/ra6w/params.h

diff --git a/drivers/net/wireless/renesas/ra6w/params.h b/drivers/net/wireless/renesas/ra6w/params.h
new file mode 100644
index 000000000000..c67b157e5113
--- /dev/null
+++ b/drivers/net/wireless/renesas/ra6w/params.h
@@ -0,0 +1,149 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) [2022-2025] Renesas Electronics Corporation and/or its affiliates.
+ */
+
+#ifndef RA6W_PARAMS_H
+#define RA6W_PARAMS_H
+
+#define RA6W_PHY_MINOR_VERSION(v)	(((v) & 0x00FF0000) >> 16)
+#define RA6W_PHY_MAJOR_VERSION(v)	(((v) & 0xFF000000) >> 24)
+#define RA6W_PHY_VERSION(v) \
+	((RA6W_PHY_MAJOR_VERSION(v) + 2) * 10 + RA6W_PHY_MINOR_VERSION(v))
+
+enum ra6w_params_dev_feat {
+	RA6W_DEV_FEAT_BCN_BIT,
+	RA6W_DEV_FEAT_RADAR_BIT,
+	RA6W_DEV_FEAT_PS_BIT,
+	RA6W_DEV_FEAT_UAPSD_BIT,
+	RA6W_DEV_FEAT_AMPDU_BIT,
+	RA6W_DEV_FEAT_AMSDU_BIT,
+	RA6W_DEV_FEAT_P2P_BIT,
+	RA6W_DEV_FEAT_P2P_GO_BIT,
+	RA6W_DEV_FEAT_UMAC_BIT,
+	RA6W_DEV_FEAT_VHT_BIT,
+	RA6W_DEV_FEAT_BFMEE_BIT,
+	RA6W_DEV_FEAT_BFMER_BIT,
+	RA6W_DEV_FEAT_WAPI_BIT,
+	RA6W_DEV_FEAT_MFP_BIT,
+	RA6W_DEV_FEAT_MU_MIMO_RX_BIT,
+	RA6W_DEV_FEAT_MU_MIMO_TX_BIT,
+	RA6W_DEV_FEAT_MESH_BIT,
+	RA6W_DEV_FEAT_TDLS_BIT,
+	RA6W_DEV_FEAT_ANT_DIV_BIT,
+	RA6W_DEV_FEAT_UF_BIT,
+	RA6W_DEV_FEAT_AMSDU_MAX_SIZE_0_BIT,
+	RA6W_DEV_FEAT_AMSDU_MAX_SIZE_1_BIT,
+	RA6W_DEV_FEAT_MON_DATA_BIT,
+	RA6W_DEV_FEAT_HE_BIT,
+	RA6W_DEV_FEAT_TWT_BIT,
+	RA6W_DEV_FEAT_FTM_INIT_BIT,
+	RA6W_DEV_FEAT_FAKE_FTM_RSP_BIT,
+	RA6W_DEV_FEAT_HW_LLCSNAP_INS_BIT,
+	RA6W_DEV_FEAT_MAX
+};
+
+enum ra6w_params_mac_feat {
+	RA6W_MAC_FEAT_QOS_BIT,
+	RA6W_MAC_FEAT_EDCA_BIT,
+	RA6W_MAC_FEAT_SME_BIT,
+	RA6W_MAC_FEAT_SECURITY_BIT,
+	RA6W_MAC_FEAT_WEP_BIT,
+	RA6W_MAC_FEAT_TKIP_BIT,
+	RA6W_MAC_FEAT_CCMP_BIT,
+	RA6W_MAC_FEAT_RCE_BIT,
+	RA6W_MAC_FEAT_GCMP_BIT,
+	RA6W_MAC_FEAT_HT_BIT,
+	RA6W_MAC_FEAT_VHT_BIT,
+	RA6W_MAC_FEAT_TPC_BIT,
+	RA6W_MAC_FEAT_WAPI_BIT,
+	RA6W_MAC_FEAT_COEX_BIT,
+	RA6W_MAC_FEAT_HE_BIT,
+	RA6W_MAC_FEAT_RESERVED_BIT,
+	RA6W_MAC_FEAT_BFMEE_BIT,
+	RA6W_MAC_FEAT_BFMER_BIT,
+	RA6W_MAC_FEAT_MU_MIMO_TX_BIT,
+
+	RA6W_MAC_FEAT_MAX,
+};
+
+struct ra6w_params_dev_features {
+	bool tdls_supported;
+	bool amsdu_supported;
+	bool vht_supported;
+	bool he_supported;
+	bool he_ul_on;
+	bool bfmee_enabled;
+	bool ps_supported;
+	bool wapi_supported;
+	bool mfp_supported;
+	bool gcmp_supported;
+	bool radar_supported;
+	bool mu_mimo_rx_enabled;
+	bool mu_mimo_tx_enabled;
+	bool twt_enabled;
+	u8 nss;
+	u32 uapsd_threshold;
+	u8 bw_max;
+};
+
+struct ra6w_params_module_params {
+	bool stbc_enabled;
+	bool ldpc_enabled;
+	bool ant_div;
+	bool ht_supported;
+	bool amsdu_require_spp;
+	bool bfmer_enabled;
+	bool dpsm_enabled;
+	bool ap_uapsd_enabled;
+	bool use_sgi;
+	bool ccmp256_supported;
+	char *regdom_mode;
+	u8 mcs_map_range;
+	u8 he_mcs_map_range;
+	u8 rx_amsdu_size;
+	u32 log_level;
+};
+
+struct ra6w_params {
+	struct ra6w_params_dev_features features;
+	struct ra6w_params_module_params module_params;
+};
+
+extern struct ra6w_params ra6w_params_list;
+
+int ra6w_params_init(struct ra6w_core *core);
+bool ra6w_params_regd_mode_is_auto(void);
+int ra6w_params_regd_set_self(struct wiphy *wiphy);
+bool ra6w_params_ps_supported(void);
+bool ra6w_params_dpsm_enabled(void);
+bool ra6w_params_amsdu_require_spp(void);
+bool ra6w_params_ht_supported(void);
+bool ra6w_params_vht_supported(void);
+bool ra6w_params_he_supported(void);
+bool ra6w_params_he_ul_on(void);
+bool ra6w_params_wapi_supported(void);
+bool ra6w_params_mfp_supported(void);
+bool ra6w_params_ap_uapsd_enabled(void);
+bool ra6w_params_tdls_supported(void);
+bool ra6w_params_gcmp_supported(void);
+bool ra6w_params_ccmp256_supported(void);
+bool ra6w_params_bfmee_enabled(void);
+bool ra6w_params_bfmer_enabled(void);
+bool ra6w_params_ldpc_enabled(void);
+bool ra6w_params_stbc_enabled(void);
+u8 ra6w_params_bw_max_get(void);
+bool ra6w_params_use_sgi(void);
+bool ra6w_params_mu_mimo_rx_enabled(void);
+bool ra6w_params_mu_mimo_tx_enabled(void);
+bool ra6w_params_twt_enabled(void);
+bool ra6w_params_ant_div(void);
+u32 ra6w_params_log_level(void);
+void ra6w_params_log_level_set(u32 log_level);
+u8 ra6w_params_nss(void);
+u8 ra6w_params_rx_amsdu_size(void);
+u8 ra6w_params_mcs_map_range(void);
+u8 ra6w_params_he_mcs_map_range(void);
+u32 ra6w_params_uapsd_threshold(void);
+
+#endif /* RA6W_PARAMS_H */
-- 
2.17.1


