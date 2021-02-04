Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07F2A30FC5E
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Feb 2021 20:18:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239687AbhBDTOw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 4 Feb 2021 14:14:52 -0500
Received: from so15.mailgun.net ([198.61.254.15]:16623 "EHLO so15.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239223AbhBDSgu (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 4 Feb 2021 13:36:50 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1612463784; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=YRhfio3s07foWgnVnJHEW8KVHkShavHHIildMeIV4Kg=; b=eGSvqv8/wZUFs75+sHm29l6HkezbQ5TKFVyg2ZO2mQ55v7vdWhUnpW1iGTbziAnPll76yQ/i
 g2GIAnSKOXJVQW0UIflw2LH0eUEJW8yIS0a2mIYX2N5Tv46CqRQIXX/ibGWr2l4RhOje2Y4R
 qtXMRi4HLRXUzBk6bX9axLVfOZY=
X-Mailgun-Sending-Ip: 198.61.254.15
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 601c3e8781f6c45dce22593c (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 04 Feb 2021 18:35:51
 GMT
Sender: tamizhr=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 539FEC43461; Thu,  4 Feb 2021 18:35:50 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from tamizhr-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tamizhr)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 03995C433C6;
        Thu,  4 Feb 2021 18:35:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 03995C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=tamizhr@codeaurora.org
From:   Tamizh chelvam <tamizhr@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Tamizh Chelvam <tamizhr@codeaurora.org>
Subject: [PATCH] ath10k: Add new debug_mask for sta related logs
Date:   Fri,  5 Feb 2021 00:05:38 +0530
Message-Id: <1612463738-16542-1-git-send-email-tamizhr@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Tamizh Chelvam <tamizhr@codeaurora.org>

Add new enum ATH10K_DBG_STA debug_mask for printing
sta related logs. This will be useful to check the
debug logs of connection and changes related to
station.

Tested-on: QCA9984 hw1.0 PCI 10.4-3.9.0.2-00021

Signed-off-by: Tamizh Chelvam <tamizhr@codeaurora.org>
---
 drivers/net/wireless/ath/ath10k/debug.h |  1 +
 drivers/net/wireless/ath/ath10k/mac.c   | 20 ++++++++++----------
 drivers/net/wireless/ath/ath10k/wmi.c   |  4 ++--
 3 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/debug.h b/drivers/net/wireless/ath/ath10k/debug.h
index 997c1c8..0af787f 100644
--- a/drivers/net/wireless/ath/ath10k/debug.h
+++ b/drivers/net/wireless/ath/ath10k/debug.h
@@ -34,6 +34,7 @@ enum ath10k_debug_mask {
 	ATH10K_DBG_USB_BULK	= 0x00080000,
 	ATH10K_DBG_SNOC		= 0x00100000,
 	ATH10K_DBG_QMI		= 0x00200000,
+	ATH10K_DBG_STA		= 0x00400000,
 	ATH10K_DBG_ANY		= 0xffffffff,
 };
 
diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
index d403c9f..b6836ef 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -6667,7 +6667,7 @@ static void ath10k_sta_rc_update_wk(struct work_struct *wk)
 		enum wmi_phy_mode mode;
 
 		mode = chan_to_phymode(&def);
-		ath10k_dbg(ar, ATH10K_DBG_MAC, "mac update sta %pM peer bw %d phymode %d\n",
+		ath10k_dbg(ar, ATH10K_DBG_STA, "mac update sta %pM peer bw %d phymode %d\n",
 			   sta->addr, bw, mode);
 
 		err = ath10k_wmi_peer_set_param(ar, arvif->vdev_id, sta->addr,
@@ -6686,7 +6686,7 @@ static void ath10k_sta_rc_update_wk(struct work_struct *wk)
 	}
 
 	if (changed & IEEE80211_RC_NSS_CHANGED) {
-		ath10k_dbg(ar, ATH10K_DBG_MAC, "mac update sta %pM nss %d\n",
+		ath10k_dbg(ar, ATH10K_DBG_STA, "mac update sta %pM nss %d\n",
 			   sta->addr, nss);
 
 		err = ath10k_wmi_peer_set_param(ar, arvif->vdev_id, sta->addr,
@@ -6697,7 +6697,7 @@ static void ath10k_sta_rc_update_wk(struct work_struct *wk)
 	}
 
 	if (changed & IEEE80211_RC_SMPS_CHANGED) {
-		ath10k_dbg(ar, ATH10K_DBG_MAC, "mac update sta %pM smps %d\n",
+		ath10k_dbg(ar, ATH10K_DBG_STA, "mac update sta %pM smps %d\n",
 			   sta->addr, smps);
 
 		err = ath10k_wmi_peer_set_param(ar, arvif->vdev_id, sta->addr,
@@ -6708,7 +6708,7 @@ static void ath10k_sta_rc_update_wk(struct work_struct *wk)
 	}
 
 	if (changed & IEEE80211_RC_SUPP_RATES_CHANGED) {
-		ath10k_dbg(ar, ATH10K_DBG_MAC, "mac update sta %pM supp rates\n",
+		ath10k_dbg(ar, ATH10K_DBG_STA, "mac update sta %pM supp rates\n",
 			   sta->addr);
 
 		err = ath10k_station_assoc(ar, arvif->vif, sta, true);
@@ -7404,7 +7404,7 @@ static int ath10k_sta_state(struct ieee80211_hw *hw,
 		enum wmi_peer_type peer_type = WMI_PEER_TYPE_DEFAULT;
 		u32 num_tdls_stations;
 
-		ath10k_dbg(ar, ATH10K_DBG_MAC,
+		ath10k_dbg(ar, ATH10K_DBG_STA,
 			   "mac vdev %d peer create %pM (new sta) sta %d / %d peer %d / %d\n",
 			   arvif->vdev_id, sta->addr,
 			   ar->num_stations + 1, ar->max_num_stations,
@@ -7504,7 +7504,7 @@ static int ath10k_sta_state(struct ieee80211_hw *hw,
 		/*
 		 * Existing station deletion.
 		 */
-		ath10k_dbg(ar, ATH10K_DBG_MAC,
+		ath10k_dbg(ar, ATH10K_DBG_STA,
 			   "mac vdev %d peer delete %pM sta %pK (sta gone)\n",
 			   arvif->vdev_id, sta->addr, sta);
 
@@ -7576,7 +7576,7 @@ static int ath10k_sta_state(struct ieee80211_hw *hw,
 		/*
 		 * New association.
 		 */
-		ath10k_dbg(ar, ATH10K_DBG_MAC, "mac sta %pM associated\n",
+		ath10k_dbg(ar, ATH10K_DBG_STA, "mac sta %pM associated\n",
 			   sta->addr);
 
 		ret = ath10k_station_assoc(ar, vif, sta, false);
@@ -7589,7 +7589,7 @@ static int ath10k_sta_state(struct ieee80211_hw *hw,
 		/*
 		 * Tdls station authorized.
 		 */
-		ath10k_dbg(ar, ATH10K_DBG_MAC, "mac tdls sta %pM authorized\n",
+		ath10k_dbg(ar, ATH10K_DBG_STA, "mac tdls sta %pM authorized\n",
 			   sta->addr);
 
 		ret = ath10k_station_assoc(ar, vif, sta, false);
@@ -7612,7 +7612,7 @@ static int ath10k_sta_state(struct ieee80211_hw *hw,
 		/*
 		 * Disassociation.
 		 */
-		ath10k_dbg(ar, ATH10K_DBG_MAC, "mac sta %pM disassociated\n",
+		ath10k_dbg(ar, ATH10K_DBG_STA, "mac sta %pM disassociated\n",
 			   sta->addr);
 
 		ret = ath10k_station_disassoc(ar, vif, sta);
@@ -8429,7 +8429,7 @@ static void ath10k_sta_rc_update(struct ieee80211_hw *hw,
 		return;
 	}
 
-	ath10k_dbg(ar, ATH10K_DBG_MAC,
+	ath10k_dbg(ar, ATH10K_DBG_STA,
 		   "mac sta rc update for %pM changed %08x bw %d nss %d smps %d\n",
 		   sta->addr, changed, sta->bandwidth, sta->rx_nss,
 		   sta->smps_mode);
diff --git a/drivers/net/wireless/ath/ath10k/wmi.c b/drivers/net/wireless/ath/ath10k/wmi.c
index 29f6431..d48b922 100644
--- a/drivers/net/wireless/ath/ath10k/wmi.c
+++ b/drivers/net/wireless/ath/ath10k/wmi.c
@@ -3497,7 +3497,7 @@ void ath10k_wmi_event_peer_sta_kickout(struct ath10k *ar, struct sk_buff *skb)
 		return;
 	}
 
-	ath10k_dbg(ar, ATH10K_DBG_WMI, "wmi event peer sta kickout %pM\n",
+	ath10k_dbg(ar, ATH10K_DBG_STA, "wmi event peer sta kickout %pM\n",
 		   arg.mac_addr);
 
 	rcu_read_lock();
@@ -7506,7 +7506,7 @@ ath10k_wmi_op_gen_set_sta_ps(struct ath10k *ar, u32 vdev_id,
 	cmd->param_id    = __cpu_to_le32(param_id);
 	cmd->param_value = __cpu_to_le32(value);
 
-	ath10k_dbg(ar, ATH10K_DBG_WMI,
+	ath10k_dbg(ar, ATH10K_DBG_STA,
 		   "wmi sta ps param vdev_id 0x%x param %d value %d\n",
 		   vdev_id, param_id, value);
 	return skb;
-- 
2.7.4

