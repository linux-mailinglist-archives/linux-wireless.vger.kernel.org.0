Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 916E56B9056
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Mar 2023 11:42:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbjCNKmE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Mar 2023 06:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbjCNKlv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Mar 2023 06:41:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5FDF6A1E6
        for <linux-wireless@vger.kernel.org>; Tue, 14 Mar 2023 03:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678790328;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=KQ2NL75tj/rjA/WpjtLRRXGonxIa46DC8d1nbtWSPlo=;
        b=ViHBILCl5jbtCZIYUSgDznP2ALzo4qavvFfY9357UoJTqx8Gofhfu1dogDpyc8aV2KqXV9
        qPETLh5kfacciQAqVVBnL47pfQsT4t0+GVAuHU3lRUrEUAISIOe2cEWfMsrm5aprFFwwQ9
        6VmPeSpckGV4MVvR2cftBjdFOuxNxRg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-553-QFhKFowFP9uXPXAaZkQr-w-1; Tue, 14 Mar 2023 06:38:45 -0400
X-MC-Unique: QFhKFowFP9uXPXAaZkQr-w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5ACE0857A81;
        Tue, 14 Mar 2023 10:38:45 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.39.192.170])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C7058140EBF4;
        Tue, 14 Mar 2023 10:38:43 +0000 (UTC)
From:   Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To:     gregory.greenman@intel.com, kvalo@kernel.org,
        johannes.berg@intel.com, linux-wireless@vger.kernel.org
Cc:     Jose Ignacio Tornos Martinez <jtornosm@redhat.com>,
        Petr Stourac <pstourac@redhat.com>
Subject: [PATCH] iwlwifi: mvm: fix double list_add at iwl_mvm_mac_wake_tx_queue (roaming)
Date:   Tue, 14 Mar 2023 11:38:40 +0100
Message-Id: <20230314103840.30771-1-jtornosm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Issues like this, in scenarios with continuous roaming, have been reported:

