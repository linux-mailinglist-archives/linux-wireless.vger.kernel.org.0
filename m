Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21CDD43D97B
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Oct 2021 04:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbhJ1Cuf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 Oct 2021 22:50:35 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:19400 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbhJ1Cud (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 Oct 2021 22:50:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1635389288; x=1666925288;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=h3qcP1eJIif59J3YuE0ozu1JxO8u8oMGwSmyPSlHp30=;
  b=ldwtthKwvjIoJ3e15KnW6pgFn8BWW2CwWvMjnslWGgTjmcndzANNA475
   xpjjf59g/DgJpWLif92rm4nuDilZDcJpHVTyrdh4AMOyZHHAfojL/SXQJ
   n33EJttG/wJ0470cAOPD4FProAgL+OwwCG5jh5Y8btToS2P3JERXCX47x
   4=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 27 Oct 2021 19:48:07 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2021 19:48:07 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.7;
 Wed, 27 Oct 2021 19:48:06 -0700
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.7;
 Wed, 27 Oct 2021 19:48:05 -0700
From:   Wen Gong <quic_wgong@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <quic_wgong@quicinc.com>
Subject: [PATCH] ath11k: fix read fail for htt_stats and htt_peer_stats for single pdev
Date:   Wed, 27 Oct 2021 22:47:49 -0400
Message-ID: <20211028024749.15039-1-quic_wgong@quicinc.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The pdev id is set to 0 for single pdev configured hardware, the real
pdev id is not 0 in firmware, for example, its pdev id is 1 for 5G/6G
phy and 2 for 2G band phy. For HTT_H2T_MSG_TYPE_EXT_STATS_CFG message,
firmware parse the pdev_mask to its pdev id, ath11k set it to 0 for
single pdev, it is not correct, need set it with the real pdev id of
firmware.

Save the real pdev id report by firmware and set it correctly.

Below commands run success with this patch:
cat /sys/kernel/debug/ieee80211/phy0/ath11k/htt_stats
cat /sys/kernel/debug/ieee80211/phy0/netdev\:wls1/stations/00\:03\:7f\:75\:59\:85/htt_peer_stats

Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1

Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/core.h  |  5 ++
 drivers/net/wireless/ath/ath11k/dp_tx.c |  9 +++-
 drivers/net/wireless/ath/ath11k/mac.c   | 61 +++++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/mac.h   |  4 ++
 drivers/net/wireless/ath/ath11k/wmi.c   |  6 +++
 drivers/net/wireless/ath/ath11k/wmi.h   |  4 +-
 6 files changed, 86 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index c6ea362f24fb..be475a0bc112 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -755,6 +755,11 @@ struct ath11k_base {
 	/* Protects data like peers */
 	spinlock_t base_lock;
 	struct ath11k_pdev pdevs[MAX_RADIOS];
+	struct {
+		enum WMI_HOST_WLAN_BAND supported_bands;
+		u32 pdev_id;
+	} target_pdev_ids[MAX_RADIOS];
+	u8 target_pdev_count;
 	struct ath11k_pdev __rcu *pdevs_active[MAX_RADIOS];
 	struct ath11k_hal_reg_capabilities_ext hal_reg_cap[MAX_RADIOS];
 	unsigned long long free_vdev_map;
diff --git a/drivers/net/wireless/ath/ath11k/dp_tx.c b/drivers/net/wireless/ath/ath11k/dp_tx.c
index 8bba5234f81f..9164f3ee5270 100644
--- a/drivers/net/wireless/ath/ath11k/dp_tx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_tx.c
@@ -9,6 +9,7 @@
 #include "debugfs_sta.h"
 #include "hw.h"
 #include "peer.h"
+#include "mac.h"
 
 static enum hal_tcl_encap_type
 ath11k_dp_tx_get_encap_type(struct ath11k_vif *arvif, struct sk_buff *skb)
@@ -985,6 +986,7 @@ ath11k_dp_tx_htt_h2t_ext_stats_req(struct ath11k *ar, u8 type,
 	struct ath11k_dp *dp = &ab->dp;
 	struct sk_buff *skb;
 	struct htt_ext_stats_cfg_cmd *cmd;
+	u32 pdev_id;
 	int len = sizeof(*cmd);
 	int ret;
 
@@ -998,7 +1000,12 @@ ath11k_dp_tx_htt_h2t_ext_stats_req(struct ath11k *ar, u8 type,
 	memset(cmd, 0, sizeof(*cmd));
 	cmd->hdr.msg_type = HTT_H2T_MSG_TYPE_EXT_STATS_CFG;
 
-	cmd->hdr.pdev_mask = 1 << ar->pdev->pdev_id;
+	if (ab->hw_params.single_pdev_only)
+		pdev_id = ath11k_mac_get_target_pdev_id(ar);
+	else
+		pdev_id = ar->pdev->pdev_id;
+
+	cmd->hdr.pdev_mask = 1 << pdev_id;
 
 	cmd->hdr.stats_type = type;
 	cmd->cfg_param0 = cfg_params->cfg0;
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index ad3510bec4da..7f3439f87d45 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -552,6 +552,67 @@ struct ath11k *ath11k_mac_get_ar_by_pdev_id(struct ath11k_base *ab, u32 pdev_id)
 	return NULL;
 }
 
+struct ath11k_vif *ath11k_mac_get_vif_up(struct ath11k_base *ab)
+{
+	struct ath11k *ar;
+	struct ath11k_pdev *pdev;
+	struct ath11k_vif *arvif;
+	int i;
+
+	for (i = 0; i < ab->num_radios; i++) {
+		pdev = &ab->pdevs[i];
+		ar = pdev->ar;
+		list_for_each_entry(arvif, &ar->arvifs, list) {
+			if (arvif->is_up)
+				return arvif;
+		}
+	}
+
+	return NULL;
+}
+
+static bool ath11k_mac_band_match(enum nl80211_band band1, enum WMI_HOST_WLAN_BAND band2)
+{
+	return (((band1 == NL80211_BAND_2GHZ) && (band2 & WMI_HOST_WLAN_2G_CAP)) ||
+		(((band1 == NL80211_BAND_5GHZ) || (band1 == NL80211_BAND_6GHZ)) &&
+		   (band2 & WMI_HOST_WLAN_5G_CAP)));
+}
+
+u8 ath11k_mac_get_target_pdev_id_from_vif(struct ath11k_vif *arvif)
+{
+	struct ath11k *ar = arvif->ar;
+	struct ath11k_base *ab = ar->ab;
+	struct ieee80211_vif *vif = arvif->vif;
+	struct cfg80211_chan_def def;
+	enum nl80211_band band;
+	u8 pdev_id = ab->target_pdev_ids[0].pdev_id;
+	int i;
+
+	if (WARN_ON(ath11k_mac_vif_chan(vif, &def)))
+		return pdev_id;
+
+	band = def.chan->band;
+
+	for (i = 0; i < ab->target_pdev_count; i++) {
+		if (ath11k_mac_band_match(band, ab->target_pdev_ids[i].supported_bands))
+			return ab->target_pdev_ids[i].pdev_id;
+	}
+
+	return pdev_id;
+}
+
+u8 ath11k_mac_get_target_pdev_id(struct ath11k *ar)
+{
+	struct ath11k_vif *arvif;
+
+	arvif = ath11k_mac_get_vif_up(ar->ab);
+
+	if (arvif)
+		return ath11k_mac_get_target_pdev_id_from_vif(arvif);
+	else
+		return ar->ab->target_pdev_ids[0].pdev_id;
+}
+
 static void ath11k_pdev_caps_update(struct ath11k *ar)
 {
 	struct ath11k_base *ab = ar->ab;
diff --git a/drivers/net/wireless/ath/ath11k/mac.h b/drivers/net/wireless/ath/ath11k/mac.h
index 86a186d32e99..0b2a1612f745 100644
--- a/drivers/net/wireless/ath/ath11k/mac.h
+++ b/drivers/net/wireless/ath/ath11k/mac.h
@@ -150,6 +150,10 @@ int ath11k_mac_rfkill_config(struct ath11k *ar);
 struct ath11k_vif *ath11k_mac_get_arvif(struct ath11k *ar, u32 vdev_id);
 struct ath11k_vif *ath11k_mac_get_arvif_by_vdev_id(struct ath11k_base *ab,
 						   u32 vdev_id);
+u8 ath11k_mac_get_target_pdev_id(struct ath11k *ar);
+u8 ath11k_mac_get_target_pdev_id_from_vif(struct ath11k_vif *arvif);
+struct ath11k_vif *ath11k_mac_get_vif_up(struct ath11k_base *ab);
+
 struct ath11k *ath11k_mac_get_ar_by_vdev_id(struct ath11k_base *ab, u32 vdev_id);
 struct ath11k *ath11k_mac_get_ar_by_pdev_id(struct ath11k_base *ab, u32 pdev_id);
 enum wmi_vdev_type ath11k_mac_get_ar_vdev_type(struct ath11k *ar);
diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index cef140e8aa6e..e4e3f6696e48 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -320,6 +320,7 @@ ath11k_pull_mac_phy_cap_svc_ready_ext(struct ath11k_pdev_wmi *wmi_handle,
 				      struct ath11k_pdev *pdev)
 {
 	struct wmi_mac_phy_capabilities *mac_phy_caps;
+	struct ath11k_base *ab = wmi_handle->wmi_ab->ab;
 	struct ath11k_band_cap *cap_band;
 	struct ath11k_pdev_cap *pdev_cap = &pdev->cap;
 	u32 phy_map;
@@ -351,6 +352,10 @@ ath11k_pull_mac_phy_cap_svc_ready_ext(struct ath11k_pdev_wmi *wmi_handle,
 	pdev->pdev_id = mac_phy_caps->pdev_id;
 	pdev_cap->supported_bands |= mac_phy_caps->supported_bands;
 	pdev_cap->ampdu_density = mac_phy_caps->ampdu_density;
+	ab->target_pdev_ids[ab->target_pdev_count].supported_bands =
+		mac_phy_caps->supported_bands;
+	ab->target_pdev_ids[ab->target_pdev_count].pdev_id = mac_phy_caps->pdev_id;
+	ab->target_pdev_count++;
 
 	/* Take non-zero tx/rx chainmask. If tx/rx chainmask differs from
 	 * band to band for a single radio, need to see how this should be
@@ -4306,6 +4311,7 @@ static int ath11k_wmi_tlv_ext_soc_hal_reg_caps_parse(struct ath11k_base *soc,
 	svc_rdy_ext->param.num_phy = svc_rdy_ext->soc_hal_reg_caps->num_phy;
 
 	soc->num_radios = 0;
+	soc->target_pdev_count = 0;
 	phy_id_map = svc_rdy_ext->pref_hw_mode_caps.phy_id_map;
 
 	while (phy_id_map && soc->num_radios < MAX_RADIOS) {
diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
index f9ac109fc7c1..ef7b20ba8c95 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -115,10 +115,10 @@ enum wmi_host_hw_mode_priority {
 	WMI_HOST_HW_MODE_MAX_PRI
 };
 
-enum {
+enum WMI_HOST_WLAN_BAND {
 	WMI_HOST_WLAN_2G_CAP	= 0x1,
 	WMI_HOST_WLAN_5G_CAP	= 0x2,
-	WMI_HOST_WLAN_2G_5G_CAP	= 0x3,
+	WMI_HOST_WLAN_2G_5G_CAP	= WMI_HOST_WLAN_2G_CAP | WMI_HOST_WLAN_5G_CAP,
 };
 
 /*
-- 
2.31.1

