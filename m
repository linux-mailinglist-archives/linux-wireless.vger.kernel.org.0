Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 375975B37A1
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Sep 2022 14:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbiIIMVG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 9 Sep 2022 08:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230468AbiIIMUs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 9 Sep 2022 08:20:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1E82AFAD2
        for <linux-wireless@vger.kernel.org>; Fri,  9 Sep 2022 05:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662725941;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=EfsZnF1MxqcOt9mj3bMzAU3DiTkhC8DUqbe0H9bEk3w=;
        b=HP4omCtKYM3yCM+6pTHsnPFgq5ZiWYQpTZtQMLchIshMH0rh4i+2qTPlAI9HLiLTaRF08a
        gfUcC0GrU2IKNrO61r8xQ3HBi1/8koo8NL6+n0ELIkB0R2f++EUA7TvM2dQJO8/Krn1kPa
        fvVQWoG5OP/mkmr4mW2F3YV/50IIkic=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-81-WD1V4GdZNdOWdkYZPlJdzQ-1; Fri, 09 Sep 2022 08:12:39 -0400
X-MC-Unique: WD1V4GdZNdOWdkYZPlJdzQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E533D803520;
        Fri,  9 Sep 2022 12:12:38 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.39.192.103])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9D6501121314;
        Fri,  9 Sep 2022 12:12:37 +0000 (UTC)
From:   Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To:     gregory.greenman@intel.com, linux-wireless@vger.kernel.org
Cc:     Jose Ignacio Tornos Martinez <jtornosm@redhat.com>,
        Petr Stourac <pstourac@redhat.com>
Subject: [PATCH] iwlwifi: mvm: fix double list_add at iwl_mvm_mac_wake_tx_queue (other cases)
Date:   Fri,  9 Sep 2022 14:12:35 +0200
Message-Id: <20220909121235.575541-1-jtornosm@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Extend the applied solution with commit 14a3aacf517a9
("iwlwifi: mvm: fix double list_add at iwl_mvm_mac_wake_tx_queue")
to other cases where the station queues are also disabled and the related
lists are not emptied. In the same way, if some new element is added later
to the list in iwl_mvm_mac_wake_tx_queue, it can match with the old one
and produce the same commented BUG.

Again, in order to avoid this problem, we must also remove the related
lists when station queues are disabled.

Fixes: cfbc6c4c5b91c ("iwlwifi: mvm: support mac80211 TXQs model")
Reported-by: Petr Stourac <pstourac@redhat.com>
Tested-by: Petr Stourac <pstourac@redhat.com>
Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
index 2661d4e819ce..e28505a1f2c4 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/sta.c
@@ -367,6 +367,7 @@ static int iwl_mvm_disable_txq(struct iwl_mvm *mvm, struct ieee80211_sta *sta,
 			iwl_mvm_txq_from_tid(sta, tid);
 
 		mvmtxq->txq_id = IWL_MVM_INVALID_QUEUE;
+		list_del_init(&mvmtxq->list);
 	}
 
 	/* Regardless if this is a reserved TXQ for a STA - mark it as false */
@@ -461,6 +462,7 @@ static int iwl_mvm_remove_sta_queue_marking(struct iwl_mvm *mvm, int queue)
 		mvmsta->tid_data[tid].txq_id = IWL_MVM_INVALID_QUEUE;
 
 		mvmtxq->txq_id = IWL_MVM_INVALID_QUEUE;
+		list_del_init(&mvmtxq->list);
 	}
 
 	mvmsta->tfd_queue_msk &= ~BIT(queue); /* Don't use this queue anymore */
-- 
2.37.2

