Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5317C47ED7F
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Dec 2021 09:53:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352044AbhLXIxO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Dec 2021 03:53:14 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:43502 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352109AbhLXIxN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Dec 2021 03:53:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1640335993; x=1671871993;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=60bRtmFjNvT6LC3UYZQHBnguRZ1sGGjmPtz8GBAj30Q=;
  b=cuK+wj9d2IIWTaz1A3IyEEoymjrRwfsJ7vku5CsaqYyyjH0pRGtXA7Kx
   Y5L7J1T7o4z9s8xp8dhCeL+IVjMGtpp4LM2h1N/ICX5n93isik82ulh+r
   v6LhzST20AmNdT38K0TVkI5ahUoHo0G+K9F4KcNsmXw3EEKm0ai6ufMa8
   I=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 24 Dec 2021 00:53:13 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Dec 2021 00:53:13 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Fri, 24 Dec 2021 00:53:12 -0800
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Fri, 24 Dec 2021 00:53:11 -0800
From:   Wen Gong <quic_wgong@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <quic_wgong@quicinc.com>
Subject: [PATCH v2 13/15] ath11k: discard BSS_CHANGED_TXPOWER when EXT_TPC_REG_SUPPORT for 6 GHz
Date:   Fri, 24 Dec 2021 03:52:34 -0500
Message-ID: <20211224085236.9064-14-quic_wgong@quicinc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211224085236.9064-1-quic_wgong@quicinc.com>
References: <20211224085236.9064-1-quic_wgong@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When station is connected to a 6 GHz AP, it has 2 way to configure
the power limit to firmware. The first way is to send 2 wmi command
WMI_PDEV_PARAM_TXPOWER_LIMIT2G/WMI_PDEV_PARAM_TXPOWER_LIMIT5G to
firmware, the second way is to send WMI_VDEV_SET_TPC_POWER_CMDID to
firmware which include more parameters for power control.

When firmware support SERVICE_EXT_TPC_REG, it means firmware support
the second way for WMI_VDEV_SET_TPC_POWER_CMDID, then ath11k discard
BSS_CHANGED_TXPOWER flag from mac80211 which is used to the first way
for 6 GHz band in this patch and select the second way in the subsequent
patch.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1

Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/hw.c  |  6 ++++++
 drivers/net/wireless/ath/ath11k/hw.h  |  1 +
 drivers/net/wireless/ath/ath11k/mac.c | 19 +++++++++++++++++--
 3 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/hw.c b/drivers/net/wireless/ath/ath11k/hw.c
index 712818edb4ca..5734fbfc6db5 100644
--- a/drivers/net/wireless/ath/ath11k/hw.c
+++ b/drivers/net/wireless/ath/ath11k/hw.c
@@ -812,6 +812,12 @@ bool ath11k_hw_supports_6g_cc_ext(struct ath11k *ar)
 	return ath11k_hw_supports_cc_ext(ar->ab) && ar->supports_6ghz;
 }
 
+bool ath11k_hw_supports_tpc_ext(struct ath11k *ar)
+{
+	return ath11k_hw_supports_6g_cc_ext(ar) &&
+	       test_bit(WMI_TLV_SERVICE_EXT_TPC_REG_SUPPORT, ar->ab->wmi_ab.svc_map);
+}
+
 const struct ath11k_hw_ops ipq8074_ops = {
 	.get_hw_mac_from_pdev_id = ath11k_hw_ipq8074_mac_from_pdev_id,
 	.wmi_init_config = ath11k_init_wmi_config_ipq8074,
diff --git a/drivers/net/wireless/ath/ath11k/hw.h b/drivers/net/wireless/ath/ath11k/hw.h
index 969d29aaee6a..909ddd0fa187 100644
--- a/drivers/net/wireless/ath/ath11k/hw.h
+++ b/drivers/net/wireless/ath/ath11k/hw.h
@@ -279,6 +279,7 @@ static inline int ath11k_hw_mac_id_to_srng_id(struct ath11k_hw_params *hw,
 
 bool ath11k_hw_supports_cc_ext(struct ath11k_base *ab);
 bool ath11k_hw_supports_6g_cc_ext(struct ath11k *ar);
+bool ath11k_hw_supports_tpc_ext(struct ath11k *ar);
 
 struct ath11k_fw_ie {
 	__le32 id;
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index e1bdfe466bc7..54d7327265d6 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -3078,6 +3078,16 @@ static int ath11k_mac_config_obss_pd(struct ath11k *ar,
 	return 0;
 }
 
+static bool ath11k_mac_supports_station_tpc(struct ath11k *ar,
+					    struct ath11k_vif *arvif,
+					    const struct cfg80211_chan_def *chandef)
+{
+	return ath11k_hw_supports_tpc_ext(ar) &&
+	       arvif->vdev_type == WMI_VDEV_TYPE_STA &&
+	       chandef->chan &&
+	       chandef->chan->band == NL80211_BAND_6GHZ;
+}
+
 static void ath11k_mac_op_bss_info_changed(struct ieee80211_hw *hw,
 					   struct ieee80211_vif *vif,
 					   struct ieee80211_bss_conf *info,
@@ -3268,8 +3278,13 @@ static void ath11k_mac_op_bss_info_changed(struct ieee80211_hw *hw,
 		ath11k_dbg(ar->ab, ATH11K_DBG_MAC, "mac vdev_id %i txpower %d\n",
 			   arvif->vdev_id, info->txpower);
 
-		arvif->txpower = info->txpower;
-		ath11k_mac_txpower_recalc(ar);
+		if (ath11k_mac_supports_station_tpc(ar, arvif, &info->chandef)) {
+			ath11k_dbg(ar->ab, ATH11K_DBG_MAC,
+				   "discard tx power, change to set TPC power\n");
+		} else {
+			arvif->txpower = info->txpower;
+			ath11k_mac_txpower_recalc(ar);
+		}
 	}
 
 	if (changed & BSS_CHANGED_PS &&
-- 
2.31.1

