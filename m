Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9D1245755
	for <lists+linux-wireless@lfdr.de>; Sun, 16 Aug 2020 13:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729084AbgHPL3g (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 16 Aug 2020 07:29:36 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:47928 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728984AbgHPL2v (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 16 Aug 2020 07:28:51 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597577329; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=WWfiXGSJolN+CYoFTLXe0bKzZJ1O/oCyhOYiEYQ2Drc=; b=gt7shzccsEOrSeEl+tG0CZa/oI3ta7nsVK0RWd+AZWoZCGTjZifBuZYnIaZgV7cm52SXyCN+
 bV+cHH62+75dkCYkEzZ0UTC0xIkP9eAb5zdVZQ3xDB2NZaX/rRt4IuCQ7qaZIZpU0U6+RvWx
 y/QCyTJ/QbJVKlzGjgUFBTlhzDE=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 5f3915ac2f4952907db1a758 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sun, 16 Aug 2020 11:17:00
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 7C0DAC433C6; Sun, 16 Aug 2020 11:17:00 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5CBD3C43395;
        Sun, 16 Aug 2020 11:16:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5CBD3C43395
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH v2 12/12] ath11k: dp: redefine peer_map and peer_unmap
Date:   Sun, 16 Aug 2020 14:16:39 +0300
Message-Id: <1597576599-8857-13-git-send-email-kvalo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1597576599-8857-1-git-send-email-kvalo@codeaurora.org>
References: <1597576599-8857-1-git-send-email-kvalo@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Carl Huang <cjhuang@codeaurora.org>

For QCA6390, it uses peer_map and peer_unmap V1. IPQ8074 uses V2.
Redefine previous definition to peer_map2 and peer_unmap2.

Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1
Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.1.0.1-01238-QCAHKSWPL_SILICONZ-2

Signed-off-by: Carl Huang <cjhuang@codeaurora.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/dp.h    | 6 ++++--
 drivers/net/wireless/ath/ath11k/dp_rx.c | 2 ++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/dp.h b/drivers/net/wireless/ath/ath11k/dp.h
index 7587862d2e32..07876fd521f7 100644
--- a/drivers/net/wireless/ath/ath11k/dp.h
+++ b/drivers/net/wireless/ath/ath11k/dp.h
@@ -936,11 +936,13 @@ struct htt_rx_ring_tlv_filter {
 
 enum htt_t2h_msg_type {
 	HTT_T2H_MSG_TYPE_VERSION_CONF,
+	HTT_T2H_MSG_TYPE_PEER_MAP	= 0x3,
+	HTT_T2H_MSG_TYPE_PEER_UNMAP	= 0x4,
 	HTT_T2H_MSG_TYPE_RX_ADDBA	= 0x5,
 	HTT_T2H_MSG_TYPE_PKTLOG		= 0x8,
 	HTT_T2H_MSG_TYPE_SEC_IND	= 0xb,
-	HTT_T2H_MSG_TYPE_PEER_MAP	= 0x1e,
-	HTT_T2H_MSG_TYPE_PEER_UNMAP	= 0x1f,
+	HTT_T2H_MSG_TYPE_PEER_MAP2	= 0x1e,
+	HTT_T2H_MSG_TYPE_PEER_UNMAP2	= 0x1f,
 	HTT_T2H_MSG_TYPE_PPDU_STATS_IND = 0x1d,
 	HTT_T2H_MSG_TYPE_EXT_STATS_CONF = 0x1c,
 	HTT_T2H_MSG_TYPE_BKPRESSURE_EVENT_IND = 0x24,
diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index 66002de04aec..6009c26ce525 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -1569,6 +1569,7 @@ void ath11k_dp_htt_htc_t2h_msg_handler(struct ath11k_base *ab,
 		complete(&dp->htt_tgt_version_received);
 		break;
 	case HTT_T2H_MSG_TYPE_PEER_MAP:
+	case HTT_T2H_MSG_TYPE_PEER_MAP2:
 		vdev_id = FIELD_GET(HTT_T2H_PEER_MAP_INFO_VDEV_ID,
 				    resp->peer_map_ev.info);
 		peer_id = FIELD_GET(HTT_T2H_PEER_MAP_INFO_PEER_ID,
@@ -1582,6 +1583,7 @@ void ath11k_dp_htt_htc_t2h_msg_handler(struct ath11k_base *ab,
 		ath11k_peer_map_event(ab, vdev_id, peer_id, mac_addr, ast_hash);
 		break;
 	case HTT_T2H_MSG_TYPE_PEER_UNMAP:
+	case HTT_T2H_MSG_TYPE_PEER_UNMAP2:
 		peer_id = FIELD_GET(HTT_T2H_PEER_UNMAP_INFO_PEER_ID,
 				    resp->peer_unmap_ev.info);
 		ath11k_peer_unmap_event(ab, peer_id);
-- 
2.7.4

