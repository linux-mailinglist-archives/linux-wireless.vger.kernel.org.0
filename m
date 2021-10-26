Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AFCB43B11A
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Oct 2021 13:20:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235515AbhJZLW0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 26 Oct 2021 07:22:26 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:47817 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234910AbhJZLWZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 26 Oct 2021 07:22:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1635247202; x=1666783202;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/VdXjZeertDBhheMPWEn+odbnDuSPrVDKp4B0qugQGw=;
  b=r6viQJzKSPubsqhVyhoYhvd9sqSi3KCJkoYbv2520C4pvze0TL9EisgI
   umGbmlVi7uPi7Nn8OmIZT631YY7h+Y4XjQlSQ/xn9o6hbrIDHRh0uODu3
   GYlifkdJwV/lTV838wIH4LLjU5sCphyUVIjgIvG2UxrAdb5qi+hxoFAOY
   c=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 26 Oct 2021 04:20:02 -0700
X-QCInternal: smtphost
Received: from nalasex01a.na.qualcomm.com ([10.47.209.196])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2021 04:20:02 -0700
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.7;
 Tue, 26 Oct 2021 04:20:00 -0700
From:   Wen Gong <quic_wgong@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <quic_wgong@quicinc.com>
Subject: [PATCH 10/15] ath11k: save max tx power in vdev start response event from firmware
Date:   Tue, 26 Oct 2021 07:19:08 -0400
Message-ID: <20211026111913.7346-11-quic_wgong@quicinc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211026111913.7346-1-quic_wgong@quicinc.com>
References: <20211026111913.7346-1-quic_wgong@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Save the max tx power received in the vdev start response event from
firmware. A subsequent patch will use this to calculate the final power
value for WMI_VDEV_SET_TPC_POWER_CMDID.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1

Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/core.h | 1 +
 drivers/net/wireless/ath/ath11k/wmi.c  | 3 ++-
 drivers/net/wireless/ath/ath11k/wmi.h  | 1 +
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index 94516d14f89b..6969e0a6fc7b 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -605,6 +605,7 @@ struct ath11k {
 #endif
 	bool dfs_block_radar_events;
 	struct ath11k_thermal thermal;
+	s8 max_allowed_tx_power;
 };
 
 struct ath11k_band_cap {
diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index 2684c042bbad..985035fab744 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -4484,6 +4484,7 @@ static int ath11k_pull_vdev_start_resp_tlv(struct ath11k_base *ab, struct sk_buf
 	vdev_rsp->mac_id = ev->mac_id;
 	vdev_rsp->cfgd_tx_streams = ev->cfgd_tx_streams;
 	vdev_rsp->cfgd_rx_streams = ev->cfgd_rx_streams;
+	vdev_rsp->max_allowed_tx_power = ev->max_allowed_tx_power;
 
 	kfree(tb);
 	return 0;
@@ -6655,7 +6656,7 @@ static void ath11k_vdev_start_resp_event(struct ath11k_base *ab, struct sk_buff
 	}
 
 	ar->last_wmi_vdev_start_status = 0;
-
+	ar->max_allowed_tx_power = vdev_start_resp.max_allowed_tx_power;
 	status = vdev_start_resp.status;
 
 	if (WARN_ON_ONCE(status)) {
diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
index c62c9e1982ce..2fc48aa662c6 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -3975,6 +3975,7 @@ struct wmi_vdev_start_resp_event {
 	};
 	u32 cfgd_tx_streams;
 	u32 cfgd_rx_streams;
+	s32 max_allowed_tx_power;
 } __packed;
 
 /* VDEV start response status codes */
-- 
2.31.1

