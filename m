Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF2BF59746
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Jun 2019 11:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbfF1JUW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Jun 2019 05:20:22 -0400
Received: from paleale.coelho.fi ([176.9.41.70]:54688 "EHLO
        farmhouse.coelho.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726531AbfF1JUW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Jun 2019 05:20:22 -0400
Received: from 91-156-6-193.elisa-laajakaista.fi ([91.156.6.193] helo=redipa.ger.corp.intel.com)
        by farmhouse.coelho.fi with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <luca@coelho.fi>)
        id 1hgn3M-0001ny-Cz; Fri, 28 Jun 2019 12:20:20 +0300
From:   Luca Coelho <luca@coelho.fi>
To:     kvalo@codeaurora.org
Cc:     linux-wireless@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Luca Coelho <luciano.coelho@intel.com>
Subject: [PATCH 02/20] iwlwifi: d3: Use struct_size() helper
Date:   Fri, 28 Jun 2019 12:19:50 +0300
Message-Id: <20190628092008.11049-3-luca@coelho.fi>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190628092008.11049-1-luca@coelho.fi>
References: <20190628092008.11049-1-luca@coelho.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>

Make use of the struct_size() helper instead of an open-coded version
in order to avoid any potential type mistakes, in particular in the
context in which this code is being used.

So, change the following form:

sizeof(*pattern_cmd) +
               wowlan->n_patterns * sizeof(struct iwlagn_wowlan_pattern)

 to :

struct_size(pattern_cmd, patterns, wowlan->n_patterns)

This code was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
index 60f5d337f16d..363fd6127bb6 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/d3.c
@@ -398,8 +398,7 @@ static int iwl_mvm_send_patterns_v1(struct iwl_mvm *mvm,
 	if (!wowlan->n_patterns)
 		return 0;
 
-	cmd.len[0] = sizeof(*pattern_cmd) +
-		wowlan->n_patterns * sizeof(struct iwl_wowlan_pattern_v1);
+	cmd.len[0] = struct_size(pattern_cmd, patterns, wowlan->n_patterns);
 
 	pattern_cmd = kmalloc(cmd.len[0], GFP_KERNEL);
 	if (!pattern_cmd)
-- 
2.20.1

