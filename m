Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C68621DCE07
	for <lists+linux-wireless@lfdr.de>; Thu, 21 May 2020 15:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729424AbgEUNb1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 May 2020 09:31:27 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:57697 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728208AbgEUNb1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 May 2020 09:31:27 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1590067886; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=x8ufmryuvoaiIxjJW3uzOILwM39qeoNc05NQTVgr0NI=; b=GpiwY6YrQC1JLcyeD6UbBuz1KvRyR9jlMEruuU1VJkf/NlY9vyA/JT0XGVxhlWSVC60H1i/I
 +l4sdbVH+pdJFjDIXW0EB2e/mWlEn9zn4iXMJfA46ucK6P2aPvf0FO6RT3SnJNN2ZeTfxp+s
 u8wQ5+VZCXzsN6SWlVPtx+9O5n8=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 5ec6829940528fe394780923 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 21 May 2020 13:31:05
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id EF66BC433C6; Thu, 21 May 2020 13:31:04 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from CHECSTP344574-LIN.qca.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mkenna)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1F824C433CA;
        Thu, 21 May 2020 13:31:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1F824C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=mkenna@codeaurora.org
From:   Maharaja Kennadyrajan <mkenna@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Ritesh Singh <ritesi@codeaurora.org>,
        Maharaja Kennadyrajan <mkenna@codeaurora.org>
Subject: [PATCH 3/3] ath11k: remove "ath11k_mac_get_ar_vdev_stop_status" references
Date:   Thu, 21 May 2020 19:00:29 +0530
Message-Id: <1590067829-26109-4-git-send-email-mkenna@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1590067829-26109-1-git-send-email-mkenna@codeaurora.org>
References: <1590067829-26109-1-git-send-email-mkenna@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ritesh Singh <ritesi@codeaurora.org>

Unused structure ath11k_vdev_stop_status is removed.
'ath11k_mac_get_ar_vdev_stop_status' api has been replaced
with 'ath11k_mac_get_ar_by_vdev_id' inside vdev_stopped_event.

Tested-on: IPQ8074 WLAN.HK.2.4.0.1-00009-QCAHKSWPL_SILICONZ-1

Signed-off-by: Ritesh Singh <ritesi@codeaurora.org>
Signed-off-by: Maharaja Kennadyrajan <mkenna@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/core.h |  6 ------
 drivers/net/wireless/ath/ath11k/mac.c  | 36 ----------------------------------
 drivers/net/wireless/ath/ath11k/mac.h  |  2 --
 drivers/net/wireless/ath/ath11k/wmi.c  |  2 +-
 4 files changed, 1 insertion(+), 45 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index 283846e..ef4c9e4 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -415,11 +415,6 @@ struct ath11k_per_peer_tx_stats {
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
@@ -494,7 +489,6 @@ struct ath11k {
 	struct completion install_key_done;
 
 	int last_wmi_vdev_start_status;
-	struct ath11k_vdev_stop_status vdev_stop_status;
 	struct completion vdev_setup_done;
 	struct completion vdev_delete_done;
 
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index a936bb6..ffaac779 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -452,31 +452,6 @@ struct ath11k *ath11k_mac_get_ar_by_pdev_id(struct ath11k_base *ab, u32 pdev_id)
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
@@ -4760,13 +4735,6 @@ static int ath11k_mac_vdev_stop(struct ath11k_vif *arvif)
 
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
@@ -4795,10 +4763,6 @@ static int ath11k_mac_vdev_stop(struct ath11k_vif *arvif)
 
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
index 7cc0fca..ff85957 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -5207,7 +5207,7 @@ static void ath11k_vdev_stopped_event(struct ath11k_base *ab, struct sk_buff *sk
 	}
 
 	rcu_read_lock();
-	ar = ath11k_mac_get_ar_vdev_stop_status(ab, vdev_id);
+	ar = ath11k_mac_get_ar_by_vdev_id(ab, vdev_id);
 	if (!ar) {
 		ath11k_warn(ab, "invalid vdev id in vdev stopped ev %d",
 			    vdev_id);
-- 
1.9.1

