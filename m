Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 612732146DA
	for <lists+linux-wireless@lfdr.de>; Sat,  4 Jul 2020 17:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbgGDPOc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 4 Jul 2020 11:14:32 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:29843 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726639AbgGDPOb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 4 Jul 2020 11:14:31 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1593875669; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=oJ2jzm5iGHk/oc2OMS3YZaYRoD2Rs7gDw0GDbYZsvcs=; b=O9oMFndVkQiTHj63fTEsOcO0FFpZvxMm4Yrd+qB5cEbzdjS5+O/bNeMc9uipHZkyh0maDmoW
 neP/8AKlr20LXYDmdiFfSowxyVvtqgsQ2JUcA7O1lUGBPEnAcZDe2wKGkMXV/d2UuIN2UfnV
 DU/3XAuXm076etLlPFYyv8NvGHw=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 5f009ccb6f2ee827da4c1a4d (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 04 Jul 2020 15:14:19
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 007DBC433C8; Sat,  4 Jul 2020 15:14:18 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from tamizhr-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tamizhr)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 28CCBC433CA;
        Sat,  4 Jul 2020 15:14:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 28CCBC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=tamizhr@codeaurora.org
From:   Tamizh Chelvam <tamizhr@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Tamizh Chelvam <tamizhr@codeaurora.org>
Subject: [PATCHv2 4/4] ath10k: Add new api to support reset TID config
Date:   Sat,  4 Jul 2020 20:43:34 +0530
Message-Id: <1593875614-5683-5-git-send-email-tamizhr@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1593875614-5683-1-git-send-email-tamizhr@codeaurora.org>
References: <1593875614-5683-1-git-send-email-tamizhr@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add ops for reset_tid_config to support reset TID
configuration. This send default configuration to the
target for the TIDs and stores default value in the host.

Tested-on: QCA9984 hw1.0 PCI 10.4-3.9.0.2-00021

Signed-off-by: Tamizh Chelvam <tamizhr@codeaurora.org>
---
 drivers/net/wireless/ath/ath10k/core.h |  1 +
 drivers/net/wireless/ath/ath10k/mac.c  | 88 ++++++++++++++++++++++++++++++++++
 2 files changed, 89 insertions(+)

