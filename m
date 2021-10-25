Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 627E3439601
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Oct 2021 14:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233190AbhJYMUQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 Oct 2021 08:20:16 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:38509 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233176AbhJYMTy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Oct 2021 08:19:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1635164253; x=1666700253;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=CoO8fG3XYZh2qdyBkOvtTBsE0q5aPqOPTI8LniuqIwM=;
  b=XQBOJglyEyMfBl3S6iuR6nRKU51iA+Sn0sOgpLTW9EZwmUg/M2MnyVfz
   YSN1+n96zyzp7I4wz9PNvBxpzRdQcbYhJImEnaks/vDYVyEJo3XhC77Q/
   ljoHZXEjWKh9ut9Kstb8yQ2ViYOtYb4PEe7nME/j9UdwEi0NAt8sPs3Ca
   k=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 25 Oct 2021 05:17:32 -0700
X-QCInternal: smtphost
Received: from nalasex01a.na.qualcomm.com ([10.47.209.196])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2021 05:17:32 -0700
Received: from ppranees-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.7;
 Mon, 25 Oct 2021 05:17:29 -0700
From:   P Praneesh <quic_ppranees@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        P Praneesh <quic_ppranees@quicinc.com>,
        Lavanya Suresh <lavaks@codeaurora.org>
Subject: [PATCH] ath11k: send proper txpower and maxregpower values to firmware
Date:   Mon, 25 Oct 2021 17:47:09 +0530
Message-ID: <1635164229-22880-1-git-send-email-quic_ppranees@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Set proper values for max_regpower, max_power, max_antenna_gain as it
is because firmware will convert power values to 0.5dbm steps by
multiplying it with 2.

If txpower is not set, it will lead to cca stuck resulting in latency
issues for QCN9074.

Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.4.0.1-01386-QCAHKSWPL_SILICONZ-1

Co-developed-by: Lavanya Suresh <lavaks@codeaurora.org>
Signed-off-by: Lavanya Suresh <lavaks@codeaurora.org>
Signed-off-by: P Praneesh <quic_ppranees@quicinc.com>
---
Depends-on: "ath11k: Add ROC support for wide band scan"
---
 drivers/net/wireless/ath/ath11k/mac.c | 12 ++++++------
 drivers/net/wireless/ath/ath11k/wmi.c |  2 ++
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 3d197d8..e0dae04 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -775,9 +775,9 @@ static int ath11k_mac_monitor_vdev_start(struct ath11k *ar, int vdev_id,
 	arg.channel.chan_radar = !!(channel->flags & IEEE80211_CHAN_RADAR);
 
 	arg.channel.min_power = 0;
-	arg.channel.max_power = channel->max_power * 2;
-	arg.channel.max_reg_power = channel->max_reg_power * 2;
-	arg.channel.max_antenna_gain = channel->max_antenna_gain * 2;
+	arg.channel.max_power = channel->max_power;
+	arg.channel.max_reg_power = channel->max_reg_power;
+	arg.channel.max_antenna_gain = channel->max_antenna_gain;
 
 	arg.pref_tx_streams = ar->num_tx_chains;
 	arg.pref_rx_streams = ar->num_rx_chains;
@@ -6127,9 +6127,9 @@ ath11k_mac_vdev_start_restart(struct ath11k_vif *arvif,
 		ath11k_phymodes[chandef->chan->band][chandef->width];
 
 	arg.channel.min_power = 0;
-	arg.channel.max_power = chandef->chan->max_power * 2;
-	arg.channel.max_reg_power = chandef->chan->max_reg_power * 2;
-	arg.channel.max_antenna_gain = chandef->chan->max_antenna_gain * 2;
+	arg.channel.max_power = chandef->chan->max_power;
+	arg.channel.max_reg_power = chandef->chan->max_reg_power;
+	arg.channel.max_antenna_gain = chandef->chan->max_antenna_gain;
 
 	arg.pref_tx_streams = ar->num_tx_chains;
 	arg.pref_rx_streams = ar->num_rx_chains;
diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index c428a025..242990e 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -2535,6 +2535,8 @@ int ath11k_wmi_send_scan_chan_list_cmd(struct ath11k *ar,
 					    tchan_info->reg_class_id);
 			*reg2 |= FIELD_PREP(WMI_CHAN_REG_INFO2_ANT_MAX,
 					    tchan_info->antennamax);
+			*reg2 |= FIELD_PREP(WMI_CHAN_REG_INFO2_MAX_TX_PWR,
+					    tchan_info->maxregpower);
 
 			ath11k_dbg(ar->ab, ATH11K_DBG_WMI,
 				   "WMI chan scan list chan[%d] = %u, chan_info->info %8x\n",
-- 
2.7.4

