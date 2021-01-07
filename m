Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1655F2EC715
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Jan 2021 00:51:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbhAFXvi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 6 Jan 2021 18:51:38 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:50093 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726293AbhAFXvi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 6 Jan 2021 18:51:38 -0500
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 06 Jan 2021 15:50:57 -0800
X-QCInternal: smtphost
Received: from mxchen-linux.qualcomm.com (HELO mxchen-linux.localdomain) ([10.234.28.165])
  by ironmsg04-sd.qualcomm.com with ESMTP; 06 Jan 2021 15:50:57 -0800
Received: by mxchen-linux.localdomain (Postfix, from userid 451784)
        id 690183D3F; Wed,  6 Jan 2021 15:50:56 -0800 (PST)
From:   Max Chen <mxchen@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     Max Chen <mxchen@codeaurora.org>, linux-wireless@vger.kernel.org,
        wil6210@qti.qualcomm.com
Subject: [PATCH 2/2] wil6210: Add Support for Extended DMG MCS 12.1
Date:   Wed,  6 Jan 2021 15:50:50 -0800
Message-Id: <1609977050-7089-3-git-send-email-mxchen@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1609977050-7089-1-git-send-email-mxchen@codeaurora.org>
References: <1609977050-7089-1-git-send-email-mxchen@codeaurora.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

FW reports Tx/Rx extended MCS 12.1 to driver as "26". Driver will
convert this into base MCS 7 + EXTENDED_SC_DMG flag so kernel can do
the correct phy rate conversion. Also add log prints to print "12.1"
instead of "26" for extended MCS.

Signed-off-by: Max Chen <mxchen@codeaurora.org>
---
 drivers/net/wireless/ath/wil6210/cfg80211.c  | 38 ++++++++++++++++++++++------
 drivers/net/wireless/ath/wil6210/debugfs.c   | 17 ++++++++-----
 drivers/net/wireless/ath/wil6210/txrx_edma.c |  2 ++
 drivers/net/wireless/ath/wil6210/wil6210.h   |  3 +++
 drivers/net/wireless/ath/wil6210/wmi.c       | 11 ++++----
 5 files changed, 52 insertions(+), 19 deletions(-)

diff --git a/drivers/net/wireless/ath/wil6210/cfg80211.c b/drivers/net/wireless/ath/wil6210/cfg80211.c
index 1c42410..1ff2679 100644
--- a/drivers/net/wireless/ath/wil6210/cfg80211.c
+++ b/drivers/net/wireless/ath/wil6210/cfg80211.c
@@ -441,7 +441,9 @@ int wil_cid_fill_sinfo(struct wil6210_vif *vif, int cid,
 	} __packed reply;
 	struct wil_net_stats *stats = &wil->sta[cid].stats;
 	int rc;
-	u8 txflag = RATE_INFO_FLAGS_DMG;
+	u8 tx_mcs, rx_mcs;
+	u8 tx_rate_flag = RATE_INFO_FLAGS_DMG;
+	u8 rx_rate_flag = RATE_INFO_FLAGS_DMG;
 
 	memset(&reply, 0, sizeof(reply));
 
