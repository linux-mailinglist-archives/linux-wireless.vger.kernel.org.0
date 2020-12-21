Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F2782DF78B
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Dec 2020 02:56:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726129AbgLUBx5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 20 Dec 2020 20:53:57 -0500
Received: from so254-31.mailgun.net ([198.61.254.31]:48774 "EHLO
        so254-31.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbgLUBx5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 20 Dec 2020 20:53:57 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1608515613; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=QQKZtdU5aapl2TsfW56Emn7Tl65Rubj/ruzexWFDQes=; b=uOMO1cid/hwFaLUnzM43LGJGy5XaIvXYDG+x9uNynQXRtxKDLzpMTsE/7R8aVcN52wnGtY8X
 0IvQh9dvVQz6Tm1E42egjweqWSvxgxR81Mq+JxLO+Kve8qHIyaI5QAKMFwJ0ZfXVeMpeqcV8
 qV9sRdEqhNZ3s7HBX58Esf7Z920=
X-Mailgun-Sending-Ip: 198.61.254.31
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 5fe00001f5e9af65f8047765 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 21 Dec 2020 01:53:05
 GMT
Sender: miaoqing=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C4F26C433CA; Mon, 21 Dec 2020 01:53:05 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from miaoqing-HP-Z220-SFF-Workstation.ap.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: miaoqing)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 220E4C433C6;
        Mon, 21 Dec 2020 01:53:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 220E4C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=miaoqing@codeaurora.org
From:   Miaoqing Pan <miaoqing@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Miaoqing Pan <miaoqing@codeaurora.org>
Subject: [PATCH] ath10k: fix wmi mgmt tx queue full due to race condition
Date:   Mon, 21 Dec 2020 09:52:59 +0800
Message-Id: <1608515579-1066-1-git-send-email-miaoqing@codeaurora.org>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Failed to transmit wmi management frames:

[84977.840894] ath10k_snoc a000000.wifi: wmi mgmt tx queue is full
[84977.840913] ath10k_snoc a000000.wifi: failed to transmit packet, dropping: -28
[84977.840924] ath10k_snoc a000000.wifi: failed to submit frame: -28
[84977.840932] ath10k_snoc a000000.wifi: failed to transmit frame: -28

This issue is caused by race condition between skb_dequeue and
__skb_queue_tail. The queue of ‘wmi_mgmt_tx_queue’ is protected by a
different lock: ar->data_lock vs list->lock, the result is no protection.
So when ath10k_mgmt_over_wmi_tx_work() and ath10k_mac_tx_wmi_mgmt()
running concurrently on different CPUs, there appear to be a rare corner
cases when the queue length is 1,

  CPUx (skb_deuque)			CPUy (__skb_queue_tail)
					next=list
					prev=list
  struct sk_buff *skb = skb_peek(list);	WRITE_ONCE(newsk->next, next);
  WRITE_ONCE(list->qlen, list->qlen - 1);WRITE_ONCE(newsk->prev, prev);
  next       = skb->next;		WRITE_ONCE(next->prev, newsk);
  prev       = skb->prev;		WRITE_ONCE(prev->next, newsk);
  skb->next  = skb->prev = NULL;	list->qlen++;
  WRITE_ONCE(next->prev, prev);
  WRITE_ONCE(prev->next, next);

If the instruction ‘next = skb->next’ is executed before
‘WRITE_ONCE(prev->next, newsk)’, newsk will be lost, as CPUx get the
old ‘next’ pointer, but the length is still added by one. The final
result is the length of the queue will reach the maximum value but
the queue is empty.

So remove ar->data_lock, and use 'skb_queue_tail' instead of
'__skb_queue_tail' to prevent the potential race condition.

Tested-on: WCN3990 hw1.0 SNOC WLAN.HL.3.1.c2-00033-QCAHLSWMTPLZ-1

Signed-off-by: Miaoqing Pan <miaoqing@codeaurora.org>
---
 drivers/net/wireless/ath/ath10k/mac.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
index dc32c78..5da1504 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -3763,23 +3763,16 @@ bool ath10k_mac_tx_frm_has_freq(struct ath10k *ar)
 static int ath10k_mac_tx_wmi_mgmt(struct ath10k *ar, struct sk_buff *skb)
 {
 	struct sk_buff_head *q = &ar->wmi_mgmt_tx_queue;
-	int ret = 0;
-
-	spin_lock_bh(&ar->data_lock);
 
 	if (skb_queue_len(q) == ATH10K_MAX_NUM_MGMT_PENDING) {
 		ath10k_warn(ar, "wmi mgmt tx queue is full\n");
-		ret = -ENOSPC;
-		goto unlock;
+		return -ENOSPC;
 	}
 
-	__skb_queue_tail(q, skb);
+	skb_queue_tail(q, skb);
 	ieee80211_queue_work(ar->hw, &ar->wmi_mgmt_tx_work);
 
-unlock:
-	spin_unlock_bh(&ar->data_lock);
-
-	return ret;
+	return 0;
 }
 
 static enum ath10k_mac_tx_path
-- 
2.7.4

