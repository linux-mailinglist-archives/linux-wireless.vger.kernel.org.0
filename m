Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E92363736AF
	for <lists+linux-wireless@lfdr.de>; Wed,  5 May 2021 11:01:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231875AbhEEJB6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 5 May 2021 05:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbhEEJB6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 5 May 2021 05:01:58 -0400
X-Greylist: delayed 171 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 05 May 2021 02:01:02 PDT
Received: from mail.as201155.net (mail.as201155.net [IPv6:2a05:a1c0:f001::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F822C061574
        for <linux-wireless@vger.kernel.org>; Wed,  5 May 2021 02:01:02 -0700 (PDT)
Received: from smtps.newmedia-net.de ([2a05:a1c0:0:de::167]:58612 helo=webmail.newmedia-net.de)
        by mail.as201155.net with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
        (Exim 4.82_1-5b7a7c0-XX)
        (envelope-from <s.gottschall@dd-wrt.com>)
        id 1leDM7-0004E8-2j; Wed, 05 May 2021 10:58:07 +0200
X-CTCH-RefID: str=0001.0A782F16.60925E1F.00D0,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=dd-wrt.com; s=mikd;
        h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From; bh=P85S0XPIM6wCqaYwWRfiHU2er+qx8scogUOEsj3QIwg=;
        b=qJ3/CDN8bQh1MesFIfbSw3ePuv0vNzwbq7HmRx6llr9sU2+kuEIfutSAXBGdHxru5F8AB5UAom9evLmgO92j+SSzwmPkl9J+Onj4ytc2cebKvWlZWJ/WO8ueRPb6GuSjE3KHew+mf+qNYRgVaAIZhzls6if7fhrqehFc6crMN9s=;
From:   Sebastian Gottschall <s.gottschall@dd-wrt.com>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Sebastian Gottschall <s.gottschall@dd-wrt.com>
Subject: [PATCH] ath10k: Fix tx hanging
Date:   Wed,  5 May 2021 15:58:06 +0700
Message-Id: <20210505085806.11474-1-s.gottschall@dd-wrt.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Received:  from [81.201.155.134] (helo=linux.suse)
        by webmail.newmedia-net.de with esmtpa (Exim 4.72)
        (envelope-from <s.gottschall@dd-wrt.com>)
        id 1leDM7-000TIB-Ja; Wed, 05 May 2021 10:58:07 +0200
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

While running stress tests in roaming scenarios (switching ap's every 5
seconds, we discovered a issue which leads to tx hangings of exactly 5
seconds while or after scanning for new accesspoints. We found out that
this hanging is triggered by ath10k_mac_wait_tx_complete since the
empty_tx_wq was not wake when the num_tx_pending counter reaches zero.
To fix this, we simply move the wake_up call to htt_tx_dec_pending,
since this call was missed on several locations within the ath10k code.

Signed-off-by: Sebastian Gottschall <s.gottschall@dd-wrt.com>
---
 drivers/net/wireless/ath/ath10k/htt_tx.c | 3 +++
 drivers/net/wireless/ath/ath10k/txrx.c   | 2 --
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/htt_tx.c b/drivers/net/wireless/ath/ath10k/htt_tx.c
index d6b8bdcef416..b793eac2cfac 100644
--- a/drivers/net/wireless/ath/ath10k/htt_tx.c
+++ b/drivers/net/wireless/ath/ath10k/htt_tx.c
@@ -147,6 +147,9 @@ void ath10k_htt_tx_dec_pending(struct ath10k_htt *htt)
 	htt->num_pending_tx--;
 	if (htt->num_pending_tx == htt->max_num_pending_tx - 1)
 		ath10k_mac_tx_unlock(htt->ar, ATH10K_TX_PAUSE_Q_FULL);
+
+	if (htt->num_pending_tx == 0)
+		wake_up(&htt->empty_tx_wq);
 }
 
 int ath10k_htt_tx_inc_pending(struct ath10k_htt *htt)
diff --git a/drivers/net/wireless/ath/ath10k/txrx.c b/drivers/net/wireless/ath/ath10k/txrx.c
index 7c9ea0c073d8..6f8b64218894 100644
--- a/drivers/net/wireless/ath/ath10k/txrx.c
+++ b/drivers/net/wireless/ath/ath10k/txrx.c
@@ -82,8 +82,6 @@ int ath10k_txrx_tx_unref(struct ath10k_htt *htt,
 	flags = skb_cb->flags;
 	ath10k_htt_tx_free_msdu_id(htt, tx_done->msdu_id);
 	ath10k_htt_tx_dec_pending(htt);
-	if (htt->num_pending_tx == 0)
-		wake_up(&htt->empty_tx_wq);
 	spin_unlock_bh(&htt->tx_lock);
 
 	rcu_read_lock();
-- 
2.31.1

