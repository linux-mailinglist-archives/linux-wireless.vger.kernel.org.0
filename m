Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0CB94C6244
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Feb 2022 05:54:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233041AbiB1Ezb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 27 Feb 2022 23:55:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbiB1Eza (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 27 Feb 2022 23:55:30 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F8B33A1AA
        for <linux-wireless@vger.kernel.org>; Sun, 27 Feb 2022 20:54:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1646024092; x=1677560092;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=CVVSFNNDEqLT4e1N5mE8Dw8bH2o3G0bbZNsm9kyaZSU=;
  b=P9pEFjZMBEneYEF/xHYZxio0bEe41JxwXQ9XP6pvmbWwt2JiwVWSaZFf
   E39llwPqGlZL3mXgx8Nb2YLaVxDwx4A53vLjVzp8hjrQj4GcogTDiH5dE
   GFPcu4Wh277ecQ+LUM552dX8qnu1Y2Hp8RzyvGIx6X7Z8VrL8xpp96y57
   Y=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 27 Feb 2022 20:54:51 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2022 20:54:51 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Sun, 27 Feb 2022 20:54:50 -0800
Received: from periyasa-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Sun, 27 Feb 2022 20:54:49 -0800
From:   Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Subject: [PATCH] ath11k: Refactor the peer delete
Date:   Mon, 28 Feb 2022 10:24:39 +0530
Message-ID: <1646024079-26391-1-git-send-email-quic_periyasa@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
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

Introduce new helper function for peer delete to reuse this logic
in all peer cleanup procedures. Found this in code review.
Also this change is applicable for all the platform.

Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.5.0.1-01067-QCAHKSWPL_SILICONZ-1

Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/mac.c  | 16 +++-------------
 drivers/net/wireless/ath/ath11k/peer.c | 31 ++++++++++++++++---------------
 2 files changed, 19 insertions(+), 28 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index d5b83f9..9e71eda 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -6364,22 +6364,12 @@ static int ath11k_mac_op_add_interface(struct ieee80211_hw *hw,
 
 err_peer_del:
 	if (arvif->vdev_type == WMI_VDEV_TYPE_AP) {
-		reinit_completion(&ar->peer_delete_done);
-
-		fbret = ath11k_wmi_send_peer_delete_cmd(ar, vif->addr,
-							arvif->vdev_id);
+		fbret = ath11k_peer_delete(ar, arvif->vdev_id, vif->addr);
 		if (fbret) {
-			ath11k_warn(ar->ab, "failed to delete peer vdev_id %d addr %pM\n",
-				    arvif->vdev_id, vif->addr);
+			ath11k_warn(ar->ab, "fallback fail to delete peer addr %pM vdev_id %d ret %d\n",
+				    vif->addr, arvif->vdev_id, fbret);
 			goto err;
 		}
-
-		fbret = ath11k_wait_for_peer_delete_done(ar, arvif->vdev_id,
-							 vif->addr);
-		if (fbret)
-			goto err;
-
-		ar->num_peers--;
 	}
 
 err_vdev_del:
diff --git a/drivers/net/wireless/ath/ath11k/peer.c b/drivers/net/wireless/ath/ath11k/peer.c
index 332886b..392985b 100644
--- a/drivers/net/wireless/ath/ath11k/peer.c
+++ b/drivers/net/wireless/ath/ath11k/peer.c
@@ -217,7 +217,7 @@ int ath11k_wait_for_peer_delete_done(struct ath11k *ar, u32 vdev_id,
 	return 0;
 }
 
-int ath11k_peer_delete(struct ath11k *ar, u32 vdev_id, u8 *addr)
+static int __ath11k_peer_delete(struct ath11k *ar, u32 vdev_id, const u8 *addr)
 {
 	int ret;
 
@@ -237,6 +237,19 @@ int ath11k_peer_delete(struct ath11k *ar, u32 vdev_id, u8 *addr)
 	if (ret)
 		return ret;
 
+	return 0;
+}
+
+int ath11k_peer_delete(struct ath11k *ar, u32 vdev_id, u8 *addr)
+{
+	int ret;
+
+	lockdep_assert_held(&ar->conf_mutex);
+
+	ret = __ath11k_peer_delete(ar, vdev_id, addr);
+	if (ret)
+		return ret;
+
 	ar->num_peers--;
 
 	return 0;
@@ -323,22 +336,10 @@ int ath11k_peer_create(struct ath11k *ar, struct ath11k_vif *arvif,
 	return 0;
 
 cleanup:
-	reinit_completion(&ar->peer_delete_done);
-
-	fbret = ath11k_wmi_send_peer_delete_cmd(ar, param->peer_addr,
-						param->vdev_id);
-	if (fbret) {
-		ath11k_warn(ar->ab, "failed to delete peer vdev_id %d addr %pM\n",
-			    param->vdev_id, param->peer_addr);
-		goto exit;
-	}
-
-	fbret = ath11k_wait_for_peer_delete_done(ar, param->vdev_id,
-						 param->peer_addr);
+	fbret = __ath11k_peer_delete(ar, param->vdev_id, param->peer_addr);
 	if (fbret)
-		ath11k_warn(ar->ab, "failed wait for peer %pM delete done id %d fallback ret %d\n",
+		ath11k_warn(ar->ab, "failed peer %pM delete vdev_id %d fallback ret %d\n",
 			    param->peer_addr, param->vdev_id, fbret);
 
-exit:
 	return ret;
 }
-- 
2.7.4

