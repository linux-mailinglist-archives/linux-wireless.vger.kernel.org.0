Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5EA92B3E51
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Nov 2020 09:10:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728057AbgKPIJn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 16 Nov 2020 03:09:43 -0500
Received: from z5.mailgun.us ([104.130.96.5]:11848 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727376AbgKPIJm (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 16 Nov 2020 03:09:42 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1605514182; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=4WBYGxr9OXnXfaRh/+n/ReKp1W/0hIpHLkqTouj1/o8=; b=Chf2/ysnyq6yv7Mfj9GSebXZbuHQLhKZx9KuuQPt3/WpirjQ1ZLosSd/Bu77s2VW6Q0OCXTx
 q0it/VoGS71PGaH30L6s6SZ3VljQOTmAeAIYQLssaZZsphovUKzrXjd3kzbL4yvkJkzFsOKr
 YFaQEShKycQZpGDkKQY4Fgq8tyw=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 5fb233ae37ede2253b9c538c (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 16 Nov 2020 08:09:18
 GMT
Sender: mkenna=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 8E0B6C43462; Mon, 16 Nov 2020 08:09:18 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from ssreeela-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mkenna)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 92A4CC433ED;
        Mon, 16 Nov 2020 08:09:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 92A4CC433ED
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=mkenna@codeaurora.org
From:   Maharaja Kennadyrajan <mkenna@codeaurora.org>
To:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Cc:     Ritesh Singh <ritesi@codeaurora.org>,
        Maharaja Kennadyrajan <mkenna@codeaurora.org>
Subject: [PATCH v3 3/3] ath11k: remove "ath11k_mac_get_ar_vdev_stop_status" references
Date:   Mon, 16 Nov 2020 13:39:03 +0530
Message-Id: <1605514143-17652-4-git-send-email-mkenna@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1605514143-17652-1-git-send-email-mkenna@codeaurora.org>
References: <1605514143-17652-1-git-send-email-mkenna@codeaurora.org>
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
    V3: Rebased on latest ath.git TOT & added correct version name
        in the subject name in the patches.
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

