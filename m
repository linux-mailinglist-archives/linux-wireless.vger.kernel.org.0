Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6D9F612BC8
	for <lists+linux-wireless@lfdr.de>; Sun, 30 Oct 2022 18:18:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbiJ3RSj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 30 Oct 2022 13:18:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbiJ3RSh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 30 Oct 2022 13:18:37 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47B6AFD0
        for <linux-wireless@vger.kernel.org>; Sun, 30 Oct 2022 10:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667150316; x=1698686316;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=s9kPyQORdiFz0dvlLLjmZpaqS4pBNYScbXB4DL+zgtc=;
  b=a1r53nF+1z7jnYe0oiGncQ/FOpcFgf+QsrDp1M8IBUamupaL2P56qMV5
   boATqEp9r0pqnGBw6IdDhpUQiDrqHGy0UVJ37/tF/mSH7Ll+su+NfucGg
   uW8NTPVTbNBqTp054ZASKTsmflszOCUb5l01F0ksTDX7hcXT8oTo/3XN/
   33xj6Lt9HUMM2pRma6txQD6M+Ev1l70Mv2H0PtHWvkSF/q1sQ7rzyz3Em
   wNRNpjBNWq/qho5spQOM6S/PxTmjx3ddv4QDfXk9ao9658MjhF1GvEl9E
   TMrsqxeKhqpRHe8Xb7mogeTLB/4/B5t+Fg+n6b3U2ngfOwEv3p5R4spkc
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10516"; a="372973247"
X-IronPort-AV: E=Sophos;i="5.95,226,1661842800"; 
   d="scan'208";a="372973247"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2022 10:18:36 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10516"; a="633290273"
X-IronPort-AV: E=Sophos;i="5.95,226,1661842800"; 
   d="scan'208";a="633290273"
Received: from gustyuzh-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.intel.com) ([10.249.83.75])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2022 10:18:34 -0700
From:   gregory.greenman@intel.com
To:     kvalo@kernel.org, johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 6/6] wifi: iwlwifi: mei: fix potential NULL-ptr deref after clone
Date:   Sun, 30 Oct 2022 19:17:45 +0200
Message-Id: <20221030191011.0ce03ba99601.I87960b7cb0a3d16b9fd8d9144027e7e2587f5a58@changeid>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221030171745.132081-1-gregory.greenman@intel.com>
References: <20221030171745.132081-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

If cloning the SKB fails, don't try to use it, but rather return
as if we should pass it.

Coverity CID: 1503456

Fixes: 2da4366f9e2c ("iwlwifi: mei: add the driver to allow cooperation with CSME")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mei/net.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mei/net.c b/drivers/net/wireless/intel/iwlwifi/mei/net.c
index 3472167c8370..eac46d1a397a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mei/net.c
+++ b/drivers/net/wireless/intel/iwlwifi/mei/net.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Copyright (C) 2021 Intel Corporation
+ * Copyright (C) 2021-2022 Intel Corporation
  */
 
 #include <uapi/linux/if_ether.h>
@@ -337,10 +337,14 @@ rx_handler_result_t iwl_mei_rx_filter(struct sk_buff *orig_skb,
 	if (!*pass_to_csme)
 		return RX_HANDLER_PASS;
 
-	if (ret == RX_HANDLER_PASS)
+	if (ret == RX_HANDLER_PASS) {
 		skb = skb_copy(orig_skb, GFP_ATOMIC);
-	else
+
+		if (!skb)
+			return RX_HANDLER_PASS;
+	} else {
 		skb = orig_skb;
+	}
 
 	/* CSME wants the MAC header as well, push it back */
 	skb_push(skb, skb->data - skb_mac_header(skb));
-- 
2.35.3

