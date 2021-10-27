Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D703543C6CA
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Oct 2021 11:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241274AbhJ0JvT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 Oct 2021 05:51:19 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:36123 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241271AbhJ0JvT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 Oct 2021 05:51:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1635328134; x=1666864134;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=N4WIC0PYLvAwbctoYHTdFtMV3c7neUJd/qJhuebSOKc=;
  b=ATGegBWOSlm+ze8t/C2g/0B13/xXm2xrmgcjgyRPhdJkFSCFSEZT1/Is
   FewOzH3w06+TRu8ZoTFlboW3l2jGJkfIeN3FkIOtzLGT0onqsZsu4WjOd
   p/xrIEKSoAuoYrP/vZnZHf01Vu0KRgIScN4TQDmBu+43djUtRl9Hz9XLc
   o=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 27 Oct 2021 02:48:54 -0700
X-QCInternal: smtphost
Received: from nalasex01a.na.qualcomm.com ([10.47.209.196])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2021 02:48:54 -0700
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.7;
 Wed, 27 Oct 2021 02:48:51 -0700
From:   Wen Gong <quic_wgong@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <quic_wgong@quicinc.com>
Subject: [PATCH] ath11k: skip sending vdev down for channel switch
Date:   Wed, 27 Oct 2021 05:48:36 -0400
Message-ID: <20211027094836.12524-1-quic_wgong@quicinc.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
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
 drivers/net/wireless/ath/ath11k/mac.c | 27 +--------------------------
 1 file changed, 1 insertion(+), 26 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 9e7cffc4dffa..f0f71e9c6e94 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -5440,32 +5440,7 @@ ath11k_mac_update_vif_chan(struct ath11k *ar,
 
 	lockdep_assert_held(&ar->conf_mutex);
 
-	for (i = 0; i < n_vifs; i++) {
-		arvif = (void *)vifs[i].vif->drv_priv;
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
-	}
-
-	/* All relevant vdevs are downed and associated channel resources
+	/* Associated channel resources of all relevant vdevs
 	 * should be available for the channel switch now.
 	 */
 
-- 
2.31.1

