Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AADA3D03ED
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Jul 2021 23:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231676AbhGTUw7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 20 Jul 2021 16:52:59 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:51945 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234001AbhGTUvt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 20 Jul 2021 16:51:49 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1626816747; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=pTgIsAFvKI5zaKS8j6HkCt9Dr4xbghRAApcXu+jUG8M=; b=ZAAksGTytroGGn4JtQ3J6nCBuDx5xyVpnhflyyy4ZihH6zkONxlfFzdmrU9OAB7jqgetM0bw
 aodI6LSEYmEo+yYTMvYfRD+vtYNqbnEtj3Er8kXZA+EaraVr1rhQNUCootlK9BaqAyA+ckoS
 iUediQZtUI3serWUbPDTPAUCDn8=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 60f740d74815712f3a66316d (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 20 Jul 2021 21:32:07
 GMT
Sender: jouni=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id AE3D3C43217; Tue, 20 Jul 2021 21:32:06 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from jouni.codeaurora.org (85-76-67-217-nat.elisa-mobile.fi [85.76.67.217])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jouni)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BA686C433D3;
        Tue, 20 Jul 2021 21:32:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BA686C433D3
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=jouni@codeaurora.org
From:   Jouni Malinen <jouni@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Karthikeyan Periyasamy <periyasa@codeaurora.org>,
        Jouni Malinen <jouni@codeaurora.org>
Subject: [PATCH 2/2] ath11k: fix 4addr multicast packet tx
Date:   Wed, 21 Jul 2021 00:31:47 +0300
Message-Id: <20210720213147.90042-2-jouni@codeaurora.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210720213147.90042-1-jouni@codeaurora.org>
References: <20210720213147.90042-1-jouni@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Karthikeyan Periyasamy <periyasa@codeaurora.org>

In 4addr, AP wired backbone to STA wired backbone ping fails due to ARP
request not getting answered. Here 4addr ARP multicast packet is sent in
3addr, so that 4addr STA not honouring the 3addr ARP multicast packet.
Fix this issue by sending out multicast packet in 4addr format, firmware
expects peer meta flag instead of vdev meta flag in Tx descriptor.

Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.4.0.1-01641-QCAHKSWPL_SILICONZ-1

Signed-off-by: Karthikeyan Periyasamy <periyasa@codeaurora.org>
Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/core.h  |  1 +
 drivers/net/wireless/ath/ath11k/dp_tx.c | 12 ++++++++++--
 drivers/net/wireless/ath/ath11k/dp_tx.h |  2 +-
 drivers/net/wireless/ath/ath11k/mac.c   |  6 +++++-
 drivers/net/wireless/ath/ath11k/peer.c  | 11 +++++++++++
 5 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index 11c8dffd0236..6a6cabdd3e30 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -377,6 +377,7 @@ struct ath11k_sta {
 #endif
 
 	bool use_4addr_set;
+	u16 tcl_metadata;
 };
 
 #define ATH11K_MIN_5G_FREQ 4150
