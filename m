Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3435E6E0802
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Apr 2023 09:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbjDMHpS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Apr 2023 03:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbjDMHpQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Apr 2023 03:45:16 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A7FA5FC6
        for <linux-wireless@vger.kernel.org>; Thu, 13 Apr 2023 00:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681371916; x=1712907916;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rvrQg5jEmDflez/fZ7Mje3WWcogGs86bETNKNAtrd/U=;
  b=Lb5rsubygwzTS/SH1HSlx2vzV0VQDq7kReGijdkBj4me63nthopgQ7G/
   HsGpt4pnHvIcuiBzMk7mUbJ9dgkOHUZ+Ghm1DDMa9CtK3w/49wmwkpGmN
   2XQpl9wlxcF6URtrnqDIO3DhMfusT0nRNYcqHd0Quqs/AwKFepZpRJfva
   F/6UxjO1/RCqFhNvELiB0zJYVx/B9tEWahiXcHtG7zh7y/3cjGAQbTZRa
   8i78s6aaRcnPQJ0j2c74CvxU+5HXNltcY+iw77LX4CrPGtMYBUYsgpYnM
   ngZMaRxfWXFtoeB7YCI4FstIepxvXlr4m/QYKeyihh+D8A2wYHz+7Kf1O
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="323735940"
X-IronPort-AV: E=Sophos;i="5.98,341,1673942400"; 
   d="scan'208";a="323735940"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2023 00:45:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="833034701"
X-IronPort-AV: E=Sophos;i="5.98,341,1673942400"; 
   d="scan'208";a="833034701"
Received: from apeled2-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.251.184.75])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2023 00:45:14 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Miri Korenblit <miriam.rachel.korenblit@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 03/15] wifi: iwlwifi: add a validity check of queue_id in iwl_txq_reclaim
Date:   Thu, 13 Apr 2023 10:44:03 +0300
Message-Id: <20230413102635.a9c3fd32bce7.I5fbdcf3b1b80eb96a907116c166f19dc0aae7cb8@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230413074415.1054160-1-gregory.greenman@intel.com>
References: <20230413074415.1054160-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Miri Korenblit <miriam.rachel.korenblit@intel.com>

This function receives the queue id to reclaim packets from. Currently
we're passing to it the queue id we received from the FW in the flush
response. We don't do any check of this value and it might be invalid.
In such case we will refer to a pointer to a queue which might be NULL.
Fix this by adding a validity check of the queue id before using it.

Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/queue/tx.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/queue/tx.c b/drivers/net/wireless/intel/iwlwifi/queue/tx.c
index 726185d6fab8..d1c39c214f95 100644
--- a/drivers/net/wireless/intel/iwlwifi/queue/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/queue/tx.c
@@ -1554,14 +1554,18 @@ void iwl_txq_reclaim(struct iwl_trans *trans, int txq_id, int ssn,
 		     struct sk_buff_head *skbs)
 {
 	struct iwl_txq *txq = trans->txqs.txq[txq_id];
-	int tfd_num = iwl_txq_get_cmd_index(txq, ssn);
-	int read_ptr = iwl_txq_get_cmd_index(txq, txq->read_ptr);
-	int last_to_free;
+	int tfd_num, read_ptr, last_to_free;
 
 	/* This function is not meant to release cmd queue*/
 	if (WARN_ON(txq_id == trans->txqs.cmd.q_id))
 		return;
 
+	if (WARN_ON(!txq))
+		return;
+
+	tfd_num = iwl_txq_get_cmd_index(txq, ssn);
+	read_ptr = iwl_txq_get_cmd_index(txq, txq->read_ptr);
+
 	spin_lock_bh(&txq->lock);
 
 	if (!test_bit(txq_id, trans->txqs.queue_used)) {
-- 
2.38.1

