Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 049346C7329
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Mar 2023 23:36:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbjCWWgR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Mar 2023 18:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjCWWgQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Mar 2023 18:36:16 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7308B23C4E
        for <linux-wireless@vger.kernel.org>; Thu, 23 Mar 2023 15:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679610975; x=1711146975;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2oXdXzWSKt+wAtNnaZIxsdC9BCMOg4z881auNrA9jzg=;
  b=Uq1AVvkYRX90QI6670K1FKJn0a0XQkIrOsjvnhYR5jmUuvRf8nrwDC7s
   mQLc5wlOLP6rX8nQWTRfMlxfNwrEjrbiDBJmpR84hwhJ8aF4FtKzSX3ld
   VnY62qJIk4DaOqSzLDwUV2PXhVBQFJplM1mjIGeGHX+RL8n4OHbPFQSFa
   Fx01wYj4tq3OKUH/pSCXpwmQrmIzeICD8GXTui3skAQI7JfH4McN6UGxU
   HYU+MhC76eO6Ssdjm1Ib25I0rtVK064S5e7JlfoHpog8cnfd+bkwPROBs
   R78XtMDB1o65rDm1nLQAxBen1C3zmdm3LJt+Rdv1QFrJpXJjgWf0wVMuG
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="323506037"
X-IronPort-AV: E=Sophos;i="5.98,286,1673942400"; 
   d="scan'208";a="323506037"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2023 15:36:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="751664845"
X-IronPort-AV: E=Sophos;i="5.98,286,1673942400"; 
   d="scan'208";a="751664845"
Received: from teshkol-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.249.86.22])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2023 15:36:13 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Gregory Greenman <gregory.greenman@intel.com>,
        Dan Carpenter <error27@gmail.com>
Subject: [PATCH] wifi: iwlwifi: mvm: fix NULL deref in iwl_mvm_mld_disable_txq
Date:   Fri, 24 Mar 2023 00:35:43 +0200
Message-Id: <20230323223543.1903872-1-gregory.greenman@intel.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Gregory Greenman <gregory.greenman@intel.com>

Handle NULL sta pointer.

Fixes: 006c152ac9e5 ("wifi: iwlwifi: mvm: add support for the new STA related commands")
Reported-by: Dan Carpenter <error27@gmail.com>
Link: https://lore.kernel.org/linux-wireless/20230314194113.132873ce015c.I7b12a77e5be066730762e6ceeeaa7190293c3df1@changeid/
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
index d81fc9207ef0..51532b6379e2 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-sta.c
@@ -227,10 +227,15 @@ static int iwl_mvm_mld_disable_txq(struct iwl_mvm *mvm,
 				   struct ieee80211_sta *sta,
 				   u16 *queueptr, u8 tid)
 {
-	struct iwl_mvm_sta *mvmsta = iwl_mvm_sta_from_mac80211(sta);
+	struct iwl_mvm_sta *mvmsta;
 	int queue = *queueptr;
 	int ret = 0;
 
+	if (!sta)
+		return -EINVAL;
+
+	mvmsta = iwl_mvm_sta_from_mac80211(sta);
+
 	if (mvm->sta_remove_requires_queue_remove) {
 		u32 cmd_id = WIDE_ID(DATA_PATH_GROUP,
 				     SCD_QUEUE_CONFIG_CMD);
-- 
2.38.1

