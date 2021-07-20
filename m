Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8ED03D03E8
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jul 2021 23:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232037AbhGTUvp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Jul 2021 16:51:45 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:51945 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233404AbhGTUvb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Jul 2021 16:51:31 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1626816727; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=0NKtP900YLYCGbw3/GGjWWripcJNlTdjFgNVgginJt0=; b=abeQRnEIETDnBog8B8jC5dz4L/CByAwwAd4rRXQWAhj3mrSD3aI8lXlncgB6UaxCJ7IxwD7n
 Jd43kUakxtbNRc2ljAhNOBgnVzUYc34DC9P8+cZCUyohmRMATXg9kMszaiWSrlwKfnFbNmhy
 bB2QJmD4AKn90qUvNto1Rmu6PRY=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 60f740d4290ea35ee6638a2d (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 20 Jul 2021 21:32:04
 GMT
Sender: jouni=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 72C9CC43460; Tue, 20 Jul 2021 21:32:03 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from jouni.codeaurora.org (85-76-67-217-nat.elisa-mobile.fi [85.76.67.217])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jouni)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 07C11C433F1;
        Tue, 20 Jul 2021 21:32:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 07C11C433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=jouni@codeaurora.org
From:   Jouni Malinen <jouni@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Sathishkumar Muruganandam <murugana@codeaurora.org>,
        Jouni Malinen <jouni@codeaurora.org>
Subject: [PATCH 1/2] ath11k: fix 4-addr tx failure for AP and STA modes
Date:   Wed, 21 Jul 2021 00:31:46 +0300
Message-Id: <20210720213147.90042-1-jouni@codeaurora.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sathishkumar Muruganandam <murugana@codeaurora.org>

Ath11k FW requires peer parameter WMI_PEER_USE_4ADDR to be set for
4-addr peers allowing 4-address frame transmission to those peers.

Add ath11k driver callback for sta_set_4addr() to queue new workq
set_4addr_wk only once based on new boolean, use_4addr_set.

sta_set_4addr() will be called during 4-addr STA association cases
applicable for both AP and STA modes.

In ath11k_sta_set_4addr_wk(),

AP mode:
        WMI_PEER_USE_4ADDR will be set for the corresponding
        associated 4-addr STA(s)

STA mode:
        WMI_PEER_USE_4ADDR will be set for the AP to which the
        4-addr STA got associated.

Tested-on: IPQ8074 WLAN.HK.2.1.0.1-01238-QCAHKSWPL_SILICONZ-1

Signed-off-by: Sathishkumar Muruganandam <murugana@codeaurora.org>
Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/core.h |  3 ++
 drivers/net/wireless/ath/ath11k/mac.c  | 48 ++++++++++++++++++++++++--
 2 files changed, 49 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index 018fb2385f2a..11c8dffd0236 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -362,6 +362,7 @@ struct ath11k_sta {
 	enum hal_pn_type pn_type;
 
 	struct work_struct update_wk;
+	struct work_struct set_4addr_wk;
 	struct rate_info txrate;
 	struct rate_info last_txrate;
 	u64 rx_duration;
@@ -374,6 +375,8 @@ struct ath11k_sta {
 	/* protected by conf_mutex */
 	bool aggr_mode;
 #endif
+
+	bool use_4addr_set;
 };
 
 #define ATH11K_MIN_5G_FREQ 4150
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index e9b3689331ec..d42637ecbf1e 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -3155,6 +3155,31 @@ static void ath11k_sta_rc_update_wk(struct work_struct *wk)
 	mutex_unlock(&ar->conf_mutex);
 }
 
