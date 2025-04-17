Return-Path: <linux-wireless+bounces-21649-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A16FFA91EC7
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Apr 2025 15:53:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4E2F7A32A1
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Apr 2025 13:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C36424E4B2;
	Thu, 17 Apr 2025 13:53:29 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE0724EF61
	for <linux-wireless@vger.kernel.org>; Thu, 17 Apr 2025 13:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744898008; cv=none; b=jDNDZmAyJfUmZHkej6RoXXAhEZHgsnuUNQCNcjP5U4nnGpJj8lEkxb8EKGh9AYP2quM5SpRG0/jcLlhkhCuFMEYWfrkJdYwrsvbgIFCxenytmB7uM1Zx+pq3VfzRpiwFZnk4o9b/mO6WftKccOK6GXxCfAD/DQgQVgnIWw1bKSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744898008; c=relaxed/simple;
	bh=uNuI8hNdpIS37N6iXXkpOO3ANxlUDfUwmFQ0fpBjdMc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=gG2Y1kRwIftI4SgIYl/nyjnP/070ZUTA/+9EgMCqV31MXQW65CX5qSN+CRrLRPlPdhd5GazYMk+DhrXKcJQmpy6EzBwVkKekpGRsXMmcqOccECqujNPYh1qGzqUVTUZou+ze8ymuGfnXK5v9rVUVwJiPxfTp7ltPPvQNxNxR34w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: hbwGHSvsTuW/pNivB0Nutw==
X-CSE-MsgGUID: nJLL4fhbT1+r3V0Ap44gEQ==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 17 Apr 2025 22:53:25 +0900
Received: from localhost.localdomain (unknown [10.14.100.3])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 74AF7400502F;
	Thu, 17 Apr 2025 22:53:21 +0900 (JST)
From: Alexander Savchenko <oleksandr.savchenko.dn@bp.renesas.com>
To: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes@sipsolutions.net>
Cc: Sergiy Petrov <sergiy.petrov.ue@bp.renesas.com>,
	Viktor Barna <viktor.barna.rj@bp.renesas.com>,
	Gal Gur <gal.gur.jx@renesas.com>,
	Alexander Savchenko <oleksandr.savchenko.dn@bp.renesas.com>
Subject: [PATCH 09/38] ra6w: add ctrl.c
Date: Thu, 17 Apr 2025 16:52:07 +0300
Message-Id: <20250417135236.52410-10-oleksandr.savchenko.dn@bp.renesas.com>
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
 drivers/net/wireless/renesas/ra6w/ctrl.c | 1649 ++++++++++++++++++++++
 1 file changed, 1649 insertions(+)
 create mode 100644 drivers/net/wireless/renesas/ra6w/ctrl.c

