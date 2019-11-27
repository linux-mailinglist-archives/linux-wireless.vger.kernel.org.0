Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB38E10B0DE
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Nov 2019 15:08:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbfK0OIv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 Nov 2019 09:08:51 -0500
Received: from a27-186.smtp-out.us-west-2.amazonses.com ([54.240.27.186]:60528
        "EHLO a27-186.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726985AbfK0OIv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 Nov 2019 09:08:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1574863730;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        bh=HeqadJXTb/e90a+A5/3KPeCsZUX0H5OR6kAqWpL2A9E=;
        b=NnlpBor+WuxgDPXzjuPCdnO2A8p8PUFm8nRAr9R0pyYQImjWikvmbhdMrIEAiDe9
        W9Ji4/xehiqBjvbo5xqipsxMg4FC+CglNmiDbo+wNaIfLS5WCd8EzaxNSgUjIrTbNvh
        3T/1z4lPu/AiNurXc0+2dA04O3CU+LfqVIEHe/ko=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1574863730;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:Feedback-ID;
        bh=HeqadJXTb/e90a+A5/3KPeCsZUX0H5OR6kAqWpL2A9E=;
        b=YRA5tJzYNx66hzpNzkBzgM0lGE0WtVOd3+Sni0juLX4TvobsbW6qabP8Fw5keb35
        Rw1KldE22wa1xgOsXcly5PXOdCtCsrRtd8CJXKBDMAVcNOedaB5jf95MJdUEgE8+wDx
        SZmoZVbI9qnJGWXLmYnm1Ia3Z3iAwtsPIJtX/ngw=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8CC12C447B7
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     linux-wireless@vger.kernel.org
Cc:     ath11k@lists.infradead.org
Subject: [PATCH 04/10] ath11k: pktlog: fix sending/using the pdev id
Date:   Wed, 27 Nov 2019 14:08:50 +0000
Message-ID: <0101016ead3176e9-4ce1305f-5b82-4490-bf38-9caa4ddd9105-000000@us-west-2.amazonses.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1574863720-25728-1-git-send-email-kvalo@codeaurora.org>
References: <1574863720-25728-1-git-send-email-kvalo@codeaurora.org>
X-SES-Outgoing: 2019.11.27-54.240.27.186
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Anilkumar Kolli <akolli@codeaurora.org>

Fixes sending the pdev id(0,1,2 for mac0, mac1, mac2)
to FW in wmi cmd pktlog enable/disable.

Signed-off-by: Anilkumar Kolli <akolli@codeaurora.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/dp_rx.c | 8 +++++---
 drivers/net/wireless/ath/ath11k/wmi.c   | 6 +++---
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index acad74658e64..67efa247bf65 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -1265,7 +1265,6 @@ static void ath11k_htt_pktlog(struct ath11k_base *ab, struct sk_buff *skb)
 	u8 pdev_id;
 
 	len = FIELD_GET(HTT_T2H_PPDU_STATS_INFO_PAYLOAD_SIZE, data->hdr);
-
 	if (len > ATH11K_HTT_PKTLOG_MAX_SIZE) {
 		ath11k_warn(ab, "htt pktlog buffer size %d, expected < %d\n",
 			    len,
@@ -1274,8 +1273,11 @@ static void ath11k_htt_pktlog(struct ath11k_base *ab, struct sk_buff *skb)
 	}
 
 	pdev_id = FIELD_GET(HTT_T2H_PPDU_STATS_INFO_PDEV_ID, data->hdr);
-	pdev_id = DP_HW2SW_MACID(pdev_id);
-	ar = ab->pdevs[pdev_id].ar;
+	ar = ath11k_mac_get_ar_by_pdev_id(ab, pdev_id);
+	if (!ar) {
+		ath11k_warn(ab, "invalid pdev id %d on htt pktlog\n", pdev_id);
+		return;
+	}
 
 	trace_ath11k_htt_pktlog(ar, data->payload, len);
 }
diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index aae6e76330da..f349bf2c1ee8 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -2321,7 +2321,7 @@ int ath11k_wmi_pdev_peer_pktlog_filter(struct ath11k *ar, u8 *addr, u8 enable)
 	cmd->tlv_header = FIELD_PREP(WMI_TLV_TAG, WMI_TAG_PDEV_PEER_PKTLOG_FILTER_CMD) |
 			  FIELD_PREP(WMI_TLV_LEN, sizeof(*cmd) - TLV_HDR_SIZE);
 
-	cmd->pdev_id = ar->pdev->pdev_id;
+	cmd->pdev_id = DP_HW2SW_MACID(ar->pdev->pdev_id);
 	cmd->num_mac = 1;
 	cmd->enable = enable;
 
@@ -2419,7 +2419,7 @@ int ath11k_wmi_pdev_pktlog_enable(struct ath11k *ar, u32 pktlog_filter)
 	cmd->tlv_header = FIELD_PREP(WMI_TLV_TAG, WMI_TAG_PDEV_PKTLOG_ENABLE_CMD) |
 			  FIELD_PREP(WMI_TLV_LEN, sizeof(*cmd) - TLV_HDR_SIZE);
 
-	cmd->pdev_id = ar->pdev->pdev_id;
+	cmd->pdev_id = DP_HW2SW_MACID(ar->pdev->pdev_id);
 	cmd->evlist = pktlog_filter;
 	cmd->enable = ATH11K_WMI_PKTLOG_ENABLE_FORCE;
 
@@ -2449,7 +2449,7 @@ int ath11k_wmi_pdev_pktlog_disable(struct ath11k *ar)
 	cmd->tlv_header = FIELD_PREP(WMI_TLV_TAG, WMI_TAG_PDEV_PKTLOG_DISABLE_CMD) |
 			  FIELD_PREP(WMI_TLV_LEN, sizeof(*cmd) - TLV_HDR_SIZE);
 
-	cmd->pdev_id = ar->pdev->pdev_id;
+	cmd->pdev_id = DP_HW2SW_MACID(ar->pdev->pdev_id);
 
 	ret = ath11k_wmi_cmd_send(wmi, skb,
 				  WMI_PDEV_PKTLOG_DISABLE_CMDID);
-- 
2.7.4

