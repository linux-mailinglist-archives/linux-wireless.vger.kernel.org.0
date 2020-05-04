Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E10491C40AD
	for <lists+linux-wireless@lfdr.de>; Mon,  4 May 2020 19:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729884AbgEDRBh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 4 May 2020 13:01:37 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:30965 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729459AbgEDRBh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 4 May 2020 13:01:37 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588611696; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=fPoux2pQjdP+ZEXNV24YVedAMDvry0ZQnYEZA4UjdyY=; b=EvfJ1UjVQmbHJ8b0csB78Qa4UNBAvMXt8flihFiYcdkO7v1xjlfdE32yHxHcDK0Zm+CAVMll
 qTZlDgVxh6Dx91SeqLEurdinlMA1uRagNYNspmhYGIUQ7Yw/NwfPaZaegIEHWHlF3nd43JGL
 r13Pv7dMa1yp7gk/KutWlyjKMJk=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eb04a57.7ff0eb95a110-smtp-out-n03;
 Mon, 04 May 2020 17:01:11 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 9BDA3C433BA; Mon,  4 May 2020 17:01:10 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from cheath10p342229-lin.qca.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tamizhr)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0365FC433CB;
        Mon,  4 May 2020 17:01:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0365FC433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=tamizhr@codeaurora.org
From:   Tamizh Chelvam <tamizhr@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Tamizh Chelvam <tamizhr@codeaurora.org>
Subject: [PATCH] ath11k: fix kernel panic by freeing the msdu received with invalid length
Date:   Mon,  4 May 2020 22:29:28 +0530
Message-Id: <1588611568-20791-1-git-send-email-tamizhr@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In certain scenario host receives the packets with invalid length
which causes below kernel panic. Free up those msdus to avoid
this kernel panic.

 2270.028121:   <6> task: ffffffc0008306d0 ti: ffffffc0008306d0 task.ti: ffffffc0008306d0
 2270.035247:   <2> PC is at skb_panic+0x40/0x44
 2270.042784:   <2> LR is at skb_panic+0x40/0x44
 2270.521775:   <2> [<ffffffc0004a06e0>] skb_panic+0x40/0x44
 2270.524039:   <2> [<ffffffc0004a1278>] skb_put+0x54/0x5c
 2270.529264:   <2> [<ffffffbffcc373a8>] ath11k_dp_process_rx_err+0x320/0x5b0 [ath11k]
 2270.533860:   <2> [<ffffffbffcc30b68>] ath11k_dp_service_srng+0x80/0x268 [ath11k]
 2270.541063:   <2> [<ffffffbffcc1d554>] ath11k_hal_rx_reo_ent_buf_paddr_get+0x200/0xb64 [ath11k]
 2270.547917:   <2> [<ffffffc0004b1f74>] net_rx_action+0xf8/0x274
 2270.556247:   <2> [<ffffffc000099df4>] __do_softirq+0x128/0x228
 2270.561625:   <2> [<ffffffc00009a130>] irq_exit+0x84/0xcc
 2270.567008:   <2> [<ffffffc0000cfb28>] __handle_domain_irq+0x8c/0xb0
 2270.571695:   <2> [<ffffffc000082484>] gic_handle_irq+0x6c/0xbc

Signed-off-by: Tamizh Chelvam <tamizhr@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/dp_rx.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index 47ad3bd..90d2d47 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -2270,6 +2270,7 @@ static int ath11k_dp_rx_process_msdu(struct ath11k *ar,
 	struct ieee80211_hdr *hdr;
 	struct sk_buff *last_buf;
 	u8 l3_pad_bytes;
+	u8 *hdr_status;
 	u16 msdu_len;
 	int ret;
 
@@ -2298,8 +2299,13 @@ static int ath11k_dp_rx_process_msdu(struct ath11k *ar,
 		skb_pull(msdu, HAL_RX_DESC_SIZE);
 	} else if (!rxcb->is_continuation) {
 		if ((msdu_len + HAL_RX_DESC_SIZE) > DP_RX_BUFFER_SIZE) {
+			hdr_status = ath11k_dp_rx_h_80211_hdr(rx_desc);
 			ret = -EINVAL;
 			ath11k_warn(ar->ab, "invalid msdu len %u\n", msdu_len);
+			ath11k_dbg_dump(ar->ab, ATH11K_DBG_DATA, NULL, "", hdr_status,
+					sizeof(struct ieee80211_hdr));
+			ath11k_dbg_dump(ar->ab, ATH11K_DBG_DATA, NULL, "", rx_desc,
+					sizeof(struct hal_rx_desc));
 			goto free_out;
 		}
 		skb_put(msdu, HAL_RX_DESC_SIZE + l3_pad_bytes + msdu_len);
@@ -3394,6 +3400,7 @@ static int ath11k_dp_rx_frag_h_mpdu(struct ath11k *ar,
 	struct sk_buff *msdu;
 	struct ath11k_skb_rxcb *rxcb;
 	struct hal_rx_desc *rx_desc;
+	u8 *hdr_status;
 	u16 msdu_len;
 
 	spin_lock_bh(&rx_ring->idr_lock);
@@ -3431,6 +3438,17 @@ static int ath11k_dp_rx_frag_h_mpdu(struct ath11k *ar,
 
 	rx_desc = (struct hal_rx_desc *)msdu->data;
 	msdu_len = ath11k_dp_rx_h_msdu_start_msdu_len(rx_desc);
+	if ((msdu_len + HAL_RX_DESC_SIZE) > DP_RX_BUFFER_SIZE) {
+		hdr_status = ath11k_dp_rx_h_80211_hdr(rx_desc);
+		ath11k_warn(ar->ab, "invalid msdu leng %u", msdu_len);
+		ath11k_dbg_dump(ar->ab, ATH11K_DBG_DATA, NULL, "", hdr_status,
+				sizeof(struct ieee80211_hdr));
+		ath11k_dbg_dump(ar->ab, ATH11K_DBG_DATA, NULL, "", rx_desc,
+				sizeof(struct hal_rx_desc));
+		dev_kfree_skb_any(msdu);
+		goto exit;
+	}
+
 	skb_put(msdu, HAL_RX_DESC_SIZE + msdu_len);
 
 	if (ath11k_dp_rx_frag_h_mpdu(ar, msdu, ring_desc)) {
-- 
1.9.1
