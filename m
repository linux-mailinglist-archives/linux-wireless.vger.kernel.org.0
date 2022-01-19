Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60163493D08
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Jan 2022 16:23:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355710AbiASPXe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 19 Jan 2022 10:23:34 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:10456 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1355706AbiASPXd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 19 Jan 2022 10:23:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1642605813; x=1674141813;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=WSAhAGkz0RGiwr+44Zh5fWkCgOy3QtsalCwavtqWhpk=;
  b=xeEe+yIfYa1JP4At/FTO/2vdaf33dDo7J54J3FZSCF3CCxClANXkaeHm
   0j0dG6MJkTqfcxBb3OlnBX6L0f1FfleXEQ2c/Az76NIn0UjEpZyIDXtKm
   fy3shquhhocC3jrgaXSOBVQtA55wFXMNnPyIHdZOgBxUGTSYwmA2Q8aLq
   E=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 19 Jan 2022 07:23:33 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2022 07:23:33 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 19 Jan 2022 07:23:32 -0800
Received: from akolli-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 19 Jan 2022 07:23:30 -0800
From:   Anilkumar Kolli <quic_akolli@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Anilkumar Kolli <quic_akolli@quicinc.com>
Subject: [PATCH] ath11k: Fix uninitialized symbol 'rx_buf_sz'
Date:   Wed, 19 Jan 2022 20:53:13 +0530
Message-ID: <1642605793-13518-1-git-send-email-quic_akolli@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add missing else statement in ath11k_dp_rx_process_mon_status()
to fix below smatch warnings,
    drivers/net/wireless/ath/ath11k/dp_rx.c:3105
    ath11k_dp_rx_process_mon_status()
    error: uninitialized symbol 'rx_buf_sz'.

Fixes: ab18e3bc1c13 ("ath11k: Fix pktlog lite rx events")

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Anilkumar Kolli <quic_akolli@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/debugfs.h | 1 +
 drivers/net/wireless/ath/ath11k/dp_rx.c   | 7 +++++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/debugfs.h b/drivers/net/wireless/ath/ath11k/debugfs.h
index 4c0740394c95..71525d786bdf 100644
--- a/drivers/net/wireless/ath/ath11k/debugfs.h
+++ b/drivers/net/wireless/ath/ath11k/debugfs.h
@@ -88,6 +88,7 @@ enum ath11k_pktlog_mode {
 };
 
 enum ath11k_pktlog_enum {
+	ATH11K_PKTLOG_TYPE_INVALID      = 0,
 	ATH11K_PKTLOG_TYPE_TX_CTRL      = 1,
 	ATH11K_PKTLOG_TYPE_TX_STAT      = 2,
 	ATH11K_PKTLOG_TYPE_TX_MSDU_ID   = 3,
diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index 89b77b94bb20..99dc9b5bbf4b 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -5054,7 +5054,7 @@ int ath11k_dp_rx_process_mon_status(struct ath11k_base *ab, int mac_id,
 	struct ath11k_sta *arsta;
 	int num_buffs_reaped = 0;
 	u32 rx_buf_sz;
-	u16 log_type = 0;
+	u16 log_type;
 	struct ath11k_mon_data *pmon = (struct ath11k_mon_data *)&ar->dp.mon_data;
 	struct ath11k_pdev_mon_stats *rx_mon_stats = &pmon->rx_mon_stats;
 	struct hal_rx_mon_ppdu_info *ppdu_info = &pmon->mon_ppdu_info;
@@ -5076,9 +5076,12 @@ int ath11k_dp_rx_process_mon_status(struct ath11k_base *ab, int mac_id,
 		} else if (ath11k_debugfs_is_pktlog_rx_stats_enabled(ar)) {
 			log_type = ATH11K_PKTLOG_TYPE_RX_STATBUF;
 			rx_buf_sz = DP_RX_BUFFER_SIZE;
+		} else {
+			log_type = ATH11K_PKTLOG_TYPE_INVALID;
+			rx_buf_sz = 0;
 		}
 
-		if (log_type)
+		if (log_type != ATH11K_PKTLOG_TYPE_INVALID)
 			trace_ath11k_htt_rxdesc(ar, skb->data, log_type, rx_buf_sz);
 
 		hal_status = ath11k_hal_rx_parse_mon_status(ab, ppdu_info, skb);
-- 
2.7.4

