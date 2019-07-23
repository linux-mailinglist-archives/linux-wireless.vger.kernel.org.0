Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93AD371A90
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jul 2019 16:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390642AbfGWOiM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 23 Jul 2019 10:38:12 -0400
Received: from s3.sipsolutions.net ([144.76.43.62]:56506 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730299AbfGWOiL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 23 Jul 2019 10:38:11 -0400
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <johannes@sipsolutions.net>)
        id 1hpvve-0007sr-5B; Tue, 23 Jul 2019 16:38:10 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Subject: [PATCH 2/3] iwlwifi: mvm: fix an out-of-bound access
Date:   Tue, 23 Jul 2019 16:38:02 +0200
Message-Id: <20190723143803.8698-3-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190723143803.8698-1-johannes@sipsolutions.net>
References: <20190723143803.8698-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

The index for the elements of the ACPI object we dereference
was static. This means that if we called the function twice
we wouldn't start from 3 again, but rather from the latest
index we reached in the previous call.
This was dutifully reported by KASAN.

Fix this.

Cc: stable@vger.kernel.org
Fixes: 6996490501ed ("iwlwifi: mvm: add support for EWRD (Dynamic SAR) ACPI table")
Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 00c89bcfdf6a..5de54d1559dd 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -755,7 +755,7 @@ static int iwl_mvm_sar_get_ewrd_table(struct iwl_mvm *mvm)
 
 	for (i = 0; i < n_profiles; i++) {
 		/* the tables start at element 3 */
-		static int pos = 3;
+		int pos = 3;
 
 		/* The EWRD profiles officially go from 2 to 4, but we
 		 * save them in sar_profiles[1-3] (because we don't
-- 
2.20.1

