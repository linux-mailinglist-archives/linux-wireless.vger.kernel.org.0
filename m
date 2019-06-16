Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6C99473AB
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Jun 2019 09:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726256AbfFPHeW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 16 Jun 2019 03:34:22 -0400
Received: from alexa-out-ams-02.qualcomm.com ([185.23.61.163]:36718 "EHLO
        alexa-out-ams-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726390AbfFPHeV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 16 Jun 2019 03:34:21 -0400
Received: from ironmsg02-ams.qualcomm.com ([10.251.56.3])
  by alexa-out-ams-02.qualcomm.com with ESMTP; 16 Jun 2019 09:26:16 +0200
X-IronPort-AV: E=McAfee;i="6000,8403,9289"; a="8499840"
Received: from lx-merez1.mea.qualcomm.com ([10.18.173.103])
  by ironmsg02-ams.qualcomm.com with ESMTP; 16 Jun 2019 09:26:15 +0200
From:   Maya Erez <merez@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Ahmad Masri <amasri@codeaurora.org>,
        linux-wireless@vger.kernel.org, wil6210@qti.qualcomm.com,
        Maya Erez <merez@codeaurora.org>
Subject: [PATCH 10/11] wil6210: set WIL_WMI_CALL_GENERAL_TO_MS as wmi_call timeout
Date:   Sun, 16 Jun 2019 10:26:06 +0300
Message-Id: <1560669967-23706-11-git-send-email-merez@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1560669967-23706-1-git-send-email-merez@codeaurora.org>
References: <1560669967-23706-1-git-send-email-merez@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ahmad Masri <amasri@codeaurora.org>

Replace all wmi_call timeouts that are less than 100 msec to use
WIL_WMI_CALL_GENERAL_TO_MS (100 msec) as a default. Some of the
current wmi_call timeouts are too short and fails to receive its
waiting events.

Signed-off-by: Ahmad Masri <amasri@codeaurora.org>
Signed-off-by: Maya Erez <merez@codeaurora.org>
---
 drivers/net/wireless/ath/wil6210/cfg80211.c |  3 ++-
 drivers/net/wireless/ath/wil6210/debugfs.c  |  2 +-
 drivers/net/wireless/ath/wil6210/txrx.c     |  9 +++++---
 drivers/net/wireless/ath/wil6210/wil6210.h  |  1 +
 drivers/net/wireless/ath/wil6210/wmi.c      | 32 +++++++++++++++++------------
 5 files changed, 29 insertions(+), 18 deletions(-)

diff --git a/drivers/net/wireless/ath/wil6210/cfg80211.c b/drivers/net/wireless/ath/wil6210/cfg80211.c
index cd41a0b..52ae3d9 100644
--- a/drivers/net/wireless/ath/wil6210/cfg80211.c
+++ b/drivers/net/wireless/ath/wil6210/cfg80211.c
@@ -314,7 +314,8 @@ int wil_cid_fill_sinfo(struct wil6210_vif *vif, int cid,
 	memset(&reply, 0, sizeof(reply));
 
 	rc = wmi_call(wil, WMI_NOTIFY_REQ_CMDID, vif->mid, &cmd, sizeof(cmd),
-		      WMI_NOTIFY_REQ_DONE_EVENTID, &reply, sizeof(reply), 20);
+		      WMI_NOTIFY_REQ_DONE_EVENTID, &reply, sizeof(reply),
+		      WIL_WMI_CALL_GENERAL_TO_MS);
 	if (rc)
 		return rc;
 
diff --git a/drivers/net/wireless/ath/wil6210/debugfs.c b/drivers/net/wireless/ath/wil6210/debugfs.c
index bbe274c..4d0c867 100644
--- a/drivers/net/wireless/ath/wil6210/debugfs.c
+++ b/drivers/net/wireless/ath/wil6210/debugfs.c
@@ -1334,7 +1334,7 @@ static int bf_show(struct seq_file *s, void *data)
 		rc = wmi_call(wil, WMI_NOTIFY_REQ_CMDID, vif->mid,
 			      &cmd, sizeof(cmd),
 			      WMI_NOTIFY_REQ_DONE_EVENTID, &reply,
-			      sizeof(reply), 20);
+			      sizeof(reply), WIL_WMI_CALL_GENERAL_TO_MS);
 		/* if reply is all-0, ignore this CID */
 		if (rc || is_all_zeros(&reply.evt, sizeof(reply.evt)))
 			continue;
diff --git a/drivers/net/wireless/ath/wil6210/txrx.c b/drivers/net/wireless/ath/wil6210/txrx.c
index 8790e5e..eae00aa 100644
--- a/drivers/net/wireless/ath/wil6210/txrx.c
+++ b/drivers/net/wireless/ath/wil6210/txrx.c
@@ -1037,7 +1037,8 @@ static int wil_vring_init_tx(struct wil6210_vif *vif, int id, int size,
 	if (!vif->privacy)
 		txdata->dot1x_open = true;
 	rc = wmi_call(wil, WMI_VRING_CFG_CMDID, vif->mid, &cmd, sizeof(cmd),
-		      WMI_VRING_CFG_DONE_EVENTID, &reply, sizeof(reply), 100);
+		      WMI_VRING_CFG_DONE_EVENTID, &reply, sizeof(reply),
+		      WIL_WMI_CALL_GENERAL_TO_MS);
 	if (rc)
 		goto out_free;
 
