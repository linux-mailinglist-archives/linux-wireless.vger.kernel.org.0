Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9FC843C69B
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Oct 2021 11:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238859AbhJ0JlG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 Oct 2021 05:41:06 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:35654 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234018AbhJ0JlF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 Oct 2021 05:41:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1635327521; x=1666863521;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OdC7LkPyp5AWTA7ablp9ZhOZuD4oCYcrlSj/zgD70NE=;
  b=SF9MgelclQdneD61XTpI9Kn4L0QvCCOSQ77ulGK2vrQ0syRbkiQia837
   jnhnDUksC2oBSQRTJuaqI4XkS0PBajRO4oVq1KoGOApBq6hwXtnLgjFQ+
   Lu6Urhx03PYzgdvJw92nmbtMQt5Z2sKu2ZQ6DmN00joyuYH33/ePrdwDL
   w=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 27 Oct 2021 02:38:40 -0700
X-QCInternal: smtphost
Received: from nalasex01a.na.qualcomm.com ([10.47.209.196])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2021 02:38:41 -0700
Received: from wgong-HP3-Z230-SFF-Workstation.qca.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.7;
 Wed, 27 Oct 2021 02:38:39 -0700
From:   Wen Gong <quic_wgong@quicinc.com>
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>, <quic_wgong@quicinc.com>
Subject: [PATCH] ath11k: move peer delete after vdev stop of station for QCA6390 and WCN6855
Date:   Wed, 27 Oct 2021 05:38:25 -0400
Message-ID: <20211027093825.12167-1-quic_wgong@quicinc.com>
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

When station connect to AP, the wmi command sequence is:
peer_create->vdev_start->vdev_up
and sequence of station disconnect fo AP is:
peer_delete->vdev_down->vdev_stop
The sequence of disconnect is not opposite of connect, it caused firmware
crash when it handle wmi vdev stop cmd when the AP is support TWT of
802.11 ax, because firmware need access the bss peer for vdev stop cmd.

kernel: [  390.438564] ath11k_pci 0000:05:00.0: wmi cmd send 0x6001 ret 0
kernel: [  390.438567] ath11k_pci 0000:05:00.0: WMI peer create vdev_id 0 peer_addr c4:04:15:3b:e0:39
kernel: [  390.472724] ath11k_pci 0000:05:00.0: mac vdev 0 start center_freq 2437 phymode 11ax-he20-2g
kernel: [  390.472731] ath11k_pci 0000:05:00.0: wmi cmd send 0x5003 ret 0
kernel: [  390.560849] ath11k_pci 0000:05:00.0: wmi cmd send 0x5005 ret 0
kernel: [  390.560850] ath11k_pci 0000:05:00.0: WMI mgmt vdev up id 0x0 assoc id 1 bssid c4:04:15:3b:e0:39

kernel: [  399.432896] ath11k_pci 0000:05:00.0: WMI peer delete vdev_id 0 peer_addr c4:04:15:3b:e0:39
kernel: [  399.432902] ath11k_pci 0000:05:00.0: wmi cmd send 0x6002 ret 0
kernel: [  399.441380] ath11k_pci 0000:05:00.0: wmi cmd send 0x5007 ret 0
kernel: [  399.441381] ath11k_pci 0000:05:00.0: WMI vdev down id 0x0
kernel: [  399.454681] ath11k_pci 0000:05:00.0: wmi cmd send 0x5006 ret 0
kernel: [  399.454682] ath11k_pci 0000:05:00.0: WMI vdev stop id 0x0

The opposite sequence of disconnect should be:
vdev_down->vdev_stop->peer_delete

This patch change the sequence of disconnect for station as above
opposite sequence for QCA6390, firmware not crash again with this patch.

Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1

Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
---
 drivers/net/wireless/ath/ath11k/mac.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index 47d0dc69463a..ad3510bec4da 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -3406,6 +3406,10 @@ static int ath11k_mac_op_sta_state(struct ieee80211_hw *hw,
 		    new_state == IEEE80211_STA_NOTEXIST)) {
 		ath11k_dp_peer_cleanup(ar, arvif->vdev_id, sta->addr);
 
+		if (ar->ab->hw_params.vdev_start_delay &&
+		    vif->type == NL80211_IFTYPE_STATION)
+			goto free;
+
 		ret = ath11k_peer_delete(ar, arvif->vdev_id, sta->addr);
 		if (ret)
 			ath11k_warn(ar->ab, "Failed to delete peer: %pM for VDEV: %d\n",
@@ -3427,6 +3431,7 @@ static int ath11k_mac_op_sta_state(struct ieee80211_hw *hw,
 		}
 		spin_unlock_bh(&ar->ab->base_lock);
 
+free:
 		kfree(arsta->tx_stats);
 		arsta->tx_stats = NULL;
 
@@ -6313,6 +6318,19 @@ ath11k_mac_op_unassign_vif_chanctx(struct ieee80211_hw *hw,
 
 	arvif->is_started = false;
 
+	if (ab->hw_params.vdev_start_delay &&
+	    arvif->vdev_type == WMI_VDEV_TYPE_STA) {
+		ret = ath11k_peer_delete(ar, arvif->vdev_id, arvif->bssid);
+		if (ret)
+			ath11k_warn(ar->ab,
+				    "delete peer fail: %pM for VDEV: %d\n",
+				    arvif->bssid, arvif->vdev_id);
+		else
+			ath11k_dbg(ar->ab, ATH11K_DBG_MAC,
+				   "removed peer after vdev stop: %pM for VDEV: %d\n",
+				   arvif->bssid, arvif->vdev_id);
+	}
+
 	if (ab->hw_params.vdev_start_delay &&
 	    arvif->vdev_type == WMI_VDEV_TYPE_MONITOR)
 		ath11k_wmi_vdev_down(ar, arvif->vdev_id);
-- 
2.31.1

