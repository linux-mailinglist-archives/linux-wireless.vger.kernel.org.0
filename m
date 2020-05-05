Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 857681C502D
	for <lists+linux-wireless@lfdr.de>; Tue,  5 May 2020 10:24:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725915AbgEEIYB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 5 May 2020 04:24:01 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:21265 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725766AbgEEIYA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 5 May 2020 04:24:00 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588667040; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=QbuBmPty6sYHJmDdYUPa/PrW7ejMHdsCRelaXowWGh8=; b=T8hLsHpMAkJZtD18MuCz3Yl8BYzX2LZI4oov8w/YWM/F/dRn4O5siOsJMeHTaeLxWRNy6F6+
 E3PV/KfFBruwRcaYMgMU8HPTRdbNHDaktX8i+m/8GaEn9cTxvh3Aml7hEAtnEl+gIFbbb/Fd
 5fMKc5MwMdIg62HLNW76ZkDWkyo=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eb12295.7fe68b6e15a8-smtp-out-n01;
 Tue, 05 May 2020 08:23:49 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 4DB7EC433D2; Tue,  5 May 2020 08:23:49 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from pillair-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pillair)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0F071C433CB;
        Tue,  5 May 2020 08:23:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0F071C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=pillair@codeaurora.org
From:   Rakesh Pillai <pillair@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rakesh Pillai <pillair@codeaurora.org>
Subject: [PATCH v2] ath10k: Remove msdu from idr when management pkt send fails
Date:   Tue,  5 May 2020 13:53:35 +0530
Message-Id: <1588667015-25490-1-git-send-email-pillair@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Currently when the sending of any management pkt
via wmi command fails, the packet is being unmapped
freed in the error handling. But the idr entry added,
which is used to track these packet is not getting removed.

Hence, during unload, in wmi cleanup, all the entries
in IDR are removed and the corresponding buffer is
attempted to be freed. This can cause a situation where
one packet is attempted to be freed twice.

Fix this error by rmeoving the msdu from the idr
list when the sending of a management packet over
wmi fails.

Tested HW: WCN3990
Tested FW: WLAN.HL.3.1-01040-QCAHLSWMTPLZ-1

Fixes: 1807da49733e ("ath10k: wmi: add management tx by reference support over wmi")
Signed-off-by: Rakesh Pillai <pillair@codeaurora.org>
---
Changes from v1:
- Added a helper function in wmi-ops for cleanup_mgmt_tx_send
---
 drivers/net/wireless/ath/ath10k/wmi-ops.h | 15 ++++++++++++++-
 drivers/net/wireless/ath/ath10k/wmi-tlv.c | 15 +++++++++++++++
 2 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath10k/wmi-ops.h b/drivers/net/wireless/ath/ath10k/wmi-ops.h
index 1491c25..8c3a656 100644
--- a/drivers/net/wireless/ath/ath10k/wmi-ops.h
+++ b/drivers/net/wireless/ath/ath10k/wmi-ops.h
@@ -133,6 +133,7 @@ struct wmi_ops {
 	struct sk_buff *(*gen_mgmt_tx_send)(struct ath10k *ar,
 					    struct sk_buff *skb,
 					    dma_addr_t paddr);
+	int (*cleanup_mgmt_tx_send)(struct ath10k *ar, struct sk_buff *msdu);
 	struct sk_buff *(*gen_dbglog_cfg)(struct ath10k *ar, u64 module_enable,
 					  u32 log_level);
 	struct sk_buff *(*gen_pktlog_enable)(struct ath10k *ar, u32 filter);
@@ -442,6 +443,15 @@ ath10k_wmi_get_txbf_conf_scheme(struct ath10k *ar)
 }
 
 static inline int
+ath10k_wmi_cleanup_mgmt_tx_send(struct ath10k *ar, struct sk_buff *msdu)
+{
+	if (!ar->wmi.ops->cleanup_mgmt_tx_send)
+		return -EOPNOTSUPP;
+
+	return ar->wmi.ops->cleanup_mgmt_tx_send(ar, msdu);
+}
+
+static inline int
 ath10k_wmi_mgmt_tx_send(struct ath10k *ar, struct sk_buff *msdu,
 			dma_addr_t paddr)
 {
@@ -457,8 +467,11 @@ ath10k_wmi_mgmt_tx_send(struct ath10k *ar, struct sk_buff *msdu,
 
 	ret = ath10k_wmi_cmd_send(ar, skb,
 				  ar->wmi.cmd->mgmt_tx_send_cmdid);
-	if (ret)
+	if (ret) {
+		/* remove this msdu from idr tracking */
+		ath10k_wmi_cleanup_mgmt_tx_send(ar, msdu);
 		return ret;
+	}
 
 	return 0;
 }
diff --git a/drivers/net/wireless/ath/ath10k/wmi-tlv.c b/drivers/net/wireless/ath/ath10k/wmi-tlv.c
index e1ab900f..2a31a42 100644
--- a/drivers/net/wireless/ath/ath10k/wmi-tlv.c
+++ b/drivers/net/wireless/ath/ath10k/wmi-tlv.c
@@ -2898,6 +2898,18 @@ ath10k_wmi_tlv_op_gen_request_stats(struct ath10k *ar, u32 stats_mask)
 }
 
 static int
+ath10k_wmi_tlv_op_cleanup_mgmt_tx_send(struct ath10k *ar,
+				       struct sk_buff *msdu)
+{
+	struct ath10k_skb_cb *cb = ATH10K_SKB_CB(msdu);
+	struct ath10k_wmi *wmi = &ar->wmi;
+
+	idr_remove(&wmi->mgmt_pending_tx, cb->msdu_id);
+
+	return 0;
+}
+
+static int
 ath10k_wmi_mgmt_tx_alloc_msdu_id(struct ath10k *ar, struct sk_buff *skb,
 				 dma_addr_t paddr)
 {
@@ -2971,6 +2983,8 @@ ath10k_wmi_tlv_op_gen_mgmt_tx_send(struct ath10k *ar, struct sk_buff *msdu,
 	if (desc_id < 0)
 		goto err_free_skb;
 
+	cb->msdu_id = desc_id;
+
 	ptr = (void *)skb->data;
 	tlv = ptr;
 	tlv->tag = __cpu_to_le16(WMI_TLV_TAG_STRUCT_MGMT_TX_CMD);
@@ -4419,6 +4433,7 @@ static const struct wmi_ops wmi_tlv_ops = {
 	.gen_force_fw_hang = ath10k_wmi_tlv_op_gen_force_fw_hang,
 	/* .gen_mgmt_tx = not implemented; HTT is used */
 	.gen_mgmt_tx_send = ath10k_wmi_tlv_op_gen_mgmt_tx_send,
+	.cleanup_mgmt_tx_send = ath10k_wmi_tlv_op_cleanup_mgmt_tx_send,
 	.gen_dbglog_cfg = ath10k_wmi_tlv_op_gen_dbglog_cfg,
 	.gen_pktlog_enable = ath10k_wmi_tlv_op_gen_pktlog_enable,
 	.gen_pktlog_disable = ath10k_wmi_tlv_op_gen_pktlog_disable,
-- 
2.7.4
