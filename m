Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5A094EAFC5
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Mar 2022 17:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237264AbiC2PEe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 29 Mar 2022 11:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237094AbiC2PEe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 29 Mar 2022 11:04:34 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D92618C0D0
        for <linux-wireless@vger.kernel.org>; Tue, 29 Mar 2022 08:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1648566171; x=1680102171;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=sXujaEN5nHLpPV9RxMoiZbS35N+Y4Qx+sgw2qjfj924=;
  b=rPX4GcIX9HB2eoNq2KteSmQ0X6RtppCcMPV9GyTYZ5iKXQMww+vjRldq
   H0Avq+FvAFvzJ4O3iuepgH97qQlxFkAQhaF+r4K2XINua4K/EBDlklwn4
   0QgE1kqXwzaPFyKW5Bvr8ZhU8sIEkSYja96Sn/D3o+SW2zXxHCaf3KrbS
   E=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 29 Mar 2022 08:02:50 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2022 08:02:50 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 29 Mar 2022 08:02:50 -0700
Received: from akalaise-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 29 Mar 2022 08:02:48 -0700
From:   Karthikeyan Kathirvel <quic_kathirve@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Karthikeyan Kathirvel <quic_kathirve@quicinc.com>
Subject: [PATCH] ath11k: Change max no of active probe SSID and BSSID to fw capability
Date:   Tue, 29 Mar 2022 20:32:21 +0530
Message-ID: <20220329150221.21907-1-quic_kathirve@quicinc.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The maximum number of SSIDs in a for active probe requests is currently
reported as 16 (WLAN_SCAN_PARAMS_MAX_SSID) when registering the driver.
The scan_req_params structure only has the capacity to hold 10 SSIDs.
This leads to a buffer overflow which can be triggered from
wpa_supplicant in userspace. When copying the SSIDs into the
scan_req_params structure in the ath11k_mac_op_hw_scan route, it can
overwrite the extraie pointer.

Firmware supports 16 ssid * 4 bssid, for each ssid 4 bssid combo probe
request will be sent, so totally 64 probe requests supported. So
set both max ssid and bssid to 16 and 4 respectively. Remove the
redundant macros of ssid and bssid.

Tested-on : WLAN.HK.2.7.0.1-01300-QCAHKSWPL_SILICONZ-1 v1

Signed-off-by: Karthikeyan Kathirvel <quic_kathirve@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/wmi.h | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
index 587f42307250..b5b72483477d 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -3088,9 +3088,6 @@ enum scan_dwelltime_adaptive_mode {
 	SCAN_DWELL_MODE_STATIC = 4
 };
 
-#define WLAN_SCAN_MAX_NUM_SSID          10
-#define WLAN_SCAN_MAX_NUM_BSSID         10
-
 #define WLAN_SSID_MAX_LEN 32
 
 struct element_info {
@@ -3105,7 +3102,6 @@ struct wlan_ssid {
 
 #define WMI_IE_BITMAP_SIZE             8
 
-#define WMI_SCAN_MAX_NUM_SSID                0x0A
 /* prefix used by scan requestor ids on the host */
 #define WMI_HOST_SCAN_REQUESTOR_ID_PREFIX 0xA000
 
@@ -3113,10 +3109,6 @@ struct wlan_ssid {
 /* host cycles through the lower 12 bits to generate ids */
 #define WMI_HOST_SCAN_REQ_ID_PREFIX 0xA000
 
-#define WLAN_SCAN_PARAMS_MAX_SSID    16
-#define WLAN_SCAN_PARAMS_MAX_BSSID   4
-#define WLAN_SCAN_PARAMS_MAX_IE_LEN  256
-
 /* Values lower than this may be refused by some firmware revisions with a scan
  * completion with a timedout reason.
  */
@@ -3312,8 +3304,8 @@ struct scan_req_params {
 	u32 n_probes;
 	u32 *chan_list;
 	u32 notify_scan_events;
-	struct wlan_ssid ssid[WLAN_SCAN_MAX_NUM_SSID];
-	struct wmi_mac_addr bssid_list[WLAN_SCAN_MAX_NUM_BSSID];
+	struct wlan_ssid ssid[WLAN_SCAN_PARAMS_MAX_SSID];
+	struct wmi_mac_addr bssid_list[WLAN_SCAN_PARAMS_MAX_BSSID];
 	struct element_info extraie;
 	struct element_info htcap;
 	struct element_info vhtcap;

base-commit: 1198cbe26aa57ebef7a5c4315260d2e93a93e9a6
-- 
2.23.0

