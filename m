Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E71E11E6A2
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Dec 2019 16:35:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727908AbfLMPfN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Dec 2019 10:35:13 -0500
Received: from nbd.name ([46.4.11.11]:54636 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727862AbfLMPfM (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Dec 2019 10:35:12 -0500
Received: from pd95fd344.dip0.t-ipconnect.de ([217.95.211.68] helo=bertha.fritz.box)
        by ds12 with esmtpa (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1ifmyE-0005ee-8r; Fri, 13 Dec 2019 16:35:10 +0100
From:   John Crispin <john@phrozen.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>,
        John Crispin <john@phrozen.org>
Subject: [PATCH V2 2/2] ath11k: set the BA buffer size to 256 when HE is enabled
Date:   Fri, 13 Dec 2019 16:34:57 +0100
Message-Id: <20191213153457.11946-2-john@phrozen.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191213153457.11946-1-john@phrozen.org>
References: <20191213153457.11946-1-john@phrozen.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>

This patch sets the correct BA buffer size when we are in HE mode.
Without this change we are not able to receive 256 bitmapped BA frames.

Signed-off-by: John Crispin <john@phrozen.org>
Signed-off-by: Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/mac.c | 14 ++++++++++++++
 drivers/net/wireless/ath/ath11k/wmi.h |  2 ++
 2 files changed, 16 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index b229b0b3e0bd..82df8af57369 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -1758,6 +1758,20 @@ static void ath11k_mac_op_bss_info_changed(struct ieee80211_hw *hw,
 		if (ret)
 			ath11k_warn(ar->ab, "failed to update bcn template: %d\n",
 				    ret);
+
+		if (vif->bss_conf.he_support) {
+			ret = ath11k_wmi_vdev_set_param_cmd(ar, arvif->vdev_id,
+							    WMI_VDEV_PARAM_BA_MODE,
+							    WMI_BA_MODE_BUFFER_SIZE_256);
+			if (ret)
+				ath11k_warn(ar->ab,
+					    "failed to set BA BUFFER SIZE 256 for vdev: %d\n",
+					    arvif->vdev_id);
+			else
+				ath11k_dbg(ar->ab, ATH11K_DBG_MAC,
+					   "Set BA BUFFER SIZE 256 for VDEV: %d\n",
+					   arvif->vdev_id);
+		}
 	}
 
 	if (changed & (BSS_CHANGED_BEACON_INFO | BSS_CHANGED_BEACON)) {
diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
index f62f796305aa..284794dadd87 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -54,6 +54,7 @@ struct wmi_tlv {
 #define WLAN_SCAN_PARAMS_MAX_BSSID   4
 #define WLAN_SCAN_PARAMS_MAX_IE_LEN  256
 
+#define WMI_BA_MODE_BUFFER_SIZE_256  3
 /*
  * HW mode config type replicated from FW header
  * @WMI_HOST_HW_MODE_SINGLE: Only one PHY is active.
@@ -1004,6 +1005,7 @@ enum wmi_tlv_vdev_param {
 	WMI_VDEV_PARAM_HE_RANGE_EXT,
 	WMI_VDEV_PARAM_ENABLE_BCAST_PROBE_RESPONSE,
 	WMI_VDEV_PARAM_FILS_MAX_CHANNEL_GUARD_TIME,
+	WMI_VDEV_PARAM_BA_MODE = 0x7e,
 	WMI_VDEV_PARAM_SET_HE_SOUNDING_MODE = 0x87,
 	WMI_VDEV_PARAM_PROTOTYPE = 0x8000,
 	WMI_VDEV_PARAM_BSS_COLOR,
-- 
2.20.1