diff --git a/drivers/net/wireless/ath/ath11k/dp_tx.c b/drivers/net/wireless/ath/ath11k/dp_tx.c
index 8bba5234f81f..3acdd4050d5b 100644
--- a/drivers/net/wireless/ath/ath11k/dp_tx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_tx.c
@@ -78,7 +78,7 @@ enum hal_encrypt_type ath11k_dp_tx_get_encrypt_type(u32 cipher)
 }
 
 int ath11k_dp_tx(struct ath11k *ar, struct ath11k_vif *arvif,
-		 struct sk_buff *skb)
+		 struct ath11k_sta *arsta, struct sk_buff *skb)
 {
 	struct ath11k_base *ab = ar->ab;
 	struct ath11k_dp *dp = &ab->dp;
@@ -145,7 +145,15 @@ int ath11k_dp_tx(struct ath11k *ar, struct ath11k_vif *arvif,
 		     FIELD_PREP(DP_TX_DESC_ID_MSDU_ID, ret) |
 		     FIELD_PREP(DP_TX_DESC_ID_POOL_ID, pool_id);
 	ti.encap_type = ath11k_dp_tx_get_encap_type(arvif, skb);
-	ti.meta_data_flags = arvif->tcl_metadata;
+
+	if (ieee80211_has_a4(hdr->frame_control) &&
+	    is_multicast_ether_addr(hdr->addr3) && arsta &&
+	    arsta->use_4addr_set) {
+		ti.meta_data_flags = arsta->tcl_metadata;
+		ti.flags0 |= FIELD_PREP(HAL_TCL_DATA_CMD_INFO1_TO_FW, 1);
+	} else {
+		ti.meta_data_flags = arvif->tcl_metadata;
+	}
 
 	if (ti.encap_type == HAL_TCL_ENCAP_TYPE_RAW) {
 		if (skb_cb->flags & ATH11K_SKB_CIPHER_SET) {
diff --git a/drivers/net/wireless/ath/ath11k/dp_tx.h b/drivers/net/wireless/ath/ath11k/dp_tx.h
index f8a9f9c8e444..698b907b878d 100644
--- a/drivers/net/wireless/ath/ath11k/dp_tx.h
+++ b/drivers/net/wireless/ath/ath11k/dp_tx.h
@@ -17,7 +17,7 @@ struct ath11k_dp_htt_wbm_tx_status {
 
 int ath11k_dp_tx_htt_h2t_ver_req_msg(struct ath11k_base *ab);
 int ath11k_dp_tx(struct ath11k *ar, struct ath11k_vif *arvif,
-		 struct sk_buff *skb);
+		 struct ath11k_sta *arsta, struct sk_buff *skb);
 void ath11k_dp_tx_completion_handler(struct ath11k_base *ab, int ring_id);
 int ath11k_dp_tx_send_reo_cmd(struct ath11k_base *ab, struct dp_rx_tid *rx_tid,
 			      enum hal_reo_cmd_type type,
diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index d42637ecbf1e..e8da4af82221 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -4356,6 +4356,7 @@ static void ath11k_mac_op_tx(struct ieee80211_hw *hw,
 	struct ath11k_vif *arvif = ath11k_vif_to_arvif(vif);
 	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
 	struct ieee80211_key_conf *key = info->control.hw_key;
+	struct ath11k_sta *arsta = NULL;
 	u32 info_flags = info->flags;
 	bool is_prb_rsp;
 	int ret;
@@ -4381,7 +4382,10 @@ static void ath11k_mac_op_tx(struct ieee80211_hw *hw,
 		return;
 	}
 
-	ret = ath11k_dp_tx(ar, arvif, skb);
+	if (control->sta)
+		arsta = (struct ath11k_sta *)control->sta->drv_priv;
+
+	ret = ath11k_dp_tx(ar, arvif, arsta, skb);
 	if (ret) {
 		ath11k_warn(ar->ab, "failed to transmit frame %d\n", ret);
 		ieee80211_free_txskb(ar->hw, skb);
diff --git a/drivers/net/wireless/ath/ath11k/peer.c b/drivers/net/wireless/ath/ath11k/peer.c
index f49abefa9618..85471f8b3563 100644
--- a/drivers/net/wireless/ath/ath11k/peer.c
+++ b/drivers/net/wireless/ath/ath11k/peer.c
@@ -251,6 +251,7 @@ int ath11k_peer_create(struct ath11k *ar, struct ath11k_vif *arvif,
 		       struct ieee80211_sta *sta, struct peer_create_params *param)
 {
 	struct ath11k_peer *peer;
+	struct ath11k_sta *arsta;
 	int ret;
 
 	lockdep_assert_held(&ar->conf_mutex);
@@ -319,6 +320,16 @@ int ath11k_peer_create(struct ath11k *ar, struct ath11k_vif *arvif,
 	peer->sec_type = HAL_ENCRYPT_TYPE_OPEN;
 	peer->sec_type_grp = HAL_ENCRYPT_TYPE_OPEN;
 
+	if (sta) {
+		arsta = (struct ath11k_sta *)sta->drv_priv;
+		arsta->tcl_metadata |= FIELD_PREP(HTT_TCL_META_DATA_TYPE, 0) |
+				       FIELD_PREP(HTT_TCL_META_DATA_PEER_ID,
+						  peer->peer_id);
+
+		/* set HTT extension valid bit to 0 by default */
+		arsta->tcl_metadata &= ~HTT_TCL_META_DATA_VALID_HTT;
+	}
+
 	ar->num_peers++;
 
 	spin_unlock_bh(&ar->ab->base_lock);
-- 
2.25.1

