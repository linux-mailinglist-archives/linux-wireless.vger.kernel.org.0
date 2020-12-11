Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E82472D6F8C
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Dec 2020 06:17:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728856AbgLKFPQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 11 Dec 2020 00:15:16 -0500
Received: from so254-31.mailgun.net ([198.61.254.31]:24354 "EHLO
        so254-31.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728576AbgLKFOw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 11 Dec 2020 00:14:52 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1607663671; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=1hoc8+xReSH4IwL1/xbLMJY3qV/59fymcfM18m96A5M=; b=PzAcXjC6J4r/ObRxfCvioK/1/hsFtvY/skkiF4jUA6tEuD8rtSBM56n9alw7i/mdc0ZWfhTi
 S+SAcxWnB1GSE+8UaTLwzgEcf3dkOFHj38JoLZw9+dta+7+yzSJP+5tmdJRsBAhA49+jG337
 /7rjezvqOYqvAIzBmZuklW4rICY=
X-Mailgun-Sending-Ip: 198.61.254.31
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 5fd3001d6752249c549ecbe0 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 11 Dec 2020 05:14:05
 GMT
Sender: cjhuang=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 4F41CC433ED; Fri, 11 Dec 2020 05:14:04 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from cjhuang-Inspiron-7590.qca.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: cjhuang)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id ED434C433CA;
        Fri, 11 Dec 2020 05:14:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org ED434C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=cjhuang@codeaurora.org
From:   Carl Huang <cjhuang@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH] ath11k: start vdev if a bss peer is already created
Date:   Fri, 11 Dec 2020 00:13:58 -0500
Message-Id: <20201211051358.9191-1-cjhuang@codeaurora.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

For QCA6390, bss peer must be created before vdev is to start. This
change is to start vdev if a bss peer is created. Otherwise, ath11k
delays to start vdev.

This fixes an issue in a case where HT/VHT/HE settings change between
authentication and association, e.g., due to the user space request
to disable HT.

Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1

Signed-off-by: Carl Huang <cjhuang@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/mac.c  |  8 ++++++--
 drivers/net/wireless/ath/ath11k/peer.c | 17 +++++++++++++++++
 drivers/net/wireless/ath/ath11k/peer.h |  2 ++
 3 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index c3072b5005f8..0c27cd7929a7 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -2986,6 +2986,7 @@ static int ath11k_mac_station_add(struct ath11k *ar,
 	}
 
 	if (ab->hw_params.vdev_start_delay &&
+	    !arvif->is_started &&
 	    arvif->vdev_type != WMI_VDEV_TYPE_AP) {
 		ret = ath11k_start_vdev_delay(ar->hw, vif);
 		if (ret) {
@@ -5255,7 +5256,8 @@ ath11k_mac_op_assign_vif_chanctx(struct ieee80211_hw *hw,
 	/* for QCA6390 bss peer must be created before vdev_start */
 	if (ab->hw_params.vdev_start_delay &&
 	    arvif->vdev_type != WMI_VDEV_TYPE_AP &&
-	    arvif->vdev_type != WMI_VDEV_TYPE_MONITOR) {
+	    arvif->vdev_type != WMI_VDEV_TYPE_MONITOR &&
+	    !ath11k_peer_find_by_vdev_id(ab, arvif->vdev_id)) {
 		memcpy(&arvif->chanctx, ctx, sizeof(*ctx));
 		mutex_unlock(&ar->conf_mutex);
 		return 0;
@@ -5266,7 +5268,9 @@ ath11k_mac_op_assign_vif_chanctx(struct ieee80211_hw *hw,
 		return -EBUSY;
 	}
 
-	if (ab->hw_params.vdev_start_delay) {
+	if (ab->hw_params.vdev_start_delay &&
+	    (arvif->vdev_type == WMI_VDEV_TYPE_AP ||
+	    arvif->vdev_type == WMI_VDEV_TYPE_MONITOR)) {
 		param.vdev_id = arvif->vdev_id;
 		param.peer_type = WMI_PEER_TYPE_DEFAULT;
 		param.peer_addr = ar->mac_addr;
diff --git a/drivers/net/wireless/ath/ath11k/peer.c b/drivers/net/wireless/ath/ath11k/peer.c
index 1866d82678fa..b69e7ebfa930 100644
--- a/drivers/net/wireless/ath/ath11k/peer.c
+++ b/drivers/net/wireless/ath/ath11k/peer.c
@@ -76,6 +76,23 @@ struct ath11k_peer *ath11k_peer_find_by_id(struct ath11k_base *ab,
 	return NULL;
 }
 
+struct ath11k_peer *ath11k_peer_find_by_vdev_id(struct ath11k_base *ab,
+						int vdev_id)
+{
+	struct ath11k_peer *peer;
+
+	spin_lock_bh(&ab->base_lock);
+
+	list_for_each_entry(peer, &ab->peers, list) {
+		if (vdev_id == peer->vdev_id) {
+			spin_unlock_bh(&ab->base_lock);
+			return peer;
+		}
+	}
+	spin_unlock_bh(&ab->base_lock);
+	return NULL;
+}
+
 void ath11k_peer_unmap_event(struct ath11k_base *ab, u16 peer_id)
 {
 	struct ath11k_peer *peer;
diff --git a/drivers/net/wireless/ath/ath11k/peer.h b/drivers/net/wireless/ath/ath11k/peer.h
index bba2e00b6944..8553ed061aea 100644
--- a/drivers/net/wireless/ath/ath11k/peer.h
+++ b/drivers/net/wireless/ath/ath11k/peer.h
@@ -43,5 +43,7 @@ int ath11k_peer_create(struct ath11k *ar, struct ath11k_vif *arvif,
 		       struct ieee80211_sta *sta, struct peer_create_params *param);
 int ath11k_wait_for_peer_delete_done(struct ath11k *ar, u32 vdev_id,
 				     const u8 *addr);
+struct ath11k_peer *ath11k_peer_find_by_vdev_id(struct ath11k_base *ab,
+						int vdev_id);
 
 #endif /* _PEER_H_ */
-- 
2.25.1

