Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04E4D103774
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Nov 2019 11:27:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728659AbfKTK1C (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Nov 2019 05:27:02 -0500
Received: from paleale.coelho.fi ([176.9.41.70]:58542 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728148AbfKTK1B (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Nov 2019 05:27:01 -0500
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1iXNCN-0001kS-Ag; Wed, 20 Nov 2019 12:26:59 +0200
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org
Date:   Wed, 20 Nov 2019 12:26:43 +0200
Message-Id: <20191120102650.514376-6-luca@coelho.fi>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191120102650.514376-1-luca@coelho.fi>
References: <20191120102650.514376-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on farmhouse.coelho.fi
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        TVD_RCVD_IP,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.2
Subject: [PATCH 05/12] iwlwifi: mvm: remove left-over non-functional email alias
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

This email alias (ilw@linux.intel.com) hasn't been functional
for probably closer to a decade than not, remove it. It's not
really clear to me how this ended up in new code though.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
index 75a7af5ad7b2..ef99c49247b7 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
@@ -23,7 +23,7 @@
  * in the file called COPYING.
  *
  * Contact Information:
- *  Intel Linux Wireless <ilw@linux.intel.com>
+ *  Intel Linux Wireless <linuxwifi@intel.com>
  * Intel Corporation, 5200 N.E. Elam Young Parkway, Hillsboro, OR 97124-6497
  *
  * BSD LICENSE
-- 
2.24.0

