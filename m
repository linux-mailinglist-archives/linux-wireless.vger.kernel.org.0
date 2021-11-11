Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0659E44D91A
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Nov 2021 16:20:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233823AbhKKPXI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 11 Nov 2021 10:23:08 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:18789 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233766AbhKKPXG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 11 Nov 2021 10:23:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1636644017; x=1668180017;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=3WhpqACNKff6MmXV5dNtvRocnnTl8mlXto095kLFgik=;
  b=MvIswYtZgp64ZZecaBvaziXpQYO9IuDOLq1SyZJPq51Sho7Gnnj/NGhf
   OUsiNOskDJn1k8H+P4vErxWIaj40/qkA98wHGeKYMH6EEbDprS6uVcX39
   55JLureGA9eNfwIyUz0EaCuUNa0IWuyJGIGJINQ6OQdnoLcXiLdqJUwCa
   Q=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 11 Nov 2021 07:20:16 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2021 07:20:16 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.7;
 Thu, 11 Nov 2021 07:20:16 -0800
Received: from vnaralas-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 11 Nov 2021 07:20:14 -0800
From:   Venkateswara Naralasetty <quic_vnaralas@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Venkateswara Naralasetty <quic_vnaralas@quicinc.com>
Subject: [PATCH] ath11k: fix target assert during channel switch
Date:   Thu, 11 Nov 2021 20:50:02 +0530
Message-ID: <1636644002-25446-1-git-send-email-quic_vnaralas@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Currently the updated bandwidth for the peer will be configured
to the firmware after channel switch from the sta_rc_update_wk.
If the updated bandwidth is greater than the configured peer phymode
during the peer assoc may result target assert.

For example, initially AP is in HE40 mode and the peer phymode is
configured as MODE_11AX_HE40 during peer assoc. Now user change the
channel width to HE80 then, the peer bandwidth will be updated as
HE80 to the firmware.

This will trigger target assert due to peer bandwidth is greater than
the peer phymode.

Fix this issue by sending peer assoc command before setting the updated
peer bw to fw.

Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.5.0.1-01100-QCAHKSWPL_SILICONZ-1

Signed-off-by: Venkateswara Naralasetty <quic_vnaralas@quicinc.com>
---
Depends-on: "ath11k: Clear auth flag only for actual association in security mode"

 drivers/net/wireless/ath/ath11k/mac.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index eba8cee..2e2a8ad 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -3826,11 +3826,27 @@ static void ath11k_sta_rc_update_wk(struct work_struct *wk)
 			   ath11k_mac_max_he_nss(he_mcs_mask)));
 
 	if (changed & IEEE80211_RC_BW_CHANGED) {
-		err = ath11k_wmi_set_peer_param(ar, sta->addr, arvif->vdev_id,
-						WMI_PEER_CHWIDTH, bw);
-		if (err)
-			ath11k_warn(ar->ab, "failed to update STA %pM peer bw %d: %d\n",
-				    sta->addr, bw, err);
+		/* Send peer assoc command before set peer bandwidth param to
+		 * avoid the mismatch between the peer phymode and the peer
+		 * bandwidth.
+		 */
+		ath11k_peer_assoc_prepare(ar, arvif->vif, sta, &peer_arg, true);
+
+		peer_arg.is_assoc = false;
+		err = ath11k_wmi_send_peer_assoc_cmd(ar, &peer_arg);
+		if (err) {
+			ath11k_warn(ar->ab, "failed to send peer assoc for STA %pM vdev %i: %d\n",
+				    sta->addr, arvif->vdev_id, err);
+		} else if (wait_for_completion_timeout(&ar->peer_assoc_done, 1 * HZ)) {
+			err = ath11k_wmi_set_peer_param(ar, sta->addr, arvif->vdev_id,
+							WMI_PEER_CHWIDTH, bw);
+			if (err)
+				ath11k_warn(ar->ab, "failed to update STA %pM peer bw %d: %d\n",
+					    sta->addr, bw, err);
+		} else {
+			ath11k_warn(ar->ab, "failed to get peer assoc conf event for %pM vdev %i\n",
+				    sta->addr, arvif->vdev_id);
+		}
 	}
 
 	if (changed & IEEE80211_RC_NSS_CHANGED) {
-- 
2.7.4

