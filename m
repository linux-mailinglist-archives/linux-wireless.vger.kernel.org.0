Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B20552D35D
	for <lists+linux-wireless@lfdr.de>; Thu, 19 May 2022 14:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234985AbiESM7d (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 May 2022 08:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238109AbiESM7I (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 May 2022 08:59:08 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F48DE732B
        for <linux-wireless@vger.kernel.org>; Thu, 19 May 2022 05:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1652965095; x=1684501095;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=jYwDht3oXd+jf0z1KjRp0bFkmv9I/TqMmsa/01rrl6M=;
  b=jE0kaqnEc66AiR1DVeD0OQUS8xGyeA74DDAisCgrt/cscNp3eNSICKm5
   oXWqLSWhWNExnHzjo1dviBS6sXEbIhzXzt5Z8s3O8VZlBVUe9eWMGMSMl
   689eR7Q5B7n+49GnQ8zdj5/KNmF7bfYXsB6H6a7dNOwGaDCdI0zau+7vP
   4=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 19 May 2022 05:58:15 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 05:58:14 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 19 May 2022 05:58:14 -0700
Received: from cdchalpyex0390930-lin.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 19 May 2022 05:58:12 -0700
From:   Thiraviyam Mariyappan <quic_tmariyap@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Thiraviyam Mariyappan <quic_tmariyap@quicinc.com>
Subject: [PATCH] ath11k: support avg signal in station dump
Date:   Thu, 19 May 2022 18:27:41 +0530
Message-ID: <1652965061-30457-1-git-send-email-quic_tmariyap@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Currently mac80211 doesn't calculate average signal when RSS(Receive side
scaling) is enabled from the driver, so average signal isn't printed in
the station dump. To address this issue, calculate the average signal
from RSSI within driver and display in the station dump.

Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.5.0.1-01208-QCAHKSWPL_SILICONZ-1

Signed-off-by: Thiraviyam Mariyappan <quic_tmariyap@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/core.h  | 4 ++++
 drivers/net/wireless/ath/ath11k/dp_rx.c | 3 +++
 drivers/net/wireless/ath/ath11k/mac.c   | 4 ++++
 3 files changed, 11 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index 95bca0b..ea31016 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -14,6 +14,7 @@
 #include <linux/dmi.h>
 #include <linux/ctype.h>
 #include <linux/rhashtable.h>
+#include <linux/average.h>
 #include "qmi.h"
 #include "htc.h"
 #include "wmi.h"
@@ -464,6 +465,8 @@ struct ath11k_per_ppdu_tx_stats {
 	u32 retry_bytes;
 };
 
+DECLARE_EWMA(avg_rssi, 10, 8)
+
 struct ath11k_sta {
 	struct ath11k_vif *arvif;
 
@@ -482,6 +485,7 @@ struct ath11k_sta {
 	u64 rx_duration;
 	u64 tx_duration;
 	u8 rssi_comb;
+	struct ewma_avg_rssi avg_rssi;
 	s8 rssi_beacon;
 	s8 chain_signal[IEEE80211_MAX_CHAINS];
 	struct ath11k_htt_tx_stats *tx_stats;
diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index 049774cc..e16beb9 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -2765,6 +2765,9 @@ static void ath11k_dp_rx_update_peer_stats(struct ath11k_sta *arsta,
 	if (!rx_stats)
 		return;
 
+	arsta->rssi_comb = ppdu_info->rssi_comb;
+	ewma_avg_rssi_add(&arsta->avg_rssi, ppdu_info->rssi_comb);
+
 	num_msdu = ppdu_info->tcp_msdu_count + ppdu_info->tcp_ack_msdu_count +
 		   ppdu_info->udp_msdu_count + ppdu_info->other_msdu_count;
 
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index ee1590b..362a07a 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -4479,6 +4479,7 @@ static int ath11k_mac_station_add(struct ath11k *ar,
 		}
 	}
 
+	ewma_avg_rssi_init(&arsta->avg_rssi);
 	return 0;
 
 free_tx_stats:
@@ -8161,6 +8162,9 @@ static void ath11k_mac_op_sta_statistics(struct ieee80211_hw *hw,
 		sinfo->signal = db2dbm ? signal : signal + ATH11K_DEFAULT_NOISE_FLOOR;
 		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_SIGNAL);
 	}
+
+	sinfo->signal_avg = ewma_avg_rssi_read(&arsta->avg_rssi) + ATH11K_DEFAULT_NOISE_FLOOR;
+	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_SIGNAL_AVG);
 }
 
 #if IS_ENABLED(CONFIG_IPV6)
-- 
2.7.4

