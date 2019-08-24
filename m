Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA7229BE11
	for <lists+linux-wireless@lfdr.de>; Sat, 24 Aug 2019 15:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727706AbfHXNtI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 24 Aug 2019 09:49:08 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:47070 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727684AbfHXNtI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 24 Aug 2019 09:49:08 -0400
Received: by mail-lj1-f194.google.com with SMTP id f9so11259153ljc.13
        for <linux-wireless@vger.kernel.org>; Sat, 24 Aug 2019 06:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y4ckJfUXdxYeBz+7wUqFbJD/Jfd+wV+ceQz91vng7WE=;
        b=pL5AguciFr7X2gsSdc3TNpb1ed6bl+g7M4AAddaaY9xi2KpWXdDnoQgeep9RrZa5x5
         rOmwuZz3Yr0tJc6ezrCliHytRDTDp5WPlSCHGgnmUGuoutPhtPiTd5h+ZQ9EBv5Pl1lV
         nbb45ze9jgw6Yn04I8wS96RfzKTkI2Xi2MvovewXFM8XDGXG0BPthUVU+L07TxEy7a+v
         bZ7sYu790IFyDqtPcECPqIDgZhzQ7dQoeAbfVIYz5nA2Hszge2I2AYIKe2rjHpLvVjSh
         rExFNHzMe7oGlUS2lTqEl3VRwHq/HS4CVB1qQf7KFQ9MC9wtobUU3FTguBPHYGO+JP0G
         dy2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y4ckJfUXdxYeBz+7wUqFbJD/Jfd+wV+ceQz91vng7WE=;
        b=JwgVh1p28Nrp2iNR0Eaxv1KrhT92q2rqAqV6Bnp7v6XJzr5YOs4XHAZ9sUpq3L4sLv
         ULJjbLiey7nsdIS+t/6PExZsz0swPqVCCaqpcqyUQHpATs0XAG9RGiCMs3/1RM36xS9Y
         cP9L+cpTOEYYXGN6xFn2ztIxraj7jpkBy2D4wqq7ZbX9QBxbogdYhGOH+Nr+jRpKZJGS
         zyDBdqjpZpHU5J7Ws3+Lk3Uw1rt01dGZeh83BvYyCwhVjUrba3RRfOl8Cd/YR+OCo3IV
         /LiJVBPTFi26xdk+l+X0NQUiEa1BX05BPCOEJQ9+FvE3omKO5nBxlu7eK0aTjpI/3oQB
         0HJw==
X-Gm-Message-State: APjAAAUIv5GF2caX6sHLeIINYSSvYOPkJW2UAtIV20uLDUFDyNcUxAHM
        7tTGT62m8bPeidwrkPrcdwY=
X-Google-Smtp-Source: APXvYqzr60mv7xW7ASDmfqWZlIngrlE4CousXz3jEzXHAASMbLtBMj2SVsJBfe3nyVQ1KgCzEZFuJg==
X-Received: by 2002:a2e:2f0d:: with SMTP id v13mr5561854ljv.198.1566654546588;
        Sat, 24 Aug 2019 06:49:06 -0700 (PDT)
Received: from localhost.localdomain (81-233-89-221-no75.tbcn.telia.com. [81.233.89.221])
        by smtp.gmail.com with ESMTPSA id s7sm1115950lji.26.2019.08.24.06.49.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Aug 2019 06:49:06 -0700 (PDT)
From:   Erik Stromdahl <erik.stromdahl@gmail.com>
To:     kvalo@qca.qualcomm.com, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org
Cc:     Erik Stromdahl <erik.stromdahl@gmail.com>
Subject: [PATCH] ath10k: remove TX lock from ath10k_htt_tx_inc_pending
Date:   Sat, 24 Aug 2019 15:48:57 +0200
Message-Id: <20190824134857.4094-1-erik.stromdahl@gmail.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This commit removes the call to ath10k_mac_tx_lock() from
ath10k_htt_tx_inc_pending() in case the high water mark is reached.