diff --git a/drivers/net/wireless/ath/ath10k/core.h b/drivers/net/wireless/ath/ath10k/core.h
index 939cf01..4cf5bd4 100644
--- a/drivers/net/wireless/ath/ath10k/core.h
+++ b/drivers/net/wireless/ath/ath10k/core.h
@@ -633,6 +633,7 @@ struct ath10k_vif {
 	u8 rate_ctrl[ATH10K_TID_MAX];
 	u32 rate_code[ATH10K_TID_MAX];
 	int rtscts[ATH10K_TID_MAX];
+	u32 tids_rst;
 };
 
 struct ath10k_vif_iter {
diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
index 991f274..594e7af 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -6689,6 +6689,7 @@ static int ath10k_sta_set_txpwr(struct ieee80211_hw *hw,
 struct ath10k_mac_iter_tid_conf_data {
 	struct ieee80211_vif *curr_vif;
 	struct ath10k *ar;
+	bool reset_config;
 };
 
 static bool
@@ -7071,6 +7072,54 @@ static int ath10k_mac_set_tid_config(struct ath10k *ar, struct ieee80211_sta *st
 	return ret;
 }
 
+static int ath10k_mac_reset_tid_config(struct ath10k *ar,
+				       struct ieee80211_sta *sta,
+				       struct ath10k_vif *arvif,
+				       u8 tids)
+{
+	struct ath10k_sta *arsta = (struct ath10k_sta *)sta->drv_priv;
+	struct wmi_per_peer_per_tid_cfg_arg arg;
+	int ret = 0, i = 0;
+
+	arg.vdev_id = arvif->vdev_id;
+	while (i < ATH10K_TID_MAX) {
+		if (!(tids & BIT(i))) {
+			i++;
+			continue;
+		}
+
+		arg.tid = i;
+		arg.ack_policy = WMI_PEER_TID_CONFIG_ACK;
+		arg.retry_count = ATH10K_MAX_RETRY_COUNT;
+		arg.rate_ctrl = WMI_TID_CONFIG_RATE_CONTROL_AUTO;
+		arg.aggr_control = WMI_TID_CONFIG_AGGR_CONTROL_ENABLE;
+		arg.rtscts_ctrl = WMI_TID_CONFIG_RTSCTS_CONTROL_ENABLE;
+		arg.ext_tid_cfg_bitmap = WMI_EXT_TID_RTS_CTS_CONFIG;
+		ether_addr_copy(arg.peer_macaddr.addr, sta->addr);
+		ret = ath10k_wmi_set_per_peer_per_tid_cfg(ar, &arg);
+		if (ret)
+			return ret;
+
+		if (!arvif->tids_rst) {
+			arsta->retry_long[i] = -1;
+			arsta->noack[i] = -1;
+			arsta->ampdu[i] = -1;
+			arsta->rate_code[i] = -1;
+			arsta->rate_ctrl[i] = 0;
+			arsta->rtscts[i] = -1;
+		} else {
+			arvif->retry_long[i] = 0;
+			arvif->noack[i] = 0;
+			arvif->ampdu[i] = 0;
+			arvif->rate_code[i] = 0;
+			arvif->rate_ctrl[i] = 0;
+			arvif->rtscts[i] = 0;
+		}
+		i++;
+	}
+	return ret;
+}
+
 static void ath10k_sta_tid_cfg_wk(struct work_struct *wk)
 {
 	struct wmi_per_peer_per_tid_cfg_arg arg = {};
@@ -7089,6 +7138,12 @@ static void ath10k_sta_tid_cfg_wk(struct work_struct *wk)
 
 	mutex_lock(&ar->conf_mutex);
 
+	if (arvif->tids_rst) {
+		ret = ath10k_mac_reset_tid_config(ar, sta, arvif,
+						  arvif->tids_rst);
+		goto exit;
+	}
+
 	ether_addr_copy(arg.peer_macaddr.addr, sta->addr);
 	for (i = 0; i < ATH10K_TID_MAX; i++) {
 		config_apply = false;
@@ -7177,6 +7232,7 @@ static void ath10k_sta_tid_cfg_wk(struct work_struct *wk)
 		arg.rcode_flags = 0;
 	}
 
+exit:
 	mutex_unlock(&ar->conf_mutex);
 }
 
@@ -9078,6 +9134,7 @@ static int ath10k_mac_op_set_tid_config(struct ieee80211_hw *hw,
 	mutex_lock(&ar->conf_mutex);
 	arg.vdev_id = arvif->vdev_id;
 
+	arvif->tids_rst = 0;
 	memset(arvif->tid_conf_changed, 0, sizeof(arvif->tid_conf_changed));
 
 	for (i = 0; i < tid_config->n_tid_conf; i++) {
@@ -9092,6 +9149,7 @@ static int ath10k_mac_op_set_tid_config(struct ieee80211_hw *hw,
 		goto exit;
 
 	ret = 0;
+	arvif->tids_rst = 0;
 	data.curr_vif = vif;
 	data.ar = ar;
 
@@ -9103,6 +9161,35 @@ static int ath10k_mac_op_set_tid_config(struct ieee80211_hw *hw,
 	return ret;
 }
 
+static int ath10k_mac_op_reset_tid_config(struct ieee80211_hw *hw,
+					  struct ieee80211_vif *vif,
+					  struct ieee80211_sta *sta,
+					  u8 tids)
+{
+	struct ath10k_vif *arvif = (void *)vif->drv_priv;
+	struct ath10k_mac_iter_tid_conf_data data = {};
+	struct ath10k *ar = hw->priv;
+	int ret = 0;
+
+	mutex_lock(&ar->conf_mutex);
+
+	if (sta) {
+		arvif->tids_rst = 0;
+		ret = ath10k_mac_reset_tid_config(ar, sta, arvif, tids);
+		goto exit;
+	}
+
+	arvif->tids_rst = tids;
+	data.curr_vif = vif;
+	data.ar = ar;
+	ieee80211_iterate_stations_atomic(hw, ath10k_mac_vif_stations_tid_conf,
+					  &data);
+
+exit:
+	mutex_unlock(&ar->conf_mutex);
+	return ret;
+}
+
 static const struct ieee80211_ops ath10k_ops = {
 	.tx				= ath10k_mac_op_tx,
 	.wake_tx_queue			= ath10k_mac_op_wake_tx_queue,
@@ -9147,6 +9234,7 @@ static int ath10k_mac_op_set_tid_config(struct ieee80211_hw *hw,
 	.sta_pre_rcu_remove		= ath10k_mac_op_sta_pre_rcu_remove,
 	.sta_statistics			= ath10k_sta_statistics,
 	.set_tid_config			= ath10k_mac_op_set_tid_config,
+	.reset_tid_config		= ath10k_mac_op_reset_tid_config,
 
 	CFG80211_TESTMODE_CMD(ath10k_tm_cmd)
 
-- 
1.9.1

