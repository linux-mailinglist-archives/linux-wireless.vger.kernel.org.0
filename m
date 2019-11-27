Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC6BE10B0E2
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Nov 2019 15:08:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbfK0OI6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 Nov 2019 09:08:58 -0500
Received: from a27-185.smtp-out.us-west-2.amazonses.com ([54.240.27.185]:41632
        "EHLO a27-185.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726603AbfK0OI5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 Nov 2019 09:08:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1574863737;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        bh=cXdhKXZBus14skFVGOBJQUV52OckLP9J0eoWnT1d3dw=;
        b=B+gk/cCf+NmX2Dgo/PF2avEbur8BYALtU+5+vn6x4GBP8WwWVksN78W7BmlmEl8w
        OVjOlUuHjwNXl9WRQVKx4AD7oAv3BTNPc7mKiQC5zonCQoX1lfEKYQjliT0qkFS9MFI
        podso6JKJW+QogO+SxvHxILPVQx4shq6eicz70fk=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1574863737;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:Feedback-ID;
        bh=cXdhKXZBus14skFVGOBJQUV52OckLP9J0eoWnT1d3dw=;
        b=FQrJxAu/konrrpplbcmUYK/HHEOMOlIu7i6ljXQhhH/+EA1wLEzy5TQVRtQfL4yJ
        efqJxqWkqzJtTmaJ0MSjVUjZpKTgQhEPqIPVU3tHS39liepimdu4I7qpM6y/f71ZCb3
        62RCBe/RBLhLz64EChJHCjYcRMtt5j20dBqaI/O4=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3ED85C447B4
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     linux-wireless@vger.kernel.org
Cc:     ath11k@lists.infradead.org
Subject: [PATCH 08/10] ath11k: add support for controlling tx power to a station
Date:   Wed, 27 Nov 2019 14:08:57 +0000
Message-ID: <0101016ead3190bd-20f4b056-6124-49a6-85d7-3792da0f6ffe-000000@us-west-2.amazonses.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1574863720-25728-1-git-send-email-kvalo@codeaurora.org>
References: <1574863720-25728-1-git-send-email-kvalo@codeaurora.org>
X-SES-Outgoing: 2019.11.27-54.240.27.185
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Maharaja Kennadyrajan <mkenna@codeaurora.org>

This patch will add the support to control the transmit power
for traffic to a station associated with the AP.

Underlying firmware will enforce that the maximum tx power will
be based on the regulatory requirements. If the user given
transmit power is greater than the allowed tx power in the given
channel, then the firmware will use the maximum tx power in the
same channel.

Max and Min tx power values will depends on number of tx chain
masks. The allowed tx power range values are from 6 to 23.

When 0 is sent to the firmware as tx power, it will revert to
the default tx power for the station.

Signed-off-by: Maharaja Kennadyrajan <mkenna@codeaurora.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/debug.h |  3 +++
 drivers/net/wireless/ath/ath11k/mac.c   | 37 +++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/debug.h b/drivers/net/wireless/ath/ath11k/debug.h
index aef33f83c9b1..a317a7bdb9a2 100644
--- a/drivers/net/wireless/ath/ath11k/debug.h
+++ b/drivers/net/wireless/ath/ath11k/debug.h
@@ -9,6 +9,9 @@
 #include "hal_tx.h"
 #include "trace.h"
 
+#define ATH11K_TX_POWER_MAX_VAL	70
+#define ATH11K_TX_POWER_MIN_VAL	0
+
 enum ath11k_debug_mask {
 	ATH11K_DBG_AHB		= 0x00000001,
 	ATH11K_DBG_WMI		= 0x00000002,
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 412c258143ca..5231c4fa0e38 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -2842,6 +2842,41 @@ static int ath11k_mac_op_sta_state(struct ieee80211_hw *hw,
 	return ret;
 }
 
+static int ath11k_mac_op_sta_set_txpwr(struct ieee80211_hw *hw,
+				       struct ieee80211_vif *vif,
+				       struct ieee80211_sta *sta)
+{
+	struct ath11k *ar = hw->priv;
+	struct ath11k_vif *arvif = (void *)vif->drv_priv;
+	int ret = 0;
+	s16 txpwr;
+
+	if (sta->txpwr.type == NL80211_TX_POWER_AUTOMATIC) {
+		txpwr = 0;
+	} else {
+		txpwr = sta->txpwr.power;
+		if (!txpwr)
+			return -EINVAL;
+	}
+
+	if (txpwr > ATH11K_TX_POWER_MAX_VAL || txpwr < ATH11K_TX_POWER_MIN_VAL)
+		return -EINVAL;
+
+	mutex_lock(&ar->conf_mutex);
+
+	ret = ath11k_wmi_set_peer_param(ar, sta->addr, arvif->vdev_id,
+					WMI_PEER_USE_FIXED_PWR, txpwr);
+	if (ret) {
+		ath11k_warn(ar->ab, "failed to set tx power for station ret: %d\n",
+			    ret);
+		goto out;
+	}
+
+out:
+	mutex_unlock(&ar->conf_mutex);
+	return ret;
+}
+
 static void ath11k_mac_op_sta_rc_update(struct ieee80211_hw *hw,
 					struct ieee80211_vif *vif,
 					struct ieee80211_sta *sta,
@@ -5311,6 +5346,7 @@ static const struct ieee80211_ops ath11k_ops = {
 	.cancel_hw_scan                 = ath11k_mac_op_cancel_hw_scan,
 	.set_key                        = ath11k_mac_op_set_key,
 	.sta_state                      = ath11k_mac_op_sta_state,
+	.sta_set_txpwr			= ath11k_mac_op_sta_set_txpwr,
 	.sta_rc_update			= ath11k_mac_op_sta_rc_update,
 	.conf_tx                        = ath11k_mac_op_conf_tx,
 	.set_antenna			= ath11k_mac_op_set_antenna,
@@ -5571,6 +5607,7 @@ static int ath11k_mac_register(struct ath11k *ar)
 	ar->hw->wiphy->n_iface_combinations = ARRAY_SIZE(ath11k_if_comb);
 
 	wiphy_ext_feature_set(ar->hw->wiphy, NL80211_EXT_FEATURE_CQM_RSSI_LIST);
+	wiphy_ext_feature_set(ar->hw->wiphy, NL80211_EXT_FEATURE_STA_TX_PWR);
 
 	ar->hw->wiphy->cipher_suites = cipher_suites;
 	ar->hw->wiphy->n_cipher_suites = ARRAY_SIZE(cipher_suites);
-- 
2.7.4

