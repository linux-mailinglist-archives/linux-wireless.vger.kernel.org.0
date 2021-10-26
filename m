Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7F5643AA93
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Oct 2021 04:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234525AbhJZDBn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 Oct 2021 23:01:43 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:21689 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbhJZDBm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Oct 2021 23:01:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1635217160; x=1666753160;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OVoBcGDkhc6VnKEutfoPDmQju4OwxIJ0h0yn5iQdpUI=;
  b=fAhoEdMQI8FomeR1TZmbd2FQUR52/D0AJWc96ui+G0HHVAu47q4zcIID
   SWTCcBWAkQ/yNdO7TxzCLhdcJMaWcNtJ320Of/WgfeXq+3r6/HBdRkJNB
   Zi4vYLj+RNmbVpcTwIYox7FzLBnOIFTwN2z0obHqXphHHOoU9LWOQP1b6
   c=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 25 Oct 2021 19:59:20 -0700
X-QCInternal: smtphost
Received: from nalasex01a.na.qualcomm.com ([10.47.209.196])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2021 19:59:18 -0700
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.7;
 Mon, 25 Oct 2021 19:59:18 -0700
From:   Wen Gong <quic_wgong@quicinc.com>
To:     <ath10k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <quic_wgong@quicinc.com>
Subject: [PATCH] ath10k: fix scan abort when duration is set for hw scan
Date:   Mon, 25 Oct 2021 22:59:02 -0400
Message-ID: <20211026025902.26621-1-quic_wgong@quicinc.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When request scan with duration 120ms on channel 1, it failed with
scan abort easily. Because scan_timeout is set to 130ms for the scan
in ath10k_hw_scan(), and timed out before scan complete, so lead
scan abort.

failed log of ath10k:
2021-04-14T14:43:29.936058Z DEBUG kernel: [67384.594846] ath10k_sdio mmc1:0001:1: wmi tlv start scan
2021-04-14T14:43:29.937896Z DEBUG kernel: [67384.595820] ath10k_sdio mmc1:0001:1: scan event started type 1 reason 7 freq 2437 req_id 40961 scan_id 40960 vdev_id 0 state starting (1)
2021-04-14T14:43:29.938357Z DEBUG kernel: [67384.596761] ath10k_sdio mmc1:0001:1: scan event bss channel type 4 reason 7 freq 2437 req_id 40961 scan_id 40960 vdev_id 0 state running (2)
2021-04-14T14:43:29.992497Z DEBUG kernel: [67384.651013] ath10k_sdio mmc1:0001:1: scan event foreign channel type 8 reason 7 freq 2412 req_id 40961 scan_id 40960 vdev_id 0 state running (2)
2021-04-14T14:43:30.063530Z DEBUG kernel: [67384.722139] ath10k_sdio mmc1:0001:1: wmi tlv stop scan
2021-04-14T14:43:30.066592Z DEBUG kernel: [67384.724403] ath10k_sdio mmc1:0001:1: scan event completed [cancelled] type 2 reason 1 freq 2412 req_id 40961 scan_id 40960 vdev_id 0 state aborting (3)

failed log of wpa_supplicant:
2021-04-14T14:43:29.981842Z DEBUG wpa_supplicant[887]: wlan0: nl80211: scan request
2021-04-14T14:43:29.981988Z DEBUG wpa_supplicant[887]: nl80211: Passive scan requested
2021-04-14T14:43:29.982202Z DEBUG wpa_supplicant[887]: nl80211: Add NL80211_SCAN_FLAG_FLUSH
2021-04-14T14:43:29.982339Z DEBUG wpa_supplicant[887]: Scan requested (ret=0) - scan timeout 30 seconds
2021-04-14T14:43:29.982491Z DEBUG wpa_supplicant[887]: nl80211: Drv Event 33 (NL80211_CMD_TRIGGER_SCAN) received for wlan0
2021-04-14T14:43:29.982629Z DEBUG wpa_supplicant[887]: wlan0: nl80211: Scan trigger
2021-04-14T14:43:29.982779Z DEBUG wpa_supplicant[887]: wlan0: Event SCAN_STARTED (47) received
2021-04-14T14:43:29.982920Z DEBUG wpa_supplicant[887]: wlan0: Own scan request started a scan in 0.000175 seconds
2021-04-14T14:43:30.082401Z DEBUG wpa_supplicant[887]: nl80211: Drv Event 35 (NL80211_CMD_SCAN_ABORTED) received for wlan0
2021-04-14T14:43:30.082704Z DEBUG wpa_supplicant[887]: wlan0: nl80211: Scan aborted
2021-04-14T14:43:30.082905Z DEBUG wpa_supplicant[887]: nl80211: Scan included frequencies: 2412
2021-04-14T14:43:30.083123Z DEBUG wpa_supplicant[887]: wlan0: Event SCAN_RESULTS (3) received
2021-04-14T14:43:30.083310Z DEBUG wpa_supplicant[887]: wlan0: Scan completed in 0.128655 seconds

This is to increase the scan_timeout with 200ms for this situation,
then scan will not timed out for this situation.

Tested-on: QCA6174 hw3.2 SDIO WLAN.RMH.4.4.1-00049

Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
---
 drivers/net/wireless/ath/ath10k/mac.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
index bb6c5ee43ac0..a4bd6b9dcf6f 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -6354,13 +6354,14 @@ static int ath10k_hw_scan(struct ieee80211_hw *hw,
 		scan_timeout = min_t(u32, arg.max_rest_time *
 				(arg.n_channels - 1) + (req->duration +
 				ATH10K_SCAN_CHANNEL_SWITCH_WMI_EVT_OVERHEAD) *
-				arg.n_channels, arg.max_scan_time + 200);
-
+				arg.n_channels, arg.max_scan_time);
 	} else {
-		/* Add a 200ms margin to account for event/command processing */
-		scan_timeout = arg.max_scan_time + 200;
+		scan_timeout = arg.max_scan_time;
 	}
 
+	/* Add a 200ms margin to account for event/command processing */
+	scan_timeout += 200;
+
 	ret = ath10k_start_scan(ar, &arg);
 	if (ret) {
 		ath10k_warn(ar, "failed to start hw scan: %d\n", ret);
-- 
2.31.1

