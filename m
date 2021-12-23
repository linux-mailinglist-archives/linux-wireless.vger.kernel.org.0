Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6941847DFA3
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Dec 2021 08:34:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235223AbhLWHeC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Dec 2021 02:34:02 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:20594 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229965AbhLWHeB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Dec 2021 02:34:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1640244840; x=1671780840;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=IPgXqOrbVpxh2yy4NDqLsleSLik0IPZuiQ4C/w3cgu4=;
  b=Ots4Z9Wh3B8YodyA452DBk1iSC+WWFntScAMhYg8xAPVVxa+bPXmfN8Q
   +Z4UzBZPF3zerk1iGyGU2UKGh4fw52H8HICtOrqktywnVOUfS23bbRrXd
   h6ihu7ub7xbQsc5U3KO5oB+tgqIlGOpiqpoe4iDn00LbyzxUq0nNh7D5f
   E=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 22 Dec 2021 23:34:00 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2021 23:34:00 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 22 Dec 2021 23:33:59 -0800
Received: from periyasa-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 22 Dec 2021 23:33:58 -0800
From:   Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy <periyasa@codeaurora.org>
Subject: [PATCH] ath11k: Refactor the fallback routine when peer create fails
Date:   Thu, 23 Dec 2021 13:03:39 +0530
Message-ID: <1640244819-21183-1-git-send-email-quic_periyasa@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Karthikeyan Periyasamy <periyasa@codeaurora.org>

When there is an error in peer create process from
ath11k_peer_find(), the code attempts to handle a fallback
for peer create. When this fallback fails, the driver returns
the fallback return code rather than actual error code
(-ENOENT). So refactor the fallback routine to return
the actual error code.

Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.5.0.1-01067-QCAHKSWPL_SILICONZ-1

Signed-off-by: Karthikeyan Periyasamy <periyasa@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/peer.c | 40 +++++++++++++++++++---------------
 1 file changed, 23 insertions(+), 17 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/peer.c b/drivers/net/wireless/ath/ath11k/peer.c
index 85471f8..332886b 100644
--- a/drivers/net/wireless/ath/ath11k/peer.c
+++ b/drivers/net/wireless/ath/ath11k/peer.c
@@ -252,7 +252,7 @@ int ath11k_peer_create(struct ath11k *ar, struct ath11k_vif *arvif,
 {
 	struct ath11k_peer *peer;
 	struct ath11k_sta *arsta;
-	int ret;
+	int ret, fbret;
 
 	lockdep_assert_held(&ar->conf_mutex);
 
@@ -291,22 +291,8 @@ int ath11k_peer_create(struct ath11k *ar, struct ath11k_vif *arvif,
 		ath11k_warn(ar->ab, "failed to find peer %pM on vdev %i after creation\n",
 			    param->peer_addr, param->vdev_id);
 
-		reinit_completion(&ar->peer_delete_done);
-
-		ret = ath11k_wmi_send_peer_delete_cmd(ar, param->peer_addr,
-						      param->vdev_id);
-		if (ret) {
-			ath11k_warn(ar->ab, "failed to delete peer vdev_id %d addr %pM\n",
-				    param->vdev_id, param->peer_addr);
-			return ret;
-		}
-
-		ret = ath11k_wait_for_peer_delete_done(ar, param->vdev_id,
-						       param->peer_addr);
-		if (ret)
-			return ret;
-
-		return -ENOENT;
+		ret = -ENOENT;
+		goto cleanup;
 	}
 
 	peer->pdev_idx = ar->pdev_idx;
@@ -335,4 +321,24 @@ int ath11k_peer_create(struct ath11k *ar, struct ath11k_vif *arvif,
 	spin_unlock_bh(&ar->ab->base_lock);
 
 	return 0;
+
+cleanup:
+	reinit_completion(&ar->peer_delete_done);
+
+	fbret = ath11k_wmi_send_peer_delete_cmd(ar, param->peer_addr,
+						param->vdev_id);
+	if (fbret) {
+		ath11k_warn(ar->ab, "failed to delete peer vdev_id %d addr %pM\n",
+			    param->vdev_id, param->peer_addr);
+		goto exit;
+	}
+
+	fbret = ath11k_wait_for_peer_delete_done(ar, param->vdev_id,
+						 param->peer_addr);
+	if (fbret)
+		ath11k_warn(ar->ab, "failed wait for peer %pM delete done id %d fallback ret %d\n",
+			    param->peer_addr, param->vdev_id, fbret);
+
+exit:
+	return ret;
 }
-- 
2.7.4