@@ -1125,7 +1126,8 @@ static int wil_tx_vring_modify(struct wil6210_vif *vif, int ring_id, int cid,
 	cmd.vring_cfg.tx_sw_ring.ring_mem_base = cpu_to_le64(vring->pa);
 
 	rc = wmi_call(wil, WMI_VRING_CFG_CMDID, vif->mid, &cmd, sizeof(cmd),
-		      WMI_VRING_CFG_DONE_EVENTID, &reply, sizeof(reply), 100);
+		      WMI_VRING_CFG_DONE_EVENTID, &reply, sizeof(reply),
+		      WIL_WMI_CALL_GENERAL_TO_MS);
 	if (rc)
 		goto fail;
 
@@ -1205,7 +1207,8 @@ int wil_vring_init_bcast(struct wil6210_vif *vif, int id, int size)
 		txdata->dot1x_open = true;
 	rc = wmi_call(wil, WMI_BCAST_VRING_CFG_CMDID, vif->mid,
 		      &cmd, sizeof(cmd),
-		      WMI_VRING_CFG_DONE_EVENTID, &reply, sizeof(reply), 100);
+		      WMI_VRING_CFG_DONE_EVENTID, &reply, sizeof(reply),
+		      WIL_WMI_CALL_GENERAL_TO_MS);
 	if (rc)
 		goto out_free;
 
diff --git a/drivers/net/wireless/ath/wil6210/wil6210.h b/drivers/net/wireless/ath/wil6210/wil6210.h
index 038329b..6f456b3 100644
--- a/drivers/net/wireless/ath/wil6210/wil6210.h
+++ b/drivers/net/wireless/ath/wil6210/wil6210.h
@@ -99,6 +99,7 @@ static inline u32 WIL_GET_BITS(u32 x, int b0, int b1)
 #define WIL_MAX_AMPDU_SIZE_128	(128 * 1024) /* FW/HW limit */
 #define WIL_MAX_AGG_WSIZE_64	(64) /* FW/HW limit */
 #define WIL6210_MAX_STATUS_RINGS	(8)
