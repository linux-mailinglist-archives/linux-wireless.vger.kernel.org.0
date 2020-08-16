Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29DB524561E
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Aug 2020 07:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730099AbgHPFbs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 16 Aug 2020 01:31:48 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:52995 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730068AbgHPFbs (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 16 Aug 2020 01:31:48 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597555907; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=J7YCZJt0aHvhVUa6BlmC/ZdiVJmVVAeF1RqwsDfcD40=; b=Pnv/se2n05pH/Vv3Hap/cgSIg1VRCXvt1BnGvsm/nPe0/8Xw7zUOMjlsCDjiqCOkfLgYMAgi
 h/zgxDvLTUItUMSP7ipiwSx3VTEYYoDlqm2WatzMhUR6RdxRpR2DbGNTBMAzg7XfzM0Dq+tl
 l4Pr8xMx5t7jenkHvqnRlIJ7YNI=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 5f38c4c0cbcd42bdee045d74 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sun, 16 Aug 2020 05:31:44
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 9868EC433C9; Sun, 16 Aug 2020 05:31:43 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6BE08C433CB;
        Sun, 16 Aug 2020 05:31:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6BE08C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH 6/9] ath11k: assign correct search flag and type for QCA6390
Date:   Sun, 16 Aug 2020 08:31:28 +0300
Message-Id: <1597555891-26112-7-git-send-email-kvalo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1597555891-26112-1-git-send-email-kvalo@codeaurora.org>
References: <1597555891-26112-1-git-send-email-kvalo@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Carl Huang <cjhuang@codeaurora.org>

QCA6390 doesn't enable V2 map and ummap event, so the addr search
flags and type is different from IPQ8074. Assign correct search flags
and type for QCA6390.

Without this change, ping sometimes fails. With this change, now ping
is always successful.

Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1
Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.1.0.1-01238-QCAHKSWPL_SILICONZ-2

Signed-off-by: Carl Huang <cjhuang@codeaurora.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/core.c  |  2 ++
 drivers/net/wireless/ath/ath11k/dp.c    | 15 +++++++++++----
 drivers/net/wireless/ath/ath11k/dp_rx.c | 10 ++++++++++
 drivers/net/wireless/ath/ath11k/hw.h    |  1 +
 4 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index c469904057f9..a279450438bb 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -41,6 +41,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.num_rxmda_per_pdev = 1,
 		.rx_mac_buf_ring = false,
 		.vdev_start_delay = false,
+		.htt_peer_map_v2 = true,
 	},
 	{
 		.name = "qca6390 hw2.0",
@@ -64,6 +65,7 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.num_rxmda_per_pdev = 2,
 		.rx_mac_buf_ring = true,
 		.vdev_start_delay = true,
+		.htt_peer_map_v2 = false,
 	},
 };
 
diff --git a/drivers/net/wireless/ath/ath11k/dp.c b/drivers/net/wireless/ath/ath11k/dp.c
index 93f30525d7f6..fb82c4f75ced 100644
--- a/drivers/net/wireless/ath/ath11k/dp.c
+++ b/drivers/net/wireless/ath/ath11k/dp.c
@@ -909,13 +909,20 @@ int ath11k_dp_htt_connect(struct ath11k_dp *dp)
 
 static void ath11k_dp_update_vdev_search(struct ath11k_vif *arvif)
 {
-	 /* For STA mode, enable address search index,
-	  * tcl uses ast_hash value in the descriptor.
+	 /* When v2_map_support is true:for STA mode, enable address
+	  * search index, tcl uses ast_hash value in the descriptor.
+	  * When v2_map_support is false: for STA mode, dont' enable
+	  * address search index.
 	  */
 	switch (arvif->vdev_type) {
 	case WMI_VDEV_TYPE_STA:
-		arvif->hal_addr_search_flags = HAL_TX_ADDRX_EN;
-		arvif->search_type = HAL_TX_ADDR_SEARCH_INDEX;
+		if (arvif->ar->ab->hw_params.htt_peer_map_v2) {
+			arvif->hal_addr_search_flags = HAL_TX_ADDRX_EN;
+			arvif->search_type = HAL_TX_ADDR_SEARCH_INDEX;
+		} else {
+			arvif->hal_addr_search_flags = HAL_TX_ADDRY_EN;
+			arvif->search_type = HAL_TX_ADDR_SEARCH_DEFAULT;
+		}
 		break;
 	case WMI_VDEV_TYPE_AP:
 	case WMI_VDEV_TYPE_IBSS:
diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index 4d745ea63f3e..33c7c232773f 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -1625,6 +1625,16 @@ void ath11k_dp_htt_htc_t2h_msg_handler(struct ath11k_base *ab,
 		complete(&dp->htt_tgt_version_received);
 		break;
 	case HTT_T2H_MSG_TYPE_PEER_MAP:
+		vdev_id = FIELD_GET(HTT_T2H_PEER_MAP_INFO_VDEV_ID,
+				    resp->peer_map_ev.info);
+		peer_id = FIELD_GET(HTT_T2H_PEER_MAP_INFO_PEER_ID,
+				    resp->peer_map_ev.info);
+		peer_mac_h16 = FIELD_GET(HTT_T2H_PEER_MAP_INFO1_MAC_ADDR_H16,
+					 resp->peer_map_ev.info1);
+		ath11k_dp_get_mac_addr(resp->peer_map_ev.mac_addr_l32,
+				       peer_mac_h16, mac_addr);
+		ath11k_peer_map_event(ab, vdev_id, peer_id, mac_addr, 0);
+		break;
 	case HTT_T2H_MSG_TYPE_PEER_MAP2:
 		vdev_id = FIELD_GET(HTT_T2H_PEER_MAP_INFO_VDEV_ID,
 				    resp->peer_map_ev.info);
diff --git a/drivers/net/wireless/ath/ath11k/hw.h b/drivers/net/wireless/ath/ath11k/hw.h
index cac6cd3c4c57..500060b36fb4 100644
--- a/drivers/net/wireless/ath/ath11k/hw.h
+++ b/drivers/net/wireless/ath/ath11k/hw.h
@@ -150,6 +150,7 @@ struct ath11k_hw_params {
 	int num_rxmda_per_pdev;
 	bool rx_mac_buf_ring;
 	bool vdev_start_delay;
+	bool htt_peer_map_v2;
 };
 
 struct ath11k_hw_ops {
-- 
2.7.4