...
[149909.128985] wlp3s0: disconnect from AP 34:13:e8:b1:db:9a for new auth to 34:13:e8:3c:fb:db
[149909.307717] wlp3s0: authenticate with 34:13:e8:3c:fb:db
[149909.313266] wlp3s0: 80 MHz not supported, disabling VHT
[149909.430578] wlp3s0: send auth to 34:13:e8:3c:fb:db (try 1/3)
[149909.482194] wlp3s0: authenticated
[149909.487314] wlp3s0: associate with 34:13:e8:3c:fb:db (try 1/3)
[149909.507995] wlp3s0: RX ReassocResp from 34:13:e8:3c:fb:db (capab=0x411 status=0 aid=1)
[149909.523045] wlp3s0: associated
[149911.155963] wlp3s0: disconnect from AP 34:13:e8:3c:fb:db for new auth to 34:13:e8:b1:db:9a
[149911.338758] wlp3s0: authenticate with 34:13:e8:b1:db:9a
[149911.344214] wlp3s0: 80 MHz not supported, disabling VHT
[149911.461627] wlp3s0: send auth to 34:13:e8:b1:db:9a (try 1/3)
[149911.527693] wlp3s0: authenticated
[149911.531890] wlp3s0: associate with 34:13:e8:b1:db:9a (try 1/3)
[149911.555003] wlp3s0: RX ReassocResp from 34:13:e8:b1:db:9a (capab=0x411 status=0 aid=1)
[149911.570254] wlp3s0: associated
[149913.302972] wlp3s0: disconnect from AP 34:13:e8:b1:db:9a for new auth to 34:13:e8:3c:fb:db
[149913.512736] wlp3s0: authenticate with 34:13:e8:3c:fb:db
[149913.518183] wlp3s0: 80 MHz not supported, disabling VHT
[149913.635546] wlp3s0: send auth to 34:13:e8:3c:fb:db (try 1/3)
[149913.672891] list_add double add: new=ffff8e66943f1300, prev=ffff8e66943f1300, next=ffff8e6692a72300.
[149913.688659] ------------[ cut here ]------------
[149913.699785] kernel BUG at lib/list_debug.c:33!
[149913.704403] invalid opcode: 0000 [#1] PREEMPT SMP PTI
[149913.709540] CPU: 1 PID: 626 Comm: wpa_supplicant Not tainted 6.2.0-rc6+ #6
[149913.716602] Hardware name: Dell Inc. Inspiron 660s/0478VN       , BIOS A07 08/24/2012
[149913.724725] RIP: 0010:__list_add_valid.cold+0x23/0x5b
[149913.729953] Code: 01 00 e9 f0 be 90 ff 48 c7 c7 e8 38 7b 90 e8 4b 6d fd ff 0f 0b 48 89 f2 4c 89 c1 48 89 fe 48 c7 c7 e8 39 7b 90 e8 34 6d fd ff <0f> 0b 48 89 d1 4c 89 c6 4c 89 ca 48 c7 c7 90 39 7b 90 e8 1d 6d fd
[149913.749125] RSP: 0018:ffff9c0a009b7708 EFLAGS: 00010286
[149913.754437] RAX: 0000000000000058 RBX: ffff8e66943f1300 RCX: 0000000000000000
[149913.761853] RDX: 0000000000000201 RSI: ffffffff90799b20 RDI: 00000000ffffffff
[149913.769192] RBP: ffff8e66943f12e8 R08: 77656e203a646461 R09: 20656c62756f6420
[149913.776532] R10: 20656c62756f6420 R11: 6464615f7473696c R12: ffff8e6692a72080
[149913.783873] R13: ffff8e66943f1300 R14: ffff8e6692a72300 R15: ffff8e6692a708e0
[149913.791214] FS:  00007f2e55a027c0(0000) GS:ffff8e669a300000(0000) knlGS:0000000000000000
[149913.799438] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[149913.805353] CR2: 00007f101a652ce0 CR3: 0000000108404006 CR4: 00000000000606e0
[149913.812681] Call Trace:
[149913.815332]  <TASK>
[149913.817552]  iwl_mvm_mac_wake_tx_queue+0xb5/0x114 [iwlmvm]
[149913.823256]  ieee80211_queue_skb+0x2ca/0x730 [mac80211]
[149913.828752]  ieee80211_tx+0x9a/0x110 [mac80211]
...

This can be reproduced with a single script from the station:
    while true; do
        wpa_cli -i wlp3s0 roam 34:13:E8:B1:DB:9A
        sleep 2
        wpa_cli -i wlp3s0 roam 34:13:E8:3C:FB:DB
        sleep 2
    done
And flooding with tx traffic.

The reason is the race condition produced in iwl_mvm_mac_wake_tx_queue when
add_stream_txqs is added to que list but only if the list is empty, because
iwl_mvm_mac_wake_tx_queue can be called concurrently. In the previous example,
it has been seen that two simultaneous executions of iwl_mvm_mac_wake_tx_queue
have progressed by adding to the list because the queue was empty at that
moment for both and the second one tried to add the same element to the list.

So protection for this operation is needed. After applying the solution, the
problem does not reproduce.

Fixes: cfbc6c4c5b91c ("iwlwifi: mvm: support mac80211 TXQs model")
Reported-by: Petr Stourac <pstourac@redhat.com>
Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c | 9 ++++++++-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h      | 1 +
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c      | 1 +
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 5273ade71117..6d591b48f1bf 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -787,11 +787,18 @@ static void iwl_mvm_mac_wake_tx_queue(struct ieee80211_hw *hw,
 		return;
 	}
 
+	spin_lock_bh(&mvmtxq->list_lock);
+
 	/* The list is being deleted only after the queue is fully allocated. */
-	if (!list_empty(&mvmtxq->list))
+	if (!list_empty(&mvmtxq->list)) {
+		spin_unlock_bh(&mvmtxq->list_lock);
 		return;
+	}
 
 	list_add_tail(&mvmtxq->list, &mvm->add_stream_txqs);
+
+	spin_unlock_bh(&mvmtxq->list_lock);
+
 	schedule_work(&mvm->add_stream_wk);
 }
 
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
index ce6b701f3f4c..f51bdb4d41fb 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mvm.h
@@ -727,6 +727,7 @@ enum iwl_mvm_queue_status {
 
 struct iwl_mvm_txq {
 	struct list_head list;
+	spinlock_t list_lock;
 	u16 txq_id;
 	atomic_t tx_request;
 	bool stopped;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
index 69634fb82a9b..252a652be79f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -1705,6 +1705,7 @@ int iwl_mvm_add_sta(struct iwl_mvm *mvm,
 
 		mvmtxq->txq_id = IWL_MVM_INVALID_QUEUE;
 		INIT_LIST_HEAD(&mvmtxq->list);
+		spin_lock_init(&mvmtxq->list_lock);
 		atomic_set(&mvmtxq->tx_request, 0);
 	}
 
-- 
2.38.1

