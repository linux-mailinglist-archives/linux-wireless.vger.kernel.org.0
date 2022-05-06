Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68F8951CE2A
	for <lists+linux-wireless@lfdr.de>; Fri,  6 May 2022 04:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387960AbiEFBkL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 May 2022 21:40:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381611AbiEFBkJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 May 2022 21:40:09 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B29F75DBE3
        for <linux-wireless@vger.kernel.org>; Thu,  5 May 2022 18:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1651800988; x=1683336988;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pq9AoO2HdkTPAhbDQ8F6/vYfYQzav5wkkjwhVZBACzE=;
  b=bjV0Of6vKcg/oFN/hXG79JoIOY4gkOXkR7RtfXbCwEYrX7no5Wkoc6U3
   YtSHiaqupuB75k76h4ctbM28vSHgdbqY7oUAJ/WtHw7GxGVPP9tZWXFmi
   RHR2bBtg4ARWjeyyOY5wbOoIYuTc25VQSMHSOF3mDNbrq6Tf9dyvqBvgV
   g=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 05 May 2022 18:36:28 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2022 18:36:28 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 5 May 2022 18:36:28 -0700
Received: from bqiang-Celadon-RN.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 5 May 2022 18:36:26 -0700
From:   Baochen Qiang <quic_bqiang@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 2/3] ath11k: Don't check arvif->is_started before sending management frames
Date:   Fri, 6 May 2022 09:36:13 +0800
Message-ID: <20220506013614.1580274-3-quic_bqiang@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220506013614.1580274-1-quic_bqiang@quicinc.com>
References: <20220506013614.1580274-1-quic_bqiang@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Commit 66307ca04057 ("ath11k: fix mgmt_tx_wmi cmd sent to FW for
deleted vdev") wants both of below two conditions are true before
sending management frames:

1: ar->allocated_vdev_map & (1LL << arvif->vdev_id)
2: arvif->is_started

Actually the second one is not necessary because with the first one
we can make sure the vdev is present.

Also use ar->conf_mutex to synchronize vdev delete and mgmt. TX.

This issue is found in case of Passpoint scenario where ath11k
needs to send action frames before vdev is started.

Fix it by removing the second condition.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1

Fixes: 66307ca04057 ("ath11k: fix mgmt_tx_wmi cmd sent to FW for deleted vdev")
Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
---
v2:
 1. s/cause/because in commit log

 drivers/net/wireless/ath/ath11k/mac.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 6e6b8562b481..db6a38b98765 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -5551,8 +5551,8 @@ static void ath11k_mgmt_over_wmi_tx_work(struct work_struct *work)
 		}
 
 		arvif = ath11k_vif_to_arvif(skb_cb->vif);
-		if (ar->allocated_vdev_map & (1LL << arvif->vdev_id) &&
-		    arvif->is_started) {
+		mutex_lock(&ar->conf_mutex);
+		if (ar->allocated_vdev_map & (1LL << arvif->vdev_id)) {
 			ret = ath11k_mac_mgmt_tx_wmi(ar, arvif, skb);
 			if (ret) {
 				ath11k_warn(ar->ab, "failed to tx mgmt frame, vdev_id %d :%d\n",
@@ -5570,6 +5570,7 @@ static void ath11k_mgmt_over_wmi_tx_work(struct work_struct *work)
 				    arvif->is_started);
 			ath11k_mgmt_over_wmi_tx_drop(ar, skb);
 		}
+		mutex_unlock(&ar->conf_mutex);
 	}
 }
 
-- 
2.25.1

