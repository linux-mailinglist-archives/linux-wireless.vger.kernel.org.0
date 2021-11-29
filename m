Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF344613A9
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Nov 2021 12:12:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377629AbhK2LPO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Nov 2021 06:15:14 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:36068 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237404AbhK2LNM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Nov 2021 06:13:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1638184195; x=1669720195;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YOg3epeOYjJtoChU9S5PIQ8Pg5aK5gjy7h4SRE7uFyo=;
  b=lUKOcOZi1HUCYxEuh4XqqbewU6SbR4FuVb+ewE9Wh8IZdZcznf8jz+BJ
   HVwFRyBSK4GzwewZS3Py6Uy+TRvwkKNHvYSaKGi9AWZLNmNYaIrge7u48
   k389MiCM1hsj+GqmON6MqgWlPZL89qKsCmfeUQVLnd+3qZMTDks22owKN
   w=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 29 Nov 2021 03:09:54 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2021 03:09:54 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Mon, 29 Nov 2021 03:09:54 -0800
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Mon, 29 Nov 2021 03:09:52 -0800
From:   Wen Gong <quic_wgong@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <quic_wgong@quicinc.com>
Subject: [PATCH] ath11k: change to use dynamic memory for channel list of scan
Date:   Mon, 29 Nov 2021 06:09:39 -0500
Message-ID: <20211129110939.15711-1-quic_wgong@quicinc.com>
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

Currently there are about 60 channels for 6 GHz, then the size of
chan_list in struct scan_req_params which is 40 is not enough to
fill all the channel list of 6 GHz.

Use dynamic memory to save the channel list of scan.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1

Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/mac.c | 10 ++++++++++
 drivers/net/wireless/ath/ath11k/wmi.h |  3 +--
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 06d20658586a..bad2f720a444 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -3500,6 +3500,14 @@ static int ath11k_mac_op_hw_scan(struct ieee80211_hw *hw,
 
 	if (req->n_channels) {
 		arg.num_chan = req->n_channels;
+		arg.chan_list = kcalloc(arg.num_chan, sizeof(*arg.chan_list),
+					GFP_KERNEL);
+
+		if (!arg.chan_list) {
+			ret = -ENOMEM;
+			goto exit;
+		}
+
 		for (i = 0; i < arg.num_chan; i++)
 			arg.chan_list[i] = req->channels[i]->center_freq;
 	}
@@ -3518,6 +3526,8 @@ static int ath11k_mac_op_hw_scan(struct ieee80211_hw *hw,
 						      ATH11K_MAC_SCAN_TIMEOUT_MSECS));
 
 exit:
+	kfree(arg.chan_list);
+
 	if (req->ie_len)
 		kfree(arg.extraie.ptr);
 
diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
index 8e8bac1b7370..35f5432357f5 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -3082,7 +3082,6 @@ enum scan_dwelltime_adaptive_mode {
 
 #define WLAN_SCAN_MAX_NUM_SSID          10
 #define WLAN_SCAN_MAX_NUM_BSSID         10
-#define WLAN_SCAN_MAX_NUM_CHANNELS      40
 
 #define WLAN_SSID_MAX_LEN 32
 
@@ -3303,7 +3302,7 @@ struct scan_req_params {
 	u32 num_bssid;
 	u32 num_ssids;
 	u32 n_probes;
-	u32 chan_list[WLAN_SCAN_MAX_NUM_CHANNELS];
+	u32 *chan_list;
 	u32 notify_scan_events;
 	struct wlan_ssid ssid[WLAN_SCAN_MAX_NUM_SSID];
 	struct wmi_mac_addr bssid_list[WLAN_SCAN_MAX_NUM_BSSID];
-- 
2.31.1

