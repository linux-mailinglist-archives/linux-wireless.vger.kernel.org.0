Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 344202E0612
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Dec 2020 07:36:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725945AbgLVGfq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Dec 2020 01:35:46 -0500
Received: from so254-31.mailgun.net ([198.61.254.31]:26690 "EHLO
        so254-31.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725300AbgLVGfp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Dec 2020 01:35:45 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1608618921; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=TKB7sI3CKvg+RVej1qQWFlhU6xzxcbfFdpg5n8TXN34=; b=R1xzHyClDmJWI6qOhgXslqbzrzuB2D+gge5aRZgABTmBJ7StpiuQxp6rcOQM5iokJLwCtvrc
 oe+5dvDXnyUdbzgTZLldlrXy/c0MTRKT1rtlxXMdaOA8GzGXN2xYGrd3YJ7SF3H2COIAFERv
 ZVPBgbtHzF86LoYwYch1fXZeMuQ=
X-Mailgun-Sending-Ip: 198.61.254.31
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 5fe1938d1d5c1fa42785d605 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 22 Dec 2020 06:34:53
 GMT
Sender: miaoqing=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 375E5C433CA; Tue, 22 Dec 2020 06:34:53 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from miaoqing-HP-Z220-SFF-Workstation.ap.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: miaoqing)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4602AC433ED;
        Tue, 22 Dec 2020 06:34:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4602AC433ED
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=miaoqing@codeaurora.org
From:   Miaoqing Pan <miaoqing@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, briannorris@chromium.org,
        Miaoqing Pan <miaoqing@codeaurora.org>
Subject: [PATCH v2] ath10k: fix wmi mgmt tx queue full due to race condition
Date:   Tue, 22 Dec 2020 14:34:47 +0800
Message-Id: <1608618887-8857-1-git-send-email-miaoqing@codeaurora.org>
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
'__skb_queue_tail' to prevent the potential race condition. Also switch
to use skb_queue_len_lockless, in case we queue a few SKBs simultaneously.

Tested-on: WCN3990 hw1.0 SNOC WLAN.HL.3.1.c2-00033-QCAHLSWMTPLZ-1

Signed-off-by: Miaoqing Pan <miaoqing@codeaurora.org>
---
v2: use skb_queue_len_lockless instead of skb_queue_len
---
 drivers/net/wireless/ath/ath10k/mac.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
index dc32c78..3cefa13 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -3763,23 +3763,16 @@ bool ath10k_mac_tx_frm_has_freq(struct ath10k *ar)
 static int ath10k_mac_tx_wmi_mgmt(struct ath10k *ar, struct sk_buff *skb)
 {
 	struct sk_buff_head *q = &ar->wmi_mgmt_tx_queue;
-	int ret = 0;
-
-	spin_lock_bh(&ar->data_lock);
 
-	if (skb_queue_len(q) == ATH10K_MAX_NUM_MGMT_PENDING) {
+	if (skb_queue_len_lockless(q) >= ATH10K_MAX_NUM_MGMT_PENDING) {
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

