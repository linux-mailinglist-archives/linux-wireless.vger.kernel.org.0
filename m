Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA55772F9A2
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jun 2023 11:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244247AbjFNJps (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 14 Jun 2023 05:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244330AbjFNJow (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 14 Jun 2023 05:44:52 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EA322102
        for <linux-wireless@vger.kernel.org>; Wed, 14 Jun 2023 02:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686735839; x=1718271839;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QAwYQKWF2HjpFh5e3CWrraoI9sISzIU5JismLwvJGCQ=;
  b=LXdYx+wiZ9xEmZp+eD9UDeB6X+c9BAuEj3W3GlL2asrGP0NHpgvcasUw
   bTi1ba0Vooz1UvAM19Xe+jyaUKjQPBkPu047O+L5HcmZCtavVeeMpLr43
   0ixMdZ4W6NKBKLv+ODsJo8IDLE0yRm7kXMZrsCGt2gE+mjvuO1kFoksU4
   y6Ym2MZi6uUoZxCsuByDANIXXg3e2zjS7NBjNBFrJ9y/doFyGo0Q5YTLR
   k5D2alpjxE36vvYQz7CeZCHP7N9nqs6aMY4bLvutJKD1ob/XM+4rjciyZ
   AgBhaV4g/LY2QYBTW+VE79QgbOu+uP58VoWg/YyjB3ICZQNNMNbNpC/DH
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="361049928"
X-IronPort-AV: E=Sophos;i="6.00,242,1681196400"; 
   d="scan'208";a="361049928"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 02:42:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="711989920"
X-IronPort-AV: E=Sophos;i="6.00,242,1681196400"; 
   d="scan'208";a="711989920"
Received: from basharil-mobl.ger.corp.intel.com (HELO ggreenma-mobl2.lan) ([10.214.203.45])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 02:42:36 -0700
From:   gregory.greenman@intel.com
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 19/20] wifi: iwlwifi: Validate slots_num before allocating memory
Date:   Wed, 14 Jun 2023 12:41:36 +0300
Message-Id: <20230614123447.90be48017c1b.I880e451e137c5cd688d5f38b573b0dbf352762b3@changeid>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230614094137.379897-1-gregory.greenman@intel.com>
References: <20230614094137.379897-1-gregory.greenman@intel.com>
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

From: Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>

Verify slots_num is valid in iwl_txq_alloc()

Signed-off-by: Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/queue/tx.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/queue/tx.c b/drivers/net/wireless/intel/iwlwifi/queue/tx.c
index d1c39c214f95..245bff01b4f8 100644
--- a/drivers/net/wireless/intel/iwlwifi/queue/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/queue/tx.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2020-2022 Intel Corporation
+ * Copyright (C) 2020-2023 Intel Corporation
  */
 #include <net/tso.h>
 #include <linux/tcp.h>
@@ -1027,6 +1027,9 @@ int iwl_txq_alloc(struct iwl_trans *trans, struct iwl_txq *txq, int slots_num,
 	size_t tb0_buf_sz;
 	int i;
 
+	if (WARN_ONCE(slots_num <= 0, "Invalid slots num:%d\n", slots_num))
+		return -EINVAL;
+
 	if (WARN_ON(txq->entries || txq->tfds))
 		return -EINVAL;
 
-- 
2.38.1

