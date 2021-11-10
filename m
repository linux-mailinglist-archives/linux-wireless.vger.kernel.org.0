Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0A9344C4CF
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Nov 2021 17:06:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231770AbhKJQJa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 10 Nov 2021 11:09:30 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:65079 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231303AbhKJQJ3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 10 Nov 2021 11:09:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1636560402; x=1668096402;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=21kKblIO2WAqKNg27VAfdkgJ1VawQwyxjqN2LA2derY=;
  b=mLArDu+/2tHTSxIPfVXZm8H+k4TeGn0eMhtMu0QojDEjMA6Mq3440Dv/
   qO9IvcLbO6jMfBTOVHTnIF4TGSRB6jrySNQ85vr27PGnJvl7eQHFmsvmc
   RBgpFo0vzayI4zmvx1UT5Dpte8nQmDA9G6mWdoH2bDMH/su22CtNc3D/B
   A=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 10 Nov 2021 08:06:42 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2021 08:06:42 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.7;
 Wed, 10 Nov 2021 08:06:41 -0800
Received: from periyasa-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.7;
 Wed, 10 Nov 2021 08:06:40 -0800
From:   Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Subject: [PATCH] ath11k: avoid unnecessary BH disable lock in STA kickout event
Date:   Wed, 10 Nov 2021 21:36:28 +0530
Message-ID: <1636560388-24955-1-git-send-email-quic_periyasa@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In STA kickout event processing, the peer object is protected
under spin lock BH. Release this lock after picking up the vdev_id
from the peer object instead after ieee80211_report_low_ack().
This will minimize the lock hold period which will improve
performance since base_lock is used across the data path.
This was found in code review.

Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.5.0.1-00729-QCAHKSWPL_SILICONZ-3 v2

Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/wmi.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index 5ae2ef4..60de539 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -6398,6 +6398,7 @@ static void ath11k_peer_sta_kickout_event(struct ath11k_base *ab, struct sk_buff
 	struct ieee80211_sta *sta;
 	struct ath11k_peer *peer;
 	struct ath11k *ar;
+	u32 vdev_id;
 
 	if (ath11k_pull_peer_sta_kickout_ev(ab, skb, &arg) != 0) {
 		ath11k_warn(ab, "failed to extract peer sta kickout event");
@@ -6413,10 +6414,15 @@ static void ath11k_peer_sta_kickout_event(struct ath11k_base *ab, struct sk_buff
 	if (!peer) {
 		ath11k_warn(ab, "peer not found %pM\n",
 			    arg.mac_addr);
+		spin_unlock_bh(&ab->base_lock);
 		goto exit;
 	}
 
-	ar = ath11k_mac_get_ar_by_vdev_id(ab, peer->vdev_id);
+	vdev_id = peer->vdev_id;
+
+	spin_unlock_bh(&ab->base_lock);
+
+	ar = ath11k_mac_get_ar_by_vdev_id(ab, vdev_id);
 	if (!ar) {
 		ath11k_warn(ab, "invalid vdev id in peer sta kickout ev %d",
 			    peer->vdev_id);
@@ -6437,7 +6443,6 @@ static void ath11k_peer_sta_kickout_event(struct ath11k_base *ab, struct sk_buff
 	ieee80211_report_low_ack(sta, 10);
 
 exit:
-	spin_unlock_bh(&ab->base_lock);
 	rcu_read_unlock();
 }
 
-- 
2.7.4

