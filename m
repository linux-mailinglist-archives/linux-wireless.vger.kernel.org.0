Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A81A3124911
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Dec 2019 15:06:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbfLROGI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Dec 2019 09:06:08 -0500
Received: from alexa-out-ams-02.qualcomm.com ([185.23.61.163]:54572 "EHLO
        alexa-out-ams-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727152AbfLROGH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Dec 2019 09:06:07 -0500
X-Greylist: delayed 365 seconds by postgrey-1.27 at vger.kernel.org; Wed, 18 Dec 2019 09:06:00 EST
Received: from ironmsg03-ams.qualcomm.com ([10.251.56.4])
  by alexa-out-ams-02.qualcomm.com with ESMTP; 18 Dec 2019 14:59:55 +0100
Received: from lx-merez2.mea.qualcomm.com ([10.18.173.102])
  by ironmsg03-ams.qualcomm.com with ESMTP; 18 Dec 2019 14:59:54 +0100
From:   Maya Erez <merez@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Dedy Lansky <dlansky@codeaurora.org>,
        linux-wireless@vger.kernel.org, wil6210@qti.qualcomm.com,
        Maya Erez <merez@codeaurora.org>
Subject: [PATCH 8/8] wil6210: add support for set_cqm_rssi_config
Date:   Wed, 18 Dec 2019 15:59:47 +0200
Message-Id: <20191218135947.5903-9-merez@codeaurora.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191218135947.5903-1-merez@codeaurora.org>
References: <20191218135947.5903-1-merez@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Dedy Lansky <dlansky@codeaurora.org>

set_cqm_rssi_config() is used by the kernel to configure connection
quality monitor RSSI threshold.
wil6210 uses WMI_SET_LINK_MONITOR_CMDID to set the RSSI threshold to
FW which in turn reports RSSI threshold changes with
WMI_LINK_MONITOR_EVENTID.

Signed-off-by: Dedy Lansky <dlansky@codeaurora.org>
Signed-off-by: Maya Erez <merez@codeaurora.org>
---
 drivers/net/wireless/ath/wil6210/cfg80211.c | 18 +++++
 drivers/net/wireless/ath/wil6210/wil6210.h  |  3 +
 drivers/net/wireless/ath/wil6210/wmi.c      | 76 +++++++++++++++++++++
 drivers/net/wireless/ath/wil6210/wmi.h      | 33 +++++++++
 4 files changed, 130 insertions(+)

diff --git a/drivers/net/wireless/ath/wil6210/cfg80211.c b/drivers/net/wireless/ath/wil6210/cfg80211.c
index 5a3aff131472..0851d2bede89 100644
--- a/drivers/net/wireless/ath/wil6210/cfg80211.c
+++ b/drivers/net/wireless/ath/wil6210/cfg80211.c
@@ -2594,6 +2594,23 @@ static int wil_cfg80211_set_multicast_to_unicast(struct wiphy *wiphy,
 	return 0;
 }
 
+static int wil_cfg80211_set_cqm_rssi_config(struct wiphy *wiphy,
+					    struct net_device *dev,
+					    s32 rssi_thold, u32 rssi_hyst)
+{
+	struct wil6210_priv *wil = wiphy_to_wil(wiphy);
+	int rc;
+
+	wil->cqm_rssi_thold = rssi_thold;
+
+	rc = wmi_set_cqm_rssi_config(wil, rssi_thold, rssi_hyst);
+	if (rc)
+		/* reset stored value upon failure */
+		wil->cqm_rssi_thold = 0;
+
+	return rc;
+}
+
 static const struct cfg80211_ops wil_cfg80211_ops = {
 	.add_virtual_intf = wil_cfg80211_add_iface,
 	.del_virtual_intf = wil_cfg80211_del_iface,
@@ -2625,6 +2642,7 @@ static const struct cfg80211_ops wil_cfg80211_ops = {
 	.start_p2p_device = wil_cfg80211_start_p2p_device,
 	.stop_p2p_device = wil_cfg80211_stop_p2p_device,
 	.set_power_mgmt = wil_cfg80211_set_power_mgmt,
+	.set_cqm_rssi_config = wil_cfg80211_set_cqm_rssi_config,
 	.suspend = wil_cfg80211_suspend,
 	.resume = wil_cfg80211_resume,
 	.sched_scan_start = wil_cfg80211_sched_scan_start,
diff --git a/drivers/net/wireless/ath/wil6210/wil6210.h b/drivers/net/wireless/ath/wil6210/wil6210.h
index 21399ced2a5d..5dc881d3c057 100644
--- a/drivers/net/wireless/ath/wil6210/wil6210.h
+++ b/drivers/net/wireless/ath/wil6210/wil6210.h
@@ -1060,6 +1060,7 @@ struct wil6210_priv {
 	u32 max_agg_wsize;
 	u32 max_ampdu_size;
 	u8 multicast_to_unicast;
+	s32 cqm_rssi_thold;
 };
 
 #define wil_to_wiphy(i) (i->wiphy)
@@ -1441,4 +1442,6 @@ int wmi_addba_rx_resp_edma(struct wil6210_priv *wil, u8 mid, u8 cid,
 void update_supported_bands(struct wil6210_priv *wil);
 
 void wil_clear_fw_log_addr(struct wil6210_priv *wil);
+int wmi_set_cqm_rssi_config(struct wil6210_priv *wil,
+			    s32 rssi_thold, u32 rssi_hyst);
 #endif /* __WIL6210_H__ */
diff --git a/drivers/net/wireless/ath/wil6210/wmi.c b/drivers/net/wireless/ath/wil6210/wmi.c
index 3aca86b3071d..dcba0a4c47b4 100644
--- a/drivers/net/wireless/ath/wil6210/wmi.c
+++ b/drivers/net/wireless/ath/wil6210/wmi.c
@@ -476,6 +476,8 @@ static const char *cmdid2name(u16 cmdid)
 		return "WMI_RBUFCAP_CFG_CMD";
 	case WMI_TEMP_SENSE_ALL_CMDID:
 		return "WMI_TEMP_SENSE_ALL_CMDID";
+	case WMI_SET_LINK_MONITOR_CMDID:
+		return "WMI_SET_LINK_MONITOR_CMD";
 	default:
 		return "Untracked CMD";
 	}
@@ -624,6 +626,10 @@ static const char *eventid2name(u16 eventid)
 		return "WMI_RBUFCAP_CFG_EVENT";
 	case WMI_TEMP_SENSE_ALL_DONE_EVENTID:
 		return "WMI_TEMP_SENSE_ALL_DONE_EVENTID";
+	case WMI_SET_LINK_MONITOR_EVENTID:
+		return "WMI_SET_LINK_MONITOR_EVENT";
+	case WMI_LINK_MONITOR_EVENTID:
+		return "WMI_LINK_MONITOR_EVENT";
 	default:
 		return "Untracked EVENT";
 	}
@@ -1836,6 +1842,32 @@ wmi_evt_reassoc_status(struct wil6210_vif *vif, int id, void *d, int len)
 	wil6210_disconnect(vif, NULL, WLAN_REASON_PREV_AUTH_NOT_VALID);
 }
 
+static void
+wmi_evt_link_monitor(struct wil6210_vif *vif, int id, void *d, int len)
+{
+	struct wil6210_priv *wil = vif_to_wil(vif);
+	struct net_device *ndev = vif_to_ndev(vif);
+	struct wmi_link_monitor_event *evt = d;
+	enum nl80211_cqm_rssi_threshold_event event_type;
+
+	if (len < sizeof(*evt)) {
+		wil_err(wil, "link monitor event too short %d\n", len);
+		return;
+	}
+
+	wil_dbg_wmi(wil, "link monitor event, type %d rssi %d (stored %d)\n",
+		    evt->type, evt->rssi_level, wil->cqm_rssi_thold);
+
+	if (evt->type != WMI_LINK_MONITOR_NOTIF_RSSI_THRESHOLD_EVT)
+		/* ignore */
+		return;
+
+	event_type = (evt->rssi_level > wil->cqm_rssi_thold ?
+		      NL80211_CQM_RSSI_THRESHOLD_EVENT_HIGH :
+		      NL80211_CQM_RSSI_THRESHOLD_EVENT_LOW);
+	cfg80211_cqm_rssi_notify(ndev, event_type, evt->rssi_level, GFP_KERNEL);
+}
+
 /**
  * Some events are ignored for purpose; and need not be interpreted as
  * "unhandled events"
@@ -1869,6 +1901,7 @@ static const struct {
 	{WMI_LINK_STATS_EVENTID,		wmi_evt_link_stats},
 	{WMI_FT_AUTH_STATUS_EVENTID,		wmi_evt_auth_status},
 	{WMI_FT_REASSOC_STATUS_EVENTID,		wmi_evt_reassoc_status},
+	{WMI_LINK_MONITOR_EVENTID,		wmi_evt_link_monitor},
 };
 
 /*
@@ -3981,3 +4014,46 @@ int wmi_link_stats_cfg(struct wil6210_vif *vif, u32 type, u8 cid, u32 interval)
 
 	return 0;
 }
+
+int wmi_set_cqm_rssi_config(struct wil6210_priv *wil,
+			    s32 rssi_thold, u32 rssi_hyst)
+{
+	struct net_device *ndev = wil->main_ndev;
+	struct wil6210_vif *vif = ndev_to_vif(ndev);
+	int rc;
+	struct {
+		struct wmi_set_link_monitor_cmd cmd;
+		s8 rssi_thold;
+	} __packed cmd = {
+		.cmd = {
+			.rssi_hyst = rssi_hyst,
+			.rssi_thresholds_list_size = 1,
+		},
+		.rssi_thold = rssi_thold,
+	};
+	struct {
+		struct wmi_cmd_hdr hdr;
+		struct wmi_set_link_monitor_event evt;
+	} __packed reply = {
+		.evt = {.status = WMI_FW_STATUS_FAILURE},
+	};
+
+	if (rssi_thold > S8_MAX || rssi_thold < S8_MIN || rssi_hyst > U8_MAX)
+		return -EINVAL;
+
+	rc = wmi_call(wil, WMI_SET_LINK_MONITOR_CMDID, vif->mid, &cmd,
+		      sizeof(cmd), WMI_SET_LINK_MONITOR_EVENTID,
+		      &reply, sizeof(reply), WIL_WMI_CALL_GENERAL_TO_MS);
+	if (rc) {
+		wil_err(wil, "WMI_SET_LINK_MONITOR_CMDID failed, rc %d\n", rc);
+		return rc;
+	}
+
+	if (reply.evt.status != WMI_FW_STATUS_SUCCESS) {
+		wil_err(wil, "WMI_SET_LINK_MONITOR_CMDID failed, status %d\n",
+			reply.evt.status);
+		return -EINVAL;
+	}
+
+	return 0;
+}
diff --git a/drivers/net/wireless/ath/wil6210/wmi.h b/drivers/net/wireless/ath/wil6210/wmi.h
index 6bd4ccee28ab..e3558136e0c4 100644
--- a/drivers/net/wireless/ath/wil6210/wmi.h
+++ b/drivers/net/wireless/ath/wil6210/wmi.h
@@ -192,6 +192,7 @@ enum wmi_command_id {
 	WMI_RCP_ADDBA_RESP_EDMA_CMDID			= 0x83B,
 	WMI_LINK_MAINTAIN_CFG_WRITE_CMDID		= 0x842,
 	WMI_LINK_MAINTAIN_CFG_READ_CMDID		= 0x843,
+	WMI_SET_LINK_MONITOR_CMDID			= 0x845,
 	WMI_SET_SECTORS_CMDID				= 0x849,
 	WMI_MAINTAIN_PAUSE_CMDID			= 0x850,
 	WMI_MAINTAIN_RESUME_CMDID			= 0x851,
@@ -1973,6 +1974,7 @@ enum wmi_event_id {
 	WMI_REPORT_STATISTICS_EVENTID			= 0x100B,
 	WMI_FT_AUTH_STATUS_EVENTID			= 0x100C,
 	WMI_FT_REASSOC_STATUS_EVENTID			= 0x100D,
+	WMI_LINK_MONITOR_EVENTID			= 0x100E,
 	WMI_RADAR_GENERAL_CONFIG_EVENTID		= 0x1100,
 	WMI_RADAR_CONFIG_SELECT_EVENTID			= 0x1101,
 	WMI_RADAR_PARAMS_CONFIG_EVENTID			= 0x1102,
@@ -2024,6 +2026,7 @@ enum wmi_event_id {
 	WMI_TX_MGMT_PACKET_EVENTID			= 0x1841,
 	WMI_LINK_MAINTAIN_CFG_WRITE_DONE_EVENTID	= 0x1842,
 	WMI_LINK_MAINTAIN_CFG_READ_DONE_EVENTID		= 0x1843,
+	WMI_SET_LINK_MONITOR_EVENTID			= 0x1845,
 	WMI_RF_XPM_READ_RESULT_EVENTID			= 0x1856,
 	WMI_RF_XPM_WRITE_RESULT_EVENTID			= 0x1857,
 	WMI_LED_CFG_DONE_EVENTID			= 0x1858,
@@ -3312,6 +3315,36 @@ struct wmi_link_maintain_cfg_read_cmd {
 	__le32 cid;
 } __packed;
 
+/* WMI_SET_LINK_MONITOR_CMDID */
+struct wmi_set_link_monitor_cmd {
+	u8 rssi_hyst;
+	u8 reserved[12];
+	u8 rssi_thresholds_list_size;
+	s8 rssi_thresholds_list[0];
+} __packed;
+
+/* wmi_link_monitor_event_type */
+enum wmi_link_monitor_event_type {
+	WMI_LINK_MONITOR_NOTIF_RSSI_THRESHOLD_EVT	= 0x00,
+	WMI_LINK_MONITOR_NOTIF_TX_ERR_EVT		= 0x01,
+	WMI_LINK_MONITOR_NOTIF_THERMAL_EVT		= 0x02,
+};
+
+/* WMI_SET_LINK_MONITOR_EVENTID */
+struct wmi_set_link_monitor_event {
+	/* wmi_fw_status */
+	u8 status;
+	u8 reserved[3];
+} __packed;
+
+/* WMI_LINK_MONITOR_EVENTID */
+struct wmi_link_monitor_event {
+	/* link_monitor_event_type */
+	u8 type;
+	s8 rssi_level;
+	u8 reserved[2];
+} __packed;
+
 /* WMI_LINK_MAINTAIN_CFG_WRITE_DONE_EVENTID */
 struct wmi_link_maintain_cfg_write_done_event {
 	/* requested connection ID */
-- 
2.23.0