@@ -451,13 +453,15 @@ int wil_cid_fill_sinfo(struct wil6210_vif *vif, int cid,
 	if (rc)
 		return rc;
 
+	tx_mcs = le16_to_cpu(reply.evt.bf_mcs);
+
 	wil_dbg_wmi(wil, "Link status for CID %d MID %d: {\n"
-		    "  MCS %d TSF 0x%016llx\n"
+		    "  MCS %s TSF 0x%016llx\n"
 		    "  BF status 0x%08x RSSI %d SQI %d%%\n"
 		    "  Tx Tpt %d goodput %d Rx goodput %d\n"
 		    "  Sectors(rx:tx) my %d:%d peer %d:%d\n"
 		    "  Tx mode %d}\n",
-		    cid, vif->mid, le16_to_cpu(reply.evt.bf_mcs),
+		    cid, vif->mid, WIL_EXTENDED_MCS_CHECK(tx_mcs),
 		    le64_to_cpu(reply.evt.tsf), reply.evt.status,
 		    reply.evt.rssi,
 		    reply.evt.sqi,
@@ -481,12 +485,30 @@ int wil_cid_fill_sinfo(struct wil6210_vif *vif, int cid,
 			BIT_ULL(NL80211_STA_INFO_RX_DROP_MISC) |
 			BIT_ULL(NL80211_STA_INFO_TX_FAILED);
 
-	if (wil->use_enhanced_dma_hw && reply.evt.tx_mode != WMI_TX_MODE_DMG)
-		txflag = RATE_INFO_FLAGS_EDMG;
+	if (wil->use_enhanced_dma_hw && reply.evt.tx_mode != WMI_TX_MODE_DMG) {
+		tx_rate_flag = RATE_INFO_FLAGS_EDMG;
+		rx_rate_flag = RATE_INFO_FLAGS_EDMG;
+	}
+
+	rx_mcs = stats->last_mcs_rx;
+
+	/* check extended MCS (12.1) and convert it into
+	 * base MCS (7) + EXTENDED_SC_DMG flag
+	 */
+	if (tx_mcs == WIL_EXTENDED_MCS_26) {
+		tx_rate_flag = RATE_INFO_FLAGS_EXTENDED_SC_DMG;
+		tx_mcs = WIL_BASE_MCS_FOR_EXTENDED_26;
+	}
+	if (rx_mcs == WIL_EXTENDED_MCS_26) {
+		rx_rate_flag = RATE_INFO_FLAGS_EXTENDED_SC_DMG;
+		rx_mcs = WIL_BASE_MCS_FOR_EXTENDED_26;
+	}
+
+	sinfo->txrate.flags = tx_rate_flag;
+	sinfo->rxrate.flags = rx_rate_flag;
+	sinfo->txrate.mcs = tx_mcs;
+	sinfo->rxrate.mcs = rx_mcs;
 
-	sinfo->txrate.flags = txflag;
-	sinfo->txrate.mcs = le16_to_cpu(reply.evt.bf_mcs);
-	sinfo->rxrate.mcs = stats->last_mcs_rx;
 	sinfo->txrate.n_bonded_ch =
 				  wil_tx_cb_mode_to_n_bonded(reply.evt.tx_mode);
 	sinfo->rxrate.n_bonded_ch =
diff --git a/drivers/net/wireless/ath/wil6210/debugfs.c b/drivers/net/wireless/ath/wil6210/debugfs.c
index 2d618f9..4c944e5 100644
--- a/drivers/net/wireless/ath/wil6210/debugfs.c
+++ b/drivers/net/wireless/ath/wil6210/debugfs.c
@@ -1294,6 +1294,7 @@ static int bf_show(struct seq_file *s, void *data)
 
 	for (i = 0; i < wil->max_assoc_sta; i++) {
 		u32 status;
+		u8 bf_mcs;
 
 		cmd.cid = i;
 		rc = wmi_call(wil, WMI_NOTIFY_REQ_CMDID, vif->mid,
@@ -1305,9 +1306,10 @@ static int bf_show(struct seq_file *s, void *data)
 			continue;
 
 		status = le32_to_cpu(reply.evt.status);
+		bf_mcs = le16_to_cpu(reply.evt.bf_mcs);
 		seq_printf(s, "CID %d {\n"
 			   "  TSF = 0x%016llx\n"
-			   "  TxMCS = %2d TxTpt = %4d\n"
+			   "  TxMCS = %s TxTpt = %4d\n"
 			   "  SQI = %4d\n"
 			   "  RSSI = %4d\n"
 			   "  Status = 0x%08x %s\n"
@@ -1316,7 +1318,7 @@ static int bf_show(struct seq_file *s, void *data)
 			   "}\n",
 			   i,
 			   le64_to_cpu(reply.evt.tsf),
-			   le16_to_cpu(reply.evt.bf_mcs),
+			   WIL_EXTENDED_MCS_CHECK(bf_mcs),
 			   le32_to_cpu(reply.evt.tx_tpt),
 			   reply.evt.sqi,
 			   reply.evt.rssi,
@@ -1443,8 +1445,10 @@ static int link_show(struct seq_file *s, void *data)
 			if (rc)
 				goto out;
 
-			seq_printf(s, "  Tx_mcs = %d\n", sinfo->txrate.mcs);
-			seq_printf(s, "  Rx_mcs = %d\n", sinfo->rxrate.mcs);
+			seq_printf(s, "  Tx_mcs = %s\n",
+				   WIL_EXTENDED_MCS_CHECK(sinfo->txrate.mcs));
+			seq_printf(s, "  Rx_mcs = %s\n",
+				   WIL_EXTENDED_MCS_CHECK(sinfo->rxrate.mcs));
 			seq_printf(s, "  SQ     = %d\n", sinfo->signal);
 		} else {
 			seq_puts(s, "  INVALID MID\n");
@@ -1848,7 +1852,7 @@ static void wil_link_stats_print_basic(struct wil6210_vif *vif,
 		snprintf(per, sizeof(per), "%d%%", basic->per_average);
 
 	seq_printf(s, "CID %d {\n"
-		   "\tTxMCS %d TxTpt %d\n"
+		   "\tTxMCS %s TxTpt %d\n"
 		   "\tGoodput(rx:tx) %d:%d\n"
 		   "\tRxBcastFrames %d\n"
 		   "\tRSSI %d SQI %d SNR %d PER %s\n"
@@ -1856,7 +1860,8 @@ static void wil_link_stats_print_basic(struct wil6210_vif *vif,
 		   "\tSectors(rx:tx) my %d:%d peer %d:%d\n"
 		   "}\n",
 		   basic->cid,
-		   basic->bf_mcs, le32_to_cpu(basic->tx_tpt),
+		   WIL_EXTENDED_MCS_CHECK(basic->bf_mcs),
+		   le32_to_cpu(basic->tx_tpt),
 		   le32_to_cpu(basic->rx_goodput),
 		   le32_to_cpu(basic->tx_goodput),
 		   le32_to_cpu(basic->rx_bcast_frames),
diff --git a/drivers/net/wireless/ath/wil6210/txrx_edma.c b/drivers/net/wireless/ath/wil6210/txrx_edma.c
index 8ca2ce5..201c8c3 100644
--- a/drivers/net/wireless/ath/wil6210/txrx_edma.c
+++ b/drivers/net/wireless/ath/wil6210/txrx_edma.c
@@ -1026,6 +1026,8 @@ static struct sk_buff *wil_sring_reap_rx_edma(struct wil6210_priv *wil,
 		stats->last_mcs_rx = wil_rx_status_get_mcs(msg);
 		if (stats->last_mcs_rx < ARRAY_SIZE(stats->rx_per_mcs))
 			stats->rx_per_mcs[stats->last_mcs_rx]++;
+		else if (stats->last_mcs_rx == WIL_EXTENDED_MCS_26)
+			stats->rx_per_mcs[WIL_BASE_MCS_FOR_EXTENDED_26]++;
 
 		stats->last_cb_mode_rx  = wil_rx_status_get_cb_mode(msg);
 	}
diff --git a/drivers/net/wireless/ath/wil6210/wil6210.h b/drivers/net/wireless/ath/wil6210/wil6210.h
index 5dc881d..30392eb 100644
--- a/drivers/net/wireless/ath/wil6210/wil6210.h
+++ b/drivers/net/wireless/ath/wil6210/wil6210.h
@@ -89,6 +89,9 @@ static inline u32 WIL_GET_BITS(u32 x, int b0, int b1)
 #define WIL_MAX_AGG_WSIZE_64	(64) /* FW/HW limit */
 #define WIL6210_MAX_STATUS_RINGS	(8)
 #define WIL_WMI_CALL_GENERAL_TO_MS 100
+#define WIL_EXTENDED_MCS_26 (26) /* FW reports MCS 12.1 to driver as "26" */
+#define WIL_BASE_MCS_FOR_EXTENDED_26 (7) /* MCS 7 is base MCS for MCS 12.1 */
+#define WIL_EXTENDED_MCS_CHECK(x) (((x) == WIL_EXTENDED_MCS_26) ? "12.1" : #x)
 
 /* Hardware offload block adds the following:
  * 26 bytes - 3-address QoS data header
diff --git a/drivers/net/wireless/ath/wil6210/wmi.c b/drivers/net/wireless/ath/wil6210/wmi.c
index 421aebb..7e83ec7 100644
--- a/drivers/net/wireless/ath/wil6210/wmi.c
+++ b/drivers/net/wireless/ath/wil6210/wmi.c
@@ -851,9 +851,9 @@ static void wmi_evt_rx_mgmt(struct wil6210_vif *vif, int id, void *d, int len)
 	d_status = le16_to_cpu(data->info.status);
 	fc = rx_mgmt_frame->frame_control;
 
-	wil_dbg_wmi(wil, "MGMT Rx: channel %d MCS %d RSSI %d SQI %d%%\n",
-		    data->info.channel, data->info.mcs, data->info.rssi,
-		    data->info.sqi);
+	wil_dbg_wmi(wil, "MGMT Rx: channel %d MCS %s RSSI %d SQI %d%%\n",
+		    data->info.channel, WIL_EXTENDED_MCS_CHECK(data->info.mcs),
+		    data->info.rssi, data->info.sqi);
 	wil_dbg_wmi(wil, "status 0x%04x len %d fc 0x%04x\n", d_status, d_len,
 		    le16_to_cpu(fc));
 	wil_dbg_wmi(wil, "qid %d mid %d cid %d\n",
@@ -1422,8 +1422,9 @@ wmi_evt_sched_scan_result(struct wil6210_vif *vif, int id, void *d, int len)
 	else
 		signal = data->info.sqi;
 
-	wil_dbg_wmi(wil, "sched scan result: channel %d MCS %d RSSI %d\n",
-		    data->info.channel, data->info.mcs, data->info.rssi);
+	wil_dbg_wmi(wil, "sched scan result: channel %d MCS %s RSSI %d\n",
+		    data->info.channel, WIL_EXTENDED_MCS_CHECK(data->info.mcs),
+		    data->info.rssi);
 	wil_dbg_wmi(wil, "len %d qid %d mid %d cid %d\n",
 		    d_len, data->info.qid, data->info.mid, data->info.cid);
 	wil_hex_dump_wmi("PROBE ", DUMP_PREFIX_OFFSET, 16, 1, rx_mgmt_frame,
-- 
2.7.4

