Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA964AF3D5
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Feb 2022 15:14:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234858AbiBIONv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Feb 2022 09:13:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233904AbiBIONt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Feb 2022 09:13:49 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B69E5C0612BE
        for <linux-wireless@vger.kernel.org>; Wed,  9 Feb 2022 06:13:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644416032; x=1675952032;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=mWjJdHYODbZPfvSGWhcZc8pUvzmhPRg5+wfmSCaUo1A=;
  b=I0OnsYzQ3TsOeGGLkWL6lZwlAhujZ5HQyrn9Zv+F7b2BT5GQor+SU/5L
   3WrkeZqdLJzb5wkHyfzcTd6Or5RGJrI4NRWrrhTPdG4svLhQJ67bzcNBy
   nw1bmNL4Asvab3g4GMQYYn6CbCeBPEp3u57HsHB2fGX0q5tQFGx4rNSTY
   w=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 09 Feb 2022 06:13:52 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 06:13:52 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 9 Feb 2022 06:13:51 -0800
Received: from vnaralas-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 9 Feb 2022 06:13:50 -0800
From:   Venkateswara Naralasetty <quic_vnaralas@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Venkateswara Naralasetty <quic_vnaralas@quicinc.com>
Subject: [PATCH 1/2] ath11k: fix WARN_ON during ath11k_mac_update_vif_chan
Date:   Wed, 9 Feb 2022 19:43:38 +0530
Message-ID: <1644416019-820-1-git-send-email-quic_vnaralas@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
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

Fix WARN_ON() from ath11k_mac_update_vif_chan() if vdev is not up.
Since change_chanctx can be called even before vdev_up from
ieee80211_start_ap->ieee80211_vif_use_channel->
ieee80211_recalc_radar_chanctx.

Do vdev stop followed by a vdev start in case of vdev is down.

Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.5.0.1-01100-QCAHKSWPL_SILICONZ-1

Signed-off-by: Venkateswara Naralasetty <quic_vnaralas@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/mac.c | 32 ++++++++++++++++++++++++++------
 1 file changed, 26 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index ed89905..d5922a0 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -6856,13 +6856,33 @@ ath11k_mac_update_vif_chan(struct ath11k *ar,
 		if (WARN_ON(!arvif->is_started))
 			continue;
 
-		if (WARN_ON(!arvif->is_up))
-			continue;
+		/* change_chanctx can be called even before vdev_up from
+		 * ieee80211_start_ap->ieee80211_vif_use_channel->
+		 * ieee80211_recalc_radar_chanctx.
+		 *
+		 * Firmware expect vdev_restart only if vdev is up.
+		 * If vdev is down then it expect vdev_stop->vdev_start.
+		 */
+		if (arvif->is_up) {
+			ret = ath11k_mac_vdev_restart(arvif, &vifs[i].new_ctx->def);
+			if (ret) {
+				ath11k_warn(ab, "failed to restart vdev %d: %d\n",
+					    arvif->vdev_id, ret);
+				continue;
+			}
+		} else {
+			ret = ath11k_mac_vdev_stop(arvif);
+			if (ret) {
+				ath11k_warn(ab, "failed to stop vdev %d: %d\n",
+					    arvif->vdev_id, ret);
+				continue;
+			}
+
+			ret = ath11k_mac_vdev_start(arvif, &vifs[i].new_ctx->def);
+			if (ret)
+				ath11k_warn(ab, "failed to start vdev %d: %d\n",
+					    arvif->vdev_id, ret);
 
-		ret = ath11k_mac_vdev_restart(arvif, &vifs[i].new_ctx->def);
-		if (ret) {
-			ath11k_warn(ab, "failed to restart vdev %d: %d\n",
-				    arvif->vdev_id, ret);
 			continue;
 		}
 
-- 
2.7.4