diff --git a/drivers/net/wireless/renesas/ra6w/ctrl.c b/drivers/net/wireless/renesas/ra6w/ctrl.c
new file mode 100644
index 000000000000..5d8efc9e3bc7
--- /dev/null
+++ b/drivers/net/wireless/renesas/ra6w/ctrl.c
@@ -0,0 +1,1649 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * This file contains synchronous fw routine.
+ *
+ * Copyright (C) [2022-2025] Renesas Electronics Corporation and/or its affiliates.
+ */
+
+#include <linux/sched/clock.h>
+#include <net/cfg80211.h>
+
+#include "dbg.h"
+#include "cmd.h"
+#include "core.h"
+#include "ctrl.h"
+#include "if.h"
+#include "cfg80211.h"
+#include "params.h"
+
+#define RA6W_CTRL_EVENT_WAIT_DEFAULT_TIME_MS	2000
+
+static int ra6w_ctrl_wait(struct ra6w_ctrl *ctrl, u8 cmd)
+{
+	int ret_event = 0;
+	struct ra6w_q_event *event = &ctrl->event;
+
+	wait_event_interruptible_timeout(event->wait_queue,
+					 ra6w_q_event_condition(event, cmd, &ret_event),
+					 msecs_to_jiffies(RA6W_CTRL_EVENT_WAIT_DEFAULT_TIME_MS));
+
+	atomic_set(&event->condition, RA6W_CTRL_EVENT_RESET);
+
+	if (ret_event != cmd) {
+		ra6w_err("[%s] received %d event. Expected %u event\n", __func__, ret_event, cmd);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static int ra6w_ctrl_set(struct ra6w_ctrl *ctrl, u8 cmd, void *req, u16 req_len)
+{
+	struct ra6w_cmd_hdr *hdr;
+	struct ra6w_core *core = container_of(ctrl, struct ra6w_core, ctrl);
+	struct ra6w_if *ifp = container_of(core, struct ra6w_if, core);
+
+	if (!req)
+		return -ENOENT;
+
+	hdr = req;
+	hdr->cmd = cmd;
+	hdr->data_len = cpu_to_le16(req_len);
+
+	return ra6w_if_write(ifp, req, req_len + sizeof(*hdr));
+}
+
+static int ra6w_ctrl_set_wait(struct ra6w_ctrl *ctrl, u8 cmd, void *req, u16 req_len)
+{
+	struct ra6w_core *core = container_of(ctrl, struct ra6w_core, ctrl);
+	struct ra6w_if *ifp = container_of(core, struct ra6w_if, core);
+	int ret;
+
+	ret = ra6w_if_write(ifp, req, req_len);
+	if (ret)
+		return ret;
+
+	return ra6w_ctrl_wait(ctrl, cmd);
+}
+
+static int ra6w_ctrl_set_and_wait(struct ra6w_ctrl *ctrl, u8 cmd, void *req, u16 req_len)
+{
+	struct ra6w_cmd_hdr *hdr;
+	int ret;
+
+	if (!req)
+		return -ENOENT;
+
+	hdr = req;
+	hdr->cmd = cmd;
+	hdr->data_len = cpu_to_le16(req_len);
+
+	ret = ra6w_ctrl_set_wait(ctrl, cmd, req, req_len + sizeof(*hdr));
+	if (ret) {
+		struct ra6w_core *core = container_of(ctrl, struct ra6w_core, ctrl);
+
+		ra6w_recovery_event_post(&core->recovery);
+	}
+
+	return ret;
+}
+
+static int ra6w_ctrl_rsp_sync(struct ra6w_ctrl *ctrl, u8 cmd, u16 rsp_len)
+{
+	if (ctrl->cmd != cmd)
+		return -EINVAL;
+
+	if (ctrl->rsp_len != rsp_len)
+		return -EINVAL;
+
+	ctrl->rsp = NULL;
+	ctrl->rsp_len = 0;
+
+	return 0;
+}
+
+static int ra6w_ctrl_set_and_wait_rsp(struct ra6w_ctrl *ctrl, u8 cmd, void *req, u16 req_len,
+				      void *rsp, u16 rsp_len)
+{
+	struct ra6w_cmd_hdr *hdr;
+	int ret;
+
+	if (!req || !rsp)
+		return -ENOENT;
+
+	hdr = req;
+	hdr->cmd = cmd;
+	hdr->data_len = cpu_to_le16(req_len);
+
+	ctrl->rsp = rsp;
+	ctrl->rsp_len = rsp_len;
+
+	ret = ra6w_ctrl_set_wait(ctrl, cmd, req, req_len + sizeof(*hdr));
+	if (ret)
+		return ret;
+
+	return ra6w_ctrl_rsp_sync(ctrl, cmd, rsp_len);
+}
+
+void ra6w_ctrl_event_post(struct ra6w_ctrl *ctrl, const struct sk_buff *skb)
+{
+	struct ra6w_ctrl_rsp *rsp = (struct ra6w_ctrl_rsp *)skb->data;
+
+	if (rsp->ext_len == RA6W_CTRL_RSP_EXT_LEN) {
+		struct ra6w_core *core = container_of(ctrl, struct ra6w_core, ctrl);
+
+		ra6w_status_set(&core->status, rsp->ext_hdr.status);
+	}
+
+	ctrl->cmd = rsp->cmd;
+
+	if (ctrl->rsp) {
+		ctrl->rsp_len = le16_to_cpu(rsp->data_len);
+		memcpy(ctrl->rsp, rsp->data, le16_to_cpu(rsp->data_len));
+	}
+
+	ra6w_q_event_set(&ctrl->event, rsp->cmd);
+}
+
+/* Assume that rate higher that 54 Mbps are BSS membership */
+#define RA6W_IS_BASIC_RATE(r) (((r) & 0x80) && (((r) & ~0x80) <= (54 * 2)))
+
+static const s32 bw2chnl[] = {
+	[NL80211_CHAN_WIDTH_20_NOHT] = RA6W_CMD_PHY_CHNL_BW_20,
+	[NL80211_CHAN_WIDTH_20] = RA6W_CMD_PHY_CHNL_BW_20,
+	[NL80211_CHAN_WIDTH_40] = RA6W_CMD_PHY_CHNL_BW_40,
+	[NL80211_CHAN_WIDTH_80] = RA6W_CMD_PHY_CHNL_BW_80,
+	[NL80211_CHAN_WIDTH_160] = RA6W_CMD_PHY_CHNL_BW_160,
+	[NL80211_CHAN_WIDTH_80P80] = RA6W_CMD_PHY_CHNL_BW_80P80,
+};
+
+const s32 chnl2bw[] = {
+	[RA6W_CMD_PHY_CHNL_BW_20] = NL80211_CHAN_WIDTH_20,
+	[RA6W_CMD_PHY_CHNL_BW_40] = NL80211_CHAN_WIDTH_40,
+	[RA6W_CMD_PHY_CHNL_BW_80] = NL80211_CHAN_WIDTH_80,
+	[RA6W_CMD_PHY_CHNL_BW_160] = NL80211_CHAN_WIDTH_160,
+	[RA6W_CMD_PHY_CHNL_BW_80P80] = NL80211_CHAN_WIDTH_80P80,
+};
+
+static inline u16 ra6w_ctrl_get_chan_flags(u32 flags)
+{
+	u16 chan_flags = 0;
+
+	if (flags & IEEE80211_CHAN_DISABLED)
+		chan_flags |= RA6W_CMD_CHAN_DISABLED_BIT;
+
+	if (flags & IEEE80211_CHAN_NO_IR)
+		chan_flags |= RA6W_CMD_CHAN_NO_IR_BIT;
+
+	if (flags & IEEE80211_CHAN_RADAR)
+		chan_flags |= RA6W_CMD_CHAN_RADAR_BIT;
+
+	return chan_flags;
+}
+
+int ra6w_ctrl_dev_hw_reset(struct ra6w_ctrl *ctrl)
+{
+	int ret;
+	u8 cmd = RA6W_CMD_COMMON_RESET;
+	struct ra6w_cmd_reset_req *req = NULL;
+
+	req = kzalloc(sizeof(*req), GFP_KERNEL);
+	if (!req)
+		return -ENOMEM;
+
+	ret = ra6w_ctrl_set(ctrl, cmd, req, sizeof(req->data));
+
+	kfree(req);
+
+	return ret;
+}
+
+int ra6w_ctrl_dev_reset(struct ra6w_ctrl *ctrl)
+{
+	struct ra6w_cmd_reset_req *req = NULL;
+	u8 cmd = RA6W_CMD_MM_RESET;
+	int ret;
+
+	req = kzalloc(sizeof(*req), GFP_KERNEL);
+	if (!req)
+		return -ENOMEM;
+
+	req->data.time_usec = cpu_to_le64(local_clock() / NSEC_PER_USEC);
+
+	ret = ra6w_ctrl_set_and_wait(ctrl, cmd, req, sizeof(req->data));
+
+	kfree(req);
+
+	return ret;
+}
+
+int ra6w_ctrl_dev_start(struct ra6w_ctrl *ctrl, const struct ra6w_cmd_phy_cfg *phy_config)
+{
+	struct ra6w_cmd_mm_start_req *req = NULL;
+	u8 cmd = RA6W_CMD_MM_START;
+	int ret;
+
+	req = kzalloc(sizeof(*req), GFP_KERNEL);
+	if (!req)
+		return -ENOMEM;
+
+	memcpy(&req->data.phy_cfg, phy_config, sizeof(*phy_config));
+	req->data.uapsd_timeout = cpu_to_le32(ra6w_params_uapsd_threshold());
+	req->data.lp_clk_accuracy = cpu_to_le16(RA6W_CFG80211_LPCA_PPM);
+	req->data.rx_hostbuf_size = cpu_to_le16(RA6W_CMD_DATA_SIZE);
+
+	ret = ra6w_ctrl_set_and_wait(ctrl, cmd, req, sizeof(req->data));
+
+	kfree(req);
+
+	return ret;
+}
+
+int ra6w_ctrl_otp_mac_addr_get(struct ra6w_ctrl *ctrl, u8 *mac)
+{
+	struct ra6w_cmd_hdr *req = NULL;
+	u8 cmd = RA6W_CMD_COMMON_GET_MAC_ADDR;
+	int ret;
+
+	if (!mac)
+		return -ENOENT;
+
+	req = kzalloc(sizeof(*req), GFP_KERNEL);
+	if (!req)
+		return -ENOMEM;
+
+	ret = ra6w_ctrl_set_and_wait_rsp(ctrl, cmd, req, 0, mac, ETH_ALEN);
+	if (ret)
+		goto req_free;
+
+	if (!is_valid_ether_addr(mac))
+		ret = -ENOENT;
+
+req_free:
+	kfree(req);
+
+	return ret;
+}
+
+static int ra6w_ctrl_get_fw_ver(struct ra6w_ctrl *ctrl, struct ra6w_cmd_fw_ver_rsp *rsp)
+{
+	struct ra6w_cmd_hdr *req = NULL;
+	u8 cmd = RA6W_CMD_MM_GET_VER;
+	int ret;
+
+	if (!rsp)
+		return -ENOENT;
+
+	req = kzalloc(sizeof(*req), GFP_KERNEL);
+	if (!req)
+		return -ENOMEM;
+
+	ret = ra6w_ctrl_set_and_wait_rsp(ctrl, cmd, req, 0, rsp, sizeof(*rsp));
+
+	kfree(req);
+
+	return ret;
+}
+
+int ra6w_ctrl_update_fw_ver(struct ra6w_ctrl *ctrl)
+{
+#define UNPACK_FW_VERSION(str, fw_version)				\
+do {									\
+	u8 *p = (u8 *)fw_version;					\
+	snprintf(str, sizeof(str),					\
+		 "%hhu.%hhu.%hhu.%hhu.%hhu",				\
+		 (p[3] >> 4) & 0x0f, p[3] & 0x0f, p[2], p[1], p[0]);	\
+} while (0)
+
+	struct ra6w_core *core = container_of(ctrl, struct ra6w_core, ctrl);
+	struct ra6w_cmd_fw_ver_rsp *fw_ver = &core->sinfo.fw_ver;
+	int ret;
+
+	ret = ra6w_ctrl_get_fw_ver(ctrl, fw_ver);
+	if (ret)
+		return ret;
+
+	UNPACK_FW_VERSION(core->sinfo.fw_version, &fw_ver->fw_version);
+	ra6w_info("fw_version : %s", core->sinfo.fw_version);
+	ra6w_dbg("machw_features : 0x%X", fw_ver->machw_features);
+	ra6w_dbg("machw_version : 0x%X", fw_ver->machw_version);
+	ra6w_dbg("phy_feature : 0x%X", fw_ver->phy_feature);
+	ra6w_dbg("phy_version : 0x%X", fw_ver->phy_version);
+	ra6w_dbg("features : 0x%X", fw_ver->features);
+	ra6w_dbg("max_sta_nb : %d", fw_ver->max_sta_nb);
+	ra6w_dbg("max_vif_nb : %d", fw_ver->max_vif_nb);
+
+	core->sinfo.machw_support_type = RA6W_MACHW_SUPPORT_HE;
+
+	return 0;
+}
+
+int ra6w_ctrl_if_add(struct ra6w_ctrl *ctrl, const u8 *mac, u8 iftype, bool p2p,
+		     struct ra6w_cmd_add_if_rsp *rsp)
+{
+	int ret;
+	struct ra6w_cmd_add_if_req *req = NULL;
+	struct ra6w_cmd_add_if_data *req_data = NULL;
+	u8 cmd = RA6W_CMD_MM_ADD_IF;
+
+	if (!rsp)
+		return -ENOENT;
+
+	req = kzalloc(sizeof(*req), GFP_KERNEL);
+	if (!req)
+		return -ENOMEM;
+
+	req_data = &req->data;
+
+	ether_addr_copy((u8 *)&req_data->addr.addr, mac);
+
+	switch (iftype) {
+	case NL80211_IFTYPE_P2P_CLIENT:
+		p2p = true;
+		req_data->iftype = RA6W_VIF_TYPE_STA;
+		break;
+	case NL80211_IFTYPE_STATION:
+		req_data->iftype = RA6W_VIF_TYPE_STA;
+		break;
+	case NL80211_IFTYPE_ADHOC:
+		req_data->iftype = RA6W_VIF_TYPE_IBSS;
+		break;
+	case NL80211_IFTYPE_P2P_GO:
+		p2p = true;
+		req_data->iftype = RA6W_VIF_TYPE_AP;
+		break;
+	case NL80211_IFTYPE_AP:
+		req_data->iftype = RA6W_VIF_TYPE_AP;
+		break;
+	case NL80211_IFTYPE_MESH_POINT:
+		req_data->iftype = RA6W_VIF_TYPE_MESH_POINT;
+		break;
+	case NL80211_IFTYPE_AP_VLAN:
+		ret = -EINVAL;
+		goto free;
+	case NL80211_IFTYPE_MONITOR:
+		req_data->iftype = RA6W_VIF_TYPE_MONITOR;
+		req_data->uf = false;
+		break;
+	default:
+		req_data->iftype = RA6W_VIF_TYPE_STA;
+		break;
+	}
+
+	req_data->p2p = p2p;
+
+	ret = ra6w_ctrl_set_and_wait_rsp(ctrl, cmd, req, sizeof(req->data), rsp, sizeof(*rsp));
+	if (!ret)
+		ret = ra6w_status_err_code_to_errno(rsp->status);
+
+free:
+	kfree(req);
+
+	return ret;
+}
+
+int ra6w_ctrl_if_remove(struct ra6w_ctrl *ctrl, u8 vif_idx)
+{
+	struct ra6w_cmd_del_if_req *req = NULL;
+	u8 cmd = RA6W_CMD_MM_RM_IF;
+	int ret;
+
+	req = kzalloc(sizeof(*req), GFP_KERNEL);
+	if (!req)
+		return -ENOMEM;
+
+	req->data.vif_idx = vif_idx;
+
+	ret = ra6w_ctrl_set_and_wait(ctrl, cmd, req, sizeof(req->data));
+
+	kfree(req);
+
+	return ret;
+}
+
+static int ra6w_ctrl_req_ht_cap_set(struct ra6w_cmd_me_config_data *req_data,
+				    struct ieee80211_sta_ht_cap *ht_cap)
+{
+	struct ra6w_cmd_mac_htcapability *ht = &req_data->ht_cap;
+	const u8 *ht_mcs = NULL;
+	int i = 0;
+
+	if (!ht_cap->ht_supported) {
+		ra6w_err("[%s] HT not supported. Abort.\n", __func__);
+		return -ENOENT;
+	}
+
+	req_data->ht_supp = ht_cap->ht_supported;
+	ht->ht_capa_info = cpu_to_le16(ht_cap->cap);
+	ht->a_mpdu_param = ht_cap->ampdu_factor |
+			   (ht_cap->ampdu_density << IEEE80211_HT_AMPDU_PARM_DENSITY_SHIFT);
+
+	ht_mcs = (u8 *)&ht_cap->mcs;
+	for (i = 0; i < sizeof(ht_cap->mcs); i++)
+		ht->mcs_rate[i] = ht_mcs[i];
+
+	ht->ht_extended_capa = 0;
+	ht->tx_beamforming_capa = 0;
+	ht->asel_capa = 0;
+
+	return 0;
+}
+
+static void ra6w_ctrl_req_vht_cap_set(struct ra6w_cmd_me_config_data *req_data,
+				      const struct ieee80211_sta_vht_cap *vht_cap)
+{
+	struct ra6w_cmd_mac_vhtcapability *vht = &req_data->vht_cap;
+
+	req_data->vht_supp = vht_cap->vht_supported;
+	if (!vht_cap->vht_supported)
+		return;
+
+	vht->vht_capa_info = cpu_to_le32(vht_cap->cap);
+	vht->rx_highest = vht_cap->vht_mcs.rx_highest;
+	vht->rx_mcs_map = vht_cap->vht_mcs.rx_mcs_map;
+	vht->tx_highest = vht_cap->vht_mcs.tx_highest;
+	vht->tx_mcs_map = vht_cap->vht_mcs.tx_mcs_map;
+}
+
+static void ra6w_ctrl_req_he_cap_set(struct ra6w_cmd_me_config_data *req_data,
+				     const struct ieee80211_sta_he_cap *he_cap)
+{
+	struct ra6w_cmd_mac_hecapability *he = &req_data->he_cap;
+	const struct ieee80211_he_cap_elem *cap_elem;
+
+	req_data->he_supp = he_cap->has_he;
+	if (!he_cap->has_he)
+		return;
+
+	cap_elem = &he_cap->he_cap_elem;
+	memcpy(he->mac_cap_info, cap_elem->mac_cap_info, ARRAY_SIZE(cap_elem->mac_cap_info));
+	memcpy(he->phy_cap_info, cap_elem->phy_cap_info, ARRAY_SIZE(cap_elem->phy_cap_info));
+
+	he->mcs_supp.rx_mcs_80 = he_cap->he_mcs_nss_supp.rx_mcs_80;
+	he->mcs_supp.tx_mcs_80 = he_cap->he_mcs_nss_supp.tx_mcs_80;
+	he->mcs_supp.rx_mcs_160 = he_cap->he_mcs_nss_supp.rx_mcs_160;
+	he->mcs_supp.tx_mcs_160 = he_cap->he_mcs_nss_supp.tx_mcs_160;
+	he->mcs_supp.rx_mcs_80p80 = he_cap->he_mcs_nss_supp.rx_mcs_80p80;
+	he->mcs_supp.tx_mcs_80p80 = he_cap->he_mcs_nss_supp.tx_mcs_80p80;
+
+	memcpy(he->ppe_thres, he_cap->ppe_thres, RA6W_CMD_MAC_HE_PPE_THRES_MAX_LEN);
+
+	req_data->he_ul_on = ra6w_params_he_ul_on();
+}
+
+static int ra6w_ctrl_cmd_me_config_set(struct ra6w_cmd_me_config_data *req_data,
+				       const struct wiphy *wiphy)
+{
+	struct ieee80211_supported_band *sband = NULL;
+	struct ieee80211_sta_ht_cap *ht_cap = NULL;
+	struct ieee80211_sta_vht_cap *vht_cap = NULL;
+	struct ieee80211_sta_he_cap const *he_cap = NULL;
+	int ret;
+
+	if (wiphy->bands[NL80211_BAND_5GHZ]) {
+		sband = wiphy->bands[NL80211_BAND_5GHZ];
+		ht_cap = &sband->ht_cap;
+		vht_cap = &sband->vht_cap;
+		if (sband->iftype_data)
+			he_cap = &sband->iftype_data->he_cap;
+	} else if (wiphy->bands[NL80211_BAND_2GHZ]) {
+		sband = wiphy->bands[NL80211_BAND_2GHZ];
+		ht_cap = &sband->ht_cap;
+		if (sband->iftype_data)
+			he_cap = &sband->iftype_data->he_cap;
+		vht_cap = NULL;
+	}
+
+	if (!ht_cap) {
+		ra6w_err("[%s] HT not found. Abort.\n", __func__);
+		return -ENOENT;
+	}
+
+	ret = ra6w_ctrl_req_ht_cap_set(req_data, ht_cap);
+	if (ret)
+		return ret;
+
+	if (vht_cap)
+		ra6w_ctrl_req_vht_cap_set(req_data, vht_cap);
+
+	if (he_cap)
+		ra6w_ctrl_req_he_cap_set(req_data, he_cap);
+
+	req_data->ps_on = ra6w_params_ps_supported();
+	req_data->dpsm = ra6w_params_dpsm_enabled();
+	req_data->tx_lft = cpu_to_le16(RA6W_CMD_TX_LIFETIME_MS);
+	req_data->amsdu_tx = 0;
+	req_data->ant_div_on = ra6w_params_ant_div();
+	req_data->phy_bw_max = ra6w_params_bw_max_get();
+
+	return 0;
+}
+
+int ra6w_ctrl_me_config(struct ra6w_ctrl *ctrl, struct wiphy *wiphy)
+{
+	int ret;
+	u8 cmd = RA6W_CMD_ME_CONFIG;
+	struct ra6w_cmd_me_config_req *req = NULL;
+
+	req = kzalloc(sizeof(*req), GFP_KERNEL);
+	if (!req)
+		return -ENOMEM;
+
+	ret = ra6w_ctrl_cmd_me_config_set(&req->data, wiphy);
+	if (ret)
+		goto req_free;
+
+	ret = ra6w_ctrl_set_and_wait(ctrl, cmd, req, sizeof(req->data));
+	if (ret)
+		goto req_free;
+
+	ra6w_info("HT supp %d, VHT supp %d, HE supp %d\n",
+		  req->data.ht_supp, req->data.vht_supp, req->data.he_supp);
+
+req_free:
+	kfree(req);
+
+	return ret;
+}
+
+int ra6w_ctrl_chan_config(struct ra6w_ctrl *ctrl, struct wiphy *wiphy)
+{
+	int ret;
+	const struct ieee80211_supported_band *band = NULL;
+	int i = 0;
+	struct ra6w_cmd_me_chan_config_req *req = NULL;
+	u8 cmd = RA6W_CMD_ME_CHAN_CONFIG;
+
+	req = kzalloc(sizeof(*req), GFP_KERNEL);
+	if (!req)
+		return -ENOMEM;
+
+	if (wiphy->bands[NL80211_BAND_2GHZ]) {
+		band = wiphy->bands[NL80211_BAND_2GHZ];
+		for (i = 0; i < band->n_channels; i++) {
+			const struct ieee80211_channel *channel = &band->channels[i];
+			struct ra6w_cmd_prim_ch_def *ch_def = &req->data.chan24G[i];
+
+			ch_def->ch_flags |= cpu_to_le16(ra6w_ctrl_get_chan_flags(channel->flags));
+			ch_def->ch_band = NL80211_BAND_2GHZ;
+			ch_def->ch_freq = cpu_to_le16(channel->center_freq);
+			ch_def->tx_max_pwr = min_t(int, channel->max_power, channel->max_reg_power);
+			req->data.chan24G_cnt++;
+			if (req->data.chan24G_cnt == RA6W_CMD_SCAN_CHANNEL_24G)
+				break;
+		}
+	}
+
+	if (wiphy->bands[NL80211_BAND_5GHZ]) {
+		band = wiphy->bands[NL80211_BAND_5GHZ];
+		for (i = 0; i < band->n_channels; i++) {
+			const struct ieee80211_channel *channel = &band->channels[i];
+			struct ra6w_cmd_prim_ch_def *ch_def = &req->data.chan5G[i];
+
+			ch_def->ch_flags |= cpu_to_le16(ra6w_ctrl_get_chan_flags(channel->flags));
+			ch_def->ch_band = NL80211_BAND_5GHZ;
+			ch_def->ch_freq = cpu_to_le16(channel->center_freq);
+			ch_def->tx_max_pwr = min_t(int, channel->max_power, channel->max_reg_power);
+			req->data.chan5G_cnt++;
+			if (req->data.chan5G_cnt == RA6W_CMD_SCAN_CHANNEL_5G)
+				break;
+		}
+	}
+
+	ret = ra6w_ctrl_set_and_wait(ctrl, cmd, req, sizeof(req->data));
+
+	kfree(req);
+
+	return ret;
+}
+
+int ra6w_ctrl_scan_start(struct ra6w_ctrl *ctrl, struct cfg80211_scan_request *param)
+{
+	int ret;
+	const struct ra6w_cfg80211_vif *vif = NULL;
+	struct ra6w_cmd_sc_start_req *req = NULL;
+	u16 req_len = 0;
+	__le16 chan_flags = 0;
+	u16 i;
+	u16 j;
+	u8 cmd = RA6W_CMD_SC_START;
+
+	if (!param->wdev)
+		return -EINVAL;
+
+	req_len = sizeof(req->data) + param->ie_len;
+	req = kzalloc(req_len, GFP_KERNEL);
+	if (!req)
+		return -ENOMEM;
+
+	eth_broadcast_addr((u8 *)&req->data.bssid);
+
+	vif = container_of(param->wdev, struct ra6w_cfg80211_vif, wdev);
+	req->data.vif_idx = vif->vif_idx;
+	req->data.n_channels = (u8)min_t(int, RA6W_CMD_SCAN_CHANNEL_MAX, param->n_channels);
+	req->data.n_ssids = (u8)min_t(int, RA6W_CMD_SCAN_SSID_MAX, param->n_ssids);
+	req->data.no_cck = param->no_cck;
+	if (param->duration_mandatory)
+		req->data.duration = cpu_to_le32(ieee80211_tu_to_usec(param->duration));
+
+	if (req->data.n_ssids == 0)
+		chan_flags |= cpu_to_le16(RA6W_CMD_CHAN_NO_IR_BIT);
+
+	for (i = 0; i < req->data.n_ssids; i++) {
+		for (j = 0; j < param->ssids[i].ssid_len; j++)
+			req->data.ssid[i].ssid[j] = param->ssids[i].ssid[j];
+
+		req->data.ssid[i].ssid_len = param->ssids[i].ssid_len;
+	}
+
+	if (param->ie && param->ie_len > 0) {
+		req->data.ie_len = cpu_to_le16(param->ie_len);
+		req->data.ie_addr = 0;
+		memcpy(req->data.ie, param->ie, param->ie_len);
+	}
+
+	for (i = 0; i < req->data.n_channels; i++) {
+		const struct ieee80211_channel *channel = param->channels[i];
+		struct ra6w_cmd_prim_ch_def *ch_def = &req->data.chan[i];
+
+		ch_def->ch_band = channel->band;
+		ch_def->ch_freq = cpu_to_le16(channel->center_freq);
+		ch_def->ch_flags = chan_flags |
+				   cpu_to_le16(ra6w_ctrl_get_chan_flags(channel->flags));
+		ch_def->tx_max_pwr = min_t(int, channel->max_power, channel->max_reg_power);
+	}
+
+	ret = ra6w_ctrl_set_and_wait(ctrl, cmd, req, req_len);
+
+	kfree(req);
+
+	return ret;
+}
+
+int ra6w_ctrl_scan_cancel(struct ra6w_ctrl *ctrl, const struct ra6w_cfg80211_vif *vif)
+{
+	int ret;
+	struct ra6w_cmd_sc_cancel_req *req = NULL;
+	u8 cmd = RA6W_CMD_SC_CANCEL_CMD;
+
+	req = kzalloc(sizeof(*req), GFP_KERNEL);
+	if (!req)
+		return -ENOMEM;
+
+	req->data.vif_idx = vif->vif_idx;
+
+	ret = ra6w_ctrl_set_and_wait(ctrl, cmd, req, sizeof(req->data));
+
+	kfree(req);
+
+	return ret;
+}
+
+int ra6w_ctrl_connect(struct ra6w_ctrl *ctrl, const struct net_device *ndev,
+		      struct cfg80211_connect_params *sme,
+		      struct ra6w_cmd_sm_connect_rsp *rsp)
+{
+	int ret;
+	struct ra6w_cfg80211_vif *vif = NULL;
+	struct ra6w_cmd_sm_connect_req *req = NULL;
+	struct ra6w_cmd_sm_connect_data *req_data = NULL;
+	u8 cmd = RA6W_CMD_SM_CONNECT;
+	int i;
+	u32 req_len;
+
+	if (!rsp)
+		return -ENOENT;
+
+	vif = netdev_priv(ndev);
+	if (!vif)
+		return -ENOENT;
+
+	req_len = sizeof(req->data) + sme->ie_len;
+	req = kzalloc(req_len, GFP_KERNEL);
+	if (!req)
+		return -ENOMEM;
+
+	req_data = &req->data;
+
+	if (sme->crypto.n_ciphers_pairwise &&
+	    (sme->crypto.ciphers_pairwise[0] == WLAN_CIPHER_SUITE_WEP40 ||
+	    sme->crypto.ciphers_pairwise[0] == WLAN_CIPHER_SUITE_TKIP ||
+	    sme->crypto.ciphers_pairwise[0] == WLAN_CIPHER_SUITE_WEP104))
+		req_data->flags |= cpu_to_le32(RA6W_CMD_CONN_DISABLE_HT_BIT);
+
+	if (sme->crypto.cipher_group)
+		req_data->flags |= cpu_to_le32(RA6W_CMD_CONN_USE_PRIVACY_BIT);
+
+	if (sme->crypto.control_port)
+		req_data->flags |= cpu_to_le32(RA6W_CMD_CONN_CONTROL_PORT_HOST_BIT);
+
+	if (sme->crypto.control_port_no_encrypt)
+		req_data->flags |= cpu_to_le32(RA6W_CMD_CONN_CONTROL_PORT_NO_ENC_BIT);
+
+	if (sme->crypto.cipher_group &&
+	    sme->crypto.cipher_group != WLAN_CIPHER_SUITE_WEP40 &&
+	    sme->crypto.cipher_group != WLAN_CIPHER_SUITE_WEP104)
+		req_data->flags |= cpu_to_le32(RA6W_CMD_CONN_USE_PAIRWISE_KEY_BIT);
+
+	if (sme->mfp == NL80211_MFP_REQUIRED)
+		req_data->flags |= cpu_to_le32(RA6W_CMD_CONN_MFP_IN_USE_BIT);
+
+	if (ra6w_params_amsdu_require_spp())
+		req_data->flags |= cpu_to_le32(RA6W_CMD_CONN_REQUIRE_SPP_AMSDU_BIT);
+
+	req_data->ctrl_port_ethertype = sme->crypto.control_port_ethertype;
+
+	if (sme->bssid)
+		ether_addr_copy((u8 *)&req_data->bssid, sme->bssid);
+	else
+		eth_broadcast_addr((u8 *)&req_data->bssid);
+
+	if (sme->prev_bssid)
+		req_data->flags |= cpu_to_le32(RA6W_CMD_CONN_REASSOCIATION_BIT);
+
+	req_data->vif_idx = vif->vif_idx;
+	req_data->chan.ch_freq = cpu_to_le16(0xFFFF);
+	if (sme->channel) {
+		req_data->chan.ch_band = sme->channel->band;
+		req_data->chan.ch_freq = cpu_to_le16(sme->channel->center_freq);
+		req_data->chan.ch_flags =
+				cpu_to_le16(ra6w_ctrl_get_chan_flags(sme->channel->flags));
+	}
+
+	for (i = 0; i < sme->ssid_len; i++)
+		req_data->ssid.ssid[i] = sme->ssid[i];
+
+	req_data->ssid.ssid_len = sme->ssid_len;
+	req_data->listen_interval = 0;
+	req_data->dont_wait_bcmc = false;
+
+	switch (sme->auth_type) {
+	case NL80211_AUTHTYPE_AUTOMATIC:
+		req_data->auth_type = WLAN_AUTH_OPEN;
+		break;
+	case NL80211_AUTHTYPE_OPEN_SYSTEM:
+		req_data->auth_type = WLAN_AUTH_OPEN;
+		break;
+	case NL80211_AUTHTYPE_SHARED_KEY:
+		req_data->auth_type = WLAN_AUTH_SHARED_KEY;
+		break;
+	case NL80211_AUTHTYPE_FT:
+		ret = -EOPNOTSUPP;
+		goto req_free;
+	case NL80211_AUTHTYPE_SAE:
+		req_data->auth_type = WLAN_AUTH_SAE;
+		break;
+	default:
+		ret = -EINVAL;
+		goto req_free;
+	}
+
+	memcpy(req_data->ie_buf, sme->ie, sme->ie_len);
+	req_data->ie_len = cpu_to_le16(sme->ie_len);
+
+	req_data->uapsd_queues = IEEE80211_WMM_IE_STA_QOSINFO_AC_MASK;
+
+	ret = ra6w_ctrl_set_and_wait_rsp(ctrl, cmd, req, req_len, rsp, sizeof(*rsp));
+	if (!ret)
+		ret = ra6w_status_err_code_to_errno(rsp->status);
+
+req_free:
+	kfree(req);
+
+	return ret;
+}
+
+int ra6w_ctrl_disconnect_req(struct ra6w_ctrl *ctrl, const struct ra6w_cfg80211_vif *vif,
+			     u16 reason)
+{
+	struct ra6w_cmd_disconnect_req *req = NULL;
+	u8 cmd = RA6W_CMD_SM_DISCONNECT;
+	int ret;
+
+	req = kzalloc(sizeof(*req), GFP_KERNEL);
+	if (!req)
+		return -ENOMEM;
+
+	req->data.vif_idx = vif->vif_idx;
+	req->data.deauth_reason = cpu_to_le16(reason);
+
+	ret = ra6w_ctrl_set_and_wait(ctrl, cmd, req, sizeof(req->data));
+
+	kfree(req);
+
+	return ret;
+}
+
+int ra6w_ctrl_add_key_req(struct ra6w_ctrl *ctrl, const struct ra6w_cfg80211_key *key,
+			  const u8 *key_data, u32 key_len, u8 key_index,
+			  struct ra6w_cmd_key_add_rsp *rsp)
+{
+	int ret;
+	struct ra6w_cmd_key_add_req *req = NULL;
+	struct ra6w_cmd_key_add_data *req_data = NULL;
+	u8 cmd = RA6W_CMD_MM_ADD_KEY;
+
+	if (!rsp)
+		return -ENOENT;
+
+	req = kzalloc(sizeof(*req), GFP_KERNEL);
+	if (!req)
+		return -ENOMEM;
+
+	req_data = &req->data;
+	req_data->sta_id = key->sta_idx;
+	req_data->key_idx = key_index;
+	req_data->pairwise = key->pairwise;
+	req_data->vif_idx = key->vif_idx;
+	req_data->key.length = key_len;
+	req_data->cipher_suite = key->cipher_type;
+
+	memcpy(req_data->key.array, key_data, key_len);
+
+	ret = ra6w_ctrl_set_and_wait_rsp(ctrl, cmd, req, sizeof(req->data), rsp, sizeof(*rsp));
+	if (!ret)
+		ret = ra6w_status_err_code_to_errno(rsp->status);
+
+	kfree(req);
+
+	return ret;
+}
+
+int ra6w_ctrl_del_key_req(struct ra6w_ctrl *ctrl, u8 key_index)
+{
+	struct ra6w_cmd_key_del_req *req = NULL;
+	u8 cmd = RA6W_CMD_MM_DEL_KEY;
+	int ret;
+
+	req = kzalloc(sizeof(*req), GFP_KERNEL);
+	if (!req)
+		return -ENOMEM;
+
+	req->data.key_index = key_index;
+
+	ret = ra6w_ctrl_set_and_wait(ctrl, cmd, req, sizeof(req->data));
+
+	kfree(req);
+
+	return ret;
+}
+
+int ra6w_ctrl_add_station_req(struct ra6w_ctrl *ctrl, struct station_parameters *params,
+			      const u8 *mac, u8 vif_idx, struct ra6w_cmd_sta_add_rsp *rsp)
+{
+	struct ra6w_cmd_sta_add_req *req = NULL;
+	struct ra6w_cmd_sta_add_data *req_data = NULL;
+	const struct link_station_parameters *link = NULL;
+	u8 cmd = RA6W_CMD_ME_ADD_STA;
+	int ret;
+
+	if (!rsp)
+		return -ENOENT;
+
+	req = kzalloc(sizeof(*req), GFP_KERNEL);
+	if (!req)
+		return -ENOMEM;
+
+	req_data = &req->data;
+	ether_addr_copy((u8 *)&req_data->mac_addr.addr[0], mac);
+
+	link = &params->link_sta_params;
+	req_data->rate_set.length = min_t(u8, sizeof(req_data->rate_set.array),
+					  link->supported_rates_len);
+
+	memcpy(req_data->rate_set.array, link->supported_rates, req_data->rate_set.length);
+
+	if (params->capability & WLAN_CAPABILITY_SHORT_PREAMBLE)
+		req_data->flags |= cpu_to_le32(RA6W_CMD_STA_CAP_SHORT_PREAMBLE_BIT);
+
+	if (link->ht_capa) {
+		const struct ieee80211_ht_cap *ht_cap = link->ht_capa;
+
+		req_data->flags |= cpu_to_le32(RA6W_CMD_STA_CAP_HT_BIT);
+		req_data->ht_cap.ht_capa_info = ht_cap->cap_info;
+		req_data->ht_cap.a_mpdu_param = ht_cap->ampdu_params_info;
+		memcpy(req_data->ht_cap.mcs_rate, &ht_cap->mcs, sizeof(req_data->ht_cap.mcs_rate));
+		req_data->ht_cap.ht_extended_capa = ht_cap->extended_ht_cap_info;
+		req_data->ht_cap.tx_beamforming_capa = ht_cap->tx_BF_cap_info;
+		req_data->ht_cap.asel_capa = ht_cap->antenna_selection_info;
+	}
+
+	if (link->vht_capa) {
+		const struct ieee80211_vht_cap *vht_cap = link->vht_capa;
+
+		req_data->flags |= cpu_to_le32(RA6W_CMD_STA_CAP_VHT_BIT);
+		req_data->vht_cap.vht_capa_info = vht_cap->vht_cap_info;
+		req_data->vht_cap.rx_highest = vht_cap->supp_mcs.rx_highest;
+		req_data->vht_cap.rx_mcs_map = vht_cap->supp_mcs.rx_mcs_map;
+		req_data->vht_cap.tx_highest = vht_cap->supp_mcs.tx_highest;
+		req_data->vht_cap.tx_mcs_map = vht_cap->supp_mcs.tx_mcs_map;
+	}
+
+	if (link->he_capa) {
+		const struct ieee80211_he_cap_elem *he_cap = link->he_capa;
+
+		req_data->flags |= cpu_to_le32(RA6W_CMD_STA_CAP_HE_BIT);
+		memcpy(req_data->he_cap.mac_cap_info, he_cap->mac_cap_info,
+		       sizeof(he_cap->mac_cap_info));
+		memcpy(req_data->he_cap.phy_cap_info, he_cap->phy_cap_info,
+		       sizeof(he_cap->phy_cap_info));
+	}
+
+	if (params->sta_flags_set & BIT(NL80211_STA_FLAG_WME))
+		req_data->flags |= cpu_to_le32(RA6W_CMD_STA_CAP_QOS_BIT);
+
+	if (params->sta_flags_set & BIT(NL80211_STA_FLAG_MFP))
+		req_data->flags |= cpu_to_le32(RA6W_CMD_STA_CAP_MFP_BIT);
+
+	if (link->opmode_notif_used) {
+		req_data->flags |= cpu_to_le32(RA6W_CMD_STA_OP_NOT_IE_BIT);
+		req_data->opmode_notif = link->opmode_notif;
+	}
+
+	req_data->aid = cpu_to_le16(params->aid);
+	req_data->uapsd_queues = params->uapsd_queues;
+	req_data->max_sp_len = params->max_sp * 2;
+	req_data->vif_idx = vif_idx;
+
+	if (params->sta_flags_set & BIT(NL80211_STA_FLAG_TDLS_PEER)) {
+		const struct ra6w_core *core = container_of(ctrl, struct ra6w_core, ctrl);
+		const struct ra6w_cfg80211_priv *priv = core->priv;
+		const struct ra6w_cfg80211_vif *vif = priv->vif_table[vif_idx];
+
+		req_data->tdls_sta = true;
+		if ((params->ext_capab[3] & WLAN_EXT_CAPA4_TDLS_CHAN_SWITCH) &&
+		    !vif->tdls_chsw_prohibited)
+			req_data->tdls_chsw_allowed = true;
+		if (vif->tdls_status == RA6W_CMD_TDLS_STATE_TX_RSP)
+			req_data->tdls_sta_initiator = true;
+	}
+
+	ret = ra6w_ctrl_set_and_wait_rsp(ctrl, cmd, req, sizeof(req->data), rsp, sizeof(*rsp));
+	if (!ret)
+		ret = ra6w_status_err_code_to_errno(rsp->status);
+
+	kfree(req);
+
+	return ret;
+}
+
+int ra6w_ctrl_del_station_req(struct ra6w_ctrl *ctrl, u8 sta_idx, bool is_tdls_sta)
+{
+	struct ra6w_cmd_sta_del_req *req = NULL;
+	u8 cmd = RA6W_CMD_ME_DEL_STA;
+	int ret;
+
+	req = kzalloc(sizeof(*req), GFP_KERNEL);
+	if (!req)
+		return -ENOMEM;
+
+	req->data.sta_idx = sta_idx;
+	req->data.is_tdls_sta = is_tdls_sta;
+
+	ret = ra6w_ctrl_set_and_wait(ctrl, cmd, req, sizeof(req->data));
+
+	kfree(req);
+
+	return ret;
+}
+
+int ra6w_ctrl_port_control_req(struct ra6w_ctrl *ctrl, bool authorized, u8 sta_idx)
+{
+	struct ra6w_cmd_port_control_req *req = NULL;
+	u8 cmd = RA6W_CMD_ME_SET_CONTROL_PORT;
+	int ret;
+
+	req = kzalloc(sizeof(*req), GFP_KERNEL);
+	if (!req)
+		return -ENOMEM;
+
+	req->data.port_control_state = authorized;
+	req->data.sta_idx = sta_idx;
+
+	ret = ra6w_ctrl_set_and_wait(ctrl, cmd, req, sizeof(req->data));
+
+	kfree(req);
+
+	return ret;
+}
+
+static void ra6w_ctrl_channel_set(struct ra6w_cmd_oper_ch_info *chan,
+				  const struct cfg80211_chan_def *chandef)
+{
+	const struct ieee80211_channel *channel = chandef->chan;
+
+	chan->ch_band = channel->band;
+	chan->ch_bw = bw2chnl[chandef->width];
+	chan->freq_prim20 = cpu_to_le16(channel->center_freq);
+	chan->freq_cen1 = cpu_to_le16(chandef->center_freq1);
+	chan->freq_cen2 = cpu_to_le16(chandef->center_freq2);
+	chan->ch_flags = cpu_to_le16(ra6w_ctrl_get_chan_flags(channel->flags));
+	chan->tx_max_pwr = min_t(int, channel->max_power, channel->max_reg_power);
+}
+
+int ra6w_ctrl_remain_on_channel_req(struct ra6w_ctrl *ctrl, const struct ra6w_cfg80211_vif *vif,
+				    struct ieee80211_channel *chan, int duration)
+{
+	struct ra6w_cmd_roc_req *req = NULL;
+	struct ra6w_cmd_roc_data *req_data = NULL;
+	struct cfg80211_chan_def chandef;
+	u8 cmd = RA6W_CMD_MM_REMAIN_ON_CHANNEL;
+	int ret;
+
+	req = kzalloc(sizeof(*req), GFP_KERNEL);
+	if (!req)
+		return -ENOMEM;
+
+	cfg80211_chandef_create(&chandef, chan, NL80211_CHAN_NO_HT);
+
+	req_data = &req->data;
+	req_data->op_code = RA6W_CMD_ROC_OP_CODE_START;
+	req_data->vif_idx = vif->vif_idx;
+	req_data->duration_ms = cpu_to_le32(duration);
+	ra6w_ctrl_channel_set(&req_data->chan, &chandef);
+
+	ret = ra6w_ctrl_set_and_wait(ctrl, cmd, req, sizeof(req->data));
+
+	kfree(req);
+
+	return ret;
+}
+
+int ra6w_ctrl_cancel_remain_on_channel_req(struct ra6w_ctrl *ctrl)
+{
+	struct ra6w_cmd_roc_req *req = NULL;
+	u8 cmd = RA6W_CMD_MM_REMAIN_ON_CHANNEL;
+	int ret;
+
+	req = kzalloc(sizeof(*req), GFP_KERNEL);
+	if (!req)
+		return -ENOMEM;
+
+	req->data.op_code = RA6W_CMD_ROC_OP_CODE_STOP;
+
+	ret = ra6w_ctrl_set_and_wait(ctrl, cmd, req, sizeof(req->data));
+
+	kfree(req);
+
+	return ret;
+}
+
+int ra6w_ctrl_ap_start_req(struct ra6w_ctrl *ctrl, struct ra6w_cfg80211_vif *vif,
+			   struct cfg80211_ap_settings *settings,
+			   struct ra6w_cmd_ap_start_rsp *rsp)
+{
+	int ret = -ENOENT;
+	struct ra6w_cmd_ap_start_req *req = NULL;
+	struct ra6w_cmd_ap_start_data *req_data = NULL;
+	struct ra6w_cfg80211_beacon_info *beacon_info = NULL;
+	int var_offset = offsetof(struct ieee80211_mgmt, u.beacon.variable);
+	u8 cmd = RA6W_CMD_AM_START;
+	int len = 0;
+	int i;
+	const u8 *var_pos = NULL;
+	u8 *beacon_buf = NULL;
+	const u8 *rate_ie = NULL;
+	u8 rate_len = 0;
+	u32 flags = 0;
+
+	if (!rsp)
+		return -ENOENT;
+
+	req = kzalloc(sizeof(*req), GFP_KERNEL);
+	if (!req)
+		return -ENOMEM;
+
+	beacon_info = &vif->ap.bcn;
+	beacon_info->dtim_period = settings->dtim_period;
+	beacon_buf = ra6w_cfg80211_create_beacon(beacon_info, &settings->beacon);
+	if (!beacon_buf) {
+		ret = -ENOMEM;
+		goto req_free;
+	}
+
+	req_data = &req->data;
+
+	len = beacon_info->len - var_offset;
+	var_pos = beacon_buf + var_offset;
+
+	rate_ie = cfg80211_find_ie(WLAN_EID_SUPP_RATES, var_pos, len);
+	if (rate_ie) {
+		const u8 *rates = rate_ie + 2;
+
+		for (i = 0; (i < rate_ie[1]) && (rate_len < RA6W_CMD_MAC_RATESET_LEN); i++) {
+			if (RA6W_IS_BASIC_RATE(rates[i]))
+				req_data->basic_rates.array[rate_len++] = rates[i];
+		}
+	}
+
+	rate_ie = cfg80211_find_ie(WLAN_EID_EXT_SUPP_RATES, var_pos, len);
+	if (rate_ie) {
+		const u8 *rates = rate_ie + 2;
+
+		for (i = 0; (i < rate_ie[1]) && (rate_len < RA6W_CMD_MAC_RATESET_LEN); i++) {
+			if (RA6W_IS_BASIC_RATE(rates[i]))
+				req_data->basic_rates.array[rate_len++] = rates[i];
+		}
+	}
+
+	req_data->basic_rates.length = rate_len;
+	req_data->vif_idx = vif->vif_idx;
+	memcpy(req_data->beacon, beacon_buf, beacon_info->len);
+	req_data->bcn_len = cpu_to_le16(beacon_info->len);
+	req_data->tim_oft = cpu_to_le16(beacon_info->head_len);
+	req_data->tim_len = beacon_info->tim_len;
+	ra6w_ctrl_channel_set(&req_data->chan, &settings->chandef);
+	req_data->bcn_int = cpu_to_le16(settings->beacon_interval);
+
+	if (settings->crypto.cipher_group) {
+		flags |= RA6W_CMD_CONN_USE_PRIVACY_BIT;
+
+		if (settings->crypto.cipher_group != WLAN_CIPHER_SUITE_WEP40 &&
+		    settings->crypto.cipher_group != WLAN_CIPHER_SUITE_WEP104)
+			flags |= RA6W_CMD_CONN_USE_PAIRWISE_KEY_BIT;
+	}
+
+	if (settings->crypto.control_port)
+		flags |= RA6W_CMD_CONN_CONTROL_PORT_HOST_BIT;
+
+	if (settings->crypto.control_port_no_encrypt)
+		flags |= RA6W_CMD_CONN_CONTROL_PORT_NO_ENC_BIT;
+
+	req_data->flags = cpu_to_le32(flags);
+
+	req_data->ctrl_port_ethertype = cpu_to_be16(ETH_P_PAE);
+	if (settings->crypto.control_port_ethertype)
+		req_data->ctrl_port_ethertype = settings->crypto.control_port_ethertype;
+
+	ret = ra6w_ctrl_set_and_wait_rsp(ctrl, cmd, req, sizeof(req->data), rsp, sizeof(*rsp));
+	if (!ret)
+		ret = ra6w_status_err_code_to_errno(rsp->status);
+
+	kfree(beacon_buf);
+
+req_free:
+	kfree(req);
+
+	return ret;
+}
+
+int ra6w_ctrl_ap_stop_req(struct ra6w_ctrl *ctrl, const struct ra6w_cfg80211_vif *vif)
+{
+	struct ra6w_cmd_ap_stop_req *req = NULL;
+	u8 cmd = RA6W_CMD_AM_STOP;
+	int ret;
+
+	req = kzalloc(sizeof(*req), GFP_KERNEL);
+	if (!req)
+		return -ENOMEM;
+
+	req->data.vif_idx = vif->vif_idx;
+
+	ret = ra6w_ctrl_set_and_wait(ctrl, cmd, req, sizeof(req->data));
+
+	kfree(req);
+
+	return ret;
+}
+
+int ra6w_ctrl_change_beacon_req(struct ra6w_ctrl *ctrl, u8 vif_idx, const u8 *bcn,
+				u16 bcn_len, u16 tim_oft, u16 tim_len, const u16 *csa_oft)
+{
+	struct ra6w_cmd_change_bcn_req *req = NULL;
+	struct ra6w_cmd_change_bcn_data *req_data = NULL;
+	u8 cmd = RA6W_CMD_AM_BCN_CHANGE;
+	int ret;
+
+	req = kzalloc(sizeof(*req), GFP_KERNEL);
+	if (!req)
+		return -ENOMEM;
+
+	req_data = &req->data;
+	req_data->bcn_len = cpu_to_le16(bcn_len);
+	req_data->tim_oft = cpu_to_le16(tim_oft);
+	req_data->tim_len = tim_len;
+	req_data->vif_id = vif_idx;
+	memcpy(req_data->bcn_ptr, bcn, bcn_len);
+
+	if (csa_oft) {
+		int i;
+
+		for (i = 0; i < RA6W_CMD_BCN_MAX_CSA_CPT; i++)
+			req_data->csa_oft[i] = (u8)csa_oft[i];
+	}
+
+	ret = ra6w_ctrl_set_and_wait(ctrl, cmd, req, sizeof(req->data));
+
+	kfree(req);
+
+	return ret;
+}
+
+int ra6w_ctrl_monitor_mode_req(struct ra6w_ctrl *ctrl, const struct cfg80211_chan_def *chandef,
+			       struct ra6w_cmd_mon_mode_rsp *rsp)
+{
+	int ret;
+	struct ra6w_cmd_mon_mode_req *req = NULL;
+	struct ra6w_cmd_mon_mode_data *req_data = NULL;
+	u8 cmd = RA6W_CMD_ME_SET_MON_CFG;
+
+	if (!rsp)
+		return -ENOENT;
+
+	req = kzalloc(sizeof(*req), GFP_KERNEL);
+	if (!req)
+		return -ENOMEM;
+
+	req_data = &req->data;
+
+	if (chandef) {
+		req_data->ch_valid = true;
+		ra6w_ctrl_channel_set(&req_data->chan, chandef);
+	}
+
+	req_data->uf_enable = true;
+
+	ret = ra6w_ctrl_set_and_wait_rsp(ctrl, cmd, req, sizeof(req->data), rsp, sizeof(*rsp));
+
+	kfree(req);
+
+	return ret;
+}
+
+int ra6w_ctrl_probe_client_req(struct ra6w_ctrl *ctrl, u8 vif_idx, u8 sta_idx,
+			       struct ra6w_cmd_probe_client_rsp *rsp)
+{
+	int ret;
+	struct ra6w_cmd_probe_client_req *req = NULL;
+	u8 cmd = RA6W_CMD_AM_PROBE_CLIENT;
+
+	if (!rsp)
+		return -ENOENT;
+
+	req = kzalloc(sizeof(*req), GFP_KERNEL);
+	if (!req)
+		return -ENOMEM;
+
+	req->data.vif_idx = vif_idx;
+	req->data.sta_idx = sta_idx;
+
+	ret = ra6w_ctrl_set_and_wait_rsp(ctrl, cmd, req, sizeof(req->data), rsp, sizeof(*rsp));
+	if (!ret)
+		ret = ra6w_status_err_code_to_errno(rsp->status);
+
+	kfree(req);
+
+	return ret;
+}
+
+int ra6w_ctrl_set_ap_isolate_req(struct ra6w_ctrl *ctrl, u8 ap_isolate,
+				 struct ra6w_cmd_ap_isolate_rsp *rsp)
+{
+	int ret;
+	struct ra6w_cmd_ap_isolate_req *req = NULL;
+	u8 cmd = RA6W_CMD_AM_ISOLATE;
+
+	if (!rsp)
+		return -ENOENT;
+
+	req = kzalloc(sizeof(*req), GFP_KERNEL);
+	if (!req)
+		return -ENOMEM;
+
+	req->data.ap_isolate = ap_isolate;
+
+	ret = ra6w_ctrl_set_and_wait_rsp(ctrl, cmd, req, sizeof(req->data), rsp, sizeof(*rsp));
+
+	kfree(req);
+
+	return ret;
+}
+
+int ra6w_ctrl_edca_req(struct ra6w_ctrl *ctrl, u8 ac, u32 param, bool uapsd, u8 vif_idx)
+{
+	struct ra6w_cmd_edca_req *req = NULL;
+	struct ra6w_cmd_edca_data *req_data = NULL;
+	u8 cmd = RA6W_CMD_MM_SET_EDCA;
+	int ret;
+
+	req = kzalloc(sizeof(*req), GFP_KERNEL);
+	if (!req)
+		return -ENOMEM;
+
+	req_data = &req->data;
+	req_data->ac = ac;
+	req_data->edca_param = cpu_to_le32(param);
+	req_data->uapsd_enabled = uapsd;
+	req_data->vif_idx = vif_idx;
+
+	ret = ra6w_ctrl_set_and_wait(ctrl, cmd, req, sizeof(req->data));
+
+	kfree(req);
+
+	return ret;
+}
+
+int ra6w_ctrl_set_tx_power_req(struct ra6w_ctrl *ctrl, u8 vif_idx, s8 tx_power)
+{
+	struct ra6w_cmd_set_tx_power_req *req = NULL;
+	u8 cmd = RA6W_CMD_MM_SET_POWER;
+	int ret;
+
+	req = kzalloc(sizeof(*req), GFP_KERNEL);
+	if (!req)
+		return -ENOMEM;
+
+	req->data.vif_idx = vif_idx;
+	req->data.tx_power = tx_power;
+
+	ret = ra6w_ctrl_set_and_wait(ctrl, cmd, req, sizeof(req->data));
+
+	kfree(req);
+
+	return ret;
+}
+
+int ra6w_ctrl_set_power_mgmt_req(struct ra6w_ctrl *ctrl, u8 ps_mode)
+{
+	struct ra6w_cmd_set_power_mgmt_req *req = NULL;
+	u8 cmd = RA6W_CMD_ME_SET_PS_MODE;
+	int ret;
+
+	req = kzalloc(sizeof(*req), GFP_KERNEL);
+	if (!req)
+		return -ENOMEM;
+
+	req->data.ps_mode = ps_mode;
+
+	ret = ra6w_ctrl_set_and_wait(ctrl, cmd, req, sizeof(req->data));
+
+	kfree(req);
+
+	return ret;
+}
+
+int ra6w_ctrl_cqm_rssi_config_req(struct ra6w_ctrl *ctrl, u8 vif_idx,
+				  s32 rssi_thold, u32 rssi_hyst)
+{
+	struct ra6w_cmd_cqm_rssi_config_req *req = NULL;
+	u8 cmd = RA6W_CMD_MM_GET_RSSI;
+	int ret;
+
+	req = kzalloc(sizeof(*req), GFP_KERNEL);
+	if (!req)
+		return -ENOMEM;
+
+	req->data.vif_idx = vif_idx;
+	req->data.rssi_thold = rssi_thold;
+	req->data.rssi_hyst = rssi_hyst;
+
+	ret = ra6w_ctrl_set(ctrl, cmd, req, sizeof(req->data));
+
+	kfree(req);
+
+	return ret;
+}
+
+int ra6w_ctrl_sm_ext_auth_req_rsp(struct ra6w_ctrl *ctrl, u8 vif_idx, u16 status)
+{
+	struct ra6w_cmd_sm_ext_auth_req_rsp_req *req = NULL;
+	u8 cmd = RA6W_CMD_SM_EXTERNAL_AUTH_REQUIRED_RSP;
+	int ret;
+
+	req = kzalloc(sizeof(*req), GFP_KERNEL);
+	if (!req)
+		return -ENOMEM;
+
+	req->data.vif_idx = vif_idx;
+	req->data.status = cpu_to_le16(status);
+
+	ret = ra6w_ctrl_set_and_wait(ctrl, cmd, req, sizeof(req->data));
+
+	kfree(req);
+
+	return ret;
+}
+
+int ra6w_ctrl_mem_read_req(struct ra6w_ctrl *ctrl, u32 addr,
+			   struct ra6w_cmd_mem_read_rsp *rsp)
+{
+	struct ra6w_cmd_dbg_mem_read_req *req = NULL;
+	u8 cmd = RA6W_CMD_DBG_MEM_READ;
+	int ret;
+
+	req = kzalloc(sizeof(*req), GFP_KERNEL);
+	if (!req)
+		return -ENOMEM;
+
+	req->data.mem_addr = cpu_to_le32(addr);
+
+	ret = ra6w_ctrl_set_and_wait_rsp(ctrl, cmd, req, sizeof(req->data), rsp, sizeof(*rsp));
+
+	kfree(req);
+
+	return ret;
+}
+
+int ra6w_ctrl_mem_write_req(struct ra6w_ctrl *ctrl, u32 addr, u32 value)
+{
+	struct ra6w_cmd_dbg_mem_write_req *req = NULL;
+	u8 cmd = RA6W_CMD_DBG_MEM_WRITE;
+	int ret;
+
+	req = kzalloc(sizeof(*req), GFP_KERNEL);
+	if (!req)
+		return -ENOMEM;
+
+	req->data.mem_addr = cpu_to_le32(addr);
+	req->data.mem_value = cpu_to_le32(value);
+
+	ret = ra6w_ctrl_set_and_wait(ctrl, cmd, req, sizeof(req->data));
+
+	kfree(req);
+
+	return ret;
+}
+
+int ra6w_ctrl_dbg_mode_filter_req(struct ra6w_ctrl *ctrl, u32 mode)
+{
+	struct ra6w_cmd_dbg_mode_filter_req *req = NULL;
+	u8 cmd = RA6W_CMD_DBG_SET_MOD_FILTER;
+	int ret;
+
+	req = kzalloc(sizeof(*req), GFP_KERNEL);
+	if (!req)
+		return -ENOMEM;
+
+	req->data.mode_filter = cpu_to_le32(mode);
+
+	ret = ra6w_ctrl_set_and_wait(ctrl, cmd, req, sizeof(req->data));
+
+	kfree(req);
+
+	return ret;
+}
+
+int ra6w_ctrl_dbg_level_filter_req(struct ra6w_ctrl *ctrl, u32 level)
+{
+	struct ra6w_cmd_dbg_level_filter_req *req = NULL;
+	u8 cmd = RA6W_CMD_DBG_SET_SEV_FILTER;
+	int ret;
+
+	req = kzalloc(sizeof(*req), GFP_KERNEL);
+	if (!req)
+		return -ENOMEM;
+
+	req->data.level_filter = cpu_to_le32(level);
+
+	ret = ra6w_ctrl_set_and_wait(ctrl, cmd, req, sizeof(req->data));
+
+	kfree(req);
+
+	return ret;
+}
+
+int ra6w_ctrl_rf_tx_req(struct ra6w_ctrl *ctrl, struct ra6w_cmd_rf_tx_data *data)
+{
+	struct ra6w_cmd_rf_tx_req *req = NULL;
+	struct ra6w_cmd_rf_tx_data *req_data = NULL;
+	u8 cmd = RA6W_CMD_DBG_RF_TX;
+	int ret;
+
+	req = kzalloc(sizeof(*req), GFP_KERNEL);
+	if (!req)
+		return -ENOMEM;
+
+	req_data = &req->data;
+	req_data->start = data->start;
+	req_data->frequency = data->frequency;
+	req_data->num_frames = data->num_frames;
+	req_data->frame_len = data->frame_len;
+	req_data->tx_rate = data->tx_rate;
+	req_data->tx_power = data->tx_power;
+	req_data->dest_addr = data->dest_addr;
+	req_data->bssid = data->bssid;
+	req_data->gi = data->gi;
+	req_data->green_field = data->green_field;
+	req_data->preamble_type = data->preamble_type;
+	req_data->qos_enable = data->qos_enable;
+	req_data->ack_policy = data->ack_policy;
+	req_data->aifsn_val = data->aifsn_val;
+
+	ret = ra6w_ctrl_set_and_wait(ctrl, cmd, req, sizeof(req->data));
+
+	kfree(req);
+
+	return ret;
+}
+
+int ra6w_ctrl_rf_cw_req(struct ra6w_ctrl *ctrl, const struct ra6w_cmd_rf_cw_data *data)
+{
+	struct ra6w_cmd_rf_cw_req *req = NULL;
+	u8 cmd = RA6W_CMD_DBG_RF_CW;
+	int ret;
+
+	req = kzalloc(sizeof(*req), GFP_KERNEL);
+	if (!req)
+		return -ENOMEM;
+
+	req->data.start = data->start;
+	req->data.frequency = data->frequency;
+	req->data.tx_power = data->tx_power;
+
+	ret = ra6w_ctrl_set_and_wait(ctrl, cmd, req, sizeof(*req));
+
+	kfree(req);
+
+	return ret;
+}
+
+int ra6w_ctrl_rf_cont_req(struct ra6w_ctrl *ctrl, const struct ra6w_cmd_rf_cont_data *data)
+{
+	struct ra6w_cmd_rf_cont_req *req = NULL;
+	u8 cmd = RA6W_CMD_DBG_RF_CONT;
+	int ret;
+
+	req = kzalloc(sizeof(*req), GFP_KERNEL);
+	if (!req)
+		return -ENOMEM;
+
+	req->data.start = data->start;
+	req->data.frequency = data->frequency;
+	req->data.tx_power = data->tx_power;
+
+	ret = ra6w_ctrl_set_and_wait(ctrl, cmd, req, sizeof(*req));
+
+	kfree(req);
+
+	return ret;
+}
+
+int ra6w_ctrl_rf_ch_req(struct ra6w_ctrl *ctrl, u16 frequency)
+{
+	struct ra6w_cmd_rf_ch_req *req = NULL;
+	u8 cmd = RA6W_CMD_DBG_RF_CH;
+	int ret;
+
+	req = kzalloc(sizeof(*req), GFP_KERNEL);
+	if (!req)
+		return -ENOMEM;
+
+	req->data.frequency = cpu_to_le16(frequency);
+
+	ret = ra6w_ctrl_set_and_wait(ctrl, cmd, req, sizeof(*req));
+
+	kfree(req);
+
+	return ret;
+}
+
+int ra6w_ctrl_rf_per_req(struct ra6w_ctrl *ctrl, u8 start, struct ra6w_cmd_rf_per_rsp *rsp)
+{
+	int ret;
+	struct ra6w_cmd_rf_per_req *req = NULL;
+	u8 cmd = RA6W_CMD_DBG_RF_PER;
+
+	if (!rsp)
+		return -ENOENT;
+
+	req = kzalloc(sizeof(*req), GFP_KERNEL);
+	if (!req)
+		return -ENOMEM;
+
+	req->data.start = start;
+
+	ret = ra6w_ctrl_set_and_wait_rsp(ctrl, cmd, req, sizeof(*req), rsp, sizeof(*rsp));
+
+	kfree(req);
+
+	return ret;
+}
+
+int ra6w_ctrl_stats_tx_req(struct ra6w_ctrl *ctrl, u8 req_type, struct ra6w_cmd_stats_tx_rsp *rsp)
+{
+	int ret;
+	struct ra6w_cmd_stats_tx_req *req = NULL;
+	u8 cmd = RA6W_CMD_DBG_STATS_TX;
+
+	if (!rsp)
+		return -ENOENT;
+
+	req = kzalloc(sizeof(*req), GFP_KERNEL);
+	if (!req)
+		return -ENOMEM;
+
+	req->data.req_type = req_type;
+
+	ret = ra6w_ctrl_set_and_wait_rsp(ctrl, cmd, req, sizeof(*req), rsp, sizeof(*rsp));
+	if (!ret && rsp->status != RA6W_STATS_STATUS_ENABLED)
+		ret = -EPERM;
+
+	kfree(req);
+
+	return ret;
+}
+
+int ra6w_ctrl_stats_tx_start_req(struct ra6w_ctrl *ctrl, u8 req_type)
+{
+	int ret;
+	struct ra6w_cmd_stats_tx_req *req = NULL;
+	u8 cmd = RA6W_CMD_DBG_STATS_TX;
+
+	req = kzalloc(sizeof(*req), GFP_KERNEL);
+	if (!req)
+		return -ENOMEM;
+
+	req->data.req_type = req_type;
+
+	ret = ra6w_ctrl_set_and_wait(ctrl, cmd, req, sizeof(*req));
+
+	kfree(req);
+
+	return ret;
+}
+
+void ra6w_ctrl_init(struct ra6w_ctrl *ctrl)
+{
+	atomic_set(&ctrl->event.condition, RA6W_CTRL_EVENT_RESET);
+	init_waitqueue_head(&ctrl->event.wait_queue);
+}
-- 
2.17.1


