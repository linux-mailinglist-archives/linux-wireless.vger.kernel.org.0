Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 707EB1FB343
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jun 2020 16:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729237AbgFPOBu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 16 Jun 2020 10:01:50 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:22812 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729253AbgFPOBq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 16 Jun 2020 10:01:46 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1592316106; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=+T7oOKfPWdhKt+kt4ZFX6NX78mRFapYCcTvo2dTViPQ=; b=oT998LNWpy+/p7aiVvQ1YT1rMzYXJ1a4MjzoeXbcfxY5oRfUrVd6q/m0x5vH85lKXPS3N0Qn
 GLrh4H8UW1TBmBbVcUZVwLFAsftPuCDScq1hgYDBRIWro6RbiyubF3x8/3Us3kFkSWKtclbq
 9ld8ibwREsQW/mqTyjupWj6PMZs=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n13.prod.us-west-2.postgun.com with SMTP id
 5ee8d0b0e144dd5115ff622b (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 16 Jun 2020 14:01:20
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id DC81DC43395; Tue, 16 Jun 2020 14:01:19 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 25182C433CB;
        Tue, 16 Jun 2020 14:01:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 25182C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH 09/12] ath11k: remove useless info messages
Date:   Tue, 16 Jun 2020 17:00:52 +0300
Message-Id: <1592316055-24958-10-git-send-email-kvalo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1592316055-24958-1-git-send-email-kvalo@codeaurora.org>
References: <1592316055-24958-1-git-send-email-kvalo@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

ath11k should not be spamming these to the logs. If these are important they
should be debug messages, but I just remove them for now.

Compile tested only.

Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/mac.c      | 8 --------
 drivers/net/wireless/ath/ath11k/peer.c     | 3 ---
 drivers/net/wireless/ath/ath11k/qmi.c      | 1 -
 drivers/net/wireless/ath/ath11k/spectral.c | 8 ++------
 4 files changed, 2 insertions(+), 18 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index cdedb2ea7d87..0fd1f714429c 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -3039,10 +3039,6 @@ static int ath11k_mac_op_sta_state(struct ieee80211_hw *hw,
 		if (ret)
 			ath11k_warn(ar->ab, "Failed to associate station: %pM\n",
 				    sta->addr);
-		else
-			ath11k_info(ar->ab,
-				    "Station %pM moved to assoc state\n",
-				    sta->addr);
 	} else if (old_state == IEEE80211_STA_ASSOC &&
 		   new_state == IEEE80211_STA_AUTH &&
 		   (vif->type == NL80211_IFTYPE_AP ||
@@ -3052,10 +3048,6 @@ static int ath11k_mac_op_sta_state(struct ieee80211_hw *hw,
 		if (ret)
 			ath11k_warn(ar->ab, "Failed to disassociate station: %pM\n",
 				    sta->addr);
-		else
-			ath11k_info(ar->ab,
-				    "Station %pM moved to disassociated state\n",
-				    sta->addr);
 	}
 
 	mutex_unlock(&ar->conf_mutex);
diff --git a/drivers/net/wireless/ath/ath11k/peer.c b/drivers/net/wireless/ath/ath11k/peer.c
index 297172538620..61ad9300eafb 100644
--- a/drivers/net/wireless/ath/ath11k/peer.c
+++ b/drivers/net/wireless/ath/ath11k/peer.c
@@ -223,9 +223,6 @@ int ath11k_peer_create(struct ath11k *ar, struct ath11k_vif *arvif,
 	peer = ath11k_peer_find_by_pdev_idx(ar->ab, ar->pdev_idx, param->peer_addr);
 	if (peer) {
 		spin_unlock_bh(&ar->ab->base_lock);
-		ath11k_info(ar->ab,
-			    "ignoring the peer %pM creation on same pdev idx %d\n",
-			    param->peer_addr, ar->pdev_idx);
 		return -EINVAL;
 	}
 	spin_unlock_bh(&ar->ab->base_lock);
diff --git a/drivers/net/wireless/ath/ath11k/qmi.c b/drivers/net/wireless/ath/ath11k/qmi.c
index d9ffdf84ccae..bbdbf1ed19dc 100644
--- a/drivers/net/wireless/ath/ath11k/qmi.c
+++ b/drivers/net/wireless/ath/ath11k/qmi.c
@@ -1901,7 +1901,6 @@ static int ath11k_qmi_load_bdf(struct ath11k_base *ab)
 			goto out_qmi_bdf;
 		}
 	}
-	ath11k_info(ab, "qmi BDF downloaded\n");
 
 out_qmi_bdf:
 	iounmap(bdf_addr);
diff --git a/drivers/net/wireless/ath/ath11k/spectral.c b/drivers/net/wireless/ath/ath11k/spectral.c
index 1c5d65bb411f..6cbe6f4e2864 100644
--- a/drivers/net/wireless/ath/ath11k/spectral.c
+++ b/drivers/net/wireless/ath/ath11k/spectral.c
@@ -954,10 +954,8 @@ int ath11k_spectral_init(struct ath11k_base *ab)
 	int i;
 
 	if (!test_bit(WMI_TLV_SERVICE_FREQINFO_IN_METADATA,
-		      ab->wmi_ab.svc_map)) {
-		ath11k_info(ab, "spectral not supported\n");
+		      ab->wmi_ab.svc_map))
 		return 0;
-	}
 
 	for (i = 0; i < ab->num_radios; i++) {
 		ar = ab->pdevs[i].ar;
@@ -966,10 +964,8 @@ int ath11k_spectral_init(struct ath11k_base *ab)
 		ret = ath11k_dbring_get_cap(ar->ab, ar->pdev_idx,
 					    WMI_DIRECT_BUF_SPECTRAL,
 					    &db_cap);
-		if (ret) {
-			ath11k_info(ab, "spectral not enabled for pdev %d\n", i);
+		if (ret)
 			continue;
-		}
 
 		idr_init(&sp->rx_ring.bufs_idr);
 		spin_lock_init(&sp->rx_ring.idr_lock);
-- 
2.7.4

