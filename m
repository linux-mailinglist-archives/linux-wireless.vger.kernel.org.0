Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCD542B0078
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Nov 2020 08:44:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725981AbgKLHoZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 12 Nov 2020 02:44:25 -0500
Received: from m42-4.mailgun.net ([69.72.42.4]:63314 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725860AbgKLHoZ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 12 Nov 2020 02:44:25 -0500
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 5face7996c42d983b9233015 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 12 Nov 2020 07:43:21
 GMT
Sender: mkenna=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 9A2A3C433FF; Thu, 12 Nov 2020 07:43:20 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from ssreeela-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mkenna)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 700EBC433CB;
        Thu, 12 Nov 2020 07:43:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 700EBC433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=mkenna@codeaurora.org
From:   Maharaja Kennadyrajan <mkenna@codeaurora.org>
To:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Cc:     Ritesh Singh <ritesi@codeaurora.org>,
        Maharaja Kennadyrajan <mkenna@codeaurora.org>
Subject: [PATCH 3/3] ath11k: remove "ath11k_mac_get_ar_vdev_stop_status" references
Date:   Thu, 12 Nov 2020 13:13:00 +0530
Message-Id: <1605166980-29115-4-git-send-email-mkenna@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1605166980-29115-1-git-send-email-mkenna@codeaurora.org>
References: <1605166980-29115-1-git-send-email-mkenna@codeaurora.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ritesh Singh <ritesi@codeaurora.org>

Unused structure ath11k_vdev_stop_status is removed.
'ath11k_mac_get_ar_vdev_stop_status' api has been replaced
with 'ath11k_mac_get_ar_by_vdev_id' inside vdev_stopped_event.

Signed-off-by: Ritesh Singh <ritesi@codeaurora.org>
Signed-off-by: Maharaja Kennadyrajan <mkenna@codeaurora.org>
---

    V2: Rebased on latest ath.git TOT(Addressed Kalle's comment).

 drivers/net/wireless/ath/ath11k/core.h |  6 ------
 drivers/net/wireless/ath/ath11k/mac.c  | 36 ----------------------------------
 drivers/net/wireless/ath/ath11k/mac.h  |  2 --
 drivers/net/wireless/ath/ath11k/wmi.c  |  2 +-
 4 files changed, 1 insertion(+), 45 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index c7ce7c2..f2c05da 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -432,11 +432,6 @@ struct ath11k_per_peer_tx_stats {
 #define ATH11K_FLUSH_TIMEOUT (5 * HZ)
 #define ATH11K_VDEV_DELETE_TIMEOUT_HZ (5 * HZ)
 
-struct ath11k_vdev_stop_status {
-	bool stop_in_progress;
-	u32  vdev_id;
-};
-
 struct ath11k {
 	struct ath11k_base *ab;
 	struct ath11k_pdev *pdev;
@@ -512,7 +507,6 @@ struct ath11k {
 	struct completion install_key_done;
 
 	int last_wmi_vdev_start_status;
-	struct ath11k_vdev_stop_status vdev_stop_status;
 	struct completion vdev_setup_done;
 	struct completion vdev_delete_done;
 
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 10d83a9..29777bc 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -537,31 +537,6 @@ struct ath11k *ath11k_mac_get_ar_by_pdev_id(struct ath11k_base *ab, u32 pdev_id)
 	return NULL;
 }
 
-struct ath11k *ath11k_mac_get_ar_vdev_stop_status(struct ath11k_base *ab,
-						  u32 vdev_id)
-{
-	int i;
-	struct ath11k_pdev *pdev;
-	struct ath11k *ar;
-
-	for (i = 0; i < ab->num_radios; i++) {
-		pdev = rcu_dereference(ab->pdevs_active[i]);
-		if (pdev && pdev->ar) {
-			ar = pdev->ar;
-
-			spin_lock_bh(&ar->data_lock);
-			if (ar->vdev_stop_status.stop_in_progress &&
-			    ar->vdev_stop_status.vdev_id == vdev_id) {
-				ar->vdev_stop_status.stop_in_progress = false;
-				spin_unlock_bh(&ar->data_lock);
-				return ar;
-			}
-			spin_unlock_bh(&ar->data_lock);
-		}
-	}
-	return NULL;
-}
-
 static void ath11k_pdev_caps_update(struct ath11k *ar)
 {
 	struct ath11k_base *ab = ar->ab;
@@ -5024,13 +4999,6 @@ static int ath11k_mac_vdev_stop(struct ath11k_vif *arvif)
 
 	reinit_completion(&ar->vdev_setup_done);
 
-	spin_lock_bh(&ar->data_lock);
-
-	ar->vdev_stop_status.stop_in_progress = true;
-	ar->vdev_stop_status.vdev_id = arvif->vdev_id;
-
-	spin_unlock_bh(&ar->data_lock);
-
 	ret = ath11k_wmi_vdev_stop(ar, arvif->vdev_id);
 	if (ret) {
 		ath11k_warn(ar->ab, "failed to stop WMI vdev %i: %d\n",
@@ -5059,10 +5027,6 @@ static int ath11k_mac_vdev_stop(struct ath11k_vif *arvif)
 
 	return 0;
 err:
-	spin_lock_bh(&ar->data_lock);
-	ar->vdev_stop_status.stop_in_progress = false;
-	spin_unlock_bh(&ar->data_lock);
-
 	return ret;
 }
 
diff --git a/drivers/net/wireless/ath/ath11k/mac.h b/drivers/net/wireless/ath/ath11k/mac.h
index 0607479..597104a 100644
--- a/drivers/net/wireless/ath/ath11k/mac.h
+++ b/drivers/net/wireless/ath/ath11k/mac.h
@@ -137,8 +137,6 @@ struct ath11k_vif *ath11k_mac_get_arvif_by_vdev_id(struct ath11k_base *ab,
 						   u32 vdev_id);
 struct ath11k *ath11k_mac_get_ar_by_vdev_id(struct ath11k_base *ab, u32 vdev_id);
 struct ath11k *ath11k_mac_get_ar_by_pdev_id(struct ath11k_base *ab, u32 pdev_id);
-struct ath11k *ath11k_mac_get_ar_vdev_stop_status(struct ath11k_base *ab,
-						  u32 vdev_id);
 
 void ath11k_mac_drain_tx(struct ath11k *ar);
 void ath11k_mac_peer_cleanup_all(struct ath11k *ar);
diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index e374270..f6f7269 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -5856,7 +5856,7 @@ static void ath11k_vdev_stopped_event(struct ath11k_base *ab, struct sk_buff *sk
 	}
 
 	rcu_read_lock();
-	ar = ath11k_mac_get_ar_vdev_stop_status(ab, vdev_id);
+	ar = ath11k_mac_get_ar_by_vdev_id(ab, vdev_id);
 	if (!ar) {
 		ath11k_warn(ab, "invalid vdev id in vdev stopped ev %d",
 			    vdev_id);
-- 
2.7.4

