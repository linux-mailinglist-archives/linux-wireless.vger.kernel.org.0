Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6104B72E380
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jun 2023 14:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242016AbjFMM6K (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 13 Jun 2023 08:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242266AbjFMM6G (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 13 Jun 2023 08:58:06 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FBFD199B
        for <linux-wireless@vger.kernel.org>; Tue, 13 Jun 2023 05:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686661077; x=1718197077;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5c0zJYZ+WxeMHBNLi4O0FSs0w2PZ9cQ5o9MIJxCmnIU=;
  b=XhJuEbo1ZV3eCpKqgFGMlX+SMWUI2kR918AZqrm/qRYc4efY51wO7ZHN
   Z1wXJXljjqjDbmGmBhVgozoLAow7hjzxv1nhuf3iVMeLIgYcFjTQzz72a
   aGcWOzWfBZ7a8TBv3QEASiIR6QOMsR55ppfyXMfSe1Jog0P3v+UcV2Tok
   i/l3xSbF5bjKYTUdk+pW1u7L3yZhRPG4xwkE6IjokvcCOpqUd28ntpP+S
   SZkDuMNfJYa9T542SijfzNQwDEXxe5SCQByjfWeKkMo5Jik+jLL/zrgVO
   uIndrXy/NHiHdlDyEbL71Mj/ngz/j4/VHqwDshDywjJ9rzNnXERsw4JcA
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="347973747"
X-IronPort-AV: E=Sophos;i="6.00,239,1681196400"; 
   d="scan'208";a="347973747"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 05:57:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="835880809"
X-IronPort-AV: E=Sophos;i="6.00,239,1681196400"; 
   d="scan'208";a="835880809"
Received: from slerer-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.249.90.17])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 05:57:55 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 08/14] wifi: iwlwifi: mvm: fix potential array out of bounds access
Date:   Tue, 13 Jun 2023 15:57:21 +0300
Message-Id: <20230613155501.f193b7493a93.I6948ba625b9318924b96a5e22602ac75d2bd0125@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230613125727.300445-1-gregory.greenman@intel.com>
References: <20230613125727.300445-1-gregory.greenman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Gregory Greenman <gregory.greenman@intel.com>

Account for IWL_SEC_WEP_KEY_OFFSET when needed while verifying
key_len size in iwl_mvm_sec_key_add().

Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c
index 3e6f86f644b5..995c0e01b331 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2022 Intel Corporation
+ * Copyright (C) 2022 - 2023 Intel Corporation
  */
 #include <linux/kernel.h>
 #include <net/mac80211.h>
@@ -175,9 +175,14 @@ int iwl_mvm_mld_send_key(struct iwl_mvm *mvm, u32 sta_mask, u32 key_flags,
 		.u.add.key_flags = cpu_to_le32(key_flags),
 		.u.add.tx_seq = cpu_to_le64(atomic64_read(&keyconf->tx_pn)),
 	};
+	int max_key_len = sizeof(cmd.u.add.key);
 	int ret;
 
-	if (WARN_ON(keyconf->keylen > sizeof(cmd.u.add.key)))
+	if (keyconf->cipher == WLAN_CIPHER_SUITE_WEP40 ||
+	    keyconf->cipher == WLAN_CIPHER_SUITE_WEP104)
+		max_key_len -= IWL_SEC_WEP_KEY_OFFSET;
+
+	if (WARN_ON(keyconf->keylen > max_key_len))
 		return -EINVAL;
 
 	if (WARN_ON(!sta_mask))
-- 
2.38.1