+#define WIL_WMI_CALL_GENERAL_TO_MS 100
 
 /* Hardware offload block adds the following:
  * 26 bytes - 3-address QoS data header
diff --git a/drivers/net/wireless/ath/wil6210/wmi.c b/drivers/net/wireless/ath/wil6210/wmi.c
index 5d7eb52..542ef15 100644
--- a/drivers/net/wireless/ath/wil6210/wmi.c
+++ b/drivers/net/wireless/ath/wil6210/wmi.c
@@ -40,7 +40,6 @@
 		 " 60G device led enablement. Set the led ID (0-2) to enable");
 
 #define WIL_WAIT_FOR_SUSPEND_RESUME_COMP 200
-#define WIL_WMI_CALL_GENERAL_TO_MS 100
 #define WIL_WMI_PCP_STOP_TO_MS 5000
 
 /**
@@ -2059,7 +2058,8 @@ int wmi_echo(struct wil6210_priv *wil)
 	};
 
 	return wmi_call(wil, WMI_ECHO_CMDID, vif->mid, &cmd, sizeof(cmd),
-			WMI_ECHO_RSP_EVENTID, NULL, 0, 50);
+			WMI_ECHO_RSP_EVENTID, NULL, 0,
+			WIL_WMI_CALL_GENERAL_TO_MS);
 }
 
 int wmi_set_mac_address(struct wil6210_priv *wil, void *addr)
@@ -2118,7 +2118,7 @@ int wmi_led_cfg(struct wil6210_priv *wil, bool enable)
 
 	rc = wmi_call(wil, WMI_LED_CFG_CMDID, vif->mid, &cmd, sizeof(cmd),
 		      WMI_LED_CFG_DONE_EVENTID, &reply, sizeof(reply),
-		      100);
+		      WIL_WMI_CALL_GENERAL_TO_MS);
 	if (rc)
 		goto out;
 
@@ -2267,7 +2267,8 @@ int wmi_get_ssid(struct wil6210_vif *vif, u8 *ssid_len, void *ssid)
 	memset(&reply, 0, sizeof(reply));
 
 	rc = wmi_call(wil, WMI_GET_SSID_CMDID, vif->mid, NULL, 0,
-		      WMI_GET_SSID_EVENTID, &reply, sizeof(reply), 20);
+		      WMI_GET_SSID_EVENTID, &reply, sizeof(reply),
+		      WIL_WMI_CALL_GENERAL_TO_MS);
 	if (rc)
 		return rc;
 
@@ -2304,7 +2305,8 @@ int wmi_get_channel(struct wil6210_priv *wil, int *channel)
 	memset(&reply, 0, sizeof(reply));
 
 	rc = wmi_call(wil, WMI_GET_PCP_CHANNEL_CMDID, vif->mid, NULL, 0,
-		      WMI_GET_PCP_CHANNEL_EVENTID, &reply, sizeof(reply), 20);
+		      WMI_GET_PCP_CHANNEL_EVENTID, &reply, sizeof(reply),
+		      WIL_WMI_CALL_GENERAL_TO_MS);
 	if (rc)
 		return rc;
 
@@ -2400,7 +2402,8 @@ int wmi_stop_discovery(struct wil6210_vif *vif)
 	wil_dbg_wmi(wil, "sending WMI_DISCOVERY_STOP_CMDID\n");
 
 	rc = wmi_call(wil, WMI_DISCOVERY_STOP_CMDID, vif->mid, NULL, 0,
-		      WMI_DISCOVERY_STOPPED_EVENTID, NULL, 0, 100);
+		      WMI_DISCOVERY_STOPPED_EVENTID, NULL, 0,
+		      WIL_WMI_CALL_GENERAL_TO_MS);
 
 	if (rc)
 		wil_err(wil, "Failed to stop discovery\n");
@@ -2546,12 +2549,14 @@ int wmi_rxon(struct wil6210_priv *wil, bool on)
 	if (on) {
 		rc = wmi_call(wil, WMI_START_LISTEN_CMDID, vif->mid, NULL, 0,
 			      WMI_LISTEN_STARTED_EVENTID,
-			      &reply, sizeof(reply), 100);
+			      &reply, sizeof(reply),
+			      WIL_WMI_CALL_GENERAL_TO_MS);
 		if ((rc == 0) && (reply.evt.status != WMI_FW_STATUS_SUCCESS))
 			rc = -EINVAL;
 	} else {
 		rc = wmi_call(wil, WMI_DISCOVERY_STOP_CMDID, vif->mid, NULL, 0,
-			      WMI_DISCOVERY_STOPPED_EVENTID, NULL, 0, 20);
+			      WMI_DISCOVERY_STOPPED_EVENTID, NULL, 0,
+			      WIL_WMI_CALL_GENERAL_TO_MS);
 	}
 
 	return rc;
@@ -2640,7 +2645,8 @@ int wmi_get_temperature(struct wil6210_priv *wil, u32 *t_bb, u32 *t_rf)
 	memset(&reply, 0, sizeof(reply));
 
 	rc = wmi_call(wil, WMI_TEMP_SENSE_CMDID, vif->mid, &cmd, sizeof(cmd),
-		      WMI_TEMP_SENSE_DONE_EVENTID, &reply, sizeof(reply), 100);
+		      WMI_TEMP_SENSE_DONE_EVENTID, &reply, sizeof(reply),
+		      WIL_WMI_CALL_GENERAL_TO_MS);
 	if (rc)
 		return rc;
 
@@ -2822,7 +2828,7 @@ int wmi_addba_rx_resp(struct wil6210_priv *wil,
 
 	rc = wmi_call(wil, WMI_RCP_ADDBA_RESP_CMDID, mid, &cmd, sizeof(cmd),
 		      WMI_RCP_ADDBA_RESP_SENT_EVENTID, &reply, sizeof(reply),
-		      100);
+		      WIL_WMI_CALL_GENERAL_TO_MS);
 	if (rc)
 		return rc;
 
@@ -2904,7 +2910,7 @@ int wmi_ps_dev_profile_cfg(struct wil6210_priv *wil,
 	rc = wmi_call(wil, WMI_PS_DEV_PROFILE_CFG_CMDID, vif->mid,
 		      &cmd, sizeof(cmd),
 		      WMI_PS_DEV_PROFILE_CFG_EVENTID, &reply, sizeof(reply),
-		      100);
+		      WIL_WMI_CALL_GENERAL_TO_MS);
 	if (rc)
 		return rc;
 
@@ -2941,7 +2947,7 @@ int wmi_set_mgmt_retry(struct wil6210_priv *wil, u8 retry_short)
 	rc = wmi_call(wil, WMI_SET_MGMT_RETRY_LIMIT_CMDID, vif->mid,
 		      &cmd, sizeof(cmd),
 		      WMI_SET_MGMT_RETRY_LIMIT_EVENTID, &reply, sizeof(reply),
-		      100);
+		      WIL_WMI_CALL_GENERAL_TO_MS);
 	if (rc)
 		return rc;
 
@@ -2971,7 +2977,7 @@ int wmi_get_mgmt_retry(struct wil6210_priv *wil, u8 *retry_short)
 	memset(&reply, 0, sizeof(reply));
 	rc = wmi_call(wil, WMI_GET_MGMT_RETRY_LIMIT_CMDID, vif->mid, NULL, 0,
 		      WMI_GET_MGMT_RETRY_LIMIT_EVENTID, &reply, sizeof(reply),
-		      100);
+		      WIL_WMI_CALL_GENERAL_TO_MS);
 	if (rc)
 		return rc;
 
-- 
1.9.1

