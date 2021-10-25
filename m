Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E08D943960F
	for <lists+linux-wireless@lfdr.de>; Mon, 25 Oct 2021 14:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233131AbhJYMXh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 25 Oct 2021 08:23:37 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:43263 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233106AbhJYMXh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 25 Oct 2021 08:23:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1635164475; x=1666700475;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=gY2wVZzuowqwL8UzlbTf5gnOqtd/tFAkzwq2gcuIZ+c=;
  b=SItHv9KzMFAtKNh37LiwUnt7Uji0quQ25sEAhllRREjLHLQSOKkInu5A
   YDOzpEirdf+EqPCyWyoFy4Q26Wj781TzmUIxQZG7z29l2ypJlp7c7hOtB
   07+I6Q5wTb0k5w4pZkuXYryjhOpeyv+7q+IZ/LYwQMRkfBhDb8cFvZUnB
   Y=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 25 Oct 2021 05:21:15 -0700
X-QCInternal: smtphost
Received: from nalasex01a.na.qualcomm.com ([10.47.209.196])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2021 05:21:14 -0700
Received: from ppranees-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.7;
 Mon, 25 Oct 2021 05:21:12 -0700
From:   P Praneesh <quic_ppranees@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        P Praneesh <ppranees@codeaurora.org>,
        Lavanya Suresh <lavaks@codeaurora.org>
Subject: [PATCH] ath11k: Increment pending_mgmt_tx count before tx send invoke
Date:   Mon, 25 Oct 2021 17:50:31 +0530
Message-ID: <1635164431-27437-1-git-send-email-quic_ppranees@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: P Praneesh <ppranees@codeaurora.org>

There is a race condition whereby the tx completion handler can be invoked
before the 'num_pending_mgmt_tx" count is incremented. If that occurs, we
could get warning trace indicating that 'num_pending_mgmt_tx' is 0 (because
it was not yet incremented). Ideally, this trace should be seen only if
mgmt tx has not happened but tx completion is received, and it is not
expected in this race condition.

Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.4.0.1-01386-QCAHKSWPL_SILICONZ-1

Co-developed-by: Lavanya Suresh <lavaks@codeaurora.org>
Signed-off-by: Lavanya Suresh <lavaks@codeaurora.org>
Signed-off-by: P Praneesh <ppranees@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/mac.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 1cc5560..56f3208 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -5048,13 +5048,15 @@ static void ath11k_mgmt_over_wmi_tx_work(struct work_struct *work)
 		arvif = ath11k_vif_to_arvif(skb_cb->vif);
 		if (ar->allocated_vdev_map & (1LL << arvif->vdev_id) &&
 		    arvif->is_started) {
+			atomic_inc(&ar->num_pending_mgmt_tx);
 			ret = ath11k_mac_mgmt_tx_wmi(ar, arvif, skb);
 			if (ret) {
+				if (atomic_dec_if_positive(&ar->num_pending_mgmt_tx) < 0)
+					WARN_ON_ONCE(1);
+
 				ath11k_warn(ar->ab, "failed to tx mgmt frame, vdev_id %d :%d\n",
 					    arvif->vdev_id, ret);
 				ieee80211_free_txskb(ar->hw, skb);
-			} else {
-				atomic_inc(&ar->num_pending_mgmt_tx);
 			}
 		} else {
 			ath11k_warn(ar->ab,
-- 
2.7.4

