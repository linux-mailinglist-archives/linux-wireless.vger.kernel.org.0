Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93CF7717AB8
	for <lists+linux-wireless@lfdr.de>; Wed, 31 May 2023 10:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234834AbjEaIvl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 31 May 2023 04:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235250AbjEaIuy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 31 May 2023 04:50:54 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2CA21BD
        for <linux-wireless@vger.kernel.org>; Wed, 31 May 2023 01:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685523052; x=1717059052;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vWdM2+NCYgFVq1uDxsl6B+Zff7acYFH8PTB4NEF/2AY=;
  b=e62c5Cgs97d6kLwOFjCaA31b9JHDYWfKbQOR13Y5CbY7u+cFN+qdKc/q
   nLof0SxJoHSD0/T1wen8jSUUHCdH2Tjp4YLr0QABzNsptDAG4ERyQLOBa
   mccI/NmvVg1tIxElcJJ9uWXMUmJ/Vv9kzsUgDr9fh6MRyvYI/+DPHS51v
   zR+c6E7C7nuJ49VHmrHGRwZw16NsKUgHaRpZD7MnJ8S0fFqxC4ZsdwWh3
   tJEC0STtWXwljvHol07Kj4rg9qysyF/5yLLHZAmyfFt6GpSQJQRp4uR4Z
   hTG1+c1S6JDKSEsK4ecZcZ2JMDWc930+yW+GNcNjRqHa08waCERh2a+rM
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="354023944"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; 
   d="scan'208";a="354023944"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2023 01:50:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="701027059"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; 
   d="scan'208";a="701027059"
Received: from amilman1-mobl1.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.215.102])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2023 01:50:50 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Avraham Stern <avraham.stern@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH wireless] wifi: iwlwifi: iwlmei: fix compilation error
Date:   Wed, 31 May 2023 11:50:33 +0300
Message-Id: <20230531085033.216028-1-gregory.greenman@intel.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Avraham Stern <avraham.stern@intel.com>

The feature is still disabled (depends on BROKEN), but
the code had a compilation error after one of the merges.
Fix that.

Signed-off-by: Avraham Stern <avraham.stern@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mei/main.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mei/main.c b/drivers/net/wireless/intel/iwlwifi/mei/main.c
index 0a29fb013005..54445f39fd55 100644
--- a/drivers/net/wireless/intel/iwlwifi/mei/main.c
+++ b/drivers/net/wireless/intel/iwlwifi/mei/main.c
@@ -1791,9 +1791,8 @@ int iwl_mei_register(void *priv, const struct iwl_mei_ops *ops)
 		if (iwl_mei_is_connected()) {
 			if (mei->amt_enabled)
 				iwl_mei_send_sap_msg(mei->cldev,
-						     SAP_MSG_NOTIF_WIFIDR_UP,
-						     false);
-			ops->rfkill(priv, mei->link_prot_state);
+						     SAP_MSG_NOTIF_WIFIDR_UP);
+			ops->rfkill(priv, mei->link_prot_state, false);
 		}
 	}
 	ret = 0;
-- 
2.38.1

