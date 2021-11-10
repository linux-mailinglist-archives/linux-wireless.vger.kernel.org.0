Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 589C944C2E9
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Nov 2021 15:23:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231731AbhKJO0h (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 10 Nov 2021 09:26:37 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:14849 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231340AbhKJO0g (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 10 Nov 2021 09:26:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1636554229; x=1668090229;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=q3qNSKFcQq+TiIPXfvsf2+AVEG8VEuKs5xVYnQ4oWI0=;
  b=SXVxYax89RRZWTSPmQQhljDYPqbb28zD3zYL5HKIsQpzvmzUBUgWYVO9
   mFnmNWQxxHg3BO6taAjTlhP7nBOUzM+/1FLyx0/Z0JvsOfBnw4RG+wcOp
   /T4FXYOTpwrvfYKJUEb9Z8le/+uNsJ9PMaXa22KPd2dJvunkI0RV9yhVq
   A=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 10 Nov 2021 06:23:48 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2021 06:23:48 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.7;
 Wed, 10 Nov 2021 06:23:48 -0800
Received: from periyasa-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.7;
 Wed, 10 Nov 2021 06:23:45 -0800
From:   Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Subject: [PATCH] ath11k: fix fw crash due to peer get authorized before key install
Date:   Wed, 10 Nov 2021 19:53:20 +0530
Message-ID: <1636554200-12345-1-git-send-email-quic_periyasa@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Firmware expects host to authorize the peer after the successful key
install. But host authorize the peer before the key install, this trigger
the firmware assert which leads to Q6 crash. To avoid this Q6 crash, host
should authorize the peer after the key install. So introduce is_authorized
in peer object to identify that peer is authorize or not. When
IEEE80211_STA_CONTROL_PORT flag is unset, peer move to authorize state
before the vdev up. When the same flag is set then peer move to authorize
state after vdev up. So added authorise check in ath11k_bss_assoc() to
handle the earlier state transition case. Also added the WMI authorize
procedure in ath11k_mac_op_sta_state() to handle the non-earlier state
transition case.

Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.4.0.1-01492-QCAHKSWPL_SILICONZ-1

Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/mac.c  | 53 +++++++++++++++++++++++++++++-----
 drivers/net/wireless/ath/ath11k/peer.h |  1 +
 2 files changed, 47 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 50a6f88..5d860fe 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -2397,6 +2397,8 @@ static void ath11k_bss_assoc(struct ieee80211_hw *hw,
 	struct ath11k_vif *arvif = (void *)vif->drv_priv;
 	struct peer_assoc_params peer_arg;
 	struct ieee80211_sta *ap_sta;
+	struct ath11k_peer *peer;
+	bool is_auth = false;
 	int ret;
 
 	lockdep_assert_held(&ar->conf_mutex);
@@ -2458,13 +2460,22 @@ static void ath11k_bss_assoc(struct ieee80211_hw *hw,
 		   "mac vdev %d up (associated) bssid %pM aid %d\n",
 		   arvif->vdev_id, bss_conf->bssid, bss_conf->aid);
 
-	/* Authorize BSS Peer */
-	ret = ath11k_wmi_set_peer_param(ar, arvif->bssid,
-					arvif->vdev_id,
-					WMI_PEER_AUTHORIZE,
-					1);
-	if (ret)
-		ath11k_warn(ar->ab, "Unable to authorize BSS peer: %d\n", ret);
+	spin_lock_bh(&ar->ab->base_lock);
+
+	peer = ath11k_peer_find(ar->ab, arvif->vdev_id, arvif->bssid);
+	if (peer && peer->is_authorized)
+		is_auth = true;
+
+	spin_unlock_bh(&ar->ab->base_lock);
+
+	if (is_auth) {
+		ret = ath11k_wmi_set_peer_param(ar, arvif->bssid,
+						arvif->vdev_id,
+						WMI_PEER_AUTHORIZE,
+						1);
+		if (ret)
+			ath11k_warn(ar->ab, "Unable to authorize BSS peer: %d\n", ret);
+	}
 
 	ret = ath11k_wmi_send_obss_spr_cmd(ar, arvif->vdev_id,
 					   &bss_conf->he_obss_pd);
@@ -4131,6 +4142,34 @@ static int ath11k_mac_op_sta_state(struct ieee80211_hw *hw,
 			ath11k_warn(ar->ab, "Failed to associate station: %pM\n",
 				    sta->addr);
 	} else if (old_state == IEEE80211_STA_ASSOC &&
+		   new_state == IEEE80211_STA_AUTHORIZED) {
+		spin_lock_bh(&ar->ab->base_lock);
+
+		peer = ath11k_peer_find(ar->ab, arvif->vdev_id, sta->addr);
+		if (peer)
+			peer->is_authorized = true;
+
+		spin_unlock_bh(&ar->ab->base_lock);
+
+		if (vif->type == NL80211_IFTYPE_STATION && arvif->is_up) {
+			ret = ath11k_wmi_set_peer_param(ar, sta->addr,
+							arvif->vdev_id,
+							WMI_PEER_AUTHORIZE,
+							1);
+			if (ret)
+				ath11k_warn(ar->ab, "Unable to authorize peer %pM vdev %d: %d\n",
+					    sta->addr, arvif->vdev_id, ret);
+		}
+	} else if (old_state == IEEE80211_STA_AUTHORIZED &&
+		   new_state == IEEE80211_STA_ASSOC) {
+		spin_lock_bh(&ar->ab->base_lock);
+
+		peer = ath11k_peer_find(ar->ab, arvif->vdev_id, sta->addr);
+		if (peer)
+			peer->is_authorized = false;
+
+		spin_unlock_bh(&ar->ab->base_lock);
+	} else if (old_state == IEEE80211_STA_ASSOC &&
 		   new_state == IEEE80211_STA_AUTH &&
 		   (vif->type == NL80211_IFTYPE_AP ||
 		    vif->type == NL80211_IFTYPE_MESH_POINT ||
diff --git a/drivers/net/wireless/ath/ath11k/peer.h b/drivers/net/wireless/ath/ath11k/peer.h
index 619db00..63fe566 100644
--- a/drivers/net/wireless/ath/ath11k/peer.h
+++ b/drivers/net/wireless/ath/ath11k/peer.h
@@ -28,6 +28,7 @@ struct ath11k_peer {
 	u8 ucast_keyidx;
 	u16 sec_type;
 	u16 sec_type_grp;
+	bool is_authorized;
 };
 
 void ath11k_peer_unmap_event(struct ath11k_base *ab, u16 peer_id);
-- 
2.7.4

