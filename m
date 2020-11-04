Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB3C2A6C05
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Nov 2020 18:46:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731937AbgKDRpv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Nov 2020 12:45:51 -0500
Received: from m42-4.mailgun.net ([69.72.42.4]:58154 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730555AbgKDRpu (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Nov 2020 12:45:50 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1604511949; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=Mw1zY0ur78ZuO0uupqFI0slfe04S1iFGgLPAPXJ1/9I=; b=qZ9uPTECZ6dDGfGSPeaSwdrT2ShGvslmd3AiswpLkgUFG/KdoeZ4WYBU14E8U59a5VvvZHJk
 USb0K1P0V6RmLNRhN3XN4JuP44DcLd7XgUaK3Js1uK/hRJtfMoru4PKheUqROZpASxuvCLAA
 xeAbMHUsy4fCQZhVZQHL93HO5Wo=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 5fa2e8bd77d543c3c706286a (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 04 Nov 2020 17:45:33
 GMT
Sender: periyasa=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 86C27C433C6; Wed,  4 Nov 2020 17:45:33 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from periyasa-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: periyasa)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B9578C433C8;
        Wed,  4 Nov 2020 17:45:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B9578C433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=periyasa@codeaurora.org
From:   Karthikeyan Periyasamy <periyasa@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Karthikeyan Periyasamy <periyasa@codeaurora.org>
Subject: [PATCH] ath11k: Fix the hal descriptor mask
Date:   Wed,  4 Nov 2020 23:15:21 +0530
Message-Id: <1604511921-24840-1-git-send-email-periyasa@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Below listed hal descriptor mask are incorrect, so modify it to correct one
 - CE destination status description meta info mask is increased from
   8 bits to 16 bits from the 0th bit position
 - Rx Reo queue duplicate count mask is decreased from 22 bits to 16 bits
 - Reo threshold status counter sum mask is increased from 24 bits to 26 bits

No functionality impact, these descriptors are currently not used in any
supported platform. But in future if someone referred these descriptor then
ended with wrong values.

Found this during code review.

Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.1.0.1-01238-QCAHKSWPL_SILICONZ-2

Signed-off-by: Karthikeyan Periyasamy <periyasa@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/hal_desc.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/hal_desc.h b/drivers/net/wireless/ath/ath11k/hal_desc.h
index ceebdc2..1b713cb 100644
--- a/drivers/net/wireless/ath/ath11k/hal_desc.h
+++ b/drivers/net/wireless/ath/ath11k/hal_desc.h
@@ -1425,7 +1425,7 @@ struct hal_ce_srng_dest_desc {
 #define HAL_CE_DST_STATUS_DESC_FLAGS_GATHER		BIT(11)
 #define HAL_CE_DST_STATUS_DESC_FLAGS_LEN		GENMASK(31, 16)
 
-#define HAL_CE_DST_STATUS_DESC_META_INFO_DATA		GENMASK(7, 0)
+#define HAL_CE_DST_STATUS_DESC_META_INFO_DATA		GENMASK(15, 0)
 #define HAL_CE_DST_STATUS_DESC_META_INFO_RING_ID	GENMASK(27, 20)
 #define HAL_CE_DST_STATUS_DESC_META_INFO_LOOP_CNT	HAL_SRNG_DESC_LOOP_CNT
 
@@ -1946,7 +1946,7 @@ enum hal_rx_reo_queue_pn_size {
 
 #define HAL_RX_REO_QUEUE_INFO3_TIMEOUT_COUNT		GENMASK(9, 4)
 #define HAL_RX_REO_QUEUE_INFO3_FWD_DUE_TO_BAR_CNT	GENMASK(15, 10)
-#define HAL_RX_REO_QUEUE_INFO3_DUPLICATE_COUNT		GENMASK(31, 10)
+#define HAL_RX_REO_QUEUE_INFO3_DUPLICATE_COUNT		GENMASK(31, 16)
 
 #define HAL_RX_REO_QUEUE_INFO4_FRAME_IN_ORD_COUNT	GENMASK(23, 0)
 #define HAL_RX_REO_QUEUE_INFO4_BAR_RECVD_COUNT		GENMASK(31, 24)
@@ -2432,7 +2432,7 @@ struct hal_reo_flush_timeout_list_status {
 #define HAL_REO_DESC_THRESH_STATUS_INFO1_LINK_DESC_COUNTER0	GENMASK(23, 0)
 #define HAL_REO_DESC_THRESH_STATUS_INFO2_LINK_DESC_COUNTER1	GENMASK(23, 0)
 #define HAL_REO_DESC_THRESH_STATUS_INFO3_LINK_DESC_COUNTER2	GENMASK(23, 0)
-#define HAL_REO_DESC_THRESH_STATUS_INFO4_LINK_DESC_COUNTER_SUM	GENMASK(23, 0)
+#define HAL_REO_DESC_THRESH_STATUS_INFO4_LINK_DESC_COUNTER_SUM	GENMASK(25, 0)
 
 struct hal_reo_desc_thresh_reached_status {
 	struct hal_reo_status_hdr hdr;
-- 
2.7.4

