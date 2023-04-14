Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48A956E2085
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Apr 2023 12:15:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbjDNKP5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Apr 2023 06:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbjDNKPz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Apr 2023 06:15:55 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1799A2107
        for <linux-wireless@vger.kernel.org>; Fri, 14 Apr 2023 03:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681467346; x=1713003346;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TET7QFqLFEl8L4EgJteqE2HSDpxkWFXQNsZZ9jYFTbw=;
  b=Ee+aI9MeVL4bAC6+Ff8vJJKX59u1svaAYCBp+4esKJcBPHKwXYufi7/k
   3YhjaqVNvnyRAGZyZk3ApzmiD8wOEW4W4OUTS9SKWsx1KlNy9uGxujCUR
   PEGb/1q2QmBTHWCxwZMIhuS/j9rYrPrwWhIzsx1N7fMHPAKIwPr/aqGLz
   n8wfOgoqPW88IhPGDL6PQHG93nOrXITleFQ84sVPAMbQxHtgFxQaEPJkP
   mQcLve+JxTyjpPCbHbnJE+wFBg/3pisJWzTXYWsYQCbJcE7F1hKGcpfgA
   ViBQFjTQEP1kbNvb/XywdnhuMDspWALd8N92vtNuaLwxz2BFXQ2Kte/ul
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="346263703"
X-IronPort-AV: E=Sophos;i="5.99,195,1677571200"; 
   d="scan'208";a="346263703"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2023 03:12:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="692351846"
X-IronPort-AV: E=Sophos;i="5.99,195,1677571200"; 
   d="scan'208";a="692351846"
Received: from yalankry-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.233.156])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2023 03:12:48 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 15/15] wifi: iwlwifi: mvm: tx: remove misleading if statement
Date:   Fri, 14 Apr 2023 13:12:06 +0300
Message-Id: <20230414130637.57c1eb58e655.I1b47a7771cd66306931089c150c6b5b240bdcba5@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230414101206.1170180-1-gregory.greenman@intel.com>
References: <20230414101206.1170180-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

The if statement here is misleading, we return zero anyway
since we just checked the 'ret' variable, simplify the code
to remove the condition entirely.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
index ab448ff6a740..66b5e8700983 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
@@ -1255,8 +1255,7 @@ int iwl_mvm_tx_skb_sta(struct iwl_mvm *mvm, struct sk_buff *skb,
 	if (ret)
 		return ret;
 
-	if (WARN_ON(skb_queue_empty(&mpdus_skbs)))
-		return ret;
+	WARN_ON(skb_queue_empty(&mpdus_skbs));
 
 	while (!skb_queue_empty(&mpdus_skbs)) {
 		skb = __skb_dequeue(&mpdus_skbs);
-- 
2.38.1

