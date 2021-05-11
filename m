Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3E3637ABCF
	for <lists+linux-wireless@lfdr.de>; Tue, 11 May 2021 18:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231392AbhEKQYT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 May 2021 12:24:19 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:23522 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231839AbhEKQYO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 May 2021 12:24:14 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1620750188; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=IVyami990KY+dqeiRJu1k7i0CV3TjJ04chwTn6JjOvQ=; b=ug+SCr7MaDGj/IjZReCQSu6frTkbtm3lhyrJlIRK0hpRx0srZTdn6Nt+Bwvx7W4w02+s1DsT
 dcyDmQCU3KfJL1gYt4DmLXRZFZ1UUy3EpERKXfyUoPnq0KwIRlFUETPNqYJgxtWzAdthA8A/
 7x23I53pkOr4OB0fEAo9SgHeocg=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 609aaf695702f8d969e32965 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 11 May 2021 16:23:05
 GMT
Sender: jouni=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 09E95C43147; Tue, 11 May 2021 16:23:05 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from jouni.codeaurora.org (85-76-96-12-nat.elisa-mobile.fi [85.76.96.12])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jouni)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1F2CAC4338A;
        Tue, 11 May 2021 16:23:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1F2CAC4338A
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=jouni@codeaurora.org
From:   Jouni Malinen <jouni@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        Baochen Qiang <bqiang@codeaurora.org>,
        Jouni Malinen <jouni@codeaurora.org>
Subject: [PATCH 5/7] ath11k: add support to get peer id for WCN6855
Date:   Tue, 11 May 2021 19:22:12 +0300
Message-Id: <20210511162214.29475-6-jouni@codeaurora.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210511162214.29475-1-jouni@codeaurora.org>
References: <20210511162214.29475-1-jouni@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Baochen Qiang <bqiang@codeaurora.org>

For WCN6855, the layout of hal rx mpdu info is different, so need to
handle this target differently when getting peer id.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-01720.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1
Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1

Signed-off-by: Baochen Qiang <bqiang@codeaurora.org>
Signed-off-by: Jouni Malinen <jouni@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/hal_rx.c |  5 +----
 drivers/net/wireless/ath/ath11k/hal_rx.h |  8 +++++++
 drivers/net/wireless/ath/ath11k/hw.c     | 28 ++++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/hw.h     |  1 +
 4 files changed, 38 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/hal_rx.c b/drivers/net/wireless/ath/ath11k/hal_rx.c
index b479d93bee32..95d77468e87e 100644
--- a/drivers/net/wireless/ath/ath11k/hal_rx.c
+++ b/drivers/net/wireless/ath/ath11k/hal_rx.c
@@ -1092,12 +1092,9 @@ ath11k_hal_rx_parse_mon_status_tlv(struct ath11k_base *ab,
 		break;
 	}
 	case HAL_RX_MPDU_START: {
-		struct hal_rx_mpdu_info *mpdu_info =
-			(struct hal_rx_mpdu_info *)tlv_data;
 		u16 peer_id;
 
-		peer_id = FIELD_GET(HAL_RX_MPDU_INFO_INFO0_PEERID,
-				    __le32_to_cpu(mpdu_info->info0));
+		peer_id = ab->hw_params.hw_ops->mpdu_info_get_peerid(tlv_data);
 		if (peer_id)
 			ppdu_info->peer_id = peer_id;
 		break;
diff --git a/drivers/net/wireless/ath/ath11k/hal_rx.h b/drivers/net/wireless/ath/ath11k/hal_rx.h
index d464a270c049..0f1f04b812b9 100644
--- a/drivers/net/wireless/ath/ath11k/hal_rx.h
+++ b/drivers/net/wireless/ath/ath11k/hal_rx.h
@@ -254,12 +254,20 @@ struct hal_rx_phyrx_rssi_legacy_info {
 } __packed;
 
 #define HAL_RX_MPDU_INFO_INFO0_PEERID	GENMASK(31, 16)
+#define HAL_RX_MPDU_INFO_INFO0_PEERID_WCN6855	GENMASK(15, 0)
+
 struct hal_rx_mpdu_info {
 	__le32 rsvd0;
 	__le32 info0;
 	__le32 rsvd1[21];
 } __packed;
 
+struct hal_rx_mpdu_info_wcn6855 {
+	__le32 rsvd0[8];
+	__le32 info0;
+	__le32 rsvd1[14];
+} __packed;
+
 #define HAL_RX_PPDU_END_DURATION	GENMASK(23, 0)
 struct hal_rx_ppdu_end_duration {
 	__le32 rsvd0[9];
diff --git a/drivers/net/wireless/ath/ath11k/hw.c b/drivers/net/wireless/ath/ath11k/hw.c
index 01207b50a454..d9596903b0a5 100644
--- a/drivers/net/wireless/ath/ath11k/hw.c
+++ b/drivers/net/wireless/ath/ath11k/hw.c
@@ -742,6 +742,29 @@ static void ath11k_hw_wcn6855_reo_setup(struct ath11k_base *ab)
 			   ring_hash_map);
 }
 
