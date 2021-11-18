Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34A0D455875
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Nov 2021 10:59:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245411AbhKRKCn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 18 Nov 2021 05:02:43 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:30077 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245399AbhKRKCU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 18 Nov 2021 05:02:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1637229561; x=1668765561;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=QoWGoOyQvErGWgrbmuo0CNtxStgDp/nC3/B7aJLxAns=;
  b=oQs66it9cOQ9mNV2ZPysGvjRkOnoVLWY93nZaJDOKtFaaxEvq3sTll4T
   SiB19JrNofHlukIL5hEamz/dd0txq9sAZGeSmhVS7GLBH+zAu+VGIFk5s
   f8hAFgsZe+9za3JSzCtHSfDCWZcaRMPeEJJ2vTIqtKk2+DYBRGeFAQEQa
   4=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 18 Nov 2021 01:59:18 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2021 01:59:17 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 18 Nov 2021 01:59:16 -0800
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 18 Nov 2021 01:59:15 -0800
From:   Wen Gong <quic_wgong@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <quic_wgong@quicinc.com>
Subject: [PATCH v2] ath11k: skip sending vdev down for channel switch
Date:   Thu, 18 Nov 2021 04:59:01 -0500
Message-ID: <20211118095901.8271-1-quic_wgong@quicinc.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The ath11k driver currently sends vdev down to the firmware before
updating the channel context, which is followed by a vdev restart
command.

Sending vdev down is not required before sending a vdev restart,
because the firmware internally does vdev down when ath11k sends
a vdev restart command.

Firmware will happen crash while channel switch without this change.

Hence skip the vdev down command sending when updating the channel
context and then fix the firmware crash issue.

Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1

Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
---
v2: rebased to latest ath.git master ath-202111170737

 drivers/net/wireless/ath/ath11k/mac.c | 32 +--------------------------
 1 file changed, 1 insertion(+), 31 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 292b2b7eab11..fe03836c9a84 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -6363,37 +6363,7 @@ ath11k_mac_update_vif_chan(struct ath11k *ar,
 
 	lockdep_assert_held(&ar->conf_mutex);
 
-	for (i = 0; i < n_vifs; i++) {
-		arvif = (void *)vifs[i].vif->drv_priv;
-
-		if (vifs[i].vif->type == NL80211_IFTYPE_MONITOR)
-			monitor_vif = true;
-
-		ath11k_dbg(ab, ATH11K_DBG_MAC,
-			   "mac chanctx switch vdev_id %i freq %u->%u width %d->%d\n",
-			   arvif->vdev_id,
-			   vifs[i].old_ctx->def.chan->center_freq,
-			   vifs[i].new_ctx->def.chan->center_freq,
-			   vifs[i].old_ctx->def.width,
-			   vifs[i].new_ctx->def.width);
-
-		if (WARN_ON(!arvif->is_started))
-			continue;
-
-		if (WARN_ON(!arvif->is_up))
-			continue;
-
-		ret = ath11k_wmi_vdev_down(ar, arvif->vdev_id);
-		if (ret) {
-			ath11k_warn(ab, "failed to down vdev %d: %d\n",
-				    arvif->vdev_id, ret);
-			continue;
-		}
-
-		ar->num_started_vdevs--;
-	}
-
-	/* All relevant vdevs are downed and associated channel resources
+	/* Associated channel resources of all relevant vdevs
 	 * should be available for the channel switch now.
 	 */
 

base-commit: 63ec871bc50a306aac550e2d85f697ca2d5f5deb
-- 
2.31.1