ath10k_mac_tx_lock() calls ieee80211_stop_queues() in order to stop
mac80211 from pushing more TX data to the driver (this is the TX lock).

If a driver is trying to fetch an skb from a queue while the queue is
stopped, ieee80211_tx_dequeue() will return NULL.

So, in ath10k_mac_tx_push_txq(), there is a risk that the call to
ath10k_htt_tx_inc_pending() results in a stop of the mac80211 TX queues
just before the skb is fetched.

This will cause ieee80211_tx_dequeue() to return NULL and
ath10k_mac_tx_push_txq() to exit prematurely and return -ENOENT.
Before the function returns ath10k_htt_tx_dec_pending() will be called.
This call will re-enable the TX queues through ath10k_mac_tx_unlock().
When ath10k_mac_tx_push_txq() has returned, the TX queue will be
returned back to mac80211 with ieee80211_return_txq() without the skb
being properly consumed.

Since the TX queues were re-enabled in the error exit path of
ath10k_mac_tx_push_txq(), mac80211 can continue pushing data to the
driver. If the hardware does not consume the data, the above mentioned
case will be repeated over and over.

A case when the hardware is not able to transmit the data from the host
is when a STA has been dis-associated from an AP and has not yet been
able to re-associate. In this case there will be no TX_COMPL_INDs from
the hardware, resulting in the TX counter not be decremented.

This phenomenon has been observed in both a real and a test setup.

In order to fix this, the actual TX locking (the call to
ath10k_mac_tx_lock()) was removed from ath10k_htt_tx_inc_pending().
Instead, ath10k_mac_tx_lock() is called separately after the skb has
been fetched (after the call to ieee80211_tx_dequeue()). At this point
it is OK to stop the queues.

Signed-off-by: Erik Stromdahl <erik.stromdahl@gmail.com>
---
 drivers/net/wireless/ath/ath10k/htt_tx.c | 2 --
 drivers/net/wireless/ath/ath10k/mac.c    | 8 ++++++++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/htt_tx.c b/drivers/net/wireless/ath/ath10k/htt_tx.c
index 2ef717f18795..32fd71f28ef9 100644
--- a/drivers/net/wireless/ath/ath10k/htt_tx.c
+++ b/drivers/net/wireless/ath/ath10k/htt_tx.c
@@ -157,8 +157,6 @@ int ath10k_htt_tx_inc_pending(struct ath10k_htt *htt)
 		return -EBUSY;
 
 	htt->num_pending_tx++;
-	if (htt->num_pending_tx == htt->max_num_pending_tx)
-		ath10k_mac_tx_lock(htt->ar, ATH10K_TX_PAUSE_Q_FULL);
 
 	return 0;
 }
diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
index c1bf1167a2ce..8d357c79ca59 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -4078,6 +4078,11 @@ int ath10k_mac_tx_push_txq(struct ieee80211_hw *hw,
 		return -ENOENT;
 	}
 
+	spin_lock_bh(&ar->htt.tx_lock);
+	if (htt->num_pending_tx == htt->max_num_pending_tx)
+		ath10k_mac_tx_lock(ar, ATH10K_TX_PAUSE_Q_FULL);
+	spin_unlock_bh(&ar->htt.tx_lock);
+
 	airtime = ath10k_mac_update_airtime(ar, txq, skb);
 	ath10k_mac_tx_h_fill_cb(ar, vif, txq, skb, airtime);
 
@@ -4370,6 +4375,9 @@ static void ath10k_mac_op_tx(struct ieee80211_hw *hw,
 			return;
 		}
 
+		if (htt->num_pending_tx == htt->max_num_pending_tx)
+			ath10k_mac_tx_lock(ar, ATH10K_TX_PAUSE_Q_FULL);
+
 		ret = ath10k_htt_tx_mgmt_inc_pending(htt, is_mgmt, is_presp);
 		if (ret) {
 			ath10k_dbg(ar, ATH10K_DBG_MAC, "failed to increase tx mgmt pending count: %d, dropping\n",
-- 
2.22.0

