Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F81253C6F0
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jun 2022 10:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242837AbiFCI2t (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 3 Jun 2022 04:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236793AbiFCI2r (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 3 Jun 2022 04:28:47 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADE1A1DA6C
        for <linux-wireless@vger.kernel.org>; Fri,  3 Jun 2022 01:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1654244923; x=1685780923;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=vsdHMBbWYySCVMmt2M7J4AJC+lyS3tKNTe9m+MALQis=;
  b=xFqaQqkQJJf5TUokZV3zpAw3QzFJseXPbMNNoZTh0rPTqkhzlodf1xop
   1A2eeO7Oe8hX+VfMtaOhdGWSU5YycBObr5Bxk4CNAOdGSXTIRIy21rL++
   YJBidmfG9rlazrrCs9IcEh9YVbP6IR2iXEj9kr13nXf3Qj5y06/wGa1Vp
   Y=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 03 Jun 2022 01:28:43 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2022 01:28:43 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 3 Jun 2022 01:28:42 -0700
Received: from adisi-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 3 Jun 2022 01:28:40 -0700
From:   Aditya Kumar Singh <quic_adisi@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Aditya Kumar Singh <quic_adisi@quicinc.com>
Subject: [PATCH v3 2/2] ath11k: add get_txpower mac ops
Date:   Fri, 3 Jun 2022 13:58:14 +0530
Message-ID: <20220603082814.31466-3-quic_adisi@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220603082814.31466-1-quic_adisi@quicinc.com>
References: <20220603082814.31466-1-quic_adisi@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
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

Driver does not support get_txpower mac ops because of which
cfg80211 returns vif->bss_conf.txpower to user space. bss_conf.txpower
gets its value from ieee80211_channel->max_reg_power. However, the final
txpower is dependent on few other parameters apart from max regulatory
supported power. It is the firmware which knows about all these
parameters and considers the minimum for each packet transmission.

All ath11k firmware reports the final tx power in firmware pdev stats
which falls under fw_stats.

Add get_txpower mac ops to get the tx power from firmware leveraging
fw_stats and return it accordingly.

Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.5.0.1-01100-QCAHKSWPL_SILICONZ-1
Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.5.0.1-01100-QCAHKSWPL_SILICONZ-1
Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3

Signed-off-by: Aditya Kumar Singh <quic_adisi@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/mac.c | 92 +++++++++++++++++++++++++++
 1 file changed, 92 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index f11956163822..e0b6c9aa4727 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -8471,6 +8471,95 @@ static int ath11k_mac_op_remain_on_channel(struct ieee80211_hw *hw,
 	return ret;
 }
 
+static int ath11k_fw_stats_request(struct ath11k *ar,
+				   struct stats_request_params *req_param)
+{
+	struct ath11k_base *ab = ar->ab;
+	unsigned long time_left;
+	int ret;
+
+	lockdep_assert_held(&ar->conf_mutex);
+
+	spin_lock_bh(&ar->data_lock);
+	ar->fw_stats_done = false;
+	ath11k_fw_stats_pdevs_free(&ar->fw_stats.pdevs);
+	spin_unlock_bh(&ar->data_lock);
+
+	reinit_completion(&ar->fw_stats_complete);
+
+	ret = ath11k_wmi_send_stats_request_cmd(ar, req_param);
+	if (ret) {
+		ath11k_warn(ab, "could not request fw stats (%d)\n",
+			    ret);
+		return ret;
+	}
+
+	time_left = wait_for_completion_timeout(&ar->fw_stats_complete,
+						1 * HZ);
+
+	if (!time_left)
+		return -ETIMEDOUT;
+
+	return 0;
+}
+
+static int ath11k_mac_op_get_txpower(struct ieee80211_hw *hw,
+				     struct ieee80211_vif *vif,
+				     int *dbm)
+{
+	struct ath11k *ar = hw->priv;
+	struct ath11k_base *ab = ar->ab;
+	struct stats_request_params req_param = {0};
+	struct ath11k_fw_stats_pdev *pdev;
+	int ret;
+
+	/* Final Tx power is minimum of Target Power, CTL power, Regulatory
+	 * Power, PSD EIRP Power. We just know the Regulatory power from the
+	 * regulatory rules obtained. FW knows all these power and sets the min
+	 * of these. Hence, we request the FW pdev stats in which FW reports
+	 * the minimum of all vdev's channel Tx power.
+	 */
+	mutex_lock(&ar->conf_mutex);
+
+	if (ar->state != ATH11K_STATE_ON)
+		goto err_fallback;
+
+	req_param.pdev_id = ar->pdev->pdev_id;
+	req_param.stats_id = WMI_REQUEST_PDEV_STAT;
+
+	ret = ath11k_fw_stats_request(ar, &req_param);
+	if (ret) {
+		ath11k_warn(ab, "failed to request fw pdev stats: %d\n", ret);
+		goto err_fallback;
+	}
+
+	spin_lock_bh(&ar->data_lock);
+	pdev = list_first_entry_or_null(&ar->fw_stats.pdevs,
+					struct ath11k_fw_stats_pdev, list);
+	if (!pdev) {
+		spin_unlock_bh(&ar->data_lock);
+		goto err_fallback;
+	}
+
+	/* tx power is set as 2 units per dBm in FW. */
+	*dbm = pdev->chan_tx_power / 2;
+
+	spin_unlock_bh(&ar->data_lock);
+	mutex_unlock(&ar->conf_mutex);
+
+	ath11k_dbg(ar->ab, ATH11K_DBG_MAC, "txpower from firmware %d, reported %d dBm\n",
+		   pdev->chan_tx_power, *dbm);
+	return 0;
+
+err_fallback:
+	mutex_unlock(&ar->conf_mutex);
+	/* We didn't get txpower from FW. Hence, relying on vif->bss_conf.txpower */
+	*dbm = vif->bss_conf.txpower;
+	ath11k_dbg(ar->ab, ATH11K_DBG_MAC, "txpower from firmware NaN, reported %d dBm\n",
+		   *dbm);
+	return 0;
+}
+
 static const struct ieee80211_ops ath11k_ops = {
 	.tx				= ath11k_mac_op_tx,
 	.start                          = ath11k_mac_op_start,
@@ -8521,6 +8610,7 @@ static const struct ieee80211_ops ath11k_ops = {
 #if IS_ENABLED(CONFIG_IPV6)
 	.ipv6_addr_change = ath11k_mac_op_ipv6_changed,
 #endif
+	.get_txpower                    = ath11k_mac_op_get_txpower,
 
 	.set_sar_specs			= ath11k_mac_op_set_bios_sar_specs,
 	.remain_on_channel		= ath11k_mac_op_remain_on_channel,
@@ -9129,6 +9219,8 @@ int ath11k_mac_allocate(struct ath11k_base *ab)
 		clear_bit(ATH11K_FLAG_MONITOR_VDEV_CREATED, &ar->monitor_flags);
 		ar->vdev_id_11d_scan = ATH11K_11D_INVALID_VDEV_ID;
 		init_completion(&ar->completed_11d_scan);
+
+		ath11k_fw_stats_init(ar);
 	}
 
 	return 0;
-- 
2.17.1

