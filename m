Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1229746BBE0
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Dec 2021 13:55:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231788AbhLGM6n (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 7 Dec 2021 07:58:43 -0500
Received: from m43-7.mailgun.net ([69.72.43.7]:42646 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231753AbhLGM6m (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 7 Dec 2021 07:58:42 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1638881712; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=WEJ0/ZFtyQS3WqQORa4Z21qWdgkBHxpeHse109EMgLc=; b=OQ6G+qp0PXBxqNYSs8MGWe8gwc8fSZvEvLH9YlFS/HQxZThMkYswJfH+0xHbR4vofQfjUBVk
 +4AnpuIZ6zhNgHDdouZzCg6CTNLiWiBw2XT/PSqJJA55N+OJHf7iqpvBxg2djF31NSP7HKbt
 HpDhvV7gUlCXbgRECVSZ7y823y8=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 61af59af465c4a723b06790a (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 07 Dec 2021 12:55:11
 GMT
Sender: akolli=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 885F4C43619; Tue,  7 Dec 2021 12:55:11 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from akolli-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: akolli)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5D5ECC43618;
        Tue,  7 Dec 2021 12:55:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 5D5ECC43618
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Anilkumar Kolli <akolli@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Anilkumar Kolli <akolli@codeaurora.org>
Subject: [PATCH v2 2/3] ath11k: add software monitor ring descriptor for full monitor
Date:   Tue,  7 Dec 2021 18:24:54 +0530
Message-Id: <1638881695-22155-3-git-send-email-akolli@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1638881695-22155-1-git-send-email-akolli@codeaurora.org>
References: <1638881695-22155-1-git-send-email-akolli@codeaurora.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In full monitor mode, monitor destination ring is read in
software monitor ring descriptor format instead of
reo_entrance_ring format. Add new sw_mon_ring descriptor.

Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.4.0.1-01734-QCAHKSWPL_SILICONZ-1

Signed-off-by: Anilkumar Kolli <akolli@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/hal_desc.h | 19 +++++++++++++
 drivers/net/wireless/ath/ath11k/hal_rx.c   | 44 ++++++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/hal_rx.h   | 17 ++++++++++++
 3 files changed, 80 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/hal_desc.h b/drivers/net/wireless/ath/ath11k/hal_desc.h
index 00b595b84939..406767672844 100644
--- a/drivers/net/wireless/ath/ath11k/hal_desc.h
+++ b/drivers/net/wireless/ath/ath11k/hal_desc.h
@@ -858,6 +858,25 @@ struct hal_reo_entrance_ring {
  *		this ring has looped around the ring.
  */
 
+#define HAL_SW_MON_RING_INFO0_RXDMA_PUSH_REASON	GENMASK(1, 0)
+#define HAL_SW_MON_RING_INFO0_RXDMA_ERROR_CODE	GENMASK(6, 2)
+#define HAL_SW_MON_RING_INFO0_MPDU_FRAG_NUMBER	GENMASK(10, 7)
+#define HAL_SW_MON_RING_INFO0_FRAMELESS_BAR	BIT(11)
+#define HAL_SW_MON_RING_INFO0_STATUS_BUF_CNT	GENMASK(15, 12)
+#define HAL_SW_MON_RING_INFO0_END_OF_PPDU	BIT(16)
+
+#define HAL_SW_MON_RING_INFO1_PHY_PPDU_ID	GENMASK(15, 0)
+#define HAL_SW_MON_RING_INFO1_RING_ID		GENMASK(27, 20)
+#define HAL_SW_MON_RING_INFO1_LOOPING_COUNT	GENMASK(31, 28)
+
+struct hal_sw_monitor_ring {
+	struct ath11k_buffer_addr buf_addr_info;
+	struct rx_mpdu_desc rx_mpdu_info;
+	struct ath11k_buffer_addr status_buf_addr_info;
+	u32 info0;
+	u32 info1;
+} __packed;
+
 #define HAL_REO_CMD_HDR_INFO0_CMD_NUMBER	GENMASK(15, 0)
 #define HAL_REO_CMD_HDR_INFO0_STATUS_REQUIRED	BIT(16)
 
diff --git a/drivers/net/wireless/ath/ath11k/hal_rx.c b/drivers/net/wireless/ath/ath11k/hal_rx.c
index 0e43e215c10a..1e279e99baa8 100644
--- a/drivers/net/wireless/ath/ath11k/hal_rx.c
+++ b/drivers/net/wireless/ath/ath11k/hal_rx.c
@@ -1185,3 +1185,47 @@ void ath11k_hal_rx_reo_ent_buf_paddr_get(void *rx_desc, dma_addr_t *paddr,
 
 	*pp_buf_addr = (void *)buf_addr_info;
 }
+
+void
+ath11k_hal_rx_sw_mon_ring_buf_paddr_get(void *rx_desc,
+					struct hal_sw_mon_ring_entries *sw_mon_entries)
+{
+	struct hal_sw_monitor_ring *sw_mon_ring = rx_desc;
+	struct ath11k_buffer_addr *buf_addr_info;
+	struct ath11k_buffer_addr *status_buf_addr_info;
+	struct rx_mpdu_desc *rx_mpdu_desc_info_details;
+
+	rx_mpdu_desc_info_details = &sw_mon_ring->rx_mpdu_info;
+
+	sw_mon_entries->msdu_cnt = FIELD_GET(RX_MPDU_DESC_INFO0_MSDU_COUNT,
+					     rx_mpdu_desc_info_details->info0);
+
+	buf_addr_info = &sw_mon_ring->buf_addr_info;
+	status_buf_addr_info = &sw_mon_ring->status_buf_addr_info;
+
+	sw_mon_entries->mon_dst_paddr = (((u64)FIELD_GET(BUFFER_ADDR_INFO1_ADDR,
+					buf_addr_info->info1)) << 32) |
+					FIELD_GET(BUFFER_ADDR_INFO0_ADDR,
+						  buf_addr_info->info0);
+
+	sw_mon_entries->mon_status_paddr =
+			(((u64)FIELD_GET(BUFFER_ADDR_INFO1_ADDR,
+					 status_buf_addr_info->info1)) << 32) |
+				FIELD_GET(BUFFER_ADDR_INFO0_ADDR,
+					  status_buf_addr_info->info0);
+
+	sw_mon_entries->mon_dst_sw_cookie = FIELD_GET(BUFFER_ADDR_INFO1_SW_COOKIE,
+						      buf_addr_info->info1);
+
+	sw_mon_entries->mon_status_sw_cookie = FIELD_GET(BUFFER_ADDR_INFO1_SW_COOKIE,
+							 status_buf_addr_info->info1);
+
+	sw_mon_entries->status_buf_count = FIELD_GET(HAL_SW_MON_RING_INFO0_STATUS_BUF_CNT,
+						     sw_mon_ring->info0);
+
+	sw_mon_entries->dst_buf_addr_info = buf_addr_info;
+	sw_mon_entries->status_buf_addr_info = status_buf_addr_info;
+
+	sw_mon_entries->ppdu_id =
+		FIELD_GET(HAL_SW_MON_RING_INFO1_PHY_PPDU_ID, sw_mon_ring->info1);
+}
diff --git a/drivers/net/wireless/ath/ath11k/hal_rx.h b/drivers/net/wireless/ath/ath11k/hal_rx.h
index 0f1f04b812b9..8db420ef6351 100644
--- a/drivers/net/wireless/ath/ath11k/hal_rx.h
+++ b/drivers/net/wireless/ath/ath11k/hal_rx.h
@@ -77,6 +77,20 @@ enum hal_rx_mon_status {
 	HAL_RX_MON_STATUS_BUF_DONE,
 };
 
+struct hal_sw_mon_ring_entries {
+	dma_addr_t mon_dst_paddr;
+	dma_addr_t mon_status_paddr;
+	u32 mon_dst_sw_cookie;
+	u32 mon_status_sw_cookie;
+	void *dst_buf_addr_info;
+	void *status_buf_addr_info;
+	u16 ppdu_id;
+	u8 status_buf_count;
+	u8 msdu_cnt;
+	bool end_of_ppdu;
+	bool drop_ppdu;
+};
+
 struct hal_rx_mon_ppdu_info {
 	u32 ppdu_id;
 	u32 ppdu_ts;
@@ -331,6 +345,9 @@ void ath11k_hal_rx_reo_ent_buf_paddr_get(void *rx_desc,
 					 dma_addr_t *paddr, u32 *sw_cookie,
 					 void **pp_buf_addr_info, u8 *rbm,
 					 u32 *msdu_cnt);
+void
+ath11k_hal_rx_sw_mon_ring_buf_paddr_get(void *rx_desc,
+					struct hal_sw_mon_ring_entries *sw_mon_ent);
 enum hal_rx_mon_status
 ath11k_hal_rx_parse_mon_status(struct ath11k_base *ab,
 			       struct hal_rx_mon_ppdu_info *ppdu_info,
-- 
2.7.4

