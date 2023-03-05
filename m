Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C3396AAF5C
	for <lists+linux-wireless@lfdr.de>; Sun,  5 Mar 2023 13:17:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbjCEMQ7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 5 Mar 2023 07:16:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjCEMQ6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 5 Mar 2023 07:16:58 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F6C7126E9
        for <linux-wireless@vger.kernel.org>; Sun,  5 Mar 2023 04:16:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678018617; x=1709554617;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FJD11OU2sCQYjJG3e1TabaJJ7LEk2lyWrpCG0qIxuqQ=;
  b=MyTGtqgUJzAszRE7+cApX2Fni7Sp+py5hxtAwT1rE587rBew1rV6MsqF
   nUvV0qMPnMBZr188o0VFfQsRyhp/Lldnxao1zXViYaR+hQqSkBtKMUft+
   0IkBAAVxYswOQW6vO+ylzqkS5KCjTEWLFQJ0Y9g95JoS63LWcG0T90C5a
   cZLgoGU6s82/W4JpvnRjqpDhPGeephpX/xorTukKABn0La/r27DAnailW
   GJIcEcYt8iRRNSHQuCGBd3g0zf1Kgnvl1CDV+1OPfVTz9p/xePAqlxBDl
   cR+KNRZkXfW5Oy0Zqv0hp6HxNZWK3wDeCSlP1jmzzhR0osNprPGpaZxlb
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10639"; a="400193154"
X-IronPort-AV: E=Sophos;i="5.98,235,1673942400"; 
   d="scan'208";a="400193154"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2023 04:16:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10639"; a="708354994"
X-IronPort-AV: E=Sophos;i="5.98,235,1673942400"; 
   d="scan'208";a="708354994"
Received: from hsaid-mobl2.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.249.80.12])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2023 04:16:55 -0800
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Mordechay Goodstein <mordechay.goodstein@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 02/21] wifi: iwlwifi: mvm: mark mac header with no data frames
Date:   Sun,  5 Mar 2023 14:16:16 +0200
Message-Id: <20230305124406.8f53cc8579bf.I8819c005b4953cea03346d0aff82b31d94f79fe5@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230305121635.301451-1-gregory.greenman@intel.com>
References: <20230305121635.301451-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Mordechay Goodstein <mordechay.goodstein@intel.com>

Although no data is presented in the skb, but upper layers need it for
calculating where radio tap header are done, so we mark it.

Signed-off-by: Mordechay Goodstein <mordechay.goodstein@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
index 3d7717fdb4d5..ba9f79ada82f 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
@@ -2147,11 +2147,8 @@ void iwl_mvm_rx_monitor_no_data(struct iwl_mvm *mvm, struct napi_struct *napi,
 	 *
 	 * We mark it as mac header, for upper layers to know where
 	 * all radio tap header ends.
-	 *
-	 * Since data doesn't move data while putting data on skb and that is
-	 * the only way we use, data + len is the next place that hdr would be put
 	 */
-	skb_set_mac_header(skb, skb->len);
+	skb_reset_mac_header(skb);
 
 	/*
 	 * Override the nss from the rx_vec since the rate_n_flags has
-- 
2.38.1

