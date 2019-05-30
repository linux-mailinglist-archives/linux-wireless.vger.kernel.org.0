Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD042F9D4
	for <lists+linux-wireless@lfdr.de>; Thu, 30 May 2019 11:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727471AbfE3Jr1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 May 2019 05:47:27 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:43318 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727171AbfE3Jr1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 May 2019 05:47:27 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 2F1196122D; Thu, 30 May 2019 09:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1559209646;
        bh=ZIFNe1Vm8PNCgpBZ186FQ8xv/J8gFD9jafYqAPeOhac=;
        h=From:To:Cc:Subject:Date:From;
        b=ZdQjAtx+SPU35O03T3zI6KdISEwO7MpfZdeBEKqVXYNsoxNtz+9aKUCxOBb0UTsn+
         +JYM3EqqU5ywiKFp3kYayIG+IuwSGrNECUom942/9YMkRx6xthpYWBW7cCy6+lA4Sm
         qEv4qb2n/kZexxYgFJ94Ot0Vq7hHxUkl6lZD80s8=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from checstex0244823-lin.qca.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: bpothuno@codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6289760F3E;
        Thu, 30 May 2019 09:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1559209644;
        bh=ZIFNe1Vm8PNCgpBZ186FQ8xv/J8gFD9jafYqAPeOhac=;
        h=From:To:Cc:Subject:Date:From;
        b=oBco/EeSI4+ucNl24bTOTDTlvVSyLVXiaPZkApiiU1BJTNb2obPEFgBoyfzgdERvX
         OCXFQ/Plb2vmZyMFPNlBJKec0RvRKfYHnZaBY2rsKntWyQEerMMvzfaCYraok4uzsM
         u+GjA0FoipFKs/lkr+mKIUEqfOTlGc6xqAMXFXWE=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6289760F3E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=bpothuno@codeaurora.org
From:   Balaji Pothunoori <bpothuno@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Ashok Raj Nagarajan <arnagara@codeaurora.org>,
        Balaji Pothunoori <bpothuno@codeaurora.org>
Subject: [PATCH v5] ath10k: add support for controlling tx power to a station
Date:   Thu, 30 May 2019 15:17:18 +0530
Message-Id: <1559209638-23887-1-git-send-email-bpothuno@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ashok Raj Nagarajan <arnagara@codeaurora.org>

This patch will add the support to control the transmit power for traffic
to a station associated with the AP.

Underlying firmware will enforce that the maximum tx power will be based
on the regulatory requirements. If the user given transmit power is greater
than the allowed tx power in the given channel, then the firmware will use
the maximum tx power in the same channel.

Max and Min tx power values will depends on no of tx chain masks,
for QCA9984 allowed tx power range values from 6 to 23.

When 0 is sent to the firmware as tx power, it will revert to the default
tx power for the station.

Tested Hardware : QCA9984
Tested Firmware : 10.4-3.9.0.2-00046

Co-developed-by: Balaji Pothunoori <bpothuno@codeaurora.org>
Signed-off-by: Ashok Raj Nagarajan <arnagara@codeaurora.org>
Signed-off-by: Balaji Pothunoori <bpothuno@codeaurora.org>
---
v2: removed mBm to dBm conversion
v3: rebased wmi.h changes
v4: no changes, rebased 
v5: updated firmware details which 
    addresses Bob comments.
    updated commit log.

Note: mac80211/cfg80211 patches got merged hence sending
      ath10k alone with v5 and mentioned 10.4-3.9.0.2-00046
      firmware is yet to be upstream.

patchwork links :
 	https://patchwork.kernel.org/patch/10876859/
	https://patchwork.kernel.org/patch/10876853/

 drivers/net/wireless/ath/ath10k/debug.h |  3 +++
 drivers/net/wireless/ath/ath10k/mac.c   | 39 +++++++++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath10k/wmi.h   |  6 +++++
 3 files changed, 48 insertions(+)