+static void ath11k_sta_set_4addr_wk(struct work_struct *wk)
+{
+	struct ath11k *ar;
+	struct ath11k_vif *arvif;
+	struct ath11k_sta *arsta;
+	struct ieee80211_sta *sta;
+	int ret = 0;
+
+	arsta = container_of(wk, struct ath11k_sta, set_4addr_wk);
+	sta = container_of((void *)arsta, struct ieee80211_sta, drv_priv);
+	arvif = arsta->arvif;
+	ar = arvif->ar;
+
+	ath11k_dbg(ar->ab, ATH11K_DBG_MAC,
+		   "setting USE_4ADDR for peer %pM\n", sta->addr);
+
+	ret = ath11k_wmi_set_peer_param(ar, sta->addr,
+					arvif->vdev_id,
+					WMI_PEER_USE_4ADDR, 1);
+
+	if (ret)
+		ath11k_warn(ar->ab, "failed to set peer %pM 4addr capability: %d\n",
+			    sta->addr, ret);
+}
+
 static int ath11k_mac_inc_num_stations(struct ath11k_vif *arvif,
 				       struct ieee80211_sta *sta)
 {
@@ -3234,11 +3259,13 @@ static int ath11k_mac_station_add(struct ath11k *ar,
 	}
 
 	if (ieee80211_vif_is_mesh(vif)) {
+		ath11k_dbg(ab, ATH11K_DBG_MAC,
+			   "setting USE_4ADDR for mesh STA %pM\n", sta->addr);
 		ret = ath11k_wmi_set_peer_param(ar, sta->addr,
 						arvif->vdev_id,
 						WMI_PEER_USE_4ADDR, 1);
 		if (ret) {
-			ath11k_warn(ab, "failed to STA %pM 4addr capability: %d\n",
+			ath11k_warn(ab, "failed to set mesh STA %pM 4addr capability: %d\n",
 				    sta->addr, ret);
 			goto free_tx_stats;
 		}
@@ -3291,8 +3318,10 @@ static int ath11k_mac_op_sta_state(struct ieee80211_hw *hw,
 
 	/* cancel must be done outside the mutex to avoid deadlock */
 	if ((old_state == IEEE80211_STA_NONE &&
-	     new_state == IEEE80211_STA_NOTEXIST))
+	     new_state == IEEE80211_STA_NOTEXIST)) {
 		cancel_work_sync(&arsta->update_wk);
+		cancel_work_sync(&arsta->set_4addr_wk);
+	}
 
 	mutex_lock(&ar->conf_mutex);
 
@@ -3301,6 +3330,7 @@ static int ath11k_mac_op_sta_state(struct ieee80211_hw *hw,
 		memset(arsta, 0, sizeof(*arsta));
 		arsta->arvif = arvif;
 		INIT_WORK(&arsta->update_wk, ath11k_sta_rc_update_wk);
+		INIT_WORK(&arsta->set_4addr_wk, ath11k_sta_set_4addr_wk);
 
 		ret = ath11k_mac_station_add(ar, vif, sta);
 		if (ret)
@@ -3395,6 +3425,19 @@ static int ath11k_mac_op_sta_set_txpwr(struct ieee80211_hw *hw,
 	return ret;
 }
 
+static void ath11k_mac_op_sta_set_4addr(struct ieee80211_hw *hw,
+					struct ieee80211_vif *vif,
+					struct ieee80211_sta *sta, bool enabled)
+{
+	struct ath11k *ar = hw->priv;
+	struct ath11k_sta *arsta = (struct ath11k_sta *)sta->drv_priv;
+
+	if (enabled && !arsta->use_4addr_set) {
+		ieee80211_queue_work(ar->hw, &arsta->set_4addr_wk);
+		arsta->use_4addr_set = true;
+	}
+}
+
 static void ath11k_mac_op_sta_rc_update(struct ieee80211_hw *hw,
 					struct ieee80211_vif *vif,
 					struct ieee80211_sta *sta,
@@ -6180,6 +6223,7 @@ static const struct ieee80211_ops ath11k_ops = {
 	.cancel_hw_scan                 = ath11k_mac_op_cancel_hw_scan,
 	.set_key                        = ath11k_mac_op_set_key,
 	.sta_state                      = ath11k_mac_op_sta_state,
+	.sta_set_4addr                  = ath11k_mac_op_sta_set_4addr,
 	.sta_set_txpwr			= ath11k_mac_op_sta_set_txpwr,
 	.sta_rc_update			= ath11k_mac_op_sta_rc_update,
 	.conf_tx                        = ath11k_mac_op_conf_tx,
-- 
2.25.1

