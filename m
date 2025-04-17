Return-Path: <linux-wireless+bounces-21650-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83D47A91EC4
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Apr 2025 15:53:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDB3246447C
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Apr 2025 13:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 527D324E4B2;
	Thu, 17 Apr 2025 13:53:32 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A34024EAA4
	for <linux-wireless@vger.kernel.org>; Thu, 17 Apr 2025 13:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744898012; cv=none; b=AVHeLq6s5gmDjc5Ru8E4D9Gu2+3U7lwMbVVDnG1wOjkcDJjtLv8dQb3MflugxsEt1iIbA34n1JWSTy6+3BL4rkU+PLQ7/eRUbwaBCci8YNURounly4rLlVMmClrN6ZbnGKCq0Yfp3wnXSZmGIS06auaOwTyPcJs9V+5zymKVynw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744898012; c=relaxed/simple;
	bh=U8E1qiaNsTXurFNMRo6kztTdOlLLEvAcaFMg0dAzIs0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=gJQOB3VrEnc2Oe8KiGXoVQt1aj8i3hK+9wNfRLkVsSlhf100mea9BudOkhLAuleD81nzZJToDknzc8smrvFw+x05dHr0Al8YWii74KqY6Xrgw4bx0FZI5jxcgMTBKh2Q1BbMxdEP3YQmJRWHZceAyZ4xOrcnbTAn+4eQ7BopAZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: y8DCk4F4SNSPQ4drtqwDrw==
X-CSE-MsgGUID: bJV5BIm0SiyeK8usPmo6sg==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 17 Apr 2025 22:53:29 +0900
Received: from localhost.localdomain (unknown [10.14.100.3])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 0556E4006DE8;
	Thu, 17 Apr 2025 22:53:25 +0900 (JST)
From: Alexander Savchenko <oleksandr.savchenko.dn@bp.renesas.com>
To: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes@sipsolutions.net>
Cc: Sergiy Petrov <sergiy.petrov.ue@bp.renesas.com>,
	Viktor Barna <viktor.barna.rj@bp.renesas.com>,
	Gal Gur <gal.gur.jx@renesas.com>,
	Alexander Savchenko <oleksandr.savchenko.dn@bp.renesas.com>
Subject: [PATCH 10/38] ra6w: add ctrl.h
Date: Thu, 17 Apr 2025 16:52:08 +0300
Message-Id: <20250417135236.52410-11-oleksandr.savchenko.dn@bp.renesas.com>
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
 drivers/net/wireless/renesas/ra6w/ctrl.h | 100 +++++++++++++++++++++++
 1 file changed, 100 insertions(+)
 create mode 100644 drivers/net/wireless/renesas/ra6w/ctrl.h