+static u16 ath11k_hw_ipq8074_mpdu_info_get_peerid(u8 *tlv_data)
+{
+	u16 peer_id = 0;
+	struct hal_rx_mpdu_info *mpdu_info =
+		(struct hal_rx_mpdu_info *)tlv_data;
+
+	peer_id = FIELD_GET(HAL_RX_MPDU_INFO_INFO0_PEERID,
+			    __le32_to_cpu(mpdu_info->info0));
+
+	return peer_id;
+}
+
+static u16 ath11k_hw_wcn6855_mpdu_info_get_peerid(u8 *tlv_data)
+{
+	u16 peer_id = 0;
+	struct hal_rx_mpdu_info_wcn6855 *mpdu_info =
+		(struct hal_rx_mpdu_info_wcn6855 *)tlv_data;
+
+	peer_id = FIELD_GET(HAL_RX_MPDU_INFO_INFO0_PEERID_WCN6855,
+			    __le32_to_cpu(mpdu_info->info0));
+	return peer_id;
+}
+
 const struct ath11k_hw_ops ipq8074_ops = {
 	.get_hw_mac_from_pdev_id = ath11k_hw_ipq8074_mac_from_pdev_id,
 	.wmi_init_config = ath11k_init_wmi_config_ipq8074,
@@ -775,6 +798,7 @@ const struct ath11k_hw_ops ipq8074_ops = {
 	.rx_desc_get_attention = ath11k_hw_ipq8074_rx_desc_get_attention,
 	.rx_desc_get_msdu_payload = ath11k_hw_ipq8074_rx_desc_get_msdu_payload,
 	.reo_setup = ath11k_hw_ipq8074_reo_setup,
+	.mpdu_info_get_peerid = ath11k_hw_ipq8074_mpdu_info_get_peerid,
 };
 
 const struct ath11k_hw_ops ipq6018_ops = {
@@ -810,6 +834,7 @@ const struct ath11k_hw_ops ipq6018_ops = {
 	.rx_desc_get_attention = ath11k_hw_ipq8074_rx_desc_get_attention,
 	.rx_desc_get_msdu_payload = ath11k_hw_ipq8074_rx_desc_get_msdu_payload,
 	.reo_setup = ath11k_hw_ipq8074_reo_setup,
+	.mpdu_info_get_peerid = ath11k_hw_ipq8074_mpdu_info_get_peerid,
 };
 
 const struct ath11k_hw_ops qca6390_ops = {
@@ -845,6 +870,7 @@ const struct ath11k_hw_ops qca6390_ops = {
 	.rx_desc_get_attention = ath11k_hw_ipq8074_rx_desc_get_attention,
 	.rx_desc_get_msdu_payload = ath11k_hw_ipq8074_rx_desc_get_msdu_payload,
 	.reo_setup = ath11k_hw_ipq8074_reo_setup,
+	.mpdu_info_get_peerid = ath11k_hw_ipq8074_mpdu_info_get_peerid,
 };
 
 const struct ath11k_hw_ops qcn9074_ops = {
@@ -880,6 +906,7 @@ const struct ath11k_hw_ops qcn9074_ops = {
 	.rx_desc_get_attention = ath11k_hw_qcn9074_rx_desc_get_attention,
 	.rx_desc_get_msdu_payload = ath11k_hw_qcn9074_rx_desc_get_msdu_payload,
 	.reo_setup = ath11k_hw_ipq8074_reo_setup,
+	.mpdu_info_get_peerid = ath11k_hw_ipq8074_mpdu_info_get_peerid,
 };
 
 const struct ath11k_hw_ops wcn6855_ops = {
@@ -915,6 +942,7 @@ const struct ath11k_hw_ops wcn6855_ops = {
 	.rx_desc_get_attention = ath11k_hw_wcn6855_rx_desc_get_attention,
 	.rx_desc_get_msdu_payload = ath11k_hw_wcn6855_rx_desc_get_msdu_payload,
 	.reo_setup = ath11k_hw_wcn6855_reo_setup,
+	.mpdu_info_get_peerid = ath11k_hw_wcn6855_mpdu_info_get_peerid,
 };
 
 #define ATH11K_TX_RING_MASK_0 0x1
diff --git a/drivers/net/wireless/ath/ath11k/hw.h b/drivers/net/wireless/ath/ath11k/hw.h
index afe3b3c71695..be62f0c2e25e 100644
--- a/drivers/net/wireless/ath/ath11k/hw.h
+++ b/drivers/net/wireless/ath/ath11k/hw.h
@@ -200,6 +200,7 @@ struct ath11k_hw_ops {
 	struct rx_attention *(*rx_desc_get_attention)(struct hal_rx_desc *desc);
 	u8 *(*rx_desc_get_msdu_payload)(struct hal_rx_desc *desc);
 	void (*reo_setup)(struct ath11k_base *ab);
+	u16 (*mpdu_info_get_peerid)(u8 *tlv_data);
 };
 
 extern const struct ath11k_hw_ops ipq8074_ops;
-- 
2.25.1

