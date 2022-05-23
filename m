Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0785530AA8
	for <lists+linux-wireless@lfdr.de>; Mon, 23 May 2022 10:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbiEWHqm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 23 May 2022 03:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231295AbiEWHqg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 23 May 2022 03:46:36 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D309318387
        for <linux-wireless@vger.kernel.org>; Mon, 23 May 2022 00:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1653291994; x=1684827994;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SYZtd6kbLP5eqlkD9Nn28cDORVEsM1UcG2akq0E0BvM=;
  b=yWcvORW2JwOU4OfniMafuz8cR0bz/vu84MzFKpFakdOEwUMoiZzhfsM8
   aclYRsocpq18y28yOqixdQfiDyNRFMckxM73xBF7Lth3lbYla0x0xtaPR
   0Rn4a4dGpsk/UvPUFWyFBC+bcNmErIYwNzNqFdBnojDiQFpU+Ld/YdZwl
   Y=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 22 May 2022 23:01:28 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2022 23:01:28 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Sun, 22 May 2022 23:01:28 -0700
Received: from alokad-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Sun, 22 May 2022 23:01:27 -0700
From:   Aloka Dixit <quic_alokad@quicinc.com>
To:     <johannes@sipsolutions.net>, <linux-wireless@vger.kernel.org>,
        <ath11k@lists.infradead.org>
CC:     Aloka Dixit <quic_alokad@quicinc.com>,
        John Crispin <john@phrozen.org>
Subject: [PATCH 6/9] ath11k: configure MBSSID device parameters
Date:   Sun, 22 May 2022 23:01:05 -0700
Message-ID: <20220523060108.23982-7-quic_alokad@quicinc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220523060108.23982-1-quic_alokad@quicinc.com>
References: <20220523060108.23982-1-quic_alokad@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add new field nontransmitting_vif_count in struct ath11k_vif which
keeps track of non-transmitting interfaces associated with a
transmitting interface when MBSSID is enabled.
The count is decremented when WMI vdev down is invoked and incremented
when WMI vdev up is invoked.
Use this field to set the profile index and total profile count during
WMI vdev up operation.

Signed-off-by: Aloka Dixit <quic_alokad@quicinc.com>
Co-developed-by: John Crispin <john@phrozen.org>
Signed-off-by: John Crispin <john@phrozen.org>
---
 drivers/net/wireless/ath/ath11k/core.h |  2 ++
 drivers/net/wireless/ath/ath11k/mac.c  | 32 +++++++++++++++++++++++---
 2 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index 95bca0b078b1..750dc9b46860 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -357,6 +357,8 @@ struct ath11k_vif {
 #ifdef CONFIG_ATH11K_DEBUGFS
 	struct dentry *debugfs_twt;
 #endif /* CONFIG_ATH11K_DEBUGFS */
+
+	u8 nontransmitting_vif_count;
 };
 
 struct ath11k_vif_iter {
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 32ddb80f4cec..10d35cdfafdb 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -1421,9 +1421,13 @@ static void ath11k_control_beaconing(struct ath11k_vif *arvif,
 				     struct ieee80211_bss_conf *info)
 {
 	struct ath11k *ar = arvif->ar;
+	struct ath11k_vif *tx_arvif = NULL;
 	int ret = 0;
 	struct vdev_up_params params = { 0 };
 
+	if (arvif->vif->mbssid_tx_vif)
+		tx_arvif = (void *)arvif->vif->mbssid_tx_vif->drv_priv;
+
 	lockdep_assert_held(&arvif->ar->conf_mutex);
 
 	if (!info->enable_beacon) {
@@ -1433,6 +1437,9 @@ static void ath11k_control_beaconing(struct ath11k_vif *arvif,
 				    arvif->vdev_id, ret);
 
 		arvif->is_up = false;
+		if (tx_arvif)
+			tx_arvif->nontransmitting_vif_count = 0;
+
 		return;
 	}
 
@@ -1453,6 +1460,13 @@ static void ath11k_control_beaconing(struct ath11k_vif *arvif,
 	params.vdev_id = arvif->vdev_id;
 	params.aid = arvif->aid;
 	params.bssid = arvif->bssid;
+	if (tx_arvif) {
+		params.tx_bssid = tx_arvif->bssid;
+		params.profile_idx = info->bssid_index;
+		if (params.profile_idx >= tx_arvif->nontransmitting_vif_count)
+			tx_arvif->nontransmitting_vif_count = params.profile_idx;
+		params.profile_count = tx_arvif->nontransmitting_vif_count;
+	}
 	ret = ath11k_wmi_vdev_up(arvif->ar, &params);
 	if (ret) {
 		ath11k_warn(ar->ab, "failed to bring up vdev %d: %i\n",
@@ -2813,7 +2827,7 @@ static void ath11k_bss_disassoc(struct ieee80211_hw *hw,
 				struct ieee80211_vif *vif)
 {
 	struct ath11k *ar = hw->priv;
-	struct ath11k_vif *arvif = (void *)vif->drv_priv;
+	struct ath11k_vif *arvif = (void *)vif->drv_priv, *tx_arvif;
 	int ret;
 
 	lockdep_assert_held(&ar->conf_mutex);
@@ -2827,6 +2841,11 @@ static void ath11k_bss_disassoc(struct ieee80211_hw *hw,
 			    arvif->vdev_id, ret);
 
 	arvif->is_up = false;
+	if (arvif->vif->mbssid_tx_vif) {
+		tx_arvif = (void *)arvif->vif->mbssid_tx_vif->drv_priv;
+		if (tx_arvif != arvif)
+			tx_arvif->nontransmitting_vif_count--;
+	}
 
 	memset(&arvif->rekey_data, 0, sizeof(arvif->rekey_data));
 
@@ -3372,7 +3391,8 @@ static void ath11k_mac_op_bss_info_changed(struct ieee80211_hw *hw,
 			ret = ath11k_wmi_send_obss_color_collision_cfg_cmd(
 				ar, arvif->vdev_id, info->he_bss_color.color,
 				ATH11K_BSS_COLOR_COLLISION_DETECTION_AP_PERIOD_MS,
-				info->he_bss_color.enabled);
+				arvif->vif->bss_conf.nontransmitted ?
+				0 : info->he_bss_color.enabled);
 			if (ret)
 				ath11k_warn(ar->ab, "failed to set bss color collision on vdev %i: %d\n",
 					    arvif->vdev_id,  ret);
@@ -6952,7 +6972,7 @@ ath11k_mac_update_vif_chan(struct ath11k *ar,
 			   int n_vifs)
 {
 	struct ath11k_base *ab = ar->ab;
-	struct ath11k_vif *arvif;
+	struct ath11k_vif *arvif, *tx_arvif;
 	int ret;
 	int i;
 	bool monitor_vif = false;
@@ -7011,6 +7031,12 @@ ath11k_mac_update_vif_chan(struct ath11k *ar,
 		params.vdev_id = arvif->vdev_id;
 		params.aid = arvif->aid;
 		params.bssid = arvif->bssid;
+		if (arvif->vif->mbssid_tx_vif) {
+			tx_arvif = (void *)arvif->vif->mbssid_tx_vif->drv_priv;
+			params.tx_bssid = tx_arvif->bssid;
+			params.profile_idx = arvif->vif->bss_conf.bssid_index;
+			params.profile_count = tx_arvif->nontransmitting_vif_count;
+		}
 		ret = ath11k_wmi_vdev_up(arvif->ar, &params);
 		if (ret) {
 			ath11k_warn(ab, "failed to bring vdev up %d: %d\n",
-- 
2.31.1