diff --git a/drivers/net/wireless/renesas/ra6w/ctrl.h b/drivers/net/wireless/renesas/ra6w/ctrl.h
new file mode 100644
index 000000000000..7d98251d81ae
--- /dev/null
+++ b/drivers/net/wireless/renesas/ra6w/ctrl.h
@@ -0,0 +1,100 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) [2022-2025] Renesas Electronics Corporation and/or its affiliates.
+ */
+
+#ifndef RA6W_CTRL_H
+#define RA6W_CTRL_H
+
+#include <net/cfg80211.h>
+
+#define RA6W_CTRL_DATA_LEN	980
+#define RA6W_CTRL_RSP_EXT_LEN	(sizeof(struct ra6w_ctrl_rsp_ext_hdr))
+#define RA6W_CTRL_EVENT_RESET	0
+
+struct ra6w_ctrl_rsp_ext_hdr {
+	u32 status : 32;
+};
+
+struct ra6w_ctrl_rsp {
+	u8 cmd;
+	u8 ext_len;
+	__le16 data_len;
+	struct ra6w_ctrl_rsp_ext_hdr ext_hdr;
+	u8 data[RA6W_CTRL_DATA_LEN];
+};
+
+struct ra6w_ctrl {
+	struct ra6w_q_event event;
+	u8 cmd;
+	void *rsp;
+	u16 rsp_len;
+};
+
+extern const int chnl2bw[];
+
+struct ra6w_cfg80211_vif;
+struct ra6w_cfg80211_key;
+
+void ra6w_ctrl_init(struct ra6w_ctrl *ctrl);
+void ra6w_ctrl_event_post(struct ra6w_ctrl *ctrl, const struct sk_buff *skb);
+int ra6w_ctrl_dev_hw_reset(struct ra6w_ctrl *ctrl);
+int ra6w_ctrl_dev_reset(struct ra6w_ctrl *ctrl);
+int ra6w_ctrl_dev_start(struct ra6w_ctrl *ctrl, const struct ra6w_cmd_phy_cfg *phy_config);
+int ra6w_ctrl_otp_mac_addr_get(struct ra6w_ctrl *ctrl, u8 *mac);
+int ra6w_ctrl_if_add(struct ra6w_ctrl *ctrl, const u8 *mac, u8 iftype, bool p2p,
+		     struct ra6w_cmd_add_if_rsp *rsp);
+int ra6w_ctrl_if_remove(struct ra6w_ctrl *ctrl, u8 vif_idx);
+int ra6w_ctrl_me_config(struct ra6w_ctrl *ctrl, struct wiphy *wiphy);
+int ra6w_ctrl_chan_config(struct ra6w_ctrl *ctrl, struct wiphy *wiphy);
+int ra6w_ctrl_scan_start(struct ra6w_ctrl *ctrl, struct cfg80211_scan_request *param);
+int ra6w_ctrl_scan_cancel(struct ra6w_ctrl *ctrl, const struct ra6w_cfg80211_vif *vif);
+int ra6w_ctrl_connect(struct ra6w_ctrl *ctrl, const struct net_device *ndev,
+		      struct cfg80211_connect_params *sme,
+		      struct ra6w_cmd_sm_connect_rsp *rsp);
+int ra6w_ctrl_disconnect_req(struct ra6w_ctrl *ctrl, const struct ra6w_cfg80211_vif *vif,
+			     u16 reason);
+int ra6w_ctrl_add_key_req(struct ra6w_ctrl *ctrl, const struct ra6w_cfg80211_key *key,
+			  const u8 *key_data, u32 key_len, u8 key_index,
+			    struct ra6w_cmd_key_add_rsp *rsp);
+int ra6w_ctrl_del_key_req(struct ra6w_ctrl *ctrl, u8 key_index);
+int ra6w_ctrl_add_station_req(struct ra6w_ctrl *ctrl, struct station_parameters *params,
+			      const u8 *mac, u8 vif_idx, struct ra6w_cmd_sta_add_rsp *rsp);
+int ra6w_ctrl_del_station_req(struct ra6w_ctrl *ctrl, u8 sta_idx, bool is_tdls_sta);
+int ra6w_ctrl_port_control_req(struct ra6w_ctrl *ctrl, bool authorized, u8 sta_idx);
+int ra6w_ctrl_remain_on_channel_req(struct ra6w_ctrl *ctrl, const struct ra6w_cfg80211_vif *vif,
+				    struct ieee80211_channel *chan, int duration);
+int ra6w_ctrl_cancel_remain_on_channel_req(struct ra6w_ctrl *ctrl);
+int ra6w_ctrl_ap_start_req(struct ra6w_ctrl *ctrl, struct ra6w_cfg80211_vif *vif,
+			   struct cfg80211_ap_settings *settings,
+			   struct ra6w_cmd_ap_start_rsp *rsp);
+int ra6w_ctrl_ap_stop_req(struct ra6w_ctrl *ctrl, const struct ra6w_cfg80211_vif *vif);
+int ra6w_ctrl_change_beacon_req(struct ra6w_ctrl *ctrl, u8 vif_idx, const u8 *bcn, u16 bcn_len,
+				u16 tim_oft, u16 tim_len, const u16 *csa_oft);
+int ra6w_ctrl_monitor_mode_req(struct ra6w_ctrl *ctrl, const struct cfg80211_chan_def *chandef,
+			       struct ra6w_cmd_mon_mode_rsp *rsp);
+int ra6w_ctrl_probe_client_req(struct ra6w_ctrl *ctrl, u8 vif_idx, u8 sta_idx,
+			       struct ra6w_cmd_probe_client_rsp *rsp);
+int ra6w_ctrl_set_ap_isolate_req(struct ra6w_ctrl *ctrl, u8 ap_isolate,
+				 struct ra6w_cmd_ap_isolate_rsp *rsp);
+int ra6w_ctrl_edca_req(struct ra6w_ctrl *ctrl, u8 ac, u32 param, bool uapsd, u8 vif_idx);
+int ra6w_ctrl_set_tx_power_req(struct ra6w_ctrl *ctrl, u8 vif_idx, s8 tx_power);
+int ra6w_ctrl_set_power_mgmt_req(struct ra6w_ctrl *ctrl, u8 ps_mode);
+int ra6w_ctrl_cqm_rssi_config_req(struct ra6w_ctrl *ctrl, u8 vif_idx,
+				  s32 rssi_thold, u32 rssi_hyst);
+int ra6w_ctrl_mem_read_req(struct ra6w_ctrl *ctrl, u32 addr,
+			   struct ra6w_cmd_mem_read_rsp *rsp);
+int ra6w_ctrl_mem_write_req(struct ra6w_ctrl *ctrl, u32 addr, u32 value);
+int ra6w_ctrl_dbg_mode_filter_req(struct ra6w_ctrl *ctrl, u32 mode);
+int ra6w_ctrl_dbg_level_filter_req(struct ra6w_ctrl *ctrl, u32 level);
+int ra6w_ctrl_rf_tx_req(struct ra6w_ctrl *ctrl, struct ra6w_cmd_rf_tx_data *data);
+int ra6w_ctrl_rf_cw_req(struct ra6w_ctrl *ctrl, const struct ra6w_cmd_rf_cw_data *data);
+int ra6w_ctrl_rf_cont_req(struct ra6w_ctrl *ctrl, const struct ra6w_cmd_rf_cont_data *data);
+int ra6w_ctrl_rf_ch_req(struct ra6w_ctrl *ctrl, u16 frequency);
+int ra6w_ctrl_rf_per_req(struct ra6w_ctrl *ctrl, u8 start, struct ra6w_cmd_rf_per_rsp *rsp);
+int ra6w_ctrl_sm_ext_auth_req_rsp(struct ra6w_ctrl *ctrl, u8 vif_idx, u16 status);
+int ra6w_ctrl_update_fw_ver(struct ra6w_ctrl *ctrl);
+int ra6w_ctrl_stats_tx_req(struct ra6w_ctrl *ctrl, u8 req_type, struct ra6w_cmd_stats_tx_rsp *rsp);
+int ra6w_ctrl_stats_tx_start_req(struct ra6w_ctrl *ctrl, u8 req_type);
+
+#endif /* RA6W_CTRL_H */
-- 
2.17.1


