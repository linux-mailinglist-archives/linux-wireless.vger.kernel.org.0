Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 771E6ACBA2
	for <lists+linux-wireless@lfdr.de>; Sun,  8 Sep 2019 10:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbfIHIjW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 8 Sep 2019 04:39:22 -0400
Received: from alexa-out-ams-02.qualcomm.com ([185.23.61.163]:51394 "EHLO
        alexa-out-ams-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727418AbfIHIjS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 8 Sep 2019 04:39:18 -0400
X-Greylist: delayed 365 seconds by postgrey-1.27 at vger.kernel.org; Sun, 08 Sep 2019 04:39:09 EDT
Received: from ironmsg03-ams.qualcomm.com ([10.251.56.4])
  by alexa-out-ams-02.qualcomm.com with ESMTP; 08 Sep 2019 10:33:04 +0200
Received: from lx-merez1.mea.qualcomm.com ([10.18.173.103])
  by ironmsg03-ams.qualcomm.com with ESMTP; 08 Sep 2019 10:33:03 +0200
From:   Maya Erez <merez@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Maya Erez <merez@codeaurora.org>, linux-wireless@vger.kernel.org,
        wil6210@qti.qualcomm.com
Subject: [PATCH 08/11] wil6210: report boottime_ns in scan results
Date:   Sun,  8 Sep 2019 11:32:52 +0300
Message-Id: <1567931575-27984-9-git-send-email-merez@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1567931575-27984-1-git-send-email-merez@codeaurora.org>
References: <1567931575-27984-1-git-send-email-merez@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Call cfg80211_inform_bss_frame_data to report cfg80211 on the
boottime_ns in order to prevent the scan results filtering due to
aging.

Signed-off-by: Maya Erez <merez@codeaurora.org>
---
 drivers/net/wireless/ath/wil6210/wmi.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/wil6210/wmi.c b/drivers/net/wireless/ath/wil6210/wmi.c
index 88d9e5a..153b844 100644
--- a/drivers/net/wireless/ath/wil6210/wmi.c
+++ b/drivers/net/wireless/ath/wil6210/wmi.c
@@ -878,6 +878,12 @@ static void wmi_evt_rx_mgmt(struct wil6210_vif *vif, int id, void *d, int len)
 
 	if (ieee80211_is_beacon(fc) || ieee80211_is_probe_resp(fc)) {
 		struct cfg80211_bss *bss;
+		struct cfg80211_inform_bss bss_data = {
+			.chan = channel,
+			.scan_width = NL80211_BSS_CHAN_WIDTH_20,
+			.signal = signal,
+			.boottime_ns = ktime_to_ns(ktime_get_boottime()),
+		};
 		u64 tsf = le64_to_cpu(rx_mgmt_frame->u.beacon.timestamp);
 		u16 cap = le16_to_cpu(rx_mgmt_frame->u.beacon.capab_info);
 		u16 bi = le16_to_cpu(rx_mgmt_frame->u.beacon.beacon_int);
@@ -892,8 +898,9 @@ static void wmi_evt_rx_mgmt(struct wil6210_vif *vif, int id, void *d, int len)
 
 		wil_dbg_wmi(wil, "Capability info : 0x%04x\n", cap);
 
-		bss = cfg80211_inform_bss_frame(wiphy, channel, rx_mgmt_frame,
-						d_len, signal, GFP_KERNEL);
+		bss = cfg80211_inform_bss_frame_data(wiphy, &bss_data,
+						     rx_mgmt_frame,
+						     d_len, GFP_KERNEL);
 		if (bss) {
 			wil_dbg_wmi(wil, "Added BSS %pM\n",
 				    rx_mgmt_frame->bssid);
@@ -1391,6 +1398,10 @@ static void wmi_evt_delba(struct wil6210_vif *vif, int id, void *d, int len)
 	__le16 fc;
 	u32 d_len;
 	struct cfg80211_bss *bss;
+	struct cfg80211_inform_bss bss_data = {
+		.scan_width = NL80211_BSS_CHAN_WIDTH_20,
+		.boottime_ns = ktime_to_ns(ktime_get_boottime()),
+	};
 
 	if (flen < 0) {
 		wil_err(wil, "sched scan result event too short, len %d\n",
@@ -1433,8 +1444,10 @@ static void wmi_evt_delba(struct wil6210_vif *vif, int id, void *d, int len)
 		return;
 	}
 
-	bss = cfg80211_inform_bss_frame(wiphy, channel, rx_mgmt_frame,
-					d_len, signal, GFP_KERNEL);
+	bss_data.signal = signal;
+	bss_data.chan = channel;
+	bss = cfg80211_inform_bss_frame_data(wiphy, &bss_data, rx_mgmt_frame,
+					     d_len, GFP_KERNEL);
 	if (bss) {
 		wil_dbg_wmi(wil, "Added BSS %pM\n", rx_mgmt_frame->bssid);
 		cfg80211_put_bss(wiphy, bss);
-- 
1.9.1

