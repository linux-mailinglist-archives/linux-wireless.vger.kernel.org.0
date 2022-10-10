Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FA5B5F9AD6
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Oct 2022 10:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232149AbiJJIQo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 10 Oct 2022 04:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232147AbiJJIQj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 10 Oct 2022 04:16:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54B8358177
        for <linux-wireless@vger.kernel.org>; Mon, 10 Oct 2022 01:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665389788;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=M/N4xF8fEpFP+eN1dNDfrA/GAu2UYXmS8p3OpwqipvI=;
        b=fteccEnuH+0EQ4k3vE9Ng848mFsDZ63qZWo2Ygg5rJk7WodmqLI449J4OOileWO640/pEQ
        ak/xyjxtGRQk+35rGS/03mjXGrOMMlzxDhK/5KH7Cb7cBLb1XHWsGznHNWjFMO9nsFe3VW
        V996vhLELzgMwLnx8IggWV27dvfSioU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-601-HNMvOqFIMwa_jI30QhQK1g-1; Mon, 10 Oct 2022 04:16:21 -0400
X-MC-Unique: HNMvOqFIMwa_jI30QhQK1g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4F5063C10220;
        Mon, 10 Oct 2022 08:16:21 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.39.192.159])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E17B4C15BA5;
        Mon, 10 Oct 2022 08:16:19 +0000 (UTC)
From:   Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To:     jtornosm@redhat.com
Cc:     gregory.greenman@intel.com, kvalo@kernel.org,
        linux-wireless@vger.kernel.org, pstourac@redhat.com
Subject: [PATCH v2] iwlwifi: mvm: fix double list_add at iwl_mvm_mac_wake_tx_queue (other cases)
Date:   Mon, 10 Oct 2022 10:16:11 +0200
Message-Id: <20221010081611.145027-1-jtornosm@redhat.com>
In-Reply-To: <20220909121235.575541-1-jtornosm@redhat.com>
References: <20220909121235.575541-1-jtornosm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

BUGs like this are still reproducible:

[   31.509616] list_add corruption. prev->next should be next (ffff8f8644242300), but was ffff8f86493fd300. (prev=ffff8f86493fd300).
[   31.521544] ------------[ cut here ]------------
[   31.526248] kernel BUG at lib/list_debug.c:30!
[   31.530781] invalid opcode: 0000 [#1] PREEMPT SMP PTI
[   31.535831] CPU: 1 PID: 626 Comm: wpa_supplicant Not tainted 6.0.0+ #7
[   31.542450] Hardware name: Dell Inc. Inspiron 660s/0478VN       , BIOS A07 08/24/2012
[   31.550484] RIP: 0010:__list_add_valid.cold+0x3a/0x5b
[   31.555537] Code: f2 4c 89 c1 48 89 fe 48 c7 c7 28 20 69 89 e8 4c e3 fd ff 0f 0b 48 89 d1 4c 89 c6 4c 89 ca 48 c7 c7 d0 1f 69 89 e8 35 e3 fd ff <0f> 0b 4c 89 c1 48 c7 c7 78 1f 69 89 e8 24 e3 fd ff 0f 0b 48 c7 c7
[   31.574605] RSP: 0018:ffff9f6f00dc3748 EFLAGS: 00010286
[   31.579990] RAX: 0000000000000075 RBX: ffff8f8644242080 RCX: 0000000000000000
[   31.587155] RDX: 0000000000000201 RSI: ffffffff8967862d RDI: 00000000ffffffff
[   31.594482] RBP: ffff8f86493fd2e8 R08: 0000000000000000 R09: 00000000ffffdfff
[   31.601735] R10: ffff9f6f00dc3608 R11: ffffffff89f46128 R12: ffff8f86493fd300
[   31.608986] R13: ffff8f86493fd300 R14: ffff8f8644242300 R15: ffff8f8643dd3f2c
[   31.616151] FS:  00007f3bb9a707c0(0000) GS:ffff8f865a300000(0000) knlGS:0000000000000000
[   31.624447] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   31.630286] CR2: 00007fe3647d5600 CR3: 00000001125a6002 CR4: 00000000000606e0
[   31.637539] Call Trace:
[   31.639936]  <TASK>
[   31.642143]  iwl_mvm_mac_wake_tx_queue+0x71/0x90 [iwlmvm]
[   31.647569]  ieee80211_queue_skb+0x4b6/0x720 [mac80211]
...

So, it is necessary to extend the applied solution with commit 14a3aacf517a9
("iwlwifi: mvm: fix double list_add at iwl_mvm_mac_wake_tx_queue")
to all other cases where the station queues are invalidated and the related
lists are not emptied. Because, otherwise as before, if some new element is 
added later to the list in iwl_mvm_mac_wake_tx_queue, it can match with the 
old one and produce the same commented BUG.

That is, in order to avoid this problem completely, we must also remove the 
related lists for the other cases when station queues are invalidated.

Fixes: cfbc6c4c5b91c ("iwlwifi: mvm: support mac80211 TXQs model")
Reported-by: Petr Stourac <pstourac@redhat.com>
Tested-by: Petr Stourac <pstourac@redhat.com>
Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
---
V1 -> V2:
- More detailed explanation of the patch and add a real case.

 drivers/net/wireless/intel/iwlwifi/mvm/sta.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
index cc92706b3d16..cbd8053a9e35 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -384,6 +384,7 @@ static int iwl_mvm_disable_txq(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
 			iwl_mvm_txq_from_tid(sta, tid);
 
 		mvmtxq->txq_id = IWL_MVM_INVALID_QUEUE;
+		list_del_init(&mvmtxq->list);
 	}
 
 	/* Regardless if this is a reserved TXQ for a STA - mark it as false */
@@ -478,6 +479,7 @@ static int iwl_mvm_remove_sta_queue_marking(struct iwl_mvm *mvm, int queue)
 		mvmsta->tid_data[tid].txq_id = IWL_MVM_INVALID_QUEUE;
 
 		mvmtxq->txq_id = IWL_MVM_INVALID_QUEUE;
+		list_del_init(&mvmtxq->list);
 	}
 
 	mvmsta->tfd_queue_msk &= ~BIT(queue); /* Don't use this queue anymore */
-- 
2.37.3

