Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB2A978D9C2
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Aug 2023 20:35:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237276AbjH3SeD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 30 Aug 2023 14:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242436AbjH3Ibl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 30 Aug 2023 04:31:41 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B407F1A6
        for <linux-wireless@vger.kernel.org>; Wed, 30 Aug 2023 01:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693384296; x=1724920296;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=swH4q6J3iThlwS10o9OYLdf01fl2wARs9eQ9LBJrR9A=;
  b=VO3p4WJzAynZrAuX3S012BJ6hoZyHgOXvGNfjTnTD7RMQPZ6kJEbIkY3
   Elc4kPVSHFh5CQyh0wDigo8VpjUI+2kDrKQ/zbADVds+v8m+n9HhreSFO
   67DHH+7Z/3WSu7dTz+/n8Z2Ir/0v8zW70lEKEqfC4/QUqasko3aQ5TvPj
   BOqiGkvogqsMFlFJbXaxgAXCyYT/Dsxohx8GPci0MZUOvnuwz9FosRXp2
   yaCu4ZFXGrHeDD+MNlfmmEBTSeMIEELkLfDEZnBqC2HB11TWu4oOdUh6b
   lCKpeR2PBfcgpZMrk059kIOJoNn7rURg+M7+3HISeipuDppe9E7eIOyel
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="461958933"
X-IronPort-AV: E=Sophos;i="6.02,213,1688454000"; 
   d="scan'208";a="461958933"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 01:31:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="829152141"
X-IronPort-AV: E=Sophos;i="6.02,213,1688454000"; 
   d="scan'208";a="829152141"
Received: from oweil1-mobl3.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.214.210.69])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 01:31:34 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 07/16] wifi: iwlwifi: queue: fix kernel-doc
Date:   Wed, 30 Aug 2023 11:30:55 +0300
Message-Id: <20230830112059.247919faf4fd.I489f8b3b2ebb49a421bd5d76ea0201262134fb67@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230830083104.546619-1-gregory.greenman@intel.com>
References: <20230830083104.546619-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

Fix the kernel-doc annotations here, adding the trans
parameter and fixing the syntax.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/queue/tx.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/queue/tx.h b/drivers/net/wireless/intel/iwlwifi/queue/tx.h
index b7d3808588bf..52aa885af49b 100644
--- a/drivers/net/wireless/intel/iwlwifi/queue/tx.h
+++ b/drivers/net/wireless/intel/iwlwifi/queue/tx.h
@@ -71,7 +71,8 @@ static inline void iwl_txq_stop(struct iwl_trans *trans, struct iwl_txq *txq)
 
 /**
  * iwl_txq_inc_wrap - increment queue index, wrap back to beginning
- * @index -- current index
+ * @trans: the transport (for configuration data)
+ * @index: current index
  */
 static inline int iwl_txq_inc_wrap(struct iwl_trans *trans, int index)
 {
@@ -81,7 +82,8 @@ static inline int iwl_txq_inc_wrap(struct iwl_trans *trans, int index)
 
 /**
  * iwl_txq_dec_wrap - decrement queue index, wrap back to end
- * @index -- current index
+ * @trans: the transport (for configuration data)
+ * @index: current index
  */
 static inline int iwl_txq_dec_wrap(struct iwl_trans *trans, int index)
 {
-- 
2.38.1

