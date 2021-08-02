Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95BE23DDAFE
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Aug 2021 16:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234132AbhHBO2q (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 Aug 2021 10:28:46 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:50924 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S233959AbhHBO2q (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 Aug 2021 10:28:46 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=kveik.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94)
        (envelope-from <luca@coelho.fi>)
        id 1mAYvh-001xts-Ml; Mon, 02 Aug 2021 17:28:35 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     luca@coelho.fi, linux-wireless@vger.kernel.org
Date:   Mon,  2 Aug 2021 17:28:21 +0300
Message-Id: <iwlwifi.20210802172232.0ef8aedd4f9b.If527b9ae5bf8de8c6877d4b6a21ed8d81b0f877e@changeid>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210802142829.109448-1-luca@coelho.fi>
References: <20210802142829.109448-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.5-pre1 (2020-06-20) on
        farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP autolearn=ham autolearn_force=no version=3.4.5-pre1
Subject: [PATCH 04/12] iwlwifi: pcie: remove spaces from queue names
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Luca Coelho <luciano.coelho@intel.com>

If we use spaces in the queue names, we get files with spaces in their
name in procfs, which is ugly.  Remove the spaces.

Reported-by: Joe Perches <joe@perches.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/pcie/internal.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
index 6c3b0403b68f..a43e56c7689f 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/internal.h
@@ -678,19 +678,19 @@ static inline const char *queue_name(struct device *dev,
 			  IWL_SHARED_IRQ_FIRST_RSS ? 1 : 0;
 
 		if (i == 0)
-			return DRV_NAME ": shared IRQ";
+			return DRV_NAME ":shared_IRQ";
 
 		return devm_kasprintf(dev, GFP_KERNEL,
-				      DRV_NAME ": queue %d", i + vec);
+				      DRV_NAME ":queue_%d", i + vec);
 	}
 	if (i == 0)
-		return DRV_NAME ": default queue";
+		return DRV_NAME ":default_queue";
 
 	if (i == trans_p->alloc_vecs - 1)
-		return DRV_NAME ": exception";
+		return DRV_NAME ":exception";
 
 	return devm_kasprintf(dev, GFP_KERNEL,
-			      DRV_NAME  ": queue %d", i);
+			      DRV_NAME  ":queue_%d", i);
 }
 
 static inline void iwl_enable_rfkill_int(struct iwl_trans *trans)
-- 
2.32.0