diff --git a/drivers/net/wireless/ath/ath10k/debug.h b/drivers/net/wireless/ath/ath10k/debug.h
index db78e85..2e43d8d 100644
--- a/drivers/net/wireless/ath/ath10k/debug.h
+++ b/drivers/net/wireless/ath/ath10k/debug.h
@@ -71,6 +71,9 @@ struct ath10k_pktlog_hdr {
 /* FIXME: How to calculate the buffer size sanely? */
 #define ATH10K_FW_STATS_BUF_SIZE (1024 * 1024)
 
+#define ATH10K_TX_POWER_MAX_VAL 70
+#define ATH10K_TX_POWER_MIN_VAL 0
+
 extern unsigned int ath10k_debug_mask;
 
 __printf(2, 3) void ath10k_info(struct ath10k *ar, const char *fmt, ...);
diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
index b500fd4..7e3e403 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -6358,6 +6358,41 @@ static void ath10k_mac_dec_num_stations(struct ath10k_vif *arvif,
 	ar->num_stations--;
 }
 
+static int ath10k_sta_set_txpwr(struct ieee80211_hw *hw,
+				struct ieee80211_vif *vif,
+				struct ieee80211_sta *sta)
+{
+	struct ath10k *ar = hw->priv;
+	struct ath10k_vif *arvif = (void *)vif->drv_priv;
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
+	if (txpwr > ATH10K_TX_POWER_MAX_VAL || txpwr < ATH10K_TX_POWER_MIN_VAL)
+		return -EINVAL;
+
+	mutex_lock(&ar->conf_mutex);
+
+	ret = ath10k_wmi_peer_set_param(ar, arvif->vdev_id, sta->addr,
+					WMI_PEER_USE_FIXED_PWR, txpwr);
+	if (ret) {
+		ath10k_warn(ar, "failed to set tx power for station ret: %d\n",
+			    ret);
+		goto out;
+	}
+
+out:
+	mutex_unlock(&ar->conf_mutex);
+	return ret;
+}
+
 static int ath10k_sta_state(struct ieee80211_hw *hw,
 			    struct ieee80211_vif *vif,
 			    struct ieee80211_sta *sta,
@@ -8015,6 +8050,7 @@ static const struct ieee80211_ops ath10k_ops = {
 	.set_key			= ath10k_set_key,
 	.set_default_unicast_key        = ath10k_set_default_unicast_key,
 	.sta_state			= ath10k_sta_state,
+	.sta_set_txpwr			= ath10k_sta_set_txpwr,
 	.conf_tx			= ath10k_conf_tx,
 	.remain_on_channel		= ath10k_remain_on_channel,
 	.cancel_remain_on_channel	= ath10k_cancel_remain_on_channel,
@@ -8703,6 +8739,9 @@ int ath10k_mac_register(struct ath10k *ar)
 		wiphy_ext_feature_set(ar->hw->wiphy,
 				      NL80211_EXT_FEATURE_ENABLE_FTM_RESPONDER);
 
+	if (test_bit(WMI_SERVICE_TX_PWR_PER_PEER, ar->wmi.svc_map))
+		wiphy_ext_feature_set(ar->hw->wiphy,
+				      NL80211_EXT_FEATURE_STA_TX_PWR);
 	/*
 	 * on LL hardware queues are managed entirely by the FW
 	 * so we only advertise to mac we can do the queues thing
diff --git a/drivers/net/wireless/ath/ath10k/wmi.h b/drivers/net/wireless/ath/ath10k/wmi.h
index 12f57f9..a0ed078 100644
--- a/drivers/net/wireless/ath/ath10k/wmi.h
+++ b/drivers/net/wireless/ath/ath10k/wmi.h
@@ -200,6 +200,7 @@ enum wmi_service {
 	WMI_SERVICE_RTT_RESPONDER_ROLE,
 	WMI_SERVICE_PER_PACKET_SW_ENCRYPT,
 	WMI_SERVICE_REPORT_AIRTIME,
+	WMI_SERVICE_TX_PWR_PER_PEER,
 
 	/* Remember to add the new value to wmi_service_name()! */
 
@@ -367,6 +368,7 @@ enum wmi_10_4_service {
 	WMI_10_4_SERVICE_RTT_RESPONDER_ROLE,
 	WMI_10_4_SERVICE_EXT_PEER_TID_CONFIGS_SUPPORT,
 	WMI_10_4_SERVICE_REPORT_AIRTIME,
+	WMI_10_4_SERVICE_TX_PWR_PER_PEER,
 };
 
 static inline char *wmi_service_name(enum wmi_service service_id)
@@ -491,6 +493,7 @@ static inline char *wmi_service_name(enum wmi_service service_id)
 	SVCSTR(WMI_SERVICE_RTT_RESPONDER_ROLE);
 	SVCSTR(WMI_SERVICE_PER_PACKET_SW_ENCRYPT);
 	SVCSTR(WMI_SERVICE_REPORT_AIRTIME);
+	SVCSTR(WMI_SERVICE_TX_PWR_PER_PEER);
 
 	case WMI_SERVICE_MAX:
 		return NULL;
@@ -818,6 +821,8 @@ static inline void wmi_10_4_svc_map(const __le32 *in, unsigned long *out,
 	       WMI_SERVICE_PER_PACKET_SW_ENCRYPT, len);
 	SVCMAP(WMI_10_4_SERVICE_REPORT_AIRTIME,
 	       WMI_SERVICE_REPORT_AIRTIME, len);
+	SVCMAP(WMI_10_4_SERVICE_TX_PWR_PER_PEER,
+	       WMI_SERVICE_TX_PWR_PER_PEER, len);
 }
 
 #undef SVCMAP
@@ -6262,6 +6267,7 @@ enum wmi_peer_param {
 	WMI_PEER_USE_4ADDR  = 0x6,
 	WMI_PEER_DEBUG      = 0xa,
 	WMI_PEER_PHYMODE    = 0xd,
+	WMI_PEER_USE_FIXED_PWR = 0x8,
 	WMI_PEER_DUMMY_VAR  = 0xff, /* dummy parameter for STA PS workaround */
 };
 
-- 
2.7.4

